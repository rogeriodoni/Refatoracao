*==============================================================================
* SIGOPCHRBO.PRG
* Business Object para Relatorio de Relacao de Cheques
*
* Herda de: RelatorioBase
* Form: FormSIGOPCHR.prg
* Relatorio original: SIGOPCHR.SCX / SigOpChr.FRX
*==============================================================================

DEFINE CLASS SIGOPCHRBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpChr"
    this_cTituloRelatorio   = ""
    this_cSubtituloRelatorio = ""

    *-- Filtros de parametro do formulario (legado: Get_Oper/GetDataI/GetDataF/GetTipo/getGrupo/getConta/ImpNConta)
    this_cOperacao          = ""
    this_dDataInicial       = {}
    this_dDataFinal         = {}
    this_nTipo              = 1
    this_cGrupo             = ""
    this_cDescGrupo         = ""
    this_cConta             = ""
    this_cDescConta         = ""
    this_lImpNConta         = .F.

    *-- Cursores principais consumidos pelo FRX (nomes preservados do legado)
    this_cCursorDados       = "CsImpressao"
    this_cCursorCabecalho   = "csCabecalho"

    *--------------------------------------------------------------------------
    * Init - Construtor do BO de Relatorio de Cheques
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Cheques"

        THIS.this_dDataInicial = DATE() - 30
        THIS.this_dDataFinal   = DATE()
        THIS.this_nTipo        = 1

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarParametros - Valida filtros antes de PrepararDados
    * Equivale ao bloco de validacao de btnReport.Click do legado
    * (Data Inicial/Final invalidas, Final < Inicial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarParametros()
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataInicial)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataInicial
            THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + ;
                "o Pode Ser Menor do que a Inicial!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCabecalho - Popula cursor csCabecalho referenciado pelo FRX legado
    * SigOpChr.frx tem Dataenvironment com alias csCabecalho (Empresa, Titulo,
    * Subtitulo, Quebra, Nconta). Estrutura preservada do legado
    * (SIGOPCHR.processamento).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCabecalho()
        LOCAL loc_cEmp, loc_cRazas, loc_cEmpresa, loc_cTitulo, loc_cSubtitulo
        LOCAL loc_lQuebra, loc_nResult

        loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        loc_cRazas = ""
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
            "cursor_4c_EmpCab")
        IF loc_nResult > 0 AND USED("cursor_4c_EmpCab") AND RECCOUNT("cursor_4c_EmpCab") > 0
            loc_cRazas = ALLTRIM(cursor_4c_EmpCab.Razas)
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        loc_cEmpresa = loc_cEmp + IIF(EMPTY(loc_cRazas), "", " - " + loc_cRazas)

        loc_cTitulo = "Rela" + CHR(231) + CHR(227) + "o " + ;
            IIF(THIS.this_nTipo = 1, "Geral de Cheques - ", "de Cheques Pendentes - ") + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cOperacao)), ;
                "Todas as Opera" + CHR(231) + CHR(245) + "es", ;
                ALLTRIM(THIS.this_cOperacao))

        loc_cSubtitulo = "Per" + CHR(237) + "odo : " + DTOC(THIS.this_dDataInicial) + ;
            " at" + CHR(233) + " " + DTOC(THIS.this_dDataFinal) + "     " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cGrupo)), ;
                "Todos os Grupos", "Grupo : " + ALLTRIM(THIS.this_cGrupo)) + "  " + ;
            IIF(EMPTY(ALLTRIM(THIS.this_cConta)), ;
                "Todas as Contas", "Conta : " + ALLTRIM(THIS.this_cConta))

        loc_lQuebra = EMPTY(ALLTRIM(THIS.this_cConta))

        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), Subtitulo C(80), ;
            Quebra L(1), Nconta L)
        INSERT INTO csCabecalho (Empresa, Titulo, Subtitulo, Quebra, Nconta) ;
            VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubtitulo, loc_lQuebra, ;
                    THIS.this_lImpNConta)

        SELECT csCabecalho
        GO TOP
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta WHERE a partir dos filtros e executa a consulta
    * Transcricao de SIGOPCHR.processamento:
    *   From SigChe a, SigCdOpt b, SigCdCli c
    *   Where a.Vencs Between ?ldDatai And ?ldDataF
    *     [And a.Umovs = lcOpera] [And a.GrClis = lcGrupo] [And a.IClis = lcConta]
    *     [And b.Tipos = 'DB' quando this_nTipo = 2 (nao liquidado)]
    *     And a.Umovs = b.Operacaos And a.Iclis = c.Iclis
    *   Order By 1,2,3,4,5,6,7,8,9,10
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cWhere
        LOCAL loc_tDataFinal, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarParametros()
                loc_lSucesso = .F.
            ELSE
                THIS.CriarCabecalho()

                *-- Data final inclui o dia inteiro (fDtoSQL(ldDataF,'23:59:59') no legado)
                loc_tDataFinal = DATETIME(YEAR(THIS.this_dDataFinal), ;
                    MONTH(THIS.this_dDataFinal), DAY(THIS.this_dDataFinal), 23, 59, 59)

                loc_cWhere = " a.Vencs BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                             " AND " + FormatarDataSQL(loc_tDataFinal)

                IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                    loc_cWhere = loc_cWhere + " AND a.Umovs = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOperacao))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + " AND a.GrClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF
                IF !EMPTY(ALLTRIM(THIS.this_cConta))
                    loc_cWhere = loc_cWhere + " AND a.IClis = " + ;
                        EscaparSQL(ALLTRIM(THIS.this_cConta))
                ENDIF
                IF THIS.this_nTipo = 2
                    loc_cWhere = loc_cWhere + " AND b.Tipos = " + EscaparSQL("DB")
                ENDIF

                loc_cSQL = "SELECT a.Vencs, a.GrClis AS Grupos, a.IClis AS Contas," + ;
                           " a.Umovs, a.Emps, a.Bancos, a.Agencias, a.NContas," + ;
                           " a.NCheques, a.Valors, b.Tipos, c.Rclis" + ;
                           " FROM SigChe a" + ;
                           " INNER JOIN SigCdOpt b ON a.Umovs = b.Operacaos" + ;
                           " INNER JOIN SigCdCli c ON a.IClis = c.IClis" + ;
                           " WHERE" + loc_cWhere + ;
                           " ORDER BY a.Vencs, a.GrClis, a.IClis, a.Umovs, a.Emps," + ;
                           " a.Bancos, a.Agencias, a.NContas, a.NCheques, a.Valors"

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar cheques" + CHR(13) + ;
                        CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir e o cursor nao estiver vazio. Isola SET POINT/SEPARATOR/
    * REPORTBEHAVIOR durante o REPORT FORM porque o FRX legado Fortyus foi
    * desenhado com POINT="." + REPORTBEHAVIOR 80. Restaura o menu principal
    * depois do PREVIEW (Erro63).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + ;
                "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum cheque encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        *-- Restaurar menu (Erro63): REPORT FORM PREVIEW abre toolbar propria
        *-- que corrompe o cache visual do _MSYSMENU.
        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PREVIEW", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia o relatorio para a impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = THIS.ExecutarReportForm("SigOpChr", "PRINTER_PROMPT", THIS.this_cCursorDados)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir relat" + CHR(243) + "rio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo ASCII (Pattern #167)
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "sigopchr_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        THIS.RegistrarAuditoria("EXCEL")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum cheque encontrado com os filtros informados."
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    MsgErro(THIS.this_cMensagemErro, "Rela" + CHR(231) + CHR(227) + "o de Cheques")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarExcel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave composta dos filtros, usada em RegistrarAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "OPER=" + ALLTRIM(THIS.this_cOperacao) + ;
               ";TIPO=" + ALLTRIM(STR(THIS.this_nTipo, 1)) + ;
               ";GRUPO=" + ALLTRIM(THIS.this_cGrupo) + ;
               ";CONTA=" + ALLTRIM(THIS.this_cConta) + ;
               ";DT=" + DTOC(THIS.this_dDataInicial) + "-" + DTOC(THIS.this_dDataFinal)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra a geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SigChe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos por PrepararDados/CriarCabecalho
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(3), loc_nI
        loc_aCursores(1) = THIS.this_cCursorDados
        loc_aCursores(2) = "csCabecalho"
        loc_aCursores(3) = "cursor_4c_EmpCab"

        FOR loc_nI = 1 TO 3
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
