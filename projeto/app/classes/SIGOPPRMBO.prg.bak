*==============================================================================
* SIGOPPRMBO.prg - Business Object para FormSIGOPPRM (Promocoes do Produto)
* Herda de BusinessBase
*
* ATENCAO: este form eh um dialogo OPERACIONAL (modal) aberto pelo Cadastro de
* Produtos - no legado "Do Form SigOpPrm With ThisForm" (sigcdpro), disparado
* apos a pergunta "O Produto Encontra-se Em Promocao!!! Deseja Conferir ?".
* Ele lista as PROMOCOES em que o produto corrente se encontra (tabela
* SigPrPmi, filtrada pelo codigo do produto) numa grade com coluna de
* marcacao, e permite RETIRAR o produto das promocoes marcadas.
*
* O Load legado cria o cursor local da grade e o Init o popula a partir do
* cursor crSigPrPmi que o form PAI ja deixa aberto:
*     Create Cursor csEmpresas (ImpEmps l(1), CPros c(14), Pecas c(10), ;
*                               Promos c(25), Datas t Null, cIdChaves c(20))
*     Index On CPros + Promos Tag CPros
* No sistema novo o form pai (FormProduto) nao mantem esse cursor aberto, por
* isso este BO le a MESMA consulta que o pai usava no AddCursor:
*     lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
* Os nomes das colunas e o filtro sao transcritos do legado (PILAR 2).
*
* O btnRetirar.Click legado executa, por linha marcada, TRES passos:
*   1) Delete From SigPrPmi  Where cIdChaves = ?pChv   (SQL Server)
*   2) Delete From crSigPrPmi Where cIdChaves = pChv   (cursor do form PAI)
*   3) Delete From csEmpresas Where cIdChaves = pChv   (cursor da grade)
* precedidos do gate de acesso fChecaAcesso('SigCdPrm', 'EXCLUIR') Or
* fChecaAcesso('SigCdPrm', 'ALTERAR'), e seguidos de GridEmps.Refresh.
*
* Como o legado SO exclui (nunca insere nem altera SigPrPmi nesta tela), o
* comportamento padrao herdado de BusinessBase para Inserir()/Atualizar() ja
* eh o correto - inventar INSERT/UPDATE aqui violaria a regra de que a lista
* de colunas vem do schema e nao de suposicao.
*
* Tabela ...: SigPrPmi
* Chave .....: cidchaves (char 20) - PK sigprpmi_cidchaves
*==============================================================================
DEFINE CLASS SIGOPPRMBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - colunas de SigPrPmi (uma promocao do produto)
    * Tipos conferidos em docs/schema.sql:
    *   cpros char(14) NOT NULL | pecas char(10) NOT NULL
    *   promos char(25) NOT NULL | cbars numeric(14,0) NOT NULL
    *   datas datetime NULL | cidchaves char(20) NOT NULL (PK)
    *   dtalts datetime NULL | promopro char(35) NOT NULL
    *   vendavels numeric(1,0) NOT NULL
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && SigPrPmi.cpros     - codigo do produto (char 14)
    this_cPecas     = ""    && SigPrPmi.pecas     - peca da promocao (char 10)
    this_cPromos    = ""    && SigPrPmi.promos    - codigo da promocao (char 25)
    this_nCbars     = 0     && SigPrPmi.cbars     - codigo de barras numeric(14,0)
    this_dDatas     = {}    && SigPrPmi.datas     - data da promocao (datetime NULL)
    this_cCidChaves = ""    && SigPrPmi.cidchaves - chave primaria Fortyus (char 20)
    this_dDtAlts    = {}    && SigPrPmi.dtalts    - data da ultima alteracao (datetime NULL)
    this_cPromoPro  = ""    && SigPrPmi.promopro  - descricao da promocao (char 35)
    this_nVendavels = 0     && SigPrPmi.vendavels - indicador vendavel numeric(1,0)

    *--------------------------------------------------------------------------
    * Propriedades - estado de tela (NAO existem em SigPrPmi)
    *--------------------------------------------------------------------------
    *-- Marcacao da linha na grade. No legado eh a coluna ImpEmps l(1) do cursor
    *-- local csEmpresas, alimentada com .f. no Insert Into do Init e alternada
    *-- pelos handlers MouseDown/KeyPress do Check1 da Column1.
    this_lImpEmps = .F.

    *-- Nome do cursor que alimenta a grade do dialogo (equivale a csEmpresas).
    this_cCursorItens = "cursor_4c_Promocoes"

    *-- Nome do cursor de SigPrPmi que o form PAI mantem aberto, quando houver
    *-- (equivale a crSigPrPmi). Vazio significa que o pai nao tem esse cursor e
    *-- o passo 2 da retirada do legado nao se aplica.
    this_cCursorItensPai = ""

    *-- pcEscolha do form PAI, recebido junto com a referencia do pai no Init do
    *-- form (LParameters pAnt / ThisForm.ParentForm = pAnt). O legado compara
    *-- com 'CONSULTAR' para decidir Column1.ReadOnly e a visibilidade de
    *-- btnRetirar/cmdRetirar.
    this_cModoEscolha = ""

    *-- .T. quando this_cModoEscolha = "CONSULTAR": a coluna de marcacao fica
    *-- somente leitura e o botao Retirar fica oculto.
    this_lSomenteConsulta = .F.

    *-- Resultado do gate de acesso do btnRetirar.Click legado
    *-- (fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso('SigCdPrm','ALTERAR')).
    this_lTemAcessoRetirar = .F.

    *-- Programa consultado no gate de acesso (1o argumento do fChecaAcesso).
    this_cProgramaAcesso = "SigCdPrm"

    *-- Contadores do dialogo: promocoes carregadas, marcadas e efetivamente
    *-- retiradas na ultima execucao da retirada.
    this_nTotalPromocoes    = 0
    this_nTotalSelecionadas = 0
    this_nTotalRetiradas    = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave e zera o estado do dialogo.
    * DODEFAULT() sem argumento segue o padrao dos BOs de dialogo OPERACIONAL
    * (SigOpPrLBO): a tabela eh atribuida direto, sem instanciar DataAccess,
    * porque o acesso desta tela eh Select/Delete via SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigPrPmi"
                THIS.this_cCampoChave = "cidchaves"

                *-- Estado inicial do dialogo
                THIS.this_cCursorItens       = "cursor_4c_Promocoes"
                THIS.this_cCursorItensPai    = ""
                THIS.this_cModoEscolha       = ""
                THIS.this_lSomenteConsulta   = .F.
                THIS.this_lTemAcessoRetirar  = .F.
                THIS.this_cProgramaAcesso    = "SigCdPrm"
                THIS.this_nTotalPromocoes    = 0
                THIS.this_nTotalSelecionadas = 0
                THIS.this_nTotalRetiradas    = 0

                *-- Colunas de SigPrPmi da linha corrente
                THIS.this_cCPros     = ""
                THIS.this_cPecas     = ""
                THIS.this_cPromos    = ""
                THIS.this_nCbars     = 0
                THIS.this_dDatas     = {}
                THIS.this_cCidChaves = ""
                THIS.this_dDtAlts    = {}
                THIS.this_cPromoPro  = ""
                THIS.this_nVendavels = 0
                THIS.this_lImpEmps   = .F.

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            loc_lResultado = .F.
            MsgErro("Erro ao inicializar SIGOPPRMBO: " + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades desta promocao a partir da
    * linha CORRENTE de um cursor aberto.
    *
    * Aceita DOIS formatos de cursor, porque sao os dois usados por este
    * dialogo (regra #9 - sempre SELECT (alias) antes de ler os campos, nunca
    * campo):
    *   1) a MESMA consulta que o form pai usa no AddCursor - Select * From
    *      SigPrPmi Where cpros = ?pPro - com TODAS as colunas da tabela
    *      (cpros, pecas, promos, cbars, datas, cidchaves, dtalts, promopro,
    *      vendavels);
    *   2) o cursor local da grade (equivalente a csEmpresas do legado), que
    *      tem so ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves.
    * Por isso as colunas exclusivas de SigPrPmi (cbars/dtalts/promopro/
    * vendavels) e a marcacao exclusiva da grade (ImpEmps) sao lidas so
    * quando TYPE() confirma que existem no alias recebido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de promo" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF EOF()
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente no cursor de promo" + CHR(231) + CHR(245) + "es"
            RETURN .F.
        ENDIF

        THIS.this_cCPros     = TratarNulo(cpros, "")
        THIS.this_cPecas     = TratarNulo(pecas, "")
        THIS.this_cPromos    = TratarNulo(promos, "")
        THIS.this_dDatas     = TratarNulo(datas, {})
        THIS.this_cCidChaves = TratarNulo(cidchaves, "")

        IF TYPE(par_cAliasCursor + ".cbars") != "U"
            THIS.this_nCbars = TratarNulo(cbars, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".dtalts") != "U"
            THIS.this_dDtAlts = TratarNulo(dtalts, {})
        ENDIF

        IF TYPE(par_cAliasCursor + ".promopro") != "U"
            THIS.this_cPromoPro = TratarNulo(promopro, "")
        ENDIF

        IF TYPE(par_cAliasCursor + ".vendavels") != "U"
            THIS.this_nVendavels = TratarNulo(vendavels, 0)
        ENDIF

        IF TYPE(par_cAliasCursor + ".ImpEmps") != "U"
            THIS.this_lImpEmps = TratarNulo(ImpEmps, .F.)
        ENDIF

        THIS.this_cMensagemErro = ""
        loc_lResultado = .T.

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria Fortyus da promocao corrente
    * (sigprpmi_cidchaves). Usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * RetirarPromocao - Remove o produto de UMA promocao: Delete From SigPrPmi
    * Where cidchaves = <chave>, exatamente o passo 1 do btnRetirar.Click do
    * legado. O legado roda esse DELETE dentro de um Scan por linha marcada,
    * precedido do gate fChecaAcesso('SigCdPrm','EXCLUIR') Or fChecaAcesso(
    * 'SigCdPrm','ALTERAR') e de uma confirmacao do usuario, e seguido de DOIS
    * deletes em cursor LOCAL (crSigPrPmi do pai e csEmpresas da grade) - o
    * loop, a confirmacao, o gate de acesso e a manutencao dos cursores da
    * tela sao orquestracao de UI e ficam no Form; este metodo cobre so a
    * operacao de dados de UMA linha (chamada uma vez por cidchaves marcada).
    *
    * Como o legado SO exclui (nunca insere/altera SigPrPmi nesta tela - ver
    * cabecalho da classe), Inserir()/Atualizar() continuam com o
    * comportamento herdado de BusinessBase e este eh o UNICO metodo de
    * gravacao real do BO.
    *--------------------------------------------------------------------------
    PROCEDURE RetirarPromocao(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCidChaves) != "C" OR EMPTY(ALLTRIM(par_cCidChaves))
            MsgErro("Chave da promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada", "Erro")
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cCidChaves = ALLTRIM(par_cCidChaves)
            loc_cCursorTemp = "cursor_4c_DelPmi"

            loc_cSQL = "DELETE FROM SigPrPmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            DO CASE
            CASE loc_nResultado < 0
                *-- Equivale ao "Favor Reinicializar o Processo!!!" / "Falha na
                *-- Conexao (Excluindo Promocao)" do legado
                MsgErro("Favor Reinicializar o Processo (Excluindo Promo" + CHR(231) + CHR(227) + "o)" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
            CASE loc_nResultado = 0
                MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada (j" + CHR(225) + ;
                    " havia sido retirada).", "Aten" + CHR(231) + CHR(227) + "o")
            OTHERWISE
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPromocoes - Popula o cursor da grade (this_cCursorItens,
    * equivalente a csEmpresas) com as promocoes do produto informado.
    *
    * No legado quem roda esta consulta eh o form PAI (Cadastro de Produtos),
    * no AddCursor que deixa crSigPrPmi aberto ANTES de abrir este dialogo
    * ("Select * From SigPrPmi Where CPros = ?pPro"); o Init deste dialogo so
    * faz Scan nesse cursor e:
    *     Insert Into csEmpresas (ImpEmps, CPros, Pecas, Promos, Datas, ;
    *                             cIdChaves) ;
    *         Values (.f., crSigPrPmi.CPros, crSigPrPmi.Pecas, ;
    *                 crSigPrPmi.Promos, Nvl(crSigPrPmi.Datas, Ctod('')), ;
    *                 crSigPrPmi.cIdChaves)
    * com ImpEmps = .f. em TODA linha (marcacao comeca desmarcada). Como o
    * form pai desta arquitetura nao mantem esse cursor aberto (ver
    * cabecalho do Form), este metodo faz as DUAS coisas de uma vez: busca
    * SigPrPmi pelo codigo do produto (a MESMA consulta do AddCursor do pai)
    * e monta this_cCursorItens com a MESMA estrutura/ordem de colunas de
    * "Create Cursor csEmpresas (...)" do Load legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPromocoes(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCursorTemp, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_nTotalPromocoes = 0

        *-- VFP9 nao faz short-circuit em OR - os dois testes ficam em IFs
        *-- separados para o ALLTRIM() nunca rodar sobre valor que nao seja
        *-- Character (CLAUDE.md regra sobre ISNULL(x) OR EMPTY(x))
        IF VARTYPE(par_cCodigoProduto) != "C"
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(par_cCodigoProduto))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cCursorTemp = "cursor_4c_PromocoesTmp"

            *-- "Select * From SigPrPmi Where CPros = ?pPro" do AddCursor do
            *-- form pai (sigcdpro) - a MESMA consulta, transcrita aqui
            *-- porque o form pai desta arquitetura nao mantem o cursor
            *-- aberto (ver cabecalho do Form).
            loc_cSQL = "SELECT * FROM SigPrPmi WHERE cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigoProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo (Buscando Promo" + CHR(231) + CHR(245) + "es)" + CHR(13) + CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF

                *-- "Create Cursor csEmpresas (ImpEmps l(1), CPros c(14),
                *-- Pecas c(10), Promos c(25), Datas t Null, cIdChaves c(20))
                *-- / Index On CPros + Promos Tag CPros" do Load legado -
                *-- mesma estrutura, mesma ordem de colunas.
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (ImpEmps L, CPros C(14), Pecas C(10), Promos C(25), ;
                     Datas T, cIdChaves C(20))
                INDEX ON CPros + Promos TAG CPros

                IF loc_nResultado > 0
                    SELECT (loc_cCursorTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) ;
                            (ImpEmps, CPros, Pecas, Promos, Datas, cIdChaves) ;
                            VALUES (.F., cpros, pecas, promos, ;
                                TratarNulo(datas, {}), cidchaves)
                    ENDSCAN
                ENDIF

                IF USED(loc_cCursorTemp)
                    USE IN (loc_cCursorTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                GO TOP

                THIS.this_nTotalPromocoes = RECCOUNT(THIS.this_cCursorItens)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SIGOPPRMBO.CarregarPromocoes")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
