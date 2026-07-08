# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NLOTE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, DOPPS, EMPS, EMPDNPS, CIDCHAVES, EMPDOPNUMS, CIDQUERYS, _QTBAIXAR, 0, 1, XNENS, ORIDOPNUMS, COPERS, NUMLOTES, NCHEQUES, NUMS, IMPRESS, _BXAUTO, _BXPARC, _QTBAIXADO, NOPS, RNOPS, EMPDS, DOPES, NUMES, EMPOS, EMPDNCRDS, CBARS, CODBARRAS, BARRAS, OPERS, EMPDOPNCS, NCARTS, NLOTECS, QTDS, CDOPES, LNVALOBXS, EMPDOPNUMB, CBXPAGOS, PGSUBNNS, DTAGENDS, NUMPS, CSSUBNIVE, CPROS, LPRECOS, IFORS, PVENS, CMOES, GRUPOS, CODS, GERBALS, IF, NLOTES, ETIQUETA, ETIQS, PCESCOLHA, INIBEPA, RATEIO, TPOPS, CMATS, SEPPEDRAS, _PESOCONSERTO, FATORS, _COMPAGRU, _QTDE, _DIFERENCAPESO, CGRUS, CODIGOS, PESOS, PESO2S, REINOPS, ESTORNO, SEMIACABS, COEFS, ICLIS, PRODUTOS, CUNIS, CESTOQS, BXDESTS, CITENS, CITEM2, MATS, LNQTRAT, LNSOMAETQ, LCUPDATE, LNCONT, CPRO2S, DOCUS, ANAESGRPS, PO, CHKSENEXC, EDNMVCAB, CRETRABS, CONTADS, GRCOMPS, TIPOSUBNIVEL, CHKTEMSUBN, VISIVEL, _TRFPESAG, LNTOTQTD, CTRLOTES, EMPGRUESTS, CHKSUBN, LLLOTED, CLAGRUPOS, CLACONTAS, FASES, GRODNS, _NVEZES, ENCPESMS, CHKDESTS, MOVOPEVS, CHKDEVS, CODTGOPS, NIVELS, EMPCPROS, CHKCTDES, CODPDS, CRAVCERS, CONTAOS, CONTAS, PESOFIXS, LCEMPDNPS, LCBUSCAN, SERVICOS, ORDEMS, MEDTMPS, CHKQTDPS, QTDCOMPO, PESOCOMPO, XDIFP, XDIFP2, PAGSERVS, GRUPODS, APONTAS, ENVOBRIGS, DTALTS, AQTDS, DATAS, DTMOVS, VALOBXS, DTAUDITS, ULTGRVS, NACEITES, QTBXPRODS, JO, NTIPOJOALS, TUBOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LNBOT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, DOPPS, EMPS, EMPDNPS, CIDCHAVES, EMPDOPNUMS, CIDQUERYS, _QTBAIXAR, 0, 1, XNENS, ORIDOPNUMS, COPERS, NUMLOTES, NCHEQUES, NUMS, IMPRESS, _BXAUTO, _BXPARC, _QTBAIXADO, NOPS, RNOPS, EMPDS, DOPES, NUMES, EMPOS, EMPDNCRDS, CBARS, CODBARRAS, BARRAS, OPERS, EMPDOPNCS, NCARTS, NLOTECS, QTDS, CDOPES, LNVALOBXS, EMPDOPNUMB, CBXPAGOS, PGSUBNNS, DTAGENDS, NUMPS, CSSUBNIVE, CPROS, LPRECOS, IFORS, PVENS, CMOES, GRUPOS, CODS, GERBALS, IF, NLOTES, ETIQUETA, ETIQS, PCESCOLHA, INIBEPA, RATEIO, TPOPS, CMATS, SEPPEDRAS, _PESOCONSERTO, FATORS, _COMPAGRU, _QTDE, _DIFERENCAPESO, CGRUS, CODIGOS, PESOS, PESO2S, REINOPS, ESTORNO, SEMIACABS, COEFS, ICLIS, PRODUTOS, CUNIS, CESTOQS, BXDESTS, CITENS, CITEM2, MATS, LNQTRAT, LNSOMAETQ, LCUPDATE, LNCONT, CPRO2S, DOCUS, ANAESGRPS, PO, CHKSENEXC, EDNMVCAB, CRETRABS, CONTADS, GRCOMPS, TIPOSUBNIVEL, CHKTEMSUBN, VISIVEL, _TRFPESAG, LNTOTQTD, CTRLOTES, EMPGRUESTS, CHKSUBN, LLLOTED, CLAGRUPOS, CLACONTAS, FASES, GRODNS, _NVEZES, ENCPESMS, CHKDESTS, MOVOPEVS, CHKDEVS, CODTGOPS, NIVELS, EMPCPROS, CHKCTDES, CODPDS, CRAVCERS, CONTAOS, CONTAS, PESOFIXS, LCEMPDNPS, LCBUSCAN, SERVICOS, ORDEMS, MEDTMPS, CHKQTDPS, QTDCOMPO, PESOCOMPO, XDIFP, XDIFP2, PAGSERVS, GRUPODS, APONTAS, ENVOBRIGS, DTALTS, AQTDS, DATAS, DTMOVS, VALOBXS, DTAUDITS, ULTGRVS, NACEITES, QTBXPRODS, JO, NTIPOJOALS, TUBOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, DOPPS, EMPS, EMPDNPS, CIDCHAVES, EMPDOPNUMS, CIDQUERYS, _QTBAIXAR, 0, 1, XNENS, ORIDOPNUMS, COPERS, NUMLOTES, NCHEQUES, NUMS, IMPRESS, _BXAUTO, _BXPARC, _QTBAIXADO, NOPS, RNOPS, EMPDS, DOPES, NUMES, EMPOS, EMPDNCRDS, CBARS, CODBARRAS, BARRAS, OPERS, EMPDOPNCS, NCARTS, NLOTECS, QTDS, CDOPES, LNVALOBXS, EMPDOPNUMB, CBXPAGOS, PGSUBNNS, DTAGENDS, NUMPS, CSSUBNIVE, CPROS, LPRECOS, IFORS, PVENS, CMOES, GRUPOS, CODS, GERBALS, IF, NLOTES, ETIQUETA, ETIQS, PCESCOLHA, INIBEPA, RATEIO, TPOPS, CMATS, SEPPEDRAS, _PESOCONSERTO, FATORS, _COMPAGRU, _QTDE, _DIFERENCAPESO, CGRUS, CODIGOS, PESOS, PESO2S, REINOPS, ESTORNO, SEMIACABS, COEFS, ICLIS, PRODUTOS, CUNIS, CESTOQS, BXDESTS, CITENS, CITEM2, MATS, LNQTRAT, LNSOMAETQ, LCUPDATE, LNCONT, CPRO2S, DOCUS, ANAESGRPS, PO, CHKSENEXC, EDNMVCAB, CRETRABS, CONTADS, GRCOMPS, TIPOSUBNIVEL, CHKTEMSUBN, VISIVEL, _TRFPESAG, LNTOTQTD, CTRLOTES, EMPGRUESTS, CHKSUBN, LLLOTED, CLAGRUPOS, CLACONTAS, FASES, GRODNS, _NVEZES, ENCPESMS, CHKDESTS, MOVOPEVS, CHKDEVS, CODTGOPS, NIVELS, EMPCPROS, CHKCTDES, CODPDS, CRAVCERS, CONTAOS, CONTAS, PESOFIXS, LCEMPDNPS, LCBUSCAN, SERVICOS, ORDEMS, MEDTMPS, CHKQTDPS, QTDCOMPO, PESOCOMPO, XDIFP, XDIFP2, PAGSERVS, GRUPODS, APONTAS, ENVOBRIGS, DTALTS, AQTDS, DATAS, DTMOVS, VALOBXS, DTAUDITS, ULTGRVS, NACEITES, QTBXPRODS, JO, NTIPOJOALS, TUBOS

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
  ControlSource = "tmpnens.nLotes"
  ControlSource = "tmpnens.datas"
  ControlSource = "tmpnens.pesolancs"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.grupods"
  ControlSource = "tmpnens.contads"
  ControlSource = "tmpnens.grvends"
  ControlSource = "tmpnens.vends"
  ControlSource = "tmpnens.grupoos"
  ControlSource = "tmpnens.contaos"
  ControlSource = "tmpnens.docus"
  Column1.ControlSource = "tmpoperacao.CODIGOS"
  Column2.ControlSource = "TmpOperacao.TmpMins"
  ControlSource = "TmpNens.nAceites"
  ControlSource = "TmpNens.CodObs"
  ControlSource = "TmpNens.Obss"
            .InsertIntoMvHst()
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
Select TmpOperacao
		lcQuery = [Select Emps, Dopps, Numps, Datas, ContaDs From SigPdMvf ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEnve') < 1)
		lcSql = [Select CidChaves, Retrabs, Chksubn From SigCdNec Where EmpDnPs = ']+_ChaveNens+[']
		ThisForm.Podatamgr.SqlExecute(lcsql,'LocalNens')
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (OK - Update - SigCdNec)')
			lcsql = [Select cIdChaves, Vends, GrVends From SigCdNec Where empdnps = ']+lcchv+[']
			ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
			Select LocalNens
				lcQuery = [Update SigCdNec ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 4)')
			lcsql = [Select cIdChaves, Vends, GrVends From SigCdNec Where empdnps = ']+lcchv+[']
			ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
			Select LocalNens
				lcQuery = [Update SigCdNec ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 5)')
lcQuery = [Select distinct EmpdopNumb From SigBxEst Where EmpDopNums = ?lcEDNe ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrBxIt') < 1)
Select CrSigGtmpR
Select CrBxIt
	Select CrSigGtmpR
If !ThisForm.Podatamgr4.UpDate('CrSigGtmpR')
lcQuery = [Select b.EmpdopNums, b.Cpros, b.CodBarras, b.QtBaixas, b.cidChaves, b.citens, b.Qtds From SigMvItn b, SigGtmpR a ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrBxItem1') < 1)
Select CrBxItem1
lcSql = [Select * From SigBxEst where EmpDopNums = ']+lcEDNe+[']
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CrBxEst') < 1)
Select crBxEst
	Select CrBxItem1
	Seek ( _ChaveDelBx + crBxEst.CPros )
		lcUpDate = [UpDate SigMvItn Set QtBaixas = ]+Str(CrBxItem1.QtBaixas,12,3)+[, ChkSubn = ?llBaixa Where CidChaves = ']+CrBxItem1.CidChaves+[']
		lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn)')
		lcUpDate = [UpDate SigMvCab Set ChkBxParcs = ?llsubn, ChkSubn = ?llSubn, DtBaixas = ?llDtBx, DataTrans = Null Where CidChaves = ']+CrEest.CidChaves+[']
		lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 11)')
	Select crBxEst
Select crSigCdNec
Select * From CrSigCdNec Where 0=1 Into Cursor TmpNens ReadWrite
Select *, 000000.000 as ps2FaseAnt, Space(3) as cUnips, .f. as OsRets, .f. as Retrabs, Space(14) as MatPrincs,;
From CrSigCdNei Where 1=0 Into Cursor xNensi ReadWrite
Select xNensi
Select * From xNensi Where 0=1 Into Cursor xNensiE ReadWrite
Select * From xNensI Where 0=1 Into Cursor xNensiS ReadWrite
Select *, 0 as Autos, 00000 as BaseMins, 000000.000 as PesoAntigo, Space(30) as DRetrabs, .f. as Justs ;
From CrSigPdMvf where 0=1 Into Cursor xMfas ReadWrite
Select xMFas
Select *, 0 as Autos, 00000 as BaseMins, 000000.000 as PesoAntigo ;
From CrSigPdMvf where 0=1 Into Cursor xMfas2 ReadWrite
Select xMFas2
Select csCabec
Select csItens
lcDelete = [Delete From SigMvHst Where OriDopNums = ']+_Operacao+[' ]
If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvHst 3)')
lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+_Operacao+[']
If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCab)')
lcDelete    = [Delete From SigMvItn Where EmpDopNums = ']+_Operacao+[']
If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvItn 3)')
lcDelete = [Delete From SigMvCpv Where EmpDopNums = ']+_Operacao+[']
If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCpv)')
lcQuery = [Select * From SigMvCcr Where EmpDopNums = ']+_Operacao+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMccr') < 1)
Select CrMccr
lcDelete = [Delete From SigMvCcr Where EmpDopNums = ']+_Operacao+[']
lnErro = Thisform.Podatamgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCcr)')
lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_Operacao+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrPar') < 1)
Select crPar
			Select CrPrBx
			=Seek(lcCheque)
				lcUpdate = [UpDate SigCdPbx Set Deposits = ?llDep Where CidChaves = ']+CrPrBx.CidChaves+[']
				lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdPbx 2)')
lcDelete = [Delete From SigMvPar Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPar)')
lcDelete = [Delete From SigTtCcd Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigTtCcd)')
lcDelete = [Delete From SigCdCmm Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCmm)')
lcQuery = [Select NumLotes From SigChLcq Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrCheh') < 1
Select CrCheH
		lcDelete = [Delete From SigCheH Where NumLotes = ]+Str(_Lote)
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCheH)')
lcDelete = [Delete From SigChLcq Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChLcq)')
lcQuery = [Select * From SigCqChm Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrChm') < 1
Select crChm
	lcDelete = [Delete From SigCqChm Where CidChaves = ']+CrChm.cidChaves+[']
	If ThisForm.Podatamgr.SqlExecute(lcDelete,'') < 1
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCqChm)')
	lcWher = [Select * From SigCqChm Where nCheques=']+CrChm.nCheques+[' ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'CrChm2')	
	Select * From CrChm2 where Bancos+Agencias+ncontas+Ncheques=lcCheque And EmpDopNums # _Operacao ;
	lcWher = [Select * From SigChe Where Nums=']+lcNums+[' ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'CrChe')	
	Select crChe
	Seek (lcCheque)
		insert into crSigExChq (agencias,bancos,vencs,ncheques,ncontas,nums,;
		lcDelete = [Delete From SigChe Where Nums = ']+CrChe.Nums+[']
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChe)')
		lcUpDate = [Update SigChe Set Umovs = ']+lcUmovs+[', Numeros=']+lcNumCheques+[', ]+;
		lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigChe)')
		lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_Operacao+[']
		If Thisform.Podatamgr.SqlExecute(lcQuery,'CrPar') < 1
		Select CrPar
				lcUpdate = [Update SigMvPar Set VPags = 0, Pagos = ?lcPago, DtAlts = ?ldDat ] + ;
				If ThisForm.poDataMgr.SqlExecute(lcUpdate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvPar)')
lcDelete = [Delete From SigCdCar Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCar)')
lcDelete = [Delete From SigCdCtt Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCtt)')
lcDelete = [Delete From SigCdCrd Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCrd)')
lcDelete = [Delete From SigOpDev Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigOpDev 2)')
lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPec)')
lcDelete = [Delete From SigMvMov Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvMov)')
lcDelete = [Delete From SigMvEtv Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtv)')
lcDelete = [Delete From SigMvNfi Where EmpDopNums = ']+_Operacao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvNfi)')
Select TmpEest
	Select crNFis
			lcUpdate = [UpDate SigMvNfi Set Cancelas = ?llCanc Where EmpDopNums = ']+CrNfis.EmpdopNums+[']
			lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvNfi)')
			lcDelete = [Delete From SigMvNfi Where EmpDopNums = ?lcEDNe ]
			lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvNfi)')
			Select crNfis
lcQuery = [Select * From SigMvPec Where EmpDopNums = ']+_posicao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrEstPe') < 1
Select CrEsti2
Select crEesti
		Insert Into TmpEtiquetas ( CodBarras, Opers ) Values ( crEesti.CodBarras, crEesti.Opers )
		Select crEsti2
				Insert Into TmpEtiquetas ( CodBarras, Opers ) ;
	If Seek(crEesti.CPros, 'csOpeAut', 'CPros') And ;
			Not Seek(TmpEest.Emps + csOpeAut.Dopes + Str(TmpEest.Numes,6), 'csTmpOpAut', 'EmpDopNum' )
		Insert Into csTmpOpAut( AutEmps, AutDopes, AutNumes ) ;
	If Seek(crEesti.CPros, 'csOpeTrf', 'Cpros') And ;
			Not Seek(TmpEest.Emps + csOpeTrf.Dopes + Str(TmpEest.Numes,6), 'csTmpOpeAut', 'EmpDopNum' )
		Insert Into csTmpOpeAut( AutEmps, AutDopes, AutNumes ) ;
			Not Seek(lcEmp + crSigCdPam.OpConsers + crEesti.Notas, 'csTmpOpAut', 'EmpDopNum' )
		Insert Into csTmpOpAut( AutEmps, AutDopes, AutNumes ) ;
			Not Seek(lcEmp + csOpeAut.Dopes + crEesti.Notas, 'csTmpOpAut', 'EmpDopNum' )
		Insert Into csTmpOpAut( AutEmps, AutDopes, AutNumes ) ;
lcDelete = [Delete From SigMvItn Where EmpDopNums = ?lcEDNe ]
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvItn)')
	lcQuery = [Select distinct EmpdopNumb From SigBxEst Where EmpDopNums = ?lcEDNe ]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrBxIt') < 1)
	Select CrSigGtmpR
	Select CrBxIt
		Select CrSigGtmpR
	If !ThisForm.Podatamgr4.UpDate('CrSigGtmpR')
	lcQuery = [Select b.EmpdopNums,b.Cpros,b.CodBarras,b.QtBaixas,b.cidChaves,b.citens,b.Qtds,b.QtProds,b.QtReservas ]+;
				[From SigMvItn b, CptGTmpd a ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrBxItem1') < 1)
	lcQuery = [Select b.EmpDopNums, b.Citens, b.Cpros, b.CodCors, b.CodTams, b.QtBaixas, b.CidChaves, b.QtdEmbs, b.Qtds,b.QtProds,b.QtReservas,b.CodEmbs From cptgtmpd a, SigMvIts b ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrBxItem2') < 1)
	Select CrBxItem1
	Select CrBxItem2
	Select crBxEst
		If Not Seek('','TmpBxPends','BxEmpDopN')
			Insert Into TmpBxPends (BxEmps, BxDopes, BxNumes) Values ;
			Select CrBxItem1
			Seek ( _ChaveDelBx + crBxEst.CPros )
				lcUpDate = [UpDate SigMvItn Set QtBaixas = ]+Str(CrBxItem1.QtBaixas,12,3)+[, ChkSubn = ?llBaixa Where CidChaves = ']+CrBxItem1.CidChaves+[']
				lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn)')
			Select CrBxItem2
			Seek ( _ChaveDelBx + Str(crBxEst.CItens,4) )
				lcUpDate = [UpDate SigMvIts Set QtBaixas = ]+Str(CrBxItem2.QtBaixas,12,3)+[, ChkSubn = ?llBaixa Where CidChaves = ']+CrBxItem2.CidChaves+[']
				lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvIts)')
				Select CrBxItem1
				Seek ( CrBxItem2.EmpDopNums)
						Select CrBxItem1
						lcUpDate = [UpDate SigMvItn Set QtBaixas = ]+Str(CrBxItem1.QtBaixas,12,3)+[, ChkSubn = ?llBaixa Where CidChaves = ']+CrBxItem1.CidChaves+[']
						lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
							MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn 2)')
				Select CrBxItem2
			lcUpDate = [UpDate SigMvCab Set ChkBxParcs = ?llsubn, ChkSubn = ?llSubn, DtBaixas = ?llDtBx, DataTrans = Null, UltGrvs = ?lcUltGrv Where CidChaves = ']+CrEest.CidChaves+[']
			lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 11)')
			lcUpdate = [Update SigMvEte Set ChkSubn = ?llSubn Where EmpDopNums = ']+_ChaveDelbx+[']
				LnErro = ThisForm.PoDataMgr6.SqlExecute(lcUpDate,'')
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcUpDate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvEte)')
			If Seek(CrEest.Dopes,'CrSigCdMei','Dopes')
				lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+CrEest.EmpDopNums+[']
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtt - Excluir 1)')
		Select crBxEst
		Select TmpBxPends
			Select CrBxItem1
			lcUpDate = [UpDate SigMvCab Set ChkBxParcs = ?llsubn, DataTrans = Null, UltGrvs = ?lcUltGrv Where CidChaves = ']+CrEest.CidChaves+[']
			lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 12)')
			If Seek(CrEest.Dopes,'CrSigCdMei','Dopes')
				lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+CrEest.EmpdopNums+[']
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtt - excluir 2)')
		Select crBxEst
				Select CrBxItem1
				=Seek( _ChaveDelBx + crbxest.Cpros )
					lcUpDate = [UpDate SigMvItn Set QtProds = ]+Str(CrBxItem1.QtProds,12,2)+[, QtReservas = ]+Str(CrBxItem1.QtReservas,12,2)+[ ]+;
					lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn 3)')
				Select CrBxItem2
				Seek ( _ChaveDelBx + crBxEst.CPros + crBxEst.CodCors + crBxEst.CodTams )
					lcUpDate = [UpDate SigMvIts Set QtProds = ]+Str(CrBxItem2.QtProds,12,2)+[, QtReservas = ]+Str(CrBxItem2.QtReservas,12,2)+[ ]+;
					lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvIts 2)')
					Select CrBxItem1
					Seek ( CrBxItem2.EmpDopNums )
							Select CrBxItem1
							lcUpDate = [UpDate SigMvItn Set QtProds = ]+Str(CrBxItem1.QtProds,12,2)+[, QtReservas = ]+Str(CrBxItem1.QtReservas,12,2)+[ ]+;
							lnErro   = ThisForm.PodataMgr.SqlExecute(lcUpdate,'')
								MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn 4)')
					Select CrBxItem2
			Select crBxEst
