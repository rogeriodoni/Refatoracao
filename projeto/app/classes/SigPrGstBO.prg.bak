*==============================================================================
* SigPrGstBO.prg - Business Object: Geracao de Movimentacoes de Estoque
*
* Tabela principal : SigMvCab (cabecalho de movimentacao gerado)
* Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
* Herda de         : BusinessBase
*
* Este BO opera sobre cursores passados pelo formulario pai:
*   Entrada  : csCabec, csItens, CsEstPe, CrSigCdNec
*   Saida    : SigMvCab, SigMvItn, SigMvIts, SigMvPec, SigInBep (via SQLEXEC)
*==============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Contexto do formulario (recebido do pai via Init)
    *--------------------------------------------------------------------------
    this_cGrupoOper     = ""    && Grupo de operacao (C10)
    this_cPcEscolha     = ""    && Escolha de processamento passada pelo pai

    *--------------------------------------------------------------------------
    * Campos de csCabec - Cabecalho da necessidade/pedido de origem
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (C3)
    this_cEmpDs         = ""    && Descricao da empresa (display)
    this_cDopes         = ""    && Codigo da operacao (C20)
    this_nNumes         = 0     && Numero do pedido (N6,0)
    this_cMascNum       = ""    && Mascara formatada do numero
    this_dDatars        = {}    && Data de referencia do pedido
    this_cIdChaves      = ""    && ID unico (via fUniqueIds)
    this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
    this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
    this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
    this_cContaOs       = ""    && Conta de Origem (C10)
    this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
    this_cContaDs       = ""    && Conta de Destino (C10)
    this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
    this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
    this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
    this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)

    *--------------------------------------------------------------------------
    * Campos de csItens - Item corrente do pedido
    *--------------------------------------------------------------------------
    this_nCItens        = 0     && Numero sequencial do item
    this_cCPros         = ""    && Codigo do produto
    this_cDPros         = ""    && Descricao do produto
    this_cMoedas        = ""    && Moeda de cotacao
    this_nUnits         = 0     && Preco unitario
    this_nQtds          = 0     && Quantidade solicitada
    this_nTotas         = 0     && Total do item

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor csCabec para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_cMascNum    = TratarNulo(MascNum, "C")
                THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
                THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
                THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
                THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
                THIS.this_cGerado     = TratarNulo(Gerado, "C")
                THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
                THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
                THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                IF TYPE("EmpDnPs") != "U"
                    THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                ENDIF
                IF TYPE("Datars") != "U"
                    THIS.this_dDatars = TratarNulo(Datars, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica pre-condicoes para gerar pedido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione um pedido na grade e tente novamente."
            RETURN .F.
        ENDIF
        IF !EMPTY(ALLTRIM(csCabec.Gerado))
            THIS.this_cMensagemErro = "Este pedido j" + CHR(225) + " foi gerado anteriormente."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPedido - Opera principal: gera movimentacoes de estoque a partir
    *   dos cursores csCabec, csItens e CsEstPe para as tabelas SQL Server.
    *   Equivalente ao PROCEDURE gerarpedido do formulario legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarPedido()
        LOCAL loc_lResultado, loc_lOks, loc_lTransacaoAberta
        LOCAL loc_nNum, loc_cMascNum, loc_cEmpDopNums, loc_cSQL
        LOCAL loc_cEmps, loc_cDopes, loc_cGrupoOs, loc_cContaOs
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPsNec
        LOCAL loc_loBarra

        loc_lResultado       = .F.
        loc_lOks             = .T.
        loc_lTransacaoAberta = .F.

        TRY
            *-- Verificar pre-condicoes
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

                *-- Se ja gerado, retornar .T. diretamente (sem nova geracao)
                IF !EMPTY(ALLTRIM(csCabec.Gerado))
                    loc_lResultado = .T.
                ELSE

                    *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
                    loc_cEmps    = ALLTRIM(csCabec.Emps)
                    loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
                    loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
                    loc_cContaOs = ALLTRIM(csCabec.ContaOs)
                    loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
                    loc_cContaDs = ALLTRIM(csCabec.ContaDs)

                    *-- Capturar EmpDnPs de CrSigCdNec
                    loc_cEmpDnPsNec = ""
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
                        loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
                    ENDIF

                    *-- Carregar SigCdEmb para divisao de embalagem
                    loc_cSQL = "SELECT Cods, Multis FROM SigCdEmb"
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmb") < 1
                        loc_lOks = .F.
                        MsgErro("Falha ao carregar tabela de embalagem (SigCdEmb)", "Erro")
                    ENDIF

                    IF loc_lOks
                        SELECT crSigCdEmb
                        INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods
                        GO TOP IN crSigCdEmb

                        *-- Gerar numero unico e mascara para o novo movimento
                        loc_nNum        = fGerUniqueKey(ALLTRIM(loc_cDopes) + go_4c_Sistema.cCodEmpresa)
                        loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNum))
                        loc_cEmpDopNums = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + STR(loc_nNum, 6)

                        *-- Barra de progresso
                        loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                            "Gravando " + ALLTRIM(loc_cDopes) + "...", 3)
                        loc_loBarra.Show()
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Para Lan" + CHR(231) + "amento")

                        *-- Iniciar transacao SQL Server
                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        loc_lTransacaoAberta = .T.

                        *-- INSERT INTO SigMvCab
                        loc_cSQL = "INSERT INTO SigMvCab " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdncrds, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir cabe" + CHR(231) + "alho de " + ;
                                "movimenta" + CHR(231) + CHR(227) + "o (SigMvCab)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- INSERT INTO SigInBep (rastreio: cidchaves + empdnps + empdopnums)
                        loc_cSQL = "INSERT INTO SigInBep " + ;
                                   "(cidchaves, empdnps, empdopnums) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 33)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir registro de rastreio (SigInBep)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Dos Itens")

                        *-- Processar itens de csItens -> SigMvItn e SigMvIts
                        LOCAL loc_nCItens, loc_cCPros, loc_cDPros, loc_cMoedas
                        LOCAL loc_nUnits, loc_nQtds, loc_nTotas
                        LOCAL loc_cCGrus, loc_cCUnisPro, loc_nTipoEstos, loc_nEmbs
                        LOCAL loc_cSQLItem, loc_nMultis, loc_cCodEmbs, loc_nQtdEmb
                        LOCAL loc_lSub

                        IF USED("csItens")
                            SELECT csItens
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos do item ANTES de SQLEXEC
                                loc_nCItens = csItens.CItens
                                loc_cCPros  = ALLTRIM(csItens.CPros)
                                loc_cDPros  = LEFT(ALLTRIM(csItens.DPros), 65)
                                loc_cMoedas = LEFT(ALLTRIM(csItens.Moedas), 3)
                                loc_nUnits  = NVL(csItens.Units, 0)
                                loc_nQtds   = NVL(csItens.Qtds, 0)
                                loc_nTotas  = NVL(csItens.Totas, 0)

                                *-- Buscar dados do produto (grupo e unidade)
                                loc_cCGrus   = ""
                                loc_cCUnisPro = ""
                                loc_cSQLItem = "SELECT TOP 1 cgrus, cunis FROM SigCdPro " + ;
                                               "WHERE cpros = " + EscaparSQL(loc_cCPros)
                                IF USED("crTmpPro")
                                    USE IN crTmpPro
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpPro") > 0
                                    SELECT crTmpPro
                                    IF !EOF()
                                        loc_cCGrus    = ALLTRIM(cgrus)
                                        loc_cCUnisPro = ALLTRIM(cunis)
                                    ENDIF
                                ENDIF

                                *-- Buscar tipo do grupo (para verificar embalagem)
                                loc_nTipoEstos = 0
                                loc_nEmbs      = 0
                                IF !EMPTY(loc_cCGrus)
                                    loc_cSQLItem = "SELECT TOP 1 tipoestos, embs FROM SigCdGrp " + ;
                                                   "WHERE cgrus = " + EscaparSQL(loc_cCGrus)
                                    IF USED("crTmpGru")
                                        USE IN crTmpGru
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpGru") > 0
                                        SELECT crTmpGru
                                        IF !EOF()
                                            loc_nTipoEstos = NVL(tipoestos, 0)
                                            loc_nEmbs      = NVL(embs, 0)
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- INSERT INTO SigMvItn
                                loc_cSQLItem = "INSERT INTO SigMvItn " + ;
                                    "(emps, dopes, numes, citens, cpros, dpros, " + ;
                                    " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                    EscaparSQL(loc_cCPros) + ", " + ;
                                    EscaparSQL(loc_cDPros) + ", " + ;
                                    EscaparSQL(loc_cMoedas) + ", " + ;
                                    FormatarNumeroSQL(loc_nUnits, 5) + ", " + ;
                                    FormatarNumeroSQL(loc_nQtds, 3) + ", " + ;
                                    FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    "GETDATE())"
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir item de movimenta" + ;
                                        CHR(231) + CHR(227) + "o (SigMvItn)", "Erro")
                                ENDIF

                                *-- Verificar embalagem e inserir SigMvIts se aplicavel
                                IF loc_lOks
                                    loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)
                                    IF loc_lSub AND !EMPTY(loc_cCUnisPro)
                                        loc_nMultis  = 0
                                        loc_cCodEmbs = ""
                                        SELECT crSigCdEmb
                                        IF SEEK(UPPER(ALLTRIM(loc_cCUnisPro)), "crSigCdEmb", "Cods")
                                            loc_nMultis  = NVL(crSigCdEmb.Multis, 0)
                                            loc_cCodEmbs = ALLTRIM(crSigCdEmb.Cods)
                                        ENDIF

                                        IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
                                            loc_nQtdEmb = loc_nQtds / loc_nMultis
                                            loc_cSQLItem = "INSERT INTO SigMvIts " + ;
                                                "(emps, dopes, numes, cpros, citens, qtds, " + ;
                                                " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
                                                "VALUES (" + ;
                                                EscaparSQL(loc_cEmps) + ", " + ;
                                                EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                                FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                                EscaparSQL(loc_cCPros) + ", " + ;
                                                FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                                FormatarNumeroSQL(loc_nQtdEmb, 3) + ", " + ;
                                                EscaparSQL(loc_cCodEmbs) + ", " + ;
                                                FormatarNumeroSQL(loc_nMultis, 3) + ", " + ;
                                                EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                                EscaparSQL(fUniqueIds()) + ", " + ;
                                                "GETDATE())"
                                            IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                                loc_lOks = .F.
                                                MsgErro("Falha ao inserir subitem de embalagem (SigMvIts)", "Erro")
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                SELECT csItens
                            ENDSCAN

                            SELECT csItens
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- Processar CsEstPe -> SigMvPec
                        IF USED("CsEstPe")
                            LOCAL loc_nCodigos, loc_dDatatrans, loc_nNtrans
                            LOCAL loc_cLocals, loc_nValobxs, loc_cEmpSubsLocal
                            LOCAL loc_dDatas, loc_lChksubn, loc_dDtagends
                            LOCAL loc_lChkpagos, loc_nNparcs, loc_nValps
                            LOCAL loc_nValvars, loc_dVencps, loc_cPstatus
                            LOCAL loc_cEmpDopNumsPec, loc_cSQLPec

                            SELECT CsEstPe
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos ANTES de SQLEXEC
                                loc_nCodigos     = NVL(CsEstPe.Codigos, 0)
                                loc_dDatatrans   = CsEstPe.Datatrans
                                loc_nNtrans      = NVL(CsEstPe.Ntrans, 0)
                                loc_cLocals      = ALLTRIM(CsEstPe.Locals)
                                loc_nValobxs     = NVL(CsEstPe.Valobxs, 0)
                                loc_cEmpSubsLocal = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                                loc_dDatas       = CsEstPe.Datas
                                loc_lChksubn     = IIF(VARTYPE(CsEstPe.Chksubn) = "L", ;
                                                       CsEstPe.Chksubn, ;
                                                       NVL(CsEstPe.Chksubn, 0) = 1)
                                loc_dDtagends    = CsEstPe.Dtagends
                                loc_lChkpagos    = IIF(VARTYPE(CsEstPe.Chkpagos) = "L", ;
                                                       CsEstPe.Chkpagos, ;
                                                       NVL(CsEstPe.Chkpagos, 0) = 1)
                                loc_nNparcs      = NVL(CsEstPe.Nparcs, 0)
                                loc_nValps       = NVL(CsEstPe.Valps, 0)
                                loc_nValvars     = NVL(CsEstPe.Valvars, 0)
                                loc_dVencps      = CsEstPe.Vencps
                                loc_cPstatus     = LEFT(ALLTRIM(CsEstPe.Pstatus), 1)
                                loc_cEmpDopNumsPec = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + ;
                                                     STR(loc_nNum, 6)

                                loc_cSQLPec = "INSERT INTO SigMvPec " + ;
                                    "(emps, dopes, numes, codigos, datatrans, ntrans, " + ;
                                    " locals, valobxs, cidchaves, empdopnums, empsubns, " + ;
                                    " datas, chksubn, dtagends, chkpagos, nparcs, " + ;
                                    " valps, valvars, vencps, pstatus) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCodigos, 0) + ", " + ;
                                    FormatarDataSQL(loc_dDatatrans) + ", " + ;
                                    FormatarNumeroSQL(loc_nNtrans, 0) + ", " + ;
                                    EscaparSQL(LEFT(loc_cLocals, 10)) + ", " + ;
                                    FormatarNumeroSQL(loc_nValobxs, 2) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNumsPec) + ", " + ;
                                    EscaparSQL(LEFT(loc_cEmpSubsLocal, 3)) + ", " + ;
                                    FormatarDataSQL(loc_dDatas) + ", " + ;
                                    IIF(loc_lChksubn, "1", "0") + ", " + ;
                                    FormatarDataSQL(loc_dDtagends) + ", " + ;
                                    IIF(loc_lChkpagos, "1", "0") + ", " + ;
                                    FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nValps, 2) + ", " + ;
                                    FormatarNumeroSQL(loc_nValvars, 2) + ", " + ;
                                    FormatarDataSQL(loc_dVencps) + ", " + ;
                                    EscaparSQL(loc_cPstatus) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQLPec) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir parcela de pedido (SigMvPec)", "Erro")
                                ENDIF

                                SELECT CsEstPe
                            ENDSCAN

                            SELECT CsEstPe
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Preparando Grava" + CHR(231) + CHR(227) + "o")

                        *-- Auditoria
                        THIS.this_cDopes    = ALLTRIM(loc_cDopes)
                        THIS.this_cGerEmps  = loc_cEmps
                        THIS.this_cGerDopes = ALLTRIM(loc_cDopes)
                        THIS.this_nGerNumes = loc_nNum
                        THIS.RegistrarAuditoria("GERAR")

                        *-- Commit da transacao
                        IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                        ELSE
                            loc_lTransacaoAberta = .F.
                        ENDIF
                    ENDIF

                    IF !loc_lOks AND loc_lTransacaoAberta
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                    ENDIF

                    IF loc_lOks
                        *-- Atualizar csCabec local com marcacao de gerado
                        SELECT csCabec
                        REPLACE Gerado   WITH "OK", ;
                                GerEmps  WITH loc_cEmps, ;
                                GerDopes WITH ALLTRIM(loc_cDopes), ;
                                GerNumes WITH loc_nNum

                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        loc_lResultado = .T.
                    ENDIF

                    *-- Fechar cursores temporarios
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF USED("crTmpPro")
                        USE IN crTmpPro
                    ENDIF
                    IF USED("crTmpGru")
                        USE IN crTmpGru
                    ENDIF

                    loc_loBarra.Complete(.T.)

                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro GerarPedido")
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        ENDTRY

        *-- Restaurar SET KEY dos cursores de iteracao
        IF USED("csItens")
            SELECT csItens
            SET KEY TO
        ENDIF
        IF USED("CsEstPe")
            SELECT CsEstPe
            SET KEY TO
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPeriodo - Stub de compatibilidade com chamadas de SigMvCab
    * O formulario legado definia este metodo para nao gerar erro nas chamadas
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Log da operacao de geracao de movimento
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cMsg, loc_cDopps
        loc_cDopps = ""
        IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
            IF TYPE("CrSigCdNec.Dopps") != "U"
                loc_cDopps = ALLTRIM(CrSigCdNec.Dopps)
            ENDIF
        ENDIF
        loc_cMsg = "Ger.Movim.: " + ALLTRIM(THIS.this_cGerDopes) + ;
                   " Num." + ALLTRIM(STR(THIS.this_nGerNumes, 6)) + ;
                   " Emp." + ALLTRIM(THIS.this_cGerEmps)
        IF !EMPTY(loc_cDopps)
            =fGravarLog("T", loc_cDopps, gc_4c_UsuarioLogado, loc_cMsg)
        ENDIF
    ENDPROC

ENDDEFINE
