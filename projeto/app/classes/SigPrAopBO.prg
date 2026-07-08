*------------------------------------------------------------------------------
* SigPrAopBO.prg - Business Object para Alteracao de Quantidade da O.P.
* Form OPERACIONAL: Altera quantidades de divisoes de Ordens de Producao
* Tabelas principais: SigOpPic, SigCdPam, SigCdNec, SigPdMvf
*------------------------------------------------------------------------------
DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Tabela principal e chave
    this_cTabela            = "SigOpPic"
    this_cCampoChave        = "cIdChaves"

    *-- Empresa corrente
    this_cEmps              = ""

    *-- O.P. corrente
    this_nNops              = 0        && Numero da O.P. (Nops)
    this_cEmpDNps           = ""       && Chave composta empresa+DoppPads+Nops (EmpDNps)

    *-- Produto da O.P. (de SigPdMvf)
    this_cCodPds            = ""       && Codigo do produto (CodPds)

    *-- Parametros de configuracao (SigCdPam)
    this_cDoppPads          = ""       && Prefixo de OP (DoppPads)
    this_cMascNums          = ""       && Mascara de numeros (MascNums)

    *-- Flags de estado da O.P.
    this_lOpEncerrada       = .F.      && OP ja encerrada (ChkSubn = .T.)
    this_lOpLocalizada      = .F.      && OP foi localizada em SigCdNec

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de configuracao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DoppPads, MascNums FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cDoppPads = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema (SigCdPam).", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOP - Valida e carrega os itens da O.P. em cursor_4c_DivOp
    * Equivalente ao Get_OP.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarOP(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpDNps
        LOCAL loc_lEncerrada, loc_nSeq, loc_lContinuar

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                THIS.this_nNops         = par_nNops
                loc_cEmpDNps            = THIS.this_cEmps + THIS.this_cDoppPads + STR(par_nNops, 10)
                THIS.this_cEmpDNps      = loc_cEmpDNps
                THIS.this_lOpLocalizada = .F.
                THIS.this_lOpEncerrada  = .F.
                THIS.this_cCodPds       = ""

                *-- Limpa cursor antes de carregar
                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                *-- Verifica existencia e status da O.P. em SigCdNec
                loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nec") > 0
                    IF EOF("cursor_4c_Nec")
                        loc_lContinuar = .F.
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF
                        MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
                    ELSE
                        SELECT cursor_4c_Nec
                        loc_lEncerrada = NVL(ChkSubn, .F.)
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF

                        THIS.this_lOpLocalizada = .T.
                        THIS.this_lOpEncerrada  = loc_lEncerrada

                        IF loc_lEncerrada
                            loc_lContinuar = .F.
                            MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                        ENDIF
                    ENDIF
                ELSE
                    loc_lContinuar = .F.
                    MsgErro("Erro ao verificar O.P. em SigCdNec.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Carrega codigo do produto da O.P. em SigPdMvf
                loc_cSQL = "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvf") > 0
                    IF !EOF("cursor_4c_Mvf")
                        SELECT cursor_4c_Mvf
                        THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
                    ENDIF
                    IF USED("cursor_4c_Mvf")
                        USE IN cursor_4c_Mvf
                    ENDIF
                ENDIF

                *-- Carrega divisoes da O.P. de SigOpPic
                loc_cSQL = "SELECT Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "CPros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicTemp") > 0
                    loc_nSeq = 1
                    SELECT cursor_4c_OpPicTemp
                    SCAN
                        INSERT INTO cursor_4c_DivOp ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, ;
                             SeqDivs, Cpros, CodCors, CodTams, cItens) ;
                        VALUES ;
                            (ALLTRIM(NVL(cursor_4c_OpPicTemp.Dopes, "")), ;
                             NVL(cursor_4c_OpPicTemp.Numes, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             cursor_4c_OpPicTemp.DataEs, ;
                             NVL(cursor_4c_OpPicTemp.Obss, ""), ;
                             loc_nSeq, ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CPros, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodCors, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodTams, "")), ;
                             NVL(cursor_4c_OpPicTemp.Citens, 0))
                        loc_nSeq = loc_nSeq + 1
                    ENDSCAN

                    IF USED("cursor_4c_OpPicTemp")
                        USE IN cursor_4c_OpPicTemp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens da O.P. em SigOpPic.", "Erro")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Salva quantidades alteradas de volta ao SQL Server
    * Equivalente ao Grupo_Conf.Salva.Click do legado:
    * 1. Reset SeqDivs=0 em SigOpPic para a O.P.
    * 2. Para cada linha de cursor_4c_DivOp, atualiza Qtds+SeqDivs em SigOpPic
    * 3. Soma total de QtdDivs e atualiza SigPdMvf
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        LOCAL loc_cIdChaves, loc_nQtdTotal, loc_lContinuar
        LOCAL loc_cDopes, loc_nNumes, loc_nCItens, loc_nQtdDivs, loc_nSeqDiv

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                *-- Passo 1: Reseta SeqDivs = 0 para todos os itens da O.P.
                loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd0") < 1
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 1)")
                ELSE
                    IF USED("cursor_4c_Upd0")
                        USE IN cursor_4c_Upd0
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 2: Recarrega SigOpPic com cIdChaves para UPDATE por chave
                loc_cSQL = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicSave") < 1
                    loc_lContinuar = .F.
                    MsgErro("Erro ao recarregar dados de SigOpPic para grava" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 3: Para cada divisao, localiza e atualiza Qtds+SeqDivs em SigOpPic
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    GO TOP
                    SCAN WHILE loc_lContinuar
                        loc_cDopes   = ALLTRIM(cursor_4c_DivOp.Dopes)
                        loc_nNumes   = cursor_4c_DivOp.Numes
                        loc_nCItens  = cursor_4c_DivOp.cItens
                        loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                        loc_nSeqDiv  = cursor_4c_DivOp.SeqDivs

                        *-- Busca a linha correspondente em SigOpPic (SeqDivs=0 = ainda nao processado)
                        SELECT cursor_4c_OpPicSave
                        LOCATE FOR Citens         = loc_nCItens AND ;
                                   ALLTRIM(Dopes) = loc_cDopes  AND ;
                                   Numes          = loc_nNumes  AND ;
                                   SeqDivs        = 0

                        IF FOUND()
                            loc_cIdChaves = ALLTRIM(cursor_4c_OpPicSave.cIdChaves)

                            loc_cSQL = "UPDATE SigOpPic " + ;
                                       "SET Qtds = "    + FormatarNumeroSQL(loc_nQtdDivs) + ;
                                       ", SeqDivs = "   + FormatarNumeroSQL(loc_nSeqDiv)  + ;
                                       " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd1") < 1
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 2)")
                            ELSE
                                IF USED("cursor_4c_Upd1")
                                    USE IN cursor_4c_Upd1
                                ENDIF
                                *-- Marca como processado no cursor local (SeqDivs != 0)
                                REPLACE SeqDivs WITH loc_nSeqDiv IN cursor_4c_OpPicSave
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_DivOp
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_OpPicSave")
                    USE IN cursor_4c_OpPicSave
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 4: Soma QtdDivs e atualiza total em SigPdMvf
                loc_nQtdTotal = 0
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT SUM(QtdDivs) AS nTotalQtd FROM cursor_4c_DivOp ;
                           INTO CURSOR cursor_4c_Soma READWRITE
                    IF !EOF("cursor_4c_Soma")
                        loc_nQtdTotal = NVL(cursor_4c_Soma.nTotalQtd, 0)
                    ENDIF
                    IF USED("cursor_4c_Soma")
                        USE IN cursor_4c_Soma
                    ENDIF
                ENDIF

                loc_cSQL = "SELECT cIdChaves FROM SigPdMvf " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvfSave") > 0
                    IF !EOF("cursor_4c_MvfSave")
                        SELECT cursor_4c_MvfSave
                        loc_cIdChaves = ALLTRIM(cursor_4c_MvfSave.cIdChaves)

                        loc_cSQL = "UPDATE SigPdMvf " + ;
                                   "SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd2") < 1
                            loc_lContinuar = .F.
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (Update - SigPdMvf)")
                        ELSE
                            IF USED("cursor_4c_Upd2")
                                USE IN cursor_4c_Upd2
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvfSave")
                        USE IN cursor_4c_MvfSave
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 5: Auditoria, limpa cursor e reseta estado
                THIS.RegistrarAuditoria("ALTERAR")

                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                THIS.this_nNops    = 0
                THIS.this_cEmpDNps = ""
                THIS.this_cCodPds  = ""

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * Aceita alias contendo qualquer subset dos campos: Nops, CodPds, Dopes,
    * Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, cItens, SeqDivs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave da O.P.
            IF TYPE("Nops") != "U"
                THIS.this_nNops = NVL(Nops, 0)
            ENDIF

            *-- Empresa
            IF TYPE("Emps") != "U"
                THIS.this_cEmps = ALLTRIM(NVL(Emps, ""))
            ENDIF

            *-- Produto (SigPdMvf)
            IF TYPE("CodPds") != "U"
                THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
            ENDIF

            *-- Recompoe chave composta se possivel
            IF !EMPTY(THIS.this_cDoppPads) AND THIS.this_nNops > 0
                THIS.this_cEmpDNps = THIS.this_cEmps + THIS.this_cDoppPads + STR(THIS.this_nNops, 10)
            ENDIF

            *-- Status da O.P. (SigCdNec)
            IF TYPE("ChkSubn") != "U"
                THIS.this_lOpEncerrada  = NVL(ChkSubn, .F.)
                THIS.this_lOpLocalizada = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "Nops=" + TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere novos registros em SigOpPic
    * A tela apenas ALTERA quantidades de OPs existentes. Metodo mantido
    * para satisfazer contrato de BusinessBase; delega para SalvarAlteracoes
    * quando invocado via Salvar() em modo de insercao (nao usado nesta tela).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        ELSE
            *-- Nada a inserir - fluxo nao aplicavel a esta tela operacional
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava alteracoes de quantidade de volta em SigOpPic
    * Fluxo real esta em SalvarAlteracoes (chamada por BtnConfirmarClick do
    * form). Este metodo delega e registra auditoria conforme contrato de
    * BusinessBase.Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Nenhuma O.P. carregada para atualiza" + CHR(231) + CHR(227) + "o."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
