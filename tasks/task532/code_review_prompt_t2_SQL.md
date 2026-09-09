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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTbv.prg) - TRECHOS RELEVANTES PARA PASS SQL (4227 linhas total):

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

*-- Linhas 385 a 418:
385:                     USE IN cursor_4c_Dados
386:                 ENDIF
387:                 SET NULL ON
388:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(30), moerefs C(3), descos N(5,2))
389:                 INSERT INTO cursor_4c_Dados VALUES ("0000000001", "Tabela Teste", "REA", 0)
390:                 SET NULL OFF
391:                 SET DATASESSION TO (loc_nDsAtual)
392:                 loc_lResultado = .T.
393:             ELSE
394:                 IF THIS.this_oBusinessObject.Buscar("")
395:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
396: 
397:                     loc_oGrid.ColumnCount   = 4
398:                     loc_oGrid.RecordSource  = "cursor_4c_Dados"
399: 
400:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
401:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
402:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.moerefs"
403:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descos"
404: 
405:                     loc_oGrid.Column1.Width         = 110
406:                     loc_oGrid.Column2.Width         = 480
407:                     loc_oGrid.Column3.Width         = 100
408:                     loc_oGrid.Column4.Width         = 130
409: 
410:                     loc_oGrid.Column1.ReadOnly      = .T.
411:                     loc_oGrid.Column2.ReadOnly      = .T.
412:                     loc_oGrid.Column3.ReadOnly      = .T.
413:                     loc_oGrid.Column4.ReadOnly      = .T.
414: 
415:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
416:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
417:                     loc_oGrid.Column3.Header1.Caption = "Moeda Ref" + CHR(234) + "ncia"
418:                     loc_oGrid.Column4.Header1.Caption = "Desconto (%)"

*-- Linhas 1241 a 1259:
1241:             .Height       = 90
1242:             .FontName     = "Verdana"
1243:             .FontSize     = 8
1244:             .DeleteMark   = .F.
1245:             .RecordMark   = .F.
1246:             .GridLines    = 3
1247:             .HeaderHeight = 0
1248:             .RowHeight    = 18
1249:             .ScrollBars   = 2
1250:             .Visible      = .T.
1251:         ENDWITH
1252: 
1253:         WITH loc_oGridEmp.Column1
1254:             .Width    = 30
1255:             .Sparse   = .F.
1256:             .ReadOnly = .F.
1257:         ENDWITH
1258:         loc_oGridEmp.Column1.Header1.Caption = ""
1259:         loc_oGridEmp.Column1.AddObject("chk_4c_Marca", "CheckBox")

*-- Linhas 1357 a 1375:
1357:         *-- Registros excluidos da grade de faixas (BtnExcluirFaixaDescontoClick)
1358:         *-- nao devem reaparecer - DataSession=2 (privado) isola este SET do
1359:         *-- resto do sistema (CLAUDE.md #9.4)
1360:         SET DELETED ON
1361: 
1362:         THIS.CriarCursorDiaSemana()
1363: 
1364:         loc_oPg.AddObject("cnt_4c_PgConfDesconto", "Container")
1365:         WITH loc_oPg.cnt_4c_PgConfDesconto
1366:             .Top       = 151
1367:             .Left      = -1
1368:             .Width     = 1004
1369:             .Height    = 482
1370:             .BackStyle = 0
1371:             .Visible   = .T.
1372:         ENDWITH
1373: 
1374:         *----------------------------------------------------------------------
1375:         * Rotulos de cabecalho das colunas (Label1/Label2/lb_desconto)

*-- Linhas 1515 a 1533:
1515:         *----------------------------------------------------------------------
1516:         * grd_4c_GradeD - grade de detalhe (espelha SigOpTds da combinacao
1517:         * selecionada em grd_4c_GradeI). Colunas 1/2 (Inicial/Final) tem
1518:         * ControlSource/InputMask reconfigurados dinamicamente por
1519:         * MontarConfiguracaoDesconto() conforme o Tipo de Desconto (dia da
1520:         * semana/dia do mes/horario/data). Colunas 3/4 sao a faixa de
1521:         * horario dentro do dia (sempre Campo2is/Campo2fs); 5/6 sao
1522:         * Preco/Fator.
1523:         *----------------------------------------------------------------------
1524:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("grd_4c_GradeD", "Grid")
1525:         loc_oGradeD = loc_oPg.cnt_4c_PgConfDesconto.grd_4c_GradeD
1526:         loc_oGradeD.RecordSource = ""
1527:         loc_oGradeD.ColumnCount  = 6
1528:         WITH loc_oGradeD
1529:             .Top        = 26
1530:             .Left       = 462
1531:             .Width      = 358
1532:             .Height     = 419
1533:             .FontName   = "Verdana"

*-- Linhas 1570 a 1630:
1570:             .Width             = 40
1571:             .Header1.Caption   = "Inicial"
1572:             .Header1.Alignment = 2
1573:             .Header1.FontName  = "Verdana"
1574:             .Header1.FontSize  = 8
1575:             .ControlSource     = "cursor_4c_Tds.Campo2is"
1576:             .Format            = "R"
1577:             .InputMask         = "99:99"
1578:             .Text1.InputMask   = "99:99"
1579:         ENDWITH
1580:         BINDEVENT(loc_oGradeD.Column3.Text1, "When", THIS, "GradeDColumn3When")
1581:         BINDEVENT(loc_oGradeD.Column3.Text1, "Valid", THIS, "GradeDColumn3Valid")
1582: 
1583:         WITH loc_oGradeD.Column4
1584:             .Width             = 40
1585:             .Header1.Caption   = "Final"
1586:             .Header1.Alignment = 2
1587:             .Header1.FontName  = "Verdana"
1588:             .Header1.FontSize  = 8
1589:             .ControlSource     = "cursor_4c_Tds.Campo2fs"
1590:             .Format            = "R"
1591:             .InputMask         = "99:99"
1592:             .Text1.InputMask   = "99:99"
1593:         ENDWITH
1594:         BINDEVENT(loc_oGradeD.Column4.Text1, "When", THIS, "GradeDColumn4When")
1595:         BINDEVENT(loc_oGradeD.Column4.Text1, "Valid", THIS, "GradeDColumn4Valid")
1596: 
1597:         WITH loc_oGradeD.Column5
1598:             .Width             = 48
1599:             .Header1.Caption   = "Pre" + CHR(231) + "o"
1600:             .Header1.Alignment = 2
1601:             .Header1.FontName  = "Verdana"
1602:             .Header1.FontSize  = 8
1603:             .ControlSource     = "cursor_4c_Tds.descos"
1604:             .InputMask         = "999.99"
1605:             .Text1.InputMask   = "999.99"
1606:         ENDWITH
1607:         BINDEVENT(loc_oGradeD.Column5.Text1, "When", THIS, "GradeDColumn5When")
1608: 
1609:         WITH loc_oGradeD.Column6
1610:             .Width             = 46
1611:             .Header1.Caption   = "Fator"
1612:             .Header1.Alignment = 2
1613:             .Header1.FontName  = "Verdana"
1614:             .Header1.FontSize  = 8
1615:             .ControlSource     = "cursor_4c_Tds.dfators"
1616:             .InputMask         = "999.99"
1617:             .Text1.InputMask   = "999.99"
1618:         ENDWITH
1619:         BINDEVENT(loc_oGradeD.Column6.Text1, "When", THIS, "GradeDColumn5When")
1620:         BINDEVENT(loc_oGradeD.Column6.Text1, "Valid", THIS, "GradeDColumn6Valid")
1621: 
1622:         *----------------------------------------------------------------------
1623:         * cmdExcluir - remove a faixa corrente de grd_4c_GradeD
1624:         *----------------------------------------------------------------------
1625:         loc_oPg.cnt_4c_PgConfDesconto.AddObject("cmd_4c_CmdExcluir", "CommandButton")
1626:         WITH loc_oPg.cnt_4c_PgConfDesconto.cmd_4c_CmdExcluir
1627:             .Caption         = ""
1628:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1629:             .ToolTipText     = "Excluir"
1630:             .PicturePosition = 1

*-- Linhas 1651 a 1677:
1651:     * (Tipo/Codigo/Valor/Fator/Exclui/Faixa/Inicial/Final). E a MESMA
1652:     * cursor_4c_Tdt usada (somente leitura) por grd_4c_GradeI da pagina
1653:     * "Configuracao de Desconto" (ConfigurarPgPgConfDesconto).
1654:     *
1655:     * grd_4c_Gradec (6 colunas) mostra as comissoes por grupo/conta
1656:     * (SigOpTdi via cursor_4c_Tdi) da linha corrente de grd_4c_Gradei
1657:     * (filtro local via MontarComissoesDesconto - equivalente ao
1658:     * "MontaTbCom" do legado).
1659:     *
1660:     * cnt_4c_Formula1/cnt_4c_Formula2 mostram a 1a/2a formula de calculo
1661:     * (Campo/Operador/Constante/Moeda) da linha corrente de grd_4c_Gradei,
1662:     * bindados diretamente via ControlSource a cursor_4c_Tdt (mesmo padrao
1663:     * usado pelas colunas de grd_4c_GradeD em ConfigurarPgPgConfDesconto).
1664:     *--------------------------------------------------------------------------
1665:     PROTECTED PROCEDURE ConfigurarPgPgDesconto()
1666:         LOCAL loc_oPg, loc_oCnt, loc_oGradei, loc_oGradec, loc_oF1, loc_oF2
1667: 
1668:         loc_oPg = THIS.pgf_4c_Paginas.Page2
1669: 
1670:         loc_oPg.AddObject("cnt_4c_PgDesconto", "Container")
1671:         loc_oCnt = loc_oPg.cnt_4c_PgDesconto
1672:         WITH loc_oCnt
1673:             .Top       = 151
1674:             .Left      = -1
1675:             .Width     = 1004
1676:             .Height    = 482
1677:             .BackStyle = 0

*-- Linhas 1965 a 1985:
1965:             .Visible   = .T.
1966:         ENDWITH
1967: 
1968:         *----------------------------------------------------------------------
1969:         * grd_4c_Gradec - comissoes por grupo/conta da linha corrente de
1970:         * grd_4c_Gradei (cursor_4c_Tdi filtrado localmente)
1971:         *----------------------------------------------------------------------
1972:         loc_oCnt.AddObject("grd_4c_Gradec", "Grid")
1973:         loc_oGradec = loc_oCnt.grd_4c_Gradec
1974:         loc_oGradec.RecordSource = ""
1975:         loc_oGradec.ColumnCount  = 6
1976:         WITH loc_oGradec
1977:             .Top       = 16
1978:             .Left      = 575
1979:             .Width     = 422
1980:             .Height    = 279
1981:             .FontName  = "Verdana"
1982:             .FontSize  = 8
1983:             .RowHeight = 20
1984:             .RecordMark = .F.
1985:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 2050 a 2070:
2050:             .Text1.ForeColor   = RGB(0, 0, 0)
2051:             .Text1.BackColor   = RGB(255, 255, 255)
2052:         ENDWITH
2053: 
2054:         *----------------------------------------------------------------------
2055:         * Inscomis/exccomis - incluem/removem comissoes (cursor_4c_Tdi)
2056:         *----------------------------------------------------------------------
2057:         loc_oCnt.AddObject("cmd_4c_InserirComissao", "CommandButton")
2058:         WITH loc_oCnt.cmd_4c_InserirComissao
2059:             .Caption   = ""
2060:             .Picture   = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2061:             .Top       = 296
2062:             .Left      = 577
2063:             .Width     = 40
2064:             .Height    = 40
2065:             .BackColor = RGB(255, 255, 255)
2066:             .ForeColor = RGB(36, 84, 155)
2067:             .FontName  = "Verdana"
2068:             .FontSize  = 8
2069:             .FontBold  = .T.
2070:             .Themes    = .F.

*-- Linhas 2118 a 2136:
2118:             .Style          = 2
2119:             .RowSourceType  = 1
2120:             .RowSource      = "Normal,Pelo Custo,Pelo Feitio"
2121:             .ControlSource  = "cursor_4c_Tdt.tpcomis"
2122:             .FontName       = "Tahoma"
2123:             .FontSize       = 8
2124:             .Visible        = .T.
2125:         ENDWITH
2126: 
2127:         loc_oCnt.AddObject("lbl_4c_DescritivoFator", "Label")
2128:         WITH loc_oCnt.lbl_4c_DescritivoFator
2129:             .Caption   = "Descritivo de Fator :"
2130:             .Top       = 342
2131:             .Left      = 20
2132:             .Width     = 115
2133:             .Height    = 15
2134:             .BackStyle = 0
2135:             .FontName  = "Tahoma"
2136:             .FontSize  = 8

*-- Linhas 2146 a 2164:
2146:             .Width         = 80
2147:             .Height        = 18
2148:             .MaxLength     = 10
2149:             .ControlSource = "cursor_4c_Tdt.descfats"
2150:             .FontName      = "Tahoma"
2151:             .FontSize      = 8
2152:             .Visible       = .T.
2153:         ENDWITH
2154: 
2155:         loc_oCnt.AddObject("lbl_4c_FatorPadrao", "Label")
2156:         WITH loc_oCnt.lbl_4c_FatorPadrao
2157:             .Caption   = "Fator Padr" + CHR(227) + "o :"
2158:             .Top       = 341
2159:             .Left      = 270
2160:             .Width     = 81
2161:             .Height    = 15
2162:             .BackStyle = 0
2163:             .FontName  = "Tahoma"
2164:             .FontSize  = 8

*-- Linhas 2175 a 2208:
2175:             .Height        = 23
2176:             .InputMask     = "9999.999"
2177:             .Alignment     = 1
2178:             .ControlSource = "cursor_4c_Tdt.fatorpads"
2179:             .FontName      = "Tahoma"
2180:             .FontSize      = 8
2181:             .Visible       = .T.
2182:         ENDWITH
2183: 
2184:         loc_oCnt.AddObject("chk_4c_IgnoraCotacao", "CheckBox")
2185:         WITH loc_oCnt.chk_4c_IgnoraCotacao
2186:             .Caption       = "Ignora cota" + CHR(231) + CHR(227) + "o"
2187:             .Top           = 401
2188:             .Left          = 836
2189:             .Width         = 105
2190:             .Height        = 15
2191:             .Alignment     = 0
2192:             .BackStyle     = 0
2193:             .ControlSource = "cursor_4c_Tdt.chkcots"
2194:             .ToolTipText   = "Faz os c" + CHR(225) + "lculos sem usar a cota" + CHR(231) + CHR(227) + "o da moeda"
2195:             .FontName      = "Verdana"
2196:             .FontSize      = 8
2197:             .ForeColor     = RGB(90, 90, 90)
2198:             .Themes        = .F.
2199:             .Visible       = .T.
2200:         ENDWITH
2201: 
2202:         THIS.TornarControlesVisiveis(loc_oCnt)
2203:     ENDPROC
2204: 
2205:     *--------------------------------------------------------------------------
2206:     * ConfigurarFormulaDesconto - Cria os controles de uma formula (1a/2a)
2207:     * dentro do container informado, bindados a cursor_4c_Tdt.*<sufixo>
2208:     * (sufixo "t1s" ou "t2s"). Espelha o container F?rmula1/F?rmula2 do

*-- Linhas 2238 a 2368:
2238:                 .SpecialEffect = 1
2239:                 .RowSourceType = 1
2240:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2241:                 .ControlSource = "cursor_4c_Tdt.campo1" + par_cSufixo
2242:                 .BackColor     = RGB(220, 211, 194)
2243:                 .FontName      = "Tahoma"
2244:                 .FontSize      = 8
2245:                 .Visible       = .T.
2246:             ENDWITH
2247: 
2248:             .AddObject("cbo_4c_Oper1", "ComboBox")
2249:             WITH .cbo_4c_Oper1
2250:                 .Top           = 7
2251:                 .Left          = 283
2252:                 .Width         = 39
2253:                 .Height        = 24
2254:                 .Style         = 2
2255:                 .SpecialEffect = 1
2256:                 .RowSourceType = 1
2257:                 .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
2258:                 .ControlSource = "cursor_4c_Tdt.oper1" + par_cSufixo
2259:                 .BackColor     = RGB(253, 250, 185)
2260:                 .FontName      = "Tahoma"
2261:                 .FontSize      = 12
2262:                 .FontBold      = .T.
2263:                 .Visible       = .T.
2264:             ENDWITH
2265: 
2266:             .AddObject("txt_4c_Const1", "TextBox")
2267:             WITH .txt_4c_Const1
2268:                 .Top           = 7
2269:                 .Left          = 236
2270:                 .Width         = 36
2271:                 .Height        = 24
2272:                 .MaxLength     = 3
2273:                 .ControlSource = "cursor_4c_Tdt.const1" + par_cSufixo
2274:                 .BackColor     = RGB(202, 255, 224)
2275:                 .FontName      = "Tahoma"
2276:                 .FontSize      = 8
2277:                 .Visible       = .T.
2278:             ENDWITH
2279: 
2280:             .AddObject("cbo_4c_Campo2", "ComboBox")
2281:             WITH .cbo_4c_Campo2
2282:                 .Top           = 7
2283:                 .Left          = 330
2284:                 .Width         = 127
2285:                 .Height        = 24
2286:                 .Style         = 2
2287:                 .SpecialEffect = 1
2288:                 .RowSourceType = 1
2289:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2290:                 .ControlSource = "cursor_4c_Tdt.campo2" + par_cSufixo
2291:                 .BackColor     = RGB(220, 211, 194)
2292:                 .FontName      = "Tahoma"
2293:                 .FontSize      = 8
2294:                 .Visible       = .T.
2295:             ENDWITH
2296: 
2297:             .AddObject("cbo_4c_Oper2", "ComboBox")
2298:             WITH .cbo_4c_Oper2
2299:                 .Top           = 7
2300:                 .Left          = 468
2301:                 .Width         = 39
2302:                 .Height        = 24
2303:                 .Style         = 2
2304:                 .SpecialEffect = 1
2305:                 .RowSourceType = 1
2306:                 .RowSource     = ",+,-," + CHR(215) + "," + CHR(247)
2307:                 .ControlSource = "cursor_4c_Tdt.oper2" + par_cSufixo
2308:                 .BackColor     = RGB(253, 250, 185)
2309:                 .FontName      = "Tahoma"
2310:                 .FontSize      = 12
2311:                 .FontBold      = .T.
2312:                 .Visible       = .T.
2313:             ENDWITH
2314: 
2315:             .AddObject("txt_4c_Const2", "TextBox")
2316:             WITH .txt_4c_Const2
2317:                 .Top           = 7
2318:                 .Left          = 421
2319:                 .Width         = 36
2320:                 .Height        = 24
2321:                 .MaxLength     = 3
2322:                 .ControlSource = "cursor_4c_Tdt.const2" + par_cSufixo
2323:                 .BackColor     = RGB(202, 255, 224)
2324:                 .FontName      = "Tahoma"
2325:                 .FontSize      = 8
2326:                 .Visible       = .T.
2327:             ENDWITH
2328: 
2329:             .AddObject("cbo_4c_Campo3", "ComboBox")
2330:             WITH .cbo_4c_Campo3
2331:                 .Top           = 7
2332:                 .Left          = 517
2333:                 .Width         = 127
2334:                 .Height        = 24
2335:                 .Style         = 2
2336:                 .SpecialEffect = 1
2337:                 .RowSourceType = 1
2338:                 .RowSource     = "Nenhum,Peso,Fator,Pre" + CHR(231) + "o,Constante,Quantidade,Comprimento"
2339:                 .ControlSource = "cursor_4c_Tdt.campo3" + par_cSufixo
2340:                 .BackColor     = RGB(220, 211, 194)
2341:                 .FontName      = "Tahoma"
2342:                 .FontSize      = 8
2343:                 .Visible       = .T.
2344:             ENDWITH
2345: 
2346:             .AddObject("txt_4c_Const3", "TextBox")
2347:             WITH .txt_4c_Const3
2348:                 .Top           = 7
2349:                 .Left          = 608
2350:                 .Width         = 36
2351:                 .Height        = 24
2352:                 .MaxLength     = 3
2353:                 .ControlSource = "cursor_4c_Tdt.const3" + par_cSufixo
2354:                 .BackColor     = RGB(202, 255, 224)
2355:                 .FontName      = "Tahoma"
2356:                 .FontSize      = 8
2357:                 .Visible       = .T.
2358:             ENDWITH
2359: 
2360:             .AddObject("lbl_4c_MoedaConversao", "Label")
2361:             WITH .lbl_4c_MoedaConversao
2362:                 .Caption   = "Moeda de Convers" + CHR(227) + "o :"
2363:                 .Top       = 12
2364:                 .Left      = 662
2365:                 .Width     = 126
2366:                 .Height    = 15
2367:                 .BackStyle = 0
2368:                 .FontName  = "Tahoma"

*-- Linhas 2379 a 2397:
2379:                 .Width         = 40
2380:                 .Height        = 24
2381:                 .MaxLength     = 3
2382:                 .ControlSource = "cursor_4c_Tdt.moeda" + IIF(par_cSufixo = "t1s", "1s", "2s")
2383:                 .BackColor     = RGB(207, 241, 241)
2384:                 .FontName      = "Tahoma"
2385:                 .FontSize      = 8
2386:                 .Visible       = .T.
2387:             ENDWITH
2388:         ENDWITH
2389:     ENDPROC
2390: 
2391:     *--------------------------------------------------------------------------
2392:     * FormParaBO - Transfere dados do Form para Business Object
2393:     *--------------------------------------------------------------------------
2394:     PROCEDURE FormParaBO()
2395:         LOCAL loc_oPg
2396: 
2397:         loc_oPg = THIS.pgf_4c_Paginas.Page2

*-- Linhas 2495 a 2527:
2495:             *-- Container de empresas: comeca oculto ate o usuario escolher tipo 11
2496:             loc_oPg2.cnt_4c_Container1.Visible  = .F.
2497:             IF USED("cursor_4c_Empresas")
2498:                 SELECT cursor_4c_Empresas
2499:                 REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2500:                 GO TOP IN cursor_4c_Empresas
2501:             ENDIF
2502: 
2503:             *-- Registro novo (INCLUIR) ainda nao tem composicao/comissoes/
2504:             *-- faixas de desconto cadastradas
2505:             IF USED("cursor_4c_Tdt")
2506:                 USE IN cursor_4c_Tdt
2507:             ENDIF
2508:             IF USED("cursor_4c_Tdi")
2509:                 USE IN cursor_4c_Tdi
2510:             ENDIF
2511:             IF USED("cursor_4c_Tds")
2512:                 USE IN cursor_4c_Tds
2513:             ENDIF
2514:             THIS.CarregarConfiguracaoDesconto()
2515:         CATCH TO loException
2516:             MostrarErro(loException, "FormTbv.LimparCampos")
2517:         ENDTRY
2518:     ENDPROC
2519: 
2520:     *--------------------------------------------------------------------------
2521:     * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
2522:     *--------------------------------------------------------------------------
2523:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2524:         LOCAL loc_oPg2, loc_lCodHabilitar
2525:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2526: 
2527:         TRY

*-- Linhas 2642 a 2660:
2642:             RETURN loc_lResultado
2643:         ENDIF
2644: 
2645:         SELECT cursor_4c_Dados
2646:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2647: 
2648:         TRY
2649:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2650:                 THIS.BOParaForm()
2651:                 THIS.this_cModoAtual = "VISUALIZAR"
2652:                 THIS.HabilitarCampos(.F.)
2653:                 THIS.AjustarBotoesPorModo()
2654:                 THIS.AlternarPagina(2)
2655:                 loc_lResultado = .T.
2656:             ENDIF
2657:         CATCH TO loException
2658:             MostrarErro(loException, "FormTbv.BtnVisualizarClick")
2659:             loc_lResultado = .F.
2660:         ENDTRY

*-- Linhas 2675 a 2693:
2675:             RETURN loc_lResultado
2676:         ENDIF
2677: 
2678:         SELECT cursor_4c_Dados
2679:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2680: 
2681:         TRY
2682:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2683:                 THIS.this_oBusinessObject.EditarRegistro()
2684:                 THIS.BOParaForm()
2685:                 THIS.this_cModoAtual = "ALTERAR"
2686:                 THIS.HabilitarCampos(.T.)
2687:                 THIS.AjustarBotoesPorModo()
2688:                 THIS.AlternarPagina(2)
2689:                 loc_lResultado = .T.
2690:             ENDIF
2691:         CATCH TO loException
2692:             MostrarErro(loException, "FormTbv.BtnAlterarClick")
2693:             loc_lResultado = .F.

*-- Linhas 2710 a 2728:
2710:             RETURN loc_lResultado
2711:         ENDIF
2712: 
2713:         SELECT cursor_4c_Dados
2714:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
2715: 
2716:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2717:             RETURN loc_lResultado
2718:         ENDIF
2719: 
2720:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da tabela de desconto " + loc_cCodigo + "?", "Excluir")
2721:             RETURN loc_lResultado
2722:         ENDIF
2723: 
2724:         TRY
2725:             IF THIS.this_oBusinessObject.Excluir()
2726:                 MsgInfo("Tabela de desconto exclu" + CHR(237) + "da com sucesso!")
2727:                 THIS.CarregarLista()
2728:                 loc_lResultado = .T.

*-- Linhas 2740 a 2758:
2740:     *--------------------------------------------------------------------------
2741:     * BtnBuscarClick - Prepara Page2 em modo BUSCAR (localizar registro ja
2742:     * carregado na lista por codigo ou descricao), reproduzindo o Busca=1/
2743:     * Busca=2 do legado (Select CrSigOpTdz / Seek por Codigos ou Descrs)
2744:     * PUBLIC: BINDEVENT requer metodo publico
2745:     *--------------------------------------------------------------------------
2746:     PROCEDURE BtnBuscarClick()
2747:         LOCAL loc_lResultado
2748:         loc_lResultado = .F.
2749: 
2750:         TRY
2751:             THIS.this_oBusinessObject.NovoRegistro()
2752:             THIS.LimparCampos()
2753:             THIS.this_cModoAtual = "BUSCAR"
2754:             THIS.HabilitarCampos(.T.)
2755:             THIS.AjustarBotoesPorModo()
2756:             THIS.AlternarPagina(2)
2757:             loc_lResultado = .T.
2758:         CATCH TO loException

*-- Linhas 2805 a 2823:
2805:                 THIS.this_cModoAtual = "LISTA"
2806:                 THIS.AlternarPagina(1)
2807:                 IF USED("cursor_4c_Dados")
2808:                     SELECT cursor_4c_Dados
2809:                     IF !EMPTY(loc_cCodBusca)
2810:                         LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
2811:                     ELSE
2812:                         IF !EMPTY(loc_cDescBusca)
2813:                             LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descrs)) = UPPER(loc_cDescBusca)
2814:                         ENDIF
2815:                     ENDIF
2816:                 ENDIF
2817:                 loc_lResultado = .T.
2818:             ELSE
2819:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2820:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(loc_oPg2.txt_4c__codigos.Value))
2821:                         MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!", "")
2822:                         THIS.this_oBusinessObject.NovoRegistro()
2823:                         loc_oPg2.txt_4c__codigos.SetFocus

*-- Linhas 2878 a 2974:
2878: 
2879:     *--------------------------------------------------------------------------
2880:     * CriarCursorTipoDesconto - Cria cursor local (lista fixa) para cbo_4c_CmbTpDesc
2881:     * Legado: Create Cursor crTpDesc (Descrs c(40), ordem N(2,0)) no Init()
2882:     *--------------------------------------------------------------------------
2883:     PROTECTED PROCEDURE CriarCursorTipoDesconto()
2884:         IF USED("cursor_4c_TipoDesconto")
2885:             RETURN
2886:         ENDIF
2887: 
2888:         SET NULL ON
2889:         CREATE CURSOR cursor_4c_TipoDesconto (Descrs C(40), Ordem N(2, 0))
2890:         SET NULL OFF
2891:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("1-Anivers" + CHR(225) + "rio", 1)
2892:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("2-Desconto Vendedor", 2)
2893:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("3-Desconto Gerente-Grupo", 3)
2894:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("4-Desconto Gerente-Lancamento", 4)
2895:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("5-Desconto Gerente-qq pe" + CHR(231) + "a", 5)
2896:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("6-Troca Zerada", 6)
2897:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("7-Troca Upgrade", 7)
2898:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("8-Desconto Supervisor", 8)
2899:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("9-Desconto Diretoria", 9)
2900:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("10-Troca Up Alianca", 10)
2901:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("11-Desconto Gerente-Extra/loja", 11)
2902:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("12-Desconto Gerente-Brinde", 12)
2903:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES ("13-Desconto Gerente-Troca de pre" + CHR(231) + "o", 13)
2904:         INSERT INTO cursor_4c_TipoDesconto (Descrs, Ordem) VALUES (SPACE(40), 0)
2905:         GO TOP IN cursor_4c_TipoDesconto
2906:     ENDPROC
2907: 
2908:     *--------------------------------------------------------------------------
2909:     * TipoDescontoInteractiveChange - Mostra/oculta a lista de empresas conforme
2910:     * o tipo de desconto selecionado (11 = Desconto Gerente-Extra/loja)
2911:     * PUBLIC: BINDEVENT requer metodo publico
2912:     *--------------------------------------------------------------------------
2913:     PROCEDURE TipoDescontoInteractiveChange()
2914:         LOCAL loc_oPg, loc_lMostrarEmpresas
2915: 
2916:         loc_oPg = THIS.pgf_4c_Paginas.Page2
2917:         loc_lMostrarEmpresas = (loc_oPg.cbo_4c_CmbTpDesc.Value = 11)
2918: 
2919:         loc_oPg.cnt_4c_Container1.Visible = loc_lMostrarEmpresas
2920: 
2921:         IF !loc_lMostrarEmpresas AND USED("cursor_4c_Empresas")
2922:             SELECT cursor_4c_Empresas
2923:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
2924:             GO TOP IN cursor_4c_Empresas
2925:             IF PEMSTATUS(loc_oPg.cnt_4c_Container1, "grd_4c_Empresas", 5)
2926:                 loc_oPg.cnt_4c_Container1.grd_4c_Empresas.Refresh()
2927:             ENDIF
2928:         ENDIF
2929:     ENDPROC
2930: 
2931:     *--------------------------------------------------------------------------
2932:     * CarregarGradeEmpresas - Carrega grade de empresas (SigCdEmp) e marca as
2933:     * empresas presentes em this_cListaEmpresas (formato ";EMP1;EMP2;...")
2934:     *--------------------------------------------------------------------------
2935:     PROCEDURE CarregarGradeEmpresas()
2936:         LOCAL loc_lResultado, loc_oGrid, loc_cListaEmpresas
2937: 
2938:         loc_lResultado = .F.
2939: 
2940:         TRY
2941:             IF THIS.this_oBusinessObject.CarregarEmpresas()
2942:                 loc_cListaEmpresas = THIS.this_oBusinessObject.this_cListaEmpresas
2943: 
2944:                 SELECT cursor_4c_Empresas
2945:                 SCAN
2946:                     IF !EMPTY(ALLTRIM(cursor_4c_Empresas.cemps)) AND ALLTRIM(cursor_4c_Empresas.cemps) $ loc_cListaEmpresas
2947:                         REPLACE nMarca WITH 1 IN cursor_4c_Empresas
2948:                     ELSE
2949:                         REPLACE nMarca WITH 0 IN cursor_4c_Empresas
2950:                     ENDIF
2951:                 ENDSCAN
2952:                 GO TOP IN cursor_4c_Empresas
2953: 
2954:                 *-- NAO reatribuir ColumnCount aqui: destruiria o chk_4c_Marca
2955:                 *-- (AddObject em Column1) criado em ConfigurarPaginaDados (Pattern #183)
2956:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas
2957:                 loc_oGrid.RecordSource = "cursor_4c_Empresas"
2958:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Empresas.nMarca"
2959:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Empresas.cemps"
2960:                 loc_oGrid.Column1.Header1.Caption = ""
2961:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2962:                 loc_oGrid.Column1.Width  = 30
2963:                 loc_oGrid.Column2.Width  = 190
2964:                 loc_oGrid.Column1.CurrentControl = "chk_4c_Marca"
2965:                 loc_oGrid.Column2.ReadOnly = .T.
2966:                 loc_oGrid.Refresh()
2967: 
2968:                 loc_lResultado = .T.
2969:             ENDIF
2970:         CATCH TO loException
2971:             MostrarErro(loException, "FormTbv.CarregarGradeEmpresas")
2972:             loc_lResultado = .F.
2973:         ENDTRY
2974: 

*-- Linhas 2985 a 3049:
2985:         loc_cLista = ""
2986: 
2987:         IF USED("cursor_4c_Empresas")
2988:             SELECT cursor_4c_Empresas
2989:             GO TOP
2990:             SCAN
2991:                 IF cursor_4c_Empresas.nMarca = 1
2992:                     loc_cLista = loc_cLista + ";" + ALLTRIM(cursor_4c_Empresas.cemps)
2993:                 ENDIF
2994:             ENDSCAN
2995:         ENDIF
2996: 
2997:         RETURN loc_cLista
2998:     ENDPROC
2999: 
3000:     *--------------------------------------------------------------------------
3001:     * BtnEmpresasDesmarcarClick - Desmarca todas as empresas da grade
3002:     * PUBLIC: BINDEVENT requer metodo publico
3003:     *--------------------------------------------------------------------------
3004:     PROCEDURE BtnEmpresasDesmarcarClick()
3005:         IF USED("cursor_4c_Empresas")
3006:             SELECT cursor_4c_Empresas
3007:             REPLACE ALL nMarca WITH 0 IN cursor_4c_Empresas
3008:             GO TOP IN cursor_4c_Empresas
3009:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3010:         ENDIF
3011:     ENDPROC
3012: 
3013:     *--------------------------------------------------------------------------
3014:     * BtnEmpresasMarcarClick - Marca todas as empresas da grade
3015:     * PUBLIC: BINDEVENT requer metodo publico
3016:     *--------------------------------------------------------------------------
3017:     PROCEDURE BtnEmpresasMarcarClick()
3018:         IF USED("cursor_4c_Empresas")
3019:             SELECT cursor_4c_Empresas
3020:             REPLACE ALL nMarca WITH 1 IN cursor_4c_Empresas
3021:             GO TOP IN cursor_4c_Empresas
3022:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3023:         ENDIF
3024:     ENDPROC
3025: 
3026:     *--------------------------------------------------------------------------
3027:     * EmpresaCheckboxMouseDown - Toggle nMarca em cursor_4c_Empresas via mouse
3028:     * Grid nao alterna CheckBox pelo binding nativo (campo numerico) - alterna
3029:     * manualmente e suprime o toggle padrao com NODEFAULT
3030:     * PUBLIC: BINDEVENT requer metodo publico
3031:     *--------------------------------------------------------------------------
3032:     PROCEDURE EmpresaCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3033:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3034:             SELECT cursor_4c_Empresas
3035:             REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3036:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3037:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3038:             ENDIF
3039:         ENDIF
3040:         NODEFAULT
3041:     ENDPROC
3042: 
3043:     *--------------------------------------------------------------------------
3044:     * EmpresaCheckboxMouseUp - Suprime comportamento padrao
3045:     * PUBLIC: BINDEVENT requer metodo publico
3046:     *--------------------------------------------------------------------------
3047:     PROCEDURE EmpresaCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
3048:         NODEFAULT
3049:     ENDPROC

*-- Linhas 3063 a 3081:
3063:     PROCEDURE EmpresaCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3064:         IF INLIST(par_nKeyCode, 13, 32)
3065:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("cursor_4c_Empresas") AND !EOF("cursor_4c_Empresas")
3066:                 SELECT cursor_4c_Empresas
3067:                 REPLACE nMarca WITH IIF(cursor_4c_Empresas.nMarca = 0, 1, 0) IN cursor_4c_Empresas
3068:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1, "grd_4c_Empresas", 5)
3069:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1.grd_4c_Empresas.Refresh()
3070:                 ENDIF
3071:             ENDIF
3072:             NODEFAULT
3073:         ENDIF
3074:     ENDPROC
3075: 
3076:     *--------------------------------------------------------------------------
3077:     * MoedaRefLookupKeyPress / MoedaRefLookupDblClick - F4/DblClick para
3078:     * lookup de Moeda de Referencia (SigCdMoe) em txt_4c__moerefs
3079:     * PUBLIC: BINDEVENT requer metodo publico
3080:     *--------------------------------------------------------------------------
3081:     PROCEDURE MoedaRefLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 3111 a 3129:
3111:                 ENDIF
3112: 
3113:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
3114:                     SELECT cursor_4c_BuscaMoeda
3115:                     loc_oPg.txt_4c__moerefs.Value      = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
3116:                     loc_oPg.txt_4c__moerefs_desc.Value = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
3117:                 ENDIF
3118: 
3119:                 loc_oBusca.Release()
3120:             ENDIF
3121:         CATCH TO loException
3122:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaRef")
3123:         ENDTRY
3124: 
3125:         IF USED("cursor_4c_BuscaMoeda")
3126:             USE IN cursor_4c_BuscaMoeda
3127:         ENDIF
3128:     ENDPROC
3129: 

