# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (16)
- [GRID-SQL] Campo 'Campo2is' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Campo2fs' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'dfators' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Campo3is' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Campo3fs' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Campo1is' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Campo1fs' usado em ControlSource de cursor_4c_Tds mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contas' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'pintegrals' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'pdivididas' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'patendes' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'moedas' usado em ControlSource de cursor_4c_Tdi mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ORDEM, DFATORS, ICLIS, TIPOS, CODTIPS, GRUPOS, CONTAS, MOEDAS, NDIAS, LNTIPOD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TIPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ORDEM, DFATORS, ICLIS, TIPOS, CODTIPS, GRUPOS, CONTAS, MOEDAS, NDIAS, LNTIPOD
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CAMPO3IS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, ORDEM, DFATORS, ICLIS, TIPOS, CODTIPS, GRUPOS, CONTAS, MOEDAS, NDIAS, LNTIPOD

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
  ControlSource = "crSigOpTdz.obss"
  ControlSource = "crSigOpTdz.moefats"
  ControlSource = "crSigOpTdz.nParc2s"
  ControlSource = "crSigOpTdz.Fators"
  ControlSource = "crSigOpTdz.Ajustes"
  ControlSource = "crSigOpTdz.nParcs"
  ControlSource = "crSigOpTdz.descos"
  ControlSource = ""
  ControlSource = "crSigOpTdz.moerefs"
  ControlSource = "crSigOpTdz.descrs"
  ControlSource = "crSigOpTdz.codigos"
  ControlSource = "crSigOpTdz.dtterms"
  ControlSource = "crSigOpTdz.PrazoMs"
  ControlSource = "crSigOpTdz.rel_descs"
  ControlSource = "crSigOpTdz.ChkActb"
  ControlSource = "crSigOpTdz.ChkRets"
  ControlSource = "crSigOpTdz.AbateCus"
  ControlSource = "crSigOpTdz.AgruComs"
  ControlSource = "crSigOpTdz.tpdesc"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigOpTdt.campo1t2s"
  ControlSource = "crSigOpTdt.oper1t2s"
  ControlSource = "crSigOpTdt.moeda2s"
  ControlSource = "crSigOpTdt.campo2t2s"
  ControlSource = "crSigOpTdt.oper2t2s"
  ControlSource = "crSigOpTdt.campo3t2s"
  ControlSource = "crSigOpTdt.const1t2s"
  ControlSource = "crSigOpTdt.const2t2s"
  ControlSource = "crSigOpTdt.const3t2s"
  ControlSource = "crSigOpTdz.descmxs"
  ControlSource = "crSigOpTdt.campo1t1s"
  ControlSource = "crSigOpTdt.oper1t1s"
  ControlSource = "crSigOpTdt.moeda1s"
  ControlSource = "crSigOpTdt.campo2t1s"
  ControlSource = "crSigOpTdt.oper2t1s"
  ControlSource = "crSigOpTdt.campo3t1s"
  ControlSource = "crSigOpTdt.const1t1s"
  ControlSource = "crSigOpTdt.const2t1s"
  ControlSource = "crSigOpTdt.const3t1s"
  ControlSource = "crSigOpTdt.TpComis"
  ControlSource = "crSigOpTdt.DescFats"
  ControlSource = "crSigOpTdt.FatorPads"
  ControlSource = "crSigOpTdt.ChkCots"
Select CrSigOpTdt
	.Column1.ControlSource = 'CrSigOpTdt.tipos'
	.Column2.ControlSource = 'CrSigOpTdt.codtips'
	.Column3.ControlSource = 'CrSigOpTdt.descos'
	.Column4.ControlSource = 'CrSigOpTdt.dfators'
	.Column5.ControlSource = 'CrSigOpTdt.Texclus'
	.Column6.ControlSource = 'CrSigOpTdt.Faixas'	
	.Column7.ControlSource = 'CrSigOpTdt.FInicias'
	.Column8.ControlSource = 'CrSigOpTdt.FFinals'
	.Column1.ControlSource = 'CrSigOpTdt.tipos'
	.Column2.ControlSource = 'CrSigOpTdt.codtips'
	.Column3.ControlSource = 'CrSigOpTdt.tipoDs'
Select CrSigOpTdi
	.Column1.ControlSource = 'CrSigOpTdi.grupos'
	.Column2.ControlSource = 'CrSigOpTdi.contas'
	.Column3.ControlSource = 'CrSigOpTdi.pintegrals'
	.Column4.ControlSource = 'CrSigOpTdi.pdivididas'
	.Column5.ControlSource = 'CrSigOpTdi.patendes'
	.Column6.ControlSource = 'CrSigOpTdi.moedas'
Select CrSigOpTds
	Select CrSigOpTdz
	Insert Into CrSigOpTdb From Memvar
	Select CrSigOpTdt
		Insert Into CrSigOpTda From MemVar
	Select CrSigOpTdi
		Insert Into CrSigOpTdc From MemVar
	Select CrSigOpTds
		Insert Into CrSigOpTdd From MemVar
Select CrSigOpTdi
Select CrSigOpTds
		.Column1.ControlSource = 'CrSigOpTds.Campo1is'
			.Column1.ControlSource = 'CrSigOpTds.Campo3is'
		.Column2.ControlSource = 'CrSigOpTds.Campo1fs'
			.Column2.ControlSource = 'CrSigOpTds.Campo3fs'
	.Column3.ControlSource = 'CrSigOpTds.Campo2is'
	.Column4.ControlSource = 'CrSigOpTds.Campo2fs'
	.Column5.ControlSource = 'CrSigOpTds.descos'
	.Column6.ControlSource = 'CrSigOpTds.dfators'
Select CrSigOpTds
lcQryTabDi = [Select 0 As regs,a.* From SigOpTdt a Where a.codigos = ?lcCodigos Order by a.codigos,a.tipos,a.codtips ]
lcQryTbCom = [Select * From SigOpTdi Where codigos = ?lcCodigos ]
lcQryTbDes = [Select * From SigOpTds Where codigos = ?lcCodigos ]
If ThisForm.poDataMgr.SqlExecute([Select cmoes,dmoes From SigCdMoe ],'CrSigCdMoe') < 1
Select CrSigCdMoe
Select CrSigOpTdi
Select CrSigOpTdz
Insert Into DiaSemana (nDias,Descrs) values (1,'DOMINGO')
Insert Into DiaSemana (nDias,Descrs) values (2,'SEGUNDA')
Insert Into DiaSemana (nDias,Descrs) values (3,'TERCA  ')
Insert Into DiaSemana (nDias,Descrs) values (4,'QUARTA ')
Insert Into DiaSemana (nDias,Descrs) values (5,'QUINTA ')
Insert Into DiaSemana (nDias,Descrs) values (6,'SEXTA  ')
Insert Into DiaSemana (nDias,Descrs) values (7,'SABADO ')
Insert Into crTpDesc (Descrs, ordem) values ('1-Aniversario',01)
Insert Into crTpDesc (Descrs, ordem) values ('2-Desconto Vendedor',02)
Insert Into crTpDesc (Descrs, ordem) values ('3-Desconto Gerente-Grupo',03)
Insert Into crTpDesc (Descrs, ordem) values ('4-Desconto Gerente-Lancamento',04)
Insert Into crTpDesc (Descrs, ordem) values ('5-Desconto Gerente-qq peça',05)
Insert Into crTpDesc (Descrs, ordem) values ('6-Troca Zerada',06)
Insert Into crTpDesc (Descrs, ordem) values ('7-Troca Upgrade',07)
Insert Into crTpDesc (Descrs, ordem) values ('8-Desconto Supervisor',08)
Insert Into crTpDesc (Descrs, ordem) values ('9-Desconto Diretoria',09)
Insert Into crTpDesc (Descrs, ordem) values ('10-Troca Up Alianca',10)
Insert Into crTpDesc (Descrs, ordem) values ('11-Desconto Gerente-Extra/loja',11)
Insert Into crTpDesc (Descrs, ordem) values ('12-Desconto Gerente-Brinde',12)
Insert Into crTpDesc (Descrs, ordem) values ('13-Desconto Gerente-Troca de preço',13)
Insert Into crTpDesc (Descrs, ordem) values (SPACE(40),0)
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select 0 As nMarca, cemps ]+;
	   [From SigcdEmp ],'CrSigcdEmp')
Select CrSigcdEmp
	.Column1.ControlSource = 'CrSigcdemp.nMarca'
	.Column3.ControlSource = 'CrSigcdemp.cemps'
Select CrSigOpTdz
ThisForm.poDataMgr.Update('CrSigOpTdt')
ThisForm.poDataMgr.Update('CrSigOpTdi')
ThisForm.poDataMgr.Update('CrSigOpTds')
ThisForm.poDataMgr.Update('CrSigOpTdb')
ThisForm.poDataMgr.Update('CrSigOpTda')
ThisForm.poDataMgr.Update('CrSigOpTdd')
ThisForm.poDataMgr.Update('CrSigOpTdc')
ThisForm.poDataMgr.Update('CrSigOpTdt')
ThisForm.poDataMgr.Update('CrSigOpTdi')
ThisForm.poDataMgr.Update('CrSigOpTds')
ThisForm.poDataMgr.Update('CrSigOpTdt')
ThisForm.poDataMgr.Update('CrSigOpTdi')
ThisForm.poDataMgr.Update('CrSigOpTds')
ThisForm.poDataMgr.Update('CrSigOpTdb')
ThisForm.poDataMgr.Update('CrSigOpTda')
ThisForm.poDataMgr.Update('CrSigOpTdd')
ThisForm.poDataMgr.Update('CrSigOpTdc')
Select CrSigOpTda
Select CrSigOpTdc
Select CrSigOpTdd
Select CrSigOpTdb
			If Seek(CrSigOpTdz.moerefs,'CrSigCdMoe','CMoes')
			SELECT crSigCdemp
SELECT crTpDesc
Select CrSigOpTds
		Select crSigOpTdt
		SELECT crSigCdemp
		Update CrSigOpTdt Set cidchaves = Iif(Empty(cidchaves),fUniqueIds(),cidchaves)
		Update CrSigOpTdi Set cidchaves = Iif(Empty(cidchaves),fUniqueIds(),cidchaves)
		Update CrSigOpTdi Set Codigos   = CrSigOpTdz.Codigos
		Update CrSigOpTds Set cidchaves = Iif(Empty(cidchaves),fUniqueIds(),cidchaves)
		Delete From CrSigOpTdt Where Empty(tipos)
		Delete From CrSigOpTds Where Left(Campo1Is,2) = '  ' or ( descos = 0 And dFators = 0 )
		Select CrSigOpTds
		Update CrSigOpTdz Set nChvTbds = _nChv
		Delete From CrSigOpTdt
		Delete From CrSigOpTdi
		Delete From CrSigOpTds
Select CrSigOpTdt
	SELECT csSigOpTdz
	Select crSigOpTdz
	Select TmpTabdi
	Select TmpTbCom
	Select crSigOpTdt
	Append From Dbf('TmpTabdi')
	Select crSigOpTdi
	Append From Dbf('TmpTbCom')
Select CrSigcdEmp
Select CrSigcdemp
Select CrSigOpTdt
	Update CrSigOpTdt Set regs = 0 Where Recno() <> lnRecno
	Update CrSigOpTdt Set regs = 1 Where Recno() = lnRecno
	Select CrSigOpTdi
	Select CrSigOpTdi
	Select CrSigOpTdt
	Insert Into CrSigOpTdt (codigos) Values (CrSigOpTdz.codigos)
	Select CrSigOpTdi
	Select CrSigOpTdt
	Delete
		If ThisForm.poDataMgr.SqlExecute([Select iclis,grupos From SigCdCli Where iclis = ']+This.Value+[' ],'TmpCli') < 1
		Select CrSigOpTdi
	lStrQuery = [Select codigos,tipos,codtips From SigOpTdi Where codigos = ']+CrSigOpTdt.codigos+[' ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpTbCom') < 1
	Select TmpTbCom
	Insert Into CrSigOpTdi (codigos,tipos,codtips) ;
	Select CrSigOpTdi
	Select CrSigOpTdi
	Delete
Select CrSigOpTdt
	Update CrSigOpTdt Set regs = 0 Where Recno() <> lnRecno
	Update CrSigOpTdt Set regs = 1 Where Recno() = lnRecno
			If Not Seek(Padr(This.Value,7),'DiaSemana')
			If Not Empty(CrSigOpTds.Campo1fs) And Seek(Padr(Alltrim(CrSigOpTds.Campo1fs),7),'DiaSemana')
		=Seek(Padr(Alltrim(CrSigOpTds.Campo1is),7),'DiaSemana')
		Select * From DiaSemana Where nDias >= lnDia Into cursor DiaSemanaF ReadWrite
		Select DiaSemanaF
		If Not Seek(Padr(This.Value,7),'DiaSemanaf')
	Select CrSigOpTds
Select CrSigOpTds
	Delete
Select CrSigOpTds

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbv.prg) - TRECHOS RELEVANTES PARA PASS SQL (4203 linhas total):

*-- Linhas 352 a 370:
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .GridLines          = 3
358:             .GridLineColor      = RGB(238, 238, 238)
359:             .HighlightStyle     = 2
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .ReadOnly           = .T.
365:             .Visible            = .T.
366:         ENDWITH
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 

*-- Linhas 384 a 416:
384:                 IF USED("cursor_4c_Dados")
385:                     USE IN cursor_4c_Dados
386:                 ENDIF
387:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
388:                 INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
389:                 SET DATASESSION TO (loc_nDsAtual)
390:                 loc_lResultado = .T.
391:             ELSE
392:                 IF THIS.this_oBusinessObject.Buscar("")
393:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
394: 
395:                     loc_oGrid.ColumnCount   = 4
396:                     loc_oGrid.RecordSource  = "cursor_4c_Dados"
397: 
398:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
399:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
400:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
401:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"
402: 
403:                     loc_oGrid.Column1.Width         = 110
404:                     loc_oGrid.Column2.Width         = 480
405:                     loc_oGrid.Column3.Width         = 100
406:                     loc_oGrid.Column4.Width         = 130
407: 
408:                     loc_oGrid.Column1.ReadOnly      = .T.
409:                     loc_oGrid.Column2.ReadOnly      = .T.
410:                     loc_oGrid.Column3.ReadOnly      = .T.
411:                     loc_oGrid.Column4.ReadOnly      = .T.
412: 
413:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
414:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
415:                     loc_oGrid.Column3.Header1.Caption = "Moeda Ref" + CHR(234) + "ncia"
416:                     loc_oGrid.Column4.Header1.Caption = "Desconto (%)"

*-- Linhas 1239 a 1257:
1239:             .Height       = 90
1240:             .FontName     = "Verdana"
1241:             .FontSize     = 8
1242:             .DeleteMark   = .F.
1243:             .RecordMark   = .F.
1244:             .GridLines    = 3
1245:             .HeaderHeight = 0
1246:             .RowHeight    = 18
1247:             .ScrollBars   = 2
1248:             .Visible      = .T.
1249:         ENDWITH
1250: 
1251:         WITH loc_oGridEmp.Column1
1252:             .Width    = 30
1253:             .Sparse   = .F.
1254:             .ReadOnly = .F.
1255:         ENDWITH
1256:         loc_oGridEmp.Column1.Header1.Caption = ""
1257:         loc_oGridEmp.Column1.AddObject("chk_4c_Marca", "CheckBox")

*-- Linhas 1355 a 1373:
1355:         *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
1356:         *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
1357:         *-- resto do sistema (CLAUDE.md #9.4)
1358:         SET DELETED ON
1359: 
1360:         THIS.CriarCursorDiaSemana()
1361: 
1362:         loc_oPg.AddObject("cnt_4c_PgConfDesconto", "Container")
1363:         WITH loc_oPg.cnt_4c_PgConfDesconto
1364:             .Top       = 151
1365:             .Left      = -1
1366:             .Width     = 1004
1367:             .Height    = 482
1368:             .BackStyle = 0
1369:             .Visible   = .T.
1370:         ENDWITH
1371: 
1372:         *----------------------------------------------------------------------
1373:         * Rotulos de cabecalho das colunas (Label1/Label2/lb_desconto)

*-- Linhas 1513 a 1531:
1513:         *----------------------------------------------------------------------
1514:         * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
1515:         * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
1516:         * ControlSource/InputMask reconfigurados dinamicamente por
1517:         * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
1518:         * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
1519:         * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
1520:         * Preco/Fator.
1521:         *----------------------------------------------------------------------
1522:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
1523:         loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
1524:         loc_oGradeD.RecordSource = ""
1525:         loc_oGradeD.ColumnCount  = 6
1526:         WITH loc_oGradeD
1527:             .Top        = 26
1528:             .Left       = 462
1529:             .Width      = 358
1530:             .Height     = 419
1531:             .FontName   = "Verdana"

*-- Linhas 1568 a 1628:
1568:             .Width             = 40
1569:             .Header1.Caption   = "Inicial"
1570:             .Header1.Alignment = 2
1571:             .Header1.FontName  = "Verdana"
1572:             .Header1.FontSize  = 8
1573:             .ControlSource     = "cursor_4c_Tds.Campo2is"
1574:             .Format            = "R"
1575:             .InputMask         = "99:99"
1576:             .Text1.InputMask   = "99:99"
1577:         ENDWITH
1578:         BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
1579:         BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")
1580: 
1581:         WITH loc_oGradeD.Column4
1582:             .Width             = 40
1583:             .Header1.Caption   = "Final"
1584:             .Header1.Alignment = 2
1585:             .Header1.FontName  = "Verdana"
1586:             .Header1.FontSize  = 8
1587:             .ControlSource     = "cursor_4c_Tds.Campo2fs"
1588:             .Format            = "R"
1589:             .InputMask         = "99:99"
1590:             .Text1.InputMask   = "99:99"
1591:         ENDWITH
1592:         BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
1593:         BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")
1594: 
1595:         WITH loc_oGradeD.Column5
1596:             .Width             = 48
1597:             .Header1.Caption   = "Pre" + CHR(231) + "o"
1598:             .Header1.Alignment = 2
1599:             .Header1.FontName  = "Verdana"
1600:             .Header1.FontSize  = 8
1601:             .ControlSource     = "cursor_4c_Tds.descos"
1602:             .InputMask         = "999.99"
1603:             .Text1.InputMask   = "999.99"
1604:         ENDWITH
1605:         BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")
1606: 
1607:         WITH loc_oGradeD.Column6
1608:             .Width             = 46
1609:             .Header1.Caption   = "Fator"
1610:             .Header1.Alignment = 2
1611:             .Header1.FontName  = "Verdana"
1612:             .Header1.FontSize  = 8
1613:             .ControlSource     = "cursor_4c_Tds.dfators"
1614:             .InputMask         = "999.99"
1615:             .Text1.InputMask   = "999.99"
1616:         ENDWITH
1617:         BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
1618:         BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")
1619: 
1620:         *----------------------------------------------------------------------
1621:         * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
1622:         *----------------------------------------------------------------------
1623:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
1624:         WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
1625:             .Caption         = ""
1626:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1627:             .ToolTipText     = "Excluir"
1628:             .PicturePosition = 1

*-- Linhas 1649 a 1675:
1649:     * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
1650:     * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
1651:     * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
1652:     *
1653:     * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
1654:     * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
1655:     * (filtro local via MontarComissoesDesconto - equivalente ao
1656:     * "MontaTbCom" do legado).
1657:     *
1658:     * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
1659:     * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
1660:     * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
1661:     * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
1662:     *--------------------------------------------------------------------------
1663:     PROTECTED PROCEDURE ConfigurarPgPgDesconto()
1664:         LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2
1665: 
1666:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1667: 
1668:         loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
1669:         loc_oCnt = loc_oPg.cnt_4c_PgDesconto
1670:         WITH loc_oCnt
1671:             .Top       = 151
1672:             .Left      = -1
1673:             .Width     = 1004
1674:             .Height    = 482
1675:             .BackStyle = 0

*-- Linhas 1963 a 1983:
1963:             .Visible   = .T.
1964:         ENDWITH
1965: 
1966:         *----------------------------------------------------------------------
1967:         * grd_4c_Gradec - comissoes por grupo/conta da linha corrente de
1968:         * grd_4c_Gradei (cursor_4c_Tdi filtrado localmente)
1969:         *----------------------------------------------------------------------
1970:         loc_oCnt.AddObject("grd_4c_Gradec", "Grid")
1971:         loc_oGradec = loc_oCnt.grd_4c_Gradec
1972:         loc_oGradec.RecordSource = ""
1973:         loc_oGradec.ColumnCount  = 6
1974:         WITH loc_oGradec
1975:             .Top       = 16
1976:             .Left      = 575
1977:             .Width     = 422
1978:             .Height    = 279
1979:             .FontName  = "Verdana"
1980:             .FontSize  = 8
1981:             .RowHeight = 20
1982:             .RecordMark = .F.
1983:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 2048 a 2068:
2048:             .Text1.ForeColor   = RGB(0, 0, 0)
2049:             .Text1.BackColor   = RGB(255, 255, 255)
2050:         ENDWITH
2051: 
2052:         *----------------------------------------------------------------------
2053:         * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
2054:         *----------------------------------------------------------------------
2055:         loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
2056:         WITH loc_oCnt.cmd_4c_InserirComissao
2057:             .Caption   = ""
2058:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2059:             .Top       = 296
2060:             .Left      = 577
2061:             .Width     = 40
2062:             .Height    = 40
2063:             .BackColor = RGB(255, 255, 255)
2064:             .ForeColor = RGB(36, 84, 155)
2065:             .FontName  = "Verdana"
2066:             .FontSize  = 8
2067:             .FontBold  = .T.
2068:             .Themes    = .F.

*-- Linhas 2116 a 2134:
2116:             .Style          = 2
2117:             .RowSourceType  = 1
2118:             .RowSource      = "Normal,Pelo Custo,Pelo Feitio"
2119:             .ControlSource  = "cursor_4c_Tdt.tpcomis"
2120:             .FontName       = "Tahoma"
2121:             .FontSize       = 8
2122:             .Visible        = .T.
2123:         ENDWITH
2124: 
2125:         loc_oCnt.AddObject("lbl_4c_DescritivoFator", "Label")
2126:         WITH loc_oCnt.lbl_4c_DescritivoFator
2127:             .Caption   = "Descritivo de Fator :"
2128:             .Top       = 342
2129:             .Left      = 20
2130:             .Width     = 115
2131:             .Height    = 15
2132:             .BackStyle = 0
2133:             .FontName  = "Tahoma"
2134:             .FontSize  = 8

*-- Linhas 2144 a 2162:
2144:             .Width         = 80
2145:             .Height        = 18
2146:             .MaxLength     = 10
2147:             .ControlSource = "cursor_4c_Tdt.descfats"
2148:             .FontName      = "Tahoma"
2149:             .FontSize      = 8
2150:             .Visible       = .T.
2151:         ENDWITH
2152: 
2153:         loc_oCnt.AddObject("lbl_4c_FatorPadrao", "Label")
2154:         WITH loc_oCnt.lbl_4c_FatorPadrao
2155:             .Caption   = "Fator Padr" + CHR(227) + "o :"
2156:             .Top       = 341
2157:             .Left      = 270
2158:             .Width     = 81
2159:             .Height    = 15
2160:             .BackStyle = 0
2161:             .FontName  = "Tahoma"
2162:             .FontSize  = 8

*-- Linhas 2173 a 2206:
2173:             .Height        = 23
2174:             .InputMask     = "9999.999"
2175:             .Alignment     = 1
2176:             .ControlSource = "cursor_4c_Tdt.fatorpads"
2177:             .FontName      = "Tahoma"
2178:             .FontSize      = 8
2179:             .Visible       = .T.
2180:         ENDWITH
2181: 
2182:         loc_oCnt.AddObject("chk_4c_IgnoraCotacao", "CheckBox")
2183:         WITH loc_oCnt.chk_4c_IgnoraCotacao
2184:             .Caption       = "Ignora cota" + CHR(231) + CHR(227) + "o"
2185:             .Top           = 401
2186:             .Left          = 836
2187:             .Width         = 105
2188:             .Height        = 15
2189:             .Alignment     = 0
2190:             .BackStyle     = 0
2191:             .ControlSource = "cursor_4c_Tdt.chkcots"
2192:             .ToolTipText   = "Faz os c" + CHR(225) + "lculos sem usar a cota" + CHR(231) + CHR(227) + "o da moeda"
2193:             .FontName      = "Verdana"
2194:             .FontSize      = 8
2195:             .ForeColor     = RGB(90, 90, 90)
2196:             .Themes        = .F.
2197:             .Visible       = .T.
2198:         ENDWITH
2199: 
2200:         THIS.TornarControlesVisiveis(loc_oCnt)
2201:     ENDPROC
2202: 
2203:     *--------------------------------------------------------------------------
2204:     * ConfigurarFormulaDesconto - Cria os controles de uma formula (1a/2a)
2205:     * dentro do container informado, bindados a cursor_4c_Tdt.*<sufixo>
2206:     * (sufixo "t1s" ou "t2s"). Espelha o container F?rmula1/F?rmula2 do

*-- Linhas 2236 a 2366:
2236:                 .SpecialEffect = 1
2237:                 .RowSourceType = 1
2238:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2239:                 .ControlSource = "cursor_4c_Tdt.campo1" + par_cSufixo
2240:                 .BackColor     = RGB(220, 211, 194)
2241:                 .FontName      = "Tahoma"
2242:                 .FontSize      = 8
2243:                 .Visible       = .T.
2244:             ENDWITH
2245: 
2246:             .AddObject("cbo_4c_Oper1", "ComboBox")
2247:             WITH .cbo_4c_Oper1
2248:                 .Top           = 7
2249:                 .Left          = 283
2250:                 .Width         = 39
2251:                 .Height        = 24
2252:                 .Style         = 2
2253:                 .SpecialEffect = 1
2254:                 .RowSourceType = 1
2255:                 .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
2256:                 .ControlSource = "cursor_4c_Tdt.oper1" + par_cSufixo
2257:                 .BackColor     = RGB(253, 250, 185)
2258:                 .FontName      = "Tahoma"
2259:                 .FontSize      = 12
2260:                 .FontBold      = .T.
2261:                 .Visible       = .T.
2262:             ENDWITH
2263: 
2264:             .AddObject("txt_4c_Const1", "TextBox")
2265:             WITH .txt_4c_Const1
2266:                 .Top           = 7
2267:                 .Left          = 236
2268:                 .Width         = 36
2269:                 .Height        = 24
2270:                 .MaxLength     = 3
2271:                 .ControlSource = "cursor_4c_Tdt.const1" + par_cSufixo
2272:                 .BackColor     = RGB(202, 255, 224)
2273:                 .FontName      = "Tahoma"
2274:                 .FontSize      = 8
2275:                 .Visible       = .T.
2276:             ENDWITH
2277: 
2278:             .AddObject("cbo_4c_Campo2", "ComboBox")
2279:             WITH .cbo_4c_Campo2
2280:                 .Top           = 7
2281:                 .Left          = 330
2282:                 .Width         = 127
2283:                 .Height        = 24
2284:                 .Style         = 2
2285:                 .SpecialEffect = 1
2286:                 .RowSourceType = 1
2287:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2288:                 .ControlSource = "cursor_4c_Tdt.campo2" + par_cSufixo
2289:                 .BackColor     = RGB(220, 211, 194)
2290:                 .FontName      = "Tahoma"
2291:                 .FontSize      = 8
2292:                 .Visible       = .T.
2293:             ENDWITH
2294: 
2295:             .AddObject("cbo_4c_Oper2", "ComboBox")
2296:             WITH .cbo_4c_Oper2
2297:                 .Top           = 7
2298:                 .Left          = 468
2299:                 .Width         = 39
2300:                 .Height        = 24
2301:                 .Style         = 2
2302:                 .SpecialEffect = 1
2303:                 .RowSourceType = 1
2304:                 .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
2305:                 .ControlSource = "cursor_4c_Tdt.oper2" + par_cSufixo
2306:                 .BackColor     = RGB(253, 250, 185)
2307:                 .FontName      = "Tahoma"
2308:                 .FontSize      = 12
2309:                 .FontBold      = .T.
2310:                 .Visible       = .T.
2311:             ENDWITH
2312: 
2313:             .AddObject("txt_4c_Const2", "TextBox")
2314:             WITH .txt_4c_Const2
2315:                 .Top           = 7
2316:                 .Left          = 421
2317:                 .Width         = 36
2318:                 .Height        = 24
2319:                 .MaxLength     = 3
2320:                 .ControlSource = "cursor_4c_Tdt.const2" + par_cSufixo
2321:                 .BackColor     = RGB(202, 255, 224)
2322:                 .FontName      = "Tahoma"
2323:                 .FontSize      = 8
2324:                 .Visible       = .T.
2325:             ENDWITH
2326: 
2327:             .AddObject("cbo_4c_Campo3", "ComboBox")
2328:             WITH .cbo_4c_Campo3
2329:                 .Top           = 7
2330:                 .Left          = 517
2331:                 .Width         = 127
2332:                 .Height        = 24
2333:                 .Style         = 2
2334:                 .SpecialEffect = 1
2335:                 .RowSourceType = 1
2336:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2337:                 .ControlSource = "cursor_4c_Tdt.campo3" + par_cSufixo
2338:                 .BackColor     = RGB(220, 211, 194)
2339:                 .FontName      = "Tahoma"
2340:                 .FontSize      = 8
2341:                 .Visible       = .T.
2342:             ENDWITH
2343: 
2344:             .AddObject("txt_4c_Const3", "TextBox")
2345:             WITH .txt_4c_Const3
2346:                 .Top           = 7
2347:                 .Left          = 608
2348:                 .Width         = 36
2349:                 .Height        = 24
2350:                 .MaxLength     = 3
2351:                 .ControlSource = "cursor_4c_Tdt.const3" + par_cSufixo
2352:                 .BackColor     = RGB(202, 255, 224)
2353:                 .FontName      = "Tahoma"
2354:                 .FontSize      = 8
2355:                 .Visible       = .T.
2356:             ENDWITH
2357: 
2358:             .AddObject("lbl_4c_MoedaConversao", "Label")
2359:             WITH .lbl_4c_MoedaConversao
2360:                 .Caption   = "Moeda de Convers" + CHR(227) + "o :"
2361:                 .Top       = 12
2362:                 .Left      = 662
2363:                 .Width     = 126
2364:                 .Height    = 15
2365:                 .BackStyle = 0
2366:                 .FontName  = "Tahoma"

*-- Linhas 2377 a 2395:
2377:                 .Width         = 40
2378:                 .Height        = 24
2379:                 .MaxLength     = 3
2380:                 .ControlSource = "cursor_4c_Tdt.moeda" + IIF(par_cSufixo = "t1s", "1s", "2s")
2381:                 .BackColor     = RGB(207, 241, 241)
2382:                 .FontName      = "Tahoma"
2383:                 .FontSize      = 8
2384:                 .Visible       = .T.
2385:             ENDWITH
2386:         ENDWITH
2387:     ENDPROC
2388: 
2389:     *--------------------------------------------------------------------------
2390:     * FormParaBO - Transfere dados do Form para Business Object
2391:     *--------------------------------------------------------------------------
2392:     PROCEDURE FormParaBO()
2393:         LOCAL loc_oPg
2394: 
2395:         loc_oPg = THIS.pgf_4c_Paginas.Page2

*-- Linhas 2493 a 2525:
2493:             *-- Container de empresas: comeca oculto ate o usuario escolher tipo 11
2494:             loc_oPg2.cnt_4c_Container1.Visible  = .F.
2495:             IF USED("cursor_4c_Empresas")
2496:                 SELECT cursor_4c_Empresas
2497:                 REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2498:                 GO TOP IN cursor_4c_Empresas
2499:             ENDIF
2500: 
2501:             *-- Registro novo (INCLUIR) ainda nao tem composicao/comissoes/
2502:             *-- faixas de desconto cadastradas
2503:             IF USED("cursor_4c_Tdt")
2504:                 USE IN cursor_4c_Tdt
2505:             ENDIF
2506:             IF USED("cursor_4c_Tdi")
2507:                 USE IN cursor_4c_Tdi
2508:             ENDIF
2509:             IF USED("cursor_4c_Tds")
2510:                 USE IN cursor_4c_Tds
2511:             ENDIF
2512:             THIS.CarregarConfiguracaoDesconto()
2513:         CATCH TO loException
2514:             MostrarErro(loException, "FormTbv.LimparCampos")
2515:         ENDTRY
2516:     ENDPROC
2517: 
2518:     *--------------------------------------------------------------------------
2519:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
2520:     *--------------------------------------------------------------------------
2521:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2522:         LOCAL loc_oPg2, loc_lCodHabilitar
2523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2524: 
2525:         TRY

*-- Linhas 2640 a 2658:
2640:             RETURN loc_lResultado
2641:         ENDIF
2642: 
2643:         SELECT cursor_4c_Dados
2644:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2645: 
2646:         TRY
2647:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2648:                 THIS.BOParaForm()
2649:                 THIS.this_cModoAtual = "VISUALIZAR"
2650:                 THIS.HabilitarCampos(.F.)
2651:                 THIS.AjustarBotoesPorModo()
2652:                 THIS.AlternarPagina(2)
2653:                 loc_lResultado = .T.
2654:             ENDIF
2655:         CATCH TO loException
2656:             MostrarErro(loException, "FormTbv.BtnVisualizarClick")
2657:             loc_lResultado = .F.
2658:         ENDTRY

*-- Linhas 2673 a 2691:
2673:             RETURN loc_lResultado
2674:         ENDIF
2675: 
2676:         SELECT cursor_4c_Dados
2677:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2678: 
2679:         TRY
2680:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2681:                 THIS.this_oBusinessObject.EditarRegistro()
2682:                 THIS.BOParaForm()
2683:                 THIS.this_cModoAtual = "ALTERAR"
2684:                 THIS.HabilitarCampos(.T.)
2685:                 THIS.AjustarBotoesPorModo()
2686:                 THIS.AlternarPagina(2)
2687:                 loc_lResultado = .T.
2688:             ENDIF
2689:         CATCH TO loException
2690:             MostrarErro(loException, "FormTbv.BtnAlterarClick")
2691:             loc_lResultado = .F.

*-- Linhas 2708 a 2726:
2708:             RETURN loc_lResultado
2709:         ENDIF
2710: 
2711:         SELECT cursor_4c_Dados
2712:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2713: 
2714:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2715:             RETURN loc_lResultado
2716:         ENDIF
2717: 
2718:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da tabela de desconto " + loc_cCodigo + "?", "Excluir")
2719:             RETURN loc_lResultado
2720:         ENDIF
2721: 
2722:         TRY
2723:             IF THIS.this_oBusinessObject.Excluir()
2724:                 MsgInfo("Tabela de desconto exclu" + CHR(237) + "da com sucesso!")
2725:                 THIS.CarregarLista()
2726:                 loc_lResultado = .T.

*-- Linhas 2738 a 2756:
2738:     *--------------------------------------------------------------------------
2739:     * BtnBuscarClick - Prepara Page2 em modo BUSCAR (localizar registro ja
2740:     * carregado na lista por codigo ou descricao), reproduzindo o Busca=1/
2741:     * Busca=2 do legado (Select CrSigOpTdz / Seek por Codigos ou Descrs)
2742:     * PUBLIC: BINDEVENT requer metodo publico
2743:     *--------------------------------------------------------------------------
2744:     PROCEDURE BtnBuscarClick()
2745:         LOCAL loc_lResultado
2746:         loc_lResultado = .F.
2747: 
2748:         TRY
2749:             THIS.this_oBusinessObject.NovoRegistro()
2750:             THIS.LimparCampos()
2751:             THIS.this_cModoAtual = "BUSCAR"
2752:             THIS.HabilitarCampos(.T.)
2753:             THIS.AjustarBotoesPorModo()
2754:             THIS.AlternarPagina(2)
2755:             loc_lResultado = .T.
2756:         CATCH TO loException

*-- Linhas 2803 a 2821:
2803:                 THIS.this_cModoAtual = "LISTA"
2804:                 THIS.AlternarPagina(1)
2805:                 IF USED("cursor_4c_Dados")
2806:                     SELECT cursor_4c_Dados
2807:                     IF !EMPTY(loc_cCodBusca)
2808:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
2809:                     ELSE
2810:                         IF !EMPTY(loc_cDescBusca)
2811:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descrs)) = UPPER(loc_cDescBusca)
2812:                         ENDIF
2813:                     ENDIF
2814:                 ENDIF
2815:                 loc_lResultado = .T.
2816:             ELSE
2817:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2818:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2819:                         MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!", "")
2820:                         THIS.this_oBusinessObject.NovoRegistro()
2821:                         loc_oPg2.txt_4c__codigos.SetFocus

*-- Linhas 2876 a 2970:
2876: 
2877:     *--------------------------------------------------------------------------
2878:     * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
2879:     * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
2880:     *--------------------------------------------------------------------------
2881:     PROTECTED PROCEDURE CriarCursorTipoDesconto()
2882:         IF USED("cursor_4c_TipoDesconto")
2883:             RETURN
2884:         ENDIF
2885: 
2886:         CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
2887:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
2888:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
2889:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
2890:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
2891:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
2892:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
2893:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
2894:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
2895:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
2896:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
2897:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
2898:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
2899:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
2900:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
2901:         GO TOP IN cursor_4c_TipoDesconto
2902:     ENDPROC
2903: 
2904:     *--------------------------------------------------------------------------
2905:     * TipoDescontoInteractiveChange - Mostra/oculta a lista de empresas conforme
2906:     * o tipo de desconto selecionado (11 = Desconto Gerente-Extra/loja)
2907:     * PUBLIC: BINDEVENT requer metodo publico
2908:     *--------------------------------------------------------------------------
2909:     PROCEDURE TipoDescontoInteractiveChange()
2910:         LOCAL loc_oPg, loc_lMostrarEmpresas
2911: 
2912:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2913:         loc_lMostrarEmpresas = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2914: 
2915:         loc_oPg.cnt_4c_Container1.Visible = loc_lMostrarEmpresas
2916: 
2917:         IF !loc_lMostrarEmpresas AND USED("cursor_4c_Empresas")
2918:             SELECT cursor_4c_Empresas
2919:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2920:             GO TOP IN cursor_4c_Empresas
2921:             IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
2922:                 loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
2923:             ENDIF
2924:         ENDIF
2925:     ENDPROC
2926: 
2927:     *--------------------------------------------------------------------------
2928:     * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
2929:     * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
2930:     *--------------------------------------------------------------------------
2931:     PROCEDURE CarregarGradeEmpresas()
2932:         LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas
2933: 
2934:         loc_lResultado = .F.
2935: 
2936:         TRY
2937:             IF THIS.this_oBusinessObject.CarregarEmpresas()
2938:                 loc_cListaEmpresas = THIS.this_oBusinessObject.this_cListaEmpresas
2939: 
2940:                 SELECT cursor_4c_Empresas
2941:                 SCAN
2942:                     IF !EMPTY(ALLTRIM(cursor_4c_Empresas.cemps)) AND ALLTRIM(cursor_4c_Empresas.cemps) $ loc_cListaEmpresas
2943:                         REPLACE nMarca WITH 1 IN cursor_4c_Empresas
2944:                     ELSE
2945:                         REPLACE nMarca WITH 0 IN cursor_4c_Empresas
2946:                     ENDIF
2947:                 ENDSCAN
2948:                 GO TOP IN cursor_4c_Empresas
2949: 
2950:                 *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
2951:                 *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
2952:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
2953:                 loc_oGrid.RecordSource = "cursor_4c_Empresas"
2954:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
2955:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
2956:                 loc_oGrid.Column1.Header1.Caption = ""
2957:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2958:                 loc_oGrid.Column1.Width  = 30
2959:                 loc_oGrid.Column2.Width  = 190
2960:                 loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
2961:                 loc_oGrid.Column2.ReadOnly = .T.
2962:                 loc_oGrid.Refresh()
2963: 
2964:                 loc_lResultado = .T.
2965:             ENDIF
2966:         CATCH TO loException
2967:             MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
2968:             loc_lResultado = .F.
2969:         ENDTRY
2970: 

*-- Linhas 2981 a 3045:
2981:         loc_cLista = ""
2982: 
2983:         IF USED("cursor_4c_Empresas")
2984:             SELECT cursor_4c_Empresas
2985:             GO TOP
2986:             SCAN
2987:                 IF cursor_4c_Empresas.nMarca = 1
2988:                     loc_cLista = loc_cLista + ";" + ALLTRIM(cursor_4c_Empresas.cemps)
2989:                 ENDIF
2990:             ENDSCAN
2991:         ENDIF
2992: 
2993:         RETURN loc_cLista
2994:     ENDPROC
2995: 
2996:     *--------------------------------------------------------------------------
2997:     * BtnEmpresasDesmarcarClick - Desmarca todas as empresas da grade
2998:     * PUBLIC: BINDEVENT requer metodo publico
2999:     *--------------------------------------------------------------------------
3000:     PROCEDURE BtnEmpresasDesmarcarClick()
3001:         IF USED("cursor_4c_Empresas")
3002:             SELECT cursor_4c_Empresas
3003:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
3004:             GO TOP IN cursor_4c_Empresas
3005:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3006:         ENDIF
3007:     ENDPROC
3008: 
3009:     *--------------------------------------------------------------------------
3010:     * BtnEmpresasMarcarClick - Marca todas as empresas da grade
3011:     * PUBLIC: BINDEVENT requer metodo publico
3012:     *--------------------------------------------------------------------------
3013:     PROCEDURE BtnEmpresasMarcarClick()
3014:         IF USED("cursor_4c_Empresas")
3015:             SELECT cursor_4c_Empresas
3016:             REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
3017:             GO TOP IN cursor_4c_Empresas
3018:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3019:         ENDIF
3020:     ENDPROC
3021: 
3022:     *--------------------------------------------------------------------------
3023:     * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
3024:     * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
3025:     * manualmente e suprime o toggle padrao com NODEFAULT
3026:     * PUBLIC: BINDEVENT requer metodo publico
3027:     *--------------------------------------------------------------------------
3028:     PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3029:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3030:             SELECT cursor_4c_Empresas
3031:             REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3032:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3033:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3034:             ENDIF
3035:         ENDIF
3036:         NODEFAULT
3037:     ENDPROC
3038: 
3039:     *--------------------------------------------------------------------------
3040:     * EmpresaCheckboxMouseUp - Suprime comportamento padrao
3041:     * PUBLIC: BINDEVENT requer metodo publico
3042:     *--------------------------------------------------------------------------
3043:     PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3044:         NODEFAULT
3045:     ENDPROC

*-- Linhas 3059 a 3077:
3059:     PROCEDURE EmpresaCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3060:         IF INLIST(par_nKeyCode, 13, 32)
3061:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3062:                 SELECT cursor_4c_Empresas
3063:                 REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3064:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3065:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3066:                 ENDIF
3067:             ENDIF
3068:             NODEFAULT
3069:         ENDIF
3070:     ENDPROC
3071: 
3072:     *--------------------------------------------------------------------------
3073:     * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
3074:     * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
3075:     * PUBLIC: BINDEVENT requer metodo publico
3076:     *--------------------------------------------------------------------------
3077:     PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 3107 a 3125:
3107:                 ENDIF
3108: 
3109:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3110:                     SELECT cursor_4c_BuscaMoeda
3111:                     loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3112:                     loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
3113:                 ENDIF
3114: 
3115:                 loc_oBusca.Release()
3116:             ENDIF
3117:         CATCH TO loException
3118:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
3119:         ENDTRY
3120: 
3121:         IF USED("cursor_4c_BuscaMoeda")
3122:             USE IN cursor_4c_BuscaMoeda
3123:         ENDIF
3124:     ENDPROC
3125: 

*-- Linhas 3161 a 3212:
3161:                 ENDIF
3162: 
3163:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
3164:                     SELECT cursor_4c_BuscaMoedaFator
3165:                     loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
3166:                 ENDIF
3167: 
3168:                 loc_oBusca.Release()
3169:             ENDIF
3170:         CATCH TO loException
3171:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
3172:         ENDTRY
3173: 
3174:         IF USED("cursor_4c_BuscaMoedaFator")
3175:             USE IN cursor_4c_BuscaMoedaFator
3176:         ENDIF
3177:     ENDPROC
3178: 
3179:     *--------------------------------------------------------------------------
3180:     * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
3181:     * semana, usado na validacao de faixas de desconto por Dia da Semana
3182:     * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
3183:     *--------------------------------------------------------------------------
3184:     PROTECTED PROCEDURE CriarCursorDiaSemana()
3185:         IF USED("cursor_4c_DiaSemana")
3186:             RETURN
3187:         ENDIF
3188: 
3189:         CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
3190:         INDEX ON Descrs TAG Descrs
3191:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
3192:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
3193:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
3194:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
3195:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
3196:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
3197:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
3198:         GO TOP IN cursor_4c_DiaSemana
3199:     ENDPROC
3200: 
3201:     *--------------------------------------------------------------------------
3202:     * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
3203:     * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
3204:     * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
3205:     *--------------------------------------------------------------------------
3206:     PROCEDURE CarregarConfiguracaoDesconto()
3207:         LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo
3208: 
3209:         TRY
3210:             loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3211:             loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3212:             loc_oGradei     = loc_oPgConf.grd_4c_GradeI

*-- Linhas 3229 a 3295:
3229:             THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)
3230: 
3231:             loc_oGradei.RecordSource        = "cursor_4c_Tdt"
3232:             loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3233:             loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3234:             loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
3235:             loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3236:             loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3237:             loc_oGradei.Refresh()
3238: 
3239:             *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
3240:             *-- adicionais de valor/fator/exclui/faixa/inicial/final
3241:             loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
3242:             loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3243:             loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3244:             loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
3245:             loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
3246:             loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"
3247:             loc_oGradeiDesc.Column6.ControlSource = "cursor_4c_Tdt.faixas"
3248:             loc_oGradeiDesc.Column7.ControlSource = "cursor_4c_Tdt.finicias"
3249:             loc_oGradeiDesc.Column8.ControlSource = "cursor_4c_Tdt.ffinals"
3250:             loc_oGradeiDesc.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3251:             loc_oGradeiDesc.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3252:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180 -
3253:             *-- VFP pode resetar Header1.Caption ao reatribuir RecordSource)
3254:             loc_oGradeiDesc.Column1.Header1.Caption = "Tipo"
3255:             loc_oGradeiDesc.Column2.Header1.Caption = "C" + CHR(243) + "digo "
3256:             loc_oGradeiDesc.Column3.Header1.Caption = "Valor"
3257:             loc_oGradeiDesc.Column4.Header1.Caption = "Fator"
3258:             loc_oGradeiDesc.Column5.Header1.Caption = "E"
3259:             loc_oGradeiDesc.Column6.Header1.Caption = "Faixa"
3260:             loc_oGradeiDesc.Column7.Header1.Caption = "Inicial"
3261:             loc_oGradeiDesc.Column8.Header1.Caption = "Final"
3262:             loc_oGradeiDesc.Refresh()
3263: 
3264:             IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3265:                 SELECT cursor_4c_Tdt
3266:                 REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3267:                 REPLACE regs WITH 1 IN cursor_4c_Tdt
3268:                 GO TOP IN cursor_4c_Tdt
3269:             ENDIF
3270: 
3271:             *-- grd_4c_Gradec (comissoes) - filtrado pela linha corrente de
3272:             *-- cursor_4c_Tdt via MontarComissoesDesconto()
3273:             loc_oGradec.ColumnCount = 6
3274:             loc_oGradec.RecordSource        = "cursor_4c_Tdi"
3275:             loc_oGradec.Column1.ControlSource = "cursor_4c_Tdi.grupos"
3276:             loc_oGradec.Column2.ControlSource = "cursor_4c_Tdi.contas"
3277:             loc_oGradec.Column3.ControlSource = "cursor_4c_Tdi.pintegrals"
3278:             loc_oGradec.Column4.ControlSource = "cursor_4c_Tdi.pdivididas"
3279:             loc_oGradec.Column5.ControlSource = "cursor_4c_Tdi.patendes"
3280:             loc_oGradec.Column6.ControlSource = "cursor_4c_Tdi.moedas"
3281:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180)
3282:             loc_oGradec.Column1.Header1.Caption = "Grupo"
3283:             loc_oGradec.Column2.Header1.Caption = "Conta"
3284:             loc_oGradec.Column3.Header1.Caption = "Integral"
3285:             loc_oGradec.Column4.Header1.Caption = "Dividida"
3286:             loc_oGradec.Column5.Header1.Caption = "Atendim"
3287:             loc_oGradec.Column6.Header1.Caption = "Moe"
3288: 
3289:             THIS.MontarConfiguracaoDesconto()
3290:             THIS.MontarComissoesDesconto()
3291:         CATCH TO loException
3292:             MostrarErro(loException, "FormTbv.CarregarConfiguracaoDesconto")
3293:         ENDTRY
3294:     ENDPROC
3295: 

*-- Linhas 3304 a 3322:
3304:             RETURN
3305:         ENDIF
3306: 
3307:         SELECT cursor_4c_Tdt
3308:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3309:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3310: 
3311:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3312:         THIS.MontarConfiguracaoDesconto()
3313:     ENDPROC
3314: 
3315:     *--------------------------------------------------------------------------
3316:     * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
3317:     * apenas em INCLUIR/ALTERAR (equivalente ao When original)
3318:     * PUBLIC: BINDEVENT requer metodo publico
3319:     *--------------------------------------------------------------------------
3320:     PROCEDURE GradeiConfColumn3When()
3321:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3322:     ENDPROC

*-- Linhas 3337 a 3359:
3337:         ENDIF
3338:     ENDPROC
3339: 
3340:     *--------------------------------------------------------------------------
3341:     * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
3342:     * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
3343:     * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
3344:     * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
3345:     * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
3346:     * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
3347:     *--------------------------------------------------------------------------
3348:     PROTECTED PROCEDURE MontarConfiguracaoDesconto()
3349:         LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
3350:               loc_nTipoDs, loc_cTitulo
3351: 
3352:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3353:         loc_oGD     = loc_oPgConf.grd_4c_GradeD
3354: 
3355:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3356:             loc_oGD.RecordSource = ""
3357:             loc_oGD.Enabled      = .F.
3358:             loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3359:             RETURN

*-- Linhas 3374 a 3422:
3374:             OTHERWISE
3375:                 loc_cTitulo = "Data"
3376:         ENDCASE
3377:         loc_oPgConf.lbl_4c_Lb_desconto.Caption = loc_cTitulo
3378: 
3379:         IF USED("cursor_4c_Tds")
3380:             SELECT cursor_4c_Tds
3381:             SET FILTER TO ALLTRIM(codigos) == loc_cCodigo AND tipos = loc_nTipos ;
3382:                 AND ALLTRIM(codtips) == loc_cCodTips AND tipods = loc_nTipoDs
3383:             GO TOP
3384:             IF EOF()
3385:                 APPEND BLANK
3386:                 REPLACE cidchaves WITH fUniqueIds(), ;
3387:                         codigos   WITH loc_cCodigo, ;
3388:                         tipos     WITH loc_nTipos, ;
3389:                         codtips   WITH loc_cCodTips, ;
3390:                         tipods    WITH loc_nTipoDs, ;
3391:                         campo2is  WITH "00:00", ;
3392:                         campo2fs  WITH "23:59" IN cursor_4c_Tds
3393:                 GO TOP
3394:             ENDIF
3395:         ENDIF
3396: 
3397:         WITH loc_oGD
3398:             .RecordSource = ""
3399:             DO CASE
3400:                 CASE loc_nTipoDs = 5
3401:                     .Column1.ControlSource = "cursor_4c_Tds.Campo3is"
3402:                     .Column2.ControlSource = "cursor_4c_Tds.Campo3fs"
3403:                 OTHERWISE
3404:                     .Column1.ControlSource = "cursor_4c_Tds.Campo1is"
3405:                     .Column2.ControlSource = "cursor_4c_Tds.Campo1fs"
3406:             ENDCASE
3407:             .RecordSource = "cursor_4c_Tds"
3408: 
3409:             DO CASE
3410:                 CASE loc_nTipoDs = 2
3411:                     .Column1.Text1.InputMask = "XXXXXXX"
3412:                     .Column1.Text1.MaxLength = 7
3413:                     .Column2.Text1.InputMask = "XXXXXXX"
3414:                     .Column2.Text1.MaxLength = 7
3415:                 CASE loc_nTipoDs = 3
3416:                     .Column1.Text1.InputMask = "99"
3417:                     .Column1.Text1.MaxLength = 2
3418:                     .Column2.Text1.InputMask = "99"
3419:                     .Column2.Text1.MaxLength = 2
3420:                 CASE loc_nTipoDs = 4
3421:                     .Column1.Text1.InputMask = "99:99"
3422:                     .Column1.Text1.MaxLength = 5

