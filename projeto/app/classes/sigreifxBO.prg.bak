*==============================================================================
* SIGREIFXBO.PRG
* Business Object para impressao de documentos comerciais
* Corresponde ao formulario legado: SIGREIFX.SCX (frmrelatorio)
*
* Chamado via CREATEOBJECT("sigreifxBO") pelo Formsigreifx.
* Propriedades preenchidas por Formsigreifx.FormParaRelatorio() antes de Imprimir/Visualizar.
*
* O tipo de FRX e selecionado dinamicamente em ExecutarRelatorio() com base em:
*   SigCdOpe.Docus: 3/11=HxFixo, 6=VtFixo, 7=NtDeb, 8/12=Locacao, 9=Colunas, 10=3Vias
*   FRX possiveis: SigReIfx, SigReIf2, SigReHfi, SigRevfx, SigRevf2, SigRevf3,
*                  SigRevf4, SigRevf0, SigRevfc, SigRevfs, SigRevf5, SigRevf6,
*                  SigReIfi, SigReDpc, SigReIft
*==============================================================================

DEFINE CLASS sigreifxBO AS RelatorioBase

    *-- Identificacao do documento (recebidos do form de chamada via Formsigreifx.Init)
    this_cEmps           = ""   && Empresa (pcEmps, PADR 3 chars) - Cemps de SigCdEmp
    this_cDopes          = ""   && Codigo da operacao (pcDopes, PADR 20 chars) - Dopes de SigCdOpe
    this_nNumes          = 0    && Numero do documento (pcNumes, numeric 6) - Numes de SigMvCab

    *-- Modo de operacao do formulario
    this_nTpImpressao    = 0    && Tipo: 0=normal 2/4=direto sem prompt 3/4=auto-print 5=visualizar
    this_lPChkImpDoc     = .F.  && Verifica historico de impressao ao abrir (pChkImpDoc)

    *-- Controle de acesso a reimpressao (checado via fChecaAcesso no legado)
    this_lChkImpDoc      = .F.  && Documento ja impresso - requer verificacao de acesso (chkimpdoc)
    this_lChkImpDocAcess = .F.  && Usuario tem permissao para reimprimir (chkimpdocacess)

    *-- Estado dos checkboxes visuais do form
    this_lChkObs         = .T.  && Imprimir obs de moedas/cotacoes (chkObs, visivel Docus 3/6/11)
    this_lChkImagem      = .F.  && Imprimir imagem do produto (chkImagem, visivel apenas Docus 6/10)

    *-- Permissoes de acesso aos botoes (lidas de configuracao de acesso do sistema)
    this_lAcExcel        = .F.  && Permissao para exportar Excel (lAcExcel do form legado)
    this_lAcImprimir     = .T.  && Permissao para imprimir (lAcImprimir do form legado)

    *-- Arquivos temporarios de imagem gerados em ProcessarRelatorio via Sys(2023)
    this_cImgLogotipo    = ""   && Path JPG logotipo empresa copiado de SigCdEmp.LogoRels/Logos
    this_cImgTecnicas    = ""   && Path JPG imagem tecnica do produto de SigOpCdc.ImgTecs
    this_cImgBranco      = ""   && Path JPG em branco criado por fCriarIcone (brjpg.jpg)

    *-- Dados de envio por email e exportacao PDF
    this_cContaEmail     = ""   && Emails de SigCdCli.Emails concatenados (ContaOs + ContaDs)
    this_cPcArqEmail     = ""   && Path do arquivo gerado (PDF/XLS) para email (pcArqEmail)

    *-- Dados de SigCdOpe carregados em SelecionarDados
    this_nDocus          = 0    && Tipo do documento (de SigCdOpe.Docus)
    this_nOpers          = 0    && Tipo da operacao (1=Entrada 2=Saida 3=Ambos, de SigCdOpe.Opers)
    this_nNdopes         = 0    && Numero interno da operacao (de SigCdOpe.NDopes)

    *--------------------------------------------------------------------------
    * Init - Inicializa BO de impressao de documentos
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar sigreifxBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta Emps+Dopes+Numes
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o documento
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                THIS.ExecutarRelatorio(.F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do documento
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                THIS.ExecutarRelatorio(.T.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra selecao e processamento dos dados do relatorio
    * Equivalente a SelecionaDados() + Processamento() do legado
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.SelecionarDados()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.ProcessarRelatorio()
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Carrega todos os cursores de dados do SQL Server
    * Equivalente ao metodo SelecionaDados() do form legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_cEdn, loc_cQuery, loc_nResult
        loc_lSucesso = .F.
        loc_cEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

        TRY
            *-- SigCdOpe -> LocalOpe
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Opers, NDopes, Docus, Casas, CMoes, TipoNfs, Dcpns, NCPesos, cupfis, Habservs " + ;
                "FROM SigCdOpe WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "'", ;
                "LocalOpe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalOpe)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalOpe
            THIS.this_nDocus  = LocalOpe.Docus
            THIS.this_nOpers  = LocalOpe.Opers
            THIS.this_nNdopes = LocalOpe.NDopes

            *-- SigOpCdd -> LocalOpe2 (com default se nao encontrar)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DckLogos, DckAcess, DocAcess, ChkImpDp, ChkImpRot, ChkImpMon, DckDPro3s, CasQtds, " + ;
                "DckImpIss, ImpFxSers, PafEcfs, EditAgends, nCarDims, DckImpCd, DckEqs, ConfigGers, " + ;
                "DckSaldo, DocSaldo, DckTotBrt, DckObsMov, DckViaResu " + ;
                "FROM SigOpCdd WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "'", ;
                "LocalOpe2")
            IF loc_nResult < 1
                CREATE CURSOR LocalOpe2 (DckLogos n(1), DckAcess n(1), DocAcess c(12), ChkImpDp n(1), ;
                    ChkImpRot n(1), ChkImpMon n(1), DckDPro3s n(1), CasQtds n(1), DckImpIss n(1), ;
                    ImpFxSers n(1), PafEcfs n(1), EditAgends n(1), nCarDims n(1), DckImpCd n(1), ;
                    DckEqs n(1), ConfigGers c(254), DckSaldo n(1), DocSaldo c(12), DckTotBrt n(1), ;
                    DckObsMov n(1), DckViaResu n(1))
                INSERT INTO LocalOpe2 VALUES (0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                    REPLICATE(' ', 254), 0, '', 0, 0, 0)
            ENDIF
            GO TOP IN LocalOpe2
            IF EOF('LocalOpe2')
                INSERT INTO LocalOpe2 VALUES (0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ;
                    REPLICATE(' ', 254), 0, '', 0, 0, 0)
                GO TOP IN LocalOpe2
            ENDIF

            *-- SigOpCdc -> LocalDcOpe
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DocTit, DckDig, DocOrig, DocDest, DckOri, DckDest, DckReffs, DckCBar, DocReffs, " + ;
                "DckPrzE, DocPrzE, TxtPrzEnts, ChkPrzEnts, DckVend, DocVend, DocPag, DckTVend, DckBarra, " + ;
                "DckFretes, DocFretes, DckIcmIpi, DocDesco, DocAcres, DckEntregs, DocEntregs, DckObsI, " + ;
                "ImgTecs, DckTermos, TitTermos, TxtTermos, ViaTermos, TitTermgs, TxtTermgs, TitTermGs, " + ;
                "TxtTermBs, DocFxSemVl, DocFxVencs, DckTpFats, DckFiscal, DckImpIte, DckSubN, DckObsg, " + ;
                "ObsResu, DckObs, ObsCab, DckOpes, nChkVsts, DocPeso, DckPeso, DckPaga, DocObs, Coletas, " + ;
                "Docunit, DocTotI, DckTaCor, DckNIte, DocNIte, DocItem, DocDescr, DocObsI, DocObsg, " + ;
                "carcompos, ImpDups, QtdDocs, dckEmpDs, dckpeso " + ;
                "FROM SigOpCdc WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "'", ;
                "LocalDcOpe")
            IF loc_nResult < 1 OR EOF('LocalDcOpe')
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalDcOpe)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalDcOpe

            *-- SigOpCdi -> LocalOpCdi
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT lbltxidCs FROM SigOpCdi WHERE Dopes = '" + PADR(THIS.this_cDopes, 20) + "'", ;
                "LocalOpCdi")
            IF loc_nResult < 1 OR EOF('LocalOpCdi')
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalOpCdi)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalOpCdi

            *-- SigCdPam -> LocalParam
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Logos, TpInstalas, MoedaPs, DoppServs FROM SigCdPam", ;
                "LocalParam")
            IF loc_nResult < 1 OR EOF('LocalParam')
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalParam)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalParam

            *-- SigCdEmp -> LocalEmp
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s, Logos, LogoRels, Ceps, Endes, Numeros, " + ;
                "Compls, Bairs, Cidas, Estas, IMS, Razas, NEmps " + ;
                "FROM SigCdEmp WHERE Cemps = '" + PADR(THIS.this_cEmps, 3) + "'", ;
                "LocalEmp")
            IF loc_nResult < 1 OR EOF('LocalEmp')
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEmp)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalEmp

            *-- SigMvCab -> LocalEest
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Emps, Dopes, Numes, Datas, GrVends, Vends, GrResps, Resps, ContaOs, ContaDs, " + ;
                "ContaEs, PrazoEnts, Obses, ValVars, Vars, LocalEnts, TpFats, Localizas, CodTrans, " + ;
                "ValTrans, NEmps, Notas, TabDs, usuars, Nops, PStatus, EmpDs " + ;
                "FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                "LocalEest")
            IF loc_nResult < 1 OR EOF('LocalEest')
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEest)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalEest

            *-- SigMvItn + SigCdPro -> LocalEestI (itens principais)
            loc_cQuery = ;
                "SELECT a.CItens, a.CPros, b.Reffs, a.DPros, b.DPro2s, a.CUnis, a.Qtds, a.Units, " + ;
                "a.Unitorigs, a.Moedas, a.MoeVals, a.Totas, a.Aliqs, a.ValIpis, a.Obs, " + ;
                "a.valdescs, a.pdescs, a.valrats, a.icmss, a.bcicmss, b.IFors, b.Valors, " + ;
                "a.Pesos, a.TPesos, b.CodFinP, b.pesobs, b.clfiscals, " + ;
                "b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.Cftios, b.Sgrus, a.CodBarras, " + ;
                "'' as Fator, a.Citem2, a.fators, a.locals, a.localos, " + ;
                "'' as tamde, '' as tampara " + ;
                "FROM SigMvItn a, SigCdPro b " + ;
                "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND a.CPros = b.CPros"
            IF LocalDcOpe.DckOpes = 1
                loc_cQuery = loc_cQuery + " AND a.Opers = 'E'"
            ENDIF
            IF LocalDcOpe.DckOpes = 2
                loc_cQuery = loc_cQuery + " AND a.Opers = 'S'"
            ENDIF
            IF LocalOpe2.ChkImpRot = 2
                loc_cQuery = loc_cQuery + " ORDER BY a.CPros, a.CItens"
            ELSE
                loc_cQuery = loc_cQuery + " ORDER BY a.CItens"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalEestI")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Caso especial: Docus=10 com Habservs=1 usa SigMvItp
            IF LocalOpe.Docus = 10 AND LocalOpe.Habservs = 1
                loc_cQuery = ;
                    "SELECT a.CItens, a.CPros, b.Reffs, c.DPros, a.dpros as DPro2s, " + ;
                    "c.CUnis, c.Qtds, c.Units, c.Unitorigs, c.Moedas, c.MoeVals, c.Totas, " + ;
                    "c.Aliqs, c.ValIpis, a.Obs, a.valdescs, a.pdescs, a.valrats, a.icmss, " + ;
                    "a.bcicmss, b.IFors, b.Valors, c.Pesos, c.TPesos, b.CodFinP, b.pesobs, " + ;
                    "b.clfiscals, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.Cftios, b.Sgrus, " + ;
                    "a.CodBarras, '' as Fator, a.Citem2, a.fators, a.locals, a.localos, " + ;
                    "c.tamde, c.tampara " + ;
                    "FROM SigMvItn a, SigCdPro b, sigmvitp c " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " " + ;
                    "AND c.empdopnums = " + EscaparSQL(loc_cEdn) + " AND c.CPros = b.CPros"
                IF LocalDcOpe.DckOpes = 1
                    loc_cQuery = loc_cQuery + " AND a.Opers = 'E'"
                ENDIF
                IF LocalDcOpe.DckOpes = 2
                    loc_cQuery = loc_cQuery + " AND a.Opers = 'S'"
                ENDIF
                IF LocalOpe2.ChkImpRot = 2
                    loc_cQuery = loc_cQuery + " ORDER BY a.CPros, a.CItens"
                ELSE
                    loc_cQuery = loc_cQuery + " ORDER BY a.CItens"
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalEestI")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI-10)"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            GO TOP IN LocalEestI

            *-- Fator de tabela de desconto (Dcpns = 1) sobre LocalEestI
            IF LocalOpe.Dcpns = 1
                LOCAL loc_cTab
                loc_cTab = ALLTRIM(LocalEest.TabDs)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpTdt WHERE Codigos = " + EscaparSQL(loc_cTab), ;
                    "LocalTabDescs")
                IF loc_nResult >= 1
                    SELECT LocalTabDescs
                    INDEX ON Codigos + STR(Tipos, 1) + CodTips TAG CodTips
                    SELECT LocalEestI
                    SCAN
                        IF SEEK(loc_cTab + '4' + LocalEestI.CPros, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '9' + LocalEestI.CodFinP, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '1' + LocalEestI.CGrus, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '2' + LocalEestI.Linhas, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '3' + LocalEestI.Colecoes, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '6' + LocalEestI.Cunis, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '7' + LocalEestI.Cftios, 'LocalTabDescs', 'CodTips') OR ;
                           SEEK(loc_cTab + '8' + LocalEestI.Sgrus, 'LocalTabDescs', 'CodTips')
                            REPLACE Fator WITH LocalTabDescs.DescFats IN LocalEestI
                        ENDIF
                    ENDSCAN
                    SELECT LocalEestI
                ENDIF
            ENDIF

            *-- Ordenacao por fator se ChkImpRot = 3
            IF LocalOpe2.ChkImpRot = 3
                SELECT LocalEestI
                INDEX ON Fator + CPros + STR(CItens, 10) TAG Ordem
            ENDIF

            *-- Series de servico (ImpFxSers = 1): acrescenta itens de SigMvItt
            IF LocalOpe2.ImpFxSers = 1
                LOCAL loc_nUltItn
                loc_nUltItn = 0
                SELECT LocalEestI
                GO BOTTOM
                IF !EOF('LocalEestI')
                    loc_nUltItn = LocalEestI.CItens
                ENDIF
                GO TOP IN LocalEestI

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.*, b.Valors, b.DPro2s FROM SigMvItt a, SigCdPro b " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND a.CPros = b.CPros " + ;
                    "ORDER BY " + IIF(LocalOpe2.ChkImpRot = 2, "a.CPros, a.CItens", "a.CItens"), ;
                    "LocalEestis")
                IF loc_nResult >= 1
                    GO TOP IN LocalEestis
                    SELECT LocalEestis
                    SCAN
                        loc_nUltItn = loc_nUltItn + 1
                        INSERT INTO LocalEestI (CItens, CPros, DPros, DPro2s, CUnis, Qtds, Units, ;
                            Totas, Moedas, MoeVals, Valors) ;
                            VALUES (loc_nUltItn, LocalEestis.CPros, LocalEestis.DPros, ;
                                LocalEestis.DPro2s, LocalEestis.CUnis, LocalEestis.Qtds, ;
                                LocalEestis.Units, LocalEestis.Totas, LocalEestis.Moedas, ;
                                LocalEestis.MoeVals, LocalEestis.Valors)
                    ENDSCAN
                ENDIF
            ENDIF

            *-- sigexmvi -> LocalEestIE (itens cancelados para PAF)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.CPros, a.DPros, a.empdopnums, a.Qtds, a.Units, a.Totas " + ;
                "FROM sigexmvi a WHERE a.empdopnums = " + EscaparSQL(loc_cEdn), ;
                "LocalEestIE")

            GO TOP IN LocalEestI

            *-- SigMvIts + SigCdPro -> TmpEstI2 / LocalEstI2 (grade cor/tamanho)
            loc_cQuery = ;
                "SELECT a.CItens, a.CPros, c.Reffs, a.DPros, c.DPro2s, b.CodEmbs as CUnis, " + ;
                "b.Qtds, a.Units, a.Unitorigs, a.Moedas, a.MoeVals, b.QtdEmbs, a.Aliqs, " + ;
                "a.ValIpis, a.Qtds as QtdsA, a.Obs, a.valdescs, a.pdescs, a.valrats, " + ;
                "a.icmss, a.bcicmss, c.iFors, b.CodBarras, b.codtams, b.pesos, a.TPesos, " + ;
                "b.codcors, b.empdopnums, c.valors, a.fators, c.colecoes, c.codfinp, " + ;
                "c.pesobs, c.linhas, a.locals, a.localos " + ;
                "FROM SigMvItn a, SigMvIts b, SigCdPro c " + ;
                "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " " + ;
                "AND a.EmpDopNums = b.EmpDopNums AND a.CItens = b.CItens AND b.CPros = c.CPros"
            IF LocalDcOpe.DckOpes = 1
                loc_cQuery = loc_cQuery + " AND a.Opers = 'E'"
            ENDIF
            IF LocalDcOpe.DckOpes = 2
                loc_cQuery = loc_cQuery + " AND a.Opers = 'S'"
            ENDIF
            IF LocalOpe2.ChkImpRot = 2
                loc_cQuery = loc_cQuery + " ORDER BY a.CPros, a.CItens"
            ELSE
                loc_cQuery = loc_cQuery + " ORDER BY a.CItens"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "TmpEstI2")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (TmpEstI2)"
                MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT CItens, CPros, Reffs, DPros, DPro2s, CUnis, ;
                Qtds * IIF(QtdEmbs > 0, QtdEmbs, 1) AS Units, Unitorigs, ;
                Moedas, MoeVals, ;
                (Qtds * Units) * IIF(QtdEmbs > 0, QtdEmbs, 1) AS Totas, ;
                Aliqs, IFors, Obs, valdescs, pdescs, valrats, icmss, bcicmss, ;
                CodBarras, ;
                (ValIpis / IIF(QtdsA = 0, 1, QtdsA)) * (Qtds * IIF(QtdEmbs > 0, QtdEmbs, 1)) AS ValIpis, ;
                CodTams, Pesos, TPesos, CodCors, EmpDopNums, Valors, Fators, ;
                colecoes, codfinp, pesobs, linhas, locals, localos ;
            FROM TmpEstI2 ;
            ORDER BY CItens ;
            INTO CURSOR LocalEstI2 READWRITE

            SELECT LocalEstI2
            GO TOP
            IF LocalOpe2.ChkImpRot = 2
                INDEX ON CPros + STR(CItens, 6) TAG CItens
            ELSE
                INDEX ON STR(CItens, 6) TAG CItens
            ENDIF

            *-- SigMvNfi -> LocalNFis
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigMvNfi WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                "LocalNFis")
            IF loc_nResult >= 1
                GO TOP IN LocalNFis
            ENDIF

            *-- SigPrTrp -> LocalTra
            LOCAL loc_cTraCod
            loc_cTraCod = ''
            IF USED('LocalNFis') AND !EOF('LocalNFis')
                loc_cTraCod = ALLTRIM(LocalNFis.codtrans)
            ENDIF
            IF !EMPTY(loc_cTraCod)
                SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrTrp WHERE itras = " + EscaparSQL(loc_cTraCod), ;
                    "LocalTra")
                IF USED('LocalTra')
                    GO TOP IN LocalTra
                ENDIF
            ENDIF

            *-- SigMvPar + SigOpFp -> LocalPar1
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT a.FPags, a.MoeFpgs, a.CotFpgs, a.Valos, a.Vencs, b.Descrs " + ;
                "FROM SigMvPar a, SigOpFp b " + ;
                "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND b.FPags = a.FPags", ;
                "LocalPar1")
            IF loc_nResult < 1 OR !USED("LocalPar1")
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalPar1)"
                loc_lSucesso = .F.
            ENDIF
            GO TOP IN LocalPar1

            *-- Ajusta Vencs de LocalPar1
            UPDATE LocalPar1 SET Vencs = NVL(IIF(LocalDcOpe.DocFxVencs = 1, Vencs, CTOT('')), CTOT(''))
            GO TOP IN LocalPar1

            *-- LocalPar (agrupado de LocalPar1)
            SELECT SUM(1) AS Total, TTOD(Vencs) AS Vencs, FPags, MoeFpgs, CotFpgs, Valos, Descrs ;
                FROM LocalPar1 ;
                GROUP BY 2, 3, 4, 5, 6, 7 ;
                INTO CURSOR LocalPar READWRITE
            GO TOP IN LocalPar

            *-- SigMvPec -> LocalEstPe (condicional DckSubN)
            IF LocalDcOpe.DckSubN = 1
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.Codigos FROM SigMvPec a " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " ORDER BY a.Codigos", ;
                    "LocalEstPe")
                IF loc_nResult >= 1
                    GO TOP IN LocalEstPe
                ENDIF
            ENDIF

            *-- SigMvIte + SigCdEmb -> LocalMvIte (condicional ConfigGers posicao 211)
            IF INT(VAL(SUBSTR(LocalOpe2.ConfigGers, 211, 01))) = 1
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT a.*, b.Descs FROM SigMvIte a " + ;
                    "INNER JOIN SigCdEmb b ON a.CodEmbs = b.Cods " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                    "LocalMvIte")
                IF loc_nResult < 1
                    MsgErro("Favor Reinicializar o Processo!!! (LocalMvIte)", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
                GO TOP IN LocalMvIte
            ENDIF

            *-- Docus=10: SigCdobs e SigOpFnl
            IF LocalOpe.Docus = 10
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdobs", "TmpObs")
                IF loc_nResult < 1
                    MsgErro("Favor reinicializar o processo !!! (TmpObs)", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpFnl WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                    "crTmpFnl")
                IF loc_nResult < 1
                    MsgErro("Favor reinicializar o processo !!! (crTmpFnl)", ;
                        "Falha na Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em SelecionarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRelatorio - Cria cursores do relatorio e os popula com os dados
    * Equivalente ao metodo Processamento() do form legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarRelatorio()
        LOCAL loc_lSucesso, loc_cEdn, loc_cQuery, loc_nResult
        LOCAL loc_lnMax, loc_lnPgn, loc_lnItn, loc_lnQtI, loc_lnSeq, loc_lnTQt, loc_llMud
        LOCAL loc_lcFor, loc_lcEnt, loc_lcRef, loc_lcVen, loc_lcPag, loc_lcDad, loc_lcVar
        LOCAL loc_lcBar, loc_lcTel, loc_lcBVd, loc_lnNum, loc_lcFrt, loc_lnIcm, loc_lnIss
        LOCAL loc_ldOnt, loc_lcOnt, loc_lcObM, loc_lcSep, loc_lcPnt, loc_llQP
        LOCAL loc_lcObsDet, loc_lnSaldoCta, loc_lcMoeSaldo, loc_lcSaldos
        LOCAL loc_lcNEmps, loc_lcNSeqs, loc_lcSeqs, loc_lcNumes, loc_lcNumps
        LOCAL loc_lcImpCodBar, loc_lcFis, loc_lcEqv, loc_lcArquivo
        LOCAL loc_lcEmbalagem, loc_lcColecoes, loc_lcFinp, loc_lcLinhas, loc_lcPesoBs
        LOCAL loc_lcReffs, loc_lcQtd, loc_lcUnits, loc_lcPeso, loc_lcTPes, loc_lcFator
        LOCAL loc_lnCas, loc_lcMask, loc_lnSetAnt, loc_lnBrr, loc_lnTotas
        LOCAL loc_llIfr, loc_lcEnd, loc_lcMercs, loc_lcSub

        loc_lSucesso = .F.
        loc_cEdn = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

        TRY
            *-- Criar cursores do relatorio
            CREATE CURSOR crCabecalho ( ;
                Dopes c(20), Numes n(6), Datas d(8), Razas c(40), RazSocs c(50), Cgcs c(20), ;
                RespFretes c(16), Obses m(4), ObsMoes m(4), Ies c(15), GrVends c(10), Vends c(10), ;
                DVends c(50), DddVends c(4), Tel1sVends c(20), Tel2sVends c(20), Tel3sVends c(20), ;
                eMailVends c(50), GrResps c(10), Resps c(10), DResps c(40), ForIClis c(10), ;
                ForRClis c(50), ForEndes c(60), ForNums c(10), ForCompls c(15), ForCeps c(9), ;
                ForCidas c(30), ForBairs c(40), ForEstas c(2), ForContato c(20), ForDdds c(4), ;
                ForTel1s c(20), ForTel2s c(20), ForFaxs c(20), ForeMails c(50), ForCgcs c(20), ;
                ForIes c(15), ForIMuns c(20), ForTpClis n(1), EntIClis c(10), EntRClis c(50), ;
                EntEndes c(80), EntNums c(10), EntCompls c(15), EntCeps c(9), EntCidas c(30), ;
                EntBairs c(40), EntEstas c(2), EntContato c(20), EntDdds c(4), EntTel1s c(20), ;
                EntTel2s c(20), EntFaxs c(20), EnteMails c(50), EntCgcs c(20), EntIes c(15), ;
                EntTpClis n(1), PrazoEnts d(8), Icms n(16,2), TipoVars c(20), Variacao n(16,2), ;
                VariacaoP n(16,4), EditAgends n(1), CondPagto m(4), TotPag n(4), Fretes c(12), ;
                TitFornec c(15), DckPrzE n(1), DocPrzE c(15), DckReffs n(1), DocReffs c(20), ;
                DckCBar n(1), DckVend n(1), TitVend c(15), DckTVend n(1), Barras c(10), ;
                ImpCabBar l(1), Imagem c(64), ImgTec c(64), DckFretes n(1), DocFretes c(12), ;
                DckAcess n(1), DocAcess c(12), DckIcmIpi n(1), DocPag c(12), DckEntregs n(1), ;
                DocEntregs c(12), DckObsI n(1), Telefone c(41), VlFretes n(16,2), VlAcess n(16,2), ;
                BarVends c(10), TitTermos m(4), TxtTermos m(4), TitTermgs m(4), TxtTermgs m(4), ;
                TxtTermBs m(4), Pagina n(4), ObsEntrega c(254), DocFxSemVl n(1), DckTpFats n(1), ;
                TpFats c(3), DckLogos n(1), Rotas c(10), Localizas c(6), CodTrans c(10), ;
                QtdImpIte n(12,3), Subniveis m(4), DckImpIss n(1), VlrIss n(12,2), IcmsS n(12,2), ;
                VlSeguros n(12,2), ObsResu m(4), ObsCab m(4), TotQtds n(12,2), ChkImpMon n(1), ;
                TitPaf01 c(100), TitPaf02 c(100), TitPaf03 c(100), TitPaf04 c(100), ;
                nCupoms c(6), nCaixas c(3), CMoes c(3), DckPaga n(1), ImprimeLinhas n(1), ;
                ImpFator l(1), DckImpCd l(1), DocPeso c(20), DocObs c(12), Negrito l(1), ;
                DocValUni c(25), DocValTot c(25), DckEqs n(1), TotItens c(20), DesItens c(12), ;
                DocItem c(12), DocDescr c(12), DocObsI c(12), DocObsg c(12), CepCobs c(9), ;
                EndCobs c(80), BaiCobs c(20), CidCobs c(20), EstCobs c(2), EmpCeps c(9), ;
                EmpEndes c(60), EmpNumeros c(10), EmpCompls c(30), EmpBairs c(40), ;
                EmpCidas c(30), EmpEstas c(2), EmpIMS c(15), opers n(1,0), nops c(10), ;
                dcksaldo n(1,0), docsaldo c(12), SaldoCta n(14,2), MoeSaldo c(3), ;
                DckTotBrt n(1,0), DckObsMov n(1,0), Saldos c(30), ImpCodBar c(20), ;
                Status c(20), dckEmpDs n(1), EmpDs c(3), ObsDet m(4))

            CREATE CURSOR crDados ( ;
                Pagina n(4), CItens n(4), CPros c(14), Reffs c(40), DPros m(4), DPro2s m(4), ;
                CUnis c(3), Qtds c(9), Units c(15), Unitorigs n(11,2), Totas n(11,2), ;
                Moedas c(3), MoeVals n(12,2), Aliqs n(4,2), ValIpis n(11,2), Obs m(4), ;
                valdescs n(11,2), pdescs n(11,2), valrats n(11,2), icmss n(11,2), bcicmss n(11,2), ;
                Valors n(11,2), Pesos c(9), TPesos c(9), Fator c(10), CodBarras n(14), ;
                CProEqs c(14), DescSgrus c(20), ClFiscals c(10), Imagem c(100), fators c(9), ;
                Embalagens c(40), Colecoes c(10), codfinp c(3), pesobs c(9), linhas c(10), ;
                local c(10), TamDe c(4), TamPara c(4), Mercs c(3))

            CREATE CURSOR crMoedas (CMoes c(3), Valos n(12,2), CotFpgs n(12,2))
            INDEX ON CMoes TAG CMoes

            CREATE CURSOR crFatores (Fator c(10), Totas n(12,2))
            INDEX ON Fator TAG Fator

            CREATE CURSOR xTotEmb (Colecoes c(10), Fators c(9), QtdEtqs n(6), PesoEtqs n(10,3), ;
                Pesos n(12,3), Units n(15,4), Embalagens c(40), pEmb1 n(7,3), pEmb2 n(7,3), ;
                pEmb3 n(7,3), pEmb4 n(7,3), pEmb5 n(7,3))
            INDEX ON Colecoes + Fators TAG Colecoes

            loc_llQP = .F.

            *-- Locacao: ajusta separadores decimais
            IF INLIST(LocalOpe.Docus, 8, 12)
                loc_lcSep = SET("Separator")
                loc_lcPnt = SET("Point")
                SET SEPARATOR TO "."
                SET POINT TO ","
            ENDIF

            *-- Determinar max itens por pagina (lnMax)
            DO CASE
                CASE INLIST(LocalOpe.Docus, 3, 11)
                    loc_lnMax = IIF(INT(VAL(LocalDCOpe.Coletas)) < 1, 14, INT(VAL(LocalDCOpe.Coletas)))
                    loc_lnMax = IIF(LocalDcOpe.DckObsI = 1, INT(loc_lnMax / 2), loc_lnMax)
                    IF LocalOpe2.PafEcfs = 1
                        loc_lnMax = loc_lnMax - IIF(LocalDcOpe.DckObsI = 1, 1, 3)
                    ENDIF
                CASE LocalOpe.Docus = 6
                    loc_lnMax = IIF(INT(VAL(LocalDCOpe.Coletas)) < 1, 36, INT(VAL(LocalDCOpe.Coletas)))
                    loc_lnMax = IIF(LocalDcOpe.DckObsI = 1, INT(loc_lnMax / 2), loc_lnMax)
                    IF LocalOpe2.PafEcfs = 1
                        loc_lnMax = loc_lnMax - IIF(LocalDcOpe.DckObsI = 1, 1, 3)
                    ENDIF
                CASE LocalOpe.Docus = 8
                    loc_lnMax = 1
                CASE LocalOpe.Docus = 9
                    loc_lnMax = 44
                OTHERWISE
                    loc_lnMax = IIF(INT(VAL(LocalDCOpe.Coletas)) < 1, 14, INT(VAL(LocalDCOpe.Coletas)))
                    loc_lnMax = IIF(LocalDcOpe.DckObsI = 1, INT(loc_lnMax / 2), loc_lnMax)
                    IF LocalOpe2.PafEcfs = 1
                        loc_lnMax = loc_lnMax - IIF(LocalDcOpe.DckObsI = 1, 1, 3)
                    ENDIF
            ENDCASE

            *-- Carregar email de contato
            THIS.this_cContaEmail = ''
            IF !EMPTY(LocalEest.ContaOs)
                SQLEXEC(gnConnHandle, ;
                    "SELECT Emails FROM SigCdCli WHERE Iclis = '" + ALLTRIM(LocalEest.ContaOs) + "'", ;
                    "crTmpCli")
                IF USED('crTmpCli') AND !EOF('crTmpCli') AND !EMPTY(crTmpCli.Emails)
                    THIS.this_cContaEmail = ALLTRIM(crTmpCli.Emails) + ';'
                ENDIF
            ENDIF
            IF !EMPTY(LocalEest.ContaDs)
                SQLEXEC(gnConnHandle, ;
                    "SELECT Emails FROM SigCdCli WHERE Iclis = '" + ALLTRIM(LocalEest.ContaDs) + "'", ;
                    "crTmpCli")
                IF USED('crTmpCli') AND !EOF('crTmpCli') AND !EMPTY(crTmpCli.Emails)
                    THIS.this_cContaEmail = THIS.this_cContaEmail + ALLTRIM(crTmpCli.Emails)
                ENDIF
            ENDIF

            *-- Carregar detalhes da observacao (SigMvFtc, SigCrRaP, SigPrCpP)
            loc_lcObsDet = ''
            loc_cQuery = ;
                "SELECT RTRIM(LTRIM(b.Descrs)) + ' - ' + " + ;
                "CASE WHEN a.ctits = '' THEN RTRIM(LTRIM(a.Resps)) ELSE RTRIM(LTRIM(c.descrs)) END as ObsDet " + ;
                "FROM SigMvFtc a " + ;
                "JOIN SigCrRaP b ON a.ccars = b.codigos " + ;
                "JOIN SigPrCpP c ON a.ctits = c.codigos " + ;
                "WHERE b.ntipos = 2 AND c.ntipos = 2 " + ;
                "AND a.empdopnums = '" + LocalEest.Emps + ALLTRIM(LocalEest.Dopes) + ;
                STR(LocalEest.Numes, 6) + "'"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cQuery, "LocalDet")
            IF loc_nResult >= 1
                SELECT LocalDet
                GO TOP
                SCAN
                    loc_lcObsDet = loc_lcObsDet + ALLTRIM(LocalDet.ObsDet) + '; '
                ENDSCAN
            ENDIF

            *-- Saldo da conta (DckSaldo)
            loc_lnSaldoCta = 0
            loc_lcMoeSaldo = ''
            loc_lcSaldos   = ''
            IF !EMPTY(LocalEest.ContaDs) AND !EMPTY(LocalEest.Emps)
                LOCAL loc_lcMoe, loc_lnSaldoCt2, loc_lcMoeSald2, loc_lnValor
                loc_lcMoe      = ''
                loc_lnSaldoCt2 = 0
                loc_lcMoeSald2 = ''
                loc_lnValor    = 0

                SQLEXEC(gnConnHandle, ;
                    "SELECT CMoes FROM SigCdOpe WHERE Dopes = '" + ALLTRIM(LocalEest.Dopes) + "'", ;
                    "localOpMoe")
                loc_lcMoe = IIF(USED('localOpMoe') AND !EOF('localOpMoe') AND !EMPTY(localOpMoe.CMoes), ;
                    ALLTRIM(localOpMoe.CMoes), ALLTRIM(LocalParam.MoedaPs))

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupods, ContaDs, Datas, Valos FROM SigMvCab " + ;
                    "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                    "LocalEDN")
                IF loc_nResult >= 1 AND !EOF('LocalEDN')
                    LOCAL loc_pDtI
                    loc_pDtI = LocalEDN.Datas

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 Saldos, Moedas, ISNULL(DtEmis, Datas) as Datas " + ;
                        "FROM SigMvCcr " + ;
                        "WHERE Datas <= '" + DTOC(loc_pDtI) + "' " + ;
                        "AND Grupos = '" + ALLTRIM(LocalEDN.GrupoDs) + "' " + ;
                        "AND Contas = '" + ALLTRIM(LocalEDN.ContaDs) + "' " + ;
                        "AND Moedas = '" + loc_lcMoe + "' " + ;
                        "ORDER BY cidchaves DESC", ;
                        "crSldCta")
                    IF loc_nResult >= 1 AND !EOF('crSldCta') AND !EMPTY(crSldCta.Saldos)
                        loc_lnSaldoCta = crSldCta.Saldos - ;
                            IIF(LocalEDN.Datas = crSldCta.Datas, LocalEDN.Valos, 0)
                        loc_lcMoeSaldo = crSldCta.Moedas
                    ENDIF

                    LOCAL loc_lcSaldo1s, loc_lcSaldo2s
                    loc_lcSaldo1s = IIF(!EMPTY(loc_lnSaldoCta), ;
                        ALLTRIM(TRANSFORM(loc_lnSaldoCta, '999,999,999.99')) + ' ' + loc_lcMoeSaldo, '')
                    loc_lcSaldo2s = IIF(!EMPTY(loc_lnSaldoCt2), ;
                        ALLTRIM(TRANSFORM(loc_lnSaldoCt2, '999,999,999.99')) + ' ' + loc_lcMoeSald2, '')
                    loc_lcSaldos  = loc_lcSaldo1s + ;
                        IIF(!EMPTY(loc_lcSaldo1s) AND !EMPTY(loc_lcSaldo2s), ' / ', '') + ;
                        loc_lcSaldo2s
                ENDIF
            ENDIF

            *-- Titulo do Label do Fornecedor
            loc_lcFor = 'Fornecedor'
            IF INLIST(LocalOpe.Opers, 1, 3) AND !EMPTY(LocalDcOpe.DocOrig)
                loc_lcFor = ALLTRIM(LocalDcOpe.DocOrig)
            ENDIF
            IF INLIST(LocalOpe.Opers, 2, 3) AND !EMPTY(LocalDcOpe.DocDest)
                loc_lcFor = ALLTRIM(LocalDcOpe.DocDest)
            ENDIF

            *-- Titulo do Label da Data de Entrega
            loc_lcEnt = 'Data de Entrega'
            IF !EMPTY(LocalDcOpe.DocPrzE)
                loc_lcEnt = ALLTRIM(LocalDcOpe.DocPrzE)
            ENDIF

            *-- Titulo da Coluna de Referencia do Fornecedor
            loc_lcRef = 'Ref. Fornecedor'
            IF !EMPTY(LocalDcOpe.DocReffs)
                loc_lcRef = ALLTRIM(LocalDcOpe.DocReffs)
            ENDIF

            *-- Titulo do Label do Comprador
            loc_lcVen = 'Comprador'
            IF !EMPTY(LocalDcOpe.DocVend)
                loc_lcVen = ALLTRIM(LocalDcOpe.DocVend)
            ENDIF

            *-- Titulo do Label das Condicoes Comerciais
            loc_lcPag = 'Comerciais'
            IF !EMPTY(LocalDcOpe.DocPag)
                loc_lcPag = ALLTRIM(LocalDcOpe.DocPag)
            ENDIF

            *-- Titulo do Label de Dados de Entrega
            loc_lcDad = 'de Entrega'
            IF !EMPTY(LocalDcOpe.DocEntregs)
                loc_lcDad = ALLTRIM(LocalDcOpe.DocEntregs)
            ENDIF

            *-- Barcode do cabecalho (fAltBar2de5 eh funcao do Framework)
            loc_lcBar = ''
            loc_llBar = (LocalDcOpe.DckBarra = 1)
            TRY
                loc_lcBar = fAltBar2de5(PADL(STR(LocalOpe.NDopes, 4), 4, '0') + ;
                    PADL(STR(THIS.this_nNumes, 6), 6, '0'))
            CATCH
                loc_lcBar = ''
            ENDTRY

            *-- Telefone da empresa
            loc_lcTel = ALLTRIM(LocalEmp.Tel1s) + ;
                IIF(EMPTY(ALLTRIM(LocalEmp.Tel2s)), '', '/' + ALLTRIM(LocalEmp.Tel2s))

            *-- Numero do documento (considera TipoNfs = 5 = NF)
            loc_lnNum = IIF(LocalOpe.TipoNfs = 5, INT(VAL(LocalEest.Notas)), THIS.this_nNumes)

            *-- Barcode OS e numero da sequencia
            loc_lcNEmps = ALLTRIM(STR(LocalEmp.NEmps))
            loc_lcNSeqs = '0'
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT nSeqs FROM SigCdOpd WHERE Dopps = '" + ALLTRIM(LocalParam.DoppServs) + "'", ;
                "CrSigCdOpd")
            IF loc_nResult >= 1 AND !EOF('CrSigCdOpd')
                loc_lcNSeqs = ALLTRIM(STR(CrSigCdOpd.nSeqs))
            ENDIF
            loc_lcSeqs  = ALLTRIM(STR(THIS.this_nNumes))
            loc_lcNumes = PADL(loc_lcSeqs, 6, '0')
            loc_lcNumps = loc_lcNEmps + loc_lcNSeqs + loc_lcNumes
            loc_lcImpCodBar = ''
            TRY
                loc_lcImpCodBar = fAltBar2de5(PADL(ALLTRIM(loc_lcNumps), 10, '0'))
            CATCH
                loc_lcImpCodBar = ''
            ENDTRY

            *-- Status do documento
            LOCAL loc_lcStatus
            loc_lcStatus = ''
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigStats WHERE Cods = '" + ALLTRIM(LocalEest.PStatus) + "'", ;
                "CrSigStats")
            IF loc_nResult >= 1 AND !EOF('CrSigStats')
                loc_lcStatus = ALLTRIM(CrSigStats.Descs)
            ENDIF

            *-- INSERT INTO crCabecalho (linha principal)
            INSERT INTO crCabecalho ( ;
                Dopes, Numes, Datas, Razas, RazSocs, Cgcs, Ies, Obses, TitFornec, DckPrzE, ;
                DocPrzE, DckReffs, DocReffs, DckVend, TitVend, DckTVend, Barras, ImpCabBar, ;
                DckFretes, DocFretes, DckAcess, DocAcess, DckIcmIpi, DocPag, DckEntregs, ;
                DocEntregs, DckObsI, Telefone, TitTermos, TxtTermos, TitTermgs, TxtTermgs, ;
                TxtTermBs, DocFxSemVl, DckTpFats, TpFats, DckLogos, Localizas, CodTrans, ;
                DckImpIss, ChkImpMon, nCaixas, nCupoms, CMoes, DckPaga, EditAgends, ;
                ImprimeLinhas, ImpFator, DckImpCd, DocPeso, DocObs, Negrito, DocValUni, ;
                DocValTot, DckCBar, DckEqs, DocItem, DocDescr, DocObsI, DocObsg, ;
                EmpCeps, EmpEndes, EmpNumeros, EmpCompls, EmpBairs, EmpCidas, EmpEstas, ;
                EmpIMS, opers, dcksaldo, docsaldo, SaldoCta, MoeSaldo, DckTotBrt, ;
                DckObsMov, Saldos, Nops, ImpCodBar, Status, dckEmpDs, EmpDs, ObsDet) ;
            VALUES ( ;
                LocalDcOpe.DocTit, loc_lnNum, NVL(LocalEest.Datas, CTOD('')), ;
                LocalEmp.Razas, LocalEmp.RazSocs, LocalEmp.Cgcs, LocalEmp.Ies, ;
                NVL(LocalEest.Obses, ''), loc_lcFor, LocalDcOpe.DckPrzE, loc_lcEnt, ;
                LocalDcOpe.DckReffs, loc_lcRef, LocalDcOpe.DckVend, loc_lcVen, ;
                LocalDcOpe.DckTVend, loc_lcBar, loc_llBar, LocalDcOpe.DckFretes, ;
                LocalDcOpe.DocFretes, LocalOpe2.DckAcess, LocalOpe2.DocAcess, ;
                LocalDcOpe.DckIcmIpi, loc_lcPag, LocalDcOpe.DckEntregs, loc_lcDad, ;
                LocalDcOpe.DckObsI, loc_lcTel, ;
                NVL(LocalDcOpe.TitTermos, ''), NVL(LocalDcOpe.TxtTermos, ''), ;
                NVL(LocalDcOpe.TitTermgs, ''), NVL(LocalDcOpe.TxtTermgs, ''), ;
                NVL(LocalDcOpe.TxtTermBs, ''), LocalDcOpe.DocFxSemVl, ;
                LocalDcOpe.DckTpFats, LocalEest.TpFats, LocalOpe2.DckLogos, ;
                LocalEest.Localizas, LocalEest.CodTrans, LocalOpe2.DckImpIss, ;
                LocalOpe2.ChkImpMon, LEFT(LocalEest.NEmps, 3), ;
                SUBSTR(LocalEest.NEmps, 5, 6), LocalOpe.CMoes, LocalDcOpe.DckPaga, ;
                LocalOpe2.EditAgends, LocalOpe2.nCarDims, (LocalOpe.Dcpns = 1), ;
                (LocalOpe2.DckImpCd = 1), LocalDCOpe.DocPeso, LocalDCOpe.DocObs, ;
                (LocalOpe2.nCarDims = 2), LocalDCOpe.Docunit, LocalDCOpe.DocTotI, ;
                LocalDCOpe.DckCBar, LocalOpe2.DckEqs, LocalDCOpe.DocItem, ;
                LocalDCOpe.DocDescr, LocalDCOpe.DocObsI, LocalDcOpe.DocObsg, ;
                LocalEmp.Ceps, LocalEmp.Endes, LocalEmp.Numeros, LocalEmp.Compls, ;
                LocalEmp.Bairs, LocalEmp.Cidas, LocalEmp.Estas, LocalEmp.IMS, ;
                LocalOpe.Opers, LocalOpe2.dcksaldo, LocalOpe2.docsaldo, ;
                loc_lnSaldoCta, loc_lcMoeSaldo, LocalOpe2.DckTotBrt, LocalOpe2.DckObsMov, ;
                loc_lcSaldos, loc_lcNumps, loc_lcImpCodBar, loc_lcStatus, ;
                LocalDCOpe.dckEmpDs, LocalEest.EmpDs, loc_lcObsDet)

            *-- PAF - titulos de nota fiscal
            IF LocalOpe2.PafEcfs = 1
                REPLACE TitPaf01 WITH 'DOCUMENTO AUXILIAR DE VENDA - ' + ALLTRIM(THIS.this_cDopes), ;
                    TitPaf02 WITH 'N' + CHR(195) + 'O ' + CHR(201) + ' DOCUMENTO FISCAL - ' + ;
                        'N' + CHR(195) + 'O ' + CHR(201) + ' V' + CHR(193) + 'LIDO COMO RECIBO E COMO GARANTIA DE MERCADORIA - ', ;
                    TitPaf03 WITH 'N' + CHR(195) + 'O COMPROVA PAGAMENTO', ;
                    TitPaf04 WITH CHR(201) + ' VEDADA A AUTENTICA' + CHR(199) + CHR(195) + 'O DESTE DOCUMENTO' ;
                    IN crCabecalho
            ENDIF

            *-- Observacao do Resumo
            IF LocalDcOpe.DckObsg = 1 AND !ISNULL(LocalDcOpe.ObsResu)
                REPLACE ObsResu WITH LocalDcOpe.ObsResu IN crCabecalho
            ENDIF

            *-- Observacao do Cabecalho
            IF crCabecalho.DckVend <> 1 AND LocalDcOpe.DckBarra <> 1 AND ;
               LocalDcOpe.DckObs = 1 AND !ISNULL(LocalDcOpe.ObsCab)
                REPLACE ObsCab WITH LocalDcOpe.ObsCab IN crCabecalho
            ENDIF

            *-- Subniveis
            IF LocalDcOpe.DckSubN = 1 AND USED('LocalEstPe')
                loc_lcSub = ''
                SELECT LocalEstPe
                SCAN
                    IF EMPTY(loc_lcSub)
                        loc_lcSub = 'Subn' + CHR(237) + 'veis : '
                    ENDIF
                    loc_lcSub = loc_lcSub + PADL(LocalEstPe.Codigos, 10, '0') + '; '
                ENDSCAN
                REPLACE Subniveis WITH loc_lcSub IN crCabecalho
            ENDIF

            *-- Dados do Vendedor 1 (Comprador)
            SQLEXEC(gnConnHandle, ;
                "SELECT Razaos, RClis, Ddds, Tel1s, Tel2s, Tel3s, eMails " + ;
                "FROM SigCdCli WHERE IClis = '" + ALLTRIM(LocalEest.Vends) + "'", ;
                "LocalCli")
            loc_lcBVd = ''
            TRY
                loc_lcBVd = fAltBar2de5(ALLTRIM(STRTRAN(LocalEest.Vends, '/', '')) + '0')
            CATCH
                loc_lcBVd = ''
            ENDTRY
            IF USED('LocalCli') AND !EOF('LocalCli')
                REPLACE GrVends     WITH PROPER(LocalEest.GrVends), ;
                    Vends       WITH LocalEest.Vends, ;
                    DVends      WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
                    DddVends    WITH LocalCli.Ddds, ;
                    Tel1sVends  WITH LocalCli.Tel1s, ;
                    Tel2sVends  WITH LocalCli.Tel2s, ;
                    Tel3sVends  WITH LocalCli.Tel3s, ;
                    eMailVends  WITH LocalCli.eMails, ;
                    BarVends    WITH loc_lcBVd IN crCabecalho
            ENDIF

            *-- Dados do Vendedor 2 (Parceiro/Responsavel)
            SQLEXEC(gnConnHandle, ;
                "SELECT Razaos, RClis FROM SigCdCli WHERE IClis = '" + ALLTRIM(LocalEest.Resps) + "'", ;
                "LocalCli")
            IF USED('LocalCli') AND !EOF('LocalCli')
                REPLACE GrResps WITH PROPER(LocalEest.GrResps), ;
                    Resps   WITH LocalEest.Resps, ;
                    DResps  WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos) ;
                    IN crCabecalho
            ENDIF

            *-- Dados do Fornecedor
            loc_llIfr = .F.
            LOCAL loc_lcForCli
            loc_lcForCli = ''
            IF INLIST(LocalOpe.Opers, 1, 3) AND !EMPTY(LocalDcOpe.DocOrig)
                loc_lcForCli = LocalEest.ContaOs
                loc_llIfr = (LocalDCOpe.DckOri = 1)
            ENDIF
            IF INLIST(LocalOpe.Opers, 2, 3) AND !EMPTY(LocalDcOpe.DocDest)
                loc_lcForCli = LocalEest.ContaDs
                loc_llIfr = (LocalDCOpe.DckDest = 1)
            ENDIF
            IF EMPTY(loc_lcForCli)
                loc_lcForCli = LocalEest.ContaOs
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Razaos, RClis, Endes, Nums, Compls, Ceps, Cidas, Bairs, Estas, Contato, " + ;
                "Ddds, Tel1s, Tel2s, Faxs, eMails, Cpfs, Rgs, InscMuns, TpClis, CepCobs, " + ;
                "EndCobs, pracas, BaiCobs, CidCobs, EstCobs " + ;
                "FROM SigCdCli WHERE IClis = '" + ALLTRIM(loc_lcForCli) + "'", ;
                "LocalCli")

            IF loc_nResult >= 1 AND !EOF('LocalCli')
                REPLACE ForIClis WITH loc_lcForCli, ;
                    ForRClis WITH IIF(LocalDcOpe.dckdig = 1, LocalEest.usuars, ;
                        IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos)) ;
                    IN crCabecalho

                IF loc_llIfr
                    REPLACE ForEndes   WITH LocalCli.Endes, ;
                        ForNums    WITH LocalCli.Nums, ;
                        ForCompls  WITH LocalCli.Compls, ;
                        ForCeps    WITH LocalCli.Ceps, ;
                        ForCidas   WITH LocalCli.Cidas, ;
                        ForBairs   WITH LocalCli.Bairs, ;
                        ForEstas   WITH LocalCli.Estas, ;
                        ForContato WITH LocalCli.Contato, ;
                        ForDdds    WITH LocalCli.Ddds, ;
                        ForTel1s   WITH LocalCli.Tel1s, ;
                        ForTel2s   WITH LocalCli.Tel2s, ;
                        ForFaxs    WITH LocalCli.Faxs, ;
                        ForeMails  WITH LocalCli.eMails, ;
                        ForCgcs    WITH LocalCli.Cpfs, ;
                        ForIes     WITH LocalCli.Rgs, ;
                        ForIMuns   WITH LocalCli.InscMuns, ;
                        ForTpClis  WITH LocalCli.TpClis, ;
                        CepCobs    WITH LocalCli.CepCobs, ;
                        EndCobs    WITH ALLTRIM(LocalCli.EndCobs) + ',' + ALLTRIM(LocalCli.pracas), ;
                        BaiCobs    WITH LocalCli.BaiCobs, ;
                        CidCobs    WITH LocalCli.CidCobs, ;
                        EstCobs    WITH LocalCli.EstCobs IN crCabecalho
                ENDIF
            ENDIF

            *-- Dados de Entrega (ContaEs)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Razaos, RClis, Endes, Nums, Compls, Ceps, Cidas, Bairs, Estas, " + ;
                "Contato, Ddds, Tel1s, Tel2s, Faxs, eMails, Cpfs, Rgs, TpClis " + ;
                "FROM SigCdCli WHERE IClis = '" + ALLTRIM(LocalEest.ContaEs) + "'", ;
                "LocalCli")
            IF loc_nResult >= 1 AND !EOF('LocalCli')
                loc_lcEnd = ALLTRIM(LocalCli.Endes) + ;
                    IIF(EMPTY(LocalCli.Nums), '', ', ' + ALLTRIM(LocalCli.Nums)) + ;
                    IIF(EMPTY(LocalCli.Compls), '', ' - ' + ALLTRIM(LocalCli.Compls))
                REPLACE EntIClis  WITH LocalEest.ContaEs, ;
                    EntRClis  WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
                    EntFaxs   WITH LocalCli.Faxs, ;
                    EnteMails WITH LocalCli.eMails, ;
                    EntCgcs   WITH LocalCli.Cpfs, ;
                    EntIes    WITH LocalCli.Rgs, ;
                    EntTpClis WITH LocalCli.TpClis, ;
                    EntEndes  WITH loc_lcEnd, ;
                    EntCeps   WITH LocalCli.Ceps, ;
                    EntBairs  WITH LocalCli.Bairs, ;
                    EntCidas  WITH LocalCli.Cidas, ;
                    EntEstas  WITH LocalCli.Estas, ;
                    EntDdds   WITH LocalCli.Ddds, ;
                    EntTel1s  WITH LocalCli.Tel1s, ;
                    EntTel2s  WITH LocalCli.Tel2s, ;
                    EntContato WITH LocalCli.Contato IN crCabecalho
            ELSE
                *-- Se nao tem dados de entrega, usa dados do fornecedor
                IF !EMPTY(loc_lcForCli)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT Razaos, RClis, Endes, Nums, Compls, Ceps, Cidas, Bairs, Estas, " + ;
                        "Contato, Ddds, Tel1s, Tel2s, Faxs, eMails, Cpfs, Rgs, TpClis " + ;
                        "FROM SigCdCli WHERE IClis = '" + ALLTRIM(loc_lcForCli) + "'", ;
                        "LocalCli")
                    IF loc_nResult >= 1 AND !EOF('LocalCli')
                        loc_lcEnd = ALLTRIM(LocalCli.Endes) + ;
                            IIF(EMPTY(LocalCli.Nums), '', ', ' + ALLTRIM(LocalCli.Nums)) + ;
                            IIF(EMPTY(LocalCli.Compls), '', ' - ' + ALLTRIM(LocalCli.Compls))
                        REPLACE EntIClis  WITH loc_lcForCli, ;
                            EntRClis  WITH IIF(EMPTY(LocalCli.Razaos), LocalCli.RClis, LocalCli.Razaos), ;
                            EntFaxs   WITH LocalCli.Faxs, ;
                            EnteMails WITH LocalCli.eMails, ;
                            EntCgcs   WITH LocalCli.Cpfs, ;
                            EntIes    WITH LocalCli.Rgs, ;
                            EntTpClis WITH LocalCli.TpClis, ;
                            EntEndes  WITH loc_lcEnd, ;
                            EntCeps   WITH LocalCli.Ceps, ;
                            EntBairs  WITH LocalCli.Bairs, ;
                            EntCidas  WITH LocalCli.Cidas, ;
                            EntEstas  WITH LocalCli.Estas, ;
                            EntDdds   WITH LocalCli.Ddds, ;
                            EntTel1s  WITH LocalCli.Tel1s, ;
                            EntTel2s  WITH LocalCli.Tel2s, ;
                            EntContato WITH LocalCli.Contato IN crCabecalho
                    ENDIF
                ENDIF
            ENDIF

            *-- Condicoes Comerciais (condicoes de pagamento)
            loc_lcPag = ''
            IF LocalOpe.Docus = 7   && Nota de Debito
                SELECT LocalPar
                GO TOP IN LocalPar
                IF !EOF('LocalPar')
                    loc_lcPag = DTOC(LocalPar.Vencs) + ALLTRIM(TRANSFORM(LocalPar.Valos, '99,999,999.99'))
                ENDIF
            ELSE
                LOCAL loc_lcQbr, loc_lcDat, loc_lcCot
                IF LocalOpe2.ChkImpDp <> 1
                    loc_lcQbr = IIF(RECCOUNT('LocalPar') > 5, '', CHR(13))
                    SELECT LocalPar
                    SCAN
                        loc_lcDat = IIF(LocalDcOpe.DocFxVencs = 0 OR EMPTY(LocalPar.Vencs), ;
                            '', ' - ' + DTOC(LocalPar.Vencs))
                        loc_lcCot = IIF(LocalOpe.Dcpns = 1, '', ;
                            IIF(LocalPar.CotFpgs <> 1, ;
                                ' (Ct: ' + ALLTRIM(TRANSFORM(LocalPar.CotFpgs, '99,999,999.99')) + ')', ''))
                        IF LocalPar.Total > 1
                            loc_lcPag = loc_lcPag + IIF(EMPTY(loc_lcPag), '', '; ' + loc_lcQbr) + ;
                                ALLTRIM(STR(LocalPar.Total, 10)) + 'x ' + ;
                                ALLTRIM(LocalPar.FPags) + ' - ' + ;
                                IIF(LocalOpe.Docus = 6, '', ALLTRIM(LocalPar.MoeFpgs) + '$ ') + ;
                                ALLTRIM(TRANSFORM(LocalPar.Valos, '99,999,999.99')) + loc_lcCot
                        ELSE
                            loc_lcPag = loc_lcPag + IIF(EMPTY(loc_lcPag), '', '; ' + loc_lcQbr) + ;
                                ALLTRIM(LocalPar.FPags) + ' - ' + ;
                                IIF(LocalOpe.Docus = 6, '', ALLTRIM(LocalPar.MoeFpgs) + '$ ') + ;
                                ALLTRIM(TRANSFORM(LocalPar.Valos, '99,999,999.99')) + loc_lcCot
                        ENDIF
                        loc_lcPag = loc_lcPag + loc_lcDat
                    ENDSCAN
                ELSE
                    CREATE CURSOR crLcPag (Total n(10), Descrs c(30), MoeFpgs c(3), ;
                        Valos n(13,2), CotFpgs n(13,2))
                    INDEX ON ALLTRIM(Descrs) + ALLTRIM(MoeFpgs) TAG IdxLcPag
                    SELECT LocalPar1
                    SCAN
                        IF SEEK(ALLTRIM(LocalPar1.Descrs) + ALLTRIM(LocalPar1.MoeFpgs), ;
                               'crLcPag', 'IdxLcPag')
                            REPLACE Total WITH Total + 1, Valos WITH Valos + LocalPar1.Valos IN crLcPag
                        ELSE
                            INSERT INTO crLcPag (Total, Descrs, MoeFpgs, Valos, CotFpgs) ;
                                VALUES (1, LocalPar1.Descrs, LocalPar1.MoeFpgs, ;
                                    LocalPar1.Valos, LocalPar1.CotFpgs)
                        ENDIF
                    ENDSCAN
                    loc_lcQbr = IIF(RECCOUNT('crLcPag') > 5, '', CHR(13))
                    SELECT crLcPag
                    SCAN
                        loc_lcCot = IIF(LocalOpe.Dcpns = 1, '', ;
                            IIF(crLcPag.CotFpgs <> 1, ;
                                ' (Ct: ' + ALLTRIM(STR(crLcPag.CotFpgs, 16, 2)) + ')', ''))
                        loc_lcPag = loc_lcPag + IIF(EMPTY(loc_lcPag), '', '; ' + loc_lcQbr) + ;
                            ALLTRIM(STR(crLcPag.Valos, 16, 2)) + ' - ' + ;
                            ALLTRIM(STR(crLcPag.Total, 10)) + 'x ' + ;
                            ALLTRIM(crLcPag.Descrs) + loc_lcCot
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Titulo do Label de Variacao
            IF LocalEest.ValVars > 0
                loc_lcVar = 'Encargos Financeiros'
                IF !EMPTY(LocalDcOpe.DocAcres)
                    loc_lcVar = ALLTRIM(LocalDcOpe.DocAcres)
                ENDIF
            ELSE
                loc_lcVar = 'Desconto Concedido'
                IF !EMPTY(LocalDcOpe.DocDesco)
                    loc_lcVar = ALLTRIM(LocalDcOpe.DocDesco)
                ENDIF
            ENDIF

            *-- Dados de NF (frete, ICMS, ISS, seguros)
            loc_lcFrt = ''
            loc_lnIcm = 0
            loc_lnIss = 0
            IF USED('LocalNFis') AND !EOF('LocalNFis')
                loc_lnIcm = LocalNFis.ValIcms
                loc_lnIss = LocalNFis.vTotIss
                IF EMPTY(LocalNFis.VlFretes)
                    loc_lcFrt = IIF(LocalNFis.Fretes <> 1, ;
                        'Destinat' + CHR(225) + 'rio/FOB', 'Emitente/CIF')
                ELSE
                    loc_lcFrt = TRANSFORM(LocalNFis.VlFretes, '9,999,999,999.99')
                    REPLACE VlFretes WITH LocalNFis.VlFretes IN crCabecalho
                ENDIF
                REPLACE VlAcess   WITH LocalNFis.DespAces, ;
                    IcmsS     WITH LocalNFis.IcmsS, ;
                    VlSeguros WITH LocalNFis.vlseguros IN crCabecalho
            ENDIF

            *-- Valor de Transporte
            IF !EMPTY(LocalEest.ValTrans)
                REPLACE VlFretes WITH VlFretes + LocalEest.ValTrans IN crCabecalho
            ENDIF

            *-- Prazo de Entrega
            loc_ldOnt = TTOD(NVL(LocalEest.PrazoEnts, CTOT('')))
            loc_lcOnt = ''
            IF LocalDcOpe.ChkPrzEnts = 1 AND !EMPTY(LocalDcOpe.TxtPrzEnts)
                loc_lcOnt = STRTRAN(ALLTRIM(LocalDcOpe.TxtPrzEnts), '#', DTOC(loc_ldOnt))
            ENDIF

            *-- REPLACE final do crCabecalho com calculos
            REPLACE PrazoEnts  WITH loc_ldOnt, ;
                Variacao   WITH ABS(LocalEest.ValVars), ;
                VariacaoP  WITH ROUND(ABS(LocalEest.Vars), LocalOpe2.EditAgends), ;
                TipoVars   WITH loc_lcVar, ;
                Icms       WITH loc_lnIcm, ;
                RespFretes WITH loc_lcFrt, ;
                CondPagto  WITH loc_lcPag, ;
                VlrIss     WITH loc_lnIss, ;
                ObsEntrega WITH loc_lcOnt IN crCabecalho

            *-- Inserir itens em crDados (SCAN principal)
            loc_lnPgn = 1
            loc_lnItn = 0
            loc_lnQtI = 0
            loc_lnSeq = 0
            loc_lnTQt = 0
            loc_llMud = .F.

            SELECT LocalEestI
            SCAN
                loc_llMud = .F.
                loc_lcFis = ''
                loc_lcEqv = ''

                *-- Descricao fiscal / completa / produto equivalente
                IF LocalDcOpe.DckFiscal = 1 OR LocalOpe2.DckDPro3s = 1 OR LocalOpe2.DckEqs = 1
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DescFis, DPro3s, CProEqs FROM SigCdPro " + ;
                        "WHERE Cpros = '" + ALLTRIM(LocalEestI.CPros) + "'", ;
                        "LocalPro")
                    IF loc_nResult >= 1 AND !EOF('LocalPro')
                        IF (LocalDcOpe.DckFiscal = 1 OR LocalOpe2.DckDPro3s = 1)
                            loc_lcFis = NVL(IIF(LocalDcOpe.DckFiscal = 1, ;
                                LocalPro.DescFis, LocalPro.DPro3s), '')
                            loc_lcFis = STRTRAN(STRTRAN(STRTRAN(ALLTRIM(loc_lcFis), ;
                                CHR(13), ' '), CHR(10), ' '), '  ', ' ')
                        ENDIF
                        IF LocalOpe2.DckEqs = 1
                            loc_lcEqv = LocalPro.CProEqs
                        ENDIF
                    ENDIF
                ENDIF

                *-- Composicao desmembrada - inibir
                IF INLIST(LocalDcOpe.CarCompos, 1, 5) AND ;
                   INT(VAL(SUBSTR(LocalOpCdi.lbltxidCs, 21, 1))) = 1 AND ;
                   !EMPTY(LocalEestI.Citem2) AND LocalEestI.CItens <> LocalEestI.Citem2
                    LOOP
                ENDIF

                *-- Inicializar variaveis por item
                loc_lcArquivo  = ''
                loc_lcEmbalagem = ''
                loc_lcColecoes = ''
                loc_lcFinp     = ''
                loc_lcLinhas   = ''
                loc_lcPesoBs   = ''
                loc_lcMercs    = ''

                *-- Carregar dados adicionais do produto (Docus 3, 11, 6, 9, 10)
                IF INLIST(LocalOpe.Docus, 3, 11)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT FigJpgs, Colecoes, codfinp, pesobs, linhas, Mercs " + ;
                        "FROM SigCdPro WHERE Cpros = '" + ALLTRIM(LocalEestI.CPros) + "'", ;
                        "LocalPro")
                    IF loc_nResult >= 1 AND !EOF('LocalPro')
                        loc_lcColecoes = LocalPro.Colecoes
                        loc_lcFinp     = LocalPro.codfinp
                        loc_lcLinhas   = LocalPro.linhas
                        loc_lcMercs    = LocalPro.Mercs
                        loc_lcPesoBs   = ALLTRIM(TRANSFORM(LocalPro.pesobs, '99999'))
                    ENDIF
                ENDIF

                IF INLIST(LocalOpe.Docus, 6, 9, 10)
                    loc_llQP = IIF(LocalOpe2.DckTotBrt = 1, .T., .F.)
                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT FigJpgs, Colecoes, codfinp, pesobs, linhas, Mercs " + ;
                        "FROM SigCdPro WHERE Cpros = '" + ALLTRIM(LocalEestI.CPros) + "'", ;
                        "LocalPro")
                    IF loc_nResult >= 1 AND !EOF('LocalPro')
                        loc_lcColecoes = LocalPro.Colecoes
                        loc_lcFinp     = LocalPro.codfinp
                        loc_lcLinhas   = LocalPro.linhas
                        loc_lcMercs    = LocalPro.Mercs
                        loc_lcPesoBs   = ALLTRIM(TRANSFORM(LocalPro.pesobs, '99999'))

                        *-- Imagem do produto (Base64 -> JPG temp)
                        IF !EMPTY(LocalPro.FigJpgs) AND !ISNULL(LocalPro.FigJpgs)
                            LOCAL loc_lcFoto, loc_lcProduto
                            loc_lcProduto  = STRTRAN(STRTRAN(ALLTRIM(LocalEestI.CPros), '/', ''), ' ', '')
                            loc_lcFoto     = STRCONV(STRTRAN(STRTRAN(STRTRAN(LocalPro.FigJpgs, ;
                                'data:image/png;base64,', ''), ;
                                'data:image/jpeg;base64,', ''), ;
                                'data:image/jpg;base64,', ''), 14)
                            loc_lcArquivo  = SYS(2023) + '\' + ALLTRIM(loc_lcProduto) + '.JPG'
                            =STRTOFILE(loc_lcFoto, loc_lcArquivo)
                        ENDIF

                        IF !THIS.this_lChkImagem
                            loc_lcArquivo = ''
                        ENDIF

                        *-- Grade embalagem (Docus=9 com ConfigGers)
                        IF LocalOpe.Docus = 9 AND ;
                           INT(VAL(SUBSTR(LocalOpe2.ConfigGers, 211, 01))) = 1 AND USED('LocalMvIte')
                            LOCAL loc_lcFatorEmb
                            loc_lcFatorEmb = ALLTRIM(TRANSFORM(LocalEestI.Fators, '99.999'))
                            SELECT xTotEmb
                            IF !SEEK(LocalPro.Colecoes + loc_lcFatorEmb)
                                INSERT INTO xTotEmb (Colecoes, Fators) ;
                                    VALUES (LocalPro.Colecoes, loc_lcFatorEmb)
                            ENDIF
                            REPLACE Units WITH Units + LocalEestI.Units, ;
                                Pesos WITH Pesos + LocalEestI.Pesos IN xTotEmb

                            SELECT CodEmbs, Descs, Qtds, Pesos FROM LocalMvIte ;
                                WHERE CItens = LocalEestI.CItens ;
                                INTO CURSOR LocalEmb
                            SELECT LocalEmb
                            SCAN
                                loc_lcEmbalagem = loc_lcEmbalagem + ;
                                    TRANSFORM(LocalEmb.Pesos, '999.999') + ' '
                                REPLACE QtdEtqs WITH QtdEtqs + LocalEmb.Qtds, ;
                                    PesoEtqs WITH PesoEtqs + LocalEmb.Pesos, ;
                                    Pesos WITH Pesos + LocalEmb.Pesos IN xTotEmb
                                REPLACE Embalagens WITH loc_lcEmbalagem IN xTotEmb
                                LOCAL loc_lcPos
                                loc_lcPos = ALLTRIM(STR(IIF(RECNO() < 6, RECNO(), 5)))
                                SELECT xTotEmb
                            ENDSCAN
                            IF USED('LocalEmb')
                                USE IN LocalEmb
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                *-- Processar item de tamanho/cor (LocalEstI2)
                IF USED('LocalEstI2') AND SEEK(STR(LocalEestI.CItens, 6), 'LocalEstI2', 'CItens')
                    SELECT LocalEstI2
                    SCAN WHILE (CItens = LocalEestI.CItens)
                        loc_lnItn = loc_lnItn + 1
                        loc_lnSeq = loc_lnSeq + 1

                        *-- Referencia do Fornecedor
                        loc_lcReffs = ''
                        IF ALLTRIM(LocalEstI2.iFors) = ALLTRIM(loc_lcForCli)
                            loc_lcReffs = LocalEstI2.Reffs
                        ELSE
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT Reffs FROM SigPrFnc " + ;
                                "WHERE cPros = '" + ALLTRIM(LocalEstI2.CPros) + "' " + ;
                                "AND iFors = '" + ALLTRIM(loc_lcForCli) + "'", ;
                                "LocalfPro")
                            IF loc_nResult >= 1 AND !EOF('LocalfPro')
                                loc_lcReffs = LocalfPro.Reffs
                            ELSE
                                loc_lcReffs = LocalEstI2.Reffs
                            ENDIF
                        ENDIF

                        *-- Casas decimais de quantidade
                        loc_lnCas  = IIF(LocalOpe2.CasQtds = 0, 3, LocalOpe2.CasQtds)
                        loc_lcMask = '999999999' + IIF(loc_lnCas > 0, ;
                            '.' + REPLICATE('9', loc_lnCas), '')
                        loc_lnSetAnt = SET("Decimals")
                        SET DECIMALS TO MAX(loc_lnCas, 0)
                        loc_lcQtd  = TRANSFORM(LocalEstI2.Qtds, RIGHT(loc_lcMask, 9))
                        loc_lnTQt  = loc_lnTQt + LocalEstI2.Qtds
                        SET DECIMALS TO loc_lnSetAnt

                        *-- Casas decimais de valor unitario
                        loc_lnCas   = IIF(LocalOpe.Casas = 0, 2, LocalOpe.Casas)
                        loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                            '.' + REPLICATE('9', loc_lnCas), '')
                        loc_lnSetAnt = SET("Decimals")
                        SET DECIMALS TO MAX(loc_lnCas, 0)
                        loc_lcUnits = TRANSFORM(LocalEstI2.Units, RIGHT(loc_lcMask, 15))
                        IF LocalOpe.Docus = 8
                            loc_lcUnits = TRANSFORM(LocalEstI2.Units, '999,999,999.99')
                        ENDIF
                        SET DECIMALS TO loc_lnSetAnt

                        *-- Casas decimais de peso
                        loc_lnCas   = IIF(LocalOpe.NCPesos = 0, 2, LocalOpe.NCPesos)
                        loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                            '.' + REPLICATE('9', loc_lnCas), '')
                        loc_lnSetAnt = SET("Decimals")
                        SET DECIMALS TO MAX(loc_lnCas, 0)
                        loc_lcPeso  = ALLTRIM(TRANSFORM(LocalEstI2.Pesos, RIGHT(loc_lcMask, 15)))
                        loc_lcTPes  = ALLTRIM(TRANSFORM(LocalEstI2.TPesos, RIGHT(loc_lcMask, 15)))
                        loc_lcFator = ALLTRIM(TRANSFORM(LocalEstI2.Fators, '99.999'))
                        SET DECIMALS TO loc_lnSetAnt

                        loc_lnBrr = IIF(EMPTY(LocalEstI2.CodBarras), ;
                            LocalEestI.CodBarras, LocalEstI2.CodBarras)

                        INSERT INTO crDados (Pagina, CItens, CPros, Reffs, DPros, DPro2s, CUnis, ;
                            Qtds, Units, Unitorigs, Totas, Moedas, MoeVals, Aliqs, ValIpis, ;
                            Obs, valdescs, pdescs, valrats, icmss, bcicmss, Valors, Pesos, ;
                            TPesos, Fator, CodBarras, CProEqs, ClFiscals, Imagem, Fators, ;
                            Embalagens, Colecoes, codfinp, pesobs, linhas, local, ;
                            TamDe, TamPara, Mercs) ;
                        VALUES (loc_lnPgn, loc_lnSeq, LocalEstI2.CPros, loc_lcReffs, ;
                            IIF(EMPTY(loc_lcFis), LocalEstI2.DPros, loc_lcFis), ;
                            LocalEstI2.DPros, LocalEstI2.CUnis, loc_lcQtd, loc_lcUnits, ;
                            LocalEstI2.Unitorigs, LocalEstI2.Totas, LocalEstI2.Moedas, ;
                            LocalEstI2.MoeVals, LocalEstI2.Aliqs, LocalEstI2.ValIpis, ;
                            NVL(LocalEstI2.Obs, ''), LocalEstI2.valdescs, LocalEstI2.pdescs, ;
                            LocalEstI2.valrats, LocalEstI2.icmss, LocalEstI2.bcicmss, ;
                            LocalEstI2.Valors, loc_lcPeso, loc_lcTPes, LocalEestI.Fator, ;
                            loc_lnBrr, loc_lcEqv, LocalEestI.ClFiscals, loc_lcArquivo, ;
                            loc_lcFator, loc_lcEmbalagem, loc_lcColecoes, loc_lcFinp, ;
                            loc_lcPesoBs, loc_lcLinhas, ;
                            IIF(LocalOpe.Opers = 1, LocalEestI.locals, LocalEestI.localos), ;
                            LocalEestI.TamDe, LocalEestI.TamPara, loc_lcMercs)

                        IF LocalOpe.Docus = 7
                            THIS.CarregarSGrus(LocalEstI2.CPros)
                        ENDIF

                        loc_lnQtI = loc_lnQtI + LocalEstI2.Qtds

                        IF !SEEK(LocalEestI.Fator, 'crFatores', 'Fator')
                            INSERT INTO crFatores (Fator) VALUES (LocalEestI.Fator)
                        ENDIF
                        REPLACE Totas WITH Totas + LocalEstI2.TPesos IN crFatores

                        IF !SEEK(LocalEstI2.Moedas, 'crMoedas', 'CMoes')
                            INSERT INTO crMoedas (CMoes, CotFpgs) ;
                                VALUES (LocalEstI2.Moedas, LocalEstI2.MoeVals)
                        ENDIF
                        REPLACE Valos WITH Valos + LocalEstI2.Totas IN crMoedas

                        *-- Cor e Tamanho detalhado (DckTaCor)
                        IF LocalDcOpe.DckTaCor = 1
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT i.CItens, i.Qtds, i.CodEmbs, i.CodTams, i.CodCors, " + ;
                                "i.QtdEmbs, i.QtdEnts, i.CodEmbEnts, i.CodBarras, i.Pesos " + ;
                                "FROM SigMvIts i " + ;
                                "WHERE i.EmpDopNums = '" + ALLTRIM(LocalEstI2.EmpDopNums) + "' " + ;
                                "AND i.CItens = " + STR(LocalEstI2.CItens), ;
                                "TmpRel2")
                            IF loc_nResult >= 1
                                LOCAL loc_lcDetalheDP
                                loc_lcDetalheDP = ''
                                SELECT TmpRel2
                                INDEX ON STR(CItens, 4) + CodCors + CodTams + CodEmbs TAG cItens
                                SCAN WHILE TmpRel2.CItens = LocalEestI.CItens
                                    loc_lcDetalheDP = 'CB.: ' + ;
                                        TRANSFORM(IIF(TmpRel2.CodBarras = 0, 0, TmpRel2.CodBarras), '99999999')
                                    loc_lcDetalheDP = loc_lcDetalheDP + ' - Tam.: ' + TmpRel2.CodTams
                                    IF !EMPTY(TmpRel2.CodCors)
                                        SQLEXEC(gnConnHandle, ;
                                            "SELECT Descs FROM SigCdCor " + ;
                                            "WHERE Cods = '" + ALLTRIM(TmpRel2.CodCors) + "'", ;
                                            "CrTmpCor")
                                        IF USED('CrTmpCor') AND !EOF('CrTmpCor')
                                            loc_lcDetalheDP = loc_lcDetalheDP + ;
                                                ' - Cor: ' + TmpRel2.CodCors + '-' + ;
                                                PADR(CrTmpCor.Descs, 15)
                                        ENDIF
                                    ENDIF
                                    loc_lnCas  = IIF(LocalOpe2.CasQtds = 0, 3, LocalOpe2.CasQtds)
                                    loc_lcMask = '999999999' + IIF(loc_lnCas > 0, ;
                                        '.' + REPLICATE('9', loc_lnCas), '')
                                    loc_lcDetalheDP = loc_lcDetalheDP + ;
                                        ' - Qtds: ' + TRANSFORM(TmpRel2.Qtds, RIGHT(loc_lcMask, 9))
                                    loc_lnCas   = IIF(LocalOpe.NCPesos = 0, 2, LocalOpe.NCPesos)
                                    loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                                        '.' + REPLICATE('9', loc_lnCas), '')
                                    loc_lnSetAnt = SET("Decimals")
                                    SET DECIMALS TO MAX(loc_lnCas, 0)
                                    loc_lcDetalheDP = loc_lcDetalheDP + ;
                                        ' - Peso: ' + ALLTRIM(TRANSFORM(TmpRel2.Pesos, RIGHT(loc_lcMask, 15)))
                                    SET DECIMALS TO loc_lnSetAnt

                                    INSERT INTO crDados (Pagina, CItens, CPros, Reffs, DPros, ;
                                        DPro2s, CUnis, Qtds, Units, Totas, Moedas, Aliqs, ;
                                        ValIpis, Obs, Valors) ;
                                    VALUES (loc_lnPgn, loc_lnSeq, '', '', loc_lcDetalheDP, ;
                                        '', '', '', '', 0, '', 0, 0, '', 0)
                                    loc_lcDetalheDP = ''

                                    IF loc_lnItn >= loc_lnMax
                                        loc_lnItn = 0
                                        loc_lnPgn = loc_lnPgn + 1
                                        loc_llMud = .T.
                                    ENDIF
                                    SELECT TmpRel2
                                ENDSCAN
                            ENDIF
                        ENDIF

                        SELECT LocalEstI2
                        IF loc_lnItn >= loc_lnMax
                            loc_lnItn = 0
                            loc_lnPgn = loc_lnPgn + 1
                            loc_llMud = .T.
                        ENDIF
                    ENDSCAN
                    SELECT LocalEestI
                ELSE
                    *-- Item sem grade tamanho/cor - usa LocalEestI diretamente
                    loc_lnItn = loc_lnItn + 1
                    loc_lnSeq = loc_lnSeq + 1

                    loc_lcReffs = ''
                    IF !EMPTY(loc_lcForCli) AND ALLTRIM(LocalEestI.IFors) = ALLTRIM(loc_lcForCli)
                        loc_lcReffs = LocalEestI.Reffs
                    ELSE
                        IF !EMPTY(loc_lcForCli)
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT Reffs FROM SigPrFnc " + ;
                                "WHERE cPros = '" + ALLTRIM(LocalEestI.CPros) + "' " + ;
                                "AND iFors = '" + ALLTRIM(loc_lcForCli) + "'", ;
                                "LocalfPro")
                            IF loc_nResult >= 1 AND !EOF('LocalfPro')
                                loc_lcReffs = LocalfPro.Reffs
                            ELSE
                                loc_lcReffs = LocalEestI.Reffs
                            ENDIF
                        ELSE
                            loc_lcReffs = LocalEestI.Reffs
                        ENDIF
                    ENDIF

                    *-- Casas decimais de quantidade
                    loc_lnCas  = IIF(LocalOpe2.CasQtds = 0, 3, LocalOpe2.CasQtds)
                    loc_lcMask = '999999999' + IIF(loc_lnCas > 0, ;
                        '.' + REPLICATE('9', loc_lnCas), '')
                    loc_lnSetAnt = SET("Decimals")
                    SET DECIMALS TO MAX(loc_lnCas, 0)
                    loc_lcQtd  = TRANSFORM(LocalEestI.Qtds, RIGHT(loc_lcMask, 9))
                    loc_lnTQt  = loc_lnTQt + LocalEestI.Qtds
                    SET DECIMALS TO loc_lnSetAnt

                    *-- Casas decimais de valor unitario
                    loc_lnCas   = IIF(LocalOpe.Casas = 0, 2, LocalOpe.Casas)
                    loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                        '.' + REPLICATE('9', loc_lnCas), '')
                    loc_lnSetAnt = SET("Decimals")
                    SET DECIMALS TO MAX(loc_lnCas, 0)
                    loc_lcUnits = TRANSFORM(LocalEestI.Units, RIGHT(loc_lcMask, 15))
                    IF LocalOpe.Docus = 8
                        loc_lcUnits = TRANSFORM(LocalEestI.Units, '999,999,999.99')
                    ENDIF
                    loc_lnTotas = LocalEestI.Totas
                    SET DECIMALS TO loc_lnSetAnt

                    *-- Casas decimais de peso
                    loc_lnCas   = IIF(LocalOpe.NCPesos = 0, 2, LocalOpe.NCPesos)
                    loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                        '.' + REPLICATE('9', loc_lnCas), '')
                    loc_lnSetAnt = SET("Decimals")
                    SET DECIMALS TO MAX(loc_lnCas, 0)
                    loc_lcPeso  = ALLTRIM(TRANSFORM(LocalEestI.Pesos, RIGHT(loc_lcMask, 15)))
                    loc_lcTPes  = ALLTRIM(TRANSFORM(LocalEestI.TPesos, RIGHT(loc_lcMask, 15)))
                    loc_lcFator = ALLTRIM(TRANSFORM(LocalEestI.Fators, '99.999'))

                    *-- Ajustes para Docus=9 (grade colunas)
                    IF LocalOpe.Docus = 9 AND !loc_llQP AND USED('LocalMvIte')
                        SELECT SUM(Pesos) AS pesos FROM LocalMvIte ;
                            WHERE CItens = LocalEestI.CItens ;
                            INTO CURSOR LocalEmb
                        loc_lcPeso  = LocalEestI.Pesos + NVL(LocalEmb.pesos, 0)
                        loc_lcPeso  = ALLTRIM(TRANSFORM(loc_lcPeso, RIGHT(loc_lcMask, 15)))
                        loc_lcUnits = LocalEestI.Pesos
                        loc_lcUnits = ALLTRIM(TRANSFORM(loc_lcUnits, RIGHT(loc_lcMask, 15)))
                        IF USED('LocalEmb')
                            USE IN LocalEmb
                        ENDIF
                    ENDIF

                    *-- Ajuste QxP (HDG - llQP)
                    IF loc_llQP
                        loc_lcUnits = TRANSFORM(LocalEestI.Qtds * LocalEestI.Pesos, RIGHT(loc_lcMask, 15))
                        loc_lcPeso  = ALLTRIM(TRANSFORM(LocalEestI.Pesos, '999999999.99'))
                        loc_lnTotas = LocalEestI.Qtds * LocalEestI.Pesos * LocalEestI.Fators
                    ENDIF

                    SET DECIMALS TO loc_lnSetAnt

                    SELECT LocalEestI
                    INSERT INTO crDados (Pagina, CItens, CPros, Reffs, DPros, DPro2s, CUnis, ;
                        Qtds, Units, Unitorigs, Totas, Moedas, MoeVals, Aliqs, ValIpis, ;
                        Obs, valdescs, pdescs, valrats, icmss, bcicmss, Valors, Pesos, ;
                        TPesos, Fator, CodBarras, CProEqs, ClFiscals, Imagem, Fators, ;
                        Embalagens, Colecoes, codfinp, pesobs, linhas, local, ;
                        TamDe, TamPara, Mercs) ;
                    VALUES (loc_lnPgn, loc_lnSeq, LocalEestI.CPros, loc_lcReffs, ;
                        IIF(EMPTY(loc_lcFis), LocalEestI.DPros, loc_lcFis), ;
                        LocalEestI.DPro2s, LocalEestI.CUnis, loc_lcQtd, loc_lcUnits, ;
                        LocalEestI.Unitorigs, loc_lnTotas, LocalEestI.Moedas, ;
                        LocalEestI.MoeVals, LocalEestI.Aliqs, LocalEestI.ValIpis, ;
                        NVL(LocalEestI.Obs, ''), LocalEestI.valdescs, LocalEestI.pdescs, ;
                        LocalEestI.valrats, LocalEestI.icmss, LocalEestI.bcicmss, ;
                        LocalEestI.Valors, loc_lcPeso, loc_lcTPes, LocalEestI.Fator, ;
                        LocalEestI.CodBarras, loc_lcEqv, LocalEestI.ClFiscals, ;
                        loc_lcArquivo, loc_lcFator, loc_lcEmbalagem, loc_lcColecoes, ;
                        loc_lcFinp, loc_lcPesoBs, loc_lcLinhas, ;
                        IIF(LocalOpe.Opers = 1, LocalEestI.locals, LocalEestI.localos), ;
                        LocalEestI.TamDe, LocalEestI.TamPara, loc_lcMercs)

                    IF LocalOpe.Docus = 7
                        THIS.CarregarSGrus(LocalEestI.CPros)
                    ENDIF

                    loc_lnQtI = loc_lnQtI + LocalEestI.Qtds

                    IF !SEEK(LocalEestI.Fator, 'crFatores', 'Fator')
                        INSERT INTO crFatores (Fator) VALUES (LocalEestI.Fator)
                    ENDIF
                    REPLACE Totas WITH Totas + LocalEestI.TPesos IN crFatores

                    IF !SEEK(LocalEestI.Moedas, 'crMoedas', 'CMoes')
                        INSERT INTO crMoedas (CMoes, CotFpgs) ;
                            VALUES (LocalEestI.Moedas, LocalEestI.MoeVals)
                    ENDIF
                    REPLACE Valos WITH Valos + LocalEestI.Totas IN crMoedas

                    IF loc_lnItn >= loc_lnMax
                        loc_lnItn = 0
                        loc_lnPgn = loc_lnPgn + 1
                        loc_llMud = .T.
                    ENDIF
                ENDIF
            ENDSCAN

            *-- Itens cancelados PAF (LocalEestIE)
            IF USED('LocalEestIE')
                IF RECCOUNT('LocalEestIE') > 0 AND USED('CrSigCdPaf') AND !EOF('CrSigCdPaf')
                    IF INLIST(LocalOpe.CupFis, 2)
                        SELECT LocalEestIE
                        GO TOP
                        SCAN
                            loc_lnItn = loc_lnItn + 1
                            loc_lnSeq = loc_lnSeq + 1
                            INSERT INTO crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, ;
                                Qtds, Units, Totas, Moedas, MoeVals, Aliqs, ValIpis, Obs, ;
                                Valors, Pesos, TPesos, Fator, CodBarras, CProEqs) ;
                            VALUES (loc_lnPgn, loc_lnSeq, LocalEestIE.cpros, '', ;
                                ALLTRIM(LocalEestIE.DPros) + ' CANCELADO', '', ;
                                '', '', 0, '', 0, 0, 0, '', 0, '', '', '', 0, '')
                        ENDSCAN
                    ENDIF
                ENDIF
            ENDIF

            *-- Grade de embalagens xTotEmb (Docus=9 com ConfigGers)
            IF LocalOpe.Docus = 9 AND ;
               (INT(VAL(SUBSTR(LocalOpe2.ConfigGers, 211, 01))) = 1 OR loc_llQP)
                SELECT xTotEmb
                SCAN
                    loc_lnItn = loc_lnItn + 1
                    loc_lnSeq = loc_lnSeq + 1
                    loc_lnCas   = IIF(LocalOpe.NCPesos = 0, 2, LocalOpe.NCPesos)
                    loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                        '.' + REPLICATE('9', loc_lnCas), '')
                    loc_lnSetAnt = SET("Decimals")
                    SET DECIMALS TO MAX(loc_lnCas, 0)
                    LOCAL loc_lcPesoX, loc_lcPesoLX
                    loc_lcPesoX  = ALLTRIM(TRANSFORM(xTotEmb.Pesos, RIGHT(loc_lcMask, 15)))
                    loc_lcPesoLX = ALLTRIM(TRANSFORM(xTotEmb.Pesos - xTotEmb.PesoEtqs, RIGHT(loc_lcMask, 15)))
                    loc_lnCas   = IIF(LocalOpe.Casas = 0, 2, LocalOpe.Casas)
                    loc_lcMask  = '999999999' + IIF(loc_lnCas > 0, ;
                        '.' + REPLICATE('9', loc_lnCas), '')
                    SET DECIMALS TO MAX(loc_lnCas, 0)
                    LOCAL loc_lcUnitsX, loc_lnUnitsX
                    loc_lcUnitsX = TRANSFORM(xTotEmb.Units, RIGHT(loc_lcMask, 15))
                    loc_lnUnitsX = xTotEmb.Units
                    SET DECIMALS TO loc_lnSetAnt

                    IF loc_llQP
                        LOCAL loc_lcColX, loc_lnFatX
                        loc_lcColX = xTotEmb.Colecoes
                        loc_lnFatX = VAL(xTotEmb.Fators)
                        SELECT SUM(Qtds * Pesos * Fators) AS nVt, ;
                            SUM(Qtds * Pesos) AS nVL, SUM(Qtds) AS nTQ ;
                            FROM LocalEestI ;
                            WHERE Colecoes = loc_lcColX AND Fators = loc_lnFatX ;
                            INTO CURSOR crAux
                        loc_lcPesoX  = ALLTRIM(TRANSFORM(crAux.nTQ, RIGHT(loc_lcMask, 15)))
                        loc_lcPesoLX = ALLTRIM(TRANSFORM(crAux.nVL, RIGHT(loc_lcMask, 15)))
                        loc_lnUnitsX = crAux.nVt
                    ENDIF

                    LOCAL loc_lcEmbalagemX
                    loc_lcEmbalagemX = ''
                    LOCAL loc_nEmb
                    FOR loc_nEmb = 1 TO 5
                        LOCAL loc_lcPosEmb
                        loc_lcPosEmb = ALLTRIM(STR(loc_nEmb))
                        IF xTotEmb.pEmb1 + xTotEmb.pEmb2 + xTotEmb.pEmb3 + ;
                           xTotEmb.pEmb4 + xTotEmb.pEmb5 <> 0
                            loc_lcEmbalagemX = xTotEmb.Embalagens
                        ENDIF
                    ENDFOR
                    REPLACE Embalagens WITH loc_lcEmbalagemX IN xTotEmb

                    INSERT INTO crDados (Pagina, CItens, CPros, Reffs, DPros, CUnis, Qtds, ;
                        Units, Totas, Moedas, MoeVals, Aliqs, ValIpis, Obs, Valors, Pesos, ;
                        TPesos, Fator, CodBarras, CProEqs, Colecoes, Fators, Embalagens) ;
                    VALUES (loc_lnPgn, 0, xTotEmb.Colecoes, '', '', '', loc_lcPesoX, ;
                        '', loc_lnUnitsX, '', 0, 0, 0, '', 0, ;
                        loc_lcPesoLX, '', '', 0, '', ;
                        xTotEmb.Colecoes, xTotEmb.Fators, xTotEmb.Embalagens)

                    IF loc_lnItn >= loc_lnMax
                        loc_lnItn = 0
                        loc_lnPgn = loc_lnPgn + 1
                        loc_llMud = .F.
                    ENDIF
                    SELECT xTotEmb
                ENDSCAN

                *-- Reordenar e renumerar crDados
                SELECT * FROM crDados ;
                    ORDER BY Colecoes, Fators, CItens ;
                    INTO CURSOR crDados READWRITE
                loc_lnItn = 0
                loc_lnPgn = 1
                SELECT crDados
                SCAN
                    loc_lnItn = loc_lnItn + 1
                    REPLACE CItens WITH IIF(EMPTY(CItens), 0, loc_lnItn), ;
                        Pagina WITH loc_lnPgn
                    IF loc_lnItn >= loc_lnMax
                        loc_lnItn = 0
                        loc_lnPgn = loc_lnPgn + 1
                        loc_llMud = .F.
                    ENDIF
                ENDSCAN
                SELECT * FROM crDados ;
                    ORDER BY Colecoes, Fators, Pagina, CItens ;
                    INTO CURSOR crDados READWRITE
            ENDIF

            *-- Completar pagina com registros em branco (alinhar folha)
            IF loc_llMud
                loc_lnPgn = loc_lnPgn - 1
            ENDIF
            IF loc_lnItn < loc_lnMax AND !loc_llMud AND !INLIST(LocalOpe.Docus, 7, 9)
                LOCAL loc_nFill
                FOR loc_nFill = loc_lnItn TO (loc_lnMax - 1)
                    INSERT INTO crDados (Pagina) VALUES (loc_lnPgn)
                ENDFOR
            ENDIF

            *-- Criar arquivos temporarios de imagem
            THIS.this_cImgLogotipo = SYS(2023) + '\' + SYS(2015) + '.jpg'
            THIS.this_cImgTecnicas = SYS(2023) + '\' + SYS(2015) + '.jpg'

            *-- Logotipo branco em branco (fCriarIcone)
            THIS.this_cImgBranco = ''
            TRY
                THIS.this_cImgBranco = fCriarIcone('brjpg.jpg', SYS(2023))
            CATCH
                THIS.this_cImgBranco = ''
            ENDTRY

            IF EMPTY(THIS.this_cImgBranco) OR !FILE(THIS.this_cImgBranco)
                MsgAviso('N' + CHR(227) + 'o Foi Encontrado Um .JPG em Branco!!!' + CHR(13) + ;
                    'Procurar Por: ' + ALLTRIM(THIS.this_cImgBranco), 'Aviso')
                loc_lSucesso = .F.
            ENDIF

            CREATE CURSOR csBranco (Branco m(4))
            SELECT csBranco
            APPEND BLANK
            APPEND MEMO Branco FROM (THIS.this_cImgBranco) OVERWRITE

            *-- Logotipo da empresa
            IF !EMPTY(LocalEmp.LogoRels) OR !ISNULL(LocalEmp.LogoRels)
                CLEAR RESOURCES
                COPY MEMO LocalEmp.LogoRels TO (THIS.this_cImgLogotipo)
            ELSE
                IF !EMPTY(LocalEmp.Logos) OR !ISNULL(LocalEmp.Logos)
                CLEAR RESOURCES
                COPY MEMO LocalEmp.Logos TO (THIS.this_cImgLogotipo)
            ELSE
                IF !EMPTY(LocalParam.Logos)
                CLEAR RESOURCES
                COPY MEMO LocalParam.Logos TO (THIS.this_cImgLogotipo)
            ELSE
                CLEAR RESOURCES
                COPY MEMO csBranco.Branco TO (THIS.this_cImgLogotipo)
                ENDIF
                ENDIF
            ENDIF

            *-- Imagem tecnica do produto
            IF !EMPTY(LocalDcOpe.ImgTecs)
                CLEAR RESOURCES
                COPY MEMO LocalDcOpe.ImgTecs TO (THIS.this_cImgTecnicas)
            ELSE
                CLEAR RESOURCES
                COPY MEMO csBranco.Branco TO (THIS.this_cImgTecnicas)
            ENDIF

            *-- Total de itens (DckImpIte)
            LOCAL loc_lnQtt
            loc_lnQtt = 0
            IF LocalDcOpe.DckImpIte = 1
                SELECT '' AS Agrupar, SUM(VAL(Qtds)) AS Qtds ;
                    FROM crDados ;
                    GROUP BY 1 ;
                    INTO CURSOR crSoma
                GO TOP IN crSoma
                loc_lnQtt = crSoma.Qtds
            ENDIF

            *-- Total de paginas e atualizacoes finais do crCabecalho
            REPLACE QtdImpIte WITH loc_lnQtt, ;
                TotPag    WITH loc_lnPgn, ;
                Imagem    WITH THIS.this_cImgLogotipo, ;
                ImgTec    WITH THIS.this_cImgTecnicas, ;
                TotQtds   WITH loc_lnTQt IN crCabecalho

            *-- Totalizadores de Moedas (observacao de cotacoes)
            loc_lcObM = ''
            IF THIS.this_lChkObs
                IF INLIST(LocalOpe.Docus, 3, 6, 11)   && Fixo Horizontal e Vertical
                    SELECT crMoedas
                    SCAN
                        LOCAL loc_lnFtM
                        loc_lnFtM = crCabecalho.VlFretes
                        IF crCabecalho.Variacao <> 0
                            loc_lnFtM = loc_lnFtM + ;
                                (crCabecalho.Variacao * IIF(SUBSTR(crCabecalho.TipoVars, 1, 1) = 'D', -1, 1))
                        ENDIF
                        loc_lcObM = loc_lcObM + 'CT ' + ALLTRIM(crMoedas.CMoes) + ' : ' + ;
                            IIF(crMoedas.CotFpgs <> 1, ;
                                ALLTRIM(TRANSFORM(crMoedas.CotFpgs, '999,999.99')) + ' X ', ' ') + ;
                            ALLTRIM(TRANSFORM(crMoedas.Valos + loc_lnFtM, '999,999.99')) + ;
                            IIF(crMoedas.CotFpgs <> 1, ;
                                ' = (R$ ' + ALLTRIM(TRANSFORM((crMoedas.Valos + loc_lnFtM) * ;
                                crMoedas.CotFpgs, '999,999.99')) + ')', '') + CHR(13)
                    ENDSCAN
                ELSE
                    SELECT crMoedas
                    SCAN
                        loc_lnFtM = 0
                        IF crMoedas.CotFpgs <> 1 AND crCabecalho.VlFretes <> 0
                            loc_lnFtM = crCabecalho.VlFretes / crMoedas.CotFpgs
                        ENDIF
                        IF crCabecalho.Variacao <> 0
                            loc_lnFtM = loc_lnFtM + ;
                                ((crCabecalho.Variacao * IIF(SUBSTR(crCabecalho.TipoVars, 1, 1) = 'D', -1, 1)) / ;
                                IIF(crMoedas.CotFpgs = 0, 1, crMoedas.CotFpgs))
                        ENDIF
                        loc_lcObM = loc_lcObM + ALLTRIM(crMoedas.CMoes) + ' : ' + ;
                            ALLTRIM(TRANSFORM(crMoedas.Valos + loc_lnFtM, '999,999.99')) + ;
                            IIF(crMoedas.CotFpgs <> 1, ;
                                ' - (R$ ' + ALLTRIM(TRANSFORM(crMoedas.CotFpgs, '9,999.99')) + ')', '') + ;
                            CHR(13)
                    ENDSCAN
                ENDIF
            ENDIF
            REPLACE ObsMoes WITH loc_lcObM IN crCabecalho

            *-- Totalizador de Fatores
            IF crCabecalho.ImpFator
                loc_lcObM = ''
                SELECT crFatores
                SCAN
                    loc_lcObM = loc_lcObM + 'Fator ' + ALLTRIM(crFatores.Fator) + ' : ' + ;
                        ALLTRIM(TRANSFORM(crFatores.Totas, '999,999.99')) + CHR(13)
                ENDSCAN
                REPLACE ObsMoes WITH loc_lcObM IN crCabecalho
            ENDIF

            *-- Restaurar separadores para Locacao
            IF INLIST(LocalOpe.Docus, 8, 12)
                SET SEPARATOR TO (loc_lcSep)
                SET POINT TO (loc_lcPnt)
            ENDIF

            *-- Quantidade de Itens (DckNIte)
            IF LocalDCOpe.DckNIte = 1
                loc_lnCas  = IIF(LocalOpe2.CasQtds = 0, 3, LocalOpe2.CasQtds)
                loc_lcMask = '999999999' + IIF(loc_lnCas > 0, ;
                    '.' + REPLICATE('9', loc_lnCas), '')
                loc_lnSetAnt = SET("Decimals")
                SET DECIMALS TO MAX(loc_lnCas, 0)
                LOCAL loc_lcQtI
                loc_lcQtI = TRANSFORM(loc_lnQtI, RIGHT(loc_lcMask, 9))
                SET DECIMALS TO loc_lnSetAnt
                LOCAL loc_lcDIt
                loc_lcDIt = IIF(EMPTY(ALLTRIM(LocalDCOpe.DocNIte)), ;
                    'Qtde Itens', ALLTRIM(LocalDCOpe.DocNIte))
                REPLACE TotItens WITH loc_lcQtI, DesItens WITH loc_lcDIt IN crCabecalho
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em ProcessarRelatorio")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRelatorio - Executa REPORT FORM com base no tipo do documento
    * Equivalente ao metodo Visualizacao() do form legado
    * par_lPreview: .T. = PREVIEW, .F. = impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarRelatorio(par_lPreview)
        LOCAL loc_cFrx, loc_nVia, loc_nI, loc_cSep, loc_cPnt
        loc_cFrx  = ''
        loc_cSep  = ''
        loc_cPnt  = ''

        *-- Selecionar FRX com base no tipo de documento
        DO CASE
            CASE INLIST(LocalOpe.Docus, 3, 11)   && Fixo Horizontal
                IF LocalDcOpe.DckIcmIpi <> 6
                    loc_cFrx = "SigReIfx"
                ELSE
                    DELETE FROM crDados WHERE EMPTY(CPros)
                    loc_cFrx = "SigReHfi"
                ENDIF

            CASE LocalOpe.Docus = 6   && Fixo Vertical
                IF THIS.this_lChkImagem
                    loc_cFrx = IIF(LocalDcOpe.dckpeso = 1, "SigRevf5", "SigRevf6")
                ELSE
                    loc_cFrx = IIF(LocalDcOpe.dckpeso = 1, "SigRevf2", "SigRevfx")
                ENDIF

            CASE LocalOpe.Docus = 7   && Nota de Debito
                loc_cFrx = "SigRevf3"

            CASE INLIST(LocalOpe.Docus, 8, 12)   && Locacao
                loc_cSep = SET("Separator")
                loc_cPnt = SET("Point")
                SET SEPARATOR TO "."
                SET POINT TO ","
                loc_cFrx = IIF(LocalOpe.Docus = 8, "SigRevf4", "SigRevf0")

            CASE LocalOpe.Docus = 9   && Fixo Colunas
                IF LocalOpe2.DckViaResu <> 1
                    loc_cFrx = "SigRevfc"
                ENDIF

            CASE LocalOpe.Docus = 10  && Tres vias por pagina
                loc_cFrx = "SigRevfs"

            OTHERWISE
                loc_cFrx = "SigReIfi"
        ENDCASE

        *-- Executar relatorio principal
        IF !EMPTY(loc_cFrx)
            IF par_lPreview
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
            ELSE
                REPORT FORM (loc_cFrx) NOCONSOLE
            ENDIF
        ENDIF

        *-- Caso especial Docus=9 com grade de embalagens
        IF LocalOpe.Docus = 9 AND INT(VAL(SUBSTR(LocalOpe2.ConfigGers, 211, 01))) = 1
            IF USED('crCabecalho')
                SELECT crCabecalho
                GO TOP
            ENDIF
            IF par_lPreview
                REPORT FORM SigRevfc PREVIEW NOCONSOLE
            ELSE
                REPORT FORM SigRevfc NOCONSOLE
            ENDIF
        ENDIF

        *-- Restaurar separadores para Locacao
        IF INLIST(LocalOpe.Docus, 8, 12) AND !EMPTY(loc_cSep)
            SET SEPARATOR TO (loc_cSep)
            SET POINT TO (loc_cPnt)
        ENDIF

        *-- Termos e garantias
        IF LocalDcOpe.dckTermos = 1 AND LocalOpe.Docus <> 7
            loc_nVia = IIF(LocalDcOpe.ViaTermos > 0, LocalDcOpe.ViaTermos, 1)
            FOR loc_nI = 1 TO loc_nVia
                IF USED('crCabecalho')
                    SELECT crCabecalho
                    GO TOP
                ENDIF
                IF par_lPreview
                    REPORT FORM SigReIft PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM SigReIft NOCONSOLE
                ENDIF
            ENDFOR
        ENDIF

        *-- Duplicata (ImpDups = 3)
        IF LocalDcOpe.ImpDups = 3
            LOCAL loc_llImpDup
            loc_llImpDup = .F.
            IF USED('LocalPar')
                SELECT LocalPar
                SCAN
                    LOCAL loc_nResult4Dup
                    loc_nResult4Dup = SQLEXEC(gnConnHandle, ;
                        "SELECT ImpDups FROM SigOpFp WHERE Fpags = '" + ;
                        ALLTRIM(LocalPar.FPags) + "'", ;
                        "crSigOpFp")
                    IF loc_nResult4Dup < 1 OR EOF('crSigOpFp') OR crSigOpFp.ImpDups <> 1
                        DELETE
                    ELSE
                        loc_llImpDup = .T.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_llImpDup AND MsgConfirma("Confirma impress" + CHR(227) + ;
               "o da Duplicata ?(S/N)")
                IF USED('crCabecalho')
                    SELECT crCabecalho
                    GO TOP
                ENDIF
                IF USED('LocalPar')
                    SELECT LocalPar
                    GO TOP
                ENDIF
                IF par_lPreview
                    REPORT FORM SigReDpc PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM SigReDpc NOCONSOLE
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSGrus - Carrega descricao do sub-grupo para nota de debito
    * Equivalente ao metodo carregasgrus() do form legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarSGrus(par_cPro)
        LOCAL loc_nResult
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT b.Descricaos " + ;
            "FROM SigCdPro a, SigCdPsg b " + ;
            "WHERE a.Cpros = '" + ALLTRIM(par_cPro) + "' " + ;
            "AND a.CGrus = b.CGrus AND a.SGrus = b.Codigos", ;
            "LocalSgru")
        IF loc_nResult >= 1
            GO TOP IN LocalSgru
            IF !EOF('LocalSgru')
                REPLACE DescSgrus WITH LocalSgru.Descricaos IN crDados
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DocumentoExcel - Exporta dados para cursor de Excel
    * Equivalente ao metodo DocumentoExcel() do form legado
    *--------------------------------------------------------------------------
    PROCEDURE DocumentoExcel()
        SELECT CItens AS Itens, CPros AS Produtos, Reffs AS Referencia, ;
            PADR(DPros, 254) AS Descricao, CUnis AS Uni, Qtds, ;
            Units AS Unitario, Moedas AS Moeda, Totas AS Total, ;
            Aliqs AS Aliquota, ValIpis AS Ipis, Obs ;
        FROM crDados ;
        WHERE !EMPTY(CPros) ;
        INTO CURSOR crExcel

        GO TOP IN crExcel
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos e arquivos temporarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_cArq

        *-- Remover arquivos de imagem temporarios
        loc_cArq = ALLTRIM(THIS.this_cImgBranco)
        IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
            DELETE FILE (loc_cArq)
        ENDIF

        loc_cArq = ALLTRIM(THIS.this_cImgLogotipo)
        IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
            DELETE FILE (loc_cArq)
        ENDIF

        loc_cArq = ALLTRIM(THIS.this_cImgTecnicas)
        IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
            DELETE FILE (loc_cArq)
        ENDIF

        *-- Fechar cursores de dados
        LOCAL loc_asCursores(20), loc_nI
        loc_asCursores(1)  = "LocalOpe"
        loc_asCursores(2)  = "LocalOpe2"
        loc_asCursores(3)  = "LocalDcOpe"
        loc_asCursores(4)  = "LocalOpCdi"
        loc_asCursores(5)  = "LocalParam"
        loc_asCursores(6)  = "LocalEmp"
        loc_asCursores(7)  = "LocalEest"
        loc_asCursores(8)  = "LocalEestI"
        loc_asCursores(9)  = "LocalEestIE"
        loc_asCursores(10) = "LocalEstI2"
        loc_asCursores(11) = "LocalNFis"
        loc_asCursores(12) = "LocalPar"
        loc_asCursores(13) = "LocalPar1"
        loc_asCursores(14) = "LocalTra"
        loc_asCursores(15) = "crCabecalho"
        loc_asCursores(16) = "crDados"
        loc_asCursores(17) = "crMoedas"
        loc_asCursores(18) = "crFatores"
        loc_asCursores(19) = "xTotEmb"
        loc_asCursores(20) = "csBranco"

        FOR loc_nI = 1 TO 20
            IF USED(loc_asCursores(loc_nI))
                USE IN (loc_asCursores(loc_nI))
            ENDIF
        ENDFOR

        SET POINT TO "."
        SET SEPARATOR TO ","

        DODEFAULT()
    ENDPROC

ENDDEFINE
