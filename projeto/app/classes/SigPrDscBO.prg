*====================================================================
* SigPrDscBO.prg
*
* Business Object para SigPrDsc (Montagem de Descricao de Produtos)
* Tabela principal atualizada: SigCdPro (DscCompras, ObsCompras, DPros)
* Tabelas auxiliares: SigCdGrp, SigCdCor, SigCdDic, SigPrPrt
*
* Form OPERACIONAL: processa produtos sem traducao (fila em SigPrPrt),
* monta a descricao concatenando Grupo + Cor, traduz via dicionario
* (SigCdDic) e grava DscCompras/ObsCompras/DPros de volta em SigCdPro.
*====================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

	*-- Tabela principal e chave (para auditoria/BusinessBase)
	this_cTabela = "SigCdPro"
	this_cCampoChave = "CPros"

	*-- Filtro de faixa de produtos (telas getCProsI / getCProsF)
	this_cCProsI = ""
	this_cCProsF = ""

	*-- Filtro de grupo de produtos (tela getCGrus)
	this_cCGrus = ""

	*-- Produto corrente sendo processado/gravado (crProdutos.CPros)
	this_cCPros = ""

	*-- Descricao em portugues montada (Grupo + Cor) - crProdutos.Portugues
	this_cPortugues = ""

	*-- Descricao traduzida (ingles) - crProdutos.Traduzido
	this_cTraduzido = ""

	*-- Campos gravados de volta em SigCdPro.DscCompras / ObsCompras
	this_cDscCompras = ""
	this_cObsCompras = ""

	*-- Descricao final formatada gravada em SigCdPro.DPros
	this_cDPros = ""

	*-- Total de produtos processados/gravados (para mensagens de resumo)
	this_nTotalProcessados = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigCdPro"
		THIS.this_cCampoChave = "CPros"

		THIS.this_cCProsI = ""
		THIS.this_cCProsF = ""
		THIS.this_cCGrus = ""
		THIS.this_cCPros = ""
		THIS.this_cPortugues = ""
		THIS.this_cTraduzido = ""
		THIS.this_cDscCompras = ""
		THIS.this_cObsCompras = ""
		THIS.this_cDPros = ""
		THIS.this_nTotalProcessados = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega as propriedades do produto corrente a
	* partir de uma linha do cursor crProdutos (estrutura do legado:
	* CPros c(14), Portugues c(254), Traduzido c(254), DscCompras m,
	* ObsCompras m). THIS.this_cDPros e recalculado aqui pela MESMA
	* formula do PROCEDURE gravacao legado (Padr(Alltrim(Portugues),40)),
	* pois DPros nao existe como coluna no cursor - e sempre derivado.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cCPros      = ALLTRIM(TratarNulo(CPros, ""))
			THIS.this_cPortugues  = TratarNulo(Portugues, "")
			THIS.this_cTraduzido  = TratarNulo(Traduzido, "")
			THIS.this_cDscCompras = TratarNulo(DscCompras, "")
			THIS.this_cObsCompras = TratarNulo(ObsCompras, "")
			THIS.this_cDPros      = PADR(ALLTRIM(THIS.this_cPortugues), 40)

			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* TemFiltro - .T. quando ao menos um dos tres filtros da tela foi
	* informado. Eh o criterio da primeira guarda do PROCEDURE Click do
	* btnSelecionar legado:
	*
	*   If Empty(getCProsI.Value) And Empty(getCProsF.Value) And
	*      Empty(getCGrus.Value) ... Return .f.
	*
	* So o CRITERIO vem para ca - a mensagem e o SetFocus continuam no
	* Form, que eh onde moram (sao UI).
	*====================================================================
	FUNCTION TemFiltro()
		RETURN !EMPTY(ALLTRIM(THIS.this_cCProsI)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCProsF)) OR ;
		       !EMPTY(ALLTRIM(THIS.this_cCGrus))
	ENDFUNC

	*====================================================================
	* NormalizarFiltros - completa a faixa de produto quando o usuario
	* digitou apenas uma das pontas. TRANSCRICAO LITERAL do PROCEDURE
	* Click do btnSelecionar legado (regra #17 - criterio do legado nao
	* se reescreve):
	*
	*   If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
	*       getCProsF.Value = getCProsI.Value
	*   If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
	*       getCProsI.Value = getCProsF.Value
	*
	* NAO mexe no grupo: a exclusividade faixa-x-grupo eh feita pelos
	* PROCEDURE Valid dos campos (Form.ValidarCProsI/ValidarCProsF/
	* ValidarCGrus), NAO pelo botao Selecionar - o legado tambem nao a
	* aplica aqui, e aplicar limparia filtro que o usuario informou.
	*
	* Guarda os valores SEM padding de proposito: quem monta o SQL aplica
	* o Padr(...,14) / Padr(...,3) do legado. Padded aqui, o BOParaForm
	* devolveria espacos a direita para dentro dos TextBox da tela.
	*====================================================================
	PROCEDURE NormalizarFiltros()
		THIS.this_cCProsI = ALLTRIM(THIS.this_cCProsI)
		THIS.this_cCProsF = ALLTRIM(THIS.this_cCProsF)
		THIS.this_cCGrus  = ALLTRIM(THIS.this_cCGrus)

		*-- legado: If Not Empty(getCProsI.Value) And Empty(getCProsF.Value)
		IF !EMPTY(THIS.this_cCProsI) AND EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsF = THIS.this_cCProsI
		ENDIF

		*-- legado: If Empty(getCProsI.Value) And Not Empty(getCProsF.Value)
		IF EMPTY(THIS.this_cCProsI) AND !EMPTY(THIS.this_cCProsF)
			THIS.this_cCProsI = THIS.this_cCProsF
		ENDIF
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave primaria do produto em processamento
	* (usada por RegistrarAuditoria).
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCPros)
	ENDFUNC

	*====================================================================
	* Inserir - Este form OPERACIONAL nunca cria produto novo em SigCdPro
	* (o cadastro de produtos e feito em outra tela; aqui so se traduz e
	* regrava a descricao de um produto JA existente, apontado pela fila
	* SigPrPrt). "Gravar" e sempre um UPDATE - o proprio PROCEDURE
	* gravacao do legado roda o mesmo par Update/Delete em qualquer
	* contexto -, entao Inserir delega para Atualizar.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		RETURN THIS.Atualizar()
	ENDPROC

	*====================================================================
	* Atualizar - Grava a descricao (portugues/traduzido) de volta em
	* SigCdPro e remove o produto da fila SigPrPrt. Espelha
	* literalmente o PROCEDURE gravacao do legado:
	*
	*   Update SigCdPro Set DscCompras = ..., ObsCompras = ..., DPros = ...
	*                   Where CPros = ...
	*   Delete From SigPrPrt Where CPros = ...
	*
	* tratando as duas instrucoes como uma unidade: se o Delete falhar
	* apos o Update ter sido aplicado, o legado reverte tudo (RollBack).
	* Conexao nasce em modo transacional manual (Transactions=2, memoria
	* feedback_conexao_sql_transactions_2_sem_commit) - commit/rollback
	* explicitos, no mesmo padrao de SigPrChrBO.ExecutarExclusao.
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		IF EMPTY(ALLTRIM(THIS.this_cCPros))
			THIS.this_cMensagemErro = "Produto sem c" + CHR(243) + "digo (CPros) para grava" + CHR(231) + CHR(227) + "o."
			RETURN .F.
		ENDIF

		THIS.this_cDPros = PADR(ALLTRIM(THIS.this_cPortugues), 40)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigCdPro
				SET DscCompras = <<EscaparSQL(THIS.this_cDscCompras)>>,
					ObsCompras = <<EscaparSQL(THIS.this_cObsCompras)>>,
					DPros = <<EscaparSQL(THIS.this_cDPros)>>
				WHERE CPros = <<EscaparSQL(THIS.this_cCPros)>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(THIS.this_cCPros)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado >= 0
					SQLCOMMIT(gnConnHandle)
					THIS.RegistrarAuditoria("UPDATE")
					THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					*-- legado: =fGravarLog([T], Upper(ThisForm.Name), Usuar,
					*-- [Falha na Conexao (Traducao)]) - wrapper no-op
					*-- (utils\fgravarlog.prg, Erro163_Aba1); retorno descartado
					*-- igual ao original, so para reproduzir a chamada.
					=fGravarLog("T", "SIGPRDSC", gc_4c_UsuarioLogado, ;
						"Falha na Conex" + CHR(227) + "o (Traducao)")
					*-- this_cMensagemErro fica preenchida; quem EXIBE eh
					*-- BusinessBase.Salvar()->ExibirFalha() - MsgErro aqui
					*-- duplicaria a mensagem (regra: falha nunca eh muda, mas
					*-- tambem nunca eh mostrada duas vezes)
					THIS.this_cMensagemErro = "Falha ao remover o produto " + ALLTRIM(THIS.this_cCPros) + ;
						" da fila de tradu" + CHR(231) + CHR(227) + "o (SigPrPrt):" + CHR(13) + CapturarErroSQL()
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
				THIS.this_cMensagemErro = "Falha ao gravar a descri" + CHR(231) + CHR(227) + "o do produto " + ;
					ALLTRIM(THIS.this_cCPros) + " em SigCdPro:" + CHR(13) + CapturarErroSQL()
			ENDIF

		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			THIS.this_cMensagemErro = loc_oErro.Message
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
