# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'UNIFBALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTORIGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRTRANS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PRODZS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTDESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESTINOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ACERTBALS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TPOPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS

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
  DeleteMark = .F.
  Column1.ControlSource = "TmpOpera.TpOps"
  Column2.ControlSource = "TmpOpera.PesoEnts"
  Column3.ControlSource = "TmpOpera.Pfalhae"
  Column4.ControlSource = "TmpOpera.Falhae"
  Column5.ControlSource = "TmpOpera.PesoBEnts"
  ControlSource = "TmpOpera.Pfalhae"
  ControlSource = "TmpOpera.Falhae"
  DeleteMark = .F.
  Column1.ControlSource = "TmpOpera.TpOps"
  Column2.ControlSource = "TmpOpera.PesoSais"
  Column3.ControlSource = "TmpOpera.PFalha"
  Column4.ControlSource = "TmpOpera.Falha"
  Column5.ControlSource = "TmpOpera.PesoBSais"
  DeleteMark = .F.
  Column1.ControlSource = "TmpResFas.OpFase"
  Column2.ControlSource = "TmpResFas.Qtds"
  Column3.ControlSource = "TmpResFas.Qtdpcs"
  Column4.ControlSource = "TmpResFas.Pesos"
  ControlSource = "TmpResFas.OpFase"
  ControlSource = "TmpResFas.Qtds"
  ControlSource = "TmpResFas.Qtdpcs"
  DeleteMark = .F.
  Column1.ControlSource = "TmpResumo.CMats"
  Column2.ControlSource = "TmpResumo.Flag"
  Column3.ControlSource = "TmpResumo.Flag3"
  DeleteMark = .F.
  ControlSource = "crSigCdFcx.Datais"
  ControlSource = "crSigCdFcx.Datas"
  ControlSource = ""
  ControlSource = "crSigCdFcx.Codigos"
  ControlSource = ""
  ControlSource = "crSigCdFcx.Contas"
  ControlSource = "crSigCdFcx.Grupos"
  ControlSource = "crSigCdFcx.Datas"
=Seek(_Grupo, 'TmpGccr', 'BalCodigo')
Select TmpResumo
lcQuery = [Select Emps, Codigos, CPros, Saldos, Entradas, Saidas, Pesagems, FReals, FAdmins ] + ;
		    [From SigOpCfe ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFeres') < 1)
Select LocalFeres
	=Seek(LocalFeres.Cpros, 'TmpPro', 'CPros')
	lcSql = [Select nAgMts From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
	Insert Into TmpResumo (CMats, Saldoi, QtdeEnts, QtdeSais, Pesagem, FReal, FAdmin, Saldof, Grupo, Conta, Visivel, Flag3 );
Select TmpOpera
lcQuery = [Select Emps, Codigos, CPros, TpOps, PesoSais, PesoEnts, PFalhas, Falhas, PesoBSais ] + ;
		    [From SigCdFes ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFesai') < 1)
Select LocalFesai
		=Seek(LocalFesai.TpOps, 'crSigOpOpt', 'Cods')
		Insert Into TmpOpera (CMats, TpOps, QtdeSais, QtdeEnts, PFalha, Falha, PesoSais, PesoEnts, ;
		Select TmpResumo
lcQuery = [Select Emps, Codigos, CMats, Opers, Fases, Pesos, Pecas ] + ;
		    [From SigBlRes ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalResb') < 1)
Select LocalResb
	Insert Into TmpResFas (CMats, Opers, Fases, Qtds, QtdPcs, OpFase, Pesos );
Select TmpResFas
Select TmpOpera
Select TmpResumo
lcQuery = [Select Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs, nLotes ] + ;
			[From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
lcQuery = [Select b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Peso2s ] + ;
			[From SigCdNec a, SigCdNei b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
Select LocalNensI
lcQuery = [Select b.EmpDNPs, a.dopps, a.numps, b.CMats, p.DPros, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Peso2s, a.grupoos, a.contaos, a.datas, ] + ;
			[From SigCdNec a, SigCdNei b Left Join SigCdPro p On b.CMats = p.CPros ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalServ') < 1)
Select LocalServ
Select LocalNens
	loBarra.UpDate(.t.)
	=Seek(LocalNens.Dopps, 'LocalOpp', 'Dopps')
	Select LocalNensI
		=Seek(LocalNensI.CMats, 'TmpPro', 'CPros')
lcQuery = [Select Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses ] + ;
			[From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEest') < 1)
lcQuery = [Select b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.pesos ] + ;
			[From SigMvCab a, SigMvItn b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
Select LocalEestI
Select LocalEest
	loBarra.Update(.t.)
	=Seek(LocalEest.Dopes, 'crSigCdOpe', 'Dopes')
	Select LocalEestI
		=Seek(LocalNensI.CMats, 'TmpPro', 'CPros')
Select a.Grupo, a.Conta, a.CMats, Count(a.TpOps) as TotTpOp, Sum(c.IndProds) as TotIndProd, d.Freal, Sum(a.QtdeSais) as TotQtde  ;
  From TmpOpera a, crSigOpOpt c, TmpResumo d ;
Select a.Grupo, a.Conta, a.CMats, ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) as IndProd ;
	From TmpIndProd a Into Cursor TmpIndProd
Update TmpResumo set IndProd = TmpIndProd.IndProd where TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats	
Select Dopps, 1 as nMarcas from TmpHist Group By Dopps into cursor CrOpp readwrite
	.Column1.ControlSource = 'crOpp.nMarcas'
	.Column2.ControlSource = 'crOpp.Dopps'
=Seek(crSigCdFcx.Contas, 'TmpCli', 'BalCodigo')
Insert Into TmpCabec (SubTitulo, Empresa) Values (_SubTitulo, Iif(Eof('LocalEmp'), '', LocalEmp.Razas))
Select TmpResumo
	Select TmpCabec
	Select TmpResumo
	Select * ;
	  From TmpResumo ;
	Select TmpResumo
	Select * ;
	  From TmpResumo ;
	Select TmpCabec
	Select TmpOpera
	Select a.Grupo, a.Conta, a.cMats, 'Entradas' as Titulo, a.TpOps, a.pFalhaE as pFalha, Sum(a.QtdeEnts) as Qtde, ;
	  From TmpOpera a, csResumo b ;
	Select a.Grupo, a.Conta, a.CMats, 'Saidas  ' as Titulo, a.TpOps, a.pFalha, Sum(a.QtdeSais) as Qtde, ;
	  From TmpOpera a, csResumo b ;
	Select TmpOpera2
		Select TmpResFas
		Select TmpOpera2
			=Seek(TmpOpera2.TpOps,'crSigOpOpt','Cods')
			Select TmpItem
			Select TmpResFas
		Select TmpResFas
			Select TmpItem
	Select a.Grupo, a.Conta, a.CMats, Count(a.TpOps) as TotTpOp, Sum(c.IndProds) as TotIndProd, d.Freal, Sum(a.QtdeSais) as TotQtde  ;
	  From TmpOpera a, csResumo b, crSigOpOpt c, TmpResumo d ;
	Select a.Grupo, a.Conta, a.CMats, ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) as IndProd ;
		From TmpIndProd a Into Cursor TmpIndProd
	Update TmpItem set IndProd = TmpIndProd.IndProd where TmpItem.Grupo + TmpItem.Conta + TmpItem.CMats = TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
	Select TmpResFas
		Select TmpItem
		Select Distinct CMats From TmpItem Into Cursor crMateriais
		Select crMateriais
			Insert Into crImpressao (CMats, Perdas) Values (crMateriais.CMats, TmpResumo.FReal)
			Select Sum(Iif(a.Titulo = [Entradas], a.Qtde, 0.000)) as QtdeE, ; 
			  From TmpItem a ;
			Select crEntSais
			Select Sum(Iif(b.IndProds <> 0, a.Qtde, 0.000)) as QtdeL, a.Conta ;
			  From TmpItem a, crSigOpOpt b ;
			Select crEntSais
			Select LocalCta
			Insert Into TmpCabec (SubTitulo) Values (lcSub)
		Select crImpressao
	Select TmpOpera2
	Select TmpResumo
	Select TmpCabec
	Select TmpHist
		Select 'GERAL         ' as CMats, Dopps, Numps, TpOps, Datas, Grupo, Conta, Opers, Grupo2, Conta2, ;
		  From TmpHist ;
		Select a.*, b.Obss From TmpHistz a, TmpHistC b ;
			Select 'GERAL         ' as CMats, Dopps, Numps, ' ' as TpOps, Datas, Grupo, Conta, Opers, Grupo2, Conta2, ;
			From TmpHist ;
			Select a.*, b.Obss From TmpHistz a, TmpHistC b ;
				Select 'GERAL         ' as CMats, Dopps, Numps, Nenvs, TpOps, Datas, Grupo, Conta, Opers, Grupo2, Conta2, ;
				  From TmpHist ;
				Select a.*, b.Obss From TmpHistz a, TmpHistC b ;
					Select a.CMats, a.Dopps, a.Numps, a.Nenvs, a.TpOps, a.Datas, a.Opers, Sum(a.QtdeEnts) as QtdeEnts, Sum(a.QtdeSais) as QtdeSais, b.SaldoI, 1 as TpOp ;
					  From TmpHist a, TmpResumo b, LocalOpp c Where a.cmats = b.cmats and b.flag3 And ;
					Select a.CMats, a.Dopps, a.Numps, a.Nenvs, a.TpOps, a.Datas, a.Opers, Sum(a.QtdeEnts) as QtdeEnts, Sum(a.QtdeSais) as QtdeSais, b.SaldoI, 2 as TpOp ;
					  From TmpHist a, TmpResumo b, CrSigCdOpe c Where a.cmats = b.cmats and b.flag3 And ;
					Select TmpHist2
							Select dbImpressao
						Select DbImpressao
							lcSql = [Select b.Nenvs,b.CidChaves,a.cpros,a.dpros from SigPdMvf b, SigOpPic a Where b.EmpDnPs = ']+lcEdn+[' ]+;
							=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
							Select TmpOpi
									Select dbImpressao
					Select dbImpressao
						Select a.nLotes, a.CMats, a.Dopps, a.Numps, a.TpOps, a.Datas, Sum(a.QtdeEnts) as QtdeEnts, Sum(a.QtdeSais) as QtdeSais, a.Dopps + ' '+Str(a.Numps,10) as Descrs  ;
						  From TmpHist a, TmpResumo b, LocalOpp c Where a.cmats = b.cmats and b.flag3 And ;
						Select CMats, Dopps, Numps, TpOps, Datas, Grupo, Conta, Opers, Grupo2, Conta2, Cunis, ;
						  From TmpHist ;
						Select a.*, b.Obss From TmpHistz a, TmpHistC b ;
	Select crOpp
	Select * from TmpHist2 Where Dopps in &lcOperacao. into cursor TmpHist2
	Select TmpHist2
			Select DbImpressao
				Select TmpHist2
	Select TmpResumo
	Select LocalServ
Select TmpResumo
	Select LocalNens
	Select LocalEest
	Insert Into TmpHist (Grupo, Conta, CMats, TpOps, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
	If Not Seek(LocalNens.EmpDnPs,'TmpHistC','EmpDnPs')
		Insert Into TmpHistC (EmpDnPs, Obss ) Values (LocalNens.EmpDnps,TmpHist.Obss)
	Insert Into TmpHist (Grupo, Conta, CMats, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
	If Not Seek(LocalEest.Emps + LocalEest.Dopes + Str(LocalEest.Numes,10),'TmpHistC','EmpDnPs')
		Insert Into TmpHistC (EmpDnPs, Obss ) Values ;
Select crSigCdFcx
lcQryFecha = [Select a.*, b.RClis ] + ;
			   [From SigCdFcx a, SigCdCli b ] + ;
		.Pagina.Lista.Grade.Column5.ControlSource = [Nvl(crSigCdFcx.DataIs, Ctot(''))]
		.Pagina.Lista.Grade.Column6.ControlSource = [Nvl(crSigCdFcx.Datas,  Ctot(''))]
		Select crSigOpOpt
		Select LocalOpp
		Select crSigCdOpe
		Select CrSigCdCrg
		lcQuery = [Select Codigos, Descrs, UnifBals, GruFals ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpGccr') < 1)
		Select TmpGccr
			lcQuery = [Select IClis, RClis, Grupos, PagFals, RecFals, GruFals, Inativas ] + ;
					    [From SigCdCli ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
			Select TmpCli
			lcQuery = [Select CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs ] + ;
					    [From SigCdPro]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPro') < 1)
			Select TmpPro
lcQuery = [Delete From SigMvCab Where EmpDopNums = '] + _Edns + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigMvItn Where EmpDopNums = '] + _Edns + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select ExcluiHis
		lcQuery = [Delete From SigMvHst Where cIdChaves = '] + ExcluiHis.cIdChaves + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select LocalMccr
		lcQuery = [Delete From SigMvCcr Where cIdChaves = '] + LocalMccr.cIdChaves + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigOpCfe ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigCdFes ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigBlRes ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigCdFea ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcSql = [Select CidChaves From SigCdNec Where Numbals = ]+Str(CrSigCdFcx.Codigos,6)
	If (ThisForm.poDataMgr.SqlExecute(lcSql,'TmpNens') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec 1)')
		Select TmpNens
			lcUpDate = [Update SigCdNec Set ProcBals = ?llFalse, NumBals = 0 Where cidChaves = ']+TmpNens.cidChaves+[']
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec)')
			lcSql = [Select CidChaves From SigCdNec Where Numbalds = ]+Str(CrSigCdFcx.Codigos,6)
			If (ThisForm.poDataMgr.SqlExecute(lcSql,'TmpNens') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec 2)')
				Select TmpNens
					lcUpDate = [Update SigCdNec Set ProcDbal = ?llFalse, NumBalds = 0 Where cidChaves = ']+TmpNens.CidChaves+[']
					If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec 3)')
	lcSql = [Select CidChaves From SigMvCab Where NumBals = ]+Str(CrSigCdFcx.Codigos,6)
	If (ThisForm.poDataMgr.SqlExecute(lcSql,'TprMvCab') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigMvCab)')
		Select TprMvCab
			lcUpDate = [Update SigMvCab Set ProcBals = ?llFalse, NumBals = 0 Where CidChaves = ']+TprMvCab.CidChaves+[']
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigMvCab 1)')
			lcSql = [Select CidChaves From SigMvCab Where NumBalds = ]+Str(CrSigCdFcx.Codigos,6)
			If (ThisForm.poDataMgr.SqlExecute(lcSql,'TprMvCab') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigMvCab)')
				Select TprMvCab
					lcUpDate = [Update SigMvCab Set ProcdBal = ?llFalse, NumBalds = 0 Where CidChaves = ']+TprMvCab.CidChaves+[']
					If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdNec)')
	lcUpDate = [Update SigCdPsc Set ProcBals = ?llFalse , NumBals = 0 Where NumBals = ]+Str(CrSigCdFcx.codigos,6)
	If (ThisForm.poDataMgr.SqlExecute(lcUpDate, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update SigCdPsc)')
=Seek(_Dope, 'crSigCdOpe', 'Dopes')
Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos, ;
Select TmpResumo
	=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
	lcSql = [Select GruEstPs,ConEstPs,nAgMts,TipoEstos From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
	Insert Into crSigOpCfe (Emps, Codigos, CPros, Saldos, Entradas, Saidas, Pesagems, FReals, FAdmins, cIdChaves, IndProds) ;
		lcQuery = [Select Top 1 EmpGruEsts, Cpros, cIdChaves, Sqtds, CodCors, CodTams, sPesos ] + ;
					[From SigMvHst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
	Select LocalHis
	Select TmpResumo
		Insert Into crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, EmpDopNums, cIdChaves, Dtalts, cItens, Pesos ) ;
			Insert Into CrSigMvIts (Emps, dopes, Numes, Cpros, Qtds, cItens, CodCors, CodTams, CidChaves, Pesos  ) Values ;
		Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
			Insert Into crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Cpros, Qtds, Opers, Grupos, Estos, ;
Select TmpResFas
	Insert Into crSigBlRes (Emps, Codigos, Opers, CMats, Fases, Pesos, Pecas, cIdChaves) ;
Select TmpOpera
	Insert Into crSigCdFes (Emps, Codigos, CPros, TpOps, PesoSais, PesoEnts, PFalhas, Falhas, cIdChaves, PesoBSais) ;
=Seek(crSigCdFcx.Grupos, 'TmpGccr', 'BalCodigo')
=Seek(crSigCdFcx.Contas, 'TmpCli', 'BalCodigo')
Select TmpResumo
		=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
				Select LocalHis
				lcQuery = [Select Top 1 cIdChaves, UnitMeds ] + ;
							[From SigMvHst ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
			Select LocalHis
		=Seek(_Moeda, 'TmpCot')
		Select crSigMvCcr 
		Insert Into crSigMvCcr (NOpers, Emps, Datas, UsuAlts, DatAlts, Vencs, Hists, Autos, Tipos, Dopes, ;
		Select CrSigMvCcr
		Insert Into crSigMvCcr (NOpers, Emps, Datas, UsuAlts, DatAlts, Vencs, Hists, Autos, Tipos, Dopes, ;
		Select CrSigMvCcr
			Select crSigMvCcr 
				=Seek(_MoeLanca, 'TmpCot')
			Insert Into crSigMvCcr (NOpers, Emps, Datas, UsuAlts, DatAlts, Vencs, Hists, Autos, Tipos, Dopes, Numes, ;
			Select CrSigMvCcr
			Insert Into crSigMvCcr (NOpers, Emps, Datas, UsuAlts, DatAlts, Vencs, Hists, Autos, Tipos, Dopes, Numes, ;
			Select CrSigMvCcr
	If Not ThisForm.poDataMgr.Update('crSigMvCab')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
	If Not ThisForm.poDataMgr.Update('crSigMvItn')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
	If Not ThisForm.poDataMgr.Update('crSigMvIts')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvIts)')
	If Not ThisForm.poDataMgr.Update('crSigMvHst')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
	If Not ThisForm.poDataMgr.Update('crSigOpCfe')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpCfe)')
	If Not ThisForm.poDataMgr.Update('crSigBlRes')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigBlRes)')
	If Not ThisForm.poDataMgr.Update('crSigCdFes')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdFes)')
	If Not ThisForm.poDataMgr.Update('crSigMvCcr')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCcr)')
	If Not ThisForm.poDataMgr.Update('crSigCdFea')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdFea)')
	If Not ThisForm.poDataMgr.Update('crSigCdFcx')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdFcx)')
Select crSigCdFcx
=Seek(crSigCdFcx.Grupos, 'TmpGccr', 'BalCodigo')
=Seek(crSigCdFcx.Contas, 'TmpCli', 'BalCodigo')
Select crSigCdFcx
Select crSigCdFcx
Select TmpOpera
Select TmpOpera
Select TmpResumo
Select TmpResumo
Select TmpResumo
	Select TmpOpera
	Select TmpResFas
Select TmpResumo
	Select TmpOpera
Select TmpOpera
Select TmpResFas
Select TmpResumo
=Seek(_Grupo, 'TmpGccr', 'BalCodigo')
lcQuery = [Select Top 1 Datas ] + ;
			[From SigCdFcx ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crDtUBal') < 1)
lcQuery = [Select Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs, nLotes ] + ;
			[From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
lcQuery = [Select b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams ] + ;
		  [From SigCdNec a, SigCdNei b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
Select LocalNensI
lcQuery = [Select b.EmpDNPs, a.dopps, a.numps, b.CMats, p.DPros, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams, b.fators, a.grupoos, a.contaos, ] + ;
		  [From SigCdNec a, SigCdNei b Left Join SigCdPro p On b.CMats = p.CPros ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalServ') < 1)
Select LocalServ
lcQuery = [Select b.EmpDNPs, b.Qtds, b.cIdChaves ] + ;
		  [From SigCdNec a, SigPdMvf b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
Select LocalMFas
lcSql = [Select Cgrus,GruEstPs,ConEstPs,nAgMts,TipoEstos,Mercs From SigCdGrp ]
=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
Select LocalGru
lcSql = [Select Codigos,Aplicflhs From SigCdGpr ]
=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
Select LocalGgrp
Select LocalNens
	loBarra.UpDate(.t.)
	=Seek(LocalNens.Dopps, 'LocalOpp', 'Dopps')
	Select LocalNensI
				lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
				=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
				=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
				lcSql = [Select Cpros From SigOpPic where Nops = ]+Str(LocalNensi.Nops)
				=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpOpi')
					=Seek(TmpOpi.Cpros,'TmpPro','Cpros')
		=Seek(LocalNensI.CMats, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
			If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs, 'TmpConta')
				=Seek(LocalNens.ContaOs, 'TmpCli', 'BalCodigo')
				Insert Into TmpConta (Grupo, Conta, Nome) Values (LocalNens.GrupoOs, LocalNens.ContaOs, TmpCli.RClis)
			If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + lcCodCor + lcCodTam, 'TmpResumo')
				Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
			Select TmpResumo
			If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + LocalNensI.TpOps, 'TmpOpera')
				Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, Aplicflhs ) ;
			Select TmpOpera
			=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
				If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoDs, 'TmpResFas', 'Fases')
					Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
				If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoDs, 'TmpResFas', 'Fases')
					Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
				Select TmpPrz
				If Not Seek(' ' + Dtos(LocalNens.Datas) + LocalNensI.TpOps)
			If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs, 'TmpConta')
				=Seek(LocalNens.ContaDs, 'TmpCli', 'BalCodigo')
				Insert Into TmpConta (Grupo, Conta, Nome) Values (LocalNens.GrupoDs, LocalNens.ContaDs, TmpCli.RClis)
			If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats+ lcCodCor + lcCodTam, 'TmpResumo')
				Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams ) ;
			Select TmpResumo
			If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + LocalNensI.TpOps, 'TmpOpera')
				Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs ) ;
			Select TmpOpera
			=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
				If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoOs, 'TmpResFas', 'Fases')
					Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
				If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoOs, 'TmpResFas', 'Fases')
					Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
		=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
			=Seek(_Material, 'TmpPro', 'CPros')
			=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, visivel ) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material + LocalNensI.TpOps, 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, VArias, Agregas, AplicFlhs ) ;
				Select TmpOpera
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material , 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel ) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material + LocalNensI.TpOps, 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs ) ;
				Select TmpOpera
		If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoOs, 'TmpResFas', 'Fases')
			Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
		If Not Seek(_MatResFa + _Operacao + LocalNens.GrupoDs, 'TmpResFas', 'Fases')
			Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
	Select LocalMFas
			lcUpdate = [Update SigCdNec Set ProcBals = ?llTrue, NumBals = ]+Str(crSigCdFcx.Codigos,6)+[  ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigCdNec)')
			lcUpdate = [Update SigCdNec Set ProcDBal = ?llTrue, NumBalds = ]+Str(crSigCdFcx.Codigos, 6)+[  ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigCdNec)')
lcQuery = [Select Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves ] + ;
			[From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEest') < 1)
lcQuery = [Select b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens ] + ;
			[From SigMvCab a, SigMvItn b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEestI') < 1)
Select LocalEestI
lcQuery = [Select b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens ] + ;
			[From SigMvCab a, SigMvIts b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEsti2') < 1)
Select LocalEsti2
Select LocalEest
	loBarra.Update(.t.)
	=Seek(LocalEest.Dopes, 'crSigCdOpe', 'Dopes')
	Select LocalEestI
		=Seek(LocalEesti.Cpros, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
		Select LocalEsti2
		If Seek(LocalEesti.EmpDopNums + LocalEesti.Cpros + Str(LocalEesti.Citens,4))
					If Not Seek(_Grupo + _Conta, 'TmpConta')
						=Seek(LocalEest.ContaOs, 'TmpCli', 'BalCodigo')
						Insert Into TmpConta (Grupo, Conta, Nome) Values (_Grupo, _Conta, TmpCli.RClis)
					If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams  ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, AplicFlhs ) ;
					Select TmpOpera
						If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
							Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
						If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
							Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
					If Not Seek(_Grupo + _Conta, 'TmpConta')
						=Seek(_Conta, 'TmpCli', 'BalCodigo')
						Insert Into TmpConta (Grupo, Conta, Nome) Values (_Grupo, _Conta, TmpCli.RClis)
					If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel, CodCors, CodTams ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, AplicFlhs ) ;
					Select TmpOpera
						If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
							Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
						If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
							Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
				If Not Seek(_Grupo + _Conta, 'TmpConta')
					=Seek(LocalEest.ContaOs, 'TmpCli', 'BalCodigo')
					Insert Into TmpConta (Grupo, Conta, Nome) Values (_Grupo, _Conta, TmpCli.RClis)
				If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel  ) ;
				Select TmpResumo
				If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs ) ;
				Select TmpOpera
					If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
						Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
					If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
						Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
				If Not Seek(_Grupo + _Conta, 'TmpConta')
					=Seek(_Conta, 'TmpCli', 'BalCodigo')
					Insert Into TmpConta (Grupo, Conta, Nome) Values (_Grupo, _Conta, TmpCli.RClis)
				If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
				Select TmpResumo
				If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs ) ;
				Select TmpOpera
					If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
						Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
					If Not Seek(_MatResFa + _Operacao + _Grupod, 'TmpResFas', 'Fases')
						Insert Into TmpResFas (Cmats, Opers, Fases, OpFase) ;
		lcUpdate = [Update SigMvCab Set ]+Iif(_OrigemF,[ProcBals = ?llTrue, NumBals = ]+Str(crSigCdFcx.Codigos, 6)+[  ],[])+;
		If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigMvCab)')
lcSql = [Select * From SigMvEst Where EmpGruEsts = ']+lcEGE+[']
If (ThisForm.poDataMgr.SqlExecute(lcSql,'CrSalEst') < 1)
Select CrSalEst
	=Seek(CrSalEst.Cpros, 'TmpPro', 'CPros')
	=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
	=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
	If Not Seek(CrSigCdFcx.Grupos + CrSigCdFcx.Contas + CrSalEst.Cpros + lcCodCor + lcCodTam, 'TmpResumo')
		Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
lcQuery = [Select Emps, Codigos, CidChaves ] + ;
			[From SigCdPsc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPesa') < 1)
Select LocalPesa
	lcQuery = [Select CPros, Qtds, Pesos ] + ;
				[From SigCdPsi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPesaI') < 1)
	Select LocalPesaI
		=Seek(LocalPesaI.CPros, 'TmpPro', 'CPros')
		=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
		=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
		If Not Seek(_Grupo + _Conta + LocalPesaI.CPros, 'TmpResumo')
			Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
		Select TmpResumo
		Select TmpResumo
		Select [ ] as Agregar, Sum(Pesagem) as Pesagem From TmpResumo ;
	Select TmpResumo
		lcUpdate = [Update SigCdPsc Set ProcBals = ?llTrue, NumBals = ]+Str(crSigCdFcx.Codigos, 6)+[ ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigCdPsc)')
Select TmpResumo
Select TmpOpera
	Select TmpResumo
	Select [ ] as Agregar,Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
	  From TmpResumo ;
	Select TmpResumo
	Select Grupo, Conta, TpOps, Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
	  From TmpOpera ;
	=Seek(lcMat, 'TmpPro', 'CPros')
	=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
	=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
	Select csTotal
		If Not Seek(csTotal.Grupo + csTotal.Conta + lcMat + csTotal.TpOps, 'TmpOpera')
			Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, Aplicflhs ) ;
	Select Grupo, Conta, TpOps, Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
	  From TmpOpera ;
	Select csTotal
		If Not Seek(csTotal.Grupo + csTotal.Conta + lcMat + csTotal.TpOps, 'TmpOpera')
			Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, Aplicflhs ) ;
lcQuery = [Select Codigos ] + ;
			[From SigCdFcx ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrUltBal') < 1)
Select CrUltBal
	lcSql = [Select * From SigOpCfe Where Codigos = ]+Str(CrUltBal.Codigos,6)+[ And Emps = ']+ThisForm.pEmps+[' Order by Codigos, cpros ]
	lcSql = [Select * From SigOpCfe Where 0 = 1 ]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSaldoI') < 1
Select CrSaldoI
Select TmpResumo
	loBarra.Update(.t.)
	=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
	Select CrSaldoI
	=Seek(TmpResumo.Cmats)
	Select TmpOpera
	=Seek(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
		=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
	Select TmpResumo
	=Seek(crSigCdFcx.Contas, 'TmpCli', 'BalCodigo')
Select CrSaldoI
	loBarra.Update(.t.)
	=Seek(CrSaldoI.Cpros, 'TmpPro', 'CPros')
	=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
	=Seek(LocalGru.Mercs,'LocalGgrp','Codigos')
	Select TmpResumo
		Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
		Select TmpResumo
Select TmpResumo
	=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
	=Seek(TmpPro.Cgrus,'LocalGru','Cgrus')
			Select LocalHis
			lcQuery = [Select Top 1 cIdChaves, UnitMeds ] + ;
						[From SigMvHst ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
		Select LocalHis
	If Not Seek(_Moeda, 'TmpCot')
		Insert Into TmpCot (Cmoes, Valos) Values (_Moeda, _Cota)
Select LocalMoe
	If Not Seek(LocalMoe.Cmoes, 'TmpCot')
		Insert Into TmpCot (Cmoes, Valos) Values (LocalMoe.Cmoes, _Cota)
Select TmpResumo
Select TmpOpera
Select TmpResFas
Select TmpResumo
Select a.Grupo, a.Conta, a.CMats, Count(a.TpOps) as TotTpOp, Sum(c.IndProds) as TotIndProd, d.Freal, Sum(a.QtdeSais) as TotQtde  ;
  From TmpOpera a, crSigOpOpt c, TmpResumo d ;
Select a.Grupo, a.Conta, a.CMats, ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) as IndProd ;
	From TmpIndProd a Into Cursor TmpIndProd
Update TmpResumo set IndProd = TmpIndProd.IndProd where TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats	
Select Dopps, 1 as nMarcas from TmpHist Group By Dopps into cursor CrOpp readwrite
	.Column1.ControlSource = 'crOpp.nMarcas'
	.Column2.ControlSource = 'crOpp.Dopps'
	Insert Into CrSigCdFea (Grupos,Contas,Datas,Emps,Falhas,Numes,Produzidos,Tipos,Trabs,CidChaves,NumBals) Values ;
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	If Not Seek(This.Value, 'TmpGccr', 'BalDescrs')
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	If Not Seek(This.Value, 'TmpGccr', 'BalCodigo')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg) - TRECHOS RELEVANTES PARA PASS SQL (5371 linhas total):

*-- Linhas 521 a 539:
521:             .HighlightBackColor = RGB(255, 255, 255)
522:             .HighlightForeColor = RGB(15, 41, 104)
523:             .HighlightStyle     = 2
524:             .DeleteMark         = .F.
525:             .RecordMark         = .F.
526:             .RowHeight          = 16
527:             .ScrollBars         = 2
528:             .GridLines          = 3
529:             .Visible            = .T.
530:         ENDWITH
531:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
532:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
533: 
534:         THIS.TornarControlesVisiveis(loc_oPagina)
535:     ENDPROC
536: 
537:     *==========================================================================
538:     * ConfigurarPaginaDados - Configura Page2 (edicao + resultado de balanco)
539:     * FASE 5: container BotoesAcao + botoes Confirmar/Cancelar + Shape +

*-- Linhas 970 a 1012:
970: 
971:     *==========================================================================
972:     * CarregarLista - Carrega/recarrega grid da Page1 com dados do periodo filtrado
973:     * OBRIGATORIO: rebind ControlSource + Headers APOS RecordSource (Problema 2/48)
974:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
975:     *==========================================================================
976:     PROCEDURE CarregarLista()
977:         LOCAL loc_lResultado, loc_oGrid, loc_cEmp, loc_dDtI, loc_dDtF
978:         loc_lResultado = .F.
979: 
980:         TRY
981:             loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
982:             loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
983:             loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
984: 
985:             THIS.this_oBusinessObject.PreencherFiltro(loc_cEmp, loc_dDtI, loc_dDtF)
986: 
987:             IF THIS.this_oBusinessObject.Buscar("")
988:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
989: 
990:                 loc_oGrid.ColumnCount  = 5
991:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
992: 
993:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
994:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
995:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
996:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
997:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datais"
998: 
999:                 loc_oGrid.Column1.Width = 70
1000:                 loc_oGrid.Column2.Width = 120
1001:                 loc_oGrid.Column3.Width = 120
1002:                 loc_oGrid.Column4.Width = 200
1003:                 loc_oGrid.Column5.Width = 200
1004: 
1005:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d."
1006:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1007:                 loc_oGrid.Column3.Header1.Caption = "Conta"
1008:                 loc_oGrid.Column4.Header1.Caption = "Data Encerramento"
1009:                 loc_oGrid.Column5.Header1.Caption = "Data In" + CHR(237) + "cio"
1010: 
1011:                 THIS.FormatarGridLista(loc_oGrid)
1012: 

*-- Linhas 1084 a 1102:
1084:         loc_cCidChaves = ""
1085: 
1086:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1087:             SELECT cursor_4c_Dados
1088:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1089:         ENDIF
1090: 
1091:         IF EMPTY(loc_cCidChaves)
1092:             MsgAviso("Selecione um registro para visualizar.")
1093:         ELSE
1094:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1095:                 THIS.this_cPcEscolha = "CONSULTAR"
1096:                 THIS.this_cModoAtual = "VISUALIZAR"
1097:                 THIS.AlternarPagina(2)
1098:                 THIS.AjustarBotoesPorModo()
1099:                 THIS.HabilitarCampos()
1100:             ENDIF
1101:         ENDIF
1102:     ENDPROC

*-- Linhas 1110 a 1128:
1110:         loc_cCidChaves = ""
1111: 
1112:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1113:             SELECT cursor_4c_Dados
1114:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1115:         ENDIF
1116: 
1117:         IF EMPTY(loc_cCidChaves)
1118:             MsgAviso("Selecione um registro para alterar.")
1119:         ELSE
1120:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1121:                 THIS.this_oBusinessObject.EditarRegistro()
1122:                 THIS.this_cPcEscolha = "ALTERAR"
1123:                 THIS.this_cModoAtual = "ALTERAR"
1124:                 THIS.AlternarPagina(2)
1125:                 THIS.AjustarBotoesPorModo()
1126:                 THIS.HabilitarCampos()
1127:             ENDIF
1128:         ENDIF

*-- Linhas 1138 a 1156:
1138:         loc_lConfirma  = .F.
1139: 
1140:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1141:             SELECT cursor_4c_Dados
1142:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1143:         ENDIF
1144: 
1145:         IF EMPTY(loc_cCidChaves)
1146:             MsgAviso("Selecione um registro para excluir.")
1147:         ELSE
1148:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1149:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1150:                     "Confirmar Exclus" + CHR(227) + "o")
1151:                 IF loc_lConfirma
1152:                     IF THIS.this_oBusinessObject.Excluir()
1153:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1154:                         THIS.CarregarLista()
1155:                     ENDIF
1156:                 ENDIF

*-- Linhas 1319 a 1406:
1319:         TRY
1320:             *-- crSigCdPac - parametros de conta do balanco
1321:             IF !USED("crSigCdPac")
1322:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
1323:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
1324:             ENDIF
1325: 
1326:             *-- crSigCdPam - parametros de material do balanco
1327:             IF !USED("crSigCdPam")
1328:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
1329:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
1330:             ENDIF
1331: 
1332:             *-- TmpGccr - grupos de balanco da empresa (SigCdGcc)
1333:             *-- Campos: Codigos (BalCodigo), Descrs (BalDescrs), UnifBals, GruFals, etc.
1334:             IF !USED("TmpGccr")
1335:                 loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals, BalCodigo, BalDescrs FROM SigCdGcc " + ;
1336:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr)
1337:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
1338:                     SELECT TmpGccr
1339:                     INDEX ON BalCodigo  TAG BalCodigo
1340:                     INDEX ON BalDescrs  TAG BalDescrs
1341:                     SET ORDER TO BalCodigo
1342:                 ENDIF
1343:             ENDIF
1344: 
1345:             *-- TmpCli - contas de balanco (clientes/contas correntes)
1346:             IF !USED("TmpCli")
1347:                 loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
1348:                            "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
1349:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
1350:                     SELECT TmpCli
1351:                     INDEX ON BalCodigo TAG BalCodigo
1352:                     INDEX ON BalNome   TAG BalNome
1353:                     SET ORDER TO BalCodigo
1354:                 ENDIF
1355:             ENDIF
1356: 
1357:             *-- TmpPro - produtos/materiais (SigCdPro)
1358:             IF !USED("TmpPro")
1359:                 loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
1360:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
1361:                     SELECT TmpPro
1362:                     INDEX ON CPros TAG CPros
1363:                     SET ORDER TO CPros
1364:                 ENDIF
1365:             ENDIF
1366: 
1367:             *-- crSigOpOpt - opcoes de operacao (SigOpOpt)
1368:             IF !USED("crSigOpOpt")
1369:                 loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
1370:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
1371:                     SELECT crSigOpOpt
1372:                     INDEX ON Cods TAG Cods
1373:                     SET ORDER TO Cods
1374:                 ENDIF
1375:             ENDIF
1376: 
1377:             *-- LocalOpp - tipos de operacao de producao (SigCdNop)
1378:             IF !USED("LocalOpp")
1379:                 loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
1380:                 IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
1381:                     SELECT LocalOpp
1382:                     INDEX ON Dopps TAG Dopps
1383:                     SET ORDER TO Dopps
1384:                 ENDIF
1385:             ENDIF
1386: 
1387:             *-- crSigCdOpe - tipos de operacao de estoque (SigCdOpe)
1388:             IF !USED("crSigCdOpe")
1389:                 loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
1390:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
1391:                     SELECT crSigCdOpe
1392:                     INDEX ON Dopes TAG Dopes
1393:                     SET ORDER TO Dopes
1394:                 ENDIF
1395:             ENDIF
1396: 
1397:         CATCH TO loc_oErro
1398:             MsgErro("Erro em CarregarDadosAuxiliares:" + CHR(13) + loc_oErro.Message, "FormFea")
1399:         ENDTRY
1400:     ENDPROC
1401: 
1402:     *==========================================================================
1403:     * BOParaForm - Preenche controles visuais a partir do BO / crSigCdFcx
1404:     * Fase 5: Codigo e Data (Grupo/Conta/Lote em Fase 6)
1405:     *==========================================================================
1406:     PROTECTED PROCEDURE BOParaForm()

*-- Linhas 1451 a 1469:
1451:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1452: 
1453:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1454:                 SELECT crSigCdFcx
1455:                 REPLACE crSigCdFcx.Datas WITH loc_oPagina.txt_4c_Data.Value
1456: 
1457:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1458:                     REPLACE crSigCdFcx.Grupos WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), LEN(crSigCdFcx.Grupos))
1459:                 ENDIF
1460:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1461:                     REPLACE crSigCdFcx.Contas WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Conta.Value), LEN(crSigCdFcx.Contas))
1462:                 ENDIF
1463:             ENDIF
1464:         CATCH TO loc_oErro
1465:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormFea")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *==========================================================================

*-- Linhas 1550 a 1592:
1550:                 *-- carregar do SigOpCfe (saldos salvos) vinculados ao crSigCdFcx
1551:                 IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1552:                     LOCAL loc_cSql
1553:                     loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
1554:                                TRANSFORM(crSigCdFcx.Codigos) + ;
1555:                                " AND Emps = " + EscaparSQL(ALLTRIM(crSigCdFcx.Emps)) + ;
1556:                                " ORDER BY Codigos, Cpros"
1557:                     IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoCarreg") > 0
1558:                         *-- Popula TmpResumo a partir dos saldos salvos
1559:                         IF !USED("TmpResumo")
1560:                             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), ;
1561:                                 CUnis C(10), Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), ;
1562:                                 Saldof N(12,3), PfTrabs N(8,2), IndProd N(8,2), ;
1563:                                 PesoEnts N(12,3), PesoSais N(12,3), QtdeEnts N(12,3), ;
1564:                                 QtdeSais N(12,3), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1565:                                 Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
1566:                                 Varias N(1), Agregas N(1), Visivel L, ;
1567:                                 Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
1568:                             INDEX ON Grupo + Conta + CMats TAG GrConMat
1569:                             SET ORDER TO GrConMat
1570:                         ELSE
1571:                             SELECT TmpResumo
1572:                             ZAP
1573:                             SET ORDER TO GrConMat
1574:                         ENDIF
1575:                         SELECT CrSaldoCarreg
1576:                         SCAN
1577:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, Saldof) ;
1578:                                 VALUES (crSigCdFcx.Grupos, crSigCdFcx.Contas, ;
1579:                                         CrSaldoCarreg.Cpros, CrSaldoCarreg.Pesagems)
1580:                         ENDSCAN
1581:                         IF USED("CrSaldoCarreg")
1582:                             USE IN CrSaldoCarreg
1583:                         ENDIF
1584:                         loc_lResultado = .T.
1585:                     ENDIF
1586:                 ENDIF
1587:             ENDIF
1588:         CATCH TO loc_oErro
1589:             MsgErro("Erro em CarregarDados:" + CHR(13) + loc_oErro.Message, "FormFea")
1590:         ENDTRY
1591:         RETURN loc_lResultado
1592:     ENDPROC

*-- Linhas 1712 a 1730:
1712:                     ENDIF
1713:                 ELSE
1714:                     *-- Modo posicao (!Fechamento): apenas reverter e voltar
1715:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1716:                     THIS.this_lFechamento = .T.
1717:                     THIS.AlternarPagina(1)
1718:                     loc_lResultado = .T.
1719:                 ENDIF
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loc_oErro.Message + ;
1723:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
1724:         ENDTRY
1725: 
1726:         RETURN loc_lResultado
1727:     ENDPROC
1728: 
1729:     *==========================================================================
1730:     * BtnSalvarClick - Alias canonico de BtnConfirmarClick

