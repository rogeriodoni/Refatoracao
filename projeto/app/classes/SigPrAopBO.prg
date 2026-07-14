*******************************************************************************
* SigPrAopBO.prg - Business Object: Alteracao de Quantidade da O.P.
* Herda de BusinessBase
* Tabela principal: SigOpPic
*******************************************************************************

DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpPic"
    this_cCampoChave = "Nops"

    *-- Numero da Ordem de Producao atual
    this_nNops     = 0

    *-- Codigo do produto da OP
    this_cCodPds   = ""

    *-- Chave composta: cCodEmpresa + DoppPads + Str(Nops,10)
    this_cEmpDNps  = ""

    *-- Parametros carregados de SigCdPam
    this_cDoppPads = ""
    this_cMascNums = ""

    *-- Nome do cursor de trabalho da divisao de OP (equivalente a Temp_DivOp)
    this_cCursorDivOp = "cursor_4c_DivOp"

    *---------------------------------------------------------------------------
    PROCEDURE Init()
    *---------------------------------------------------------------------------
        THIS.this_cTabela     = "SigOpPic"
        THIS.this_cCampoChave = "Nops"
        DODEFAULT()
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            loc_cSql = "SELECT TOP 1 DoppPads, MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdPam") > 0
                IF !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_cDoppPads = NVL(ALLTRIM(DoppPads), "")
                    THIS.this_cMascNums = NVL(ALLTRIM(MascNums), "")
                    loc_lSucesso = .T.
                ENDIF
                USE IN cursor_4c_SigCdPam
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE CarregarDivOp(par_nNops, par_cCursorDestino)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cEmpDNps
        LOCAL loc_nItem, loc_cCodPds, loc_lChkSubn, loc_lOPValida
        LOCAL loc_cDopes, loc_nNumes, loc_nQtds, loc_dDataes
        LOCAL loc_mObss, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nCitens, loc_cIdChaves

        loc_lSucesso  = .F.
        loc_lOPValida = .F.
        loc_nItem     = 0
        loc_cCodPds   = ""
        loc_lChkSubn  = .F.

        IF par_nNops = 0
            RETURN .F.
        ENDIF

        TRY
            *-- Monta chave EmpDNps: cCodEmpresa + DoppPads + Str(Nops,10)
            loc_cEmpDNps = go_4c_Sistema.cCodEmpresa + THIS.this_cDoppPads + STR(par_nNops, 10)
            THIS.this_cEmpDNps = loc_cEmpDNps
            THIS.this_nNops    = par_nNops

            *-- Valida OP em SigCdNec (verifica existencia e se nao foi encerrada)
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            loc_cSql = "SELECT TOP 1 EmpDNps, ChkSubn FROM SigCdNec " + ;
                       "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdNec") > 0
                IF !EOF("cursor_4c_SigCdNec")
                    SELECT cursor_4c_SigCdNec
                    loc_lChkSubn  = NVL(cursor_4c_SigCdNec.ChkSubn, .F.)
                    loc_lOPValida = .T.
                ENDIF
                USE IN cursor_4c_SigCdNec
            ELSE
                MsgErro("Erro ao validar O.P.", "Erro")
            ENDIF

            IF loc_lOPValida AND loc_lChkSubn
                MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                loc_lOPValida = .F.
            ENDIF

            IF !loc_lOPValida AND !loc_lChkSubn AND par_nNops > 0
                MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
            ENDIF

            IF loc_lOPValida
                *-- Obtem codigo do produto via SigPdMvf
                IF USED("cursor_4c_SigPdMvfLoad")
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                loc_cSql = "SELECT TOP 1 CodPds FROM SigPdMvf " + ;
                           "WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfLoad") > 0
                    IF !EOF("cursor_4c_SigPdMvfLoad")
                        SELECT cursor_4c_SigPdMvfLoad
                        loc_cCodPds = NVL(ALLTRIM(cursor_4c_SigPdMvfLoad.CodPds), "")
                    ENDIF
                    USE IN cursor_4c_SigPdMvfLoad
                ENDIF
                THIS.this_cCodPds = loc_cCodPds

                *-- Carrega itens de SigOpPic para o cursor de trabalho
                IF USED("cursor_4c_SigOpPicLoad")
                    USE IN cursor_4c_SigOpPicLoad
                ENDIF
                loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "Cpros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops, 0)
                IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicLoad") > 0
                    SELECT (par_cCursorDestino)
                    ZAP

                    SELECT cursor_4c_SigOpPicLoad
                    GO TOP
                    loc_nItem = 0
                    SCAN
                        loc_nItem     = loc_nItem + 1
                        loc_cDopes    = NVL(cursor_4c_SigOpPicLoad.Dopes, "")
                        loc_nNumes    = NVL(cursor_4c_SigOpPicLoad.Numes, 0)
                        loc_nQtds     = NVL(cursor_4c_SigOpPicLoad.Qtds, 0)
                        loc_dDataes   = cursor_4c_SigOpPicLoad.DataEs
                        loc_mObss     = NVL(cursor_4c_SigOpPicLoad.Obss, "")
                        loc_cCpros    = NVL(cursor_4c_SigOpPicLoad.Cpros, "")
                        loc_cCodCors  = NVL(cursor_4c_SigOpPicLoad.CodCors, "")
                        loc_cCodTams  = NVL(cursor_4c_SigOpPicLoad.CodTams, "")
                        loc_nCitens   = NVL(cursor_4c_SigOpPicLoad.Citens, 0)
                        loc_cIdChaves = NVL(ALLTRIM(cursor_4c_SigOpPicLoad.cIdChaves), "")

                        INSERT INTO (par_cCursorDestino) ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, SeqDivs, ;
                             Cpros, CodCors, CodTams, Citens, cIdChaves, Nops) ;
                            VALUES (loc_cDopes, loc_nNumes, loc_nQtds, loc_nQtds, ;
                                    loc_dDataes, loc_mObss, loc_nItem, ;
                                    loc_cCpros, loc_cCodCors, loc_cCodTams, ;
                                    loc_nCitens, loc_cIdChaves, par_nNops)
                    ENDSCAN

                    USE IN cursor_4c_SigOpPicLoad

                    SELECT (par_cCursorDestino)
                    IF RECCOUNT() > 0
                        GO TOP
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens de SigOpPic.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_SigCdNec")
                USE IN cursor_4c_SigCdNec
            ENDIF
            IF USED("cursor_4c_SigPdMvfLoad")
                USE IN cursor_4c_SigPdMvfLoad
            ENDIF
            IF USED("cursor_4c_SigOpPicLoad")
                USE IN cursor_4c_SigOpPicLoad
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *---------------------------------------------------------------------------
        IF THIS.this_nNops = 0
            RETURN .F.
        ENDIF
        IF !USED(THIS.this_cCursorDivOp) OR RECCOUNT(THIS.this_cCursorDivOp) = 0
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_lErroInLoop
        LOCAL loc_nTotalQtds, loc_cCursorDiv, loc_nNops, loc_cChave
        LOCAL loc_nCitens, loc_cDopes, loc_nNumes, loc_nQtdDivs, loc_nSeqDivs

        loc_lSucesso    = .F.
        loc_lErroInLoop = .F.
        loc_nTotalQtds  = 0
        loc_cCursorDiv  = THIS.this_cCursorDivOp
        loc_nNops       = THIS.this_nNops

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Carrega SigOpPic fresco para esta OP (sera o espelho local das operacoes)
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            loc_cSql = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                       "FROM SigOpPic " + ;
                       "WHERE Nops = " + FormatarNumeroSQL(loc_nNops, 0)
            IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigOpPicSave") <= 0
                MsgErro("Falha ao carregar SigOpPic para gravacao.", "Erro")
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ELSE
                *-- Passo 1: Zera SeqDivs de todos os itens da OP
                SELECT cursor_4c_SigOpPicSave
                GO TOP
                SCAN WHILE !loc_lErroInLoop
                    loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                    loc_cSql   = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                                 "WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                    IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                        MsgErro("Falha ao reinicializar O.P. Favor tentar novamente.", "Erro")
                        loc_lErroInLoop = .T.
                    ELSE
                        REPLACE SeqDivs WITH 0 IN cursor_4c_SigOpPicSave
                    ENDIF
                ENDSCAN

                *-- Passo 2: Atualiza Qtds/SeqDivs conforme cursor de trabalho
                IF !loc_lErroInLoop AND USED(loc_cCursorDiv) AND RECCOUNT(loc_cCursorDiv) > 0
                    SELECT (loc_cCursorDiv)
                    GO TOP
                    SCAN WHILE !loc_lErroInLoop
                        loc_nCitens  = NVL(EVALUATE(loc_cCursorDiv + ".Citens"), 0)
                        loc_cDopes   = NVL(ALLTRIM(EVALUATE(loc_cCursorDiv + ".Dopes")), "")
                        loc_nNumes   = NVL(EVALUATE(loc_cCursorDiv + ".Numes"), 0)
                        loc_nQtdDivs = NVL(EVALUATE(loc_cCursorDiv + ".QtdDivs"), 0)
                        loc_nSeqDivs = NVL(EVALUATE(loc_cCursorDiv + ".SeqDivs"), 0)

                        *-- Localiza linha correspondente em SigOpPicSave por Citens+Dopes+Numes
                        SELECT cursor_4c_SigOpPicSave
                        GO TOP
                        SCAN FOR Nops = loc_nNops AND Citens = loc_nCitens AND SeqDivs = 0
                            IF NVL(ALLTRIM(Dopes), "") + STR(NVL(Numes, 0), 6) = ;
                               loc_cDopes + STR(loc_nNumes, 6)
                                loc_cChave = NVL(ALLTRIM(cIdChaves), "")
                                loc_cSql   = "UPDATE SigOpPic SET " + ;
                                             "Qtds = " + FormatarNumeroSQL(loc_nQtdDivs, 3) + ;
                                             ", SeqDivs = " + FormatarNumeroSQL(loc_nSeqDivs, 0) + ;
                                             " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                                IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                    MsgErro("Falha ao atualizar SigOpPic. Favor reinicializar.", "Erro")
                                    loc_lErroInLoop = .T.
                                ELSE
                                    REPLACE Qtds    WITH loc_nQtdDivs, ;
                                            SeqDivs WITH loc_nSeqDivs ;
                                            IN cursor_4c_SigOpPicSave
                                ENDIF
                                EXIT
                            ENDIF
                        ENDSCAN
                        SELECT (loc_cCursorDiv)
                    ENDSCAN
                ENDIF

                *-- Passo 3: Soma Qtds atualizadas e grava total em SigPdMvf
                IF !loc_lErroInLoop
                    SELECT cursor_4c_SigOpPicSave
                    loc_nTotalQtds = 0
                    SUM Qtds TO loc_nTotalQtds

                    IF USED("cursor_4c_SigPdMvfSave")
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                    loc_cSql = "SELECT TOP 1 cIdChaves FROM SigPdMvf " + ;
                               "WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)
                    IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigPdMvfSave") > 0
                        SELECT cursor_4c_SigPdMvfSave
                        IF !EOF("cursor_4c_SigPdMvfSave")
                            loc_cChave = NVL(ALLTRIM(cursor_4c_SigPdMvfSave.cIdChaves), "")
                            loc_cSql   = "UPDATE SigPdMvf SET " + ;
                                         "Qtds = " + FormatarNumeroSQL(loc_nTotalQtds, 3) + ;
                                         " WHERE cIdChaves = " + EscaparSQL(loc_cChave)
                            IF SQLEXEC(gnConnHandle, loc_cSql) <= 0
                                MsgErro("Falha ao atualizar total em SigPdMvf.", "Erro")
                                loc_lErroInLoop = .T.
                            ENDIF
                        ENDIF
                        USE IN cursor_4c_SigPdMvfSave
                    ENDIF
                ENDIF

                IF loc_lErroInLoop
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_SigOpPicSave")
                    USE IN cursor_4c_SigOpPicSave
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            IF USED("cursor_4c_SigOpPicSave")
                USE IN cursor_4c_SigOpPicSave
            ENDIF
            IF USED("cursor_4c_SigPdMvfSave")
                USE IN cursor_4c_SigPdMvfSave
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *---------------------------------------------------------------------------
        RETURN THIS.Inserir()
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNops = NVL(Nops, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *---------------------------------------------------------------------------
        RETURN TRANSFORM(THIS.this_nNops)
    ENDPROC

    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
    *---------------------------------------------------------------------------
        LOCAL loc_cSql, loc_oErro
        TRY
            loc_cSql = "INSERT INTO LogAuditoria (Tabela, Chave, Operacao, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpPic") + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar auditoria: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
