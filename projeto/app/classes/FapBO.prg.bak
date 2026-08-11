*====================================================================
* FapBO.prg
*
* Business Object para Envio para Recuperacao
* Tabela: SigCdFea
* PK: cidchaves (char 20)
*====================================================================

DEFINE CLASS FapBO AS BusinessBase

	*-- Chave primaria (char 20, gerada via fGerUniqueKey no legado)
	this_cCidChaves = ""

	*-- Numero sequencial visivel ao usuario
	this_nNumes     = 0

	*-- Empresa
	this_cEmps      = ""

	*-- Tipo ('F' ou outro - recebido como parametro ao abrir o form)
	this_cTipos     = ""

	*-- Data do envio
	this_dDatas     = {}

	*-- Grupo de conta corrente (codigo + descricao de lookup)
	this_cGrupos    = ""
	this_cDsGrupos  = ""

	*-- Conta corrente (codigo + descricao de lookup)
	this_cContas    = ""
	this_cDsContas  = ""

	*-- Recuperadora - codigo e nome (SigCdCli.IClis / RClis)
	this_cIfors     = ""
	this_cDsIfors   = ""

	*-- Tipo de material (SigOpOpt.Cods)
	this_cTpmats    = ""

	*-- Pesos em gramas
	this_nBrutos    = 0     && Peso Bruto
	this_nTrabs     = 0     && Peso Trabalhado
	this_nFalhas    = 0     && Peso Falha
	this_nProduzidos= 0     && Produzido

	*-- Totais de material recuperado
	this_nPesoccbs  = 0     && Total Com Cobranca
	this_nPesoscbs  = 0     && Total Sem Cobranca

	*-- Flag de baixa (bit -> logical)
	this_lBaixas    = .F.

	*-- Numero do balancete relacionado
	this_nNumbals   = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela    = "SigCdFea"
			THIS.this_cCampoChave = "cidchaves"
			loc_lResultado = .T.
		CATCH TO loException
			MsgErro("Erro ao inicializar FapBO: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da PK para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT lista de registros (filtrado por empresa + tipo)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals" + ;
					   " FROM SigCdFea a" + ;
					   " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND a.tipos = " + EscaparSQL(THIS.this_cTipos)

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.numes"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado > 0
				GO TOP IN cursor_4c_Dados
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals," + ;
					   " ISNULL(b.Descrs, '') AS ds_grupos," + ;
					   " ISNULL(c.RClis, '') AS ds_contas," + ;
					   " ISNULL(d.RClis, '') AS ds_ifors" + ;
					   " FROM SigCdFea a" + ;
					   " LEFT JOIN SigCdGcr b ON b.Codigos = a.grupos" + ;
					   " LEFT JOIN SigCdCli c ON c.IClis = a.contas" + ;
					   " LEFT JOIN SigCdCli d ON d.IClis = a.ifors" + ;
					   " WHERE a.cidchaves = " + EscaparSQL(par_cCodigo)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
				THIS.this_nNumes      = TratarNulo(numes, "N")
				THIS.this_cEmps       = TratarNulo(emps, "C")
				THIS.this_cTipos      = TratarNulo(tipos, "C")
				THIS.this_dDatas      = TratarNulo(datas, "D")
				THIS.this_cGrupos     = TratarNulo(grupos, "C")
				THIS.this_cContas     = TratarNulo(contas, "C")
				THIS.this_cIfors      = TratarNulo(ifors, "C")
				THIS.this_cTpmats     = TratarNulo(tpmats, "C")
				THIS.this_nBrutos     = TratarNulo(brutos, "N")
				THIS.this_nTrabs      = TratarNulo(trabs, "N")
				THIS.this_nFalhas     = TratarNulo(falhas, "N")
				THIS.this_nProduzidos = TratarNulo(produzidos, "N")
				THIS.this_nPesoccbs   = TratarNulo(pesoccbs, "N")
				THIS.this_nPesoscbs   = TratarNulo(pesoscbs, "N")
				THIS.this_lBaixas     = (TratarNulo(baixas, "N") = 1)
				THIS.this_nNumbals    = TratarNulo(numbals, "N")

				*-- Descricoes (apenas disponiveis no cursor de CarregarPorCodigo com JOIN)
				TRY
					THIS.this_cDsGrupos = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_grupos"))
					THIS.this_cDsContas = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_contas"))
					THIS.this_cDsIfors  = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_ifors"))
				CATCH
					&& Cursor sem descricoes - normal para Buscar()
				ENDTRY

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_nNumes
		loc_lSucesso = .F.

		TRY
			*-- Gerar cidchaves unico (20 chars)
			loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)

			*-- Gerar proximo numes sequencial para empresa+tipo
			loc_nNumes = THIS.GerarProximoNumes()
			IF loc_nNumes <= 0
				MsgErro("Erro ao gerar n" + CHR(250) + "mero sequencial.", "Erro")
			ELSE
				THIS.this_cCidChaves = loc_cChave
				THIS.this_nNumes     = loc_nNumes
				THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa

				loc_cSQL = "INSERT INTO SigCdFea" + ;
						   " (cidchaves, numes, emps, tipos, datas," + ;
						   "  grupos, contas, ifors, tpmats," + ;
						   "  brutos, trabs, falhas, produzidos," + ;
						   "  pesoccbs, pesoscbs, baixas, numbals)" + ;
						   " VALUES (" + ;
						   EscaparSQL(THIS.this_cCidChaves) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
						   EscaparSQL(THIS.this_cEmps) + ", " + ;
						   EscaparSQL(THIS.this_cTipos) + ", " + ;
						   FormatarDataSQL(THIS.this_dDatas) + ", " + ;
						   EscaparSQL(THIS.this_cGrupos) + ", " + ;
						   EscaparSQL(THIS.this_cContas) + ", " + ;
						   EscaparSQL(THIS.this_cIfors) + ", " + ;
						   EscaparSQL(THIS.this_cTpmats) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
						   IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumbals) + ;
						   ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
				ENDIF

				IF USED("cursor_4c_Ins")
					USE IN cursor_4c_Ins
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFea SET" + ;
					   " datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
					   " grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
					   " contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
					   " ifors = " + EscaparSQL(THIS.this_cIfors) + ", " + ;
					   " tpmats = " + EscaparSQL(THIS.this_cTpmats) + ", " + ;
					   " brutos = " + FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
					   " trabs = " + FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
					   " falhas = " + FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
					   " produzidos = " + FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
					   " pesoccbs = " + FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
					   " pesoscbs = " + FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
					   " baixas = " + IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
					   " numbals = " + FormatarNumeroSQL(THIS.this_nNumbals) + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdFea" + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Del")
				USE IN cursor_4c_Del
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor de grupos disponiveis (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
					   " WHERE BalFalPers = 1 ORDER BY Codigos"

			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar grupos: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarGrupos: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor de contas para um grupo (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarContas(par_cGrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.IClis, a.RClis" + ;
					   " FROM SigCdCli a" + ;
					   " JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
					   " WHERE b.BalFalPers = 1"

			IF !EMPTY(par_cGrupo)
				loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(par_cGrupo)
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar contas: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarContas: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarTiposMaterial - Carrega cursor de tipos de material (Situas=3)
	*====================================================================
	PROCEDURE BuscarTiposMaterial()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods"

			IF USED("cursor_4c_TpMats")
				USE IN cursor_4c_TpMats
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpMats")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar tipos de material: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarTiposMaterial: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoNumes - Retorna proximo numero sequencial para empresa+tipo
	*====================================================================
	PROTECTED PROCEDURE GerarProximoNumes()
		LOCAL loc_cSQL, loc_nResultado, loc_nProximo
		loc_nProximo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(numes), 0) + 1 AS proximo" + ;
					   " FROM SigCdFea" + ;
					   " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND tipos = " + EscaparSQL(THIS.this_cTipos)

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Numes")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Numes") > 0
				SELECT cursor_4c_Numes
				loc_nProximo = proximo
			ELSE
				MsgErro("Erro ao gerar n" + CHR(250) + "mero: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF
		CATCH TO loException
			MsgErro("Erro em GerarProximoNumes: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_nProximo
	ENDPROC

ENDDEFINE
