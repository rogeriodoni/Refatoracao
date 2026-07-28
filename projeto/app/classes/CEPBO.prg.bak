*====================================================================
* CEPBO.prg
*
* Business Object para CEP (Cadastro de Enderecos Postais)
* Tabela principal: cep (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CEPBO AS BusinessBase

	*-- Propriedades da entidade (tabela: cep)
	this_cCidChaves   = ""   && cidchaves char(20)  - PK (ID unico gerado por fUniqueIds)
	this_cCeps        = ""   && ceps char(9)        - CEP (ex: 41820-610)
	this_cTipoNomes   = ""   && tiponomes char(15)  - Tipo de endereco (R, AV, TV, AL...)
	this_cNomes       = ""   && nomes char(72)      - Nome do endereco
	this_cBairros     = ""   && bairros char(72)    - Bairro
	this_cCidades     = ""   && cidades char(72)    - Cidade
	this_cEstados     = ""   && estados char(2)     - UF (sigla)
	this_cComples     = ""   && comples char(72)    - Complemento
	this_cNums        = ""   && nums char(11)       - Numero
	this_cTipoCeps    = ""   && tipoceps char(1)    - Tipo do CEP
	this_cBarCeps     = ""   && cBarCeps char(7)    - Codigo de barras CEP

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "cep"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de CEPs no cursor_4c_Dados
	* par_cFiltro: sigla da UF para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " ORDER BY Ceps"
			ELSE
				loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
				           " FROM Cep" + ;
				           " WHERE Estados = " + EscaparSQL(UPPER(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY Ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps" + ;
			           " FROM Cep" + ;
			           " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cCidChaves  = TratarNulo(cIdChaves,  "C")
			THIS.this_cCeps       = TratarNulo(Ceps,       "C")
			THIS.this_cTipoNomes  = TratarNulo(TipoNomes,  "C")
			THIS.this_cNomes      = TratarNulo(Nomes,      "C")
			THIS.this_cBairros    = TratarNulo(Bairros,    "C")
			THIS.this_cCidades    = TratarNulo(Cidades,    "C")
			THIS.this_cEstados    = TratarNulo(Estados,    "C")
			THIS.this_cComples    = TratarNulo(Comples,    "C")
			THIS.this_cNums       = TratarNulo(Nums,       "C")
			THIS.this_cTipoCeps   = TratarNulo(TipoCeps,   "C")
			THIS.this_cBarCeps    = TratarNulo(cBarCeps,   "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Gerar chave unica via SQL Server NEWID()
			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidChaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica para o CEP.", "Erro")
			ELSE
				loc_cSQL = "INSERT INTO Cep (cIdChaves, Ceps, TipoNomes, Nomes, Bairros, Cidades, Estados, Comples, Nums, cBarCeps, TipoCeps)" + ;
				           " VALUES (" + ;
				           EscaparSQL(THIS.this_cCidChaves) + "," + ;
				           EscaparSQL(THIS.this_cCeps)      + "," + ;
				           EscaparSQL(THIS.this_cTipoNomes) + "," + ;
				           EscaparSQL(THIS.this_cNomes)     + "," + ;
				           EscaparSQL(THIS.this_cBairros)   + "," + ;
				           EscaparSQL(THIS.this_cCidades)   + "," + ;
				           EscaparSQL(THIS.this_cEstados)   + "," + ;
				           EscaparSQL(THIS.this_cComples)   + "," + ;
				           EscaparSQL(THIS.this_cNums)      + "," + ;
				           EscaparSQL(THIS.this_cBarCeps)   + "," + ;
				           EscaparSQL(THIS.this_cTipoCeps)  + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela Cep
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE Cep SET" + ;
			           " Ceps       = " + EscaparSQL(THIS.this_cCeps)      + "," + ;
			           " TipoNomes  = " + EscaparSQL(THIS.this_cTipoNomes) + "," + ;
			           " Nomes      = " + EscaparSQL(THIS.this_cNomes)     + "," + ;
			           " Bairros    = " + EscaparSQL(THIS.this_cBairros)   + "," + ;
			           " Cidades    = " + EscaparSQL(THIS.this_cCidades)   + "," + ;
			           " Estados    = " + EscaparSQL(THIS.this_cEstados)   + "," + ;
			           " Comples    = " + EscaparSQL(THIS.this_cComples)   + "," + ;
			           " Nums       = " + EscaparSQL(THIS.this_cNums)      + "," + ;
			           " cBarCeps   = " + EscaparSQL(THIS.this_cBarCeps)   + "," + ;
			           " TipoCeps   = " + EscaparSQL(THIS.this_cTipoCeps)  + ;
			           " WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela Cep
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM Cep WHERE cIdChaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir CEP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir CEP:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
