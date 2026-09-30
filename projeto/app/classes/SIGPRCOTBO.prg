*====================================================================
* SIGPRCOTBO.prg
*
* Business Object para Cotacao de Moeda (grade de cotacoes por data/hora)
* Tabela: SigCdCot
* Herda de: BusinessBase
*
* Este BO atende um form OPERACIONAL do tipo dialogo modal filho: eh
* aberto a partir do cadastro de Moedas (FormMoe) para uma unica moeda
* (par_cMoeda), e gerencia uma grade de cotacoes (data + hora + valor)
* dessa moeda. Nao segue o padrao CRUD de registro unico.
*====================================================================

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCot)
    this_cCidChaves     = ""    && cidchaves char(20) - PK (fUniqueIds())
    this_cMoeda         = ""    && cmoes char(3) - codigo da moeda (FK SigCdMoe)
    this_dData          = {}    && datas datetime - data da cotacao
    this_cHora          = ""    && horas char(8) - hora da cotacao
    this_nValor         = 0     && valos numeric(11,6) - valor da cotacao
    this_dDataAlteracao = {}    && dtalts datetime - data da ultima alteracao
    this_cUsuario       = ""    && usuars char(10) - usuario que gravou

    *-- Contexto do dialogo (moeda para a qual as cotacoes sao filtradas)
    this_cMoedaFiltro   = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCot"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRCOTBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor de cotacoes (mesma estrutura de SigCdCot)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidChaves     = ALLTRIM(TratarNulo(cidchaves, ""))
            THIS.this_cMoeda         = ALLTRIM(TratarNulo(cmoes, ""))
            THIS.this_dData          = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_cHora          = ALLTRIM(TratarNulo(horas, ""))
            THIS.this_nValor         = TratarNulo(valos, 0)
            THIS.this_dDataAlteracao = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_cUsuario       = ALLTRIM(TratarNulo(usuars, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Carrega as cotacoes de uma moeda em cursor_4c_Dados
    * Espelha "Select * From CrSigCdCot Into Cursor TmpCot ReadWrite" do
    * Init legado (a query que abastece a grade do dialogo), incluindo os
    * dois indices que o Init cria sobre o cursor de trabalho (CidChaves -
    * usado pelo Excluir/localizacao por linha - e Cotacaos - usado pelo
    * Incluir/Sair para checar duplicidade e ordenar a grade).
    *====================================================================
    PROCEDURE Buscar(par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cMoeda
        loc_lSucesso = .F.
        loc_cMoeda   = IIF(VARTYPE(par_cMoeda) = "C", ALLTRIM(par_cMoeda), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, cmoes, datas, horas, valos, dtalts, usuars
                FROM SigCdCot
                WHERE cmoes = <<EscaparSQL(loc_cMoeda)>>
                ORDER BY cmoes, datas, horas
            ENDTEXT

            *-- A grade tem 3 colunas EDITAVEIS (data/cotacao/hora) - SQLEXEC
            *-- cria cursor SOMENTE-LEITURA, entao o resultado eh copiado para
            *-- um cursor READWRITE (CLAUDE.md: "Grid com coluna editavel
            *-- exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON cidchaves TAG CidChaves
                INDEX ON cmoes + DTOS(datas) + horas TAG Cotacaos

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar cota" + CHR(231) + CHR(227) + "oes:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SIGPRCOTBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere nova cotacao na tabela SigCdCot
    * Espelha SIGPRCOT.inserir.Click do legado: gera cidchaves, grava
    * data/hora/usuario de alteracao no momento da inclusao.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            THIS.this_dDataAlteracao = DATE()
            THIS.this_cUsuario       = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuario)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCot (cmoes, datas, horas, valos, cidchaves, dtalts, usuars)
                VALUES (
                    <<EscaparSQL(ALLTRIM(THIS.this_cMoeda))>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<EscaparSQL(THIS.this_cHora)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 6)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    <<EscaparSQL(THIS.this_cUsuario)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SIGPRCOTBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza cotacao existente na tabela SigCdCot
    * Espelha SIGPRCOT.sair.Click do legado (sincronizacao datas/horas/
    * valos do cursor de edicao para a tabela), atualizando tambem o
    * carimbo de data/usuario da alteracao.
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDataAlteracao = DATE()
            THIS.this_cUsuario       = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                gc_4c_UsuarioLogado, THIS.this_cUsuario)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCot
                SET datas  = <<FormatarDataSQL(THIS.this_dData)>>,
                    horas  = <<EscaparSQL(THIS.this_cHora)>>,
                    valos  = <<FormatarNumeroSQL(THIS.this_nValor, 6)>>,
                    dtalts = <<FormatarDataSQL(THIS.this_dDataAlteracao)>>,
                    usuars = <<EscaparSQL(THIS.this_cUsuario)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SIGPRCOTBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui cotacao da tabela SigCdCot
    * Espelha SIGPRCOT.delete.Click do legado (Delete From SigCdCot
    * Where cidchaves = ...).
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "Registro sem chave para exclus" + CHR(227) + "o."
            ELSE
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    DELETE FROM SigCdCot
                    WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SIGPRCOTBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
