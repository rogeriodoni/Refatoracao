*====================================================================
* SigOpDesBO.prg
*
* Business Object para Selecao de Descontos (dialogo modal aberto a
* partir da grade de itens de um movimento de venda).
*
* Tabela gravada ao confirmar a selecao: SigMvItd (uma linha por tipo
* de desconto marcado na grade). Tabela consultada/atualizada para o
* controle de cota acumulada por empresa: SigCdDes.
*
* O item/movimento de origem (Emps/Dopes/Numes/Cpros/Citens/...) e o
* cadastro do produto atual (Cgrus/Sgrus/...) sao fornecidos pelo form
* chamador - esta nova arquitetura nao depende mais dos cursores
* globais do legado (TprMvCab/crTpmMvItn), que sao passados pelo
* FormBase chamador via parametro.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpDesBO AS BusinessBase

	*-- Contexto do movimento/item (equivalente a TprMvCab/crTpmMvItn do legado)
	this_cEmps       = ""   && Emps       char(3)  - empresa do movimento
	this_cDopes      = ""   && Dopes      char(20) - documento/operacao do movimento
	this_nNumes      = 0    && Numes      numeric(6,0) - numero do movimento
	this_cContads    = ""   && Contads    char(10) - codigo da conta/cliente do movimento
	this_dDatas      = {}   && Datas      datetime - data do movimento
	this_cEmpDopNums = ""   && EmpDopNums char(29) - chave posicional Emps+Dopes+Numes (regra #42, NAO usar ALLTRIM nas partes)
	this_cCpros      = ""   && Cpros      char(14) - codigo do produto do item atual
	this_nCitens     = 0    && Citens     numeric  - numero/indice do item na lista de itens
	this_nUnitOrigs  = 0    && UnitOrigs  numeric(14,6) - valor unitario original do item (base do desconto)
	this_nQtds       = 0    && Qtds       numeric(9,3)  - quantidade do item
	this_nTotas      = 0    && Totas      numeric(11,2) - valor total do item

	*-- Cadastro do produto atual (SigCdPro), usado nas regras de elegibilidade de desconto
	this_cCgrus      = ""   && Cgrus      - grupo do produto
	this_cSgrus      = ""   && Sgrus      - subgrupo do produto
	this_cCodcors    = ""   && Codcors    - codigo da cor do produto
	this_cColecoes   = ""   && Colecoes   - codigo da colecao do produto
	this_cCodfinp    = ""   && Codfinp    - codigo do acabamento/finp do produto
	this_nPvens      = 0    && Pvens      - preco de venda atual do produto
	this_dDtLacto    = {}   && DtLacto    - data de lancamento do produto
	this_lForaLinha  = .F.  && ForaLinha  - indica produto fora de linha
	this_nPrecode    = 0    && Precode    - indica produto de/por (preco promocional)

	*-- Totais da selecao de desconto (equivalente a ThisForm.lnValor/lnSaldo/lnTDesc do legado)
	this_nValor      = 0    && Valor original do item, base do calculo de desconto
	this_nSaldo      = 0    && Saldo apos aplicar os descontos selecionados na grade
	this_nTDesc      = 0    && Soma dos valores de desconto selecionados na grade

	*-- Cota de desconto da empresa (SigCdDes), controla o limite acumulado
	this_cCodigo     = ""   && Codigo    char(10)      - PK de SigCdDes
	this_nValCota    = 0    && ValCota   numeric(11,2) - valor da cota de desconto da empresa
	this_nValDes     = 0    && ValDes    numeric(11,2) - valor de desconto ja utilizado (acumulado)
	this_nValMeta    = 0    && ValMeta   numeric(11,2) - valor da meta de venda da empresa
	this_nValCotaC   = 0    && ValCotaC  numeric(11,2) - valor da cota complementar

	*-- Soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	*-- mesmo movimento, restrita aos tipos que CONSOMEM a cota da
	*-- empresa. Equivale ao lnTDescM do calctots legado, que vem de
	*-- "SELECT crSigmvitd / SUM vdes to lnTDescM for
	*--  !INLIST(tpdesc,1,2,6,7,10,11,12,13) AND citens <> pcItem".
	*-- crSigmvitd e' cursor global do form chamador, que esta
	*-- arquitetura nao tem: a soma e' resolvida por
	*-- CarregarDescontoOutrosItens e lida pelo CalcularTotais do form.
	this_nVDescOutrosItens = 0

	*-- Linha de desconto a gravar em SigMvItd quando o usuario confirma a selecao
	this_cCidChaves  = ""   && CidChaves char(20)      - PK da linha de desconto (gerada por fUniqueIds())
	this_dDtAlts     = {}   && DtAlts    datetime      - data/hora da inclusao do desconto
	this_cCdesc      = ""   && Cdesc     char(10)      - codigo do tipo de desconto selecionado (SigOpTdz.codigos)
	this_cDdesc      = ""   && Ddesc     char(30)      - descricao do tipo de desconto selecionado
	this_nPdes       = 0    && Pdes      numeric(7,4)  - percentual de desconto aplicado
	this_nVdes       = 0    && Vdes      numeric(9,2)  - valor de desconto aplicado
	this_nValBase    = 0    && ValBase   numeric(10,2) - valor base sobre o qual o desconto foi calculado
	this_nTpDesc     = 0    && TpDesc    numeric(2,0)  - tipo de desconto (1=aniversario,2=financeiro,3=relogio,6=troca,7=updiamond,8=supervisor,9=diretoria,10=upalianca,11=extra,12=brinde,13=alteracao de preco)
	this_cUsuars     = ""   && Usuars    char(10)      - usuario que autorizou/incluiu o desconto

	*-- Colunas NOT NULL de SigMvItd que o INSERT legado NUNCA cita (regra #22 -
	*-- invisiveis no dump porque nao tem controle na tela nem property no SCX).
	*-- Sem valor proprio no legado: usar o default documentado (numeric -> 0,
	*-- char -> vazio) para nao quebrar o INSERT com "valor NULL" no SQL Server.
	this_nCitensTpDesc = 0  && CitensTpDesc numeric(4,0) - sem referencia no legado, default 0
	this_cChaveexterna = "" && ChaveExterna char(33)     - sem referencia no legado, default vazio

	*-- Contexto de ELEGIBILIDADE do item, consultado por
	*-- ConsultarContextoElegibilidade e lido por FiltrarElegibilidade.
	*-- Cada uma substitui o RECCOUNT() de um cursor auxiliar do Init
	*-- legado (ver o comentario de FiltrarElegibilidade).
	this_nQtdPromoImp  = 0  && crProPro - SigImpPr vigente para o produto
	this_nQtdAniv      = 0  && crClid   - SigCdCli.nascs no mes corrente
	this_nQtdPrecoAlt  = 0  && crPre    - SigPrPre com troca de preco em 2 dias
	this_nDescPrecoAlt = 0  && crPre.descos - percentual da troca de preco (teto do tipo 13)
	this_nQtdItdJolie  = 0  && crItdJ   - SigMvItd ja gravado com o tipo 2 do grupo configurado

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigMvItd"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso
	* em RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de SigMvItd do cursor
	* para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes
	* de acessar os campos (regra #9 CLAUDE.md).
	*
	* O 2o argumento de TratarNulo e' o VALOR PADRAO devolvido quando a
	* coluna vem NULL, NAO um codigo de tipo: TratarNulo(citens, "N")
	* gravaria a STRING "N" numa property numerica e a primeira conta
	* feita com ela estouraria por tipo. Por isso cada chamada abaixo
	* passa o default do TIPO da property - "" para char, 0 para numeric
	* e {} para datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCdesc         = TratarNulo(cdesc, "")
				THIS.this_cCidChaves     = TratarNulo(cidchaves, "")
				THIS.this_nCitens        = TratarNulo(citens, 0)
				THIS.this_cCpros         = TratarNulo(cpros, "")
				THIS.this_cDdesc         = TratarNulo(ddesc, "")
				THIS.this_cDopes         = TratarNulo(dopes, "")
				THIS.this_dDtAlts        = TratarNulo(dtalts, {})
				THIS.this_cEmpDopNums    = TratarNulo(empdopnums, "")
				THIS.this_cEmps          = TratarNulo(emps, "")
				THIS.this_nNumes         = TratarNulo(numes, 0)
				THIS.this_nPdes          = TratarNulo(pdes, 0)
				THIS.this_cUsuars        = TratarNulo(usuars, "")
				THIS.this_nValBase       = TratarNulo(valbase, 0)
				THIS.this_nVdes          = TratarNulo(vdes, 0)
				THIS.this_nCitensTpDesc  = TratarNulo(citenstpdesc, 0)
				THIS.this_cCodigo        = TratarNulo(codigo, "")
				THIS.this_nTpDesc        = TratarNulo(tpdesc, 0)
				THIS.this_cChaveexterna  = TratarNulo(chaveexterna, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere nova linha de desconto em SigMvItd
	* PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida -
	* equivalente a "lcIdChave = fUniqueIds()" do btnConfirmar.Click legado.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
				THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- DtAlts = data/hora da inclusao (equivalente a DATETIME() do legado)
			THIS.this_dDtAlts = DATETIME()

			loc_cSQL = "INSERT INTO SigMvItd ("
			loc_cSQL = loc_cSQL + "cdesc, cidchaves, citens, cpros, ddesc, dopes, dtalts, empdopnums,"
			loc_cSQL = loc_cSQL + "emps, numes, pdes, usuars, valbase, vdes, citenstpdesc, codigo,"
			loc_cSQL = loc_cSQL + "tpdesc, chaveexterna"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza linha de desconto existente em SigMvItd (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo posicional Emps+Dopes+Numes (regra #42 - NUNCA ALLTRIM nas partes)
			THIS.this_cEmpDopNums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			loc_cSQL = "UPDATE SigMvItd SET"
			loc_cSQL = loc_cSQL + " cdesc = " + EscaparSQL(LEFT(THIS.this_cCdesc, 10)) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " ddesc = " + EscaparSQL(LEFT(THIS.this_cDdesc, 30)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pdes = " + FormatarNumeroSQL(THIS.this_nPdes, 4) + ","
			loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
			loc_cSQL = loc_cSQL + " valbase = " + FormatarNumeroSQL(THIS.this_nValBase, 2) + ","
			loc_cSQL = loc_cSQL + " vdes = " + FormatarNumeroSQL(THIS.this_nVdes, 2) + ","
			loc_cSQL = loc_cSQL + " citenstpdesc = " + FormatarNumeroSQL(THIS.this_nCitensTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " codigo = " + EscaparSQL(LEFT(THIS.this_cCodigo, 10)) + ","
			loc_cSQL = loc_cSQL + " tpdesc = " + FormatarNumeroSQL(THIS.this_nTpDesc, 0) + ","
			loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidChaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar desconto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em SigOpDesBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirDescontosDoItem - remove TODAS as linhas de desconto do item
	* corrente em SigMvItd, antes de btnConfirmar.Click regravar a
	* selecao atual da grade.
	*
	* Legado (btnConfirmar.Click):
	*   SELECT crsigmvitd
	*   DELETE all for cpros = crTpmMvItn.cpros and citens = crTpmMvItn.citens
	*
	* crsigmvitd e' cursor GLOBAL do form chamador (todas as linhas de
	* desconto do movimento, de TODOS os itens) - nesta arquitetura o
	* DELETE vai direto na tabela, restrito ao mesmo par cpros/citens, que
	* e' exatamente o que o FOR do legado filtra.
	*
	* PUBLIC: chamado pelo form em BtnConfirmarClick (regra #51 - metodo
	* chamado de fora nunca pode ser PROTECTED).
	*====================================================================
	PROCEDURE ExcluirDescontosDoItem()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso

		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCpros, "")))
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelItd")

			IF loc_nResult < 0
				MsgErro("Erro ao remover os descontos anteriores do item:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_DelItd")
				USE IN cursor_4c_DelItd
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.ExcluirDescontosDoItem")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ContarSQL - devolve o escalar da coluna N de um SELECT COUNT(*)
	* executado no SQL Server. Centraliza o padrao
	* "SQLEXEC -> le N -> fecha cursor" usado pelas checagens de
	* elegibilidade abaixo, que no legado eram RECCOUNT() de cursores
	* auxiliares (crProPro/crClid/crItdJ).
	*
	* O cursor de apoio e' SEMPRE fechado antes e depois, para nao deixar
	* alias aberto entre chamadas (o 2o SQLEXEC no mesmo alias erraria).
	* PROTECTED - chamado so por THIS. dentro do proprio BO (regra #51).
	*====================================================================
	PROTECTED FUNCTION ContarSQL(par_cSQL)
		LOCAL loc_nTotal, loc_nResult, loc_nAliasAnt

		loc_nTotal    = 0
		loc_nAliasAnt = SELECT()

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		loc_nResult = SQLEXEC(gnConnHandle, par_cSQL, "cursor_4c_DesCnt")

		IF loc_nResult >= 0 AND USED("cursor_4c_DesCnt")
			SELECT cursor_4c_DesCnt
			IF !EOF()
				loc_nTotal = NVL(cursor_4c_DesCnt.N, 0)
			ENDIF
		ENDIF

		IF USED("cursor_4c_DesCnt")
			USE IN cursor_4c_DesCnt
		ENDIF

		IF loc_nAliasAnt > 0
			SELECT (loc_nAliasAnt)
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ContarTipoConfig - conta linhas de cursor_4c_TipoTmp (o crTipo do
	* legado: SigOpTdt cruzado com SigOpTdz) para um par Tipos/TpDesc,
	* opcionalmente restrito ao grupo informado em Codtips.
	*
	* Substitui os RECCOUNT() dos cursores auxiliares do Init legado:
	*   crTipoRe   = crTipo where tipos = 1 and tpdesc = 3   (relogio)
	*   crTipoExAl = crTipo where tipos = 1 and tpdesc = 11  (extra alianca)
	*   crTipoJ    = crTipo where tipos = 1 and tpdesc = 2   (jolie)
	*   crGrRe/crGrAl/crGrJ = o MESMO conjunto, restrito a
	*                         "cgrus do produto in (codtips)"
	*
	* par_nUsarCod e' NUMERICO (0 = conta o par Tipos/TpDesc inteiro,
	* 1 = conta so as linhas cujo Codtips casa com par_cCodTips) de
	* proposito: parametro LOGICO omitido obriga teste de PCOUNT para ser
	* lido com seguranca.
	*
	* O RECNO corrente de cursor_4c_TipoTmp e' reposto no fim - o SCAN
	* move o ponteiro e outras checagens leem o mesmo alias depois.
	*====================================================================
	PROTECTED FUNCTION ContarTipoConfig(par_nTipos, par_nTpDesc, par_nUsarCod, par_cCodTips)
		LOCAL loc_nTotal, loc_nRecAnt, loc_cCod, loc_nAliasAnt

		loc_nTotal = 0

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			loc_cCod      = IIF(VARTYPE(par_cCodTips) = "C", ALLTRIM(par_cCodTips), "")

			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					IF par_nUsarCod = 0 OR ;
					   ALLTRIM(cursor_4c_TipoTmp.Codtips) == loc_cCod
						loc_nTotal = loc_nTotal + 1
					ENDIF
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_nTotal
	ENDFUNC

	*====================================================================
	* ObterCodigoTipoConfig - devolve o Codigos da PRIMEIRA linha de
	* cursor_4c_TipoTmp para o par Tipos/TpDesc informado.
	*
	* Reproduz a leitura do legado "crTipoExAl.codigos" / "crTipoJ.codigos"
	* nos DELETE condicionais: apos "SELECT * from crTipo where ... into
	* cursor crTipoXX" o ponteiro fica no TOPO, entao o que o legado le e'
	* o primeiro registro da ordenacao por cidchaves - que e' a ordenacao
	* com que cursor_4c_TipoTmp e' criado.
	*====================================================================
	PROTECTED FUNCTION ObterCodigoTipoConfig(par_nTipos, par_nTpDesc)
		LOCAL loc_cCodigo, loc_nRecAnt, loc_nAliasAnt

		loc_cCodigo = ""

		IF USED("cursor_4c_TipoTmp")
			loc_nAliasAnt = SELECT()
			SELECT cursor_4c_TipoTmp
			loc_nRecAnt = IIF(EOF("cursor_4c_TipoTmp"), 0, RECNO("cursor_4c_TipoTmp"))

			SCAN
				IF cursor_4c_TipoTmp.Tipos = par_nTipos AND ;
				   cursor_4c_TipoTmp.Tpdesc = par_nTpDesc
					loc_cCodigo = ALLTRIM(NVL(cursor_4c_TipoTmp.Codigos, ""))
					EXIT
				ENDIF
			ENDSCAN

			IF loc_nRecAnt > 0 AND loc_nRecAnt <= RECCOUNT("cursor_4c_TipoTmp")
				GO loc_nRecAnt IN cursor_4c_TipoTmp
			ENDIF

			IF loc_nAliasAnt > 0
				SELECT (loc_nAliasAnt)
			ENDIF
		ENDIF

		RETURN loc_cCodigo
	ENDFUNC

	*====================================================================
	* CarregarCota - popula cursor_4c_Cota (crSigCdDes do legado) com a
	* cota de desconto da empresa do movimento: codigo, empresa, cota
	* contratada, cota ja utilizada e meta.
	*
	* No legado crSigCdDes NAO e' consultado neste form - ele chega aberto
	* do form chamador, que o monta a partir de SigCdDes. Aqui a consulta
	* e' feita no proprio BO, filtrada pela empresa do movimento
	* (this_cEmps), que e' a mesma linha que o legado exibia.
	*
	* A coluna Valdes trazida aqui e' o acumulado GRAVADO em SigCdDes;
	* CalcTots soma a ela os descontos da tela antes de exibir.
	*
	* SQLEXEC NUNCA sobre o alias ligado ao Grid (isso zeraria o
	* ColumnCount): a consulta vai para cursor_4c_CotaTmp e cursor_4c_Cota
	* e' recarregado com ZAP + APPEND FROM DBF(), que preserva estrutura,
	* RecordSource e ControlSource.
	*====================================================================
	PROCEDURE CarregarCota()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps

		loc_lSucesso = .F.

		TRY
			loc_cEmps = ALLTRIM(NVL(THIS.this_cEmps, ""))

			loc_cSQL = "SELECT ISNULL(codigo, '') AS Codigo,"
			loc_cSQL = loc_cSQL + " ISNULL(emps, '') AS Emps,"
			loc_cSQL = loc_cSQL + " ISNULL(valcota, 0) AS Valcota,"
			loc_cSQL = loc_cSQL + " ISNULL(valdes, 0) AS Valdes,"
			loc_cSQL = loc_cSQL + " ISNULL(valmeta, 0) AS Valmeta"
			loc_cSQL = loc_cSQL + " FROM SigCdDes"
			loc_cSQL = loc_cSQL + " WHERE emps = " + EscaparSQL(loc_cEmps)
			loc_cSQL = loc_cSQL + " ORDER BY codigo"

			IF USED("cursor_4c_CotaTmp")
				USE IN cursor_4c_CotaTmp
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotaTmp")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar a cota de descontos da empresa:" + ;
						CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF !USED("cursor_4c_Cota")
					SET NULL ON
					CREATE CURSOR cursor_4c_Cota ;
						(Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
						 Codigo C(10), Valmeta N(11,2))
					SET NULL OFF
				ENDIF

				SELECT cursor_4c_Cota
				ZAP

				IF USED("cursor_4c_CotaTmp") AND RECCOUNT("cursor_4c_CotaTmp") > 0
					SELECT cursor_4c_Cota
					APPEND FROM DBF("cursor_4c_CotaTmp")
				ENDIF

				IF USED("cursor_4c_CotaTmp")
					USE IN cursor_4c_CotaTmp
				ENDIF

				SELECT cursor_4c_Cota
				GO TOP

				*-- Codigo da cota vigente: e' o "crSigcdDes.codigo" que o
				*-- btnConfirmar.Click legado grava em SigMvItd.codigo.
				IF !EOF("cursor_4c_Cota")
					THIS.this_cCodigo  = ALLTRIM(NVL(cursor_4c_Cota.Codigo, ""))
					THIS.this_nValCota = NVL(cursor_4c_Cota.Valcota, 0)
					THIS.this_nValDes  = NVL(cursor_4c_Cota.Valdes, 0)
					THIS.this_nValMeta = NVL(cursor_4c_Cota.Valmeta, 0)
				ENDIF

				*-- lnTDescM do calctots legado: os descontos ja gravados
				*-- pelos OUTROS itens do movimento entram na cota
				*-- utilizada que a grade exibe. Resolvido aqui, junto com
				*-- a cota, porque e' a mesma conta e nao muda enquanto o
				*-- dialogo esta aberto. O retorno nao condiciona o
				*-- sucesso da carga da cota: sem a soma dos outros itens
				*-- a tela ainda abre e opera, so a cota utilizada fica
				*-- sem essa parcela - e a falha de SQL ja foi exibida.
				THIS.CarregarDescontoOutrosItens()

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarCota")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDescontoOutrosItens - resolve o lnTDescM do calctots legado:
	* a soma dos descontos JA GRAVADOS em SigMvItd pelos OUTROS itens do
	* mesmo movimento, contando so os tipos que CONSOMEM a cota da
	* empresa.
	*
	* Legado (PROCEDURE calctots):
	*
	*   SELECT crSigmvitd
	*   GO top
	*   SUM vdes to lnTDescM for !INLIST(tpdesc,1,2,6,7,10,11,12,13)
	*                            AND citens <> pcItem
	*
	* crSigmvitd e' um cursor GLOBAL do form chamador (todos os itens de
	* desconto do movimento), igual a TprMvCab/crTpmMvItn - nao existe
	* nesta arquitetura, entao a mesma conta e' feita no SQL Server com o
	* filtro IDENTICO: mesmo movimento (empdopnums), outro item
	* (citens <> this_nCitens) e a MESMA lista de tipos excluidos.
	*
	* Os oito tipos de fora sao aniversario(1), financeiro(2), troca
	* zerada(6), up diamond(7), upgrade alianca(10), extra/loja(11),
	* brinde(12) e troca de preco(13) - a lista do comentario do legado
	* ("nao entra na cota A,V,TZ,UP,UpAlianca,extra/loja,brinde,troca
	* preco"). NAO confundir com a lista do teste de ESTOURO da cota nos
	* Valid das celulas, que exclui apenas 1, 2, 9 e 11: o legado tem duas
	* listas diferentes de proposito.
	*
	* Resolvido UMA vez, na carga: esta tela edita UM item, os descontos
	* dos outros itens nao mudam enquanto o dialogo esta aberto, e o
	* legado tambem nao os reconsulta (ele so re-soma um cursor que
	* ninguem alterou entre uma chamada de calctots e a seguinte).
	*
	* A chave do movimento e' POSICIONAL (regra #42): Emps char(3) +
	* Dopes char(20) + Str(Numes, 6) = char(29). PADR explicito em cada
	* parte, NUNCA ALLTRIM - encurtar qualquer parte desloca a chave, o
	* SELECT nao casa nada e devolve ZERO linhas sem erro nenhum, o que
	* faria a cota utilizada ser calculada sem os outros itens.
	*
	* Zero linhas NAO e' falha: movimento com um unico item, ou com
	* descontos so dos tipos excluidos, soma zero - exatamente o que o
	* legado obtem com crSigmvitd vazio.
	*====================================================================
	PROCEDURE CarregarDescontoOutrosItens()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpDopNums

		loc_lSucesso = .F.

		TRY
			THIS.this_nVDescOutrosItens = 0

			loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
							  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
							  STR(NVL(THIS.this_nNumes, 0), 6)

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF

			loc_cSQL = "SELECT ISNULL(SUM(vdes), 0) AS Vdes"
			loc_cSQL = loc_cSQL + " FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
			loc_cSQL = loc_cSQL + " AND citens <> " + ;
								  FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc NOT IN (1, 2, 6, 7, 10, 11, 12, 13)"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdOutros")

			IF loc_nResult < 0
				MsgErro("Erro ao somar os descontos dos demais itens do " + ;
						"movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED("cursor_4c_ItdOutros") AND ;
				   RECCOUNT("cursor_4c_ItdOutros") > 0
					SELECT cursor_4c_ItdOutros
					GO TOP
					THIS.this_nVDescOutrosItens = NVL(cursor_4c_ItdOutros.Vdes, 0)
				ENDIF

				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItdOutros")
				USE IN cursor_4c_ItdOutros
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontoOutrosItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ConsultarContextoElegibilidade - executa as consultas de contexto
	* que o Init legado fazia em cursores auxiliares e guarda o resultado
	* nas propriedades this_nQtd*/this_nDescPrecoAlt.
	*
	* Equivalencia com o legado, consulta por consulta:
	*
	*   crProPro -> this_nQtdPromoImp  (SigImpPr vigente na data do
	*               movimento; havendo promocao, so sobram os tipos 8 e 9)
	*   crClid   -> this_nQtdAniv      (SigCdCli.nascs no mes corrente;
	*               sem aniversario, o tipo 1 sai)
	*   crPre    -> this_nQtdPrecoAlt / this_nDescPrecoAlt (SigPrPre com
	*               troca de preco nos ultimos 2 dias; sem troca o tipo 13
	*               sai, com troca o percentual vira o teto do tipo 13)
	*   crItdJ   -> this_nQtdItdJolie  (SigMvItd ja gravado com o desconto
	*               tipo 2 do grupo configurado para este item)
	*
	* A divisao de crPre e' feita no VFP e nao no SQL Server porque
	* "ROUND((pvens - pvensant) / pvens * 100, 2)" com pvens = 0 ABORTA a
	* query inteira no SQL Server (divide by zero); aqui o zero devolve 0
	* e o tipo 13 fica com o teto do proprio cadastro, em vez de a tela
	* inteira falhar.
	*
	* ORDEM: depende de cursor_4c_TipoTmp ja estar carregado, porque o
	* codigo do tipo 2 jolie sai de ObterCodigoTipoConfig.
	*====================================================================
	PROTECTED PROCEDURE ConsultarContextoElegibilidade()
		LOCAL loc_cSQL, loc_cCpros, loc_cContads, loc_dBase, loc_dLimite
		LOCAL loc_nResult, loc_cCodTipoJ, loc_nPvens, loc_nPvensAnt

		loc_cCpros   = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cContads = ALLTRIM(NVL(THIS.this_cContads, ""))

		*-- Data base do movimento (TprMvCab.datas no legado). Sem data no
		*-- contexto cai em DATE(), para as comparacoes de vigencia nunca
		*-- virarem comparacao com NULL (que nao casa nada em silencio).
		loc_dBase = ConverterParaData(THIS.this_dDatas)
		IF EMPTY(loc_dBase)
			loc_dBase = DATE()
		ENDIF

		*-- Legado: ldData = DTOT(TTOD(TprMvCab.datas) - 2)
		loc_dLimite = loc_dBase - 2

		THIS.this_nQtdPromoImp  = 0
		THIS.this_nQtdAniv      = 0
		THIS.this_nQtdPrecoAlt  = 0
		THIS.this_nDescPrecoAlt = 0
		THIS.this_nQtdItdJolie  = 0

		*-- crProPro: produto com promocao de importacao vigente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigImpPr"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND dtinicial <= " + FormatarDataSQL(loc_dBase)
		loc_cSQL = loc_cSQL + " AND dtfinal >= " + FormatarDataSQL(loc_dBase)
		THIS.this_nQtdPromoImp = THIS.ContarSQL(loc_cSQL)

		*-- crClid: aniversario do cliente no mes corrente
		loc_cSQL = "SELECT COUNT(*) AS N FROM SigCdCli"
		loc_cSQL = loc_cSQL + " WHERE iclis = " + EscaparSQL(loc_cContads)
		loc_cSQL = loc_cSQL + " AND nascs IS NOT NULL"
		loc_cSQL = loc_cSQL + " AND MONTH(nascs) = " + FormatarNumeroSQL(MONTH(DATE()), 0)
		THIS.this_nQtdAniv = THIS.ContarSQL(loc_cSQL)

		*-- crPre: troca de preco do produto nos ultimos 2 dias
		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		loc_cSQL = "SELECT TOP 1 ISNULL(pvens, 0) AS Pvens,"
		loc_cSQL = loc_cSQL + " ISNULL(pvensant, 0) AS Pvensant"
		loc_cSQL = loc_cSQL + " FROM SigPrPre"
		loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND datas >= " + FormatarDataSQL(loc_dLimite)
		loc_cSQL = loc_cSQL + " ORDER BY datas DESC"

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PreTmp")

		IF loc_nResult >= 0 AND USED("cursor_4c_PreTmp")
			SELECT cursor_4c_PreTmp
			IF !EOF()
				THIS.this_nQtdPrecoAlt = RECCOUNT("cursor_4c_PreTmp")
				loc_nPvens    = NVL(cursor_4c_PreTmp.Pvens, 0)
				loc_nPvensAnt = NVL(cursor_4c_PreTmp.Pvensant, 0)
				IF loc_nPvens <> 0
					THIS.this_nDescPrecoAlt = ROUND((loc_nPvens - loc_nPvensAnt) / ;
													loc_nPvens * 100, 2)
				ENDIF
			ENDIF
		ENDIF

		IF USED("cursor_4c_PreTmp")
			USE IN cursor_4c_PreTmp
		ENDIF

		*-- crItdJ: desconto tipo 2 do grupo configurado ja gravado para
		*-- este item (havendo, o tipo 2 permanece na grade).
		loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)

		IF !EMPTY(loc_cCodTipoJ)
			loc_cSQL = "SELECT COUNT(*) AS N FROM SigMvItd"
			loc_cSQL = loc_cSQL + " WHERE cpros = " + EscaparSQL(loc_cCpros)
			loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)
			loc_cSQL = loc_cSQL + " AND tpdesc = 2"
			loc_cSQL = loc_cSQL + " AND cdesc = " + EscaparSQL(loc_cCodTipoJ)
			THIS.this_nQtdItdJolie = THIS.ContarSQL(loc_cSQL)
		ENDIF
	ENDPROC

	*====================================================================
	* FiltrarElegibilidade - aplica sobre par_cAlias (copia de trabalho
	* dos tipos de desconto) os DELETE de elegibilidade do Init legado,
	* na MESMA ordem em que o legado os executa.
	*
	* Mapa linha a linha com o legado:
	*
	*  1) if RECCOUNT('crItnS') = 0 -> DELETE for INLIST(tpdesc,6,7,10)
	*     crItnS e' o item de SUBNIVEL, que no legado vem do cursor
	*     crEesti aberto pelo form chamador. O contrato de Init deste form
	*     recebe o item ATUAL, nao a troca de subnivel, logo RECCOUNT = 0
	*     e os tipos de troca (6 = troca zerada, 7 = up diamond,
	*     10 = upgrade alianca) saem - exatamente o que o legado faz
	*     quando nao ha subnivel.
	*  2) if RECCOUNT('crTipoExAl') <> 0 and RECCOUNT('crGrAl') = 0
	*        -> DELETE for tpdesc = 11 and codigos = crTipoExAl.codigos
	*  3) if RECCOUNT('crPre') = 0 -> DELETE for INLIST(tpdesc,13)
	*     senao -> replace descosmax with crPre.descos for tpdesc = 13
	*  4) if RECCOUNT('crGrRe') = 0 -> DELETE for INLIST(tpdesc,3)
	*  5) if nascs vazio ou de outro mes -> DELETE for INLIST(tpdesc,1)
	*  6) if RECCOUNT('crProPro') > 0 -> DELETE for !INLIST(tpdesc,8,9)
	*  7) if RECCOUNT('crDepor') > 0 -> DELETE for !INLIST(tpdesc,2,8,9)
	*     crDepor e' "SigCdPro where cpros = X and precode <> 0", que o
	*     contexto ja traz em this_nPrecode.
	*  8) jolie -> DELETE for tpdesc = 2 and codigos = crTipoJ.codigos
	*
	* Dois DELETE do legado ficam de FORA, por motivos opostos:
	*
	*  - FORA DE LINHA: o bloco "DELETE for !INLIST(tpdesc,2,5,8,9)" esta
	*    COMENTADO no legado (*!*), com a nota "Permite descontos mesmo se
	*    produto fora de linha" - manter o comportamento comentado e' a
	*    leitura fiel, e por isso this_lForaLinha nao filtra nada aqui.
	*  - BRINDE (tipo 12): o legado so o mantem quando SigCdPmc tem
	*    promocao vigente com "valmin <= valor dos OUTROS itens do
	*    movimento"; esse somatorio vem do cursor de itens do form
	*    chamador, que nao faz parte do contrato de Init. Filtrar por um
	*    total arbitrario RETIRARIA da tela um desconto que o legado
	*    concede, entao o tipo 12 permanece e a autorizacao continua
	*    sendo cobrada no fluxo de confirmacao.
	*
	* A condicao jolie do legado tem DOIS ramos ligados por OR; aqui
	* entra apenas o primeiro ("grupo configurado no tipo 2 e o produto
	* fora desse grupo"), porque o segundo depende do mesmo somatorio de
	* itens do chamador. O ramo aplicado e' um SUBCONJUNTO do que o legado
	* apaga, logo nenhum tipo que o legado mantem e' retirado.
	*====================================================================
	PROTECTED PROCEDURE FiltrarElegibilidade(par_cAlias)
		LOCAL loc_nTipoExAl, loc_nGrupoExAl, loc_cCodExAl
		LOCAL loc_nTipoRe, loc_nGrupoRe, loc_nTipoJ, loc_nGrupoJ, loc_cCodTipoJ
		LOCAL loc_cCgrus

		loc_cCgrus = ALLTRIM(NVL(THIS.this_cCgrus, ""))

		*-- (1) sem item de subnivel: tipos de troca saem
		SELECT (par_cAlias)
		DELETE FOR INLIST(Tpdesc, 6, 7, 10)

		*-- (2) tipo 11 com grupo configurado que nao e' o do produto
		loc_nTipoExAl  = THIS.ContarTipoConfig(1, 11, 0, "")
		loc_nGrupoExAl = THIS.ContarTipoConfig(1, 11, 1, loc_cCgrus)

		IF loc_nTipoExAl <> 0 AND loc_nGrupoExAl = 0
			loc_cCodExAl = THIS.ObterCodigoTipoConfig(1, 11)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 11 AND ALLTRIM(Codigos) == loc_cCodExAl
		ENDIF

		*-- (3) tipo 13 depende de troca de preco recente
		SELECT (par_cAlias)
		IF THIS.this_nQtdPrecoAlt = 0
			DELETE FOR INLIST(Tpdesc, 13)
		ELSE
			REPLACE ALL Descosmax WITH THIS.this_nDescPrecoAlt ;
				FOR Tpdesc = 13
		ENDIF

		*-- (4) tipo 3 (relogio) depende do grupo configurado
		loc_nTipoRe  = THIS.ContarTipoConfig(1, 3, 0, "")
		loc_nGrupoRe = THIS.ContarTipoConfig(1, 3, 1, loc_cCgrus)

		SELECT (par_cAlias)
		IF loc_nTipoRe <> 0 AND loc_nGrupoRe = 0
			DELETE FOR INLIST(Tpdesc, 3)
		ENDIF

		*-- (5) tipo 1 (aniversario) depende do mes de nascimento
		SELECT (par_cAlias)
		IF THIS.this_nQtdAniv = 0
			DELETE FOR INLIST(Tpdesc, 1)
		ENDIF

		*-- (6) produto em promocao: so supervisor (8) e diretoria (9)
		SELECT (par_cAlias)
		IF THIS.this_nQtdPromoImp > 0
			DELETE FOR !INLIST(Tpdesc, 8, 9)
		ENDIF

		*-- (7) produto de/por: so financeiro (2), supervisor (8), diretoria (9)
		SELECT (par_cAlias)
		IF NVL(THIS.this_nPrecode, 0) <> 0
			DELETE FOR !INLIST(Tpdesc, 2, 8, 9)
		ENDIF

		*-- (8) tipo 2 (jolie) com grupo configurado que nao e' o do produto
		loc_nTipoJ  = THIS.ContarTipoConfig(1, 2, 0, "")
		loc_nGrupoJ = THIS.ContarTipoConfig(1, 2, 1, loc_cCgrus)

		IF loc_nTipoJ <> 0 AND loc_nGrupoJ = 0 AND THIS.this_nQtdItdJolie = 0
			loc_cCodTipoJ = THIS.ObterCodigoTipoConfig(1, 2)
			SELECT (par_cAlias)
			DELETE FOR Tpdesc = 2 AND ALLTRIM(Codigos) == loc_cCodTipoJ
		ENDIF

		SELECT (par_cAlias)
	ENDPROC

	*====================================================================
	* MarcarDescontosGravados - pre-seleciona em par_cAlias os tipos de
	* desconto JA gravados em SigMvItd para o item corrente, trazendo o
	* percentual, o valor e o usuario que autorizou.
	*
	* Legado (fim do Init):
	*   SELECT * from crSigmvitd where cpros = lcCpros and citens = pcItem
	*                                                   into cursor crOpItd
	*   SELECT localDes / GO top / SCAN
	*       SELECT crOpItd / LOCATE for cdesc = localDes.codigos
	*       IF FOUND()
	*           replace selecao with 1              in localDes
	*           replace descos  with crOpItd.pdes   in localDes
	*           replace valdes  with crOpItd.vdes   in localDes
	*           replace usuars  with crOpItd.usuars in localDes
	*       ENDIF
	*   ENDSCAN
	*
	* O filtro ganha empdopnums (a chave posicional Emps+Dopes+Numes) em
	* cima de cpros/citens: no legado crSigmvitd JA chega do chamador
	* restrito ao movimento aberto, enquanto aqui a leitura e' direta na
	* tabela e cpros+citens sozinhos casariam o mesmo item de OUTROS
	* movimentos. A chave e' montada com PADR nas partes, NUNCA ALLTRIM -
	* ela e' POSICIONAL (3 + 20 + 6 = 29, a largura de
	* SigMvItd.empdopnums); ALLTRIM nas partes encurta a chave e o SELECT
	* devolve ZERO linhas sem nenhum erro.
	*====================================================================
	PROTECTED PROCEDURE MarcarDescontosGravados(par_cAlias)
		LOCAL loc_cSQL, loc_nResult, loc_cEmpDopNums, loc_cCpros, loc_cCodigo

		loc_cCpros      = ALLTRIM(NVL(THIS.this_cCpros, ""))
		loc_cEmpDopNums = PADR(NVL(THIS.this_cEmps, ""), 3) + ;
						  PADR(NVL(THIS.this_cDopes, ""), 20) + ;
						  STR(NVL(THIS.this_nNumes, 0), 6)

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		loc_cSQL = "SELECT ISNULL(cdesc, '') AS Cdesc,"
		loc_cSQL = loc_cSQL + " ISNULL(pdes, 0) AS Pdes,"
		loc_cSQL = loc_cSQL + " ISNULL(vdes, 0) AS Vdes,"
		loc_cSQL = loc_cSQL + " ISNULL(usuars, '') AS Usuars"
		loc_cSQL = loc_cSQL + " FROM SigMvItd"
		loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNums)
		loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(loc_cCpros)
		loc_cSQL = loc_cSQL + " AND citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0)

		loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItdTmp")

		IF loc_nResult < 0
			MsgErro("Erro ao ler os descontos j" + CHR(225) + " gravados do item:" + ;
					CHR(13) + CapturarErroSQL(), "Erro SQL")
		ELSE
			IF USED("cursor_4c_ItdTmp") AND RECCOUNT("cursor_4c_ItdTmp") > 0
				SELECT (par_cAlias)
				GO TOP
				SCAN
					loc_cCodigo = ALLTRIM(NVL(EVALUATE(par_cAlias + ".Codigos"), ""))

					SELECT cursor_4c_ItdTmp
					GO TOP
					LOCATE FOR ALLTRIM(cursor_4c_ItdTmp.Cdesc) == loc_cCodigo

					IF FOUND()
						SELECT (par_cAlias)
						REPLACE Selecao WITH 1, ;
								Descos  WITH NVL(cursor_4c_ItdTmp.Pdes, 0), ;
								Valdes  WITH NVL(cursor_4c_ItdTmp.Vdes, 0), ;
								Usuars  WITH ALLTRIM(NVL(cursor_4c_ItdTmp.Usuars, ""))
					ENDIF

					SELECT (par_cAlias)
				ENDSCAN
			ENDIF
		ENDIF

		IF USED("cursor_4c_ItdTmp")
			USE IN cursor_4c_ItdTmp
		ENDIF

		SELECT (par_cAlias)
		GO TOP
	ENDPROC

	*====================================================================
	* CarregarDescontos - popula cursor_4c_Dados (localDes do legado) com
	* os tipos de desconto que o item corrente pode receber.
	*
	* Pipeline, espelhando o Init legado:
	*
	*  1) cursor_4c_DesTmp  <- SigOpTdz cruzado com SigCdTbd pela operacao
	*                          do movimento (crDesc do legado), com a
	*                          copia de trabalho das colunas de localDes:
	*                          Selecao = 0, Valdes = 0, Descos = 0 e
	*                          Descosmax = SigOpTdz.descos (o teto que o
	*                          Valid da coluna "% Desconto" cobra). O
	*                          legado monta esse mesmo par com
	*                          "Select 0 as selecao, 000000000.00 as
	*                          valdes, descos as descosmax, * from crDesc"
	*                          seguido de "replace all descos with 0.00".
	*  2) cursor_4c_TipoTmp <- SigOpTdt cruzado com SigOpTdz (crTipo),
	*                          ordenado por cidchaves: a configuracao de
	*                          grupo de cada tipo de desconto.
	*  3) ConsultarContextoElegibilidade -> promocao / aniversario /
	*                          troca de preco / jolie ja gravado
	*  4) FiltrarElegibilidade           -> os DELETE do legado
	*  5) MarcarDescontosGravados        -> pre-selecao a partir de SigMvItd
	*  6) cursor_4c_Dados   <- ZAP + APPEND FROM DBF(copia compactada)
	*
	* Dois cuidados de SQL nas consultas 1 e 2:
	*
	*  - COLLATE DATABASE_DEFAULT em "a.codigos = c.codigos":
	*    SigOpTdz.codigos e' SQL_Latin1_General_CP1_CI_AS e
	*    SigCdTbd.codigos e' Latin1_General_CI_AS. Sem o COLLATE o SQL
	*    Server RECUSA a query inteira com conflito de ordenacao, em
	*    runtime, com o .prg compilando limpo. O join de SigOpTdt com
	*    SigOpTdz nao precisa: as duas colunas estao na mesma collation.
	*  - "a.listaemp IS NULL" no filtro do tipo 11: o legado faz
	*    "DELETE FROM crDesc where tpDesc = 11 and !listaemp like '%emp%'"
	*    e, com listaemp nulo, "!NULL" e' NULL no VFP - a linha NAO e'
	*    apagada. Omitir o IS NULL apagaria linha que o legado mantem.
	*
	* O ZAP/APPEND existe porque SQLEXEC (ou SELECT INTO CURSOR) sobre o
	* alias ligado ao Grid o fecha e recria, zerando o ColumnCount - a
	* grade viraria um retangulo branco sem cabecalho, sem erro nenhum.
	* A lista de colunas do CREATE CURSOR aqui e' a MESMA do placeholder
	* criado em FormSigOpDes.ConfigurarGrade, porque APPEND FROM casa as
	* colunas por NOME.
	*====================================================================
	PROCEDURE CarregarDescontos()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmps, loc_cDopes
		LOCAL loc_cListaEmp, loc_cDeletedAnt

		loc_lSucesso = .F.

		TRY
			loc_cEmps     = ALLTRIM(NVL(THIS.this_cEmps, ""))
			loc_cDopes    = ALLTRIM(NVL(THIS.this_cDopes, ""))
			loc_cListaEmp = EscaparSQL("%" + loc_cEmps + "%")

			*-- (1) crDesc: tipos habilitados na operacao do movimento
			IF USED("cursor_4c_DesSql")
				USE IN cursor_4c_DesSql
			ENDIF

			loc_cSQL = "SELECT 0 AS Selecao,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(9,2)) AS Valdes,"
			loc_cSQL = loc_cSQL + " CAST(0 AS numeric(7,4)) AS Descos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descos, 0) AS Descosmax,"
			loc_cSQL = loc_cSQL + " ISNULL(a.codigos, '') AS Codigos,"
			loc_cSQL = loc_cSQL + " ISNULL(a.descrs, '') AS Descrs,"
			loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc,"
			loc_cSQL = loc_cSQL + " CAST('' AS char(10)) AS Usuars"
			loc_cSQL = loc_cSQL + " FROM SigOpTdz a"
			loc_cSQL = loc_cSQL + " INNER JOIN SigCdTbd c"
			loc_cSQL = loc_cSQL + " ON a.codigos COLLATE DATABASE_DEFAULT = c.codigos"
			loc_cSQL = loc_cSQL + " WHERE c.dopes = " + EscaparSQL(loc_cDopes)
			loc_cSQL = loc_cSQL + " AND a.tpdesc <> 0"
			loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
			loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
								  loc_cListaEmp + ")"
			loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesSql")

			IF loc_nResult < 0
				MsgErro("Erro ao carregar os tipos de desconto da opera" + ;
						CHR(231) + CHR(227) + "o:" + CHR(13) + ;
						CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Copia de trabalho READWRITE: os DELETE/REPLACE de
				*-- elegibilidade nao rodam em cursor de SQL pass-through.
				IF USED("cursor_4c_DesTmp")
					USE IN cursor_4c_DesTmp
				ENDIF
				SELECT * FROM cursor_4c_DesSql INTO CURSOR cursor_4c_DesTmp READWRITE

				IF USED("cursor_4c_DesSql")
					USE IN cursor_4c_DesSql
				ENDIF

				*-- (2) crTipo: configuracao de grupo por tipo de desconto
				IF USED("cursor_4c_TipoTmp")
					USE IN cursor_4c_TipoTmp
				ENDIF

				loc_cSQL = "SELECT ISNULL(b.codigos, '') AS Codigos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.codtips, '') AS Codtips,"
				loc_cSQL = loc_cSQL + " ISNULL(b.tipos, 0) AS Tipos,"
				loc_cSQL = loc_cSQL + " ISNULL(b.cidchaves, '') AS Cidchaves,"
				loc_cSQL = loc_cSQL + " ISNULL(a.tpdesc, 0) AS Tpdesc"
				loc_cSQL = loc_cSQL + " FROM SigOpTdt b"
				loc_cSQL = loc_cSQL + " INNER JOIN SigOpTdz a ON a.codigos = b.codigos"
				loc_cSQL = loc_cSQL + " WHERE a.tpdesc <> 0"
				loc_cSQL = loc_cSQL + " AND (a.tpdesc <> 11 OR a.listaemp IS NULL"
				loc_cSQL = loc_cSQL + " OR CAST(a.listaemp AS varchar(8000)) LIKE " + ;
									  loc_cListaEmp + ")"
				loc_cSQL = loc_cSQL + " ORDER BY b.cidchaves"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TipoTmp")

				IF loc_nResult < 0
					MsgErro("Erro ao carregar a configura" + CHR(231) + CHR(227) + ;
							"o dos tipos de desconto:" + CHR(13) + ;
							CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- (3) contexto e (4) elegibilidade
					THIS.ConsultarContextoElegibilidade()
					THIS.FiltrarElegibilidade("cursor_4c_DesTmp")

					*-- Compacta: APPEND FROM respeita SET DELETED, e o
					*-- estado do ambiente nao e' garantido aqui. O SET e'
					*-- restaurado logo depois, sem macro.
					loc_cDeletedAnt = SET("DELETED")
					SET DELETED ON

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					SELECT * FROM cursor_4c_DesTmp INTO CURSOR cursor_4c_DesApp READWRITE

					IF loc_cDeletedAnt = "OFF"
						SET DELETED OFF
					ELSE
						SET DELETED ON
					ENDIF

					IF USED("cursor_4c_DesTmp")
						USE IN cursor_4c_DesTmp
					ENDIF

					*-- (5) pre-selecao do que ja esta gravado
					THIS.MarcarDescontosGravados("cursor_4c_DesApp")

					*-- (6) recarga do alias do Grid preservando a estrutura
					IF !USED("cursor_4c_Dados")
						SET NULL ON
						CREATE CURSOR cursor_4c_Dados ;
							(Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
							 Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
							 Descosmax N(7,4), Usuars C(10))
						SET NULL OFF
					ENDIF

					SELECT cursor_4c_Dados
					ZAP

					IF USED("cursor_4c_DesApp") AND RECCOUNT("cursor_4c_DesApp") > 0
						SELECT cursor_4c_Dados
						APPEND FROM DBF("cursor_4c_DesApp")
					ENDIF

					IF USED("cursor_4c_DesApp")
						USE IN cursor_4c_DesApp
					ENDIF
					IF USED("cursor_4c_TipoTmp")
						USE IN cursor_4c_TipoTmp
					ENDIF

					SELECT cursor_4c_Dados
					GO TOP

					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
					"Procedure: " + loException.Procedure, ;
					"Erro em SigOpDesBO.CarregarDescontos")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