*-- Linhas 1748 a 1766:
1748:         TRY
1749:             THIS.this_lCancelar = .T.
1750:             *-- Rollback da transacao SQL corrente
1751:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1752:             THIS.this_lFechamento = .T.
1753:             THIS.AlternarPagina(1)
1754:             loc_lResultado = .T.
1755:         CATCH TO loc_oErro
1756:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "FormFea")
1757:         ENDTRY
1758: 
1759:         RETURN loc_lResultado
1760:     ENDPROC
1761: 
1762:     *==========================================================================
1763:     * IncluirHistorico - Insere registro nos cursores TmpHist e TmpHistC
1764:     * Traducao de inclui_historico (legado). Chamado em SCAN loops dentro
1765:     * de ProcessarBalanco para cada movimento de entrada/saida.
1766:     * PUBLIC: BINDEVENT/SCAN exige metodo publico (CLAUDE.md regra #3)

*-- Linhas 1785 a 1854:
1785:         ENDIF
1786: 
1787:         IF par_cArquivo = "Nens"
1788:             SELECT LocalNens
1789:             IF par_cTipoConta = "O"
1790:                 loc_cGrupo  = LocalNens.Grupoos
1791:                 loc_cConta  = LocalNens.Contaos
1792:                 loc_cGrupo2 = LocalNens.Grupods
1793:                 loc_cConta2 = LocalNens.Contads
1794:             ELSE
1795:                 loc_cGrupo  = LocalNens.Grupods
1796:                 loc_cConta  = LocalNens.Contads
1797:                 loc_cGrupo2 = LocalNens.Grupoos
1798:                 loc_cConta2 = LocalNens.Contaos
1799:             ENDIF
1800:         ELSE
1801:             SELECT LocalEest
1802:             loc_cGrupo  = IIF(TYPE("par_cGrupoo") = "C", par_cGrupoo, SPACE(10))
1803:             loc_cConta  = IIF(TYPE("par_cContao") = "C", par_cContao, SPACE(10))
1804:             loc_cGrupo2 = IIF(TYPE("par_cGrupod") = "C", par_cGrupod, SPACE(10))
1805:             loc_cConta2 = IIF(TYPE("par_cContad") = "C", par_cContad, SPACE(10))
1806:         ENDIF
1807: 
1808:         IF loc_nEntrada = 0 AND loc_nSaida = 0 AND loc_nPEntrada = 0 AND loc_nPSaida = 0
1809:             RETURN
1810:         ENDIF
1811: 
1812:         IF par_cArquivo = "Nens"
1813:             INSERT INTO TmpHist ;
1814:                 (Grupo, Conta, CMats, TpOps, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
1815:                  Grupo2, Conta2, PesoEnts, PesoSais, Nenvs, Obss, Opers, PesoFabre, PesoFabrs, cUnips, Emps, nLotes) ;
1816:                 VALUES ;
1817:                 (loc_cGrupo, loc_cConta, LocalNensI.CMats, LocalNensI.TpOps, LocalNens.Datas, ;
1818:                  loc_nEntrada, loc_nSaida, LocalNens.Dopps, LocalNens.Numps, LocalNensI.CUnis, ;
1819:                  loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, LocalNensI.Nenvs, ;
1820:                  NVL(LocalNens.Obss, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
1821:                  TmpPro.cUnips, LocalNens.Emps, LocalNens.nLotes)
1822: 
1823:             IF NOT SEEK(LocalNens.EmpDnPs, "TmpHistC", "EmpDnPs")
1824:                 INSERT INTO TmpHistC (EmpDnPs, Obss) ;
1825:                     VALUES (LocalNens.EmpDnPs, TmpHist.Obss)
1826:             ENDIF
1827:         ELSE
1828:             INSERT INTO TmpHist ;
1829:                 (Grupo, Conta, CMats, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
1830:                  Grupo2, Conta2, PesoEnts, PesoSais, Obss, Opers, PesoFabre, PesoFabrs, cUniPs, Emps) ;
1831:                 VALUES ;
1832:                 (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEest.Datas, ;
1833:                  loc_nEntrada, loc_nSaida, LocalEest.Dopes, LocalEest.Numes, LocalEestI.CUnis, ;
1834:                  loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, ;
1835:                  NVL(LocalEest.Obses, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
1836:                  TmpPro.cuniPs, LocalEest.Emps)
1837: 
1838:             IF NOT SEEK(LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), "TmpHistC", "EmpDnPs")
1839:                 INSERT INTO TmpHistC (EmpDnPs, Obss) ;
1840:                     VALUES (LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), TmpHist.Obss)
1841:             ENDIF
1842:         ENDIF
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * BtnProcessarClick - Valida campos e executa ProcessarBalanco
1847:     * Legado: Processar.Click (o maior metodo do formulario: ~1475 linhas)
1848:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1849:     *==========================================================================
1850:     PROCEDURE BtnProcessarClick()
1851:         LOCAL loc_lResultado
1852:         loc_lResultado = .F.
1853: 
1854:         TRY

*-- Linhas 1875 a 1900:
1875:     *  6. Calculo de saldos finais (CrUltBal / CrSaldoI)
1876:     *  7. Calculo de cotacoes (TmpCot)
1877:     *  8. Calcular indice de produtividade
1878:     *  9. Se Fechamento: INSERT em CrSigCdFea
1879:     * 10. Exibir cnt_4c_Resultado
1880:     *==========================================================================
1881:     PROTECTED FUNCTION ProcessarBalanco()
1882:         LOCAL loc_oPagina, loc_cEmpr
1883:         LOCAL loc_cGrupo, loc_cConta, loc_dData, loc_nCodigo, loc_nLote
1884:         LOCAL loc_pDtI, loc_pDtF, loc_llFalse, loc_llTrue
1885:         LOCAL loc_cQuery, loc_cUpdate, loc_cSql, loc_cEdn, loc_cEGE
1886:         LOCAL loc_cMatSec, loc_nFalhaAdmitida, loc_llTipoQ, loc_llGrvPrz
1887:         LOCAL loc_cMaterial, loc_cMatResFa, loc_cOperacao
1888:         LOCAL loc_lOrigem, loc_lDestino, loc_lOrigemF, loc_lDestinoF
1889:         LOCAL loc_nPesoTotal, loc_nQtde, loc_nPeso, loc_nFalha
1890:         LOCAL loc_cCodCor, loc_cCodTam
1891:         LOCAL loc_cGrupoD, loc_cContaD
1892:         LOCAL loc_nNumFape, loc_nTrabalhado, loc_nTrabalhadB
1893:         LOCAL loc_nSaldoi, loc_nPesagem
1894:         LOCAL loc_cMoeda, loc_nCusto, loc_nCota
1895:         LOCAL loc_dDataUBal, loc_nNdFechas, loc_nCodigosFcx
1896:         LOCAL loc_cMatPrev, loc_cMatOuro
1897:         LOCAL loc_loBarra
1898: 
1899:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1900:         loc_cEmpr   = THIS.this_cPEmps

*-- Linhas 1946 a 2141:
1946:             RETURN .F.
1947:         ENDIF
1948: 
1949:         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1950: 
1951:         *-- Ocultar resultado + resetar EntraPeso
1952:         loc_oPagina.cnt_4c_Resultado.Visible = .F.
1953:         THIS.this_lEntraPeso = .F.
1954: 
1955:         *-- ZAP / CREATE cursores temporarios
1956:         IF USED("TmpCot")
1957:             ZAP IN TmpCot
1958:         ELSE
1959:             CREATE CURSOR TmpCot (Cmoes C(10), Valos N(18,6))
1960:             INDEX ON Cmoes TAG Cmoes
1961:             SET ORDER TO Cmoes
1962:         ENDIF
1963: 
1964:         IF USED("TmpConta")
1965:             ZAP IN TmpConta
1966:             SELECT TmpConta
1967:             SET ORDER TO GrConta
1968:         ELSE
1969:             CREATE CURSOR TmpConta (Grupo C(10), Conta C(10), Nome C(80))
1970:             INDEX ON Grupo + Conta TAG GrConta
1971:             SET ORDER TO GrConta
1972:         ENDIF
1973: 
1974:         IF USED("TmpHist")
1975:             ZAP IN TmpHist
1976:         ELSE
1977:             CREATE CURSOR TmpHist (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), Datas D, ;
1978:                                    QtdeEnts N(12,3), QtdeSais N(12,3), Dopps C(15), ;
1979:                                    Numps N(10), cUnis C(10), Grupo2 C(10), Conta2 C(10), ;
1980:                                    PesoEnts N(12,3), PesoSais N(12,3), Nenvs N(10), ;
1981:                                    Obss C(100), Opers C(1), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1982:                                    cUnips C(10), Emps C(3), nLotes N(6))
1983:         ENDIF
1984: 
1985:         IF USED("TmpHistC")
1986:             ZAP IN TmpHistC
1987:         ELSE
1988:             CREATE CURSOR TmpHistC (EmpDnPs C(23), Obss C(100))
1989:             INDEX ON EmpDnPs TAG EmpDnPs
1990:             SET ORDER TO EmpDnPs
1991:         ENDIF
1992: 
1993:         IF USED("TmpPrz")
1994:             ZAP IN TmpPrz
1995:             SELECT TmpPrz
1996:             SET ORDER TO TmpPrz
1997:         ELSE
1998:             CREATE CURSOR TmpPrz (Datas D, TpOps C(15), Pesos N(12,3), Qtds N(12,3))
1999:             INDEX ON SPACE(1) + DTOS(Datas) + TpOps TAG TmpPrz
2000:             SET ORDER TO TmpPrz
2001:         ENDIF
2002: 
2003:         IF USED("CrSigCdFea")
2004:             ZAP IN CrSigCdFea
2005:         ELSE
2006:             CREATE CURSOR CrSigCdFea (Grupos C(10), Contas C(10), Datas D, Emps C(3), ;
2007:                                       Falhas N(12,3), Numes N(6,0), Produzidos N(12,3), ;
2008:                                       Tipos C(1), Trabs N(12,3), CidChaves C(36), NumBals N(6,0))
2009:         ENDIF
2010: 
2011:         IF USED("TmpOpera")
2012:             SELECT TmpOpera
2013:             SET ORDER TO GrConMatTp ASCENDING
2014:             SET KEY TO
2015:             ZAP
2016:         ELSE
2017:             CREATE CURSOR TmpOpera (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), ;
2018:                                     PesoEnts N(12,3), PesoSais N(12,3), ;
2019:                                     QtdeEnts N(12,3), QtdeSais N(12,3), ;
2020:                                     PesoBEnts N(12,3), PesoBSais N(12,3), ;
2021:                                     QtdeBEnts N(12,3), QtdeBSais N(12,3), ;
2022:                                     Varias N(1,0), Agregas N(1,0), AplicFlhs N(1,0), ;
2023:                                     PFalha N(6,2), Falha N(12,3))
2024:             INDEX ON Grupo + Conta + CMats + TpOps TAG GrConMatTp
2025:             SET ORDER TO GrConMatTp
2026:         ENDIF
2027: 
2028:         IF USED("TmpResFas")
2029:             SELECT TmpResFas
2030:             SET ORDER TO
2031:             ZAP
2032:         ELSE
2033:             CREATE CURSOR TmpResFas (Cmats C(14), Opers C(1), Fases C(10), OpFase C(18), ;
2034:                                      Qtds N(12,3), Pesos N(12,3), QtdPcs N(12,3))
2035:             INDEX ON Cmats + Opers + Fases TAG Fases
2036:             SET ORDER TO Fases
2037:         ENDIF
2038: 
2039:         IF USED("TmpResumo")
2040:             SELECT TmpResumo
2041:             ZAP
2042:             SET ORDER TO GrConMat
2043:         ELSE
2044:             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), CUnis C(10), ;
2045:                                      PesoEnts N(12,3), PesoSais N(12,3), ;
2046:                                      QtdeEnts N(12,3), QtdeSais N(12,3), ;
2047:                                      PesoFabre N(12,3), PesoFabrs N(12,3), ;
2048:                                      Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
2049:                                      Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
2050:                                      PfTrabs N(8,2), IndProd N(8,2), ;
2051:                                      Varias N(1,0), Agregas N(1,0), Visivel L, ;
2052:                                      Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
2053:             INDEX ON Grupo + Conta + CMats TAG GrConMat
2054:             INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMatCS
2055:             SET ORDER TO GrConMat
2056:         ENDIF
2057: 
2058:         *-- Obter MatSec de crSigCdPac
2059:         loc_cMatSec = ""
2060:         IF USED("crSigCdPac") AND !EOF("crSigCdPac")
2061:             loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
2062:         ELSE
2063:             loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
2064:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac") > 0 AND !EOF("crSigCdPac")
2065:                 loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
2066:             ENDIF
2067:         ENDIF
2068:         IF !USED("crSigCdPam")
2069:             loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
2070:             =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
2071:         ENDIF
2072: 
2073:         *-- Garantir TmpPro / crSigOpOpt / LocalOpp / crSigCdOpe carregados
2074:         IF !USED("TmpPro")
2075:             loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
2076:             IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
2077:                 SELECT TmpPro
2078:                 INDEX ON CPros TAG CPros
2079:                 SET ORDER TO CPros
2080:             ENDIF
2081:         ENDIF
2082:         IF !USED("crSigOpOpt")
2083:             loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
2084:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
2085:                 SELECT crSigOpOpt
2086:                 INDEX ON Cods TAG Cods
2087:                 SET ORDER TO Cods
2088:             ENDIF
2089:         ENDIF
2090:         IF !USED("LocalOpp")
2091:             loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
2092:             IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
2093:                 SELECT LocalOpp
2094:                 INDEX ON Dopps TAG Dopps
2095:                 SET ORDER TO Dopps
2096:             ENDIF
2097:         ENDIF
2098:         IF !USED("crSigCdOpe")
2099:             loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
2100:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
2101:                 SELECT crSigCdOpe
2102:                 INDEX ON Dopes TAG Dopes
2103:                 SET ORDER TO Dopes
2104:             ENDIF
2105:         ENDIF
2106: 
2107:         *-- Obter codigo do FCX corrente
2108:         loc_nCodigosFcx = 0
2109:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2110:             loc_nCodigosFcx = crSigCdFcx.Codigos
2111:         ENDIF
2112: 
2113:         *-- Seek grupo em TmpGccr
2114:         IF USED("TmpGccr")
2115:             =SEEK(loc_cGrupo, "TmpGccr", "BalCodigo")
2116:         ENDIF
2117: 
2118:         *-- Buscar data do ultimo balanco (crDtUBal)
2119:         loc_cQuery = "SELECT TOP 1 Datas FROM SigCdFcx " + ;
2120:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
2121:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
2122:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
2123:                      " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
2124:                      " ORDER BY Emps DESC, Grupos DESC, Contas DESC, Datas DESC"
2125: 
2126:         IF SQLEXEC(gnConnHandle, loc_cQuery, "crDtUBal") < 1
2127:             MsgErro("Falha na conex" + CHR(227) + "o (crDtUBal). Reinicializar o processo.", ;
2128:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2129:             RETURN .F.
2130:         ENDIF
2131:         GO TOP IN crDtUBal
2132: 
2133:         loc_nNdFechas = 0
2134:         IF USED("crSigCdPac") AND !EOF("crSigCdPac")
2135:             loc_nNdFechas = NVL(crSigCdPac.ndFechas, 0)
2136:         ENDIF
2137: 
2138:         IF EOF("crDtUBal")
2139:             loc_dDataUBal = CTOD("")
2140:         ELSE
2141:             loc_dDataUBal = TTOD(crDtUBal.Datas) + loc_nNdFechas

*-- Linhas 2151 a 2306:
2151: 
2152:         *-- Atualizar Datais no FCX com data do ultimo balanco
2153:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2154:             SELECT crSigCdFcx
2155:             REPLACE crSigCdFcx.Datais WITH loc_dDataUBal
2156:         ENDIF
2157: 
2158:         *-- Parametros de data para SQL parametrizado
2159:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2160:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2161: 
2162:         *-- Dados da empresa (EmpBals)
2163:         loc_cSql = "SELECT TOP 1 * FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpr)
2164:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalEmp")
2165:         LOCAL loc_cEmpBals
2166:         loc_cEmpBals = ""
2167:         IF USED("LocalEmp") AND !EOF("LocalEmp") AND PEMSTATUS(LocalEmp, "EmpBals", 5)
2168:             loc_cEmpBals = ALLTRIM(NVL(LocalEmp.EmpBals, ""))
2169:         ENDIF
2170: 
2171:         *==========================================================================
2172:         *-- MOVIMENTACOES DE PRODUCAO (LocalNens / LocalNensI)
2173:         *==========================================================================
2174:         loc_cQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, " + ;
2175:                      "Obss, cIdChaves, EmpDnPs, nLotes " + ;
2176:                      "FROM SigCdNec " + ;
2177:                      "WHERE ( Emps = " + EscaparSQL(loc_cEmpr) + ;
2178:                      IIF(!EMPTY(loc_cEmpBals), " OR Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2179:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2180:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2181:                      " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2182:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2183:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + ;
2184:                      " AND ProcBals = ?loc_llFalse))" + ;
2185:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
2186:                      " ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"
2187: 
2188:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNens") < 1
2189:             MsgErro("Falha na conex" + CHR(227) + "o (LocalNens). Reinicializar.", ;
2190:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2191:             RETURN .F.
2192:         ENDIF
2193: 
2194:         loc_cQuery = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, " + ;
2195:                      "b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
2196:                      "FROM SigCdNec a, SigCdNei b " + ;
2197:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2198:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2199:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2200:                      " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2201:                      " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2202:                      " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2203:                      " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2204:                      " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llFalse" + ;
2205:                      " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
2206: 
2207:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNensI") < 1
2208:             MsgErro("Falha na conex" + CHR(227) + "o (LocalNensI). Reinicializar.", ;
2209:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2210:             RETURN .F.
2211:         ENDIF
2212:         SELECT LocalNensI
2213:         INDEX ON EmpDNPs TAG EmpDNPs
2214:         SET ORDER TO EmpDNPs
2215: 
2216:         *-- LocalServ (servicos por funcionario)
2217:         loc_cQuery = "SELECT b.EmpDNPs, a.dopps, a.numps, b.CMats, p.DPros, b.CUnis, b.Nenvs, " + ;
2218:                      "b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams, " + ;
2219:                      "b.fators, a.grupoos, a.contaos, " + ;
2220:                      "CASE WHEN a.retrabs = 0 THEN b.qtds * b.fators ELSE b.qtds * b.coefs END AS valors, a.datas " + ;
2221:                      "FROM SigCdNec a, SigCdNei b LEFT JOIN SigCdPro p ON b.CMats = p.CPros " + ;
2222:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2223:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2224:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2225:                      " AND ((a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2226:                      " AND a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2227:                      " AND a.ProcdBal = ?loc_llFalse) OR (a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2228:                      " AND a.ContaOs = " + EscaparSQL(loc_cConta) + ;
2229:                      " AND a.ProcBals = ?loc_llFalse))" + ;
2230:                      " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llTrue" + ;
2231:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
2232:                      " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
2233: 
2234:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalServ") < 1
2235:             MsgErro("Falha na conex" + CHR(227) + "o (LocalServ). Reinicializar.", ;
2236:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2237:             RETURN .F.
2238:         ENDIF
2239:         SELECT LocalServ
2240:         INDEX ON CMats + EmpDNPs TAG EmpDNPs
2241:         SET ORDER TO EmpDNPs
2242: 
2243:         *-- LocalMFas (fases de producao)
2244:         loc_cQuery = "SELECT b.EmpDNPs, b.Qtds, b.cIdChaves " + ;
2245:                      "FROM SigCdNec a, SigPdMvf b " + ;
2246:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2247:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2248:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2249:                      " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2250:                      " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2251:                      " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2252:                      " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2253:                      " AND a.EmpDNPs = b.EmpDNPs" + ;
2254:                      " ORDER BY b.EmpDNPs, b.Qtds, b.cIdChaves"
2255: 
2256:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalMFas") < 1
2257:             MsgErro("Falha na conex" + CHR(227) + "o (LocalMFas). Reinicializar.", ;
2258:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2259:             RETURN .F.
2260:         ENDIF
2261:         SELECT LocalMFas
2262:         INDEX ON EmpDNPs TAG EmpDNPs
2263:         SET ORDER TO EmpDNPs
2264: 
2265:         *-- Grupos de produto (LocalGru / LocalGgrp)
2266:         loc_cSql = "SELECT Cgrus, GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs, MoeCusts FROM SigCdGrp"
2267:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalGru")
2268:         SELECT LocalGru
2269:         INDEX ON Cgrus TAG Cgrus
2270: 
2271:         loc_cSql = "SELECT Codigos, Aplicflhs FROM SigCdGpr"
2272:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalGgrp")
2273:         SELECT LocalGgrp
2274:         INDEX ON Codigos TAG Codigos
2275: 
2276:         *-- Inicializacao de flags
2277:         loc_nFalhaAdmitida = 0
2278:         loc_llTipoQ        = .F.
2279:         loc_llGrvPrz       = .F.
2280: 
2281:         *==========================================================================
2282:         *-- SCAN PRINCIPAL: Movimentacoes de Producao (LocalNens)
2283:         *==========================================================================
2284:         SELECT LocalNens
2285:         loc_loBarra = CREATEOBJECT("fwprogressbar", ;
2286:                       "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
2287:                       RECCOUNT("LocalNens"))
2288:         loc_loBarra.Show
2289: 
2290:         SCAN
2291:             loc_loBarra.Update(.T.)
2292: 
2293:             loc_cEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)
2294: 
2295:             =SEEK(LocalNens.Dopps, "LocalOpp", "Dopps")
2296: 
2297:             loc_lOrigem   = .F.
2298:             loc_lDestino  = .F.
2299:             loc_cMaterial = SPACE(14)
2300:             loc_cMatResFa = SPACE(14)
2301: 
2302:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2303:                LocalOpp.Origems = 1 AND LocalNens.GrupoOs = loc_cGrupo AND ;
2304:                LocalNens.ContaOs = loc_cConta AND INLIST(LocalOpp.EstOrigs, 1, 2)
2305:                 loc_lOrigem = .T.
2306:             ENDIF

*-- Linhas 2318 a 2363:
2318:             loc_llGrvPrz   = .F.
2319: 
2320:             *-- Scan interno: itens do movimento (LocalNensI)
2321:             SELECT LocalNensI
2322:             SEEK loc_cEdn
2323:             SCAN WHILE EmpDNPs = loc_cEdn
2324:                 *-- Determinar material baseado em UnifBals
2325:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4
2326:                     IF LocalNensI.Nops = 0
2327:                         loc_cMaterial = LocalNensI.CMats
2328:                     ELSE
2329:                         loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
2330:                         =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
2331:                         =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
2332:                         IF USED("crSigCdPam") AND !EOF("crSigCdPam")
2333:                             loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
2334:                         ELSE
2335:                             loc_cMaterial = TmpPro.MatPrincs
2336:                         ENDIF
2337:                     ENDIF
2338:                     IF LocalNensI.CMats <> loc_cMaterial
2339:                         IF LocalNensI.CMats <> loc_cMatSec
2340:                             LOOP
2341:                         ELSE
2342:                             loc_cMaterial = loc_cMatSec
2343:                         ENDIF
2344:                     ENDIF
2345:                 ELSE
2346:                     IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3
2347:                         loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
2348:                         =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
2349:                         IF LocalNensI.Nops = 0
2350:                             loc_cMaterial = LocalNensI.CMats
2351:                         ELSE
2352:                             =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
2353:                             IF USED("crSigCdPam") AND !EOF("crSigCdPam")
2354:                                 loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
2355:                             ELSE
2356:                                 loc_cMaterial = TmpPro.MatPrincs
2357:                             ENDIF
2358:                         ENDIF
2359:                     ELSE
2360:                         IF USED("TmpGccr") AND !EOF("TmpGccr") AND USED("crSigCdPam") AND !EOF("crSigCdPam")
2361:                             loc_cMaterial = IIF(TmpGccr.UnifBals = 1, ALLTRIM(crSigCdPam.Ouros), LocalNensI.CMats)
2362:                         ELSE
2363:                             loc_cMaterial = LocalNensI.CMats

*-- Linhas 2377 a 2709:
2377:                 IF loc_lOrigem
2378:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs, "TmpConta")
2379:                         =SEEK(LocalNens.ContaOs, "TmpCli", "BalCodigo")
2380:                         INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2381:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
2382:                                     IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2383:                     ENDIF
2384:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
2385:                         INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2386:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
2387:                                     TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2388:                     ENDIF
2389:                     SELECT TmpResumo
2390:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2391:                         REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
2392:                                 QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
2393:                                 PesoFabre WITH PesoFabre + LocalNensI.Peso2s
2394:                         THIS.IncluirHistorico("Nens", "O", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2395:                     ELSE
2396:                         REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
2397:                                 QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
2398:                                 PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
2399:                         THIS.IncluirHistorico("Nens", "O", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2400:                     ENDIF
2401:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
2402:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2403:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
2404:                                     LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2405:                     ENDIF
2406:                     SELECT TmpOpera
2407:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2408:                         REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
2409:                                 QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
2410:                     ELSE
2411:                         REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
2412:                                 QtdeSais WITH QtdeSais + LocalNensI.Qtds
2413:                     ENDIF
2414:                     =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
2415:                     IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
2416:                        USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
2417:                        crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
2418:                        crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
2419:                         loc_llTipoQ = .T.
2420:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2421:                             loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
2422:                             REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
2423:                             loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
2424:                         ENDIF
2425:                     ENDIF
2426:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2427:                         loc_cOperacao = "E"
2428:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2429:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2430:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Entrada " + LocalNens.GrupoDs)
2431:                         ENDIF
2432:                     ELSE
2433:                         loc_cOperacao = "S"
2434:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2435:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2436:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Saida   " + LocalNens.GrupoDs)
2437:                         ENDIF
2438:                     ENDIF
2439:                     REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
2440:                             Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
2441:                     IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND crSigOpOpt.Prodzs = 1
2442:                         SELECT TmpPrz
2443:                         IF !SEEK(SPACE(1) + DTOS(LocalNens.Datas) + LocalNensI.TpOps)
2444:                             APPEND BLANK
2445:                             REPLACE Datas WITH LocalNens.Datas, TpOps WITH LocalNensI.TpOps
2446:                         ENDIF
2447:                         REPLACE Pesos WITH Pesos + LocalNensI.Pesos
2448:                         loc_llGrvPrz = .T.
2449:                     ENDIF
2450:                 ENDIF
2451: 
2452:                 *-- DESTINO
2453:                 IF loc_lDestino
2454:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs, "TmpConta")
2455:                         =SEEK(LocalNens.ContaDs, "TmpCli", "BalCodigo")
2456:                         INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2457:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, ;
2458:                                     IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2459:                     ENDIF
2460:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
2461:                         INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2462:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
2463:                                     TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2464:                     ENDIF
2465:                     SELECT TmpResumo
2466:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2467:                         REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
2468:                                 QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
2469:                                 PesoFabre WITH PesoFabre + LocalNensI.Peso2s
2470:                         THIS.IncluirHistorico("Nens", "D", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2471:                     ELSE
2472:                         REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
2473:                                 QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
2474:                                 PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
2475:                         THIS.IncluirHistorico("Nens", "D", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2476:                     ENDIF
2477:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
2478:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2479:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
2480:                                     LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2481:                     ENDIF
2482:                     SELECT TmpOpera
2483:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2484:                         REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
2485:                                 QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
2486:                     ELSE
2487:                         REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
2488:                                 QtdeSais WITH QtdeSais + LocalNensI.Qtds
2489:                     ENDIF
2490:                     =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
2491:                     IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
2492:                        USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
2493:                        crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
2494:                        crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
2495:                         loc_llTipoQ = .T.
2496:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2497:                             loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
2498:                             REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
2499:                             loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
2500:                         ENDIF
2501:                     ENDIF
2502:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2503:                         loc_cOperacao = "E"
2504:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2505:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2506:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Entrada " + LocalNens.GrupoOs)
2507:                         ENDIF
2508:                     ELSE
2509:                         loc_cOperacao = "S"
2510:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2511:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2512:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Saida   " + LocalNens.GrupoOs)
2513:                         ENDIF
2514:                     ENDIF
2515:                     REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
2516:                             Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
2517:                 ENDIF
2518: 
2519:                 *-- UnifBals=3: material principal secundario
2520:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3 AND ;
2521:                    LocalNensI.CMats <> loc_cMaterial AND ;
2522:                    USED("crSigCdFcx") AND !EOF("crSigCdFcx") AND ;
2523:                    LocalGru.GruEstPs <> crSigCdFcx.Grupos AND LocalGru.ConEstPs <> crSigCdFcx.Contas
2524:                     =SEEK(loc_cMaterial, "TmpPro", "CPros")
2525:                     =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
2526:                     =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
2527:                     IF loc_lOrigem
2528:                         IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial, "TmpResumo")
2529:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
2530:                                 VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
2531:                         ENDIF
2532:                         SELECT TmpResumo
2533:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2534:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2535:                         ELSE
2536:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2537:                         ENDIF
2538:                         IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
2539:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2540:                                 VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, ;
2541:                                         LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2542:                         ENDIF
2543:                         SELECT TmpOpera
2544:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2545:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2546:                         ELSE
2547:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2548:                         ENDIF
2549:                     ENDIF
2550:                     IF loc_lDestino
2551:                         IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial, "TmpResumo")
2552:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
2553:                                 VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
2554:                         ENDIF
2555:                         SELECT TmpResumo
2556:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2557:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2558:                         ELSE
2559:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2560:                         ENDIF
2561:                         IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
2562:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2563:                                 VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, ;
2564:                                         LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2565:                         ENDIF
2566:                         SELECT TmpOpera
2567:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2568:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2569:                         ELSE
2570:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2571:                         ENDIF
2572:                     ENDIF
2573:                 ENDIF
2574: 
2575:             ENDSCAN
2576: 
2577:             *-- TmpResFas pos-scan-interno
2578:             IF loc_lDestino AND !EMPTY(ALLTRIM(loc_cMatResFa))
2579:                 loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1, "E", "S")
2580:                 IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2581:                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2582:                         VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, ;
2583:                                 IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoOs)
2584:                 ENDIF
2585:             ENDIF
2586:             IF loc_lOrigem AND !EMPTY(ALLTRIM(loc_cMatResFa))
2587:                 loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1, "E", "S")
2588:                 IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2589:                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2590:                         VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, ;
2591:                                 IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoDs)
2592:                 ENDIF
2593:             ENDIF
2594: 
2595:             *-- LocalMFas para este movimento
2596:             SELECT LocalMFas
2597:             SEEK loc_cEdn
2598:             SCAN WHILE EmpDNPs = loc_cEdn
2599:                 REPLACE QtdPcs WITH QtdPcs + LocalMfas.Qtds IN TmpResFas
2600:                 IF loc_llGrvPrz
2601:                     REPLACE Qtds WITH Qtds + LocalMfas.Qtds IN TmpPrz
2602:                 ENDIF
2603:             ENDSCAN
2604: 
2605:             *-- Marcar NEC como processada no balanco (se Fechamento)
2606:             IF THIS.this_lFechamento
2607:                 IF loc_lOrigem
2608:                     loc_cUpdate = "UPDATE SigCdNec SET ProcBals = ?loc_llTrue, NumBals = " + ;
2609:                                   TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
2610:                     IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
2611:                         MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Orig). Reinicializar.", "FormFea")
2612:                         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2613:                         RETURN .F.
2614:                     ENDIF
2615:                 ENDIF
2616:                 IF loc_lDestino
2617:                     loc_cUpdate = "UPDATE SigCdNec SET ProcDBal = ?loc_llTrue, NumBalds = " + ;
2618:                                   TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
2619:                     IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
2620:                         MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Dest). Reinicializar.", "FormFea")
2621:                         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2622:                         RETURN .F.
2623:                     ENDIF
2624:                 ENDIF
2625:             ENDIF
2626: 
2627:         ENDSCAN
2628:         loc_loBarra.Complete
2629: 
2630:         *==========================================================================
2631:         *-- MOVIMENTACOES DE ESTOQUE (LocalEest / LocalEestI / LocalEsti2)
2632:         *==========================================================================
2633:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2634:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2635: 
2636:         loc_cQuery = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves " + ;
2637:                      "FROM SigMvCab " + ;
2638:                      "WHERE (Emps = " + EscaparSQL(loc_cEmpr) + " OR Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2639:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2640:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2641:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2642:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + " AND ProcBals = ?loc_llFalse))" + ;
2643:                      IIF(loc_nLote > 0, " AND 0=1", "") + ;
2644:                      " ORDER BY Datas"
2645: 
2646:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEest") < 1
2647:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEest). Reinicializar.", "FormFea")
2648:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2649:             RETURN .F.
2650:         ENDIF
2651: 
2652:         loc_cQuery = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
2653:                      "FROM SigMvCab a, SigMvItn b " + ;
2654:                      "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2655:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2656:                      " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2657:                      " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2658:                      " AND a.EmpDopNums = b.EmpDopNums" + ;
2659:                      " ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds"
2660: 
2661:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEestI") < 1
2662:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEestI). Reinicializar.", "FormFea")
2663:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2664:             RETURN .F.
2665:         ENDIF
2666:         SELECT LocalEestI
2667:         INDEX ON EmpDopNums TAG EmpDopNums
2668:         SET ORDER TO EmpDopNums
2669: 
2670:         loc_cQuery = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
2671:                      "FROM SigMvCab a, SigMvIts b " + ;
2672:                      "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2673:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2674:                      " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2675:                      " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2676:                      " AND a.EmpDopNums = b.EmpDopNums" + ;
2677:                      " ORDER BY b.EmpDopNums, b.CPros, b.codcors, b.codtams, b.citens"
2678: 
2679:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEsti2") < 1
2680:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEsti2). Reinicializar.", "FormFea")
2681:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2682:             RETURN .F.
2683:         ENDIF
2684:         SELECT LocalEsti2
2685:         INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
2686:         SET ORDER TO EmpDopNums
2687: 
2688:         *-- SCAN: Movimentacoes de Estoque
2689:         SELECT LocalEest
2690:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
2691:         loc_loBarra.Show
2692: 
2693:         SCAN
2694:             loc_loBarra.Update(.T.)
2695:             loc_cEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)
2696: 
2697:             =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")
2698: 
2699:             loc_lOrigem   = .F.
2700:             loc_lDestino  = .F.
2701:             loc_lOrigemF  = .F.
2702:             loc_lDestinoF = .F.
2703: 
2704:             IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
2705:                 IF crSigCdOpe.Estoqs = 1 AND (crSigCdOpe.EstOrigs = 4 OR crSigCdOpe.Opers = 3) AND LocalEest.Emps = loc_cEmpr
2706:                     IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2707:                         loc_lOrigem = .T.
2708:                     ELSE
2709:                         IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta

*-- Linhas 2730 a 2748:
2730:                 LOOP
2731:             ENDIF
2732: 
2733:             SELECT LocalEestI
2734:             SEEK loc_cEdn
2735:             SCAN WHILE EmpDopNums = loc_cEdn
2736:                 =SEEK(LocalEestI.Cpros, "TmpPro", "CPros")
2737:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
2738:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
2739: 
2740:                 loc_cGrupoD   = SPACE(10)
2741:                 loc_cContaD   = SPACE(10)
2742:                 loc_cOperacao = " "
2743: 
2744:                 IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND crSigCdOpe.EstOrigs = 4
2745:                     loc_lOrigem  = .F.
2746:                     loc_lDestino = .F.
2747:                     IF LocalEestI.Opers = "S" AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2748:                         loc_lOrigem   = .T.

*-- Linhas 2859 a 3344:
2859:                 ENDIF
2860: 
2861:                 *-- Scan LocalEsti2
2862:                 SELECT LocalEsti2
2863:                 SET ORDER TO EmpDopNums
2864:                 IF SEEK(LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4))
2865:                     SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = ;
2866:                                LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4)
2867:                         loc_nQtde = LocalEsti2.Qtds
2868:                         loc_nPeso = LocalEsti2.Pesos
2869:                         loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(LocalEsti2.CodCors), " "), 4)
2870:                         loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(LocalEsti2.CodTams), " "), 4)
2871:                         IF loc_lOrigem
2872:                             IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2873:                                 =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
2874:                                 INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2875:                                     VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2876:                             ENDIF
2877:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
2878:                                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2879:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, ;
2880:                                             LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2881:                             ENDIF
2882:                             SELECT TmpResumo
2883:                             IF loc_cOperacao = "E"
2884:                                 REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
2885:                                         PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2886:                                         PesoFabre WITH PesoFabre + loc_nQtde
2887:                                 THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2888:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2889:                             ELSE
2890:                                 REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
2891:                                         PesoSais  WITH PesoSais  + loc_nQtde, ;
2892:                                         PesoFabrs WITH PesoFabrs + loc_nQtde
2893:                                 THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2894:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2895:                             ENDIF
2896:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
2897:                                 INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2898:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
2899:                                             TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2900:                             ENDIF
2901:                             SELECT TmpOpera
2902:                             IF loc_cOperacao = "E"
2903:                                 REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
2904:                             ELSE
2905:                                 REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
2906:                             ENDIF
2907:                             IF loc_cOperacao = "E"
2908:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2909:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2910:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
2911:                                 ENDIF
2912:                             ELSE
2913:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2914:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2915:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
2916:                                 ENDIF
2917:                             ENDIF
2918:                             REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
2919:                                     Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
2920:                         ENDIF
2921:                         IF loc_lDestino
2922:                             IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2923:                                 =SEEK(loc_cConta, "TmpCli", "BalCodigo")
2924:                                 INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2925:                                     VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2926:                             ENDIF
2927:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
2928:                                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2929:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, ;
2930:                                             LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2931:                             ENDIF
2932:                             SELECT TmpResumo
2933:                             IF loc_cOperacao = "E"
2934:                                 REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
2935:                                         PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2936:                                         PesoFabre WITH PesoFabre + loc_nQtde
2937:                                 THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2938:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2939:                             ELSE
2940:                                 REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
2941:                                         PesoSais  WITH PesoSais  + loc_nQtde, ;
2942:                                         PesoFabrs WITH PesoFabrs + loc_nQtde
2943:                                 THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2944:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2945:                             ENDIF
2946:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
2947:                                 INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2948:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
2949:                                             TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2950:                             ENDIF
2951:                             SELECT TmpOpera
2952:                             IF loc_cOperacao = "E"
2953:                                 REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
2954:                             ELSE
2955:                                 REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
2956:                             ENDIF
2957:                             IF loc_cOperacao = "E"
2958:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2959:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2960:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
2961:                                 ENDIF
2962:                             ELSE
2963:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2964:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2965:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
2966:                                 ENDIF
2967:                             ENDIF
2968:                             REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
2969:                                     Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
2970:                         ENDIF
2971:                     ENDSCAN
2972:                 ELSE
2973:                     *-- Sem LocalEsti2: usar LocalEestI diretamente
2974:                     loc_nQtde = LocalEestI.Qtds
2975:                     loc_nPeso = LocalEestI.Pesos
2976:                     IF loc_lOrigem
2977:                         IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2978:                             =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
2979:                             INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2980:                                 VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2981:                         ENDIF
2982:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
2983:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
2984:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
2985:                         ENDIF
2986:                         SELECT TmpResumo
2987:                         IF loc_cOperacao = "E"
2988:                             REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
2989:                                     PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2990:                                     PesoFabre WITH PesoFabre + loc_nQtde
2991:                             THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2992:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2993:                         ELSE
2994:                             REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
2995:                                     PesoSais  WITH PesoSais  + loc_nQtde, ;
2996:                                     PesoFabrs WITH PesoFabrs + loc_nQtde
2997:                             THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2998:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2999:                         ENDIF
3000:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
3001:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
3002:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), LocalGgrp.AplicFlhs)
3003:                         ENDIF
3004:                         SELECT TmpOpera
3005:                         IF loc_cOperacao = "E"
3006:                             REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
3007:                         ELSE
3008:                             REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
3009:                         ENDIF
3010:                         IF loc_cOperacao = "E"
3011:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3012:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3013:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
3014:                             ENDIF
3015:                         ELSE
3016:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3017:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3018:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
3019:                             ENDIF
3020:                         ENDIF
3021:                         REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
3022:                                 Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
3023:                     ENDIF
3024:                     IF loc_lDestino
3025:                         IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
3026:                             =SEEK(loc_cConta, "TmpCli", "BalCodigo")
3027:                             INSERT INTO TmpConta (Grupo, Conta, Nome) ;
3028:                                 VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
3029:                         ENDIF
3030:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
3031:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3032:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3033:                         ENDIF
3034:                         SELECT TmpResumo
3035:                         IF loc_cOperacao = "E"
3036:                             REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
3037:                                     PesoEnts  WITH PesoEnts  + loc_nQtde, ;
3038:                                     PesoFabre WITH PesoFabre + loc_nQtde
3039:                             THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
3040:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
3041:                         ELSE
3042:                             REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
3043:                                     PesoSais  WITH PesoSais  + loc_nQtde, ;
3044:                                     PesoFabrs WITH PesoFabrs + loc_nQtde
3045:                             THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
3046:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
3047:                         ENDIF
3048:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
3049:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3050:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
3051:                                         TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3052:                         ENDIF
3053:                         SELECT TmpOpera
3054:                         IF loc_cOperacao = "E"
3055:                             REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
3056:                         ELSE
3057:                             REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
3058:                         ENDIF
3059:                         IF loc_cOperacao = "E"
3060:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3061:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3062:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
3063:                             ENDIF
3064:                         ELSE
3065:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3066:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3067:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
3068:                             ENDIF
3069:                         ENDIF
3070:                         REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
3071:                                 Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
3072:                     ENDIF
3073:                 ENDIF
3074: 
3075:                 loc_lOrigemF  = IIF(!loc_lOrigemF,  loc_lOrigem,  loc_lOrigemF)
3076:                 loc_lDestinoF = IIF(!loc_lDestinoF, loc_lDestino, loc_lDestinoF)
3077:             ENDSCAN
3078: 
3079:             *-- Marcar SigMvCab como processada
3080:             IF THIS.this_lFechamento AND (loc_lOrigemF OR loc_lDestinoF)
3081:                 loc_cUpdate = "UPDATE SigMvCab SET " + ;
3082:                               IIF(loc_lOrigemF, "ProcBals = ?loc_llTrue, NumBals = " + TRANSFORM(loc_nCodigosFcx) + " ", "") + ;
3083:                               IIF(loc_lDestinoF, IIF(loc_lOrigemF, ",", "") + ;
3084:                               "ProcDBal = ?loc_llTrue, NumBalds = " + TRANSFORM(loc_nCodigosFcx) + " ", " ") + ;
3085:                               "WHERE CidChaves = '" + ALLTRIM(LocalEest.CidChaves) + "'"
3086:                 IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
3087:                     MsgErro("Falha na conex" + CHR(227) + "o (Update SigMvCab). Reinicializar.", "FormFea")
3088:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3089:                     RETURN .F.
3090:                 ENDIF
3091:             ENDIF
3092: 
3093:         ENDSCAN
3094:         loc_loBarra.Complete()
3095: 
3096:         *==========================================================================
3097:         *-- SALDOS DE ESTOQUE (CrSalEst / SigMvEst)
3098:         *==========================================================================
3099:         LOCAL loc_cGrupoFcx, loc_cContaFcx
3100:         loc_cGrupoFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Grupos, loc_cGrupo)
3101:         loc_cContaFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Contas, loc_cConta)
3102:         loc_cEGE = loc_cEmpr + PADR(loc_cGrupoFcx, 10) + PADR(loc_cContaFcx, 10)
3103: 
3104:         loc_cSql = "SELECT * FROM SigMvEst WHERE EmpGruEsts = " + EscaparSQL(loc_cEGE)
3105:         IF SQLEXEC(gnConnHandle, loc_cSql, "CrSalEst") < 1
3106:             MsgErro("Falha na conex" + CHR(227) + "o (CrSalEst). Reinicializar.", "FormFea")
3107:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3108:             RETURN .F.
3109:         ENDIF
3110: 
3111:         SELECT CrSalEst
3112:         SCAN
3113:             =SEEK(CrSalEst.Cpros, "TmpPro", "CPros")
3114:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3115:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3116:             loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(CrSalEst.CodCors), " "), 4)
3117:             loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(CrSalEst.CodTams), " "), 4)
3118:             IF !SEEK(loc_cGrupoFcx + loc_cContaFcx + CrSalEst.Cpros + loc_cCodCor + loc_cCodTam, "TmpResumo")
3119:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
3120:                     VALUES (loc_cGrupoFcx, loc_cContaFcx, CrSalEst.Cpros, TmpPro.CUnis, ;
3121:                             TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
3122:             ENDIF
3123:         ENDSCAN
3124: 
3125:         *==========================================================================
3126:         *-- PESAGENS (LocalPesa / LocalPesaI / SigCdPsc / SigCdPsi)
3127:         *==========================================================================
3128:         loc_pDtI = fDtoSQL(loc_dDataUBal)
3129:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
3130: 
3131:         loc_cQuery = "SELECT Emps, Codigos, CidChaves FROM SigCdPsc " + ;
3132:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3133:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
3134:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
3135:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND ProcBals = ?loc_llFalse" + ;
3136:                      " ORDER BY Emps, Codigos"
3137: 
3138:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesa") < 1
3139:             MsgErro("Falha na conex" + CHR(227) + "o (LocalPesa). Reinicializar.", "FormFea")
3140:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3141:             RETURN .F.
3142:         ENDIF
3143: 
3144:         SELECT LocalPesa
3145:         SCAN
3146:             loc_cQuery = "SELECT CPros, Qtds, Pesos FROM SigCdPsi " + ;
3147:                          "WHERE Emps = " + EscaparSQL(ALLTRIM(LocalPesa.Emps)) + ;
3148:                          " AND Codigos = " + TRANSFORM(LocalPesa.Codigos) + ;
3149:                          " ORDER BY CPros"
3150:             IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesaI") < 1
3151:                 MsgErro("Falha na conex" + CHR(227) + "o (LocalPesaI). Reinicializar.", "FormFea")
3152:                 SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3153:                 RETURN .F.
3154:             ENDIF
3155:             SELECT LocalPesaI
3156:             SCAN
3157:                 =SEEK(LocalPesaI.CPros, "TmpPro", "CPros")
3158:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3159:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3160:                 IF !SEEK(loc_cGrupo + loc_cConta + LocalPesaI.CPros, "TmpResumo")
3161:                     INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3162:                         VALUES (loc_cGrupo, loc_cConta, LocalPesaI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3163:                 ENDIF
3164:                 SELECT TmpResumo
3165:                 REPLACE Pesagem  WITH TmpResumo.Pesagem  + LocalPesaI.Qtds  IN TmpResumo
3166:                 REPLACE Pesagem3 WITH TmpResumo.Pesagem3 + LocalPesaI.Pesos IN TmpResumo
3167:             ENDSCAN
3168: 
3169:             *-- UnifBals=1: agregar pesagem no ouro
3170:             IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
3171:                USED("crSigCdPam") AND !EOF("crSigCdPam")
3172:                 loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
3173:                 IF !EMPTY(loc_cMatOuro)
3174:                     SELECT TmpResumo
3175:                     SET ORDER TO
3176:                     LOCATE FOR CMats = loc_cMatOuro
3177:                     IF EOF()
3178:                         APPEND BLANK
3179:                         REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
3180:                     ENDIF
3181:                     SELECT [  ] AS Agregar, SUM(Pesagem) AS Pesagem FROM TmpResumo ;
3182:                         WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND Pesagem <> 0 ;
3183:                         INTO CURSOR csTotal GROUP BY 1
3184:                     GO TOP IN csTotal
3185:                     REPLACE Pesagem  WITH Pesagem  + csTotal.Pesagem, ;
3186:                             Pesagem2 WITH Pesagem2 + csTotal.Pesagem IN TmpResumo
3187:                 ENDIF
3188:             ENDIF
3189: 
3190:             SELECT TmpResumo
3191:             SET ORDER TO GrConMat
3192: 
3193:             IF THIS.this_lFechamento
3194:                 loc_cUpdate = "UPDATE SigCdPsc SET ProcBals = ?loc_llTrue, NumBals = " + ;
3195:                               TRANSFORM(loc_nCodigosFcx) + ;
3196:                               " WHERE cidchaves = '" + ALLTRIM(LocalPesa.cidchaves) + "'"
3197:                 IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
3198:                     MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPsc). Reinicializar.", "FormFea")
3199:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3200:                     RETURN .F.
3201:                 ENDIF
3202:             ENDIF
3203:         ENDSCAN
3204: 
3205:         *==========================================================================
3206:         *-- CALCULOS FINAIS: saldos, falhas, produtividade
3207:         *==========================================================================
3208:         SELECT TmpResumo
3209:         REPLACE ALL Flag3 WITH .T.
3210: 
3211:         SELECT TmpOpera
3212:         REPLACE ALL PesoBEnts WITH PesoEnts, PesoBSais WITH PesoSais, ;
3213:                     QtdeBEnts WITH QtdeEnts, QtdeBSais WITH QtdeSais IN TmpOpera
3214: 
3215:         *-- UnifBals=1: unificar como ouro
3216:         IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
3217:            USED("crSigCdPam") AND !EOF("crSigCdPam")
3218:             loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
3219:             IF !EMPTY(loc_cMatOuro)
3220:                 SELECT TmpResumo
3221:                 SET ORDER TO
3222:                 LOCATE FOR CMats = loc_cMatOuro
3223:                 IF EOF()
3224:                     APPEND BLANK
3225:                     REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
3226:                 ENDIF
3227:                 SELECT [  ] AS Agregar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3228:                     FROM TmpResumo WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
3229:                     INTO CURSOR csTotal GROUP BY 1
3230:                 GO TOP IN csTotal
3231:                 SELECT TmpResumo
3232:                 SCAN
3233:                     IF CMats = loc_cMatOuro
3234:                         REPLACE PesoEnts WITH PesoEnts + csTotal.pEnts, PesoSais WITH PesoSais + csTotal.pSais, ;
3235:                                 QtdeEnts WITH QtdeEnts + csTotal.pEnts, QtdeSais WITH QtdeSais + csTotal.pSais
3236:                     ELSE
3237:                         IF Agregas <> 1
3238:                             REPLACE Visivel WITH .F., Flag3 WITH .F.
3239:                         ENDIF
3240:                     ENDIF
3241:                 ENDSCAN
3242:                 =SEEK(loc_cMatOuro, "TmpPro", "CPros")
3243:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3244:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3245:                 SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3246:                     FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
3247:                     GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
3248:                 SELECT csTotal
3249:                 SCAN
3250:                     IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
3251:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3252:                             VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
3253:                                     TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3254:                     ENDIF
3255:                     REPLACE TmpOpera.PesoEnts WITH TmpOpera.PesoEnts + csTotal.pEnts IN TmpOpera
3256:                     REPLACE TmpOpera.PesoSais WITH TmpOpera.PesoSais + csTotal.pSais IN TmpOpera
3257:                     REPLACE TmpOpera.QtdeEnts WITH TmpOpera.QtdeEnts + csTotal.pEnts IN TmpOpera
3258:                     REPLACE TmpOpera.QtdeSais WITH TmpOpera.QtdeSais + csTotal.pSais IN TmpOpera
3259:                 ENDSCAN
3260:                 SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3261:                     FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND AplicFlhs <> 2 ;
3262:                     GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
3263:                 SELECT csTotal
3264:                 SCAN
3265:                     IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
3266:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3267:                             VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
3268:                                     TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3269:                     ENDIF
3270:                     REPLACE TmpOpera.PesoBEnts WITH TmpOpera.PesoBEnts + csTotal.pEnts IN TmpOpera
3271:                     REPLACE TmpOpera.PesoBSais WITH TmpOpera.PesoBSais + csTotal.pSais IN TmpOpera
3272:                     REPLACE TmpOpera.QtdeBEnts WITH TmpOpera.QtdeBEnts + csTotal.pEnts IN TmpOpera
3273:                     REPLACE TmpOpera.QtdeBSais WITH TmpOpera.QtdeBSais + csTotal.pSais IN TmpOpera
3274:                 ENDSCAN
3275:             ENDIF
3276:         ENDIF
3277: 
3278:         *-- Saldo anterior (CrUltBal -> CrSaldoI)
3279:         loc_cQuery = "SELECT Codigos FROM SigCdFcx " + ;
3280:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3281:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
3282:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
3283:                      " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
3284:                      " ORDER BY Codigos"
3285:         IF SQLEXEC(gnConnHandle, loc_cQuery, "CrUltBal") < 1
3286:             MsgErro("Falha na conex" + CHR(227) + "o (CrUltBal). Reinicializar.", "FormFea")
3287:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3288:             RETURN .F.
3289:         ENDIF
3290:         SELECT CrUltBal
3291:         GO BOTTOM
3292:         IF RECCOUNT() > 0
3293:             loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + TRANSFORM(CrUltBal.Codigos) + ;
3294:                        " AND Emps = " + EscaparSQL(loc_cEmpr) + " ORDER BY Codigos, cpros"
3295:         ELSE
3296:             loc_cSql = "SELECT * FROM SigOpCfe WHERE 0 = 1"
3297:         ENDIF
3298:         IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoI") < 1
3299:             MsgErro("Falha na conex" + CHR(227) + "o (CrSaldoI). Reinicializar.", "FormFea")
3300:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3301:             RETURN .F.
3302:         ENDIF
3303:         SELECT CrSaldoI
3304:         INDEX ON Cpros TAG Cpros
3305: 
3306:         loc_nTrabalhado = 0
3307:         loc_nTrabalhadB = 0
3308: 
3309:         *-- Calcular saldos finais para cada material em TmpResumo
3310:         SELECT TmpResumo
3311:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("TmpResumo"))
3312:         loc_loBarra.Show
3313:         loc_cMatPrev = SPACE(14)
3314: 
3315:         SCAN
3316:             loc_loBarra.Update(.T.)
3317:             STORE 0 TO loc_nSaldoi, loc_nPesagem
3318: 
3319:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3320:             IF !loc_llTipoQ AND TmpResumo.CMats <> loc_cMatPrev
3321:                 loc_nFalhaAdmitida = 0
3322:                 loc_cMatPrev = TmpResumo.CMats
3323:             ENDIF
3324: 
3325:             SELECT CrSaldoI
3326:             =SEEK(TmpResumo.CMats)
3327:             loc_nSaldoi = IIF(EOF("CrSaldoI"), 0, CrSaldoI.Pesagems)
3328: 
3329:             SELECT TmpOpera
3330:             =SEEK(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
3331:             loc_nTrabalhado = 0
3332:             loc_nTrabalhadB = 0
3333:             SCAN WHILE CMats = TmpResumo.CMats
3334:                 =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
3335:                 IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
3336:                    USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3337:                    crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
3338:                    crSigOpOpt.TFalhas <> "Q" AND TmpOpera.AplicFlhs <> 2 AND ;
3339:                    crSigCdPam.GrTrans <> loc_cGrupo
3340:                     loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3)
3341:                     REPLACE PFalha WITH crSigOpOpt.PFalhas, ;
3342:                             Falha  WITH ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3) IN TmpOpera
3343:                 ENDIF
3344:                 IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;

*-- Linhas 3351 a 3527:
3351:                 loc_nTrabalhado = loc_nTrabalhadB
3352:             ENDIF
3353: 
3354:             SELECT TmpResumo
3355:             REPLACE Saldoi  WITH loc_nSaldoi, ;
3356:                     FReal   WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem, ;
3357:                     FAdmin  WITH loc_nFalhaAdmitida, ;
3358:                     Saldof  WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem - loc_nFalhaAdmitida, ;
3359:                     PfTrabs WITH IIF(loc_nTrabalhado <> 0, (Saldof / loc_nTrabalhado * 100), 0)
3360: 
3361:             =SEEK(loc_cConta, "TmpCli", "BalCodigo")
3362:             IF TmpResumo.Saldof <> 0 AND USED("TmpCli") AND !EOF("TmpCli") AND ;
3363:                (TmpCli.PagFals = 1 OR TmpCli.RecFals = 1)
3364:                 REPLACE Flag WITH .T., Flag2 WITH .T. IN TmpResumo
3365:                 IF THIS.this_lFechamento
3366:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
3367:                         loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.Visible = .T.
3368:                     ENDIF
3369:                 ENDIF
3370:             ENDIF
3371:         ENDSCAN
3372: 
3373:         *-- Processar registros do saldo anterior que nao estao em TmpResumo
3374:         SELECT CrSaldoI
3375:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("CrSaldoI"))
3376:         loc_loBarra.Show
3377:         SCAN
3378:             loc_loBarra.Update(.T.)
3379:             IF CrSaldoI.Pesagems = 0
3380:                 LOOP
3381:             ENDIF
3382:             =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
3383:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3384:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3385:             loc_nSaldoi = CrSaldoI.Pesagems
3386:             SELECT TmpResumo
3387:             LOCATE FOR CMats = CrSaldoI.Cpros
3388:             IF EOF()
3389:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3390:                     VALUES (loc_cGrupo, loc_cConta, CrSaldoI.Cpros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3391:                 SELECT TmpResumo
3392:                 REPLACE Saldoi WITH loc_nSaldoi, FReal WITH loc_nSaldoi, ;
3393:                         FAdmin WITH 0, Saldof WITH loc_nSaldoi, PfTrabs WITH 0
3394:             ENDIF
3395:         ENDSCAN
3396: 
3397:         *-- Construir tabela de cotacoes (TmpCot)
3398:         SELECT TmpResumo
3399:         SCAN
3400:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3401:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3402: 
3403:             loc_nCusto = 0
3404:             loc_cMoeda = ""
3405: 
3406:             IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND crSigCdPam.AcertBals = 1
3407:                 loc_nCusto = TmpPro.Custofs
3408:                 loc_cMoeda = ALLTRIM(TmpPro.MoeCusfs)
3409:             ELSE
3410:                 LOCAL loc_pDtHist1, loc_pDtHist2
3411:                 loc_pDtHist1 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData))
3412:                 loc_pDtHist2 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), "23:59:59")
3413:                 loc_cQuery = "SELECT TOP 1 cIdChaves, UnitMeds FROM SigMvHst " + ;
3414:                              "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3415:                              " AND Cpros = " + EscaparSQL(ALLTRIM(TmpResumo.CMats)) + ;
3416:                              " AND Datas BETWEEN ?loc_pDtHist1 AND ?loc_pDtHist2" + ;
3417:                              " ORDER BY cIdChaves DESC, UnitMeds ASC"
3418:                 IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalHis") > 0
3419:                     GO TOP IN LocalHis
3420:                     IF !EOF("LocalHis")
3421:                         loc_nCusto = LocalHis.UnitMeds
3422:                         loc_cMoeda = ALLTRIM(LocalGru.MoeCusts)
3423:                     ENDIF
3424:                 ENDIF
3425:             ENDIF
3426: 
3427:             IF EMPTY(loc_cMoeda)
3428:                 LOOP
3429:             ENDIF
3430: 
3431:             LOCAL loc_dDataFcx
3432:             loc_dDataFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData)
3433:             loc_nCota = fBuscarCotacao(loc_cMoeda, loc_dDataFcx, gnConnHandle)
3434:             IF !SEEK(loc_cMoeda, "TmpCot")
3435:                 INSERT INTO TmpCot (Cmoes, Valos) VALUES (loc_cMoeda, loc_nCota)
3436:             ENDIF
3437:         ENDSCAN
3438: 
3439:         *-- Adicionar cotacoes de todas as moedas (SigCdMoe)
3440:         loc_cSql = "SELECT CMoes FROM SigCdMoe ORDER BY CMoes"
3441:         IF SQLEXEC(gnConnHandle, loc_cSql, "LocalMoe") > 0
3442:             SELECT LocalMoe
3443:             SCAN
3444:                 IF !SEEK(ALLTRIM(LocalMoe.Cmoes), "TmpCot")
3445:                     loc_nCota = fBuscarCotacao(ALLTRIM(LocalMoe.Cmoes), ;
3446:                                                IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), ;
3447:                                                gnConnHandle)
3448:                     INSERT INTO TmpCot (Cmoes, Valos) VALUES (ALLTRIM(LocalMoe.Cmoes), loc_nCota)
3449:                 ENDIF
3450:             ENDSCAN
3451:         ENDIF
3452:         loc_loBarra.Complete()
3453: 
3454:         *-- Posicionar cursores
3455:         SELECT TmpResumo
3456:         SET ORDER TO GrConMat
3457:         GO TOP
3458:         SELECT TmpOpera
3459:         SET ORDER TO GrConMatTp
3460:         SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
3461:         GO TOP
3462:         SELECT TmpResFas
3463:         SET ORDER TO Fases
3464:         SET KEY TO TmpResumo.CMats
3465:         GO TOP
3466:         SELECT TmpResumo
3467:         GO TOP
3468: 
3469:         IF EOF("TmpResumo")
3470:             MsgAviso("Nenhuma Informa" + CHR(231) + CHR(227) + "o Foi Selecionada...")
3471:             loc_oPagina.txt_4c_Data.SetFocus()
3472:             RETURN .F.
3473:         ENDIF
3474: 
3475:         *-- Calcular indice de produtividade
3476:         SELECT a.Grupo, a.Conta, a.CMats, COUNT(a.TpOps) AS TotTpOp, ;
3477:                SUM(c.IndProds) AS TotIndProd, d.Freal, SUM(a.QtdeSais) AS TotQtde ;
3478:             FROM TmpOpera a, crSigOpOpt c, TmpResumo d ;
3479:             WHERE !EMPTY(a.QtdeSais) AND a.TpOps = c.Cods AND c.IndProds > 0 AND ;
3480:                   d.Grupo + d.Conta + d.CMats = a.Grupo + a.Conta + a.CMats ;
3481:             GROUP BY a.Grupo, a.Conta, a.CMats, d.Freal ;
3482:             INTO CURSOR TmpIndProd
3483: 
3484:         IF RECCOUNT("TmpIndProd") > 0
3485:             SELECT a.Grupo, a.Conta, a.CMats, ;
3486:                    ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) AS IndProd ;
3487:                 FROM TmpIndProd a INTO CURSOR TmpIndProd
3488:             UPDATE TmpResumo SET IndProd = TmpIndProd.IndProd ;
3489:                 WHERE TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = ;
3490:                       TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
3491:         ENDIF
3492: 
3493:         *-- Atualizar grdMov RecordSource (controle de Fase 6)
3494:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "grdMov", 5)
3495:             loc_oPagina.cnt_4c_Resultado.grdMov.RecordSource = ""
3496:             SELECT Dopps, 1 AS nMarcas FROM TmpHist GROUP BY Dopps INTO CURSOR CrOpp READWRITE
3497:             WITH loc_oPagina.cnt_4c_Resultado.grdMov
3498:                 .RecordSource          = "crOpp"
3499:                 .Column1.ControlSource = "crOpp.nMarcas"
3500:                 .Column2.ControlSource = "crOpp.Dopps"
3501:                 .Column1.Width = 17
3502:                 .Column2.Width = 150
3503:                 .Refresh()
3504:             ENDWITH
3505:         ENDIF
3506: 
3507:         *-- Inserir no CrSigCdFea se Fechamento
3508:         IF THIS.this_lFechamento
3509:             loc_nNumFape = fGerUniqueKey(loc_cEmpr + "SigCdFea")
3510:             SELECT TmpResumo
3511:             GO TOP
3512:             INSERT INTO CrSigCdFea (Grupos, Contas, Datas, Emps, Falhas, Numes, Produzidos, ;
3513:                                     Tipos, Trabs, CidChaves, NumBals) ;
3514:                 VALUES (loc_cGrupo, loc_cConta, loc_dData, ;
3515:                         IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), ALLTRIM(crSigCdFcx.Emps), loc_cEmpr), ;
3516:                         IIF(!EOF("TmpResumo"), TmpResumo.Saldof, 0), ;
3517:                         loc_nNumFape, 0, "F", loc_nTrabalhado, fUniqueIds(), loc_nCodigosFcx)
3518:         ENDIF
3519: 
3520:         *-- Habilitar Confirmar
3521:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
3522: 
3523:         *-- Exibir resultado (Fase 6: GradeMat refresh via PEMSTATUS)
3524:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "GradeMat", 5)
3525:             loc_oPagina.cnt_4c_Resultado.GradeMat.AfterRowColChange(1)
3526:             loc_oPagina.cnt_4c_Resultado.GradeMat.Refresh
3527:         ENDIF

*-- Linhas 4332 a 4370:
4332:             ENDWITH
4333:             WITH loc_oGrd.Column1
4334:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4335:                 .ControlSource   = "TmpOpera.TpOps"
4336:                 .Width           = 120
4337:             ENDWITH
4338:             WITH loc_oGrd.Column2
4339:                 .Header1.Caption = "Qtde"
4340:                 .ControlSource   = "TmpOpera.QtdeEnts"
4341:                 .Width           = 80
4342:             ENDWITH
4343:             WITH loc_oGrd.Column3
4344:                 .Header1.Caption = "F.Adm"
4345:                 .ControlSource   = "TmpOpera.PFalha"
4346:                 .Width           = 60
4347:             ENDWITH
4348:             WITH loc_oGrd.Column4
4349:                 .Header1.Caption = "Falha"
4350:                 .ControlSource   = "TmpOpera.Falha"
4351:                 .Width           = 60
4352:             ENDWITH
4353:             WITH loc_oGrd.Column5
4354:                 .Header1.Caption = "Base Falha"
4355:                 .ControlSource   = "TmpOpera.PesoBEnts"
4356:                 .Width           = 80
4357:             ENDWITH
4358:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
4359:             BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")
4360: 
4361:             *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
4362:             par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
4363:             WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
4364:                 .Value         = ""
4365:                 .Top           = 220
4366:                 .Left          = 10
4367:                 .Width         = 484
4368:                 .Height        = 23
4369:                 .ReadOnly      = .T.
4370:                 .FontName      = "Tahoma"

*-- Linhas 4394 a 4432:
4394:             ENDWITH
4395:             WITH loc_oGrd.Column1
4396:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4397:                 .ControlSource   = "TmpOpera.TpOps"
4398:                 .Width           = 120
4399:             ENDWITH
4400:             WITH loc_oGrd.Column2
4401:                 .Header1.Caption = "Qtde"
4402:                 .ControlSource   = "TmpOpera.QtdeSais"
4403:                 .Width           = 80
4404:             ENDWITH
4405:             WITH loc_oGrd.Column3
4406:                 .Header1.Caption = "F.Adm"
4407:                 .ControlSource   = "TmpOpera.PFalha"
4408:                 .Width           = 60
4409:             ENDWITH
4410:             WITH loc_oGrd.Column4
4411:                 .Header1.Caption = "Falha"
4412:                 .ControlSource   = "TmpOpera.Falha"
4413:                 .Width           = 60
4414:             ENDWITH
4415:             WITH loc_oGrd.Column5
4416:                 .Header1.Caption = "Base Falha"
4417:                 .ControlSource   = "TmpOpera.PesoBSais"
4418:                 .Width           = 80
4419:             ENDWITH
4420:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
4421:             BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")
4422: 
4423:             *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
4424:             par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
4425:             WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
4426:                 .Value         = ""
4427:                 .Top           = 220
4428:                 .Left          = 10
4429:                 .Width         = 484
4430:                 .Height        = 23
4431:                 .ReadOnly      = .T.
4432:                 .FontName      = "Tahoma"

*-- Linhas 4456 a 4489:
4456:             ENDWITH
4457:             WITH loc_oGrd.Column1
4458:                 .Header1.Caption = "Fases"
4459:                 .ControlSource   = "TmpResFas.Fases"
4460:                 .Width           = 120
4461:             ENDWITH
4462:             WITH loc_oGrd.Column2
4463:                 .Header1.Caption = "Qtde"
4464:                 .ControlSource   = "TmpResFas.Qtds"
4465:                 .Width           = 120
4466:             ENDWITH
4467:             WITH loc_oGrd.Column3
4468:                 .Header1.Caption = "Pe" + CHR(231) + "as"
4469:                 .ControlSource   = "TmpResFas.QtdPcs"
4470:                 .Width           = 120
4471:             ENDWITH
4472:             WITH loc_oGrd.Column4
4473:                 .Header1.Caption = "Pesos"
4474:                 .ControlSource   = "TmpResFas.Pesos"
4475:                 .Width           = 120
4476:             ENDWITH
4477: 
4478:             *-- cnt_4c_Conversao (top=292,left=192,w=248,h=66) - inicia oculto
4479:             par_oCnt.AddObject("cnt_4c_Conversao", "Container")
4480:             WITH par_oCnt.cnt_4c_Conversao
4481:                 .Top         = 292
4482:                 .Left        = 192
4483:                 .Width       = 248
4484:                 .Height      = 66
4485:                 .BackColor   = RGB(240, 240, 240)
4486:                 .BackStyle   = 1
4487:                 .Visible     = .F.
4488:             ENDWITH
4489:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_TituloConv", "Label")

*-- Linhas 4594 a 4636:
4594:             ENDWITH
4595:             WITH loc_oGrd.Column1
4596:                 .Header1.Caption = "Material"
4597:                 .ControlSource   = "TmpResumo.CMats"
4598:                 .Width           = 110
4599:                 .ReadOnly        = .T.
4600:             ENDWITH
4601:             WITH loc_oGrd.Column2
4602:                 .Header1.Caption = ""
4603:                 .ControlSource   = "TmpResumo.Flag3"
4604:                 .Width           = 32
4605:                 .Sparse          = .F.
4606:             ENDWITH
4607:             loc_oGrd.Column2.AddObject("Check1", "CheckBox")
4608:             WITH loc_oGrd.Column2.Check1
4609:                 .Caption   = ""
4610:                 .Alignment = 0
4611:                 .ReadOnly  = .F.
4612:                 .Visible   = .T.
4613:                 .Top       = 9
4614:                 .Left      = 2
4615:                 .Height    = 17
4616:                 .Width     = 22
4617:             ENDWITH
4618:             loc_oGrd.Column2.CurrentControl = "Check1"
4619:             WITH loc_oGrd.Column3
4620:                 .Header1.Caption = "I"
4621:                 .ControlSource   = "TmpResumo.Flag2"
4622:                 .Width           = 32
4623:                 .Sparse          = .F.
4624:                 .ReadOnly        = .T.
4625:             ENDWITH
4626:             loc_oGrd.Column3.AddObject("Check1", "CheckBox")
4627:             WITH loc_oGrd.Column3.Check1
4628:                 .Caption   = ""
4629:                 .Alignment = 0
4630:                 .ReadOnly  = .T.
4631:                 .Visible   = .T.
4632:                 .Top       = 9
4633:                 .Left      = 2
4634:                 .Height    = 17
4635:                 .Width     = 22
4636:             ENDWITH

*-- Linhas 4668 a 4686:
4668:             IF !USED("TmpGccr")
4669:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4670:             ELSE
4671:                 SELECT TmpGccr
4672:                 GO TOP
4673:                 SET ORDER TO BalCodigo
4674:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4675:                 IF VARTYPE(loc_oBusca) = "O"
4676:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4677:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4678:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4679:                     loc_oBusca.Show()
4680:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4681:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4682:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4683:                         ENDIF
4684:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4685:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4686:                         ENDIF

*-- Linhas 4716 a 4754:
4716:             IF !USED("TmpGccr")
4717:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4718:             ELSE
4719:                 SELECT TmpGccr
4720:                 SET ORDER TO BalDescrs
4721:                 GO TOP
4722:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4723:                 IF VARTYPE(loc_oBusca) = "O"
4724:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4725:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4726:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4727:                     loc_oBusca.Show()
4728:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4729:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4730:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4731:                         ENDIF
4732:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4733:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4734:                         ENDIF
4735:                     ENDIF
4736:                     loc_oBusca.Release()
4737:                     loc_oBusca = .NULL.
4738:                 ENDIF
4739:                 SELECT TmpGccr
4740:                 SET ORDER TO BalCodigo
4741:             ENDIF
4742:         CATCH TO loc_oErro
4743:             MsgErro("Erro em AbrirLookupDGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4744:         ENDTRY
4745:     ENDPROC
4746: 
4747:     *==========================================================================
4748:     * ContaKeyPress / ContaDblClick / AbrirLookupConta
4749:     * Lookup de Conta de Balanco (TmpCli pre-carregado)
4750:     *==========================================================================
4751:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4752:         IF INLIST(par_nKeyCode, 13, 9, 115)
4753:             THIS.AbrirLookupConta()
4754:             NODEFAULT

*-- Linhas 4766 a 4784:
4766:             IF !USED("TmpCli")
4767:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4768:             ELSE
4769:                 SELECT TmpCli
4770:                 GO TOP
4771:                 SET ORDER TO BalCodigo
4772:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4773:                 IF VARTYPE(loc_oBusca) = "O"
4774:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4775:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4776:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4777:                     loc_oBusca.Show()
4778:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4779:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4780:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4781:                         ENDIF
4782:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4783:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4784:                         ENDIF

*-- Linhas 4814 a 4852:
4814:             IF !USED("TmpCli")
4815:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4816:             ELSE
4817:                 SELECT TmpCli
4818:                 SET ORDER TO BalNome
4819:                 GO TOP
4820:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4821:                 IF VARTYPE(loc_oBusca) = "O"
4822:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4823:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4824:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4825:                     loc_oBusca.Show()
4826:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4827:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4828:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4829:                         ENDIF
4830:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4831:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4832:                         ENDIF
4833:                     ENDIF
4834:                     loc_oBusca.Release()
4835:                     loc_oBusca = .NULL.
4836:                 ENDIF
4837:                 SELECT TmpCli
4838:                 SET ORDER TO BalCodigo
4839:             ENDIF
4840:         CATCH TO loc_oErro
4841:             MsgErro("Erro em AbrirLookupDConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4842:         ENDTRY
4843:     ENDPROC
4844: 
4845:     *==========================================================================
4846:     * MoedaLostFocus - Lookup de Moeda (SigCdMoe) ao sair do campo
4847:     * PUBLIC: BINDEVENT em txt_4c_MOEDA.LostFocus
4848:     *==========================================================================
4849:     PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
4850:         LOCAL loc_oCnt, loc_cMoeda, loc_oBusca
4851:         TRY
4852:             loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.cnt_4c_Conversao

*-- Linhas 4904 a 4955:
4904:         TRY
4905:             IF USED("TmpResumo") AND !EOF("TmpResumo")
4906:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
4907:                 SELECT TmpResumo
4908: 
4909:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
4910:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
4911:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
4912:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
4913:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
4914:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
4915:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
4916:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
4917:                 loc_oCnt.Get_Pfalha.Value    = TmpResumo.PfTrabs
4918: 
4919:                 *-- Atualizar GradeEntradas com filtro do material corrente
4920:                 IF USED("TmpOpera")
4921:                     SELECT TmpOpera
4922:                     SET ORDER TO GrConMatTp
4923:                     SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
4924:                     GO TOP
4925:                 ENDIF
4926: 
4927:                 IF PEMSTATUS(loc_oCnt, "Pagina", 5)
4928:                     loc_oPage1 = loc_oCnt.Pagina.Pages(1)
4929:                     IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
4930:                         loc_oPage1.GradeEntradas.Refresh()
4931:                         loc_oPage1.GradeEntradas.AfterRowColChange(1)
4932:                     ENDIF
4933:                     loc_oPage2 = loc_oCnt.Pagina.Pages(2)
4934:                     IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
4935:                         loc_oPage2.GradeSaidas.Refresh()
4936:                     ENDIF
4937: 
4938:                     *-- Atualizar GradeResumo com filtro do material corrente
4939:                     IF USED("TmpResFas")
4940:                         SELECT TmpResFas
4941:                         SET KEY TO TmpResumo.CMats
4942:                         GO TOP
4943:                     ENDIF
4944:                     IF PEMSTATUS(loc_oCnt.Pagina.Pages(3), "GradeResumo", 5)
4945:                         loc_oCnt.Pagina.Pages(3).GradeResumo.Refresh()
4946:                     ENDIF
4947:                 ENDIF
4948: 
4949:                 *-- Atualizar datas do periodo no cabecalho do resultado
4950:                 IF PEMSTATUS(loc_oCnt, "Get_Datai", 5)
4951:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo, "txt_4c_DtInicial", 5)
4952:                         loc_oCnt.Get_Datai.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
4953:                         loc_oCnt.Get_Dataf.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
4954:                     ENDIF
4955:                 ENDIF

*-- Linhas 5010 a 5036:
5010:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5011:                 IF !TmpResumo.Flag2
5012:                     MsgAviso("Esta Conta N" + CHR(227) + "o Permite Acerto de Balan" + CHR(231) + "o...")
5013:                     SELECT TmpResumo
5014:                     REPLACE Flag3 WITH .F.
5015:                     IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5016:                         loc_oCnt.GradeMat.Refresh()
5017:                     ENDIF
5018:                 ELSE
5019:                     IF TmpResumo.Saldof = 0 AND TmpResumo.Flag3
5020:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Diferen" + CHR(231) + CHR(97) + "  Para Acerto...")
5021:                         SELECT TmpResumo
5022:                         REPLACE Flag3 WITH .F.
5023:                         IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5024:                             loc_oCnt.GradeMat.Refresh()
5025:                         ENDIF
5026:                     ENDIF
5027:                 ENDIF
5028:             ENDIF
5029:         CATCH TO loc_oErro
5030:             MsgErro("Erro em GradeMatCheck1Change:" + CHR(13) + loc_oErro.Message, "FormFea")
5031:         ENDTRY
5032:     ENDPROC
5033: 
5034:     *==========================================================================
5035:     * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
5036:     * PUBLIC: BINDEVENT exige metodo publico

*-- Linhas 5083 a 5101:
5083:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5084:                 loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5085:                 loc_nPesagem = NVL(loc_oCnt.Get_Pesagem.Value, 0)
5086:                 SELECT TmpResumo
5087:                 REPLACE Pesagem WITH loc_nPesagem, ;
5088:                         Saldof  WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem - TmpResumo.FAdmin, ;
5089:                         FReal   WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem
5090:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
5091:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
5092:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
5093:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
5094:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
5095:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
5096:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
5097:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
5098:                 loc_oCnt.Get_Pesagem.ReadOnly = .T.
5099:             ENDIF
5100:         CATCH TO loc_oErro
5101:             MsgErro("Erro em PesagemLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")

*-- Linhas 5109 a 5212:
5109:     PROCEDURE BtnSelTudoClick()
5110:         TRY
5111:             IF USED("TmpResumo")
5112:                 SELECT TmpResumo
5113:                 REPLACE ALL Flag3 WITH .T.
5114:                 GO TOP
5115:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5116:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5117:                 ENDIF
5118:             ENDIF
5119:         CATCH TO loc_oErro
5120:             MsgErro("Erro em BtnSelTudoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5121:         ENDTRY
5122:     ENDPROC
5123: 
5124:     *==========================================================================
5125:     * BtnApagaClick - Desmarca todos os materiais (Flag3=.F.) no GradeMat
5126:     * PUBLIC: BINDEVENT exige metodo publico
5127:     *==========================================================================
5128:     PROCEDURE BtnApagaClick()
5129:         TRY
5130:             IF USED("TmpResumo")
5131:                 SELECT TmpResumo
5132:                 REPLACE ALL Flag3 WITH .F.
5133:                 GO TOP
5134:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5135:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5136:                 ENDIF
5137:             ENDIF
5138:         CATCH TO loc_oErro
5139:             MsgErro("Erro em BtnApagaClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5140:         ENDTRY
5141:     ENDPROC
5142: 
5143:     *==========================================================================
5144:     * GrdMovCheck1KeyPress - Alterna nMarcas com Enter/Espaco no grdMov
5145:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
5146:     *==========================================================================
5147:     PROCEDURE GrdMovCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5148:         TRY
5149:             IF INLIST(m.par_nKeyCode, 13, 32)
5150:                 IF USED("crOpp") AND !EOF("crOpp")
5151:                     SELECT crOpp
5152:                     REPLACE nMarcas WITH IIF(crOpp.nMarcas = 0, 1, 0)
5153:                     KEYBOARD "{DNARROW}"
5154:                     KEYBOARD "{UPARROW}"
5155:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "grdMov", 5)
5156:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.grdMov.Refresh()
5157:                     ENDIF
5158:                 ENDIF
5159:                 NODEFAULT
5160:             ENDIF
5161:         CATCH TO loc_oErro
5162:             MsgErro("Erro em GrdMovCheck1KeyPress:" + CHR(13) + loc_oErro.Message, "FormFea")
5163:         ENDTRY
5164:     ENDPROC
5165: 
5166:     *==========================================================================
5167:     * PaginaResultadoPage1Activate - Ativa aba Entradas (seta ordem TmpOpera)
5168:     * PUBLIC: BINDEVENT em Pagina.Pages(1).Activate
5169:     *==========================================================================
5170:     PROCEDURE PaginaResultadoPage1Activate()
5171:         LOCAL loc_oPage1
5172:         TRY
5173:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5174:                 SELECT TmpOpera
5175:                 SET ORDER TO GrConMatTp
5176:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5177:                 GO TOP
5178:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
5179:                 IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
5180:                     loc_oPage1.GradeEntradas.Refresh()
5181:                     loc_oPage1.GradeEntradas.AfterRowColChange(1)
5182:                 ENDIF
5183:             ENDIF
5184:         CATCH TO loc_oErro
5185:             MsgErro("Erro em PaginaResultadoPage1Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5186:         ENDTRY
5187:     ENDPROC
5188: 
5189:     *==========================================================================
5190:     * PaginaResultadoPage2Activate - Ativa aba Saidas (seta ordem TmpOpera)
5191:     * PUBLIC: BINDEVENT em Pagina.Pages(2).Activate
5192:     *==========================================================================
5193:     PROCEDURE PaginaResultadoPage2Activate()
5194:         LOCAL loc_oPage2
5195:         TRY
5196:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5197:                 SELECT TmpOpera
5198:                 SET ORDER TO GrConMatTp
5199:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5200:                 GO TOP
5201:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
5202:                 IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
5203:                     loc_oPage2.GradeSaidas.Refresh()
5204:                     loc_oPage2.GradeSaidas.AfterRowColChange(1)
5205:                 ENDIF
5206:             ENDIF
5207:         CATCH TO loc_oErro
5208:             MsgErro("Erro em PaginaResultadoPage2Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5209:         ENDTRY
5210:     ENDPROC
5211: 
5212:     *==========================================================================

*-- Linhas 5242 a 5279:
5242:             IF USED("TmpCabec")
5243:                 USE IN TmpCabec
5244:             ENDIF
5245:             CREATE CURSOR TmpCabec (Titulo C(100), SubTitulo C(254), Empresa C(80))
5246: 
5247:             loc_cSubTitulo = ""
5248:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
5249:                 IF USED("TmpCli")
5250:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
5251:                 ENDIF
5252:                 loc_cSubTitulo = " Conta : " + ALLTRIM(NVL(crSigCdFcx.Grupos, "")) + ;
5253:                                  " / " + ALLTRIM(NVL(crSigCdFcx.Contas, ""))
5254:                 IF USED("TmpCli") AND !EOF("TmpCli")
5255:                     loc_cSubTitulo = loc_cSubTitulo + " [ " + ALLTRIM(TmpCli.RClis) + " ] "
5256:                 ENDIF
5257:                 loc_cSubTitulo = loc_cSubTitulo + CHR(13) + CHR(10) + ;
5258:                                  "Per" + CHR(237) + "odo : " + ;
5259:                                  NVL(DTOC(crSigCdFcx.Datais), "") + " a " + ;
5260:                                  NVL(DTOC(crSigCdFcx.Datas), "")
5261:             ENDIF
5262: 
5263:             loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
5264:             INSERT INTO TmpCabec (Titulo, SubTitulo, Empresa) ;
5265:                 VALUES ("Balan" + CHR(231) + "o de Estoque", loc_cSubTitulo, loc_cEmpresa)
5266: 
5267:             *-- Verificar arquivo FRX
5268:             loc_cFRX = FULLPATH(gc_4c_CaminhoReports + "SIGCDFEA.frx")
5269:             IF !FILE(loc_cFRX)
5270:                 MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
5271:                     CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
5272:                     "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5273:             ELSE
5274:                 IF !USED("TmpResumo") OR RECCOUNT("TmpResumo") = 0
5275:                     MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.")
5276:                 ELSE
5277:                     *-- Isolar locale para FRX legado (Pattern #117)
5278:                     loc_cPointOrig    = SET("POINT")
5279:                     loc_cSepOrig      = SET("SEPARATOR")


### BO (C:\4c\projeto\app\classes\FeaBO.prg):
*==============================================================================
* FeaBO.prg - Business Object: Fechamento de Estoque (Balanco)
* Tabela principal: SigCdFcx
* Formulario origem: SIGCDFEA.SCX (frmcadastro)
* Criado: 2026-08-02
*
* Schema SigCdFcx:
*   emps char(3), codigos numeric(6,0), grupos char(10), contas char(10),
*   datais datetime, datas datetime, cpros char(14), entradas numeric(11,3),
*   fadmins numeric(11,3), freals numeric(11,3), pesagems numeric(11,3),
*   saidas numeric(11,3), saldos numeric(11,3), usuars char(10),
*   cidchaves char(20) PK
*==============================================================================

DEFINE CLASS FeaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdFcx (schema exato)
    *--------------------------------------------------------------------------
    this_cEmps      = ""   && emps char(3) - empresa
    this_nCodigos   = 0    && codigos numeric(6,0) - codigo negocio
    this_cGrupos    = ""   && grupos char(10)
    this_cContas    = ""   && contas char(10)
    this_dDatais    = {}   && datais datetime - data inicial
    this_dDatas     = {}   && datas datetime - data final
    this_cCpros     = ""   && cpros char(14) - codigo produto
    this_nEntradas  = 0    && entradas numeric(11,3)
    this_nFadmins   = 0    && fadmins numeric(11,3) - falha admitida
    this_nFreals    = 0    && freals numeric(11,3) - falha real
    this_nPesagems  = 0    && pesagems numeric(11,3)
    this_nSaidas    = 0    && saidas numeric(11,3)
    this_nSaldos    = 0    && saldos numeric(11,3)
    this_cUsuars    = ""   && usuars char(10)
    this_cCidChaves = ""   && cidchaves char(20) - PK

    *--------------------------------------------------------------------------
    * Propriedades de descricao (lookup - nao armazenadas na tabela)
    *--------------------------------------------------------------------------
    this_cDGrupos   = ""   && descricao do grupo (TmpGccr.Descrs)
    this_cDContas   = ""   && descricao da conta (TmpCli.RClis)

    *--------------------------------------------------------------------------
    * Propriedades de filtro de periodo (Page1/Lista)
    *--------------------------------------------------------------------------
    this_cEmpFiltro  = ""  && empresa do filtro (Get_cd_empresa)
    this_dDtInicial  = {}  && data inicial do filtro
    this_dDtFinal    = {}  && data final do filtro

    *--------------------------------------------------------------------------
    * Propriedades de estado do processo
    *--------------------------------------------------------------------------
    this_nLote      = 0    && lote de processamento (getlote - numeric 6)
    this_lFechamento = .T. && registro esta aberto para processamento
    this_lAcInserir  = .F. && acao de insercao ativa
    this_lEntraPeso  = .F. && entrada de peso via balanca

    *--------------------------------------------------------------------------
    * Propriedades de resultado (populadas apos ProcessarBalanco via TmpResumo)
    *--------------------------------------------------------------------------
    this_nSaldoi    = 0    && saldo inicial (TmpResumo.Saldoi)
    this_nQtdeEnts  = 0    && quantidade de entradas (TmpResumo.QtdeEnts)
    this_nSEntradas = 0    && saldo + entradas (calculado: Saldoi + QtdeEnts)
    this_nQtdeSais  = 0    && quantidade de saidas (TmpResumo.QtdeSais)
    this_nPesagem   = 0    && pesagem fisica (TmpResumo.Pesagem)
    this_nFReal     = 0    && falha real (TmpResumo.FReal)
    this_nFAdmin    = 0    && falha admitida (TmpResumo.FAdmin)
    this_nSaldof    = 0    && saldo final (TmpResumo.Saldof)
    this_nPfTrabs   = 0    && percentual falha/trabalhado (TmpResumo.PfTrabs)

    *--------------------------------------------------------------------------
    * Propriedades de filtros de impressao (checkboxes/opcoes do Resultado)
    *--------------------------------------------------------------------------
    this_lPerdas    = .F.  && demonstrativo de perdas (chkPerdas)
    this_lHistorico = .F.  && historico (Historico)
    this_lResumido  = .T.  && resumido - default ativo (Resumido)
    this_lAnalitico = .F.  && analitico (Analitico)
    this_lServicos  = .F.  && servicos (chkServ)
    this_lPorMov    = .F.  && por movimentacao (porMov)
    this_lPorEnv    = .F.  && por envio (porenv)
    this_lPorMat    = .F.  && por material (pormat)
    this_lMovAgru   = .F.  && movimentacao agrupada (MovAgru)
    this_lMovLote   = .F.  && movimentacao por lote (MovLote)
    this_nOrdem     = 1    && opcao de ordem do relatorio (op_ordem)

    *--------------------------------------------------------------------------
    * Propriedades de conversao de moeda (Cnt_Conversao)
    *--------------------------------------------------------------------------
    this_cMoeda     = ""   && codigo da moeda (Get_MOEDA / SigCdMoe.CMoes)
    this_dDataCc    = {}   && data de conversao (Get_DataCc)

    *--------------------------------------------------------------------------
    * Propriedades de tipo de operacao selecionada (AfterRowColChange GradeMat)
    *--------------------------------------------------------------------------
    this_cTpOperacao = ""  && tipo de operacao do grid (TmpOpera.TpOps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFcx"
            THIS.this_cCampoChave = "CidChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdFcx filtrados por empresa e periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cDtF
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpFiltro))

            IF VARTYPE(THIS.this_dDtInicial) = "D" AND !EMPTY(THIS.this_dDtInicial)
                loc_cSQL = loc_cSQL + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF VARTYPE(THIS.this_dDtFinal) = "D" AND !EMPTY(THIS.this_dDtFinal)
                loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                loc_cDtF = LEFT(loc_cDtF, LEN(loc_cDtF) - 1) + " 23:59:59'"
                loc_cSQL = loc_cSQL + " AND a.Datas <= " + loc_cDtF
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas, a.Datas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao listar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_nCodigos   = TratarNulo(Codigos,   "N")
                THIS.this_cGrupos    = TratarNulo(Grupos,    "C")
                THIS.this_cContas    = TratarNulo(Contas,    "C")
                THIS.this_dDatais    = IIF(ISNULL(Datais),   {}, TTOD(Datais))
                THIS.this_dDatas     = IIF(ISNULL(Datas),    {}, TTOD(Datas))
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_nEntradas  = TratarNulo(Entradas,  "N")
                THIS.this_nFadmins   = TratarNulo(Fadmins,   "N")
                THIS.this_nFreals    = TratarNulo(Freals,    "N")
                THIS.this_nPesagems  = TratarNulo(Pesagems,  "N")
                THIS.this_nSaidas    = TratarNulo(Saidas,    "N")
                THIS.this_nSaldos    = TratarNulo(Saldos,    "N")
                THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Gerar chave primaria unica via SQL Server
            SQLEXEC(gnConnHandle, "SELECT REPLACE(CAST(NEWID() AS VARCHAR(36)),'-','') AS chave", "cursor_4c_ChaveNova")
            IF USED("cursor_4c_ChaveNova") AND RECCOUNT("cursor_4c_ChaveNova") > 0
                SELECT cursor_4c_ChaveNova
                THIS.this_cCidChaves = LEFT(ALLTRIM(chave), 20)
                USE IN cursor_4c_ChaveNova
            ELSE
                IF USED("cursor_4c_ChaveNova")
                    USE IN cursor_4c_ChaveNova
                ENDIF
                THIS.this_cCidChaves = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa) + "FCX" + TRANSFORM(SECONDS()), 20)
            ENDIF

            THIS.this_cEmps   = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "INSERT INTO SigCdFcx" + ;
                       " (Emps, Codigos, Grupos, Contas, Datais, Datas," + ;
                       "  Cpros, Entradas, Fadmins, Freals, Pesagems," + ;
                       "  Saidas, Saldos, Usuars, CidChaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatais) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFadmins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFreals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesagems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaidas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaldos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdFcx SET" + ;
                       " Grupos   = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                       " Contas   = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
                       " Datais   = " + FormatarDataSQL(THIS.this_dDatais) + "," + ;
                       " Datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Cpros    = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + "," + ;
                       " Entradas = " + FormatarNumeroSQL(THIS.this_nEntradas) + "," + ;
                       " Fadmins  = " + FormatarNumeroSQL(THIS.this_nFadmins) + "," + ;
                       " Freals   = " + FormatarNumeroSQL(THIS.this_nFreals) + "," + ;
                       " Pesagems = " + FormatarNumeroSQL(THIS.this_nPesagems) + "," + ;
                       " Saidas   = " + FormatarNumeroSQL(THIS.this_nSaidas) + "," + ;
                       " Saldos   = " + FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                       " Usuars   = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdFcx e movimentos relacionados
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cEdns
        loc_lResultado = .F.

        TRY
            *-- Chave composta usada em SigMvCab/SigMvItn
            loc_cEdns = LEFT(ALLTRIM(THIS.this_cEmps), 3) + PADL(TRANSFORM(THIS.this_nCodigos), 6, "0")

            *-- Excluir itens de movimentos (SigMvItn)
            loc_cSQL    = "DELETE FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Excluir cabecalho de movimentos (SigMvCab)
                loc_cSQL    = "DELETE FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Excluir registro principal (SigCdFcx)
                    loc_cSQL    = "DELETE FROM SigCdFcx WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir Fechamento de Estoque (SigCdFcx):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir cabecalho de movimentos (SigMvCab):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens de movimentos (SigMvItn):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherFiltro - Define parametros de filtro empresa + periodo
    *--------------------------------------------------------------------------
    PROCEDURE PreencherFiltro(par_cEmp, par_dDtI, par_dDtF)
        THIS.this_cEmpFiltro = ALLTRIM(par_cEmp)
        THIS.this_dDtInicial = par_dDtI
        THIS.this_dDtFinal   = par_dDtF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega cursor de grupos de conta corrente para lookup
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT g.Codigos, g.Descrs FROM SigCdGcr g"

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " WHERE g.Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY g.Descrs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar grupos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarContas - Carrega cursor de contas/clientes para lookup (SigCdCli)
    *--------------------------------------------------------------------------
    FUNCTION BuscarContas(par_cGrupo, par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT c.Iclis, c.RClis, c.Inativas FROM SigCdCli c ORDER BY c.RClis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaConta")
                TABLEREVERT(.T., "cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

