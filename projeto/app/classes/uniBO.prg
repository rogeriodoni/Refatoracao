*====================================================================
* uniBO.prg
*
* Business Object para Cadastro de Unidades
* Tabela: SigCdUni
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS uniBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUni)
    this_cCodigo                      = ""    && cunis char(3) - PK
    this_cDescricao                   = ""    && dunis char(20)
    this_cEtiquetaIndividual          = ""    && etiqs char(1) - S/N
    this_cPerguntaQtdEtiq             = ""    && pqtds char(1) - S/N
    this_nDistribuicao                = 0     && distribs numeric(1,0) - 1=Movimentacao 2=Preco Atual
    this_cPreenchePeso                = ""    && ppesos char(1) - S/N
    this_cQtdDesmembrada              = ""    && desmembs char(1) - S/N
    this_cControleEstoque             = ""    && cestos char(1) - 1/2/3
    this_nFatorConversaoGR            = 0     && fators numeric(7,4)
    this_nFatorDivisorCT              = 0     && fatdivs numeric(5,2)
    this_nPercCustoVendaQtde          = 0     && pcustvens numeric(5,2)
    this_cPesoIgualQtde               = ""    && qtequalps char(1) - S/N
    this_cMedicaoTempo                = ""    && medtmps char(1) - S/N
    this_nEtiquetaDuplicada           = 0     && etiqdups numeric(1,0) - checkbox
    this_nNaoRecalculaQtde            = 0     && recqtd numeric(1,0) - checkbox
    this_cBloqueiaQtdFracionada       = ""    && blqqtdfrac char(1) - S/N
    this_nNaoImprimeEtiquetaCadProduto = 0    && etiqcdpro numeric(1,0) - checkbox

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUni"
            THIS.this_cCampoChave = "cunis"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "uniBO.Init")
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
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo                      = TratarNulo(cunis,      "C")
                THIS.this_cDescricao                   = TratarNulo(dunis,      "C")
                THIS.this_cEtiquetaIndividual           = TratarNulo(etiqs,     "C")
                THIS.this_cPerguntaQtdEtiq              = TratarNulo(pqtds,     "C")
                THIS.this_nDistribuicao                 = TratarNulo(distribs,  "N")
                THIS.this_cPreenchePeso                 = TratarNulo(ppesos,    "C")
                THIS.this_cQtdDesmembrada                = TratarNulo(desmembs, "C")
                THIS.this_cControleEstoque              = TratarNulo(cestos,    "C")
                THIS.this_nFatorConversaoGR             = TratarNulo(fators,    "N")
                THIS.this_nFatorDivisorCT               = TratarNulo(fatdivs,   "N")
                THIS.this_nPercCustoVendaQtde           = TratarNulo(pcustvens, "N")
                THIS.this_cPesoIgualQtde                = TratarNulo(qtequalps, "C")
                THIS.this_cMedicaoTempo                 = TratarNulo(medtmps,   "C")
                THIS.this_nEtiquetaDuplicada            = TratarNulo(etiqdups,  "N")
                THIS.this_nNaoRecalculaQtde             = TratarNulo(recqtd,    "N")
                THIS.this_cBloqueiaQtdFracionada        = TratarNulo(blqqtdfrac, "C")
                THIS.this_nNaoImprimeEtiquetaCadProduto = TratarNulo(etiqcdpro, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "uniBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Transcrito do legado (Grupo_Salva.Salva.Click, ramos INSERIR/ALTERAR):
    * Unidade e Descricao obrigatorios; Unidade duplicada so bloqueia na INCLUSAO
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "Unidade n" + CHR(227) + "o pode ficar em branco!"
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                THIS.this_cMensagemErro = "Unidade j" + CHR(225) + " Cadastrada!"
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o pode ficar em branco."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se a unidade ja existe no banco
    * Transcrito do legado: ChkRegister('SigCdUni','cunis', valor)
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdUni" + ;
                " WHERE cunis = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar Unidade:" + CHR(13) + loException.Message, "uniBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUni
    * NOTA: acimas, abaixos, ftconvuns, descuni, etiqref, impdesc sao
    * colunas NOT NULL sem controle correspondente no form legado
    * (nao referenciadas em nenhum lugar do codigo fonte original) -
    * gravadas com 0 (CLAUDE.md regra #22)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUni (
                    cunis, dunis, etiqs, pqtds, distribs, ppesos, desmembs,
                    cestos, fators, fatdivs, pcustvens, qtequalps, medtmps,
                    etiqdups, recqtd, blqqtdfrac, etiqcdpro,
                    acimas, abaixos, ftconvuns, descuni, etiqref, impdesc
                )
                VALUES (
                    <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cEtiquetaIndividual)>>,
                    <<EscaparSQL(THIS.this_cPerguntaQtdEtiq)>>,
                    <<FormatarNumeroSQL(THIS.this_nDistribuicao, 0)>>,
                    <<EscaparSQL(THIS.this_cPreenchePeso)>>,
                    <<EscaparSQL(THIS.this_cQtdDesmembrada)>>,
                    <<EscaparSQL(THIS.this_cControleEstoque)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatorConversaoGR, 4)>>,
                    <<FormatarNumeroSQL(THIS.this_nFatorDivisorCT, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercCustoVendaQtde, 2)>>,
                    <<EscaparSQL(THIS.this_cPesoIgualQtde)>>,
                    <<EscaparSQL(THIS.this_cMedicaoTempo)>>,
                    <<FormatarNumeroSQL(THIS.this_nEtiquetaDuplicada, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNaoRecalculaQtde, 0)>>,
                    <<EscaparSQL(THIS.this_cBloqueiaQtdFracionada)>>,
                    <<FormatarNumeroSQL(THIS.this_nNaoImprimeEtiquetaCadProduto, 0)>>,
                    <<FormatarNumeroSQL(0, 3)>>,
                    <<FormatarNumeroSQL(0, 3)>>,
                    <<FormatarNumeroSQL(0, 2)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(0, 0)>>,
                    <<FormatarNumeroSQL(0, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "uniBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUni
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUni
                SET dunis      = <<EscaparSQL(THIS.this_cDescricao)>>,
                    etiqs      = <<EscaparSQL(THIS.this_cEtiquetaIndividual)>>,
                    pqtds      = <<EscaparSQL(THIS.this_cPerguntaQtdEtiq)>>,
                    distribs   = <<FormatarNumeroSQL(THIS.this_nDistribuicao, 0)>>,
                    ppesos     = <<EscaparSQL(THIS.this_cPreenchePeso)>>,
                    desmembs   = <<EscaparSQL(THIS.this_cQtdDesmembrada)>>,
                    cestos     = <<EscaparSQL(THIS.this_cControleEstoque)>>,
                    fators     = <<FormatarNumeroSQL(THIS.this_nFatorConversaoGR, 4)>>,
                    fatdivs    = <<FormatarNumeroSQL(THIS.this_nFatorDivisorCT, 2)>>,
                    pcustvens  = <<FormatarNumeroSQL(THIS.this_nPercCustoVendaQtde, 2)>>,
                    qtequalps  = <<EscaparSQL(THIS.this_cPesoIgualQtde)>>,
                    medtmps    = <<EscaparSQL(THIS.this_cMedicaoTempo)>>,
                    etiqdups   = <<FormatarNumeroSQL(THIS.this_nEtiquetaDuplicada, 0)>>,
                    recqtd     = <<FormatarNumeroSQL(THIS.this_nNaoRecalculaQtde, 0)>>,
                    blqqtdfrac = <<EscaparSQL(THIS.this_cBloqueiaQtdFracionada)>>,
                    etiqcdpro  = <<FormatarNumeroSQL(THIS.this_nNaoImprimeEtiquetaCadProduto, 0)>>
                WHERE cunis = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "uniBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUni
    * Transcrito do legado (Salva.Click, ramo EXCLUIR): bloqueia exclusao
    * se a Unidade estiver em uso em SigCdPro.cunis, SigCdGrp.cunips
    * ou referenciada na posicao 11-13 de SigCdGrp.cfggergprs
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUsoProduto, loc_nUsoGrupo
        loc_lSucesso    = .F.
        loc_nUsoProduto = 0
        loc_nUsoGrupo   = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nUso FROM SigCdPro" + ;
                " WHERE cunis = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nUsoProduto = NVL(cursor_4c_ChkPro.nUso, 0)
                    USE IN cursor_4c_ChkPro
                ENDIF

                IF loc_nUsoProduto > 0
                    THIS.this_cMensagemErro = "Existe Produto Cadastrado com essa Unidade!"
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT COUNT(*) AS nUso FROM SigCdGrp
                        WHERE cunips = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
                           OR SUBSTRING(cfggergprs, 11, 3) = <<EscaparSQL(ALLTRIM(THIS.this_cCodigo))>>
                    ENDTEXT
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_ChkGrp")
                            SELECT cursor_4c_ChkGrp
                            loc_nUsoGrupo = NVL(cursor_4c_ChkGrp.nUso, 0)
                            USE IN cursor_4c_ChkGrp
                        ENDIF

                        IF loc_nUsoGrupo > 0
                            THIS.this_cMensagemErro = "Existe Um Grupo de Produto Cadastrado com essa Unidade!"
                        ELSE
                            loc_cSQL = "DELETE FROM SigCdUni WHERE cunis = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado >= 0
                                THIS.RegistrarAuditoria("DELETE")
                                loc_lSucesso = .T.
                            ELSE
                                MostrarErro("Erro ao excluir unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "uniBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com as colunas da grade do legado
    * (cunis "Unidade", dunis "Descricao" - PROCEDURE Init/AddCursor)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cunis C(3), dunis C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cunis, dunis FROM SigCdUni"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cunis"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar unidades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "uniBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cunis)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cunis, dunis, etiqs, pqtds, distribs, ppesos, desmembs,
                    cestos, fators, fatdivs, pcustvens, qtequalps, medtmps,
                    etiqdups, recqtd, blqqtdfrac, etiqcdpro
                FROM SigCdUni
                WHERE cunis = <<EscaparSQL(ALLTRIM(par_cCodigo))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Unidade n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar unidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "uniBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
