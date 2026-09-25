*====================================================================
* SigMvSbnBO.prg
*
* Business Object para SigMvSbn (Subniveis de Movimento)
* Form OPERACIONAL: exibe os subniveis (SigMvPec/SigOpDev + SigMvCab)
* de uma operacao/movimento especifico, e os itens (SigMvItn) do
* subnivel selecionado, alem da imagem/descricao do produto (SigCdPro).
*
* Tabelas envolvidas: SigMvPec, SigOpDev, SigMvCab, SigCdOpe, SigStats,
*                      SigMvItn, SigCdPro, SigCdGrp, SigCdEmp, SigCdPam,
*                      SigCdOpd
*====================================================================

DEFINE CLASS SigMvSbnBO AS BusinessBase

	*-- Propriedades da entidade (parametros recebidos do form pai)
	this_cEmps = ""                && Empresa (SigMvCab.Emps / lpEmps)
	this_cDopes = ""                && Codigo da operacao (SigMvCab.Dopes / lpDopes)
	this_nNumes = 0                 && Numero do movimento (SigMvCab.Numes / lpNumes)
	this_cCursorOrigem = ""         && Nome do cursor de origem recebido do form pai (lpCursor)

	*-- Propriedades derivadas/calculadas
	this_cCaption = ""              && Titulo montado: "Subniveis - <Dopes> ( <Numes> )"
	this_cDescricaoOperacao = ""    && Descricao da operacao (SigCdOpe.nDopes / crXOpe)
	this_nCodigoBusca = 0           && Codigo calculado: (Dopes numerico * 1000000) + Numes
	this_lAcOficina = .F.           && Indica se o usuario tem acesso ao botao Oficina (fChecaAcesso OPPEND)
	this_lOcultaPrs = .F.           && Indica se a grade fwGrade deve ficar oculta (fChecaAcesso OCULTAPRS)

	*-- Propriedades do subnivel selecionado na grade principal (TmpSubN)
	this_nOrdes = 0                 && Ordem do subnivel (TmpSubN.Ordes)
	this_dDatas = {}                && Data do movimento do subnivel (TmpSubN.Datas)
	this_cNotas = ""                && Numero da nota/documento (TmpSubN.Notas)
	this_cDescricaoProduto = ""     && Descricao do produto exibida (Get_descr)
	this_nValorTotal = 0            && Valor total do subnivel selecionado (Get_valo / TmpSubN.Valos)
	this_nValorInicial = 0          && Valor inicial do subnivel selecionado (Get_items / TmpSubN.ValInis)
	this_cUsuars = ""               && Usuario responsavel pelo subnivel (TmpSubN.Usuars)
	this_nNops = 0                  && Numero da ordem de producao vinculada (TmpSubN.Nops)
	this_dPrazoEnts = {}            && Prazo de entrega do subnivel (TmpSubN.PrazoEnts)
	this_cPstatus = ""              && Codigo do status do subnivel (TmpSubN.pstatus)
	this_cDescStatus = ""           && Descricao do status (TmpSubN.Descs / SigStats.descs)

	*-- Nomes dos cursores que este BO popula/consome (mantidos como
	*-- propriedade para o Form referenciar sem repetir literais)
	this_cCursorLista = "cursor_4c_Subniveis"    && Grid principal (equivalente a TmpSubN do legado)
	this_cCursorItens = "cursor_4c_Itens"        && Grid de itens do subnivel selecionado (crTpmMvItnSubn)
	this_cCursorProduto = "cursor_4c_Produto"    && Dados/imagem do produto exibido (crTmpPro / crTPro)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "Numes"

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
	* cursor de listagem (cursor_4c_Subniveis, equivalente ao TmpSubN do
	* legado) para as propriedades this_* do subnivel selecionado.
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
				THIS.this_nOrdes        = TratarNulo(Ordes, 0)
				THIS.this_cEmps         = TratarNulo(Emps, "")
				THIS.this_cDopes        = TratarNulo(Dopes, "")
				THIS.this_nNumes        = TratarNulo(Numes, 0)
				THIS.this_dDatas        = TratarNulo(Datas, {})
				THIS.this_cNotas        = TratarNulo(Notas, "")
				THIS.this_nValorTotal   = TratarNulo(Valos, 0)
				THIS.this_nValorInicial = TratarNulo(ValInis, 0)
				THIS.this_cUsuars       = TratarNulo(Usuars, "")
				THIS.this_nNops         = TratarNulo(Nops, 0)
				THIS.this_dPrazoEnts    = TratarNulo(PrazoEnts, {})
				THIS.this_cPstatus      = TratarNulo(pstatus, "")
				THIS.this_cDescStatus   = TratarNulo(Descs, "")

				loc_lSucesso = .T.
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Chave logica do subnivel corrente, equivalente
	* ao EmpDopNums usado no legado (Emps + Dopes + Numes com 6 digitos)
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* MontarChaveEmpDopNums - Monta a chave Emps+Dopes+Str(Numes,6) usada
	* pelo legado (lcEmpDopNums) para filtrar os itens (SigMvItn) do
	* subnivel selecionado. Publico porque o Form tambem precisa montar
	* essa chave a partir da linha corrente do grid antes de chamar
	* BuscarItensSubnivel().
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		*-- A chave eh POSICIONAL e tem 29 caracteres FIXOS. O legado monta
		*-- "TmpSubN.Emps + TmpSubN.Dopes + Str(TmpSubN.Numes, 6)" SEM ALLTRIM:
		*-- como Emps eh char(3) e Dopes eh char(20), a concatenacao ja sai
		*-- com o padding das colunas - 3 + 20 + 6 = 29, exatamente a largura
		*-- de SigMvItn.EmpDopNums / SigMvCab.EmpDopNums (char(29) no
		*-- docs\schema.sql).
		*--
		*-- ALLTRIM aqui QUEBRA a busca em silencio: "001" + "MALOTE" + "     3"
		*-- da 15 caracteres ("001MALOTE     3") e nunca casa com o valor
		*-- gravado, que eh "001MALOTE                   3". O SQL roda sem
		*-- erro e devolve ZERO linhas, entao a grade de itens fica sempre
		*-- vazia e a descricao/imagem do produto nunca carregam.
		*--
		*-- PADR explicito (em vez de confiar no padding do cursor) porque
		*-- ObterChavePrimaria() chama este metodo com as properties
		*-- this_cEmps/this_cDopes, que o Init do Form guarda JA com ALLTRIM.
		RETURN PADR(TratarNulo(par_cEmps, ""), 3) + ;
		       PADR(TratarNulo(par_cDopes, ""), 20) + ;
		       STR(TratarNulo(par_nNumes, 0), 6)
	ENDFUNC

	*====================================================================
	* Inserir / Atualizar - SigMvSbn eh EXCLUSIVAMENTE uma tela de
	* CONSULTA (mostra subniveis e itens de um movimento ja gravado por
	* outras telas do sistema). O codigo fonte legado inteiro
	* (SigMvSbn_form_codigo_fonte.txt) foi conferido e NAO contem nenhum
	* comando de gravacao (Insert/Update/Delete/TableUpdate/Gather) - so
	* consultas (SqlExecute) e navegacao entre grades. Nao existe chave
	* nem tabela para gravar aqui, e inventar um INSERT/UPDATE violaria o
	* PILAR 2 (nunca gravar algo que o legado nao grava). Por isso os dois
	* metodos ficam sobrescritos apenas para deixar a mensagem explicita -
	* RegistrarAuditoria() nunca eh chamado porque nenhuma gravacao ocorre.
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		THIS.this_cMensagemErro = "SigMvSbn " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	PROTECTED PROCEDURE Atualizar()
		THIS.this_cMensagemErro = "SigMvSbn " + CHR(233) + " uma tela de consulta - n" + ;
			CHR(227) + "o grava registros."
		RETURN .F.
	ENDPROC

	*====================================================================
	* BuscarSubniveis - Popula this_cCursorLista com os subniveis do
	* movimento (SigMvPec + SigOpDev, unidos por Codigos), replicando o
	* Init() do legado. Tambem resolve this_nCodigoBusca, this_lAcOficina
	* e this_lOcultaPrs (usados pelo Form para montar a tela).
	*====================================================================
	FUNCTION BuscarSubniveis(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo, loc_cUsuario, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			IF USED("cursor_4c_SbnOpeTmp")
				USE IN cursor_4c_SbnOpeTmp
			ENDIF

			loc_cSQL = "SELECT nDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnOpeTmp")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigCdOpe)"
			ELSE
				SELECT cursor_4c_SbnOpeTmp

				IF EOF()
					THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(par_cDopes) + ;
						" n" + CHR(227) + "o cadastrada em SigCdOpe."
				ELSE
					THIS.this_nCodigoBusca = (cursor_4c_SbnOpeTmp.nDopes * 1000000) + par_nNumes
					loc_nCodigo = THIS.this_nCodigoBusca

					loc_cUsuario = TratarNulo(gc_4c_UsuarioLogado, "")
					THIS.this_lAcOficina = fChecaAcesso(PADL(TRANSFORM(cursor_4c_SbnOpeTmp.nDopes), 8, "0"), "OPPEND")
					THIS.this_lOcultaPrs = (UPPER(ALLTRIM(loc_cUsuario)) <> "4CONTROL") AND ;
						fChecaAcesso(PADL(TRANSFORM(cursor_4c_SbnOpeTmp.nDopes), 8, "0"), "OCULTAPRS")

					loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, " + ;
						"b.Nops, b.Datars, c.Ordes, b.PrazoEnts, b.pstatus, ISNULL(d.descs, SPACE(20)) AS Descs " + ;
						"FROM SigMvPec a " + ;
						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;
						"JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
						"LEFT JOIN SigStats d ON b.pstatus = d.cods " + ;
						"WHERE a.Codigos = " + STR(loc_nCodigo, 10) + ;
						" AND a.EmpSubns = " + EscaparSQL(ALLTRIM(par_cEmps)) + " " + ;
						"UNION ALL " + ;
						"SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Notas, b.Valos, b.ValInis, b.Usuars, " + ;
						"b.Nops, b.Datars, c.Ordes, b.PrazoEnts, b.pstatus, ISNULL(d.descs, SPACE(20)) AS Descs " + ;
						"FROM SigOpDev a " + ;
						"JOIN SigMvCab b ON a.EmpDopnums = b.EmpDopNums " + ;
						"JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
						"LEFT JOIN SigStats d ON b.pstatus = d.cods " + ;
						"WHERE a.Codigos = " + STR(loc_nCodigo, 10) + " " + ;
						"ORDER BY b.Datars"

					IF USED("cursor_4c_SbnListaTmp")
						USE IN cursor_4c_SbnListaTmp
					ENDIF

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnListaTmp")

					IF loc_nResultado < 1
						THIS.this_cMensagemErro = "Favor reinicializar o processo. (Subn" + CHR(237) + "veis)"
					ELSE
						IF RECCOUNT("cursor_4c_SbnListaTmp") = 0
							THIS.this_cMensagemErro = "Nenhum registro encontrado."
						ELSE
							IF USED(THIS.this_cCursorLista)
								USE IN (THIS.this_cCursorLista)
							ENDIF

							SELECT Ordes, Emps, Dopes, Numes, Datas, Notas, Valos, ValInis, Usuars, Nops, PrazoEnts, pstatus, Descs ;
								FROM cursor_4c_SbnListaTmp ;
								INTO CURSOR (THIS.this_cCursorLista) READWRITE

							SELECT (THIS.this_cCursorLista)
							REPLACE ALL PrazoEnts WITH {} FOR ISNULL(PrazoEnts)
							INDEX ON DTOS(Datas) + STR(Ordes, 4) + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
							GO TOP

							loc_lSucesso = .T.
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SbnOpeTmp")
				USE IN cursor_4c_SbnOpeTmp
			ENDIF
			IF USED("cursor_4c_SbnListaTmp")
				USE IN cursor_4c_SbnListaTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarItensSubnivel - Popula this_cCursorItens com os itens
	* (SigMvItn) do subnivel selecionado, replicando Grade.AfterRowColChange
	*   par_cEmpDopNums - chave montada por MontarChaveEmpDopNums()
	*====================================================================
	FUNCTION BuscarItensSubnivel(par_cEmpDopNums)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			*-- SEM ALLTRIM: a chave eh posicional de 29 caracteres (ver
			*-- MontarChaveEmpDopNums). O legado tambem embute o valor cru
			*-- ("...EmpDopNums = '" + lcEmpDopNums + "'"). Trimar aqui seria
			*-- reintroduzir pela porta de tras o defeito que a chave acabou
			*-- de consertar caso o formato de Numes mude.
			loc_cSQL = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

			IF USED("cursor_4c_ItnTmp")
				USE IN cursor_4c_ItnTmp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnTmp")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor reinicializar o processo. (Itens do Subn" + CHR(237) + "vel)"
			ELSE
				IF USED(THIS.this_cCursorItens)
					USE IN (THIS.this_cCursorItens)
				ENDIF

				SELECT * FROM cursor_4c_ItnTmp INTO CURSOR (THIS.this_cCursorItens) READWRITE

				SELECT (THIS.this_cCursorItens)
				GO TOP

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItnTmp")
				USE IN cursor_4c_ItnTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarDadosProduto - Popula this_cCursorProduto com Cpros/FigJpgs/
	* Dpros/Cgrus/Dgrus (join SigCdPro+SigCdGrp), replicando a consulta
	* feita em Grade.AfterRowColChange apos carregar os itens do subnivel.
	* Tambem atualiza this_cDescricaoProduto (Get_descr).
	*====================================================================
	FUNCTION BuscarDadosProduto(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT a.Cpros, a.FigJpgs, a.dpros, a.Cgrus, b.Dgrus " + ;
				"FROM SigCdPro a, SigCdGrp b " + ;
				"WHERE a.Cpros = " + EscaparSQL(ALLTRIM(par_cCpros)) + " AND a.Cgrus = b.Cgrus"

			IF USED(THIS.this_cCursorProduto)
				USE IN (THIS.this_cCursorProduto)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Dados do Produto)"
			ELSE
				SELECT (THIS.this_cCursorProduto)
				GO TOP

				THIS.this_cDescricaoProduto = TratarNulo(dpros, "")

				loc_lSucesso = .T.
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* BuscarImagemProdutoPorCodigo - Versao enxuta (Cpros/FigJpgs/Dpros,
	* sem grupo), replicando fwgrade.AfterRowColChange (CursorQuery do
	* legado quando o usuario navega dentro da grade de itens).
	*====================================================================
	FUNCTION BuscarImagemProdutoPorCodigo(par_cCpros)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

			IF USED(THIS.this_cCursorProduto)
				USE IN (THIS.this_cCursorProduto)
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
			ELSE
				SELECT (THIS.this_cCursorProduto)
				GO TOP

				THIS.this_cDescricaoProduto = TratarNulo(Dpros, "")

				loc_lSucesso = .T.
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterNumeroOS - Replica BtnOficina.Click: calcula o numero da OS
	* (lcNumps do legado) a partir de Empresa (SigCdEmp.NEmps), do
	* departamento de servicos (SigCdPam.DoppServs) e da sequencia da
	* operacao de servicos (SigCdOpd.nSeqs). Retorna 0 em caso de falha
	* (this_cMensagemErro fica preenchido); o Form so abre SigRePhi
	* quando o retorno for > 0.
	*====================================================================
	FUNCTION ObterNumeroOS(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_nNEmps, loc_nSeqs, loc_cNEmps, loc_cSeqs, loc_cNumes, loc_nNumps, loc_lSucesso

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_nNumps = 0

		IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel"
			RETURN 0
		ENDIF

		TRY
			loc_cSQL = "SELECT NEmps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cEmps))

			IF USED("cursor_4c_SbnEmpTmp")
				USE IN cursor_4c_SbnEmpTmp
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnEmpTmp")

			IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnEmpTmp") = 0
				THIS.this_cMensagemErro = "Empresa " + ALLTRIM(par_cEmps) + " n" + CHR(227) + "o cadastrada em SigCdEmp."
			ELSE
				loc_nNEmps = cursor_4c_SbnEmpTmp.NEmps

				loc_cSQL = "SELECT DoppServs FROM SigCdPam"

				IF USED("cursor_4c_SbnPamTmp")
					USE IN cursor_4c_SbnPamTmp
				ENDIF

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnPamTmp")

				IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnPamTmp") = 0
					THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
						"metros do Sistema n" + CHR(227) + "o encontrada (SigCdPam)."
				ELSE
					loc_cSQL = "SELECT nSeqs FROM SigCdOpd WHERE Dopps = " + ;
						EscaparSQL(ALLTRIM(TratarNulo(cursor_4c_SbnPamTmp.DoppServs, "")))

					IF USED("cursor_4c_SbnOpdTmp")
						USE IN cursor_4c_SbnOpdTmp
					ENDIF

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SbnOpdTmp")

					IF loc_nResultado < 1 OR RECCOUNT("cursor_4c_SbnOpdTmp") = 0
						THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de servi" + CHR(231) + ;
							"os n" + CHR(227) + "o cadastrada em SigCdOpd."
					ELSE
						loc_nSeqs = cursor_4c_SbnOpdTmp.nSeqs

						loc_cNEmps = ALLTRIM(STR(loc_nNEmps))
						loc_cSeqs  = ALLTRIM(STR(loc_nSeqs))
						loc_cNumes = PADL(ALLTRIM(STR(par_nNumes)), 6, "0")

						loc_nNumps = INT(VAL(loc_cNEmps + loc_cSeqs + loc_cNumes))

						loc_lSucesso = .T.
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SbnEmpTmp")
				USE IN cursor_4c_SbnEmpTmp
			ENDIF
			IF USED("cursor_4c_SbnPamTmp")
				USE IN cursor_4c_SbnPamTmp
			ENDIF
			IF USED("cursor_4c_SbnOpdTmp")
				USE IN cursor_4c_SbnOpdTmp
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			loc_lSucesso = .F.
			loc_nNumps = 0
		ENDTRY

		RETURN loc_nNumps
	ENDFUNC

ENDDEFINE
