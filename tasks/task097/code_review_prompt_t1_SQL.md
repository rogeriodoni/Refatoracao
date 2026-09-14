# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NUMES, FPARCS, 1, ADQUIRENTE, INFO, BANDEIRA, FORMAS, VALAV, VALFIN, FPAGS, EMPDOPNUMS, DOPES, EMPS, TIPOOPS, GERGDMIS, INFOS, RELFECHAS, OPERS, EMPSUBVEND, NOPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NUMES, FPARCS, 1, ADQUIRENTE, INFO, BANDEIRA, FORMAS, VALAV, VALFIN, FPAGS, EMPDOPNUMS, DOPES, EMPS, TIPOOPS, GERGDMIS, INFOS, RELFECHAS, OPERS, EMPSUBVEND, NOPERS

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
		[a.EmpDopNums not in (select empdopnums from sigmvpar where fpags in ('garantia','cortesia','pag efetuado','PAG EFETUAD','CHEQUES')) and ] + ;
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
	Select Curt
	Select Info, formas, bandeira, adquirente, valAv, Cast(0.00 As numeric(11,2)) As QtdAv, valFin, Cast(0.00 As numeric(11,2)) As QtdFin ;
	From Curt Where 1=0 ;
	Select csResult 
	Select valAv as aVista, QtdAv as QtVista, valFin as aPrazo, QtdFin as QtPrazo From csResult Into Cursor csResTotal readwrite
	Select csResTotal
	Select Curt
	Select Distinct Info, adquirente from Curt Into Cursor csAdq Readwrite
		Select csRelatorio
		Select csRelatorio
	Select csAdq
		Select csResult
		Select Distinct formas, bandeira from Curt where adquirente = lcAdq and Info = lcInfo Into Cursor csBand readwrite 
		Select csRelatorio
		Select csBand
			Select Info, adquirente, formas, bandeira, Sum(valAv) As valAv, Count(1) as QtdAv, Cast(0.00 As numeric(11,2))  As valFin, Cast(0.00 As numeric(11,2))  As QtdFin ;
				from Curt ;
			Select Info, adquirente, formas, bandeira, Cast(0.00 As numeric(11,2)) As valAv, Cast(0.00 As numeric(11,2)) as QtdAv, Sum(valFin) As valFin, Count(1) as QtdFin ;
				from Curt ;
			Select Info, adquirente, formas, bandeira, Sum(valAv) As valAv, Sum(QtdAv) As QtdAv, Sum(valFin) As valFin, Sum(QtdFin) As QtdFin ;
				from csValAv ;
			Select csSomaAF
				Select csResTotal 
				Select csResult
				Select csSomaAF
			Select csBand
		Select csResult
			Select csRelatorio
		Select csAdq	
		Select csRelatorio
	Select Info, Sum(valAv) As valAv,Sum(valFin) As valFin,Sum(valRec) As valRec From Curt Group By Info Into Cursor curPag
	Select *, valAv+valFin As valVenda, valAv+valFin+valRec As valTot From curPag Into Cursor curPag
	Select Sum(valAv) As valAv, Sum(valFin) As valFin, Sum(valRec) As valRec, Sum(valVenda) As valVenda, Sum(valTot) As valTot From curPag Into Cursor curPagT
	Select curPag
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
Insert Into csCabecalho (empresa, titulo, PERIODO) Values (lcCbEmp, lcCbTitulo, lcCbPeriodo)
Select csRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefc2.prg) - TRECHOS RELEVANTES PARA PASS SQL (860 linhas total):

*-- Linhas 647 a 684:
647:             loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)
648:             IF gnConnHandle > 0 AND !EMPTY(loc_cCod) AND ;
649:                EMPTY(ALLTRIM(loc_oPg1.txt_4c_NomEmpresa.Value))
650:                 loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
651:                            "WHERE Cemps = " + EscaparSQL(loc_cCod)
652:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpLc")
653:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpLc") > 0
654:                     SELECT cursor_4c_Refc2EmpLc
655:                     IF !EOF()
656:                         loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
657:                     ENDIF
658:                 ENDIF
659:                 IF USED("cursor_4c_Refc2EmpLc")
660:                     USE IN cursor_4c_Refc2EmpLc
661:                 ENDIF
662:             ENDIF
663: 
664:             *-- Carrega operacao e conserto do SigCdPam para Page2 (configuracao)
665:             IF gnConnHandle > 0
666:                 loc_cSQL = "SELECT TOP 1 Dopes, OpcOnsers FROM SigCdPam"
667:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2PamLc")
668:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2PamLc") > 0
669:                     SELECT cursor_4c_Refc2PamLc
670:                     IF !EOF()
671:                         loc_oPg2.txt_4c_DesOperacao.Value = ALLTRIM(Dopes)
672:                         loc_oPg2.txt_4c_DesConserto.Value = ALLTRIM(OpcOnsers)
673:                     ENDIF
674:                 ENDIF
675:                 IF USED("cursor_4c_Refc2PamLc")
676:                     USE IN cursor_4c_Refc2PamLc
677:                 ENDIF
678:             ENDIF
679: 
680:             loc_oPg1.txt_4c_CdEmpresa.SetFocus()
681: 
682:         CATCH TO loc_oErro
683:             MsgErro(loc_oErro.Message, "LimparCampos")
684:         ENDTRY

*-- Linhas 749 a 772:
749:                 RETURN
750:             ENDIF
751: 
752:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
753:                        "WHERE Cemps = " + EscaparSQL(loc_cCod)
754:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpV")
755: 
756:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpV") > 0
757:                 SELECT cursor_4c_Refc2EmpV
758:                 IF !EOF()
759:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
760:                     loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
761:                 ENDIF
762:             ELSE
763:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Aviso")
764:                 loc_oPg1.txt_4c_CdEmpresa.Value  = ""
765:                 loc_oPg1.txt_4c_NomEmpresa.Value = ""
766:                 THIS.AbrirBuscaEmpresa()
767:             ENDIF
768: 
769:             IF USED("cursor_4c_Refc2EmpV")
770:                 USE IN cursor_4c_Refc2EmpV
771:             ENDIF
772: 

*-- Linhas 807 a 832:
807:             ENDIF
808: 
809:             *-- Busca empresa pela razao social (correspondencia parcial - TOP 2 para detectar duplicidade)
810:             loc_cSQL = "SELECT TOP 2 Cemps, Razas FROM SigCdEmp " + ;
811:                        "WHERE Razas LIKE " + EscaparSQL("%" + loc_cNom + "%") + ;
812:                        " ORDER BY Cemps"
813:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2NomV")
814: 
815:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2NomV") = 1
816:                 *-- Encontrou exatamente uma - preenche automaticamente
817:                 SELECT cursor_4c_Refc2NomV
818:                 IF !EOF()
819:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
820:                     loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
821:                 ENDIF
822:                 IF USED("cursor_4c_Refc2NomV")
823:                     USE IN cursor_4c_Refc2NomV
824:                 ENDIF
825:             ELSE
826:                 IF USED("cursor_4c_Refc2NomV")
827:                     USE IN cursor_4c_Refc2NomV
828:                 ENDIF
829:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_Refc2NomV") = 0
830:                     MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Aviso")
831:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ""
832:                     loc_oPg1.txt_4c_NomEmpresa.Value = ""

