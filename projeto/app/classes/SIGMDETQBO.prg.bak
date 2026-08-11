*------------------------------------------------------------------------------
* SIGMDETQBO.prg - Business Object: Mudanca de Cor/Tamanho de Etiqueta
* Herda de BusinessBase
* Tabela principal: SigOpEtq (etiquetas de operacao)
*------------------------------------------------------------------------------
DEFINE CLASS SIGMDETQBO AS BusinessBase

    *-- Codigo de barras da etiqueta (numerico)
    this_nCodBarras  = 0

    *-- Codigo do produto (de CrSigOpEtq.CPros / CrSigMvHst.CPros)
    this_cCPros      = ""

    *-- Codigo da empresa (de CrSigMvHst.Emps)
    this_cEmps       = ""

    *-- Cor e Tamanho ANTIGOS (lidos de CrSigOpEtq.CodCors / .CodTams)
    this_cCorAnt     = ""
    this_cTamAnt     = ""

    *-- Cor e Tamanho NOVOS (informados pelo usuario, lookup SigCdCor / SigCdTam)
    this_cCorNew     = ""
    this_cTamNew     = ""

    *-- Chave de sessao do sistema (de crSigCdPac.SigKeys)
    this_cSigKey     = ""

    *-- Codigo da operacao padrao para mudanca cor/tamanho (de crSigCdPac.DopCorTam)
    this_cDopCorTam  = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigOpEtq"
        this_cCampoChave = "CBars"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPac: SigKeys e DopCorTam
    * Deve ser chamado no InicializarForm do Form antes de qualquer operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys, DopCorTam FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") >= 1
                IF RECCOUNT("cursor_4c_Pac") > 0
                    SELECT cursor_4c_Pac
                    THIS.this_cSigKey    = ALLTRIM(cursor_4c_Pac.SigKeys)
                    THIS.this_cDopCorTam = ALLTRIM(cursor_4c_Pac.DopCorTam)
                    IF EMPTY(THIS.this_cDopCorTam)
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o para Mudan" + CHR(231) + "a de Cor/Tamanho n" + CHR(227) + "o definida nos Par" + CHR(226) + "metros do Sistema.", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados em SigCdPac.", "Erro")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema (SigCdPac).", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorBarras - Valida e carrega dados da etiqueta pelo codigo de barras
    * Popula: this_nCodBarras, this_cCPros, this_cEmps, this_cCorAnt, this_cTamAnt
    * Retorna .T. se encontrado e valido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorBarras(par_nCodBarras)
        LOCAL loc_lSucesso, loc_lContinuar, loc_nCodBars, loc_cSQL, loc_oErro

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBars = IIF(VARTYPE(par_nCodBarras) = "C", VAL(par_nCodBarras), par_nCodBarras)

            IF EMPTY(loc_nCodBars)
                loc_lContinuar = .F.
            ENDIF

            *-- Passo 1: Localiza em SigOpEtq + SigOpEta (trata barcode antigo)
            IF loc_lContinuar
                loc_cSQL = "SELECT a.CPros, a.CBars, b.cbars_old " + ;
                           "FROM SigOpEtq a " + ;
                           "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                           "WHERE (a.CBars = " + TRANSFORM(loc_nCodBars) + ;
                           " OR b.cbars_old = " + TRANSFORM(loc_nCodBars) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrEtiqs)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_Etiqs
                GO TOP
                IF RECCOUNT("cursor_4c_Etiqs") > 0
                    loc_nCodBars = cursor_4c_Etiqs.CBars
                ENDIF
                IF USED("cursor_4c_Etiqs")
                    USE IN cursor_4c_Etiqs
                ENDIF
            ENDIF

            *-- Passo 2: Carrega dados completos da etiqueta
            IF loc_lContinuar
                loc_cSQL = "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nCodBars)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtq") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrSigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF RECCOUNT("cursor_4c_SigOpEtq") = 0
                    MsgAviso("Barra N" + CHR(227) + "o Localizado!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                IF EMPTY(cursor_4c_SigOpEtq.Contas) OR EMPTY(cursor_4c_SigOpEtq.Grupos)
                    MsgAviso("Barra j" + CHR(225) + " Vendido!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 3: Valida conta transitoria no historico
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Estos FROM SigMvHst WHERE codbarras = " + ;
                           TRANSFORM(loc_nCodBars) + " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstVal") >= 1
                    IF RECCOUNT("cursor_4c_MvHstVal") > 0
                        SELECT cursor_4c_MvHstVal
                        IF INLIST(ALLTRIM(cursor_4c_MvHstVal.Estos), "15000100", "15000150", "15000113")
                            MsgAviso("O Barra Informado Est" + CHR(225) + " Em Uma Conta Transit" + CHR(243) + "ria/" + ;
                                     "Transferencia e N" + CHR(227) + "o Pode Realizar a Altera" + CHR(231) + CHR(227) + "o " + ;
                                     "Dos Dados. Favor Verificar.", "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvHstVal")
                        USE IN cursor_4c_MvHstVal
                    ENDIF
                ENDIF
            ENDIF

            *-- Passo 4: Popula propriedades do BO
            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                THIS.this_nCodBarras = loc_nCodBars
                THIS.this_cCPros     = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                THIS.this_cCorAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                THIS.this_cTamAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodTams)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BuscarPorBarras")
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF
            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigOpEtq para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodBarras = TratarNulo(CBars,    "N")
            THIS.this_cCPros     = ALLTRIM(TratarNulo(CPros,   "C"))
            THIS.this_cCorAnt    = ALLTRIM(TratarNulo(CodCors, "C"))
            THIS.this_cTamAnt    = ALLTRIM(TratarNulo(CodTams, "C"))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo de barras como string
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodBarras)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAlteracao - Processa mudanca de Cor/Tamanho da etiqueta
    * Pre-condicao: BuscarPorBarras() e CarregarParametros() ja executados
    *               this_cCorNew e this_cTamNew devem estar preenchidos
    * Fluxo: INSERT SigMvCab + INSERT SigMvHst(S) + INSERT SigMvHst(E) + UPDATE SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarAlteracao()
        LOCAL loc_lSucesso, loc_lTransacao, loc_lContinuar
        LOCAL loc_nCodBarras, loc_cCorOld, loc_cTamOld, loc_cCorNew, loc_cTamNew
        LOCAL loc_cProd, loc_cEmps, loc_nTipoEstos
        LOCAL loc_cIds, loc_nPSeq, loc_nNume
        LOCAL loc_dtData, loc_dData, loc_cSQL, loc_cMsg, loc_oErro
        *-- Campos capturados do historico anterior
        LOCAL loc_cUnits, loc_cMoedas, loc_nTotas, loc_dDataTrans
        LOCAL loc_cEmpos, loc_nCodBarrasHist, loc_nQtds, loc_cGrupos
        LOCAL loc_cEstos, loc_nRecalMeds, loc_cObs, loc_nPesos
        LOCAL loc_cEmpGruEsts, loc_cOriDopNums, loc_nBcIpis, loc_dDtAudits

        loc_lSucesso   = .F.
        loc_lTransacao = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = THIS.this_nCodBarras
            loc_cCorOld    = ALLTRIM(THIS.this_cCorAnt)
            loc_cTamOld    = ALLTRIM(THIS.this_cTamAnt)
            loc_cCorNew    = ALLTRIM(THIS.this_cCorNew)
            loc_cTamNew    = ALLTRIM(THIS.this_cTamNew)
            loc_dtData     = DATETIME()
            loc_dData      = DATE()

            *-- Passo 1: Carrega historico mais recente para obter campos de cabecalho
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Emps, CPros, Units, Moedas, Totas, DataTrans, Empos, " + ;
                           "CodBarras, Qtds, Grupos, Estos, RecalMeds, Obs, Pesos, " + ;
                           "DtAudits, EmpGruEsts, OriDopNums, BcIpis " + ;
                           "FROM SigMvHst WHERE codbarras = " + TRANSFORM(loc_nCodBarras) + ;
                           " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstProc") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvHst)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar AND RECCOUNT("cursor_4c_MvHstProc") = 0
                MsgErro("Hist" + CHR(243) + "rico n" + CHR(227) + "o encontrado para o barras.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_MvHstProc
                loc_cEmps          = ALLTRIM(cursor_4c_MvHstProc.Emps)
                loc_cProd          = ALLTRIM(cursor_4c_MvHstProc.CPros)
                loc_cUnits         = ALLTRIM(cursor_4c_MvHstProc.Units)
                loc_cMoedas        = ALLTRIM(cursor_4c_MvHstProc.Moedas)
                loc_nTotas         = cursor_4c_MvHstProc.Totas
                loc_dDataTrans     = cursor_4c_MvHstProc.DataTrans
                loc_cEmpos         = ALLTRIM(cursor_4c_MvHstProc.Empos)
                loc_nCodBarrasHist = cursor_4c_MvHstProc.CodBarras
                loc_nQtds          = cursor_4c_MvHstProc.Qtds
                loc_cGrupos        = ALLTRIM(cursor_4c_MvHstProc.Grupos)
                loc_cEstos         = ALLTRIM(cursor_4c_MvHstProc.Estos)
                loc_nRecalMeds     = IIF(VARTYPE(cursor_4c_MvHstProc.RecalMeds) = "L", ;
                                         IIF(cursor_4c_MvHstProc.RecalMeds, 1, 0), ;
                                         cursor_4c_MvHstProc.RecalMeds)
                loc_cObs           = ALLTRIM(cursor_4c_MvHstProc.Obs)
                loc_nPesos         = cursor_4c_MvHstProc.Pesos
                loc_cEmpGruEsts    = ALLTRIM(cursor_4c_MvHstProc.EmpGruEsts)
                loc_cOriDopNums    = ALLTRIM(cursor_4c_MvHstProc.OriDopNums)
                loc_nBcIpis        = cursor_4c_MvHstProc.BcIpis
                loc_dDtAudits      = cursor_4c_MvHstProc.DtAudits
                IF USED("cursor_4c_MvHstProc")
                    USE IN cursor_4c_MvHstProc
                ENDIF
            ENDIF

            *-- Passo 2: Valida TipoEstos do grupo do produto
            IF loc_lContinuar
                loc_cSQL = "SELECT b.tipoestos " + ;
                           "FROM sigcdpro a " + ;
                           "JOIN sigcdgrp b ON a.cgrus = b.cgrus " + ;
                           "WHERE a.cpros = " + EscaparSQL(loc_cProd)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProc") >= 1 AND RECCOUNT("cursor_4c_GruposProc") > 0
                    SELECT cursor_4c_GruposProc
                    loc_nTipoEstos = cursor_4c_GruposProc.TipoEstos
                    IF INLIST(loc_nTipoEstos, 2, 4) AND EMPTY(loc_cCorNew)
                        MsgAviso("Favor Informar a Cor.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND INLIST(loc_nTipoEstos, 3, 4) AND EMPTY(loc_cTamNew)
                        MsgAviso("Favor Informar o Tamanho.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 3 AND !EMPTY(loc_cCorNew)
                        loc_cCorNew = ""
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 2 AND !EMPTY(loc_cTamNew)
                        loc_cTamNew = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_GruposProc")
                    USE IN cursor_4c_GruposProc
                ENDIF
            ENDIF

            *-- Passo 3: Gera chaves unicas
            IF loc_lContinuar
                loc_nNume = fGerUniqueKey(ALLTRIM(THIS.this_cDopCorTam) + loc_cEmps)
                loc_cIds  = DTOS(loc_dData) + "S" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")
            ENDIF

            *-- Passo 4: Inicia transacao
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 1
                    loc_lTransacao = .T.
                ELSE
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 5: INSERT em SigMvCab
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, Usuars, Datars, DataS, Mascnum, CidChaves, EmpDopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + ;
                           EscaparSQL(fUniqueIds()) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvCab)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 6: INSERT SigMvHst Saida (Opers='S', CodCors/CodTams ANTIGOS)
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, EmpDopNums, " + ;
                           "EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'S', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorOld) + ", " + ;
                           EscaparSQL(loc_cTamOld) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Sa" + CHR(237) + "da")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 7: INSERT SigMvHst Entrada (Opers='E', CodCors/CodTams NOVOS)
            IF loc_lContinuar
                loc_cIds  = DTOS(loc_dData) + "E" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")

                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, " + ;
                           "EmpDopNums, EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'E', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorNew) + ", " + ;
                           EscaparSQL(loc_cTamNew) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Entrada")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 8: UPDATE SigOpEtq com novos CodCors/CodTams
            IF loc_lContinuar
                loc_cSQL = "UPDATE SigOpEtq SET " + ;
                           "CodCors = " + EscaparSQL(loc_cCorNew) + ", " + ;
                           "CodTams = " + EscaparSQL(loc_cTamNew) + ;
                           " WHERE CBars = " + TRANSFORM(loc_nCodBarras)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 9: Recalculo de estoque via SqlCalcP2 e fRecalculaC
            IF loc_lContinuar
                SET NULL ON
                CREATE CURSOR cursor_4c_LocalHis ;
                    (Emps C(10), Grupos C(10), Estos C(20), CPros C(15), DataS D, CodCors C(6), CodTams C(6))
                SET NULL OFF
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorOld, loc_cTamOld)
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorNew, loc_cTamNew)
                SELECT cursor_4c_LocalHis
                GO TOP
                SCAN
                    =SqlCalcP2(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.Grupos, ;
                               cursor_4c_LocalHis.Estos, cursor_4c_LocalHis.CPros, ;
                               cursor_4c_LocalHis.DataS, cursor_4c_LocalHis.CodCors, ;
                               cursor_4c_LocalHis.CodTams, gnConnHandle)
                    =SqlCalcP2(.T., gnConnHandle, .T.)
                    =fRecalculaC(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.CPros, ;
                                 cursor_4c_LocalHis.DataS, gnConnHandle)
                    SELECT cursor_4c_LocalHis
                ENDSCAN
                IF USED("cursor_4c_LocalHis")
                    USE IN cursor_4c_LocalHis
                ENDIF
            ENDIF

            *-- Passo 10: Commit ou Rollback
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "COMMIT") >= 1
                    loc_lTransacao = .F.
                    loc_lSucesso   = .T.
                ELSE
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ELSE
                IF loc_lTransacao
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF

            *-- Passo 11: Log de auditoria (somente apos sucesso)
            IF loc_lSucesso
                loc_cMsg = "Barra : " + TRANSFORM(loc_nCodBarras) + ;
                           " *** Anterior(C:" + loc_cCorOld + ",T:" + loc_cTamOld + ;
                           ") Novo(C:" + loc_cCorNew + ",T:" + loc_cTamNew + ") *** "
                =fGravarLog("T", "SIGMDETQ", ALLTRIM(THIS.this_cDopCorTam), loc_cMsg, gc_4c_UsuarioLogado)
                THIS.RegistrarAuditoria("ALTERAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ProcessarAltera" + CHR(231) + CHR(227) + "o")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            IF USED("cursor_4c_MvHstProc")
                USE IN cursor_4c_MvHstProc
            ENDIF
            IF USED("cursor_4c_GruposProc")
                USE IN cursor_4c_GruposProc
            ENDIF
            IF USED("cursor_4c_LocalHis")
                USE IN cursor_4c_LocalHis
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * Form SIGMDETQ nao possui insert tradicional. A operacao unica eh a
    * mudanca de cor/tamanho da etiqueta, que gera INSERT em SigMvCab/SigMvHst
    * e UPDATE em SigOpEtq atomicamente dentro de ProcessarAlteracao().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * A "atualizacao" da etiqueta (troca de cor/tamanho) segue o mesmo fluxo
    * transacional de ProcessarAlteracao (UPDATE SigOpEtq + historico).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nCodBarras)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    * Retorna: CONVERT(DATETIME, 'AAAA-MM-DD HH:MM:SS', 120)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE
