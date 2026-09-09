*====================================================================
* StoBO.prg
*
* Business Object para Cadastro de Status de Operacao
* Tabela: SigCdSts
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS StoBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdSts)
    this_cCodigo          = ""    && cods char(3) - PK
    this_cDescricao       = ""    && descs char(30)
    this_cDiasValidos     = ""    && ddvals char(10) - string bruta (8 flags 0/1)

    *-- Propriedades individuais dos dias de entrega (derivadas de this_cDiasValidos)
    this_lEntregaDomingo  = .F.   && posicao 1 de ddvals - chkEntregaDo
    this_lEntregaSegunda  = .F.   && posicao 2 de ddvals - chkEntrega02
    this_lEntregaTerca    = .F.   && posicao 3 de ddvals - chkEntrega03
    this_lEntregaQuarta   = .F.   && posicao 4 de ddvals - chkEntrega04
    this_lEntregaQuinta   = .F.   && posicao 5 de ddvals - chkEntrega05
    this_lEntregaSexta    = .F.   && posicao 6 de ddvals - chkEntrega06
    this_lEntregaSabado   = .F.   && posicao 7 de ddvals - chkEntregaSa
    this_lEntregaFeriado  = .F.   && posicao 8 de ddvals - chkEntregaFe

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSts"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "StoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDPROC

    *====================================================================
    * SincronizarDiasDoValor - Decompoe this_cDiasValidos (ddvals) nas
    * 8 propriedades booleanas individuais (posicoes 1 a 8)
    * Ordem: Domingo,Segunda,Terca,Quarta,Quinta,Sexta,Sabado,Feriado
    *====================================================================
    PROTECTED PROCEDURE SincronizarDiasDoValor()
        LOCAL loc_cStr
        loc_cStr = PADR(THIS.this_cDiasValidos, 8, " ")

        THIS.this_lEntregaDomingo = (SUBSTR(loc_cStr, 1, 1) == "1")
        THIS.this_lEntregaSegunda = (SUBSTR(loc_cStr, 2, 1) == "1")
        THIS.this_lEntregaTerca   = (SUBSTR(loc_cStr, 3, 1) == "1")
        THIS.this_lEntregaQuarta  = (SUBSTR(loc_cStr, 4, 1) == "1")
        THIS.this_lEntregaQuinta  = (SUBSTR(loc_cStr, 5, 1) == "1")
        THIS.this_lEntregaSexta   = (SUBSTR(loc_cStr, 6, 1) == "1")
        THIS.this_lEntregaSabado  = (SUBSTR(loc_cStr, 7, 1) == "1")
        THIS.this_lEntregaFeriado = (SUBSTR(loc_cStr, 8, 1) == "1")
    ENDPROC

    *====================================================================
    * MontarDiasValidos - Recompoe this_cDiasValidos (ddvals) a partir
    * das 8 propriedades booleanas individuais, antes de gravar
    *====================================================================
    PROTECTED PROCEDURE MontarDiasValidos()
        LOCAL loc_cStr
        loc_cStr = IIF(THIS.this_lEntregaDomingo, "1", "0") + ;
                   IIF(THIS.this_lEntregaSegunda, "1", "0") + ;
                   IIF(THIS.this_lEntregaTerca,   "1", "0") + ;
                   IIF(THIS.this_lEntregaQuarta,  "1", "0") + ;
                   IIF(THIS.this_lEntregaQuinta,  "1", "0") + ;
                   IIF(THIS.this_lEntregaSexta,   "1", "0") + ;
                   IIF(THIS.this_lEntregaSabado,  "1", "0") + ;
                   IIF(THIS.this_lEntregaFeriado, "1", "0")

        THIS.this_cDiasValidos = loc_cStr
        RETURN loc_cStr
    ENDPROC

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
                THIS.this_cCodigo      = TratarNulo(cods,   "C")
                THIS.this_cDescricao   = TratarNulo(descs,  "C")
                THIS.this_cDiasValidos = TratarNulo(ddvals, "C")

                THIS.SincronizarDiasDoValor()

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "StoBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdSts" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "StoBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdSts
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.MontarDiasValidos()

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdSts (cods, descs, ddvals)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cDiasValidos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir status de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "StoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdSts
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.MontarDiasValidos()

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdSts
                SET descs  = <<EscaparSQL(THIS.this_cDescricao)>>,
                    ddvals = <<EscaparSQL(THIS.this_cDiasValidos)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar status de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "StoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdSts
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdSts WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir status de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "StoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs, ddvals
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(3), descs C(30), ddvals C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs, ddvals FROM SigCdSts"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar status de opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "StoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, ddvals" + ;
                " FROM SigCdSts WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Status de Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar status de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "StoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
