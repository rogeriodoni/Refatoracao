*====================================================================
* OrcBO.prg
*
* Business Object para Orc (Orcamento/Previsao)
* Tabela: SigCdMrp (multi-linha: uma por grupo/conta)
*
* Chave composta do "cabecalho": cEmps + cMes + cAno + cTitulo + Moeda
* Chave de linha: cIdChaves (UUID gerado por fUniqueIds)
*
* Estrutura SigCdMrp:
*   cemps     - Empresa       (C(3))
*   cmes      - Mes           (C(2))
*   cano      - Ano           (C(4))
*   ctitulo   - Titulo        (C(40))
*   moeda     - Cod. Moeda    (C(3))
*   nvltots   - Total orcado  (N(15,2))
*   cgrupos   - Cod. Grupo    (C(10)) - linha de grupo
*   iclis     - Cod. Cliente  (C(10)) - linha de conta
*   nvalors   - Valor         (N(15,2))
*   npercs    - Percentual    (N(9,6))
*   cidchaves - ID unico linha (C(20))
*====================================================================

DEFINE CLASS OrcBO AS BusinessBase

	*-- ==========================================
	*-- Propriedades do cabecalho (identificacao)
	*-- ==========================================
	this_cEmps      = ""  && Empresa (C(3))
	this_cMes       = ""  && Mes (C(2)) - "01" a "12"
	this_cAno       = ""  && Ano (C(4)) - "2026"
	this_cTitulo    = ""  && Titulo da previsao (C(40))
	this_cMoeda     = ""  && Codigo da moeda (C(3))
	this_cDescMoeda = ""  && Descricao da moeda - de SigCdMoe.dmoes
	this_nVlTots    = 0   && Total orcado (N(15,2))

	*-- ==========================================
	*-- Propriedades de linha (detalhe)
	*-- ==========================================
	this_cIdChaves  = ""  && ID unico da linha - gerado por fUniqueIds
	this_cGrupos    = ""  && Codigo do grupo - SigCdGcr.codigos
	this_cIClis     = ""  && Codigo da conta/cliente - SigCdCli.iclis
	this_nValors    = 0   && Valor alocado (N(15,2))
	this_nPercs     = 0   && Percentual alocado (N(9,6))

	*-- ==========================================
	*-- Propriedades de controle interno
	*-- ==========================================
	this_cChaveCompostaAnterior = ""  && Chave antes de edicao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = DODEFAULT()

			THIS.this_cTabela     = "SigCdMrp"
			THIS.this_cCampoChave = "cIdChaves"

		CATCH TO loException
			MsgErro("Erro em OrcBO.Init: " + loException.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave composta para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEmps) + "+" + ;
		       ALLTRIM(THIS.this_cMes)  + "+" + ;
		       ALLTRIM(THIS.this_cAno)  + "+" + ;
		       ALLTRIM(THIS.this_cTitulo) + "+" + ;
		       ALLTRIM(THIS.this_cMoeda)
	ENDPROC

	*====================================================================
	* Buscar - Carrega cursor_4c_Dados com lista agrupada de orcamentos
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cWhere
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cWhere = " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
			IF !EMPTY(par_cFiltro)
				loc_cWhere = loc_cWhere + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
			           "MAX(cidchaves) AS cidchaves " + ;
			           "FROM SIGCDMRP" + ;
			           loc_cWhere + ;
			           " GROUP BY cemps, cmes, cano, ctitulo, moeda, nvltots" + ;
			           " ORDER BY cano, cmes, ctitulo"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
				USE IN cursor_4c_DadosTmp
				GO TOP IN cursor_4c_Dados
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar or" + CHR(231) + "amentos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cEmps     = ALLTRIM(cemps)
				THIS.this_cMes      = ALLTRIM(cmes)
				THIS.this_cAno      = ALLTRIM(cano)
				THIS.this_cTitulo   = ALLTRIM(ctitulo)
				THIS.this_cMoeda    = ALLTRIM(moeda)
				THIS.this_nVlTots   = nvltots
				THIS.this_cIdChaves = ALLTRIM(cidchaves)

				THIS.this_cChaveCompostaAnterior = THIS.ObterChavePrimaria()

				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro por cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps, cmes, cano, ctitulo, moeda, nvltots, cidchaves " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cidchaves = " + EscaparSQL(par_cChave)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodTmp")
			IF loc_nResult > 0 AND !EOF("cursor_4c_CodTmp")
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CodTmp")
				THIS.this_lNovoRegistro = .F.
			ELSE
				THIS.this_cUltimoErro = "Registro n" + CHR(227) + "o encontrado."
			ENDIF

			IF USED("cursor_4c_CodTmp")
				USE IN cursor_4c_CodTmp
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor_4c_Grupos de SigCdGcr (READWRITE)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_cSQL = "SELECT codigos, descrs, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SigCdGcr " + ;
			           "ORDER BY codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_GrpTmp INTO CURSOR cursor_4c_Grupos READWRITE
				USE IN cursor_4c_GrpTmp
				GO TOP IN cursor_4c_Grupos
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar grupos."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor_4c_Contas de SIGCDCLI (READWRITE)
	*====================================================================
	PROCEDURE BuscarContas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_cSQL = "SELECT grupos, iclis, rclis, " + ;
			           "CAST(0.0 AS NUMERIC(15,2)) AS Valor, " + ;
			           "CAST(0.0 AS NUMERIC(9,6)) AS Perc " + ;
			           "FROM SIGCDCLI " + ;
			           "ORDER BY rclis"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaTmp")
			IF loc_nResult > 0
				SELECT * FROM cursor_4c_CtaTmp INTO CURSOR cursor_4c_Contas READWRITE
				USE IN cursor_4c_CtaTmp
				GO TOP IN cursor_4c_Contas
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao carregar contas."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDetalhe - Popula Valor/Perc em cursor_4c_Grupos e cursor_4c_Contas
	*                   com os valores existentes no BD para o orcamento atual
	*====================================================================
	PROCEDURE CarregarDetalhe()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cGrupo, loc_cConta, loc_nValor, loc_nPerc
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cgrupos, iclis, nvalors, npercs " + ;
			           "FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Detalhe")
			IF loc_nResult > 0
				SELECT cursor_4c_Detalhe
				SCAN
					loc_cGrupo = ALLTRIM(cgrupos)
					loc_cConta = ALLTRIM(iclis)
					loc_nValor = nvalors
					loc_nPerc  = npercs

					IF !EMPTY(loc_cGrupo) AND USED("cursor_4c_Grupos")
						SELECT cursor_4c_Grupos
						LOCATE FOR ALLTRIM(codigos) == loc_cGrupo
						IF FOUND("cursor_4c_Grupos")
							SELECT cursor_4c_Grupos
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF

					IF !EMPTY(loc_cConta) AND USED("cursor_4c_Contas")
						SELECT cursor_4c_Contas
						LOCATE FOR ALLTRIM(iclis) == loc_cConta
						IF FOUND("cursor_4c_Contas")
							SELECT cursor_4c_Contas
							REPLACE Valor WITH loc_nValor, Perc WITH loc_nPerc
						ENDIF
					ENDIF
				ENDSCAN

				IF USED("cursor_4c_Detalhe")
					USE IN cursor_4c_Detalhe
				ENDIF

				IF USED("cursor_4c_Grupos")
					GO TOP IN cursor_4c_Grupos
				ENDIF
				IF USED("cursor_4c_Contas")
					GO TOP IN cursor_4c_Contas
				ENDIF
			ENDIF

			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Retorna .T. se chave composta ja existe no BD
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")
			IF loc_nResult > 0
				SELECT cursor_4c_DupChk
				loc_lResultado = (qtde > 0)
				USE IN cursor_4c_DupChk
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterDescricaoMoeda - Retorna SigCdMoe.dmoes para o codigo informado
	*====================================================================
	PROCEDURE ObterDescricaoMoeda(par_cCodMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResult
		loc_cDescricao = ""

		TRY
			IF !EMPTY(par_cCodMoeda)
				loc_cSQL = "SELECT dmoes FROM SigCdMoe " + ;
				           "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodMoeda))

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
				IF loc_nResult > 0 AND !EOF("cursor_4c_Moeda")
					SELECT cursor_4c_Moeda
					loc_cDescricao = ALLTRIM(dmoes)
				ENDIF
				IF USED("cursor_4c_Moeda")
					USE IN cursor_4c_Moeda
				ENDIF
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDPROC

	*====================================================================
	* EfetuarSalvamento - Delta save de grupos e contas em SIGCDMRP
	*   Para cada grupo/conta: faz UPDATE se ja existe, INSERT se novo
	*   Para ALTERAR: deleta previamente linhas zeradas (removidas pelo usuario)
	*====================================================================
	PROTECTED PROCEDURE EfetuarSalvamento()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_cEmps, loc_cMes, loc_cAno, loc_cTitulo, loc_cMoeda, loc_nVlTots
		LOCAL loc_cCodigo, loc_cIdChaves, loc_cOper, loc_lOk
		loc_lResultado = .F.

		TRY
			loc_lOk     = .T.
			loc_cEmps   = EscaparSQL(ALLTRIM(THIS.this_cEmps))
			loc_cMes    = EscaparSQL(ALLTRIM(THIS.this_cMes))
			loc_cAno    = EscaparSQL(ALLTRIM(THIS.this_cAno))
			loc_cTitulo = EscaparSQL(ALLTRIM(THIS.this_cTitulo))
			loc_cMoeda  = EscaparSQL(ALLTRIM(THIS.this_cMoeda))
			loc_nVlTots = FormatarNumeroSQL(THIS.this_nVlTots)
			loc_cOper   = IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE")

			*-- Para ALTERAR: remover linhas de grupos zerados (usuario removeu do orcamento)
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor = 0 AND cursor_4c_Grupos.Perc = 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = EscaparSQL(ALLTRIM(codigos))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + loc_cCodigo + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover grupo zerado."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Para ALTERAR: remover linhas de contas zeradas
			IF !THIS.this_lNovoRegistro AND loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor = 0 AND cursor_4c_Contas.Perc = 0
					SELECT cursor_4c_Contas
					loc_cCodigo = EscaparSQL(ALLTRIM(iclis))
					loc_cSQL = "DELETE FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps   + ;
					           "  AND cmes    = " + loc_cMes    + ;
					           "  AND cano    = " + loc_cAno    + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + loc_cCodigo + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao remover conta zerada."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar grupos com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Grupos")
				SELECT cursor_4c_Grupos
				SCAN FOR cursor_4c_Grupos.Valor <> 0 OR cursor_4c_Grupos.Perc <> 0
					SELECT cursor_4c_Grupos
					loc_cCodigo = ALLTRIM(codigos)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND cgrupos = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND iclis   = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           EscaparSQL("") + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Grupos.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar grupo " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			*-- Salvar contas com valor ou percentual
			IF loc_lOk AND USED("cursor_4c_Contas")
				SELECT cursor_4c_Contas
				SCAN FOR cursor_4c_Contas.Valor <> 0 OR cursor_4c_Contas.Perc <> 0
					SELECT cursor_4c_Contas
					loc_cCodigo = ALLTRIM(iclis)

					*-- Verifica se linha ja existe no BD
					loc_cSQL = "SELECT cidchaves FROM SIGCDMRP " + ;
					           "WHERE cemps   = " + loc_cEmps + ;
					           "  AND cmes    = " + loc_cMes  + ;
					           "  AND cano    = " + loc_cAno  + ;
					           "  AND ctitulo = " + loc_cTitulo + ;
					           "  AND moeda   = " + loc_cMoeda  + ;
					           "  AND iclis   = " + EscaparSQL(loc_cCodigo) + ;
					           "  AND cgrupos = ''"
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

					IF loc_nResult > 0 AND !EOF("cursor_4c_ChkExiste")
						SELECT cursor_4c_ChkExiste
						loc_cIdChaves = ALLTRIM(cidchaves)
						USE IN cursor_4c_ChkExiste
						loc_cSQL = "UPDATE SIGCDMRP SET " + ;
						           "nvalors = " + FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           "npercs  = " + FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           "nvltots = " + loc_nVlTots + ;
						           " WHERE cidchaves = " + EscaparSQL(loc_cIdChaves)
					ELSE
						IF USED("cursor_4c_ChkExiste")
							USE IN cursor_4c_ChkExiste
						ENDIF
						loc_cIdChaves = fUniqueIds()
						loc_cSQL = "INSERT INTO SIGCDMRP " + ;
						           "(cemps, cmes, cano, ctitulo, moeda, nvltots, " + ;
						           "cgrupos, iclis, nvalors, npercs, cidchaves) " + ;
						           "VALUES (" + ;
						           loc_cEmps   + ", " + ;
						           loc_cMes    + ", " + ;
						           loc_cAno    + ", " + ;
						           loc_cTitulo + ", " + ;
						           loc_cMoeda  + ", " + ;
						           loc_nVlTots + ", " + ;
						           EscaparSQL("") + ", " + ;
						           EscaparSQL(loc_cCodigo) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Valor) + ", " + ;
						           FormatarNumeroSQL(cursor_4c_Contas.Perc)  + ", " + ;
						           EscaparSQL(loc_cIdChaves) + ")"
					ENDIF

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult <= 0
						THIS.this_cUltimoErro = "Erro ao salvar conta " + loc_cCodigo + "."
						loc_lOk = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF

			IF loc_lOk
				THIS.RegistrarAuditoria(loc_cOper)
				loc_lResultado = .T.
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Override: delega para EfetuarSalvamento
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_lResultado = THIS.EfetuarSalvamento()
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui todas as linhas do orcamento no BD
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDMRP " + ;
			           "WHERE cemps   = " + EscaparSQL(ALLTRIM(THIS.this_cEmps))   + ;
			           "  AND cmes    = " + EscaparSQL(ALLTRIM(THIS.this_cMes))    + ;
			           "  AND cano    = " + EscaparSQL(ALLTRIM(THIS.this_cAno))    + ;
			           "  AND ctitulo = " + EscaparSQL(ALLTRIM(THIS.this_cTitulo)) + ;
			           "  AND moeda   = " + EscaparSQL(ALLTRIM(THIS.this_cMoeda))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cUltimoErro = "Erro ao excluir or" + CHR(231) + "amento."
			ENDIF

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE
