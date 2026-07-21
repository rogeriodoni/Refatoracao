*==============================================================================
* ACJBO.prg - Business Object para Acessos de JOB
* Tabela principal: SigCdAcJ | PK: pkChaves
* Lista de JOBs: SigCdCli (filtro SigCdGcr.Coletors=10)
*==============================================================================

DEFINE CLASS ACJBO AS BusinessBase

    *-- Propriedades do JOB selecionado (display - SigCdCli via crGradeJOB)
    this_cGrupos        = ""    && Grupos    CHAR  - Grupo do JOB
    this_cIClis         = ""    && IClis     CHAR  - C" + CHR(243) + "digo do JOB (PK em SigCdCli)
    this_cRClis         = ""    && RClis     CHAR  - C" + CHR(243) + "digo abreviado
    this_cRazaos        = ""    && Razaos    CHAR  - Descritivo do JOB
    this_cUsuarsCriador = ""    && Usuars    CHAR  - Usu" + CHR(225) + "rio que criou o JOB
    this_dDataIncs      = {}    && DataIncs  DATE  - Data de inclus" + CHR(227) + "o
    this_lInativas      = .F.   && Inativas  NUM   - Inativo (0=N, 1=S)

    *-- Propriedades de controle de acesso (SigCdAcJ)
    this_cPkChaves      = ""    && pkChaves  CHAR  - Chave prim" + CHR(225) + "ria (gerada por fUniqueIds)
    this_cJOBs          = ""    && JOBs      CHAR  - FK para IClis do JOB
    this_cUsuars        = ""    && Usuars    CHAR  - Login do usu" + CHR(225) + "rio com acesso
    this_cNComps        = ""    && NComps    CHAR  - Nome completo (JOIN SigCdUsu.NComps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdAcJ"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkChaves, "C")
                THIS.this_cJOBs     = TratarNulo(JOBs,     "C")
                THIS.this_cUsuars   = TratarNulo(Usuars,   "C")
                THIS.this_cNComps   = TratarNulo(NComps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarJobDoCursor - Carrega dados do JOB selecionado (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarJobDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos        = TratarNulo(Grupos,   "C")
                THIS.this_cIClis         = TratarNulo(IClis,    "C")
                THIS.this_cRClis         = TratarNulo(RClis,    "C")
                THIS.this_cRazaos        = TratarNulo(Razaos,   "C")
                THIS.this_cUsuarsCriador = TratarNulo(Usuars,   "C")
                THIS.this_dDataIncs      = TratarNulo(DataIncs, "D")
                THIS.this_lInativas      = (TratarNulo(Inativas, "N") = 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar JOB do cursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de JOBs (SigCdCli filtrado por Coletors=10)
    * Cursor destino: cursor_4c_Lista
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Grupos, a.IClis, a.RClis, a.Razaos," + ;
                       " a.Inativas, a.Usuars, a.DataIncs" + ;
                       " FROM SigCdGcr b, SigCdCli a" + ;
                       " WHERE b.Coletors = 10" + ;
                       " AND b.Codigos = a.Grupos"

            loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar JOBs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar JOBs:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega usu" + CHR(225) + "rios com acesso ao JOB
    * Cursor destino: cursor_4c_AcJ
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.JOBs = " + EscaparSQL(ALLTRIM(par_cIClis)) + ;
                       " ORDER BY a.Usuars"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcJ")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Salva lista de usu" + CHR(225) + "rios com acesso ao JOB
    * Estrat" + CHR(233) + "gia: DELETE todos os existentes + INSERT dos atuais
    * Par" + CHR(226) + "metro: par_cIClis - c" + CHR(243) + "digo do JOB
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChaves
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            *-- 1. Deletar todos os acessos antigos para este JOB
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos antigos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Inserir registros atuais do cursor (somente com Usuars preenchido e nao deletados)
            IF USED("cursor_4c_AcJ") AND RECCOUNT("cursor_4c_AcJ") > 0
                SELECT cursor_4c_AcJ
                GO TOP
                DO WHILE !EOF("cursor_4c_AcJ")
                    IF !DELETED() AND !EMPTY(ALLTRIM(cursor_4c_AcJ.Usuars))
                        loc_cPkChaves = ALLTRIM(cursor_4c_AcJ.pkChaves)
                        IF EMPTY(loc_cPkChaves)
                            loc_cPkChaves = SYS(2015) + SYS(2015)
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cPkChaves) + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cIClis)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_AcJ.Usuars)) + ;
                                   ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso para usu" + CHR(225) + "rio " + ;
                                   ALLTRIM(cursor_4c_AcJ.Usuars) + ":" + CHR(13) + ;
                                   CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                    SKIP IN cursor_4c_AcJ
                ENDDO
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirAcessos - Remove todos os acessos de um JOB
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirAcessos(par_cIClis)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cIClis))
                MsgAviso("C" + CHR(243) + "digo do JOB n" + CHR(227) + "o informado.")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCdAcJ WHERE JOBs = " + EscaparSQL(ALLTRIM(par_cIClis))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acessos:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inserir registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdAcJ (pkChaves, JOBs, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                       EscaparSQL(THIS.this_cJOBs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualizar registro individual (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdAcJ SET" + ;
                       " JOBs = " + EscaparSQL(THIS.this_cJOBs) + "," + ;
                       " Usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro individual (chamado pelo BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAcJ WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega acesso pela chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.pkChaves, a.JOBs, a.Usuars, b.NComps" + ;
                       " FROM SigCdAcJ a" + ;
                       " LEFT JOIN SigCdUsu b ON a.Usuars = b.Usuarios" + ;
                       " WHERE a.pkChaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidadeUsuario - Verifica usu" + CHR(225) + "rios duplicados no cursor local
    * Retorna "" se OK, ou mensagem de erro se houver duplicata
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUnicidadeUsuario()
        LOCAL loc_cMensagem, loc_lSucesso
        loc_cMensagem = ""
        loc_lSucesso  = .F.

        TRY
            IF !USED("cursor_4c_AcJ")
                loc_lSucesso = ""
            ENDIF

            SELECT SUM(1) AS Soma, Usuars ;
              FROM cursor_4c_AcJ ;
             WHERE !DELETED() AND !EMPTY(ALLTRIM(Usuars)) ;
             GROUP BY Usuars ;
              INTO CURSOR cursor_4c_DuplAcJ

            GO TOP IN cursor_4c_DuplAcJ
            SELECT cursor_4c_DuplAcJ
            LOCATE FOR cursor_4c_DuplAcJ.Soma > 1
            IF !EOF("cursor_4c_DuplAcJ")
                loc_cMensagem = "O Usu" + CHR(225) + "rio " + CHR(34) + ;
                               ALLTRIM(cursor_4c_DuplAcJ.Usuars) + ;
                               CHR(34) + " est" + CHR(225) + " duplicado na grade!!!"
            ENDIF

            IF USED("cursor_4c_DuplAcJ")
                USE IN cursor_4c_DuplAcJ
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar unicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMensagem
    ENDPROC

ENDDEFINE
