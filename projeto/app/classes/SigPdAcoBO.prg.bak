*==============================================================================
* SigPdAcoBO.prg - Business Object: Acompanhamento de Material por Grupo
* Form Operacional - sem tabela principal unica (multi-tabelas)
* Tabelas: SigMvEst, SigCdPro, SigMvCab, SigMvItn, SigCdGrp, SigCdPam, SigCdEmp
*==============================================================================

DEFINE CLASS SigPdAcoBO AS BusinessBase

    *-- Controle de estado do processamento
    this_lProcessamento  = .F.

    *-- Parametros de operacoes carregados de SigCdPam
    this_cDopEmphs   = ""
    this_cDopReqcs   = ""
    this_cDopPedcs   = ""
    this_cDopComps   = ""
    this_cDopTrfCps  = ""

    *-- Cabecalho do relatorio
    this_cTituloRel   = ""
    this_cSubTitulo   = ""
    this_cNomeEmpresa = ""

    *-- Filtro corrente
    this_cGrupoAtual  = ""

    *--------------------------------------------------------------------------
    * Init - Configura BO (form operacional sem tabela CRUD unica)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de parametros para this_*
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDopEmphs  = TratarNulo(DopEmphs,  "C")
            THIS.this_cDopReqcs  = TratarNulo(DopReqcs,  "C")
            THIS.this_cDopPedcs  = TratarNulo(DopPedcs,  "C")
            THIS.this_cDopComps  = TratarNulo(DopComps,  "C")
            THIS.this_cDopTrfCps = TratarNulo(DopTrfCps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave unica
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Executa primeira geracao do relatorio
    *   Form operacional de relatorio: a operacao "Inserir" equivale a executar
    *   o processamento inicial que monta o cursor csRel com saldos atuais,
    *   parametros e empresa. Retorna .T. se o processamento foi bem sucedido
    *   e o cursor csRel ficou disponivel para o Grid.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_oListbox)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Garante parametros e cursores prontos
            IF EMPTY(THIS.this_cDopEmphs) .AND. EMPTY(THIS.this_cDopReqcs) .AND. ;
               EMPTY(THIS.this_cDopPedcs) .AND. EMPTY(THIS.this_cDopComps) .AND. ;
               EMPTY(THIS.this_cDopTrfCps)
                THIS.CarregarParametros()
            ENDIF

            IF !USED("csRel") .OR. !USED("csCab")
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Executa processamento real (popula csRel + listbox de grupos)
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Re-executa processamento do relatorio
    *   Form operacional de relatorio: a operacao "Atualizar" equivale a
    *   recalcular saldos atuais. Zera csRel, reprocessa do zero e mantem
    *   o filtro de grupo corrente. Usado quando o usuario clica "Processar"
    *   apos primeira execucao para refletir mudancas em estoque.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_oListbox)
        LOCAL loc_lSucesso, loc_cGrupoAnterior
        loc_lSucesso = .F.
        loc_cGrupoAnterior = THIS.this_cGrupoAtual

        TRY
            *-- Limpa filtro previo para nao interferir no SCAN do Processar
            IF USED("csRel")
                SELECT csRel
                SET KEY TO
                ZAP
            ENDIF

            *-- Reprocessa carregando saldos atuais
            loc_lSucesso = THIS.Processar(par_oListbox)

            IF loc_lSucesso
                THIS.this_lProcessamento = .T.

                *-- Restaura filtro de grupo se havia um ativo
                IF !EMPTY(loc_cGrupoAnterior) .AND. USED("csRel")
                    THIS.FiltrarPorGrupo(loc_cGrupoAnterior)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de operacao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DopEmphs, DopReqcs, DopPedcs, DopComps, DopTrfCps " + ;
                       "FROM SigCdPam"

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    THIS.CarregarDoCursor("cursor_4c_Pam")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega nome da empresa logada para this_cNomeEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa()
        LOCAL loc_cSQL, loc_cCodEmp
        loc_cCodEmp = go_4c_Sistema.cCodEmpresa

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp"

            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                LOCATE FOR ALLTRIM(Cemps) = ALLTRIM(loc_cCodEmp)
                IF FOUND()
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp) + " - " + ALLTRIM(TratarNulo(Razas, "C"))
                ELSE
                    THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
                ENDIF
            ELSE
                THIS.this_cNomeEmpresa = ALLTRIM(loc_cCodEmp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorRelatorio - Cria cursores csRel e csCab para o relatorio
    *                        Estrutura IDENTICA a do Load original
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorRelatorio()
        IF USED("csCab")
            USE IN csCab
        ENDIF
        IF USED("csRel")
            USE IN csRel
        ENDIF

        CREATE CURSOR csCab (cbemp C(60), cbtit C(100), cbsubtit C(100))
        APPEND BLANK

        SET NULL ON
        CREATE CURSOR csRel ( ;
            Cgrus    C(3)    NULL, ;
            Mats     C(10)   NULL, ;
            Dcompos  C(30)   NULL, ;
            Qtds     N(10,3) NULL, ;
            QtdMins  N(10,3) NULL, ;
            CUnis    C(3)    NULL, ;
            QtdReqs  N(10,3) NULL, ;
            QtdPedcs N(10,3) NULL, ;
            QtdComps N(10,3) NULL, ;
            QtdEmphs N(10,3) NULL, ;
            QtdPfins N(10,3) NULL, ;
            QtdPfMs  N(12,3) NULL, ;
            Flags    L       NULL, ;
            Mat2s    C(10)   NULL, ;
            Dcompo2s C(30)   NULL, ;
            Seqs     C(1)    NULL, ;
            PesoMs   N(12,3) NULL  ;
        )
        SET NULL OFF

        INDEX ON Cgrus + Mats + Seqs TAG GruMat
        INDEX ON Mats + CUnis TAG Mats
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Processa saldos e movimentacoes por grupo de material
    *             Popula cursor csRel. par_oListbox recebe grupos encontrados.
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oListbox)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCodEmp, loc_cEmpGE
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEdI, loc_cEdF, loc_qtMin
        LOCAL loc_cCPros_s, loc_cDPros_s, loc_cCUnis_s, loc_cCGrus_s, loc_cCUniPs_s
        LOCAL loc_nQMins_s, loc_nPesoMs_s, loc_nSqtds_s, loc_nSPesos_s
        LOCAL loc_cCPros_o, loc_cCUnis_o, loc_cCUniPs_o, loc_cCGrus_o, loc_cDPros_o
        LOCAL loc_nQMins_o, loc_nPesoMs_o, loc_nQtdDiff_o

        loc_lSucesso = .F.
        loc_cCodEmp  = go_4c_Sistema.cCodEmpresa

        TRY
            *-- Prepara titulo e cabecalho do relatorio
            THIS.this_cTituloRel = "Relat" + CHR(243) + "rio de Acompanhamento de Material por Grupo"
            THIS.this_cSubTitulo = " "
            THIS.CarregarEmpresa()

            IF USED("csCab")
                SELECT csCab
                REPLACE cbemp    WITH THIS.this_cNomeEmpresa, ;
                        cbtit    WITH THIS.this_cTituloRel,   ;
                        cbsubtit WITH THIS.this_cSubTitulo
            ENDIF

            *-- Zera ou (re)cria csRel
            IF USED("csRel")
                SELECT csRel
                ZAP
            ELSE
                THIS.CriarCursorRelatorio()
            ENDIF

            *-- Carrega grupos validos (crGrupo com index por Cgrus)
            loc_cSQL = "SELECT Cgrus, Dgrus FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crGrupo")
                USE IN crGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crGrupo") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crGrupo)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF
            SELECT crGrupo
            INDEX ON Cgrus TAG Cgrus

            *-- Carrega combinacoes Grupos/Estos para busca no estoque
            loc_cSQL = "SELECT DISTINCT GruEstPs AS Grupos, ConEstps AS Estos " + ;
                       "FROM SigCdGrp " + ;
                       "WHERE NOT GruEstPs = '" + SPACE(10) + "' AND " + ;
                             "NOT ConEstPs = '" + SPACE(10) + "'"

            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                MsgAviso("Falha na conex" + CHR(227) + "o (crSigCdGrp)", "Aviso")
                loc_lSucesso = loc_lSucesso
            ENDIF

            *-- Cria cursor acumulador de estoque (writable) com campos necessarios
            IF USED("pEstoque")
                USE IN pEstoque
            ENDIF
            SET NULL ON
            CREATE CURSOR pEstoque (CPros C(10) NULL, Sqtds N(10,3) NULL, sPesos N(12,3) NULL)
            SET NULL OFF

            IF RECCOUNT("crSigCdGrp") = 1
                *-- Grupo unico: busca estoque diretamente
                SELECT crSigCdGrp
                GO TOP
                loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                           "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                IF USED("cursor_4c_EstTemp")
                    USE IN cursor_4c_EstTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstTemp") < 1
                    MsgAviso("Falha na conex" + CHR(227) + "o (pEstoque)", "Aviso")
                    loc_lSucesso = loc_lSucesso
                ENDIF

                SELECT cursor_4c_EstTemp
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO pEstoque FROM MEMVAR
                ENDSCAN
            ELSE
                *-- Multiplos grupos: acumula em pEstoque
                SELECT crSigCdGrp
                SCAN
                    loc_cEmpGE = loc_cCodEmp + crSigCdGrp.Grupos + crSigCdGrp.Estos

                    loc_cSQL = "SELECT CPros, Sqtds, sPesos FROM SigMvEst " + ;
                               "WHERE EmpGruEsts = " + EscaparSQL(loc_cEmpGE) + " AND NOT Sqtds = 0"

                    IF USED("cursor_4c_TmpEst")
                        USE IN cursor_4c_TmpEst
                    ENDIF

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEst") < 1
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpEst
                    SCAN
                        SCATTER MEMVAR
                        INSERT INTO pEstoque FROM MEMVAR
                    ENDSCAN
                ENDSCAN
            ENDIF

            *-- Preenche listbox de grupos (Cgrus-Dgrus)
            IF TYPE("par_oListbox") = "O" .AND. !ISNULL(par_oListbox)
                par_oListbox.Clear()
                SELECT crGrupo
                GO TOP
                SCAN
                    par_oListbox.AddItem(ALLTRIM(crGrupo.Cgrus) + "-" + ALLTRIM(crGrupo.Dgrus))
                ENDSCAN
            ENDIF

            *-- Popula csRel com saldo atual de estoque por produto/unidade
            SELECT pEstoque
            GO TOP
            SCAN
                loc_cCPros_s = pEstoque.CPros

                loc_cSQL = "SELECT DPros, CUnis, CGrus, QMins, cUniPs, PesoMs " + ;
                           "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(loc_cCPros_s))

                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") <= 0 .OR. EOF("crSigCdPro")
                    LOOP
                ENDIF

                SELECT crSigCdPro
                loc_cDPros_s  = TratarNulo(DPros,  "C")
                loc_cCUnis_s  = TratarNulo(CUnis,  "C")
                loc_cCGrus_s  = TratarNulo(CGrus,  "C")
                loc_cCUniPs_s = TratarNulo(cUniPs, "C")
                loc_nQMins_s  = TratarNulo(QMins,  "N")
                loc_nPesoMs_s = TratarNulo(PesoMs, "N")

                *-- Produto deve pertencer a um grupo valido
                IF !SEEK(crSigCdPro.CGrus, "crGrupo", "Cgrus")
                    LOOP
                ENDIF

                SELECT pEstoque
                loc_nSqtds_s  = TratarNulo(Sqtds,  "N")
                loc_nSPesos_s = TratarNulo(sPesos,  "N")

                *-- Linha unidade primaria (Seqs='1')
                SELECT csRel
                IF !SEEK(loc_cCPros_s + loc_cCUnis_s, "csRel", "Mats")
                    APPEND BLANK
                ENDIF

                REPLACE Qtds     WITH Qtds + loc_nSqtds_s, ;
                        QtdMins  WITH loc_nQMins_s, ;
                        Mats     WITH loc_cCPros_s, ;
                        Mat2s    WITH loc_cCPros_s, ;
                        Dcompos  WITH loc_cDPros_s, ;
                        Dcompo2s WITH loc_cDPros_s, ;
                        CUnis    WITH loc_cCUnis_s, ;
                        CGrus    WITH loc_cCGrus_s, ;
                        Seqs     WITH "1"

                *-- Linha unidade alternativa por peso (Seqs='2')
                IF !EMPTY(loc_cCUniPs_s) .AND. loc_nPesoMs_s <> 0
                    loc_qtMin = ROUND(loc_nQMins_s / loc_nPesoMs_s, 0)

                    SELECT csRel
                    IF !SEEK(loc_cCPros_s + loc_cCUniPs_s, "csRel", "Mats")
                        APPEND BLANK
                    ENDIF

                    REPLACE Qtds     WITH Qtds + loc_nSPesos_s, ;
                            QtdMins  WITH loc_qtMin, ;
                            Mats     WITH loc_cCPros_s, ;
                            Dcompos  WITH loc_cDPros_s, ;
                            CUnis    WITH loc_cCUniPs_s, ;
                            CGrus    WITH loc_cCGrus_s, ;
                            PesoMs   WITH loc_nPesoMs_s, ;
                            Seqs     WITH "2"
                ENDIF
            ENDSCAN

            *-- Processa 5 tipos de operacao: Empenho(1), Requisicao(2),
            *   PedidoCompra(3), Compra(4), TransferenciaCompra(5->QtdComps)
            FOR loc_nX = 1 TO 5
                DO CASE
                    CASE loc_nX = 1
                        loc_cOperBusca = THIS.this_cDopEmphs
                        loc_cCampo     = "QtdEmphs"
                    CASE loc_nX = 2
                        loc_cOperBusca = THIS.this_cDopReqcs
                        loc_cCampo     = "QtdReqs"
                    CASE loc_nX = 3
                        loc_cOperBusca = THIS.this_cDopPedcs
                        loc_cCampo     = "QtdPedcs"
                    CASE loc_nX = 4
                        loc_cOperBusca = THIS.this_cDopComps
                        loc_cCampo     = "QtdComps"
                    CASE loc_nX = 5
                        loc_cOperBusca = THIS.this_cDopTrfCps
                        loc_cCampo     = "QtdComps"
                ENDCASE

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEdI = loc_cCodEmp + loc_cOperBusca + STR(0,      6)
                loc_cEdF = loc_cCodEmp + loc_cOperBusca + STR(999999, 6)

                loc_cSQL = "SELECT b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                           "c.Cgrus, c.QMins, c.Dpros, c.CUnis, c.cUnips, c.PesoMs " + ;
                           "FROM SigMvCab a, SigMvItn b, SigCdPro c " + ;
                           "WHERE a.EmpDopNums BETWEEN " + EscaparSQL(loc_cEdI) + " AND " + EscaparSQL(loc_cEdF) + " AND " + ;
                                 "a.EmpDopNums = b.EmpDopNums AND " + ;
                                 "NOT ((b.Qtds - b.QtBaixas) = 0) AND " + ;
                                 "b.CPros = c.CPros " + ;
                           "ORDER BY b.EmpDopNums, b.CPros, b.Qtds, b.QtBaixas, " + ;
                                    "c.Cgrus, c.QMins, c.Dpros, c.CUnis"

                IF USED("crOperacao")
                    USE IN crOperacao
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crOperacao") < 1
                    LOOP
                ENDIF

                SELECT crOperacao
                SCAN
                    IF !SEEK(crOperacao.Cgrus, "crGrupo", "Cgrus")
                        LOOP
                    ENDIF

                    loc_cCPros_o   = crOperacao.CPros
                    loc_cCUnis_o   = crOperacao.CUnis
                    loc_cCUniPs_o  = TratarNulo(crOperacao.cUnips, "C")
                    loc_cCGrus_o   = crOperacao.Cgrus
                    loc_cDPros_o   = TratarNulo(crOperacao.Dpros,  "C")
                    loc_nQMins_o   = TratarNulo(crOperacao.QMins,  "N")
                    loc_nPesoMs_o  = TratarNulo(crOperacao.PesoMs, "N")
                    loc_nQtdDiff_o = TratarNulo(crOperacao.Qtds, "N") - TratarNulo(crOperacao.QtBaixas, "N")

                    *-- Linha unidade primaria
                    SELECT csRel
                    IF !SEEK(loc_cCPros_o + loc_cCUnis_o, "csRel", "Mats")
                        APPEND BLANK
                        REPLACE QtdMins  WITH loc_nQMins_o, ;
                                Mats     WITH loc_cCPros_o, ;
                                Dcompos  WITH loc_cDPros_o, ;
                                Mat2s    WITH loc_cCPros_o, ;
                                Dcompo2s WITH loc_cDPros_o, ;
                                CUnis    WITH loc_cCUnis_o, ;
                                CGrus    WITH loc_cCGrus_o, ;
                                PesoMs   WITH loc_nPesoMs_o, ;
                                Seqs     WITH "1"
                    ENDIF

                    DO CASE
                        CASE loc_cCampo = "QtdEmphs"
                            REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdReqs"
                            REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdPedcs"
                            REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                        CASE loc_cCampo = "QtdComps"
                            REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                    ENDCASE

                    *-- Linha unidade alternativa por peso
                    IF !EMPTY(loc_cCUniPs_o) .AND. loc_nPesoMs_o <> 0
                        loc_qtMin = ROUND(loc_nQMins_o / loc_nPesoMs_o, 0)

                        SELECT csRel
                        IF !SEEK(loc_cCPros_o + loc_cCUniPs_o, "csRel", "Mats")
                            APPEND BLANK
                            REPLACE QtdMins  WITH loc_qtMin, ;
                                    Mats     WITH loc_cCPros_o, ;
                                    Dcompos  WITH loc_cDPros_o, ;
                                    CUnis    WITH loc_cCUniPs_o, ;
                                    CGrus    WITH loc_cCGrus_o, ;
                                    PesoMs   WITH loc_nPesoMs_o, ;
                                    Seqs     WITH "2"
                        ENDIF

                        DO CASE
                            CASE loc_cCampo = "QtdEmphs"
                                REPLACE QtdEmphs WITH QtdEmphs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdReqs"
                                REPLACE QtdReqs  WITH QtdReqs  + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdPedcs"
                                REPLACE QtdPedcs WITH QtdPedcs + loc_nQtdDiff_o
                            CASE loc_cCampo = "QtdComps"
                                REPLACE QtdComps WITH QtdComps + loc_nQtdDiff_o
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDFOR

            *-- Calcula posicao final e flag de alerta (linhas Seqs='2' em peso)
            SELECT csRel
            SCAN
                IF Seqs = "2"
                    REPLACE QtdReqs  WITH ROUND(QtdReqs  / PesoMs, 0), ;
                            QtdPedcs WITH ROUND(QtdPedcs / PesoMs, 0), ;
                            QtdComps WITH ROUND(QtdComps / PesoMs, 0), ;
                            QtdEmphs WITH ROUND(QtdEmphs / PesoMs, 0), ;
                            Dcompo2s WITH PADC("*", 35)
                ENDIF
                REPLACE QtdPfins WITH (Qtds - QtdMins + QtdReqs + QtdPedcs + QtdComps - QtdEmphs)
                REPLACE Flags    WITH IIF(QtdReqs > 0 .AND. QtdPfins > 0, .T., .F.)
            ENDSCAN

            THIS.this_lProcessamento = .T.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarPorGrupo - Aplica filtro SET KEY no cursor csRel pelo grupo
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarPorGrupo(par_cGrupo)
        THIS.this_cGrupoAtual = ALLTRIM(LEFT(par_cGrupo, 3))

        IF USED("csRel")
            SELECT csRel
            SET ORDER TO TAG GruMat
            SET KEY TO THIS.this_cGrupoAtual
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarCabecalhoRelatorio - Atualiza subtitulo no cursor csCab
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarCabecalhoRelatorio(par_cSubTitulo)
        THIS.this_cSubTitulo = par_cSubTitulo
        IF USED("csCab")
            SELECT csCab
            REPLACE cbsubtit WITH par_cSubTitulo
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores auxiliares criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(9), loc_i
        loc_aCursores(1) = "cursor_4c_Pam"
        loc_aCursores(2) = "cursor_4c_Emp"
        loc_aCursores(3) = "crGrupo"
        loc_aCursores(4) = "crSigCdGrp"
        loc_aCursores(5) = "pEstoque"
        loc_aCursores(6) = "crOperacao"
        loc_aCursores(7) = "crSigCdPro"
        loc_aCursores(8) = "cursor_4c_EstTemp"
        loc_aCursores(9) = "cursor_4c_TmpEst"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores(loc_i))
                USE IN (loc_aCursores(loc_i))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
