*====================================================================
* RegBO.prg
*
* Business Object para Cadastro de Regioes
* Tabela principal : SigCdReg (regiaos, descs, skchaves)
* Tabela filha     : SigCdRgi (municipios tipos='M' e vendedores tipos='C')
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS RegBO AS BusinessBase

    *-- ----------------------------------------------------------------
    *-- Propriedades da entidade principal (SigCdReg)
    *-- ----------------------------------------------------------------
    this_cRegiaos   = ""    && regiaos  char(10)  - PK
    this_cDescs     = ""    && descs    char(30)
    this_cSkChaves  = ""    && skchaves char(20)  - chave UUID (liga SigCdRgi)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdReg"
            THIS.this_cCampoChave = "regiaos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "RegBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cRegiaos  = TratarNulo(regiaos,  "C")
                THIS.this_cDescs    = TratarNulo(descs,    "C")
                THIS.this_cSkChaves = TratarNulo(skchaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Seleciona todas as regioes para o grid de listagem
    * par_cFiltro: filtro opcional (nao usado - mantido por padrao)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " ORDER BY regiaos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar regi" + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega uma regiao pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cRegiaos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT regiaos, descs, skchaves" + ;
                       " FROM SigCdReg" + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(par_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar regi" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarMunicipios - Carrega municipios da regiao no crMuni
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crMuni")
                USE IN crMuni
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " c.descs AS munici, d.estados AS uf" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdmun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN sigcdufs d ON d.ufibges = c.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'M'" + ;
                           " ORDER BY c.descs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MuniTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar munic" + CHR(237) + "pios: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crMuni (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), munici C(40), uf C(2))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_MuniTemp") > 0
                        APPEND FROM DBF("cursor_4c_MuniTemp")
                    ENDIF

                    IF RECCOUNT("crMuni") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crMuni
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_MuniTemp")
                    USE IN cursor_4c_MuniTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarMunicipios")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarVendedores - Carrega vendedores/clientes da regiao no crVend
    * par_cSkChaves: skchaves da regiao
    *====================================================================
    PROCEDURE BuscarVendedores(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("crVend")
                USE IN crVend
            ENDIF

            IF EMPTY(ALLTRIM(par_cSkChaves))
                *-- Regiao nova: criar cursor vazio com linha em branco
                SET NULL ON
                CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                    codibges C(7), tipos C(1), iclis C(10), vend C(50))
                SET NULL OFF
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkChaves, a.codibges, a.tipos," + ;
                           " a.iclis, c.razaos AS vend" + ;
                           " FROM SigCdRgi a" + ;
                           " LEFT JOIN sigcdcli c ON c.iclis = a.iclis" + ;
                           " WHERE a.skchaves = " + EscaparSQL(ALLTRIM(par_cSkChaves)) + ;
                           " AND a.tipos = 'C'" + ;
                           " ORDER BY c.razaos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendTemp")
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar vendedores: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SET NULL ON
                    CREATE CURSOR crVend (skchaves C(20), pkChaves C(20), ;
                        codibges C(7), tipos C(1), iclis C(10), vend C(50))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_VendTemp") > 0
                        APPEND FROM DBF("cursor_4c_VendTemp")
                    ENDIF

                    IF RECCOUNT("crVend") = 0
                        APPEND BLANK
                    ENDIF

                    GO TOP IN crVend
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_VendTemp")
                    USE IN cursor_4c_VendTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.BuscarVendedores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirFilhos - Insere registros em SigCdRgi a partir de crMuni e crVend
    * par_cSkChaves: skchaves da regiao (recem gerado ou existente)
    *====================================================================
    PROTECTED PROCEDURE InserirFilhos(par_cSkChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cPkChaves
        loc_lSucesso = .T.
        TRY
            *-- Inserir municipios do crMuni (tipos='M', codibges nao vazio)
            IF USED("crMuni")
                SELECT crMuni
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crMuni.codibges)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", " + ;
                                   EscaparSQL(ALLTRIM(crMuni.codibges)) + ", 'M', '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsMuni")
                        IF USED("cursor_4c_InsMuni")
                            USE IN cursor_4c_InsMuni
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- Inserir vendedores do crVend (tipos='C', iclis nao vazio)
            IF loc_lSucesso AND USED("crVend")
                SELECT crVend
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crVend.iclis)) .AND. !DELETED()
                        loc_cPkChaves = fUniqueIds()
                        loc_cSQL = "INSERT INTO SigCdRgi" + ;
                                   " (pkChaves, skchaves, codibges, tipos, iclis)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cSkChaves)) + ", '', 'C', " + ;
                                   EscaparSQL(ALLTRIM(crVend.iclis)) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsVend")
                        IF USED("cursor_4c_InsVend")
                            USE IN cursor_4c_InsVend
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir vendedor: " + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.InserirFilhos")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdReg + filhos em SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cSkChaves
        loc_lSucesso = .F.
        TRY
            *-- Gerar chave UUID para skchaves
            loc_cSkChaves = fUniqueIds()
            THIS.this_cSkChaves = loc_cSkChaves

            loc_cSQL = "INSERT INTO SigCdReg (regiaos, descs, skchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cRegiaos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ", " + ;
                       EscaparSQL(loc_cSkChaves) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsReg")
            IF USED("cursor_4c_InsReg")
                USE IN cursor_4c_InsReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao inserir regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = THIS.InserirFilhos(loc_cSkChaves)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigCdReg + rebuild de SigCdRgi
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Atualizar descricao (regiaos nao pode ser alterado)
            loc_cSQL = "UPDATE SigCdReg" + ;
                       " SET descs = " + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
                       " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdReg")
            IF USED("cursor_4c_UpdReg")
                USE IN cursor_4c_UpdReg
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar regi" + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remover todos os filhos existentes e reinserir
                loc_cSQL = "DELETE FROM SigCdRgi" + ;
                           " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
                IF USED("cursor_4c_DelRgi")
                    USE IN cursor_4c_DelRgi
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao remover municipios/vendedores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = THIS.InserirFilhos(ALLTRIM(THIS.this_cSkChaves))
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE de SigCdRgi + SigCdReg
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir filhos primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM SigCdRgi" + ;
                       " WHERE skchaves = " + EscaparSQL(ALLTRIM(THIS.this_cSkChaves))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgi")
            IF USED("cursor_4c_DelRgi")
                USE IN cursor_4c_DelRgi
            ENDIF

            IF loc_nResult < 0
                MsgErro("Erro ao excluir municipios/vendedores:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir regiao principal
                loc_cSQL = "DELETE FROM SigCdReg" + ;
                           " WHERE regiaos = " + EscaparSQL(ALLTRIM(THIS.this_cRegiaos))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelReg")
                IF USED("cursor_4c_DelReg")
                    USE IN cursor_4c_DelReg
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir regi" + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "RegBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cRegiaos)
    ENDPROC

ENDDEFINE
