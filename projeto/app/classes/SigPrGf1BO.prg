*==============================================================================
* SIGPRGF1BO.PRG
* Business Object para Falha x Recuperacao por Mes
* Origem: SigPrGf1.SCX
* Consulta SigCdFea agrupada por empresa/mes e prepara cursor crRel1
* para exibicao em FormSigPrGf2
*==============================================================================

DEFINE CLASS SigPrGf1BO AS BusinessBase

    *-- Parametros de entrada
    this_dDataInicial  = {}    && getDtInicial - Data inicial do periodo (D)
    this_dDataFinal    = {}    && getDtFinal   - Data final do periodo (D)

    *-- Contexto de empresa (preenchido no processamento)
    this_cEmpresa      = ""    && Cemps da empresa corrente (C3)
    this_cNomeEmpresa  = ""    && Razas da empresa corrente (C)

    *-- Titulos do relatorio (montados em PrepararRelatorio)
    this_cTitulo1      = ""    && "Falha X Recuperacao por Mes da Empresa XX - Nome" (C100)
    this_cTitulo2      = ""    && "[De dd/mm/aa a dd/mm/aa]" (C)

    *-- Mensagem de retorno do processo (usada pelo form para MessageBox)
    this_cMsgProcesso  = ""    && Resultado ou erro do processamento (C)

    *--------------------------------------------------------------------------
    * INIT - Configura BO sem tabela principal (form operacional puro)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        THIS.this_dDataInicial = {}
        THIS.this_dDataFinal   = {}
        THIS.this_cEmpresa     = ""
        THIS.this_cNomeEmpresa = ""
        THIS.this_cTitulo1     = ""
        THIS.this_cTitulo2     = ""
        THIS.this_cMsgProcesso = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de auditoria composta pelo intervalo de datas
    * Form operacional sem tabela principal, usa periodo como identificador
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !EMPTY(THIS.this_dDataInicial)
            loc_cChave = DTOS(THIS.this_dDataInicial)
        ENDIF

        IF !EMPTY(THIS.this_dDataFinal)
            loc_cChave = loc_cChave + "-" + DTOS(THIS.this_dDataFinal)
        ENDIF

        IF !EMPTY(THIS.this_cEmpresa)
            loc_cChave = ALLTRIM(THIS.this_cEmpresa) + "|" + loc_cChave
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do cursor de entrada
    * Cursor deve conter campos: DataInicial (D), DataFinal (D)
    * Opcional: Emps (C3), Razas (C)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE(par_cAliasCursor + ".DataInicial") != "U"
                    THIS.this_dDataInicial = TratarNulo(DataInicial, "D")
                ENDIF

                IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                    THIS.this_dDataFinal = TratarNulo(DataFinal, "D")
                ENDIF

                IF TYPE(par_cAliasCursor + ".Emps") != "U"
                    THIS.this_cEmpresa = TratarNulo(Emps, "C")
                ENDIF

                IF TYPE(par_cAliasCursor + ".Razas") != "U"
                    THIS.this_cNomeEmpresa = TratarNulo(Razas, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Executa a geracao do relatorio Falha X Recuperacao
    * Wrapper de ProcessarDados com auditoria da execucao
    * Retorna .T. se cursor crRel1 foi criado com registros
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        loc_lSucesso = THIS.ProcessarDados()

        IF loc_lSucesso
            THIS.RegistrarAuditoria("GERAR")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa o relatorio com novos parametros de periodo
    * Wrapper de ProcessarDados com auditoria de reexecucao
    * Retorna .T. se cursor crRel1 foi recriado com registros
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF !THIS.ValidarParametros()
            RETURN .F.
        ENDIF

        *-- Fecha cursor de resultado anterior para evitar dados stale
        IF USED("crRel1")
            USE IN crRel1
        ENDIF

        loc_lSucesso = THIS.ProcessarDados()

        IF loc_lSucesso
            THIS.RegistrarAuditoria("REPROCESSAR")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    * Grava operacao, chave (empresa+periodo), usuario e timestamp
    * Erros de auditoria nao bloqueiam a operacao principal
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro, loc_cTabelaLog

        TRY
            *-- Como form operacional nao tem tabela, usa identificador do relatorio
            loc_cTabelaLog = "SigPrGf1"

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cTabelaLog) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Audit")

            IF USED("cursor_4c_Audit")
                USE IN cursor_4c_Audit
            ENDIF

        CATCH TO loc_oErro
            *-- Auditoria nunca bloqueia a operacao principal do relatorio
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida datas do periodo antes do processamento
    * Popula this_cMsgProcesso com mensagem de erro se invalido
    * Retorna .T. se valido, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ValidarParametros()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMsgProcesso = "Data Final Inv" + CHR(225) + "lida!!!"
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMsgProcesso = "Data Inicial Maior Que a Data Final!!!"
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado
            IF (YEAR(THIS.this_dDataInicial) = YEAR(THIS.this_dDataFinal) AND ;
                (MONTH(THIS.this_dDataInicial) - MONTH(THIS.this_dDataFinal) + 1) > 12) OR ;
               (YEAR(THIS.this_dDataInicial) != YEAR(THIS.this_dDataFinal) AND ;
                ((12 - MONTH(THIS.this_dDataInicial)) + MONTH(THIS.this_dDataFinal) + 1) > 12)
                THIS.this_cMsgProcesso = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
                loc_lResultado = .F.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarDados - Consulta SigCdFea agrupada por mes e cria cursor crRel1
    * Retorna .T. se crRel1 tem registros, .F. se vazio ou erro de conexao
    * Popula: this_cEmpresa, this_cNomeEmpresa, this_cTitulo1, this_cTitulo2
    *--------------------------------------------------------------------------
    FUNCTION ProcessarDados()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_nDecimals, loc_cFixed, loc_cExact
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cStrgMes, loc_cTitulo1, loc_cTitulo2
        LOCAL loc_cEmpresa, loc_cNomeEmpresa

        loc_lResultado  = .F.
        loc_nDecimals   = SET("Decimals")
        loc_cFixed      = SET("Fixed")
        loc_cExact      = SET("Exact")

        TRY
            SET DECIMALS TO 6
            SET FIXED ON
            SET EXACT ON

            *-- Obtem nome da empresa corrente
            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")

            IF USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                loc_cNomeEmpresa = ALLTRIM(NVL(cursor_4c_Emp.Razas, ""))
            ELSE
                loc_cNomeEmpresa = ""
            ENDIF

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            THIS.this_cEmpresa     = loc_cEmpresa
            THIS.this_cNomeEmpresa = loc_cNomeEmpresa

            *-- Monta titulos do relatorio
            loc_cTitulo1 = "Falha X Recupera" + CHR(231) + CHR(227) + ;
                           "o por M" + CHR(234) + "s da Empresa "

            DO CASE
                CASE EMPTY(THIS.this_dDataInicial) AND EMPTY(THIS.this_dDataFinal)
                    loc_cTitulo2 = ""
                CASE THIS.this_dDataInicial = THIS.this_dDataFinal
                    loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDataInicial) + "]"
                CASE EMPTY(THIS.this_dDataInicial)
                    loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "]"
                OTHERWISE
                    loc_cTitulo2 = " [De " + DTOC(THIS.this_dDataInicial) + ;
                                   " " + CHR(224) + " " + DTOC(THIS.this_dDataFinal) + "]"
            ENDCASE

            THIS.this_cTitulo1 = PADR(loc_cTitulo1 + ALLTRIM(loc_cEmpresa) + ;
                                      " - " + ALLTRIM(loc_cNomeEmpresa), 100)
            THIS.this_cTitulo2 = loc_cTitulo2

            *-- Consulta SQL Server: SigCdFea com dados de Falha/Recuperacao por empresa
            IF USED("cursor_4c_TmpRel")
                USE IN cursor_4c_TmpRel
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs " + ;
                       "FROM SigCdFea a " + ;
                       "LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps " + ;
                       "WHERE a.Datas >= " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataFinal) + ")" + ;
                       " AND a.Emps = " + EscaparSQL(loc_cEmpresa)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRel")

            IF loc_nRet >= 1
                *-- String auxiliar: nome de cada mes com 9 chars (CHR(231)=c cedilha em Marco)
                loc_cStrgMes = "Janeiro  " + ;
                               "Fevereiro" + ;
                               "Mar" + CHR(231) + "o    " + ;
                               "Abril    " + ;
                               "Maio     " + ;
                               "Junho    " + ;
                               "Julho    " + ;
                               "Agosto   " + ;
                               "Setembro " + ;
                               "Outubro  " + ;
                               "Novembro " + ;
                               "Dezembro "

                *-- Agrega por empresa/mes em cursor crRel1 consumido por FormSigPrGf2
                IF USED("crRel1")
                    USE IN crRel1
                ENDIF

                SELECT Emps AS Cemps, ;
                       PADR(DTOS(Datas), 6) AS cAnomess, ;
                       PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + ;
                            "./" + TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                       PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + ;
                            " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                       loc_cTitulo2 AS loc_cTitulo2, ;
                       PADR(ALLTRIM(m.loc_cEmpresa) + " - " + ;
                            ALLTRIM(m.loc_cNomeEmpresa), 100) AS cEmpresas, ;
                       VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                       VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                  FROM cursor_4c_TmpRel ;
                 GROUP BY 1, 2, 3, 4, 5, 6 ;
                  INTO CURSOR crRel1 READWRITE

                IF USED("cursor_4c_TmpRel")
                    USE IN cursor_4c_TmpRel
                ENDIF

                SELECT crRel1
                GO TOP

                loc_lResultado = !EOF("crRel1")
            ELSE
                THIS.this_cMsgProcesso = "Favor Reinicializar o Processo!!!"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        *-- Restaura configuracoes de ambiente
        SET DECIMALS TO (loc_nDecimals)
        SET FIXED &loc_cFixed.
        SET EXACT &loc_cExact.

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
