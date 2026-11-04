*==============================================================================
* SigOpCrdBO.prg
*
* Business Object para FormSigOpCrd - Geracao de Certificado de Credito
* Legado: SigOpCrd.SCX (task713)
*
* Tabela principal : SigOpCrr (chave: cidchaves char(20))
* Operacao dona    : SigCdOpe.dopes char(20) - recebida do form pai
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO aberto pelo cadastro de Tipos de Operacao (SigCdOpe /
* FormOPE). Edita, numa grade de 4 colunas, as N faixas de valores que
* definem o Certificado de Credito da operacao corrente:
*
*    Column1  FaixaIs    faixais   numeric(11,2)  "Faixa Inicial"
*    Column2  FaixaFs    faixafs   numeric(11,2)  "Faixa Final"
*    Column3  Percs      percs     numeric(5,2)   "%"
*    Column4  Multiplos  multiplos numeric(11,2)  "Multiplos"
*
* As outras duas colunas da tabela NAO aparecem na tela e sao preenchidas
* por codigo, exatamente como o legado faz:
*
*    dopes      - herdado de crSigCdOpe.Dopes (a operacao sendo editada)
*    cidchaves  - fUniqueIds() (PK do padrao Fortyus)
*
*------------------------------------------------------------------------------
* MODELO DE GRAVACAO (transcrito do legado)
*
* A tela NAO grava linha a linha: ela acumula as alteracoes no cursor da
* grade (crSigOpCrr no legado, cursor_4c_Dados aqui) e persiste TUDO de uma
* vez ao encerrar, no cmdSair.Click:
*
*    Select CrSigOpCrr
*    Go Top
*    Delete For Empty(Dopes) or Empty(faixafs)
*    Replace CidChaves with fUniqueIds() For Empty(CidChaves)
*    ... poDataMgr.UpDate('crSigOpCrr') / Commit() / RollBack()
*
* Os dois marcadores lHouveIns / lHouveExcl do legado decidem se a gravacao
* chega a ser tentada - sem insercao nem exclusao, o Encerrar apenas devolve
* o foco ao form pai. Ficam espelhados em this_lHouveInsercao e
* this_lHouveExclusao.
*
* IMPORTANTE (regra #22): as SEIS colunas de SigOpCrr sao NOT NULL e nenhuma
* tem DEFAULT - conferido em docs/schema.sql (UTF-16, lido com
* Get-Content -Raw). Por isso a gravacao cobre todas as seis, inclusive as
* duas que nao aparecem na tela.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA
*
* O legado nao tem botao de Alterar nem de Buscar: a grade ja abre editavel
* e o unico botao de acao, alem do Encerrar, eh o Excluir (que apaga a linha
* corrente do cursor). A remocao definitiva no servidor acontece junto com a
* gravacao do Encerrar, por reconciliacao do conjunto de linhas da operacao,
* e nao por um DELETE disparado a cada clique: ExcluirLinhaCursor apenas marca
* a linha, e GravarFaixas traduz essa marca em DELETE no servidor, dentro do
* mesmo lote transacional dos INSERT e UPDATE. ExecutarExclusao existe e usa o
* MESMO montador de SQL, para o caso de apagar uma faixa isolada pelo
* Excluir() da BusinessBase - assim a lista de colunas e o criterio da chave
* nao podem divergir entre os dois caminhos.
*==============================================================================

DEFINE CLASS SigOpCrdBO AS BusinessBase

    *--------------------------------------------------------------------------
    * PROPRIEDADES DA ENTIDADE - SigOpCrr
    *
    * Uma property por coluna da tabela, com a grafia da coluna preservada
    * (inclusive o sufixo "s" do padrao Fortyus - NUNCA "corrigir" para o
    * singular). Tipos conferidos em docs/schema.sql:
    *
    *    [cidchaves] char(20)       NOT NULL   (PK)
    *    [dopes]     char(20)       NOT NULL
    *    [faixafs]   numeric(11,2)  NOT NULL
    *    [faixais]   numeric(11,2)  NOT NULL
    *    [percs]     numeric(5,2)   NOT NULL
    *    [multiplos] numeric(11,2)  NOT NULL
    *--------------------------------------------------------------------------
    this_cCidchaves = ""    && cidchaves char(20)      - PK (fUniqueIds)
    this_cDopes     = ""    && dopes     char(20)      - operacao dona
    this_nFaixais   = 0     && faixais   numeric(11,2) - Column1 "Faixa Inicial"
    this_nFaixafs   = 0     && faixafs   numeric(11,2) - Column2 "Faixa Final"
    this_nPercs     = 0     && percs     numeric(5,2)  - Column3 "%"
    this_nMultiplos = 0     && multiplos numeric(11,2) - Column4 "Multiplos"

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI
    *
    * Legado: lcOperacao = crSigCdOpe.Dopes, lido no Init a partir do cursor
    * da operacao que o cadastro de Tipos de Operacao mantem aberto. Aqui o
    * valor chega por parametro e fica guardado nesta property, que eh a
    * FONTE UNICA da coluna dopes de toda linha nova.
    *
    * this_cEscolha espelha o PcEscolha do legado:
    *    Thisform.PcEscolha = IIF(EMPTY(poForm.PcEscolha),"INSERIR",poForm.PcEscolha)
    * e eh o que decide se a grade abre editavel (INSERIR/ALTERAR) ou apenas
    * para consulta, alem de habilitar ou nao o botao Excluir.
    *--------------------------------------------------------------------------
    this_cOperacao     = ""         && Dopes da operacao corrente (contexto)
    this_cDescOperacao = ""         && Dopes em Proper() para o titulo da tela
    this_cEscolha      = "INSERIR"  && PcEscolha: INSERIR / ALTERAR / PROCURAR

    *--------------------------------------------------------------------------
    * MARCADORES DE ALTERACAO A GRAVAR (legado: lHouveIns / lHouveExcl)
    *
    * O Encerrar so tenta gravar quando pelo menos um deles esta ligado -
    * transcricao literal do guard do cmdSair.Click:
    *    If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *--------------------------------------------------------------------------
    this_lHouveInsercao = .F.       && houve insercao de linha na grade
    this_lHouveExclusao = .F.       && houve exclusao de linha na grade

    *--------------------------------------------------------------------------
    * PERMISSAO DE EXCLUSAO
    *
    * Legado: .cmdExcluir.Visible = fChecaAcesso('SigOpCrr','EXCLUIR') And ;
    *                               InList(PcEscolha,'INSERIR','ALTERAR')
    * Resolvida uma vez e guardada aqui, para o form apenas espelhar no
    * Visible/Enabled do botao.
    *--------------------------------------------------------------------------
    this_lPodeExcluir = .F.

    *--------------------------------------------------------------------------
    * CURSORES DE TRABALHO
    *
    * this_cCursorDados eh o alias ligado ao RecordSource da grade - o mesmo
    * papel do crSigOpCrr legado. NUNCA receber SQLEXEC direto: SQLEXEC sobre
    * o alias de um Grid fecha e recria o alias, zerando ColumnCount e
    * deixando a grade um retangulo branco. A carga passa por
    * this_cCursorTemp e eh transferida com ZAP + APPEND FROM DBF().
    *
    * A grade tem coluna EDITAVEL, portanto o cursor de dados precisa ser
    * READWRITE - cursor de SQL pass-through nasce somente-leitura e o
    * REPLACE da edicao estouraria.
    *--------------------------------------------------------------------------
    this_cCursorDados = "cursor_4c_Dados"       && alias do Grid (READWRITE)
    this_cCursorTemp  = "cursor_4c_DadosTmp"    && destino do SQLEXEC
    this_cCursorAux   = "cursor_4c_Aux"         && conferencias pontuais

    *--------------------------------------------------------------------------
    * ACOMPANHAMENTO DA GRAVACAO
    *
    * O legado reporta apenas "Erro na Gravacao dos Dados do Cadastro de
    * Operacoes."; estes contadores existem para a mensagem poder dizer
    * quantas linhas entraram, foram alteradas e foram removidas.
    *--------------------------------------------------------------------------
    this_nRegistrosInseridos   = 0
    this_nRegistrosAtualizados = 0
    this_nRegistrosExcluidos   = 0

    *--------------------------------------------------------------------------
    * LOTE DE COMANDOS SQL
    *
    * A gravacao do Encerrar abrange varias linhas e tem de ser ATOMICA, como
    * o par Update/Commit-RollBack do poDataMgr legado. Os comandos sao
    * acumulados aqui e executados num unico bloco transacional.
    *--------------------------------------------------------------------------
    this_cLoteGravacao = ""

    *--------------------------------------------------------------------------
    * COLUNAS DO CURSOR DA GRADE - fonte UNICA
    *
    * A lista existe para dois usos: conferir se um alias cursor_4c_Dados
    * pre-existente tem a estrutura DESTA tela antes de reaproveita-lo, e
    * montar o SELECT da carga com os MESMOS nomes do CREATE CURSOR - o
    * APPEND FROM DBF() casa as colunas por NOME, entao qualquer divergencia
    * de grafia faz a coluna chegar EM BRANCO, sem erro e sem log.
    *
    * lnovos NAO eh coluna de SigOpCrr: eh o marcador de linha ainda nao
    * gravada no servidor. O legado obtinha essa distincao de graca, porque o
    * crSigOpCrr era cursor REMOTO e o poDataMgr.UpDate sabia separar INSERT
    * de UPDATE de DELETE. Aqui a grade vive num CREATE CURSOR comum, logo a
    * distincao tem de ser carregada explicitamente - sem ela a gravacao do
    * Encerrar nao tem como saber o que inserir e o que atualizar.
    *--------------------------------------------------------------------------
    this_cColunasTabela = "cidchaves,dopes,faixais,faixafs,percs,multiplos"
    this_cColunaNovos   = "lnovos"

    *--------------------------------------------------------------------------
    * CONTROLE DA TRANSACAO DO LOTE
    *
    * O lote vai num SQLEXEC UNICO, com o controle de transacao escrito em
    * T-SQL. BEGIN/COMMIT enviados em SQLEXEC separados NAO protegem nada
    * neste ambiente: a conexao nasce com Transactions = 2 e @@TRANCOUNT ja
    * vale 1, portanto um BEGIN proprio apenas ANINHA (vai para 2) e o COMMIT
    * correspondente volta para 1 sem efetivar. Dai o SAVE TRANSACTION com
    * nome proprio quando ja ha transacao aberta (o caso normal) e o THROW no
    * CATCH, que faz o erro chegar ao retorno do SQLEXEC e deixa
    * CapturarErroSQL() com o texto real do SQL Server.
    *--------------------------------------------------------------------------
    this_cNomeSavepoint = "SigOpCrd4c"

    *--------------------------------------------------------------------------
    * this_lCursorRecriado - avisa ao form que o alias do Grid foi FECHADO e
    * criado de novo, e que portanto RecordSource e os ControlSource das
    * Columns precisam ser religados. Fechar e recriar o alias derruba o
    * binding do Grid EM SILENCIO: a grade fica permanentemente vazia com o
    * cursor cheio. O caminho normal de recarga (ZAP + APPEND FROM DBF)
    * PRESERVA o binding e deixa esta flag em .F.
    *--------------------------------------------------------------------------
    this_lCursorRecriado = .F.

    *--------------------------------------------------------------------------
    * Init - define a tabela principal, a chave primaria e o contexto
    *
    * par_cOperacao - Dopes da operacao dona das faixas (crSigCdOpe.Dopes no
    *                 legado). Opcional: o form pode informar depois, pela
    *                 property this_cOperacao, antes da primeira carga.
    * par_cEscolha  - PcEscolha herdado do form pai. Vazio equivale a
    *                 "INSERIR", exatamente como o IIF(EMPTY(...)) do legado.
    *
    * NAO carrega dado nenhum aqui: Init de BO que devolve .F. destroi o
    * objeto, CREATEOBJECT retorna .F. e o form nunca abre - inclusive em
    * validacao de UI, onde gnConnHandle = -1 e qualquer SQLEXEC estoura.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cOperacao, par_cEscolha)
        LOCAL loc_lSucesso, loc_cOperacao, loc_cEscolha
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpCrr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Operacao dona das faixas (contexto vindo do form pai)
            loc_cOperacao = ""
            IF VARTYPE(par_cOperacao) = "C"
                loc_cOperacao = ALLTRIM(par_cOperacao)
            ENDIF
            THIS.this_cOperacao     = loc_cOperacao
            THIS.this_cDopes        = loc_cOperacao
            THIS.this_cDescOperacao = PROPER(loc_cOperacao)

            *-- PcEscolha: vazio equivale a INSERIR (IIF(EMPTY(...)) do legado)
            loc_cEscolha = ""
            IF VARTYPE(par_cEscolha) = "C"
                loc_cEscolha = UPPER(ALLTRIM(par_cEscolha))
            ENDIF
            IF EMPTY(loc_cEscolha)
                loc_cEscolha = "INSERIR"
            ENDIF
            THIS.this_cEscolha = loc_cEscolha

            *-- Permissao de exclusao: fChecaAcesso + modo editavel (legado)
            THIS.this_lPodeExcluir = fChecaAcesso("SigOpCrr", "EXCLUIR") ;
                                     AND INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

            *-- Nenhuma alteracao a gravar ao abrir
            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            THIS.this_nRegistrosInseridos   = 0
            THIS.this_nRegistrosAtualizados = 0
            THIS.this_nRegistrosExcluidos   = 0
            THIS.this_cLoteGravacao         = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpCrdBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - defaults da LINHA NOVA
    *
    * Transcricao do Insert Into do inserelinha legado:
    *    Insert Into crSigOpCrr (Dopes, CidChaves) ;
    *        Values (crSigCdOpe.Dopes, fUniqueIds())
    *
    * Ou seja: a operacao vem do contexto e a PK eh gerada por fUniqueIds() -
    * NUNCA string vazia, senao a segunda linha colide no indice unico. As
    * quatro colunas numericas nascem zeradas (o legado as deixa com o valor
    * do registro em branco do cursor, que eh zero); as quatro sao NOT NULL,
    * portanto o zero eh valor gravavel e nao ausencia de valor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cCidchaves = fUniqueIds()
        THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
        THIS.this_nFaixais   = 0
        THIS.this_nFaixafs   = 0
        THIS.this_nPercs     = 0
        THIS.this_nMultiplos = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - valor da PK para a auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC


    *==========================================================================
    * CriarCursorDados - prepara o cursor READWRITE ligado ao Grid
    *
    * O cursor TEM de ser READWRITE: a grade desta tela eh editavel e cursor
    * de SQL pass-through nasce SOMENTE-LEITURA - o REPLACE da edicao
    * estouraria. Por isso o alias da grade nunca recebe SQLEXEC: a carga
    * passa pelo cursor temporario (ver CarregarFaixas).
    *
    * Ponto UNICO de CREATE CURSOR desta tela. A ordem e a grafia das colunas
    * tem de ser identicas em todo lugar que mencione o cursor, porque o
    * APPEND FROM DBF() casa por NOME.
    *
    * Larguras conferidas em docs/schema.sql: numeric(11,2) sao 9 digitos
    * inteiros + 2 decimais, que em VFP (onde a largura inclui o ponto) eh
    * N(12,2); numeric(5,2) sao 3 + 2, isto eh N(6,2). Batem com os
    * InputMask do SCX legado ("999,999,999.99" e "999.99").
    *
    * par_lForcarRecriar - .T. derruba e recria o alias mesmo que ele exista.
    *                      Quem chamar assim fica responsavel por religar o
    *                      Grid; this_lCursorRecriado avisa que eh o caso.
    *==========================================================================
    PROCEDURE CriarCursorDados(par_lForcarRecriar)
        LOCAL loc_lSucesso, loc_lRecriar, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

        THIS.this_lCursorRecriado = .F.

        TRY
            loc_lRecriar = .T.

            IF USED(loc_cAlias)
                loc_lRecriar = .F.

                IF VARTYPE(par_lForcarRecriar) = "L" AND par_lForcarRecriar
                    loc_lRecriar = .T.
                ENDIF

                *-- Alias herdado de outra tela com estrutura diferente eh pior
                *-- que alias ausente: o ZAP apaga as linhas mas PRESERVA as
                *-- colunas e a nulabilidade do dono anterior, e o APPEND
                *-- seguinte falha por coluna que esta tela nem conhece.
                IF !loc_lRecriar
                    IF !THIS.CursorTemEstruturaEsperada(loc_cAlias)
                        loc_lRecriar = .T.
                    ENDIF
                ENDIF

                IF loc_lRecriar
                    USE IN (loc_cAlias)
                ENDIF
            ENDIF

            IF loc_lRecriar
                CREATE CURSOR (loc_cAlias) ( ;
                    cidchaves C(20), ;
                    dopes     C(20), ;
                    faixais   N(12, 2), ;
                    faixafs   N(12, 2), ;
                    percs     N(6, 2), ;
                    multiplos N(12, 2), ;
                    lnovos    L )

                THIS.this_lCursorRecriado = .T.
            ENDIF

            *-- SET DELETED eh escopado por data session e o form eh
            *-- DataSession = 2: o SET DELETED ON do config.prg roda na sessao
            *-- 1 e NAO alcanca a sessao privada, que nasce com DELETED OFF.
            *-- Sem repor aqui, o DELETE do botao Excluir apenas MARCA a linha
            *-- e ela continua aparecendo na grade - o usuario clica Excluir e
            *-- nada some, sem erro e sem log. Reposto no ponto que prepara o
            *-- ambiente de dados, para nao depender de cada chamador lembrar.
            SET DELETED ON

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao preparar o cursor das faixas de valores:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CursorTemEstruturaEsperada - confere se o alias tem as colunas desta tela
    *
    * PEMSTATUS NAO serve para isto: o primeiro argumento tem de ser OBJETO, e
    * passar nome de cursor dispara "Function argument value, type, or count is
    * invalid.". Campo de cursor se confere com TYPE(alias + ".campo").
    *==========================================================================
    PROTECTED FUNCTION CursorTemEstruturaEsperada(par_cAlias)
        LOCAL loc_lOk, loc_cLista, loc_cAlias, loc_cCampo, loc_nI, loc_nTotal

        loc_lOk    = .T.
        loc_cAlias = ALLTRIM(NVL(par_cAlias, ""))
        loc_cLista = ALLTRIM(THIS.this_cColunasTabela) + "," + ALLTRIM(THIS.this_cColunaNovos)

        IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
            loc_lOk = .F.
        ELSE
            loc_nTotal = OCCURS(",", loc_cLista) + 1

            FOR loc_nI = 1 TO loc_nTotal
                loc_cCampo = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))

                IF !EMPTY(loc_cCampo)
                    IF TYPE(loc_cAlias + "." + loc_cCampo) = "U"
                        loc_lOk = .F.
                        EXIT
                    ENDIF
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarFaixas - traz as faixas da operacao corrente para a grade
    *
    * Equivale ao trecho do Init legado:
    *     With SigCdOpe.poDatamgr
    *         .ReQuery('crSigOpCrr')
    *         SELECT crSigOpCrr
    *         Go Top
    *     EndWith
    *
    * O SELECT vai para um cursor TEMPORARIO e o conteudo eh transferido com
    * ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias do Grid FECHA e
    * RECRIA o alias, zerando ColumnCount: a grade viraria um retangulo branco
    * sem cabecalho e sem coluna, e nada a religaria depois.
    *
    * Filtro por dopes, como o cursor parametrizado do legado - esta tela
    * edita as faixas de UMA operacao. Sem operacao no contexto, cursor vazio
    * eh o resultado CERTO: trazer a tabela inteira exibiria faixa de outras
    * operacoes, e o Encerrar as regravaria sob a operacao errada.
    *==========================================================================
    PROCEDURE CarregarFaixas()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasTmp
        LOCAL loc_cSQL, loc_nResultado, loc_cSafety, loc_oErro

        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_cAlias      = ALLTRIM(THIS.this_cCursorDados)
        loc_cAliasTmp   = ALLTRIM(THIS.this_cCursorTemp)
        loc_cSafety     = ""

        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.CriarCursorDados()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF EMPTY(ALLTRIM(NVL(THIS.this_cOperacao, "")))
                    *-- Grade vazia com a estrutura pronta: nao eh falha.
                    loc_lProsseguir = .F.
                    loc_lSucesso    = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao (modo de teste / validacao de UI) a grade
                    *-- abre vazia, e isso tambem nao eh falha.
                    loc_lProsseguir = .F.
                    loc_lSucesso    = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Comparacao sem RTRIM de proposito: dopes eh char(20) e o
                *-- SQL Server compara char com preenchimento de brancos
                *-- (ANSI), entao o = casa e o indice segue utilizavel.
                loc_cSQL = "SELECT cidchaves, dopes, faixais, faixafs, percs, multiplos" + ;
                           " FROM SigOpCrr" + ;
                           " WHERE dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao)) + ;
                           " ORDER BY faixais, faixafs"

                IF USED(loc_cAliasTmp)
                    USE IN (loc_cAliasTmp)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao carregar as faixas de valores da " + ;
                        "opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- SET SAFETY tambem eh escopado por data session: com
                *-- DataSession = 2 vale ON mesmo com o SET SAFETY OFF do
                *-- main.prg, e ai o ZAP abre o dialogo modal "Are you sure?"
                *-- e CONGELA a tela esperando um clique que ninguem ve.
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF

                SELECT (loc_cAlias)
                ZAP

                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF
                loc_cSafety = ""

                *-- lnovos chega .F. em toda linha do servidor, porque o APPEND
                *-- casa por NOME e o cursor temporario nao tem essa coluna -
                *-- que eh exatamente o desejado: linha vinda do banco eh
                *-- UPDATE na gravacao, nunca INSERT.
                SELECT (loc_cAlias)
                APPEND FROM DBF(loc_cAliasTmp)

                SELECT (loc_cAlias)
                GO TOP

                IF USED(loc_cAliasTmp)
                    USE IN (loc_cAliasTmp)
                ENDIF

                *-- Recarga eh ponto de partida limpo: nada a gravar.
                THIS.this_lHouveInsercao = .F.
                THIS.this_lHouveExclusao = .F.

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar as faixas de valores:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaCursor - acrescenta a linha EM BRANCO de digitacao
    *
    * Transcricao da parte de DADOS do inserelinha legado:
    *     Thisform.lHouveIns = .T.
    *     Select crSigOpCrr
    *     Locate for faixafs=0
    *     If Eof()
    *         Insert Into crSigOpCrr (Dopes, CidChaves) ;
    *             Values (crSigCdOpe.Dopes, fUniqueIds())
    *     EndIf
    *     Select crSigOpCrr
    *
    * O Keyboard '{DNARROW}', o GradeSubN.Refresh e o Column1.SetFocus do
    * legado sao da TELA e ficam no form; aqui mora so a linha do cursor. O
    * ponteiro eh deixado onde o legado o deixa (na linha em branco achada, ou
    * na recem-inserida), porque eh dele que o SetFocus do form depende.
    *
    * Dois detalhes transcritos de proposito, e NAO "corrigidos":
    *   1. lHouveIns eh ligado ANTES do Locate, ou seja mesmo quando a linha
    *      em branco JA existe e nada eh inserido. Eh esse marcador que
    *      autoriza a gravacao do Encerrar - mexer nele mudaria quais edicoes
    *      chegam a ser gravadas.
    *   2. a linha nasce so com dopes e cidchaves; as quatro colunas numericas
    *      ficam no valor em branco do cursor, que eh zero. As seis colunas
    *      sao NOT NULL, portanto zero eh valor gravavel e nao ausencia de
    *      valor - e faixafs = 0 eh justamente o que marca a linha como "em
    *      branco", tanto para o Locate daqui quanto para o descarte da
    *      gravacao.
    *==========================================================================
    PROCEDURE InserirLinhaCursor()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

        THIS.this_cMensagemErro = ""

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor das faixas de valores n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto."
                MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                THIS.this_lErroExibido = .T.
            ELSE
                THIS.this_lHouveInsercao = .T.

                SELECT (loc_cAlias)
                LOCATE FOR faixafs = 0

                IF EOF()
                    INSERT INTO (loc_cAlias) (cidchaves, dopes, lnovos) ;
                        VALUES (LEFT(fUniqueIds(), 20), ;
                                LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20), ;
                                .T.)
                ENDIF

                SELECT (loc_cAlias)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir a linha de faixa de valores:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaCursor - remove a linha corrente da grade (cmdExcluir.Click)
    *
    * Transcricao da parte de DADOS do cmdExcluir.Click legado:
    *     Select crSigOpCrr
    *     If Not Eof()
    *         Thisform.lHouveExcl = .T.
    *         Delete
    *         Skip
    *         Skip - 1
    *     Endif
    *
    * A remocao eh LOCAL: no legado o DELETE so chega ao servidor junto com a
    * gravacao do Encerrar - o poDataMgr.UpDate propaga INSERT, UPDATE e
    * DELETE do cursor remoto de uma vez. GravarFaixas reproduz isso.
    *
    * O par Skip / Skip -1 reposiciona o ponteiro no registro visivel mais
    * proximo e depende de SET DELETED ON, reposto em CriarCursorDados: com
    * DELETED OFF ele viraria um vai-e-vem inocuo e a linha apagada seguiria
    * aparecendo na grade.
    *==========================================================================
    PROCEDURE ExcluirLinhaCursor()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = ALLTRIM(THIS.this_cCursorDados)

        THIS.this_cMensagemErro = ""

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor das faixas de valores n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto."
                MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                THIS.this_lErroExibido = .T.
            ELSE
                SELECT (loc_cAlias)

                IF !EOF()
                    THIS.this_lHouveExclusao = .T.
                    DELETE
                    SKIP
                    SKIP -1
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir a linha de faixa de valores:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HaAlteracaoPendente - guard de gravacao do Encerrar
    *
    * Transcricao literal do cmdSair.Click legado:
    *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *
    * ATENCAO - comportamento do legado preservado de proposito: edicao que
    * nao passa pela ultima coluna nao liga nenhum dos dois marcadores e
    * portanto NAO eh gravada. Na pratica isso quase nunca acontece, porque o
    * LostFocus da Column4 chama inserelinha (que liga lHouveIns) sempre que
    * nao existe linha em branco - e, vindo do servidor, nenhuma linha tem
    * faixafs = 0. Transcrito como esta, e nao alargado, porque mexer no guard
    * mudaria o que a tela grava.
    *==========================================================================
    FUNCTION HaAlteracaoPendente()
        RETURN (THIS.this_lHouveExclusao OR THIS.this_lHouveInsercao)
    ENDFUNC

    *==========================================================================
    * GravarFaixas - persiste TODAS as faixas de uma vez (cmdSair.Click legado)
    *
    * Transcricao do cmdSair.Click legado:
    *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
    *         Select CrSigOpCrr
    *         Go Top
    *         Delete For Empty(Dopes) or Empty(faixafs)
    *         Replace CidChaves with fUniqueIds() For Empty(CidChaves)
    *         ... poDataMgr.UpDate / Commit / RollBack ...
    *         erro -> MessageBox de "Erro na Gravacao dos Dados ..."
    *     EndIf
    *
    * O poDataMgr.UpDate de um cursor REMOTO propaga as tres operacoes de uma
    * vez: INSERT das linhas acrescentadas, UPDATE das alteradas e DELETE das
    * marcadas. Aqui a grade vive num CREATE CURSOR comum, entao a
    * reconciliacao eh explicita - e eh para isso que lnovos existe:
    *
    *     linha marcada DELETED, lnovos = .F.  -> DELETE no servidor
    *     linha marcada DELETED, lnovos = .T.  -> nada (nunca foi gravada)
    *     linha viva, lnovos = .T.             -> INSERT
    *     linha viva, lnovos = .F.             -> UPDATE
    *
    * Tudo num LOTE unico e ATOMICO, que eh o equivalente fiel do par
    * UpDate/Commit com RollBack do legado.
    *==========================================================================
    PROCEDURE GravarFaixas()
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cAlias, loc_cAliasAnterior
        LOCAL loc_cDeleted, loc_nRecnoAnterior, loc_cComando, loc_oErro

        *-- Sem alteracao a gravar, Encerrar eh sucesso: nada a gravar nao eh
        *-- falha, e eh exatamente o que o guard do legado decide.
        loc_lSucesso       = .T.
        loc_lProsseguir    = .T.
        loc_cAlias         = ALLTRIM(THIS.this_cCursorDados)
        loc_cAliasAnterior = ALIAS()
        loc_cDeleted       = ""
        loc_nRecnoAnterior = 0

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        THIS.this_cLoteGravacao = ""

        THIS.this_nRegistrosInseridos   = 0
        THIS.this_nRegistrosAtualizados = 0
        THIS.this_nRegistrosExcluidos   = 0

        TRY
            IF !THIS.HaAlteracaoPendente()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED(loc_cAlias)
                    THIS.this_cMensagemErro = "O cursor das faixas de valores n" + ;
                        CHR(227) + "o est" + CHR(225) + " aberto."
                    MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                    THIS.this_lErroExibido = .T.
                    loc_lProsseguir = .F.
                    loc_lSucesso    = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- RECNO guardado junto com o alias: o SCAN abaixo varre o
                *-- cursor inteiro e deixa o ponteiro em EOF. Repor so o alias
                *-- devolveria a area de trabalho certa com a LINHA errada, e
                *-- a grade do usuario mudaria de registro sozinha.
                loc_nRecnoAnterior = RECNO(loc_cAlias)

                *-- Descarte do legado: linha sem operacao, ou com faixa final
                *-- zerada (a linha "em branco" de digitacao), nao eh gravada.
                SELECT (loc_cAlias)
                GO TOP
                DELETE FOR EMPTY(dopes) OR faixafs = 0

                *-- A PK eh gerada por LINHA. Cada registro recebe um valor
                *-- proprio porque o VFP reavalia a expressao do WITH a cada
                *-- registro - chave repetida colidiria no indice unico a
                *-- partir da segunda linha.
                REPLACE cidchaves WITH LEFT(fUniqueIds(), 20) ;
                    FOR EMPTY(cidchaves) IN (loc_cAlias)

                *-- DELETED OFF para o SCAN VER as linhas marcadas: sao elas
                *-- que viram DELETE no servidor. Reposto apos a varredura.
                loc_cDeleted = SET("DELETED")
                SET DELETED OFF

                SELECT (loc_cAlias)
                GO TOP

                SCAN
                    loc_cComando = ""

                    IF DELETED()
                        *-- Linha removida da grade. Se nunca foi gravada, nao
                        *-- existe no servidor e nada ha a apagar la.
                        IF !lnovos AND !EMPTY(cidchaves)
                            THIS.CarregarDoCursor(loc_cAlias)
                            loc_cComando = THIS.MontarDeleteLinha()

                            IF EMPTY(loc_cComando)
                                MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                                THIS.this_lErroExibido = .T.
                                loc_lProsseguir = .F.
                                loc_lSucesso    = .F.
                                EXIT
                            ENDIF

                            THIS.AcrescentarAoLote(loc_cComando)
                            THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("DELETE"))
                            THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
                        ENDIF
                    ELSE
                        THIS.CarregarDoCursor(loc_cAlias)

                        *-- Depois do descarte acima nenhuma linha viva deveria
                        *-- reprovar. Se reprovar, a gravacao INTEIRA para com
                        *-- a mensagem: pular a linha calada gravaria o resto e
                        *-- perderia essa sem o usuario saber.
                        IF !THIS.ValidarDados()
                            MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                            THIS.this_lErroExibido = .T.
                            loc_lProsseguir = .F.
                            loc_lSucesso    = .F.
                            EXIT
                        ENDIF

                        IF lnovos
                            loc_cComando = THIS.MontarInsertLinha()
                        ELSE
                            loc_cComando = THIS.MontarUpdateLinha()
                        ENDIF

                        IF EMPTY(loc_cComando)
                            MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                            THIS.this_lErroExibido = .T.
                            loc_lProsseguir = .F.
                            loc_lSucesso    = .F.
                            EXIT
                        ENDIF

                        THIS.AcrescentarAoLote(loc_cComando)

                        IF lnovos
                            THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("INSERT"))
                            THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
                        ELSE
                            THIS.AcrescentarAoLote(THIS.MontarInsertAuditoria("UPDATE"))
                            THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_cDeleted = "ON"
                    SET DELETED ON
                ENDIF
                loc_cDeleted = ""
            ENDIF

            IF loc_lProsseguir
                IF EMPTY(ALLTRIM(THIS.this_cLoteGravacao))
                    *-- Nada sobrou: as linhas em aberto eram todas em branco e
                    *-- cairam no mesmo descarte do legado. Encerrar sem gravar.
                    loc_lSucesso = .T.
                ELSE
                    loc_lSucesso = THIS.ExecutarLoteGravacao()
                ENDIF
            ENDIF

            IF USED(loc_cAlias)
                IF loc_lProsseguir AND loc_lSucesso
                    *-- Gravou: as linhas marcadas saem FISICAMENTE do cursor e
                    *-- as novas deixam de ser novas. Sem isso, uma segunda
                    *-- gravacao reenviaria os mesmos DELETE e repetiria os
                    *-- INSERT, colidindo na chave primaria.
                    SELECT (loc_cAlias)
                    PACK
                    REPLACE ALL lnovos WITH .F. IN (loc_cAlias)
                    GO TOP IN (loc_cAlias)

                    THIS.this_lHouveInsercao = .F.
                    THIS.this_lHouveExclusao = .F.
                ELSE
                    IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(loc_cAlias))
                        GO loc_nRecnoAnterior IN (loc_cAlias)
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_cDeleted = "ON"
                SET DELETED ON
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados do Cadastro de " + ;
                "Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AcrescentarAoLote - enfileira um comando no lote transacional
    *==========================================================================
    PROTECTED FUNCTION AcrescentarAoLote(par_cComando)
        LOCAL loc_lOk, loc_cComando

        loc_lOk      = .F.
        loc_cComando = ALLTRIM(NVL(par_cComando, ""))

        IF !EMPTY(loc_cComando)
            THIS.this_cLoteGravacao = THIS.this_cLoteGravacao + loc_cComando + ;
                ";" + CHR(13) + CHR(10)
            loc_lOk = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * ExecutarLoteGravacao - manda o lote num SQLEXEC unico e ATOMICO
    *
    * Por que nao BEGIN/COMMIT em SQLEXEC separados: a conexao deste ambiente
    * nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao um BEGIN
    * proprio apenas ANINHA (vai para 2) e o COMMIT correspondente volta para
    * 1 sem efetivar nada - e um ROLLBACK nomeado nessa situacao nem roda.
    * Dai o SAVE TRANSACTION quando ja ha transacao aberta (o caso normal) e o
    * THROW no CATCH, que faz o erro chegar ao retorno do SQLEXEC e deixa
    * CapturarErroSQL() com o texto real do SQL Server.
    *
    * NAO ha SQLROLLBACK no caminho de erro, de proposito: o BEGIN CATCH do
    * lote ja desfez o que este metodo escreveu (ate o savepoint), e um
    * SQLROLLBACK aqui derrubaria tambem a transacao do RESTO da aplicacao,
    * que compartilha o mesmo gnConnHandle. O SQLCOMMIT do caminho de sucesso
    * eh o Commit() do poDataMgr legado - passo com caminho de falha proprio,
    * nao detalhe de infra: sem ele o gravado so se efetiva no disconnect
    * limpo e SOME se o processo for morto.
    *==========================================================================
    PROTECTED FUNCTION ExecutarLoteGravacao()
        LOCAL loc_lOk, loc_cSQL, loc_cCRLF, loc_cSavepoint
        LOCAL loc_nResultado, loc_lManual

        loc_lOk   = .F.
        loc_cCRLF = CHR(13) + CHR(10)

        IF EMPTY(ALLTRIM(NVL(THIS.this_cLoteGravacao, "")))
            THIS.this_cMensagemErro = "Nada para gravar."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            RETURN .F.
        ENDIF

        loc_cSavepoint = ALLTRIM(THIS.this_cNomeSavepoint)

        *-- Medido antes do lote: com a conexao em auto-commit o par fica
        *-- inerte. IF ANINHADO mais abaixo de proposito - VFP9 nao faz
        *-- curto-circuito em AND e chamaria o SQLCOMMIT de qualquer jeito.
        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        loc_cSQL = "SET NOCOUNT ON;" + loc_cCRLF + ;
            "DECLARE @nivel int = @@TRANCOUNT;" + loc_cCRLF + ;
            "IF @nivel = 0 BEGIN TRANSACTION" + loc_cCRLF + ;
            "ELSE SAVE TRANSACTION " + loc_cSavepoint + ";" + loc_cCRLF + ;
            "BEGIN TRY" + loc_cCRLF + ;
            THIS.this_cLoteGravacao + ;
            "IF @nivel = 0 COMMIT TRANSACTION;" + loc_cCRLF + ;
            "END TRY" + loc_cCRLF + ;
            "BEGIN CATCH" + loc_cCRLF + ;
            "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + loc_cCRLF + ;
            "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION " + loc_cSavepoint + "; END;" + loc_cCRLF + ;
            "THROW;" + loc_cCRLF + ;
            "END CATCH"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + "es." + ;
                CHR(13) + CapturarErroSQL()
            loc_lOk = .F.
        ELSE
            loc_lOk = .T.
        ENDIF

        IF loc_lManual
            IF loc_lOk
                = SQLCOMMIT(gnConnHandle)
            ENDIF
        ENDIF

        THIS.this_cLoteGravacao = ""

        IF !loc_lOk
            MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - le a linha CORRENTE do cursor para as propriedades
    *
    * SELECT do alias ANTES de ler os campos: "campo" NAO eh
    * sintaxe valida em VFP9 - dispara "Function name is missing )".
    *
    * TratarNulo em todas as colunas porque SigOpCrr eh lida com SELECT e
    * qualquer coluna pode chegar NULL do driver; as quatro numericas voltam a
    * zero, que eh valor gravavel nas colunas NOT NULL da tabela.
    *
    * par_cCursor - alias a ler. Omitido, usa o cursor da grade.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lSucesso, loc_cCursor, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = ALLTRIM(THIS.this_cCursorDados)

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
            loc_cCursor = ALLTRIM(par_cCursor)
        ENDIF

        TRY
            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "O cursor [" + loc_cCursor + "] n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cCursor)

                IF EOF()
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                        " linha corrente para carregar."
                ELSE
                    THIS.this_cCidchaves = ALLTRIM(TratarNulo(cidchaves, ""))
                    THIS.this_cDopes     = ALLTRIM(TratarNulo(dopes, ""))
                    THIS.this_nFaixais   = TratarNulo(faixais, 0)
                    THIS.this_nFaixafs   = TratarNulo(faixafs, 0)
                    THIS.this_nPercs     = TratarNulo(percs, 0)
                    THIS.this_nMultiplos = TratarNulo(multiplos, 0)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao ler a faixa de valores do cursor:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - criterio de aceitacao de UMA faixa
    *
    * O legado NAO tem validacao de tela aqui: a unica regra que ele aplica eh
    * o descarte do cmdSair.Click,
    *     Delete For Empty(Dopes) or Empty(faixafs)
    * mais a exigencia implicita de chave,
    *     Replace CidChaves with fUniqueIds() For Empty(CidChaves)
    *
    * Sao essas as tres condicoes conferidas aqui, e NADA ALEM. Em especial
    * NAO se exige faixais <= faixafs, nem percs > 0, nem faixa sem
    * sobreposicao: o legado aceita tudo isso, e inventar a regra bloquearia
    * gravacao que hoje funciona.
    *
    * Empty(faixafs) sobre coluna numerica eh exatamente faixafs = 0, que eh
    * tambem o que marca a linha "em branco" de digitacao.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                "o da faixa de valores n" + CHR(227) + "o informada."

        CASE THIS.this_nFaixafs = 0
            THIS.this_cMensagemErro = "Faixa Final n" + CHR(227) + "o informada."

        CASE EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
            THIS.this_cMensagemErro = "Chave da faixa de valores n" + CHR(227) + ;
                "o gerada."

        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * MontarInsertLinha - INSERT da faixa corrente, com as SEIS colunas
    *
    * As seis colunas de SigOpCrr sao NOT NULL e nenhuma tem DEFAULT
    * (conferido em docs/schema.sql, lido com Get-Content -Raw por ser
    * UTF-16). O legado grava o registro INTEIRO - AddCursor sem query eh
    * SELECT * + TABLEUPDATE - entao as duas colunas que nao aparecem na tela
    * (cidchaves e dopes) continuam sendo gravadas. Omitir qualquer uma aqui
    * faria o SQL Server recusar o INSERT INTEIRO, e a tela nao incluiria nada.
    *
    * LEFT(...,20) nas duas colunas char: a largura vem do SCHEMA, nunca do
    * tamanho do controle na tela.
    *==========================================================================
    PROTECTED FUNCTION MontarInsertLinha()
        LOCAL loc_cChave, loc_cDopes

        loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidchaves, "")), 20)
        loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

        IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
            THIS.this_cMensagemErro = "Faixa de valores sem chave ou sem opera" + ;
                CHR(231) + CHR(227) + "o - inclus" + CHR(227) + "o cancelada."
            RETURN ""
        ENDIF

        RETURN "INSERT INTO SigOpCrr" + ;
            " (cidchaves, dopes, faixais, faixafs, percs, multiplos)" + ;
            " VALUES (" + EscaparSQL(loc_cChave) + ", " + ;
            EscaparSQL(loc_cDopes) + ", " + ;
            FormatarNumeroSQL(THIS.this_nFaixais, 2) + ", " + ;
            FormatarNumeroSQL(THIS.this_nFaixafs, 2) + ", " + ;
            FormatarNumeroSQL(THIS.this_nPercs, 2) + ", " + ;
            FormatarNumeroSQL(THIS.this_nMultiplos, 2) + ")"
    ENDFUNC

    *==========================================================================
    * MontarUpdateLinha - UPDATE da faixa corrente, pela chave primaria
    *
    * dopes entra no SET junto com as quatro numericas porque eh coluna de
    * DADOS do registro (e NOT NULL), nao parte da chave: a PK de SigOpCrr eh
    * so cidchaves (constraint sigopcrr_cidchaves).
    *==========================================================================
    PROTECTED FUNCTION MontarUpdateLinha()
        LOCAL loc_cChave, loc_cDopes

        loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidchaves, "")), 20)
        loc_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

        IF EMPTY(loc_cChave) OR EMPTY(loc_cDopes)
            THIS.this_cMensagemErro = "Faixa de valores sem chave ou sem opera" + ;
                CHR(231) + CHR(227) + "o - altera" + CHR(231) + CHR(227) + ;
                "o cancelada."
            RETURN ""
        ENDIF

        RETURN "UPDATE SigOpCrr SET" + ;
            " dopes = " + EscaparSQL(loc_cDopes) + "," + ;
            " faixais = " + FormatarNumeroSQL(THIS.this_nFaixais, 2) + "," + ;
            " faixafs = " + FormatarNumeroSQL(THIS.this_nFaixafs, 2) + "," + ;
            " percs = " + FormatarNumeroSQL(THIS.this_nPercs, 2) + "," + ;
            " multiplos = " + FormatarNumeroSQL(THIS.this_nMultiplos, 2) + ;
            " WHERE cidchaves = " + EscaparSQL(loc_cChave)
    ENDFUNC

    *==========================================================================
    * MontarDeleteLinha - DELETE da faixa corrente, pela chave primaria
    *==========================================================================
    PROTECTED FUNCTION MontarDeleteLinha()
        LOCAL loc_cChave

        loc_cChave = LEFT(ALLTRIM(NVL(THIS.this_cCidchaves, "")), 20)

        IF EMPTY(loc_cChave)
            THIS.this_cMensagemErro = "Faixa de valores sem chave - exclus" + ;
                CHR(227) + "o cancelada."
            RETURN ""
        ENDIF

        RETURN "DELETE FROM SigOpCrr WHERE cidchaves = " + EscaparSQL(loc_cChave)
    ENDFUNC

    *==========================================================================
    * MontarInsertAuditoria - comando de auditoria para entrar no MESMO lote
    *
    * Vai junto com a operacao no lote transacional, e nao por SQLEXEC a
    * parte: assim o log nunca registra uma gravacao que foi desfeita.
    *
    * DataHora recebe GETDATE() literal, funcao do servidor. NUNCA
    * GETDATE(): o filtro de tipo dessa funcao devolveria a
    * string "NULL" e o INSERT quebraria na coluna NOT NULL.
    *
    * Larguras de LogAuditoria no schema: Tabela varchar(100),
    * Operacao varchar(10), ChaveRegistro varchar(100), Usuario varchar(50).
    *==========================================================================
    PROTECTED FUNCTION MontarInsertAuditoria(par_cOperacao)
        LOCAL loc_cOperacao, loc_cChave, loc_cUsuario

        loc_cOperacao = UPPER(ALLTRIM(NVL(par_cOperacao, "")))
        loc_cChave    = ALLTRIM(NVL(THIS.ObterChavePrimaria(), ""))
        loc_cUsuario  = "SISTEMA"

        IF TYPE("gc_4c_UsuarioLogado") = "C"
            IF !EMPTY(ALLTRIM(gc_4c_UsuarioLogado))
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
        ENDIF

        *-- Sem operacao ou sem chave nao ha o que auditar. Devolver vazio eh
        *-- inocuo: AcrescentarAoLote ignora comando vazio e a gravacao do
        *-- DADO, que eh o que importa, segue adiante.
        IF EMPTY(loc_cOperacao) OR EMPTY(loc_cChave)
            RETURN ""
        ENDIF

        RETURN "INSERT INTO LogAuditoria" + ;
            " (Tabela, Operacao, ChaveRegistro, Usuario, DataHora)" + ;
            " VALUES (" + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTabela), 100)) + ", " + ;
            EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
            EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
            EscaparSQL(LEFT(loc_cUsuario, 50)) + ", GETDATE())"
    ENDFUNC

    *==========================================================================
    * Inserir - grava UMA faixa de valores (caminho do Salvar da BusinessBase)
    *
    * O caminho normal desta tela eh a gravacao em LOTE do Encerrar
    * (GravarFaixas). Este metodo cumpre o contrato Salvar() -> Inserir() da
    * BusinessBase e serve para gravar uma unica faixa sem passar pela grade.
    * Os dois caminhos compartilham o MESMO montador de SQL, para que a lista
    * de colunas nao possa divergir entre eles.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lManual, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- PK e operacao completadas a partir do contexto quando vem
            *-- vazias, como no Insert Into do inserelinha legado.
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
                THIS.this_cDopes = LEFT(ALLTRIM(NVL(THIS.this_cOperacao, "")), 20)
            ENDIF

            loc_cSQL = THIS.MontarInsertLinha()

            IF EMPTY(loc_cSQL)
                *-- MontarInsertLinha ja deixou a mensagem em this_cMensagemErro
                *-- e quem exibe eh o ExibirFalha do Salvar da BusinessBase.
                loc_lSucesso = .F.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ELSE
                    loc_lManual    = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao incluir a faixa de valores:" + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("INSERT")

                        IF loc_lManual
                            = SQLCOMMIT(gnConnHandle)
                        ENDIF

                        THIS.this_nRegistrosInseridos = THIS.this_nRegistrosInseridos + 1
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao incluir a faixa de valores:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - grava a alteracao de UMA faixa (contrato do Salvar)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lManual, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = THIS.MontarUpdateLinha()

            IF EMPTY(loc_cSQL)
                loc_lSucesso = .F.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ELSE
                    loc_lManual    = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao alterar a faixa de valores:" + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")

                        IF loc_lManual
                            = SQLCOMMIT(gnConnHandle)
                        ENDIF

                        THIS.this_nRegistrosAtualizados = THIS.this_nRegistrosAtualizados + 1
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao alterar a faixa de valores:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - apaga UMA faixa no servidor, pela chave primaria
    *
    * PROTECTED de proposito: de fora, sempre Excluir() da BusinessBase, que
    * valida o estado, roda os hooks e garante que a falha nunca eh muda.
    *
    * No fluxo da TELA a remocao eh local (ExcluirLinhaCursor) e so chega ao
    * servidor junto com a gravacao do Encerrar, por reconciliacao - que eh o
    * que o poDataMgr.UpDate do cursor remoto fazia. Os dois caminhos usam o
    * MESMO montador de SQL.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lManual, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSQL = THIS.MontarDeleteLinha()

            IF EMPTY(loc_cSQL)
                loc_lSucesso = .F.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ELSE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

                    *-- Auditoria ANTES do DELETE: ObterChavePrimaria le a
                    *-- property, que o LimparDados do Excluir() zera depois.
                    THIS.RegistrarAuditoria("DELETE")

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao excluir a faixa de valores:" + ;
                            CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Faixas de Valores")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        IF loc_lManual
                            = SQLCOMMIT(gnConnHandle)
                        ENDIF

                        THIS.this_nRegistrosExcluidos = THIS.this_nRegistrosExcluidos + 1
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir a faixa de valores:" + CHR(13) + ;
                loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Faixas de Valores")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - devolve as propriedades ao estado de registro novo
    *
    * dopes volta para a operacao do CONTEXTO, nao para vazio: toda faixa
    * desta tela pertence a operacao que o form pai esta editando, e eh desse
    * valor que o InicializarValoresPadrao tambem parte.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_cDopes     = ALLTRIM(NVL(THIS.this_cOperacao, ""))
        THIS.this_nFaixais   = 0
        THIS.this_nFaixafs   = 0
        THIS.this_nPercs     = 0
        THIS.this_nMultiplos = 0

        THIS.this_cLoteGravacao = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - fecha os cursores desta tela
    *
    * USE IN fecha o alias mesmo com buffer sujo, e por isso NAO ha
    * TABLEREVERT aqui: TABLEREVERT exige buffering e, sobre cursor criado por
    * CREATE CURSOR (que nasce com Buffering = 1), dispara o erro 1586
    * "Function requires row or table buffering mode." - que num Destroy fora
    * de TRY viraria Program Error cru na cara do usuario.
    *==========================================================================
    PROCEDURE Destroy()
        IF USED(ALLTRIM(THIS.this_cCursorTemp))
            USE IN (ALLTRIM(THIS.this_cCursorTemp))
        ENDIF

        IF USED(ALLTRIM(THIS.this_cCursorAux))
            USE IN (ALLTRIM(THIS.this_cCursorAux))
        ENDIF

        IF USED(ALLTRIM(THIS.this_cCursorDados))
            USE IN (ALLTRIM(THIS.this_cCursorDados))
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
