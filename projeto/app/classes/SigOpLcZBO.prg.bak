*============================================================================
* SigOpLcZBO.prg - Business Object para "Selecao de Localizacao" (SIGOPLCZ)
*
* Form OPERACIONAL (SIGOPLCZ / FormSigOpLcZ): dialogo MODAL chamado por um
* form PAI que ja tem aberto o cursor crTpmMvItn com os itens de um
* movimento (produtos sem localizacao atribuida, ou a atualizar). O dialogo
* NAO consulta o banco: ele agrega esse cursor localmente (Select Distinct
* Cpros/Dpros/Locals), deixa o usuario marcar linhas na grade, escolher UMA
* localizacao (lookup em SigPrLcl) e aplicar em lote - de volta no cursor do
* PAI, via UPDATE crTpmMvItn Set Locals|Localos = <escolhida> Where
* Cpros = <marcado>.
*
* Parametros do legado (Init lParameters pCnx, pEscolha, pOrigem):
*   pCnx      - ThisForm.poDataMgr (gerenciador de conexao Fortyus). NAO
*               tem equivalente aqui: a arquitetura nova usa o handle
*               global gnConnHandle, entao este BO nao guarda property para
*               ele.
*   pEscolha  - Thisform.pcEscolha: modo de abertura ('INSERIR'/'ALTERAR'/
*               'PROCURAR' no padrao Fortyus). Controla o When() dos botoes
*               de marcacao/limpeza/localizar (so habilitados fora de
*               'PROCURAR').
*   pOrigem   - Thisform.pcOrigem: 'ORIGEM' ou outro valor. Decide qual
*               coluna do crTpmMvItn recebe a localizacao no Confirmar:
*               'ORIGEM' grava em Localos, qualquer outro valor grava em
*               Locals.
*
* Cursor de entrada (fornecido pelo form PAI - este BO so o consulta/altera,
* nunca o cria):
*   crTpmMvItn - cursor de itens do movimento, com (ao menos) Cpros, Dpros,
*                Locals e LocalOs. Alias LITERAL do legado: o form pai e os
*                metodos deste BO compartilham a mesma area de trabalho, por
*                isso NAO se renomeia (mesma logica de alias-contrato das
*                regras de FRX/OLE - aqui o "contrato" eh com quem chama a
*                tela, nao com um relatorio).
*
* Cursores de trabalho (criados pelo Init, nas fases seguintes):
*   cursor_4c_Itens        - equivalente ao crItensLoc do legado: Select
*                             Distinct 0 as Marcas, Cpros, Dpros e a coluna
*                             de localizacao atual (Locals ou LocalOs,
*                             conforme this_cOrigem) extraida de
*                             crTpmMvItn Where Not Empty(Cpros). Marcas eh a
*                             flag de selecao (0/1) que a grade edita via
*                             CheckBox.
*   cursor_4c_Selecionados  - equivalente ao csLocals do legado: Cpros c(14)
*                             + Locals c(10), populado pelo Localizar
*                             (linhas marcadas) e aplicado ao crTpmMvItn pelo
*                             Confirmar.
*
* Nao existe tabela propria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server - toda leitura/escrita eh sobre
* os cursores em memoria acima.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*
* Fase 2 - Metodos de dados (sem CRUD de tabela - este BO nao tem tabela
* propria, entao Inserir()/Atualizar()/ExecutarExclusao()/
* ObterChavePrimaria()/RegistrarAuditoria() NAO sao sobrescritos aqui: o
* comportamento padrao herdado de BusinessBase ja eh o correto para esta
* tela, que so le/escreve nos cursores em memoria abaixo):
*   CarregarItens()       - equivalente ao Init/Select Distinct do legado:
*                           (re)monta cursor_4c_Itens a partir de
*                           crTpmMvItn, indexado por Cpros.
*   SelecionarTodos()     - equivalente ao SigOpLcZ.SelTudo.Click.
*   DesmarcarTodos()      - equivalente ao SigOpLcZ.apaga.Click.
*   Localizar()           - equivalente ao cmdAcoes.btnLocalizar.Click:
*                           valida a base escolhida, move os itens
*                           marcados de cursor_4c_Itens para
*                           cursor_4c_Selecionados e limpa a marcacao.
*   Confirmar()           - equivalente ao cntBotoes.btnConfirmar.Click:
*                           aplica cursor_4c_Selecionados de volta em
*                           crTpmMvItn (Localos ou Locals conforme
*                           this_cOrigem).
*   ObterImagemProduto()  - equivalente ao CursorQuery('SigCdPro',...,
*                           'FigJpgs') do grdItens.AfterRowColChange.
*   PrepararCursores()    - equivalente ao "If Used([csLocals]) / Use in
*                           csLocals / Create Cursor csLocals(...)" do Init
*                           legado: derruba e recria
*                           cursor_4c_Selecionados, para que uma reabertura
*                           do dialogo nao herde a selecao do movimento
*                           anterior.
*   CarregarDoCursor()    - le a linha CORRENTE da grade (Cpros, Dpros,
*                           Locals, Marcas) para as properties this_*Atual,
*                           como faz o grdItens.AfterRowColChange legado.
*   LimparLinhaAtual()    - zera essas properties (cursor vazio ou em EOF).
*   PodeLocalizar()       - regra "Empty(Locals) And Not Empty(Marcas)" do
*                           AfterRowColChange: fonte unica do
*                           btnLocalizar.Enabled.
*   PodeEditar()          - regra "InList(pcEscolha,'INSERIR','ALTERAR')"
*                           dos When() legado: fonte unica do Enabled dos
*                           botoes de marcacao/limpeza/localizacao.
*============================================================================

DEFINE CLASS SigOpLcZBO AS BusinessBase

    *==========================================================================
    * PARAMETROS DE ABERTURA (pcEscolha / pcOrigem do legado)
    *==========================================================================

    *-- Modo de abertura: 'INSERIR' / 'ALTERAR' / 'PROCURAR'. Fora de
    *-- 'PROCURAR' os botoes de marcar/limpar/localizar ficam habilitados
    *-- (mesmo teste do When legado: InList(pcEscolha,'INSERIR','ALTERAR')).
    this_cEscolha = ""

    *-- 'ORIGEM' ou outro valor. Decide, no Confirmar, se a localizacao
    *-- escolhida grava em crTpmMvItn.Localos (ORIGEM) ou em
    *-- crTpmMvItn.Locals (qualquer outro valor).
    this_cOrigem = ""

    *==========================================================================
    * CURSOR DE ENTRADA (fornecido pelo form PAI)
    *==========================================================================

    *-- Alias LITERAL compartilhado com quem abriu o dialogo - nao se
    *-- renomeia para o padrao cursor_4c_* porque este BO nao o cria, so
    *-- consulta/atualiza a area de trabalho que o chamador deixou aberta.
    this_cCursorOrigem = "crTpmMvItn"

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Equivalente ao crItensLoc do legado: grade de selecao (Marcas, Cpros,
    *-- Dpros, Locals/LocalOs conforme this_cOrigem)
    this_cCursorItens = "cursor_4c_Itens"

    *-- Equivalente ao csLocals do legado: itens marcados + localizacao
    *-- escolhida, acumulados pelo Localizar e aplicados pelo Confirmar
    this_cCursorSelecionados = "cursor_4c_Selecionados"

    *==========================================================================
    * LOCALIZACAO ESCOLHIDA (getBase/getDBase do legado)
    *==========================================================================

    *-- Codigo da base de localizacao escolhida (lookup em SigPrLcl.Codigos)
    this_cBaseLocalizacao = ""

    *-- Descricao da base de localizacao escolhida (SigPrLcl.Descricaos)
    this_cDescBaseLocalizacao = ""

    *==========================================================================
    * LINHA CORRENTE DA GRADE (crItensLoc do legado)
    *
    * O grdItens.AfterRowColChange legado le TRES campos da linha corrente de
    * crItensLoc: Cpros (para a consulta da imagem do produto) e Locals +
    * Marcas (para decidir se o botao Localizar fica habilitado). Estas
    * properties sao o destino dessa leitura, feita por CarregarDoCursor().
    *==========================================================================

    *-- Codigo do produto da linha corrente (crItensLoc.Cpros, char(14))
    this_cCprosAtual = ""

    *-- Descricao do produto da linha corrente (crItensLoc.Dpros)
    this_cDprosAtual = ""

    *-- Localizacao JA atribuida ao produto da linha corrente
    *-- (crItensLoc.Locals, char(10)); fica vazia enquanto o item nao foi
    *-- localizado
    this_cLocalAtual = ""

    *-- Flag de selecao da linha corrente (crItensLoc.Marcas): 0 = nao
    *-- marcada, 1 = marcada. NUMERICA, igual ao "0 as Marcas" do Select
    *-- Distinct legado: comparar com 0/1, nunca com .F./.T.
    this_nMarcasAtual = 0

    *--------------------------------------------------------------------------
    * Init - Recebe o modo de abertura e a origem, vindos do form PAI
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEscolha, par_cOrigem)
        * Sem tabela propria: este BO nao faz CRUD contra o SQL Server
        DODEFAULT("")

        IF VARTYPE(par_cEscolha) = "C"
            THIS.this_cEscolha = par_cEscolha
        ENDIF

        IF VARTYPE(par_cOrigem) = "C"
            THIS.this_cOrigem = par_cOrigem
        ENDIF

        *-- O Init legado cria csLocals (derrubando um remanescente) antes
        *-- de qualquer coisa. Fazer isso aqui garante que
        *-- cursor_4c_Selecionados exista desde a construcao, sem depender
        *-- de o Form lembrar de chamar PrepararCursores().
        THIS.PrepararCursores()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - (Re)monta cursor_4c_Itens a partir de crTpmMvItn.
    * Equivalente ao trecho do Init legado:
    *   Select Distinct 0 as Marcas, Cpros, Dpros,
    *     Iif(pcOrigem='ORIGEM', LocalOs, Locals) as Locals
    *     From crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc
    * seguido do Index on Cpros Tag Cpros do MontaGrade (a grade em si -
    * RecordSource/ControlSource/Refresh - fica no Form, que a reconfigura
    * apos chamar este metodo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorOrigem)
            THIS.this_cMensagemErro = "Cursor de itens do movimento (" + ;
                THIS.this_cCursorOrigem + ") n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        SELECT DISTINCT 0 AS Marcas, Cpros, Dpros, ;
                IIF(THIS.this_cOrigem == "ORIGEM", LocalOs, Locals) AS Locals ;
            FROM (THIS.this_cCursorOrigem) ;
            WHERE !EMPTY(Cpros) ;
            INTO CURSOR (THIS.this_cCursorItens) READWRITE

        IF USED(THIS.this_cCursorItens)
            SELECT (THIS.this_cCursorItens)
            INDEX ON Cpros TAG Cpros
            GO TOP
            loc_lSucesso = .T.
        ELSE
            THIS.this_cMensagemErro = "Falha ao montar a grade de itens."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria (zerado) o cursor de itens selecionados.
    * Equivalente ao trecho do Init legado:
    *   If Used([csLocals]) / Use in csLocals / EndIf
    *   Create Cursor csLocals(Cpros c(14), Locals c(10))
    * O legado DERRUBA um csLocals remanescente antes de recriar, e isso eh
    * regra e nao detalhe: este dialogo eh reaberto a cada movimento, e um
    * cursor sobrevivente de uma abertura anterior faria o Confirmar()
    * aplicar localizacoes de OUTRO movimento, sem erro e sem aviso. Por isso
    * a criacao mora aqui (o Form chama na abertura) e nao so embutida no
    * Localizar().
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_nAreaAnterior

        *-- CREATE CURSOR SELECIONA o cursor criado. Como este metodo roda
        *-- no Init (construcao do BO), deixar a area trocada mudaria o
        *-- cursor corrente POR BAIXO do form PAI, que tem crTpmMvItn
        *-- selecionado. O legado contorna com um "Select crTpmMvItn"
        *-- logo depois; aqui salva e restaura, que nao depende de quem chama.
        loc_nAreaAnterior = SELECT()

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))

        SELECT (loc_nAreaAnterior)

        THIS.this_cBaseLocalizacao     = ""
        THIS.this_cDescBaseLocalizacao = ""

        THIS.LimparLinhaAtual()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparLinhaAtual - Zera as properties da linha corrente da grade.
    * Usado pelo PrepararCursores e pelo CarregarDoCursor quando o cursor
    * esta vazio ou em EOF (nenhuma linha corrente para ler).
    *--------------------------------------------------------------------------
    PROCEDURE LimparLinhaAtual()
        THIS.this_cCprosAtual  = ""
        THIS.this_cDprosAtual  = ""
        THIS.this_cLocalAtual  = ""
        THIS.this_nMarcasAtual = 0

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a linha CORRENTE do cursor da grade de itens para
    * as properties this_*Atual.
    * Equivalente as leituras de crItensLoc feitas pelo
    * SigOpLcZ.grdItens.AfterRowColChange:
    *   crItensLoc.Cpros  -> consulta da imagem (ObterImagemProduto)
    *   crItensLoc.Locals -> regra de habilitacao do Localizar
    *   crItensLoc.Marcas -> regra de habilitacao do Localizar
    * Chamado SEM argumento, le o proprio cursor_4c_Itens
    * (this_cCursorItens), que eh o uso normal a partir do
    * AfterRowColChange da grade.
    *
    * Guarda de EOF/BOF obrigatoria: o cursor fica vazio quando todos os
    * itens ja foram localizados (o Localizar() apaga as linhas marcadas), e
    * ler campo em EOF devolveria o valor da ULTIMA linha apagada,
    * reabilitando o Localizar para um produto que nao esta mais na grade.
    *
    * A area de trabalho do chamador eh salva e restaurada (o lnOldSel do
    * legado): este metodo eh um LEITOR e nao deve deixar o cursor da grade
    * selecionado por efeito colateral.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_nAreaAnterior, loc_lSucesso

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND ;
            !EMPTY(par_cAliasCursor), par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.LimparLinhaAtual()
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF() OR RECCOUNT() = 0
                THIS.LimparLinhaAtual()
            ELSE
                THIS.this_cCprosAtual  = ALLTRIM(TratarNulo(Cpros, ""))
                THIS.this_cDprosAtual  = ALLTRIM(TratarNulo(Dpros, ""))
                THIS.this_cLocalAtual  = ALLTRIM(TratarNulo(Locals, ""))
                THIS.this_nMarcasAtual = TratarNulo(Marcas, 0)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        SELECT (loc_nAreaAnterior)

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeLocalizar - Regra de habilitacao do botao Localizar para a linha
    * corrente da grade.
    * Equivalente ao final do SigOpLcZ.grdItens.AfterRowColChange:
    *   If Empty(crItensLoc.Locals) And Not Empty(crItensLoc.Marcas)
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .T.
    *   Else
    *       ThisForm.cmdAcoes.btnLocalizar.Enabled = .F.
    *   EndIf
    * FONTE UNICA: quem calcula eh o BO e o Form so espelha em .Enabled -
    * reescrever a condicao no Form faria as duas divergirem.
    * Pressupoe CarregarDoCursor() ja chamado para a linha corrente.
    *--------------------------------------------------------------------------
    PROCEDURE PodeLocalizar()
        RETURN EMPTY(THIS.this_cLocalAtual) AND THIS.this_nMarcasAtual <> 0
    ENDPROC

    *--------------------------------------------------------------------------
    * PodeEditar - O modo de abertura permite marcar/limpar/localizar?
    * Equivalente ao When() que o legado repete em grdItens.Column3.Check1,
    * nos dois CommandGroup cmdAcoes, em apaga e em SelTudo:
    *   Return(InList(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
    * FONTE UNICA dessa regra: os controles do Form espelham este metodo em
    * vez de repetir o INLIST.
    * O UPPER/ALLTRIM eh defensivo - this_cEscolha pode chegar de um campo
    * char padded do chamador, e SET EXACT ON (config.prg) faria o INLIST
    * falhar com o padding.
    *--------------------------------------------------------------------------
    PROCEDURE PodeEditar()
        RETURN INLIST(UPPER(ALLTRIM(NVL(THIS.this_cEscolha, ""))), ;
            "INSERIR", "ALTERAR")
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTodos - Marca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.SelTudo.Click
    *   (Replace All crItensLoc.Marcas with 1).
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 1
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas de cursor_4c_Itens.
    * Equivalente ao SigOpLcZ.apaga.Click
    *   (Replace All crItensLoc.Marcas with 0).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF !USED(THIS.this_cCursorItens)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH 0
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Localizar - Move os itens marcados de cursor_4c_Itens para
    * cursor_4c_Selecionados, usando a base escolhida (this_cBaseLocalizacao).
    * Equivalente ao SigOpLcZ.cmdAcoes.btnLocalizar.Click:
    *   valida getBase.Value; Scan For Marcas <> 0 em crItensLoc, Append
    *   Blank em csLocals (Cpros, Locals = base escolhida); Delete From
    *   crItensLoc Where Marcas <> 0; limpa getBase/getDBase.
    *--------------------------------------------------------------------------
    PROCEDURE Localizar()
        LOCAL loc_cCpros

        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(NVL(THIS.this_cBaseLocalizacao, "")))
            THIS.this_cMensagemErro = "Informar a Base da Localiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "A grade de itens n" + CHR(227) + "o est" + CHR(225) + " carregada."
            RETURN .F.
        ENDIF

        IF !USED(THIS.this_cCursorSelecionados)
            CREATE CURSOR (THIS.this_cCursorSelecionados) (Cpros C(14), Locals C(10))
        ENDIF

        SELECT (THIS.this_cCursorItens)
        GO TOP
        SCAN FOR Marcas <> 0
            loc_cCpros = Cpros

            SELECT (THIS.this_cCursorSelecionados)
            APPEND BLANK
            REPLACE Cpros  WITH loc_cCpros
            REPLACE Locals WITH THIS.this_cBaseLocalizacao

            SELECT (THIS.this_cCursorItens)
        ENDSCAN

        SELECT (THIS.this_cCursorItens)
        DELETE FOR Marcas <> 0
        GO TOP

        THIS.this_cBaseLocalizacao = ""
        THIS.this_cDescBaseLocalizacao = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Confirmar - Aplica cursor_4c_Selecionados de volta em crTpmMvItn.
    * Equivalente ao SigOpLcZ.cntBotoes.btnConfirmar.Click:
    *   Scan em csLocals; Update crTpmMvItn Set Localos|Locals =
    *   csLocals.Locals Where Cpros = csLocals.Cpros, conforme this_cOrigem.
    * Sem linhas em cursor_4c_Selecionados (nenhum item foi Localizar()ado),
    * eh um no-op valido - o legado tambem nao faz nada no Scan vazio.
    *--------------------------------------------------------------------------
    PROCEDURE Confirmar()
        LOCAL loc_cCpros, loc_cLocal, loc_lOrigem

        IF !USED(THIS.this_cCursorSelecionados)
            RETURN .T.
        ENDIF

        loc_lOrigem = (THIS.this_cOrigem == "ORIGEM")

        SELECT (THIS.this_cCursorSelecionados)
        GO TOP
        SCAN
            loc_cCpros = Cpros
            loc_cLocal = Locals

            SELECT (THIS.this_cCursorOrigem)
            IF loc_lOrigem
                REPLACE ALL LocalOs WITH loc_cLocal FOR Cpros = loc_cCpros
            ELSE
                REPLACE ALL Locals WITH loc_cLocal FOR Cpros = loc_cCpros
            ENDIF

            SELECT (THIS.this_cCursorSelecionados)
        ENDSCAN

        SELECT (THIS.this_cCursorOrigem)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Devolve o conteudo de SigCdPro.FigJpgs (base64) do
    * produto informado, ou .NULL. se nao houver imagem.
    * Equivalente ao
    *   ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *     crItensLoc.Cpros,'FigJpgs')
    * do SigOpLcZ.grdItens.AfterRowColChange. A decodificacao do base64 e a
    * gravacao do arquivo .jpg temporario (StrToFile) ficam no Form, que eh
    * quem conhece o controle Image que vai exibi-la.
    *--------------------------------------------------------------------------
    PROCEDURE ObterImagemProduto(par_cCpros)
        LOCAL loc_cCursorTemp, loc_cSQL, loc_xRetorno

        loc_xRetorno = .NULL.

        IF EMPTY(ALLTRIM(NVL(par_cCpros, "")))
            RETURN loc_xRetorno
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_xRetorno
        ENDIF

        loc_cCursorTemp = "cursor_4c_ImgProdTmp"
        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + ;
            EscaparSQL(ALLTRIM(par_cCpros))

        IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp) > 0
            IF USED(loc_cCursorTemp) AND RECCOUNT(loc_cCursorTemp) > 0
                IF !ISNULL(EVALUATE(loc_cCursorTemp + ".FigJpgs")) AND ;
                        !EMPTY(EVALUATE(loc_cCursorTemp + ".FigJpgs"))
                    loc_xRetorno = EVALUATE(loc_cCursorTemp + ".FigJpgs")
                ENDIF
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Erro ao buscar imagem do produto: " + CapturarErroSQL()
        ENDIF

        IF USED(loc_cCursorTemp)
            USE IN (loc_cCursorTemp)
        ENDIF

        RETURN loc_xRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha os cursores de trabalho criados por este BO.
    * Equivalente ao SigOpLcZ.Release: Use In crItensLoc / Use In csLocals.
    * (cursor_4c_Itens / cursor_4c_Selecionados). crTpmMvItn eh do form PAI e
    * NAO eh fechado aqui.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF

        IF USED(THIS.this_cCursorSelecionados)
            USE IN (THIS.this_cCursorSelecionados)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
