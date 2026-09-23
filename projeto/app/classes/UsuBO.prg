*====================================================================
* UsuBO.prg
*
* Business Object para Usu (Cadastro de Usuarios)
* Tabela: SigCdUsu (PK: usuarios)
*====================================================================

DEFINE CLASS UsuBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUsu - docs/schema.sql)
	this_cSupervis                  = ""   && char(1)  NOT NULL
	this_cUsuarios                  = ""   && char(10) NOT NULL - PK
	this_cSenhas                    = ""   && char(10) NOT NULL
	this_cCCargs                    = ""   && char(10) NOT NULL
	this_cLimDescs                  = ""   && char(1)  NOT NULL
	this_cNComps                    = ""   && char(30) NOT NULL
	this_cDeptos                    = ""   && char(10) NOT NULL
	this_cLibPess                   = ""   && char(1)  NOT NULL
	this_cLibProds                  = ""   && char(1)  NOT NULL
	this_cSetores                   = ""   && char(10) NOT NULL
	this_cCAtivos                   = ""   && char(1)  NOT NULL
	this_cMBiodigs                  = ""   && text     NULL
	this_dTDtSenhas                 = {}   && datetime NULL
	this_cIClis                     = ""   && char(10) NOT NULL
	this_nObrigSenhas                = 0    && numeric(1,0) NOT NULL
	this_cLibQtMins                 = ""   && char(1)  NOT NULL
	this_cFigJpgSUser               = ""   && text     NULL

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigCdUsu"
			THIS.this_cCampoChave = "usuarios"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UsuBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cUsuarios)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de usuarios no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, setores, cativos, iclis" + ;
				           " FROM SigCdUsu ORDER BY usuarios"
			ELSE
				loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, setores, cativos, iclis" + ;
				           " FROM SigCdUsu" + ;
				           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY usuarios"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK = usuarios)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cUsuarios)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT supervis, usuarios, senhas, ccargs, limdescs," + ;
			           " ncomps, deptos, libpess, libprods, setores, cativos," + ;
			           " mbiodigs, tdtsenhas, iclis, obrigsenhas, libqtmins," + ;
			           " figjpgsuser" + ;
			           " FROM SigCdUsu" + ;
			           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(par_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cSupervis     = TratarNulo(supervis, "C")
			THIS.this_cUsuarios     = TratarNulo(usuarios, "C")
			THIS.this_cSenhas       = TratarNulo(senhas, "C")
			THIS.this_cCCargs       = TratarNulo(ccargs, "C")
			THIS.this_cLimDescs     = TratarNulo(limdescs, "C")
			THIS.this_cNComps       = TratarNulo(ncomps, "C")
			THIS.this_cDeptos       = TratarNulo(deptos, "C")
			THIS.this_cLibPess      = TratarNulo(libpess, "C")
			THIS.this_cLibProds     = TratarNulo(libprods, "C")
			THIS.this_cSetores      = TratarNulo(setores, "C")
			THIS.this_cCAtivos      = TratarNulo(cativos, "C")
			THIS.this_cMBiodigs     = TratarNulo(mbiodigs, "C")
			THIS.this_dTDtSenhas    = TratarNulo(tdtsenhas, {})
			THIS.this_cIClis        = TratarNulo(iclis, "C")
			THIS.this_nObrigSenhas  = TratarNulo(obrigsenhas, "N")
			THIS.this_cLibQtMins    = TratarNulo(libqtmins, "C")
			THIS.this_cFigJpgSUser  = TratarNulo(figjpgsuser, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdUsu" + ;
			           " (supervis, usuarios, senhas, ccargs, limdescs," + ;
			           " ncomps, deptos, libpess, libprods, setores," + ;
			           " cativos, mbiodigs, tdtsenhas, iclis, obrigsenhas," + ;
			           " libqtmins, figjpgsuser)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cSupervis) + "," + ;
			           EscaparSQL(THIS.this_cUsuarios) + "," + ;
			           EscaparSQL(THIS.this_cSenhas) + "," + ;
			           EscaparSQL(THIS.this_cCCargs) + "," + ;
			           EscaparSQL(THIS.this_cLimDescs) + "," + ;
			           EscaparSQL(THIS.this_cNComps) + "," + ;
			           EscaparSQL(THIS.this_cDeptos) + "," + ;
			           EscaparSQL(THIS.this_cLibPess) + "," + ;
			           EscaparSQL(THIS.this_cLibProds) + "," + ;
			           EscaparSQL(THIS.this_cSetores) + "," + ;
			           EscaparSQL(THIS.this_cCAtivos) + "," + ;
			           EscaparSQL(THIS.this_cMBiodigs) + "," + ;
			           FormatarDataSQL(THIS.this_dTDtSenhas) + "," + ;
			           EscaparSQL(THIS.this_cIClis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
			           EscaparSQL(THIS.this_cLibQtMins) + "," + ;
			           EscaparSQL(THIS.this_cFigJpgSUser) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdUsu SET" + ;
			           " supervis = " + EscaparSQL(THIS.this_cSupervis) + "," + ;
			           " senhas = " + EscaparSQL(THIS.this_cSenhas) + "," + ;
			           " ccargs = " + EscaparSQL(THIS.this_cCCargs) + "," + ;
			           " limdescs = " + EscaparSQL(THIS.this_cLimDescs) + "," + ;
			           " ncomps = " + EscaparSQL(THIS.this_cNComps) + "," + ;
			           " deptos = " + EscaparSQL(THIS.this_cDeptos) + "," + ;
			           " libpess = " + EscaparSQL(THIS.this_cLibPess) + "," + ;
			           " libprods = " + EscaparSQL(THIS.this_cLibProds) + "," + ;
			           " setores = " + EscaparSQL(THIS.this_cSetores) + "," + ;
			           " cativos = " + EscaparSQL(THIS.this_cCAtivos) + "," + ;
			           " mbiodigs = " + EscaparSQL(THIS.this_cMBiodigs) + "," + ;
			           " tdtsenhas = " + FormatarDataSQL(THIS.this_dTDtSenhas) + "," + ;
			           " iclis = " + EscaparSQL(THIS.this_cIClis) + "," + ;
			           " obrigsenhas = " + FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
			           " libqtmins = " + EscaparSQL(THIS.this_cLibQtMins) + "," + ;
			           " figjpgsuser = " + EscaparSQL(THIS.this_cFigJpgSUser) + ;
			           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(THIS.this_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdUsu WHERE RTRIM(usuarios) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
