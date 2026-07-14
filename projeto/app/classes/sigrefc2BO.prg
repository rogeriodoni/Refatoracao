*==============================================================================
* SIGREFC2BO.PRG
* Business Object para Relatorio: Fechamento de Caixa
* Herda de: RelatorioBase
* Form original: SIGREFC1 (sigrefc2.SCX)
* Report form: SigReFc3
*==============================================================================

DEFINE CLASS sigrefc2BO AS RelatorioBase

    *-- Filtros do relatorio (mapeados dos controles do form original)
    this_dDtInicial      = {}       && get_dt_inicial - Data inicial do periodo
    this_dDtFinal        = {}       && get_dt_final   - Data final do periodo
    this_cCodEmpresa     = ""       && get_cd_empresa - Codigo da empresa (max 3 chars)
    this_cNomEmpresa     = ""       && get_ds_empresa - Razao social da empresa (max 40 chars)
    this_nTipoRelatorio  = 1        && TpRel.Value    - 1=Visao detalhada, 2=Mapa de Fechamento

    *-- Configuracao do relatorio
    this_cArquivoRelatorio = "SigReFc3"   && Nome do arquivo FRX (sem extensao e sem path)
    this_cTitulo           = "Fechamento de Caixa"

    *-- Parametros carregados de SigCdPam no Init
    this_cOperacao   = ""     && SigCdPam.dopes    - Operacao de fechamento configurada
    this_cConserto   = ""     && SigCdPam.opconsers - Operacao de conserto configurada

    *-- Variaveis de resultado (compatibilidade com PUBLIC vars do legado)
    this_nResLanca  = 0
    this_nResForma  = 0
    this_nResCheque = 0
    this_nResCartao = 0
    this_nResVende  = 0
    this_nResConta  = 0
    this_nResLanFor = 0
    this_nResQtdes  = 0
    this_nResVDets  = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa BO carregando dados de referencia necessarios
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_lAbortou, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        loc_lAbortou = .F.
        TRY
            DODEFAULT()

            *-- Cursor auxiliar de tipos de movimento (compatibilidade com framework)
            IF !USED("csSigCdTom")
                CREATE CURSOR csSigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                INDEX ON Codigos TAG Codigos
            ENDIF

            *-- Carrega parametros de fechamento de caixa
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPam", "CrSigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + "metros de fechamento"
                loc_lAbortou = .T.
            ENDIF

            *-- Extrai operacoes configuradas no parametro do sistema
            IF !loc_lAbortou AND RECCOUNT("CrSigCdPam") > 0
                SELECT CrSigCdPam
                GO TOP
                THIS.this_cOperacao = ALLTRIM(dopes)
                THIS.this_cConserto = ALLTRIM(opconsers)
            ENDIF

            *-- Carrega formas de pagamento indexado por fpags
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpFp", "CrSigOpFp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar formas de pagamento"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou AND RECCOUNT("CrSigOpFp") > 0
                SELECT CrSigOpFp
                INDEX ON fpags TAG FPags
                GO TOP
            ENDIF

            *-- Valores iniciais dos filtros
            IF !loc_lAbortou
                THIS.this_dDtInicial    = DATE()
                THIS.this_dDtFinal      = DATE()
                THIS.this_cCodEmpresa   = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.this_cNomEmpresa   = ""
                THIS.this_nTipoRelatorio = 1
                THIS.this_nResLanca     = 0
                THIS.this_nResForma     = 0
                THIS.this_nResCheque    = 0
                THIS.this_nResCartao    = 0
                THIS.this_nResVende     = 0
                THIS.this_nResConta     = 0
                THIS.this_nResLanFor    = 0
                THIS.this_nResQtdes     = 0
                THIS.this_nResVDets     = 0
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrSigOpFp")
            USE IN CrSigOpFp
        ENDIF
        IF USED("csSigCdTom")
            USE IN csSigCdTom
        ENDIF
        IF USED("csRelatorio")
            USE IN csRelatorio
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara todos os dados para o relatorio SigReFc3
    * Equivalente ao procedimento 'processamento' do formulario legado.
    * Declara PRIVATE pDtI/pDtF/pDtH para queries parametrizadas acessadas
    * pelos metodos auxiliares PrepararMapaFechamento e PrepararVisaoDetalhada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        LOCAL ldInicial, ldFinal, lcEmp, lnTpRel
        LOCAL lcOperacao, lcConserto, lcCbTitulo, lcCbPeriodo
        PRIVATE pDtI, pDtF, pDtH
        loc_lSucesso = .F.
        TRY
            ldInicial  = THIS.this_dDtInicial
            ldFinal    = THIS.this_dDtFinal
            lcEmp      = ALLTRIM(THIS.this_cCodEmpresa)
            lnTpRel    = THIS.this_nTipoRelatorio
            lcOperacao = ALLTRIM(THIS.this_cOperacao)
            lcConserto = ALLTRIM(THIS.this_cConserto)

            *-- Parametros datetime para queries parametrizadas (?pDtI / ?pDtF)
            pDtI = DATETIME(YEAR(ldInicial), MONTH(ldInicial), DAY(ldInicial),  0,  0,  0)
            pDtF = DATETIME(YEAR(ldFinal),   MONTH(ldFinal),   DAY(ldFinal),   23, 59, 59)
            pDtH = DATETIME(YEAR(DATE()),    MONTH(DATE()),    DAY(DATE()),    23, 59, 59)

            *-- Titulo da empresa para o cabecalho
            IF EMPTY(lcEmp)
                lcCbTitulo = "Todas as empresas"
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(lcEmp), ;
                    "cursor_4c_Refc2Emp")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Refc2Emp") > 0
                    SELECT cursor_4c_Refc2Emp
                    IF !EOF()
                        lcCbTitulo = lcEmp + "-" + ALLTRIM(Razas)
                    ELSE
                        lcCbTitulo = lcEmp
                    ENDIF
                ELSE
                    lcCbTitulo = lcEmp
                ENDIF
                IF USED("cursor_4c_Refc2Emp")
                    USE IN cursor_4c_Refc2Emp
                ENDIF
            ENDIF

            IF EMPTY(lcOperacao)
                MsgAviso("N" + CHR(227) + "o existe movimenta" + CHR(231) + CHR(227) + ;
                    "o de fechamento configurada!!!", "Aviso")
            ENDIF

            WAIT WINDOW "Aguarde..." NOWAIT NOCLEAR

            *-- Cria cursor de resultado do relatorio
            IF USED("csRelatorio")
                USE IN csRelatorio
            ENDIF
            CREATE CURSOR csRelatorio ;
                (c0 Char(60), c1 Char(30), c2 Char(30), ;
                 c3 Char(30), c4 Char(30), c5 Char(30), ;
                 c6 Char(30), c7 Char(2))

            IF lnTpRel = 2
                THIS.PrepararMapaFechamento(lcEmp, lcOperacao)
                lcCbTitulo = "MAPA DE FECHAMENTO"
            ENDIF

            IF lnTpRel = 1
                THIS.PrepararVisaoDetalhada(lcEmp, lcOperacao, lcConserto)
            ENDIF

            *-- Cabecalho do relatorio
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            lcCbPeriodo = "Periodo : " + DTOC(ldInicial) + " a " + DTOC(ldFinal)
            CREATE CURSOR csCabecalho (empresa c(240), titulo c(240), PERIODO c(80))
            INSERT INTO csCabecalho (empresa, titulo, PERIODO) ;
                VALUES (lcEmp + " ", lcCbTitulo, lcCbPeriodo)

            WAIT CLEAR

            SELECT csRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararMapaFechamento - Monta mapa de fechamentos por data/loja/vendedor
    * Corresponde ao bloco lnTpRel=2 do procedimento 'processamento' legado.
    * Utiliza PRIVATE pDtI/pDtF declarados em PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararMapaFechamento(par_lcEmp, par_lcOperacao)
        LOCAL loc_lcQuery, loc_nResult, loc_lcEmpAnt
        loc_lcEmpAnt = "   "

        *-- Seleciona vendas com gergdmis=1 (sem fpags de garantia/cortesia)
        loc_lcQuery = ;
            [Select a.emps, LEFT(convert(char,a.datas,120),10) as datas ] + ;
            [From sigmvCab a, sigcdope g, sigcdtom h ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [a.dopes = g.dopes and g.tipoops = h.codigos and h.gergdmis = 1 and ] + ;
            [g.tipoops <> 5 and ] + ;
            [a.EmpDopNums not in (select empdopnums from sigmvpar where ] + ;
            [fpags in ('GARANTIA','CORTESIA','PAG EFETUADO','PAG EFETUAD','CHEQUES')) and ] + ;
            [h.gergdmis = 1 group by a.emps, a.datas ]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosF") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosF)", "Erro")
            RETURN .F.
        ENDIF

        *-- Seleciona atendimentos/vendedores da operacao configurada
        loc_lcQuery = ;
            [Select a.emps, LEFT(convert(char,a.datas,120),10) as datas, ] + ;
            [a.dopes, b.codvends, b.nAtends as nAtend ] + ;
            [From SigMvCab a, SigMvate b ] + ;
            [Where a.empdopnums = b.empdopnums ] + ;
            [and a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [a.Dopes = '] + par_lcOperacao + [' ]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosF1") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosF1)", "Erro")
            RETURN .F.
        ENDIF

        *-- Une dados: loja/data sem atendente (fec=N) + com atendente (fec=S)
        SELECT a.emps, a.DataS, Space(10) As codvends, 000 As nAtend, 'N' As fec ;
            From csDadosF a ;
            Where a.emps + a.DataS Not In (Select b.emps + b.DataS From csDadosF1 b) ;
            union ;
            SELECT a.emps, a.DataS, b.codvends, b.nAtend, 'S' As fec ;
            From csDadosF a, csDadosF1 b ;
            Where a.emps + a.DataS = b.emps + b.DataS ;
            Into Cursor curF

        SELECT * From curF Order By emps, DataS Into Cursor curFec

        SELECT curFec
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curFec") = 1
                APPEND BLANK
                REPLACE c0 With "MAPA DE FECHAMENTOS NO PERIODO"
                APPEND BLANK
                REPLACE c1 With "Loja"
                REPLACE c2 With "Data"
                REPLACE c3 With "Vendedor"
                REPLACE c4 With "Atendimentos"
                REPLACE c5 With "Fechamento"
                REPLACE c7 With "C5"
            ENDIF
            APPEND BLANK
            REPLACE c1 With IIF(ALLTRIM(curFec.emps) <> loc_lcEmpAnt, ALLTRIM(curFec.emps), [])
            REPLACE c2 With SUBSTR(curFec.DataS,9,2) + "/" + ;
                SUBSTR(curFec.DataS,6,2) + "/" + SUBSTR(curFec.DataS,1,4)
            REPLACE c3 With ALLTRIM(curFec.codvends)
            REPLACE c4 With ALLTRIM(STR(curFec.nAtend))
            REPLACE c5 With ALLTRIM(curFec.fec)
            REPLACE c7 With "D5"
            loc_lcEmpAnt = ALLTRIM(curFec.emps)
            SELECT curFec
        ENDSCAN

        IF USED("csDadosF")
            USE IN csDadosF
        ENDIF
        IF USED("csDadosF1")
            USE IN csDadosF1
        ENDIF
        IF USED("curF")
            USE IN curF
        ENDIF
        IF USED("curFec")
            USE IN curFec
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararVisaoDetalhada - Monta visao detalhada do fechamento de caixa
    * Corresponde ao bloco lnTpRel=1 do procedimento 'processamento' legado.
    * Utiliza PRIVATE pDtI/pDtF declarados em PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararVisaoDetalhada(par_lcEmp, par_lcOperacao, par_lcConserto)
        LOCAL loc_lcQuery, loc_nResult
        LOCAL lcAdq, lcInfo, lcBand, lcForma

        *-- 1. Vendas (csDadosV) - gergdmis=1, tipoops<>5, fpags normais
        loc_lcQuery = ;
            [Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, ] + ;
            [c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, d.fparcs, ] + ;
            [c.valos as valosM, c.moefpgs, ] + ;
            [case when d.infos = 'T' then d.formas else e.descrs end as info, ] + ;
            [d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente ] + ;
            [From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ] + ;
            [Where c.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [c.Emps = '] + par_lcEmp + [' And ]) + ;
            [g.tipoops = h.codigos and h.gergdmis = 1 and g.tipoops <> 5 and ] + ;
            [c.fpags = d.fpags and d.infos = e.infos and g.relfechas = 1 and ] + ;
            [c.dopes = g.dopes and ] + ;
            [c.fpags not in ('GARANTIA','CORTESIA','PAG EFETUADO','ABERTO R',] + ;
            ['PAG EFETUAD','CHEQUES','CREDITO LOJA','DEV LOJA','CRED PERMUTA') ] + ;
            [order by c.cidchaves]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosV") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosV)", "Erro")
            RETURN .F.
        ENDIF

        *-- 2. Pagamento Efetuado (csDadosP) - fpags de pagamento/credito
        loc_lcQuery = ;
            [Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, ] + ;
            [c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, d.fparcs, ] + ;
            [case when d.infos = 'T' then d.formas else e.descrs end as info, ] + ;
            [d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente ] + ;
            [From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ] + ;
            [Where c.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [c.Emps = '] + par_lcEmp + [' And ]) + ;
            [g.tipoops = h.codigos and h.gergdmis = 1 and g.tipoops <> 5 and ] + ;
            [c.fpags = d.fpags and d.infos = e.infos and g.opers <> 1 and ] + ;
            [g.relfechas = 1 and c.dopes = g.dopes and ] + ;
            [c.fpags in ('pag efetuado','aberto r','CREDITO LOJA','DEV LOJA','CRED PERMUTA') ] + ;
            [order by c.cidchaves]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosP") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosP)", "Erro")
            RETURN .F.
        ENDIF

        *-- 3. Devolucoes (csDadosD) - tipoops=5
        loc_lcQuery = ;
            [Select a.datas, a.Emps, a.Dopes, a.Numes, a.empdopnums, ] + ;
            [a.cidchaves as chaCab, b.cidchaves as chaItn, b.CPros, b.dpros, ] + ;
            [b.qtds, b.units, b.unitorigs, b.totas, i.empsubvend, a.empsdev ] + ;
            [From SigMvCab a, SigMvItn b, sigcdope g, SigOpCdi i ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [a.EmpDopNums = b.EmpDopNums and g.tipoops = 5 and ] + ;
            [g.relfechas = 1 and a.dopes = g.dopes and a.dopes = i.dopes ] + ;
            [order by a.cidchaves, b.cidchaves]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosD") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosD)", "Erro")
            RETURN .F.
        ENDIF

        *-- Filtra devolucoes: remove loja diferente quando EmpSubVend=1
        SELECT csDadosD
        SCAN
            IF EMPTY(EmpsDev)
                SELECT csDadosD
                LOOP
            ENDIF
            IF EmpSubVend = 1
                IF EmpsDev <> Emps
                    SELECT csDadosD
                    DELETE
                    LOOP
                ENDIF
            ENDIF
            SELECT csDadosD
        ENDSCAN

        *-- 4. Devolucoes subsidiarias (csDadosD2) - EmpsDev filtrado
        loc_lcQuery = ;
            [Select a.datas, a.Emps, a.Dopes, a.Numes, a.empdopnums, ] + ;
            [a.cidchaves as chaCab, b.cidchaves as chaItn, b.CPros, b.dpros, ] + ;
            [b.qtds, b.units, b.unitorigs, b.totas, i.empsubvend, a.empsdev ] + ;
            [From SigMvCab a, SigMvItn b, sigcdope g, SigOpCdi i ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.EmpsDev = '] + par_lcEmp + [' And ]) + ;
            [a.EmpDopNums = b.EmpDopNums and g.tipoops = 5 and ] + ;
            [g.relfechas = 1 and a.dopes = g.dopes and a.dopes = i.dopes ] + ;
            [and empsubvend = 1 ] + ;
            [order by a.cidchaves, b.cidchaves]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosD2") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosD2)", "Erro")
            RETURN .F.
        ENDIF

        *-- 5. E-Commerce (csDadosEC) - VENDA PICKUP STORE / SHIP FROM STOR
        loc_lcQuery = ;
            [Select distinct a.datas, a.emps, a.dopes, a.numes, a.pedidoweb, a.valos ] + ;
            [From SigMvCab a, sigcdope g, sigcdtom h ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [a.dopes = g.dopes and ] + ;
            [a.dopes in('VENDA PICKUP STORE','VENDA SHIP FROM STOR') and ] + ;
            [g.tipoops = h.codigos and g.relfechas = 1 ] + ;
            [order by a.datas]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosEC") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosEC)", "Erro")
            RETURN .F.
        ENDIF

        *-- 6. Recebimentos (csDadosR) - RECEBIMENTO via SigMvccr
        loc_lcQuery = ;
            [Select distinct IsNull(j.Datarcs, c.Datas) as datas, c.Emps, c.Dopes, ] + ;
            [c.Numes, c.empdopnums, c.cidchaves as chaPar, c.fpags, ] + ;
            [(c.valos*c.cotfpgs) as valos, d.fparcs, c.valos as valosM, c.moefpgs, ] + ;
            [case when d.infos = 'T' then d.formas else e.descrs end as info, ] + ;
            [d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente ] + ;
            [From SigMvccr a, sigmvPar c ] + ;
            [Left Join SigCdPgr j On c.Empdopnums = j.Empdopnums ] + ;
            [, sigcdope g, sigcdtom h, sigopfp d, sigprinf e ] + ;
            [Where IsNull(j.Datarcs, c.Datas) BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [c.Emps = '] + par_lcEmp + [' And ]) + ;
            [c.dopes = g.dopes and c.dopes = 'RECEBIMENTO' and c.nopers = a.nopers and ] + ;
            [g.tipoops = h.codigos and g.relfechas = 1 and ] + ;
            [c.fpags = d.fpags and d.infos = e.infos ] + ;
            [order by c.cidchaves]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosR") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosR)", "Erro")
            RETURN .F.
        ENDIF

        *-- 7. Consertos/OS (csDadosE) - operacao configurada em SigCdPam
        loc_lcQuery = ;
            [select a.numes, a.empsubns, ] + ;
            [convert(integer,right(a.codigos,6)) as numesS, b.dopes, c.valos, c.empdopnums ] + ;
            [from sigmvpec a, sigcdope b, sigmvcab c, sigcdope g ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [g.relfechas = 1 and a.dopes = g.dopes and a.dopes = '] + par_lcConserto + [' and ] + ;
            [convert(integer,a.codigos/1000000)=b.ndopes and ] + ;
            [c.emps = a.empsubns and ] + ;
            [c.dopes=b.dopes and c.numes = convert(integer,right(a.codigos,6)) ] + ;
            [order by c.empdopnums]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosE") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosE)", "Erro")
            RETURN .F.
        ENDIF

        *-- Prepara fechamento: agrega por chapar (vendas e recebimentos)
        SELECT chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, ;
            Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, ;
            Max(valpends) As valpends, Max(bandeira) As bandeira, ;
            MAX(adquirente) As adquirente, Max(valosM) As valosM, ;
            MAX(moefpgs) as moefpgs ;
            From csDadosV Group By chapar Into Cursor Curv

        SELECT chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, ;
            Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, ;
            Max(valpends) As valpends, Max(bandeira) As bandeira, ;
            MAX(adquirente) As adquirente, Max(valosM) As valosM, ;
            MAX(moefpgs) as moefpgs ;
            From csDadosR Group By chapar Into Cursor Curr

        *-- Une vendas (Curv) e recebimentos (Curr) com valRec
        SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, ;
            valos As valAv, Cast(0.00 As numeric(11,2)) As valFin, ;
            Cast(0.00 As numeric(11,2)) As valRec ;
            from Curv Where fparcs = 1 ;
            union ;
            SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, ;
            Cast(0.00 As numeric(11,2)) As valAv, valos As valFin, ;
            Cast(0.00 As numeric(11,2)) As valRec ;
            from Curv Where !(fparcs = 1) ;
            union ;
            SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, ;
            Cast(0.00 As numeric(11,2)) As valAv, ;
            Cast(0.00 As numeric(11,2)) As valFin, valos As valRec ;
            from Curr ;
            into Cursor Curt

        *-- Totais por forma de pagamento
        Select Info, Sum(valAv) As valAv, Sum(valFin) As valFin, Sum(valRec) As valRec ;
            From Curt Group By Info Into Cursor curPag
        Select *, valAv+valFin As valVenda, valAv+valFin+valRec As valTot ;
            From curPag Into Cursor curPag
        Select Sum(valAv) As valAv, Sum(valFin) As valFin, Sum(valRec) As valRec, ;
            Sum(valVenda) As valVenda, Sum(valTot) As valTot ;
            From curPag Into Cursor curPagT

        SELECT curPag
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curPag") = 1
                APPEND BLANK
                REPLACE c2 With "A VISTA"
                REPLACE c3 With "FINANCIADO"
                REPLACE c4 With "TOTAL (VENDAS)"
                REPLACE c5 With "RECEBIMENTO"
                REPLACE c6 With "TOTAL RECEBIDO"
                REPLACE c7 With "C1"
            ENDIF
            APPEND BLANK
            REPLACE c1 With curPag.Info
            REPLACE c2 With TRANSFORM(curPag.valAv,    "@R 999,999,999.99")
            REPLACE c3 With TRANSFORM(curPag.valFin,   "@R 999,999,999.99")
            REPLACE c4 With TRANSFORM(curPag.valVenda, "@R 999,999,999.99")
            REPLACE c5 With TRANSFORM(curPag.valRec,   "@R 999,999,999.99")
            REPLACE c6 With TRANSFORM(curPag.valTot,   "@R 999,999,999.99")
            REPLACE c7 With "D1"
            SELECT curPag
        ENDSCAN

        IF RECCOUNT("curPag") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c1 With "TOTAL"
            REPLACE c2 With TRANSFORM(curPagT.valAv,    "@R 999,999,999.99")
            REPLACE c3 With TRANSFORM(curPagT.valFin,   "@R 999,999,999.99")
            REPLACE c4 With TRANSFORM(curPagT.valVenda, "@R 999,999,999.99")
            REPLACE c5 With TRANSFORM(curPagT.valRec,   "@R 999,999,999.99")
            REPLACE c6 With TRANSFORM(curPagT.valTot,   "@R 999,999,999.99")
            REPLACE c7 With "T1"
            APPEND BLANK
            APPEND BLANK
        ENDIF

        *-- Totalizador por moeda
        Select valosM, moefpgs, chapar from Curv ;
            union ;
            Select valosM, moefpgs, chapar from Curr ;
            into cursor curM
        SELECT SUM(valosM) as valosM, moefpgs from curM group by moefpgs into cursor curM

        SELECT curM
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curM") = 1
                APPEND BLANK
                REPLACE c0 With "Total por moeda"
                APPEND BLANK
                REPLACE c3 With PADL("Total", 14)
                REPLACE c4 With "Moeda"
                REPLACE c7 With "C8"
            ENDIF
            APPEND BLANK
            REPLACE c3 With TRANSFORM(curM.valosM, "@R 999,999,999.99")
            REPLACE c4 With ALLTRIM(curM.moefpgs)
            REPLACE c7 With "D8"
            SELECT curM
        ENDSCAN
        SELECT csRelatorio
        APPEND BLANK
        APPEND BLANK

        *-- Pagamento Efetuado (tres colunas)
        Select dopes, numes, valos From csDadosP Order By dopes, numes Into Cursor curPeX
        Select Sum(valos) As valos From curPeX Into Cursor curPeT

        Select  Space(26) As dopes, Space(20) As valos, ;
            Space(26) As dopes1, Space(15) As valos1, ;
            Space(26) As dopes2, Space(15) As valos2 ;
            From curPeX where 1=0 Into Cursor curPe Readwrite

        SELECT curPeX
        GO TOP
        DO WHILE !EOF()
            SELECT curPe
            APPEND BLANK
            SELECT curPeX
            REPLACE dopes  With ALLTRIM(curPeX.dopes) + " " + ALLTRIM(STR(curPeX.numes)) In curPe
            REPLACE valos  With ALLTRIM(TRANSFORM(curPeX.valos, "@R 999,999,999.99")) In curPe
            SKIP
            IF EOF()
                EXIT
            ENDIF
            REPLACE dopes1 With ALLTRIM(curPeX.dopes) + " " + ALLTRIM(STR(curPeX.numes)) In curPe
            REPLACE valos1 With ALLTRIM(TRANSFORM(curPeX.valos, "@R 999,999,999.99")) In curPe
            SKIP
            IF EOF()
                EXIT
            ENDIF
            REPLACE dopes2 With ALLTRIM(curPeX.dopes) + " " + ALLTRIM(STR(curPeX.numes)) In curPe
            REPLACE valos2 With ALLTRIM(TRANSFORM(curPeX.valos, "@R 999,999,999.99")) In curPe
            SKIP
        ENDDO

        SELECT curPe
        GO TOP
        SCAN
            SELECT csRelatorio
            IF RECNO("curPe") = 1
                APPEND BLANK
                REPLACE c0 With "Recebido Anteriormente R$ " + ;
                    ALLTRIM(TRANSFORM(curPeT.valos, "@R 999,999,999.99"))
                APPEND BLANK
                REPLACE c1 With PADR("Vendas", 20)
                REPLACE c2 With PADL("Valor", 15)
                REPLACE c3 With PADR("Vendas", 20)
                REPLACE c4 With PADL("Valor", 15)
                REPLACE c5 With PADR("Vendas", 20)
                REPLACE c6 With PADL("Valor", 15)
                REPLACE c7 With "C7"
            ENDIF
            APPEND BLANK
            REPLACE c1 With ALLTRIM(curPe.dopes)
            REPLACE c2 With PADL(ALLTRIM(curPe.valos),  15)
            REPLACE c3 With ALLTRIM(curPe.dopes1)
            REPLACE c4 With PADL(ALLTRIM(curPe.valos1), 15)
            REPLACE c5 With ALLTRIM(curPe.dopes2)
            REPLACE c6 With PADL(ALLTRIM(curPe.valos2), 15)
            REPLACE c7 With "D7"
            SELECT curPe
        ENDSCAN
        SELECT csRelatorio
        APPEND BLANK
        APPEND BLANK

        *-- Pecas Devolvidas
        Select numes, cpros, qtds, totas From csDadosD ;
            union all ;
            Select numes, cpros, qtds, totas From csDadosD2 ;
            Into Cursor curDev

        Select Sum(totas) As totas From curDev Into Cursor curDevT

        SELECT curDev
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curDev") = 1
                APPEND BLANK
                REPLACE c0 With "PE" + CHR(199) + "AS DEVOLVIDAS"
                APPEND BLANK
                REPLACE c1 With "No. do P"
                REPLACE c2 With "Pe" + CHR(231) + "as"
                REPLACE c3 With PADL("Qtde", 15)
                REPLACE c4 With PADL("Valor", 15)
                REPLACE c7 With "C2"
            ENDIF
            APPEND BLANK
            REPLACE c1 With ALLTRIM(STR(curDev.numes))
            REPLACE c2 With ALLTRIM(curDev.cpros)
            REPLACE c3 With PADL(TRANSFORM(curDev.qtds, "@R 999999"), 15)
            REPLACE c4 With PADL(TRANSFORM(curDev.totas, "@R 999,999,999.99"), 15)
            REPLACE c7 With "D2"
            SELECT curDev
        ENDSCAN

        IF RECCOUNT("curDev") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c3 With PADL("TOTAL", 15)
            REPLACE c4 With PADL(TRANSFORM(curDevT.totas, "@R 999,999,999.99"), 15)
            REPLACE c7 With "T2"
            APPEND BLANK
            APPEND BLANK
        ENDIF

        *-- Venda E-Commerce
        Select numes, pedidoweb, valos From csDadosEC Into Cursor curECo
        Select Sum(valos) As valos From curECo Into Cursor curECoT

        SELECT curECo
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curECo") = 1
                APPEND BLANK
                REPLACE c0 With "VENDA E-COMMERCE"
                APPEND BLANK
                REPLACE c1 With "Numero"
                REPLACE c2 With "Pedido"
                REPLACE c3 With PADL("Valor", 15)
                REPLACE c7 With "C3"
            ENDIF
            APPEND BLANK
            REPLACE c1 With ALLTRIM(STR(curECo.numes))
            REPLACE c2 With ALLTRIM(curECo.Pedidoweb)
            REPLACE c3 With PADL(TRANSFORM(curECo.valos, "@R 999,999,999.99"), 15)
            REPLACE c7 With "D3"
            SELECT curECo
        ENDSCAN

        IF RECCOUNT("curECo") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c2 With PADL("TOTAL", 15)
            REPLACE c3 With PADL(TRANSFORM(curECoT.valos, "@R 999,999,999.99"), 15)
            REPLACE c7 With "T3"
            APPEND BLANK
            APPEND BLANK
        ENDIF

        *-- Ordens de Servico Pagas (Consertos)
        Select numes, numesS, valos From csDadosE Into Cursor curEnt
        Select Sum(valos) As valos From curEnt Into Cursor curEntT

        SELECT curEnt
        GO TOP

        SCAN
            SELECT csRelatorio
            IF RECNO("curEnt") = 1
                APPEND BLANK
                REPLACE c0 With "ORDEM DE SERVI" + CHR(199) + "OS PAGAS"
                APPEND BLANK
                REPLACE c1 With "No. do P"
                REPLACE c2 With "OS"
                REPLACE c3 With PADL("Valor", 15)
                REPLACE c7 With "C3"
            ENDIF
            APPEND BLANK
            REPLACE c1 With ALLTRIM(STR(curEnt.numes))
            REPLACE c2 With ALLTRIM(STR(curEnt.numesS))
            REPLACE c3 With PADL(TRANSFORM(curEnt.valos, "@R 999,999,999.99"), 15)
            REPLACE c7 With "D3"
            SELECT curEnt
        ENDSCAN

        IF RECCOUNT("curEnt") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c2 With PADL("TOTAL", 15)
            REPLACE c3 With PADL(TRANSFORM(curEntT.valos, "@R 999,999,999.99"), 15)
            REPLACE c7 With "T3"
            APPEND BLANK
            APPEND BLANK
        ENDIF

        *-- Detalhamento OS pagas (preparafechamentoconserto do legado)
        THIS.PrepararFechamentoConserto(par_lcEmp, par_lcConserto)

        *-- Cartoes por adquirente (CARTAO PARCELADO + CARTAO A VISTA)
        Select adquirente, bandeira, empdopnums ;
            From Curt Where bandeira <> '  ' ;
            Group By empdopnums, adquirente, bandeira Into Cursor crQtv
        Select adquirente, bandeira, Count(empdopnums) As qtdv ;
            From crQtv Group By adquirente, bandeira Into Cursor crQtv

        SELECT adquirente from crQtv group by adquirente into cursor crAdq
        SELECT crAdq
        GO TOP

        SCAN
            lcAdq = crAdq.adquirente

            *-- Cartao Parcelado (CARTAO/CREDITO) por adquirente
            Select a.bandeira, Sum(a.valFin+a.valAv) As valos, ;
                Max(b.qtdv) As qtds, lcAdq As adquirente, 000 As linha ;
                from Curt a, crQtv b ;
                Where Inlist(a.formas,'CARTAO','CREDITO') And a.adquirente == lcAdq ;
                and a.adquirente=b.adquirente And a.bandeira=b.bandeira ;
                group By a.bandeira Into Cursor curCar Readwrite

            Select Sum(valos) As valos, Sum(qtds) As qtds ;
                From curCar Into Cursor curCarT

            SELECT curCar
            GO TOP

            SCAN
                SELECT csRelatorio
                IF RECNO("curCar") = 1
                    APPEND BLANK
                    REPLACE c0 With lcAdq
                    APPEND BLANK
                    REPLACE c1 With "CART" + CHR(195) + "O PARCELADO"
                    REPLACE c2 With PADL("QTD.", 15)
                    REPLACE c3 With PADL("VALOR VENDIDO", 15)
                    REPLACE c7 With "C4"
                ENDIF
                APPEND BLANK
                REPLACE c1 With ALLTRIM(NVL(curCar.bandeira, []))
                REPLACE c2 With PADL(TRANSFORM(NVL(curCar.qtds, 0), "@R 999999"), 15)
                REPLACE c3 With PADL(TRANSFORM(NVL(curCar.valos, 0), "@R 999,999,999.99"), 15)
                REPLACE c7 With "D4"
                SELECT curCar
            ENDSCAN

            IF RECCOUNT("curCar") > 0
                SELECT csRelatorio
                APPEND BLANK
                REPLACE c1 With PADL("TOTAL", 15)
                REPLACE c2 With PADL(TRANSFORM(curCarT.qtds, "@R 999999"), 15)
                REPLACE c3 With PADL(TRANSFORM(curCarT.valos, "@R 999,999,999.99"), 15)
                REPLACE c7 With "T4"
                APPEND BLANK
                APPEND BLANK
            ENDIF

            *-- Cartao a Vista (DEBITO) por adquirente
            Select a.bandeira, Sum(a.valFin+a.valAv) As valos, ;
                Max(b.qtdv) As qtds, lcAdq As adquirente, 000 As linha ;
                from Curt a, crQtv b ;
                Where Inlist(a.formas,'DEBITO') And a.adquirente == lcAdq ;
                and a.adquirente=b.adquirente And a.bandeira=b.bandeira ;
                group By a.bandeira Into Cursor curCarD Readwrite

            Select * from curCarD into cursor curCar readwrite
            Select Sum(valos) As valos, Sum(qtds) As qtds ;
                From curCar Into Cursor curCarT

            SELECT curCar
            GO TOP

            SCAN
                SELECT csRelatorio
                IF RECNO("curCar") = 1
                    APPEND BLANK
                    REPLACE c0 With lcAdq
                    APPEND BLANK
                    REPLACE c1 With "CART" + CHR(195) + "O " + CHR(192) + " VISTA"
                    REPLACE c2 With PADL("QTD.", 15)
                    REPLACE c3 With PADL("VALOR VENDIDO", 15)
                    REPLACE c7 With "C6"
                ENDIF
                APPEND BLANK
                REPLACE c1 With ALLTRIM(NVL(curCar.bandeira, []))
                REPLACE c2 With PADL(TRANSFORM(NVL(curCar.qtds, 0), "@R 999999"), 15)
                REPLACE c3 With PADL(TRANSFORM(NVL(curCar.valos, 0), "@R 999,999,999.99"), 15)
                REPLACE c7 With "D6"
                SELECT curCar
            ENDSCAN

            IF RECCOUNT("curCar") > 0
                SELECT csRelatorio
                APPEND BLANK
                REPLACE c1 With PADL("TOTAL", 15)
                REPLACE c2 With PADL(TRANSFORM(curCarT.qtds, "@R 999999"), 15)
                REPLACE c3 With PADL(TRANSFORM(curCarT.valos, "@R 999,999,999.99"), 15)
                REPLACE c7 With "T6"
                APPEND BLANK
                APPEND BLANK
            ENDIF

            SELECT crAdq
        ENDSCAN

        *-- Limpa cursores intermediarios
        LOCAL loc_aCursores(16), loc_n
        loc_aCursores(1)  = "csDadosV"
        loc_aCursores(2)  = "csDadosP"
        loc_aCursores(3)  = "csDadosD"
        loc_aCursores(4)  = "csDadosD2"
        loc_aCursores(5)  = "csDadosEC"
        loc_aCursores(6)  = "csDadosR"
        loc_aCursores(7)  = "csDadosE"
        loc_aCursores(8)  = "Curv"
        loc_aCursores(9)  = "Curr"
        loc_aCursores(10) = "Curt"
        loc_aCursores(11) = "curPag"
        loc_aCursores(12) = "curPagT"
        loc_aCursores(13) = "curM"
        loc_aCursores(14) = "curPeX"
        loc_aCursores(15) = "curPeT"
        loc_aCursores(16) = "curPe"
        FOR loc_n = 1 TO 16
            IF USED(loc_aCursores(loc_n))
                USE IN (loc_aCursores(loc_n))
            ENDIF
        ENDFOR
        IF USED("curDev")
            USE IN curDev
        ENDIF
        IF USED("curDevT")
            USE IN curDevT
        ENDIF
        IF USED("curECo")
            USE IN curECo
        ENDIF
        IF USED("curECoT")
            USE IN curECoT
        ENDIF
        IF USED("curEnt")
            USE IN curEnt
        ENDIF
        IF USED("curEntT")
            USE IN curEntT
        ENDIF
        IF USED("crQtv")
            USE IN crQtv
        ENDIF
        IF USED("crAdq")
            USE IN crAdq
        ENDIF
        IF USED("curCar")
            USE IN curCar
        ENDIF
        IF USED("curCarD")
            USE IN curCarD
        ENDIF
        IF USED("curCarT")
            USE IN curCarT
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararFechamentoConserto - Detalhamento das OS pagas por adquirente
    * Equivalente ao procedimento 'preparafechamentoconserto' legado.
    * Utiliza PRIVATE pDtI/pDtF declarados em PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararFechamentoConserto(par_lcEmp, par_lcConserto)
        LOCAL loc_lcQuery, loc_nResult
        LOCAL lcAdq, lcInfo, lcBand, lcForma

        loc_lcQuery = ;
            [Select c.datas, c.Emps, c.Dopes, c.Numes, c.empdopnums, ] + ;
            [c.cidchaves as chaPar, c.fpags, (c.valos*c.cotfpgs) as valos, ] + ;
            [d.fparcs, c.valos as valosM, c.moefpgs, ] + ;
            [case when d.infos = 'T' then d.formas else e.descrs end as info, ] + ;
            [d.formas, d.valpends, d.trocos, d.bandeira, c.adquirente ] + ;
            [From sigmvPar c, sigopfp d, sigprinf e, sigcdope g, sigcdtom h ] + ;
            [Where c.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [c.Emps = '] + par_lcEmp + [' And ]) + ;
            [g.relfechas = 1 and g.tipoops = h.codigos and h.gergdmis = 1 and ] + ;
            [g.tipoops <> 5 and c.fpags = d.fpags and d.infos = e.infos and ] + ;
            [c.dopes = g.dopes and ] + ;
            [c.fpags not in ('GARANTIA','CORTESIA','PAG EFETUADO','ABERTO R',] + ;
            ['PAG EFETUAD','CHEQUES','CREDITO LOJA','DEV LOJA','CRED PERMUTA') ] + ;
            [and c.empdopnums in(select a.empdopnums ] + ;
            [from sigmvpec a, sigcdope b, sigmvcab c, sigcdope g ] + ;
            [Where a.datas BetWeen ?pDtI And ?pDtF And ] + ;
            IIF(EMPTY(par_lcEmp), [ ], [a.Emps = '] + par_lcEmp + [' And ]) + ;
            [g.relfechas = 1 and a.dopes = g.dopes and a.dopes = '] + par_lcConserto + [' and ] + ;
            [convert(integer,a.codigos/1000000)=b.ndopes and c.emps = a.empsubns and ] + ;
            [c.dopes=b.dopes and c.numes = convert(integer,right(a.codigos,6))) and ] + ;
            [g.tipoops = h.codigos and h.gergdmis = 1 and g.tipoops <> 5 and ] + ;
            [c.fpags not in ('GARANTIA','CORTESIA','PAG EFETUADO','ABERTO R',] + ;
            ['PAG EFETUAD','CHEQUES','CREDITO LOJA','DEV LOJA','CRED PERMUTA') ] + ;
            [order by c.empdopnums ]

        IF SQLEXEC(gnConnHandle, loc_lcQuery, "csDadosNewE") < 1
            MsgErro("Favor Reinicializar o Processo!!! (csDadosNewE)", "Erro")
            RETURN .F.
        ENDIF

        *-- Agrega por chapar
        Select chapar, Max(empdopnums) As empdopnums, Max(valos) As valos, ;
            Max(fparcs) As fparcs, Max(Info) As Info, Max(formas) As formas, ;
            Max(valpends) As valpends, Max(bandeira) As bandeira, ;
            MAX(adquirente) As adquirente, Max(valosM) As valosM, ;
            MAX(moefpgs) as moefpgs ;
            From csDadosNewE Group By chapar Into Cursor CurvE

        Select chapar, empdopnums, Info, formas, bandeira, adquirente, ;
            valos As valAv, Cast(0.00 As numeric(11,2)) As valFin, ;
            Cast(0.00 As numeric(11,2)) As valRec ;
            from CurvE Where fparcs = 1 ;
            union ;
            SELECT chapar, empdopnums, Info, formas, bandeira, adquirente, ;
            Cast(0.00 As numeric(11,2)) As valAv, valos As valFin, ;
            Cast(0.00 As numeric(11,2)) As valRec ;
            from CurvE Where !(fparcs = 1) ;
            into Cursor CurtE

        SELECT CurtE
        GO TOP

        Store [] to lcAdq, lcInfo, lcBand, lcForma

        *-- Cursor estrutura para resultado
        Select Info, formas, bandeira, adquirente, valAv, ;
            Cast(0.00 As numeric(11,2)) As QtdAv, valFin, ;
            Cast(0.00 As numeric(11,2)) As QtdFin ;
            From CurtE Where 1=0 ;
            Into cursor csResultE readwrite

        Select valAv as aVista, QtdAv as QtVista, valFin as aPrazo, ;
            QtdFin as QtPrazo ;
            From csResultE Into Cursor csResTotalE readwrite

        SELECT csResTotalE
        APPEND BLANK

        SELECT CurtE
        GO TOP
        Select Distinct Info, adquirente from CurtE Into Cursor csAdqE Readwrite

        IF RECCOUNT("csAdqE") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c0 With "DETALHAMENTO DAS ORDEM DE SERVI" + CHR(199) + "OS PAGAS"
            APPEND BLANK
            REPLACE c2 With "A VISTA"
            REPLACE c4 With "PARCELADO"
            REPLACE c6 With "TOTAL"
            REPLACE c7 With "B7"

            SELECT csRelatorio
            APPEND BLANK
            REPLACE c2 With "QTD"
            REPLACE c3 With "R$"
            REPLACE c4 With "QTD"
            REPLACE c5 With "R$"
            REPLACE c6 With "R$"
            REPLACE c7 With "B1"
        ENDIF

        SELECT csAdqE
        GO TOP
        SCAN
            SELECT csResultE
            ZAP IN csResultE

            lcAdq  = csAdqE.Adquirente
            lcInfo = csAdqE.Info

            Select Distinct formas, bandeira ;
                from CurtE where adquirente = lcAdq and Info = lcInfo ;
                Into Cursor csBandE readwrite

            SELECT csRelatorio
            APPEND BLANK
            REPLACE c3 With ALLTRIM(lcInfo) + " " + ALLTRIM(lcAdq)
            REPLACE c7 With "B7"

            SELECT csBandE
            GO TOP
            SCAN
                lcBand  = csBandE.bandeira
                lcForma = csBandE.formas

                Select Info, adquirente, formas, bandeira, ;
                    Sum(valAv) As valAv, Count(1) as QtdAv, ;
                    Cast(0.00 As numeric(11,2)) As valFin, ;
                    Cast(0.00 As numeric(11,2)) As QtdFin ;
                    from CurtE ;
                    Where adquirente = lcAdq And Info = lcInfo ;
                    and bandeira = lcBand and formas = lcForma and valAv <> 0 ;
                    group by Info, adquirente, formas, bandeira ;
                union all ;
                Select Info, adquirente, formas, bandeira, ;
                    Cast(0.00 As numeric(11,2)) As valAv, ;
                    Cast(0.00 As numeric(11,2)) as QtdAv, ;
                    Sum(valFin) As valFin, Count(1) as QtdFin ;
                    from CurtE ;
                    Where adquirente = lcAdq And Info = lcInfo ;
                    and bandeira = lcBand and formas = lcForma and valFin <> 0 ;
                    group by Info, adquirente, formas, bandeira ;
                    Into Cursor csValAvE

                Select Info, adquirente, formas, bandeira, ;
                    Sum(valAv) As valAv, Sum(QtdAv) As QtdAv, ;
                    Sum(valFin) As valFin, Sum(QtdFin) As QtdFin ;
                    from csValAvE ;
                    Group by Info, adquirente, formas, bandeira ;
                    Into Cursor csSomaAFE ReadWrite

                SELECT csSomaAFE
                GO TOP
                SCAN
                    SELECT csResTotalE
                    GO TOP
                    REPLACE aVista  With aVista  + csSomaAFE.valAv  IN csResTotalE
                    REPLACE QtVista With QtVista + csSomaAFE.QtdAv  IN csResTotalE
                    REPLACE aPrazo  With aPrazo  + csSomaAFE.valFin IN csResTotalE
                    REPLACE QtPrazo With QtPrazo + csSomaAFE.QtdFin IN csResTotalE

                    SELECT csResultE
                    APPEND BLANK
                    REPLACE Info       With csSomaAFE.Info
                    REPLACE adquirente With csSomaAFE.adquirente
                    REPLACE formas     With csSomaAFE.formas
                    REPLACE bandeira   With csSomaAFE.bandeira
                    REPLACE valAv      With csSomaAFE.valAv
                    REPLACE QtdAv      With csSomaAFE.QtdAv
                    REPLACE valFin     With csSomaAFE.valFin
                    REPLACE QtdFin     With csSomaAFE.QtdFin IN csResultE
                    SELECT csSomaAFE
                ENDSCAN
                SELECT csBandE
            ENDSCAN

            SELECT csResultE
            GO TOP
            SCAN
                SELECT csRelatorio
                APPEND BLANK
                REPLACE c1 With IIF(EMPTY(csResultE.adquirente), csResultE.formas, csResultE.bandeira)
                REPLACE c2 With TRANSFORM(csResultE.QtdAv,  "@R 999,999,999.99")
                REPLACE c3 With TRANSFORM(csResultE.valAv,  "@R 999,999,999.99")
                REPLACE c4 With TRANSFORM(csResultE.QtdFin, "@R 999,999,999.99")
                REPLACE c5 With TRANSFORM(csResultE.valFin, "@R 999,999,999.99")
                REPLACE c6 With TRANSFORM(csResultE.valAv + csResultE.valFin, "@R 999,999,999.99")
                REPLACE c7 With "B1"
                SELECT csResultE
            ENDSCAN

            SELECT csAdqE
        ENDSCAN

        IF RECCOUNT("csResTotalE") > 0
            SELECT csRelatorio
            APPEND BLANK
            REPLACE c1 With "TOTAL"
            REPLACE c2 With TRANSFORM(csResTotalE.QtVista, "@R 999,999,999.99")
            REPLACE c3 With TRANSFORM(csResTotalE.aVista,  "@R 999,999,999.99")
            REPLACE c4 With TRANSFORM(csResTotalE.QtPrazo, "@R 999,999,999.99")
            REPLACE c5 With TRANSFORM(csResTotalE.aPrazo,  "@R 999,999,999.99")
            REPLACE c6 With TRANSFORM(csResTotalE.aVista + csResTotalE.aPrazo, "@R 999,999,999.99")
            REPLACE c7 With "T1"
            APPEND BLANK
            APPEND BLANK
        ENDIF

        *-- Limpa cursores intermediarios
        IF USED("csDadosNewE")
            USE IN csDadosNewE
        ENDIF
        IF USED("CurvE")
            USE IN CurvE
        ENDIF
        IF USED("CurtE")
            USE IN CurtE
        ENDIF
        IF USED("csResultE")
            USE IN csResultE
        ENDIF
        IF USED("csResTotalE")
            USE IN csResTotalE
        ENDIF
        IF USED("csAdqE")
            USE IN csAdqE
        ENDIF
        IF USED("csBandE")
            USE IN csBandE
        ENDIF
        IF USED("csValAvE")
            USE IN csValAvE
        ENDIF
        IF USED("csSomaAFE")
            USE IN csSomaAFE
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta relatorio para arquivo texto/Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReFc3_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do registro de relatorio executado
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCodEmpresa) + "|" + ;
            DTOC(THIS.this_dDtInicial) + "|" + ;
            DTOC(THIS.this_dDtFinal) + "|" + ;
            ALLTRIM(STR(THIS.this_nTipoRelatorio))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Mapeia datas/empresa/tipo do cursor para as propriedades this_*.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido ou n" + CHR(227) + "o aberto"
            ELSE
                SELECT (par_cAliasCursor)
                IF !EOF()
                    IF TYPE("dDtInicial") = "D"
                        THIS.this_dDtInicial = NVL(dDtInicial, DATE())
                    ENDIF
                    IF TYPE("dDtFinal") = "D"
                        THIS.this_dDtFinal = NVL(dDtFinal, DATE())
                    ENDIF
                    IF TYPE("cCodEmpresa") = "C"
                        THIS.this_cCodEmpresa = ALLTRIM(NVL(cCodEmpresa, ""))
                    ENDIF
                    IF TYPE("cNomEmpresa") = "C"
                        THIS.this_cNomEmpresa = ALLTRIM(NVL(cNomEmpresa, ""))
                    ENDIF
                    IF TYPE("nTipoRelatorio") = "N"
                        THIS.this_nTipoRelatorio = NVL(nTipoRelatorio, 1)
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a BO de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o Inserir n" + CHR(227) + "o se aplica a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a BO de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o Atualizar n" + CHR(227) + "o se aplica a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE
