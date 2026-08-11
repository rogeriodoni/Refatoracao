*==============================================================================
* SIGREANIBO.PRG  (sigreaniBO.prg)
* Business Object para Relatorio de Aniversariantes
* Herda de RelatorioBase
*
* Tabelas: SigCdCli (clientes - aniversarios/casamentos/conjuges)
*          SigCdCe  (empresas  - socios e conjuges de socios)
*          SigCdEmp (cabecalho - razao social da empresa)
* Filtros: DtInicial e DtFinal (somente dia/mes importam)
*
* Logica de PrepararDados:
*   1. Extrai dia/mes e converte para MMDD para comparar com dmnascs/dmcasas/dmconjs
*   2. Busca SigCdCli com aniversario/casamento/conjuge no intervalo MMDD
*   3. Cria CsRelatorio com estrutura identica ao CsRelatorio original
*   4. Para cada cliente: inclui linha de aniversario e linha de conjuge (se aplicavel)
*   5. Busca SigCdCe e inclui socios (DtNasc1s-3s) e conjuges (DtnConj1-3)
*   6. Ordena por MMDD+Iclis via INDEX TAG Impressao
*==============================================================================

DEFINE CLASS sigreaniBO AS RelatorioBase

    *-- Filtros do relatorio (somente dia/mes importam, ano e ignorado)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Cursores utilizados pelo relatorio
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "SigReAni.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Aniversariantes"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreaniBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta CsRelatorio e CsCabecalho para o relatorio
    * Replica a logica do PROCEDURE processamento do SCX original:
    *   - Converte datas para MMDD e filtra por dmnascs/dmcasas/dmconjs
    *   - Processa clientes (aniversario + conjuge)
    *   - Processa socios e conjuges de socios via SigCdCe
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lnDIni, loc_lnMIni, loc_lnDFin, loc_lnMFin
        LOCAL loc_cMmddIni, loc_cMmddFin
        LOCAL loc_lcCbEmpresa, loc_lcCbPeriodo
        LOCAL loc_nX, loc_cNome, loc_cDNasc

        loc_lSucesso = .F.

        TRY
            *-- Validar filtros obrigatorios
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Informe o per" + CHR(237) + "odo inicial e final"
                loc_lSucesso = .F.
            ENDIF

            *-- Extrair dia e mes das datas filtro
            loc_lnDIni = DAY(THIS.this_dDtInicial)
            loc_lnMIni = MONTH(THIS.this_dDtInicial)
            loc_lnDFin = DAY(THIS.this_dDtFinal)
            loc_lnMFin = MONTH(THIS.this_dDtFinal)

            *-- Converter para formato MMDD (mesmo formato de dmnascs/dmcasas/dmconjs)
            loc_cMmddIni = PADL(TRANSFORM(loc_lnMIni), 2, "0") + PADL(TRANSFORM(loc_lnDIni), 2, "0")
            loc_cMmddFin = PADL(TRANSFORM(loc_lnMFin), 2, "0") + PADL(TRANSFORM(loc_lnDFin), 2, "0")

            *-- Limpar cursores de execucao anterior
            THIS.LimparCursores()

            *-- Buscar razao social da empresa para o cabecalho
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa")
            IF loc_nResult > 0
                SELECT cursor_4c_Empresa
                IF !EOF()
                    loc_lcCbEmpresa = ALLTRIM(Razas)
                ELSE
                    loc_lcCbEmpresa = ""
                ENDIF
                USE IN cursor_4c_Empresa
            ELSE
                loc_lcCbEmpresa = ""
            ENDIF

            *-- Montar descricao do periodo para cabecalho
            loc_lcCbPeriodo = "Per" + CHR(237) + "odo: " + ;
                              PADL(TRANSFORM(loc_lnDIni), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMIni), 2, "0") + ;
                              " " + CHR(224) + " " + ;
                              PADL(TRANSFORM(loc_lnDFin), 2, "0") + "/" + ;
                              PADL(TRANSFORM(loc_lnMFin), 2, "0")

            *-- Criar cursor de cabecalho do relatorio
            SET NULL ON
            CREATE CURSOR CsCabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
            SET NULL OFF
            INSERT INTO CsCabecalho (cb_empresa, cb_titulo, cb_periodo) ;
                   VALUES (loc_lcCbEmpresa, ;
                           "Rela" + CHR(231) + CHR(227) + "o de Aniversariantes", ;
                           loc_lcCbPeriodo)

            *-- Buscar clientes com aniversario/casamento/conjuge no intervalo MMDD
            loc_cSQL = "SELECT * FROM SigCdCli WHERE " + ;
                       "(dmnascs >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmnascs <= " + EscaparSQL(loc_cMmddFin) + ")" + ;
                       " OR (dmcasas >= " + EscaparSQL(loc_cMmddIni) + ;
                       " AND dmcasas <= " + EscaparSQL(loc_cMmddFin) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliSource")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar clientes aniversariantes"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor de resultado com mesma estrutura do CsRelatorio original
            SET NULL ON
            CREATE CURSOR CsRelatorio (Emps C(3), mes N(2), dia N(2), Iclis C(10), ;
                                           Rclis C(40), Endes C(60), Bairs C(40), ;
                                           Ceps C(9), Cidas C(30), Estas C(2), ;
                                           Tel1s C(20), Faxs C(20), Nascs D, ;
                                           emails C(50), ContaVens C(10))
            SET NULL OFF
            INDEX ON PADL(TRANSFORM(mes),2,"0") + PADL(TRANSFORM(dia),2,"0") + Iclis TAG Impressao

            *-- Processar clientes: aniversario proprio e aniversario do conjuge
            SELECT cursor_4c_CliSource
            SCAN
                SCATTER MEMVAR

                *-- Aniversario do cliente
                IF BETWEEN(DAY(m.Nascs), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.Nascs), loc_lnMIni, loc_lnMFin)
                    m.mes = MONTH(m.Nascs)
                    m.dia = DAY(m.Nascs)
                    SELECT CsRelatorio
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                *-- Aniversario do conjuge do cliente
                IF BETWEEN(DAY(m.dtncons), loc_lnDIni, loc_lnDFin) AND ;
                   BETWEEN(MONTH(m.dtncons), loc_lnMIni, loc_lnMFin) AND ;
                   !EMPTY(m.conjuges)
                    m.mes   = MONTH(m.dtncons)
                    m.dia   = DAY(m.dtncons)
                    m.Rclis = m.conjuges
                    m.Nascs = m.dtncons
                    SELECT CsRelatorio
                    APPEND BLANK
                    GATHER MEMVAR
                ENDIF

                SELECT cursor_4c_CliSource
            ENDSCAN

            IF USED("cursor_4c_CliSource")
                USE IN cursor_4c_CliSource
            ENDIF

            *-- Buscar socios/empresas para processar aniversarios de socios e seus conjuges
            loc_cSQL = "SELECT * FROM SigCdCe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CeSource")
            IF loc_nResult > 0
                SELECT cursor_4c_CeSource
                INDEX ON Iclis TAG Iclis

                SELECT cursor_4c_CeSource
                SCAN
                    SCATTER MEMVAR

                    *-- Verificar aniversarios dos 3 socios (Socio1s/DtNasc1s ate Socio3s/DtNasc3s)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Socio"  + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtNasc" + TRANSFORM(loc_nX) + "s"

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT CsRelatorio
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    *-- Verificar aniversarios dos conjuges dos socios (Conj1s/DtnConj1 ate Conj3s/DtnConj3)
                    FOR loc_nX = 1 TO 3
                        loc_cNome  = "m.Conj"   + TRANSFORM(loc_nX) + "s"
                        loc_cDNasc = "m.DtnConj" + TRANSFORM(loc_nX)

                        IF BETWEEN(DAY(&loc_cDNasc.), loc_lnDIni, loc_lnDFin) AND ;
                           BETWEEN(MONTH(&loc_cDNasc.), loc_lnMIni, loc_lnMFin) AND ;
                           !EMPTY(&loc_cNome.)

                            IF !USED("cursor_4c_TmpCli")
                                loc_cSQL = "SELECT * FROM SigCdCli WHERE Iclis = " + ;
                                           EscaparSQL(ALLTRIM(cursor_4c_CeSource.Iclis))
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            ENDIF

                            IF USED("cursor_4c_TmpCli")
                                SELECT cursor_4c_TmpCli
                                SCATTER MEMVAR
                                m.mes   = MONTH(&loc_cDNasc.)
                                m.dia   = DAY(&loc_cDNasc.)
                                m.Rclis = &loc_cNome.
                                m.Nascs = &loc_cDNasc.
                                SELECT CsRelatorio
                                APPEND BLANK
                                GATHER MEMVAR
                            ENDIF
                        ENDIF
                    NEXT

                    IF USED("cursor_4c_TmpCli")
                        USE IN cursor_4c_TmpCli
                    ENDIF

                    SELECT cursor_4c_CeSource
                ENDSCAN

                IF USED("cursor_4c_CeSource")
                    USE IN cursor_4c_CeSource
                ENDIF
            ENDIF

            *-- Posicionar no inicio do cursor de resultado para o REPORT FORM
            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                ELSE
                    IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                        MsgAviso("Nenhum registro encontrado para os filtros informados.", ;
                                 "Relat" + CHR(243) + "rio")
                        THIS.LimparCursores()
                    ELSE
                        REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                        THIS.LimparCursores()
                        THIS.this_cMensagemErro = ""
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF !FILE(THIS.this_cFRXPath)
                    THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                              CHR(227) + "o encontrado: " + THIS.this_cFRXPath
                ELSE
                    IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                        MsgAviso("Nenhum registro encontrado para os filtros informados.", ;
                                 "Relat" + CHR(243) + "rio")
                        THIS.LimparCursores()
                    ELSE
                        REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                        THIS.LimparCursores()
                        THIS.this_cMensagemErro = ""
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores do relatorio se estiverem abertos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        IF USED("cursor_4c_CliSource")
            USE IN cursor_4c_CliSource
        ENDIF
        IF USED("cursor_4c_CeSource")
            USE IN cursor_4c_CeSource
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF
        IF USED("cursor_4c_Empresa")
            USE IN cursor_4c_Empresa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    * Stub para compatibilidade com RelatorioBase.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * BOs de Relatorio populam dados via PrepararDados() -> CsRelatorio,
    * nao precisam carregar registro individual do cursor.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao inserem registros no banco.
    * Operacao real e executada por Visualizar()/Imprimir().
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
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    * Relatorios sao somente-leitura: nao excluem registros no banco.
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
    * Destroy - Fecha cursores abertos pelo relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE
