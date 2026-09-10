*====================================================================
* TpcBO.prg
*
* Business Object para Cadastro de Tipos de Composicao
* Tabela principal : SigCdTpc  (tipos, descrs, custos, nchkimps, nchkmais, nordems, usarpas)
* Tabela de detalhe: SigCdCom  (cidchaves PK, tipos FK, cgrus) - grupos vinculados ao tipo
*   A descricao do grupo (dgrus) vem de SigCdGrp via JOIN - SigCdCom nao tem coluna de descricao.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpcBO AS BusinessBase

    *-- Propriedades da entidade principal (mapeamento para tabela SigCdTpc)
    this_cTipo                   = ""    && tipos    char(20) - PK
    this_cDescricao               = ""    && descrs   char(40)
    this_nCalculaCustos           = 0     && custos   numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nImprimir                = 0     && nchkimps numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nMaiusculos               = 0     && nchkmais numeric(1,0) - OptionGroup (1=Sim/2=Nao)
    this_nOrdemImpressao           = 0     && nordems  numeric(2,0)
    this_nUtilizaProdutoAcabado    = 0     && usarpas  numeric(1,0) - OptionGroup (1=Sim/2=Nao)

    *-- Propriedade auxiliar do detalhe (grade de Grupos vinculados - tabela SigCdCom)
    *-- Cursor local usado pelo Grid da Page2: colunas CGrus (grupo) + DGrus (descricao via JOIN SigCdGrp)
    this_cCursorGrupos             = "cursor_4c_Grupos"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdTpc"
            THIS.this_cCampoChave = "tipos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpcBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cTipo)
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de composicao no cursor_4c_Dados
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT tipos, descrs FROM SigCdTpc ORDER BY tipos"
            ELSE
                loc_cSQL = "SELECT tipos, descrs FROM SigCdTpc" + ;
                           " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY tipos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK = tipos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cTipo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT custos, descrs, tipos, nchkimps, nchkmais," + ;
                       " nordems, usarpas" + ;
                       " FROM SigCdTpc" + ;
                       " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(par_cTipo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                IF loc_lSucesso
                    THIS.CarregarGrupos(par_cTipo)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cTipo                  = TratarNulo(tipos, "C")
            THIS.this_cDescricao             = TratarNulo(descrs, "C")
            THIS.this_nCalculaCustos         = TratarNulo(custos, "N")
            THIS.this_nImprimir              = TratarNulo(nchkimps, "N")
            THIS.this_nMaiusculos            = TratarNulo(nchkmais, "N")
            THIS.this_nOrdemImpressao        = TratarNulo(nordems, "N")
            THIS.this_nUtilizaProdutoAcabado = TratarNulo(usarpas, "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarGrupos - Carrega grade de Grupos vinculados ao Tipo
    * (SigCdCom.cgrus + descricao via JOIN SigCdGrp.dgrus) em cursor_4c_Grupos
    *====================================================================
    PROCEDURE CarregarGrupos(par_cTipo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_cSQL = "SELECT a.cgrus, ISNULL(b.dgrus, '') AS dgrus" + ;
                       " FROM SigCdCom a" + ;
                       " LEFT JOIN SigCdGrp b ON RTRIM(b.cgrus) = RTRIM(a.cgrus)" + ;
                       " WHERE RTRIM(a.tipos) = " + EscaparSQL(ALLTRIM(par_cTipo)) + ;
                       " ORDER BY a.cgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupos do tipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarCursoresGrid - Cria cursor vazio de Grupos para INCLUIR
    *====================================================================
    PROCEDURE InicializarCursoresGrid()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Grupos (cgrus C(3), dgrus C(20))
        SET NULL OFF
    ENDPROC

    *====================================================================
    * SalvarGrupos - Regrava vinculos de Grupos do Tipo (SigCdCom)
    * Espelha o legado: apaga tudo do Tipo e reinsere os CGrus distintos
    * e nao vazios presentes em cursor_4c_Grupos
    *====================================================================
    PROTECTED PROCEDURE SalvarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
        loc_lSucesso = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_cSQL = "DELETE FROM SigCdCom WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                IF USED("cursor_4c_Grupos") AND RECCOUNT("cursor_4c_Grupos") > 0
                    IF USED("cursor_4c_GruposGravar")
                        USE IN cursor_4c_GruposGravar
                    ENDIF

                    SELECT DISTINCT cgrus ;
                        FROM cursor_4c_Grupos ;
                       WHERE !EMPTY(ALLTRIM(cgrus)) ;
                       ORDER BY cgrus ;
                        INTO CURSOR cursor_4c_GruposGravar

                    SELECT cursor_4c_GruposGravar
                    SCAN
                        loc_cCidchaves = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdCom (tipos, cgrus, cidchaves)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cTipo) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_GruposGravar.cgrus)) + "," + ;
                                   EscaparSQL(loc_cCidchaves) + ;
                                   ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            loc_lSucesso = .F.
                            MsgErro("Erro ao inserir grupo do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_GruposGravar")
                        USE IN cursor_4c_GruposGravar
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        CATCH TO loc_oErro
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            MsgErro("Erro ao salvar grupos do tipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdTpc + grade de grupos (SigCdCom)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdTpc" + ;
                       " (custos, descrs, tipos, nchkimps, nchkmais, nordems, usarpas)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCalculaCustos) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       EscaparSQL(THIS.this_cTipo) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImprimir) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaiusculos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOrdemImpressao) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUtilizaProdutoAcabado) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                THIS.SalvarGrupos()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdTpc + grade de grupos (SigCdCom)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdTpc SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " custos = " + FormatarNumeroSQL(THIS.this_nCalculaCustos) + "," + ;
                       " nchkimps = " + FormatarNumeroSQL(THIS.this_nImprimir) + "," + ;
                       " nchkmais = " + FormatarNumeroSQL(THIS.this_nMaiusculos) + "," + ;
                       " nordems = " + FormatarNumeroSQL(THIS.this_nOrdemImpressao) + "," + ;
                       " usarpas = " + FormatarNumeroSQL(THIS.this_nUtilizaProdutoAcabado) + ;
                       " WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.SalvarGrupos()
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE SigCdCom (grupos) + SigCdTpc (registro principal)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir grupos vinculados (SigCdCom)
            loc_cSQL = "DELETE FROM SigCdCom WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- 2. Excluir registro principal (SigCdTpc)
                loc_cSQL = "DELETE FROM SigCdTpc WHERE RTRIM(tipos) = " + EscaparSQL(ALLTRIM(THIS.this_cTipo))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir tipo de composicao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de composicao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
