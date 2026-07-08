*==============================================================================
* SIGREIIVBO.PRG
* Business Object do Relatorio de Impressao de Invoice
*
* Herda de RelatorioBase
* Responsavel por: selecao de dados, montagem do cursor crInvoices,
* preparacao para impressao/visualizacao do relatorio SigReIiv.FRX
*==============================================================================

DEFINE CLASS SigReIivBO AS RelatorioBase

    *-- Parametros de identificacao do pedido (recebidos via FormParaRelatorio)
    this_cEmps              = ""    && Codigo da empresa (3 chars)
    this_cDopes             = ""    && Codigo da operacao (20 chars)
    this_nNumes             = 0     && Numero do pedido
    this_nTpImp             = 0     && Tipo de impressao (1=preview, 2=imprimir, 3=auto, 4=prompt+imprimir)
    this_cContaEmail        = ""    && Email acumulado dos clientes de origem/destino

    *-- Opcoes de impressao
    this_lImprimirListagem  = .F.   && Imprimir listagem complementar (SigReIpk)

    *-- Cursor principal gerado pelo processamento
    this_cCursorDados       = "crInvoices"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de invoice
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Busca dados das tabelas de origem (selecionadados original)
    * Popula: cursor_4c_LocalParam, cursor_4c_LocalEmp, cursor_4c_LocalMvCab,
    *         cursor_4c_LocalMvItn, cursor_4c_LocalMvIts, cursor_4c_LocalSubMv,
    *         cursor_4c_LocalNFis, cursor_4c_LocalPar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_lcEdn, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_lcEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

                *-- SigCdPam - Parametros gerais
                loc_cSQL = "SELECT CGruEstPs FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalParam")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalParam)"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalParam
                GO TOP
                IF EOF("cursor_4c_LocalParam")
                    THIS.this_cMensagemErro = "Sem dados em SigCdPam"
                    EXIT
                ENDIF

                *-- SigCdEmp - Dados da empresa
                loc_cSQL = "SELECT RazSocs, Razas, Endes, Numeros, Bairs, " + ;
                           "       Cidas, Estas, Ceps, Paises " + ;
                           "FROM SigCdEmp " + ;
                           "WHERE Cemps = '" + PADR(THIS.this_cEmps, 3) + "'"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalEmp)"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalEmp
                GO TOP
                IF EOF("cursor_4c_LocalEmp")
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada"
                    EXIT
                ENDIF

                *-- SigMvCab - Cabecalho do movimento
                loc_cSQL = "SELECT Numes, Datas, ContaOs, ContaDs, Notas, " + ;
                           "       Valos, ObsEs, DtEmis " + ;
                           "FROM SigMvCab " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalMvCab)"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalMvCab
                GO TOP
                IF EOF("cursor_4c_LocalMvCab")
                    THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado"
                    EXIT
                ENDIF

                *-- SigMvItn - Itens do movimento
                loc_cSQL = "SELECT a.CItens, a.CodBarras, a.CPros, a.DPros, " + ;
                           "       a.Units, a.Pesos, a.Qtds, a.Totas " + ;
                           "FROM SigMvItn a " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                           "ORDER BY a.CItens, a.CPros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMvItn")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalMvItn)"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalMvItn
                GO TOP
                IF EOF("cursor_4c_LocalMvItn")
                    THIS.this_cMensagemErro = "Sem itens no movimento"
                    EXIT
                ENDIF

                *-- SigMvIts - Itens de tamanhos e cores
                loc_cSQL = "SELECT a.CItens, a.CPros, a.CodBarras, " + ;
                           "       a.Qtds, a.CodCors, a.CodTams " + ;
                           "FROM SigMvIts a " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                           "ORDER BY a.CItens, a.CPros"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMvIts")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalMvIts)"
                    EXIT
                ENDIF

                *-- SigSubMv - Sub-movimentos com composicao
                loc_cSQL = "SELECT a.CItens, a.CPros, a.Mats, a.Pesos, " + ;
                           "       a.Qtds, p.Varias, b.NTipoJoals " + ;
                           "FROM SigSubMv a, SigCdPro p, SigCdGrp b " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                           "  AND a.Mats = p.CPros " + ;
                           "  AND p.CGrus = b.CGrus " + ;
                           "ORDER BY a.CItens, a.CPros, a.Mats"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalSubMv")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o (LocalSubMv)"
                    EXIT
                ENDIF

                *-- SigMvNfi - Nota Fiscal
                loc_cSQL = "SELECT Emis, Qtdes, PLiqs, PBrus, CodTrans, " + ;
                           "       Numeros, Espes, VlFretes, VlSeguros, DespAces " + ;
                           "FROM SigMvNfi " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNFis")
                IF !USED("cursor_4c_LocalNFis")
                    THIS.this_cMensagemErro = "NF n" + CHR(227) + "o encontrada"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalNFis
                GO TOP

                *-- SigMvPar + SigOpFp - Condicoes de pagamento
                loc_cSQL = "SELECT a.Fpags, a.MoeFpgs, a.Valos, b.Descrs, b.Trocos " + ;
                           "FROM SigMvPar a, SigOpFp b " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_lcEdn) + " " + ;
                           "  AND a.Fpags = b.Fpags"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPar1")
                IF !USED("cursor_4c_LocalPar1")
                    THIS.this_cMensagemErro = "Formas de pagamento n" + CHR(227) + "o encontradas"
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalPar1
                GO TOP

                SELECT SUM(1) AS Total, FPags, MoeFpgs, Valos, Descrs, Trocos ;
                  FROM cursor_4c_LocalPar1 ;
                 GROUP BY FPags, MoeFpgs, Valos, Descrs, Trocos ;
                  INTO CURSOR cursor_4c_LocalPar READWRITE

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SelecionarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra selecao e montagem do cursor crInvoices
    * Equivalente ao processamento original
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lcEdn, loc_cSQL, loc_nResult, loc_lcQtd
        LOCAL loc_lnMax, loc_lcTit, loc_lcLis, loc_lcEmail
        LOCAL loc_lcCtO, loc_lcEdO, loc_lcTxO, loc_lcCtD, loc_lcEdD
        LOCAL loc_lcCtE, loc_lcEdE, loc_lcTrp, loc_lcDtE, loc_lcPai
        LOCAL loc_lcVol, loc_lcEsp, loc_lcQtt, loc_lcPeB, loc_lcPeL
        LOCAL loc_lcFrete, loc_lcSeguro, loc_lcDgb, loc_lcPag, loc_lcPct
        LOCAL loc_lnPgn, loc_lnItn, loc_lnVal, loc_lnHnd, loc_lnCtt, loc_lnCtt2
        LOCAL loc_lnPtt, loc_lcBrc, loc_lcArq, loc_lcFoto
        LOCAL loc_lcCor, loc_lcTam, loc_lcCla, loc_lcDps, loc_lcDgs, loc_lcDcr
        LOCAL loc_lcCdE, loc_ldDat, loc_lcTxI, loc_lcOCb, loc_lcVlT
        LOCAL loc_lnQtdsItens, loc_ldDtE

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                SET POINT TO ","
                SET SEPARATOR TO "."

                loc_lcEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

                *-- SigCdDic - Dicionario de traducoes para ingles
                loc_cSQL = "SELECT Expressao, Traducao " + ;
                           "FROM SigCdDic " + ;
                           "WHERE Idioma = 'INGLES    ' " + ;
                           "ORDER BY LEN(Expressao) DESC, Expressao"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_crSigCdDic")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigCdDic)")
                    EXIT
                ENDIF

                *-- SigOpCdd - Configuracao de casas decimais
                loc_cSQL = "SELECT CasQtds " + ;
                           "FROM SigOpCdd " + ;
                           "WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "' " + ;
                           "ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalOpe)")
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalOpe
                GO TOP

                *-- SigOpCdi - Configuracao de invoice da operacao
                loc_cSQL = "SELECT * " + ;
                           "FROM SigOpCdi " + ;
                           "WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "' " + ;
                           "ORDER BY Dopes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalIvOpe")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalIvOpe)")
                    EXIT
                ENDIF
                SELECT cursor_4c_LocalIvOpe
                GO TOP
                IF EOF("cursor_4c_LocalIvOpe")
                    MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                             "o Possui Invoices Configuradas Para Impress" + CHR(227) + "o!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o!!!")
                    EXIT
                ENDIF
                IF cursor_4c_LocalIvOpe.chkInvs <> 1
                    MsgAviso("Esta Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                             "o Foi Configurada Para Imprimir Invoices!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o!!!")
                    EXIT
                ENDIF

                *-- Define tipo dinamico para campo Qtds
                SELECT cursor_4c_LocalOpe
                IF cursor_4c_LocalOpe.CasQtds < 1
                    loc_lcQtd = "n(12)"
                ELSE
                    loc_lcQtd = "n(12," + ALLTRIM(STR(cursor_4c_LocalOpe.CasQtds, 10)) + ")"
                ENDIF

                *-- Cria cursor principal crInvoices
                IF USED("crInvoices")
                    USE IN crInvoices
                ENDIF

                CREATE CURSOR crInvoices (Dopes c(20), chkTits n(1), lblTits c(30), ;
                    chkLists n(1), lblLists c(30), chkOrigs n(1), lblOrigs c(30), ;
                    chkEndOs n(1), lblEndOs c(30), chkDests n(1), lblDests c(30), ;
                    chkEndDs n(1), lblEndDs c(30), chkEmps n(1), lblEmps c(30), ;
                    chkEndEs n(1), lblEndEs c(30), chkTrans n(1), lblTrans c(30), ;
                    chkEmis n(1), lblEmis c(30), optEmis n(1), chkPais n(1), ;
                    lblPais c(30), chkVols n(1), lblVols c(30), lblVolCs c(30), ;
                    chkEsps n(1), lblEsps c(30), lblEspCs c(30), chkQtds n(1), ;
                    lblQtds c(30), lblQtdCs c(30), chkPesoBs n(1), lblPesoBs c(30), ;
                    chkPesoLs n(1), lblPesoLs c(30), chkTots n(1), lblTots c(30), ;
                    chkItens n(1), SubGBris c(6), chkPags n(1), lblPags c(30), ;
                    chkRods n(1), lblRods c(30), ObsRods M(4), ;
                    DSubGBris c(10), CItens n(10), CPros c(14), CodTams c(4), ;
                    FigJpgs m(4), DCors c(20), DGrus c(20), CClass c(3), DPros m(4), ;
                    Metals n(11,3), PTots n(11,3), QtdBs n(11,3), PesoBs n(11,3), ;
                    Mat1s c(14), Qtd1s n(11,3), Peso1s n(11,3), Qtds &loc_lcQtd., ;
                    Units n(12,2), Totas n(12,2), Pagina n(4), TotPag n(4), ;
                    DadTits c(100), DadLists c(100), DadOrigs c(100), DadEndOs c(200), ;
                    DadDests c(100), DadEndDs c(200), DadEmps c(100), DadEndEs c(200), ;
                    DadTrans c(100), DadEmis c(100), DadPais c(100), DadVols c(100), ;
                    DadEsps c(100), DadQtds c(100), DadPesoBs c(100), DadPesoLs c(100), ;
                    DadTots c(100), DadPags M(4), ImpRodape l, ChkTxIds n(1), ;
                    lblTxIds c(30), lblTxIdCs m(4), lblTxIdOs m(4), chkDescLng n(1), ;
                    ObsCab M, DadHands n(12,2), lblFrete c(30), chkFrete n(1), ;
                    lblSeguro c(30), chkSeguro n(1), DadFrete c(100), DadSeguro c(100))

                *-- Busca dados das tabelas de origem
                IF !THIS.SelecionarDados()
                    EXIT
                ENDIF

                SELECT cursor_4c_LocalIvOpe
                loc_lnMax = IIF(cursor_4c_LocalIvOpe.MaxItens > 0, cursor_4c_LocalIvOpe.MaxItens, 9999)

                *-- Titulo do relatorio
                loc_lcTit = ""
                SELECT cursor_4c_LocalMvCab
                IF cursor_4c_LocalIvOpe.chkCabs = 1
                    loc_lcTit = ALLTRIM(cursor_4c_LocalIvOpe.lblTits) + " n" + CHR(186) + " " + ;
                                ALLTRIM(cursor_4c_LocalMvCab.Notas)
                ENDIF
                loc_lcOCb = NVL(cursor_4c_LocalMvCab.ObsEs, "")

                *-- Titulo da listagem
                loc_lcLis = ""
                IF cursor_4c_LocalIvOpe.chkLists = 1
                    loc_lcLis = ALLTRIM(cursor_4c_LocalIvOpe.lblLists) + " " + ;
                                ALLTRIM(cursor_4c_LocalMvCab.Notas) + "/" + ;
                                SUBSTR(DTOS(cursor_4c_LocalMvCab.Datas), 3, 2)
                ENDIF

                *-- Email dos clientes de origem e destino
                loc_lcEmail = ""
                IF !EMPTY(cursor_4c_LocalMvCab.ContaOs)
                    loc_cSQL = "SELECT Emails FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(cursor_4c_LocalMvCab.ContaOs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli") > 0
                        SELECT cursor_4c_TmpCli
                        IF !EMPTY(cursor_4c_TmpCli.Emails)
                            loc_lcEmail = ALLTRIM(cursor_4c_TmpCli.Emails) + ";"
                        ENDIF
                        USE IN cursor_4c_TmpCli
                    ENDIF
                ENDIF
                SELECT cursor_4c_LocalMvCab
                IF !EMPTY(cursor_4c_LocalMvCab.ContaDs)
                    loc_cSQL = "SELECT Emails FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(cursor_4c_LocalMvCab.ContaDs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli") > 0
                        SELECT cursor_4c_TmpCli
                        IF !EMPTY(cursor_4c_TmpCli.Emails)
                            loc_lcEmail = loc_lcEmail + ALLTRIM(cursor_4c_TmpCli.Emails)
                        ENDIF
                        USE IN cursor_4c_TmpCli
                    ENDIF
                ENDIF
                THIS.this_cContaEmail = loc_lcEmail

                *-- Descricao e endereco da conta de origem
                loc_lcCtO = ""
                loc_lcEdO = ""
                loc_lcTxO = ""
                SELECT cursor_4c_LocalMvCab
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND !EMPTY(cursor_4c_LocalMvCab.ContaOs) AND ;
                   (cursor_4c_LocalIvOpe.chkOrigs = 1 OR cursor_4c_LocalIvOpe.chkEndOs = 1)
                    loc_cSQL = "SELECT Razaos, RClis, Endes, Nums, Compls, " + ;
                               "       Ceps, Cidas, Bairs, Estas, Paises, Obs " + ;
                               "FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(cursor_4c_LocalMvCab.ContaOs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli") > 0
                        SELECT cursor_4c_LocalCli
                        IF cursor_4c_LocalIvOpe.ChkTxIds = 1
                            loc_lcTxO = NVL(cursor_4c_LocalCli.Obs, "")
                        ENDIF
                        loc_lcCtO = ALLTRIM(IIF(EMPTY(cursor_4c_LocalCli.Razaos), ;
                                    cursor_4c_LocalCli.RClis, cursor_4c_LocalCli.Razaos))
                        loc_lcEdO = ALLTRIM(cursor_4c_LocalCli.Endes) + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Nums)),   "", ", "     + ALLTRIM(cursor_4c_LocalCli.Nums))   + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Compls)), "", " - "    + ALLTRIM(cursor_4c_LocalCli.Compls)) + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Bairs)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Bairs))  + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Cidas)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Cidas))  + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Estas)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Estas))  + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Paises)), "", " - "    + ALLTRIM(cursor_4c_LocalCli.Paises)) + ;
                                    IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Ceps)),   "", " - CEP: " + ALLTRIM(cursor_4c_LocalCli.Ceps))
                        USE IN cursor_4c_LocalCli
                    ENDIF
                ENDIF

                *-- Descricao e endereco da conta de destino
                loc_lcCtD = ""
                loc_lcEdD = ""
                loc_lcTxI = NVL(cursor_4c_LocalIvOpe.lblTxIds, "")
                SELECT cursor_4c_LocalMvCab
                IF !EMPTY(cursor_4c_LocalMvCab.ContaDs)
                    loc_cSQL = "SELECT Razaos, RClis, Endes, Nums, Compls, " + ;
                               "       Ceps, Cidas, Bairs, Estas, Paises, Obs " + ;
                               "FROM SigCdCli " + ;
                               "WHERE IClis = '" + ALLTRIM(cursor_4c_LocalMvCab.ContaDs) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli") > 0
                        SELECT cursor_4c_LocalCli
                        IF cursor_4c_LocalIvOpe.ChkTxIds = 1
                            loc_lcTxI = NVL(cursor_4c_LocalCli.Obs, "")
                        ENDIF
                        IF cursor_4c_LocalIvOpe.chkCabs = 1 AND ;
                           (cursor_4c_LocalIvOpe.chkDests = 1 OR cursor_4c_LocalIvOpe.chkEndDs = 1)
                            loc_lcCtD = ALLTRIM(IIF(EMPTY(cursor_4c_LocalCli.Razaos), ;
                                        cursor_4c_LocalCli.RClis, cursor_4c_LocalCli.Razaos))
                            loc_lcEdD = ALLTRIM(cursor_4c_LocalCli.Endes) + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Nums)),   "", ", "     + ALLTRIM(cursor_4c_LocalCli.Nums))   + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Compls)), "", " - "    + ALLTRIM(cursor_4c_LocalCli.Compls)) + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Bairs)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Bairs))  + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Cidas)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Cidas))  + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Estas)),  "", " - "    + ALLTRIM(cursor_4c_LocalCli.Estas))  + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Paises)), "", " - "    + ALLTRIM(cursor_4c_LocalCli.Paises)) + ;
                                        IIF(EMPTY(ALLTRIM(cursor_4c_LocalCli.Ceps)),   "", " - CEP: " + ALLTRIM(cursor_4c_LocalCli.Ceps))
                        ENDIF
                        USE IN cursor_4c_LocalCli
                    ENDIF
                ENDIF

                *-- Descricao e endereco da empresa
                loc_lcCtE = ""
                loc_lcEdE = ""
                SELECT cursor_4c_LocalEmp
                IF cursor_4c_LocalIvOpe.chkCabs = 1
                    loc_lcCtE = IIF(EMPTY(cursor_4c_LocalEmp.RazSocs), ;
                                    cursor_4c_LocalEmp.Razas, cursor_4c_LocalEmp.RazSocs)
                    loc_lcEdE = ALLTRIM(cursor_4c_LocalEmp.Endes) + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Numeros)), "", ", "      + ALLTRIM(cursor_4c_LocalEmp.Numeros)) + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Bairs)),   "", " - "     + ALLTRIM(cursor_4c_LocalEmp.Bairs))  + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Cidas)),   "", " - "     + ALLTRIM(cursor_4c_LocalEmp.Cidas))  + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Estas)),   "", " - "     + ALLTRIM(cursor_4c_LocalEmp.Estas))  + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Paises)),  "", " - "     + ALLTRIM(cursor_4c_LocalEmp.Paises)) + ;
                                IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Ceps)),    "", " - CEP : " + ALLTRIM(cursor_4c_LocalEmp.Ceps))
                ENDIF

                *-- Transportadora
                loc_lcTrp = ""
                SELECT cursor_4c_LocalNFis
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND !EMPTY(cursor_4c_LocalNFis.CodTrans) AND ;
                   cursor_4c_LocalIvOpe.chkTrans = 1
                    loc_cSQL = "SELECT Razaos FROM SigPrTrp " + ;
                               "WHERE Itras = '" + ALLTRIM(cursor_4c_LocalNFis.CodTrans) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalTra") > 0
                        SELECT cursor_4c_LocalTra
                        loc_lcTrp = ALLTRIM(cursor_4c_LocalTra.Razaos)
                        USE IN cursor_4c_LocalTra
                    ENDIF
                ENDIF

                *-- Data de embarque
                loc_lcDtE = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkEmis = 1
                    SELECT cursor_4c_LocalEmp
                    loc_lcCdE = IIF(EMPTY(ALLTRIM(cursor_4c_LocalEmp.Cidas)), "", ;
                                    ALLTRIM(cursor_4c_LocalEmp.Cidas) + ", ")
                    SELECT cursor_4c_LocalMvCab
                    loc_ldDat = IIF(EMPTY(cursor_4c_LocalMvCab.DtEmis), ;
                                    IIF(EMPTY(cursor_4c_LocalMvCab.Datas), DATETIME(), cursor_4c_LocalMvCab.Datas), ;
                                    cursor_4c_LocalMvCab.DtEmis)
                    SELECT cursor_4c_LocalIvOpe
                    DO CASE
                        CASE cursor_4c_LocalIvOpe.optEmis = 2
                            loc_lcDtE = DTOC(TTOD(NVL(loc_ldDat, DATETIME())))
                            loc_lcDtE = loc_lcCdE + SUBSTR(loc_lcDtE, 7, 4) + "/" + ;
                                        SUBSTR(loc_lcDtE, 4, 2) + "/" + SUBSTR(loc_lcDtE, 1, 2)
                        CASE cursor_4c_LocalIvOpe.optEmis = 3
                            loc_ldDtE = TTOD(NVL(loc_ldDat, DATETIME()))
                            IF !EMPTY(loc_ldDtE)
                                loc_lcDtE = loc_lcCdE + CMONTH(loc_ldDtE) + " " + ;
                                            ALLTRIM(STR(DAY(loc_ldDtE), 20, 0)) + ", " + ;
                                            ALLTRIM(STR(YEAR(loc_ldDtE), 20, 0))
                            ENDIF
                        CASE cursor_4c_LocalIvOpe.optEmis = 4
                            loc_lcDtE = loc_lcCdE + fMontaDtChq(TTOD(NVL(loc_ldDat, DATETIME())))
                        OTHERWISE
                            loc_lcDtE = loc_lcCdE + DTOC(TTOD(NVL(loc_ldDat, DATETIME())))
                    ENDCASE
                ENDIF

                *-- Pais
                loc_lcPai = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkPais = 1
                    loc_lcPai = "Brazil"
                ENDIF

                *-- Numero de volumes
                loc_lcVol = ""
                SELECT cursor_4c_LocalNFis
                IF cursor_4c_LocalIvOpe.chkCabs = 1
                    IF cursor_4c_LocalIvOpe.chkVols = 1
                        loc_lcVol = ALLTRIM(STR(IIF(EMPTY(cursor_4c_LocalNFis.Qtdes), 1, ;
                                    cursor_4c_LocalNFis.Qtdes), 6)) + " "
                    ENDIF
                    IF !EMPTY(cursor_4c_LocalNFis.Numeros)
                        loc_lcVol = loc_lcVol + ALLTRIM(cursor_4c_LocalNFis.Numeros)
                    ELSE
                        loc_lcVol = loc_lcVol + ALLTRIM(cursor_4c_LocalIvOpe.lblVolCs)
                    ENDIF
                ENDIF

                *-- Especificacoes
                loc_lcEsp = ""
                SELECT cursor_4c_LocalNFis
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkEsps = 1
                    loc_lcEsp = ALLTRIM(cursor_4c_LocalNFis.Espes)
                ENDIF

                *-- Quantidade total
                loc_lcQtt = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkQtds = 1
                    SELECT " " AS Agrupar, SUM(Qtds) AS Qtds ;
                      FROM cursor_4c_LocalMvItn ;
                      INTO CURSOR cursor_4c_crQtds ;
                     GROUP BY 1
                    SELECT cursor_4c_crQtds
                    GO TOP
                    IF !EOF("cursor_4c_crQtds")
                        IF INT(cursor_4c_crQtds.Qtds) - cursor_4c_crQtds.Qtds <> 0
                            loc_lcQtt = TRANSFORM(cursor_4c_crQtds.Qtds, "@R 99,999.99") + " "
                        ELSE
                            loc_lcQtt = ALLTRIM(STR(cursor_4c_crQtds.Qtds, 10)) + " "
                        ENDIF
                    ELSE
                        loc_lcQtt = "1 "
                    ENDIF
                    USE IN cursor_4c_crQtds
                    loc_lcQtt = loc_lcQtt + ALLTRIM(cursor_4c_LocalIvOpe.lblQtdCs)
                ENDIF

                *-- Peso bruto
                loc_lcPeB = ""
                SELECT cursor_4c_LocalNFis
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkPesoBs = 1 AND ;
                   cursor_4c_LocalNFis.PBrus > 0
                    loc_lcPeB = TRANSFORM(TRANSFORM(cursor_4c_LocalNFis.PBrus * 100, ;
                                "@l 9999999"), "@R 99,999.99") + "Kg"
                ENDIF

                *-- Peso liquido
                loc_lcPeL = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkPesoLs = 1 AND ;
                   cursor_4c_LocalNFis.PLiqs > 0
                    loc_lcPeL = TRANSFORM(TRANSFORM(cursor_4c_LocalNFis.PLiqs * 100, ;
                                "@l 9999999"), "@R 99,999.99") + "Kg"
                ENDIF

                *-- Frete
                loc_lcFrete = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkFrete = 1 AND ;
                   cursor_4c_LocalNFis.VlFretes > 0
                    loc_lcFrete = ALLTRIM(TRANSFORM(cursor_4c_LocalNFis.VlFretes, "@999,999,999.99"))
                ENDIF

                *-- Seguro
                loc_lcSeguro = ""
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkSeguro = 1 AND ;
                   cursor_4c_LocalNFis.VlSeguros > 0
                    loc_lcSeguro = ALLTRIM(TRANSFORM(cursor_4c_LocalNFis.VlSeguros, "@999,999,999.99"))
                ENDIF

                *-- Descritivo do grupo de brilhantes
                loc_lcDgb = ""
                SELECT cursor_4c_LocalIvOpe
                IF !EMPTY(cursor_4c_LocalIvOpe.lblEspCs)
                    loc_lcDgb = ALLTRIM(cursor_4c_LocalIvOpe.lblEspCs)
                ENDIF

                *-- Total de valor dos itens
                SELECT " " AS Agrupar, SUM(Totas) AS Totas ;
                  FROM cursor_4c_LocalMvItn ;
                  INTO CURSOR cursor_4c_LocalTPar2 ;
                 GROUP BY 1
                SELECT cursor_4c_LocalTPar2
                GO TOP
                loc_lnCtt2 = cursor_4c_LocalTPar2.Totas
                USE IN cursor_4c_LocalTPar2

                *-- Total das condicoes de pagamento
                SELECT " " AS Agrupar, SUM(Valos * IIF(Trocos = 1, -1, 1)) AS Valos ;
                  FROM cursor_4c_LocalPar ;
                  INTO CURSOR cursor_4c_LocalTPar ;
                 GROUP BY 1
                SELECT cursor_4c_LocalTPar
                GO TOP
                loc_lnCtt = cursor_4c_LocalTPar.Valos
                USE IN cursor_4c_LocalTPar

                *-- Texto das condicoes de pagamento
                loc_lcPag = ""
                SELECT cursor_4c_LocalPar
                SCAN
                    loc_lcPct = PADL(ALLTRIM(STR((cursor_4c_LocalPar.Valos / loc_lnCtt2) * 100, 8, 2)), 8)
                    loc_lcPag = loc_lcPag + PADR(ALLTRIM(cursor_4c_LocalPar.Descrs), 25) + ;
                                " (" + loc_lcPct + "%) " + ;
                                PADL(ALLTRIM(STR(cursor_4c_LocalPar.Valos, 16, 2)), 18) + CHR(13)
                ENDSCAN
                IF !EMPTY(loc_lcPag)
                    loc_lcPag = loc_lcPag + SPACE(42) + REPLICATE("_", 14) + CHR(13)
                    loc_lcPag = loc_lcPag + PADR("Total", 15) + SPACE(11) + ;
                                PADL(ALLTRIM(STR(loc_lnCtt, 16, 2)), 30)
                ENDIF

                *-- Imagem em branco para produtos sem foto
                loc_lcBrc = gc_4c_CaminhoIcones + "BrJpg.JPG"
                IF USED("cursor_4c_crBranco")
                    USE IN cursor_4c_crBranco
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_crBranco (Branco m)
                SET NULL OFF
                SELECT cursor_4c_crBranco
                APPEND BLANK
                IF FILE(loc_lcBrc)
                    APPEND MEMO Branco FROM (loc_lcBrc) OVERWRITE
                ENDIF

                *-- Loop de insercao de produtos no crInvoices
                loc_lnPgn = 1
                loc_lnItn = 1
                loc_lnVal = 0

                SELECT cursor_4c_LocalMvItn
                GO TOP
                SCAN
                    loc_lnItn = cursor_4c_LocalMvItn.CItens

                    *-- Dados do produto
                    loc_cSQL = "SELECT DPros, DescFis, DscCompras, CGrus, " + ;
                               "       CClass, FigJpgs, CodCors, CodTams " + ;
                               "FROM SigCdPro " + ;
                               "WHERE CPros = '" + PADR(cursor_4c_LocalMvItn.CPros, 14) + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") < 1
                        MsgErro("Falha ao buscar produto: " + ALLTRIM(cursor_4c_LocalMvItn.CPros), "Erro")
                        *-- Continua para proximo item sem interromper o loop
                    ELSE
                        SELECT cursor_4c_LocalPro
                        loc_lcCor = cursor_4c_LocalPro.CodCors
                        loc_lcTam = cursor_4c_LocalPro.CodTams

                        *-- Itens de cor e tamanho para este item
                        IF USED("cursor_4c_crItens")
                            USE IN cursor_4c_crItens
                        ENDIF
                        SELECT Qtds, CodCors, CodTams ;
                          FROM cursor_4c_LocalMvIts ;
                         WHERE CItens = loc_lnItn ;
                          INTO CURSOR cursor_4c_crItens READWRITE
                        SELECT cursor_4c_crItens
                        GO TOP
                        IF EOF("cursor_4c_crItens")
                            USE IN cursor_4c_crItens
                            SELECT Qtds, SPACE(4) AS CodCors, SPACE(4) AS CodTams ;
                              FROM cursor_4c_LocalMvItn ;
                             WHERE CItens = loc_lnItn ;
                              INTO CURSOR cursor_4c_crItens READWRITE
                            SELECT cursor_4c_crItens
                            GO TOP
                        ENDIF

                        SELECT cursor_4c_crItens
                        SCAN
                            loc_lcCor = IIF(EMPTY(cursor_4c_crItens.CodCors), loc_lcCor, cursor_4c_crItens.CodCors)
                            loc_lcTam = IIF(EMPTY(cursor_4c_crItens.CodTams), loc_lcTam, cursor_4c_crItens.CodTams)
                            loc_lnQtdsItens = cursor_4c_crItens.Qtds

                            SELECT cursor_4c_LocalPro
                            loc_lcCla = cursor_4c_LocalPro.CClass
                            loc_lcDps = ALLTRIM(NVL(cursor_4c_LocalPro.DscCompras, NVL(cursor_4c_LocalPro.DescFis, "")))
                            loc_lcDps = ALLTRIM(IIF(EMPTY(loc_lcDps), cursor_4c_LocalPro.DPros, loc_lcDps))
                            loc_lcDgs = ""

                            *-- Traducao para ingles (chkDescLng)
                            SELECT cursor_4c_LocalIvOpe
                            IF cursor_4c_LocalIvOpe.chkDescLng = 1
                                IF !EMPTY(cursor_4c_LocalPro.CGrus)
                                    loc_cSQL = "SELECT DGrus FROM SigCdGrp " + ;
                                               "WHERE CGrus = '" + ALLTRIM(cursor_4c_LocalPro.CGrus) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru") > 0
                                        SELECT cursor_4c_LocalGru
                                        loc_lcDgs = ALLTRIM(cursor_4c_LocalGru.DGrus)
                                        USE IN cursor_4c_LocalGru
                                    ENDIF
                                ENDIF
                                IF !EMPTY(loc_lcDgs)
                                    SELECT cursor_4c_crSigCdDic
                                    SCAN
                                        loc_lcDgs = STRTRAN(loc_lcDgs, ;
                                                    ALLTRIM(cursor_4c_crSigCdDic.Expressao), ;
                                                    ALLTRIM(cursor_4c_crSigCdDic.Traducao))
                                        loc_lcDps = STRTRAN(loc_lcDps, ;
                                                    ALLTRIM(cursor_4c_crSigCdDic.Expressao), ;
                                                    ALLTRIM(cursor_4c_crSigCdDic.Traducao))
                                    ENDSCAN
                                ENDIF
                            ENDIF

                            *-- Descricao da cor
                            loc_lcDcr = ""
                            loc_cSQL = "SELECT Descs FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_lcCor)
                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCor") > 0
                                SELECT cursor_4c_LocalCor
                                loc_lcDcr = ALLTRIM(cursor_4c_LocalCor.Descs)
                                USE IN cursor_4c_LocalCor
                            ENDIF
                            SELECT cursor_4c_LocalIvOpe
                            IF cursor_4c_LocalIvOpe.chkDescLng = 1 AND !EMPTY(loc_lcDcr)
                                SELECT cursor_4c_crSigCdDic
                                SCAN
                                    loc_lcDcr = STRTRAN(loc_lcDcr, ;
                                                ALLTRIM(cursor_4c_crSigCdDic.Expressao), ;
                                                ALLTRIM(cursor_4c_crSigCdDic.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Insere registro no crInvoices
                            SELECT cursor_4c_LocalIvOpe
                            INSERT INTO crInvoices (Dopes, chkTits, lblTits, ;
                                    chkLists, lblLists, chkOrigs, lblOrigs, ;
                                    chkEndOs, lblEndOs, chkDests, lblDests, ;
                                    chkEndDs, lblEndDs, chkEmps, lblEmps, ;
                                    chkEndEs, lblEndEs, chkTrans, lblTrans, ;
                                    chkEmis, lblEmis, optEmis, chkPais, lblPais, ;
                                    chkVols, lblVols, lblVolCs, chkEsps, lblEsps, ;
                                    lblEspCs, chkQtds, lblQtds, lblQtdCs, ;
                                    chkPesoBs, lblPesoBs, chkPesoLs, lblPesoLs, ;
                                    chkTots, lblTots, chkItens, SubGBris, ;
                                    chkPags, lblPags, chkRods, lblRods, ObsRods, ;
                                    chkDescLng, ChkTxIds, lblTxIds, lblTxIdCs, lblTxIdOs, ;
                                    CPros, PTots, Qtds, Units, Totas, ;
                                    DadTits, DadLists, DadOrigs, DadEndOs, ;
                                    DadDests, DadEndDs, DadEmps, DadEndEs, ;
                                    DadTrans, DadEmis, DadPais, DadVols, ;
                                    DadEsps, DadQtds, DadPesoBs, DadPesoLs, ;
                                    DadPags, Pagina, ObsCab, CItens, DSubGBris, ;
                                    DPros, DGrus, CClass, CodTams, DCors, FigJpgs, ;
                                    lblFrete, chkFrete, lblSeguro, chkSeguro, ;
                                    DadFrete, DadSeguro) ;
                            VALUES (cursor_4c_LocalIvOpe.Dopes, cursor_4c_LocalIvOpe.chkTits, ;
                                    cursor_4c_LocalIvOpe.lblTits, cursor_4c_LocalIvOpe.chkLists, ;
                                    cursor_4c_LocalIvOpe.lblLists, cursor_4c_LocalIvOpe.chkOrigs, ;
                                    cursor_4c_LocalIvOpe.lblOrigs, cursor_4c_LocalIvOpe.chkEndOs, ;
                                    cursor_4c_LocalIvOpe.lblEndOs, cursor_4c_LocalIvOpe.chkDests, ;
                                    cursor_4c_LocalIvOpe.lblDests, cursor_4c_LocalIvOpe.chkEndDs, ;
                                    cursor_4c_LocalIvOpe.lblEndDs, cursor_4c_LocalIvOpe.chkEmps, ;
                                    cursor_4c_LocalIvOpe.lblEmps, cursor_4c_LocalIvOpe.chkEndEs, ;
                                    cursor_4c_LocalIvOpe.lblEndEs, cursor_4c_LocalIvOpe.chkTrans, ;
                                    cursor_4c_LocalIvOpe.lblTrans, cursor_4c_LocalIvOpe.chkEmis, ;
                                    cursor_4c_LocalIvOpe.lblEmis, cursor_4c_LocalIvOpe.optEmis, ;
                                    cursor_4c_LocalIvOpe.chkPais, cursor_4c_LocalIvOpe.lblPais, ;
                                    cursor_4c_LocalIvOpe.chkVols, cursor_4c_LocalIvOpe.lblVols, ;
                                    cursor_4c_LocalIvOpe.lblVolCs, cursor_4c_LocalIvOpe.chkEsps, ;
                                    cursor_4c_LocalIvOpe.lblEsps, cursor_4c_LocalIvOpe.lblEspCs, ;
                                    cursor_4c_LocalIvOpe.chkQtds, cursor_4c_LocalIvOpe.lblQtds, ;
                                    cursor_4c_LocalIvOpe.lblQtdCs, cursor_4c_LocalIvOpe.chkPesoBs, ;
                                    cursor_4c_LocalIvOpe.lblPesoBs, cursor_4c_LocalIvOpe.chkPesoLs, ;
                                    cursor_4c_LocalIvOpe.lblPesoLs, cursor_4c_LocalIvOpe.chkTots, ;
                                    cursor_4c_LocalIvOpe.lblTots, cursor_4c_LocalIvOpe.chkItens, ;
                                    cursor_4c_LocalIvOpe.SubGBris, cursor_4c_LocalIvOpe.chkPags, ;
                                    cursor_4c_LocalIvOpe.lblPags, cursor_4c_LocalIvOpe.chkRods, ;
                                    cursor_4c_LocalIvOpe.lblRods, NVL(cursor_4c_LocalIvOpe.ObsRods, ""), ;
                                    cursor_4c_LocalIvOpe.chkDescLng, cursor_4c_LocalIvOpe.ChkTxIds, ;
                                    cursor_4c_LocalIvOpe.lblTxIds, loc_lcTxI, loc_lcTxO, ;
                                    cursor_4c_LocalMvItn.CPros, cursor_4c_LocalMvItn.Pesos, ;
                                    loc_lnQtdsItens, cursor_4c_LocalMvItn.Units, ;
                                    cursor_4c_LocalMvItn.Units * loc_lnQtdsItens, ;
                                    loc_lcTit, loc_lcLis, loc_lcCtO, loc_lcEdO, ;
                                    loc_lcCtD, loc_lcEdD, loc_lcCtE, loc_lcEdE, ;
                                    loc_lcTrp, loc_lcDtE, loc_lcPai, loc_lcVol, ;
                                    loc_lcEsp, loc_lcQtt, loc_lcPeB, loc_lcPeL, ;
                                    loc_lcPag, loc_lnPgn, loc_lcOCb, ;
                                    cursor_4c_LocalMvItn.CItens, loc_lcDgb, ;
                                    loc_lcDps, loc_lcDgs, loc_lcCla, loc_lcTam, ;
                                    loc_lcDcr, NVL(cursor_4c_LocalPro.FigJpgs, ""), ;
                                    cursor_4c_LocalIvOpe.lblFrete, cursor_4c_LocalIvOpe.chkFrete, ;
                                    cursor_4c_LocalIvOpe.lblSeguro, cursor_4c_LocalIvOpe.chkSeguro, ;
                                    loc_lcFrete, loc_lcSeguro)

                            *-- Extrai imagem do produto para arquivo jpg temporario
                            loc_lcArq = SYS(2023) + "\SigReIiv_" + ;
                                        ALLTRIM(cursor_4c_LocalMvItn.CPros) + ".jpg"
                            CLEAR RESOURCES
                            SELECT crInvoices
                            GO BOTTOM
                            IF !EMPTY(crInvoices.FigJpgs) AND !ISNULL(crInvoices.FigJpgs) AND ;
                               LEN(ALLTRIM(crInvoices.FigJpgs)) > 10
                                loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                             crInvoices.FigJpgs, ;
                                             "data:image/png;base64,", ""), ;
                                             "data:image/jpeg;base64,", ""), ;
                                             "data:image/jpg;base64,", ""), 14)
                                STRTOFILE(loc_lcFoto, loc_lcArq)
                            ELSE
                                COPY MEMO cursor_4c_crBranco.Branco TO (loc_lcArq)
                            ENDIF

                            *-- Composicao do produto
                            IF USED("cursor_4c_LocalCompo")
                                USE IN cursor_4c_LocalCompo
                            ENDIF

                            SELECT cursor_4c_LocalSubMv
                            GO TOP
                            LOCATE FOR cursor_4c_LocalSubMv.CItens = cursor_4c_LocalMvItn.CItens
                            IF !EOF("cursor_4c_LocalSubMv")
                                SELECT Mats, Qtds, Pesos AS PCompos, Varias, NTipoJoals, 0 AS Fators ;
                                  FROM cursor_4c_LocalSubMv ;
                                 WHERE CItens = cursor_4c_LocalMvItn.CItens ;
                                 ORDER BY Mats ;
                                  INTO CURSOR cursor_4c_LocalCompo READWRITE
                            ELSE
                                loc_cSQL = "SELECT a.Mats, a.Qtds, a.Pesos AS PCompos, " + ;
                                           "       p.Varias, b.NTipoJoals, u.Fators " + ;
                                           "FROM SigPrCpo a, SigCdPro p, SigCdGrp b, SigCdUni u " + ;
                                           "WHERE a.CPros = '" + PADR(cursor_4c_LocalMvItn.CPros, 14) + "' " + ;
                                           "  AND a.Mats = p.CPros " + ;
                                           "  AND p.CGrus = b.CGrus " + ;
                                           "  AND a.UniCompos = u.CUnis " + ;
                                           "ORDER BY a.Mats"
                                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCompo")
                                IF USED("cursor_4c_LocalCompo")
                                    UPDATE cursor_4c_LocalCompo ;
                                       SET Qtds    = Qtds    * loc_lnQtdsItens, ;
                                           PCompos = PCompos * loc_lnQtdsItens
                                ENDIF
                            ENDIF

                            loc_lnPtt = 0

                            IF USED("cursor_4c_LocalCompo")
                                SELECT cursor_4c_LocalCompo
                                SCAN
                                    DO CASE
                                        CASE cursor_4c_LocalCompo.Varias = 1
                                            SELECT crInvoices
                                            GO BOTTOM
                                            REPLACE Metals WITH Metals + cursor_4c_LocalCompo.Qtds
                                            loc_lnPtt = loc_lnPtt + cursor_4c_LocalCompo.Qtds
                                            SELECT cursor_4c_LocalCompo
                                        CASE INLIST(cursor_4c_LocalCompo.NTipoJoals, 0, 1)
                                            SELECT crInvoices
                                            GO BOTTOM
                                            REPLACE Peso1s WITH Peso1s + cursor_4c_LocalCompo.Qtds, ;
                                                    Qtd1s  WITH Qtd1s  + cursor_4c_LocalCompo.PCompos
                                            loc_lnPtt = loc_lnPtt + ;
                                                        (cursor_4c_LocalCompo.PCompos * cursor_4c_LocalCompo.Fators)
                                            SELECT cursor_4c_LocalCompo
                                        CASE cursor_4c_LocalCompo.NTipoJoals = 2
                                            SELECT crInvoices
                                            GO BOTTOM
                                            REPLACE QtdBs  WITH QtdBs  + cursor_4c_LocalCompo.Qtds, ;
                                                    PesoBs WITH PesoBs + cursor_4c_LocalCompo.PCompos
                                            loc_lnPtt = loc_lnPtt + ;
                                                        (cursor_4c_LocalCompo.PCompos * cursor_4c_LocalCompo.Fators)
                                            SELECT cursor_4c_LocalCompo
                                    ENDCASE
                                ENDSCAN
                            ENDIF

                            SELECT crInvoices
                            GO BOTTOM
                            REPLACE PTots WITH loc_lnPtt

                            loc_lnVal = loc_lnVal + (cursor_4c_LocalMvItn.Units * loc_lnQtdsItens)
                            loc_lnItn = loc_lnItn + 1
                            IF loc_lnItn > loc_lnMax
                                loc_lnItn = 1
                                loc_lnPgn = loc_lnPgn + 1
                            ENDIF

                            SELECT cursor_4c_crItens
                        ENDSCAN && cursor_4c_crItens
                    ENDIF && produto encontrado

                    SELECT cursor_4c_LocalMvItn
                ENDSCAN && cursor_4c_LocalMvItn

                *-- Calculo final do valor total
                SELECT cursor_4c_LocalNFis
                loc_lnHnd = cursor_4c_LocalNFis.VlFretes + cursor_4c_LocalNFis.VlSeguros + ;
                            cursor_4c_LocalNFis.DespAces

                loc_lcVlT = ""
                SELECT cursor_4c_LocalIvOpe
                IF cursor_4c_LocalIvOpe.chkCabs = 1 AND cursor_4c_LocalIvOpe.chkTots = 1
                    loc_lcVlT = ALLTRIM(TRANSFORM(loc_lnVal + loc_lnHnd, "@Z 999,999,999.99"))
                ENDIF

                UPDATE crInvoices ;
                   SET TotPag   = loc_lnPgn, ;
                       DadTots  = loc_lcVlT, ;
                       DadHands = loc_lnHnd

                *-- Primeira passagem para obter numero real de paginas
                SELECT crInvoices
                GO BOTTOM
                REPLACE ImpRodape WITH .T.
                GO TOP
                REPORT FORM SigReIiv NOCONSOLE
                UPDATE crInvoices SET TotPag = _PageNo

                SELECT crInvoices
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_lcPmt, loc_lcArq
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_lcPmt = IIF(INLIST(THIS.this_nTpImp, 2, 4), "", "PROMPT")
                REPORT FORM SigReIiv TO PRINTER &loc_lcPmt. NOCONSOLE

                IF THIS.this_lImprimirListagem
                    SELECT crInvoices
                    GO TOP
                    REPORT FORM SigReIpk TO PRINTER NOCONSOLE
                ENDIF

                loc_lcArq = SYS(2023) + "\SigReIiv_*.jpg"
                DELETE FILE &loc_lcArq.

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_lcArq
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                REPORT FORM SigReIiv PREVIEW NOCONSOLE

                IF THIS.this_lImprimirListagem
                    SELECT crInvoices
                    GO TOP
                    REPORT FORM SigReIpk PREVIEW NOCONSOLE
                ENDIF

                loc_lcArq = SYS(2023) + "\SigReIiv_*.jpg"
                DELETE FILE &loc_lcArq.

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e restaura configuracoes
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_lcArq
        TRY
            loc_lcArq = SYS(2023) + "\SigReIiv_*.jpg"
            DELETE FILE &loc_lcArq.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        SET POINT TO "."
        SET SEPARATOR TO ","
        DODEFAULT()
    ENDPROC

ENDDEFINE
