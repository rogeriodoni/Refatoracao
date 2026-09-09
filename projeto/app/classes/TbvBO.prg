*====================================================================
* TbvBO.prg
*
* Business Object para Tabelas de Descontos
* Tabela principal: SigOpTdz (codigos PK)
* Sub-tabelas (grades - tratadas em fases posteriores via cursor):
*   SigOpTdt (composicao/formula), SigOpTdi (comissoes por grupo/conta),
*   SigOpTds (faixas de horario/dia de desconto), SigCdEmp (empresas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TbvBO AS BusinessBase

	*-- Propriedades da entidade (SigOpTdz)
	this_cCodigo          = ""   && codigos char(10)      - PK codigo da tabela de desconto
	this_cDescricao       = ""   && descrs char(30)        - descricao
	this_cMoeRef          = ""   && moerefs char(3)        - moeda de referencia
	this_nDesconto        = 0    && descos numeric(5,2)    - percentual de desconto
	this_cObservacao      = ""   && obss char(30)          - observacao
	this_nRelDesconto     = 0    && rel_descs numeric(1,0) - imprime no relatorio de tab. desconto (OptionGroup)
	this_dDataTermino     = {}   && dtterms datetime (NULL) - valido ate (data de termino)
	this_nPrazoMedio      = 0    && prazoms numeric(3,0)   - prazo medio (sem uso)
	this_nChkAcesso       = 0    && chkactb numeric(1,0)   - checar acesso (OptionGroup)
	this_nChkRetorno      = 0    && chkrets numeric(1,0)   - checagem de retorno (OptionGroup)
	this_nAjuste          = 0    && ajustes numeric(8,6)   - valor de ajuste
	this_nFator           = 0    && fators numeric(4,2)    - fator
	this_cMoedaFator      = ""   && moefats char(3)        - moeda do fator
	this_nChaveTabDesc    = 0    && nchvtbds numeric(6,0)  - chave interna da tabela de desconto (auto-gerada)
	this_nDescontoMaximo  = 0    && descmxs numeric(5,2)   - desconto maximo
	this_nAbateCusto      = 0    && abatecus numeric(1,0)  - abater custo de produto da comissao (OptionGroup)
	this_nAgrupaComissao  = 0    && agrucoms numeric(1,0)  - agrupar comissao por (OptionGroup)
	this_nParcelas        = 0    && nparcs numeric(3,0)    - numero de parcelas
	this_nParcelas2       = 0    && nparc2s numeric(3,0)   - numero de parcelas (2)
	this_cListaEmpresas   = ""   && listaemp text (NULL)   - lista de empresas selecionadas (memo)
	this_nTipoDesconto    = 0    && tpdesc numeric(2,0)    - tipo de desconto progressivo (ComboBox)

	*-- Propriedades locais (NAO existem no schema de SigOpTdz - apenas estado UI)
	this_cMoeRefDescricao = ""   && nao persiste - descricao da moeda de referencia (lookup exibicao)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigOpTdz"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCodigo)
	ENDFUNC

	*====================================================================
	* Buscar - SELECT dos registros de SigOpTdz (filtro opcional por descricao)
	*====================================================================
	FUNCTION Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, moerefs, descos" + ;
					   " FROM SigOpTdz"

			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + ;
					" WHERE UPPER(descrs) LIKE UPPER(" + ;
					EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY codigos"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar tabelas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarPorCodigo - SELECT registro por chave primaria (codigos)
	*====================================================================
	FUNCTION CarregarPorCodigo(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc" + ;
					   " FROM SigOpTdz" + ;
					   " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				IF loc_lResultado
					THIS.this_lNovoRegistro = .F.
				ENDIF
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCodigo         = ALLTRIM(TratarNulo(codigos, "C"))
				THIS.this_nDesconto       = TratarNulo(descos, 0)
				THIS.this_cDescricao      = ALLTRIM(TratarNulo(descrs, "C"))
				THIS.this_cMoeRef         = ALLTRIM(TratarNulo(moerefs, "C"))
				THIS.this_cObservacao     = ALLTRIM(TratarNulo(obss, "C"))
				THIS.this_nRelDesconto    = TratarNulo(rel_descs, 0)
				THIS.this_dDataTermino    = TratarNulo(dtterms, {})
				THIS.this_nPrazoMedio     = TratarNulo(prazoms, 0)
				THIS.this_nChkAcesso      = TratarNulo(chkactb, 0)
				THIS.this_nChkRetorno     = TratarNulo(chkrets, 0)
				THIS.this_nAjuste         = TratarNulo(ajustes, 0)
				THIS.this_nFator          = TratarNulo(fators, 0)
				THIS.this_cMoedaFator     = ALLTRIM(TratarNulo(moefats, "C"))
				THIS.this_nChaveTabDesc   = TratarNulo(nchvtbds, 0)
				THIS.this_nDescontoMaximo = TratarNulo(descmxs, 0)
				THIS.this_nAbateCusto     = TratarNulo(abatecus, 0)
				THIS.this_nAgrupaComissao = TratarNulo(agrucoms, 0)
				THIS.this_nParcelas       = TratarNulo(nparcs, 0)
				THIS.this_nParcelas2      = TratarNulo(nparc2s, 0)
				THIS.this_cListaEmpresas  = ALLTRIM(TratarNulo(listaemp, ""))
				THIS.this_nTipoDesconto   = TratarNulo(tpdesc, 0)

				THIS.this_cMoeRefDescricao = ""

				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Inserir - INSERT INTO SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "INSERT INTO SigOpTdz" + ;
					   " (codigos, descos, descrs, moerefs, obss," + ;
					   " rel_descs, dtterms, prazoms, chkactb, chkrets," + ;
					   " ajustes, fators, moefats, nchvtbds, descmxs," + ;
					   " abatecus, agrucoms, nparcs, nparc2s, listaemp, tpdesc)" + ;
					   " VALUES (" + ;
					   EscaparSQL(THIS.this_cCodigo) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDesconto, 2) + ", " + ;
					   EscaparSQL(THIS.this_cDescricao) + ", " + ;
					   EscaparSQL(THIS.this_cMoeRef) + ", " + ;
					   EscaparSQL(THIS.this_cObservacao) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + ", " + ;
					   FormatarDataSQL(THIS.this_dDataTermino) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAjuste, 6) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nFator, 2) + ", " + ;
					   EscaparSQL(THIS.this_cMoedaFator) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas, 0) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nParcelas2, 0) + ", " + ;
					   EscaparSQL(THIS.this_cListaEmpresas) + ", " + ;
					   FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ")"

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Ins")
				TABLEREVERT(.T., "cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
			IF USED("cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* Atualizar - UPDATE SigOpTdz
	*====================================================================
	PROTECTED FUNCTION Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigOpTdz SET" + ;
					   " descos     = " + FormatarNumeroSQL(THIS.this_nDesconto, 2) + "," + ;
					   " descrs     = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
					   " moerefs    = " + EscaparSQL(THIS.this_cMoeRef) + "," + ;
					   " obss       = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
					   " rel_descs  = " + FormatarNumeroSQL(THIS.this_nRelDesconto, 0) + "," + ;
					   " dtterms    = " + FormatarDataSQL(THIS.this_dDataTermino) + "," + ;
					   " prazoms    = " + FormatarNumeroSQL(THIS.this_nPrazoMedio, 0) + "," + ;
					   " chkactb    = " + FormatarNumeroSQL(THIS.this_nChkAcesso, 0) + "," + ;
					   " chkrets    = " + FormatarNumeroSQL(THIS.this_nChkRetorno, 0) + "," + ;
					   " ajustes    = " + FormatarNumeroSQL(THIS.this_nAjuste, 6) + "," + ;
					   " fators     = " + FormatarNumeroSQL(THIS.this_nFator, 2) + "," + ;
					   " moefats    = " + EscaparSQL(THIS.this_cMoedaFator) + "," + ;
					   " nchvtbds   = " + FormatarNumeroSQL(THIS.this_nChaveTabDesc, 0) + "," + ;
					   " descmxs    = " + FormatarNumeroSQL(THIS.this_nDescontoMaximo, 2) + "," + ;
					   " abatecus   = " + FormatarNumeroSQL(THIS.this_nAbateCusto, 0) + "," + ;
					   " agrucoms   = " + FormatarNumeroSQL(THIS.this_nAgrupaComissao, 0) + "," + ;
					   " nparcs     = " + FormatarNumeroSQL(THIS.this_nParcelas, 0) + "," + ;
					   " nparc2s    = " + FormatarNumeroSQL(THIS.this_nParcelas2, 0) + "," + ;
					   " listaemp   = " + EscaparSQL(THIS.this_cListaEmpresas) + "," + ;
					   " tpdesc     = " + FormatarNumeroSQL(THIS.this_nTipoDesconto, 0) + ;
					   " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Upd")
				TABLEREVERT(.T., "cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar tabela de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ObterDescricaoMoeda - Busca a descricao (dmoes) de uma moeda pelo codigo
	* Usado para exibir a descricao da Moeda de Referencia ao carregar registro
	*====================================================================
	FUNCTION ObterDescricaoMoeda(par_cCodigoMoeda)
		LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
		loc_cDescricao = ""

		IF VARTYPE(par_cCodigoMoeda) != "C" OR EMPTY(ALLTRIM(par_cCodigoMoeda))
			RETURN loc_cDescricao
		ENDIF

		TRY
			loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + ;
					   EscaparSQL(ALLTRIM(par_cCodigoMoeda))

			IF USED("cursor_4c_Moeda")
				USE IN cursor_4c_Moeda
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Moeda") > 0
				loc_cDescricao = ALLTRIM(TratarNulo(cursor_4c_Moeda.dmoes, "C"))
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ObterDescricaoMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Moeda")
			USE IN cursor_4c_Moeda
		ENDIF

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* CarregarEmpresas - SELECT das empresas (SigCdEmp) para a grade de
	* selecao usada no tipo de desconto 11 (Desconto Gerente-Extra/loja)
	* Popula cursor_4c_Empresas (READWRITE) com coluna virtual nMarca
	*====================================================================
	FUNCTION CarregarEmpresas()
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cemps FROM SigCdEmp ORDER BY cemps"

			IF USED("cursor_4c_EmpresasTemp")
				USE IN cursor_4c_EmpresasTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Empresas")
					USE IN cursor_4c_Empresas
				ENDIF

				SELECT 0 AS nMarca, cemps ;
					FROM cursor_4c_EmpresasTemp ;
					INTO CURSOR cursor_4c_Empresas READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_EmpresasTemp")
			USE IN cursor_4c_EmpresasTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* ExecutarExclusao - DELETE das sub-tabelas (Tdt/Tdi/Tds) + SigOpTdz
	*====================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_lResultado, loc_lContinua, loc_cSQL, loc_nResultado
		loc_lResultado = .F.
		loc_lContinua  = .T.

		TRY
			*-- Remove registros das grades relacionadas primeiro (formula/comissao/faixas)
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
			IF USED("cursor_4c_DelTdt")
				TABLEREVERT(.T., "cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdt")
			IF USED("cursor_4c_DelTdt")
				USE IN cursor_4c_DelTdt
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao excluir formulas da tabela de desconto:" + CHR(13) + ;
						 CapturarErroSQL(), "Erro SQL")
				loc_lContinua = .F.
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTdi")
					TABLEREVERT(.T., "cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdi")
				IF USED("cursor_4c_DelTdi")
					USE IN cursor_4c_DelTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir comissoes da tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_DelTds")
					TABLEREVERT(.T., "cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTds")
				IF USED("cursor_4c_DelTds")
					USE IN cursor_4c_DelTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao excluir faixas de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
					loc_lContinua = .F.
				ENDIF
			ENDIF

			IF loc_lContinua
				*-- Remove o registro principal
				loc_cSQL = "DELETE FROM SigOpTdz WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
				IF USED("cursor_4c_Del")
					TABLEREVERT(.T., "cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
				IF USED("cursor_4c_Del")
					USE IN cursor_4c_Del
				ENDIF

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("DELETE")
					loc_lResultado = .T.
				ELSE
					MsgErro("Erro ao excluir tabela de desconto:" + CHR(13) + ;
							 CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComposicaoDesconto - SELECT das linhas de formula/tipo
	* (SigOpTdt) do codigo corrente, usadas como mestre pela grade
	* Gradei da pagina "Configuracao de Desconto" (somente leitura la) e
	* pela grade editavel Gradei da pagina "Descontos / Comissoes"
	* (grd_4c_Gradei em ConfigurarPgPgDesconto - fonte da verdade para
	* incluir/alterar/excluir linhas de composicao).
	* Popula cursor_4c_Tdt (READWRITE) com coluna virtual "regs" (flag
	* de linha corrente, equivalente ao "regs" do legado). Inclui TODAS
	* as colunas NOT NULL de SigOpTdt (cidchaves, formulas 1a/2a, moedas,
	* tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot) para
	* que SalvarComposicaoDesconto() consiga regravar a linha completa.
	*====================================================================
	FUNCTION CarregarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods, descos, dfators," + ;
					   " texclus, faixas, finicias, ffinals," + ;
					   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
					   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
					   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
					   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
					   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot" + ;
					   " FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_TdtTemp")
				USE IN cursor_4c_TdtTemp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TdtTemp")
			IF loc_nResultado >= 0
				IF USED("cursor_4c_Tdt")
					USE IN cursor_4c_Tdt
				ENDIF

				SELECT 0 AS regs, * ;
					FROM cursor_4c_TdtTemp ;
					INTO CURSOR cursor_4c_Tdt READWRITE

				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_TdtTemp")
			USE IN cursor_4c_TdtTemp
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarFaixasDesconto - SELECT de TODAS as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips+tipods da linha corrente
	* de cursor_4c_Tdt - mesmo padrao do legado (CrSigOpTds carregado 1x
	* no Init, filtrado via Set Key a cada troca de linha da grade mestre).
	* Popula cursor_4c_Tds (READWRITE).
	*====================================================================
	FUNCTION CarregarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, tipods," + ;
					   " campo1is, campo1fs, campo2is, campo2fs," + ;
					   " campo3is, campo3fs, campo4is, campo4fs," + ;
					   " descos, dfators, nchvtbds" + ;
					   " FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips, tipods"

			IF USED("cursor_4c_Tds")
				USE IN cursor_4c_Tds
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tds")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- cursor_4c_Tds precisa ser READWRITE para APPEND/REPLACE feitos
		*-- na grade GradeD - o cursor de saida do SQLEXEC ja e editavel,
		*-- mas garantimos a existencia mesmo sem linhas retornadas
		IF loc_lResultado AND USED("cursor_4c_Tds") AND RECCOUNT("cursor_4c_Tds") = 0
			*-- SQLEXEC sem linhas ainda cria a estrutura do cursor - ok
		ENDIF

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarFaixasDesconto - Grava (substitui) as faixas de horario/dia/
	* mes/data (SigOpTds) do codigo corrente a partir do conteudo atual
	* de cursor_4c_Tds. Estrategia DELETE + INSERT (mesmo padrao usado
	* em ExecutarExclusao para as sub-tabelas relacionadas).
	*====================================================================
	FUNCTION SalvarFaixasDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tds")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTds WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdsSalvar")
			IF USED("cursor_4c_DelTdsSalvar")
				USE IN cursor_4c_DelTdsSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir faixas de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tds
			*-- O form filtra localmente (SET FILTER) pela combinacao
			*-- Tipo/Codigo/TipoDesconto exibida em grd_4c_GradeD - ao gravar
			*-- e preciso considerar TODAS as combinacoes, nao so a ultima
			*-- filtrada
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTds (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " campo1is, campo1fs, campo2is, campo2fs, campo3is, campo3fs," + ;
						   " campo4is, campo4fs, descos, dfators, nchvtbds) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tds.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.tipods, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo1fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo2fs) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3is) + ", " + ;
						   FormatarDataSQL(cursor_4c_Tds.campo3fs) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4is) + ", " + ;
						   EscaparSQL(cursor_4c_Tds.campo4fs) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.dfators, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tds.nchvtbds, 0) + ")"

				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTds")
				IF USED("cursor_4c_InsTds")
					USE IN cursor_4c_InsTds
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar faixa de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarFaixasDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* CarregarComissoesDesconto - SELECT de TODAS as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente. O form filtra localmente
	* (SET FILTER) pela combinacao tipos+codtips da linha corrente de
	* cursor_4c_Tdt (grd_4c_Gradei da pagina "Descontos / Comissoes"),
	* mesmo padrao usado para cursor_4c_Tds (MontarConfiguracaoDesconto).
	* Popula cursor_4c_Tdi (READWRITE - saida do SQLEXEC ja e editavel).
	*====================================================================
	FUNCTION CarregarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, codigos, tipos, codtips, grupos, contas," + ;
					   " moedas, pintegrals, pdivididas, patendes" + ;
					   " FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo) + ;
					   " ORDER BY codigos, tipos, codtips"

			IF USED("cursor_4c_Tdi")
				USE IN cursor_4c_Tdi
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tdi")
			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao carregar comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.CarregarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComposicaoDesconto - Grava (substitui) as linhas de formula/
	* tipo (SigOpTdt) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdt (grd_4c_Gradei editavel da pagina "Descontos /
	* Comissoes"). Estrategia DELETE + INSERT (mesmo padrao de
	* SalvarFaixasDesconto). tpunidade/chkmultcot nao tem controle na UI
	* (sem uso no legado migrado) - gravados como 0.
	*====================================================================
	FUNCTION SalvarComposicaoDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdt")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdt WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdtSalvar")
			IF USED("cursor_4c_DelTdtSalvar")
				USE IN cursor_4c_DelTdtSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdt
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdt (cidchaves, codigos, tipos, codtips, tipods," + ;
						   " descos, dfators, texclus, faixas, finicias, ffinals," + ;
						   " campo1t1s, campo2t1s, campo3t1s, oper1t1s, oper2t1s," + ;
						   " const1t1s, const2t1s, const3t1s, moeda1s," + ;
						   " campo1t2s, campo2t2s, campo3t2s, oper1t2s, oper2t2s," + ;
						   " const1t2s, const2t2s, const3t2s, moeda2s, moeda3s," + ;
						   " tpcomis, descfats, fatorpads, chkcots, tpunidade, chkmultcot)" + ;
						   " VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.codtips) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tipods, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.descos, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.dfators, 2) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.texclus) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.faixas, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.finicias, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.ffinals, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t1s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t1s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t1s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda1s) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo2t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.campo3t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper1t2s, 0) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.oper2t2s, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const1t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const2t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.const3t2s) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.moeda2s) + ", " + ;
						   EscaparSQL(NVL(cursor_4c_Tdt.moeda3s, "")) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.tpcomis, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdt.descfats) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.fatorpads, 3) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdt.chkcots, 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.tpunidade, 0), 0) + ", " + ;
						   FormatarNumeroSQL(NVL(cursor_4c_Tdt.chkmultcot, 0), 0) + ")"

				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdt")
				IF USED("cursor_4c_InsTdt")
					USE IN cursor_4c_InsTdt
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar linha de composi" + CHR(231) + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComposicaoDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

	*====================================================================
	* SalvarComissoesDesconto - Grava (substitui) as comissoes por grupo/
	* conta (SigOpTdi) do codigo corrente a partir do conteudo atual de
	* cursor_4c_Tdi (grd_4c_Gradec da pagina "Descontos / Comissoes").
	* Estrategia DELETE + INSERT (mesmo padrao de SalvarFaixasDesconto).
	*====================================================================
	FUNCTION SalvarComissoesDesconto(par_cCodigo)
		LOCAL loc_lResultado, loc_cSQL, loc_nResultado
		loc_lResultado = .F.

		IF !USED("cursor_4c_Tdi")
			RETURN .T.
		ENDIF

		TRY
			loc_cSQL = "DELETE FROM SigOpTdi WHERE codigos = " + EscaparSQL(par_cCodigo)
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelTdiSalvar")
			IF USED("cursor_4c_DelTdiSalvar")
				USE IN cursor_4c_DelTdiSalvar
			ENDIF

			IF loc_nResultado < 0
				MsgErro("Erro ao substituir comiss" + CHR(245) + "es de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lResultado = .F.
			ENDIF

			loc_lResultado = .T.

			SELECT cursor_4c_Tdi
			SET FILTER TO
			SCAN FOR !DELETED()
				loc_cSQL = "INSERT INTO SigOpTdi (cidchaves, codigos, tipos, codtips," + ;
						   " grupos, contas, moedas, pintegrals, pdivididas, patendes) VALUES (" + ;
						   EscaparSQL(NVL(cursor_4c_Tdi.cidchaves, fUniqueIds())) + ", " + ;
						   EscaparSQL(par_cCodigo) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.tipos, 0) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.codtips) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.grupos) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.contas) + ", " + ;
						   EscaparSQL(cursor_4c_Tdi.moedas) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pintegrals, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.pdivididas, 2) + ", " + ;
						   FormatarNumeroSQL(cursor_4c_Tdi.patendes, 2) + ")"

				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsTdi")
				IF USED("cursor_4c_InsTdi")
					USE IN cursor_4c_InsTdi
				ENDIF

				IF loc_nResultado < 0
					MsgErro("Erro ao gravar comiss" + CHR(227) + "o de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lResultado = .F.
					EXIT
				ENDIF
			ENDSCAN
		CATCH TO loc_oErro
			MsgErro("Erro em TbvBO.SalvarComissoesDesconto:" + CHR(13) + loc_oErro.Message, "Erro")
			loc_lResultado = .F.
		ENDTRY

		RETURN loc_lResultado
	ENDFUNC

ENDDEFINE
