*==============================================================================
* OpsBO.prg - Business Object para Cadastro de Opera??es
* Tabela: SigCdOpe | PK: dopes
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OpsBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpe"
    this_cCampoChave  = "dopes"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpe (campos do formul?rio)
    *--------------------------------------------------------------------------
    this_cDopes     = ""    && dopes    char(20) - C�digo / chave prim�ria
    this_nNDopes    = 0     && ndopes   numeric(4,0) - N�mero da opera��o
    this_cTitOpes   = ""    && titopes  char(30) - T�tulo / descri��o
    this_cMenus     = ""    && menus    char(10) - Menu
    this_cSubMenus  = ""    && submenus char(15) - Submenu
    this_nOrdes     = 0     && ordes    numeric(4,0) - Ordem
    this_cCmoes     = ""    && cmoes    char(3)  - Moeda
    this_nCopers    = 0     && copers   numeric(1,0) - Tipo movimento (0=Entrada,1=Sa�da)
    this_cObsOpes   = ""    && obsopes  text     - Observa��o
    this_nTipoOps   = 0     && tipoops  numeric(2,0) - Tipo de opera��o
    this_cAbrevs    = ""    && abrevs   char(3)  - Abreviatura / reduzida
    this_cNivels    = ""    && nivels   char(20) - Sub-n�vel
    this_nNFiscals  = 0     && nfiscals numeric(1,0) - Fiscal

    *--------------------------------------------------------------------------
    * Propriedades - SigOpCdc (cursor secund?rio - inativa??o)
    *--------------------------------------------------------------------------
    this_nOpeInatvs = 0     && opeinatvs numeric(1,0) - Opera��o inativa (0=Ativa,1=Inativa)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave prim?ria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
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
                THIS.this_cDopes    = TratarNulo(Dopes,    "C")
                THIS.this_nNDopes   = TratarNulo(NDopes,   "N")
                THIS.this_cTitOpes  = TratarNulo(TitOpes,  "C")
                THIS.this_cMenus    = TratarNulo(Menus,    "C")
                THIS.this_cSubMenus = TratarNulo(SubMenus, "C")
                THIS.this_nOrdes    = TratarNulo(Ordes,    "N")
                THIS.this_cCmoes    = TratarNulo(CMoes,    "C")
                THIS.this_nCopers   = TratarNulo(Copers,   "N")
                THIS.this_cObsOpes  = TratarNulo(ObsOpes,  "C")
                THIS.this_nTipoOps  = TratarNulo(TipoOps,  "N")
                THIS.this_cAbrevs   = TratarNulo(Abrevs,   "C")
                THIS.this_cNivels   = TratarNulo(Nivels,   "C")
                THIS.this_nNFiscals = TratarNulo(NFiscals, "N")
                IF TYPE("OpeInatvs") != "U"
                    THIS.this_nOpeInatvs = TratarNulo(OpeInatvs, "N")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message, "OpsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cDopes))
            MsgAviso("C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cDopes)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cTitOpes))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se dopes ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpe" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOps")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOps")
                SELECT cursor_4c_ChkOps
                loc_lExiste = (cursor_4c_ChkOps.qtd > 0)
                USE IN cursor_4c_ChkOps
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OpsBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * AtualizarSigOpCdc - Insere ou atualiza status de inativacao em SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE AtualizarSigOpCdc()
        LOCAL loc_cSQL, loc_nResultado, loc_nExiste
        loc_nExiste = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCdc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCdc")
                SELECT cursor_4c_ChkCdc
                loc_nExiste = NVL(cursor_4c_ChkCdc.qtd, 0)
                USE IN cursor_4c_ChkCdc
            ENDIF

            IF loc_nExiste > 0
                loc_cSQL = "UPDATE SigOpCdc SET OpeInatvs = " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ;
                    " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            ELSE
                loc_cSQL = "INSERT INTO SigOpCdc (Dopes, OpeInatvs)" + ;
                    " VALUES (" + ;
                    EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ")"
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loException
            MostrarErro("Erro ao atualizar SigOpCdc:" + CHR(13) + loException.Message, "OpsBO.AtualizarSigOpCdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOpe" + ;
                " (Dopes, NDopes, TitOpes, Menus, SubMenus," + ;
                "  Ordes, CMoes, Copers, ObsOpes, TipoOps, Abrevs, Nivels, NFiscals)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNDopes, 0) + ", " + ;
                EscaparSQL(THIS.this_cTitOpes) + ", " + ;
                EscaparSQL(THIS.this_cMenus) + ", " + ;
                EscaparSQL(THIS.this_cSubMenus) + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdes, 0) + ", " + ;
                EscaparSQL(THIS.this_cCmoes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCopers, 0) + ", " + ;
                EscaparSQL(THIS.this_cObsOpes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipoOps, 0) + ", " + ;
                EscaparSQL(THIS.this_cAbrevs) + ", " + ;
                EscaparSQL(THIS.this_cNivels) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpe SET" + ;
                " NDopes   = " + FormatarNumeroSQL(THIS.this_nNDopes, 0) + "," + ;
                " TitOpes  = " + EscaparSQL(THIS.this_cTitOpes) + "," + ;
                " Menus    = " + EscaparSQL(THIS.this_cMenus) + "," + ;
                " SubMenus = " + EscaparSQL(THIS.this_cSubMenus) + "," + ;
                " Ordes    = " + FormatarNumeroSQL(THIS.this_nOrdes, 0) + "," + ;
                " CMoes    = " + EscaparSQL(THIS.this_cCmoes) + "," + ;
                " Copers   = " + FormatarNumeroSQL(THIS.this_nCopers, 0) + "," + ;
                " ObsOpes  = " + EscaparSQL(THIS.this_cObsOpes) + "," + ;
                " TipoOps  = " + FormatarNumeroSQL(THIS.this_nTipoOps, 0) + "," + ;
                " Abrevs   = " + EscaparSQL(THIS.this_cAbrevs) + "," + ;
                " Nivels   = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                " NFiscals = " + FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SigCdOpe e tabelas relacionadas
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar uso em SigOpFin (lancamentos financeiros)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFin" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFin")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFin")
                SELECT cursor_4c_ChkFin
                loc_nUso = NVL(cursor_4c_ChkFin.qtd, 0)
                USE IN cursor_4c_ChkFin
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                *-- Excluir registros filhos antes do principal
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdd WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdc WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))

                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista operacoes com filtro de status
    * par_cFiltro: "" = todos | "Ativo" = ativos | "Inativo" = inativos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Dopes C(20), NDopes N(4,0), ;
                        Abrevs C(20), CMoes C(3), Nivels C(20), Menus C(10), ;
                        SubMenus C(15), Ordes N(4,0), TipoOps N(2,0), ;
                        DopMenus C(30), Inativas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C"
                    DO CASE
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "ATIVO"
                            loc_cWhere = " WHERE NVL(b.OpeInatvs, 0) = 0"
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "INATIVO"
                            loc_cWhere = " WHERE NVL(b.OpeInatvs, 0) = 1"
                    ENDCASE
                ENDIF

                loc_cSQL = "SELECT a.Dopes, a.NDopes, a.Abrevs, a.CMoes," + ;
                    " a.Nivels, a.Menus, a.SubMenus, a.Ordes, a.TipoOps," + ;
                    " LEFT(RIGHT(d.ConfigGers, 89), 30) AS DopMenus," + ;
                    " NVL(b.OpeInatvs, 0) AS Inativas" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                    " LEFT JOIN SigOpCdd d ON d.Dopes = a.Dopes" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Dopes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (Dopes)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.NDopes, a.TitOpes, a.Menus, a.SubMenus," + ;
                " a.Ordes, a.CMoes, a.Copers, a.ObsOpes, a.TipoOps," + ;
                " a.Abrevs, a.Nivels, a.NFiscals," + ;
                " NVL(b.OpeInatvs, 0) AS OpeInatvs" + ;
                " FROM SigCdOpe a" + ;
                " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                " WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpsBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
