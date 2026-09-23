*====================================================================
* USABO.prg
*
* Business Object para USA (Usuarios Automaticos)
* Tabela: SigSyMov (PK: cidchaves)
*====================================================================

DEFINE CLASS USABO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigSyMov - docs/schema.sql)
	this_cCidChaves                 = ""   && char(20) - PK (fUniqueIds())
	this_cUsuars                    = ""   && char(10) - FK SigCdUsu.usuarios
	this_cDopes                     = ""   && char(20) - FK SigCdOpe.Dopes
	this_cEmps                      = ""   && char(3)  - FK SigCdEmp.Cemps

	*-- Propriedades de exibicao (NAO persistidas - vem do LEFT JOIN do legado)
	this_cNComps                    = ""   && SigCdUsu.ncomps  (nome do usuario)
	this_cRazas                     = ""   && SigCdEmp.razas   (razao social da empresa)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigSyMov"
			THIS.this_cCampoChave = "cidchaves"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "USABO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	* Colunas persistidas (cidchaves, usuars, dopes, emps) sempre existem;
	* ncomps/razas so existem quando o cursor veio de query com LEFT JOIN
	* (SigCdUsu/SigCdEmp), por isso o TYPE() antes de ler.
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cUsuars    = TratarNulo(usuars, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			THIS.this_cEmps      = TratarNulo(emps, "C")

			IF TYPE(par_cAliasCursor + ".ncomps") != "U"
				THIS.this_cNComps = TratarNulo(ncomps, "C")
			ENDIF
			IF TYPE(par_cAliasCursor + ".razas") != "U"
				THIS.this_cRazas = TratarNulo(razas, "C")
			ENDIF

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigSyMov
	* Todas as 4 colunas da tabela sao NOT NULL (docs/schema.sql) - cidchaves
	* eh a PK Fortyus, gerada aqui via fUniqueIds() quando ainda vazia.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigSyMov" + ;
					   " (cidchaves, usuars, dopes, emps)" + ;
					   " VALUES (" + ;
					   EscaparSQL(THIS.this_cCidChaves) + "," + ;
					   EscaparSQL(THIS.this_cUsuars) + "," + ;
					   EscaparSQL(THIS.this_cDopes) + "," + ;
					   EscaparSQL(THIS.this_cEmps) + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigSyMov (cidchaves nunca eh alterada)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigSyMov SET" + ;
					   " usuars = " + EscaparSQL(THIS.this_cUsuars) + "," + ;
					   " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
					   " emps = " + EscaparSQL(THIS.this_cEmps) + ;
					   " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - SELECT para a lista (Page1). Espelha o AddCursor/pColuna
	* do legado (Init): usuars, dopes, emps. cidchaves vai junto no cursor
	* (nao aparece no grid) para permitir Alterar/Excluir/Visualizar.
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), usuars C(10), dopes C(20), emps C(3))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT cidchaves, usuars, dopes, emps FROM SigSyMov"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY usuars"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao buscar usu" + CHR(225) + "rios autom" + CHR(225) + "ticos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "USABO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	* Traz tambem ncomps/razas (LEFT JOIN, igual ao legado) para exibicao
	* somente-leitura em Page2 (CarregarDoCursor ja testa TYPE antes de ler).
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.usuars, a.dopes, a.emps," + ;
				" b.ncomps, c.razas" + ;
				" FROM SigSyMov a" + ;
				" LEFT JOIN SigCdUsu b ON a.usuars = b.usuarios" + ;
				" LEFT JOIN SigCdEmp c ON a.emps = c.cemps" + ;
				" WHERE a.cidchaves = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Usu" + CHR(225) + "rio autom" + CHR(225) + "tico n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MsgErro("Erro ao carregar usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar:" + CHR(13) + loc_oErro.Message, "USABO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SigSyMov (chamado por Excluir())
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigSyMov WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir usu" + CHR(225) + "rio autom" + CHR(225) + "tico:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
