*====================================================================
* SigOpChpBO.prg
*
* Business Object para SigOpChp (Prorrogar vencimento de cheque)
* Tabela principal: SigChe (chave: nums)
*
* Form original: dialogo modal MODAL aberto a partir de um form pai
* (ThisForm.ParentForm), que prorroga o vencimento de um cheque
* (SigChe), calcula e grava juros de prorrogacao (SigMvCcr) e
* registra o historico de alteracao de vencimento (SigChea).
*====================================================================

DEFINE CLASS SigOpChpBO AS BusinessBase

	*-- Dados do cheque sendo prorrogado (SigChe)
	this_cNums = ""
	this_dVencs = {}
	this_nValors = 0
	this_cBancos = ""
	this_cAgencias = ""
	this_cNContas = ""
	this_cNCheques = ""
	this_cIClis = ""
	this_cGrClis = ""

	*-- Dados digitados/calculados na tela de prorrogacao
	this_dVencNovo = {}
	this_nDias = 0
	this_nJuros = 0
	this_nValJuros = 0

	*-- Parametros do sistema (SigCdPam) usados na prorrogacao
	this_cMoedaCheqs = ""
	this_cContaJuros = ""
	this_cGrupoJuros = ""
	this_nDiaPrors = 0

	*-- Chave de sessao do usuario (CrSigCdPac.SigKeys)
	this_cSigKey = ""

	*-- Flag: .T. depois da 1a chamada de CarregarParametrosSistema()
	this_lParametrosCarregados = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela = "SigChe"
		THIS.this_cCampoChave = "nums"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Nums (char(8)) do cheque sendo prorrogado
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cNums
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia os campos de SigChe (par_cAliasCursor)
	* para as propriedades de exibicao do dialogo. Os campos digitados
	* pelo usuario (this_dVencNovo/this_nDias/this_nJuros/this_nValJuros)
	* NAO sao tocados aqui - ficam vazios/zero, a espera da digitacao.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cNums     = ALLTRIM(TratarNulo(nums, ""))
			THIS.this_dVencs    = TratarNulo(vencs, {})
			THIS.this_nValors   = TratarNulo(valors, 0)
			THIS.this_cBancos   = ALLTRIM(TratarNulo(bancos, ""))
			THIS.this_cAgencias = ALLTRIM(TratarNulo(agencias, ""))
			THIS.this_cNContas  = ALLTRIM(TratarNulo(ncontas, ""))
			THIS.this_cNCheques = ALLTRIM(TratarNulo(ncheques, ""))
			THIS.this_cIClis    = ALLTRIM(TratarNulo(iclis, ""))
			THIS.this_cGrClis   = ALLTRIM(TratarNulo(grclis, ""))

			THIS.this_lNovoRegistro = .F.
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Unica validacao do legado (Prorroga.Click:483-487):
	* o novo vencimento nao pode ficar em branco.
	*====================================================================
	PROCEDURE ValidarDados()
		IF ISNULL(THIS.this_dVencNovo) OR EMPTY(THIS.this_dVencNovo)
			THIS.this_cMensagemErro = "Vencimento n" + CHR(227) + "o pode ficar em branco!"
			RETURN .F.
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarParametrosSistema - Carrega os parametros de SigCdPam
	* (Conta/Grupo de Juros, Moeda de Cheques, Dias para bloqueio) e a
	* chave de sessao de SigCdPac.SigKeys (Init do legado:400-403).
	* Chamado de forma preguicosa (lazy) a partir de Atualizar(), para
	* o BO ficar autossuficiente independente da ordem de chamada do form.
	*====================================================================
	PROTECTED PROCEDURE CarregarParametrosSistema()
		LOCAL loc_nResultado, loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Pam")
				USE IN cursor_4c_Pam
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT TOP 1 contajuros, grupojuros, moedacheqs, diaprors FROM SigCdPam", ;
				"cursor_4c_Pam")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pam") > 0
				SELECT cursor_4c_Pam
				THIS.this_cContaJuros = ALLTRIM(NVL(contajuros, ""))
				THIS.this_cGrupoJuros = ALLTRIM(NVL(grupojuros, ""))
				THIS.this_cMoedaCheqs = IIF(EMPTY(ALLTRIM(NVL(moedacheqs, ""))), "R", ALLTRIM(moedacheqs))
				THIS.this_nDiaPrors   = NVL(diaprors, 0)
			ENDIF

			IF USED("cursor_4c_Pam")
				USE IN cursor_4c_Pam
			ENDIF

			IF USED("cursor_4c_Pac")
				USE IN cursor_4c_Pac
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, "SELECT TOP 1 sigkeys FROM SigCdPac", "cursor_4c_Pac")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Pac") > 0
				SELECT cursor_4c_Pac
				THIS.this_cSigKey = ALLTRIM(NVL(sigkeys, ""))
			ENDIF

			IF USED("cursor_4c_Pac")
				USE IN cursor_4c_Pac
			ENDIF

			THIS.this_lParametrosCarregados = .T.
			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarCidChaveMvCcr - Reproduz a formula do legado (Prorroga.Click:
	* 530/579) para a CidChaves de cada lancamento de SigMvCcr:
	*   pCidC = Dtos(Datetime()) + Transform(fGerUniqueKey(Dtos(Datetime())),
	*           "@L 999999") + ThisForm.sigkey
	* Chamada DUAS vezes (uma por linha) para gerar valores distintos -
	* fGerUniqueKey incrementa a sequencia a cada chamada.
	*====================================================================
	PROTECTED PROCEDURE GerarCidChaveMvCcr()
		RETURN LEFT(DTOS(DATETIME()) + ;
			TRANSFORM(fGerUniqueKey(DTOS(DATETIME())), "@L 999999") + ;
			THIS.this_cSigKey, 20)
	ENDPROC

	*====================================================================
	* AdicionarCampoSQL - Acumula par (coluna, valor-SQL-ja-formatado) nas
	* strings de colunas/valores passadas por referencia. Usado para
	* montar o INSERT de SigMvCcr (78 colunas NOT NULL - regra #22) sem
	* risco de desalinhamento por contagem manual de virgulas: cada
	* coluna e o seu valor ficam juntos na MESMA linha de chamada.
	*====================================================================
	PROTECTED PROCEDURE AdicionarCampoSQL(par_cCols, par_cVals, par_cColuna, par_cValorSQL)
		par_cCols = par_cCols + IIF(EMPTY(par_cCols), "", ",") + par_cColuna
		par_cVals = par_cVals + IIF(EMPTY(par_cVals), "", ",") + par_cValorSQL
	ENDPROC

	*====================================================================
	* MontarLancamentoSigMvCcr - Monta o INSERT de uma linha de SigMvCcr,
	* cobrindo as 74 colunas NOT NULL da tabela + vencs/datas/datalts/
	* hists (nullable, mas sempre preenchidas pelo legado). Colunas nao
	* referenciadas pelo Prorroga.Click do legado (regra #22) recebem o
	* mesmo "branco"/"zero" que o Append Blank do cursor legado geraria.
	*
	* Parametros:
	*   par_cCidChave  - CidChaves (PK) desta linha
	*   par_cGrupo/par_cConta/par_cMoeda/par_nCotacao/par_nValor - lado
	*     principal (grupos/contas/moedas/cotacaos/valors/opers)
	*   par_cOpers     - "C" ou "D" (lado principal)
	*   par_cSGrupo/par_cSConta/par_cSMoeda/par_nSCotacao/par_nSValor -
	*     lado contrapartida (sgrupos/scontas/smoedas/scotacaos/svalors)
	*   par_cSOpers    - "C" ou "D" (lado contrapartida, oposto de par_cOpers)
	*   par_nNoper     - numero da operacao (fGerUniqueKey, igual nas 2 linhas)
	*   par_cHist      - texto de historico (igual nas 2 linhas)
	*   par_tDatas     - data/hora da operacao (datas/vencs)
	*   par_tDatalts   - data/hora da ultima alteracao (datalts)
	*====================================================================
	PROTECTED PROCEDURE MontarLancamentoSigMvCcr(par_cCidChave, ;
			par_cGrupo, par_cConta, par_cMoeda, par_nCotacao, par_nValor, par_cOpers, ;
			par_cSGrupo, par_cSConta, par_cSMoeda, par_nSCotacao, par_nSValor, par_cSOpers, ;
			par_nNoper, par_cHist, par_tDatas, par_tDatalts)

		LOCAL loc_cCols, loc_cVals, loc_cGruConMoes
		loc_cCols = ""
		loc_cVals = ""
		loc_cGruConMoes = LEFT(PADR(par_cGrupo, 10) + PADR(par_cConta, 10) + PADR(par_cMoeda, 3), 23)

		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "autos", "1")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "concs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contages", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contas", EscaparSQL(par_cConta))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contems", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cotacaos", FormatarNumeroSQL(par_nCotacao, 7))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "datalts", FormatarDataSQL(par_tDatalts))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "datas", FormatarDataSQL(par_tDatas))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "docus", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopes", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "emps", EscaparSQL(go_4c_Sistema.cCodEmpresa))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupages", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupems", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "grupos", EscaparSQL(par_cGrupo))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "hists", EscaparSQL(par_cHist))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "locals", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "moedas", EscaparSQL(par_cMoeda))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nlancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nopers", FormatarNumeroSQL(par_nNoper, 0))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "ntrans", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "numes", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "opers", EscaparSQL(par_cOpers))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldocs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldons", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "saldos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "scontas", EscaparSQL(par_cSConta))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "scotacaos", FormatarNumeroSQL(par_nSCotacao, 7))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "sgrupos", EscaparSQL(par_cSGrupo))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "shists", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "smoedas", EscaparSQL(par_cSMoeda))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "sopers", EscaparSQL(par_cSOpers))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "svalors", FormatarNumeroSQL(par_nSValor, 2))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tipos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titbans", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titulos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usualts", EscaparSQL(gc_4c_UsuarioLogado))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuexcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valliqs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valocurs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valors", FormatarNumeroSQL(par_nValor, 2))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valpags", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vencs", FormatarDataSQL(par_tDatas))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vlancs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "vopers", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "contapgs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "numcs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cotusus", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "bcontas", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "bgrupos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "borderos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "intconts", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuconcs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "auditors", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "valprev", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "cidchaves", EscaparSQL(par_cCidChave))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empdopncs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empdopnums", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "gruconmoes", EscaparSQL(loc_cGruConMoes))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "pagos", EscaparSQL("1"))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "dopotps", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usupagos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titcancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "usuconfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "nopercancs", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "especienfs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "jobs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "impostos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tpimpostos", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "titpais", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empccs", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "recor", "0")
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "compet", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "empos", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "oridopnums", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "rcontas", EscaparSQL(""))
		THIS.AdicionarCampoSQL(@loc_cCols, @loc_cVals, "tpdocnf", EscaparSQL(""))

		RETURN "INSERT INTO SigMvCcr (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
	ENDPROC

	*====================================================================
	* Atualizar - Prorroga o vencimento do cheque (Prorroga.Click, linha
	* a linha):
	*   1) UPDATE SigChe (novo vencimento + data de alteracao)
	*   2) INSERT SigChea (historico da prorrogacao)
	*   3) Se houver juros calculados, grava o lancamento em partida
	*      dobrada em SigMvCcr (linha "C" na Conta/Grupo de Juros do
	*      parametro + linha "D" espelhada do lado do cliente) e
	*      acumula o recalculo de saldos (fRecalculaS)
	*   4) Se o atraso (em dias) desde a 1a prorrogacao do cheque for
	*      >= SigCdPam.DiaPrors, registra o bloqueio (SigClLan, Cocos='05')
	*   5) Processa o recalculo de saldos acumulado (fRecalculaS(.T.))
	*
	* NUNCA ha RETURN dentro do TRY (regra #1) - o fluxo e controlado por
	* loc_lContinuar, e o COMMIT/ROLLBACK e decidido uma unica vez no fim.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lContinuar, loc_oErro
		LOCAL loc_tAgora, loc_dVencsAntigo, loc_nNoper, loc_cCidChave1, loc_cCidChave2
		LOCAL loc_cHist, loc_nDias, loc_dVencsHist, loc_nQtdBloqueio

		loc_lSucesso   = .F.
		loc_lContinuar = .T.

		TRY
			THIS.CarregarParametrosSistema()

			loc_tAgora       = DATETIME()
			loc_dVencsAntigo = THIS.this_dVencs

			*-- 1) UPDATE SigChe (Prorroga.Click:489-496)
			loc_cSQL = "UPDATE SigChe SET " + ;
				"vencs = " + FormatarDataSQL(THIS.this_dVencNovo) + "," + ;
				"dtalts = " + FormatarDataSQL(loc_tAgora) + ;
				" WHERE nums = " + EscaparSQL(THIS.this_cNums)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado < 0
				MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o novo vencimento:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
				loc_lContinuar = .F.
			ENDIF

			*-- 2) INSERT SigChea - historico (Prorroga.Click:499-525). O
			*--    "vencs" gravado no historico e o vencimento ANTERIOR
			*--    (m.Vencs = _OVenc, capturado antes do UPDATE acima).
			IF loc_lContinuar
				loc_cSQL = "INSERT INTO SigChea (cidchaves, nums, vencs, usuars, vjuros, pjuros, datas, motivo)" + ;
					" VALUES (" + ;
					EscaparSQL(fUniqueIds()) + "," + ;
					EscaparSQL(THIS.this_cNums) + "," + ;
					FormatarDataSQL(loc_dVencsAntigo) + "," + ;
					EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
					FormatarNumeroSQL(THIS.this_nValJuros, 2) + "," + ;
					FormatarNumeroSQL(THIS.this_nJuros, 2) + "," + ;
					FormatarDataSQL(DATE()) + "," + ;
					EscaparSQL("") + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado < 0
					MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o hist" + CHR(243) + ;
						"rico da prorroga" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lContinuar = .F.
				ENDIF
			ENDIF

			*-- 3) Juros de prorrogacao: lancamento em partida dobrada em
			*--    SigMvCcr (Prorroga.Click:527-613), so quando ha valor
			*--    de juros calculado na tela.
			IF loc_lContinuar AND THIS.this_nValJuros > 0
				loc_nNoper     = fGerUniqueKey("SigMvCcr")
				loc_cHist      = go_4c_Sistema.cCodEmpresa + " JUROS PRORROG. CHEQUE " + ;
					ALLTRIM(THIS.this_cBancos) + "/" + ALLTRIM(THIS.this_cAgencias) + "/" + ;
					ALLTRIM(THIS.this_cNContas) + "/" + ALLTRIM(THIS.this_cNCheques)

				*-- 3a) Linha "C" - credito na Conta/Grupo de Juros do
				*--     parametro, contrapartida "D" do lado do cliente.
				loc_cCidChave1 = THIS.GerarCidChaveMvCcr()
				loc_cSQL = THIS.MontarLancamentoSigMvCcr(loc_cCidChave1, ;
					THIS.this_cGrupoJuros, THIS.this_cContaJuros, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "C", ;
					THIS.this_cGrClis, THIS.this_cIClis, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "D", ;
					loc_nNoper, loc_cHist, loc_tAgora, loc_tAgora)

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

				IF loc_nResultado < 0
					MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o juros de prorroga" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					loc_lContinuar = .F.
				ELSE
					fRecalculaS(THIS.this_cGrupoJuros, THIS.this_cContaJuros, DATE(), THIS.this_cMoedaCheqs)
				ENDIF

				*-- 3b) Linha "D" espelhada - mesma operacao (nopers),
				*--     lados invertidos (Prorroga.Click:579-613). O
				*--     datalts aqui usa DATE() (nao DATETIME()), fiel
				*--     ao quirk do legado nessa 2a linha.
				IF loc_lContinuar
					loc_cCidChave2 = THIS.GerarCidChaveMvCcr()
					loc_cSQL = THIS.MontarLancamentoSigMvCcr(loc_cCidChave2, ;
						THIS.this_cGrClis, THIS.this_cIClis, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "D", ;
						THIS.this_cGrupoJuros, THIS.this_cContaJuros, THIS.this_cMoedaCheqs, 1, THIS.this_nValJuros, "C", ;
						loc_nNoper, loc_cHist, loc_tAgora, DATE())

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

					IF loc_nResultado < 0
						MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a contrapartida do juros de " + ;
							"prorroga" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
						loc_lContinuar = .F.
					ELSE
						fRecalculaS(THIS.this_cGrClis, THIS.this_cIClis, DATE(), THIS.this_cMoedaCheqs)
					ENDIF
				ENDIF
			ENDIF

			*-- 4) Atraso desde a 1a prorrogacao -> bloqueio (Prorroga.Click:
			*--    617-646). Sem ORDER BY, fiel ao CursorQuery('SigChea',...)
			*--    legado, que tambem nao ordena antes do Go Top.
			IF loc_lContinuar
				loc_dVencsHist = {}

				loc_cSQL = "SELECT TOP 1 vencs FROM SigChea WHERE nums = " + EscaparSQL(THIS.this_cNums)
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistChea")

				IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_HistChea") > 0
					SELECT cursor_4c_HistChea
					loc_dVencsHist = ConverterParaData(vencs)
				ENDIF

				IF USED("cursor_4c_HistChea")
					USE IN cursor_4c_HistChea
				ENDIF

				loc_nDias = 0
				IF !EMPTY(loc_dVencsHist)
					loc_nDias = ConverterParaData(THIS.this_dVencNovo) - loc_dVencsHist
				ENDIF

				IF loc_nDias >= THIS.this_nDiaPrors
					loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigClLan WHERE grupos = " + EscaparSQL(THIS.this_cGrClis) + ;
						" AND contas = " + EscaparSQL(THIS.this_cIClis) + " AND cocos = '05'"
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkLan")

					loc_nQtdBloqueio = 0
					IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkLan") > 0
						SELECT cursor_4c_ChkLan
						loc_nQtdBloqueio = NVL(qtd, 0)
					ENDIF

					IF USED("cursor_4c_ChkLan")
						USE IN cursor_4c_ChkLan
					ENDIF

					IF loc_nQtdBloqueio = 0
						loc_cSQL = "INSERT INTO SigClLan (cidchaves, grupos, contas, cocos, grucontas) VALUES (" + ;
							EscaparSQL(fUniqueIds()) + "," + ;
							EscaparSQL(THIS.this_cGrClis) + "," + ;
							EscaparSQL(THIS.this_cIClis) + "," + ;
							EscaparSQL("05") + "," + ;
							EscaparSQL(LEFT(PADR(THIS.this_cGrClis, 10) + PADR(THIS.this_cIClis, 10), 20)) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

						IF loc_nResultado < 0
							MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel registrar o bloqueio de atraso:" + ;
								CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lContinuar = .F.
						ENDIF
					ENDIF
				ENDIF
			ENDIF

			*-- 5) Processa o recalculo de saldos acumulado + commit/rollback
			*--    (Prorroga.Click:648-655)
			IF loc_lContinuar
				IF fRecalculaS(.T.)
					THIS.this_dVencs = THIS.this_dVencNovo
					THIS.RegistrarAuditoria("UPDATE")
					SQLCOMMIT(gnConnHandle)
					loc_lSucesso = .T.
				ELSE
					SQLROLLBACK(gnConnHandle)
					MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
				ENDIF
			ELSE
				SQLROLLBACK(gnConnHandle)
			ENDIF
		CATCH TO loc_oErro
			SQLROLLBACK(gnConnHandle)
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*-- Inserir() NAO e sobrescrito: este BO so prorroga cheques que JA
	*-- existem em SigChe (nunca cria um registro novo) - o comportamento
	*-- herdado da BusinessBase para Inserir() permanece o correto.

ENDDEFINE
