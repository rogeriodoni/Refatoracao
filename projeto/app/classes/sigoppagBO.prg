*====================================================================
* sigoppagBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPPAG" ("Recebimento" -
* condicoes de pagamento/recebimento de um movimento). O legado abre
* este form como FILHO do form de cabecalho do movimento (Lparameters
* pForm, datses, plAltDireta, plAutomatico - Set Datasession To datses,
* isto e, o filho passa a compartilhar a MESMA data session do pai, com
* os cursores xPar/TprMvCab/crSigCdOpe/crSigMvNfi/crSigCdCfo/crSigCdPam
* ja abertos por ele).
*
* Tabelas envolvidas: SigMvPar (condicoes de pagamento/parcelas do
* movimento - cursor legado xPar, chave cidchaves), SigMvCab (cabecalho
* do movimento - espelhado no cursor temporario TprMvCab do pai),
* SigCdOpe (configuracao da operacao), SigOpFp (catalogo de formas de
* pagamento), SigCdMoe (moedas), SigCdCrt (bandeiras de cartao),
* SigCdCad (adquirentes/modalidades - tipocads = 'ADQUIRENTE'),
* SigCdMod (modalidades de pagamento), SigCqChm/SigChe (protocolo e
* cheque), SigCdCtt (protocolo de cartao de credito).
*
* Referencias legado -> BO (linha do xPar sendo incluida/alterada,
* mapeamento 1-para-1 para SigMvPar):
*   xPar.Agencias/Bancos/Cartaos/Contas/CotFPgs/Dopes/EmpOs/FPags/
*   InsChs/MoeFPgs/NCarnes/NCarts/NoCreditos/Nsu/NumChqs/Numeros/Numes/
*   NumOlds/Obs/Outros/Trocos/ValDescs/Valos/Vencs/adquirente/autoriza/
*   cnIdTefs/nIdCheps/Parcs/TParcs/VPags ->
*       this_cAgencias/this_cBancos/this_cCartaos/this_cContas/
*       this_nCotfpgs/this_cDopes/this_cEmpos/this_cFpags/this_lInschs/
*       this_cMoefpgs/this_cNcarnes/this_nNcarts/this_cNocreditos/
*       this_cNsu/this_cNumchqs/this_cNumeros/this_nNumes/
*       this_nNumolds/this_cObs/this_cOutros/this_nTrocos/
*       this_nValdescs/this_nValos/this_dVencs/this_cAdquirente/
*       this_cAutoriza/this_cCnidtefs/this_nNidcheps/this_nParcs/
*       this_nTparcs/this_nVpags
*   (demais colunas de SigMvPar sem uso direto no codigo analisado -
*   declaradas do mesmo jeito, para paridade de schema/INSERT futuro:
*   this_nEcNumes/this_cGrclis/this_cIclis/this_cImpcars/this_cLocals/
*   this_nNcopias/this_nNopers/this_nNrecs/this_nNtrans/this_cCotusus/
*   this_cCnnsuparcs/this_nNumlotechs/this_cCidchaves/this_nValocurs/
*   this_cEmpdopnums/this_cPagos/this_dDtalts/this_cCpfs/
*   this_cDigagencs/this_cDigchqs/this_cDigcontas/this_cPracas/
*   this_cCodbcrts/this_lLcancelas/this_nVcofins/this_nVcsll/this_nVirf/
*   this_nVlrtrbfs/this_nVpis/this_cChaveexterna/this_dDatas/
*   this_dDatatrans/this_cDcarts/this_dDpags/this_dDtdeps/this_cEmps)
*
* Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+Numes
* (this_cEmps/this_cDopes/this_nNumes abaixo). Sufixo "Cab" evita colisao
* com propriedades de mesmo nome da linha de SigMvPar (ex.: this_nValos
* e o valor da PARCELA; this_nValosCab e o total do movimento):
*   TprMvCab.ContaOs/ContaDs/Datas/Notas/PrazoEnts/TabDs/TpFats/ValDevs/
*   ValEncs/ValInis/ValServs/ValTrans/ValUtiCsh/ValVarPs/ValVars/Valos/
*   VarTots/Vars -> this_cContaOsCab/this_cContaDsCab/this_dDatasCab/
*   this_cNotasCab/this_dPrazoEntsCab/this_cTabDsCab/this_cTpFatsCab/
*   this_nValDevsCab/this_nValEncsCab/this_nValInisCab/this_nValServsCab/
*   this_nValTransCab/this_nValUtiCshCab/this_nValVarPsCab/
*   this_nValVarsCab/this_nValosCab/this_nVarTotsCab/this_nVarsCab
*   (TabDs/TpFats corrigidos para CHAR na Fase 7/8 - docs\schema.sql mostra
*   SigMvCab.tabds char(10) e tpfats char(3); a Fase 1 os declarara como
*   numeric por engano e nenhum outro arquivo do projeto os referenciava
*   ainda, regra #19 - MaxLength/tipo vem do schema, nunca de palpite)
*
* Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
* Sufixo "Ope" pelo mesmo motivo (SigCdOpe.Vars/parcs tambem colidiriam
* com propriedades de SigMvPar/outro config):
*   SigCdOpe.BlqDatas/CMoes/COpers/Caixas/Confes/Deacrs/DtEntrs/EdComis/
*   FPagOpCrs/HabServs/LPrecos/Opers/ParRecals/parcs/PesoVts/PrecoAuts/
*   PrecoVts/ValPres/Vars/aptpfats/cheqs/cupfis ->
*       this_nBlqDatasOpe/this_cCMoesOpe/this_nCopersOpe/this_nCaixasOpe/
*       this_nConfesOpe/this_nDeacrsOpe/this_nDtEntrsOpe/this_nEdComisOpe/
*       this_cFPagOpCrsOpe/this_nHabServsOpe/this_nLPrecosOpe/
*       this_nOpersOpe/this_nParRecalsOpe/this_nParcsOpe/this_nPesoVtsOpe/
*       this_nPrecoAutsOpe/this_nPrecoVtsOpe/this_nValPresOpe/
*       this_nVarsOpe/this_nAptpfatsOpe/this_nCheqsOpe/this_nCupfisOpe
*
* Flags recebidas do form pai na abertura (legado: plAltDireta,
* plAutomatico) -> this_lAltDireta/this_lAutomatico. poForm (referencia
* de UI) e a troca de DataSession ficam no FORM.
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigMvCab/SigCdOpe (os
* campos *Cab/*Ope acima) sera carregada por metodo proprio em fase
* posterior - os valores abaixo ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para a CONDICAO/PARCELA de SigMvPar (chave cidchaves), com
* RegistrarAuditoria() (herdado de BusinessBase) chamado em
* Inserir/Atualizar. cidchaves e a chave Fortyus (fUniqueIds(), regra
* #22) gerada no Inserir quando ainda vazia; empdopnums e a chave
* posicional Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito,
* nunca ALLTRIM nas partes).
*
* Fase 7/8 - CarregarConfiguracao() (SigMvCab/SigCdOpe, equivalentes aos
* cursores que o FORM PAI legado ja tinha abertos - regra #35/cabecalho
* acima), CarregarCondicoes() (leitura de SigMvPar para a grade - o
* legado faz isso via AddCursor no Init do pai; aqui e feito por SQLEXEC
* em cursor temporario + ZAP/APPEND no cursor ja ligado ao Grid, regra
* "SQLEXEC sobre alias de grid zera o ColumnCount") e ExcluirCondicao()
* (DELETE por cidchaves, chamado pelo Apaga.Click do form quando a linha
* corrente ja foi persistida em SigMvPar).
*====================================================================

DEFINE CLASS sigoppagBO AS BusinessBase

	*-- Flags recebidas do form pai na abertura (legado: Lparameters
	*-- pForm, datses, plAltDireta, plAutomatico). poForm (referencia de
	*-- UI) e a troca de DataSession ficam no Form.
	this_lAltDireta = .F.           && plAltDireta - fluxo de alteracao direta da condicao (pula parte da validacao de limite)
	this_lAutomatico = .F.          && plAutomatico - fluxo automatico (sem interacao do usuario, ex.: TEF/cartao processado por integracao)

	*-- Identificacao do cabecalho do movimento (legado: TprMvCab.Emps/
	*-- Dopes/Numes, compartilhados pela DataSession do pai). O form
	*-- migrado repassa so os valores escalares - mesmos valores que
	*-- aparecem tambem em cada linha de SigMvPar (emps/dopes/numes).
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps / SigMvPar.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes / SigMvPar.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes / SigMvPar.numes)

	*-- Cabecalho do movimento (TprMvCab/SigMvCab), lido via Emps+Dopes+
	*-- Numes acima. Sufixo "Cab" para nao colidir com propriedade de
	*-- mesmo nome da linha de SigMvPar (ex.: valos). Populados em fase
	*-- posterior (leitura via SQLEXEC); default abaixo.
	this_cContaOsCab = ""           && TprMvCab.ContaOs - conta de origem do movimento (credito a estornar/base de calculo)
	this_cContaDsCab = ""           && TprMvCab.ContaDs - conta de destino do movimento (cliente/fornecedor, usado em Chklimite/CursorQuery de SigCdCli)
	this_dDatasCab = {}             && TprMvCab.Datas - data do movimento, base do vencimento default da parcela
	this_cNotasCab = ""             && TprMvCab.Notas - numero/mascara da nota fiscal do movimento (usado na mensagem de confirmacao do Ok.Click)
	this_dPrazoEntsCab = {}         && TprMvCab.PrazoEnts - prazo de entrega, usado como base alternativa do vencimento quando CrSigOpFp.TpVencs = 2
	this_cTabDsCab = ""             && TprMvCab.TabDs - tabela de preco de destino (char(10) no schema - SigMvCab.tabds)
	this_cTpFatsCab = ""            && TprMvCab.TpFats - tipo de faturamento do movimento (char(3) no schema - SigMvCab.tpfats; chave de SigCdTif.Codigos no Ok.Click)
	this_nValDevsCab = 0            && TprMvCab.ValDevs - valor de devolucao (usado no calculo do total a receber quando Vars = 4)
	this_nValEncsCab = 0            && TprMvCab.ValEncs - valor de encargos do movimento
	this_nValInisCab = 0            && TprMvCab.ValInis - valor inicial do movimento (base de calculo de desconto/acrescimo)
	this_nValServsCab = 0           && TprMvCab.ValServs - valor total de servicos do movimento (somado ao valor de produto no calculo de variacao)
	this_nValTransCab = 0           && TprMvCab.ValTrans - valor de transporte/frete do movimento
	this_nValUtiCshCab = 0          && TprMvCab.ValUtiCsh - valor de cashback/bonus utilizado no movimento
	this_nValVarPsCab = 0           && TprMvCab.ValVarPs - percentual de variacao (desconto/acrescimo) aplicado ao movimento
	this_nValVarsCab = 0            && TprMvCab.ValVars - valor de variacao (desconto negativo/acrescimo positivo) do movimento
	this_nValosCab = 0              && TprMvCab.Valos - valor total do movimento (a ratear entre as condicoes de pagamento)
	this_nVarTotsCab = 0            && TprMvCab.VarTots - total de variacao acumulado do movimento
	this_nVarsCab = 0               && TprMvCab.Vars - percentual de variacao do movimento (espelha ValVarPs em alguns pontos do legado)

	*-- Configuracao da operacao (SigCdOpe), lida via Dopes = this_cDopes.
	*-- Sufixo "Ope" pelo mesmo motivo de colisao de nomes (Vars/parcs
	*-- tambem existem em outras origens). Populados em fase posterior;
	*-- default abaixo.
	this_nBlqDatasOpe = 0           && SigCdOpe.BlqDatas - bloqueia alteracao de vencimento (1=sempre, 3=so para tras) no Valid de Dataget_venc
	this_cCMoesOpe = ""             && SigCdOpe.CMoes - moeda padrao da operacao (usada na cotacao de moeda da operacao x moeda de pagamento)
	this_nCopersOpe = 0             && SigCdOpe.COpers - tipo de calculo de troco/complemento (1=debita da conta, 2=credita)
	this_nCaixasOpe = 0             && SigCdOpe.Caixas - 1 = operacao movimenta caixa (habilita protocolo de cheque obrigatorio)
	this_nConfesOpe = 0             && SigCdOpe.Confes - 1 = condicao de pagamento ja confirmada (desabilita cartao de credito manual)
	this_nDeacrsOpe = 0             && SigCdOpe.Deacrs - habilita os containers de desconto/acrescimo manual (Get_PorcVariacao/Get_TotVariacao)
	this_nDtEntrsOpe = 0            && SigCdOpe.DtEntrs - habilita uso do prazo de entrega como base alternativa do vencimento (confirmar tipo exato no schema)
	this_nEdComisOpe = 0            && SigCdOpe.EdComis - habilita edicao manual do numero de parcelas (Get_npar)
	this_cFPagOpCrsOpe = ""         && SigCdOpe.FPagOpCrs - forma de pagamento padrao/credito da operacao (usada em Apaga.Click/comparacoes de forma)
	this_nHabServsOpe = 0           && SigCdOpe.HabServs - habilita o campo de total de servicos (Get_TotServico)
	this_nLPrecosOpe = 0            && SigCdOpe.LPrecos - operacao usa lista de precos (afeta regra de variacao/desconto)
	this_nOpersOpe = 0              && SigCdOpe.Opers - 1=Entrada/2=Saida, direcao da operacao
	this_nParRecalsOpe = 0          && SigCdOpe.ParRecals - recalcula parcelas automaticamente ao mudar o valor
	this_nParcsOpe = 0              && SigCdOpe.parcs - 1 = operacao permite parcelamento (habilita Get_npar/Get_vpar)
	this_nPesoVtsOpe = 0            && SigCdOpe.PesoVts - operacao totaliza por peso (usado em Bot_TotItem.Click)
	this_nPrecoAutsOpe = 0          && SigCdOpe.PrecoAuts - autoriza precificacao automatica (espelha o uso em outros BOs de item)
	this_nPrecoVtsOpe = 0           && SigCdOpe.PrecoVts - operacao totaliza por valor de venda (usado em Bot_TotItem.Click)
	this_nValPresOpe = 0            && SigCdOpe.ValPres - operacao exige valor presente (desconta juros/calcula a valor presente)
	this_nVarsOpe = 0               && SigCdOpe.Vars - tipo de variacao permitido na operacao (3 = bloqueia Desconto/Acrescimo)
	this_nAptpfatsOpe = 0           && SigCdOpe.aptpfats - tipo de fatura/apuracao da operacao
	this_nCheqsOpe = 0              && SigCdOpe.cheqs - operacao aceita cheque como forma de pagamento
	this_nCupfisOpe = 0             && SigCdOpe.cupfis - 3 = cupom fiscal/nao fiscal (regras de TEF e bloqueio de valor zero)
	this_nParAutosOpe = 0           && SigCdOpe.parautos - 4 = bloqueia exclusao de condicao InsChs (Apaga.Click); 5 = bloqueia o proprio botao Apaga (regra externa ao Click, nao portada nesta fase)

	*-- Nome do cursor que este BO popula/consome (constante, para o Form
	*-- referenciar sem repetir literal - equivalente ao alias global do
	*-- legado xPar)
	this_cCursorCondicoes = "cursor_4c_Condicoes"  && Grade de condicoes de pagamento do movimento (SigMvPar)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela
	*-- SigMvPar - uma CONDICAO/PARCELA de pagamento do movimento, chave
	*-- cidchaves). this_cEmps/this_cDopes/this_nNumes acima JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cAgencias     = ""   && agencias char(4) - agencia bancaria do cheque
	this_cBancos       = ""   && bancos char(3) - banco do cheque
	this_cCartaos      = ""   && cartaos char(20) - numero do cartao de credito
	this_cContas       = ""   && contas char(10) - conta bancaria do cheque
	this_nCotfpgs      = 0    && cotfpgs numeric(11,4) - cotacao da moeda de pagamento na data da condicao
	this_dDatas        = {}   && datas datetime - data da condicao (preenchimento conforme regra de negocio da operacao)
	this_dDatatrans    = {}   && datatrans datetime - data da transacao (TEF/cartao)
	this_cDcarts       = ""   && dcarts char(12) - data de validade do cartao (MM/AAAA ou similar, mascara do legado)
	this_nEcNumes      = 0    && ec_numes numeric(6,0) - numero do comprovante eletronico de cheque (DOC/TED)
	this_cFpags        = ""   && fpags char(12) - codigo da forma de pagamento (SigOpFp.Fpags)
	this_cGrclis       = ""   && grclis char(10) - grupo do cliente/conta na data da condicao
	this_cIclis        = ""   && iclis char(10) - codigo da conta (cliente/fornecedor) associada a condicao
	this_cImpcars      = ""   && impcars char(1) - indicador de impressao do carne/boleto
	this_lInschs       = .F.  && inschs bit - condicao inserida via leitor de cheque (insercao automatica)
	this_cLocals       = ""   && locals char(10) - local/filial de recebimento
	this_cMoefpgs      = ""   && moefpgs char(3) - moeda da forma de pagamento
	this_cNcarnes      = ""   && ncarnes char(11) - numero do carne de pagamento
	this_nNcarts       = 0    && ncarts numeric(10,0) - numero sequencial de protocolo do cartao de credito
	this_nNcopias      = 0    && ncopias numeric(6,0) - numero de copias impressas do comprovante
	this_cNocreditos   = ""   && nocreditos char(10) - numero/codigo de aprovacao do credito (cartao/cheque pre-datado)
	this_nNopers       = 0    && nopers numeric(7,0) - numero da operacao de TEF/cartao
	this_nNrecs        = 0    && nrecs numeric(11,0) - numero do recibo gerado para a condicao
	this_nNtrans       = 0    && ntrans numeric(6,0) - numero da transacao (TEF)
	this_cNumchqs      = ""   && numchqs char(8) - numero do cheque
	this_cNumeros      = ""   && numeros char(6) - numero da conta bancaria do cheque (complemento de contas)
	this_nNumolds      = 0    && numolds numeric(6,0) - numero antigo/sequencia de regravacao da condicao (controle de aprovacao)
	this_cOutros       = ""   && outros char(20) - campo livre complementar da condicao
	this_nValos        = 0    && valos numeric(11,2) - valor da parcela/condicao de pagamento
	this_dVencs        = {}   && vencs datetime - data de vencimento da parcela
	this_nVpags        = 0    && vpags numeric(11,2) - valor efetivamente pago/recebido da parcela
	this_cCotusus      = ""   && cotusus char(30) - usuario que autorizou a cotacao manual
	this_cObs          = ""   && obs text - observacao da condicao de pagamento
	this_nParcs        = 0    && parcs numeric(2,0) - numero da parcela (sequencial dentro do total de parcelas)
	this_cCnidtefs     = ""   && cnidtefs char(10) - identificador da transacao TEF
	this_cCnnsuparcs   = ""   && cnnsuparcs char(12) - NSU da parcela (TEF/cartao)
	this_nNumlotechs   = 0    && numlotechs numeric(8,0) - numero do lote de cheques
	this_nNidcheps     = 0    && nidcheps numeric(10,0) - identificador do cheque pre-datado associado
	this_cEmpos        = ""   && empos char(3) - empresa de origem (quando a condicao se refere a outra empresa do grupo)
	this_cCidchaves    = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_nValocurs     = 0    && valocurs numeric(11,2) - valor da condicao convertido na moeda corrente
	this_nTrocos       = 0    && trocos numeric(1,0) - 1 = condicao representa troco/complemento devolvido ao cliente
	this_cEmpdopnums   = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga a condicao ao cabecalho (regra #42)
	this_cPagos        = ""   && pagos char(1) - indicador S/N de condicao ja liquidada
	this_dDtalts       = {}   && dtalts datetime - data da ultima alteracao da condicao
	this_cCpfs         = ""   && cpfs char(20) - CPF/CNPJ do titular do cartao/cheque, quando divergente da conta
	this_cDigagencs    = ""   && digagencs char(1) - digito verificador da agencia bancaria
	this_cDigchqs      = ""   && digchqs char(1) - digito verificador do cheque
	this_cDigcontas    = ""   && digcontas char(1) - digito verificador da conta bancaria
	this_cPracas       = ""   && pracas char(3) - praca bancaria do cheque
	this_nTparcs       = 0    && tparcs numeric(2,0) - total de parcelas da condicao (denominador de Parcs)
	this_nValdescs     = 0    && valdescs numeric(11,2) - valor de desconto aplicado a esta condicao
	this_cCodbcrts     = ""   && codbcrts char(5) - codigo da bandeira do cartao (SigCdCrt)
	this_lLcancelas    = .F.  && lcancelas bit - condicao cancelada (exclusao logica)
	this_nVcofins      = 0    && vcofins numeric(14,2) - valor de COFINS retido na condicao
	this_nVcsll        = 0    && vcsll numeric(14,2) - valor de CSLL retido na condicao
	this_nVirf         = 0    && virf numeric(14,2) - valor de IRF retido na condicao
	this_nVlrtrbfs     = 0    && vlrtrbfs numeric(14,2) - valor de tributo federal retido na condicao
	this_nVpis         = 0    && vpis numeric(14,2) - valor de PIS retido na condicao
	this_cAdquirente   = ""   && adquirente char(8) - codigo da adquirente do cartao (SigCdCad, tipocads = 'ADQUIRENTE')
	this_cAutoriza     = ""   && autoriza char(6) - codigo de autorizacao da transacao de cartao
	this_cNsu          = ""   && nsu char(50) - NSU (Numero Sequencial Unico) da transacao de cartao/TEF
	this_cChaveexterna = ""   && chaveexterna char(33) - chave de integracao externa (TEF/adquirente)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters pForm, datses, plAltDireta,
	* plAutomatico do Init do form legado - o form migrado repassa os
	* valores escalares que identificam o cabecalho do movimento
	* (par_cEmps/par_cDopes/par_nNumes, lidos pelo form a partir do
	* chamador) alem das duas flags de comportamento (poForm/datses, que
	* sao referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lAltDireta, par_lAutomatico)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvPar"
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

		IF VARTYPE(par_lAltDireta) = "L"
			THIS.this_lAltDireta = par_lAltDireta
		ENDIF

		IF VARTYPE(par_lAutomatico) = "L"
			THIS.this_lAutomatico = par_lAutomatico
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia uma linha de SigMvPar (cursor populado por
	* SQLEXEC, ex.: this_cCursorCondicoes) para as properties desta
	* condicao/parcela. NAO eh PROTECTED (regra #51 - BusinessBase declara
	* publico e o Form chama direto ao posicionar a linha da grade).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)

			THIS.this_cEmps         = TratarNulo(emps, "")
			THIS.this_cDopes        = TratarNulo(dopes, "")
			THIS.this_nNumes        = TratarNulo(numes, 0)
			THIS.this_cAgencias     = TratarNulo(agencias, "")
			THIS.this_cBancos       = TratarNulo(bancos, "")
			THIS.this_cCartaos      = TratarNulo(cartaos, "")
			THIS.this_cContas       = TratarNulo(contas, "")
			THIS.this_nCotfpgs      = TratarNulo(cotfpgs, 0)
			THIS.this_dDatas        = TratarNulo(datas, {})
			THIS.this_dDatatrans    = TratarNulo(datatrans, {})
			THIS.this_cDcarts       = TratarNulo(dcarts, "")
			THIS.this_nEcNumes      = TratarNulo(ec_numes, 0)
			THIS.this_cFpags        = TratarNulo(fpags, "")
			THIS.this_cGrclis       = TratarNulo(grclis, "")
			THIS.this_cIclis        = TratarNulo(iclis, "")
			THIS.this_cImpcars      = TratarNulo(impcars, "")
			THIS.this_lInschs       = ConverterParaLogico(inschs)
			THIS.this_cLocals       = TratarNulo(locals, "")
			THIS.this_cMoefpgs      = TratarNulo(moefpgs, "")
			THIS.this_cNcarnes      = TratarNulo(ncarnes, "")
			THIS.this_nNcarts       = TratarNulo(ncarts, 0)
			THIS.this_nNcopias      = TratarNulo(ncopias, 0)
			THIS.this_cNocreditos   = TratarNulo(nocreditos, "")
			THIS.this_nNopers       = TratarNulo(nopers, 0)
			THIS.this_nNrecs        = TratarNulo(nrecs, 0)
			THIS.this_nNtrans       = TratarNulo(ntrans, 0)
			THIS.this_cNumchqs      = TratarNulo(numchqs, "")
			THIS.this_cNumeros      = TratarNulo(numeros, "")
			THIS.this_nNumolds      = TratarNulo(numolds, 0)
			THIS.this_cOutros       = TratarNulo(outros, "")
			THIS.this_nValos        = TratarNulo(valos, 0)
			THIS.this_dVencs        = TratarNulo(vencs, {})
			THIS.this_nVpags        = TratarNulo(vpags, 0)
			THIS.this_cCotusus      = TratarNulo(cotusus, "")
			THIS.this_cObs          = TratarNulo(obs, "")
			THIS.this_nParcs        = TratarNulo(parcs, 0)
			THIS.this_cCnidtefs     = TratarNulo(cnidtefs, "")
			THIS.this_cCnnsuparcs   = TratarNulo(cnnsuparcs, "")
			THIS.this_nNumlotechs   = TratarNulo(numlotechs, 0)
			THIS.this_nNidcheps     = TratarNulo(nidcheps, 0)
			THIS.this_cEmpos        = TratarNulo(empos, "")
			THIS.this_cCidchaves    = TratarNulo(cidchaves, "")
			THIS.this_nValocurs     = TratarNulo(valocurs, 0)
			THIS.this_nTrocos       = TratarNulo(trocos, 0)
			THIS.this_cEmpdopnums   = TratarNulo(empdopnums, "")
			THIS.this_cPagos        = TratarNulo(pagos, "")
			THIS.this_dDtalts       = TratarNulo(dtalts, {})
			THIS.this_cCpfs         = TratarNulo(cpfs, "")
			THIS.this_cDigagencs    = TratarNulo(digagencs, "")
			THIS.this_cDigchqs      = TratarNulo(digchqs, "")
			THIS.this_cDigcontas    = TratarNulo(digcontas, "")
			THIS.this_cPracas       = TratarNulo(pracas, "")
			THIS.this_nTparcs       = TratarNulo(tparcs, 0)
			THIS.this_nValdescs     = TratarNulo(valdescs, 0)
			THIS.this_cCodbcrts     = TratarNulo(codbcrts, "")
			THIS.this_lLcancelas    = ConverterParaLogico(lcancelas)
			THIS.this_nVcofins      = TratarNulo(vcofins, 0)
			THIS.this_nVcsll        = TratarNulo(vcsll, 0)
			THIS.this_nVirf         = TratarNulo(virf, 0)
			THIS.this_nVlrtrbfs     = TratarNulo(vlrtrbfs, 0)
			THIS.this_nVpis         = TratarNulo(vpis, 0)
			THIS.this_cAdquirente   = TratarNulo(adquirente, "")
			THIS.this_cAutoriza     = TratarNulo(autoriza, "")
			THIS.this_cNsu          = TratarNulo(nsu, "")
			THIS.this_cChaveexterna = TratarNulo(chaveexterna, "")

			loc_lResultado = .T.
		ENDIF

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves (PK Fortyus, regra #22). PROTECTED:
	* nunca chamado de fora (so por RegistrarAuditoria/ExecutarExclusao).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidchaves
	ENDPROC

	*====================================================================
	* Inserir - INSERT completo em SigMvPar (condicao/parcela do
	* movimento). cidchaves (PK) e gerada aqui se ainda vazia (regra #22
	* - fUniqueIds(), NUNCA string vazia). empdopnums e a chave posicional
	* Emps(3)+Dopes(20)+Str(Numes,6) (regra #42 - PADR explicito, NUNCA
	* ALLTRIM nas partes). dpags/dtdeps (datetime NULL, sem uso no
	* codigo legado analisado) ficam fora da lista - SQL Server grava
	* NULL por omissao, o que e permitido pelo schema.
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		IF EMPTY(THIS.this_cCidchaves)
			THIS.this_cCidchaves = fUniqueIds()
		ENDIF

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				INSERT INTO SigMvPar (
					emps, dopes, numes, agencias, bancos, cartaos, contas, cotfpgs,
					datas, datatrans, dcarts, ec_numes, fpags, grclis, iclis, impcars,
					inschs, locals, moefpgs, ncarnes, ncarts, ncopias, nocreditos,
					nopers, nrecs, ntrans, numchqs, numeros, numolds, outros, valos,
					vencs, vpags, cotusus, obs, parcs, cnidtefs, cnnsuparcs,
					numlotechs, nidcheps, empos, cidchaves, valocurs, trocos,
					empdopnums, pagos, dtalts, cpfs, digagencs, digchqs, digcontas,
					pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, vcsll,
					virf, vlrtrbfs, vpis, adquirente, autoriza, nsu, chaveexterna
				)
				VALUES (
					<<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cDopes, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					<<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					<<FormatarDataSQL(THIS.this_dDatas)>>,
					<<FormatarDataSQL(THIS.this_dDatatrans)>>,
					<<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					<<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					<<IIF(THIS.this_lInschs, "1", "0")>>,
					<<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					<<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					<<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					<<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					<<FormatarDataSQL(THIS.this_dVencs)>>,
					<<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					<<EscaparSQL(THIS.this_cObs)>>,
					<<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					<<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					<<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					<<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>,
					<<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					<<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					<<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					<<FormatarDataSQL(THIS.this_dDtalts)>>,
					<<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					<<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					<<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					<<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					<<IIF(THIS.this_lLcancelas, "1", "0")>>,
					<<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					<<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					<<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					<<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					<<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					<<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				)
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERIR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao inserir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE completo em SigMvPar pela PK cidchaves. emps/
	* dopes/numes/cidchaves identificam o registro e NAO entram no SET.
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

		loc_lSucesso = .F.

		THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + ;
			PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				UPDATE SigMvPar SET
					agencias     = <<EscaparSQL(LEFT(THIS.this_cAgencias, 4))>>,
					bancos       = <<EscaparSQL(LEFT(THIS.this_cBancos, 3))>>,
					cartaos      = <<EscaparSQL(LEFT(THIS.this_cCartaos, 20))>>,
					contas       = <<EscaparSQL(LEFT(THIS.this_cContas, 10))>>,
					cotfpgs      = <<FormatarNumeroSQL(THIS.this_nCotfpgs, 4)>>,
					datas        = <<FormatarDataSQL(THIS.this_dDatas)>>,
					datatrans    = <<FormatarDataSQL(THIS.this_dDatatrans)>>,
					dcarts       = <<EscaparSQL(LEFT(THIS.this_cDcarts, 12))>>,
					ec_numes     = <<FormatarNumeroSQL(THIS.this_nEcNumes, 0)>>,
					fpags        = <<EscaparSQL(LEFT(THIS.this_cFpags, 12))>>,
					grclis       = <<EscaparSQL(LEFT(THIS.this_cGrclis, 10))>>,
					iclis        = <<EscaparSQL(LEFT(THIS.this_cIclis, 10))>>,
					impcars      = <<EscaparSQL(LEFT(THIS.this_cImpcars, 1))>>,
					inschs       = <<IIF(THIS.this_lInschs, "1", "0")>>,
					locals       = <<EscaparSQL(LEFT(THIS.this_cLocals, 10))>>,
					moefpgs      = <<EscaparSQL(LEFT(THIS.this_cMoefpgs, 3))>>,
					ncarnes      = <<EscaparSQL(LEFT(THIS.this_cNcarnes, 11))>>,
					ncarts       = <<FormatarNumeroSQL(THIS.this_nNcarts, 0)>>,
					ncopias      = <<FormatarNumeroSQL(THIS.this_nNcopias, 0)>>,
					nocreditos   = <<EscaparSQL(LEFT(THIS.this_cNocreditos, 10))>>,
					nopers       = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
					nrecs        = <<FormatarNumeroSQL(THIS.this_nNrecs, 0)>>,
					ntrans       = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
					numchqs      = <<EscaparSQL(LEFT(THIS.this_cNumchqs, 8))>>,
					numeros      = <<EscaparSQL(LEFT(THIS.this_cNumeros, 6))>>,
					numolds      = <<FormatarNumeroSQL(THIS.this_nNumolds, 0)>>,
					outros       = <<EscaparSQL(LEFT(THIS.this_cOutros, 20))>>,
					valos        = <<FormatarNumeroSQL(THIS.this_nValos, 2)>>,
					vencs        = <<FormatarDataSQL(THIS.this_dVencs)>>,
					vpags        = <<FormatarNumeroSQL(THIS.this_nVpags, 2)>>,
					cotusus      = <<EscaparSQL(LEFT(THIS.this_cCotusus, 30))>>,
					obs          = <<EscaparSQL(THIS.this_cObs)>>,
					parcs        = <<FormatarNumeroSQL(THIS.this_nParcs, 0)>>,
					cnidtefs     = <<EscaparSQL(LEFT(THIS.this_cCnidtefs, 10))>>,
					cnnsuparcs   = <<EscaparSQL(LEFT(THIS.this_cCnnsuparcs, 12))>>,
					numlotechs   = <<FormatarNumeroSQL(THIS.this_nNumlotechs, 0)>>,
					nidcheps     = <<FormatarNumeroSQL(THIS.this_nNidcheps, 0)>>,
					empos        = <<EscaparSQL(LEFT(THIS.this_cEmpos, 3))>>,
					valocurs     = <<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
					trocos       = <<FormatarNumeroSQL(THIS.this_nTrocos, 0)>>,
					empdopnums   = <<EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))>>,
					pagos        = <<EscaparSQL(LEFT(THIS.this_cPagos, 1))>>,
					dtalts       = <<FormatarDataSQL(THIS.this_dDtalts)>>,
					cpfs         = <<EscaparSQL(LEFT(THIS.this_cCpfs, 20))>>,
					digagencs    = <<EscaparSQL(LEFT(THIS.this_cDigagencs, 1))>>,
					digchqs      = <<EscaparSQL(LEFT(THIS.this_cDigchqs, 1))>>,
					digcontas    = <<EscaparSQL(LEFT(THIS.this_cDigcontas, 1))>>,
					pracas       = <<EscaparSQL(LEFT(THIS.this_cPracas, 3))>>,
					tparcs       = <<FormatarNumeroSQL(THIS.this_nTparcs, 0)>>,
					valdescs     = <<FormatarNumeroSQL(THIS.this_nValdescs, 2)>>,
					codbcrts     = <<EscaparSQL(LEFT(THIS.this_cCodbcrts, 5))>>,
					lcancelas    = <<IIF(THIS.this_lLcancelas, "1", "0")>>,
					vcofins      = <<FormatarNumeroSQL(THIS.this_nVcofins, 2)>>,
					vcsll        = <<FormatarNumeroSQL(THIS.this_nVcsll, 2)>>,
					virf         = <<FormatarNumeroSQL(THIS.this_nVirf, 2)>>,
					vlrtrbfs     = <<FormatarNumeroSQL(THIS.this_nVlrtrbfs, 2)>>,
					vpis         = <<FormatarNumeroSQL(THIS.this_nVpis, 2)>>,
					adquirente   = <<EscaparSQL(LEFT(THIS.this_cAdquirente, 8))>>,
					autoriza     = <<EscaparSQL(LEFT(THIS.this_cAutoriza, 6))>>,
					nsu          = <<EscaparSQL(LEFT(THIS.this_cNsu, 50))>>,
					chaveexterna = <<EscaparSQL(LEFT(THIS.this_cChaveexterna, 33))>>
				WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("ALTERAR")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao atualizar condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - le o cabecalho do movimento (TprMvCab, cursor
	* que o FORM PAI legado ja deixa aberto na DataSession compartilhada -
	* regra #35/cabecalho do topo deste arquivo) e a configuracao da
	* operacao (SigCdOpe, via SQLEXEC por Dopes). Chamado pelo Form logo
	* apos instanciar o BO, ANTES de CarregarCondicoes()/CarregarLista().
	*
	* TprMvCab e um cursor MONTADO pelo form pai (nao necessariamente
	* 1-para-1 com as colunas de SigMvCab) - por isso cada leitura e
	* guardada por TYPE() != "U": campo ausente la NAO e erro aqui, so
	* mantem o default ja declarado na propriedade.
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		TRY
			IF USED("TprMvCab")
				SELECT TprMvCab
				IF RECCOUNT() > 0 AND !EOF()
					IF TYPE("TprMvCab.contaos") != "U"
						THIS.this_cContaOsCab = TratarNulo(contaos, "")
					ENDIF
					IF TYPE("TprMvCab.contads") != "U"
						THIS.this_cContaDsCab = TratarNulo(contads, "")
					ENDIF
					IF TYPE("TprMvCab.datas") != "U"
						THIS.this_dDatasCab = TratarNulo(datas, {})
					ENDIF
					IF TYPE("TprMvCab.notas") != "U"
						THIS.this_cNotasCab = TratarNulo(notas, "")
					ENDIF
					IF TYPE("TprMvCab.prazoents") != "U"
						THIS.this_dPrazoEntsCab = TratarNulo(prazoents, {})
					ENDIF
					IF TYPE("TprMvCab.tabds") != "U"
						THIS.this_cTabDsCab = TratarNulo(tabds, "")
					ENDIF
					IF TYPE("TprMvCab.tpfats") != "U"
						THIS.this_cTpFatsCab = TratarNulo(tpfats, "")
					ENDIF
					IF TYPE("TprMvCab.valdevs") != "U"
						THIS.this_nValDevsCab = TratarNulo(valdevs, 0)
					ENDIF
					IF TYPE("TprMvCab.valencs") != "U"
						THIS.this_nValEncsCab = TratarNulo(valencs, 0)
					ENDIF
					IF TYPE("TprMvCab.valinis") != "U"
						THIS.this_nValInisCab = TratarNulo(valinis, 0)
					ENDIF
					IF TYPE("TprMvCab.valservs") != "U"
						THIS.this_nValServsCab = TratarNulo(valservs, 0)
					ENDIF
					IF TYPE("TprMvCab.valtrans") != "U"
						THIS.this_nValTransCab = TratarNulo(valtrans, 0)
					ENDIF
					IF TYPE("TprMvCab.valuticsh") != "U"
						THIS.this_nValUtiCshCab = TratarNulo(valuticsh, 0)
					ENDIF
					IF TYPE("TprMvCab.valvarps") != "U"
						THIS.this_nValVarPsCab = TratarNulo(valvarps, 0)
					ENDIF
					IF TYPE("TprMvCab.valvars") != "U"
						THIS.this_nValVarsCab = TratarNulo(valvars, 0)
					ENDIF
					IF TYPE("TprMvCab.valos") != "U"
						THIS.this_nValosCab = TratarNulo(valos, 0)
					ENDIF
					IF TYPE("TprMvCab.vartots") != "U"
						THIS.this_nVarTotsCab = TratarNulo(vartots, 0)
					ENDIF
					IF TYPE("TprMvCab.vars") != "U"
						THIS.this_nVarsCab = TratarNulo(vars, 0)
					ENDIF
				ENDIF
			ENDIF

			IF USED("cursor_4c_SigCdOpeTmp")
				USE IN cursor_4c_SigCdOpeTmp
			ENDIF

			IF !EMPTY(THIS.this_cDopes)
				TEXT TO loc_cSQL TEXTMERGE NOSHOW
					SELECT blqdatas, cmoes, copers, caixas, confes, deacrs, dtentrs,
						   edcomis, fpagopcrs, habservs, lprecos, opers, parrecals,
						   parcs, pesovts, precoauts, precovts, valpres, vars,
						   aptpfats, cheqs, cupfis, parautos
					FROM SigCdOpe
					WHERE dopes = <<EscaparSQL(THIS.this_cDopes)>>
				ENDTEXT

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeTmp")

				IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdOpeTmp") AND !EOF("cursor_4c_SigCdOpeTmp")
					SELECT cursor_4c_SigCdOpeTmp
					THIS.this_nBlqDatasOpe  = TratarNulo(blqdatas, 0)
					THIS.this_cCMoesOpe     = TratarNulo(cmoes, "")
					THIS.this_nCopersOpe    = TratarNulo(copers, 0)
					THIS.this_nCaixasOpe    = TratarNulo(caixas, 0)
					THIS.this_nConfesOpe    = TratarNulo(confes, 0)
					THIS.this_nDeacrsOpe    = TratarNulo(deacrs, 0)
					THIS.this_nDtEntrsOpe   = TratarNulo(dtentrs, 0)
					THIS.this_nEdComisOpe   = TratarNulo(edcomis, 0)
					THIS.this_cFPagOpCrsOpe = TratarNulo(fpagopcrs, "")
					THIS.this_nHabServsOpe  = TratarNulo(habservs, 0)
					THIS.this_nLPrecosOpe   = TratarNulo(lprecos, 0)
					THIS.this_nOpersOpe     = TratarNulo(opers, 0)
					THIS.this_nParRecalsOpe = TratarNulo(parrecals, 0)
					THIS.this_nParcsOpe     = TratarNulo(parcs, 0)
					THIS.this_nPesoVtsOpe   = TratarNulo(pesovts, 0)
					THIS.this_nPrecoAutsOpe = TratarNulo(precoauts, 0)
					THIS.this_nPrecoVtsOpe  = TratarNulo(precovts, 0)
					THIS.this_nValPresOpe   = TratarNulo(valpres, 0)
					THIS.this_nVarsOpe      = TratarNulo(vars, 0)
					THIS.this_nAptpfatsOpe  = TratarNulo(aptpfats, 0)
					THIS.this_nCheqsOpe     = TratarNulo(cheqs, 0)
					THIS.this_nCupfisOpe    = TratarNulo(cupfis, 0)
					THIS.this_nParAutosOpe  = TratarNulo(parautos, 0)
				ENDIF

				IF USED("cursor_4c_SigCdOpeTmp")
					USE IN cursor_4c_SigCdOpeTmp
				ENDIF
			ENDIF

			loc_lSucesso = .T.
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o do movimento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarConfiguracao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarCondicoes - porta PARCIAL do carregamento de condicoes de
	* SigMvPar para a grade. No legado isso e feito pelo FORM PAI, via
	* AddCursor no seu proprio Init, deixando xPar ja aberto e
	* compartilhado com este form filho (regra #35/cabecalho). Quando este
	* form roda ISOLADO (sem pai - modo de teste/validacao de UI), xPar
	* nao existe: este metodo busca SigMvPar por Emps+Dopes+Numes via
	* SQLEXEC e substitui o CONTEUDO do cursor_4c_Condicoes (ja criado e
	* ligado ao Grid por Formsigoppag::ConfigurarGrid) SEM refazer a
	* estrutura - SQLEXEC direto no alias do grid zeraria o ColumnCount.
	*====================================================================
	PROCEDURE CarregarCondicoes()
		LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp, loc_lSucesso, loc_oErro

		loc_lSucesso   = .F.
		loc_cCursorTmp = "cursor_4c_CondicoesTmp"

		IF !USED(THIS.this_cCursorCondicoes)
			RETURN loc_lSucesso
		ENDIF

		TRY
			IF USED(loc_cCursorTmp)
				USE IN (loc_cCursorTmp)
			ENDIF

			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				SELECT cidchaves, emps, dopes, numes, fpags, valos, vencs,
					   moefpgs, cotfpgs, valdescs, inschs, numchqs, nidcheps, trocos
				FROM SigMvPar
				WHERE emps = <<EscaparSQL(THIS.this_cEmps)>>
				  AND dopes = <<EscaparSQL(THIS.this_cDopes)>>
				  AND numes = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>
				ORDER BY vencs
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

			IF loc_nResultado >= 0 AND USED(loc_cCursorTmp)
				SELECT (THIS.this_cCursorCondicoes)
				ZAP
				APPEND FROM (DBF(loc_cCursorTmp))

				USE IN (loc_cCursorTmp)

				SELECT (THIS.this_cCursorCondicoes)
				GO TOP

				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao carregar condi" + CHR(231) + CHR(245) + "es de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.CarregarCondicoes")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExcluirCondicao - DELETE direto em SigMvPar pela PK cidchaves, usado
	* pelo Apaga.Click do form (regra #22 - cidchaves e a PK Fortyus).
	* Linha que nunca foi persistida (cidchaves ainda vazio) nao precisa de
	* DELETE remoto - retorna sucesso sem tocar no banco.
	*====================================================================
	PROCEDURE ExcluirCondicao(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

		loc_lSucesso = .F.

		IF EMPTY(par_cCidchaves)
			RETURN .T.
		ENDIF

		TRY
			TEXT TO loc_cSQL TEXTMERGE NOSHOW
				DELETE FROM SigMvPar WHERE cidchaves = <<EscaparSQL(LEFT(par_cCidchaves, 20))>>
			ENDTEXT

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = CapturarErroSQL()
				MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MostrarErro("Erro ao excluir condi" + CHR(231) + CHR(227) + "o de pagamento:" + CHR(13) + loc_oErro.Message, "sigoppagBO.ExcluirCondicao")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE
