*====================================================================
* UfdBO.prg
*
* Business Object para Cadastro de ICMS Interestadual (UF x UF)
* Tabela: SigCdUfd
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UfdBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUfd)
    this_cChave              = ""    && cidchaves char(20) - PK
    this_cUfOrigem           = ""    && codigos char(2)
    this_cUfDestino          = ""    && destinos char(2)
    this_nAliqIcms           = 0     && aliqs numeric(5,2)
    this_cCfop               = ""    && cfos char(10)
    this_nAliqSubTrib        = 0     && aliqsbs numeric(9,2)
    this_nAliqInterestadual  = 0     && aliqsb2s numeric(9,2)
    this_nAliqIcmsPImp       = 0     && aliqpimps numeric(4,2)
    this_nAliqFcp            = 0     && aliqfcp numeric(5,3)
    this_nAliqRedBase        = 0     && aliqredb numeric(6,3)
    this_cIeSubstituto       = ""    && iest char(20)
    this_nBaseReduzida       = 0     && nbaseres numeric(1,0)
    this_nChkIcms            = 0     && chkicms numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfd"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "UfdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChave             = TratarNulo(cidchaves, "C")
                THIS.this_cUfOrigem          = TratarNulo(codigos,   "C")
                THIS.this_cUfDestino         = TratarNulo(destinos,  "C")
                THIS.this_nAliqIcms          = TratarNulo(aliqs,     "N")
                THIS.this_cCfop              = TratarNulo(cfos,      "C")
                THIS.this_nAliqSubTrib       = TratarNulo(aliqsbs,   "N")
                THIS.this_nAliqInterestadual = TratarNulo(aliqsb2s,  "N")
                THIS.this_nAliqIcmsPImp      = TratarNulo(aliqpimps, "N")
                THIS.this_nAliqFcp           = TratarNulo(aliqfcp,   "N")
                THIS.this_nAliqRedBase       = TratarNulo(aliqredb,  "N")
                THIS.this_cIeSubstituto      = TratarNulo(iest,      "C")
                THIS.this_nBaseReduzida      = TratarNulo(nbaseres,  "N")
                THIS.this_nChkIcms           = TratarNulo(chkicms,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChave)
                THIS.this_cChave = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUfd (cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    <<EscaparSQL(THIS.this_cUfDestino)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    <<EscaparSQL(THIS.this_cCfop)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUfd
                SET codigos   = <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    destinos  = <<EscaparSQL(THIS.this_cUfDestino)>>,
                    aliqs     = <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    cfos      = <<EscaparSQL(THIS.this_cCfop)>>,
                    aliqsbs   = <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    aliqsb2s  = <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    aliqpimps = <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    aliqfcp   = <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    aliqredb  = <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    iest      = <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    nbaseres  = <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    chkicms   = <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cidchaves (chave oculta p/ Alterar/Excluir)
    * + as 8 colunas exibidas na grade da lista (pColuna do legado)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(2), destinos C(2), ;
                        aliqs N(5,2), aliqsbs N(9,2), aliqpimps N(4,2), aliqfcp N(5,3), ;
                        aliqredb N(6,3), iest C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigos, destinos, aliqs, aliqsbs," + ;
                    " aliqpimps, aliqfcp, aliqredb, iest FROM SigCdUfd"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos, destinos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms
                FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de ICMS Interestadual n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUfd
    * Chamado internamente por BusinessBase.Excluir() (PROTECTED - regra CLAUDE.md)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir ICMS Interestadual:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "UfdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
