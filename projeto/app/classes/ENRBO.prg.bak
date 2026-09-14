*====================================================================
* ENRBO.prg
*
* Business Object para Enderecos (Cadastro de Enderecos - SigCdEnr)
* Tabela principal: SigCdEnr (pkchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ENRBO AS BusinessBase

	*-- Propriedades da entidade (tabela: SigCdEnr)
	this_cPkChaves  = ""   && pkchaves char(20) - PK (ID gerado via SQL NEWID)
	this_cCep       = ""   && ceps     char(9)  - CEP (formato 99999-999)
	this_cEndereco  = ""   && endes    char(60) - Endereco
	this_cBairro    = ""   && bairs    char(40) - Bairro

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdEnr"
		THIS.this_cCampoChave = "pkchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cPkChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de enderecos no cursor crSigCdEnr
	* par_cFiltro: trecho de CEP ou endereco para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " ORDER BY ceps"
			ELSE
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " WHERE ceps LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " OR endes LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEnr")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo pkchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cPkChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
			           " FROM SigCdEnr" + ;
			           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cPkChaves  = TratarNulo(pkchaves, "C")
			THIS.this_cCep       = TratarNulo(ceps,     "C")
			THIS.this_cEndereco  = TratarNulo(endes,    "C")
			THIS.this_cBairro    = TratarNulo(bairs,    "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicado - Verifica se endereco ja esta cadastrado
	* Retorna .T. se ja existe (duplicado), .F. se pode inserir
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicado()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
			           " WHERE ceps  = " + EscaparSQL(THIS.this_cCep)      + ;
			           " AND   endes = " + EscaparSQL(THIS.this_cEndereco) + ;
			           " AND   bairs = " + EscaparSQL(THIS.this_cBairro)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
				SELECT cursor_4c_DupCheck
				loc_lDuplicado = (cursor_4c_DupCheck.total > 0)
			ENDIF

			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCep))
				MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
			    IF THIS.VerificarDuplicado()
				MsgErro("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Gerar chave unica via SQL Server NEWID()
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
				IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
					SELECT cursor_4c_Uuid
					THIS.this_cPkChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
				ENDIF
				IF USED("cursor_4c_Uuid")
					USE IN cursor_4c_Uuid
				ENDIF

				IF EMPTY(THIS.this_cPkChaves)
					MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCdEnr (pkchaves, ceps, endes, bairs)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cPkChaves)  + "," + ;
					           EscaparSQL(THIS.this_cCep)       + "," + ;
					           EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
					           EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
					           ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdEnr SET" + ;
			           " ceps  = " + EscaparSQL(THIS.this_cCep)                      + "," + ;
			           " endes = " + EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
			           " bairs = " + EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
			           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdEnr WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
