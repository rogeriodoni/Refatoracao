*==============================================================================
* sigpres2BO.prg - Business Object para Pedido de Estoque (SIGPRES2)
* Herda de: BusinessBase
* Tabela principal: SigMvPec (PK: cidchaves, chave negocio: empdopnums)
* Itens: SigMvItn (join SigMvIts para cor/tamanho)
*==============================================================================
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela      = "SigMvPec"
    this_cCampoChave  = "cidchaves"

    *-- Chave de negocio composta (emps+dopes+numes)
    this_cEmpdopnums  = ""

    *-- Campos de SigMvPec (schema exato)
    this_cEmps        = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nCodigos     = 0
    this_dDatatrans   = {}
    this_nNtrans      = 0
    this_cLocals      = ""
    this_nValobxs     = 0
    this_cCidchaves   = ""
    this_cEmpsubs     = ""
    this_dDatas       = {}
    this_lChksubn     = .F.
    this_dDtagends    = {}
    this_lChkpagos    = .F.
    this_nNparcs      = 0
    this_nValps       = 0
    this_nValvars     = 0
    this_dVencps      = {}
    this_cPStatus     = ""

    *-- Campos adicionais do csTemporario (origem/destino contabil)
    this_cGrupoOs     = ""
    this_cContaOs     = ""
    this_cGrupoDs     = ""
    this_cContaDs     = ""
    this_cEmpds       = ""
    this_cUsuars      = ""
    this_nNops        = 0
    this_cVends       = ""
    this_cGrvends     = ""
    this_cTabds       = ""
    this_cObses       = ""
    this_dPrazoents   = {}
    this_cMascnum     = ""
    this_cNotas       = ""
    this_lChkBxParcs  = .F.

    *-- Descricoes (preenchidas por lookup em tempo de execucao)
    this_cDconta      = ""
    this_cDcontad     = ""
    this_cDresps      = ""

    *-- Referencia ao form pai (para navegacao/callbacks)
    this_oParentForm  = .NULL.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvPec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_nCodigos     = TratarNulo(codigos,    "N")
                THIS.this_dDatatrans   = TratarNulo(datatrans,  "D")
                THIS.this_nNtrans      = TratarNulo(ntrans,     "N")
                THIS.this_cLocals      = TratarNulo(locals,     "C")
                THIS.this_nValobxs     = TratarNulo(valobxs,    "N")
                THIS.this_cCidchaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpdopnums  = TratarNulo(empdopnums, "C")
                THIS.this_cEmpsubs     = TratarNulo(empsubns,   "C")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_dDtagends    = TratarNulo(dtagends,   "D")
                THIS.this_lChkpagos    = ConverterParaLogico(chkpagos)
                THIS.this_nNparcs      = TratarNulo(nparcs,     "N")
                THIS.this_nValps       = TratarNulo(valps,      "N")
                THIS.this_nValvars     = TratarNulo(valvars,    "N")
                THIS.this_dVencps      = TratarNulo(vencps,     "D")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursorTemporario - Carrega campos do csTemporario (form)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursorTemporario(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps        = TratarNulo(emps,       "C")
                THIS.this_cEmpds       = TratarNulo(empds,      "C")
                THIS.this_cDopes       = TratarNulo(dopes,      "C")
                THIS.this_nNumes       = TratarNulo(numes,      "N")
                THIS.this_dDatas       = TratarNulo(datas,      "D")
                THIS.this_cGrupoOs     = TratarNulo(grupoos,    "C")
                THIS.this_cContaOs     = TratarNulo(contaos,    "C")
                THIS.this_cGrupoDs     = TratarNulo(grupods,    "C")
                THIS.this_cContaDs     = TratarNulo(contads,    "C")
                THIS.this_nNops        = TratarNulo(nops,       "N")
                THIS.this_cUsuars      = TratarNulo(usuars,     "C")
                THIS.this_cPStatus     = TratarNulo(pstatus,    "C")
                THIS.this_cVends       = TratarNulo(vends,      "C")
                THIS.this_cGrvends     = TratarNulo(grvends,    "C")
                THIS.this_cTabds       = TratarNulo(tabds,      "C")
                THIS.this_cObses       = TratarNulo(obses,      "C")
                THIS.this_dPrazoents   = TratarNulo(prazoents,  "D")
                THIS.this_cMascnum     = TratarNulo(mascnum,    "C")
                THIS.this_cNotas       = TratarNulo(notas,      "C")
                THIS.this_lChksubn     = ConverterParaLogico(chksubn)
                THIS.this_lChkBxParcs  = ConverterParaLogico(chkbxparcs)
                THIS.this_cEmpdopnums  = ALLTRIM(THIS.this_cEmps) + ;
                                         ALLTRIM(THIS.this_cDopes) + ;
                                         STR(THIS.this_nNumes, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro do SigMvPec pela chave de negocio
    * par_cEmpdopnums: emps+dopes+numes(6) concatenados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigMvPec conforme filtro
    * par_cFiltro: clausula WHERE adicional (sem o WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        loc_lResultado = .F.
        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = "SELECT emps, dopes, numes, datas, pstatus, cidchaves," + ;
                       " empdopnums, valobxs, nparcs, valps, valvars, vencps" + ;
                       " FROM SigMvPec" + loc_cWhere + ;
                       " ORDER BY empdopnums"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItens - Carrega cursor xEestI com itens do pedido
    * par_cEmpdopnums: chave composta do pedido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT ISNULL(b.codtams,'') AS codtams," + ;
                       " ISNULL(b.codcors,'') AS codcors, b.qtds AS QtdsS, a.*" + ;
                       " FROM SigMvItn a" + ;
                       " LEFT JOIN SigMvIts b ON a.empdopnums = b.empdopnums" + ;
                       " AND a.cpros = b.cpros AND a.citens = b.citens" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpdopnums))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigMvItn") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCursorItens - Agrega itens por cpros+codcors+codtams para o grid
    * Precisa que crSigMvItn ja esteja carregado (via BuscarItens)
    *--------------------------------------------------------------------------
    PROCEDURE MontarCursorItens(par_cEmpdopnums)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF !USED("crSigMvItn")
                IF !THIS.BuscarItens(par_cEmpdopnums)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = "SELECT empdopnums, cpros, codcors, codtams," + ;
                       " SUM(qtds) AS qtds, SUM(qtdss) AS qtdss," + ;
                       " MAX(qtbaixas) AS qtbaixas, MAX(qtprods) AS qtprods," + ;
                       " MAX(qtbxprods) AS qtbxprods, 0 AS citens," + ;
                       " SUM(tpesos) AS tpesos, SUM(descvals) AS descvals" + ;
                       " FROM crSigMvItn" + ;
                       " GROUP BY empdopnums, cpros, codcors, codtams"
            SELECT &loc_cSQL INTO CURSOR crSigMvItn READWRITE

            IF !USED("xEestI")
                CREATE CURSOR xEestI (empdopnums C(29), cpros C(14), codcors C(4), ;
                    codtams C(4), qtds N(11,3), qtdss N(11,3), qtbaixas N(11,3), ;
                    qtprods N(11,3), qtbxprods N(11,3), citens N(4,0), ;
                    tpesos N(11,2), descvals N(11,2), DPros C(50), OBS M)
            ELSE
                ZAP IN xEestI
            ENDIF

            SELECT crSigMvItn
            INDEX ON EmpDopNums TAG EmpDopNums

            LOCAL loc_nI, loc_nQtds, loc_nQtdss
            FOR loc_nI = 1 TO RECCOUNT("crSigMvItn")
                GO loc_nI IN crSigMvItn
                SELECT crSigMvItn
                SCATTER MEMVAR MEMO

                IF !EMPTY(ALLTRIM(m.codtams)) OR !EMPTY(ALLTRIM(m.codcors))
                    m.qtds = m.qtdss
                ENDIF

                LOCAL loc_cSQLPro
                loc_cSQLPro = "SELECT cpros, DPros, PesoMs FROM SigCdPro" + ;
                              " WHERE cpros = " + EscaparSQL(ALLTRIM(m.cpros))
                IF SQLEXEC(gnConnHandle, loc_cSQLPro, "crSigCdPro") > 0 AND ;
                   RECCOUNT("crSigCdPro") > 0
                    m.tpesos   = crSigCdPro.PesoMs * m.qtds
                    m.descvals = (m.qtbaixas / IIF(m.qtds <> 0, m.qtds, 1)) * 100
                    m.DPros    = ALLTRIM(crSigCdPro.DPros)
                    IF USED("crSigCdPro")
                        USE IN crSigCdPro
                    ENDIF
                ENDIF

                INSERT INTO xEestI FROM MEMVAR
            ENDFOR

            *-- Linha de TOTAL
            LOCAL loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            SELECT xEestI
            SUM qtds, qtbaixas, tpesos, qtprods, qtbxprods ;
                TO loc_nTqtd, loc_nTqtdb, loc_nTpeso, loc_nTQtPrd, loc_nTQtBxprd
            APPEND BLANK IN xEestI
            SELECT xEestI
            REPLACE cpros    WITH "TOTAL ->", ;
                    qtds     WITH loc_nTqtd, ;
                    qtbaixas WITH loc_nTqtdb, ;
                    tpesos   WITH loc_nTpeso, ;
                    qtprods  WITH loc_nTQtPrd, ;
                    qtbxprods WITH loc_nTQtBxprd, ;
                    descvals WITH ((loc_nTqtdb / IIF(loc_nTqtd <> 0, loc_nTqtd, 1)) * 100)
            GO TOP IN xEestI

            *-- Index para busca por produto+tamanho
            SELECT xEestI
            INDEX ON ALLTRIM(cpros) + ALLTRIM(codtams) TAG Tamanho

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMascaraNumeracao - Busca MascNums de SigCdPam para o tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMascaraNumeracao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 MascNums FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") > 0 AND ;
               RECCOUNT("crSigCdPam") > 0
                SELECT crSigCdPam
                THIS.this_cMascnum = ALLTRIM(crSigCdPam.MascNums)
                loc_lResultado = .T.
                IF USED("crSigCdPam")
                    USE IN crSigCdPam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTipoOperacao - Busca dados de SigCdOpe para o tipo op
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTipoOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe") > 0 AND ;
               RECCOUNT("crSigCdOpe") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarSubDadosOperacao - Busca SigOpCdc para tipo de operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubDadosOperacao(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigOpCdc WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cDopes))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpCdc") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoCliente - Busca Rclis de SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoCliente(par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cDescricao
        loc_lResultado = .F.
        loc_cDescricao = ""
        TRY
            IF !EMPTY(ALLTRIM(par_cConta))
                loc_cSQL = "SELECT TOP 1 Rclis FROM SigCdCli" + ;
                           " WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCli") > 0 AND ;
                   RECCOUNT("crSigCdCli") > 0
                    loc_cDescricao = ALLTRIM(crSigCdCli.Rclis)
                    loc_lResultado = .T.
                ENDIF
                IF USED("crSigCdCli")
                    USE IN crSigCdCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.this_cDconta = loc_cDescricao
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Persiste alteracoes do csTemporario de volta ao SigMvPec
    * Atualiza apenas os campos editaveis pelo usuario neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarAtualizacao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvPec SET" + ;
                       " datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " pstatus = " + EscaparSQL(THIS.this_cPStatus) + ;
                       " WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui pedido do SigMvPec (e itens relacionados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigMvItn WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvIts WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigMvPec WHERE empdopnums = " + ;
                       EscaparSQL(THIS.this_cEmpdopnums)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigMvPec com todos os campos obrigatorios
    * cidchaves gerado como emps(3)+dopes(10)+numes(6)+segundos(1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCidchaves, loc_cEmpdopnums
        loc_lResultado = .F.
        TRY
            *-- Gerar cidchaves (char 20): emps 3 + dopes 10 + numes 6 + tick 1
            loc_cEmpdopnums = LEFT(ALLTRIM(THIS.this_cEmps) + SPACE(3), 3) + ;
                              LEFT(ALLTRIM(THIS.this_cDopes) + SPACE(20), 20) + ;
                              RIGHT("      " + ALLTRIM(STR(THIS.this_nNumes, 6)), 6)
            loc_cCidchaves  = LEFT(loc_cEmpdopnums, 19) + ;
                              RIGHT(ALLTRIM(STR(INT(SECONDS()), 1)), 1)

            THIS.this_cCidchaves  = LEFT(loc_cCidchaves, 20)
            THIS.this_cEmpdopnums = LEFT(loc_cEmpdopnums, 29)

            loc_cSQL = "INSERT INTO SigMvPec" + ;
                       " (emps, dopes, numes, codigos, datatrans, ntrans," + ;
                       "  locals, valobxs, cidchaves, empdopnums, empsubns," + ;
                       "  datas, chksubn, dtagends, chkpagos, nparcs," + ;
                       "  valps, valvars, vencps, pstatus)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValobxs) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpsubs), 3)) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       IIF(THIS.this_lChksubn, "1", "0") + "," + ;
                       FormatarDataSQL(THIS.this_dDtagends) + "," + ;
                       IIF(THIS.this_lChkpagos, "1", "0") + "," + ;
                       FormatarNumeroSQL(THIS.this_nNparcs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValvars) + "," + ;
                       FormatarDataSQL(THIS.this_dVencps) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPStatus), 1)) + ;
                       ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir pedido:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
