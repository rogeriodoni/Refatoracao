*==============================================================================
* SIGRECTPBO.PRG
* Business Object para Relatorio de Cotacao de Compras
* Herda de RelatorioBase
* Formulario original: SIGRECTP (sigrectp.SCX)
*
* Tabelas: SigCtTdc (cabecalho), SigCtTct (itens), SigCtTfn (fornecedores),
*           SigCtTps (pedidos gerados), sigcdusu (usuarios)
*==============================================================================

DEFINE CLASS SIGRECTPBO AS RelatorioBase

    *-- Arquivo e titulo do relatorio
    this_cArquivoRelatorio  = ""
    this_cTituloRelatorio   = ""

    *-- Cursor de saida do relatorio
    this_cCursorDados       = "crImpressao"

    *-- Filtros de periodo de cotacao (obrigatorios)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de periodo de validade (opcionais)
    this_dDtValidIs         = {}
    this_dDtValidFs         = {}

    *-- Filtro de comprador (sigcdusu.Usuarios, MaxLen 10)
    this_cComprador         = ""

    *-- Filtro de aprovador (sigcdusu.Usuarios, MaxLen 10)
    this_cAprovador         = ""

    *-- Filtro de produto: codigo (SigCtTct.cpros, MaxLen 14) e descricao (SigCtTct.dpros)
    this_cCPros             = ""
    this_cDPros             = ""

    *-- Filtro de fornecedor: codigo (SigCtTfn.iclis, MaxLen 10) e nome (SigCdCli.rclis)
    this_cIClis             = ""
    this_cRClis             = ""

    *-- Filtro pedidos: 1=Sim (tem pedido gerado), 2=Nao, 3=Ambos (default 3)
    this_nPedidos           = 3

    *-- Filtro aprovados: 1=Sim (chkaprovs=1), 2=Nao (chkaprovs=0), 3=Ambos (default 3)
    this_nAprovados         = 3

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de cotacao de compras
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
            THIS.this_cArquivoRelatorio = "SigReCtp"   && FRX do legado (Erro331: "relsigrectp" nunca existiu)
            THIS.this_cTituloRelatorio  = "Relat" + CHR(243) + "rio de Cota" + ;
                                          CHR(231) + CHR(227) + "o de Compras"
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de preparar dados.
    * Equivalente a loNegocios.ValidaBotoes(loObj) do legado.
    * Retorna "": filtros validos
    * Retorna "DataInicial": data inicial vazia ou invalida
    * Retorna "DataFinal":   data final vazia ou invalida
    * Retorna "Periodo":     data final < data inicial (cotacao)
    * Retorna "PeriodoV":    data validade final < data validade inicial
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            RETURN "DataInicial"
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            RETURN "DataFinal"
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            RETURN "Periodo"
        ENDIF
        IF !EMPTY(THIS.this_dDtValidIs) AND !EMPTY(THIS.this_dDtValidFs)
            IF THIS.this_dDtValidFs < THIS.this_dDtValidIs
                RETURN "PeriodoV"
            ENDIF
        ENDIF
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Transcricao da classe de negocio legado cnSigReCtp
    *   (Fortyus\SigReCtp.PRG: Processamento -> CriarCabecalho, CriarCursores,
    *   SelecDados). Erro331: a versao migrada tinha sido INVENTADA - cursor so
    *   com o cabecalho da cotacao e crCabecalho com cb_*; o SigReCtp.frx le
    *   crImpressao (uma linha por produto com o fornecedor vencedor, Contador=1,
    *   + uma linha por pedido gerado, Contador=2..n) e crCabecalho.Titulo/
    *   SubTit/Empresa.
    *   crImpressao / crCabecalho: nomes exigidos pelo FRX (contrato do legado).
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lAbortou
        LOCAL loc_cSQL, loc_cVal, loc_nCod, loc_cLet, loc_nCnt, loc_oProg
        LOCAL loc_cSub, loc_cEmp, loc_cEmpDop
        loc_lSucesso = .F.
        loc_lAbortou = .F.
        loc_oProg    = .NULL.
        TRY
            THIS.this_cMensagemErro = ""

            *-- CriarCabecalho
            loc_cSub = "Cota" + CHR(231) + CHR(227) + "o : " + DTOC(THIS.this_dDtInicial) + " a " + DTOC(THIS.this_dDtFinal) + " " + ;
                IIF(!EMPTY(THIS.this_dDtValidIs) OR !EMPTY(THIS.this_dDtValidFs), ;
                    "Validade : " + DTOC(THIS.this_dDtValidIs) + " a " + DTOC(THIS.this_dDtValidFs) + " ", "") + ;
                IIF(EMPTY(THIS.this_cComprador), "", " - Comprador : " + ALLTRIM(THIS.this_cComprador)) + ;
                IIF(EMPTY(THIS.this_cAprovador), "", " - Aprovador : " + ALLTRIM(THIS.this_cAprovador)) + ;
                IIF(EMPTY(THIS.this_cCPros), "", " - Produto : " + ALLTRIM(THIS.this_cCPros)) + ;
                IIF(EMPTY(THIS.this_cIClis), "", " - Fornecedor : " + ALLTRIM(THIS.this_cIClis)) + ;
                IIF(THIS.this_nPedidos = 1, "Com Pedidos", "") + ;
                IIF(THIS.this_nAprovados = 1, "Com Aprova" + CHR(231) + CHR(227) + "o", "")

            loc_cEmp = ""
            IF SQLEXEC(gnConnHandle, "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), "cursor_4c_CtpEmp") > 0
                IF !EOF("cursor_4c_CtpEmp")
                    loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(cursor_4c_CtpEmp.Razas)
                ENDIF
                USE IN cursor_4c_CtpEmp
            ENDIF

            IF USED("crCabecalho")
                USE IN crCabecalho
            ENDIF
            CREATE CURSOR crCabecalho (Titulo C(200), SubTit C(200), Empresa C(80))
            INSERT INTO crCabecalho (Titulo, SubTit, Empresa) ;
                VALUES ("Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras", loc_cSub, loc_cEmp)
            GO TOP IN crCabecalho

            *-- CriarCursores
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF
            CREATE CURSOR crImpressao (Codigos N(6), DtCotas D(8), IClis C(10), RClis C(50), ;
                CPros C(14), DPros C(40), QtdAdqs N(12,2), ValAdqs N(12,2), ;
                Emps C(3), Dopes C(20), Numes N(6), DtPedidos D(8), ;
                JustGerals M(4), Justificas M(4), Aprovador C(10), ;
                NmAprovador C(30), Aprovados L(1), Contador N(3))

            *-- SelecDados: validade (opcional, 3 combinacoes como no legado)
            loc_cVal = ""
            DO CASE
                CASE !EMPTY(THIS.this_dDtValidIs) AND !EMPTY(THIS.this_dDtValidFs)
                    loc_cVal = "b.DtValids BETWEEN " + FormatarDataSQL(THIS.this_dDtValidIs) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtValidFs) + " AND "
                CASE !EMPTY(THIS.this_dDtValidIs)
                    loc_cVal = "b.DtValids >= " + FormatarDataSQL(THIS.this_dDtValidIs) + " AND "
                CASE !EMPTY(THIS.this_dDtValidFs)
                    loc_cVal = "b.DtValids <= " + FormatarDataSQL(THIS.this_dDtValidFs) + " AND "
            ENDCASE

            *-- Periodo: legado usa fDtoSql(data) nas DUAS pontas (sem 23:59:59)
            loc_cSQL = "SELECT a.Codigos, b.DtCotas, a.CPros, a.DPros, a.QtdAdqs, a.ValAdqs, a.Justificas," + ;
                " b.Justificas AS JustGerals, b.ChkAprovs, b.Aprovador, c.NComps AS NmAprovador," + ;
                " a.Marca01, a.Marca02, a.Marca03, a.Marca04, a.Marca05, a.Marca06" + ;
                " FROM SigCtTct a, SigCtTdc b" + ;
                " LEFT JOIN SigCdUsu c ON c.Usuarios = b.Aprovador" + ;
                " WHERE a.Codigos = b.Codigos AND" + ;
                " b.DtCotas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + " AND " + FormatarDataSQL(THIS.this_dDtFinal) + " AND " + ;
                loc_cVal + ;
                IIF(EMPTY(THIS.this_cCPros),     "", "a.CPros = "     + EscaparSQL(THIS.this_cCPros) + " AND ") + ;
                IIF(EMPTY(THIS.this_cComprador), "", "b.Comprador = " + EscaparSQL(THIS.this_cComprador) + " AND ") + ;
                IIF(EMPTY(THIS.this_cAprovador), "", "b.Aprovador = " + EscaparSQL(THIS.this_cAprovador) + " AND ") + ;
                IIF(THIS.this_nAprovados = 3, "", IIF(THIS.this_nAprovados = 2, "b.ChkAprovs = 0 AND ", "b.ChkAprovs = 1 AND ")) + ;
                IIF(THIS.this_nPedidos   = 3, "", IIF(THIS.this_nPedidos   = 2, "b.Situas = 0 AND ",    "b.Situas > 0 AND ")) + ;
                "0 = 0 ORDER BY a.Codigos, a.CPros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtpDados1") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigReCtp_Dados1)"
                loc_lAbortou = .T.
            ENDIF

            IF !loc_lAbortou
                SELECT DISTINCT Codigos FROM cursor_4c_CtpDados1 ORDER BY Codigos INTO CURSOR cursor_4c_CtpCodigos

                IF RECCOUNT("cursor_4c_CtpCodigos") > 0
                    loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Cota" + CHR(231) + CHR(245) + "es...", RECCOUNT("cursor_4c_CtpCodigos"))
                    IF VARTYPE(loc_oProg) = "O"
                        loc_oProg.Show()
                    ENDIF
                ENDIF

                SELECT cursor_4c_CtpCodigos
                SCAN WHILE !loc_lAbortou
                    loc_nCod = cursor_4c_CtpCodigos.Codigos
                    IF VARTYPE(loc_oProg) = "O"
                        loc_oProg.SubTitulo.Caption = "Cota" + CHR(231) + CHR(227) + "o : " + ALLTRIM(STR(loc_nCod, 6))
                        loc_oProg.Update(.T.)
                    ENDIF

                    SELECT * FROM cursor_4c_CtpDados1 WHERE Codigos = loc_nCod ORDER BY CPros INTO CURSOR cursor_4c_CtpDados

                    *-- Fornecedor vencedor de cada produto (Marca01..06 -> grade A..F)
                    SELECT cursor_4c_CtpDados
                    SCAN WHILE !loc_lAbortou
                        loc_cLet = " "
                        DO CASE
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca01)
                                loc_cLet = "A"
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca02)
                                loc_cLet = "B"
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca03)
                                loc_cLet = "C"
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca04)
                                loc_cLet = "D"
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca05)
                                loc_cLet = "E"
                            CASE THIS.MarcaLigada(cursor_4c_CtpDados.Marca06)
                                loc_cLet = "F"
                        ENDCASE

                        IF !EMPTY(loc_cLet)
                            loc_cSQL = "SELECT a.IClis, a.Fornecs FROM SigCtTfn a" + ;
                                " WHERE a.Codigos = " + ALLTRIM(STR(cursor_4c_CtpDados.Codigos, 6)) + ;
                                " AND a.Grades = " + EscaparSQL(loc_cLet) + ;
                                IIF(EMPTY(THIS.this_cIClis), "", " AND a.IClis = " + EscaparSQL(PADR(THIS.this_cIClis, 10)))
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtpFornecs") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (crSigReCtp_Fornecs)"
                                loc_lAbortou = .T.
                            ELSE
                                IF !EOF("cursor_4c_CtpFornecs")
                                    INSERT INTO crImpressao (Codigos, DtCotas, IClis, RClis, CPros, DPros, QtdAdqs, ValAdqs, ;
                                        JustGerals, Justificas, Contador, Aprovador, NmAprovador, Aprovados) ;
                                        VALUES (cursor_4c_CtpDados.Codigos, ConverterParaData(NVL(cursor_4c_CtpDados.DtCotas, {})), ;
                                            cursor_4c_CtpFornecs.IClis, cursor_4c_CtpFornecs.Fornecs, cursor_4c_CtpDados.CPros, ;
                                            cursor_4c_CtpDados.DPros, cursor_4c_CtpDados.QtdAdqs, cursor_4c_CtpDados.ValAdqs, ;
                                            NVL(cursor_4c_CtpDados.JustGerals, ""), NVL(cursor_4c_CtpDados.Justificas, ""), 1, ;
                                            cursor_4c_CtpDados.Aprovador, NVL(cursor_4c_CtpDados.NmAprovador, ""), ;
                                            (cursor_4c_CtpDados.ChkAprovs = 1))
                                ENDIF
                                USE IN cursor_4c_CtpFornecs
                            ENDIF
                        ENDIF
                        SELECT cursor_4c_CtpDados
                    ENDSCAN

                    *-- Pedidos gerados pela cotacao (Contador 2..n)
                    IF !loc_lAbortou
                        SELECT crImpressao
                        LOCATE FOR Codigos = loc_nCod
                        IF FOUND()
                            loc_cSQL = "SELECT a.EmpDopNums, b.Datas FROM SigCtTps a, SigCtTpc b" + ;
                                " WHERE a.Codigos = " + ALLTRIM(STR(loc_nCod, 6)) + " AND a.Codigos = b.Codigos" + ;
                                " ORDER BY a.EmpDopNums"
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtpPeds") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (crSigReCtp_Peds)"
                                loc_lAbortou = .T.
                            ELSE
                                loc_nCnt = 1
                                SELECT cursor_4c_CtpPeds
                                SCAN
                                    loc_nCnt    = loc_nCnt + 1
                                    loc_cEmpDop = cursor_4c_CtpPeds.EmpDopNums
                                    INSERT INTO crImpressao (Codigos, Contador, Emps, Dopes, Numes, DtPedidos) ;
                                        VALUES (loc_nCod, loc_nCnt, SUBSTR(loc_cEmpDop, 1, 3), SUBSTR(loc_cEmpDop, 4, 20), ;
                                            INT(VAL(SUBSTR(loc_cEmpDop, 24, 6))), ConverterParaData(NVL(cursor_4c_CtpPeds.Datas, {})))
                                    SELECT cursor_4c_CtpPeds
                                ENDSCAN
                                USE IN cursor_4c_CtpPeds
                            ENDIF
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_CtpDados")
                        USE IN cursor_4c_CtpDados
                    ENDIF
                    SELECT cursor_4c_CtpCodigos
                ENDSCAN
                USE IN cursor_4c_CtpCodigos
                USE IN cursor_4c_CtpDados1
            ENDIF

            IF !loc_lAbortou
                SELECT crImpressao
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF VARTYPE(loc_oProg) = "O"
            loc_oProg.Complete()
            loc_oProg = .NULL.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcaLigada - SigCtTct.MarcaNN eh bit: chega Logico ou Numerico conforme
    *   o driver (regra #13). O legado fazia "Case crSigReCtp_Dados.Marca01".
    *--------------------------------------------------------------------------
    PROCEDURE MarcaLigada(par_uValor)
        IF VARTYPE(par_uValor) = "L"
            RETURN par_uValor
        ENDIF
        RETURN (NVL(par_uValor, 0) = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave descritiva para auditoria (periodo+filtros)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTituloRelatorio)
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_dDtFinal)
            loc_cChave = loc_cChave + "|" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cComprador))
            loc_cChave = loc_cChave + "|comp:" + ALLTRIM(THIS.this_cComprador)
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.this_cIClis))
            loc_cChave = loc_cChave + "|forn:" + ALLTRIM(THIS.this_cIClis)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cOperacao
        loc_lSucesso = .F.
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao), ;
                            par_cOperacao, "VISUALIZAR")
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Operacao, Tabela, ChaveRegistro, Usuario, DataHora, DadosNovos) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cOperacao) + "," + ;
                EscaparSQL("RELATORIO_COTACAO_COMPRAS") + "," + ;
                EscaparSQL(THIS.ObterChavePrimaria()) + "," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(ALLTRIM(THIS.this_cTituloRelatorio)) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar auditoria"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de parametros salvos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) ;
               OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido: " + ;
                    TRANSFORM(par_cAliasCursor)
                loc_lSucesso = .F.
            ELSE
                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF !EOF()
                    IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                        THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_final") = "D"
                        THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".dt_final")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_i") = "D"
                        THIS.this_dDtValidIs = EVALUATE(loc_cAlias + ".dt_valid_i")
                    ENDIF
                    IF TYPE(loc_cAlias + ".dt_valid_f") = "D"
                        THIS.this_dDtValidFs = EVALUATE(loc_cAlias + ".dt_valid_f")
                    ENDIF
                    IF TYPE(loc_cAlias + ".comprador") = "C"
                        THIS.this_cComprador = ALLTRIM(EVALUATE(loc_cAlias + ".comprador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".aprovador") = "C"
                        THIS.this_cAprovador = ALLTRIM(EVALUATE(loc_cAlias + ".aprovador"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cpros") = "C"
                        THIS.this_cCPros = ALLTRIM(EVALUATE(loc_cAlias + ".cpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".dpros") = "C"
                        THIS.this_cDPros = ALLTRIM(EVALUATE(loc_cAlias + ".dpros"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".iclis") = "C"
                        THIS.this_cIClis = ALLTRIM(EVALUATE(loc_cAlias + ".iclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".rclis") = "C"
                        THIS.this_cRClis = ALLTRIM(EVALUATE(loc_cAlias + ".rclis"))
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_pedidos") = "N"
                        THIS.this_nPedidos = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_pedidos"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_pedidos"), 3)
                    ENDIF
                    IF TYPE(loc_cAlias + ".n_aprovados") = "N"
                        THIS.this_nAprovados = IIF(BETWEEN(EVALUATE(loc_cAlias + ".n_aprovados"), 1, 3), ;
                            EVALUATE(loc_cAlias + ".n_aprovados"), 3)
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o grava registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de cota" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o altera registros. Use PrepararDados() seguido de Imprimir()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores abertos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC


    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        PREVIEW NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO PRINTER PROMPT NOCONSOLE
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para arquivo ASCII (Excel) (Pattern #167 auto)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SIGRECTP_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
