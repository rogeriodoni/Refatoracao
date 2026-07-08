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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefc2.prg) - TRECHOS RELEVANTES PARA PASS SQL (862 linhas total):

*-- Linhas 649 a 686:
649:             loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CdEmpresa.Value)
650:             IF gnConnHandle > 0 AND !EMPTY(loc_cCod) AND ;
651:                EMPTY(ALLTRIM(loc_oPg1.txt_4c_NomEmpresa.Value))
652:                 loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
653:                            "WHERE Cemps = " + EscaparSQL(loc_cCod)
654:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpLc")
655:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpLc") > 0
656:                     SELECT cursor_4c_Refc2EmpLc
657:                     IF !EOF()
658:                         loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
659:                     ENDIF
660:                 ENDIF
661:                 IF USED("cursor_4c_Refc2EmpLc")
662:                     USE IN cursor_4c_Refc2EmpLc
663:                 ENDIF
664:             ENDIF
665: 
666:             *-- Carrega operacao e conserto do SigCdPam para Page2 (configuracao)
667:             IF gnConnHandle > 0
668:                 loc_cSQL = "SELECT TOP 1 Dopes, OpcOnsers FROM SigCdPam"
669:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2PamLc")
670:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2PamLc") > 0
671:                     SELECT cursor_4c_Refc2PamLc
672:                     IF !EOF()
673:                         loc_oPg2.txt_4c_DesOperacao.Value = ALLTRIM(Dopes)
674:                         loc_oPg2.txt_4c_DesConserto.Value = ALLTRIM(OpcOnsers)
675:                     ENDIF
676:                 ENDIF
677:                 IF USED("cursor_4c_Refc2PamLc")
678:                     USE IN cursor_4c_Refc2PamLc
679:                 ENDIF
680:             ENDIF
681: 
682:             loc_oPg1.txt_4c_CdEmpresa.SetFocus()
683: 
684:         CATCH TO loc_oErro
685:             MsgErro(loc_oErro.Message, "LimparCampos")
686:         ENDTRY

*-- Linhas 751 a 774:
751:                 RETURN
752:             ENDIF
753: 
754:             loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp " + ;
755:                        "WHERE Cemps = " + EscaparSQL(loc_cCod)
756:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2EmpV")
757: 
758:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2EmpV") > 0
759:                 SELECT cursor_4c_Refc2EmpV
760:                 IF !EOF()
761:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
762:                     loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
763:                 ENDIF
764:             ELSE
765:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Aviso")
766:                 loc_oPg1.txt_4c_CdEmpresa.Value  = ""
767:                 loc_oPg1.txt_4c_NomEmpresa.Value = ""
768:                 THIS.AbrirBuscaEmpresa()
769:             ENDIF
770: 
771:             IF USED("cursor_4c_Refc2EmpV")
772:                 USE IN cursor_4c_Refc2EmpV
773:             ENDIF
774: 

*-- Linhas 809 a 834:
809:             ENDIF
810: 
811:             *-- Busca empresa pela razao social (correspondencia parcial - TOP 2 para detectar duplicidade)
812:             loc_cSQL = "SELECT TOP 2 Cemps, Razas FROM SigCdEmp " + ;
813:                        "WHERE Razas LIKE " + EscaparSQL("%" + loc_cNom + "%") + ;
814:                        " ORDER BY Cemps"
815:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Refc2NomV")
816: 
817:             IF loc_nRes > 0 AND RECCOUNT("cursor_4c_Refc2NomV") = 1
818:                 *-- Encontrou exatamente uma - preenche automaticamente
819:                 SELECT cursor_4c_Refc2NomV
820:                 IF !EOF()
821:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ALLTRIM(Cemps)
822:                     loc_oPg1.txt_4c_NomEmpresa.Value = ALLTRIM(Razas)
823:                 ENDIF
824:                 IF USED("cursor_4c_Refc2NomV")
825:                     USE IN cursor_4c_Refc2NomV
826:                 ENDIF
827:             ELSE
828:                 IF USED("cursor_4c_Refc2NomV")
829:                     USE IN cursor_4c_Refc2NomV
830:                 ENDIF
831:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_Refc2NomV") = 0
832:                     MsgAviso("Empresa n" + CHR(227) + "o encontrada.", "Aviso")
833:                     loc_oPg1.txt_4c_CdEmpresa.Value  = ""
834:                     loc_oPg1.txt_4c_NomEmpresa.Value = ""

