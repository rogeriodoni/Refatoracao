*====================================================================
* PATBO.prg
*
* Business Object para Pedido de Atendimento
* Tabela: SigCdPat
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS PATBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento SigCdPat)
    this_cPkchaves  = ""    && pkchaves char(20) - PK
    this_cEmps      = ""    && emps char(3) - empresa
    this_tDatas     = {}    && datas datetime
    this_cCodvends  = ""    && codvends char(10) - codigo do cliente/vendedor
    this_cClientes  = ""    && clientes char(50) - nome do cliente
    this_cPerguntas = ""    && perguntas text - intencao/observacoes
    this_nVendconcs = 2     && vendconcs numeric(1,0) - 1=Sim 2=Nao

    *====================================================================
    * Init - Inicializa BO
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela    = "SigCdPat"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro livre (WHERE clause)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT pkchaves, emps, datas, codvends, clientes, perguntas, vendconcs " + ;
                       "FROM SigCdPat"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF RECCOUNT("cursor_4c_DadosTemp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao buscar dados: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PATBO.Buscar")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PATBO.Buscar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor ativo
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            THIS.this_cPkchaves  = ALLTRIM(pkchaves)
            THIS.this_cEmps      = ALLTRIM(emps)
            THIS.this_tDatas     = IIF(ISNULL(datas), {}, datas)
            THIS.this_cCodvends  = ALLTRIM(codvends)
            THIS.this_cClientes  = ALLTRIM(clientes)
            THIS.this_cPerguntas = IIF(ISNULL(perguntas), "", ALLTRIM(perguntas))
            THIS.this_nVendconcs = IIF(ISNULL(vendconcs), 2, vendconcs)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "PATBO.CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir (PROTECTED) - INSERT INTO SigCdPat
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPk, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cPk = LEFT(SYS(2015) + SYS(2015), 20)
            THIS.this_cPkchaves = loc_cPk

            loc_cSQL = "INSERT INTO SigCdPat " + ;
                "(pkchaves, emps, datas, codvends, clientes, perguntas, vendconcs) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cPk) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                FormatarDataSQL(THIS.this_tDatas) + ", " + ;
                EscaparSQL(THIS.this_cCodvends) + ", " + ;
                EscaparSQL(THIS.this_cClientes) + ", " + ;
                EscaparSQL(THIS.this_cPerguntas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVendconcs, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao inserir: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PATBO.Inserir")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PATBO.Inserir")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar (PROTECTED) - UPDATE SigCdPat
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPat SET " + ;
                "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                "datas = " + FormatarDataSQL(THIS.this_tDatas) + ", " + ;
                "codvends = " + EscaparSQL(THIS.this_cCodvends) + ", " + ;
                "clientes = " + EscaparSQL(THIS.this_cClientes) + ", " + ;
                "perguntas = " + EscaparSQL(THIS.this_cPerguntas) + ", " + ;
                "vendconcs = " + FormatarNumeroSQL(THIS.this_nVendconcs, 0) + ;
                " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PATBO.Atualizar")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PATBO.Atualizar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao (PROTECTED) - DELETE FROM SigCdPat
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPat WHERE pkchaves = " + ;
                EscaparSQL(THIS.this_cPkchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao excluir: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PATBO.ExecutarExclusao")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "PATBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescEmpresa - Retorna razas de SigCdEmp dado cemps
    *====================================================================
    PROCEDURE BuscarDescEmpresa(par_cEmps)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(par_cEmps), ;
                "cursor_4c_DescEmp")
            IF loc_nResult > 0 AND USED("cursor_4c_DescEmp") AND !EMPTY(cursor_4c_DescEmp.razas)
                loc_cDesc = ALLTRIM(cursor_4c_DescEmp.razas)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PATBO.BuscarDescEmpresa")
        ENDTRY
        IF USED("cursor_4c_DescEmp")
            USE IN cursor_4c_DescEmp
        ENDIF
        RETURN loc_cDesc
    ENDPROC

    *====================================================================
    * BuscarDescVendedor - Retorna rclis de SigCdCli dado iclis=codvends
    *====================================================================
    PROCEDURE BuscarDescVendedor(par_cCodvends)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(par_cCodvends), ;
                "cursor_4c_DescVend")
            IF loc_nResult > 0 AND USED("cursor_4c_DescVend") AND !EMPTY(cursor_4c_DescVend.rclis)
                loc_cDesc = ALLTRIM(cursor_4c_DescVend.rclis)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PATBO.BuscarDescVendedor")
        ENDTRY
        IF USED("cursor_4c_DescVend")
            USE IN cursor_4c_DescVend
        ENDIF
        RETURN loc_cDesc
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkchaves
    ENDPROC

ENDDEFINE
