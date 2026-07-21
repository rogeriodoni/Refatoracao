*==============================================================================
* SIGREAPPBO.PRG
* Business Object para Relatorio de Analise a Pagar / Receber
*
* Herda de: RelatorioBase
* Formulario origem: SIGREAPP.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS sigreappBO AS RelatorioBase

    *-- Filtros de data
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros de tipo de analise
    this_nOptAnaSi      = 1     && 1=Analitico, 2=Sintetico, 3=Fluxo de Caixa
    this_nOptDatas      = 1     && 1=Vencimento, 2=Emissao, 3=Lancamento
    this_nOptSaldos     = 1     && 1=Informado, 2=Data Inicial, 3=Data Atual
    this_nOptAutorizados = 1    && 1=Todos, 2=Autorizados, 3=Nao Autorizados
    this_nOptJuros      = 2     && 1=Sim, 2=Nao

    *-- Filtros de grupo contabil
    this_cGrupo         = ""    && Codigo do grupo (MaxLength=10)
    this_cDGrupo        = ""    && Descricao do grupo (MaxLength=20)

    *-- Filtros de conta contabil
    this_cConta         = ""    && Codigo da conta (MaxLength=10)
    this_cDConta        = ""    && Descricao da conta (MaxLength=40)

    *-- Filtro de numero de operacao
    this_nNumes         = 0     && Numero da operacao (0=todos)

    *-- Filtro de juros
    this_nJuros         = 0     && Taxa de juros % mes (InputMask=99.99)

    *-- Filtros de pagamento/recebimento
    this_nPagamentos    = 0     && CheckBox value: 0=desmarcado, 1=marcado
    this_nRecebimentos  = 0     && CheckBox value: 0=desmarcado, 1=marcado

    *-- Filtro de saldo inicial
    this_nSaldo         = 0     && Saldo inicial informado

    *-- Filtros de moeda
    this_cCdMoeda       = ""    && Codigo da moeda (MaxLength=3)
    this_cDsMoeda       = ""    && Descricao da moeda (MaxLength=15)

    *-- Filtros de Job (centro de custo)
    this_cJobs          = ""    && Codigo do job (MaxLength=10, padded)
    this_cDJobs         = ""    && Descricao do job (MaxLength=40)

    *-- Propriedades de runtime (estado interno)
    this_nVlCotacao     = 1     && Taxa de cotacao da moeda selecionada
    this_cSaldos1       = ""    && Label do saldo para cabecalho do relatorio
    this_cSaldos2       = ""    && Valor do saldo para cabecalho do relatorio

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            *-- Valores padrao identicos ao Init() original do SIGREAPP
            THIS.this_dDtInicial     = DATE()
            THIS.this_dDtFinal       = DATE()
            THIS.this_nNumes         = 0
            THIS.this_nVlCotacao     = 1
            THIS.this_nOptAnaSi      = 1
            THIS.this_nOptDatas      = 1
            THIS.this_nOptSaldos     = 1
            THIS.this_nOptAutorizados = 1
            THIS.this_nOptJuros      = 2  && Default: Nao calcular juros
            THIS.this_nJuros         = 0
            THIS.this_nPagamentos    = 0
            THIS.this_nRecebimentos  = 0
            THIS.this_nSaldo         = 0
            THIS.this_cCdMoeda       = ""
            THIS.this_cDsMoeda       = ""
            THIS.this_cGrupo         = ""
            THIS.this_cDGrupo        = ""
            THIS.this_cConta         = ""
            THIS.this_cDConta        = ""
            THIS.this_cJobs          = ""
            THIS.this_cDJobs         = ""
            THIS.this_cSaldos1       = ""
            THIS.this_cSaldos2       = ""

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos e cursores temporarios do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL ARRAY loc_aCursores[16]
        LOCAL loc_nI

        loc_aCursores[1]  = "crCabecalho"
        loc_aCursores[2]  = "crDados"
        loc_aCursores[3]  = "crDados1"
        loc_aCursores[4]  = "crDados2"
        loc_aCursores[5]  = "crDados3"
        loc_aCursores[6]  = "crRel"
        loc_aCursores[7]  = "crEmps"
        loc_aCursores[8]  = "crProcessar"
        loc_aCursores[9]  = "crPrevs"
        loc_aCursores[10] = "LocalPrev"
        loc_aCursores[11] = "LocalSaldos"
        loc_aCursores[12] = "crTmpPar"
        loc_aCursores[13] = "crTmpPrIt"
        loc_aCursores[14] = "crTmpPrBx"
        loc_aCursores[15] = "crTmpMccr"
        loc_aCursores[16] = "crParcPag"

        FOR loc_nI = 1 TO 16
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarCambio - Busca taxa de cambio (substitui fBuscarCambio legado)
    * par_cMoeda: codigo da moeda (3 chars); retorna taxa ou 1 se nao encontrar
    *--------------------------------------------------------------------------
    FUNCTION BuscarCambio(par_cMoeda)
        LOCAL loc_cChave

        IF EMPTY(par_cMoeda) OR PADR(ALLTRIM(par_cMoeda), 3) = SPACE(3)
            RETURN 1
        ENDIF

        IF USED("cursor_4c_SigCdCot")
            loc_cChave = PADR(ALLTRIM(par_cMoeda), 3) + DTOS(DATE())
            IF SEEK(loc_cChave, "cursor_4c_SigCdCot", "CMoeData")
                RETURN cursor_4c_SigCdCot.Valos
            ENDIF
        ENDIF

        RETURN 1
    ENDFUNC

    *--------------------------------------------------------------------------
    * NCalcJuros - Calcula juros compostos sobre valor vencido
    * par_ldDataVenc: data de vencimento (Date)
    * par_nVlrBase : valor base para calculo
    *--------------------------------------------------------------------------
    FUNCTION NCalcJuros(par_ldDataVenc, par_nVlrBase)
        LOCAL loc_nVlrJuros, loc_nDias, loc_nJurosDia

        loc_nVlrJuros = 0

        IF THIS.this_nJuros <= 0 OR THIS.this_nOptJuros <> 1
            RETURN 0
        ENDIF

        loc_nJurosDia = ROUND((((1 + THIS.this_nJuros / 100) ^ (1/30)) - 1) * 100, 9)

        IF par_ldDataVenc < DATE()
            loc_nDias = DATE() - par_ldDataVenc
            loc_nVlrJuros = ROUND(par_nVlrBase * (((1 + loc_nJurosDia / 100) ^ (loc_nDias)) - 1), 2)
        ENDIF

        RETURN loc_nVlrJuros
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscaSaldos - Busca saldos iniciais de contas contabeis
    * Retorna: saldo total acumulado (numeric)
    * Efeito colateral: preenche this_cSaldos1 e this_cSaldos2
    *--------------------------------------------------------------------------
    FUNCTION BuscaSaldos()
        LOCAL loc_cQuery, loc_nResult, loc_nRet, loc_cDataPat, loc_ldData

        loc_nRet = 0
        THIS.this_cSaldos1 = "Saldo Inicial :" + CHR(13)
        THIS.this_cSaldos2 = " " + CHR(13)

        TRY
            loc_ldData   = IIF(THIS.this_nOptSaldos = 2, THIS.this_dDtInicial, DATE())
            loc_cDataPat = "'" + DTOS(loc_ldData) + " 23:59:59'"

            loc_cQuery = "Select c.Grupos, c.Contas, d.RClis, c.Datas, c.Saldos " + ;
                         "From SigMvCcr c, SigCdCli d " + ;
                         "Where c.cIdChaves In (" + ;
                         "Select Max(b.cIdChaves) as cIdChaves " + ;
                         "From SigCdGcr a, SigMvCcr b " + ;
                         "Where a.Coletors = 11 And " + ;
                         "a.Codigos = b.Grupos And " + ;
                         "b.Datas <= " + loc_cDataPat + " " + ;
                         "Group By b.Grupos, b.Contas) And " + ;
                         "c.Contas = d.IClis And " + ;
                         "Not c.Saldos = 0"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalSaldos")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + CHR(227) + "o (LocalSaldos)")
                loc_lResultado = 0
            ENDIF

            SELECT LocalSaldos
            GO TOP IN LocalSaldos
            IF EOF("LocalSaldos")
                THIS.this_cSaldos1 = "Saldo Inicial :"
                THIS.this_cSaldos2 = "0,00 (Nenhuma Conta Com Saldo Configurada Nos Grupos de Contas)"
            ELSE
                SCAN
                    THIS.this_cSaldos1 = THIS.this_cSaldos1 + ;
                                         TRANSFORM(LocalSaldos.Saldos, "9,999,999,999.99") + ;
                                         " = " + CHR(13)
                    THIS.this_cSaldos2 = THIS.this_cSaldos2 + ;
                                         ALLTRIM(LocalSaldos.Contas) + ;
                                         " / " + ALLTRIM(LocalSaldos.RClis) + CHR(13)
                    loc_nRet = loc_nRet + LocalSaldos.Saldos
                ENDSCAN
            ENDIF
            USE IN LocalSaldos

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessaPagRec - Prepara dados para relatorio de Pagamentos/Recebimentos
    * Chamado por PrepararDados() quando this_nPagamentos=1 ou this_nRecebimentos=1
    *--------------------------------------------------------------------------
    PROCEDURE ProcessaPagRec()
        LOCAL loc_lSucesso, loc_cDopes, loc_cQuery, loc_nResult
        LOCAL loc_ldDataIni, loc_ldDataFin, loc_cGrupo, loc_cConta, loc_nCodOper
        LOCAL loc_cDataIni, loc_cDataFin, loc_cEmpresa, loc_cTitulo, loc_cPeriodo
        LOCAL loc_lcEDN

        loc_lSucesso = .F.

        TRY
            loc_cDopes    = PADR(IIF(THIS.this_nPagamentos = 1, "PAGAMENTO", "RECEBIMENTO"), 20)
            loc_ldDataIni = THIS.this_dDtInicial
            loc_ldDataFin = THIS.this_dDtFinal
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_nCodOper  = THIS.this_nNumes

            loc_cDataIni = "'" + DTOS(loc_ldDataIni) + "'"
            loc_cDataFin = "'" + DTOS(loc_ldDataFin) + " 23:59:59'"

            CREATE CURSOR crDados(Vencs d(8), Emps c(3), Numes n(6), Datas d(8), ;
                                  Titulos c(10), Debito n(12,2), Credito n(12,2), ;
                                  Acerto n(12,2), Moeda c(3), Hists c(100), ;
                                  Hist2s c(40), CondPag m(4), VlrPago m(4), nTotPago n(12,2))
            INDEX ON Emps + STR(Numes, 6) TAG OrdRel

            IF loc_nCodOper <= 0
                loc_cQuery = "Select a.Emps, a.Numes, a.EmpDopNums, a.DataRcs, a.Dopes " + ;
                             "from SigCdPgr a " + ;
                             "Inner Join SigCdPgc b on b.EmpDopNums = a.EmpDopNums " + ;
                             "where a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                             " and a.DataRcs between " + loc_cDataIni + " and " + loc_cDataFin + ;
                             " And b.Grupos = '" + loc_cGrupo + "'" + ;
                             IIF(!EMPTY(loc_cConta), " And b.Contas = '" + loc_cConta + "'", "") + ;
                             " Order by a.EmpDopNums"
            ELSE
                loc_cQuery = "Select Emps, Numes, EmpDopNums, DataRcs, Dopes " + ;
                             "from SigCdPgr where Dopes = " + EscaparSQL(loc_cDopes) + ;
                             " and Numes = " + STR(loc_nCodOper, 6)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crDados1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + CHR(227) + "o (crDados1)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF

            CREATE CURSOR crCabecalho(Empresa c(80), Titulo c(80), Periodo c(80))

            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - "
            IF USED("cursor_4c_SigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cEmps")
                    loc_cEmpresa = loc_cEmpresa + ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            loc_cTitulo = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise " + CHR(224) + ;
                          " Pagar/Receber - " + ;
                          IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamentos", "Recebimentos")

            IF loc_nCodOper <= 0
                loc_cPeriodo = IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamentos", "Recebimentos") + ;
                               " de : " + DTOC(loc_ldDataIni) + " " + CHR(224) + " " + DTOC(loc_ldDataFin)
                loc_cPeriodo = loc_cPeriodo + " - Grupo: " + ALLTRIM(loc_cGrupo) + ;
                               IIF(!EMPTY(loc_cConta), " - Conta: " + loc_cConta, "")
            ELSE
                loc_cPeriodo = IIF(loc_cDopes = PADR("PAGAMENTO", 20), "Pagamento", "Recebimento") + ;
                               ": N" + CHR(186) + " " + STR(loc_nCodOper, 6)
            ENDIF

            INSERT INTO crCabecalho(Empresa, Titulo, Periodo) ;
                             VALUES (loc_cEmpresa, loc_cTitulo, loc_cPeriodo)

            SELECT crDados1
            GO TOP IN crDados1
            SCAN
                loc_cQuery = "Select a.Acertos, a.Contas, a.Datas, a.Hists, a.Moedas, " + ;
                             "a.Nopers, a.Opers, a.Tipos, a.Valos, a.Vencs, a.Empos, b.RClis " + ;
                             "from SigCdPit a " + ;
                             "Inner Join SigCdCli b on b.Iclis = a.Contas " + ;
                             "Where EmpDopNums = '" + ALLTRIM(crDados1.EmpDopNums) + "'"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrIt")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPrIt)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF

                LOCAL loc_nValos, loc_nAcerto, loc_cMoeda, loc_cHists, loc_cHist2s
                LOCAL loc_ldVencs2, loc_cTitulo2
                loc_nValos   = 0
                loc_nAcerto  = 0
                loc_cMoeda   = ""
                loc_cHists   = ""
                loc_cHist2s  = ""
                loc_ldVencs2 = CTOD("")
                loc_cTitulo2 = ""

                loc_lcEDN = crDados1.Emps + crDados1.Dopes + STR(crDados1.Numes, 6)
                loc_cQuery = "Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs " + ;
                             "from SigMvPar where EmpDopNums = '" + ALLTRIM(loc_lcEDN) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crParcPag")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crParcPag)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT crParcPag

                SELECT crTmpPrIt
                SCAN
                    IF loc_nCodOper <= 0 AND !EMPTY(loc_cConta) AND loc_cConta <> crTmpPrIt.Contas
                        LOOP
                    ENDIF

                    loc_cQuery = "Select Valors, ValPags, Moedas, Hists, Hist2s, Vencs, Titulos " + ;
                                 "from SigMvCcr where Emps = '" + ALLTRIM(crTmpPrIt.Empos) + "'" + ;
                                 " and Nopers = " + STR(crTmpPrIt.Nopers, 9)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpMccr")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpMccr)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    loc_cQuery = "Select Valos, VPags, Emps, Dopes, Numes, FPags, MoeFpgs, Vencs " + ;
                                 "from SigMvPar where Emps = '" + ALLTRIM(crTmpPrIt.Empos) + "'" + ;
                                 " and Nopers = " + STR(crTmpPrIt.Nopers, 9)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPar)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crTmpPar

                    loc_cQuery = "Select Valos, FPags from SigCdPbx where Nopers = " + ;
                                 STR(crTmpPrIt.Nopers, 9) + ;
                                 " And EmpDopNums = '" + ALLTRIM(crDados1.EmpDopNums) + "'"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crTmpPrBx")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crTmpPrBx)"
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                    SELECT crTmpPrBx

                    loc_cTitulo2  = IIF(!EOF("crTmpMccr"), crTmpMccr.Titulos, "")
                    loc_cHist2s   = IIF(!EOF("crTmpMccr"), crTmpMccr.Hist2s, "")

                    DO CASE
                        CASE crTmpPrIt.Tipos = "C"
                            SELECT crTmpMccr
                            IF !EOF("crTmpMccr")
                                loc_nValos   = crTmpMccr.Valors - crTmpMccr.ValPags + crTmpPrIt.Acertos
                                loc_nAcerto  = crTmpPrIt.Acertos
                                loc_cMoeda   = crTmpMccr.Moedas
                                loc_cHists   = crTmpMccr.Hists
                                loc_cHist2s  = crTmpMccr.Hist2s
                                loc_ldVencs2 = TTOD(crTmpMccr.Vencs)
                            ENDIF

                        CASE crTmpPrIt.Tipos = "P"
                            SELECT crTmpPar
                            IF EOF("crTmpPar")
                                SELECT crTmpMccr
                                IF !EOF("crTmpMccr")
                                    loc_nValos   = crTmpMccr.Valors - crTmpMccr.ValPags + crTmpPrIt.Acertos
                                    loc_nAcerto  = crTmpPrIt.Acertos
                                    loc_cMoeda   = crTmpMccr.Moedas
                                    loc_cHists   = crTmpMccr.Hists
                                    loc_cHist2s  = crTmpMccr.Hist2s
                                    loc_ldVencs2 = TTOD(crTmpMccr.Vencs)
                                ENDIF
                            ELSE
                                loc_nValos   = crTmpPar.Valos - crTmpPar.VPags + crTmpPrIt.Acertos
                                loc_nAcerto  = crTmpPrIt.Acertos
                                loc_cMoeda   = crTmpPar.MoeFpgs
                                loc_ldVencs2 = TTOD(crTmpPar.Vencs)
                                loc_cHists   = ALLTRIM(crTmpPar.FPags) + " " + crTmpPar.Emps + ;
                                               ALLTRIM(crTmpPar.Dopes) + " " + ;
                                               ALLTRIM(STR(crTmpPar.Numes, 6))
                                IF !EOF("crTmpMccr")
                                    SELECT crTmpMccr
                                    loc_cHists  = crTmpMccr.Hists
                                    loc_cHist2s = crTmpMccr.Hist2s
                                ENDIF
                            ENDIF

                        CASE crTmpPrIt.Tipos = "M"
                            loc_nValos   = crTmpPrIt.Valos
                            loc_nAcerto  = crTmpPrIt.Acertos
                            loc_cMoeda   = crTmpPrIt.Moedas
                            loc_ldVencs2 = TTOD(crTmpPrIt.Vencs)
                            loc_cHists   = crTmpPrIt.Hists
                    ENDCASE

                    LOCAL loc_nDebito2, loc_nCredito2
                    loc_nDebito2  = IIF(crTmpPrIt.Opers = "D", 0, loc_nValos)
                    loc_nCredito2 = IIF(crTmpPrIt.Opers = "C", 0, loc_nValos)

                    loc_cHists = loc_cHists + IIF(!EMPTY(loc_cHist2s), CHR(13) + loc_cHist2s, "")

                    LOCAL loc_cCondFinal, loc_cVlPagoFinal, loc_nTotPagoFinal
                    loc_cCondFinal    = ""
                    loc_cVlPagoFinal  = ""
                    loc_nTotPagoFinal = 0

                    SELECT crTmpPrBx
                    SCAN
                        loc_cCondFinal   = loc_cCondFinal + ;
                                           IIF(!EMPTY(loc_cCondFinal), CHR(13), "") + crTmpPrBx.FPags
                        loc_cVlPagoFinal = loc_cVlPagoFinal + ;
                                           IIF(!EMPTY(loc_cVlPagoFinal), CHR(13), "") + ;
                                           TRANSFORM(crTmpPrBx.Valos, "9,999,999.99")
                        loc_nTotPagoFinal = loc_nTotPagoFinal + crTmpPrBx.Valos
                    ENDSCAN

                    INSERT INTO crDados(Emps, Numes, Datas, Titulos, Vencs, Debito, ;
                                        Credito, Acerto, Moeda, Hists, Hist2s, ;
                                        CondPag, VlrPago, nTotPago) ;
                                 VALUES (crDados1.Emps, crDados1.Numes, crTmpPrIt.Datas, ;
                                         loc_cTitulo2, loc_ldVencs2, loc_nDebito2, ;
                                         loc_nCredito2, loc_nAcerto, loc_cMoeda, ;
                                         loc_cHists, loc_cHist2s, loc_cCondFinal, ;
                                         loc_cVlPagoFinal, loc_nTotPagoFinal)
                ENDSCAN
            ENDSCAN

            SELECT crDados
            GO TOP IN crDados

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores de dados para o relatorio
    * Override de RelatorioBase.PrepararDados()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lPagRec, loc_cCpoDt, loc_ldDataIni, loc_ldDataFin
        LOCAL loc_cGrupo, loc_cConta, loc_cJob, loc_cDesJob, loc_nSaldo, loc_nAut
        LOCAL loc_cQuery, loc_nResult, loc_cDataIni, loc_cDataFin
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cPeriodo, loc_cMoeda, loc_cDatas
        LOCAL loc_cSaldo, loc_nCtRef, loc_nColuna, loc_cDesJob1
        LOCAL loc_ldVct, loc_nSdD, loc_nSdT, loc_nValFC, loc_nCtRFC

        loc_lSucesso = .F.

        TRY
            loc_ldDataIni = THIS.this_dDtInicial
            loc_ldDataFin = THIS.this_dDtFinal
            loc_cCpoDt    = IIF(THIS.this_nOptDatas = 1, "Vencs", ;
                               IIF(THIS.this_nOptDatas = 2, "DtEmis", "Datas"))
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cConta    = ALLTRIM(THIS.this_cConta)
            loc_lPagRec   = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)
            loc_nSaldo    = THIS.this_nSaldo
            loc_nAut      = THIS.this_nOptAutorizados
            loc_cJob      = PADR(ALLTRIM(THIS.this_cJobs), 10)
            loc_cDesJob   = IIF(!EMPTY(loc_cJob), ;
                               CHR(13) + CHR(10) + "Job : " + ALLTRIM(loc_cJob) + ;
                               " - " + THIS.this_cDJobs, "")

            IF loc_lPagRec
                loc_lSucesso = THIS.ProcessaPagRec()
                loc_lSucesso = loc_lSucesso
            ENDIF

            loc_cDataIni = "'" + DTOS(loc_ldDataIni) + "'"
            loc_cDataFin = "'" + DTOS(loc_ldDataFin) + " 23:59:59'"

            CREATE CURSOR crCabecalho (Empresa c(80), Titulo c(180), SubTitulo c(180), ;
                                       Periodo c(180), nQtdEmp n(2), ;
                                       cEmp1 c(3), cEmp2 c(3), cEmp3 c(3), cEmp4 c(3), ;
                                       cEmp5 c(3), cEmp6 c(3), cEmp7 c(3), cEmp8 c(3), ;
                                       cEmp9 c(3), SaldoFinal n(15,2), SaldoIni n(15,2), ;
                                       SaldosCab1 m, SaldosCab2 m)

            THIS.this_cSaldos1 = ""
            THIS.this_cSaldos2 = ""
            loc_cSaldo = ""

            IF (THIS.this_nOptAnaSi = 1)
                loc_cSaldo = IIF(!EMPTY(loc_nSaldo), ;
                                 " - Saldo Inicial : " + ;
                                 ALLTRIM(TRANSFORM(loc_nSaldo, "999,999,999.99")), "")
            ELSE
                IF INLIST(THIS.this_nOptSaldos, 2, 3)
                    loc_nSaldo = THIS.BuscaSaldos()
                ELSE
                    THIS.this_cSaldos1 = "Saldo Inicial : "
                    THIS.this_cSaldos2 = ALLTRIM(TRANSFORM(loc_nSaldo, "999,999,999.99"))
                ENDIF
            ENDIF

            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - "
            IF USED("cursor_4c_SigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cEmps")
                    loc_cEmpresa = loc_cEmpresa + ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            loc_cTitulo  = "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"
            loc_cMoeda   = IIF(EMPTY(THIS.this_cCdMoeda), "", ;
                               " - Moeda : " + ALLTRIM(THIS.this_cCdMoeda) + ;
                               " - " + ALLTRIM(THIS.this_cDsMoeda))
            loc_cDatas   = IIF(THIS.this_nOptDatas = 1, "Vencimentos", ;
                               IIF(THIS.this_nOptDatas = 2, ;
                                   "Emiss" + CHR(245) + "es", ;
                                   "Lan" + CHR(231) + "amentos"))
            loc_cDesJob1 = ""
            loc_cPeriodo = loc_cDatas + " de : " + DTOC(loc_ldDataIni) + ;
                           " " + CHR(224) + " " + DTOC(loc_ldDataFin) + ;
                           loc_cMoeda + loc_cSaldo + loc_cDesJob

            INSERT INTO crCabecalho (Empresa, Titulo, SubTitulo, Periodo, ;
                                     SaldoIni, SaldosCab1, SaldosCab2) ;
                             VALUES  (loc_cEmpresa, loc_cTitulo, loc_cDesJob1, ;
                                     loc_cPeriodo, loc_nSaldo, ;
                                     THIS.this_cSaldos1, THIS.this_cSaldos2)

            *-- Query principal: movimentos a pagar/receber em SigMvCcr
            loc_cQuery = "Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, " + ;
                         "a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, " + ;
                         "a.Valors as VlOrig, a.ValPags, (a.Valors-a.ValPags) as Valors, " + ;
                         "b.RClis, b.Codigos, a.Moedas " + ;
                         "From SigMvCcr a Inner Join SigCdCli b on b.iClis = a.Contas " + ;
                         "Where a." + loc_cCpoDt + " BetWeen " + loc_cDataIni + ;
                         " and " + loc_cDataFin

            IF !EMPTY(loc_cGrupo)
                loc_cQuery = loc_cQuery + " And a.Grupos = '" + loc_cGrupo + "'"
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cQuery = loc_cQuery + " And a.Contas = '" + loc_cConta + "'"
            ENDIF
            loc_cQuery = loc_cQuery + ;
                         " And (a.Valors-a.ValPags) > 0" + ;
                         " And a.Pagos = 1" + ;
                         " And a.ContaPgs <> 2" + ;
                         " And a.Tipos <> 'C'"
            IF THIS.this_nOptAnaSi = 3
                loc_cQuery = loc_cQuery + " And a.Tipos <> 'X'"
            ENDIF
            IF loc_nAut > 1
                loc_cQuery = loc_cQuery + " And " + ;
                             IIF(loc_nAut = 2, "Not ", "") + ;
                             "a.UsuConfs = Space(10)"
            ENDIF
            IF !EMPTY(loc_cJob)
                loc_cQuery = loc_cQuery + " And a.Jobs = '" + loc_cJob + "'"
            ENDIF
            loc_cQuery = loc_cQuery + ;
                         " Order By a.Emps, a.DopCs, a.Contas, a." + loc_cCpoDt

            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "crDados1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados1)"
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar operacoes de previsao selecionadas pelo usuario
            SELECT * ;
              FROM cursor_4c_SigOpOpe ;
             WHERE RealPrevs = 2 AND Imps = 1 ;
              INTO CURSOR crPrevs

            SELECT crPrevs
            GO TOP IN crPrevs
            IF !EOF("crPrevs")
                *-- Incluir movimentos de previsao (SigMvCpv)
                loc_cQuery = "Select a.Emps, a.DopCs, a.Nopers, a.EmpDopNums, a.Contas, " + ;
                             "a.Titulos, a.Vencs, a.Opers, a.Hists, a.EspecieNFs, " + ;
                             "a.Valors as VlOrig, a.ValPags, (a.Valors-a.ValPags) as Valors, " + ;
                             "b.RClis, b.Codigos, a.Moedas " + ;
                             "From SigMvCpv a Inner Join SigCdCli b on b.iClis = a.Contas " + ;
                             "Where a." + loc_cCpoDt + " Between " + loc_cDataIni + ;
                             " and " + loc_cDataFin

                IF !EMPTY(loc_cGrupo)
                    loc_cQuery = loc_cQuery + " And a.Grupos = '" + loc_cGrupo + "'"
                ENDIF
                IF !EMPTY(loc_cConta)
                    loc_cQuery = loc_cQuery + " And a.Contas = '" + loc_cConta + "'"
                ENDIF
                loc_cQuery = loc_cQuery + ;
                             " And (a.Valors-a.ValPags) > 0" + ;
                             " And a.Pagos = 1" + ;
                             " And a.ContaPgs <> 2" + ;
                             " And a.Tipos <> 'C'"
                IF THIS.this_nOptAnaSi = 3
                    loc_cQuery = loc_cQuery + " And a.Tipos <> 'X'"
                ENDIF
                IF loc_nAut > 1
                    loc_cQuery = loc_cQuery + " And " + ;
                                 IIF(loc_nAut = 2, "Not ", "") + ;
                                 "a.UsuConfs = Space(10)"
                ENDIF
                IF !EMPTY(loc_cJob)
                    loc_cQuery = loc_cQuery + " And a.Jobs = '" + loc_cJob + "'"
                ENDIF
                loc_cQuery = loc_cQuery + ;
                             " Order By a.Emps, a.DopCs, a.Contas, a." + loc_cCpoDt

                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalPrev")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (LocalPrev)"
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    loc_lSucesso = .F.
                ENDIF

                SELECT a.* ;
                  FROM crDados1 a ;
                 INNER JOIN cursor_4c_SigCdEmp b ON b.cEmps = a.Cemps ;
                 INNER JOIN cursor_4c_SigOpOpe c ON c.Dopes = a.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc d ON d.Codigos = a.Codigos ;
                 WHERE (b.Imps = 1) AND (c.Imps = 1) AND (d.Imps = 1) AND ;
                       a.Opers = LEFT(c.Opers, 1) ;
                 UNION ALL ;
                SELECT e.* ;
                  FROM LocalPrev e ;
                 INNER JOIN cursor_4c_SigCdEmp f ON f.cEmps = e.Cemps ;
                 INNER JOIN cursor_4c_SigOpOpe g ON g.Dopes = e.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc h ON h.Codigos = e.Codigos ;
                 WHERE (f.Imps = 1) AND (g.Imps = 1) AND (h.Imps = 1) AND ;
                       e.Opers = LEFT(g.Opers, 1) INTO CURSOR crDados2
            ELSE
                SELECT a.* ;
                  FROM crDados1 a ;
                 INNER JOIN cursor_4c_SigCdEmp b ON b.cEmps = a.Cemps ;
                 INNER JOIN cursor_4c_SigOpOpe c ON c.Dopes = a.DopCs ;
                 INNER JOIN cursor_4c_SigCdClc d ON d.Codigos = a.Codigos ;
                 WHERE (b.Imps = 1) AND (c.Imps = 1) AND (d.Imps = 1) AND ;
                       a.Opers = LEFT(c.Opers, 1) INTO CURSOR crDados2
            ENDIF

            *-- Filtrar por parcelas pagas e montar crDados final
            SELECT * FROM crDados2 WHERE 0=1 INTO CURSOR crDados READWRITE

            SELECT crDados2
            GO TOP IN crDados2
            SCAN
                LOCAL loc_ldVenc, loc_cQry, loc_nTmpResult, loc_nVPags
                IF !EMPTY(crDados2.EmpDopNums) AND crDados2.ValPags <= 0
                    loc_ldVenc = TTOD(crDados2.Vencs)
                    loc_cQry = "Select vPags from SigMvPar where empdopnums = '" + ;
                               ALLTRIM(crDados2.EmpDopNums) + ;
                               "' and Vencs = '" + DTOS(loc_ldVenc) + "'"
                    loc_nTmpResult = SQLEXEC(gnConnHandle, loc_cQry, "crTmpPar")
                    loc_nVPags = IIF(loc_nTmpResult > 0 AND !EOF("crTmpPar"), crTmpPar.VPags, 0)
                    IF (crDados2.VlOrig - loc_nVPags) > 0 OR loc_nTmpResult <= 0 OR EOF("crTmpPar")
                        SELECT crDados2
                        SCATTER MEMVAR MEMO
                        IF loc_nTmpResult > 0 AND !EOF("crTmpPar")
                            m.Valors = (m.VlOrig - IIF(crTmpPar.vPags > m.VlOrig, m.VlOrig, crTmpPar.vPags))
                        ENDIF
                        INSERT INTO crDados FROM MEMVAR
                    ENDIF
                ELSE
                    SELECT crDados2
                    SCATTER MEMVAR MEMO
                    INSERT INTO crDados FROM MEMVAR
                ENDIF
            ENDSCAN

            *-- Processar de acordo com o tipo de analise selecionado
            DO CASE
                CASE (THIS.this_nOptAnaSi = 1) && Analitico
                    CREATE CURSOR crRel(Emps c(3), DopCs c(20), Titulos c(10), ;
                                        Conta c(10), NomeConta c(50), Vencs d(8), ;
                                        Debito n(14,2), Credito n(14,2), VlJuros n(14,2), ;
                                        VlTotal n(14,2), EmpDopNums c(29), ;
                                        OpDopCs c(2), OpLanc c(1))

                    SELECT crDados
                    GO TOP IN crDados
                    SCAN
                        LOCAL loc_bFound, loc_nVlJuros2, loc_nValorConv2
                        loc_bFound = SEEK(crDados.DopCs, "cursor_4c_SigOpOpe", "Dopes")

                        loc_nVlJuros2   = 0
                        loc_nValorConv2 = crDados.Valors

                        IF loc_bFound AND !EOF("cursor_4c_SigOpOpe")
                            IF (cursor_4c_SigOpOpe.Opers == "CR" AND crDados.Opers = "C") OR ;
                               (cursor_4c_SigOpOpe.Opers == "DB" AND crDados.Opers = "D")
                                loc_nVlJuros2 = THIS.NCalcJuros(TTOD(crDados.Vencs), crDados.Valors)
                            ENDIF
                        ENDIF

                        loc_nCtRef = THIS.BuscarCambio(crDados.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValorConv2 = loc_nValorConv2 * loc_nCtRef / THIS.this_nVlCotacao
                        ENDIF

                        APPEND BLANK IN crRel
                        REPLACE Emps       WITH crDados.Emps, ;
                                DopCs      WITH crDados.DopCs, ;
                                Titulos    WITH crDados.Titulos, ;
                                Conta      WITH crDados.Contas, ;
                                EmpDopNums WITH IIF(EMPTY(SUBSTR(crDados.EmpDopNums, 4, 1)), "", crDados.EmpDopNums), ;
                                NomeConta  WITH crDados.RClis, ;
                                Vencs      WITH TTOD(crDados.Vencs), ;
                                Debito     WITH IIF(crDados.Opers = "D", loc_nValorConv2, 0), ;
                                Credito    WITH IIF(crDados.Opers = "C", loc_nValorConv2, 0), ;
                                VlJuros    WITH loc_nVlJuros2, ;
                                VlTotal    WITH loc_nValorConv2 + loc_nVlJuros2, ;
                                OpDopCs    WITH IIF(loc_bFound AND !EOF("cursor_4c_SigOpOpe"), ;
                                                    cursor_4c_SigOpOpe.Opers, ""), ;
                                OpLanc     WITH crDados.Opers IN crRel
                    ENDSCAN
                    SELECT crRel
                    INDEX ON DTOS(Vencs) TAG OrdRel

                CASE (THIS.this_nOptAnaSi = 2) && Sintetico
                    CREATE CURSOR crRel(Conta c(10), NomeConta c(50), ;
                                        nVlrEmp1 n(14,2), nVlrEmp2 n(14,2), nVlrEmp3 n(14,2), ;
                                        nVlrEmp4 n(14,2), nVlrEmp5 n(14,2), nVlrEmp6 n(14,2), ;
                                        nVlrEmp7 n(14,2), nVlrEmp8 n(14,2), nVlrEmp9 n(14,2), ;
                                        VlTotal n(14,2))
                    INDEX ON Conta TAG Conta

                    CREATE CURSOR crEmps(Coluna n(2), Emps c(3))
                    INDEX ON Emps TAG Emps

                    loc_nColuna = 1

                    SELECT crDados
                    GO TOP IN crDados
                    SCAN
                        LOCAL loc_bFound2, loc_nValorConv3, loc_nVlJuros3, loc_nVlrAtu
                        LOCAL loc_cCampoEmp, loc_cCampoVal, loc_nVlCampo
                        loc_bFound2 = SEEK(crDados.DopCs, "cursor_4c_SigOpOpe", "Dopes")

                        IF !SEEK(crDados.Contas, "crRel", "Conta")
                            APPEND BLANK IN crRel
                            REPLACE Conta     WITH crDados.Contas, ;
                                    NomeConta WITH crDados.RClis IN crRel
                        ENDIF

                        loc_nValorConv3 = crDados.Valors
                        loc_nCtRef = THIS.BuscarCambio(crDados.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValorConv3 = loc_nValorConv3 * loc_nCtRef / THIS.this_nVlCotacao
                        ENDIF

                        loc_nVlJuros3 = 0
                        IF loc_bFound2 AND !EOF("cursor_4c_SigOpOpe")
                            IF (cursor_4c_SigOpOpe.Opers == "CR" AND crDados.Opers = "C") OR ;
                               (cursor_4c_SigOpOpe.Opers == "DB" AND crDados.Opers = "D")
                                loc_nVlJuros3 = THIS.NCalcJuros(TTOD(crDados.Vencs), loc_nValorConv3)
                            ENDIF
                        ENDIF

                        loc_nVlrAtu = loc_nValorConv3 + loc_nVlJuros3

                        IF !SEEK(crDados.Emps, "crEmps", "Emps")
                            INSERT INTO crEmps(Coluna, Emps) VALUES (loc_nColuna, crDados.Emps)
                            loc_cCampoEmp = "cEmp" + ALLTRIM(STR(loc_nColuna))
                            REPLACE &loc_cCampoEmp WITH crDados.Emps IN crCabecalho
                            loc_nColuna = loc_nColuna + 1
                        ENDIF

                        loc_cCampoVal = "nVlrEmp" + ALLTRIM(STR(crEmps.Coluna))
                        loc_nVlCampo  = IIF(crDados.Opers = "D", loc_nVlrAtu, loc_nVlrAtu * -1)

                        REPLACE &loc_cCampoVal WITH &loc_cCampoVal + loc_nVlCampo, ;
                                VlTotal WITH VlTotal + loc_nVlCampo IN crRel
                    ENDSCAN

                    REPLACE nQtdEmp WITH loc_nColuna - 1 IN crCabecalho

                    SELECT crRel
                    INDEX ON NomeConta TAG OrdRel

                OTHERWISE && Fluxo de Caixa
                    SELECT "" as GrpSaldos, TTOD(Vencs) as Vencs, Titulos, Hists, ;
                           EspecieNFs, Moedas, Valors, Opers, ;
                           9999999999.99 as SaldoDia, 9999999999.99 as SaldoTot, ;
                           9999999999.99 as Debitos,  9999999999.99 as Creditos ;
                      FROM crDados ;
                     ORDER BY Vencs, Titulos, Hists, EspecieNFs, Moedas, Valors ;
                      INTO CURSOR crProcessar READWRITE

                    UPDATE crProcessar SET SaldoDia = 0, SaldoTot = 0, Debitos = 0, Creditos = 0

                    loc_ldVct = CTOD("01/01/1900")
                    loc_nSdD  = 0
                    loc_nSdT  = loc_nSaldo

                    SELECT crProcessar
                    SCAN
                        IF (loc_ldVct <> crProcessar.Vencs)
                            loc_nSdD = 0
                        ENDIF
                        loc_ldVct = crProcessar.Vencs

                        loc_nValFC  = ABS(crProcessar.Valors)
                        loc_nCtRFC  = THIS.BuscarCambio(crProcessar.Moedas)
                        IF THIS.this_nVlCotacao > 0
                            loc_nValFC = loc_nValFC * loc_nCtRFC / THIS.this_nVlCotacao
                        ENDIF

                        loc_nSdD = loc_nSdD + (loc_nValFC * IIF(crProcessar.Opers = "D", 1, -1))
                        loc_nSdT = loc_nSdT + (loc_nValFC * IIF(crProcessar.Opers = "D", 1, -1))

                        REPLACE Debitos  WITH IIF(crProcessar.Opers = "D", loc_nValFC, 0), ;
                                Creditos WITH IIF(crProcessar.Opers = "C", loc_nValFC, 0), ;
                                SaldoDia WITH loc_nSdD, ;
                                SaldoTot WITH loc_nSdT IN crProcessar
                    ENDSCAN

                    SELECT crProcessar
                    GO TOP IN crProcessar
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 PREVIEW NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 PREVIEW NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 PREVIEW NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 PREVIEW NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 TO PRINTER PROMPT NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 TO PRINTER PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 TO PRINTER PROMPT NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirSemDialogo - Prepara dados e imprime diretamente (sem dialogo)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirSemDialogo()
        LOCAL loc_lSucesso, loc_lPagRec

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lPagRec = (THIS.this_nPagamentos = 1) OR (THIS.this_nRecebimentos = 1)

            IF (THIS.this_nOptAnaSi = 3)
                REPORT FORM SigReAp4 TO PRINTER NOCONSOLE
            ELSE
                IF !loc_lPagRec
                    IF (THIS.this_nOptAnaSi = 1)
                        REPORT FORM SigReAp1 TO PRINTER NOCONSOLE
                    ELSE
                        REPORT FORM SigReAp2 TO PRINTER NOCONSOLE
                    ENDIF
                ELSE
                    REPORT FORM SigReAp3 TO PRINTER NOCONSOLE
                ENDIF
            ENDIF

            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e delega exportacao para Excel ao DODEFAULT
    * Para Fluxo de Caixa (opt=3): cria crDados3 com colunas do crProcessar
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nOptAnaSi = 3
                SELECT crDados
                GO TOP IN crDados

                SELECT grpsaldos, vencs, titulos, hists, especienfs, ;
                       valors, opers, debitos, creditos, saldodia, saldotot, moedas ;
                  FROM crProcessar ;
                 WHERE 0=0 INTO CURSOR crDados3 READWRITE

                SELECT crDados3
                GO TOP IN crDados3
            ENDIF

            DODEFAULT()

            THIS.RegistrarAuditoria("EXPORTAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        DO CASE
            CASE THIS.this_nPagamentos = 1
                loc_cTipo = "PAG"
            CASE THIS.this_nRecebimentos = 1
                loc_cTipo = "REC"
            CASE THIS.this_nOptAnaSi = 1
                loc_cTipo = "ANALITICO"
            CASE THIS.this_nOptAnaSi = 2
                loc_cTipo = "SINTETICO"
            OTHERWISE
                loc_cTipo = "FLUXOCAIXA"
        ENDCASE

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF THIS.this_nNumes > 0
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(STR(THIS.this_nNumes, 6))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (crCabecalho, crRel, crProcessar, crDados)
    *   - Imprimir() / Visualizar() / ExportarExcel() consomem esses cursores
    *     atraves dos .FRX SigReAp1/SigReAp2/SigReAp3/SigReAp4
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

ENDDEFINE
