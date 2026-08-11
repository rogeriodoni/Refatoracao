*====================================================================
* CVIBO.prg
*
* Business Object para Comissoes de Vendedores Individuais
* Tabela principal: SigCcCmV (cIdChaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CVIBO AS BusinessBase

	*-- Propriedades da entidade (SigCcCmV)
	this_cCidChaves  = ""    && cIdChaves char(20)    - PK (UUID via fUniqueIds)
	this_cUsuars     = ""    && Usuars char(10)        - usuario (FK SigCdUsu.Usuarios)
	this_cMess       = ""    && Mess char(2)           - mes de referencia (MM)
	this_cAnos       = ""    && Anos char(4)           - ano de referencia (YYYY)
	this_cIndivs     = ""    && Indivs char(1)         - tipo: I=Individual R=Responsavel S=Setor
	this_cSetors     = ""    && Setors char(10)        - setor (FK SigCdSet.Setores)
	this_cSupervs    = ""    && Supervs char(10)       - responsavel (FK SigCcCmV.Usuars onde Indivs=R)
	this_nAdics      = 0     && Adics numeric(5,2)     - percentual adicional
	this_nMinimos    = 0     && Minimos numeric(11,2)  - valor minimo
	this_nMinExps    = 0     && MinExps numeric(11,2)  - experiencia minima

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmV"
		THIS.this_cCampoChave = "cIdChaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT com filtro WHERE opcional
	* par_cFiltro: clausula WHERE sem a palavra WHERE (ex: "Mess='01' AND Anos='2026'")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV"
			IF TYPE("par_cFiltro") = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = loc_cSQL + " ORDER BY Anos, Mess, Usuars"

			IF USED("crSigCcCmV")
				USE IN crSigCcCmV
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmV")
			IF loc_nResult > 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega BO pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV WHERE cIdChaves = " + EscaparSQL(par_cChave)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades do BO a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAlias)
		LOCAL loc_lResultado
		loc_lResultado = .F.
		IF USED(par_cAlias)
			SELECT (par_cAlias)
			THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
			THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
			THIS.this_cMess      = TratarNulo(Mess,      "C")
			THIS.this_cAnos      = TratarNulo(Anos,      "C")
			THIS.this_cIndivs    = TratarNulo(Indivs,    "C")
			THIS.this_cSetors    = TratarNulo(Setors,    "C")
			THIS.this_cSupervs   = TratarNulo(Supervs,   "C")
			THIS.this_nAdics     = TratarNulo(Adics,     "N")
			THIS.this_nMinimos   = TratarNulo(Minimos,   "N")
			THIS.this_nMinExps   = TratarNulo(MinExps,   "N")
			loc_lResultado = .T.
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido, loc_cSQLComI, loc_nResComI
		LOCAL loc_cSQLSupv, loc_nResSupv
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cUsuars))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Usu" + CHR(225) + "rio!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMess))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o M" + CHR(234) + "s de Refer" + ;
				CHR(234) + "ncia!!!", "Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !(INT(VAL(THIS.this_cMess)) > 0)
			MsgAviso("M" + CHR(234) + "s de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cAnos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Ano de Refer" + CHR(234) + "ncia!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !BETWEEN(INT(VAL(THIS.this_cAnos)), 1, 9999)
			MsgAviso("Ano de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIndivs))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Status de Tipo de Vendedor!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !INLIST(ALLTRIM(THIS.this_cIndivs), "I", "R", "S")
			MsgAviso("Observe a Informa" + CHR(231) + CHR(227) + "o na Tela ao Lado do Tipo de Vendedor!!!" + CHR(13) + ;
				"Voc" + CHR(234) + " Est" + CHR(225) + " Tentando Usar Um Tipo de Vendedor Que N" + CHR(227) + "o Existe!!!", ;
				"Aten" + CHR(231) + CHR(227) + "o!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_nMinimos = 0
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Valor M" + CHR(237) + "nimo!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "I" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser Individual e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "S" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser de Setor e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND !EMPTY(ALLTRIM(THIS.this_cSupervs))
			MsgAviso("O Respons" + CHR(225) + "vel N" + CHR(227) + "o Pode Ter Um Respons" + CHR(225) + "vel Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND ;
			EMPTY(ALLTRIM(THIS.this_cSetors)) AND THIS.this_nAdics = 0
			MsgAviso("O Vendedor Respons" + CHR(225) + "vel Tem Que Ter Um Adicional Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		*-- Verificar se usuario ja cadastrado no periodo em SigCcCmI (Vendedor por Cargo)
		IF loc_lValido
			loc_cSQLComI = "SELECT Usuars, Mess, Anos, cIdChaves FROM SigCcCmI" + ;
				" WHERE Usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars))

			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF

			loc_nResComI = SQLEXEC(gnConnHandle, loc_cSQLComI, "cursor_4c_ComI")
			IF loc_nResComI > 0
				SELECT cursor_4c_ComI
				SCAN
					IF ALLTRIM(cursor_4c_ComI.Mess) = ALLTRIM(THIS.this_cMess) AND ;
					   ALLTRIM(cursor_4c_ComI.Anos) = ALLTRIM(THIS.this_cAnos)
						MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado No Per" + ;
							CHR(237) + "odo Como Vendedor Por Cargo!!!", ;
							"Valida" + CHR(231) + CHR(227) + "o")
						loc_lValido = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF
			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF
		ENDIF

		*-- Verificar se supervisor ja tem vinculo no mesmo periodo (se tem setor definido)
		IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cSetors))
			loc_cSQLSupv = "SELECT Usuars FROM SigCcCmV" + ;
				" WHERE Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ;
				" AND Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + ;
				" AND Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ;
				" AND cIdChaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF

			loc_nResSupv = SQLEXEC(gnConnHandle, loc_cSQLSupv, "cursor_4c_Supv")
			IF loc_nResSupv > 0 AND RECCOUNT("cursor_4c_Supv") > 0
				SELECT cursor_4c_Supv
				GO TOP
				IF !EOF("cursor_4c_Supv")
					MsgAviso("Usu" + CHR(225) + "rio Cadastrado Como Vendedor Respons" + CHR(225) + "vel!!!", ;
						"Valida" + CHR(231) + CHR(227) + "o")
					loc_lValido = .F.
				ENDIF
			ENDIF
			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			loc_cSQL = "INSERT INTO SigCcCmV" + ;
				" (cIdChaves, Usuars, Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos, MinExps)" + ;
				" VALUES (" + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cMess)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + ", " + ;
				FormatarNumeroSQL(THIS.this_nAdics) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinExps) + ")"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "UPDATE SigCcCmV SET" + ;
				" Usuars = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + "," + ;
				" Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + "," + ;
				" Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + "," + ;
				" Indivs = " + EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + "," + ;
				" Setors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + "," + ;
				" Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + "," + ;
				" Adics = " + FormatarNumeroSQL(THIS.this_nAdics) + "," + ;
				" Minimos = " + FormatarNumeroSQL(THIS.this_nMinimos) + "," + ;
				" MinExps = " + FormatarNumeroSQL(THIS.this_nMinExps) + ;
				" WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "DELETE FROM SigCcCmV WHERE cIdChaves = " + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CopiarPeriodo - Copia comissoes de um periodo de origem para destino
	* par_cOMess/par_cOAnos: periodo de origem (MM/YYYY)
	* par_cDMess/par_cDAnos: periodo de destino (MM/YYYY)
	* Retorna .T. se ao menos um registro foi gerado com sucesso
	*====================================================================
	PROCEDURE CopiarPeriodo(par_cOMess, par_cOAnos, par_cDMess, par_cDAnos)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_llIns, loc_llOks, loc_lcMsg, loc_llPular
		LOCAL loc_nConnFP2, loc_oProg
		LOCAL loc_cSQLFop, loc_nResFop
		LOCAL loc_cSQLBusca, loc_nResBusca
		LOCAL loc_cNovaChave, loc_cSQLIns, loc_nResIns
		LOCAL loc_cUsar, loc_cIndv, loc_cSet, loc_cSup
		LOCAL loc_nAdi, loc_nMin, loc_nMinEx

		loc_lResultado = .F.
		loc_llIns      = .F.
		loc_llOks      = .T.
		loc_lcMsg      = ""
		loc_llPular    = .F.
		loc_nConnFP2   = 0
		loc_oProg      = .NULL.

		TRY
			*-- Buscar todos os registros do periodo de origem
			loc_cSQL = "SELECT * FROM SigCcCmV" + ;
				" WHERE Mess = " + EscaparSQL(par_cOMess) + ;
				" AND Anos = " + EscaparSQL(par_cOAnos) + ;
				" ORDER BY Usuars"

			IF USED("crOrigem")
				USE IN crOrigem
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crOrigem")
			IF loc_nResult < 1
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem:" + CHR(13) + ;
					CapturarErroSQL(), "Erro SQL")
			ELSE
				SELECT crOrigem
				GO TOP
				IF EOF("crOrigem")
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + CHR(237) + ;
						"odo de Origem Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
				ELSE
					*-- Tentar conexao secundaria para folha de pagamento
					loc_nConnFP2 = SQLCONNECT("SigCcCMV_FOPAGV")

					*-- Criar barra de progresso
					loc_oProg = CREATEOBJECT("fwprogressbar", ;
						"Processando Vendedores...", RECCOUNT("crOrigem") + 1)
					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Show()
					ENDIF

					SELECT crOrigem
					SCAN
						*-- Capturar valores do registro atual antes de mudar area de trabalho
						loc_cUsar  = ALLTRIM(crOrigem.Usuars)
						loc_cIndv  = ALLTRIM(crOrigem.Indivs)
						loc_cSet   = ALLTRIM(crOrigem.Setors)
						loc_cSup   = ALLTRIM(crOrigem.Supervs)
						loc_nAdi   = crOrigem.Adics
						loc_nMin   = crOrigem.Minimos
						loc_nMinEx = crOrigem.MinExps
						loc_llPular = .F.

						IF VARTYPE(loc_oProg) = "O"
							loc_oProg.Update(.T.)
							IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
								loc_oProg.SubTitulo.Caption = "Processando o Vendedor : " + loc_cUsar
							ENDIF
						ENDIF

						*-- Verificar atividade na folha de pagamento (se conexao disponivel)
						IF loc_nConnFP2 > 0
							loc_cSQLFop = "SELECT Funcs, Conds FROM FopCff" + ;
								" WHERE Funcs = " + EscaparSQL(loc_cUsar) + ;
								" ORDER BY Funcs"

							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF

							loc_nResFop = SQLEXEC(loc_nConnFP2, loc_cSQLFop, "crFopCff")
							IF loc_nResFop > 0
								SELECT crFopCff
								GO TOP
								IF EOF("crFopCff") OR INLIST(ALLTRIM(crFopCff.Conds), "D", "Q")
									loc_lcMsg = loc_lcMsg + loc_cUsar + ;
										IIF(!EOF("crFopCff"), "(" + ALLTRIM(crFopCff.Conds) + "); ", "; ")
									loc_llPular = .T.
								ENDIF
							ENDIF
							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF
						ENDIF

						IF !loc_llPular
							*-- Verificar se ja existe no periodo de destino
							loc_cSQLBusca = "SELECT cIdChaves FROM SigCcCmV" + ;
								" WHERE Usuars = " + EscaparSQL(loc_cUsar) + ;
								" AND Indivs = " + EscaparSQL(loc_cIndv) + ;
								" AND Setors = " + EscaparSQL(loc_cSet) + ;
								" AND Mess = " + EscaparSQL(par_cDMess) + ;
								" AND Anos = " + EscaparSQL(par_cDAnos)

							IF USED("crBusca")
								USE IN crBusca
							ENDIF

							loc_nResBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "crBusca")
							IF loc_nResBusca > 0
								SELECT crBusca
								GO TOP
								IF EOF("crBusca")
									*-- Inserir novo registro no periodo de destino
									loc_cNovaChave = fUniqueIds()
									loc_cSQLIns = "INSERT INTO SigCcCmV" + ;
										" (cIdChaves, Usuars, Mess, Anos, Indivs," + ;
										" Setors, Supervs, Adics, Minimos, MinExps)" + ;
										" VALUES (" + ;
										EscaparSQL(loc_cNovaChave) + ", " + ;
										EscaparSQL(loc_cUsar) + ", " + ;
										EscaparSQL(par_cDMess) + ", " + ;
										EscaparSQL(par_cDAnos) + ", " + ;
										EscaparSQL(loc_cIndv) + ", " + ;
										EscaparSQL(loc_cSet) + ", " + ;
										EscaparSQL(loc_cSup) + ", " + ;
										FormatarNumeroSQL(loc_nAdi) + ", " + ;
										FormatarNumeroSQL(loc_nMin) + ", " + ;
										FormatarNumeroSQL(loc_nMinEx) + ")"

									loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)
									IF loc_nResIns > 0
										loc_llIns = .T.
									ELSE
										MsgErro("Falha ao inserir vendedor " + loc_cUsar + ":" + ;
											CHR(13) + CapturarErroSQL(), "Erro SQL")
										loc_llOks = .F.
									ENDIF
								ENDIF
							ENDIF
							IF USED("crBusca")
								USE IN crBusca
							ENDIF
						ENDIF

						IF !loc_llOks
							EXIT
						ENDIF
					ENDSCAN

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Update(.T.)
						IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
							loc_oProg.SubTitulo.Caption = "Atualizando Os Registros"
						ENDIF
					ENDIF

					IF loc_llIns
						IF loc_llOks
							IF !EMPTY(loc_lcMsg)
								MsgAviso("N" + CHR(227) + "o Gerados: " + loc_lcMsg, ;
									"C" + CHR(243) + "pia Parcialmente Conclu" + CHR(237) + "da")
							ELSE
								MsgInfo("Os Registros Foram Gerados Com Sucesso!!!", ;
									"C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
							ENDIF
							loc_lResultado = .T.
						ELSE
							MsgErro("Houve Uma Falha na Grava" + CHR(231) + CHR(227) + ;
								"o e Os Registros N" + CHR(195) + "O Foram Gerados!!!", "Erro!!!")
						ENDIF
					ELSE
						MsgAviso("Nenhum Registro Foi Gerado!!!", ;
							"C" + CHR(243) + "pia Conclu" + CHR(237) + "da Sem Sucesso")
					ENDIF

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Complete()
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CopiarPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- Limpeza de cursores e conexao secundaria (FORA do TRY)
		IF USED("crOrigem")
			USE IN crOrigem
		ENDIF
		IF USED("crFopCff")
			USE IN crFopCff
		ENDIF
		IF USED("crBusca")
			USE IN crBusca
		ENDIF
		IF loc_nConnFP2 > 0
			SQLDISCONNECT(loc_nConnFP2)
		ENDIF

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE
