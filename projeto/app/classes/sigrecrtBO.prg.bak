*==============================================================================
* SIGRECRTBO.PRG
* Business Object para Relatorio de Cheques Da Carteira (SIGRECRT)
* Herda de RelatorioBase
*
* Filtros:
*   - Tipo de data: 1=Vencimento, 2=Emissao
*   - Periodo (data inicial / data final)
*   - Empresa (codigo + descricao)
*   - Tipo de relatorio: 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
*   - Opcao nota: 1=Sim, 2=Nao, 3=Ambos
*   - Ordem: 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
*   - Juros mensal (%)
*   - Opcao Bons: 1=Ativos, 2=Todos (visivel apenas em TipoRel=4)
*   - Emissor (grupo/conta)
*   - Origem (grupo/conta)
*   - Destino (grupo/conta)
* Tabelas: SigCcChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdPam, SigCdEmp, SigCqLcm
*==============================================================================

DEFINE CLASS sigrecrtBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores principais
    this_cCursorDados       = "CsRelatorio"
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorOperacoes   = "cursor_4c_SigCdOpt"

    *-- Filtro: tipo de data (1=Vencimento, 2=Emissao)
    this_nTipoDat           = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: tipo relatorio (GetTipoRel.ListIndex)
    *-- 1=Ativos, 2=Baixados, 3=Neg.PG, 4=Bons, 5=Devolvidos
    this_nTipoRel           = 1

    *-- Filtro: opcao nota (opt_nr_opcao.Value): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Titulos dinamicos carregados de SigCdPac (captions do opt_nr_opcao)
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtro: ordem de classificacao (get_ordem.ListIndex)
    *-- 1=VALOR, 2=DATA VENCIMENTO, 3=DATA OPERACAO
    this_nIndexOrdem        = 1

    *-- Filtro: taxa de juros mensal %
    this_nJuros             = 0

    *-- Filtro: opcao bons (Opt_Bons.Value): 1=Ativos, 2=Todos
    this_nOptBons           = 1

    *-- Tipo de juros de SigCdPam.JuroCarts: 1=Simples, 2=Compostos
    this_nJurosCarts        = 1

    *-- Filtro emissor/carteira
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro origem
    this_cCdOriGrupo        = ""
    this_cDsOriGrupo        = ""
    this_cCdOriConta        = ""
    this_cDsOriConta        = ""

    *-- Filtro destino/deposito
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura FRX, titulo, datas iniciais e carrega parametros auxiliares
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReCrt.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques Da Carteira"
            THIS.this_dDtInicial  = DATE()
            THIS.this_dDtFinal    = DATE()
            IF DODEFAULT()
                THIS.CarregarParametros()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdOpt (indexado), SigCdPac e SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Operacoes de cheque: necessario para filtros de tipo no PrepararDados
            loc_cSQL = "SELECT * FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpt")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao carregar SigCdOpt"
            ELSE
                SELECT cursor_4c_SigCdOpt
                INDEX ON operacaos TAG operacaos
                GO TOP

                *-- Titulos das opcoes de nota (SigCdPac)
                loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPac
                    GO TOP
                    THIS.this_cTituloOpcao1 = IIF(!EMPTY(ALLTRIM(TitOpcS)), ALLTRIM(TitOpcS), "Sim")
                    THIS.this_cTituloOpcao2 = IIF(!EMPTY(ALLTRIM(TitOpcN)), ALLTRIM(TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cTituloOpcao3 = IIF(!EMPTY(ALLTRIM(TitOpcA)), ALLTRIM(TitOpcA), "Ambos")
                    USE IN cursor_4c_SigCdPac
                ENDIF

                *-- Parametros de juros (SigCdPam.JuroCarts: 1=Simples, 2=Compostos)
                loc_cSQL = "SELECT JuroCarts FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    THIS.this_nJurosCarts = IIF(!EOF(), NVL(JuroCarts, 1), 1)
                    USE IN cursor_4c_SigCdPam
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa e popula CsRelatorio/CsCabecalho
    * Replica o processamento() do form legado SIGRECRT
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro, loc_lOK
        LOCAL loc_nTipoDat, loc_dDtInicial, loc_dDtFinal
        LOCAL loc_cCdEmpresa, loc_cDsEmpresa, loc_nNrOpcao
        LOCAL loc_cCdEmiGrupo, loc_cDsEmiGrupo, loc_cCdEmiConta, loc_cDsEmiConta
        LOCAL loc_cCdOriGrupo, loc_cDsOriGrupo, loc_cCdOriConta, loc_cDsOriConta
        LOCAL loc_cCdDesGrupo, loc_cDsDesGrupo, loc_cCdDesConta, loc_cDsDesConta
        LOCAL loc_nTipoRel, loc_nJuros, loc_nIndexOrdem, loc_nOptBons
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerOriGrupo, loc_cVerOriConta
        LOCAL loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cVerOrdem, loc_cVerTipo
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cEmissor, loc_cDestino, loc_cOrigem
        LOCAL loc_cTipoD, loc_cSQL, loc_nResult
        LOCAL loc_nDias, loc_nTxDia, loc_nVJuros, loc_dVen, loc_dDat

        loc_lSucesso = .F.
        TRY
            loc_lOK = .T.

            *-- Copiar filtros das propriedades para variaveis locais
            *-- (necessario: ?var em SQLEXEC exige variaveis no escopo local/private)
            loc_nTipoDat    = THIS.this_nTipoDat
            loc_dDtInicial  = THIS.this_dDtInicial
            loc_dDtFinal    = THIS.this_dDtFinal
            loc_cCdEmpresa  = THIS.this_cCdEmpresa
            loc_cDsEmpresa  = THIS.this_cDsEmpresa
            loc_nNrOpcao    = THIS.this_nNrOpcao
            loc_cCdEmiGrupo = THIS.this_cCdEmiGrupo
            loc_cDsEmiGrupo = THIS.this_cDsEmiGrupo
            loc_cCdEmiConta = THIS.this_cCdEmiConta
            loc_cDsEmiConta = THIS.this_cDsEmiConta
            loc_cCdOriGrupo = THIS.this_cCdOriGrupo
            loc_cDsOriGrupo = THIS.this_cDsOriGrupo
            loc_cCdOriConta = THIS.this_cCdOriConta
            loc_cDsOriConta = THIS.this_cDsOriConta
            loc_cCdDesGrupo = THIS.this_cCdDesGrupo
            loc_cDsDesGrupo = THIS.this_cDsDesGrupo
            loc_cCdDesConta = THIS.this_cCdDesConta
            loc_cDsDesConta = THIS.this_cDsDesConta
            loc_nTipoRel    = THIS.this_nTipoRel
            loc_nJuros      = THIS.this_nJuros
            loc_nIndexOrdem = THIS.this_nIndexOrdem
            loc_nOptBons    = THIS.this_nOptBons

            *-- Clausulas WHERE para SQLEXEC (usa ?var para parametrizacao de data/string)
            loc_cVerData = IIF(loc_nTipoDat = 2, ;
                " and b.datas between ?loc_dDtInicial and ?loc_dDtFinal ", ;
                " and b.vencs between ?loc_dDtInicial and ?loc_dDtFinal ")
            loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "", ;
                                   " and a.emps = ?loc_cCdEmpresa ")
            loc_cVerOpcao    = IIF(loc_nNrOpcao = 1, ;
                                   " and not a.notas = '" + SPACE(6) + "' ", ;
                                   IIF(loc_nNrOpcao = 2, ;
                                       " and a.notas = '" + SPACE(6) + "' ", ;
                                       ""))
            loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "", ;
                                   " and b.grupoT = ?loc_cCdEmiGrupo ")
            loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "", ;
                                   " and b.contaT = ?loc_cCdEmiConta ")
            loc_cVerOriGrupo = IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "", ;
                                   " and e.grupoOs = ?loc_cCdOriGrupo ")
            loc_cVerOriConta = IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "", ;
                                   " and e.contaOs = ?loc_cCdOriConta ")
            loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "", ;
                                   " and e.grupoDs = ?loc_cCdDesGrupo ")
            loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "", ;
                                   " and e.contaDs = ?loc_cCdDesConta ")
            loc_cVerOrdem    = IIF(loc_nIndexOrdem = 1, " ORDER BY 2", ;
                                IIF(loc_nIndexOrdem = 2, " ORDER BY 3", " ORDER BY 4"))

            *-- Filtro de tipo de relatorio: subselects em cursor_4c_SigCdOpt (VFP local)
            DO CASE
            CASE loc_nTipoRel = 2
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='CR' and devolvidos = 'N'] + ;
                               [ and opants not in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S'))]
            CASE loc_nTipoRel = 3
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'S')]
            CASE loc_nTipoRel = 4
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos <> 'S' and ] + ;
                               IIF(loc_nOptBons = 1, [tipos='DB' And Ordens = 1], [0 = 0]) + [)]
                loc_cVerTipo = loc_cVerTipo + ;
                               [ and a.contat Not in(Select Iclis from cursor_4c_CliCqDev)]
            CASE loc_nTipoRel = 5
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where devolvidos = 'S')]
            OTHERWISE
                loc_cVerTipo = [and a.umovs in (select operacaos from cursor_4c_SigCdOpt] + ;
                               [ where tipos='DB' and devolvidos = 'N')]
            ENDCASE

            *-- Clientes com cheque devolvido (necessario para filtro tipo 4 - Bons)
            IF USED("cursor_4c_CliCqDev")
                USE IN cursor_4c_CliCqDev
            ENDIF
            loc_cSQL = "select distinct contat as iclis from sigche" + ;
                       " where umovs in (Select operacaos from SigCdOpt where devolvidos = 'S')"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliCqDev")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar lista de cheques devolvidos"
                loc_lOK = .F.
            ENDIF

            *-- Query principal: cheques com joins em clientes, lancamentos e movimentacoes
            IF loc_lOK
                IF USED("cursor_4c_SqlTmp0")
                    USE IN cursor_4c_SqlTmp0
                ENDIF
                loc_cSQL = "select a.nums, b.valors, b.vencs, b.datas as dtBai, b.datas as dtEmi," + ;
                           " b.grclis, b.iclis, c.rclis as rclisT, d.rclis as rclisO, f.rclis as rclisD," + ;
                           " b.bancos, b.agencias, b.ncontas, b.ncheques, a.numlotes," + ;
                           " b.emps, b.umovs, e.codigos, b.contat, b.grupot, a.valjuros, a.cotas" + ;
                           " from SigCcChm a left join sigcdcli c" + ;
                           " on a.grupot = c.grupos and a.contat = c.iclis," + ;
                           " SigChe b, sigcdcli d, SigCqLcm e, sigcdcli f" + ;
                           " where a.nums = b.nums" + ;
                           " and a.numlotes = e.numlotes" + ;
                           " and b.umovs = e.codigos" + ;
                           " and e.grupoos = d.grupos and e.contaos = d.iclis" + ;
                           " and e.grupods = f.grupos and e.contads = f.iclis" + ;
                           loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                           loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                           loc_cVerOriGrupo + loc_cVerOriConta + ;
                           loc_cVerDesGrupo + loc_cVerDesConta + ;
                           " Order by a.nums, a.numlotes, b.datas, b.grclis, b.iclis," + ;
                           " b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques," + ;
                           " b.valors, b.emps, b.umovs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlTmp0")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados de cheques da carteira"
                    loc_lOK = .F.
                ENDIF
            ENDIF

            IF loc_lOK
                *-- Aplicar filtro de tipo via SELECT local VFP
                *-- (cursor_4c_SigCdOpt e cursor_4c_CliCqDev sao referenciados como VFP aliases)
                IF USED("CsRelatorio")
                    USE IN CsRelatorio
                ENDIF
                SELECT *, 0000000.00 AS cotasE, 0000000.00 AS valsai, 0000000.00 AS valent, ;
                       0000000.00 AS Dif, 0000000.00 AS valliq, SPACE(50) AS NomeCF ;
                    FROM cursor_4c_SqlTmp0 a WHERE 1=1 &loc_cVerTipo ;
                    INTO CURSOR CsRelatorio &loc_cVerOrdem. READWRITE

                *-- Buscar nome da empresa para o cabecalho
                loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cEmpresa)

                *-- Textos do cabecalho do relatorio
                loc_cTipoD = IIF(loc_nTipoDat = 1, "VENCIMENTO", "EMISSAO")
                DO CASE
                CASE loc_nTipoRel = 1
                    loc_cTitulo = "ATIVOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 2
                    loc_cTitulo = "BAIXADOS POR " + loc_cTipoD
                CASE loc_nTipoRel = 3
                    loc_cTitulo = "NEG.PG"
                CASE loc_nTipoRel = 4
                    loc_cTitulo = "BONS"
                OTHERWISE
                    loc_cTitulo = "DEVOLVIDOS"
                ENDCASE

                loc_cPeriodo = IIF(loc_nTipoDat = 2, "Emiss" + CHR(227) + "o: ", "Vencimento: ") + ;
                               DTOC(loc_dDtInicial) + " " + CHR(224) + " " + DTOC(loc_dDtFinal) + ;
                               " - Empresa: " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmpresa)), "Geral", ;
                                   ALLTRIM(loc_cCdEmpresa) + " - " + ALLTRIM(loc_cDsEmpresa))
                loc_cEmissor = "Grupo/Conta Emissor  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdEmiGrupo) + " - " + ALLTRIM(loc_cDsEmiGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdEmiConta)), "Todas", ;
                                   ALLTRIM(loc_cCdEmiConta) + " - " + ALLTRIM(loc_cDsEmiConta))
                loc_cDestino = "Grupo/Conta Destino  : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdDesGrupo) + " - " + ALLTRIM(loc_cDsDesGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdDesConta)), "Todas", ;
                                   ALLTRIM(loc_cCdDesConta) + " - " + ALLTRIM(loc_cDsDesConta))
                loc_cOrigem  = "Grupo/Conta Origem   : " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriGrupo)), "Todos", ;
                                   ALLTRIM(loc_cCdOriGrupo) + " - " + ALLTRIM(loc_cDsOriGrupo)) + ;
                               " / " + ;
                               IIF(EMPTY(ALLTRIM(loc_cCdOriConta)), "Todas", ;
                                   ALLTRIM(loc_cCdOriConta) + " - " + ALLTRIM(loc_cDsOriConta))

                *-- Cursor de cabecalho para o FRX
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                           Operacao C(80), Emissor C(80), Destino C(80), Origem C(80))
                INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino, Origem) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, ;
                            loc_cEmissor, loc_cDestino, loc_cOrigem)

                *-- Percorrer registros para calcular cotasE, valsai, Dif, valliq, juros
                SELECT CsRelatorio
                GO TOP
                SCAN
                    *-- Buscar cotas de entrada do cheque para calculo de diferencas
                    loc_cSQL = "select a.cotas, e.codigos from SigCcChm a, SigCqLcm e" + ;
                               " where a.numlotes = e.numlotes" + ;
                               " and a.bancos   ='" + ALLTRIM(CsRelatorio.bancos)   + "'" + ;
                               " and a.agencias ='" + ALLTRIM(CsRelatorio.agencias) + "'" + ;
                               " and a.ncontas  ='" + ALLTRIM(CsRelatorio.ncontas)  + "'" + ;
                               " and a.ncheques ='" + ALLTRIM(CsRelatorio.ncheques) + "'"
                    IF USED("cursor_4c_Cur1")
                        USE IN cursor_4c_Cur1
                    ENDIF
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cur1")

                    IF USED("cursor_4c_Cur2")
                        USE IN cursor_4c_Cur2
                    ENDIF
                    SELECT cotas FROM cursor_4c_Cur1 ;
                        WHERE codigos IN (SELECT operacaos FROM cursor_4c_SigCdOpt ;
                                          WHERE tipos = 'DB' AND devolvidos = 'N') ;
                        INTO CURSOR cursor_4c_Cur2
                    SELECT cursor_4c_Cur2
                    GO TOP
                    SELECT CsRelatorio
                    REPLACE cotasE WITH IIF(!EOF("cursor_4c_Cur2"), cursor_4c_Cur2.cotas, 1.00) ;
                        IN CsRelatorio
                    REPLACE rclisT WITH IIF(ISNULL(rclisT), "", rclisT) IN CsRelatorio
                    REPLACE NomeCF WITH IIF(INLIST(loc_nTipoRel, 1, 3), rclisO, rclisD) IN CsRelatorio

                    DO CASE
                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 2
                        REPLACE valjuros WITH 0 IN CsRelatorio
                        REPLACE valsai   WITH 0 IN CsRelatorio
                        REPLACE Dif      WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq   WITH 0 IN CsRelatorio
                        REPLACE dtBai    WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 1 AND loc_nTipoDat = 1
                        REPLACE valsai WITH 0 IN CsRelatorio
                        REPLACE Dif    WITH ROUND(valors / cotas, 2) IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio
                        REPLACE dtBai  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 2
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE valent WITH ROUND(valjuros / cotasE, 2) IN CsRelatorio
                        REPLACE Dif    WITH valsai - valent IN CsRelatorio
                        REPLACE valliq WITH valsai + Dif IN CsRelatorio
                        REPLACE dtEmi  WITH CTOD("  /  /  ") IN CsRelatorio
                        REPLACE vencs  WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 1
                        REPLACE dtBai WITH CTOD("  /  /  ") IN CsRelatorio

                    CASE loc_nTipoRel = 4 AND loc_nOptBons = 2
                        IF SEEK(CsRelatorio.umovs, "cursor_4c_SigCdOpt", "operacaos")
                            IF cursor_4c_SigCdOpt.Ordens = 1
                                REPLACE dtBai WITH CTOD("  /  /  ")
                            ENDIF
                        ENDIF
                        SELECT CsRelatorio

                    CASE INLIST(loc_nTipoRel, 3, 5)
                        REPLACE vencs  WITH CsRelatorio.Vencs IN CsRelatorio
                        REPLACE valsai WITH ROUND(valjuros / cotas, 2) IN CsRelatorio
                        REPLACE Dif    WITH 0 IN CsRelatorio
                        REPLACE valliq WITH 0 IN CsRelatorio

                        IF loc_nJuros > 0
                            loc_dVen   = DATE()
                            loc_dDat   = TTOD(CsRelatorio.Vencs)
                            loc_nDias  = IIF(loc_dDat >= loc_dVen, 0, loc_dVen - loc_dDat)
                            loc_nTxDia = loc_nJuros / 30
                            IF THIS.this_nJurosCarts = 2
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (((1 + loc_nTxDia / 100) ^ (loc_nDias)) - 1), 2)
                            ELSE
                                loc_nVJuros = ROUND(CsRelatorio.valors * ;
                                              (loc_nJuros / 100) * (loc_nDias / 30), 2)
                            ENDIF
                            REPLACE ValJuros WITH loc_nVJuros IN CsRelatorio
                        ENDIF
                    ENDCASE
                ENDSCAN

                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                SELECT CsRelatorio
                REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
                THIS.LimparCursores()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrtBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros principais.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRT|" + ;
                     STR(THIS.this_nTipoDat, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     STR(THIS.this_nTipoRel, 1) + "|" + ;
                     STR(THIS.this_nNrOpcao, 1) + "|" + ;
                     STR(THIS.this_nIndexOrdem, 1) + "|" + ;
                     STR(THIS.this_nOptBons, 1) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmiConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdOriConta) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cCdDesConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas TipoDat, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, TipoRel, NrOpcao, IndexOrdem, Juros, OptBons,
    *   CdEmiGrupo, DsEmiGrupo, CdEmiConta, DsEmiConta,
    *   CdOriGrupo, DsOriGrupo, CdOriConta, DsOriConta,
    *   CdDesGrupo, DsDesGrupo, CdDesConta, DsDesConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".TipoDat") = "N"
                    THIS.this_nTipoDat = EVALUATE(loc_cAlias + ".TipoDat")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".TipoRel") = "N"
                    THIS.this_nTipoRel = EVALUATE(loc_cAlias + ".TipoRel")
                ENDIF
                IF TYPE(loc_cAlias + ".NrOpcao") = "N"
                    THIS.this_nNrOpcao = EVALUATE(loc_cAlias + ".NrOpcao")
                ENDIF
                IF TYPE(loc_cAlias + ".IndexOrdem") = "N"
                    THIS.this_nIndexOrdem = EVALUATE(loc_cAlias + ".IndexOrdem")
                ENDIF
                IF TYPE(loc_cAlias + ".Juros") = "N"
                    THIS.this_nJuros = EVALUATE(loc_cAlias + ".Juros")
                ENDIF
                IF TYPE(loc_cAlias + ".OptBons") = "N"
                    THIS.this_nOptBons = EVALUATE(loc_cAlias + ".OptBons")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiGrupo") = "C"
                    THIS.this_cCdEmiGrupo = EVALUATE(loc_cAlias + ".CdEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiGrupo") = "C"
                    THIS.this_cDsEmiGrupo = EVALUATE(loc_cAlias + ".DsEmiGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmiConta") = "C"
                    THIS.this_cCdEmiConta = EVALUATE(loc_cAlias + ".CdEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmiConta") = "C"
                    THIS.this_cDsEmiConta = EVALUATE(loc_cAlias + ".DsEmiConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriGrupo") = "C"
                    THIS.this_cCdOriGrupo = EVALUATE(loc_cAlias + ".CdOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriGrupo") = "C"
                    THIS.this_cDsOriGrupo = EVALUATE(loc_cAlias + ".DsOriGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdOriConta") = "C"
                    THIS.this_cCdOriConta = EVALUATE(loc_cAlias + ".CdOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsOriConta") = "C"
                    THIS.this_cDsOriConta = EVALUATE(loc_cAlias + ".DsOriConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesGrupo") = "C"
                    THIS.this_cCdDesGrupo = EVALUATE(loc_cAlias + ".CdDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesGrupo") = "C"
                    THIS.this_cDsDesGrupo = EVALUATE(loc_cAlias + ".DsDesGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".CdDesConta") = "C"
                    THIS.this_cCdDesConta = EVALUATE(loc_cAlias + ".CdDesConta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsDesConta") = "C"
                    THIS.this_cDsDesConta = EVALUATE(loc_cAlias + ".DsDesConta")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "sigrecrtBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("CsCabecalho")
            USE IN CsCabecalho
        ENDIF
        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        IF USED("cursor_4c_SqlTmp0")
            USE IN cursor_4c_SqlTmp0
        ENDIF
        IF USED("cursor_4c_CliCqDev")
            USE IN cursor_4c_CliCqDev
        ENDIF
        IF USED("cursor_4c_Cur1")
            USE IN cursor_4c_Cur1
        ENDIF
        IF USED("cursor_4c_Cur2")
            USE IN cursor_4c_Cur2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores permanentes e libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED("cursor_4c_SigCdOpt")
            USE IN cursor_4c_SigCdOpt
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
