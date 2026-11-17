*==============================================================================
* SigOpRobBO.PRG
* Business Object do formulario SigOpRob (dialogo de exibicao de texto)
* Responsabilidade: manter os dados exibidos pelo dialogo somente-leitura
* que o legado SIGOPROB.SCX usava para mostrar um texto ao usuario.
*
* ORIGEM (SIGOPROB.SCX - PROCEDURE Init):
*     Lparameters pcTitulo, pcTexto, poForm
*     ThisForm.Caption = pcTitulo
*     ThisForm.Edit1.Value = pcTexto
*     ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
*     ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
*     ThisForm.poParentForm = poForm
*
* SigOpRob NAO possui tabela associada no banco: o dump do legado nao tem
* Dataenvironment com cursor, nao tem AddCursor, nao tem SQL e nao tem
* TABLEUPDATE (comportamento.json: temSQL=false, totalQueries=0, 2 metodos).
* O conteudo exibido chega PRONTO pelos parametros do Init, vindo do form
* chamador. Por isso this_cTabela e this_cCampoChave permanecem vazios, e a
* verificacao no schema canonico (docs/schema.sql, 682 tabelas) confirma que
* nenhuma tabela SIGOPROB existe.
*
* O terceiro parametro do Init legado (poForm) e uma REFERENCIA DE OBJETO
* para o formulario chamador, usada apenas para reabilita-lo ao fechar
* (CmdSair.Click: ThisForm.poParentForm.Enabled = .T.). Por ser estado de
* INTERFACE, e nao dado de negocio, essa referencia fica na propriedade
* this_oFormChamador do proprio Form (camada UI) e NAO no Business Object -
* guardar referencia de Form dentro do BO criaria referencia circular e
* seguraria o formulario em memoria apos o Release.
*==============================================================================

DEFINE CLASS SigOpRobBO AS BusinessBase

    *-- Propriedades de dados (espelham os parametros de dados do Init legado)
    this_cTitulo = ""       && pcTitulo - titulo do dialogo (Caption do Form,
                            && lblSombra.Caption e lblTitulo.Caption)
    this_cTexto  = ""       && pcTexto  - conteudo exibido no EditBox somente
                            && leitura (Edit1.Value, ReadOnly = .T.)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Recebe os mesmos dados do Init legado (titulo e texto). Os parametros
    * sao opcionais: quando ausentes, as propriedades ficam vazias e o Form
    * preenche depois via FormParaBO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cTitulo, par_cTexto)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        *-- SigOpRob e um dialogo de exibicao, sem tabela e sem chave primaria
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Inicializa o estado padrao herdado (edicao/novo registro/alterado)
        DODEFAULT()

        *-- Titulo do dialogo (pcTitulo no legado)
        IF VARTYPE(par_cTitulo) = "C"
            THIS.this_cTitulo = par_cTitulo
        ELSE
            THIS.this_cTitulo = ""
        ENDIF

        *-- Texto exibido no EditBox (pcTexto no legado)
        IF VARTYPE(par_cTexto) = "C"
            THIS.this_cTexto = par_cTexto
        ELSE
            THIS.this_cTexto = ""
        ENDIF

        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades de dados do dialogo
    * Sobrescreve BusinessBase.LimparDados para limpar tambem as propriedades
    * especificas desta classe, mantendo a limpeza da mensagem de erro feita
    * pela classe base.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cTitulo = ""
        THIS.this_cTexto  = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FASE 2 - Decisao de arquitetura: metodos de persistencia herdados
    *
    * SigOpRob nao tem tabela, cursor ou SQL no legado (ver cabecalho da
    * classe): o Init recebe o texto PRONTO via parametro e o unico botao
    * (CmdSair.Click) apenas libera a janela e reabilita o form chamador -
    * nao ha Insert Into, Update, Delete From, AddCursor nem TableUpdate em
    * SIGOPROB.SCX (tasks\task796\SigOpRob_form_codigo_fonte.txt, 2 metodos,
    * comportamento.json com totalQueries=0).
    *
    * Por isso os metodos de persistencia da BusinessBase ficam herdados,
    * sem sobrescrita nesta classe:
    *   - CarregarDoCursor(pcCursor): este dialogo nao tem cursor para
    *     carregar; o comportamento herdado (retorna .T. sem tocar em
    *     dados) ja eh o correto para este caso.
    *   - Inserir()/Atualizar(): nao ha coluna nenhuma para gravar - o
    *     comportamento herdado de BusinessBase (recusar a operacao) ja eh
    *     o correto. Sobrescrever com um Insert/Update inventado violaria a
    *     regra de que a lista de colunas vem do schema, nunca de
    *     suposicao (nao existe tabela SIGOPROB no schema canonico).
    *   - ObterChavePrimaria(): nao existe chave primaria para este
    *     dialogo; o retorno herdado (string vazia) ja eh o correto.
    *   - RegistrarAuditoria(): como Inserir()/Atualizar() nunca gravam
    *     nada nesta classe, este metodo nunca eh acionado por ela.
    *--------------------------------------------------------------------------

ENDDEFINE
