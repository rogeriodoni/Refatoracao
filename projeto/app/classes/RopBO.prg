*==============================================================================
* RopBO.prg - Business Object para Restricoes Por Operacao
* Tabela principal: SigCdRpo
* PK: cIdChaves (CHAR, gerada por fUniqueIds())
* Task: task502
* Herda de: BusinessBase
*==============================================================================

SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da tabela SigCdRpo
    this_cIdChaves   = ""   && cIdChaves CHAR(PK) - Chave prim" + CHR(225) + "ria
    this_cDopps      = ""   && Dopps     CHAR(20) - Opera" + CHR(231) + CHR(227) + "o
    this_cTpOps      = ""   && TpOps     CHAR    - Tipo de Movimenta" + CHR(231) + CHR(227) + "o
    this_cCgrus      = ""   && Cgrus     CHAR(3) - Grupo de Produto
    this_cOpers      = ""   && Opers     CHAR(1) - Opera" + CHR(231) + CHR(227) + "o Estoque (E/S)
    this_cMercs      = ""   && mercs     CHAR(3) - Grande Grupo
    this_cGrupos     = ""   && Grupos    CHAR(10)- Grupo Contab
    this_cContas     = ""   && Contas    CHAR(10)- Conta Destino
    this_cContaOrig  = ""   && ContaOrig CHAR(10)- Conta Origem
    this_cCodCors    = ""   && CodCors   CHAR(4) - Cor
    this_nExclus     = 2    && Exclus    NUMERIC - 1=Sim, 2=N" + CHR(227) + "o (default 2)
    this_cDopTpGrus  = ""   && DopTpGrus CHAR - campo computado

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT SigCdRpo com filtro opcional (sem a palavra WHERE)
    * Popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Dopps, TpOps, Cgrus, Opers, mercs, Grupos," + ;
                       " Contas, ContaOrig, CodCors, Exclus, DopTpGrus" + ;
                       " FROM SigCdRpo"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Dopps, TpOps, Cgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cIdChaves, Dopps, TpOps, Cgrus, Opers, mercs, Grupos," + ;
                       " Contas, ContaOrig, CodCors, Exclus, DopTpGrus" + ;
                       " FROM SigCdRpo" + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar registro:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves   = TratarNulo(cIdChaves,  "C")
                THIS.this_cDopps      = TratarNulo(Dopps,      "C")
                THIS.this_cTpOps      = TratarNulo(TpOps,      "C")
                THIS.this_cCgrus      = TratarNulo(Cgrus,      "C")
                THIS.this_cOpers      = TratarNulo(Opers,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cContaOrig  = TratarNulo(ContaOrig,  "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_nExclus     = TratarNulo(Exclus,     "N")
                THIS.this_cDopTpGrus  = TratarNulo(DopTpGrus,  "C")
                *-- Garantir valor padrao para Exclus se vier zerado
                IF THIS.this_nExclus = 0
                    THIS.this_nExclus = 2
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar cursor:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta todas as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cIdChaves   = ""
        THIS.this_cDopps      = ""
        THIS.this_cTpOps      = ""
        THIS.this_cCgrus      = ""
        THIS.this_cOpers      = ""
        THIS.this_cMercs      = ""
        THIS.this_cGrupos     = ""
        THIS.this_cContas     = ""
        THIS.this_cContaOrig  = ""
        THIS.this_cCodCors    = ""
        THIS.this_nExclus     = 2
        THIS.this_cDopTpGrus  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Define defaults para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_nExclus = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Regras do legado (Salva.Click):
    *   1. Dopps obrigatorio
    *   2. Pelo menos um de: TpOps, Cgrus, mercs, Grupos
    *   3. Opers deve ser vazio, E ou S
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cDopps))
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o (Opera" + CHR(231) + CHR(227) + "o) " + ;
                     CHR(233) + " obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cTpOps)) AND ;
               EMPTY(ALLTRIM(THIS.this_cCgrus)) AND ;
               EMPTY(ALLTRIM(THIS.this_cMercs)) AND ;
               EMPTY(ALLTRIM(THIS.this_cGrupos))
                MsgAviso("Informe pelo menos um dos campos:" + CHR(13) + ;
                         "Tipo de Material, Grupo de Produto, Grande Grupo ou Grupo Contab.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o Estoque inv" + CHR(225) + "lida!" + CHR(13) + ;
                         "Use E (Entrada), S (Sa" + CHR(237) + "da) ou deixe em branco.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * AntesDeGravar - Verifica duplicata antes de gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AntesDeGravar()
        LOCAL loc_lPode
        loc_lPode = .T.

        IF THIS.VerificarDuplicata()
            MsgAviso("J" + CHR(225) + " existe um registro com esta combina" + CHR(231) + CHR(227) + "o de campos!" + CHR(13) + ;
                     "Opera" + CHR(231) + CHR(227) + "o cancelada.")
            loc_lPode = .F.
        ENDIF

        RETURN loc_lPode
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicata - Verifica se ja existe registro com mesma combinacao
    * de 9 campos (excluindo o cIdChaves corrente em updates)
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata, loc_nQtd
        loc_lDuplicata = .F.
        loc_nQtd       = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdRpo" + ;
                       " WHERE Dopps      = " + EscaparSQL(THIS.this_cDopps)    + ;
                       "   AND TpOps      = " + EscaparSQL(THIS.this_cTpOps)    + ;
                       "   AND Cgrus      = " + EscaparSQL(THIS.this_cCgrus)    + ;
                       "   AND Opers      = " + EscaparSQL(THIS.this_cOpers)    + ;
                       "   AND mercs      = " + EscaparSQL(THIS.this_cMercs)    + ;
                       "   AND Grupos     = " + EscaparSQL(THIS.this_cGrupos)   + ;
                       "   AND Contas     = " + EscaparSQL(THIS.this_cContas)   + ;
                       "   AND ContaOrig  = " + EscaparSQL(THIS.this_cContaOrig)+ ;
                       "   AND CodCors    = " + EscaparSQL(THIS.this_cCodCors)

            IF !THIS.this_lNovoRegistro AND !EMPTY(ALLTRIM(THIS.this_cIdChaves))
                loc_cSQL = loc_cSQL + ;
                           "   AND cIdChaves <> " + EscaparSQL(THIS.this_cIdChaves)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_nQtd = cursor_4c_ChkDup.qtd
                USE IN cursor_4c_ChkDup
                loc_lDuplicata = (loc_nQtd > 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicata:" + CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.VerificarDuplicata")
        ENDTRY

        RETURN loc_lDuplicata
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdRpo
    * Gera cIdChaves via fUniqueIds(), computa DopTpGrus antes do INSERT
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIdChaves = fUniqueIds()

            THIS.this_cDopTpGrus = ALLTRIM(THIS.this_cDopps) + ;
                                   ALLTRIM(THIS.this_cTpOps) + ;
                                   ALLTRIM(THIS.this_cCgrus) + ;
                                   ALLTRIM(THIS.this_cMercs) + ;
                                   ALLTRIM(THIS.this_cGrupos)

            loc_cSQL = "INSERT INTO SigCdRpo" + ;
                       " (cIdChaves, Dopps, TpOps, Cgrus, Opers, mercs, Grupos," + ;
                       "  Contas, ContaOrig, CodCors, Exclus, DopTpGrus)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)   + ", " + ;
                       EscaparSQL(THIS.this_cDopps)      + ", " + ;
                       EscaparSQL(THIS.this_cTpOps)      + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)      + ", " + ;
                       EscaparSQL(UPPER(ALLTRIM(THIS.this_cOpers))) + ", " + ;
                       EscaparSQL(THIS.this_cMercs)      + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                       EscaparSQL(THIS.this_cContas)     + ", " + ;
                       EscaparSQL(THIS.this_cContaOrig)  + ", " + ;
                       EscaparSQL(THIS.this_cCodCors)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nExclus, 0) + ", " + ;
                       EscaparSQL(THIS.this_cDopTpGrus)  + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRpo WHERE cIdChaves
    * Computa DopTpGrus antes do UPDATE
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDopTpGrus = ALLTRIM(THIS.this_cDopps) + ;
                                   ALLTRIM(THIS.this_cTpOps) + ;
                                   ALLTRIM(THIS.this_cCgrus) + ;
                                   ALLTRIM(THIS.this_cMercs) + ;
                                   ALLTRIM(THIS.this_cGrupos)

            loc_cSQL = "UPDATE SigCdRpo SET" + ;
                       " Dopps      = " + EscaparSQL(THIS.this_cDopps)      + ", " + ;
                       " TpOps      = " + EscaparSQL(THIS.this_cTpOps)      + ", " + ;
                       " Cgrus      = " + EscaparSQL(THIS.this_cCgrus)      + ", " + ;
                       " Opers      = " + EscaparSQL(UPPER(ALLTRIM(THIS.this_cOpers))) + ", " + ;
                       " mercs      = " + EscaparSQL(THIS.this_cMercs)      + ", " + ;
                       " Grupos     = " + EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                       " Contas     = " + EscaparSQL(THIS.this_cContas)     + ", " + ;
                       " ContaOrig  = " + EscaparSQL(THIS.this_cContaOrig)  + ", " + ;
                       " CodCors    = " + EscaparSQL(THIS.this_cCodCors)    + ", " + ;
                       " Exclus     = " + FormatarNumeroSQL(THIS.this_nExclus, 0) + ", " + ;
                       " DopTpGrus  = " + EscaparSQL(THIS.this_cDopTpGrus)  + ;
                       " WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigCdRpo WHERE cIdChaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir Restri" + CHR(231) + CHR(227) + "o Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
