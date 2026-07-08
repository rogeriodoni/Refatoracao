*==============================================================================
* SIGREJOBBO.PRG
* Business Object para Relatorio de Briefing do Job (SigReJob)
*
* Herda de RelatorioBase
* Emite relatorio SigReJb1.frx em duas passagens:
*   Passagem 1 = Relatorio 1 (cursor crImpressao  - campos Jb_003 a Jb_016)
*   Passagem 2 = Relatorio 2 (cursor crImpressa2  - campos Jb_017+ e blocos)
*
* IMPORTANTE: este BO e invocado por um form-filho que recebe pFrm (ParentForm).
* O ParentForm possui os cursors TprMvCab, crSigOpCdI e crSigMvJbC ja abertos
* na sua datasession. O BO acessa esses cursors via this_oParentForm.
*==============================================================================

DEFINE CLASS SigReJobBO AS RelatorioBase

    *-- Referencia ao formulario pai (FormJob ou equivalente) que abriu o relatorio
    this_oParentForm     = .NULL.

    *-- Complemento do titulo dos relatorios (linha de OBS do cabecalho do movimento)
    this_cCompTits       = ""

    *-- Passagem atual: 1 = Relatorio 1 (crImpressao), 2 = Relatorio 2 (crImpressa2)
    this_nPassagem       = 0

    *-- Flag: imprimir documento (chkimpdoc do form original)
    this_lChkImpDoc      = .F.

    *-- Flag: imprimir documento acessivel (chkimpdocacess do form original)
    this_lChkImpDocAcess = .F.

    *-- Conta de email para envio do documento (ContaEmail do form original)
    this_cContaEmail     = ""

    *-- Caminho completo do arquivo FRX do relatorio
    this_cCaminhoFRX     = ""

    *-- DivNotas da empresa (0=nao carregado, 1=ambas, 2=somente Emp1, 3=somente Emp2)
    this_nDivNotas       = 0
    *-- Valores calculados em PrepararRelatorio1 e reutilizados em PrepararRelatorio2
    this_cJobLinha       = ""
    this_cCliLinha       = ""
    this_cCttLinha       = ""
    this_cDtEntrada      = ""
    this_cExtLinha       = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO e caminho do FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_cCaminhoFRX = gc_4c_CaminhoReports + "SigReJb1.frx"
        THIS.this_nPassagem   = 1
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de referencias
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Inicializar - Configura referencia ao form pai e carrega CompTits do DB
    * par_oParentForm: referencia ao form que abriu este relatorio (FormJob etc.)
    *--------------------------------------------------------------------------
    PROCEDURE Inicializar(par_oParentForm)
        LOCAL loc_lSucesso, loc_lcQuery, loc_lnResult
        loc_lSucesso = .F.
        TRY
            THIS.this_oParentForm = par_oParentForm
            THIS.this_cCompTits   = ""
            THIS.this_nPassagem   = 1

            loc_lcQuery = "SELECT ObsCabMovs FROM SigMvCab " + ;
                          "WHERE EmpDopNums = '" + ;
                          ALLTRIM(TprMvCab.Emps) + ALLTRIM(TprMvCab.Dopes) + ;
                          STR(TprMvCab.Numes, 6) + "'"
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_LocalCab")
            IF loc_lnResult >= 1
                SELECT cursor_4c_LocalCab
                GO TOP IN cursor_4c_LocalCab
                IF !EOF("cursor_4c_LocalCab")
                    THIS.this_cCompTits = CHR(13) + ALLTRIM(cursor_4c_LocalCab.ObsCabMovs)
                ENDIF
                USE IN cursor_4c_LocalCab
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQueryStr - Lookup por chave string (equivalente ao poDataMgr.CursorQuery)
    * Parametros: tabela, alias destino, campo chave, valor chave, lista de campos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CursorQueryStr(par_cTabela, par_cAlias, par_cChave, par_cValor, par_cCampos)
        LOCAL loc_lnResult
        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF
        loc_lnResult = SQLEXEC(gnConnHandle, ;
            "SELECT " + par_cCampos + ;
            " FROM " + par_cTabela + ;
            " WHERE " + par_cChave + " = " + EscaparSQL(ALLTRIM(par_cValor)), ;
            par_cAlias)
        RETURN (loc_lnResult >= 1 AND USED(par_cAlias))
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Wrapper com TRY/CATCH que orquestra criacao dos cursores
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.PrepararDadosInterno()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosInterno - Cria crCabecalho, crImpressao (pass.1) e crImpressa2 (pass.2)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararDadosInterno()
        IF !THIS.PrepararCabecalho()
            RETURN .F.
        ENDIF
        IF !THIS.PrepararRelatorio1()
            RETURN .F.
        ENDIF
        IF !THIS.PrepararRelatorio2()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCabecalho - Monta crCabecalho: titulo, subtitulo, rodape, aprovado
    * Acessa cursors TprMvCab, crSigOpCdI, crSigCdOpe da datasession do form pai
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCabecalho()
        LOCAL loc_lcRe1, loc_lcSb1, loc_lcRdp, loc_lcApr, loc_lcEdn
        LOCAL loc_lcQuery, loc_lnResult, loc_lnCod, loc_lnEmp, loc_lcCfgResp

        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        CREATE CURSOR crCabecalho (Titulo M(4), Subtitulo M(4), Rodape M(4), Aprovados C(100))

        loc_lcRe1 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 001, 50))), ;
                    "Relat" + CHR(243) + "rio de Briefing", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 001, 50))) + ;
                    THIS.this_cCompTits

        loc_lcSb1 = PROPER(ALLTRIM(TprMvCab.Dopes)) + " - " + ;
                    ALLTRIM(STR(TprMvCab.Numes, 10)) + " - " + ;
                    DTOC(TTOD(TprMvCab.Datas))

        IF !THIS.CursorQueryStr("SigCdEmp", "cursor_4c_LocalEmps", "Cemps", TprMvCab.Emps, "DivNotas")
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (SigReJob - LocalEmps)")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_LocalEmps
        GO TOP IN cursor_4c_LocalEmps
        loc_lnEmp = IIF(EOF("cursor_4c_LocalEmps"), 1, cursor_4c_LocalEmps.DivNotas)
        USE IN cursor_4c_LocalEmps
        THIS.this_nDivNotas = loc_lnEmp

        IF VARTYPE(THIS.this_oParentForm) = "O"
            loc_lcCfgResp = ALLTRIM(NVL(THIS.this_oParentForm.CfgTitResponsavel, ""))
        ELSE
            loc_lcCfgResp = "Respons" + CHR(225) + "vel"
        ENDIF
        IF EMPTY(loc_lcCfgResp)
            loc_lcCfgResp = "Respons" + CHR(225) + "vel"
        ENDIF

        loc_lcRdp = "Data : " + DTOC(TTOD(TprMvCab.Datas)) + SPACE(5) + loc_lcCfgResp + " : "
        IF !EMPTY(ALLTRIM(TprMvCab.Resps))
            IF !THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", TprMvCab.Resps, "RClis")
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 1)")
                RETURN .F.
            ENDIF
            SELECT cursor_4c_LocalBus
            GO TOP IN cursor_4c_LocalBus
            IF !EOF("cursor_4c_LocalBus")
                loc_lcRdp = loc_lcRdp + ALLTRIM(cursor_4c_LocalBus.RClis)
            ENDIF
            USE IN cursor_4c_LocalBus
        ENDIF
        loc_lcRdp = loc_lcRdp + CHR(13)

        loc_lnCod = (crSigCdOpe.NDopes * 1000000) + TprMvCab.Numes

        loc_lcQuery = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
                      "b.Datars, c.TitOpes " + ;
                      "FROM SigMvPec a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
                      "WHERE a.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
                      "a.EmpDopNums = b.EmpDopNums AND " + ;
                      "a.EmpSubns = '" + ALLTRIM(TprMvCab.Emps) + "' AND " + ;
                      "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
                      "UNION ALL " + ;
                      "SELECT o.Emps, o.Dopes, o.Numes, b.Datas, b.Resps, d.RClis, " + ;
                      "b.Datars, c.TitOpes " + ;
                      "FROM SigOpDev o, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
                      "WHERE o.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
                      "o.EmpDopNums = b.EmpDopNums AND " + ;
                      "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
                      "ORDER BY b.Datars"

        loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_LocalBus")
        IF loc_lnResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 2)")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_LocalBus
        GO TOP IN cursor_4c_LocalBus
        IF EOF("cursor_4c_LocalBus")
            loc_lcRdp = loc_lcRdp + "Data :     /   /        " + SPACE(5) + "Aprovado por : "
            loc_lcEdn = ""
        ELSE
            loc_lcRdp = loc_lcRdp + "Data : " + DTOC(TTOD(cursor_4c_LocalBus.Datas)) + ;
                        SPACE(5) + PROPER(ALLTRIM(cursor_4c_LocalBus.TitOpes)) + ;
                        " : " + ALLTRIM(cursor_4c_LocalBus.RClis)
            loc_lcEdn = cursor_4c_LocalBus.Emps + cursor_4c_LocalBus.Dopes + ;
                        STR(cursor_4c_LocalBus.Numes, 6)
        ENDIF
        USE IN cursor_4c_LocalBus
        loc_lcRdp = loc_lcRdp + CHR(13)

        loc_lcApr = "Aprova" + CHR(231) + CHR(227) + "o Cliente"

        IF EMPTY(ALLTRIM(loc_lcEdn))
            loc_lcRdp = loc_lcRdp + "Data :     /   /        " + SPACE(5) + loc_lcApr + " : "
        ELSE
            IF !THIS.CursorQueryStr("SigCdOpe", "cursor_4c_LocalOpe", "Dopes", ;
                                    SUBSTR(loc_lcEdn, 4, 20), "NDopes")
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 3)")
                RETURN .F.
            ENDIF
            SELECT cursor_4c_LocalOpe
            GO TOP IN cursor_4c_LocalOpe
            IF !EOF("cursor_4c_LocalOpe")
                loc_lnCod = (cursor_4c_LocalOpe.NDopes * 1000000) + INT(VAL(RIGHT(loc_lcEdn, 6)))

                loc_lcQuery = "SELECT a.Emps, a.Dopes, a.Numes, b.Datas, b.Resps, d.RClis, " + ;
                              "b.Datars, c.TitOpes " + ;
                              "FROM SigMvPec a, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
                              "WHERE a.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
                              "a.EmpDopNums = b.EmpDopNums AND " + ;
                              "a.EmpSubns = '" + ALLTRIM(TprMvCab.Emps) + "' AND " + ;
                              "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
                              "UNION ALL " + ;
                              "SELECT o.Emps, o.Dopes, o.Numes, b.Datas, b.Resps, d.RClis, " + ;
                              "b.Datars, c.TitOpes " + ;
                              "FROM SigOpDev o, SigMvCab b, SigCdOpe c, SigCdCli d " + ;
                              "WHERE o.Codigos = " + ALLTRIM(STR(loc_lnCod, 10)) + " AND " + ;
                              "o.EmpDopNums = b.EmpDopNums AND " + ;
                              "b.Dopes = c.Dopes AND b.Resps = d.IClis " + ;
                              "ORDER BY b.Datars"

                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_LocalBus")
                IF loc_lnResult < 1
                    USE IN cursor_4c_LocalOpe
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 4)")
                    RETURN .F.
                ENDIF
                SELECT cursor_4c_LocalBus
                GO TOP IN cursor_4c_LocalBus
                IF EOF("cursor_4c_LocalBus")
                    loc_lcRdp = loc_lcRdp + "Data :     /   /        " + ;
                                SPACE(5) + "Aprova" + CHR(231) + CHR(227) + "o Cliente : "
                ELSE
                    loc_lcRdp = loc_lcRdp + "Data : " + ;
                                DTOC(TTOD(cursor_4c_LocalBus.Datas)) + SPACE(5) + ;
                                PROPER(ALLTRIM(cursor_4c_LocalBus.TitOpes)) + ;
                                " : " + ALLTRIM(cursor_4c_LocalBus.RClis)
                    loc_lcApr = PROPER(ALLTRIM(cursor_4c_LocalBus.TitOpes))
                ENDIF
                USE IN cursor_4c_LocalBus
            ENDIF
            USE IN cursor_4c_LocalOpe
        ENDIF

        INSERT INTO crCabecalho (Titulo, Subtitulo, Rodape, Aprovados) ;
                         VALUES (loc_lcRe1, loc_lcSb1, loc_lcRdp, loc_lcApr)
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararRelatorio1 - Monta crImpressao com campos Jb_003 a Jb_016 (Passagem 1)
    * Armazena this_cJobLinha, this_cCliLinha, this_cCttLinha, this_cDtEntrada, this_cExtLinha
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararRelatorio1()
        LOCAL loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, loc_lcDtT
        LOCAL loc_lcB01, loc_lcExt, loc_lcQuery, loc_lnResult, loc_lnCnt
        LOCAL loc_lcTit, loc_lcCnt, loc_lcVal
        DIMENSION loc_laImp(16, 2)

        IF USED("crImpressao")
            USE IN crImpressao
        ENDIF
        CREATE CURSOR crImpressao (Jobs C(250), Clientes C(250), Contatos C(250), ;
                                   DtEntradas C(100), DtApresentas C(100), DtEntregas C(100), ;
                                   Extras C(100), Bloco001 M(4), TitCampo M(4), ValCampo M(4))

        *-- Campo do Job
        loc_lcJob = ALLTRIM(TprMvCab.Jobs)
        IF !EMPTY(ALLTRIM(TprMvCab.Jobs))
            IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", ;
                                   TprMvCab.Jobs, "RClis, DataIncs, Usuars")
                SELECT cursor_4c_LocalBus
                GO TOP IN cursor_4c_LocalBus
                IF !EOF("cursor_4c_LocalBus")
                    loc_lcJob = loc_lcJob + " - " + ALLTRIM(cursor_4c_LocalBus.RClis)
                ENDIF
                USE IN cursor_4c_LocalBus
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 5)")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Campo do Cliente e Contatos
        loc_lcCli = ALLTRIM(TprMvCab.ContaOs)
        loc_lcCtt = ""
        IF !EMPTY(ALLTRIM(TprMvCab.ContaOs))
            IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", ;
                                   TprMvCab.ContaOs, "RClis, Ddds, Tel1s, Tel2s, Faxs, Contato, eMails")
                SELECT cursor_4c_LocalBus
                GO TOP IN cursor_4c_LocalBus
                IF !EOF("cursor_4c_LocalBus")
                    loc_lcCli = loc_lcCli + " - " + ALLTRIM(cursor_4c_LocalBus.RClis)
                    loc_lcCtt = ALLTRIM(NVL(crSigMvJbC.Jb_Contatos, ""))
                ENDIF
                USE IN cursor_4c_LocalBus
            ELSE
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 6)")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Data de Entrada: minima data do job no mesmo departamento
        loc_lcDtE = "Data de Entrada : "
        loc_lcQuery = "SELECT Jobs, Min(Datas) AS Datas FROM SigMvCab " + ;
                      "WHERE Dopes = '" + ALLTRIM(TprMvCab.Dopes) + "' AND " + ;
                      "Jobs = '" + ALLTRIM(TprMvCab.Jobs) + "' " + ;
                      "GROUP BY Jobs"
        loc_lnResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_LocalBus")
        IF loc_lnResult < 1
            MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (SigReJob - SelecionaDados 7)")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_LocalBus
        GO TOP IN cursor_4c_LocalBus
        IF !EOF("cursor_4c_LocalBus")
            loc_lcDtE = loc_lcDtE + DTOC(TTOD(cursor_4c_LocalBus.Datas))
        ENDIF
        USE IN cursor_4c_LocalBus

        loc_lcDtA = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0001, 50))), ;
                    "Apresenta" + CHR(231) + CHR(227) + "o : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0001, 50)) + " : ") + ;
                    IIF(ISNULL(crSigMvJbC.Jb_001), "", DTOC(TTOD(crSigMvJbC.Jb_001)))

        loc_lcDtT = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0051, 50))), ;
                    "Entrega : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0051, 50)) + " : ") + ;
                    IIF(ISNULL(crSigMvJbC.Jb_002), "", DTOC(TTOD(crSigMvJbC.Jb_002)))

        loc_lcB01 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 101, 50))), ;
                    "Briefing", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 101, 50)))

        loc_lcExt = "Briefing Extra : "
        IF !EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3351, 50)))
            loc_lcExt = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3351, 50)) + " : "
        ENDIF
        loc_lcExt = loc_lcExt + IIF(NVL(crSigMvJbC.Jb_072, 0) = 1, "Sim", "N" + CHR(227) + "o")

        *-- Armazenar para reutilizacao em PrepararRelatorio2
        THIS.this_cJobLinha  = loc_lcJob
        THIS.this_cCliLinha  = loc_lcCli
        THIS.this_cCttLinha  = loc_lcCtt
        THIS.this_cDtEntrada = loc_lcDtE
        THIS.this_cExtLinha  = loc_lcExt

        *-- Mapa de titulos e posicoes dos campos (indices 3 a 16)
        loc_laImp(03, 1) = "Sobre o Que Estamos Falando?"
        loc_laImp(03, 2) = 0351
        loc_laImp(04, 1) = "Hist" + CHR(243) + "rico"
        loc_laImp(04, 2) = 0401
        loc_laImp(05, 1) = "Contexto Mercadol" + CHR(243) + "gico"
        loc_laImp(05, 2) = 0451
        loc_laImp(06, 1) = "Cen" + CHR(225) + "rio"
        loc_laImp(06, 2) = 0501
        loc_laImp(07, 1) = "Target"
        loc_laImp(07, 2) = 0551
        loc_laImp(08, 1) = "O problema"
        loc_laImp(08, 2) = 0601
        loc_laImp(09, 1) = "Desafio"
        loc_laImp(09, 2) = 0651
        loc_laImp(10, 1) = "Objetivos"
        loc_laImp(10, 2) = 0701
        loc_laImp(11, 1) = "Tom de voz"
        loc_laImp(11, 2) = 0751
        loc_laImp(12, 1) = "Inspira" + CHR(231) + CHR(245) + "es"
        loc_laImp(12, 2) = 0801
        loc_laImp(13, 1) = "Cliente"
        loc_laImp(13, 2) = 0851
        loc_laImp(14, 1) = "Sugest" + CHR(245) + "es"
        loc_laImp(14, 2) = 0901
        loc_laImp(15, 1) = "Comunica" + CHR(231) + CHR(227) + "o"
        loc_laImp(15, 2) = 0951
        loc_laImp(16, 1) = "Informa" + CHR(231) + CHR(245) + "es do local do evento"
        loc_laImp(16, 2) = 1001

        FOR loc_lnCnt = 3 TO 16
            loc_lcTit = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), loc_laImp(loc_lnCnt, 2), 50))
            loc_lcTit = IIF(EMPTY(loc_lcTit), ALLTRIM(loc_laImp(loc_lnCnt, 1)), loc_lcTit)
            loc_lcCnt = PADL(loc_lnCnt, 3, "0")
            loc_lcVal = ALLTRIM(NVL(EVALUATE("crSigMvJbC.Jb_" + loc_lcCnt), ""))

            INSERT INTO crImpressao (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                     DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                             VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                     loc_lcDtT, loc_lcExt, loc_lcB01, loc_lcTit, loc_lcVal)
        NEXT

        SELECT crImpressao
        GO TOP IN crImpressao
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararRelatorio2 - Monta crImpressa2 com Jb_017+ e blocos (Passagem 2)
    * Reutiliza this_cJobLinha, this_cCliLinha, this_cCttLinha, this_cDtEntrada, this_cExtLinha
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararRelatorio2()
        LOCAL loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, loc_lcDtT
        LOCAL loc_lcExt, loc_lcB02, loc_lcVal, loc_lcNom, loc_lcTit, loc_lcMnt, loc_lcOut
        LOCAL loc_lnEmp

        IF USED("crImpressa2")
            USE IN crImpressa2
        ENDIF
        CREATE CURSOR crImpressa2 (Jobs C(250), Clientes C(250), Contatos C(250), ;
                                   DtEntradas C(100), DtApresentas C(100), DtEntregas C(100), ;
                                   Extras C(100), Bloco001 M(4), TitCampo M(4), ValCampo M(4))

        *-- Reutilizar valores ja calculados em PrepararRelatorio1
        loc_lcJob = THIS.this_cJobLinha
        loc_lcCli = THIS.this_cCliLinha
        loc_lcCtt = THIS.this_cCttLinha
        loc_lcDtE = THIS.this_cDtEntrada
        loc_lcExt = THIS.this_cExtLinha
        loc_lnEmp = THIS.this_nDivNotas

        loc_lcDtA = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0001, 50))), ;
                    "Apresenta" + CHR(231) + CHR(227) + "o : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0001, 50)) + " : ") + ;
                    IIF(ISNULL(crSigMvJbC.Jb_001), "", DTOC(TTOD(crSigMvJbC.Jb_001)))

        loc_lcDtT = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0051, 50))), ;
                    "Entrega : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0051, 50)) + " : ") + ;
                    IIF(ISNULL(crSigMvJbC.Jb_002), "", DTOC(TTOD(crSigMvJbC.Jb_002)))

        *-- Bloco 1: Periodo/Data + Montagem + Local + Publico + Budget
        IF EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0151, 50)))
            loc_lcMnt = "In" + CHR(237) + "cio de Montagem : " + ;
                        IIF(ISNULL(crSigMvJbC.Jb_019), "", DTOC(TTOD(crSigMvJbC.Jb_019))) + ;
                        CHR(13) + ;
                        "In" + CHR(237) + "cio de Desmontagem : " + ;
                        IIF(ISNULL(crSigMvJbC.Jb_020), "", DTOC(TTOD(crSigMvJbC.Jb_020))) + ;
                        CHR(13)
        ELSE
            loc_lcMnt = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0151, 50)) + " : " + ;
                        IIF(ISNULL(crSigMvJbC.Jb_019), "", DTOC(TTOD(crSigMvJbC.Jb_019))) + ;
                        " at" + CHR(233) + " " + ;
                        IIF(ISNULL(crSigMvJbC.Jb_020), "", DTOC(TTOD(crSigMvJbC.Jb_020))) + ;
                        CHR(13)
        ENDIF

        loc_lcVal = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0101, 50))), ;
                    "Per" + CHR(237) + "odo do Evento : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0101, 50)) + " : ") + ;
                    IIF(ISNULL(crSigMvJbC.Jb_017), "", DTOC(TTOD(crSigMvJbC.Jb_017))) + ;
                    " at" + CHR(233) + " " + ;
                    IIF(ISNULL(crSigMvJbC.Jb_018), "", DTOC(TTOD(crSigMvJbC.Jb_018))) + ;
                    CHR(13) + loc_lcMnt + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0301, 50))), ;
                    "Local do Evento : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0301, 50)) + " : ") + ;
                    NVL(crSigMvJbC.Jb_021, "") + ;
                    CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0201, 50))), ;
                    "P" + CHR(250) + "blico Estimado : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0201, 50)) + " : ") + ;
                    NVL(crSigMvJbC.Jb_022, "") + ;
                    CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0251, 50))), ;
                    "Budget Estimado : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 0251, 50)) + " : ") + ;
                    NVL(crSigMvJbC.Jb_023, "")

        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, "", "", loc_lcVal)

        *-- Bloco Empresa 1 (DivNotas = 0, 1 ou 2)
        IF INLIST(loc_lnEmp, 0, 1, 2)
            loc_lcVal = ""
            loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 151, 50))), ;
                        "Empresa 1", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 151, 50)))

            *-- Atendimento (Jb_024)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_024, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1051, 50))), ;
                        "Atendimento : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1051, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Comercial (Jb_025)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_025, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1101, 50))), ;
                        "Comercial : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1101, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Gerencia de Projeto (Jb_026)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_026, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1201, 50))), ;
                        "Ger" + CHR(234) + "ncia de Projeto : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1201, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Criacao (Jb_027)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_027, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1301, 50))), ;
                        "Cria" + CHR(231) + CHR(227) + "o : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1301, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Arquiteto (Jb_028)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_028, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1151, 50))), ;
                        "Arquiteto : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1151, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Orcamento (Jb_029)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_029, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1251, 50))), ;
                        "Or" + CHR(231) + "amento : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1251, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Montagem (Jb_030)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_030, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1351, 50))), ;
                        "Montagem : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1351, 50)) + " : ") + ;
                        loc_lcNom

            INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                     DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                             VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                     loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)
        ENDIF

        *-- Bloco Empresa 2 (DivNotas = 0, 1 ou 3)
        IF INLIST(loc_lnEmp, 0, 1, 3)
            loc_lcVal = ""
            loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 201, 50))), ;
                        "Empresa 2", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 201, 50)))

            *-- Lider de Projeto (Jb_031)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_031, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1401, 50))), ;
                        "L" + CHR(237) + "der de Projeto : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1401, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Atendimento (Jb_032)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_032, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1451, 50))), ;
                        "Atendimento : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1451, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Comercial (Jb_033)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_033, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1551, 50))), ;
                        "Comercial : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 551, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Criacao (Jb_034)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_034, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1651, 50))), ;
                        "Cria" + CHR(231) + CHR(227) + "o : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1651, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Planejamento (Jb_035)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_035, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1501, 50))), ;
                        "Planejamento : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1501, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Producao (Jb_036)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_036, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1601, 50))), ;
                        "Produ" + CHR(231) + CHR(227) + "o : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1601, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            *-- Producao Financeira (Jb_037)
            loc_lcNom = PADR(NVL(crSigMvJbC.Jb_037, ""), 10)
            IF !EMPTY(ALLTRIM(loc_lcNom))
                IF THIS.CursorQueryStr("SigCdCli", "cursor_4c_LocalBus", "IClis", loc_lcNom, "RClis")
                    SELECT cursor_4c_LocalBus
                    GO TOP IN cursor_4c_LocalBus
                    IF !EOF("cursor_4c_LocalBus")
                        loc_lcNom = ALLTRIM(cursor_4c_LocalBus.RClis) + " (" + ALLTRIM(loc_lcNom) + ")"
                    ENDIF
                    USE IN cursor_4c_LocalBus
                ENDIF
            ENDIF
            loc_lcVal = loc_lcVal + IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1701, 50))), ;
                        "Produ" + CHR(231) + CHR(227) + "o Financeira : ", ;
                        ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1701, 50)) + " : ") + ;
                        loc_lcNom + CHR(13)

            INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                     DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                             VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                     loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)
        ENDIF

        *-- Bloco Tipo de Projeto
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 251, 50))), ;
                    "Tipo de Projeto", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 251, 50)))
        loc_lcVal = PADR("( " + IIF(NVL(crSigMvJbC.Jb_038, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1751, 50))), ;
                    "Pedido do Cliente", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1751, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_039, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1801, 50))), ;
                    "Concorr" + CHR(234) + "ncia", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1801, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_040, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1851, 50))), ;
                    "Licita" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1851, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_041, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1901, 50))), ;
                    "Propriet" + CHR(225) + "rio", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1901, 50))), 38)
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Tipo de Desenvolvimento
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 301, 50))), ;
                    "Tipo de Desenvolvimento", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 301, 50)))
        loc_lcVal = PADR("( " + IIF(NVL(crSigMvJbC.Jb_042, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1951, 50))), ;
                    "Desenvolvimento Total", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 1951, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_043, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2001, 50))), ;
                    "Produ" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2001, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_044, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2051, 50))), ;
                    "Cria" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2051, 50))), 38)
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Apresentacao
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 401, 50))), ;
                    "Apresenta" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 401, 50)))
        loc_lcVal = PADR("( " + IIF(NVL(crSigMvJbC.Jb_049, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2101, 50))), ;
                    "Presencial", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2101, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_050, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2151, 50))), ;
                    "Eletr" + CHR(244) + "nica", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2151, 50))), 38)
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Proposta Comercial
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 451, 50))), ;
                    "Proposta Comercial", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 451, 50)))
        loc_lcVal = PADR("( " + IIF(NVL(crSigMvJbC.Jb_051, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2201, 50))), ;
                    "Impress" + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2201, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_052, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2251, 50))), ;
                    "CD", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2251, 50))), 38) + ;
                    "( " + IIF(NVL(crSigMvJbC.Jb_053, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2301, 50))), ;
                    "Outros", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2301, 50))) + ;
                    " : " + ALLTRIM(NVL(crSigMvJbC.Jb_073, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Proposta Tecnica
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 451, 50))), ;
                    "Proposta T" + CHR(233) + "cnica", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 451, 50)))
        loc_lcVal = PADR("( " + IIF(NVL(crSigMvJbC.Jb_054, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2351, 50))), ;
                    "Impress" + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2351, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_055, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2401, 50))), ;
                    "CD", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2401, 50))), 38) + ;
                    "( " + IIF(NVL(crSigMvJbC.Jb_056, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2451, 50))), ;
                    "Outros", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2451, 50))) + ;
                    " : " + ALLTRIM(NVL(crSigMvJbC.Jb_074, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Infos Clientes
        loc_lcB02 = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 351, 50))), ;
                    "Infos Clientes", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 351, 50)))
        loc_lcVal = IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2501, 50))), ;
                    "Logomarca : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2501, 50)) + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_045, "")) + CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2551, 50))), ;
                    "Manual de Marca : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2551, 50)) + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_046, "")) + CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2601, 50))), ;
                    "Imagens : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2601, 50)) + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_047, "")) + CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2651, 50))), ;
                    "Refer" + CHR(234) + "ncias : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2651, 50)) + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_048, "")) + CHR(13) + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2701, 50))), ;
                    "Atas, emails e correspond" + CHR(234) + "ncias de altera" + ;
                    CHR(231) + CHR(245) + "es e aprova" + CHR(231) + CHR(227) + "o do cliente : ", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2701, 50)) + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_061, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Documentos Necessarios
        loc_lcTit = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2751, 50))
        loc_lcTit = IIF(EMPTY(loc_lcTit), "Documentos Necess" + CHR(225) + "rios", loc_lcTit)
        loc_lcVal = ALLTRIM(NVL(crSigMvJbC.Jb_057, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, "", loc_lcTit, loc_lcVal)

        *-- Bloco Avaliacao do Job
        loc_lcTit = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2801, 50))
        loc_lcTit = IIF(EMPTY(loc_lcTit), "Avalia" + CHR(231) + CHR(227) + "o do Job", loc_lcTit)
        loc_lcVal = ALLTRIM(NVL(crSigMvJbC.Jb_058, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, "", loc_lcTit, loc_lcVal)

        *-- Bloco Modelo Fiscal / Consideracoes Financeiras
        loc_lcB02 = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 601, 50))
        loc_lcB02 = IIF(EMPTY(loc_lcB02), ;
                    "Modelo Fiscal / Considera" + CHR(231) + CHR(245) + "es Financeiras", ;
                    loc_lcB02)
        loc_lcVal = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3251, 50))
        loc_lcVal = IIF(EMPTY(loc_lcVal), "C" + CHR(243) + "digo de Atividade : ", ;
                    loc_lcVal + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_062, "")) + CHR(13) + CHR(13) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_063, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2851, 50))), ;
                    "NF de Servi" + CHR(231) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2851, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_064, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2901, 50))), ;
                    "Nota de D" + CHR(233) + "bito", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2901, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_065, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2951, 50))), ;
                    "NF de Loca" + CHR(231) + CHR(227) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 2951, 50))), 38) + ;
                    CHR(13) + CHR(13) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_066, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3001, 50))), ;
                    "Incentivo ICMS", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3001, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_067, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3051, 50))), ;
                    "Incentivo Rouanet", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3051, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_068, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3101, 50))), ;
                    "Incentivo ISS", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3101, 50))), 38) + ;
                    PADR("( " + IIF(NVL(crSigMvJbC.Jb_069, 0) = 1, "X", " ") + " )" + ;
                    IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3151, 50))), ;
                    "Patrocin" + CHR(237) + "o", ;
                    ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3151, 50))), 38)
        loc_lcOut = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3401, 50))
        loc_lcVal = loc_lcVal + CHR(13) + CHR(13) + ;
                    IIF(EMPTY(loc_lcOut), "Outras Receitas : ", loc_lcOut + " : ") + ;
                    ALLTRIM(NVL(crSigMvJbC.Jb_070, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, loc_lcB02, "", loc_lcVal)

        *-- Bloco Comentarios Financeiros
        loc_lcTit = ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_CPO, ""), 3301, 50))
        loc_lcTit = IIF(EMPTY(loc_lcTit), "Coment" + CHR(225) + "rios Financeiros", loc_lcTit)
        loc_lcVal = ALLTRIM(NVL(crSigMvJbC.Jb_071, ""))
        INSERT INTO crImpressa2 (Jobs, Clientes, Contatos, DtEntradas, DtApresentas, ;
                                 DtEntregas, Extras, Bloco001, TitCampo, ValCampo) ;
                         VALUES (loc_lcJob, loc_lcCli, loc_lcCtt, loc_lcDtE, loc_lcDtA, ;
                                 loc_lcDtT, loc_lcExt, "", loc_lcTit, loc_lcVal)

        SELECT crImpressa2
        GO TOP IN crImpressa2
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTituloRelatorio2 - Titulo do segundo relatorio para substituir em crCabecalho
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterTituloRelatorio2()
        RETURN IIF(EMPTY(ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 051, 50))), ;
               "Relat" + CHR(243) + "rio de Briefing", ;
               ALLTRIM(SUBSTR(NVL(crSigOpCdI.JOB_MV_TIT, ""), 051, 50))) + ;
               THIS.this_cCompTits
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe os dois relatorios em modo PREVIEW
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lcRe2
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT crImpressao
                GO TOP IN crImpressao
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE

                loc_lcRe2 = THIS.ObterTituloRelatorio2()
                REPLACE Titulo WITH loc_lcRe2 IN crCabecalho
                SELECT crImpressa2
                GO TOP IN crImpressa2
                REPORT FORM (THIS.this_cCaminhoFRX) PREVIEW NOCONSOLE

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime os dois relatorios com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lcRe2
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT crImpressao
                GO TOP IN crImpressao
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE

                loc_lcRe2 = THIS.ObterTituloRelatorio2()
                REPLACE Titulo WITH loc_lcRe2 IN crCabecalho
                SELECT crImpressa2
                GO TOP IN crImpressa2
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER PROMPT NOCONSOLE

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Imprime os dois relatorios sem dialogo (para documento/email)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso, loc_lcRe2
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT crImpressao
                GO TOP IN crImpressao
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER NOCONSOLE

                loc_lcRe2 = THIS.ObterTituloRelatorio2()
                REPLACE Titulo WITH loc_lcRe2 IN crCabecalho
                SELECT crImpressa2
                GO TOP IN crImpressa2
                REPORT FORM (THIS.this_cCaminhoFRX) TO PRINTER NOCONSOLE

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
