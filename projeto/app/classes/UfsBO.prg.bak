*====================================================================
* UfsBO.prg
*
* Business Object para Ufs (Cadastro de Estados)
* Tabela: SigCdUfs (PK: estados)
*====================================================================

DEFINE CLASS UfsBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUfs - docs/schema.sql)
	this_cEstados                   = ""   && char(2)  - PK
	this_cDescrs                    = ""   && char(40)
	this_nAicms                     = 0    && numeric(9,2)
	this_nBicms                     = 0    && numeric(9,2)
	this_nAreduzidas                = 0    && numeric(9,2)
	this_cIpis                      = ""   && char(1)
	this_nGer60D                    = 0    && numeric(1,0)
	this_nGer60I                    = 0    && numeric(1,0)
	this_nGer60R                    = 0    && numeric(1,0)
	this_nGer74                     = 0    && numeric(1,0)
	this_nGer75                     = 0    && numeric(1,0)
	this_nGer77                     = 0    && numeric(1,0)
	this_nGerSefaz                  = 0    && numeric(1,0)
	this_nGer50                     = 0    && numeric(1,0)
	this_nGer51                     = 0    && numeric(1,0)
	this_nGer54                     = 0    && numeric(1,0)
	this_nGer60                     = 0    && numeric(1,0)
	this_nGer61                     = 0    && numeric(1,0)
	this_nGer70                     = 0    && numeric(1,0)
	this_nGer88                     = 0    && numeric(1,0)
	this_nAliqsbs                   = 0    && numeric(9,2)
	this_nGer53                     = 0    && numeric(1,0)
	this_nNgersufr1s                = 0    && int
	this_nGerncm                    = 0    && numeric(1,0)
	this_nCodidents                 = 0    && numeric(1,0)
	this_nGer60P                    = 0    && numeric(1,0)
	this_nNcotepe52s                = 0    && int
	this_nGer88ms                   = 0    && numeric(1,0)
	this_nUFIBGEs                   = 0    && numeric(2,0)
	this_cLayoutnf                  = ""   && char(20)
	this_nChkgnre                   = 0    && numeric(1,0)
	this_cChaveConsultaHomologacao  = ""   && char(80)
	this_cChaveConsultaProducao     = ""   && char(80)
	this_cHomologacao               = ""   && char(80)
	this_cProducao                  = ""   && char(80)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigCdUfs"
			THIS.this_cCampoChave = "estados"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UfsBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cEstados)
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
				THIS.this_cEstados                  = TratarNulo(estados,                   "C")
				THIS.this_cDescrs                   = TratarNulo(descrs,                    "C")
				THIS.this_nAicms                    = TratarNulo(aicms,                      "N")
				THIS.this_nBicms                    = TratarNulo(bicms,                      "N")
				THIS.this_nAreduzidas                = TratarNulo(areduzidas,                "N")
				THIS.this_cIpis                     = TratarNulo(ipis,                       "C")
				THIS.this_nGer60D                   = TratarNulo(ger60d,                     "N")
				THIS.this_nGer60I                   = TratarNulo(ger60i,                     "N")
				THIS.this_nGer60R                   = TratarNulo(ger60r,                     "N")
				THIS.this_nGer74                    = TratarNulo(ger74,                      "N")
				THIS.this_nGer75                    = TratarNulo(ger75,                      "N")
				THIS.this_nGer77                    = TratarNulo(ger77,                      "N")
				THIS.this_nGerSefaz                 = TratarNulo(gersefaz,                   "N")
				THIS.this_nGer50                    = TratarNulo(ger50,                      "N")
				THIS.this_nGer51                    = TratarNulo(ger51,                      "N")
				THIS.this_nGer54                    = TratarNulo(ger54,                      "N")
				THIS.this_nGer60                    = TratarNulo(ger60,                      "N")
				THIS.this_nGer61                    = TratarNulo(ger61,                      "N")
				THIS.this_nGer70                    = TratarNulo(ger70,                      "N")
				THIS.this_nGer88                    = TratarNulo(ger88,                      "N")
				THIS.this_nAliqsbs                  = TratarNulo(aliqsbs,                    "N")
				THIS.this_nGer53                    = TratarNulo(ger53,                      "N")
				THIS.this_nNgersufr1s                = TratarNulo(ngersufr1s,                "N")
				THIS.this_nGerncm                   = TratarNulo(gerncm,                     "N")
				THIS.this_nCodidents                = TratarNulo(codidents,                  "N")
				THIS.this_nGer60P                   = TratarNulo(ger60p,                     "N")
				THIS.this_nNcotepe52s                = TratarNulo(ncotepe52s,                "N")
				THIS.this_nGer88ms                  = TratarNulo(ger88ms,                    "N")
				THIS.this_nUFIBGEs                  = TratarNulo(UFIBGEs,                    "N")
				THIS.this_cLayoutnf                 = TratarNulo(layoutnf,                   "C")
				THIS.this_nChkgnre                  = TratarNulo(chkgnre,                    "N")
				THIS.this_cChaveConsultaHomologacao = TratarNulo(ChaveConsultaHomologacao,    "C")
				THIS.this_cChaveConsultaProducao    = TratarNulo(ChaveConsultaProducao,       "C")
				THIS.this_cHomologacao              = TratarNulo(Homologacao,                 "C")
				THIS.this_cProducao                 = TratarNulo(Producao,                    "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfsBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Transcrito do legado: getEstado nao pode ficar vazio; UF duplicada
	* so eh bloqueada na INCLUSAO (Salva.Click, SigCdUfs_form_codigo_fonte.txt)
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cEstados)
			THIS.this_cMensagemErro = "U.F. Inv" + CHR(225) + "lido."
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cEstados)
				THIS.this_cMensagemErro = "U.F. J" + CHR(225) + " Cadastrado."
				loc_lValido = .F.
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se estados ja existe no banco
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUfs" + ;
				" WHERE estados = " + EscaparSQL(par_cEstados)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
				SELECT cursor_4c_ChkCod
				loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
				USE IN cursor_4c_ChkCod
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar U.F.:" + CHR(13) + loException.Message, "UfsBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigCdUfs (
					estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				)
				VALUES (
					<<EscaparSQL(THIS.this_cEstados)>>,
					<<EscaparSQL(THIS.this_cDescrs)>>,
					<<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					<<EscaparSQL(THIS.this_cIpis)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					<<EscaparSQL(THIS.this_cLayoutnf)>>,
					<<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					<<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					<<EscaparSQL(THIS.this_cHomologacao)>>,
					<<EscaparSQL(THIS.this_cProducao)>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfsBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdUfs
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdUfs
				SET descrs      = <<EscaparSQL(THIS.this_cDescrs)>>,
					aicms       = <<FormatarNumeroSQL(THIS.this_nAicms, 2)>>,
					bicms       = <<FormatarNumeroSQL(THIS.this_nBicms, 2)>>,
					areduzidas  = <<FormatarNumeroSQL(THIS.this_nAreduzidas, 2)>>,
					ipis        = <<EscaparSQL(THIS.this_cIpis)>>,
					ger60d      = <<FormatarNumeroSQL(THIS.this_nGer60D, 0)>>,
					ger60i      = <<FormatarNumeroSQL(THIS.this_nGer60I, 0)>>,
					ger60r      = <<FormatarNumeroSQL(THIS.this_nGer60R, 0)>>,
					ger74       = <<FormatarNumeroSQL(THIS.this_nGer74, 0)>>,
					ger75       = <<FormatarNumeroSQL(THIS.this_nGer75, 0)>>,
					ger77       = <<FormatarNumeroSQL(THIS.this_nGer77, 0)>>,
					gersefaz    = <<FormatarNumeroSQL(THIS.this_nGerSefaz, 0)>>,
					ger50       = <<FormatarNumeroSQL(THIS.this_nGer50, 0)>>,
					ger51       = <<FormatarNumeroSQL(THIS.this_nGer51, 0)>>,
					ger54       = <<FormatarNumeroSQL(THIS.this_nGer54, 0)>>,
					ger60       = <<FormatarNumeroSQL(THIS.this_nGer60, 0)>>,
					ger61       = <<FormatarNumeroSQL(THIS.this_nGer61, 0)>>,
					ger70       = <<FormatarNumeroSQL(THIS.this_nGer70, 0)>>,
					ger88       = <<FormatarNumeroSQL(THIS.this_nGer88, 0)>>,
					aliqsbs     = <<FormatarNumeroSQL(THIS.this_nAliqsbs, 2)>>,
					ger53       = <<FormatarNumeroSQL(THIS.this_nGer53, 0)>>,
					ngersufr1s  = <<FormatarNumeroSQL(THIS.this_nNgersufr1s, 0)>>,
					gerncm      = <<FormatarNumeroSQL(THIS.this_nGerncm, 0)>>,
					codidents   = <<FormatarNumeroSQL(THIS.this_nCodidents, 0)>>,
					ger60p      = <<FormatarNumeroSQL(THIS.this_nGer60P, 0)>>,
					ncotepe52s  = <<FormatarNumeroSQL(THIS.this_nNcotepe52s, 0)>>,
					ger88ms     = <<FormatarNumeroSQL(THIS.this_nGer88ms, 0)>>,
					UFIBGEs     = <<FormatarNumeroSQL(THIS.this_nUFIBGEs, 0)>>,
					layoutnf    = <<EscaparSQL(THIS.this_cLayoutnf)>>,
					chkgnre     = <<FormatarNumeroSQL(THIS.this_nChkgnre, 0)>>,
					ChaveConsultaHomologacao = <<EscaparSQL(THIS.this_cChaveConsultaHomologacao)>>,
					ChaveConsultaProducao    = <<EscaparSQL(THIS.this_cChaveConsultaProducao)>>,
					Homologacao = <<EscaparSQL(THIS.this_cHomologacao)>>,
					Producao    = <<EscaparSQL(THIS.this_cProducao)>>
				WHERE estados = <<EscaparSQL(THIS.this_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfsBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro da tabela SigCdUfs
	* Transcrito do legado (Salva.Click, ramo EXCLUIR): bloqueia exclusao
	* se a UF estiver em uso em SigCdCli.estas, SigCdCee.estas ou SigCdCll.estas
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
		loc_lSucesso = .F.
		loc_nUso     = 0

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT CASE WHEN
					EXISTS (SELECT 1 FROM SigCdCli WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCee WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>) OR
					EXISTS (SELECT 1 FROM SigCdCll WHERE estas = <<EscaparSQL(THIS.this_cEstados)>>)
				THEN 1 ELSE 0 END AS nUso
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUfs")

			IF loc_nResultado < 0
				MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ChkUfs")
					SELECT cursor_4c_ChkUfs
					loc_nUso = NVL(cursor_4c_ChkUfs.nUso, 0)
					USE IN cursor_4c_ChkUfs
				ENDIF

				IF loc_nUso > 0
					THIS.this_cMensagemErro = "Estado n" + CHR(227) + "o pode ser exclu" + CHR(237) + ;
						"do pois est" + CHR(225) + " sendo usado em Clientes!"
				ELSE
					loc_cSQL = "DELETE FROM SigCdUfs WHERE estados = " + EscaparSQL(THIS.this_cEstados)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "UfsBO.ExecutarExclusao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com as colunas da grade do legado
	* (Estados, descrs, aicms, bicms, areduzidas, AliqSbs - PROCEDURE Init)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (estados C(2), descrs C(40), aicms N(9,2), bicms N(9,2), areduzidas N(9,2), aliqsbs N(9,2))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT estados, descrs, aicms, bicms, areduzidas, aliqsbs FROM SigCdUfs"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY estados"

				IF USED("cursor_4c_Dados")
					USE IN cursor_4c_Dados
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
				IF loc_nResultado >= 0
					loc_lSucesso = .T.
				ELSE
					MostrarErro("Erro ao buscar estados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfsBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (estados)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cEstados)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT estados, descrs, aicms, bicms, areduzidas, ipis,
					ger60d, ger60i, ger60r, ger74, ger75, ger77, gersefaz,
					ger50, ger51, ger54, ger60, ger61, ger70, ger88,
					aliqsbs, ger53, ngersufr1s, gerncm, codidents, ger60p,
					ncotepe52s, ger88ms, UFIBGEs, layoutnf, chkgnre,
					ChaveConsultaHomologacao, ChaveConsultaProducao, Homologacao, Producao
				FROM SigCdUfs
				WHERE estados = <<EscaparSQL(par_cEstados)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Estado n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar estado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfsBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
