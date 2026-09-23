*====================================================================
* TPRBO.prg
*
* Business Object para Cadastro de Subtipos de Transportes
* Tabela: SigPrTro
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TPRBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTro)
    this_cIdChaves   = ""    && cidchaves char(20) - PK
    this_cTpTrans    = ""    && tptrans   char(6)
    this_cTps        = ""    && tps       char(1)
    this_cRecTrans   = ""    && rectrans  char(1) - T/R
    this_cDbf        = ""    && dbf       char(8)
    this_cObs        = ""    && obs       char(40)
    this_cCProcs     = ""    && cprocs    char(15)
    this_nOrdems     = 0     && ordems    numeric(2,0)
    this_cIndice     = ""    && indice    char(15)
    this_cChave      = ""    && chave     char(40)
    this_cComparacao = ""    && comparacao text
    this_nFotos      = 0     && fotos     numeric(1,0) - 1=Sim/2=Nao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTro"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TPRBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *====================================================================
    * InicializarValoresPadrao - Hook chamado por NovoRegistro
    * NOTA: this_cTpTrans (filtro/grupo de transporte da tela) deve ser
    * atribuido pelo Form APOS chamar NovoRegistro() - equivale ao legado
    * "Replace TpTrans With ThisForm.TpTrans" feito no Grupo_op.Click(Inserir)
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cIdChaves   = ""
        THIS.this_cTpTrans    = ""
        THIS.this_cTps        = ""
        THIS.this_cRecTrans   = ""
        THIS.this_cDbf        = ""
        THIS.this_cObs        = ""
        THIS.this_cCProcs     = ""
        THIS.this_nOrdems     = 0
        THIS.this_cIndice     = ""
        THIS.this_cChave      = ""
        THIS.this_cComparacao = ""
        THIS.this_nFotos      = 1   && legado: op_fotos.Value default = 1 (Sim)
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
                THIS.this_cIdChaves   = TratarNulo(cidchaves,  "C")
                THIS.this_cTpTrans    = TratarNulo(tptrans,    "C")
                THIS.this_cTps        = TratarNulo(tps,        "C")
                THIS.this_cRecTrans   = TratarNulo(rectrans,   "C")
                THIS.this_cDbf        = TratarNulo(dbf,        "C")
                THIS.this_cObs        = TratarNulo(obs,        "C")
                THIS.this_cCProcs     = TratarNulo(cprocs,     "C")
                THIS.this_nOrdems     = TratarNulo(ordems,     "N")
                THIS.this_cIndice     = TratarNulo(indice,     "C")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cComparacao = TratarNulo(comparacao, "C")
                THIS.this_nFotos      = TratarNulo(fotos,      "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPRBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcricao literal das validacoes de Pagina.Dados.Grupo_Salva.Salva.Click,
    * getRecTrans.Valid, getCProcs.Valid e getTps.Valid do legado SIGCDTPR
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cRecTrans, loc_cCProcs, loc_cTps, loc_cDbf
        loc_lValido   = .T.
        loc_cRecTrans = ALLTRIM(UPPER(NVL(THIS.this_cRecTrans, "")))
        loc_cCProcs   = ALLTRIM(UPPER(NVL(THIS.this_cCProcs, "")))
        loc_cTps      = ALLTRIM(UPPER(NVL(THIS.this_cTps, "")))
        loc_cDbf      = ALLTRIM(NVL(THIS.this_cDbf, ""))

        *-- Obrigatorio Informar a Descricao do Transporte
        IF EMPTY(THIS.this_cObs)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Descri" + CHR(231) + CHR(227) + "o do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar o Codigo do Transporte
        IF loc_lValido AND EMPTY(loc_cTps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar o Tipo do Transporte
        IF loc_lValido AND EMPTY(loc_cRecTrans)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- O Tipo do Transporte Tem Que Ser T ou R
        IF loc_lValido AND !INLIST(loc_cRecTrans, "T", "R")
            MsgAviso("O Tipo do Transporte Tem Que Ser T ou R!!!")
            loc_lValido = .F.
        ENDIF

        *-- Obrigatorio Informar a Tabela do Transporte
        IF loc_lValido AND EMPTY(loc_cDbf)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Tabela do Transporte!!!")
            loc_lValido = .F.
        ENDIF

        *-- getCProcs.Valid: lista de processos validos depende do Tipo (T/R)
        IF loc_lValido AND !EMPTY(loc_cCProcs)
            IF loc_cRecTrans = "T"
                IF !INLIST(loc_cCProcs, "COPIA", "PRODUTO", "CLIENTE", "PROETI", ;
                        "TRANSFERE", "SITUACAO", "CHDEVOL", "BALANCO", "CPF", "ETIQUETA", ;
                        "COMPLEMENTO", "COMPLECLI", "EMPCLIENTE", "DATATRANS", "APAGA", ;
                        "SIGMVHST", "SIGMVCCR", "SALDO", "TRANSFEREC", "CADCLIENTES")
                    MsgAviso("Os Processos V" + CHR(225) + "lidos s" + CHR(227) + "o: COPIA, PRODUTO, CLIENTE, PROETI, TRANSFERE, " + CHR(13) + ;
                        "SITUACAO, CHDEVOL, BALANCO, CPF, ETIQUETA, COMPLEMENTO, COMPLECLI, " + ;
                        "EMPCLIENTE,DATATRANS,APAGA,SIGMVHST,SIGMVCCR,SALDO,TRANSFEREC,CADCLIENTES")
                    loc_lValido = .F.
                ENDIF
            ELSE
                IF !INLIST(loc_cCProcs, "INSERIR", "COPIA", "APAGA", "ATUALIZA", "TRANSFERE", ;
                        "BAIXA VALPAGS", "SITUCHDEV", "INTERATIVO", "CURSOR", "COMANDO", ;
                        "ETIQUETA", "EXCLUSIVO", "TRANSF ETQ", "ATUACPF")
                    MsgAviso("Os Processos V" + CHR(225) + "lidos s" + CHR(227) + "o: INSERIR,COPIA,APAGA,ATUALIZA,TRANSFERE,TRANSF ETQ, " + CHR(13) + ;
                        "BAIXA VALPAGS,SITUCHDEV,ETIQUETA,INTERATIVO,EXCLUSIVO,CURSOR,COMANDO ")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        *-- getCProcs.Valid / getTps.Valid: COMPLEMENTO/COMPLECLI exige codigo LETRA (A-Z)
        IF loc_lValido AND INLIST(loc_cCProcs, "COMPLEMENTO", "COMPLECLI")
            IF EMPTY(loc_cTps) OR ASC(loc_cTps) < 65 OR ASC(loc_cTps) > 90
                MsgAviso("C" + CHR(243) + "digo do Transporte deve ser Letra")
                loc_lValido = .F.
            ENDIF
        ENDIF

        *-- getCProcs.Valid: ATUACPF somente para o arquivo SigCdCli
        IF loc_lValido AND loc_cCProcs = "ATUACPF" AND UPPER(loc_cDbf) != "SIGCDCLI"
            MsgAviso("Tipo AtuaCpf " + CHR(233) + " utilizado somente para o Arquivo SigCdCli !!!")
            loc_lValido = .F.
        ENDIF

        *-- Salva.Click: verifica duplicidade (TpTrans+Tps+RecTrans+CProcs), exceto o proprio registro
        IF loc_lValido
            IF THIS.VerificarDuplicidade(THIS.this_cTpTrans, loc_cTps, loc_cRecTrans, loc_cCProcs, THIS.this_cIdChaves)
                MsgAviso("C" + CHR(243) + "digo do Transporte J" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Verifica se ja existe outro registro com a
    * mesma combinacao TpTrans+Tps+RecTrans+CProcs (Salva.Click - LocalTron)
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cTpTrans, par_cTps, par_cRecTrans, par_cCProcs, par_cIdChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigPrTro" + ;
                " WHERE tptrans = "  + EscaparSQL(par_cTpTrans) + ;
                " AND tps = "        + EscaparSQL(par_cTps) + ;
                " AND rectrans = "   + EscaparSQL(par_cRecTrans) + ;
                " AND cprocs = "     + EscaparSQL(par_cCProcs) + ;
                " AND cidchaves <> " + EscaparSQL(par_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkTro")
                SELECT cursor_4c_ChkTro
                loc_lExiste = (cursor_4c_ChkTro.qtd > 0)
                USE IN cursor_4c_ChkTro
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "TPRBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrTro
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- cidchaves e a PK fisica da tabela (Legado: "Replace cIdChaves With fUniqueIds()" no Salva.Click/INSERIR)
            THIS.this_cIdChaves = LEFT(fUniqueIds(), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTro (cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, ordems, indice, chave, comparacao, fotos)
                VALUES (
                    <<EscaparSQL(THIS.this_cIdChaves)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cRecTrans)>>,
                    <<EscaparSQL(THIS.this_cDbf)>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<EscaparSQL(THIS.this_cCProcs)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    <<EscaparSQL(THIS.this_cIndice)>>,
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<EscaparSQL(THIS.this_cComparacao)>>,
                    <<FormatarNumeroSQL(THIS.this_nFotos, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPRBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrTro
    * (tptrans e cidchaves nao sao alterados - Legado nao os reatribui no ALTERAR)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTro
                SET tps        = <<EscaparSQL(THIS.this_cTps)>>,
                    rectrans   = <<EscaparSQL(THIS.this_cRecTrans)>>,
                    dbf        = <<EscaparSQL(THIS.this_cDbf)>>,
                    obs        = <<EscaparSQL(THIS.this_cObs)>>,
                    cprocs     = <<EscaparSQL(THIS.this_cCProcs)>>,
                    ordems     = <<FormatarNumeroSQL(THIS.this_nOrdems, 0)>>,
                    indice     = <<EscaparSQL(THIS.this_cIndice)>>,
                    chave      = <<EscaparSQL(THIS.this_cChave)>>,
                    comparacao = <<EscaparSQL(THIS.this_cComparacao)>>,
                    fotos      = <<FormatarNumeroSQL(THIS.this_nFotos, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cIdChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPRBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrTro
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTro WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TPRBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados (colunas exibidas na Grade da Page1)
    * Legado: "Select * From SigPrTro Where TpTrans = ? Order BY RecTrans,Tps,ordems"
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), tptrans C(6), tps C(1), ;
                        rectrans C(1), dbf C(8), obs C(40), cprocs C(15), indice C(15), ;
                        ordems N(2,0), fotos N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, indice, ordems, fotos" + ;
                    " FROM SigPrTro"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY rectrans, tps, ordems"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar subtipos de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TPRBO.Buscar")
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
            loc_cSQL = "SELECT cidchaves, tptrans, tps, rectrans, dbf, obs, cprocs, ordems, indice, chave, comparacao, fotos" + ;
                " FROM SigPrTro WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Subtipo de Transporte n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar subtipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TPRBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
