*====================================================================
* sigoporcBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPORC" (grade de Itens de
* um Orcamento). O legado abre este form como filho do form de
* cabecalho do movimento (Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes, isto e, o filho passa a compartilhar a MESMA
* data session do pai, com os cursores crSigMvOrc/crSigMvOrp/TprMvCab/
* crSigCdOpe/LocalEmp ja abertos por ele).
*
* Tabelas envolvidas: SigMvOrc (itens do orcamento), SigMvOrp
* (parcelas/previsoes de pagamento do item), SigMvCab (cabecalho do
* movimento - espelhado no cursor temporario TprMvCab do pai), SigCdOpe
* (configuracao da operacao), SigCdEmp (configuracao da empresa).
*
* Referencias legado -> BO:
*   TprMvCab.Emps/Dopes/Numes/MascNum -> this_cEmps/this_cDopes/
*                                        this_nNumes/this_cMascNum
*   crSigCdOpe.DigItens/CadProds/Opers/Origems/Destinos/OpePads ->
*                                        this_nDigItens/this_nCadProds/
*                                        this_nOpers/this_nOrigems/
*                                        this_nDestinos/this_cOpePads
*   LocalEmp.DivNotas (CursorQuery de SigCdEmp) -> this_nDivNotas
*   TprMvCab.ContaOs/ContaDs -> this_cContaOs/this_cContaDs
*   TprMvCab.Acres/PTax1s/PTax2s/PTax3s/Descs -> this_nAcres/this_nPTax1s/
*                                          this_nPTax2s/this_nPTax3s/this_nDescs
*   SigOpCdd.ConfigGers -> this_cConfigGers
*   Thisform.Caption -> this_cCaption
*   crSigMvOrc (grade de itens) -> this_cCursorItens ("cursor_4c_Itens")
*   crSigMvOrp (grade de parcelas) -> this_cCursorParcelas
*                                     ("cursor_4c_Parcelas")
*
* Thisform.ParentForm, Thisform.poObjExt1 (referencia ao form externo de
* pesquisa de produtos SigOpCgp) e o controle de DataSession permanecem
* no FORM (sao referencias/estado de UI, fora da responsabilidade do
* Business Object).
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigCdOpe/SigCdEmp
* (DigItens/CadProds/Opers/Origems/Destinos/OpePads/DivNotas) e as
* colunas de TprMvCab (ContaOs/ContaDs/Acres/PTax1s/PTax2s/PTax3s) serao
* carregadas por metodo proprio em fase posterior - os valores abaixo
* ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para o ITEM de SigMvOrc (chave cidchaves), com RegistrarAuditoria()
* (herdado de BusinessBase) chamado em Inserir/Atualizar. cidchaves e
* pkchaves sao as duas chaves Fortyus (fUniqueIds(), regra #22) geradas
* no Inserir quando ainda vazias. Buscar() nao e sobrescrito aqui: a
* listagem de itens (SELECT com joins de produto/unidade) fica na fase do
* BO que monta o cursor da grade (CarregarItens), porque a consulta tem
* joins e nao cabe no Buscar() generico herdado de BusinessBase.
*
* Fase 7/8 - CarregarConfiguracao() (SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab,
* equivalentes aos cursores que o FORM PAI legado ja tinha abertos -
* regra #35/cabecalho acima), CarregarItens()/CarregarParcelas() (leitura
* de SigMvOrc/SigMvOrp para as duas grades - o legado faz isso via
* AddCursor no Init; aqui e feito por SQLEXEC em cursor temporario +
* ZAP/APPEND no cursor ja ligado ao Grid, regra "SQLEXEC sobre alias de
* grid zera o ColumnCount").
*
* Modo Criacao do legado (SigCdOpe.DigItens IN (6,7), com sub-blocos
* lidos de SigOpCdI.JOB_MV_BLO em btnInsBlo/btnInsSub) NAO E PORTADO: a
* tabela SigOpCdI NAO EXISTE no schema canonico (conferido em
* docs\schema.sql, regra #14 - zero ocorrencias, nao e falso-negativo de
* encoding). This_nDigItens continua sendo lido e comparado (para nao
* quebrar os outros ramos que dependem dele, como DigItens=5->CONSULTAR),
* mas o ramo exclusivo de DigItens IN (6,7) que insere sub-itens de
* JOB_MV_BLO fica de fora em btnInsBlo/btnInsSub, com o motivo documentado
* la (nao e omissao silenciosa - rule "SEMPRE FUNCIONALIDADE COMPLETA",
* mas a fonte de dados do legado para essa sub-feature nao existe mais).
*====================================================================

DEFINE CLASS sigoporcBO AS BusinessBase

	*-- Parametros recebidos do form pai na abertura do dialogo (legado:
	*-- Lparameters poForm, pnDatSes). O form migrado repassa so os
	*-- valores escalares que identificam o cabecalho do movimento
	*-- (TprMvCab/SigMvCab); poForm (referencia de UI) e a troca de
	*-- DataSession ficam no Form.
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes)
	this_cMascNum = ""              && Mascara/numero formatado do documento (TprMvCab.MascNum) - usado no Caption "Itens"

	*-- Configuracao da operacao (SigCdOpe), referente ao Dopes acima.
	*-- Controla ramos de negocio usados pelos botoes/grades desta tela.
	*-- Populados em fase posterior (leitura via SQLEXEC); default abaixo.
	this_nDigItens = 0              && SigCdOpe.DigItens - 5 forca modo CONSULTAR independente do pai (Op_Escolha)
	this_nCadProds = 0              && SigCdOpe.CadProds - habilita o botao "Cadastro de Produtos" (btnCadPro)
	this_nOpers = 0                 && SigCdOpe.Opers - 1=Entrada/2=Saida, usado para resolver o fornecedor padrao
	this_nOrigems = 0               && SigCdOpe.Origems - .T. quando a conta de origem (TprMvCab.ContaOs) e obrigatoria
	this_nDestinos = 0              && SigCdOpe.Destinos - .T. quando a conta de destino (TprMvCab.ContaDs) e obrigatoria
	this_cOpePads = ""              && SigCdOpe.OpePads - padrao de operacao usado no cadastro de produtos
	this_nImagems = 0               && SigCdOpe.Imagems - habilita a pre-visualizacao da foto do produto no AfterRowColChange (grdItem.imgProds)
	this_nConfes = 0                && SigCdOpe.Confes - quando = 1, suprime a pre-visualizacao mesmo com Imagems = 1
	this_nPrecoAuts = 0             && SigCdOpe.PrecoAuts - autoriza a precificacao automatica em btnCadPro.Click
	this_nPrecoPs = 0               && SigCdOpe.PrecoPs - origem do preco automatico (1/10=venda ou ideal, 2=custo, 5=valors, 7=ultima compra, 8/9=custo medio, 11=custo total)
	this_nPrecops = 0               && SigCdOpe.Precops - moeda/fator de venda(1) ou custo(2) a copiar do cadastro de produto
	this_cCMoes = ""                && SigCdOpe.CMoes - moeda padrao da operacao (fallback quando nao ha precificacao automatica)

	*-- Configuracao da empresa (SigCdEmp), lida via Cemps = this_cEmps
	*-- (legado: CursorQuery([SigCdEmp],[LocalEmp],[Cemps],TprMvCab.Emps,[DivNotas])).
	*-- Populada em fase posterior; default abaixo.
	this_nDivNotas = 0              && SigCdEmp.DivNotas - 1=Preco&Gerencial(P&G) / 2=SRCOM - decide a formula de rateio dos percentuais do item

	*-- Contas de origem/destino do cabecalho (TprMvCab/SigMvCab), usadas
	*-- em btnCadPro.Click para resolver o fornecedor do produto novo.
	*-- Populadas em fase posterior; default abaixo.
	this_cContaOs = ""              && Conta de Origem (TprMvCab.ContaOs)
	this_cContaDs = ""              && Conta de Destino (TprMvCab.ContaDs)

	*-- Percentuais/indices do cabecalho (TprMvCab/SigMvCab), usados como
	*-- semente dos campos de percentual do item recem-incluido.
	*-- Populados em fase posterior; default abaixo.
	this_nAcres = 0                 && TprMvCab.Acres - imposto cheio (usado quando o item NAO e servico)
	this_nPTax1s = 0                && TprMvCab.PTax1s - percentual default de BV (Perc3s)
	this_nPTax2s = 0                && TprMvCab.PTax2s - percentual default de despesa operacional/contingente (Perc1s)
	this_nPTax3s = 0                && TprMvCab.PTax3s - percentual default de imposto de servico (Perc4s quando Servicos)
	this_nDescs = 0                 && TprMvCab.Descs - percentual default de lucro/"Taxa Adm." (Perc2s)

	*-- Mascara de configuracoes gerais da operacao (SigOpCdd.ConfigGers),
	*-- lida via Dopes = this_cDopes. Posicao 192 (1 char) = flag de
	*-- Decupagem (Int(Val(Substr(ConfigGers,192,1))) = 1), usada em
	*-- TotalizarItn(). Populada em fase posterior; default "" faz a
	*-- checagem de Decupagem avaliar sempre .F. (SUBSTR/VAL de string
	*-- vazia devolve 0), que e o comportamento seguro ate a config
	*-- chegar.
	this_cConfigGers = ""
	this_nChkIfors = 0              && SigOpCdd.ChkIfors - 1/2 habilita a resolucao de preco por SigPrFnc (tabela de fornecedor) antes do padrao de SigCdMoe

	*-- Titulo montado para a tela (legado: Thisform.Caption)
	this_cCaption = ""              && "<Emps> <Dopes> <MascNum> - Itens"

	*-- Nomes dos cursores que este BO popula/consome (constantes, para o
	*-- Form referenciar sem repetir literais - equivalentes aos aliases
	*-- globais do legado crSigMvOrc/crSigMvOrp)
	this_cCursorItens = "cursor_4c_Itens"        && Grade de itens do orcamento (SigMvOrc)
	this_cCursorParcelas = "cursor_4c_Parcelas"  && Grade de parcelas/previsoes do item selecionado (SigMvOrp)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela SigMvOrc -
	*-- um ITEM da grade de orcamento, chave cidchaves). this_cEmps/
	*-- this_cDopes/this_nNumes acima (recebidos no Init) JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cCblocos    = ""   && cblocos char(30) - marcador de linha (SUBTOTAL/BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL ou vazio = item normal)
	this_nCitem2     = 0    && citem2 numeric(10,0) - item do bloco (subtotal pai)
	this_nCitens     = 0    && citens numeric(10,0) - numero do item (PK logica dentro do orcamento)
	this_cCpros      = ""   && cpros char(14) - codigo do produto
	this_cCunips     = ""   && cunips char(3) - unidade de compra/pedido
	this_cCunis      = ""   && cunis char(3) - unidade de venda
	this_cDpro2s     = ""   && dpro2s text NULL - descricao complementar do produto
	this_cDpros      = ""   && dpros char(65) - descricao do produto/bloco
	this_cEmpdopnums = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga o item ao cabecalho
	this_nFators     = 0    && fators numeric(8,4) - fator de conversao de unidade
	this_nPesos      = 0    && pesos numeric(8,4) - peso unitario
	this_cPkchaves   = ""   && pkchaves char(20) - chave unica Fortyus (fUniqueIds(), independente de cidchaves)
	this_nQtds       = 0    && qtds numeric(8,4) - quantidade
	this_nTotas      = 0    && totas numeric(13,2) - total do item
	this_nUnits      = 0    && units numeric(13,2) - valor unitario
	this_cCidchaves  = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_cMoedas     = ""   && moedas char(3) - moeda do total de custo
	this_cMoefats    = ""   && moefats char(3) - moeda de faturamento
	this_cMoevs      = ""   && moevs char(3) - moeda de venda
	this_cNotas      = ""   && notas char(9) - numero/mascara da nota associada
	this_cObs        = ""   && obs text NULL - observacao do item
	this_cOpers      = ""   && opers char(1) - tipo de operacao do item (distinto de this_nOpers, que e config de SigCdOpe)
	this_nTota1s     = 0    && tota1s numeric(13,2) - despesa operacional (Perc1s)
	this_nTota2s     = 0    && tota2s numeric(13,2) - lucro (Perc2s)
	this_nTota3s     = 0    && tota3s numeric(13,2) - BV (Perc3s)
	this_nTota4s     = 0    && tota4s numeric(13,2) - imposto/servico (Perc4s)
	this_nTota5s     = 0    && tota5s numeric(13,2) - incentivo 1 (Perc5s)
	this_nTota6s     = 0    && tota6s numeric(13,2) - incentivo 2 (Perc6s)
	this_nTota7s     = 0    && tota7s numeric(13,2) - custo interno SRCOM
	this_nTota8s     = 0    && tota8s numeric(13,2) - valor fornecedor
	this_nTota9s     = 0    && tota9s numeric(13,2) - saldo real custo interno SRCOM
	this_nTota10s    = 0    && tota10s numeric(13,2) - saldo real fornecedor
	this_nTpesos     = 0    && tpesos numeric(8,4) - peso total
	this_nUnivals    = 0    && univals numeric(13,2) - valor unitario de venda
	this_nUtilizas   = 0    && utilizas numeric(2,0) - controle de utilizacao (fluxo de preco autorizado)
	this_lServicos   = .F.  && servicos bit - item e servico (troca a regra de calculo do imposto)
	this_nCitagrs    = 0    && citagrs numeric(10,0) - item do agrupador (decupagem)
	this_nCitem3     = 0    && citem3 numeric(10,0) - item do sub-bloco (subtotal de 2o nivel)
	this_cCodacabs   = ""   && codacabs char(3) - codigo de acabamento (SigCdAca)
	this_lDebitos    = .F.  && debitos bit - item gerado a debito (bloqueia imposto cheio)
	this_lTaxas      = .F.  && taxas bit - item e taxa (fee)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters poForm, pnDatSes do Init do
	* form legado - o form migrado repassa so os valores escalares que
	* identificam o cabecalho do movimento (poForm/pnDatSes, que sao
	* referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cMascNum)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvOrc"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_cMascNum) = "C"
			THIS.this_cMascNum = par_cMascNum
		ENDIF

		*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+Alltrim(MascNum)+' - Itens'
		THIS.this_cCaption = ALLTRIM(THIS.this_cEmps) + " " + ALLTRIM(THIS.this_cDopes) + ;
			" " + ALLTRIM(THIS.this_cMascNum) + " - Itens"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) do item
	* corrente, para uso em RegistrarAuditoria()
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de um item de SigMvOrc
	* (cursor_4c_Itens/crSigMvOrc) para as propriedades do BO. SEMPRE usar
	* SELECT (par_cAliasCursor) antes de acessar os campos (regra #8).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCblocos = TratarNulo(cblocos, "C")
				THIS.this_nCitem2 = TratarNulo(citem2, "N")
				THIS.this_nCitens = TratarNulo(citens, "N")
				THIS.this_cCpros = TratarNulo(cpros, "C")
				THIS.this_cCunips = TratarNulo(cunips, "C")
				THIS.this_cCunis = TratarNulo(cunis, "C")
				THIS.this_cDopes = TratarNulo(dopes, "C")
				THIS.this_cDpro2s = TratarNulo(dpro2s, "C")
				THIS.this_cDpros = TratarNulo(dpros, "C")
				THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
				THIS.this_cEmps = TratarNulo(emps, "C")
				THIS.this_nFators = TratarNulo(fators, "N")
				THIS.this_nNumes = TratarNulo(numes, "N")
				THIS.this_nPesos = TratarNulo(pesos, "N")
				THIS.this_cPkchaves = TratarNulo(pkchaves, "C")
				THIS.this_nQtds = TratarNulo(qtds, "N")
				THIS.this_nTotas = TratarNulo(totas, "N")
				THIS.this_nUnits = TratarNulo(units, "N")
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cMoedas = TratarNulo(moedas, "C")
				THIS.this_cMoefats = TratarNulo(moefats, "C")
				THIS.this_cMoevs = TratarNulo(moevs, "C")
				THIS.this_cNotas = TratarNulo(notas, "C")
				THIS.this_cObs = TratarNulo(obs, "C")
				THIS.this_cOpers = TratarNulo(opers, "C")
				THIS.this_nTota1s = TratarNulo(tota1s, "N")
				THIS.this_nTota2s = TratarNulo(tota2s, "N")
				THIS.this_nTota3s = TratarNulo(tota3s, "N")
				THIS.this_nTota4s = TratarNulo(tota4s, "N")
				THIS.this_nTota5s = TratarNulo(tota5s, "N")
				THIS.this_nTota6s = TratarNulo(tota6s, "N")
				THIS.this_nTota7s = TratarNulo(tota7s, "N")
				THIS.this_nTota8s = TratarNulo(tota8s, "N")
				THIS.this_nTota9s = TratarNulo(tota9s, "N")
				THIS.this_nTota10s = TratarNulo(tota10s, "N")
				THIS.this_nTpesos = TratarNulo(tpesos, "N")
				THIS.this_nUnivals = TratarNulo(univals, "N")
				THIS.this_nUtilizas = TratarNulo(utilizas, "N")
				IF VARTYPE(servicos) = "L"
					THIS.this_lServicos = servicos
				ELSE
					THIS.this_lServicos = (NVL(servicos, 0) = 1)
				ENDIF
				THIS.this_nCitagrs = TratarNulo(citagrs, "N")
				THIS.this_nCitem3 = TratarNulo(citem3, "N")
				THIS.this_cCodacabs = TratarNulo(codacabs, "C")
				IF VARTYPE(debitos) = "L"
					THIS.this_lDebitos = debitos
				ELSE
					THIS.this_lDebitos = (NVL(debitos, 0) = 1)
				ENDIF
				IF VARTYPE(taxas) = "L"
					THIS.this_lTaxas = taxas
				ELSE
					THIS.this_lTaxas = (NVL(taxas, 0) = 1)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo item (linha) em SigMvOrc
	* PK (cidchaves) e pkchaves gerados via fUniqueIds() se ainda vazios
	* (regra #22 - PK Fortyus NUNCA pode ser string vazia)
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cPkchaves, "")))
				THIS.this_cPkchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo computado: Emps + Dopes + Numes (chave posicional que liga
			*-- o item ao cabecalho - regra #42, NUNCA ALLTRIM nas partes)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "INSERT INTO SigMvOrc ("
			loc_cSQL = loc_cSQL + "cblocos, citem2, citens, cpros, cunips, cunis, dopes, dpro2s,"
			loc_cSQL = loc_cSQL + "dpros, empdopnums, emps, fators, numes, pesos, pkchaves, qtds,"
			loc_cSQL = loc_cSQL + "totas, units, cidchaves, moedas, moefats, moevs, notas, obs,"
			loc_cSQL = loc_cSQL + "opers, tota10s, tota1s, tota2s, tota3s, tota4s, tota5s, tota6s,"
			loc_cSQL = loc_cSQL + "tota7s, tota8s, tota9s, tpesos, univals, utilizas, servicos, citagrs,"
			loc_cSQL = loc_cSQL + "citem3, codacabs, debitos, taxas"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lTaxas, "1", "0") + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza item existente em SigMvOrc (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo computado: Emps + Dopes + Numes (chave posicional - regra #42)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "UPDATE SigMvOrc SET"
			loc_cSQL = loc_cSQL + " cblocos = " + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dpro2s = " + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + " pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + " tota10s = " + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + " tota1s = " + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + " tota2s = " + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + " tota3s = " + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + " tota4s = " + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + " tota5s = " + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + " tota6s = " + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + " tota7s = " + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + " tota8s = " + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + " tota9s = " + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + " servicos = " + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " citagrs = " + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + " citem3 = " + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + " codacabs = " + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + " debitos = " + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " taxas = " + IIF(THIS.this_lTaxas, "1", "0")
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - Le SigCdOpe (por Dopes), SigCdEmp (por Cemps -
	* regra SigCdEmp usa Cemps, NUNCA Cemps), SigOpCdd (por Dopes) e os
	* percentuais/contas do cabecalho em SigMvCab (por Emps+Dopes+Numes).
	* Equivalente ao bloco de cursores que o FORM PAI legado ja mantinha
	* abertos (crSigCdOpe/LocalEmp/crSigOpCdd/TprMvCab) - aqui cada valor e
	* lido direto do SQL Server, uma unica vez, na abertura do dialogo.
	*
	* Chamada em Formsigoporc.InicializarForm, logo apos CREATEOBJECT do
	* BO e ANTES de qualquer Configurar*() que dependa de this_cOpEscolha
	* (o Form recalcula this_cOpEscolha com this_nDigItens depois desta
	* chamada - regra do legado: DigItens=5 forca CONSULTAR).
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_lSucesso
		loc_lSucesso = .T.

		TRY
			*-- SigCdOpe (configuracao da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF
			loc_cSQL = "SELECT DigItens, CadProds, Opers, Origems, Destinos, OpePads,"
			loc_cSQL = loc_cSQL + " Imagems, Confes, PrecoAuts, PrecoPs, Precops, CMoes"
			loc_cSQL = loc_cSQL + " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") > 0 AND USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
				SELECT cursor_4c_CfgOpe
				THIS.this_nDigItens  = TratarNulo(DigItens, "N")
				THIS.this_nCadProds  = TratarNulo(CadProds, "N")
				THIS.this_nOpers     = TratarNulo(Opers, "N")
				THIS.this_nOrigems   = TratarNulo(Origems, "N")
				THIS.this_nDestinos  = TratarNulo(Destinos, "N")
				THIS.this_cOpePads   = TratarNulo(OpePads, "C")
				THIS.this_nImagems   = TratarNulo(Imagems, "N")
				THIS.this_nConfes    = TratarNulo(Confes, "N")
				THIS.this_nPrecoAuts = TratarNulo(PrecoAuts, "N")
				THIS.this_nPrecoPs   = TratarNulo(PrecoPs, "N")
				THIS.this_nPrecops   = TratarNulo(Precops, "N")
				THIS.this_cCMoes     = TratarNulo(CMoes, "C")
			ENDIF
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF

			*-- SigCdEmp (configuracao da empresa, chave Cemps)
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF
			loc_cSQL = "SELECT DivNotas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgEmp") > 0 AND USED("cursor_4c_CfgEmp") AND RECCOUNT("cursor_4c_CfgEmp") > 0
				THIS.this_nDivNotas = TratarNulo(cursor_4c_CfgEmp.DivNotas, "N")
			ENDIF
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF

			*-- SigOpCdd (configuracao-detalhe da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF
			loc_cSQL = "SELECT ConfigGers, ChkIfors FROM SigOpCdd WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpd") > 0 AND USED("cursor_4c_CfgOpd") AND RECCOUNT("cursor_4c_CfgOpd") > 0
				THIS.this_cConfigGers = TratarNulo(cursor_4c_CfgOpd.ConfigGers, "C")
				THIS.this_nChkIfors   = TratarNulo(cursor_4c_CfgOpd.ChkIfors, "N")
			ENDIF
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF

			*-- SigMvCab (cabecalho do movimento, chave Emps+Dopes+Numes) -
			*-- percentuais default (semente do item novo) e contas de
			*-- origem/destino (usadas por btnCadPro.Click)
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
			loc_cSQL = "SELECT Acres, PTax1s, PTax2s, PTax3s, Descs, ContaOs, ContaDs"
			loc_cSQL = loc_cSQL + " FROM SigMvCab WHERE Emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND Dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgCab") > 0 AND USED("cursor_4c_CfgCab") AND RECCOUNT("cursor_4c_CfgCab") > 0
				SELECT cursor_4c_CfgCab
				THIS.this_nAcres   = TratarNulo(Acres, "N")
				THIS.this_nPTax1s  = TratarNulo(PTax1s, "N")
				THIS.this_nPTax2s  = TratarNulo(PTax2s, "N")
				THIS.this_nPTax3s  = TratarNulo(PTax3s, "N")
				THIS.this_nDescs   = TratarNulo(Descs, "N")
				THIS.this_cContaOs = TratarNulo(ContaOs, "C")
				THIS.this_cContaDs = TratarNulo(ContaDs, "C")
			ENDIF
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarConfiguracao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Popula cursor_4c_Itens (grade de itens) a partir de
	* SigMvOrc, filtrado por Emps/Dopes/Numes e ordenado por Citens -
	* equivalente ao AddCursor('SigMvOrc','citens','CrSigMvOrc',...) do
	* Init legado. SQLEXEC vai para um cursor TEMPORARIO; cursor_4c_Itens
	* (ja ligado ao Grid, com colunas de lookup instaladas via AddObject)
	* e recarregado com ZAP + APPEND FROM DBF() - NUNCA SQLEXEC direto nele
	* (regra: SQLEXEC sobre alias de grid zera o ColumnCount).
	*====================================================================
	PROCEDURE CarregarItens()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF

			loc_cSQL = "SELECT o.cblocos, o.citem2, o.citens, o.cpros, o.cunips, o.cunis, o.dopes,"
			loc_cSQL = loc_cSQL + " o.dpro2s, o.dpros, o.empdopnums, o.emps, o.fators, o.numes, o.pesos,"
			loc_cSQL = loc_cSQL + " o.pkchaves, o.qtds, o.totas, o.units, o.cidchaves, o.moedas, o.moefats,"
			loc_cSQL = loc_cSQL + " o.moevs, o.notas, o.obs, o.opers, o.tota10s, o.tota1s, o.tota2s, o.tota3s,"
			loc_cSQL = loc_cSQL + " o.tota4s, o.tota5s, o.tota6s, o.tota7s, o.tota8s, o.tota9s, o.tpesos,"
			loc_cSQL = loc_cSQL + " o.univals, o.utilizas, o.servicos, o.citagrs, o.citem3, o.codacabs,"
			loc_cSQL = loc_cSQL + " o.debitos, o.taxas,"
			*-- Descricoes de lookup exibidas nas Columns 4/6/30 da grade de itens
			*-- (legado: crSigMvOrc.DcUnis/DcUnips/DAcabs - colunas PROJETADAS pela
			*-- query do form PAI, nao colunas de SigMvOrc). Sem estes tres joins a
			*-- grade abriria com Unidade/Unidade(pedido)/Acabamento em BRANCO,
			*-- mesmo com cunis/cunips/codacabs gravados.
			loc_cSQL = loc_cSQL + " NVL(uv.dunis, '')  AS dcunis,"
			loc_cSQL = loc_cSQL + " NVL(up.dunis, '')  AS dcunips,"
			loc_cSQL = loc_cSQL + " NVL(ac.descrs, '') AS dacabs"
			loc_cSQL = loc_cSQL + " FROM SigMvOrc o"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni uv ON RTRIM(uv.cunis) = RTRIM(o.cunis)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni up ON RTRIM(up.cunis) = RTRIM(o.cunips)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdAca ac ON RTRIM(ac.cods)  = RTRIM(o.codacabs)"
			loc_cSQL = loc_cSQL + " WHERE o.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND o.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND o.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY o.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar itens do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorItens)
					SELECT (THIS.this_cCursorItens)
					ZAP
					IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
						APPEND FROM DBF("cursor_4c_ItensTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParcelas - Popula cursor_4c_Parcelas (grade de parcelas) a
	* partir de SigMvOrp, filtrado por Emps/Dopes/Numes e ordenado por
	* Citens - equivalente ao AddCursor('SigMvOrp','citens','CrSigMvOrp',
	* ...) do Init legado. dfors (descricao do fornecedor, Column6 de
	* grd_4c_Parcelas, SEMPRE ReadOnly) e projetado via LEFT JOIN em
	* SigCdCli.Iclis/Rclis - mesma tabela de conta usada pelo lookup
	* fAcessoContas do legado (ver cabecalho de ConfigurarGradeParcelas).
	* Mesmo padrao grid-safe de CarregarItens (cursor temporario + ZAP +
	* APPEND FROM DBF no cursor ja ligado ao Grid).
	*====================================================================
	PROCEDURE CarregarParcelas()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF

			loc_cSQL = "SELECT p.cidchaves, p.citens, p.datas, p.dopes, p.empdopnums,"
			loc_cSQL = loc_cSQL + " p.emps, p.numes, p.percs, p.valos, p.vlbaixas,"
			loc_cSQL = loc_cSQL + " p.borderos, p.ifors, p.valcreds,"
			loc_cSQL = loc_cSQL + " NVL(f.rclis, '') AS dfors"
			loc_cSQL = loc_cSQL + " FROM SigMvOrp p LEFT JOIN SigCdCli f ON f.iclis = p.ifors"
			loc_cSQL = loc_cSQL + " WHERE p.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND p.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND p.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY p.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParcelasTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar parcelas do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorParcelas)
					SELECT (THIS.this_cCursorParcelas)
					ZAP
					IF USED("cursor_4c_ParcelasTmp") AND RECCOUNT("cursor_4c_ParcelasTmp") > 0
						APPEND FROM DBF("cursor_4c_ParcelasTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarParcelas")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
