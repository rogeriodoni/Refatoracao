*====================================================================
* sigprccpBO.prg
*
* Business Object para sigprccp (Recalculo de Precos)
* Tabela principal atualizada pelo processamento: SigCdPro (cpros)
* Tabela de presets de filtro (somente LEITURA, nunca gravada por
* este form): SigCdCcp (cIdChaves)
*
* Form legado: SIGPRCCP - "Recalculo de Precos"
* Forma OPERACIONAL: recalcula Custo/Venda de produtos filtrados,
* grava o resultado em SigCdPro e registra o historico do calculo.
*====================================================================

DEFINE CLASS sigprccpBO AS BusinessBase

	*-- Modo de execucao (Automatico = .T. quando chamado via ProcessarAutomatico,
	*-- percorrendo os presets de SigCdCcp; .F. quando disparado manualmente)
	this_lAutomatico = .F.

	*-- Filtros - Fornecedor
	this_cFornecs = ""
	this_cDFornecs = ""

	*-- Filtros - Faixas de classificacao do produto (SigCdCcp.merci/mercf etc)
	this_cMercI = ""
	this_cMercF = ""
	this_cGrupoI = ""
	this_cGrupoF = ""
	this_cSubGrupoI = ""
	this_cSubGrupoF = ""
	this_cUnidadeI = ""
	this_cUnidadeF = ""
	this_cLinhaI = ""
	this_cLinhaF = ""
	this_cColecaoI = ""
	this_cColecaoF = ""
	this_cMoedaI = ""
	this_cMoedaF = ""

	*-- Filtros - Faixas numericas (Markup/Encargo/Variacao)
	this_nMarkupI = 0
	this_nMarkupF = 0
	this_nEncargoI = 0
	this_nEncargoF = 0
	this_nVariacao = 0

	*-- Filtros - Feitio (SigPrFti) usado como referencia de calculo
	this_cFeitio = ""

	*-- Opcoes de processamento (OptionGroups do form - valores 1-based).
	*-- this_nAtualizaVenda=2 ("Nao") e this_nOpcaoCompra=3 ("Todos") sao
	*-- os defaults EXATOS do SCX legado (Opc_pven.Value=2/Opc_Compra.Value=3)
	this_nOpcaoMoeda = 1
	this_nSituacao = 1
	this_nTipoRecalculo = 1
	this_nAtualizaVenda = 2
	this_nOpcaoCompra = 3

	*-- Dados de recalculo
	this_nReajuste = 0
	this_nNovoEncargo = 0
	this_nNovoMarkup = 0
	this_cNovoFeitio = ""

	*-- Produto corrente (linha da grade marcada para gravacao do preco
	*-- recalculado) - mapeia SigCdPro.cpros, o registro efetivamente
	*-- atualizado por Inserir/Atualizar/ObterChavePrimaria/CarregarDoCursor
	this_cCpros = ""                && cpros char(14) - PK
	this_cDescricaoProduto = ""     && dpros char(65) - somente referencia
	this_nCustoAtual = 0            && custofs numeric(11,3)
	this_nVendaAtual = 0            && pvens numeric(11,5)
	this_nVendaIdeal = 0            && pvideals numeric(11,5)
	this_nFatorCusto = 0            && fcustos numeric(11,5)
	this_nFatorVenda = 0            && fvendas numeric(7,3)
	this_cMoedaCusto = ""           && moecs char(3)
	this_cMoedaVenda = ""           && moevs char(3)

	*-- Flag "Confirma a Impressao das Etiquetas?" do metodo "atualizar"
	*-- legado (m.ImpEtiqs = llImpEtiq gravado junto com o preco novo).
	*-- NUMERICO 0/1 porque impetiqs eh bit e o CheckBox/confirmacao do
	*-- form trabalha com 0/1 (nunca .T./.F.)
	this_nImpEtiqs = 0              && impetiqs bit

	*-- Subgrupo recalculado por faixa de preco (SigCdPsg.nfaixafins),
	*-- aplicado somente quando SigCdPaC.nchksubgrs = 1 - transcricao do
	*-- bloco "If crSigCdPac.nChkSubGrs = 1 ... Replace sGrus With
	*-- csSigCdPsg.Codigos" do metodo "atualizar" legado.
	*-- this_lAtualizarSubGrupo controla se Atualizar() inclui sgrus no
	*-- UPDATE: o legado so troca o subgrupo quando acha a faixa.
	this_cSubGrupo = ""             && sgrus char(6)
	this_lAtualizarSubGrupo = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		*-- Tabela efetivamente atualizada pelo processamento (SigCdPro),
		*-- pois SigCdCcp (presets de filtro) e somente LEITURA neste form.
		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "cpros"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave do produto sendo gravado
	* (usada por RegistrarAuditoria em Atualizar)
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCpros)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega os dados do produto (linha da grade de
	* recalculo) para as propriedades this_c*/this_n* correspondentes.
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				*-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR default do
				*-- tipo da coluna, NUNCA um codigo de tipo ("C"/"N") - com a coluna
				*-- NULL, "C" gravaria a string literal "C" na property e "N" poria
				*-- uma STRING numa property this_n*, estourando FormatarNumeroSQL.
				THIS.this_cCpros            = TratarNulo(cpros,    "")
				THIS.this_cDescricaoProduto = TratarNulo(dpros,    "")
				THIS.this_nCustoAtual       = TratarNulo(custofs,  0)
				THIS.this_nVendaAtual       = TratarNulo(pvens,    0)
				THIS.this_nVendaIdeal       = TratarNulo(pvideals, 0)
				THIS.this_nFatorCusto       = TratarNulo(fcustos,  0)
				THIS.this_nFatorVenda       = TratarNulo(fvendas,  0)
				THIS.this_cMoedaCusto       = TratarNulo(moecs,    "")
				THIS.this_cMoedaVenda       = TratarNulo(moevs,    "")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar produto do cursor:" + CHR(13) + ;
				loException.Message, "sigprccpBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Grava o preco/custo recalculado de volta em SigCdPro
	* Equivalente a PROCEDURE atualizar do legado: Scatter/Gather do
	* registro com DataAlts/UsuaAlts atualizados e commit do preco novo.
	*
	* Inserir()/ExecutarExclusao() NAO sao sobrescritos neste BO: o
	* recalculo so ATUALIZA produtos ja cadastrados em SigCdPro - nunca
	* cria nem apaga produto - entao o comportamento herdado de
	* BusinessBase (recusar a operacao) ja eh o correto para os dois.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_cSubGru, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- sgrus so entra no UPDATE quando a faixa de SigCdPsg foi
			*-- localizada (legado: "If ! Eof() / Replace sGrus With
			*-- csSigCdPsg.Codigos") - fora disso o subgrupo nao se mexe.
			loc_cSubGru = ""
			IF THIS.this_lAtualizarSubGrupo AND !EMPTY(ALLTRIM(THIS.this_cSubGrupo))
				loc_cSubGru = "sgrus = " + ;
					EscaparSQL(LEFT(ALLTRIM(THIS.this_cSubGrupo), 6)) + ","
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET custofs  = <<FormatarNumeroSQL(THIS.this_nCustoAtual, 3)>>,
					pvens    = <<FormatarNumeroSQL(THIS.this_nVendaAtual, 5)>>,
					pvideals = <<FormatarNumeroSQL(THIS.this_nVendaIdeal, 5)>>,
					fcustos  = <<FormatarNumeroSQL(THIS.this_nFatorCusto, 5)>>,
					fvendas  = <<FormatarNumeroSQL(THIS.this_nFatorVenda, 3)>>,
					moecs    = <<EscaparSQL(THIS.this_cMoedaCusto)>>,
					moevs    = <<EscaparSQL(THIS.this_cMoedaVenda)>>,
					impetiqs = <<FormatarNumeroSQL(IIF(THIS.this_nImpEtiqs = 1, 1, 0), 0)>>,
					<<loc_cSubGru>>
					dtalts   = GETDATE(),
					usuaalts = <<EscaparSQL(LEFT(gc_4c_UsuarioLogado, 20))>>
				WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar pre" + CHR(231) + "o do produto:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprccpBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AcrescentarFaixa - Helper de MontarWhereFiltros: acrescenta a faixa
	* (BETWEEN/>=/<=) de UM campo a clausula WHERE em construcao. Espelha
	* o corpo do "For lnConta = 1 To 7" do metodo "processar" legado
	* (SIGPRCCP): so entra em ">= "/"<= "/"Between" quando pelo menos um
	* dos limites foi informado, e "And" so precede quando ja existe algo
	* acumulado em par_cWhereAtual.
	*====================================================================
	PROTECTED FUNCTION AcrescentarFaixa(par_cWhereAtual, par_cCampo, par_cInicio, par_cFim)
		LOCAL loc_cWhere, loc_cIni, loc_cFim
		loc_cWhere = par_cWhereAtual
		loc_cIni   = ALLTRIM(TratarNulo(par_cInicio, ""))
		loc_cFim   = ALLTRIM(TratarNulo(par_cFim, ""))

		IF !EMPTY(loc_cIni) OR !EMPTY(loc_cFim)
			IF !EMPTY(loc_cWhere)
				loc_cWhere = loc_cWhere + " And "
			ENDIF

			IF EMPTY(loc_cIni)
				loc_cWhere = loc_cWhere + par_cCampo + " <= " + EscaparSQL(loc_cFim)
			ELSE
				IF EMPTY(loc_cFim)
					loc_cWhere = loc_cWhere + par_cCampo + " >= " + EscaparSQL(loc_cIni)
				ELSE
					loc_cWhere = loc_cWhere + par_cCampo + " Between " + ;
						EscaparSQL(loc_cIni) + " And " + EscaparSQL(loc_cFim)
				ENDIF
			ENDIF
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* MontarWhereFiltros - Constroi a clausula WHERE dos filtros de faixa
	* (Grande Grupo/Grupo/Subgrupo/Unidade/Linha/Colecao/Moeda), Situacao,
	* Fornecedor, Opcao de Compra, Markup, Encargo e Feitio - transcricao
	* literal do bloco de montagem de lcWhere do metodo "processar" legado
	* (laCampo/laVarias percorrendo os 7 pares de faixa, seguido dos IIF de
	* Situas/Ifors/ForaLinha/Margems/Encargos/cFtios+cFtioCs).
	*====================================================================
	PROTECTED FUNCTION MontarWhereFiltros()
		LOCAL loc_cWhere, loc_cCampoMoeda

		*-- laCampo[5] do legado: 'Moedas', ou 'Moevs' quando fwoption1.Value = 2
		loc_cCampoMoeda = IIF(THIS.this_nOpcaoMoeda = 2, "Moevs", "Moedas")

		loc_cWhere = ""
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "CGrus",     THIS.this_cGrupoI,    THIS.this_cGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Cunis",     THIS.this_cUnidadeI,  THIS.this_cUnidadeF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Linhas",    THIS.this_cLinhaI,    THIS.this_cLinhaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Colecoes",  THIS.this_cColecaoI,  THIS.this_cColecaoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, loc_cCampoMoeda, THIS.this_cMoedaI, THIS.this_cMoedaF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "SGrus",     THIS.this_cSubGrupoI, THIS.this_cSubGrupoF)
		loc_cWhere = THIS.AcrescentarFaixa(loc_cWhere, "Mercs",     THIS.this_cMercI,     THIS.this_cMercF)

		loc_cWhere = ALLTRIM(loc_cWhere)
		IF EMPTY(loc_cWhere)
			loc_cWhere = "1=1"
		ENDIF
		IF UPPER(RIGHT(loc_cWhere, 3)) == "AND"
			loc_cWhere = ALLTRIM(SUBSTR(loc_cWhere, 1, LEN(loc_cWhere) - 3))
		ENDIF

		*-- Situacao (Opc_situacao): 1=Ativos, 2=Inativos, 3=Todos (sem filtro)
		IF INLIST(THIS.this_nSituacao, 1, 2)
			loc_cWhere = loc_cWhere + " And Situas = " + FormatarNumeroSQL(THIS.this_nSituacao, 0)
		ENDIF

		*-- Fornecedor (getCFornecs)
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFornecs, "")))
			loc_cWhere = loc_cWhere + " And Ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecs))
		ENDIF

		*-- Opc_Compra: 1=Comprar (ForaLinha=0), 2=Nao Comprar (ForaLinha=1), 3=Todos
		IF INLIST(THIS.this_nOpcaoCompra, 1, 2)
			loc_cWhere = loc_cWhere + " And ForaLinha = " + IIF(THIS.this_nOpcaoCompra = 1, "0", "1")
		ENDIF

		*-- Faixa de Markup (GetMrki/GetMrkf)
		IF THIS.this_nMarkupI > 0
			loc_cWhere = loc_cWhere + " And Margems Between " + ;
				FormatarNumeroSQL(THIS.this_nMarkupI, 2) + " And " + FormatarNumeroSQL(THIS.this_nMarkupF, 2)
		ENDIF

		*-- Faixa de Encargo (Get_EncI/Get_Encf)
		IF THIS.this_nEncargoI > 0
			loc_cWhere = loc_cWhere + " And Encargos Between " + ;
				FormatarNumeroSQL(THIS.this_nEncargoI, 2) + " And " + FormatarNumeroSQL(THIS.this_nEncargoF, 2)
		ENDIF

		*-- Feitio (Get_Feitio) - casa tanto o feitio de venda quanto o de custo
		IF !EMPTY(ALLTRIM(TratarNulo(THIS.this_cFeitio, "")))
			loc_cWhere = loc_cWhere + " And (cFtios = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ;
				" Or cFtioCs = " + EscaparSQL(ALLTRIM(THIS.this_cFeitio)) + ")"
		ENDIF

		RETURN loc_cWhere
	ENDFUNC

	*====================================================================
	* BuscarProdutosFiltrados - Consulta SigCdPro com a clausula WHERE de
	* MontarWhereFiltros (transcricao da fase de consulta do metodo
	* "processar" legado: "lcQuery = [Select * From SigCdPro Where ] +
	* lcWhere + ..."). O calculo de reajuste (conversao de moeda, peso de
	* composicao e markup de grupo) que o legado aplica DEPOIS desta
	* consulta usa this_nReajuste/this_nNovoMarkup/this_nNovoEncargo, que
	* espelham os controles Get_Reajuste/GetnMrk/Get_Encargo do formulario.
	*
	* Resultado fica em cursor_4c_ProdutosSQL (cpros/dpros/pvens/custofs/
	* pvideals/fcustos/fvendas/moecs/moevs) para o Form transferir para o
	* cursor da grade (cursor_4c_Produtos) em CarregarLista.
	*====================================================================
	FUNCTION BuscarProdutosFiltrados()
		LOCAL loc_cWhere, loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cWhere = THIS.MontarWhereFiltros()

			IF USED("cursor_4c_ProdutosSQL")
				USE IN cursor_4c_ProdutosSQL
			ENDIF

			*-- cgrus nao aparece na grade, mas viaja junto porque a
			*-- reclassificacao de subgrupo por faixa (ResolverSubGrupoPorFaixa)
			*-- precisa do grupo do produto na hora de gravar
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cpros, dpros, pvens, custofs, pvideals, fcustos, fvendas,
					moecs, moevs, cgrus
				FROM SigCdPro
				WHERE <<loc_cWhere>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosSQL")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao consultar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao buscar produtos:" + CHR(13) + loException.Message, ;
				"sigprccpBO.BuscarProdutosFiltrados")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


	*====================================================================
	* BuscarPresetsAutomaticos - Le os presets de recalculo ativos de
	* SigCdCcp para o modo Automatico. Transcricao literal da consulta do
	* metodo "processaautomatico" legado:
	*     lcQuery = [Select * From SigCdCcp Where Inativas <> 1]
	*
	* Resultado em cursor_4c_PresetsCcp (uma linha por preset, na ordem
	* natural da tabela - o legado nao ordena).
	*====================================================================
	FUNCTION BuscarPresetsAutomaticos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_PresetsCcp")
				USE IN cursor_4c_PresetsCcp
			ENDIF

			loc_cSQL = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PresetsCcp")

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
					CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdCcp)")
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler presets de rec" + CHR(225) + "lculo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.BuscarPresetsAutomaticos")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterChkSubGrupos - Le SigCdPaC.nchksubgrs, o parametro que liga a
	* reclassificacao de subgrupo por faixa de preco no fim do metodo
	* "atualizar" legado (If crSigCdPac.nChkSubGrs = 1). O legado carrega
	* esse valor no Init (CursorQuery 'SigCdPaC' ... 'Calccusts,NCHKSUBGRS').
	*
	* Retorno: NUMERICO (0 quando o parametro nao existe ou a consulta
	* falha) - nchksubgrs eh numeric(1,0), nao bit, entao chega SEMPRE
	* numerico e nao precisa de teste de VARTYPE para Logico.
	*====================================================================
	FUNCTION ObterChkSubGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_nChk
		loc_nChk = 0

		TRY
			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF

			loc_cSQL = "SELECT TOP 1 nchksubgrs FROM SigCdPaC"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PacChk")

			IF loc_nResultado >= 0 AND USED("cursor_4c_PacChk")
				SELECT cursor_4c_PacChk
				GO TOP
				IF !EOF()
					loc_nChk = TratarNulo(cursor_4c_PacChk.nchksubgrs, 0)
				ENDIF
			ENDIF

			IF USED("cursor_4c_PacChk")
				USE IN cursor_4c_PacChk
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao ler par" + CHR(226) + "metro de subgrupo:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ObterChkSubGrupos")
		ENDTRY

		RETURN loc_nChk
	ENDFUNC

	*====================================================================
	* ResolverSubGrupoPorFaixa - Devolve o subgrupo (SigCdPsg.codigos) cuja
	* faixa comporta o preco de venda informado. Transcricao do bloco do
	* metodo "atualizar" legado:
	*     Select * From SigCdPsg Where CGrus = '<grupo>' Order By nFaixaFins
	*     Locate For nFaixaFins >= lnPVens
	*     If ! Eof() -> Replace sGrus With csSigCdPsg.Codigos
	* O "Locate" sobre o cursor ORDENADO por nFaixaFins pega a PRIMEIRA
	* faixa cujo limite superior alcanca o preco - equivalente exato ao
	* TOP 1 ... ORDER BY nfaixafins abaixo.
	*
	* Retorno: CHAR com o codigo do subgrupo, "" quando nao ha faixa
	* (caso em que o legado NAO troca o subgrupo).
	*====================================================================
	FUNCTION ResolverSubGrupoPorFaixa(par_cGrupo, par_nVenda)
		LOCAL loc_cSQL, loc_nResultado, loc_cCodigo
		loc_cCodigo = ""

		TRY
			IF !EMPTY(ALLTRIM(TratarNulo(par_cGrupo, "")))
				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF

				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT TOP 1 codigos
					FROM SigCdPsg
					WHERE cgrus = <<EscaparSQL(ALLTRIM(par_cGrupo))>>
						AND nfaixafins >= <<FormatarNumeroSQL(par_nVenda, 2)>>
					ORDER BY nfaixafins
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Psg")

				IF loc_nResultado >= 0 AND USED("cursor_4c_Psg")
					SELECT cursor_4c_Psg
					GO TOP
					IF !EOF()
						loc_cCodigo = ALLTRIM(TratarNulo(cursor_4c_Psg.codigos, ""))
					ENDIF
				ENDIF

				IF USED("cursor_4c_Psg")
					USE IN cursor_4c_Psg
				ENDIF
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao resolver subgrupo por faixa:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ResolverSubGrupoPorFaixa")
		ENDTRY

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* ColunasComunsProPrc - Lista das 121 colunas presentes ao mesmo tempo
	* em SigCdPro e SigCdPrc (extraidas de docs/schema.sql). O legado copia
	* o registro INTEIRO com "Scatter Memvar Memo" + "Insert Into
	* CrSigCdPrc From MemVar", que preenche apenas os campos de nome igual
	* nas duas tabelas - esta lista eh exatamente esse conjunto.
	*
	* par_lOrigem = .T. devolve as EXPRESSOES do SELECT sobre SigCdPro,
	* com LEFT() nas 3 colunas que sao mais CURTAS no destino (locals
	* 10->6, sittricms 3->2, codtams 4->2); sem o LEFT o SQL Server recusa
	* o INSERT com "String or binary data would be truncated".
	* par_lOrigem = .F. devolve os nomes crus, para a lista de destino.
	*====================================================================
	PROTECTED FUNCTION ColunasComunsProPrc(par_lOrigem)
		LOCAL loc_c
		loc_c = ""
		loc_c = loc_c + "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, "
		loc_c = loc_c + "cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, "
		loc_c = loc_c + "fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(locals, 6)", "locals") + ", "
		loc_c = loc_c + "margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, "
		loc_c = loc_c + "obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, "
		loc_c = loc_c + "reffs, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(sittricms, 2)", "sittricms") + ", "
		loc_c = loc_c + "tcomps, tipos, transps, valors, varias, situas, "
		loc_c = loc_c + "dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, "
		loc_c = loc_c + "codcors, "
		loc_c = loc_c + IIF(par_lOrigem, "LEFT(codtams, 2)", "codtams") + ", "
		loc_c = loc_c + "compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, "
		loc_c = loc_c + "chkfunds, casas, impetiqs, qtdcpnts, dpro2s, dsccompras, encoms, obscompras, "
		loc_c = loc_c + "codacbs, cravcers, cunips, ipis, mercs, pesobs, tamhs, tamls, "
		loc_c = loc_c + "tamps, tptribs, volumes, obsetqs, ultcomps, vultcomps, multcomps, markupa, "
		loc_c = loc_c + "tinsts, cclass, cftiocs, figtecs, nivelqs, pftiocs, usuincs, diasinas, "
		loc_c = loc_c + "idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, contaccus, "
		loc_c = loc_c + "gruccus, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, "
		loc_c = loc_c + "idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, "
		loc_c = loc_c + "conjunts"

		RETURN loc_c
	ENDFUNC

	*====================================================================
	* GravarHistoricoPreco - Registra em SigCdPrc o retrato do produto
	* ANTES da gravacao do preco novo. Transcricao do bloco do metodo
	* "atualizar" legado:
	*     lcSql = [Select * From SigCdPro Where Cpros = ']+m.cpros+[']
	*     Select TmpPro2 / Scatter Memvar Memo
	*     m.DataAlts = Datetime() / m.HoraAlts = Substr(Ttoc(...),12,8)
	*     m.UsuaAlts = Usuar / m.cIdChaves = fUniqueIds()
	*     m.Origem   = Ttoc(Datetime()) + [ SigPrCcp]
	*     Insert Into CrSigCdPrc From MemVar
	* Feito com INSERT ... SELECT (server-side) para nao trazer as 121
	* colunas para o VFP so para devolve-las.
	*
	* As 15 colunas NOT NULL que existem em SigCdPrc e NAO em SigCdPro
	* recebem o valor em branco do tipo - equivalente ao registro em
	* branco do cursor do legado, que o "Insert From Memvar" nao toca.
	* SigCdPrc nao tem nenhum DEFAULT, entao omitir qualquer uma delas
	* faria o SQL Server recusar o INSERT inteiro (CLAUDE.md regra #22).
	* figuras (image) fica de fora porque aceita NULL.
	*
	* IMPORTANTE: chamar ANTES de Salvar()/Atualizar(), senao o historico
	* guarda o preco NOVO em vez do antigo.
	*====================================================================
	FUNCTION GravarHistoricoPreco(par_cCpros)
		LOCAL loc_cSQL, loc_cDestino, loc_cOrigem, loc_cExtras, loc_cValores
		LOCAL loc_cHora, loc_cOrigemTxt, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- m.HoraAlts = Substr(Ttoc(m.DataAlts),12,8) do legado
			loc_cHora = SUBSTR(TTOC(DATETIME()), 12, 8)

			*-- m.Origem = Ttoc(Datetime()) + [ SigPrCcp] do legado
			loc_cOrigemTxt = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

			loc_cExtras  = "codcpds, cbms, caracts, cunifors, custocvs, ltmins, markcvs, pesomts, " + ;
				"pidealcvs, qtdias, retiras, codccnjs, montagens, tmontas, codconc"
			loc_cValores = EscaparSQL("") + ", 0, " + EscaparSQL("") + ", " + EscaparSQL("") + ;
				", 0, 0, 0, 0, 0, 0, 0, " + EscaparSQL("") + ", 0, " + EscaparSQL("") + ;
				", " + EscaparSQL("")

			loc_cDestino = THIS.ColunasComunsProPrc(.F.)
			loc_cOrigem  = THIS.ColunasComunsProPrc(.T.)

			loc_cSQL = "INSERT INTO SigCdPrc " + ;
				"(dataalts, horaalts, usuaalts, cidchaves, origem, " + ;
				loc_cExtras + ", " + loc_cDestino + ") " + ;
				"SELECT GETDATE(), " + ;
				EscaparSQL(loc_cHora) + ", " + ;
				EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
				EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
				EscaparSQL(loc_cOrigemTxt) + ", " + ;
				loc_cValores + ", " + loc_cOrigem + " " + ;
				"FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
					"rico de pre" + CHR(231) + "o (SigCdPrc) do produto " + ;
					ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de pre" + CHR(231) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.GravarHistoricoPreco")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* GravarHistoricoComposicao - Copia a composicao corrente do produto
	* (SigPrCpo) para SigPrCp2. Transcricao do bloco do metodo "atualizar"
	* legado:
	*     Select * From SigPrCpo Where CPros = '<cpros>' -> TmpCompo
	*     Scan / Scatter MemVar Memo
	*        m.DataAlts/HoraAlts/UsuaAlts / m.cIdChaves = fUniqueIds()
	*        Insert Into CrSigPrCp2 From MemVar
	*     EndScan
	* Como o legado gera um cIdChaves NOVO por LINHA, a gravacao eh feita
	* linha a linha (um INSERT ... SELECT por cidchaves de origem) - um
	* unico INSERT em conjunto repetiria a mesma chave em todas as linhas
	* e colidiria no indice unico.
	*
	* SigPrCp2 = SigPrCpo menos PedraPrincipal, mais dataalts/horaalts/
	* usuaalts; dcompos eh char(30) contra char(40) na origem, por isso o
	* LEFT(dcompos, 30).
	*====================================================================
	FUNCTION GravarHistoricoComposicao(par_cCpros)
		LOCAL loc_cSQL, loc_cCols, loc_cColsOrig, loc_cHora, loc_cUsuario
		LOCAL loc_nResultado, loc_lSucesso, loc_lProsseguir
		loc_lSucesso    = .F.
		loc_lProsseguir = .T.

		TRY
			loc_cHora    = SUBSTR(TTOC(DATETIME()), 12, 8)
			loc_cUsuario = LEFT(gc_4c_UsuarioLogado, 10)

			loc_cCols = ""
			loc_cCols = loc_cCols + "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, "
			loc_cCols = loc_cCols + "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, "
			loc_cCols = loc_cCols + "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, "
			loc_cCols = loc_cCols + "cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, "
			loc_cCols = loc_cCols + "tipos, matriz, obsofs"

			*-- Mesma lista, com LEFT() na unica coluna mais curta no destino
			loc_cColsOrig = STRTRAN(loc_cCols, "dcompos,", "LEFT(dcompos, 30),")

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF

			loc_cSQL = "SELECT cidchaves FROM SigPrCpo WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoOrig")

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Falha ao ler composi" + CHR(231) + CHR(227) + ;
					"o do produto " + ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
				loc_lProsseguir = .F.
			ENDIF

			IF loc_lProsseguir
				*-- Produto sem composicao: nada a historiar, e o legado
				*-- tambem apenas nao entra no Scan (sucesso)
				loc_lSucesso = .T.

				SELECT cursor_4c_CompoOrig
				SCAN
					loc_cSQL = "INSERT INTO SigPrCp2 " + ;
						"(dataalts, horaalts, usuaalts, cidchaves, " + loc_cCols + ") " + ;
						"SELECT GETDATE(), " + ;
						EscaparSQL(loc_cHora) + ", " + ;
						EscaparSQL(loc_cUsuario) + ", " + ;
						EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
						loc_cColsOrig + " " + ;
						"FROM SigPrCpo WHERE cidchaves = " + ;
						EscaparSQL(ALLTRIM(cursor_4c_CompoOrig.cidchaves))

					IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
						THIS.this_cMensagemErro = "Falha ao gravar hist" + CHR(243) + ;
							"rico de composi" + CHR(231) + CHR(227) + "o (SigPrCp2) do produto " + ;
							ALLTRIM(par_cCpros) + ": " + CapturarErroSQL()
						MsgErro(THIS.this_cMensagemErro, "Erro SQL")
						loc_lSucesso = .F.
						EXIT
					ENDIF

					SELECT cursor_4c_CompoOrig
				ENDSCAN
			ENDIF

			IF USED("cursor_4c_CompoOrig")
				USE IN cursor_4c_CompoOrig
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao gravar hist" + CHR(243) + "rico de composi" + ;
				CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, ;
				"sigprccpBO.GravarHistoricoComposicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExcluirPrecosTabela - Apaga os precos de tabela do produto, que
	* passam a estar defasados depois do recalculo. Transcricao literal do
	* metodo "atualizar" legado:
	*     [Delete From SigPrPrt Where CPros = '] + m.CPros + [' ]
	*====================================================================
	FUNCTION ExcluirPrecosTabela(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + ;
				EscaparSQL(ALLTRIM(par_cCpros))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Falha ao excluir pre" + CHR(231) + ;
					"os de tabela (SigPrPrt) do produto " + ALLTRIM(par_cCpros) + ;
					": " + CapturarErroSQL()
				MsgErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao excluir pre" + CHR(231) + "os de tabela:" + CHR(13) + ;
				loException.Message, "sigprccpBO.ExcluirPrecosTabela")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* IniciarTransacao / ConfirmarTransacao / DesfazerTransacao
	*
	* Equivalentes de ThisForm.poDataMgr.Commit() / .RollBack() do legado,
	* que existem porque o fSqlConector legado abre a conexao com
	* Transactions = 2 (manual). Neste ambiente a conexao JA nasce em
	* transacao manual (SQLGETPROP(0,"Transactions") = 2 num VFP9 virgem),
	* entao nao ha nada a abrir: IniciarTransacao apenas confere o handle e
	* limpa a mensagem de erro; o que importa eh o par SQLCOMMIT/
	* SQLROLLBACK no fim - sem eles a transacao nunca eh fechada e a
	* gravacao SOME se o processo morrer antes do disconnect limpo.
	*====================================================================
	FUNCTION IniciarTransacao()
		THIS.this_cMensagemErro = ""
		RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
	ENDFUNC

	FUNCTION ConfirmarTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
			IF !loc_lSucesso
				THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + ;
					CHR(227) + "o: " + CapturarErroSQL()
			ENDIF
		CATCH TO loException
			THIS.this_cMensagemErro = loException.Message
			MostrarErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.ConfirmarTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	FUNCTION DesfazerTransacao()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_lSucesso = (SQLROLLBACK(gnConnHandle) > 0)
		CATCH TO loException
			MostrarErro("Erro ao desfazer transa" + CHR(231) + CHR(227) + "o:" + ;
				CHR(13) + loException.Message, "sigprccpBO.DesfazerTransacao")
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC


ENDDEFINE
