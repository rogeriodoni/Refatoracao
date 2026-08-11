*==============================================================================
* HORBO.prg - Business Object: Cadastro de Carga Hor?ria
* Tabela principal : SigCdThs
* Chave prim?ria  : cidchaves
* Form OPERACIONAL: recebe pCod (Fase/Setor) e pUni (Unidade Produtiva)
*==============================================================================
* Colunas SigCdThs : cidchaves c(20) PK, codigos n(6,0), datas datetime,
*                    qtds n(4,1), qthoras n(4,2), setors c(10), uniprdts c(10)
* Colunas SigCdUpd : cidchaves c(20) PK, codigos c(10), ddsems n(1,0),
*                    hordds n(4,2), uniprdts c(10), ordems n(2,0), qtdes n(2,0)
* Colunas SigCdGcr : codigos c(10) PK, descrs c(40)
*==============================================================================

DEFINE CLASS HORBO AS BusinessBase

    *-- Identifica??o da tabela
    this_cTabela      = "SigCdThs"
    this_cCampoChave  = "cidchaves"

    *-- Par?metros do form (recebidos do caller)
    this_cSetors      = ""      && Fase/Setor - char(10) - coluna setors
    this_cUniPrdts    = ""      && Unidade Produtiva - char(10) - coluna uniprdts
    this_cDFases      = ""      && Descri??o da Fase (SigCdGcr.descrs)

    *-- Modo de opera??o (equivalente a pcEscolha do legado)
    this_cPcEscolha   = ""      && CONSULTAR / INSERIR / ALTERAR / EXCLUIR / COPIARP

    *-- Dados do registro corrente (SigCdThs)
    this_cCidChaves   = ""      && PK - char(20) - coluna cidchaves
    this_dDatas       = {}      && Data do registro - coluna datas (datetime)
    this_nQtds        = 0       && Quantidade - numeric(4,1) - coluna qtds
    this_nQtHoras     = 0       && Horas por dia - numeric(4,2) - coluna qthoras

    *-- Sele??o de per?odo (para modos INSERIR / COPIARP)
    this_cMes         = ""      && M?s selecionado - char(2)
    this_cAno         = ""      && Ano selecionado - char(4)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim?ria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDescricaoFase - Busca descri??o da Fase/Setor em SigCdGcr
    * Retorna: .T. se encontrado, .F. se n?o encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarDescricaoFase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDFases = ""

            IF !EMPTY(THIS.this_cSetors)
                loc_cSQL = "SELECT descrs FROM SigCdGcr " + ;
                           "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10))

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFase")
                IF loc_nRet > 0 AND USED("cursor_4c_DescFase") AND !EOF("cursor_4c_DescFase")
                    THIS.this_cDFases = ALLTRIM(cursor_4c_DescFase.descrs)
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDescricaoFase")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeMesAno - Carrega cursor crMesAno com meses/anos existentes
    * em SigCdThs para o Setor e Unidade Produtiva atuais
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("crMesAno")
                ZAP IN crMesAno

                loc_cSQL = "SELECT DISTINCT datas " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " ORDER BY datas"

                IF USED("cursor_4c_DatasTemp")
                    USE IN cursor_4c_DatasTemp
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DatasTemp")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarGradeMesAno).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    *-- Extrai mes/ano distintos do cursor de datas
                    SELECT DISTINCT ;
                        SUBSTR(DTOS(TTOD(datas)), 5, 2) AS Mes, ;
                        SUBSTR(DTOS(TTOD(datas)), 1, 4) AS Ano ;
                    FROM cursor_4c_DatasTemp ;
                    INTO CURSOR cursor_4c_MesAnoTemp READWRITE

                    SELECT cursor_4c_MesAnoTemp
                    SCAN
                        INSERT INTO crMesAno (Mes, Ano) ;
                            VALUES (cursor_4c_MesAnoTemp.Mes, cursor_4c_MesAnoTemp.Ano)
                    ENDSCAN

                    IF USED("cursor_4c_DatasTemp")
                        USE IN cursor_4c_DatasTemp
                    ENDIF
                    IF USED("cursor_4c_MesAnoTemp")
                        USE IN cursor_4c_MesAnoTemp
                    ENDIF

                    *-- Posiciona no m?s corrente se existir
                    SET NEAR ON
                    =SEEK(SUBSTR(DTOS(DATE()), 1, 6), "crMesAno", "Ordem")
                    SET NEAR OFF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarGradeMesAno")

            IF USED("cursor_4c_DatasTemp")
                USE IN cursor_4c_DatasTemp
            ENDIF
            IF USED("cursor_4c_MesAnoTemp")
                USE IN cursor_4c_MesAnoTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCalendario - Carrega crCalendario para o mes/ano informado
    * par_cMes   : Mes desejado (char 2, ex: "08")
    * par_cAno   : Ano desejado (char 4, ex: "2026")
    * par_lTrunc  : .T. = truncar e recalcular dias; .F. = apenas carregar
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarCalendario(par_cMes, par_cAno, par_lTrunc)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDia, loc_ldDtF, loc_ldDtI
        LOCAL loc_nDow, loc_ldDay
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_nHor, loc_nQts
        LOCAL loc_llZer
        LOCAL loc_nDia, loc_nObj, loc_cObj
        LOCAL loc_nHorTotal, loc_nQth, loc_nQtd
        LOCAL loc_cHrr
        loc_lSucesso = .F.

        TRY
            IF USED("crCalendario")
                loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                *-- Busca dados de SigCdThs para o per?odo
                loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDia, 1) - 1, .T.)

                loc_cSQL = "SELECT * " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                IF USED("cursor_4c_TmpCtHr")
                    USE IN cursor_4c_TmpCtHr
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCtHr")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    SELECT cursor_4c_TmpCtHr
                    INDEX ON DTOS(TTOD(datas)) TAG Datas

                    *-- Modo truncar: recalcula horas conforme SigCdUpd
                    LOCAL loc_lTruncOk
                    loc_lTruncOk = .T.
                    IF par_lTrunc
                        loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                                   "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                   " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                        IF loc_nRet < 1
                            MsgErro("Falha ao consultar SigCdUpd (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                            IF USED("cursor_4c_TmpCtHr")
                                USE IN cursor_4c_TmpCtHr
                            ENDIF
                            loc_lTruncOk = .F.
                        ELSE
                            GO TOP IN cursor_4c_LocalUPrdt

                            loc_nHds = cursor_4c_LocalUPrdt.hordds
                            loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                            loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                            FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDia, 1) - 1)
                                loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + par_cMes + "/" + par_cAno)

                                loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                                loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                                loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                                IF SEEK(DTOS(loc_ldDay), "cursor_4c_TmpCtHr", "Datas")
                                    SELECT cursor_4c_TmpCtHr
                                    REPLACE qtds    WITH loc_nQts, ;
                                            qthoras WITH loc_nHor
                                ELSE
                                    INSERT INTO cursor_4c_TmpCtHr ;
                                        (setors, uniprdts, datas, qtds, qthoras) ;
                                    VALUES ;
                                        (THIS.this_cSetors, THIS.this_cUniPrdts, ;
                                         loc_ldDay, loc_nQts, loc_nHor)
                                ENDIF
                            NEXT

                            IF USED("cursor_4c_LocalUPrdt")
                                USE IN cursor_4c_LocalUPrdt
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lTruncOk
                        *-- Alimenta crCalendario com dados do m?s
                        ZAP IN crCalendario

                        IF RECCOUNT("cursor_4c_TmpCtHr") > 0
                            APPEND BLANK IN crCalendario
                            GO TOP IN crCalendario

                            loc_nDow = 1
                            loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                            FOR loc_nObj = 1 TO 42
                                loc_cObj = PADL(loc_nObj, 2, "0")

                                *-- Limpa slot do calend?rio
                                SELECT crCalendario
                                REPLACE ("Data"    + loc_cObj) WITH CTOD(""), ;
                                        ("QtHoras" + loc_cObj) WITH 0, ;
                                        ("Qtds"    + loc_cObj) WITH 0

                                IF loc_nDow = DOW(loc_ldDia) AND MONTH(loc_ldDia) = INT(VAL(par_cMes))
                                    loc_nHorTotal = 0
                                    loc_nQth = 0
                                    loc_nQtd = 0

                                    IF SEEK(DTOS(loc_ldDia), "cursor_4c_TmpCtHr", "Datas")
                                        loc_nQth      = cursor_4c_TmpCtHr.qthoras
                                        loc_nQtd      = cursor_4c_TmpCtHr.qtds
                                        loc_nHorTotal = THIS.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                                    ENDIF

                                    SELECT crCalendario
                                    REPLACE ("Data"    + loc_cObj) WITH loc_ldDia, ;
                                            ("QtHoras" + loc_cObj) WITH loc_nQth, ;
                                            ("Qtds"    + loc_cObj) WITH loc_nQtd

                                    loc_ldDia = loc_ldDia + 1
                                ENDIF

                                loc_nDow = loc_nDow + 1
                                IF loc_nDow > 7
                                    loc_nDow = 1
                                ENDIF
                            NEXT
                        ENDIF

                        IF USED("cursor_4c_TmpCtHr")
                            USE IN cursor_4c_TmpCtHr
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarCalendario")

            IF USED("cursor_4c_TmpCtHr")
                USE IN cursor_4c_TmpCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPeriodo - Insere novo per?odo de carga hor?ria
    * par_cMes : M?s do per?odo (char 2)
    * par_cAno : Ano do per?odo (char 4)
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION InserirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_ldDay, loc_llZer, loc_nHor, loc_nQts
        LOCAL loc_nDia
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            *-- Verifica se j? existem lan?amentos no per?odo
            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtHr")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkCtHr") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF

                    *-- Busca configura??o da unidade produtiva em SigCdUpd
                    loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                               "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                    IF USED("cursor_4c_LocalUPrdt")
                        USE IN cursor_4c_LocalUPrdt
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar SigCdUpd (InserirPeriodo).", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        GO TOP IN cursor_4c_LocalUPrdt

                        loc_nHds = cursor_4c_LocalUPrdt.hordds
                        loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                        loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        *-- Cria cursor de work para inser??o em lote
                        IF USED("crSigCdThs")
                            TABLEREVERT(.T., "crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        SET NULL ON
                        CREATE CURSOR crSigCdThs ;
                            (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                             qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                             setors C(10) NULL, uniprdts C(10) NULL)
                        SET NULL OFF

                        *-- Insere um registro por dia do m?s
                        FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDat, 1) - 1)
                            loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))

                            loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                            loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                            loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                            SELECT crSigCdThs
                            APPEND BLANK
                            REPLACE setors    WITH THIS.this_cSetors, ;
                                    uniprdts  WITH THIS.this_cUniPrdts, ;
                                    qtds      WITH loc_nQts, ;
                                    qthoras   WITH loc_nHor, ;
                                    datas     WITH loc_ldDay, ;
                                    cidchaves WITH THIS.GerarChaveUnica()
                        NEXT

                        *-- Envia para SQL Server via SQLEXEC INSERT em lote
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                        IF USED("crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        *-- Atualiza crMesAno se o m?s n?o existia
                        IF loc_lSucesso AND USED("crMesAno")
                            IF !SEEK(SUBSTR(DTOS(loc_ldDat), 1, 6), "crMesAno", "Ordem")
                                INSERT INTO crMesAno (Mes, Ano) ;
                                    VALUES (SUBSTR(DTOS(loc_ldDat), 5, 2), SUBSTR(DTOS(loc_ldDat), 1, 4))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.InserirPeriodo")

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlterarPeriodo - Altera dados do per?odo atual a partir de crCalendario
    * Retorna: .T. se alterado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION AlterarPeriodo()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_ldDtI, loc_ldDtF
        LOCAL loc_nQth, loc_nQtd
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            IF USED("crCalendario")
                IF USED("crSigCdThs")
                    TABLEREVERT(.T., "crSigCdThs")
                    USE IN crSigCdThs
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigCdThs ;
                    (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                     qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                     setors C(10) NULL, uniprdts C(10) NULL)
                SET NULL OFF

                LOCAL loc_lLoopOk
                loc_lLoopOk = .T.

                FOR loc_nObj = 1 TO 42
                    IF loc_lLoopOk
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        SELECT crCalendario
                        loc_ldDia = EVALUATE("Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("Qtds"    + loc_cObj)

                            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                            loc_ldDtF = THIS.FormatarDataSQL(loc_ldDia, .T.)

                            *-- Busca registro existente para o dia
                            loc_cSQL = "SELECT * FROM SigCdThs " + ;
                                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                            IF loc_nRet < 1
                                MsgErro("Falha ao consultar SigCdThs (AlterarPeriodo).", "Erro de Conex" + CHR(227) + "o")
                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF
                                loc_lLoopOk = .F.
                            ELSE
                                SELECT crSigCdThs
                                IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                                    *-- Existe: copia e atualiza horas/qtd
                                    GO TOP IN cursor_4c_LocalCtHr
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE cidchaves WITH cursor_4c_LocalCtHr.cidchaves, ;
                                            codigos   WITH cursor_4c_LocalCtHr.codigos, ;
                                            datas     WITH cursor_4c_LocalCtHr.datas, ;
                                            setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth
                                ELSE
                                    *-- N?o existe: insere novo registro
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE setors    WITH THIS.this_cSetors, ;
                                            uniprdts  WITH THIS.this_cUniPrdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth, ;
                                            datas     WITH loc_ldDia, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                ENDIF

                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF

                                loc_lUpd = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                NEXT

                IF loc_lLoopOk
                    IF loc_lUpd
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdThs")
                    USE IN crSigCdThs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.AlterarPeriodo")

            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirPeriodo - Exclui todos os registros do per?odo (mes/ano)
    * par_cMes : M?s a excluir (char 2)
    * par_cAno : Ano a excluir (char 4)
    * Retorna: .T. se exclu?do com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION ExcluirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            loc_cSQL = "DELETE FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult")
            IF loc_nRet < 1
                MsgErro("Falha ao excluir per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_DelResult")
                    USE IN cursor_4c_DelResult
                ENDIF

                *-- Remove da crMesAno
                IF USED("crMesAno")
                    DELETE FROM crMesAno ;
                    WHERE Mes = SUBSTR(DTOS(loc_ldDat), 5, 2) AND ;
                          Ano = SUBSTR(DTOS(loc_ldDat), 1, 4)
                    PACK IN crMesAno
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.ExcluirPeriodo")

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CopiarPeriodo - Copia per?odo do mes/ano selecionado para outro mes/ano
    * par_cMesOrig : M?s de origem (mes do crMesAno selecionado no grid)
    * par_cAnoOrig : Ano de origem
    * par_cMesDest : M?s de destino (digitado pelo usu?rio)
    * par_cAnoDest : Ano de destino (digitado pelo usu?rio)
    * Retorna: .T. se copiado com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION CopiarPeriodo(par_cMesOrig, par_cAnoOrig, par_cMesDest, par_cAnoDest)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_ldDatDest, loc_ldDtI, loc_ldDtF
        LOCAL loc_ldDatOrig, loc_ldDtIOrig, loc_ldDtFOrig
        LOCAL loc_ldDtn
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            *-- Verifica se destino j? tem lan?amentos
            loc_ldDatDest = CTOD("01/" + PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDatDest)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDatDest, 1) - 1, .T.)

            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDest")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar destino em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkDest") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF

                    *-- Busca registros de origem
                    loc_ldDatOrig = CTOD("01/" + PADL(par_cMesOrig, 2, "0") + "/" + PADL(par_cAnoOrig, 4, "0"))
                    loc_ldDtIOrig = THIS.FormatarDataSQL(loc_ldDatOrig)
                    loc_ldDtFOrig = THIS.FormatarDataSQL(GOMONTH(loc_ldDatOrig, 1) - 1, .T.)

                    loc_cSQL = "SELECT * FROM SigCdThs " + ;
                               "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + loc_ldDtIOrig + " AND " + loc_ldDtFOrig

                    IF USED("cursor_4c_LocalCtHr")
                        USE IN cursor_4c_LocalCtHr
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar origem em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                            IF USED("crSigCdThs")
                                TABLEREVERT(.T., "crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF

                            SET NULL ON
                            CREATE CURSOR crSigCdThs ;
                                (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                                 qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                                 setors C(10) NULL, uniprdts C(10) NULL)
                            SET NULL OFF

                            SELECT cursor_4c_LocalCtHr
                            SCAN
                                *-- Ajusta dia para o m?s destino
                                loc_ldDtn = CTOD(SUBSTR(DTOC(cursor_4c_LocalCtHr.datas), 1, 3) + ;
                                                 PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))

                                IF !EMPTY(loc_ldDtn)
                                    SELECT crSigCdThs
                                    APPEND BLANK
                                    REPLACE setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH cursor_4c_LocalCtHr.qtds, ;
                                            qthoras   WITH cursor_4c_LocalCtHr.qthoras, ;
                                            datas     WITH loc_ldDtn, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                    loc_lUpd = .T.
                                ENDIF
                            ENDSCAN

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            IF loc_lUpd
                                loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                                *-- Atualiza crMesAno com o novo per?odo
                                IF loc_lSucesso AND USED("crMesAno") AND !EMPTY(loc_ldDtn)
                                    INSERT INTO crMesAno (Mes, Ano) ;
                                        VALUES (SUBSTR(DTOS(loc_ldDtn), 5, 2), SUBSTR(DTOS(loc_ldDtn), 1, 4))
                                ENDIF
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF

                            IF USED("crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CopiarPeriodo")

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF
            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnviarCursorParaServidor - Insere/atualiza registros de crSigCdThs
    * no SQL Server usando SQLEXEC por registro
    * Retorna: .T. se todos enviados com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EnviarCursorParaServidor(par_cCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_nCodigos, loc_ldDatas
        LOCAL loc_nQtds, loc_nQtHoras, loc_cSetors, loc_cUniPrdts
        loc_lSucesso = .T.

        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                SELECT (par_cCursor)
                GO TOP

                SCAN
                    loc_cCidChaves = ALLTRIM(EVALUATE(par_cCursor + ".cidchaves"))
                    loc_nCodigos   = EVALUATE(par_cCursor + ".codigos")
                    loc_ldDatas    = EVALUATE(par_cCursor + ".datas")
                    loc_nQtds      = EVALUATE(par_cCursor + ".qtds")
                    loc_nQtHoras   = EVALUATE(par_cCursor + ".qthoras")
                    loc_cSetors    = ALLTRIM(EVALUATE(par_cCursor + ".setors"))
                    loc_cUniPrdts  = ALLTRIM(EVALUATE(par_cCursor + ".uniprdts"))

                    *-- Tenta UPDATE primeiro
                    loc_cSQL = "UPDATE SigCdThs " + ;
                               "SET qtds = " + FormatarNumeroSQL(loc_nQtds, 1) + ;
                               ", qthoras = " + FormatarNumeroSQL(loc_nQtHoras, 2) + ;
                               " WHERE setors = " + EscaparSQL(PADR(loc_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + THIS.FormatarDataSQL(loc_ldDatas) + ;
                               " AND " + THIS.FormatarDataSQL(loc_ldDatas, .T.)

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdResult")

                    IF USED("cursor_4c_UpdResult")
                        USE IN cursor_4c_UpdResult
                    ENDIF

                    *-- Verifica linhas afetadas: 0 = novo registro, faz INSERT
                    LOCAL loc_nAffected
                    loc_nAffected = 0
                    IF loc_nRet >= 1
                        IF SQLEXEC(gnConnHandle, "SELECT @@ROWCOUNT AS rn", "cursor_4c_RowCnt") >= 1
                            loc_nAffected = cursor_4c_RowCnt.rn
                        ENDIF
                        IF USED("cursor_4c_RowCnt")
                            USE IN cursor_4c_RowCnt
                        ENDIF
                    ENDIF

                    *-- Se UPDATE nao afetou nenhuma linha, faz INSERT
                    IF loc_nRet < 1 OR loc_nAffected = 0
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF
                        loc_cSQL = "INSERT INTO SigCdThs " + ;
                                   "(cidchaves, codigos, setors, uniprdts, datas, qtds, qthoras) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", 0, " + ;
                                   EscaparSQL(PADR(loc_cSetors, 10)) + ", " + ;
                                   EscaparSQL(PADR(loc_cUniPrdts, 10)) + ", " + ;
                                   THIS.FormatarDataSQL(loc_ldDatas) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtds, 1) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtHoras, 2) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult")
                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF

                        IF loc_nRet < 1
                            MsgErro("Falha ao inserir registro em SigCdThs.", "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.EnviarCursorParaServidor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave prim?ria ?nica (char 20)
    * Usa NEWID() do SQL Server para gerar GUID truncado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRet
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, "SELECT LEFT(REPLACE(NEWID(),'-',''),20) AS nova_chave", "cursor_4c_NewId")
            IF loc_nRet > 0 AND USED("cursor_4c_NewId") AND !EOF("cursor_4c_NewId")
                loc_cChave = ALLTRIM(cursor_4c_NewId.nova_chave)
            ENDIF

            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            *-- Fallback com SYS(2015) se SQL falhar
            loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)
        ENDTRY

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarFeriado - Verifica se uma data ? feriado em SigCdThs (stub)
    * Substitui fChkFeriado() do legado
    * par_ldData : Data a verificar
    * Retorna: .T. se for feriado, .F. caso contr?rio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarFeriado(par_ldData)
        LOCAL loc_lFeriado, loc_cSQL, loc_nRet
        loc_lFeriado = .F.

        TRY
            *-- Verifica em SigCdThs se o dia tem qthoras=0 explicitamente (feriado configurado)
            *-- Na aus?ncia de tabela de feriados dedicada no sistema, retorna .F. por padr?o
            *-- O legado usava fChkFeriado() do framework que consultava tabela de feriados
            loc_lFeriado = .F.
        CATCH TO loc_oErro
            loc_lFeriado = .F.
        ENDTRY

        RETURN loc_lFeriado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataSQL - Formata data para SQL Server incluindo hora opcional
    * par_ldData   : Data a formatar
    * par_lComHora : .T. = adiciona "23:59:59" (fim do dia)
    * Retorna: string no formato 'YYYY-MM-DD HH:MM:SS' entre aspas simples
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDataSQL(par_ldData, par_lComHora)
        LOCAL loc_cData
        loc_cData = "NULL"

        TRY
            IF !EMPTY(par_ldData) AND par_ldData <> {}
                IF VARTYPE(par_lComHora) = "L" AND par_lComHora
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 23:59:59'"
                ELSE
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 00:00:00'"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cData = "NULL"
        ENDTRY

        RETURN loc_cData
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConverterHorasParaDecimal - Converte horas*qtd para valor decimal total
    * Substitui: Val(Strtran(fMtoH(fHtoM(Str(qtHoras,5,2)) * qtds), ':', '.'))
    * par_nQtHoras : Horas por dia (numeric)
    * par_nQtds    : Quantidade (numeric)
    * Retorna: valor decimal total de horas
    *--------------------------------------------------------------------------
    FUNCTION ConverterHorasParaDecimal(par_nQtHoras, par_nQtds)
        LOCAL loc_nTotalMinutos, loc_nHoras, loc_nMinutos, loc_nDecimal
        loc_nDecimal = 0

        TRY
            *-- fHtoM: horas decimais -> minutos (ex: 8.30 -> 510 min)
            *-- QtHoras est? no formato decimal (8.5 = 8h30)
            loc_nTotalMinutos = INT(par_nQtHoras) * 60 + ;
                                (par_nQtHoras - INT(par_nQtHoras)) * 100
            loc_nTotalMinutos = loc_nTotalMinutos * par_nQtds

            *-- fMtoH: minutos -> horas decimal
            loc_nHoras   = INT(loc_nTotalMinutos / 60)
            loc_nMinutos = MOD(loc_nTotalMinutos, 60)
            loc_nDecimal = VAL(TRANSFORM(loc_nHoras, "@L 9999") + "." + PADL(TRANSFORM(loc_nMinutos, "@L 99"), 2, "0"))
        CATCH TO loc_oErro
            loc_nDecimal = 0
        ENDTRY

        RETURN loc_nDecimal
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * par_cAliasCursor : Alias do cursor (ex: crMesAno)
    * Retorna: .T. se carregado com sucesso, .F. se cursor n?o aberto
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cMes = TratarNulo(Mes, "C")
                THIS.this_cAno = TratarNulo(Ano, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigat?rios antes de Inserir/Atualizar
    * Retorna: .T. se v?lido, .F. se inv?lido (exibe mensagem ao usu?rio)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cMes)
            MsgAviso("M" + CHR(234) + "s obrigat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cAno) OR LEN(ALLTRIM(THIS.this_cAno)) < 4
            MsgAviso("Ano obrigat" + CHR(243) + "rio (4 d" + CHR(237) + "gitos).")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cSetors)
            MsgAviso("Fase/Setor obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cUniPrdts)
            MsgAviso("Unidade Produtiva obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Cria novo per?odo de carga hor?ria no SQL Server
    * Delega para InserirPeriodo usando this_cMes e this_cAno
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.InserirPeriodo(THIS.this_cMes, THIS.this_cAno)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Grava altera??es do calend?rio atual para o SQL Server
    * Delega para AlterarPeriodo que usa crCalendario como fonte
    * Retorna: .T. se atualizado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.AlterarPeriodo()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("U")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