lcDelete = [Delete From SigMvIts Where EmpDopNums = ?lcEDNe ]
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvIts)')
lcDelete = [Delete From SigMvItp Where EmpDopNums = ?lcEDNe ]
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvItp)')
lcDelete = [Delete From SigBxEst Where EmpDopNums = ?lcEDNe ]
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigBxEst)')
lcDelete = [Delete From SigCdMlc Where EmpDopNums = ?lcEDNe ]
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdMlc)')
lcDelete = [Delete From SigInAtz Where EmpDopNums = ']+lcEDNe+[']
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigInAtz)')
lcSql = [Select * From SigOpPii Where EmpDopNums = ']+lcEDNe+[']
Thisform.Podatamgr.Sqlexecute(lcSql,'LocalOpiC')
Select LocalOpiC
	lcSql = [Select * From SigOpPic where Nops = ]+Str(LocalOpiC.Nops)
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpOpi')
	Select TmpOpi
			lcSql = [Update SigOpPic Set Qtds = ]+Str(TmpOpi.Qtds,12,3)+[ Where Cidchaves = ']+pids+[']
			ThisForm.Podatamgr.Sqlexecute(lcSql,'')
				Delete In TmpOpi
				lcSql = [Delete From SigOpPic Where Cidchaves = ']+pids+[']
				ThisForm.Podatamgr.Sqlexecute(lcSql,'')
lcDelete = [Delete From SigOpPii Where EmpDopNums = ']+lcEDNe+[']
lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigOpPii)')
	lcSql = [Select CidChaves From SigMvCab Where Rnops = ]+Str(_Nops)
	Thisform.Podatamgr.Sqlexecute(lcSql,'LocEest')
	Select LocEest
		lcSql = [Update SigMvCab Set Rnops = 0 Where CidChaves = ']+LocEest.CidChaves+[']
		ThisForm.Podatamgr.Sqlexecute(lcSql,'')
	lcQuery = [Select Emps, Empds, Dopes, Numes From SigMvCab Where Not EmpDs = ']+Space(3)+[' ] +;
			  [Select Emps, EmpDs, Dopes, Numes From SigMvCab Where ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CsTmpTrfs') < 1)
	Select csTmpTrfs
		lcDelete    = [Delete From SigMvItn Where EmpDopNums = ']+lcEmpDopNum+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvItn 2)')
		lcQuery = [Select Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+CsTmpTrfs.Emps+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
		Select CrHis
		lcDelete = [Delete From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+CsTmpTrfs.emps+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvHst 2)')
		lcDelete = [Delete From SigOpEtq Where EmpDopNums = ']+lcEmpDopNum+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpEtq)')
		lcQuery = [Select Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+CsTmpTrfs.Emps+[']		
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
		Select crHis
		lcDelete = [Delete From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+CsTmpTrfs.emps+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvHst 3)')
		lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+lcEmpDopNum+[']
		If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCab)')
	lcSql = [Select EmpDnCrds, EmpDopNums From SigMvCab Where EmpDnCrds = ']+lcEmpDopNum2+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CsTmpTrfs') < 1)
	Select csTmpTrfs
		lcQuery = [Select Datas,Cpros,Grupos,Estos,CodCors,CodTams,Emps From SigMvHst Where OriDopNums = ']+lcEmpDopNum+[' ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrHis') < 1)
		Select CrHis
	lcSql = [Select EmpDnCrds, EmpDopNums From SigMvCab Where 0=1]
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CsTmpTrfs') < 1)
Select CsTmpTrfs
	Select TmpEtiquetas
			Select crEti
					Select xEesti
					Seek (TmpEtiquetas.CodBarras)
						lcDelete = [Delete From SigOpEtq Where Cbars = ]+Str(TmpEtiquetas.CodBarras,14)
						If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpEtq)')
					Select xEesti
					lcDelete = [Delete From SigOpEtq Where Cbars = ]+Str(TmpEtiquetas.CodBarras,14)
					If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigOpEtq 2)')
				lcQuery = [Select * From SigMvHst Where CodBarras = ]+Str(TmpEtiquetas.CodBarras,8)+[ Order By Seqs Desc ]
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
				Select crHis
						If Seek(CrHis.OriDopNums,'CsTmpTrfs','EmpDopNums')
					lcQuery = [Select * From SigCdMlc Where Barras = ]+Str(TmpEtiquetas.CodBarras,8)+[ Order By Datas Desc ]
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrMloc') < 1)
					Select crMloc
					lcSql = [Select AltEtiqs From SigOpCdc Where dopes = ']+TmpEest.Dopes+[']
					If (ThisForm.poDataMgr.SqlExecute(lcsql, 'CrDop') < 1)
							lcSql = [Select a.Pesos, a.Qtds, a.Cidchaves, a.Opers, b.dopes, b.AltEtiqs From SigMvHst a, SigOpCdc b ]+;
							If (ThisForm.poDataMgr.SqlExecute(lcsql, 'CrHisEtq') < 1)
							Select CrHisEtq
							lcUpDate = [UpDate SigOpEtq Set ]+Iif(CrDop.AltEtiqs=4,[],[Grupos=']+_GrupoEti+[', Contas=']+_ContaEti+[', ])+;
							lcSql = [Select a.Pesos,a.Qtds,a.Cidchaves,a.Opers,b.dopes,a.Grupos,a.Estos,b.AltEtiqs From SigMvHst a, SigOpCdc b ]+;
							If (ThisForm.poDataMgr.SqlExecute(lcsql, 'CrHisEtq') < 1)
							Select CrHisEtq
							lcUpDate = [UpDate SigOpEtq Set Grupos=']+_GrupoEti+[', Contas=']+_ContaEti+[', ]+;
						lcUpDate = [UpDate SigOpEtq Set Grupos=']+_GrupoEti+[', Contas=']+_ContaEti+[', Empos=']+_EmposEti+[', ]+;
					If (ThisForm.poDataMgr.SqlExecute(lcUpDate,' ') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigOpEtq)')
						lcUpDate = [UpDate SigOpEtq Set Grupos=']+Space(10)+[', Contas=']+Space(10)+[', Empos=']+CrEti.Emps+[', ]+;
						If (ThisForm.poDataMgr.SqlExecute(lcUpDate,' ') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigOpEtq 2)')
		Select TmpEtiquetas
Select TmpEtiquetas
		lcQuery = [Select dopes,datas,seqs,codbarras From SigMvHst Where CodBarras = ]+Str(TmpEtiquetas.CodBarras,8)+[ And OriDopNums <> ']+TmpEest.empDopNums+[' Order By Seqs Desc ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
		Select crHis
			lcUpDate = [UpDate SigOpEtq Set DtBals = ?llDtBal Where Cbars = ]+Str(TmpEtiquetas.CodBarras,14)
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate,' ') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigOpEtq 3)')
			lcQuery = [Select a.Codbarras, b.Datas, a.Dopes From SigMvItn a, SigMvCab b ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEesti') < 1)
			Select LocalEesti
					lcUpDate = [UpDate SigOpEtq Set DtBals = ?llDtBal Where Cbars = ]+Str(TmpEtiquetas.CodBarras,14)
					If (ThisForm.poDataMgr.SqlExecute(lcUpDate,' ') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update SigOpEtq 4)')
Select csTmpOpAut
	lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCab 2)')
	lcDelete = [Delete From SigMvItn Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvItn 3)')
	lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvPec )')
Select CsTmpOpeAut
	lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCab 3)')
	lcDelete = [Delete From SigMvItn Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvItn 4)')
	lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+lcEmpDopNum+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvPec )')
	lcQuery = [Select Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+csTmpOpeAut.AutEmps+[']	
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crhis') < 1)
	Select crHis
	lcDelete = [Delete From SigMvHst Where EmpDopNums = ']+lcEmpDopNum+[' And Empos = ']+csTmpOpeAut.AutEmps+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvHst 4)')
Select CrHis
	lcDelete = [Delete From SigMvHst Where CidChaves = ']+CrHis.cidChaves+[']
	lnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvHst)')
	Select CrHis
lcSql = [Select Distinct EmpDopNcs From SigMvCpv Where EmpDopNums = ']+_posicao+[']
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'crMccr') < 1)
Select CrMccr
	lcDelete = [Delete From ScoTitOc Where EmpdopNcs = ']+CrMccr.EmpdopNcs+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCpv)')
lcDelete = [Delete From SigMvCpv Where EmpDopNums = ']+_posicao+[']
If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCpv)')
lcQuery = [Select * From SigMvCcr Where EmpDopNums = ']+_posicao+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crMccr') < 1)
Select CrMccr
Select Distinct EmpDopNcs From crMccr Into Cursor Selecao
Select Selecao
	lcDelete = [Delete From ScoTitOc Where EmpdopNcs = ']+Selecao.EmpdopNcs+[']
	If (ThisForm.poDataMgr.SqlExecute(lcDelete,' ') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete SigMvCcr)')
lcDelete = [Delete From SigMvCcr Where EmpDopNums = ']+_Posicao+[']
lnErro = Thisform.Podatamgr.SqlExecute(lcDelete,'')
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCcr)')
lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_posicao+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrPar') < 1)
Select crPar
			Select CrPrBx
			=Seek(lcCheque)
				lcUpdate = [UpDate SigCdPbx Set Deposits = ?llDep Where CidChaves = ']+CrPrBx.CidChaves+[']
				lnErro = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdPbx 2)')
lcDelete = [Delete From SigMvPar Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPar)')
lcDelete = [Delete From SigTtCcd Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigTtCcd)')
lcDelete = [Delete From SigCdCmm Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCmm)')
lcQuery = [Select NumLotes From SigChLcq Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrCheh') < 1
Select CrCheH
		lcDelete = [Delete From SigCheH Where NumLotes = ]+Str(_Lote)
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCheH)')
lcDelete = [Delete From SigChLcq Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChLcq)')
lcQuery = [Select * From SigCqChm Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrChm') < 1
Select crChm
	lcDelete = [Delete From SigCqChm Where CidChaves = ']+CrChm.cidChaves+[']
	If ThisForm.Podatamgr.SqlExecute(lcDelete,'') < 1
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCqChm)')
	lcWher = [Select * From SigCqChm Where nCheques=']+CrChm.nCheques+[' ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'CrChm2')	
	Select * From CrChm2 where Bancos+Agencias+ncontas+Ncheques=lcCheque And EmpDopNums # _Posicao ;
	lcWher = [Select * From SigChe Where Nums=']+lcNums+[' ]
	lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'CrChe')	
	Select crChe
	Seek (lcCheque)
		insert into crSigExChq (agencias,bancos,vencs,ncheques,ncontas,nums,;
		lcDelete = [Delete From SigChe Where Nums = ']+CrChe.Nums+[']
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigChe)')
		lcUpDate = [Update SigChe Set Umovs = ']+lcUmovs+[', Numeros=']+lcNumCheques+[', ]+;
		lnErro   = ThisForm.Podatamgr.SqlExecute(lcUpDate,'')
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigChe)')
		lcQuery = [Select * From SigMvPar Where EmpDopNums = ']+_Posicao+[']
		If Thisform.Podatamgr.SqlExecute(lcQuery,'CrPar') < 1
		Select CrPar
				lcUpdate = [Update SigMvPar Set VPags = 0, Pagos = ?lcPago, DtAlts = ?ldDat ] + ;
				If ThisForm.poDataMgr.SqlExecute(lcUpdate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvPar)')
lcDelete = [Delete From SigCdCar Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCar)')
	lcQuery = [Select * From SigCdCtt Where EmpDopNums = ']+_Posicao+[']
	If Thisform.Podatamgr.SqlExecute(lcQuery,'CrCart') < 1
	Select CrCart
		Insert Into crSigExCrt (Numes, Dt_Deposit, Datatrans, FPags, NoCreditos, NoResumos, ;
lcDelete = [Delete From SigCdCtt Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCtt)')
lcDelete = [Delete From SigCdCrd Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigCdCrd)')
lcQuery = [Select * From SigOpDev Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcQuery,'CrDevol') < 1
Select crDevol
			lcUpDate = [UpDate SigMvCab Set ChkSubn = ?lcSubn, ChkBxParcs = ?lcSubn, DtAlts = ?ldDtAlt, DtBaixas = ?llDtBx, DataTrans = Null, UltGrvs = ?lcUltGrv Where CidChaves = ']+CrTmpEest.CidChaves+[']
			If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 13)')
			lcUpdate = [Update SigMvEte Set ChkSubn = ?lcSubn Where EmpDopNums = ']+CrTmpEest.EmpDopNums+[']
				LnErro = ThisForm.PoDataMgr6.SqlExecute(lcUpDate,'')
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcUpDate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvEte )')
			If Seek(CrTmpEest.Dopes,'CrSigCdMei','Dopes')
				lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+CrTmpEest.EmpdopNums+[']
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtt - excluir 3)')
lcDelete = [Delete From SigOpDev Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigOpDev 2)')
	lcSql = [Select CidChaves,empDnCrds,EmpDopNums from SigMvCab where EmpDnCrds = ']+_Posicao+[']
	If Thisform.Podatamgr.SqlExecute(lcSql,'Tmp') < 1
		MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCab (Tmp))')
	Select Tmp
		lcDelete = [Delete From SigMvCab Where CidChaves = ']+Tmp.CidChaves+[']
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCab (Excluir OpCr))')
		lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+Tmp.EmpDopNums+[']
		If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPec (Excluir Opcr))')
	Select csTmpCart
 		lcWhere = [Select Cidchaves, obses From SigCdCtt Where ncarts = ]+Str(CsTmpCart.Ncarts,10)+[ And Emps = ']+CsTmpCart.Empos+[']
		If ThisForm.podatamgr.SqlExecute(lcWhere,'CrTmpCart') < 1
		Select CrTmpCart
			lcUpDate = [UpDate SigCdCtt Set Obses = Null Where CidChaves = ']+CrTmpCart.CidChaves+[']
			If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCtt 2)')
	 		lcWhere = [Select Cidchaves, obses From SigCdCtt Where nLotecs = ]+Str(crTmpCart.nLoteCs,10)+[ And Emps = ']+CrTmpCart.Emps+[']
			If ThisForm.podatamgr.SqlExecute(lcWhere,'CrCart') < 1
			Select CrCart
		 		lcWhere = [Select Cidchaves From SigCdCar Where nLotecs = ]+Str(crTmpCart.nLoteCs,10)+[ And Emps = ']+CrTmpCart.Emps+[']
				If ThisForm.podatamgr.SqlExecute(lcWhere,'CrCar') < 1
				Select CrCar
					lcUpDate = [UpDate SigCdCar Set utilizados  = 0 Where CidChaves = ']+CrCar.CidChaves+[']
					If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCar)')
	insert into crSigExMvc (acres,datars,datas,desc2s,descs,Dopes,;
		Select crEesti
			Insert Into CrSigExMvi From Memvar
lcSql = [Select * From SigOpCsn Where cDopes = ']+TmpEest.Dopes+[']
If Thisform.Podatamgr.Sqlexecute(lcSql,'LocSnOpe') < 1
Select LocSnOpe
Select crEstPe
	lcSql = [Select Dopes, AgdAutos, ddNfs From SigOpCdc Where Dopes = ']+dope+[']
	=Thisform.Podatamgr.Sqlexecute(lcsql,'TmpDcOpe')
	=Seek(Dope,'LocSnOpe','Dopes')
		lcUpDate = [UpDate SigMvCab Set DtBaixas = ?llDtBx, ]+;
		If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
			MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 14')
			lcSql = [Select Sum(Qtdes) as Qtdes From SigBxEst Where EmpDopNumb = ']+CrEest.EmpdopNums+[']
			If Thisform.Podatamgr.Sqlexecute(lcSql,'CsTmpBxEst') < 1
				lcUpdate = [Update SigMvCab Set ChkSubn = ?llFalse, DataTrans = Null, UltGrvs = ?lcUltGrv Where EmpDopNums = ']+CrEest.EmpdopNums+[']
				If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 14')
				lcUpdate = [Update SigMvCab Set ChkSubn = ?llFalse, ChkBxParcs = ?llFalse, DataTrans = Null, UltGrvs = ?lcUltGrv Where EmpDopNums = ']+CrEest.EmpdopNums+[']
				If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvCab 14')
				lcUpdate = [Update SigMvItn Set QtBaixas=0, ChkSubn = ?llFalse Where EmpDopNums = ']+CrEest.EmpdopNums+[']
				If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvItn 14')
				lcUpdate = [Update SigMvIts Set QtBaixas=0, ChkSubn = ?llFalse Where EmpDopNums = ']+CrEest.EmpdopNums+[']
				If ThisForm.Podatamgr.SqlExecute(lcUpDate,'') < 1
					MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvIts 14')
			lcUpdate = [Update SigMvEte Set ChkSubn = ?llFalse Where EmpDopNums = ']+CrEest.EmpDopNums+[']
				LnErro = ThisForm.PoDataMgr6.SqlExecute(lcUpDate,'')
				LnErro = ThisForm.PoDataMgr.SqlExecute(lcUpDate,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigMvEte )')
		If Seek(CrEest.Dopes,'CrSigCdMei','Dopes')
			lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+CrEest.EmpDopNums+[']
			LnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtt - excluir 5)')
			Select CrTmpEstPe
					lcUpdate = [Update SigMvPec Set ChkSubn = ?llFalse, DtAGends = ?ldDtNull Where Cidchaves = ']+CrTmpEstpe.CidChaves+[']
					If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
					lcUpdate = [Update SigMvCab Set ChkSubn = ?llSubn, DtAgends = ?llDtAgd, DataTrans = Null, UltGrvs = ?lcUltGrv Where EmpDopNums = ']+CrTmpEest.EmpDopNums+[']
					If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
					lcUpdate = [Update SigMvPec Set ChkPagos = ?llFalse Where Cidchaves = ']+CrTmpEstpe.CidChaves+[']
					If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
					lcUpdate = [Update SigMvCab Set ChkPagos = ?llPago, DataTrans = Null, UltGrvs = ?lcUltGrv Where EmpDopNums = ']+CrTmpEest.EmpDopNums+[']
					If ThisForm.PodataMgr.SqlExecute(lcUpdate,'') < 1
				If Seek(CrTmpEest.Dopes,'CrSigCdMei','Dopes')
					lcDelete = [Delete From SigMvEtt Where EmpdopNums = ']+CrTmpEest.empDopNums+[']
					LnErro = ThisForm.PoDataMgr.SqlExecute(lcDelete,'')
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtt - excluir 6)')
lcDelete = [Delete From SigMvItt Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvItt)')
lcDelete = [Delete From SigMvEtd Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtd)')
lcDelete = [Delete From SigMvPec Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvPec)')
lcDelete = [Delete From SigMvMov Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvMov)')
lcDelete = [Delete From SigMvEtv Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEtv)')
lcDelete = [Delete From SigMvEte Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvEte)')
lcDelete = [Delete From SigMvCab Where EmpDopNums = ']+_Posicao+[']
If Thisform.Podatamgr.SqlExecute(lcDelete,'') < 1
	MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Delete SigMvCab 5)')
Select crSigCdNec
Select LocalEest
		lcQuery = [Delete From SigMvItn Where EmpDopNums = ']+ _ChaveEest +[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Delete From SigMvIts Where EmpDopNums = ']+ _ChaveEest +[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Delete From SigMvCab Where EmpDopNums = ']+ _ChaveEest +[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Delete From SigBxEst Where EmpDopNums = ']+ _ChaveEest +[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalHis
			lcQuery = [Delete From SigMvHst ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalEestI
			lcQuery = [Update SigMvItn Set QtReservas = 0, QtProds = 0, QtBxProds = 0, DtAlts = ?pDat ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalEstI2
			lcQuery = [Update SigMvIts Set QtReservas = 0, QtProds = 0, QtBxProds = 0 ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigMvCab ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Select Emps, Dopps, Numps, cIdChaves ] + ;
			    [From SigCdNec ] + ;
			   [Select Emps, Dopps, Numps, CidChaves From SigCdNec ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
	Select LocalNens
		Select LocalNensi
			lcQuery = [Delete From SigCdNei ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalOpi
			lcQuery = [Delete From SigOpPic ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalHis
			lcQuery = [Delete From SigMvHst ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		Select LocalMFas
			lcQuery = [Delete From SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Delete From SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select xNensi
lcSql = [Select * From SigOpOeo Where Dopps = ']+CrSigCdNec.Dopps+[' ]
If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalEopp') < 1
Select CsCabec
Select CsItens
Select LocalEOpp
	lcSql = [Select * From SigCdOpe where Dopes = ']+LocalEOpp.Dopes+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSigCdOpe') < 1
	Insert Into CsCabec (EmpDs, Emps, Dopes, Datas) Values ;
	lcSql = [Select b.cpros,b.Qtds,b.EmpDopNums,b.Numes,c.Ndopes From SigPdMvf a, SigOpPic b, SigCdOpe c ]+;
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalMfas') < 1
		Select LocalMfas
			lcSql = [Select a.cmats,a.qtds,a.Pesos From SigCdNei a ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalNensi') < 1
			Select LocalNensi
		Select Distinct nDopes,Numes From LocalMfas Into cursor CsSubNiveis
		Select CsSubNiveis
			Select CsEstPe
			Insert Into CsEstPe (Dopes,Codigos,Emps ) Values (LocalEOpp.Dopes,lnCod,CrSigCdNec.Emps)
Update CsItens Set EmpDopNums = Emps + Dopes + Str(Numes,6)
Update CsCabec Set EmpDopNums = Emps + Dopes + Str(Numes,6)
Update CsEstPe Set EmpDopNums = Emps + Dopes + Str(Numes,6)
lcSql = [select * from SigCdPro where cpros = ']+pproduto+[']
ThisForm.Podatamgr.sqlexecute(lcSql,'CrTmpPro')
Select ( pcArq )
	lcSql = [Select Codigos From SigCdLpc where lPrecos = ']+CsCabec.lPrecos+[']
	lnErro = ThisForm.podatamgr.SqlExecute(lcSql,'CrtmplPre')
	lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+CsCabec.lPrecos+[']
	lnErro = ThisForm.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
	Select CrSigCdLpi
					lcQuery = [Select Moevs, Pvens From SigPrFnc Where Cpros = ']+CrTmpPro.Cpros+[' And Ifors = ']+_Ct+[']
					=ThisForm.Podatamgr.Sqlexecute(lcQuery,'CrTmpFpro')
				lcQuery = [Select MoeQs, QtdEqs ] + ;
						    [From SigCdMoe ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpMoe') < 1)
		Select ( pcArq )
Select ( pcArq )
Select ( pcArq )
lcQuery = [Select Distinct TpOps From SigCdRpo Where Dopps = ']+CrSigCdOpd.Dopps+[' ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmprOpt') < 1)
	lcQuery = [Select Distinct TpOps From SigCdRpo Where Dopps = ']+CrSigCdOpd.Dopps+[' ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmprOpt') < 1)
lcQuery = [Select Cods, Descs, pFalhas, Grupos ] + ;
			[From SigOpOpt ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpOpt') < 1)
Select TmpRopt
	Select a.* from TmpOpt a, TmpRopt b Where a.Cods = b.TpOps Into Cursor csSelecao ReadWrite
	Select * From TmpOpt Into Cursor CsSelecao ReadWrite
Select CsSelecao
Select crSigCdNec
	lcQryNens  = [Select * From SigCdNec ] + ;
	lcQryNens  = [Select * From SigCdNec ] + ;
lcQryNensI = [Select * From SigCdNei]
lcQryMFas  = [Select * From SigPdMvf]
lcQryHis   = [Select * From SigMvHst]
lcQryMccr  = [Select * From SigMvCcr]
lcQryMcpv  = [Select * From SigMvCpv]
lcQryEti   = [Select * From SigOpEtq]
lcQryPEti  = [Select * From SigEtPos]
lcQryEest  = [Select * From SigMvCab]
lcQryEestI = [Select * From SigMvItn]
lcQryMvIts = [Select * From SigMvIts]
lcQrySubMv = [Select * From SigSubMv]
lcQryDelet = [Select * From SigExMvc]
lcQryInc   = [Select * From SigOpInc]
		Select * From CrSigCdNec Into Cursor CrProcurar ReadWrite
		Select CrProcurar
		Select crSigCdOpd
		Select crSigCdSvc
		lcQuery = [Select Codigos, Descrs, TrfPesas, CompAgrus, CtrLotes, UnifBals ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpGccr') < 1)
		Select TmpGccr
			lcQuery = [Select IClis, RClis, Grupos, Inativas ] + ;
					    [From SigCdCli ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
			Select TmpCli
		Select crSigCdOpd
		If Not Seek(ThisForm._Dopp)
			Select CrSigCdNec
Select CrSigCdNec
	Select crProcurar
		If Not Seek(lcChv, 'crSigCdNec', 'Numps')
		 	Insert Into crSigCdNec From MemVar
Select CrSigCdNec
	Select CrSigCdNec
	=Seek(ThisForm.pemps + ThisForm._dopp + Str(ThisForm.Locregister,10))
Select crSigCdOpd
=Seek(crSigCdOpd.Nivels, 'crSigCdOpd', 'Dopps')
Select TmpNens
lcQuery = [Delete From SigCdNei Where EmpDnPs = '] + _ChaveDel1 + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcSql = [Select Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams From SigMvHst where OriDopNums = ']+_ChaveDel2+[']
If (ThisForm.poDataMgr.SqlExecute(lcSql,'LocalHis') < 1)
Select LocalHis
lcQuery = [Delete From SigMvHst Where OridopNums = '] + _ChaveDel2 + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Select EmpDnPs From SigCdNec Where nLotes = ] + Alltrim(Str(TmpNens.nLotes)) + [ And EmpDnPs <> '] + _ChaveDel1 + [']
	ThisForm.Podatamgr.Sqlexecute(lcQuery,'LocalNlt')
	Select LocalNlt
		lcQuery = [Delete From SigPdNlt Where nLotes = ] + Alltrim(Str(TmpNens.nLotes))
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalMccr
	lcQuery = [Delete From SigMvCcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalEti
		lcQuery = [Update SigOpEtq ] + ;
		lcQuery = [Delete From SigOpEtq ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigOpPic set Codbarras = 0 ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigEtPos ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalEest
	lcQuery = [Delete From SigMvItn ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigMvIts ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigSubMv ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcSql = [Select Emps, Grupos, Estos, Cpros, Datas, CodCors, CodTams From SigMvHst where OriDopNums = ']+LocalEest.EmpDopNums+[']	
	If (ThisForm.poDataMgr.SqlExecute(lcSql,'LocalHis') < 1)
	Select LocalHis
	lcQuery = [Delete From SigMvHst Where OridopNums = '] + LocalEest.empDopNums + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Delete From SigBxEst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	Select LocalMccr
		lcQuery = [Delete From SigMvCcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select LocalMFas
		Select LocalNens
			lcQuery = [Update SigCdNec ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update - SigCdNec 1)')
		Select LocalNens
			lcQuery = [Update SigCdNec ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update - SigCdNec 2)')
	Select LocalOpi
			lcQuery = [Update SigMvCab ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update - SigMvCab)')
	lcQuery = [Delete From SigPdMvf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
	Select LocalNens
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Excluir - Update - SigCdNec)')
lcQuery = [Delete From SigOpInc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigPrJus ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
lcQuery = [Delete From SigCdNec ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	lcQuery = [Update SigInAop Set EmpDnPs = ' ' Where EmpDnPs = ']+TmpNens.EmpDnPs+[']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, ' ') < 1)
	Insert Into crSigExMvc (Datars, Datas, Dopes, Emps, Grupoos, Contaos, Grupods, Contads, Numes, ;
	If Not ThisForm.poDataMgr.Update('crSigExMvc')
Delete From crProcurar Where Numps = TmpNens.NumPs
lcQuery = [Select * From SigInBep Where EmpDnPs = ']+_ChaveDel1+[']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCabEP') < 1)
lcSql = [Select Distinct Dopes from SigCdMei Order by Dopes ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdMei')
Select CrSigCdMei
Select * From CrSigMvCab Where 0=1 Into Cursor TmpEest ReadWrite
Select LocalCabEp
	lcSql = [Select * From SigMvCab Where EmpDopNums = ']+LocalCabEp.EmpDopNums+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalEest') < 1)
	Select TmpEest
	Select LocalEest
	Insert Into TmpEest From Memvar
	Select Distinct CodProPads as CPros, Dopes ;
	  From TmpOpe ;
	lcWher = [Select Dopeds as Dopes, Cpros From SigOpTrf ]+;
	lnErro = ThisForm.Podatamgr.SqlExecute(lcWher,'CsOpeTrf')
	Select CsOpeTrf
lcQuery = [Delete From SigInBep ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select xMFas
=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
Select CrSigCdOpd
Select CrSigCdNei
Select xNensI
Select * From xNensI Where Not Empty(TPOPS) Into Cursor csCompOps Readwrite
Select csCompOps
Select xNensI
Delete All For Empty(Nops) And Empty(CMats) And Empty(Cats) And (Rateio <> 1)
Delete All For !Visivel And CrSigCdOpd.SepPedras = 1 && Tiago - 30/01/2013 - Deleta dos itens (pedras) que já estão agregados, para não dar erro no rateio quando for operação SEPARA PEDRAS
	Select xPesa
	Select Nops, Nenvs, MatPs, Sum(Peso) As Pesos ;
		From xPesa ;
	Select xRateio
		Select xNensI
		If Seek(_Nenv)
					Select xNensI
			Select xNensI
			If Seek(_Nops)
				Select xNensI
			Insert Into xNensI (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio, Peso2s) ;
				Select xNensI
					Select xNensI
					Select xNensI
						Select xNensI
Select xMFas
Select xNensI
	Select xMFas
		lcsql = [Select MatPrincs,Cgrus From SigCdPro Where Cpros = ']+xMFas.codpds+[']
		Thisform.poDataMgr.SqlExecute(lcsql,'LocalPro')
		lcsql = [Select Mercs From SigCdGrp Where Cgrus = ']+LocalPro.Cgrus+[']
		Thisform.poDataMgr.SqlExecute(lcsql,'LocalGru')
		lcsql = [Select MatPrincs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
		Thisform.poDataMgr.SqlExecute(lcsql,'LocalGgrp')
		lcSql = [Select Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds, CodTgops, citens From SigOpPic Where Nops = ]+Str(xMFas.Nops)
		Thisform.PodataMgr.SqlExecute(lcsql,'LocalOpi')
		lcSql = [Select Globalizas, servicos From SigCdOpe Where Dopes = ']+LocalOpi.Dopes+[']
		ThisForm.PodataMgr.SqlExecute(lcsql,'LocalOpe')
		Select xMFas
			Select csCompOps
			Select * from csCompOps Where Nenvs = _nEnvs And Nops = _nOps Into Cursor csResCpOs ReadWrite
			Select csResCpOs
				Select csCompOps
				Select * from csCompOps Where Empty(Nenvs) And Empty(Nops) Into Cursor csResCpOs ReadWrite
				Select csResCpOs
				Select xMFas
				Insert Into xNensI (Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio, TPOPS, FlagIncs, Nenvs, Nops) ;
		Insert Into xNensI (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio, TPOPS, FlagIncs) ;
&&Select * From CrSigCdNei Where 0 = 1 Into Cursor LocalNensI ReadWrite
Select * From xNensI Where 0 = 1 Into Cursor LocalNensI Readwrite
Select LocalNensI
Select xNensI
	If Not Seek(lcBusca,'LocalNensI','Gravar')
		Insert Into LocalNensI (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, TPOPS, Cats, Obss, ;
			Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, Empos, Qtds, Grupos, ;
			Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, Empos, Qtds, Grupos, ;
	Select xMFas
	If (Not Empty(xNensI.Nops) And Seek(xNensI.Nops) And (LocalGru.CEstoqs = 1)) Or (Not Empty(xNensI.Nenvs) And Seek(xNensI.Nenvs) And (LocalGru.CEstoqs = 1)) And LocalGru.Semiacabs <> 1 && Tiago - 13/10/2015 - Quando for semiacabado não agrega pois agrega os componentes dele
		lcQuery = [Select Top 1 Datas, Horas, Valos ] + ;
			[From SigCdCot ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCot') < 1)
		Select LocalCot
		lcQuery = [Select a.comis from SigCdCrg a inner join SigCdCli b on a.CCargs = b.CCargs where Iclis = '] + _Conta + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalCar') < 1)
		Select LocalCar
		Select crSigMvCcr
		Insert Into crSigMvCcr (NOpers, Emps, DataS, UsuAlts, DatAlts, Vencs, Hists, Autos, Dopes, Numes, Tipos, ;
		Insert Into crSigMvCcr (NOpers, Emps, DataS, UsuAlts, DatAlts, Vencs, Hists, Autos, Dopes, Numes, Tipos, ;
	Select xNensI
Select CrSigCdNei
Append From Dbf('LocalNensI')
	Select xMFas
			lcQuery = [Select Ordems, Grupos ] + ;
				[From SigCdPrf ] + ;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalProF') < 1)
			Select LocalProf
				lcQuery = [Select Grupos, Ordems ] + ;
					[From SigCdPrf ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalProF') < 1)
				Select LocalProf
						lcQuery = [Select Grupos, Ordems ] + ;
							[From SigCdPrf ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalProF') < 1)
						Select LocalProf
		Select xMFas
		Insert Into crSigPdMvf (Emps, Dopps, Numps, Datars, DataS, Usuars, Opers, GrupoOs, Contaos, Grupods,;
Select xNensiS  &&Serviços
	Insert Into CrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, TPOPS, Cats, Obss, AQtds, ;
Select xNensiJ &&Justificativas
	Insert Into CrSigPrJus (Emps, Dopps, Numps, Nops, Nenvs, cIdChaves, EmpDNPs, cRetrabs, Cods ) ;
	Select xMFas
		lcQuery = [Select CidChaves From SigPdMvf ] + ;
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'TmpMfad') < 1)
			=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Delete 1- SigPdMvf)')
		Select TmpMfad
			lcQuery = [Delete From SigPdMvf Where CidChaves = ']+TmpMfad.cIdChaves+[']
			If (Thisform.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Delete 2 - SigPdMvf)')
	Select xMFas
		Select LocalOpi
			If Not Seek(lcEdn, 'xTotPed')
				Insert Into xTotPed (Emps, Dopes, Numes) ;
	Select xTotPed
		Select LocalOpi
			lcQuery = [Update SigMvCab ] + ;
			If (Thisform.poDataMgr.SqlExecute(lcQuery, '') < 1)
				=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Update - SigMvCab)')
		Select Nenvs, Sum(Qtds) As Qtds ;
			From xPesa ;
		Select a.Nenvs, Sum(a.Pesos) As Pesos, b.Qtds ;
			From xNensI a, TPesa b ;
		Select xRateio
		Select xPesa
			Select xRateio
			If Seek(_Nenv) And (xRateio.Pesos <> 0) And (CrSigCdOpd.PesMatPs)
				Select xPesa
				Select xPesa
	Select xPesa
		lcsql = [Select a.Cgrus, b.cestoqs, c.Etiqs, b.TipoEstos, c.CEstos, a.CUnis, a.CUnips From SigCdPro a, SigCdGrp b, SigCdUni c Where a.Cpros = ']+xPesa.CPros+[' ]+;
		=Thisform.poDataMgr.SqlExecute(lcsql,'LocalPro')
			Select xPesa
			lcSql = [Select Globalizas, servicos From SigCdOpe Where Dopes = ']+xPesa.Dopes+[']
			ThisForm.PodataMgr.SqlExecute(lcsql,'crConserto')
			Select xPesa
					Insert Into crSigOpEtq (Cbars, CPros, Pesos, Qtds, Emps, Dopes, Numes, DataS, Empos, Grupos, Contas, ;
					Insert Into crSigOpEtq (Cbars, CPros, Pesos, Qtds, Emps, Dopes, Numes, DataS, Empos, Grupos, Contas, ;
				lcQuery = [Update SigOpPic ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Update - SigOpPic)')
					Insert Into crSigEtPos (Cbars, CPros, Pesos, Qtds, Emps, Dopes, Numes, DataS, Empos, Grupos, Contas, ;
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, Empos, Qtds, ;
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, Empos, Qtds, ;
		lcsql = [Select Cpros, cItens, QtProds, QtBxProds, cidchaves From SigMvItn Where EmpDopNums = ']+lcEdn+[' ]+;
		If Thisform.poDataMgr.SqlExecute(lcsql,'LocalEestI') < 1
		Select LocalEestI
				Select LocalEestI
				lcQuery = [Update SigMvItn ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Update - SigMvItn 1)')
				lcQuery = [Select QtProds, QtBxProds, cIdChaves ] + ;
					[From SigMvIts ] + ;
				If (Thisform.poDataMgr.SqlExecute(lcQuery, 'LocalEstI2') < 1)
				Select LocalEstI2
						lcQuery = [Update SigMvIts ] + ;
						If (Thisform.poDataMgr.SqlExecute(lcQuery, '') < 1)
							=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (mSv_Inserir - Update - SigMvIts)')
		lcsql = [Select * From SigCdOpe Where dopes = ']+_Dope+[']
		=Thisform.poDataMgr.SqlExecute(lcsql,'CrSigCdOpe')
			Select *, Space(10) As Grupods, Space(10) As Contads, Space(10) As GrupoOs, Space(10) As Contaos ;
				From crSigEtPos Into Cursor Localpeti Order By cIdChaves Readwrite
			Select *, Space(10) As Grupods, Space(10) As Contads, Space(10) As GrupoOs, Space(10) As Contaos ;
				From crSigOpEtq Into Cursor Localpeti Order By Cbars Readwrite
		Select Localpeti
			lcsql = [Select GrupoOs, ContaOs, GrupoDs, ContaDs From SigMvCab ]+;
			Thisform.poDataMgr.SqlExecute(lcsql,'LocalEest')
		Select Sum(Qtds) As Qtds , Sum(Pesos + Peso2s) As Pesos, Nops From Localpeti Group By Nops Into Cursor crTotEti Readwrite
		Select Localpeti
				Insert Into crSigMvCab (Emps, EmpDs, Dopes, Numes, MascNum, DataS, Datars, Usuars, GrupoOs, Contaos, ;
			Insert Into crSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, CUnis, Dpros, ;
				Insert Into crSigMvIts ( CItens, CPros, Emps, Dopes, Numes, Qtds, QtdEmbs, Pesos, CodCors, CodTams, CodEmbs, EmpDopNums, cIdChaves, DtAlts ) ;
				Select crSigOpEtq
			Select crTotEti
				Select xPesa
				Select xNensI
				If Seek(_Nenv)
				Select * From xPesa Where Nops = _Nenv Into Cursor crRatCompo
				Select xNensI
						lcsql = [Select a.Mats, a.Qtds, a.cats, a.grupos, a.ordems, a.cunis as unicompos, a.Pesos, a.units as pcompos, a.moevs as moeds ]+;
							[From SigSubMv a ]+;
						=Thisform.poDataMgr.SqlExecute(lcsql,'LocalCompo')
						Select LocalCompo
						lcsql = [Select Mats, Qtds, Cats, Grupos, Ordems, UniCompos, Pesos, pCompos, Moeds  From SigPrCpo Where Cpros = ']+Localpeti.CPros+[' ] +;
						Thisform.poDataMgr.SqlExecute(lcsql,'LocalCompo')
						Select crRatCompo
							lcsql = [Select a.Mats, a.Qtds, a.cats, a.grupos, a.ordems, a.cunis as unicompos, a.Pesos, a.units as pcompos, a.moevs as moeds ]+;
								[From SigSubMv a ]+;
							=Thisform.poDataMgr.SqlExecute(lcsql,'LocalCompo')
							Select LocalCompo
					Select xNensI
					Insert Into crSigSubMv (CItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, CUnis, CUniPs, Dpros, ;
					Select crSigOpEtq
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, ;
				Insert Into crSigMvHst ( Usuars, Datars, Opers, Dopes, Numes, DataS, CPros, Qtds, ;
		=Thisform.poDataMgr.SqlExecute([Select Top 1 Cods from SigStats Order By Cods Desc],[CrTmpStats])
		Select CrTmpStats
			Select xNensi 
			Select Distinct Nops From xNensi where Not Empty(Nops) Into Cursor csTmpNops ReadWrite 
			Select csTmpNops
				lcQuery = [Select EmpDopNums From SigOpPic Where Nops = ]+Str(csTmpNops.Nops,10)
				=Thisform.poDataMgr.SqlExecute(lcQuery,'CrTmpOpPic')
				Select CrTmpOpPic
				lcQuery = [Select distinct c.empdopnums, d.nemps, right(a.codigos,6) as codigos ] + ;
						[from sigmvpec a ] + ;
						[join sigcdemp d on a.empsubns = d.cemps ] + ;
						[join sigmvcab c on a.empsubns = c.emps and right(a.codigos,6)=c.numes ] + ;
						[Join (select a.Dopes from sigcdope a ] + ;
							[join sigmvpec b on a.ndopes = left(b.Codigos,len(b.codigos)-6) where b.empdopnums = ']+lcEdnOp+[' ) b on c.dopes = b.dopes ] + ;
				=Thisform.poDataMgr.SqlExecute(lcQuery,'CrTmpProdu')
				Select CrTmpProdu
				Select a.EmpDopNums from CrTmpProdu a ;
					Join xNensi b on a.Codigos = Right(Str(b.Nops,10),6) ;
				Select crAtStatus
					lcUpdate = [Update SigMvCab Set PStatus = ']+lcPStatus+[' Where EmpDopNums = ']+crAtStatus.EmpDopNums+[' ]
					=Thisform.poDataMgr.SqlExecute(lcUpdate)
					Select crAtStatus
				lcUpdate = [Update SigMvCab Set Nops = ]+Str(lnNop,10)+[ Where EmpDopNums = ']+lcEdnOp+[' ]
				=Thisform.poDataMgr.SqlExecute(lcUpdate)
				Select csTmpNops
		lcsql = [Select * From sigopfin Where dopes = ']+_Dope+[' and codigos <> space(10)]
		=Thisform.poDataMgr.SqlExecute(lcsql,'CrSigOpFin')
			Select crSigMvCab
					Select Moedas, Sum(totas) As totas From crSigMvItn Where EmpDopNums = crSigMvCab.EmpDopNums Group By 1 Into Cursor crSoma
				Select crSigMvCcr
					Insert Into crSigMvCcr (NOpers, VOpers, Emps, DataS, UsuAlts, DatAlts, Vencs, Hists, Opers, SOpers, Moedas, ;
				Select TmpComiss
							Insert Into crSigMvCcr (NOpers, VOpers, Emps, DataS, UsuAlts, DatAlts, Vencs, Hists, Opers, SOpers, Moedas, ;
	Select * From crSigMvItn Into Cursor xEesti Where 0=1 Readwrite
	Select Nenvs, Nops, CMats, Qtds, Pesos, Peso2s,cIdChaves  From CrSigCdNei ;
	Select crSigMvCab
	Select TmpNensi
		lcsql = [Select Cpros From SigOpPic where Nops = ]+Str(TmpNensi.Nops)
		Thisform.poDataMgr.SqlExecute(lcsql,'LocalOpi')
		lcsql = [Select a.emps,a.Numes,a.GrupoOs,a.ContaOs,a.GrupoDs,a.ContaDs,]+;
			[from SigMvCab a, SigMvItn b Where a.Nops = ]+Str(lnOp)+[ ]+;
		lnErro = Thisform.poDataMgr.SqlExecute(lcsql,'CrTmpEesti')
		Select CrTmpEesti
			lcUpDate = [UpDate SigMvItn Set QtBaixas = ]+Str(CrTmpEesti.QtBaixas,12,3)+[, ChkSubn = ?llBaixa ]+;
			lnErro = Thisform.poDataMgr.SqlExecute(lcUpDate,'')
			lcsql = [Select cpros,dpros,cunis from SigCdPro where cpros = ']+lcPro+[']
			If Thisform.poDataMgr.SqlExecute(lcsql,'LocalPro') < 1
			Select crSigMvCab
			If Not Seek(CrSigCdOpd.DopEmphs+CrTmpEesti.GrupoOs+CrTmpEesti.Contaos+CrTmpEesti.Grupods+CrTmpEesti.Contads)
				Insert Into crSigMvCab (MascNum,DataS,Datars,Dopes,Emps,Numes,GrupoOs,Contaos,Grupods,Contads,;
			Select crSigMvItn
			Insert Into crSigMvItn (CItens,CPros,CUnis,Dopes,Dpros,Emps,Numes,Opers,Qtds,;
			Insert Into crSigBxEst ( Emps, Dopes, Numes, CItens, CPros, Qtdes, ;
Select xMFas
Select xNensiN  &&não conformidades
	=Seek(xNensiN.Nops,'xMfas')
	Insert Into crSigOpInc (Nops, Cods, CPros, Nenvs, Qtds, EmpDNPs, DataS, cIdChaves, Grupos, Contas, Descs, Conta2s ) Values ;
Select xNensiNC  &&Autorizações
	Insert Into crSigOpInc (Cods, Nenvs, Qtds, AQtds, EmpDNPs, DataS, cIdChaves, Grupos, Contas, Descs, Usuars ) Values ;
Select TmpNens
Delete From crProcurar Where Numps = TmpNens.Numps
	Select * From xNensI Where CarCompos And Visivel Order By Nenvs, Amarracao Into Cursor crTmpSacb Readwrite
		lcsql = [Select * From SigCdOpe Where Dopes = '] + _Dope + [']
		=Thisform.poDataMgr.SqlExecute(lcsql,'crSigCdOpe')
		Select crSigMvCab
		Insert Into crSigMvCab (MascNum,DataS,Datars,Dopes,Emps,Numes,GrupoOs,Contaos,Grupods,Contads,cIdChaves,EmpDopNums,EmpDnCrds,Usuars) Values ;
		Select crTmpSacb
			Insert Into crSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, CUnis, Pesos, CUniPs, Dpros, ;
				Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, DataS, CPros, units, Moedas, ;
				Insert Into crSigMvHst ( Usuars, Datars, Opers, Dopes, Numes, DataS, CPros, Qtds, units, Moedas, ;
		lcSql = [Select * from SigCdNec Where EmpDnPs = ']+lcEdn+[']
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpProcurar')
		Select TmpProcurar
			If Not Seek(TmpProcurar.Numps,'CrProcurar','numps')
				Insert into crProcurar From memvar
		lcSql = [Select * from SigCdNec Where Docus = ']+lcDocu+[']
		=ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpProcurar')
		Select TmpProcurar
			If Not Seek(TmpProcurar.Numps,'CrProcurar','numps')
				Insert into crProcurar From memvar
lcQuery = [Select a.Mats, a.Qtds, b.GrupoBxps, b.ContaBxps ] + ;
            [From SigPrCpo a, SigCdGrp b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCompo]) < 1)
PROCEDURE insertintomvhst
Select LocalCompo
    Insert Into crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, CPros, Empos, Qtds, Grupos, Estos, cIdChaves, ;
Select crSigCdNec
		Select crSigCdNec
	lcsql = [Select * From SigPdNlt Where nLotes = ]+Str(crSigCdNec.nLotes)
	ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalNlt')
	=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')	
		Select LocalMFas
			lcQuery = [Select Nops, Datas, Emps, Dopps, Numps, cIdChaves ] + ;
						[From SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNops') < 1)
			Select LocalNops
		Select LocalEti
				lcSql = [Select a.empdopnums as EDNCDNEC, c.empdopnums as EDNMVCAB, b.OriDopNums, b.EmpDopNums as EDNMVHST from SigOpEtq a ] +;
							[Inner join (Select Top 1 OriDopNums, EmpDopNums, CodBarras, Seqs From SigMvHst Where CodBarras = ] + Alltrim(Str(LocalEti.CBars,14)) + [ Order By CodBarras, Seqs Desc) b ] +;
							[Inner Join SigMvCab c On a.EmpDopNums = c.EmpDnCrds ] + ;
							[Inner Join SigMvItn d On c.EmpDopNums = d.EmpDopNums And d.Codbarras = a.Cbars	] + ;
				If ThisForm.podatamgr.Sqlexecute(lcsql,'LocalMvCab') < 1
				Select LocalMvCab
		Select LocalMccr
	=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
		lcQuery = [Select Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
		lcQuery = [Select Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
	Select crSigCdNec
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	Select crSigCdNec
		lcQuery = [Select Nops, Datas, Emps, Dopps, Numps, cIdChaves ] + ;
					[From SigPdMvf ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
		Select LocalMFas
			Select crSigCdNec
		Select TmpNens
	Select crSigCdNec
			lcUpDate = [Update SigCdNec ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcUpDate,'') < 1)
		Insert Into TmpNens (Chksubn, Datars, Datas, Datatrans, Dopps, Emps, Numps, Usuars, TotPesos, Obss, ;
		=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		=Seek(crSigCdOpd.Nivels, 'crSigCdOpd', 'Dopps')
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		lcQuery = [Select Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ] + ;
					[From SigPdMvf ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
		Select LocalMFas
			lcSql = [Select Descs From SigPrCrt Where cods = ']+LocalMfas.cRetrabs+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCrt') < 1
			lcSql = [Select cods From SigPrJst Where cRetrabs = ']+LocalmFAS.cRetrabs+[']
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalJust') < 1
			Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
			If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
				Insert Into TmpOperacao (Codigos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs)
			lcQuery = [Select Emps, Dopes, Numes, EmpDs, Qtds, CodCors, CodTams, CodBarras, citens ] + ;
						[From SigOpPic ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpi') < 1)
			Select LocalOpi
				Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes, ;
			lcQuery = [Select a.Nenvs, a.GrupoDs, a.ContaDs, a.Dopps, a.Numps, a.cRetrabs, a.datas, b.descs, c.Rclis ]+;
					  [From SigPdMvf a, SigPrCrt b, SigCdCli c ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'Lcmfas5') < 1)
			Select Lcmfas5
				Insert Into xNensiR (nenvs, EmpDopNums, Datas, Destinos, Retrabs, Rclis ) Values ;
		lcQuery = [Select * From SigCdNei ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
		Select LocalNensI
					Insert Into xNensI (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs,  QtFaseAnt, Qtds, PsFaseAnt, ;
						If Not Seek(Str(_Nenv, 10) + _BMat + _TMat, 'xNensi', 'NEnvTpops')
							Insert Into xNensI (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, ;
						Select xNensI
					Insert Into xNensI (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs,  QtFaseAnt, Qtds, PsFaseAnt, ;
						Insert Into xNensIs (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
					If Not Seek(LocalNensI.Nops, 'xMfas', 'Nops')
						lcQuery = [Select EmpDNPs, Emps, Dopps, Nops ] + ;
									[From SigOpPic ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalOpi') < 1)
						lcQuery = [Select Nops, Qtds, Codpds, Pesos ] + ;
									[From SigPdMvf ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas') < 1)
						Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
					If Not Seek((_NumNivel * 10000000000) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
						Insert Into TmpOperacao (Codigos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs)
			Select LocalNensI
		lcQuery = [Select * From SigOpInc Where EmpDnPs = ']+_ChaveNens+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalInc') < 1)
		Select LocalInc
				Insert Into xNensiNC From memvar
				Insert Into xNensiN From Memvar
		lcQuery = [Select a.*, b.Descrs as Descs From SigPrJus a, SigPrJst b Where a.EmpDnPs = ']+_ChaveNens+[' And a.Cods = b.Cods ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalJust') < 1)
		Select LocalJust
			Insert Into xNensiJ From Memvar
		Select TmpOperacao
			Select LocalPEti
				Insert Into xPesa (Cbars, Cpros, Peso, Qtds, Emps, Dopes, Numes, Nops, Oper, Conta, Obs, Cors, Tams, MatPs, Nenvs) ;
			Select LocalEti
				Insert Into xPesa (Cbars, Cpros, Peso, Qtds, Emps, Dopes, Numes, Nops, Oper, Conta, Obs, Cors, ;
		Select crSigCdNec
		Insert Into TmpNens (Emps, Dopps, Numps, Usuars, Datars, Datas) ;
	 	Select TmpOperacao
	 	Select TmpOperacao
	=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	Select crSigCdOpd
		Select TmpNens
	Select TmpNens
Select TmpNens
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	Select xMFas
			Select LocalPro
		Select TmpOperacao
		Select Codigos from TmpOperacao Where Not Empty(Codigos) into Cursor csQtdOPs ReadWrite 
		Select csQtdOPs
		Select xNensI
				lcSql = [Select cEstos From SigCdUni Where cunis = ']+xnensi.cunis+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
			Select xNensI			
			=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
		Select xNensI
			Select xMfas
	Select xNensI
		lcQuery = [Select Codigos, Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
		lcQuery = [Select Codigos, Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
	=Seek(TmpNens.GrupoOs,'TmpGccr','balcodigo')
	=Seek(TmpNens.GrupoDs,'TmpGccr','balcodigo')
			Select TmpOperacao
				lcQuery = [Select b.nlotes from SigPdMvf a Inner Join SigCdNec b on a.EmpDnPs = b.EmpDnPs ] +;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery,'TmpOpLote') < 1)
			lcsql = [Update SigPdNlt Set ChkSubn = 1 Where nLotes = ]+ Alltrim(Str(TmpNens.nLotes))
			lcsql = [Update SigPdNlt Set ChkSubn = 0 Where nLotes = ]+ Alltrim(Str(TmpNens.nLotes))
		If (ThisForm.poDataMgr.SqlExecute(lcSql,'') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigPdNlt)')
		lcSql  = [Select * From SigCdNec Where nLotes = ]+ Alltrim(Str(TmpNens.nLotes))
		Thisform.Podatamgr.sqlexecute(lcsql,'TmpMov')
			Select CrSigPdNlt
			lcsql = [Update SigPdNlt ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcSql,'') < 1)
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigPdNlt)')
			lcsql = [Select * From SigPdNlt Where EmpGruEsts = ']+TmpNens.Emps+TmpNens.GrupoDs+TmpNens.ContaDs+[' ]+;
			Thisform.Podatamgr.sqlexecute(lcsql,'TmpNlt')
				Insert Into CrSigPdNlt (nLotes,Emps,Grupos,Contas,EmpGruEsts,Datas) Values ;
			Select CrSigPdNlt
		Select xPesa
		Select xNensiS
				Select crSigCdSvc
					Case Seek(xNensiS.Cats + xNensiS.GrupoFs + xNensiS.ContaFs )
					Case Seek(xNensiS.Cats + xNensiS.GrupoFs + Space(10))
					Case Seek(xNensiS.Cats + Space(20))
					Select xNensis
		lStrQuery = [Select Setors From SigCdCle Where ClaGrupos = ']+TmpNens.GrupoDs+[' And ClaContas = ']+TmpNens.ContaDs+[']
		If (ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrTmpClaes') < 1)
		Select CrTmpClaes
		Select xMfas
			lcQuery = [Select GrupoDs,ContaDs ] + ;
					    [From SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
			Select LocalMFas2
				lStrQuery = [Select Setors From SigCdCle Where ClaGrupos = ']+LocalMfas2.GrupoDs+[' And ClaContas = ']+Localmfas2.ContaDs+[']
				If (ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrTmpClaes') < 1)
				Select CrTmpClaes
		Select crSigCdNec
			If llTaOK And Not ThisForm.poDataMgr.Update('crSigExMvc')
				=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigExMvc)')
			Select xNensI
			Select xMfas
		Select CrSigCdNec
		Insert Into crSigCdNec (Datars, Datas, Emps, Dopps, Numps, Obss, Usuars, TotPesos, Grupoos, Contaos, Grupods, ;
		If llTaOk And Not ThisForm.poDataMgr.Update('crSigCdNec')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNec)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigCdNei')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdNei)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigPdMvf')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdMvf)')
		If llTaOK And Not ThisForm.poDataMgr.Update('CrSigPrJus')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrJus)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigPdNlt')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPdNlt)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigOpInc')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpInc)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigInAop')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigInAop)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigOpEtq')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpEtq)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigEtPos')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigEtPos)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvHst')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvCcr')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCcr)')
		If llTaOK And Not ThisForm.poDataMgr.Update('cqSigMvCcr')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - cqSigMvCcr)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvCpv')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCpv)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvCab')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvItn')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvItn)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvIts')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvIts)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigSubMv')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigSubMv)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigExMvc')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigExMvc)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigBxEst')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigBxEst)')
		If llTaOK And Not ThisForm.poDataMgr.Update('crSigMvHst') && Tiago - 10/09/2014 - Só atualiza o SIGMVHST depois que conseguiu atualizar o SIGMVEST para não dar DEADLOCK
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
	Select crSigCdNec
				=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		Select crSigCdNec			
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select TmpNens
lcSql = [Select * From SigPdNlt Where nLotes = ]+Str(crSigCdNec.nLotes)
If Thisform.Podatamgr.Sqlexecute(lcSql,'LocalNlt') < 1
	Select LocalNlt
	lcSql = [Update SigPdNlt Set chksubn =  0 Where nLotes = ]+Str(crSigCdNec.nLotes)
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'') < 1
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão - Update SigPdNlt ')
	If Seek(TmpNens.GrupoOs,'TmpGccr','balcodigo') and InList(TmpGccr.CtrLotes,1,3)
		lcsql = [Select nlotes, Datas From SigPdNlt Where EmpGruEsts = ']+TmpNens.Emps+TmpNens.GrupoOs+TmpNens.ContaOs+[' ]+;
		Thisform.Podatamgr.sqlexecute(lcsql,'TmpNlt')
		Select TmpNlt
		If Not Seek(This.Value)
		If Seek(TmpNens.GrupoDs,'TmpGccr','balcodigo') and InList(TmpGccr.CtrLotes,1,3)
			lcsql = [Select nlotes, Datas From SigPdNlt Where EmpGruEsts = ']+TmpNens.Emps+TmpNens.GrupoDs+TmpNens.ContaDs+[' ]+;
			Thisform.Podatamgr.sqlexecute(lcsql,'TmpNlt')
			Select TmpNlt
			If Not Seek(This.Value)
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
	Select TmpOperacao
Select xNensi
If Not Seek(Str(0, 10) + lccMats)
	Insert Into xNensi (Emps, Dopps, Numps, Visivel, Rateio, FlagIncs, TpOps, NChkSep) ;
=Thisform.podatamgr.SqlExecute([Select CPros, DPros, CUnis, cUniPs, Cgrus From SigCdPro Where Cpros = ']+lccMats+[' ],[crTmpPro])
Select xNensi
	If Not Empty(This.Value) And Not Seek(This.Value, 'TmpGccr', 'BalCodigo')
		lcSql = [Select Fases From SigClStp Where Iclis = ']+This.Parent.Get_conta.Value+[']
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
			Select LocalSetP
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	lcSql = [Select Fases From SigClStp Where Iclis = ']+TmpCli.Iclis+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
		Select LocalSetP
		lcQuery = [Select Codigos, Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
	If Not Seek(This.Value, 'TmpCli', 'BalNome')
	lcSql = [Select Fases From SigClStp Where Iclis = ']+TmpCli.Iclis+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
		Select LocalSetP
		lcQuery = [Select Codigos, Datas ] + ;
				    [From SigCdFcx ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
		Select LocalFecha
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	=Seek(crSigCdOpd.Nivels, 'crSigCdOpd', 'Dopps')
	lcsql = [Select numps, cIdChaves From SigCdNec Where EmpDnps BetWeen ?_chaveI and ?_chaveF]
	ThisForm.Podatamgr.SqlExecute(lcsql,'BuscaNens')
	Select BuscaNens
If Not Empty(This.Value) And Not Seek(This.Value, 'TmpGccr', 'BalCodigo')
	lcSql = [Select Fases From SigClStp Where Iclis = ']+This.Parent.Get_conta.Value+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
		Select LocalSetP
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	lcSql = [Select Fases From SigClStp Where Iclis = ']+TmpCli.Iclis+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
		Select LocalSetP
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
	If Not Seek(This.Value, 'TmpCli', 'BalNome')
	lcSql = [Select Fases From SigClStp Where Iclis = ']+TmpCli.Iclis+[']
	If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalSetP') < 1)
		Select LocalSetP
	lcQuery = [Select Codigos, Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalFecha') < 1)
	Select LocalFecha
		Select TmpOperacao
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(crSigCdOpd.Nivels, 'crSigCdOpd', 'Dopps')
=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
			lcSql = [Select CidChaves, ChkSubn From SigCdNec Where EmpDnPs = ']+_Chave+[']
			ThisForm.PodataMgr.Sqlexecute(lcsql,'LocalNens')
			Select LocalNens
	Select Codigos ;
	  From TmpOperacao ;
	Select TmpOperacao
		Select CrSigInAop
		Delete All for Nenvs = _nOperacao
		Select xMFas
		Delete All for Nenvs = _nOperacao
		Select xOpi
		Delete All for Nenvs = _nOperacao
		Select xPesa
		Delete All for Nenvs = _nOperacao
			Select * from xNensi Where Nenvs = _nOperacao Into Cursor DelxNensi
			Select DelxNensi
				If Seek( Str(0,10) + DelxNensi.cMats, 'xNensi', 'NopCmat')
					Select xNensi
						Delete
		Select xNensi
		Delete All for Nenvs = _nOperacao
		Select xNensiS
		Delete All For Nenvs = _nOperacao
		Select xnensiR
		Delete All For Nenvs = _Noperacao
		Select xNensiP
		Delete All for Nenvs = _nOperacao
		Select CsContas
		Delete All For Nenvs = _nOperacao
		Select xMaterial
		Delete All For Nenvs = _nOperacao
		lcSql = [Select cIdChaves, Vends, GrVends From SigCdNec Where EmpDnPs = ']+lcEdn+[']
		ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
		Select LocalNens
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text)')
			lcSql = [Select Nops, cIdChaves From SigPdMvf Where EmpDnPs = ']+_Chave+[']
			ThisForm.PodataMgr.SqlExecute(lcsql,'LocalMfas')
			Select LocalMFas
				lcSql = [Select cIdChaves, Vends, GrVends From SigCdNec Where EmpDnPs = ']+lcEdn+[']
				ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
				Select LocalNens
					lcQuery = [Update SigCdNec ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
						=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 2)')
				lcSql = [Select cIdChaves, Vends, GrVends From SigCdNec Where EmpDnPs = ']+lcEdn+[']
				ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
				Select LocalNens
				lcQuery = [Update SigCdNec ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 2)')
		Select TmpOperacao
		Delete
	Select TmpOperacao
	=Seek(This.Value)
			Insert Into TmpOperacao (Codigos) Values (0)
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
		lcQuery = [Select Emps, Dopps, Numps, Datas, ContaDs From SigPdMvf ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEnve') < 1)
		Select LocalEnve
		=Seek(LocalEnve.Dopps, 'crSigCdOpd', 'Dopps')
		lcSql = [Select CidChaves, Retrabs, Chksubn From SigCdNec Where EmpDnPs = ']+_ChaveNens+[']
		ThisForm.Podatamgr.SqlExecute(lcsql,'LocalNens')
		lcQuery = [Update SigCdNec ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (OK - Update - SigCdNec)')
		lcSql = [Select Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, ]+;
				[Pesos, Qtds, Obsps, Ordems, cRetrabs From SigPdMvf Where EmpDnPs = ']+_ChaveNens+[']
		ThisForm.PodataMgr.SqlExecute(lcSql,'LocalMfas')
		Select LocalMFas
			lcQuery = [Select a.Nops, a.Datas, a.cidChaves From SigPdMvf a ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
			Select LocalMFas2
				Select TmpNens
			Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
			If Not Seek((_NumNivel * 10000000000 ) + xMFas.NEnvs, 'TmpOperacao', 'Codigos')
				Insert Into TmpOperacao (Codigos) Values ((_NumNivel * 10000000000) + xMFas.NEnvs)
			lcSql = [Select Emps, Dopes, Numes, Qtds, CodCors, CodTams, Empds, CodTgops, citens From SigOpPic Where Nops = ]+Str(LocalMfas.Nops)
			Thisform.PodataMgr.SqlExecute(lcsql,'LocalOpi')
			Select LocalOpi
					lcSql = [Select ContaOs, ContaDs From SigMvCab Where EmpDopNums = ']+lcEdn+[']
					ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalEest')
					lcSql = [Select Globalizas, servicos From SigCdOpe Where Dopes = ']+LocalOpi.Dopes+[']
					ThisForm.PodataMgr.SqlExecute(lcsql,'LocalOpe')
					lcSql = [Select dopes, EncPesMs From SigOpCdc Where Dopes = ']+LocalOpi.Dopes+[']
					ThisForm.PodataMgr.SqlExecute(lcsql,'LocalDcOpe')
					Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Nenvs, Emps, Dopes, Numes, ;
		lcSql = [Select Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, ]+;
				[From SigCdNei Where EmpDnPs = ']+_chaveNens+[']
		ThisForm.Podatamgr.SqlExecute(lcsql,'LocalNensi')
		Select LocalNensi
				lcsql = [Select CGrus, Varias, Dpros, Cunis, cUnips From SigCdPro Where Cpros = ']+LocalNensi.cmats+[']
				ThisForm.Podatamgr.SqlExecute(lcsql,'LocalPro')
					Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs,  QtFaseAnt, Qtds, PsFaseAnt, ;
							If Not Seek(Str(_Nenv, 10) + _BMat + _TMat, 'xNensi', 'NEnvTpops')
								Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, Cats, TpOps, Servicos) ;
							Select xNensi
			Select LocalNensi
		=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
			Select TmpOperacao
			Delete For Codigos = 0
				Insert Into TmpOperacao (Codigos) Values (0)
		lcQuery = [Select cIdChaves, Vends, GrVends, ChkSubn From SigCdNec Where EmpDnps = ']+_chave+[']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNens]) < 1)
			Select TmpNens
			Select TmpNens
			Select dopps From CrSigCdOpd Where ChkDests = 1 Into Cursor TmpOppE
				lcSql = [Select Numps From SigPdMvf Where Nops = ]+Str(_Noperacao,10)+[ And dopps = ']+TmpOppE.Dopps+[']
				If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpMfEnv') > 0 And Reccount('TmpMfEnv') > 0
		lcsql = [Select CodPds From SigPdMvf Where EmpDnps = ']+_chave+[']
		ThisForm.Podatamgr.SqlExecute(lcsql,'LocalMfas')
		Select LocalMFas
			lcsql = [Select MatPrincs,Cgrus From SigCdPro Where Cpros = ']+LocalMfas.codpds+[']
			ThisForm.Podatamgr.SqlExecute(lcsql,'LocalPro')
			lcsql = [Select Mercs From SigCdGrp Where Cgrus = ']+LocalPro.Cgrus+[']
			ThisForm.PodataMgr.SqlExecute(lcsql,'LocalGru')
			lcsql = [Select MatPrincs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
			ThisForm.PodataMgr.Sqlexecute(lcsql,'LocalGgrp')
			Select xMaterial
		Select Distinct MatPs ;
		  From xMaterial ;
				Select TmpNens
		Select csResultado
			lcsql = [Select Codigos, Tubos From SigCdFud Where Nops = ]+Str(This.Value)
			ThisForm.PodataMgr.Sqlexecute(lcsql,'LocalIfund')
			Select LocalIfund
				lcQuery = [Select * ] + ;
						    [From SigCdFud ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalIfund') < 1)
				Select LocalIfund
					Select TmpNens
			lcSql = [Select Cods From SigOpOpt Where ChkDevs = 'S' ]
			If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpOPt') < 1)
			Select TmpOpt
				lcSql = [Select a.Cmats, a.Qtds, a.TpOps From SigCdNei a, SigCdOpd b, SigOpOpt c ]+;
						[Select a.Cmats, (a.Qtds*-1) as Qtds, a.TpOps From SigCdNei a, SigCdOpd b ]+;
				If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNoo') < 1)
				Select cmats, Sum(qtds) as Qtds From LocalNoo Group by cmats Into Cursor Selecao
				Select Selecao
						Select TmpNens
		lcsql = [Select a.Nops, a.Nenvs, a.Dopps, a.NumPs, b.CodTgOps From SigPdMvf a, SigOpPic b ]+;
		Thisform.Podatamgr.SqlExecute(lcsql,'LocalMfas')
		Select LocalMFas
			=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
			lcQuery = [Select a.Nops, a.Datas, a.Dopps, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.CodPds, a.Ordems, a.cIdChaves, a.Qtds, b.ChkDests ] + ;
					    [From SigPdMvf a, SigCdOpd b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
			Select LocalMFas2
				Select TmpNens
					Select TmpNens
				Select TmpNens
					Select TmpNens
				Select TmpNens
			If Not Empty(crSigCdOpd.Nivels) And Seek(LocalMFas2.Dopps, 'crSigCdOpd', 'Dopps') And Not Empty(crSigCdOpd.Nivels)
				=Seek(_CheckBaixa,'CrSigCdOpd','Dopps')
			=Seek(LocalMFas2.Dopps, 'crSigCdOpd', 'Dopps') 
			lcsql = [Select ChkSubn, Vends, GrVends From SigCdNec Where EmpDnPs = ']+lcedn+[']
			ThisForm.Podatamgr.SqlExecute(lcsql,'LocalNens')
			Select LocalNens
				Select TmpNens
			=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
			lcsql = [Select Obss From SigOpPic Where Nops = ]+Str(_Nops)
			ThisForm.Podatamgr.SqlExecute(lcsql,'LocalOpi')
			Select LocalOpi
					lcSql = [Select CidChaves From SigCdMsg Where EmpCpros = ']+ ThisForm.Pemps + Padr('OBSOP',10)+[']
					ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpMens')
					Select CrTmpMens
				lcsql = [Select CidChaves From SigCdPrf Where Produtos = ']+LocalMFas2.CodPds+[']
				ThisForm.Podatamgr.SqlExecute(lcsql,'LocalProf')
					lcQuery = [Select Produtos, Ordems, Grupos, Ordem2 ] + ;
							    [From SigCdPrf ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalProF') < 1)
					Select LocalProF
								Select TmpOperacao
									Select TmpNens
										Select TmpNens
			lcQuery = [Update SigPdMvf ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
				Select TmpNens
				lcSql = [Select Emps, Dopps, Numps From SigPdMvf Where Nops = ]+Str(_Noperacao)+[ And emps = ']+_Empr+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalMfas3')
				Select LocalMFas3
						Select TmpNens
			Select LocalMfas
			Select LocalMFas
				=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
				lcQuery = [Select Nops, Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, CodPds, Ordems, cIdChaves, Qtds ] + ;
						    [From SigPdMvf ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
				Select LocalMFas2
					Select TmpNens
				lcQuery = [Update SigPdMvf ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					Select TmpNens
			Select crSigCdOpd
			Select xMFas
				Select xMFas
				Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
				Select xOpi
				Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
				Select xPesa
				Delete All For Nenvs = Val(Right(Str(_OldCodigo, 12), 10))
				lcsql = [Select cIdChaves, Vends, GrVends From SigCdNec Where EmpDNPs = ']+lcedn+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalNens')
				Select LocalNens
				lcQuery = [Update SigCdNec ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
					=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 3)')
			Select xNensi
				Delete All For Emps + Dopps + Str(Numps, 10) = _Chave
			Delete All For Empty(CMats) And Empty(Nops) And Empty(Qtds) And Empty(PsFaseAnt)
				lcsql = [Select cIdChaves, Vends, GrVends, ChkSubn From SigCdNec Where EmpDnps BetWeen ]+;
				ThisForm.Podatamgr.SqlExecute(lcsql,'LocalNens')
					Select TmpOperacao
				Select Codigos From TmpOperacao ;
				lcsql = [Select Nops, CodPds, Ordems, Nenvs, Datars, Datas, Opers, Unids, Pesos, Obsps, Obss, Qtds ]+;
						[From SigPdMvf Where Empdnps Between ']+_chavei+[' And ']+_ChaveF+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalMfas')
					Select TmpOperacao
					lcsql = [Select Nops, CodPds, Ordems, Nenvs, Datars, Datas, Opers, Unids, Pesos, Obsps, Obss, Qtds ]+;
							[From SigPdMvf Where Empdnps = ']+_chave+[']
					ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalMfas')
			Select LocalMFas
				lcQuery = [Select a.Nops, a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.cIdChaves, a.CodPds, ]+;
						  [From SigPdMvf a, SigCdPro b ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNops') < 1)
				Select LocalNops
				=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
					Select Dopps From crSigCdOpd Where ChkDests = 6 Into Cursor TmpRepo
						lcSql = [Select a.Cmats, a.Qtds From SigCdNei a, SigCdOpd b ]+;
						If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNoo') < 1)
						Select LocalNoo
							Select TmpNens
					lcsql = [Select cIdChaves, Vends, GrVends From SigCdNec Where empdnps = ']+lcchv+[']
					ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
					Select LocalNens
						lcQuery = [Update SigCdNec ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 4)')
					lcsql = [Select cIdChaves, Vends, GrVends From SigCdNec Where empdnps = ']+lcchv+[']
					ThisForm.PodataMgr.SqlExecute(lcsql,'LocalNens')
					Select LocalNens
						lcQuery = [Update SigCdNec ] + ;
						If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
							=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCdNec - Text 5)')
					lcQuery = [Select Produtos, Ordems, Grupos, Ordem2 ] + ;
							    [From SigCdPrf ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalProF') < 1)
					Select LocalProF
					lcQuery = [Select GrupoDs ] + ;
							    [From SigPdMvf ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
					Select LocalMFas2
					lcQuery = [Select a.emps, a.Dopps, a.Numps, a.Cmats, a.Pesofixs, a.qtds, a.pesos, b.Datas, a.peso2s, ]+;
								[From SigCdNei a, SigCdNec b ]+;
					ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalNensi')
					Select LocalNensi
						=Seek(LocalNensi.Dopps, 'crSigCdOpd', 'Dopps')
					=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
						Select TmpNens
					lcsql = [Select Emps, EmpDs, Dopes, Numes, Qtds, CodCors, CodTams, CodBarras, Nops, CodTgOps, citens ]+;
							[From SigOpPic Where Nops = ]+Str(LocalNops.Nops)
					ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalOpi')
					Select LocalOpi
						lcsql = [Select Contaos, contaDs From SigMvCab Where empdopnums = ']+lcchv+[']
						ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalEest')
						lcsql = [Select Globalizas, Servicos, CadProds, Pesos From SigCdOpe Where dopes = ']+LocalOpi.Dopes+[']
						Thisform.podatamgr.sqlexecute(lcsql,'LocalOpe')
						lcSql = [Select dopes, EncPesMs From SigOpCdc Where Dopes = ']+LocalOpi.Dopes+[']
						ThisForm.PodataMgr.SqlExecute(lcsql,'LocalDcOpe')
						lcsql = [Select MatPrincs, Cgrus, Pesoms from SigCdPro where cpros = ']+LocalNops.CodPds+[']
						ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
						lcsql = [Select Mercs from SigCdGrp where cgrus = ']+localpro.cgrus+[']
						ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
						lcsql = [Select MatPrincs,cpqtds From SigCdGpr Where codigos = ']+localgru.mercs+[']
						ThisForm.PodataMgr.sqlexecute(lcsql,'Localggrp')
						Insert Into xOpi (Nops, Oper, Qtds, CPros, Indiv, Amarra, Nenvs, Emps, Dopes, Numes, Conta, ;
						Select ChkDests,ReiNops From CrSigCdOpd Where Dopps = LocalNops.Dopps Into Cursor TmpDopp
						Select TmpDopp
								Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, ;
								Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, ;
								Insert Into xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, ;
								Select xPesa
									Insert Into xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, ;
				=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
				lcsql = [Select Emps, EmpDs, Dopes, Numes, Qtds, CodCors, CodTams, CodBarras, CodTgOps, citens ]+;
						[From SigOpPic where Nops = ]+Str(LocalNops.Nops)
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalOpi')	
				Select LocalOpi
				Insert Into xMFas (Emps, Dopps, Numps, Datars, Datas, Usuars, Opers, Grupoos, Contaos, Grupods, ;
					lcSql = [Select * From SigInAop Where Grupos = ']+TmpNens.GrupoOs+[' And Contas = ']+TmpNens.ContaOs+[' ]+;
					Thisform.Podatamgr.Sqlexecute(lcSql,'TmpAope')
					Select TmpAope
						Insert Into CrSigInAop From Memvar
				lcQuery = [Select a.emps, a.Dopps, a.Numps, a.Cmats, a.Pesofixs, a.qtds, a.pesos, b.Datas, a.peso2s, ]+;
							[a.CodCors, a.CodTams, a.Servicos, a.TpOps, b.CidChaves From SigCdNei a, SigCdNec b ]+;
				ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalNensi')
				Select LocalNensi
					=Seek(LocalNensi.Dopps, 'crSigCdOpd', 'Dopps')
				=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
					lcsql = [Select DPros, CGRus, CUnis, Varias, cunips From SigCdPro where cpros = ']+LocalNensi.cmats+[']
					ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
						Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, QtFaseAnt, Qtds, ;
					lcQuery = [Select a.emps, a.Dopps, a.Numps, a.Cmats, a.Pesofixs, a.qtds, a.pesos, b.Datas, ]+;
							  [a.Peso2s, a.codcors, a.codTams, b.CidChaves, b.EmpDnps From SigCdNei a, SigCdNec b ]+;
					ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalNensi4')
						Select LocalNensi4
							=Seek(LocalNensi4.Dopps, 'crSigCdOpd', 'Dopps')
								Select * From LocalNensi4 Where CidChaves = lcBuscaN Into Cursor CsSelecao
									Select a.* From LocalNensi4 a, CrSigCdOpd b Where a.dopps = b.dopps ;
								Select CsSelecao
									=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
										lcsql = [Select DPros, CGRus, CUnis, Varias, cunips From SigCdPro where cpros = ']+CsSelecao.cmats+[']
										ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
										If (!llDesagrega And (!Seek( Str( xMFas.Nops, 10 ) + CsSelecao.CMats, 'xNensi','NopCMat' ) Or lcbuscaN > lcbuscaN1 )) && Tiago - estava OR (!llDesagrega And lcbuscaN > lcbuscaN1 ) - mudei devido estar carregando componente já desagregado
											Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, QtFaseAnt, Qtds, ;
									Select * From LocalNensi4 Where CidChaves = lcBuscaN Into Cursor CsSelecao
										Select a.* From LocalNensi4 a, CrSigCdOpd b Where a.dopps = b.dopps ;
									Select CsSelecao
										=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
											lcsql = [Select a.CUnis, a.DPros, a.CGrus, a.cunips, a.varias, a.cunips, b.SemiAcabs From SigCdPro a, SigCdGrp b Where a.cpros = ']+CsSelecao.cMats+[' ]+;
											Thisform.podatamgr.Sqlexecute(lcsql,'LocalPro')
											If Not Seek( Str(Iif(CrSigCdOpd.SepPedras=4,0,Iif(CrSigCdOpd.SepPedras=3,LocalMfas.Nops,_nOperacao)),10) + CsSelecao.cMats, 'xNensi', 'NopCMatV') 
												Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, QtFaseAnt, Qtds, ;
						Select LocalNensi4
						=Seek(LocalNensi4.Dopps, 'crSigCdOpd', 'Dopps')
						Select * From LocalNensi4 Where CidChaves = lcBuscaN Into Cursor CsSelecao
						Select CsSelecao
							=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
								lcsql = [Select DPros, CGRus, CUnis, Varias, cunips From SigCdPro where cpros = ']+CsSelecao.cmats+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
								If !Seek( Str( xMFas.Nops, 10 ) + CsSelecao.CMats, 'xNensi','NopCMat' ) Or (!llDesagrega And lcbuscaN > lcbuscaN1 )
									Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, QtFaseAnt, Qtds, ;
				=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
					Select LocalNensi
						Select xNensi
						If Not Seek(Str(xMfas.Nops,10) + csResultado.MatPs)
							lcsql = [Select DPros, CGRus, CUnis, Varias, cunips From SigCdPro where cpros = ']+csResultado.Matps+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalPro')
							Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, QtFaseAnt, Qtds, ;
					Select xNensi
					If Not Seek(_AgrupaOper + Space(10))
						Insert Into xNensi (Nops, Nenvs, Visivel, Rateio, CUnis, MatPrincs, TpOps) ;
							Select xPesa
				lcsql = [Select Qtds, empdopnums, citens From SigOpPic Where Nops = ]+Str(LocalMFas.Nops)
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalOpi')
				Select LocalOpi
					lcSql = [Select a.Mats, a.Qtds, a.cats, a.grupos, a.ordems, a.cunis as unicompos, a.Pesos, a.units as pcompos, a.moevs as moeds ]+;
							[From SigSubMv a ]+;
					=ThisForm.Podatamgr.SqlExecute(lcSql,'LocalCompo')
						lcsql = [Select Mats, Qtds, Cats, Grupos, Ordems, UniCompos, Pesos, pCompos, Moeds  From SigPrCpo Where Cpros = ']+LocalMFas.CodPds+[']
						ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalCompo')
						Select LocalCompo
							lcsql = [Select cpros,CUnis, DPros, CGrus, PesoMs, Varias, cunips, cproEqs From SigCdPro Where cpros = ']+LocalCompo.Mats+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'Localpro')
								lcsql = [Select cpros, CUnis, DPros, CGrus, PesoMs, Varias, cunips, cproEqs From SigCdPro Where cpros = ']+LocalPro.Cproeqs+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'Localpro')
							lcsql = [Select Fators,Cestos,QtEqualPs From SigCdUni Where Cunis = ']+LocalPro.Cunis+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
							lcsql = [Select Fators,Cestos,QtEqualPs From SigCdUni Where Cunis = ']+LocalPro.Cunips+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni2')
							lcsql = [Select cestoqs,TpMovs from SigCdGrp where cgrus = ']+localpro.cgrus+[']
							ThisForm.PodataMgr.sqlexecute(lcsql,'LocalGru')
							lcQuery = [Select cIdChaves ] + ;
									    [From SigPdMvf ] + ;
							If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crBusca') < 1)
							Select LocalCompo
								Select xNensi
								If !Seek(Str(xMfas.Nops,10) + Localpro.cpros )
									Select LocalCompo
									Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
								If Not Seek(_AgrupaOper + _CMat, 'xNensi', 'NEnvCMat')
									Insert Into xNensi (Nops, Nenvs, CMats, CDescs, CUnis, CGrus, ;
							Select LocalCompo
								Select crSigCdSvc
									Case Seek(LocalCompo.Cats + TmpNens.Grupoos + TmpNens.Contaos)
									Case Seek(LocalCompo.Cats + TmpNens.Grupoos + Space(10))
									Case Seek(LocalCompo.Cats + Space(20))
								If Not Seek(Str(xMfas.Nops,10) + LocalCompo.Cats, 'xNensi', 'NEnvMCat')
									Insert Into xNensi (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
									lcQuery = [Select a.comis from SigCdCrg a inner join SigCdCli b on a.CCargs = b.CCargs where Iclis = '] + _Conta + [']
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCar') < 1)
									Select LocalCar
									Select xNensi
									lcQuery  = [Select top 1 b.cmats from sigPdMvf a inner join sigcdnei b on a.empdnps = b.empdnps ] +;
												[inner join sigcdnec c on a.empdnps = c.empdnps and ] +;
									If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas2') < 1)
									Select LocalMFas2
										lcQuery = [Select Rclis from SigCdCli where Iclis = '] + _Conta + [']
										If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCliSer') < 1)
					Select LocalCompo
						lcsql = [Select MedTmps From SigCdUni Where Cunis = ']+LocalCompo.UniCompos+[']
						ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
						Select Localcompo
							lcsql = [Select CGrus, Varias From SigCdPro Where cpros = ']+LocalCompo.Mats+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'Localpro')
								If Not Seek(Str(_nOperacao, 10) + Localpro.Cgrus, 'xNensiP', 'NenvsCgrus')
									Insert Into xNensiP (NEnvs, CMats, Cgrus ) ;
						Select xNensi
						Select Cgrus, Cunis, Cunips, Sum(Qtds) as Qtds, Sum(Peso2s) as Pesos from xNensi where Nops = _nOperacao And Rateio = 3 And !Servicos GROUP By Cgrus, Cunis, Cunips Into Cursor TmpTotAgre
						Select a.Cgrus, a.Qtds as QtdCompo, a.Pesos as PesoCompo, Nvl(b.Qtds,0) as QtdAgre, Nvl(b.Pesos,0) as PesoAgre, Nvl(b.Cunis,'') as Cunis, Nvl(b.Cunips,'') as Cunips ;
							from xNensiP a Left Join TmpTotAgre b on a.Cgrus = b.Cgrus Into Cursor TmpDifAgre
						Select TmpDifAgre
							lcSql = [Select cEstos, Fators From SigCdUni Where cunis = ']+TmpDifAgre.cunis+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
							lcSql = [Select cEstos, Fators From SigCdUni Where cunis = ']+TmpDifAgre.cuniPs+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni2')
							lcSql = [Select Premios From SigCdGrp Where cGrus = ']+TmpDifAgre.cGrus+[']
							ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpGrp')
						Select TmpDifAgre
						Select TmpTotAgre
							Select TmpNens
						Select xNensi
						lcSql = [Select a.Mats, a.Qtds, a.Pesos ]+;
								[From SigSubMv a ]+;
						=ThisForm.Podatamgr.SqlExecute(lcSql,'LocalCompo')
							lcQuery = [select a.emps + b.dopes +str(a.numes,6) as EDN ]+;
								[from sigmvpec a ]+;
								[join sigcdope b on b.ndopes = convert(int,a.codigos/1000000) ]+;
							=Thisform.poDataMgr.SqlExecute(lcQuery,[LocalEDN])
								lcSql = [Select a.Mats, a.Qtds, a.Pesos ]+;
									[From SigSubMv a ]+;
								=ThisForm.Podatamgr.SqlExecute(lcSql,'LocalCompo')
								lcsql = [Select Mats, Qtds, Pesos From SigPrCpo where Cpros = ']+LocalMFas.CodPds+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalCompo')
						Select LocalCompo
							lcsql = [Select a.CUnis, a.DPros, a.CGrus, a.cunips, b.SemiAcabs From SigCdPro a, SigCdGrp b Where a.cpros = ']+LocalCompo.Mats+[' ]+;
							Thisform.podatamgr.Sqlexecute(lcsql,'LocalPro')
							If Not Seek(Str(_nOperacao, 10) + LocalCompo.Mats, 'xNensiP', 'Nenvs')
								Insert Into xNensiP (NEnvs, CMats, Cgrus ) ;
								If Not Seek( Str(Iif(CrSigCdOpd.SepPedras=4,0,Iif(CrSigCdOpd.SepPedras=3,LocalMfas.Nops,_nOperacao)),10) + LocalCompo.Mats, 'xNensi', 'NopCMatV') && Tiago - 30/01/2013 - Alterei para usar o índice NopCmatV que só filtra os itens que estão visíveis na grade
									Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
								lcsql = [Select Cgrus,Cunis,cunips,PesoMs From SigCdPro where cpros = ']+xNensi.Cmats+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
								lcsql = [Select TpMovs From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
								ThisForm.PodataMgr.Sqlexecute(lcsql,'CrTmpGru')
								lcsql = [Select Fators From SigCdUni Where cunis = ']+CrTmpPro.Cunis+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
								lcsql = [Select Fators From SigCdUni Where cunis = ']+CrTmpPro.Cunips+[']
								ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni2')
										Select xNensi
											Select xNensi
											Select xNensi
									Insert Into xNensi (Emps, Dopps, Numps, Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
											Select xNensi
												Select xNensi
							lcSql = [Select * From SigCdNei Where Nops = ]+Str(LocalMfas.Nops)+[ And Dopps = ']+CrSigCdOpd.Dopps+[']
							ThisForm.PodataMgr.SqlExecute(lcsql,'LocNensi')
							Select LocNensi
								lcSql = [Select a.CUnis, a.DPros, a.CGrus, a.cunips, b.SemiAcabs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+LocNensi.Cmats+[' ]+;
								ThisForm.PodataMgr.SqlExecute(lcsql,'LocalPro')
								If Seek(Str(LocalMfas.Nops,10) + LocNensi.Cmats, 'xNensi', 'NopCMatV') && Tiago - 30/01/2013 - Alterei para usar o índice NopCmatV que só filtra os itens que estão visíveis na grade
								lcSql = [Select Cgrus, cUnis, cUniPs From SigCdPro Where Cpros = ']+xNensi.Cmats+[']
								ThisForm.PodataMgr.SqlExecute(lcSql,'CrTmpPro')
								lcSql = [Select TpMovs From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
								ThisForm.Podatamgr.SqlExecute(lcsql,'CrTmpGru')
								lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunis+[']
								Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni')
								lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunips+[']
								Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni2')
										Select xNensi
											Select xNensi
								Select xNensi
									Delete
									If Seek(Str(0) + LocNensi.Cmats, 'xNensi', 'NopCmat')
									lcSql = [Select Cgrus, cUnis, cUniPs From SigCdPro Where Cpros = ']+xNensi.Cmats+[']
									ThisForm.PodataMgr.SqlExecute(lcSql,'CrTmpPro')
									lcSql = [Select TpMovs From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
									ThisForm.Podatamgr.SqlExecute(lcsql,'CrTmpGru')
									lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunis+[']
									Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni')
									lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunips+[']
									Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni2')
											Select xNensi
												Select xNensi
									Select xNensi
										Delete
					Select LocalOpi					
				Select LocalMfas
				lcQuery = [Select a.emps, a.Dopps, a.Numps, a.Cmats, a.Pesofixs, a.qtds, a.pesos, b.Datas, ]+;
						  [a.Peso2s, a.codcors, a.codTams, b.CidChaves, b.EmpDnps From SigCdNei a, SigCdNec b ]+;
				ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalNensi4')
				Select LocalNensi4
					=Seek(LocalNensi4.Dopps, 'crSigCdOpd', 'Dopps')
						Select * From LocalNensi4 Where CidChaves = lcBuscaN Into Cursor CsSelecao
						Select CsSelecao
							=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
								lcSql = [Select a.CUnis, a.DPros, a.CGrus, a.cUniPs, b.SemiAcabs From SigCdPro a, SigCdGrp b Where a.Cpros = ']+CsSelecao.Cmats+[' ]+;
								ThisForm.PodataMgr.SqlExecute(lcsql,'LocalPro')
								If Seek(Str(_nOperacao,10) + CsSelecao.Cmats, 'xNensi', 'NopCMatV') && Tiago - 30/01/2013 - Alterei para usar o índice NopCmatV que só filtra os itens que estão visíveis na grade
								lcSql = [Select Cgrus, cUnis, cUniPs From SigCdPro Where Cpros = ']+xNensi.Cmats+[']
								ThisForm.PodataMgr.SqlExecute(lcSql,'CrTmpPro')
								lcSql = [Select TpMovs From SigCdGrp Where Cgrus = ']+CrTmpPro.Cgrus+[']
								ThisForm.Podatamgr.SqlExecute(lcsql,'CrTmpGru')
								lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunis+[']
								Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni')
								lcSql = [Select Fators From SigCdUni Where Cunis = ']+CrTmpPro.Cunips+[']
								Thisform.PodataMgr.SqlExecute(lcsql,'LocalUni2')
										Select xNensi
								Select xNensi
									Delete
					=Seek(LocalNensi4.Dopps, 'crSigCdOpd', 'Dopps')
					=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')					
			lcQuery = [Select a.Nenvs, a.GrupoDs, a.ContaDs, a.GrupoOs, a.ContaOs, a.Dopps, a.EmpDnPs, a.cRetrabs, ]+;
						[c.EmpDopNums From SigPdMvf a, SigCdOpd b, SigOpPic c, SigCdSvc d ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalMFas4') < 1)
			Select LocalMfas4
				Select CsContas
				If Not Seek(Str(Localmfas4.Nenvs))
				lcsql = [Select Cpros,Dpros,Moedas,Qtds,EmpDopNums,Dopes From SigMvItp Where EmpDopNums = ']+LocalMfas4.EmpDopNums+[']
				ThisForm.Podatamgr.sqlexecute(lcsql,'TmpEsti3')
				Select TmpEsti3
					lcsql = [Select DigEnves From SigCdOpe Where Dopes = ']+TmpEsti3.dopes+[']
					Thisform.Podatamgr.sqlexecute(lcsql,'Crope')
					lcsql = [Select Dpros,Cunis,Cgrus, cUniPs From SigCdPro Where Cpros = ']+TmpEsti3.Cpros+[']
					Thisform.podatamgr.sqlexecute(lcsql,'LocalPro')
					Insert Into xNensIs (Emps, Dopps, Numps, CMats, CDescs, CUnis, CGrus, Visivel, Rateio, ;
			lcQuery = [Select a.Nenvs, a.GrupoDs, a.ContaDs, a.Dopps, a.Numps, a.cRetrabs, a.datas, b.descs, c.Rclis ]+;
					  [From SigPdMvf a, SigPrCrt b, SigCdCli c ]+;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'Lcmfas5') < 1)
			Select Lcmfas5
				Insert Into xNensiR (nenvs, EmpDopNums, Datas, Destinos, Retrabs, Rclis ) Values ;
				lcsql = [Select Rclis From SigCdCli where Iclis = ']+TmpNens.contaos+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalCli')
				lcsql = [Select Rclis From SigCdCli where Iclis = ']+TmpNens.contaDs+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalCli')
				lcsql = [Select Rclis From SigCdCli where Iclis = ']+TmpNens.vends+[']
				ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalCli')
			Select TmpOperacao
		Select TmpNens
Select xNensi
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select TmpNens
Select TmpOperacao
	Select xMFas
Select TmpOperacao
Delete For Codigos = 0
	Insert Into TmpOperacao (Codigos) Values (0)
	lcQuery = [Select Codigos, Descrs ] + ;
			    [From SigCdObs ] + ;
	If (loCnx.SqlExecute(lcQuery, 'crLocalObs') < 1)
	Select crLocalObs
	If Not Seek(This.Value, 'crLocalObs', 'Codigos')
	Select crSigCdObs
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select xMFas
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
Select xNensi
Select xNensi
	lcSql = [Select Cpros From SigOpPic Where Nops = ]+Str(xnensi.Nops)
	=Thisform.PodataMgr.SqlExecute(lcsql,'TmpOpi')
	Insert Into TmpDistrib (Nops, Nenvs, Qtds2, Pesos2, CUnis, CMats, CDescs, CGrus, Qtds, Pesos, nLotes, CodPds) ;
Select TmpDistrib
Select NEnvs, CodPds, CMats, Qtds, Pesos ;
  From TmpDistrib ;
Select crImps
		Insert Into dbImpressao (Pedido, CPros, Qtds, QtdeEtiq) ;
Select dbImpressao
	Select xNensiS
	Select xNensiS
	Select xNensi
		=Seek(TmpNens.GrupoOs,'TmpGccr','BalCodigo')
		Select xOpi
		Select xPesa
	Select xNensi
		Select xNensi
		SELECT TmpOperacao
			SELECT xNensi
	Select xMfas

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpdmp6.prg) - TRECHOS RELEVANTES PARA PASS SQL (3946 linhas total):

*-- Linhas 647 a 665:
647:             .Height       = 442
648:             .RecordSource = ""
649:             .RecordMark   = .F.
650:             .DeleteMark   = .F.
651:             .ReadOnly     = .T.
652:             .GridLines    = 3
653:             .FontName     = "Verdana"
654:             .FontSize     = 8
655:             .ColumnCount  = 8
656:             .Visible      = .T.
657:         ENDWITH
658: 
659:         THIS.FormatarGridLista()
660: 
661:         *-- BINDEVENTs: botoes CRUD (handlers PUBLIC por regra CLAUDE.md #3)
662:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
663:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
664:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
665:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")

*-- Linhas 1641 a 1671:
1641:             .ReadOnly    = .T.
1642:             .Visible     = .F.
1643:             .RecordMark   = .F.
1644:             .DeleteMark   = .F.
1645:         ENDWITH
1646: 
1647:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1648:             .ControlSource   = "TmpOperacao.Codigos"
1649:             .FontName        = "Courier New"
1650:             .Width           = 94
1651:             .InputMask       = "999999999999"
1652:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1653:         ENDWITH
1654: 
1655:         WITH loc_oPagina.grd_4c_GradeOperacao.Column2
1656:             .ControlSource   = "TmpOperacao.TmpMins"
1657:             .FontName        = "Courier New"
1658:             .Width           = 45
1659:             .InputMask       = "99999"
1660:             .Header1.Caption = "Temp/Min"
1661:         ENDWITH
1662: 
1663:         *-- =====================================================================
1664:         *-- CAMPO CODIGO DE OBSERVACAO (get_codobs no legado)
1665:         *-- Legado: Top=234+29=263, Left=690, Width=32, Height=23, InputMask="999"
1666:         *-- Label: Top=238+29=267, Left=599 (Say3 no legado)
1667:         *-- BO: this_cCodObs
1668:         *-- =====================================================================
1669:         loc_oPagina.AddObject("lbl_4c_LblObs", "Label")
1670:         WITH loc_oPagina.lbl_4c_LblObs
1671:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"

*-- Linhas 1820 a 1922:
1820:         loc_oGrade = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
1821: 
1822:         WITH loc_oGrade.Column1
1823:             .ControlSource = "cursor_4c_Dados.numps"
1824:             .Width         = 70
1825:             .Resizable     = .F.
1826:             .Movable       = .F.
1827:             .Header1.Caption   = "N" + CHR(250) + "m."
1828:             .Header1.Alignment = 2
1829:             .Header1.FontName  = "Tahoma"
1830:             .Header1.FontBold  = .T.
1831:             .Header1.FontSize  = 8
1832:         ENDWITH
1833: 
1834:         WITH loc_oGrade.Column2
1835:             .ControlSource = "cursor_4c_Dados.datas"
1836:             .Width         = 82
1837:             .Resizable     = .F.
1838:             .Movable       = .F.
1839:             .Header1.Caption   = "Data"
1840:             .Header1.Alignment = 2
1841:             .Header1.FontName  = "Tahoma"
1842:             .Header1.FontBold  = .T.
1843:             .Header1.FontSize  = 8
1844:         ENDWITH
1845: 
1846:         WITH loc_oGrade.Column3
1847:             .ControlSource = "cursor_4c_Dados.dopps"
1848:             .Width         = 140
1849:             .Resizable     = .F.
1850:             .Movable       = .F.
1851:             .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1852:             .Header1.Alignment = 2
1853:             .Header1.FontName  = "Tahoma"
1854:             .Header1.FontBold  = .T.
1855:             .Header1.FontSize  = 8
1856:         ENDWITH
1857: 
1858:         WITH loc_oGrade.Column4
1859:             .ControlSource = "cursor_4c_Dados.nlotes"
1860:             .Width         = 70
1861:             .Resizable     = .F.
1862:             .Movable       = .F.
1863:             .Header1.Caption   = "Lote"
1864:             .Header1.Alignment = 2
1865:             .Header1.FontName  = "Tahoma"
1866:             .Header1.FontBold  = .T.
1867:             .Header1.FontSize  = 8
1868:         ENDWITH
1869: 
1870:         WITH loc_oGrade.Column5
1871:             .ControlSource = "cursor_4c_Dados.grupoos"
1872:             .Width         = 80
1873:             .Resizable     = .F.
1874:             .Movable       = .F.
1875:             .Header1.Caption   = "Gr. Orig."
1876:             .Header1.Alignment = 2
1877:             .Header1.FontName  = "Tahoma"
1878:             .Header1.FontBold  = .T.
1879:             .Header1.FontSize  = 8
1880:         ENDWITH
1881: 
1882:         WITH loc_oGrade.Column6
1883:             .ControlSource = "cursor_4c_Dados.contaos"
1884:             .Width         = 80
1885:             .Resizable     = .F.
1886:             .Movable       = .F.
1887:             .Header1.Caption   = "Ct. Orig."
1888:             .Header1.Alignment = 2
1889:             .Header1.FontName  = "Tahoma"
1890:             .Header1.FontBold  = .T.
1891:             .Header1.FontSize  = 8
1892:         ENDWITH
1893: 
1894:         WITH loc_oGrade.Column7
1895:             .ControlSource = "cursor_4c_Dados.grupods"
1896:             .Width         = 80
1897:             .Resizable     = .F.
1898:             .Movable       = .F.
1899:             .Header1.Caption   = "Gr. Dest."
1900:             .Header1.Alignment = 2
1901:             .Header1.FontName  = "Tahoma"
1902:             .Header1.FontBold  = .T.
1903:             .Header1.FontSize  = 8
1904:         ENDWITH
1905: 
1906:         WITH loc_oGrade.Column8
1907:             .ControlSource = "cursor_4c_Dados.contads"
1908:             .Width         = 80
1909:             .Resizable     = .F.
1910:             .Movable       = .F.
1911:             .Header1.Caption   = "Ct. Dest."
1912:             .Header1.Alignment = 2
1913:             .Header1.FontName  = "Tahoma"
1914:             .Header1.FontBold  = .T.
1915:             .Header1.FontSize  = 8
1916:         ENDWITH
1917:     ENDPROC
1918: 
1919:     *--------------------------------------------------------------------------
1920:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1921:     * par_nPagina: 1=Lista, 2=Dados
1922:     *--------------------------------------------------------------------------

*-- Linhas 2025 a 2043:
2025:             RETURN
2026:         ENDIF
2027: 
2028:         SELECT cursor_4c_Dados
2029:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2030:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2031:         THIS.this_cModoAtual = "VISUALIZAR"
2032: 
2033:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2034:             THIS.BOParaForm()
2035:             THIS.AjustarBotoesPorModo()
2036:             THIS.HabilitarCampos(.F.)
2037:             THIS.AlternarPagina(2)
2038:         ELSE
2039:             MsgErro("Erro ao carregar registro para visualiza" + CHR(231) + CHR(227) + "o.", "Erro")
2040:         ENDIF
2041:     ENDPROC
2042: 
2043:     *--------------------------------------------------------------------------

*-- Linhas 2052 a 2070:
2052:             RETURN
2053:         ENDIF
2054: 
2055:         SELECT cursor_4c_Dados
2056:         loc_cCidChaves       = ALLTRIM(cursor_4c_Dados.cidchaves)
2057:         THIS.this_nPNumes    = cursor_4c_Dados.numps
2058:         THIS.this_cModoAtual = "ALTERAR"
2059: 
2060:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2061:             THIS.this_oBusinessObject.EditarRegistro()
2062:             THIS.BOParaForm()
2063:             THIS.AjustarBotoesPorModo()
2064:             THIS.HabilitarCampos(.T.)
2065:             THIS.AlternarPagina(2)
2066:         ELSE
2067:             MsgErro("Erro ao carregar registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
2068:         ENDIF
2069:     ENDPROC
2070: 

*-- Linhas 2081 a 2099:
2081:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2082:                 MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o.", "Aviso")
2083:             ELSE
2084:                 SELECT cursor_4c_Dados
2085:                 loc_nNumps     = cursor_4c_Dados.numps
2086:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2087: 
2088:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento " + TRANSFORM(loc_nNumps) + "?", "Confirmar Exclus" + CHR(227) + "o")
2089:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2090:                         IF THIS.this_oBusinessObject.Excluir()
2091:                             THIS.CarregarLista()
2092:                             THIS.AjustarBotoesPorModo()
2093:                         ELSE
2094:                             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Excluir")
2095:                         ENDIF
2096:                     ELSE
2097:                         MsgErro("Erro ao carregar movimento para exclus" + CHR(227) + "o.", "Erro")
2098:                     ENDIF
2099:                 ENDIF

*-- Linhas 2162 a 2220:
2162: 
2163:     *--------------------------------------------------------------------------
2164:     * CmdFechaLoteClick - Fecha ou cancela fechamento do lote selecionado
2165:     * Legado: cmdfechalote.Click - SELECT SigPdNlt.Chksubn, UPDATE Chksubn
2166:     *--------------------------------------------------------------------------
2167:     PROCEDURE CmdFechaLoteClick()
2168:         LOCAL loc_lResultado, loc_nLote, loc_cSQL, loc_nRet, loc_lSubn
2169:         loc_lResultado = .F.
2170:         loc_nLote      = 0
2171:         loc_lSubn      = .F.
2172: 
2173:         TRY
2174:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2175:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
2176:             ELSE
2177:                 SELECT cursor_4c_Dados
2178:                 loc_nLote = cursor_4c_Dados.nlotes
2179: 
2180:                 loc_cSQL = "SELECT Chksubn FROM SigPdNlt WHERE nlote = " + TRANSFORM(loc_nLote)
2181:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NltTemp")
2182: 
2183:                 IF loc_nRet > 0 AND USED("cursor_4c_NltTemp") AND RECCOUNT("cursor_4c_NltTemp") > 0
2184:                     GO TOP IN cursor_4c_NltTemp
2185:                     loc_lSubn = cursor_4c_NltTemp.Chksubn
2186:                 ENDIF
2187: 
2188:                 IF USED("cursor_4c_NltTemp")
2189:                     USE IN cursor_4c_NltTemp
2190:                 ENDIF
2191: 
2192:                 IF loc_lSubn
2193:                     IF MsgConfirma("Cancelar o fechamento do lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2194:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 0 WHERE nlote = " + TRANSFORM(loc_nLote)
2195:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2196:                         IF loc_nRet > 0
2197:                             THIS.CarregarLista()
2198:                         ELSE
2199:                             MsgErro("Erro ao cancelar fechamento do lote.", "Erro")
2200:                         ENDIF
2201:                     ENDIF
2202:                 ELSE
2203:                     IF MsgConfirma("Fechar o lote " + TRANSFORM(loc_nLote) + "?", "Confirmar")
2204:                         loc_cSQL = "UPDATE SigPdNlt SET Chksubn = 1 WHERE nlote = " + TRANSFORM(loc_nLote)
2205:                         loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
2206:                         IF loc_nRet > 0
2207:                             THIS.CarregarLista()
2208:                         ELSE
2209:                             MsgErro("Erro ao fechar lote.", "Erro")
2210:                         ENDIF
2211:                     ENDIF
2212:                 ENDIF
2213: 
2214:                 loc_lResultado = .T.
2215:             ENDIF
2216: 
2217:         CATCH TO loc_oErro
2218:             IF USED("cursor_4c_NltTemp")
2219:                 USE IN cursor_4c_NltTemp
2220:             ENDIF

*-- Linhas 2743 a 2762:
2743:             IF EMPTY(THIS.this_cDopp)
2744:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2745:             ELSE
2746:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2747:                     "SELECT Boletos FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2748:                     "cursor_4c_BoletoConf")
2749:                 IF loc_nRet > 0 AND USED("cursor_4c_BoletoConf") AND RECCOUNT("cursor_4c_BoletoConf") > 0
2750:                     GO TOP IN cursor_4c_BoletoConf
2751:                     loc_nBoletos = cursor_4c_BoletoConf.Boletos
2752:                 ENDIF
2753:                 IF USED("cursor_4c_BoletoConf")
2754:                     USE IN cursor_4c_BoletoConf
2755:                 ENDIF
2756:                 IF INLIST(loc_nBoletos, 1, 3)
2757:                     THIS.ImpBol()
2758:                 ENDIF
2759:                 loc_lResultado = .T.
2760:             ENDIF
2761:         CATCH TO loc_oErro
2762:             IF USED("cursor_4c_BoletoConf")

*-- Linhas 2805 a 2824:
2805:             IF EMPTY(THIS.this_cDopp)
2806:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada.", "Aviso")
2807:             ELSE
2808:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2809:                     "SELECT Docus, Etiqs FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopp), ;
2810:                     "cursor_4c_DocConf")
2811:                 IF loc_nRet > 0 AND USED("cursor_4c_DocConf") AND RECCOUNT("cursor_4c_DocConf") > 0
2812:                     GO TOP IN cursor_4c_DocConf
2813:                     loc_nDocus = cursor_4c_DocConf.Docus
2814:                     loc_nEtiqs = cursor_4c_DocConf.Etiqs
2815:                 ENDIF
2816:                 IF USED("cursor_4c_DocConf")
2817:                     USE IN cursor_4c_DocConf
2818:                 ENDIF
2819:                 IF loc_nDocus = 1 AND loc_nEtiqs = 1
2820:                     DO FORM FormSigReDct WITH loc_cEmps, loc_cDopps, THIS.this_nPNumes
2821:                 ENDIF
2822:                 loc_lResultado = .T.
2823:             ENDIF
2824:         CATCH TO loc_oErro

*-- Linhas 2882 a 2921:
2882: 
2883:     *--------------------------------------------------------------------------
2884:     * LoteLostFocus - Valida o numero do lote contra SigPdNlt
2885:     * Legado: Get_Lote.Valid - Select nlotes, Datas From SigPdNlt
2886:     *   Where EmpGruEsts = emps+grupoos+contaos And Chksubn = 0
2887:     *--------------------------------------------------------------------------
2888:     PROCEDURE LoteLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2889:         LOCAL loc_oPg2, loc_oCnt, loc_nLote, loc_nRet, loc_cWhere
2890: 
2891:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2892:         loc_oCnt  = .NULL.
2893:         loc_nLote = 0
2894: 
2895:         TRY
2896:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Dados", 5)
2897:                 loc_oCnt  = loc_oPg2.cnt_4c_Dados
2898:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2899:                     loc_nLote = IIF(VARTYPE(loc_oCnt.txt_4c_Lote.Value) = "N", loc_oCnt.txt_4c_Lote.Value, 0)
2900:                 ENDIF
2901:             ENDIF
2902: 
2903:             IF loc_nLote > 0
2904:                 loc_cWhere = " WHERE nlote = " + TRANSFORM(loc_nLote) + " AND Chksubn = 0"
2905:                 loc_nRet   = SQLEXEC(gnConnHandle, ;
2906:                     "SELECT nlotes, Datas FROM SigPdNlt" + loc_cWhere, ;
2907:                     "cursor_4c_NltValid")
2908: 
2909:                 IF loc_nRet > 0 AND USED("cursor_4c_NltValid") AND RECCOUNT("cursor_4c_NltValid") = 0
2910:                     MsgAviso("Lote " + TRANSFORM(loc_nLote) + " n" + CHR(227) + "o encontrado ou fechado.", "Aviso")
2911:                     IF PEMSTATUS(loc_oCnt, "txt_4c_Lote", 5)
2912:                         loc_oCnt.txt_4c_Lote.Value = 0
2913:                         loc_oCnt.txt_4c_Lote.SetFocus()
2914:                     ENDIF
2915:                 ELSE
2916:                     THIS.this_oBusinessObject.this_nNLotes = loc_nLote
2917:                 ENDIF
2918: 
2919:                 IF USED("cursor_4c_NltValid")
2920:                     USE IN cursor_4c_NltValid
2921:                 ENDIF

*-- Linhas 2956 a 2998:
2956:     *--------------------------------------------------------------------------
2957:     * BuscaOpLostFocus - Busca movimento por numero de OP no campo Buscaop
2958:     * Legado: get_buscaop.When -> salva _OldCodigo; Valid -> SQL em SigCdNec
2959:     *   Select numps, cIdChaves From SigCdNec Where EmpDnps Between chaveI and chaveF
2960:     *--------------------------------------------------------------------------
2961:     PROCEDURE BuscaOpLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2962:         LOCAL loc_oPg2, loc_nNovoVal, loc_nRet, loc_cChaveI, loc_cChaveF
2963: 
2964:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2965:         loc_nNovoVal = 0
2966: 
2967:         TRY
2968:             IF PEMSTATUS(loc_oPg2, "txt_4c_Buscaop", 5)
2969:                 loc_nNovoVal = IIF(VARTYPE(loc_oPg2.txt_4c_Buscaop.Value) = "N", loc_oPg2.txt_4c_Buscaop.Value, 0)
2970:             ENDIF
2971: 
2972:             IF loc_nNovoVal <> THIS.this_nOldCodigo AND loc_nNovoVal > 0
2973:                 *-- Compoe chaves de busca: emps + dopps + str(op*10000, 10) range
2974:                 loc_cChaveI = THIS.this_oBusinessObject.this_cEmps + ;
2975:                               PADR(THIS.this_cDopp, 20) + ;
2976:                               RIGHT(STR(loc_nNovoVal * 10000, 12), 10)
2977:                 loc_cChaveF = THIS.this_oBusinessObject.this_cEmps + ;
2978:                               PADR(THIS.this_cDopp, 20) + ;
2979:                               RIGHT(STR((loc_nNovoVal + 1) * 10000, 12), 10)
2980: 
2981:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2982:                     "SELECT numps, cIdChaves FROM SigCdNec WHERE EmpDnps BETWEEN " + ;
2983:                     EscaparSQL(loc_cChaveI) + " AND " + EscaparSQL(loc_cChaveF), ;
2984:                     "cursor_4c_BuscaOp")
2985: 
2986:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaOp") AND RECCOUNT("cursor_4c_BuscaOp") > 0
2987:                     GO TOP IN cursor_4c_BuscaOp
2988:                     THIS.this_nPNumes = cursor_4c_BuscaOp.numps
2989:                     THIS.this_oBusinessObject.CarregarPorChave(cursor_4c_BuscaOp.cIdChaves)
2990:                     THIS.BOParaForm()
2991:                 ENDIF
2992: 
2993:                 IF USED("cursor_4c_BuscaOp")
2994:                     USE IN cursor_4c_BuscaOp
2995:                 ENDIF
2996:             ENDIF
2997: 
2998:             THIS.this_nOldCodigo = loc_nNovoVal

*-- Linhas 3151 a 3173:
3151:                     loc_oPg2.cnt_4c_Origem.txt_4c_DcontaOrig.Value = ""
3152:                 ENDIF
3153:             ELSE
3154:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3155:                 IF !EMPTY(loc_cGrupo)
3156:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3157:                 ENDIF
3158:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrig")
3159: 
3160:                 IF loc_nRet > 0 AND USED("cursor_4c_CliOrig") AND RECCOUNT("cursor_4c_CliOrig") = 0
3161:                     USE IN cursor_4c_CliOrig
3162:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3163:                         "SIGCDCLI", "cursor_4c_CliOrig", "iclis", loc_cConta, ;
3164:                         "Busca de Contas")
3165:                     IF VARTYPE(loc_oBusca) = "O"
3166:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3167:                             loc_cConta = ALLTRIM(cursor_4c_CliOrig.iclis)
3168:                             loc_cNome  = ALLTRIM(cursor_4c_CliOrig.rclis)
3169:                         ELSE
3170:                             IF !loc_oBusca.this_lAchouRegistro
3171:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3172:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3173:                             loc_oBusca.Show()

*-- Linhas 3241 a 3261:
3241:             ENDIF
3242: 
3243:             IF !EMPTY(loc_cNome)
3244:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3245:                     "SELECT iclis, rclis FROM SIGCDCLI WHERE rclis LIKE " + ;
3246:                     EscaparSQL(loc_cNome + "%") + " ORDER BY rclis", "cursor_4c_DCliOrig")
3247: 
3248:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliOrig") AND RECCOUNT("cursor_4c_DCliOrig") > 0
3249:                     IF RECCOUNT("cursor_4c_DCliOrig") = 1
3250:                         GO TOP IN cursor_4c_DCliOrig
3251:                         loc_cConta = ALLTRIM(cursor_4c_DCliOrig.iclis)
3252:                         loc_cNome  = ALLTRIM(cursor_4c_DCliOrig.rclis)
3253:                     ELSE
3254:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3255:                         IF VARTYPE(loc_oBusca) = "O"
3256:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliOrig"
3257:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3258:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3259:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3260:                             loc_oBusca.Show()
3261:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliOrig")

*-- Linhas 3419 a 3441:
3419:                     loc_oPg2.cnt_4c_Destino.txt_4c_DcontaDest.Value = ""
3420:                 ENDIF
3421:             ELSE
3422:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3423:                 IF !EMPTY(loc_cGrupo)
3424:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3425:                 ENDIF
3426:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDest")
3427: 
3428:                 IF loc_nRet > 0 AND USED("cursor_4c_CliDest") AND RECCOUNT("cursor_4c_CliDest") = 0
3429:                     USE IN cursor_4c_CliDest
3430:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3431:                         "SIGCDCLI", "cursor_4c_CliDest", "iclis", loc_cConta, ;
3432:                         "Busca de Contas")
3433:                     IF VARTYPE(loc_oBusca) = "O"
3434:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3435:                             loc_cConta = ALLTRIM(cursor_4c_CliDest.iclis)
3436:                             loc_cNome  = ALLTRIM(cursor_4c_CliDest.rclis)
3437:                         ELSE
3438:                             IF !loc_oBusca.this_lAchouRegistro
3439:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3440:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3441:                             loc_oBusca.Show()

*-- Linhas 3509 a 3529:
3509:             ENDIF
3510: 
3511:             IF !EMPTY(loc_cNome)
3512:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3513:                     "SELECT iclis, rclis FROM SIGCDCLI WHERE rclis LIKE " + ;
3514:                     EscaparSQL(loc_cNome + "%") + " ORDER BY rclis", "cursor_4c_DCliDest")
3515: 
3516:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliDest") AND RECCOUNT("cursor_4c_DCliDest") > 0
3517:                     IF RECCOUNT("cursor_4c_DCliDest") = 1
3518:                         GO TOP IN cursor_4c_DCliDest
3519:                         loc_cConta = ALLTRIM(cursor_4c_DCliDest.iclis)
3520:                         loc_cNome  = ALLTRIM(cursor_4c_DCliDest.rclis)
3521:                     ELSE
3522:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3523:                         IF VARTYPE(loc_oBusca) = "O"
3524:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliDest"
3525:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3526:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3527:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3528:                             loc_oBusca.Show()
3529:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliDest")

*-- Linhas 3687 a 3709:
3687:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
3688:                 ENDIF
3689:             ELSE
3690:                 loc_cSQL = "SELECT iclis, rclis, grupos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cConta)
3691:                 IF !EMPTY(loc_cGrupo)
3692:                     loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
3693:                 ENDIF
3694:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliResp")
3695: 
3696:                 IF loc_nRet > 0 AND USED("cursor_4c_CliResp") AND RECCOUNT("cursor_4c_CliResp") = 0
3697:                     USE IN cursor_4c_CliResp
3698:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3699:                         "SIGCDCLI", "cursor_4c_CliResp", "iclis", loc_cConta, ;
3700:                         "Busca de Contas")
3701:                     IF VARTYPE(loc_oBusca) = "O"
3702:                         IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3703:                             loc_cConta = ALLTRIM(cursor_4c_CliResp.iclis)
3704:                             loc_cNome  = ALLTRIM(cursor_4c_CliResp.rclis)
3705:                         ELSE
3706:                             IF !loc_oBusca.this_lAchouRegistro
3707:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                      "C" + CHR(243) + "digo")
3708:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3709:                             loc_oBusca.Show()

*-- Linhas 3777 a 3797:
3777:             ENDIF
3778: 
3779:             IF !EMPTY(loc_cNome)
3780:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3781:                     "SELECT iclis, rclis FROM SIGCDCLI WHERE rclis LIKE " + ;
3782:                     EscaparSQL(loc_cNome + "%") + " ORDER BY rclis", "cursor_4c_DCliResp")
3783: 
3784:                 IF loc_nRet > 0 AND USED("cursor_4c_DCliResp") AND RECCOUNT("cursor_4c_DCliResp") > 0
3785:                     IF RECCOUNT("cursor_4c_DCliResp") = 1
3786:                         GO TOP IN cursor_4c_DCliResp
3787:                         loc_cConta = ALLTRIM(cursor_4c_DCliResp.iclis)
3788:                         loc_cNome  = ALLTRIM(cursor_4c_DCliResp.rclis)
3789:                     ELSE
3790:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3791:                         IF VARTYPE(loc_oBusca) = "O"
3792:                             loc_oBusca.this_cCursorDestino = "cursor_4c_DCliResp"
3793:                             loc_oBusca.this_cTitulo = "Contas por Nome"
3794:                             loc_oBusca.mAddColuna("rclis",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Nome")
3795:                             loc_oBusca.mAddColuna("iclis",  "XXXXXXXXXX",                                        "C" + CHR(243) + "digo")
3796:                             loc_oBusca.Show()
3797:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_DCliResp")

*-- Linhas 3863 a 3889:
3863:             ELSE
3864:                 THIS.this_cAntValue = TRANSFORM(loc_nCod)
3865: 
3866:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3867:                     "SELECT codigos, descrs, observas FROM SigCdObs WHERE codigos = " + ;
3868:                     FormatarNumeroSQL(loc_nCod), "cursor_4c_ObsBusca")
3869: 
3870:                 IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca") AND RECCOUNT("cursor_4c_ObsBusca") = 0
3871:                     USE IN cursor_4c_ObsBusca
3872:                     *-- Nao encontrou: abre busca completa
3873:                     loc_nRet = SQLEXEC(gnConnHandle, ;
3874:                         "SELECT codigos, descrs, observas FROM SigCdObs ORDER BY codigos", ;
3875:                         "cursor_4c_ObsBusca")
3876: 
3877:                     IF loc_nRet > 0 AND USED("cursor_4c_ObsBusca")
3878:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3879:                         IF VARTYPE(loc_oBusca) = "O"
3880:                             loc_oBusca.this_cCursorDestino = "cursor_4c_ObsBusca"
3881:                             loc_oBusca.this_cTitulo = "Observa" + CHR(231) + CHR(227) + "es"
3882:                             loc_oBusca.mAddColuna("codigos", "999",                                                "C" + CHR(243) + "d.")
3883:                             loc_oBusca.mAddColuna("descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3884:                             loc_oBusca.Show()
3885:                             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ObsBusca")
3886:                                 GO TOP IN cursor_4c_ObsBusca
3887:                                 loc_nCod = cursor_4c_ObsBusca.codigos
3888:                                 loc_cObs = IIF(VARTYPE(cursor_4c_ObsBusca.observas) = "C", cursor_4c_ObsBusca.observas, "")
3889:                             ELSE


### BO (C:\4c\projeto\app\classes\sigpdmp6BO.prg):
*==============================================================================
* sigpdmp6BO.prg - Business Object para Movimentacao de Industria
* Tabela principal: SigCdNec | PK: cidchaves (char 20, gerado por fUniqueIds)
* Chave composta: empdnps = emps(3) + dopps(20) + str(numps,10) -> char(33)
*==============================================================================

DEFINE CLASS sigpdmp6BO AS BusinessBase

    *-- Identificacao e Chave
    this_cCidChaves  = ""    && cidchaves  CHAR(20) - PK (gerado por fUniqueIds)
    this_cEmpDnPs    = ""    && empdnps    CHAR(33) - Chave composta (emps+dopps+str(numps,10))

    *-- Campos da chave composta
    this_cEmps       = ""    && emps       CHAR(3)  - Empresa
    this_cDopps      = ""    && dopps      CHAR(20) - Codigo da operacao/documento
    this_nNumps      = 0     && numps      NUMERIC(10,0) - Numero do movimento

    *-- Datas
    this_tDatars     = {}    && datars     DATETIME - Data/hora do registro
    this_dDatas      = {}    && datas      DATETIME - Data do movimento
    this_tDataTrans  = {}    && datatrans  DATETIME - Data de transferencia

    *-- Origem
    this_cGrupoos    = ""    && grupoos    CHAR(10) - Grupo de conta corrente de origem
    this_cContaos    = ""    && contaos    CHAR(10) - Conta de origem

    *-- Destino
    this_cGrupods    = ""    && grupods    CHAR(10) - Grupo de conta corrente de destino
    this_cContads    = ""    && contads    CHAR(10) - Conta de destino
    this_cEmpds      = ""    && empds      CHAR(3)  - Empresa de destino

    *-- Vendedor
    this_cGrVends    = ""    && grvends    CHAR(10) - Grupo do vendedor
    this_cVends      = ""    && vends      CHAR(10) - Vendedor

    *-- Pesos e Totais
    this_nTotPesos   = 0     && totpesos   NUMERIC(11,3) - Peso total
    this_nPesoLancs  = 0     && pesolancs  NUMERIC(11,3) - Peso lancado

    *-- Lotes e OPs
    this_nNLotes     = 0     && nlotes     NUMERIC(10,0) - Numero do lote (0=sem lote)
    this_nNAceites   = 0     && naceites   NUMERIC(10,0) - Numero de aceites
    this_nNops       = 0     && nops       NUMERIC(10,0) - Numero da OP

    *-- Transacao e Local
    this_nNTrans     = 0     && ntrans     NUMERIC(6,0)  - Numero de transacao
    this_cLocals     = ""    && locals     CHAR(10) - Local
    this_cJobs       = ""    && jobs       CHAR(10) - Job

    *-- Documento e Observacao
    this_cDocus      = ""    && docus      CHAR(10) - Numero do documento
    this_nCodObs     = 0     && codobs     NUMERIC(3,0) - Codigo de observacao
    this_cObss       = ""    && obss       TEXT     - Texto de observacao

    *-- Nao Conformidade
    this_lNConforms  = .F.   && nconforms  BIT      - Nao conforme (flag)
    this_cCodNConfs  = ""    && codnconfs  CHAR(10) - Codigo de nao conformidade

    *-- Balancos
    this_nNumBals    = 0     && numbals    NUMERIC(6,0) - Numero do balanco
    this_nNumBalds   = 0     && numbalds   NUMERIC(6,0) - Numero do balanco destino

    *-- Usuarios
    this_cUsuars     = ""    && usuars     CHAR(10) - Usuario que lancou
    this_cUsuLibs    = ""    && usulibs    CHAR(10) - Usuario que liberou
    this_cUsuConfs   = ""    && usuconfs   CHAR(10) - Usuario que confirmou

    *-- Flags bit
    this_lRetrabs    = .F.   && retrabs    BIT - Retrabalho
    this_lChksubn    = .F.   && chksubn    BIT - Subnivel/lote fechado
    this_lProcbals   = .F.   && procbals   BIT - Processado no balancete
    this_lProcdbal   = .F.   && procdbal   BIT - Processado no balancete 2
    this_lImprs      = .F.   && imprs      BIT - Impresso
    this_lAutos      = .F.   && autos      BIT - Processamento automatico
    this_lLccs       = .F.   && lccs       BIT - LCC (Lote Controle Cliente)
    this_nChkBaixa   = 0     && chkbaixa   NUMERIC(1,0) - Flag baixa

    *-- Liberacao (char, nao bit)
    this_cLibProds   = ""    && libprods   CHAR(10) - Liberado para producao

    *-- Descricoes lookup (nao armazenadas)
    this_cNomeContaOs  = ""  && Nome da conta de origem (lookup SigCdCli)
    this_cNomeContads  = ""  && Nome da conta de destino (lookup SigCdCli)
    this_cNomeVends    = ""  && Nome do vendedor (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDnPs    = TratarNulo(empdnps,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_nNumps      = TratarNulo(numps,      "N")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_tDatars     = TratarNulo(datars,     "T")
                THIS.this_tDataTrans  = TratarNulo(datatrans,  "T")
                THIS.this_cGrupoos    = TratarNulo(grupoos,    "C")
                THIS.this_cContaos    = TratarNulo(contaos,    "C")
                THIS.this_cGrupods    = TratarNulo(grupods,    "C")
                THIS.this_cContads    = TratarNulo(contads,    "C")
                THIS.this_cEmpds      = TratarNulo(empds,      "C")
                THIS.this_cGrVends    = TratarNulo(grvends,    "C")
                THIS.this_cVends      = TratarNulo(vends,      "C")
                THIS.this_nTotPesos   = TratarNulo(totpesos,   "N")
                THIS.this_nPesoLancs  = TratarNulo(pesolancs,  "N")
                THIS.this_nNLotes     = TratarNulo(nlotes,     "N")
                THIS.this_nNAceites   = TratarNulo(naceites,   "N")
                THIS.this_nNops       = TratarNulo(nops,       "N")
                THIS.this_nNTrans     = TratarNulo(ntrans,     "N")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_cJobs       = TratarNulo(jobs,       "C")
                THIS.this_cDocus      = TratarNulo(docus,      "C")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cObss       = TratarNulo(obss,       "C")
                THIS.this_lNConforms  = ConverterParaLogico(nconforms)
                THIS.this_cCodNConfs  = TratarNulo(codnconfs,  "C")
                THIS.this_nNumBals    = TratarNulo(numbals,    "N")
                THIS.this_nNumBalds   = TratarNulo(numbalds,   "N")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cUsuLibs    = TratarNulo(usulibs,    "C")
                THIS.this_cUsuConfs   = TratarNulo(usuconfs,   "C")
                THIS.this_lRetrabs    = ConverterParaLogico(retrabs)
                THIS.this_lChksubn    = ConverterParaLogico(chksubn)
                THIS.this_lProcbals   = ConverterParaLogico(procbals)
                THIS.this_lProcdbal   = ConverterParaLogico(procdbal)
                THIS.this_lImprs      = ConverterParaLogico(imprs)
                THIS.this_lAutos      = ConverterParaLogico(autos)
                THIS.this_lLccs       = ConverterParaLogico(lccs)
                THIS.this_nChkBaixa   = TratarNulo(chkbaixa,  "N")
                THIS.this_cLibProds   = TratarNulo(libprods,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos em cursor_4c_Dados
    * par_cFiltro: clausula WHERE sem a palavra WHERE (vazio = sem filtro)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.grupoos, n.contaos, n.grupods, n.contads," + ;
                       " n.grvends, n.vends, n.usuars, n.codobs, n.docus, n.nlotes," + ;
                       " n.naceites, n.nops, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.imprs, n.autos," + ;
                       " n.lccs, n.libprods, n.codnconfs, n.jobs, n.locals," + ;
                       " n.empds, n.chkbaixa" + ;
                       " FROM SigCdNec n"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY n.datas DESC, n.numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos de ind" + CHR(250) + "stria:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - Busca movimentos por empresa, operacao e periodo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopp, par_dDtI, par_dDtF)
        LOCAL loc_cFiltro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFiltro = "n.emps = " + EscaparSQL(par_cEmps)

            IF !EMPTY(ALLTRIM(par_cDopp))
                loc_cFiltro = loc_cFiltro + " AND n.dopps = " + EscaparSQL(par_cDopp)
            ENDIF

            IF !EMPTY(par_dDtI)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) >= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtI) + ")"
            ENDIF

            IF !EMPTY(par_dDtF)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) <= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtF) + ")"
            ENDIF

            loc_lSucesso = THIS.Buscar(loc_cFiltro)

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.datatrans, n.grupoos, n.contaos," + ;
                       " n.grupods, n.contads, n.empds, n.grvends, n.vends," + ;
                       " n.usuars, n.codobs, n.obss, n.docus, n.nlotes, n.naceites," + ;
                       " n.nops, n.ntrans, n.locals, n.jobs, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.codnconfs," + ;
                       " n.procbals, n.procdbal, n.imprs, n.autos, n.lccs," + ;
                       " n.libprods, n.numbals, n.numbalds," + ;
                       " n.usulibs, n.chkbaixa, n.usuconfs" + ;
                       " FROM SigCdNec n" + ;
                       " WHERE n.cidchaves = " + EscaparSQL(par_cCidChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorEmpDnPs - Carrega pelo empdnps (chave composta alternativa)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorEmpDnPs(par_cEmpDnPs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdNec WHERE empdnps = " + ;
                       EscaparSQL(par_cEmpDnPs)

            IF USED("cursor_4c_ChaveBusca")
                USE IN cursor_4c_ChaveBusca
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChaveBusca")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChaveBusca") > 0
                SELECT cursor_4c_ChaveBusca
                loc_cCidChaves = ALLTRIM(cursor_4c_ChaveBusca.cidchaves)
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
                loc_lSucesso = THIS.CarregarPorCodigo(loc_cCidChaves)
            ELSE
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorEmpDnPs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNec (PROTECTED)
    * Nota: cidchaves deve ser gerado antes (via fUniqueIds ou equivalente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Monta chave composta empdnps
            THIS.this_cEmpDnPs = PADR(ALLTRIM(THIS.this_cEmps), 3)  + ;
                                  PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                  STR(THIS.this_nNumps, 10)

            *-- Usuario logado
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (cidchaves, empdnps, emps, dopps, numps," + ;
                       "  datas, grupoos, contaos, grupods, contads, empds," + ;
                       "  grvends, vends, usuars, codobs, docus," + ;
                       "  nlotes, naceites, nops, ntrans, locals, jobs," + ;
                       "  totpesos, pesolancs, retrabs, chksubn," + ;
                       "  nconforms, codnconfs, procbals, procdbal," + ;
                       "  imprs, autos, lccs, libprods, chkbaixa)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)            + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)              + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                 + ", " + ;
                       EscaparSQL(THIS.this_cDopps)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)          + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos)              + ", " + ;
                       EscaparSQL(THIS.this_cContaos)              + ", " + ;
                       EscaparSQL(THIS.this_cGrupods)              + ", " + ;
                       EscaparSQL(THIS.this_cContads)              + ", " + ;
                       EscaparSQL(THIS.this_cEmpds)                + ", " + ;
                       EscaparSQL(THIS.this_cGrVends)              + ", " + ;
                       EscaparSQL(THIS.this_cVends)                + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs)         + ", " + ;
                       EscaparSQL(THIS.this_cDocus)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNLotes)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNAceites)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops)           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNTrans)         + ", " + ;
                       EscaparSQL(THIS.this_cLocals)               + ", " + ;
                       EscaparSQL(THIS.this_cJobs)                 + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesoLancs)      + ", " + ;
                       IIF(THIS.this_lRetrabs,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lChksubn,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lNConforms, "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cCodNConfs)            + ", " + ;
                       IIF(THIS.this_lProcbals,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lProcdbal,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lImprs,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lAutos,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lLccs,      "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cLibProds)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkBaixa)       + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Salvar obss (TEXT) separadamente se preenchido
                IF !EMPTY(ALLTRIM(THIS.this_cObss))
                    THIS.AtualizarObss()
                ENDIF
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNec (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas     = " + FormatarDataSQL(THIS.this_dDatas)    + ", " + ;
                       "  grupoos   = " + EscaparSQL(THIS.this_cGrupoos)       + ", " + ;
                       "  contaos   = " + EscaparSQL(THIS.this_cContaos)       + ", " + ;
                       "  grupods   = " + EscaparSQL(THIS.this_cGrupods)       + ", " + ;
                       "  contads   = " + EscaparSQL(THIS.this_cContads)       + ", " + ;
                       "  empds     = " + EscaparSQL(THIS.this_cEmpds)         + ", " + ;
                       "  grvends   = " + EscaparSQL(THIS.this_cGrVends)       + ", " + ;
                       "  vends     = " + EscaparSQL(THIS.this_cVends)         + ", " + ;
                       "  codobs    = " + FormatarNumeroSQL(THIS.this_nCodObs) + ", " + ;
                       "  docus     = " + EscaparSQL(THIS.this_cDocus)         + ", " + ;
                       "  nlotes    = " + FormatarNumeroSQL(THIS.this_nNLotes) + ", " + ;
                       "  naceites  = " + FormatarNumeroSQL(THIS.this_nNAceites) + ", " + ;
                       "  nops      = " + FormatarNumeroSQL(THIS.this_nNops)   + ", " + ;
                       "  totpesos  = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "  pesolancs = " + FormatarNumeroSQL(THIS.this_nPesoLancs) + ", " + ;
                       "  retrabs   = " + IIF(THIS.this_lRetrabs, "1", "0")   + ", " + ;
                       "  chksubn   = " + IIF(THIS.this_lChksubn, "1", "0")   + ", " + ;
                       "  nconforms = " + IIF(THIS.this_lNConforms, "1", "0") + ", " + ;
                       "  codnconfs = " + EscaparSQL(THIS.this_cCodNConfs)    + ", " + ;
                       "  imprs     = " + IIF(THIS.this_lImprs, "1", "0")     + ", " + ;
                       "  autos     = " + IIF(THIS.this_lAutos, "1", "0")     + ", " + ;
                       "  lccs      = " + IIF(THIS.this_lLccs, "1", "0")      + ", " + ;
                       "  libprods  = " + EscaparSQL(THIS.this_cLibProds)     + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Atualizar obss (TEXT) separadamente
                THIS.AtualizarObss()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarObss - Salva campo TEXT obss separadamente
    * Campos TEXT/NTEXT exigem UPDATE separado em alguns cenarios ODBC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarObss()
        LOCAL loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET obss = " + EscaparSQL(THIS.this_cObss) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNec (PROTECTED)
    * Exclui apenas o cabecalho. A logica do form deve excluir SigCdNei,
    * SigMvHst, SigMvCab e demais tabelas filhas antes de chamar Excluir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens do movimento (SigCdNei) antes do cabecalho
            loc_cSQL = "DELETE FROM SigCdNei WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDnPs)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens do movimento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

