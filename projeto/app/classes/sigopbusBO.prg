*******************************************************************************
* sigopbusBO.prg - Business Object para Busca de Produto (dialogo auxiliar)
* Tabela principal: SigCdPro (PK: cpros)
* Origem: tasks\task649\sigopbus_form_codigo_fonte.txt (SIGOPBUS)
* Natureza: dialogo de busca (NAO eh CRUD) - pesquisa SigCdPro por Descricao,
*           Codigo, Referencia de Fornecedor ou Descritivo e devolve o
*           codigo escolhido ao form chamador.
*
* Fase 2/8 - O dump legado (tasks\task649\comportamento.json: metodosComSQL=0,
* totalQueries=0, funcoesExternas=["fwBuscaExt"]) nao tem nenhum
* TABLEUPDATE/AddCursor/Insert/Update/Delete em tabela remota - os quatro
* Valid() (Get_Descricao/Get_Produto/Get_RefFor/get_DPro2s) apenas abrem o
* picker fwBuscaExt (equivalente a FormBuscaAuxiliar no migrado) e leem o
* registro escolhido. Por isso Inserir()/Atualizar()/ExecutarExclusao()
* permanecem SEM override: o comportamento padrao herdado de BusinessBase
* ja eh o correto para este dialogo somente-leitura.
*
* Completado em: Fase 2 - CarregarDoCursor()/ObterCodigoRetorno()/
* ObterFiltroSituacao()/ObterChavePrimaria()/LimparDados()
*******************************************************************************

DEFINE CLASS sigopbusBO AS BusinessBase

    *-- Criterios de busca (um por campo de pesquisa do dialogo legado)
    this_cCpros        = ""    && cpros char(14) - codigo do produto (busca/retorno)
    this_cDpros        = ""    && dpros char(65) - descricao do produto (criterio de busca)
    this_cDpro2s       = ""    && dpro2s char(45) - descritivo do produto (criterio de busca)
    this_cReffs        = ""    && reffs char(40) - referencia de fornecedor (criterio de busca)

    *-- Resultado devolvido ao form chamador
    this_cProduto      = ""    && valor retornado (codigo, cod. pai, cod. macro ou cod. barras conforme flags abaixo)

    *-- Parametros de comportamento recebidos do form chamador (equivalentes as Lparameters do legado)
    this_nSituas       = 0     && filtro de situacao: 0=todas,1=ativos,2=inativos,3=0/1/2,4=ativos+encomenda,5=encomenda
    this_nFiltraSituas = 0     && <>0 ativa o filtro de this_nSituas na busca
    this_lTipoRetorno  = .F.   && .T.=devolve codigo de barras (cbars); .F.=devolve codigo do produto (cpros)
    this_lConjunto     = .F.   && .T.=produto trabalha com conjunto (devolve/exibe conjunts - Cod. Pai)
    this_lCodMacro     = .F.   && .T.=produto trabalha com codigo macro (devolve/exibe codmacro)
    this_lCnjLacto     = .F.   && .T.=exibe coluna de conjunto no resultado da busca

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Equivalente ao "ThisForm.Produto = Space(14)" que o
    * legado repete no inicio de cada Valid(), antes de tentar a busca, e
    * limpa tambem os criterios para o dialogo poder ser reaproveitado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCpros   = ""
        THIS.this_cDpros   = ""
        THIS.this_cDpro2s  = ""
        THIS.this_cReffs   = ""
        THIS.this_cProduto = SPACE(14)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - cpros eh a PK de SigCdPro. Fica disponivel so por
    * completude de contrato (regra CLAUDE.md #51): RegistrarAuditoria nunca
    * eh chamado por este BO, porque Inserir()/Atualizar() nao sao
    * sobrescritos (dialogo somente-leitura, ver cabecalho do arquivo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFiltroSituacao - Fragmento de filtro adicional por situacao do
    * produto, reproduzindo o "Do Case" presente nos Valid() de
    * Get_Descricao/Get_Produto/get_DPro2s do legado. So atua quando
    * this_nSituas <> 0 E this_nFiltraSituas <> 0 (legado: "If
    * Thisform.Situas <> 0 And ThisForm.FiltraSituas <> 0"); fora disso
    * devolve "" (sem filtro adicional).
    *
    * O fragmento NAO leva "And" nem "Where" na frente - quem consome
    * (par_cFiltro de FormBuscaAuxiliar) concatena "And (filtro)" por conta
    * propria (regra CLAUDE.md #37/Pattern #154).
    *
    * Get_RefFor (busca por Referencia de Fornecedor) NUNCA aplica este
    * filtro no legado - o form (Fase 6) so chama este metodo para os
    * outros tres campos de busca.
    *--------------------------------------------------------------------------
    FUNCTION ObterFiltroSituacao()
        LOCAL loc_cFiltro
        loc_cFiltro = ""

        IF THIS.this_nSituas != 0 AND THIS.this_nFiltraSituas != 0
            DO CASE
            CASE THIS.this_nSituas = 1
                loc_cFiltro = "Situas <> 2"
            CASE THIS.this_nSituas = 2
                loc_cFiltro = "Situas = 2"
            CASE THIS.this_nSituas = 3
                loc_cFiltro = "Situas In(0,1,2)"
            CASE THIS.this_nSituas = 4
                loc_cFiltro = "Situas <> 2 And Encoms = 1"
            CASE THIS.this_nSituas = 5
                loc_cFiltro = "Encoms = 1"
            ENDCASE
        ENDIF

        RETURN loc_cFiltro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCodigoRetorno - Resolve o valor que o dialogo devolve ao form
    * chamador. Legado (presente nos quatro Valid(), apos "If Lastkey() <>
    * 27", com CrListaRemota ja posicionado no registro escolhido pelo
    * picker):
    *   ThisForm.Produto = Iif(ThisForm.Conjunto, CrListaRemota.Conjunts,
    *       Iif(ThisForm.CodMacro, CrListaRemota.CodMacro,
    *       Iif(ThisForm.Tiporetorno, Str(CrListaRemota.Cbars),
    *       CrListaRemota.Cpros)))
    *
    * par_cAliasCursor eh o cursor/linha ja selecionada pelo lookup
    * (fwBuscaExt no legado, FormBuscaAuxiliar no migrado). Preenche
    * THIS.this_cProduto e devolve o mesmo valor. Guardas de TYPE() evitam
    * "Variable X is not found" quando a coluna preferida (Conjunts/
    * CodMacro/Cbars) nao vier no cursor de resultado - nesse caso cai para
    * Cpros, que eh sempre o identificador base do produto.
    *--------------------------------------------------------------------------
    FUNCTION ObterCodigoRetorno(par_cAliasCursor)
        LOCAL loc_cResultado
        loc_cResultado = SPACE(14)

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                DO CASE
                CASE THIS.this_lConjunto AND TYPE(par_cAliasCursor + ".Conjunts") != "U"
                    loc_cResultado = TratarNulo(Conjunts, SPACE(14))
                CASE THIS.this_lCodMacro AND TYPE(par_cAliasCursor + ".CodMacro") != "U"
                    loc_cResultado = TratarNulo(CodMacro, SPACE(14))
                CASE THIS.this_lTipoRetorno AND TYPE(par_cAliasCursor + ".Cbars") != "U"
                    loc_cResultado = ALLTRIM(STR(TratarNulo(Cbars, 0)))
                OTHERWISE
                    loc_cResultado = TratarNulo(Cpros, SPACE(14))
                ENDCASE
            ENDIF
        ENDIF

        THIS.this_cProduto = loc_cResultado
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a linha ATUAL de par_cAliasCursor
    * (resultado do lookup/picker apos a selecao do usuario) para as
    * properties de criterio/resultado e resolve THIS.this_cProduto (ver
    * ObterCodigoRetorno). Equivalente ao trecho comum aos quatro Valid()
    * do legado, apos "If Lastkey() <> 27": leitura das colunas do produto
    * encontrado. Regra CLAUDE.md #9: SELECT antes de acessar campo, nunca
    * campo direto sobre o alias.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                IF TYPE(par_cAliasCursor + ".Cpros") != "U"
                    THIS.this_cCpros = TratarNulo(Cpros, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Dpros") != "U"
                    THIS.this_cDpros = TratarNulo(Dpros, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Dpro2s") != "U"
                    THIS.this_cDpro2s = TratarNulo(Dpro2s, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Reffs") != "U"
                    THIS.this_cReffs = TratarNulo(Reffs, "")
                ENDIF

                THIS.ObterCodigoRetorno(par_cAliasCursor)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProduto - Equivalente ao PROCEDURE Unload do legado:
    *   Return(Thisform.Produto)
    * O legado era aberto via "DO FORM SigOpBus WITH ... TO lcVar" (o VFP
    * captura nessa clausula o retorno do Unload); o form chamador le este
    * metodo (via Formsigopbus.ObterProduto()) apos o Show() modal
    * retornar, antes de liberar o dialogo.
    *--------------------------------------------------------------------------
    FUNCTION ObterProduto()
        RETURN THIS.this_cProduto
    ENDFUNC

ENDDEFINE
