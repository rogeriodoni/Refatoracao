*------------------------------------------------------------------------------
* SigOpBloBO.prg - Business Object para Bloqueio de Periodo (SigSyBlq)
* Herda de: BusinessBase
* Tabela: SigSyBlq (registro unico de configuracao de bloqueio)
*------------------------------------------------------------------------------
DEFINE CLASS SigOpBloBO AS BusinessBase

    *-- Propriedades da tabela SigSyBlq
    this_cCidChaves = ""    && cidchaves  CHAR(20) NOT NULL - Chave " + CHR(250) + "nica (fUniqueIds)
    this_dDatais    = {}    && datais     DATETIME - Data inicial do per" + CHR(237) + "odo de bloqueio
    this_dDatafs    = {}    && datafs     DATETIME - Data final do per" + CHR(237) + "odo de bloqueio
    this_nDdretros  = 0     && ddretros   NUMERIC(5,0) NOT NULL - Dias retroativos de bloqueio autom" + CHR(225) + "tico
    this_nDdfutus   = 0     && ddfutus    NUMERIC(5,0) NOT NULL - Dias futuros de bloqueio autom" + CHR(225) + "tico
    this_dDtiConts  = {}    && DTICONTS   DATETIME - Data in" + CHR(237) + "cio do bloqueio cont" + CHR(225) + "bil
    this_nChkConcs  = 0     && chkconcs   NUMERIC(1,0) NOT NULL - Op" + CHR(231) + CHR(227) + "o de concilia" + CHR(231) + CHR(227) + "o (1=Checar Bloqueio,2=Liberar Data,3=Nenhum)
    this_dDtgdmis   = {}    && dtgdmis    DATETIME - Data de gera" + CHR(231) + CHR(227) + "o/modifica" + CHR(231) + CHR(227) + "o (n" + CHR(227) + "o exibido na tela)
    this_dDtgeras   = {}    && dtgeras    DATETIME - Data de gera" + CHR(231) + CHR(227) + "o do registro (n" + CHR(227) + "o exibido na tela)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigSyBlq"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarValoresPadrao - Gera a chave unica (fUniqueIds) para o
    * registro novo, igual ao legado (SIGOPBLO.Init: "Insert Into crBloqueio
    * (cIdChaves) Values (fUniqueIds())" quando o cursor vinha vazio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarValoresPadrao()
        IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarRegistroUnico - Carrega o registro UNICO de parametros de
    * bloqueio (equivalente ao AddCursor + Requery do Init legado:
    * "lcQryBloqueio = [Select * From SigSyBlq]" + ".AddCursor(...)").
    * SigSyBlq tem no maximo 1 linha (parametros globais do sistema, nao
    * filtrados por codigo digitado pelo usuario - por isso NAO ha
    * CarregarPorCodigo(codigo) como nos BOs de cadastro). PUBLIC (sem
    * PROTECTED) porque o form chama este metodo direto (regra #51).
    *
    * Retorna .T. se encontrou e carregou um registro existente (quem
    * chama decide EditarRegistro()); .F. se a tabela esta vazia -
    * primeira execucao do sistema, quem chama decide NovoRegistro(),
    * que aciona InicializarValoresPadrao() (gera o fUniqueIds()).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarRegistroUnico()
        LOCAL loc_cSQL, loc_lResultado, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 cidchaves, datais, datafs, ddretros, " + ;
                "ddfutus, DtiConts, chkconcs, dtgdmis, dtgeras FROM SigSyBlq"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar par" + CHR(226) + "metros de bloqueio:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros de bloqueio:" + ;
                CHR(13) + loc_oErro.Message, "SigOpBloBO.CarregarRegistroUnico")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Get_datfin.Valid do legado, repetido aqui como
    * ultimo portao antes de gravar (o campo ja valida no LostFocus -
    * FormSigOpBlo.DatfinLostFocus - mas guards de regra de negocio
    * fazem parte da formula, regra #17, e tem de sobreviver mesmo se
    * o usuario nunca passar pelo campo em tela):
    *
    *   If (This.Value < Thisform.get_datini.Value)
    *       =Messagebox('Entrada Invalida!!!', 0+48, '')
    *       Return 0
    *   EndIf
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF THIS.this_dDatafs < THIS.this_dDatais
            THIS.this_cMensagemErro = "Entrada Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    * REGRA CRITICA: 2o argumento de TratarNulo eh o VALOR padrao do TIPO da
    * coluna ("" / 0 / {}), NUNCA o codigo de tipo "C"/"N"/"D"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_dDatais    = TratarNulo(datais,    {})
                THIS.this_dDatafs    = TratarNulo(datafs,    {})
                THIS.this_nDdretros  = TratarNulo(ddretros,  0)
                THIS.this_nDdfutus   = TratarNulo(ddfutus,   0)
                THIS.this_dDtiConts  = TratarNulo(DtiConts,  {})
                THIS.this_nChkConcs  = TratarNulo(chkconcs,  0)
                THIS.this_dDtgdmis   = TratarNulo(dtgdmis,   {})
                THIS.this_dDtgeras   = TratarNulo(dtgeras,   {})
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpBloBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere o registro unico de parametros de bloqueio em SigSyBlq
    * Cobre TODAS as colunas NOT NULL (cidchaves, ddretros, ddfutus, chkconcs)
    * dtgeras/dtgdmis sao colunas internas de auditoria (nao exibidas na
    * tela, conforme Fase 1) - gravadas com GETDATE() na inclusao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigSyBlq (cidchaves, datais, datafs, ddretros, ddfutus,
                    DtiConts, chkconcs, dtgdmis, dtgeras)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<FormatarDataSQL(THIS.this_dDatais)>>,
                    <<FormatarDataSQL(THIS.this_dDatafs)>>,
                    <<FormatarNumeroSQL(THIS.this_nDdretros, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDdfutus, 0)>>,
                    <<FormatarDataSQL(THIS.this_dDtiConts)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkConcs, 0)>>,
                    GETDATE(),
                    GETDATE()
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir par" + CHR(226) + "metros de bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpBloBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro unico de parametros de bloqueio
    * dtgdmis (data de modificacao) eh sempre regravada com GETDATE();
    * dtgeras (data de geracao original) nunca eh tocada no UPDATE
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigSyBlq
                SET datais    = <<FormatarDataSQL(THIS.this_dDatais)>>,
                    datafs    = <<FormatarDataSQL(THIS.this_dDatafs)>>,
                    ddretros  = <<FormatarNumeroSQL(THIS.this_nDdretros, 0)>>,
                    ddfutus   = <<FormatarNumeroSQL(THIS.this_nDdfutus, 0)>>,
                    DtiConts  = <<FormatarDataSQL(THIS.this_dDtiConts)>>,
                    chkconcs  = <<FormatarNumeroSQL(THIS.this_nChkConcs, 0)>>,
                    dtgdmis   = GETDATE()
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar par" + CHR(226) + "metros de bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpBloBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
