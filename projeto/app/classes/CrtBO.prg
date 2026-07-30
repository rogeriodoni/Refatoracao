*==============================================================================
* CRTBO.PRG
* Business Object para Cadastro de Retrabalhos (SigPrCrt)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CrtBO AS BusinessBase

    *-- Propriedades de dados da tabela SigPrCrt
    this_cCodigo    = ""    && cods   CHAR(6)  - Codigo do Retrabalho (PK)
    this_cDescricao = ""    && descs  CHAR(30) - Descricao
    this_nFator     = 0     && fators NUMERIC  - Fator (9999.99)
    this_nSeq       = 0     && Seqs   NUMERIC  - Sequencia/Ordem
    this_cEmpresa   = ""    && Cemps   CHAR(3)  - Empresa Padrao (FK SigCdEmp)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCrt"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_nFator     = 0
        THIS.this_nSeq       = 0
        THIS.this_cEmpresa   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFator     = TratarNulo(fators,"N")
            THIS.this_nSeq       = TratarNulo(Seqs,  "N")
            THIS.this_cEmpresa   = TratarNulo(Emps,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista retrabalhos (SELECT para o grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR Emps = ' '" + ;
                       " ORDER BY Cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar retrabalhos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                THIS.this_cMensagemErro = "Retrabalho n" + CHR(227) + "o encontrado."
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        FINALLY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCrt (Cods, Descs, Fators, Seqs, Emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFator) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeq) + ", " + ;
                       EscaparSQL(THIS.this_cEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCrt SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " Fators = " + FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       " Seqs = " + FormatarNumeroSQL(THIS.this_nSeq) + "," + ;
                       " Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigPrCrt (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio antes de Salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            LOCAL loc_lExiste, loc_nVerif
            loc_lExiste = .F.
            TRY
                loc_nVerif = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigPrCrt WHERE Cods = " + EscaparSQL(THIS.this_cCodigo), ;
                    "cursor_4c_Verif")
                IF loc_nVerif > 0 AND RECCOUNT("cursor_4c_Verif") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                    loc_lExiste = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar c" + CHR(243) + "digo: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            FINALLY
                IF USED("cursor_4c_Verif")
                    USE IN cursor_4c_Verif
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDFUNC

ENDDEFINE
