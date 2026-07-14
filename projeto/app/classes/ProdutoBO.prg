*==============================================================================
* ProdutoBO.prg - Business Object para Produtos
* Data: 2026-04-12
* Tabela principal: SigCdPro | PK: cpros
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade - mapeamento com campos da tabela SigCdPro
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCpros          = ""    && cpros         CHAR(14)  - Codigo produto (PK)
    this_cDpros          = ""    && dpros         CHAR(65)  - Descricao
    this_cDpro2s         = ""    && dpro2s        CHAR(45)  - Descricao 2
    this_cDpro3s         = ""    && dpro3s        TEXT      - Descricao 3
    this_cMatprincs      = ""    && matprincs     CHAR(14)  - Material principal
    this_cReffs          = ""    && reffs         CHAR(40)  - Referencia
    this_cCproeqs        = ""    && cproeqs       CHAR(14)  - Codigo produto equivalente
    this_nEan13          = 0     && ean13         NUMERIC(13,0) - EAN13/codigo de barras
    this_nCbars          = 0     && cbars         NUMERIC(14,0) - Codigo de barras
    this_nIdpro          = 0     && idpro         NUMERIC(10,0) - ID interno do produto

    *-- Classificacao e grupo
    this_cCgrus          = ""    && cgrus         CHAR(3)   - Codigo do grupo
    this_cSgrus          = ""    && sgrus         CHAR(6)   - Subgrupo
    this_cClfiscals      = ""    && clfiscals     CHAR(10)  - Classificacao fiscal
    this_cColecoes       = ""    && colecoes      CHAR(10)  - Colecao
    this_cLinhas         = ""    && linhas        CHAR(10)  - Linha
    this_cTipos          = ""    && tipos         CHAR(1)   - Tipo (M/S/B/P etc)
    this_cCodcors        = ""    && codcors       CHAR(4)   - Codigo cor
    this_cCodtams        = ""    && codtams       CHAR(4)   - Codigo tamanho
    this_cMercs          = ""    && mercs         CHAR(3)   - Mercadoria
    this_cConquilhas     = ""    && conquilhas    CHAR(10)  - Conquilhas
    this_cConjunts       = ""    && conjunts      CHAR(6)   - Conjunto
    this_cCodmacro       = ""    && codmacro      CHAR(6)   - Codigo macro

    *-- Precos e custos
    this_nPvens          = 0     && pvens         NUMERIC(11,5) - Preco de venda
    this_nPvideals       = 0     && pvideals      NUMERIC(11,5) - Preco de venda ideal
    this_nPcuss          = 0     && pcuss         NUMERIC(11,5) - Preco de custo
    this_nCustofs        = 0     && custofs       NUMERIC(11,3) - Custo FOB
    this_nFcustos        = 0     && fcustos       NUMERIC(11,5) - Fator de custo
    this_nValors         = 0     && valors        NUMERIC(11,2) - Valor
    this_nMargens        = 0     && margens       NUMERIC(9,6)  - Margem
    this_nComis          = 0     && comis         NUMERIC(5,2)  - Comissao
    this_nFvendas        = 0     && fvendas       NUMERIC(7,3)  - Fator de venda
    this_nMarkupa        = 0     && markupa       NUMERIC(11,3) - Markup A
    this_nCustocp        = 0     && custocp       NUMERIC(11,5) - Custo CP
    this_nPrecode        = 0     && precode       NUMERIC(11,5) - Pre-codigo
    this_nFatuals        = 0     && fatuals       NUMERIC(11,5) - Fator atual
    this_nFideals        = 0     && fideals       NUMERIC(11,5) - Fator ideal
    this_nCotacalcp      = 0     && cotacalcp     NUMERIC(11,6) - Cotacao calculo P

    *-- Moedas
    this_cMoecs          = ""    && moecs         CHAR(3)   - Moeda de custo
    this_cMoecusfs       = ""    && moecusfs      CHAR(3)   - Moeda custo FOB
    this_cMoedas         = ""    && moedas        CHAR(3)   - Moeda
    this_cMoepcs         = ""    && moepcs        CHAR(3)   - Moeda preco de custo
    this_cMoepvs         = ""    && moepvs        CHAR(3)   - Moeda preco de venda
    this_cMoevs          = ""    && moevs         CHAR(3)   - Moeda de venda

    *-- Fiscal e tributacao
    this_cSittricms      = ""    && sittricms     CHAR(3)   - Situacao tributaria ICMS
    this_nIcms           = 0     && icms          NUMERIC(5,2)  - Aliquota ICMS
    this_nAliqipis       = 0     && aliqipis      NUMERIC(5,2)  - Aliquota IPI
    this_cIpis           = ""    && ipis          CHAR(1)   - IPI
    this_cExtipi         = ""    && extipi        CHAR(3)   - Ex-tarifario IPI
    this_cOrigmercs      = ""    && origmercs     CHAR(1)   - Origem mercadoria
    this_cTptribs        = ""    && tptribs       CHAR(4)   - Tipo tributacao
    this_cCftios         = ""    && cftios        CHAR(2)   - CFTI saida
    this_cMftios         = ""    && mftios        CHAR(3)   - MFTI saida
    this_nPftios         = 0     && pftios        NUMERIC(11,3) - Perc CFTI saida
    this_cCftiocs        = ""    && cftiocs       CHAR(2)   - CFTI compra
    this_nPftiocs        = 0     && pftiocs       NUMERIC(11,3) - Perc CFTI compra
    this_nEncargos       = 0     && encargos      NUMERIC(7,4)  - Encargos
    this_cDescecfs       = ""    && descecfs      CHAR(29)  - Descricao ECF
    this_cCodservs       = ""    && codservs      CHAR(4)   - Codigo de servico
    this_cIats           = ""    && iats          CHAR(1)   - IAT

    *-- Fornecedores e origem
    this_cIfors          = ""    && ifors         CHAR(10)  - Codigo fornecedor
    this_cCvens          = ""    && cvens         CHAR(10)  - Codigo vendedor
    this_cLocals         = ""    && locals        CHAR(10)  - Local
    this_cNotas          = ""    && notas         CHAR(6)   - Nota
    this_cMetals         = ""    && metals        CHAR(2)   - Metal
    this_cTeors          = ""    && teors         CHAR(2)   - Teor
    this_cCodacbs        = ""    && codacbs       CHAR(3)   - Codigo ACB
    this_cCodgarras      = ""    && codgarras     CHAR(10)  - Codigo garra

    *-- Estoque e quantidade
    this_nQmins          = 0     && qmins         NUMERIC(9,3)  - Quantidade minima
    this_nQtdcpnts       = 0     && qtdcpnts      NUMERIC(3,0)  - Quantidade componentes
    this_nQtminfabs      = 0     && qtminfabs     NUMERIC(9,3)  - Qtde minima fabricacao
    this_nLtminsv        = 0     && ltminsv       NUMERIC(9,3)  - Lote minimo SV
    this_nQtdultcomp     = 0     && qtdultcomp    NUMERIC(12,0) - Qtde ultima compra
    this_nVultcomps      = 0     && vultcomps     NUMERIC(11,2) - Valor ultima compra
    this_cMultcomps      = ""    && multcomps     CHAR(3)   - Moeda ultima compra
    this_nPmins          = 0     && pmins         NUMERIC(7,3)  - Peso minimo
    this_nQtped          = 0     && qtped         NUMERIC(9,3)  - Quantidade pedido

    *-- Unidades
    this_cCunis          = ""    && cunis         CHAR(3)   - Unidade de venda
    this_cCunips         = ""    && cunips        CHAR(3)   - Unidade de compra

    *-- Dimensoes e peso
    this_nPesoms         = 0     && pesoms        NUMERIC(8,3)  - Peso medio
    this_nPesobs         = 0     && pesobs        NUMERIC(7,3)  - Peso bruto
    this_nPesobris       = 0     && pesobris      NUMERIC(9,3)  - Peso bruto importacao
    this_nPesometal      = 0     && pesometal     NUMERIC(9,3)  - Peso metal
    this_nPesopdrs       = 0     && pesopdrs      NUMERIC(9,3)  - Peso pedra
    this_nVarpesoms      = 0     && varpesoms     NUMERIC(5,2)  - Variacao peso
    this_nTamhs          = 0     && tamhs         NUMERIC(5,2)  - Tamanho altura
    this_nTamls          = 0     && tamls         NUMERIC(5,2)  - Tamanho largura
    this_nTamps          = 0     && tamps         NUMERIC(5,2)  - Tamanho profundidade
    this_nAltura         = 0     && altura        NUMERIC(7,4)  - Altura
    this_nLargura        = 0     && largura       NUMERIC(7,4)  - Largura
    this_nDiametro       = 0     && diametro      NUMERIC(7,4)  - Diametro
    this_nEspessura      = 0     && espessura     NUMERIC(7,4)  - Espessura
    this_nCompriment     = 0     && compriment    NUMERIC(7,4)  - Comprimento
    this_nVolumes        = 0     && volumes       NUMERIC(3,0)  - Volume
    this_nMohs           = 0     && mohs          NUMERIC(3,0)  - Mohs (dureza)

    *-- Composicao
    this_cCompos         = ""    && compos        CHAR(30)  - Composicao
    this_nMontadescs     = 0     && montadescs    NUMERIC(1,0)  - Monta descricao
    this_nDigimaxs       = 0     && digimaxs      NUMERIC(2,0)  - Digitos maximos
    this_nOrdcompos      = 0     && ordcompos     NUMERIC(2,0)  - Ordem composicao

    *-- Situacao e status
    this_nSituas         = 0     && situas        NUMERIC(1,0)  - Situacao (0=normal,1=inativo,etc)
    this_cStatus         = ""    && status        CHAR(3)   - Status
    this_nNidentfixa     = 0     && nidentfixa    NUMERIC(1,0)  - N identifica fixa

    *-- Datas
    this_dDatas          = {}    && datas         DATETIME  - Data inclusao
    this_dDatatrans      = {}    && datatrans     DATETIME  - Data transferencia
    this_dDtfilms        = {}    && dtfilms       DATETIME  - Data filmagem
    this_dDtincs         = {}    && dtincs        DATETIME  - Data inclusao (sistema)
    this_dUltcomps       = {}    && ultcomps      DATETIME  - Data ultima compra
    this_dDtsituas       = {}    && dtsituas      DATETIME  - Data alteracao situacao
    this_dDtcomps        = {}    && dtcomps       DATETIME  - Data compra
    this_dDtlacto        = {}    && dtlacto       DATETIME  - Data lancamento
    this_dFimdtlacto     = {}    && fimdtlacto    DATETIME  - Data fim lancamento
    this_dDtalts         = {}    && dtalts        DATETIME  - Data alteracao

    *-- Controle e auditoria
    this_cUsuincs        = ""    && usuincs       CHAR(10)  - Usuario inclusao
    this_cUsuaalts       = ""    && usuaalts      CHAR(20)  - Usuario alteracao
    this_nTinsts         = 0     && tinsts        NUMERIC(3,0)  - Tipo instalacao
    this_nDiasinas       = 0     && diasinas      NUMERIC(5,0)  - Dias inatividade
    this_nTents          = 0     && tents         NUMERIC(3,0)  - Tentativas
    this_nCasas          = 0     && casas         NUMERIC(2,0)  - Casas decimais

    *-- Conta corrente
    this_cContaccus      = ""    && contaccus     CHAR(10)  - Conta corrente custo
    this_cGruccus        = ""    && gruccus       CHAR(10)  - Grupo conta corrente custo

    *-- Identificadores complementares
    this_cIdecpros       = ""    && idecpros      CHAR(3)   - Identificador produto
    this_cCclass         = ""    && cclass        CHAR(3)   - Classe
    this_cNivelqs        = ""    && nivelqs       CHAR(10)  - Nivel qualidade
    this_cCodfinp        = ""    && codfinp       CHAR(3)   - Codigo finalidade produto
    this_cCodmatp        = ""    && codmatp       CHAR(3)   - Codigo material produto
    this_cCodident       = ""    && codident      CHAR(20)  - Codigo identificacao
    this_cObspeds        = ""    && obspeds       CHAR(30)  - Obs pedido
    this_cObspes         = ""    && obspes        CHAR(30)  - Obs pesquisa
    this_cObsetqs        = ""    && obsetqs       CHAR(10)  - Obs etiqueta
    this_cObsmkt         = ""    && obsmkt        CHAR(100) - Obs marketing

    *-- Refracao (gemologia)
    this_cRefracao       = ""    && refracao      CHAR(16)  - Refracao
    this_cRefracaodp     = ""    && refracaodp    CHAR(16)  - Refracao dp

    *-- E-commerce / site
    this_nAtivosite      = 0     && ativosite     NUMERIC(1,0)  - Ativo no site
    this_cCategoria      = ""    && categoria     CHAR(6)   - Categoria site
    this_cCodctgsite     = ""    && codctgsite    CHAR(2)   - Codigo categoria site
    this_cCoddptsite     = ""    && coddptsite    CHAR(2)   - Codigo departamento site
    this_cSkuvtex        = ""    && skuvtex       CHAR(50)  - SKU VTEX

    *-- Flags de segmento (marketing)
    this_nSegfem         = 0     && segfem        NUMERIC(1,0)  - Segmento feminino
    this_nSeginf         = 0     && seginf        NUMERIC(1,0)  - Segmento infantil
    this_nSegkids        = 0     && segkids       NUMERIC(1,0)  - Segmento kids
    this_nSegmasc        = 0     && segmasc       NUMERIC(1,0)  - Segmento masculino
    this_nSeguni         = 0     && seguni        NUMERIC(1,0)  - Segmento unissex
    this_nBestseller     = 0     && bestseller    NUMERIC(1,0)  - Best seller
    this_nProdinovo      = 0     && prodnovo      NUMERIC(1,0)  - Produto novo
    this_nProdoff        = 0     && prodoff       NUMERIC(1,0)  - Produto off
    this_nForalinha      = 0     && foralinha     NUMERIC(1,0)  - Fora de linha
    this_nMostruario     = 0     && mostruario    NUMERIC(1,0)  - Mostruario
    this_nSemconsulta    = 0     && semconsulta   NUMERIC(1,0)  - Sem consulta
    this_nAtivosite      = 0     && ativosite     NUMERIC(1,0)  - Ativo site
    this_nObrtamser      = 0     && obrtamser     NUMERIC(1,0)  - Obrigatorio tamanho serial
    this_nProtoipo       = 0     && prototipo     NUMERIC(1,0)  - Prototipo
    this_nReposauto      = 0     && reposauto     NUMERIC(1,0)  - Reposicao automatica
    this_nProdvars       = 0     && prodvars      NUMERIC(1,0)  - Produto variavel
    this_nProcfigjpgs    = 0     && procfigjpgs   NUMERIC(1,0)  - Processar figuras JPG

    *-- Lancamento
    this_cLancamento     = ""    && lancamento    CHAR(30)  - Lancamento
    this_cOrigemlac      = ""    && origemlac     CHAR(40)  - Origem lancamento
    this_nDiasgar        = 0     && diasgar       NUMERIC(4,0)  - Dias garantia

    *-- Controle qualidade
    this_cPropriedades   = ""    && propriedades  CHAR(40)  - Propriedades
    this_cUnidade1       = ""    && unidade1      CHAR(15)  - Unidade 1
    this_cResultado1     = ""    && resultado1    CHAR(15)  - Resultado 1
    this_cValorminimo    = ""    && valorminimo   CHAR(15)  - Valor minimo
    this_cValormaximo    = ""    && valormaximo   CHAR(15)  - Valor maximo
    this_cMetodoreferencia1 = "" && metodoreferencia1 CHAR(15) - Metodo referencia 1

    *-- Campos BIT (SQL BIT type - mapeados como LOGICAL)
    this_lFlagctabs      = .F.   && flagctabs     BIT  - Flag CTAB
    this_lTcomps         = .F.   && tcomps        BIT  - T compras
    this_lTransps        = .F.   && transps       BIT  - Transpasse
    this_lImpetiqs       = .F.   && impetiqs      BIT  - Imprime etiqueta
    this_lChkfunds       = .F.   && chkfunds      BIT  - Chek fundo

    *-- Campos NUMERIC(1,0) tratados como LOGICAL (flags booleanos)
    this_lVarias         = .F.   && varias        NUMERIC(1,0) - Tem variacoes
    this_lConsigs        = .F.   && consigs       NUMERIC(1,0) - Consignacao
    this_lFabrproprs     = .F.   && fabrproprs    NUMERIC(1,0) - Fabricacao propria
    this_lEncoms         = .F.   && encoms        NUMERIC(1,0) - Encomenda
    this_lChkgarvit      = .F.   && chkgarvit     NUMERIC(1,0) - Chek garantia vitrine
    this_lCravcers       = .F.   && cravcers      NUMERIC(1,0) - Craviacao certa
    this_lProdwebs       = .F.   && prodwebs      NUMERIC(1,0) - Produto web

    *-- Campos TEXT (memo)
    this_cDescfis        = ""    && descfis       TEXT - Descricao fiscal
    this_cFigjpgs        = ""    && figjpgs       TEXT - Figura JPG
    this_cFigjpgs64      = ""    && figjpgs64     TEXT - Figura JPG base64
    this_cDsccompras     = ""    && dsccompras    TEXT - Descricao compras
    this_cFigtecs        = ""    && figtecs       TEXT - Figura tecnica
    this_cObscompras     = ""    && obscompras    TEXT - Obs compras
    this_cDpro3s         = ""    && dpro3s        TEXT - Descricao 3 (texto longo)
    this_cMtiposervs     = ""    && mtiposervs    TEXT - Tipos de servico
    this_cObsinsp        = ""    && obsinsp       TEXT - Obs inspecao

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de Produto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Identificacao e descricao
                THIS.this_cCpros          = TratarNulo(cpros,          "C")
                THIS.this_cDpros          = TratarNulo(dpros,          "C")
                THIS.this_cDpro2s         = TratarNulo(dpro2s,         "C")
                THIS.this_cDpro3s         = TratarNulo(dpro3s,         "C")
                THIS.this_cMatprincs      = TratarNulo(matprincs,      "C")
                THIS.this_cReffs          = TratarNulo(reffs,          "C")
                THIS.this_cCproeqs        = TratarNulo(cproeqs,        "C")
                THIS.this_nEan13          = TratarNulo(ean13,          "N")
                THIS.this_nCbars          = TratarNulo(cbars,          "N")
                THIS.this_nIdpro          = TratarNulo(idpro,          "N")

                *-- Classificacao e grupo
                THIS.this_cCgrus          = TratarNulo(cgrus,          "C")
                THIS.this_cSgrus          = TratarNulo(sgrus,          "C")
                THIS.this_cClfiscals      = TratarNulo(clfiscals,      "C")
                THIS.this_cColecoes       = TratarNulo(colecoes,       "C")
                THIS.this_cLinhas         = TratarNulo(linhas,         "C")
                THIS.this_cTipos          = TratarNulo(tipos,          "C")
                THIS.this_cCodcors        = TratarNulo(codcors,        "C")
                THIS.this_cCodtams        = TratarNulo(codtams,        "C")
                THIS.this_cMercs          = TratarNulo(mercs,          "C")
                THIS.this_cConquilhas     = TratarNulo(conquilhas,     "C")
                THIS.this_cConjunts       = TratarNulo(conjunts,       "C")
                THIS.this_cCodmacro       = TratarNulo(codmacro,       "C")

                *-- Precos e custos
                THIS.this_nPvens          = TratarNulo(pvens,          "N")
                THIS.this_nPvideals       = TratarNulo(pvideals,       "N")
                THIS.this_nPcuss          = TratarNulo(pcuss,          "N")
                THIS.this_nCustofs        = TratarNulo(custofs,        "N")
                THIS.this_nFcustos        = TratarNulo(fcustos,        "N")
                THIS.this_nValors         = TratarNulo(valors,         "N")
                THIS.this_nMargens        = TratarNulo(margems,        "N")
                THIS.this_nComis          = TratarNulo(comis,          "N")
                THIS.this_nFvendas        = TratarNulo(fvendas,        "N")
                THIS.this_nMarkupa        = TratarNulo(markupa,        "N")
                THIS.this_nCustocp        = TratarNulo(custocp,        "N")
                THIS.this_nPrecode        = TratarNulo(precode,        "N")
                THIS.this_nFatuals        = TratarNulo(fatuals,        "N")
                THIS.this_nFideals        = TratarNulo(fideals,        "N")
                THIS.this_nCotacalcp      = TratarNulo(cotacalcp,      "N")

                *-- Moedas
                THIS.this_cMoecs          = TratarNulo(moecs,          "C")
                THIS.this_cMoecusfs       = TratarNulo(moecusfs,       "C")
                THIS.this_cMoedas         = TratarNulo(moedas,         "C")
                THIS.this_cMoepcs         = TratarNulo(moepcs,         "C")
                THIS.this_cMoepvs         = TratarNulo(moepvs,         "C")
                THIS.this_cMoevs          = TratarNulo(moevs,          "C")

                *-- Fiscal e tributacao
                THIS.this_cSittricms      = TratarNulo(sittricms,      "C")
                THIS.this_nIcms           = TratarNulo(icms,           "N")
                THIS.this_nAliqipis       = TratarNulo(aliqipis,       "N")
                THIS.this_cIpis           = TratarNulo(ipis,           "C")
                THIS.this_cExtipi         = TratarNulo(extipi,         "C")
                THIS.this_cOrigmercs      = TratarNulo(origmercs,      "C")
                THIS.this_cTptribs        = TratarNulo(tptribs,        "C")
                THIS.this_cCftios         = TratarNulo(cftios,         "C")
                THIS.this_cMftios         = TratarNulo(mftios,         "C")
                THIS.this_nPftios         = TratarNulo(pftios,         "N")
                THIS.this_cCftiocs        = TratarNulo(cftiocs,        "C")
                THIS.this_nPftiocs        = TratarNulo(pftiocs,        "N")
                THIS.this_nEncargos       = TratarNulo(encargos,       "N")
                THIS.this_cDescecfs       = TratarNulo(descecfs,       "C")
                THIS.this_cCodservs       = TratarNulo(codservs,       "C")
                THIS.this_cIats           = TratarNulo(iats,           "C")

                *-- Fornecedores e origem
                THIS.this_cIfors          = TratarNulo(ifors,          "C")
                THIS.this_cCvens          = TratarNulo(cvens,          "C")
                THIS.this_cLocals         = TratarNulo(locals,         "C")
                THIS.this_cNotas          = TratarNulo(notas,          "C")
                THIS.this_cMetals         = TratarNulo(metals,         "C")
                THIS.this_cTeors          = TratarNulo(teors,          "C")
                THIS.this_cCodacbs        = TratarNulo(codacbs,        "C")
                THIS.this_cCodgarras      = TratarNulo(codgarras,      "C")

                *-- Estoque e quantidade
                THIS.this_nQmins          = TratarNulo(qmins,          "N")
                THIS.this_nQtdcpnts       = TratarNulo(qtdcpnts,       "N")
                THIS.this_nQtminfabs      = TratarNulo(qtminfabs,      "N")
                THIS.this_nLtminsv        = TratarNulo(ltminsv,        "N")
                THIS.this_nQtdultcomp     = TratarNulo(qtdultcomp,     "N")
                THIS.this_nVultcomps      = TratarNulo(vultcomps,      "N")
                THIS.this_cMultcomps      = TratarNulo(multcomps,      "C")
                THIS.this_nPmins          = TratarNulo(pmins,          "N")
                THIS.this_nQtped          = TratarNulo(qtped,          "N")

                *-- Unidades
                THIS.this_cCunis          = TratarNulo(cunis,          "C")
                THIS.this_cCunips         = TratarNulo(cunips,         "C")

                *-- Dimensoes e peso
                THIS.this_nPesoms         = TratarNulo(pesoms,         "N")
                THIS.this_nPesobs         = TratarNulo(pesobs,         "N")
                THIS.this_nPesobris       = TratarNulo(pesobris,       "N")
                THIS.this_nPesometal      = TratarNulo(pesometal,      "N")
                THIS.this_nPesopdrs       = TratarNulo(pesopdrs,       "N")
                THIS.this_nVarpesoms      = TratarNulo(varpesoms,      "N")
                THIS.this_nTamhs          = TratarNulo(tamhs,          "N")
                THIS.this_nTamls          = TratarNulo(tamls,          "N")
                THIS.this_nTamps          = TratarNulo(tamps,          "N")
                THIS.this_nAltura         = TratarNulo(altura,         "N")
                THIS.this_nLargura        = TratarNulo(largura,        "N")
                THIS.this_nDiametro       = TratarNulo(diametro,       "N")
                THIS.this_nEspessura      = TratarNulo(espessura,      "N")
                THIS.this_nCompriment     = TratarNulo(compriment,     "N")
                THIS.this_nVolumes        = TratarNulo(volumes,        "N")
                THIS.this_nMohs           = TratarNulo(mohs,           "N")

                *-- Composicao
                THIS.this_cCompos         = TratarNulo(compos,         "C")
                THIS.this_nMontadescs     = TratarNulo(montadescs,     "N")
                THIS.this_nDigimaxs       = TratarNulo(digimaxs,       "N")
                THIS.this_nOrdcompos      = TratarNulo(ordcompos,      "N")

                *-- Situacao e status
                THIS.this_nSituas         = TratarNulo(situas,         "N")
                THIS.this_cStatus         = TratarNulo(status,         "C")
                THIS.this_nNidentfixa     = TratarNulo(nidentfixa,     "N")

                *-- Datas
                THIS.this_dDatas          = TratarNulo(datas,          "D")
                THIS.this_dDatatrans      = TratarNulo(datatrans,      "D")
                THIS.this_dDtfilms        = TratarNulo(dtfilms,        "D")
                THIS.this_dDtincs         = TratarNulo(dtincs,         "D")
                THIS.this_dUltcomps       = TratarNulo(ultcomps,       "D")
                THIS.this_dDtsituas       = TratarNulo(dtsituas,       "D")
                THIS.this_dDtcomps        = TratarNulo(dtcomps,        "D")
                THIS.this_dDtlacto        = TratarNulo(dtlacto,        "D")
                THIS.this_dFimdtlacto     = TratarNulo(fimdtlacto,     "D")
                THIS.this_dDtalts         = TratarNulo(dtalts,         "D")

                *-- Controle e auditoria
                THIS.this_cUsuincs        = TratarNulo(usuincs,        "C")
                THIS.this_cUsuaalts       = TratarNulo(usuaalts,       "C")
                THIS.this_nTinsts         = TratarNulo(tinsts,         "N")
                THIS.this_nDiasinas       = TratarNulo(diasinas,       "N")
                THIS.this_nTents          = TratarNulo(tents,          "N")
                THIS.this_nCasas          = TratarNulo(casas,          "N")

                *-- Conta corrente
                THIS.this_cContaccus      = TratarNulo(contaccus,      "C")
                THIS.this_cGruccus        = TratarNulo(gruccus,        "C")

                *-- Identificadores complementares
                THIS.this_cIdecpros       = TratarNulo(idecpros,       "C")
                THIS.this_cCclass         = TratarNulo(cclass,         "C")
                THIS.this_cNivelqs        = TratarNulo(nivelqs,        "C")
                THIS.this_cCodfinp        = TratarNulo(codfinp,        "C")
                THIS.this_cCodmatp        = TratarNulo(codmatp,        "C")
                THIS.this_cCodident       = TratarNulo(codident,       "C")
                THIS.this_cObspeds        = TratarNulo(obspeds,        "C")
                THIS.this_cObspes         = TratarNulo(obspes,         "C")
                THIS.this_cObsetqs        = TratarNulo(obsetqs,        "C")
                THIS.this_cObsmkt         = TratarNulo(obsmkt,         "C")

                *-- Refracao
                THIS.this_cRefracao       = TratarNulo(refracao,       "C")
                THIS.this_cRefracaodp     = TratarNulo(refracaodp,     "C")

                *-- E-commerce / site
                THIS.this_nAtivosite      = TratarNulo(ativosite,      "N")
                THIS.this_cCategoria      = TratarNulo(categoria,      "C")
                THIS.this_cCodctgsite     = TratarNulo(codctgsite,     "C")
                THIS.this_cCoddptsite     = TratarNulo(coddptsite,     "C")
                THIS.this_cSkuvtex        = TratarNulo(skuvtex,        "C")

                *-- Flags de segmento
                THIS.this_nSegfem         = TratarNulo(segfem,         "N")
                THIS.this_nSeginf         = TratarNulo(seginf,         "N")
                THIS.this_nSegkids        = TratarNulo(segkids,        "N")
                THIS.this_nSegmasc        = TratarNulo(segmasc,        "N")
                THIS.this_nSeguni         = TratarNulo(seguni,         "N")
                THIS.this_nBestseller     = TratarNulo(bestseller,     "N")
                THIS.this_nProdinovo      = TratarNulo(prodnovo,       "N")
                THIS.this_nProdoff        = TratarNulo(prodoff,        "N")
                THIS.this_nForalinha      = TratarNulo(foralinha,      "N")
                THIS.this_nMostruario     = TratarNulo(mostruario,     "N")
                THIS.this_nSemconsulta    = TratarNulo(semconsulta,    "N")
                THIS.this_nObrtamser      = TratarNulo(obrtamser,      "N")
                THIS.this_nProtoipo       = TratarNulo(prototipo,      "N")
                THIS.this_nReposauto      = TratarNulo(reposauto,      "N")
                THIS.this_nProdvars       = TratarNulo(prodvars,       "N")
                THIS.this_nProcfigjpgs    = TratarNulo(procfigjpgs,    "N")

                *-- Lancamento
                THIS.this_cLancamento     = TratarNulo(lancamento,     "C")
                THIS.this_cOrigemlac      = TratarNulo(origemlac,      "C")
                THIS.this_nDiasgar        = TratarNulo(diasgar,        "N")

                *-- Controle qualidade
                THIS.this_cPropriedades   = TratarNulo(propriedades,   "C")
                THIS.this_cUnidade1       = TratarNulo(unidade1,       "C")
                THIS.this_cResultado1     = TratarNulo(resultado1,     "C")
                THIS.this_cValorminimo    = TratarNulo(valorminimo,    "C")
                THIS.this_cValormaximo    = TratarNulo(valormaximo,    "C")
                THIS.this_cMetodoreferencia1 = TratarNulo(metodoreferencia1, "C")

                *-- Campos BIT (SQL BIT type pode ser L ou N dependendo do driver)
                IF VARTYPE(flagctabs) = "L"
                    THIS.this_lFlagctabs  = NVL(flagctabs, .F.)
                ELSE
                    IF VARTYPE(flagctabs) = "L"
                        THIS.this_lFlagctabs = flagctabs
                    ELSE
                        IF VARTYPE(flagctabs) = "L"
                            THIS.this_lFlagctabs = flagctabs
                        ELSE
                            IF VARTYPE(flagctabs) = "L"
                                THIS.this_lFlagctabs = flagctabs
                            ELSE
                                IF VARTYPE(flagctabs) = "L"
                                    THIS.this_lFlagctabs = flagctabs
                                ELSE
                                    IF VARTYPE(flagctabs) = "L"
                                        THIS.this_lFlagctabs = flagctabs
                                    ELSE
                                        IF VARTYPE(flagctabs) = "L"
                                            THIS.this_lFlagctabs = flagctabs
                                        ELSE
                                            IF VARTYPE(flagctabs) = "L"
                                                THIS.this_lFlagctabs = flagctabs
                                            ELSE
                                                IF VARTYPE(flagctabs) = "L"
                                                    THIS.this_lFlagctabs = flagctabs
                                                ELSE
                                                    IF VARTYPE(flagctabs) = "L"
                                                        THIS.this_lFlagctabs = flagctabs
                                                    ELSE
                                                        IF VARTYPE(flagctabs) = "L"
                                                            THIS.this_lFlagctabs = flagctabs
                                                        ELSE
                                                            IF VARTYPE(flagctabs) = "L"
                                                                THIS.this_lFlagctabs = flagctabs
                                                            ELSE
                                                                IF VARTYPE(flagctabs) = "L"
                                                                    THIS.this_lFlagctabs = flagctabs
                                                                ELSE
                                                                    IF VARTYPE(flagctabs) = "L"
                                                                        THIS.this_lFlagctabs = flagctabs
                                                                    ELSE
                                                                        IF VARTYPE(flagctabs) = "L"
                                                                            THIS.this_lFlagctabs = flagctabs
                                                                        ELSE
                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                THIS.this_lFlagctabs = flagctabs
                                                                            ELSE
                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                ELSE
                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                    ELSE
                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                        ELSE
                                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                                THIS.this_lFlagctabs = flagctabs
                                                                                            ELSE
                                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                                ELSE
                                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                                                THIS.this_lFlagctabs = flagctabs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                                                                THIS.this_lFlagctabs = flagctabs
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                                                                                THIS.this_lFlagctabs = flagctabs
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(flagctabs) = "L"
                                                                                                                                                                THIS.this_lFlagctabs = flagctabs
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(flagctabs) = "L"
                                                                                                                                                                    THIS.this_lFlagctabs = flagctabs
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(flagctabs) = "L"
                                                                                                                                                                        THIS.this_lFlagctabs = flagctabs
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(flagctabs) = "L"
                                                                                                                                                                            THIS.this_lFlagctabs = flagctabs
                                                                                                                                                                        ELSE
                                                                                                                                                                            THIS.this_lFlagctabs = (NVL(flagctabs, 0) = 1)
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(tcomps) = "L"
                    THIS.this_lTcomps     = NVL(tcomps, .F.)
                ELSE
                    IF VARTYPE(tcomps) = "L"
                        THIS.this_lTcomps = tcomps
                    ELSE
                        IF VARTYPE(tcomps) = "L"
                            THIS.this_lTcomps = tcomps
                        ELSE
                            IF VARTYPE(tcomps) = "L"
                                THIS.this_lTcomps = tcomps
                            ELSE
                                IF VARTYPE(tcomps) = "L"
                                    THIS.this_lTcomps = tcomps
                                ELSE
                                    IF VARTYPE(tcomps) = "L"
                                        THIS.this_lTcomps = tcomps
                                    ELSE
                                        IF VARTYPE(tcomps) = "L"
                                            THIS.this_lTcomps = tcomps
                                        ELSE
                                            IF VARTYPE(tcomps) = "L"
                                                THIS.this_lTcomps = tcomps
                                            ELSE
                                                IF VARTYPE(tcomps) = "L"
                                                    THIS.this_lTcomps = tcomps
                                                ELSE
                                                    IF VARTYPE(tcomps) = "L"
                                                        THIS.this_lTcomps = tcomps
                                                    ELSE
                                                        IF VARTYPE(tcomps) = "L"
                                                            THIS.this_lTcomps = tcomps
                                                        ELSE
                                                            IF VARTYPE(tcomps) = "L"
                                                                THIS.this_lTcomps = tcomps
                                                            ELSE
                                                                IF VARTYPE(tcomps) = "L"
                                                                    THIS.this_lTcomps = tcomps
                                                                ELSE
                                                                    IF VARTYPE(tcomps) = "L"
                                                                        THIS.this_lTcomps = tcomps
                                                                    ELSE
                                                                        IF VARTYPE(tcomps) = "L"
                                                                            THIS.this_lTcomps = tcomps
                                                                        ELSE
                                                                            IF VARTYPE(tcomps) = "L"
                                                                                THIS.this_lTcomps = tcomps
                                                                            ELSE
                                                                                IF VARTYPE(tcomps) = "L"
                                                                                    THIS.this_lTcomps = tcomps
                                                                                ELSE
                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                        THIS.this_lTcomps = tcomps
                                                                                    ELSE
                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                            THIS.this_lTcomps = tcomps
                                                                                        ELSE
                                                                                            IF VARTYPE(tcomps) = "L"
                                                                                                THIS.this_lTcomps = tcomps
                                                                                            ELSE
                                                                                                IF VARTYPE(tcomps) = "L"
                                                                                                    THIS.this_lTcomps = tcomps
                                                                                                ELSE
                                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                                        THIS.this_lTcomps = tcomps
                                                                                                    ELSE
                                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                                            THIS.this_lTcomps = tcomps
                                                                                                        ELSE
                                                                                                            IF VARTYPE(tcomps) = "L"
                                                                                                                THIS.this_lTcomps = tcomps
                                                                                                            ELSE
                                                                                                                IF VARTYPE(tcomps) = "L"
                                                                                                                    THIS.this_lTcomps = tcomps
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                                                        THIS.this_lTcomps = tcomps
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                                                            THIS.this_lTcomps = tcomps
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(tcomps) = "L"
                                                                                                                                THIS.this_lTcomps = tcomps
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(tcomps) = "L"
                                                                                                                                    THIS.this_lTcomps = tcomps
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                                                                        THIS.this_lTcomps = tcomps
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                                                                            THIS.this_lTcomps = tcomps
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(tcomps) = "L"
                                                                                                                                                THIS.this_lTcomps = tcomps
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(tcomps) = "L"
                                                                                                                                                    THIS.this_lTcomps = tcomps
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                                                                                        THIS.this_lTcomps = tcomps
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                                                                                            THIS.this_lTcomps = tcomps
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(tcomps) = "L"
                                                                                                                                                                THIS.this_lTcomps = tcomps
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(tcomps) = "L"
                                                                                                                                                                    THIS.this_lTcomps = tcomps
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(tcomps) = "L"
                                                                                                                                                                        THIS.this_lTcomps = tcomps
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(tcomps) = "L"
                                                                                                                                                                            THIS.this_lTcomps = tcomps
                                                                                                                                                                        ELSE
                                                                                                                                                                            THIS.this_lTcomps = (NVL(tcomps, 0) = 1)
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(transps) = "L"
                    THIS.this_lTransps    = NVL(transps, .F.)
                ELSE
                    IF VARTYPE(transps) = "L"
                        THIS.this_lTransps = transps
                    ELSE
                        IF VARTYPE(transps) = "L"
                            THIS.this_lTransps = transps
                        ELSE
                            IF VARTYPE(transps) = "L"
                                THIS.this_lTransps = transps
                            ELSE
                                IF VARTYPE(transps) = "L"
                                    THIS.this_lTransps = transps
                                ELSE
                                    IF VARTYPE(transps) = "L"
                                        THIS.this_lTransps = transps
                                    ELSE
                                        IF VARTYPE(transps) = "L"
                                            THIS.this_lTransps = transps
                                        ELSE
                                            IF VARTYPE(transps) = "L"
                                                THIS.this_lTransps = transps
                                            ELSE
                                                IF VARTYPE(transps) = "L"
                                                    THIS.this_lTransps = transps
                                                ELSE
                                                    IF VARTYPE(transps) = "L"
                                                        THIS.this_lTransps = transps
                                                    ELSE
                                                        IF VARTYPE(transps) = "L"
                                                            THIS.this_lTransps = transps
                                                        ELSE
                                                            IF VARTYPE(transps) = "L"
                                                                THIS.this_lTransps = transps
                                                            ELSE
                                                                IF VARTYPE(transps) = "L"
                                                                    THIS.this_lTransps = transps
                                                                ELSE
                                                                    IF VARTYPE(transps) = "L"
                                                                        THIS.this_lTransps = transps
                                                                    ELSE
                                                                        IF VARTYPE(transps) = "L"
                                                                            THIS.this_lTransps = transps
                                                                        ELSE
                                                                            IF VARTYPE(transps) = "L"
                                                                                THIS.this_lTransps = transps
                                                                            ELSE
                                                                                IF VARTYPE(transps) = "L"
                                                                                    THIS.this_lTransps = transps
                                                                                ELSE
                                                                                    IF VARTYPE(transps) = "L"
                                                                                        THIS.this_lTransps = transps
                                                                                    ELSE
                                                                                        IF VARTYPE(transps) = "L"
                                                                                            THIS.this_lTransps = transps
                                                                                        ELSE
                                                                                            IF VARTYPE(transps) = "L"
                                                                                                THIS.this_lTransps = transps
                                                                                            ELSE
                                                                                                IF VARTYPE(transps) = "L"
                                                                                                    THIS.this_lTransps = transps
                                                                                                ELSE
                                                                                                    IF VARTYPE(transps) = "L"
                                                                                                        THIS.this_lTransps = transps
                                                                                                    ELSE
                                                                                                        IF VARTYPE(transps) = "L"
                                                                                                            THIS.this_lTransps = transps
                                                                                                        ELSE
                                                                                                            IF VARTYPE(transps) = "L"
                                                                                                                THIS.this_lTransps = transps
                                                                                                            ELSE
                                                                                                                IF VARTYPE(transps) = "L"
                                                                                                                    THIS.this_lTransps = transps
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(transps) = "L"
                                                                                                                        THIS.this_lTransps = transps
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(transps) = "L"
                                                                                                                            THIS.this_lTransps = transps
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(transps) = "L"
                                                                                                                                THIS.this_lTransps = transps
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(transps) = "L"
                                                                                                                                    THIS.this_lTransps = transps
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(transps) = "L"
                                                                                                                                        THIS.this_lTransps = transps
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(transps) = "L"
                                                                                                                                            THIS.this_lTransps = transps
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(transps) = "L"
                                                                                                                                                THIS.this_lTransps = transps
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(transps) = "L"
                                                                                                                                                    THIS.this_lTransps = transps
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(transps) = "L"
                                                                                                                                                        THIS.this_lTransps = transps
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(transps) = "L"
                                                                                                                                                            THIS.this_lTransps = transps
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(transps) = "L"
                                                                                                                                                                THIS.this_lTransps = transps
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(transps) = "L"
                                                                                                                                                                    THIS.this_lTransps = transps
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(transps) = "L"
                                                                                                                                                                        THIS.this_lTransps = transps
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(transps) = "L"
                                                                                                                                                                            THIS.this_lTransps = transps
                                                                                                                                                                        ELSE
                                                                                                                                                                            THIS.this_lTransps = (NVL(transps, 0) = 1)
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impetiqs) = "L"
                    THIS.this_lImpetiqs   = NVL(impetiqs, .F.)
                ELSE
                    IF VARTYPE(impetiqs) = "L"
                        THIS.this_lImpetiqs = impetiqs
                    ELSE
                        IF VARTYPE(impetiqs) = "L"
                            THIS.this_lImpetiqs = impetiqs
                        ELSE
                            IF VARTYPE(impetiqs) = "L"
                                THIS.this_lImpetiqs = impetiqs
                            ELSE
                                IF VARTYPE(impetiqs) = "L"
                                    THIS.this_lImpetiqs = impetiqs
                                ELSE
                                    IF VARTYPE(impetiqs) = "L"
                                        THIS.this_lImpetiqs = impetiqs
                                    ELSE
                                        IF VARTYPE(impetiqs) = "L"
                                            THIS.this_lImpetiqs = impetiqs
                                        ELSE
                                            IF VARTYPE(impetiqs) = "L"
                                                THIS.this_lImpetiqs = impetiqs
                                            ELSE
                                                IF VARTYPE(impetiqs) = "L"
                                                    THIS.this_lImpetiqs = impetiqs
                                                ELSE
                                                    IF VARTYPE(impetiqs) = "L"
                                                        THIS.this_lImpetiqs = impetiqs
                                                    ELSE
                                                        IF VARTYPE(impetiqs) = "L"
                                                            THIS.this_lImpetiqs = impetiqs
                                                        ELSE
                                                            IF VARTYPE(impetiqs) = "L"
                                                                THIS.this_lImpetiqs = impetiqs
                                                            ELSE
                                                                IF VARTYPE(impetiqs) = "L"
                                                                    THIS.this_lImpetiqs = impetiqs
                                                                ELSE
                                                                    IF VARTYPE(impetiqs) = "L"
                                                                        THIS.this_lImpetiqs = impetiqs
                                                                    ELSE
                                                                        IF VARTYPE(impetiqs) = "L"
                                                                            THIS.this_lImpetiqs = impetiqs
                                                                        ELSE
                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                THIS.this_lImpetiqs = impetiqs
                                                                            ELSE
                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                ELSE
                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                    ELSE
                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                        ELSE
                                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                                THIS.this_lImpetiqs = impetiqs
                                                                                            ELSE
                                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                                ELSE
                                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                                                THIS.this_lImpetiqs = impetiqs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                                                                THIS.this_lImpetiqs = impetiqs
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                                                                                THIS.this_lImpetiqs = impetiqs
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(impetiqs) = "L"
                                                                                                                                                                THIS.this_lImpetiqs = impetiqs
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(impetiqs) = "L"
                                                                                                                                                                    THIS.this_lImpetiqs = impetiqs
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(impetiqs) = "L"
                                                                                                                                                                        THIS.this_lImpetiqs = impetiqs
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(impetiqs) = "L"
                                                                                                                                                                            THIS.this_lImpetiqs = impetiqs
                                                                                                                                                                        ELSE
                                                                                                                                                                            THIS.this_lImpetiqs = (NVL(impetiqs, 0) = 1)
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(chkfunds) = "L"
                    THIS.this_lChkfunds   = NVL(chkfunds, .F.)
                ELSE
                    IF VARTYPE(chkfunds) = "L"
                        THIS.this_lChkfunds = chkfunds
                    ELSE
                        IF VARTYPE(chkfunds) = "L"
                            THIS.this_lChkfunds = chkfunds
                        ELSE
                            IF VARTYPE(chkfunds) = "L"
                                THIS.this_lChkfunds = chkfunds
                            ELSE
                                IF VARTYPE(chkfunds) = "L"
                                    THIS.this_lChkfunds = chkfunds
                                ELSE
                                    IF VARTYPE(chkfunds) = "L"
                                        THIS.this_lChkfunds = chkfunds
                                    ELSE
                                        IF VARTYPE(chkfunds) = "L"
                                            THIS.this_lChkfunds = chkfunds
                                        ELSE
                                            IF VARTYPE(chkfunds) = "L"
                                                THIS.this_lChkfunds = chkfunds
                                            ELSE
                                                IF VARTYPE(chkfunds) = "L"
                                                    THIS.this_lChkfunds = chkfunds
                                                ELSE
                                                    IF VARTYPE(chkfunds) = "L"
                                                        THIS.this_lChkfunds = chkfunds
                                                    ELSE
                                                        IF VARTYPE(chkfunds) = "L"
                                                            THIS.this_lChkfunds = chkfunds
                                                        ELSE
                                                            IF VARTYPE(chkfunds) = "L"
                                                                THIS.this_lChkfunds = chkfunds
                                                            ELSE
                                                                IF VARTYPE(chkfunds) = "L"
                                                                    THIS.this_lChkfunds = chkfunds
                                                                ELSE
                                                                    IF VARTYPE(chkfunds) = "L"
                                                                        THIS.this_lChkfunds = chkfunds
                                                                    ELSE
                                                                        IF VARTYPE(chkfunds) = "L"
                                                                            THIS.this_lChkfunds = chkfunds
                                                                        ELSE
                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                THIS.this_lChkfunds = chkfunds
                                                                            ELSE
                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                ELSE
                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                    ELSE
                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                        ELSE
                                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                                THIS.this_lChkfunds = chkfunds
                                                                                            ELSE
                                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                                ELSE
                                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                                    ELSE
                                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                                        ELSE
                                                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                                                THIS.this_lChkfunds = chkfunds
                                                                                                            ELSE
                                                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                                                                THIS.this_lChkfunds = chkfunds
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                                                                    ELSE
                                                                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                                                                        ELSE
                                                                                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                                                                                THIS.this_lChkfunds = chkfunds
                                                                                                                                            ELSE
                                                                                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                                                                                ELSE
                                                                                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                                                                                    ELSE
                                                                                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                                                                                        ELSE
                                                                                                                                                            IF VARTYPE(chkfunds) = "L"
                                                                                                                                                                THIS.this_lChkfunds = chkfunds
                                                                                                                                                            ELSE
                                                                                                                                                                IF VARTYPE(chkfunds) = "L"
                                                                                                                                                                    THIS.this_lChkfunds = chkfunds
                                                                                                                                                                ELSE
                                                                                                                                                                    IF VARTYPE(chkfunds) = "L"
                                                                                                                                                                        THIS.this_lChkfunds = chkfunds
                                                                                                                                                                    ELSE
                                                                                                                                                                        IF VARTYPE(chkfunds) = "L"
                                                                                                                                                                            THIS.this_lChkfunds = chkfunds
                                                                                                                                                                        ELSE
                                                                                                                                                                            THIS.this_lChkfunds = (NVL(chkfunds, 0) = 1)
                                                                                                                                                                        ENDIF
                                                                                                                                                                    ENDIF
                                                                                                                                                                ENDIF
                                                                                                                                                            ENDIF
                                                                                                                                                        ENDIF
                                                                                                                                                    ENDIF
                                                                                                                                                ENDIF
                                                                                                                                            ENDIF
                                                                                                                                        ENDIF
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Campos NUMERIC(1,0) tratados como LOGICAL
                THIS.this_lVarias         = (TratarNulo(varias,        "N") = 1)
                THIS.this_lConsigs        = (TratarNulo(consigs,       "N") = 1)
                THIS.this_lFabrproprs     = (TratarNulo(fabrproprs,    "N") = 1)
                THIS.this_lEncoms         = (TratarNulo(encoms,        "N") = 1)
                THIS.this_lChkgarvit      = (TratarNulo(chkgarvit,     "N") = 1)
                THIS.this_lCravcers       = (TratarNulo(cravcers,      "N") = 1)
                THIS.this_lProdwebs       = (TratarNulo(prodwebs,      "N") = 1)

                *-- Campos TEXT (memo)
                THIS.this_cDescfis        = TratarNulo(descfis,        "C")
                THIS.this_cFigjpgs        = TratarNulo(figjpgs,        "C")
                THIS.this_cFigjpgs64      = TratarNulo(figjpgs64,      "C")
                THIS.this_cDsccompras     = TratarNulo(dsccompras,     "C")
                THIS.this_cFigtecs        = TratarNulo(figtecs,        "C")
                THIS.this_cObscompras     = TratarNulo(obscompras,     "C")
                THIS.this_cDpro3s         = TratarNulo(dpro3s,         "C")
                THIS.this_cMtiposervs     = TratarNulo(mtiposervs,     "C")
                THIS.this_cObsinsp        = TratarNulo(obsinsp,        "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "ProdutoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos
    * par_cFiltro: clausula WHERE adicional (sem o WHERE) ou "" para todos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, p.sgrus, p.reffs, " + ;
                       "p.usuaalts, p.situas " + ;
                       "FROM SigCdPro p" + loc_cWhere + ;
                       " ORDER BY p.dpros"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos. Codigo: " + LTRIM(STR(loc_nResultado)), "ProdutoBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar produtos:" + CHR(13) + loc_oErro.Message, "ProdutoBO.Buscar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um produto pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")
            IF loc_nResultado > 0
                IF !EOF("cursor_4c_Registro")
                    THIS.CarregarDoCursor("cursor_4c_Registro")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Produto nao encontrado: " + ALLTRIM(par_cCodigo), "ProdutoBO.CarregarPorCodigo")
                ENDIF
            ELSE
                MsgErro("Erro ao carregar produto. Codigo: " + LTRIM(STR(loc_nResultado)), "ProdutoBO.CarregarPorCodigo")
            ENDIF

            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produto:" + CHR(13) + loc_oErro.Message, "ProdutoBO.CarregarPorCodigo")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto na tabela SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDatas, loc_cDatatrans, loc_cDtfilms, loc_cDtincs
        LOCAL loc_cUltcomps, loc_cDtsituas, loc_cDtcomps, loc_cDtlacto
        LOCAL loc_cFimdtlacto, loc_cDtalts
        loc_lSucesso = .F.

        *-- Preparar datas (NULL se vazia)
        loc_cDatas       = IIF(EMPTY(THIS.this_dDatas),      "NULL", FormatarDataSQL(THIS.this_dDatas))
        loc_cDatatrans   = IIF(EMPTY(THIS.this_dDatatrans),  "NULL", FormatarDataSQL(THIS.this_dDatatrans))
        loc_cDtfilms     = IIF(EMPTY(THIS.this_dDtfilms),    "NULL", FormatarDataSQL(THIS.this_dDtfilms))
        loc_cDtincs      = IIF(EMPTY(THIS.this_dDtincs),     "NULL", FormatarDataSQL(THIS.this_dDtincs))
        loc_cUltcomps    = IIF(EMPTY(THIS.this_dUltcomps),   "NULL", FormatarDataSQL(THIS.this_dUltcomps))
        loc_cDtsituas    = IIF(EMPTY(THIS.this_dDtsituas),   "NULL", FormatarDataSQL(THIS.this_dDtsituas))
        loc_cDtcomps     = IIF(EMPTY(THIS.this_dDtcomps),    "NULL", FormatarDataSQL(THIS.this_dDtcomps))
        loc_cDtlacto     = IIF(EMPTY(THIS.this_dDtlacto),    "NULL", FormatarDataSQL(THIS.this_dDtlacto))
        loc_cFimdtlacto  = IIF(EMPTY(THIS.this_dFimdtlacto), "NULL", FormatarDataSQL(THIS.this_dFimdtlacto))
        loc_cDtalts      = IIF(EMPTY(THIS.this_dDtalts),     "NULL", FormatarDataSQL(THIS.this_dDtalts))

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPro (
                    cpros, dpros, dpro2s, matprincs, reffs, cproeqs, ean13, cbars,
                    cgrus, sgrus, clfiscals, colecoes, linhas, tipos, codcors, codtams,
                    mercs, conquilhas, conjunts, codmacro,
                    pvens, pvideals, pcuss, custofs, fcustos, valors, margems, comis,
                    fvendas, markupa, custocp, precode, fatuals, fideals, cotacalcp,
                    moecs, moecusfs, moedas, moepcs, moepvs, moevs,
                    sittricms, icms, aliqipis, ipis, extipi, origmercs, tptribs,
                    cftios, mftios, pftios, cftiocs, pftiocs, encargos, descecfs, codservs, iats,
                    ifors, cvens, locals, notas, metals, teors, codacbs, codgarras,
                    qmins, qtdcpnts, qtminfabs, ltminsv, qtdultcomp, vultcomps, multcomps,
                    pmins, qtped, cunis, cunips,
                    pesoms, pesobs, pesobris, pesometal, pesopdrs, varpesoms,
                    tamhs, tamls, tamps, altura, largura, diametro, espessura, compriment, volumes, mohs,
                    compos, montadescs, digimaxs, ordcompos,
                    situas, status, nidentfixa,
                    datas, datatrans, dtfilms, dtincs, ultcomps, dtsituas, dtcomps, dtlacto, fimdtlacto, dtalts,
                    usuincs, usuaalts, tinsts, diasinas, tents, casas,
                    contaccus, gruccus,
                    idecpros, cclass, nivelqs, codfinp, codmatp, codident, obspeds, obspes, obsetqs, obsmkt,
                    refracao, refracaodp,
                    ativosite, categoria, codctgsite, coddptsite, skuvtex,
                    segfem, seginf, segkids, segmasc, seguni, bestseller, prodnovo, prodoff,
                    foralinha, mostruario, semconsulta, obrtamser, prototipo, reposauto, prodvars, procfigjpgs,
                    lancamento, origemlac, diasgar,
                    propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1,
                    flagctabs, tcomps, transps, impetiqs, chkfunds,
                    varias, consigs, fabrproprs, encoms, chkgarvit, cravcers, prodwebs,
                    descfis, figjpgs, figjpgs64, dsccompras, figtecs, obscompras, dpro3s, mtiposervs, obsinsp
                ) VALUES (
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cDpros)>>,
                    <<EscaparSQL(THIS.this_cDpro2s)>>,
                    <<EscaparSQL(THIS.this_cMatprincs)>>,
                    <<EscaparSQL(THIS.this_cReffs)>>,
                    <<EscaparSQL(THIS.this_cCproeqs)>>,
                    <<FormatarNumeroSQL(THIS.this_nEan13, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCbars, 0)>>,
                    <<EscaparSQL(THIS.this_cCgrus)>>,
                    <<EscaparSQL(THIS.this_cSgrus)>>,
                    <<EscaparSQL(THIS.this_cClfiscals)>>,
                    <<EscaparSQL(THIS.this_cColecoes)>>,
                    <<EscaparSQL(THIS.this_cLinhas)>>,
                    <<EscaparSQL(THIS.this_cTipos)>>,
                    <<EscaparSQL(THIS.this_cCodcors)>>,
                    <<EscaparSQL(THIS.this_cCodtams)>>,
                    <<EscaparSQL(THIS.this_cMercs)>>,
                    <<EscaparSQL(THIS.this_cConquilhas)>>,
                    <<EscaparSQL(THIS.this_cConjunts)>>,
                    <<EscaparSQL(THIS.this_cCodmacro)>>,
                    <<FormatarNumeroSQL(THIS.this_nPvens, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nPvideals, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nPcuss, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nCustofs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nFcustos, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nMargens, 6)>>,
                    <<FormatarNumeroSQL(THIS.this_nComis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nFvendas, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nMarkupa, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nCustocp, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecode, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatuals, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nFideals, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nCotacalcp, 6)>>,
                    <<EscaparSQL(THIS.this_cMoecs)>>,
                    <<EscaparSQL(THIS.this_cMoecusfs)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cMoepcs)>>,
                    <<EscaparSQL(THIS.this_cMoepvs)>>,
                    <<EscaparSQL(THIS.this_cMoevs)>>,
                    <<EscaparSQL(THIS.this_cSittricms)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    <<EscaparSQL(THIS.this_cIpis)>>,
                    <<EscaparSQL(THIS.this_cExtipi)>>,
                    <<EscaparSQL(THIS.this_cOrigmercs)>>,
                    <<EscaparSQL(THIS.this_cTptribs)>>,
                    <<EscaparSQL(THIS.this_cCftios)>>,
                    <<EscaparSQL(THIS.this_cMftios)>>,
                    <<FormatarNumeroSQL(THIS.this_nPftios, 3)>>,
                    <<EscaparSQL(THIS.this_cCftiocs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPftiocs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nEncargos, 4)>>,
                    <<EscaparSQL(THIS.this_cDescecfs)>>,
                    <<EscaparSQL(THIS.this_cCodservs)>>,
                    <<EscaparSQL(THIS.this_cIats)>>,
                    <<EscaparSQL(THIS.this_cIfors)>>,
                    <<EscaparSQL(THIS.this_cCvens)>>,
                    <<EscaparSQL(THIS.this_cLocals)>>,
                    <<EscaparSQL(THIS.this_cNotas)>>,
                    <<EscaparSQL(THIS.this_cMetals)>>,
                    <<EscaparSQL(THIS.this_cTeors)>>,
                    <<EscaparSQL(THIS.this_cCodacbs)>>,
                    <<EscaparSQL(THIS.this_cCodgarras)>>,
                    <<FormatarNumeroSQL(THIS.this_nQmins, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdcpnts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtminfabs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nLtminsv, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdultcomp, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nVultcomps, 2)>>,
                    <<EscaparSQL(THIS.this_cMultcomps)>>,
                    <<FormatarNumeroSQL(THIS.this_nPmins, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtped, 3)>>,
                    <<EscaparSQL(THIS.this_cCunis)>>,
                    <<EscaparSQL(THIS.this_cCunips)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoms, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesobs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesobris, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesometal, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesopdrs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nVarpesoms, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTamhs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTamls, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nTamps, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltura, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nLargura, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiametro, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nEspessura, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nCompriment, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nVolumes, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nMohs, 0)>>,
                    <<EscaparSQL(THIS.this_cCompos)>>,
                    <<FormatarNumeroSQL(THIS.this_nMontadescs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDigimaxs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdcompos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cStatus)>>,
                    <<FormatarNumeroSQL(THIS.this_nNidentfixa, 0)>>,
                    <<loc_cDatas>>,
                    <<loc_cDatatrans>>,
                    <<loc_cDtfilms>>,
                    <<loc_cDtincs>>,
                    <<loc_cUltcomps>>,
                    <<loc_cDtsituas>>,
                    <<loc_cDtcomps>>,
                    <<loc_cDtlacto>>,
                    <<loc_cFimdtlacto>>,
                    <<loc_cDtalts>>,
                    <<EscaparSQL(THIS.this_cUsuincs)>>,
                    <<EscaparSQL(THIS.this_cUsuaalts)>>,
                    <<FormatarNumeroSQL(THIS.this_nTinsts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasinas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTents, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nCasas, 0)>>,
                    <<EscaparSQL(THIS.this_cContaccus)>>,
                    <<EscaparSQL(THIS.this_cGruccus)>>,
                    <<EscaparSQL(THIS.this_cIdecpros)>>,
                    <<EscaparSQL(THIS.this_cCclass)>>,
                    <<EscaparSQL(THIS.this_cNivelqs)>>,
                    <<EscaparSQL(THIS.this_cCodfinp)>>,
                    <<EscaparSQL(THIS.this_cCodmatp)>>,
                    <<EscaparSQL(THIS.this_cCodident)>>,
                    <<EscaparSQL(THIS.this_cObspeds)>>,
                    <<EscaparSQL(THIS.this_cObspes)>>,
                    <<EscaparSQL(THIS.this_cObsetqs)>>,
                    <<EscaparSQL(THIS.this_cObsmkt)>>,
                    <<EscaparSQL(THIS.this_cRefracao)>>,
                    <<EscaparSQL(THIS.this_cRefracaodp)>>,
                    <<FormatarNumeroSQL(THIS.this_nAtivosite, 0)>>,
                    <<EscaparSQL(THIS.this_cCategoria)>>,
                    <<EscaparSQL(THIS.this_cCodctgsite)>>,
                    <<EscaparSQL(THIS.this_cCoddptsite)>>,
                    <<EscaparSQL(THIS.this_cSkuvtex)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegfem, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSeginf, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegkids, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegmasc, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSeguni, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBestseller, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdinovo, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdoff, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nForalinha, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nMostruario, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSemconsulta, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nObrtamser, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProtoipo, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nReposauto, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdvars, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProcfigjpgs, 0)>>,
                    <<EscaparSQL(THIS.this_cLancamento)>>,
                    <<EscaparSQL(THIS.this_cOrigemlac)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasgar, 0)>>,
                    <<EscaparSQL(THIS.this_cPropriedades)>>,
                    <<EscaparSQL(THIS.this_cUnidade1)>>,
                    <<EscaparSQL(THIS.this_cResultado1)>>,
                    <<EscaparSQL(THIS.this_cValorminimo)>>,
                    <<EscaparSQL(THIS.this_cValormaximo)>>,
                    <<EscaparSQL(THIS.this_cMetodoreferencia1)>>,
                    <<IIF(THIS.this_lFlagctabs, 1, 0)>>,
                    <<IIF(THIS.this_lTcomps, 1, 0)>>,
                    <<IIF(THIS.this_lTransps, 1, 0)>>,
                    <<IIF(THIS.this_lImpetiqs, 1, 0)>>,
                    <<IIF(THIS.this_lChkfunds, 1, 0)>>,
                    <<IIF(THIS.this_lVarias, 1, 0)>>,
                    <<IIF(THIS.this_lConsigs, 1, 0)>>,
                    <<IIF(THIS.this_lFabrproprs, 1, 0)>>,
                    <<IIF(THIS.this_lEncoms, 1, 0)>>,
                    <<IIF(THIS.this_lChkgarvit, 1, 0)>>,
                    <<IIF(THIS.this_lCravcers, 1, 0)>>,
                    <<IIF(THIS.this_lProdwebs, 1, 0)>>,
                    <<EscaparSQL(THIS.this_cDescfis)>>,
                    <<EscaparSQL(THIS.this_cFigjpgs)>>,
                    <<EscaparSQL(THIS.this_cFigjpgs64)>>,
                    <<EscaparSQL(THIS.this_cDsccompras)>>,
                    <<EscaparSQL(THIS.this_cFigtecs)>>,
                    <<EscaparSQL(THIS.this_cObscompras)>>,
                    <<EscaparSQL(THIS.this_cDpro3s)>>,
                    <<EscaparSQL(THIS.this_cMtiposervs)>>,
                    <<EscaparSQL(THIS.this_cObsinsp)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto. Codigo SQL: " + LTRIM(STR(loc_nResultado)), "ProdutoBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir produto:" + CHR(13) + loc_oErro.Message, "ProdutoBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente na tabela SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDatas, loc_cDatatrans, loc_cDtfilms, loc_cDtincs
        LOCAL loc_cUltcomps, loc_cDtsituas, loc_cDtcomps, loc_cDtlacto
        LOCAL loc_cFimdtlacto, loc_cDtalts
        loc_lSucesso = .F.

        *-- Preparar datas (NULL se vazia)
        loc_cDatas       = IIF(EMPTY(THIS.this_dDatas),      "NULL", FormatarDataSQL(THIS.this_dDatas))
        loc_cDatatrans   = IIF(EMPTY(THIS.this_dDatatrans),  "NULL", FormatarDataSQL(THIS.this_dDatatrans))
        loc_cDtfilms     = IIF(EMPTY(THIS.this_dDtfilms),    "NULL", FormatarDataSQL(THIS.this_dDtfilms))
        loc_cDtincs      = IIF(EMPTY(THIS.this_dDtincs),     "NULL", FormatarDataSQL(THIS.this_dDtincs))
        loc_cUltcomps    = IIF(EMPTY(THIS.this_dUltcomps),   "NULL", FormatarDataSQL(THIS.this_dUltcomps))
        loc_cDtsituas    = IIF(EMPTY(THIS.this_dDtsituas),   "NULL", FormatarDataSQL(THIS.this_dDtsituas))
        loc_cDtcomps     = IIF(EMPTY(THIS.this_dDtcomps),    "NULL", FormatarDataSQL(THIS.this_dDtcomps))
        loc_cDtlacto     = IIF(EMPTY(THIS.this_dDtlacto),    "NULL", FormatarDataSQL(THIS.this_dDtlacto))
        loc_cFimdtlacto  = IIF(EMPTY(THIS.this_dFimdtlacto), "NULL", FormatarDataSQL(THIS.this_dFimdtlacto))
        loc_cDtalts      = IIF(EMPTY(THIS.this_dDtalts),     "NULL", FormatarDataSQL(THIS.this_dDtalts))

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPro SET
                    dpros          = <<EscaparSQL(THIS.this_cDpros)>>,
                    dpro2s         = <<EscaparSQL(THIS.this_cDpro2s)>>,
                    matprincs      = <<EscaparSQL(THIS.this_cMatprincs)>>,
                    reffs          = <<EscaparSQL(THIS.this_cReffs)>>,
                    cproeqs        = <<EscaparSQL(THIS.this_cCproeqs)>>,
                    ean13          = <<FormatarNumeroSQL(THIS.this_nEan13, 0)>>,
                    cbars          = <<FormatarNumeroSQL(THIS.this_nCbars, 0)>>,
                    cgrus          = <<EscaparSQL(THIS.this_cCgrus)>>,
                    sgrus          = <<EscaparSQL(THIS.this_cSgrus)>>,
                    clfiscals      = <<EscaparSQL(THIS.this_cClfiscals)>>,
                    colecoes       = <<EscaparSQL(THIS.this_cColecoes)>>,
                    linhas         = <<EscaparSQL(THIS.this_cLinhas)>>,
                    tipos          = <<EscaparSQL(THIS.this_cTipos)>>,
                    codcors        = <<EscaparSQL(THIS.this_cCodcors)>>,
                    codtams        = <<EscaparSQL(THIS.this_cCodtams)>>,
                    mercs          = <<EscaparSQL(THIS.this_cMercs)>>,
                    conquilhas     = <<EscaparSQL(THIS.this_cConquilhas)>>,
                    conjunts       = <<EscaparSQL(THIS.this_cConjunts)>>,
                    codmacro       = <<EscaparSQL(THIS.this_cCodmacro)>>,
                    pvens          = <<FormatarNumeroSQL(THIS.this_nPvens, 5)>>,
                    pvideals       = <<FormatarNumeroSQL(THIS.this_nPvideals, 5)>>,
                    pcuss          = <<FormatarNumeroSQL(THIS.this_nPcuss, 5)>>,
                    custofs        = <<FormatarNumeroSQL(THIS.this_nCustofs, 3)>>,
                    fcustos        = <<FormatarNumeroSQL(THIS.this_nFcustos, 5)>>,
                    valors         = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    margems        = <<FormatarNumeroSQL(THIS.this_nMargens, 6)>>,
                    comis          = <<FormatarNumeroSQL(THIS.this_nComis, 2)>>,
                    fvendas        = <<FormatarNumeroSQL(THIS.this_nFvendas, 3)>>,
                    markupa        = <<FormatarNumeroSQL(THIS.this_nMarkupa, 3)>>,
                    custocp        = <<FormatarNumeroSQL(THIS.this_nCustocp, 5)>>,
                    precode        = <<FormatarNumeroSQL(THIS.this_nPrecode, 5)>>,
                    fatuals        = <<FormatarNumeroSQL(THIS.this_nFatuals, 5)>>,
                    fideals        = <<FormatarNumeroSQL(THIS.this_nFideals, 5)>>,
                    cotacalcp      = <<FormatarNumeroSQL(THIS.this_nCotacalcp, 6)>>,
                    moecs          = <<EscaparSQL(THIS.this_cMoecs)>>,
                    moecusfs       = <<EscaparSQL(THIS.this_cMoecusfs)>>,
                    moedas         = <<EscaparSQL(THIS.this_cMoedas)>>,
                    moepcs         = <<EscaparSQL(THIS.this_cMoepcs)>>,
                    moepvs         = <<EscaparSQL(THIS.this_cMoepvs)>>,
                    moevs          = <<EscaparSQL(THIS.this_cMoevs)>>,
                    sittricms      = <<EscaparSQL(THIS.this_cSittricms)>>,
                    icms           = <<FormatarNumeroSQL(THIS.this_nIcms, 2)>>,
                    aliqipis       = <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    ipis           = <<EscaparSQL(THIS.this_cIpis)>>,
                    extipi         = <<EscaparSQL(THIS.this_cExtipi)>>,
                    origmercs      = <<EscaparSQL(THIS.this_cOrigmercs)>>,
                    tptribs        = <<EscaparSQL(THIS.this_cTptribs)>>,
                    cftios         = <<EscaparSQL(THIS.this_cCftios)>>,
                    mftios         = <<EscaparSQL(THIS.this_cMftios)>>,
                    pftios         = <<FormatarNumeroSQL(THIS.this_nPftios, 3)>>,
                    cftiocs        = <<EscaparSQL(THIS.this_cCftiocs)>>,
                    pftiocs        = <<FormatarNumeroSQL(THIS.this_nPftiocs, 3)>>,
                    encargos       = <<FormatarNumeroSQL(THIS.this_nEncargos, 4)>>,
                    descecfs       = <<EscaparSQL(THIS.this_cDescecfs)>>,
                    codservs       = <<EscaparSQL(THIS.this_cCodservs)>>,
                    iats           = <<EscaparSQL(THIS.this_cIats)>>,
                    ifors          = <<EscaparSQL(THIS.this_cIfors)>>,
                    cvens          = <<EscaparSQL(THIS.this_cCvens)>>,
                    locals         = <<EscaparSQL(THIS.this_cLocals)>>,
                    notas          = <<EscaparSQL(THIS.this_cNotas)>>,
                    metals         = <<EscaparSQL(THIS.this_cMetals)>>,
                    teors          = <<EscaparSQL(THIS.this_cTeors)>>,
                    codacbs        = <<EscaparSQL(THIS.this_cCodacbs)>>,
                    codgarras      = <<EscaparSQL(THIS.this_cCodgarras)>>,
                    qmins          = <<FormatarNumeroSQL(THIS.this_nQmins, 3)>>,
                    qtdcpnts       = <<FormatarNumeroSQL(THIS.this_nQtdcpnts, 0)>>,
                    qtminfabs      = <<FormatarNumeroSQL(THIS.this_nQtminfabs, 3)>>,
                    ltminsv        = <<FormatarNumeroSQL(THIS.this_nLtminsv, 3)>>,
                    qtdultcomp     = <<FormatarNumeroSQL(THIS.this_nQtdultcomp, 0)>>,
                    vultcomps      = <<FormatarNumeroSQL(THIS.this_nVultcomps, 2)>>,
                    multcomps      = <<EscaparSQL(THIS.this_cMultcomps)>>,
                    pmins          = <<FormatarNumeroSQL(THIS.this_nPmins, 3)>>,
                    qtped          = <<FormatarNumeroSQL(THIS.this_nQtped, 3)>>,
                    cunis          = <<EscaparSQL(THIS.this_cCunis)>>,
                    cunips         = <<EscaparSQL(THIS.this_cCunips)>>,
                    pesoms         = <<FormatarNumeroSQL(THIS.this_nPesoms, 3)>>,
                    pesobs         = <<FormatarNumeroSQL(THIS.this_nPesobs, 3)>>,
                    pesobris       = <<FormatarNumeroSQL(THIS.this_nPesobris, 3)>>,
                    pesometal      = <<FormatarNumeroSQL(THIS.this_nPesometal, 3)>>,
                    pesopdrs       = <<FormatarNumeroSQL(THIS.this_nPesopdrs, 3)>>,
                    varpesoms      = <<FormatarNumeroSQL(THIS.this_nVarpesoms, 2)>>,
                    tamhs          = <<FormatarNumeroSQL(THIS.this_nTamhs, 2)>>,
                    tamls          = <<FormatarNumeroSQL(THIS.this_nTamls, 2)>>,
                    tamps          = <<FormatarNumeroSQL(THIS.this_nTamps, 2)>>,
                    altura         = <<FormatarNumeroSQL(THIS.this_nAltura, 4)>>,
                    largura        = <<FormatarNumeroSQL(THIS.this_nLargura, 4)>>,
                    diametro       = <<FormatarNumeroSQL(THIS.this_nDiametro, 4)>>,
                    espessura      = <<FormatarNumeroSQL(THIS.this_nEspessura, 4)>>,
                    compriment     = <<FormatarNumeroSQL(THIS.this_nCompriment, 4)>>,
                    volumes        = <<FormatarNumeroSQL(THIS.this_nVolumes, 0)>>,
                    mohs           = <<FormatarNumeroSQL(THIS.this_nMohs, 0)>>,
                    compos         = <<EscaparSQL(THIS.this_cCompos)>>,
                    montadescs     = <<FormatarNumeroSQL(THIS.this_nMontadescs, 0)>>,
                    digimaxs       = <<FormatarNumeroSQL(THIS.this_nDigimaxs, 0)>>,
                    ordcompos      = <<FormatarNumeroSQL(THIS.this_nOrdcompos, 0)>>,
                    situas         = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    status         = <<EscaparSQL(THIS.this_cStatus)>>,
                    nidentfixa     = <<FormatarNumeroSQL(THIS.this_nNidentfixa, 0)>>,
                    datas          = <<loc_cDatas>>,
                    datatrans      = <<loc_cDatatrans>>,
                    dtfilms        = <<loc_cDtfilms>>,
                    dtincs         = <<loc_cDtincs>>,
                    ultcomps       = <<loc_cUltcomps>>,
                    dtsituas       = <<loc_cDtsituas>>,
                    dtcomps        = <<loc_cDtcomps>>,
                    dtlacto        = <<loc_cDtlacto>>,
                    fimdtlacto     = <<loc_cFimdtlacto>>,
                    dtalts         = <<loc_cDtalts>>,
                    usuincs        = <<EscaparSQL(THIS.this_cUsuincs)>>,
                    usuaalts       = <<EscaparSQL(THIS.this_cUsuaalts)>>,
                    tinsts         = <<FormatarNumeroSQL(THIS.this_nTinsts, 0)>>,
                    diasinas       = <<FormatarNumeroSQL(THIS.this_nDiasinas, 0)>>,
                    tents          = <<FormatarNumeroSQL(THIS.this_nTents, 0)>>,
                    casas          = <<FormatarNumeroSQL(THIS.this_nCasas, 0)>>,
                    contaccus      = <<EscaparSQL(THIS.this_cContaccus)>>,
                    gruccus        = <<EscaparSQL(THIS.this_cGruccus)>>,
                    idecpros       = <<EscaparSQL(THIS.this_cIdecpros)>>,
                    cclass         = <<EscaparSQL(THIS.this_cCclass)>>,
                    nivelqs        = <<EscaparSQL(THIS.this_cNivelqs)>>,
                    codfinp        = <<EscaparSQL(THIS.this_cCodfinp)>>,
                    codmatp        = <<EscaparSQL(THIS.this_cCodmatp)>>,
                    codident       = <<EscaparSQL(THIS.this_cCodident)>>,
                    obspeds        = <<EscaparSQL(THIS.this_cObspeds)>>,
                    obspes         = <<EscaparSQL(THIS.this_cObspes)>>,
                    obsetqs        = <<EscaparSQL(THIS.this_cObsetqs)>>,
                    obsmkt         = <<EscaparSQL(THIS.this_cObsmkt)>>,
                    refracao       = <<EscaparSQL(THIS.this_cRefracao)>>,
                    refracaodp     = <<EscaparSQL(THIS.this_cRefracaodp)>>,
                    ativosite      = <<FormatarNumeroSQL(THIS.this_nAtivosite, 0)>>,
                    categoria      = <<EscaparSQL(THIS.this_cCategoria)>>,
                    codctgsite     = <<EscaparSQL(THIS.this_cCodctgsite)>>,
                    coddptsite     = <<EscaparSQL(THIS.this_cCoddptsite)>>,
                    skuvtex        = <<EscaparSQL(THIS.this_cSkuvtex)>>,
                    segfem         = <<FormatarNumeroSQL(THIS.this_nSegfem, 0)>>,
                    seginf         = <<FormatarNumeroSQL(THIS.this_nSeginf, 0)>>,
                    segkids        = <<FormatarNumeroSQL(THIS.this_nSegkids, 0)>>,
                    segmasc        = <<FormatarNumeroSQL(THIS.this_nSegmasc, 0)>>,
                    seguni         = <<FormatarNumeroSQL(THIS.this_nSeguni, 0)>>,
                    bestseller     = <<FormatarNumeroSQL(THIS.this_nBestseller, 0)>>,
                    prodnovo       = <<FormatarNumeroSQL(THIS.this_nProdinovo, 0)>>,
                    prodoff        = <<FormatarNumeroSQL(THIS.this_nProdoff, 0)>>,
                    foralinha      = <<FormatarNumeroSQL(THIS.this_nForalinha, 0)>>,
                    mostruario     = <<FormatarNumeroSQL(THIS.this_nMostruario, 0)>>,
                    semconsulta    = <<FormatarNumeroSQL(THIS.this_nSemconsulta, 0)>>,
                    obrtamser      = <<FormatarNumeroSQL(THIS.this_nObrtamser, 0)>>,
                    prototipo      = <<FormatarNumeroSQL(THIS.this_nProtoipo, 0)>>,
                    reposauto      = <<FormatarNumeroSQL(THIS.this_nReposauto, 0)>>,
                    prodvars       = <<FormatarNumeroSQL(THIS.this_nProdvars, 0)>>,
                    procfigjpgs    = <<FormatarNumeroSQL(THIS.this_nProcfigjpgs, 0)>>,
                    lancamento     = <<EscaparSQL(THIS.this_cLancamento)>>,
                    origemlac      = <<EscaparSQL(THIS.this_cOrigemlac)>>,
                    diasgar        = <<FormatarNumeroSQL(THIS.this_nDiasgar, 0)>>,
                    propriedades   = <<EscaparSQL(THIS.this_cPropriedades)>>,
                    unidade1       = <<EscaparSQL(THIS.this_cUnidade1)>>,
                    resultado1     = <<EscaparSQL(THIS.this_cResultado1)>>,
                    valorminimo    = <<EscaparSQL(THIS.this_cValorminimo)>>,
                    valormaximo    = <<EscaparSQL(THIS.this_cValormaximo)>>,
                    metodoreferencia1 = <<EscaparSQL(THIS.this_cMetodoreferencia1)>>,
                    flagctabs      = <<IIF(THIS.this_lFlagctabs, 1, 0)>>,
                    tcomps         = <<IIF(THIS.this_lTcomps, 1, 0)>>,
                    transps        = <<IIF(THIS.this_lTransps, 1, 0)>>,
                    impetiqs       = <<IIF(THIS.this_lImpetiqs, 1, 0)>>,
                    chkfunds       = <<IIF(THIS.this_lChkfunds, 1, 0)>>,
                    varias         = <<IIF(THIS.this_lVarias, 1, 0)>>,
                    consigs        = <<IIF(THIS.this_lConsigs, 1, 0)>>,
                    fabrproprs     = <<IIF(THIS.this_lFabrproprs, 1, 0)>>,
                    encoms         = <<IIF(THIS.this_lEncoms, 1, 0)>>,
                    chkgarvit      = <<IIF(THIS.this_lChkgarvit, 1, 0)>>,
                    cravcers       = <<IIF(THIS.this_lCravcers, 1, 0)>>,
                    prodwebs       = <<IIF(THIS.this_lProdwebs, 1, 0)>>,
                    descfis        = <<EscaparSQL(THIS.this_cDescfis)>>,
                    figjpgs        = <<EscaparSQL(THIS.this_cFigjpgs)>>,
                    figjpgs64      = <<EscaparSQL(THIS.this_cFigjpgs64)>>,
                    dsccompras     = <<EscaparSQL(THIS.this_cDsccompras)>>,
                    figtecs        = <<EscaparSQL(THIS.this_cFigtecs)>>,
                    obscompras     = <<EscaparSQL(THIS.this_cObscompras)>>,
                    dpro3s         = <<EscaparSQL(THIS.this_cDpro3s)>>,
                    mtiposervs     = <<EscaparSQL(THIS.this_cMtiposervs)>>,
                    obsinsp        = <<EscaparSQL(THIS.this_cObsinsp)>>
                WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto. Codigo SQL: " + LTRIM(STR(loc_nResultado)), "ProdutoBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar produto:" + CHR(13) + loc_oErro.Message, "ProdutoBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui produto da tabela SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE cpros = " + EscaparSQL(THIS.this_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto. Codigo SQL: " + LTRIM(STR(loc_nResultado)), "ProdutoBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir produto:" + CHR(13) + loc_oErro.Message, "ProdutoBO.ExecutarExclusao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
