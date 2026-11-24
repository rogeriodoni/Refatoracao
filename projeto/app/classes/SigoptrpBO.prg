*==============================================================================
* SIGOPTRPBO.PRG
* Business Object do dialogo "Transportadoras" (SIGOPTRP), aberto pelo form
* pai de Cadastro de Operacoes (SigCdOpe) via
* "Do Form Sigoptrp With ThisForm, nDataSession", NAO acessivel direto pelo
* menu.
*
* Tabela persistida : SigOpTrp  (transportadoras habilitadas para a operacao)
* Chave Real (PK)    : cidchaves - gerada com fUniqueIds() ao inserir (regra
*                       #22 do CLAUDE.md - NUNCA string vazia, senao a 2a
*                       linha colide no indice unico)
* Colunas da tabela  : dopes, itras, cidchaves (lista tirada literalmente do
*                       "Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves)
*                       Values (...)" do legado - ver NOTA DE SCHEMA abaixo)
*
* NOTA DE SCHEMA (regra #14 do CLAUDE.md): a tabela SigOpTrp NAO aparece em
* docs/schema.sql (conferido com Get-Content -Raw -Encoding Unicode, que
* respeita o BOM UTF-16 - zero ocorrencias de "OpTrp" no arquivo inteiro,
* contra SigOpTrf/SigPrTrp/SigIvTrp/SIGFITRP que existem). O legado
* (Sigoptrp_form_codigo_fonte.txt) usa o nome "SigOpTrp" de forma consistente
* em TRES pontos (AddCursor, Insert Into CrSigOpTrp, Delete From SigOpTrp) -
* nao ha divergencia de grafia dentro do proprio legado, nem tabela com nome
* parecido que sugira erro de digitacao do migrador. Por isso o nome foi
* mantido EXATO, igual ao legado (PILAR 2) - a ausencia no snapshot do
* schema e uma divergencia de BANCO/ambiente (tabela pode ter sido criada
* depois do snapshot), nao um erro de migracao a corrigir trocando o nome.
*
* NATUREZA DESTE DIALOGO (lido do legado, Sigoptrp_form_codigo_fonte.txt):
*   O Init recebe (poForm, pnDataSes): poForm e o form PAI (SigCdOpe, lista
*   de operacoes) e pnDataSes e a DataSession do pai - o dialogo faz
*   "Set DataSession to pnDataSes" para conseguir ler crSigCdOpe (cursor do
*   pai) diretamente, antes de abrir a propria DataSession = 2 privada
*   (mesmo padrao de SigOpTrf/SigOpTop - FormSigOpTrf usa DataSession = 1
*   compartilhada no migrado, em vez de trocar de sessao manualmente).
*
*   O Caption e montado como:
*     'Transportadoras ' + AllTrim(crSigCdOpe.Dopes)
*   e replicado em cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
*   Uma unica grade (GradeOpe, 2 colunas) <- xOpe (Dopes C(20), Itras C(10),
*   Razaos C(40)) - cursor LOCAL editavel, carregado no Init a partir das
*   linhas ja gravadas em SigOpTrp para esta operacao (JOIN com SigPrTrp
*   para resolver a descricao):
*     lcSql = "Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
*              Where a.Dopes = '<crSigCdOpe.Dopes>' And a.Itras = b.Itras"
*   Column1.Text1 (Itras) tem Valid com lookup fwbuscaext em SigPrTrp pela
*   chave Itras - achando, preenche Razaos (xOpe.Razaos); vazio, limpa o
*   campo. Column2.Text1 (Razaos) tem When = Return .F. - e SOMENTE EXIBICAO,
*   nunca editado digitando, NUNCA persistido em SigOpTrp (so aparece no
*   SELECT acima via JOIN) - mesmo papel do this_cDpros em SigOpTrfBO.
*
*   cmdInserir: Insert Into xOpe (Itras) Values (Space(10)) - acrescenta
*   linha em branco na grade e foca a coluna do codigo; marca GravaDados.
*
*   cmdExcluir: apaga a linha corrente de xOpe (Delete + Skip); marca
*   GravaDados.
*
*   cmdSair (Caption "Confirmar"): SE GravaDados -> valida que nao ha
*   Itras duplicado entre as linhas nao-vazias de xOpe (Group By Itras
*   Having Sum(1) > 1 -> aborta com MessageBox se achar); senao, apaga TODAS
*   as linhas de SigOpTrp desta operacao (Delete From SigOpTrp Where
*   dopes = '<crSigCdOpe.Dopes>') e regrava uma linha por xOpe.Itras
*   nao-vazio (Insert Into CrSigOpTrp (Dopes, Itras, cIdChaves) Values
*   (crSigCdOpe.Dopes, xOpe.Itras, fUniqueIds())), via
*   poDatamgr.UpDate('CrSigOpTrp') + Commit() dentro de TRY/CATCH com
*   RollBack no erro - mesmo padrao "apaga tudo da operacao e reinsere" do
*   SigOpTrfBO (regra #22 do CLAUDE.md - cidchaves SEMPRE fUniqueIds(),
*   nunca string vazia). Confirmar reabilita o form pai e libera o dialogo:
*     Thisform.ParentForm.Enabled = .T.
*     ThisForm.Release
*
*   Cancela: so reabilita o form pai e libera o dialogo, SEM gravar nada
*   (equivalente ao Cancelar do SigOpTrfBO - nenhuma chamada ao BO).
*
*   Por isso este BO sobrescreve Inserir() (fase seguinte) operando sobre
*   UMA linha por vez (identificada por cidchaves), que o fluxo de gravacao
*   em lote do Confirmar (fases seguintes) vai chamar em loop, uma vez por
*   linha nao-vazia de xOpe, dentro do "apaga tudo e reinsere" do legado.
*   NAO sobrescreve Atualizar() nem ExecutarExclusao(): nao ha alteracao nem
*   exclusao unitaria no legado - a remocao de uma linha e so o efeito
*   colateral de ela nao ser reinserida no lote seguinte, igual ao
*   SigOpTrfBO.
*==============================================================================

DEFINE CLASS SigoptrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdOpe (crSigCdOpe no legado, cursor do form pai)
    * Operacao cujas transportadoras habilitadas estao sendo editadas.
    * this_cDopes e usado tanto como filtro da carga quanto como o valor da
    * coluna "dopes" de cada linha gravada em SigOpTrp (as duas coisas sao
    * sempre o mesmo codigo, por desenho deste dialogo - mesmo papel do
    * SigOpTrfBO).
    *--------------------------------------------------------------------------
    this_cDopes          = ""  && SigCdOpe.Dopes CHAR(20) - operacao (contexto, vindo do form pai)
    this_cTituloDialogo  = ""  && Caption montado: "Transportadoras " + this_cDopes

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DA GRADE (xOpe / SigOpTrp + SigPrTrp)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""  && cidchaves - PK, gerada com fUniqueIds() ao inserir
    this_cItras     = ""  && itras  CHAR(10) - codigo da transportadora (SigPrTrp.Itras)
    this_cRazaos    = ""  && razaos CHAR(40) - descricao da transportadora (SigPrTrp.Razaos) - SOMENTE EXIBICAO, NAO persistida em SigOpTrp

    *--------------------------------------------------------------------------
    * CURSOR DE TRABALHO - nome fixo, populado pelo BO nas fases seguintes.
    * Nunca e SQLEXEC direto no cursor ligado ao Grid (regra do CLAUDE.md
    * sobre SQLEXEC derrubar ColumnCount de Grid) - carga via cursor
    * temporario + ZAP/APPEND FROM DBF(), mesmo padrao do SigOpTrfBO.
    *--------------------------------------------------------------------------
    this_cCursorItens = "cursor_4c_Itens"  && xOpe no legado - Dopes C(20), Itras C(10), Razaos C(40)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_lDadosAlterados = .F.  && ThisForm.GravaDados no legado - .T. quando algo foi incluido/excluido e precisa regravar ao Confirmar
    this_nTotalItens      = 0   && RECCOUNT de this_cCursorItens apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * this_cTabela/this_cCampoChave apontam para a tabela REALMENTE gravada
    * por este dialogo (SigOpTrp) - ver NOTA DE SCHEMA no cabecalho do
    * arquivo sobre a ausencia dela em docs/schema.sql.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpTrp"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cDopes         = ""
            THIS.this_cTituloDialogo = ""

            THIS.this_cCidChaves = ""
            THIS.this_cItras     = ""
            THIS.this_cRazaos    = ""

            THIS.this_lDadosAlterados = .F.
            THIS.this_nTotalItens     = 0

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da linha de SigOpTrp (cidchaves).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dopes/itras/razaos da linha corrente de um
    * alias no formato de this_cCursorItens (xOpe no legado - Dopes C(20),
    * Itras C(10), Razaos C(40)). Razaos e SOMENTE EXIBICAO (resolvida via
    * JOIN com SigPrTrp em CarregarItens), nunca persistida em SigOpTrp - ver
    * cabecalho do arquivo.
    *
    * this_cCidChaves e SEMPRE zerado aqui: xOpe nao tem essa coluna (o
    * legado regrava cidchaves do ZERO com fUniqueIds() a cada Confirmar,
    * para TODAS as linhas - nunca preserva a PK antiga, mesmo quando a
    * linha ja existia). Quem for persistir esta linha (Inserir, fase
    * seguinte) gera a PK nova sozinho.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cDopes     = TratarNulo(dopes, "")
        THIS.this_cItras     = TratarNulo(itras, "")
        THIS.this_cRazaos    = TratarNulo(razaos, "")
        THIS.this_cCidChaves = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma transportadora habilitada em SigOpTrp.
    * cidchaves (PK real, regra #22 do CLAUDE.md) e gerado com fUniqueIds()
    * quando ainda nao foi atribuido - NUNCA string vazia, senao a 2a linha
    * do lote colide no indice unico. O fluxo de gravacao em lote do
    * Confirmar (PersistirItens, fase seguinte) zera this_cCidChaves antes
    * de chamar Inserir() para cada linha nao-vazia de xOpe, reproduzindo o
    * "Zap + Scan ... Insert ... fUniqueIds()" do legado - cidchaves NUNCA e
    * reaproveitado de uma gravacao anterior.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigOpTrp (cidchaves, dopes, itras)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cItras) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir transportadora:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ApagarItensDaOperacao - apaga TODAS as transportadoras ja gravadas em
    * SigOpTrp para a operacao corrente (this_cDopes). Equivale ao
    * "Select CrSigOpTrp / Zap" do cmdSair.Click legado (a view CrSigOpTrp e
    * o AddCursor sem filtro em SigOpTrp - mas o DELETE aqui, ao contrario do
    * legado, filtra explicitamente por dopes, porque este BO fala com o SQL
    * Server direto, sem a AddCursor/UpDate/Commit do poDatamgr).
    *
    * Primitiva do "apaga tudo e regrava" que o Confirmar faz em lote
    * (FormSigoptrp.PersistirItens, fase seguinte) ANTES de reinserir uma
    * linha por item nao-vazio de xOpe. O legado NAO tem exclusao unitaria
    * de item (cmdExcluir so apaga da grade local xOpe, nunca de SigOpTrp
    * direto), e por isso este BO nao sobrescreve ExecutarExclusao() -
    * Excluir() por cidchaves nao serviria aqui, porque o cidchaves exibido
    * na grade nunca foi persistido (ver CarregarDoCursor).
    *
    * Esta no BO, e nao no Form, porque eh SQL (PILAR 3 - arquitetura em
    * camadas): o Form orquestra o lote, o BO fala com o banco.
    *
    * A auditoria de um DELETE em LOTE nao tem uma PK unica para registrar,
    * entao a chave logada eh o codigo da OPERACAO - que eh o que identifica
    * o conjunto afetado. this_cCidChaves eh preservado e reposto: ele
    * pertence a linha corrente, nao a este comando.
    *
    * EscaparSQL(this_cDopes) com o valor ALLTRIM'd eh a mesma forma usada
    * em CarregarItens: dopes eh CHAR(20) e o SQL Server compara CHAR com
    * blank-padding ANSI, entao o WHERE casa com o valor gravado (ALLTRIM na
    * chave INTEIRA eh inofensivo - regra #42 proibe ALLTRIM nas PARTES de
    * chave concatenada, que nao eh o caso).
    *
    * O RETURN de guarda fica FORA do TRY e o RETURN final eh unico
    * (regra #1).
    *
    * Metodo PUBLIC: chamado pelo Form (PersistirItens) e pelo harness de
    * teste - metodo que o form chama de fora NUNCA pode ser PROTECTED
    * (regra #51).
    *--------------------------------------------------------------------------
    PROCEDURE ApagarItensDaOperacao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveAnterior, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigOpTrp" + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                *-- Auditoria do lote pela operacao (ver cabecalho do metodo)
                loc_cChaveAnterior   = THIS.this_cCidChaves
                THIS.this_cCidChaves = ALLTRIM(THIS.this_cDopes)
                THIS.RegistrarAuditoria("DELETE")
                THIS.this_cCidChaves = loc_cChaveAnterior

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao apagar as transportadoras:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao apagar as transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FecharCursoresTrabalho - fecha o cursor de trabalho (regra #52 -
    * TABLEREVERT so quando ha buffering, senao dispara o erro 1586).
    * Chamado no INICIO de CarregarItens (reentrancia - este dialogo pode
    * ser aberto mais de uma vez na mesma sessao do processo) e pelo
    * Destroy do Form (teardown final).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresTrabalho()
        IF VARTYPE(THIS.this_cCursorItens) = "C" AND !EMPTY(THIS.this_cCursorItens) ;
                AND USED(THIS.this_cCursorItens)
            IF CURSORGETPROP("Buffering", THIS.this_cCursorItens) > 1
                TABLEREVERT(.T., THIS.this_cCursorItens)
            ENDIF
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - carga inicial do dialogo (trecho principal do Init
    * legado): popula this_cCursorItens (xOpe) a partir das transportadoras
    * ja habilitadas para a operacao corrente, resolvendo a descricao via
    * JOIN com SigPrTrp.
    *
    *   Legado (Init):
    *     lcSql = [Select a.*, b.Razaos From SigOpTrp a, SigPrTrp b
    *              Where a.Dopes = ']+CrSigCdOpe.Dopes+[' And a.Itras = b.Itras]
    *     ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
    *     Select CsSelecao
    *     Scan
    *         Scatter Memvar
    *         Select xOpe
    *         Append Blank
    *         Gather Memvar
    *     EndScan
    *
    * O JOIN (a.Itras = b.Itras, sem OUTER) e DE PROPOSITO: so entra na
    * grade transportadora que EXISTE em SigPrTrp - mesma regra que o Valid
    * do Column1.Text1 aplica ao digitar (fwbuscaext em SigPrTrp). xOpe nao
    * tem coluna cidchaves (ver CarregarDoCursor) porque o legado nunca
    * preserva a PK antiga ao regravar.
    *
    * FecharCursoresTrabalho() no INICIO garante reentrancia - o CREATE
    * CURSOR abaixo estouraria "Cursor ja existe" se this_cCursorItens ja
    * estivesse aberto de uma chamada anterior.
    *
    * Metodo PUBLIC: chamado pelo Form (CarregarLista, fase seguinte) e pelo
    * harness de teste.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cAliasTemp, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cDopes, "")))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        TRY
            THIS.FecharCursoresTrabalho()

            loc_cAliasTemp = "cursor_4c_ItensTemp"

            loc_cSQL = "SELECT a.dopes, a.itras, b.razaos" + ;
                       " FROM SigOpTrp a, SigPrTrp b" + ;
                       " WHERE a.dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND a.itras = b.itras"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTemp)

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao consultar transportadoras:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ELSE
                *-- xOpe: cursor LOCAL editavel (Insert/Delete direto da
                *-- grade, nunca SQLEXEC nele - regra do CLAUDE.md sobre
                *-- SQLEXEC derrubar Grid.ColumnCount)
                CREATE CURSOR (THIS.this_cCursorItens) (Dopes C(20), Itras C(10), Razaos C(40))
                INDEX ON Dopes TAG Dopes
                SET ORDER TO

                IF USED(loc_cAliasTemp)
                    SELECT (loc_cAliasTemp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorItens) (Dopes, Itras, Razaos) ;
                            VALUES (TratarNulo(dopes, ""), TratarNulo(itras, ""), TratarNulo(razaos, ""))
                    ENDSCAN
                    USE IN (loc_cAliasTemp)
                ENDIF

                SELECT (THIS.this_cCursorItens)
                SET ORDER TO
                GO TOP

                THIS.this_nTotalItens = RECCOUNT(THIS.this_cCursorItens)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar transportadoras:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
