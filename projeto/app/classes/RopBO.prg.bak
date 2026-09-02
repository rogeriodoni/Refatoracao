*==============================================================================
* RopBO.prg
*
* Business Object para Cadastro de Restricoes Por Operacao
* Tabela: SigCdRpo
* Herda de: BusinessBase
*
* Colunas da tabela SigCdRpo:
*   cidchaves  char(20)    PK - Chave unica gerada via NEWID
*   cgrus      char(3)     Grupo de Produto
*   dopps      char(20)    Operacao de Producao
*   doptpgrus  char(48)    Composto: Dopp+TpOp+Cgru+Mercs+Grupos
*   tpops      char(15)    Tipo de Material/Operacao
*   mercs      char(3)     Grande Grupo
*   opers      char(1)     Operacao Estoque (E/S)
*   grupos     char(10)    Grupo de Conta Contabil
*   exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
*   contas     char(10)    Conta Destino
*   codcors    char(4)     Codigo da Cor
*   contaorig  char(10)    Conta Origem
*==============================================================================

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdRpo)
    this_cCidChaves  = ""   && cidchaves  char(20)    PK
    this_cCgrus      = ""   && cgrus      char(3)     Grupo de Produto
    this_cDopps      = ""   && dopps      char(20)    Operacao
    this_cDoptpgrus  = ""   && doptpgrus  char(48)    Composto (auto-gerado)
    this_cTpops      = ""   && tpops      char(15)    Tipo de Material
    this_cMercs      = ""   && mercs      char(3)     Grande Grupo
    this_cOpers      = ""   && opers      char(1)     Op.Estoque E/S
    this_cGrupos     = ""   && grupos     char(10)    Grupo Conta
    this_nExclus     = 2    && exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
    this_cContas     = ""   && contas     char(10)    Conta Destino
    this_cCodcors    = ""   && codcors    char(4)     Cor
    this_cContaorig  = ""   && contaorig  char(10)    Conta Origem

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCgrus      = TratarNulo(cgrus,      "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_cDoptpgrus  = TratarNulo(doptpgrus,  "C")
                THIS.this_cTpops      = TratarNulo(tpops,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cOpers      = TratarNulo(opers,      "C")
                THIS.this_cGrupos     = TratarNulo(grupos,     "C")
                THIS.this_nExclus     = TratarNulo(exclus,     "N")
                THIS.this_cContas     = TratarNulo(contas,     "C")
                THIS.this_cCodcors    = TratarNulo(codcors,    "C")
                THIS.this_cContaorig  = TratarNulo(contaorig,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves  = ""
        THIS.this_cCgrus      = ""
        THIS.this_cDopps      = ""
        THIS.this_cDoptpgrus  = ""
        THIS.this_cTpops      = ""
        THIS.this_cMercs      = ""
        THIS.this_cOpers      = ""
        THIS.this_cGrupos     = ""
        THIS.this_nExclus     = 2
        THIS.this_cContas     = ""
        THIS.this_cCodcors    = ""
        THIS.this_cContaorig  = ""
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(THIS.this_cTpops) AND EMPTY(THIS.this_cCgrus) AND ;
               EMPTY(THIS.this_cMercs) AND EMPTY(THIS.this_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo de Material Ou " + ;
                    "Grupo de Produto Ou Grande Grupo Ou Grupo Conta")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite Apenas [E] ou [S] ou [ ] !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Restri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica restricao ja cadastrada com mesmos campos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRpo" + ;
                " WHERE Dopps    = " + EscaparSQL(THIS.this_cDopps) + ;
                " AND   TpOps    = " + EscaparSQL(THIS.this_cTpops) + ;
                " AND   CGrus    = " + EscaparSQL(THIS.this_cCgrus) + ;
                " AND   Mercs    = " + EscaparSQL(THIS.this_cMercs) + ;
                " AND   Grupos   = " + EscaparSQL(THIS.this_cGrupos) + ;
                " AND   Contas   = " + EscaparSQL(THIS.this_cContas) + ;
                " AND   ContaOrig= " + EscaparSQL(THIS.this_cContaorig) + ;
                " AND   CodCors  = " + EscaparSQL(THIS.this_cCodcors)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RopBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult, loc_cSQL
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RopBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RopBO.Inserir")
            ELSE
                THIS.this_cDoptpgrus = LEFT( ;
                    ALLTRIM(THIS.this_cDopps)  + ;
                    ALLTRIM(THIS.this_cTpops)  + ;
                    ALLTRIM(THIS.this_cCgrus)  + ;
                    ALLTRIM(THIS.this_cMercs)  + ;
                    ALLTRIM(THIS.this_cGrupos) + ;
                    SPACE(48), 48)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdRpo (
                        cidchaves, cgrus, dopps, doptpgrus, tpops,
                        mercs, opers, grupos, exclus, contas, codcors, contaorig
                    ) VALUES (
                        <<EscaparSQL(THIS.this_cCidChaves)>>,
                        <<EscaparSQL(THIS.this_cCgrus)>>,
                        <<EscaparSQL(THIS.this_cDopps)>>,
                        <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                        <<EscaparSQL(THIS.this_cTpops)>>,
                        <<EscaparSQL(THIS.this_cMercs)>>,
                        <<EscaparSQL(THIS.this_cOpers)>>,
                        <<EscaparSQL(THIS.this_cGrupos)>>,
                        <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                        <<EscaparSQL(THIS.this_cContas)>>,
                        <<EscaparSQL(THIS.this_cCodcors)>>,
                        <<EscaparSQL(THIS.this_cContaorig)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDoptpgrus = LEFT( ;
                ALLTRIM(THIS.this_cDopps)  + ;
                ALLTRIM(THIS.this_cTpops)  + ;
                ALLTRIM(THIS.this_cCgrus)  + ;
                ALLTRIM(THIS.this_cMercs)  + ;
                ALLTRIM(THIS.this_cGrupos) + ;
                SPACE(48), 48)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdRpo SET
                    cgrus      = <<EscaparSQL(THIS.this_cCgrus)>>,
                    dopps      = <<EscaparSQL(THIS.this_cDopps)>>,
                    doptpgrus  = <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                    tpops      = <<EscaparSQL(THIS.this_cTpops)>>,
                    mercs      = <<EscaparSQL(THIS.this_cMercs)>>,
                    opers      = <<EscaparSQL(THIS.this_cOpers)>>,
                    grupos     = <<EscaparSQL(THIS.this_cGrupos)>>,
                    exclus     = <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodcors)>>,
                    contaorig  = <<EscaparSQL(THIS.this_cContaorig)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas para o grid (ordem identica ao legado)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        dopps     C(20), ;
                        tpops     C(15), ;
                        cgrus     C(3),  ;
                        opers     C(1),  ;
                        mercs     C(3),  ;
                        grupos    C(10), ;
                        contas    C(10), ;
                        contaorig C(10), ;
                        codcors   C(4),  ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT dopps, tpops, cgrus, opers, mercs," + ;
                    " grupos, contas, contaorig, codcors, cidchaves" + ;
                    " FROM SigCdRpo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dopps, tpops, cgrus"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cgrus, dopps, doptpgrus, tpops," + ;
                " mercs, opers, grupos, exclus, contas, codcors, contaorig" + ;
                " FROM SigCdRpo WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
