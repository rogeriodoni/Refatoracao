*==============================================================================
* SigOpLopBO.prg - Business Object: Sub-Nivel (selecao de Operacoes)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (dialogo modal filho - recebe ParentForm, marca/desmarca
*       as Operacoes no cursor do form pai e devolve o controle a ele)
*
* ORIGEM LEGADO: SigOpLop.SCX (Caption "Sub-Nivel"). O Init recebe pFrm (o form
* que abre o dialogo), desabilita o pai e devolve o Enabled no Ok. O dialogo
* NAO executa SQL nenhum: a grade grdOperacoes esta ligada ao cursor LocalSacOp,
* criado e populado por QUEM abre o dialogo, e o Check1 da Column1 alterna
* LocalSacOp.Selecionada por codigo (Gather Memvar Fields Selecionada), com a
* Column2 (Dopes) em ReadOnly.
*
* QUEM ABRE O DIALOGO (achado no acervo legado, 4install\FortyusMC\Fortyus):
* sigatsac.SCX, metodo gerarope, monta o cursor e so entao chama a tela -
* transcrito aqui LITERALMENTE porque eh o CONTRATO da grade:
*
*   lcQuery = [Select 0 as Selecionada, Dopes, GerOpServs, cCodServs,
*              nVlServs, nAliIss, fPags ] + ;
*             [From SigCdSOp ] + ;
*             [Where Codigos = ] + <crSigCdSOs.CodDeps> + [ And ] + ;
*             [GerOpers = 1]
*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSacOp]) < 1) ... Return 0
*   Select LocalSacOp
*   Go Top In LocalSacOp
*   If Eof([LocalSacOp]) ... Else   If (Reccount([LocalSacOp]) > 0)
*       Do Form SigOpLop With ThisForm
*   ...
*   Select LocalSacOp
*   Scan
*       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
*   EndScan
*
* Ou seja: a tabela de origem eh SigCdSOp (Operacoes do Departamento), NAO
* SigCdOpe, e depois de fechado o dialogo o form pai volta a LER o MESMO alias
* LocalSacOp - inclusive as colunas que a grade nao mostra (GerOpServs,
* cCodServs, nVlServs, nAliIss, fPags). Por isso este BO:
*   - mantem o alias legado LocalSacOp (nunca renomeia o cursor do pai);
*   - mapeia as SETE colunas do cursor, nao so as duas visiveis;
*   - trata a camada de dados como CURSOR, nao como INSERT/UPDATE.
*
* GRAVACAO: Inserir(), Atualizar(), ExecutarExclusao() e RegistrarAuditoria()
* ficam HERDADOS de BusinessBase - o comportamento padrao da base ja eh o
* correto para esta tela, porque o legado nao tem TABLEUPDATE, nao tem
* .AddCursor e nao tem Insert/Update/Delete sobre tabela nenhuma: a marcacao
* vive no cursor em memoria e quem persiste qualquer coisa eh o form pai,
* depois do Ok. Sobrescrever esses metodos aqui exigiria INVENTAR um comando de
* gravacao que o legado nao possui.
*
* FASE 1/8: declaracao das propriedades + Init().
* FASE 2/8: camada de dados do cursor - CarregarDoCursor() com TODAS as colunas,
*           CarregarOperacoes() (a query do legado), GarantirCursorGrade(),
*           GradeEditavel(), AlternarSelecao(), AtualizarTotais(), TemSelecao(),
*           LimparDados(), ObterChavePrimaria(), Destroy().
*==============================================================================

DEFINE CLASS SigOpLopBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTRATO DE CURSORES
    *
    * this_cCursorPai   - alias EXATO do legado (LocalSacOp). Pertence ao form
    *                     que abre o dialogo; este BO le e alterna a coluna
    *                     Selecionada dele e, quando o pai pede, o POPULA com a
    *                     query do legado - mas nunca o renomeia.
    * this_cCursorGrade - alias local usado como espelho da grade quando o
    *                     dialogo eh instanciado FORA do fluxo real (validacao
    *                     de UI / teste), em que LocalSacOp nao existe.
    *                     Nomenclatura cursor_4c_* do projeto.
    * this_cCursorTemp  - alias temporario do SQLEXEC. O resultado de SQLEXEC
    *                     nasce SOMENTE-LEITURA e a grade tem coluna EDITAVEL
    *                     (o CheckBox da Column1), entao a consulta cai aqui e
    *                     o alias da grade eh montado READWRITE a partir dele.
    *--------------------------------------------------------------------------
    this_cCursorPai   = "LocalSacOp"
    this_cCursorGrade = "cursor_4c_Operacoes"
    this_cCursorTemp  = "cursor_4c_OperacoesTmp"

    *--------------------------------------------------------------------------
    * COLUNAS DA GRADE (LocalSacOp) - uma propriedade por coluna do legado,
    * na MESMA ordem do Select de sigatsac.gerarope.
    *
    * this_nSelecionada - LocalSacOp.Selecionada. No legado a coluna nasce do
    *                     literal "0 as Selecionada", e o toggle eh
    *                     Iif(Selecionada = 0, 1, 0): eh NUMERICA (0/1), nao
    *                     logica. O pai confere com "Selecionada = 1".
    * this_cDopes       - LocalSacOp.Dopes -> SigCdSOp.dopes char(20). Unica
    *                     coluna EXIBIDA na grade (Column2, ReadOnly).
    * this_nGerOpServs  - LocalSacOp.GerOpServs -> geropservs numeric(1,0).
    *                     Lido pelo pai (If LocalSacOp.GerOpServs = 1 abre o
    *                     SigPrIns de servico), portanto NUMERICO.
    * this_cCodServs    - LocalSacOp.cCodServs -> ccodservs char(10).
    * this_nVlServs     - LocalSacOp.nVlServs  -> nvlservs numeric(11,2).
    * this_nAliIss      - LocalSacOp.nAliIss   -> naliiss  numeric(4,2).
    * this_cFPags       - LocalSacOp.fPags     -> fpags    char(12).
    *--------------------------------------------------------------------------
    this_nSelecionada = 0
    this_cDopes       = ""
    this_nGerOpServs  = 0
    this_cCodServs    = ""
    this_nVlServs     = 0
    this_nAliIss      = 0
    this_cFPags       = ""

    *--------------------------------------------------------------------------
    * TOTALIZADORES DA SELECAO (consultados pelo Form no Ok/Encerrar)
    *
    * this_nTotalOperacoes    - quantidade de linhas da grade
    * this_nTotalSelecionadas - quantidade de linhas com Selecionada = 1
    * this_cOperacoesMarcadas - lista das Operacoes marcadas, separadas por
    *                           virgula, para o form pai consumir sem precisar
    *                           varrer o cursor de novo
    *--------------------------------------------------------------------------
    this_nTotalOperacoes    = 0
    this_nTotalSelecionadas = 0
    this_cOperacoesMarcadas = ""

    *--------------------------------------------------------------------------
    * LARGURAS DO SCHEMA (docs\schema.sql, tabela SigCdSOp) - usadas pelo
    * PADR/LEFT das rotinas de carga e pelo MaxLength dos controles, para nunca
    * exibir nem montar valor maior do que a coluna aceita.
    *--------------------------------------------------------------------------
    this_nTamDopes    = 20
    this_nTamCodServs = 10
    this_nTamFPags    = 12
    this_nTamCodigos  = 10

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * A tabela de origem eh SigCdSOp e a coluna que identifica a linha para
    * ESTE dialogo eh dopes (a PK fisica da tabela eh cidchaves, que o Select
    * do legado NAO traz para o cursor, logo nao esta disponivel aqui).
    *
    * As propriedades sao atribuidas ANTES de DODEFAULT() porque
    * BusinessBase.Init() so instancia o DataAccess quando RECEBE o nome da
    * tabela como parametro - aqui a tela nao grava, entao o DataAccess nao eh
    * necessario e nao se passa parametro.
    *
    * O RETURN .T. explicito eh obrigatorio: Init que devolve .F. faz
    * CREATEOBJECT retornar valor nao-objeto e o form nao abre.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdSOp"
        THIS.this_cCampoChave = "dopes"

        DODEFAULT()

        THIS.LimparDados()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterAliasGrade - Resolve QUAL alias a grade deve usar
    *
    * No fluxo real o cursor eh do form pai (LocalSacOp). Fora dele (validacao
    * de UI / teste headless) esse alias nao existe e a grade cai no espelho
    * local. Resolver o alias por aqui evita espalhar IF USED() por todo o Form
    * e garante que Grid.RecordSource, Column.ControlSource e os handlers do
    * CheckBox falem SEMPRE do mesmo cursor.
    *--------------------------------------------------------------------------
    PROCEDURE ObterAliasGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.this_cCursorGrade

        IF USED(THIS.this_cCursorPai)
            loc_cAlias = THIS.this_cCursorPai
        ENDIF

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GarantirCursorGrade - Assegura que existe um alias com a estrutura da
    *                       grade ANTES de o Grid ser ligado a ele
    *
    * Column.ControlSource apontando para cursor que ainda nao existe estoura
    * "Alias ... is not found" DENTRO do TRY do InicializarForm: o CREATEOBJECT
    * devolve .F. e a tela simplesmente nao abre. Entao, quando o cursor do pai
    * nao esta aberto, cria-se o espelho VAZIO com as SETE colunas na MESMA
    * ordem do Select do legado - sem inventar nenhuma linha, porque sem o form
    * pai nao ha Operacao nenhuma a exibir.
    *
    * Tipos conforme docs\schema.sql (SigCdSOp) e conforme o literal
    * "0 as Selecionada" do legado. O cursor nasce READWRITE, que eh o que a
    * Column1 precisa para aceitar o REPLACE do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE GarantirCursorGrade()
        LOCAL loc_cAlias

        loc_cAlias = THIS.ObterAliasGrade()

        IF !USED(loc_cAlias)
            SET NULL ON
            CREATE CURSOR cursor_4c_Operacoes ( ;
                Selecionada N(1), ;
                Dopes       C(20), ;
                GerOpServs  N(1), ;
                cCodServs   C(10), ;
                nVlServs    N(11,2), ;
                nAliIss     N(4,2), ;
                fPags       C(12))
            SET NULL OFF

            loc_cAlias = THIS.this_cCursorGrade
        ENDIF

        THIS.AtualizarTotais(loc_cAlias)

        RETURN loc_cAlias
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeEditavel - .T. quando o alias da grade aceita REPLACE
    *
    * O CheckBox da Column1 alterna a coluna Selecionada por REPLACE, e isso
    * exige cursor READWRITE. Cursor devolvido por SQLEXEC nasce SOMENTE-LEITURA:
    * nesse caso o controle aparece, recebe foco e NAO muda de valor - defeito
    * silencioso que parece bug de Enabled/ReadOnly. Quem monta o cursor
    * (CarregarOperacoes, aqui, ou o form pai) tem de entregar READWRITE; este
    * metodo existe para que o Form possa AVISAR em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE GradeEditavel(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lEditavel

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        loc_lEditavel = .F.

        IF USED(loc_cAlias)
            loc_lEditavel = !ISREADONLY(loc_cAlias)
        ENDIF

        RETURN loc_lEditavel
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor da grade com a query do legado
    *
    * TRANSCRICAO de sigatsac.gerarope (ver cabecalho). O filtro eh
    * "Codigos = <departamento> And GerOpers = 1" - os dois termos vem do
    * legado e nenhum foi acrescentado.
    *
    * par_cCodigoDepartamento = SigCdSOp.codigos char(10), que no legado vem de
    * crSigCdSOs.CodDeps (a OS selecionada na grade do form pai). Sem esse
    * codigo nao existe consulta possivel: devolve .F. com mensagem, e a grade
    * continua com o espelho vazio criado por GarantirCursorGrade.
    *
    * O SQLEXEC cai em cursor TEMPORARIO e o alias da grade eh montado a partir
    * dele, por dois motivos: (a) o cursor de SQLEXEC eh somente-leitura e a
    * Column1 precisa de REPLACE; (b) SQLEXEC sobre o alias JA ligado a um Grid
    * fecha e recria esse alias, zerando ColumnCount e deixando a grade como um
    * retangulo branco. Com o alias ja aberto e editavel usa-se ZAP + APPEND,
    * que preserva estrutura, RecordSource, ControlSource e CurrentControl.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigoDepartamento)
        LOCAL loc_cSQL, loc_cCodigo, loc_cAlias, loc_nResultado
        LOCAL loc_lSucesso, loc_cSafety, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodigoDepartamento) != "C" OR EMPTY(par_cCodigoDepartamento)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Departamento n" + ;
                CHR(227) + "o informado para carregar as Opera" + CHR(231) + ;
                CHR(245) + "es."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        loc_cCodigo = LEFT(ALLTRIM(par_cCodigoDepartamento), THIS.this_nTamCodigos)

        *-- Select transcrito do legado (sigatsac.gerarope): colunas e ordem
        *-- IDENTICAS, porque o form pai le todas elas depois do Ok.
        loc_cSQL = "SELECT 0 AS Selecionada, Dopes, GerOpServs, cCodServs," + ;
                   " nVlServs, nAliIss, fPags" + ;
                   " FROM SigCdSOp" + ;
                   " WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
                   " AND GerOpers = 1" + ;
                   " ORDER BY Dopes"

        TRY
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar as Opera" + CHR(231) + ;
                    CHR(245) + "es do Departamento: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                loc_cAlias = THIS.ObterAliasGrade()

                IF USED(loc_cAlias) AND !ISREADONLY(loc_cAlias)
                    *-- Alias ja aberto e editavel (tipicamente ligado ao Grid):
                    *-- ZAP + APPEND preserva o binding da grade. SET SAFETY eh
                    *-- escopado por data session e volta a ON em form
                    *-- DataSession = 2, onde o ZAP abriria dialogo modal e
                    *-- congelaria a tela.
                    loc_cSafety = SET("SAFETY")
                    SET SAFETY OFF
                    SELECT (loc_cAlias)
                    ZAP
                    APPEND FROM DBF(THIS.this_cCursorTemp)
                    IF loc_cSafety = "ON"
                        SET SAFETY ON
                    ENDIF
                ELSE
                    *-- Primeira carga (ou alias somente-leitura): monta o alias
                    *-- legado LocalSacOp como cursor READWRITE.
                    IF USED(THIS.this_cCursorPai)
                        USE IN (THIS.this_cCursorPai)
                    ENDIF

                    SELECT * ;
                        FROM cursor_4c_OperacoesTmp ;
                        INTO CURSOR LocalSacOp READWRITE

                    loc_cAlias = THIS.this_cCursorPai
                ENDIF

                IF USED(THIS.this_cCursorTemp)
                    USE IN (THIS.this_cCursorTemp)
                ENDIF

                *-- Go Top In LocalSacOp - exatamente como o legado faz antes de
                *-- abrir o dialogo.
                SELECT (loc_cAlias)
                GO TOP

                THIS.AtualizarTotais(loc_cAlias)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao carregar as Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE do cursor nas propriedades
    *
    * Mapeia as SETE colunas do cursor do legado, nao apenas as duas que a
    * grade exibe: o form pai consome GerOpServs, cCodServs, nVlServs, nAliIss
    * e fPags depois que o dialogo fecha, e eh este metodo que leva esses
    * valores para o BO.
    *
    * Cuidados:
    *   - SELECT (par_cAliasCursor) ANTES de ler os campos, e restauracao da
    *     area de trabalho anterior no fim (nao roubar o SELECT de quem chamou);
    *   - guarda de EOF: cursor vazio ou posicionado no fim nao pode "carregar"
    *     lixo nas propriedades;
    *   - existencia de cada coluna por TYPE(alias + ".coluna") != "U" -
    *     PEMSTATUS exige OBJETO no 1o argumento e estoura com nome de cursor;
    *   - coluna numeric(1,0) pode chegar como Numerico (numeric) ou como Logico
    *     (bit) conforme o driver: VARTYPE antes de comparar, senao da
    *     type mismatch.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_lSucesso, loc_uValor

        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        SELECT (loc_cAlias)

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada no cursor [" + loc_cAlias + "]."
        ELSE
            *-- Selecionada: marcacao numerica 0/1 (literal "0 as Selecionada")
            IF TYPE(loc_cAlias + ".Selecionada") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nSelecionada = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nSelecionada = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- Dopes: a Operacao exibida na Column2 (SigCdSOp.dopes char(20))
            IF TYPE(loc_cAlias + ".Dopes") != "U"
                THIS.this_cDopes = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""), ;
                                        THIS.this_nTamDopes)
            ENDIF

            *-- GerOpServs: numeric(1,0); o form pai testa "= 1"
            IF TYPE(loc_cAlias + ".GerOpServs") != "U"
                loc_uValor = EVALUATE(loc_cAlias + ".GerOpServs")
                IF VARTYPE(loc_uValor) = "N"
                    THIS.this_nGerOpServs = NVL(loc_uValor, 0)
                ELSE
                    THIS.this_nGerOpServs = IIF(NVL(loc_uValor, .F.), 1, 0)
                ENDIF
            ENDIF

            *-- cCodServs: char(10)
            IF TYPE(loc_cAlias + ".cCodServs") != "U"
                THIS.this_cCodServs = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".cCodServs"), ""), ;
                                           THIS.this_nTamCodServs)
            ENDIF

            *-- nVlServs: numeric(11,2)
            IF TYPE(loc_cAlias + ".nVlServs") != "U"
                THIS.this_nVlServs = TratarNulo(EVALUATE(loc_cAlias + ".nVlServs"), 0)
                IF VARTYPE(THIS.this_nVlServs) != "N"
                    THIS.this_nVlServs = 0
                ENDIF
            ENDIF

            *-- nAliIss: numeric(4,2) - aliquota de ISS usada pelo pai no calculo
            IF TYPE(loc_cAlias + ".nAliIss") != "U"
                THIS.this_nAliIss = TratarNulo(EVALUATE(loc_cAlias + ".nAliIss"), 0)
                IF VARTYPE(THIS.this_nAliIss) != "N"
                    THIS.this_nAliIss = 0
                ENDIF
            ENDIF

            *-- fPags: char(12) - forma de pagamento que o pai le em SigOpFp
            IF TYPE(loc_cAlias + ".fPags") != "U"
                THIS.this_cFPags = LEFT(TratarNulo(EVALUATE(loc_cAlias + ".fPags"), ""), ;
                                        THIS.this_nTamFPags)
            ENDIF

            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Alterna a marcacao da LINHA CORRENTE
    *
    * Reproduz o que o Check1 da Column1 faz no legado:
    *
    *   m.Selecionada = Iif(LocalSacOp.Selecionada = 0, 1, 0)
    *   Select LocalSacOp
    *   Gather Memvar Fields Selecionada
    *   ThisForm.grdOperacoes.Refresh
    *
    * O Gather Memvar sobre UM campo eh exatamente um REPLACE desse campo; o
    * Refresh da grade fica no Form, que eh quem tem o controle visual.
    *
    * Devolve o valor novo (0 ou 1), ou -1 quando nao foi possivel alternar -
    * assim o Form distingue "desmarcou" de "falhou" em vez de ficar inerte.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nAtual, loc_nNovo, loc_uValor
        LOCAL loc_oErro

        loc_nNovo = -1

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto."
            RETURN -1
        ENDIF

        IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o posicionada para marcar."
            RETURN -1
        ENDIF

        IF ISREADONLY(loc_cAlias)
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] est" + CHR(225) + ;
                " somente-leitura e a marca" + CHR(231) + CHR(227) + "o da Opera" + ;
                CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser gravada."
            RETURN -1
        ENDIF

        IF TYPE(loc_cAlias + ".Selecionada") = "U"
            THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o possui a coluna Selecionada."
            RETURN -1
        ENDIF

        loc_cAreaAnterior = ALIAS()

        TRY
            SELECT (loc_cAlias)

            loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
            IF VARTYPE(loc_uValor) = "N"
                loc_nAtual = NVL(loc_uValor, 0)
            ELSE
                loc_nAtual = IIF(NVL(loc_uValor, .F.), 1, 0)
            ENDIF

            loc_nNovo = IIF(loc_nAtual = 0, 1, 0)

            REPLACE Selecionada WITH loc_nNovo IN (loc_cAlias)

            THIS.this_nSelecionada  = loc_nNovo
            THIS.this_cMensagemErro = ""

            THIS.AtualizarTotais(loc_cAlias)
        CATCH TO loc_oErro
            loc_nNovo = -1
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao marcar a Opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN loc_nNovo
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTotais - Reconta a selecao e monta a lista das marcadas
    *
    * Equivale ao Scan que o form pai roda DEPOIS do Ok:
    *
    *   Select LocalSacOp
    *   Scan
    *       If Not llOks And (LocalSacOp.Selecionada = 1) ... llOks = .t.
    *   EndScan
    *
    * O RECNO eh salvo e reposto: SCAN move o ponteiro, e a linha corrente eh a
    * que o usuario esta vendo na grade - perde-la faz a grade "pular" sozinha.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTotais(par_cAliasCursor)
        LOCAL loc_cAlias, loc_cAreaAnterior, loc_nRegistro, loc_nSel, loc_cLista
        LOCAL loc_uValor, loc_nValor, loc_oErro

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         ALLTRIM(par_cAliasCursor), THIS.ObterAliasGrade())

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        loc_cAreaAnterior = ALIAS()
        loc_nSel          = 0
        loc_cLista        = ""

        TRY
            SELECT (loc_cAlias)
            loc_nRegistro = RECNO(loc_cAlias)

            THIS.this_nTotalOperacoes = RECCOUNT(loc_cAlias)

            SCAN
                loc_nValor = 0

                IF TYPE(loc_cAlias + ".Selecionada") != "U"
                    loc_uValor = EVALUATE(loc_cAlias + ".Selecionada")
                    IF VARTYPE(loc_uValor) = "N"
                        loc_nValor = NVL(loc_uValor, 0)
                    ELSE
                        loc_nValor = IIF(NVL(loc_uValor, .F.), 1, 0)
                    ENDIF
                ENDIF

                IF loc_nValor = 1
                    loc_nSel = loc_nSel + 1

                    IF TYPE(loc_cAlias + ".Dopes") != "U"
                        loc_cLista = loc_cLista + ;
                            IIF(EMPTY(loc_cLista), "", ", ") + ;
                            ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Dopes"), ""))
                    ENDIF
                ENDIF
            ENDSCAN

            THIS.this_nTotalSelecionadas = loc_nSel
            THIS.this_cOperacoesMarcadas = loc_cLista

            *-- Repoe a linha que o usuario estava vendo na grade
            IF loc_nRegistro > 0 AND loc_nRegistro <= RECCOUNT(loc_cAlias)
                GO loc_nRegistro IN (loc_cAlias)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Falha ao totalizar a sele" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        IF !EMPTY(loc_cAreaAnterior) AND USED(loc_cAreaAnterior)
            SELECT (loc_cAreaAnterior)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * TemSelecao - .T. quando ha ao menos uma Operacao marcada
    *
    * Eh o llOks do form pai, exposto aqui para que ele nao precise varrer o
    * cursor de novo. CONSULTA apenas: o Ok do legado NAO exige selecao (ele so
    * devolve o Enabled ao pai e libera a tela), portanto o Form nao deve usar
    * este metodo para bloquear o Ok.
    *--------------------------------------------------------------------------
    PROCEDURE TemSelecao(par_cAliasCursor)
        THIS.AtualizarTotais(par_cAliasCursor)

        RETURN (THIS.this_nTotalSelecionadas > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades da linha e os totalizadores
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_nSelecionada = 0
        THIS.this_cDopes       = ""
        THIS.this_nGerOpServs  = 0
        THIS.this_cCodServs    = ""
        THIS.this_nVlServs     = 0
        THIS.this_nAliIss      = 0
        THIS.this_cFPags       = ""

        THIS.this_nTotalOperacoes    = 0
        THIS.this_nTotalSelecionadas = 0
        THIS.this_cOperacoesMarcadas = ""

        THIS.this_cMensagemErro = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identidade da linha corrente
    *
    * SigCdSOp.dopes - a PK fisica da tabela eh cidchaves, que o Select do
    * legado nao traz para o cursor da grade e portanto nao existe aqui.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Fecha apenas o que ESTE BO criou
    *
    * O cursor do pai (LocalSacOp) continua aberto de proposito: o form pai le
    * a selecao depois que o dialogo fecha. Fecha-lo aqui apagaria o resultado
    * da tela inteira.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorTemp)
            USE IN (THIS.this_cCursorTemp)
        ENDIF

        IF USED(THIS.this_cCursorGrade)
            USE IN (THIS.this_cCursorGrade)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
