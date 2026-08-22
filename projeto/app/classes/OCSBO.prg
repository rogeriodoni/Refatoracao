*====================================================================
* OCSBO.prg
*
* Business Object para Ocasiao
* Tabela principal: SigCdOcs (cidchaves PK, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS OCSBO AS BusinessBase

	*-- Propriedades da entidade (SigCdOcs)
	this_cCidchaves = ""   && cidchaves char(20)  - PK tecnica gerada por fUniqueIds
	this_cCods      = ""   && cods char(10)       - codigo de ocasiao (chave de negocio)
	this_cDescs     = ""   && descs char(40)      - descricao da ocasiao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdOcs"
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
	* Buscar - Lista registros com filtro opcional sobre cods/descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cWhere = " WHERE cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = "SELECT cods, descs FROM SigCdOcs" + ;
			           loc_cWhere + ;
			           " ORDER BY cods"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado > 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo de negocio (cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs FROM SigCdOcs" + ;
			           " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCodigo))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

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
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT INTO SigCdOcs
	* Gera cidchaves via fUniqueIds() (funcao do framework legado)
	* Valida: cods nao pode ser vazio nem duplicado
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCods))
				MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Verificar duplicidade de codigo
				loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOcs WHERE cods = " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cCods))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCods")
				IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkCods") > 0
					SELECT cursor_4c_ChkCods
					IF cursor_4c_ChkCods.qtd > 0
						MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
					ELSE
						IF USED("cursor_4c_ChkCods")
							USE IN cursor_4c_ChkCods
						ENDIF
						THIS.this_cCidchaves = fUniqueIds()

						loc_cSQL = "INSERT INTO SigCdOcs (cidchaves, cods, descs)" + ;
						           " VALUES (" + ;
						           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
						           EscaparSQL(THIS.this_cCods) + ", " + ;
						           EscaparSQL(THIS.this_cDescs) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado >= 0
							THIS.RegistrarAuditoria("INSERT")
							loc_lSucesso = .T.
						ELSE
							MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
						ENDIF
					ENDIF
				ELSE
					MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					IF USED("cursor_4c_ChkCods")
						USE IN cursor_4c_ChkCods
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
			IF USED("cursor_4c_ChkCods")
				USE IN cursor_4c_ChkCods
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE SigCdOcs (apenas descs; cods e cidchaves sao imutaveis)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdOcs SET" + ;
			           " descs = " + EscaparSQL(THIS.this_cDescs) + ;
			           " WHERE cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE FROM SigCdOcs
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdOcs WHERE cods = " + ;
			           EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
