*==============================================================================
* acgBO.prg
* Business Object para Acesso de Grupos
* Tabela: sigcdgra
* Legado: SIGCDACG.SCX (frmcadastro)
*==============================================================================

*------------------------------------------------------------------------------
* Classe: AcgBO
* Descricao: Gerenciamento de grupos de acesso (sigcdgra)
* Herda de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS AcgBO AS BusinessBase

    *-- Identificacao da tabela e chave primaria
    this_cTabela     = "sigcdgra"
    this_cCampoChave = "Grupos"
    this_cCursor     = "crsigcdgra"

    *-- Propriedades da entidade
    this_cGrupos    = ""   && Codigo do grupo (c10)
    this_cNComps    = ""   && Nome completo do grupo (c100)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        THIS.this_cCursor     = "crsigcdgra"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("crsigcdgra")
            loc_cChave = ALLTRIM(crsigcdgra.Grupos)
        ELSE
            loc_cChave = THIS.this_cGrupos
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades da entidade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cGrupos = ""
        THIS.this_cNComps  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Prepara cursor vazio para novo registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        IF NOT USED("crsigcdgra")
            SET NULL ON
            CREATE CURSOR crsigcdgra (;
                Grupos C(10),;
                NComps C(100);
            )
            SET NULL OFF
        ELSE
            ZAP IN crsigcdgra
        ENDIF
        SELECT crsigcdgra
        APPEND BLANK
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nResultado

        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do Grupo n" + CHR(227) + "o pode ser vazio!"
            MsgAviso(THIS.this_cMensagemErro)
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cNComps))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser vazia!"
            MsgAviso(THIS.this_cMensagemErro)
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS nQtd FROM sigcdgra WHERE grupos = " + EscaparSQL(THIS.this_cGrupos), ;
                "cursor_4c_DupVerif")
            IF loc_nResultado > 0
                IF NVL(cursor_4c_DupVerif.nQtd, 0) > 0
                    THIS.this_cMensagemErro = "Grupo j" + CHR(225) + " cadastrado!"
                    MsgAviso(THIS.this_cMensagemErro)
                    loc_lValido = .F.
                ENDIF
                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos e popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT grupos, ncomps FROM sigcdgra ORDER BY grupos"

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado > 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ELSE
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (;
                        Grupos C(10),;
                        NComps C(100);
                    )
                    SET NULL OFF
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ENDIF

                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar grupos de acesso"
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro e popula crsigcdgra para binding
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT grupos, ncomps FROM sigcdgra WHERE grupos = " + EscaparSQL(par_cCodigo)

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Busca") > 0
                SELECT cursor_4c_Busca
                THIS.this_cGrupos = ALLTRIM(NVL(cursor_4c_Busca.grupos, ""))
                THIS.this_cNComps  = ALLTRIM(NVL(cursor_4c_Busca.ncomps, ""))

                *-- Atualizar crsigcdgra para binding dos textboxes
                IF NOT USED("crsigcdgra")
                    SET NULL ON
                    CREATE CURSOR crsigcdgra (;
                        Grupos C(10),;
                        NComps C(100);
                    )
                    SET NULL OFF
                ELSE
                    ZAP IN crsigcdgra
                ENDIF
                SELECT crsigcdgra
                APPEND BLANK
                REPLACE Grupos WITH THIS.this_cGrupos
                REPLACE NComps  WITH THIS.this_cNComps

                THIS.this_lNovoRegistro = .F.
                THIS.this_lEmEdicao     = .F.
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de alias de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        IF VARTYPE(par_cAlias) = "C" AND USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cGrupos = ALLTRIM(NVL(EVALUATE(par_cAlias + ".grupos"), ""))
            THIS.this_cNComps  = ALLTRIM(NVL(EVALUATE(par_cAlias + ".ncomps"),  ""))
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo grupo em sigcdgra
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "INSERT INTO sigcdgra (grupos, ncomps) VALUES (" + ;
                   EscaparSQL(THIS.this_cGrupos) + ", " + ;
                   EscaparSQL(THIS.this_cNComps) + ")"

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir grupo"
                MsgErro(THIS.this_cMensagemErro)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(THIS.this_cMensagemErro)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza descricao do grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "UPDATE sigcdgra SET ncomps = " + EscaparSQL(THIS.this_cNComps) + ;
                   " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar grupo"
                MsgErro(THIS.this_cMensagemErro)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(THIS.this_cMensagemErro)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui grupo e todos os dados relacionados
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruposEsc

        loc_lSucesso   = .F.
        loc_cGruposEsc = EscaparSQL(THIS.this_cGrupos)

        TRY
            *-- Excluir em cascata (tabelas filhas primeiro)
            SQLEXEC(gnConnHandle, "DELETE FROM sigactel WHERE grupos = " + loc_cGruposEsc)
            SQLEXEC(gnConnHandle, "DELETE FROM sigcdacb WHERE grupos = " + loc_cGruposEsc)
            SQLEXEC(gnConnHandle, "DELETE FROM sigcdacu WHERE grupos = " + loc_cGruposEsc)
            SQLEXEC(gnConnHandle, "DELETE FROM sigcdacg WHERE grupos = " + loc_cGruposEsc)

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdgra WHERE grupos = " + loc_cGruposEsc)

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir grupo"
                MsgErro(THIS.this_cMensagemErro)
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(THIS.this_cMensagemErro)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