*-- Linhas 3165 a 3218:
3165:                 ENDIF
3166: 
3167:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoedaFator")
3168:                     SELECT cursor_4c_BuscaMoedaFator
3169:                     loc_oPg.txt_4c_MoeFat.Value = ALLTRIM(cursor_4c_BuscaMoedaFator.cmoes)
3170:                 ENDIF
3171: 
3172:                 loc_oBusca.Release()
3173:             ENDIF
3174:         CATCH TO loException
3175:             MostrarErro(loException, "FormTbv.AbrirLookupMoedaFator")
3176:         ENDTRY
3177: 
3178:         IF USED("cursor_4c_BuscaMoedaFator")
3179:             USE IN cursor_4c_BuscaMoedaFator
3180:         ENDIF
3181:     ENDPROC
3182: 
3183:     *--------------------------------------------------------------------------
3184:     * CriarCursorDiaSemana - Cria cursor local (lista fixa) com os 7 dias da
3185:     * semana, usado na validacao de faixas de desconto por Dia da Semana
3186:     * Legado: Create Cursor DiaSemana (ndias n(1), Descrs c(7)) no Init()
3187:     *--------------------------------------------------------------------------
3188:     PROTECTED PROCEDURE CriarCursorDiaSemana()
3189:         IF USED("cursor_4c_DiaSemana")
3190:             RETURN
3191:         ENDIF
3192: 
3193:         SET NULL ON
3194:         CREATE CURSOR cursor_4c_DiaSemana (nDias N(1), Descrs C(7))
3195:         SET NULL OFF
3196:         INDEX ON Descrs TAG Descrs
3197:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (1, "DOMINGO")
3198:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (2, "SEGUNDA")
3199:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (3, "TERCA  ")
3200:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (4, "QUARTA ")
3201:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (5, "QUINTA ")
3202:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (6, "SEXTA  ")
3203:         INSERT INTO cursor_4c_DiaSemana (nDias, Descrs) VALUES (7, "SABADO ")
3204:         GO TOP IN cursor_4c_DiaSemana
3205:     ENDPROC
3206: 
3207:     *--------------------------------------------------------------------------
3208:     * CarregarConfiguracaoDesconto - Carrega grd_4c_GradeI (SigOpTdt) e
3209:     * grd_4c_GradeD (SigOpTds) do codigo corrente. Chamado por BOParaForm()
3210:     * ao entrar em ALTERAR/VISUALIZAR/EXCLUIR e por LimparCampos() (INCLUIR).
3211:     *--------------------------------------------------------------------------
3212:     PROCEDURE CarregarConfiguracaoDesconto()
3213:         LOCAL loc_oPgConf, loc_oPgDesc, loc_oGradei, loc_oGradeiDesc, loc_oGradec, loc_cCodigo
3214: 
3215:         TRY
3216:             loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3217:             loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3218:             loc_oGradei     = loc_oPgConf.grd_4c_GradeI

*-- Linhas 3235 a 3301:
3235:             THIS.this_oBusinessObject.CarregarFaixasDesconto(loc_cCodigo)
3236: 
3237:             loc_oGradei.RecordSource        = "cursor_4c_Tdt"
3238:             loc_oGradei.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3239:             loc_oGradei.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3240:             loc_oGradei.Column3.ControlSource = "cursor_4c_Tdt.tipods"
3241:             loc_oGradei.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3242:             loc_oGradei.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3243:             loc_oGradei.Refresh()
3244: 
3245:             *-- grd_4c_Gradei (pgDesconto) - MESMA cursor_4c_Tdt, colunas
3246:             *-- adicionais de valor/fator/exclui/faixa/inicial/final
3247:             loc_oGradeiDesc.RecordSource        = "cursor_4c_Tdt"
3248:             loc_oGradeiDesc.Column1.ControlSource = "cursor_4c_Tdt.tipos"
3249:             loc_oGradeiDesc.Column2.ControlSource = "cursor_4c_Tdt.codtips"
3250:             loc_oGradeiDesc.Column3.ControlSource = "cursor_4c_Tdt.descos"
3251:             loc_oGradeiDesc.Column4.ControlSource = "cursor_4c_Tdt.dfators"
3252:             loc_oGradeiDesc.Column5.ControlSource = "cursor_4c_Tdt.texclus"
3253:             loc_oGradeiDesc.Column6.ControlSource = "cursor_4c_Tdt.faixas"
3254:             loc_oGradeiDesc.Column7.ControlSource = "cursor_4c_Tdt.finicias"
3255:             loc_oGradeiDesc.Column8.ControlSource = "cursor_4c_Tdt.ffinals"
3256:             loc_oGradeiDesc.SetAll("DynamicBackColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(128,128,128), RGB(255,255,255))", "Column")
3257:             loc_oGradeiDesc.SetAll("DynamicForeColor", "IIF(cursor_4c_Tdt.regs = 1, RGB(255,255,255), RGB(0,0,0))", "Column")
3258:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180 -
3259:             *-- VFP pode resetar Header1.Caption ao reatribuir RecordSource)
3260:             loc_oGradeiDesc.Column1.Header1.Caption = "Tipo"
3261:             loc_oGradeiDesc.Column2.Header1.Caption = "C" + CHR(243) + "digo "
3262:             loc_oGradeiDesc.Column3.Header1.Caption = "Valor"
3263:             loc_oGradeiDesc.Column4.Header1.Caption = "Fator"
3264:             loc_oGradeiDesc.Column5.Header1.Caption = "E"
3265:             loc_oGradeiDesc.Column6.Header1.Caption = "Faixa"
3266:             loc_oGradeiDesc.Column7.Header1.Caption = "Inicial"
3267:             loc_oGradeiDesc.Column8.Header1.Caption = "Final"
3268:             loc_oGradeiDesc.Refresh()
3269: 
3270:             IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3271:                 SELECT cursor_4c_Tdt
3272:                 REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3273:                 REPLACE regs WITH 1 IN cursor_4c_Tdt
3274:                 GO TOP IN cursor_4c_Tdt
3275:             ENDIF
3276: 
3277:             *-- grd_4c_Gradec (comissoes) - filtrado pela linha corrente de
3278:             *-- cursor_4c_Tdt via MontarComissoesDesconto()
3279:             loc_oGradec.ColumnCount = 6
3280:             loc_oGradec.RecordSource        = "cursor_4c_Tdi"
3281:             loc_oGradec.Column1.ControlSource = "cursor_4c_Tdi.grupos"
3282:             loc_oGradec.Column2.ControlSource = "cursor_4c_Tdi.contas"
3283:             loc_oGradec.Column3.ControlSource = "cursor_4c_Tdi.pintegrals"
3284:             loc_oGradec.Column4.ControlSource = "cursor_4c_Tdi.pdivididas"
3285:             loc_oGradec.Column5.ControlSource = "cursor_4c_Tdi.patendes"
3286:             loc_oGradec.Column6.ControlSource = "cursor_4c_Tdi.moedas"
3287:             *-- Reaplica cabecalhos apos RecordSource (Problema 48/Pattern #180)
3288:             loc_oGradec.Column1.Header1.Caption = "Grupo"
3289:             loc_oGradec.Column2.Header1.Caption = "Conta"
3290:             loc_oGradec.Column3.Header1.Caption = "Integral"
3291:             loc_oGradec.Column4.Header1.Caption = "Dividida"
3292:             loc_oGradec.Column5.Header1.Caption = "Atendim"
3293:             loc_oGradec.Column6.Header1.Caption = "Moe"
3294: 
3295:             THIS.MontarConfiguracaoDesconto()
3296:             THIS.MontarComissoesDesconto()
3297:         CATCH TO loException
3298:             MostrarErro(loException, "FormTbv.CarregarConfiguracaoDesconto")
3299:         ENDTRY
3300:     ENDPROC
3301: 

*-- Linhas 3310 a 3328:
3310:             RETURN
3311:         ENDIF
3312: 
3313:         SELECT cursor_4c_Tdt
3314:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3315:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3316: 
3317:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3318:         THIS.MontarConfiguracaoDesconto()
3319:     ENDPROC
3320: 
3321:     *--------------------------------------------------------------------------
3322:     * GradeiConfColumn3When - habilita edicao da coluna "Tipos Desconto"
3323:     * apenas em INCLUIR/ALTERAR (equivalente ao When original)
3324:     * PUBLIC: BINDEVENT requer metodo publico
3325:     *--------------------------------------------------------------------------
3326:     PROCEDURE GradeiConfColumn3When()
3327:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3328:     ENDPROC

*-- Linhas 3343 a 3365:
3343:         ENDIF
3344:     ENDPROC
3345: 
3346:     *--------------------------------------------------------------------------
3347:     * MontarConfiguracaoDesconto - Equivalente ao "MontaTbDes" do legado.
3348:     * Filtra cursor_4c_Tds pela combinacao Tipo+Codigo+TipoDesconto da linha
3349:     * corrente de grd_4c_GradeI, cria a faixa inicial (00:00-23:59) quando
3350:     * ainda nao existe nenhuma, e reconfigura grd_4c_GradeD (ControlSource/
3351:     * InputMask das colunas Inicial/Final) conforme o Tipo de Desconto:
3352:     * 2=Dia da Semana, 3=Dia do Mes, 4=Horario, 5=Data
3353:     *--------------------------------------------------------------------------
3354:     PROTECTED PROCEDURE MontarConfiguracaoDesconto()
3355:         LOCAL loc_oGD, loc_oPgConf, loc_cCodigo, loc_nTipos, loc_cCodTips, ;
3356:               loc_nTipoDs, loc_cTitulo
3357: 
3358:         loc_oPgConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto
3359:         loc_oGD     = loc_oPgConf.grd_4c_GradeD
3360: 
3361:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3362:             loc_oGD.RecordSource = ""
3363:             loc_oGD.Enabled      = .F.
3364:             loc_oPgConf.lbl_4c_Lb_desconto.Caption = "Tipo de Desconto"
3365:             RETURN

*-- Linhas 3380 a 3441:
3380:             OTHERWISE
3381:                 loc_cTitulo = "Data"
3382:         ENDCASE
3383:         loc_oPgConf.lbl_4c_Lb_desconto.Caption = loc_cTitulo
3384: 
3385:         IF USED("cursor_4c_Tds")
3386:             SELECT cursor_4c_Tds
3387:             SET FILTER TO ALLTRIM(codigos) == loc_cCodigo AND tipos = loc_nTipos ;
3388:                 AND ALLTRIM(codtips) == loc_cCodTips AND tipods = loc_nTipoDs
3389:             GO TOP
3390:             IF EOF()
3391:                 APPEND BLANK
3392:                 REPLACE cidchaves WITH fUniqueIds(), ;
3393:                         codigos   WITH loc_cCodigo, ;
3394:                         tipos     WITH loc_nTipos, ;
3395:                         codtips   WITH loc_cCodTips, ;
3396:                         tipods    WITH loc_nTipoDs, ;
3397:                         campo2is  WITH "00:00", ;
3398:                         campo2fs  WITH "23:59" IN cursor_4c_Tds
3399:                 GO TOP
3400:             ENDIF
3401:         ENDIF
3402: 
3403:         *-- RecordSource DEVE ser atribuido FORA do WITH que acessa .Column -
3404:         *-- dentro do mesmo WITH as colunas ainda nao existem no momento da
3405:         *-- reatribuicao, gerando "Unknown member COLUMN1" (Pattern GRID-WITH)
3406:         loc_oGD.RecordSource = ""
3407:         loc_oGD.ColumnCount = 3
3408:         loc_oGD.RecordSource = "cursor_4c_Tds"
3409: 
3410:         WITH loc_oGD
3411:             *-- Redefinir ControlSource de TODAS as colunas apos reatribuir
3412:             *-- RecordSource - VFP faz auto-bind pela ordem dos campos do
3413:             *-- cursor, ignorando qualquer ControlSource setado antes (Pattern
3414:             *-- GRID-RECORDSOURCE-AUTOBIND)
3415:             DO CASE
3416:                 CASE loc_nTipoDs = 5
3417:                     .Column1.ControlSource = "cursor_4c_Tds.Campo3is"
3418:                     .Column2.ControlSource = "cursor_4c_Tds.Campo3fs"
3419:                 OTHERWISE
3420:                     .Column1.ControlSource = "cursor_4c_Tds.Campo1is"
3421:                     .Column2.ControlSource = "cursor_4c_Tds.Campo1fs"
3422:             ENDCASE
3423:             .Column3.ControlSource = "cursor_4c_Tds.Campo2is"
3424:             .Column4.ControlSource = "cursor_4c_Tds.Campo2fs"
3425:             .Column5.ControlSource = "cursor_4c_Tds.descos"
3426:             .Column6.ControlSource = "cursor_4c_Tds.dfators"
3427: 
3428:             DO CASE
3429:                 CASE loc_nTipoDs = 2
3430:                     .Column1.Text1.InputMask = "XXXXXXX"
3431:                     .Column1.Text1.MaxLength = 7
3432:                     .Column2.Text1.InputMask = "XXXXXXX"
3433:                     .Column2.Text1.MaxLength = 7
3434:                 CASE loc_nTipoDs = 3
3435:                     .Column1.Text1.InputMask = "99"
3436:                     .Column1.Text1.MaxLength = 2
3437:                     .Column2.Text1.InputMask = "99"
3438:                     .Column2.Text1.MaxLength = 2
3439:                 CASE loc_nTipoDs = 4
3440:                     .Column1.Text1.InputMask = "99:99"
3441:                     .Column1.Text1.MaxLength = 5

*-- Linhas 3482 a 3839:
3482: 
3483:         RETURN TRANSFORM(loc_nHora, "@L 99") + ":" + TRANSFORM(loc_nMin, "@L 99")
3484:     ENDFUNC
3485: 
3486:     *--------------------------------------------------------------------------
3487:     * FaixaTemInicial - Indica se a faixa (linha corrente de cursor_4c_Tds)
3488:     * ja tem o valor Inicial preenchido, condicao para habilitar as demais
3489:     * colunas de grd_4c_GradeD (equivalente ao "Left(Campo1is,2)" do legado).
3490:     * Quando o Tipo de Desconto e "Data" (5), o Inicial fica em Campo3is
3491:     * (nao em Campo1is - ver MontarConfiguracaoDesconto)
3492:     *--------------------------------------------------------------------------
3493:     PROTECTED FUNCTION FaixaTemInicial()
3494:         LOCAL loc_nTipoDs
3495: 
3496:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3497:             RETURN .F.
3498:         ENDIF
3499: 
3500:         loc_nTipoDs = 0
3501:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3502:             loc_nTipoDs = cursor_4c_Tdt.tipods
3503:         ENDIF
3504: 
3505:         IF loc_nTipoDs = 5
3506:             RETURN !EMPTY(cursor_4c_Tds.Campo3is)
3507:         ENDIF
3508: 
3509:         RETURN !EMPTY(LEFT(NVL(cursor_4c_Tds.Campo1is, ""), 2))
3510:     ENDFUNC
3511: 
3512:     *--------------------------------------------------------------------------
3513:     * GradeD Column1/Column2 (Inicial/Final) - When/Valid
3514:     * Equivalente ao "PgConfDesconto.GradeD.Column1/2.Text1" do legado:
3515:     * validacao/formatacao depende do Tipo de Desconto (tipods) da linha
3516:     * corrente de grd_4c_GradeI (cursor_4c_Tdt)
3517:     * PUBLIC: BINDEVENT requer metodo publico
3518:     *--------------------------------------------------------------------------
3519:     PROCEDURE GradeDColumn1When()
3520:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3521:     ENDPROC
3522: 
3523:     PROCEDURE GradeDColumn1Valid()
3524:         LOCAL loc_oGD, loc_cValor, loc_cFormatado
3525: 
3526:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3527:             RETURN
3528:         ENDIF
3529: 
3530:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3531:         loc_cValor = ALLTRIM(loc_oGD.Column1.Text1.Value)
3532: 
3533:         IF EMPTY(loc_cValor)
3534:             RETURN
3535:         ENDIF
3536: 
3537:         DO CASE
3538:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3539:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3540:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido. Informe Domingo, Segunda, Terca, Quarta, Quinta, Sexta ou Sabado.", "")
3541:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3542:                 ELSE
3543:                     REPLACE Campo1is WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3544:                     IF EMPTY(ALLTRIM(cursor_4c_Tds.Campo1fs))
3545:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3546:                     ENDIF
3547:                 ENDIF
3548: 
3549:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3550:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3551:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3552:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3553:                 ELSE
3554:                     REPLACE Campo1is WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3555:                     IF VAL(cursor_4c_Tds.Campo1fs) = 0 OR VAL(cursor_4c_Tds.Campo1is) > VAL(cursor_4c_Tds.Campo1fs)
3556:                         REPLACE Campo1fs WITH cursor_4c_Tds.Campo1is IN cursor_4c_Tds
3557:                     ENDIF
3558:                 ENDIF
3559: 
3560:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3561:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3562:                 IF EMPTY(loc_cFormatado)
3563:                     REPLACE Campo1is WITH "" IN cursor_4c_Tds
3564:                 ELSE
3565:                     REPLACE Campo1is WITH loc_cFormatado IN cursor_4c_Tds
3566:                     IF EMPTY(cursor_4c_Tds.Campo1fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo1fs, ":", ""))
3567:                         REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3568:                     ENDIF
3569:                 ENDIF
3570: 
3571:             OTHERWISE  && 5 = Data (Campo3is/Campo3fs, DATETIME - VFP valida o tipo na propria coluna)
3572:                 IF !EMPTY(cursor_4c_Tds.Campo3fs) AND cursor_4c_Tds.Campo3is > cursor_4c_Tds.Campo3fs
3573:                     REPLACE Campo3fs WITH cursor_4c_Tds.Campo3is IN cursor_4c_Tds
3574:                 ENDIF
3575:         ENDCASE
3576: 
3577:         loc_oGD.Refresh()
3578:     ENDPROC
3579: 
3580:     PROCEDURE GradeDColumn2When()
3581:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3582:     ENDPROC
3583: 
3584:     PROCEDURE GradeDColumn2Valid()
3585:         LOCAL loc_oGD, loc_cValor, loc_nDiaIni, loc_cFormatado
3586: 
3587:         IF !USED("cursor_4c_Tdt") OR !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tdt") OR EOF("cursor_4c_Tds")
3588:             RETURN
3589:         ENDIF
3590: 
3591:         loc_oGD    = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3592:         loc_cValor = ALLTRIM(loc_oGD.Column2.Text1.Value)
3593: 
3594:         IF EMPTY(loc_cValor)
3595:             RETURN
3596:         ENDIF
3597: 
3598:         DO CASE
3599:             CASE cursor_4c_Tdt.tipods = 2  && Dia da Semana
3600:                 IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3601:                     MsgAviso("Dia da semana inv" + CHR(225) + "lido.", "")
3602:                     RETURN
3603:                 ENDIF
3604:                 IF SEEK(PADR(UPPER(ALLTRIM(cursor_4c_Tds.Campo1is)), 7), "cursor_4c_DiaSemana", "Descrs")
3605:                     loc_nDiaIni = cursor_4c_DiaSemana.nDias
3606:                     IF !SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs") OR cursor_4c_DiaSemana.nDias < loc_nDiaIni
3607:                         MsgAviso("Dia final n" + CHR(227) + "o pode ser anterior ao dia inicial !!!", "")
3608:                         RETURN
3609:                     ENDIF
3610:                 ENDIF
3611:                 =SEEK(PADR(UPPER(loc_cValor), 7), "cursor_4c_DiaSemana", "Descrs")
3612:                 REPLACE Campo1fs WITH ALLTRIM(cursor_4c_DiaSemana.Descrs) IN cursor_4c_Tds
3613: 
3614:             CASE cursor_4c_Tdt.tipods = 3  && Dia do Mes
3615:                 IF !BETWEEN(VAL(loc_cValor), 1, 31)
3616:                     MsgAviso("Dia do m" + CHR(234) + "s deve ser entre 1 e 31 !!!", "")
3617:                     RETURN
3618:                 ENDIF
3619:                 IF VAL(loc_cValor) < VAL(cursor_4c_Tds.Campo1is)
3620:                     MsgAviso("Intervalo de dias inv" + CHR(225) + "lido. O dia final " + CHR(233) + " menor que o inicial.", "")
3621:                     RETURN
3622:                 ENDIF
3623:                 REPLACE Campo1fs WITH PADL(TRANSFORM(INT(VAL(loc_cValor))), 2, "0") IN cursor_4c_Tds
3624: 
3625:             CASE cursor_4c_Tdt.tipods = 4  && Horario
3626:                 loc_cFormatado = THIS.FormatarHorarioValidado(loc_cValor)
3627:                 IF EMPTY(loc_cFormatado)
3628:                     RETURN
3629:                 ENDIF
3630:                 IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo1is, ":", ""))
3631:                     MsgAviso("Intervalo de hor" + CHR(225) + "rio inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3632:                     RETURN
3633:                 ENDIF
3634:                 REPLACE Campo1fs WITH loc_cFormatado IN cursor_4c_Tds
3635: 
3636:             OTHERWISE  && 5 = Data
3637:                 IF cursor_4c_Tds.Campo3fs < cursor_4c_Tds.Campo3is
3638:                     MsgAviso("Data final n" + CHR(227) + "o pode ser menor que a inicial !!!", "")
3639:                 ENDIF
3640:         ENDCASE
3641: 
3642:         loc_oGD.Refresh()
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * GradeD Column3/Column4 - faixa de horario dentro do dia (Campo2is/fs).
3647:     * Nao se aplica quando o Tipo de Desconto ja e "Horario" (Column1/2)
3648:     * PUBLIC: BINDEVENT requer metodo publico
3649:     *--------------------------------------------------------------------------
3650:     PROCEDURE GradeDColumn3When()
3651:         LOCAL loc_nTipoDs
3652:         loc_nTipoDs = 0
3653:         IF USED("cursor_4c_Tdt") AND !EOF("cursor_4c_Tdt")
3654:             loc_nTipoDs = cursor_4c_Tdt.tipods
3655:         ENDIF
3656:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial() AND loc_nTipoDs != 4
3657:     ENDPROC
3658: 
3659:     PROCEDURE GradeDColumn3Valid()
3660:         LOCAL loc_oGD, loc_cFormatado
3661: 
3662:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3663:             RETURN
3664:         ENDIF
3665: 
3666:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3667:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column3.Text1.Value))
3668:         IF EMPTY(loc_cFormatado)
3669:             RETURN
3670:         ENDIF
3671: 
3672:         REPLACE Campo2is WITH loc_cFormatado IN cursor_4c_Tds
3673:         IF EMPTY(cursor_4c_Tds.Campo2fs) OR VAL(STRTRAN(loc_cFormatado, ":", "")) > VAL(STRTRAN(cursor_4c_Tds.Campo2fs, ":", ""))
3674:             REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3675:         ENDIF
3676: 
3677:         loc_oGD.Refresh()
3678:     ENDPROC
3679: 
3680:     PROCEDURE GradeDColumn4When()
3681:         RETURN THIS.GradeDColumn3When()
3682:     ENDPROC
3683: 
3684:     PROCEDURE GradeDColumn4Valid()
3685:         LOCAL loc_oGD, loc_cFormatado
3686: 
3687:         IF !USED("cursor_4c_Tds") OR EOF("cursor_4c_Tds")
3688:             RETURN
3689:         ENDIF
3690: 
3691:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3692:         loc_cFormatado = THIS.FormatarHorarioValidado(ALLTRIM(loc_oGD.Column4.Text1.Value))
3693:         IF EMPTY(loc_cFormatado)
3694:             RETURN
3695:         ENDIF
3696: 
3697:         IF VAL(STRTRAN(loc_cFormatado, ":", "")) < VAL(STRTRAN(cursor_4c_Tds.Campo2is, ":", ""))
3698:             MsgAviso("Intervalo de horas inv" + CHR(225) + "lido. A hora final " + CHR(233) + " menor que a inicial.", "")
3699:             RETURN
3700:         ENDIF
3701: 
3702:         REPLACE Campo2fs WITH loc_cFormatado IN cursor_4c_Tds
3703:         loc_oGD.Refresh()
3704:     ENDPROC
3705: 
3706:     *--------------------------------------------------------------------------
3707:     * GradeD Column5/Column6 - Preco/Fator da faixa. Column6 (Fator), ao
3708:     * confirmar com ENTER, cria automaticamente uma nova faixa em branco
3709:     * (equivalente ao legado)
3710:     * PUBLIC: BINDEVENT requer metodo publico
3711:     *--------------------------------------------------------------------------
3712:     PROCEDURE GradeDColumn5When()
3713:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND THIS.FaixaTemInicial()
3714:     ENDPROC
3715: 
3716:     PROCEDURE GradeDColumn6Valid()
3717:         LOCAL loc_oGD
3718: 
3719:         IF LASTKEY() != 13 OR !USED("cursor_4c_Tds") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3720:             RETURN
3721:         ENDIF
3722: 
3723:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3724: 
3725:         SELECT cursor_4c_Tds
3726:         SKIP
3727:         IF EOF()
3728:             APPEND BLANK
3729:             REPLACE cidchaves WITH fUniqueIds(), ;
3730:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3731:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3732:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3733:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3734:                     campo2is  WITH "00:00", ;
3735:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3736:             GO BOTTOM IN cursor_4c_Tds
3737:         ENDIF
3738: 
3739:         loc_oGD.Refresh()
3740:     ENDPROC
3741: 
3742:     *--------------------------------------------------------------------------
3743:     * BtnExcluirFaixaDescontoClick - remove a faixa corrente de grd_4c_GradeD;
3744:     * garante que sempre reste ao menos uma faixa (equivalente ao legado)
3745:     * PUBLIC: BINDEVENT requer metodo publico
3746:     *--------------------------------------------------------------------------
3747:     PROCEDURE BtnExcluirFaixaDescontoClick()
3748:         LOCAL loc_oGD, loc_nRegistros
3749: 
3750:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tds") ;
3751:                 OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3752:             RETURN
3753:         ENDIF
3754: 
3755:         loc_oGD = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeD
3756: 
3757:         SELECT cursor_4c_Tds
3758:         IF !EOF()
3759:             DELETE
3760:         ENDIF
3761: 
3762:         COUNT FOR !DELETED() TO loc_nRegistros
3763:         IF loc_nRegistros = 0
3764:             APPEND BLANK
3765:             REPLACE cidchaves WITH fUniqueIds(), ;
3766:                     codigos   WITH ALLTRIM(cursor_4c_Tdt.codigos), ;
3767:                     tipos     WITH cursor_4c_Tdt.tipos, ;
3768:                     codtips   WITH ALLTRIM(cursor_4c_Tdt.codtips), ;
3769:                     tipods    WITH cursor_4c_Tdt.tipods, ;
3770:                     campo2is  WITH "00:00", ;
3771:                     campo2fs  WITH "23:59" IN cursor_4c_Tds
3772:         ENDIF
3773: 
3774:         GO TOP IN cursor_4c_Tds
3775:         loc_oGD.Refresh()
3776:         loc_oGD.SetFocus
3777:     ENDPROC
3778: 
3779:     *--------------------------------------------------------------------------
3780:     * MontarComissoesDesconto - Equivalente ao "MontaTbCom" do legado.
3781:     * Filtra localmente cursor_4c_Tdi pela combinacao Tipo+Codigo da linha
3782:     * corrente de grd_4c_Gradei (cursor_4c_Tdt) e atualiza grd_4c_Gradec.
3783:     *--------------------------------------------------------------------------
3784:     PROTECTED PROCEDURE MontarComissoesDesconto()
3785:         LOCAL loc_oGradec, loc_nTipos, loc_cCodTips
3786: 
3787:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
3788: 
3789:         IF !USED("cursor_4c_Tdi")
3790:             RETURN
3791:         ENDIF
3792: 
3793:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3794:             SELECT cursor_4c_Tdi
3795:             SET FILTER TO .F.
3796:             loc_oGradec.Refresh()
3797:             RETURN
3798:         ENDIF
3799: 
3800:         loc_nTipos   = cursor_4c_Tdt.tipos
3801:         loc_cCodTips = ALLTRIM(cursor_4c_Tdt.codtips)
3802: 
3803:         SELECT cursor_4c_Tdi
3804:         SET FILTER TO tipos = loc_nTipos AND ALLTRIM(codtips) = loc_cCodTips
3805:         GO TOP IN cursor_4c_Tdi
3806:         loc_oGradec.Refresh()
3807:     ENDPROC
3808: 
3809:     *--------------------------------------------------------------------------
3810:     * GradeiDescAfterRowColChange - troca de linha em grd_4c_Gradei (pagina
3811:     * "Descontos / Comissoes"): marca a linha corrente (flag "regs",
3812:     * compartilhada com grd_4c_GradeI de PgConfDesconto), refresca os
3813:     * controles bindados a cursor_4c_Tdt (formulas 1a/2a, comissao, fator/
3814:     * descritivo, ignora cotacao) e reconfigura grd_4c_Gradec (comissoes)
3815:     * PUBLIC: BINDEVENT requer metodo publico + parametro do evento
3816:     *--------------------------------------------------------------------------
3817:     PROCEDURE GradeiDescAfterRowColChange(par_nColIndex)
3818:         LOCAL loc_oCnt
3819: 
3820:         IF !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
3821:             RETURN
3822:         ENDIF
3823: 
3824:         SELECT cursor_4c_Tdt
3825:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
3826:         REPLACE regs WITH 1 IN cursor_4c_Tdt
3827: 
3828:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
3829:         loc_oCnt.grd_4c_Gradei.Refresh()
3830:         loc_oCnt.cnt_4c_Formula1.Refresh()
3831:         loc_oCnt.cnt_4c_Formula2.Refresh()
3832:         loc_oCnt.cbo_4c_ComboComis.Refresh()
3833:         loc_oCnt.txt_4c_DescFats.Refresh()
3834:         loc_oCnt.txt_4c_FatorPads.Refresh()
3835:         loc_oCnt.chk_4c_IgnoraCotacao.Refresh()
3836: 
3837:         *-- grd_4c_GradeI de PgConfDesconto compartilha a mesma cursor_4c_Tdt
3838:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
3839: 

