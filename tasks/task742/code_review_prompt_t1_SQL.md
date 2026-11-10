# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SITUAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TABLE_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMN_NAME' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPCODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LISTINDEX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ESTADOS, I, DV, J, PEDIDO, DOPES, CTIPOS, EMPS, CPROS, MARCASUBNS, DESCS, UFIBGES, CODIGOS, IETIQS, 0, EMPDOPNUMS, ORIDOPNUMS, ETQSAIDS, FRETEDEFS, VALUE, FRTICMS, VLFRETES, FRTIPIS, SEGICMS, VLSEGUROS, SEGIPIS, DESICMS, DESPACES, DESIPIS, RCFINAS, CEMPS, ICLIS, PROTS, ITRAS, TIPONFS, OPERACAOS, OBRDTSAI, CFOPS, QTDS, DIGITENS, PARRECALS, SERIES, VOLUMES, OPERS

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
  ControlSource = "crSigMvNfi.BasecIpis"
  ControlSource = "crSigMvNfi.ValIpis"
  ControlSource = "crSigMvNfi.BasecIcms"
  ControlSource = "crSigMvNfi.ValIcms"
  ControlSource = "crSigMvNfi.TotProds"
  ControlSource = "crSigMvNfi.TotNotas"
  ControlSource = "crSigMvNfi.VlFretes"
  ControlSource = "crSigMvNfi.VlSeguros"
  ControlSource = "crSigMvNfi.DespAces"
  ControlSource = "crSigMvNfi.Qtdes"
  ControlSource = "crSigMvNfi.Espes"
  ControlSource = "crSigMvNfi.Marcas"
  ControlSource = "crSigMvNfi.Numeros"
  ControlSource = "crSigMvNfi.PLiqs"
  ControlSource = "crSigMvNfi.PBrus"
  ControlSource = "crSigMvNfi.Placas"
  ControlSource = "crSigMvNfi.CodTrans"
  ControlSource = ""
  ControlSource = "crSigMvNfi.Fretes"
  ControlSource = "crSigMvNfi.UfPlacas"
  ControlSource = "crSigMvNfi.Obss"
  ControlSource = "crSigMvNfi.ObsFretes"
  ControlSource = "crSigMvNfi.obspliqs"
  ControlSource = "crSigMvNfi.obspbrus"
  ControlSource = "crSigMvNfi.FrtIcms"
  ControlSource = "crSigMvNfi.FrtIpis"
  ControlSource = "crSigMvNfi.SegIcms"
  ControlSource = "crSigMvNfi.SegIpis"
  ControlSource = "crSigMvNfi.DesIcms"
  ControlSource = "crSigMvNfi.DesIpis"
  ControlSource = "crSigMvNfi.bcicmss"
  ControlSource = "crSigMvNfi.Icmss"
  ControlSource = "crSigMvNfi.basecic2s"
  ControlSource = "crSigMvNfi.Basecic3s"
  ControlSource = "crSigMvNfi.BasecIp2s"
  ControlSource = "crSigMvNfi.Basecip3s"
  ControlSource = "crSigMvNfi.IpiNCreds"
  ControlSource = "crSigMvNfi.nfechv"
  ControlSource = "crSigMvNfi.ndis"
  ControlSource = "crSigMvNfi.dregdis"
  ControlSource = "crSigMvNfi.ddesembs"
  ControlSource = "crSigMvNfi.nfechvc"
  ControlSource = "TprMvCab.ValVars"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigMvNfi.codbenefs"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigMvNfi.vdeducoes"
  ControlSource = "crSigMvNfi.vdscconds"
  ControlSource = "crSigMvNfi.vdsciconds"
  ControlSource = "crSigMvNfi.outretens"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigMvNfi.vtotiss"
  ControlSource = "crSigMvNfi.virf"
  ControlSource = "crSigMvNfi.vinss"
  ControlSource = "crSigMvNfi.vpis"
  ControlSource = "crSigMvNfi.vcsll"
  ControlSource = "crSigMvNfi.vcofins"
  ControlSource = ""
  ControlSource = "crSigMvNfi.NFis"
  ControlSource = "crSigMvNfi.CFis"
  ControlSource = ""
  ControlSource = "crSigMvNfi.Series"
  ControlSource = "crSigMvNfi.EspecieNFs"
  ControlSource = "crSigMvNfi.Emis"
  ControlSource = "crSigMvNfi.Selos"
  ControlSource = "crSigMvNfi.DtSaidas"
  ControlSource = "crSigMvNfi.CfoSubs"
  ControlSource = ""
lcQuery = [Select UFIBGEs ] + ;
		    [From SigCdUfs ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
Select LocalUF
		Insert Into crSigPrNfe (EmpDopNums, Emps, Dopes, Numes, Datas, Usuars, Arquivos, Notas, cIdChaves, ids, lotes, recibos, prots, stats, statts) ;
		If Not ThisForm.Parentform.poDataMgr.Update([crSigPrNfe])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigPrNfe)])
		If Not ThisForm.ParentForm.poDataMgr.Update([crSigMvNfi])
			=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Update - crSigMvNfi)])
Select crSigMvNfi
	lcQuery = [Select Frete from SigWbPed where Pedido = ']+TprMvCab.pedidoWeb+[']
	ThisForm.ParentForm.poDataMgr.SQLExecute(lcQuery,[crFretePed])
	Select crFretePed
	lcQuery = [Select Cfops from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[']
	ThisForm.ParentForm.poDataMgr.SQLExecute(lcQuery,[crTmpCfoOp])
lcSql = [Select * From SigCdSrv Where ctipos = ]+Iif(CrSigCdOpe.Opers=1,['E'],['S'])
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcSql, 'cServNfisc') < 1)
Select cServNfisc
	Select crSigMvNfi
		lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
		  			[From SigCnFNf ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
		Select crSigCnFNf
			lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
			  			[From SigCnFNf ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
			Select crSigCnFNf
		Insert Into crSigMvNfi (Emps, Dopes, Numes, NFis, Emis, Series, VlFretes, VlSeguros, DespAces, ;
		lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
		  			[From SigCnFNf ] + ;
		If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
		Select crSigCnFNf
			lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
			  			[From SigCnFNf ] + ;
			If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
			Select crSigCnFNf
	Select crSigMvNfi
		Select crSigMvNfi
		Select crTpmMvItn
				lcQuery = [Select Volumes ] + ;
				  			[From SigCdPro ] + ;
				If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
				Select LocalPro
		Select crSigMvNfi
			Select cServNfisc
			If Seek( CrSigMvNfi.CodServs )
		Select crSigMvNfi
	Insert Into crTiponfs	(Descrs) Values([01-NF de Serviço])
	Insert Into crTiponfs	(Descrs) Values([02-NF Fatura de Serviço])
	Insert Into crTiponfs	(Descrs) Values([03-Bilhete de Ingresso])
	Insert Into crTiponfs	(Descrs) Values([04-NF Simplificada de Serviço])
	Insert Into crTiponfs	(Descrs) Values([05-NF de Entrada])
	Insert Into crTiponfs	(Descrs) Values([06-NF Remessa de Material e Equipamento])
	Insert Into crTiponfs	(Descrs) Values([07-Cupom de Máquina Registradora])
	Insert Into crTiponfs	(Descrs) Values([08-Carnê de Pagamento])
	Insert Into crTiponfs	(Descrs) Values([09-Bilhete Eletrônico de Ingressos])
	Insert Into crTiponfs	(Descrs) Values([10-Nota Fiscal de Entrada e Serviço])
	Insert Into crTiponfs	(Descrs) Values([11-Rol de Lavanderia])
	Insert Into crTiponfs	(Descrs) Values([12-Nota de Hospedagem])
	Insert Into crTiponfs	(Descrs) Values([13-Cupom de Estacionamento])
	Insert Into crTiponfs	(Descrs) Values([14-NF Conjunta Estadual])
	Insert Into crTiponfs	(Descrs) Values([15-NF Conjunta Federal])
	Insert Into crTiponfs	(Descrs) Values([16-Conhecimento de Transporte Conjunto Estadual])
	Insert Into crTiponfs	(Descrs) Values([17-Emissor de Cupons Fiscais - ECF])
	Insert Into crTiponfs	(Descrs) Values([18-Recibo])
	Insert Into crTiponfs	(Descrs) Values([19-NF Saída de Mercadoria])
	Insert Into crTiponfs	(Descrs) Values([20-NF de Estacionamento])
	Insert Into crTiponfs	(Descrs) Values([99-Fora do País])
		Insert Into crTpTrib	(Descrs) Values([01-No Município])
		Insert Into crTpTrib	(Descrs) Values([02-Fora do Municipio])
		Insert Into crTpTrib	(Descrs) Values([03-Isenta])
		Insert Into crTpTrib	(Descrs) Values([04-Imune])
		Insert Into crTpTrib	(Descrs) Values([05-Suspensa por decisão Judicial])
		Insert Into crTpTrib	(Descrs) Values([06-Suspensa por decisão /administrativa])
		Insert Into crTpTrib	(Descrs) Values([T - Operação Normal])
		Insert Into crTpTrib	(Descrs) Values([I - Isenta ou Não Tributável no Município])
		Insert Into crTpTrib	(Descrs) Values([F - Isenta ou Não Tributável em Outro Município])
		Insert Into crTpTrib	(Descrs) Values([C - Cancelado])
		Insert Into crTpTrib	(Descrs) Values([E - Extraviado])
		Insert Into crTpTrib	(Descrs) Values([J - ISS Suspenso por Decisão Judicial])
		lcQuery = 	[Select a.codigos From SigCdMun a, SigcdUfs b where b.estados = '] + ;
		If (ThisForm.parentform.Podatamgr.SqlExecute(lcQuery, [crLocal])) >0
		SELECT descrs from crBeneficioRJ where codigos = crSigMvNfi.codbenefs into cursor crLocal
		SELECT descrs from crSrvMuns where codigos = lcSrvFis into cursor crLocal
		SELECT descrs from crBeneficioRJ where codigos = crSigMvNfi.codbenefs into cursor crLocal
		SELECT descrs from crSrvMuns where codigos = lcSrvfis into cursor crLocal
	SELECT crTpTrib
	SELECT descrs from crTipoNfs where SUBSTR(crTiponfs.descrs, 1,2) = crSigMvNfi.tiponfs into cursor crLocal
lnOldSel = Select()
	Select TprMvCab
	Select crSigMvNfi
Select(lnOldSel)
Select crSigMvNfi
		Insert Into dbImpressao ( CPros, Qtds, Cbars, Obs) Values ( crSigCdPam.Ouros, 1, lnBar, lcObs)
		lcQuery = [Select * From SigMvItn Where 0=1 Order By CItens]
		If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 0
		lcquery = [Select * From SigMvIts Where 0=1 Order By CItens]
		If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
		lcQuery = [Select * From SigMvItn Where EmpDopNums = ']+lcbusca+[' Order By CItens]
		If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 0
		lcquery = [Select * From SigMvIts Where EmpDopNums = ']+lcBusca+[' Order By CItens]
		If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
	lcQuery = [Select a.*,b.cunis From SigMvHst a, SigCdPro b Where a.OriDopNums = ']+lcbusca+[' And ]+;
	If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEesti') < 1
	lcquery = [Select * From SigMvIts Where EmpDopNums = ']+lcBusca+[' And 0=1 ]
	If ThisForm.parentform.poDataMgr.SqlExecute(lcQuery,'CrEsti2') < 1
Select CrEsti2
Select crEesti
		lcSql = [Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads ]+;
				[From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus Where a.Cpros = ']+CrEesti.Cpros+[']
		If ThisForm.parentform.poDataMgr.Sqlexecute(lcSql,'LocalPro') < 1
				Select crEsti2
				Insert Into dbImpressao (cpros, qtds, qtdeEtiq, Pesos, Obs, PVens, Moedas, EmpDopNums, CItens, CodTams) ;
				Select crEsti2
						Insert Into dbImpressao (CPros, Qtds, QtdeEtiq, CodTams, Obs, PVens, Pesos, Moedas, EmpDopNums, CItens) ;
			Select crEsti2
			Insert Into dbImpressao (CPros, Qtds, Pesos, Obs, PVens, Moedas, EmpDopNums, CItens, CodTams) ;
Update dbImpressao Set Pedido = crSigCdOpe.Abrevs
Select dbImpressao
lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
  			[From SigCnFNf ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
Select crSigCnFNf
	lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
	  			[From SigCnFNf ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
	Select crSigCnFNf
	Select crTpmMvItn
		Select crTpmMvIts
	Select crSigMvNfi
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
lcSql = [Select * From SigCdCfo Where Codigos = ']+CrSigMvNfi.Cfis+[']
Thisform.parentForm.PodataMgr.Sqlexecute(lcSql,'LocalCfo')
	SELECT crFinVin
lcQuery = [Select pastas, logonfe From SigCdEmp Where CEmps = '] + lcEmp + [']
If (ThisForm.parentform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
	DELETE file &lcArq
LOCAL cCorpo, cFrom, cCC, cTo, cAssunto, cAnexo, cEmail
	lcQuery = [Select servs, emailnfe, senhas, pastas, textonfe, portas ] +;
			  [From SigCdEmp ] + ;
	If (ThisForm.parentform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
	cFrom  = ALLTRIM(LocalEmp.emailnfe)
	lcQuery = [Select emails ] +;
			  [From SigCdCli ] + ;
	If (ThisForm.parentform.poDataMgr.SqlExecute(lcQuery, [LocalCli]) < 1)
		IF enviaEmail(cTo, cCorpo, cAssunto, cAnexo, cFrom, cCC)
		DELETE file &lcArqT
		DELETE file &lcArqX
		DELETE file &lcArqC
		DELETE file &lcArqP
Select crSigMvNfi
lcQuery = [Select servs, emailnfe, senhas, pastas, textonfe, portas ] +;
		  [From SigCdEmp ] + ;
If (ThisForm.parentform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
	lcQuery = 	[Select b.estados as estados, a.descs as munici, a.codigos as codibges From SigCdMun a, SigcdUfs b where b.estados = '] + ;
	If (ThisForm.parentform.Podatamgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crlocal
		If Not Seek(Padr(This.Value, 40), [crLocal], [munici])
	Select crBeneficioRJ
	If Not Seek(Padr(This.Value, 3), [crBeneficioRJ], [codigos])
	Select crBeneficioRJ
	Select crSrvMuns
	If Not Seek(Padr(This.Value, 8), [crSrvMuns], [codigos])
Select crSrvMuns
		lcSql = [Select * From SigCdCfo Where Operacaos = ]+Iif(CrSigCdOpe.Opers=1,['E'],['S'])
		lcSql = [Select * From SigCdCfo ]
		lcSql = lcSql + Iif(At([Where],lcSql) > 0,[ And ],[ Where ]) + [ Codigos in (Select Cfops from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[')]
	If ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'TmpSigCdCfo') < 1
	Update TmpSigCdCfo Set Descricaos = Iif(Empty(Desc2s), Descricaos, Desc2s)
		Delete From TmpSigCdCfo Where (TmpSigCdCfo.Situas = 2)
	Select TmpSigCdCfo
	If !Seek( This.Value )
		Update crTpmMvItn Set Cfops = ' '
		lcSql = [Select * From SigCdCfo Where Operacaos = ]+Iif(CrSigCdOpe.Opers=1,['E'],['S'])
		lcSql = [Select * From SigCdCfo ]
		lcSql = lcSql + Iif(At([Where],lcSql) > 0,[ And ],[ Where ]) + [ Codigos in (Select Cfops from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[')]
	If ThisForm.ParentForm.PodataMgr.SqlExecute(lcSql,'TmpSigCdCfo') < 1
	Update TmpSigCdCfo Set Descricaos = Iif(Empty(Desc2s), Descricaos, Desc2s)
		Delete From TmpSigCdCfo Where (TmpSigCdCfo.Situas = 2)
	Select TmpSigCdCfo
	If !Seek( This.Value )
		Update crTpmMvItn Set Cfops = ' '
		lcQuery = [Select Distinct series From SigCnFNf ]
		lcQuery = [Select series From SigCnFNf Where Emps = ']+TprMvCab.emps+[']
	If ThisForm.Parentform.podatamgr.sqlexecute(lcquery,'TmpCfgNf') < 0
	Select TmpCfgNf
		lcQuery = [Select series From SigCnFNf Where Emps = ']+Space(3)+[']
		If ThisForm.Parentform.podatamgr.sqlexecute(lcquery,'TmpCfgNf') < 0
	Select TmpCfgNf
	Select TmpCfgNf
	If !Seek( This.Value )
lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
  			[From SigCnFNf ] + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
Select crSigCnFNf
	lcQuery = [Select Series, NldSer, MarPads, EspPads, Piss, FatBrutos, PesoVols ] + ;
	  			[From SigCnFNf ] + ;
	If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, 'crSigCnFNf') < 1)
	Select crSigCnFNf
		Select crSigMvNfi
Select crSigMvNfi
			lcQuery = [Select ObsPads from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[' and Cfops = ']+crSigMvNfi.CfoSubs+['] 				
			lcQuery = [Select ObsPads from SigCdOop where Dopes = ']+crSigCdOpe.Dopes+[' and Cfops = ']+ThisForm.Get_ClFiscal.Value+['] 	
		ThisForm.parentform.poDataMgr.SQLExecute(lcQuery,[crTmpCfoOp]) 			
	Select TprMvCab
		Select crTpmMvItn
			Select xPar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopfis.prg) - TRECHOS RELEVANTES PARA PASS SQL (8063 linhas total):

*-- Linhas 23 a 41:
23: * loForm.DataSessionId" dentro do proprio Init para abandonar a
24: * datasession privada e compartilhar a do form pai (os cursores legados
25: * sao globais). Na arquitetura migrada nao ha cursor global compartilhado
26: * entre forms - este form le/grava via this_oBusinessObject (SQLEXEC
27: * proprio com gnConnHandle), entao a datasession privada (regra
28: * CLAUDE.md #9.4, ja coberta por FormBase.Init() com SET DATE TO BRITISH +
29: * SET CENTURY ON antes de qualquer private datasession) e inofensiva;
30: * mantida = 2 por fidelidade ao dump (PILAR 1).
31: *
32: * Montagem (migracao multi-fase):
33: *   Fase 3        - DEFINE CLASS, propriedades, Init/Destroy/
34: *                   InicializarForm, ConfigurarPageFrame() com
35: *                   ConfigurarCabecalho() (cnt_4c_Sombra + Shape2) e
36: *                   ConfigurarPgfPaginas() (pgf_4c_1, Page1="Nota Fiscal",
37: *                   Page2="Servicos"), TornarControlesVisiveis().
38: *   Fase 4        - Campos/containers do form DIRETO (fora do PageFrame),
39: *                   via ConfigurarCamposForm() + ConfigurarBotaoOk() (cmd_4c_
40: *                   Ok). So geometria/propriedades visuais - Valid/When/
41: *                   LostFocus/GotFocus e o Click do botao ok ficam para a

*-- Linhas 55 a 86:
55: *                   botoes Fwbtnm1-7/ImpEtiqueta, via
56: *                   ConfigurarPaginaNotaFiscal() - so geometria/propriedades
57: *                   visuais (Top/Left/Width/Height/Format/InputMask/
58: *                   MaxLength/Alignment/cores), SEM ControlSource (o dump
59: *                   liga direto a crSigMvNfi/TprMvCab, cursores globais que
60: *                   NAO existem na arquitetura migrada; o bind real via
61: *                   this_oBusinessObject entra no FormParaBO()/BOParaForm()
62: *                   da Fase 7/8, junto com Valid/When/LostFocus).
63: *   Fase 6 (esta) - Campos da pagina "Servicos" (pgf_4c_1.Page2, dump
64: *                   SIGOPFIS.Pagina.Servicos - 38 objetos): tipo de
65: *                   tributacao, UF/municipio da prestacao, beneficio
66: *                   fiscal, codigo de servico municipal, deducoes/
67: *                   descontos/retencoes, ISS retido, tipo de nota, totais
68: *                   de impostos (Fwget1-6/set_total), via
69: *                   ConfigurarPaginaServicos() - mesmo criterio da Fase 5:
70: *                   so geometria/propriedades visuais, SEM RowSource/
71: *                   ControlSource (Get_tptribsers/get_tiponfs dependem de
72: *                   cursores que o legado monta em runtime a partir de
73: *                   crSigCdEmp/fBeneficio_RJ/fCodMunicipal - Fase 7/8).
74: *   Fase 7/8      - Lookups (fwbuscaext/fwbuscaint do dump: UF, Municipio,
75: *                   Transportadora, Especie, Beneficio Fiscal, Servico
76: *                   Municipal), validacoes de calculo fiscal (formulas de
77: *                   frete/seguro/despesas x ICMS/IPI, regra CLAUDE.md #17
78: *                   - transcrever literal), FormParaBO()/BOParaForm(),
79: *                   botao ok.Click (gravacao/validacao final) e os botoes
80: *                   de impressao/NFe (Fwbtnm1-7).
81: *
82: * Nomes de objeto conforme tasks/task742/mapeamento.json.
83: *==============================================================================
84: 
85: DEFINE CLASS Formsigopfis AS FormBase
86: 

*-- Linhas 845 a 863:
845:     * Page1 (pagina real e visivel, NAO ha compensacao de PageFrame.Top=-29
846:     * - essa compensacao so existe no padrao frmcadastro com abas ocultas).
847:     *
848:     * So geometria/propriedades visuais nesta fase - SEM ControlSource (o
849:     * dump liga direto a crSigMvNfi/TprMvCab, cursores globais do legado que
850:     * nao existem na arquitetura migrada). O bind com this_oBusinessObject
851:     * via FormParaBO()/BOParaForm(), e os eventos Valid/When/LostFocus,
852:     * entram na Fase 7/8 junto com os lookups.
853:     *
854:     * Nomes de objeto ASCII (mapeamento.json tem 2 defeitos corrigidos
855:     * aqui, regra CLAUDE.md #11/#30): Get_PesoLiq e Get_PesoBruto colidiam
856:     * no mapeamento (os dois mapeados para "txt_4c_Peso") - renomeados para
857:     * txt_4c_PesoLiq/txt_4c_PesoBruto; Get_Esp?cie e Get_Endere?o tinham
858:     * acento no nome do objeto (invalido em identificador VFP9) -
859:     * renomeados para txt_4c_EspecieVol (ASCII, e distinto do txt_4c_Especie
860:     * do form direto - campo diferente, mesma grafia no legado) e
861:     * txt_4c_Endereco.
862:     *
863:     * Themes=.T. + DisabledPicture em TODOS os botoes com Picture (regra

*-- Linhas 2683 a 2719:
2683:     * mesmo criterio da Fase 5/ConfigurarPaginaNotaFiscal()).
2684:     *
2685:     * So geometria/propriedades visuais nesta fase - SEM RowSource/
2686:     * ControlSource. Get_tptribsers.RowSource="crTpTrib" e
2687:     * get_tiponfs.RowSource="crtiponfs.descrs" apontam para cursores que o
2688:     * Init legado (dump linhas 4788-4857) monta em RUNTIME - crTpTrib com
2689:     * INSERT INTO literal condicionado a crSigCdEmp.cidas = "RIO DE JANEIRO",
2690:     * crtiponfs via fBeneficio_RJ()/fCodMunicipal() (funcoes globais do
2691:     * legado, regra CLAUDE.md #27/#43 - wrapper ou reimplementacao no BO) -
2692:     * entram na Fase 7/8 junto com os lookups (fwbuscaext de UF/fwbuscaint de
2693:     * Municipio/Beneficio Fiscal/Servico Municipal) e o FormParaBO()/
2694:     * BOParaForm().
2695:     *
2696:     * Say1/Say2/Say3/Say4/Say5/Say6/Say7/Say8/Say10-16 do dump sao classe
2697:     * "say" com AutoSize=.T. e SEM Width/Alignment declarados - regra
2698:     * CLAUDE.md #23: migrados com .AutoSize=.F. + .Alignment=0 + Width
2699:     * calculada para caber o texto (AutoSize=.T. e no-op em Label criado por
2700:     * AddObject). Say9/Say23 JA declaram Width explicita no dump - copiadas
2701:     * literalmente.
2702:     *
2703:     * Op_IssRetido (OptionGroup "Nao"/"Sim", dump Option1.Value=1/
2704:     * Option2.Value=0) - geometria e Buttons(N) completos; ControlSource
2705:     * (issretidos) entra na Fase 7/8 com o resto do FormParaBO/BOParaForm.
2706:     *--------------------------------------------------------------------------
2707:     PROTECTED PROCEDURE ConfigurarPaginaServicos()
2708:         LOCAL loc_oPag, loc_oErro
2709: 
2710:         TRY
2711:             loc_oPag = THIS.pgf_4c_1.Page2
2712: 
2713:             *======================================================
2714:             * Bloco 1 (Top 54-82): Tipo de Tributacao de Servicos
2715:             *======================================================
2716:             loc_oPag.AddObject("lbl_4c_Label23", "Label")
2717:             WITH loc_oPag.lbl_4c_Label23
2718:                 .FontName  = "Tahoma"
2719:                 .FontSize  = 8

*-- Linhas 3585 a 3635:
3585:     *--------------------------------------------------------------------------
3586:     * FecharCursorTemporario - fecha com seguranca um cursor auxiliar.
3587:     * TABLEREVERT() EXIGE buffering: chamado em cursor com Buffering = 1 (o
3588:     * default de CREATE CURSOR e de cursor de SQLEXEC) ele NAO e inocuo -
3589:     * dispara o erro 1586 "Function requires row or table buffering mode". Dai
3590:     * a guarda por CURSORGETPROP: USE IN fecha o alias mesmo com buffer sujo
3591:     * (regra CLAUDE.md #52).
3592:     *--------------------------------------------------------------------------
3593:     PROTECTED PROCEDURE FecharCursorTemporario(par_cAlias)
3594:         IF VARTYPE(par_cAlias) = "C" AND !EMPTY(par_cAlias) AND USED(par_cAlias)
3595:             IF CURSORGETPROP("Buffering", par_cAlias) > 1
3596:                 TABLEREVERT(.T., par_cAlias)
3597:             ENDIF
3598:             USE IN (par_cAlias)
3599:         ENDIF
3600:     ENDPROC
3601: 
3602:     *--------------------------------------------------------------------------
3603:     * CarregarListaLookup - roda na sessao DESTE form o SELECT que monta a
3604:     * lista do lookup, e devolve .T. quando veio pelo menos uma linha.
3605:     *
3606:     * O legado carrega a lista INTEIRA (ja filtrada) num cursor e so depois faz
3607:     * Seek - e esse cursor que decide se o picker abre. Reproduzir isso aqui
3608:     * tambem resolve um problema de sessao: este form e DataSession = 2
3609:     * (privada, igual ao SCX) e o FormBuscaAuxiliar nao declara DataSession,
3610:     * entao o cursor que ELE cria vive na sessao default e nao e legivel deste
3611:     * lado. Por isso toda COLUNA de que o form precisa e lida deste cursor
3612:     * local, e do picker vem apenas o CODIGO escolhido.
3613:     *--------------------------------------------------------------------------
3614:     PROTECTED FUNCTION CarregarListaLookup(par_cCursor, par_cSQL)
3615:         LOCAL loc_nResultado, loc_lOk
3616:         loc_lOk = .F.
3617: 
3618:         THIS.FecharCursorTemporario(par_cCursor)
3619: 
3620:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
3621: 
3622:         IF loc_nResultado < 0
3623:             MsgErro("Falha ao consultar a lista de busca." + CHR(13) + ;
3624:                 CapturarErroSQL(), "Erro SQL")
3625:         ELSE
3626:             IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
3627:                 loc_lOk = .T.
3628:             ENDIF
3629:         ENDIF
3630: 
3631:         RETURN loc_lOk
3632:     ENDFUNC
3633: 
3634:     *--------------------------------------------------------------------------
3635:     * AcharNaListaLookup - equivalente ao "Seek( This.Value )" do legado:

*-- Linhas 3642 a 3660:
3642: 
3643:         IF USED(par_cCursor) AND VARTYPE(par_cValor) = "C"
3644:             loc_cAlvo = UPPER(ALLTRIM(par_cValor))
3645:             SELECT (par_cCursor)
3646:             LOCATE FOR UPPER(ALLTRIM(TRANSFORM(EVALUATE(par_cCursor + "." + par_cCampo)))) == loc_cAlvo
3647:             loc_lAchou = FOUND(par_cCursor)
3648:         ENDIF
3649: 
3650:         RETURN loc_lAchou
3651:     ENDFUNC
3652: 
3653:     *--------------------------------------------------------------------------
3654:     * LerColunaLookup - le uma coluna do cursor local de lookup na linha
3655:     * corrente, devolvendo string vazia quando o cursor/linha nao resolve.
3656:     *--------------------------------------------------------------------------
3657:     PROTECTED FUNCTION LerColunaLookup(par_cCursor, par_cCampo)
3658:         LOCAL loc_cValor
3659:         loc_cValor = ""
3660: 

*-- Linhas 3672 a 3690:
3672:     * abre o FormBuscaAuxiliar sobre uma TABELA do SQL Server e devolve o
3673:     * CODIGO escolhido ("" quando o usuario cancelou).
3674:     *
3675:     * Usa a API com parametros do FormBuscaAuxiliar porque assim o SELECT roda
3676:     * DENTRO da sessao do picker, que e a unica em que o cursor dele e legivel
3677:     * (ver CarregarListaLookup). O valor escolhido volta por Mostrar(), que le
3678:     * o cursor na propria sessao do picker e publica cCodigoSelecionado -
3679:     * NUNCA lendo o cursor deste lado, que daria sempre vazio.
3680:     *
3681:     * par_cFiltro recebe a condicao SEM o "WHERE" (o Init concatena
3682:     * " AND (<filtro>)"), e par_cTabela recebe o nome PURO da tabela: embutir
3683:     * um WHERE no nome geraria dois WHERE na consulta final.
3684:     *--------------------------------------------------------------------------
3685:     PROTECTED FUNCTION PickerCodigoRemoto(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
3686:             par_cTituloCod, par_cTituloDesc, par_cValor, par_cTitulo, par_cFiltro)
3687:         LOCAL loc_oBusca, loc_cCodigo, loc_cCursor
3688:         loc_cCodigo = ""
3689:         loc_cCursor = "cursor_4c_PickerFis"
3690: 

*-- Linhas 3733 a 3777:
3733:         ENDIF
3734: 
3735:         IF !EMPTY(loc_cDopes)
3736:             loc_cSQL = "SELECT opers FROM SigCdOpe WHERE RTRIM(dopes) = " + ;
3737:                 EscaparSQL(loc_cDopes)
3738: 
3739:             IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
3740:                 SELECT (loc_cCursor)
3741:                 GO TOP
3742:                 loc_nOpers = VAL(THIS.LerColunaLookup(loc_cCursor, "opers"))
3743:             ENDIF
3744: 
3745:             THIS.FecharCursorTemporario(loc_cCursor)
3746:         ENDIF
3747: 
3748:         RETURN loc_nOpers
3749:     ENDFUNC
3750: 
3751:     *--------------------------------------------------------------------------
3752:     * ObterConfigSerieVazia - devolve SigOpCdd.servzs (0 quando nao resolve).
3753:     * O legado le crSigOpCdd.SerVzs para decidir se a lista de series e global
3754:     * ("Select Distinct series From SigCnFNf") ou por empresa.
3755:     *--------------------------------------------------------------------------
3756:     PROTECTED FUNCTION ObterConfigSerieVazia()
3757:         LOCAL loc_cCursor, loc_nServzs
3758:         loc_nServzs = 0
3759:         loc_cCursor = "cursor_4c_CddFis"
3760: 
3761:         IF THIS.CarregarListaLookup(loc_cCursor, "SELECT servzs FROM SigOpCdd")
3762:             SELECT (loc_cCursor)
3763:             GO TOP
3764:             loc_nServzs = VAL(THIS.LerColunaLookup(loc_cCursor, "servzs"))
3765:         ENDIF
3766: 
3767:         THIS.FecharCursorTemporario(loc_cCursor)
3768: 
3769:         RETURN loc_nServzs
3770:     ENDFUNC
3771: 
3772:     *==========================================================================
3773:     * HANDLERS DE LOOKUP - um por campo, ligado aos 3 eventos.
3774:     * PUBLIC (sem PROTECTED) por exigencia do BINDEVENT (regra CLAUDE.md #3).
3775:     *==========================================================================
3776:     PROCEDURE ClFiscalLookup(par_nKeyCode, par_nShiftAltCtrl)
3777:         IF THIS.TeclaAbreLookup(par_nKeyCode)

*-- Linhas 3854 a 3900:
3854:     *--------------------------------------------------------------------------
3855:     * EstaIncluindo - .T. no modo de INCLUSAO. O legado usa essa distincao
3856:     * dentro do Valid do CFOP ("If (ThisForm.Op_Escolha = [INSERIR])" ->
3857:     * "Delete From TmpSigCdCfo Where Situas = 2"): CFOP desativado nao pode
3858:     * ser escolhido em nota NOVA, mas continua visivel em nota ja gravada.
3859:     *--------------------------------------------------------------------------
3860:     PROTECTED FUNCTION EstaIncluindo()
3861:         RETURN INLIST(UPPER(ALLTRIM(THIS.this_cModoAtual)), "INCLUIR", "INSERIR")
3862:     ENDFUNC
3863: 
3864:     *--------------------------------------------------------------------------
3865:     * AbrirLookupCfop - picker do CFOP de movimentacao, pelos dois lados:
3866:     *   par_cModo = "COD"  -> legado SIGOPFIS.Get_ClFiscal.Valid
3867:     *   par_cModo = "DESC" -> legado SIGOPFIS.Get_DClFiscal.Valid
3868:     *
3869:     * Os dois Valid do legado montam a MESMA lista (TmpSigCdCfo) e diferem
3870:     * apenas na ordem/coluna de busca ("Set Order to Codigos" contra
3871:     * "Set Order to Descricaos") e na ordem das colunas do picker. A lista do
3872:     * legado tem tres filtros, todos reproduzidos aqui:
3873:     *
3874:     *   1. operacaos = 'E'/'S' quando SigCdOpe.opers esta em (1,2)
3875:     *      ("If InList(CrSigCdOpe.Opers,1,2)")
3876:     *   2. codigos IN (SELECT cfops FROM SigCdOop WHERE dopes = <operacao>)
3877:     *      quando llFiltraCfo esta ligado ("If ThisForm.llFiltraCfo")
3878:     *   3. situas <> 2 em modo de inclusao
3879:     *      ("Delete From TmpSigCdCfo Where (TmpSigCdCfo.Situas = 2)")
3880:     *
3881:     * e ainda uma substituicao de descricao:
3882:     *      "Update TmpSigCdCfo Set Descricaos = Iif(Empty(Desc2s), Descricaos,
3883:     *       Desc2s)"
3884:     * reproduzida pelo CASE do SELECT (equivalente e sem depender de cursor
3885:     * gravavel, que cursor de SQLEXEC nao e).
3886:     *
3887:     * Os dois lados - a lista local e o picker - consomem a MESMA expressao de
3888:     * origem (loc_cFonte), uma subconsulta derivada com alias. Assim o picker
3889:     * ve exatamente as linhas e a descricao que o legado veria, e nao a tabela
3890:     * crua: o Init do FormBuscaAuxiliar concatena a propria clausula WHERE ao
3891:     * que recebe em par_cTabela, e uma subconsulta com alias e um table
3892:     * reference valido nessa posicao (diferente de embutir um WHERE no nome da
3893:     * tabela, que geraria dois WHERE na consulta final).
3894:     *--------------------------------------------------------------------------
3895:     PROCEDURE AbrirLookupCfop(par_cModo)
3896:         IF THIS.this_lEmLookup
3897:             RETURN
3898:         ENDIF
3899: 
3900:         THIS.this_lEmLookup = .T.

*-- Linhas 3933 a 3980:
3933:                     loc_nOpers = THIS.ObterOperacaoMovimento()
3934:                     IF INLIST(loc_nOpers, 1, 2)
3935:                         loc_cWhere = " WHERE operacaos = " + ;
3936:                             EscaparSQL(IIF(loc_nOpers = 1, "E", "S"))
3937:                     ENDIF
3938: 
3939:                     *-- Filtro 2: so os CFOP associados a operacao (SigCdOop).
3940:                     IF THIS.this_lFiltraCfo
3941:                         loc_cDopes = ""
3942:                         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3943:                             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
3944:                         ENDIF
3945: 
3946:                         loc_cWhere = loc_cWhere + ;
3947:                             IIF(EMPTY(loc_cWhere), " WHERE ", " AND ") + ;
3948:                             "codigos IN (SELECT cfops FROM SigCdOop WHERE RTRIM(dopes) = " + ;
3949:                             EscaparSQL(loc_cDopes) + ")"
3950:                     ENDIF
3951: 
3952:                     *-- Filtro 3: em inclusao, CFOP desativado nao entra.
3953:                     IF THIS.EstaIncluindo()
3954:                         loc_cWhere = loc_cWhere + ;
3955:                             IIF(EMPTY(loc_cWhere), " WHERE ", " AND ") + ;
3956:                             "situas <> 2"
3957:                     ENDIF
3958: 
3959:                     loc_cFonte = "(SELECT codigos," + ;
3960:                         " CASE WHEN LTRIM(RTRIM(ISNULL(desc2s, ''))) = ''" + ;
3961:                         " THEN descricaos ELSE desc2s END AS descricaos," + ;
3962:                         " ipi_icms, incicmnfs, operacaos" + ;
3963:                         " FROM SigCdCfo" + loc_cWhere + ") AS CfoFis"
3964: 
3965:                     loc_cSQL = "SELECT * FROM " + loc_cFonte + ;
3966:                         " ORDER BY " + loc_cCampo
3967: 
3968:                     IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
3969:                         *-- Legado: "If !Seek( This.Value )" - achando na
3970:                         *-- lista, resolve sem exibir o dialogo (contrato da
3971:                         *-- regra CLAUDE.md #37).
3972:                         IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cValor)
3973:                             IF loc_lPorDesc
3974:                                 loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
3975:                                     "descricaos", "codigos", ;
3976:                                     "Descri" + CHR(231) + CHR(227) + "o", "C" + CHR(243) + "digo", ;
3977:                                     loc_cValor, "Cadastro de C.F.O.P.", "")
3978:                             ELSE
3979:                                 loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
3980:                                     "codigos", "descricaos", ;

*-- Linhas 4068 a 4086:
4068:     * fwbuscasel sobre TmpCfgNf com a UNICA coluna Series).
4069:     *
4070:     * A lista do legado tem tres passos, todos reproduzidos:
4071:     *   1. SigOpCdd.SerVzs = 1 -> "Select Distinct series From SigCnFNf"
4072:     *      (serie global); senao "... Where Emps = <empresa do movimento>"
4073:     *   2. lista vazia -> repete com Emps = Space(3) (serie generica)
4074:     *   3. "Set Order to Series" + "If !Seek( This.Value )" -> picker
4075:     *
4076:     * Apos a escolha o legado le a configuracao da serie em SigCnFNf e aplica
4077:     * as marcas/especies padrao em crSigMvNfi ("Replace Marcas with
4078:     * crSigCnFNf.MarPads, Espes With crSigCnFNf.EspPads") - reproduzido em
4079:     * AplicarSerieEscolhida.
4080:     *
4081:     * A numeracao da nota e o selo fiscal (fGerUniqueKey/fCanUniqueKey/
4082:     * fVerImpPends, sobre SigCdSer) sao sequenciadores de documento e entram
4083:     * com as validacoes de gravacao, nas Fases 7/8.
4084:     *--------------------------------------------------------------------------
4085:     PROCEDURE AbrirLookupSerie()
4086:         IF THIS.this_lEmLookup

*-- Linhas 4114 a 4145:
4114:                     loc_nServzs = THIS.ObterConfigSerieVazia()
4115: 
4116:                     IF loc_nServzs = 1
4117:                         loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf) AS SerFis"
4118:                     ELSE
4119:                         loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf WHERE RTRIM(emps) = " + ;
4120:                             EscaparSQL(loc_cEmps) + ") AS SerFis"
4121:                     ENDIF
4122: 
4123:                     loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY series"
4124: 
4125:                     *-- Legado: lista vazia por empresa -> repete com a
4126:                     *-- empresa generica (Space(3)).
4127:                     IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL) AND loc_nServzs != 1
4128:                         loc_cFonte = "(SELECT DISTINCT series FROM SigCnFNf WHERE RTRIM(emps) = " + ;
4129:                             EscaparSQL("") + ") AS SerFis"
4130:                         loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY series"
4131:                         THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
4132:                     ENDIF
4133: 
4134:                     IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
4135:                         IF !THIS.AcharNaListaLookup(loc_cCursor, "series", loc_cValor)
4136:                             *-- Picker de UMA coluna, como o legado
4137:                             *-- ("loLista.AddColuna( 'Series', Repl('X',10),
4138:                             *-- 'Codigo' )" e mais nada).
4139:                             loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
4140:                                 "series", "", "S" + CHR(233) + "rie", "", ;
4141:                                 loc_cValor, "Cadastro de S" + CHR(233) + "ries", "")
4142:                         ELSE
4143:                             loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "series")
4144:                         ENDIF
4145: 

*-- Linhas 4170 a 4214:
4170:     * AplicarSerieEscolhida - le a configuracao da serie em SigCnFNf e aplica
4171:     * marca e especie padrao, transcrevendo o trecho do Valid legado:
4172:     *
4173:     *   lcQuery = [Select Series, NldSer, MarPads, EspPads, ... From SigCnFNf
4174:     *              Where Emps = <empresa> And Series = <serie>]
4175:     *   ... Go Top / If Eof() -> repete com Emps = Space(3)
4176:     *   Replace Marcas with crSigCnFNf.MarPads, Espes With crSigCnFNf.EspPads
4177:     *   If IsEmpty(crSigMvNfi.Marcas) -> Replace Marcas with crSigCnFNf.MarPads
4178:     *
4179:     * Os campos de destino na tela sao txt_4c_Marca e txt_4c_EspecieVol, da
4180:     * pagina "Nota Fiscal" (o legado termina o Valid dando Refresh neles).
4181:     *--------------------------------------------------------------------------
4182:     PROTECTED PROCEDURE AplicarSerieEscolhida(par_cSerie, par_cEmps)
4183:         LOCAL loc_cCursor, loc_cSQL, loc_cMarca, loc_cEspecie, loc_oCtrl
4184: 
4185:         loc_cCursor = "cursor_4c_CfgSerie"
4186: 
4187:         loc_cSQL = "SELECT series, nldser, marpads, esppads, piss, fatbrutos, pesovols" + ;
4188:             " FROM SigCnFNf WHERE RTRIM(emps) = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
4189:             " AND RTRIM(series) = " + EscaparSQL(ALLTRIM(par_cSerie))
4190: 
4191:         IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
4192:             loc_cSQL = "SELECT series, nldser, marpads, esppads, piss, fatbrutos, pesovols" + ;
4193:                 " FROM SigCnFNf WHERE RTRIM(emps) = " + EscaparSQL("") + ;
4194:                 " AND RTRIM(series) = " + EscaparSQL(ALLTRIM(par_cSerie))
4195:             THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
4196:         ENDIF
4197: 
4198:         IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
4199:             SELECT (loc_cCursor)
4200:             GO TOP
4201: 
4202:             loc_cMarca   = THIS.LerColunaLookup(loc_cCursor, "marpads")
4203:             loc_cEspecie = THIS.LerColunaLookup(loc_cCursor, "esppads")
4204: 
4205:             loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_Marca")
4206:             IF VARTYPE(loc_oCtrl) = "O" AND !EMPTY(loc_cMarca)
4207:                 loc_oCtrl.Value = loc_cMarca
4208:                 loc_oCtrl.Refresh()
4209:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
4210:                     THIS.this_oBusinessObject.this_cMarcas = loc_cMarca
4211:                 ENDIF
4212:             ENDIF
4213: 
4214:             loc_oCtrl = THIS.ResolverControle("pgf_4c_1.Page1.txt_4c_EspecieVol")

*-- Linhas 4256 a 4274:
4256: 
4257:                 IF !EMPTY(loc_cValor)
4258:                     IF THIS.CarregarListaLookup(loc_cCursor, ;
4259:                             "SELECT especies, descs FROM SigCdEsp ORDER BY especies")
4260: 
4261:                         IF !THIS.AcharNaListaLookup(loc_cCursor, "especies", loc_cValor)
4262:                             loc_cCodigo = THIS.PickerCodigoRemoto("SigCdEsp", ;
4263:                                 "especies", "descs", ;
4264:                                 "Esp" + CHR(233) + "cie", "Descri" + CHR(231) + CHR(227) + "o", ;
4265:                                 loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
4266:                         ELSE
4267:                             loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "especies")
4268:                         ENDIF
4269: 
4270:                         IF !EMPTY(loc_cCodigo)
4271:                             loc_oTxt.Value = loc_cCodigo
4272:                             loc_oTxt.Refresh()
4273: 
4274:                             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 4341 a 4367:
4341:                     *-- Legado: a busca por NOME restringe a lista por
4342:                     *-- SUBSTRING antes de abrir o picker.
4343:                     IF loc_lPorNome
4344:                         loc_cFonte = "(SELECT itras, razaos, endes, cidas, estas, cgcs" + ;
4345:                             " FROM SigPrTrp WHERE razaos LIKE " + ;
4346:                             EscaparSQL("%" + loc_cValor + "%") + ") AS TrpFis"
4347:                     ELSE
4348:                         loc_cFonte = "(SELECT itras, razaos, endes, cidas, estas, cgcs" + ;
4349:                             " FROM SigPrTrp) AS TrpFis"
4350:                     ENDIF
4351: 
4352:                     loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY " + loc_cCampo
4353: 
4354:                     IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
4355:                         IF !THIS.AcharNaListaLookup(loc_cCursor, loc_cCampo, loc_cValor)
4356:                             IF loc_lPorNome
4357:                                 loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
4358:                                     "razaos", "itras", ;
4359:                                     "Raz" + CHR(227) + "o Social", "C" + CHR(243) + "digo", ;
4360:                                     loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
4361:                             ELSE
4362:                                 loc_cCodigo = THIS.PickerCodigoRemoto(loc_cFonte, ;
4363:                                     "itras", "razaos", ;
4364:                                     "C" + CHR(243) + "digo", "Raz" + CHR(227) + "o Social", ;
4365:                                     loc_cValor, "Sele" + CHR(231) + CHR(227) + "o", "")
4366:                             ENDIF
4367: 

*-- Linhas 4504 a 4522:
4504: 
4505:                 IF !EMPTY(loc_cValor)
4506:                     IF THIS.CarregarListaLookup(loc_cCursor, ;
4507:                             "SELECT estados, descrs FROM SigCdUfs ORDER BY estados")
4508: 
4509:                         IF !THIS.AcharNaListaLookup(loc_cCursor, "estados", PADR(loc_cValor, 2))
4510:                             loc_cCodigo = THIS.PickerCodigoRemoto("SigCdUfs", ;
4511:                                 "estados", "descrs", ;
4512:                                 "UF", "Descri" + CHR(231) + CHR(227) + "o", ;
4513:                                 PADR(loc_cValor, 2), "Sele" + CHR(231) + CHR(227) + "o", "")
4514:                         ELSE
4515:                             loc_cCodigo = THIS.LerColunaLookup(loc_cCursor, "estados")
4516:                         ENDIF
4517: 
4518:                         *-- Legado: "If crListaRemota.Estados <> '  '" - UF
4519:                         *-- vazia nao sobrescreve o campo.
4520:                         IF !EMPTY(loc_cCodigo)
4521:                             loc_oTxt.Value = loc_cCodigo
4522:                             loc_oTxt.Refresh()

*-- Linhas 4546 a 4566:
4546:     * AbrirLookupMunicipio - picker do municipio da prestacao de servico
4547:     * (legado Pagina.Servicos.Get_Mun.Valid).
4548:     *
4549:     * A lista do legado e um JOIN filtrado pela UF do campo vizinho:
4550:     *   lcQuery = [Select b.estados as estados, a.descs as munici,
4551:     *              a.codigos as codibges From SigCdMun a, SigcdUfs b
4552:     *              where b.estados = '<UF>' and a.ufibges = b.ufibges
4553:     *              order by descs]
4554:     *   Index On munici / If Not Seek(Padr(This.Value, 40)) -> fwbuscaint
4555:     *   This.Value = crlocal.munici / lcIbges = crlocal.codibges
4556:     *   replace prestservs with lcIbges in crSigMvNfi
4557:     *
4558:     * Sem UF preenchida o legado nao consulta nada ("If Not Empty(lcUf)") e o
4559:     * codigo IBGE do municipio e zerado - os dois comportamentos reproduzidos.
4560:     *
4561:     * Tabelas: SigCdMun (codigos char(7), descs char(40), ufibges numeric) e
4562:     * SigCdUfs (estados char(2), UFIBGEs numeric) - conferidas em
4563:     * docs/schema.sql.
4564:     *--------------------------------------------------------------------------
4565:     PROCEDURE AbrirLookupMunicipio()
4566:         IF THIS.this_lEmLookup

*-- Linhas 4595 a 4618:
4595:                         THIS.this_oBusinessObject.this_cPrestservs = ""
4596:                     ENDIF
4597:                 ELSE
4598:                     loc_cFonte = "(SELECT b.estados AS estados, a.descs AS munici," + ;
4599:                         " a.codigos AS codibges" + ;
4600:                         " FROM SigCdMun a INNER JOIN SigCdUfs b ON a.ufibges = b.UFIBGEs" + ;
4601:                         " WHERE RTRIM(b.estados) = " + EscaparSQL(loc_cUf) + ") AS MunFis"
4602: 
4603:                     loc_cSQL = "SELECT * FROM " + loc_cFonte + " ORDER BY munici"
4604: 
4605:                     IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
4606:                         IF !THIS.AcharNaListaLookup(loc_cCursor, "munici", loc_cValor)
4607:                             loc_cNome = THIS.PickerCodigoRemoto(loc_cFonte, ;
4608:                                 "munici", "estados", ;
4609:                                 "Munic" + CHR(237) + "pios", "UF", ;
4610:                                 loc_cValor, "Munic" + CHR(237) + "pios", "")
4611: 
4612:                             IF !EMPTY(loc_cNome)
4613:                                 IF !THIS.AcharNaListaLookup(loc_cCursor, "munici", loc_cNome)
4614:                                     loc_cNome = ""
4615:                                 ENDIF
4616:                             ENDIF
4617:                         ELSE
4618:                             loc_cNome = THIS.LerColunaLookup(loc_cCursor, "munici")

*-- Linhas 5008 a 5065:
5008:     *
5009:     *   ThisForm.llFiltraCfo = .F.
5010:     *   If( crSigOpCdd.ChkCFOP <> 2 )
5011:     *       lcQuery = [Select Cfops from SigCdOop where Dopes = '<dopes>']
5012:     *       ... If not Eof -> ThisForm.llFiltraCfo = .T.
5013:     *   Endif
5014:     *   ThisForm.Pagina.Impostos.ImpEtiqueta.Visible = (CrSigOpCdd.Etigar = 1)
5015:     *   ThisForm.NfServicos = CrTmpSerie.TpServicos
5016:     *
5017:     * No legado isso le cursores que o form PAI mantem abertos; aqui cada
5018:     * valor vem do banco pela conexao propria. Falha de leitura NAO derruba
5019:     * a tela (o form fica com o default das properties) - por isso TRY/CATCH
5020:     * proprio, e por isso e chamado DEPOIS da montagem visual.
5021:     *--------------------------------------------------------------------------
5022:     PROTECTED PROCEDURE CarregarEstadoFiscal()
5023:         LOCAL loc_oErro, loc_cDopes, loc_cSQL, loc_cCursor, loc_oBtn
5024:         LOCAL loc_nChkCfop, loc_nEtigar
5025: 
5026:         loc_cCursor = "cursor_4c_EstadoFis"
5027: 
5028:         *-- Sem conexao usavel nao ha estado a carregar, e insistir seria pior
5029:         *-- que inutil: SQLEXEC com handle invalido DISPARA EXCECAO (nao
5030:         *-- devolve -1), que cairia no CATCH abaixo e exibiria um erro de
5031:         *-- conexao a cada abertura durante a validacao de UI / teste
5032:         *-- headless, onde gnConnHandle vale 0 ou -1 de proposito.
5033:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
5034:             RETURN
5035:         ENDIF
5036: 
5037:         TRY
5038:             loc_cDopes = ""
5039:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
5040:                 loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
5041:             ENDIF
5042: 
5043:             *-- llFiltraCfo: so filtra quando a configuracao permite E existe
5044:             *-- CFOP cadastrada para a operacao (as DUAS condicoes do legado).
5045:             THIS.this_lFiltraCfo = .F.
5046:             loc_nChkCfop = THIS.ObterConfigNumerica("SigOpCdd", "chkcfop", "")
5047: 
5048:             IF loc_nChkCfop != 2 AND !EMPTY(loc_cDopes)
5049:                 loc_cSQL = "SELECT cfops FROM SigCdOop WHERE RTRIM(dopes) = " + ;
5050:                     EscaparSQL(loc_cDopes)
5051: 
5052:                 IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5053:                     THIS.this_lFiltraCfo = .T.
5054:                 ENDIF
5055: 
5056:                 THIS.FecharCursorTemporario(loc_cCursor)
5057:             ENDIF
5058: 
5059:             *-- Visible do ImpEtiqueta vem da configuracao Etigar (etiqueta de
5060:             *-- garantia), nao do SCX - o dump sobrescreve no proprio Init.
5061:             loc_nEtigar = THIS.ObterConfigNumerica("SigOpCdd", "etigar", "")
5062:             loc_oBtn = THIS.ResolverControle("pgf_4c_1.Page1.cmd_4c_ImpEtiqueta")
5063:             IF VARTYPE(loc_oBtn) = "O"
5064:                 loc_oBtn.Visible = (loc_nEtigar = 1)
5065:             ENDIF

*-- Linhas 5087 a 5111:
5087:         loc_nValor  = 0
5088:         loc_cCursor = "cursor_4c_CfgNum"
5089: 
5090:         loc_cSQL = "SELECT " + par_cColuna + " FROM " + par_cTabela
5091:         IF VARTYPE(par_cWhere) = "C" AND !EMPTY(par_cWhere)
5092:             loc_cSQL = loc_cSQL + " WHERE " + par_cWhere
5093:         ENDIF
5094: 
5095:         IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5096:             SELECT (loc_cCursor)
5097:             GO TOP
5098:             loc_nValor = VAL(THIS.LerColunaLookup(loc_cCursor, par_cColuna))
5099:         ENDIF
5100: 
5101:         THIS.FecharCursorTemporario(loc_cCursor)
5102: 
5103:         RETURN loc_nValor
5104:     ENDFUNC
5105: 
5106:     *--------------------------------------------------------------------------
5107:     * ColunaExisteNaTabela - equivalente migrado do "Type([crX.Coluna]) = [N]"
5108:     * que o legado usa como GUARDA antes de aplicar uma regra.
5109:     *
5110:     * No ok.Click o legado escreve:
5111:     *   If Type([crSigOpCdi.ObrDtSai])=[N] And crSigOpCdi.ObrDtSai = 1

*-- Linhas 5121 a 5188:
5121:         loc_lExiste = .F.
5122:         loc_cCursor = "cursor_4c_ColFis"
5123: 
5124:         loc_cSQL = "SELECT COUNT(*) AS nExiste FROM INFORMATION_SCHEMA.COLUMNS" + ;
5125:             " WHERE TABLE_NAME = " + EscaparSQL(ALLTRIM(par_cTabela)) + ;
5126:             " AND COLUMN_NAME = "  + EscaparSQL(ALLTRIM(par_cColuna))
5127: 
5128:         IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5129:             SELECT (loc_cCursor)
5130:             GO TOP
5131:             loc_lExiste = (VAL(THIS.LerColunaLookup(loc_cCursor, "nExiste")) > 0)
5132:         ENDIF
5133: 
5134:         THIS.FecharCursorTemporario(loc_cCursor)
5135: 
5136:         RETURN loc_lExiste
5137:     ENDFUNC
5138: 
5139:     *--------------------------------------------------------------------------
5140:     * ObterTipoServicoSerie - SigCdSer.tpservicos da serie da nota, que no
5141:     * legado chega por "ThisForm.NfServicos = CrTmpSerie.TpServicos".
5142:     *
5143:     * A chave do cadastro de series e POSICIONAL: empcods char(6) =
5144:     * emps char(3) + cods char(3). Montada com PADR explicito, NUNCA com
5145:     * ALLTRIM nas partes - ALLTRIM encurta a chave, ela nao casa e o SELECT
5146:     * devolve ZERO linha em silencio (regra CLAUDE.md #42). O legado faz o
5147:     * mesmo SEEK duas vezes: primeiro com a empresa da nota, depois com a
5148:     * empresa generica (Space(3)), que e o cadastro valido para todas.
5149:     *--------------------------------------------------------------------------
5150:     PROTECTED FUNCTION ObterTipoServicoSerie()
5151:         LOCAL loc_cCursor, loc_cSQL, loc_cEmps, loc_cSerie, loc_nTipo
5152:         loc_nTipo   = 0
5153:         loc_cCursor = "cursor_4c_SerFis"
5154:         loc_cEmps   = ""
5155:         loc_cSerie  = ""
5156: 
5157:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5158:             loc_cEmps  = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
5159:             loc_cSerie = ALLTRIM(THIS.this_oBusinessObject.this_cSeries)
5160:         ENDIF
5161: 
5162:         IF !EMPTY(loc_cSerie)
5163:             loc_cSQL = "SELECT tpservicos FROM SigCdSer WHERE empcods = " + ;
5164:                 EscaparSQL(PADR(loc_cEmps, 3) + PADR(loc_cSerie, 3))
5165: 
5166:             IF !THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5167:                 loc_cSQL = "SELECT tpservicos FROM SigCdSer WHERE empcods = " + ;
5168:                     EscaparSQL(PADR("", 3) + PADR(loc_cSerie, 3))
5169:                 THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5170:             ENDIF
5171: 
5172:             IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
5173:                 SELECT (loc_cCursor)
5174:                 GO TOP
5175:                 loc_nTipo = VAL(THIS.LerColunaLookup(loc_cCursor, "tpservicos"))
5176:             ENDIF
5177: 
5178:             THIS.FecharCursorTemporario(loc_cCursor)
5179:         ENDIF
5180: 
5181:         RETURN loc_nTipo
5182:     ENDFUNC
5183: 
5184:     *--------------------------------------------------------------------------
5185:     * AbrirCursorNota - abre, na sessao deste form, as colunas pedidas do
5186:     * registro de SigMvNfi que a tela representa (equivalente ao cursor
5187:     * crSigMvNfi que o form PAI mantem posicionado no legado).
5188:     *

*-- Linhas 5200 a 5224:
5200:         ENDIF
5201: 
5202:         IF !EMPTY(loc_cChave)
5203:             loc_cSQL = "SELECT " + par_cColunas + " FROM SigMvNfi" + ;
5204:                 " WHERE RTRIM(cidchaves) = " + EscaparSQL(loc_cChave)
5205: 
5206:             loc_lOk = THIS.CarregarListaLookup(par_cCursor, loc_cSQL)
5207: 
5208:             IF loc_lOk
5209:                 SELECT (par_cCursor)
5210:                 GO TOP
5211:             ENDIF
5212:         ENDIF
5213: 
5214:         RETURN loc_lOk
5215:     ENDFUNC
5216: 
5217:     *--------------------------------------------------------------------------
5218:     * LerTextoNota - le coluna "text" (XML/PDF/TXT da NFe) de um cursor.
5219:     *
5220:     * NAO usa LerColunaLookup: aquele passa por TRANSFORM(), que nao serve
5221:     * para memo/text de dezenas de KB. Aqui o valor sai cru, com guarda de
5222:     * NULL (as quatro colunas sao "text NULL" no schema) e de tipo.
5223:     *--------------------------------------------------------------------------
5224:     PROTECTED FUNCTION LerTextoNota(par_cCursor, par_cCampo)

*-- Linhas 5461 a 5479:
5461:     *--------------------------------------------------------------------------
5462:     * ObterTipoTributacaoServico - valor de SigMvNfi.tptribsers (numeric(2,0)).
5463:     *
5464:     * No legado o ComboBox Get_tptribsers tem ControlSource nessa coluna e o
5465:     * Valid grava "RECNO('crTpTrib')", ou seja o INDICE 1-based do item
5466:     * escolhido: ListIndex e a leitura equivalente na tela. Quando a lista
5467:     * ainda nao tem itens (ListIndex = 0) vale a property do BO - nunca o
5468:     * contrario, porque o que o usuario acabou de escolher esta no controle.
5469:     *--------------------------------------------------------------------------
5470:     PROTECTED FUNCTION ObterTipoTributacaoServico()
5471:         LOCAL loc_oCbo, loc_nTipo
5472:         loc_nTipo = 0
5473: 
5474:         loc_oCbo = THIS.ResolverControle("pgf_4c_1.Page2.cbo_4c_Get_tptribsers")
5475: 
5476:         IF VARTYPE(loc_oCbo) = "O" AND loc_oCbo.ListIndex > 0
5477:             loc_nTipo = loc_oCbo.ListIndex
5478:         ELSE
5479:             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 5522 a 5567:
5522:         ENDIF
5523: 
5524:         IF !EMPTY(loc_cSerie)
5525:             loc_cSQL = "SELECT cods FROM SigCdSer WHERE empcods = " + ;
5526:                 EscaparSQL(PADR(loc_cEmps, 3) + PADR(loc_cSerie, 3))
5527:             loc_lAchou = THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5528: 
5529:             IF !loc_lAchou
5530:                 *-- Segunda tentativa do legado: empresa generica (Space(3)).
5531:                 loc_cSQL = "SELECT cods FROM SigCdSer WHERE empcods = " + ;
5532:                     EscaparSQL(PADR("", 3) + PADR(loc_cSerie, 3))
5533:                 loc_lAchou = THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5534:             ENDIF
5535: 
5536:             THIS.FecharCursorTemporario(loc_cCursor)
5537: 
5538:             IF !loc_lAchou
5539:                 MsgAviso("Aten" + CHR(231) + CHR(227) + "o! N" + CHR(227) + ;
5540:                     "o existe Cadastro da S" + CHR(233) + "rie " + loc_cSerie + ;
5541:                     " para a Empresa " + loc_cEmps, ;
5542:                     "Cadastro de S" + CHR(233) + "rie")
5543:             ENDIF
5544:         ENDIF
5545:     ENDPROC
5546: 
5547:     *--------------------------------------------------------------------------
5548:     * AplicarObservacaoPadraoCfop - bloco "If ThisForm.llFiltraCfo" do
5549:     * ok.Click legado, que busca a observacao padrao da CFOP e a grava no
5550:     * movimento:
5551:     *
5552:     *   lcQuery = [Select ObsPads from SigCdOop where Dopes = '<dopes>'
5553:     *              and Cfops = '<CfoSubs ou Get_ClFiscal.Value>']
5554:     *   ... If Used + not Eof
5555:     *       cursorquery('SigCdObs','CrObs','Codigos', crTmpCfoOp.ObsPads)
5556:     *       cursorquery('SigCdEmp','CrEmp','Cemps', ParentForm.pEmps, [Cgcs])
5557:     *       ThisForm.MontaObs(ThisForm.ParentForm.poDataMgr)
5558:     *
5559:     * O MontaObs do legado (dump, PROCEDURE de mesmo nome) faz duas coisas:
5560:     *   Replace CodObs With crObs.Codigos In TprMvCab          <- CODIGO
5561:     *   lcMsg = fMontaObs(crObs.Observas, pCnx)                <- TEXTO
5562:     *   If Not Empty(lcMsg) -> Replace ObsEs With lcMsg In TprMvCab
5563:     *
5564:     * O CODIGO e gravado aqui. O TEXTO depende de fMontaObs(), que expande as
5565:     * macros da observacao padrao (CNPJ da empresa, numeros do movimento) e
5566:     * NAO veio no acervo: um stub devolvendo "" faria o "If Not Empty" nunca
5567:     * entrar e a observacao fiscal ficaria vazia EM SILENCIO - exatamente o

*-- Linhas 5590 a 5622:
5590:         ENDIF
5591: 
5592:         IF !EMPTY(loc_cDopes) AND !EMPTY(loc_cCfop)
5593:             loc_cSQL = "SELECT obspads FROM SigCdOop" + ;
5594:                 " WHERE RTRIM(dopes) = " + EscaparSQL(loc_cDopes) + ;
5595:                 " AND RTRIM(cfops) = "   + EscaparSQL(loc_cCfop)
5596: 
5597:             IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
5598:                 SELECT (loc_cCursor)
5599:                 GO TOP
5600:                 loc_nCodObs = VAL(THIS.LerColunaLookup(loc_cCursor, "obspads"))
5601: 
5602:                 IF loc_nCodObs > 0
5603:                     loc_cSQL = "SELECT codigos, observas FROM SigCdObs" + ;
5604:                         " WHERE codigos = " + FormatarNumeroSQL(loc_nCodObs, 0)
5605: 
5606:                     IF THIS.CarregarListaLookup(loc_cCursorObs, loc_cSQL)
5607:                         SELECT (loc_cCursorObs)
5608:                         GO TOP
5609: 
5610:                         *-- "Replace CodObs With crObs.Codigos In TprMvCab"
5611:                         THIS.GravarNoMovimento("CodObs", loc_nCodObs)
5612: 
5613:                         loc_cTextoObs = THIS.LerTextoNota(loc_cCursorObs, "observas")
5614: 
5615:                         IF !EMPTY(loc_cTextoObs)
5616:                             *-- fMontaObs() expandiria as macros deste texto.
5617:                             THIS.AvisarLegadoNaoPortado("fMontaObs()", ;
5618:                                 "gravar o texto da observa" + CHR(231) + CHR(227) + ;
5619:                                 "o padr" + CHR(227) + "o da CFOP " + loc_cCfop + ;
5620:                                 " no movimento")
5621:                         ENDIF
5622:                     ENDIF

*-- Linhas 5673 a 5691:
5673: 
5674:         IF !EMPTY(loc_cDopes)
5675:             loc_nDigDoc = THIS.ObterConfigNumerica("SigCdOpe", "digdoc", ;
5676:                 "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
5677:         ENDIF
5678: 
5679:         *-- Numero da nota volta para o cabecalho do movimento.
5680:         IF loc_nDigDoc != 4
5681:             loc_cNota = ""
5682:             loc_oCtrl = THIS.ResolverControle("txt_4c_Nota")
5683:             IF VARTYPE(loc_oCtrl) = "O"
5684:                 loc_cNota = ALLTRIM(TRANSFORM(loc_oCtrl.Value))
5685:             ENDIF
5686: 
5687:             IF EMPTY(loc_cNota) AND VARTYPE(THIS.this_oBusinessObject) = "O"
5688:                 loc_cNota = ALLTRIM(THIS.this_oBusinessObject.this_cNFis)
5689:             ENDIF
5690: 
5691:             THIS.GravarNoMovimento("Notas", loc_cNota)

*-- Linhas 5783 a 5801:
5783: 
5784:         *-- COUNT percorre o cursor de itens: guardar e repor o RECNO, porque
5785:         *-- quem abriu esse cursor e o form PAI e ele conta com a posicao.
5786:         SELECT crTpmMvItn
5787:         loc_nRegAnterior = RECNO("crTpmMvItn")
5788: 
5789:         COUNT TO loc_nItens FOR !EMPTY(crTpmMvItn.Cpros) AND crTpmMvItn.Qtds != 0
5790: 
5791:         IF BETWEEN(loc_nRegAnterior, 1, RECCOUNT("crTpmMvItn"))
5792:             GO loc_nRegAnterior IN crTpmMvItn
5793:         ENDIF
5794: 
5795:         IF loc_nItens = 0
5796:             RETURN
5797:         ENDIF
5798: 
5799:         loc_oBO = THIS.this_oBusinessObject
5800: 
5801:         loc_nValos = TprMvCab.ValInis + TprMvCab.ValServs + TprMvCab.ValEncs + ;

*-- Linhas 5807 a 5871:
5807: 
5808:     *--------------------------------------------------------------------------
5809:     * RecalcularVencimentosParcelas - "If ParAutos = 1 And ParRecals = 1 /
5810:     * Select xPar / Scan / Replace Vencs With nDias + Ttod(CrSigMvNfi.Emis)"
5811:     * do ok.Click legado.
5812:     *
5813:     * As DUAS configuracoes sao exigidas juntas, como no legado. A data de
5814:     * emissao passa por ConverterParaData() e nao por TTOD(): TTOD so aceita
5815:     * DATETIME e estoura erro 11 com DATE, e o mesmo campo chega como DATE
5816:     * (TextBox criado com {}) ou DATETIME (coluna datetime via SQLEXEC)
5817:     * conforme o caminho - regra CLAUDE.md #16.
5818:     *--------------------------------------------------------------------------
5819:     PROTECTED PROCEDURE RecalcularVencimentosParcelas()
5820:         LOCAL loc_cDopes, loc_cWhere, loc_dEmissao, loc_oCtrl
5821: 
5822:         IF !USED("xPar")
5823:             RETURN
5824:         ENDIF
5825: 
5826:         loc_cDopes = ""
5827:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5828:             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
5829:         ENDIF
5830: 
5831:         IF EMPTY(loc_cDopes)
5832:             RETURN
5833:         ENDIF
5834: 
5835:         loc_cWhere = "RTRIM(dopes) = " + EscaparSQL(loc_cDopes)
5836: 
5837:         IF THIS.ObterConfigNumerica("SigCdOpe", "parautos", loc_cWhere) != 1 OR ;
5838:                 THIS.ObterConfigNumerica("SigCdOpe", "parrecals", loc_cWhere) != 1
5839:             RETURN
5840:         ENDIF
5841: 
5842:         loc_dEmissao = {}
5843:         loc_oCtrl = THIS.ResolverControle("txt_4c_Emissao")
5844:         IF VARTYPE(loc_oCtrl) = "O"
5845:             loc_dEmissao = ConverterParaData(loc_oCtrl.Value)
5846:         ENDIF
5847: 
5848:         IF EMPTY(loc_dEmissao) AND VARTYPE(THIS.this_oBusinessObject) = "O"
5849:             loc_dEmissao = ConverterParaData(THIS.this_oBusinessObject.this_dEmis)
5850:         ENDIF
5851: 
5852:         IF EMPTY(loc_dEmissao)
5853:             RETURN
5854:         ENDIF
5855: 
5856:         SELECT xPar
5857:         SCAN
5858:             REPLACE Vencs WITH xPar.nDias + loc_dEmissao IN xPar
5859:         ENDSCAN
5860:     ENDPROC
5861: 
5862:     *==========================================================================
5863:     * BOTAO "Etiquetas" (legado SIGOPFIS.Pagina.Impostos.ImpEtiqueta)
5864:     *==========================================================================
5865: 
5866:     *--------------------------------------------------------------------------
5867:     * CmdImprimirEtiquetasClick - wrapper fino (o corpo tem RETURN antecipado
5868:     * na recusa da confirmacao e em cada falha de consulta; RETURN dentro de
5869:     * TRY/CATCH e proibido - regra CLAUDE.md #1).
5870:     *
5871:     * O legado declara "Lparameters pOperacao" no proprio Click, porque ele

*-- Linhas 5900 a 5918:
5900:     *      insere UMA etiqueta de lote e deixa os cursores de item VAZIOS)
5901:     *      senao -> itens de SigMvHst (reimpressao por operacao de origem)
5902:     *   5. Scan dos itens montando dbImpressao
5903:     *   6. Update dbImpressao Set Pedido = crSigCdOpe.Abrevs
5904:     *   7. TpTlEtiqs = 2 -> SigOpIpE (por OPERACAO)  |  senao -> SigOpEtS
5905:     *
5906:     * MsgConfirma devolve LOGICO (regra CLAUDE.md #7) - nao se compara com 6.
5907:     *--------------------------------------------------------------------------
5908:     PROTECTED PROCEDURE CmdImprimirEtiquetasClickExec(par_cOperacao)
5909:         LOCAL loc_cOperacao, loc_cOperacaoNota, loc_nTpTlEtiqs, loc_cAbrev
5910: 
5911:         loc_cOperacaoNota = THIS.MontarChaveOperacaoNota()
5912: 
5913:         loc_cOperacao = IIF(!EMPTY(par_cOperacao), ALLTRIM(par_cOperacao), ;
5914:             loc_cOperacaoNota)
5915: 
5916:         IF EMPTY(loc_cOperacao)
5917:             MsgAviso("A nota ainda n" + CHR(227) + "o foi gravada - n" + CHR(227) + ;
5918:                 "o h" + CHR(225) + " itens para etiquetar.", ;

*-- Linhas 5935 a 5962:
5935: 
5936:         THIS.MontarEtiquetasDosItens()
5937: 
5938:         *-- "Update dbImpressao Set Pedido = crSigCdOpe.Abrevs". O valor vai
5939:         *-- para uma LOCAL antes: chamada de metodo no SET de um UPDATE-SQL
5940:         *-- do VFP nao e expressao confiavel, e a LOCAL tambem evita que o
5941:         *-- nome colida com coluna do proprio cursor.
5942:         loc_cAbrev = THIS.ObterAbreviacaoOperacao()
5943: 
5944:         SELECT dbImpressao
5945:         UPDATE dbImpressao SET Pedido = loc_cAbrev
5946: 
5947:         SELECT dbImpressao
5948:         GO TOP
5949: 
5950:         loc_nTpTlEtiqs = THIS.ObterConfigNumerica("SigOpCdd", "tptletiqs", "")
5951: 
5952:         IF loc_nTpTlEtiqs = 2
5953:             *-- "ThisForm.Tipo = [OPERACAO] / Do Form SigOpIpE With ThisForm, .t."
5954:             THIS.AvisarLegadoNaoPortado("tela SigOpIpE (etiquetas por opera" + ;
5955:                 CHR(231) + CHR(227) + "o)", ;
5956:                 "abrir a impress" + CHR(227) + "o de etiquetas por opera" + ;
5957:                 CHR(231) + CHR(227) + "o - o cursor de etiquetas foi montado " + ;
5958:                 "e tem " + TRANSFORM(RECCOUNT("dbImpressao")) + " linha(s)")
5959:         ELSE
5960:             THIS.AbrirTelaEtiquetasProduto()
5961:         ENDIF
5962: 

*-- Linhas 5970 a 5988:
5970:     *
5971:     * Chave POSICIONAL char(29) = Emps(3) + Dopes(20) + Str(Numes,6): montada
5972:     * com PADR nas partes de texto, NUNCA com ALLTRIM - ALLTRIM encurta a
5973:     * chave, ela nao casa com o EmpDopNums gravado e o SELECT dos itens
5974:     * devolve ZERO linha em silencio (regra CLAUDE.md #42). A soma das
5975:     * larguras (3 + 20 + 6 = 29) e a conferencia.
5976:     *--------------------------------------------------------------------------
5977:     PROTECTED FUNCTION MontarChaveOperacaoNota()
5978:         LOCAL loc_cChave, loc_oBO
5979:         loc_cChave = ""
5980: 
5981:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5982:             loc_oBO = THIS.this_oBusinessObject
5983: 
5984:             *-- Quando o BO ja guarda o EmpDopNums pronto, usa o valor dele:
5985:             *-- e exatamente a chave gravada, sem risco de remontagem.
5986:             IF !EMPTY(ALLTRIM(loc_oBO.this_cEmpDopNums))
5987:                 loc_cChave = loc_oBO.this_cEmpDopNums
5988:             ELSE

*-- Linhas 6018 a 6054:
6018: 
6019:         IF !USED("dbImpressao")
6020:             SET NULL ON
6021:             CREATE CURSOR dbImpressao ( ;
6022:                 CPros      C(14) NULL, ;
6023:                 Qtds       N(12, 3) NULL, ;
6024:                 QtdeEtiq   N(12, 3) NULL, ;
6025:                 Pedido     C(30) NULL, ;
6026:                 Obs        C(10) NULL, ;
6027:                 Moedas     C(3)  NULL, ;
6028:                 EmpDopNums C(29) NULL, ;
6029:                 PVens      N(15, 6) NULL, ;
6030:                 Pesos      N(12, 3) NULL, ;
6031:                 CItens     N(10, 0) NULL, ;
6032:                 CodTams    C(4)  NULL, ;
6033:                 CBars      N(14, 0) NULL)
6034:             SET NULL OFF
6035:         ELSE
6036:             loc_cSafety = SET("SAFETY")
6037:             SET SAFETY OFF
6038: 
6039:             SELECT dbImpressao
6040:             ZAP
6041: 
6042:             IF loc_cSafety = "ON"
6043:                 SET SAFETY ON
6044:             ENDIF
6045:         ENDIF
6046: 
6047:         IF !USED("dbImpressao")
6048:             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel preparar a " + ;
6049:                 "grade de etiquetas (dbImpressao).", ;
6050:                 "Impress" + CHR(227) + "o de Etiquetas")
6051:             loc_lOk = .F.
6052:         ENDIF
6053: 
6054:         RETURN loc_lOk

*-- Linhas 6084 a 6277:
6084:             loc_nCtrlLotes = 0
6085:             IF !EMPTY(loc_cDopes)
6086:                 loc_nCtrlLotes = THIS.ObterConfigNumerica("SigCdOpe", "ctrllotes", ;
6087:                     "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
6088:             ENDIF
6089:             loc_nIetiqs = THIS.ObterConfigNumerica("SigOpCdc", "ietiqs", "")
6090: 
6091:             IF INLIST(loc_nCtrlLotes, 1, 2) AND loc_nIetiqs = 1
6092:                 *-- Ramo (a): etiqueta de LOTE.
6093:                 THIS.InserirEtiquetaDeLote()
6094: 
6095:                 loc_lOk = THIS.CarregarListaOuVazio("crEesti", ;
6096:                     "SELECT * FROM SigMvItn WHERE 1 = 0")
6097:                 IF loc_lOk
6098:                     loc_lOk = THIS.CarregarListaOuVazio("crEsti2", ;
6099:                         "SELECT * FROM SigMvIts WHERE 1 = 0")
6100:                 ENDIF
6101:             ELSE
6102:                 *-- Ramo (b): itens da propria nota.
6103:                 loc_cSQL = "SELECT * FROM SigMvItn WHERE RTRIM(empdopnums) = " + ;
6104:                     EscaparSQL(loc_cBusca) + " ORDER BY citens"
6105:                 loc_lOk = THIS.CarregarListaOuVazio("crEesti", loc_cSQL)
6106: 
6107:                 IF loc_lOk
6108:                     loc_cSQL = "SELECT * FROM SigMvIts WHERE RTRIM(empdopnums) = " + ;
6109:                         EscaparSQL(loc_cBusca) + " ORDER BY citens"
6110:                     loc_lOk = THIS.CarregarListaOuVazio("crEsti2", loc_cSQL)
6111:                 ENDIF
6112:             ENDIF
6113:         ELSE
6114:             *-- Ramo (c): reimpressao a partir do historico.
6115:             loc_cSQL = "SELECT a.*, b.cunis AS cunis FROM SigMvHst a" + ;
6116:                 " INNER JOIN SigCdPro b ON RTRIM(b.cpros) = RTRIM(a.cpros)" + ;
6117:                 " WHERE RTRIM(a.oridopnums) = " + EscaparSQL(loc_cBusca) + ;
6118:                 " AND RTRIM(a.opers) = " + EscaparSQL("E")
6119:             loc_lOk = THIS.CarregarListaOuVazio("crEesti", loc_cSQL)
6120: 
6121:             IF loc_lOk
6122:                 loc_lOk = THIS.CarregarListaOuVazio("crEsti2", ;
6123:                     "SELECT * FROM SigMvIts WHERE 1 = 0")
6124:             ENDIF
6125:         ENDIF
6126: 
6127:         IF loc_lOk AND USED("crEsti2")
6128:             *-- "Select CrEsti2 / Index On Citens Tag Citens" do legado - o
6129:             *-- Scan adiante faz Seek por CItens neste cursor.
6130:             SELECT crEsti2
6131:             INDEX ON citens TAG citens
6132:         ENDIF
6133: 
6134:         RETURN loc_lOk
6135:     ENDFUNC
6136: 
6137:     *--------------------------------------------------------------------------
6138:     * CarregarListaOuVazio - igual a CarregarListaLookup, mas aceita ZERO
6139:     * linha como SUCESSO.
6140:     *
6141:     * Os cursores de etiqueta sao criados de proposito vazios em dois ramos do
6142:     * legado ("Where 0=1"), e tratar vazio como falha abortaria justamente a
6143:     * etiqueta de LOTE, que e a unica linha valida nesse caso.
6144:     *--------------------------------------------------------------------------
6145:     PROTECTED FUNCTION CarregarListaOuVazio(par_cCursor, par_cSQL)
6146:         LOCAL loc_nResultado, loc_lOk
6147:         loc_lOk = .F.
6148: 
6149:         THIS.FecharCursorTemporario(par_cCursor)
6150: 
6151:         loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
6152: 
6153:         IF loc_nResultado < 0
6154:             MsgErro("Falha ao consultar os itens da etiqueta." + CHR(13) + ;
6155:                 CapturarErroSQL(), "Erro SQL")
6156:         ELSE
6157:             loc_lOk = USED(par_cCursor)
6158:         ENDIF
6159: 
6160:         RETURN loc_lOk
6161:     ENDFUNC
6162: 
6163:     *--------------------------------------------------------------------------
6164:     * InserirEtiquetaDeLote - ramo de LOTE do ImpEtiqueta legado:
6165:     *
6166:     *   lnBar = Val( Str(crSigCdOpe.Ndopes,4) + Transf(crSigMvNfi.Numes,"@L 999999") )
6167:     *   lcObs = crSigCdOpe.Abrevs + "-" + Transf(crSigMvNfi.Numes,"@L 999999")
6168:     *   Insert Into dbImpressao (CPros, Qtds, Cbars, Obs)
6169:     *            Values (crSigCdPam.Ouros, 1, lnBar, lcObs)
6170:     *
6171:     * O codigo de barras e POSICIONAL: 4 digitos do Ndopes seguidos de 6 do
6172:     * numero do movimento, ambos com zero a esquerda ("@L" do TRANSFORM) -
6173:     * montar com ALLTRIM mudaria o numero gerado.
6174:     *--------------------------------------------------------------------------
6175:     PROTECTED PROCEDURE InserirEtiquetaDeLote()
6176:         LOCAL loc_cDopes, loc_nNdopes, loc_nNumes, loc_cAbrevs, loc_cOuros
6177:         LOCAL loc_cNumes, loc_nBar, loc_cObs, loc_cWhere
6178: 
6179:         loc_cDopes = ""
6180:         loc_nNumes = 0
6181: 
6182:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
6183:             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
6184:             loc_nNumes = THIS.this_oBusinessObject.this_nNumes
6185:         ENDIF
6186: 
6187:         loc_nNdopes = 0
6188:         loc_cAbrevs = ""
6189: 
6190:         IF !EMPTY(loc_cDopes)
6191:             loc_cWhere  = "RTRIM(dopes) = " + EscaparSQL(loc_cDopes)
6192:             loc_nNdopes = THIS.ObterConfigNumerica("SigCdOpe", "ndopes", loc_cWhere)
6193:             loc_cAbrevs = THIS.ObterAbreviacaoOperacao()
6194:         ENDIF
6195: 
6196:         loc_cOuros = THIS.ObterProdutoControleLote()
6197:         loc_cNumes = TRANSFORM(loc_nNumes, "@L 999999")
6198:         loc_nBar   = VAL(TRANSFORM(loc_nNdopes, "@L 9999") + loc_cNumes)
6199:         loc_cObs   = ALLTRIM(loc_cAbrevs) + "-" + loc_cNumes
6200: 
6201:         INSERT INTO dbImpressao (CPros, Qtds, CBars, Obs) ;
6202:             VALUES (loc_cOuros, 1, loc_nBar, LEFT(loc_cObs, 10))
6203:     ENDPROC
6204: 
6205:     *--------------------------------------------------------------------------
6206:     * ObterProdutoControleLote - crSigCdPam.Ouros, o produto de controle que
6207:     * o legado usa na etiqueta de lote. SigCdPam e tabela de parametro com
6208:     * uma linha so (o legado le direto do cursor, sem filtro).
6209:     *--------------------------------------------------------------------------
6210:     PROTECTED FUNCTION ObterProdutoControleLote()
6211:         LOCAL loc_cCursor, loc_cValor
6212:         loc_cCursor = "cursor_4c_PamFis"
6213:         loc_cValor  = ""
6214: 
6215:         IF THIS.CarregarListaLookup(loc_cCursor, "SELECT ouros FROM SigCdPam")
6216:             SELECT (loc_cCursor)
6217:             GO TOP
6218:             loc_cValor = THIS.LerColunaLookup(loc_cCursor, "ouros")
6219:         ENDIF
6220: 
6221:         THIS.FecharCursorTemporario(loc_cCursor)
6222: 
6223:         RETURN loc_cValor
6224:     ENDFUNC
6225: 
6226:     *--------------------------------------------------------------------------
6227:     * ObterAbreviacaoOperacao - crSigCdOpe.Abrevs, usado no "Update
6228:     * dbImpressao Set Pedido = crSigCdOpe.Abrevs" e na observacao do lote.
6229:     *--------------------------------------------------------------------------
6230:     PROTECTED FUNCTION ObterAbreviacaoOperacao()
6231:         LOCAL loc_cCursor, loc_cDopes, loc_cValor
6232:         loc_cCursor = "cursor_4c_AbrevFis"
6233:         loc_cValor  = ""
6234:         loc_cDopes  = ""
6235: 
6236:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
6237:             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
6238:         ENDIF
6239: 
6240:         IF !EMPTY(loc_cDopes)
6241:             IF THIS.CarregarListaLookup(loc_cCursor, ;
6242:                     "SELECT abrevs FROM SigCdOpe WHERE RTRIM(dopes) = " + ;
6243:                     EscaparSQL(loc_cDopes))
6244:                 SELECT (loc_cCursor)
6245:                 GO TOP
6246:                 loc_cValor = THIS.LerColunaLookup(loc_cCursor, "abrevs")
6247:             ENDIF
6248: 
6249:             THIS.FecharCursorTemporario(loc_cCursor)
6250:         ENDIF
6251: 
6252:         RETURN loc_cValor
6253:     ENDFUNC
6254: 
6255:     *--------------------------------------------------------------------------
6256:     * MontarEtiquetasDosItens - "Select crEesti / Scan ... Endscan" do
6257:     * ImpEtiqueta legado, transcrito com as mesmas condicoes:
6258:     *
6259:     *   If cursorQuery('SigCdUni','crSigCdUni','Cunis', CrEesti.Cunis)
6260:     *        And ( CrEesti.Opers = 'E' Or crSigOpCdd.EtqSaids = 1 )
6261:     *       ... Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads
6262:     *           From SigCdPro a Inner Join SigCdGrp b On b.cGrus = a.cGrus
6263:     *       If LocalPro.EtiPads = 'D' -> Loop     (grupo so por selecao)
6264:     *       _QtEtiq = crEesti.Qtds ; _QtPeso = CrEesti.Pesos
6265:     *       If crSigCdUni.pqtds='S' And crSigCdUni.Etiqs#'S'
6266:     *           _QtEtiq = 0 ; _QtPeso = 0 ; Do Form SigOpQtE With Cpros
6267:     *       If crSigCdUni.Etiqs = 'S'  -> por CODIGO DE BARRAS
6268:     *       Else                       -> por PRODUTO
6269:     *
6270:     * O "Do Form SigOpQtE" (que PERGUNTA ao usuario a quantidade por peso)
6271:     * nao foi migrado: ali o legado ZERA as duas quantidades e espera o
6272:     * dialogo devolve-las, entao seguir sem ele geraria etiqueta com
6273:     * quantidade ZERO em silencio. Por isso avisa e NAO insere a linha -
6274:     * regra CLAUDE.md #27 (ausencia visivel em vez de dado errado calado).
6275:     *--------------------------------------------------------------------------
6276:     PROTECTED PROCEDURE MontarEtiquetasDosItens()
6277:         LOCAL loc_nEtqSaids, loc_cCunis, loc_cPqtds, loc_cEtiqs, loc_cEtiPads

*-- Linhas 6286 a 6308:
6286:         loc_nEtqSaids  = THIS.ObterConfigNumerica("SigOpCdd", "etqsaids", "")
6287:         loc_lAvisouQtE = .F.
6288: 
6289:         SELECT crEesti
6290:         GO TOP
6291: 
6292:         *-- DO WHILE + SKIP, NAO Scan/Endscan: o corpo abaixo chama metodos
6293:         *-- que fazem SQLEXEC e INSERT, e cada um deles TROCA a work area
6294:         *-- corrente. Com Scan/Endscan, um LOOP depois dessa troca faria o
6295:         *-- ENDSCAN avancar o cursor ERRADO (ou nenhum) - laco infinito ou
6296:         *-- itens pulados, sem erro nenhum. O SKIP explicito nomeia o alias.
6297:         DO WHILE !EOF("crEesti")
6298:             loc_lPular = .F.
6299: 
6300:             loc_cCunis  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.cunis, "")))
6301:             loc_cCpros  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.cpros, "")))
6302:             loc_cOpers  = ALLTRIM(TRANSFORM(TratarNulo(crEesti.opers, "")))
6303:             loc_nQtEtiq = TratarNulo(crEesti.qtds, 0)
6304:             loc_nQtPeso = TratarNulo(crEesti.pesos, 0)
6305:             loc_nUnits  = TratarNulo(crEesti.units, 0)
6306:             loc_cMoedas = TratarNulo(crEesti.moedas, "")
6307:             loc_cEmpDop = TratarNulo(crEesti.empdopnums, "")
6308:             loc_nCitens = TratarNulo(crEesti.citens, 0)

*-- Linhas 6351 a 6454:
6351:                     IF loc_nCodBarras != 0
6352:                         THIS.PosicionarSubItemEtiqueta(loc_nCitens)
6353: 
6354:                         INSERT INTO dbImpressao (CPros, Qtds, QtdeEtiq, Pesos, Obs, ;
6355:                                 PVens, Moedas, EmpDopNums, CItens, CodTams) ;
6356:                             VALUES (STR(loc_nCodBarras, 14), 1, loc_nQtEtiq, ;
6357:                                 loc_nQtPeso, THIS.LerSubItemEtiqueta("codcors"), ;
6358:                                 loc_nUnits, loc_cMoedas, loc_cEmpDop, loc_nCitens, ;
6359:                                 THIS.LerSubItemEtiqueta("codtams"))
6360:                     ELSE
6361:                         *-- Sem codigo de barras no item: o legado desce para os
6362:                         *-- SUB-ITENS (tamanho/cor) e insere um por um.
6363:                         THIS.InserirEtiquetasDosSubItens(loc_nCitens, loc_nQtPeso, ;
6364:                             loc_nUnits, loc_cMoedas, loc_cEmpDop)
6365:                     ENDIF
6366:                 ELSE
6367:                     *-- Etiqueta por PRODUTO.
6368:                     THIS.PosicionarSubItemEtiqueta(loc_nCitens)
6369: 
6370:                     INSERT INTO dbImpressao (CPros, Qtds, Pesos, Obs, PVens, ;
6371:                             Moedas, EmpDopNums, CItens, CodTams) ;
6372:                         VALUES (loc_cCpros, loc_nQtEtiq, loc_nQtPeso, ;
6373:                             THIS.LerSubItemEtiqueta("codcors"), loc_nUnits, ;
6374:                             loc_cMoedas, loc_cEmpDop, loc_nCitens, ;
6375:                             THIS.LerSubItemEtiqueta("codtams"))
6376:                 ENDIF
6377:             ENDIF
6378: 
6379:             SKIP IN crEesti
6380:         ENDDO
6381: 
6382:         THIS.FecharCursorTemporario("cursor_4c_UniFis")
6383:     ENDPROC
6384: 
6385:     *--------------------------------------------------------------------------
6386:     * InserirEtiquetasDosSubItens - "Select crEsti2 / Seek CrEesti.Citens /
6387:     * Scan While crEsti2.CItens = CrEesti.Citens" do legado: uma etiqueta por
6388:     * sub-item (combinacao de tamanho/cor) que tenha codigo de barras.
6389:     *--------------------------------------------------------------------------
6390:     PROTECTED PROCEDURE InserirEtiquetasDosSubItens(par_nCitens, par_nQtPeso, ;
6391:             par_nUnits, par_cMoedas, par_cEmpDop)
6392:         LOCAL loc_nBarras, loc_nQtds, loc_cCodTams, loc_cCodCors
6393: 
6394:         IF !USED("crEsti2")
6395:             RETURN
6396:         ENDIF
6397: 
6398:         SELECT crEsti2
6399:         SET ORDER TO TAG citens
6400: 
6401:         IF !SEEK(par_nCitens, "crEsti2", "citens")
6402:             RETURN
6403:         ENDIF
6404: 
6405:         *-- DO WHILE + SKIP em vez de "Scan While": o INSERT troca a work area
6406:         *-- corrente, e o ENDSCAN avancaria o cursor errado.
6407:         DO WHILE !EOF("crEsti2") AND TratarNulo(crEsti2.citens, 0) = par_nCitens
6408:             loc_nBarras  = TratarNulo(crEsti2.codbarras, 0)
6409:             loc_nQtds    = TratarNulo(crEsti2.qtds, 0)
6410:             loc_cCodTams = TratarNulo(crEsti2.codtams, "")
6411:             loc_cCodCors = TratarNulo(crEsti2.codcors, "")
6412: 
6413:             IF loc_nBarras != 0
6414:                 INSERT INTO dbImpressao (CPros, Qtds, QtdeEtiq, CodTams, Obs, ;
6415:                         PVens, Pesos, Moedas, EmpDopNums, CItens) ;
6416:                     VALUES (STR(loc_nBarras, 14), 1, loc_nQtds, loc_cCodTams, ;
6417:                         loc_cCodCors, par_nUnits, par_nQtPeso, par_cMoedas, ;
6418:                         par_cEmpDop, par_nCitens)
6419:             ENDIF
6420: 
6421:             SKIP IN crEsti2
6422:         ENDDO
6423:     ENDPROC
6424: 
6425:     *--------------------------------------------------------------------------
6426:     * PosicionarSubItemEtiqueta - "Select crEsti2 / Seek CrEesti.Citens" que o
6427:     * legado faz ANTES de inserir, para que crEsti2.CodCors/CodTams usados no
6428:     * Insert sejam os do item corrente.
6429:     *
6430:     * Recebe o CItens por parametro em vez de ler crEesti: quem chama esta
6431:     * dentro de um laco e ja capturou o valor, e assim este metodo nao depende
6432:     * de qual alias esta selecionado no momento da chamada.
6433:     *--------------------------------------------------------------------------
6434:     PROTECTED PROCEDURE PosicionarSubItemEtiqueta(par_nCitens)
6435:         IF !USED("crEsti2")
6436:             RETURN
6437:         ENDIF
6438: 
6439:         SELECT crEsti2
6440:         SET ORDER TO TAG citens
6441:         =SEEK(par_nCitens, "crEsti2", "citens")
6442:     ENDPROC
6443: 
6444:     *--------------------------------------------------------------------------
6445:     * LerSubItemEtiqueta - le uma coluna de crEsti2 na linha em que ele esta
6446:     * posicionado, devolvendo "" quando o cursor nao tem a linha (os dois
6447:     * ramos "Where 0=1" do legado deixam crEsti2 vazio de proposito).
6448:     *--------------------------------------------------------------------------
6449:     PROTECTED FUNCTION LerSubItemEtiqueta(par_cCampo)
6450:         LOCAL loc_cValor
6451:         loc_cValor = ""
6452: 
6453:         IF USED("crEsti2")
6454:             IF !EOF("crEsti2") AND TYPE("crEsti2." + par_cCampo) != "U"

*-- Linhas 6467 a 6513:
6467:     *--------------------------------------------------------------------------
6468:     PROTECTED FUNCTION CarregarConfigUnidade(par_cCunis)
6469:         RETURN THIS.CarregarListaLookup("cursor_4c_UniFis", ;
6470:             "SELECT cunis, pqtds, etiqs FROM SigCdUni WHERE RTRIM(cunis) = " + ;
6471:             EscaparSQL(ALLTRIM(par_cCunis)))
6472:     ENDFUNC
6473: 
6474:     *--------------------------------------------------------------------------
6475:     * ObterEtiquetaPadraoGrupo - SigCdGrp.etipads do grupo do produto:
6476:     *
6477:     *   Select a.Cpros, a.Cgrus, b.nTipoJoals, b.etipads
6478:     *     From SigCdPro a Inner Join SigCdGrp b on b.cGrus = a.cGrus
6479:     *    Where a.Cpros = '<cpros>'
6480:     *
6481:     * O legado aborta o processo inteiro quando essa consulta nao traz linha
6482:     * ("Favor Reiniciar o Processo!!!" + Return 0). Aqui devolve "" e o
6483:     * chamador trata: abortar o Scan por um produto sem grupo deixaria as
6484:     * etiquetas dos OUTROS itens sem gerar, o que e pior do que pular um.
6485:     *--------------------------------------------------------------------------
6486:     PROTECTED FUNCTION ObterEtiquetaPadraoGrupo(par_cCpros)
6487:         LOCAL loc_cCursor, loc_cValor, loc_cSQL
6488:         loc_cCursor = "cursor_4c_GrpFis"
6489:         loc_cValor  = ""
6490: 
6491:         IF !EMPTY(par_cCpros)
6492:             loc_cSQL = "SELECT a.cpros, a.cgrus, b.ntipojoals, b.etipads" + ;
6493:                 " FROM SigCdPro a INNER JOIN SigCdGrp b" + ;
6494:                 " ON RTRIM(b.cgrus) = RTRIM(a.cgrus)" + ;
6495:                 " WHERE RTRIM(a.cpros) = " + EscaparSQL(ALLTRIM(par_cCpros))
6496: 
6497:             IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
6498:                 SELECT (loc_cCursor)
6499:                 GO TOP
6500:                 loc_cValor = THIS.LerColunaLookup(loc_cCursor, "etipads")
6501:             ENDIF
6502: 
6503:             THIS.FecharCursorTemporario(loc_cCursor)
6504:         ENDIF
6505: 
6506:         RETURN loc_cValor
6507:     ENDFUNC
6508: 
6509:     *--------------------------------------------------------------------------
6510:     * AbrirTelaEtiquetasProduto - "Do Form SigOpEtS With ThisForm,
6511:     * ThisForm.DataSessionId" do legado.
6512:     *
6513:     * SigOpEtS JA foi migrado como Formsigopets, com a MESMA assinatura

*-- Linhas 6704 a 6722:
6704: 
6705:         IF !EMPTY(loc_cDopes)
6706:             loc_nValor = THIS.ObterConfigNumerica("SigCdOpe", "cupfis", ;
6707:                 "RTRIM(dopes) = " + EscaparSQL(loc_cDopes))
6708:         ENDIF
6709: 
6710:         RETURN loc_nValor
6711:     ENDFUNC
6712: 
6713:     *--------------------------------------------------------------------------
6714:     * ObterPastaEmpresaNfe / ObterPastaNfe / ObterLogotipoNfe - leem
6715:     * SigCdEmp (pastas, logonfe) da empresa da nota.
6716:     *
6717:     * O legado usa a pasta de duas formas: crua (onde fica o unidanfe.exe) e
6718:     * com o sufixo "TXT\", onde gravam os arquivos da NFe - as duas aparecem
6719:     * no mesmo Click ("ALLTRIM(localEmp.pastas) + [TXT\]" e
6720:     * "ALLTRIM(localEmp.pastas) + 'unidanfe.exe'").
6721:     *--------------------------------------------------------------------------
6722:     PROTECTED FUNCTION ObterPastaEmpresaNfe()

*-- Linhas 6771 a 6814:
6771:     ENDFUNC
6772: 
6773:     *--------------------------------------------------------------------------
6774:     * CarregarConfigEmpresaNfe - "Select servs, emailnfe, senhas, pastas,
6775:     * textonfe, portas From SigCdEmp Where CEmps = '<cemps da nota>'" do
6776:     * legado, mais logonfe (que o Fwbtnm1 tambem le).
6777:     *
6778:     * SigCdEmp usa cemps (COM o C) para o codigo da empresa, enquanto
6779:     * SigMvNfi usa emps (SEM o C): conferido em docs/schema.sql, o prefixo da
6780:     * tabela NAO decide (regra CLAUDE.md #48).
6781:     *--------------------------------------------------------------------------
6782:     PROTECTED FUNCTION CarregarConfigEmpresaNfe(par_cCursor)
6783:         LOCAL loc_cEmps, loc_cSQL, loc_lOk
6784:         loc_lOk   = .F.
6785:         loc_cEmps = ""
6786: 
6787:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
6788:             loc_cEmps = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
6789:         ENDIF
6790: 
6791:         IF !EMPTY(loc_cEmps)
6792:             loc_cSQL = "SELECT servs, emailnfe, senhas, pastas, textonfe," + ;
6793:                 " portas, logonfe FROM SigCdEmp WHERE RTRIM(cemps) = " + ;
6794:                 EscaparSQL(loc_cEmps)
6795: 
6796:             loc_lOk = THIS.CarregarListaLookup(par_cCursor, loc_cSQL)
6797: 
6798:             IF loc_lOk
6799:                 SELECT (par_cCursor)
6800:                 GO TOP
6801:             ENDIF
6802:         ENDIF
6803: 
6804:         RETURN loc_lOk
6805:     ENDFUNC
6806: 
6807:     *--------------------------------------------------------------------------
6808:     * GravarArquivoNfe - "=StrToFile(ALLTRIM(<blob>), <arquivo>)" do legado,
6809:     * com confirmacao de que o arquivo saiu.
6810:     *--------------------------------------------------------------------------
6811:     PROTECTED FUNCTION GravarArquivoNfe(par_cCaminho, par_cConteudo)
6812:         LOCAL loc_lOk
6813:         loc_lOk = .F.
6814: 

*-- Linhas 6821 a 6839:
6821:     ENDFUNC
6822: 
6823:     *--------------------------------------------------------------------------
6824:     * ApagarArquivosAnteriores - "DELETE file &lcArq" do legado (mascara com
6825:     * curinga). ERASE nao aceita mascara em variavel sem macro, e falha de
6826:     * exclusao nao pode abortar a reimpressao - por isso o TRY proprio com
6827:     * CATCH que informa (CATCH nunca silencioso, regra CLAUDE.md #9).
6828:     *--------------------------------------------------------------------------
6829:     PROTECTED PROCEDURE ApagarArquivosAnteriores(par_cMascara)
6830:         LOCAL loc_oErro, loc_cSafety
6831: 
6832:         IF EMPTY(par_cMascara)
6833:             RETURN
6834:         ENDIF
6835: 
6836:         loc_cSafety = SET("SAFETY")
6837:         SET SAFETY OFF
6838: 
6839:         TRY

*-- Linhas 7025 a 7043:
7025:     ENDFUNC
7026: 
7027:     *--------------------------------------------------------------------------
7028:     * ObterEmailCliente - "Select emails From SigCdCli Where Iclis =
7029:     * '<crSigMvNfi.clifors>'" do Fwbtnm2 legado.
7030:     *
7031:     * clifors e char(20) em SigMvNfi e iclis e char(10) em SigCdCli: a
7032:     * comparacao vai por RTRIM nos dois lados, como nas outras consultas
7033:     * deste form.
7034:     *--------------------------------------------------------------------------
7035:     PROTECTED FUNCTION ObterEmailCliente()
7036:         LOCAL loc_cCursor, loc_cCursorNota, loc_cCliente, loc_cEmail
7037:         loc_cCursor     = "cursor_4c_CliFis"
7038:         loc_cCursorNota = "cursor_4c_CliNota"
7039:         loc_cEmail      = ""
7040:         loc_cCliente    = ""
7041: 
7042:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
7043:             loc_cCliente = ALLTRIM(THIS.this_oBusinessObject.this_cClifors)

*-- Linhas 7052 a 7072:
7052: 
7053:         IF !EMPTY(loc_cCliente)
7054:             IF THIS.CarregarListaLookup(loc_cCursor, ;
7055:                     "SELECT emails FROM SigCdCli WHERE RTRIM(iclis) = " + ;
7056:                     EscaparSQL(loc_cCliente))
7057:                 SELECT (loc_cCursor)
7058:                 GO TOP
7059:                 loc_cEmail = ALLTRIM(THIS.LerColunaLookup(loc_cCursor, "emails"))
7060:             ENDIF
7061: 
7062:             THIS.FecharCursorTemporario(loc_cCursor)
7063:         ENDIF
7064: 
7065:         RETURN loc_cEmail
7066:     ENDFUNC
7067: 
7068:     *==========================================================================
7069:     * BOTOES "Cancela Nota" / "Carta de Correcao" (legado Fwbtnm3 / Fwbtnm4)
7070:     *==========================================================================
7071: 
7072:     *--------------------------------------------------------------------------

*-- Linhas 7411 a 7463:
7411:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cCFis))
7412:                     loc_oBO.this_cDClFiscal = THIS.ConsultarColunaUnica( ;
7413:                         "CASE WHEN LTRIM(RTRIM(ISNULL(desc2s,''))) = '' THEN descricaos ELSE desc2s END", ;
7414:                         "SigCdCfo", "codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCFis)))
7415:                 ENDIF
7416: 
7417:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cCfoSubs))
7418:                     loc_oBO.this_cDCfoSubs = THIS.ConsultarColunaUnica( ;
7419:                         "CASE WHEN LTRIM(RTRIM(ISNULL(desc2s,''))) = '' THEN descricaos ELSE desc2s END", ;
7420:                         "SigCdCfo", "codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cCfoSubs)))
7421:                 ENDIF
7422: 
7423:                 *-- Transportadora (mesma fonte do lookup -
7424:                 *-- AbrirLookupTransportadoraExec).
7425:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cCodTrans))
7426:                     loc_cCursor = "cursor_4c_CarregaTrp"
7427:                     loc_cSQL = "SELECT razaos, endes, cidas, estas FROM SigPrTrp WHERE itras = " + ;
7428:                         EscaparSQL(ALLTRIM(loc_oBO.this_cCodTrans))
7429: 
7430:                     IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
7431:                         loc_oBO.this_cDTransp   = THIS.LerColunaLookup(loc_cCursor, "razaos")
7432:                         loc_oBO.this_cEndTransp = THIS.LerColunaLookup(loc_cCursor, "endes")
7433:                         loc_oBO.this_cCidTransp = THIS.LerColunaLookup(loc_cCursor, "cidas")
7434:                         loc_oBO.this_cUfTransp  = THIS.LerColunaLookup(loc_cCursor, "estas")
7435:                     ENDIF
7436: 
7437:                     THIS.FecharCursorTemporario(loc_cCursor)
7438:                 ENDIF
7439: 
7440:                 *-- Municipio/UF da prestacao de servico - restaurados a partir
7441:                 *-- do codigo IBGE persistido (this_cPrestservs, mesma fonte do
7442:                 *-- lookup - AbrirLookupMunicipioExec); UF/Municipio da tela sao
7443:                 *-- so exibicao (ControlSource = "" no dump).
7444:                 IF !EMPTY(ALLTRIM(loc_oBO.this_cPrestservs))
7445:                     loc_cCursor = "cursor_4c_CarregaMun"
7446:                     loc_cSQL = "SELECT a.descs AS munici, b.estados AS estados" + ;
7447:                         " FROM SigCdMun a INNER JOIN SigCdUfs b ON a.ufibges = b.UFIBGEs" + ;
7448:                         " WHERE a.codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cPrestservs))
7449: 
7450:                     IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
7451:                         loc_oBO.this_cMunServ = THIS.LerColunaLookup(loc_cCursor, "munici")
7452:                         loc_oBO.this_cUfServ  = THIS.LerColunaLookup(loc_cCursor, "estados")
7453:                     ENDIF
7454: 
7455:                     THIS.FecharCursorTemporario(loc_cCursor)
7456:                 ENDIF
7457:             ENDIF
7458:         CATCH TO loc_oErro
7459:             MsgErro(loc_oErro.Message + CHR(13) + ;
7460:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
7461:                 "Procedure: " + loc_oErro.Procedure, "Erro em PreencherDescricoesDerivadas")
7462:         ENDTRY
7463:     ENDPROC

*-- Linhas 7473 a 7491:
7473:         loc_cValor  = ""
7474:         loc_cCursor = "cursor_4c_ColUnica"
7475: 
7476:         loc_cSQL = "SELECT " + par_cExpressao + " AS valorunico FROM " + par_cTabela
7477:         IF VARTYPE(par_cWhere) = "C" AND !EMPTY(par_cWhere)
7478:             loc_cSQL = loc_cSQL + " WHERE " + par_cWhere
7479:         ENDIF
7480: 
7481:         IF THIS.CarregarListaLookup(loc_cCursor, loc_cSQL)
7482:             loc_cValor = THIS.LerColunaLookup(loc_cCursor, "valorunico")
7483:         ENDIF
7484: 
7485:         THIS.FecharCursorTemporario(loc_cCursor)
7486: 
7487:         RETURN loc_cValor
7488:     ENDFUNC
7489: 
7490:     *--------------------------------------------------------------------------
7491:     * CopiarControleParaBO / CopiarBOParaControle - par generico que liga UM

*-- Linhas 7515 a 7544:
7515: 
7516:     *--------------------------------------------------------------------------
7517:     * FormParaBO - espelha TODOS os controles ligados a crSigMvNfi (dump
7518:     * legado - ver ControlSource de cada objeto em
7519:     * tasks/task742/sigopfis_form_codigo_fonte.txt) nas properties do
7520:     * sigopfisBO, na mesma ordem dos blocos de ConfigurarCamposForm()/
7521:     * ConfigurarPaginaNotaFiscal()/ConfigurarPaginaServicos(). Chamado pelo
7522:     * BtnConfirmarClickExec logo antes de Salvar().
7523:     *
7524:     * NAO mapeados (por desenho, nao por omissao):
7525:     *   - txt_4c_PFrtIpi/PFrtIcm/PSegIpi/PSegIcm/PDesIpi/PDesIcm: percentuais
7526:     *     TRANSIENTES do dump (ControlSource = "" no legado) - so alimentam os
7527:     *     calculos de ConfigurarEventosCalculo(), nunca sao gravados.
7528:     *   - txt_4c_Set_total (Pagina Servicos): soma exibida, ControlSource="".
7529:     *   - txt_4c_Uf/txt_4c_Mun (Pagina Servicos): ControlSource="" no legado -
7530:     *     so this_cPrestservs (IBGE) e persistido, via AbrirLookupMunicipioExec.
7531:     *--------------------------------------------------------------------------
7532:     PROTECTED PROCEDURE FormParaBO()
7533:         LOCAL loc_oErro, loc_oTxt, loc_nSoma
7534: 
7535:         TRY
7536:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
7537: 
7538:             *-- Campos diretos do form
7539:             THIS.CopiarControleParaBO("txt_4c_Serie",     "this_cSeries")
7540:             THIS.CopiarControleParaBO("txt_4c_Nota",      "this_cNFis")
7541:             THIS.CopiarControleParaBO("txt_4c_Especie",   "this_cEspecieNFs")
7542:             THIS.CopiarControleParaBO("txt_4c_Emissao",   "this_dEmis")
7543:             THIS.CopiarControleParaBO("txt_4c_Saidas",    "this_dDtSaidas")
7544:             THIS.CopiarControleParaBO("txt_4c_Selo",      "this_nSelos")


### BO (C:\4c\projeto\app\classes\sigopfisBO.prg):
*============================================================================
* sigopfisBO.prg - Business Object para Dados Fiscais da Nota Fiscal
*
* Tabela principal : SigMvNfi  (PK: cidchaves char(20))
* Ligacao mestre    : SigMvCab (FK composta: EmpDopNums char(29) = Emps+Dopes+Str(Numes,6))
* Lookup transporte  : SigPrTrp (PK: Itras,  desc: Razaos)
* Lookup CFO         : SigCdCfo (PK: Codigos)
* Lookup UF/Municipio : SigCdUfs (PK: Estados), SigCdMun (PK: Codigos/Munici)
* Lookup beneficio    : SigCdBfj / crBeneficioRJ (PK: codigos, desc: descrs)
* Lookup servico mun. : crSrvMuns (PK: codigos, desc: descrs)
*
* Este BO representa a aba "Dados Fiscais"/"Servicos" de uma Nota Fiscal,
* embutida como sub-pagina de um form de movimentacao maior (SigOpMvi e
* similares). O registro de SigMvNfi e gravado pelo form PAI (TableUpdate do
* cursor principal); este BO fornece as propriedades e as regras de calculo
* fiscal (impostos, servicos) referentes ao mesmo registro.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopfisBO AS BusinessBase

    *==========================================================================
    * Chave e ligacao com o movimento (SigMvCab) - cidchaves eh a PK de SigMvNfi;
    * EmpDopNums (Emps+Dopes+Str(Numes,6)) e a chave composta que liga ao
    * cabecalho do movimento (regra #42: NUNCA ALLTRIM nas partes internas).
    *==========================================================================
    this_cCidchaves  = ""   && char(20) - PK
    this_cEmpDopNums = ""   && char(29) - Emps(3) + Dopes(20) + Str(Numes,6)
    this_cEmps       = ""   && char(3)  - Empresa do movimento
    this_cDopes      = ""   && char(20) - Documento de operacao
    this_nNumes      = 0    && numeric(6,0) - Numero sequencial do movimento

    *==========================================================================
    * Cabecalho da Nota (Pagina Impostos - topo do form)
    *==========================================================================
    this_cNFis       = ""   && char(6)  - Numero da nota fiscal
    this_cSeries     = ""   && char(8)  - Serie da nota
    this_cEspecieNFs = ""   && char(6)  - Especie da nota
    this_dEmis       = {}   && datetime NULL - Data de emissao
    this_nSelos      = 0    && numeric(10,0) - Numero do selo fiscal
    this_dDtSaidas   = {}   && datetime NULL - Data de saida
    this_cCFis       = ""   && char(10) - CFOP de movimentacao
    this_cCfoSubs    = ""   && char(10) - CFOP de substituicao

    *==========================================================================
    * Impostos - IPI / ICMS (bases e valores)
    *==========================================================================
    this_nBasecIpis   = 0   && numeric(14,2) - Base de calculo do IPI
    this_nValIpis     = 0   && numeric(14,2) - Valor do IPI
    this_nBasecIcms   = 0   && numeric(14,2) - Base de calculo do ICMS
    this_nValIcms     = 0   && numeric(14,2) - Valor do ICMS
    this_nTotProds    = 0   && numeric(14,2) - Total dos produtos
    this_nTotNotas    = 0   && numeric(14,2) - Total da nota fiscal

    *==========================================================================
    * Impostos - Substituicao / Isento / Outras bases (ICMS e IPI)
    *==========================================================================
    this_nBcicmss      = 0  && numeric(15,2) - Base substituicao ICMS
    this_nIcmss        = 0  && numeric(15,2) - Valor substituicao ICMS
    this_nBasecic2s    = 0  && numeric(14,2) - Base ICMS isento
    this_nBasecic3s    = 0  && numeric(14,2) - Base ICMS outras
    this_nBasecIp2s    = 0  && numeric(14,2) - Base IPI isento
    this_nBasecip3s    = 0  && numeric(14,2) - Base IPI outras
    this_nIpiNCreds    = 0  && numeric(14,2) - IPI nao creditado

    *==========================================================================
    * Frete / Seguro / Despesas acessorias (valores e percentuais/bases ICMS/IPI)
    *==========================================================================
    this_nVlFretes   = 0    && numeric(14,2) - Valor do frete
    this_nVlSeguros  = 0    && numeric(14,2) - Valor do seguro
    this_nDespAces   = 0    && numeric(14,2) - Despesas acessorias
    this_nFrtIcms    = 0    && numeric(15,2) - ICMS sobre frete
    this_nFrtIpis    = 0    && numeric(15,2) - IPI sobre frete
    this_nSegIcms    = 0    && numeric(15,2) - ICMS sobre seguro
    this_nSegIpis    = 0    && numeric(15,2) - IPI sobre seguro
    this_nDesIcms    = 0    && numeric(15,2) - ICMS sobre despesas
    this_nDesIpis    = 0    && numeric(15,2) - IPI sobre despesas
    this_cObsFretes  = ""   && char(10) - Observacao do frete (preenchida quando % = 0)
    this_cObspliqs   = ""   && char(10) - Observacao peso liquido
    this_cObspbrus   = ""   && char(10) - Observacao peso bruto

    *==========================================================================
    * Transporte / Volumes
    *==========================================================================
    this_cCodTrans = ""     && char(10) - Codigo do transportador (SigPrTrp.Itras)
    this_nFretes   = 0      && numeric(1,0) - Modo de frete (ComboBox - indice 1-based)
    this_cPlacas   = ""     && char(8)  - Placa do veiculo
    this_cUfPlacas = ""     && char(2)  - UF da placa
    this_nQtdes    = 0      && numeric(6,0) - Quantidade de volumes
    this_cEspes    = ""     && char(10) - Especie dos volumes
    this_cMarcas   = ""     && char(10) - Marca dos volumes
    this_cNumeros  = ""     && char(10) - Numeracao dos volumes
    this_nPLiqs    = 0      && numeric(10,3) NULL - Peso liquido
    this_nPBrus    = 0      && numeric(10,3) NULL - Peso bruto
    this_cObss     = ""     && char(40) - Observacoes gerais

    *==========================================================================
    * NFe - Chave de acesso / DI (Declaracao de Importacao)
    *==========================================================================
    this_cNfechv  = ""      && char(44) - Chave de acesso da NFe
    this_cNfechvc = ""      && char(44) - Chave de acesso da NFe referenciada (NFe complementar)
    this_cNdis    = ""      && char(10) - Numero da DI
    this_dDregdis = {}      && datetime NULL - Data de registro da DI
    this_dDdesembs = {}     && datetime NULL - Data de desembaraco da DI

    *==========================================================================
    * Servicos (ISS/Simples Nacional - Pagina Servicos)
    *==========================================================================
    this_nTptribsers  = 0   && numeric(2,0) - Tipo de tributacao de servicos (RECNO de crTpTrib)
    this_cCodbenefs   = ""  && char(3)  - Codigo do beneficio fiscal
    this_cCodsrvfis   = ""  && char(6)  - Codigo do servico municipal
    this_nVdeducoes   = 0   && numeric(15,2) - Deducoes
    this_nVdscconds   = 0   && numeric(15,2) - Desconto condicionado
    this_nVdsciconds  = 0   && numeric(15,2) - Desconto incondicionado
    this_nOutretens   = 0   && numeric(15,2) - Outras retencoes
    this_nIssretidos  = 0   && numeric(1,0) - ISS retido (OptionGroup - indice 1-based)
    this_cTiponfs     = ""  && char(2)  - Tipo de nota (convencional/NFCe)
    this_nVtotiss     = 0   && numeric(14,2) - Total ISS (campo Fwget1)
    this_nVirf        = 0   && numeric(14,2) - Total IRRF (campo Fwget2)
    this_nVinss       = 0   && numeric(14,2) - Total INSS (campo Fwget3)
    this_nVpis        = 0   && numeric(14,2) - Total PIS (campo Fwget4)
    this_nVcsll       = 0   && numeric(14,2) - Total CSLL (campo Fwget5)
    this_nVcofins     = 0   && numeric(14,2) - Total COFINS (campo Fwget6)

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas diretamente no banco
    * (resultado de lookup, usados so para preencher a descricao na tela)
    *==========================================================================
    this_cDClFiscal  = ""   && Descricao do CFOP de movimentacao (SigCdCfo)
    this_cDCfoSubs   = ""   && Descricao do CFOP de substituicao (SigCdCfo)
    this_cDTransp    = ""   && Razao social do transportador (SigPrTrp.Razaos)
    this_cEndTransp  = ""   && Endereco do transportador
    this_cCidTransp  = ""   && Cidade do transportador
    this_cUfTransp   = ""   && UF do transportador
    this_cUfServ     = ""   && UF do local da prestacao de servico (Servicos)
    this_cMunServ    = ""   && Municipio da prestacao de servico (Servicos)
    this_cDCodbenefs = ""   && Descricao do beneficio fiscal
    this_cDCodsrvfis = ""   && Descricao do servico municipal

    *==========================================================================
    * Colunas NOT NULL de SigMvNfi sem controle correspondente na tela (nao
    * citadas em layout.json/comportamento.json) - mantidas como propriedades,
    * e nao como literal fixo no SQL, para o valor gravado por outra rotina
    * (ex.: Cancela Nota / Carta de Correcao) nao ser PERDIDO no proximo
    * Atualizar() desta aba (regra CLAUDE.md #22 - INSERT/UPDATE tem de cobrir
    * toda coluna NOT NULL do schema, nunca so as citadas no dump do legado).
    *==========================================================================
    this_lCancelas     = .F.  && cancelas bit - nota cancelada
    this_cClfis        = ""   && clfis char(12)
    this_cClifors      = ""   && clifors char(20)
    this_cCodcons      = ""   && codcons char(9)
    this_cConds        = ""   && conds char(12)
    this_nIcms         = 0    && icms numeric(4,2) - aliquota ICMS
    this_nImpress      = 0    && impress numeric(6,0)
    this_nIpis         = 0    && ipis numeric(4,2) - aliquota IPI
    this_cObs2s        = ""   && obs2s char(40)
    this_cOperas       = ""   && operas char(1) - E/S
    this_nPerciss      = 0    && perciss numeric(5,2)
    this_nPesos        = 0    && pesos numeric(7,2)
    this_lRegs         = .F.  && regs bit
    this_nVals         = 0    && vals numeric(14,2)
    this_nVtotsers     = 0    && vtotsers numeric(14,2)
    this_cCgcs         = ""   && cgcs char(21)
    this_lCorrecs      = .F.  && correcs bit - carta de correcao emitida
    this_cLocals       = ""   && locals char(10)
    this_nNtrans       = 0    && ntrans numeric(6,0)
    this_cCodservs     = ""   && codservs char(10)
    this_cDescservs    = ""   && descservs char(40)
    this_nChkenvias    = 0    && chkenvias numeric(1,0)
    this_nLoterps      = 0    && loterps numeric(6,0)
    this_nNumrps       = 0    && numrps numeric(12,0)
    this_nPcofins      = 0    && pcofins numeric(5,2)
    this_nPcsll        = 0    && pcsll numeric(5,2)
    this_nPinss        = 0    && pinss numeric(5,2)
    this_nPirf         = 0    && pirf numeric(5,2)
    this_nPpis         = 0    && ppis numeric(5,2)
    this_cSerierps     = ""   && serierps char(5)
    this_cTiporps      = ""   && tiporps char(5)
    this_nValiis       = 0    && valiis numeric(14,2)
    this_cNfeprt       = ""   && nfeprt char(15)
    this_cChnfes       = ""   && chnfes char(44)
    this_cPrestservs   = ""   && prestservs char(7)
    this_nVfcpst       = 0    && vfcpst numeric(14,2)
    this_cNumeroNota   = ""   && NumeroNota char(10)
    this_nChkrastreio  = 0    && chkrastreio numeric(1,0)
    this_cChaveExterna = ""   && chaveexterna char(33)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvNfi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SigMvNfi) para
    * as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de acessar
    * os campos (regra #8/CLAUDE.md) - nunca campo.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)

                THIS.this_cNFis       = TratarNulo(nfis, "")
                THIS.this_cSeries     = TratarNulo(series, "")
                THIS.this_cEspecieNFs = TratarNulo(especienfs, "")
                THIS.this_dEmis       = TratarNulo(emis, {})
                THIS.this_nSelos      = TratarNulo(selos, 0)
                THIS.this_dDtSaidas   = TratarNulo(dtsaidas, {})
                THIS.this_cCFis       = TratarNulo(cfis, "")
                THIS.this_cCfoSubs    = TratarNulo(cfosubs, "")

                THIS.this_nBasecIpis  = TratarNulo(basecipis, 0)
                THIS.this_nValIpis    = TratarNulo(valipis, 0)
                THIS.this_nBasecIcms  = TratarNulo(basecicms, 0)
                THIS.this_nValIcms    = TratarNulo(valicms, 0)
                THIS.this_nTotProds   = TratarNulo(totprods, 0)
                THIS.this_nTotNotas   = TratarNulo(totnotas, 0)

                THIS.this_nBcicmss    = TratarNulo(bcicmss, 0)
                THIS.this_nIcmss      = TratarNulo(icmss, 0)
                THIS.this_nBasecic2s  = TratarNulo(basecic2s, 0)
                THIS.this_nBasecic3s  = TratarNulo(basecic3s, 0)
                THIS.this_nBasecIp2s  = TratarNulo(basecip2s, 0)
                THIS.this_nBasecip3s  = TratarNulo(basecip3s, 0)
                THIS.this_nIpiNCreds  = TratarNulo(ipincreds, 0)

                THIS.this_nVlFretes   = TratarNulo(vlfretes, 0)
                THIS.this_nVlSeguros  = TratarNulo(vlseguros, 0)
                THIS.this_nDespAces   = TratarNulo(despaces, 0)
                THIS.this_nFrtIcms    = TratarNulo(frticms, 0)
                THIS.this_nFrtIpis    = TratarNulo(frtipis, 0)
                THIS.this_nSegIcms    = TratarNulo(segicms, 0)
                THIS.this_nSegIpis    = TratarNulo(segipis, 0)
                THIS.this_nDesIcms    = TratarNulo(desicms, 0)
                THIS.this_nDesIpis    = TratarNulo(desipis, 0)
                THIS.this_cObsFretes  = TratarNulo(obsfretes, "")
                THIS.this_cObspliqs   = TratarNulo(obspliqs, "")
                THIS.this_cObspbrus   = TratarNulo(obspbrus, "")

                THIS.this_cCodTrans   = TratarNulo(codtrans, "")
                THIS.this_nFretes     = TratarNulo(fretes, 0)
                THIS.this_cPlacas     = TratarNulo(placas, "")
                THIS.this_cUfPlacas   = TratarNulo(ufplacas, "")
                THIS.this_nQtdes      = TratarNulo(qtdes, 0)
                THIS.this_cEspes      = TratarNulo(espes, "")
                THIS.this_cMarcas     = TratarNulo(marcas, "")
                THIS.this_cNumeros    = TratarNulo(numeros, "")
                THIS.this_nPLiqs      = TratarNulo(pliqs, 0)
                THIS.this_nPBrus      = TratarNulo(pbrus, 0)
                THIS.this_cObss       = TratarNulo(obss, "")

                THIS.this_cNfechv     = TratarNulo(nfechv, "")
                THIS.this_cNfechvc    = TratarNulo(nfechvc, "")
                THIS.this_cNdis       = TratarNulo(ndis, "")
                THIS.this_dDregdis    = TratarNulo(dregdis, {})
                THIS.this_dDdesembs   = TratarNulo(ddesembs, {})

                THIS.this_nTptribsers  = TratarNulo(tptribsers, 0)
                THIS.this_cCodbenefs   = TratarNulo(codbenefs, "")
                THIS.this_cCodsrvfis   = TratarNulo(codsrvfis, "")
                THIS.this_nVdeducoes   = TratarNulo(vdeducoes, 0)
                THIS.this_nVdscconds   = TratarNulo(vdscconds, 0)
                THIS.this_nVdsciconds  = TratarNulo(vdsciconds, 0)
                THIS.this_nOutretens   = TratarNulo(outretens, 0)
                THIS.this_nIssretidos  = TratarNulo(issretidos, 0)
                THIS.this_cTiponfs     = TratarNulo(tiponfs, "")
                THIS.this_nVtotiss     = TratarNulo(vtotiss, 0)
                THIS.this_nVirf        = TratarNulo(virf, 0)
                THIS.this_nVinss       = TratarNulo(vinss, 0)
                THIS.this_nVpis        = TratarNulo(vpis, 0)
                THIS.this_nVcsll       = TratarNulo(vcsll, 0)
                THIS.this_nVcofins     = TratarNulo(vcofins, 0)

                *-- Colunas NOT NULL sem controle na tela (regra #22)
                IF VARTYPE(cancelas) = "L"
                    THIS.this_lCancelas = cancelas
                ELSE
                    THIS.this_lCancelas = (NVL(cancelas, 0) = 1)
                ENDIF
                THIS.this_cClfis      = TratarNulo(clfis, "")
                THIS.this_cClifors    = TratarNulo(clifors, "")
                THIS.this_cCodcons    = TratarNulo(codcons, "")
                THIS.this_cConds      = TratarNulo(conds, "")
                THIS.this_nIcms       = TratarNulo(icms, 0)
                THIS.this_nImpress    = TratarNulo(impress, 0)
                THIS.this_nIpis       = TratarNulo(ipis, 0)
                THIS.this_cObs2s      = TratarNulo(obs2s, "")
                THIS.this_cOperas     = TratarNulo(operas, "")
                THIS.this_nPerciss    = TratarNulo(perciss, 0)
                THIS.this_nPesos      = TratarNulo(pesos, 0)
                IF VARTYPE(regs) = "L"
                    THIS.this_lRegs = regs
                ELSE
                    THIS.this_lRegs = (NVL(regs, 0) = 1)
                ENDIF
                THIS.this_nVals       = TratarNulo(vals, 0)
                THIS.this_nVtotsers   = TratarNulo(vtotsers, 0)
                THIS.this_cCgcs       = TratarNulo(cgcs, "")
                IF VARTYPE(correcs) = "L"
                    THIS.this_lCorrecs = correcs
                ELSE
                    THIS.this_lCorrecs = (NVL(correcs, 0) = 1)
                ENDIF
                THIS.this_cLocals     = TratarNulo(locals, "")
                THIS.this_nNtrans     = TratarNulo(ntrans, 0)
                THIS.this_cCodservs   = TratarNulo(codservs, "")
                THIS.this_cDescservs  = TratarNulo(descservs, "")
                THIS.this_nChkenvias  = TratarNulo(chkenvias, 0)
                THIS.this_nLoterps    = TratarNulo(loterps, 0)
                THIS.this_nNumrps     = TratarNulo(numrps, 0)
                THIS.this_nPcofins    = TratarNulo(pcofins, 0)
                THIS.this_nPcsll      = TratarNulo(pcsll, 0)
                THIS.this_nPinss      = TratarNulo(pinss, 0)
                THIS.this_nPirf       = TratarNulo(pirf, 0)
                THIS.this_nPpis       = TratarNulo(ppis, 0)
                THIS.this_cSerierps   = TratarNulo(serierps, "")
                THIS.this_cTiporps    = TratarNulo(tiporps, "")
                THIS.this_nValiis     = TratarNulo(valiis, 0)
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_cChnfes     = TratarNulo(chnfes, "")
                THIS.this_cPrestservs = TratarNulo(prestservs, "")
                THIS.this_nVfcpst     = TratarNulo(vfcpst, 0)
                IF TYPE("numeronota") != "U"
                    THIS.this_cNumeroNota = TratarNulo(numeronota, "")
                ENDIF
                THIS.this_nChkrastreio = TratarNulo(chkrastreio, 0)
                IF TYPE("chaveexterna") != "U"
                    THIS.this_cChaveExterna = TratarNulo(chaveexterna, "")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCidchaves - carrega o registro de SigMvNfi cuja PK bate com
    * this_cCidchaves (equivalente ao form PAI ja ter posicionado o cursor
    * global crSigMvNfi no legado). SELECT em cursor TEMPORARIO + CarregarDoCursor
    * (regra CLAUDE.md #8 - SEMPRE SELECT (alias) antes de ler campo, nunca
    * campo). Chamado pelo Form ao abrir em modo ALTERAR/VISUALIZAR.
    *==========================================================================
    PROCEDURE CarregarPorCidchaves()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = !EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))

        TRY
            IF loc_lProsseguir
                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfi WHERE cidchaves = " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidchaves), 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CargaNfi")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar dados fiscais da nota:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_CargaNfi") AND RECCOUNT("cursor_4c_CargaNfi") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CargaNfi")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_CargaNfi")
                    USE IN cursor_4c_CargaNfi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.CarregarPorCidchaves")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigMvNfi
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida (regra #22
    * - NUNCA string vazia, senao o 2o registro colide no indice unico)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvNfi ("
            loc_cSQL = loc_cSQL + "cidchaves, empdopnums, emps, dopes, numes,"
            loc_cSQL = loc_cSQL + "nfis, series, especienfs, emis, selos, dtsaidas, cfis, cfosubs,"
            loc_cSQL = loc_cSQL + "basecipis, valipis, basecicms, valicms, totprods, totnotas,"
            loc_cSQL = loc_cSQL + "bcicmss, icmss, basecic2s, basecic3s, basecip2s, basecip3s, ipincreds,"
            loc_cSQL = loc_cSQL + "vlfretes, vlseguros, despaces, frticms, frtipis, segicms, segipis, desicms, desipis,"
            loc_cSQL = loc_cSQL + "obsfretes, obspliqs, obspbrus,"
            loc_cSQL = loc_cSQL + "codtrans, fretes, placas, ufplacas, qtdes, espes, marcas, numeros, pliqs, pbrus, obss,"
            loc_cSQL = loc_cSQL + "nfechv, nfechvc, ndis, dregdis, ddesembs,"
            loc_cSQL = loc_cSQL + "tptribsers, codbenefs, codsrvfis, vdeducoes, vdscconds, vdsciconds, outretens,"
            loc_cSQL = loc_cSQL + "issretidos, tiponfs, vtotiss, virf, vinss, vpis, vcsll, vcofins,"
            loc_cSQL = loc_cSQL + "cancelas, clfis, clifors, codcons, conds, icms, impress, ipis, obs2s, operas,"
            loc_cSQL = loc_cSQL + "perciss, pesos, regs, vals, vtotsers, cgcs, correcs, locals, ntrans,"
            loc_cSQL = loc_cSQL + "codservs, descservs, chkenvias, loterps, numrps, pcofins, pcsll, pinss, pirf, ppis,"
            loc_cSQL = loc_cSQL + "serierps, tiporps, valiis, nfeprt, chnfes, prestservs, vfcpst,"
            loc_cSQL = loc_cSQL + "NumeroNota, chkrastreio, chaveexterna"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigMvNfi (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao,
            *-- regra #42 - NUNCA ALLTRIM nas partes internas)
            THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvNfi SET"
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " nfis = " + EscaparSQL(LEFT(THIS.this_cNFis, 6)) + ","
            loc_cSQL = loc_cSQL + " series = " + EscaparSQL(LEFT(THIS.this_cSeries, 8)) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecieNFs, 6)) + ","
            loc_cSQL = loc_cSQL + " emis = " + FormatarDataSQL(THIS.this_dEmis) + ","
            loc_cSQL = loc_cSQL + " selos = " + FormatarNumeroSQL(THIS.this_nSelos, 0) + ","
            loc_cSQL = loc_cSQL + " dtsaidas = " + FormatarDataSQL(THIS.this_dDtSaidas) + ","
            loc_cSQL = loc_cSQL + " cfis = " + EscaparSQL(LEFT(THIS.this_cCFis, 10)) + ","
            loc_cSQL = loc_cSQL + " cfosubs = " + EscaparSQL(LEFT(THIS.this_cCfoSubs, 10)) + ","
            loc_cSQL = loc_cSQL + " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecIpis, 2) + ","
            loc_cSQL = loc_cSQL + " valipis = " + FormatarNumeroSQL(THIS.this_nValIpis, 2) + ","
            loc_cSQL = loc_cSQL + " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecIcms, 2) + ","
            loc_cSQL = loc_cSQL + " valicms = " + FormatarNumeroSQL(THIS.this_nValIcms, 2) + ","
            loc_cSQL = loc_cSQL + " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds, 2) + ","
            loc_cSQL = loc_cSQL + " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas, 2) + ","
            loc_cSQL = loc_cSQL + " bcicmss = " + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + " icmss = " + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + " basecic2s = " + FormatarNumeroSQL(THIS.this_nBasecic2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecic3s = " + FormatarNumeroSQL(THIS.this_nBasecic3s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip2s = " + FormatarNumeroSQL(THIS.this_nBasecIp2s, 2) + ","
            loc_cSQL = loc_cSQL + " basecip3s = " + FormatarNumeroSQL(THIS.this_nBasecip3s, 2) + ","
            loc_cSQL = loc_cSQL + " ipincreds = " + FormatarNumeroSQL(THIS.this_nIpiNCreds, 2) + ","
            loc_cSQL = loc_cSQL + " vlfretes = " + FormatarNumeroSQL(THIS.this_nVlFretes, 2) + ","
            loc_cSQL = loc_cSQL + " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros, 2) + ","
            loc_cSQL = loc_cSQL + " despaces = " + FormatarNumeroSQL(THIS.this_nDespAces, 2) + ","
            loc_cSQL = loc_cSQL + " frticms = " + FormatarNumeroSQL(THIS.this_nFrtIcms, 2) + ","
            loc_cSQL = loc_cSQL + " frtipis = " + FormatarNumeroSQL(THIS.this_nFrtIpis, 2) + ","
            loc_cSQL = loc_cSQL + " segicms = " + FormatarNumeroSQL(THIS.this_nSegIcms, 2) + ","
            loc_cSQL = loc_cSQL + " segipis = " + FormatarNumeroSQL(THIS.this_nSegIpis, 2) + ","
            loc_cSQL = loc_cSQL + " desicms = " + FormatarNumeroSQL(THIS.this_nDesIcms, 2) + ","
            loc_cSQL = loc_cSQL + " desipis = " + FormatarNumeroSQL(THIS.this_nDesIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obsfretes = " + EscaparSQL(LEFT(THIS.this_cObsFretes, 10)) + ","
            loc_cSQL = loc_cSQL + " obspliqs = " + EscaparSQL(LEFT(THIS.this_cObspliqs, 10)) + ","
            loc_cSQL = loc_cSQL + " obspbrus = " + EscaparSQL(LEFT(THIS.this_cObspbrus, 10)) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodTrans, 10)) + ","
            loc_cSQL = loc_cSQL + " fretes = " + FormatarNumeroSQL(THIS.this_nFretes, 0) + ","
            loc_cSQL = loc_cSQL + " placas = " + EscaparSQL(LEFT(THIS.this_cPlacas, 8)) + ","
            loc_cSQL = loc_cSQL + " ufplacas = " + EscaparSQL(LEFT(THIS.this_cUfPlacas, 2)) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " marcas = " + EscaparSQL(LEFT(THIS.this_cMarcas, 10)) + ","
            loc_cSQL = loc_cSQL + " numeros = " + EscaparSQL(LEFT(THIS.this_cNumeros, 10)) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPLiqs, 3) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPBrus, 3) + ","
            loc_cSQL = loc_cSQL + " obss = " + EscaparSQL(LEFT(THIS.this_cObss, 40)) + ","
            loc_cSQL = loc_cSQL + " nfechv = " + EscaparSQL(LEFT(THIS.this_cNfechv, 44)) + ","
            loc_cSQL = loc_cSQL + " nfechvc = " + EscaparSQL(LEFT(THIS.this_cNfechvc, 44)) + ","
            loc_cSQL = loc_cSQL + " ndis = " + EscaparSQL(LEFT(THIS.this_cNdis, 10)) + ","
            loc_cSQL = loc_cSQL + " dregdis = " + FormatarDataSQL(THIS.this_dDregdis) + ","
            loc_cSQL = loc_cSQL + " ddesembs = " + FormatarDataSQL(THIS.this_dDdesembs) + ","
            loc_cSQL = loc_cSQL + " tptribsers = " + FormatarNumeroSQL(THIS.this_nTptribsers, 0) + ","
            loc_cSQL = loc_cSQL + " codbenefs = " + EscaparSQL(LEFT(THIS.this_cCodbenefs, 3)) + ","
            loc_cSQL = loc_cSQL + " codsrvfis = " + EscaparSQL(LEFT(THIS.this_cCodsrvfis, 6)) + ","
            loc_cSQL = loc_cSQL + " vdeducoes = " + FormatarNumeroSQL(THIS.this_nVdeducoes, 2) + ","
            loc_cSQL = loc_cSQL + " vdscconds = " + FormatarNumeroSQL(THIS.this_nVdscconds, 2) + ","
            loc_cSQL = loc_cSQL + " vdsciconds = " + FormatarNumeroSQL(THIS.this_nVdsciconds, 2) + ","
            loc_cSQL = loc_cSQL + " outretens = " + FormatarNumeroSQL(THIS.this_nOutretens, 2) + ","
            loc_cSQL = loc_cSQL + " issretidos = " + FormatarNumeroSQL(THIS.this_nIssretidos, 0) + ","
            loc_cSQL = loc_cSQL + " tiponfs = " + EscaparSQL(LEFT(THIS.this_cTiponfs, 2)) + ","
            loc_cSQL = loc_cSQL + " vtotiss = " + FormatarNumeroSQL(THIS.this_nVtotiss, 2) + ","
            loc_cSQL = loc_cSQL + " virf = " + FormatarNumeroSQL(THIS.this_nVirf, 2) + ","
            loc_cSQL = loc_cSQL + " vinss = " + FormatarNumeroSQL(THIS.this_nVinss, 2) + ","
            loc_cSQL = loc_cSQL + " vpis = " + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + " vcsll = " + FormatarNumeroSQL(THIS.this_nVcsll, 2) + ","
            loc_cSQL = loc_cSQL + " vcofins = " + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + " cancelas = " + IIF(THIS.this_lCancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " clfis = " + EscaparSQL(LEFT(THIS.this_cClfis, 12)) + ","
            loc_cSQL = loc_cSQL + " clifors = " + EscaparSQL(LEFT(THIS.this_cClifors, 20)) + ","
            loc_cSQL = loc_cSQL + " codcons = " + EscaparSQL(LEFT(THIS.this_cCodcons, 9)) + ","
            loc_cSQL = loc_cSQL + " conds = " + EscaparSQL(LEFT(THIS.this_cConds, 12)) + ","
            loc_cSQL = loc_cSQL + " icms = " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + " impress = " + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + " ipis = " + FormatarNumeroSQL(THIS.this_nIpis, 2) + ","
            loc_cSQL = loc_cSQL + " obs2s = " + EscaparSQL(LEFT(THIS.this_cObs2s, 40)) + ","
            loc_cSQL = loc_cSQL + " operas = " + EscaparSQL(LEFT(THIS.this_cOperas, 1)) + ","
            loc_cSQL = loc_cSQL + " perciss = " + FormatarNumeroSQL(THIS.this_nPerciss, 2) + ","
            loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 2) + ","
            loc_cSQL = loc_cSQL + " regs = " + IIF(THIS.this_lRegs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " vals = " + FormatarNumeroSQL(THIS.this_nVals, 2) + ","
            loc_cSQL = loc_cSQL + " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers, 2) + ","
            loc_cSQL = loc_cSQL + " cgcs = " + EscaparSQL(LEFT(THIS.this_cCgcs, 21)) + ","
            loc_cSQL = loc_cSQL + " correcs = " + IIF(THIS.this_lCorrecs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " codservs = " + EscaparSQL(LEFT(THIS.this_cCodservs, 10)) + ","
            loc_cSQL = loc_cSQL + " descservs = " + EscaparSQL(LEFT(THIS.this_cDescservs, 40)) + ","
            loc_cSQL = loc_cSQL + " chkenvias = " + FormatarNumeroSQL(THIS.this_nChkenvias, 0) + ","
            loc_cSQL = loc_cSQL + " loterps = " + FormatarNumeroSQL(THIS.this_nLoterps, 0) + ","
            loc_cSQL = loc_cSQL + " numrps = " + FormatarNumeroSQL(THIS.this_nNumrps, 0) + ","
            loc_cSQL = loc_cSQL + " pcofins = " + FormatarNumeroSQL(THIS.this_nPcofins, 2) + ","
            loc_cSQL = loc_cSQL + " pcsll = " + FormatarNumeroSQL(THIS.this_nPcsll, 2) + ","
            loc_cSQL = loc_cSQL + " pinss = " + FormatarNumeroSQL(THIS.this_nPinss, 2) + ","
            loc_cSQL = loc_cSQL + " pirf = " + FormatarNumeroSQL(THIS.this_nPirf, 2) + ","
            loc_cSQL = loc_cSQL + " ppis = " + FormatarNumeroSQL(THIS.this_nPpis, 2) + ","
            loc_cSQL = loc_cSQL + " serierps = " + EscaparSQL(LEFT(THIS.this_cSerierps, 5)) + ","
            loc_cSQL = loc_cSQL + " tiporps = " + EscaparSQL(LEFT(THIS.this_cTiporps, 5)) + ","
            loc_cSQL = loc_cSQL + " valiis = " + FormatarNumeroSQL(THIS.this_nValiis, 2) + ","
            loc_cSQL = loc_cSQL + " nfeprt = " + EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ","
            loc_cSQL = loc_cSQL + " chnfes = " + EscaparSQL(LEFT(THIS.this_cChnfes, 44)) + ","
            loc_cSQL = loc_cSQL + " prestservs = " + EscaparSQL(LEFT(THIS.this_cPrestservs, 7)) + ","
            loc_cSQL = loc_cSQL + " vfcpst = " + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + " NumeroNota = " + EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ","
            loc_cSQL = loc_cSQL + " chkrastreio = " + FormatarNumeroSQL(THIS.this_nChkrastreio, 0) + ","
            loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveExterna, 33))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar dados fiscais da nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopfisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

