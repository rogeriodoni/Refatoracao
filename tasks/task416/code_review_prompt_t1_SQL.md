# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (14)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CGRUS, NAGMTS, VARIAS, NUMBALDS, DATAS, GRUPOOS, CONTAOS, CPROS, INDPRODS, CRMATERIA, CRENTSA, CMATS, CHKDESTS, DOPPS, EMPDNPS, NENVS, NOPS, NLOTES, NMARCAS, LNTOTOP, _PENTRADA, _PSAIDA, _SAIDA, GERBALS, EMPDOPNUMS, CIDCHAVES, NUMBALS, EMPGRUESTS, CODCORS, CODTAMS, SPESOS, LNQT, ORIGEMS, _VALOR, VALUE, CONTADS, PROCDBAL, PROCBALS, TFALHAS, GRUESTPS, CONESTPS, EMPDS, 0, OPERS, AGREGAS, PESAGEM, CSTOTAL, APLICFLHS, LCQUERY, CODIGOS, RECFALS, SERVICOS, CONTAS, GRUPOS
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg) - TRECHOS RELEVANTES PARA PASS SQL (5369 linhas total):

*-- Linhas 519 a 537:
519:             .HighlightBackColor = RGB(255, 255, 255)
520:             .HighlightForeColor = RGB(15, 41, 104)
521:             .HighlightStyle     = 2
522:             .DeleteMark         = .F.
523:             .RecordMark         = .F.
524:             .RowHeight          = 16
525:             .ScrollBars         = 2
526:             .GridLines          = 3
527:             .Visible            = .T.
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
530:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
531: 
532:         THIS.TornarControlesVisiveis(loc_oPagina)
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * ConfigurarPaginaDados - Configura Page2 (edicao + resultado de balanco)
537:     * FASE 5: container BotoesAcao + botoes Confirmar/Cancelar + Shape +

*-- Linhas 968 a 1010:
968: 
969:     *==========================================================================
970:     * CarregarLista - Carrega/recarrega grid da Page1 com dados do periodo filtrado
971:     * OBRIGATORIO: rebind ControlSource + Headers APOS RecordSource (Problema 2/48)
972:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
973:     *==========================================================================
974:     PROCEDURE CarregarLista()
975:         LOCAL loc_lResultado, loc_oGrid, loc_cEmp, loc_dDtI, loc_dDtF
976:         loc_lResultado = .F.
977: 
978:         TRY
979:             loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
980:             loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
981:             loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
982: 
983:             THIS.this_oBusinessObject.PreencherFiltro(loc_cEmp, loc_dDtI, loc_dDtF)
984: 
985:             IF THIS.this_oBusinessObject.Buscar("")
986:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
987: 
988:                 loc_oGrid.ColumnCount  = 5
989:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
990: 
991:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
992:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
993:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
994:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
995:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datais"
996: 
997:                 loc_oGrid.Column1.Width = 70
998:                 loc_oGrid.Column2.Width = 120
999:                 loc_oGrid.Column3.Width = 120
1000:                 loc_oGrid.Column4.Width = 200
1001:                 loc_oGrid.Column5.Width = 200
1002: 
1003:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d."
1004:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1005:                 loc_oGrid.Column3.Header1.Caption = "Conta"
1006:                 loc_oGrid.Column4.Header1.Caption = "Data Encerramento"
1007:                 loc_oGrid.Column5.Header1.Caption = "Data In" + CHR(237) + "cio"
1008: 
1009:                 THIS.FormatarGridLista(loc_oGrid)
1010: 

*-- Linhas 1082 a 1100:
1082:         loc_cCidChaves = ""
1083: 
1084:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1085:             SELECT cursor_4c_Dados
1086:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1087:         ENDIF
1088: 
1089:         IF EMPTY(loc_cCidChaves)
1090:             MsgAviso("Selecione um registro para visualizar.")
1091:         ELSE
1092:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1093:                 THIS.this_cPcEscolha = "CONSULTAR"
1094:                 THIS.this_cModoAtual = "VISUALIZAR"
1095:                 THIS.AlternarPagina(2)
1096:                 THIS.AjustarBotoesPorModo()
1097:                 THIS.HabilitarCampos()
1098:             ENDIF
1099:         ENDIF
1100:     ENDPROC

*-- Linhas 1108 a 1126:
1108:         loc_cCidChaves = ""
1109: 
1110:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1111:             SELECT cursor_4c_Dados
1112:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1113:         ENDIF
1114: 
1115:         IF EMPTY(loc_cCidChaves)
1116:             MsgAviso("Selecione um registro para alterar.")
1117:         ELSE
1118:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1119:                 THIS.this_oBusinessObject.EditarRegistro()
1120:                 THIS.this_cPcEscolha = "ALTERAR"
1121:                 THIS.this_cModoAtual = "ALTERAR"
1122:                 THIS.AlternarPagina(2)
1123:                 THIS.AjustarBotoesPorModo()
1124:                 THIS.HabilitarCampos()
1125:             ENDIF
1126:         ENDIF

*-- Linhas 1136 a 1154:
1136:         loc_lConfirma  = .F.
1137: 
1138:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1139:             SELECT cursor_4c_Dados
1140:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1141:         ENDIF
1142: 
1143:         IF EMPTY(loc_cCidChaves)
1144:             MsgAviso("Selecione um registro para excluir.")
1145:         ELSE
1146:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1147:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1148:                     "Confirmar Exclus" + CHR(227) + "o")
1149:                 IF loc_lConfirma
1150:                     IF THIS.this_oBusinessObject.Excluir()
1151:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1152:                         THIS.CarregarLista()
1153:                     ENDIF
1154:                 ENDIF

*-- Linhas 1317 a 1404:
1317:         TRY
1318:             *-- crSigCdPac - parametros de conta do balanco
1319:             IF !USED("crSigCdPac")
1320:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
1321:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
1322:             ENDIF
1323: 
1324:             *-- crSigCdPam - parametros de material do balanco
1325:             IF !USED("crSigCdPam")
1326:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
1327:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
1328:             ENDIF
1329: 
1330:             *-- TmpGccr - grupos de balanco da empresa (SigCdGcc)
1331:             *-- Campos: Codigos (BalCodigo), Descrs (BalDescrs), UnifBals, GruFals, etc.
1332:             IF !USED("TmpGccr")
1333:                 loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals, BalCodigo, BalDescrs FROM SigCdGcc " + ;
1334:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr)
1335:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
1336:                     SELECT TmpGccr
1337:                     INDEX ON BalCodigo  TAG BalCodigo
1338:                     INDEX ON BalDescrs  TAG BalDescrs
1339:                     SET ORDER TO BalCodigo
1340:                 ENDIF
1341:             ENDIF
1342: 
1343:             *-- TmpCli - contas de balanco (clientes/contas correntes)
1344:             IF !USED("TmpCli")
1345:                 loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
1346:                            "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
1347:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
1348:                     SELECT TmpCli
1349:                     INDEX ON BalCodigo TAG BalCodigo
1350:                     INDEX ON BalNome   TAG BalNome
1351:                     SET ORDER TO BalCodigo
1352:                 ENDIF
1353:             ENDIF
1354: 
1355:             *-- TmpPro - produtos/materiais (SigCdPro)
1356:             IF !USED("TmpPro")
1357:                 loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
1358:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
1359:                     SELECT TmpPro
1360:                     INDEX ON CPros TAG CPros
1361:                     SET ORDER TO CPros
1362:                 ENDIF
1363:             ENDIF
1364: 
1365:             *-- crSigOpOpt - opcoes de operacao (SigOpOpt)
1366:             IF !USED("crSigOpOpt")
1367:                 loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
1368:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
1369:                     SELECT crSigOpOpt
1370:                     INDEX ON Cods TAG Cods
1371:                     SET ORDER TO Cods
1372:                 ENDIF
1373:             ENDIF
1374: 
1375:             *-- LocalOpp - tipos de operacao de producao (SigCdNop)
1376:             IF !USED("LocalOpp")
1377:                 loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
1378:                 IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
1379:                     SELECT LocalOpp
1380:                     INDEX ON Dopps TAG Dopps
1381:                     SET ORDER TO Dopps
1382:                 ENDIF
1383:             ENDIF
1384: 
1385:             *-- crSigCdOpe - tipos de operacao de estoque (SigCdOpe)
1386:             IF !USED("crSigCdOpe")
1387:                 loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
1388:                 IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
1389:                     SELECT crSigCdOpe
1390:                     INDEX ON Dopes TAG Dopes
1391:                     SET ORDER TO Dopes
1392:                 ENDIF
1393:             ENDIF
1394: 
1395:         CATCH TO loc_oErro
1396:             MsgErro("Erro em CarregarDadosAuxiliares:" + CHR(13) + loc_oErro.Message, "FormFea")
1397:         ENDTRY
1398:     ENDPROC
1399: 
1400:     *==========================================================================
1401:     * BOParaForm - Preenche controles visuais a partir do BO / crSigCdFcx
1402:     * Fase 5: Codigo e Data (Grupo/Conta/Lote em Fase 6)
1403:     *==========================================================================
1404:     PROTECTED PROCEDURE BOParaForm()

*-- Linhas 1449 a 1467:
1449:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1450: 
1451:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1452:                 SELECT crSigCdFcx
1453:                 REPLACE crSigCdFcx.Datas WITH loc_oPagina.txt_4c_Data.Value
1454: 
1455:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1456:                     REPLACE crSigCdFcx.Grupos WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), LEN(crSigCdFcx.Grupos))
1457:                 ENDIF
1458:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1459:                     REPLACE crSigCdFcx.Contas WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Conta.Value), LEN(crSigCdFcx.Contas))
1460:                 ENDIF
1461:             ENDIF
1462:         CATCH TO loc_oErro
1463:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormFea")
1464:         ENDTRY
1465:     ENDPROC
1466: 
1467:     *==========================================================================

*-- Linhas 1548 a 1590:
1548:                 *-- carregar do SigOpCfe (saldos salvos) vinculados ao crSigCdFcx
1549:                 IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1550:                     LOCAL loc_cSql
1551:                     loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
1552:                                TRANSFORM(crSigCdFcx.Codigos) + ;
1553:                                " AND Emps = " + EscaparSQL(ALLTRIM(crSigCdFcx.Emps)) + ;
1554:                                " ORDER BY Codigos, Cpros"
1555:                     IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoCarreg") > 0
1556:                         *-- Popula TmpResumo a partir dos saldos salvos
1557:                         IF !USED("TmpResumo")
1558:                             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), ;
1559:                                 CUnis C(10), Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), ;
1560:                                 Saldof N(12,3), PfTrabs N(8,2), IndProd N(8,2), ;
1561:                                 PesoEnts N(12,3), PesoSais N(12,3), QtdeEnts N(12,3), ;
1562:                                 QtdeSais N(12,3), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1563:                                 Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
1564:                                 Varias N(1), Agregas N(1), Visivel L, ;
1565:                                 Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
1566:                             INDEX ON Grupo + Conta + CMats TAG GrConMat
1567:                             SET ORDER TO GrConMat
1568:                         ELSE
1569:                             SELECT TmpResumo
1570:                             ZAP
1571:                             SET ORDER TO GrConMat
1572:                         ENDIF
1573:                         SELECT CrSaldoCarreg
1574:                         SCAN
1575:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, Saldof) ;
1576:                                 VALUES (crSigCdFcx.Grupos, crSigCdFcx.Contas, ;
1577:                                         CrSaldoCarreg.Cpros, CrSaldoCarreg.Pesagems)
1578:                         ENDSCAN
1579:                         IF USED("CrSaldoCarreg")
1580:                             USE IN CrSaldoCarreg
1581:                         ENDIF
1582:                         loc_lResultado = .T.
1583:                     ENDIF
1584:                 ENDIF
1585:             ENDIF
1586:         CATCH TO loc_oErro
1587:             MsgErro("Erro em CarregarDados:" + CHR(13) + loc_oErro.Message, "FormFea")
1588:         ENDTRY
1589:         RETURN loc_lResultado
1590:     ENDPROC

