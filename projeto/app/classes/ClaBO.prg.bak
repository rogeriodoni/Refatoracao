*------------------------------------------------------------------------------
* ClaBO.prg - Business Object para Classificacao de Produtos
* Tabela principal: SigCdCls
* Tabela detalhe:   SigCdCla (grupos associados)
*------------------------------------------------------------------------------

DEFINE CLASS ClaBO AS BusinessBase

    *-- Propriedades da entidade SigCdCls
    this_cCodigo    = ""   && SigCdCls.Cods     (PK char(3))
    this_cDescricao = ""   && SigCdCls.Descs    (char(40))
    this_cTipo      = ""   && SigCdCls.Tipos    (char(1): O=Ouro, P=Prata, R=Rel+CHR(243)+gio, J=Jolie)
    this_nSitua     = 0    && SigCdCls.Situas   (numeric(1,0): 1=Ativos, 2=Inativos, 3=Ambos)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCls"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdCls filtrados opcionalmente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Buscar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods = " + EscaparSQL(par_cCodigo)

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = ALLTRIM(NVL(Cods,  ""))
                THIS.this_cDescricao = ALLTRIM(NVL(Descs, ""))
                THIS.this_cTipo      = ALLTRIM(NVL(Tipos, ""))
                THIS.this_nSitua     = NVL(Situas, 0)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigo))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdCls (Cods, Descs, Tipos, Situas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigo)    + "," + ;
                           EscaparSQL(THIS.this_cDescricao) + "," + ;
                           EscaparSQL(THIS.this_cTipo)      + "," + ;
                           FormatarNumeroSQL(THIS.this_nSitua) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Inserir: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCls SET" + ;
                       "  Descs  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "  Tipos  = " + EscaparSQL(THIS.this_cTipo)      + "," + ;
                       "  Situas = " + FormatarNumeroSQL(THIS.this_nSitua) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Atualizar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdCla e SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir registros de detalhe (SigCdCla)
            loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos da classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir registro principal (SigCdCls)
                loc_cSQL = "DELETE FROM SigCdCls WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos associados (SigCdCla + SigCdGrp) para o grid
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.CGrus, b.DGrus" + ;
                       " FROM SigCdCla a" + ;
                       " LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.CGrus"

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Grupos")
                    GO TOP IN cursor_4c_Grupos
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.BuscarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Salva grupos associados em SigCdCla (DELETE + INSERT)
    *   par_cCodigo       = codigo da classificacao (SigCdCls.Cods)
    *   par_cCursorGrupos = alias do cursor local com CGrus/DGrus
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cCodigo, par_cCursorGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCGrus, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                *-- Remover grupos antigos
                loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_lResultado = .T.

                    *-- Inserir grupos do cursor (apenas CGrus nao vazio e distintos)
                    IF USED(par_cCursorGrupos) AND RECCOUNT(par_cCursorGrupos) > 0
                        SELECT DISTINCT CGrus FROM (par_cCursorGrupos) ;
                            WHERE !EMPTY(CGrus) ;
                            ORDER BY CGrus ;
                            INTO CURSOR cursor_4c_GruposGrav

                        IF USED("cursor_4c_GruposGrav") AND RECCOUNT("cursor_4c_GruposGrav") > 0
                            GO TOP IN cursor_4c_GruposGrav
                            SELECT cursor_4c_GruposGrav
                            SCAN
                                loc_cCGrus      = ALLTRIM(cursor_4c_GruposGrav.CGrus)
                                loc_cCidchaves  = LEFT(fUniqueIds(), 20)

                                loc_cSQL = "INSERT INTO SigCdCla (CGrus, CIdChaves, Cods)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(loc_cCGrus)     + "," + ;
                                           EscaparSQL(loc_cCidchaves) + "," + ;
                                           EscaparSQL(par_cCodigo)    + ;
                                           ")"

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_cCGrus + ":" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                    EXIT
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF USED("cursor_4c_GruposGrav")
                            USE IN cursor_4c_GruposGrav
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.SalvarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
