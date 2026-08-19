*==============================================================================
* MrcBO.prg - Business Object para Cadastro de Demonstrativos
* Tabela principal: SigCdMrr (Demonstrativos)
* Tabela relacionada: SigCdMri (Itens do Demonstrativo)
*==============================================================================
DEFINE CLASS MrcBO AS BusinessBase

    *-- Propriedades da entidade SigCdMrr
    this_cBalanco   = ""   && balancos char(20) - chave primaria
    this_cTitulo    = ""   && titulos  char(40)
    this_nMapa      = 1    && mapas    numeric(1,0): 1=Plano de Contas, 2=Mapa de Contas

    *-- Nome do cursor principal
    this_cCursorDados = "cursor_4c_Dados"

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMrr"
        THIS.this_cCampoChave = "Balancos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cBalanco
    ENDFUNC

    *--------------------------------------------------------------------------
    * NovoRegistro - Prepara BO para INSERT
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cBalanco = ""
        THIS.this_cTitulo  = ""
        THIS.this_nMapa    = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara BO para UPDATE
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBalanco = TratarNulo(Balancos, "C")
            THIS.this_cTitulo  = TratarNulo(Titulos,  "C")
            THIS.this_nMapa    = TratarNulo(Mapas,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cBalanco))
            THIS.this_cMensagemErro = "Demonstrativo " + CHR(233) + " obrigat" + CHR(243) + "rio."
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona registros de SigCdMrr para a grade
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE Balancos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       loc_cWhere + ;
                       " ORDER BY Balancos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar demonstrativos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar demonstrativos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um demonstrativo pelo codigo (Balancos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Balancos, Titulos, Mapas" + ;
                       " FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Demonstrativo n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se Balancos ja existe em SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMrr" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChk")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChk") > 0
                SELECT cursor_4c_DupChk
                loc_lExiste = (cursor_4c_DupChk.Total > 0)
            ENDIF

            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DupChk")
                USE IN cursor_4c_DupChk
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo demonstrativo em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                THIS.this_cMensagemErro = "Demonstrativo j" + CHR(225) + " cadastrado."
                MsgAviso(THIS.this_cMensagemErro, "Registro Duplicado")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdMrr (Balancos, Titulos, Mapas)" + ;
                           " VALUES (" + EscaparSQL(THIS.this_cBalanco) + ;
                           ", " + EscaparSQL(THIS.this_cTitulo) + ;
                           ", " + FormatarNumeroSQL(THIS.this_nMapa) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao inserir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza demonstrativo existente em SigCdMrr (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMrr" + ;
                       " SET Titulos = " + EscaparSQL(THIS.this_cTitulo) + ;
                       ", Mapas = " + FormatarNumeroSQL(THIS.this_nMapa) + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar demonstrativo: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui demonstrativo e seus itens (PROTECTED)
    * Cascade: DELETE SigCdMri primeiro, depois SigCdMrr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- 1. Excluir itens do demonstrativo (SigCdMri) - cascade
            loc_cSQL = "DELETE FROM SigCdMri WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMri")

            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao excluir itens: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                loc_lSucesso = .F.
            ELSE
                *-- 2. Excluir o demonstrativo principal (SigCdMrr)
                loc_cSQL = "DELETE FROM SigCdMrr WHERE Balancos = " + EscaparSQL(THIS.this_cBalanco)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelMrr")

                IF USED("cursor_4c_DelMrr")
                    USE IN cursor_4c_DelMrr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao excluir demonstrativo: " + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao excluir demonstrativo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DelMri")
                USE IN cursor_4c_DelMri
            ENDIF
            IF USED("cursor_4c_DelMrr")
                USE IN cursor_4c_DelMrr
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
