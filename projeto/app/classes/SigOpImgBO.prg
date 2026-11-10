*====================================================================
* SigOpImgBO.prg
*
* Business Object para Captura de Imagens de Produtos
* Tabela principal: SigCdPro
* Herda de: BusinessBase
*
* Origem: SigOpImg.SCX (Framework legado Fortyus)
* Form OPERACIONAL - selecao de produtos por filtro (periodo de
* inclusao, grupo, produto, linha, situacao de imagem) + captura/
* visualizacao/exclusao da imagem (FigJpgs) do produto selecionado.
*====================================================================

DEFINE CLASS SigOpImgBO AS BusinessBase

    *-- Propriedades de FILTRO (tela de selecao - optImagem/getDtIni/
    *-- getDtFin/getGrupo/getDGrupo/getCProsF/getDProsF/getLin/getDLin)
    this_dDataIni           = {}    && getDtIni.Value  - periodo de inclusao (data inicial)
    this_dDataFin           = {}    && getDtFin.Value  - periodo de inclusao (data final)
    this_nTipoImagem        = 0     && optImagem.Value - 1=Sem Imagem, 2=Com Imagem, 3=Geral
    this_cGrupoFiltro       = ""    && getGrupo.Value    - cgrus char(3) do filtro
    this_cDescGrupoFiltro   = ""    && getDGrupo.Value   - descricao do grupo filtro (SigCdGrp.dgrus)
    this_cProdutoFiltro     = ""    && getCProsF.Value   - cpros char(14) do filtro
    this_cDescProdutoFiltro = ""    && getDProsF.Value   - descricao do produto filtro (dpros)
    this_cLinhaFiltro       = ""    && getLin.Value      - linhas char(10) do filtro
    this_cDescLinhaFiltro   = ""    && getDLin.Value     - descricao da linha filtro (SigCdLin.descs)

    *-- Propriedades do PRODUTO CORRENTE (linha selecionada na grade,
    *-- originadas de SigCdPro/cursor de listagem csProdutos)
    this_cCodProduto     = ""    && cpros char(14) - PK
    this_cDescProduto    = ""    && dpros char(65) (65 no banco, 40 no cursor legado de listagem)
    this_cCodFornecedor  = ""    && ifors char(10)
    this_cReferencia     = ""    && reffs char(40)
    this_cCodGrupo       = ""    && cgrus char(3)
    this_cCodLinha       = ""    && linhas char(10)
    this_cImagemBase64   = ""    && figjpgs text (memo) - imagem em base64/binario
    this_dDataFilme      = {}    && dtfilms datetime - data/hora da ultima transferencia de imagem
    this_dDataInclusao   = {}    && dtincs  datetime - data de inclusao do produto
    this_dData           = {}    && datas   datetime - data da ultima alteracao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades do PRODUTO CORRENTE a
    * partir de um cursor posicionado em SigCdPro (SELECT * ou lista de
    * colunas equivalente ao csProdutos do legado: DtFilms, DtIncs,
    * Datas, CPros, DPros, IFors, Reffs, CGrus, Linhas, FigJpgs)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodProduto    = ALLTRIM(TratarNulo(cpros, ""))
        THIS.this_cDescProduto   = ALLTRIM(TratarNulo(dpros, ""))
        THIS.this_cCodFornecedor = ALLTRIM(TratarNulo(ifors, ""))
        THIS.this_cReferencia    = ALLTRIM(TratarNulo(reffs, ""))
        THIS.this_cCodGrupo      = ALLTRIM(TratarNulo(cgrus, ""))
        THIS.this_cCodLinha      = ALLTRIM(TratarNulo(linhas, ""))
        THIS.this_cImagemBase64  = TratarNulo(figjpgs, "")
        THIS.this_dDataFilme     = ConverterParaData(TratarNulo(dtfilms, {}))
        THIS.this_dDataInclusao  = ConverterParaData(TratarNulo(dtincs, {}))
        THIS.this_dData          = ConverterParaData(TratarNulo(datas, {}))

        RETURN .T.
    ENDPROC

    *====================================================================
    * ValidarDados - Valida o produto corrente antes de atualizar a
    * imagem (coluna FigJpgs de SigCdPro)
    *====================================================================
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodProduto))
            THIS.this_cMensagemErro = "Nenhum produto selecionado para atualizar a imagem."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do produto corrente (cpros)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodProduto, ""))
    ENDPROC

    *====================================================================
    * Atualizar - Grava a imagem (FigJpgs) do produto corrente em
    * SigCdPro, atualizando tambem DtFilms (data da transferencia) e
    * Datas (data da ultima alteracao). Reproduz o Update/Commit feito
    * pelo legado apos CmdgFigura.Valid (capturar imagem) e apos a
    * opcao de imagem em branco - as duas acoes sao a MESMA gravacao,
    * apenas com this_cImagemBase64 vazio ou preenchido.
    *
    * Este formulario (SigOpImg) so atualiza a imagem de produtos JA
    * cadastrados em SigCdPro - o cadastro completo do produto (Inserir)
    * e feito pelo ProdutoBO/FormProduto, e nao ha exclusao de registro
    * aqui. Por isso Inserir()/ExecutarExclusao() permanecem herdados de
    * BusinessBase (nunca chamados por este formulario).
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "figjpgs = " + EscaparSQL(THIS.this_cImagemBase64) + ", " + ;
                "dtfilms = GETDATE(), " + ;
                "datas = GETDATE() " + ;
                "WHERE cpros = " + EscaparSQL(THIS.this_cCodProduto)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_dDataFilme = DATE()
                THIS.this_dData      = DATE()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel atualizar a imagem do produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpImgBO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparPreviewImpressao - "Delete From SigPrPrt Where Cpros = ..."
    * do cmdFigura.Valid legado: apaga a previsualizacao de impressao em
    * cache do produto antes de gravar a nova imagem (so a opcao "Imagem"
    * faz essa limpeza no legado; "Branco" nao chama este metodo).
    *====================================================================
    PROCEDURE LimparPreviewImpressao(par_cCodProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCodProduto) != "C" OR EMPTY(ALLTRIM(par_cCodProduto))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPrt WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCodProduto))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)
        CATCH TO loc_oErro
            *-- Limpeza de cache de previsualizacao - falha aqui nao pode
            *-- bloquear a gravacao da imagem (que eh a acao principal),
            *-- mas o erro precisa ficar visivel (regra #9 - CATCH nunca
            *-- silencioso).
            MsgErro(loc_oErro.Message, "SigOpImgBO.LimparPreviewImpressao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processar - Busca em SigCdPro os produtos que atendem aos filtros
    * correntes (this_dDataIni/this_dDataFin/this_nTipoImagem/
    * this_cGrupoFiltro/this_cProdutoFiltro/this_cLinhaFiltro) e devolve
    * o resultado em par_cCursorDestino via SQLEXEC (cursor TEMPORARIO -
    * quem repopula o cursor ligado ao Grid eh o Form, via ZAP + APPEND
    * FROM DBF, nunca SQLEXEC direto no alias do Grid).
    *
    * Equivalente ao PROCEDURE Processamento do legado (SigOpImg.SCX):
    * mesmo WHERE (DtIncs Between, FigJpgs Is [Not] Null, CPros/CGrus/
    * Linhas quando informados) e mesmo Order By CPros.
    *====================================================================
    PROCEDURE Processar(par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDtIni, loc_cDtFin, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorDestino) != "C" OR EMPTY(par_cCursorDestino)
            THIS.this_cMensagemErro = "Cursor de destino n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            *-- Limite superior do periodo com hora 23:59:59, igual ao
            *-- "pDtF = fDtoSQL(ThisForm.getDtFin.Value, '23:59:59')" legado
            loc_cDtIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFin = "'" + PADL(YEAR(THIS.this_dDataFin), 4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin), 2, "0") + " 23:59:59'"

            loc_cSQL = "SELECT dtfilms, dtincs, datas, cpros, dpros, ifors, reffs, cgrus, linhas, figjpgs " + ;
                "FROM SigCdPro " + ;
                "WHERE dtincs BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin

            DO CASE
                CASE THIS.this_nTipoImagem = 1
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NULL"
                CASE THIS.this_nTipoImagem = 2
                    loc_cSQL = loc_cSQL + " AND figjpgs IS NOT NULL"
            ENDCASE

            IF !EMPTY(ALLTRIM(NVL(THIS.this_cProdutoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cProdutoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cGrupoFiltro, "")))
                loc_cSQL = loc_cSQL + " AND cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupoFiltro))
            ENDIF
            IF !EMPTY(ALLTRIM(NVL(THIS.this_cLinhaFiltro, "")))
                loc_cSQL = loc_cSQL + " AND linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLinhaFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cpros"

            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel buscar os produtos." + CHR(13) + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
