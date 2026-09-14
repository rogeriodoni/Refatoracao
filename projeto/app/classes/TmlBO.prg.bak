*====================================================================
* TmlBO.prg
*
* Business Object para Tipos de Material (SigCdTml / SIGCDTML)
* Tabela principal: SigOpOpt (cidchaves PK tecnica, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmlBO AS BusinessBase

	*-- Propriedades da entidade (SigOpOpt) - todas as 21 colunas da tabela
	this_cCidchaves  = ""    && cidchaves char(20)  - PK tecnica (UUID fUniqueIds, Replace no legado)
	this_cCods       = ""    && cods char(15)       - codigo (chave de negocio, unicidade validada no Salvar)
	this_cDescs      = ""    && descs char(40)      - descricao do tipo de material
	this_cGeraccs    = " "   && geraccs char(1)     - NOT NULL, sem campo na UI legada (default espaco)
	this_nPfalhas    = 0     && pfalhas numeric(5,2)  - falha admitida
	this_cGrupos     = ""    && grupos char(10)     - grupo (FK SigCdGcr.Codigos)
	this_cContas     = ""    && contas char(10)     - conta (FK SigCdCli.Iclis)
	this_cTfalhas    = ""    && tfalhas char(1)     - [P]ercentual ou [Q]uantidade
	this_cCtrlpds    = ""    && ctrlpds char(1)     - Analisa Producao (S/N)
	this_nValors     = 0     && valors numeric(7,2)   - valor
	this_nSituas     = 1     && situas numeric(1,0)   - situacao (OptionGroup: 1=Ativo,2=Inativo,3=Falhas/Perdas)
	this_nProdzs     = 0     && prodzs numeric(1,0)   - checkbox Produzido
	this_nTrabas     = 0     && trabas numeric(1,0)   - checkbox Trabalhado
	this_cAnaEsGrps  = ""    && anaesgrps char(1)   - Lancar Somente (E/S)
	this_cChkDevs    = ""    && chkdevs char(1)     - Checar Devolucao (S/N)
	this_cCodAcbs    = ""    && codacbs char(3)     - Tipo Acabamento (FK SigCdAca.Cods)
	this_nModels     = 0     && models numeric(1,0)   - checkbox Modelagem
	this_cEmps       = ""    && cemps char(3)        - Empresa (FK SigCdEmp.CEmps)
	this_nDupTpOps   = 0     && duptpops numeric(1,0) - checkbox Checar Duplicidade
	this_nRetrab     = 0     && retrab numeric(1,0)   - checkbox Aceita Retrabalho
	this_nIndProds   = 0     && indprods numeric(4,2)  - indice de produtividade

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela     = "SigOpOpt"
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
	* Buscar - Carrega lista de tipos de material no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tipos de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods" + ;
			           " FROM SigOpOpt" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cGeraccs   = TratarNulo(geraccs, "C")
			THIS.this_nPfalhas   = TratarNulo(pfalhas, "N")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cTfalhas   = TratarNulo(tfalhas, "C")
			THIS.this_cCtrlpds   = TratarNulo(ctrlpds, "C")
			THIS.this_nValors    = TratarNulo(valors, "N")
			THIS.this_nSituas    = TratarNulo(situas, "N")
			THIS.this_nProdzs    = TratarNulo(prodzs, "N")
			THIS.this_nTrabas    = TratarNulo(trabas, "N")
			THIS.this_cAnaEsGrps = TratarNulo(anaesgrps, "C")
			THIS.this_cChkDevs   = TratarNulo(chkdevs, "C")
			THIS.this_cCodAcbs   = TratarNulo(codacbs, "C")
			THIS.this_nModels    = TratarNulo(models, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nDupTpOps  = TratarNulo(duptpops, "N")
			THIS.this_nRetrab    = TratarNulo(retrab, "N")
			THIS.this_nIndProds  = TratarNulo(indprods, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SigOpOpt (cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigOpOpt SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           " geraccs = " + EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           " pfalhas = " + FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           " contas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           " tfalhas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           " ctrlpds = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           " situas = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           " prodzs = " + FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           " trabas = " + FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           " anaesgrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           " chkdevs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           " codacbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           " models = " + FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           " emps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           " duptpops = " + FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           " retrab = " + FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           " indprods = " + FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigOpOpt WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
