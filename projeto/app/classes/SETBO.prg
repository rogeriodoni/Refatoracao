*==============================================================================
* SETBO.prg
*
* Business Object para Cadastro de Setores
* Tabela principal: SigCdSet
* Tabela filha: SigCdSei (Localizacoes do Setor)
* Lookup: SigPrLcl (Localizacoes - codigo/descricao)
* Herda de: BusinessBase
*
* Colunas SigCdSet:
*   setores   char(10)  PK - Codigo do Setor
*   descrs    char(40)  Descricao do Setor
*
* Colunas SigCdSei:
*   cidchaves char(20)  PK - Chave unica
*   setores   char(10)  FK -> SigCdSet.setores
*   locals    char(10)  Codigo de Localizacao (FK -> SigPrLcl.codigos)
*==============================================================================

DEFINE CLASS SETBO AS BusinessBase

    *-- Propriedades da entidade principal (SigCdSet)
    this_cSetores = ""   && setores  char(10)  PK - Codigo do Setor
    this_cDescrs  = ""   && descrs   char(40)  Descricao do Setor

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSet"
            THIS.this_cCampoChave = "Setores"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSetores)
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cSetores        = ""
        THIS.this_cDescrs         = ""
        THIS.this_lNovoRegistro   = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSetores = TratarNulo(Setores, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT em SigCdSet para preencher cursor_4c_Dados
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " ORDER BY Setores"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Setores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo do setor
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoes - Carrega localizacoes do setor em cursor
    *   Enriquece Locals com Descricaos de SigPrLcl
    *   Resultado: cursor_4c_Localizacoes (Setores, Locals, Descricaos)
    *==========================================================================
    FUNCTION CarregarLocalizacoes(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Localizacoes")
                USE IN cursor_4c_Localizacoes
            ENDIF

            loc_cSQL = "SELECT a.Setores, a.Locals AS Locals," + ;
                       " ISNULL(b.Descricaos, SPACE(20)) AS Descricaos" + ;
                       " FROM SigCdSei a" + ;
                       " LEFT JOIN SigPrLcl b ON b.Codigos = a.Locals" + ;
                       " WHERE a.Setores = " + EscaparSQL(ALLTRIM(par_cSetores)) + ;
                       " ORDER BY a.Locals"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Localizacoes")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Localizacoes") AND RECCOUNT("cursor_4c_Localizacoes") >= 0
                    GO TOP IN cursor_4c_Localizacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar localizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoDuplicada - Verifica se Locals ja existe no setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoDuplicada(par_cLocals, par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF

            loc_cSQL = "SELECT COUNT(1) AS Qt" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocal")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLocal") > 0
                SELECT cursor_4c_VldLocal
                loc_lDuplicado = (Qt > 0)
            ENDIF

            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoDuplicada")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoOutroSetor - Verifica se Locals pertence a outro setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoOutroSetor(par_cLocals, par_cSetoresAtual)
        LOCAL loc_cSQL, loc_nResult, loc_cSetorExistente
        loc_cSetorExistente = ""
        TRY
            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores <> " + EscaparSQL(ALLTRIM(par_cSetoresAtual))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSetor")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSetor") > 0
                SELECT cursor_4c_VldSetor
                loc_cSetorExistente = ALLTRIM(Setores)
            ENDIF

            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoOutroSetor")
        ENDTRY
        RETURN loc_cSetorExistente
    ENDFUNC

    *==========================================================================
    * BuscarLocalizacao - Lookup em SigPrLcl pelo codigo
    *   Resultado: cursor_4c_BuscaLocal (Codigos, Descricaos)
    *==========================================================================
    FUNCTION BuscarLocalizacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaLocal")
                TABLEREVERT(.T., "cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLocal")

            IF loc_nResult >= 0
                IF USED("cursor_4c_BuscaLocal") AND RECCOUNT("cursor_4c_BuscaLocal") >= 0
                    GO TOP IN cursor_4c_BuscaLocal
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.BuscarLocalizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarSetorExistente - Verifica se codigo de setor ja existe
    *==========================================================================
    FUNCTION VerificarSetorExistente(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.
        TRY
            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSet")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSet") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.VerificarSetorExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * Inserir (PROTECTED) - INSERT em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdSet (Setores, Descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar (PROTECTED) - UPDATE em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdSet SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(THIS.this_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao (PROTECTED) - DELETE em SigCdSet e SigCdSei
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdSet WHERE Setores = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cSetores))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(245) + "es do Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarLocalizacoes - Sincroniza SigCdSei com cursor de localizacoes
    *   par_cSetores    - Codigo do setor
    *   par_cCursorSei  - Nome do cursor com registros a salvar (Locals, Descricaos)
    *==========================================================================
    FUNCTION SalvarLocalizacoes(par_cSetores, par_cCursorSei)
        LOCAL loc_cSQL, loc_lSucesso, loc_cLocals, loc_cIdChave
        loc_lSucesso = .F.
        TRY
            *-- Delete all existing localizations for the setor (replace-all approach)
            *-- This ensures removed/changed rows are cleaned from SigCdSei
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Insert all non-empty locals from cursor
            IF USED(par_cCursorSei) AND RECCOUNT(par_cCursorSei) > 0
                SELECT (par_cCursorSei)
                SCAN FOR !EMPTY(ALLTRIM(Locals))
                    loc_cLocals  = ALLTRIM(Locals)
                    loc_cIdChave = LOWER(SYS(2015)) + TRANSFORM(SECONDS(), "@L")
                    loc_cSQL = "INSERT INTO SigCdSei (cidchaves, Setores, Locals)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cIdChave) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cSetores)) + ", " + ;
                               EscaparSQL(loc_cLocals) + ")"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.SalvarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
