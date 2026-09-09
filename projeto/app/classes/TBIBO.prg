*==============================================================================
* TBIBO.PRG
* Business Object - Tabelas de Referencia (Impressao de Tabela de Cambio)
* Baseado no formulario legado SIGCDTBI (Relatorio de Tabelas de Referencia)
* Camada: BusinessBase (regras de negocio) -> DataAccess (SQL Server)
*==============================================================================

DEFINE CLASS TBIBO AS BusinessBase

    *-- Propriedades principais (espelham os campos do formulario original)
    this_cMoeda            = ""    && Codigo da moeda de referencia (SigCdMoe.Cmoes)
    this_cMoedaDescricao   = ""    && Descricao da moeda de referencia (SigCdMoe.Dmoes)
    this_nCopias           = 1     && Quantidade de copias da impressao
    this_cConteudoRelatorio = ""   && Texto pronto para impressao (montado por GerarTabelaReferencia)
    this_cMensagemErro     = ""    && Mensagem de erro/aviso preenchida por GerarTabelaReferencia/Inserir/Atualizar

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdMoe")

        THIS.this_cCampoChave = "Cmoes"

        THIS.this_cMoeda = ""
        THIS.this_cMoedaDescricao = ""
        THIS.this_nCopias = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o codigo/descricao da moeda de referencia
    * a partir de um cursor resultante de SELECT em SigCdMoe (cmoes, dmoes),
    * espelhando o retorno do fwBuscaExt('SigCdMoe', ...) do formulario
    * original (Valid de get_moeda / get_moeda_desc).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoeda          = TratarNulo(cmoes, "C")
            THIS.this_cMoedaDescricao = TratarNulo(dmoes, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo da moeda de referencia atualmente carregada
    * (usado por RegistrarAuditoria e por eventuais chamadas de Salvar/Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cMoeda)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterCotacao - Cotacao mais recente (<= par_dData) da moeda informada,
    * espelhando fBuscarCambio(ctod(''), par_dData, space(03), par_cMoeda) do
    * codigo original (cmd_ok.Click). Retorna 0 se nao houver cotacao lancada
    * para a moeda na tabela SigCdCot.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResultado
        loc_nCotacao = 0

        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN loc_nCotacao
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        loc_cSQL = "SELECT valos, datas FROM SigCdCot " + ;
                   "WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                   " ORDER BY datas DESC, horas DESC"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiCotacao")

        IF loc_nResultado > 0 AND USED("cursor_4c_TbiCotacao") AND ;
           RECCOUNT("cursor_4c_TbiCotacao") > 0
            SELECT cursor_4c_TbiCotacao
            LOCATE FOR datas <= par_dData
            IF FOUND("cursor_4c_TbiCotacao")
                loc_nCotacao = NVL(cursor_4c_TbiCotacao.valos, 0)
            ENDIF
        ENDIF

        IF USED("cursor_4c_TbiCotacao")
            USE IN cursor_4c_TbiCotacao
        ENDIF

        RETURN loc_nCotacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarTabelaReferencia - Monta o conteudo texto (THIS.this_cConteudoRelatorio)
    * da tabela de cambio das Tabelas de Referencia (SigOpTdz com Rel_Descs = 1),
    * convertidas para a moeda informada em par_cMoedaRef, espelhando a logica
    * de cmd_ok.Click do formulario original (sem a selecao de impressora de
    * etiqueta legada, que nao se aplica a arquitetura nova).
    *
    * Retorna .T. com THIS.this_cConteudoRelatorio preenchido em caso de
    * sucesso, ou .F. com THIS.this_cMensagemErro preenchido caso nao haja
    * tabelas de desconto marcadas (Rel_Descs = 1) ou ocorra falha de SQL.
    *--------------------------------------------------------------------------
    FUNCTION GerarTabelaReferencia(par_cMoedaRef)
        LOCAL loc_lSucesso, loc_cMoedaRef, loc_nCotRef, loc_cSQL, loc_nResultado
        LOCAL loc_cMoeda, loc_nCotacao, loc_lMultiplica, loc_nValorConvertido
        LOCAL loc_cConteudo, loc_cLinha, loc_lExisteImpressao, loc_oErro

        loc_lSucesso            = .F.
        loc_lExisteImpressao    = .F.
        loc_cMoedaRef           = ALLTRIM(NVL(par_cMoedaRef, ""))
        THIS.this_cMensagemErro     = ""
        THIS.this_cConteudoRelatorio = ""

        TRY
            IF USED("cursor_4c_TbiMoedas")
                USE IN cursor_4c_TbiMoedas
            ENDIF
            IF USED("cursor_4c_TbiTabelas")
                USE IN cursor_4c_TbiTabelas
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, fmults, tabrefs FROM SigCdMoe ORDER BY cmoes"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiMoedasTmp")

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao consultar Moedas (SigCdMoe)."
            ELSE
                SELECT * FROM cursor_4c_TbiMoedasTmp INTO CURSOR cursor_4c_TbiMoedas READWRITE
                IF USED("cursor_4c_TbiMoedasTmp")
                    USE IN cursor_4c_TbiMoedasTmp
                ENDIF

                loc_cSQL = "SELECT codigos, descos, descrs FROM SigOpTdz " + ;
                           "WHERE rel_descs = 1 ORDER BY codigos"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TbiTabelasTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao consultar Tabelas de " + ;
                        "Refer" + CHR(234) + "ncia (SigOpTdz)."
                ELSE
                    SELECT * FROM cursor_4c_TbiTabelasTmp INTO CURSOR cursor_4c_TbiTabelas READWRITE
                    IF USED("cursor_4c_TbiTabelasTmp")
                        USE IN cursor_4c_TbiTabelasTmp
                    ENDIF

                    IF RECCOUNT("cursor_4c_TbiTabelas") = 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                            " tabelas de desconto selecionadas para impress" + ;
                            CHR(227) + "o !"
                    ELSE
                        loc_nCotRef = THIS.ObterCotacao(loc_cMoedaRef, DATE())

                        loc_cConteudo = REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Tabelas de refer" + CHR(234) + "ncia em " + DTOC(DATE()) + CHR(13) + CHR(10) + ;
                            REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                            "Moeda de refer" + CHR(234) + "ncia: " + loc_cMoedaRef + ;
                            " (" + ALLTRIM(TRANSFORM(loc_nCotRef, "999999999.99")) + ")" + ;
                            CHR(13) + CHR(10) + CHR(13) + CHR(10)

                        SELECT cursor_4c_TbiMoedas
                        SCAN FOR ALLTRIM(cursor_4c_TbiMoedas.cmoes) <> loc_cMoedaRef ;
                                AND cursor_4c_TbiMoedas.tabrefs
                            loc_cMoeda      = ALLTRIM(cursor_4c_TbiMoedas.cmoes)
                            loc_lMultiplica = (ALLTRIM(cursor_4c_TbiMoedas.fmults) == "S")
                            loc_nCotacao    = THIS.ObterCotacao(loc_cMoeda, DATE())

                            loc_cConteudo = loc_cConteudo + "Moeda: " + loc_cMoeda + CHR(13) + CHR(10) + ;
                                PADR("Tabela", 12) + PADR("Desconto %", 14) + "Valor Convertido" + CHR(13) + CHR(10) + ;
                                REPLICATE("-", 45) + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiTabelas
                            SCAN
                                loc_lExisteImpressao = .T.
                                loc_nValorConvertido = IIF(loc_lMultiplica, ;
                                    ROUND(loc_nCotRef * loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2), ;
                                    ROUND(loc_nCotacao * (1 - (cursor_4c_TbiTabelas.descos / 100)), 2))

                                loc_cLinha = PADR(ALLTRIM(cursor_4c_TbiTabelas.codigos), 12) + ;
                                    PADR(ALLTRIM(TRANSFORM(cursor_4c_TbiTabelas.descos, "999.99")), 14) + ;
                                    ALLTRIM(TRANSFORM(loc_nValorConvertido, "999999999.99"))

                                loc_cConteudo = loc_cConteudo + loc_cLinha + CHR(13) + CHR(10)
                            ENDSCAN

                            loc_cConteudo = loc_cConteudo + CHR(13) + CHR(10)

                            SELECT cursor_4c_TbiMoedas
                        ENDSCAN

                        IF !loc_lExisteImpressao
                            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                                " tabelas de desconto selecionadas para impress" + ;
                                CHR(227) + "o !"
                        ELSE
                            THIS.this_cConteudoRelatorio = loc_cConteudo
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_TbiMoedas")
            USE IN cursor_4c_TbiMoedas
        ENDIF
        IF USED("cursor_4c_TbiTabelas")
            USE IN cursor_4c_TbiTabelas
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar - TBIBO NAO grava registros de moeda.
    *
    * O formulario original SIGCDTBI ("Relatorio de Tabelas de Referencia")
    * eh um utilitario de IMPRESSAO: ele apenas LE e VALIDA um codigo de
    * moeda ja existente em SigCdMoe (via fwBuscaExt, metodos Valid de
    * get_moeda/get_moeda_desc) para montar a tabela de cambio impressa no
    * cmd_ok.Click. Em nenhum ponto do codigo fonte original ha um INSERT
    * ou UPDATE em SigCdMoe - o cadastro/manutencao da moeda pertence
    * exclusivamente ao MoeBO/FormMoe (Cadastro de Moedas).
    *
    * Estes overrides existem para cumprir o contrato de BusinessBase e
    * bloquear, com mensagem clara, qualquer tentativa de gravacao por
    * este BO - evitando duplicar (e divergir de) a regra de negocio de
    * SigCdMoe que ja vive em MoeBO.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para incluir novos registros."
        RETURN .F.
    ENDFUNC

    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Este formul" + CHR(225) + "rio " + ;
            "n" + CHR(227) + "o cadastra moedas." + CHR(13) + ;
            "Utilize o Cadastro de Moedas para alterar registros existentes."
        RETURN .F.
    ENDFUNC

ENDDEFINE
