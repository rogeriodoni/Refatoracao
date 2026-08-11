*================================================================================
* SigPrHprBO.prg - Business Object: Historico de Produtos (SIGPRHPR)
* Form: OPERACIONAL
* Tabela principal: SigMvHst (UPDATE de auditoria)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *-- Tabela e chave principal (SigMvHst recebe UPDATE de auditoria)
    this_cTabela     = "SigMvHst"
    this_cCampoChave = "cidchaves"

    *-- Parametros de contexto recebidos do form pai ao abrir
    this_cCdGrupo    = ""
    this_cCdConta    = ""
    this_cCdProduto  = ""
    this_cDsProduto  = ""
    this_dDataIni    = {}
    this_dDataFim    = {}
    this_cCodEmpresa = ""

    *-- Dados do registro corrente de SigMvHst (linha selecionada no grid)
    this_cEmps       = ""
    this_cEmpos      = ""
    this_cGrupos     = ""
    this_cEstos      = ""
    this_cCpros      = ""
    this_cDopes      = ""
    this_nNumes      = 0
    this_dDatas      = {}
    this_cAuditors   = ""
    this_dDtAudits   = {}
    this_nQtds       = 0
    this_cOpers      = ""
    this_nSQtds      = 0
    this_cObs        = ""
    this_cUsuars     = ""
    this_cCidChaves  = ""
    this_nPesos      = 0
    this_nSPesos     = 0
    this_cCunis      = ""
    this_cCunips     = ""
    this_cCestos     = ""
    this_cEmpDopNums = ""
    this_cEmpGruEsts = ""

    *-- Dados do documento (SigMvCab ou SigCdNec)
    this_cGrupoOri    = ""
    this_cContaOri    = ""
    this_cGrupoDes    = ""
    this_cContaDes    = ""
    this_cNotas       = ""

    *-- Descricoes do contabil (SigCdGcr e SigCdCli)
    this_cDesGrupoOri = ""
    this_cDesContaOri = ""
    this_cDesGrupoDes = ""
    this_cDesContaDes = ""

    *-- Controle interno de permissao e tipo de produto (Cestos='3' = produto peso)
    this_lTemAuditoria = .F.
    this_lEhPeso       = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cCodEmpresa = go_4c_Sistema.cCodEmpresa

            *-- Cursor placeholder para grid de historico
            *-- Estrutura espelha campos do SQLEXEC em CarregarHistorico
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico (;
                emps      C(3)    NULL, ;
                empos     C(3)    NULL, ;
                grupos    C(10)   NULL, ;
                estos     C(10)   NULL, ;
                cpros     C(14)   NULL, ;
                dopes     C(20)   NULL, ;
                numes     N(6,0)  NULL, ;
                datas     T       NULL, ;
                auditors  C(10)   NULL, ;
                dtaudits  T       NULL, ;
                qtds      N(9,3)  NULL, ;
                opers     C(1)    NULL, ;
                sqtds     N(11,3) NULL, ;
                obs       M       NULL, ;
                usuars    C(10)   NULL, ;
                cidchaves C(20)   NULL, ;
                pesos     N(15,3) NULL, ;
                spesos    N(15,3) NULL, ;
                cunis     C(3)    NULL  ;
            )
            INDEX ON DTOS(datas) TAG datas
            INDEX ON pesos TAG pesos
            SET NULL OFF

            *-- Cursor placeholder para grid de subniveis
            *-- Estrutura espelha crSubniveis do legado
            SET NULL ON
            CREATE CURSOR cursor_4c_Subniveis (;
                emps  C(3)   NULL, ;
                dopes C(20)  NULL, ;
                numes N(6,0) NULL  ;
            )
            INDEX ON emps TAG emps
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia dados da linha corrente do cursor para as props
    * Assinatura canonica CRUD (par_cAliasCursor). Alias flexivel para
    * cursor_4c_Historico ou qualquer outro cursor com estrutura de SigMvHst.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Historico", par_cAliasCursor)
            IF USED(loc_cAlias) AND RECCOUNT(loc_cAlias) > 0
                SELECT (loc_cAlias)
                THIS.this_cEmps      = TratarNulo(emps, "C")
                THIS.this_cEmpos     = TratarNulo(empos, "C")
                THIS.this_cGrupos    = TratarNulo(grupos, "C")
                THIS.this_cEstos     = TratarNulo(estos, "C")
                THIS.this_cCpros     = TratarNulo(cpros, "C")
                THIS.this_cDopes     = TratarNulo(dopes, "C")
                IF VARTYPE(numes) = "N"
                    THIS.this_nNumes = NVL(numes, 0)
                ELSE
                    THIS.this_nNumes = 0
                ENDIF
                THIS.this_dDatas     = NVL(datas, {})
                THIS.this_cAuditors  = TratarNulo(auditors, "C")
                THIS.this_dDtAudits  = NVL(dtaudits, {})
                IF VARTYPE(qtds) = "N"
                    THIS.this_nQtds  = NVL(qtds, 0)
                ELSE
                    THIS.this_nQtds  = 0
                ENDIF
                THIS.this_cOpers     = TratarNulo(opers, "C")
                IF VARTYPE(sqtds) = "N"
                    THIS.this_nSQtds = NVL(sqtds, 0)
                ELSE
                    THIS.this_nSQtds = 0
                ENDIF
                THIS.this_cObs       = TratarNulo(obs, "C")
                THIS.this_cUsuars    = TratarNulo(usuars, "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(pesos) = "N"
                    THIS.this_nPesos = NVL(pesos, 0)
                ELSE
                    THIS.this_nPesos = 0
                ENDIF
                IF TYPE(loc_cAlias + ".spesos") != "U"
                    IF VARTYPE(spesos) = "N"
                        THIS.this_nSPesos = NVL(spesos, 0)
                    ELSE
                        THIS.this_nSPesos = 0
                    ENDIF
                ENDIF
                IF TYPE(loc_cAlias + ".cunis") != "U"
                    THIS.this_cCunis = TratarNulo(cunis, "C")
                ENDIF
                THIS.this_lTemAuditoria = (NOT EMPTY(ALLTRIM(THIS.this_cAuditors)))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDoCursor]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este form eh OPERACIONAL de leitura (historico de produtos).
    * Registros em SigMvHst sao gerados por movimentacoes de outros modulos,
    * NUNCA inseridos manualmente por este cadastro. Assim, Inserir() bloqueia
    * a operacao e retorna .F., garantindo que o form Salvar() (chamado pela
    * FormBase por engano) nao corrompa o historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido incluir registros no hist" + CHR(243) + "rico de produtos. Movimenta" + CHR(231) + CHR(245) + "es s" + CHR(227) + "o geradas pelos m" + CHR(243) + "dulos operacionais."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvHst dos campos de auditoria (auditors/dtaudits).
    * Aplica ou remove marca de auditor conforme this_lTemAuditoria.
    * Registra evento em LogAuditoria via RegistrarAuditoria("UPDATE").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nQueryOk, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Nenhum registro selecionado para atualizar."
            ELSE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                IF THIS.this_lTemAuditoria
                    *-- Marcar como auditado pelo usuario logado
                    loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(loc_cUsuario) + ;
                               ", dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ELSE
                    *-- Remover marca de auditoria
                    loc_cSQL = "UPDATE SigMvHst SET auditors = '          ', dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ENDIF

                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar auditoria do hist" + CHR(243) + "rico."
                ELSE
                    *-- Sincronizar cursor local + props
                    IF USED("cursor_4c_Historico")
                        SELECT cursor_4c_Historico
                        IF THIS.this_lTemAuditoria
                            REPLACE auditors WITH loc_cUsuario, dtaudits WITH DATETIME()
                            THIS.this_cAuditors = loc_cUsuario
                            THIS.this_dDtAudits = DATETIME()
                        ELSE
                            REPLACE auditors WITH SPACE(10), dtaudits WITH {}
                            THIS.this_cAuditors = ""
                            THIS.this_dDtAudits = {}
                        ENDIF
                    ENDIF
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " [Atualizar]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override com GETDATE() nativo do SQL Server.
    * Regra: NUNCA usar GETDATE() em campo DataHora
    * (rejeita tipo T, gera INSERT NULL em NOT NULL). Lesson 2026-07-08.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario
        loc_cChave = THIS.ObterChavePrimaria()
        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF
        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"
        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico
    *-- Carrega SigMvHst para cursor_4c_Historico conforme parametros do form pai
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL, loc_cEmpGruEst, loc_cDtIni, loc_cDtFim
        loc_lSucesso = .F.
        TRY
            loc_cEmpGruEst = THIS.this_cCodEmpresa + THIS.this_cCdGrupo + THIS.this_cCdConta
            loc_cDtIni     = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFim     = FormatarDataSQL(THIS.this_dDataFim)

            loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, " + ;
                       "a.dopes, a.numes, a.datas, a.auditors, a.dtaudits, " + ;
                       "a.qtds, a.opers, a.sqtds, a.obs, a.usuars, " + ;
                       "a.cidchaves, a.pesos, a.spesos, '   ' AS cunis " + ;
                       "FROM SigMvHst a " + ;
                       "WHERE a.empgruests = " + EscaparSQL(loc_cEmpGruEst) + ;
                       " AND a.cpros = " + EscaparSQL(THIS.this_cCdProduto) + ;
                       " AND CAST(a.datas AS DATE) >= " + loc_cDtIni + ;
                       " AND CAST(a.datas AS DATE) <= " + loc_cDtFim + ;
                       " ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar hist" + CHR(243) + "rico de produtos.", "Erro")
            ELSE
                SELECT cursor_4c_Historico
                ZAP
                APPEND FROM DBF("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp

                THIS.CarregarDadosProduto()

                IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                    SELECT cursor_4c_Historico
                    REPLACE ALL cunis WITH THIS.this_cCunis
                ENDIF

                SELECT cursor_4c_Historico
                INDEX ON DTOS(datas) TAG datas
                INDEX ON pesos TAG pesos
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarHistorico]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosProduto
    *-- Carrega SigCdPro e SigCdUni para o produto corrente
    *-- Preenche this_cCunis, this_cCunips, this_cCestos, this_lEhPeso
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(THIS.this_cCdProduto), "cursor_4c_TmpPro")
            IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                GO TOP
                THIS.this_cCunis  = NVL(cursor_4c_TmpPro.cunis, "")
                THIS.this_cCunips = NVL(cursor_4c_TmpPro.cunips, "")
            ELSE
                THIS.this_cCunis  = ""
                THIS.this_cCunips = ""
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            THIS.this_cCestos = ""
            IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT Cestos FROM SigCdUni WHERE cunis = " + ;
                    EscaparSQL(THIS.this_cCunis), "cursor_4c_TmpUni")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpUni") AND RECCOUNT("cursor_4c_TmpUni") > 0
                    SELECT cursor_4c_TmpUni
                    GO TOP
                    THIS.this_cCestos = NVL(cursor_4c_TmpUni.Cestos, "")
                ENDIF
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
            ENDIF

            THIS.this_lEhPeso = (THIS.this_cCestos = "3")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosProduto]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosLinhaSelecionada
    *-- Copia dados do registro corrente de cursor_4c_Historico para props this_*
    *-- Chamado pelo form apos AfterRowColChange
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                THIS.this_cEmps      = NVL(cursor_4c_Historico.emps, "")
                THIS.this_cEmpos     = NVL(cursor_4c_Historico.empos, "")
                THIS.this_cGrupos    = NVL(cursor_4c_Historico.grupos, "")
                THIS.this_cEstos     = NVL(cursor_4c_Historico.estos, "")
                THIS.this_cCpros     = NVL(cursor_4c_Historico.cpros, "")
                THIS.this_cDopes     = NVL(cursor_4c_Historico.dopes, "")
                THIS.this_nNumes     = NVL(cursor_4c_Historico.numes, 0)
                THIS.this_dDatas     = NVL(cursor_4c_Historico.datas, {})
                THIS.this_cAuditors  = NVL(cursor_4c_Historico.auditors, "")
                THIS.this_dDtAudits  = NVL(cursor_4c_Historico.dtaudits, {})
                THIS.this_nQtds      = NVL(cursor_4c_Historico.qtds, 0)
                THIS.this_cOpers     = NVL(cursor_4c_Historico.opers, "")
                THIS.this_nSQtds     = NVL(cursor_4c_Historico.sqtds, 0)
                THIS.this_cObs       = NVL(cursor_4c_Historico.obs, "")
                THIS.this_cUsuars    = NVL(cursor_4c_Historico.usuars, "")
                THIS.this_cCidChaves = NVL(cursor_4c_Historico.cidchaves, "")
                THIS.this_nPesos     = NVL(cursor_4c_Historico.pesos, 0)
                THIS.this_nSPesos    = NVL(cursor_4c_Historico.spesos, 0)
                THIS.this_cCunis     = NVL(cursor_4c_Historico.cunis, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosLinhaSelecionada]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDocumento
    *-- Carrega documento (SigMvCab ou SigCdNec) do registro corrente
    *-- Tenta SigMvCab primeiro (empdopnums); se vazio, tenta SigCdNec (empdnps)
    *-- Preenche this_cGrupoOri, this_cContaOri, this_cGrupoDes, this_cContaDes, this_cNotas
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_lSucesso = .F.
        TRY
            THIS.this_cGrupoOri = ""
            THIS.this_cContaOri = ""
            THIS.this_cGrupoDes = ""
            THIS.this_cContaDes = ""
            THIS.this_cNotas    = ""

            loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
            loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

            IF USED("cursor_4c_DocTemp")
                USE IN cursor_4c_DocTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas " + ;
                "FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNum), ;
                "cursor_4c_DocTemp")

            IF loc_nQueryOk >= 1 AND USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") = 0
                USE IN cursor_4c_DocTemp
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT grupoos, contaos, grupods, contads, '      ' AS Notas " + ;
                    "FROM SigCdNec " + ;
                    "WHERE empdnps = " + EscaparSQL(loc_cEmpDopNumLong), ;
                    "cursor_4c_DocTemp")
            ENDIF

            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar documento do movimento.", "Erro")
            ELSE
                IF USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") > 0
                    SELECT cursor_4c_DocTemp
                    GO TOP
                    THIS.this_cGrupoOri = NVL(cursor_4c_DocTemp.grupoos, "")
                    THIS.this_cContaOri = NVL(cursor_4c_DocTemp.contaos, "")
                    THIS.this_cGrupoDes = NVL(cursor_4c_DocTemp.grupods, "")
                    THIS.this_cContaDes = NVL(cursor_4c_DocTemp.contads, "")
                    THIS.this_cNotas    = NVL(cursor_4c_DocTemp.Notas, "")
                ENDIF
                IF USED("cursor_4c_DocTemp")
                    USE IN cursor_4c_DocTemp
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDocumento]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesContabil
    *-- Carrega descricoes de grupos (SigCdGcr) e contas (SigCdCli)
    *-- Preenche this_cDesGrupoOri/Des e this_cDesContaOri/Des
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        LOCAL loc_cGruOri, loc_cConOri, loc_cGruDes, loc_cConDes
        loc_lSucesso = .F.
        TRY
            loc_cGruOri = THIS.this_cGrupoOri
            loc_cConOri = THIS.this_cContaOri
            loc_cGruDes = THIS.this_cGrupoDes
            loc_cConDes = THIS.this_cContaDes

            THIS.this_cDesGrupoOri = ""
            THIS.this_cDesContaOri = ""
            THIS.this_cDesGrupoDes = ""
            THIS.this_cDesContaDes = ""

            *-- Grupos via SigCdGcr (coluna descrs COM r)
            IF USED("cursor_4c_TmpGcr")
                USE IN cursor_4c_TmpGcr
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cGruOri)) OR NOT EMPTY(ALLTRIM(loc_cGruDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr " + ;
                    "WHERE codigos = " + EscaparSQL(loc_cGruOri) + ;
                    " OR codigos = " + EscaparSQL(loc_cGruDes), ;
                    "cursor_4c_TmpGcr")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpGcr") AND RECCOUNT("cursor_4c_TmpGcr") > 0
                    SELECT cursor_4c_TmpGcr
                    INDEX ON codigos TAG codigos
                    GO TOP
                    THIS.this_cDesGrupoOri = IIF(SEEK(loc_cGruOri, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                    THIS.this_cDesGrupoDes = IIF(SEEK(loc_cGruDes, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpGcr")
                    USE IN cursor_4c_TmpGcr
                ENDIF
            ENDIF

            *-- Contas via SigCdCli
            IF USED("cursor_4c_TmpCli")
                USE IN cursor_4c_TmpCli
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cConOri)) OR NOT EMPTY(ALLTRIM(loc_cConDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SigCdCli " + ;
                    "WHERE iclis = " + EscaparSQL(loc_cConOri) + ;
                    " OR iclis = " + EscaparSQL(loc_cConDes), ;
                    "cursor_4c_TmpCli")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                    SELECT cursor_4c_TmpCli
                    INDEX ON iclis TAG iclis
                    GO TOP
                    THIS.this_cDesContaOri = IIF(SEEK(loc_cConOri, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                    THIS.this_cDesContaDes = IIF(SEEK(loc_cConDes, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDescricoesContabil]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubniveis
    *-- Carrega SigMvPec para cursor_4c_Subniveis do registro corrente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEdn, loc_cSQL
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Subniveis
            ZAP

            loc_cEdn = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, " + ;
                       "RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
                       "FROM SigMvPec a, SigCdOpe b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
                       "ORDER BY 1, 2, 3"

            IF USED("cursor_4c_SubniveisTemp")
                USE IN cursor_4c_SubniveisTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubniveisTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar subniveis.", "Erro")
            ELSE
                IF USED("cursor_4c_SubniveisTemp") AND RECCOUNT("cursor_4c_SubniveisTemp") > 0
                    SELECT cursor_4c_SubniveisTemp
                    SCAN
                        INSERT INTO cursor_4c_Subniveis (emps, dopes, numes) ;
                            VALUES (cursor_4c_SubniveisTemp.Emps, ;
                                    cursor_4c_SubniveisTemp.Dopes, ;
                                    VAL(cursor_4c_SubniveisTemp.Numes))
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_SubniveisTemp")
                    USE IN cursor_4c_SubniveisTemp
                ENDIF
                SELECT cursor_4c_Subniveis
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarSubniveis]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AuditarRegistro
    *-- Marca registro corrente como auditado pelo usuario logado em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado para auditar.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao registrar auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao registrar data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH gc_4c_UsuarioLogado
                            REPLACE dtaudits WITH DATETIME()
                        ENDIF
                        THIS.this_cAuditors = gc_4c_UsuarioLogado
                        THIS.this_dDtAudits = DATETIME()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [AuditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE DesauditarRegistro
    *-- Remove marca de auditoria do registro corrente em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = '          ' " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao remover auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao remover data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH SPACE(10)
                            REPLACE dtaudits WITH {}
                        ENDIF
                        THIS.this_cAuditors = ""
                        THIS.this_dDtAudits = {}
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [DesauditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarPermissaoAuditoria
    *-- Retorna .T. se o usuario logado pode auditar o registro corrente
    *-- Supervisor (4CONTROL) sempre pode; outros: apenas registros sem auditor
    *-- ou registros que o proprio usuario auditou
    *--------------------------------------------------------------------------
        LOCAL loc_lPermitido, loc_lSupervisor
        loc_lPermitido  = .F.
        TRY
            loc_lSupervisor = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = "4CONTROL")
            IF loc_lSupervisor
                loc_lPermitido = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cAuditors))
                    loc_lPermitido = .T.
                ELSE
                    IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = UPPER(ALLTRIM(THIS.this_cAuditors))
                        loc_lPermitido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarPermissaoAuditoria]", "Erro")
        ENDTRY
        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarExistenciaDocumento
    *-- Verifica se existe documento para o registro corrente
    *-- Retorna "MOVCAB" se em SigMvCab, "NEC" se em SigCdNec, "" se nao encontrou
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_cTipoDoc = ""
        TRY
            IF NOT (EMPTY(ALLTRIM(THIS.this_cEmps)) OR EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes = 0)
                loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
                loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cEmpDopNum), "cursor_4c_TmpChk")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                    SELECT cursor_4c_TmpChk
                    IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                        loc_cTipoDoc = "MOVCAB"
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF

                IF EMPTY(loc_cTipoDoc)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigCdNec WHERE EmpDnPs = " + ;
                        EscaparSQL(loc_cEmpDopNumLong), "cursor_4c_TmpChk")
                    IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                        SELECT cursor_4c_TmpChk
                        IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                            loc_cTipoDoc = "NEC"
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpChk")
                        USE IN cursor_4c_TmpChk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarExistenciaDocumento]", "Erro")
        ENDTRY
        RETURN loc_cTipoDoc
    ENDPROC

ENDDEFINE