*-- Linhas 1710 a 1728:
1710:                     ENDIF
1711:                 ELSE
1712:                     *-- Modo posicao (!Fechamento): apenas reverter e voltar
1713:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1714:                     THIS.this_lFechamento = .T.
1715:                     THIS.AlternarPagina(1)
1716:                     loc_lResultado = .T.
1717:                 ENDIF
1718:             ENDIF
1719:         CATCH TO loc_oErro
1720:             MsgErro("Erro em BtnConfirmarClick:" + CHR(13) + loc_oErro.Message + ;
1721:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
1722:         ENDTRY
1723: 
1724:         RETURN loc_lResultado
1725:     ENDPROC
1726: 
1727:     *==========================================================================
1728:     * BtnSalvarClick - Alias canonico de BtnConfirmarClick

*-- Linhas 1746 a 1764:
1746:         TRY
1747:             THIS.this_lCancelar = .T.
1748:             *-- Rollback da transacao SQL corrente
1749:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1750:             THIS.this_lFechamento = .T.
1751:             THIS.AlternarPagina(1)
1752:             loc_lResultado = .T.
1753:         CATCH TO loc_oErro
1754:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "FormFea")
1755:         ENDTRY
1756: 
1757:         RETURN loc_lResultado
1758:     ENDPROC
1759: 
1760:     *==========================================================================
1761:     * IncluirHistorico - Insere registro nos cursores TmpHist e TmpHistC
1762:     * Traducao de inclui_historico (legado). Chamado em SCAN loops dentro
1763:     * de ProcessarBalanco para cada movimento de entrada/saida.
1764:     * PUBLIC: BINDEVENT/SCAN exige metodo publico (CLAUDE.md regra #3)

*-- Linhas 1783 a 1852:
1783:         ENDIF
1784: 
1785:         IF par_cArquivo = "Nens"
1786:             SELECT LocalNens
1787:             IF par_cTipoConta = "O"
1788:                 loc_cGrupo  = LocalNens.Grupoos
1789:                 loc_cConta  = LocalNens.Contaos
1790:                 loc_cGrupo2 = LocalNens.Grupods
1791:                 loc_cConta2 = LocalNens.Contads
1792:             ELSE
1793:                 loc_cGrupo  = LocalNens.Grupods
1794:                 loc_cConta  = LocalNens.Contads
1795:                 loc_cGrupo2 = LocalNens.Grupoos
1796:                 loc_cConta2 = LocalNens.Contaos
1797:             ENDIF
1798:         ELSE
1799:             SELECT LocalEest
1800:             loc_cGrupo  = IIF(TYPE("par_cGrupoo") = "C", par_cGrupoo, SPACE(10))
1801:             loc_cConta  = IIF(TYPE("par_cContao") = "C", par_cContao, SPACE(10))
1802:             loc_cGrupo2 = IIF(TYPE("par_cGrupod") = "C", par_cGrupod, SPACE(10))
1803:             loc_cConta2 = IIF(TYPE("par_cContad") = "C", par_cContad, SPACE(10))
1804:         ENDIF
1805: 
1806:         IF loc_nEntrada = 0 AND loc_nSaida = 0 AND loc_nPEntrada = 0 AND loc_nPSaida = 0
1807:             RETURN
1808:         ENDIF
1809: 
1810:         IF par_cArquivo = "Nens"
1811:             INSERT INTO TmpHist ;
1812:                 (Grupo, Conta, CMats, TpOps, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
1813:                  Grupo2, Conta2, PesoEnts, PesoSais, Nenvs, Obss, Opers, PesoFabre, PesoFabrs, cUnips, Emps, nLotes) ;
1814:                 VALUES ;
1815:                 (loc_cGrupo, loc_cConta, LocalNensI.CMats, LocalNensI.TpOps, LocalNens.Datas, ;
1816:                  loc_nEntrada, loc_nSaida, LocalNens.Dopps, LocalNens.Numps, LocalNensI.CUnis, ;
1817:                  loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, LocalNensI.Nenvs, ;
1818:                  NVL(LocalNens.Obss, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
1819:                  TmpPro.cUnips, LocalNens.Emps, LocalNens.nLotes)
1820: 
1821:             IF NOT SEEK(LocalNens.EmpDnPs, "TmpHistC", "EmpDnPs")
1822:                 INSERT INTO TmpHistC (EmpDnPs, Obss) ;
1823:                     VALUES (LocalNens.EmpDnPs, TmpHist.Obss)
1824:             ENDIF
1825:         ELSE
1826:             INSERT INTO TmpHist ;
1827:                 (Grupo, Conta, CMats, Datas, QtdeEnts, QtdeSais, Dopps, Numps, cUnis, ;
1828:                  Grupo2, Conta2, PesoEnts, PesoSais, Obss, Opers, PesoFabre, PesoFabrs, cUniPs, Emps) ;
1829:                 VALUES ;
1830:                 (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEest.Datas, ;
1831:                  loc_nEntrada, loc_nSaida, LocalEest.Dopes, LocalEest.Numes, LocalEestI.CUnis, ;
1832:                  loc_cGrupo2, loc_cConta2, loc_nPEntrada, loc_nPSaida, ;
1833:                  NVL(LocalEest.Obses, ""), par_cTipo, loc_nPfEntrada, loc_nPfSaida, ;
1834:                  TmpPro.cuniPs, LocalEest.Emps)
1835: 
1836:             IF NOT SEEK(LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), "TmpHistC", "EmpDnPs")
1837:                 INSERT INTO TmpHistC (EmpDnPs, Obss) ;
1838:                     VALUES (LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 10), TmpHist.Obss)
1839:             ENDIF
1840:         ENDIF
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * BtnProcessarClick - Valida campos e executa ProcessarBalanco
1845:     * Legado: Processar.Click (o maior metodo do formulario: ~1475 linhas)
1846:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1847:     *==========================================================================
1848:     PROCEDURE BtnProcessarClick()
1849:         LOCAL loc_lResultado
1850:         loc_lResultado = .F.
1851: 
1852:         TRY

*-- Linhas 1873 a 1898:
1873:     *  6. Calculo de saldos finais (CrUltBal / CrSaldoI)
1874:     *  7. Calculo de cotacoes (TmpCot)
1875:     *  8. Calcular indice de produtividade
1876:     *  9. Se Fechamento: INSERT em CrSigCdFea
1877:     * 10. Exibir cnt_4c_Resultado
1878:     *==========================================================================
1879:     PROTECTED FUNCTION ProcessarBalanco()
1880:         LOCAL loc_oPagina, loc_cEmpr
1881:         LOCAL loc_cGrupo, loc_cConta, loc_dData, loc_nCodigo, loc_nLote
1882:         LOCAL loc_pDtI, loc_pDtF, loc_llFalse, loc_llTrue
1883:         LOCAL loc_cQuery, loc_cUpdate, loc_cSql, loc_cEdn, loc_cEGE
1884:         LOCAL loc_cMatSec, loc_nFalhaAdmitida, loc_llTipoQ, loc_llGrvPrz
1885:         LOCAL loc_cMaterial, loc_cMatResFa, loc_cOperacao
1886:         LOCAL loc_lOrigem, loc_lDestino, loc_lOrigemF, loc_lDestinoF
1887:         LOCAL loc_nPesoTotal, loc_nQtde, loc_nPeso, loc_nFalha
1888:         LOCAL loc_cCodCor, loc_cCodTam
1889:         LOCAL loc_cGrupoD, loc_cContaD
1890:         LOCAL loc_nNumFape, loc_nTrabalhado, loc_nTrabalhadB
1891:         LOCAL loc_nSaldoi, loc_nPesagem
1892:         LOCAL loc_cMoeda, loc_nCusto, loc_nCota
1893:         LOCAL loc_dDataUBal, loc_nNdFechas, loc_nCodigosFcx
1894:         LOCAL loc_cMatPrev, loc_cMatOuro
1895:         LOCAL loc_loBarra
1896: 
1897:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1898:         loc_cEmpr   = THIS.this_cPEmps

*-- Linhas 1944 a 2139:
1944:             RETURN .F.
1945:         ENDIF
1946: 
1947:         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1948: 
1949:         *-- Ocultar resultado + resetar EntraPeso
1950:         loc_oPagina.cnt_4c_Resultado.Visible = .F.
1951:         THIS.this_lEntraPeso = .F.
1952: 
1953:         *-- ZAP / CREATE cursores temporarios
1954:         IF USED("TmpCot")
1955:             ZAP IN TmpCot
1956:         ELSE
1957:             CREATE CURSOR TmpCot (Cmoes C(10), Valos N(18,6))
1958:             INDEX ON Cmoes TAG Cmoes
1959:             SET ORDER TO Cmoes
1960:         ENDIF
1961: 
1962:         IF USED("TmpConta")
1963:             ZAP IN TmpConta
1964:             SELECT TmpConta
1965:             SET ORDER TO GrConta
1966:         ELSE
1967:             CREATE CURSOR TmpConta (Grupo C(10), Conta C(10), Nome C(80))
1968:             INDEX ON Grupo + Conta TAG GrConta
1969:             SET ORDER TO GrConta
1970:         ENDIF
1971: 
1972:         IF USED("TmpHist")
1973:             ZAP IN TmpHist
1974:         ELSE
1975:             CREATE CURSOR TmpHist (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), Datas D, ;
1976:                                    QtdeEnts N(12,3), QtdeSais N(12,3), Dopps C(15), ;
1977:                                    Numps N(10), cUnis C(10), Grupo2 C(10), Conta2 C(10), ;
1978:                                    PesoEnts N(12,3), PesoSais N(12,3), Nenvs N(10), ;
1979:                                    Obss C(100), Opers C(1), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1980:                                    cUnips C(10), Emps C(3), nLotes N(6))
1981:         ENDIF
1982: 
1983:         IF USED("TmpHistC")
1984:             ZAP IN TmpHistC
1985:         ELSE
1986:             CREATE CURSOR TmpHistC (EmpDnPs C(23), Obss C(100))
1987:             INDEX ON EmpDnPs TAG EmpDnPs
1988:             SET ORDER TO EmpDnPs
1989:         ENDIF
1990: 
1991:         IF USED("TmpPrz")
1992:             ZAP IN TmpPrz
1993:             SELECT TmpPrz
1994:             SET ORDER TO TmpPrz
1995:         ELSE
1996:             CREATE CURSOR TmpPrz (Datas D, TpOps C(15), Pesos N(12,3), Qtds N(12,3))
1997:             INDEX ON SPACE(1) + DTOS(Datas) + TpOps TAG TmpPrz
1998:             SET ORDER TO TmpPrz
1999:         ENDIF
2000: 
2001:         IF USED("CrSigCdFea")
2002:             ZAP IN CrSigCdFea
2003:         ELSE
2004:             CREATE CURSOR CrSigCdFea (Grupos C(10), Contas C(10), Datas D, Emps C(3), ;
2005:                                       Falhas N(12,3), Numes N(6,0), Produzidos N(12,3), ;
2006:                                       Tipos C(1), Trabs N(12,3), CidChaves C(36), NumBals N(6,0))
2007:         ENDIF
2008: 
2009:         IF USED("TmpOpera")
2010:             SELECT TmpOpera
2011:             SET ORDER TO GrConMatTp ASCENDING
2012:             SET KEY TO
2013:             ZAP
2014:         ELSE
2015:             CREATE CURSOR TmpOpera (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), ;
2016:                                     PesoEnts N(12,3), PesoSais N(12,3), ;
2017:                                     QtdeEnts N(12,3), QtdeSais N(12,3), ;
2018:                                     PesoBEnts N(12,3), PesoBSais N(12,3), ;
2019:                                     QtdeBEnts N(12,3), QtdeBSais N(12,3), ;
2020:                                     Varias N(1,0), Agregas N(1,0), AplicFlhs N(1,0), ;
2021:                                     PFalha N(6,2), Falha N(12,3))
2022:             INDEX ON Grupo + Conta + CMats + TpOps TAG GrConMatTp
2023:             SET ORDER TO GrConMatTp
2024:         ENDIF
2025: 
2026:         IF USED("TmpResFas")
2027:             SELECT TmpResFas
2028:             SET ORDER TO
2029:             ZAP
2030:         ELSE
2031:             CREATE CURSOR TmpResFas (Cmats C(14), Opers C(1), Fases C(10), OpFase C(18), ;
2032:                                      Qtds N(12,3), Pesos N(12,3), QtdPcs N(12,3))
2033:             INDEX ON Cmats + Opers + Fases TAG Fases
2034:             SET ORDER TO Fases
2035:         ENDIF
2036: 
2037:         IF USED("TmpResumo")
2038:             SELECT TmpResumo
2039:             ZAP
2040:             SET ORDER TO GrConMat
2041:         ELSE
2042:             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), CUnis C(10), ;
2043:                                      PesoEnts N(12,3), PesoSais N(12,3), ;
2044:                                      QtdeEnts N(12,3), QtdeSais N(12,3), ;
2045:                                      PesoFabre N(12,3), PesoFabrs N(12,3), ;
2046:                                      Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
2047:                                      Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), ;
2048:                                      PfTrabs N(8,2), IndProd N(8,2), ;
2049:                                      Varias N(1,0), Agregas N(1,0), Visivel L, ;
2050:                                      Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
2051:             INDEX ON Grupo + Conta + CMats TAG GrConMat
2052:             INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMatCS
2053:             SET ORDER TO GrConMat
2054:         ENDIF
2055: 
2056:         *-- Obter MatSec de crSigCdPac
2057:         loc_cMatSec = ""
2058:         IF USED("crSigCdPac") AND !EOF("crSigCdPac")
2059:             loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
2060:         ELSE
2061:             loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
2062:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac") > 0 AND !EOF("crSigCdPac")
2063:                 loc_cMatSec = ALLTRIM(NVL(crSigCdPac.MatSec, ""))
2064:             ENDIF
2065:         ENDIF
2066:         IF !USED("crSigCdPam")
2067:             loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
2068:             =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
2069:         ENDIF
2070: 
2071:         *-- Garantir TmpPro / crSigOpOpt / LocalOpp / crSigCdOpe carregados
2072:         IF !USED("TmpPro")
2073:             loc_cSql = "SELECT CPros, CUnis, Varias, Cgrus, MatPrincs, Custofs, MoeCusfs FROM SigCdPro"
2074:             IF SQLEXEC(gnConnHandle, loc_cSql, "TmpPro") > 0
2075:                 SELECT TmpPro
2076:                 INDEX ON CPros TAG CPros
2077:                 SET ORDER TO CPros
2078:             ENDIF
2079:         ENDIF
2080:         IF !USED("crSigOpOpt")
2081:             loc_cSql = "SELECT Cods, PFalhas, TFalhas, Trabas, Prodzs, IndProds FROM SigOpOpt"
2082:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigOpOpt") > 0
2083:                 SELECT crSigOpOpt
2084:                 INDEX ON Cods TAG Cods
2085:                 SET ORDER TO Cods
2086:             ENDIF
2087:         ENDIF
2088:         IF !USED("LocalOpp")
2089:             loc_cSql = "SELECT Dopps, Origems, Destinos, EstOrigs, EstDests FROM SigCdNop"
2090:             IF SQLEXEC(gnConnHandle, loc_cSql, "LocalOpp") > 0
2091:                 SELECT LocalOpp
2092:                 INDEX ON Dopps TAG Dopps
2093:                 SET ORDER TO Dopps
2094:             ENDIF
2095:         ENDIF
2096:         IF !USED("crSigCdOpe")
2097:             loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests, Opers FROM SigCdOpe"
2098:             IF SQLEXEC(gnConnHandle, loc_cSql, "crSigCdOpe") > 0
2099:                 SELECT crSigCdOpe
2100:                 INDEX ON Dopes TAG Dopes
2101:                 SET ORDER TO Dopes
2102:             ENDIF
2103:         ENDIF
2104: 
2105:         *-- Obter codigo do FCX corrente
2106:         loc_nCodigosFcx = 0
2107:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2108:             loc_nCodigosFcx = crSigCdFcx.Codigos
2109:         ENDIF
2110: 
2111:         *-- Seek grupo em TmpGccr
2112:         IF USED("TmpGccr")
2113:             =SEEK(loc_cGrupo, "TmpGccr", "BalCodigo")
2114:         ENDIF
2115: 
2116:         *-- Buscar data do ultimo balanco (crDtUBal)
2117:         loc_cQuery = "SELECT TOP 1 Datas FROM SigCdFcx " + ;
2118:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
2119:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
2120:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
2121:                      " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
2122:                      " ORDER BY Emps DESC, Grupos DESC, Contas DESC, Datas DESC"
2123: 
2124:         IF SQLEXEC(gnConnHandle, loc_cQuery, "crDtUBal") < 1
2125:             MsgErro("Falha na conex" + CHR(227) + "o (crDtUBal). Reinicializar o processo.", ;
2126:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2127:             RETURN .F.
2128:         ENDIF
2129:         GO TOP IN crDtUBal
2130: 
2131:         loc_nNdFechas = 0
2132:         IF USED("crSigCdPac") AND !EOF("crSigCdPac")
2133:             loc_nNdFechas = NVL(crSigCdPac.ndFechas, 0)
2134:         ENDIF
2135: 
2136:         IF EOF("crDtUBal")
2137:             loc_dDataUBal = CTOD("")
2138:         ELSE
2139:             loc_dDataUBal = TTOD(crDtUBal.Datas) + loc_nNdFechas

*-- Linhas 2149 a 2304:
2149: 
2150:         *-- Atualizar Datais no FCX com data do ultimo balanco
2151:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2152:             SELECT crSigCdFcx
2153:             REPLACE crSigCdFcx.Datais WITH loc_dDataUBal
2154:         ENDIF
2155: 
2156:         *-- Parametros de data para SQL parametrizado
2157:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2158:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2159: 
2160:         *-- Dados da empresa (EmpBals)
2161:         loc_cSql = "SELECT TOP 1 * FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpr)
2162:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalEmp")
2163:         LOCAL loc_cEmpBals
2164:         loc_cEmpBals = ""
2165:         IF USED("LocalEmp") AND !EOF("LocalEmp") AND PEMSTATUS(LocalEmp, "EmpBals", 5)
2166:             loc_cEmpBals = ALLTRIM(NVL(LocalEmp.EmpBals, ""))
2167:         ENDIF
2168: 
2169:         *==========================================================================
2170:         *-- MOVIMENTACOES DE PRODUCAO (LocalNens / LocalNensI)
2171:         *==========================================================================
2172:         loc_cQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, " + ;
2173:                      "Obss, cIdChaves, EmpDnPs, nLotes " + ;
2174:                      "FROM SigCdNec " + ;
2175:                      "WHERE ( Emps = " + EscaparSQL(loc_cEmpr) + ;
2176:                      IIF(!EMPTY(loc_cEmpBals), " OR Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2177:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2178:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2179:                      " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2180:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2181:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + ;
2182:                      " AND ProcBals = ?loc_llFalse))" + ;
2183:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
2184:                      " ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"
2185: 
2186:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNens") < 1
2187:             MsgErro("Falha na conex" + CHR(227) + "o (LocalNens). Reinicializar.", ;
2188:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2189:             RETURN .F.
2190:         ENDIF
2191: 
2192:         loc_cQuery = "SELECT b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, " + ;
2193:                      "b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
2194:                      "FROM SigCdNec a, SigCdNei b " + ;
2195:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2196:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2197:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2198:                      " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2199:                      " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2200:                      " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2201:                      " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2202:                      " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llFalse" + ;
2203:                      " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
2204: 
2205:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalNensI") < 1
2206:             MsgErro("Falha na conex" + CHR(227) + "o (LocalNensI). Reinicializar.", ;
2207:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2208:             RETURN .F.
2209:         ENDIF
2210:         SELECT LocalNensI
2211:         INDEX ON EmpDNPs TAG EmpDNPs
2212:         SET ORDER TO EmpDNPs
2213: 
2214:         *-- LocalServ (servicos por funcionario)
2215:         loc_cQuery = "SELECT b.EmpDNPs, a.dopps, a.numps, b.CMats, p.DPros, b.CUnis, b.Nenvs, " + ;
2216:                      "b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams, " + ;
2217:                      "b.fators, a.grupoos, a.contaos, " + ;
2218:                      "CASE WHEN a.retrabs = 0 THEN b.qtds * b.fators ELSE b.qtds * b.coefs END AS valors, a.datas " + ;
2219:                      "FROM SigCdNec a, SigCdNei b LEFT JOIN SigCdPro p ON b.CMats = p.CPros " + ;
2220:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2221:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2222:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2223:                      " AND ((a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2224:                      " AND a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2225:                      " AND a.ProcdBal = ?loc_llFalse) OR (a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2226:                      " AND a.ContaOs = " + EscaparSQL(loc_cConta) + ;
2227:                      " AND a.ProcBals = ?loc_llFalse))" + ;
2228:                      " AND a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_llTrue" + ;
2229:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;
2230:                      " ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops"
2231: 
2232:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalServ") < 1
2233:             MsgErro("Falha na conex" + CHR(227) + "o (LocalServ). Reinicializar.", ;
2234:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2235:             RETURN .F.
2236:         ENDIF
2237:         SELECT LocalServ
2238:         INDEX ON CMats + EmpDNPs TAG EmpDNPs
2239:         SET ORDER TO EmpDNPs
2240: 
2241:         *-- LocalMFas (fases de producao)
2242:         loc_cQuery = "SELECT b.EmpDNPs, b.Qtds, b.cIdChaves " + ;
2243:                      "FROM SigCdNec a, SigPdMvf b " + ;
2244:                      "WHERE ( a.Emps = " + EscaparSQL(loc_cEmpr) + ;
2245:                      IIF(!EMPTY(loc_cEmpBals), " OR a.Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2246:                      " AND a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2247:                      " AND (a.GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2248:                      " OR a.GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2249:                      " AND (a.ContaDs = " + EscaparSQL(loc_cConta) + ;
2250:                      " OR a.ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2251:                      " AND a.EmpDNPs = b.EmpDNPs" + ;
2252:                      " ORDER BY b.EmpDNPs, b.Qtds, b.cIdChaves"
2253: 
2254:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalMFas") < 1
2255:             MsgErro("Falha na conex" + CHR(227) + "o (LocalMFas). Reinicializar.", ;
2256:                     "FormFea - ProcessarBalan" + CHR(231) + "o")
2257:             RETURN .F.
2258:         ENDIF
2259:         SELECT LocalMFas
2260:         INDEX ON EmpDNPs TAG EmpDNPs
2261:         SET ORDER TO EmpDNPs
2262: 
2263:         *-- Grupos de produto (LocalGru / LocalGgrp)
2264:         loc_cSql = "SELECT Cgrus, GruEstPs, ConEstPs, nAgMts, TipoEstos, Mercs, MoeCusts FROM SigCdGrp"
2265:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalGru")
2266:         SELECT LocalGru
2267:         INDEX ON Cgrus TAG Cgrus
2268: 
2269:         loc_cSql = "SELECT Codigos, Aplicflhs FROM SigCdGpr"
2270:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalGgrp")
2271:         SELECT LocalGgrp
2272:         INDEX ON Codigos TAG Codigos
2273: 
2274:         *-- Inicializacao de flags
2275:         loc_nFalhaAdmitida = 0
2276:         loc_llTipoQ        = .F.
2277:         loc_llGrvPrz       = .F.
2278: 
2279:         *==========================================================================
2280:         *-- SCAN PRINCIPAL: Movimentacoes de Producao (LocalNens)
2281:         *==========================================================================
2282:         SELECT LocalNens
2283:         loc_loBarra = CREATEOBJECT("fwprogressbar", ;
2284:                       "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
2285:                       RECCOUNT("LocalNens"))
2286:         loc_loBarra.Show
2287: 
2288:         SCAN
2289:             loc_loBarra.Update(.T.)
2290: 
2291:             loc_cEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)
2292: 
2293:             =SEEK(LocalNens.Dopps, "LocalOpp", "Dopps")
2294: 
2295:             loc_lOrigem   = .F.
2296:             loc_lDestino  = .F.
2297:             loc_cMaterial = SPACE(14)
2298:             loc_cMatResFa = SPACE(14)
2299: 
2300:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2301:                LocalOpp.Origems = 1 AND LocalNens.GrupoOs = loc_cGrupo AND ;
2302:                LocalNens.ContaOs = loc_cConta AND INLIST(LocalOpp.EstOrigs, 1, 2)
2303:                 loc_lOrigem = .T.
2304:             ENDIF

*-- Linhas 2316 a 2361:
2316:             loc_llGrvPrz   = .F.
2317: 
2318:             *-- Scan interno: itens do movimento (LocalNensI)
2319:             SELECT LocalNensI
2320:             SEEK loc_cEdn
2321:             SCAN WHILE EmpDNPs = loc_cEdn
2322:                 *-- Determinar material baseado em UnifBals
2323:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4
2324:                     IF LocalNensI.Nops = 0
2325:                         loc_cMaterial = LocalNensI.CMats
2326:                     ELSE
2327:                         loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
2328:                         =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
2329:                         =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
2330:                         IF USED("crSigCdPam") AND !EOF("crSigCdPam")
2331:                             loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
2332:                         ELSE
2333:                             loc_cMaterial = TmpPro.MatPrincs
2334:                         ENDIF
2335:                     ENDIF
2336:                     IF LocalNensI.CMats <> loc_cMaterial
2337:                         IF LocalNensI.CMats <> loc_cMatSec
2338:                             LOOP
2339:                         ELSE
2340:                             loc_cMaterial = loc_cMatSec
2341:                         ENDIF
2342:                     ENDIF
2343:                 ELSE
2344:                     IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3
2345:                         loc_cSql = "SELECT Cpros FROM SigOpPic WHERE Nops = " + TRANSFORM(LocalNensI.Nops)
2346:                         =SQLEXEC(gnConnHandle, loc_cSql, "TmpOpi")
2347:                         IF LocalNensI.Nops = 0
2348:                             loc_cMaterial = LocalNensI.CMats
2349:                         ELSE
2350:                             =SEEK(TmpOpi.Cpros, "TmpPro", "CPros")
2351:                             IF USED("crSigCdPam") AND !EOF("crSigCdPam")
2352:                                 loc_cMaterial = IIF(EMPTY(TmpPro.MatPrincs), ALLTRIM(crSigCdPam.Ouros), TmpPro.MatPrincs)
2353:                             ELSE
2354:                                 loc_cMaterial = TmpPro.MatPrincs
2355:                             ENDIF
2356:                         ENDIF
2357:                     ELSE
2358:                         IF USED("TmpGccr") AND !EOF("TmpGccr") AND USED("crSigCdPam") AND !EOF("crSigCdPam")
2359:                             loc_cMaterial = IIF(TmpGccr.UnifBals = 1, ALLTRIM(crSigCdPam.Ouros), LocalNensI.CMats)
2360:                         ELSE
2361:                             loc_cMaterial = LocalNensI.CMats

*-- Linhas 2375 a 2707:
2375:                 IF loc_lOrigem
2376:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs, "TmpConta")
2377:                         =SEEK(LocalNens.ContaOs, "TmpCli", "BalCodigo")
2378:                         INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2379:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
2380:                                     IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2381:                     ENDIF
2382:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
2383:                         INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2384:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
2385:                                     TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2386:                     ENDIF
2387:                     SELECT TmpResumo
2388:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2389:                         REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
2390:                                 QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
2391:                                 PesoFabre WITH PesoFabre + LocalNensI.Peso2s
2392:                         THIS.IncluirHistorico("Nens", "O", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2393:                     ELSE
2394:                         REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
2395:                                 QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
2396:                                 PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
2397:                         THIS.IncluirHistorico("Nens", "O", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2398:                     ENDIF
2399:                     IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
2400:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2401:                             VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, LocalNensI.CMats, ;
2402:                                     LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2403:                     ENDIF
2404:                     SELECT TmpOpera
2405:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2406:                         REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
2407:                                 QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
2408:                     ELSE
2409:                         REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
2410:                                 QtdeSais WITH QtdeSais + LocalNensI.Qtds
2411:                     ENDIF
2412:                     =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
2413:                     IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
2414:                        USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
2415:                        crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
2416:                        crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
2417:                         loc_llTipoQ = .T.
2418:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2419:                             loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
2420:                             REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
2421:                             loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
2422:                         ENDIF
2423:                     ENDIF
2424:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2425:                         loc_cOperacao = "E"
2426:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2427:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2428:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Entrada " + LocalNens.GrupoDs)
2429:                         ENDIF
2430:                     ELSE
2431:                         loc_cOperacao = "S"
2432:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2433:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2434:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, "Saida   " + LocalNens.GrupoDs)
2435:                         ENDIF
2436:                     ENDIF
2437:                     REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
2438:                             Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
2439:                     IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND crSigOpOpt.Prodzs = 1
2440:                         SELECT TmpPrz
2441:                         IF !SEEK(SPACE(1) + DTOS(LocalNens.Datas) + LocalNensI.TpOps)
2442:                             APPEND BLANK
2443:                             REPLACE Datas WITH LocalNens.Datas, TpOps WITH LocalNensI.TpOps
2444:                         ENDIF
2445:                         REPLACE Pesos WITH Pesos + LocalNensI.Pesos
2446:                         loc_llGrvPrz = .T.
2447:                     ENDIF
2448:                 ENDIF
2449: 
2450:                 *-- DESTINO
2451:                 IF loc_lDestino
2452:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs, "TmpConta")
2453:                         =SEEK(LocalNens.ContaDs, "TmpCli", "BalCodigo")
2454:                         INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2455:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, ;
2456:                                     IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2457:                     ENDIF
2458:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + loc_cCodCor + loc_cCodTam, "TmpResumo")
2459:                         INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2460:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
2461:                                     TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2462:                     ENDIF
2463:                     SELECT TmpResumo
2464:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2465:                         REPLACE PesoEnts  WITH PesoEnts  + LocalNensI.Pesos, ;
2466:                                 QtdeEnts  WITH QtdeEnts  + LocalNensI.Qtds, ;
2467:                                 PesoFabre WITH PesoFabre + LocalNensI.Peso2s
2468:                         THIS.IncluirHistorico("Nens", "D", "E", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2469:                     ELSE
2470:                         REPLACE PesoSais  WITH PesoSais  + LocalNensI.Pesos, ;
2471:                                 QtdeSais  WITH QtdeSais  + LocalNensI.Qtds, ;
2472:                                 PesoFabrs WITH PesoFabrs + LocalNensI.Peso2s
2473:                         THIS.IncluirHistorico("Nens", "D", "S", LocalNensI.Qtds, LocalNensI.Pesos, LocalNensI.Peso2s)
2474:                     ENDIF
2475:                     IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + LocalNensI.TpOps, "TmpOpera")
2476:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2477:                             VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
2478:                                     LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2479:                     ENDIF
2480:                     SELECT TmpOpera
2481:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2482:                         REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, ;
2483:                                 QtdeEnts WITH QtdeEnts + LocalNensI.Qtds
2484:                     ELSE
2485:                         REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, ;
2486:                                 QtdeSais WITH QtdeSais + LocalNensI.Qtds
2487:                     ENDIF
2488:                     =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
2489:                     IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
2490:                        USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
2491:                        crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
2492:                        crSigOpOpt.TFalhas = "Q" AND crSigCdPam.GrTrans <> loc_cGrupo
2493:                         loc_llTipoQ = .T.
2494:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2495:                             loc_nFalha = IIF(crSigOpOpt.Pfalhas > LocalNensI.Qtds, LocalNensI.Qtds, crSigOpOpt.Pfalhas)
2496:                             REPLACE PFalha WITH loc_nFalha, Falha WITH TmpOpera.Falha + loc_nFalha IN TmpOpera
2497:                             loc_nFalhaAdmitida = loc_nFalhaAdmitida + loc_nFalha
2498:                         ENDIF
2499:                     ENDIF
2500:                     IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2501:                         loc_cOperacao = "E"
2502:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2503:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2504:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Entrada " + LocalNens.GrupoOs)
2505:                         ENDIF
2506:                     ELSE
2507:                         loc_cOperacao = "S"
2508:                         IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2509:                             INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2510:                                 VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, "Saida   " + LocalNens.GrupoOs)
2511:                         ENDIF
2512:                     ENDIF
2513:                     REPLACE Qtds  WITH TmpResFas.Qtds  + LocalNensI.Qtds, ;
2514:                             Pesos WITH TmpResFas.Pesos + LocalNensI.Pesos IN TmpResFas
2515:                 ENDIF
2516: 
2517:                 *-- UnifBals=3: material principal secundario
2518:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 3 AND ;
2519:                    LocalNensI.CMats <> loc_cMaterial AND ;
2520:                    USED("crSigCdFcx") AND !EOF("crSigCdFcx") AND ;
2521:                    LocalGru.GruEstPs <> crSigCdFcx.Grupos AND LocalGru.ConEstPs <> crSigCdFcx.Contas
2522:                     =SEEK(loc_cMaterial, "TmpPro", "CPros")
2523:                     =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
2524:                     =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
2525:                     IF loc_lOrigem
2526:                         IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial, "TmpResumo")
2527:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
2528:                                 VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
2529:                         ENDIF
2530:                         SELECT TmpResumo
2531:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2532:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2533:                         ELSE
2534:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2535:                         ENDIF
2536:                         IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
2537:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2538:                                 VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, loc_cMaterial, ;
2539:                                         LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2540:                         ENDIF
2541:                         SELECT TmpOpera
2542:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1
2543:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2544:                         ELSE
2545:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2546:                         ENDIF
2547:                     ENDIF
2548:                     IF loc_lDestino
2549:                         IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial, "TmpResumo")
2550:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel) ;
2551:                                 VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, TmpPro.CUnis, TmpPro.Varias, .T.)
2552:                         ENDIF
2553:                         SELECT TmpResumo
2554:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2555:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2556:                         ELSE
2557:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2558:                         ENDIF
2559:                         IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + loc_cMaterial + LocalNensI.TpOps, "TmpOpera")
2560:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2561:                                 VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, loc_cMaterial, ;
2562:                                         LocalNensI.TpOps, TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2563:                         ENDIF
2564:                         SELECT TmpOpera
2565:                         IF USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1
2566:                             REPLACE PesoEnts WITH PesoEnts + LocalNensI.Pesos, QtdeEnts WITH QtdeEnts + LocalNensI.Pesos
2567:                         ELSE
2568:                             REPLACE PesoSais WITH PesoSais + LocalNensI.Pesos, QtdeSais WITH QtdeSais + LocalNensI.Pesos
2569:                         ENDIF
2570:                     ENDIF
2571:                 ENDIF
2572: 
2573:             ENDSCAN
2574: 
2575:             *-- TmpResFas pos-scan-interno
2576:             IF loc_lDestino AND !EMPTY(ALLTRIM(loc_cMatResFa))
2577:                 loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstDests = 1, "E", "S")
2578:                 IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoOs, "TmpResFas", "Fases")
2579:                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2580:                         VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoOs, ;
2581:                                 IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoOs)
2582:                 ENDIF
2583:             ENDIF
2584:             IF loc_lOrigem AND !EMPTY(ALLTRIM(loc_cMatResFa))
2585:                 loc_cOperacao = IIF(USED("LocalOpp") AND !EOF("LocalOpp") AND LocalOpp.EstOrigs = 1, "E", "S")
2586:                 IF !SEEK(loc_cMatResFa + loc_cOperacao + LocalNens.GrupoDs, "TmpResFas", "Fases")
2587:                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2588:                         VALUES (loc_cMatResFa, loc_cOperacao, LocalNens.GrupoDs, ;
2589:                                 IIF(loc_cOperacao = "S", "Saida   ", "Entrada ") + LocalNens.GrupoDs)
2590:                 ENDIF
2591:             ENDIF
2592: 
2593:             *-- LocalMFas para este movimento
2594:             SELECT LocalMFas
2595:             SEEK loc_cEdn
2596:             SCAN WHILE EmpDNPs = loc_cEdn
2597:                 REPLACE QtdPcs WITH QtdPcs + LocalMfas.Qtds IN TmpResFas
2598:                 IF loc_llGrvPrz
2599:                     REPLACE Qtds WITH Qtds + LocalMfas.Qtds IN TmpPrz
2600:                 ENDIF
2601:             ENDSCAN
2602: 
2603:             *-- Marcar NEC como processada no balanco (se Fechamento)
2604:             IF THIS.this_lFechamento
2605:                 IF loc_lOrigem
2606:                     loc_cUpdate = "UPDATE SigCdNec SET ProcBals = ?loc_llTrue, NumBals = " + ;
2607:                                   TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
2608:                     IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
2609:                         MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Orig). Reinicializar.", "FormFea")
2610:                         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2611:                         RETURN .F.
2612:                     ENDIF
2613:                 ENDIF
2614:                 IF loc_lDestino
2615:                     loc_cUpdate = "UPDATE SigCdNec SET ProcDBal = ?loc_llTrue, NumBalds = " + ;
2616:                                   TRANSFORM(loc_nCodigosFcx) + " WHERE CidChaves = '" + ALLTRIM(LocalNens.CidChaves) + "'"
2617:                     IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
2618:                         MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdNec Dest). Reinicializar.", "FormFea")
2619:                         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2620:                         RETURN .F.
2621:                     ENDIF
2622:                 ENDIF
2623:             ENDIF
2624: 
2625:         ENDSCAN
2626:         loc_loBarra.Complete
2627: 
2628:         *==========================================================================
2629:         *-- MOVIMENTACOES DE ESTOQUE (LocalEest / LocalEestI / LocalEsti2)
2630:         *==========================================================================
2631:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2632:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2633: 
2634:         loc_cQuery = "SELECT Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves " + ;
2635:                      "FROM SigMvCab " + ;
2636:                      "WHERE (Emps = " + EscaparSQL(loc_cEmpr) + " OR Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2637:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2638:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2639:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2640:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + " AND ProcBals = ?loc_llFalse))" + ;
2641:                      IIF(loc_nLote > 0, " AND 0=1", "") + ;
2642:                      " ORDER BY Datas"
2643: 
2644:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEest") < 1
2645:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEest). Reinicializar.", "FormFea")
2646:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2647:             RETURN .F.
2648:         ENDIF
2649: 
2650:         loc_cQuery = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
2651:                      "FROM SigMvCab a, SigMvItn b " + ;
2652:                      "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2653:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2654:                      " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2655:                      " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2656:                      " AND a.EmpDopNums = b.EmpDopNums" + ;
2657:                      " ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds"
2658: 
2659:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEestI") < 1
2660:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEestI). Reinicializar.", "FormFea")
2661:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2662:             RETURN .F.
2663:         ENDIF
2664:         SELECT LocalEestI
2665:         INDEX ON EmpDopNums TAG EmpDopNums
2666:         SET ORDER TO EmpDopNums
2667: 
2668:         loc_cQuery = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, b.CodCors, b.CodTams, b.Citens " + ;
2669:                      "FROM SigMvCab a, SigMvIts b " + ;
2670:                      "WHERE (a.Emps = " + EscaparSQL(loc_cEmpr) + " OR a.Empds = " + EscaparSQL(loc_cEmpr) + ")" + ;
2671:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2672:                      " AND (GrupoDs = " + EscaparSQL(loc_cGrupo) + " OR GrupoOs = " + EscaparSQL(loc_cGrupo) + ")" + ;
2673:                      " AND (ContaDs = " + EscaparSQL(loc_cConta) + " OR ContaOs = " + EscaparSQL(loc_cConta) + ")" + ;
2674:                      " AND a.EmpDopNums = b.EmpDopNums" + ;
2675:                      " ORDER BY b.EmpDopNums, b.CPros, b.codcors, b.codtams, b.citens"
2676: 
2677:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalEsti2") < 1
2678:             MsgErro("Falha na conex" + CHR(227) + "o (LocalEsti2). Reinicializar.", "FormFea")
2679:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
2680:             RETURN .F.
2681:         ENDIF
2682:         SELECT LocalEsti2
2683:         INDEX ON EmpDopNums + Cpros + STR(Citens, 4) TAG EmpDopNums
2684:         SET ORDER TO EmpDopNums
2685: 
2686:         *-- SCAN: Movimentacoes de Estoque
2687:         SELECT LocalEest
2688:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
2689:         loc_loBarra.Show
2690: 
2691:         SCAN
2692:             loc_loBarra.Update(.T.)
2693:             loc_cEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)
2694: 
2695:             =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")
2696: 
2697:             loc_lOrigem   = .F.
2698:             loc_lDestino  = .F.
2699:             loc_lOrigemF  = .F.
2700:             loc_lDestinoF = .F.
2701: 
2702:             IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
2703:                 IF crSigCdOpe.Estoqs = 1 AND (crSigCdOpe.EstOrigs = 4 OR crSigCdOpe.Opers = 3) AND LocalEest.Emps = loc_cEmpr
2704:                     IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2705:                         loc_lOrigem = .T.
2706:                     ELSE
2707:                         IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta

*-- Linhas 2728 a 2746:
2728:                 LOOP
2729:             ENDIF
2730: 
2731:             SELECT LocalEestI
2732:             SEEK loc_cEdn
2733:             SCAN WHILE EmpDopNums = loc_cEdn
2734:                 =SEEK(LocalEestI.Cpros, "TmpPro", "CPros")
2735:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
2736:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
2737: 
2738:                 loc_cGrupoD   = SPACE(10)
2739:                 loc_cContaD   = SPACE(10)
2740:                 loc_cOperacao = " "
2741: 
2742:                 IF USED("crSigCdOpe") AND !EOF("crSigCdOpe") AND crSigCdOpe.EstOrigs = 4
2743:                     loc_lOrigem  = .F.
2744:                     loc_lDestino = .F.
2745:                     IF LocalEestI.Opers = "S" AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2746:                         loc_lOrigem   = .T.

*-- Linhas 2857 a 3342:
2857:                 ENDIF
2858: 
2859:                 *-- Scan LocalEsti2
2860:                 SELECT LocalEsti2
2861:                 SET ORDER TO EmpDopNums
2862:                 IF SEEK(LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4))
2863:                     SCAN WHILE EmpDopNums + Cpros + STR(Citens, 4) = ;
2864:                                LocalEestI.EmpDopNums + LocalEestI.Cpros + STR(LocalEestI.Citens, 4)
2865:                         loc_nQtde = LocalEsti2.Qtds
2866:                         loc_nPeso = LocalEsti2.Pesos
2867:                         loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(LocalEsti2.CodCors), " "), 4)
2868:                         loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(LocalEsti2.CodTams), " "), 4)
2869:                         IF loc_lOrigem
2870:                             IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2871:                                 =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
2872:                                 INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2873:                                     VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2874:                             ENDIF
2875:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
2876:                                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2877:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, ;
2878:                                             LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2879:                             ENDIF
2880:                             SELECT TmpResumo
2881:                             IF loc_cOperacao = "E"
2882:                                 REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
2883:                                         PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2884:                                         PesoFabre WITH PesoFabre + loc_nQtde
2885:                                 THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2886:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2887:                             ELSE
2888:                                 REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
2889:                                         PesoSais  WITH PesoSais  + loc_nQtde, ;
2890:                                         PesoFabrs WITH PesoFabrs + loc_nQtde
2891:                                 THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2892:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2893:                             ENDIF
2894:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
2895:                                 INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2896:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
2897:                                             TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2898:                             ENDIF
2899:                             SELECT TmpOpera
2900:                             IF loc_cOperacao = "E"
2901:                                 REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
2902:                             ELSE
2903:                                 REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
2904:                             ENDIF
2905:                             IF loc_cOperacao = "E"
2906:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2907:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2908:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
2909:                                 ENDIF
2910:                             ELSE
2911:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2912:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2913:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
2914:                                 ENDIF
2915:                             ENDIF
2916:                             REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
2917:                                     Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
2918:                         ENDIF
2919:                         IF loc_lDestino
2920:                             IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2921:                                 =SEEK(loc_cConta, "TmpCli", "BalCodigo")
2922:                                 INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2923:                                     VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2924:                             ENDIF
2925:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEsti2.CPros + loc_cCodCor + loc_cCodTam, "TmpResumo")
2926:                                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
2927:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, ;
2928:                                             LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
2929:                             ENDIF
2930:                             SELECT TmpResumo
2931:                             IF loc_cOperacao = "E"
2932:                                 REPLACE QtdeEnts  WITH QtdeEnts  + LocalEsti2.Qtds, ;
2933:                                         PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2934:                                         PesoFabre WITH PesoFabre + loc_nQtde
2935:                                 THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2936:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2937:                             ELSE
2938:                                 REPLACE QtdeSais  WITH QtdeSais  + LocalEsti2.Qtds, ;
2939:                                         PesoSais  WITH PesoSais  + loc_nQtde, ;
2940:                                         PesoFabrs WITH PesoFabrs + loc_nQtde
2941:                                 THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2942:                                                       loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2943:                             ENDIF
2944:                             IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
2945:                                 INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
2946:                                     VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
2947:                                             TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
2948:                             ENDIF
2949:                             SELECT TmpOpera
2950:                             IF loc_cOperacao = "E"
2951:                                 REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
2952:                             ELSE
2953:                                 REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
2954:                             ENDIF
2955:                             IF loc_cOperacao = "E"
2956:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2957:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2958:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
2959:                                 ENDIF
2960:                             ELSE
2961:                                 IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
2962:                                     INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
2963:                                         VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
2964:                                 ENDIF
2965:                             ENDIF
2966:                             REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
2967:                                     Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
2968:                         ENDIF
2969:                     ENDSCAN
2970:                 ELSE
2971:                     *-- Sem LocalEsti2: usar LocalEestI diretamente
2972:                     loc_nQtde = LocalEestI.Qtds
2973:                     loc_nPeso = LocalEestI.Pesos
2974:                     IF loc_lOrigem
2975:                         IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
2976:                             =SEEK(LocalEest.ContaOs, "TmpCli", "BalCodigo")
2977:                             INSERT INTO TmpConta (Grupo, Conta, Nome) ;
2978:                                 VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
2979:                         ENDIF
2980:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
2981:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
2982:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
2983:                         ENDIF
2984:                         SELECT TmpResumo
2985:                         IF loc_cOperacao = "E"
2986:                             REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
2987:                                     PesoEnts  WITH PesoEnts  + loc_nQtde, ;
2988:                                     PesoFabre WITH PesoFabre + loc_nQtde
2989:                             THIS.IncluirHistorico("Eest", "O", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
2990:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2991:                         ELSE
2992:                             REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
2993:                                     PesoSais  WITH PesoSais  + loc_nQtde, ;
2994:                                     PesoFabrs WITH PesoFabrs + loc_nQtde
2995:                             THIS.IncluirHistorico("Eest", "O", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
2996:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
2997:                         ENDIF
2998:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
2999:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
3000:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), LocalGgrp.AplicFlhs)
3001:                         ENDIF
3002:                         SELECT TmpOpera
3003:                         IF loc_cOperacao = "E"
3004:                             REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
3005:                         ELSE
3006:                             REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
3007:                         ENDIF
3008:                         IF loc_cOperacao = "E"
3009:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3010:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3011:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
3012:                             ENDIF
3013:                         ELSE
3014:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3015:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3016:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
3017:                             ENDIF
3018:                         ENDIF
3019:                         REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
3020:                                 Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
3021:                     ENDIF
3022:                     IF loc_lDestino
3023:                         IF !SEEK(loc_cGrupo + loc_cConta, "TmpConta")
3024:                             =SEEK(loc_cConta, "TmpCli", "BalCodigo")
3025:                             INSERT INTO TmpConta (Grupo, Conta, Nome) ;
3026:                                 VALUES (loc_cGrupo, loc_cConta, IIF(USED("TmpCli") AND !EOF("TmpCli"), TmpCli.RClis, ""))
3027:                         ENDIF
3028:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros, "TmpResumo")
3029:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3030:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3031:                         ENDIF
3032:                         SELECT TmpResumo
3033:                         IF loc_cOperacao = "E"
3034:                             REPLACE QtdeEnts  WITH QtdeEnts  + LocalEestI.Qtds, ;
3035:                                     PesoEnts  WITH PesoEnts  + loc_nQtde, ;
3036:                                     PesoFabre WITH PesoFabre + loc_nQtde
3037:                             THIS.IncluirHistorico("Eest", "D", "E", loc_nQtde, loc_nQtde, loc_nQtde, ;
3038:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
3039:                         ELSE
3040:                             REPLACE QtdeSais  WITH QtdeSais  + LocalEestI.Qtds, ;
3041:                                     PesoSais  WITH PesoSais  + loc_nQtde, ;
3042:                                     PesoFabrs WITH PesoFabrs + loc_nQtde
3043:                             THIS.IncluirHistorico("Eest", "D", "S", loc_nQtde, loc_nQtde, loc_nQtde, ;
3044:                                                   loc_cGrupo, loc_cConta, loc_cGrupoD, loc_cContaD)
3045:                         ENDIF
3046:                         IF !SEEK(loc_cGrupo + loc_cConta + LocalEestI.CPros + SPACE(15), "TmpOpera")
3047:                             INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3048:                                 VALUES (loc_cGrupo, loc_cConta, LocalEestI.CPros, SPACE(15), ;
3049:                                         TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3050:                         ENDIF
3051:                         SELECT TmpOpera
3052:                         IF loc_cOperacao = "E"
3053:                             REPLACE QtdeEnts WITH QtdeEnts + loc_nQtde, PesoEnts WITH PesoEnts + loc_nQtde
3054:                         ELSE
3055:                             REPLACE QtdeSais WITH QtdeSais + loc_nQtde, PesoSais WITH PesoSais + loc_nQtde
3056:                         ENDIF
3057:                         IF loc_cOperacao = "E"
3058:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3059:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3060:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Entrada " + loc_cGrupoD)
3061:                             ENDIF
3062:                         ELSE
3063:                             IF !SEEK(loc_cMatResFa + loc_cOperacao + loc_cGrupoD, "TmpResFas", "Fases")
3064:                                 INSERT INTO TmpResFas (Cmats, Opers, Fases, OpFase) ;
3065:                                     VALUES (loc_cMatResFa, loc_cOperacao, loc_cGrupoD, "Saida   " + loc_cGrupoD)
3066:                             ENDIF
3067:                         ENDIF
3068:                         REPLACE Qtds  WITH TmpResFas.Qtds  + loc_nQtde, ;
3069:                                 Pesos WITH TmpResFas.Pesos + loc_nQtde IN TmpResFas
3070:                     ENDIF
3071:                 ENDIF
3072: 
3073:                 loc_lOrigemF  = IIF(!loc_lOrigemF,  loc_lOrigem,  loc_lOrigemF)
3074:                 loc_lDestinoF = IIF(!loc_lDestinoF, loc_lDestino, loc_lDestinoF)
3075:             ENDSCAN
3076: 
3077:             *-- Marcar SigMvCab como processada
3078:             IF THIS.this_lFechamento AND (loc_lOrigemF OR loc_lDestinoF)
3079:                 loc_cUpdate = "UPDATE SigMvCab SET " + ;
3080:                               IIF(loc_lOrigemF, "ProcBals = ?loc_llTrue, NumBals = " + TRANSFORM(loc_nCodigosFcx) + " ", "") + ;
3081:                               IIF(loc_lDestinoF, IIF(loc_lOrigemF, ",", "") + ;
3082:                               "ProcDBal = ?loc_llTrue, NumBalds = " + TRANSFORM(loc_nCodigosFcx) + " ", " ") + ;
3083:                               "WHERE CidChaves = '" + ALLTRIM(LocalEest.CidChaves) + "'"
3084:                 IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
3085:                     MsgErro("Falha na conex" + CHR(227) + "o (Update SigMvCab). Reinicializar.", "FormFea")
3086:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3087:                     RETURN .F.
3088:                 ENDIF
3089:             ENDIF
3090: 
3091:         ENDSCAN
3092:         loc_loBarra.Complete()
3093: 
3094:         *==========================================================================
3095:         *-- SALDOS DE ESTOQUE (CrSalEst / SigMvEst)
3096:         *==========================================================================
3097:         LOCAL loc_cGrupoFcx, loc_cContaFcx
3098:         loc_cGrupoFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Grupos, loc_cGrupo)
3099:         loc_cContaFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Contas, loc_cConta)
3100:         loc_cEGE = loc_cEmpr + PADR(loc_cGrupoFcx, 10) + PADR(loc_cContaFcx, 10)
3101: 
3102:         loc_cSql = "SELECT * FROM SigMvEst WHERE EmpGruEsts = " + EscaparSQL(loc_cEGE)
3103:         IF SQLEXEC(gnConnHandle, loc_cSql, "CrSalEst") < 1
3104:             MsgErro("Falha na conex" + CHR(227) + "o (CrSalEst). Reinicializar.", "FormFea")
3105:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3106:             RETURN .F.
3107:         ENDIF
3108: 
3109:         SELECT CrSalEst
3110:         SCAN
3111:             =SEEK(CrSalEst.Cpros, "TmpPro", "CPros")
3112:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3113:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3114:             loc_cCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), ALLTRIM(CrSalEst.CodCors), " "), 4)
3115:             loc_cCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), ALLTRIM(CrSalEst.CodTams), " "), 4)
3116:             IF !SEEK(loc_cGrupoFcx + loc_cContaFcx + CrSalEst.Cpros + loc_cCodCor + loc_cCodTam, "TmpResumo")
3117:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
3118:                     VALUES (loc_cGrupoFcx, loc_cContaFcx, CrSalEst.Cpros, TmpPro.CUnis, ;
3119:                             TmpPro.Varias, LocalGru.nAgMts, .T., loc_cCodCor, loc_cCodTam)
3120:             ENDIF
3121:         ENDSCAN
3122: 
3123:         *==========================================================================
3124:         *-- PESAGENS (LocalPesa / LocalPesaI / SigCdPsc / SigCdPsi)
3125:         *==========================================================================
3126:         loc_pDtI = fDtoSQL(loc_dDataUBal)
3127:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
3128: 
3129:         loc_cQuery = "SELECT Emps, Codigos, CidChaves FROM SigCdPsc " + ;
3130:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3131:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
3132:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
3133:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND ProcBals = ?loc_llFalse" + ;
3134:                      " ORDER BY Emps, Codigos"
3135: 
3136:         IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesa") < 1
3137:             MsgErro("Falha na conex" + CHR(227) + "o (LocalPesa). Reinicializar.", "FormFea")
3138:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3139:             RETURN .F.
3140:         ENDIF
3141: 
3142:         SELECT LocalPesa
3143:         SCAN
3144:             loc_cQuery = "SELECT CPros, Qtds, Pesos FROM SigCdPsi " + ;
3145:                          "WHERE Emps = " + EscaparSQL(ALLTRIM(LocalPesa.Emps)) + ;
3146:                          " AND Codigos = " + TRANSFORM(LocalPesa.Codigos) + ;
3147:                          " ORDER BY CPros"
3148:             IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalPesaI") < 1
3149:                 MsgErro("Falha na conex" + CHR(227) + "o (LocalPesaI). Reinicializar.", "FormFea")
3150:                 SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3151:                 RETURN .F.
3152:             ENDIF
3153:             SELECT LocalPesaI
3154:             SCAN
3155:                 =SEEK(LocalPesaI.CPros, "TmpPro", "CPros")
3156:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3157:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3158:                 IF !SEEK(loc_cGrupo + loc_cConta + LocalPesaI.CPros, "TmpResumo")
3159:                     INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3160:                         VALUES (loc_cGrupo, loc_cConta, LocalPesaI.CPros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3161:                 ENDIF
3162:                 SELECT TmpResumo
3163:                 REPLACE Pesagem  WITH TmpResumo.Pesagem  + LocalPesaI.Qtds  IN TmpResumo
3164:                 REPLACE Pesagem3 WITH TmpResumo.Pesagem3 + LocalPesaI.Pesos IN TmpResumo
3165:             ENDSCAN
3166: 
3167:             *-- UnifBals=1: agregar pesagem no ouro
3168:             IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
3169:                USED("crSigCdPam") AND !EOF("crSigCdPam")
3170:                 loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
3171:                 IF !EMPTY(loc_cMatOuro)
3172:                     SELECT TmpResumo
3173:                     SET ORDER TO
3174:                     LOCATE FOR CMats = loc_cMatOuro
3175:                     IF EOF()
3176:                         APPEND BLANK
3177:                         REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
3178:                     ENDIF
3179:                     SELECT [  ] AS Agregar, SUM(Pesagem) AS Pesagem FROM TmpResumo ;
3180:                         WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND Pesagem <> 0 ;
3181:                         INTO CURSOR csTotal GROUP BY 1
3182:                     GO TOP IN csTotal
3183:                     REPLACE Pesagem  WITH Pesagem  + csTotal.Pesagem, ;
3184:                             Pesagem2 WITH Pesagem2 + csTotal.Pesagem IN TmpResumo
3185:                 ENDIF
3186:             ENDIF
3187: 
3188:             SELECT TmpResumo
3189:             SET ORDER TO GrConMat
3190: 
3191:             IF THIS.this_lFechamento
3192:                 loc_cUpdate = "UPDATE SigCdPsc SET ProcBals = ?loc_llTrue, NumBals = " + ;
3193:                               TRANSFORM(loc_nCodigosFcx) + ;
3194:                               " WHERE cidchaves = '" + ALLTRIM(LocalPesa.cidchaves) + "'"
3195:                 IF SQLEXEC(gnConnHandle, loc_cUpdate, "") < 1
3196:                     MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPsc). Reinicializar.", "FormFea")
3197:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3198:                     RETURN .F.
3199:                 ENDIF
3200:             ENDIF
3201:         ENDSCAN
3202: 
3203:         *==========================================================================
3204:         *-- CALCULOS FINAIS: saldos, falhas, produtividade
3205:         *==========================================================================
3206:         SELECT TmpResumo
3207:         REPLACE ALL Flag3 WITH .T.
3208: 
3209:         SELECT TmpOpera
3210:         REPLACE ALL PesoBEnts WITH PesoEnts, PesoBSais WITH PesoSais, ;
3211:                     QtdeBEnts WITH QtdeEnts, QtdeBSais WITH QtdeSais IN TmpOpera
3212: 
3213:         *-- UnifBals=1: unificar como ouro
3214:         IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 1 AND ;
3215:            USED("crSigCdPam") AND !EOF("crSigCdPam")
3216:             loc_cMatOuro = ALLTRIM(crSigCdPam.Ouros)
3217:             IF !EMPTY(loc_cMatOuro)
3218:                 SELECT TmpResumo
3219:                 SET ORDER TO
3220:                 LOCATE FOR CMats = loc_cMatOuro
3221:                 IF EOF()
3222:                     APPEND BLANK
3223:                     REPLACE CMats WITH loc_cMatOuro, Visivel WITH .T.
3224:                 ENDIF
3225:                 SELECT [  ] AS Agregar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3226:                     FROM TmpResumo WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
3227:                     INTO CURSOR csTotal GROUP BY 1
3228:                 GO TOP IN csTotal
3229:                 SELECT TmpResumo
3230:                 SCAN
3231:                     IF CMats = loc_cMatOuro
3232:                         REPLACE PesoEnts WITH PesoEnts + csTotal.pEnts, PesoSais WITH PesoSais + csTotal.pSais, ;
3233:                                 QtdeEnts WITH QtdeEnts + csTotal.pEnts, QtdeSais WITH QtdeSais + csTotal.pSais
3234:                     ELSE
3235:                         IF Agregas <> 1
3236:                             REPLACE Visivel WITH .F., Flag3 WITH .F.
3237:                         ENDIF
3238:                     ENDIF
3239:                 ENDSCAN
3240:                 =SEEK(loc_cMatOuro, "TmpPro", "CPros")
3241:                 =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3242:                 =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3243:                 SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3244:                     FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 ;
3245:                     GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
3246:                 SELECT csTotal
3247:                 SCAN
3248:                     IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
3249:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3250:                             VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
3251:                                     TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3252:                     ENDIF
3253:                     REPLACE TmpOpera.PesoEnts WITH TmpOpera.PesoEnts + csTotal.pEnts IN TmpOpera
3254:                     REPLACE TmpOpera.PesoSais WITH TmpOpera.PesoSais + csTotal.pSais IN TmpOpera
3255:                     REPLACE TmpOpera.QtdeEnts WITH TmpOpera.QtdeEnts + csTotal.pEnts IN TmpOpera
3256:                     REPLACE TmpOpera.QtdeSais WITH TmpOpera.QtdeSais + csTotal.pSais IN TmpOpera
3257:                 ENDSCAN
3258:                 SELECT Grupo, Conta, TpOps, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
3259:                     FROM TmpOpera WHERE CMats <> loc_cMatOuro AND Varias <> 1 AND Agregas <> 1 AND AplicFlhs <> 2 ;
3260:                     GROUP BY Grupo, Conta, TpOps INTO CURSOR csTotal
3261:                 SELECT csTotal
3262:                 SCAN
3263:                     IF !SEEK(csTotal.Grupo + csTotal.Conta + loc_cMatOuro + csTotal.TpOps, "TmpOpera")
3264:                         INSERT INTO TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
3265:                             VALUES (csTotal.Grupo, csTotal.Conta, loc_cMatOuro, csTotal.TpOps, ;
3266:                                     TmpPro.Varias, LocalGru.nAgMts, LocalGgrp.AplicFlhs)
3267:                     ENDIF
3268:                     REPLACE TmpOpera.PesoBEnts WITH TmpOpera.PesoBEnts + csTotal.pEnts IN TmpOpera
3269:                     REPLACE TmpOpera.PesoBSais WITH TmpOpera.PesoBSais + csTotal.pSais IN TmpOpera
3270:                     REPLACE TmpOpera.QtdeBEnts WITH TmpOpera.QtdeBEnts + csTotal.pEnts IN TmpOpera
3271:                     REPLACE TmpOpera.QtdeBSais WITH TmpOpera.QtdeBSais + csTotal.pSais IN TmpOpera
3272:                 ENDSCAN
3273:             ENDIF
3274:         ENDIF
3275: 
3276:         *-- Saldo anterior (CrUltBal -> CrSaldoI)
3277:         loc_cQuery = "SELECT Codigos FROM SigCdFcx " + ;
3278:                      "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3279:                      " AND Grupos = " + EscaparSQL(loc_cGrupo) + ;
3280:                      " AND Contas = " + EscaparSQL(loc_cConta) + ;
3281:                      " AND NOT Codigos = " + TRANSFORM(loc_nCodigosFcx) + ;
3282:                      " ORDER BY Codigos"
3283:         IF SQLEXEC(gnConnHandle, loc_cQuery, "CrUltBal") < 1
3284:             MsgErro("Falha na conex" + CHR(227) + "o (CrUltBal). Reinicializar.", "FormFea")
3285:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3286:             RETURN .F.
3287:         ENDIF
3288:         SELECT CrUltBal
3289:         GO BOTTOM
3290:         IF RECCOUNT() > 0
3291:             loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + TRANSFORM(CrUltBal.Codigos) + ;
3292:                        " AND Emps = " + EscaparSQL(loc_cEmpr) + " ORDER BY Codigos, cpros"
3293:         ELSE
3294:             loc_cSql = "SELECT * FROM SigOpCfe WHERE 0 = 1"
3295:         ENDIF
3296:         IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoI") < 1
3297:             MsgErro("Falha na conex" + CHR(227) + "o (CrSaldoI). Reinicializar.", "FormFea")
3298:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
3299:             RETURN .F.
3300:         ENDIF
3301:         SELECT CrSaldoI
3302:         INDEX ON Cpros TAG Cpros
3303: 
3304:         loc_nTrabalhado = 0
3305:         loc_nTrabalhadB = 0
3306: 
3307:         *-- Calcular saldos finais para cada material em TmpResumo
3308:         SELECT TmpResumo
3309:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("TmpResumo"))
3310:         loc_loBarra.Show
3311:         loc_cMatPrev = SPACE(14)
3312: 
3313:         SCAN
3314:             loc_loBarra.Update(.T.)
3315:             STORE 0 TO loc_nSaldoi, loc_nPesagem
3316: 
3317:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3318:             IF !loc_llTipoQ AND TmpResumo.CMats <> loc_cMatPrev
3319:                 loc_nFalhaAdmitida = 0
3320:                 loc_cMatPrev = TmpResumo.CMats
3321:             ENDIF
3322: 
3323:             SELECT CrSaldoI
3324:             =SEEK(TmpResumo.CMats)
3325:             loc_nSaldoi = IIF(EOF("CrSaldoI"), 0, CrSaldoI.Pesagems)
3326: 
3327:             SELECT TmpOpera
3328:             =SEEK(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
3329:             loc_nTrabalhado = 0
3330:             loc_nTrabalhadB = 0
3331:             SCAN WHILE CMats = TmpResumo.CMats
3332:                 =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
3333:                 IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
3334:                    USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3335:                    crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
3336:                    crSigOpOpt.TFalhas <> "Q" AND TmpOpera.AplicFlhs <> 2 AND ;
3337:                    crSigCdPam.GrTrans <> loc_cGrupo
3338:                     loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3)
3339:                     REPLACE PFalha WITH crSigOpOpt.PFalhas, ;
3340:                             Falha  WITH ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3) IN TmpOpera
3341:                 ENDIF
3342:                 IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;

*-- Linhas 3349 a 3525:
3349:                 loc_nTrabalhado = loc_nTrabalhadB
3350:             ENDIF
3351: 
3352:             SELECT TmpResumo
3353:             REPLACE Saldoi  WITH loc_nSaldoi, ;
3354:                     FReal   WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem, ;
3355:                     FAdmin  WITH loc_nFalhaAdmitida, ;
3356:                     Saldof  WITH loc_nSaldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - TmpResumo.Pesagem - loc_nFalhaAdmitida, ;
3357:                     PfTrabs WITH IIF(loc_nTrabalhado <> 0, (Saldof / loc_nTrabalhado * 100), 0)
3358: 
3359:             =SEEK(loc_cConta, "TmpCli", "BalCodigo")
3360:             IF TmpResumo.Saldof <> 0 AND USED("TmpCli") AND !EOF("TmpCli") AND ;
3361:                (TmpCli.PagFals = 1 OR TmpCli.RecFals = 1)
3362:                 REPLACE Flag WITH .T., Flag2 WITH .T. IN TmpResumo
3363:                 IF THIS.this_lFechamento
3364:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
3365:                         loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.Visible = .T.
3366:                     ENDIF
3367:                 ENDIF
3368:             ENDIF
3369:         ENDSCAN
3370: 
3371:         *-- Processar registros do saldo anterior que nao estao em TmpResumo
3372:         SELECT CrSaldoI
3373:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("CrSaldoI"))
3374:         loc_loBarra.Show
3375:         SCAN
3376:             loc_loBarra.Update(.T.)
3377:             IF CrSaldoI.Pesagems = 0
3378:                 LOOP
3379:             ENDIF
3380:             =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
3381:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3382:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3383:             loc_nSaldoi = CrSaldoI.Pesagems
3384:             SELECT TmpResumo
3385:             LOCATE FOR CMats = CrSaldoI.Cpros
3386:             IF EOF()
3387:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3388:                     VALUES (loc_cGrupo, loc_cConta, CrSaldoI.Cpros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3389:                 SELECT TmpResumo
3390:                 REPLACE Saldoi WITH loc_nSaldoi, FReal WITH loc_nSaldoi, ;
3391:                         FAdmin WITH 0, Saldof WITH loc_nSaldoi, PfTrabs WITH 0
3392:             ENDIF
3393:         ENDSCAN
3394: 
3395:         *-- Construir tabela de cotacoes (TmpCot)
3396:         SELECT TmpResumo
3397:         SCAN
3398:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3399:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3400: 
3401:             loc_nCusto = 0
3402:             loc_cMoeda = ""
3403: 
3404:             IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND crSigCdPam.AcertBals = 1
3405:                 loc_nCusto = TmpPro.Custofs
3406:                 loc_cMoeda = ALLTRIM(TmpPro.MoeCusfs)
3407:             ELSE
3408:                 LOCAL loc_pDtHist1, loc_pDtHist2
3409:                 loc_pDtHist1 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData))
3410:                 loc_pDtHist2 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), "23:59:59")
3411:                 loc_cQuery = "SELECT TOP 1 cIdChaves, UnitMeds FROM SigMvHst " + ;
3412:                              "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3413:                              " AND Cpros = " + EscaparSQL(ALLTRIM(TmpResumo.CMats)) + ;
3414:                              " AND Datas BETWEEN ?loc_pDtHist1 AND ?loc_pDtHist2" + ;
3415:                              " ORDER BY cIdChaves DESC, UnitMeds ASC"
3416:                 IF SQLEXEC(gnConnHandle, loc_cQuery, "LocalHis") > 0
3417:                     GO TOP IN LocalHis
3418:                     IF !EOF("LocalHis")
3419:                         loc_nCusto = LocalHis.UnitMeds
3420:                         loc_cMoeda = ALLTRIM(LocalGru.MoeCusts)
3421:                     ENDIF
3422:                 ENDIF
3423:             ENDIF
3424: 
3425:             IF EMPTY(loc_cMoeda)
3426:                 LOOP
3427:             ENDIF
3428: 
3429:             LOCAL loc_dDataFcx
3430:             loc_dDataFcx = IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData)
3431:             loc_nCota = fBuscarCotacao(loc_cMoeda, loc_dDataFcx, gnConnHandle)
3432:             IF !SEEK(loc_cMoeda, "TmpCot")
3433:                 INSERT INTO TmpCot (Cmoes, Valos) VALUES (loc_cMoeda, loc_nCota)
3434:             ENDIF
3435:         ENDSCAN
3436: 
3437:         *-- Adicionar cotacoes de todas as moedas (SigCdMoe)
3438:         loc_cSql = "SELECT CMoes FROM SigCdMoe ORDER BY CMoes"
3439:         IF SQLEXEC(gnConnHandle, loc_cSql, "LocalMoe") > 0
3440:             SELECT LocalMoe
3441:             SCAN
3442:                 IF !SEEK(ALLTRIM(LocalMoe.Cmoes), "TmpCot")
3443:                     loc_nCota = fBuscarCotacao(ALLTRIM(LocalMoe.Cmoes), ;
3444:                                                IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), ;
3445:                                                gnConnHandle)
3446:                     INSERT INTO TmpCot (Cmoes, Valos) VALUES (ALLTRIM(LocalMoe.Cmoes), loc_nCota)
3447:                 ENDIF
3448:             ENDSCAN
3449:         ENDIF
3450:         loc_loBarra.Complete()
3451: 
3452:         *-- Posicionar cursores
3453:         SELECT TmpResumo
3454:         SET ORDER TO GrConMat
3455:         GO TOP
3456:         SELECT TmpOpera
3457:         SET ORDER TO GrConMatTp
3458:         SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
3459:         GO TOP
3460:         SELECT TmpResFas
3461:         SET ORDER TO Fases
3462:         SET KEY TO TmpResumo.CMats
3463:         GO TOP
3464:         SELECT TmpResumo
3465:         GO TOP
3466: 
3467:         IF EOF("TmpResumo")
3468:             MsgAviso("Nenhuma Informa" + CHR(231) + CHR(227) + "o Foi Selecionada...")
3469:             loc_oPagina.txt_4c_Data.SetFocus()
3470:             RETURN .F.
3471:         ENDIF
3472: 
3473:         *-- Calcular indice de produtividade
3474:         SELECT a.Grupo, a.Conta, a.CMats, COUNT(a.TpOps) AS TotTpOp, ;
3475:                SUM(c.IndProds) AS TotIndProd, d.Freal, SUM(a.QtdeSais) AS TotQtde ;
3476:             FROM TmpOpera a, crSigOpOpt c, TmpResumo d ;
3477:             WHERE !EMPTY(a.QtdeSais) AND a.TpOps = c.Cods AND c.IndProds > 0 AND ;
3478:                   d.Grupo + d.Conta + d.CMats = a.Grupo + a.Conta + a.CMats ;
3479:             GROUP BY a.Grupo, a.Conta, a.CMats, d.Freal ;
3480:             INTO CURSOR TmpIndProd
3481: 
3482:         IF RECCOUNT("TmpIndProd") > 0
3483:             SELECT a.Grupo, a.Conta, a.CMats, ;
3484:                    ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) AS IndProd ;
3485:                 FROM TmpIndProd a INTO CURSOR TmpIndProd
3486:             UPDATE TmpResumo SET IndProd = TmpIndProd.IndProd ;
3487:                 WHERE TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = ;
3488:                       TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
3489:         ENDIF
3490: 
3491:         *-- Atualizar grdMov RecordSource (controle de Fase 6)
3492:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "grdMov", 5)
3493:             loc_oPagina.cnt_4c_Resultado.grdMov.RecordSource = ""
3494:             SELECT Dopps, 1 AS nMarcas FROM TmpHist GROUP BY Dopps INTO CURSOR CrOpp READWRITE
3495:             WITH loc_oPagina.cnt_4c_Resultado.grdMov
3496:                 .RecordSource          = "crOpp"
3497:                 .Column1.ControlSource = "crOpp.nMarcas"
3498:                 .Column2.ControlSource = "crOpp.Dopps"
3499:                 .Column1.Width = 17
3500:                 .Column2.Width = 150
3501:                 .Refresh()
3502:             ENDWITH
3503:         ENDIF
3504: 
3505:         *-- Inserir no CrSigCdFea se Fechamento
3506:         IF THIS.this_lFechamento
3507:             loc_nNumFape = fGerUniqueKey(loc_cEmpr + "SigCdFea")
3508:             SELECT TmpResumo
3509:             GO TOP
3510:             INSERT INTO CrSigCdFea (Grupos, Contas, Datas, Emps, Falhas, Numes, Produzidos, ;
3511:                                     Tipos, Trabs, CidChaves, NumBals) ;
3512:                 VALUES (loc_cGrupo, loc_cConta, loc_dData, ;
3513:                         IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), ALLTRIM(crSigCdFcx.Emps), loc_cEmpr), ;
3514:                         IIF(!EOF("TmpResumo"), TmpResumo.Saldof, 0), ;
3515:                         loc_nNumFape, 0, "F", loc_nTrabalhado, fUniqueIds(), loc_nCodigosFcx)
3516:         ENDIF
3517: 
3518:         *-- Habilitar Confirmar
3519:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
3520: 
3521:         *-- Exibir resultado (Fase 6: GradeMat refresh via PEMSTATUS)
3522:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "GradeMat", 5)
3523:             loc_oPagina.cnt_4c_Resultado.GradeMat.AfterRowColChange(1)
3524:             loc_oPagina.cnt_4c_Resultado.GradeMat.Refresh
3525:         ENDIF

*-- Linhas 4330 a 4368:
4330:             ENDWITH
4331:             WITH loc_oGrd.Column1
4332:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4333:                 .ControlSource   = "TmpOpera.TpOps"
4334:                 .Width           = 120
4335:             ENDWITH
4336:             WITH loc_oGrd.Column2
4337:                 .Header1.Caption = "Qtde"
4338:                 .ControlSource   = "TmpOpera.QtdeEnts"
4339:                 .Width           = 80
4340:             ENDWITH
4341:             WITH loc_oGrd.Column3
4342:                 .Header1.Caption = "F.Adm"
4343:                 .ControlSource   = "TmpOpera.PFalha"
4344:                 .Width           = 60
4345:             ENDWITH
4346:             WITH loc_oGrd.Column4
4347:                 .Header1.Caption = "Falha"
4348:                 .ControlSource   = "TmpOpera.Falha"
4349:                 .Width           = 60
4350:             ENDWITH
4351:             WITH loc_oGrd.Column5
4352:                 .Header1.Caption = "Base Falha"
4353:                 .ControlSource   = "TmpOpera.PesoBEnts"
4354:                 .Width           = 80
4355:             ENDWITH
4356:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
4357:             BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")
4358: 
4359:             *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
4360:             par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
4361:             WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
4362:                 .Value         = ""
4363:                 .Top           = 220
4364:                 .Left          = 10
4365:                 .Width         = 484
4366:                 .Height        = 23
4367:                 .ReadOnly      = .T.
4368:                 .FontName      = "Tahoma"

*-- Linhas 4392 a 4430:
4392:             ENDWITH
4393:             WITH loc_oGrd.Column1
4394:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4395:                 .ControlSource   = "TmpOpera.TpOps"
4396:                 .Width           = 120
4397:             ENDWITH
4398:             WITH loc_oGrd.Column2
4399:                 .Header1.Caption = "Qtde"
4400:                 .ControlSource   = "TmpOpera.QtdeSais"
4401:                 .Width           = 80
4402:             ENDWITH
4403:             WITH loc_oGrd.Column3
4404:                 .Header1.Caption = "F.Adm"
4405:                 .ControlSource   = "TmpOpera.PFalha"
4406:                 .Width           = 60
4407:             ENDWITH
4408:             WITH loc_oGrd.Column4
4409:                 .Header1.Caption = "Falha"
4410:                 .ControlSource   = "TmpOpera.Falha"
4411:                 .Width           = 60
4412:             ENDWITH
4413:             WITH loc_oGrd.Column5
4414:                 .Header1.Caption = "Base Falha"
4415:                 .ControlSource   = "TmpOpera.PesoBSais"
4416:                 .Width           = 80
4417:             ENDWITH
4418:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
4419:             BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")
4420: 
4421:             *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
4422:             par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
4423:             WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
4424:                 .Value         = ""
4425:                 .Top           = 220
4426:                 .Left          = 10
4427:                 .Width         = 484
4428:                 .Height        = 23
4429:                 .ReadOnly      = .T.
4430:                 .FontName      = "Tahoma"

*-- Linhas 4454 a 4487:
4454:             ENDWITH
4455:             WITH loc_oGrd.Column1
4456:                 .Header1.Caption = "Fases"
4457:                 .ControlSource   = "TmpResFas.Fases"
4458:                 .Width           = 120
4459:             ENDWITH
4460:             WITH loc_oGrd.Column2
4461:                 .Header1.Caption = "Qtde"
4462:                 .ControlSource   = "TmpResFas.Qtds"
4463:                 .Width           = 120
4464:             ENDWITH
4465:             WITH loc_oGrd.Column3
4466:                 .Header1.Caption = "Pe" + CHR(231) + "as"
4467:                 .ControlSource   = "TmpResFas.QtdPcs"
4468:                 .Width           = 120
4469:             ENDWITH
4470:             WITH loc_oGrd.Column4
4471:                 .Header1.Caption = "Pesos"
4472:                 .ControlSource   = "TmpResFas.Pesos"
4473:                 .Width           = 120
4474:             ENDWITH
4475: 
4476:             *-- cnt_4c_Conversao (top=292,left=192,w=248,h=66) - inicia oculto
4477:             par_oCnt.AddObject("cnt_4c_Conversao", "Container")
4478:             WITH par_oCnt.cnt_4c_Conversao
4479:                 .Top         = 292
4480:                 .Left        = 192
4481:                 .Width       = 248
4482:                 .Height      = 66
4483:                 .BackColor   = RGB(240, 240, 240)
4484:                 .BackStyle   = 1
4485:                 .Visible     = .F.
4486:             ENDWITH
4487:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_TituloConv", "Label")

*-- Linhas 4592 a 4634:
4592:             ENDWITH
4593:             WITH loc_oGrd.Column1
4594:                 .Header1.Caption = "Material"
4595:                 .ControlSource   = "TmpResumo.CMats"
4596:                 .Width           = 110
4597:                 .ReadOnly        = .T.
4598:             ENDWITH
4599:             WITH loc_oGrd.Column2
4600:                 .Header1.Caption = ""
4601:                 .ControlSource   = "TmpResumo.Flag3"
4602:                 .Width           = 32
4603:                 .Sparse          = .F.
4604:             ENDWITH
4605:             loc_oGrd.Column2.AddObject("Check1", "CheckBox")
4606:             WITH loc_oGrd.Column2.Check1
4607:                 .Caption   = ""
4608:                 .Alignment = 0
4609:                 .ReadOnly  = .F.
4610:                 .Visible   = .T.
4611:                 .Top       = 9
4612:                 .Left      = 2
4613:                 .Height    = 17
4614:                 .Width     = 22
4615:             ENDWITH
4616:             loc_oGrd.Column2.CurrentControl = "Check1"
4617:             WITH loc_oGrd.Column3
4618:                 .Header1.Caption = "I"
4619:                 .ControlSource   = "TmpResumo.Flag2"
4620:                 .Width           = 32
4621:                 .Sparse          = .F.
4622:                 .ReadOnly        = .T.
4623:             ENDWITH
4624:             loc_oGrd.Column3.AddObject("Check1", "CheckBox")
4625:             WITH loc_oGrd.Column3.Check1
4626:                 .Caption   = ""
4627:                 .Alignment = 0
4628:                 .ReadOnly  = .T.
4629:                 .Visible   = .T.
4630:                 .Top       = 9
4631:                 .Left      = 2
4632:                 .Height    = 17
4633:                 .Width     = 22
4634:             ENDWITH

*-- Linhas 4666 a 4684:
4666:             IF !USED("TmpGccr")
4667:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4668:             ELSE
4669:                 SELECT TmpGccr
4670:                 GO TOP
4671:                 SET ORDER TO BalCodigo
4672:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4673:                 IF VARTYPE(loc_oBusca) = "O"
4674:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4675:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4676:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4677:                     loc_oBusca.Show()
4678:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4679:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4680:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4681:                         ENDIF
4682:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4683:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4684:                         ENDIF

