*====================================================================
* UpdBO.prg
*
* Business Object para Upd (Cadastro de Unidade Produtiva)
* Tabela: SigCdUpd (PK: cidchaves - Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UpdBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUpd - docs/schema.sql)
	this_cIdChaves          = ""   && cidchaves char(20) - PK (Fortyus)
	this_cCodigo             = ""   && codigos   char(10) - Fase (FK SigCdGcr.Codigos)
	this_nDiasSemana         = 0    && ddsems    numeric(1,0) - Dias por Semana (0-7)
	this_nHorasDia           = 0    && hordds    numeric(4,2) - Horas Por Dia
	this_cUnidadeProdutiva   = ""   && uniprdts  char(10) - Unidade Produtiva
	this_nOrdem              = 0    && ordems    numeric(2,0) - Ordem no Mapa
	this_nQuantidade         = 0    && qtdes     numeric(2,0) - Quantidade

	*-- Propriedade de exibicao (NAO existe em SigCdUpd - vem do JOIN com
	*-- SigCdGcr.Descrs em Buscar()/CarregarPorCodigo(); NUNCA gravar esta
	*-- coluna em Inserir/Atualizar, pois SigCdUpd nao tem campo descrs)
	this_cDescricaoFase      = ""   && SigCdGcr.descrs (JOIN, somente leitura)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdUpd"
			THIS.this_cCampoChave = "cidchaves"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UpdBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cIdChaves)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	* this_cDescricaoFase vem do JOIN com SigCdGcr.Descrs (somente leitura)
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cIdChaves         = TratarNulo(cidchaves, "C")
				THIS.this_cCodigo           = TratarNulo(codigos,   "C")
				THIS.this_nDiasSemana       = TratarNulo(ddsems,    "N")
				THIS.this_nHorasDia         = TratarNulo(hordds,    "N")
				THIS.this_cUnidadeProdutiva = TratarNulo(uniprdts,  "C")
				THIS.this_nOrdem            = TratarNulo(ordems,    "N")
				THIS.this_nQuantidade       = TratarNulo(qtdes,     "N")
				THIS.this_cDescricaoFase    = TratarNulo(descrs,    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UpdBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado (Pagina.Dados.Grupo_Salva.Salva.Click):
	* - Codigo (Fase) obrigatorio
	* - Duplicidade Codigos+UniPrdts bloqueada SOMENTE na INCLUSAO
	* Transcrito do legado (get_ddf.Valid): Dias por Semana entre 0 e 7
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cCodigo))
			THIS.this_cMensagemErro = "C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!"
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND (THIS.this_nDiasSemana < 0 OR THIS.this_nDiasSemana > 7)
			THIS.this_cMensagemErro = "A Semana s" + CHR(243) + " pode ter no m" + CHR(225) + "ximo 7 dias..."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarUnidadeExistente(THIS.this_cCodigo, THIS.this_cUnidadeProdutiva)
				THIS.this_cMensagemErro = "Unidade J" + CHR(225) + " Cadastrada!!!"
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarUnidadeExistente - Verifica se ja existe registro com o
	* mesmo par Codigos+UniPrdts (transcrito de Salva.Click, ramo INSERIR)
	*====================================================================
	PROCEDURE VerificarUnidadeExistente(par_cCodigo, par_cUnidade)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUpd" + ;
				" WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
				" AND uniprdts = " + EscaparSQL(par_cUnidade)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUpd")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUpd")
				SELECT cursor_4c_ChkUpd
				loc_lExiste = (cursor_4c_ChkUpd.qtd > 0)
				USE IN cursor_4c_ChkUpd
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar unidade:" + CHR(13) + loException.Message, "UpdBO.VerificarUnidadeExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUpd
	* cidchaves (PK Fortyus) gerado via fUniqueIds() se nao vier preenchido
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(THIS.this_cIdChaves)
				THIS.this_cIdChaves = fUniqueIds()
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUpd (cidchaves, codigos, ddsems, hordds, uniprdts, ordems, qtdes)
				VALUES (
					<<EscaparSQL(THIS.this_cIdChaves)>>,
					<<EscaparSQL(THIS.this_cCodigo)>>,
					<<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					<<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					<<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UpdBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd
				SET codigos  = <<EscaparSQL(THIS.this_cCodigo)>>,
					ddsems   = <<FormatarNumeroSQL(THIS.this_nDiasSemana, 0)>>,
					hordds   = <<FormatarNumeroSQL(THIS.this_nHorasDia, 2)>>,
					uniprdts = <<EscaparSQL(THIS.this_cUnidadeProdutiva)>>,
					ordems   = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>,
					qtdes    = <<FormatarNumeroSQL(THIS.this_nQuantidade, 0)>>
				WHERE cidchaves = <<EscaparSQL(THIS.this_cIdChaves)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UpdBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* DepoisDeGravar - Transcrito de Salva.Click (apos DoDefault()):
	* o legado sincroniza Ordems em TODAS as unidades produtivas da MESMA
	* Fase (Codigos), nao so no registro corrente - Ordem eh atributo da
	* Fase, exibido/editado em cada unidade mas compartilhado entre elas.
	*====================================================================
	PROTECTED PROCEDURE DepoisDeGravar()
		LOCAL loc_cSQL
		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUpd SET ordems = <<FormatarNumeroSQL(THIS.this_nOrdem, 0)>>
				WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
			ENDTEXT
			SQLEXEC(gnConnHandle, loc_cSQL)
		CATCH TO loException
			MostrarErro("Erro ao sincronizar ordem:" + CHR(13) + loException.Message, "UpdBO.DepoisDeGravar")
		ENDTRY
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUpd
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdUpd WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao excluir unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UpdBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Transcrito de PROCEDURE Init:
	*   Select a.*, b.Descrs From SigCdUpd a Inner Join SigCdGcr b
	*     on a.Codigos = b.Codigos
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Codigos="Fase", UniPrdts="Unid. Produtiva", Descrs="Descricao",
	*  Ordems="Ordem")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(10), uniprdts C(10), descrs C(40), ordems N(2,0), ddsems N(1,0), hordds N(4,2), qtdes N(2,0))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs," + ;
					" a.ordems, a.ddsems, a.hordds, a.qtdes" + ;
					" FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY a.codigos, a.uniprdts"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar unidades produtivas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UpdBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT a.cidchaves, a.codigos, a.uniprdts, b.descrs,
					a.ordems, a.ddsems, a.hordds, a.qtdes
				FROM SigCdUpd a INNER JOIN SigCdGcr b ON a.codigos = b.codigos
				WHERE a.cidchaves = <<EscaparSQL(par_cCodigo)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Unidade produtiva n" + CHR(227) + "o encontrada!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar unidade produtiva:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UpdBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
