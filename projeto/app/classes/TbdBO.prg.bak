*====================================================================
* TbdBO.prg
*
* Business Object para Tabelas de Desconto por Operacao
* Tabela principal: SigCdTbd (cidchaves PK)
* Tabela pai: SigCdOpe (dopes) - Operacao a qual as tabelas pertencem
* Tabela de referencia (lookup): SigOpTdz (codigos) - Tabela de Desconto
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbdBO AS BusinessBase

	*-- Propriedades da entidade (SigCdTbd)
	this_cCodigos     = ""   && codigos char(10)   - codigo da tabela de desconto (FK SigOpTdz.codigos)
	this_cCidChaves   = ""   && cidchaves char(20) - PK (chave unica Fortyus)
	this_cDopes       = ""   && dopes char(20)     - codigo/descricao da operacao (FK SigCdOpe.dopes)

	*-- Propriedades locais (NAO persistem - apenas estado/UI)
	this_cDescOperacao = ""  && descricao da operacao exibida no cabecalho (= crSigCdOpe.Dopes)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdTbd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidChaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCodigos   = TratarNulo(codigos, "C")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cDopes     = TratarNulo(dopes, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, dopes" + ;
			           " FROM SigCdTbd" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cCidChaves)
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
			           " VALUES (" + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           EscaparSQL(THIS.this_cCidChaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdTbd SET" + ;
			           " codigos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigos), 10)) + "," + ;
			           " dopes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdTbd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarPorOperacao - Carrega TODAS as tabelas de desconto vinculadas
	* a uma operacao (Dopes), com a descricao da tabela (SigOpTdz.descrs).
	* Espelha o SELECT original do Init() legado:
	*   Select a.*, b.descrs From SigCdTbd a, SigOpTdz b
	*   Where a.Dopes = <dopes> And a.codigos = b.codigos
	* cursor_4c_Dados eh convertido para READWRITE (SQLEXEC gera cursor
	* somente-leitura) pois o grid permite Inserir/Excluir/editar linhas
	* localmente antes de Confirmar (SalvarPorOperacao).
	*====================================================================
	PROCEDURE BuscarPorOperacao(par_cDopes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT a.codigos AS codigos, a.cidchaves AS cidchaves," + ;
			           " a.dopes AS dopes, b.descrs AS descrs" + ;
			           " FROM SigCdTbd a INNER JOIN SigOpTdz b ON a.codigos = b.codigos" + ;
			           " WHERE RTRIM(a.dopes) = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
			           " ORDER BY a.codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
			IF loc_nResultado >= 0
				SELECT codigos, cidchaves, dopes, descrs ;
					FROM cursor_4c_DadosTmp ;
					INTO CURSOR cursor_4c_Dados READWRITE

				IF USED("cursor_4c_DadosTmp")
					USE IN cursor_4c_DadosTmp
				ENDIF

				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DadosTmp")
				USE IN cursor_4c_DadosTmp
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarPorOperacao - Grava a lista completa de tabelas de desconto
	* de uma operacao (Dopes), substituindo os registros existentes.
	* Espelha o cmdSair.Click original: Delete From SigCdTbd Where dopes = ?
	* seguido de Insert Into SigCdTbd para cada linha nao vazia do grid.
	* par_cAliasCursor: cursor com as linhas do grid (coluna codigos).
	*====================================================================
	PROCEDURE SalvarPorOperacao(par_cDopes, par_cAliasCursor)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidChaves

		loc_lSucesso = .F.

		IF !USED(par_cAliasCursor)
			THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + "o localizado"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigCdTbd WHERE RTRIM(dopes) = " + ;
			           EscaparSQL(ALLTRIM(par_cDopes))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir tabelas de desconto anteriores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.

				SELECT (par_cAliasCursor)
				SCAN WHILE loc_lSucesso
					IF !EMPTY(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")))
						loc_cCidChaves = LEFT(fUniqueIds(), 20)

						loc_cSQL = "INSERT INTO SigCdTbd (codigos, cidchaves, dopes)" + ;
						           " VALUES (" + ;
						           EscaparSQL(LEFT(ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos")), 10)) + "," + ;
						           EscaparSQL(loc_cCidChaves) + "," + ;
						           EscaparSQL(LEFT(ALLTRIM(par_cDopes), 20)) + ;
						           ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("Erro ao gravar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ELSE
							THIS.this_cCidChaves = loc_cCidChaves
							THIS.this_cCodigos   = ALLTRIM(EVALUATE(par_cAliasCursor + ".codigos"))
							THIS.this_cDopes     = ALLTRIM(par_cDopes)
							THIS.RegistrarAuditoria("INSERT")
						ENDIF
					ENDIF
				ENDSCAN

				SELECT (par_cAliasCursor)
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gravar tabelas de desconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se ha codigos de tabela duplicados
	* no cursor do grid (espelha a checagem do cmdSair.Click original):
	*   Select Codigos, Sum(1) as Qt From xOpe Group by 1
	*   Into Cursor Selecao where codigos <> ' ' having Sum(1) > 1
	*====================================================================
	FUNCTION VerificarDuplicidade(par_cAliasCursor)
		LOCAL loc_lDuplicado

		loc_lDuplicado = .F.

		IF !USED(par_cAliasCursor)
			RETURN .F.
		ENDIF

		IF USED("cursor_4c_Duplicados")
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT codigos, COUNT(*) AS Qt FROM (par_cAliasCursor) ;
			WHERE ALLTRIM(codigos) <> "" ;
			GROUP BY codigos ;
			HAVING COUNT(*) > 1 ;
			INTO CURSOR cursor_4c_Duplicados

		IF USED("cursor_4c_Duplicados")
			IF RECCOUNT("cursor_4c_Duplicados") > 0
				loc_lDuplicado = .T.
			ENDIF
			USE IN cursor_4c_Duplicados
		ENDIF

		SELECT (par_cAliasCursor)

		RETURN loc_lDuplicado
	ENDFUNC

ENDDEFINE
