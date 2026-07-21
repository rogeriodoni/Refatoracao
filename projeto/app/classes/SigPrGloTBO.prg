*==============================================================================
* SigPrGloTBO.prg - Business Object para Processamento de O.P. por Totais
* Form OPERACIONAL: processa SigMvCab por totais e gera entradas em SigOpPic
* Variante de SigPrGloBO - mesmo esquema de dados, processamento por totais
*==============================================================================

DEFINE CLASS SigPrGloTBO AS BusinessBase

    *-- Tabela alvo de persistencia (Ordem de Producao gerada)
    this_cTabela      = "SigOpPic"
    this_cCampoChave  = "Cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de SigOpPic (registro individual da OP para CRUD)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""
    this_cEmps        = ""
    this_cDopes       = ""
    this_cDopps       = ""
    this_nNumes       = 0
    this_nNumps       = 0
    this_nNops        = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_nQtds        = 0
    this_dDataes      = {}
    this_dDataps      = {}
    this_dDataTrans   = {}
    this_dDtGeras     = {}
    this_dDtFunds     = {}
    this_cLocals      = ""
    this_nNtrans      = 0
    this_cEmpDs       = ""
    this_nSeqDivs     = 0
    this_cCodCors     = ""
    this_cCodTams     = ""
    this_lDivs        = .F.
    this_lImprs       = .F.
    this_lIimprs      = .F.
    this_cUsuars      = ""
    this_nNopMaes     = 0
    this_nPesos       = 0
    this_nCodBarras   = 0
    this_nQtdCpnts    = 0
    this_nQtdTubos    = 0
    this_cMoedas      = ""
    this_nUnits       = 0
    this_nNfunds      = 0
    this_cEmpDnps     = ""
    this_cEmpDopnops  = ""
    this_cEmpDopnums  = ""
    this_cNotas       = ""
    this_cCodTgOps    = ""
    this_nCitens      = 0
    this_cObss        = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Periodo de Emissao
    *--------------------------------------------------------------------------
    this_dDataei    = {}
    this_dDataef    = {}

    *-- Periodo de Previsao de Entrega
    this_dDatapi    = {}
    this_dDatapf    = {}

    *-- Previsao de Entrega e Data de Geracao
    this_dPrevisao  = {}
    this_dGeracao   = {}

    *--------------------------------------------------------------------------
    * Parametros de filtro - Operacao
    *--------------------------------------------------------------------------
    this_cOperacao   = ""
    this_nOperacaoi  = 0
    this_nOperacaof  = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Conta (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta = ""
    this_cConta      = ""
    this_cDConta     = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Responsavel/Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp  = ""
    this_cContaResp  = ""
    this_cDContaResp = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Empresa
    *--------------------------------------------------------------------------
    this_cCodEmpresa = ""
    this_cDsEmpresa  = ""

    *-- Checkbox "Nao Empenhar Pedras" (0=empenhar, 1=nao empenhar)
    this_nNaoEmpenharPedras = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Numero da OP e Tipo de Geracao
    *--------------------------------------------------------------------------
    this_nNumeroOP  = 0
    this_cTipoGerOP = ""

    *--------------------------------------------------------------------------
    * Propriedades de modo de execucao
    *--------------------------------------------------------------------------
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_lPorDestino = .F.
    this_lGerPorTp   = .F.
    this_lAlterEmp   = .T.

    *--------------------------------------------------------------------------
    * Cursores internos de trabalho
    *--------------------------------------------------------------------------
    this_cCursorOper    = "cursor_4c_TmpOperT"
    this_cCursorTiposGO = "cursor_4c_CrTmpTpGopT"
    this_cCursorParam   = "cursor_4c_CrSigCdPamT"
    this_cCursorCabec   = "cursor_4c_TmpCabecT"
    this_cCursorItens   = "cursor_4c_TmpItensT"

    *==========================================================================
    * Init - configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "Cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna Cidchaves (PK de SigOpPic) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * MontarCidChaves - Gera Cidchaves = Emps + Dopes + Numps (padrao SigOpPic)
    *==========================================================================
    PROTECTED PROCEDURE MontarCidChaves()
        LOCAL loc_cResultado
        loc_cResultado = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                         PADR(ALLTRIM(THIS.this_cDopes), 6) + ;
                         PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
        RETURN LEFT(loc_cResultado, 20)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor de SigOpPic
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(Cidchaves, "C")
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_cDopps      = TratarNulo(Dopps, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_nNumps      = TratarNulo(Numps, "N")
                THIS.this_nNops       = TratarNulo(Nops, "N")
                THIS.this_cCpros      = TratarNulo(Cpros, "C")
                THIS.this_cDpros      = TratarNulo(Dpros, "C")
                THIS.this_nQtds       = TratarNulo(Qtds, "N")
                THIS.this_dDataes     = TratarNulo(Dataes, "D")
                THIS.this_dDataps     = TratarNulo(Dataps, "D")
                THIS.this_dDataTrans  = TratarNulo(DataTrans, "D")
                THIS.this_dDtGeras    = TratarNulo(DtGeras, "D")
                THIS.this_dDtFunds    = TratarNulo(DtFunds, "D")
                THIS.this_cLocals     = TratarNulo(Locals, "C")
                THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
                THIS.this_cEmpDs      = TratarNulo(Empds, "C")
                THIS.this_nSeqDivs    = TratarNulo(SeqDivs, "N")
                THIS.this_cCodCors    = TratarNulo(CodCors, "C")
                THIS.this_cCodTams    = TratarNulo(CodTams, "C")
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    IF VARTYPE(Divs) = "L"
                        THIS.this_lDivs = Divs
                    ELSE
                        IF VARTYPE(Divs) = "L"
                            THIS.this_lDivs = Divs
                        ELSE
                            IF VARTYPE(Divs) = "L"
                                THIS.this_lDivs = Divs
                            ELSE
                                IF VARTYPE(Divs) = "L"
                                    THIS.this_lDivs = Divs
                                ELSE
                                    IF VARTYPE(Divs) = "L"
                                        THIS.this_lDivs = Divs
                                    ELSE
                                        THIS.this_lDivs = (NVL(Divs, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(Imprs) = "L"
                    THIS.this_lImprs = NVL(Imprs, .F.)
                ELSE
                    IF VARTYPE(Imprs) = "L"
                        THIS.this_lImprs = Imprs
                    ELSE
                        IF VARTYPE(Imprs) = "L"
                            THIS.this_lImprs = Imprs
                        ELSE
                            IF VARTYPE(Imprs) = "L"
                                THIS.this_lImprs = Imprs
                            ELSE
                                IF VARTYPE(Imprs) = "L"
                                    THIS.this_lImprs = Imprs
                                ELSE
                                    IF VARTYPE(Imprs) = "L"
                                        THIS.this_lImprs = Imprs
                                    ELSE
                                        THIS.this_lImprs = (NVL(Imprs, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(Iimprs) = "L"
                    THIS.this_lIimprs = NVL(Iimprs, .F.)
                ELSE
                    IF VARTYPE(Iimprs) = "L"
                        THIS.this_lIimprs = Iimprs
                    ELSE
                        IF VARTYPE(Iimprs) = "L"
                            THIS.this_lIimprs = Iimprs
                        ELSE
                            IF VARTYPE(Iimprs) = "L"
                                THIS.this_lIimprs = Iimprs
                            ELSE
                                IF VARTYPE(Iimprs) = "L"
                                    THIS.this_lIimprs = Iimprs
                                ELSE
                                    IF VARTYPE(Iimprs) = "L"
                                        THIS.this_lIimprs = Iimprs
                                    ELSE
                                        THIS.this_lIimprs = (NVL(Iimprs, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_cUsuars     = TratarNulo(Usuars, "C")
                THIS.this_nNopMaes    = TratarNulo(NopMaes, "N")
                THIS.this_nPesos      = TratarNulo(Pesos, "N")
                THIS.this_nCodBarras  = TratarNulo(CodBarras, "N")
                THIS.this_nQtdCpnts   = TratarNulo(QtdCpnts, "N")
                THIS.this_nQtdTubos   = TratarNulo(QtdTubos, "N")
                THIS.this_cMoedas     = TratarNulo(Moedas, "C")
                THIS.this_nUnits      = TratarNulo(Units, "N")
                THIS.this_nNfunds     = TratarNulo(Nfunds, "N")
                THIS.this_cEmpDnps    = TratarNulo(Empdnps, "C")
                THIS.this_cEmpDopnops = TratarNulo(Empdopnops, "C")
                THIS.this_cEmpDopnums = TratarNulo(Empdopnums, "C")
                THIS.this_cNotas      = TratarNulo(Notas, "C")
                THIS.this_cCodTgOps   = TratarNulo(CodTgOps, "C")
                THIS.this_nCitens     = TratarNulo(Citens, "N")
                IF TYPE(par_cAliasCursor + ".Obss") <> "U"
                    THIS.this_cObss = TratarNulo(Obss, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere um registro na tabela SigOpPic
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps)
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
            ENDIF
            IF EMPTY(THIS.this_dDtGeras)
                THIS.this_dDtGeras = DATE()
            ENDIF
            IF EMPTY(THIS.this_cEmpDs)
                THIS.this_cEmpDs = THIS.this_cEmps
            ENDIF
            IF EMPTY(THIS.this_cLocals)
                THIS.this_cLocals = ""
            ENDIF
            IF EMPTY(THIS.this_cDopps)
                THIS.this_cDopps = THIS.this_cDopes
            ENDIF
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.MontarCidChaves()
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnums)
                THIS.this_cEmpDopnums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDnps)
                THIS.this_cEmpDnps = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                     PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnops)
                THIS.this_cEmpDopnops = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0")
            ENDIF

            loc_cSQL = "INSERT INTO SigOpPic " + ;
                "(Cidchaves, Emps, Dopes, Dopps, Numes, Numps, Nops, Cpros, Dpros, Qtds, " + ;
                "Dataes, Dataps, DataTrans, DtGeras, DtFunds, Locals, Ntrans, Empds, SeqDivs, " + ;
                "CodCors, CodTams, Divs, Imprs, Iimprs, Usuars, NopMaes, Pesos, CodBarras, " + ;
                "QtdCpnts, QtdTubos, Moedas, Units, Nfunds, Empdnps, Empdopnops, " + ;
                "Empdopnums, Notas, CodTgOps, Citens, Obss) VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cDopes) + ", " + ;
                EscaparSQL(THIS.this_cDopps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                EscaparSQL(THIS.this_cCpros) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 3) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                EscaparSQL(THIS.this_cLocals) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodCors) + ", " + ;
                EscaparSQL(THIS.this_cCodTams) + ", " + ;
                IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                EscaparSQL(THIS.this_cMoedas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDnps, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnops, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnums, 29)) + ", " + ;
                EscaparSQL(THIS.this_cNotas) + ", " + ;
                EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                EscaparSQL(THIS.this_cObss) + ")"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Inserir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigOpPic (pela PK Cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para atualizar."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "UPDATE SigOpPic SET " + ;
                    "Emps = "      + EscaparSQL(THIS.this_cEmps)  + ", " + ;
                    "Dopes = "     + EscaparSQL(THIS.this_cDopes) + ", " + ;
                    "Dopps = "     + EscaparSQL(THIS.this_cDopps) + ", " + ;
                    "Numes = "     + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                    "Numps = "     + FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                    "Nops = "      + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                    "Cpros = "     + EscaparSQL(THIS.this_cCpros) + ", " + ;
                    "Dpros = "     + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                    "Qtds = "      + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                    "Dataes = "    + FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                    "Dataps = "    + FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                    "DataTrans = " + FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                    "DtGeras = "   + FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                    "DtFunds = "   + FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                    "Locals = "    + EscaparSQL(THIS.this_cLocals) + ", " + ;
                    "Ntrans = "    + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                    "Empds = "     + EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                    "SeqDivs = "   + FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", " + ;
                    "CodCors = "   + EscaparSQL(THIS.this_cCodCors) + ", " + ;
                    "CodTams = "   + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                    "Divs = "      + IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                    "Imprs = "     + IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                    "Iimprs = "    + IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                    "Usuars = "    + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "NopMaes = "   + FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                    "Pesos = "     + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                    "CodBarras = " + FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", " + ;
                    "QtdCpnts = "  + FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                    "QtdTubos = "  + FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                    "Moedas = "    + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                    "Units = "     + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                    "Nfunds = "    + FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                    "Notas = "     + EscaparSQL(THIS.this_cNotas) + ", " + ;
                    "CodTgOps = "  + EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                    "Citens = "    + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                    "Obss = "      + EscaparSQL(THIS.this_cObss) + " " + ;
                    "WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Atualizar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para excluir."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("DELETE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Excluir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Carrega um registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_CarregaOpT"
        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
            loc_cSQL = "SELECT * FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) < 1
                THIS.this_cMensagemErro = "Falha ao carregar registro de SigOpPic."
            ELSE
                IF RECCOUNT(loc_cCursor) > 0
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado em SigOpPic."
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOperacoes - Carrega cursor de operacoes validas (cursor_4c_TmpOperT)
    * Retorna .T. se encontrou ao menos uma operacao configurada
    *==========================================================================
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOper)
                USE IN (THIS.this_cCursorOper)
            ENDIF

            loc_cSQL = "SELECT ISNULL(b.OpeGops, ' ') AS OpeGops, " + ;
                       "ISNULL(b.CodTgOps, ' ') AS CodTgOps, " + ;
                       "a.Dopes, a.NDopes, a.Globalizas, a.Reservas, a.Opers, " + ;
                       "0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOper) < 1
                MsgErro("Falha ao carregar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                SELECT (THIS.this_cCursorOper)
                INDEX ON Dopes TAG Dopes
                GO TOP
                IF EOF()
                    MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar Ordem de Produ" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTiposGeracao - Carrega cursor de tipos de geracao de OP
    * Resultado em cursor_4c_CrTmpTpGopT
    *==========================================================================
    PROCEDURE CarregarTiposGeracao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorTiposGO)
                USE IN (THIS.this_cCursorTiposGO)
            ENDIF
            IF USED("cursor_4c_TmpTpGopT_raw")
                USE IN cursor_4c_TmpTpGopT_raw
            ENDIF

            loc_cSQL = "SELECT 1 AS Acesso, * FROM SigInTgo"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGopT_raw") < 1
                MsgErro("Falha ao carregar Tipos de Gera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT * FROM cursor_4c_TmpTpGopT_raw ;
                    WHERE Acesso = 1 ;
                    INTO CURSOR (THIS.this_cCursorTiposGO) READWRITE
                USE IN cursor_4c_TmpTpGopT_raw

                SELECT (THIS.this_cCursorTiposGO)
                INDEX ON Codigos TAG Codigos
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega parametros do sistema de SigCdPam
    * Resultado em cursor_4c_CrSigCdPamT
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF

            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, " + ;
                          "GlobAutos, DopEntAus, TpOpEntAus, AutComps"

            loc_cSQL = "SELECT TOP 1 " + loc_cCampos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam) < 1
                MsgErro("Falha ao carregar Par" + CHR(226) + "metros (SigCdPam).", "Erro")
            ELSE
                IF RECCOUNT(THIS.this_cCursorParam) = 0
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o configurados (SigCdPam vazio).", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPacotes - Carrega SigCdPac (configuracoes de pacote)
    * Resultado em cursor_4c_CrSigCdPacT
    *==========================================================================
    PROCEDURE CarregarPacotes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_CrSigCdPacT")
                USE IN cursor_4c_CrSigCdPacT
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdPacT") < 1
                MsgErro("Falha ao carregar SigCdPac.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida parametros obrigatorios antes do processamento
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        TRY
            IF !THIS.this_lReserva
                IF EMPTY(THIS.this_dPrevisao)
                    MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
                IF loc_lValido AND !THIS.this_lAutomatico AND EMPTY(THIS.this_dGeracao)
                    MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDataef)
                IF !EMPTY(THIS.this_dDataei) AND THIS.this_dDataef < THIS.this_dDataei
                    MsgAviso("A Data Final de Emiss" + CHR(227) + "o Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDatapf)
                IF !EMPTY(THIS.this_dDatapi) AND THIS.this_dDatapf < THIS.this_dDatapi
                    MsgAviso("A Data Final de Previs" + CHR(227) + "o de Entrega Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarNumeroOP - Verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se o numero JA existe (impede uso)
    *==========================================================================
    PROCEDURE VerificarNumeroOP(par_nNumeroOP)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.
        TRY
            IF par_nNumeroOP > 0
                loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(par_nNumeroOP, 0)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpiT") >= 1
                    loc_lExiste = (RECCOUNT("cursor_4c_TmpOpiT") > 0)
                ENDIF
                IF USED("cursor_4c_TmpOpiT")
                    USE IN cursor_4c_TmpOpiT
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * ProcessarOP - Processa ordens de producao por totais conforme parametros
    * Popula cursor_4c_TmpCabecT e cursor_4c_TmpItensT para visualizacao
    * Retorna .T. se encontrou registros para processar
    * Difere de SigPrGloBO.ProcessarOP: agrupa itens por produto (totalizacao)
    *==========================================================================
    PROCEDURE ProcessarOP()
        LOCAL loc_lSucesso, loc_lAbort, loc_cSQL
        LOCAL loc_cConde, loc_cCondp, loc_cDopp, loc_cLcEmp, loc_cTpGOp
        LOCAL loc_cOperacao, loc_nOperacaoi, loc_nOperacaof
        LOCAL loc_cGrupo, loc_cConta, loc_cGrupoV, loc_cContaV
        LOCAL loc_nOpZers, loc_nEntPes
        LOCAL loc_cDopes, loc_nGlobalizas, loc_cOpers, loc_cOpeGops, loc_nCarCompos
        LOCAL loc_cCodTgOps
        LOCAL loc_lBrk1

        loc_lSucesso = .F.
        loc_lAbort   = .F.
        TRY
            *-- Verificar pre-requisitos
            IF !USED(THIS.this_cCursorOper)
                MsgErro("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas. Execute CarregarOperacoes() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF
            IF !loc_lAbort AND !USED(THIS.this_cCursorParam)
                MsgErro("Par" + CHR(226) + "metros n" + CHR(227) + "o carregados. Execute CarregarParametros() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF

            IF !loc_lAbort
                *-- Fechar cursores de saida anteriores
                IF USED(THIS.this_cCursorCabec)
                    USE IN (THIS.this_cCursorCabec)
                ENDIF
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF
                IF USED("cursor_4c_DbParamT")
                    USE IN cursor_4c_DbParamT
                ENDIF
                IF USED("cursor_4c_TotaisTemp")
                    USE IN cursor_4c_TotaisTemp
                ENDIF

                *-- Copiar parametros para variaveis locais
                loc_cOperacao  = ALLTRIM(THIS.this_cOperacao)
                loc_nOperacaoi = THIS.this_nOperacaoi
                loc_nOperacaof = THIS.this_nOperacaof
                loc_cGrupo     = ALLTRIM(THIS.this_cGrupoConta)
                loc_cConta     = ALLTRIM(THIS.this_cConta)
                loc_cGrupoV    = ALLTRIM(THIS.this_cGrupoResp)
                loc_cContaV    = ALLTRIM(THIS.this_cContaResp)
                loc_cTpGOp     = ALLTRIM(THIS.this_cTipoGerOP)
                loc_cLcEmp     = IIF(EMPTY(THIS.this_cCodEmpresa), go_4c_Sistema.cCodEmpresa, ALLTRIM(THIS.this_cCodEmpresa))

                *-- Preparar DbParam
                loc_nOpZers = 0
                loc_nEntPes = 0
                IF THIS.this_lGerPorTp AND USED(THIS.this_cCursorTiposGO)
                    IF SEEK(loc_cTpGOp, THIS.this_cCursorTiposGO, "Codigos")
                        SELECT (THIS.this_cCursorTiposGO)
                        loc_nOpZers = NVL(OpZers, 0)
                        loc_nEntPes = NVL(EntPes, 0)
                    ENDIF
                ELSE
                    IF USED("cursor_4c_CrSigCdPacT")
                        SELECT cursor_4c_CrSigCdPacT
                        GO TOP
                        IF !EOF()
                            loc_nOpZers = NVL(OpZers, 0)
                        ENDIF
                    ENDIF
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_DbParamT (CodTgOps C(10) NULL, OpZers N(1) NULL, EntPes N(1) NULL)
                INSERT INTO cursor_4c_DbParamT (CodTgOps, OpZers, EntPes) VALUES (loc_cTpGOp, loc_nOpZers, loc_nEntPes)
                SET NULL OFF

                *-- Construir condicao de data de emissao
                IF EMPTY(THIS.this_dDataef)
                    loc_cConde = ""
                ELSE
                    IF !EMPTY(THIS.this_dDataei)
                        loc_cConde = "Datas >= " + FormatarDataSQL(THIS.this_dDataei) + ;
                                     " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ELSE
                        loc_cConde = "Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ENDIF
                ENDIF

                *-- Construir condicao de data de previsao de entrega
                IF EMPTY(THIS.this_dDatapi)
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = ""
                    ELSE
                        loc_cCondp = "PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ELSE
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + " AND "
                    ELSE
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + ;
                                     " AND PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ENDIF

                *-- Cursor de totais por produto (diferencial da versao Totais)
                SET NULL ON
                CREATE CURSOR cursor_4c_TotaisTemp ;
                    (Dopes C(20) NULL, CPros C(14) NULL, Dpros C(40) NULL, ;
                     Linhas C(10) NULL, TotalQtds N(12,3) NULL, TotalPeso N(12,2) NULL, ;
                     Emps C(3) NULL)
                SET NULL OFF
                INDEX ON Dopes + CPros TAG DopesPro

                *-- Criar cursor de cabecalhos por operacao (agrupado/totalizado)
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorCabec) ;
                    (Flag L NULL, Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, ;
                     Grupo C(10) NULL, Conta C(10) NULL, Datas D NULL, Entregas D NULL, ;
                     Grupov C(10) NULL, Contav C(10) NULL, Obs M NULL, Peso N(12,2) NULL, ;
                     GrupoDs C(10) NULL, ContaDs C(10) NULL, DConta C(40) NULL, ;
                     Notas C(6) NULL, Jobs C(10) NULL)
                SET NULL OFF
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Criar cursor de itens totalizados por produto
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, CPros C(14) NULL, ;
                     Qtds N(12,3) NULL, Saldo N(12,3) NULL, Peso N(9,3) NULL, Obs M NULL, ;
                     Linhas C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     Citens N(10) NULL, Notas C(6) NULL, dpros C(40) NULL, Reffs C(40) NULL)
                SET NULL OFF
                INDEX ON Linhas + Cpros TAG LinPro
                INDEX ON Cpros TAG Cpros
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Loop principal: percorre cada operacao
                SELECT (THIS.this_cCursorOper)
                SET ORDER TO TAG Dopes
                IF !EMPTY(loc_cOperacao)
                    SET KEY TO loc_cOperacao
                ENDIF

                loc_lBrk1 = .F.
                SCAN WHILE !loc_lBrk1

                    loc_cDopes      = ALLTRIM(Dopes)
                    loc_nGlobalizas = NVL(Globalizas, 0)
                    loc_cOpers      = ALLTRIM(NVL(Opers, ""))
                    loc_cOpeGops    = ALLTRIM(NVL(OpeGops, ""))
                    loc_nCarCompos  = NVL(carcompos, 0)
                    loc_cCodTgOps   = ALLTRIM(NVL(CodTgOps, ""))

                    *-- Filtrar por tipo de geracao se GerPorTp
                    IF THIS.this_lGerPorTp AND loc_cCodTgOps <> loc_cTpGOp
                        LOOP
                    ENDIF

                    *-- Construir SQL totalizador por produto (diferencial da versao Totais)
                    loc_cSQL = "SELECT a.Emps, a.Dopes, b.CPros, MAX(b.Dpros) AS Dpros, " + ;
                               "SUM(b.Qtds) AS TotalQtds, a.GrupoOs, a.ContaOs, " + ;
                               "a.GrupoDs, a.ContaDs, a.GrVends, a.Vends " + ;
                               "FROM SigMvCab a " + ;
                               "INNER JOIN SigMvItn b ON b.EmpDopNums = " + ;
                               "a.Emps + a.Dopes + RIGHT('000000' + CAST(a.Numes AS VARCHAR(6)), 6) " + ;
                               "WHERE " + loc_cConde + loc_cCondp + ;
                               "a.Emps = " + EscaparSQL(loc_cLcEmp) + ;
                               " AND a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                               " AND a.Nops = 0"

                    IF !EMPTY(loc_cGrupo)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cConta)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND a.ContaOs = " + EscaparSQL(loc_cConta)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND a.ContaDs = " + EscaparSQL(loc_cConta)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cGrupoV)
                        loc_cSQL = loc_cSQL + " AND a.GrVends = " + EscaparSQL(loc_cGrupoV)
                    ENDIF
                    IF !EMPTY(loc_cContaV)
                        loc_cSQL = loc_cSQL + " AND a.Vends = " + EscaparSQL(loc_cContaV)
                    ENDIF

                    IF !EMPTY(loc_cOperacao)
                        IF loc_nOperacaoi > 0 AND loc_nOperacaof > 0
                            loc_cSQL = loc_cSQL + " AND a.Numes BETWEEN " + ;
                                FormatarNumeroSQL(loc_nOperacaoi, 0) + " AND " + ;
                                FormatarNumeroSQL(loc_nOperacaof, 0)
                        ENDIF
                    ENDIF

                    IF THIS.this_lReserva
                        loc_cSQL = loc_cSQL + " AND a.rNops = 0"
                    ENDIF

                    loc_cSQL = loc_cSQL + " GROUP BY a.Emps, a.Dopes, b.CPros, " + ;
                               "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.GrVends, a.Vends"

                    IF USED("cursor_4c_TmpTotaisOp")
                        USE IN cursor_4c_TmpTotaisOp
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTotaisOp") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (TotaisOp - Dopes=" + loc_cDopes + ")", "Erro")
                        loc_lBrk1 = .T.
                        EXIT
                    ENDIF

                    *-- Inserir totais no cursor de itens
                    SELECT cursor_4c_TmpTotaisOp
                    GO TOP
                    SCAN
                        IF NVL(TotalQtds, 0) > 0
                            SELECT (THIS.this_cCursorItens)
                            INSERT INTO (THIS.this_cCursorItens) ;
                                (Emps, Dopes, CPros, Qtds, Saldo, dpros) ;
                                VALUES (cursor_4c_TmpTotaisOp.Emps, ;
                                        cursor_4c_TmpTotaisOp.Dopes, ;
                                        cursor_4c_TmpTotaisOp.CPros, ;
                                        NVL(cursor_4c_TmpTotaisOp.TotalQtds, 0), ;
                                        NVL(cursor_4c_TmpTotaisOp.TotalQtds, 0), ;
                                        ALLTRIM(NVL(cursor_4c_TmpTotaisOp.Dpros, "")))
                        ENDIF
                        SELECT cursor_4c_TmpTotaisOp
                    ENDSCAN

                    IF USED("cursor_4c_TmpTotaisOp")
                        USE IN cursor_4c_TmpTotaisOp
                    ENDIF

                    *-- Reposicionar em CursorOper para continuar o SCAN
                    SELECT (THIS.this_cCursorOper)
                ENDSCAN

                *-- Restaurar SET KEY e SET ORDER
                SELECT (THIS.this_cCursorOper)
                SET KEY TO
                SET ORDER TO

                IF !loc_lBrk1
                    IF USED(THIS.this_cCursorCabec)
                        GO TOP IN (THIS.this_cCursorCabec)
                    ENDIF
                    IF USED(THIS.this_cCursorItens)
                        GO TOP IN (THIS.this_cCursorItens)
                    ENDIF

                    loc_lSucesso = USED(THIS.this_cCursorItens) AND ;
                                   !EOF(THIS.this_cCursorItens)

                    IF !loc_lSucesso
                        MsgAviso("Nenhum Item Selecionado Para Processar!!!")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " Linha=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro ao ProcessarOP Totais")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
