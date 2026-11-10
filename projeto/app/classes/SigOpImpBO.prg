*====================================================================
* SigOpImpBO.prg
*
* Business Object para Manutencao de Impostos do Item (SIGOPIMP)
*
* Dialogo FILHO aberto pela tela de movimento (ParentForm.ParentForm)
* para ajustar manualmente os impostos de UM item da nota. No legado o
* form recebe (pForm, pnDatSes, pConexao) e trabalha sobre o cursor de
* itens do form pai - crTpmMvItn - posicionado no item corrente por
* cItens; o cabecalho vem de TprMvCab e a conta (cliente/fornecedor)
* de crSigMvNfi.cliFors.
*
* IMPORTANTE - este dialogo NAO grava em tabela de movimento: todo
* Replace do legado tem por destino o CURSOR do form pai (crTpmMvItn),
* e a persistencia fica com a tela de movimento, que recalcula os
* totais (Atuatot) e os impostos (CalcImposto) e so depois comita. Por
* isso Atualizar() aqui NAO monta um SQL UPDATE contra SigMvItn: ele
* aplica as propriedades this_* editadas de volta no cursor do form pai
* (REPLACE, igual ao legado) atraves de AplicarAoCursor() - a gravacao
* real na tabela fica a cargo da tela de movimento, de fora deste BO.
* O unico acesso remoto de escrita feito por este BO eh o UPDATE
* opcional de SigCdPro.ClFiscals, confirmado pelo usuario no lookup de
* Classificacao Fiscal (fase de lookup). Como o dialogo nunca cria nem
* exclui item - so ajusta um item ja existente - o comportamento padrao
* herdado de BusinessBase para Inserir()/ExecutarExclusao() ja eh o
* correto e este BO nao os sobrescreve.
*
* Tabelas de referencia (somente leitura):
*   SigMvItn  - estrutura/tipos das colunas do item (cursor crTpmMvItn)
*   SigCdClf  - Classificacao Fiscal (Codigos/Descricaos/BIcms)
*   SigCdCFO  - CFOP (Codigos/Descricaos/aliq*/ipis/icms)
*   SigCdPro  - Produto (ClFiscals/cgrus)
*   SigCdGRP  - Grupo do produto (servicos)
*   sigopfin  - aliquotas de imposto por conta (origem do FSigOpFin_imp
*               legado, usado quando a aliquota do CFOP vem zerada)
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpImpBO AS BusinessBase

    *----------------------------------------------------------------
    * ITEM EM EDICAO - colunas do cursor de itens do form pai
    * (crTpmMvItn no legado). Tipos conferidos em docs\schema.sql,
    * tabela SigMvItn, que eh a estrutura espelhada pelo cursor.
    *----------------------------------------------------------------
    this_nItem              = 0     && cItens   numeric(10,0) - chave do item no cursor
    this_cProduto           = ""    && Cpros    char(14)      - codigo do produto
    this_cDescricaoProduto  = ""    && Dpros    char(65)      - descricao do produto
    this_nTotal             = 0     && Totas    numeric(11,2) - total do item

    *-- IPI
    this_nAliqIpi           = 0     && Aliqs    numeric(4,2)  - percentual de IPI
    this_nValIpi            = 0     && ValIpis  numeric(11,2) - valor do IPI
    this_nBcIpi             = 0     && BcIpis   numeric(15,2) - base de calculo do IPI

    *-- ICMS
    this_nAliqIcms          = 0     && AliqIcms numeric(5,2)  - percentual de ICMS
    this_nIcms              = 0     && Icms     numeric(15,2) - valor do ICMS
    this_nBaseIcms          = 0     && BaseIcms numeric(11,2) - base de calculo do ICMS

    *-- ICMS Substituicao
    this_nIcmsSubst         = 0     && Icmss    numeric(15,2) - valor do ICMS substituicao
    this_nBcIcmsSubst       = 0     && BcIcmss  numeric(15,2) - base do ICMS substituicao

    *----------------------------------------------------------------
    * Base dos demais impostos e os valores calculados sobre ela.
    * O Valid do campo de base (getVBc) recalcula os sete valores
    * abaixo usando a aliquota do CFOP e, quando ela vem zerada, a
    * aliquota da conta; ISS/IRRF/INSS/CSSL so recebem valor quando o
    * grupo do produto eh de servico (servicos = 1).
    *----------------------------------------------------------------
    this_nValBase           = 0     && valbases numeric(11,2) - BC Imps
    this_nVPis              = 0     && vpis     numeric(11,2) - PIS
    this_nVCofins           = 0     && vcofins  numeric(11,2) - COFINS
    this_nTaxaIi            = 0     && taxaiis  numeric(11,2) - II (imposto de importacao)
    this_nIss               = 0     && iss      numeric(11,2) - ISS
    this_nIrrf              = 0     && irrf     numeric(11,2) - IRRF
    this_nInss              = 0     && inss     numeric(11,2) - INSS
    this_nCssl              = 0     && cssl     numeric(11,2) - CSSL

    *-- CFOP do item
    this_cCfop              = ""    && cfops    char(10)      - CFOP gravado no item

    *-- AltImpost NAO existe em SigMvItn: eh coluna de controle que so
    *-- existe no cursor de trabalho do form pai, marcada com .T. para
    *-- avisar a tela de movimento que o imposto foi ajustado a mao.
    this_lAltImposto        = .F.   && AltImpost (logico, somente no cursor)

    *----------------------------------------------------------------
    * CLASSIFICACAO FISCAL - SigCdClf
    * Codigo carregado do produto (SigCdPro.ClFiscals) no Init legado,
    * via Select a.ClFiscals, b.Descricaos From SigCdPro a, SigCdClf b
    *----------------------------------------------------------------
    this_cClFiscal          = ""    && SigCdClf.Codigos    char(10)
    this_cDescrClFiscal     = ""    && SigCdClf.Descricaos char(40)
    this_nBIcmsClFiscal     = 0     && SigCdClf.BIcms      numeric(9,6) - ICMS sugerido pela classificacao

    *----------------------------------------------------------------
    * CFOP - SigCdCFO
    * O Init legado le Descricaos/codigos/aliqpis/aliqcofins/aliqii/
    * aliqissqn; o Valid do campo CFOP usa tambem ipis/icms (marca de
    * tributacao com a letra T) e aliqipis/aliqivcs.
    *----------------------------------------------------------------
    this_cDescrCfop         = ""    && SigCdCFO.Descricaos char(60)
    this_nAliqIpiCfop       = 0     && SigCdCFO.aliqipis   numeric(4,2) - percentual de IPI do CFOP
    this_nAliqIcmsCfop      = 0     && SigCdCFO.aliqivcs   numeric(4,2) - percentual de ICMS do CFOP
    this_nAliqPisCfop       = 0     && SigCdCFO.aliqpis    numeric(5,2)
    this_nAliqCofinsCfop    = 0     && SigCdCFO.aliqcofins numeric(5,2)
    this_nAliqIiCfop        = 0     && SigCdCFO.aliqii     numeric(5,2)
    this_nAliqIssqnCfop     = 0     && SigCdCFO.aliqissqn  numeric(5,2)
    this_cTribIpiCfop       = ""    && SigCdCFO.ipis       char(1) - letra T indica tributado
    this_cTribIcmsCfop      = ""    && SigCdCFO.icms       char(1) - letra T indica tributado

    *----------------------------------------------------------------
    * PRODUTO / GRUPO - SigCdPro + SigCdGRP
    * servicos = 1 libera a digitacao de ISS/IRRF/INSS/CSSL (o When de
    * cada um desses campos devolve LocalGrp.servicos = 1 no legado).
    * servicos eh numeric(1,0) no schema - property NUMERICA, nunca
    * logica (eh coluna de dominio, nao booleana).
    *----------------------------------------------------------------
    this_cGrupoProduto      = ""    && SigCdPro.cgrus      char(3)
    this_nServicosGrupo     = 0     && SigCdGRP.servicos   numeric(1,0)

    *----------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    * Conta vem de crSigMvNfi.cliFors e eh o primeiro argumento do
    * FSigOpFin_imp legado (aliquota de imposto por conta).
    * Empresa/Operacao/Numero vem de TprMvCab e formam a chave de
    * transacao do log: Emps + Dopes + Str(Numes, 6) - concatenacao
    * POSICIONAL, por isso cada parte guarda a largura do schema.
    *----------------------------------------------------------------
    this_cConta             = ""    && crSigMvNfi.cliFors  char(20)
    this_cEmpresa           = ""    && SigMvCab.emps       char(3)
    this_cOperacao          = ""    && SigMvCab.dopes      char(20)
    this_nNumero            = 0     && SigMvCab.numes      numeric(6,0)
    this_cUsuario           = ""    && Usuar do legado - gc_4c_UsuarioLogado

    *----------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_lManipulou reproduz ThisForm.maniPulou: fica .T. quando
    * QUALQUER campo foi alterado pelo usuario, e eh o que decide se o
    * log MANIMPOSTO eh gravado e se a confirmacao de base zerada com
    * imposto mantido eh perguntada na saida.
    *----------------------------------------------------------------
    this_lManipulou         = .F.   && ThisForm.maniPulou
    this_lAtualizouProduto  = .F.   && .T. quando o UPDATE de SigCdPro.ClFiscals foi aplicado

    *-- Lista (separada por virgula) dos impostos que AplicarRecalculoBase()
    *-- NAO conseguiu recalcular por falta de aliquota de CFOP e de
    *-- FSigOpFin_imp (funcao legado ausente do acervo - regra #27). Vazia
    *-- quando o ultimo recalculo cobriu todos os impostos aplicaveis.
    this_cAliquotasIndisponiveis = ""

    *----------------------------------------------------------------
    * ALIAS DOS CURSORES
    * Os tres primeiros pertencem ao FORM PAI e chegam por parametro -
    * o dialogo LE e ESCREVE neles, nao os cria. Os demais sao locais
    * deste BO (lookups e consultas de aliquota).
    *----------------------------------------------------------------
    this_cCursorItens       = "crTpmMvItn"              && cursor de itens do form pai
    this_cCursorCabecalho   = "TprMvCab"                && cabecalho do movimento no form pai
    this_cCursorNfi         = "crSigMvNfi"              && nota fiscal no form pai (cliFors)
    this_cCursorClf         = "cursor_4c_ClFiscal"      && SigCdClf - classificacao fiscal
    this_cCursorCfo         = "cursor_4c_Cfop"          && SigCdCFO - CFOP
    this_cCursorGrp         = "cursor_4c_GrupoProduto"  && SigCdPro + SigCdGRP - servicos
    this_cCursorFin         = "cursor_4c_AliqFin"       && sigopfin - aliquota por conta
    this_cCursorBusca       = "cursor_4c_Busca"         && cursor dos lookups (FormBuscaAuxiliar)

    *====================================================================
    * Init - Inicializa Business Object
    *
    * Tabela/chave apontam para SigMvItn porque eh a estrutura do item
    * que este dialogo edita (o cursor do form pai a espelha). Nao se
    * passa a tabela ao DODEFAULT: sem DataAccess instanciado, nenhum
    * caminho herdado tenta gravar por conta propria - a persistencia
    * deste item eh responsabilidade da tela de movimento.
    *
    * O usuario logado eh lido com guarda de TYPE porque o BO tambem eh
    * instanciado em probe/modo de teste, quando as globais do config
    * ainda nao existem.
    *
    * Sem RETURN dentro do TRY (regra #1): a flag loc_lSucesso carrega o
    * resultado e o unico RETURN fica depois do ENDTRY.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "citens"

            *-- Usuario logado (Usuar do legado) para o log MANIMPOSTO
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            *-- Dialogo abre sempre em consulta do item corrente: nada foi
            *-- alterado ainda, e o item so eh marcado como ajustado a mao
            *-- quando o usuario confirma.
            THIS.this_lManipulou        = .F.
            THIS.this_lAltImposto       = .F.
            THIS.this_lAtualizouProduto = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpImpBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do item (SigMvItn) do
    * cursor do form pai (crTpmMvItn, default this_cCursorItens) para as
    * propriedades this_*. Equivalente ao bloco de leitura do Init
    * legado (With ThisForm / .get_Produto.Value = crTpmMvItn.Cpros / ...).
    *
    * AltImpost NAO existe em SigMvItn (regra do cabecalho deste
    * arquivo): guarda por TYPE() antes de ler, porque so o cursor de
    * trabalho do form pai tem essa coluna extra.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(pcCursor), THIS.this_cCursorItens, pcCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de itens (" + loc_cAlias + ") n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        THIS.this_nItem              = TratarNulo(cItens, 0)
        THIS.this_cProduto           = TratarNulo(Cpros, "")
        THIS.this_cDescricaoProduto  = TratarNulo(Dpros, "")
        THIS.this_nTotal             = TratarNulo(Totas, 0)

        THIS.this_nAliqIpi           = TratarNulo(Aliqs, 0)
        THIS.this_nValIpi            = TratarNulo(ValIpis, 0)
        THIS.this_nBcIpi             = TratarNulo(BcIpis, 0)

        THIS.this_nAliqIcms          = TratarNulo(AliqIcms, 0)
        THIS.this_nIcms              = TratarNulo(Icms, 0)
        THIS.this_nBaseIcms          = TratarNulo(BaseIcms, 0)

        THIS.this_nIcmsSubst         = TratarNulo(Icmss, 0)
        THIS.this_nBcIcmsSubst       = TratarNulo(BcIcmss, 0)

        THIS.this_nValBase           = TratarNulo(valbases, 0)
        THIS.this_nVPis              = TratarNulo(vpis, 0)
        THIS.this_nVCofins           = TratarNulo(vcofins, 0)
        THIS.this_nTaxaIi            = TratarNulo(taxaiis, 0)
        THIS.this_nIss               = TratarNulo(iss, 0)
        THIS.this_nIrrf              = TratarNulo(irrf, 0)
        THIS.this_nInss              = TratarNulo(inss, 0)
        THIS.this_nCssl              = TratarNulo(cssl, 0)

        THIS.this_cCfop              = TratarNulo(cfops, "")

        IF TYPE(loc_cAlias + ".AltImpost") = "L"
            THIS.this_lAltImposto = EVALUATE(loc_cAlias + ".AltImpost")
        ELSE
            THIS.this_lAltImposto = .F.
        ENDIF

        THIS.this_cCursorItens = loc_cAlias
        THIS.this_lManipulou   = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * AplicarAoCursor - Grava as propriedades this_* editadas de volta no
    * cursor do item do form pai, via REPLACE (igual a cada Valid do
    * legado - Replace Icms With This.Value in crTpmMvItn - so que num
    * unico ponto, com todos os campos deste dialogo). Localiza a linha
    * pela chave (cItens) porque o cursor do form pai pode estar
    * posicionado em outro registro quando este metodo eh chamado.
    *
    * AltImpost so eh regravado quando a coluna existe no cursor (regra
    * de AltImpost acima) - este dialogo marca o item como "imposto
    * ajustado a mao", igual ao btnConfirmar.Click e ao btnSair.Click do
    * legado.
    *====================================================================
    PROCEDURE AplicarAoCursor(pcCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(EMPTY(pcCursor), THIS.this_cCursorItens, pcCursor)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de itens (" + loc_cAlias + ") n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem

        IF !FOUND()
            THIS.this_cMensagemErro = "Item " + TRANSFORM(THIS.this_nItem) + " n" + CHR(227) + "o encontrado no cursor de itens"
            RETURN .F.
        ENDIF

        REPLACE Aliqs    WITH THIS.this_nAliqIpi, ;
                ValIpis  WITH THIS.this_nValIpi, ;
                BcIpis   WITH THIS.this_nBcIpi, ;
                AliqIcms WITH THIS.this_nAliqIcms, ;
                Icms     WITH THIS.this_nIcms, ;
                BaseIcms WITH THIS.this_nBaseIcms, ;
                Icmss    WITH THIS.this_nIcmsSubst, ;
                BcIcmss  WITH THIS.this_nBcIcmsSubst, ;
                valbases WITH THIS.this_nValBase, ;
                vpis     WITH THIS.this_nVPis, ;
                vcofins  WITH THIS.this_nVCofins, ;
                taxaiis  WITH THIS.this_nTaxaIi, ;
                iss      WITH THIS.this_nIss, ;
                irrf     WITH THIS.this_nIrrf, ;
                inss     WITH THIS.this_nInss, ;
                cssl     WITH THIS.this_nCssl, ;
                cfops    WITH THIS.this_cCfop ;
            IN (loc_cAlias)

        IF TYPE(loc_cAlias + ".AltImpost") = "L"
            REPLACE AltImpost WITH .T. IN (loc_cAlias)
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * Atualizar - OVERRIDE de BusinessBase.Atualizar().
    *
    * Para este dialogo, "atualizar" NAO eh um SQL UPDATE contra
    * SigMvItn: eh aplicar as propriedades this_* editadas de volta no
    * cursor do form pai (AplicarAoCursor), exatamente como o legado faz
    * a cada Valid de campo e no btnConfirmar/btnSair. A gravacao
    * definitiva na tabela (TABLEUPDATE) fica com a tela de movimento.
    *
    * O log de auditoria so eh registrado quando o usuario de fato
    * alterou algum valor (this_lManipulou), reproduzindo a mesma
    * condicao do legado (If ThisForm.maniPulou ... fGravarLog(...)) -
    * aqui pelo caminho padrao do sistema novo (LogAuditoria).
    *
    * Sem RETURN dentro do TRY/CATCH (regra #1).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.AplicarAoCursor(THIS.this_cCursorItens)
                IF THIS.this_lManipulou
                    THIS.RegistrarAuditoria("ALTERAR")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigOpImpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - OVERRIDE de BusinessBase.ObterChavePrimaria().
    *
    * A chave do registro editado por este dialogo eh o numero do item
    * (cItens) dentro do cursor de itens do form pai - eh o que
    * identifica a linha tanto no cursor quanto, mais tarde, na tabela
    * SigMvItn (junto com EmpDopNums, que pertence ao cabecalho).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nItem)
    ENDPROC

    *====================================================================
    * LOOKUPS FISCAIS (FASE 6/8) - Classificacao Fiscal (SigCdClf) e CFOP
    * (SigCdCFO), chamados pelo Form a partir do LostFocus de
    * txt_4c_ClFiscals/txt_4c_DClFiscals e txt_4c__ccfop/txt_4c__dcfop.
    *====================================================================

    *====================================================================
    * BuscarClassificacaoFiscal - match EXATO por Codigos ou Descricaos
    * (par_cCampoBusca). Achando exatamente 1 registro, popula
    * this_cClFiscal/this_cDescrClFiscal/this_nBIcmsClFiscal e devolve
    * .T.; senao devolve .F. (o Form abre o picker).
    *====================================================================
    PROCEDURE BuscarClassificacaoFiscal(par_cCampoBusca, par_cValor)
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lAchou
        loc_cAlias = THIS.this_cCursorClf
        loc_lAchou = .F.

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Codigos, Descricaos, BIcms FROM SigCdClf WHERE " + ;
                   par_cCampoBusca + " = " + EscaparSQL(par_cValor)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) = 1
            SELECT (loc_cAlias)
            THIS.this_cClFiscal      = ALLTRIM(Codigos)
            THIS.this_cDescrClFiscal = ALLTRIM(Descricaos)
            THIS.this_nBIcmsClFiscal = NVL(BIcms, 0)
            loc_lAchou = .T.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *====================================================================
    * AplicarAliquotaIcmsAoCursor - aplica a NOVA aliquota/ICMS (ja
    * calculados pelo Form com o BIcms sugerido pela Classificacao Fiscal)
    * direto no cursor do form pai - equivalente a:
    *   Replace AliqIcms With CrListaRemota.BIcms in crTpmMvItn
    *   xValor = ( crTpmMvItn.BaseIcms * CrListaRemota.BIcms / 100 )
    *   Replace Icms With xValor in crTpmMvItn
    *   ThisForm.maniPulou = .t.
    * do Valid de getClFiscals/getDClFiscals.
    *====================================================================
    PROCEDURE AplicarAliquotaIcmsAoCursor(par_nAliqIcms, par_nIcms)
        LOCAL loc_cAlias
        loc_cAlias = THIS.this_cCursorItens

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem

        IF !FOUND()
            RETURN .F.
        ENDIF

        REPLACE AliqIcms WITH par_nAliqIcms, ;
                Icms     WITH par_nIcms ;
            IN (loc_cAlias)

        THIS.this_nAliqIcms  = par_nAliqIcms
        THIS.this_nIcms      = par_nIcms
        THIS.this_lManipulou = .T.

        RETURN .T.
    ENDPROC

    *====================================================================
    * AtualizarClassificacaoFiscalProduto - UPDATE SigCdPro.ClFiscals,
    * confirmado pelo usuario (MsgConfirma no Form). Equivalente a:
    *   Update SigCdPro Set ClFiscals = This.Value Where CPros = crTpmMvItn.CPros
    * do Valid de getClFiscals/getDClFiscals.
    *====================================================================
    PROCEDURE AtualizarClassificacaoFiscalProduto()
        LOCAL loc_cSQL, loc_nResultado

        loc_cSQL = "UPDATE SigCdPro SET ClFiscals = " + EscaparSQL(THIS.this_cClFiscal) + ;
                   " WHERE CPros = " + EscaparSQL(THIS.this_cProduto)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a Classifica" + CHR(231) + CHR(227) + "o Fiscal do Produto." + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        THIS.this_lAtualizouProduto = .T.
        RETURN .T.
    ENDPROC

    *====================================================================
    * BuscarCfop - match EXATO por Codigos ou Descricaos (par_cCampoBusca).
    * Achando exatamente 1 registro, popula this_cCfop/this_cDescrCfop e
    * as aliquotas/flags de tributacao usadas por AplicarCfopSelecionado();
    * senao devolve .F. (o Form abre o picker).
    *====================================================================
    PROCEDURE BuscarCfop(par_cCampoBusca, par_cValor)
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lAchou
        loc_cAlias = THIS.this_cCursorCfo
        loc_lAchou = .F.

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Codigos, Descricaos, aliqipis, aliqivcs, ipis, icms, " + ;
                   "aliqpis, aliqcofins, aliqii, aliqissqn " + ;
                   "FROM SigCdCFO WHERE " + par_cCampoBusca + " = " + EscaparSQL(par_cValor)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) = 1
            SELECT (loc_cAlias)
            THIS.this_cCfop           = ALLTRIM(Codigos)
            THIS.this_cDescrCfop      = ALLTRIM(Descricaos)
            THIS.this_nAliqIpiCfop    = NVL(aliqipis, 0)
            THIS.this_nAliqIcmsCfop   = NVL(aliqivcs, 0)
            THIS.this_cTribIpiCfop    = NVL(ipis, "")
            THIS.this_cTribIcmsCfop   = NVL(icms, "")
            THIS.this_nAliqPisCfop    = NVL(aliqpis, 0)
            THIS.this_nAliqCofinsCfop = NVL(aliqcofins, 0)
            THIS.this_nAliqIiCfop     = NVL(aliqii, 0)
            THIS.this_nAliqIssqnCfop  = NVL(aliqissqn, 0)
            loc_lAchou = .T.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *====================================================================
    * AplicarCfopSelecionado - rearma base de IPI/ICMS pela tributacao do
    * novo CFOP (letra 'T' em ipis/icms) contra o Total do item, troca a
    * aliquota de IPI/ICMS pela do CFOP e recalcula ValIpis/Icms com a
    * NOVA base e a NOVA aliquota - transcrito do legado (regra #17):
    *   IF crListaRemota.ipis <> 'T' / get_bIPI = 0 / ELSE / get_bIPI = Total
    *   IF crListaRemota.icms <> 'T' / get_bicm = 0 / ELSE / get_bicm = Total
    *   Replace BaseIcms/BcIpis com esses valores
    *   Replace cfops With o CFOP escolhido
    *   get_pIPI.Value = aliqipis -> get_pIPI.Valid (Aliqs = Value; SE
    *     Aliqs <> 0, ValIpis = BcIpis(NOVO) * Aliqs / 100 - mantem o valor
    *     anterior quando a aliquota vem zerada, igual ao legado)
    *   get_pICM.Value = aliqivcs -> get_pICM.Valid (AliqIcms = Value;
    *     Icms = BaseIcms(NOVO) * AliqIcms / 100 - SEMPRE recalculado)
    *====================================================================
    PROCEDURE AplicarCfopSelecionado()
        LOCAL loc_cAlias, loc_nBcIpi, loc_nBaseIcms, loc_nValIpi, loc_nIcms

        loc_cAlias = THIS.this_cCursorItens
        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        LOCATE FOR cItens = THIS.this_nItem
        IF !FOUND()
            RETURN .F.
        ENDIF

        loc_nBcIpi    = IIF(THIS.this_cTribIpiCfop  == "T", THIS.this_nTotal, 0)
        loc_nBaseIcms = IIF(THIS.this_cTribIcmsCfop == "T", THIS.this_nTotal, 0)

        loc_nValIpi = THIS.this_nValIpi
        IF THIS.this_nAliqIpiCfop <> 0
            loc_nValIpi = ROUND(loc_nBcIpi * THIS.this_nAliqIpiCfop / 100, 2)
        ENDIF
        loc_nIcms = ROUND(loc_nBaseIcms * THIS.this_nAliqIcmsCfop / 100, 2)

        REPLACE BcIpis   WITH loc_nBcIpi, ;
                BaseIcms WITH loc_nBaseIcms, ;
                Aliqs    WITH THIS.this_nAliqIpiCfop, ;
                ValIpis  WITH loc_nValIpi, ;
                AliqIcms WITH THIS.this_nAliqIcmsCfop, ;
                Icms     WITH loc_nIcms, ;
                cfops    WITH THIS.this_cCfop ;
            IN (loc_cAlias)

        THIS.this_nBcIpi     = loc_nBcIpi
        THIS.this_nBaseIcms  = loc_nBaseIcms
        THIS.this_nAliqIpi   = THIS.this_nAliqIpiCfop
        THIS.this_nValIpi    = loc_nValIpi
        THIS.this_nAliqIcms  = THIS.this_nAliqIcmsCfop
        THIS.this_nIcms      = loc_nIcms
        THIS.this_lManipulou = .T.

        RETURN .T.
    ENDPROC


    *====================================================================
    * CarregarContextoDoProduto - transcreve as consultas de CONTEXTO que
    * o Init legado roda depois de preencher os campos de imposto. Sao
    * tres no dump; duas estao aqui e a terceira (CFOP) eh o BuscarCfop()
    * acima, que ja seleciona as MESMAS colunas e mais as aliquotas de
    * IPI/ICMS usadas por AplicarCfopSelecionado():
    *
    *   1) Classificacao Fiscal DO PRODUTO
    *      lcQuery = [Select a.ClFiscals, b.Descricaos ] + ;
    *                  [From SigCdPro a, SigCdClf b ] + ;
    *                 [Where a.CPros = '] + crTpmMvItn.CPros + [' And ] + ;
    *                       [a.ClFiscals = b.Codigos]
    *      If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalClf]) < 1)
    *          =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
    *          Return .f.
    *      EndIf
    *
    *   3) Grupo do produto (habilita os impostos de SERVICO - o When de
    *      getVIrrf/getVInss/getVCssl/getVIss do legado eh
    *      "Return LocalGrp.servicos = 1")
    *      lcQuery = [Select b.servicos From sigcdpro a, SigCdGRP b ] + ;
    *                [Where a.cpros = '] + crTpmMvItn.cpros + ;
    *                [' and a.cgrus = b.cgrus]
    *
    * O "< 1" do legado eh falha de EXECUCAO, NAO lista vazia: o
    * SqlExecute de classes\sigclcnx.PRG (linha 279) devolve o retorno CRU
    * do SQLEXEC do VFP (1 = ok, -1/-2 = erro), entao zero linha nao
    * aborta nada - produto sem classificacao casada so deixa os campos
    * em branco, igual ao legado. Por isso a guarda aqui eh
    * "loc_nResultado < 1" e nao RECCOUNT = 0.
    *
    * UNICO desvio, registrado: "a.cgrus" entra no SELECT da consulta 3
    * (o legado le so "b.servicos") para alimentar this_cGrupoProduto, que
    * ja esta declarada neste BO. Eh o MESMO join, sem filtro novo e sem
    * regra nova - nenhum valor calculado foi inventado (regra #17).
    *
    * Sem RETURN dentro do TRY (regra #1): a flag loc_lSucesso carrega o
    * resultado e o unico RETURN fica depois do ENDTRY.
    *====================================================================
    PROCEDURE CarregarContextoDoProduto()
        LOCAL loc_cAlias, loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cProduto)
                THIS.this_cMensagemErro = "Produto do item n" + CHR(227) + ;
                    "o carregado - contexto fiscal n" + CHR(227) + "o pode ser lido"
                MsgErro(THIS.this_cMensagemErro, "SigOpImpBO.CarregarContextoDoProduto")
            ELSE
                *-- Consulta 1: Classificacao Fiscal do produto
                loc_cAlias = THIS.this_cCursorClf
                IF USED(loc_cAlias)
                    USE IN (loc_cAlias)
                ENDIF

                loc_cSQL = "SELECT a.ClFiscals, b.Descricaos" + ;
                           "  FROM SigCdPro a, SigCdClf b" + ;
                           " WHERE a.CPros = " + EscaparSQL(THIS.this_cProduto) + ;
                           "   AND a.ClFiscals = b.Codigos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (Classifica" + CHR(231) + CHR(227) + "o Fiscal)" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF RECCOUNT(loc_cAlias) > 0
                        SELECT (loc_cAlias)
                        GO TOP
                        THIS.this_cClFiscal      = ALLTRIM(TratarNulo(ClFiscals, ""))
                        THIS.this_cDescrClFiscal = ALLTRIM(TratarNulo(Descricaos, ""))
                    ELSE
                        THIS.this_cClFiscal      = ""
                        THIS.this_cDescrClFiscal = ""
                    ENDIF

                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF

                    *-- Consulta 3: grupo do produto (flag de servico)
                    loc_cAlias = THIS.this_cCursorGrp
                    IF USED(loc_cAlias)
                        USE IN (loc_cAlias)
                    ENDIF

                    loc_cSQL = "SELECT a.cgrus, b.servicos" + ;
                               "  FROM SigCdPro a, SigCdGrp b" + ;
                               " WHERE a.cpros = " + EscaparSQL(THIS.this_cProduto) + ;
                               "   AND a.cgrus = b.cgrus"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (Grupo do Produto)" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF RECCOUNT(loc_cAlias) > 0
                            SELECT (loc_cAlias)
                            GO TOP
                            THIS.this_cGrupoProduto = ALLTRIM(TratarNulo(cgrus, ""))
                            *-- servicos eh numeric(1,0) no schema, mas o driver
                            *-- pode devolver Logico para coluna de 1 digito -
                            *-- testar VARTYPE antes de comparar (regra #13).
                            IF VARTYPE(servicos) = "N"
                                THIS.this_nServicosGrupo = NVL(servicos, 0)
                            ELSE
                                THIS.this_nServicosGrupo = IIF(NVL(servicos, .F.), 1, 0)
                            ENDIF
                        ELSE
                            THIS.this_cGrupoProduto  = ""
                            THIS.this_nServicosGrupo = 0
                        ENDIF

                        IF USED(loc_cAlias)
                            USE IN (loc_cAlias)
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpImpBO.CarregarContextoDoProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AplicarRecalculoBase - FASE 8/8. Transcricao do Valid de getVBc
    * (regra #17 - formula literal), disparado quando o usuario altera a
    * Base dos Demais Impostos (BC Imps). O legado recalcula PIS/COFINS/
    * II/ISS/IRRF/INSS/CSSL usando, PARA CADA imposto, a aliquota do CFOP
    * (LocalCfo.aliq*) e, so quando ela vem ZERADA, cai para
    * FSigOpFin_imp(conta, '', '<IMPOSTO>', poDataMgr) - aliquota por
    * CONTA. Para IRRF/INSS/CSSL o legado NUNCA tem aliquota de CFOP (o
    * lnAli local comeca sempre em 0), entao esses tres SEMPRE dependeriam
    * de FSigOpFin_imp.
    *
    * FSigOpFin_imp eh funcao GLOBAL do legado (SIGFUNCS.PRG) que NAO veio
    * no acervo, e devolve um VALOR DE CALCULO (a aliquota configurada por
    * conta) - regra #27 probe exatamente este caso: "funcao ausente que
    * devolve valor de calculo fica AUSENTE, nunca substituida por stub
    * zerado" (stub 0% gravaria imposto errado em silencio - mais grave
    * que a ausencia aparecer). Por isso este metodo:
    *   - recalcula o que PODE ser calculado so com a aliquota do CFOP
    *     (ja carregada por BuscarCfop/AplicarCfopSelecionado), quando ela
    *     eh diferente de zero;
    *   - quando a aliquota do CFOP eh zero (ou o imposto eh um dos tres
    *     que nunca tem aliquota de CFOP), NAO grava 0% por conta propria -
    *     deixa o valor anterior do imposto e acrescenta o nome dele em
    *     this_cAliquotasIndisponiveis, para o Form avisar o usuario UMA
    *     vez so (regra #27 - ausencia REPORTADA, nunca silenciosa).
    *
    * ISS so entra quando o grupo do produto eh de servico (servicos = 1),
    * exatamente como o legado (Replace iss With Iif(LocalGrp.servicos=1,
    * ..., 0)); IRRF/INSS/CSSL seguem a mesma guarda.
    *====================================================================
    PROCEDURE AplicarRecalculoBase()
        LOCAL loc_nBase, loc_cIndisponiveis
        loc_nBase = THIS.this_nValBase
        loc_cIndisponiveis = ""

        *-- PIS
        IF THIS.this_nAliqPisCfop <> 0
            THIS.this_nVPis = ROUND(loc_nBase * THIS.this_nAliqPisCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "PIS, "
        ENDIF

        *-- COFINS
        IF THIS.this_nAliqCofinsCfop <> 0
            THIS.this_nVCofins = ROUND(loc_nBase * THIS.this_nAliqCofinsCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "COFINS, "
        ENDIF

        *-- II (imposto de importacao)
        IF THIS.this_nAliqIiCfop <> 0
            THIS.this_nTaxaIi = ROUND(loc_nBase * THIS.this_nAliqIiCfop / 100, 2)
        ELSE
            loc_cIndisponiveis = loc_cIndisponiveis + "II, "
        ENDIF

        *-- ISS (so quando o grupo do produto eh de servico)
        IF THIS.this_nServicosGrupo = 1
            IF THIS.this_nAliqIssqnCfop <> 0
                THIS.this_nIss = ROUND(loc_nBase * THIS.this_nAliqIssqnCfop / 100, 2)
            ELSE
                loc_cIndisponiveis = loc_cIndisponiveis + "ISS, "
            ENDIF
        ELSE
            THIS.this_nIss = 0
        ENDIF

        *-- IRRF / INSS / CSSL - o legado nunca tem aliquota de CFOP para
        *-- estes tres (lnAli comeca em 0 e so FSigOpFin_imp poderia
        *-- supri-lo) - sempre indisponivel quando o grupo eh de servico.
        IF THIS.this_nServicosGrupo = 1
            loc_cIndisponiveis = loc_cIndisponiveis + "IRRF, INSS, CSSL, "
        ELSE
            THIS.this_nIrrf = 0
            THIS.this_nInss = 0
            THIS.this_nCssl = 0
        ENDIF

        IF RIGHT(loc_cIndisponiveis, 2) = ", "
            loc_cIndisponiveis = LEFT(loc_cIndisponiveis, LEN(loc_cIndisponiveis) - 2)
        ENDIF
        THIS.this_cAliquotasIndisponiveis = loc_cIndisponiveis

        THIS.this_lManipulou = .T.
        RETURN .T.
    ENDPROC
ENDDEFINE
