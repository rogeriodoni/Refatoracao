# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NUMES, FPARCS, 1, ADQUIRENTE, INFO, BANDEIRA, FORMAS, VALAV, VALFIN, FPAGS, EMPDOPNUMS, DOPES, VENDS, EMPSUBNS, EMPS, TIPOOPS, GERGDMIS, INFOS, RELFECHAS, OPERS, EMPSUBVEND, NOPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NUMES, FPARCS, 1, ADQUIRENTE, INFO, BANDEIRA, FORMAS, VALAV, VALFIN, FPAGS, EMPDOPNUMS, DOPES, VENDS, EMPSUBNS, EMPS, TIPOOPS, GERGDMIS, INFOS, RELFECHAS, OPERS, EMPSUBVEND, NOPERS

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
  Option1.ControlSource = ""
  Option2.ControlSource = ""
  ControlSource = ""
lcQuery = [Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, ] +; 
	[From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ] +; 
	[c.empdopnums in(select a.empdopnums ] +; 
	[from  sigmvpec a, sigcdope b, sigmvcab c, sigcdope g ] +;  
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosNewE') < 1)
Select chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, Max(valpends) As valpends, Max(bandeira) As bandeira, ;
	MAX(adquirente) As adquirente, Max(valosM) As valosM, MAX(moefpgs) as moefpgs From csDadosNewE Group By chapar Into Cursor CurvE
Select chapar, empdopnums, Info, formas, bandeira, adquirente, valos As valAv, Cast(0.00 As numeric(11,2))  As valFin, Cast(0.00 As numeric(11,2)) As valRec;
	from CurvE Where fparcs = 1;
	SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, Cast(0.00 As numeric(11,2)) As valAv, valos As valFin, Cast(0.00 As numeric(11,2)) As valRec;
	from CurvE Where !(fparcs = 1) ;
Select CurtE
Select Info, formas, bandeira, adquirente, valAv, Cast(0.00 As numeric(11,2)) As QtdAv, valFin, Cast(0.00 As numeric(11,2)) As QtdFin ;
From CurtE Where 1=0 ;
Select csResultE
Select valAv as aVista, QtdAv as QtVista, valFin as aPrazo, QtdFin as QtPrazo From csResultE Into Cursor csResTotalE readwrite
Select csResTotalE 
Select CurtE
Select Distinct Info, adquirente from CurtE Into Cursor csAdqE Readwrite
	Select csRelatorio
	Select csRelatorio
Select csAdqE
	Select csResultE
	Select Distinct formas, bandeira from CurtE where adquirente = lcAdq and Info = lcInfo Into Cursor csBandE readwrite 
	Select csRelatorio
	Select csBandE
		Select Info, adquirente, formas, bandeira, Sum(valAv) As valAv, Count(1) as QtdAv, Cast(0.00 As numeric(11,2))  As valFin, Cast(0.00 As numeric(11,2))  As QtdFin ;
			from CurtE ;
		Select Info, adquirente, formas, bandeira, Cast(0.00 As numeric(11,2)) As valAv, Cast(0.00 As numeric(11,2)) as QtdAv, Sum(valFin) As valFin, Count(1) as QtdFin ;
			from CurtE ;
		Select Info, adquirente, formas, bandeira, Sum(valAv) As valAv, Sum(QtdAv) As QtdAv, Sum(valFin) As valFin, Sum(QtdFin) As QtdFin ;
			from csValAvE ;
		Select csSomaAFE
			Select csResTotalE
			Select csResultE
			Select csSomaAFE
		Select csBandE
	Select csResultE
		Select csRelatorio
	Select csAdqE	
	Select csRelatorio
		lnQueryOk = ThisForm.podataMgr.SqlExecute([Select * From SigCdPam ],'CrSigCdPam')
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigOpFp ],'CrSigOpFp')
		Select CrSigOpFp
	lcQuery =	[Select a.emps, LEFT(convert(char,a.datas,120),10) as datas From sigmvCab a, sigcdope g, sigcdtom h ]+;
		[a.EmpDopNums not in (select empdopnums from sigmvpar where fpags in ('GARANTIA','CORTESIA','PAG EFETUADO','PAG EFETUAD','CHEQUES')) and ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosF') < 1)
	lcQuery =	[Select a.emps,  LEFT(convert(char,a.datas,120),10) as datas, a.dopes, b.codvends, b.nAtends as nAtend ]+;
		[From SigMvCab a, SigMvate b Where a.empdopnums = b.empdopnums and a.datas BetWeen ?pDtI And ?pDtF And ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosF1') < 1)
	Select a.emps, a.DataS, Space(10) As codvends, 000 As nAtend, 'N' As fec From csDadosF a Where a.emps+a.DataS Not In (Select b.emps+b.DataS From csDadosF1 b) ;
		SELECT a.emps, a.DataS, b.codvends, b.nAtend, 'S' As fec From csDadosF a, csDadosF1 b Where a.emps+a.DataS =b.emps+b.DataS ;
	Select * From curF Order By emps, DataS Into Cursor curFec
	Select curFec
		Select csRelatorio
		Select curFec
	lcQuery =	[Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, d.fparcs, ] +;
		[From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ]+;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosV') < 1)
	lcQuery =	[Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, d.fparcs, ] +;
		[From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ]+;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosP') < 1)
	lcQuery =	[Select a.datas, a.Emps, a.Dopes, a.Numes, a.empdopnums,a.cidchaves as chaCab, b.cidchaves as chaItn, ] +;
		[From SigMvCab a, SigMvItn b, sigcdope g, SigOpCdi i ]+;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosD') < 1)
	Select csDadosD
			Select csDadosD
				Select csDadosD
				Delete
		Select csDadosD
	lcQuery =	[Select a.datas, a.Emps, a.Dopes, a.Numes, a.empdopnums,a.cidchaves as chaCab, b.cidchaves as chaItn, ] +;
		[From SigMvCab a, SigMvItn b, sigcdope g, SigOpCdi i ]+;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosD2') < 1)
	lcQuery =	[Select distinct a.datas, a.emps, a.dopes, a.numes, a.pedidoweb, a.valos ] +;
		[From SigMvCab a, sigcdope g, sigcdtom h ]+;
		[a.dopes in('VENDA PICKUP STORE','VENDA SHIP FROM STOR') and ] +;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosEC') < 1)
	lcQuery = [Select distinct IsNull(j.Datarcs, c.Datas) as datas, c.Emps, c.Dopes, ] + ;
		[From SigMvccr a, sigmvPar c ] + ;
		[Left Join SigCdPgr j On c.Empdopnums = j.Empdopnums ] + ;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosR') < 1)
	lcQuery =	[select a.numes, a.empsubns, convert(integer,right(a.codigos,6)) as numesS, b.dopes, c.valos, c.empdopnums ] +;
		[from sigmvpec a, sigcdope b, sigmvcab c, sigcdope g ] +;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDadosE') < 1)
	Select chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, Max(valpends) As valpends, Max(bandeira) As bandeira, ;
		MAX(adquirente) As adquirente, Max(valosM) As valosM, MAX(moefpgs) as moefpgs From csDadosV Group By chapar Into Cursor Curv
	Select chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, Max(valpends) As valpends, Max(bandeira) As bandeira, ;
		MAX(adquirente) As adquirente, Max(valosM) As valosM, MAX(moefpgs) as moefpgs From csDadosR Group By chapar Into Cursor Curr
	Select chapar, empdopnums, Info, formas, bandeira, adquirente, valos As valAv, Cast(0.00 As numeric(11,2))  As valFin, Cast(0.00 As numeric(11,2)) As valRec;
		from Curv Where fparcs = 1;
		SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, Cast(0.00 As numeric(11,2)) As valAv, valos As valFin, Cast(0.00 As numeric(11,2)) As valRec;
		from Curv Where !(fparcs = 1) ;
		SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, Cast(0.00 As numeric(11,2)) As valAv, Cast(0.00 As numeric(11,2)) As valFin, valos As valRec;
		from Curr ;
	Select Info, Sum(valAv) As valAv,Sum(valFin) As valFin,Sum(valRec) As valRec From Curt Group By Info Into Cursor curPag
	Select *, valAv+valFin As valVenda, valAv+valFin+valRec As valTot From curPag Into Cursor curPag
	Select Sum(valAv) As valAv, Sum(valFin) As valFin, Sum(valRec) As valRec, Sum(valVenda) As valVenda, Sum(valTot) As valTot From curPag Into Cursor curPagT
	Select curPag
		Select csRelatorio
		Select curPag
		Select csRelatorio
	Select valosM, moefpgs, chapar from Curv union Select valosM, moefpgs, chapar from Curr into cursor curM 
	SELECT SUM(valosM) as valosM, moefpgs from curM group by moefpgs into cursor curM
	Select curM
		Select csRelatorio
		Select curM
	Select csRelatorio
	Select dopes, numes, valos From csDadosP Order By dopes, numes Into Cursor curPeX
	Select Sum(valos) As valos From curPeX Into Cursor curPeT
	Select  Space(26) As dopes, Space(20) valos, Space(26) As dopes1, Space(15) As valos1, Space(26) As dopes2, Space(15) As valos2 From curPeX ;
	Select curPeX
		Select curPe
		Select curPeX
	Select curPe
		Select csRelatorio
		Select curPe
	Select csRelatorio
	Select numes, cpros, qtds, totas From  csDadosD ;
	Select numes, cpros, qtds, totas From  csDadosD2 ;
	Select Sum(totas) As totas From  curDev Into Cursor curDevT
	Select curDev
		Select csRelatorio
		Select curDev
		Select csRelatorio
	Select numes, pedidoweb, valos  From  csDadosEC Into Cursor curECo
	Select Sum(valos) As valos From  curECo Into Cursor curEcoT
	Select curECo
		Select csRelatorio
		Select curECo
		Select csRelatorio
	Select numes, numesS, valos  From  csDadosE Into Cursor curEnt
	Select Sum(valos) As valos From  curEnt Into Cursor curEntT
	Select curEnt
		Select csRelatorio
		Select curEnt
		Select csRelatorio
	Select adquirente, bandeira, empdopnums From Curt Where bandeira <> '  ' Group By empdopnums, adquirente, bandeira Into Cursor crQtv
	Select adquirente, bandeira, Count(empdopnums) As qtdv From crQtv Group By adquirente, bandeira Into Cursor crQtv
	SELECT adquirente from crQtv group by adquirente into cursor crAdq	&& mena - 05/03/2018 - prepara lista de adquirente 
	SELECT crAdq
		Select a.bandeira, Sum(a.valFin+a.valAv) As valos, Max(b.qtdv) As qtds, lcAdq As adquirente, 000 As linha ;
			from  Curt a, crQtv b Where Inlist(a.formas,'CARTAO','CREDITO') And a.adquirente == lcAdq ;
		Select a.bandeira, Sum(a.valFin+a.valAv) As valos, Max(b.qtdv) As qtds, lcAdq As adquirente, 000 As linha ;
			from  Curt a, crQtv b Where Inlist(a.formas,'DEBITO') And a.adquirente == lcAdq ;
		Select Sum(valos) As valos, Sum(qtds) As qtds From  curCar Into Cursor curCarT
		Select curCar
			Select csRelatorio
			Select curCar
			Select csRelatorio
		Select * from curCarD into cursor curCar readwrite
		Select Sum(valos) As valos, Sum(qtds) As qtds From  curCar Into Cursor curCarT
		SELECT curCar
			Select csRelatorio
			Select curCar
			Select csRelatorio
		SELECT crAdq
Insert Into csCabecalho (empresa, titulo, PERIODO) Values (lcCbEmp, lcCbTitulo, lcCbPeriodo)
Select csRelatorio
lnOldSel = Select()
Select csDados1
	lcQuery = [Select a.EmpSubns as emps, d.dopes, convert(int,right(codigos,6)) as numes, e.datas, e.vends	]+;
		[From SigMvPec a ]+;
		[inner join SigMvCab b on a.EmpDopnums = b.EmpDopNums ]+;
		[inner join SigCdOpe c on b.Dopes = c.Dopes ]+;
		[inner join SigCdOpe d on d.ndopes = replace(a.codigos,right(codigos,6),'') ]+;
		[inner join SigMvCab e on e.empdopnums = a.EmpSubns + d.dopes + str(convert(int,right(codigos,6)),6) ]+;
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDevolucao') < 1)
		Select(lnOldSel)
		Select csDados1
		Delete
	Select csDados1
Select(lnOldSel)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefc1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1027 linhas total):

*-- Linhas 516 a 538:
516:             loc_oPg.txt_4c_CdEmpresa.Value = loc_cEmpresa
517:             loc_oPg.txt_4c_DsEmpresa.Value = ""
518:             IF !EMPTY(loc_cEmpresa)
519:                 loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + ;
520:                     EscaparSQL(loc_cEmpresa)
521:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpInit")
522:                 IF loc_nRes > 0
523:                     SELECT cursor_4c_EmpInit
524:                     IF !EOF()
525:                         loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpInit.Razas)
526:                     ENDIF
527:                 ENDIF
528:                 IF USED("cursor_4c_EmpInit")
529:                     USE IN cursor_4c_EmpInit
530:                 ENDIF
531:             ENDIF
532:             loc_oPg.txt_4c_DtInicial.Value = DATE()
533:             loc_oPg.txt_4c_DtFinal.Value   = DATE()
534:             loc_oPg.opt_4c_TpRel.Value     = 1
535:         CATCH TO loc_oErro
536:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
537:         ENDTRY
538:     ENDPROC

*-- Linhas 962 a 984:
962:             loc_oPg.txt_4c_DsEmpresa.Value = ""
963:             RETURN
964:         ENDIF
965:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
966:             EscaparSQL(loc_cValor)
967:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
968:         IF loc_nResult > 0
969:             SELECT cursor_4c_EmpVal
970:             IF !EOF()
971:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
972:             ELSE
973:                 loc_oPg.txt_4c_DsEmpresa.Value = ""
974:                 THIS.AbrirBuscaCdEmpresa()
975:             ENDIF
976:         ELSE
977:             loc_oPg.txt_4c_DsEmpresa.Value = ""
978:             THIS.AbrirBuscaCdEmpresa()
979:         ENDIF
980:         IF USED("cursor_4c_EmpVal")
981:             USE IN cursor_4c_EmpVal
982:         ENDIF
983:     ENDPROC
984: 

*-- Linhas 995 a 1017:
995:             loc_oPg.txt_4c_CdEmpresa.Value = ""
996:             RETURN
997:         ENDIF
998:         loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
999:             EscaparSQL(loc_cValor + "%")
1000:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal2")
1001:         IF loc_nResult > 0
1002:             SELECT cursor_4c_EmpVal2
1003:             IF !EOF()
1004:                 loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Cemps)
1005:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Razas)
1006:             ELSE
1007:                 THIS.AbrirBuscaDsEmpresa()
1008:             ENDIF
1009:         ELSE
1010:             THIS.AbrirBuscaDsEmpresa()
1011:         ENDIF
1012:         IF USED("cursor_4c_EmpVal2")
1013:             USE IN cursor_4c_EmpVal2
1014:         ENDIF
1015:     ENDPROC
1016: 
1017:     *--------------------------------------------------------------------------

