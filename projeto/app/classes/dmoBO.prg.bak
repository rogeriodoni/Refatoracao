*==============================================================================
* dmoBO.prg - Business Object para Desmontagem (SIGCDDMO)
* Tabela principal: SigMvCab (cabecalho de movimento de desmontagem)
* Tabelas relacionadas: SigMvItn, SigMvHst, SigMvPec, SigCdNec, SigCdNei
*==============================================================================

DEFINE CLASS dmoBO AS BusinessBase

    *-- Campos de SigMvCab -------------------------------------------------
    this_cEmps       = ""    && char(3)  - Empresa
    this_cDopes      = ""    && char(20) - Operacao (codigo da desmontagem)
    this_nNumes      = 0     && N(6)     - Numero sequencial
    this_cEmpDopNums = ""    && char(29) - Chave combinada Emps+Dopes+Str(Numes,6)
    this_cMascNum    = ""    && char(10) - Numero mascarado (exibicao)

    this_dDatas      = {}    && date     - Data da operacao
    this_tDatars     = {}    && datetime - Data de registro (criacao)
    this_tDtAlts     = {}    && datetime - Data da ultima alteracao
    this_tDtBaixas   = {}    && datetime - Data de baixa/desmontagem efetiva
    this_tDatatrans  = {}    && datetime - Data de transporte (se transportado)

    this_cGrupoos    = ""    && char(10) - Grupo Origem (GrupoOs)
    this_cContaos    = ""    && char(10) - Conta Origem (ContaOs)
    this_cGrupods    = ""    && char(10) - Grupo Destino (GrupoDs)
    this_cContads    = ""    && char(10) - Conta Destino (ContaDs)
    this_cGrVends    = ""    && char(10) - Grupo Responsavel (GrVends)
    this_cVends      = ""    && char(10) - Conta Responsavel / Vendedor (Vends)

    this_lChkSubn    = .F.   && bit      - Flag: desmontagem ja realizada
    this_cUsuars     = ""    && char(10) - Usuario que registrou
    this_cCIdChaves  = ""    && char(20) - Chave unica (GUID)
    this_cEmpGopNums = ""    && char(29) - Chave Emps+GrupoOs+Str(Numes,10)

    *-- Descricoes (nao persistidas - preenchidas via lookup) --------------
    this_cDescOrigem  = ""   && Nome da conta de origem  (SigCdCli.Rclis)
    this_cDescDestino = ""   && Nome da conta de destino (SigCdCli.Rclis)
    this_cDescVend    = ""   && Nome do responsavel       (SigCdCli.Rclis)

    *-- Estado operacional do form -----------------------------------------
    this_lEditaOrigem = .T.  && Permite editar campos de origem
    this_dDtIni       = {}   && Data inicio do filtro de periodo
    this_dDtFim       = {}   && Data fim do filtro de periodo
    this_nCItem       = 0    && Contador de itens no processo
    this_nTotalQtde   = 0    && Total de quantidade (getTQtde)
    this_nTotalPeso   = 0    && Total de peso       (getTPeso)
    this_cSigkey      = ""   && Chave de assinatura (SigCdPac.SigKeys)

    *-- Parametros de SigCdPam (configuracao da balanca/desmontagem) -------
    this_cDopesAtual  = ""   && Dopes vigente para desmontagem (SigCdPam.Desmontas)
    this_cMascNums    = ""   && Mascara de numeros             (SigCdPam.MascNums)
    this_lDesmontas   = .F.  && Flag: modulo desmontagem habilitado

    *-- Configuracoes da operacao (SigCdOpe) -------------------------------
    this_nOrigems     = 0    && Tipo origem: 0=nao usa, 1=usa conta contabil
    this_nDestinos    = 0    && Tipo destino: idem
    this_nVendes      = 0    && Tipo responsavel: 0=nao usa, 1=fixo, 2=livre
    this_lFixGOrigs   = .F.  && Grupo origem e fixo (nao editavel)
    this_lFixCOrigs   = .F.  && Conta origem e fixa (nao editavel)
    this_lFixGDests   = .F.  && Grupo destino e fixo
    this_lFixCDests   = .F.  && Conta destino e fixa
    this_lFixGVends   = .F.  && Grupo responsavel e fixo
    this_cGruOrigs    = ""   && Grupo origem padrao da operacao
    this_cConOrigs    = ""   && Conta origem padrao da operacao
    this_cGruDests    = ""   && Grupo destino padrao da operacao
    this_cConDests    = ""   && Conta destino padrao da operacao
    this_cGrVendsOpe  = ""   && Grupo responsavel padrao da operacao

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_dDtIni = DATE()
            THIS.this_dDtFim = DATE()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar dmoBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Carrega SigCdPam, SigCdPac e SigCdOpe
    * Deve ser chamado no InicializarForm antes de qualquer operacao
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- 1. SigCdPac: chave de assinatura
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") >= 1
                IF !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    THIS.this_cSigkey = ALLTRIM(TratarNulo(cursor_4c_Pac.SigKeys, "C"))
                ENDIF
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF

            *-- 2. SigCdPam: parametros da balanca e codigo de desmontagem
            loc_cSQL = "SELECT TOP 1 BalPortas, BalVelocs, BalTppars, BalBits, " + ;
                       "BalParids, Desmontas, MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") >= 1
                IF !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cDopesAtual = ALLTRIM(TratarNulo(cursor_4c_Pam.Desmontas, "C"))
                    THIS.this_cMascNums   = ALLTRIM(TratarNulo(cursor_4c_Pam.MascNums, "C"))
                    THIS.this_lDesmontas  = !EMPTY(THIS.this_cDopesAtual)
                ENDIF
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF !THIS.this_lDesmontas
                MsgErro("Opera" + CHR(231) + CHR(227) + "o de Desmontagem n" + CHR(227) + ;
                         "o configurada nos Par" + CHR(226) + "metros do Sistema.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            *-- 3. SigCdOpe: configuracoes da operacao de desmontagem
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Dopes, Origems, Destinos, Vendes, " + ;
                           "FixGOrigs, FixCOrigs, FixGDests, FixCDests, FixGVends, " + ;
                           "GruOrigs, ConOrigs, GruDests, ConDests, GrVends, ConOSubs, ConDSubs " + ;
                           "FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopesAtual)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope") >= 1
                    IF !EOF("cursor_4c_Ope")
                        SELECT cursor_4c_Ope
                        THIS.this_nOrigems    = TratarNulo(cursor_4c_Ope.Origems, "N")
                        THIS.this_nDestinos   = TratarNulo(cursor_4c_Ope.Destinos, "N")
                        THIS.this_nVendes     = TratarNulo(cursor_4c_Ope.Vendes, "N")
                        THIS.this_lFixGOrigs  = (TratarNulo(cursor_4c_Ope.FixGOrigs, "N") <> 0)
                        THIS.this_lFixCOrigs  = (TratarNulo(cursor_4c_Ope.FixCOrigs, "N") <> 0)
                        THIS.this_lFixGDests  = (TratarNulo(cursor_4c_Ope.FixGDests, "N") <> 0)
                        THIS.this_lFixCDests  = (TratarNulo(cursor_4c_Ope.FixCDests, "N") <> 0)
                        THIS.this_lFixGVends  = (TratarNulo(cursor_4c_Ope.FixGVends, "N") <> 0)
                        THIS.this_cGruOrigs   = ALLTRIM(TratarNulo(cursor_4c_Ope.GruOrigs, "C"))
                        THIS.this_cConOrigs   = ALLTRIM(TratarNulo(cursor_4c_Ope.ConOrigs, "C"))
                        THIS.this_cGruDests   = ALLTRIM(TratarNulo(cursor_4c_Ope.GruDests, "C"))
                        THIS.this_cConDests   = ALLTRIM(TratarNulo(cursor_4c_Ope.ConDests, "C"))
                        THIS.this_cGrVendsOpe = ALLTRIM(TratarNulo(cursor_4c_Ope.GrVends, "C"))
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Opera" + CHR(231) + CHR(227) + "o '" + ALLTRIM(THIS.this_cDopesAtual) + ;
                                 "' n" + CHR(227) + "o encontrada em SigCdOpe.", "Erro")
                    ENDIF
                ELSE
                    MsgErro("Falha ao carregar configura" + CHR(231) + CHR(227) + "o da opera" + ;
                             CHR(231) + CHR(227) + "o (SigCdOpe).", "Erro")
                ENDIF
                IF USED("cursor_4c_Ope")
                    USE IN cursor_4c_Ope
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro dmoBO.CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarLookups - Carrega tabelas auxiliares TempGccr, TempGru, TempUni
    * Deve ser chamado apos CarregarParametros
    *==========================================================================
    PROCEDURE CarregarLookups()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            *-- TempGccr: Grupos de Conta Corrente (SigCdGcr) para lookup grupo
            IF loc_lContinuar
                IF USED("TempGccr")
                    USE IN TempGccr
                ENDIF
                loc_cSQL = "SELECT Codigos, Descrs, GerBals FROM SigCdGcr"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempGccr") >= 1
                    SELECT TempGccr
                    INDEX ON Codigos TAG BalCodigo
                    INDEX ON Codigos TAG Codigos
                    SET ORDER TO Codigos
                ELSE
                    MsgErro("Falha ao carregar grupos de Conta Corrente (SigCdGcr).", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- TempGru: Grupos de Produto (SigCdGrp) para validar tipo estoque e custo
            IF loc_lContinuar
                IF USED("TempGru")
                    USE IN TempGru
                ENDIF
                loc_cSQL = "SELECT CGrus, CEstoqs, MoeCusts FROM SigCdGrp"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempGru") >= 1
                    SELECT TempGru
                    INDEX ON CGrus TAG CGrus
                    SET ORDER TO CGrus
                ELSE
                    MsgErro("Falha ao carregar grupos de Produto (SigCdGrp).", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- TempUni: Unidades de Medida (SigCdUni) para conversao de fatores
            IF loc_lContinuar
                IF USED("TempUni")
                    USE IN TempUni
                ENDIF
                loc_cSQL = "SELECT CUnis, Fators FROM SigCdUni"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempUni") >= 1
                    SELECT TempUni
                    INDEX ON CUnis TAG CUnis
                    SET ORDER TO CUnis
                ELSE
                    MsgErro("Falha ao carregar unidades de medida (SigCdUni).", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            loc_lSucesso = loc_lContinuar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro dmoBO.CarregarLookups")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de movimentos de desmontagem por periodo
    * Cria cursor crSigMvCab com os movimentos do periodo this_dDtIni/DtFim
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmps, loc_cDopes, loc_oErro
        LOCAL loc_cDtIni, loc_cDtFim, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDopes = THIS.this_cDopesAtual

            IF EMPTY(loc_cDopes)
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF EMPTY(THIS.this_dDtIni) OR EMPTY(THIS.this_dDtFim)
                    THIS.this_dDtIni = DATE()
                    THIS.this_dDtFim = DATE()
                ENDIF

                loc_cDtIni = FormatarDataSQL(THIS.this_dDtIni)
                loc_cDtFim = FormatarDataSQL(THIS.this_dDtFim)

                IF USED("crSigMvCab")
                    USE IN crSigMvCab
                ENDIF

                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends, " + ;
                           "Usuars, EmpDopNums, cIdChaves, ChkSubn, " + ;
                           "DtAlts, DtBaixas, DataTrans, Datars, EmpGopNums " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                           " AND Emps = " + EscaparSQL(loc_cEmps) + ;
                           " AND Dopes = " + EscaparSQL(PADR(loc_cDopes, 20)) + ;
                           " ORDER BY Datas DESC, Numes DESC"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvCab") >= 1
                    SELECT crSigMvCab
                    INDEX ON Numes TAG Numes
                    SET ORDER TO Numes
                    GO TOP IN crSigMvCab
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao carregar movimentos de Desmontagem." + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigMvCab pela chave EmpDopNums
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF EMPTY(par_cEmpDopNums)
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends, " + ;
                           "Usuars, EmpDopNums, cIdChaves, ChkSubn, " + ;
                           "DtAlts, DtBaixas, DataTrans, Datars, EmpGopNums " + ;
                           "FROM SigMvCab " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 1
                    IF RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        MsgAviso("Movimento n" + CHR(227) + "o encontrado: " + par_cEmpDopNums, "N" + CHR(227) + "o Encontrado")
                    ENDIF
                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
                ELSE
                    MsgErro("Falha ao carregar movimento." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor SigMvCab para propriedades BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps       = ALLTRIM(TratarNulo(Emps,       "C"))
            THIS.this_cDopes      = ALLTRIM(TratarNulo(Dopes,      "C"))
            THIS.this_nNumes      = TratarNulo(Numes,              "N")
            THIS.this_cMascNum    = ALLTRIM(TratarNulo(MascNum,    "C"))
            THIS.this_dDatas      = TratarNulo(Datas,              "D")
            THIS.this_tDatars     = TratarNulo(Datars,             "D")
            THIS.this_tDtAlts     = TratarNulo(DtAlts,            "D")
            THIS.this_tDtBaixas   = TratarNulo(DtBaixas,          "D")
            THIS.this_tDatatrans  = TratarNulo(DataTrans,         "D")
            THIS.this_cGrupoos    = ALLTRIM(TratarNulo(GrupoOs,   "C"))
            THIS.this_cContaos    = ALLTRIM(TratarNulo(ContaOs,   "C"))
            THIS.this_cGrupods    = ALLTRIM(TratarNulo(GrupoDs,   "C"))
            THIS.this_cContads    = ALLTRIM(TratarNulo(ContaDs,   "C"))
            THIS.this_cGrVends    = ALLTRIM(TratarNulo(GrVends,   "C"))
            THIS.this_cVends      = ALLTRIM(TratarNulo(Vends,     "C"))
            THIS.this_lChkSubn    = (TratarNulo(ChkSubn,          "N") <> 0)
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(Usuars,    "C"))
            THIS.this_cCIdChaves  = ALLTRIM(TratarNulo(cIdChaves, "C"))
            THIS.this_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums,"C"))
            THIS.this_cEmpGopNums = ALLTRIM(TratarNulo(EmpGopNums,"C"))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT cabecalho do movimento de desmontagem em SigMvCab
    * Apenas o cabecalho minimo - campos de origem/destino sao atualizados por Atualizar()
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nNumes, loc_cMascNum, loc_oErro
        LOCAL loc_cEmps, loc_cDopes, loc_cIdChaves, loc_cEmpDopNums, loc_cEmpGopNums
        loc_lSucesso = .F.

        TRY
            loc_cEmps  = go_4c_Sistema.cCodEmpresa
            loc_cDopes = PADR(THIS.this_cDopesAtual, 20)

            *-- Gera numero sequencial unico para este Dopes+Empresa
            loc_nNumes      = fGerUniqueKey(ALLTRIM(THIS.this_cDopesAtual) + loc_cEmps)
            loc_cMascNum    = fGerMascara(loc_nNumes)
            loc_cIdChaves   = fUniqueIds()
            loc_cEmpDopNums = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
            loc_cEmpGopNums = loc_cEmps + SPACE(20) + STR(loc_nNumes, 6)

            loc_cSQL = "INSERT INTO SigMvCab " + ;
                       "(Emps, Dopes, Numes, Usuars, Datars, Datas, MascNum, " + ;
                       " cIdChaves, EmpDopNums, DtAlts, EmpGopNums) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cEmps) + ", " + ;
                       EscaparSQL(loc_cDopes) + ", " + ;
                       FormatarNumeroSQL(loc_nNumes) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), GETDATE(), " + ;
                       EscaparSQL(loc_cMascNum) + ", " + ;
                       EscaparSQL(loc_cIdChaves) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cEmpGopNums) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins") >= 0
                *-- Atualiza propriedades com os valores gerados
                THIS.this_cEmps       = loc_cEmps
                THIS.this_cDopes      = ALLTRIM(loc_cDopes)
                THIS.this_nNumes      = loc_nNumes
                THIS.this_cMascNum    = loc_cMascNum
                THIS.this_cCIdChaves  = loc_cIdChaves
                THIS.this_cEmpDopNums = loc_cEmpDopNums
                THIS.this_cEmpGopNums = loc_cEmpGopNums
                THIS.this_lNovoRegistro = .F.

                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao registrar movimento de Desmontagem." + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigMvCab com dados de origem/destino/responsavel/data
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cEmpDopNums, loc_cEmpGopNums, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF EMPTY(THIS.this_cEmpDopNums)
                MsgErro("Chave do movimento n" + CHR(227) + "o definida para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cEmpGopNums = THIS.this_cEmps + ;
                                  PADR(THIS.this_cGrupoos, 20) + ;
                                  STR(THIS.this_nNumes, 6)

                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "GrupoOs = " + EscaparSQL(PADR(THIS.this_cGrupoos, 10)) + ", " + ;
                           "ContaOs = " + EscaparSQL(PADR(THIS.this_cContaos, 10)) + ", " + ;
                           "GrupoDs = " + EscaparSQL(PADR(THIS.this_cGrupods, 10)) + ", " + ;
                           "ContaDs = " + EscaparSQL(PADR(THIS.this_cContads, 10)) + ", " + ;
                           "GrVends = " + EscaparSQL(PADR(THIS.this_cGrVends, 10)) + ", " + ;
                           "Vends = " + EscaparSQL(PADR(THIS.this_cVends, 10)) + ", " + ;
                           "Usuars = " + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "EmpGopNums = " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
                           "DtAlts = GETDATE() " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd") >= 0
                    THIS.this_cEmpGopNums = loc_cEmpGopNums
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao atualizar movimento de Desmontagem." + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE SigMvCab e SigMvItn pelo EmpDopNums
    * Delegado de Excluir() do BusinessBase. Chama CancelarDesmontagem internamente.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.CancelarDesmontagem()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega itens de SigMvItn para o grid de itens
    * Cria cursor crLclMvItn com os itens do movimento informado
    *==========================================================================
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            IF EMPTY(par_cEmpDopNums)
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                IF USED("crLclMvItn")
                    USE IN crLclMvItn
                ENDIF

                *-- Cria cursor identico ao SigMvItn para trabalho local (ReadWrite)
                loc_cSQL = "SELECT Emps, Dopes, Numes, Cpros, Dpros, Qtds, Pesos, " + ;
                           "Cunis, Aqtds, Datatrans, NrCons, Totas, Units, NumOlds, Notas, " + ;
                           "Opers, Moedas, Fators, MoeFats, FatVals, MoeVals, DescVals, " + ;
                           "UniVals, Iconfs, cItens, UnitEmbs, TPesos, Obs, CodBarras, " + ;
                           "ValIpis, TpIpis, Aliqs, Sitribs, EmpDopNums, DtAlts, cIdChaves " + ;
                           "FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                           " ORDER BY Cpros"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "crLclMvItn") >= 1
                    SELECT crLclMvItn
                    GO TOP IN crLclMvItn

                    IF RECCOUNT("crLclMvItn") = 0
                        *-- Cursor vazio mas disponivel para o grid
                        APPEND BLANK IN crLclMvItn
                        ZAP IN crLclMvItn
                    ENDIF

                    *-- Calcular totais
                    THIS.this_nTotalQtde = 0
                    THIS.this_nTotalPeso = 0
                    SELECT SUM(Qtds) AS TQtds, SUM(Qtds * Pesos) AS TPesos ;
                        FROM crLclMvItn ;
                        INTO CURSOR cursor_4c_Totais
                    IF RECCOUNT("cursor_4c_Totais") > 0
                        SELECT cursor_4c_Totais
                        THIS.this_nTotalQtde = TratarNulo(cursor_4c_Totais.TQtds,  "N")
                        THIS.this_nTotalPeso = TratarNulo(cursor_4c_Totais.TPesos, "N")
                    ENDIF
                    IF USED("cursor_4c_Totais")
                        USE IN cursor_4c_Totais
                    ENDIF

                    GO TOP IN crLclMvItn
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao carregar itens do movimento." + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro dmoBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarDesmontagem - Executa o processo de desmontagem (mSv_inserir)
    * Pre-condicao: CarregarParametros(), CarregarLookups() e Inserir()/CarregarPorCodigo()
    *               ja executados. crLclMvItn deve estar populado com os itens.
    * Fluxo:
    *   1. Monta composicoes via SigCdPro + SigPrCpo
    *   2. INSERT SigMvItn (itens da desmontagem saindo do estoque)
    *   3. INSERT SigMvHst tipo "S" (saida do produto pai)
    *   4. INSERT SigCdNec (cabecalho de necessidade)
    *   5. INSERT SigCdNei (itens de necessidade - materias-primas)
    *   6. INSERT SigMvHst tipo "E" (entrada de materia-prima)
    *   7. INSERT SigMvPec (pecas/subnivel)
    *   8. UPDATE SigMvCab - marca ChkSubn=1, DtBaixas=data
    *==========================================================================
    PROCEDURE ProcessarDesmontagem()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cChave
        LOCAL loc_dtAgora, loc_dData, loc_cBaixaSQL
        LOCAL loc_nPeso, loc_nPesoTot, loc_nPesoLanc, loc_nPesoRat, loc_nRecnoRat
        LOCAL loc_cIds, loc_cIdC, loc_nSeq, loc_cSQL, loc_nResult
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cEmps  = THIS.this_cEmps
            loc_cDopes = THIS.this_cDopesAtual
            loc_nNumes = THIS.this_nNumes
            loc_cChave = THIS.this_cEmpDopNums
            loc_dtAgora = DATETIME()
            loc_dData  = THIS.this_dDatas
            loc_cBaixaSQL = FormatarDataSQL(loc_dData)

            IF EMPTY(loc_cChave) OR EMPTY(loc_cEmps) OR loc_nNumes = 0
                MsgErro("Movimento n" + CHR(227) + "o inicializado. Execute Inserir() primeiro.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND (!USED("crLclMvItn") OR RECCOUNT("crLclMvItn") = 0)
                MsgAviso("Nenhum item de desmontagem informado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lContinuar = .F.
            ENDIF

            *-- Verifica se cursos de lookup estao disponiveis
            IF loc_lContinuar AND (!USED("TempUni") OR !USED("TempGru"))
                MsgErro("Tabelas de lookup n" + CHR(227) + "o carregadas. Execute CarregarLookups().", "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Cria cursores de trabalho temporarios
            CREATE CURSOR TmpLanca (CMats C(14), Qtds N(12,3), CGrus C(3))
            INDEX ON CMats TAG CMats
            CREATE CURSOR TmpMat (CMats C(14), Qtdes N(12,3), Varia N(1), Fators N(12,4), CGrus C(3))
            INDEX ON CMats TAG CMats

            *-- Cursor de composicoes: produto pai x materias-primas
            CREATE CURSOR crCompo (CPros C(14), CMats C(14), Qtds N(9,3), CUnis C(3), CGrus C(3), Varias N(1))
            INDEX ON CPros + CMats TAG CPros

            *-- Agrupa produtos do lote de desmontagem (sem duplicatas)
            SELECT CPros, SPACE(3) AS CUnis, SPACE(3) AS CGrus, 0 AS Varias ;
                FROM crLclMvItn ;
                GROUP BY CPros ;
                INTO CURSOR crProdutos READWRITE
            SELECT crProdutos
            INDEX ON CPros TAG CPros

            *-- Passo 1: Para cada produto, carrega composicao via SigCdPro + SigPrCpo
            IF loc_lContinuar
                SELECT crProdutos
                SCAN
                    loc_cSQL = "SELECT CUnis, CGrus, Varias, CproEqs FROM SigCdPro " + ;
                               "WHERE CPros = " + EscaparSQL(crProdutos.CPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro") >= 1 AND !EOF("cursor_4c_Pro")
                        SELECT crProdutos
                        REPLACE CUnis  WITH ALLTRIM(cursor_4c_Pro.CUnis), ;
                                CGrus  WITH ALLTRIM(cursor_4c_Pro.CGrus), ;
                                Varias WITH cursor_4c_Pro.Varias

                        *-- Tenta composicao direta; se vazia, tenta via CproEqs
                        loc_cSQL = "SELECT Mats, Qtds FROM SigPrCpo WHERE CPros = " + ;
                                   EscaparSQL(crProdutos.CPros)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TCompo") < 1 OR ;
                           RECCOUNT("cursor_4c_TCompo") = 0
                            IF USED("cursor_4c_TCompo")
                                USE IN cursor_4c_TCompo
                            ENDIF
                            loc_cSQL = "SELECT Mats, Qtds FROM SigPrCpo WHERE CPros = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Pro.CproEqs))
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TCompo")
                        ENDIF

                        IF USED("cursor_4c_TCompo") AND RECCOUNT("cursor_4c_TCompo") > 0
                            SELECT cursor_4c_TCompo
                            SCAN
                                loc_cSQL = "SELECT CUnis, CGrus, Varias FROM SigCdPro " + ;
                                           "WHERE CPros = " + EscaparSQL(ALLTRIM(cursor_4c_TCompo.Mats))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mat") >= 1 AND !EOF("cursor_4c_Mat")
                                    SELECT cursor_4c_TCompo
                                    INSERT INTO crCompo (CPros, CMats, Qtds, CUnis, CGrus, Varias) ;
                                           VALUES (crProdutos.CPros, cursor_4c_TCompo.Mats, ;
                                                   cursor_4c_TCompo.Qtds, cursor_4c_Mat.CUnis, ;
                                                   cursor_4c_Mat.CGrus, cursor_4c_Mat.Varias)
                                ENDIF
                                IF USED("cursor_4c_Mat")
                                    USE IN cursor_4c_Mat
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Pro")
                        USE IN cursor_4c_Pro
                    ENDIF
                    IF USED("cursor_4c_TCompo")
                        USE IN cursor_4c_TCompo
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Remove itens invalidos do lote
            DELETE FROM crLclMvItn WHERE EMPTY(Cpros) OR EMPTY(Qtds)

            *-- Passo 2: Para cada item do lote: INSERT SigMvItn + INSERT SigMvHst(S)
            IF loc_lContinuar
                SELECT crLclMvItn
                GO TOP
                SCAN
                    SELECT crCompo
                    SEEK crLclMvItn.CPros

                    ZAP IN TmpMat
                    SCAN WHILE crCompo.CPros = crLclMvItn.CPros
                        SET ORDER TO CUnis IN TempUni
                        SEEK crCompo.CUnis IN TempUni
                        SET ORDER TO CGrus IN TempGru
                        SEEK crCompo.CGrus IN TempGru

                        IF TempGru.CEstoqs <> 2 AND crCompo.Qtds <> 0
                            IF !SEEK(crCompo.CMats, "TmpMat", "CMats")
                                INSERT INTO TmpMat (CMats, Varia, Fators, CGrus) ;
                                       VALUES (crCompo.CMats, crCompo.Varias, ;
                                               TempUni.Fators, crCompo.CGrus)
                            ENDIF
                            SELECT TmpMat
                            SEEK crCompo.CMats
                            REPLACE Qtdes WITH TmpMat.Qtdes + ;
                                    ROUND(crLclMvItn.Qtds * crCompo.Qtds, 2) IN TmpMat
                        ENDIF
                        SELECT crCompo
                    ENDSCAN

                    loc_nPeso = (crLclMvItn.Pesos * crLclMvItn.Qtds)

                    *-- Composicoes com peso fixo (nao varia)
                    SELECT TmpMat
                    SCAN FOR Varia <> 1
                        loc_nPeso = loc_nPeso - (TmpMat.Qtdes * TmpMat.Fators)
                        IF !SEEK(TmpMat.CMats, "TmpLanca", "CMats")
                            INSERT INTO TmpLanca (CMats, Qtds, CGrus) ;
                                   VALUES (TmpMat.CMats, TmpMat.Qtdes, TmpMat.CGrus)
                        ELSE
                            SELECT TmpLanca
                            SEEK TmpMat.CMats
                            REPLACE Qtds WITH TmpLanca.Qtds + TmpMat.Qtdes IN TmpLanca
                        ENDIF
                    ENDSCAN

                    loc_nPesoTot = 0
                    loc_nPesoRat = 0
                    loc_nRecnoRat = 0

                    *-- Composicoes com peso variavel (proporcional ao peso da peca)
                    SELECT TmpMat
                    SUM Qtdes TO loc_nPesoTot FOR Varia = 1
                    SCAN FOR Varia = 1
                        loc_nPesoLanc = IIF(loc_nPesoTot = 0, 0, ;
                                        ROUND(Qtdes / loc_nPesoTot * loc_nPeso, 2))
                        loc_nPesoRat = loc_nPesoRat + loc_nPesoLanc

                        IF !SEEK(TmpMat.CMats, "TmpLanca", "CMats")
                            INSERT INTO TmpLanca (CMats, Qtds, CGrus) ;
                                   VALUES (TmpMat.CMats, loc_nPesoLanc, TmpMat.CGrus)
                        ELSE
                            SELECT TmpLanca
                            SEEK TmpMat.CMats
                            REPLACE Qtds WITH TmpLanca.Qtds + loc_nPesoLanc IN TmpLanca
                        ENDIF
                        IF loc_nRecnoRat = 0
                            loc_nRecnoRat = RECNO("TmpLanca")
                        ENDIF
                        SELECT TmpMat
                    ENDSCAN

                    *-- Ajuste de arredondamento no ultimo lancamento variavel
                    IF loc_nPeso <> loc_nPesoRat AND loc_nRecnoRat <> 0
                        GO loc_nRecnoRat IN TmpLanca
                        REPLACE Qtds WITH TmpLanca.Qtds + (loc_nPeso - loc_nPesoRat) IN TmpLanca
                    ENDIF

                    *-- INSERT SigMvItn: item da desmontagem
                    SELECT crLclMvItn
                    SELECT crProdutos
                    SEEK crLclMvItn.CPros

                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(Aqtds, Cpros, Dpros, Cunis, Datatrans, Dopes, Emps, NrCons, " + ;
                               " Numes, Qtds, Totas, Units, NumOlds, Notas, Opers, Moedas, " + ;
                               " Pesos, Fators, MoeFats, FatVals, MoeVals, DescVals, UniVals, " + ;
                               " Iconfs, cItens, UnitEmbs, TPesos, Obs, CodBarras, ValIpis, " + ;
                               " TpIpis, Aliqs, Sitribs, EmpDopNums, DtAlts, cIdChaves) " + ;
                               "VALUES (" + ;
                               FormatarNumeroSQL(crLclMvItn.Qtds) + ", " + ;
                               EscaparSQL(crLclMvItn.Cpros) + ", " + ;
                               EscaparSQL(crLclMvItn.Dpros) + ", " + ;
                               EscaparSQL(crLclMvItn.Cunis) + ", " + ;
                               IIF(!EMPTY(crLclMvItn.Datatrans), FormatarDataSQL(crLclMvItn.Datatrans), "NULL") + ", " + ;
                               EscaparSQL(PADR(loc_cDopes, 20)) + ", " + ;
                               EscaparSQL(loc_cEmps) + ", " + ;
                               EscaparSQL(crLclMvItn.NrCons) + ", " + ;
                               FormatarNumeroSQL(loc_nNumes) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.Qtds) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.Totas) + ", " + ;
                               EscaparSQL(crLclMvItn.Units) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.NumOlds) + ", " + ;
                               EscaparSQL(crLclMvItn.Notas) + ", " + ;
                               EscaparSQL(crLclMvItn.Opers) + ", " + ;
                               EscaparSQL(crLclMvItn.Moedas) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.Pesos) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.Fators) + ", " + ;
                               EscaparSQL(crLclMvItn.MoeFats) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.FatVals) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.MoeVals) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.DescVals) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.UniVals) + ", " + ;
                               IIF(crLclMvItn.Iconfs, "1", "0") + ", " + ;
                               EscaparSQL(crLclMvItn.cItens) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.UnitEmbs) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.TPesos) + ", " + ;
                               EscaparSQL(crLclMvItn.Obs) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.CodBarras) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.ValIpis) + ", " + ;
                               EscaparSQL(crLclMvItn.TpIpis) + ", " + ;
                               FormatarNumeroSQL(crLclMvItn.Aliqs) + ", " + ;
                               EscaparSQL(crLclMvItn.Sitribs) + ", " + ;
                               EscaparSQL(loc_cChave) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(fUniqueIds()) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnIns")
                    IF USED("cursor_4c_ItnIns")
                        USE IN cursor_4c_ItnIns
                    ENDIF
                    IF loc_nResult < 0
                        loc_lContinuar = .F.
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigMvItn)")
                    ENDIF

                    *-- INSERT SigMvHst tipo "S" (saida do produto)
                    IF loc_lContinuar
                        SELECT crLclMvItn
                        SELECT TempGru
                        SEEK crProdutos.CGrus
                        loc_cIdC = DTOS(loc_dData) + "S" + ;
                                   TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                                   THIS.this_cSigkey
                        loc_nSeq = fGerUniqueKey("HISTBAR")

                        loc_cSQL = "INSERT INTO SigMvHst " + ;
                                   "(Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, " + ;
                                   " Cpros, Moedas, Totas, Datatrans, EmpOs, Qtds, Grupos, Estos, " + ;
                                   " cIdChaves, EmpDopNums, EmpGruEsts, DtAlts, OriDopNums, Seqs, " + ;
                                   " Units, Pesos) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", GETDATE(), " + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL("S") + ", " + ;
                                   EscaparSQL(PADR(loc_cDopes, 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNumes) + ", " + ;
                                   FormatarDataSQL(loc_dData) + ", NULL, " + ;
                                   EscaparSQL(crLclMvItn.Cpros) + ", " + ;
                                   EscaparSQL(ALLTRIM(TempGru.MoeCusts)) + ", " + ;
                                   FormatarNumeroSQL(crLclMvItn.Totas) + ", " + ;
                                   IIF(!EMPTY(crLclMvItn.Datatrans), FormatarDataSQL(crLclMvItn.Datatrans), "NULL") + ", " + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   FormatarNumeroSQL(crLclMvItn.Qtds) + ", " + ;
                                   EscaparSQL(PADR(THIS.this_cGrupoos, 10)) + ", " + ;
                                   EscaparSQL(PADR(THIS.this_cContaos, 10)) + ", " + ;
                                   EscaparSQL(loc_cIdC) + ", " + ;
                                   EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)) + ", " + ;
                                   EscaparSQL(loc_cEmps + PADR(THIS.this_cGrupoos, 10) + PADR(THIS.this_cContaos, 10)) + ", " + ;
                                   "GETDATE(), " + ;
                                   EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)) + ", " + ;
                                   FormatarNumeroSQL(loc_nSeq) + ", " + ;
                                   EscaparSQL(crLclMvItn.Units) + ", " + ;
                                   FormatarNumeroSQL(crLclMvItn.Pesos) + ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HstIns")
                        IF USED("cursor_4c_HstIns")
                            USE IN cursor_4c_HstIns
                        ENDIF
                        IF loc_nResult < 0
                            loc_lContinuar = .F.
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigMvHst-S)")
                        ENDIF

                        *-- Recalculo de estoque (fRecalculaP/fRecalculaC nao portados)
                        THIS.RecalcularEstoque(loc_cEmps, PADR(THIS.this_cGrupoos,10), ;
                                               PADR(THIS.this_cContaos,10), crLclMvItn.Cpros, loc_dData)
                        THIS.RecalcularCusto(loc_cEmps, crLclMvItn.Cpros, loc_dData)
                    ENDIF

                    SELECT crLclMvItn
                ENDSCAN
            ENDIF

            *-- Passo 3: INSERT SigCdNec (cabecalho de necessidade)
            IF loc_lContinuar
                loc_cIds = DTOS(loc_dData) + ;
                           TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                           THIS.this_cSigkey

                loc_cSQL = "INSERT INTO SigCdNec " + ;
                           "(Emps, Dopps, Numps, Usuars, Datas, Datars, Grupoos, Contaos, " + ;
                           " Grupods, Contads, cIdChaves, EmpDNps) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(PADR(loc_cDopes, 20)) + ", " + ;
                           FormatarNumeroSQL(loc_nNumes) + ", " + ;
                           EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           FormatarDataSQL(loc_dData) + ", GETDATE(), " + ;
                           EscaparSQL(PADR(THIS.this_cGrupoos, 10)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cContaos, 10)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cGrupods, 10)) + ", " + ;
                           EscaparSQL(PADR(THIS.this_cContads, 10)) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 10)) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecIns")
                IF USED("cursor_4c_NecIns")
                    USE IN cursor_4c_NecIns
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdNec)")
                ENDIF
            ENDIF

            *-- Passo 4: INSERT SigCdNei (itens de necessidade) + INSERT SigMvHst tipo "E"
            IF loc_lContinuar
                DELETE FROM TmpLanca WHERE EMPTY(CMats) OR Qtds = 0

                SELECT TmpLanca
                SCAN
                    *-- INSERT SigCdNei
                    loc_cSQL = "INSERT INTO SigCdNei " + ;
                               "(Emps, Dopps, Numps, CMats, Qtds, cIdChaves, EmpDnPs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cEmps) + ", " + ;
                               EscaparSQL(PADR(loc_cDopes, 20)) + ", " + ;
                               FormatarNumeroSQL(loc_nNumes) + ", " + ;
                               EscaparSQL(TmpLanca.CMats) + ", " + ;
                               FormatarNumeroSQL(TmpLanca.Qtds) + ", " + ;
                               EscaparSQL(fUniqueIds()) + ", " + ;
                               EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 10)) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NeiIns")
                    IF USED("cursor_4c_NeiIns")
                        USE IN cursor_4c_NeiIns
                    ENDIF
                    IF loc_nResult < 0
                        loc_lContinuar = .F.
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigCdNei)")
                    ENDIF

                    *-- INSERT SigMvHst tipo "E" (entrada de materia-prima)
                    IF loc_lContinuar
                        SEEK TmpLanca.CGrus IN TempGru
                        IF TempGru.CEstoqs <> 2
                            loc_cIdC = DTOS(loc_dData) + "E" + ;
                                       TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                                       THIS.this_cSigkey
                            loc_nSeq = fGerUniqueKey("HISTBAR")

                            loc_cSQL = "INSERT INTO SigMvHst " + ;
                                       "(Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, DtAudits, " + ;
                                       " CPros, Empos, Qtds, Grupos, Estos, CidChaves, EmpDopNums, " + ;
                                       " EmpGruEsts, DtAlts, OriDopNums, Seqs) " + ;
                                       "VALUES (" + ;
                                       EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", GETDATE(), " + ;
                                       EscaparSQL(loc_cEmps) + ", " + ;
                                       EscaparSQL("E") + ", " + ;
                                       EscaparSQL(PADR(loc_cDopes, 20)) + ", " + ;
                                       FormatarNumeroSQL(loc_nNumes) + ", " + ;
                                       FormatarDataSQL(loc_dData) + ", NULL, " + ;
                                       EscaparSQL(TmpLanca.CMats) + ", " + ;
                                       EscaparSQL(loc_cEmps) + ", " + ;
                                       FormatarNumeroSQL(TmpLanca.Qtds) + ", " + ;
                                       EscaparSQL(PADR(THIS.this_cGrupods, 10)) + ", " + ;
                                       EscaparSQL(PADR(THIS.this_cContads, 10)) + ", " + ;
                                       EscaparSQL(loc_cIdC) + ", " + ;
                                       EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)) + ", " + ;
                                       EscaparSQL(loc_cEmps + PADR(THIS.this_cGrupods, 10) + PADR(THIS.this_cContads, 10)) + ", " + ;
                                       "GETDATE(), " + ;
                                       EscaparSQL(loc_cEmps + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)) + ", " + ;
                                       FormatarNumeroSQL(loc_nSeq) + ")"

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HstEIns")
                            IF USED("cursor_4c_HstEIns")
                                USE IN cursor_4c_HstEIns
                            ENDIF
                            IF loc_nResult < 0
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigMvHst-E)")
                            ENDIF

                            IF loc_lContinuar
                                THIS.RecalcularEstoque(loc_cEmps, PADR(THIS.this_cGrupods,10), ;
                                                       PADR(THIS.this_cContads,10), TmpLanca.CMats, loc_dData)
                                THIS.RecalcularCusto(loc_cEmps, TmpLanca.CMats, loc_dData)
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT TmpLanca
                ENDSCAN
            ENDIF

            *-- Passo 5: UPDATE SigMvCab - marca ChkSubn=1 e registra DtBaixas
            IF loc_lContinuar
                loc_cSQL = "UPDATE SigMvCab " + ;
                           "SET ChkSubn = 1, " + ;
                           "DtAlts = GETDATE(), " + ;
                           "DtBaixas = " + loc_cBaixaSQL + " " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabUpd")
                IF USED("cursor_4c_CabUpd")
                    USE IN cursor_4c_CabUpd
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (SigMvCab Update)")
                ELSE
                    THIS.this_lChkSubn = .T.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.RegistrarAuditoria("PROCESS")
                loc_lSucesso = .T.
            ENDIF

            *-- Limpar cursores temporarios
            IF USED("crProdutos")
                USE IN crProdutos
            ENDIF
            IF USED("crCompo")
                USE IN crCompo
            ENDIF
            IF USED("TmpLanca")
                ZAP IN TmpLanca
            ENDIF
            IF USED("TmpMat")
                ZAP IN TmpMat
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Procedure: " + loc_oErro.Procedure, "Erro dmoBO.ProcessarDesmontagem")
            IF USED("crProdutos")
                USE IN crProdutos
            ENDIF
            IF USED("crCompo")
                USE IN crCompo
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CancelarDesmontagem - Cancela/exclui um movimento de desmontagem (mSv_excluir)
    * Fluxo:
    *   1. DELETE SigMvCab
    *   2. DELETE SigMvItn
    *   3. Para cada SigMvPec: UPDATE SigMvCab ChkSubn=0 + DELETE SigMvPec
    *   4. DELETE SigCdNec
    *   5. DELETE SigCdNei
    *   6. Para cada SigMvHst: DELETE + RecalcularEstoque + RecalcularCusto
    *==========================================================================
    PROCEDURE CancelarDesmontagem()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        LOCAL loc_cChave, loc_cChave2, loc_cSQL, loc_nResult
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cChave  = THIS.this_cEmpDopNums
            loc_cChave2 = THIS.this_cEmps + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 10)

            IF EMPTY(loc_cChave)
                MsgErro("Chave do movimento n" + CHR(227) + "o definida para cancelamento.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- 1. DELETE SigMvCab
            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelCab")
                IF USED("cursor_4c_DelCab")
                    USE IN cursor_4c_DelCab
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigMvCab)")
                ENDIF
            ENDIF

            *-- 2. DELETE SigMvItn
            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelItn")
                IF USED("cursor_4c_DelItn")
                    USE IN cursor_4c_DelItn
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigMvItn)")
                ENDIF
            ENDIF

            *-- 3. Para cada SigMvPec: UPDATE SigMvCab ChkSubn=0 + DELETE SigMvPec
            IF loc_lContinuar
                loc_cSQL = "SELECT Emps, Dopes, Numes, Codigos, EmpDopNums " + ;
                           "FROM SigMvPec WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pec") >= 1
                    SELECT cursor_4c_Pec
                    SCAN WHILE loc_lContinuar
                        LOCAL loc_nNDope, loc_cDopePec, loc_nNumePec, loc_cEdnPec
                        loc_nNDope  = INT(VAL(LEFT(cursor_4c_Pec.Codigos, 4)))
                        loc_nNumePec = INT(VAL(RIGHT(cursor_4c_Pec.Codigos, 6)))

                        *-- Localiza Dopes desta peca
                        LOCAL loc_cSQLOpe
                        loc_cSQLOpe = "SELECT TOP 1 Dopes FROM SigCdOpe WHERE NDopes = " + ;
                                      FormatarNumeroSQL(loc_nNDope)
                        IF SQLEXEC(gnConnHandle, loc_cSQLOpe, "cursor_4c_OpeChk") >= 1 AND ;
                           !EOF("cursor_4c_OpeChk")
                            loc_cDopePec = ALLTRIM(cursor_4c_OpeChk.Dopes)
                            loc_cEdnPec  = THIS.this_cEmps + PADR(loc_cDopePec, 20) + STR(loc_nNumePec, 6)

                            *-- Reverte ChkSubn do movimento pai
                            loc_cSQL = "UPDATE SigMvCab " + ;
                                       "SET ChkSubn = 0, DtAlts = GETDATE(), DtBaixas = NULL " + ;
                                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdnPec)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdPec")
                            IF USED("cursor_4c_UpdPec")
                                USE IN cursor_4c_UpdPec
                            ENDIF
                            IF loc_nResult < 0
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Update SigMvCab ChkSubn)")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_OpeChk")
                            USE IN cursor_4c_OpeChk
                        ENDIF

                        IF loc_lContinuar
                            *-- DELETE SigMvPec
                            loc_cSQL = "DELETE FROM SigMvPec WHERE EmpDopNums = " + ;
                                       EscaparSQL(cursor_4c_Pec.Emps + PADR(cursor_4c_Pec.Dopes, 20) + ;
                                                  STR(cursor_4c_Pec.Numes, 6))
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelPec")
                            IF USED("cursor_4c_DelPec")
                                USE IN cursor_4c_DelPec
                            ENDIF
                            IF loc_nResult < 0
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigMvPec)")
                            ENDIF
                        ENDIF
                        SELECT cursor_4c_Pec
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_Pec")
                    USE IN cursor_4c_Pec
                ENDIF
            ENDIF

            *-- 4. DELETE SigCdNec
            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cChave2)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelNec")
                IF USED("cursor_4c_DelNec")
                    USE IN cursor_4c_DelNec
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigCdNec)")
                ENDIF
            ENDIF

            *-- 5. DELETE SigCdNei
            IF loc_lContinuar
                loc_cSQL = "DELETE FROM SigCdNei WHERE EmpDnPs = " + EscaparSQL(loc_cChave2)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelNei")
                IF USED("cursor_4c_DelNei")
                    USE IN cursor_4c_DelNei
                ENDIF
                IF loc_nResult < 0
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigCdNei)")
                ENDIF
            ENDIF

            *-- 6. Para cada SigMvHst: DELETE + recalcular estoque
            IF loc_lContinuar
                loc_cSQL = "SELECT Emps, Grupos, Estos, CPros, Datas, CodCors, CodTams, cIdChaves " + ;
                           "FROM SigMvHst WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_His") >= 1
                    SELECT cursor_4c_His
                    SCAN WHILE loc_lContinuar
                        LOCAL loc_cEmpsH, loc_cGruposH, loc_cEstosH, loc_cProsH, loc_dDatasH
                        loc_cEmpsH   = ALLTRIM(cursor_4c_His.Emps)
                        loc_cGruposH = ALLTRIM(cursor_4c_His.Grupos)
                        loc_cEstosH  = ALLTRIM(cursor_4c_His.Estos)
                        loc_cProsH   = ALLTRIM(cursor_4c_His.CPros)
                        loc_dDatasH  = cursor_4c_His.Datas

                        loc_cSQL = "DELETE FROM SigMvHst WHERE cIdChaves = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_His.cIdChaves))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelHst")
                        IF USED("cursor_4c_DelHst")
                            USE IN cursor_4c_DelHst
                        ENDIF
                        IF loc_nResult < 0
                            loc_lContinuar = .F.
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (Delete SigMvHst)")
                        ELSE
                            THIS.RecalcularEstoque(loc_cEmpsH, loc_cGruposH, loc_cEstosH, loc_cProsH, loc_dDatasH)
                            THIS.RecalcularCusto(loc_cEmpsH, loc_cProsH, loc_dDatasH)
                        ENDIF
                        SELECT cursor_4c_His
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_His")
                    USE IN cursor_4c_His
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Procedure: " + loc_oErro.Procedure, "Erro dmoBO.CancelarDesmontagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RecalcularEstoque - Stub para fRecalculaP (nao portada do Framework)
    * fRecalculaP recalcula posicao de estoque apos movimentacao de historico
    * TODO: Implementar logica completa de recalculo de estoque quando portado
    *==========================================================================
    PROTECTED PROCEDURE RecalcularEstoque(par_cEmps, par_cGrupos, par_cEstos, par_cPros, par_dDatas)
        *-- fRecalculaP nao foi portada do Framework Fortyus
        *-- Nesta versao, o recalculo de saldo/posicao sera executado pelo servidor
        *-- via triggers ou processo batch separado
    ENDPROC

    *==========================================================================
    * RecalcularCusto - Stub para fRecalculaC (nao portada do Framework)
    * fRecalculaC recalcula custo medio do produto apos movimentacao
    * TODO: Implementar logica completa de recalculo de custo quando portado
    *==========================================================================
    PROTECTED PROCEDURE RecalcularCusto(par_cEmps, par_cPros, par_dDatas)
        *-- fRecalculaC nao foi portada do Framework Fortyus
        *-- Nesta versao, o recalculo de custo sera executado pelo servidor
        *-- via triggers ou processo batch separado
    ENDPROC

    *==========================================================================
    * VerificarBloqueio - Verifica se a data esta em periodo bloqueado
    * Wrapper para fVerificaBloqueio de functions.prg
    *==========================================================================
    PROCEDURE VerificarBloqueio(par_dData)
        LOCAL loc_nResultado
        loc_nResultado = 0

        TRY
            IF TYPE("par_dData") = "D" AND !EMPTY(par_dData)
                loc_nResultado = fVerificaBloqueio(par_dData, .NULL.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro dmoBO.VerificarBloqueio")
        ENDTRY

        RETURN loc_nResultado
    ENDPROC

ENDDEFINE
