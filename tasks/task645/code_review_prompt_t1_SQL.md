# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CBARS, CIDCHAVES, CONTAS, DTMOVS, USUARS

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

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select CrSigMvCab
Select CrSigMvHst
Insert Into crSigMvCab (Emps, Dopes, Numes, MascNum, GrupoOs, ContaOs, Datas, Usuars, EmpDopNums, cIdChaves, DtAlts) ;
Insert Into crSigMvHst (CodBarras, Usuars, Opers, Cpros, Datas, Datars, Dopes, Empos, ;
lcQuery = [Update SigOpEtq ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigOpEtq)')
If llTaOk And Not ThisForm.poDataMgr.Update('crSigMvCab')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvCab)')
If llTaOk And Not ThisForm.poDataMgr.Update('crSigMvHst')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigMvHst)')
lcQryEest = [Select * From SigMvCab Where cIdChaves = '] + pIds + [']
lcQryHis  = [Select * From SigMvHst  Where cIdChaves = '] + pIds + [']

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpBcb.prg) - TRECHOS RELEVANTES PARA PASS SQL (906 linhas total):

*-- Linhas 31 a 51:
31: * SEM METODO DE CARGA DA LISTA - o quarto nome canonico que o gate da Fase 8
32: * cobra (o "Carregar" + "Lista" do padrao CRUD) nao tem referente aqui: o SCX
33: * legado NAO tem grade nem lista. Zero "BaseClass: grid|pageframe", zero
34: * pColuna, zero ControlSource ligando lista, e os quatro .AddCursor do Init
35: * legado tem o 5o argumento VAZIO - 'crSigMvCab'/'crSigMvHst' sao os buffers
36: * de ESCRITA do INSERT do BaixaBarra, nao fonte de grade. Nao existe cursor de
37: * listagem a popular: criar o metodo obrigaria a INVENTAR uma grade que o
38: * legado nao tem (viola o PILAR 1) ou a deixar um metodo vazio (proibido pela
39: * regra de completude).
40: *
41: * O nome nao esta escrito junto de proposito: o gate confere por SUBSTRING no
42: * arquivo inteiro, entao cita-lo aqui satisfaria a checagem por PROSA, sem que
43: * exista metodo nenhum - e o ramo de excecao estrutural que de fato autoriza a
44: * ausencia (LEITOR-BAIXA, em automation\OrquestradorMigracao.ps1) nunca seria
45: * avaliado. Medido com os proprios helpers do gate, via
46: * automation\VerificarGateFase8Task645.ps1.
47: *==============================================================================
48: 
49: DEFINE CLASS FormSigOpBcb AS FormBase
50: 
51:     Height      = 600

*-- Linhas 791 a 809:
791:     * BtnConfirmarClick - equivalente ao Confirma.Click do legado (botao
792:     * "Confirma", Caption "Baixa"): com codigo preenchido, pede confirmacao
793:     * e, confirmando, efetiva a baixa via SigOpBcbBO.Inserir() - metodo que
794:     * replica o BaixaBarra legado (INSERT em SigMvCab/SigMvHst + UPDATE em
795:     * SigOpEtq num unico lote).
796:     *
797:     * SINCRONIA ANTES DE GRAVAR: o Inserir() do BO grava a etiqueta que esta
798:     * carregada nas properties, nao o que esta na tela. No fluxo normal o
799:     * LostFocus de Get_Codigo (funil ConsultarCodigo) ja deixou as duas
800:     * coisas iguais - clicar o botao tira o foco do campo e dispara o Valid,
801:     * como no legado. Mas o leitor de codigo de barras pode confirmar sem que
802:     * o foco saia do campo, e ai gravar-se-ia a etiqueta ANTERIOR: um codigo
803:     * diferente do exibido, sem erro nenhum na tela. A conferencia abaixo
804:     * reusa o MESMO funil (nao duplica a consulta) e so prossegue se a
805:     * etiqueta da tela estiver carregada e apta.
806:     *
807:     * FALHA NUNCA MUDA (regra CLAUDE.md #20): aqui o form chama Inserir()
808:     * DIRETO, sem passar por BusinessBase.Salvar(), entao o ExibirFalha() da
809:     * base nao roda. As duas recusas do Inserir() (nao localizado / ja


### BO (C:\4c\projeto\app\classes\SigOpBcbBO.prg):
*============================================================================
* SigOpBcbBO.prg - Business Object do form OPERACIONAL "Baixa de Codigos de
*                  Barras" (legado SIGOPBCB.SCX)
*
* Tabela principal : SigMvHst  (PK: cidchaves char(20))
*
* FLUXO DO LEGADO (tasks\task645\SigOpBcb_form_codigo_fonte.txt)
* ------------------------------------------------------------------------
* O operador le/digita o codigo de barras da etiqueta (Get_Codigo). O Valid
* do campo consulta SigOpEtq por CBars e, achando a etiqueta, exibe na tela
* Grupo, Conta, Produto, Descricao do Produto, Quantidade (1) e
* Quantidade (2) mais as duas unidades de medida. O botao "Baixa"
* (Confirma.Click -> ThisForm.BaixaBarra) efetiva a baixa gravando, numa
* unica transacao:
*
*   1) INSERT em SigMvCab  - cabecalho do movimento de baixa
*   2) INSERT em SigMvHst  - historico/movimento de estoque (Opers = "S")
*   3) UPDATE em SigOpEtq  - zera Grupos e Contas, marca DtMovs e Usuars
*
* Duas recusas do Valid legado, que continuam valendo:
*   - etiqueta inexistente em SigOpEtq         -> "Codigo Nao Localizado"
*   - Grupos E Contas ambos vazios na etiqueta -> "Codigo Ja Baixado"
*
* TABELAS CONSULTADAS (somente leitura)
*   SigOpEtq  - etiqueta lida pelo codigo de barras (PK cbars numeric(14,0))
*   SigCdPro  - descricao e unidades do produto (Dpros, cUnis, cUniPs)
*   SigCdPac  - parametros do sistema; dali sai SigKeys, sufixo da chave
*               cidchaves do historico (no legado, ThisForm.SigKey)
*
* CHAVES POSICIONAIS (regra CLAUDE.md #42 - o padding FAZ PARTE da chave)
*   EmpDopNums char(29) = Empos char(3) + Dopes char(20) + STR(Numes, 6)
*   EmpGruEsts char(23) = Empos char(3) + Grupos char(10) + Contas char(10)
*   As partes vao com PADR() na largura da coluna, NUNCA com ALLTRIM: a soma
*   tem de fechar exatamente 29 e 23, senao a chave nunca casa e o SELECT
*   devolve zero linha em silencio.
*
* NOTA DE ESCOPO - fRecalculaP / fRecalculaC
*   O BaixaBarra legado chama fRecalculaP/fRecalculaC (recalculo de custo e
*   preco medio de estoque) em quatro pontos. As duas funcoes NAO existem no
*   acervo - nem como .prg, nem no Framework, nem no p-code dos VCX. Pela
*   regra CLAUDE.md #27 (3a linha da tabela: funcao que devolve VALOR DE
*   CALCULO fica AUSENTE e visivel, nunca vira stub), as chamadas ficam de
*   fora: um stub devolvendo zero gravaria custo medio errado em silencio.
*   Mesmo tratamento ja adotado em SigPrGlpBO, SigPrGlxBO e dmoBO.
*
* COBERTURA DE COLUNAS NOT NULL (regra CLAUDE.md #22)
*   O legado grava o registro INTEIRO (AddCursor sem query = SELECT * +
*   TABLEUPDATE), entao coluna que nao aparece na tela continua sendo gravada
*   em branco pelo cursor. Os INSERT escritos a mao precisam cobrir TODA
*   coluna NOT NULL sem DEFAULT, senao o SQL Server recusa a gravacao inteira.
*   Medido em docs\schema.sql (UTF-16, lido com Get-Content -Raw):
*
*     SigMvCab : 137 colunas NOT NULL, 26 com DEFAULT -> 111 a cobrir
*     SigMvHst :  36 colunas NOT NULL,  0 com DEFAULT ->  36 a cobrir
*
*   As colunas sem property declarada aqui recebem o default do tipo:
*   EscaparSQL("") para char, FormatarNumeroSQL(0, <dec>) para numeric,
*   0 para bit. A lista vem do SCHEMA, nunca do dump do legado - as colunas
*   ausentes sao invisiveis la. O gate Validate-InsertNotNull (etapa
*   05f_validarSQLSchema) BLOQUEIA a migracao se faltar alguma.
*
* DATA/HORA - as properties this_t* nascem como {} (DATE vazio), que eh a
*   convencao do projeto para campo datetime ainda nao preenchido. Quando
*   recebem DATETIME() passam a ser do tipo T. FormatarDataSQL() aceita os
*   dois tipos e devolve "NULL" no vazio; TTOD() NAO aceita DATE e dispara
*   erro 11 em runtime (regra CLAUDE.md #16) - havendo necessidade de
*   converter, usar ConverterParaData() de utils\functions.prg.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpBcbBO AS BusinessBase

    *==========================================================================
    * 1) ETIQUETA LIDA - colunas de SigOpEtq (origem de quase todo o resto)
    *==========================================================================
    this_nCbars    = 0    && numeric(14,0) - SigOpEtq.cbars - codigo de barras
    this_cGrupos   = ""   && char(10)      - SigOpEtq.grupos - grupo da conta
    this_cContas   = ""   && char(10)      - SigOpEtq.contas - conta/estoque
    this_cCpros    = ""   && char(14)      - SigOpEtq.cpros  - codigo produto
    this_cEmpos    = ""   && char(3)       - SigOpEtq.empos  - empresa de origem
    this_nQtds     = 0    && numeric(9,3)  - SigOpEtq.qtds   - Quantidade (1)
    this_nPesos    = 0    && numeric(9,3)  - SigOpEtq.pesos  - Quantidade (2)
    this_cCodCors  = ""   && char(4)       - SigOpEtq.codcors - cor
    this_cCodTams  = ""   && char(4)       - SigOpEtq.codtams - tamanho

    *==========================================================================
    * 2) PRODUTO - colunas de SigCdPro lidas pelo Valid legado
    *    CursorQuery("SigCdPro", "LocalPro", "Cpros", ..., [ Dpros, cUnis, cUniPs ])
    *==========================================================================
    this_cDpros    = ""   && char(65) - SigCdPro.dpros  - descricao do produto
    this_cCunis    = ""   && char(3)  - SigCdPro.cunis  - unidade da Qtde (1)
    this_cCunips   = ""   && char(3)  - SigCdPro.cunips - unidade da Qtde (2)

    *==========================================================================
    * 3) PARAMETRO DO SISTEMA - SigCdPac
    *==========================================================================
    this_cSigKeys  = ""   && char(3) - SigCdPac.sigkeys - sufixo do cidchaves
                          &&           do historico (ThisForm.SigKey no legado)

    *==========================================================================
    * 4) CABECALHO DO MOVIMENTO - colunas gravadas em SigMvCab
    *    Emps e Dopes tambem alimentam o INSERT de SigMvHst.
    *==========================================================================
    this_cDopes      = ""   && char(20)     - SigMvCab.dopes - recebe
                            &&                PADR("BAIXA ETIQUETA", 20); o
                            &&                padding entra na chave posicional
    this_nNumes      = 0    && numeric(6,0) - SigMvCab.numes - numero do
                            &&                movimento, de fGerUniqueKey()
    this_cMascNum    = ""   && char(10)     - SigMvCab.mascnum - fGerMascara()
    this_cGrupoOs    = ""   && char(10)     - SigMvCab.grupoos - grupo de origem
    this_cContaOs    = ""   && char(10)     - SigMvCab.contaos - conta de origem
    this_tDatas      = {}   && datetime     - SigMvCab.datas / SigMvHst.datas
    this_tDatars     = {}   && datetime     - SigMvHst.datars (mesmo instante)
    this_tDtAlts     = {}   && datetime     - .dtalts das duas tabelas
    this_cUsuars     = ""   && char(10)     - .usuars das duas tabelas
    this_cCidChaves  = ""   && char(20)     - SigMvCab.cidchaves - fUniqueIds()
    this_cEmpDopNums = ""   && char(29)     - .empdopnums das duas tabelas
                            &&                (Empos + Dopes + STR(Numes, 6))

    *==========================================================================
    * 5) HISTORICO DE ESTOQUE - colunas exclusivas de SigMvHst
    *==========================================================================
    this_nCodBarras    = 0    && numeric(14,0) - SigMvHst.codbarras - o mesmo
                              &&                 valor de this_nCbars
    this_cOpers        = "S"  && char(1)       - SigMvHst.opers - "S" (saida),
                              &&                 constante no BaixaBarra legado
    this_cEstos        = ""   && char(10)      - SigMvHst.estos - recebe a
                              &&                 Conta da etiqueta
    this_cCidChavesHst = ""   && char(20)      - SigMvHst.cidchaves - montada
                              &&                 como DTOS(Datas) + "S" +
                              &&                 TRANSFORM(fGerUniqueKey(
                              &&                 DTOS(Datas)), "@L 999999") +
                              &&                 SigKeys  (8+1+6+3 = 18 chars)
    this_cEmpGruEsts   = ""   && char(23)      - SigMvHst.empgruests
                              &&                 (Empos + Grupos + Contas)
    this_cOriDopNums   = ""   && char(29)      - SigMvHst.oridopnums - mesma
                              &&                 montagem de EmpDopNums
    this_nSeqs         = 0    && numeric(10,0) - SigMvHst.seqs -
                              &&                 fGerUniqueKey("HISTBAR")

    *==========================================================================
    * 6) ESTADO DA LEITURA - resultado da consulta da etiqueta, consumido pelo
    *    Form para decidir entre exibir os dados, recusar o codigo ou avisar
    *    que a etiqueta ja foi baixada (as duas recusas do Valid legado)
    *==========================================================================
    this_lEtiquetaLocalizada = .F.   && .T. quando SigOpEtq devolveu a linha
    this_lEtiquetaBaixada    = .F.   && .T. quando Grupos e Contas estao vazios
                                     &&     na etiqueta (baixa ja efetivada)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria do Business Object
    *
    * A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
    * this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio o objeto
    * de acesso a dados fica .NULL. e todo metodo herdado que depende dele
    * devolve .F. com "Objeto de acesso a dados nao inicializado".
    *
    * this_cCampoChave recebe cidchaves - a PRIMARY KEY real de SigMvHst
    * conforme docs\schema.sql (constraint sigmvhst_cidchaves).
    *
    * Regra CLAUDE.md #1: nenhum RETURN dentro de TRY/CATCH - o resultado vai
    * numa flag e o RETURN unico fica depois do ENDTRY.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvHst")

            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"

            *-- Constante do legado: lcDop = Padr("BAIXA ETIQUETA", 20).
            *-- Fica com o padding desde o inicio porque a largura de 20
            *-- caracteres compoe EmpDopNums char(29) (regra #42).
            THIS.this_cDopes = PADR("BAIXA ETIQUETA", 20)

            *-- Operacao de saida de estoque, fixa no BaixaBarra legado.
            THIS.this_cOpers = "S"

            *-- Usuario logado alimenta usuars de SigMvCab, SigMvHst e do
            *-- UPDATE de SigOpEtq (no legado, a variavel PUBLIC Usuar).
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ELSE
                THIS.this_cUsuars = ""
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - cidchaves de SigMvHst (this_cTabela), usado pelo
    * RegistrarAuditoria herdado da BusinessBase.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChavesHst)
    ENDPROC

    *==========================================================================
    * CarregarSigKeys - Le o sufixo da chave do historico (SigCdPac.sigkeys),
    * equivalente a ThisForm.SigKey no Init legado. So eh necessario no
    * instante da gravacao, por isso fica aqui e nao no Init do BO.
    *==========================================================================
    PROTECTED FUNCTION CarregarSigKeys()
        LOCAL loc_cSigKeys, loc_nResultado
        loc_cSigKeys = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            IF USED("cursor_4c_BcbPac")
                USE IN cursor_4c_BcbPac
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT sigkeys FROM SigCdPac", "cursor_4c_BcbPac")

            IF loc_nResultado > 0 AND USED("cursor_4c_BcbPac") AND RECCOUNT("cursor_4c_BcbPac") > 0
                SELECT cursor_4c_BcbPac
                GO TOP
                loc_cSigKeys = TratarNulo(sigkeys, "")
            ENDIF

            IF USED("cursor_4c_BcbPac")
                USE IN cursor_4c_BcbPac
            ENDIF
        ENDIF

        THIS.this_cSigKeys = loc_cSigKeys
        RETURN loc_cSigKeys
    ENDFUNC

    *==========================================================================
    * ConsultarEtiqueta - replica o Valid de Get_Codigo do legado: busca a
    * etiqueta em SigOpEtq pelo codigo de barras e, achando-a valida, completa
    * com a descricao/unidades do produto (SigCdPro.CursorQuery do Valid
    * legado). Preenche as properties que o Form espelha nos campos de
    * exibicao (Grupo/Conta/Produto/Descricao/Qtde/Peso/unidades) e os dois
    * flags que decidem a mensagem no Form - mesmas duas recusas do Valid:
    *   this_lEtiquetaLocalizada - .F. quando SigOpEtq nao tem a linha
    *   this_lEtiquetaBaixada    - .T. quando Grupos e Contas estao vazios
    *                              na etiqueta (a baixa ja foi efetivada)
    *
    * par_nCbars = codigo de barras ja convertido pelo Form com
    * INT(VAL(...)), igual ao legado: lnBar = Iif(Type('This.Value')='C',
    * Int(Val(This.Value)), This.Value).
    *==========================================================================
    PROCEDURE ConsultarEtiqueta(par_nCbars)
        LOCAL loc_lSucesso, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        *-- Limpa o resultado da consulta anterior - mesmo bloco que abre o
        *-- Valid legado (With ThisForm / .Get_Grupo.Value = ' ' / ...).
        THIS.this_lEtiquetaLocalizada = .F.
        THIS.this_lEtiquetaBaixada    = .F.
        THIS.this_cGrupos   = ""
        THIS.this_cContas   = ""
        THIS.this_cCpros    = ""
        THIS.this_cDpros    = ""
        THIS.this_nQtds     = 0
        THIS.this_nPesos    = 0
        THIS.this_cCunis    = ""
        THIS.this_cCunips   = ""
        THIS.this_cEmpos    = ""
        THIS.this_cCodCors  = ""
        THIS.this_cCodTams  = ""
        THIS.this_nCbars    = par_nCbars

        IF par_nCbars <= 0
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_BcbEtq")
                    USE IN cursor_4c_BcbEtq
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Contas, Cpros, Empos, CodCors, CodTams, Qtds, Pesos " + ;
                    "FROM SigOpEtq WHERE CBars = " + FormatarNumeroSQL(par_nCbars, 0), ;
                    "cursor_4c_BcbEtq")

                IF loc_nResultado >= 0 AND USED("cursor_4c_BcbEtq") AND RECCOUNT("cursor_4c_BcbEtq") > 0
                    SELECT cursor_4c_BcbEtq
                    GO TOP

                    THIS.this_lEtiquetaLocalizada = .T.
                    THIS.this_cGrupos  = TratarNulo(Grupos, "")
                    THIS.this_cContas  = TratarNulo(Contas, "")
                    THIS.this_cCpros   = TratarNulo(Cpros, "")
                    THIS.this_cEmpos   = TratarNulo(Empos, "")
                    THIS.this_cCodCors = TratarNulo(CodCors, "")
                    THIS.this_cCodTams = TratarNulo(CodTams, "")
                    THIS.this_nQtds    = TratarNulo(Qtds, 0)
                    THIS.this_nPesos   = TratarNulo(Pesos, 0)

                    IF EMPTY(THIS.this_cGrupos) AND EMPTY(THIS.this_cContas)
                        *-- If Empty(crSigOpEtq.Grupos) And Empty(crSigOpEtq.Contas)
                        *-- "Codigo Ja Baixado" - a etiqueta nao tem mais saldo
                        *-- de Grupo/Conta para gerar uma nova baixa.
                        THIS.this_lEtiquetaBaixada = .T.
                    ELSE
                        *-- ThisForm.poDataMgr.CursorQuery('SigCdPro', 'LocalPro',
                        *-- 'Cpros', CrSigOpEtq.cpros, [ Dpros, cUnis, cUniPs ])
                        IF USED("cursor_4c_BcbPro")
                            USE IN cursor_4c_BcbPro
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "SELECT Dpros, cUnis, cUniPs FROM SigCdPro WHERE Cpros = " + EscaparSQL(THIS.this_cCpros), ;
                            "cursor_4c_BcbPro")

                        IF loc_nResultado >= 0 AND USED("cursor_4c_BcbPro") AND RECCOUNT("cursor_4c_BcbPro") > 0
                            SELECT cursor_4c_BcbPro
                            GO TOP
                            THIS.this_cDpros  = TratarNulo(Dpros, "")
                            THIS.this_cCunis  = TratarNulo(cUnis, "")
                            THIS.this_cCunips = TratarNulo(cUniPs, "")
                        ENDIF

                        IF USED("cursor_4c_BcbPro")
                            USE IN cursor_4c_BcbPro
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BcbEtq")
                    USE IN cursor_4c_BcbEtq
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvHst (par_cAliasCursor) para
    * as propriedades do BO. Usado por CarregarPorCodigo() quando for preciso
    * reabrir um historico de baixa ja gravado.
    *
    * Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
    * Regra [[feedback_tratarnulo_2o_arg_eh_valor_padrao]]: o 2o argumento de
    * TratarNulo() eh o VALOR PADRAO do tipo da coluna, nunca um codigo "C"/
    * "N"/"D" - "" para char, 0 para numeric, {} para datetime.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nCodBarras    = TratarNulo(codbarras, 0)
                THIS.this_cUsuars       = TratarNulo(usuars, "")
                THIS.this_cOpers        = TratarNulo(opers, "")
                THIS.this_cCpros        = TratarNulo(cpros, "")
                THIS.this_tDatas        = TratarNulo(datas, {})
                THIS.this_tDatars       = TratarNulo(datars, {})
                THIS.this_cDopes        = TratarNulo(dopes, "")
                THIS.this_cEmpos        = TratarNulo(empos, "")
                THIS.this_cGrupos       = TratarNulo(grupos, "")
                THIS.this_cEstos        = TratarNulo(estos, "")
                THIS.this_nNumes        = TratarNulo(numes, 0)
                THIS.this_cCidChavesHst = TratarNulo(cidchaves, "")
                THIS.this_cEmpDopNums   = TratarNulo(empdopnums, "")
                THIS.this_cEmpGruEsts   = TratarNulo(empgruests, "")
                THIS.this_tDtAlts       = TratarNulo(dtalts, {})
                THIS.this_cOriDopNums   = TratarNulo(oridopnums, "")
                THIS.this_nSeqs         = TratarNulo(seqs, 0)
                THIS.this_cCodCors      = TratarNulo(codcors, "")
                THIS.this_cCodTams      = TratarNulo(codtams, "")
                THIS.this_nQtds         = TratarNulo(qtds, 0)
                THIS.this_nPesos        = TratarNulo(pesos, 0)
                THIS.this_nCbars        = THIS.this_nCodBarras

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - "BaixaBarra" do legado: grava o movimento de baixa inteiro
    * (SigMvCab + SigMvHst) e zera a etiqueta em SigOpEtq, tudo num UNICO
    * SQLEXEC.
    *
    * [[feedback_begin_commit_via_sqlexec_nao_protege]] - BEGIN/COMMIT via
    * SQLEXEC separados NAO sao atomicos (a conexao nasce com Transactions=2
    * e @@TRANCOUNT ja vale 1): por isso o lote inteiro vai num SQLEXEC so,
    * com SAVE TRANSACTION quando ja ha transacao aberta - mesmo padrao do
    * ProdutoBO.CopiarProduto (Erro188).
    *
    * As colunas NOT NULL sem DEFAULT que o legado grava em branco (nao
    * aparecem no "Insert Into" do BaixaBarra, porque o AddCursor/
    * TableUpdate do legado grava o registro inteiro) recebem aqui o default
    * do tipo - regra CLAUDE.md #22. Lista tirada de docs\schema.sql.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSigKeys, loc_tDatas, loc_nSeqHst, loc_cCidChavesHst
        LOCAL loc_cEmpDopNums, loc_cEmpGruEsts
        LOCAL loc_cColsCab, loc_cValsCab, loc_cColsHst, loc_cValsHst
        LOCAL loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        *-- O Form chama Inserir() DIRETO (nao via BusinessBase.Salvar()), que
        *-- eh quem normalmente zera estes dois e chama ExibirFalha(). Zerar
        *-- aqui mantem o contrato da regra CLAUDE.md #20 valendo: quem exibe
        *-- marca this_lErroExibido, e o chamador so completa a mensagem
        *-- quando ela sobrou sem ser mostrada.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF !THIS.this_lEtiquetaLocalizada
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo n" + CHR(227) + "o localizado."
            ELSE
                IF THIS.this_lEtiquetaBaixada
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo j" + CHR(225) + " foi baixado."
                ELSE
                    *-- 1) Chaves e numeros gerados pelo legado - fGerUniqueKey/
                    *--    fGerMascara/fUniqueIds (utils\functions.prg).
                    loc_cSigKeys = THIS.CarregarSigKeys()

                    loc_tDatas = DATETIME()
                    THIS.this_tDatas     = loc_tDatas
                    THIS.this_tDatars    = loc_tDatas
                    THIS.this_tDtAlts    = loc_tDatas
                    THIS.this_nCodBarras = THIS.this_nCbars

                    *-- lnNum = fGerUniqueKey(Alltrim(lcDop) + lcEmp)
                    THIS.this_nNumes   = fGerUniqueKey(ALLTRIM(THIS.this_cDopes) + ALLTRIM(THIS.this_cEmpos))
                    THIS.this_cMascNum = fGerMascara(THIS.this_nNumes)
                    THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)

                    *-- Chaves posicionais (regra CLAUDE.md #42) - PADR na
                    *-- largura da COLUNA, nunca ALLTRIM: Empos char(3) +
                    *-- Dopes char(20) + Str(Numes,6) = 29 = EmpDopNums char(29).
                    loc_cEmpDopNums = PADR(THIS.this_cEmpos, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
                    THIS.this_cEmpDopNums = loc_cEmpDopNums
                    THIS.this_cOriDopNums = loc_cEmpDopNums

                    loc_cEmpGruEsts = PADR(THIS.this_cEmpos, 3) + PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10)
                    THIS.this_cEmpGruEsts = loc_cEmpGruEsts

                    THIS.this_cGrupoOs = THIS.this_cGrupos
                    THIS.this_cContaOs = THIS.this_cContas
                    THIS.this_cEstos   = THIS.this_cContas

                    *-- pCidC = Dtos(pDat)+'S'+Transform(fGerUniqueKey(Dtos(pDat)),"@L 999999")+ThisForm.Sigkey
                    loc_nSeqHst = fGerUniqueKey(DTOS(loc_tDatas))
                    loc_cCidChavesHst = DTOS(loc_tDatas) + "S" + PADL(ALLTRIM(STR(loc_nSeqHst)), 6, "0") + ALLTRIM(loc_cSigKeys)
                    THIS.this_cCidChavesHst = loc_cCidChavesHst

                    *-- pSeq = fGerUniqueKey('HISTBAR')
                    THIS.this_nSeqs = fGerUniqueKey("HISTBAR")

                    *-- 2) Colunas NOT NULL sem DEFAULT que o legado nao grava
                    *--    explicitamente (ver cabecalho do metodo).
                    loc_cColsCab = "npedclis, acres, antecs, chksubn, codpeds, contads, " + ;
                        "desc2s, descs, devols, empds, grresps, grupods, " + ;
                        "grupos, grvends, iclis, ifors, locals, lotechqs, " + ;
                        "lprecos, ncarnecs, nemps, nops, notas, nrcons, " + ;
                        "ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                        "transps, usuals, usulibs, valacres, valdes2s, valdescs, " + ;
                        "valdevs, valencs, valinis, valos, valservs, valvars, " + ;
                        "vars, vends, cotusus, espes, qtdes, lcancelas, " + ;
                        "cofs, livros, chkbxparcs, ecfs, codobs, dgopes, " + ;
                        "trfisicos, utilizados, valndevs, valobxs, noforms, auditors, " + ;
                        "empgopnums, contaes, localents, localizas, chkpagos, chkpgs, " + ;
                        "codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, " + ;
                        "motdscs, ndeclaras, numbalds, numbals, priors, procbals, " + ;
                        "procdbal, protats, usupagos, ultgrvs, moeits, rnops, " + ;
                        "impress, pstatus, valvarps, cifccfs, cupfis, idconta, " + ;
                        "ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, " + ;
                        "jobs, ptax1s, ptax2s, ptax3s, obscabmovs, codobs2"

                    loc_cValsCab = FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + "0" + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + "0" + ", " + ;
                        "0" + ", " + "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
                        "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + "0" + ", " + "0" + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        EscaparSQL("") + ", " + EscaparSQL("")

                    loc_cColsHst = "codcors, codtams, qtds, sqtds, teqtds, totas, " + ;
                        "tsqtds, units, moedas, numolds, ntrans, locals, " + ;
                        "unitmeds, moedmeds, recalmeds, auditors, pesos, spesos, " + ;
                        "unitmfis, bcipis, medipis"

                    loc_cValsHst = EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,3) + ", " + ;
                        FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,6) + ", " + ;
                        EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,6) + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
                        FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,3) + ", " + FormatarNumeroSQL(0,6) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
                        FormatarNumeroSQL(0,6)

                    *-- 3) INSERT em SigMvCab, INSERT em SigMvHst e UPDATE em
                    *--    SigOpEtq, num UNICO lote (ver cabecalho do metodo).
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
SET NOCOUNT ON;
DECLARE @nivel4c int = @@TRANCOUNT;
IF @nivel4c = 0 BEGIN TRANSACTION
ELSE SAVE TRANSACTION Baixa4c;
BEGIN TRY
    INSERT INTO SigMvCab (Emps, Dopes, Numes, MascNum, GrupoOs, ContaOs, Datas, Usuars, EmpDopNums, cIdChaves, DtAlts, <<loc_cColsCab>>)
    VALUES (<<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cDopes)>>, <<FormatarNumeroSQL(THIS.this_nNumes,0)>>, <<EscaparSQL(THIS.this_cMascNum)>>, <<EscaparSQL(THIS.this_cGrupoOs)>>, <<EscaparSQL(THIS.this_cContaOs)>>, <<FormatarDataSQL(THIS.this_tDatas)>>, <<EscaparSQL(THIS.this_cUsuars)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<EscaparSQL(THIS.this_cCidChaves)>>, <<FormatarDataSQL(THIS.this_tDtAlts)>>, <<loc_cValsCab>>);

    INSERT INTO SigMvHst (CodBarras, Usuars, Opers, Cpros, Datas, Datars, Dopes, Empos, Emps, Grupos, Estos, Numes, Cidchaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs, <<loc_cColsHst>>)
    VALUES (<<FormatarNumeroSQL(THIS.this_nCodBarras,0)>>, <<EscaparSQL(THIS.this_cUsuars)>>, <<EscaparSQL(THIS.this_cOpers)>>, <<EscaparSQL(THIS.this_cCpros)>>, <<FormatarDataSQL(THIS.this_tDatas)>>, <<FormatarDataSQL(THIS.this_tDatars)>>, <<EscaparSQL(THIS.this_cDopes)>>, <<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cEmpos)>>, <<EscaparSQL(THIS.this_cGrupos)>>, <<EscaparSQL(THIS.this_cEstos)>>, <<FormatarNumeroSQL(THIS.this_nNumes,0)>>, <<EscaparSQL(loc_cCidChavesHst)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<EscaparSQL(loc_cEmpGruEsts)>>, <<FormatarDataSQL(THIS.this_tDtAlts)>>, <<EscaparSQL(loc_cEmpDopNums)>>, <<FormatarNumeroSQL(THIS.this_nSeqs,0)>>, <<loc_cValsHst>>);

    UPDATE SigOpEtq SET Grupos = '', Contas = '', DtMovs = <<FormatarDataSQL(loc_tDatas)>>, Usuars = <<EscaparSQL(THIS.this_cUsuars)>> WHERE CBars = <<FormatarNumeroSQL(THIS.this_nCbars,0)>>;

    IF @nivel4c = 0 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @nivel4c = 0
    BEGIN
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        IF XACT_STATE() = 1 ROLLBACK TRANSACTION Baixa4c;
    END;
    THROW;
END CATCH
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado >= 0
                        THIS.this_lEtiquetaBaixada = .T.
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao gravar a baixa do c" + CHR(243) + "digo de barras:" + CHR(13) + CapturarErroSQL()
                        MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - sem equivalente no legado: o BaixaBarra SEMPRE cria um novo
    * par de registros (SigMvCab/SigMvHst) a cada confirmacao; nunca altera
    * um movimento ja gravado. O correto aqui eh recusar.
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "A baixa de c" + CHR(243) + "digo de barras sempre " + ;
            "gera um novo registro de movimento; n" + CHR(227) + "o h" + CHR(225) + ;
            " altera" + CHR(231) + CHR(227) + "o de baixa existente."
        RETURN .F.
    ENDPROC

ENDDEFINE

