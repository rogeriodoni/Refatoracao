*====================================================================
* TriBO.prg
*
* Business Object para Tributacao de Icms
* Tabela principal: SigCdIcm (codigos PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TriBO AS BusinessBase

	*-- Propriedades da entidade (SigCdIcm)
	this_cCodigos     = ""   && codigos char(3)     - PK (codigo da tributacao)
	this_cColunas     = ""   && colunas char(1)     - coluna do livro fiscal (numerico gravado como char, 1 a 3)
	this_cDescricaos  = ""   && descricaos char(40) - descricao
	this_cTipos       = ""   && tipos char(1)       - tipo (T/S/I/N/F)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdIcm"
			THIS.this_cCampoChave = "codigos"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "TriBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigos)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigos    = TratarNulo(codigos,    "C")
				THIS.this_cColunas    = TratarNulo(colunas,    "C")
				THIS.this_cDescricaos = TratarNulo(descricaos, "C")
				THIS.this_cTipos      = TratarNulo(tipos,      "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TriBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Replica as validacoes do PROCEDURE Pagina.Dados.Grupo_Salva.Salva.Click
	* do legado: codigo obrigatorio, codigo duplicado (so no INSERIR),
	* descricao obrigatoria, coluna entre 1 e 3.
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cCodigos)
			MsgAviso("C" + CHR(243) + "digo em branco !!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
				MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado !!!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND EMPTY(THIS.this_cDescricaos)
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o em branco !!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !BETWEEN(VAL(THIS.this_cColunas), 1, 3)
			MsgAviso("Coluna Inv" + CHR(225) + "lida, Permitido Apenas Valores 1,2 ou 3.")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se codigos ja existe no banco
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdIcm" + ;
				" WHERE codigos = " + EscaparSQL(par_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TriBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdIcm
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdIcm (codigos, colunas, descricaos, tipos)
				VALUES (
					<<EscaparSQL(THIS.this_cCodigos)>>,
					<<EscaparSQL(THIS.this_cColunas)>>,
					<<EscaparSQL(THIS.this_cDescricaos)>>,
					<<EscaparSQL(THIS.this_cTipos)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir tributa" + CHR(231) + CHR(227) + "o de icms:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TriBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdIcm
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdIcm
				SET colunas    = <<EscaparSQL(THIS.this_cColunas)>>,
					descricaos = <<EscaparSQL(THIS.this_cDescricaos)>>,
					tipos      = <<EscaparSQL(THIS.this_cTipos)>>
				WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar tributa" + CHR(231) + CHR(227) + "o de icms:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TriBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdIcm
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdIcm WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir tributa" + CHR(231) + CHR(227) + "o de icms:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TriBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com codigos, descricaos, colunas, tipos
	* (ordem das colunas do Grid legado: Codigo, Descricao, Coluna, Tipo)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigos C(3), descricaos C(40), colunas C(1), tipos C(1))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT codigos, descricaos, colunas, tipos FROM SigCdIcm"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY codigos"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar tributa" + CHR(231) + CHR(245) + "es de icms:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TriBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, colunas, descricaos, tipos" + ;
				" FROM SigCdIcm WHERE codigos = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Tributa" + CHR(231) + CHR(227) + "o de Icms n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar tributa" + CHR(231) + CHR(227) + "o de icms:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TriBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
