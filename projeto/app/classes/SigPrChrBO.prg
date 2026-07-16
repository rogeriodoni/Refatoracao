*------------------------------------------------------------------------------
* SigPrChrBO.prg - Business Object: Consulta e Impressao de Cheques
* Tipo: OPERACIONAL
* Tabela principal: SigCqChi (cheques emitidos)
*------------------------------------------------------------------------------

DEFINE CLASS SigPrChrBO AS BusinessBase

    *-- Identificacao
    this_cTabela             = "SigCqChi"
    this_cCampoChave         = "cidchaves"

    *-- Nomes dos cursores gerenciados por este BO
    this_cCursorCheques      = "cursor_4c_Cheques"
    this_cCursorContas       = "cursor_4c_Contas"
    this_cCursorModelos      = "cursor_4c_Modelos"

    *-- Filtros de consulta (entradas para MontarCheques)
    this_cCdGrupos           = ""
    this_cDsGrupos           = ""
    this_cCdContas           = ""
    this_cDsContas           = ""
    this_dDtInicial          = {}
    this_dDtFinal            = {}

    *-- Valores anteriores para change-detection nos filtros
    this_cAntCdGrupo         = ""
    this_cAntDsGrupo         = ""
    this_cAntCdConta         = ""
    this_cAntDsConta         = ""
    this_dAntDtIni           = {}
    this_dAntDtFin           = {}

    *-- Dados do cheque corrente (linha atual do cursor_4c_Cheques)
    this_cEmps               = ""
    this_cDopes              = ""
    this_nNumes              = 0
    this_dDatas              = {}
    this_cBancos             = ""
    this_cAgencias           = ""
    this_cNcontas            = ""
    this_cNcheques           = ""
    this_cContas             = ""
    this_nValors             = 0
    this_cFavos              = ""
    this_nNcopias            = 0
    this_nNemissoes          = 0
    this_cCidchaves          = ""
    this_nNemitidos          = 0
    this_nNcancelas          = 0
    this_cJustcanc           = ""

    *-- Colunas fisicas complementares da SigCqChi (schema completo)
    this_cGrupos             = ""
    this_cEmpdopnums         = ""
    this_lEmitidos           = .F.
    this_lCancelas           = .F.
    this_dVencs              = {}
    this_cVersos             = ""
    this_nImpversos          = 0

    *-- Permissoes do usuario (carregadas em InicializarPermissoes)
    this_lExcluirDocumento   = .F.
    this_lExcluirCheque      = .F.

    *-- Estado operacional compartilhado Form<->BO
    this_lInicial            = .T.
    this_lPlInicio           = .F.
    this_lChMatIni           = .F.
    this_lPlLeCheque         = .F.
    this_cPcChqLido          = ""
    this_lPlLeitor           = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela    = "SigCqChi"
        THIS.this_cCampoChave= "cidchaves"
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarPermissoes - Carrega permissoes do usuario para esta tela
    *--------------------------------------------------------------------------
    PROCEDURE InicializarPermissoes()
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.this_lExcluirDocumento = VerificarAcessoEmpresa(gc_4c_UsuarioLogado, "EXCLUIR")
            THIS.this_lExcluirCheque    = VerificarAcessoEmpresa(gc_4c_UsuarioLogado, "EXCLUIRCHQ")
        ELSE
            THIS.this_lExcluirDocumento = .F.
            THIS.this_lExcluirCheque    = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursores base e carrega contas com emissao de cheque
    * Equivalente ao Init() do form legado que criava CrSigCdmp, CrContas, CsSigCqChi
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdmp"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Modelos") < 1
                MsgErro("Falha ao carregar modelos de impress" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Modelos
            INDEX ON impres TAG impres
            GO TOP

            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.IClis, b.RClis " + ;
                       "FROM SigOpFp a, SigCdCli b " + ;
                       "WHERE a.EmiChqs = 1 AND b.IClis = a.ContaDs " + ;
                       "ORDER BY IClis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas") < 1
                MsgErro("Falha ao carregar contas.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            INDEX ON IClis TAG IClis
            INDEX ON RClis TAG RClis
            GO TOP

            IF USED(THIS.this_cCursorCheques)
                USE IN (THIS.this_cCursorCheques)
            ENDIF

            loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, " + ;
                       "a.ncontas, a.ncheques, a.contas, a.valors, a.favos, a.ncopias, " + ;
                       "a.emitidos, a.nemissoes, a.cancelas, a.cidchaves, a.JustCanc, " + ;
                       "0 AS NEmitidos, 0 AS NCancelas, 0 AS NMarca1s " + ;
                       "FROM SigCqChi a WHERE 0=1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorCheques) < 1
                MsgErro("Falha ao criar cursor de cheques.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.IndexarCursorCheques()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inicializar cursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * IndexarCursorCheques - Cria todos os indices necessarios no cursor de cheques
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE IndexarCursorCheques()
        SELECT (THIS.this_cCursorCheques)
        INDEX ON ncopias                                                        TAG NCopias
        INDEX ON nEmitidos                                                      TAG NEmitidos
        INDEX ON nCancelas                                                      TAG NCancelas
        INDEX ON nMarca1s                                                       TAG NMarca1s
        INDEX ON ncheques                                                       TAG NCheques
        INDEX ON datas                                                          TAG Datas
        INDEX ON ncontas + ncheques                                             TAG Conta
        INDEX ON contas + STR(ncopias)                                          TAG Contas
        INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques          TAG Emissao
        INDEX ON STR(valors, 12, 2) + bancos + agencias + ncontas + ncheques  TAG Valor
        INDEX ON bancos + agencias + ncontas + ncheques                        TAG Cheque
        INDEX ON agencias + ncontas + ncheques                                 TAG Agencia
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCheques - Carrega cursor principal de cheques conforme filtros
    * Equivalente ao mMontaChq/montachq do legado
    * par_lPosiciona: .T. = manter posicao corrente apos recarregar
    *--------------------------------------------------------------------------
    PROCEDURE MontarCheques(par_lPosiciona)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cBusca, loc_cDtInicial, loc_cDtFinal, loc_cCdGrupo, loc_cCdConta
        LOCAL loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF TYPE("par_lPosiciona") != "L"
                par_lPosiciona = .F.
            ENDIF

            IF par_lPosiciona AND USED(THIS.this_cCursorCheques) AND !EOF(THIS.this_cCursorCheques)
                SELECT (THIS.this_cCursorCheques)
                loc_cBusca = bancos + agencias + ncontas + ncheques
            ENDIF

            loc_cDtInicial = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinal   = FormatarDataSQL(THIS.this_dDtFinal)
            loc_cCdGrupo   = THIS.this_cCdGrupos
            loc_cCdConta   = THIS.this_cCdContas

            IF USED(THIS.this_cCursorCheques)
                USE IN (THIS.this_cCursorCheques)
            ENDIF

            IF USED("cursor_4c_ChequesTemp")
                USE IN cursor_4c_ChequesTemp
            ENDIF

            IF EMPTY(loc_cCdConta)
                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, a.agencias, " + ;
                           "a.ncontas, a.ncheques, a.contas, a.valors, a.favos, a.ncopias, " + ;
                           "a.emitidos, a.nemissoes, a.cancelas, a.cidchaves, a.JustCanc " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal + " AND " + ;
                           IIF(EMPTY(loc_cCdGrupo), "", "a.Grupos = " + EscaparSQL(loc_cCdGrupo) + " AND ") + ;
                           "a.Contas IN (SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1) " + ;
                           "ORDER BY a.emps, a.dopes, a.numes, a.datas, " + ;
                           "a.bancos, a.agencias, a.ncontas, a.ncheques, a.contas, " + ;
                           "a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
            ELSE
                loc_cSQL = "SELECT emps, dopes, numes, datas, bancos, agencias, " + ;
                           "ncontas, ncheques, contas, valors, favos, ncopias, " + ;
                           "emitidos, nemissoes, cancelas, cidchaves, JustCanc " + ;
                           "FROM SigCqChi " + ;
                           "WHERE datas BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal + " AND " + ;
                           IIF(EMPTY(loc_cCdGrupo), "", "Grupos = " + EscaparSQL(loc_cCdGrupo) + " AND ") + ;
                           "Contas = " + EscaparSQL(loc_cCdConta) + " " + ;
                           "ORDER BY emps, dopes, numes, datas, " + ;
                           "bancos, agencias, ncontas, ncheques, contas, " + ;
                           "valors, favos, ncopias, emitidos, nemissoes, cancelas, cidchaves"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequesTemp") < 1
                MsgErro("Falha ao carregar cheques do servidor.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT Emps, Dopes, Numes, Datas, Bancos, Agencias, NContas, NCheques, Contas, ;
                   Valors, Favos, NCopias, NEmissoes, cIdChaves, ;
                   IIF(Emitidos, 1, 0) AS NEmitidos, ;
                   IIF(Cancelas, 1, 0) AS NCancelas, ;
                   0 AS NMarca1s, JustCanc ;
              FROM cursor_4c_ChequesTemp ;
             ORDER BY Bancos, Agencias, NContas, NCheques ;
              INTO CURSOR (THIS.this_cCursorCheques) READWRITE

            IF USED("cursor_4c_ChequesTemp")
                USE IN cursor_4c_ChequesTemp
            ENDIF

            THIS.IndexarCursorCheques()

            SET ORDER TO NCopias

            IF par_lPosiciona AND !EMPTY(loc_cBusca)
                IF !SEEK(loc_cBusca, THIS.this_cCursorCheques, "Cheque")
                    SELECT (THIS.this_cCursorCheques)
                    GO TOP
                ENDIF
            ELSE
                SELECT (THIS.this_cCursorCheques)
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar cheques")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExibirCheques - Reordena/reposiciona cursor de cheques conforme conta filtrada
    * Equivalente ao mExibeCheques do legado
    * par_lSeek: .T. = posicionar no final (Chr(255))
    *--------------------------------------------------------------------------
    PROCEDURE ExibirCheques(par_lSeek)
        LOCAL loc_oErro

        TRY
            IF TYPE("par_lSeek") != "L"
                par_lSeek = .F.
            ENDIF

            IF USED(THIS.this_cCursorCheques)
                UPDATE (THIS.this_cCursorCheques) SET NMarca1s = 0 WHERE NMarca1s = 1
            ENDIF

            IF EMPTY(THIS.this_cCdContas)
                SELECT (THIS.this_cCursorCheques)
                SET ORDER TO NCopias
                IF par_lSeek
                    SEEK CHR(255) IN (THIS.this_cCursorCheques) ORDER NCopias ASCENDING
                ENDIF
            ELSE
                SELECT (THIS.this_cCursorCheques)
                SET ORDER TO Contas
                SET KEY TO THIS.this_cCdContas
                IF par_lSeek
                    SEEK THIS.this_cCdContas + CHR(255) IN (THIS.this_cCursorCheques) ORDER Contas ASCENDING
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao exibir cheques")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os cheques nao emitidos/cancelados para impressao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_oErro, loc_nRecno

        TRY
            IF !USED(THIS.this_cCursorCheques)
                RETURN
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_nRecno = RECNO()

            UPDATE (THIS.this_cCursorCheques) SET NMarca1s = 1 ;
             WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorCheques))
                GO loc_nRecno IN (THIS.this_cCursorCheques)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao marcar cheques")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Remove marcacao de todos os cheques
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_oErro, loc_nRecno

        TRY
            IF !USED(THIS.this_cCursorCheques)
                RETURN
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_nRecno = RECNO()

            UPDATE (THIS.this_cCursorCheques) SET NMarca1s = 0 WHERE NMarca1s = 1

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorCheques))
                GO loc_nRecno IN (THIS.this_cCursorCheques)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao desmarcar cheques")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarMarcaCheque - Alterna marcacao de um cheque individual (CheckBox KeyPress)
    * par_cChave: bancos+agencias+ncontas+ncheques do cheque
    *--------------------------------------------------------------------------
    PROCEDURE AlternarMarcaCheque(par_cChave)
        LOCAL loc_oErro, loc_nRecno

        TRY
            IF !USED(THIS.this_cCursorCheques)
                RETURN
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_nRecno = RECNO()

            UPDATE (THIS.this_cCursorCheques) ;
               SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
             WHERE bancos + agencias + ncontas + ncheques = par_cChave ;
               AND NEmitidos = 0 AND NCancelas = 0

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorCheques))
                GO loc_nRecno IN (THIS.this_cCursorCheques)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alternar marca do cheque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterSituacaoCheque - Retorna string descritiva da situacao do cheque corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterSituacaoCheque(par_nNcancelas, par_nNemissoes, par_nNemitidos)
        IF par_nNcancelas = 1
            RETURN "Cancelado"
        ENDIF
        IF par_nNemissoes > 1
            RETURN "Reemitido"
        ENDIF
        IF par_nNemitidos = 1
            RETURN "Emitido"
        ENDIF
        RETURN "N" + CHR(227) + "o Emitido"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCorCheque - Retorna RGB de exibicao conforme situacao do cheque
    *--------------------------------------------------------------------------
    FUNCTION ObterCorCheque(par_nNcancelas, par_nNemitidos)
        IF par_nNcancelas = 1
            RETURN RGB(255, 0, 0)
        ENDIF
        IF par_nNemitidos = 0
            RETURN RGB(0, 0, 255)
        ENDIF
        RETURN RGB(0, 0, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConta - Carrega dados da parcela/documento do cheque corrente
    * Equivalente ao CarregaConta do legado
    * Popula cursor TmpConta com dados da parcela para impressao de documento
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConta()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cChave, loc_cSQL, loc_nOk

        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques) OR EOF(THIS.this_cCursorCheques)
                MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_cChave = RTRIM(emps) + RTRIM(dopes) + STR(numes, 6)

            IF USED("cursor_4c_TmpPrIt")
                USE IN cursor_4c_TmpPrIt
            ENDIF

            loc_cSQL = "SELECT emps,dopes,numes,empos,grupos,contas,tipos,nopers,opers," + ;
                       "acertos,cotacaos,valos,moedas,hists,vencs,datas " + ;
                       "FROM SigCdPit " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cChave) + " " + ;
                       "ORDER BY emps,dopes,numes,grupos,contas,nopers"

            loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPrIt")
            IF loc_nOk < 1
                MsgErro("Falha ao carregar dados da parcela.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_TmpConta")
                USE IN cursor_4c_TmpConta
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_TmpConta (;
                grupos   C(10) NULL, ;
                contas   C(10) NULL, ;
                flag     L     NULL, ;
                valos    N(12,2) NULL, ;
                acerto   N(12,2) NULL, ;
                moedas   C(3)  NULL, ;
                datas    D     NULL, ;
                vencs    D     NULL, ;
                hists    C(50) NULL, ;
                nomes    C(50) NULL, ;
                emps     C(3)  NULL, ;
                nopers   N(9)  NULL, ;
                dopes    C(20) NULL, ;
                numes    N(6)  NULL, ;
                tipos    C(1)  NULL, ;
                fpags    C(12) NULL, ;
                opers    C(1)  NULL, ;
                baixa    N(12,2) NULL, ;
                baixaaut N(12,2) NULL, ;
                cotacaos N(12,4) NULL, ;
                grupocs  C(10) NULL, ;
                contacs  C(10) NULL, ;
                cotorigs N(12,4) NULL, ;
                moedacs  C(3)  NULL, ;
                cotacaocs N(12,4) NULL, ;
                valocs   N(12,2) NULL, ;
                empos    C(3)  NULL, ;
                OrdCopChs N(3) NULL ;
            )
            SET NULL OFF

            SELECT cursor_4c_TmpPrIt
            GO TOP

            SCAN
                SCATTER MEMVAR

                m.flag  = .F.
                m.nomes = ""

                IF SEEK(m.contas, "cursor_4c_Contas", "IClis")
                    m.nomes = cursor_4c_Contas.RClis
                ENDIF

                DO CASE
                    CASE cursor_4c_TmpPrIt.tipos = "M"
                        SCATTER FIELDS moedas, hists, vencs, datas MEMVAR
                        IF m.acertos <> 0
                            m.flag = .T.
                        ENDIF

                    CASE cursor_4c_TmpPrIt.tipos = "C"
                        m.flag = .T.
                        IF USED("cursor_4c_TmpMccr")
                            USE IN cursor_4c_TmpMccr
                        ENDIF

                        loc_cSQL = "SELECT emps,nopers,grupos,contas,valors,valpags FROM SigMvCcr " + ;
                                   "WHERE emps = " + EscaparSQL(cursor_4c_TmpPrIt.empos) + ;
                                   " AND nopers = " + FormatarNumeroSQL(cursor_4c_TmpPrIt.Nopers, 0)

                        loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccr")
                        IF loc_nOk < 1
                            MsgErro("Falha ao carregar dados de conta corrente.", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_TmpMccr
                        GO TOP
                        IF m.grupos <> cursor_4c_TmpMccr.grupos OR m.contas <> cursor_4c_TmpMccr.contas
                            SKIP
                        ENDIF

                        m.valos = cursor_4c_TmpMccr.valors - cursor_4c_TmpMccr.valpags + m.acertos

                    CASE cursor_4c_TmpPrIt.tipos = "P"
                        m.flag = .T.
                        IF USED("cursor_4c_TmpPar")
                            USE IN cursor_4c_TmpPar
                        ENDIF

                        loc_cSQL = "SELECT emps,nopers,moefpgs,fpags,vpags FROM SigMvPar " + ;
                                   "WHERE emps = " + EscaparSQL(cursor_4c_TmpPrIt.empos) + ;
                                   " AND nopers = " + FormatarNumeroSQL(cursor_4c_TmpPrIt.Nopers, 0)

                        loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPar")
                        IF loc_nOk < 1
                            MsgErro("Falha ao carregar dados de parcela.", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_TmpPar
                        GO TOP
                        m.valos  = m.valos - cursor_4c_TmpPar.vpags + m.acertos
                        m.moedas = cursor_4c_TmpPar.moefpgs
                        m.hists  = ALLTRIM(cursor_4c_TmpPar.fpags) + " " + ;
                                   m.emps + ALLTRIM(m.dopes) + " " + ALLTRIM(STR(m.numes))
                ENDCASE

                m.acerto = m.acertos

                SELECT cursor_4c_TmpConta
                INSERT INTO cursor_4c_TmpConta FROM MEMVAR
            ENDSCAN

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados do documento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirDocumento - Exclui o documento (SigCdPit) do cheque corrente
    * Equivalente ao cmdGok.cmdExcluiDoc no legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirDocumento()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk

        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques) OR EOF(THIS.this_cCursorCheques)
                MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorCheques)

            IF ncancelas = 1
                MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir documento de cheque cancelado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(RTRIM(cidchaves))
            loc_nOk  = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nOk < 1
                MsgErro("Falha ao excluir documento.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir documento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCheque - Exclui cheque cancelado (SigCqChi)
    * Equivalente ao cmdGok.btnExcluirChq no legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCheque(par_cJustificativa)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk, loc_cMensa

        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques) OR EOF(THIS.this_cCursorCheques)
                MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorCheques)

            IF ncancelas <> 1
                MsgAviso("Apenas cheques cancelados podem ser exclu" + CHR(237) + "dos.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF !THIS.this_lExcluirCheque
                MsgAviso("Acesso negado para exclus" + CHR(227) + "o de cheques.", "Sem Permiss" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(RTRIM(cidchaves))
            loc_nOk  = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nOk < 1
                MsgErro("Falha ao excluir cheque.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cMensa = "Exclus" + CHR(227) + "o do cheque cancelado: " + ;
                         RTRIM(bancos) + "/" + RTRIM(agencias) + "/" + ;
                         RTRIM(ncontas) + "/" + RTRIM(ncheques)

            THIS.RegistrarAuditoria("EXCLUIRCHQ")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir cheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarCheque - Cancela cheque (registra justificativa de cancelamento)
    * par_cJustificativa: texto da justificativa
    *--------------------------------------------------------------------------
    PROCEDURE CancelarCheque(par_cJustificativa)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cBancos
        LOCAL loc_cAgencias, loc_cNcontas, loc_cNcheques, loc_cCidchaves

        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cJustificativa)
                MsgAviso("Justificativa " + CHR(233) + " obrigat" + CHR(243) + "ria.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF !USED(THIS.this_cCursorCheques) OR EOF(THIS.this_cCursorCheques)
                MsgAviso("Nenhum cheque selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_cEmps      = RTRIM(emps)
            loc_cDopes     = RTRIM(dopes)
            loc_nNumes     = numes
            loc_cBancos    = RTRIM(bancos)
            loc_cAgencias  = RTRIM(agencias)
            loc_cNcontas   = RTRIM(ncontas)
            loc_cNcheques  = RTRIM(ncheques)
            loc_cCidchaves = RTRIM(cidchaves)

            loc_cSQL = "UPDATE SigCqChi SET Cancelas = 1, JustCanc = " + EscaparSQL(LEFT(par_cJustificativa, 50)) + ;
                       " WHERE cidchaves = " + EscaparSQL(loc_cCidchaves)

            loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nOk < 1
                MsgErro("Falha ao cancelar cheque.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("CANCELAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao cancelar cheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarChequePorCodigo - Localiza cheque no cursor por dados do banco
    * par_cBancos, par_cAgencias, par_cNcontas, par_cNcheques: identificacao
    * Retorna .T. se encontrado (cursor posicionado)
    *--------------------------------------------------------------------------
    FUNCTION BuscarChequePorCodigo(par_cBancos, par_cAgencias, par_cNcontas, par_cNcheques)
        LOCAL loc_lAchou, loc_oErro, loc_cChave

        loc_lAchou = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques)
                loc_lSucesso = .F.
            ENDIF

            loc_cChave = PADR(par_cBancos, 3) + PADR(par_cAgencias, 4) + ;
                         PADR(par_cNcontas, 10) + PADR(par_cNcheques, 6)

            SELECT (THIS.this_cCursorCheques)
            SET ORDER TO Cheque
            loc_lAchou = SEEK(loc_cChave)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cheque")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarChequePorData - Localiza cheque no cursor por data+banco+agencia+conta+numero
    *--------------------------------------------------------------------------
    FUNCTION BuscarChequePorData(par_dEmissao, par_cBancos, par_cAgencias, par_cNcontas, par_cNcheques)
        LOCAL loc_lAchou, loc_oErro, loc_cChave

        loc_lAchou = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques)
                loc_lSucesso = .F.
            ENDIF

            loc_cChave = DTOS(par_dEmissao) + PADR(par_cBancos, 3) + ;
                         PADR(par_cAgencias, 4) + PADR(par_cNcontas, 10) + PADR(par_cNcheques, 6)

            SELECT (THIS.this_cCursorCheques)
            SET ORDER TO Emissao
            loc_lAchou = SEEK(loc_cChave)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cheque por data")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarChequePorValor - Localiza cheque no cursor por valor
    *--------------------------------------------------------------------------
    FUNCTION BuscarChequePorValor(par_nValor, par_cBancos, par_cAgencias, par_cNcontas, par_cNcheques)
        LOCAL loc_lAchou, loc_oErro, loc_cChave

        loc_lAchou = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques)
                loc_lSucesso = .F.
            ENDIF

            loc_cChave = STR(par_nValor, 12, 2) + PADR(par_cBancos, 3) + ;
                         PADR(par_cAgencias, 4) + PADR(par_cNcontas, 10) + PADR(par_cNcheques, 6)

            SELECT (THIS.this_cCursorCheques)
            SET ORDER TO Valor
            loc_lAchou = SEEK(loc_cChave)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cheque por valor")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararImpressaoMatricial - Busca range de cheques para impressao matricial
    * par_cBancos, par_cChIni, par_cChFin: banco e range de numeros de cheque
    *--------------------------------------------------------------------------
    FUNCTION PrepararImpressaoMatricial(par_cBancos, par_cChIni, par_cChFin)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk

        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cBancos)
                MsgAviso("Banco n" + CHR(227) + "o preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(par_cChIni)
                MsgAviso("N" + CHR(250) + "mero do cheque inicial n" + CHR(227) + "o preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(par_cChFin)
                MsgAviso("N" + CHR(250) + "mero do cheque final n" + CHR(227) + "o preenchido.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF par_cChFin < par_cChIni
                MsgAviso("Cheque final deve ser maior ou igual ao inicial.", "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_ChequesMatricial")
                USE IN cursor_4c_ChequesMatricial
            ENDIF

            loc_cSQL = "SELECT bancos,valors,ncheques,datas,nemissoes,ncancelas,favos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE bancos = " + EscaparSQL(par_cBancos) + ;
                       " AND ncheques BETWEEN " + EscaparSQL(par_cChIni) + ;
                       " AND " + EscaparSQL(par_cChFin) + ;
                       " ORDER BY ncheques"

            loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequesMatricial")
            IF loc_nOk < 1
                MsgErro("Falha ao carregar cheques para impress" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ChequesMatricial
            GO TOP

            IF EOF()
                MsgAviso("Nenhum cheque encontrado no intervalo informado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar impress" + CHR(227) + "o matricial")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararImpressaoChequesMarcados - Verifica consistencia dos cheques marcados
    * (todos devem ser do mesmo banco) e prepara cursor de impressao
    *--------------------------------------------------------------------------
    FUNCTION PrepararImpressaoChequesMarcados()
        LOCAL loc_lSucesso, loc_oErro, loc_nRecno, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorCheques)
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorCheques)
            loc_nRecno = RECNO()

            IF USED("cursor_4c_TmpBancos")
                USE IN cursor_4c_TmpBancos
            ENDIF

            SELECT DISTINCT Bancos ;
              FROM (THIS.this_cCursorCheques) ;
             WHERE NMarca1s = 1 ;
              INTO CURSOR cursor_4c_TmpBancos

            SELECT cursor_4c_TmpBancos
            GO TOP

            IF EOF()
                MsgAviso("Nenhum cheque marcado para impress" + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("cursor_4c_TmpBancos") > 1
                MsgAviso("Todos os cheques selecionados devem ser do mesmo banco.", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT (THIS.this_cCursorCheques)
                IF BETWEEN(loc_nRecno, 1, RECCOUNT(THIS.this_cCursorCheques))
                    GO loc_nRecno
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_ChequesImpressao")
                USE IN cursor_4c_ChequesImpressao
            ENDIF

            SELECT bancos, valors, ncheques, datas, nemitidos, ncancelas, favos ;
              FROM (THIS.this_cCursorCheques) ;
             WHERE NMarca1s = 1 ;
             ORDER BY ncheques ;
              INTO CURSOR cursor_4c_ChequesImpressao

            SELECT cursor_4c_ChequesImpressao
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar impress" + CHR(227) + "o de cheques")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Valida codigo de grupo (conta contabil) informado
    * Retorna .T. se valido, popula this_cDsGrupos
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupo(par_cCodigo)
        LOCAL loc_lValido, loc_oErro, loc_cSQL

        loc_lValido = .F.

        TRY
            IF EMPTY(par_cCodigo)
                THIS.this_cDsGrupos = ""
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_GrupoTemp")
                USE IN cursor_4c_GrupoTemp
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTemp") > 0
                SELECT cursor_4c_GrupoTemp
                GO TOP
                IF !EOF()
                    THIS.this_cDsGrupos = RTRIM(descrs)
                    loc_lValido = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar grupo")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarConta - Valida codigo de conta corrente informado
    * Retorna .T. se valido, popula this_cDsContas
    *--------------------------------------------------------------------------
    FUNCTION ValidarConta(par_cCodigo)
        LOCAL loc_lValido, loc_oErro, loc_cSQL

        loc_lValido = .F.

        TRY
            IF EMPTY(par_cCodigo)
                THIS.this_cDsContas = ""
                IF USED(THIS.this_cCursorCheques)
                    SELECT (THIS.this_cCursorCheques)
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ContaTemp")
                USE IN cursor_4c_ContaTemp
            ENDIF

            loc_cSQL = "SELECT TOP 1 b.IClis, b.RClis " + ;
                       "FROM SigOpFp a, SigCdCli b " + ;
                       "WHERE a.EmiChqs = 1 AND b.IClis = a.ContaDs " + ;
                       "AND b.IClis = " + EscaparSQL(par_cCodigo)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaTemp") > 0
                SELECT cursor_4c_ContaTemp
                GO TOP
                IF !EOF()
                    THIS.this_cDsContas = RTRIM(RClis)
                    loc_lValido = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar conta")
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do cheque corrente
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir da linha corrente do cursor
    * Padrao: par_cAliasCursor eh o alias que o Form usa como fonte (cursor_4c_Cheques)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias

        loc_lSucesso = .F.

        TRY
            loc_cAlias = IIF(TYPE("par_cAliasCursor") = "C" AND !EMPTY(par_cAliasCursor), ;
                             par_cAliasCursor, THIS.this_cCursorCheques)

            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o est" + CHR(225) + "vel dispon" + CHR(237) + "vel."
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)

            IF EOF()
                THIS.this_cMensagemErro = "Nenhum registro na posi" + CHR(231) + CHR(227) + "o corrente."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cEmps        = TratarNulo(emps, "C")
            THIS.this_cDopes       = TratarNulo(dopes, "C")
            THIS.this_nNumes       = TratarNulo(numes, "N")
            THIS.this_dDatas       = TratarNulo(datas, "D")
            THIS.this_cBancos      = TratarNulo(bancos, "C")
            THIS.this_cAgencias    = TratarNulo(agencias, "C")
            THIS.this_cNcontas     = TratarNulo(ncontas, "C")
            THIS.this_cNcheques    = TratarNulo(ncheques, "C")
            THIS.this_cContas      = TratarNulo(contas, "C")
            THIS.this_nValors      = TratarNulo(valors, "N")
            THIS.this_cFavos       = TratarNulo(favos, "C")
            THIS.this_nNcopias     = TratarNulo(ncopias, "N")
            THIS.this_nNemissoes   = TratarNulo(nemissoes, "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")

            IF TYPE(loc_cAlias + ".JustCanc") != "U"
                THIS.this_cJustcanc = TratarNulo(JustCanc, "C")
            ENDIF

            IF TYPE(loc_cAlias + ".NEmitidos") != "U"
                THIS.this_nNemitidos = TratarNulo(NEmitidos, "N")
                THIS.this_lEmitidos  = (THIS.this_nNemitidos = 1)
            ENDIF

            IF TYPE(loc_cAlias + ".NCancelas") != "U"
                THIS.this_nNcancelas = TratarNulo(NCancelas, "N")
                THIS.this_lCancelas  = (THIS.this_nNcancelas = 1)
            ENDIF

            IF TYPE(loc_cAlias + ".Grupos") != "U"
                THIS.this_cGrupos = TratarNulo(Grupos, "C")
            ENDIF

            IF TYPE(loc_cAlias + ".empdopnums") != "U"
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
            ELSE
                THIS.this_cEmpdopnums = RTRIM(THIS.this_cEmps) + RTRIM(THIS.this_cDopes) + STR(THIS.this_nNumes, 6)
            ENDIF

            IF TYPE(loc_cAlias + ".vencs") != "U"
                THIS.this_dVencs = TratarNulo(vencs, "D")
            ENDIF

            IF TYPE(loc_cAlias + ".versos") != "U"
                THIS.this_cVersos = TratarNulo(versos, "C")
            ENDIF

            IF TYPE(loc_cAlias + ".impversos") != "U"
                THIS.this_nImpversos = TratarNulo(impversos, "N")
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo na SigCqChi para novo cheque
    * Chamado indiretamente por BusinessBase.Salvar() em modo INCLUIR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk, loc_cChave

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = RTRIM(THIS.this_cBancos)   + ;
                                       RTRIM(THIS.this_cAgencias) + ;
                                       RTRIM(THIS.this_cNcontas)  + ;
                                       RTRIM(THIS.this_cNcheques)
            ENDIF

            IF EMPTY(THIS.this_cEmpdopnums)
                THIS.this_cEmpdopnums = RTRIM(THIS.this_cEmps) + ;
                                        RTRIM(THIS.this_cDopes) + ;
                                        STR(THIS.this_nNumes, 6)
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATE()
            ENDIF

            loc_cSQL = "INSERT INTO SigCqChi (" + ;
                       "emps, dopes, numes, datas, bancos, agencias, ncontas, ncheques, " + ;
                       "contas, valors, favos, ncopias, nemissoes, emitidos, cancelas, " + ;
                       "grupos, cidchaves, empdopnums, JustCanc, vencs, versos, impversos" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3))       + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopes, 20))     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cBancos, 3))     + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cAgencias, 4))   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cNcontas, 10))   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cNcheques, 6))   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cContas, 10))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors, 2)    + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cFavos, 40))     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNcopias, 0)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNemissoes, 0) + ", " + ;
                       IIF(THIS.this_lEmitidos, "1", "0")         + ", " + ;
                       IIF(THIS.this_lCancelas, "1", "0")         + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cGrupos, 10))    + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29))+ ", " + ;
                       EscaparSQL(THIS.this_cJustcanc)            + ", " + ;
                       IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       EscaparSQL(THIS.this_cVersos)              + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpversos, 0) + ")"

            loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nOk < 1
                THIS.this_cMensagemErro = "Falha ao inserir cheque na SigCqChi."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir cheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo na SigCqChi para cheque existente
    * Chamado indiretamente por BusinessBase.Salvar() em modo ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave do cheque (cidchaves) n" + CHR(227) + "o informada."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "emps = "       + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                       "dopes = "      + EscaparSQL(LEFT(THIS.this_cDopes, 20))      + ", " + ;
                       "numes = "      + FormatarNumeroSQL(THIS.this_nNumes, 0)      + ", " + ;
                       "datas = "      + FormatarDataSQL(THIS.this_dDatas)           + ", " + ;
                       "bancos = "     + EscaparSQL(LEFT(THIS.this_cBancos, 3))      + ", " + ;
                       "agencias = "   + EscaparSQL(LEFT(THIS.this_cAgencias, 4))    + ", " + ;
                       "ncontas = "    + EscaparSQL(LEFT(THIS.this_cNcontas, 10))    + ", " + ;
                       "ncheques = "   + EscaparSQL(LEFT(THIS.this_cNcheques, 6))    + ", " + ;
                       "contas = "     + EscaparSQL(LEFT(THIS.this_cContas, 10))     + ", " + ;
                       "valors = "     + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                       "favos = "      + EscaparSQL(LEFT(THIS.this_cFavos, 40))      + ", " + ;
                       "ncopias = "    + FormatarNumeroSQL(THIS.this_nNcopias, 0)    + ", " + ;
                       "nemissoes = "  + FormatarNumeroSQL(THIS.this_nNemissoes, 0)  + ", " + ;
                       "emitidos = "   + IIF(THIS.this_lEmitidos, "1", "0")          + ", " + ;
                       "cancelas = "   + IIF(THIS.this_lCancelas, "1", "0")          + ", " + ;
                       "grupos = "     + EscaparSQL(LEFT(THIS.this_cGrupos, 10))     + ", " + ;
                       "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       "JustCanc = "   + EscaparSQL(THIS.this_cJustcanc)             + ", " + ;
                       "vencs = "      + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       "versos = "     + EscaparSQL(THIS.this_cVersos)               + ", " + ;
                       "impversos = "  + FormatarNumeroSQL(THIS.this_nImpversos, 0)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(RTRIM(THIS.this_cCidchaves))

            loc_nOk = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nOk < 1
                THIS.this_cMensagemErro = "Falha ao atualizar cheque na SigCqChi."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar cheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do cheque corrente na SigCqChi
    * Chamado indiretamente por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nOk

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave do cheque (cidchaves) n" + CHR(227) + "o informada."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(RTRIM(THIS.this_cCidchaves))
            loc_nOk  = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nOk < 1
                THIS.this_cMensagemErro = "Falha ao excluir cheque da SigCqChi."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir cheque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Libera todos os cursores gerenciados por este BO
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * ImprimirCheques - Impressao fisica de cheques em impressora de cheque
    * par_cBancos: banco dos cheques (todos do mesmo banco)
    * Pre-req: cursor_4c_ImpTemp com colunas Bancos,Agencias,NContas,NCheques,
    *          cIdChaves,Valors,Datas,NEmitidos,NCancelas,Favos
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirCheques(par_cBancos)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nPrinters, loc_nConta1
        LOCAL loc_cNomeImp1, loc_cNomeImp2, loc_cPrnIni
        LOCAL loc_nMaxCol, loc_nLivl1, loc_nClvl1
        LOCAL loc_nLivext1, loc_nClvext1, loc_nLivext2, loc_nClvext2
        LOCAL loc_nLinom1, loc_nClnom1, loc_nLicid1, loc_nClcid1
        LOCAL loc_nLidia1, loc_nCldia1, loc_nLimes1, loc_nClmes1
        LOCAL loc_nLiano1, loc_nClano1
        LOCAL loc_cPoint, loc_cSeparator, loc_cStrgMes
        LOCAL loc_oProgressBar
        LOCAL loc_cStrImp1, loc_cStrImp2, loc_cSQL
        LOCAL laPrinters(1)

        loc_lSucesso  = .F.
        loc_cPoint     = SET("Point")
        loc_cSeparator = SET("Separator")
        loc_cStrgMes   = "Janeiro  Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                         "Abril    Maio     Junho    Julho    " + ;
                         "Agosto   Setembro Outubro  Novembro Dezembro "

        TRY
            IF !USED("cursor_4c_ImpTemp") OR RECCOUNT("cursor_4c_ImpTemp") = 0
                MsgAviso("Nenhum cheque marcado para impress" + CHR(227) + "o.", "Cheque")
                loc_lSucesso = .F.
            ENDIF

            IF !USED(THIS.this_cCursorModelos) OR RECCOUNT(THIS.this_cCursorModelos) = 0
                MsgAviso("Nenhum modelo de cheque configurado em SigCdmp.", "Cheque")
                loc_lSucesso = .F.
            ENDIF

            *-- Construir lista de impressoras de cheque (nchqfs=1) x impressoras Windows
            IF USED("cursor_4c_ImpLista1")
                USE IN cursor_4c_ImpLista1
            ENDIF
            IF USED("cursor_4c_ImpLista2")
                USE IN cursor_4c_ImpLista2
            ENDIF

            SELECT DISTINCT impres AS cNomeImp1s, SPACE(100) AS cNomeImp2s, 0 AS nMarca1s ;
              FROM (THIS.this_cCursorModelos) ;
             WHERE nchqfs = 1 ;
             ORDER BY impres ;
              INTO CURSOR cursor_4c_ImpLista1 READWRITE

            SELECT cursor_4c_ImpLista1
            GO TOP
            IF EOF("cursor_4c_ImpLista1")
                MsgAviso("Nenhuma impressora de cheque configurada em SigCdmp.", "Cheque")
                loc_lSucesso = .F.
            ENDIF

            loc_nPrinters = APRINTERS(laPrinters)
            SELECT cursor_4c_ImpLista1
            SCAN
                loc_cNomeImp1 = LOWER(ALLTRIM(cursor_4c_ImpLista1.cNomeImp1s))
                FOR loc_nConta1 = 1 TO loc_nPrinters
                    IF LOWER(ALLTRIM(JUSTFNAME(laPrinters(loc_nConta1, 1)))) == loc_cNomeImp1
                        REPLACE cNomeImp2s WITH ALLTRIM(laPrinters(loc_nConta1, 1))
                        REPLACE nMarca1s   WITH 1
                        EXIT
                    ENDIF
                ENDFOR
            ENDSCAN

            SELECT DISTINCT cNomeImp1s, cNomeImp2s ;
              FROM cursor_4c_ImpLista1 ;
             WHERE nMarca1s = 1 ;
             ORDER BY cNomeImp1s ;
              INTO CURSOR cursor_4c_ImpLista2 READWRITE

            SELECT cursor_4c_ImpLista2
            GO TOP
            IF EOF("cursor_4c_ImpLista2")
                MsgAviso("Nenhuma impressora de cheque dispon" + CHR(237) + "vel no Windows. " + ;
                         "Verifique o cadastro de modelos (SigCdmp).", "Cheque")
                loc_lSucesso = .F.
            ENDIF

            *-- Selecionar impressora (picker se multiplas)
            IF RECCOUNT("cursor_4c_ImpLista2") > 1
                LOCAL loc_oFormImp
                loc_cNomeImp2 = ""
                loc_oFormImp = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "", "cursor_4c_ImpLista2", ;
                    "cNomeImp2s", "", ;
                    "Selecionar Impressora de Cheque", .T., .T., "")
                IF VARTYPE(loc_oFormImp) = "O"
                    loc_oFormImp.mAddColuna("cNomeImp1s", "", "Modelo")
                    loc_oFormImp.mAddColuna("cNomeImp2s", "", "Impressora")
                    loc_oFormImp.Show()
                    IF loc_oFormImp.this_lSelecionou AND USED("cursor_4c_ImpLista2")
                        SELECT cursor_4c_ImpLista2
                        loc_cNomeImp2 = ALLTRIM(cNomeImp2s)
                    ENDIF
                ENDIF
                IF EMPTY(loc_cNomeImp2)
                    loc_lSucesso = .F.
                ENDIF
                SELECT cursor_4c_ImpLista2
                LOCATE FOR ALLTRIM(cNomeImp2s) == ALLTRIM(loc_cNomeImp2)
                IF FOUND()
                    loc_cNomeImp1 = ALLTRIM(cNomeImp1s)
                ENDIF
            ELSE
                loc_cNomeImp2 = ALLTRIM(cursor_4c_ImpLista2.cNomeImp2s)
                loc_cNomeImp1 = ALLTRIM(cursor_4c_ImpLista2.cNomeImp1s)
            ENDIF

            *-- Ler posicoes do modelo no cursor de modelos
            SELECT (THIS.this_cCursorModelos)
            LOCATE FOR LOWER(ALLTRIM(impres)) == LOWER(loc_cNomeImp1)
            IF !FOUND()
                MsgErro("Modelo '" + loc_cNomeImp1 + "' n" + CHR(227) + "o encontrado em SigCdmp.", "Cheque")
                loc_lSucesso = .F.
            ENDIF

            loc_cPrnIni  = ALLTRIM(fontes)
            IF !EMPTY(loc_cPrnIni)
                loc_cPrnIni = EVALUATE(loc_cPrnIni)
            ENDIF
            loc_nMaxCol  = maxcols
            loc_nLivl1   = nlivl1s
            loc_nClvl1   = nclvl1s
            loc_nLivext1 = nlivext1s
            loc_nClvext1 = nclvext1s
            loc_nLivext2 = nlivext2s
            loc_nClvext2 = nclvext2s
            loc_nLinom1  = nlinom1s
            loc_nClnom1  = nclnom1s
            loc_nLicid1  = nlicid1s
            loc_nClcid1  = nclcid1s
            loc_nLidia1  = nlidia1s
            loc_nCldia1  = ncldia1s
            loc_nLimes1  = nlimes1s
            loc_nClmes1  = nclmes1s
            loc_nLiano1  = nliano1s
            loc_nClano1  = nclano1s

            *-- Configurar impressora e formatacao numerica
            SET PRINTER TO NAME (loc_cNomeImp2)
            SET DEVICE TO PRINTER
            SET POINT TO ","
            SET SEPARATOR TO "."

            IF !EMPTY(loc_cPrnIni)
                @ 0, 0 SAY loc_cPrnIni FONT "Courier New", 10 STYLE "N"
            ENDIF

            loc_oProgressBar = CREATEOBJECT("fwprogressbar", ;
                "Imprimindo Cheque(s) Selecionado(s)...", ;
                RECCOUNT("cursor_4c_ImpTemp"))
            IF VARTYPE(loc_oProgressBar) = "O"
                loc_oProgressBar.Show()
            ENDIF

            SELECT cursor_4c_ImpTemp
            GO TOP
            SCAN
                IF USED("cursor_4c_TmpPar")
                    USE IN cursor_4c_TmpPar
                ENDIF

                loc_cSQL = "SELECT valos, vencs FROM SigMvPar " + ;
                           "WHERE bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_ImpTemp.Bancos))   + ;
                           " AND agencias = "  + EscaparSQL(ALLTRIM(cursor_4c_ImpTemp.Agencias)) + ;
                           " AND contas = "    + EscaparSQL(ALLTRIM(cursor_4c_ImpTemp.NContas))  + ;
                           " AND numeros = "   + EscaparSQL(ALLTRIM(cursor_4c_ImpTemp.NCheques))

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPar") > 0
                    SELECT cursor_4c_TmpPar
                    GO TOP
                    IF !EOF()
                        loc_cStrImp1 = "#" + ALLTRIM(TRANSFORM(cursor_4c_TmpPar.valos, "999,999,999.99")) + "#"
                        @ loc_nLivl1, loc_nClvl1 SAY loc_cStrImp1 FONT "Courier New", 10 STYLE "N"

                        loc_cStrImp1 = IIF(TYPE("fValorExtenso") = "FN", ;
                                           ALLTRIM(fValorExtenso(cursor_4c_TmpPar.valos)), "")
                        loc_cStrImp2 = loc_cStrImp1
                        IF LEN(loc_cStrImp2) > (loc_nMaxCol - loc_nClvext1)
                            loc_cStrImp2 = LEFT(loc_cStrImp2, loc_nMaxCol - loc_nClvext1)
                            IF !EMPTY(SUBSTR(loc_cStrImp1, LEN(loc_cStrImp2) + 1))
                                loc_cStrImp2 = SUBSTR(loc_cStrImp2, 1, RAT(" ", loc_cStrImp2))
                            ENDIF
                        ENDIF
                        @ loc_nLivext1, loc_nClvext1 SAY loc_cStrImp2 FONT "Courier New", 10 STYLE "N"

                        loc_cStrImp2 = SUBSTR(loc_cStrImp1, LEN(loc_cStrImp2) + 1)
                        loc_cStrImp2 = PADR(loc_cStrImp2, MIN(LEN(loc_cStrImp2), loc_nMaxCol - loc_nClvext2))
                        @ loc_nLivext2, loc_nClvext2 SAY loc_cStrImp2 FONT "Courier New", 10 STYLE "N"

                        loc_cStrImp1 = PADR(ALLTRIM(cursor_4c_ImpTemp.Favos), ;
                                            MIN(LEN(ALLTRIM(cursor_4c_ImpTemp.Favos)), loc_nMaxCol - loc_nClnom1))
                        @ loc_nLinom1, loc_nClnom1 SAY loc_cStrImp1 FONT "Courier New", 10 STYLE "N"

                        @ loc_nLicid1, loc_nClcid1 SAY "" FONT "Courier New", 10 STYLE "N"

                        @ loc_nLidia1, loc_nCldia1 SAY ;
                            TRANSFORM(DAY(cursor_4c_TmpPar.vencs), "@L 99") ;
                            FONT "Courier New", 10 STYLE "N"
                        @ loc_nLimes1, loc_nClmes1 SAY ;
                            ALLTRIM(SUBSTR(loc_cStrgMes, MONTH(cursor_4c_TmpPar.vencs) * 9 - 8, 9)) ;
                            FONT "Courier New", 10 STYLE "N"
                        @ loc_nLiano1, loc_nClano1 SAY ;
                            TRANSFORM(YEAR(cursor_4c_TmpPar.vencs), "@L 9999") ;
                            FONT "Courier New", 10 STYLE "N"

                        loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 " + ;
                                   "WHERE cidchaves = " + EscaparSQL(ALLTRIM(cursor_4c_ImpTemp.cIdChaves))
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oProgressBar) = "O"
                    loc_oProgressBar.Update(.T.)
                ENDIF

                SELECT cursor_4c_ImpTemp
            ENDSCAN

            IF VARTYPE(loc_oProgressBar) = "O"
                loc_oProgressBar.Complete(.T.)
            ENDIF

            SET PRINTER TO DEFAULT
            SET DEVICE TO SCREEN
            SET CONSOLE ON

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            TRY
                SET PRINTER TO DEFAULT
                SET DEVICE TO SCREEN
                SET CONSOLE ON
            CATCH
            ENDTRY
            MsgErro(loc_oErro.Message, "Erro ao imprimir cheque")
        ENDTRY

        SET POINT TO (loc_cPoint)
        SET SEPARATOR TO (loc_cSeparator)

        IF USED("cursor_4c_ImpLista1")
            USE IN cursor_4c_ImpLista1
        ENDIF
        IF USED("cursor_4c_ImpLista2")
            USE IN cursor_4c_ImpLista2
        ENDIF
        IF USED("cursor_4c_TmpPar")
            USE IN cursor_4c_TmpPar
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirChequesMatricial - Impressao matricial de cheques por faixa
    * Pre-req: cursor_4c_MatrizTemp com colunas bancos,valors,ncheques,datas,
    *          emitidos,cancelas,favos (pre-construido pelo form)
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirChequesMatricial()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_MatrizTemp") OR RECCOUNT("cursor_4c_MatrizTemp") = 0
                MsgAviso("Nenhum cheque encontrado na faixa informada.", ;
                    "Impress" + CHR(227) + "o Matricial")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_MatrizTemp
            LOCATE FOR emitidos = 1
            IF FOUND()
                IF !MsgConfirma("Os cheques selecionados j" + CHR(225) + " foram emitidos. " + ;
                                "Confirma reimpress" + CHR(227) + "o ?", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            MsgInfo("Verifique se a impressora matricial est" + CHR(225) + ;
                    " pronta para impress" + CHR(227) + "o.", ;
                    "Impress" + CHR(227) + "o Matricial")

            SET PRINTER ON
            SET DEVICE TO PRINTER

            SELECT cursor_4c_MatrizTemp
            GO TOP
            SCAN
                @ PROW() + 1, 0 SAY "Banco.: " + ALLTRIM(cursor_4c_MatrizTemp.bancos) + ;
                                     "  Cheque: " + ALLTRIM(cursor_4c_MatrizTemp.ncheques) + ;
                                     "  Valor: " + ;
                                     ALLTRIM(TRANSFORM(cursor_4c_MatrizTemp.valors, "999,999,999.99"))
                @ PROW() + 1, 0 SAY "Favorecido: " + ALLTRIM(cursor_4c_MatrizTemp.favos)
                @ PROW() + 1, 0 SAY "Data: " + DTOC(cursor_4c_MatrizTemp.datas)
                @ PROW() + 1, 0 SAY REPLICATE("-", 60)

                loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 " + ;
                           "WHERE bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_MatrizTemp.bancos))   + ;
                           " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_MatrizTemp.ncheques))
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDSCAN

            EJECT
            SET DEVICE TO SCREEN
            SET PRINTER OFF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            TRY
                SET DEVICE TO SCREEN
                SET PRINTER OFF
            CATCH
            ENDTRY
            MsgErro(loc_oErro.Message, "Erro ao imprimir cheques matricial")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE LimparCursores()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorCheques)
                USE IN (THIS.this_cCursorCheques)
            ENDIF

            IF USED(THIS.this_cCursorContas)
                USE IN (THIS.this_cCursorContas)
            ENDIF

            IF USED(THIS.this_cCursorModelos)
                USE IN (THIS.this_cCursorModelos)
            ENDIF

            IF USED("cursor_4c_TmpConta")
                USE IN cursor_4c_TmpConta
            ENDIF

            IF USED("cursor_4c_TmpPrIt")
                USE IN cursor_4c_TmpPrIt
            ENDIF

            IF USED("cursor_4c_ChequesTemp")
                USE IN cursor_4c_ChequesTemp
            ENDIF

            IF USED("cursor_4c_ChequesImpressao")
                USE IN cursor_4c_ChequesImpressao
            ENDIF

            IF USED("cursor_4c_ChequesMatricial")
                USE IN cursor_4c_ChequesMatricial
            ENDIF

            IF USED("cursor_4c_TmpBancos")
                USE IN cursor_4c_TmpBancos
            ENDIF

            IF USED("cursor_4c_TmpMccr")
                USE IN cursor_4c_TmpMccr
            ENDIF

            IF USED("cursor_4c_TmpPar")
                USE IN cursor_4c_TmpPar
            ENDIF

            IF USED("cursor_4c_GrupoTemp")
                USE IN cursor_4c_GrupoTemp
            ENDIF

            IF USED("cursor_4c_ContaTemp")
                USE IN cursor_4c_ContaTemp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao liberar cursores")
        ENDTRY
    ENDPROC

ENDDEFINE
