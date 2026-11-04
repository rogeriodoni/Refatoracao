*============================================================================
* sigopclgBO.prg - Business Object para Consulta do Log (SigOpLog)
*
* Tabela principal : SigOpLog (PK: cidchaves char(20))
* Form OPERACIONAL de consulta - o legado SIGOPCLG nao grava em tabela
* nenhuma: o PROCEDURE Processamento monta um SELECT dinamico conforme os
* filtros preenchidos e exibe o resultado na Page "Resultado".
*
* Lookups usados pelo form (nao persistidos nesta entidade):
*   GetPrg.Valid     -> SigCdPrg.Programas (lista de programas)
*   GetUserSis.Valid -> SigCdUsu.Usuarios  (usuario do sistema)
*
* Herda de: BusinessBase
* Fase 1: propriedades de filtro + Init + BuscarLog
* Fase 2: CarregarDoCursor (TODAS as colunas de SigOpLog), ObterChavePrimaria,
*         DescreverOperacao, LimparRegistro, LimparDados e BuscarProgramas
*============================================================================

DEFINE CLASS sigopclgBO AS BusinessBase

    *==========================================================================
    * Propriedades de filtro (espelham os campos da Page "Dados" do legado)
    *==========================================================================
    this_cUserRede = ""    && char(20) - Usuario de Rede (filtro SigOpLog.Usuaredes =)
    this_dDtIni    = {}    && date     - Periodo: data inicial (filtro SigOpLog.Datars >=)
    this_dDtFin    = {}    && date     - Periodo: data final (filtro SigOpLog.Datars <=)
    this_cHrIni    = ""    && char(4)  - Horario de Acesso inicial, HHMM (Format "R" + InputMask 99:99)
    this_cHrFin    = ""    && char(4)  - Horario de Acesso final, HHMM (Format "R" + InputMask 99:99)
    this_cPrg      = ""    && char(20) - Programa (filtro SigOpLog.Progs =; lookup SigCdPrg.Programas)
    this_cOperacao = ""    && char(20) - Operacao: "Liberacao"/"Entrada"/"Saida"/"Transacao" (filtro SigOpLog.Opers)
    this_cUserSis  = ""    && char(20) - Usuario do Sistema (filtro SigOpLog.Usuasis =; lookup SigCdUsu.Usuarios)
    this_cParam    = ""    && char(10) - Parametros (filtro SigOpLog.Parametros LIKE "valor%")
    this_cTrans    = ""    && char(100) - Transacao (filtro SigOpLog.Transacaos LIKE "valor%")

    *==========================================================================
    * Resultado da consulta (grid da Page "Resultado")
    *==========================================================================
    this_cCursorLog       = "cursor_4c_Log"        && Alias do cursor com o resultado da pesquisa
    this_cCursorProgramas = "cursor_4c_Programas"  && Alias do cursor do lookup de Programas (SigCdPrg)
    this_nQtdeLog         = 0                      && Quantidade de linhas retornadas pela ultima pesquisa

    *==========================================================================
    * Registro corrente do Log - TODAS as colunas de SigOpLog mais a descricao
    * calculada cOpers. Preenchidas por CarregarDoCursor() a partir da linha
    * corrente do cursor do grid (o legado usa o proprio cursor como
    * ControlSource das 7 colunas do GrdLog e do fwget1 da Transacao; estas
    * propriedades existem para o form ler o registro selecionado sem precisar
    * tocar o cursor direto).
    *
    * Os nomes espelham as colunas do schema (docs/schema.sql):
    *   usuaredes  char(20)  NOT NULL | datars     datetime NULL  | horas    char(8)  NOT NULL
    *   progs      char(20)  NOT NULL | opers      char(1)  NOT NULL | usuasis char(20) NOT NULL
    *   parametros char(10)  NOT NULL | transacaos char(100) NOT NULL| cversaos char(70) NOT NULL
    *   cidchaves  char(20)  NOT NULL | copias     bit      NOT NULL
    *==========================================================================
    this_cUsuaRedes    = ""    && usuaredes  - Usuario de rede que gerou o registro
    this_dDatars       = {}    && datars     - Data do acesso (a hora fica em this_cHoras)
    this_cHoras        = ""    && horas      - Hora do acesso, formato HH:MM:SS
    this_cProgs        = ""    && progs      - Programa acessado
    this_cOpers        = ""    && opers      - Codigo da operacao: E, S, L ou outro
    this_cUsuaSis      = ""    && usuasis    - Usuario do sistema
    this_cParametros   = ""    && parametros - Parametros da chamada
    this_cTransacaos   = ""    && transacaos - Transacao registrada
    this_cCVersaos     = ""    && cversaos   - Versao do executavel que gravou o log
    this_cCidChaves    = ""    && cidchaves  - Chave primaria do registro
    this_nCopias       = 0     && copias     - Coluna bit: 1 ou 0 (bit chega Logico ou Numerico conforme o driver)
    this_cOperacaoDesc = ""    && cOpers     - Descricao da operacao (Entrada/Saida/Liberacao/Transacao)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpLog"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarLog - Monta a consulta dinamica do Log de Acessos conforme os
    * filtros preenchidos pelo usuario (equivalente ao PROCEDURE Processamento
    * do legado SIGOPCLG) e popula THIS.this_cCursorLog ("cursor_4c_Log").
    *
    * Cada filtro so entra no WHERE se a propriedade correspondente estiver
    * preenchida (mesma logica condicional do legado, transcrita literalmente -
    * inclusive o guard de "nenhum parametro preenchido" e o mapeamento de
    * Operacao para o codigo de 1 letra gravado em Opers).
    *
    * Retorna .T. quando a consulta foi executada (mesmo com zero linhas) e
    * .F. quando nenhum filtro foi informado ou o SQL falhou; nos dois casos
    * de falha THIS.this_cMensagemErro traz o motivo, para o form decidir
    * entre MsgAviso (validacao) e MsgErro (falha tecnica) - este BO nao
    * chama MsgAviso/MsgErro diretamente nesse caminho.
    *
    * Responsabilidade do FORM apos chamar este metodo (Problema 48): limpar
    * e reatribuir Grid.RecordSource + cada Column.ControlSource +
    * Column.Header1.Caption, porque o SQLEXEC recria o cursor a cada busca -
    * exatamente como o legado faz em Processamento (RecordSource = '' no
    * inicio do metodo, RecordSource + ControlSource de novo no fim).
    *==========================================================================
    PROCEDURE BuscarLog()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cHrIniSQL, loc_cHrFinSQL
        LOCAL loc_cOperFiltro, loc_dDtFinCompleta, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_nQtdeLog = 0

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cUserRede))  AND ;
               EMPTY(THIS.this_dDtIni)              AND ;
               EMPTY(THIS.this_dDtFin)              AND ;
               EMPTY(ALLTRIM(THIS.this_cHrIni))     AND ;
               EMPTY(ALLTRIM(THIS.this_cHrFin))     AND ;
               EMPTY(ALLTRIM(THIS.this_cPrg))       AND ;
               EMPTY(ALLTRIM(THIS.this_cOperacao))  AND ;
               EMPTY(ALLTRIM(THIS.this_cUserSis))   AND ;
               EMPTY(ALLTRIM(THIS.this_cParam))     AND ;
               EMPTY(ALLTRIM(THIS.this_cTrans))

                THIS.this_cMensagemErro = "Pesquisa n" + CHR(227) + "o pode ser realizada," + CHR(13) + ;
                    "Nenhum Parametro de Sele" + CHR(231) + CHR(227) + "o foi Preenchido"
                loc_lResultado = .F.

            ELSE

                *-- Monta o WHERE dinamico - so entra o que o usuario preencheu
                loc_cWhere = ""

                IF !EMPTY(ALLTRIM(THIS.this_cUserRede))
                    loc_cWhere = loc_cWhere + " UsuaRedes = " + EscaparSQL(ALLTRIM(THIS.this_cUserRede))
                ENDIF

                IF !EMPTY(THIS.this_dDtIni)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars >= " + FormatarDataSQL(THIS.this_dDtIni)
                ENDIF

                IF !EMPTY(THIS.this_dDtFin)
                    *-- Legado soma 23:59:59 ao fim do periodo (fDtoSQL(ldDtFin,'23:59:59'))
                    loc_dDtFinCompleta = DATETIME(YEAR(THIS.this_dDtFin), MONTH(THIS.this_dDtFin), ;
                        DAY(THIS.this_dDtFin), 23, 59, 59)
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Datars <= " + FormatarDataSQL(loc_dDtFinCompleta)
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrIni))
                    loc_cHrIniSQL = PADL(ALLTRIM(THIS.this_cHrIni), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas >= " + EscaparSQL(SUBSTR(loc_cHrIniSQL, 1, 2) + ":" + SUBSTR(loc_cHrIniSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cHrFin))
                    loc_cHrFinSQL = PADL(ALLTRIM(THIS.this_cHrFin), 4, "0")
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Horas <= " + EscaparSQL(SUBSTR(loc_cHrFinSQL, 1, 2) + ":" + SUBSTR(loc_cHrFinSQL, 3, 2) + ":00")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cPrg))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Progs = " + EscaparSQL(ALLTRIM(THIS.this_cPrg))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    *-- Mapeamento identico ao legado: Entrada=E, Saida=S, Liberacao=L,
                    *-- qualquer outra opcao (Transacao) = nenhum dos tres codigos acima.
                    *-- Medido no VFP9 em 2026-10-29: UPPER() converte os acentos
                    *-- (CHR(231) -> CHR(199), CHR(227) -> CHR(195)), por isso a comparacao
                    *-- com "LIBERA" + CHR(199) + CHR(195) + "O" casa com a opcao acentuada
                    *-- escolhida no ComboBox, igual ao Upper(lcOperacao) do legado.
                    DO CASE
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "ENTRADA"
                            loc_cOperFiltro = " Opers = 'E'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "SAIDA"
                            loc_cOperFiltro = " Opers = 'S'"
                        CASE UPPER(ALLTRIM(THIS.this_cOperacao)) == "LIBERA" + CHR(199) + CHR(195) + "O"
                            loc_cOperFiltro = " Opers = 'L'"
                        OTHERWISE
                            loc_cOperFiltro = " Opers <> 'E' AND Opers <> 'S' AND Opers <> 'L'"
                    ENDCASE
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + loc_cOperFiltro
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cUserSis))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Usuasis = " + EscaparSQL(ALLTRIM(THIS.this_cUserSis))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cParam))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Parametros LIKE " + EscaparSQL(ALLTRIM(THIS.this_cParam) + "%")
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cTrans))
                    loc_cWhere = loc_cWhere + IIF(!EMPTY(loc_cWhere), " AND", "") + ;
                        " Transacaos LIKE " + EscaparSQL(ALLTRIM(THIS.this_cTrans) + "%")
                ENDIF

                *-- Colunas: cOpers (descricao calculada) primeiro, depois TODAS as
                *-- colunas de SigOpLog - o legado faz [Select '          ' As cOpers, a.*].
                *-- A descricao sai de um CASE no proprio SELECT porque cursor de SQL
                *-- pass-through nasce somente-leitura no VFP e o
                *-- "Replace All cOpers With Iif(...)" do legado nao teria onde gravar;
                *-- o mapeamento eh o MESMO de THIS.DescreverOperacao().
                loc_cSQL = "SELECT " + ;
                    "CASE a.Opers " + ;
                        "WHEN 'E' THEN 'Entrada' " + ;
                        "WHEN 'S' THEN 'Saida' " + ;
                        "WHEN 'L' THEN 'Libera" + CHR(231) + CHR(227) + "o' " + ;
                        "ELSE 'Transa" + CHR(231) + CHR(227) + "o' " + ;
                    "END AS cOpers, " + ;
                    "a.UsuaRedes, a.Datars, a.Horas, a.Progs, a.Opers, a.Usuasis, " + ;
                    "a.Parametros, a.Transacaos, a.CVersaos, a.cidchaves, a.Copias " + ;
                    "FROM SigOpLog a " + ;
                    "WHERE " + loc_cWhere

                IF USED(THIS.this_cCursorLog)
                    IF CURSORGETPROP("Buffering", THIS.this_cCursorLog) > 1
                        TABLEREVERT(.T., THIS.this_cCursorLog)
                    ENDIF
                    USE IN (THIS.this_cCursorLog)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLog)

                IF loc_nResultado >= 0
                    SELECT (THIS.this_cCursorLog)
                    GO TOP
                    THIS.this_nQtdeLog = RECCOUNT()

                    IF THIS.this_nQtdeLog = 0
                        THIS.this_cMensagemErro = "Nenhum Registro Encontrado para Sele" + CHR(231) + CHR(227) + "o"
                        THIS.LimparRegistro()
                    ELSE
                        *-- Deixa o registro corrente do BO espelhando a 1a linha da grade
                        THIS.CarregarDoCursor(THIS.this_cCursorLog)
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log:" + CHR(13) + CapturarErroSQL()
                    loc_lResultado = .F.
                ENDIF

            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao executar a pesquisa do Log: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor do resultado para
    * as propriedades do registro, mapeando TODAS as colunas de SigOpLog mais
    * a descricao calculada cOpers.
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorLog.
    *
    * Chamado pelo form no AfterRowColChange do GrdLog - no legado esse evento
    * faz "ThisForm.PgfPagina.PgResultado.fwget1.Refresh", porque o fwget1 da
    * Transacao tem ControlSource no cursor; aqui o form le
    * THIS.this_cTransacaos depois desta chamada.
    *
    * O alias que estava selecionado eh restaurado no fim, para a chamada nao
    * mexer na area de trabalho corrente de quem chamou.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_uCopias, loc_oErro

        loc_lResultado = .F.
        loc_cAliasAnterior = ALIAS()
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorLog
            ENDIF

            DO CASE
                CASE !USED(loc_cAlias)
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o est" + CHR(225) + " aberto para leitura do Log."

                CASE RECCOUNT(loc_cAlias) = 0
                    THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                        "o possui registros."
                    THIS.LimparRegistro()

                OTHERWISE
                    SELECT (loc_cAlias)

                    IF EOF() OR BOF()
                        GO TOP
                    ENDIF

                    THIS.this_cUsuaRedes  = ALLTRIM(TratarNulo(UsuaRedes, ""))
                    THIS.this_dDatars     = ConverterParaData(TratarNulo(Datars, {}))
                    THIS.this_cHoras      = ALLTRIM(TratarNulo(Horas, ""))
                    THIS.this_cProgs      = ALLTRIM(TratarNulo(Progs, ""))
                    THIS.this_cOpers      = TratarNulo(Opers, "")
                    THIS.this_cUsuaSis    = ALLTRIM(TratarNulo(Usuasis, ""))
                    THIS.this_cParametros = ALLTRIM(TratarNulo(Parametros, ""))
                    THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    THIS.this_cCVersaos   = ALLTRIM(TratarNulo(CVersaos, ""))
                    THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))

                    *-- copias eh coluna bit: conforme o driver chega Logico (.T./.F.)
                    *-- ou Numerico (0/1), por isso testar VARTYPE antes de usar o valor
                    loc_uCopias = NVL(Copias, 0)
                    IF VARTYPE(loc_uCopias) = "L"
                        THIS.this_nCopias = IIF(loc_uCopias, 1, 0)
                    ELSE
                        THIS.this_nCopias = loc_uCopias
                    ENDIF

                    *-- cOpers so existe no cursor vindo de BuscarLog(); vindo de outro
                    *-- lugar, a descricao sai do mesmo mapeamento usado pelo legado
                    IF TYPE(loc_cAlias + ".cOpers") == "C"
                        THIS.this_cOperacaoDesc = ALLTRIM(TratarNulo(cOpers, ""))
                    ELSE
                        THIS.this_cOperacaoDesc = THIS.DescreverOperacao(THIS.this_cOpers)
                    ENDIF

                    loc_lResultado = .T.
            ENDCASE
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar o registro do Log: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * DescreverOperacao - Converte o codigo gravado em SigOpLog.Opers na
    * descricao exibida na coluna "Operacao" do grid.
    *
    * Transcricao do legado (PROCEDURE Processamento):
    *   Replace All cOpers With Iif(Opers='E','Entrada',Iif(Opers='S','Saida',
    *               Iif(Opers='L','Liberacao','Transacao')))
    *==========================================================================
    PROCEDURE DescreverOperacao(par_cOpers)
        LOCAL loc_cCodigo, loc_cDescricao

        IF VARTYPE(par_cOpers) = "C"
            loc_cCodigo = UPPER(ALLTRIM(par_cOpers))
        ELSE
            loc_cCodigo = ""
        ENDIF

        DO CASE
            CASE loc_cCodigo == "E"
                loc_cDescricao = "Entrada"
            CASE loc_cCodigo == "S"
                loc_cDescricao = "Saida"
            CASE loc_cCodigo == "L"
                loc_cDescricao = "Libera" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                loc_cDescricao = "Transa" + CHR(231) + CHR(227) + "o"
        ENDCASE

        RETURN loc_cDescricao
    ENDPROC

    *==========================================================================
    * BuscarProgramas - Popula o cursor do lookup de Programas usado pelo
    * Valid do campo Programa (GetPrg) do legado:
    *   SqlExecute([Select Distinct Programas From SigCdPrg Order By Programas],
    *              "crSigCdPrg")
    *
    * par_cCursor eh opcional: sem ele usa THIS.this_cCursorProgramas.
    * Retorna .T. quando a consulta rodou (mesmo com zero linhas).
    *
    * Nos dois caminhos de falha (SQL e excecao) o motivo fica em
    * THIS.this_cMensagemErro e quem EXIBE eh o FORM - mesma convencao
    * documentada em BuscarLog, deste mesmo BO. A excecao NAO eh engolida: o
    * unico chamador (o lookup de Programa em Formsigopclg) reporta com
    * MsgErro, e exibir aqui TAMBEM empilharia dois dialogos sobre a mesma
    * falha (regra CLAUDE.md #20 - fonte unica de reporte).
    *==========================================================================
    PROCEDURE BuscarProgramas(par_cCursor)
        LOCAL loc_lResultado, loc_cAlias, loc_cSQL, loc_nResultado, loc_oErro

        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF VARTYPE(par_cCursor) = "C" AND !EMPTY(ALLTRIM(par_cCursor))
                loc_cAlias = ALLTRIM(par_cCursor)
            ELSE
                loc_cAlias = THIS.this_cCursorProgramas
            ENDIF

            loc_cSQL = "SELECT DISTINCT Programas FROM SigCdPrg ORDER BY Programas"

            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

            IF loc_nResultado >= 0
                SELECT (loc_cAlias)
                GO TOP
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas:" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar a lista de Programas: " + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparRegistro - Zera somente as propriedades do registro corrente do
    * Log, preservando os filtros digitados pelo usuario (usado quando a
    * pesquisa nao retorna linha nenhuma)
    *==========================================================================
    PROCEDURE LimparRegistro()
        THIS.this_cUsuaRedes    = ""
        THIS.this_dDatars       = {}
        THIS.this_cHoras        = ""
        THIS.this_cProgs        = ""
        THIS.this_cOpers        = ""
        THIS.this_cUsuaSis      = ""
        THIS.this_cParametros   = ""
        THIS.this_cTransacaos   = ""
        THIS.this_cCVersaos     = ""
        THIS.this_cCidChaves    = ""
        THIS.this_nCopias       = 0
        THIS.this_cOperacaoDesc = ""
    ENDPROC

    *==========================================================================
    * LimparDados - Zera filtros e registro corrente, deixando o BO como na
    * abertura da tela (o form chama este metodo ao voltar da Page "Resultado"
    * para a Page "Dados", para a consulta seguinte comecar limpa)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUserRede = ""
        THIS.this_dDtIni    = {}
        THIS.this_dDtFin    = {}
        THIS.this_cHrIni    = ""
        THIS.this_cHrFin    = ""
        THIS.this_cPrg      = ""
        THIS.this_cOperacao = ""
        THIS.this_cUserSis  = ""
        THIS.this_cParam    = ""
        THIS.this_cTrans    = ""

        THIS.this_nQtdeLog = 0
        THIS.LimparRegistro()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro corrente (SigOpLog.cidchaves),
    * conforme THIS.this_cCampoChave definido no Init
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * Este BO eh somente-leitura: SIGOPCLG eh um visualizador do Log de
    * Acessos e o legado nao tem gravacao nesta tela - o dump
    * sigopclg_form_codigo_fonte.txt nao tem nenhum TABLEUPDATE, nenhum
    * .AddCursor e nenhum Insert Into / Update / Delete From (o log eh gravado
    * por outros pontos da aplicacao). O comportamento padrao herdado de
    * BusinessBase - recusar a operacao preenchendo this_cMensagemErro, que o
    * Salvar()/Excluir() reportam pelo ExibirFalha() - ja eh o correto para
    * Inserir(), Atualizar() e ExecutarExclusao(), por isso eles ficam
    * herdados em vez de sobrescritos: sobrescrever exigiria inventar a lista
    * de colunas de um INSERT ou de um UPDATE que o legado nao faz, e a regra
    * #22 do CLAUDE.md manda tirar essa lista do schema, nunca de adivinhacao.
    * RegistrarAuditoria() tambem fica herdado de BusinessBase - ele eh
    * acionado por Inserir/Atualizar/ExecutarExclusao, que aqui nunca gravam -
    * e ObterChavePrimaria() acima ja devolve a chave certa (cidchaves) caso
    * alguma rotina de auditoria venha a ser acionada sobre este BO.
    *==========================================================================

ENDDEFINE
