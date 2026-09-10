*====================================================================
* TPDBO.prg
*
* Business Object para Tipos de Documentos
* Tabela principal: SigCdTpD (pkchave PK tecnica, codigos chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TPDBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTpD)
	this_cPkchave = ""   && pkchave char(20)   - PK tecnica (UUID fUniqueIds)
	this_cCodigos = ""   && codigos char(2)    - codigo do tipo de documento
	this_cDescs   = ""   && descs   char(30)   - descricao do tipo de documento
	this_nTipos   = 0    && tipos   numeric(1,0) - obrigatoriedade nota fiscal (1=Obrigatorio, 2=Nao, 3=Obrigatorio/Permite Duplicados, 4=Nao/Permite Duplicados)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTpD"
		THIS.this_cCampoChave = "pkchave"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	* (usa o codigo de negocio - Codigos - e nao a PK tecnica/UUID)
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de documentos no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descs FROM SigCdTpD ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descs FROM SigCdTpD" + ;
				           " WHERE RTRIM(codigos) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tipos de documentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de documentos:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo de negocio (Codigos)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigos)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT pkchave, codigos, descs, tipos" + ;
			           " FROM SigCdTpD" + ;
			           " WHERE RTRIM(codigos) = " + EscaparSQL(ALLTRIM(par_cCodigos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de documento:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cPkchave = TratarNulo(pkchave, "C")
			THIS.this_cCodigos = TratarNulo(codigos, "C")
			THIS.this_cDescs   = TratarNulo(descs, "C")
			THIS.this_nTipos   = TratarNulo(tipos, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTpD
	* Replica a validacao do legado: bloqueia Codigos duplicado antes de
	* gravar e gera a PK tecnica (pkchave) via fUniqueIds(), igual ao
	* "Replace pkchave With fUniqueIds() in crSigCdTpD" do form original.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChave, loc_lDuplicado
		loc_lSucesso   = .F.
		loc_lDuplicado = .F.

		TRY
			*-- 1. Verifica duplicidade de codigo (Select Codigos From SigCdTpD Where Codigos = ...)
			loc_cSQL = "SELECT codigos FROM SigCdTpD" + ;
			           " WHERE RTRIM(codigos) = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaDup")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerificaDup") > 0
				loc_lDuplicado = .T.
				MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
			ENDIF

			IF USED("cursor_4c_VerificaDup")
				USE IN cursor_4c_VerificaDup
			ENDIF

			IF !loc_lDuplicado
				*-- 2. Gera PK tecnica (equivalente a fUniqueIds() do legado)
				loc_cPkChave = LEFT(fUniqueIds(), 20)

				loc_cSQL = "INSERT INTO SigCdTpD (pkchave, codigos, descs, tipos)" + ;
				           " VALUES (" + ;
				           EscaparSQL(loc_cPkChave) + "," + ;
				           EscaparSQL(THIS.this_cCodigos) + "," + ;
				           EscaparSQL(THIS.this_cDescs) + "," + ;
				           FormatarNumeroSQL(THIS.this_nTipos) + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado >= 0
					THIS.this_cPkchave = loc_cPkChave
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir tipo de documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de documento:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_VerificaDup")
				USE IN cursor_4c_VerificaDup
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTpD
	* Codigos NAO e alterado (campo desabilitado no modo ALTERAR no
	* legado - Valid/When de getCodigos so libera INSERIR/PROCURAR) -
	* usa a PK tecnica (pkchave) na clausula WHERE.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTpD SET" + ;
			           " descs = " + EscaparSQL(THIS.this_cDescs) + "," + ;
			           " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
			           " WHERE RTRIM(pkchave) = " + EscaparSQL(ALLTRIM(THIS.this_cPkchave))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de documento:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SigCdTpD (pela PK tecnica)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTpD WHERE RTRIM(pkchave) = " + EscaparSQL(ALLTRIM(THIS.this_cPkchave))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de documento:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
