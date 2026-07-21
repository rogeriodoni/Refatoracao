*====================================================================
* SigPrFemBO.prg
*
* Business Object para Analise de Producao (SIGPRFEM)
* Form OPERACIONAL - processamento analitico sem CRUD
*====================================================================

DEFINE CLASS SigPrFemBO AS BusinessBase

	*-- Parametros de consulta (filtros do form)
	this_dDataInicio    = {}
	this_dDataFinal     = {}
	this_cDemonstrativo = ""
	this_cEmpresa       = ""
	this_cGrupos        = ""
	this_cContas        = ""

	*-- Material principal e operacao de balanco (SigCdPam)
	this_cCodMat    = ""
	this_cDopeBals  = ""

	*-- Tempo de fechamento em segundos (SigCdPac.ndFechas)
	this_nNdFechas  = 0

	*-- Totalizadores do painel Resumo
	this_nSaldoIni  = 0
	this_nSaldoAnt  = 0
	this_nEntradas  = 0
	this_nTEntradas = 0
	this_nSaidas    = 0
	this_nSaldo     = 0
	this_nSaldoFunc = 0
	this_nPesagem   = 0
	this_nSaldoT    = 0
	this_nFalhaFunc = 0

	*====================================================================
	* Init
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()

			THIS.this_cTabela     = ""
			THIS.this_cCampoChave = ""

			THIS.this_dDataInicio    = {}
			THIS.this_dDataFinal     = {}
			THIS.this_cDemonstrativo = ""
			THIS.this_cEmpresa       = go_4c_Sistema.cCodEmpresa
			THIS.this_cGrupos        = ""
			THIS.this_cContas        = ""
			THIS.this_cCodMat        = ""
			THIS.this_cDopeBals      = ""
			THIS.this_nNdFechas      = 0
			THIS.this_nSaldoIni      = 0
			THIS.this_nSaldoAnt      = 0
			THIS.this_nEntradas      = 0
			THIS.this_nTEntradas     = 0
			THIS.this_nSaidas        = 0
			THIS.this_nSaldo         = 0
			THIS.this_nSaldoFunc     = 0
			THIS.this_nPesagem       = 0
			THIS.this_nSaldoT        = 0
			THIS.this_nFalhaFunc     = 0

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
				" PROC=" + loc_oErro.Procedure, "Erro SigPrFemBO.Init")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - OPERACIONAL, sem chave primaria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN ""
	ENDPROC

	*====================================================================
	* CarregarDoCursor - OPERACIONAL, sem CRUD
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		RETURN .T.
	ENDPROC

	*====================================================================
	* ValidarDados - valida filtros do form antes de processar
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		THIS.this_cMensagemErro = ""

		IF EMPTY(THIS.this_dDataFinal)
			THIS.this_cMensagemErro = "A Data Final Deve Ser Informada!!!"
			RETURN .F.
		ENDIF

		IF !EMPTY(THIS.this_dDataInicio) AND THIS.this_dDataInicio > THIS.this_dDataFinal
			THIS.this_cMensagemErro = "A Data Final Deve Ser Maior Que a Data Inicial!!!"
			RETURN .F.
		ENDIF

		IF EMPTY(THIS.this_cDemonstrativo)
			THIS.this_cMensagemErro = "A Configura" + CHR(231) + CHR(227) + "o Deve Ser Informada!!!"
			RETURN .F.
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* PrepararCursoresBase - carrega tabelas de lookup do SQL Server
	* Chamado pelo Form.InicializarForm() uma vez ao abrir o form
	*====================================================================
	PROCEDURE PrepararCursoresBase()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- SigCdPam: material principal e operacao de balanco
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Ouros, DopeBals FROM SigCdPam", ;
				"crSigCdPam") > 0
				SELECT crSigCdPam
				GO TOP
				IF !EOF()
					THIS.this_cCodMat   = NVL(crSigCdPam.Ouros, "")
					THIS.this_cDopeBals = NVL(crSigCdPam.DopeBals, "")
				ENDIF
			ENDIF

			*-- SigCdPac: tempo de fechamento
			IF SQLEXEC(gnConnHandle, ;
				"SELECT ndFechas FROM SigCdPac", ;
				"crSigCdPac") > 0
				SELECT crSigCdPac
				GO TOP
				IF !EOF()
					THIS.this_nNdFechas = NVL(crSigCdPac.ndFechas, 0)
				ENDIF
			ENDIF

			*-- SigCdOpe: operacoes de estoque
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Dopes, Origems, EstOrigs, Destinos, EstDests, Opers FROM SigCdOpe", ;
				"crSigCdOpe") > 0
				SELECT crSigCdOpe
				INDEX ON Dopes TAG Dopes
				SET ORDER TO Dopes
			ENDIF

			*-- SigCdOpd: operacoes de producao
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Dopps, Origems, EstOrigs, Destinos, EstDests FROM SigCdOpd", ;
				"crSigCdOpd") > 0
				SELECT crSigCdOpd
				INDEX ON Dopps TAG Dopps
				SET ORDER TO Dopps
			ENDIF

			*-- SigCdGcr: grupos de controle de recursos
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Codigos, UnifBals, GerBals FROM SigCdGcr", ;
				"crSigCdGcr") > 0
				SELECT crSigCdGcr
				INDEX ON Codigos TAG Codigos
				SET ORDER TO Codigos
			ENDIF

			*-- SigCdGrp: grupos de produtos (LocalGru)
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Cgrus, Mercs, TipoEstos, nAgMts, GruEstPs, ConEstPs FROM SigCdGrp", ;
				"LocalGru") > 0
				SELECT LocalGru
				INDEX ON Cgrus TAG Cgrus
				SET ORDER TO Cgrus
			ENDIF

			*-- SigCdGpr: super-grupos (LocalGgrp)
			IF SQLEXEC(gnConnHandle, ;
				"SELECT Codigos, UnifBals FROM SigCdGpr", ;
				"LocalGgrp") > 0
				SELECT LocalGgrp
				INDEX ON Codigos TAG Codigos
				SET ORDER TO Codigos
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
				" PROC=" + loc_oErro.Procedure, "Erro SigPrFemBO.PrepararCursoresBase")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* PrepararCursoresTrabalho - cria cursores acumuladores
	* Equivalente ao PROCEDURE Load do form original
	* Chamado pelo Form.InicializarForm()
	*====================================================================
	PROCEDURE PrepararCursoresTrabalho()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			SET NULL ON

			IF USED("Entradas")
				USE IN Entradas
			ENDIF
			CREATE CURSOR Entradas (Emps C(3) NULL, TpOps C(15) NULL, Qtde N(12,3) NULL)
			INDEX ON Emps + TpOps TAG TpOps
			SET ORDER TO TpOps

			IF USED("Saidas")
				USE IN Saidas
			ENDIF
			CREATE CURSOR Saidas (Emps C(3) NULL, TpOps C(15) NULL, Qtde N(12,3) NULL)
			INDEX ON Emps + TpOps TAG TpOps
			SET ORDER TO TpOps

			IF USED("Saldos")
				USE IN Saldos
			ENDIF
			CREATE CURSOR Saldos (Grupos C(10) NULL, Contas C(10) NULL, Qtde N(12,3) NULL, Emps C(3) NULL)
			INDEX ON Grupos TAG GruConta
			SET ORDER TO GruConta

			IF USED("SaldoAnt")
				USE IN SaldoAnt
			ENDIF
			CREATE CURSOR SaldoAnt (Grupos C(10) NULL, Contas C(10) NULL, Qtde N(12,3) NULL, Emps C(3) NULL)
			INDEX ON Grupos TAG GruConta
			SET ORDER TO GruConta

			IF USED("Falhas")
				USE IN Falhas
			ENDIF
			CREATE CURSOR Falhas (Grupos C(10) NULL, Contas C(10) NULL, Qtde N(12,3) NULL, ;
				Entra N(12,3) NULL, Saida N(12,3) NULL, Emps C(3) NULL)
			INDEX ON Grupos TAG GruConta
			SET ORDER TO GruConta

			IF USED("TmpResumo")
				USE IN TmpResumo
			ENDIF
			CREATE CURSOR TmpResumo (;
				Flag     L    NULL, ;
				Flag2    L    NULL, ;
				Grupo    C(10) NULL, ;
				Conta    C(10) NULL, ;
				CMats    C(14) NULL, ;
				CUnis    C(3)  NULL, ;
				PesoEnts N(12,3) NULL, ;
				QtdeEnts N(12,3) NULL, ;
				PesoSais N(12,3) NULL, ;
				QtdeSais N(12,3) NULL, ;
				Saldoi   N(12,3) NULL, ;
				Pesagem  N(12,3) NULL, ;
				FReal    N(12,3) NULL, ;
				FAdmin   N(12,3) NULL, ;
				Saldof   N(12,3) NULL, ;
				PesoPEnts N(12,3) NULL, ;
				PesoPSais N(12,3) NULL, ;
				PfTrabs  N(9,2)  NULL, ;
				Flag3    L    NULL, ;
				Varias   N(1)  NULL, ;
				PesoFabre N(12,3) NULL, ;
				PesoFabrs N(12,3) NULL, ;
				cUniPs   C(3)  NULL, ;
				CodCors  C(4)  NULL, ;
				CodTams  C(4)  NULL, ;
				Visivel  L    NULL, ;
				Agregas  N(1)  NULL)
			INDEX ON CMats + CodCors + CodTams TAG Cpros
			INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
			INDEX ON Grupo + Conta TAG GruCon
			INDEX ON Grupo + Conta + CMats TAG GruConMat
			SET ORDER TO GrConMat

			SET NULL OFF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			SET NULL OFF
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
				" PROC=" + loc_oErro.Procedure, "Erro SigPrFemBO.PrepararCursoresTrabalho")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ProcessarAnalise - logica principal do botao Processar
	* Retorna .T. em sucesso; erros ficam em this_cMensagemErro
	*====================================================================
	PROCEDURE ProcessarAnalise()
		LOCAL loc_lResultado, loc_oErro
		LOCAL lcEmp, lcCodMat, lcChave, lcConfig, lcQuery, lcSql
		LOCAL loc_pDatBefore, loc_pDtI, loc_pDtF
		LOCAL lnSaldoIni, lnPesagem, lnSaldoFunc, lnSaldoaFun
		LOCAL lnFalhaFunc, lnTotalEntra, lnTotalSaida, lnLinha, lnLinha2
		LOCAL loc_oBarra, loc_oBarrap
		LOCAL lcAlias, lcTemp, lcEdn, lcChave1, lcChave2, lcTpOp
		LOCAL llEOrigem, llEDestino, llSOrigem, llSDestino, llFalse, llTrue, loc_pNot
		LOCAL _Grupoo, _Contao, _Grupod, _Contad, _Operacao, _Material, Ok, _OriDes
		LOCAL loc_x, loc_QEnt, loc_QSai, loc_QFalha, loc_nRec, loc_nRecTemp
		LOCAL loc_pPescI, loc_pPescF

		loc_lResultado = .F.

		TRY
			*-- Validar filtros
			IF !THIS.ValidarDados()
				MsgAviso(THIS.this_cMensagemErro, "")
				loc_lResultado = .F.
			ENDIF

			*-- Variaveis de trabalho
			lcEmp    = THIS.this_cEmpresa
			lcCodMat = THIS.this_cCodMat
			lcConfig = THIS.this_cDemonstrativo

			*-- Timestamps para queries parametrizadas
			loc_pDatBefore = TTOD(THIS.this_dDataInicio - 1)
			loc_pDtI       = TTOD(THIS.this_dDataInicio)
			loc_pDtF       = DATETIME(YEAR(THIS.this_dDataFinal), MONTH(THIS.this_dDataFinal), ;
				DAY(THIS.this_dDataFinal), 23, 59, 59)
			loc_pPescI     = loc_pDtI
			loc_pPescF     = loc_pDtF

			*-- Zerar cursores acumuladores
			ZAP IN Saldos
			ZAP IN SaldoAnt
			ZAP IN Falhas
			ZAP IN Entradas
			ZAP IN Saidas

			*-- Carregar configuracao do demonstrativo (SigPrDmo)
			lcSql = "SELECT Grupos, Contas FROM SigPrDmo WHERE Nome = " + ;
				EscaparSQL(lcConfig)
			IF SQLEXEC(gnConnHandle, lcSql, "crSigPrDmo") <= 0
				MsgErro("Falha ao carregar configuracao do demonstrativo.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT crSigPrDmo
			GO TOP
			IF EOF()
				MsgAviso("Configura" + CHR(231) + CHR(227) + "o '" + lcConfig + "' n" + ;
					CHR(227) + "o encontrada em SigPrDmo.", "")
				loc_lResultado = .F.
			ENDIF
			lcChave            = lcEmp + crSigPrDmo.Grupos + crSigPrDmo.Contas
			THIS.this_cGrupos  = crSigPrDmo.Grupos
			THIS.this_cContas  = crSigPrDmo.Contas
			USE IN crSigPrDmo

			*-- Saldo Inicial (ultimo historico antes do periodo)
			lnSaldoIni = 0
			lcSql = "SELECT TOP 1 Sqtds FROM SigMvHst " + ;
				"WHERE EmpGruEsts = '" + lcChave + "' AND " + ;
				"CPros = '" + ALLTRIM(lcCodMat) + "' AND " + ;
				"Datas <= ?loc_pDatBefore " + ;
				"ORDER BY cIdChaves DESC"
			IF SQLEXEC(gnConnHandle, lcSql, "crSigMvHst") > 0
				SELECT crSigMvHst
				GO TOP
				IF !EOF()
					lnSaldoIni = NVL(crSigMvHst.Sqtds, 0)
				ENDIF
				USE IN crSigMvHst
			ENDIF

			*-- Config pesagem (SigCdDpr Operas='P')
			lcSql = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
				"WHERE Operas = 'P' AND Nome = " + EscaparSQL(lcConfig)
			IF SQLEXEC(gnConnHandle, lcSql, "TmpPesag") <= 0
				MsgErro("Falha ao carregar TmpPesag.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpPesag
			INDEX ON Grupos + Contas TAG GruConta
			SET ORDER TO GruConta

			*-- Config saldo c/funcionario (SigCdDpr Operas='H')
			lcSql = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
				"WHERE Operas = 'H' AND Nome = " + EscaparSQL(lcConfig)
			IF SQLEXEC(gnConnHandle, lcSql, "TmpSaldo") <= 0
				MsgErro("Falha ao carregar TmpSaldo.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpSaldo
			INDEX ON Grupos + Contas TAG GruConta
			SET ORDER TO GruConta

			*-- Config entradas (SigCdDpr Operas='E')
			lcSql = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
				"WHERE Operas = 'E' AND Nome = " + EscaparSQL(lcConfig)
			IF SQLEXEC(gnConnHandle, lcSql, "TmpEntra") <= 0
				MsgErro("Falha ao carregar TmpEntra.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpEntra
			INDEX ON Grupos + Contas + TpOps TAG GruConTp
			INDEX ON Grupos + Contas TAG GruCon
			SET ORDER TO GruConTp

			*-- Config saidas (SigCdDpr Operas='S')
			lcSql = "SELECT Grupos, Contas, TpOps FROM SigCdDpr " + ;
				"WHERE Operas = 'S' AND Nome = " + EscaparSQL(lcConfig)
			IF SQLEXEC(gnConnHandle, lcSql, "TmpSaida") <= 0
				MsgErro("Falha ao carregar TmpSaida.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpSaida
			INDEX ON Grupos + Contas + TpOps TAG GruConTp
			INDEX ON Grupos + Contas TAG GruCon
			SET ORDER TO GruConTp

			*-- Produtos (TmpPro)
			lcSql = "SELECT CPros, DPros, CUnis, CGrus, Varias, Custofs, MoeCusfs, MatPrincs, cUniPs " + ;
				"FROM SigCdPro"
			IF SQLEXEC(gnConnHandle, lcSql, "TmpPro") <= 0
				MsgErro("Falha ao carregar TmpPro.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpPro
			INDEX ON CPros TAG CPros
			SET ORDER TO CPros

			*==============================================================
			* PROCESSAR MOV. DE PRODUCAO (SigCdNec + SigCdNei)
			*==============================================================
			lcSql = "SELECT a.Datas, a.Emps, a.Dopps, a.Numps, a.GrupoOs, a.ContaOs, " + ;
				"a.GrupoDs, a.ContaDs, a.cIdChaves, b.EmpDnps, b.Servicos, " + ;
				"b.CMats, b.TpOps, b.Qtds, b.Pesos, b.cIdChaves as ChaveB, b.Nops " + ;
				"FROM SigCdNec a, SigCdNei b " + ;
				"WHERE a.Emps = '" + lcEmp + "' AND " + ;
				"a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND " + ;
				"a.EmpDNPs = b.EmpDNPs " + ;
				"ORDER BY b.cIdChaves"
			IF SQLEXEC(gnConnHandle, lcSql, "crProducao") <= 0
				MsgErro("Falha ao carregar crProducao.", "Erro")
				loc_lResultado = .F.
			ENDIF

			*-- SigOpPic (TmpOpi)
			lcSql = "SELECT CPros, Nops FROM SigOpPic"
			IF SQLEXEC(gnConnHandle, lcSql, "TmpOpi") <= 0
				MsgErro("Falha ao carregar TmpOpi.", "Erro")
				loc_lResultado = .F.
			ENDIF
			SELECT TmpOpi
			INDEX ON Nops TAG Nops
			SET ORDER TO Nops

			*-- Subsets distintos de crProducao
			SELECT DISTINCT EmpDnps, Servicos, CMats, Pesos, ChaveB, TpOps, Qtds, Nops ;
				FROM crProducao ;
				WHERE !Servicos ;
				INTO CURSOR crSigCdNei READWRITE
			SELECT crSigCdNei
			INDEX ON EmpDnps TAG EmpDnps
			SET ORDER TO EmpDnps

			SELECT DISTINCT Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
				FROM crProducao ;
				ORDER BY Datas, Emps, Dopps, Numps, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
				INTO CURSOR crSigCdNec

			IF USED("crProducao")
				USE IN crProducao
			ENDIF

			SELECT crSigCdNec
			loc_nRec = RECCOUNT("crSigCdNec")
			loc_oBarra = CREATEOBJECT("fwprogressbar", ;
				"Processando Mov. Produ" + CHR(231) + CHR(227) + "o", loc_nRec)
			loc_oBarra.Show()

			SCAN
				loc_oBarra.Update(.T.)

				=SEEK(crSigCdNec.Dopps, "crSigCdOpd", "Dopps")

				llEOrigem  = .F.
				llEDestino = .F.
				llSOrigem  = .F.
				llSDestino = .F.

				IF crSigCdOpd.Origems = 1
					IF (SEEK(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, "TmpEntra", "GruCon") OR ;
						SEEK(crSigCdNec.GrupoOs + SPACE(10), "TmpEntra", "GruCon")) AND ;
						crSigCdOpd.EstOrigs = 1
						llEOrigem = .T.
					ENDIF
					IF (SEEK(crSigCdNec.GrupoOs + crSigCdNec.ContaOs, "TmpSaida", "GruCon") OR ;
						SEEK(crSigCdNec.GrupoOs + SPACE(10), "TmpSaida", "GruCon")) AND ;
						crSigCdOpd.EstOrigs = 2
						llSOrigem = .T.
					ENDIF
				ENDIF

				IF crSigCdOpd.Destinos = 1
					IF (SEEK(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, "TmpEntra", "GruCon") OR ;
						SEEK(crSigCdNec.GrupoDs + SPACE(10), "TmpEntra", "GruCon")) AND ;
						crSigCdOpd.EstDests = 1
						llEDestino = .T.
					ENDIF
					IF (SEEK(crSigCdNec.GrupoDs + crSigCdNec.ContaDs, "TmpSaida", "GruCon") OR ;
						SEEK(crSigCdNec.GrupoDs + SPACE(10), "TmpSaida", "GruCon")) AND ;
						crSigCdOpd.EstDests = 2
						llSDestino = .T.
					ENDIF
				ENDIF

				IF !llEOrigem AND !llEDestino AND !llSOrigem AND !llSDestino
					LOOP
				ENDIF

				lcEdn = crSigCdNec.Emps + crSigCdNec.Dopps + STR(crSigCdNec.Numps, 10)
				_Material = SPACE(14)

				SELECT crSigCdNei
				=SEEK(lcEdn)
				SCAN WHILE EmpDnps = lcEdn
					lcChave1 = crSigCdNec.GrupoOs + crSigCdNec.ContaOs + crSigCdNei.TpOps
					lcChave2 = crSigCdNec.GrupoOs + SPACE(10) + crSigCdNei.TpOps

					=SEEK(crSigCdNec.GrupoOs, "crSigCdGcr", "Codigos")

					IF crSigCdGcr.UnifBals = 4
						IF crSigCdNei.Nops = 0
							_Material = crSigCdNei.CMats
						ELSE
							=SEEK(crSigCdNei.Nops, "TmpOpi", "Nops")
							=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
							_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
						ENDIF
						IF crSigCdNei.CMats <> _Material
							LOOP
						ENDIF
					ELSE
						IF crSigCdGcr.UnifBals = 3
							=SEEK(crSigCdNei.Nops, "TmpOpi", "Nops")
							IF crSigCdNei.Nops = 0
								_Material = crSigCdNei.CMats
							ELSE
								=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
								_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
							ENDIF
						ELSE
							_Material = IIF(crSigCdGcr.UnifBals = 1, lcCodMat, crSigCdNei.CMats)
						ENDIF
					ENDIF

					Ok = (_Material = lcCodMat)

					IF (llEOrigem OR llSOrigem) AND Ok
						IF llEOrigem
							lcTemp  = "TmpEntra"
							lcAlias = "Entradas"
						ELSE
							lcTemp  = "TmpSaida"
							lcAlias = "Saidas"
						ENDIF

						IF SEEK(lcChave1, lcTemp, "GruConTp") OR SEEK(lcChave2, lcTemp, "GruConTp")
							IF !SEEK(lcEmp + &lcTemp..TpOps, lcAlias)
								INSERT INTO (lcAlias) (TpOps) VALUES (&lcTemp..TpOps)
							ENDIF
							IF crSigCdNei.CMats = lcCodMat AND crSigCdGcr.UnifBals = 1
								REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigCdNei.Qtds
							ELSE
								REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigCdNei.Pesos
							ENDIF
							REPLACE &lcAlias..Emps WITH lcEmp
						ENDIF
					ENDIF

					lcChave1 = crSigCdNec.GrupoDs + crSigCdNec.ContaDs + crSigCdNei.TpOps
					lcChave2 = crSigCdNec.GrupoDs + SPACE(10) + crSigCdNei.TpOps

					=SEEK(crSigCdNec.GrupoDs, "crSigCdGcr", "Codigos")

					IF crSigCdGcr.UnifBals = 4
						IF crSigCdNei.Nops = 0
							_Material = crSigCdNei.CMats
						ELSE
							=SEEK(crSigCdNei.Nops, "TmpOpi", "Nops")
							=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
							_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
						ENDIF
						IF crSigCdNei.CMats <> _Material
							LOOP
						ENDIF
					ELSE
						IF crSigCdGcr.UnifBals = 3
							=SEEK(crSigCdNei.Nops, "TmpOpi", "Nops")
							IF crSigCdNei.Nops = 0
								_Material = crSigCdNei.CMats
							ELSE
								=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
								_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
							ENDIF
						ELSE
							_Material = IIF(crSigCdGcr.UnifBals = 1, lcCodMat, crSigCdNei.CMats)
						ENDIF
					ENDIF

					Ok = (_Material = lcCodMat)

					IF (llEDestino OR llSDestino) AND Ok
						IF llEDestino
							lcTemp  = "TmpEntra"
							lcAlias = "Entradas"
						ELSE
							lcTemp  = "TmpSaida"
							lcAlias = "Saidas"
						ENDIF

						IF SEEK(lcChave1, lcTemp, "GruConTp") OR SEEK(lcChave2, lcTemp, "GruConTp")
							IF !SEEK(lcEmp + &lcTemp..TpOps, lcAlias)
								INSERT INTO (lcAlias) (TpOps) VALUES (&lcTemp..TpOps)
							ENDIF
							IF crSigCdNei.CMats = lcCodMat AND crSigCdGcr.UnifBals = 1
								REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigCdNei.Qtds
							ELSE
								REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigCdNei.Pesos
							ENDIF
							REPLACE &lcAlias..Emps WITH lcEmp
						ENDIF
					ENDIF
				ENDSCAN
			ENDSCAN
			loc_oBarra.Complete()

			IF USED("crSigCdNei")
				USE IN crSigCdNei
			ENDIF
			IF USED("crSigCdNec")
				USE IN crSigCdNec
			ENDIF

			*==============================================================
			* PROCESSAR MOV. DE ESTOQUE (SigMvCab + SigMvItn)
			*==============================================================
			lcSql = "SELECT a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoOs, a.ContaOs, " + ;
				"a.GrupoDs, a.ContaDs, a.cIdChaves, b.EmpDopNums, b.CPros, b.Opers, b.Qtds, " + ;
				"b.cIdChaves as ChaveB " + ;
				"FROM SigMvCab a, SigMvItn b " + ;
				"WHERE a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND " + ;
				"(a.Emps = '" + lcEmp + "' OR a.EmpDs = '" + lcEmp + "') AND " + ;
				"NOT a.Dopes = '" + ALLTRIM(THIS.this_cDopeBals) + "' AND " + ;
				"a.EmpDopNums = b.EmpDopNums " + ;
				"ORDER BY a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, a.GrupoOs, " + ;
				"a.ContaOs, a.GrupoDs, a.ContaDs, a.cIdChaves, " + ;
				"b.EmpDopNums, b.CPros, b.Opers, b.Qtds, b.cIdChaves"
			IF SQLEXEC(gnConnHandle, lcSql, "crEstoque") <= 0
				MsgErro("Falha ao carregar crEstoque.", "Erro")
				loc_lResultado = .F.
			ENDIF

			SELECT DISTINCT EmpDopNums, CPros, Opers, Qtds, ChaveB ;
				FROM crEstoque ;
				ORDER BY EmpDopNums, CPros, Opers, Qtds, ChaveB ;
				INTO CURSOR crSigMvItn READWRITE
			SELECT crSigMvItn
			INDEX ON EmpDopNums TAG EmpDopNums
			SET ORDER TO EmpDopNums

			SELECT DISTINCT Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
				FROM crEstoque ;
				ORDER BY Datas, Emps, EmpDs, Dopes, Numes, GrupoOs, ContaOs, GrupoDs, ContaDs, cIdChaves ;
				INTO CURSOR crSigMvCab

			IF USED("crEstoque")
				USE IN crEstoque
			ENDIF

			SELECT crSigMvCab
			loc_nRec = RECCOUNT("crSigMvCab")
			loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque...", loc_nRec)
			loc_oBarra.Show()

			SCAN
				loc_oBarra.Update(.T.)

				=SEEK(crSigMvCab.Dopes, "crSigCdOpe", "Dopes")
				_OriDes = .F.

				IF crSigMvCab.EmpDs = lcEmp
					IF SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra", "GruCon")
						_OriDes = .T.
					ENDIF
				ELSE
					IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida", "GruCon")) OR ;
						(SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra", "GruCon") OR ;
						SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida", "GruCon"))
						_OriDes = .T.
					ENDIF
				ENDIF

				IF !_OriDes
					LOOP
				ENDIF

				lcEdn = crSigMvCab.Emps + crSigMvCab.Dopes + STR(crSigMvCab.Numes, 6)

				SELECT crSigMvItn
				SEEK lcEdn
				SCAN WHILE EmpDopNums = lcEdn
					_Grupoo   = SPACE(10)
					_Contao   = SPACE(10)
					_Grupod   = SPACE(10)
					_Contad   = SPACE(10)
					llSOrigem  = .F.
					llEDestino = .F.

					IF crSigCdOpe.EstOrigs = 4
						IF crSigMvItn.Opers = 'S' AND ;
							(SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida", "GruCon") OR ;
							SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida", "GruCon"))
							llSOrigem = .T.
							_Grupoo   = crSigMvCab.GrupoOs
							_Contao   = crSigMvCab.ContaOs
						ELSE
							IF crSigMvItn.Opers = 'E' AND ;
								(SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra", "GruCon") OR ;
								SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra", "GruCon"))
								llEDestino = .T.
								_Grupod    = crSigMvCab.GrupoDs
								_Contad    = crSigMvCab.ContaDs
							ENDIF
						ENDIF
					ELSE
						IF crSigCdOpe.Opers = 3
							IF crSigCdOpe.Origems = 1
								IF crSigMvItn.Opers = 'S' AND ;
									(SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida", "GruCon") OR ;
									SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida", "GruCon"))
									llSOrigem = .T.
									_Grupoo   = crSigMvCab.GrupoOs
									_Contao   = crSigMvCab.ContaOs
								ELSE
									IF crSigMvItn.Opers = 'E' AND ;
										(SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra", "GruCon") OR ;
										SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra", "GruCon"))
										llEDestino = .T.
										_Grupod    = crSigMvCab.GrupoOs
										_Contad    = crSigMvCab.ContaOs
									ENDIF
								ENDIF
							ELSE
								IF crSigCdOpe.Destinos = 1
									IF crSigMvItn.Opers = 'S' AND ;
										(SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida", "GruCon") OR ;
										SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida", "GruCon"))
										llSOrigem = .T.
										_Grupoo   = crSigMvCab.GrupoDs
										_Contao   = crSigMvCab.ContaDs
									ELSE
										IF crSigMvItn.Opers = 'E' AND ;
											(SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra", "GruCon") OR ;
											SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra", "GruCon"))
											llEDestino = .T.
											_Grupod    = crSigMvCab.GrupoDs
											_Contad    = crSigMvCab.ContaDs
										ENDIF
									ENDIF
								ENDIF
							ENDIF
						ELSE
							IF crSigCdOpe.Origems = 1
								IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpSaida", "GruCon") OR ;
									SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpSaida", "GruCon")) AND ;
									crSigCdOpe.EstOrigs = 2
									llSOrigem = .T.
									_Grupoo   = crSigMvCab.GrupoOs
									_Contao   = crSigMvCab.ContaOs
								ELSE
									IF (SEEK(crSigMvCab.GrupoOs + crSigMvCab.ContaOs, "TmpEntra", "GruCon") OR ;
										SEEK(crSigMvCab.GrupoOs + SPACE(10), "TmpEntra", "GruCon")) AND ;
										crSigCdOpe.EstOrigs = 1
										llEDestino = .T.
										_Grupod    = crSigMvCab.GrupoOs
										_Contad    = crSigMvCab.ContaOs
									ENDIF
								ENDIF
							ENDIF

							IF crSigCdOpe.Destinos = 1
								IF (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpSaida", "GruCon") OR ;
									SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpSaida", "GruCon")) AND ;
									crSigCdOpe.EstDests = 2
									llSOrigem = .T.
									_Grupoo   = crSigMvCab.GrupoDs
									_Contao   = crSigMvCab.ContaDs
								ELSE
									IF (SEEK(crSigMvCab.GrupoDs + crSigMvCab.ContaDs, "TmpEntra", "GruCon") OR ;
										SEEK(crSigMvCab.GrupoDs + SPACE(10), "TmpEntra", "GruCon")) AND ;
										crSigCdOpe.EstDests = 1
										llEDestino = .T.
										_Grupod    = crSigMvCab.GrupoDs
										_Contad    = crSigMvCab.ContaDs
									ENDIF
								ENDIF
							ENDIF
						ENDIF
					ENDIF

					lcChave1 = _Grupoo + _Contao + SPACE(15)
					lcChave2 = _Grupoo + SPACE(10) + SPACE(15)
					lcTpOp   = PADR(LEFT(crSigMvCab.Dopes, 10), 15)

					=SEEK(_Grupoo, "crSigCdGcr", "Codigos")
					=SEEK(crSigMvItn.CPros, "TmpPro", "CPros")

					IF INLIST(crSigCdGcr.UnifBals, 3, 4)
						_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
					ELSE
						=SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
						_Material = IIF(crSigCdGcr.UnifBals = 1 AND LocalGru.nAgMts <> 1, ;
							lcCodMat, crSigMvItn.CPros)
					ENDIF

					IF crSigCdGcr.UnifBals = 4 AND crSigMvItn.CPros <> _Material
						_Material = crSigMvItn.CPros
					ENDIF

					Ok = (_Material = lcCodMat)

					IF llSOrigem AND Ok
						lcTemp  = "TmpSaida"
						lcAlias = "Saidas"
						lcEmp   = IIF(EMPTY(crSigMvCab.EmpDs), crSigMvCab.Emps, crSigMvCab.EmpDs)

						IF SEEK(lcChave1, lcTemp, "GruConTp") OR SEEK(lcChave2, lcTemp, "GruConTp")
							IF !SEEK(lcEmp + lcTpOp, lcAlias)
								SELECT (lcAlias)
								APPEND BLANK
								REPLACE TpOps WITH lcTpOp, Emps WITH lcEmp
							ENDIF
							REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigMvItn.Qtds
						ENDIF
					ENDIF

					lcChave1 = _Grupod + _Contad + SPACE(15)
					lcChave2 = _Grupod + SPACE(10) + SPACE(15)

					=SEEK(_Grupod, "crSigCdGcr", "Codigos")
					=SEEK(crSigMvItn.CPros, "TmpPro", "CPros")

					IF INLIST(crSigCdGcr.UnifBals, 3, 4)
						_Material = IIF(EMPTY(TmpPro.MatPrincs), lcCodMat, TmpPro.MatPrincs)
					ELSE
						=SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
						_Material = IIF(crSigCdGcr.UnifBals = 1 AND LocalGru.nAgMts <> 1, ;
							lcCodMat, crSigMvItn.CPros)
					ENDIF

					IF crSigCdGcr.UnifBals = 4 AND crSigMvItn.CPros <> _Material
						_Material = crSigMvItn.CPros
					ENDIF

					Ok = (_Material = lcCodMat)

					IF llEDestino AND Ok
						lcTemp  = "TmpEntra"
						lcAlias = "Entradas"
						lcEmp   = crSigMvCab.Emps

						IF SEEK(lcChave1, lcTemp, "GruConTp") OR SEEK(lcChave2, lcTemp, "GruConTp")
							IF !SEEK(lcEmp + lcTpOp, lcAlias)
								SELECT (lcAlias)
								APPEND BLANK
								REPLACE TpOps WITH lcTpOp, Emps WITH lcEmp
							ENDIF
							REPLACE &lcAlias..Qtde WITH &lcAlias..Qtde + crSigMvItn.Qtds
						ENDIF
					ENDIF
				ENDSCAN
			ENDSCAN
			loc_oBarra.Complete()

			*-- Restaurar lcEmp (pode ter sido alterado no loop de estoque)
			lcEmp = THIS.this_cEmpresa

			IF USED("crSigMvItn")
				USE IN crSigMvItn
			ENDIF
			IF USED("crSigMvCab")
				USE IN crSigMvCab
			ENDIF

			*==============================================================
			* PROCESSAR PESAGEM
			*==============================================================
			lnPesagem = 0

			SELECT TmpPesag
			loc_nRec = RECCOUNT("TmpPesag")
			loc_oBarra = CREATEOBJECT("fwprogressbar", "Processando Pesagens", loc_nRec)
			loc_oBarra.Show()

			SCAN
				loc_oBarra.Update(.T.)

				lcSql = "SELECT Datas, Codigos FROM SigCdPsc " + ;
					"WHERE Emps = '" + lcEmp + "' AND " + ;
					"Grupos = '" + ALLTRIM(TmpPesag.Grupos) + "' AND " + ;
					"Contas = '" + ALLTRIM(TmpPesag.Contas) + "' AND " + ;
					"Datas >= ?loc_pPescI AND Datas <= ?loc_pPescF " + ;
					"ORDER BY Datas DESC, Codigos DESC"
				IF SQLEXEC(gnConnHandle, lcSql, "crSigCdPsc") <= 0
					MsgErro("Falha ao carregar crSigCdPsc.", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT crSigCdPsc
				GO TOP

				lcSql = "SELECT CPros, Qtds FROM SigCdPsi " + ;
					"WHERE Emps = '" + lcEmp + "' AND " + ;
					"Codigos = " + FormatarNumeroSQL(crSigCdPsc.Codigos, 0) + " AND " + ;
					"CPros = '" + ALLTRIM(lcCodMat) + "' " + ;
					"ORDER BY CPros, Qtds"
				IF SQLEXEC(gnConnHandle, lcSql, "crSigCdPsi") <= 0
					MsgErro("Falha ao carregar crSigCdPsi.", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT crSigCdPsi
				SCAN
					lnPesagem = lnPesagem + NVL(crSigCdPsi.Qtds, 0)
				ENDSCAN

				IF USED("crSigCdPsc")
					USE IN crSigCdPsc
				ENDIF
				IF USED("crSigCdPsi")
					USE IN crSigCdPsi
				ENDIF
			ENDSCAN
			loc_oBarra.Complete()

			*==============================================================
			* PROCESSAR SALDO COM FUNCIONARIOS ? PosBalanco()
			*==============================================================
			lnSaldoFunc = 0
			lnSaldoaFun = 0

			SELECT TmpSaldo
			loc_nRec = RECCOUNT("TmpSaldo")
			loc_oBarra = CREATEOBJECT("fwprogressbar", ;
				"Processando Saldo c/funcion" + CHR(225) + "rio", loc_nRec)
			loc_oBarra.Show()

			SCAN
				loc_oBarra.Update(.T.)

				IF EMPTY(TmpSaldo.Contas)
					lcSql = "SELECT Emps, Grupos, Estos, CPros FROM SigMvEst " + ;
						"WHERE Emps = '" + lcEmp + "' AND " + ;
						"Grupos = '" + ALLTRIM(TmpSaldo.Grupos) + "' AND " + ;
						"CPros = '" + ALLTRIM(lcCodMat) + "'"
				ELSE
					lcSql = "SELECT Emps, Grupos, Estos, CPros FROM SigMvEst " + ;
						"WHERE EmpGruEsts = '" + lcEmp + ALLTRIM(TmpSaldo.Grupos) + ALLTRIM(TmpSaldo.Contas) + "' AND " + ;
						"CPros = '" + ALLTRIM(lcCodMat) + "'"
				ENDIF

				IF SQLEXEC(gnConnHandle, lcSql, "crSigMvEst") <= 0
					MsgErro("Falha ao carregar crSigMvEst.", "Erro")
					loc_lResultado = .F.
				ENDIF

				SELECT crSigMvEst
				SCAN
					=SEEK(crSigMvEst.Grupos, "crSigCdGcr", "Codigos")
					Ok = (crSigMvEst.CPros = lcCodMat OR crSigCdGcr.UnifBals = 1)
					IF !Ok
						LOOP
					ENDIF

					THIS.PosBalanco()
				ENDSCAN

				IF USED("crSigMvEst")
					USE IN crSigMvEst
				ENDIF
			ENDSCAN
			loc_oBarra.Complete()

			SELECT [  ] AS Agrupar, SUM(Qtde) AS Qtde FROM Saldos INTO CURSOR CsSelecao GROUP BY 1
			lnSaldoFunc = NVL(CsSelecao.Qtde, 0)
			USE IN CsSelecao

			SELECT [  ] AS Agrupar, SUM(Qtde) AS Qtde FROM SaldoAnt INTO CURSOR CsSelecao GROUP BY 1
			lnSaldoaFun = NVL(CsSelecao.Qtde, 0)
			USE IN CsSelecao

			*==============================================================
			* PROCESSAR FALHAS
			*==============================================================
			lnFalhaFunc = 0

			SELECT TmpSaldo
			loc_nRec = RECCOUNT("TmpSaldo")
			loc_oBarra = CREATEOBJECT("fwprogressbar", ;
				"Processando Falha dos Funcion" + CHR(225) + "rios", loc_nRec)
			loc_oBarra.Show()

			SCAN
				loc_oBarra.Update(.T.)

				IF TmpSaldo.Contas = SPACE(10)
					lcSql = "SELECT b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems " + ;
						"FROM SigCdFcx a, SigOpCfe b " + ;
						"WHERE a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND " + ;
						"a.Emps = '" + lcEmp + "' AND " + ;
						"a.Grupos = '" + ALLTRIM(TmpSaldo.Grupos) + "' AND " + ;
						"a.Emps = b.Emps AND a.Codigos = b.Codigos AND " + ;
						"b.CPros = '" + ALLTRIM(lcCodMat) + "' " + ;
						"ORDER BY b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems"
				ELSE
					lcSql = "SELECT b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems " + ;
						"FROM SigCdFcx a, SigOpCfe b " + ;
						"WHERE a.Datas BETWEEN ?loc_pDtI AND ?loc_pDtF AND " + ;
						"a.Emps = '" + lcEmp + "' AND " + ;
						"a.Grupos = '" + ALLTRIM(TmpSaldo.Grupos) + "' AND " + ;
						"a.Contas = '" + ALLTRIM(TmpSaldo.Contas) + "' AND " + ;
						"a.Emps = b.Emps AND a.Codigos = b.Codigos AND " + ;
						"b.CPros = '" + ALLTRIM(lcCodMat) + "' " + ;
						"ORDER BY b.cIdChaves, b.FReals, b.Entradas, b.Saldos, b.Saidas, b.Pesagems"
				ENDIF

				IF SQLEXEC(gnConnHandle, lcSql, "crSigCdFcx") <= 0
					MsgErro("Falha ao carregar crSigCdFcx.", "Erro")
					loc_lResultado = .F.
				ENDIF

				SELECT crSigCdFcx
				SCAN
					lnFalhaFunc = lnFalhaFunc + NVL(crSigCdFcx.FReals, 0)
					IF !SEEK(TmpSaldo.Grupos, "Falhas", "GruConta")
						INSERT INTO Falhas (Grupos, Contas, Emps) ;
							VALUES (TmpSaldo.Grupos, TmpSaldo.Contas, lcEmp)
					ENDIF
					REPLACE Qtde  WITH Falhas.Qtde  + NVL(crSigCdFcx.FReals, 0), ;
							Entra WITH Falhas.Entra + NVL(crSigCdFcx.Entradas, 0) + NVL(crSigCdFcx.Saldos, 0), ;
							Saida WITH Falhas.Saida + NVL(crSigCdFcx.Saidas, 0) + NVL(crSigCdFcx.Pesagems, 0) IN Falhas
				ENDSCAN

				IF USED("crSigCdFcx")
					USE IN crSigCdFcx
				ENDIF
			ENDSCAN
			loc_oBarra.Complete()

			*==============================================================
			* TOTAIS FINAIS
			*==============================================================
			SELECT Entradas
			SUM Qtde TO lnTotalEntra

			SELECT Saidas
			SUM Qtde TO lnTotalSaida

			*-- Armazenar em propriedades do BO
			THIS.this_nSaldoIni  = lnSaldoIni
			THIS.this_nSaldoAnt  = lnSaldoaFun
			THIS.this_nEntradas  = lnTotalEntra
			THIS.this_nTEntradas = lnSaldoIni + lnTotalEntra + lnSaldoaFun
			THIS.this_nSaidas    = lnTotalSaida
			THIS.this_nPesagem   = lnPesagem
			THIS.this_nSaldo     = lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun
			THIS.this_nSaldoFunc = lnSaldoFunc
			THIS.this_nFalhaFunc = lnFalhaFunc
			THIS.this_nSaldoT    = lnPesagem + lnSaldoFunc

			*==============================================================
			* CRIAR CURSORES PARA RELATORIO (TmpImp)
			*==============================================================
			IF USED("TmpImprime2")
				USE IN TmpImprime2
			ENDIF
			CREATE CURSOR TmpImprime2 (;
				Linha2  N(3)   NULL, ;
				Cabec2  L      NULL, ;
				Titulo2 C(40)  NULL, ;
				Valor2  N(12,3) NULL, ;
				Traco2  L      NULL, ;
				Emps    C(3)   NULL)

			IF USED("TmpImprime")
				USE IN TmpImprime
			ENDIF
			CREATE CURSOR TmpImprime (;
				Linha   N(3)   NULL, ;
				Cabec   L      NULL, ;
				Titulo  C(80)  NULL, ;
				Valor   N(12,3) NULL, ;
				Valor1  N(11,3) NULL, ;
				Traco   L      NULL, ;
				Entrada N(12,3) NULL, ;
				Saida   N(12,3) NULL, ;
				Falha   L      NULL)

			lnLinha = 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Saldo Inicial : ", lnSaldoIni)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Saldo Ant c/Funcion" + CHR(225) + "rio : ", lnSaldoaFun)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Entradas : ", lnTotalEntra)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Total de Entradas : ", lnSaldoIni + lnTotalEntra + lnSaldoaFun)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Sa" + CHR(237) + "das : ", lnTotalSaida)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Saldo : ", lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Saldo com Funcion" + CHR(225) + "rios : ", lnSaldoFunc)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Pesagem : ", lnPesagem)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor) ;
				VALUES (lnLinha, .F., "Total : ", lnPesagem + lnSaldoFunc)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
				VALUES (lnLinha, .F., "Falha dos Funcion" + CHR(225) + "rios : ", lnFalhaFunc, .T.)
			lnLinha = lnLinha + 1
			INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Traco) ;
				VALUES (lnLinha, .F., "Diferen" + CHR(231) + "a : ", ;
				lnSaldoIni + lnTotalEntra - lnTotalSaida + lnSaldoaFun - ;
				lnPesagem - lnSaldoFunc - lnFalhaFunc, .T.)

			*-- Detalhe de Entradas
			lnLinha2 = 0
			SELECT Entradas
			GO TOP
			IF !EOF()
				lnLinha2 = lnLinha2 + 1
				INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
					VALUES (lnLinha2, .T., "Resumo de Entradas")

				SELECT Entradas
				SCAN
					lnLinha2 = lnLinha2 + 1
					INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
						VALUES (lnLinha2, .F., Entradas.TpOps, Entradas.Qtde, Entradas.Emps)
				ENDSCAN
				SELECT TmpImprime2
				REPLACE Traco2 WITH .T. IN TmpImprime2
			ENDIF

			lnLinha2 = lnLinha2 + 1
			INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
				VALUES (lnLinha2, .F., " ", lnTotalEntra)

			*-- Detalhe de Saidas
			SELECT Saidas
			GO TOP
			IF !EOF()
				lnLinha2 = lnLinha2 + 1
				INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
					VALUES (lnLinha2, .T., "Resumo de Sa" + CHR(237) + "das")

				SELECT Saidas
				SCAN
					lnLinha2 = lnLinha2 + 1
					INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
						VALUES (lnLinha2, .F., ;
						IIF(EMPTY(Saidas.TpOps), "PRODUZIDO", Saidas.TpOps), ;
						Saidas.Qtde, Saidas.Emps)
				ENDSCAN
				SELECT TmpImprime2
				REPLACE Traco2 WITH .T. IN TmpImprime2
			ENDIF

			lnLinha2 = lnLinha2 + 1
			INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
				VALUES (lnLinha2, .F., " ", lnTotalSaida)

			*-- Detalhe de Saldos das Fases
			SELECT Saldos
			GO TOP
			IF !EOF()
				lnLinha2 = lnLinha2 + 1
				INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
					VALUES (lnLinha2, .T., " ")
				lnLinha2 = lnLinha2 + 1
				INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
					VALUES (lnLinha2, .T., "Saldos das Fases")

				SELECT Saldos
				SCAN
					lnLinha2 = lnLinha2 + 1
					INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
						VALUES (lnLinha2, .F., Saldos.Grupos, Saldos.Qtde)
				ENDSCAN
				SELECT TmpImprime2
				REPLACE Traco2 WITH .T. IN TmpImprime2
			ENDIF

			lnLinha2 = lnLinha2 + 1
			INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
				VALUES (lnLinha2, .F., " ", lnSaldoFunc)

			*-- Detalhe de Falhas das Fases
			SELECT Falhas
			GO TOP
			IF !EOF()
				lnLinha = lnLinha + 1
				INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
					VALUES (lnLinha, .T., PADC("Falhas das Fases", 70))
				lnLinha = lnLinha + 1
				INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
					VALUES (lnLinha, .T., "Setor           Entrada      Saida      Falha Gr         %")

				SELECT Falhas
				SCAN
					lnLinha = lnLinha + 1
					loc_x = IIF(NVL(Falhas.Saida, 0) <> 0, (Falhas.Qtde / Falhas.Saida * 100), 0)
					INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
						VALUES (lnLinha, .F., Falhas.Grupos, Falhas.Qtde, loc_x, ;
						Falhas.Entra, Falhas.Saida, .T.)
				ENDSCAN

				SELECT Falhas
				SUM Entra, Saida, Qtde TO loc_QEnt, loc_QSai, loc_QFalha
				loc_x = IIF(loc_QSai <> 0, (loc_QFalha / loc_QSai * 100), 0)

				SELECT TmpImprime
				REPLACE Traco WITH .T. IN TmpImprime
				lnLinha = lnLinha + 1
				INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, Entrada, Saida, Falha) ;
					VALUES (lnLinha, .F., " ", loc_QFalha, loc_x, loc_QEnt, loc_QSai, .T.)
			ENDIF

			*-- JOIN final para relatorio
			LOCAL loc_cOrder
			IF lnLinha2 > lnLinha
				loc_cOrder = "t2.Linha2"
			ELSE
				loc_cOrder = "t1.Linha"
			ENDIF

			IF USED("TmpImp")
				USE IN TmpImp
			ENDIF
			SELECT T1.*, T2.* ;
				FROM TmpImprime T1 ;
				FULL JOIN TmpImprime2 T2 ;
				ON T1.Linha = T2.Linha2 ;
				INTO CURSOR TmpImp ;
				ORDER BY &loc_cOrder.

			*-- Cabecalho para o relatorio
			lcSql = "SELECT Razas FROM SigCdEmp WHERE Cemps = '" + lcEmp + "'"
			IF SQLEXEC(gnConnHandle, lcSql, "crSigCdEmp") > 0
				SELECT crSigCdEmp
				GO TOP
			ENDIF

			IF USED("Cabecalho")
				USE IN Cabecalho
			ENDIF
			CREATE CURSOR Cabecalho (pNomeEmpresa C(60), pRelTitulo C(60), pPeriodo C(60))
			INSERT INTO Cabecalho (pNomeEmpresa, pRelTitulo, pPeriodo) ;
				VALUES (IIF(USED("crSigCdEmp") AND !EOF("crSigCdEmp"), ;
					NVL(crSigCdEmp.Razas, ""), ""), ;
				"An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o", ;
				"Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDataInicio) + ;
				" at" + CHR(233) + " " + DTOC(THIS.this_dDataFinal))

			IF USED("crSigCdEmp")
				USE IN crSigCdEmp
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
				" PROC=" + loc_oErro.Procedure, "Erro SigPrFemBO.ProcessarAnalise")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* PosBalanco - calcula balanco por funcionario/conta
	* Equivalente ao PROCEDURE posbalanco do form original
	* Chamado internamente por ProcessarAnalise()
	* Contexto: crSigMvEst posicionado no registro corrente (SCAN)
	*====================================================================
	PROTECTED PROCEDURE PosBalanco()
		LOCAL loc_lResultado, loc_oErro
		LOCAL loc_pDat, loc_pNot, loc_llFalse, loc_llTrue
		LOCAL loc_lcEdn, loc_lcQuery, loc_lcSql
		LOCAL loc_nCt, loc_oBarra
		LOCAL loc_ldDataB, loc_ldDataL
		LOCAL loc_lcCodCor, loc_lcCodTam
		LOCAL loc_Origem, loc_Destino, loc_Material, loc_MatResFa
		LOCAL loc_FalhaAdmitida, loc_Trabalhado
		LOCAL loc_lcGrupo, loc_lcConta
		LOCAL loc_lcMat, loc_Saldoi, loc_nQtde, loc_nPeso

		loc_lResultado = .F.

		TRY
			*-- Inicializar variaveis de contexto
			loc_ldDatai  = THIS.this_dDataInicio
			loc_ldDataf  = THIS.this_dDataFinal
			loc_lcEmp    = THIS.this_cEmpresa
			loc_lcCodMat = THIS.this_cCodMat
			loc_Trabalhado = 0

			*-- Verificar gerador de balanco do cliente
			loc_lcSql = "SELECT Rclis, GerBals, PagFals, RecFals FROM SigCdCli " + ;
				"WHERE Iclis = '" + ALLTRIM(crSigMvEst.Estos) + "'"
			IF SQLEXEC(gnConnHandle, loc_lcSql, "CrSigCdCli") <= 0
				MsgErro("Falha na conex" + CHR(227) + "o (crSigCdCli).", "Erro")
				loc_lResultado = .F.
			ENDIF

			=SEEK(crSigMvEst.Grupos, "CrSigCdGcr", "Codigos")

			IF CrSigCdCli.GerBals <> 1 OR crSigCdGcr.GerBals <> 1
				USE IN CrSigCdCli
				loc_lResultado = .T.
			ENDIF

			*-- Datas de fechamento
			loc_lcQuery = "SELECT Datas, Codigos FROM SigCdFcx " + ;
				"WHERE Emps = '" + loc_lcEmp + "' AND " + ;
				"Grupos = '" + ALLTRIM(crSigMvEst.Grupos) + "' AND " + ;
				"Contas = '" + ALLTRIM(crSigMvEst.Estos) + "'"
			IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalFecha") <= 0
				MsgErro("Falha na conex" + CHR(227) + "o (LocalFecha).", "Erro")
				loc_lResultado = .F.
			ENDIF

			*-- Guardar Grupo e Conta correntes
			loc_lcGrupo = crSigMvEst.Grupos
			loc_lcConta = crSigMvEst.Estos

			FOR loc_nCt = 1 TO 2
				SELECT TmpResumo
				SET ORDER TO 0
				ZAP
				SET ORDER TO GrConMat

				loc_ldDataB = IIF(loc_nCt = 1, loc_ldDatai - 1, loc_ldDataf)
				loc_ldDataL = IIF(loc_nCt = 1, loc_ldDatai - 1, loc_ldDataf)

				*-- Encontrar data de fechamento mais recente
				SELECT LocalFecha
				INDEX ON DTOS(Datas) TAG Datas
				SET ORDER TO Datas DESCENDING
				SET NEAR ON
				=SEEK(DTOS(loc_ldDataB))
				SET NEAR OFF

				IF LocalFecha.Datas > loc_ldDataB
					loc_pDat = CTOT("01/01/1900")
					LOCATE FOR .F.
				ELSE
					loc_pDat = TTOD(LocalFecha.Datas) + THIS.this_nNdFechas
				ENDIF
				loc_pNot    = .F.
				loc_llFalse = .F.
				loc_llTrue  = .T.
				loc_FalhaAdmitida = 0

				*-- Movimentos de producao (SigCdNec + SigCdNei)
				loc_lcQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, " + ;
					"Emps, Numps, Obss, cIdChaves, EmpDnPs " + ;
					"FROM SigCdNec " + ;
					"WHERE Emps = '" + loc_lcEmp + "' AND " + ;
					"Datas >= ?loc_pDat AND " + ;
					"((GrupoDs = '" + ALLTRIM(loc_lcGrupo) + "' AND " + ;
					"ContaDs = '" + ALLTRIM(loc_lcConta) + "') OR " + ;
					"(GrupoOs = '" + ALLTRIM(loc_lcGrupo) + "' AND " + ;
					"ContaOs = '" + ALLTRIM(loc_lcConta) + "')) " + ;
					"ORDER BY Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, cIdChaves"
				IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalNens") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (LocalNens).", "Erro")
					loc_lResultado = .F.
				ENDIF

				loc_lcQuery = "SELECT b.EmpDnPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, " + ;
					"b.TpOps, b.cIdChaves, b.Nops, b.Peso2s, b.CodCors, b.CodTams " + ;
					"FROM SigCdNec a, SigCdNei b " + ;
					"WHERE a.Emps = '" + loc_lcEmp + "' AND " + ;
					"a.Datas >= ?loc_pDat AND " + ;
					"(a.GrupoDs = '" + ALLTRIM(loc_lcGrupo) + "' OR " + ;
					"a.GrupoOs = '" + ALLTRIM(loc_lcGrupo) + "') AND " + ;
					"(a.ContaDs = '" + ALLTRIM(loc_lcConta) + "' OR " + ;
					"a.ContaOs = '" + ALLTRIM(loc_lcConta) + "') AND " + ;
					"a.EmpDNPs = b.EmpDNPs AND b.Servicos = ?loc_pNot " + ;
					"ORDER BY b.EmpDNPs, b.CMats, b.CUnis, b.Nenvs, b.Pesos, b.Qtds, " + ;
					"b.TpOps, b.cIdChaves, b.Nops"
				IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalNensI") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (LocalNensI).", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT LocalNensI
				INDEX ON EmpDNPs TAG EmpDNPs
				SET ORDER TO EmpDNPs

				SELECT LocalNens
				loc_oBarra = CREATEOBJECT("fwprogressbar", ;
					"Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
					RECCOUNT("LocalNens"))
				loc_oBarra.Show()

				SCAN
					loc_oBarra.Update(.T.)

					IF DTOS(Datas) > DTOS(loc_ldDataL)
						LOOP
					ENDIF

					loc_lcEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)

					=SEEK(LocalNens.Dopps, "crSigCdOpd", "Dopps")

					loc_Origem   = .F.
					loc_Destino  = .F.
					loc_Material = SPACE(14)

					IF crSigCdOpd.Origems = 1 AND LocalNens.GrupoOs = loc_lcGrupo AND ;
						LocalNens.ContaOs = loc_lcConta AND INLIST(crSigCdOpd.EstOrigs, 1, 2)
						loc_Origem = .T.
					ENDIF

					IF crSigCdOpd.Destinos = 1 AND LocalNens.GrupoDs = loc_lcGrupo AND ;
						LocalNens.ContaDs = loc_lcConta AND INLIST(crSigCdOpd.EstDests, 1, 2)
						loc_Destino = .T.
					ENDIF

					IF !loc_Origem AND !loc_Destino
						LOOP
					ENDIF

					SELECT LocalNensI
					SEEK loc_lcEdn
					SCAN WHILE EmpDNPs = loc_lcEdn
						IF crSigCdGcr.UnifBals = 4
							IF LocalNensI.Nops = 0
								loc_Material = LocalNensI.CMats
							ELSE
								=SEEK(LocalNensI.Nops, "TmpOpi", "Nops")
								=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
								loc_Material = IIF(EMPTY(TmpPro.MatPrincs), loc_lcCodMat, TmpPro.MatPrincs)
							ENDIF
							IF LocalNensI.CMats <> loc_Material
								LOOP
							ENDIF
						ELSE
							IF crSigCdGcr.UnifBals = 3
								=SEEK(LocalNensI.Nops, "TmpOpi", "Nops")
								IF LocalNensI.Nops = 0
									loc_Material = LocalNensI.CMats
								ELSE
									=SEEK(TmpOpi.CPros, "TmpPro", "CPros")
									loc_Material = IIF(EMPTY(TmpPro.MatPrincs), loc_lcCodMat, TmpPro.MatPrincs)
								ENDIF
							ELSE
								loc_Material = IIF(crSigCdGcr.UnifBals = 1, loc_lcCodMat, LocalNensI.CMats)
							ENDIF
						ENDIF
						loc_MatResFa = loc_Material

						=SEEK(LocalNensI.CMats, "TmpPro", "CPros")
						=SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
						=SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

						loc_lcCodCor = PADR(IIF(INLIST(LocalGru.TipoEstos, 2, 4), LocalNensI.CodCors, " "), 4)
						loc_lcCodTam = PADR(IIF(INLIST(LocalGru.TipoEstos, 3, 4), LocalNensI.CodTams, " "), 4)

						IF loc_Origem
							IF !SEEK(LocalNens.GrupoOs + LocalNens.ContaOs + LocalNensI.CMats + ;
								loc_lcCodCor + loc_lcCodTam, "TmpResumo", "GrConMat")
								INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
									VALUES (LocalNens.GrupoOs, LocalNens.ContaOs, ;
									LocalNensI.CMats, TmpPro.CUnis, TmpPro.Varias, ;
									LocalGru.nAgMts, .T., loc_lcCodCor, loc_lcCodTam)
							ENDIF

							SELECT TmpResumo
							IF crSigCdOpd.EstOrigs = 1
								REPLACE PesoEnts  WITH PesoEnts  + NVL(LocalNensI.Pesos, 0), ;
										QtdeEnts  WITH QtdeEnts  + NVL(LocalNensI.Qtds, 0), ;
										PesoFabre WITH PesoFabre + NVL(LocalNensI.Peso2s, 0)
							ELSE
								REPLACE PesoSais WITH PesoSais + NVL(LocalNensI.Pesos, 0), ;
										QtdeSais WITH QtdeSais + NVL(LocalNensI.Qtds, 0), ;
										PesoFabrs WITH PesoFabrs + NVL(LocalNensI.Peso2s, 0)
							ENDIF
						ENDIF

						IF loc_Destino
							IF !SEEK(LocalNens.GrupoDs + LocalNens.ContaDs + LocalNensI.CMats + ;
								loc_lcCodCor + loc_lcCodTam, "TmpResumo", "GrConMat")
								INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel, CodCors, CodTams) ;
									VALUES (LocalNens.GrupoDs, LocalNens.ContaDs, LocalNensI.CMats, ;
									TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T., loc_lcCodCor, loc_lcCodTam)
							ENDIF

							SELECT TmpResumo
							IF crSigCdOpd.EstDests = 1
								REPLACE PesoEnts  WITH PesoEnts  + NVL(LocalNensI.Pesos, 0), ;
										QtdeEnts  WITH QtdeEnts  + NVL(LocalNensI.Qtds, 0), ;
										PesoFabre WITH PesoFabre + NVL(LocalNensI.Peso2s, 0)
							ELSE
								REPLACE PesoSais WITH PesoSais + NVL(LocalNensI.Pesos, 0), ;
										QtdeSais WITH QtdeSais + NVL(LocalNensI.Qtds, 0), ;
										PesoFabrs WITH PesoFabrs + NVL(LocalNensI.Peso2s, 0)
							ENDIF
						ENDIF
					ENDSCAN
				ENDSCAN
				loc_oBarra.Complete()

				*-- Movimentos de estoque (SigMvCab + SigMvIts)
				loc_lcQuery = "SELECT a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
					"a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, " + ;
					"a.Obses, a.cIdChaves, b.EmpDopNums, b.CPros, b.Qtds, b.Pesos, " + ;
					"b.CodCors, b.CodTams, b.Citens " + ;
					"FROM SigMvCab a, SigMvIts b " + ;
					"WHERE (a.Emps = '" + loc_lcEmp + "' OR a.EmpDs = '" + loc_lcEmp + "') AND " + ;
					"a.Datas >= ?loc_pDat AND " + ;
					"(a.GrupoDs = '" + ALLTRIM(loc_lcGrupo) + "' OR a.GrupoOs = '" + ALLTRIM(loc_lcGrupo) + "') AND " + ;
					"(a.ContaDs = '" + ALLTRIM(loc_lcConta) + "' OR a.ContaOs = '" + ALLTRIM(loc_lcConta) + "') AND " + ;
					"a.EmpDopNums = b.EmpDopNums " + ;
					"ORDER BY b.EmpDopNums, b.CPros, b.CodCors, b.CodTams, b.Citens"
				IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEsti2") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (LocalEsti2).", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT LocalEsti2
				INDEX ON EmpDopNums + CPros + STR(Citens, 4) TAG EmpDopNums
				SET ORDER TO EmpDopNums

				loc_lcQuery = "SELECT b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos, b.cItens " + ;
					"FROM SigMvCab a, SigMvItn b " + ;
					"WHERE (a.Emps = '" + loc_lcEmp + "' OR a.EmpDs = '" + loc_lcEmp + "') AND " + ;
					"a.Datas >= ?loc_pDat AND " + ;
					"(a.GrupoDs = '" + ALLTRIM(loc_lcGrupo) + "' OR a.GrupoOs = '" + ALLTRIM(loc_lcGrupo) + "') AND " + ;
					"(a.ContaDs = '" + ALLTRIM(loc_lcConta) + "' OR a.ContaOs = '" + ALLTRIM(loc_lcConta) + "') AND " + ;
					"a.EmpDopNums = b.EmpDopNums " + ;
					"ORDER BY b.EmpDopNums, b.Opers, b.CPros, b.CUnis, b.Qtds, b.Pesos"
				IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEestI") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (LocalEestI).", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT LocalEestI
				INDEX ON EmpDopNums TAG EmpDopNums
				SET ORDER TO EmpDopNums

				loc_lcQuery = "SELECT a.Datas, a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
					"a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.cIdChaves, a.EmpDs " + ;
					"FROM SigMvCab a " + ;
					"WHERE (a.Emps = '" + loc_lcEmp + "' OR a.EmpDs = '" + loc_lcEmp + "') AND " + ;
					"a.Datas >= ?loc_pDat AND " + ;
					"((a.GrupoDs = '" + ALLTRIM(loc_lcGrupo) + "' AND a.ContaDs = '" + ALLTRIM(loc_lcConta) + "') OR " + ;
					"(a.GrupoOs = '" + ALLTRIM(loc_lcGrupo) + "' AND a.ContaOs = '" + ALLTRIM(loc_lcConta) + "')) " + ;
					"ORDER BY Datas"
				IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalEest") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (LocalEest).", "Erro")
					loc_lResultado = .F.
				ENDIF

				SELECT LocalEest
				loc_oBarra = CREATEOBJECT("fwprogressbar", ;
					"Processando Mov. de Estoque", RECCOUNT("LocalEest"))
				loc_oBarra.Show()

				SCAN
					loc_oBarra.Update(.T.)

					IF DTOS(Datas) > DTOS(loc_ldDataL)
						LOOP
					ENDIF

					loc_lcEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)

					=SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")

					loc_Origem  = .F.
					loc_Destino = .F.

					IF LocalEest.Emps = loc_lcEmp
						IF INLIST(crSigCdOpe.EstOrigs, 4) OR crSigCdOpe.Opers = 3
							IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_lcGrupo AND LocalEest.ContaOs = loc_lcConta
								loc_Origem = .T.
							ELSE
								IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_lcGrupo AND LocalEest.ContaDs = loc_lcConta
									loc_Destino = .T.
								ENDIF
							ENDIF
						ELSE
							IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_lcGrupo AND LocalEest.ContaOs = loc_lcConta
								IF INLIST(crSigCdOpe.EstOrigs, 1, 2)
									loc_Origem = .T.
								ENDIF
							ENDIF
							IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_lcGrupo AND LocalEest.ContaDs = loc_lcConta
								IF INLIST(crSigCdOpe.EstDests, 1, 2)
									loc_Destino = .T.
								ENDIF
							ENDIF
						ENDIF
					ELSE
						IF LocalEest.EmpDs = loc_lcEmp
							IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_lcGrupo AND LocalEest.ContaDs = loc_lcConta
								IF INLIST(crSigCdOpe.EstDests, 1, 2)
									loc_Destino = .T.
								ENDIF
							ENDIF
						ENDIF
					ENDIF

					IF !loc_Origem AND !loc_Destino
						LOOP
					ENDIF

					SELECT LocalEestI
					SEEK loc_lcEdn
					SCAN WHILE EmpDopNums = loc_lcEdn
						=SEEK(LocalEestI.CPros, "TmpPro", "CPros")
						=SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
						=SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")

						LOCAL loc_Grupod2, loc_Contad2, loc_Operacao
						loc_Grupod2  = SPACE(10)
						loc_Contad2  = SPACE(10)
						loc_Operacao = " "

						IF INLIST(crSigCdGcr.UnifBals, 3, 4)
							loc_Material = IIF(EMPTY(TmpPro.MatPrincs), loc_lcCodMat, TmpPro.MatPrincs)
						ELSE
							loc_Material = IIF(crSigCdGcr.UnifBals = 1, loc_lcCodMat, LocalEestI.CPros)
						ENDIF

						IF crSigCdGcr.UnifBals = 4 AND LocalEestI.CPros <> loc_Material
							LOOP
						ENDIF

						loc_nQtde = NVL(LocalEestI.Qtds, 0)
						loc_nPeso = NVL(LocalEestI.Pesos, 0)

						IF loc_Origem
							IF !SEEK(loc_lcGrupo + loc_lcConta + LocalEestI.CPros, "TmpResumo", "GruConMat")
								INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
									VALUES (loc_lcGrupo, loc_lcConta, LocalEestI.CPros, ;
									LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
							ENDIF

							SELECT TmpResumo
							IF crSigCdOpe.EstOrigs = 1
								REPLACE QtdeEnts  WITH QtdeEnts  + loc_nQtde, ;
										PesoEnts  WITH PesoEnts  + loc_nPeso, ;
										PesoFabre WITH PesoFabre + loc_nPeso
							ELSE
								REPLACE QtdeSais WITH QtdeSais + loc_nQtde, ;
										PesoSais WITH PesoSais + loc_nPeso, ;
										PesoFabrs WITH PesoFabrs + loc_nPeso
							ENDIF
						ENDIF

						IF loc_Destino
							IF !SEEK(loc_lcGrupo + loc_lcConta + LocalEestI.CPros, "TmpResumo", "GruConMat")
								INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
									VALUES (loc_lcGrupo, loc_lcConta, LocalEestI.CPros, ;
									LocalEestI.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
							ENDIF

							SELECT TmpResumo
							IF crSigCdOpe.EstDests = 1
								REPLACE QtdeEnts  WITH QtdeEnts  + loc_nQtde, ;
										PesoEnts  WITH PesoEnts  + loc_nPeso, ;
										PesoFabre WITH PesoFabre + loc_nPeso
							ELSE
								REPLACE QtdeSais WITH QtdeSais + loc_nQtde, ;
										PesoSais WITH PesoSais + loc_nPeso, ;
										PesoFabrs WITH PesoFabrs + loc_nPeso
							ENDIF
						ENDIF
					ENDSCAN
				ENDSCAN
				loc_oBarra.Complete()

				*-- Marcar registros do grupo/conta processado
				SELECT TmpResumo
				REPLACE Flag3 WITH .T. FOR Grupo + Conta = loc_lcGrupo + loc_lcConta

				*-- Ajuste para UnifBals = 1 (material unificado)
				IF crSigCdGcr.UnifBals = 1
					loc_lcMat = loc_lcCodMat
					SELECT TmpResumo
					IF !SEEK(loc_lcGrupo + loc_lcConta + loc_lcMat, "TmpResumo", "GruConMat")
						APPEND BLANK
						REPLACE CMats   WITH loc_lcMat, ;
								Grupo   WITH loc_lcGrupo, ;
								Conta   WITH loc_lcConta, ;
								Visivel WITH .T.
					ENDIF

					SELECT [  ] AS Agrupar, SUM(PesoEnts) AS pEnts, SUM(PesoSais) AS pSais ;
						FROM TmpResumo ;
						WHERE Grupo + Conta = loc_lcGrupo + loc_lcConta AND ;
						CMats <> loc_lcMat AND NVL(Varias, 0) <> 1 AND NVL(Agregas, 0) <> 1 ;
						INTO CURSOR csTotal GROUP BY 1
					GO TOP IN csTotal

					SELECT TmpResumo
					=SEEK(loc_lcGrupo + loc_lcConta, "TmpResumo", "GruCon")
					SCAN WHILE Grupo + Conta = loc_lcGrupo + loc_lcConta
						IF CMats = loc_lcMat
							REPLACE PesoEnts WITH PesoEnts + NVL(csTotal.pEnts, 0)
							REPLACE PesoSais WITH PesoSais + NVL(csTotal.pSais, 0)
							REPLACE QtdeEnts WITH QtdeEnts + NVL(csTotal.pEnts, 0)
							REPLACE QtdeSais WITH QtdeSais + NVL(csTotal.pSais, 0)
						ELSE
							IF NVL(Agregas, 0) <> 1
								REPLACE Visivel WITH .F., Flag3 WITH .F.
							ENDIF
						ENDIF
					ENDSCAN
					USE IN csTotal
				ENDIF

				*-- Buscar saldo anterior da conta
				loc_lcSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
					FormatarNumeroSQL(LocalFecha.Codigos, 0) + ;
					" AND Emps = '" + loc_lcEmp + "' ORDER BY Codigos, CPros"
				IF SQLEXEC(gnConnHandle, loc_lcSql, "CrSaldoI") <= 0
					MsgErro("Falha na conex" + CHR(227) + "o (CrSaldoI).", "Erro")
					loc_lResultado = .F.
				ENDIF
				SELECT CrSaldoI
				INDEX ON CPros TAG CPros
				SET ORDER TO CPros

				*-- Calcular saldo final por material
				LOCAL loc_lcMatAtual
				loc_lcMatAtual = SPACE(14)

				SELECT TmpResumo
				SET ORDER TO GrConMat
				=SEEK(loc_lcGrupo + loc_lcConta, "TmpResumo", "GruCon")
				SCAN WHILE Grupo + Conta = loc_lcGrupo + loc_lcConta
					STORE 0 TO loc_Saldoi

					=SEEK(TmpResumo.CMats, "TmpPro", "CPros")
					IF !loc_llFalse AND TmpResumo.CMats <> loc_lcMatAtual
						loc_FalhaAdmitida = 0
						loc_lcMatAtual = TmpResumo.CMats
					ENDIF

					SELECT CrSaldoI
					=SEEK(TmpResumo.CMats)
					loc_Saldoi = NVL(CrSaldoI.Pesagems, 0)

					SELECT TmpResumo
					REPLACE Saldoi  WITH loc_Saldoi, ;
							FReal   WITH loc_Saldoi + NVL(TmpResumo.QtdeEnts, 0) - NVL(TmpResumo.QtdeSais, 0) - NVL(TmpResumo.Pesagem, 0), ;
							FAdmin  WITH loc_FalhaAdmitida, ;
							Saldof  WITH loc_Saldoi + NVL(TmpResumo.QtdeEnts, 0) - NVL(TmpResumo.QtdeSais, 0) - NVL(TmpResumo.Pesagem, 0) - loc_FalhaAdmitida, ;
							PfTrabs WITH IIF(loc_Trabalhado <> 0, (Saldof / loc_Trabalhado * 100), 0)

					IF NVL(TmpResumo.Saldof, 0) <> 0 AND ;
						(NVL(CrSigCdCli.PagFals, 0) = 1 OR NVL(CrSigCdCli.RecFals, 0) = 1)
						REPLACE Flag  WITH .T., ;
								Flag2 WITH (NVL(CrSigCdCli.PagFals, 0) = 1 OR NVL(CrSigCdCli.RecFals, 0) = 1) IN TmpResumo
					ENDIF
				ENDSCAN

				*-- Saldo do material principal para acumular em Saldos/SaldoAnt
				SELECT TmpResumo
				=SEEK(loc_lcGrupo + loc_lcConta + loc_lcCodMat, "TmpResumo", "GruConMat")
				SCAN WHILE Grupo + Conta + CMats = loc_lcGrupo + loc_lcConta + loc_lcCodMat
					IF loc_nCt = 2
						IF !SEEK(loc_lcGrupo, "Saldos", "GruConta")
							INSERT INTO Saldos (Grupos, Contas, Emps) ;
								VALUES (loc_lcGrupo, loc_lcConta, loc_lcEmp)
						ENDIF
						REPLACE Qtde WITH Qtde + NVL(TmpResumo.SaldoF, 0) IN Saldos
					ELSE
						IF !SEEK(loc_lcGrupo, "SaldoAnt", "GruConta")
							INSERT INTO SaldoAnt (Grupos, Contas, Emps) ;
								VALUES (loc_lcGrupo, loc_lcConta, loc_lcEmp)
						ENDIF
						REPLACE Qtde WITH Qtde + NVL(TmpResumo.SaldoF, 0) IN SaldoAnt
					ENDIF
				ENDSCAN

				*-- Limpar cursores temporarios do loop
				IF USED("LocalNens")
					USE IN LocalNens
				ENDIF
				IF USED("LocalNensI")
					USE IN LocalNensI
				ENDIF
				IF USED("LocalEest")
					USE IN LocalEest
				ENDIF
				IF USED("LocalEestI")
					USE IN LocalEestI
				ENDIF
				IF USED("LocalEsti2")
					USE IN LocalEsti2
				ENDIF
				IF USED("CrSaldoI")
					USE IN CrSaldoI
				ENDIF
			NEXT

			IF USED("LocalFecha")
				USE IN LocalFecha
			ENDIF
			IF USED("CrSigCdCli")
				USE IN CrSigCdCli
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
				" PROC=" + loc_oErro.Procedure, "Erro SigPrFemBO.PosBalanco")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE
