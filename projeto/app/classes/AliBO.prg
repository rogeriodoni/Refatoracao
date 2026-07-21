*====================================================================
* AliBO.prg
*
* Business Object para Alineas
* Tabela: SIGCDALI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS AliBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDALI)
	this_nCodigos    = 0    && codigos numeric(3,0) - PK
	this_cDescrs     = ""   && descrs char(40)
	this_cOpAutos    = ""   && opautos char(15) - FK SigCdOpt.Operacaos
	this_cOpSaidas   = ""   && opsaidas char(15) - FK SigCdOpt.Operacaos
	this_cFPagSAutos = ""   && fpagsautos char(12) - FK SigOpFp.Fpags
	this_nPefins     = 2    && pefins numeric(1,0) - 1=Sim, 2=Nao
	this_nReincids   = 0    && reincids numeric(4,2) - nao exibido no form

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDALI"
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
	* Buscar - Carrega lista de alineas no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " WHERE descrs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
			           " FROM SigCdAli" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_nCodigos    = TratarNulo(codigos, "N")
			THIS.this_cDescrs     = TratarNulo(descrs, "C")
			THIS.this_cOpAutos    = TratarNulo(opautos, "C")
			THIS.this_cOpSaidas   = TratarNulo(opsaidas, "C")
			THIS.this_cFPagSAutos = TratarNulo(fpagsautos, "C")
			THIS.this_nPefins     = TratarNulo(pefins, "N")
			THIS.this_nReincids   = TratarNulo(reincids, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdAli (codigos, descrs, opautos, opsaidas, fpagsautos, pefins)" + ;
			           " VALUES (" + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cDescrs) + "," + ;
			           EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPefins) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdAli SET" + ;
			           " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
			           " opautos = " + EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           " opsaidas = " + EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           " fpagsautos = " + EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           " pefins = " + FormatarNumeroSQL(THIS.this_nPefins) + ;
			           " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdAli WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
