*==============================================================================
* SigOpFpgBO.prg
*
* Business Object para SigOpFpg (Forma de Pagamento)
* Dialogo filho chamado por formularios de movimento (ex.: Fluxo de Caixa /
* Baixa de Titulos) para distribuir o valor de um titulo/cheque em uma ou
* mais formas de pagamento (dinheiro, cartao, carne, cheque, outros).
*
* Nao possui tabela principal propria: a grade de formas de pagamento
* trabalha sobre o cursor local xPar (populado/consumido pelo form) e os
* dados sao devolvidos ao formulario pai, que grava no titulo/movimento
* de origem (SigChLcq e afins).
*
* FASE 1/8: Propriedades e Init. FASE 8/8: propriedades adicionais lidas
* pelo gerador de parcelas (this_cEmps/this_nEntradas/this_nDias/
* this_cTvens/this_cDcarts), populadas pelo FormSigOpFpg em
* AplicarFormaPagamento/DefinirDadosTitulo.
*==============================================================================

DEFINE CLASS SigOpFpgBO AS BusinessBase

    *-- Contexto recebido do formulario pai (Init do form legado:
    *-- Lparameters pForm, DatSes, llAltDireta)
    this_cOpEscolha     = ""    && op_escolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/EXCLUIR)
    this_lAltDireta     = .F.   && llAltDireta - fluxo de alteracao direta de forma de pagamento

    *-- Dados do titulo/movimento sendo pago (resolvidos a partir do cursor
    *-- do form pai - equivalente a CrSigChLcq no legado)
    this_dDtEnts        = {}    && datetime - data de entrada/movimentacao do titulo
    this_nValTots       = 0     && numeric  - valor total do titulo/cheque a pagar
    this_cEmps          = ""    && char     - empresa do titulo (SigChLcq.Emps), gravada em cada parcela

    *-- Linha corrente da grade de formas de pagamento (xPar), espelhando as
    *-- colunas usadas pelo legado: FPags, Valos, Vencs, Moedas, CotFpgs
    this_cFPags         = ""    && char     - codigo da forma de pagamento (SigCdOpFp.FPags)
    this_nValos         = 0     && numeric  - valor da parcela/linha
    this_dVencs         = {}    && date     - data de vencimento da parcela
    this_cMoedas        = ""    && char     - moeda da parcela
    this_nCotFpgs       = 0     && numeric  - cotacao aplicada na parcela

    *-- Totais e campos de cabecalho do dialogo
    this_cMoeOper       = ""    && char     - moeda de operacao (Get_MoeOper)
    this_nTotForma      = 0     && numeric  - total ja distribuido nas formas de pagamento
    this_nNPar          = 0     && numeric  - numero de parcelas
    this_nVPar          = 0     && numeric  - valor da parcela calculada
    this_nPEncargo      = 0     && numeric  - percentual de encargo financeiro
    this_nVEncargo      = 0     && numeric  - valor de encargo financeiro
    this_nCotacao       = 0     && numeric  - cotacao atual da moeda de operacao
    this_cCotUsu        = ""    && char     - indicador de cotacao alterada manualmente (SigOpAlC)
    this_nValTotChqs    = 0     && numeric  - valor total ja distribuido em cheques
    this_cObs           = ""    && memo     - observacao (forma "Outros")

    *-- Regras de vencimento/parcelamento da forma de pagamento escolhida
    *-- (SigOpFp.entradas/dias/tvens/dcarts), lidas em AplicarFormaPagamento e
    *-- consumidas pelo gerador de parcelas (fweditdata_venc.Valid do legado)
    this_nEntradas      = 0     && numeric - dias da data do titulo at? o 1o vencimento
    this_nDias          = 0     && numeric - intervalo entre parcelas (dias)
    this_cTvens         = ""    && char    - "F"=dias Fixos (GoMonth) / "C"=dias Corridos
    this_cDcarts        = ""    && char    - descricao do cartao, gravada em cada parcela

    *-- Painel Cartao de Credito (CntCCred / CntCCredFP)
    this_cCartao        = ""    && char     - numero do cartao de credito
    this_nCred          = 0     && numeric  - numero de parcelas do credito

    *-- Painel Carne (CntCarneFP)
    this_cCarne         = ""    && char     - codigo do carne

    *-- Painel Cheque (CntChequeFP)
    this_cBco           = ""    && char     - codigo do banco
    this_cAge           = ""    && char     - codigo da agencia
    this_cConta         = ""    && char     - numero da conta
    this_cNum           = ""    && char     - numero do cheque

    *-- Estado de controle (leitora serial de cheques / flags do legado)
    this_lLeitor        = .F.   && leitora serial de cheques habilitada
    this_cLeituraSerial = ""    && buffer com a leitura recebida da porta serial
    this_cTipoLeitora   = ""    && "S" = leitora serial configurada
    this_lDigpar        = .F.   && habilita digitacao manual de numero de parcelas
    this_lCarAuts       = .F.   && SigCdOpFp.CarAuts - cartao de credito sem validacao de digitos

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal (dialogo
    * trabalha sobre cursor local do form pai).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela principal
    * (ver cabecalho da classe): a linha corrente da grade de formas de
    * pagamento chega por propriedade (this_cFPags/this_nValos/this_dVencs/
    * this_cMoedas/this_nCotFpgs), preenchida pelo proprio form a partir do
    * cursor local xPar - nao por SELECT (par_cAliasCursor).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. Este dialogo nao grava em tabela do SQL
    * Server: a gravacao efetiva do titulo/movimento ocorre no formulario
    * pai (SigChLcq e afins), a partir do cursor xPar devolvido no Return.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui. O registro
    * de auditoria do titulo/movimento fica a cargo do formulario pai.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

ENDDEFINE
