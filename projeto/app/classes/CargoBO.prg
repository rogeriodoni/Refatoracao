*====================================================================
* CargoBO.prg
*
* Business Object para Cargos
* Tabela principal: SIGCDCRG (ccargs PK)
* Sub-tabelas: SIGCRRCC (acesso financeiro), sigcarct (categorias)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CargoBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCRG)
	this_cCcargs      = ""   && ccargs char(10)      - PK (codigo do cargo)
	this_cDcargs      = ""   && dcargs char(20)       - descricao
	this_nAcrepors    = 0    && acrepors numeric(9,2) - acrescimo %
	this_cAltcots     = ""   && altcots char(1)       - altera cotacao (S/N)
	this_nComis       = 0    && comis numeric(5,2)    - comissao %
	this_dDatatrans   = {}   && datatrans datetime    - data transacao (NULL)
	this_nDescpors    = 0    && descpors numeric(9,2) - desconto %
	this_nLimacres    = 0    && limacres numeric(11,2) - limite acrescimo (R$)
	this_nLimdescs    = 0    && limdescs numeric(11,2) - limite desconto (R$)
	this_cNivels      = ""   && nivels char(1)        - senha (S/N)
	this_nVarcots     = 0    && varcots numeric(5,2)  - variacao cotacao %
	this_cLimites     = ""   && limites char(1)       - libera limite (S/N)
	this_nAcomis      = 0    && acomis numeric(5,2)   - fator de comissao %
	this_cFcomis      = ""   && fcomis char(1)        - tipo comissao S/N
	this_cCancitens   = ""   && cancitens char(1)     - cancela item cupom fiscal (S/N)
	this_nVllibpgs    = 0    && vllibpgs numeric(11,2) - valor liberar pagamentos (R$)
	this_cLibfpags    = ""   && libfpags char(1)      - excluir cond. pagto ecf (S/N)
	this_cLibsdins    = ""   && libsdins char(1)      - libera saldo insuficiente (S/N)
	this_nVllibcots   = 0    && vllibcots numeric(11,2) - valor liberar cotacoes (R$)
	this_nVllibopes   = 0    && vllibopes numeric(11,2) - valor liberar movimentacoes (R$)
	this_cLibfpgs     = ""   && libfpgs char(1)       - libera condicao pagto (S/N)
	this_cLibopes     = ""   && libopes char(1)       - liberar movim. estoque (S/N)
	this_cGrcomis     = ""   && grcomis char(10)      - grupo financeiro
	this_nTpcomis     = 0    && tpcomis numeric(1,0)  - tipo comissao (OptionGroup)
	this_nLibleilaos  = 0    && libleilaos numeric(1,0) - libera leilao (OptionGroup)
	this_nLibdupends  = 0    && libdupends numeric(1,0) - libera duplicidade (OptionGroup)
	this_nLibduptits  = 0    && libduptits numeric(1,0) - liberar titulos iguais (OptionGroup)
	this_nLibprzes    = 0    && libprzes numeric(1,0) - liberar prazo entrega (OptionGroup)
	this_nLibsldtqe   = 0    && libsldtqe numeric(1,0) - libera saldo cotacao (OptionGroup)
	this_cLibaltcli   = ""   && libaltcli char(1)     - libera alterar cliente (S/N)
	this_cLibexprd    = ""   && libexprd char(1)      - libera excluir mov. producao (S/N)
	this_nCustoprod   = 0    && custoprod numeric(1,0) - custo producao (OptionGroup)
	this_cLibvmovdup  = ""   && libvmovdup char(1)    - liberar variacao mov dupla (S/N)
	this_nVarmovdup   = 0    && varmovdup numeric(5,2) - variacao mov dupla %
	this_cLibopers    = ""   && libopers char(1)      - liberar operacoes (S/N)
	this_cLibvarpeso  = ""   && libvarpeso char(1)    - liberar variacao peso (S/N)
	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)

	*-- Propriedades locais (NAO existem no schema de sigcdcrg ? apenas estado UI)
	this_cConsSubn    = ""   && nao persiste ? coluna ausente no banco
	this_nLibValmmax  = 0    && nao persiste ? coluna ausente no banco

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCRG"
		THIS.this_cCampoChave = "ccargs"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCcargs)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de cargos no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG ORDER BY ccargs"
			ELSE
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG" + ;
				           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY ccargs"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cargos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar cargos:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT acrepors, altcots, ccargs, comis, datatrans," + ;
			           " dcargs, descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs, libfpags," + ;
			           " libsdins, vllibcots, vllibopes, libfpgs, libopes, grcomis," + ;
			           " tpcomis, libleilaos, libdupends, libduptits, libprzes," + ;
			           " libsldtqe, libaltcli, libexprd, custoprod, libvmovdup," + ;
			           " varmovdup, libopers, libvarpeso, libmultvends, altvlpro" + ;
			           " FROM SIGCDCRG" + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
				IF loc_lSucesso
					THIS.CarregarSubTabelaAcessoFinan(par_cCcargs)
					THIS.CarregarSubTabelaCategorias(par_cCcargs)
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCcargs       = TratarNulo(ccargs, "C")
			THIS.this_cDcargs       = TratarNulo(dcargs, "C")
			THIS.this_nAcrepors     = TratarNulo(acrepors, "N")
			THIS.this_cAltcots      = TratarNulo(altcots, "C")
			THIS.this_nComis        = TratarNulo(comis, "N")
			THIS.this_nDescpors     = TratarNulo(descpors, "N")
			THIS.this_nLimacres     = TratarNulo(limacres, "N")
			THIS.this_nLimdescs     = TratarNulo(limdescs, "N")
			THIS.this_cNivels       = TratarNulo(nivels, "C")
			THIS.this_nVarcots      = TratarNulo(varcots, "N")
			THIS.this_cLimites      = TratarNulo(limites, "C")
			THIS.this_nAcomis       = TratarNulo(acomis, "N")
			THIS.this_cFcomis       = TratarNulo(fcomis, "C")
			THIS.this_cCancitens    = TratarNulo(cancitens, "C")
			THIS.this_nVllibpgs     = TratarNulo(vllibpgs, "N")
			THIS.this_cLibfpags     = TratarNulo(libfpags, "C")
			THIS.this_cLibsdins     = TratarNulo(libsdins, "C")
			THIS.this_nVllibcots    = TratarNulo(vllibcots, "N")
			THIS.this_nVllibopes    = TratarNulo(vllibopes, "N")
			THIS.this_cLibfpgs      = TratarNulo(libfpgs, "C")
			THIS.this_cLibopes      = TratarNulo(libopes, "C")
			THIS.this_cGrcomis      = TratarNulo(grcomis, "C")
			THIS.this_nTpcomis      = TratarNulo(tpcomis, "N")
			THIS.this_nLibleilaos   = TratarNulo(libleilaos, "N")
			THIS.this_nLibdupends   = TratarNulo(libdupends, "N")
			THIS.this_nLibduptits   = TratarNulo(libduptits, "N")
			THIS.this_nLibprzes     = TratarNulo(libprzes, "N")
			THIS.this_nLibsldtqe    = TratarNulo(libsldtqe, "N")
			THIS.this_cLibaltcli    = TratarNulo(libaltcli, "C")
			THIS.this_cLibexprd     = TratarNulo(libexprd, "C")
			THIS.this_nCustoprod    = TratarNulo(custoprod, "N")
			THIS.this_cLibvmovdup   = TratarNulo(libvmovdup, "C")
			THIS.this_nVarmovdup    = TratarNulo(varmovdup, "N")
			THIS.this_cLibopers     = TratarNulo(libopers, "C")
			THIS.this_cLibvarpeso   = TratarNulo(libvarpeso, "C")
			THIS.this_nLibmultvends = TratarNulo(libmultvends, "N")
			THIS.this_nAltvlpro     = TratarNulo(altvlpro, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaAcessoFinan - Carrega acesso financeiro (SIGCRRCC)
	*====================================================================
	PROCEDURE CarregarSubTabelaAcessoFinan(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_AcessoFinan")
				USE IN cursor_4c_AcessoFinan
			ENDIF

			loc_cSQL = "SELECT grupos, contas, valors, moedas FROM SIGCRRCC" + ;
			           " WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY grupos, contas"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessoFinan")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaCategorias - Carrega categorias (sigcarct + sigcdctg)
	*====================================================================
	PROCEDURE CarregarSubTabelaCategorias(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Categorias")
				USE IN cursor_4c_Categorias
			ENDIF

			loc_cSQL = "SELECT a.categoria, ISNULL(b.descs, '') AS descs, a.tipo, a.cargo" + ;
			           " FROM sigcarct a" + ;
			           " LEFT JOIN sigcdctg b ON RTRIM(b.cods) = RTRIM(a.categoria)" + ;
			           " WHERE RTRIM(a.cargo) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY a.categoria"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Categorias")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursoresGrid - Cria cursores vazios para grids em INCLUIR
	*====================================================================
	PROCEDURE InicializarCursoresGrid()
		IF USED("cursor_4c_AcessoFinan")
			USE IN cursor_4c_AcessoFinan
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_AcessoFinan (grupos C(10), contas C(10), valors N(13,2), moedas C(3))
		SET NULL OFF

		IF USED("cursor_4c_Categorias")
			USE IN cursor_4c_Categorias
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_Categorias (categoria C(6), descs C(30), tipo C(10), cargo C(10))
		SET NULL OFF
	ENDPROC

	*====================================================================
	* SalvarSubTabelaAcessoFinan - Salva acesso financeiro (SIGCRRCC)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaAcessoFinan()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_AcessoFinan") AND RECCOUNT("cursor_4c_AcessoFinan") > 0
					GO TOP IN cursor_4c_AcessoFinan
					SELECT cursor_4c_AcessoFinan
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.grupos)) .OR. ;
						   !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.contas))
							loc_cCidchaves = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO SIGCRRCC (cargos, cidchaves, grupos, contas, valors, moedas)" + ;
							           " VALUES (" + ;
							           EscaparSQL(THIS.this_cCcargs) + "," + ;
							           EscaparSQL(loc_cCidchaves) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.grupos) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.contas) + "," + ;
							           FormatarNumeroSQL(cursor_4c_AcessoFinan.valors) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.moedas) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarSubTabelaCategorias - Salva categorias (sigcarct)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaCategorias()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChave
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_Categorias") AND RECCOUNT("cursor_4c_Categorias") > 0
					GO TOP IN cursor_4c_Categorias
					SELECT cursor_4c_Categorias
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_Categorias.categoria))
							loc_cPkChave = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO sigcarct (categoria, pkchave, tipo, cargo)" + ;
							           " VALUES (" + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.categoria), 6)) + "," + ;
							           EscaparSQL(loc_cPkChave) + "," + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.tipo), 10)) + "," + ;
							           EscaparSQL(THIS.this_cCcargs) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SIGCDCRG" + ;
			           " (ccargs, dcargs, acrepors, altcots, comis," + ;
			           " descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs," + ;
			           " libfpags, libsdins, vllibcots, vllibopes, libfpgs," + ;
			           " libopes, grcomis, tpcomis, libleilaos, libdupends," + ;
			           " libduptits, libprzes, libsldtqe, libaltcli, libexprd," + ;
			           " custoprod, libvmovdup, varmovdup, libopers, libvarpeso," + ;
			           " libmultvends, altvlpro)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCcargs) + "," + ;
			           EscaparSQL(THIS.this_cDcargs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           EscaparSQL(THIS.this_cAltcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           EscaparSQL(THIS.this_cNivels) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           EscaparSQL(THIS.this_cLimites) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           EscaparSQL(THIS.this_cFcomis) + "," + ;
			           EscaparSQL(THIS.this_cCancitens) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibopes) + "," + ;
			           EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           EscaparSQL(THIS.this_cLibopers) + "," + ;
			           EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAltvlpro) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCRG SET" + ;
			           " dcargs = " + EscaparSQL(THIS.this_cDcargs) + "," + ;
			           " acrepors = " + FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           " altcots = " + EscaparSQL(THIS.this_cAltcots) + "," + ;
			           " comis = " + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           " descpors = " + FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           " limacres = " + FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           " limdescs = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
			           " varcots = " + FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           " limites = " + EscaparSQL(THIS.this_cLimites) + "," + ;
			           " acomis = " + FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           " fcomis = " + EscaparSQL(THIS.this_cFcomis) + "," + ;
			           " cancitens = " + EscaparSQL(THIS.this_cCancitens) + "," + ;
			           " vllibpgs = " + FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           " libfpags = " + EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           " libsdins = " + EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           " vllibcots = " + FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           " vllibopes = " + FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           " libfpgs = " + EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           " libopes = " + EscaparSQL(THIS.this_cLibopes) + "," + ;
			           " grcomis = " + EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           " tpcomis = " + FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           " libleilaos = " + FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           " libdupends = " + FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           " libduptits = " + FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           " libprzes = " + FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           " libsldtqe = " + FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           " libaltcli = " + EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           " libexprd = " + EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           " custoprod = " + FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           " libvmovdup = " + EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           " varmovdup = " + FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE SIGCRRCC + sigcarct + SIGCDCRG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- 1. Excluir acesso financeiro (SIGCRRCC)
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- 2. Excluir categorias (sigcarct)
				loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					MsgErro("Erro ao excluir categorias do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Excluir registro principal (SIGCDCRG)
					loc_cSQL = "DELETE FROM SIGCDCRG WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
