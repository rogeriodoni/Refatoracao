*====================================================================
* sigprpdfBO.prg
*
* Business Object para sigprpdf
* Tabela: 
*
* GERADO AUTOMATICAMENTE - Revisar e completar
*====================================================================

DEFINE CLASS sigprpdfBO AS BusinessBase

	*-- Propriedades da entidade

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		
		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "cods"
		
		RETURN .T.
	ENDPROC

	*====================================================================
	* Buscar - Busca registros no banco
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		
		TRY
			loc_cSQL = "SELECT  " + ;
					"FROM  " + ;
					"ORDER BY cods"
			
			IF !EMPTY(par_cFiltro)
				*-- TODO: Adicionar filtro ao SQL
			ENDIF
			
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao buscar dados"
				loc_lResultado = .F.
			ENDIF
			
		CATCH TO loException
			THIS.this_cMensagemErro = "Erro: " + loException.Message
			loc_lResultado = .F.
		ENDTRY
		
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega dados do cursor para propriedades
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.
		
		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF
		
		*-- CRITICO: SELECT antes de acessar campos
		SELECT (par_cAliasCursor)
		
		
		loc_lResultado = .T.
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		
		TRY
			loc_cSQL = "INSERT INTO  () " + ;
					"VALUES ("
			
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao inserir registro"
				loc_lResultado = .F.
			ENDIF
			
		CATCH TO loException
			THIS.this_cMensagemErro = "Erro: " + loException.Message
			loc_lResultado = .F.
		ENDTRY
		
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		
		TRY
			loc_cSQL = "UPDATE  SET "
			loc_cSQL = loc_cSQL + " WHERE cods = " + EscaparSQL(THIS.this_cCods)
			
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao atualizar registro"
				loc_lResultado = .F.
			ENDIF
			
		CATCH TO loException
			THIS.this_cMensagemErro = "Erro: " + loException.Message
			loc_lResultado = .F.
		ENDTRY
		
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCods
	ENDPROC

ENDDEFINE
