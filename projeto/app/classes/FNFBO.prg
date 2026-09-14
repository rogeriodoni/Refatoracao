*==============================================================================
* FNFBO.prg - Business Object para Finalizadoras n" + CHR(227) + "o Fiscal
* Tabela: SIGFINTB
* PK: cidchaves (char 20 - gerado via NEWID SQL Server)
*==============================================================================
DEFINE CLASS FNFBO AS BusinessBase

    *-- Propriedades herdadas (sobrescrever em Init)
    this_cTabela      = "SIGFINTB"
    this_cCampoChave  = "cidchaves"

    *-- Campos de SIGFINTB
    this_cCidChaves   = ""   && char(20) PK
    this_cImps        = ""   && char(20) Impressora
    this_nOrdems      = 0    && numeric(2,0) Ordem
    this_cOpernf      = ""   && char(2) Cod.Opera" + CHR(231) + CHR(227) + "o NF
    this_cOpernf2     = ""   && char(2) Cod.Abertura (s" + CHR(243) + " SWEDA/NSWEDA)
    this_cDescrs      = ""   && char(50) Descri" + CHR(231) + CHR(227) + "o
    this_nNfixos         = 0    && numeric(1,0) Fixo: 1=Sim 0=N" + CHR(227) + "o
    this_cImpsOriginal   = ""   && imps carregado do BD (antes de edicao)
    this_nOrdemsOriginal = 0    && ordems carregado do BD (antes de edicao)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGFINTB"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista finalizadoras n" + CHR(227) + "o fiscais
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega finalizadora por Impressora+Ordem (chave natural)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.opernf, a.opernf2," + ;
                       " a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves      = TratarNulo(cidchaves, "C")
            THIS.this_cImps           = TratarNulo(imps,      "C")
            THIS.this_nOrdems         = TratarNulo(ordems,    "N")
            THIS.this_cImpsOriginal   = THIS.this_cImps
            THIS.this_nOrdemsOriginal = THIS.this_nOrdems
            THIS.this_cOpernf         = TratarNulo(opernf,    "C")
            THIS.this_cOpernf2        = TratarNulo(opernf2,   "C")
            THIS.this_cDescrs         = TratarNulo(descrs,    "C")
            THIS.this_nNfixos         = TratarNulo(nfixos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidade - Verifica se Impressora+Ordem j" + CHR(225) + " existe
    * Retorna .T. se combinacao esta disponivel (sem duplicata)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarUnicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDisponivel
        loc_lDisponivel = .T.

        *-- Se editando sem alterar chave composta, nao ha conflito de unicidade
        IF !THIS.this_lNovoRegistro AND ;
           ALLTRIM(THIS.this_cImps) = ALLTRIM(THIS.this_cImpsOriginal) AND ;
           THIS.this_nOrdems = THIS.this_nOrdemsOriginal
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS cnt FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Unic")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Unic") > 0
                SELECT cursor_4c_Unic
                IF cursor_4c_Unic.cnt > 0
                    MsgAviso("Impressora / Ordem j" + CHR(225) + " cadastrada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lDisponivel = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar chave unica via NEWID do SQL Server
            THIS.this_cCidChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGFINTB" + ;
                           " (cidchaves, imps, ordems, opernf, opernf2, descrs, nfixos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cImps) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                           EscaparSQL(THIS.this_cDescrs) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNfixos) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem (excluindo registro atual) ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SIGFINTB SET" + ;
                       " imps = " + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " opernf = " + EscaparSQL(THIS.this_cOpernf) + ", " + ;
                       " opernf2 = " + EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = " + FormatarNumeroSQL(THIS.this_nNfixos) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da finalizadora por chave natural imps+ordems
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