*-- Linhas 3463 a 3820:
3463: 
3464:         RETURN TRANSFORM(loc_nHora, "@L 99") + ":" + TRANSFORM(loc_nMin, "@L 99")
3465:     ENDFUNC
3466: 
3467:     *--------------------------------------------------------------------------
3468:     * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
3469:     * ja tem o valor Inicial preenchido, condicao para habilitar as demais
3470:     * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
3471:     * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
3472:     * (nao em Campo1is - ver MontarConfiguracaoDesconto)
3473:     *--------------------------------------------------------------------------
3474:     PROTECTED FUNCTION FaixaTemInicial()
3475:         LOCAL loc_nTipoDs
3476: 
3477:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3478:             RETURN .F.
3479:         ENDIF
3480: 
3481:         loc_nTipoDs = 0
3482:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3483:             loc_nTipoDs = cursor_4c_Tdt.tipods
3484:         ENDIF
3485: 
3486:         IF loc_nTipoDs = 5
3487:             RETURN !EMPTY(cursor_4c_Tds.Campo3is)
3488:         ENDIF
3489: 
3490:         RETURN !EMPTY(LEFT(NVL(cursor_4c_Tds.Campo1is, ""), 2))
3491:     ENDFUNC
3492: 
3493:     *--------------------------------------------------------------------------
3494:     * GradeD Column1/Column2 (Inicial/Final) - When/Valid
3495:     * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
3496:     * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
3497:     * corrente de grd_4c_GradeI (cursor_4c_Tdt)
3498:     * PUBLIC: BINDEVENT requer metodo publico
3499:     *--------------------------------------------------------------------------
3500:     PROCEDURE GradeDColumn1When()
3501:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3502:     ENDPROC
3503: 
3504:     PROCEDURE GradeDColumn1Valid()
3505:         LOCAL loc_oGD, loc_cValor, loc_cFormatado
3506: 
3507:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3508:             RETURN
3509:         ENDIF
3510: 
3511:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3512:         loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)
3513: 
3514:         IF EMPTY(loc_cValor)
3515:             RETURN
3516:         ENDIF
3517: 
3518:         DO CASE
3519:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3520:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3521:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
3522:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3523:                 ELSE
3524:                     REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3525:                     IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
3526:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3527:                     ENDIF
3528:                 ENDIF
3529: 
3530:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3531:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3532:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3533:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3534:                 ELSE
3535:                     REPLACE Campo1is WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3536:                     IF VAL(cursor_4c_Tds.Campo1fs) = 0 OR VAL(cursor_4c_Tds.Campo1is) > VAL(cursor_4c_Tds.Campo1fs)
3537:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3538:                     ENDIF
3539:                 ENDIF
3540: 
3541:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3542:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3543:                 IF EMPTY(loc_cFormatado)
3544:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3545:                 ELSE
3546:                     REPLACE Campo1is WITH loc_cFormatado IN cursor_4c_Tds
3547:                     IF EMPTY(cursor_4c_Tds.Campo1fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo1fs, ":", ""))
3548:                         REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3549:                     ENDIF
3550:                 ENDIF
3551: 
3552:             OTHERWISE  && 5 = Data (Campo3is/Campo3fs, DATETIME - VFP valida o tipo na propria coluna)
3553:                 IF !EMPTY(cursor_4c_Tds.Campo3fs) AND cursor_4c_Tds.Campo3is > cursor_4c_Tds.Campo3fs
3554:                     REPLACE Campo3fs WITH cursor_4c_Tds.Campo3is IN cursor_4c_Tds
3555:                 ENDIF
3556:         ENDCASE
3557: 
3558:         loc_oGD.Refresh()
3559:     ENDPROC
3560: 
3561:     PROCEDURE GradeDColumn2When()
3562:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3563:     ENDPROC
3564: 
3565:     PROCEDURE GradeDColumn2Valid()
3566:         LOCAL loc_oGD, loc_cValor, loc_nDiaIni, loc_cFormatado
3567: 
3568:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3569:             RETURN
3570:         ENDIF
3571: 
3572:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3573:         loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)
3574: 
3575:         IF EMPTY(loc_cValor)
3576:             RETURN
3577:         ENDIF
3578: 
3579:         DO CASE
3580:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3581:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3582:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
3583:                     RETURN
3584:                 ENDIF
3585:                 IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
3586:                     loc_nDiaIni = cursor_4c_DiaSemana.nDias
3587:                     IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni
3588:                         MsgAviso("Dia final n" + CHR(227) + "o pode ser anterior ao dia inicial !!!", "")
3589:                         RETURN
3590:                     ENDIF
3591:                 ENDIF
3592:                 =SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3593:                 REPLACE Campo1fs WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3594: 
3595:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3596:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3597:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3598:                     RETURN
3599:                 ENDIF
3600:                 IF VAL(loc_cValor) < VAL(cursor_4c_Tds.Campo1is)
3601:                     MsgAviso("Intervalo de dias inv" + CHR(225) + "lido. O dia final " + CHR(233) + " menor que o inicial.", "")
3602:                     RETURN
3603:                 ENDIF
3604:                 REPLACE Campo1fs WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3605: 
3606:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3607:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3608:                 IF EMPTY(loc_cFormatado)
3609:                     RETURN
3610:                 ENDIF
3611:                 IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo1is, ":", ""))
3612:                     MsgAviso("Intervalo de hor" + CHR(225) + "rio inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3613:                     RETURN
3614:                 ENDIF
3615:                 REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3616: 
3617:             OTHERWISE  && 5 = Data
3618:                 IF cursor_4c_Tds.Campo3fs < cursor_4c_Tds.Campo3is
3619:                     MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a inicial !!!", "")
3620:                 ENDIF
3621:         ENDCASE
3622: 
3623:         loc_oGD.Refresh()
3624:     ENDPROC
3625: 
3626:     *--------------------------------------------------------------------------
3627:     * GradeD Column3/Column4 - faixa de horario dentro do dia (Campo2is/fs).
3628:     * Nao se aplica quando o Tipo de Desconto ja e "Horario" (Column1/2)
3629:     * PUBLIC: BINDEVENT requer metodo publico
3630:     *--------------------------------------------------------------------------
3631:     PROCEDURE GradeDColumn3When()
3632:         LOCAL loc_nTipoDs
3633:         loc_nTipoDs = 0
3634:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3635:             loc_nTipoDs = cursor_4c_Tdt.tipods
3636:         ENDIF
3637:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial() AND loc_nTipoDs != 4
3638:     ENDPROC
3639: 
3640:     PROCEDURE GradeDColumn3Valid()
3641:         LOCAL loc_oGD, loc_cFormatado
3642: 
3643:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3644:             RETURN
3645:         ENDIF
3646: 
3647:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3648:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
3649:         IF EMPTY(loc_cFormatado)
3650:             RETURN
3651:         ENDIF
3652: 
3653:         REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
3654:         IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
3655:             REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3656:         ENDIF
3657: 
3658:         loc_oGD.Refresh()
3659:     ENDPROC
3660: 
3661:     PROCEDURE GradeDColumn4When()
3662:         RETURN THIS.GradeDColumn3When()
3663:     ENDPROC
3664: 
3665:     PROCEDURE GradeDColumn4Valid()
3666:         LOCAL loc_oGD, loc_cFormatado
3667: 
3668:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3669:             RETURN
3670:         ENDIF
3671: 
3672:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3673:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
3674:         IF EMPTY(loc_cFormatado)
3675:             RETURN
3676:         ENDIF
3677: 
3678:         IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
3679:             MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3680:             RETURN
3681:         ENDIF
3682: 
3683:         REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3684:         loc_oGD.Refresh()
3685:     ENDPROC
3686: 
3687:     *--------------------------------------------------------------------------
3688:     * GradeD Column5/Column6 - Preco/Fator da faixa. Column6 (Fator), ao
3689:     * confirmar com ENTER, cria automaticamente uma nova faixa em branco
3690:     * (equivalente ao legado)
3691:     * PUBLIC: BINDEVENT requer metodo publico
3692:     *--------------------------------------------------------------------------
3693:     PROCEDURE GradeDColumn5When()
3694:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3695:     ENDPROC
3696: 
3697:     PROCEDURE GradeDColumn6Valid()
3698:         LOCAL loc_oGD
3699: 
3700:         IF LASTKEY() != 13 OR !USED("cursor_4c_Tds") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3701:             RETURN
3702:         ENDIF
3703: 
3704:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3705: 
3706:         SELECT cursor_4c_Tds
3707:         SKIP
3708:         IF EOF()
3709:             APPEND BLANK
3710:             REPLACE cidchaves WITH fUniqueIds(), ;
3711:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3712:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3713:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3714:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3715:                     campo2is  WITH "00:00", ;
3716:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3717:             GO BOTTOM IN cursor_4c_Tds
3718:         ENDIF
3719: 
3720:         loc_oGD.Refresh()
3721:     ENDPROC
3722: 
3723:     *--------------------------------------------------------------------------
3724:     * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
3725:     * garante que sempre reste ao menos uma faixa (equivalente ao legado)
3726:     * PUBLIC: BINDEVENT requer metodo publico
3727:     *--------------------------------------------------------------------------
3728:     PROCEDURE BtnExcluirFaixaDescontoClick()
3729:         LOCAL loc_oGD, loc_nRegistros
3730: 
3731:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
3732:                 OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3733:             RETURN
3734:         ENDIF
3735: 
3736:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3737: 
3738:         SELECT cursor_4c_Tds
3739:         IF !EOF()
3740:             DELETE
3741:         ENDIF
3742: 
3743:         COUNT FOR !DELETED() TO loc_nRegistros
3744:         IF loc_nRegistros = 0
3745:             APPEND BLANK
3746:             REPLACE cidchaves WITH fUniqueIds(), ;
3747:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3748:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3749:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3750:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3751:                     campo2is  WITH "00:00", ;
3752:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3753:         ENDIF
3754: 
3755:         GO TOP IN cursor_4c_Tds
3756:         loc_oGD.Refresh()
3757:         loc_oGD.SetFocus
3758:     ENDPROC
3759: 
3760:     *--------------------------------------------------------------------------
3761:     * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
3762:     * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
3763:     * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
3764:     *--------------------------------------------------------------------------
3765:     PROTECTED PROCEDURE MontarComissoesDesconto()
3766:         LOCAL loc_oGradec, loc_nTipos, loc_cCodTips
3767: 
3768:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
3769: 
3770:         IF !USED("cursor_4c_Tdi")
3771:             RETURN
3772:         ENDIF
3773: 
3774:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3775:             SELECT cursor_4c_Tdi
3776:             SET FILTER TO .F.
3777:             loc_oGradec.Refresh()
3778:             RETURN
3779:         ENDIF
3780: 
3781:         loc_nTipos   = cursor_4c_Tdt.tipos
3782:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3783: 
3784:         SELECT cursor_4c_Tdi
3785:         SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
3786:         GO TOP IN cursor_4c_Tdi
3787:         loc_oGradec.Refresh()
3788:     ENDPROC
3789: 
3790:     *--------------------------------------------------------------------------
3791:     * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
3792:     * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
3793:     * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
3794:     * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
3795:     * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
3796:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3797:     *--------------------------------------------------------------------------
3798:     PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
3799:         LOCAL loc_oCnt
3800: 
3801:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3802:             RETURN
3803:         ENDIF
3804: 
3805:         SELECT cursor_4c_Tdt
3806:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3807:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3808: 
3809:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3810:         loc_oCnt.grd_4c_Gradei.Refresh()
3811:         loc_oCnt.cnt_4c_Formula1.Refresh()
3812:         loc_oCnt.cnt_4c_Formula2.Refresh()
3813:         loc_oCnt.cbo_4c_ComboComis.Refresh()
3814:         loc_oCnt.txt_4c_DescFats.Refresh()
3815:         loc_oCnt.txt_4c_FatorPads.Refresh()
3816:         loc_oCnt.chk_4c_IgnoraCotacao.Refresh()
3817: 
3818:         *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
3819:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3820: 

*-- Linhas 3951 a 3969:
3951:                 ENDIF
3952: 
3953:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
3954:                     SELECT cursor_4c_BuscaComposicao
3955:                     REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
3956:                     loc_oGradei.Refresh()
3957:                 ENDIF
3958: 
3959:                 loc_oBusca.Release()
3960:             ENDIF
3961:         CATCH TO loException
3962:             MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
3963:         ENDTRY
3964: 
3965:         IF USED("cursor_4c_BuscaComposicao")
3966:             USE IN cursor_4c_BuscaComposicao
3967:         ENDIF
3968:     ENDPROC
3969: 

*-- Linhas 3981 a 4126:
3981: 
3982:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3983: 
3984:         INSERT INTO cursor_4c_Tdt (codigos) VALUES (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
3985:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3986:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3987: 
3988:         loc_oPgDesc.grd_4c_Gradei.Refresh()
3989:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3990:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
3991:         THIS.MontarComissoesDesconto()
3992:     ENDPROC
3993: 
3994:     *--------------------------------------------------------------------------
3995:     * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
3996:     * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
3997:     * (equivalente ao legado - "Exclua primeiro as comissoes...")
3998:     * PUBLIC: BINDEVENT requer metodo publico
3999:     *--------------------------------------------------------------------------
4000:     PROCEDURE BtnExcluirComposicaoClick()
4001:         LOCAL loc_oPgDesc
4002: 
4003:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
4004:             RETURN
4005:         ENDIF
4006: 
4007:         THIS.MontarComissoesDesconto()
4008:         IF USED("cursor_4c_Tdi") AND !EOF("cursor_4c_Tdi")
4009:             MsgAviso("Imposs" + CHR(237) + "vel excluir!!! Exclua primeiro as comiss" + CHR(245) + "es...", "")
4010:             RETURN
4011:         ENDIF
4012: 
4013:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4014: 
4015:         SELECT cursor_4c_Tdt
4016:         DELETE
4017:         GO BOTTOM IN cursor_4c_Tdt
4018:         IF !EOF("cursor_4c_Tdt")
4019:             REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4020:             REPLACE regs WITH 1 IN cursor_4c_Tdt
4021:         ENDIF
4022: 
4023:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4024:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4025:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4026:         THIS.MontarComissoesDesconto()
4027:     ENDPROC
4028: 
4029:     *--------------------------------------------------------------------------
4030:     * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
4031:     * para a linha corrente de composicao (Tipo/Codigo)
4032:     * PUBLIC: BINDEVENT requer metodo publico
4033:     *--------------------------------------------------------------------------
4034:     PROCEDURE BtnInserirComissaoClick()
4035:         LOCAL loc_oPgDesc
4036: 
4037:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
4038:                 OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
4039:             RETURN
4040:         ENDIF
4041: 
4042:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4043: 
4044:         INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
4045:             (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))
4046: 
4047:         THIS.MontarComissoesDesconto()
4048:         loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
4049:     ENDPROC
4050: 
4051:     *--------------------------------------------------------------------------
4052:     * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
4053:     * PUBLIC: BINDEVENT requer metodo publico
4054:     *--------------------------------------------------------------------------
4055:     PROCEDURE BtnExcluirComissaoClick()
4056:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4057:             RETURN
4058:         ENDIF
4059: 
4060:         SELECT cursor_4c_Tdi
4061:         DELETE
4062:         GO BOTTOM IN cursor_4c_Tdi
4063: 
4064:         THIS.MontarComissoesDesconto()
4065:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
4066:     ENDPROC
4067: 
4068:     *--------------------------------------------------------------------------
4069:     * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
4070:     * Simplificado em relacao ao legado: NAO reproduz as checagens de
4071:     * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
4072:     * fora do escopo desta migracao). Column2 (Conta) valida contra
4073:     * SigCdCli e preenche automaticamente o Grupo quando vazio.
4074:     * PUBLIC: BINDEVENT requer metodo publico
4075:     *--------------------------------------------------------------------------
4076:     PROCEDURE GradecColumn1Valid()
4077:         RETURN .T.
4078:     ENDPROC
4079: 
4080:     PROCEDURE GradecColumn2Valid()
4081:         LOCAL loc_oGradec, loc_cConta, loc_cSQL
4082: 
4083:         IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4084:             RETURN .T.
4085:         ENDIF
4086: 
4087:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
4088:         loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)
4089: 
4090:         IF EMPTY(loc_cConta)
4091:             RETURN .T.
4092:         ENDIF
4093: 
4094:         TRY
4095:             loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
4096: 
4097:             IF USED("cursor_4c_BuscaConta")
4098:                 USE IN cursor_4c_BuscaConta
4099:             ENDIF
4100: 
4101:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
4102:                 MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")
4103:                 IF USED("cursor_4c_BuscaConta")
4104:                     USE IN cursor_4c_BuscaConta
4105:                 ENDIF
4106:                 loc_lResultado = .F.
4107:             ENDIF
4108: 
4109:             REPLACE contas WITH loc_cConta IN cursor_4c_Tdi
4110:             IF EMPTY(ALLTRIM(cursor_4c_Tdi.grupos))
4111:                 REPLACE grupos WITH ALLTRIM(TratarNulo(cursor_4c_BuscaConta.grupos, "C")) IN cursor_4c_Tdi
4112:             ENDIF
4113:             loc_oGradec.Refresh()
4114:         CATCH TO loException
4115:             MostrarErro(loException, "FormTbv.GradecColumn2Valid")
4116:         ENDTRY
4117: 
4118:         IF USED("cursor_4c_BuscaConta")
4119:             USE IN cursor_4c_BuscaConta
4120:         ENDIF
4121: 
4122:         RETURN .T.
4123:     ENDPROC
4124: 
4125:     *--------------------------------------------------------------------------
4126:     * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)

*-- Linhas 4183 a 4203:
4183:                 USE IN cursor_4c_Empresas
4184:             ENDIF
4185:             IF USED("cursor_4c_Tdt")
4186:                 USE IN cursor_4c_Tdt
4187:             ENDIF
4188:             IF USED("cursor_4c_Tdi")
4189:                 USE IN cursor_4c_Tdi
4190:             ENDIF
4191:             IF USED("cursor_4c_Tds")
4192:                 USE IN cursor_4c_Tds
4193:             ENDIF
4194:             IF USED("cursor_4c_DiaSemana")
4195:                 USE IN cursor_4c_DiaSemana
4196:             ENDIF
4197:         CATCH TO loException
4198:             *-- Ignorar erros na destruicao
4199:         ENDTRY
4200:         DODEFAULT()
4201:     ENDPROC
4202: 
4203: ENDDEFINE


### BO (C:\4c\projeto\app\classes\TbvBO.prg):
*====================================================================
* TbvBO.prg
*
* Business Object para Tabelas de Descontos
* Tabela principal: SigOpTdz (codigos PK)
* Sub-tabelas (grades - tratadas em fases posteriores via cursor):
*   SigOpTdt (composicao/formula), SigOpTdi (comissoes por grupo/conta),
*   SigOpTds (faixas de horario/dia de desconto), SigCdEmp (empresas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbvBO AS BusinessBase

	*-- Propriedades da entidade (SigOpTdz)
	this_cCodigo          = ""   && codigos char(10)      - PK codigo da tabela de desconto
	this_cDescricao       = ""   && descrs char(30)        - descricao
	this_cMoeRef          = ""   && moerefs char(3)        - moeda de referencia
	this_nDesconto        = 0    && descos numeric(5,2)    - percentual de desconto
	this_cObservacao      = ""   && obss char(30)          - observacao
	this_nRelDesconto     = 0    && rel_descs numeric(1,0) - imprime no relatorio de tab. desconto (OptionGroup)
	this_dDataTermino     = {}   && dtterms datetime (NULL) - valido ate (data de termino)
	this_nPrazoMedio      = 0    && prazoms numeric(3,0)   - prazo medio (sem uso)
	this_nChkAcesso       = 0    && chkactb numeric(1,0)   - checar acesso (OptionGroup)
	this_nChkRetorno      = 0    && chkrets numeric(1,0)   - checagem de retorno (OptionGroup)
	this_nAjuste          = 0    && ajustes numeric(8,6)   - valor de ajuste
	this_nFator           = 0    && fators numeric(4,2)    - fator
	this_cMoedaFator      = ""   && moefats char(3)        - moeda do fator
	this_nChaveTabDesc    = 0    && nchvtbds numeric(6,0)  - chave interna da tabela de desconto (auto-gerada)
	this_nDescontoMaximo  = 0    && descmxs numeric(5,2)   - desconto maximo
	this_nAbateCusto      = 0    && abatecus numeric(1,0)  - abater custo de produto da comissao (OptionGroup)
	this_nAgrupaComissao  = 0    && agrucoms numeric(1,0)  - agrupar comissao por (OptionGroup)
	this_nParcelas        = 0    && nparcs numeric(3,0)    - numero de parcelas
	this_nParcelas2       = 0    && nparc2s numeric(3,0)   - numero de parcelas (2)
	this_cListaEmpresas   = ""   && listaemp text (NULL)   - lista de empresas selecionadas (memo)
	this_nTipoDesconto    = 0    && tpdesc numeric(2,0)    - tipo de desconto progressivo (ComboBox)

	*-- Propriedades locais (NAO existem no schema de SigOpTdz - apenas estado UI)
	this_cMoeRefDescricao = ""   && nao persiste - descricao da moeda de referencia (lookup exibicao)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigOpTdz"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDFUNC

	*====================================================================
	* Buscar - SELECT dos registros de SigOpTdz (filtro opcional por descricao)
	*====================================================================
	FUNCTION Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, moerefs, descos" + ;
					   " FROM SigOpTdz"

			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + ;
					" WHERE UPPER(descrs) LIKE UPPER(" + ;
					EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY codigos"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarPorCodigo - SELECT registro por chave primaria (codigos)
	*====================================================================
	FUNCTION CarregarPorCodigo(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc" + ;
					   " FROM SigOpTdz" + ;
					   " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				IF loc_lResultado
					THIS.this_lNovoRegistro = .F.
				ENDIF
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo         = ALLTRIM(TratarNulo(codigos, "C"))
				THIS.this_nDesconto       = TratarNulo(descos, 0)
				THIS.this_cDescricao      = ALLTRIM(TratarNulo(descrs, "C"))
				THIS.this_cMoeRef         = ALLTRIM(TratarNulo(moerefs, "C"))
				THIS.this_cObservacao     = ALLTRIM(TratarNulo(obss, "C"))
				THIS.this_nRelDesconto    = TratarNulo(rel_descs, 0)
				THIS.this_dDataTermino    = TratarNulo(dtterms, {})
				THIS.this_nPrazoMedio     = TratarNulo(prazoms, 0)
				THIS.this_nChkAcesso      = TratarNulo(chkactb, 0)
				THIS.this_nChkRetorno     = TratarNulo(chkrets, 0)
				THIS.this_nAjuste         = TratarNulo(ajustes, 0)
				THIS.this_nFator          = TratarNulo(fators, 0)
				THIS.this_cMoedaFator     = ALLTRIM(TratarNulo(moefats, "C"))
				THIS.this_nChaveTabDesc   = TratarNulo(nchvtbds, 0)
				THIS.this_nDescontoMaximo = TratarNulo(descmxs, 0)
				THIS.this_nAbateCusto     = TratarNulo(abatecus, 0)
				THIS.this_nAgrupaComissao = TratarNulo(agrucoms, 0)
				THIS.this_nParcelas       = TratarNulo(nparcs, 0)
				THIS.this_nParcelas2      = TratarNulo(nparc2s, 0)
				THIS.this_cListaEmpresas  = ALLTRIM(TratarNulo(listaemp, ""))
				THIS.this_nTipoDesconto   = TratarNulo(tpdesc, 0)

				THIS.this_cMoeRefDescricao = ""

				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Inserir - INSERT INTO SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "INSERT INTO SigOpTdz" + ;
					   " (codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc)" + ;
					   " VALUES (" + ;
					   EscaparSQL(THIS.this_cCodigo) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDesconto, 2) + ", " + ;
					   EscaparSQL(THIS.this_cDescricao) + ", " + ;
					   EscaparSQL(THIS.this_cMoeRef) + ", " + ;
					   EscaparSQL(THIS.this_cObservacao) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + ", " + ;
					   FormatarDataSQL(THIS.this_dDataTermino) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAjuste, 6) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nFator, 2) + ", " + ;
					   EscaparSQL(THIS.this_cMoedaFator) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas2, 0) + ", " + ;
					   EscaparSQL(THIS.this_cListaEmpresas) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ")"

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Ins")
				TABLEREVERT(.T., "cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
			IF USED("cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Atualizar - UPDATE SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigOpTdz SET" + ;
					   " descos     = " + FormatarNumeroSQL(THIS.this_nDesconto, 2) + "," + ;
					   " descrs     = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
					   " moerefs    = " + EscaparSQL(THIS.this_cMoeRef) + "," + ;
					   " obss       = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
					   " rel_descs  = " + FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + "," + ;
					   " dtterms    = " + FormatarDataSQL(THIS.this_dDataTermino) + "," + ;
					   " prazoms    = " + FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + "," + ;
					   " chkactb    = " + FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + "," + ;
					   " chkrets    = " + FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + "," + ;
					   " ajustes    = " + FormatarNumeroSQL(THIS.this_nAjuste, 6) + "," + ;
					   " fators     = " + FormatarNumeroSQL(THIS.this_nFator, 2) + "," + ;
					   " moefats    = " + EscaparSQL(THIS.this_cMoedaFator) + "," + ;
					   " nchvtbds   = " + FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + "," + ;
					   " descmxs    = " + FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + "," + ;
					   " abatecus   = " + FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + "," + ;
					   " agrucoms   = " + FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + "," + ;
					   " nparcs     = " + FormatarNumeroSQL(THIS.this_nParcelas, 0) + "," + ;
					   " nparc2s    = " + FormatarNumeroSQL(THIS.this_nParcelas2, 0) + "," + ;
					   " listaemp   = " + EscaparSQL(THIS.this_cListaEmpresas) + "," + ;
					   " tpdesc     = " + FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ;
					   " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Upd")
				TABLEREVERT(.T., "cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ObterDescricaoMoeda - Busca a descricao (dmoes) de uma moeda pelo codigo
	* Usado para exibir a descricao da Moeda de Referencia ao carregar registro
	*====================================================================
	FUNCTION ObterDescricaoMoeda(par_cCodigoMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
		loc_cDescricao = ""

		IF VARTYPE(par_cCodigoMoeda) != "C" OR EMPTY(ALLTRIM(par_cCodigoMoeda))
			RETURN loc_cDescricao
		ENDIF

		TRY
			loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + ;
					   EscaparSQL(ALLTRIM(par_cCodigoMoeda))

			IF USED("cursor_4c_Moeda")
				USE IN cursor_4c_Moeda
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Moeda") > 0
				loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Moeda.dmoes, "C"))
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ObterDescricaoMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Moeda")
			USE IN cursor_4c_Moeda
		ENDIF

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* CarregarEmpresas - SELECT das empresas (SigCdEmp) para a grade de
	* selecao usada no tipo de desconto 11 (Desconto Gerente-Extra/loja)
	* Popula cursor_4c_Empresas (READWRITE) com coluna virtual nMarca
	*====================================================================
	FUNCTION CarregarEmpresas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps FROM SigCdEmp ORDER BY cemps"

			IF USED("cursor_4c_EmpresasTemp")
				USE IN cursor_4c_EmpresasTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Empresas")
					USE IN cursor_4c_Empresas
				ENDIF

				SELECT 0 AS nMarca, cemps ;
					FROM cursor_4c_EmpresasTemp ;
					INTO CURSOR cursor_4c_Empresas READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_EmpresasTemp")
			USE IN cursor_4c_EmpresasTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ExecutarExclusao - DELETE das sub-tabelas (Tdt/Tdi/Tds) + SigOpTdz
	*====================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado, loc_lContinua, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		loc_lContinua  = .T.

		TRY
			*-- Remove registros das grades relacionadas primeiro (formula/comissao/faixas)
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
			IF USED("cursor_4c_DelTdt")
				TABLEREVERT(.T., "cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdt")
			IF USED("cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir formulas da tabela de desconto:" + CHR(13) + ;
						 CapturarErroSQL(), "Erro SQL")
				loc_lContinua = .F.
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTdi")
					TABLEREVERT(.T., "cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdi")
				IF USED("cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir comissoes da tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTds")
					TABLEREVERT(.T., "cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTds")
				IF USED("cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir faixas de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				*-- Remove o registro principal
				loc_cSQL = "DELETE FROM SigOpTdz WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_Del")
					TABLEREVERT(.T., "cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
				IF USED("cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("DELETE")
					loc_lResultado = .T.
				ELSE
					MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComposicaoDesconto - SELECT das linhas de formula/tipo
	* (SigOpTdt) do codigo corrente, usadas como mestre pela grade
	* Gradei da pagina "Configuracao de Desconto" (somente leitura la) e
	* pela grade editavel Gradei da pagina "Descontos / Comissoes"
	* (grd_4c_Gradei em ConfigurarPgPgDesconto - fonte da verdade para
	* incluir/alterar/excluir linhas de composicao).
	* Popula cursor_4c_Tdt (READWRITE) com coluna virtual "regs" (flag
	* de linha corrente, equivalente ao "regs" do legado). Inclui TODAS
	* as colunas NOT NULL de SigOpTdt (cidchaves, formulas 1a/2a, moedas,
	* tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot) para
	* que SalvarComposicaoDesconto() consiga regravar a linha completa.
	*====================================================================
	FUNCTION CarregarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods, descos, dfators," + ;
					   " texclus, faixas, finicias, ffinals," + ;
					   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
					   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
					   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
					   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
					   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot" + ;
					   " FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_TdtTemp")
				USE IN cursor_4c_TdtTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TdtTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Tdt")
					USE IN cursor_4c_Tdt
				ENDIF

				SELECT 0 AS regs, * ;
					FROM cursor_4c_TdtTemp ;
					INTO CURSOR cursor_4c_Tdt READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_TdtTemp")
			USE IN cursor_4c_TdtTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarFaixasDesconto - SELECT de TODAS as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips+tipods da linha corrente
	* de cursor_4c_Tdt - mesmo padrao do legado (CrSigOpTds carregado 1x
	* no Init, filtrado via Set Key a cada troca de linha da grade mestre).
	* Popula cursor_4c_Tds (READWRITE).
	*====================================================================
	FUNCTION CarregarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods," + ;
					   " campo1is, campo1fs, campo2is, campo2fs," + ;
					   " campo3is, campo3fs, campo4is, campo4fs," + ;
					   " descos, dfators, nchvtbds" + ;
					   " FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips, tipods"

			IF USED("cursor_4c_Tds")
				USE IN cursor_4c_Tds
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tds")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- cursor_4c_Tds precisa ser READWRITE para APPEND/REPLACE feitos
		*-- na grade GradeD - o cursor de saida do SQLEXEC ja e editavel,
		*-- mas garantimos a existencia mesmo sem linhas retornadas
		IF loc_lResultado AND USED("cursor_4c_Tds") AND RECCOUNT("cursor_4c_Tds") = 0
			*-- SQLEXEC sem linhas ainda cria a estrutura do cursor - ok
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarFaixasDesconto - Grava (substitui) as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente a partir do conteudo atual
	* de cursor_4c_Tds. Estrategia DELETE + INSERT (mesmo padrao usado
	* em ExecutarExclusao para as sub-tabelas relacionadas).
	*====================================================================
	FUNCTION SalvarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tds")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdsSalvar")
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tds
			*-- O form filtra localmente (SET FILTER) pela combinacao
			*-- Tipo/Codigo/TipoDesconto exibida em grd_4c_GradeD - ao gravar
			*-- e preciso considerar TODAS as combinacoes, nao so a ultima
			*-- filtrada
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTds (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " campo1is, campo1fs, campo2is, campo2fs, campo3is, campo3fs," + ;
						   " campo4is, campo4fs, descos, dfators, nchvtbds) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tds.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipods, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2fs) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3is) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4fs) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.dfators, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.nchvtbds, 0) + ")"

				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTds")
				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar faixa de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComissoesDesconto - SELECT de TODAS as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips da linha corrente de
	* cursor_4c_Tdt (grd_4c_Gradei da pagina "Descontos / Comissoes"),
	* mesmo padrao usado para cursor_4c_Tds (MontarConfiguracaoDesconto).
	* Popula cursor_4c_Tdi (READWRITE - saida do SQLEXEC ja e editavel).
	*====================================================================
	FUNCTION CarregarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, grupos, contas," + ;
					   " moedas, pintegrals, pdivididas, patendes" + ;
					   " FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_Tdi")
				USE IN cursor_4c_Tdi
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tdi")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComposicaoDesconto - Grava (substitui) as linhas de formula/
	* tipo (SigOpTdt) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdt (grd_4c_Gradei editavel da pagina "Descontos /
	* Comissoes"). Estrategia DELETE + INSERT (mesmo padrao de
	* SalvarFaixasDesconto). tpunidade/chkmultcot nao tem controle na UI
	* (sem uso no legado migrado) - gravados como 0.
	*====================================================================
	FUNCTION SalvarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdt")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdtSalvar")
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdt
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdt (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " descos, dfators, texclus, faixas, finicias, ffinals," + ;
						   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
						   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
						   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
						   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
						   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot)" + ;
						   " VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipods, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.dfators, 2) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.texclus) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.faixas, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.finicias, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.ffinals, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t1s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda1s) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t2s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda2s) + ", " + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.moeda3s, "")) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tpcomis, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.descfats) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.fatorpads, 3) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.chkcots, 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.tpunidade, 0), 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.chkmultcot, 0), 0) + ")"

				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdt")
				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar linha de composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComissoesDesconto - Grava (substitui) as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdi (grd_4c_Gradec da pagina "Descontos / Comissoes").
	* Estrategia DELETE + INSERT (mesmo padrao de SalvarFaixasDesconto).
	*====================================================================
	FUNCTION SalvarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdi")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdiSalvar")
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdi
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdi (cidchaves, codigos, tipos, codtips," + ;
						   " grupos, contas, moedas, pintegrals, pdivididas, patendes) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdi.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.codtips) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.grupos) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.contas) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.moedas) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pintegrals, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pdivididas, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.patendes, 2) + ")"

				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdi")
				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar comiss" + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

ENDDEFINE