*-- Linhas 3970 a 3988:
3970:                 ENDIF
3971: 
3972:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaComposicao")
3973:                     SELECT cursor_4c_BuscaComposicao
3974:                     REPLACE codtips WITH ALLTRIM(EVALUATE("cursor_4c_BuscaComposicao." + loc_cCampo)) IN cursor_4c_Tdt
3975:                     loc_oGradei.Refresh()
3976:                 ENDIF
3977: 
3978:                 loc_oBusca.Release()
3979:             ENDIF
3980:         CATCH TO loException
3981:             MostrarErro(loException, "FormTbv.AbrirLookupCodigoComposicao")
3982:         ENDTRY
3983: 
3984:         IF USED("cursor_4c_BuscaComposicao")
3985:             USE IN cursor_4c_BuscaComposicao
3986:         ENDIF
3987:     ENDPROC
3988: 

*-- Linhas 4000 a 4145:
4000: 
4001:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4002: 
4003:         INSERT INTO cursor_4c_Tdt (codigos) VALUES (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
4004:         REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4005:         REPLACE regs WITH 1 IN cursor_4c_Tdt
4006: 
4007:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4008:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4009:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4010:         THIS.MontarComissoesDesconto()
4011:     ENDPROC
4012: 
4013:     *--------------------------------------------------------------------------
4014:     * BtnExcluirComposicaoClick - Remove a linha corrente de composicao
4015:     * (cursor_4c_Tdt); bloqueia se ainda houver comissoes vinculadas
4016:     * (equivalente ao legado - "Exclua primeiro as comissoes...")
4017:     * PUBLIC: BINDEVENT requer metodo publico
4018:     *--------------------------------------------------------------------------
4019:     PROCEDURE BtnExcluirComposicaoClick()
4020:         LOCAL loc_oPgDesc
4021: 
4022:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") OR EOF("cursor_4c_Tdt")
4023:             RETURN
4024:         ENDIF
4025: 
4026:         THIS.MontarComissoesDesconto()
4027:         IF USED("cursor_4c_Tdi") AND !EOF("cursor_4c_Tdi")
4028:             MsgAviso("Imposs" + CHR(237) + "vel excluir!!! Exclua primeiro as comiss" + CHR(245) + "es...", "")
4029:             RETURN
4030:         ENDIF
4031: 
4032:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4033: 
4034:         SELECT cursor_4c_Tdt
4035:         DELETE
4036:         GO BOTTOM IN cursor_4c_Tdt
4037:         IF !EOF("cursor_4c_Tdt")
4038:             REPLACE ALL regs WITH 0 IN cursor_4c_Tdt
4039:             REPLACE regs WITH 1 IN cursor_4c_Tdt
4040:         ENDIF
4041: 
4042:         loc_oPgDesc.grd_4c_Gradei.Refresh()
4043:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgConfDesconto.grd_4c_GradeI.Refresh()
4044:         loc_oPgDesc.grd_4c_Gradei.Column1.SetFocus
4045:         THIS.MontarComissoesDesconto()
4046:     ENDPROC
4047: 
4048:     *--------------------------------------------------------------------------
4049:     * BtnInserirComissaoClick - Inclui uma nova comissao (cursor_4c_Tdi)
4050:     * para a linha corrente de composicao (Tipo/Codigo)
4051:     * PUBLIC: BINDEVENT requer metodo publico
4052:     *--------------------------------------------------------------------------
4053:     PROCEDURE BtnInserirComissaoClick()
4054:         LOCAL loc_oPgDesc
4055: 
4056:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdt") ;
4057:                 OR EOF("cursor_4c_Tdt") OR !USED("cursor_4c_Tdi")
4058:             RETURN
4059:         ENDIF
4060: 
4061:         loc_oPgDesc = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto
4062: 
4063:         INSERT INTO cursor_4c_Tdi (codigos, tipos, codtips) VALUES ;
4064:             (ALLTRIM(THIS.this_oBusinessObject.this_cCodigo), cursor_4c_Tdt.tipos, ALLTRIM(cursor_4c_Tdt.codtips))
4065: 
4066:         THIS.MontarComissoesDesconto()
4067:         loc_oPgDesc.grd_4c_Gradec.Column1.SetFocus
4068:     ENDPROC
4069: 
4070:     *--------------------------------------------------------------------------
4071:     * BtnExcluirComissaoClick - Remove a comissao corrente (cursor_4c_Tdi)
4072:     * PUBLIC: BINDEVENT requer metodo publico
4073:     *--------------------------------------------------------------------------
4074:     PROCEDURE BtnExcluirComissaoClick()
4075:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4076:             RETURN
4077:         ENDIF
4078: 
4079:         SELECT cursor_4c_Tdi
4080:         DELETE
4081:         GO BOTTOM IN cursor_4c_Tdi
4082: 
4083:         THIS.MontarComissoesDesconto()
4084:         THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec.Column1.SetFocus
4085:     ENDPROC
4086: 
4087:     *--------------------------------------------------------------------------
4088:     * GradecColumn1Valid / GradecColumn2Valid - Grupo/Conta da comissao.
4089:     * Simplificado em relacao ao legado: NAO reproduz as checagens de
4090:     * acesso contabil (fAcessoContab/fAcessoContas do Framework legado -
4091:     * fora do escopo desta migracao). Column2 (Conta) valida contra
4092:     * SigCdCli e preenche automaticamente o Grupo quando vazio.
4093:     * PUBLIC: BINDEVENT requer metodo publico
4094:     *--------------------------------------------------------------------------
4095:     PROCEDURE GradecColumn1Valid()
4096:         RETURN .T.
4097:     ENDPROC
4098: 
4099:     PROCEDURE GradecColumn2Valid()
4100:         LOCAL loc_oGradec, loc_cConta, loc_cSQL
4101: 
4102:         IF !USED("cursor_4c_Tdi") OR EOF("cursor_4c_Tdi")
4103:             RETURN .T.
4104:         ENDIF
4105: 
4106:         loc_oGradec = THIS.pgf_4c_Paginas.Page2.cnt_4c_PgDesconto.grd_4c_Gradec
4107:         loc_cConta  = ALLTRIM(loc_oGradec.Column2.Text1.Value)
4108: 
4109:         IF EMPTY(loc_cConta)
4110:             RETURN .T.
4111:         ENDIF
4112: 
4113:         TRY
4114:             loc_cSQL = "SELECT iclis, grupos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
4115: 
4116:             IF USED("cursor_4c_BuscaConta")
4117:                 USE IN cursor_4c_BuscaConta
4118:             ENDIF
4119: 
4120:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") < 1 OR !USED("cursor_4c_BuscaConta") OR EOF("cursor_4c_BuscaConta")
4121:                 MsgAviso("Conta Inv" + CHR(225) + "lida !!!", "Acesso Negado")
4122:                 IF USED("cursor_4c_BuscaConta")
4123:                     USE IN cursor_4c_BuscaConta
4124:                 ENDIF
4125:                 loc_lResultado = .F.
4126:             ENDIF
4127: 
4128:             REPLACE contas WITH loc_cConta IN cursor_4c_Tdi
4129:             IF EMPTY(ALLTRIM(cursor_4c_Tdi.grupos))
4130:                 REPLACE grupos WITH ALLTRIM(TratarNulo(cursor_4c_BuscaConta.grupos, "C")) IN cursor_4c_Tdi
4131:             ENDIF
4132:             loc_oGradec.Refresh()
4133:         CATCH TO loException
4134:             MostrarErro(loException, "FormTbv.GradecColumn2Valid")
4135:         ENDTRY
4136: 
4137:         IF USED("cursor_4c_BuscaConta")
4138:             USE IN cursor_4c_BuscaConta
4139:         ENDIF
4140: 
4141:         RETURN .T.
4142:     ENDPROC
4143: 
4144:     *--------------------------------------------------------------------------
4145:     * TornarControlesVisiveis - Torna controles do container visiveis (recursivo)

*-- Linhas 4207 a 4227:
4207:                 USE IN cursor_4c_Empresas
4208:             ENDIF
4209:             IF USED("cursor_4c_Tdt")
4210:                 USE IN cursor_4c_Tdt
4211:             ENDIF
4212:             IF USED("cursor_4c_Tdi")
4213:                 USE IN cursor_4c_Tdi
4214:             ENDIF
4215:             IF USED("cursor_4c_Tds")
4216:                 USE IN cursor_4c_Tds
4217:             ENDIF
4218:             IF USED("cursor_4c_DiaSemana")
4219:                 USE IN cursor_4c_DiaSemana
4220:             ENDIF
4221:         CATCH TO loException
4222:             *-- Ignorar erros na destruicao
4223:         ENDTRY
4224:         DODEFAULT()
4225:     ENDPROC
4226: 
4227: ENDDEFINE


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

