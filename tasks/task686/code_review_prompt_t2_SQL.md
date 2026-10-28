# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'OPERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTORIGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ESTDESTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: SALDO, GERBALS, EMPS, GRUPOS, ESTOS, ICLIS, CONTADS, PROCDBAL, CONTAOS, PROCBALS, GRUPOOS, NOPS, CGRUS, CODIGOS, CMATS, GRUESTPS, CONESTPS, EMPDS, CPROS, VARIAS, AGREGAS, APLICFLHS, LCQUERY, 0, TFALHAS, RECFALS, FASES, CONTAS, DATAS, EMPDNPS, SERVICOS, EMPDOPNUMS

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
  Column1.ControlSource = "TmpSaldo.Codigo"
  Column2.ControlSource = "TmpSaldo.Nome"
  Column3.ControlSource = "TmpSaldo.Fase"
  Column4.ControlSource = "TmpSaldo.Saldo"
  Column5.ControlSource = "TmpSaldo.Data"
Insert Into TmpCabec (Empresa, Titulo, SubTitulo) Values (lcEmpresa, lcTitulo, lcSubTitulo)
Select TmpSaldo
		Select crSigOpOpt
		Select crSigCdOpe
		Select LocalOpp
		Select crSigCdGcr
			lcQuery = [Select CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs ] + ;
					    [From SigCdPro]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPro') < 1)
			Select TmpPro
		lcQuery = [Select IClis, RClis, Grupos, Inativas ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
		Select TmpCli
		lcQuery = [Select Codigos, Descrs, TrfPesas, CompAgrus ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpGccr') < 1)
		Select TmpGccr
Select TmpOpera
Select TmpResumo
Select TmpSaldo 
lcQuery = [Select Grupos, Estos ] + ;
		    [From SigMvEst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvEst') < 1)
Select crSigMvEst
	loBarraP.UpDate(.t.)
	lcSql = [Select Rclis, GerBals, PagFals, RecFals From SigCdCli where Iclis = ']+CrSigMvEst.Estos+[']
	If Thisform.Podatamgr.Sqlexecute(lcSql,'CrSigCdCli') < 1
	=Seek(CrSigMvEst.Grupos,'CrSigCdGcr','Codigos')
	lcQuery = [Select Top 1 Datas ] + ;
			    [From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdFcx') < 1)
	Insert Into TmpSaldo (Codigo, Nome, Fase, Data) ;
	lcQuery = [Select Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, Obss, cIdChaves, EmpDnPs ] + ;
				[From SigCdNec ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNens') < 1)
	lcQuery = [Select b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams ] + ;
				[From SigCdNec a, SigCdNei b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalNensI') < 1)
	Select LocalNensI
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
			lcSql = [Select GruEstPs,ConEstPs,nAgMts,TipoEstos,Mercs From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
			lcSql = [Select Aplicflhs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + LocalNensI.TpOps, 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, AplicFlhs ) ;
				Select TmpOpera
				=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats+ lcCodCor + lcCodTam, 'TmpResumo')
					Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams ) ;
				Select TmpResumo
				If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + LocalNensI.TpOps, 'TmpOpera')
					Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
				Select TmpOpera
				=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
			=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
			lcSql = [Select Aplicflhs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
				=Seek(_Material, 'TmpPro', 'CPros')
				lcSql = [Select Aplicflhs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
					If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, visivel ) ;
					Select TmpResumo
					If Not Seek(LocalNens.GrupoOs + LocalNens.ContaOs + _Material + LocalNensI.TpOps, 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, VArias, Agregas, AplicFlhs) ;
					Select TmpOpera
					If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material , 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Visivel ) ;
					Select TmpResumo
					If Not Seek(LocalNens.GrupoDs + LocalNens.ContaDs + _Material + LocalNensI.TpOps, 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
					Select TmpOpera
	lcQuery = [Select Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Dopes, Numes, Obses, CidChaves, EmpDs ] + ;
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
			lcSql = [Select GruEstPs,ConEstPs,nAgMts,TipoEstos,mercs From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
			lcSql = [Select Aplicflhs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
			Select LocalEsti2
			If Seek(LocalEesti.EmpDopNums + LocalEesti.Cpros + Str(LocalEesti.Citens,4))
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams  ) ;
						Select TmpResumo
						If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
							Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, AGregas, AplicFlhs) ;
						Select TmpOpera
						If Not Seek(_Grupo + _Conta + LocalEsti2.CPros + lcCodCor + lcCodTam, 'TmpResumo')
							Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel, CodCors, CodTams ) ;
						Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel  ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs) ;
					Select TmpOpera
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros, 'TmpResumo')
						Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
					Select TmpResumo
					If Not Seek(_Grupo + _Conta + LocalEestI.CPros + Space(15), 'TmpOpera')
						Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, Varias, Agregas, AplicFlhs) ;
					Select TmpOpera
	lcQuery = [Select Emps, Codigos ] + ;
				[From SigCdPsc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPesa') < 1)
	Select LocalPesa
		lcQuery = [Select CPros, Qtds ] + ;
					[From SigCdPsi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPesaI') < 1)
		Select LocalPesaI
			=Seek(LocalPesaI.CPros, 'TmpPro', 'CPros')
			lcSql = [Select GruEstPs,ConEstPs,nAgMts,TipoEstos,mercs From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
			lcSql = [Select Aplicflhs From SigCdGpr Where Codigos = ']+LocalGru.Mercs+[']
			=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGgrp')
			If Not Seek(_Grupo + _Conta + LocalPesaI.CPros, 'TmpResumo')
				Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, visivel ) ;
			Select TmpResumo
	Select TmpResumo
	Select TmpOpera
		Select TmpResumo
		If Not Seek(_Grupo + _Conta + lcMat)
		Select [ ] as Agrupar,Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
		  From TmpResumo ;
		Select TmpResumo
		=Seek(_Grupo + _Conta)
		Select Grupo, Conta, TpOps, Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
		  From TmpOpera ;
		Select csTotal
			If Not Seek(csTotal.Grupo + csTotal.Conta + lcMat + csTotal.TpOps, 'TmpOpera')
				Insert Into TmpOpera (Grupo, Conta, CMats, TpOps, AplicFlhs ) ;
		Select Grupo, Conta, TpOps, Sum(PesoEnts) as pEnts, Sum(PesoSais) as pSais ;
		  From TmpOpera ;
		Select csTotal
			If Seek(csTotal.Grupo + csTotal.Conta + lcMat + csTotal.TpOps, 'TmpOpera')
	lcQuery = [Select Codigos ] + ;
				[From SigCdFcx ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrUltBal') < 1)
	Select CrUltBal
		lcSql = [Select * From SigOpCfe Where Codigos = ]+Str(CrUltBal.Codigos,6)+[ And Emps= ']+_Empr+[' Order by Codigos, cpros ]
		lcSql = [Select * From SigOpCfe Where 0 = 1 ]
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'CrSaldoI') < 1
	Select CrSaldoI
	Select TmpResumo
	=Seek(_Grupo + _Conta)
		loBarra.Update(.t.)
		=Seek(TmpResumo.CMats, 'TmpPro', 'CPros')
		Select CrSaldoI
		=Seek(TmpResumo.Cmats)
		Select TmpOpera
		=Seek(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
			=Seek(TmpOpera.TpOps, 'crSigOpOpt', 'Cods')
		Select TmpResumo
	Select CrSaldoI
		loBarra.Update(.t.)
		=Seek(CrSaldoI.Cpros, 'TmpPro', 'CPros')
		lcSql = [Select GruEstPs,ConEstPs,nAgMts,TipoEstos,mercs From SigCdGrp Where Cgrus = ']+TmpPro.Cgrus+[']
		=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalGru')
		Select TmpResumo
			Insert Into TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
			Select TmpResumo
Select TmpSaldo
	Select TmpResumo
	=Seek(TmpSaldo.Fase + TmpSaldo.Codigo + lcCodMat)
Select TmpSaldo
	Delete For Saldo = 0
	If Not Empty(This.Value) And Not Seek(This.Value, 'TmpGccr', 'BalCodigo')
	If Not Seek(This.Value, 'TmpCli', 'BalCodigo')
	If Not Seek(This.Value, 'TmpCli', 'BalNome')
	If Not Empty(This.Value) And Not Seek(Padr(This.Value,40), 'TmpGccr', 'BalDescrs')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCFE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1686 linhas total):

*-- Linhas 1058 a 1095:
1058:     * PROTECTED obrigatorio: FormBase.prg declara PROTECTED PROCEDURE
1059:     * LimparCampos (ver nota em FormParaBO).
1060:     *
1061:     * O ZAP eh seguro aqui: cursor_4c_Saldo nasce de CREATE CURSOR, logo com
1062:     * Buffering = 1 (regra #52), e o Form nao declara DataSession = 2.
1063:     *
1064:     * this_lResultadoValido volta a .T. de proposito - e NAO a .F.: o SCX
1065:     * legado nao declara Grade.Visible nem Visualizar/Imprimir.Enabled, logo
1066:     * a tela ABRE com a grade (vazia) visivel e os dois botoes habilitados, e
1067:     * quem clicar em Video/Impressora antes de processar recebe o aviso
1068:     * "Nenhuma Informacao Selecionada!!!" do proprio metodo de emissao.
1069:     * Derrubar os botoes aqui seria desvio do PILAR 1.
1070:     *==========================================================================
1071:     PROTECTED PROCEDURE LimparCampos()
1072:         LOCAL loc_oErro
1073:         TRY
1074:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1075:                 THIS.this_oBusinessObject.LimparDados()
1076:                 THIS.BOParaForm()
1077:             ENDIF
1078: 
1079:             IF USED("cursor_4c_Saldo")
1080:                 SELECT cursor_4c_Saldo
1081:                 ZAP
1082:             ENDIF
1083: 
1084:             THIS.this_lResultadoValido = .T.
1085:             THIS.AjustarBotoesPorModo()
1086:             THIS.HabilitarCampos(.T.)
1087:             THIS.CarregarDados()
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + CHR(13) + ;
1090:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1091:                     "Procedure: " + loc_oErro.Procedure, "Erro em LimparCampos")
1092:         ENDTRY
1093:     ENDPROC
1094: 
1095:     *==========================================================================

*-- Linhas 1175 a 1211:
1175:         TRY
1176:             IF !USED("cursor_4c_Saldo")
1177:                 SET NULL ON
1178:                 CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
1179:                                                 Saldo N(12,3), Data D)
1180:                 SET NULL OFF
1181:                 INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
1182:                 INDEX ON Codigo + Fase TAG Codigo
1183:                 INDEX ON Fase + Codigo TAG Carrega
1184:             ENDIF
1185: 
1186:             THIS.AddObject("grd_4c_Dados", "Grid")
1187:             WITH THIS.grd_4c_Dados
1188:                 .Top               = 230
1189:                 .Left              = 119
1190:                 .Width             = 561
1191:                 .Height            = 326
1192:                 .FontName          = "Tahoma"
1193:                 .FontSize          = 8
1194:                 .AllowHeaderSizing = .F.
1195:                 .AllowRowSizing    = .F.
1196:                 .DeleteMark        = .F.
1197:                 .RecordMark        = .F.
1198:                 .ScrollBars        = 2
1199:                 .RowHeight         = 17
1200:                 .GridLineColor     = RGB(238, 238, 238)
1201:                 .ReadOnly          = .T.
1202:                 .ColumnCount       = 5
1203:                 .Visible           = .T.
1204:             ENDWITH
1205: 
1206:             THIS.CarregarDados()
1207:         CATCH TO loc_oErro
1208:             MsgErro(loc_oErro.Message + CHR(13) + ;
1209:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1210:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
1211:         ENDTRY

*-- Linhas 1218 a 1264:
1218:     * independente, eh o RESULTADO do processamento disparado pelos campos de
1219:     * filtro - ver nota de Fase 8/8 no cabecalho do arquivo). PUBLIC para ser
1220:     * alcancavel por LimparCampos() e pelos harness de verificacao.
1221:     * Column.Width/Header1 sao redefinidos DEPOIS do ControlSource (Problema
1222:     * 48 CLAUDE.md: RecordSource reseta Width para 90 e Header1.Caption para
1223:     * "Header1"). Chamado agora (grade vazia) e sera chamado de novo quando
1224:     * Processar (fase futura) repopular cursor_4c_Saldo - por isso tambem
1225:     * fecha com GO TOP + Refresh (regra #21: popular cursor nao repinta a
1226:     * grade por si so).
1227:     *==========================================================================
1228:     PROCEDURE CarregarDados()
1229:         LOCAL loc_oErro, loc_oGrid
1230:         TRY
1231:             IF !USED("cursor_4c_Saldo")
1232:                 SET NULL ON
1233:                 CREATE CURSOR cursor_4c_Saldo (Codigo C(10), Nome C(50), Fase C(10), ;
1234:                                                 Saldo N(12,3), Data D)
1235:                 SET NULL OFF
1236:                 INDEX ON Codigo + Fase TAG Impressao FOR Saldo <> 0
1237:                 INDEX ON Codigo + Fase TAG Codigo
1238:                 INDEX ON Fase + Codigo TAG Carrega
1239:             ENDIF
1240: 
1241:             loc_oGrid = THIS.grd_4c_Dados
1242:             loc_oGrid.RecordSource = ""
1243:             loc_oGrid.RecordSource = "cursor_4c_Saldo"
1244: 
1245:             loc_oGrid.Column1.ControlSource = "cursor_4c_Saldo.Codigo"
1246:             loc_oGrid.Column2.ControlSource = "cursor_4c_Saldo.Nome"
1247:             loc_oGrid.Column3.ControlSource = "cursor_4c_Saldo.Fase"
1248:             loc_oGrid.Column4.ControlSource = "cursor_4c_Saldo.Saldo"
1249:             loc_oGrid.Column5.ControlSource = "cursor_4c_Saldo.Data"
1250: 
1251:             WITH loc_oGrid.Column1
1252:                 .FontName  = "Tahoma"
1253:                 .FontSize  = 8
1254:                 .Width     = 80
1255:                 .Movable   = .F.
1256:                 .Resizable = .F.
1257:                 .ReadOnly  = .T.
1258:                 .Header1.Caption   = "Funcion" + CHR(225) + "rio"
1259:                 .Header1.Alignment = 2
1260:                 .Header1.FontName  = "Tahoma"
1261:                 .Header1.FontSize  = 8
1262:                 .Header1.ForeColor = RGB(0, 0, 0)
1263:                 .Text1.BorderStyle = 0
1264:                 .Text1.Margin      = 0

*-- Linhas 1353 a 1371:
1353:                 .Text1.FontSize    = 8
1354:             ENDWITH
1355: 
1356:             SELECT cursor_4c_Saldo
1357:             GO TOP
1358:             loc_oGrid.Refresh()
1359:         CATCH TO loc_oErro
1360:             MsgErro(loc_oErro.Message + CHR(13) + ;
1361:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1362:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1363:         ENDTRY
1364:     ENDPROC
1365: 
1366:     *==========================================================================
1367:     * ConfigurarBotoes - Cria os 4 botoes de acao reais do SIGOPCFE.SCX
1368:     * (Processar/Video/Impressora/Encerrar - este form OPERACIONAL nao tem
1369:     * CRUD Incluir/Alterar/Excluir). Standalone CommandButton com Picture
1370:     * usa Themes=.T. + DisabledPicture (nao o Themes=.F. literal do SCX) -
1371:     * Visualizar/Imprimir sao Enabled/Disabled durante o processamento

*-- Linhas 1526 a 1544:
1526: 
1527:         *-- TRY/CATCH so em volta do processamento (Fase 8/8): ProcessarSaldos
1528:         *-- devolve .F. nos caminhos previstos, mas uma falha inesperada
1529:         *-- (fwprogressbar, SQLEXEC) nao pode deixar a tela com o painel
1530:         *-- "Aguarde..." no ar e os campos desabilitados para sempre - o
1531:         *-- restabelecimento abaixo roda em qualquer saida. Sem RETURN dentro
1532:         *-- do bloco (regra #1).
1533:         TRY
1534:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarSaldos()
1535:         CATCH TO loc_oErro
1536:             loc_lSucesso = .F.
1537:             MsgErro(loc_oErro.Message + CHR(13) + ;
1538:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1539:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdProcessaClick")
1540:         ENDTRY
1541: 
1542:         THIS.cnt_4c_Mensagem.Visible = .F.
1543:         THIS.HabilitarCampos(.T.)
1544: 

