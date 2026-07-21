*====================================================================
* sigproefBO.prg
* Business Object para Selecao de Transacao TEF (sigproef)
* Tabela principal: SigOpFp | Chave: Fpags
*====================================================================

DEFINE CLASS sigproefBO AS BusinessBase

    *-- ===================================================================
    *-- IDENTIFICACAO DA ENTIDADE
    *-- ===================================================================
    this_cTabela     = "SigOpFp"
    this_cCampoChave = "Fpags"

    *-- ===================================================================
    *-- CONFIGURACAO DE HARDWARE - SigCdPam
    *-- ===================================================================
    this_nNcChequeps = 0
    this_nSistef     = 0
    this_cNumIps     = ""

    *-- ===================================================================
    *-- CONFIGURACAO DO SISTEMA - SigCdPac
    *-- ===================================================================
    this_cVerSitefs  = ""

    *-- ===================================================================
    *-- IMPRESSORA FISCAL - SIGFIMPF
    *-- ===================================================================
    this_cCImpFabs   = ""
    this_cCnCaixas   = ""

    *-- ===================================================================
    *-- ESTADO OPERACIONAL DO FORM
    *-- ===================================================================
    this_cOperacao   = ""
    this_cNoCaixa    = ""
    this_cNoFab      = ""
    this_lCancelaVisivel = .F.

    *-- ===================================================================
    *-- FILTRO DE PERIODO
    *-- ===================================================================
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *-- ===================================================================
    *-- PAGAMENTO FP - SigOpFp (campos usados pelo form)
    *-- ===================================================================
    this_cCodEstabs   = ""

    *-- ===================================================================
    *-- TRANSACAO CORRENTE (campos do cursor Transacao)
    *-- ===================================================================
    this_cDopes       = ""
    this_cCnCupoms    = ""
    this_cCCupomNvs   = ""
    this_cCnNsus      = ""
    this_nCnValors    = 0
    this_dCnDtTrans   = {}
    this_cCnHrTrans   = ""
    this_cStatus      = ""
    this_cFPags       = ""
    this_lCancel      = .F.
    this_nCupFis      = 0
    this_cEmpDopNums  = ""
    this_cCnIdents    = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigOpFp"
            THIS.this_cCampoChave = "Fpags"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarConfiguracao - Carrega SigCdPam e SigCdPac em cursores
    * Chamado pelo form apos conexao estabelecida
    *====================================================================
    PROCEDURE CarregarConfiguracao()
        LOCAL loc_lResultado, loc_nRes
        loc_lResultado = .F.

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT ncchequeps, Sistef, NumIps FROM SigCdPam", ;
                "crSigCdPam")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPam"
                loc_lResultado = .F.
            ENDIF

            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT VerSitefs FROM SigCdPac", ;
                "crSigCdPac")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao carregar SigCdPac"
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                THIS.this_nNcChequeps = NVL(ncchequeps, 0)
                THIS.this_nSistef     = NVL(Sistef, 0)
                THIS.this_cNumIps     = ALLTRIM(NVL(NumIps, ""))
            ENDIF

            IF USED("crSigCdPac")
                SELECT crSigCdPac
                GO TOP
                THIS.this_cVerSitefs  = ALLTRIM(NVL(VerSitefs, ""))
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarImpressoraFiscal - Carrega SIGFIMPF pelo numero de fabricacao
    * par_cNoFab: numero de fabricacao da impressora (cImpFabs)
    *====================================================================
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cImpFabs, CnCaixas FROM SIGFIMPF"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF")

            IF loc_nRes >= 0 AND USED("crSigFiMpF")
                SELECT crSigFiMpF
                IF !EOF()
                    THIS.this_cCImpFabs = ALLTRIM(NVL(cImpFabs, ""))
                    THIS.this_cCnCaixas = ALLTRIM(NVL(CnCaixas, ""))
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Impressora Fiscal inv" + CHR(225) + "lida para esta Loja"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar impressora fiscal"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarTransacoes - Busca transacoes TEF no periodo informado
    * Equivalente ao metodo SqlTrans do form original
    * Popula cursor "Transacao" com os dados formatados
    *====================================================================
    PROCEDURE BuscarTransacoes(par_dDataInicial, par_dDataFinal)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        LOCAL loc_cDtI, loc_cDtF, loc_cDtISQL, loc_cDtFSQL
        loc_lResultado = .F.

        TRY
            THIS.this_dDataInicial = par_dDataInicial
            THIS.this_dDataFinal   = par_dDataFinal

            loc_cDtI    = DTOS(par_dDataInicial)
            loc_cDtF    = DTOS(par_dDataFinal)
            loc_cDtISQL = FormatarDataSQL(par_dDataInicial)
            loc_cDtFSQL = FormatarDataSQL(par_dDataFinal)

            loc_cSQL = "SELECT DISTINCT a.Cemps, a.cDopes, a.cncupoms, a.cnIdents, " + ;
                       "a.cCupomNvs, a.cNnsus, a.cNValors, a.cnDtTrans, " + ;
                       "a.CnHrTrans, a.cStatus, a.FPags " + ;
                       "FROM SigFiTef a " + ;
                       "WHERE cndttransI BETWEEN " + EscaparSQL(loc_cDtI) + " AND " + EscaparSQL(loc_cDtF) + " " + ;
                       "AND a.ctipos = 'R' " + ;
                       "AND (a.cHeaders = 'CRT' OR a.cHeaders = 'CHQ') " + ;
                       "AND NOT a.cnnsus = '   ' " + ;
                       "ORDER BY a.cnDtTrans, a.CnHrTrans"

            IF USED("Selecao")
                USE IN Selecao
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar transa" + CHR(231) + CHR(245) + "es TEF"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Notas, b.CupFis " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE a.Datas BETWEEN " + loc_cDtISQL + " AND " + loc_cDtFSQL + " " + ;
                       "AND a.dopes = b.dopes " + ;
                       "AND b.Cupfis IN (1, 3)"

            IF USED("Selecao2")
                USE IN Selecao2
            ENDIF
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "Selecao2")
            IF loc_nRes < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cupom"
                loc_lResultado = .F.
            ENDIF

            SELECT Selecao2
            INDEX ON EmpDopNums TAG EmpDopNums

            IF USED("Transacao")
                USE IN Transacao
            ENDIF
            CREATE CURSOR Transacao ( ;
                cDopes      C(20), ;
                cnCupoms    C(10), ;
                cCupomNvs   C(20), ;
                cnnsus      C(12), ;
                cnValors    N(12,2), ;
                cnDtTrans   D, ;
                CnHrTrans   C(8), ;
                cStatus     C(3), ;
                FPags       C(12), ;
                lCancel     L, ;
                CupFis      N(1), ;
                EmpDopNums  C(29), ;
                cnIdents    C(10) ;
            )
            INDEX ON cnDtTrans TAG Datas

            SELECT Selecao
            SCAN
                SCATTER MEMVAR
                m.CnHrTrans = TRANSFORM(m.CnHrTrans, "@R xx:xx:xx")
                m.CnValors  = ROUND(VAL(STRTRAN(m.cnValors, ',', '')) / 100, 2)
                m.CnDtTrans = CTOD(SUBSTR(m.CnDtTrans, 1, 2) + '/' + ;
                              SUBSTR(m.CnDtTrans, 3, 2) + '/' + ;
                              RIGHT(m.CnDtTrans, 4))

                =SEEK(m.Cemps + PADR(m.Cdopes, 20) + STR(VAL(m.cncupoms), 6), 'Selecao2')

                IF !EOF('Selecao2')
                    m.cnCupoms   = Selecao2.Notas
                    m.CupFis     = Selecao2.CupFis
                    m.EmpDopNums = Selecao2.EmpDopNums
                ELSE
                    m.cnCupoms   = ""
                    m.CupFis     = 0
                    m.EmpDopNums = ""
                ENDIF

                SELECT Transacao
                APPEND BLANK
                GATHER MEMVAR
                REPLACE cnnsus   WITH SUBSTR(cnnsus, 1, 12)
                REPLACE lCancel  WITH IIF(cStatus = "CNC", .T., .F.)
            ENDSCAN

            SELECT Transacao
            GO BOTTOM

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPagamentoFP - Carrega dados de SigOpFp para transacao corrente
    * par_cFPags: chave Fpags da transacao
    *====================================================================
    PROCEDURE CarregarPagamentoFP(par_cFPags)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF USED("csSigOpFp")
                USE IN csSigOpFp
            ENDIF

            loc_cSQL = "SELECT * FROM SigOpFp WHERE Fpags = " + EscaparSQL(par_cFPags)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "csSigOpFp")

            IF loc_nRes >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar pagamento"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CancelarTransacao - Cancela transacao TEF selecionada
    * Atualiza SigFiTef e SigMvPar
    * par_cCnNsus:     NSU da transacao
    * par_cEmpDopNums: chave EmpDopNums para SigMvPar
    * par_cCnIdents:   identidade da transacao em SigMvPar
    *====================================================================
    PROCEDURE CancelarTransacao(par_cCnNsus, par_cEmpDopNums, par_cCnIdents)
        LOCAL loc_lResultado, loc_nRes, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = 'CNC', " + ;
                       "UsuCancs = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                       "WHERE ctipos = 'R' AND cHeaders = 'CRT' " + ;
                       "AND CNNSUS = " + EscaparSQL(ALLTRIM(par_cCnNsus))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes > 0
                loc_cSQL = "SELECT EmpDopNums, Valos, CnIdTefs, cidChaves " + ;
                           "FROM SigMvPar WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

                IF USED("LocalPar")
                    USE IN LocalPar
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "LocalPar")

                SELECT LocalPar
                LOCATE FOR CnIdTefs = par_cCnIdents
                IF !EOF() AND loc_nRes > 0
                    loc_cSQL = "UPDATE SigMvPar SET lCancelas = 1 " + ;
                               "WHERE CidChaves = " + EscaparSQL(LocalPar.Cidchaves)
                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                IF loc_nRes > 0
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar SigMvPar"
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao cancelar em SigFiTef"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarTransacaoCorrente - Preenche this_* com dados da linha do grid
    * par_cAlias: alias do cursor Transacao (normalmente "Transacao")
    *====================================================================
    PROCEDURE CarregarTransacaoCorrente(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cDopes      = ALLTRIM(NVL(cDopes, ""))
            THIS.this_cCnCupoms   = ALLTRIM(NVL(cnCupoms, ""))
            THIS.this_cCCupomNvs  = ALLTRIM(NVL(cCupomNvs, ""))
            THIS.this_cCnNsus     = ALLTRIM(NVL(cnnsus, ""))
            THIS.this_nCnValors   = NVL(cnValors, 0)
            THIS.this_dCnDtTrans  = NVL(cnDtTrans, {})
            THIS.this_cCnHrTrans  = ALLTRIM(NVL(CnHrTrans, ""))
            THIS.this_cStatus     = ALLTRIM(NVL(cStatus, ""))
            THIS.this_cFPags      = ALLTRIM(NVL(FPags, ""))
            THIS.this_lCancel     = NVL(lCancel, .F.)
            THIS.this_nCupFis     = NVL(CupFis, 0)
            THIS.this_cEmpDopNums = ALLTRIM(NVL(EmpDopNums, ""))
            THIS.this_cCnIdents   = ALLTRIM(NVL(cnIdents, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega campos de SigOpFp nas propriedades this_*
    * par_cAliasCursor: alias do cursor com dados de SigOpFp (ex: csSigOpFp)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            THIS.this_cFPags     = ALLTRIM(NVL(Fpags, ""))
            THIS.this_cCodEstabs = ALLTRIM(NVL(CodEstabs, ""))

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDPROC

    *====================================================================
    * Inserir - Insere transacao no cursor local Transacao
    * Usado para registrar transacoes TEF processadas pelo form
    * Preenche todos os campos usando as propriedades this_*
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cValFmt
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                CREATE CURSOR Transacao ( ;
                    cDopes      C(20), ;
                    cnCupoms    C(10), ;
                    cCupomNvs   C(20), ;
                    cnnsus      C(12), ;
                    cnValors    N(12,2), ;
                    cnDtTrans   D, ;
                    CnHrTrans   C(8), ;
                    cStatus     C(3), ;
                    FPags       C(12), ;
                    lCancel     L, ;
                    CupFis      N(1), ;
                    EmpDopNums  C(29), ;
                    cnIdents    C(10) ;
                )
                INDEX ON cnDtTrans TAG Datas
            ENDIF

            SELECT Transacao
            APPEND BLANK
            REPLACE cDopes      WITH THIS.this_cDopes, ;
                    cnCupoms    WITH THIS.this_cCnCupoms, ;
                    cCupomNvs   WITH THIS.this_cCCupomNvs, ;
                    cnnsus      WITH THIS.this_cCnNsus, ;
                    cnValors    WITH THIS.this_nCnValors, ;
                    cnDtTrans   WITH THIS.this_dCnDtTrans, ;
                    CnHrTrans   WITH THIS.this_cCnHrTrans, ;
                    cStatus     WITH THIS.this_cStatus, ;
                    FPags       WITH THIS.this_cFPags, ;
                    lCancel     WITH THIS.this_lCancel, ;
                    CupFis      WITH THIS.this_nCupFis, ;
                    EmpDopNums  WITH THIS.this_cEmpDopNums, ;
                    cnIdents    WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("INSERT")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza transacao no cursor local Transacao
    * Localiza pela chave FPags e atualiza campos mutaveis
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento (Fpags) obrigat" + CHR(243) + "ria"
                loc_lResultado = .F.
            ENDIF

            IF !USED("Transacao")
                THIS.this_cMensagemErro = "Cursor Transacao n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lResultado = .F.
            ENDIF

            SELECT Transacao
            LOCATE FOR ALLTRIM(FPags) == ALLTRIM(THIS.this_cFPags) ;
                       AND ALLTRIM(cnnsus) == ALLTRIM(THIS.this_cCnNsus)

            IF !FOUND()
                THIS.this_cMensagemErro = "Transa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada"
                loc_lResultado = .F.
            ENDIF

            REPLACE cStatus    WITH THIS.this_cStatus, ;
                    lCancel    WITH THIS.this_lCancel, ;
                    cnValors   WITH THIS.this_nCnValors, ;
                    CnHrTrans  WITH THIS.this_cCnHrTrans, ;
                    CupFis     WITH THIS.this_nCupFis, ;
                    EmpDopNums WITH THIS.this_cEmpDopNums, ;
                    cnIdents   WITH THIS.this_cCnIdents

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar transa" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
