# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '3' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MAPAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LNVALOR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SUBTOT100S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NIVELS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: IMPS, CEMPS, I, NFS, EMPS, BALANCOS, DTEMIS, DATAS, VENCS, DATARCS, CIDCHAVES, ICLIS, TPREGS, PS, LCCLASSES, LNOPERACAO, ANALITICOS, GRUPOS, ORDEMS, CLASSES, CGRUPOS, DS_GRUPOS, LNRECTROCA, BFIRST, PERCPREV, PERCGRP, VALOR, VLRCOMP, 0

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
  DeleteMark = .F.
Select csSigCdEmp
	.Column1.ControlSource = []
	.Column2.ControlSource = []
	.Column3.ControlSource = []
	.Column4.ControlSource = []
	.Column5.ControlSource = []
Select cEmps From csSigCdEmp where Imps = 1 into cursor crQtdEmp
	lcQuery = [Select 0 as Imps, cEmps,cMes,cAno,cTitulo,Moeda from SigCdMrp where cEmps = ']+crQtdEmp.cEmps+[' group by cEmps,cMes,cAno,cTitulo,Moeda]
	lcQuery = [Select 0 as Imps, cEmps,cMes,cAno,cTitulo,Moeda from SigCdMrp where cEmps = ']+''+[' group by cEmps,cMes,cAno,cTitulo,Moeda]
If (ThisForm.podatamgr.SQLExecute(lcQuery,'crSigCdMrp') < 1)
Select crSigCdMrp
	.DeleteMark        = .f.
	.Column1.ControlSource   = 'crSigCdMrp.Imps'
	.Column2.ControlSource   = 'crSigCdMrp.cTitulo'
	.Column3.ControlSource   = 'crSigCdMrp.cMes'
	.Column4.ControlSource   = 'crSigCdMrp.cAno'
	.Column5.ControlSource   = 'crSigCdMrp.Moeda'
lcQuery = [Select a.Grupos, a.Contas, ] + ;
			[From SigMvCcr a Inner Join SigCdMri c On a.Grupos = c.Grupos ] + ;
				[Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
				[Left Join SigCdPit e On a.nOpers = e.nOpers And a.Emps = e.EmpOs ] +;
				[Left Join SigCdPgr f On e.Empdopnums = f.Empdopnums ] +;				
			[Inner Join SigCdCss d On b.Classes = d.Classes ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [TmpBalC]) < 1)
Select Distinct Grupos, Contas, Nvl(Datas,Ctot(Space(08))) as Datas, Valors, Svalors, Moedas, Smoedas, Cotacaos, ;
  From TmpBalC ;
	Select cBalC
			Select TmpBalC
		Select cBalC
	Select d.Ordems, ;
	  From cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select d.Ordems, ;
	  From cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select d.Ordems, ;
	  From cBalC a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select a.* ;
	  From cBal3C a ;
	Select b.* ;
      From cBal4C b ;
	Select dbCompara
		loBarra.Update(.T.)
		If ThisForm.poDataMgr.SqlExecute([Select IClis,RClis From SigCdCli Where IClis = ']+lcConta+[' ],'TmpCli') < 1
		Select TmpCli
		Select dbCompara
		Select dbCompara
		Select crSigCdMri
			If (crSigCdMri.Balancos=pDem And (Not Seek(crSigCdMri.Grupos, 'dbCompara', 'Grupos') Or crSigCdMri.TpRegs=2))
				=Seek(crSigCdMri.Grupos,  'crSigCdGcr', 'Codigos')
				=Seek(crSigCdMri.Classes, 'crSigCdCss', 'Classes')
				Insert Into dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Contas, Ds_contas, Valor, Moedas, ;
			=Seek(crSigCdMri.Grupos + Iif(crSigCdMri.TpRegs=1, '', Chr(255)), 'crSigCdGcr', 'Codigos')
		Select crSigCdMri
		Select dbCompara
				If Not Seek(Padr(Alltrim(m.Classes), 10, '0') + Padr(m.Grupos, 10) + m.Ps + Padr(m.Contas,10), 'dbCompara', 'Classes')
					Insert Into dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Titulos, ;
		Select dbCompara
		Select dbCompara
			   Select ContPartC
						Insert Into dbCompara (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Titulos, ;
	         	Select dbCompara
		Select dbCompara
		=Seek('', 'dbCompara', 'Classes')
		Select dbCompara
			Select crSigCdMri
			Select dbCompara
		Select dbCompara
		Select dbCompara
	Select * From cBalC Into Cursor dbCompara Readwrite 
	Select cBalC
Select dbRelatorio
			Select Tempo
		Select crSigCdCot
		Select crSigCdMoe
		Select crSigCdGcr
		lcQuery = [Select * ] + ;
				    [From SigCdMrr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdMrr') < 1)
		Select crSigCdMrr
		lcQuery = [Select Ordems, Classes, Grupos, DescGrps, Fators, Operacaos, ] + ;
				    [From SigCdMri ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdMri') < 1)
		Select crSigCdMri
		Select crSigCdCss
		lcQuery = [Select 0 as Imps,cMes,cAno,cTitulo,Moeda from SigCdMrp group by cMes,cAno,cTitulo,Moeda]
		If (ThisForm.podatamgr.SQLExecute(lcQuery,'crSigCdMrp') < 1)
		Select crSigCdMrp
		lcQuery = [Select cEmps,cMes,cAno,cTitulo,Moeda,cGrupos,iClis,nValors from SigCdMrp]
		If (ThisForm.poDataMgr.SQLExecute(lcQuery,'crPrevisao') < 1)
		Select crPrevisao
		If ThisForm.podatamgr.SQLExecute([select a.cemps, a.razas, 1 as Imps from SigCdEmp a order by a.cemps],'csSigCdEmp') < 1 Then
			.DeleteMark        = .f.
			.Column1.ControlSource   = 'csSigCdEmp.Imps'
			.Column2.ControlSource   = 'csSigCdEmp.CEmps'
			.Column3.ControlSource   = 'csSigCdEmp.Razas'
		lcQuery = [Select GrupoPags, ContaPags, GrupoRecs, ContaRecs From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPam]) < 1)
Select cEmps, Razas from csSigCdEmp Where Imps = 1 into cursor crAux
		Select crAux
=Seek(lcDmr, [crSigCdMrr], [Balancos])
Select crSigCdMrp
Select cTitulo from crSigCdMrp where Imps = 1 into cursor crAux
	Select crSigCdMrp
	lcQuery = [Select cGrupos, iClis, Sum(nValors) as nValors from SigCdMrr where cEmps+cMes+cAno+cTitulo+Moeda in ]+lcOrcs + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crPrevisao') < 1)
	Select crPrevisao
Insert Into dbCabecalho (NomeEmpresa, Titulo, Empresa, Previsao, Orcamento, Comparativo, Faixas) Values ;
lcQuery = [Select Distinct a.Grupos, a.Contas, ] + ;
			[From SigMvCcr a Inner Join SigCdMri c On a.Grupos = c.Grupos ] + ;
				[Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
			[Inner Join SigCdCss d On b.Classes = d.Classes ] + ;
			[Left Join SigCdPit e On a.nOpers = e.nOpers And a.Emps = e.EmpOs ] +;
			[Left Join SigCdPgr f On e.Empdopnums = f.Empdopnums ] +;
			[Left Join SigCdPit g On a.vOpers = (g.EmpOs + convert(varchar(9),g.nOpers)) ] + ;
			[Left Join SigCdPgr h On g.Empdopnums = h.Empdopnums ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpBal1') < 1)
Select Distinct Grupos, Contas, Nvl(Datas,Ctot(Space(08))) as Datas, Valors, Svalors, Moedas, Smoedas, Cotacaos, ;
  From TmpBal1 ;
	Select d.Ordems, ;
	  From cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select cBal2
			Select TmpBal1
		Select cBal2
		Select cBalCP
			Select cBalCP
	Select d.Ordems, ;
	  From cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select d.Ordems, ;
	  From cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select d.Ordems, ;
	  From cBal2 a, crSigCdGcr b, crSigCdMri d, crSigCdCss e ;
	Select a.* ;
	  From cBal3 a ;
	Select b.* ;
      From cBal4 b ;
	Select dbRelatorio
		loBarra.Update(.T.)
		If ThisForm.poDataMgr.SqlExecute([Select IClis,RClis From SigCdCli Where IClis = ']+lcConta+[' ],'TmpCli') < 1
		Select TmpCli
		Select dbRelatorio
		Select dbRelatorio
		Select crSigCdMri
			If (crSigCdMri.Balancos=lcDmr And (Not Seek(crSigCdMri.Grupos, 'dbRelatorio', 'Grupos') Or crSigCdMri.TpRegs=2))
				=Seek(crSigCdMri.Grupos,  'crSigCdGcr', 'Codigos')
				=Seek(crSigCdMri.Classes, 'crSigCdCss', 'Classes')
				Insert Into dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Contas, Ds_contas, Valor, Moedas, ;
			=Seek(crSigCdMri.Grupos + Iif(crSigCdMri.TpRegs=1, '', Chr(255)), 'crSigCdGcr', 'Codigos')
		Select crSigCdMri
		Select dbRelatorio
				If Not Seek(Padr(Alltrim(m.Classes), 10, '0') + Padr(m.Grupos, 10) + m.Ps + Padr(m.Contas,10), 'dbRelatorio', 'Classes')
					Insert Into dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Titulos, ;
		Select dbRelatorio
		Select dbRelatorio
			   Select ContPart
						Insert Into dbRelatorio (Ordems, Classes, Desctpgcs, Grupos, Ds_grupos, Titulos, ;
	         	Select dbRelatorio
		Select dbRelatorio
		=Seek('', 'dbRelatorio', 'Classes')
		Select dbRelatorio
			Select crSigCdMri
			Select dbRelatorio
		Select dbRelatorio
					If Seek(dbRelatorio.Contas,'crPrevisao','PrevCta')
					If Seek(dbRelatorio.Grupos,'crPrevisao','PrevGrp')
		Select dbRelatorio
	Select cBal2
	Select iClis, nValors from crPrevisao where iClis not in (Select Contas from dbRelatorio) into cursor crAdicionar
	Select crAdicionar
		ThisForm.poDataMgr.SqlExecute([Select Grupos, rClis from SigCdCli where iClis = ']+crAdicionar.iClis+['], 'crGrupoCta')		
		Select * from dbRelatorio where Grupos = crGrupoCta.Grupos into cursor crAux
		Select crAux
			Insert into dbRelatorio from Memvar			  
	Select dbRelatorio
			Select Nvl(Sum(a.Previsao),0) as TotPrev from dbRelatorio a where a.Ordems = dbRelatorio.Ordems and a.Classes = dbRelatorio.Classes and ;
				Select nValors from crPrevisao where cGrupos = dbRelatorio.Grupos into cursor crVlrGrp
	Select Ordems, Grupos, Ds_Grupos from dbRelatorio where Ps = '6' into cursor crAux
	Select crAux
		Select Nvl(Sum(Previsao),0) as TotPrev from dbRelatorio where Ordems < crAux.Ordems and Ps <> '6' into cursor crTot
		Select crTot
			Update dbRelatorio set Previsao = crTot.TotPrev where Ps == '6' and Grupos = crAux.Grupos and Ds_Grupos = crAux.Ds_Grupos
	Select dbRelatorio
			=Seek(lcSubTot,'crSigCdMri','Grupos')
	Select dbRelatorio
				lcQuery = [Select Sum(a.nValors) as TotPrev from SigCdMrp a inner join SigCdCli b on b.iClis = a.iClis ] + ;
						  [inner join SigCdGcr c on c.Codigos = b.Grupos where c.Classes = ']+dbRelatorio.Classes+[' and ] + ;
						  [Select Sum(a.nValors) as TotPrev from SigCdMrp a inner join SigCdGcr b on b.Codigos = a.cGrupos ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpPrev') < 1)
				Select Sum(Nvl(TotPrev,0)) as TotPrev from crTmpPrev into cursor crTotPrev
				Select crTotPrev																			
				Select Nvl(Sum(a.Previsao),0) as TotPrev from dbRelatorio a where a.Ordems = dbRelatorio.Ordems and a.Classes = dbRelatorio.Classes and ;
				Select crTotPrev
				Select Nvl(Sum(a.Previsao),0) as TotPrev, Sum(a.Valor) as TotReal from dbRelatorio a where a.Ordems = dbRelatorio.Ordems and a.Classes = dbRelatorio.Classes and ;
	Update dbRelatorio set PercPrev = Min(PercPrev,999.99) where PercPrev <> 0
	Update dbRelatorio set PercGrp = Min(PercGrp,999.99) where PercGrp <> 0
	Select Emps as Empresas, ;
	  From dbRelatorio ;
	Select Tempo
		Select dbRelatorio
		Update dbRelatorio Set Emps = ''
	Select * from dbRelatorio into cursor crTmp
	Select a.*, a.Valor as VlrComp, 000.00 as VarComp from crTmp a into Cursor dbRelatorio readwrite
	Select dbRelatorio
	Select dbCompara
	Select dbRelatorio
		If Seek(dbRelatorio.Classes+dbRelatorio.Grupos+dbRelatorio.ds_Grupos+dbRelatorio.Contas,[dbCompara],[skGroup]) and dbCompara.Valor <> 0
	Select * from dbCompara where Classes+Grupos+ds_Grupos+Contas not in (Select Classes+Grupos+ds_Grupos+Contas from dbRelatorio) into cursor crAdiciona
	Select crAdiciona
		Insert into dbRelatorio from MemVar
	Select dbRelatorio
	=Seek('', 'dbRelatorio', 'Classes') 		
	Select dbRelatorio
		Select crSigCdMri
		Select dbRelatorio
	Select dbRelatorio
Select csSigCdEmp
	Select * from dbRelatorio Where 0=1 Into Cursor TmpRelat1 Readwrite
	Select dbRelatorio
		Select cBalCP
			Insert Into TmpRelat1 From Memvar
	Select TmpRelat1
		Insert Into dbRelatorio From Memvar
			If ThisForm.poDataMgr.SqlExecute([Select IClis,RClis From SigCdCli Where IClis = ']+dbRelatorio.SContas+[' ],'TmpCli') < 1
			Select TmpCli
			If ThisForm.poDataMgr.SqlExecute([Select IClis,RClis From SigCdCli Where IClis = ']+dbRelatorio.ContEms+[' ],'TmpCli') < 1
			Select TmpCli
Select dbRelatorio
Select dbRelatorio
		If ThisForm.poDataMgr.SqlExecute([Select IClis,RClis From SigCdCli Where IClis = ']+dbRelatorio.SContas+[' ],'TmpCli') < 1
		Select TmpCli
Select dbRelatorio
			Select Tempo
   	If Not Seek(This.Value, 'crSigCdMrr', 'Balancos')
	Select csSigCdEmp
Select csSigCdEmp
	Select crSigCdMrp
Select crSigCdMrp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredtv.prg) - TRECHOS RELEVANTES PARA PASS SQL (1739 linhas total):

*-- Linhas 738 a 756:
738:             .FontSize          = 8
739:             .AllowHeaderSizing = .F.
740:             .AllowRowSizing    = .F.
741:             .DeleteMark        = .F.
742:             .RecordMark        = .F.
743:             .ReadOnly          = .F.
744:             .RowHeight         = 17
745:             .ScrollBars        = 2
746:             .GridLineColor     = RGB(238, 238, 238)
747:             .Visible           = .T.
748:         ENDWITH
749:         WITH THIS.grd_4c_Emps.Column1
750:             .Width     = 15
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .Movable   = .F.
754:             .Resizable = .F.
755:             .ReadOnly  = .F.
756:             .Sparse    = .F.

*-- Linhas 826 a 844:
826:             .FontSize          = 8
827:             .AllowHeaderSizing = .F.
828:             .AllowRowSizing    = .F.
829:             .DeleteMark        = .F.
830:             .RecordMark        = .F.
831:             .ReadOnly          = .F.
832:             .RowHeight         = 17
833:             .ScrollBars        = 2
834:             .GridLineColor     = RGB(238, 238, 238)
835:             .Visible           = .T.
836:         ENDWITH
837:         WITH THIS.grd_4c_Orcs.Column1
838:             .Width     = 15
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .Movable   = .F.
842:             .Resizable = .F.
843:             .ReadOnly  = .F.
844:             .Sparse    = .F.

*-- Linhas 910 a 948:
910:         ENDIF
911:         WITH THIS.grd_4c_Emps
912:             .RecordSource          = "csSigCdEmp"
913:             .Column1.ControlSource = "csSigCdEmp.Imps"
914:             .Column2.ControlSource = "csSigCdEmp.CEmps"
915:             .Column3.ControlSource = "csSigCdEmp.Razas"
916:         ENDWITH
917:         THIS.grd_4c_Emps.Refresh()
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * ConfigurarGridOrcamentos - Vincula RecordSource apos crSigCdMrp disponivel
922:     *--------------------------------------------------------------------------
923:     PROTECTED PROCEDURE ConfigurarGridOrcamentos()
924:         IF NOT USED("crSigCdMrp")
925:             RETURN
926:         ENDIF
927:         WITH THIS.grd_4c_Orcs
928:             .RecordSource          = "crSigCdMrp"
929:             .Column1.ControlSource = "crSigCdMrp.Imps"
930:             .Column2.ControlSource = "crSigCdMrp.cTitulo"
931:             .Column3.ControlSource = "crSigCdMrp.cMes"
932:             .Column4.ControlSource = "crSigCdMrp.cAno"
933:             .Column5.ControlSource = "crSigCdMrp.Moeda"
934:         ENDWITH
935:         THIS.grd_4c_Orcs.Refresh()
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     * ConfigurarBINDEVENTs - Vincula eventos a metodos do form
940:     *--------------------------------------------------------------------------
941:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
942:         *-- Campos de data
943:         BINDEVENT(THIS.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
944:         BINDEVENT(THIS.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
945: 
946:         *-- Moeda
947:         BINDEVENT(THIS.txt_4c_CodMoeda, "KeyPress", THIS, "TeclaLookupMoedaCod")
948:         BINDEVENT(THIS.txt_4c_DesMoeda, "KeyPress", THIS, "TeclaLookupMoedaDesc")

*-- Linhas 1281 a 1302:
1281:             THIS.AtualizarEstadoMoedaDesc()
1282:             RETURN
1283:         ENDIF
1284:         loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
1285:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1286:         IF loc_nResult > 0
1287:             SELECT cursor_4c_MoeVal
1288:             IF !EOF()
1289:                 THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
1290:             ELSE
1291:                 THIS.txt_4c_DesMoeda.Value = ""
1292:                 THIS.AbrirBuscaMoedaCod()
1293:             ENDIF
1294:         ELSE
1295:             THIS.txt_4c_DesMoeda.Value = ""
1296:             THIS.AbrirBuscaMoedaCod()
1297:         ENDIF
1298:         IF USED("cursor_4c_MoeVal")
1299:             USE IN cursor_4c_MoeVal
1300:         ENDIF
1301:         THIS.AtualizarEstadoMoedaDesc()
1302:     ENDPROC

*-- Linhas 1357 a 1378:
1357:             THIS.AtualizarEstadoMoedaDesc()
1358:             RETURN
1359:         ENDIF
1360:         loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
1361:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
1362:         IF loc_nResult > 0
1363:             SELECT cursor_4c_MoeDescVal
1364:             IF !EOF()
1365:                 THIS.txt_4c_CodMoeda.Value = ALLTRIM(CMoes)
1366:                 THIS.txt_4c_DesMoeda.Value = ALLTRIM(DMoes)
1367:             ELSE
1368:                 THIS.AbrirBuscaMoedaDesc()
1369:             ENDIF
1370:         ELSE
1371:             THIS.AbrirBuscaMoedaDesc()
1372:         ENDIF
1373:         IF USED("cursor_4c_MoeDescVal")
1374:             USE IN cursor_4c_MoeDescVal
1375:         ENDIF
1376:         THIS.AtualizarEstadoMoedaDesc()
1377:     ENDPROC
1378: 

*-- Linhas 1424 a 1446:
1424:             RETURN
1425:         ENDIF
1426:         loc_cFiltro = IIF(THIS.this_nTipo = 2, "Mapas = 2", "NOT Mapas = 2")
1427:         loc_cSQL    = "SELECT Balancos FROM SigCdMrr WHERE Balancos = " + EscaparSQL(loc_cValor) + ;
1428:                       " AND " + loc_cFiltro
1429:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DemVal")
1430:         IF loc_nResult > 0
1431:             SELECT cursor_4c_DemVal
1432:             IF !EOF()
1433:                 THIS.txt_4c_Demons.Value = ALLTRIM(Balancos)
1434:             ELSE
1435:                 THIS.AbrirBuscaDemonstrativo()
1436:             ENDIF
1437:         ELSE
1438:             THIS.AbrirBuscaDemonstrativo()
1439:         ENDIF
1440:         IF USED("cursor_4c_DemVal")
1441:             USE IN cursor_4c_DemVal
1442:         ENDIF
1443:         THIS.txt_4c_Demons.Refresh()
1444:     ENDPROC
1445: 
1446:     *==========================================================================

