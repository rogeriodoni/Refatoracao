*==============================================================================
* SIGREVTOBO.PRG
* Business Object para Relatorio Total Por Operacao (SIGREVTO)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvPar (sem moeda de operacao)
*                     SigMvCab (com moeda de operacao via SigCdOpe.CMoes)
*
* Filtros:
*   - Operacao  (codigo da operacao - campo Dopes de SigMvPar/SigMvCab)
*   - Periodo   (data inicial / data final)
*   - Moeda     (codigo + descricao - CMoes/DMoes de SigCdMoe)
*   - Empresa   (codigo + descricao - Cemps/Razas de SigCdEmp, opcional)
*==============================================================================

DEFINE CLASS sigrevtoBO AS RelatorioBase

    *-- Filtro: operacao (get_dopes do legado - Dopes C(20))
    this_cDopes         = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: moeda (get_moeda/get_moeda_desc do legado)
    this_cMoeda         = ""
    this_cMoedaDesc     = ""

    *-- Filtro: empresa (getEmpresa/getDesEmpresa do legado, opcional)
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Dados derivados - preenchidos em InicializarFiltros() e PrepararDados()
    this_cMoedaOpe      = ""   && CMoes de SigCdOpe para a operacao (vazio = usa SigMvPar)
    this_cNomeEmpresa   = ""   && Razas de SigCdEmp para cabecalho

    *-- Nome do cursor de saida populado por PrepararDados()
    *-- Deve bater com o cursor que o FRX legado (SigReVto.frx) espera.
    this_cCursorDados   = "csRelatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de totais por operacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega valores padrao de moeda e define datas
    * Chamado pelo Form em InicializarForm() apos instanciar o BO
    * Equivalente ao SELECT MoedaPs FROM SigCdPam no Init() legado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Datas padrao = hoje
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()

            *-- Busca moeda padrao em SigCdPam
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
            loc_cSQL = "SELECT MoedaPs FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                GO TOP
                IF !EOF()
                    THIS.this_cMoeda = ALLTRIM(MoedaPs)
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            *-- Busca descricao da moeda padrao
            IF !EMPTY(THIS.this_cMoeda)
                IF USED("cursor_4c_MoePad")
                    USE IN cursor_4c_MoePad
                ENDIF
                loc_cSQL = "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + ;
                           EscaparSQL(THIS.this_cMoeda)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePad")
                IF loc_nResult > 0
                    SELECT cursor_4c_MoePad
                    GO TOP
                    IF !EOF()
                        THIS.this_cMoedaDesc = ALLTRIM(DMoes)
                    ENDIF
                    USE IN cursor_4c_MoePad
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor_4c_Relatorio + CsCabecalho
    * Equivalente ao PROCEDURE processamento do legado SIGREVTO
    *
    * Logica dual:
    *   Branch A (EMPTY CMoes): usa SigMvPar + converte MoeFpgs -> this_cMoeda
    *   Branch B (!EMPTY CMoes): usa SigMvCab + converte CMoes da ope -> this_cMoeda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_cDopes, loc_cMoeda, loc_cEmpresa, loc_cMoeOpe
        LOCAL loc_cDtIni, loc_cDtFin, loc_cWEmp
        LOCAL loc_cRazas, loc_cTitulo, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cDopes   = PADR(ALLTRIM(THIS.this_cDopes), 20)
            loc_cMoeda   = ALLTRIM(THIS.this_cMoeda)
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cMoeOpe  = ""

            *-- Validacao obrigatoria
            IF EMPTY(ALLTRIM(loc_cDopes))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                    "o obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(loc_cMoeda)
                THIS.this_cMensagemErro = "Moeda obrigat" + CHR(243) + "ria"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo obrigat" + CHR(243) + "rio"
                loc_lSucesso = .F.
            ENDIF

            *-- Formata datas para SQL DATETIME (coluna datas = DATETIME no banco)
            loc_cDtIni = "'" + PADL(YEAR(THIS.this_dDtInicial),4,"0")  + "-" + ;
                               PADL(MONTH(THIS.this_dDtInicial),2,"0") + "-" + ;
                               PADL(DAY(THIS.this_dDtInicial),2,"0")   + " 00:00:00'"
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDtFinal),4,"0")    + "-" + ;
                               PADL(MONTH(THIS.this_dDtFinal),2,"0")   + "-" + ;
                               PADL(DAY(THIS.this_dDtFinal),2,"0")     + " 23:59:59'"

            *-- 1. Nome da empresa para o cabecalho do relatorio
            loc_cRazas = ""
            IF USED("cursor_4c_EmpCab")
                USE IN cursor_4c_EmpCab
            ENDIF
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpCab")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpCab
                GO TOP
                IF !EOF()
                    loc_cRazas = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_EmpCab
            ENDIF

            *-- 2. Textos do cabecalho
            loc_cTitulo = "Relat" + CHR(243) + "rio Total Por Opera" + ;
                          CHR(231) + CHR(227) + "o - " + ;
                          PROPER(ALLTRIM(loc_cDopes)) + ;
                          IIF(EMPTY(loc_cEmpresa), "", ;
                              " - Empresa : " + loc_cEmpresa)
            loc_cPeriodo = "Per" + CHR(237) + "odo de " + ;
                           DTOC(THIS.this_dDtInicial) + " " + ;
                           CHR(224) + " " + DTOC(THIS.this_dDtFinal)

            *-- 3. Cria cursor de cabecalho para uso no FRX
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                             VALUES (loc_cRazas,  loc_cTitulo, loc_cPeriodo)

            *-- 4. Busca moeda da operacao em SigCdOpe (CMoes)
            IF USED("cursor_4c_Ope")
                USE IN cursor_4c_Ope
            ENDIF
            loc_cSQL = "SELECT CMoes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(loc_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
            IF loc_nResult > 0
                SELECT cursor_4c_Ope
                GO TOP
                IF !EOF()
                    loc_cMoeOpe = ALLTRIM(CMoes)
                ENDIF
                USE IN cursor_4c_Ope
            ENDIF
            THIS.this_cMoedaOpe = loc_cMoeOpe

            *-- 5. WHERE de empresa (opcional - filtra por empresa especifica)
            loc_cWEmp = IIF(EMPTY(loc_cEmpresa), "", ;
                            "Emps = " + EscaparSQL(loc_cEmpresa) + " AND ")

            *-- 6. Fecha cursor de resultado anterior
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(loc_cMoeOpe)
                *-- Branch A: SigMvPar (operacao sem moeda de referencia definida)
                *-- Converte MoeFpgs -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, MoeFpgs, Valos " + ;
                           "FROM SigMvPar " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvPar")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvPar"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvPar.Emps, crSigMvPar.Dopes, ;
                       loc_cMoeda AS lcMoeda, ;
                       0 AS mValVars, 0 AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = MoeFpgs, Valos, ;
                           Valos * fBuscarCotacao(MoeFpgs, Datas, gnConnHandle) / ;
                                  fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvPar ;
                  GROUP BY crSigMvPar.Emps, crSigMvPar.Dopes, lcMoeda, 4, 5 ;
                  ORDER BY crSigMvPar.Emps, crSigMvPar.Dopes ;
                  INTO CURSOR csRelatorio READWRITE

                IF USED("crSigMvPar")
                    USE IN crSigMvPar
                ENDIF
            ELSE
                *-- Branch B: SigMvCab (operacao com moeda de referencia)
                *-- Converte CMoes da operacao -> this_cMoeda via fBuscarCotacao
                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, ValVars, ValDevs, Valos " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + ;
                           " AND " + loc_cDtFin + ;
                           " AND " + loc_cWEmp + ;
                           "Dopes = " + EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao buscar dados de SigMvCab"
                    loc_lSucesso = .F.
                ENDIF

                SELECT crSigMvCab.Emps, crSigMvCab.Dopes, ;
                       loc_cMoeda AS lcMoeda, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValVars, ;
                           ValVars * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValVars, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, ValDevs, ;
                           ValDevs * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValDevs, ;
                       SUM(IIF(loc_cMoeda = loc_cMoeOpe, Valos, ;
                           Valos   * fBuscarCotacao(loc_cMoeOpe, Datas, gnConnHandle) / ;
                                    fBuscarCotacao(loc_cMoeda, Datas, gnConnHandle))) AS mValos ;
                  FROM crSigMvCab ;
                  GROUP BY crSigMvCab.Emps, crSigMvCab.Dopes, lcMoeda ;
                  ORDER BY crSigMvCab.Emps, crSigMvCab.Dopes ;
                  INTO CURSOR csRelatorio READWRITE

                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF
            ENDIF

            *-- Posiciona no inicio do cursor de resultado
            IF USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; isola SET
    *-- POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM (Erro28).
    *-- Guard cursor vazio evita preview em branco (Erro30).
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
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

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa PrepararDados e exibe relatorio em preview
    * Equivalente ao PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
            ELSE
                THIS.ExecutarReportForm("SigReVto", "PREVIEW", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa PrepararDados e envia para impressora (com prompt)
    * Equivalente ao PROCEDURE impressao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
            ELSE
                THIS.ExecutarReportForm("SigReVto", "PRINTER_PROMPT", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Executa PrepararDados e imprime direto sem prompt
    * Equivalente ao PROCEDURE documento do legado
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                MsgErro(THIS.this_cMensagemErro)
            ELSE
                THIS.ExecutarReportForm("SigReVto", "PRINTER", THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Documento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> cursor_4c_Relatorio,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir()/Documento().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao atualizam registros no banco.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO APLICAVEL a Relatorios
    * Relatorios sao somente-leitura.
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao geram registros de auditoria
    * Override do RelatorioBase para deixar explicito.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos por InicializarFiltros e PrepararDados
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        IF USED("cursor_4c_MoePad")
            USE IN cursor_4c_MoePad
        ENDIF
        IF USED("cursor_4c_EmpCab")
            USE IN cursor_4c_EmpCab
        ENDIF
        IF USED("cursor_4c_Ope")
            USE IN cursor_4c_Ope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("crSigMvPar")
            USE IN crSigMvPar
        ENDIF
        IF USED("crSigMvCab")
            USE IN crSigMvCab
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
