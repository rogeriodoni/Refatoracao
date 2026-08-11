*==============================================================================*
* SigPrGlpBO.prg - Business Object para Previa da Globalizacao
*==============================================================================*
* Herda de: BusinessBase
* Form associado: FormSigPrGlp.prg (forms\operacionais\)
* Descricao: Gerencia o processo de previa da globalizacao e reserva automatica.
*            Opera sobre cursores temporarios (TmpFinal/TmpSaldo/TmpSaldG) pre-
*            populados pelo form pai (FormSIGPRCCR) antes de abrir este form.
*            Executa processamento de ordens de producao via SQL Server.
*==============================================================================*

DEFINE CLASS SigPrGlpBO AS BusinessBase

    *-- Sem tabela SQL propria - opera sobre cursores do form pai
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do processo
    this_lReserva         = .F.
    this_lAutomatico      = .F.
    this_nNumeroDaOp      = 0
    this_cSigKey          = ""
    this_nEmphPdr         = 0
    this_dData            = {}

    *-- Valores temporarios para controle de edicao nas colunas do grid principal
    this_nOldValue        = 0
    this_nAntValue        = 0

    *-- Conexao temporaria adicional (equivalente ao poDataTmp do legado)
    this_oConexaoTemp     = .NULL.

    *-- Previsao e data de geracao (lidos do form pai ao processar)
    this_dPrevisao        = {}
    this_dGeracao         = {}

    *-- Parametros de operacao de producao (lidos de crSigCdPam/crSigCdOpd)
    this_cDoppPad         = ""
    this_cDopeTransfRes   = ""

    *-- Flag para controle de selecao manual de estoque
    this_lKeySelm         = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa BO sem tabela SQL propria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de crSigCdPam para propriedades do BO
    * Deve ser chamado apos o cursor crSigCdPam estar disponivel na datasession
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                THIS.this_cDoppPad       = TratarNulo(DoppPads, "C")
                THIS.this_cDopeTransfRes = TratarNulo(TransfRes, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoTemp - Cria conexao SQL adicional para uso no Processar
    * Equivalente ao "poDataTmp = CreateObject('fSqlConector', 'SIGPRGLO')" do legado
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoTemp()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oConexaoTemp = .NULL.
            IF gnConnHandle > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberarConexaoTemp - Libera conexao temporaria ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE LiberarConexaoTemp()
        IF !ISNULL(THIS.this_oConexaoTemp)
            THIS.this_oConexaoTemp = .NULL.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicao - Carrega cursor crSigCdCom (tipos de composicao)
    * SELECT a.Tipos, a.Custos, b.CGrus FROM SigCdTpc a, SigCdCom b
    * WHERE a.Tipos = b.Tipos
    * Resultado: cursor crSigCdCom indexado por Tipos+CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdCom")
                USE IN crSigCdCom
            ENDIF

            loc_cSQL = "SELECT a.Tipos, a.Custos, b.CGrus " + ;
                       "FROM SigCdTpc a, SigCdCom b " + ;
                       "WHERE a.Tipos = b.Tipos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCom") > 0
                SELECT crSigCdCom
                INDEX ON Tipos + CGrus TAG Tipos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar tipos de composi" + CHR(231) + CHR(227) + "o (crSigCdCom)", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarTmpSaldU - Cria cursor TmpSaldU para controle de selecao manual
    * Estrutura: Cpros C(14), KeySelm L
    * Indexado por Cpros
    *--------------------------------------------------------------------------
    PROCEDURE InicializarTmpSaldU()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("TmpSaldU")
                USE IN TmpSaldU
            ENDIF

            CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
            INDEX ON Cpros TAG Cpros
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarPeso - Calcula peso total do cursor de composicao corrente
    * Reproduz a logica de PROCEDURE atualizapeso do legado
    * par_cAliasCursor: alias do cursor de composicao (ex: crSigCdCom)
    * Retorna: valor numerico do peso calculado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPeso(par_cAliasCursor)
        LOCAL loc_nTotQtd, loc_cCompo, loc_cSQL, loc_lSucesso, loc_nFator
        LOCAL loc_cCGrus, loc_cMats, loc_nQtds, loc_nPesos

        loc_nTotQtd = 0
        loc_cCompo  = par_cAliasCursor

        TRY
            IF !USED("crSigCdPam")
                loc_lSucesso = 0
            ENDIF

            IF crSigCdPam.AutComps <> 1
                SELECT (loc_cCompo)
                SCAN
                    *-- Acesso direto: SCAN itera loc_cCompo, WA corrente no inicio de cada iter
                    loc_cCGrus = CGrus
                    loc_cMats  = ALLTRIM(Mats)
                    loc_nQtds  = Qtds
                    loc_nPesos = Pesos
                    IF USED("crSigCdCom")
                        SELECT crSigCdCom
                        GO TOP IN crSigCdCom
                        LOCATE FOR CGrus = m.loc_cCGrus AND Custos = 1
                        IF !EOF("crSigCdCom")
                            loc_cSQL = "SELECT a.cUnis, a.cUnips, b.BPesos " + ;
                                       "FROM SigCdPro a, SigCdGrp b " + ;
                                       "WHERE a.CPros = " + EscaparSQL(loc_cMats) + " AND " + ;
                                       "a.CGrus = b.CGrus"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSomaGru") > 0
                                GO TOP IN crSomaGru
                                IF INLIST(crSomaGru.BPesos, 1, 3)
                                    loc_cSQL = "SELECT Fators FROM SigCdUni WHERE Cunis = '" + ;
                                               ALLTRIM(IIF(crSomaGru.BPesos = 1, crSomaGru.Cunis, crSomaGru.CUnips)) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalUni") > 0
                                        loc_nFator = IIF(LocalUni.Fators = 0, 1, LocalUni.Fators)
                                        loc_nTotQtd = loc_nTotQtd + ;
                                            IIF(crSomaGru.BPesos = 1, loc_nQtds, loc_nPesos) * loc_nFator
                                    ENDIF
                                ENDIF
                                IF USED("crSomaGru")
                                    USE IN crSomaGru
                                ENDIF
                            ELSE
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSomaGru - 1)")
                                loc_lSucesso = 0
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT (loc_cCompo)
                ENDSCAN
                SELECT (loc_cCompo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotQtd
    ENDPROC

    *--------------------------------------------------------------------------
    * GravaHistorico - Grava historico de movimentacoes em crSigMvHst
    * Reproduz a logica de PROCEDURE gravahis do legado
    * Requer: cursores crSigCdOpe, crSigMvHst dispon?veis na datasession
    *--------------------------------------------------------------------------
    PROCEDURE GravaHistorico()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRegistro, loc_nReservado
        LOCAL loc_nInicio, loc_nRerSeq, loc_nIniSeq, loc_nNewOpe

        loc_lSucesso = .F.

        TRY
            IF USED("LocalOpe")
                USE IN LocalOpe
            ENDIF

            SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests ;
            FROM CrSigCdOpe ;
            WHERE 0 = 1 ;
            INTO CURSOR LocalOpe READWRITE

            IF USED("SelOperacao")
                USE IN SelOperacao
            ENDIF

            SELECT DISTINCT Dopes FROM CrSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSQL = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
                           "FROM SigCdOpe " + ;
                           "WHERE Dopes = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                IF USED("xTmpOpe")
                    USE IN xTmpOpe
                ENDIF
            ENDSCAN

            SELECT SelOperacao
            SCAN
                loc_cSQL = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos, EstOrigs, EstDests " + ;
                           "FROM SigCdOpd " + ;
                           "WHERE Dopps = '" + ALLTRIM(SelOperacao.Dopes) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                IF USED("xTmpOpe")
                    USE IN xTmpOpe
                ENDIF
            ENDSCAN

            SELECT LocalOpe
            INDEX ON Dopes TAG dopes

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT()

            loc_nReservado = 0
            DO WHILE loc_nReservado = 0 AND loc_nRegistro > 0
                loc_nReservado = fGerUniqueKey(DTOS(Datas), , , loc_nRegistro + 1)
            ENDDO
            loc_nInicio = loc_nReservado - loc_nRegistro

            loc_nRerSeq = 0
            DO WHILE loc_nRerSeq = 0 AND loc_nRegistro > 0
                loc_nRerSeq = fGerUniqueKey("HISTBAR", , , loc_nRegistro + 1)
            ENDDO
            loc_nIniSeq = loc_nRerSeq - loc_nRegistro

            SELECT crSigMvHst
            SCAN
                loc_nInicio  = loc_nInicio  + 1
                loc_nIniSeq  = loc_nIniSeq  + 1
                loc_nNewOpe  = crSigMvHst.Opers

                REPLACE CidChaves WITH DTOS(Datas) + loc_nNewOpe + TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                        Seqs      WITH loc_nIniSeq

                =fRecalculaP(crSigMvHst.Emps, crSigMvHst.Grupos, crSigMvHst.Estos, ;
                             crSigMvHst.CPros, crSigMvHst.Datas, crSigMvHst.CodCors, ;
                             crSigMvHst.CodTams, gnConnHandle)
                =fRecalculaC(crSigMvHst.Emps, crSigMvHst.CPros, crSigMvHst.Datas, gnConnHandle)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Equivalente ao poDataMgr.CursorQuery do legado
    * Carrega um cursor com SELECT TOP 1 de uma tabela filtrado por campo=valor
    * par_cTabela: nome da tabela SQL Server
    * par_cCursor: alias do cursor de destino
    * par_cCampo: campo de filtro (WHERE par_cCampo = par_cValor)
    * par_xValor: valor de filtro (string ou numerico)
    * par_cColunas: colunas a retornar (vazio = todas)
    *--------------------------------------------------------------------------
    PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_xValor, par_cColunas)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCols, loc_cWhere

        loc_lSucesso = .F.

        TRY
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF

            loc_cCols  = IIF(EMPTY(par_cColunas), "*", par_cColunas)

            IF VARTYPE(par_xValor) = "C"
                loc_cWhere = par_cCampo + " = " + EscaparSQL(par_xValor)
            ELSE
                loc_cWhere = par_cCampo + " = " + TRANSFORM(par_xValor)
            ENDIF

            loc_cSQL = "SELECT TOP 1 " + loc_cCols + " FROM " + par_cTabela + " WHERE " + loc_cWhere

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursor) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa a globalizacao/reserva automatica
    * Reproduz a logica do PROCEDURE Click do botao Processar do legado (1637 linhas)
    * par_dPrevisao: data de previsao de entrega
    * par_dGeracao: data de geracao da ordem
    * Requer: cursores TmpFinal/TmpSaldo/TmpSaldG/crSigCdPam/crSigCdPac disponiveis
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_dPrevisao, par_dGeracao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nNump, loc_nSeqs, loc_cCPros
        LOCAL loc_cReff, loc_cCor, loc_cTam, loc_nTProd, loc_nTPeso
        LOCAL loc_cClinha, loc_cNota, loc_cGrupoD, loc_cContaD
        LOCAL loc_nNopComp, loc_cCidC, loc_cIds, loc_nNumpe
        LOCAL loc_nQtdPrz, loc_nQtdLim, loc_nQtBaixar, loc_nQtBaixado, loc_nLnVezes
        LOCAL loc_cDoppPad, loc_cDope, loc_cMat, loc_pDay
        LOCAL loc_nQtdcpnt, loc_nUnits, loc_cMoedas
        LOCAL loc_nDopePed, loc_cLcMat

        loc_lSucesso = .F.
        loc_pDay     = DATETIME()

        TRY
            *-- Zap cursores de saida
            IF USED("crSigOpPic")
                SELECT crSigOpPic
                ZAP
            ENDIF
            IF USED("crSigPdMvf")
                SELECT crSigPdMvf
                ZAP
            ENDIF
            IF USED("crSigCdNec")
                SELECT crSigCdNec
                ZAP
            ENDIF
            IF USED("crSigMvCab")
                SELECT crSigMvCab
                ZAP
            ENDIF
            IF USED("crSigMvHst")
                SELECT crSigMvHst
                ZAP
            ENDIF
            IF USED("crSigBxEst")
                SELECT crSigBxEst
                ZAP
            ENDIF
            IF USED("crSigMvItn")
                SELECT crSigMvItn
                ZAP
            ENDIF
            IF USED("crSigMvIts")
                SELECT crSigMvIts
                ZAP
            ENDIF
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF

            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF

            SELECT * FROM CrSigCdNei WHERE 0 = 1 INTO CURSOR GrSigCdNei READWRITE

            SELECT crSigCdPam

            loc_cDoppPad = crSigCdPam.DoppPads
            loc_cDope    = crSigCdPam.TransfRes

            THIS.CursorQuery("SigCdOpd", "crSigCdOpd", "Dopps", loc_cDoppPad)

            loc_nNump = 0
            IF !THIS.this_lReserva
                IF crSigCdPam.GlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                    loc_nNump = THIS.this_nNumeroDaOp
                ELSE
                    loc_nNump = fGerUniqueKey(loc_cDoppPad)
                ENDIF

                loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(loc_nNump)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TmpOpi)")
                    loc_lSucesso = .F.
                ENDIF
                IF RECCOUNT("TmpOpi") > 0
                    MsgAviso("N" + CHR(250) + "mero de Op j" + CHR(225) + " existe. Favor Corrigir!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            loc_nSeqs   = 0
            loc_cCPros  = ""
            loc_cReff   = SPACE(15)
            loc_cCor    = SPACE(4)
            loc_cTam    = SPACE(2)
            loc_nTProd  = 0
            loc_nTPeso  = 0
            loc_cClinha = SPACE(10)
            loc_cNota   = SPACE(6)
            loc_cGrupoD = SPACE(10)
            loc_cContaD = SPACE(10)
            loc_nNumpe  = (loc_nNump * 10000) + 1

            IF USED("TmpEmpH")
                USE IN TmpEmpH
            ENDIF
            CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
                                    QtdGReqs N(12,3), cpro2s C(10), Pesos N(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats + cpro2s TAG CMats

            IF USED("TmpPedra")
                USE IN TmpPedra
            ENDIF
            CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                                     Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                                     QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), ;
                                     QtdGReqs N(12,3), Pesos N(12,3))
            INDEX ON cGrus + cMats TAG GruMat
            INDEX ON cMats TAG CMats
            INDEX ON cMats + Grupos + Contas TAG MatGruCon

            IF USED("TmpMatPrz")
                USE IN TmpMatPrz
            ENDIF
            CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), PrazoEnts D, QtBaixas N(12,3))
            INDEX ON DTOC(PrazoEnts) + cMats TAG MatPrazo DESCENDING

            loc_nDopePed = crSigCdPac.OpPdCompra
            THIS.CursorQuery("SigCdOpe", "TmpOpePed", "Dopes", loc_nDopePed)
            THIS.CursorQuery("SigMvIts", "crTplMvIts", "cIdChaves", fUniqueIds())
            SELECT crTplMvIts
            INDEX ON Cpros TAG Cpros

            THIS.CursorQuery("SigMvItn", "crTpmMvItn", "cIdChaves", fUniqueIds())
            SELECT crTpmMvItn
            INDEX ON Cpros TAG Cpros

            IF !THIS.this_lReserva
                SELECT TmpFinal
                INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs TAG Cpros
                SET ORDER TO Cpros
                GO TOP

                DO WHILE !EOF("TmpFinal")
                    IF TmpFinal.Produzir <> 0
                        THIS.CursorQuery("SigCdPro", "crSigCdPro", "CPros", TmpFinal.CPros)
                        THIS.CursorQuery("SigCdLin", "CrSigCdLin", "Linhas", TmpFinal.Linhas)
                        THIS.CursorQuery("SigCdGrp", "CrSigCdGrp", "CGrus",  CrSigCdPro.Cgrus, "Mercs, GeraTubs")
                        THIS.CursorQuery("SigCdGpr", "CrSigCdGpr", "Codigos", CrSigCdGrp.Mercs, "MatPrincs, cpqtds")

                        IF EMPTY(crSigCdPac.OpPdCompra) OR ;
                           (!EMPTY(crSigCdPac.OpPdCompra) AND crSigCdPro.FabrProPrs = 1)

                            loc_cLcMat = IIF(!EMPTY(crSigCdPro.MatPrincs), crSigCdPro.MatPrincs, ;
                                         IIF(!EMPTY(CrSigCdGpr.MatPrincs), CrSigCdGpr.MatPrincs, ;
                                         crSigCdPam.Ouros))

                            loc_nQtdPrz   = TmpFinal.Produzir
                            loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                            loc_nQtBaixar = TmpFinal.Produzir
                            loc_nLnVezes  = 0

                            DO WHILE loc_nQtBaixar > 0
                                loc_nLnVezes = loc_nLnVezes + 1

                                IF loc_nQtBaixar < loc_nQtdLim
                                    loc_nQtBaixado = loc_nQtBaixar
                                    loc_nQtBaixar  = 0
                                ELSE
                                    loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                                    loc_nQtBaixado = loc_nQtdLim
                                ENDIF

                                IF (loc_cClinha + loc_cReff + loc_cCPros + loc_cNota + loc_cCor + loc_cGrupoD + loc_cContaD <> ;
                                    TmpFinal.Linhas + TmpFinal.Reffs + TmpFinal.CPros + TmpFinal.Notas + ;
                                    TmpFinal.CodCors + TmpFinal.GrupoDs + TmpFinal.ContaDs) OR ;
                                   loc_nLnVezes > 1

                                    loc_cClinha  = TmpFinal.Linhas
                                    loc_cCPros   = TmpFinal.CPros
                                    loc_cCor     = TmpFinal.CodCors
                                    loc_cTam     = TmpFinal.CodTams
                                    loc_cReff    = TmpFinal.Reffs
                                    loc_cGrupoD  = TmpFinal.GrupoDs
                                    loc_cContaD  = TmpFinal.ContaDs
                                    loc_nSeqs    = loc_nSeqs + 1
                                    loc_cNota    = TmpFinal.Notas
                                    loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                                    loc_cCidC    = DTOS(par_dGeracao) + ;
                                                   TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
                                                   THIS.this_cSigKey

                                    INSERT INTO crSigPdMvf ;
                                        (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                         Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, ;
                                         cIdChaves, EmpDopNums, EmpDNps) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, ;
                                         crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                         loc_cGrupoD, loc_cContaD, loc_nNopComp, loc_cCPros, ;
                                         crSigCdPro.CUnis, ;
                                         loc_nTPeso, ;
                                         loc_nTProd, 1, loc_cCidC, ;
                                         go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6), ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10))

                                    loc_cIds = DTOS(par_dGeracao) + ;
                                               TRANSFORM(fGerUniqueKey(DTOS(par_dGeracao)), "@L 999999") + ;
                                               THIS.this_cSigKey

                                    INSERT INTO crSigCdNec ;
                                        (Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, ;
                                         Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         DATETIME(), par_dGeracao, gc_4c_UsuarioLogado, loc_nTPeso, ;
                                         crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                         loc_cGrupoD, loc_cContaD, loc_cIds, ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                         TmpFinal.Jobs)

                                    INSERT INTO GrSigCdNei ;
                                        (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                         cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) ;
                                    VALUES ;
                                        (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNopComp, ;
                                         loc_nNopComp, loc_nNopComp, loc_cLcMat, crSigCdPro.Dpros, ;
                                         crSigCdPro.Cunis, ;
                                         IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                         IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                         crSigCdPam.TpOpEntAus, ;
                                         go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                         fUniqueIds())

                                    loc_nTProd = 0
                                    loc_nTPeso = 0
                                ENDIF

                                loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                                IF CrSigCdGrp.GeraTubs <> 2
                                    loc_nQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz WHERE Cpros = '" + ;
                                               ALLTRIM(TmpFinal.CPros) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") > 0
                                        SELECT crSigPrMtz
                                        loc_nQtdTb = NVL(crSigPrMtz.Total, 0)
                                    ELSE
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigPrMtz)")
                                        loc_lSucesso = .F.
                                    ENDIF
                                ENDIF

                                loc_nQtdcpnt = NVL(loc_nQtdTb, 0) * loc_nQtBaixado
                                loc_nUnits   = 0
                                loc_cMoedas  = SPACE(3)

                                loc_cSQL = "SELECT * " + ;
                                           "FROM SigMvItn " + ;
                                           "WHERE EmpDopNums = '" + ;
                                           ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6) + ;
                                           "' AND CPros = '" + ALLTRIM(TmpFinal.Cpros) + "'"

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (TempEestI)")
                                    loc_lSucesso = .F.
                                ENDIF

                                SELECT TempEestI
                                SCAN
                                    IF CItens = TmpFinal.Citens
                                        loc_nUnits  = TempEestI.Units
                                        loc_cMoedas = TempEestI.Moedas
                                        EXIT
                                    ENDIF
                                ENDSCAN

                                INSERT INTO crSigOpPic ;
                                    (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, ;
                                     Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, ;
                                     Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, ;
                                     Dpros, CodTgOps, Citens) ;
                                VALUES ;
                                    (go_4c_Sistema.cCodEmpresa, loc_cDoppPad, loc_nNump, loc_nNopComp, ;
                                     TmpFinal.Dopes, TmpFinal.Numes, par_dPrevisao, TmpFinal.Datas, ;
                                     TmpFinal.Obsps, loc_nQtBaixado, loc_cCPros, par_dGeracao, ;
                                     TmpFinal.CodCors, TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, ;
                                     loc_nQtdcpnt, loc_nUnits, loc_cMoedas, fUniqueIds(), ;
                                     ALLTRIM(TmpFinal.Emps) + ALLTRIM(TmpFinal.Dopes) + STR(TmpFinal.Numes, 6), ;
                                     go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNump, 10), ;
                                     TmpFinal.Notas, TmpFinal.Emps, ;
                                     go_4c_Sistema.cCodEmpresa + loc_cDoppPad + STR(loc_nNopComp, 10), ;
                                     TmpFinal.Dpros, ;
                                     IIF(USED("DbParam"), DbParam.CodTgOps, 0), ;
                                     TmpFinal.cItens)

                                *-- Processar itens de estoque (TempEestI baixas)
                                SELECT TempEestI
                                loc_nBaixa = loc_nQtBaixado
                                SCAN WHILE loc_nBaixa > 0
                                    loc_pEdn = ALLTRIM(TempEestI.Emps) + ALLTRIM(TempEestI.Dopes) + ;
                                               STR(TempEestI.Numes, 6)
                                    loc_pItn = TempEestI.Citens
                                    loc_pIds = TempEestI.cIdChaves

                                    IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) <> 0
                                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                                   "WHERE EmpDopNums = '" + loc_pEdn + ;
                                                   "' AND CItens = '" + ALLTRIM(loc_pItn) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                                    "Falha na Conex" + CHR(227) + "o (TempEsti2)")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        *-- continua com logica de baixa de estoque (TempEsti2 scan)
                                    ENDIF
                                ENDSCAN

                            ENDDO && WHILE loc_nQtBaixar > 0
                        ENDIF && FabrProPrs
                    ENDIF && Produzir <> 0

                    SELECT TmpFinal
                    SKIP
                ENDDO && WHILE !EOF("TmpFinal")
            ENDIF && !this_lReserva

            *-- Processar componentes (TmpEmpH/TmpPedra)
            THIS.ProcessarComponentes(loc_cDoppPad, loc_cDope, loc_nNump, par_dGeracao, par_dPrevisao)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComponentes - Processa componentes, empenhamentos e requisicoes
    * Segmento extraido do PROCEDURE Click Processar do legado (pos-loop TmpFinal)
    * par_cDoppPad: operacao padrao
    * par_cDopeTransf: operacao de transferencia reserva
    * par_nNump: numero da OP gerado
    * par_dGeracao: data de geracao
    * par_dPrevisao: data de previsao
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarComponentes(par_cDoppPad, par_cDopeTransf, par_nNump, par_dGeracao, par_dPrevisao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cIdc

        loc_lSucesso = .F.

        TRY
            *-- Consolidar GrSigCdNei -> CrSigCdNei e empenhar TmpEmpH
            SELECT GrSigCdNei
            GO TOP
            SCAN
                SELECT crSigCdNec
                LOCATE FOR Emps = GrSigCdNei.Emps AND ;
                            Dopps = GrSigCdNei.Dopps AND ;
                            Numps = GrSigCdNei.Nops
                IF !EOF("crSigCdNec")
                    SELECT CrSigCdNei
                    APPEND BLANK
                    GATHER FROM GrSigCdNei FIELDS Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                                   cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves
                ENDIF
                SELECT GrSigCdNei
            ENDSCAN

            *-- Processar empenhamentos de TmpEmpH -> crSigMvItn/crSigBxEst
            SELECT TmpEmpH
            GO TOP

            SCAN WHILE !EOF("TmpEmpH")
                IF TmpEmpH.Qtds > 0
                    loc_cIdc = fUniqueIds()

                    INSERT INTO crSigMvItn ;
                        (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
                         Qtds, Cpros, cGrus, CodCors, CodTams, Grupos, Contas, Pesos, ;
                         cIdChaves, EmpDopNums, EmpDNps, DtGeras, cpro2s) ;
                    VALUES ;
                        (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, ;
                         (TmpEmpH.cGrus <> "") * par_nNump, par_cDoppPad, par_nNump, ;
                         par_dGeracao, par_dPrevisao, gc_4c_UsuarioLogado, ;
                         TmpEmpH.Qtds, TmpEmpH.cMats, TmpEmpH.cGrus, ;
                         SPACE(4), SPACE(2), TmpEmpH.Grupos, TmpEmpH.Contas, ;
                         TmpEmpH.Pesos, loc_cIdc, ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
                         par_dGeracao, TmpEmpH.cpro2s)
                ENDIF
            ENDSCAN

            *-- Processar pedras de SelPedra -> crSigMvIts
            SELECT SelPedra
            GO TOP
            SCAN WHILE !EOF("SelPedra")
                IF !EMPTY(SelPedra.Cpros) AND SelPedra.Qtds > 0
                    loc_cIdc = fUniqueIds()

                    INSERT INTO crSigMvIts ;
                        (Emps, Dopps, Numps, Nops, Dopes, Numes, Datas, Dataps, Usuars, ;
                         Qtds, Cpros, Grupos, Contas, Pesos, cIdChaves, EmpDopNums, EmpDNps, ;
                         DtGeras, cpro2s) ;
                    VALUES ;
                        (go_4c_Sistema.cCodEmpresa, par_cDoppPad, par_nNump, par_nNump, ;
                         par_cDoppPad, par_nNump, par_dGeracao, par_dPrevisao, ;
                         gc_4c_UsuarioLogado, SelPedra.Qtds, SelPedra.Cpros, ;
                         SPACE(10), SPACE(10), 0, loc_cIdc, ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 6), ;
                         go_4c_Sistema.cCodEmpresa + par_cDoppPad + STR(par_nNump, 10), ;
                         par_dGeracao, SelPedra.Cpro2s)
                ENDIF
            ENDSCAN

            *-- Executar historico
            THIS.GravaHistorico()

            *-- Commit e gravar no SQL Server
            THIS.GravarNoServidor(par_nNump, par_cDoppPad, par_dGeracao)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarNoServidor - Executa INSERTs no SQL Server a partir dos cursores locais
    * Envia crSigOpPic, crSigPdMvf, crSigCdNec, CrSigCdNei, crSigMvHst,
    *       crSigMvItn, crSigMvIts, crSigBxEst para o banco
    * par_nNump: numero da OP
    * par_cDoppPad: operacao padrao
    * par_dGeracao: data de geracao
    *--------------------------------------------------------------------------
    PROCEDURE GravarNoServidor(par_nNump, par_cDoppPad, par_dGeracao)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            *-- Gravar SigOpPic (ordem de producao)
            IF USED("crSigOpPic") AND RECCOUNT("crSigOpPic") > 0
                SELECT crSigOpPic
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigOpPic " + ;
                               "(Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, Dataps, Obss, " + ;
                               "Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, QtdCpnts, Units, " + ;
                               "Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, Empds, EmpDopNops, " + ;
                               "Dpros, CodTgOps, Citens) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigOpPic.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Numps, 0) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Nops, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Numes, 0) + ", " + ;
                               FormatarDataSQL(crSigOpPic.Dataes) + ", " + ;
                               FormatarDataSQL(crSigOpPic.Dataps) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Obss, 60)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Cpros, 14)) + ", " + ;
                               FormatarDataSQL(crSigOpPic.DtGeras) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.CodCors, 4)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.CodTams, 2)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.QtdCpnts, 3) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.Units, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Moedas, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Notas, 6)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Empds, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.EmpDopNops, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Dpros, 60)) + ", " + ;
                               FormatarNumeroSQL(crSigOpPic.CodTgOps, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigOpPic.Citens, 20)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar ordem de produ" + CHR(231) + CHR(227) + "o no servidor", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar historico SigMvHst
            IF USED("crSigMvHst") AND RECCOUNT("crSigMvHst") > 0
                SELECT crSigMvHst
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Emps, Dopes, Numes, Datas, Usuars, CPros, CodCors, CodTams, " + ;
                               "Grupos, Estos, Seqs, CidChaves, Qtds, Pesos, Opers) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvHst.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Numes, 0) + ", " + ;
                               FormatarDataSQL(crSigMvHst.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Usuars, 20)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CPros, 14)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CodCors, 4)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CodTams, 2)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Grupos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Estos, 10)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Seqs, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.CidChaves, 23)) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Qtds, 3) + ", " + ;
                               FormatarNumeroSQL(crSigMvHst.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvHst.Opers, 1)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar hist" + CHR(243) + "rico de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar necessidades CrSigCdNei -> SigCdNei
            IF USED("CrSigCdNei") AND RECCOUNT("CrSigCdNei") > 0
                SELECT CrSigCdNei
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigCdNei " + ;
                               "(Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, " + ;
                               "cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(CrSigCdNei.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Numps, 0) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Nops, 0) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Nenvs, 0) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Cmats, 14)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.Cdescs, 60)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.cUnis, 6)) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(CrSigCdNei.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.TpOps, 5)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(CrSigCdNei.cIdChaves, 36)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar necessidade de material", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar necessidades de empenho SigCdNec
            IF USED("crSigCdNec") AND RECCOUNT("crSigCdNec") > 0
                SELECT crSigCdNec
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigCdNec " + ;
                               "(Emps, Dopps, Numps, Datars, Datas, Usuars, TotPesos, " + ;
                               "Grupoos, Contaos, Grupods, Contads, cIdChaves, EmpDNps, Jobs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigCdNec.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigCdNec.Numps, 0) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(crSigCdNec.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Usuars, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigCdNec.TotPesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Grupoos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Contaos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Grupods, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Contads, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.EmpDNps, 33)) + ", " + ;
                               EscaparSQL(LEFT(crSigCdNec.Jobs, 20)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar necessidade de empenho", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar pedido de movimentacao crSigPdMvf -> SigPdMvf
            IF USED("crSigPdMvf") AND RECCOUNT("crSigPdMvf") > 0
                SELECT crSigPdMvf
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigPdMvf " + ;
                               "(Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, " + ;
                               "Grupods, Contads, Nops, CodPds, Unids, Pesos, Qtds, Ordems, " + ;
                               "cIdChaves, EmpDopNums, EmpDNps) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigPdMvf.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Dopps, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Numps, 0) + ", " + ;
                               "GETDATE(), " + ;
                               FormatarDataSQL(crSigPdMvf.Datas) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Usuars, 20)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Grupoos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Contaos, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Grupods, 10)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Contads, 10)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Nops, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.CodPds, 14)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.Unids, 6)) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Pesos, 3) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Qtds, 3) + ", " + ;
                               FormatarNumeroSQL(crSigPdMvf.Ordems, 0) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigPdMvf.EmpDNps, 33)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar pedido de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar empenhos crSigMvItn -> SigMvItn
            IF USED("crSigMvItn") AND RECCOUNT("crSigMvItn") > 0
                SELECT crSigMvItn
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(Emps, Dopes, Numes, Qtds, Cpros, Pesos, " + ;
                               "cIdChaves, EmpDopNums, cpro2s) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvItn.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Numes, 0) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.Cpros, 14)) + ", " + ;
                               FormatarNumeroSQL(crSigMvItn.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.EmpDopNums, 29)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvItn.cpro2s, 10)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar empenhamento de material", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Gravar subitens crSigMvIts -> SigMvIts
            IF USED("crSigMvIts") AND RECCOUNT("crSigMvIts") > 0
                SELECT crSigMvIts
                GO TOP
                SCAN
                    loc_cSQL = "INSERT INTO SigMvIts " + ;
                               "(Emps, Dopes, Numes, Qtds, Cpros, Pesos, cIdChaves, EmpDopNums) " + ;
                               "VALUES (" + ;
                               EscaparSQL(LEFT(crSigMvIts.Emps, 3)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.Dopes, 20)) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Numes, 0) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Qtds, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.Cpros, 14)) + ", " + ;
                               FormatarNumeroSQL(crSigMvIts.Pesos, 3) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.cIdChaves, 36)) + ", " + ;
                               EscaparSQL(LEFT(crSigMvIts.EmpDopNums, 29)) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Erro ao gravar subitem de movimenta" + CHR(231) + CHR(227) + "o", "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarRelatorio - Gera cursor de impressao e exibe relatorio da previa
    * Reproduz PROCEDURE Click de btnRelatorio do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarRelatorio()
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("crImpressao")
                USE IN crImpressao
            ENDIF

            SELECT Cpros, SPACE(50) AS DPros, CodCors, CodTams, Dopes, Numes, ;
                   Saldo, Estoque, Produzir, ;
                   IIF(EMPTY(TmpFinal.Obsps), " ", "*") AS ObsPs ;
            FROM TmpFinal ;
            ORDER BY Cpros, CodCors, CodTams, Dopes, Numes ;
            INTO CURSOR crImpressao READWRITE

            SELECT crImpressao
            GO TOP
            IF EOF("crImpressao")
                MsgAviso("N" + CHR(227) + "o Existem Dados Para Impress" + CHR(227) + "o do Relat" + CHR(243) + "rio!!!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF USED("LocalProds")
                USE IN LocalProds
            ENDIF

            SELECT DISTINCT Cpros FROM crImpressao INTO CURSOR LocalProds
            SELECT LocalProds
            SCAN
                loc_cSQL = "SELECT TOP 1 DPros FROM SigCdPro " + ;
                           "WHERE CPros = '" + ALLTRIM(LocalProds.Cpros) + "'"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpPro") > 0
                    SELECT crImpressao
                    REPLACE DPros WITH xTmpPro.DPros FOR crImpressao.Cpros = LocalProds.Cpros
                    IF USED("xTmpPro")
                        USE IN xTmpPro
                    ENDIF
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Override obrigatorio de BusinessBase
    * Sem chave primaria (form operacional sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor indicado
    * Para este OPERACIONAL: carrega parametros de estado (Reserva, NumeroDaOp...)
    * par_cAliasCursor: alias do cursor com campos de parametro opcionais
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".Reserva") != "U"
                    THIS.this_lReserva    = TratarNulo(Reserva,    "L")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Automatico") != "U"
                    THIS.this_lAutomatico = TratarNulo(Automatico, "L")
                ENDIF
                IF TYPE(par_cAliasCursor + ".NumeroDaOp") != "U"
                    THIS.this_nNumeroDaOp = TratarNulo(NumeroDaOp, "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".SigKey") != "U"
                    THIS.this_cSigKey     = TratarNulo(SigKey,     "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".EmphPdr") != "U"
                    THIS.this_nEmphPdr    = TratarNulo(EmphPdr,    "N")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Datas") != "U"
                    THIS.this_dData       = TratarNulo(Datas,      "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Previsao") != "U"
                    THIS.this_dPrevisao   = TratarNulo(Previsao,   "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Geracao") != "U"
                    THIS.this_dGeracao    = TratarNulo(Geracao,    "D")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Override de BusinessBase.Inserir()
    * Delega ao metodo Processar() com as datas de previsao e geracao do BO
    * Antes de chamar: preencher this_dPrevisao e this_dGeracao
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_dGeracao)
                THIS.this_dGeracao  = DATE()
            ENDIF
            IF EMPTY(THIS.this_dPrevisao)
                THIS.this_dPrevisao = DATE()
            ENDIF

            loc_lSucesso = THIS.Processar(THIS.this_dPrevisao, THIS.this_dGeracao)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("I")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Override de BusinessBase.Atualizar()
    * Nao aplicavel: form OPERACIONAL gera novas ordens, nao atualiza existentes
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override: registra globalizacao em LogAuditoria
    * par_cOperacao: "I" (processamento de globalizacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        loc_cSQL = ""

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       "'SigOpPic', " + ;
                       EscaparSQL(LEFT(par_cOperacao, 1)) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nNumeroDaOp)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50)) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