*-- Linhas 4714 a 4752:
4714:             IF !USED("TmpGccr")
4715:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4716:             ELSE
4717:                 SELECT TmpGccr
4718:                 SET ORDER TO BalDescrs
4719:                 GO TOP
4720:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4721:                 IF VARTYPE(loc_oBusca) = "O"
4722:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4723:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4724:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4725:                     loc_oBusca.Show()
4726:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4727:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4728:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4729:                         ENDIF
4730:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4731:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4732:                         ENDIF
4733:                     ENDIF
4734:                     loc_oBusca.Release()
4735:                     loc_oBusca = .NULL.
4736:                 ENDIF
4737:                 SELECT TmpGccr
4738:                 SET ORDER TO BalCodigo
4739:             ENDIF
4740:         CATCH TO loc_oErro
4741:             MsgErro("Erro em AbrirLookupDGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4742:         ENDTRY
4743:     ENDPROC
4744: 
4745:     *==========================================================================
4746:     * ContaKeyPress / ContaDblClick / AbrirLookupConta
4747:     * Lookup de Conta de Balanco (TmpCli pre-carregado)
4748:     *==========================================================================
4749:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4750:         IF INLIST(par_nKeyCode, 13, 9, 115)
4751:             THIS.AbrirLookupConta()
4752:             NODEFAULT

*-- Linhas 4764 a 4782:
4764:             IF !USED("TmpCli")
4765:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4766:             ELSE
4767:                 SELECT TmpCli
4768:                 GO TOP
4769:                 SET ORDER TO BalCodigo
4770:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4771:                 IF VARTYPE(loc_oBusca) = "O"
4772:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4773:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4774:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4775:                     loc_oBusca.Show()
4776:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4777:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4778:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4779:                         ENDIF
4780:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4781:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4782:                         ENDIF

*-- Linhas 4812 a 4850:
4812:             IF !USED("TmpCli")
4813:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4814:             ELSE
4815:                 SELECT TmpCli
4816:                 SET ORDER TO BalNome
4817:                 GO TOP
4818:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4819:                 IF VARTYPE(loc_oBusca) = "O"
4820:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4821:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4822:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4823:                     loc_oBusca.Show()
4824:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4825:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4826:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4827:                         ENDIF
4828:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4829:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4830:                         ENDIF
4831:                     ENDIF
4832:                     loc_oBusca.Release()
4833:                     loc_oBusca = .NULL.
4834:                 ENDIF
4835:                 SELECT TmpCli
4836:                 SET ORDER TO BalCodigo
4837:             ENDIF
4838:         CATCH TO loc_oErro
4839:             MsgErro("Erro em AbrirLookupDConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4840:         ENDTRY
4841:     ENDPROC
4842: 
4843:     *==========================================================================
4844:     * MoedaLostFocus - Lookup de Moeda (SigCdMoe) ao sair do campo
4845:     * PUBLIC: BINDEVENT em txt_4c_MOEDA.LostFocus
4846:     *==========================================================================
4847:     PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
4848:         LOCAL loc_oCnt, loc_cMoeda, loc_oBusca
4849:         TRY
4850:             loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.cnt_4c_Conversao

*-- Linhas 4902 a 4953:
4902:         TRY
4903:             IF USED("TmpResumo") AND !EOF("TmpResumo")
4904:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
4905:                 SELECT TmpResumo
4906: 
4907:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
4908:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
4909:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
4910:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
4911:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
4912:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
4913:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
4914:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
4915:                 loc_oCnt.Get_Pfalha.Value    = TmpResumo.PfTrabs
4916: 
4917:                 *-- Atualizar GradeEntradas com filtro do material corrente
4918:                 IF USED("TmpOpera")
4919:                     SELECT TmpOpera
4920:                     SET ORDER TO GrConMatTp
4921:                     SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
4922:                     GO TOP
4923:                 ENDIF
4924: 
4925:                 IF PEMSTATUS(loc_oCnt, "Pagina", 5)
4926:                     loc_oPage1 = loc_oCnt.Pagina.Pages(1)
4927:                     IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
4928:                         loc_oPage1.GradeEntradas.Refresh()
4929:                         loc_oPage1.GradeEntradas.AfterRowColChange(1)
4930:                     ENDIF
4931:                     loc_oPage2 = loc_oCnt.Pagina.Pages(2)
4932:                     IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
4933:                         loc_oPage2.GradeSaidas.Refresh()
4934:                     ENDIF
4935: 
4936:                     *-- Atualizar GradeResumo com filtro do material corrente
4937:                     IF USED("TmpResFas")
4938:                         SELECT TmpResFas
4939:                         SET KEY TO TmpResumo.CMats
4940:                         GO TOP
4941:                     ENDIF
4942:                     IF PEMSTATUS(loc_oCnt.Pagina.Pages(3), "GradeResumo", 5)
4943:                         loc_oCnt.Pagina.Pages(3).GradeResumo.Refresh()
4944:                     ENDIF
4945:                 ENDIF
4946: 
4947:                 *-- Atualizar datas do periodo no cabecalho do resultado
4948:                 IF PEMSTATUS(loc_oCnt, "Get_Datai", 5)
4949:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo, "txt_4c_DtInicial", 5)
4950:                         loc_oCnt.Get_Datai.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
4951:                         loc_oCnt.Get_Dataf.Value = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
4952:                     ENDIF
4953:                 ENDIF

*-- Linhas 5008 a 5034:
5008:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5009:                 IF !TmpResumo.Flag2
5010:                     MsgAviso("Esta Conta N" + CHR(227) + "o Permite Acerto de Balan" + CHR(231) + "o...")
5011:                     SELECT TmpResumo
5012:                     REPLACE Flag3 WITH .F.
5013:                     IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5014:                         loc_oCnt.GradeMat.Refresh()
5015:                     ENDIF
5016:                 ELSE
5017:                     IF TmpResumo.Saldof = 0 AND TmpResumo.Flag3
5018:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Diferen" + CHR(231) + CHR(97) + "  Para Acerto...")
5019:                         SELECT TmpResumo
5020:                         REPLACE Flag3 WITH .F.
5021:                         IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5022:                             loc_oCnt.GradeMat.Refresh()
5023:                         ENDIF
5024:                     ENDIF
5025:                 ENDIF
5026:             ENDIF
5027:         CATCH TO loc_oErro
5028:             MsgErro("Erro em GradeMatCheck1Change:" + CHR(13) + loc_oErro.Message, "FormFea")
5029:         ENDTRY
5030:     ENDPROC
5031: 
5032:     *==========================================================================
5033:     * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
5034:     * PUBLIC: BINDEVENT exige metodo publico

*-- Linhas 5081 a 5099:
5081:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5082:                 loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5083:                 loc_nPesagem = NVL(loc_oCnt.Get_Pesagem.Value, 0)
5084:                 SELECT TmpResumo
5085:                 REPLACE Pesagem WITH loc_nPesagem, ;
5086:                         Saldof  WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem - TmpResumo.FAdmin, ;
5087:                         FReal   WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem
5088:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
5089:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
5090:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
5091:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
5092:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
5093:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
5094:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
5095:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
5096:                 loc_oCnt.Get_Pesagem.ReadOnly = .T.
5097:             ENDIF
5098:         CATCH TO loc_oErro
5099:             MsgErro("Erro em PesagemLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")

*-- Linhas 5107 a 5210:
5107:     PROCEDURE BtnSelTudoClick()
5108:         TRY
5109:             IF USED("TmpResumo")
5110:                 SELECT TmpResumo
5111:                 REPLACE ALL Flag3 WITH .T.
5112:                 GO TOP
5113:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5114:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5115:                 ENDIF
5116:             ENDIF
5117:         CATCH TO loc_oErro
5118:             MsgErro("Erro em BtnSelTudoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5119:         ENDTRY
5120:     ENDPROC
5121: 
5122:     *==========================================================================
5123:     * BtnApagaClick - Desmarca todos os materiais (Flag3=.F.) no GradeMat
5124:     * PUBLIC: BINDEVENT exige metodo publico
5125:     *==========================================================================
5126:     PROCEDURE BtnApagaClick()
5127:         TRY
5128:             IF USED("TmpResumo")
5129:                 SELECT TmpResumo
5130:                 REPLACE ALL Flag3 WITH .F.
5131:                 GO TOP
5132:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5133:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5134:                 ENDIF
5135:             ENDIF
5136:         CATCH TO loc_oErro
5137:             MsgErro("Erro em BtnApagaClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5138:         ENDTRY
5139:     ENDPROC
5140: 
5141:     *==========================================================================
5142:     * GrdMovCheck1KeyPress - Alterna nMarcas com Enter/Espaco no grdMov
5143:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
5144:     *==========================================================================
5145:     PROCEDURE GrdMovCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5146:         TRY
5147:             IF INLIST(m.par_nKeyCode, 13, 32)
5148:                 IF USED("crOpp") AND !EOF("crOpp")
5149:                     SELECT crOpp
5150:                     REPLACE nMarcas WITH IIF(crOpp.nMarcas = 0, 1, 0)
5151:                     KEYBOARD "{DNARROW}"
5152:                     KEYBOARD "{UPARROW}"
5153:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "grdMov", 5)
5154:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.grdMov.Refresh()
5155:                     ENDIF
5156:                 ENDIF
5157:                 NODEFAULT
5158:             ENDIF
5159:         CATCH TO loc_oErro
5160:             MsgErro("Erro em GrdMovCheck1KeyPress:" + CHR(13) + loc_oErro.Message, "FormFea")
5161:         ENDTRY
5162:     ENDPROC
5163: 
5164:     *==========================================================================
5165:     * PaginaResultadoPage1Activate - Ativa aba Entradas (seta ordem TmpOpera)
5166:     * PUBLIC: BINDEVENT em Pagina.Pages(1).Activate
5167:     *==========================================================================
5168:     PROCEDURE PaginaResultadoPage1Activate()
5169:         LOCAL loc_oPage1
5170:         TRY
5171:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5172:                 SELECT TmpOpera
5173:                 SET ORDER TO GrConMatTp
5174:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5175:                 GO TOP
5176:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
5177:                 IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
5178:                     loc_oPage1.GradeEntradas.Refresh()
5179:                     loc_oPage1.GradeEntradas.AfterRowColChange(1)
5180:                 ENDIF
5181:             ENDIF
5182:         CATCH TO loc_oErro
5183:             MsgErro("Erro em PaginaResultadoPage1Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5184:         ENDTRY
5185:     ENDPROC
5186: 
5187:     *==========================================================================
5188:     * PaginaResultadoPage2Activate - Ativa aba Saidas (seta ordem TmpOpera)
5189:     * PUBLIC: BINDEVENT em Pagina.Pages(2).Activate
5190:     *==========================================================================
5191:     PROCEDURE PaginaResultadoPage2Activate()
5192:         LOCAL loc_oPage2
5193:         TRY
5194:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5195:                 SELECT TmpOpera
5196:                 SET ORDER TO GrConMatTp
5197:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5198:                 GO TOP
5199:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
5200:                 IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
5201:                     loc_oPage2.GradeSaidas.Refresh()
5202:                     loc_oPage2.GradeSaidas.AfterRowColChange(1)
5203:                 ENDIF
5204:             ENDIF
5205:         CATCH TO loc_oErro
5206:             MsgErro("Erro em PaginaResultadoPage2Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5207:         ENDTRY
5208:     ENDPROC
5209: 
5210:     *==========================================================================

*-- Linhas 5240 a 5277:
5240:             IF USED("TmpCabec")
5241:                 USE IN TmpCabec
5242:             ENDIF
5243:             CREATE CURSOR TmpCabec (Titulo C(100), SubTitulo C(254), Empresa C(80))
5244: 
5245:             loc_cSubTitulo = ""
5246:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
5247:                 IF USED("TmpCli")
5248:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
5249:                 ENDIF
5250:                 loc_cSubTitulo = " Conta : " + ALLTRIM(NVL(crSigCdFcx.Grupos, "")) + ;
5251:                                  " / " + ALLTRIM(NVL(crSigCdFcx.Contas, ""))
5252:                 IF USED("TmpCli") AND !EOF("TmpCli")
5253:                     loc_cSubTitulo = loc_cSubTitulo + " [ " + ALLTRIM(TmpCli.RClis) + " ] "
5254:                 ENDIF
5255:                 loc_cSubTitulo = loc_cSubTitulo + CHR(13) + CHR(10) + ;
5256:                                  "Per" + CHR(237) + "odo : " + ;
5257:                                  NVL(DTOC(crSigCdFcx.Datais), "") + " a " + ;
5258:                                  NVL(DTOC(crSigCdFcx.Datas), "")
5259:             ENDIF
5260: 
5261:             loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
5262:             INSERT INTO TmpCabec (Titulo, SubTitulo, Empresa) ;
5263:                 VALUES ("Balan" + CHR(231) + "o de Estoque", loc_cSubTitulo, loc_cEmpresa)
5264: 
5265:             *-- Verificar arquivo FRX
5266:             loc_cFRX = FULLPATH(gc_4c_CaminhoReports + "SIGCDFEA.frx")
5267:             IF !FILE(loc_cFRX)
5268:                 MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
5269:                     CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
5270:                     "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5271:             ELSE
5272:                 IF !USED("TmpResumo") OR RECCOUNT("TmpResumo") = 0
5273:                     MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.")
5274:                 ELSE
5275:                     *-- Isolar locale para FRX legado (Pattern #117)
5276:                     loc_cPointOrig    = SET("POINT")
5277:                     loc_cSepOrig      = SET("SEPARATOR")


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
            loc_cSQL = "SELECT g.Codigos, g.Descrs FROM SigCdGcr g WHERE 1=1"

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " AND (g.Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " OR g.Descrs LIKE " + EscaparSQL("%" + ALLTRIM(par_cValor) + "%") + ")"
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
            loc_cSQL = "SELECT c.Iclis, c.RClis, c.Inativas FROM SigCdCli c WHERE 1=1"

            IF VARTYPE(par_cGrupo) = "C" AND !EMPTY(ALLTRIM(par_cGrupo))
                loc_cSQL = loc_cSQL + " AND c.Iclis LIKE " + EscaparSQL(ALLTRIM(par_cGrupo) + "%")
            ENDIF

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " AND (c.Iclis LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
                           " OR c.RClis LIKE " + EscaparSQL("%" + ALLTRIM(par_cValor) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY c.RClis"

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

