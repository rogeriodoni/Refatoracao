# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FILTRASITUAS, ENCOMS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopbus.prg) - TRECHOS RELEVANTES PARA PASS SQL (1143 linhas total):

*-- Linhas 106 a 124:
106: *             cada AddObject (".Value = TratarNulo(...)") e agora tem UM
107: *             ponto de recarga; LimparCampos() devolve o dialogo ao estado
108: *             do Init legado ("ThisForm.Produto = Space(14)" com os 4 campos
109: *             vazios - o SCX nao declara Value nem ControlSource em nenhum).
110: *             Os TRES sao PROTECTED porque FormBase declara os hooks
111: *             PROTECTED e VFP9 nao permite ALARGAR escopo de metodo herdado.
112: *             BOParaForm() NAO substitui o eco por campo que cada Exec faz
113: *             depois de uma selecao: o legado escreve SO no proprio campo
114: *             ("This.Value = CrListaRemota.Dpros"), e reescrever os quatro
115: *             ali seria desvio do PILAR 1.
116: *
117: *             Os demais itens do roteiro generico desta fase (BtnBuscarClick/
118: *             BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick/CarregarLista/
119: *             HabilitarCampos/AjustarBotoesPorModo) sao NO-OP JUSTIFICADO:
120: *             sao vocabulario de form CRUD (frmcadastro, Page1=Lista/
121: *             Page2=Dados com Confirmar/Cancelar/Encerrar) e este dialogo
122: *             FLAT nao tem CRUD nenhum - o legado (SIGOPBUS.SCX) nao declara
123: *             UM botao Buscar/Salvar/Cancelar/Encerrar, nem Grid, nem
124: *             PageFrame (ver nota da Fase 4), logo nao ha lista a carregar

*-- Linhas 1110 a 1128:
1110:     * LimparCampos - Zera os 4 criterios e o resultado, devolvendo o dialogo
1111:     * ao estado em que o Init legado o deixava ("ThisForm.Produto =
1112:     * Space(14)", com os 4 TextBox vazios porque o SCX nao declara Value
1113:     * nem ControlSource em nenhum deles). Delega ao BO (fonte unica dos
1114:     * valores) e repinta a tela por BOParaForm().
1115:     *
1116:     * PROTECTED - FormBase declara LimparCampos() PROTECTED.
1117:     *--------------------------------------------------------------------------
1118:     PROTECTED PROCEDURE LimparCampos()
1119:         LOCAL loc_oErro
1120:         TRY
1121:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1122:                 THIS.this_oBusinessObject.LimparDados()
1123:             ENDIF
1124:             THIS.BOParaForm()
1125:         CATCH TO loc_oErro
1126:             MsgErro(loc_oErro.Message + CHR(13) + ;
1127:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1128:                 "Procedure: " + loc_oErro.Procedure, "Formsigopbus.LimparCampos")


### BO (C:\4c\projeto\app\classes\sigopbusBO.prg):
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

