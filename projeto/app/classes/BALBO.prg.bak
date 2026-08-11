*====================================================================
* BALBO.prg
*
* Business Object para Balanco de Inventario
* Tabela: SIGCDBAL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS BALBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDBAL)
	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica UUID)
	*-- Identificacao
	this_nCodigos    = 0    && codigos numeric(4,0) - codigo do balanco
	this_cEmps       = ""   && emps char(3) - empresa
	this_cUsuars     = ""   && usuars char(10) - usuario
	this_nNtrans     = 0    && ntrans numeric(6,0) - numero da transacao
	*-- Grupos de Estoque (conta + grupo)
	this_cGrupos     = ""   && grupos char(10) - grupo de estoque (SigCdGcr)
	this_cContas     = ""   && contas char(10) - conta de estoque (SigCdCli)
	*-- Datas
	this_dDtbases    = {}   && dtbases datetime - data base
	this_dDatainis   = {}   && datainis datetime - data inicial leitura
	this_dDatafims   = {}   && datafims datetime - data final leitura
	this_dDatatrans  = {}   && datatrans datetime - data transporte
	*-- Flags de controle
	this_lEncerras   = .F.  && encerras bit - balanco encerrado
	this_lTratas     = .F.  && tratas bit - tratamento especial
	this_nSepestqs   = 0    && sepestqs numeric(1,0) - separar por estoque
	this_nTrtporpeso = 0    && trtporpeso numeric(1,0) - tratar por peso
	this_nAgrupas    = 0    && agrupas numeric(1,0) - forma de agrupamento
	this_nLeitgructa = 0    && leitgructa numeric(1,0) - leitura somente grupo+conta
	this_nFilbarras  = 0    && filbarras numeric(1,0) - filtro tipo codigo de barras
	*-- Locais (filtros)
	this_cLocals     = ""   && locals char(10) - local (usado na leitura)
	this_cLocalis    = ""   && localis char(10) - local inicial (filtro)
	this_cLocalfs    = ""   && localfs char(10) - local final (filtro)
	*-- Fornecedores (filtros)
	this_cIforis     = ""   && iforis char(10) - fornecedor inicial
	this_cIforfs     = ""   && iforfs char(10) - fornecedor final
	*-- Preco (filtros)
	this_nPrecois    = 0    && precois numeric(8,2) - preco inicial
	this_nPrecofs    = 0    && precofs numeric(8,2) - preco final
	*-- Grupos de Produto (filtros)
	this_cCgruis     = ""   && cgruis char(3) - grupo produto inicial (SigCdGrp.cgrus)
	this_cCgrufs     = ""   && cgrufs char(3) - grupo produto final (SigCdGrp.cgrus)
	*-- Grandes Grupos (filtros)
	this_cCggruis    = ""   && cggruis char(3) - grande grupo inicial (SigCdGpr.codigos)
	this_cCggrufs    = ""   && cggrufs char(3) - grande grupo final (SigCdGpr.codigos)
	*-- Colecoes (filtros)
	this_cColecoesi  = ""   && colecoesi char(10) - colecao inicial (SigCdCol.colecoes)
	this_cColecoesf  = ""   && colecoesf char(10) - colecao final (SigCdCol.colecoes)
	*-- Produtos (filtros)
	this_cCprosi     = ""   && cprosi char(14) - produto inicial (SigCdPro.cpros)
	this_cCprosf     = ""   && cprosf char(14) - produto final (SigCdPro.cpros)
	*-- Subgrupos (filtros)
	this_cSgrusi     = ""   && sgrusi char(6) - subgrupo inicial (SigCdPsg.codigos)
	this_cSgrusf     = ""   && sgrusf char(6) - subgrupo final (SigCdPsg.codigos)
	*-- Unidades (filtros)
	this_cCfinpsi    = ""   && cfinpsi char(3) - unidade inicial (SigCdUni.cunis)
	this_cCfinpsf    = ""   && cfinpsf char(3) - unidade final (SigCdUni.cunis)
	*-- Memo/XML (filtros em grade)
	this_cMfilggrp   = ""   && mfilggrp text - XML marcacoes grandes grupos
	this_cMfilgrupo  = ""   && mfilgrupo text - XML marcacoes grupos produto
	this_cObs        = ""   && obs text - observacao geral

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDBAL"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista balancos de inventario da empresa atual
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " ORDER BY codigos, cidchaves"
			ELSE
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos, cidchaves"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um balanco pelo cidchaves (PK UUID)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorNumero - Carrega balanco pelo numero (codigos + emps)
	*====================================================================
	PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
			           " AND emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cCidchaves    = TratarNulo(cidchaves,    "C")
			THIS.this_nCodigos      = TratarNulo(codigos,      "N")
			THIS.this_cEmps         = TratarNulo(emps,         "C")
			THIS.this_cGrupos       = TratarNulo(grupos,       "C")
			THIS.this_cContas       = TratarNulo(contas,       "C")
			THIS.this_dDtbases      = TratarNulo(dtbases,      "D")
			THIS.this_dDatainis     = TratarNulo(datainis,     "D")
			THIS.this_dDatafims     = TratarNulo(datafims,     "D")
			THIS.this_dDatatrans    = TratarNulo(datatrans,    "D")
			THIS.this_lEncerras     = (TratarNulo(encerras,    "N") = 1)
			THIS.this_lTratas       = (TratarNulo(tratas,      "N") = 1)
			THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
			THIS.this_nSepestqs     = TratarNulo(sepestqs,     "N")
			THIS.this_nTrtporpeso   = TratarNulo(trtporpeso,   "N")
			THIS.this_nLeitgructa   = TratarNulo(leitgructa,   "N")
			THIS.this_nFilbarras    = TratarNulo(filbarras,     "N")
			THIS.this_cLocalis      = TratarNulo(localis,      "C")
			THIS.this_cLocalfs      = TratarNulo(localfs,      "C")
			THIS.this_cIforis       = TratarNulo(iforis,       "C")
			THIS.this_cIforfs       = TratarNulo(iforfs,       "C")
			THIS.this_cCgruis       = TratarNulo(cgruis,       "C")
			THIS.this_cCgrufs       = TratarNulo(cgrufs,       "C")
			THIS.this_cCggruis      = TratarNulo(cggruis,      "C")
			THIS.this_cCggrufs      = TratarNulo(cggrufs,      "C")
			THIS.this_cColecoesi    = TratarNulo(colecoesi,    "C")
			THIS.this_cColecoesf    = TratarNulo(colecoesf,    "C")
			THIS.this_cCprosi       = TratarNulo(cprosi,       "C")
			THIS.this_cCprosf       = TratarNulo(cprosf,       "C")
			THIS.this_cSgrusi       = TratarNulo(sgrusi,       "C")
			THIS.this_cSgrusf       = TratarNulo(sgrusf,       "C")
			THIS.this_cCfinpsi      = TratarNulo(cfinpsi,      "C")
			THIS.this_cCfinpsf      = TratarNulo(cfinpsf,      "C")
			THIS.this_nPrecois      = TratarNulo(precois,      "N")
			THIS.this_nPrecofs      = TratarNulo(precofs,      "N")
			THIS.this_nNtrans       = TratarNulo(ntrans,       "N")
			THIS.this_cLocals       = TratarNulo(locals,       "C")
			THIS.this_cUsuars       = TratarNulo(usuars,       "C")
			*-- Campos TEXT/memo (podem nao estar no cursor de listagem)
			IF PEMSTATUS(EVAL(par_cAliasCursor), "mfilggrp", 5) OR ;
			   !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
				THIS.this_cMfilggrp  = TratarNulo(mfilggrp,   "C")
				THIS.this_cMfilgrupo = TratarNulo(mfilgrupo,  "C")
				THIS.this_cObs       = TratarNulo(obs,        "C")
			ENDIF
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
		loc_nCodigo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
			           " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nCodigo = cursor_4c_ProxCod.prox_cod
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		ENDTRY

		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			*-- Gerar chave UUID e proximo codigo sequencial
			THIS.this_cCidchaves = ""
			loc_cSQL = "SELECT LEFT(NEWID(), 20) AS novo_uuid"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				loc_lSucesso = .F.
			ENDIF

			loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
			IF loc_nCodigo = 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
				loc_lSucesso = .F.
			ENDIF
			THIS.this_nCodigos = loc_nCodigo
			THIS.this_cEmps    = loc_cEmp
			THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

			loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
			           " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
			           " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
			           ") VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cEmps) + "," + ;
			           EscaparSQL(THIS.this_cGrupos) + "," + ;
			           EscaparSQL(THIS.this_cContas) + "," + ;
			           FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           EscaparSQL(THIS.this_cLocalis) + "," + ;
			           EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           EscaparSQL(THIS.this_cIforis) + "," + ;
			           EscaparSQL(THIS.this_cIforfs) + "," + ;
			           EscaparSQL(THIS.this_cCgruis) + "," + ;
			           EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           EscaparSQL(THIS.this_cCggruis) + "," + ;
			           EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           EscaparSQL(THIS.this_cCprosi) + "," + ;
			           EscaparSQL(THIS.this_cCprosf) + "," + ;
			           EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
			           EscaparSQL(THIS.this_cLocals) + "," + ;
			           EscaparSQL(THIS.this_cUsuars) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
			           " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
			           " dtbases = " + FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           " datainis = " + FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           " datafims = " + FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           " filbarras = " + FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
			           " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
			           " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
			           " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
			           " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
			           " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
			           " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
			           " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
			           " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do balanco e registros filhos
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
		loc_lSucesso = .F.
		loc_nCodigos = THIS.this_nCodigos
		loc_cEmps    = ALLTRIM(THIS.this_cEmps)

		TRY
			*-- Remover registros filhos: SigIvTrB (balancos itens)
			loc_cSQL = "DELETE FROM SigIvTrB" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrH (historico de leitura)
			loc_cSQL = "DELETE FROM SigIvTrH" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrE (etiquetas)
			loc_cSQL = "DELETE FROM SigIvTrE" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover o balanco principal
			loc_cSQL = "DELETE FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarEncerramento - Marca/desmarca balanco como encerrado
	*====================================================================
	PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
			           " datafims = " + FormatarDataSQL(par_dDatafim) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_lEncerras  = par_lEncerrar
				THIS.this_dDatafims  = par_dDatafim
				THIS.RegistrarAuditoria("ENCERRAR")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarTransporte - Marca balanco como transportado
	*====================================================================
	PROCEDURE AtualizarTransporte(par_dDataTrans)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " datatrans = " + FormatarDataSQL(par_dDataTrans) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_dDatatrans = par_dDataTrans
				THIS.RegistrarAuditoria("TRANSPORTE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao registrar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao registrar transporte:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarFiltrosXML - Salva filtros de grade (mfilggrp, mfilgrupo)
	*====================================================================
	PROCEDURE AtualizarFiltrosXML(par_cMfilggrp, par_cMfilgrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " mfilggrp = " + EscaparSQL(par_cMfilggrp) + "," + ;
			           " mfilgrupo = " + EscaparSQL(par_cMfilgrupo) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_cMfilggrp  = par_cMfilggrp
				THIS.this_cMfilgrupo = par_cMfilgrupo
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao salvar filtros XML:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar filtros XML:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarGrupoEstoque - Verifica se grupo de estoque eh valido
	*====================================================================
	PROCEDURE ValidarGrupoEstoque(par_cGrupos)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cGrupos))
				loc_lValido = .F.
			ENDIF

			loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
			           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* ValidarConta - Verifica se conta de estoque eh valida
	*====================================================================
	PROCEDURE ValidarConta(par_cContas)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cContas))
				loc_lValido = .T.
			ENDIF

			loc_cSQL = "SELECT TOP 1 IClis FROM SigCdCli" + ;
			           " WHERE IClis = " + EscaparSQL(ALLTRIM(par_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCta")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValCta") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

ENDDEFINE
