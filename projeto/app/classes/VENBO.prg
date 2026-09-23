*====================================================================
* VENBO.prg
*
* Business Object para Vendedores
* Tabela principal: SigCdVen (codigo PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VENBO AS BusinessBase

	*-- Propriedades da entidade (SigCdVen)
	this_cCodigo    = ""   && codigo char(20)      - PK (codigo do vendedor)
	this_cEmps      = ""   && emps char(3)         - codigo da empresa/loja
	this_cGrupo     = ""   && gruvens char(10)     - grupo do vendedor
	this_cCodVens   = ""   && codvens char(10)     - codigo do vendedor (cliente)
	this_cNomeVen   = ""   && nomeven varchar(255) - nome do vendedor
	this_cUfs       = ""   && ufs char(2)          - estado
	this_dDtIni     = {}   && dtini datetime       - data inicial (NULL)
	this_dDtFin     = {}   && dtfin datetime       - data final (NULL)
	this_cSituas    = ""   && situas char(30)      - situacao
	this_cCargo     = ""   && cargo char(15)       - cargo
	this_nComis     = 0    && comis numeric(7,4)   - comissao %
	this_nSubsidio  = 0    && subsidio numeric(7,4) - subsidio %
	this_nPmeta     = 0    && pmeta numeric(7,4)   - meta %
	this_cFolga     = ""   && folga char(1)        - folga (S/N) - NOT NULL, sem campo na tela
	this_dDtAlts    = {}   && dtalts datetime      - data da ultima alteracao (NULL)
	this_cUsuAlts   = ""   && usualts char(10)     - usuario da ultima alteracao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdVen"
			THIS.this_cCampoChave = "codigo"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "VENBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo   = TratarNulo(codigo,   "")
				THIS.this_cEmps     = TratarNulo(emps,     "")
				THIS.this_cGrupo    = TratarNulo(gruvens,  "")
				THIS.this_cCodVens  = TratarNulo(codvens,  "")
				THIS.this_cNomeVen  = TratarNulo(nomeven,  "")
				THIS.this_cUfs      = TratarNulo(ufs,      "")
				THIS.this_dDtIni    = TratarNulo(dtini,    {})
				THIS.this_dDtFin    = TratarNulo(dtfin,    {})
				THIS.this_cSituas   = TratarNulo(situas,   "")
				THIS.this_cCargo    = TratarNulo(cargo,    "")
				THIS.this_nComis    = TratarNulo(comis,    0)
				THIS.this_nSubsidio = TratarNulo(subsidio, 0)
				THIS.this_nPmeta    = TratarNulo(pmeta,    0)
				THIS.this_cFolga    = TratarNulo(folga,    "")
				THIS.this_dDtAlts   = TratarNulo(dtalts,   {})
				THIS.this_cUsuAlts  = TratarNulo(usualts,  "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VENBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdVen (codigo, emps, gruvens, codvens, nomeven, ufs,
					dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga,
					dtalts, usualts)
				VALUES (
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<EscaparSQL(THIS.this_cEmps)>>,
					<<EscaparSQL(THIS.this_cGrupo)>>,
					<<EscaparSQL(THIS.this_cCodVens)>>,
					<<EscaparSQL(THIS.this_cNomeVen)>>,
					<<EscaparSQL(THIS.this_cUfs)>>,
					<<FormatarDataSQL(THIS.this_dDtIni)>>,
					<<FormatarDataSQL(THIS.this_dDtFin)>>,
					<<EscaparSQL(THIS.this_cSituas)>>,
					<<EscaparSQL(THIS.this_cCargo)>>,
					<<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					<<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					<<EscaparSQL(THIS.this_cFolga)>>,
					GETDATE(),
					<<EscaparSQL(gc_4c_UsuarioLogado)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VENBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdVen
				SET emps     = <<EscaparSQL(THIS.this_cEmps)>>,
					gruvens  = <<EscaparSQL(THIS.this_cGrupo)>>,
					codvens  = <<EscaparSQL(THIS.this_cCodVens)>>,
					nomeven  = <<EscaparSQL(THIS.this_cNomeVen)>>,
					ufs      = <<EscaparSQL(THIS.this_cUfs)>>,
					dtini    = <<FormatarDataSQL(THIS.this_dDtIni)>>,
					dtfin    = <<FormatarDataSQL(THIS.this_dDtFin)>>,
					situas   = <<EscaparSQL(THIS.this_cSituas)>>,
					cargo    = <<EscaparSQL(THIS.this_cCargo)>>,
					comis    = <<FormatarNumeroSQL(THIS.this_nComis, 4)>>,
					subsidio = <<FormatarNumeroSQL(THIS.this_nSubsidio, 4)>>,
					pmeta    = <<FormatarNumeroSQL(THIS.this_nPmeta, 4)>>,
					dtalts   = GETDATE(),
					usualts  = <<EscaparSQL(gc_4c_UsuarioLogado)>>
				WHERE codigo = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VENBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdVen
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdVen WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VENBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados espelhando as colunas do Grade legado
	* (Init: AddCursor lcQrycdVen + pColuna x11):
	* codigo, codvens, nome (SigCdUsu.ncomps), emps, empreg (SigCdCli.emps),
	* gruvens, dtini, dtfin, situas, cargo, usualts, dtalts
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigo C(20), codvens C(10), ;
						nome C(30), emps C(3), empreg C(3), gruvens C(10), ;
						dtini T, dtfin T, situas C(30), cargo C(15), ;
						usualts C(10), dtalts T)
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.codigo, a.codvens, ISNULL(b.ncomps,'') AS nome," + ;
					" a.emps, c.emps AS empreg, a.gruvens, a.dtini, a.dtfin," + ;
					" a.situas, a.cargo, a.usualts, a.dtalts" + ;
					" FROM SigCdVen a" + ;
					" LEFT JOIN SigCdUsu b ON a.codvens = b.usuarios" + ;
					" LEFT JOIN SigCdCli c ON a.gruvens = c.grupos AND a.codvens = c.iclis"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigo"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VENBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (codigo)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigo, emps, gruvens, codvens, nomeven, ufs," + ;
				" dtini, dtfin, situas, cargo, comis, subsidio, pmeta, folga," + ;
				" dtalts, usualts" + ;
				" FROM SigCdVen WHERE codigo = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Vendedor n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VENBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
