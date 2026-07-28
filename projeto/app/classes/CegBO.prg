*====================================================================
* CegBO.prg
*
* Business Object para Prioridade de Estoque p/Globaliza??o
* Tabela principal: SigCdCeg (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CegBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCeg)
	this_cCidchaves   = ""   && cidchaves char(?)      - PK (gerado por fUniqueIds)
	this_cGrupos      = ""   && grupos char(?)         - Grupo (FK SigCdGcr.Codigos)
	this_cContas      = ""   && contas char(?)         - Conta (via fAcessoContas)
	this_cEmps        = ""   && Cemps char(3)           - Empresa (FK SigCdEmp.CEmps)
	this_nPriors      = 0    && priors numeric(2,0)    - Prioridade (InputMask "99")
	this_nTpCads      = 0    && TpCads numeric(1,0)    - Tipo (OptionGroup 3 opcoes)

	*-- Propriedade auxiliar de exibicao (NAO persiste no banco)
	this_cDEmps       = ""   && descricao da empresa (SigCdEmp.Razas - display only)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCeg"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.priors, a.grupos, a.contas, a.emps," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)"

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE RTRIM(a.grupos) LIKE " + ;
				           EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.priors"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar prioridades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar prioridades:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pela chave primaria
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.contas, a.grupos, a.priors," + ;
			           " a.emps, a.tpcads," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)" + ;
			           " WHERE RTRIM(a.cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_nPriors    = TratarNulo(priors, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nTpCads    = TratarNulo(tpcads, "N")
			THIS.this_cDEmps     = TratarNulo(Razas, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se grupos+contas ja existem (INSERT)
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SIGCDCEG" + ;
			           " WHERE RTRIM(grupos) = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ;
			           " AND RTRIM(contas) = " + EscaparSQL(ALLTRIM(THIS.this_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND !EOF("cursor_4c_Duplic")
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF

			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCEG" + ;
			           " (cidchaves, contas, grupos, priors, emps, tpcads)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCEG SET" + ;
			           " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           " priors = " + FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           " tpcads = " + FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCEG" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
