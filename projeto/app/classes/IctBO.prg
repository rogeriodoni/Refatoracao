*====================================================================
* IctBO.prg
*
* Business Object para Cadastro de Tipo de Tributa??o do ICMS
* Tabela: SigPrTri
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS IctBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTri)
    this_cCidChaves   = ""    && cidchaves char(20) - PK composta (gerada)
    this_cTipos       = ""    && tipos     char(4)
    this_cDescs       = ""    && descs     char(20)
    this_cCfops       = ""    && cfops     char(10)
    this_cOrigems     = ""    && origems   char(2)
    this_cDestinos    = ""    && destinos  char(2)
    this_cMovs        = ""    && movs      char(1)
    this_nAliquotas   = 0     && aliquotas numeric(5,2)
    this_nBases       = 0     && bases     numeric(5,2)
    this_nReduzidas   = 0     && reduzidas numeric(5,2)
    this_nAliqicmsts  = 0     && aliqicmsts numeric(5,2) - Aliq. Substitui??o

    *-- Propriedades auxiliares de exibi??o (vem de JOINs, n?o s?o colunas de SigPrTri)
    this_cOrigemd     = ""    && SigCdUfs.Descrs para Origems (display)
    this_cDestinoD    = ""    && SigCdUfs.Descrs para Destinos (display)
    this_cCfopd       = ""    && SigCdCfo.Descricaos para Cfops (display)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTri"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message, "IctBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * cidchaves = tipos(4) + cfops(10) + movs(1) + origems(2) + "/" + destinos(2) = 20 chars
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * GerarCidChaves - Computa a PK composta a partir dos campos-chave
    *====================================================================
    PROTECTED FUNCTION GerarCidChaves()
        RETURN PADR(ALLTRIM(THIS.this_cTipos),  4) + ;
               PADR(ALLTRIM(THIS.this_cCfops), 10) + ;
               LEFT(ALLTRIM(THIS.this_cMovs) + " ", 1) + ;
               PADR(ALLTRIM(THIS.this_cOrigems), 2) + ;
               "/" + ;
               PADR(ALLTRIM(THIS.this_cDestinos), 2)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,   "C")
                THIS.this_cTipos      = TratarNulo(Tipos,       "C")
                THIS.this_cDescs      = TratarNulo(Descs,       "C")
                THIS.this_cCfops      = TratarNulo(CFOPs,       "C")
                THIS.this_cOrigems    = TratarNulo(Origems,     "C")
                THIS.this_cDestinos   = TratarNulo(Destinos,    "C")
                THIS.this_cMovs       = TratarNulo(Movs,        "C")
                THIS.this_nAliquotas  = TratarNulo(Aliquotas,   "N")
                THIS.this_nBases      = TratarNulo(Bases,       "N")
                THIS.this_nReduzidas  = TratarNulo(Reduzidas,   "N")
                THIS.this_nAliqicmsts = TratarNulo(aliqicmsts,  "N")
                IF FCOUNT() > 11
                    THIS.this_cOrigemd  = TratarNulo(Origemd,   "C")
                    THIS.this_cDestinoD = TratarNulo(Destinod,  "C")
                    THIS.this_cCfopd    = TratarNulo(CFOPd,     "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "IctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cTipos))
            MsgAviso("Tipo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCfops))
            MsgAviso("C.F.O.P. obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cMovs))
            MsgAviso("Tipo de Movimento obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ELSE
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cMovs)), "E", "S")
            MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido. Use E=Entrada ou S=Sa" + CHR(237) + "da.")
            loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - Busca registros na tabela SigPrTri com JOINs de display
    * par_cFiltro: condicao SQL sem WHERE (vazio = todos)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), Tipos C(4), ;
                        Descs C(20), CFOPs C(10), Origems C(2), Destinos C(2), ;
                        Movs C(1), Aliquotas N(5,2), Bases N(5,2), Reduzidas N(5,2), ;
                        aliqicmsts N(5,2), Origemd C(50), Destinod C(50), CFOPd C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                    " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                    " a.Reduzidas, a.aliqicmsts," + ;
                    " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                    " FROM SigPrTri a" + ;
                    " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                    " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                    " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Tipos, a.CFOPs, a.Movs, a.Origems, a.Destinos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "IctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                " a.Reduzidas, a.aliqicmsts," + ;
                " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                " FROM SigPrTri a" + ;
                " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos" + ;
                " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

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
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "IctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarCidChaves()

            loc_cSQL = "INSERT INTO SigPrTri" + ;
                " (cidchaves, Tipos, Descs, CFOPs, Origems, Destinos," + ;
                " Movs, Aliquotas, Bases, Reduzidas, aliqicmsts)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cTipos)     + ", " + ;
                EscaparSQL(THIS.this_cDescs)     + ", " + ;
                EscaparSQL(THIS.this_cCfops)     + ", " + ;
                EscaparSQL(THIS.this_cOrigems)   + ", " + ;
                EscaparSQL(THIS.this_cDestinos)  + ", " + ;
                EscaparSQL(THIS.this_cMovs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "IctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrTri (PROTECTED)
    * Apenas campos editaveis em modo ALTERAR (nao atualiza chave composta)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrTri SET" + ;
                " Descs = "      + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                " Aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                " Bases = "      + FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                " Reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                " aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "IctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTri WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "IctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
