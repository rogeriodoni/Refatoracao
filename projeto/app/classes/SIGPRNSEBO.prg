*==============================================================================
* SIGPRNSEBO.prg - Business Object para Integracao de NF-e Municipal
*==============================================================================
* Form    : FormSIGPRNSE
* Tabela  : SigMvNfi (operacoes de notas fiscais de servico)
* Tipo    : OPERACIONAL - Geracao de arquivo TXT NFS-e (RJ/SP)
*==============================================================================

DEFINE CLASS SIGPRNSEBO AS BusinessBase

    *-- Tabela e chave principal
    this_cTabela      = "SigMvNfi"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de filtro (preenchidos por Selecionar)
    this_cEmps        = ""
    this_cDEmps       = ""
    this_dDtIni       = {}
    this_dDtFin       = {}
    this_cCidade      = ""
    this_cDirs        = ""
    this_nProcessados = 0

    *-- Dados da empresa (carregados de SigCdEmp em Selecionar)
    this_nTpEmps   = 0
    this_cCgcs     = ""
    this_cIMs      = ""
    this_nEmpofs   = 0
    this_cCodOpers = ""
    this_cDirsEmp  = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMvNfi"
        THIS.this_cCampoChave  = "EmpDopNums"
        THIS.this_dDtIni       = DATE()
        THIS.this_dDtFin       = DATE()
        THIS.this_cCidade      = "RJ - Rio de Janeiro"
        THIS.this_cDirs        = "C:\"
        THIS.this_nProcessados = 1
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - requerido por BusinessBase
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDEmps + STR(0, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarUfs - carrega cursor de municipios/UFs do SQL Server
    * Usado em GerarArquivoRJ para SEEK de cidade de prestacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUfs()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("LocalUfs")
                USE IN LocalUfs
            ENDIF
            loc_cSQL = "SELECT DISTINCT a.Codigos, a.Descs, b.Estados " + ;
                       "FROM SigCdMun a, SigCdUfs b " + ;
                       "WHERE a.UFIBGEs = b.UFIBGEs"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalUfs") < 1
                MsgErro("Erro ao carregar tabela de munic" + CHR(237) + "pios.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF USED("LocalUfs")
                SELECT LocalUfs
                INDEX ON Codigos TAG Codigos
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarUfs")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorOperacoes - cria/recria cursor local de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorOperacoes()
        TRY
            IF USED("csOperacoes")
                SELECT csOperacoes
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR csOperacoes (SelImp l(1), Emps c(3), Dopes c(20), ;
                    Numes n(6,0), Datas d(8), Valos n(12,2), Notas c(10), ;
                    Usuars c(10), ContaOs c(10), ContaDs c(10), Opers c(1), Erros m(4))
                SET NULL OFF
                INDEX ON Emps + Dopes + STR(Numes, 6)                     TAG Operacao
                INDEX ON DTOS(Datas) + Emps + Dopes + STR(Numes, 6)       TAG Data
                INDEX ON Notas + Emps + Dopes + STR(Numes, 6)             TAG Nota
                INDEX ON ContaOs + Emps + Dopes + STR(Numes, 6)           TAG Origem
                INDEX ON ContaDs + Emps + Dopes + STR(Numes, 6)           TAG Destino
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CriarCursor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Selecionar - seleciona notas fiscais conforme filtros e popula csOperacoes
    * par_cEmps          : empresa (char 3)
    * par_dDtIni         : data inicial
    * par_dDtFin         : data final
    * par_lNaoProcesados : .T. = nao processadas, .F. = ja processadas
    * par_cDir           : diretorio de gravacao do arquivo
    * Retorno: .T. se OK, .F. se erro/validacao falhou
    *--------------------------------------------------------------------------
    PROCEDURE Selecionar(par_cEmps, par_dDtIni, par_dDtFin, par_lNaoProcesados, par_cDir)
        LOCAL loc_lSucesso, loc_cSQL, loc_cDtFim, loc_cNotIn, loc_cProdutos, ;
              loc_cErr, loc_lNaoProcesados, loc_cEmps, loc_dDtIni, loc_dDtFin, ;
              loc_cDir, loc_cIdChave, loc_dEmis, loc_oErro

        loc_lSucesso       = .F.
        loc_lNaoProcesados = IIF(TYPE("par_lNaoProcesados") = "L", par_lNaoProcesados, .T.)
        loc_cEmps          = PADR(ALLTRIM(IIF(TYPE("par_cEmps") = "C", par_cEmps, "")), 3)
        loc_dDtIni         = IIF(TYPE("par_dDtIni") = "D", par_dDtIni, DATE())
        loc_dDtFin         = IIF(TYPE("par_dDtFin") = "D", par_dDtFin, DATE())
        loc_cDir           = IIF(TYPE("par_cDir") = "C", par_cDir, "C:\")

        *-- Confirmacao para reprocessar notas ja processadas
        IF !loc_lNaoProcesados
            IF !MsgConfirma("Confirma a Sele" + CHR(231) + CHR(227) + "o de Notas Fiscais J" + ;
                            CHR(225) + " Processadas Anteriormente?" + CHR(13) + ;
                            "Este Processo Poder" + CHR(225) + " Sobrepor Registros no Arquivo Gerado e Pode" + ;
                            CHR(13) + "Causar Duplicidade ou Mesmo Cancelamento das Notas Anteriores!!!")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Validacoes
        IF EMPTY(loc_dDtIni)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(loc_dDtFin)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF loc_dDtFin < loc_dDtIni
            MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(loc_cEmps)
            MsgAviso("Empresa Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(loc_cDir)) .OR. !DIRECTORY(loc_cDir)
            MsgAviso("Pasta do Arquivo Inv" + CHR(225) + "lida!!!")
            RETURN .F.
        ENDIF

        TRY
            *-- Monta data final com horario 23:59:59
            loc_cDtFim = "'" + PADL(TRANSFORM(YEAR(loc_dDtFin)), 4, "0") + "-" + ;
                         PADL(TRANSFORM(MONTH(loc_dDtFin)), 2, "0") + "-" + ;
                         PADL(TRANSFORM(DAY(loc_dDtFin)), 2, "0") + " 23:59:59'"

            *-- Carrega dados da empresa
            IF USED("LocalEmp")
                USE IN LocalEmp
            ENDIF
            loc_cSQL = "SELECT TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(loc_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalEmp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao carregar empresa.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Salva dados da empresa nas propriedades do BO
            IF USED("LocalEmp") .AND. !EOF("LocalEmp")
                SELECT LocalEmp
                THIS.this_nTpEmps   = NVL(LocalEmp.TpEmps, 0)
                THIS.this_cCgcs     = NVL(LocalEmp.Cgcs, "")
                THIS.this_cIMs      = NVL(LocalEmp.IMs, "")
                THIS.this_nEmpofs   = NVL(LocalEmp.Empofs, 0)
                THIS.this_cCodOpers = NVL(LocalEmp.CodOpers, "")
                THIS.this_cDirsEmp  = NVL(LocalEmp.Dirs, "")
            ENDIF

            *-- Monta flag NOT IN para filtro de ja processados
            loc_cNotIn = IIF(loc_lNaoProcesados, " NOT", "")

            *-- Carrega notas fiscais de servico
            IF USED("LocalNotas")
                USE IN LocalNotas
            ENDIF
            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, " + ;
                       "a.Emis, b.Obses, a.Cancelas, a.TotProds, a.VCofins, a.TpTribSers, " + ;
                       "a.PrestServs, a.CodBenefs, a.CodSrvFis, a.VDeducoes, a.VDscConds, " + ;
                       "a.VDscIConds, a.OutRetens, a.ISSRetidos, a.TipoNFs, a.VCsll, " + ;
                       "a.VInss, a.VIrf, a.VPis, a.VTotIss, b.Usuars, b.ContaOs, b.ContaDs, " + ;
                       "c.TpClis, c.Cpfs, c.InscMuns, c.Rgs, c.Razaos, c.RClis, c.Endes, " + ;
                       "c.Nums, c.Compls, c.Bairs, c.Cidas, c.Estas, c.Ceps, c.Tel1s, " + ;
                       "c.eMails, c.OptSimples " + ;
                       "FROM SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d " + ;
                       "WHERE a.Emis BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
                       " AND " + loc_cDtFim + " " + ;
                       "AND a.Emps = " + EscaparSQL(loc_cEmps) + " " + ;
                       "AND a.EmpDopNums = b.EmpDopNums " + ;
                       "AND b.ContaDs = c.IClis " + ;
                       "AND LEFT(a.Series, 3) = d.Cods " + ;
                       "AND d.TpServicos IN (1, 3) " + ;
                       "AND a.EmpDopNums" + loc_cNotIn + ;
                       " IN (SELECT o.EmpDopNums FROM SigPcOoL o WHERE o.Tipos = 'SIGPRNSE')"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalNotas") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao carregar notas.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verifica se encontrou dados
            SELECT LocalNotas
            GO TOP IN LocalNotas
            IF EOF("LocalNotas")
                MsgInfo("N" + CHR(227) + "o Foram Encontrados Dados Com os Filtros Informados!!!")
            ELSE
                *-- Recria cursor de operacoes
                THIS.CriarCursorOperacoes()

                *-- Processa cada nota: valida + insere em csOperacoes + registra em SigPcOoL
                SELECT LocalNotas
                SCAN
                loc_cErr = ""

                IF EMPTY(ALLTRIM(LocalNotas.Razaos)) .AND. EMPTY(ALLTRIM(LocalNotas.RClis))
                    loc_cErr = loc_cErr + "O Nome e a Raz" + CHR(227) + "o Social da Conta """ + ;
                               ALLTRIM(LocalNotas.ContaOs) + """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Series))
                    loc_cErr = loc_cErr + "A S" + CHR(233) + "rie da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.NFis))
                    loc_cErr = loc_cErr + "O N" + CHR(250) + "mero da Nota Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Ceps))
                    loc_cErr = loc_cErr + "O CEP da Conta """ + ALLTRIM(LocalNotas.ContaOs) + ;
                               """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Endes))
                    loc_cErr = loc_cErr + "O Endere" + CHR(231) + "o da Conta """ + ALLTRIM(LocalNotas.ContaOs) + ;
                               """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Bairs))
                    loc_cErr = loc_cErr + "O Bairro da Conta """ + ALLTRIM(LocalNotas.ContaOs) + ;
                               """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Cidas))
                    loc_cErr = loc_cErr + "A Cidade da Conta """ + ALLTRIM(LocalNotas.ContaOs) + ;
                               """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(LocalNotas.Estas))
                    loc_cErr = loc_cErr + "A UF da Conta """ + ALLTRIM(LocalNotas.ContaOs) + ;
                               """ Est" + CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF ISNULL(LocalNotas.Emis) .OR. EMPTY(LocalNotas.Emis)
                    loc_cErr = loc_cErr + "A Data de Emiss" + CHR(227) + "o da Nota Est" + CHR(225) + ;
                               " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(ALLTRIM(STRTRAN(NVL(LocalNotas.CodSrvFis, ""), ".", "")))
                    loc_cErr = loc_cErr + "O C" + CHR(243) + "digo do Servi" + CHR(231) + "o Municipal da Nota Est" + ;
                               CHR(225) + " em Branco;" + CHR(13)
                ENDIF
                IF EMPTY(NVL(LocalNotas.TotProds, 0))
                    loc_cErr = loc_cErr + "O Valor dos Servi" + CHR(231) + "os da Nota Est" + CHR(225) + ;
                               " Zerado;" + CHR(13)
                ENDIF

                *-- Converte data de emissao
                IF ISNULL(LocalNotas.Emis)
                    loc_dEmis = {}
                ELSE
                    loc_dEmis = TTOD(LocalNotas.Emis)
                ENDIF

                *-- Insere no cursor local csOperacoes
                INSERT INTO csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, ;
                                        Notas, Usuars, ContaOs, ContaDs, Opers, Erros) ;
                    VALUES (EMPTY(loc_cErr), ;
                            NVL(LocalNotas.Emps, ""), ;
                            NVL(LocalNotas.Dopes, ""), ;
                            NVL(LocalNotas.Numes, 0), ;
                            loc_dEmis, ;
                            NVL(LocalNotas.TotProds, 0), ;
                            NVL(LocalNotas.NFis, ""), ;
                            NVL(LocalNotas.Usuars, ""), ;
                            NVL(LocalNotas.ContaOs, ""), ;
                            NVL(LocalNotas.ContaDs, ""), ;
                            NVL(LocalNotas.Operas, ""), ;
                            loc_cErr)

                *-- Registra processamento no SQL Server (SigPcOoL)
                loc_cProdutos = IIF(loc_lNaoProcesados, "", ;
                                    "LAN" + CHR(199) + "AMENTO REFEITO")
                loc_cIdChave  = LEFT(fUniqueIds(), 20)

                loc_cSQL = "INSERT INTO SigPcOoL " + ;
                           "(Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, " + ;
                           "Datas, Usuars, Produtos, Processos, cIdChaves, EmpDopNums, EdnDests) " + ;
                           "VALUES ('SIGPRNSE', " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Emps, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Dopes, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(LocalNotas.Numes, 0), 0) + ", " + ;
                           "'', '', 0, GETDATE(), " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           EscaparSQL(loc_cProdutos) + ", " + ;
                           "'', " + ;
                           EscaparSQL(loc_cIdChave) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(LocalNotas.Emps, "")) + ;
                                      ALLTRIM(NVL(LocalNotas.Dopes, "")) + ;
                                      STR(NVL(LocalNotas.Numes, 0), 6)) + ", " + ;
                           "'')"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao registrar em SigPcOoL.", "Erro")
                    *-- Continua processando as demais notas
                ENDIF

                SELECT LocalNotas
                ENDSCAN

                *-- Armazena parametros nas propriedades do BO para uso em Processamento
                THIS.this_cEmps   = loc_cEmps
                THIS.this_dDtIni  = loc_dDtIni
                THIS.this_dDtFin  = loc_dDtFin
                THIS.this_cDirs   = loc_cDir

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Selecionar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoRJ - gera arquivo TXT NFS-e para o municipio do Rio de Janeiro
    * Versao 3.1 - Prefeitura Municipal da Cidade do Rio de Janeiro
    * Retorno: .T. se arquivo gerado com sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoRJ()
        LOCAL loc_lSucesso, loc_cArq, loc_cDir, loc_lcArq, loc_lcStr, loc_lcFim, ;
              loc_lcTip, loc_lcCpf, loc_lcIms, loc_lcDtI, loc_lcDtF, ;
              loc_lnR20, loc_lnR40, loc_lnTsr, loc_lnTdd, loc_lnTdc, loc_lnTdi, ;
              loc_lcSer, loc_lcNot, loc_lcEmi, loc_lcSts, ;
              loc_lcTpT, loc_lcCpW, loc_lcImT, loc_lcIeT, loc_lcNmT, ;
              loc_lcEdT, loc_lcTeT, loc_lcNeT, loc_lcCeT, loc_lcBaT, ;
              loc_lcCdT, loc_lcUfT, loc_lcCcT, loc_lcT1T, loc_lcEmT, ;
              loc_lcTts, loc_lcCps, loc_lcUps, loc_lcRet, loc_lcOSN, loc_lcInC, ;
              loc_lcCsF, loc_lcCdB, loc_lcCsM, loc_lnAlq, loc_lcAlq, ;
              loc_lcVal, loc_lcVde, loc_lcVds, loc_lcVdi, loc_lcCof, loc_lcCsl, ;
              loc_lcIns, loc_lcIrf, loc_lcPis, loc_lcOut, loc_lcIss, loc_lcRtd, ;
              loc_lcObs, loc_lcNdt, loc_lcTsr, loc_lcTdd, loc_lcTdc, loc_lcTdi, ;
              loc_lcTpn, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Carregando notas de saida (csOperacoes selecionadas)
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "S" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfS READWRITE

            *-- Carregando notas de entrada
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "E" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfE READWRITE

            *-- Totalizadores para o registro 90
            loc_lnR20 = 0
            loc_lnR40 = 0
            loc_lnTsr = 0
            loc_lnTdd = 0
            loc_lnTdc = 0
            loc_lnTdi = 0

            loc_lcFim = CHR(13) + CHR(10)

            loc_lcTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_lcCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_lcIms = PADL(CHRTRAN(THIS.this_cIMs,  ".-/ ", ""), 15, "0")
            loc_lcDtI = DTOS(THIS.this_dDtIni)
            loc_lcDtF = DTOS(THIS.this_dDtFin)

            loc_cDir  = ALLTRIM(THIS.this_cDirs)
            loc_lcArq = loc_cDir + ALLTRIM(loc_lcIms) + "_" + ;
                        LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            =STRTOFILE("", loc_lcArq, .F.)

            IF !FILE(loc_lcArq)
                MsgErro("O Arquivo """ + loc_lcArq + """ N" + CHR(227) + "o Pode Ser Criado!!!" + ;
                        CHR(13) + "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + ;
                        CHR(227) + "o e Tente Novamente!!!", "Erro na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lSucesso = .F.
            ENDIF

            *-- Registro Tipo 10 - Cabecalho
            loc_lcStr = "10" + ;
                        "003" + ;
                        loc_lcTip + ;
                        loc_lcCpf + ;
                        loc_lcIms + ;
                        loc_lcDtI + ;
                        loc_lcDtF + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            *-- Processando notas de saida (Registro Tipo 20)
            SELECT LocalNfS
            SCAN
                loc_lcSer = PADR(ALLTRIM(LocalNfS.Series), 5)
                loc_lcNot = PADL(ALLTRIM(LocalNfS.NFis), 15, "0")
                loc_lcEmi = DTOS(LocalNfS.Emis)
                loc_lcSts = IIF(LocalNfS.Cancelas, "2", "1")

                loc_lcTpT = PADL(NVL(LocalNfS.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfS.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfS.InscMuns, ""), ".-/ ", ""), 15, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfS.Rgs, ""),      ".-/ ", ""), 15, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfS.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfS.RClis, "")), loc_lcNmT), 115)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfS.Endes, "")), 125)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfS.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfS.Compls, "")), 60)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfS.Bairs, "")), 72)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfS.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfS.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfS.Ceps, ""), "-", ""), 8, "0")
                loc_lcT1T = PADR(CHRTRAN(NVL(LocalNfS.Tel1s, ""), ".-", ""), 11)
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfS.eMails, "")), 80)

                loc_lcTts = PADL(TRANSFORM(NVL(LocalNfS.TpTribSers, 0)), 2, "0")
                loc_lcCps = loc_lcCdT
                loc_lcUps = loc_lcUfT
                IF USED("LocalUfs") .AND. SEEK(NVL(LocalNfS.PrestServs, ""), "LocalUfs", "Codigos")
                    loc_lcCps = PADR(UPPER(ALLTRIM(NVL(LocalUfs.Descs, ""))), 50)
                    loc_lcUps = PADR(UPPER(ALLTRIM(NVL(LocalUfs.Estados, ""))), 2)
                ENDIF

                loc_lcRet = PADL(TRANSFORM(NVL(THIS.this_nEmpofs, 0)), 2, "0")
                loc_lcOSN = IIF(NVL(LocalNfS.OptSimples, "") = "S", "1", "0")
                loc_lcInC = IIF(INLIST(loc_lcTts, "03", "04"), "1", "0")
                loc_lcCsF = PADR(NVL(THIS.this_cCodOpers, ""), 4)
                loc_lcCdB = PADL(ALLTRIM(NVL(LocalNfS.CodBenefs, "")), 3, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfS.CodSrvFis, ""), ".", ""), 6)

                *-- Valores
                loc_lnAlq = IIF(NVL(LocalNfS.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfS.VTotIss, 0) / NVL(LocalNfS.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 5, "0")
                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfS.TotProds, 0),   20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfS.VDeducoes, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVds = PADL(CHRTRAN(STR(NVL(LocalNfS.VDscConds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVdi = PADL(CHRTRAN(STR(NVL(LocalNfS.VDscIConds, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcCof = PADL(CHRTRAN(STR(NVL(LocalNfS.VCofins, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcCsl = PADL(CHRTRAN(STR(NVL(LocalNfS.VCsll, 0),      20, 2), ". ", ""), 15, "0")
                loc_lcIns = PADL(CHRTRAN(STR(NVL(LocalNfS.VInss, 0),      20, 2), ". ", ""), 15, "0")
                loc_lcIrf = PADL(CHRTRAN(STR(NVL(LocalNfS.VIrf, 0),       20, 2), ". ", ""), 15, "0")
                loc_lcPis = PADL(CHRTRAN(STR(NVL(LocalNfS.VPis, 0),       20, 2), ". ", ""), 15, "0")
                loc_lcOut = PADL(CHRTRAN(STR(NVL(LocalNfS.OutRetens, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcIss = PADL(CHRTRAN(STR(NVL(LocalNfS.VTotIss, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcRtd = IIF(NVL(LocalNfS.ISSRetidos, 0) = 1, "1", "0")
                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfS.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfS.VDeducoes, 0)
                loc_lnTdc = loc_lnTdc + NVL(LocalNfS.VDscConds, 0)
                loc_lnTdi = loc_lnTdi + NVL(LocalNfS.VDscIConds, 0)

                *-- Registro Tipo 20 - Detalhe saida
                loc_lcStr = "20" + ;
                            "0" + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcSts + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcT1T + ;
                            loc_lcEmT + ;
                            loc_lcTts + ;
                            loc_lcCps + ;
                            loc_lcUps + ;
                            loc_lcRet + ;
                            loc_lcOSN + ;
                            loc_lcInC + ;
                            loc_lcCsF + ;
                            SPACE(11) + ;
                            loc_lcCdB + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            loc_lcVds + ;
                            loc_lcVdi + ;
                            loc_lcCof + ;
                            loc_lcCsl + ;
                            loc_lcIns + ;
                            loc_lcIrf + ;
                            loc_lcPis + ;
                            loc_lcOut + ;
                            loc_lcIss + ;
                            loc_lcRtd + ;
                            loc_lcEmi + ;
                            SPACE(15) + ;
                            SPACE(15) + ;
                            SPACE(05) + ;
                            PADL("", 15, "0") + ;
                            SPACE(30) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnR20 = loc_lnR20 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Processando notas de entrada (Registro Tipo 40)
            SELECT LocalNfE
            SCAN
                loc_lcTpn = PADL(ALLTRIM(TRANSFORM(NVL(LocalNfE.TipoNFs, 0))), 2, "0")
                loc_lcSer = PADR(ALLTRIM(NVL(LocalNfE.Series, "")), 5)
                loc_lcNot = PADL(ALLTRIM(NVL(LocalNfE.NFis, "")), 15, "0")
                loc_lcEmi = DTOS(LocalNfE.Emis)
                loc_lcSts = IIF(LocalNfE.Cancelas, "2", "1")

                loc_lcTpT = PADL(NVL(LocalNfE.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfE.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfE.InscMuns, ""), ".-/ ", ""), 15, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfE.Rgs, ""),      ".-/ ", ""), 15, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfE.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfE.RClis, "")), loc_lcNmT), 115)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfE.Endes, "")), 125)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfE.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfE.Compls, "")), 60)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfE.Bairs, "")), 72)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfE.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfE.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfE.Ceps, ""), "-", ""), 8, "0")
                loc_lcT1T = PADR(CHRTRAN(NVL(LocalNfE.Tel1s, ""), ".-", ""), 11)
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfE.eMails, "")), 80)

                loc_lcTts = PADL(TRANSFORM(NVL(LocalNfE.TpTribSers, 0)), 2, "0")
                loc_lcOSN = IIF(NVL(LocalNfE.OptSimples, "") = "S", "1", "0")
                loc_lcCsF = PADR(NVL(THIS.this_cCodOpers, ""), 4)
                loc_lcCdB = PADL(ALLTRIM(NVL(LocalNfE.CodBenefs, "")), 3, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfE.CodSrvFis, ""), ".", ""), 6)

                *-- Valores
                loc_lnAlq = IIF(NVL(LocalNfE.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfE.VTotIss, 0) / NVL(LocalNfE.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 5, "0")
                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfE.TotProds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfE.VDeducoes, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcIss = PADL(CHRTRAN(STR(NVL(LocalNfE.VTotIss, 0),   20, 2), ". ", ""), 15, "0")
                loc_lcRtd = IIF(NVL(LocalNfE.ISSRetidos, 0) = 1, "1", "0")
                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfE.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfE.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfE.VDeducoes, 0)

                *-- Registro Tipo 40 - Declaracao notas convencionais recebidas
                loc_lcStr = "40" + ;
                            loc_lcTpn + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcSts + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcT1T + ;
                            loc_lcEmT + ;
                            loc_lcTts + ;
                            SPACE(54) + ;
                            loc_lcOSN + ;
                            loc_lcCsF + ;
                            SPACE(11) + ;
                            loc_lcCdB + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            SPACE(30) + ;
                            loc_lcIss + ;
                            loc_lcRtd + ;
                            loc_lcEmi + ;
                            SPACE(15) + ;
                            SPACE(15) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnR40 = loc_lnR40 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Registro Tipo 90 - Rodape
            loc_lcNdt = PADL(CHRTRAN(STR(loc_lnR20 + loc_lnR40, 20, 0), ". ", ""), 8, "0")
            loc_lcTsr = PADL(CHRTRAN(STR(loc_lnTsr, 20, 2), ". ", ""), 15, "0")
            loc_lcTdd = PADL(CHRTRAN(STR(loc_lnTdd, 20, 2), ". ", ""), 15, "0")
            loc_lcTdc = PADL(CHRTRAN(STR(loc_lnTdc, 20, 2), ". ", ""), 15, "0")
            loc_lcTdi = PADL(CHRTRAN(STR(loc_lnTdi, 20, 2), ". ", ""), 15, "0")

            loc_lcStr = "90" + ;
                        loc_lcNdt + ;
                        loc_lcTsr + ;
                        loc_lcTdd + ;
                        loc_lcTdc + ;
                        loc_lcTdi + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            MsgInfo("O Arquivo """ + loc_lcArq + """ Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_lnR20, 10)) + CHR(13) + ;
                    "Notas de Entrada: " + ALLTRIM(STR(loc_lnR40, 10)))

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GerarArquivoRJ")
        ENDTRY

        IF USED("LocalNfS")
            USE IN LocalNfS
        ENDIF
        IF USED("LocalNfE")
            USE IN LocalNfE
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoSP - gera arquivo TXT NFS-e para o municipio de Sao Paulo
    * Versao 3.4 - Prefeitura Municipal da Cidade de Sao Paulo
    * Retorno: .T. se arquivo gerado com sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivoSP()
        LOCAL loc_lSucesso, loc_cDir, loc_lcArq, loc_lcStr, loc_lcFim, ;
              loc_lcTip, loc_lcCpf, loc_lcIms, loc_lcDtI, loc_lcDtF, ;
              loc_lnRg2, loc_lnTsr, loc_lnTdd, ;
              loc_lcSer, loc_lcNot, loc_lcEmi, loc_lcTts, ;
              loc_lcTpT, loc_lcCpW, loc_lcImT, loc_lcIeT, loc_lcNmT, ;
              loc_lcEdT, loc_lcTeT, loc_lcNeT, loc_lcCeT, loc_lcBaT, ;
              loc_lcCdT, loc_lcUfT, loc_lcCcT, loc_lcEmT, ;
              loc_lcVal, loc_lcVde, loc_lcCsM, loc_lcMps, ;
              loc_lnAlq, loc_lcAlq, loc_lcRtd, ;
              loc_lcPis, loc_lcCof, loc_lcIns, loc_lcIrf, loc_lcCsl, ;
              loc_lcIss, loc_lcObs, ;
              loc_lcNdt, loc_lcTsr, loc_lcTdd, ;
              loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Carregando notas de saida
            SELECT a.* ;
              FROM LocalNotas a, csOperacoes b ;
             WHERE a.Operas = "S" AND ;
                   a.Emps + a.Dopes + STR(a.Numes, 6) = b.Emps + b.Dopes + STR(b.Numes, 6) AND ;
                   b.SelImp ;
              INTO CURSOR LocalNfS READWRITE

            *-- Totalizadores para registro 9
            loc_lnRg2 = 0
            loc_lnTsr = 0
            loc_lnTdd = 0

            loc_lcFim = CHR(13) + CHR(10)

            loc_lcTip = IIF(THIS.this_nTpEmps = 1, "1", "2")
            loc_lcCpf = PADL(CHRTRAN(THIS.this_cCgcs, ".-/ ", ""), 14, "0")
            loc_lcIms = PADL(CHRTRAN(THIS.this_cIMs,  ".-/ ", ""),  8, "0")
            loc_lcDtI = DTOS(THIS.this_dDtIni)
            loc_lcDtF = DTOS(THIS.this_dDtFin)

            loc_cDir  = ALLTRIM(THIS.this_cDirs)
            loc_lcArq = loc_cDir + ALLTRIM(loc_lcIms) + "_" + ;
                        LEFT(CHRTRAN(TTOC(DATETIME()), "/: ", "--_"), 16) + ".TXT"

            =STRTOFILE("", loc_lcArq, .F.)

            IF !FILE(loc_lcArq)
                MsgErro("O Arquivo """ + loc_lcArq + """ N" + CHR(227) + "o Pode Ser Criado!!!" + ;
                        CHR(13) + "Verifique Suas Permiss" + CHR(245) + "es de Cria" + CHR(231) + ;
                        CHR(227) + "o e Tente Novamente!!!", "Erro na Cria" + CHR(231) + CHR(227) + "o do Arquivo")
                loc_lSucesso = .F.
            ENDIF

            *-- Registro Tipo 1 - Cabecalho SP
            loc_lcStr = "1" + ;
                        "002" + ;
                        loc_lcIms + ;
                        loc_lcDtI + ;
                        loc_lcDtF + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            *-- Processando notas de saida (Registro Tipo 6)
            SELECT LocalNfS
            SCAN
                loc_lcTpT = PADL(NVL(LocalNfS.TpClis, "0"), 1, "0")
                loc_lcTpT = IIF(loc_lcTpT = "0", "3", loc_lcTpT)
                loc_lcCpW = PADL(CHRTRAN(NVL(LocalNfS.Cpfs, ""), ".-/ ", ""), 14, "0")
                IF loc_lcCpW = "00000000000000"
                    loc_lcTpT = "3"
                ENDIF
                loc_lcImT = PADL(CHRTRAN(NVL(LocalNfS.InscMuns, ""), ".-/ ", ""), 8, "0")
                loc_lcIeT = PADL(CHRTRAN(NVL(LocalNfS.Rgs, ""),      ".-/ ", ""), 12, "0")
                loc_lcNmT = ALLTRIM(NVL(LocalNfS.Razaos, ""))
                loc_lcNmT = PADR(IIF(EMPTY(loc_lcNmT), ALLTRIM(NVL(LocalNfS.RClis, "")), loc_lcNmT), 75)
                loc_lcEdT = PADR(ALLTRIM(NVL(LocalNfS.Endes, "")), 50)
                loc_lcTeT = ALLTRIM(LEFT(loc_lcEdT, AT(" ", loc_lcEdT)))
                loc_lcTeT = PADR(IIF(EMPTY(loc_lcTeT), "RUA", loc_lcTeT), 3)
                loc_lcNeT = PADR(ALLTRIM(NVL(LocalNfS.Nums, "")), 10)
                loc_lcCeT = PADR(ALLTRIM(NVL(LocalNfS.Compls, "")), 30)
                loc_lcBaT = PADR(ALLTRIM(NVL(LocalNfS.Bairs, "")), 30)
                loc_lcCdT = PADR(ALLTRIM(NVL(LocalNfS.Cidas, "")), 50)
                loc_lcUfT = PADR(ALLTRIM(NVL(LocalNfS.Estas, "")), 2)
                loc_lcCcT = PADL(CHRTRAN(NVL(LocalNfS.Ceps, ""), "-", ""), 8, "0")
                loc_lcEmT = PADR(ALLTRIM(NVL(LocalNfS.eMails, "")), 75)

                loc_lcSer = PADR(ALLTRIM(NVL(LocalNfS.Series, "")), 5)
                loc_lcNot = PADL(ALLTRIM(NVL(LocalNfS.NFis, "")), 12, "0")
                loc_lcEmi = DTOS(LocalNfS.Emis)

                DO CASE
                    CASE NVL(LocalNfS.TpTribSers, 0) = 1
                        loc_lcTts = "T"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 2
                        loc_lcTts = "I"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 3
                        loc_lcTts = "F"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 4
                        loc_lcTts = "C"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 5
                        loc_lcTts = "E"
                    CASE NVL(LocalNfS.TpTribSers, 0) = 6
                        loc_lcTts = "J"
                    OTHERWISE
                        loc_lcTts = "T"
                ENDCASE

                loc_lcVal = PADL(CHRTRAN(STR(NVL(LocalNfS.TotProds, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcVde = PADL(CHRTRAN(STR(NVL(LocalNfS.VDeducoes, 0), 20, 2), ". ", ""), 15, "0")
                loc_lcCsM = PADR(STRTRAN(NVL(LocalNfS.CodSrvFis, ""), ".", ""), 5)
                loc_lcMps = PADL(ALLTRIM(NVL(LocalNfS.PrestServs, "")), 7, "0")

                loc_lnAlq = IIF(NVL(LocalNfS.TotProds, 0) = 0, 0, ;
                                (NVL(LocalNfS.VTotIss, 0) / NVL(LocalNfS.TotProds, 1)) * 100)
                loc_lcAlq = PADL(CHRTRAN(STR(loc_lnAlq, 9, 2), ". ", ""), 4, "0")
                loc_lcRtd = PADR(IIF(NVL(LocalNfS.ISSRetidos, 0) = 1, "2", "1"), 1)
                loc_lcPis = PADL(CHRTRAN(STR(NVL(LocalNfS.VPis, 0),     20, 2), ". ", ""), 15, "0")
                loc_lcCof = PADL(CHRTRAN(STR(NVL(LocalNfS.VCofins, 0),  20, 2), ". ", ""), 15, "0")
                loc_lcIns = PADL(CHRTRAN(STR(NVL(LocalNfS.VInss, 0),    20, 2), ". ", ""), 15, "0")
                loc_lcIrf = PADL(CHRTRAN(STR(NVL(LocalNfS.VIrf, 0),     20, 2), ". ", ""), 15, "0")
                loc_lcCsl = PADL(CHRTRAN(STR(NVL(LocalNfS.VCsll, 0),    20, 2), ". ", ""), 15, "0")

                loc_lcObs = ALLTRIM(STRTRAN(STRTRAN(NVL(LocalNfS.Obses, ""), CHR(13), "|"), CHR(10), ""))
                loc_lcObs = IIF(EMPTY(loc_lcObs), "Servi" + CHR(231) + "os Prestados", loc_lcObs)

                *-- Acumula totalizadores
                loc_lnTsr = loc_lnTsr + NVL(LocalNfS.TotProds, 0)
                loc_lnTdd = loc_lnTdd + NVL(LocalNfS.VDeducoes, 0)

                *-- Registro Tipo 6 - Detalhe saida SP
                loc_lcStr = "6" + ;
                            "RPS  " + ;
                            loc_lcSer + ;
                            loc_lcNot + ;
                            loc_lcEmi + ;
                            loc_lcTts + ;
                            loc_lcVal + ;
                            loc_lcVde + ;
                            loc_lcCsM + ;
                            loc_lcAlq + ;
                            loc_lcRtd + ;
                            loc_lcTpT + ;
                            loc_lcCpW + ;
                            loc_lcImT + ;
                            loc_lcIeT + ;
                            loc_lcNmT + ;
                            loc_lcTeT + ;
                            loc_lcEdT + ;
                            loc_lcNeT + ;
                            loc_lcCeT + ;
                            loc_lcBaT + ;
                            loc_lcCdT + ;
                            loc_lcUfT + ;
                            loc_lcCcT + ;
                            loc_lcEmT + ;
                            loc_lcPis + ;
                            loc_lcCof + ;
                            loc_lcIns + ;
                            loc_lcIrf + ;
                            loc_lcCsl + ;
                            PADL("0", 15, "0") + ;
                            PADL("0", 5,  "0") + ;
                            SPACE(10) + ;
                            PADL("0", 12, "0") + ;
                            PADL("0", 12, "0") + ;
                            loc_lcMps + ;
                            SPACE(200) + ;
                            loc_lcObs + ;
                            loc_lcFim

                loc_lnRg2 = loc_lnRg2 + 1
                =STRTOFILE(loc_lcStr, loc_lcArq, .T.)
            ENDSCAN

            *-- Registro Tipo 9 - Rodape SP
            loc_lcNdt = PADL(CHRTRAN(STR(loc_lnRg2, 20, 0), ". ", ""), 7, "0")
            loc_lcTsr = PADL(CHRTRAN(STR(loc_lnTsr, 20, 2), ". ", ""), 15, "0")
            loc_lcTdd = PADL(CHRTRAN(STR(loc_lnTdd, 20, 2), ". ", ""), 15, "0")

            loc_lcStr = "9" + ;
                        loc_lcNdt + ;
                        loc_lcTsr + ;
                        loc_lcTdd + ;
                        loc_lcFim
            =STRTOFILE(loc_lcStr, loc_lcArq, .T.)

            MsgInfo("O Arquivo """ + loc_lcArq + """ Foi Gerado!" + CHR(13) + ;
                    "Notas de Sa" + CHR(237) + "da: " + ALLTRIM(STR(loc_lnRg2, 10)))

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GerarArquivoSP")
        ENDTRY

        IF USED("LocalNfS")
            USE IN LocalNfS
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - coordena a geracao do arquivo NFS-e conforme municipio
    * par_cCidade: "RJ - Rio de Janeiro" ou "SP - Sao Paulo"
    * Retorno: .T. se arquivo gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Processamento(par_cCidade)
        LOCAL loc_lSucesso, loc_cCidade, loc_oErro
        loc_lSucesso = .F.
        loc_cCidade  = ALLTRIM(IIF(TYPE("par_cCidade") = "C", par_cCidade, THIS.this_cCidade))

        TRY
            DO CASE
                CASE loc_cCidade = "RJ - Rio de Janeiro"
                    loc_lSucesso = THIS.GerarArquivoRJ()

                CASE loc_cCidade = "SP - S" + CHR(227) + "o Paulo"
                    loc_lSucesso = THIS.GerarArquivoSP()

                OTHERWISE
                    MsgAviso("Munic" + CHR(237) + "pio n" + CHR(227) + "o suportado: " + loc_cCidade)
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Processamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
