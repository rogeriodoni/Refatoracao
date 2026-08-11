*==============================================================================
* EspBO.prg - Business Object para Cadastro de Especies
* Tabela: SigCdEsp
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS EspBO AS BusinessBase

    *-- Propriedades de configuracao da tabela
    this_cTabela      = "SigCdEsp"
    this_cCampoChave  = "especies"

    *-- Propriedades de dados (mapeiam colunas de SigCdEsp)
    this_cEspecies    = ""    && char(6) - PK
    this_cDescs       = ""    && char(40)
    this_nProvs       = 1     && numeric(1,0) - 1=Com Provisao, 2=Sem Provisao
    this_nObrigs      = 1     && numeric(1,0) - 1=Sim, 2=Nao

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEsp"
        THIS.this_cCampoChave = "especies"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEspecies
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEspecies = TratarNulo(especies, "C")
            THIS.this_cDescs    = TratarNulo(descs,    "C")
            THIS.this_nProvs    = TratarNulo(provs,    "N")
            THIS.this_nObrigs   = TratarNulo(obrigs,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " ORDER BY especies"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                           " FROM SigCdEsp" + ;
                           " WHERE especies LIKE " + EscaparSQL(par_cFiltro + "%") + ;
                           " ORDER BY especies"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar esp" + CHR(233) + "cies:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo da especie
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT especies, descs, provs, obrigs" + ;
                       " FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdEsp (especies, descs, provs, obrigs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEspecies) + ", " + ;
                       EscaparSQL(THIS.this_cDescs)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nProvs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nObrigs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdEsp (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdEsp SET" + ;
                       " descs  = " + EscaparSQL(THIS.this_cDescs)          + ", " + ;
                       " provs  = " + FormatarNumeroSQL(THIS.this_nProvs)   + ", " + ;
                       " obrigs = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar esp" + CHR(233) + "cie:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdEsp (PROTECTED - chamado por Excluir)
    * Valida uso em SigMvCcr (EspecieNfs) e SigCdOpe (Especies) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Verificar uso em SigMvCcr
            loc_cSQL = "SELECT TOP 1 cIdChaves FROM SigMvCcr" + ;
                       " WHERE EspecieNfs = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCcr")
                TABLEREVERT(.T., "cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCcr")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCcr") > 0
                MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Nos T" + ;
                         CHR(237) + "tulos e N" + CHR(227) + "o Pode Ser Exclu" + ;
                         CHR(237) + "da!!!", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Verificar uso em SigCdOpe
                loc_cSQL = "SELECT TOP 1 Dopes FROM SigCdOpe" + ;
                           " WHERE Especies = " + EscaparSQL(THIS.this_cEspecies)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkOpe")
                    TABLEREVERT(.T., "cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpe")

                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkOpe") > 0
                    SELECT cursor_4c_ChkOpe
                    GO TOP
                    MsgAviso("A Esp" + CHR(233) + "cie Est" + CHR(225) + " Em Uso Na Opera" + ;
                             CHR(231) + CHR(227) + "o " + CHR(34) + ;
                             ALLTRIM(cursor_4c_ChkOpe.Dopes) + CHR(34) + ;
                             " e N" + CHR(227) + "o Pode Ser Exclu" + CHR(237) + "da!!!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    *-- Sem dependencias - executar exclusao
                    loc_cSQL = "DELETE FROM SigCdEsp" + ;
                               " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado > 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir esp" + CHR(233) + "cie:" + CHR(13) + ;
                                CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ChkOpe")
                    USE IN cursor_4c_ChkOpe
                ENDIF
            ENDIF

            IF USED("cursor_4c_ChkMvCcr")
                USE IN cursor_4c_ChkMvCcr
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    FUNCTION Validar()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        IF EMPTY(ALLTRIM(THIS.this_cEspecies))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDescs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND THIS.this_nProvs = 0
            MsgAviso("Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + ;
                     "bil Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 especies FROM SigCdEsp" + ;
                       " WHERE especies = " + EscaparSQL(THIS.this_cEspecies)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
                loc_lExiste = .T.
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE
