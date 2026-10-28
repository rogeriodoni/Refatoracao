*==============================================================================
* sigopcgpBO.prg - Business Object para Consulta Global de Produtos
* Origem: SIGOPCGP.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgpBO AS BusinessBase

    *-- Controle de fluxo (equivalentes as propriedades/vars do form legado)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_cProdutoAtual      = ""    && _Produto - produto corrente (crTSigPro.cpros) na Pagina Resultado
    this_lAlteraPreco       = .F.   && ThisForm.AlteraPreco - fluxo de alteracao de preco (Do Form SigCdPro)
    this_lPrEca             = .F.   && par_prEca recebido no Init do form legado (fluxo iniciado por outra tela)
    this_nTpCalcp           = 0     && ThisForm.Tpcalcp - tipo de calculo de preco em uso
    this_cComposiciona      = ""    && ThisForm.Composiciona - grupo de composicao corrente
    this_lRetornoCj         = .F.   && ThisForm.RetornoCj - retorno do dialogo de conjuge (Do Form SigOpCcj)
    this_cEmpOperas         = ""    && ThisForm.EmpOperas - empresa selecionada para a faixa de operacao
    this_lUsuarioRestrito   = .F.   && ThisForm.llUser - restringe edicao de imagem/preco por tipo de usuario

    *-- Filtro: Produto (faixa de codigo + descricoes)
    this_cProdutoInicial = ""    && Get_produto_inicial - SigCdPro.cpros (faixa - inicio)
    this_cProdutoFinal   = ""    && Get_produto_final   - SigCdPro.cpros (faixa - fim)
    this_cDescricao      = ""    && Get_descricao       - SigCdPro.dpros (contem)
    this_cDescritivo     = ""    && Get_Descritivo      - SigCdPro.descritivo (contem)
    this_cDCompl         = ""    && Get_DCompl          - descricao completa (contem)
    this_cEquivalente    = ""    && getEquivalente      - SigCdPro.cpros do produto equivalente
    this_nBarra          = 0     && Get_Barra           - codigo de barras (SigCdPro.cbars)
    this_lEquivalentes   = .F.   && chkEquivalentes     - .T. = inclui produtos equivalentes na busca

    *-- Filtro: Grupo / Subgrupo / Grande Grupo / Linha / Colecao
    this_cCdGrupo    = ""    && get_cd_grupo  - SigCdGrp.cgrus
    this_cDsGrupo    = ""    && get_ds_grupo  - SigCdGrp.dgrus (preenchido pelo lookup)
    this_cCdSGrupo   = ""    && get_cd_sgrupo - SigCdPsg.codigos (subgrupo do grupo acima)
    this_cDsSGrupo   = ""    && get_ds_sgrupo - SigCdPsg.descricaos (preenchido pelo lookup)
    this_cGde        = ""    && Get_gde       - SigCdGpr.codigos (grande grupo)
    this_cLinhaI     = ""    && GetLin        - SigCdLin.linhas (faixa - inicio)
    this_cLinhaF     = ""    && GetLin2       - SigCdLin.linhas (faixa - fim)
    this_cColecaoI   = ""    && GetCol        - SigCdCol.colecoes (faixa - inicio)
    this_cColecaoF   = ""    && GetCol1       - SigCdCol.colecoes (faixa - fim)

    *-- Filtro: Peso / Cor / Tamanho / Dimensoes
    this_nPesoInicial = 0     && get_peso_inicial - SigCdPro.pesoms (faixa - inicio)
    this_nPesoFinal   = 0     && get_peso_final   - SigCdPro.pesoms (faixa - fim)
    this_cCor         = ""    && getCor      - SigCdCor.cods
    this_cDCor        = ""    && Get_dCor    - SigCdCor.descs (preenchido pelo lookup)
    this_cTam         = ""    && getTam      - SigCdTam.cods
    this_cDTam        = ""    && get_dTam    - SigCdTam.descs (preenchido pelo lookup)
    this_nTamProf     = 0     && get_tamps   - dimensao: profundidade
    this_nTamAlt      = 0     && get_tamas   - dimensao: altura
    this_nTamComp     = 0     && get_tamcs   - dimensao: comprimento

    *-- Filtro: Categoria / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de Valor
    this_cCategoria   = ""    && getCategoria   - SigCdCtg.cods
    this_cDCategoria  = ""    && getDCategoria  - SigCdCtg.descs (preenchido pelo lookup)
    this_cConjunto    = ""    && getConjunto    - codigo pai (SigCdPro.conjunts)
    this_cClasse      = ""    && get_cClass     - SigCdCls.cods
    this_cCodFinPI    = ""    && getCodFinP     - SigCdFip.cods (Modelo, faixa - inicio)
    this_cCodFinPF    = ""    && getCodFinPF    - SigCdFip.cods (Modelo, faixa - fim)
    this_cFxPreco     = ""    && getFxPreco     - SigCdPpc/SigCdPpi (faixa de valor do grupo)
    this_cLocais      = ""    && getLocals      - localizacao do produto
    this_cCodMacro    = ""    && getCodMacro    - codigo macro do produto

    *-- Filtro: CPF/CGC, Situacao, Imagem, Web
    this_cCPF          = ""    && Get_CPF   - CPF/CGC do cliente/fornecedor (faixa de operacao)
    this_cSituacao     = ""    && cmbSituas  - situacao do produto (RowSource)
    this_cImagem       = ""    && cmbImagem  - filtro por presenca de imagem (RowSource)
    this_nProdutoWeb   = 0     && optWebs    - indice do OptionGroup (5 opcoes) - produto web
    this_lOff          = .F.   && chkOff     - produto fora de linha / inativo no site

    *-- Filtro: Fornecedor / Referencia / Lista de Precos / Promocao
    this_cCdFornecedor   = ""    && get_cd_fornecedor  - SigCdCli.iclis (fAcessoContas)
    this_cDsFornecedor   = ""    && get_ds_fornecedor  - SigCdCli.rclis (preenchido pelo lookup)
    this_cRefFornecedor  = ""    && get_ref_fornecedor - SigCdPro.reffs (faixa - inicio)
    this_cRefFornecedorF = ""    && Get_ReffsF         - SigCdPro.reffs (faixa - fim)
    this_nTpReffs        = 0     && Opt_TpReffs        - indice do OptionGroup (3 opcoes)
    this_cLista          = ""    && Get_Lista          - SigCdLpc.lprecos
    this_cPromo          = ""    && get_promo          - SigPrPmc.promos

    *-- Filtro: Faixas de valor (custo / estimado / venda) + moeda
    this_nCustoInicial    = 0     && get_custo_inicial    - faixa de custo (inicio)
    this_nCustoFinal      = 0     && get_custo_final      - faixa de custo (fim)
    this_cMoeCusto        = ""    && get_moe_custo        - SigCdMoe.cmoes
    this_nEstimadoInicial = 0     && get_estimado_inicial - faixa de valor estimado (inicio)
    this_nEstimadoFinal   = 0     && get_estimado_final   - faixa de valor estimado (fim)
    this_cMoeEstimado     = ""    && get_moe_estimado     - SigCdMoe.cmoes
    this_nVendaInicial    = 0     && get_venda_inicial    - faixa de preco de venda (inicio)
    this_nVendaFinal      = 0     && get_venda_final      - faixa de preco de venda (fim)
    this_cMoeVenda        = ""    && get_moe_venda        - SigCdMoe.cmoes

    *-- Filtro: Empresa / Operacao / Periodo
    this_cEmpresa      = ""    && getEmps    - SigCdEmp.cemps
    this_cDEmpresa     = ""    && getDEmps   - SigCdEmp.razas (preenchido pelo lookup)
    this_cEmpresaOpe   = ""    && getEmpsO   - SigCdEmp.cemps (faixa de operacao)
    this_cOperacaoI    = ""    && Get_Operacaoi - SigCdOpe.dopes (faixa - inicio)
    this_cOperacaoF    = ""    && Get_Operacao  - SigCdOpe.dopes (faixa - fim)
    this_nTipoOperacao = 0     && OptOperacao   - indice do OptionGroup (3 opcoes)
    this_nTipoData     = 0     && OptTpData     - indice do OptionGroup (2 opcoes) - Dt. Operacao / Dt. Cadastro
    this_nTipoDataCad  = 0     && OptTpDtCad    - indice do OptionGroup (2 opcoes) - Inclusao / Alteracao
    this_nFormaPagto   = 0     && OptPagamento  - indice do OptionGroup (3 opcoes)
    this_lMarcaTOpe    = .F.   && ck_MarcaTOpe  - marca/desmarca todos os tipos de operacao da grade
    this_dDtOperacaoI  = {}    && get_dt_inicial - faixa de data de operacao (inicio)
    this_dDtOperacaoF  = {}    && get_dt_final   - faixa de data de operacao (fim)
    this_dDtAlteracaoI = {}    && getDtAltI      - faixa de data de alteracao (inicio)
    this_dDtAlteracaoF = {}    && getDtAltF      - faixa de data de alteracao (fim)

    *-- Filtro: Grupo/Conta Contabil (C.C. relacionado) e Conta de Origem/Destino do movimento
    this_cCdGrupoContab = ""    && get_Grupo   - SigCdCrg.ccargs (fAcessoContab)
    this_cDsGrupoContab = ""    && get_NGrupo  - descricao do grupo contabil (preenchido pelo lookup)
    this_cConta         = ""    && Get_Conta   - SigCdCli.iclis (fAcessoContas)
    this_cDConta        = ""    && Get_NConta  - SigCdCli.rclis (preenchido pelo lookup)
    this_cContaO        = ""    && get_ContaO  - SigCdCli.iclis (conta de origem/destino do movimento)
    this_cDContaO       = ""    && get_NContaO - SigCdCli.rclis (preenchido pelo lookup)

    *--------------------------------------------------------------------------
    * Init - este BO eh de CONSULTA customizada (SigOpCgp nao eh cadastro CRUD
    * de uma tabela so, e sim um painel que cruza SigCdPro com dezenas de
    * tabelas de apoio). this_cTabela/this_cCampoChave ficam com a entidade
    * central da consulta (Produtos), mas NAO sao passados a DODEFAULT():
    * BusinessBase.Init(pcTabela) so instanciaria um DataAccess generico sobre
    * SigCdPro, que este BO nao usa (as consultas sao todas via SQLEXEC).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o produto corrente a partir do cursor que
    * alimenta a grade de resultados (CrTSigPro/CrProdutos no legado). Este BO
    * eh de CONSULTA (SigOpCgp cruza SigCdPro com dezenas de tabelas de apoio
    * via SQLEXEC proprios de cada aba de resultado) - nao ha gravacao de
    * registro aqui, so o rastreio de qual produto esta em foco.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cProdutoAtual = TratarNulo(cpros, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigOpCgp eh consulta sobre SigCdPro; a chave do
    * registro em foco (usada so se algum fluxo chegar a chamar
    * RegistrarAuditoria) eh o codigo do produto corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cProdutoAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - SigOpCgp eh form de CONSULTA
    * (Consulta Global de Produtos): nenhum botao do legado grava SigCdPro por
    * aqui - alteracao e inclusao de produto abrem Do Form SigCdPro (FormProduto,
    * via BtnCadastroAlterar/btnProduto). A unica gravacao vista no dump
    * (Update SigCdPrf Set Obs em Pag_Resultado.Result.Fase.Get_Obs.LostFocus)
    * eh a observacao de fase de producao, que pertence ao metodo da propria
    * grade/aba Fase (fases seguintes desta migracao), nao a este trio. O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este BO.
    *--------------------------------------------------------------------------

ENDDEFINE
