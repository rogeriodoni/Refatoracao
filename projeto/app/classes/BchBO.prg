*====================================================================
* BchBO.prg
*
* Business Object para Balanco de Cheques
* Tabela: SigCdBch
* PK: Codigos (numeric 6,0)
*
* Colunas (schema.sql):
*   operacaos  char(15)      NOT NULL
*   codigos    numeric(6,0)  NOT NULL  <- PK
*   datafims   datetime      NULL
*   datainis   datetime      NULL
*   encerras   bit           NOT NULL
*   tipos      numeric(1,0)  NOT NULL
*   grupos     char(10)      NOT NULL
*   contas     char(10)      NOT NULL
*   grvs       bit           NOT NULL
*====================================================================

DEFINE CLASS BchBO AS BusinessBase

	*-- Propriedades da tabela SigCdBch
	this_nCodigos  = 0
	this_cOperacaos = ""
	this_dDataInis = {}
	this_dDataFims = {}
	this_lEncerras = .F.
	this_nTipos    = 0
	this_cGrupos   = ""
	this_cContas   = ""
	this_lGrvs     = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdBch"
			THIS.this_cCampoChave = "Codigos"
			loc_lResultado = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Busca registros de SigCdBch
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch" + loc_cWhere + " ORDER BY codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros de Balan" + CHR(231) + "o de Cheques: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_nCodigos   = TratarNulo(codigos,   "N")
				THIS.this_cOperacaos = TratarNulo(operacaos, "C")
				THIS.this_dDataInis  = TratarNulo(datainis,  "D")
				THIS.this_dDataFims  = TratarNulo(datafims,  "D")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				THIS.this_cGrupos    = TratarNulo(grupos,    "C")
				THIS.this_cContas    = TratarNulo(contas,    "C")
				THIS.this_lEncerras  = ConverterParaLogico(encerras)
				THIS.this_lGrvs      = ConverterParaLogico(grvs)
				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nNovoCodigo
		loc_lResultado = .F.

		TRY
			*-- Gerar novo codigo (PK)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT ISNULL(MAX(codigos),0)+1 AS proximo FROM SigCdBch", ;
				"cursor_4c_ProxCod")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nNovoCodigo = proximo
			ELSE
				loc_nNovoCodigo = 1
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF

			THIS.this_nCodigos = loc_nNovoCodigo

			loc_cSQL = "INSERT INTO SigCdBch" + ;
					   " (codigos, operacaos, datainis, datafims, tipos," + ;
					   "  grupos, contas, encerras, grvs)" + ;
					   " VALUES (" + ;
					   FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   IIF(THIS.this_lGrvs, "1", "0") + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET" + ;
					   " operacaos = " + EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   " datainis  = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   " datafims  = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   " tipos     = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   " grupos    = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   " contas    = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   " encerras  = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   " grvs      = " + IIF(THIS.this_lGrvs, "1", "0") + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdBch
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
					"vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			THIS.RegistrarAuditoria("DELETE")

			loc_cSQL = "DELETE FROM SigCdBch WHERE codigos = " + ;
					   FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* EncerrarBalanco - Encerra o balanco de cheques (DataFims + Encerras=.T.)
	*====================================================================
	PROCEDURE EncerrarBalanco()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("Balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "UPDATE SigCdBch SET datafims = GETDATE(), encerras = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lEncerras = .T.
				THIS.this_dDataFims = DATE()
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao encerrar balan" + CHR(231) + "o: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* MarcarGravado - Define Grvs=1 em SigCdBch apos gravar leitura
	*====================================================================
	PROCEDURE MarcarGravado()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET grvs = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lGrvs = .T.
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao marcar gravado: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE
