*==============================================================================
* SIGREHPEBO.PRG
* Business Object do Relatorio SIGREHPE
*
* Herda de: RelatorioBase
* Tabela principal: SigChe (cheques)
* Tabela auxiliar: SigCdOpt (operacoes DB)
*==============================================================================

DEFINE CLASS SIGREHPEBO AS RelatorioBase

    *-- Tabela e chave principal
    this_cTabela        = "SigChe"
    this_cCampoChave    = "Umovs"

    *-- Caminho do arquivo de relatorio (.frx)
    this_cArquivoFRX    = ""

    *-- Titulo do relatorio
    this_cTitulo        = ""

    *-- Dados da empresa para cabecalho
    this_cEmpresa       = ""

    *-- Nomes dos cursores de dados
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela       = "SigChe"
            THIS.this_cCampoChave   = "Umovs"
            THIS.this_cTitulo       = "Resumo de Cheques Pendentes"
            THIS.this_cArquivoFRX   = gc_4c_CaminhoReports + "RelSIGREHPE.frx"
            loc_lSucesso            = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa SQL principal e popula CsRelatorio
    * Equivalente ao PROCEDURE processamento do legado
    * SQL original: SELECT a.Umovs, Sum(a.Valors) as Valor
    *               FROM SigChe a, SigCdOpt b
    *               WHERE a.UMovs = b.Operacaos AND b.Tipos = 'DB'
    *               GROUP BY a.Umovs
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql

        loc_lSucesso = .F.
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            loc_cSql = "SELECT a.Umovs, SUM(a.Valors) AS Valor " + ;
                       "FROM SigChe a, SigCdOpt b " + ;
                       "WHERE a.UMovs = b.Operacaos " + ;
                       "AND b.Tipos = 'DB' " + ;
                       "GROUP BY a.Umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "CsRelatorio")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques pendentes"
            ELSE
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    * Equivalente ao trecho inicial do PROCEDURE processamento do legado:
    *   ThisForm.podatamgr.CursorQuery('SigCdEmp','crSigCdEmp','cEmps',_empr)
    *   lcEmp = Alltrim(crSigCdEmp.Cemps + ' - ' + crSigCdEmp.Razas)
    *   Create Cursor csCabecalho ...
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa

        loc_lSucesso     = .F.
        loc_cNomeEmpresa = ""
        TRY
            loc_cSqlEmp = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Cemps) + ;
                                       " - " + ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (Empresa C(80), Titulo C(80))
            INSERT INTO CsCabecalho (Empresa, Titulo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREHPEBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    * Equivalente ao PROCEDURE impressao do legado:
    *   Report Form SigReHpe To PRINTER Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    * Equivalente ao PROCEDURE visualizacao do legado:
    *   Report Form SigReHpe Preview NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF THIS.PrepararDados()
                IF THIS.MontarCabecalho()
                    SELECT CsRelatorio
                    REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                    THIS.LimparCursores()
                    loc_lSucesso = .T.
                ELSE
                    IF EMPTY(THIS.this_cMensagemErro)
                        THIS.this_cMensagemErro = "Erro ao montar cabe" + CHR(231) + "alho do relat" + CHR(243) + "rio"
                    ENDIF
                ENDIF
            ELSE
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "RELATORIO=SIGREHPE"
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: visualizar preview
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SIGREHPEBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReHpe") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
