*==============================================================================
* SigPrIbbBO.prg - Business Object para Impressao de Boleto Bancario
* Herda de: BusinessBase
* Form correspondente: FormSigPrIbb.prg
* Tabela principal: SigMvCab / SigMvPar
* Tipo: OPERACIONAL (recebe EmpDopNum como parametro)
*==============================================================================
DEFINE CLASS SigPrIbbBO AS BusinessBase

    *-- Chave composta da movimentacao (PADR(pEdn, 29))
    *-- Emps[1-3] + Dopes[4-23] + Numes[24-29]
    this_cEmpDopNum = ""
    this_cEmps      = ""
    this_cDopes     = ""
    this_cNumes     = ""

    *-- Total das parcelas calculado em SelecionarDados
    this_nTotal     = 0

    *==========================================================================
    * Init - Configura tabela e chave para BusinessBase
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave do registro corrente
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNum
    ENDPROC

    *==========================================================================
    * InicializarCursores - Cria estrutura dos cursores de trabalho (from Load)
    * cursor_4c_Grade: usado como RecordSource do grid no form
    * crDados / TmpImprime: mantidos com nomes legados para compatibilidade SigPrIbl
    *==========================================================================
    PROCEDURE InicializarCursores()
        SET NULL ON

        CREATE CURSOR cursor_4c_Grade ;
            (FPags C(12), Parcs N(2), CLocals C(100), ;
             Vencs D(8), Datas D(8), Valos N(12,2), CTxtCds M(4))

        CREATE CURSOR crDados ;
            (CLocals C(100), Vencs C(12), DatDoc D(8), ;
             NumDoc C(8), Valor N(14,2), Razaos C(50), Cpfs C(20), ;
             EndCobs C(80), BaiCobs C(20), CidCobs C(20), EstCobs C(2), ;
             CepCobs C(9), Texto M)

        CREATE CURSOR TmpImprime ;
            (Linha N(6,2), Coluna N(6,2), Conteudo C(100), Style C(3), ;
             FontName C(64), FontSize I, LineSize N(6,2), NHeight N(6,2))

        SET NULL OFF
        INDEX ON (Linha * 1000000000) + (Coluna * 100) TAG Ordem
    ENDPROC

    *==========================================================================
    * SelecionarDados - Carrega parcelas com boleto ativo (from selecionadados)
    *==========================================================================
    PROCEDURE SelecionarDados(par_cEmpDopNum)
        LOCAL loc_lSucesso, loc_nTot, loc_cSQL, loc_cSQLCfg
        LOCAL loc_cFPags, loc_nParcs, loc_nValos, loc_dVencs, loc_dDatas
        LOCAL loc_cLocals, loc_cTxtCds, loc_lAchCfg
        loc_lSucesso = .T.
        loc_nTot     = 0

        TRY
            IF USED("cursor_4c_Grade")
                SELECT cursor_4c_Grade
                ZAP
            ENDIF

            loc_cSQL = "SELECT b.FPags, b.Parcs, b.Vencs, b.Datas, b.Valos " + ;
                       "FROM SigMvCab a, SigMvPar b, SigCdOpe c, SigOpCdc d, SigOpFp e " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNum) + ;
                       " AND a.EmpDopNums = b.EmpDopNums" + ;
                       " AND b.Dopes = c.Dopes" + ;
                       " AND c.Dopes = d.Dopes" + ;
                       " AND d.ImpBols = 1" + ;
                       " AND b.FPags = e.FPags" + ;
                       " AND e.ImpBols = 1" + ;
                       " ORDER BY b.FPags, b.Parcs"

            IF USED("cursor_4c_SelTemp")
                USE IN cursor_4c_SelTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SelTemp") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE
                GO TOP IN cursor_4c_SelTemp

                DO WHILE !EOF("cursor_4c_SelTemp")
                    SELECT cursor_4c_SelTemp
                    loc_cFPags = cursor_4c_SelTemp.FPags
                    loc_nParcs = cursor_4c_SelTemp.Parcs
                    loc_nValos = cursor_4c_SelTemp.Valos

                    IF TYPE("cursor_4c_SelTemp.Vencs") == "T"
                        loc_dVencs = TTOD(NVL(cursor_4c_SelTemp.Vencs, CTOT("")))
                    ELSE
                        loc_dVencs = NVL(cursor_4c_SelTemp.Vencs, {})
                    ENDIF

                    IF TYPE("cursor_4c_SelTemp.Datas") == "T"
                        loc_dDatas = TTOD(NVL(cursor_4c_SelTemp.Datas, CTOT("")))
                    ELSE
                        loc_dDatas = NVL(cursor_4c_SelTemp.Datas, {})
                    ENDIF

                    *-- Busca configuracao de boleto para esta forma de pagamento
                    loc_lAchCfg = .F.
                    loc_cSQLCfg = "SELECT CLocals, CTxtCds FROM SigCnFBl WHERE FPags = " + ;
                                  EscaparSQL(loc_cFPags)

                    IF USED("cursor_4c_CfgTemp")
                        USE IN cursor_4c_CfgTemp
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQLCfg, "cursor_4c_CfgTemp") > 0 AND ;
                       USED("cursor_4c_CfgTemp") AND !EOF("cursor_4c_CfgTemp")
                        loc_cLocals = NVL(cursor_4c_CfgTemp.CLocals, "")
                        loc_cTxtCds = NVL(cursor_4c_CfgTemp.CTxtCds, "")
                        loc_lAchCfg = .T.
                    ELSE
                        *-- Fallback: configuracao padrao (FPags = espacos)
                        IF USED("cursor_4c_CfgTemp")
                            USE IN cursor_4c_CfgTemp
                        ENDIF
                        loc_cSQLCfg = "SELECT CLocals, CTxtCds FROM SigCnFBl WHERE FPags = " + ;
                                      EscaparSQL(SPACE(12))
                        IF SQLEXEC(gnConnHandle, loc_cSQLCfg, "cursor_4c_CfgTemp") > 0 AND ;
                           USED("cursor_4c_CfgTemp") AND !EOF("cursor_4c_CfgTemp")
                            loc_cLocals = NVL(cursor_4c_CfgTemp.CLocals, "")
                            loc_cTxtCds = NVL(cursor_4c_CfgTemp.CTxtCds, "")
                            loc_lAchCfg = .T.
                        ENDIF
                    ENDIF

                    IF loc_lAchCfg
                        SELECT cursor_4c_Grade
                        INSERT INTO cursor_4c_Grade ;
                            (FPags, Parcs, Vencs, Datas, Valos, CLocals, CTxtCds) ;
                            VALUES (m.loc_cFPags, m.loc_nParcs, m.loc_dVencs, m.loc_dDatas, ;
                                    m.loc_nValos, m.loc_cLocals, m.loc_cTxtCds)
                        loc_nTot = loc_nTot + loc_nValos
                    ENDIF

                    IF USED("cursor_4c_CfgTemp")
                        USE IN cursor_4c_CfgTemp
                    ENDIF

                    SKIP IN cursor_4c_SelTemp
                ENDDO

                GO TOP IN cursor_4c_Grade
                THIS.this_nTotal = loc_nTot

                IF USED("cursor_4c_SelTemp")
                    USE IN cursor_4c_SelTemp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro SelecionarDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Detalhe - Insere registro de impressao em TmpImprime (from detalhe)
    * par_cDet: expressao VFP string avaliada por SigPrIbl na impressao
    * par_cEst: "*" para pular / outro valor para inserir
    *==========================================================================
    PROCEDURE Detalhe(par_nLin, par_nCol, par_cDet, par_cEst, par_nTam, par_nAlt)
        LOCAL loc_nLin, loc_nCol, loc_cDet, loc_cEst

        loc_nLin = IIF(TYPE("par_nLin") == "N", par_nLin, 0)
        loc_nCol = IIF(TYPE("par_nCol") == "N", par_nCol, 0)
        loc_cDet = IIF(TYPE("par_cDet") == "C", par_cDet, "")
        loc_cEst = IIF(TYPE("par_cEst") == "C", ALLTRIM(par_cEst), "X")

        IF !loc_cEst = "*" AND (loc_nCol <> 0 OR loc_nLin <> 0)
            SELECT TmpImprime
            INSERT INTO TmpImprime (Linha, Coluna, Conteudo, Style, LineSize, NHeight) ;
                VALUES (m.loc_nLin, m.loc_nCol, m.loc_cDet, m.loc_cEst, par_nTam, par_nAlt)
        ENDIF
    ENDPROC

    *==========================================================================
    * Imprimir - Processa e imprime boleto bancario da parcela corrente (from imprimir)
    * Fluxo: busca cab -> NF -> operacao -> cliente -> forma pgto
    *        -> atualiza SigCnFBl -> verifica impressora -> monta TmpImprime
    *        -> chama SigPrIbl (programa legado de impressao de boleto)
    *==========================================================================
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        LOCAL loc_cFPags, loc_nParcs, loc_cDoc, loc_ldVct
        LOCAL loc_cDopes, loc_cContaOs, loc_cContaDs, loc_cCli
        LOCAL loc_lNfiscal, loc_lImpNotas, loc_lImp, loc_nCnt
        LOCAL loc_cCLocals, loc_cCTxtCds, loc_cNomeImp, loc_cQuery
        LOCAL loc_nTm1, loc_nTm2, loc_nTam, loc_cCTamFolha
        LOCAL loc_dVencs, loc_dDatas, loc_nValos
        loc_lSucesso = .T.

        TRY
            *-- Limpa cursores de trabalho
            IF USED("crDados")
                SELECT crDados
                ZAP
            ENDIF
            IF USED("TmpImprime")
                SELECT TmpImprime
                ZAP
            ENDIF

            *-- Guarda parcela corrente antes de qualquer SELECT
            SELECT cursor_4c_Grade
            loc_cFPags  = cursor_4c_Grade.FPags
            loc_nParcs  = cursor_4c_Grade.Parcs
            loc_dVencs  = cursor_4c_Grade.Vencs
            loc_dDatas  = cursor_4c_Grade.Datas
            loc_nValos  = cursor_4c_Grade.Valos
            loc_cCLocals = NVL(cursor_4c_Grade.CLocals, "")
            loc_cCTxtCds = NVL(cursor_4c_Grade.CTxtCds, "")

            *-- 1. Busca cabecalho da movimentacao
            IF USED("cursor_4c_TmpMvCab")
                USE IN cursor_4c_TmpMvCab
            ENDIF

            LOCAL loc_cSQLMvCab
            loc_cSQLMvCab = "SELECT Dopes, ContaOs, ContaDs FROM SigMvCab " + ;
                            "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNum)

            IF SQLEXEC(gnConnHandle, loc_cSQLMvCab, "cursor_4c_TmpMvCab") < 1 OR ;
               !USED("cursor_4c_TmpMvCab") OR EOF("cursor_4c_TmpMvCab")
                MsgErro("Movimenta" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                        "o Encontrada!!!", "Inconsist" + CHR(234) + "ncia Nos Dados")
                loc_lSucesso = .F.
            ELSE
                loc_cDopes   = ALLTRIM(cursor_4c_TmpMvCab.Dopes)
                loc_cContaOs = ALLTRIM(cursor_4c_TmpMvCab.ContaOs)
                loc_cContaDs = ALLTRIM(cursor_4c_TmpMvCab.ContaDs)
                USE IN cursor_4c_TmpMvCab
            ENDIF

            IF loc_lSucesso
                *-- 2. Numero do documento (NF + parcela ou so parcela)
                loc_cDoc = "Parc.: " + ALLTRIM(STR(loc_nParcs, 2))

                IF USED("cursor_4c_TmpNfis")
                    USE IN cursor_4c_TmpNfis
                ENDIF

                LOCAL loc_cSQLNfi
                loc_cSQLNfi = "SELECT NFis FROM SigMvNfi WHERE EmpDopNums = " + ;
                              EscaparSQL(THIS.this_cEmpDopNum)

                IF SQLEXEC(gnConnHandle, loc_cSQLNfi, "cursor_4c_TmpNfis") > 0 AND ;
                   USED("cursor_4c_TmpNfis") AND !EOF("cursor_4c_TmpNfis")
                    loc_cDoc = ALLTRIM(cursor_4c_TmpNfis.NFis) + "-" + ;
                               ALLTRIM(STR(loc_nParcs, 2))
                ENDIF

                IF USED("cursor_4c_TmpNfis")
                    USE IN cursor_4c_TmpNfis
                ENDIF

                *-- 3. Busca operacao para saber se NF fiscal (Nfiscals)
                IF USED("cursor_4c_TmpOpe")
                    USE IN cursor_4c_TmpOpe
                ENDIF

                LOCAL loc_cSQLOpe
                loc_cSQLOpe = "SELECT Nfiscals FROM SigCdOpe WHERE Dopes = " + ;
                              EscaparSQL(loc_cDopes)
                loc_lNfiscal = 0

                IF SQLEXEC(gnConnHandle, loc_cSQLOpe, "cursor_4c_TmpOpe") < 1 OR ;
                   !USED("cursor_4c_TmpOpe") OR EOF("cursor_4c_TmpOpe")
                    MsgErro("Opera" + CHR(231) + CHR(227) + "o N" + CHR(227) + ;
                            "o Encontrada!!!", "Inconsist" + CHR(234) + "ncia Nos Dados")
                    loc_lSucesso = .F.
                ELSE
                    loc_lNfiscal = NVL(cursor_4c_TmpOpe.Nfiscals, 0)
                    USE IN cursor_4c_TmpOpe
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 4. Determina conta do cliente (ContaOs para NF fiscal, ContaDs para demais)
                loc_cCli = IIF(loc_lNfiscal = 1, loc_cContaOs, loc_cContaDs)

                *-- 5. Busca dados do cliente
                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF

                LOCAL loc_cSQLCli
                loc_cSQLCli = "SELECT Razaos, Cpfs, EndCobs, Endes, BaiCobs, Bairs, " + ;
                              "CidCobs, Cidas, EstCobs, Estas, CepCobs, Ceps " + ;
                              "FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCli)

                IF SQLEXEC(gnConnHandle, loc_cSQLCli, "cursor_4c_TmpCli") < 1 OR ;
                   !USED("cursor_4c_TmpCli") OR EOF("cursor_4c_TmpCli")
                    MsgErro("Conta '" + loc_cCli + "' N" + CHR(227) + ;
                            "o Encontrada!!!", "Inconsist" + CHR(234) + "ncia Nos Dados")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 6. Busca forma de pagamento para saber se usa data real (ImpNotas)
                IF USED("cursor_4c_TmpFpag")
                    USE IN cursor_4c_TmpFpag
                ENDIF

                LOCAL loc_cSQLFpag
                loc_cSQLFpag = "SELECT ImpBols, ImpNotas FROM SigOpFp WHERE FPags = " + ;
                               EscaparSQL(loc_cFPags)
                loc_lImpNotas = 0

                IF SQLEXEC(gnConnHandle, loc_cSQLFpag, "cursor_4c_TmpFpag") < 1 OR ;
                   !USED("cursor_4c_TmpFpag") OR EOF("cursor_4c_TmpFpag")
                    MsgErro("Forma de Pagamento N" + CHR(227) + "o Encontrada!!!", ;
                            "Inconsist" + CHR(234) + "ncia Nos Dados")
                    loc_lSucesso = .F.
                ELSE
                    loc_lImpNotas = NVL(cursor_4c_TmpFpag.ImpNotas, 0)
                    USE IN cursor_4c_TmpFpag
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 7. Salva CLocals e CTxtCds editados na configuracao de boleto
                loc_cQuery = "UPDATE SigCnFBl " + ;
                             "SET CLocals = " + EscaparSQL(loc_cCLocals) + ", " + ;
                                 "CTxtCds = " + EscaparSQL(loc_cCTxtCds) + " " + ;
                             "WHERE FPags = " + EscaparSQL(loc_cFPags)

                IF SQLEXEC(gnConnHandle, loc_cQuery) < 1
                    MsgErro("A Configura" + CHR(231) + CHR(227) + ;
                            "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + ;
                            "o Pode Ser Atualizada!!!", ;
                            "Condi" + CHR(231) + CHR(227) + "o: " + ALLTRIM(loc_cFPags))
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 8. Busca configuracao completa de boleto (posicoes de impressao)
                IF USED("cursor_4c_CfgBl")
                    USE IN cursor_4c_CfgBl
                ENDIF

                LOCAL loc_cSQLCfgBl
                loc_cSQLCfgBl = "SELECT * FROM SigCnFBl WHERE FPags = " + ;
                                EscaparSQL(loc_cFPags)

                IF SQLEXEC(gnConnHandle, loc_cSQLCfgBl, "cursor_4c_CfgBl") < 1 OR ;
                   !USED("cursor_4c_CfgBl") OR EOF("cursor_4c_CfgBl")
                    *-- Fallback: configuracao padrao
                    IF USED("cursor_4c_CfgBl")
                        USE IN cursor_4c_CfgBl
                    ENDIF
                    loc_cSQLCfgBl = "SELECT * FROM SigCnFBl WHERE FPags = " + ;
                                    EscaparSQL(SPACE(12))
                    SQLEXEC(gnConnHandle, loc_cSQLCfgBl, "cursor_4c_CfgBl")
                ENDIF

                IF !USED("cursor_4c_CfgBl") OR EOF("cursor_4c_CfgBl")
                    MsgErro("Configura" + CHR(231) + CHR(227) + ;
                            "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + ;
                            "o Encontrada!!!", ;
                            "Condi" + CHR(231) + CHR(227) + "o: " + ALLTRIM(loc_cFPags))
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 9. Verifica se a impressora configurada esta disponivel
                LOCAL ARRAY loc_laPrn(1)
                loc_lImp     = .F.
                loc_cNomeImp = ALLTRIM(cursor_4c_CfgBl.CNomeImps)

                IF APRINTERS(loc_laPrn) > 0
                    FOR loc_nCnt = 1 TO ALEN(loc_laPrn, 1)
                        IF UPPER(ALLTRIM(loc_laPrn(loc_nCnt, 1))) = UPPER(loc_cNomeImp)
                            loc_lImp = .T.
                            loc_nCnt = ALEN(loc_laPrn, 1) + 1
                        ENDIF
                    ENDFOR
                ENDIF

                IF !loc_lImp
                    MsgErro("Impressora '" + loc_cNomeImp + ;
                            "' de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + ;
                            "o Encontrada!!!", ;
                            "Condi" + CHR(231) + CHR(227) + "o: " + ALLTRIM(loc_cFPags))
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                *-- 10. Determina representacao da data de vencimento
                *--     ImpNotas=1 -> data real DTOC / senao -> codigo FPags
                loc_ldVct = IIF(loc_lImpNotas = 1, DTOC(loc_dVencs), ALLTRIM(loc_cFPags))

                *-- 11. Coleta dados do cliente e insere em crDados
                LOCAL loc_cRazaos, loc_cCpfs
                LOCAL loc_cEndCobs, loc_cEndes, loc_cBaiCobs, loc_cBairs
                LOCAL loc_cCidCobs, loc_cCidas, loc_cEstCobs, loc_cEstas
                LOCAL loc_cCepCobs, loc_cCeps

                SELECT cursor_4c_TmpCli
                loc_cRazaos  = ALLTRIM(NVL(cursor_4c_TmpCli.Razaos,  ""))
                loc_cCpfs    = ALLTRIM(NVL(cursor_4c_TmpCli.Cpfs,    ""))
                loc_cEndCobs = ALLTRIM(NVL(cursor_4c_TmpCli.EndCobs, ""))
                loc_cEndes   = ALLTRIM(NVL(cursor_4c_TmpCli.Endes,   ""))
                loc_cBaiCobs = ALLTRIM(NVL(cursor_4c_TmpCli.BaiCobs, ""))
                loc_cBairs   = ALLTRIM(NVL(cursor_4c_TmpCli.Bairs,   ""))
                loc_cCidCobs = ALLTRIM(NVL(cursor_4c_TmpCli.CidCobs, ""))
                loc_cCidas   = ALLTRIM(NVL(cursor_4c_TmpCli.Cidas,   ""))
                loc_cEstCobs = ALLTRIM(NVL(cursor_4c_TmpCli.EstCobs, ""))
                loc_cEstas   = ALLTRIM(NVL(cursor_4c_TmpCli.Estas,   ""))
                loc_cCepCobs = ALLTRIM(NVL(cursor_4c_TmpCli.CepCobs, ""))
                loc_cCeps    = ALLTRIM(NVL(cursor_4c_TmpCli.Ceps,    ""))
                USE IN cursor_4c_TmpCli

                SELECT crDados
                ZAP
                INSERT INTO crDados ;
                    (CLocals, Vencs, DatDoc, NumDoc, Valor, ;
                     Razaos, Cpfs, Texto, EndCobs, BaiCobs, CidCobs, EstCobs, CepCobs) ;
                    VALUES (m.loc_cCLocals, m.loc_ldVct, m.loc_dDatas, m.loc_cDoc, ;
                            m.loc_nValos, m.loc_cRazaos, m.loc_cCpfs, m.loc_cCTxtCds, ;
                            IIF(!EMPTY(m.loc_cEndCobs), m.loc_cEndCobs, m.loc_cEndes), ;
                            IIF(!EMPTY(m.loc_cBaiCobs), m.loc_cBaiCobs, m.loc_cBairs), ;
                            IIF(!EMPTY(m.loc_cCidCobs), m.loc_cCidCobs, m.loc_cCidas), ;
                            IIF(!EMPTY(m.loc_cEstCobs), m.loc_cEstCobs, m.loc_cEstas), ;
                            IIF(!EMPTY(m.loc_cCepCobs), m.loc_cCepCobs, m.loc_cCeps))

                *-- 12. L? posicoes de impressao da configuracao de boleto
                LOCAL loc_nLnLocals,  loc_nClLocals
                LOCAL loc_nLnDtVencs, loc_nClDtVencs
                LOCAL loc_nLnDtDocs,  loc_nClDtDocs
                LOCAL loc_nLnNrDocs,  loc_nClNrDocs
                LOCAL loc_nLnVlDocs,  loc_nClVlDocs
                LOCAL loc_nLnRazClis, loc_nClRazClis
                LOCAL loc_nLnCgcClis, loc_nClCgcClis
                LOCAL loc_nLnEndCobs, loc_nClEndCobs
                LOCAL loc_nLnBaiCobs, loc_nClBaiCobs
                LOCAL loc_nLnCidCobs, loc_nClCidCobs
                LOCAL loc_nLnEstCobs, loc_nClEstCobs
                LOCAL loc_nLnCepCobs, loc_nClCepCobs
                LOCAL loc_nLntxtcds,  loc_nCltxtcds

                SELECT cursor_4c_CfgBl
                loc_nLnLocals  = cursor_4c_CfgBl.nLnLocals
                loc_nClLocals  = cursor_4c_CfgBl.nClLocals
                loc_nLnDtVencs = cursor_4c_CfgBl.nLnDtVencs
                loc_nClDtVencs = cursor_4c_CfgBl.nClDtVencs
                loc_nLnDtDocs  = cursor_4c_CfgBl.nLnDtDocs
                loc_nClDtDocs  = cursor_4c_CfgBl.nClDtDocs
                loc_nLnNrDocs  = cursor_4c_CfgBl.nLnNrDocs
                loc_nClNrDocs  = cursor_4c_CfgBl.nClNrDocs
                loc_nLnVlDocs  = cursor_4c_CfgBl.nLnVlDocs
                loc_nClVlDocs  = cursor_4c_CfgBl.nClVlDocs
                loc_nLnRazClis = cursor_4c_CfgBl.nLnRazClis
                loc_nClRazClis = cursor_4c_CfgBl.nClRazClis
                loc_nLnCgcClis = cursor_4c_CfgBl.nLnCgcClis
                loc_nClCgcClis = cursor_4c_CfgBl.nClCgcClis
                loc_nLnEndCobs = cursor_4c_CfgBl.nLnEndCobs
                loc_nClEndCobs = cursor_4c_CfgBl.nClEndCobs
                loc_nLnBaiCobs = cursor_4c_CfgBl.nLnBaiCobs
                loc_nClBaiCobs = cursor_4c_CfgBl.nClBaiCobs
                loc_nLnCidCobs = cursor_4c_CfgBl.nLnCidCobs
                loc_nClCidCobs = cursor_4c_CfgBl.nClCidCobs
                loc_nLnEstCobs = cursor_4c_CfgBl.nLnEstCobs
                loc_nClEstCobs = cursor_4c_CfgBl.nClEstCobs
                loc_nLnCepCobs = cursor_4c_CfgBl.nLnCepCobs
                loc_nClCepCobs = cursor_4c_CfgBl.nClCepCobs
                loc_nLntxtcds  = cursor_4c_CfgBl.nLntxtcds
                loc_nCltxtcds  = cursor_4c_CfgBl.nCltxtcds
                loc_cCTamFolha = cursor_4c_CfgBl.CTamFolha
                USE IN cursor_4c_CfgBl

                *-- 13. Monta linhas de impressao em TmpImprime
                *--     Conteudo armazena expressoes VFP avaliadas por SigPrIbl
                THIS.Detalhe(loc_nLnLocals,  loc_nClLocals,  "crDados.CLocals",                "", 60, 1)
                THIS.Detalhe(loc_nLnDtVencs, loc_nClDtVencs, "crDados.Vencs",                  "", 9,  1)
                THIS.Detalhe(loc_nLnDtDocs,  loc_nClDtDocs,  "Dtoc(crDados.DatDoc)",            "", 9,  1)
                THIS.Detalhe(loc_nLnNrDocs,  loc_nClNrDocs,  "crDados.NumDoc",                  "", 9,  1)
                THIS.Detalhe(loc_nLnVlDocs,  loc_nClVlDocs,  ;
                    "Transform(crDados.Valor,'@Z 999,999,999.99')",                               "", 15, 1)
                THIS.Detalhe(loc_nLnRazClis, loc_nClRazClis, "Alltrim(crDados.Razaos)",          "", 50, 1)
                THIS.Detalhe(loc_nLnCgcClis, loc_nClCgcClis, "Alltrim(crDados.Cpfs)",            "", 20, 1)
                THIS.Detalhe(loc_nLnEndCobs, loc_nClEndCobs, "Alltrim(crDados.EndCobs)",         "", 80, 1)
                THIS.Detalhe(loc_nLnBaiCobs, loc_nClBaiCobs, "Alltrim(crDados.BaiCobs)",         "", 20, 1)
                THIS.Detalhe(loc_nLnCidCobs, loc_nClCidCobs, "Alltrim(crDados.CidCobs)",         "", 20, 1)
                THIS.Detalhe(loc_nLnEstCobs, loc_nClEstCobs, "Alltrim(crDados.EstCobs)",         "", 2,  1)
                THIS.Detalhe(loc_nLnCepCobs, loc_nClCepCobs, "Alltrim(crDados.CepCobs)",         "", 9,  1)
                THIS.Detalhe(loc_nLntxtcds,  loc_nCltxtcds,  "crDados.Texto",                    "", 60, 6)

                *-- 14. Calcula tamanho do papel a partir de CTamFolha (ex: "A4/210/297")
                loc_nTm1 = AT("/", loc_cCTamFolha, 1) + 1
                loc_nTm2 = AT("/", loc_cCTamFolha, 2) - (AT("/", loc_cCTamFolha, 1) + 1)
                loc_nTam = VAL(ALLTRIM(SUBSTR(loc_cCTamFolha, loc_nTm1, loc_nTm2)))

                *-- 15. Executa impressao via SigPrIbl (programa legado de boleto bancario)
                DO SigPrIbl WITH "TmpImprime", loc_cNomeImp, ;
                                 "To Printer NoConsole", 0, loc_nTam, 0, 0, ;
                                 "crDados", 17
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro Imprimir Boleto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Registra impressao de um novo boleto bancario
    * Semantica OPERACIONAL: cada boleto impresso equivale a uma "insercao"
    * de operacao de cobranca. Chama Imprimir() e registra auditoria PRINT.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpDopNum)
                THIS.this_cMensagemErro = "Movimenta" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o selecionada"
                loc_lSucesso = .F.
            ELSE
                IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade") OR ;
                   RECCOUNT("cursor_4c_Grade") = 0
                    THIS.this_cMensagemErro = "Nenhuma parcela dispon" + CHR(237) + ;
                        "vel para impress" + CHR(227) + "o"
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = THIS.Imprimir()

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("PRINT")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Inserir Boleto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Persiste alteracoes de Local de Pagamento e Texto do Cedente
    * na configuracao de boleto (SigCnFBl) para a parcela corrente do grid.
    * Chamado antes da impressao para salvar edicoes do usuario nos EditBoxes
    * getLocals e getTxtCds do form.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cFPags, loc_cCLocals, loc_cCTxtCds, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Grade") OR EOF("cursor_4c_Grade")
                THIS.this_cMensagemErro = "Nenhuma parcela selecionada"
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Grade
            loc_cFPags   = ALLTRIM(NVL(cursor_4c_Grade.FPags,   ""))
            loc_cCLocals = NVL(cursor_4c_Grade.CLocals, "")
            loc_cCTxtCds = NVL(cursor_4c_Grade.CTxtCds, "")

            IF EMPTY(loc_cFPags)
                THIS.this_cMensagemErro = "Forma de pagamento inv" + CHR(225) + "lida"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCnFBl " + ;
                       "SET CLocals = " + EscaparSQL(loc_cCLocals) + ", " + ;
                           "CTxtCds = " + EscaparSQL(loc_cCTxtCds) + " " + ;
                       "WHERE FPags = " + EscaparSQL(loc_cFPags)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                THIS.this_cMensagemErro = "A Configura" + CHR(231) + CHR(227) + ;
                    "o de Boleto Banc" + CHR(225) + "rio N" + CHR(227) + ;
                    "o Pode Ser Atualizada!!!"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro Atualizar SigCnFBl")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO com EmpDopNum do cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cEdn
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                loc_cEdn = PADR(ALLTRIM(NVL(EmpDopNums, "")), 29)
                THIS.this_cEmpDopNum = loc_cEdn
                THIS.this_cEmps      = ALLTRIM(SUBSTR(loc_cEdn, 1,  3))
                THIS.this_cDopes     = ALLTRIM(SUBSTR(loc_cEdn, 4,  20))
                THIS.this_cNumes     = ALLTRIM(SUBSTR(loc_cEdn, 24, 6))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
