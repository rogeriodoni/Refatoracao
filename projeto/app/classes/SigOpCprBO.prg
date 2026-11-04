*==============================================================================
* SigOpCprBO.prg - Business Object para Copia de Processo (SIGOPCPR)
*
* Form OPERACIONAL de DIALOGO (WindowType = 1, TitleBar = 0, ControlBox = .F.,
* AutoCenter = .T., Height = 157, Width = 800) aberto por um form PAI - o Init
* legado recebe "LParameters poForm, pOperacao, pComissao" e guarda
* .ParentForm = poForm / .poDataMgr = poForm.poDataMgr / .pComis = pComissao.
*
* A tela tem DOIS campos e DOIS botoes:
*   GetOrigem  - codigo de ORIGEM, recebido em pOperacao. O "When" devolve .f.,
*                isto eh, o campo eh EXIBIDO mas nao recebe foco nem edicao.
*   GetDestino - codigo NOVO, digitado pelo usuario. O "Valid" recusa codigo
*                que JA exista na tabela de destino.
*   CmdCopia   - executa a copia (cabecalho + itens) e fecha o dialogo.
*   CmdExit    - fecha o dialogo sem copiar ("Release Windows", Cancel = .T.).
*
* DUAS MODALIDADES NO MESMO FORM - a flag pComis decide tudo
* ----------------------------------------------------------
* O legado usa a MESMA tela para copiar duas coisas diferentes, e a unica
* diferenca eh o valor de pComissao recebido do form pai:
*
*   pComis = .T.  -> copia CADASTRO DE COMISSAO : SigCmCab (cabecalho)
*                                               + SigCmItn (itens)
*                    chave do usuario: SigCmCab.cods      char(40)
*                    largura do campo na tela: 290 / MaxLength 40
*
*   pComis = .F.  -> copia PROCESSO             : SigPcOop (cabecalho)
*                                               + SigPcOoI (itens)
*                    chave do usuario: SigPcOop.processos char(20)
*                    largura do campo na tela: 150 / MaxLength 20
*
* As larguras e os MaxLength acima estao no Init legado e NAO sao palpite -
* por isso viram propriedades (this_nTamCods / this_nTamProcessos) em vez de
* numero solto espalhado pelo codigo. O PADR com essas larguras eh obrigatorio
* nas consultas: o legado escreve Padr(This.Value, 40) / Padr(this.Value, 20) e
* a comparacao com o valor gravado depende do padding da coluna char (regra
* #42 - chave posicional).
*
* MAPEAMENTO DAS COLUNAS SOBRESCRITAS NA COPIA
* --------------------------------------------
* O legado copia o registro INTEIRO com "Scatter Memvar Memo" +
* "Insert Into <cursor> From Memvar" e depois SOBRESCREVE um punhado de
* colunas. Sao essas - e SO essas - que precisam de propriedade no BO; o resto
* das colunas eh copiado tal e qual (tipos conferidos em docs/schema.sql, lido
* com Get-Content -Raw por ser UTF-16 - regra #14):
*
*   MODO COMISSAO (ramo If ThisForm.pComis do CmdCopia.Click)
*     SigCmCab.cods      char(40) NOT NULL  <- getDestino.Value  -> this_cCods
*     SigCmCab.pkchaves  char(20) NOT NULL  <- fUniqueIds()      -> this_cPkchaves
*     SigCmCab.usuars    char(10) NOT NULL  <- usuario logado    -> this_cUsuars
*     SigCmCab.datas     datetime NULL      <- Datetime()        -> this_tDatas
*     SigCmItn.fkchaves  char(20) NOT NULL  <- mesma pkchaves    -> this_cFkchaves
*     SigCmItn.pkchaves  char(20) NOT NULL  <- fUniqueIds() POR LINHA
*
*   MODO PROCESSO (ramo Else do CmdCopia.Click)
*     SigPcOop.processos char(20) NOT NULL  <- getDestino.Value  -> this_cProcessos
*     SigPcOop.codigos   numeric(6,0) NN    <- fGerUniqueKey     -> this_nCodigos
*     SigPcOoI.processos char(20) NOT NULL  <- getDestino.Value  -> this_cProcessos
*     SigPcOoI.codigos   numeric(6,0) NN    <- mesmo this_nCodigos
*     SigPcOoI.cidchaves char(20) NOT NULL  <- fUniqueIds() POR LINHA
*
* O "POR LINHA" dos itens eh regra, nao detalhe: pkchaves (SigCmItn) e
* cidchaves (SigPcOoI) sao PRIMARY KEY das respectivas tabelas (constraint
* sigpcooi_cidchaves e a PK clustered de SigCmItn em docs/schema.sql), entao um
* unico valor reaproveitado para todos os itens colidiria no indice unico a
* partir do segundo registro.
*
* O CONTADOR DO PROCESSO
* ----------------------
* No modo processo o legado chama fGerUniqueKey('SigPcOoP') - contador
* persistido em dbo.SIGSYSEQ - para emitir o novo SigPcOop.codigos, que eh a
* PRIMARY KEY da tabela (constraint sigpcoop_codigos). A chave do contador vai
* em this_cChaveSequencia com a grafia EXATA do legado ('SigPcOoP', com o P
* final maiusculo), porque eh o conteudo da coluna SIGSYSEQ.valor. Retorno 0
* significa que o contador nao emitiu numero e aborta a copia - eh o mesmo
* sentinela que o proprio legado testa.
*
* GRAVACAO ATOMICA
* ----------------
* A copia escreve em DUAS tabelas (cabecalho + N itens) e o legado trata isso
* como uma coisa so: ele enfileira tudo nos cursores remotos (crSigCmCab /
* crSigCmItn / crSigPcOop / crSigPcOoI) e descarrega com dois poDataMgr.UpDate
* seguidos de UM poDataMgr.Commit(). Na arquitetura nova o equivalente fiel eh
* mandar os INSERT num LOTE unico de SQLEXEC com controle de transacao em
* T-SQL (DECLARE @nivel = @@TRANCOUNT / BEGIN TRANSACTION ou SAVE TRANSACTION
* / BEGIN TRY ... END TRY / BEGIN CATCH ... THROW): a conexao deste ambiente
* nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao BEGIN e COMMIT
* enviados em SQLEXEC separados apenas ANINHAM e nao protegem nada. Por isso
* this_cNomeSavepoint guarda o nome do savepoint usado no lote.
*
* AUDITORIA DO LEGADO
* -------------------
* O ramo de processo termina com fGravarLog([C], Thisform.Name, [COPIA],
* crSigPcOop.Processos) - por isso this_cProgramaLog = "SIGOPCPR" (o
* ThisForm.Name do legado, nao o nome da classe nova) e
* this_cOperacaoLog = "COPIA". O wrapper utils\fgravarlog.prg existe e eh um
* no-op documentado; a auditoria propria do sistema novo
* (BusinessBase.RegistrarAuditoria -> LogAuditoria) eh independente dele.
*
* Tabela principal declarada em this_cTabela: SigPcOop (chave primaria
* codigos), que eh a modalidade default do dialogo (pComis = .F.).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCprBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DO DIALOGO (recebidos do form pai)
    *==========================================================================

    *-- pComis do legado. Decide qual par de tabelas eh copiado, a largura e o
    *-- MaxLength dos dois TextBox, e qual validacao o GetDestino.Valid faz.
    this_lComissao        = .F.

    *-- GetOrigem.Value - vem de pOperacao no Init legado
    *-- (ThisForm.GetOrigem.Value = pOperacao). Em modo comissao eh
    *-- SigCmCab.cods char(40); em modo processo eh SigPcOop.processos char(20).
    this_cOrigem          = ""

    *-- GetDestino.Value - o codigo NOVO digitado pelo usuario.
    this_cDestino         = ""

    *==========================================================================
    * NOMES DE TABELA (PILAR 2 - grafia EXATA do banco)
    *==========================================================================
    this_cTabelaProcCab   = "SigPcOop"   && cabecalho do processo
    this_cTabelaProcItn   = "SigPcOoI"   && itens do processo
    this_cTabelaComCab    = "SigCmCab"   && cabecalho da comissao
    this_cTabelaComItn    = "SigCmItn"   && itens da comissao

    *==========================================================================
    * CONSTANTES DO LEGADO (larguras e chave do contador)
    *==========================================================================

    *-- SigPcOop.processos char(20) - Padr(this.Value, 20) do GetDestino.Valid
    *-- e largura/MaxLength do campo em modo processo.
    this_nTamProcessos    = 20

    *-- SigCmCab.cods char(40) - Padr(This.Value, 40) do GetDestino.Valid e
    *-- largura/MaxLength do campo em modo comissao.
    this_nTamCods         = 40

    *-- SigCmCab.pkchaves / SigCmItn.pkchaves / SigCmItn.fkchaves /
    *-- SigPcOoI.cidchaves - todas char(20).
    this_nTamChaves       = 20

    *-- SigCmCab.usuars e SigCmCab.usualts - char(10).
    this_nTamUsuario      = 10

    *-- Argumento de fGerUniqueKey no ramo de processo. Eh o conteudo da coluna
    *-- dbo.SIGSYSEQ.valor, com a grafia do legado.
    this_cChaveSequencia  = "SigPcOoP"

    *-- Nome do savepoint do lote T-SQL que torna a copia atomica.
    this_cNomeSavepoint   = "Cpr4c"

    *==========================================================================
    * COLUNAS SOBRESCRITAS NA COPIA
    *==========================================================================

    *-- SigPcOop.processos / SigPcOoI.processos char(20) NOT NULL - recebe o
    *-- codigo de destino em modo processo.
    this_cProcessos       = ""

    *-- SigPcOop.codigos / SigPcOoI.codigos numeric(6,0) NOT NULL - numero
    *-- emitido por fGerUniqueKey(this_cChaveSequencia). PK de SigPcOop.
    this_nCodigos         = 0

    *-- SigPcOoI.cidchaves char(20) NOT NULL - PK dos itens do processo,
    *-- fUniqueIds() uma vez por linha copiada.
    this_cCidchaves       = ""

    *-- SigCmCab.cods char(40) NOT NULL - recebe o codigo de destino em modo
    *-- comissao.
    this_cCods            = ""

    *-- SigCmCab.pkchaves char(20) NOT NULL - PK do cabecalho de comissao novo
    *-- (o lcKey = fUniqueIds() do legado). Eh tambem o valor gravado em
    *-- SigCmItn.fkchaves de todos os itens copiados.
    this_cPkchaves        = ""

    *-- SigCmItn.fkchaves char(20) NOT NULL - amarra o item ao cabecalho novo.
    this_cFkchaves        = ""

    *-- SigCmCab.usuars char(10) NOT NULL - usuario logado (o Usuars do
    *-- Replace legado).
    this_cUsuars          = ""

    *-- SigCmCab.datas datetime NULL - Datetime() no momento da copia.
    this_tDatas           = {}

    *==========================================================================
    * ORIGEM LIDA DO BANCO (o que o SELECT do legado traz antes de copiar)
    *==========================================================================

    *-- SigCmCab.pkchaves do registro de ORIGEM. Eh o filtro dos itens de
    *-- origem: o legado consulta SigCmItn Where fkChaves =
    *-- Padr(LocalCmCab.pkChaves, 20).
    this_cPkchavesOrigem  = ""

    *-- SigPcOop.codigos do registro de ORIGEM, lido junto com o cabecalho.
    this_nCodigosOrigem   = 0

    *-- .T. quando a consulta de origem achou o registro (o
    *-- Not Eof([LocalCmCab]) / Select csSigPcOop do legado).
    this_lOrigemEncontrada = .F.

    *==========================================================================
    * RESULTADO DA OPERACAO
    *==========================================================================

    *-- .T. depois que o lote de INSERT foi confirmado.
    this_lCopiaRealizada  = .F.

    *-- Quantas linhas de item foram copiadas (SigCmItn ou SigPcOoI).
    this_nItensCopiados   = 0

    *-- .T. quando o codigo de destino digitado JA existe na tabela - eh o que
    *-- faz o GetDestino.Valid recusar o valor com "Processo J" + a-acento +
    *-- " Cadastrado" (modo processo) ou com a mensagem de descricao de
    *-- comissao ja informada (modo comissao).
    this_lDestinoDuplicado = .F.

    *==========================================================================
    * CURSORES DE TRABALHO
    *
    * Nomes com o prefixo cursor_4c_ do PILAR 3 (os LocalBus / LocalCmCab /
    * LocalCmItn / csSigPcOop / csSigPcOoI do legado). Nenhum deles eh
    * consumido por FRX, entao o prefixo eh o correto.
    *==========================================================================
    this_cCursorValida    = "cursor_4c_CprValida"   && LocalBus - duplicidade
    this_cCursorCabecalho = "cursor_4c_CprCab"      && LocalCmCab / csSigPcOop
    this_cCursorItens     = "cursor_4c_CprItn"      && LocalCmItn / csSigPcOoI

    *-- Lista de colunas da tabela, lida do INFORMATION_SCHEMA para montar o
    *-- INSERT ... SELECT da copia (ver ObterListaColunas). Nao tem paralelo no
    *-- legado: la o "Scatter Memvar Memo" resolve a lista de colunas sozinho.
    this_cCursorColunas   = "cursor_4c_CprCols"

    *==========================================================================
    * LOTE DA GRAVACAO
    *
    * O legado enfileira cabecalho e itens nos cursores remotos e descarrega
    * tudo no fim (dois poDataMgr.UpDate + um Commit). O equivalente fiel aqui
    * eh acumular os INSERT em this_cLoteCopia e manda-los num SQLEXEC unico,
    * com transacao em T-SQL (ver ExecutarLoteCopia).
    *==========================================================================
    this_cLoteCopia       = ""

    *-- Nome da tabela que esta sendo gravada, para a mensagem de erro dizer em
    *-- QUAL das duas o lote parou (cabecalho ou itens).
    this_cEtapaAtual      = ""

    *-- Chaves de item ja emitidas neste lote, no formato "|<chave>|", para
    *-- GerarChaveItem nunca repetir uma PK dentro da mesma copia.
    this_cChavesGeradas   = ""

    *==========================================================================
    * AUDITORIA DO LEGADO (fGravarLog)
    *==========================================================================
    this_cProgramaLog     = "SIGOPCPR"   && ThisForm.Name do legado
    this_cOperacaoLog     = "COPIA"      && 3o argumento de fGravarLog
    this_cTipoLog         = "C"          && 1o argumento de fGravarLog

    *==========================================================================
    * Init - Fixa tabela/chave e zera o estado do dialogo
    *
    * Equivale ao Init legado na parte que eh de NEGOCIO: guardar pComis e o
    * codigo de origem. O que o Init legado faz de UI (Caption nos dois labels
    * da faixa, largura e MaxLength dos TextBox, Refresh do GetOrigem) fica no
    * form, que le as larguras das propriedades this_nTamProcessos /
    * this_nTamCods declaradas acima.
    *
    * this_cTabela = "SigPcOop" com this_cCampoChave = "codigos" porque essa eh
    * a PRIMARY KEY da tabela (constraint sigpcoop_codigos) e a modalidade
    * default do dialogo eh a de processo (pComis = .F.).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigPcOop")

            THIS.this_cTabela     = "SigPcOop"
            THIS.this_cCampoChave = "codigos"

            *-- Nomes de tabela (grafia exata do banco - PILAR 2).
            THIS.this_cTabelaProcCab = "SigPcOop"
            THIS.this_cTabelaProcItn = "SigPcOoI"
            THIS.this_cTabelaComCab  = "SigCmCab"
            THIS.this_cTabelaComItn  = "SigCmItn"

            *-- Constantes transcritas do Init / Valid / Click legado.
            THIS.this_nTamProcessos   = 20
            THIS.this_nTamCods        = 40
            THIS.this_nTamChaves      = 20
            THIS.this_nTamUsuario     = 10
            THIS.this_cChaveSequencia = "SigPcOoP"
            THIS.this_cNomeSavepoint  = "Cpr4c"

            *-- Estado inicial: dialogo recem-aberto, modalidade de processo,
            *-- nada lido do banco, nada copiado.
            THIS.this_lComissao         = .F.
            THIS.this_cOrigem           = ""
            THIS.this_cDestino          = ""
            THIS.this_cProcessos        = ""
            THIS.this_nCodigos          = 0
            THIS.this_cCidchaves        = ""
            THIS.this_cCods             = ""
            THIS.this_cPkchaves         = ""
            THIS.this_cFkchaves         = ""
            THIS.this_tDatas            = {}
            THIS.this_cPkchavesOrigem   = ""
            THIS.this_nCodigosOrigem    = 0
            THIS.this_lOrigemEncontrada = .F.
            THIS.this_lCopiaRealizada   = .F.
            THIS.this_nItensCopiados    = 0
            THIS.this_lDestinoDuplicado = .F.

            *-- Nomes dos cursores de trabalho.
            THIS.this_cCursorValida    = "cursor_4c_CprValida"
            THIS.this_cCursorCabecalho = "cursor_4c_CprCab"
            THIS.this_cCursorItens     = "cursor_4c_CprItn"
            THIS.this_cCursorColunas   = "cursor_4c_CprCols"

            *-- Lote de gravacao vazio: nada enfileirado ainda.
            THIS.this_cLoteCopia     = ""
            THIS.this_cEtapaAtual    = ""
            THIS.this_cChavesGeradas = ""

            *-- Dados da chamada a fGravarLog do ramo de processo.
            THIS.this_cProgramaLog = "SIGOPCPR"
            THIS.this_cOperacaoLog = "COPIA"
            THIS.this_cTipoLog     = "C"

            *-- Usuario logado, gravado em SigCmCab.usuars. Guardado aqui (e
            *-- nao lido direto na hora do INSERT) para que o valor seja o
            *-- mesmo do inicio ao fim da operacao.
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), THIS.this_nTamUsuario)
            ENDIF

            *-- Estado de edicao herdado de BusinessBase: este dialogo nao
            *-- edita registro, ele copia - entao nasce fora de edicao.
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_cMensagemErro   = ""
            THIS.this_lErroExibido    = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SigOpCprBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfigurarModalidade - Recebe os parametros que o form pai passa
    *
    * Equivale as atribuicoes do Init legado (ThisForm.pComis = pComissao e
    * ThisForm.GetOrigem.Value = pOperacao), com a diferenca de que aqui elas
    * ficam no BO: eh a flag pComis que decide tabela, largura do campo e
    * validacao, e isso eh regra de negocio, nao UI.
    *
    * par_lComissao - .T. copia cadastro de comissao, .F. copia processo
    * par_cOperacao - codigo de ORIGEM (o pOperacao do legado)
    *==========================================================================
    PROCEDURE ConfigurarModalidade(par_lComissao, par_cOperacao)
        LOCAL loc_nTamanho

        THIS.this_lComissao = IIF(VARTYPE(par_lComissao) = "L", par_lComissao, .F.)

        *-- A tabela "do BO" eh a da modalidade: comissao -> SigCmCab
        *-- (PK pkchaves), processo -> SigPcOop (PK codigos). Sem isto a
        *-- auditoria de BusinessBase.RegistrarAuditoria gravaria SEMPRE
        *-- "SigPcOop" em LogAuditoria.Tabela, inclusive quando a copia foi de
        *-- cadastro de comissao. O this_oDataAccess criado no Init continua
        *-- apontando para SigPcOop e nao eh usado por este dialogo: a copia
        *-- nao passa por Buscar/DataAccess, ela monta o proprio SQL.
        THIS.this_cTabela     = THIS.ObterTabelaCabecalho()
        THIS.this_cCampoChave = IIF(THIS.this_lComissao, "pkchaves", "codigos")

        loc_nTamanho = THIS.ObterTamanhoChave()

        IF VARTYPE(par_cOperacao) = "C"
            THIS.this_cOrigem = LEFT(ALLTRIM(par_cOperacao), loc_nTamanho)
        ELSE
            THIS.this_cOrigem = ""
        ENDIF

        *-- Troca de modalidade descarta o que foi lido/digitado antes: o
        *-- codigo de destino de uma tabela nao vale para a outra.
        THIS.this_cDestino          = ""
        THIS.this_cPkchavesOrigem   = ""
        THIS.this_nCodigosOrigem    = 0
        THIS.this_lOrigemEncontrada = .F.
        THIS.this_lCopiaRealizada   = .F.
        THIS.this_nItensCopiados    = 0
        THIS.this_lDestinoDuplicado = .F.
        THIS.this_cMensagemErro     = ""
        THIS.this_lErroExibido      = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterTamanhoChave - Largura da coluna de codigo da modalidade corrente
    *
    * Modo comissao  -> 40 (SigCmCab.cods      char(40))
    * Modo processo  -> 20 (SigPcOop.processos char(20))
    *
    * Eh esse numero que o form usa no MaxLength dos dois TextBox e que as
    * consultas usam no PADR - o legado escreve Padr(This.Value, 40) no ramo de
    * comissao e Padr(this.Value, 20) no de processo.
    *==========================================================================
    FUNCTION ObterTamanhoChave()
        RETURN IIF(THIS.this_lComissao, THIS.this_nTamCods, THIS.this_nTamProcessos)
    ENDFUNC

    *==========================================================================
    * ObterTabelaCabecalho / ObterTabelaItens - Par de tabelas da modalidade
    *
    * Modo comissao -> SigCmCab / SigCmItn
    * Modo processo -> SigPcOop / SigPcOoI
    *==========================================================================
    FUNCTION ObterTabelaCabecalho()
        RETURN IIF(THIS.this_lComissao, THIS.this_cTabelaComCab, THIS.this_cTabelaProcCab)
    ENDFUNC

    FUNCTION ObterTabelaItens()
        RETURN IIF(THIS.this_lComissao, THIS.this_cTabelaComItn, THIS.this_cTabelaProcItn)
    ENDFUNC

    *==========================================================================
    * ObterCampoChave - Coluna que guarda o codigo digitado pelo usuario
    *
    * Modo comissao -> cods      (SigCmCab)
    * Modo processo -> processos (SigPcOop)
    *
    * Eh a coluna do Where da checagem de duplicidade do GetDestino.Valid.
    *==========================================================================
    FUNCTION ObterCampoChave()
        RETURN IIF(THIS.this_lComissao, "cods", "processos")
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave primaria do registro CRIADO pela copia,
    * usada pela auditoria de BusinessBase.
    *
    * Modo comissao -> SigCmCab.pkchaves char(20)
    * Modo processo -> SigPcOop.codigos  numeric(6,0)
    *
    * O PADR ate 20 no ramo de comissao existe porque a coluna eh char(20) e o
    * valor guardado na propriedade pode vir com ALLTRIM (regra #42). No ramo
    * de processo a chave eh numerica, entao vai como texto via TRANSFORM.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave

        IF THIS.this_lComissao
            loc_cChave = PADR(ALLTRIM(THIS.this_cPkchaves), THIS.this_nTamChaves)
        ELSE
            loc_cChave = ALLTRIM(TRANSFORM(THIS.this_nCodigos))
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * LimparDados - Zera o estado da operacao (hook de BusinessBase)
    *
    * Mantem a MODALIDADE e o codigo de ORIGEM: os dois vem do form pai no
    * ConfigurarModalidade e nao sao estado de uma copia, sao o contexto do
    * dialogo inteiro. Limpar os dois aqui faria o dialogo perder o processo
    * que ele esta copiando.
    *==========================================================================
    PROCEDURE LimparDados()
        THIS.this_cDestino          = ""
        THIS.this_cProcessos        = ""
        THIS.this_nCodigos          = 0
        THIS.this_cCidchaves        = ""
        THIS.this_cCods             = ""
        THIS.this_cPkchaves         = ""
        THIS.this_cFkchaves         = ""
        THIS.this_tDatas            = {}
        THIS.this_cPkchavesOrigem   = ""
        THIS.this_nCodigosOrigem    = 0
        THIS.this_lOrigemEncontrada = .F.
        THIS.this_lCopiaRealizada   = .F.
        THIS.this_nItensCopiados    = 0
        THIS.this_lDestinoDuplicado = .F.
        THIS.this_cMensagemErro     = ""
        THIS.this_lErroExibido      = .F.

        *-- Lote de uma copia anterior nao pode sobreviver para a proxima: ele
        *-- seria regravado junto, duplicando o registro ja copiado.
        THIS.this_cLoteCopia        = ""
        THIS.this_cEtapaAtual       = ""
        THIS.this_cChavesGeradas    = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FecharCursor - Fecha um alias com o guard de buffering da regra #52
    *
    * TABLEREVERT em cursor com Buffering = 1 dispara o erro 1586 "Function
    * requires row or table buffering mode"; USE IN fecha o alias mesmo com
    * buffer sujo, entao o TABLEREVERT so eh chamado quando ha buffering.
    *==========================================================================
    PROTECTED PROCEDURE FecharCursor(par_cAlias)
        IF VARTYPE(par_cAlias) <> "C" OR EMPTY(par_cAlias)
            RETURN .F.
        ENDIF

        IF USED(par_cAlias)
            IF CURSORGETPROP("Buffering", par_cAlias) > 1
                TABLEREVERT(.T., par_cAlias)
            ENDIF
            USE IN (par_cAlias)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores de trabalho do dialogo
    *==========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursor(THIS.this_cCursorValida)
        THIS.FecharCursor(THIS.this_cCursorCabecalho)
        THIS.FecharCursor(THIS.this_cCursorItens)
        THIS.FecharCursor(THIS.this_cCursorColunas)

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le o registro de ORIGEM do cursor
    *
    * Equivale ao que o legado faz implicitamente antes do "Scatter Memvar
    * Memo": ele seleciona o cursor de origem (LocalCmCab / csSigPcOop) e le
    * dali a chave que vai filtrar os itens. As colunas que este metodo guarda
    * sao SO as que a copia precisa conhecer:
    *
    *   modo comissao -> cods      (codigo de origem) e pkchaves (filtro dos
    *                              itens: SigCmItn Where fkChaves = pkchaves)
    *   modo processo -> processos (codigo de origem) e codigos  (PK do
    *                              cabecalho de origem)
    *
    * As demais colunas das quatro tabelas NUNCA passam pela memoria do VFP: a
    * copia delas eh feita server-side pelo INSERT ... SELECT de
    * MontarInsertCopia (ver nota de arquitetura no cabecalho do arquivo).
    *
    * O teste de existencia da coluna eh TYPE("<coluna>") != "U" depois do
    * SELECT do alias - PEMSTATUS exige OBJETO no 1o argumento e estoura com
    * nome de cursor. O IF por coluna existe porque o MESMO metodo atende os
    * dois cursores de origem, que tem colunas diferentes.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- Modo comissao: SigCmCab.cods / SigCmCab.pkchaves
                IF TYPE("cods") != "U"
                    THIS.this_cOrigem = ALLTRIM(TratarNulo(cods, ""))
                ENDIF
                IF TYPE("pkchaves") != "U"
                    THIS.this_cPkchavesOrigem = ALLTRIM(TratarNulo(pkchaves, ""))
                ENDIF

                *-- Modo processo: SigPcOop.processos / SigPcOop.codigos
                IF TYPE("processos") != "U"
                    THIS.this_cOrigem = ALLTRIM(TratarNulo(processos, ""))
                ENDIF
                IF TYPE("codigos") != "U"
                    THIS.this_nCodigosOrigem = TratarNulo(codigos, 0)
                ENDIF

                THIS.this_lOrigemEncontrada = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "SigOpCprBO.CarregarDoCursor")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOrigem - Consulta o cabecalho de ORIGEM e guarda a chave dele
    *
    * Transcreve as duas consultas do CmdCopia.Click legado:
    *
    *   comissao: Select * From SigCmCab Where Cods      = Padr(origem, 40)
    *   processo: Select * From SigPcOop Where Processos = Padr(origem, 20)
    *
    * TRES desvios deliberados, todos documentados:
    *
    * 1. TOP 1 + ORDER BY pela PRIMARY KEY. Nem "cods" (SigCmCab) nem
    *    "processos" (SigPcOop) sao unicas - as PK sao "pkchaves" e "codigos".
    *    O legado faz "Go Top" num resultado SEM ORDER BY, o que escolhe uma
    *    linha qualquer; aqui a linha escolhida eh deterministica, e eh essa
    *    mesma linha que o INSERT ... SELECT vai copiar (ele filtra pela PK
    *    lida aqui, nunca por cods/processos - senao, com duas linhas de mesmo
    *    codigo, a copia tentaria gravar DUAS vezes a mesma PK nova).
    *
    * 2. SELECT so das duas colunas de chave, nao "Select *": o resto do
    *    registro eh copiado server-side e nao precisa vir para o VFP.
    *
    * 3. Origem AUSENTE aborta com mensagem. No legado o modo comissao fica
    *    MUDO (o "If Not Eof([LocalCmCab])" simplesmente nao entra, e a tela
    *    fecha como se tivesse copiado) e o modo processo eh pior: ele faz
    *    Scatter/Append/Gather sobre cursor VAZIO, o que gravaria um registro
    *    EM BRANCO. Nos dois casos o silencio eh o defeito, nao a feature.
    *==========================================================================
    FUNCTION CarregarOrigem()
        LOCAL loc_lSucesso, loc_cOrigem, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        loc_cOrigem  = ALLTRIM(NVL(THIS.this_cOrigem, ""))

        THIS.this_lOrigemEncontrada = .F.

        IF EMPTY(loc_cOrigem)
            THIS.this_cMensagemErro = "Origem Inv" + CHR(225) + "lida !!!"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_lComissao
            loc_cSQL = "SELECT TOP 1 cods, pkchaves FROM " + THIS.this_cTabelaComCab + ;
                " WHERE cods = " + EscaparSQL(PADR(loc_cOrigem, THIS.this_nTamCods)) + ;
                " ORDER BY pkchaves"
        ELSE
            loc_cSQL = "SELECT TOP 1 processos, codigos FROM " + THIS.this_cTabelaProcCab + ;
                " WHERE processos = " + EscaparSQL(PADR(loc_cOrigem, THIS.this_nTamProcessos)) + ;
                " ORDER BY codigos"
        ENDIF

        THIS.FecharCursor(THIS.this_cCursorCabecalho)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCabecalho)

        DO CASE
            CASE loc_nResultado < 0
                *-- Mesma mensagem do legado quando o SqlExecute devolve < 1.
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    CapturarErroSQL()

            CASE !USED(THIS.this_cCursorCabecalho) OR RECCOUNT(THIS.this_cCursorCabecalho) = 0
                THIS.this_cMensagemErro = IIF(THIS.this_lComissao, ;
                    "Cadastro de Comiss" + CHR(227) + "o de origem n" + CHR(227) + "o encontrado !!!", ;
                    "Processo de origem n" + CHR(227) + "o encontrado !!!")

            OTHERWISE
                SELECT (THIS.this_cCursorCabecalho)
                GO TOP
                loc_lSucesso = THIS.CarregarDoCursor(THIS.this_cCursorCabecalho)
        ENDCASE

        THIS.FecharCursor(THIS.this_cCursorCabecalho)

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarDestino - Transcricao do GetDestino.Valid legado
    *
    * O legado recusa codigo de destino que JA exista na tabela de cabecalho:
    *
    *   comissao: Select * From SigCmCab Where Cods = Padr(valor, 40)
    *             -> "Descricao do Cadastro de Comissao Ja Informado!!!"
    *   processo: Select Processos From SigPcOop Where Processos = Padr(valor, 20)
    *             -> "Processo Ja Cadastrado!!!"
    *
    * O PADR com a largura da coluna (40 / 20) eh do legado e fica: a coluna eh
    * char de largura fixa e o SQL Server compara com blank-padding ANSI, entao
    * a forma com PADR eh equivalente a sem - e eh a que o dump escreve.
    *
    * Devolve .T. quando o valor PODE ser usado (nao existe e a consulta
    * rodou). Em qualquer recusa, this_cMensagemErro fica com o texto do legado
    * e this_lDestinoDuplicado registra o motivo - quem exibe eh o chamador (o
    * LostFocus do campo) ou o ExibirFalha do BusinessBase.Salvar (regra #20):
    * a falha nunca eh muda, mas tambem nunca sai em dobro.
    *
    * par_cDestino - opcional; sem ele valida this_cDestino.
    *==========================================================================
    FUNCTION ValidarDestino(par_cDestino)
        LOCAL loc_lValido, loc_cValor, loc_cSQL, loc_nResultado

        loc_lValido = .F.
        THIS.this_lDestinoDuplicado = .F.

        IF VARTYPE(par_cDestino) = "C"
            loc_cValor = ALLTRIM(par_cDestino)
        ELSE
            loc_cValor = ALLTRIM(NVL(THIS.this_cDestino, ""))
        ENDIF

        *-- "If Not Empty(This.Value)" do legado: campo vazio nao eh consultado
        *-- nem recusado pelo Valid (quem recusa vazio eh o CmdCopia.Click).
        IF EMPTY(loc_cValor)
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_lComissao
            loc_cSQL = "SELECT TOP 1 cods AS chave FROM " + THIS.this_cTabelaComCab + ;
                " WHERE cods = " + EscaparSQL(PADR(loc_cValor, THIS.this_nTamCods))
        ELSE
            loc_cSQL = "SELECT TOP 1 processos AS chave FROM " + THIS.this_cTabelaProcCab + ;
                " WHERE processos = " + EscaparSQL(PADR(loc_cValor, THIS.this_nTamProcessos))
        ENDIF

        THIS.FecharCursor(THIS.this_cCursorValida)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorValida)

        DO CASE
            CASE loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    CapturarErroSQL()

            CASE USED(THIS.this_cCursorValida) AND RECCOUNT(THIS.this_cCursorValida) > 0
                THIS.this_lDestinoDuplicado = .T.
                IF THIS.this_lComissao
                    THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + ;
                        "o do Cadastro de Comiss" + CHR(227) + "o J" + CHR(225) + " Informado!!!"
                ELSE
                    THIS.this_cMensagemErro = "Processo J" + CHR(225) + " Cadastrado!!!"
                ENDIF

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        THIS.FecharCursor(THIS.this_cCursorValida)

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * ValidarDados - Hook de BusinessBase.Salvar
    *
    * Junta as DUAS validacoes que no legado moram em lugares diferentes: o
    * "If Empty(ThisForm.GetDestino.Value) / Destino Invalido !!!" do
    * CmdCopia.Click e a checagem de duplicidade do GetDestino.Valid.
    *
    * A duplicidade eh reconsultada aqui de proposito, mesmo o campo ja tendo
    * passado pelo Valid: entre digitar e clicar em Copiar, outro usuario pode
    * ter gravado o mesmo codigo, e sem esta checagem a violacao de PRIMARY KEY
    * chegaria CRUA do ODBC na tela.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(ALLTRIM(NVL(THIS.this_cDestino, "")))
                *-- Texto literal do legado (sem acento no dump).
                THIS.this_cMensagemErro = "Destino Invalido !!!"

            CASE EMPTY(ALLTRIM(NVL(THIS.this_cOrigem, "")))
                THIS.this_cMensagemErro = "Origem Inv" + CHR(225) + "lida !!!"

            OTHERWISE
                loc_lValido = THIS.ValidarDestino(THIS.this_cDestino)
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ExecutarCopia - Entrada publica do CmdCopia.Click
    *
    * Caminho canonico NovoRegistro + Salvar, para que a validacao
    * (ValidarDados) e o relato de falha (ExibirFalha do BusinessBase) rodem
    * sempre - inclusive quando quem chama eh o botao diretamente. Chamar
    * Inserir() por fora funciona, mas deixa o relato de erro na mao do
    * chamador (regra #20).
    *
    * O destino eh guardado DEPOIS do NovoRegistro porque este chama
    * LimparDados, que zera this_cDestino (e preserva modalidade e origem).
    *==========================================================================
    FUNCTION ExecutarCopia(par_cDestino)
        LOCAL loc_lSucesso, loc_cDestino

        IF VARTYPE(par_cDestino) = "C"
            loc_cDestino = ALLTRIM(par_cDestino)
        ELSE
            loc_cDestino = ALLTRIM(NVL(THIS.this_cDestino, ""))
        ENDIF

        THIS.NovoRegistro()

        THIS.this_cDestino = LEFT(loc_cDestino, THIS.ObterTamanhoChave())

        loc_lSucesso = THIS.Salvar()

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - A COPIA (transcricao do CmdCopia.Click legado)
    *
    * Ordem do legado, preservada:
    *   1. recusa destino vazio
    *   2. le o cabecalho de ORIGEM
    *   3. emite as chaves novas    <- fGerUniqueKey / fUniqueIds
    *   4. enfileira cabecalho + itens
    *   5. descarrega tudo (poDataMgr.UpDate x2 + Commit) -> aqui, UM lote
    *   6. fGravarLog (so no ramo de processo, como no legado)
    *
    * O passo 3 vem ANTES do lote por um motivo que nao eh estetico:
    * fGerUniqueKey grava em dbo.SIGSYSEQ e fecha a transacao da conexao com
    * SQLCOMMIT/SQLROLLBACK proprios. Chamada DENTRO do lote, ela comitaria a
    * copia pela metade. O legado tambem a chama antes de tudo.
    *
    * O "Zap In crSigPcOop / Zap In crSigPcOoI" do legado nao tem equivalente:
    * ele limpa os cursores remotos bufferizados que o form PAI mantem abertos
    * e que recebem o registro antes do Update(). Aqui nao ha cursor
    * intermediario - o INSERT ... SELECT grava direto.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cDestino, loc_nNovoCodigo, loc_cChave, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cDestino = ALLTRIM(NVL(THIS.this_cDestino, ""))

            DO CASE
                CASE EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Destino Invalido !!!"

                CASE !THIS.CarregarOrigem()
                    *-- Mensagem ja definida por CarregarOrigem.

                OTHERWISE
                    THIS.this_tDatas = DATETIME()

                    IF THIS.this_lComissao
                        *-- lcKey = fUniqueIds() do legado: PK do cabecalho novo
                        *-- e fkchaves de todos os itens copiados.
                        loc_cChave = PADR(fUniqueIds(), THIS.this_nTamChaves)

                        IF EMPTY(ALLTRIM(loc_cChave))
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                                "vel gerar a chave do Cadastro de Comiss" + CHR(227) + "o."
                        ELSE
                            THIS.this_cPkchaves = loc_cChave
                            THIS.this_cFkchaves = loc_cChave
                            THIS.this_cCods     = PADR(loc_cDestino, THIS.this_nTamCods)
                            loc_lSucesso        = .T.
                        ENDIF
                    ELSE
                        *-- lnNDopes = fGerUniqueKey('SigPcOoP'): contador
                        *-- persistido em dbo.SIGSYSEQ. Zero eh o sentinela de
                        *-- falha que o proprio legado testa.
                        loc_nNovoCodigo = fGerUniqueKey(THIS.this_cChaveSequencia)

                        IF loc_nNovoCodigo = 0
                            THIS.this_cMensagemErro = "C" + CHR(243) + "digo Autom" + CHR(225) + ;
                                "tico de Processo Inv" + CHR(225) + "lido !!!"
                        ELSE
                            THIS.this_nCodigos   = loc_nNovoCodigo
                            THIS.this_cProcessos = PADR(loc_cDestino, THIS.this_nTamProcessos)
                            loc_lSucesso         = .T.
                        ENDIF
                    ENDIF

                    IF loc_lSucesso
                        loc_lSucesso = THIS.MontarLoteCopia()

                        IF loc_lSucesso
                            loc_lSucesso = THIS.ExecutarLoteCopia()
                        ENDIF

                        IF loc_lSucesso
                            THIS.this_lCopiaRealizada = .T.

                            *-- fGravarLog([C], Thisform.Name, [COPIA],
                            *-- crSigPcOop.Processos) - o legado so audita no
                            *-- ramo de processo, e o 4o argumento eh o codigo
                            *-- de destino recem-gravado.
                            IF !THIS.this_lComissao
                                fGravarLog(THIS.this_cTipoLog, THIS.this_cProgramaLog, ;
                                    THIS.this_cOperacaoLog, ALLTRIM(THIS.this_cProcessos))
                            ENDIF

                            *-- Auditoria propria do sistema novo (LogAuditoria),
                            *-- independente do fGravarLog do legado. A tabela
                            *-- registrada eh a da modalidade corrente, porque
                            *-- ConfigurarModalidade mantem this_cTabela em dia.
                            THIS.RegistrarAuditoria("INSERT")
                        ENDIF
                    ENDIF
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cLoteCopia    = ""
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Este dialogo nao ALTERA registro: ele COPIA
    *
    * O legado tem um botao so ("Copiar"), e ele sempre cria um cabecalho NOVO
    * com chave nova. O caminho canonico (ExecutarCopia -> NovoRegistro ->
    * Salvar) por isso cai sempre em Inserir(). Atualizar() delega para o mesmo
    * lugar para nao ficar quebrado se algum chamador invocar Salvar() sem
    * passar por NovoRegistro() - mesmo tratamento do BO irmao SigOpCopBO, que
    * migra o outro dialogo de copia do sistema.
    *==========================================================================
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

    *==========================================================================
    * MontarLoteCopia - Enfileira em this_cLoteCopia o cabecalho + os itens
    *
    * Equivale aos dois blocos "Scatter Memvar Memo / Insert Into <cursor> From
    * Memvar / Replace <colunas>" do legado, que copiam o registro INTEIRO e
    * depois sobrescrevem um punhado de colunas. Aqui isso vira
    * INSERT ... SELECT server-side (ver MontarInsertCopia).
    *
    * O que o legado sobrescreve, e que esta reproduzido abaixo:
    *
    *   COMISSAO  SigCmCab: cods      <- destino
    *                       pkchaves  <- lcKey (fUniqueIds, uma vez)
    *                       datas     <- Datetime()
    *             SigCmItn: fkchaves  <- lcKey
    *                       pkchaves  <- fUniqueIds() POR LINHA
    *
    *   PROCESSO  SigPcOop: processos <- destino
    *                       codigos   <- fGerUniqueKey('SigPcOoP')
    *             SigPcOoI: processos <- destino
    *                       codigos   <- o mesmo numero do cabecalho
    *                       cidchaves <- fUniqueIds() POR LINHA
    *
    * O "POR LINHA" eh regra, nao detalhe: pkchaves (SigCmItn) e cidchaves
    * (SigPcOoI) sao PRIMARY KEY das respectivas tabelas, entao um unico valor
    * reaproveitado colidiria no indice unico a partir do segundo item.
    *
    * NOTA sobre SigCmCab.usuars: o legado escreve "Replace USUARS With Usuars"
    * e isso NAO troca o usuario. Em REPLACE o nome desqualificado resolve
    * primeiro como CAMPO, e mesmo que resolvesse como a memvar criada pelo
    * Scatter o valor seria o MESMO - os dois lados sao o usuars da ORIGEM.
    * Ou seja, a coluna fica com o valor copiado, e eh exatamente o que o
    * INSERT ... SELECT faz sem sobrepor nada. Reescrever isso para o usuario
    * logado mudaria o dado gravado em relacao ao legado (regra #17).
    *
    * O FILTRO dos itens tambem eh o do legado, e os dois ramos diferem:
    *   comissao: SigCmItn Where fkChaves  = <pkchaves da origem>
    *   processo: SigPcOoI Where Processos = <processos da origem>
    * (no ramo de processo o legado filtra por "processos", nao por "codigos".)
    *==========================================================================
    PROTECTED FUNCTION MontarLoteCopia()
        LOCAL loc_lOk, loc_cCRLF, loc_cTabCab, loc_cTabItn, loc_cColsCab, ;
            loc_cColsItn, loc_cWhereCab, loc_cWhereItn, loc_cOvrCab, loc_cOvrItn, ;
            loc_cCampoPkItn, loc_cSQL, loc_nResultado, loc_cPkItem, loc_cChaveItem

        loc_lOk   = .T.
        loc_cCRLF = CHR(13) + CHR(10)

        THIS.this_cLoteCopia     = ""
        THIS.this_cChavesGeradas = ""
        THIS.this_nItensCopiados = 0

        loc_cTabCab = THIS.ObterTabelaCabecalho()
        loc_cTabItn = THIS.ObterTabelaItens()

        IF THIS.this_lComissao
            *-- O cabecalho eh filtrado pela PK da origem (pkchaves), nao por
            *-- "cods": "cods" nao eh unica e duas linhas gerariam duas
            *-- tentativas de gravar a MESMA pkchaves nova.
            loc_cWhereCab = "pkchaves = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPkchavesOrigem), THIS.this_nTamChaves))

            loc_cOvrCab = "cods="      + EscaparSQL(THIS.this_cCods) + ;
                          "|pkchaves=" + EscaparSQL(THIS.this_cPkchaves) + ;
                          "|datas="    + FormatarDataSQL(THIS.this_tDatas)

            loc_cWhereItn   = "fkchaves = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPkchavesOrigem), THIS.this_nTamChaves))
            loc_cCampoPkItn = "pkchaves"
        ELSE
            loc_cWhereCab = "codigos = " + FormatarNumeroSQL(THIS.this_nCodigosOrigem, 0)

            loc_cOvrCab = "processos=" + EscaparSQL(THIS.this_cProcessos) + ;
                          "|codigos="  + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_cWhereItn   = "processos = " + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cOrigem), THIS.this_nTamProcessos))
            loc_cCampoPkItn = "cidchaves"
        ENDIF

        *-- 1) Lista de colunas das duas tabelas (uma consulta por tabela, FORA
        *--    do laco dos itens - SQLEXEC troca a area de trabalho corrente e
        *--    dentro de um SCAN isso quebraria a varredura).
        loc_cColsCab = THIS.ObterListaColunas(loc_cTabCab)
        loc_lOk      = !EMPTY(loc_cColsCab)

        IF loc_lOk
            loc_cColsItn = THIS.ObterListaColunas(loc_cTabItn)
            loc_lOk      = !EMPTY(loc_cColsItn)
        ENDIF

        *-- 2) Cabecalho (1 linha)
        IF loc_lOk
            THIS.this_cEtapaAtual = loc_cTabCab

            loc_cSQL = THIS.MontarInsertCopia(loc_cTabCab, loc_cColsCab, loc_cOvrCab, loc_cWhereCab)
            loc_lOk  = !EMPTY(loc_cSQL)

            IF loc_lOk
                THIS.this_cLoteCopia = loc_cSQL + ";" + loc_cCRLF
            ENDIF
        ENDIF

        *-- 3) Itens (N linhas, cada uma com a propria chave unica)
        IF loc_lOk
            THIS.this_cEtapaAtual = loc_cTabItn

            THIS.FecharCursor(THIS.this_cCursorItens)

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT " + loc_cCampoPkItn + " AS chave FROM " + loc_cTabItn + ;
                " WHERE " + loc_cWhereItn + ;
                " ORDER BY " + loc_cCampoPkItn, THIS.this_cCursorItens)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao ler os itens de " + loc_cTabItn + ":" + ;
                    CHR(13) + CapturarErroSQL()
                loc_lOk = .F.
            ELSE
                SELECT (THIS.this_cCursorItens)
                SCAN WHILE loc_lOk
                    loc_cPkItem    = ALLTRIM(TratarNulo(chave, ""))
                    loc_cChaveItem = THIS.GerarChaveItem()

                    IF EMPTY(loc_cPkItem) OR EMPTY(ALLTRIM(loc_cChaveItem))
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel gerar a chave de um item de " + loc_cTabItn + "."
                        loc_lOk = .F.
                    ELSE
                        IF THIS.this_lComissao
                            loc_cOvrItn = "fkchaves="  + EscaparSQL(THIS.this_cFkchaves) + ;
                                          "|pkchaves=" + EscaparSQL(loc_cChaveItem)
                        ELSE
                            loc_cOvrItn = "processos="  + EscaparSQL(THIS.this_cProcessos) + ;
                                          "|codigos="   + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                          "|cidchaves=" + EscaparSQL(loc_cChaveItem)
                        ENDIF

                        loc_cSQL = THIS.MontarInsertCopia(loc_cTabItn, loc_cColsItn, loc_cOvrItn, ;
                            loc_cCampoPkItn + " = " + ;
                            EscaparSQL(PADR(loc_cPkItem, THIS.this_nTamChaves)))

                        IF EMPTY(loc_cSQL)
                            loc_lOk = .F.
                        ELSE
                            THIS.this_cLoteCopia = THIS.this_cLoteCopia + loc_cSQL + ";" + loc_cCRLF
                            THIS.this_nItensCopiados = THIS.this_nItensCopiados + 1

                            *-- cidchaves do ultimo item novo, guardado para
                            *-- conferencia da copia.
                            IF !THIS.this_lComissao
                                THIS.this_cCidchaves = loc_cChaveItem
                            ENDIF
                        ENDIF
                    ENDIF
                ENDSCAN

                THIS.FecharCursor(THIS.this_cCursorItens)
            ENDIF
        ENDIF

        IF !loc_lOk
            THIS.this_cLoteCopia = ""
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * GerarChaveItem - fUniqueIds() com garantia de nao repetir DENTRO do lote
    *
    * fUniqueIds monta a chave com RIGHT(SYS(2015), 9) + digitos aleatorios.
    * Duas chamadas no mesmo laco podem, em teoria, devolver o mesmo valor - e
    * como a chave eh PRIMARY KEY do item, uma repeticao faria o lote INTEIRO
    * ser desfeito pelo ROLLBACK, com o usuario vendo so uma violacao de chave.
    * Mais barato conferir aqui: as chaves ja emitidas ficam em
    * this_cChavesGeradas e a geracao eh repetida ate 10 vezes.
    *==========================================================================
    PROTECTED FUNCTION GerarChaveItem()
        LOCAL loc_cChave, loc_nTentativa, loc_lRepetida

        loc_cChave    = ""
        loc_lRepetida = .T.

        FOR loc_nTentativa = 1 TO 10
            loc_cChave = PADR(fUniqueIds(), THIS.this_nTamChaves)

            loc_lRepetida = (AT("|" + ALLTRIM(loc_cChave) + "|", THIS.this_cChavesGeradas) > 0)

            IF !loc_lRepetida
                EXIT
            ENDIF
        ENDFOR

        IF loc_lRepetida
            loc_cChave = ""
        ELSE
            THIS.this_cChavesGeradas = THIS.this_cChavesGeradas + ;
                "|" + ALLTRIM(loc_cChave) + "|"
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterListaColunas - Nomes das colunas da tabela, na ordem do schema
    *
    * A lista vem do INFORMATION_SCHEMA em tempo de execucao, e nao fixa no
    * fonte, pelo mesmo motivo do BO irmao SigOpCopBO: a copia tem de levar
    * TODAS as colunas (eh o que o "Scatter Memvar Memo" do legado faz), e uma
    * lista congelada aqui faria o INSERT quebrar em silencio - ou pior, deixar
    * coluna NOT NULL de fora - no dia em que o schema mudasse (regra #22).
    *
    * Como as duas pontas do INSERT ... SELECT sao a MESMA tabela, a lista
    * serve para os dois lados e nao ha intersecao a calcular nem truncamento
    * de largura a tratar.
    *==========================================================================
    PROTECTED FUNCTION ObterListaColunas(par_cTabela)
        LOCAL loc_cLista, loc_cTabela, loc_nResultado

        loc_cLista  = ""
        loc_cTabela = ALLTRIM(NVL(par_cTabela, ""))

        IF EMPTY(loc_cTabela)
            RETURN ""
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN ""
        ENDIF

        THIS.FecharCursor(THIS.this_cCursorColunas)

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME AS col FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = " + EscaparSQL(loc_cTabela) + ;
            " ORDER BY ORDINAL_POSITION", THIS.this_cCursorColunas)

        IF loc_nResultado < 0 OR !USED(THIS.this_cCursorColunas) OR ;
                RECCOUNT(THIS.this_cCursorColunas) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler as colunas de " + loc_cTabela + ":" + CHR(13) + CapturarErroSQL()
        ELSE
            SELECT (THIS.this_cCursorColunas)
            SCAN
                loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(col)
            ENDSCAN
        ENDIF

        THIS.FecharCursor(THIS.this_cCursorColunas)

        RETURN loc_cLista
    ENDFUNC

    *==========================================================================
    * MontarInsertCopia - "INSERT INTO T (cols) SELECT exprs FROM T WHERE ..."
    *
    * Reproduz o par "Scatter Memvar Memo / Insert From Memvar" + "Replace" do
    * legado sem trazer o registro para a memoria do VFP: toda coluna entra no
    * SELECT com o proprio nome (copia) e as sobrepostas entram como EXPRESSAO.
    *
    * par_cColunas   - lista separada por virgula (de ObterListaColunas)
    * par_cOverrides - "col=<expr SQL>|col=<expr SQL>|..." (expr ja no formato
    *                  final do SQL Server, isto eh, ja com aspas quando for
    *                  texto - EscaparSQL/FormatarDataSQL/FormatarNumeroSQL
    *                  devolvem assim)
    * par_cWhere     - filtro da linha de origem
    *
    * Devolve "" quando algum override NAO casa com coluna real da tabela: erro
    * de grafia no nome da coluna nasceria silencioso (a coluna continuaria
    * sendo copiada da origem) e eh justamente o defeito que a regra #22
    * descreve. O chamador aborta o lote inteiro.
    *==========================================================================
    PROTECTED FUNCTION MontarInsertCopia(par_cTabela, par_cColunas, par_cOverrides, par_cWhere)
        LOCAL loc_cTabela, loc_cCols, loc_cExprs, loc_cCol, loc_cOvr, loc_cValor, ;
            loc_nPos, loc_nI, loc_nCols, loc_nUsados, loc_nPedidos
        LOCAL ARRAY loc_aCols[1]

        loc_cTabela = ALLTRIM(NVL(par_cTabela, ""))

        IF EMPTY(loc_cTabela) OR EMPTY(ALLTRIM(NVL(par_cColunas, "")))
            RETURN ""
        ENDIF

        loc_nCols = ALINES(loc_aCols, ALLTRIM(par_cColunas), 3, ",")

        IF loc_nCols = 0
            RETURN ""
        ENDIF

        loc_cCols   = ""
        loc_cExprs  = ""
        loc_nUsados = 0
        loc_cOvr    = "|" + ALLTRIM(NVL(par_cOverrides, "")) + "|"

        FOR loc_nI = 1 TO loc_nCols
            loc_cCol = ALLTRIM(loc_aCols[loc_nI])

            IF EMPTY(loc_cCol)
                LOOP
            ENDIF

            loc_nPos = AT("|" + LOWER(loc_cCol) + "=", LOWER(loc_cOvr))

            IF loc_nPos > 0
                loc_cValor  = SUBSTR(loc_cOvr, loc_nPos + LEN(loc_cCol) + 2)
                loc_cValor  = LEFT(loc_cValor, AT("|", loc_cValor) - 1)
                loc_nUsados = loc_nUsados + 1
            ELSE
                loc_cValor = loc_cCol
            ENDIF

            loc_cCols  = loc_cCols  + IIF(EMPTY(loc_cCols),  "", ", ") + loc_cCol
            loc_cExprs = loc_cExprs + IIF(EMPTY(loc_cExprs), "", ", ") + loc_cValor
        ENDFOR

        *-- Cada override pedido tem de ter casado com uma coluna REAL.
        loc_nPedidos = 0
        IF !EMPTY(ALLTRIM(NVL(par_cOverrides, "")))
            loc_nPedidos = OCCURS("|", ALLTRIM(par_cOverrides)) + 1
        ENDIF

        IF loc_nUsados < loc_nPedidos
            THIS.this_cMensagemErro = "C" + CHR(243) + "pia de " + loc_cTabela + ": " + ;
                TRANSFORM(loc_nPedidos - loc_nUsados) + " de " + TRANSFORM(loc_nPedidos) + ;
                " campos a sobrepor n" + CHR(227) + "o existem na tabela." + CHR(13) + ;
                ALLTRIM(NVL(par_cOverrides, ""))
            RETURN ""
        ENDIF

        RETURN "INSERT INTO " + loc_cTabela + " (" + loc_cCols + ")" + ;
            " SELECT " + loc_cExprs + " FROM " + loc_cTabela + ;
            " WHERE " + par_cWhere
    ENDFUNC

    *==========================================================================
    * ExecutarLoteCopia - Grava cabecalho + itens numa transacao ATOMICA
    *
    * O legado trata a copia como uma coisa so: enfileira tudo nos cursores
    * remotos e descarrega com dois poDataMgr.UpDate seguidos de UM Commit().
    * Aqui o equivalente fiel eh mandar o lote num SQLEXEC UNICO com o controle
    * de transacao em T-SQL.
    *
    * Por que nao BEGIN/COMMIT em SQLEXEC separados: a conexao nasce com
    * Transactions = 2 e @@TRANCOUNT ja vale 1, entao um BEGIN proprio so
    * ANINHA (vai para 2) e o COMMIT volta para 1 sem efetivar nada - e um
    * ROLLBACK nomeado nessa situacao nem roda. Dai o SAVE TRANSACTION quando
    * ja ha transacao aberta (o caso normal) e o THROW no CATCH, que faz o erro
    * chegar ao retorno do SQLEXEC e deixa CapturarErroSQL() com o texto real.
    *==========================================================================
    PROTECTED FUNCTION ExecutarLoteCopia()
        LOCAL loc_lOk, loc_cSQL, loc_cCRLF, loc_cSavepoint, loc_nResultado

        loc_lOk   = .F.
        loc_cCRLF = CHR(13) + CHR(10)

        IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteCopia, "")))
            THIS.this_cMensagemErro = "Nada para copiar."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

        loc_cSQL = "SET NOCOUNT ON;" + loc_cCRLF + ;
            "DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
            "IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
            "ELSE SAVE TRANSACTION " + loc_cSavepoint + ";" + loc_cCRLF + ;
            "BEGIN TRY" + loc_cCRLF + ;
            THIS.this_cLoteCopia + ;
            "IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
            "END TRY" + loc_cCRLF + ;
            "BEGIN CATCH" + loc_cCRLF + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION " + loc_cSavepoint + "; END;" + loc_cCRLF + ;
            "THROW;" + loc_cCRLF + ;
            "END CATCH"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao gravar a c" + CHR(243) + "pia (" + ;
                ALLTRIM(NVL(THIS.this_cEtapaAtual, "")) + "):" + CHR(13) + CapturarErroSQL()
            loc_lOk = .F.
        ELSE
            loc_lOk = .T.
        ENDIF

        THIS.this_cLoteCopia = ""

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE
