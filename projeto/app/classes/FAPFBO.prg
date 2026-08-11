*====================================================================
* FAPFBO.prg
*
* Business Object para FAPF
* Form OPERACIONAL - formulario sem tabela propria no banco
*====================================================================

DEFINE CLASS FAPFBO AS BusinessBase

	*-- Identificacao da entidade (sem tabela propria - form operacional)
	this_cTabela      = ""
	this_cCampoChave  = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = ""

		RETURN .T.
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Form operacional sem campos - sempre valido
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega dados do cursor para propriedades
	* Sem campos mapeados neste form operacional
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			IF !USED(par_cAliasCursor)
				loc_lResultado = .F.
			ENDIF

			SELECT (par_cAliasCursor)
			loc_lResultado = .T.

		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, ;
				"Erro em CarregarDoCursor")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("INSERT")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			*-- Registra auditoria da operacao (padrao arquitetural)
			THIS.RegistrarAuditoria("UPDATE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Executa exclusao de registro
	* Form operacional sem tabela - sem persistencia SQL
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_oErro
		loc_lResultado = .F.

		TRY
			*-- Form operacional sem tabela propria
			THIS.RegistrarAuditoria("DELETE")
			loc_lResultado = .T.

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	* Sem chave primaria neste form operacional
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ""
	ENDPROC

ENDDEFINE
