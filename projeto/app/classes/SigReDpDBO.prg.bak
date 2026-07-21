*==============================================================================
* SIGREDPDBO.PRG
* BO para relatorio de analise de producao por dopps (SigReDpD)
*
* Herda de RelatorioBase
* Carrega cursores de referencia para lookups e processamento do relatorio
*==============================================================================

DEFINE CLASS SigReDpDBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro movimentacao / DopPs
    this_cDopp            = ""
    this_nNumes           = 0

    *-- Filtro grupo balancete (SigCdGcr.Codigos / Descrs)
    this_cGrupoGcr        = ""
    this_cDGrupoGcr       = ""

    *-- Filtro conta balancete (SigCdCli.IClis / RClis)
    this_cCodConta        = ""
    this_cNomeConta       = ""

    *-- Filtro cliente producao (SigCdCli.IClis / RClis) - get_codcli/get_desccli
    this_cCodCli          = ""
    this_cDescCli         = ""

    *-- Filtro grupo materia prima (SigCdGrp.CGrus / DGrus)
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro grande grupo (SigCdGpr.Codigos / Descs)
    this_cGgrp            = ""
    this_cDGgrp           = ""

    *-- Filtro tipo operacao (SigOpOpt.Cods)
    this_cTpOps           = ""

    *-- Filtro envelope e numero de OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro tipo geracao OP (SigInTgo.Codigos) - auto-preenchido se apenas 1 opcao
    this_cTpGOp           = ""

    *-- Flags de impressao (correspondem aos checkboxes do form)
    this_lImprimeTpMat    = .F.
    this_lAnalisarDestino = .F.
    this_lImprimeDopes    = .F.
    this_lDetalhar        = .F.
    this_lImprimeValor    = .F.
    this_lImprimeProdutos = .F.
    this_lImprimeFuncs    = .F.
    this_lRelatorio       = .F.
    this_lImprimeQtdPes   = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de referencia para lookups e processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Grupos de balancete (lookup Get_grupo / get_dgrupo)
                IF USED("CrSigCdGcr")
                    USE IN CrSigCdGcr
                ENDIF
                loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGcr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de balancete"
                    EXIT
                ENDIF
                SELECT CrSigCdGcr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                *-- Tipos de operacao (lookup Get_TpOps)
                IF USED("CrSigOpOpt")
                    USE IN CrSigOpOpt
                ENDIF
                loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt " + ;
                           "WHERE Situas < 2 AND (Emps = ' ' OR Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpOpt")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                        CHR(231) + CHR(227) + "o"
                    EXIT
                ENDIF
                SELECT CrSigOpOpt
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs

                *-- Clientes de balancete (lookup Get_conta / Get_dconta / get_codcli)
                IF USED("CrSigCdCli")
                    USE IN CrSigCdCli
                ENDIF
                loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCli")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes"
                    EXIT
                ENDIF
                SELECT CrSigCdCli
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome

                *-- Parametros SigCdPam (GrTrans filtra grupo transito no processamento)
                IF USED("CrSigCdPam")
                    USE IN CrSigCdPam
                ENDIF
                loc_cSQL = "SELECT GrTrans FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPam")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                    EXIT
                ENDIF
                SELECT CrSigCdPam
                GO TOP

                *-- Tipos de geracao OP com filtro de acesso do usuario (SigInTgo)
                IF USED("cursor_4c_TmpTpGop")
                    USE IN cursor_4c_TmpTpGop
                ENDIF
                loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGop")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de gera" + ;
                        CHR(231) + CHR(227) + "o OP"
                    EXIT
                ENDIF
                THIS.FiltrarAcessosTpGop()

                *-- Operacoes de producao com filtro de acesso (SigCdOpd)
                *-- INDEX criado ANTES do filtro (replicando ordem do legado)
                IF USED("CsSigCdOpd")
                    USE IN CsSigCdOpd
                ENDIF
                loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCdOpd")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF
                SELECT CsSigCdOpd
                INDEX ON Dopps TAG Dopps
                THIS.FiltrarAcessosOperacoes()
                SELECT CsSigCdOpd
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Init")
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosTpGop - Filtra tipos de geracao OP por acesso do usuario
    * Replica: fChecaAcesso('SIGPRGLOT', Codigos) do legado
    * Se apenas 1 tipo com acesso, pre-preenche this_cTpGOp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosTpGop()
        LOCAL loc_oErro

        TRY
            SELECT cursor_4c_TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(cursor_4c_TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN cursor_4c_TmpTpGop
                ENDIF
            ENDSCAN

            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM cursor_4c_TmpTpGop WHERE Acesso = 1 ;
                INTO CURSOR CrTmpTpGop READWRITE
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            IF RECCOUNT("CrTmpTpGop") = 1
                SELECT CrTmpTpGop
                GO TOP
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            IF USED("cursor_4c_TmpTpGop")
                USE IN cursor_4c_TmpTpGop
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosTpGop")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosOperacoes - Remove operacoes sem acesso do usuario
    * Replica: fChecaAcesso('P'+padl(ndopps,8,'0')) do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosOperacoes()
        LOCAL loc_oErro

        TRY
            SELECT CsSigCdOpd
            SCAN
                IF !fChecaAcesso("P" + PADL(CsSigCdOpd.ndopps, 8, "0"))
                    DELETE
                ENDIF
            ENDSCAN
            SELECT CsSigCdOpd
            GO TOP

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CrSigOpOpt")
            USE IN CrSigOpOpt
        ENDIF
        IF USED("CrSigCdCli")
            USE IN CrSigCdCli
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrTmpTpGop")
            USE IN CrTmpTpGop
        ENDIF
        IF USED("CsSigCdOpd")
            USE IN CsSigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpTpGop")
            USE IN cursor_4c_TmpTpGop
        ENDIF
        THIS.LimparCursoresTemp()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao dos filtros para auditoria
    *
    * Relatorio nao possui chave primaria de registro. Esta funcao monta
    * uma "chave" concatenando os principais filtros aplicados, usada
    * pelo log de auditoria para identificar qual configuracao foi executada.
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = "DT=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cGrupoGcr)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "GRP=" + ALLTRIM(THIS.this_cGrupoGcr)
        ENDIF
        IF !EMPTY(THIS.this_cCodConta)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "CTA=" + ALLTRIM(THIS.this_cCodConta)
        ENDIF
        IF !EMPTY(THIS.this_cDopp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "DOPP=" + ALLTRIM(THIS.this_cDopp)
        ENDIF
        IF !EMPTY(THIS.this_cTpGOp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "TGOP=" + ALLTRIM(THIS.this_cTpGOp)
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente persistida
    * (ex: historico de execucoes). Mapeia colunas do cursor para as
    * propriedades this_* deste BO, validando tipos antes de atribuir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("DtInicial") = "D"
                    THIS.this_dDtInicial = NVL(EVALUATE("DtInicial"), {})
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                IF TYPE("Dopp") = "C"
                    THIS.this_cDopp = ALLTRIM(NVL(EVALUATE("Dopp"), ""))
                ENDIF
                IF TYPE("Numes") = "N"
                    THIS.this_nNumes = NVL(EVALUATE("Numes"), 0)
                ENDIF
                IF TYPE("GrupoGcr") = "C"
                    THIS.this_cGrupoGcr = ALLTRIM(NVL(EVALUATE("GrupoGcr"), ""))
                ENDIF
                IF TYPE("CodConta") = "C"
                    THIS.this_cCodConta = ALLTRIM(NVL(EVALUATE("CodConta"), ""))
                ENDIF
                IF TYPE("CodCli") = "C"
                    THIS.this_cCodCli = ALLTRIM(NVL(EVALUATE("CodCli"), ""))
                ENDIF
                IF TYPE("CGru") = "C"
                    THIS.this_cCGru = ALLTRIM(NVL(EVALUATE("CGru"), ""))
                ENDIF
                IF TYPE("Ggrp") = "C"
                    THIS.this_cGgrp = ALLTRIM(NVL(EVALUATE("Ggrp"), ""))
                ENDIF
                IF TYPE("TpOps") = "C"
                    THIS.this_cTpOps = ALLTRIM(NVL(EVALUATE("TpOps"), ""))
                ENDIF
                IF TYPE("Envelope") = "N"
                    THIS.this_nEnvelope = NVL(EVALUATE("Envelope"), 0)
                ENDIF
                IF TYPE("Nop") = "N"
                    THIS.this_nNop = NVL(EVALUATE("Nop"), 0)
                ENDIF
                IF TYPE("TpGOp") = "C"
                    THIS.this_cTpGOp = ALLTRIM(NVL(EVALUATE("TpGOp"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio para rastreabilidade
    * de quem executou o relatorio de Analise de Producao por DopPs e com
    * quais filtros (datas, grupos, contas, dopp, tipo geracao OP).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL("SigReDpD") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio An" + CHR(225) + ;
                                  "lise Produ" + CHR(231) + CHR(227) + "o por DopPs") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX conforme opcoes selecionadas
    * Replica logica de selecao dos 8 relatorios (SigReDp1 a SigReDp8)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cFRX
        IF THIS.this_lDetalhar
            IF THIS.this_lImprimeValor
                IF THIS.this_lRelatorio
                    loc_cFRX = "SigReDp7"
                ELSE
                    loc_cFRX = "SigReDp6"
                ENDIF
            ELSE
                IF THIS.this_lImprimeProdutos
                    loc_cFRX = "SigReDp5"
                ELSE
                    loc_cFRX = "SigReDp1"
                ENDIF
            ENDIF
        ELSE
            IF THIS.this_lImprimeDopes
                loc_cFRX = "SigReDp2"
            ELSE
                IF THIS.this_lImprimeValor
                    loc_cFRX = "SigReDp4"
                ELSE
                    IF THIS.this_lImprimeQtdPes
                        loc_cFRX = "SigReDp8"
                    ELSE
                        loc_cFRX = "SigReDp3"
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursoresTemp - Fecha cursores temporarios criados em PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresTemp()
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        IF USED("CrSigCdNec")
            USE IN CrSigCdNec
        ENDIF
        IF USED("csLocalMc")
            USE IN csLocalMc
        ENDIF
        IF USED("crEnvelope")
            USE IN crEnvelope
        ENDIF
        IF USED("LocalCli")
            USE IN LocalCli
        ENDIF
        IF USED("LocalPro")
            USE IN LocalPro
        ENDIF
        IF USED("CrTmpCli")
            USE IN CrTmpCli
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentacoes e monta TmpRelat para relatorio
    * Replica: PROCEDURE processamento do legado (SIGREDPD)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp
        LOCAL loc_dDatai, loc_dDataf, loc_cDataFimSQL
        LOCAL loc_cDopp, loc_nNumes
        LOCAL loc_lImprimeTpMat, loc_lDestino
        LOCAL loc_cTpOpt, loc_lDope, loc_lDopeDt
        LOCAL loc_nEnvelope, loc_nOp, loc_nOpI, loc_nOpF
        LOCAL loc_cCodCli, loc_cTGOp
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv
        LOCAL loc_cPro, loc_cDpr
        LOCAL loc_lAbortarScan

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                THIS.this_cMensagemErro = ""
                THIS.LimparCursoresTemp()

                *-- Capturar valores dos filtros das propriedades
                loc_cGrupo        = ALLTRIM(THIS.this_cGrupoGcr)
                loc_cConta        = ALLTRIM(THIS.this_cCodConta)
                loc_cGruMat       = ALLTRIM(THIS.this_cCGru)
                loc_cGgrp         = ALLTRIM(THIS.this_cGgrp)
                loc_dDatai        = THIS.this_dDtInicial
                loc_dDataf        = THIS.this_dDtFinal
                loc_cDopp         = ALLTRIM(THIS.this_cDopp)
                loc_nNumes        = THIS.this_nNumes
                loc_lImprimeTpMat = THIS.this_lImprimeTpMat
                loc_lDestino      = THIS.this_lAnalisarDestino
                loc_cTpOpt        = ALLTRIM(THIS.this_cTpOps)
                loc_lDope         = THIS.this_lImprimeDopes
                loc_lDopeDt       = THIS.this_lDetalhar
                loc_nEnvelope     = THIS.this_nEnvelope
                loc_nOp           = THIS.this_nNop
                loc_nOpI          = (loc_nOp * 10000) + 1
                loc_nOpF          = (loc_nOp * 10000) + 9999
                loc_cCodCli       = ALLTRIM(THIS.this_cCodCli)
                loc_cTGOp         = ALLTRIM(THIS.this_cTpGOp)

                *-- Data final com 23:59:59 para cobrir todo o dia (replica fDtoSQL do legado)
                loc_cDataFimSQL = "'" + ;
                    PADL(YEAR(loc_dDataf),  4, "0") + "-" + ;
                    PADL(MONTH(loc_dDataf), 2, "0") + "-" + ;
                    PADL(DAY(loc_dDataf),   2, "0") + " 23:59:59'"

                *-- Criar cursor de resultado do processamento
                CREATE CURSOR TmpRelat (;
                    Fase c(10), IClis c(10), RClis c(50), CMats c(14), ;
                    DPros c(40), CPros c(14), DDPros c(40), Qtde n(12,3), ;
                    TpOps c(15), CUnis c(3), Operacaos c(31), Nenvs n(10), ;
                    Datas D, Pesos n(12,3), Valor n(12,2), Fators n(12,3), ;
                    Peso2s n(12,3), CUniPs c(3))
                INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats ;
                    TAG Operacao
                INDEX ON Fase + IClis + TpOps + CUnis + CUniPs + CMats + ;
                    Operacaos + STR(Nenvs,10) TAG FFuncMat

                *-- SQL principal: SigCdNec (cabecalho) x SigCdNei (itens)
                loc_cSQL = ;
                    "SELECT a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs," + ;
                    "a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                    "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.peso2s,b.Fators," + ;
                    "b.Servicos,b.Cats,b.Empdnps " + ;
                    "FROM SigCdNec a, SigCdNei b " + ;
                    "WHERE a.Datas BETWEEN " + FormatarDataSQL(loc_dDatai) + ;
                    " AND " + loc_cDataFimSQL + " AND "

                IF !EMPTY(loc_cGrupo)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.GrupoOs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cConta)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.ContaDs = " + EscaparSQL(loc_cConta) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.ContaOs = " + EscaparSQL(loc_cConta) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cDopp)
                    loc_cSQL = loc_cSQL + "a.Dopps = " + EscaparSQL(loc_cDopp) + " AND "
                ENDIF

                IF loc_nNumes > 0
                    loc_cSQL = loc_cSQL + "a.NumPs = " + FormatarNumeroSQL(loc_nNumes) + " AND "
                ENDIF

                loc_cSQL = loc_cSQL + "a.EmpDNPs = b.EmpDNPs ORDER BY a.cIdChaves"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = ;
                        "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF

                *-- Filtrar operacoes marcadas no grid + tipo geracao OP
                SELECT * FROM CsSigCdOpd ;
                    WHERE Marca > 0 ;
                    AND IIF(!EMPTY(m.loc_cTGOp), CodTgOps = m.loc_cTGOp, .T.) ;
                    INTO CURSOR csLocalMc READWRITE
                GO TOP IN csLocalMc

                *-- Cruzar movimentacoes com operacoes selecionadas
                IF EMPTY(loc_cDopp) AND !EOF("csLocalMc")
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs AND b.Marca > 0 ;
                        INTO CURSOR CrSigCdNec READWRITE
                ELSE
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs ;
                        AND IIF(!EMPTY(m.loc_cTGOp), b.CodTgOps = m.loc_cTGOp, .T.) ;
                        INTO CURSOR CrSigCdNec READWRITE
                ENDIF

                *-- Filtro por envelope especifico
                IF loc_nEnvelope > 0
                    SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                        WHERE Nenvs = loc_nEnvelope ;
                        INTO CURSOR crEnvelope READWRITE
                ENDIF

                SELECT CrSigCdNec
                INDEX ON DTOS(Datas) + CIdChaves TAG Datas
                SET ORDER TO Datas
                GO TOP IN CrSigCdNec

                *-- Processar cada registro de movimentacao
                loc_lAbortarScan = .F.
                IF RECCOUNT("CrSigCdNec") > 0
                    SELECT CrSigCdNec
                    SCAN
                        *-- Filtro tipo material/operacao
                        IF !EMPTY(loc_cTpOpt) AND ;
                                ALLTRIM(CrSigCdNec.TpOps) <> ALLTRIM(loc_cTpOpt)
                            LOOP
                        ENDIF

                        *-- Filtro por envelope
                        IF loc_nEnvelope > 0
                            SELECT crEnvelope
                            LOCATE FOR ALLTRIM(Empdnps) = ALLTRIM(CrSigCdNec.Empdnps)
                            IF EOF("crEnvelope")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Filtro por numero de OP
                        IF loc_nOp > 0 AND ;
                                !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF

                        *-- Filtro por cliente especifico
                        IF !EMPTY(loc_cCodCli)
                            LOCAL loc_cQLCli
                            IF !EMPTY(CrSigCdNec.Nops) AND CrSigCdNec.Nops <> 0
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM sigoppic a " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE a.Nops = " + ;
                                    FormatarNumeroSQL(CrSigCdNec.Nops) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ELSE
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM SigPdMvf f " + ;
                                    "INNER JOIN sigoppic a ON f.Nops = a.Nops " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE f.EmpDnPs = " + ;
                                    EscaparSQL(ALLTRIM(CrSigCdNec.EmpDnPs)) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ENDIF
                            IF USED("LocalCli")
                                USE IN LocalCli
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLCli, "LocalCli") < 1
                                THIS.this_cMensagemErro = "Erro ao verificar cliente"
                                loc_lAbortarScan = .T.
                                EXIT
                            ENDIF
                            IF EOF("LocalCli")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Ignorar servicos sem OP vinculada
                        IF CrSigCdNec.Servicos AND ;
                                !EMPTY(CrSigCdNec.Nenvs) AND ;
                                EMPTY(ALLTRIM(CrSigCdNec.Cats))
                            LOOP
                        ENDIF

                        *-- Buscar descricao e grupo do material
                        LOCAL loc_cQLPro
                        loc_cQLPro = ;
                            "SELECT a.CPros,a.DPros,a.CGrus,a.CUnis,a.CUniPs,b.Mercs " + ;
                            "FROM SigCdPro a, SigCdGrp b " + ;
                            "WHERE a.CPros = " + ;
                            EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                            " AND a.Cgrus = b.Cgrus"
                        IF USED("CrSigCdPro")
                            USE IN CrSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cQLPro, "CrSigCdPro") < 1
                            THIS.this_cMensagemErro = "Erro ao buscar produto"
                            loc_lAbortarScan = .T.
                            EXIT
                        ENDIF
                        SELECT CrSigCdPro

                        *-- Filtro grupo materia prima
                        IF !EMPTY(loc_cGruMat) AND ;
                                ALLTRIM(CrSigCdPro.CGrus) <> ALLTRIM(loc_cGruMat)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Filtro grande grupo
                        IF !EMPTY(loc_cGgrp) AND ;
                                ALLTRIM(CrSigCdPro.Mercs) <> ALLTRIM(loc_cGgrp)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Montar variaveis de agrupamento
                        loc_cTpOps = IIF(loc_lImprimeTpMat, ;
                            CrSigCdNec.TpOps, SPACE(15))
                        loc_cGrp = IIF(loc_lDestino, ;
                            CrSigCdNec.GrupoDs, CrSigCdNec.GrupoOs)
                        loc_cCta = IIF(loc_lDestino, ;
                            CrSigCdNec.Contads, CrSigCdNec.ContaOs)
                        loc_cPed = PADR(IIF(loc_lDope, ;
                            ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                            ALLTRIM(STR(CrSigCdNec.Numps,10)), " "), 31)
                        loc_nEnv = IIF(loc_lDope, CrSigCdNec.Nenvs, 0)

                        *-- Filtrar grupo de transito (configurado em SigCdPam)
                        IF USED("CrSigCdPam") AND ;
                                ALLTRIM(loc_cGrp) = ALLTRIM(CrSigCdPam.GrTrans)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Buscar produto da OP (apenas quando necessario)
                        loc_cPro = ""
                        loc_cDpr = ""
                        IF !EMPTY(CrSigCdNec.Nops) AND ;
                                CrSigCdNec.Nops <> 0 AND ;
                                THIS.this_lImprimeProdutos
                            LOCAL loc_cQLOpPro
                            loc_cQLOpPro = ;
                                "SELECT TOP 1 a.Cpros, b.DPros " + ;
                                "FROM SigOpPic a " + ;
                                "INNER JOIN SigCdPro b ON a.Cpros = b.Cpros " + ;
                                "WHERE Nops = " + ;
                                FormatarNumeroSQL(CrSigCdNec.Nops)
                            IF USED("LocalPro")
                                USE IN LocalPro
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLOpPro, "LocalPro") > 0
                                GO TOP IN LocalPro
                                IF !EOF("LocalPro")
                                    loc_cDpr = ALLTRIM(LocalPro.DPros)
                                    loc_cPro = ALLTRIM(LocalPro.Cpros)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Inserir/acumular em TmpRelat
                        SELECT TmpRelat
                        IF loc_lDopeDt
                            *-- Modo detalhado: agrupa por DopPs + data
                            LOCAL loc_cPedDt, loc_nEnvDt
                            loc_cPedDt = ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                                ALLTRIM(STR(CrSigCdNec.Numps,10))
                            loc_nEnvDt = CrSigCdNec.Nops
                            SET ORDER TO Operacao
                            IF !SEEK(DTOS(CrSigCdNec.Datas) + ;
                                    PADR(loc_cPedDt,31) + ;
                                    STR(loc_nEnvDt,10) + ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14))
                                INSERT INTO TmpRelat ;
                                    (Datas, Operacaos, Nenvs, CMats, Dpros, ;
                                    Cunis, CPros, DDPros, Fators) ;
                                    VALUES (CrSigCdNec.Datas, loc_cPedDt, ;
                                    loc_nEnvDt, ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPro, loc_cDpr, CrSigCdNec.Fators)
                            ENDIF
                            REPLACE Qtde  WITH Qtde  + CrSigCdNec.Qtds, ;
                                    Pesos WITH Pesos + CrSigCdNec.Pesos
                            REPLACE Valor WITH Valor + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ELSE
                            *-- Modo resumido: agrupa por grupo/conta/material
                            SET ORDER TO FFuncMat
                            IF !SEEK(loc_cGrp + loc_cCta + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats + loc_cPed + ;
                                    STR(loc_nEnv,10))
                                *-- Buscar nome da conta para exibicao
                                LOCAL loc_cRClis, loc_cQLCli2
                                loc_cRClis = ""
                                loc_cQLCli2 = ;
                                    "SELECT IClis, RClis FROM SigCdCli " + ;
                                    "WHERE IClis = " + ;
                                    EscaparSQL(ALLTRIM(loc_cCta))
                                IF USED("CrTmpCli")
                                    USE IN CrTmpCli
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQLCli2, "CrTmpCli") > 0
                                    SELECT CrTmpCli
                                    IF !EOF("CrTmpCli")
                                        loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                                    ENDIF
                                ENDIF
                                SELECT TmpRelat
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, Dpros, CPros, ;
                                    DDPros, TpOps, Cunis, Operacaos, Nenvs, ;
                                    Datas, Fators, CuniPs) ;
                                    VALUES (loc_cGrp, loc_cCta, loc_cRClis, ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    loc_cPro, loc_cDpr, loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPed, loc_nEnv, CrSigCdNec.Datas, ;
                                    CrSigCdNec.Fators, ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)

                            *-- Linha de total geral por material
                            SET ORDER TO FFuncMat
                            IF !SEEK(REPLICATE(CHR(255),20) + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats)
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, TpOps, ;
                                    Cunis, CuniPs) ;
                                    VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ENDIF

                        SELECT CrSigCdNec
                    ENDSCAN
                ENDIF

                IF loc_lAbortarScan
                    EXIT
                ENDIF

                *-- Montar cabecalho do relatorio
                loc_cCab = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
                loc_cSub = IIF(THIS.this_lRelatorio, "", ;
                    IIF(loc_lDestino, "Por Destino", "Por Origem") + " - ") + ;
                    "Per" + CHR(237) + "odo : " + ;
                    ALLTRIM(DTOC(loc_dDatai)) + ;
                    " at" + CHR(233) + " " + ALLTRIM(DTOC(loc_dDataf))

                IF USED("CrSigCdEmp")
                    USE IN CrSigCdEmp
                ENDIF
                LOCAL loc_cQLEmp
                loc_cQLEmp = "SELECT Cemps, Razas FROM SigCdEmp"
                SQLEXEC(gnConnHandle, loc_cQLEmp, "CrSigCdEmp")
                loc_cEmp = go_4c_Sistema.cCodEmpresa + " - "
                IF USED("CrSigCdEmp")
                    SELECT CrSigCdEmp
                    LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    IF !EOF("CrSigCdEmp")
                        loc_cEmp = loc_cEmp + ALLTRIM(CrSigCdEmp.Razas)
                    ENDIF
                ENDIF

                IF THIS.this_lImprimeFuncs AND !EMPTY(loc_cConta)
                    LOCAL loc_cQLFuncs
                    loc_cQLFuncs = ;
                        "SELECT a.RClis, a.Cpfs FROM SigCdCli a " + ;
                        "WHERE a.IClis = " + EscaparSQL(PADR(loc_cConta,10))
                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cQLFuncs, "LocalCli") < 1
                        THIS.this_cMensagemErro = ;
                            "Erro ao buscar funcion" + CHR(225) + "rio"
                        EXIT
                    ENDIF
                    SELECT LocalCli
                    GO TOP IN LocalCli
                    IF !EOF("LocalCli")
                        loc_cSub = loc_cSub + CHR(13) + CHR(13) + ;
                            "NOME: " + ALLTRIM(LocalCli.RClis) + ;
                            " / CPF: " + ALLTRIM(LocalCli.Cpfs)
                    ENDIF
                ENDIF

                CREATE CURSOR dbCabecalho ;
                    (Titulo c(100), SubTitulo c(200), NomeEmpresa c(100), ImpFuncs L)
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa, ImpFuncs) ;
                    VALUES (loc_cCab, loc_cSub, loc_cEmp, THIS.this_lImprimeFuncs)

                SELECT TmpRelat
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em tela (preview)
    * Replica: PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    * par_lComDialogo: .T. = abre dialogo de impressora, .F. = imprime direto
    * Replica: PROCEDURE impressao (prompt) e documento (direto) do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComDialogo)
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX, loc_lDialogo

        loc_lSucesso = .F.
        loc_lDialogo = IIF(PCOUNT() >= 1, par_lComDialogo, .F.)

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINTER NOCONSOLE
                    ENDIF
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
