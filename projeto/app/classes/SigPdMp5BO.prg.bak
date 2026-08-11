*==============================================================================
* SigPdMp5BO.prg - Business Object para Movimenta" + CHR(231) + CHR(227) + "o (OPERACIONAL)
* Data: 2026-06-19
* Form auxiliar (sub-dialog) aberto pelo form pai de movimenta" + CHR(231) + CHR(227) + "o de produ" + CHR(231) + CHR(227) + "o.
* Cursor principal: xMFas (grid de linhas de fabrica" + CHR(231) + CHR(227) + "o)
* Cursores auxiliares: xPesa, crSigCdOpd, crSigCdPro, crSigCdCli, TmpNens
*==============================================================================

DEFINE CLASS SigPdMp5BO AS BusinessBase

    *-- Linha selecionada no grid (xMFas)
    this_nNops    = 0     && xMfas.Nops     - N" + CHR(250) + "mero da industrializa" + CHR(231) + CHR(227) + "o (PK da linha)
    this_nNenvs   = 0     && xMfas.Nenvs    - N" + CHR(250) + "mero do pedido/envio
    this_nQtds    = 0     && xMfas.Qtds     - Quantidade
    this_cCodPds  = ""    && xMfas.CodPds   - C" + CHR(243) + "digo do produto
    this_nTmpMins = 0     && xMfas.TmpMins  - Tempo em minutos
    this_cObsps   = ""    && xMfas.obsps    - Observa" + CHR(231) + CHR(227) + "o da linha

    *-- Opera" + CHR(231) + CHR(227) + "o corrente (cursor TmpNens - container Opera" + CHR(231) + CHR(227) + "o)
    this_cEmps   = ""     && tmpnens.emps   - Empresa
    this_cDopps  = ""     && tmpnens.dopps  - Descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNumps  = 0      && tmpnens.numps  - N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o

    *-- Contas de origem (cursor TmpNens - container Origem)
    this_cGrupoos = ""    && tmpnens.grupoos - Grupo da conta de origem
    this_cContaos = ""    && tmpnens.contaos - Conta de origem

    *-- Contas de destino (cursor TmpNens - container Destino)
    this_cGrupods = ""    && tmpnens.grupods - Grupo da conta de destino
    this_cContads = ""    && tmpnens.contads - Conta de destino

    *-- Valores derivados/display (n" + CHR(227) + "o persistidos)
    this_cDcontaOs = ""   && crSigCdCli.Rclis para conta de origem
    this_cDcontaDs = ""   && crSigCdCli.Rclis para conta de destino
    this_cDpros    = ""   && crSigCdPro.Dpros  - Descri" + CHR(231) + CHR(227) + "o do produto
    this_cFigJpgs  = ""   && crSigCdPro.FigJpgs - Figura base64 do produto
    this_nTotQt    = 0    && Soma de xMfas.Qtds (exibida em TotQt)

    *-- Flags de estado derivados de crSigCdOpd
    this_nImagems  = 0    && crSigCdOpd.Imagems  - Exibir imagem do produto (0/1)
    this_nOrigems  = 0    && crSigCdOpd.Origems  - Exibir container Origem (0/1)
    this_nDestinos = 0    && crSigCdOpd.Destinos - Exibir container Destino (0/1)
    this_nApontas  = 0    && crSigCdOpd.apontas  - Column5 (TmpMins) edit" + CHR(225) + "vel (0/1)

    *-- Contexto do form pai
    this_cPcEscolha    = ""  && pcEscolha do form pai (INSERIR/ALTERAR/VISUALIZAR)
    this_cTipoSubNivel = ""  && TipoSubNivel do form pai (ex: 'ENV')

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega linha selecionada do grid (xMFas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops    = TratarNulo(Nops,    "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cCodPds  = TratarNulo(CodPds,  "C")
                THIS.this_nTmpMins = TratarNulo(TmpMins, "N")
                THIS.this_cObsps   = TratarNulo(obsps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linha do grid:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega dados de opera" + CHR(231) + CHR(227) + "o do cursor TmpNens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps   = TratarNulo(emps,   "C")
                THIS.this_cDopps  = TratarNulo(dopps,  "C")
                THIS.this_nNumps  = TratarNulo(numps,  "N")
                THIS.this_cGrupoos = TratarNulo(grupoos, "C")
                THIS.this_cContaos = TratarNulo(contaos, "C")
                THIS.this_cGrupods = TratarNulo(grupods, "C")
                THIS.this_cContads = TratarNulo(contads, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFlagsOperacao - Carrega flags de visibilidade do crSigCdOpd
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFlagsOperacao(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF VARTYPE(Imagems) = "N"
                    THIS.this_nImagems = NVL(Imagems, 0)
                ELSE
                    THIS.this_nImagems = IIF(NVL(Imagems, .F.), 1, 0)
                ENDIF
                IF VARTYPE(Origems) = "N"
                    THIS.this_nOrigems = NVL(Origems, 0)
                ELSE
                    THIS.this_nOrigems = IIF(NVL(Origems, .F.), 1, 0)
                ENDIF
                IF VARTYPE(Destinos) = "N"
                    THIS.this_nDestinos = NVL(Destinos, 0)
                ELSE
                    THIS.this_nDestinos = IIF(NVL(Destinos, .F.), 1, 0)
                ENDIF
                IF VARTYPE(apontas) = "N"
                    THIS.this_nApontas = NVL(apontas, 0)
                ELSE
                    THIS.this_nApontas = IIF(NVL(apontas, .F.), 1, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar flags:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarFlagsOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoProduto - Busca descri" + CHR(231) + CHR(227) + "o e imagem do produto via SQLEXEC
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoProduto(par_cCodPds)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDpros   = ""
            THIS.this_cFigJpgs = ""

            IF EMPTY(par_cCodPds)
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro" + ;
                       " WHERE CPros = " + EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_ProdInfo")
                USE IN cursor_4c_ProdInfo
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")

            IF loc_nRet > 0 AND !EOF("cursor_4c_ProdInfo")
                SELECT cursor_4c_ProdInfo
                THIS.this_cDpros   = TratarNulo(DPros,   "C")
                THIS.this_cFigJpgs = TratarNulo(FigJpgs, "C")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ProdInfo")
                USE IN cursor_4c_ProdInfo
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar produto:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.BuscarDescricaoProduto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNomeConta - Busca raz" + CHR(227) + "o social do cliente/conta via SQLEXEC
    * par_cContaId: c" + CHR(243) + "digo da conta (IClis)
    * par_cTipo: "O" para Origem, "D" para Destino
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNomeConta(par_cContaId, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cNome
        loc_lSucesso = .F.

        TRY
            loc_cNome = ""

            IF !EMPTY(par_cContaId)
                loc_cSQL = "SELECT RClis FROM SigCdCli" + ;
                           " WHERE IClis = " + EscaparSQL(par_cContaId)

                IF USED("cursor_4c_ContaInfo")
                    USE IN cursor_4c_ContaInfo
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaInfo")

                IF loc_nRet > 0 AND !EOF("cursor_4c_ContaInfo")
                    SELECT cursor_4c_ContaInfo
                    loc_cNome = TratarNulo(RClis, "C")
                ENDIF

                IF USED("cursor_4c_ContaInfo")
                    USE IN cursor_4c_ContaInfo
                ENDIF
            ENDIF

            IF UPPER(par_cTipo) = "O"
                THIS.this_cDcontaOs = loc_cNome
            ELSE
                THIS.this_cDcontaDs = loc_cNome
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar conta:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.BuscarNomeConta")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularTotalQtds - Soma Qtds do cursor xMFas e armazena em this_nTotQt
    *--------------------------------------------------------------------------
    PROCEDURE CalcularTotalQtds(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_nTotal
        loc_lSucesso = .F.

        TRY
            loc_nTotal = 0

            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                SUM Qtds TO loc_nTotal
                THIS.this_nTotQt = loc_nTotal
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao calcular total:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CalcularTotalQtds")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarQtdPesa - Atualiza Qtds em xPesa para o Nops corrente
    * Replicado do legado: SEEK(xMFas.Nops, 'xPesa', 'Nops') + REPLACE Qtds
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarQtdPesa(par_nNops, par_nQtds)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("xPesa")
                IF SEEK(par_nNops, "xPesa", "Nops")
                    REPLACE xPesa.Qtds WITH par_nQtds IN xPesa
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar pesagem:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.AtualizarQtdPesa")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave da linha atual (Nops)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNops)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de aplicar altera" + CHR(231) + CHR(245) + "es no cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF THIS.this_nQtds < 0
            THIS.this_cErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - N" + CHR(227) + "o aplic" + CHR(225) + "vel neste sub-dialog.
    * As linhas de xMFas s" + CHR(227) + "o pr" + CHR(233) + "-carregadas pelo form pai; este dialog
    * apenas exibe e permite edi" + CHR(231) + CHR(227) + "o de Qtds/TmpMins. A persist" + CHR(234) + "ncia
    * no SQL Server " + CHR(233) + " responsabilidade do form pai ao fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("I")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Sincroniza xPesa com a quantidade editada em xMFas
    * Replicado da l" + CHR(243) + "gica do legado: Column3.Text1.Valid fazia SEEK+REPLACE
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.AtualizarQtdPesa(THIS.this_nNops, THIS.this_nQtds)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("A")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar quantidade:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
