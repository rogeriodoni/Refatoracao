*====================================================================
* ARVBO.prg
*
* Business Object para Tipos de Arvore
* Tabela: SigCdArv
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ARVBO AS BusinessBase

	*-- Propriedades da entidade (SigCdArv)
	this_cCodigos  = ""   && codigos  char - PK
	this_cDescs    = ""   && descs    char - Descricao
	this_cFormulas = ""   && formulas memo/char - Formula de calculo
	this_cTempMets = ""   && TempMets char(15) - Formula temperatura metal (Fundicao)
	this_cTempTubs = ""   && TempTubs char(15) - Formula temperatura tubo (Fundicao)
	this_cTempAmbs = ""   && TempAmbs char(15) - Formula temperatura ambiente (Revestimento)
	this_cTempagus = ""   && Tempagus char(15) - Formula temperatura agua (Revestimento)
	this_nPercs    = 0    && Percs    numeric(5,2) - Percentual metal novo

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdArv"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de arvore no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
				           " TempAmbs, Tempagus, Percs" + ;
				           " FROM SigCdArv" + ;
				           " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					CREATE CURSOR cursor_4c_Dados (codigos C(10), descs C(100), formulas M, ;
					    TempMets C(15), TempTubs C(15), TempAmbs C(15), Tempagus C(15), Percs N(5,2))
				ENDIF
				MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				CREATE CURSOR cursor_4c_Dados (codigos C(10), descs C(100), formulas M, ;
				    TempMets C(15), TempTubs C(15), TempAmbs C(15), Tempagus C(15), Percs N(5,2))
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descs, formulas, TempMets, TempTubs," + ;
			           " TempAmbs, Tempagus, Percs" + ;
			           " FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Tipo de " + CHR(225) + "rvore n" + CHR(227) + "o encontrado!", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos  = TratarNulo(codigos,  "C")
			THIS.this_cDescs    = TratarNulo(descs,    "C")
			THIS.this_cFormulas = TratarNulo(formulas, "C")
			THIS.this_cTempMets = TratarNulo(TempMets, "C")
			THIS.this_cTempTubs = TratarNulo(TempTubs, "C")
			THIS.this_cTempAmbs = TratarNulo(TempAmbs, "C")
			THIS.this_cTempagus = TratarNulo(Tempagus, "C")
			THIS.this_nPercs    = TratarNulo(Percs,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdArv" + ;
			           " (codigos, descs, formulas, TempMets, TempTubs, TempAmbs, Tempagus, Percs)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCodigos)  + "," + ;
			           EscaparSQL(THIS.this_cDescs)    + "," + ;
			           EscaparSQL(THIS.this_cFormulas) + "," + ;
			           EscaparSQL(THIS.this_cTempMets) + "," + ;
			           EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           EscaparSQL(THIS.this_cTempagus) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPercs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar())
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdArv SET" + ;
			           " descs    = " + EscaparSQL(THIS.this_cDescs)    + "," + ;
			           " formulas = " + EscaparSQL(THIS.this_cFormulas) + "," + ;
			           " TempMets = " + EscaparSQL(THIS.this_cTempMets) + "," + ;
			           " TempTubs = " + EscaparSQL(THIS.this_cTempTubs) + "," + ;
			           " TempAmbs = " + EscaparSQL(THIS.this_cTempAmbs) + "," + ;
			           " Tempagus = " + EscaparSQL(THIS.this_cTempagus) + "," + ;
			           " Percs    = " + FormatarNumeroSQL(THIS.this_nPercs) + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro (PROTECTED - chamado por Excluir())
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdArv" + ;
			           " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de " + CHR(225) + "rvore:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
