*==============================================================================
* SigReIdtBO.prg
* Business Object para Relatorio de Documento de Titulo
*
* Herda de RelatorioBase
* Form original: SIGREIDT (frmrelatorio)
* Reports: SigReIdt.frx, SigReIdA.frx, SigReIag.frx
*==============================================================================

DEFINE CLASS SigReIdtBO AS RelatorioBase

    *-- Parametros do relatorio (definidos pelo form via FormParaRelatorio)
    this_cEmps       = ""   && Codigo da empresa (3 chars, ex: "001")
    this_cDopes      = ""   && Operacao/documento (20 chars padded)
    this_cNumes      = ""   && Numero do titulo
    this_nNumef      = 0    && Numero fiscal (numerico - Numef no original)
    this_cDiretorio  = ""   && Diretorio de saida opcional (pcDiretorio)
    this_cDirFiscais = ""   && Diretorio fiscal (goSistema.DirFiscais)

    *-- Opcoes de impressao (mapeados dos OptionGroups do form)
    *   this_nOptTipo:   1=Titulo, 2=Autorizacao de Gasto (default=2)
    *   this_nOptAgrupa: 1=Sim, 2=Agrupada, 3=Nenhum (default=3)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Controle interno carregado de SigCdPam (GrupoRecs/GrupoPags, ContaRecs/ContaPags)
    this_cContaTran  = ""
    this_cGrupoTran  = ""

    *-- Nome do cursor principal do relatorio (referenciado pelos FRX)
    this_cCursorDados = "crDBImp"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara dados do relatorio de documento de titulo
    * Logica original: PROCEDURE processamento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cTabMov, loc_cSinalOper, loc_cEDNE
        LOCAL loc_cObs, loc_nRecor, loc_nReg
        LOCAL loc_laTitulo, loc_lnTotVal
        LOCAL loc_cTxt01, loc_cTxt02, loc_cTxt03, loc_cTxt04
        LOCAL loc_cRclis1, loc_cRclis2, loc_cRclis3, loc_cRclis4
        LOCAL loc_cCpfs2, loc_cContaLkp
        LOCAL loc_cGrupoPortador, loc_cContaPortador
        LOCAL loc_cObsd, loc_cHists, loc_cOpersFiltro

        loc_lSucesso = .F.
        TRY
            *-- 1. Carregar dados da empresa
            loc_cSQL = "SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Emps = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                THROW
            ENDIF
            SELECT cursor_4c_LocalEmp
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(THIS.this_cEmps)
                THROW
            ENDIF

            *-- 2. Criar cursor de cabecalho do relatorio (csCabecalho - referenciado pelos FRX)
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa c(80), Titulo c(80))
            SELECT csCabecalho
            APPEND BLANK
            REPLACE Empresa WITH ALLTRIM(THIS.this_cEmps) + " - " + ALLTRIM(cursor_4c_LocalEmp.RazSocs)
            REPLACE Titulo  WITH PADR(ALLTRIM(THIS.this_cDopes), 20)

            *-- 3. Criar cursor principal de impressao (crDBImp - referenciado pelos FRX)
            IF USED("crDBImp")
                USE IN crDBImp
            ENDIF
            CREATE CURSOR crDBImp (;
                Emps c(3), RazSocs c(50), Titulo c(10), Nfs c(10), DtMovs d, ;
                Txt01 c(20), GrupEm c(10), Contem c(10), dContem c(50), ;
                Txt02 c(20), Grupo c(10), Conta c(10), dConta c(50), cpfs c(20), ;
                Txt03 c(20), sGrupos c(10), sContas c(10), sdConta c(50), Obsc c(50), Valorc n(12,2), ;
                Txt04 c(20), Gruage c(10), contag c(10), dContag c(50), ;
                DtEmis d, Titban c(10), dtVencs d, bContas c(20), ;
                bGrupos c(20), DopCs c(20), ;
                Obs c(50), Usuars c(10), ;
                Valor n(12,2), Moeda c(3), Cotacao n(12,2), ;
                Obss m, Recors m, Hists m, ;
                ValPrev n(13,2), ValOrig n(13,2), ValOco n(13,2), ;
                ValLiq n(13,2), EspecieNfs c(6), TpDocNf c(2), Compet c(7))

            *-- 4. Carregar operacoes (SigOpOpe) com indice em Dopes
            loc_cSQL = "SELECT Dopes, Opers, NDopes, RealPrevs, " + ;
                       "Txt01, Txt02, Txt03, Txt04 FROM SigOpOpe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es"
                THROW
            ENDIF
            SELECT cursor_4c_LocalOpe
            INDEX ON Dopes TAG dopes ADDITIVE
            IF NOT SEEK(PADR(ALLTRIM(THIS.this_cDopes), 20))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o encontrada: " + ALLTRIM(THIS.this_cDopes)
                THROW
            ENDIF

            *-- 5. Carregar parametros do sistema (SigCdPam)
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalParam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + "metros do sistema"
                THROW
            ENDIF
            SELECT cursor_4c_LocalParam
            GO TOP

            *-- 6. Determinar tabela de movimento e sinal da operacao
            SELECT cursor_4c_LocalOpe
            loc_cTabMov    = IIF(cursor_4c_LocalOpe.RealPrevs = 2, "SigMvCpv", "SigMvCcr")
            loc_cSinalOper = IIF(ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR", "C", "D")

            *-- 7. Carregar registro principal (crLocMccr - Tipos=' ')
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       " AND Tipos = ' '"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar movimento principal"
                THROW
            ENDIF
            SELECT crLocMccr
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado para o t" + ;
                                          CHR(237) + "tulo informado"
                THROW
            ENDIF

            *-- 8. Carregar crTmpMccr com filtro de tipo conforme optTipo
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       IIF(THIS.this_nOptTipo = 1, " AND Tipos = 'C'", "")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar dados de movimento"
                THROW
            ENDIF
            SELECT crTmpMccr
            GO TOP
            IF EOF()
                *-- Se vazio, copiar crLocMccr como base
                IF USED("crTmpMccr")
                    USE IN crTmpMccr
                ENDIF
                SELECT * FROM crLocMccr INTO CURSOR crTmpMccr READWRITE
                SELECT crLocMccr
                GO TOP
            ENDIF

            *-- 9. Se OptAgrupa 1 ou 2, carregar recorrencias
            IF INLIST(THIS.this_nOptAgrupa, 1, 2)
                SELECT crTmpMccr
                GO TOP
                loc_cEDNE = ALLTRIM(crTmpMccr.EmpDopNcs)

                loc_cSQL = "SELECT nRecors FROM SigTtRec " + ;
                           "WHERE EmpdopNcs = " + EscaparSQL(loc_cEDNE)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalRecor")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias"
                    THROW
                ENDIF
                SELECT cursor_4c_LocalRecor
                GO TOP
                loc_nRecor = cursor_4c_LocalRecor.nRecors

                *-- Buscar registros de recorrencia via UNION ALL (SigMvCcr e SigMvCpv)
                loc_cSQL = "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCcr a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs " + ;
                           "UNION ALL " + ;
                           "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCpv a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias detalhadas"
                    THROW
                ENDIF

                *-- Filtrar registros relacionados (excluindo o registro principal)
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = m.loc_cOpersFiltro ;
                    AND a.EmpdopNcs <> m.loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                IF RECCOUNT("cursor_4c_LocalMccr1") = 0
                    SELECT a.* ;
                        FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                        WHERE a.Dopcs = b.dopes ;
                        AND a.Opers = m.loc_cOpersFiltro ;
                        AND a.Tipos = " " ;
                        AND a.EmpdopNcs <> m.loc_cEDNE ;
                        INTO CURSOR cursor_4c_LocalMccr1 ;
                        ORDER BY a.vencs
                ENDIF

                *-- Se OptAgrupa=1, adicionar recorrencias ao crTmpMccr
                IF THIS.this_nOptAgrupa = 1
                    SELECT crTmpMccr
                    APPEND FROM DBF("cursor_4c_LocalMccr1")
                ENDIF
            ENDIF

            *-- 10. Processar cada registro de crTmpMccr e popular crDBImp
            SELECT crLocMccr
            GO TOP

            SELECT crTmpMccr
            GO TOP
            SCAN
                *-- Determinar GrupoTran/ContaTran para a operacao do registro atual
                IF SEEK(crTmpMccr.Dopcs, "cursor_4c_LocalOpe", "dopes")
                    SELECT cursor_4c_LocalParam
                    GO TOP
                    IF ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR"
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoPags)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaPags)
                    ELSE
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoRecs)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaRecs)
                    ENDIF
                ENDIF

                *-- Carregar detalhes complementares do titulo (SigTtCcd)
                loc_cSQL = "SELECT obsd, Hists FROM SigTtCcd " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(crTmpMccr.EmpDopNcs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccrd")
                SELECT cursor_4c_TmpMccrd
                GO TOP
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.obsd))
                    loc_cObsd = ALLTRIM(cursor_4c_TmpMccrd.obsd)
                ELSE
                    loc_cObsd = " "
                ENDIF
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.Hists))
                    loc_cHists = ALLTRIM(cursor_4c_TmpMccrd.Hists)
                ELSE
                    loc_cHists = " "
                ENDIF

                *-- Buscar nome do emitente (contems)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contems)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli1")
                SELECT cursor_4c_TmpCli1
                GO TOP
                loc_cRclis1 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli1.Rclis), "")

                *-- Buscar nome e CPF do portador (conta ou contems conforme ContaTran)
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaLkp = crTmpMccr.Contems
                ELSE
                    loc_cContaLkp = crTmpMccr.Contas
                ENDIF
                loc_cSQL = "SELECT Rclis, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(loc_cContaLkp)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli2")
                SELECT cursor_4c_TmpCli2
                GO TOP
                loc_cRclis2 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Rclis), "")
                loc_cCpfs2  = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Cpfs), "")

                *-- Buscar nome do centro de custo (scontas)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.scontas)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli3")
                SELECT cursor_4c_TmpCli3
                GO TOP
                loc_cRclis3 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli3.Rclis), "")

                *-- Buscar nome do agente cobrador (contages)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contages)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli4")
                SELECT cursor_4c_TmpCli4
                GO TOP
                loc_cRclis4 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli4.Rclis), "")

                *-- Labels de texto dos campos (Txt01-Txt04)
                SELECT cursor_4c_LocalOpe
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt01))
                    loc_cTxt01 = ALLTRIM(cursor_4c_LocalOpe.Txt01) + " :"
                ELSE
                    loc_cTxt01 = "Emitente :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt02))
                    loc_cTxt02 = ALLTRIM(cursor_4c_LocalOpe.Txt02) + " :"
                ELSE
                    loc_cTxt02 = "Portador :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt03))
                    loc_cTxt03 = ALLTRIM(cursor_4c_LocalOpe.Txt03) + " :"
                ELSE
                    loc_cTxt03 = "Centro de Custo :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt04))
                    loc_cTxt04 = ALLTRIM(cursor_4c_LocalOpe.Txt04) + " :"
                ELSE
                    loc_cTxt04 = "Agente Cobrador :"
                ENDIF

                *-- Grupo e conta do portador (podem ser transpostos com emitente)
                IF ALLTRIM(crTmpMccr.Grupos) = THIS.this_cGrupoTran
                    loc_cGrupoPortador = crTmpMccr.Grupems
                ELSE
                    loc_cGrupoPortador = crTmpMccr.Grupos
                ENDIF
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaPortador = crTmpMccr.ContEms
                ELSE
                    loc_cContaPortador = crTmpMccr.Contas
                ENDIF

                *-- Adicionar registro ao cursor crDBImp
                SELECT crDBImp
                APPEND BLANK
                REPLACE ;
                    Emps      WITH crTmpMccr.Emps, ;
                    RazSocs   WITH ALLTRIM(cursor_4c_LocalEmp.RazSocs), ;
                    Titulo    WITH crTmpMccr.Titulos, ;
                    Nfs       WITH crTmpMccr.Nfs, ;
                    DtMovs    WITH crTmpMccr.datas, ;
                    Txt01     WITH loc_cTxt01, ;
                    GrupEm    WITH crTmpMccr.Grupems, ;
                    Contem    WITH crTmpMccr.Contems, ;
                    dContem   WITH loc_cRclis1, ;
                    Txt02     WITH loc_cTxt02, ;
                    Grupo     WITH loc_cGrupoPortador, ;
                    Conta     WITH loc_cContaPortador, ;
                    dConta    WITH loc_cRclis2, ;
                    cpfs      WITH loc_cCpfs2, ;
                    Txt03     WITH loc_cTxt03, ;
                    sGrupos   WITH crTmpMccr.sgrupos, ;
                    sContas   WITH crTmpMccr.sContas, ;
                    sdConta   WITH loc_cRclis3, ;
                    Obsc      WITH NVL(crTmpMccr.hist2s, " "), ;
                    Txt04     WITH loc_cTxt04, ;
                    Gruage    WITH crTmpMccr.Grupages, ;
                    contag    WITH crTmpMccr.Contages, ;
                    dContag   WITH loc_cRclis4, ;
                    DtEmis    WITH NVL(crTmpMccr.dtemis, DATE()), ;
                    Titban    WITH crTmpMccr.Titbans, ;
                    dtVencs   WITH crTmpMccr.Vencs, ;
                    Obs       WITH NVL(crTmpMccr.hist2s, " "), ;
                    Valor     WITH crTmpMccr.Valors, ;
                    Moeda     WITH crTmpMccr.Moedas, ;
                    Cotacao   WITH crTmpMccr.Cotacaos, ;
                    bgrupos   WITH crTmpMccr.bGrupos, ;
                    bContas   WITH crTmpMccr.bContas, ;
                    Obss      WITH loc_cObsd, ;
                    Hists     WITH loc_cHists, ;
                    DopCs     WITH crTmpMccr.Dopcs, ;
                    Usuars    WITH crTmpMccr.UsuAlts, ;
                    ValPrev   WITH crLocMccr.Valprev, ;
                    ValOrig   WITH crLocMccr.Valors, ;
                    ValOco    WITH crLocMccr.Valocurs, ;
                    EspecieNfs WITH crLocMccr.EspecieNfs, ;
                    TpDocNf   WITH crLocMccr.TpDocNf, ;
                    Compet    WITH crLocMccr.Compet, ;
                    ValLiq    WITH crTmpMccr.Valors + crLocMccr.Valocurs - ;
                                  (crTmpMccr.ValPags + crLocMccr.Valocurs)

                SELECT crTmpMccr
            ENDSCAN

            *-- 11. Se OptAgrupa=2, montar texto de recorrencias agrupadas
            IF THIS.this_nOptAgrupa = 2
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = m.loc_cOpersFiltro ;
                    AND a.Tipos = " " ;
                    AND a.EmpdopNcs <> m.loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                loc_cObs = ""
                SELECT cursor_4c_LocalMccr1
                SCAN
                    IF cursor_4c_LocalMccr1.valprev = 0
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valors, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ELSE
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valprev, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ENDIF
                ENDSCAN

                SELECT crDBImp
                REPLACE ALL Recors WITH loc_cObs
            ENDIF

            *-- 12. Calcular totais por titulo
            SELECT Titulo, SUM(1) AS Qtdes ;
                FROM crDBImp ;
                GROUP BY Titulo ;
                ORDER BY Titulo ;
                INTO CURSOR cursor_4c_TmpCC

            SELECT crDBImp
            GO TOP
            loc_laTitulo = crDBImp.Titulo
            loc_lnTotVal = 0
            SCAN
                IF loc_laTitulo <> crDBImp.Titulo
                    loc_nReg = RECNO()
                    REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
                    GO loc_nReg
                    loc_lnTotVal = 0
                    loc_laTitulo = crDBImp.Titulo
                ENDIF
                SELECT cursor_4c_TmpCC
                LOCATE FOR Titulo = crDBImp.Titulo
                IF cursor_4c_TmpCC.Qtdes = 1
                    SELECT crDBImp
                    REPLACE Obsc WITH ""
                    loc_lnTotVal = crDBImp.Valor
                ELSE
                    SELECT crDBImp
                    REPLACE Obs WITH ""
                    loc_lnTotVal = loc_lnTotVal + crDBImp.Valor
                    REPLACE Valorc WITH crDBImp.Valor
                    REPLACE Valor WITH 0
                ENDIF
                SELECT crDBImp
            ENDSCAN
            REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
            GO TOP

            *-- 13. Atualizar DirFiscais se diretorio alternativo informado
            IF !EMPTY(ALLTRIM(THIS.this_cDiretorio))
                goSistema.DirFiscais = THIS.this_cDiretorio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFrx - Retorna caminho do FRX conforme opcoes de impressao
    * Logica original: procedures visualizacao/impressao/documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    FUNCTION ObterNomeFrx()
        LOCAL loc_cFrx
        IF THIS.this_nOptTipo = 1
            IF THIS.this_nOptAgrupa = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdA"
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdt"
            ENDIF
        ELSE
            loc_cFrx = gc_4c_CaminhoReports + "SigReIag"
        ENDIF
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    * Logica original: PROCEDURE visualizacao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio sem prompt
    * Logica original: PROCEDURE documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Documento")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crDBImp")
            USE IN crDBImp
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
