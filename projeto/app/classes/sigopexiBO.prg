*====================================================================
* sigopexiBO.prg
*
* Business Object para Devolucao de Produtos (dialogo filho OPERACIONAL)
* Tabela: sigopexi
* Herda de: BusinessBase
*
* NOTA: SIGOPEXI eh um dialogo MODAL chamado pela tela de Movimentacao
* (parentform) para lancar devolucao de itens digitados por codigo de
* barras. A tabela sigopexi grava so as colunas persistidas abaixo;
* CItens e DPros existem apenas no cursor em memoria (crSigOpExI) usado
* pela grade do dialogo e NAO tem coluna correspondente na tabela.
*====================================================================

DEFINE CLASS sigopexiBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela sigopexi)
    this_cPkChaves    = ""    && pkchaves char(20) - PK (gerada via fUniqueIds())
    this_nCBars       = 0     && cbars numeric(14,0) - codigo de barras do produto devolvido
    this_cCPros       = ""    && cpros char(14) - codigo do produto
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave do movimento (Emps+Dopes+Str(Numes,6))
    this_dDatas       = {}    && datas datetime - data/hora do lancamento da devolucao
    this_nValors      = 0     && valors numeric(11,2) - valor da devolucao (qtds * units)

    *-- Propriedades auxiliares somente-memoria (nao persistidas em sigopexi)
    this_nCItens      = 0     && citens - sequencial do item na grade (crSigOpExI.CItens)
    this_cDPros       = ""    && dpros char(50) - descricao do produto (crSigOpExI.DPros, via SigCdPro)

    *-- Propriedades auxiliares de processo (equivalentes a propriedades/
    *-- controles do form legado - preenchidas/lidas pelos metodos desta
    *-- fase, consumidas pelo FormSigopexi nas fases seguintes)
    this_cOpEscolha            = ""    && espelha ThisForm.op_escolha (recebido do form pai) - usado em AdicionarItemPorBarras/ConfirmarDevolucoes
    this_nTotalItens           = 0     && espelha thisform.gettotitens.Value (COUNT da grade de devolucao)
    this_nTotalValor           = 0     && espelha thisform.gettotven.Value (SUM de valors da grade de devolucao)
    this_cProdutosParaExcluir  = ""    && codigos de produto (separados por virgula) elegiveis para exclusao de cadastro (CrSigCdOpe.CadProds = 3) - o Form pergunta ao usuario e chama THIS.parentform.ExcluirPro() para cada
    this_nNovoCItem            = 0     && equivalente a thisform.parentform.CItem apos ConfirmarDevolucoes renumerar crTpmMvItn
    this_lChamouApaIte         = .F.   && .T. quando ConfirmarDevolucoes identifica que o Form deve chamar THIS.parentform.ApaIte()

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigopexi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigopexiBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da tabela sigopexi
    * (pkchaves/cbars/cpros/empdopnums/datas/valors) a partir da linha
    * CORRENTE do cursor informado (tipicamente crSigOpExI - a grade de
    * devolucao), mais as duas colunas auxiliares somente-memoria
    * (citens/dpros), quando presentes no cursor.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_nCBars      = TratarNulo(cbars, 0)
            THIS.this_cCPros      = TratarNulo(cpros, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_dDatas      = TratarNulo(datas, {})
            THIS.this_nValors     = TratarNulo(valors, 0)

            *-- Colunas auxiliares somente-memoria do cursor da grade
            *-- (nao existem na tabela sigopexi - ver cabecalho da classe)
            IF TYPE(par_cAliasCursor + ".citens") != "U"
                THIS.this_nCItens = TratarNulo(citens, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".dpros") != "U"
                THIS.this_cDPros = TratarNulo(dpros, "")
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT INTO sigopexi com os valores das properties this_*.
    * Gera THIS.this_cPkChaves via fUniqueIds() quando ainda vazio (igual
    * ao getBarras.Valid do legado, que gera a chave no momento do insert).
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigopexi (pkchaves, cbars, cpros, empdopnums, datas, valors)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCBars, 0) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inserir devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE sigopexi, identificado por this_cPkChaves.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigopexi SET" + ;
                " cbars = "      + FormatarNumeroSQL(THIS.this_nCBars, 0) + "," + ;
                " cpros = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + "," + ;
                " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + "," + ;
                " datas = "      + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                " valors = "     + FormatarNumeroSQL(THIS.this_nValors, 2) + ;
                " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao atualizar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da tabela sigopexi (pkchaves).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * AtualizarTotais - Recalcula THIS.this_nTotalItens/this_nTotalValor a
    * partir do cursor de devolucao (equivalente a "Select crSigOpExI /
    * Sum valors to lntotven / Count to lnitn" repetido no getBarras.Valid
    * e no Init do legado). O Form eh quem espelha estes valores nos
    * labels gettotitens/gettotven - esta funcao so calcula.
    *====================================================================
    PROCEDURE AtualizarTotais(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias, loc_nTotalValor, loc_nTotalItens

        loc_cAlias      = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        loc_nTotalValor = 0
        loc_nTotalItens = 0

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            SUM valors TO loc_nTotalValor
            COUNT TO loc_nTotalItens
        ENDIF

        THIS.this_nTotalValor = loc_nTotalValor
        THIS.this_nTotalItens = loc_nTotalItens

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterDescricaoProduto - SELECT dpros FROM SigCdPro WHERE cpros = ...
    * (equivalente a "podatamgr.sqlexecute('select dpros from SigCdPro
    * where cpros = ?csProcura1.CPros','LocalPro')" do getBarras.Valid
    * legado - unica consulta SQL de verdade neste dialogo).
    *====================================================================
    PROTECTED PROCEDURE ObterDescricaoProduto(par_cCodigoProduto)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao

        loc_cDescricao = ""

        loc_cSQL = "SELECT dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(ALLTRIM(NVL(par_cCodigoProduto, "")))

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProduto")

        IF loc_nResultado > 0 AND USED("cursor_4c_BuscaProduto")
            SELECT cursor_4c_BuscaProduto
            GO TOP
            IF !EOF()
                loc_cDescricao = TratarNulo(dpros, "")
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL do movimento (EmpDopNums),
    * igual a "TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)" do
    * legado. O padding faz parte da chave (regra das colunas char de
    * largura fixa) - NUNCA usar ALLTRIM nas partes, so no resultado
    * inteiro seria inofensivo. Larguras conferidas no schema: emps
    * char(3) + dopes char(20) + Str(numes,6) = 29 = empdopnums char(29).
    *====================================================================
    PROTECTED PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(ALLTRIM(NVL(par_cEmps, "")), 3) + ;
               PADR(ALLTRIM(NVL(par_cDopes, "")), 20) + ;
               STR(NVL(par_nNumes, 0), 6)
    ENDPROC

    *====================================================================
    * AdicionarItemPorBarras - Localiza o item da movimentacao
    * (crTpmMvItn - cursor global compartilhado com o form pai de
    * Movimentacao) pelo codigo de barras e, se elegivel, inclui uma nova
    * linha no cursor de devolucao (equivalente ao getBarras.Valid do
    * legado). So manipula dados - o Form (fases seguintes) limpa o
    * campo de barras, da Refresh no Grid e exibe a mensagem conforme o
    * status retornado.
    *
    * Retorno:
    *   "OK"          - item incluido com sucesso na grade de devolucao
    *   "BLOQUEADO"   - produto com baixa parcial, nao pode ser alterado
    *   "INEXISTENTE" - codigo de barras nao encontrado na movimentacao
    *   "DUPLICADO"   - produto ja estava na grade de devolucao (nao faz
    *                   nada, igual ao legado, que ignora em silencio)
    *====================================================================
    PROCEDURE AdicionarItemPorBarras(par_nBarras, par_cAliasCursorDevolucao)
        LOCAL loc_cStatus, loc_cAliasDevol, loc_nItem, loc_cDescricao, loc_cChave

        loc_cStatus     = "INEXISTENTE"
        loc_cAliasDevol = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        *-- VARTYPE isolado num IF proprio: VFP9 nao faz short-circuit em
        *-- AND/OR, e "par_nBarras != 0" com par_nBarras nao-numerico
        *-- estouraria "Operator/operand type mismatch" se avaliado junto.
        IF VARTYPE(par_nBarras) = "N"
        IF par_nBarras != 0 AND USED("crTpmMvItn") AND USED(loc_cAliasDevol)
            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
            SELECT RECNO() AS NRec, CPros, BlqAlts, qtds, units FROM crTpmMvItn ;
                WHERE CodBarras = par_nBarras INTO CURSOR cursor_4c_BuscaMovimento
            GO TOP IN cursor_4c_BuscaMovimento

            IF !EOF("cursor_4c_BuscaMovimento")
                IF cursor_4c_BuscaMovimento.BlqAlts
                    loc_cStatus = "BLOQUEADO"
                ELSE
                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                    SELECT RECNO() AS NRec FROM (loc_cAliasDevol) ;
                        WHERE CBars = par_nBarras INTO CURSOR cursor_4c_BuscaDuplicado
                    GO TOP IN cursor_4c_BuscaDuplicado

                    IF EOF("cursor_4c_BuscaDuplicado")
                        *-- Renumera CItens das linhas existentes (igual ao
                        *-- legado - normalmente no-op, preserva fidelidade)
                        loc_nItem = 0
                        SELECT (loc_cAliasDevol)
                        SCAN
                            loc_nItem = loc_nItem + 1
                            REPLACE CItens WITH loc_nItem IN (loc_cAliasDevol)
                        ENDSCAN
                        loc_nItem = loc_nItem + 1

                        loc_cDescricao = THIS.ObterDescricaoProduto(cursor_4c_BuscaMovimento.CPros)
                        loc_cChave     = THIS.MontarChaveEmpDopNums(TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes)

                        INSERT INTO (loc_cAliasDevol) (EmpDopNums, Datas, pkChaves, CBars, CPros, dpros, valors, CItens) VALUES ( ;
                            loc_cChave, ;
                            DATETIME(), ;
                            fUniqueIds(), ;
                            par_nBarras, ;
                            cursor_4c_BuscaMovimento.CPros, ;
                            loc_cDescricao, ;
                            cursor_4c_BuscaMovimento.qtds * cursor_4c_BuscaMovimento.units, ;
                            loc_nItem)

                        THIS.AtualizarTotais(loc_cAliasDevol)

                        loc_cStatus = "OK"
                    ELSE
                        loc_cStatus = "DUPLICADO"
                    ENDIF

                    IF USED("cursor_4c_BuscaDuplicado")
                        USE IN cursor_4c_BuscaDuplicado
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaMovimento")
                USE IN cursor_4c_BuscaMovimento
            ENDIF
        ENDIF
        ENDIF

        RETURN loc_cStatus
    ENDPROC

    *====================================================================
    * LimparItensDevolucao - Esvazia o cursor de devolucao (equivalente a
    * "SELECT crSigOpExI / Zap" do btnCancelar.Click do legado).
    *====================================================================
    PROCEDURE LimparItensDevolucao(par_cAliasCursorDevolucao)
        LOCAL loc_cAlias
        loc_cAlias = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)

        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            ZAP
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ConfirmarDevolucoes - Processa a confirmacao da devolucao
    * (equivalente ao confirmar.Click do legado). Para cada item da
    * grade de devolucao, localiza o item correspondente na movimentacao
    * (crTpmMvItn) pelo codigo de barras e, se nao estiver bloqueado,
    * exclui o item (e seus componentes, em crTpmMvIts) da movimentacao,
    * renumera os itens restantes e, quando aplicavel, estorna a baixa
    * de estoque (xBaixa) e avalia se o cadastro do produto pode ser
    * excluido (CrSigCdOpe.CadProds = 3 - ver AvaliarExclusaoProduto).
    *
    * Cursores globais compartilhados com o form pai de Movimentacao
    * (crTpmMvItn, crTpmMvIts, TprMvCab, CrSigCdOpe, CrSigOpCdc,
    * TmpOperacao, xBaixa) sao referenciados por NOME, igual ao legado -
    * este dialogo so eh aberto depois que o pai os deixa abertos.
    *
    * O que o legado faz em "ThisForm.parentform" (fwgrade/fwgradeR.
    * Refresh, Produto.SetFocus, CItem, ExcluirPro, ApaIte) eh
    * responsabilidade de UI/navegacao do FORM pai, nao deste BO - o
    * Form (fases seguintes) le o resultado desta chamada
    * (this_cProdutosParaExcluir, this_nNovoCItem, this_lChamouApaIte) e
    * executa essas acoes contra o parentform depois de chamar este
    * metodo.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo sem
    * nenhuma devolucao processada - igual ao legado, que nao verifica
    * sucesso por item).
    *====================================================================
    PROCEDURE ConfirmarDevolucoes(par_cAliasCursorDevolucao)
        LOCAL loc_cAliasDevol, loc_oErro, loc_lSucesso, loc_nBarras
        LOCAL loc_cItem, loc_cPro, loc_nQtde, loc_lCarregaItens, loc_lChecaQtde, loc_lChecaOper
        LOCAL loc_nReg, loc_lDel, loc_lSubNiv, loc_cont, loc_cIt, loc_nRecNo2

        loc_lSucesso                  = .F.
        loc_cAliasDevol                = IIF(EMPTY(par_cAliasCursorDevolucao), "crSigOpExI", par_cAliasCursorDevolucao)
        THIS.this_cProdutosParaExcluir = ""
        THIS.this_nNovoCItem           = 0
        THIS.this_lChamouApaIte        = .F.

        TRY
            IF USED(loc_cAliasDevol) AND USED("crTpmMvItn")
                SELECT (loc_cAliasDevol)
                SCAN
                    loc_nBarras = cbars

                    SELECT crTpmMvItn
                    LOCATE FOR CodBarras = loc_nBarras

                    IF !EOF("crTpmMvItn")
                        IF crTpmMvItn.BlqAlts
                            *-- bloqueado: o legado so exibe o MessageBox e
                            *-- segue para o proximo item do SCAN (o Form
                            *-- exibe a mensagem de bloqueio, se desejar).
                        ELSE
                            IF !EMPTY(crTpmMvItn.cpros)
                                loc_cItem         = crTpmMvItn.CItens
                                loc_cPro          = crTpmMvItn.Cpros
                                loc_nQtde         = crTpmMvItn.Qtds
                                loc_lCarregaItens = INLIST(NVL(CrSigCdOpe.ItAutos, 0), 1, 3, 4, 5) AND THIS.this_cOpEscolha == "INSERIR"
                                loc_lChecaQtde    = INLIST(NVL(CrSigCdOpe.ChkQtdss, 0), 1, 3, 4)
                                loc_lChecaOper    = (EMPTY(CrSigOpCdc.ChkOpers) OR crTpmMvItn.Opers == CrSigOpCdc.ChkOpers)

                                SELECT crTpmMvItn
                                loc_nReg = RECNO()
                                loc_lDel = .F.

                                LOCATE FOR .F.
                                IF BETWEEN(loc_nReg, 1, RECCOUNT("crTpmMvItn"))
                                    GO loc_nReg
                                    DELETE
                                    DELETE FOR cItem2 = loc_cItem
                                    loc_lDel = .T.
                                ENDIF

                                IF loc_lDel
                                    loc_lSubNiv = .F.
                                    IF USED("TmpOperacao")
                                        SELECT TmpOperacao
                                        SCAN FOR !EMPTY(Codigos)
                                            loc_lSubNiv = .T.
                                        ENDSCAN
                                    ENDIF

                                    IF loc_lSubNiv AND loc_lChecaQtde AND loc_lChecaOper AND !loc_lCarregaItens
                                        IF USED("xBaixa")
                                            SELECT xBaixa
                                            IF SEEK(loc_cPro)
                                                REPLACE qtbaixas WITH qtbaixas - loc_nQtde IN xBaixa
                                            ENDIF
                                        ENDIF
                                    ENDIF

                                    IF USED("crTpmMvIts")
                                        SELECT crTpmMvIts
                                        SET ORDER TO
                                        SET ORDER TO CItens
                                        SEEK (loc_cItem)
                                        DO WHILE !EOF("crTpmMvIts") AND crTpmMvIts.CItens = loc_cItem
                                            DELETE
                                            SEEK (loc_cItem)
                                        ENDDO
                                    ENDIF

                                    IF NVL(CrSigCdOpe.CadProds, 0) = 3
                                        THIS.AvaliarExclusaoProduto(loc_cPro, NVL(TprMvCab.EmpdopNums, ""))
                                    ENDIF
                                ENDIF
                            ELSE
                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                                SELECT "" AS Agrupar, COUNT(1) AS Total FROM crTpmMvItn ;
                                    WHERE EMPTY(CPros) INTO CURSOR xApaga GROUP BY 1

                                IF xApaga.Total > 1
                                    SELECT crTpmMvItn
                                    DELETE
                                ELSE
                                    THIS.this_lChamouApaIte = .T.
                                ENDIF

                                IF USED("xApaga")
                                    USE IN xApaga
                                ENDIF
                            ENDIF

                            SELECT crTpmMvItn
                            SET ORDER TO CItens
                            GO TOP
                            IF EOF()
                                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CItens) ;
                                    VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, 1)
                            ENDIF

                            loc_cont = 0
                            SELECT crTpmMvItn
                            SCAN
                                loc_cont = loc_cont + 1
                                IF USED("crTpmMvIts")
                                    SELECT crTpmMvIts
                                    SET ORDER TO
                                    SET ORDER TO CItens
                                    SEEK crTpmMvItn.CItens
                                    SCAN WHILE CItens = crTpmMvItn.CItens
                                        REPLACE CItens WITH loc_cont
                                    ENDSCAN
                                ENDIF
                                SELECT crTpmMvItn
                                loc_cIt     = CItens
                                loc_nRecNo2 = RECNO()
                                REPLACE cItem2 WITH loc_cont FOR cItem2 = loc_cIt
                                GO loc_nRecNo2
                                REPLACE CItens WITH loc_cont
                            ENDSCAN

                            THIS.this_nNovoCItem = loc_cont

                            SELECT crTpmMvItn
                            SET ORDER TO
                            GO BOTTOM
                            IF !EOF() AND USED("crTpmMvIts")
                                SELECT crTpmMvIts
                                SET ORDER TO CItens
                                SET KEY TO crTpmMvItn.CItens
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT (loc_cAliasDevol)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao confirmar devolu" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "sigopexiBO.ConfirmarDevolucoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AvaliarExclusaoProduto - Verifica se o produto devolvido ainda tem
    * movimento (SigMvItn), historico (SigMvHst) ou composicao (SigPrCpo)
    * em outro documento; se nao tiver nenhum, acrescenta o codigo a
    * THIS.this_cProdutosParaExcluir (lista separada por virgula) para o
    * Form perguntar ao usuario (MessageBox) e chamar
    * THIS.parentform.ExcluirPro() - equivalente ao bloco "If
    * CrSigCdOpe.CadProds = 3" do confirmar.Click legado.
    *====================================================================
    PROTECTED PROCEDURE AvaliarExclusaoProduto(par_cCodigoProduto, par_cEmpDopNumsAtual)
        LOCAL loc_cSQL, loc_nTotalMov, loc_nTotalHist, loc_nTotalCompo, loc_cProduto, loc_cEmpDopNums

        loc_cProduto     = ALLTRIM(NVL(par_cCodigoProduto, ""))
        loc_cEmpDopNums  = NVL(par_cEmpDopNumsAtual, "")

        loc_cSQL = "SELECT cpros FROM SigMvItn WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaMov")
        loc_nTotalMov = IIF(USED("cursor_4c_VerificaMov"), RECCOUNT("cursor_4c_VerificaMov"), 0)

        loc_cSQL = "SELECT cpros FROM SigMvHst WHERE cpros = " + EscaparSQL(loc_cProduto) + ;
            " AND empdopnums <> " + EscaparSQL(loc_cEmpDopNums)
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaHist")
        loc_nTotalHist = IIF(USED("cursor_4c_VerificaHist"), RECCOUNT("cursor_4c_VerificaHist"), 0)

        loc_cSQL = "SELECT mats FROM SigPrCpo WHERE mats = " + EscaparSQL(loc_cProduto)
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerificaCompo")
        loc_nTotalCompo = IIF(USED("cursor_4c_VerificaCompo"), RECCOUNT("cursor_4c_VerificaCompo"), 0)

        IF loc_nTotalMov = 0 AND loc_nTotalHist = 0 AND loc_nTotalCompo = 0
            THIS.this_cProdutosParaExcluir = THIS.this_cProdutosParaExcluir + ;
                IIF(EMPTY(THIS.this_cProdutosParaExcluir), "", ",") + loc_cProduto
        ENDIF

        IF USED("cursor_4c_VerificaMov")
            USE IN cursor_4c_VerificaMov
        ENDIF
        IF USED("cursor_4c_VerificaHist")
            USE IN cursor_4c_VerificaHist
        ENDIF
        IF USED("cursor_4c_VerificaCompo")
            USE IN cursor_4c_VerificaCompo
        ENDIF
    ENDPROC

ENDDEFINE
