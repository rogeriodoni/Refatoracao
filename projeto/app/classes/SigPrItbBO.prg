*==============================================================================
* SigPrItbBO.prg - Business Object: Integracao Contabil Total
* Herda de: BusinessBase
* Form associado: FormSigPrItb.prg
* Tabela principal: SigMvCcr (movimentos de conta corrente - leitura)
* Form OPERACIONAL: ProcessarIntegracao + GravarArquivos sao os metodos chave.
*==============================================================================
DEFINE CLASS SigPrItbBO AS BusinessBase

    *-- Parametros de filtro do usuario
    this_dDataIni            = {}
    this_dDataFim            = {}
    this_cEmpresa            = ""
    this_cDsEmpresa          = ""

    *-- Configuracao carregada do banco (SigCdPam.DirContabv)
    this_cDirContab          = ""

    *-- Flags de estado do processamento
    this_lProcessado         = .F.
    this_lTemInconsistencias = .F.

    *-- Propriedades do registro atual de SigMvCcr (para CarregarDoCursor)
    this_cEmps               = ""
    this_cGrupos             = ""
    this_cContas             = ""
    this_dDatas              = {}
    this_cHists              = ""
    this_cHist2s             = ""
    this_nValors             = 0
    this_cOpers              = ""
    this_lAutos              = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "Contas"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cContas
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas de SigMvCcr para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps   = TratarNulo(Emps,   "C")
            THIS.this_cGrupos = TratarNulo(Grupos,  "C")
            THIS.this_cContas = TratarNulo(Contas,  "C")
            THIS.this_dDatas  = TratarNulo(Datas,   "D")
            THIS.this_cHists  = TratarNulo(Hists,   "C")
            THIS.this_cHist2s = TratarNulo(Hist2s,  "C")
            THIS.this_nValors = TratarNulo(Valors,  "N")
            THIS.this_cOpers  = TratarNulo(Opers,   "C")
            IF VARTYPE(Autos) = "L"
                THIS.this_lAutos = NVL(Autos, .F.)
            ELSE
                IF VARTYPE(Autos) = "L"
                    THIS.this_lAutos = Autos
                ELSE
                    IF VARTYPE(Autos) = "L"
                        THIS.this_lAutos = Autos
                    ELSE
                        IF VARTYPE(Autos) = "L"
                            THIS.this_lAutos = Autos
                        ELSE
                            IF VARTYPE(Autos) = "L"
                                THIS.this_lAutos = Autos
                            ELSE
                                IF VARTYPE(Autos) = "L"
                                    THIS.this_lAutos = Autos
                                ELSE
                                    THIS.this_lAutos = (NVL(Autos, 0) = 1)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida parametros antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_dDataIni)
            THIS.this_cMensagemErro = "Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDataFim)
            THIS.this_cMensagemErro = "Data Final " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        IF THIS.this_dDataFim < THIS.this_dDataIni
            THIS.this_cMensagemErro = "Data Final n" + CHR(227) + "o pode ser menor que a Inicial."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - OPERACIONAL de integracao contabil
    * SigMvCcr eh tabela de movimento (populada por Contas a Pagar/Receber).
    * O form NAO insere em SigMvCcr; delega ProcessarIntegracao como acao principal
    * quando invocado no fluxo CRUD padrao (compatibilidade com BusinessBase).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                *-- Executa a integracao (mesmo fluxo do BtnProcessarClick)
                loc_lResultado = THIS.ProcessarIntegracao()
                IF loc_lResultado
                    THIS.RegistrarAuditoria("INSERIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - OPERACIONAL: reprocessa a integracao (equivalente a Inserir)
    * Mantido para respeitar contrato BusinessBase (Salvar chama Inserir OU Atualizar).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_lResultado = THIS.ProcessarIntegracao()
                IF loc_lResultado
                    THIS.RegistrarAuditoria("ATUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarInsercao - Nao aplicavel a OPERACIONAL (Inserir foi sobrescrito)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarInsercao()
        RETURN THIS.ProcessarIntegracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - Nao aplicavel a OPERACIONAL (Atualizar foi sobrescrito)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        RETURN THIS.ProcessarIntegracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra em LogAuditoria a operacao de integracao
    * Sobrescreve BusinessBase para gravar dados de contexto do processamento
    * (periodo, empresa filtrada) na coluna Observacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lResultado, loc_cSQL, loc_cChave, loc_cObs, loc_cEmp, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF EMPTY(loc_cChave)
                loc_cChave = "INTEGRACAO"
            ENDIF
            loc_cEmp = IIF(EMPTY(THIS.this_cEmpresa), "TODAS", ALLTRIM(THIS.this_cEmpresa))
            loc_cObs = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + ;
                       " a " + DTOC(THIS.this_dDataFim) + " | Empresa: " + loc_cEmp
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, ChaveRegistro, Operacao, Usuario, DataHora, DadosNovos) " + ;
                       "VALUES (" + EscaparSQL("SigMvCcr") + ", " + ;
                                    EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                                    EscaparSQL(LEFT(par_cOperacao, 10)) + ", " + ;
                                    EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50)) + ", " + ;
                                    "GETDATE(), " + ;
                                    EscaparSQL(loc_cObs) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha em auditoria nao deve abortar a operacao principal
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Aviso")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor MovAux (chamado no Load do form)
    * MovAux preserva nome legado (usado no COPY TO por nome e no INDEX)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        SET SAFETY OFF
        IF USED("MovAux")
            USE IN MovAux
        ENDIF
        CREATE CURSOR MovAux (AnoFis C(4), Datas C(8), Contas C(9), Debs C(12), ;
                              Creds C(12), Docto C(10), Hists C(70), EmpCont C(3))
        INDEX ON EmpCont + Datas TAG EmpCont
        SET ORDER TO ("") IN ("movaux")
        SET SAFETY ON
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracao - Carrega DirContabv de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DirContabv FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cDirContab = RTRIM(NVL(DirContabv, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o (SigCdPam).", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarIntegracao - Logica principal do legado (PROCEDURE processamento)
    * Queries SigMvCcr, busca ContAb em SigCdGcr/SigCdCli, monta MovAux e SemConta.
    * Cursores SemConta e Cabecalho ficam abertos para o FRX SigPrIct.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarIntegracao()
        LOCAL loc_lResultado, loc_cSQL, loc_cEmp1, loc_cFiltroEmp, loc_oProgresso
        LOCAL loc_cContabs, loc_nNcont, loc_cAnofis, loc_cDataStr, loc_cDataFim
        LOCAL loc_nDebs, loc_nCreds, loc_cDebs, loc_cCreds, loc_cDocto, loc_cHists
        LOCAL loc_cRazas, loc_cSQLCli, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_lProcessado         = .F.
            THIS.this_lTemInconsistencias = .F.

            loc_cEmp1 = RTRIM(THIS.this_cEmpresa)

            *-- Grupos de conta corrente (SigCdGcr)
            loc_cSQL = "SELECT Codigos, ContConts FROM SigCdGcr"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gcr") > 0
                SELECT cursor_4c_Gcr
                INDEX ON Codigos TAG Codigos

                *-- Todas as empresas (SigCdEmp)
                loc_cSQL = "SELECT Cemps FROM SigCdEmp"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpAll") > 0
                    SELECT cursor_4c_EmpAll
                    INDEX ON Cemps TAG Cemps

                    *-- Movimentos SigMvCcr filtrado por periodo e empresa
                    loc_cFiltroEmp = IIF(EMPTY(loc_cEmp1), "", " AND Emps = " + EscaparSQL(loc_cEmp1))
                    loc_cDataFim   = "'" + SUBSTR(DTOS(THIS.this_dDataFim), 1, 4) + "-" + ;
                                     SUBSTR(DTOS(THIS.this_dDataFim), 5, 2) + "-" + ;
                                     SUBSTR(DTOS(THIS.this_dDataFim), 7, 2) + " 23:59:59'"
                    loc_cSQL = "SELECT Emps, Grupos, Contas, Datas, Hists, Hist2s, Valors, Opers, Autos " + ;
                               "FROM SigMvCcr " + ;
                               "WHERE Datas BETWEEN " + FormatarDataSQL(THIS.this_dDataIni) + ;
                               " AND " + loc_cDataFim + loc_cFiltroEmp

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mv") > 0

                        *-- Cabecalho para FRX SigPrIct (nome preservado do legado)
                        loc_cSQL   = "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                        loc_cRazas = ""
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpNome") > 0
                            IF USED("cursor_4c_EmpNome") AND !EOF("cursor_4c_EmpNome")
                                SELECT cursor_4c_EmpNome
                                loc_cRazas = RTRIM(NVL(Razas, ""))
                            ENDIF
                            IF USED("cursor_4c_EmpNome")
                                USE IN cursor_4c_EmpNome
                            ENDIF
                        ENDIF
                        IF USED("Cabecalho")
                            USE IN Cabecalho
                        ENDIF
                        CREATE CURSOR Cabecalho (Empresa C(80), Titulo C(80), SubTit C(80), Periodo C(80))
                        INSERT INTO Cabecalho (Empresa, Titulo, SubTit, Periodo) ;
                            VALUES (go_4c_Sistema.cCodEmpresa + " - " + loc_cRazas, ;
                                    "Relat" + CHR(243) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil", ;
                                    "Contas Financeiras sem Conta Cont" + CHR(225) + "bil Cadastrada", ;
                                    "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + " " + CHR(225) + " " + DTOC(THIS.this_dDataFim))

                        *-- Cursor SemConta (inconsistencias) - nome preservado para FRX
                        IF USED("SemConta")
                            USE IN SemConta
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR SemConta (Contas C(9) NULL, Datas D NULL, Hists C(70) NULL, ;
                                                Valors N(12,2) NULL, Ocors C(40) NULL)
                        SET NULL OFF
                        INDEX ON Contas + DTOS(Datas) TAG Conta

                        *-- Limpa resultado anterior
                        ZAP IN MovAux

                        *-- Processa cada movimento
                        loc_nNcont = 0
                        SELECT cursor_4c_Mv
                        loc_oProgresso = CREATEOBJECT("fwprogressbar", "Processando Dados...", RECCOUNT())
                        loc_oProgresso.Show()

                        SCAN
                            loc_oProgresso.Update(.T.)
                            loc_nNcont = loc_nNcont + 1
                            loc_cContabs = ""

                            *-- Busca conta contabil via grupo
                            IF SEEK(cursor_4c_Mv.Grupos, "cursor_4c_Gcr", "Codigos")
                                IF !EMPTY(cursor_4c_Gcr.ContConts)
                                    loc_cContabs = RTRIM(cursor_4c_Gcr.ContConts)
                                ENDIF
                            ENDIF
                            SELECT cursor_4c_Mv

                            *-- Se grupo nao tem ContAb, busca no cliente (SigCdCli.CContabs)
                            IF EMPTY(loc_cContabs)
                                loc_cSQLCli = "SELECT TOP 1 IClis, CContabs FROM SigCdCli WHERE IClis = " + ;
                                             EscaparSQL(cursor_4c_Mv.Contas)
                                IF SQLEXEC(gnConnHandle, loc_cSQLCli, "cursor_4c_Cli") > 0
                                    IF USED("cursor_4c_Cli") AND !EOF("cursor_4c_Cli")
                                        SELECT cursor_4c_Cli
                                        IF !EMPTY(CContabs)
                                            loc_cContabs = RTRIM(CContabs)
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_Cli")
                                        USE IN cursor_4c_Cli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Mv
                            ENDIF

                            *-- Sem ContAb: usa propria conta e registra inconsistencia
                            IF EMPTY(loc_cContabs)
                                loc_cContabs = RTRIM(NVL(cursor_4c_Mv.Contas, ""))

                                SELECT SemConta
                                APPEND BLANK
                                REPLACE Contas WITH RTRIM(NVL(cursor_4c_Mv.Contas, "")), ;
                                        Datas  WITH NVL(cursor_4c_Mv.Datas, {}), ;
                                        Hists  WITH LEFT(RTRIM(NVL(cursor_4c_Mv.Hists, "")) + ;
                                                        RTRIM(NVL(cursor_4c_Mv.Hist2s, "")), 70), ;
                                        Valors WITH NVL(cursor_4c_Mv.Valors, 0)
                                SELECT cursor_4c_Mv
                            ENDIF

                            *-- Debito ou Credito
                            IF RTRIM(NVL(cursor_4c_Mv.Opers, "")) = "D"
                                loc_nDebs  = NVL(cursor_4c_Mv.Valors, 0)
                                loc_nCreds = 0
                            ELSE
                                loc_nDebs  = 0
                                loc_nCreds = NVL(cursor_4c_Mv.Valors, 0)
                            ENDIF

                            *-- Formata campos para MovAux (layout contabil SDF)
                            loc_cAnofis  = STR(YEAR(NVL(cursor_4c_Mv.Datas, DATE())), 4)
                            loc_cDataStr = STRTRAN(DTOC(NVL(cursor_4c_Mv.Datas, DATE())), "/", "")
                            loc_cDebs    = TRANSFORM(loc_nDebs  * 100, "@L 999999999999")
                            loc_cCreds   = TRANSFORM(loc_nCreds * 100, "@L 999999999999")
                            loc_cHists   = SUBSTR(RTRIM(NVL(cursor_4c_Mv.Hists, "")) + ;
                                                  RTRIM(NVL(cursor_4c_Mv.Hist2s, "")), 1, 70)
                            loc_cHists   = STRTRAN(loc_cHists, CHR(1),  "")
                            loc_cHists   = STRTRAN(loc_cHists, CHR(13), "")
                            loc_cHists   = STRTRAN(loc_cHists, CHR(10), "")

                            IF NVL(cursor_4c_Mv.Autos, .F.) AND "LOTE" $ loc_cHists
                                loc_cDocto = TRANSFORM(VAL(RIGHT(ALLTRIM(loc_cHists), 6)), "@L 999999")
                            ELSE
                                loc_cDocto = TRANSFORM(loc_nNcont, "@L 999999")
                            ENDIF

                            SELECT MovAux
                            APPEND BLANK
                            REPLACE AnoFis  WITH loc_cAnofis, ;
                                    Datas   WITH loc_cDataStr, ;
                                    Contas  WITH loc_cContabs, ;
                                    Debs    WITH loc_cDebs, ;
                                    Creds   WITH loc_cCreds, ;
                                    Docto   WITH loc_cDocto, ;
                                    Hists   WITH loc_cHists, ;
                                    EmpCont WITH RTRIM(NVL(cursor_4c_Mv.Emps, ""))

                            SELECT cursor_4c_Mv
                        ENDSCAN

                        loc_oProgresso.Complete(.T.)

                        *-- Verifica inconsistencias
                        SELECT SemConta
                        SET ORDER TO ("conta") IN ("semconta")
                        GO TOP
                        THIS.this_lTemInconsistencias = !EOF("SemConta")

                        THIS.this_lProcessado = .T.
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Falha na conex" + CHR(227) + "o (SigMvCcr).", "Erro")
                    ENDIF
                ELSE
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdEmp).", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha na conex" + CHR(227) + "o (SigCdGcr).", "Erro")
            ENDIF

            *-- Limpa cursores temporarios (SemConta e Cabecalho ficam abertos para FRX)
            IF USED("cursor_4c_Gcr")
                USE IN cursor_4c_Gcr
            ENDIF
            IF USED("cursor_4c_EmpAll")
                USE IN cursor_4c_EmpAll
            ENDIF
            IF USED("cursor_4c_Mv")
                USE IN cursor_4c_Mv
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarArquivos - Gera arquivos contabeis SDF em DirContabv
    * Logica do legado: PROCEDURE gravar - agrupa MovAux por EmpCont, COPY TO SDF
    *--------------------------------------------------------------------------
    PROCEDURE GravarArquivos()
        LOCAL loc_lResultado, loc_cNomeAux, loc_cEmpProc, loc_cNumAux, loc_oErro
        loc_lResultado = .F.
        TRY
            IF EMPTY(THIS.this_cDirContab)
                MsgErro("Diret" + CHR(243) + "rio cont" + CHR(225) + "bil n" + CHR(227) + "o configurado (SigCdPam.DirContabv).", "Erro")
            ELSE
                IF !USED("MovAux") OR RECCOUNT("MovAux") = 0
                MsgAviso("N" + CHR(227) + "o existe movimenta" + CHR(231) + CHR(227) + "o no per" + CHR(237) + "odo.")
            ELSE
                SET SAFETY OFF
                SELECT MovAux
                SET ORDER TO EmpCont
                GO TOP

                SCAN
                    loc_cNumAux  = SUBSTR(SYS(3), 3)
                    loc_cNomeAux = ADDBS(ALLTRIM(THIS.this_cDirContab)) + "CT" + loc_cNumAux + "." + MovAux.EmpCont

                    IF !FILE(loc_cNomeAux)
                        loc_cEmpProc = MovAux.EmpCont
                        COPY TO &loc_cNomeAux. WHILE loc_cEmpProc = MovAux.EmpCont TYPE SDF
                        SKIP -1
                    ENDIF
                ENDSCAN

                SET ORDER TO ("") IN ("movaux")
                SET SAFETY ON
                loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
