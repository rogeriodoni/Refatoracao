*====================================================================
* MttBO.prg
*
* Business Object para Metal/Teor
* Tabela: SigCdMtl
* PK: cidchaves (gerado via SYS(2015))
* Chave de negocio: tipos + codigos (unicos juntos)
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS MttBO AS BusinessBase

	*-- Propriedades da entidade (SigCdMtl)
	this_cCidchaves   = ""   && cidchaves char      - PK auto-gerada
	this_cTipos       = ""   && tipos char(1)       - [M]etal ou [T]eor
	this_cCodigos     = ""   && codigos char        - Codigo do metal/teor
	this_cDescs       = ""   && descs char          - Descricao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela      = "SigCdMtl"
		THIS.this_cCampoChave  = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	* par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT tipos, codigos, descs, cidchaves" + ;
			           " FROM SigCdMtl"

			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY tipos, codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao buscar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT tipos, codigos, descs, cidchaves" + ;
			           " FROM SigCdMtl" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao carregar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cTipos     = TratarNulo(tipos,     "C")
			THIS.this_cCodigos   = TratarNulo(codigos,   "C")
			THIS.this_cDescs     = TratarNulo(descs,     "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		IF !INLIST(UPPER(ALLTRIM(THIS.this_cTipos)), "M", "T")
			MsgAviso("[M]etal / [T]eor: informe M ou T!", "")
			RETURN .F.
		ENDIF

		IF EMPTY(ALLTRIM(THIS.this_cCodigos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!", "")
			RETURN .F.
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Inserir - INSERT no SigCdMtl (PROTECTED - chamado por BusinessBase.Salvar)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			*-- Verificar duplicidade de tipos + codigos
			IF THIS.VerificarDuplicidade()
				MsgAviso("Tipo e C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "")
				loc_lSucesso = .F.
			ELSE
				*-- Gerar PK unica (substitui fUniqueIds do legado)
				loc_cCidchaves = SYS(2015)

				loc_cSQL = "INSERT INTO SigCdMtl (cidchaves, tipos, codigos, descs)" + ;
				           " VALUES (" + ;
				           EscaparSQL(loc_cCidchaves) + ", " + ;
				           EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos))) + ", " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
				IF loc_nResultado >= 0
					THIS.this_cCidchaves = loc_cCidchaves
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
				ENDIF

				IF USED("cursor_4c_Ins")
					USE IN cursor_4c_Ins
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao inserir Metal/Teor: " + loException.Message, "Erro")
			IF USED("cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE no SigCdMtl (PROTECTED - chamado por BusinessBase.Salvar)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdMtl SET" + ;
			           " tipos = "   + EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos)))   + "," + ;
			           " codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
			           " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao atualizar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Upd")
			USE IN cursor_4c_Upd
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do SigCdMtl (PROTECTED - chamado por BusinessBase.Excluir)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdMtl" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao excluir Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Del")
			USE IN cursor_4c_Del
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Checa se tipos+codigos ja existem
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMtl" + ;
			           " WHERE tipos = "   + EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos))) + ;
			           " AND codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

			*-- Em UPDATE, excluir o proprio registro da verificacao
			IF !EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND !THIS.this_lNovoRegistro
				loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Duplic")
				SELECT cursor_4c_Duplic
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao verificar duplicidade: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Duplic")
			USE IN cursor_4c_Duplic
		ENDIF

		RETURN loc_lDuplicado
	ENDPROC

ENDDEFINE
