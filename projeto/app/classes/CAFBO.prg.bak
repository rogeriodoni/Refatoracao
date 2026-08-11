*====================================================================
* CAFBO.prg
* Business Object para Cancelamento de OP da Fundicao
* Tabela principal : SIGCDCNF
* Tabelas secundarias: SigCdCaf (itens), SigOpPic (ordens afetadas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CAFBO AS BusinessBase

	*-- Propriedades da entidade principal (SIGCDCNF)
	this_nCodigos   = 0     && codigos numeric(6,0) - PK auto-gerado
	this_dDatas     = {}    && datas datetime NULL - data do cancelamento
	this_cEmps      = ""    && emps char(3) - codigo da empresa
	this_cObss      = ""    && obss text NULL - observacoes
	this_cUsuars    = ""    && usuars char(10) - usuario que registrou

	*-- Nome do cursor de trabalho das OPs a cancelar (equivalente ao TmpNop legado)
	*-- Campos: Nops n(10), Cpros c(14), Qtds n(10,3), Qtdos n(10,3), nFunds n(6), DtFunds d
	this_cCursorOps = "cursor_4c_OpsCanc"

	*-- Dados retornados por ValidarOP para uso do Form
	this_nUltimaOpQtdTubos = 0
	this_nUltimaOpQtdPecas = 0
	this_nUltimaOpNFunds   = 0
	this_dUltimaOpDtFunds  = {}
	this_cUltimaOpCpros    = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCNF"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Lista cancelamentos da empresa atual para o grid da Page1
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
			loc_cSQL = "SELECT codigos, datas, usuars," + ;
				" CAST(obss AS VARCHAR(500)) AS obss" + ;
				" FROM SIGCDCNF" + ;
				" WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
				" ORDER BY codigos DESC"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResult > 0
				GO TOP IN cursor_4c_Dados
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cancelamentos: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Buscar")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega cancelamento pelo codigo PK
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
			loc_cSQL = "SELECT codigos, datas, emps, usuars," + ;
				" CAST(obss AS VARCHAR(4000)) AS obss" + ;
				" FROM SIGCDCNF WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				GO TOP IN cursor_4c_Carrega
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				IF loc_lSucesso
					THIS.this_lNovoRegistro = .F.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.CarregarPorCodigo")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia cursor para propriedades do BO
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos  = TratarNulo(codigos, "N")
			THIS.this_dDatas    = TratarNulo(datas,   "D")
			THIS.this_cEmps     = ALLTRIM(TratarNulo(emps,   "C"))
			THIS.this_cObss     = ALLTRIM(TratarNulo(obss,   "C"))
			THIS.this_cUsuars   = ALLTRIM(TratarNulo(usuars, "C"))
			loc_lSucesso = .T.
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursorOps - Cria cursor vazio para edicao de OPs
	* Equivalente ao CREATE CURSOR TmpNop do original
	*====================================================================
	PROCEDURE InicializarCursorOps()
		LOCAL loc_cCursor, loc_lSucesso
		loc_cCursor = THIS.this_cCursorOps
		loc_lSucesso = .F.
		TRY
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			SET NULL ON
			CREATE CURSOR (loc_cCursor) ;
				(Nops N(10), Cpros C(14), Qtds N(10,3), Qtdos N(10,3), nFunds N(6), DtFunds D)
			SET NULL OFF
			INDEX ON Nops TAG Nops
			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.InicializarCursorOps")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Carrega itens de SigCdCaf para cursor_4c_OpsCanc
	* Usado ao selecionar registro para ALTERAR/CONSULTAR/EXCLUIR
	* Qtdos = qtdtubos atual em SigOpPic + qtds ja cancelados (= original disponivel)
	*====================================================================
	PROCEDURE CarregarItens(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCursor
		LOCAL loc_nNops, loc_cCpros, loc_nQtds, loc_nQtdos
		LOCAL loc_nFunds, loc_dDtFunds
		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorOps

		TRY
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			IF USED("cursor_4c_ItemsTemp")
				USE IN cursor_4c_ItemsTemp
			ENDIF

			loc_cSQL = "SELECT a.nops," + ;
				" (SELECT TOP 1 cpros FROM SigOpPic WHERE nops = a.nops) AS cpros," + ;
				" a.qtds," + ;
				" ISNULL((SELECT SUM(qtdtubos) FROM SigOpPic WHERE nops = a.nops),0)" + ;
				" + a.qtds AS qtdos," + ;
				" a.nfunds, a.dtfunds" + ;
				" FROM SigCdCaf a" + ;
				" WHERE a.codigos = " + FormatarNumeroSQL(par_nCodigos)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItemsTemp")

			IF loc_nResult > 0
				SET NULL ON
				CREATE CURSOR (loc_cCursor) ;
					(Nops N(10), Cpros C(14), Qtds N(10,3), Qtdos N(10,3), nFunds N(6), DtFunds D)
				SET NULL OFF
				INDEX ON Nops TAG Nops

				IF RECCOUNT("cursor_4c_ItemsTemp") > 0
					SELECT cursor_4c_ItemsTemp
					GO TOP
					DO WHILE !EOF("cursor_4c_ItemsTemp")
						SELECT cursor_4c_ItemsTemp
						loc_nNops    = cursor_4c_ItemsTemp.nops
						loc_cCpros   = ALLTRIM(NVL(cursor_4c_ItemsTemp.cpros, ""))
						loc_nQtds    = NVL(cursor_4c_ItemsTemp.qtds, 0)
						loc_nQtdos   = NVL(cursor_4c_ItemsTemp.qtdos, 0)
						loc_nFunds   = NVL(cursor_4c_ItemsTemp.nfunds, 0)
						loc_dDtFunds = cursor_4c_ItemsTemp.dtfunds

						SELECT (loc_cCursor)
						APPEND BLANK
						REPLACE Nops    WITH loc_nNops
						REPLACE Cpros   WITH loc_cCpros
						REPLACE Qtds    WITH loc_nQtds
						REPLACE Qtdos   WITH loc_nQtdos
						REPLACE nFunds  WITH loc_nFunds
						REPLACE DtFunds WITH loc_dDtFunds

						SKIP IN cursor_4c_ItemsTemp
					ENDDO
				ENDIF

				SELECT (loc_cCursor)
				GO TOP
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.CarregarItens")
		ENDTRY

		IF USED("cursor_4c_ItemsTemp")
			USE IN cursor_4c_ItemsTemp
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarOP - Valida OP e popula propriedades this_nUltimaOp*
	* Equivalente ao evento Valid de Get_nop no legado
	* Retorna .T. se OP valida e tem qtdtubos disponivel
	*====================================================================
	PROCEDURE ValidarOP(par_nNops)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nQtdT, loc_nQtdP, loc_nFunds, loc_dDtFunds, loc_cCpros
		loc_lSucesso = .F.
		THIS.this_nUltimaOpQtdTubos = 0
		THIS.this_nUltimaOpQtdPecas = 0
		THIS.this_nUltimaOpNFunds   = 0
		THIS.this_dUltimaOpDtFunds  = {}
		THIS.this_cUltimaOpCpros    = ""

		TRY
			IF par_nNops <= 0
				MsgAviso("OP inv" + CHR(225) + "lida!", "")
			ELSE
				IF USED("cursor_4c_OPValida")
					USE IN cursor_4c_OPValida
				ENDIF

				loc_cSQL = "SELECT nops, cpros, emps, qtdtubos," + ;
					" qtdcpnts, qtds, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops)

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPValida")

				IF loc_nResult > 0 AND RECCOUNT("cursor_4c_OPValida") > 0
					SELECT cursor_4c_OPValida
					GO TOP
					IF ALLTRIM(cursor_4c_OPValida.emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
						loc_nQtdT    = 0
						loc_nQtdP    = 0
						loc_cCpros   = ALLTRIM(cursor_4c_OPValida.cpros)
						loc_nFunds   = NVL(cursor_4c_OPValida.nfunds, 0)
						loc_dDtFunds = cursor_4c_OPValida.dtfunds

						DO WHILE !EOF("cursor_4c_OPValida")
							SELECT cursor_4c_OPValida
							loc_nQtdT = loc_nQtdT + NVL(cursor_4c_OPValida.qtdtubos, 0)
							loc_nQtdP = loc_nQtdP + NVL(cursor_4c_OPValida.qtds, 0)
							SKIP IN cursor_4c_OPValida
						ENDDO

						IF loc_nQtdT <= 0
							MsgAviso("Nenhum Componente com Processo de Fundi" + CHR(231) + CHR(227) + "o!", "")
						ELSE
							THIS.this_nUltimaOpQtdTubos = loc_nQtdT
							THIS.this_nUltimaOpQtdPecas = loc_nQtdP
							THIS.this_nUltimaOpNFunds   = loc_nFunds
							THIS.this_dUltimaOpDtFunds  = loc_dDtFunds
							THIS.this_cUltimaOpCpros    = loc_cCpros
							loc_lSucesso = .T.
						ENDIF
					ELSE
						MsgAviso("OP n" + CHR(227) + "o encontrada!", "")
					ENDIF
				ELSE
					MsgAviso("OP n" + CHR(227) + "o encontrada!", "")
				ENDIF

				IF USED("cursor_4c_OPValida")
					USE IN cursor_4c_OPValida
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.ValidarOP")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Gera proximo codigo unico para SIGCDCNF
	* Equivalente ao fGerUniqueKey('SigCdCnf') do legado
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo()
		LOCAL loc_cSQL, loc_nResult, loc_nCodigo
		loc_nCodigo = 0
		TRY
			IF USED("cursor_4c_MaxCod")
				USE IN cursor_4c_MaxCod
			ENDIF
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS ProxCod FROM SIGCDCNF"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
				SELECT cursor_4c_MaxCod
				GO TOP
				loc_nCodigo = NVL(cursor_4c_MaxCod.ProxCod, 1)
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.GerarProximoCodigo")
		ENDTRY
		IF USED("cursor_4c_MaxCod")
			USE IN cursor_4c_MaxCod
		ENDIF
		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* GerarCidChavesCAF - Gera cidchaves unico para linha de SigCdCaf
	* Formato: codigos (10 digitos zero-padded) + nops (10 digitos zero-padded)
	*====================================================================
	PROTECTED PROCEDURE GerarCidChavesCAF(par_nCodigos, par_nNops)
		LOCAL loc_cChave
		loc_cChave = PADL(ALLTRIM(STR(par_nCodigos, 10)), 10, "0") + ;
			PADL(ALLTRIM(STR(par_nNops, 10)), 10, "0")
		RETURN loc_cChave
	ENDPROC

	*====================================================================
	* AtualizarOpsCancelamento - Reduz qtdtubos em SigOpPic (ao cancelar)
	* Percorre linhas da OP por nops+cpros e reduz qtdtubos ate esgotar lnQtd
	*====================================================================
	PROTECTED PROCEDURE AtualizarOpsCancelamento(par_nNops, par_nQtds)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nQtdRestante
		LOCAL loc_nQtdTubos, loc_nNovoQtd, loc_cCpros
		loc_lSucesso = .F.
		TRY
			IF par_nQtds <= 0
				loc_lSucesso = .T.
			ELSE
				IF USED("cursor_4c_OPRows")
					USE IN cursor_4c_OPRows
				ENDIF
				loc_cSQL = "SELECT cpros, qtdtubos, qtdcpnts, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
					" ORDER BY cpros"
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPRows")
				IF loc_nResult > 0
					loc_nQtdRestante = par_nQtds
					loc_lSucesso     = .T.
					SELECT cursor_4c_OPRows
					GO TOP
					DO WHILE !EOF("cursor_4c_OPRows") AND loc_nQtdRestante > 0
						SELECT cursor_4c_OPRows
						loc_nQtdTubos = NVL(cursor_4c_OPRows.qtdtubos, 0)
						loc_cCpros    = ALLTRIM(cursor_4c_OPRows.cpros)

						IF loc_nQtdTubos <= loc_nQtdRestante
							loc_nQtdRestante = loc_nQtdRestante - loc_nQtdTubos
							loc_nNovoQtd     = 0
						ELSE
							loc_nNovoQtd     = loc_nQtdTubos - loc_nQtdRestante
							loc_nQtdRestante = 0
						ENDIF

						loc_cSQL = "UPDATE SigOpPic SET qtdtubos = " + ;
							FormatarNumeroSQL(loc_nNovoQtd) + ;
							" WHERE nops = " + FormatarNumeroSQL(par_nNops)

						IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
							MsgErro("Erro ao atualizar SigOpPic (OP " + ;
								TRANSFORM(par_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
							EXIT
						ENDIF

						SKIP IN cursor_4c_OPRows
					ENDDO

					IF USED("cursor_4c_OPRows")
						USE IN cursor_4c_OPRows
					ENDIF
				ELSE
					MsgErro("Erro ao buscar linhas da OP " + ;
						TRANSFORM(par_nNops) + ": " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.AtualizarOpsCancelamento")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestaurarOpsCancelamento - Restaura qtdtubos em SigOpPic (ao desfazer)
	* Adiciona de volta ate qtdcpnts (maximo) ou ate esgotar a quantidade
	*====================================================================
	PROTECTED PROCEDURE RestaurarOpsCancelamento(par_nNops, par_nQtds)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nQtdRestante
		LOCAL loc_nQtdTubos, loc_nQtdCpnts, loc_nNovoQtd, loc_nDiff, loc_cCpros
		loc_lSucesso = .F.
		TRY
			IF par_nQtds <= 0
				loc_lSucesso = .T.
			ELSE
				IF USED("cursor_4c_OPRowsR")
					USE IN cursor_4c_OPRowsR
				ENDIF
				loc_cSQL = "SELECT cpros, qtdtubos, qtdcpnts, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
					" ORDER BY cpros"
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPRowsR")
				IF loc_nResult > 0
					loc_nQtdRestante = par_nQtds
					loc_lSucesso     = .T.
					SELECT cursor_4c_OPRowsR
					GO TOP
					DO WHILE !EOF("cursor_4c_OPRowsR") AND loc_nQtdRestante > 0
						SELECT cursor_4c_OPRowsR
						loc_nQtdTubos = NVL(cursor_4c_OPRowsR.qtdtubos, 0)
						loc_nQtdCpnts = NVL(cursor_4c_OPRowsR.qtdcpnts, 0)
						loc_cCpros    = ALLTRIM(cursor_4c_OPRowsR.cpros)

						*-- Espaco disponivel para restaurar nesta linha
						loc_nDiff = loc_nQtdCpnts - loc_nQtdTubos
						IF loc_nDiff <= 0
							SKIP IN cursor_4c_OPRowsR
							LOOP
						ENDIF

						IF loc_nDiff <= loc_nQtdRestante
							loc_nQtdRestante = loc_nQtdRestante - loc_nDiff
							loc_nNovoQtd     = loc_nQtdCpnts  && Restaura ao maximo
						ELSE
							loc_nNovoQtd     = loc_nQtdTubos + loc_nQtdRestante
							loc_nQtdRestante = 0
						ENDIF

						loc_cSQL = "UPDATE SigOpPic SET qtdtubos = " + ;
							FormatarNumeroSQL(loc_nNovoQtd) + ;
							" WHERE nops = " + FormatarNumeroSQL(par_nNops)

						IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
							MsgErro("Erro ao restaurar SigOpPic (OP " + ;
								TRANSFORM(par_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
							EXIT
						ENDIF

						SKIP IN cursor_4c_OPRowsR
					ENDDO

					IF USED("cursor_4c_OPRowsR")
						USE IN cursor_4c_OPRowsR
					ENDIF
				ELSE
					MsgErro("Erro ao buscar linhas da OP para restaurar " + ;
						TRANSFORM(par_nNops) + ": " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.RestaurarOpsCancelamento")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestaurarItensCancelamento - Carrega SigCdCaf e restaura SigOpPic
	* Usado antes de ALTERAR (para rebuild) e em ExecutarExclusao
	*====================================================================
	PROTECTED PROCEDURE RestaurarItensCancelamento(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nNops, loc_nQtds
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_ItensAntigos")
				USE IN cursor_4c_ItensAntigos
			ENDIF
			loc_cSQL = "SELECT nops, qtds FROM SigCdCaf" + ;
				" WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensAntigos")
			IF loc_nResult > 0
				loc_lSucesso = .T.
				SELECT cursor_4c_ItensAntigos
				GO TOP
				DO WHILE !EOF("cursor_4c_ItensAntigos") AND loc_lSucesso
					SELECT cursor_4c_ItensAntigos
					loc_nNops = cursor_4c_ItensAntigos.nops
					loc_nQtds = NVL(cursor_4c_ItensAntigos.qtds, 0)

					IF loc_nNops > 0 AND loc_nQtds > 0
						IF !THIS.RestaurarOpsCancelamento(loc_nNops, loc_nQtds)
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SKIP IN cursor_4c_ItensAntigos
				ENDDO
			ELSE
				MsgErro("Erro ao carregar itens para restaurar: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.RestaurarItensCancelamento")
			loc_lSucesso = .F.
		ENDTRY
		IF USED("cursor_4c_ItensAntigos")
			USE IN cursor_4c_ItensAntigos
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InserirItensCancelamento - Insere itens do cursor em SigCdCaf
	* e atualiza SigOpPic reduzindo qtdtubos
	* Pula linhas com Nops=0 ou Qtds=0 (marcadores invalidos)
	*====================================================================
	PROTECTED PROCEDURE InserirItensCancelamento(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nNops, loc_nQtds, loc_nFunds, loc_dDtFunds, loc_cCidChaves
		LOCAL loc_cCursor
		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorOps

		TRY
			IF !USED(loc_cCursor)
				MsgErro("Cursor de OPs n" + CHR(227) + "o encontrado: " + loc_cCursor, "Erro")
			ELSE
				loc_lSucesso = .T.
				SELECT (loc_cCursor)
				GO TOP
				DO WHILE !EOF(loc_cCursor) AND loc_lSucesso
					SELECT (loc_cCursor)
					loc_nNops    = Nops
					loc_nQtds    = Qtds
					loc_nFunds   = NVL(nFunds, 0)
					loc_dDtFunds = DtFunds

					SKIP IN (loc_cCursor)

					IF DELETED() OR loc_nNops <= 0 OR loc_nQtds <= 0
						LOOP
					ENDIF

					*-- Gera cidchaves unico para SigCdCaf
					loc_cCidChaves = THIS.GerarCidChavesCAF(par_nCodigos, loc_nNops)

					*-- INSERT em SigCdCaf
					loc_cSQL = "INSERT INTO SigCdCaf" + ;
						" (codigos, nops, qtds, nfunds, dtfunds, cidchaves)" + ;
						" VALUES (" + ;
						FormatarNumeroSQL(par_nCodigos) + ", " + ;
						FormatarNumeroSQL(loc_nNops) + ", " + ;
						FormatarNumeroSQL(loc_nQtds) + ", " + ;
						FormatarNumeroSQL(loc_nFunds) + ", " + ;
						IIF(EMPTY(loc_dDtFunds), "NULL", FormatarDataSQL(loc_dDtFunds)) + ", " + ;
						EscaparSQL(loc_cCidChaves) + ;
						")"

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult < 0
						MsgErro("Erro ao inserir item de cancelamento (OP " + ;
							TRANSFORM(loc_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
						loc_lSucesso = .F.
					ELSE
						*-- Atualiza SigOpPic reduzindo qtdtubos
						IF !THIS.AtualizarOpsCancelamento(loc_nNops, loc_nQtds)
							loc_lSucesso = .F.
						ENDIF
					ENDIF
				ENDDO
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.InserirItensCancelamento")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SIGCDCNF + SigCdCaf + atualiza SigOpPic
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nCodigos
		loc_lSucesso = .F.
		TRY
			loc_nCodigos = THIS.GerarProximoCodigo()
			IF loc_nCodigos <= 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo de cancelamento.", "Erro")
			ELSE
				THIS.this_nCodigos = loc_nCodigos
				THIS.this_cEmps    = go_4c_Sistema.cCodEmpresa
				THIS.this_cUsuars  = gc_4c_UsuarioLogado

				loc_cSQL = "INSERT INTO SIGCDCNF (codigos, datas, emps, usuars, obss)" + ;
					" VALUES (" + ;
					FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
					"GETDATE(), " + ;
					EscaparSQL(THIS.this_cEmps) + ", " + ;
					EscaparSQL(THIS.this_cUsuars) + ", " + ;
					EscaparSQL(THIS.this_cObss) + ;
					")"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult >= 0
					loc_lSucesso = THIS.InserirItensCancelamento(THIS.this_nCodigos)
					IF loc_lSucesso
						THIS.RegistrarAuditoria("INSERT")
					ENDIF
				ELSE
					MsgErro("Erro ao inserir cancelamento: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Inserir")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE SIGCDCNF + rebuild SigCdCaf + atualiza SigOpPic
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			*-- 1. Restaura SigOpPic com base nos itens anteriores de SigCdCaf
			IF !THIS.RestaurarItensCancelamento(THIS.this_nCodigos)
				MsgErro("Erro ao restaurar OPs para altera" + CHR(231) + CHR(227) + "o.", "Erro")
			ELSE
				*-- 2. Remove itens antigos de SigCdCaf
				loc_cSQL = "DELETE FROM SigCdCaf WHERE codigos = " + ;
					FormatarNumeroSQL(THIS.this_nCodigos)
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult < 0
					MsgErro("Erro ao remover itens antigos: " + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Re-insere itens do cursor + atualiza SigOpPic
					IF THIS.InserirItensCancelamento(THIS.this_nCodigos)
						*-- 4. UPDATE no cabecalho SIGCDCNF
						loc_cSQL = "UPDATE SIGCDCNF SET" + ;
							" datas = GETDATE()," + ;
							" usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
							" obss = " + EscaparSQL(THIS.this_cObss) + ;
							" WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)
						loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResult >= 0
							THIS.RegistrarAuditoria("UPDATE")
							loc_lSucesso = .T.
						ELSE
							MsgErro("Erro ao atualizar cabe" + CHR(231) + "alho: " + ;
								CapturarErroSQL(), "Erro SQL")
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Atualizar")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Restaura OPs e exclui cancelamento em cascata
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			*-- 1. Restaura SigOpPic a partir dos itens de SigCdCaf
			IF !THIS.RestaurarItensCancelamento(THIS.this_nCodigos)
				MsgErro("Erro ao restaurar OPs para exclus" + CHR(227) + "o.", "Erro")
			ELSE
				*-- 2. Remove itens de SigCdCaf
				loc_cSQL = "DELETE FROM SigCdCaf WHERE codigos = " + ;
					FormatarNumeroSQL(THIS.this_nCodigos)
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult < 0
					MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Remove cabecalho SIGCDCNF
					loc_cSQL = "DELETE FROM SIGCDCNF WHERE codigos = " + ;
						FormatarNumeroSQL(THIS.this_nCodigos)
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cancelamento: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.ExecutarExclusao")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
