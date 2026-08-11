*====================================================================
* CatBO.prg
*
* Business Object para Categorias de Produto
* Tabela principal: SIGCDCAT (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CatBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCAT)
	this_cCidchaves = ""   && cidchaves char(20)    - PK tecnica (UUID fUniqueIds)
	this_cCods      = ""   && cods char(6)          - codigo de categoria
	this_cDescs     = ""   && descs char(15)        - descricao curta
	this_cDesc2s    = ""   && desc2s char(40)       - descricao completa
	this_cGdegrps   = ""   && gdegrps char(3)       - grande grupo (FK SigCdGpr.Codigos)
	this_nPrazos    = 0    && prazos numeric(2,0)   - prazo de entrega (dias)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCAT"
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
	* Buscar - Carrega lista de categorias no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, gdegrps, prazos" + ;
				           " FROM SIGCDCAT" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, desc2s, gdegrps, prazos" + ;
			           " FROM SIGCDCAT" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cDesc2s    = TratarNulo(desc2s, "C")
			THIS.this_cGdegrps   = TratarNulo(gdegrps, "C")
			THIS.this_nPrazos    = TratarNulo(prazos, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCAT (cidchaves, cods, descs, desc2s, gdegrps, prazos)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCAT SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 6)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 15)) + "," + ;
			           " desc2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDesc2s), 40)) + "," + ;
			           " gdegrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGdegrps), 3)) + "," + ;
			           " prazos = " + FormatarNumeroSQL(THIS.this_nPrazos) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SIGCDCAT
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCAT WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir categoria:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
