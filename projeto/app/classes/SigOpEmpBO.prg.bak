*====================================================================
* SigOpEmpBO.prg
*
* Business Object para SigOpEmp (Empenho)
* Form OPERACIONAL (dialogo filho, somente leitura): exibe os itens
* empenhados (reservados) de um produto especifico, recebidos do
* form pai (SigMvEtr/Etiqueta) atraves de um cursor ja montado
* ('CrEmpenhado' no legado - Emps+Dopes+Numes+Datas de SigMvCab
* juntado com Qtds de SigMvItn, filtrado pelo produto corrente).
*
* Tabelas envolvidas: SigMvCab, SigMvItn, SigCdGcr, SigCdCli, SigMvEtr
*====================================================================

DEFINE CLASS SigOpEmpBO AS BusinessBase

	*-- Propriedades da entidade (linha corrente do grid de empenhos)
	this_cEmps = ""              && Empresa (CrEmpenhado.Emps / SigMvCab.Emps)
	this_cDopes = ""             && Codigo da operacao (CrEmpenhado.Dopes / SigMvCab.Dopes)
	this_nNumes = 0              && Numero do movimento (CrEmpenhado.Numes / SigMvCab.Numes)
	this_dDatas = {}             && Data do movimento (CrEmpenhado.Datas / SigMvCab.Datas)
	this_cGrupoDs = ""           && Codigo do Grupo Destino do movimento (CrEmpenhado.GrupoDs / SigMvCab.Grupods)
	this_cContaDs = ""           && Codigo da Conta Destino do movimento (CrEmpenhado.ContaDs / SigMvCab.Contads)
	this_nQtds = 0               && Quantidade empenhada do item (CrEmpenhado.Qtds / SigMvItn.Qtds)

	*-- Propriedade recebida do form pai (filtro do empenho exibido)
	this_cProduto = ""           && Codigo do produto cujos empenhos sao exibidos (SigMvItn.Cpros / crSigMvEtr.Cpros do form pai)

	*-- Propriedades derivadas/exibidas no form (descricoes resolvidas por lookup
	*-- quando o usuario navega entre as linhas da grade - AfterRowColChange)
	this_cDescricaoGrupo = ""    && Descricao do Grupo Destino da linha corrente (SigCdGcr.Descrs), exibida em get_NGrupo
	this_cDescricaoConta = ""    && Descricao da Conta Destino da linha corrente (SigCdCli.Rclis), exibida em Get_NConta

	*-- Nome do cursor de listagem que este BO popula (equivalente a
	*-- CrEmpenhado do legado); mantido como propriedade para o Form
	*-- referenciar sem repetir o literal
	this_cCursorLista = "cursor_4c_Empenhado"

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "EmpDopNums"

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
	* cursor de listagem (cursor_4c_Empenhado, equivalente ao CrEmpenhado
	* do legado) para as propriedades this_* da linha selecionada na
	* grade - usado pelo Form em AfterRowColChange para resolver as
	* descricoes de Grupo/Conta da linha corrente.
	*   par_cAliasCursor - alias a ler; se omitido usa this_cCursorLista
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_lSucesso
		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			par_cAliasCursor, THIS.this_cCursorLista)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
		ELSE
			SELECT (loc_cAlias)

			IF EOF() OR BOF()
				THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
			ELSE
				THIS.this_cEmps     = TratarNulo(Emps, "")
				THIS.this_cDopes    = TratarNulo(Dopes, "")
				THIS.this_nNumes    = TratarNulo(Numes, 0)
				THIS.this_dDatas    = TratarNulo(Datas, {})
				THIS.this_cGrupoDs  = TratarNulo(GrupoDs, "")
				THIS.this_cContaDs  = TratarNulo(ContaDs, "")
				THIS.this_nQtds     = TratarNulo(Qtds, 0)

				*-- Resolve as descricoes da linha corrente, igual ao
				*-- Grade.AfterRowColChange do legado
				THIS.this_cDescricaoGrupo = THIS.ObterDescricaoGrupo(THIS.this_cGrupoDs)
				THIS.this_cDescricaoConta = THIS.ObterDescricaoConta(THIS.this_cContaDs)

				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave logica da linha de empenho corrente,
	* equivalente ao EmpDopNums usado no legado (Emps + Dopes + Numes
	* com 6 digitos). PROTECTED: de fora do BO nunca eh chamado
	* (CLAUDE.md regra #51).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave Emps+Dopes+Str(Numes,6) usada
	* pelo legado para localizar os itens (SigMvItn) de um movimento
	* (SigMvCab). Publico porque o Form tambem precisa montar essa
	* chave a partir da linha corrente do grid.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		*-- A chave eh POSICIONAL e tem 29 caracteres FIXOS: Emps char(3) +
		*-- Dopes char(20) + Str(Numes,6) = 29, exatamente a largura de
		*-- SigMvCab.EmpDopNums/SigMvItn.EmpDopNums (char(29) no
		*-- docs\schema.sql). ALLTRIM nas partes QUEBRA a busca em
		*-- SILENCIO (CLAUDE.md regra #42) - por isso PADR explicito, sem
		*-- confiar no padding que o cursor por acaso traz.
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* Inserir / Atualizar - SigOpEmp eh EXCLUSIVAMENTE uma tela de
	* CONSULTA (dialogo filho que mostra os itens empenhados/reservados
	* de um produto). O codigo fonte legado inteiro
	* (SigOpEmp_form_codigo_fonte.txt) foi conferido e NAO contem
	* nenhum comando de gravacao (Insert/Update/Delete/TableUpdate) - o
	* unico botao ("ok"/Encerrar) apenas chama ThisForm.Release(). Nao
	* existe chave nem tabela propria para gravar aqui, e inventar um
	* INSERT/UPDATE violaria o PILAR 2. Os dois metodos ficam
	* sobrescritos apenas para deixar a mensagem explicita -
	* RegistrarAuditoria() nunca eh chamado porque nenhuma gravacao
	* ocorre.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	PROTECTED PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "Empenho " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* CriarCursorEmpenhado - cria (ou recria) o cursor placeholder da
	* grade (cursor_4c_Empenhado), com a MESMA estrutura/ordem de colunas
	* usada por BuscarEmpenhosDoProduto() - o ponto UNICO de CREATE
	* CURSOR desta tela, para o Grid.ControlSource de ConfigurarPaginaLista
	* nunca referenciar alias ainda inexistente (CLAUDE.md regra #41).
	*   par_lForcarRecriar - .T. derruba e recria o alias mesmo existindo
	*====================================================================
	PROCEDURE CriarCursorEmpenhado(par_lForcarRecriar)
		LOCAL loc_cAlias, loc_lRecriar

		loc_cAlias = ALLTRIM(THIS.this_cCursorLista)
		loc_lRecriar = !USED(loc_cAlias)

		IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
			loc_lRecriar = .T.
		ENDIF

		IF loc_lRecriar
			IF USED(loc_cAlias)
				USE IN (loc_cAlias)
			ENDIF

			*-- Larguras conforme docs\schema.sql (SigMvCab/SigMvItn):
			*-- qtds numeric(9,3) -> N(10,3) (o ponto decimal entra na largura)
			CREATE CURSOR (loc_cAlias) ( ;
				Emps     C(3),    ;
				Dopes    C(20),   ;
				Numes    N(6, 0), ;
				Datas    T,       ;
				GrupoDs  C(10),   ;
				ContaDs  C(10),   ;
				Qtds     N(10, 3) )
		ENDIF

		RETURN USED(loc_cAlias)
	ENDPROC

	*====================================================================
	* BuscarEmpenhosDoProduto - Popula this_cCursorLista (cursor_4c_
	* Empenhado) com os movimentos que tem quantidade empenhada/
	* reservada (SigMvItn.Qtds) do produto informado, juntando o
	* cabecalho do movimento (SigMvCab) com o item (SigMvItn) pela
	* chave EmpDopNums - equivalente ao cursor 'CrEmpenhado' que o form
	* pai (SigMvEtr/Etiqueta) monta e deixa aberto antes de abrir este
	* dialogo (RecordSource = 'CrEmpenhado' no Init legado).
	*   par_cEmps    - empresa (filtra o cabecalho do movimento)
	*   par_cProduto - codigo do produto (SigMvItn.Cpros) cujos
	*                  empenhos devem ser exibidos
	*====================================================================
	FUNCTION BuscarEmpenhosDoProduto(par_cEmps, par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_lSucesso, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso  = .F.
		loc_cAliasTmp = "cursor_4c_EmpenhadoTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cProduto, "")))
			THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o informado"
			RETURN .F.
		ENDIF

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Datas, " + ;
					   "a.Grupods AS GrupoDs, a.Contads AS ContaDs, b.Qtds " + ;
					   "FROM SigMvCab a " + ;
					   "JOIN SigMvItn b ON a.EmpDopNums = b.EmpDopNums " + ;
					   "WHERE b.Cpros = " + EscaparSQL(ALLTRIM(par_cProduto))

			IF VARTYPE(par_cEmps) = "C" AND !EMPTY(ALLTRIM(par_cEmps))
				loc_cSQL = loc_cSQL + " AND a.Emps = " + EscaparSQL(ALLTRIM(par_cEmps))
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.Datas"

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado < 0
				THIS.this_cMensagemErro = "Erro ao buscar os empenhos do produto:" + ;
					CHR(13) + CapturarErroSQL()
			ELSE
				*-- NAO forcar recriacao do cursor aqui: o Grid da tela ja
				*-- esta com RecordSource/ControlSource ligados a este alias
				*-- (ConfigurarGrid roda ANTES da 1a chamada a este metodo).
				*-- Fechar/recriar o alias (USE IN + CREATE CURSOR) com o
				*-- Grid ja bindado zera o ColumnCount (mesmo efeito do
				*-- SQLEXEC direto sobre alias de grid - CLAUDE.md regra
				*-- correlata). CriarCursorEmpenhado() SEM forcar so cria se
				*-- ainda nao existir; existindo, ZAP + APPEND preserva a
				*-- estrutura e o binding do Grid.
				IF !THIS.CriarCursorEmpenhado(.F.)
					THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
						"vel preparar a lista de empenhos."
				ELSE
					SELECT (THIS.this_cCursorLista)
					ZAP
					IF loc_nResultado > 0
						APPEND FROM DBF(loc_cAliasTmp)
					ENDIF

					GO TOP IN (THIS.this_cCursorLista)
					loc_lSucesso = .T.
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterDescricaoGrupo - Descricao do Grupo Destino do movimento
	* (SigCdGcr.Descrs), equivalente ao
	* CursorQuery('SigCdGcr','crSigCdGcr','codigos',GrupoDs,[Descrs])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoGrupo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_GrupoDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(descrs, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

	*====================================================================
	* ObterDescricaoConta - Descricao da Conta Destino do movimento
	* (SigCdCli.Rclis), equivalente ao
	* CursorQuery('SigCdCli','crSigCdCli','iclis',ContaDs,[Rclis])
	* do legado (Grade.AfterRowColChange).
	*====================================================================
	FUNCTION ObterDescricaoConta(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_cDescricao, loc_oErro

		loc_cDescricao = ""
		loc_cAliasTmp  = "cursor_4c_ContaDsTmp"

		IF EMPTY(ALLTRIM(TratarNulo(par_cCodigo, ""))) ;
				OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			RETURN ""
		ENDIF

		TRY
			loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + ;
				EscaparSQL(ALLTRIM(par_cCodigo))

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

			IF loc_nResultado > 0
				SELECT (loc_cAliasTmp)
				IF !EOF()
					loc_cDescricao = TratarNulo(rclis, "")
				ENDIF
			ENDIF

			IF USED(loc_cAliasTmp)
				USE IN (loc_cAliasTmp)
			ENDIF
		CATCH TO loc_oErro
			loc_cDescricao = ""
		ENDTRY

		RETURN loc_cDescricao
	ENDFUNC

ENDDEFINE
