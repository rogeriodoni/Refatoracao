*==============================================================================
* SIGOPNOPBO.PRG
* Business Object para FormSIGOPNOP - Analise de OP/Envelopes
*
* Form OPERACIONAL de consulta (sem tabela unica): pesquisa movimentacoes de
* producao por numero de Envelope (SigCdNei/SigCdNec) ou por numero de O.P.
* (SigCdNei/SigCdNec/SigOpPic/SigPdMvf), monta a arvore de resultado e exibe
* a figura do produto (SigCdPro.FigJpgs) extraida para arquivo temporario.
*==============================================================================

DEFINE CLASS SIGOPNOPBO AS BusinessBase

	*-- Criterios de pesquisa (espelham Container1.GetOP e Container1.GetEnvelope do legado)
	this_nNumeroOP = 0
	this_nNumeroEnvelope = 0

	*-- Cursores de resultado populados pelas pesquisas (Fase 2)
	this_cCursorArvore = "cursor_4c_Arvore"
	this_cCursorProduto = "cursor_4c_Produto"
	this_lRegistroEncontrado = .F.

	*-- Figura do produto extraida de SigCdPro.FigJpgs para arquivo temporario
	this_cArquivoImagem = ""

	*-- REGISTRO CORRENTE da arvore de resultado (THIS.this_cCursorArvore),
	*-- carregado por CarregarDoCursor(). Os nomes espelham as colunas do cursor
	*-- (que por sua vez espelham as colunas do legado lidas no Scan de
	*-- MakeTree/MakeTreeEnv sobre CrSigCdNei).
	this_cCidchaves = ""
	this_nNenvs = 0
	this_cEmpDnPs = ""
	this_dDatas = {}
	this_cGrupoos = ""
	this_cContaos = ""
	this_cGrupods = ""
	this_cContads = ""
	this_lServicos = .F.
	this_nNops = 0
	this_cCmats = ""
	this_cDpros = ""
	this_nQtds = 0
	this_cCunis = ""
	this_nPeso2s = 0
	this_cCunips = ""
	this_nPesos = 0
	this_nTotPesos = 0
	this_cCpros = ""
	this_nNopMaes = 0

	*-- Decomposicao POSICIONAL de EmpDnPs char(33) = Emps(3) + Dopps(20) +
	*-- Str(Numps, 10). O legado decompoe assim no TreeView.DblClick:
	*-- Left(NodeCargo,3) / Substr(NodeCargo,4,20) / Val(Alltrim(Substr(NodeCargo,24)))
	this_cEmps = ""
	this_cDopps = ""
	this_nNumps = 0

	*==============================================================================
	* Init - Inicializa Business Object
	*==============================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Consulta multi-tabela (SigCdNei/SigCdNec/SigCdPro/SigOpPic/SigPdMvf):
		*-- nao existe tabela mestre unica. O registro eh identificado pela chave de
		*-- movimentacao EmpDnPs char(33), compartilhada pelas tabelas envolvidas.
		THIS.this_cTabela = ""
		THIS.this_cCampoChave = "EmpDnPs"

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_cCursorArvore = "cursor_4c_Arvore"
		THIS.this_cCursorProduto = "cursor_4c_Produto"
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""

		THIS.ResetarRegistroCorrente()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
	* sobrescritos aqui: este form eh de CONSULTA (pesquisa movimentacoes de
	* producao por Envelope ou O.P. em SigCdNei/SigCdNec/SigCdPro/SigOpPic/
	* SigPdMvf), sem INSERT/UPDATE/DELETE no legado - o unico efeito colateral
	* eh a extracao da figura do produto para um arquivo temporario (apagado ao
	* Encerrar). O comportamento padrao herdado de BusinessBase para
	* Inserir/Atualizar/ExecutarExclusao/RegistrarAuditoria ja eh o correto para
	* este BO.
	*
	* Conferido no dump legado (SIGOPNOP_form_codigo_fonte.txt): ZERO ocorrencia
	* de TABLEUPDATE(, ZERO de .AddCursor( e ZERO alvo de Insert Into / Update /
	* Delete From. O unico Delete do legado eh "Delete File (ThisForm.Arqfigura)",
	* que apaga o arquivo temporario da figura e nao toca no banco - reproduzido
	* aqui em ExcluirImagemTemporaria(). Inventar um INSERT/UPDATE para este BO
	* exigiria adivinhar a lista de colunas, o que a regra #22 do CLAUDE.md
	* proibe (a lista vem do schema, nunca de adivinhacao).
	*
	* ObterChavePrimaria() SIM eh sobrescrito, porque a identidade do registro
	* corrente (EmpDnPs) nao eh derivavel de this_cTabela/this_cCampoChave.
	*==============================================================================

	*==============================================================================
	* PesquisarPorEnvelope - Pesquisa movimentacoes de producao por numero de
	* Envelope. Equivale ao PROCEDURE Valid de Container1.GetEnvelope no legado
	* (SigCdNei/SigCdNec/SigCdPro), que monta o cursor CrSigCdNei consumido pela
	* arvore (ThisForm.MakeTreeEnv no legado).
	*==============================================================================
	PROCEDURE PesquisarPorEnvelope(par_nNumeroEnvelope)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroEnvelope) != "N" OR par_nNumeroEnvelope = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroEnvelope = par_nNumeroEnvelope

		loc_cSQL = "SELECT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, b.Grupoos, b.Contaos, " + ;
			"b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, a.Nops, a.Cmats, c.Dpros, a.Qtds, c.Cunis, " + ;
			"a.Peso2s, c.Cunips, a.Pesos, SPACE(14) AS Cpros, 0 AS NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroEnvelope, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			THIS.this_cMensagemErro = "Envelope N" + CHR(227) + "o Localizado !!!"
			USE IN cursor_4c_Nensi
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* PesquisarPorOP - Pesquisa movimentacoes de producao por numero de O.P.
	* Equivale ao PROCEDURE Valid de Container1.GetOP no legado: primeiro tenta a
	* consulta de movimentacao normal (SigCdNei/SigCdNec/SigCdPro/SigOpPic, nos
	* dois sentidos - O.P. propria e O.P. filha de um Envelope); se nao encontrar
	* nada, cai no fallback de O.P. ainda sem movimentacao gerada (SigPdMvf/
	* SigCdNec). Em qualquer dos dois casos, busca a figura do produto em
	* SigCdPro e extrai para arquivo temporario (THIS.this_cArquivoImagem).
	*==============================================================================
	PROCEDURE PesquisarPorOP(par_nNumeroOP)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cProduto

		THIS.this_cMensagemErro = ""
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cArquivoImagem = ""
		loc_lSucesso = .F.

		IF VARTYPE(par_nNumeroOP) != "N" OR par_nNumeroOP = 0
			RETURN .F.
		ENDIF

		THIS.this_nNumeroOP = par_nNumeroOP

		loc_cSQL = "SELECT DISTINCT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nops = d.Nops " + ;
			"UNION ALL " + ;
			"SELECT DISTINCT b.Cidchaves, a.Nenvs, a.EmpDnPs, b.Datas, " + ;
			"b.Grupoos, b.Contaos, b.Grupods, b.Contads, CAST(a.Servicos AS INT) AS Servicos, 0 AS Nops, " + ;
			"a.Cmats, c.Dpros, a.Qtds, c.Cunis, a.Peso2s, c.Cunips, a.Pesos, d.Cpros, d.NopMaes " + ;
			"FROM SigCdNei a, SigCdNec b, SigCdPro c, SigOpPic d " + ;
			"WHERE a.Nenvs = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.Nops <> " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
			" AND a.EmpDnPs = b.EmpDnPs AND a.Cmats = c.Cpros AND a.Nenvs = d.Nops " + ;
			"ORDER BY b.Cidchaves, a.Nops, a.Cmats"

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		SELECT cursor_4c_Nensi
		GO TOP

		IF EOF("cursor_4c_Nensi")
			*-- O.P. ainda sem movimentacao gerada - cai no fallback de SigPdMvf,
			*-- igual ao legado ("Nenhum" material agregado, pesos/qtds zerados)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF

			loc_cSQL = "SELECT b.Cidchaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas, " + ;
				"b.Grupoos, b.Contaos, b.Grupods, b.Contads, 0 AS Servicos, " + ;
				"0 AS Nops, 'Nenhum        ' AS Cmats, " + ;
				"'Nenhum Material Agregado' AS Dpros, 0 AS Qtds, '   ' AS Cunis, " + ;
				"0 AS Peso2s, '   ' AS Cunips, 0 AS Pesos, a.CodPds AS Cpros, 0 AS NopMaes " + ;
				"FROM SigPdMvf a, SigCdNec b " + ;
				"WHERE a.Nops = " + FormatarNumeroSQL(par_nNumeroOP, 0) + ;
				" AND a.EmpDnPs = b.EmpDnPs " + ;
				"ORDER BY b.Cidchaves, a.Nops"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nensi")

			IF loc_nResultado < 1
				THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
				RETURN .F.
			ENDIF

			SELECT cursor_4c_Nensi
			GO TOP

			IF EOF("cursor_4c_Nensi")
				THIS.this_cMensagemErro = "O.P. N" + CHR(227) + "o Localizada !!!"
				USE IN cursor_4c_Nensi
				RETURN .F.
			ENDIF
		ENDIF

		loc_cProduto = ALLTRIM(cursor_4c_Nensi.Cpros)

		IF !THIS.BuscarImagemProduto(loc_cProduto)
			IF USED("cursor_4c_Nensi")
				USE IN cursor_4c_Nensi
			ENDIF
			RETURN .F.
		ENDIF

		loc_lSucesso = THIS.MontarCursorArvore("cursor_4c_Nensi")

		IF USED("cursor_4c_Nensi")
			USE IN cursor_4c_Nensi
		ENDIF

		THIS.this_lRegistroEncontrado = loc_lSucesso

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarCursorArvore - Agrupa os pesos por movimentacao (EmpDnPs, excluindo
	* linhas de servico) e junta o total (TotPesos) a cada linha do cursor de
	* origem, gravando o resultado em THIS.this_cCursorArvore. Equivale ao bloco
	* final repetido no Valid de GetEnvelope e de GetOP do legado (Select ...
	* Sum(Pesos) ... Group by 1 + Select a.*, b.TotPesos ... Into Cursor
	* CrSigCdNei Order by CidChaves, Nops, Cmats).
	*==============================================================================
	PROTECTED PROCEDURE MontarCursorArvore(par_cCursorOrigem)
		LOCAL loc_cCursorTotais

		loc_cCursorTotais = "cursor_4c_Totais"

		IF !USED(par_cCursorOrigem)
			RETURN .F.
		ENDIF

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		SELECT EmpDnPs, SUM(Pesos) AS TotPesos FROM (par_cCursorOrigem) WHERE Servicos = 0 ;
			INTO CURSOR (loc_cCursorTotais) GROUP BY 1

		IF USED(THIS.this_cCursorArvore)
			USE IN (THIS.this_cCursorArvore)
		ENDIF

		SELECT a.*, b.TotPesos FROM (par_cCursorOrigem) a, (loc_cCursorTotais) b ;
			WHERE a.EmpDnPs = b.EmpDnPs ;
			INTO CURSOR (THIS.this_cCursorArvore) READWRITE ;
			ORDER BY a.CidChaves, a.Nops, a.Cmats

		IF USED(loc_cCursorTotais)
			USE IN (loc_cCursorTotais)
		ENDIF

		RETURN USED(THIS.this_cCursorArvore) AND RECCOUNT(THIS.this_cCursorArvore) > 0
	ENDPROC

	*==============================================================================
	* BuscarImagemProduto - Localiza o produto em SigCdPro e extrai a figura
	* (FigJpgs) para um arquivo .jpg temporario, exatamente como o legado faz no
	* final do Valid de GetOP (StrToFile sobre o campo memo). Ausencia de figura
	* NAO eh erro - THIS.this_cArquivoImagem fica vazio e o Form nao exibe nada.
	*==============================================================================
	PROTECTED PROCEDURE BuscarImagemProduto(par_cProduto)
		LOCAL loc_cSQL, loc_nResultado, loc_cNomeArquivo

		THIS.this_cArquivoImagem = ""

		IF VARTYPE(par_cProduto) != "C" OR EMPTY(ALLTRIM(par_cProduto))
			RETURN .T.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			USE IN (THIS.this_cCursorProduto)
		ENDIF

		loc_cSQL = "SELECT Cpros, Dpros, FigJpgs FROM SigCdPro WHERE Cpros = " + ;
			EscaparSQL(par_cProduto)

		loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProduto)

		IF loc_nResultado < 1
			THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! " + CapturarErroSQL()
			RETURN .F.
		ENDIF

		IF USED(THIS.this_cCursorProduto)
			SELECT (THIS.this_cCursorProduto)
			GO TOP

			IF !EOF() ;
					AND !EMPTY(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs")) ;
					AND !ISNULL(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"))

				loc_cNomeArquivo = SYS(2023) + "\" + ALLTRIM(SYS(2015)) + ".jpg"

				IF STRTOFILE(EVALUATE(THIS.this_cCursorProduto + ".FigJpgs"), loc_cNomeArquivo) > 0
					THIS.this_cArquivoImagem = loc_cNomeArquivo
				ENDIF
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC


	*==============================================================================
	* CarregarDoCursor - Carrega o registro CORRENTE do cursor da arvore para as
	* propriedades do BO. Eh o que o Form consome ao montar a arvore e ao tratar o
	* no selecionado: no legado, cada iteracao do "Scan" de MakeTree/MakeTreeEnv
	* le essas MESMAS colunas direto do cursor CrSigCdNei.
	*
	* Sem par_cAliasCursor assume THIS.this_cCursorArvore.
	*
	* A work area corrente eh SALVA e RESTAURADA: o Form chama este metodo de
	* dentro de lacos que percorrem o proprio cursor, e trocar a area sem repor
	* quebraria o SCAN do chamador. Por isso ha um unico RETURN, no fim.
	*==============================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso, loc_cChave

		loc_lSucesso = .F.

		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
			ALLTRIM(par_cAliasCursor), THIS.this_cCursorArvore)

		IF !USED(loc_cAlias)
			THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
				"o est" + CHR(225) + " aberto."
		ELSE
			loc_nAreaAnterior = SELECT()
			SELECT (loc_cAlias)

			*-- Cursor em EOF/BOF nao eh falha: apenas nao ha registro corrente
			*-- para carregar (a arvore chama este metodo dentro de laco)
			IF !EOF() AND !BOF()
				THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
				THIS.this_nNenvs     = TratarNulo(Nenvs, 0)
				THIS.this_cEmpDnPs   = TratarNulo(EmpDnPs, "")
				THIS.this_dDatas     = ConverterParaData(Datas)
				THIS.this_cGrupoos   = TratarNulo(Grupoos, "")
				THIS.this_cContaos   = TratarNulo(Contaos, "")
				THIS.this_cGrupods   = TratarNulo(Grupods, "")
				THIS.this_cContads   = TratarNulo(Contads, "")
				THIS.this_nNops      = TratarNulo(Nops, 0)
				THIS.this_cCmats     = TratarNulo(Cmats, "")
				THIS.this_cDpros     = TratarNulo(Dpros, "")
				THIS.this_nQtds      = TratarNulo(Qtds, 0)
				THIS.this_cCunis     = TratarNulo(Cunis, "")
				THIS.this_nPeso2s    = TratarNulo(Peso2s, 0)
				THIS.this_cCunips    = TratarNulo(Cunips, "")
				THIS.this_nPesos     = TratarNulo(Pesos, 0)
				THIS.this_cCpros     = TratarNulo(Cpros, "")
				THIS.this_nNopMaes   = TratarNulo(NopMaes, 0)

				*-- Servicos eh coluna bit no SQL Server. O SELECT do BO a traz
				*-- como CAST(... AS INT), entao chega SEMPRE numerica ao cursor.
				*-- A conversao aqui entrega um LOGICO de verdade ao Form, que
				*-- precisa dele para usar IIF() (IIF exige logico no 1o argumento).
				THIS.this_lServicos = ConverterParaLogico(TratarNulo(Servicos, 0))

				*-- TotPesos so existe no cursor da arvore (eh o total agregado por
				*-- movimentacao). Alias cru de SQLEXEC nao tem essa coluna, e nome
				*-- de campo inexistente estoura "Variable ... is not found" - por
				*-- isso o TYPE() antes (PEMSTATUS NAO serve para cursor).
				IF TYPE(loc_cAlias + ".TotPesos") = "N"
					THIS.this_nTotPesos = TratarNulo(EVALUATE(loc_cAlias + ".TotPesos"), 0)
				ELSE
					THIS.this_nTotPesos = 0
				ENDIF

				*-- EmpDnPs char(33) eh chave POSICIONAL: Emps(3) + Dopps(20) +
				*-- Str(Numps, 10). O legado decompoe exatamente nessas fatias
				*-- (Left / Substr / Val) no TreeView.DblClick. O PADR garante as
				*-- 33 posicoes antes de fatiar; NUNCA aplicar ALLTRIM nas partes
				*-- INTERIORES, porque o padding FAZ PARTE da chave.
				loc_cChave = PADR(THIS.this_cEmpDnPs, 33)
				THIS.this_cEmps  = LEFT(loc_cChave, 3)
				THIS.this_cDopps = SUBSTR(loc_cChave, 4, 20)
				THIS.this_nNumps = VAL(ALLTRIM(SUBSTR(loc_cChave, 24)))

				loc_lSucesso = .T.
			ENDIF

			IF loc_nAreaAnterior > 0
				SELECT (loc_nAreaAnterior)
			ENDIF
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==============================================================================
	* MontarChaveEmpDnPs - Remonta a chave POSICIONAL EmpDnPs:
	*     Emps char(3) + Dopps char(20) + Str(Numps, 10) = char(33)
	* A largura do char(33) destino (SigCdNei / SigCdNec / SigPdMvf / SigOpPic) eh
	* a conferencia da montagem: 3 + 20 + 10 = 33.
	*
	* PADR EXPLICITO em cada parte. ALLTRIM nas partes INTERIORES encurtaria a
	* chave, ela nunca casaria no WHERE e o SELECT devolveria ZERO linhas em
	* SILENCIO - sem erro e sem log. Nao confiar no padding que o cursor por
	* acaso traz: as propriedades do BO podem ter vindo de um TextBox.
	*==============================================================================
	PROCEDURE MontarChaveEmpDnPs(par_cEmps, par_cDopps, par_nNumps)
		LOCAL loc_cEmps, loc_cDopps, loc_nNumps

		loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopps = IIF(VARTYPE(par_cDopps) = "C", par_cDopps, "")
		loc_nNumps = IIF(VARTYPE(par_nNumps) = "N", par_nNumps, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopps, 20) + STR(loc_nNumps, 10)
	ENDPROC

	*==============================================================================
	* ObterChavePrimaria - Identidade do registro corrente, usada pela auditoria
	* da BusinessBase. Nesta consulta nao existe tabela mestre unica: o registro
	* eh identificado pela chave de movimentacao EmpDnPs, coluna char(33) que
	* SigCdNei, SigCdNec, SigPdMvf e SigOpPic compartilham.
	*
	* ALLTRIM aqui eh na chave INTEIRA (no fim), nao nas partes - isso eh
	* inofensivo, porque char no SQL Server compara com blank-padding ANSI.
	*==============================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		LOCAL loc_cChave

		loc_cChave = ALLTRIM(THIS.this_cEmpDnPs)

		IF EMPTY(loc_cChave)
			loc_cChave = ALLTRIM(THIS.MontarChaveEmpDnPs(THIS.this_cEmps, ;
				THIS.this_cDopps, THIS.this_nNumps))
		ENDIF

		RETURN loc_cChave
	ENDPROC

	*==============================================================================
	* ResetarRegistroCorrente - Zera as propriedades do registro corrente da
	* arvore. Chamado pelo Init e pelo LimparDados: o Form nao eh fechado entre
	* uma pesquisa e outra, entao sem este reset a pesquisa seguinte exibiria
	* residuo da anterior quando o novo cursor viesse vazio.
	*==============================================================================
	PROTECTED PROCEDURE ResetarRegistroCorrente()
		THIS.this_cCidchaves = ""
		THIS.this_nNenvs     = 0
		THIS.this_cEmpDnPs   = ""
		THIS.this_dDatas     = {}
		THIS.this_cGrupoos   = ""
		THIS.this_cContaos   = ""
		THIS.this_cGrupods   = ""
		THIS.this_cContads   = ""
		THIS.this_lServicos  = .F.
		THIS.this_nNops      = 0
		THIS.this_cCmats     = ""
		THIS.this_cDpros     = ""
		THIS.this_nQtds      = 0
		THIS.this_cCunis     = ""
		THIS.this_nPeso2s    = 0
		THIS.this_cCunips    = ""
		THIS.this_nPesos     = 0
		THIS.this_nTotPesos  = 0
		THIS.this_cCpros     = ""
		THIS.this_nNopMaes   = 0
		THIS.this_cEmps      = ""
		THIS.this_cDopps     = ""
		THIS.this_nNumps     = 0

		RETURN .T.
	ENDPROC

	*==============================================================================
	* LimparDados - Zera criterios de pesquisa e registro corrente, fechando os
	* cursores de resultado. O Form chama isto ao limpar a tela (no legado os dois
	* TextBox se zeram mutuamente: GetOP.GotFocus zera GetEnvelope e o GotFocus de
	* GetEnvelope zera GetOP).
	*==============================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_nNumeroOP = 0
		THIS.this_nNumeroEnvelope = 0
		THIS.this_lRegistroEncontrado = .F.
		THIS.this_cMensagemErro = ""

		THIS.ResetarRegistroCorrente()
		THIS.FecharCursoresResultado()

		RETURN .T.
	ENDPROC

	*==============================================================================
	* FecharCursoresResultado - Fecha os cursores de resultado da consulta.
	*
	* O guard eh pelo BUFFERING, nao so pelo USED(): TABLEREVERT() EXIGE row ou
	* table buffering e, sem ele, dispara o erro 1586 em vez de ser no-op. Cursor
	* nascido de CREATE CURSOR ou de SELECT INTO CURSOR vem com Buffering = 1, e
	* nesse caso USE IN fecha o alias sozinho, mesmo com buffer sujo.
	*==============================================================================
	PROCEDURE FecharCursoresResultado()
		LOCAL ARRAY loc_aCursores[3]
		LOCAL loc_nI, loc_cCursor

		loc_aCursores[1] = THIS.this_cCursorArvore
		loc_aCursores[2] = THIS.this_cCursorProduto
		loc_aCursores[3] = "cursor_4c_Nensi"

		FOR loc_nI = 1 TO ALEN(loc_aCursores)
			loc_cCursor = loc_aCursores[loc_nI]

			IF VARTYPE(loc_cCursor) = "C" AND !EMPTY(loc_cCursor) AND USED(loc_cCursor)
				IF CURSORGETPROP("Buffering", loc_cCursor) > 1
					TABLEREVERT(.T., loc_cCursor)
				ENDIF
				USE IN (loc_cCursor)
			ENDIF
		ENDFOR

		RETURN .T.
	ENDPROC

	*==============================================================================
	* ExcluirImagemTemporaria - Apaga o .jpg que BuscarImagemProduto extraiu de
	* SigCdPro.FigJpgs. Equivale ao "Delete File (ThisForm.Arqfigura)" que o legado
	* executa no Click do botao de saida (Commandgroup1).
	*
	* CLEAR RESOURCES antes de apagar: o VFP mantem o bitmap em cache e o arquivo
	* fica preso enquanto o cache nao eh liberado (o legado faz o mesmo antes de
	* trocar a figura). SET SAFETY OFF em volta do DELETE FILE porque com SAFETY ON
	* ele abre dialogo de confirmacao, e dialogo modal travaria o pipeline.
	*==============================================================================
	PROCEDURE ExcluirImagemTemporaria()
		LOCAL loc_cArquivo, loc_cSafety

		loc_cArquivo = ALLTRIM(THIS.this_cArquivoImagem)
		THIS.this_cArquivoImagem = ""

		IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
			CLEAR RESOURCES

			loc_cSafety = SET("SAFETY")
			SET SAFETY OFF

			DELETE FILE (loc_cArquivo)

			IF loc_cSafety = "ON"
				SET SAFETY ON
			ENDIF
		ENDIF

		RETURN .T.
	ENDPROC

	*==============================================================================
	* Destroy - Libera os cursores de resultado e o arquivo temporario da figura.
	*==============================================================================
	PROCEDURE Destroy()
		THIS.ExcluirImagemTemporaria()
		THIS.FecharCursoresResultado()

		DODEFAULT()
	ENDPROC
ENDDEFINE
