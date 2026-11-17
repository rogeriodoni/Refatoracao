*====================================================================
* SigOpSitBO.prg
*
* Business Object para Descricao do Item (dialogo filho OPERACIONAL)
* Form legado: SIGOPSIT ("Cadastro de Testes" / "Descricao do Item")
*
* NOTA: SIGOPSIT eh um dialogo chamado pela tela de Movimentacao
* (parentform) para detalhar a composicao de um item (Tamanho x Cor x
* Embalagem) do produto que esta sendo lancado. A grade do dialogo
* (fwGrade) eh ligada DIRETO ao cursor crTpmMvIts, que eh COMPARTILHADO
* com o form pai de Movimentacao - este BO NAO grava em tabela propria,
* apenas manipula/valida esse cursor em memoria. A persistencia final
* em SigMvIts eh responsabilidade do form pai (ao confirmar o
* lancamento da movimentacao).
*====================================================================

DEFINE CLASS SigOpSitBO AS BusinessBase

    *-- Propriedades de cabecalho (somente leitura na tela, espelham o
    *-- produto cuja composicao esta sendo detalhada - Get_Produto e
    *-- Get_Descricao do legado)
    this_cCodigoProduto    = ""    && Get_Produto.Value   - codigo do produto (crTpmMvItn.CPros)
    this_cDescricaoProduto = ""    && Get_Descricao.Value - descricao do produto (SigCdPro.DPros)

    *-- Propriedades da linha corrente da grade (crTpmMvIts - cursor
    *-- compartilhado com o form pai de Movimentacao)
    this_cCItens  = ""    && crTpmMvIts.CItens  - FK para o item da movimentacao (crTpmMvItn.CItens)
    this_cCodTams = ""    && crTpmMvIts.CodTams - codigo do tamanho (FK SigCdTam)
    this_cCodCors = ""    && crTpmMvIts.CodCors - codigo da cor (FK SigCdCor)
    this_cCodEmbs = ""    && crTpmMvIts.CodEmbs - codigo da embalagem (FK SigCdEmb)
    this_nQtdEmbs = 0     && crTpmMvIts.QtdEmbs - quantidade por embalagem (multiplicador, validado contra SigCdEmb.Multis)
    this_nQtds    = 0     && crTpmMvIts.Qtds    - quantidade da linha
    this_nPesos   = 0     && crTpmMvIts.Pesos   - peso da linha

    *-- Propriedades auxiliares de descricao (csTmpDesc - cursor de
    *-- apoio do legado, usado para exibir a descricao de Tamanho/Cor/
    *-- Embalagem ao lado da grade de codigos)
    this_nNControle = 0    && csTmpDesc.nControle - vincula a linha de descricao a linha da grade (Str(RecNo('crTpmMvIts'),8))
    this_nNLinhas   = 0    && csTmpDesc.nLinhas   - numero sequencial da linha (ordem de exibicao)
    this_cDescTams  = ""   && csTmpDesc.cDescTams - descricao do tamanho (SigCdTam.DTams)
    this_cDescCors  = ""   && csTmpDesc.cDescCors - descricao da cor (SigCdCor.DCors)
    this_cDescEmbs  = ""   && csTmpDesc.cDescEmbs - descricao da embalagem (SigCdEmb.DEmbs)

    *-- Totais da grade (Get_TQtde/Get_TPeso - equivalentes a
    *-- "Sum(Qtds) As TQtdes, Sum(Pesos) As TPesos From crTpmMvIts Where
    *-- CItens = crTpmMvItn.CItens And Not IsEmpty(Qtds)" do fwGrade.Procedure legado)
    this_nTotalQtde = 0    && Get_TQtde.Value - soma de crTpmMvIts.Qtds (linhas com Qtds preenchido)
    this_nTotalPeso = 0    && Get_TPeso.Value - soma de crTpmMvIts.Pesos (linhas com Qtds preenchido)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            *-- SIGOPSIT nao grava em tabela propria: a grade manipula
            *-- diretamente o cursor crTpmMvIts, compartilhado com o
            *-- form pai de Movimentacao (que persiste em SigMvIts ao
            *-- confirmar o lancamento).
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpSitBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades a partir da linha
    * CORRENTE do cursor compartilhado (crTpmMvIts) e da descricao
    * correspondente em csTmpDesc, vinculada pelo numero do registro
    * (Str(RecNo('crTpmMvIts'),8) no legado - csTmpDesc.nControle).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_cChaveControle
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, "crTpmMvIts")

        IF USED(loc_cAlias) AND !EOF(loc_cAlias)
            SELECT (loc_cAlias)

            THIS.this_cCItens  = TratarNulo(CItens, "")
            THIS.this_cCodTams = TratarNulo(CodTams, "")
            THIS.this_cCodCors = TratarNulo(CodCors, "")
            THIS.this_cCodEmbs = TratarNulo(CodEmbs, "")
            THIS.this_nQtdEmbs = TratarNulo(QtdEmbs, 0)
            THIS.this_nQtds    = TratarNulo(Qtds, 0)
            THIS.this_nPesos   = TratarNulo(Pesos, 0)

            *-- csTmpDesc eh o cursor de apoio do legado (descricao de
            *-- Tamanho/Cor/Embalagem ao lado da grade) - vinculo por
            *-- numero de registro, nao por chave de negocio.
            IF USED("csTmpDesc")
                loc_cChaveControle = PADL(ALLTRIM(STR(RECNO(loc_cAlias))), 8, "0")
                SELECT csTmpDesc
                LOCATE FOR PADL(ALLTRIM(STR(nControle)), 8, "0") == loc_cChaveControle
                IF FOUND()
                    THIS.this_nNControle = nControle
                    THIS.this_nNLinhas   = nLinhas
                    THIS.this_cDescTams  = TratarNulo(cDescTams, "")
                    THIS.this_cDescCors  = TratarNulo(cDescCors, "")
                    THIS.this_cDescEmbs  = TratarNulo(cDescEmbs, "")
                ELSE
                    THIS.this_nNControle = 0
                    THIS.this_nNLinhas   = 0
                    THIS.this_cDescTams  = ""
                    THIS.this_cDescCors  = ""
                    THIS.this_cDescEmbs  = ""
                ENDIF
                SELECT (loc_cAlias)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - SIGOPSIT nao tem tabela SQL propria (ver comentario no
    * Init): a grade manipula direto o cursor crTpmMvIts, compartilhado
    * com o form pai de Movimentacao, que persiste em SigMvIts somente
    * ao confirmar o lancamento. "Inserir" aqui significa acrescentar
    * uma linha nova ao cursor em memoria, equivalente ao que o legado
    * faz ao detectar Thisform.lNovaLinha (mNovaLinha) na grade.
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("crTpmMvIts")
            THIS.this_cMensagemErro = "Cursor crTpmMvIts n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT crTpmMvIts
            APPEND BLANK
            REPLACE CItens  WITH THIS.this_cCItens, ;
                    CodTams WITH THIS.this_cCodTams, ;
                    CodCors WITH THIS.this_cCodCors, ;
                    CodEmbs WITH THIS.this_cCodEmbs, ;
                    QtdEmbs WITH THIS.this_nQtdEmbs, ;
                    Qtds    WITH THIS.this_nQtds, ;
                    Pesos   WITH THIS.this_nPesos

            IF USED("csTmpDesc")
                SELECT csTmpDesc
                APPEND BLANK
                REPLACE nControle WITH RECNO("crTpmMvIts"), ;
                        nLinhas   WITH RECCOUNT("csTmpDesc"), ;
                        cDescTams WITH THIS.this_cDescTams, ;
                        cDescCors WITH THIS.this_cDescCors, ;
                        cDescEmbs WITH THIS.this_cDescEmbs
                THIS.this_nNControle = nControle
                THIS.this_nNLinhas   = nLinhas
            ENDIF

            *-- No-op seguro: ObterChavePrimaria() devolve vazio porque nao
            *-- ha chave de banco para este cursor em memoria (ver abaixo).
            THIS.RegistrarAuditoria("INSERT")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigOpSitBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Grava as propriedades na linha CORRENTE de crTpmMvIts
    * (e na descricao correspondente em csTmpDesc), equivalente ao que
    * os Valid de cada coluna da grade fazem no legado ao sair da
    * celula editada.
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cChaveControle
        loc_lSucesso = .F.

        IF !USED("crTpmMvIts") OR EOF("crTpmMvIts")
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " linha corrente em crTpmMvIts"
            RETURN .F.
        ENDIF

        TRY
            SELECT crTpmMvIts
            REPLACE CodTams WITH THIS.this_cCodTams, ;
                    CodCors WITH THIS.this_cCodCors, ;
                    CodEmbs WITH THIS.this_cCodEmbs, ;
                    QtdEmbs WITH THIS.this_nQtdEmbs, ;
                    Qtds    WITH THIS.this_nQtds, ;
                    Pesos   WITH THIS.this_nPesos

            IF USED("csTmpDesc")
                loc_cChaveControle = PADL(ALLTRIM(STR(RECNO("crTpmMvIts"))), 8, "0")
                SELECT csTmpDesc
                LOCATE FOR PADL(ALLTRIM(STR(nControle)), 8, "0") == loc_cChaveControle
                IF FOUND()
                    REPLACE cDescTams WITH THIS.this_cDescTams, ;
                            cDescCors WITH THIS.this_cDescCors, ;
                            cDescEmbs WITH THIS.this_cDescEmbs
                ENDIF
                SELECT crTpmMvIts
            ENDIF

            *-- No-op seguro: ObterChavePrimaria() devolve vazio porque nao
            *-- ha chave de banco para este cursor em memoria (ver abaixo).
            THIS.RegistrarAuditoria("UPDATE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigOpSitBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Remove a linha CORRENTE de crTpmMvIts e a
    * descricao correspondente em csTmpDesc, renumerando csTmpDesc.nLinhas
    * em seguida - transcrito de SIGOPSIT.Apaga.Click do legado (a
    * checagem adicional de modo feita la por Thisform.cWhere e
    * responsabilidade do Form, que decide SE pode chamar este metodo).
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cChaveControle, loc_nContador
        loc_lSucesso = .F.

        IF !USED("crTpmMvIts") OR EOF("crTpmMvIts")
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " linha corrente em crTpmMvIts"
            RETURN .F.
        ENDIF

        TRY
            SELECT crTpmMvIts
            loc_cChaveControle = PADL(ALLTRIM(STR(RECNO("crTpmMvIts"))), 8, "0")
            DELETE

            IF USED("csTmpDesc")
                SELECT csTmpDesc
                LOCATE FOR PADL(ALLTRIM(STR(nControle)), 8, "0") == loc_cChaveControle
                IF FOUND()
                    DELETE
                ENDIF

                *-- Renumera nLinhas para ficar sequencial apos a exclusao,
                *-- igual ao Scan .. Replace nLinhas With nContador do legado.
                loc_nContador = 1
                GO TOP IN csTmpDesc
                SCAN
                    REPLACE csTmpDesc.nLinhas WITH loc_nContador
                    loc_nContador = loc_nContador + 1
                ENDSCAN
                SELECT crTpmMvIts
            ENDIF

            *-- No-op seguro: ObterChavePrimaria() devolve vazio porque nao
            *-- ha chave de banco para este cursor em memoria (ver abaixo).
            THIS.RegistrarAuditoria("DELETE")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigOpSitBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - SIGOPSIT nao persiste em tabela propria (ver
    * comentario no Init), entao nao ha chave de banco para auditar.
    * Devolver vazio mantem RegistrarAuditoria() (herdada de
    * BusinessBase) como no-op seguro, em vez de gravar em LogAuditoria
    * uma chave que nao corresponde a registro algum.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE
