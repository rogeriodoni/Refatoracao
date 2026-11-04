*==============================================================================
* SigOpDetBO.prg - Business Object para o dialogo de Selecao de Detalhes
* (Caracteristicas/Complementos de Produto) - SIGOPDET
*
* Form OPERACIONAL de DIALOGO (WindowType = 1, TitleBar = 0, ControlBox = .F.,
* AutoCenter = .T., AlwaysOnTop = .T., Height = 500, Width = 800) aberto por um
* form PAI - o Init legado recebe "LParameters pCnx, pEscolha, pDopes, pProd,
* pEDN" (pCnx = ThisForm.poDataMgr, nao portado - este ambiente usa o handle
* global gnConnHandle).
*
* OBJETIVO DO DIALOGO
* --------------------
* Exibir, numa grade de 3 colunas (Caracteristica / Complemento / Outros), as
* linhas de SigMvFtc associadas a um item de movimento (par EmpDopNums+Cpros)
* e permitir ao usuario escolher, para cada linha, uma Caracteristica (coluna
* ccars, validada contra SigCrRap) e um Complemento (coluna ctits, validado
* contra SigPrCpP), alem de digitar uma observacao livre (coluna resps).
*
* O universo de Caracteristicas/Complementos permitido para o par
* Grupo (pDopes, equivale a SigCdFtc.cgrus) + Grande Grupo do produto
* (SigCdPro.Mercs) vem de SigCdFtc (filtrada por ntipos = 2), unida com
* SigCrRap (descricao + flag chkobrig - caracteristica obrigatoria) e
* SigPrCpP (descricao do complemento). Essa lista NAO tem tabela propria no
* dialogo - fica numa cursor de referencia (equivalente ao LocalFtc do
* legado), carregada por metodo a implementar na Fase 2.
*
* TABELA PRINCIPAL (persistida e editada por este dialogo): SigMvFtc
*   cidchaves  char(20) NOT NULL  - PK (fUniqueIds() por linha, regra #22)
*   empdopnums char(29) NOT NULL  - chave do movimento (par_cEmpDopNums)
*   cpros      char(14) NOT NULL  - codigo do produto (par_cCpros)
*   ccars      char(20) NOT NULL  - caracteristica selecionada na linha
*   ctits      char(20) NOT NULL  - complemento selecionado na linha
*   resps      char(20) NOT NULL  - observacao/resposta digitada na linha
*   ordens     numeric(6,0) NOT NULL - ordem da linha (sem DEFAULT no schema -
*                                      o legado nunca grava no INSERT da
*                                      cursor local; a Fase 2 precisa decidir
*                                      um valor antes do INSERT real na tabela
*                                      - regra #22)
*
* PARAMETROS RECEBIDOS DO FORM PAI (Init legado, sem o pCnx que nao existe
* mais neste ambiente):
*   this_cModoOperacao - pEscolha (INSERIR/ALTERAR/VISUALIZAR/etc) - decide se
*                        as colunas da grade aceitam edicao (When do legado:
*                        InList(ThisForm.pcEscolha, 'INSERIR', 'ALTERAR'))
*   this_cGrupo        - pDopes (SigCdFtc.cgrus) - grupo de caracteristicas
*   this_cCpros        - pProd (SigCdPro.Cpros) - produto do item de movimento
*   this_cEmpDopNums   - pEDN (chave do item de movimento, SigMvCab/SigMvItn)
*
* DADO DE REFERENCIA CARREGADO A PARTIR DO PRODUTO (Fase 2):
*   this_cMercs - SigCdPro.Mercs (Grande Grupo do produto), obtido via
*                 CursorQuery/SQLEXEC em SigCdPro WHERE Cpros = this_cCpros.
*                 Usado para filtrar SigCrRap.cgrus = this_cMercs na consulta
*                 da lista de Caracteristicas/Complementos permitidos.
*
* PROPRIEDADES DA LINHA CORRENTE DA GRADE (SigMvFtc - uma linha por vez, no
* padrao de validacao de celula da grade - regra #46: Valid do TextBox da
* coluna, nunca AfterRowColChange):
*   this_cCIdChaves - cidchaves da linha corrente
*   this_cCCars     - ccars da linha corrente (Caracteristica)
*   this_cCTits     - ctits da linha corrente (Complemento)
*   this_cResps     - resps da linha corrente (observacao)
*   this_nOrdens    - ordens da linha corrente
*
* METODOS DE CARGA/PERSISTENCIA DA GRADE (Fase 4):
*   CarregarProduto()        - le SigCdPro para obter this_cMercs
*   CarregarListaReferencia() - popula cursor_4c_LocalFtc (equivalente ao
*                               LocalFtc do legado - join SigCdFtc+SigCrRap+
*                               SigPrCpP)
*   CarregarItens()          - orquestra CarregarProduto+CarregarListaReferencia
*                               e popula cursor_4c_Itens a partir de SigMvFtc
*                               (equivalente ao Init legado), garantindo uma
*                               linha para cada caracteristica obrigatoria
*   InserirLinhaPadrao()     - garante linha em branco no final da grade
*                               (cmdInserir.Click do legado)
*   ExcluirLinhaAtual()      - remove a linha corrente (cmdExcluir.Click)
*   Validacao()              - confere que toda Caracteristica obrigatoria
*                               (SigCrRap.chkobrig=1) tem linha preenchida;
*                               se ok, descarta as linhas em branco
*   GravarItens()            - persiste as linhas sobreviventes em SigMvFtc
*                               (Confirmar/Cancelar do legado - equivalente
*                               ao TABLEUPDATE automatico do cursor remoto
*                               buffered, que este ambiente nao possui)
*   ObterChavePrimaria()      - retorna this_cCIdChaves (ALLTRIM)
*
* Lookup de Caracteristica/Complemento (ValidarCaracteristica/
* ValidarComplemento, equivalentes ao fwbuscaint do legado) vivem no FORM
* (TextBoxGridLookup.prg - regra #46: Valid do TextBox da coluna), nao no BO,
* porque dependem diretamente do TextBox da celula.
*
* Este dialogo PERSISTE uma tabela propria (SigMvFtc, ao contrario de
* SigOpCtsBO/SigOpAutBO) via GravarItens()/Inserir().
*
* Fase 4/8 (atual): carga/persistencia completa da grade.
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigOpDetBO AS BusinessBase

    *-- Parametros recebidos do form pai na abertura (Init legado: pEscolha,
    *-- pDopes, pProd, pEDN - sem pCnx, que nao existe mais neste ambiente)
    this_cModoOperacao = ""    && pEscolha - INSERIR/ALTERAR/VISUALIZAR/etc
    this_cGrupo        = ""    && pDopes - SigCdFtc.cgrus (grupo de caracteristicas)
    this_cCpros        = ""    && pProd - SigCdPro.Cpros (produto do item de movimento)
    this_cEmpDopNums   = ""    && pEDN - chave do item de movimento (SigMvCab/SigMvItn)

    *-- Dado de referencia obtido a partir do produto (Fase 2:
    *-- CarregarProduto) - usado para filtrar o universo de Caracteristicas/
    *-- Complementos permitidos (SigCrRap.cgrus = this_cMercs)
    this_cMercs = ""            && SigCdPro.Mercs - Grande Grupo do produto

    *-- Propriedades da entidade (mapeamento para tabela SigMvFtc - linha
    *-- corrente da grade, uma linha por vez)
    this_cCIdChaves = ""         && cidchaves char(20) NOT NULL - PK
    this_cCCars     = ""         && ccars char(20) NOT NULL - Caracteristica
    this_cCTits     = ""         && ctits char(20) NOT NULL - Complemento
    this_cResps     = ""         && resps char(20) NOT NULL - observacao da linha
    this_nOrdens    = 0          && ordens numeric(6,0) NOT NULL - ordem da linha

    *====================================================================
    * Init - Inicializa Business Object
    * par_cModoOperacao - pEscolha do legado (INSERIR/ALTERAR/VISUALIZAR)
    * par_cGrupo        - pDopes do legado (SigCdFtc.cgrus)
    * par_cCpros        - pProd do legado (SigCdPro.Cpros)
    * par_cEmpDopNums   - pEDN do legado (chave do item de movimento)
    *====================================================================
    PROCEDURE Init(par_cModoOperacao, par_cGrupo, par_cCpros, par_cEmpDopNums)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvFtc"
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cModoOperacao = IIF(VARTYPE(par_cModoOperacao) = "C", ;
                ALLTRIM(par_cModoOperacao), "")
            THIS.this_cGrupo        = IIF(VARTYPE(par_cGrupo) = "C", ;
                ALLTRIM(par_cGrupo), "")
            THIS.this_cCpros        = IIF(VARTYPE(par_cCpros) = "C", ;
                ALLTRIM(par_cCpros), "")
            THIS.this_cEmpDopNums   = IIF(VARTYPE(par_cEmpDopNums) = "C", ;
                ALLTRIM(par_cEmpDopNums), "")

            THIS.this_cMercs = ""

            THIS.this_cCIdChaves = ""
            THIS.this_cCCars     = ""
            THIS.this_cCTits     = ""
            THIS.this_cResps     = ""
            THIS.this_nOrdens    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades da LINHA CORRENTE da grade
    * a partir de um cursor de SigMvFtc (regra #46: a validacao de celula
    * fica no Valid do TextBox da coluna, que le este metodo depois de
    * posicionar o cursor na linha da grade - nao em AfterRowColChange)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCIdChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCCars      = TratarNulo(ccars,      "C")
                THIS.this_cCTits      = TratarNulo(ctits,      "C")
                THIS.this_cResps      = TratarNulo(resps,      "C")
                THIS.this_nOrdens     = TratarNulo(ordens,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna cidchaves da linha corrente (PK de
    * SigMvFtc), usada por RegistrarAuditoria em Inserir/Atualizar
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *====================================================================
    * Inserir - Insere uma nova linha (Caracteristica/Complemento/Resposta)
    * em SigMvFtc para o item de movimento corrente (this_cEmpDopNums +
    * this_cCpros, fixos para o dialogo inteiro - regra #22: cidchaves
    * gerado por fUniqueIds(), nunca string vazia, para nao colidir no
    * indice unico quando a grade tiver mais de uma linha)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChaves)
                THIS.this_cCIdChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvFtc (cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens)
                VALUES (
                    <<EscaparSQL(THIS.this_cCIdChaves)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cCCars)>>,
                    <<EscaparSQL(THIS.this_cCTits)>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<FormatarNumeroSQL(THIS.this_nOrdens, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarProduto - Le SigCdPro para obter this_cMercs (Grande Grupo
    * do produto), usado para filtrar o universo de Caracteristicas/
    * Complementos permitidos (equivale ao CursorQuery('SigCdPro',
    * 'crProduto','Cpros',ThisForm.pcPro,'Mercs, Cpros') do Init legado)
    *====================================================================
    PROTECTED PROCEDURE CarregarProduto()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT mercs FROM SigCdPro WHERE cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetProd")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_SigOpDetProd") AND RECCOUNT("cursor_4c_SigOpDetProd") > 0
                    THIS.this_cMercs = TratarNulo(cursor_4c_SigOpDetProd.mercs, "C")
                ELSE
                    THIS.this_cMercs = ""
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar o produto do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_SigOpDetProd")
                USE IN cursor_4c_SigOpDetProd
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarListaReferencia - Monta cursor_4c_LocalFtc (equivalente ao
    * LocalFtc do legado): universo de Caracteristicas/Complementos
    * permitidos para o par Grupo (this_cGrupo = SigCdFtc.cgrus) + Grande
    * Grupo do produto (this_cMercs), com a descricao da caracteristica
    * (SigCrRap.descrs AS Desccars) e do complemento (SigPrCpP.descrs, SEM
    * alias - os nomes finais tem de bater com os das sub-consultas feitas
    * pelo Form em cima deste cursor: "Desccars" e "descrs")
    *====================================================================
    PROTECTED PROCEDURE CarregarListaReferencia()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LocalFtc")
                USE IN cursor_4c_LocalFtc
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.ccars, b.descrs AS Desccars, a.ctits, b.chkobrig, c.descrs, a.cgrus AS Dopes
                FROM SigCdFtc a
                INNER JOIN SigCrRap b ON a.ccars = b.codigos
                INNER JOIN SigPrCpP c ON a.ctits = c.codigos
                WHERE a.ntipos = 2
                AND a.cgrus = <<EscaparSQL(THIS.this_cGrupo)>>
                AND b.cgrus = <<EscaparSQL(THIS.this_cMercs)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFtc")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar a lista de caracter" + CHR(237) + "sticas/complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarListaReferencia")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItens - Orquestra a carga completa do dialogo (equivalente
    * ao Init legado, do CursorQuery do produto em diante): CarregarProduto,
    * CarregarListaReferencia, popula cursor_4c_Itens (equivalente a
    * crSigMvFtc) a partir de SigMvFtc filtrado por this_cEmpDopNums +
    * this_cCpros, e garante uma linha para CADA caracteristica obrigatoria
    * (SigCrRap.chkobrig = 1) que ainda nao esteja representada
    * (regra do legado: "Insert Into crSigMvFtc (...) Values (...)" dentro
    * do SCAN de CarsObrigs).
    *
    * cursor_4c_Itens nasce de um alias TEMPORARIO + SELECT INTO CURSOR
    * READWRITE (SQLEXEC() sozinho cria cursor so-leitura - a grade do Form
    * precisa editar celulas).
    *====================================================================
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCarObrig, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            IF !THIS.CarregarProduto()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.CarregarListaReferencia()
                    loc_lSucesso = .F.
                ELSE
                    IF USED("cursor_4c_SigOpDetItensTmp")
                        USE IN cursor_4c_SigOpDetItensTmp
                    ENDIF

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        SELECT cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens
                        FROM SigMvFtc
                        WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                        AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpDetItensTmp")

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao carregar os detalhes do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_Itens")
                            USE IN cursor_4c_Itens
                        ENDIF
                        SELECT * FROM cursor_4c_SigOpDetItensTmp INTO CURSOR cursor_4c_Itens READWRITE
                        IF USED("cursor_4c_SigOpDetItensTmp")
                            USE IN cursor_4c_SigOpDetItensTmp
                        ENDIF

                        *-- Garante uma linha para cada caracteristica obrigatoria
                        *-- ainda nao representada (legado: Insert dentro do Scan)
                        IF USED("cursor_4c_SigOpDetObrigs")
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF
                        SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                            WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                        loc_nOrdem = 0
                        SELECT cursor_4c_Itens
                        GO TOP
                        LOCATE FOR !EMPTY(ccars)
                        IF !EOF()
                            loc_nOrdem = RECCOUNT("cursor_4c_Itens")
                        ENDIF

                        IF USED("cursor_4c_SigOpDetObrigs")
                            SELECT cursor_4c_SigOpDetObrigs
                            SCAN
                                loc_cCarObrig = ccars
                                SELECT cursor_4c_Itens
                                LOCATE FOR ccars = loc_cCarObrig
                                IF !FOUND()
                                    loc_nOrdem = loc_nOrdem + 1
                                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ccars, ordens) ;
                                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, loc_cCarObrig, loc_nOrdem)
                                ENDIF
                                SELECT cursor_4c_SigOpDetObrigs
                            ENDSCAN
                            USE IN cursor_4c_SigOpDetObrigs
                        ENDIF

                        SELECT cursor_4c_Itens
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InserirLinhaPadrao - Garante que exista uma linha em branco no final
    * de cursor_4c_Itens para o usuario preencher (equivalente ao
    * cmdInserir.Click do legado: so cria se nao houver NENHUMA linha com
    * CCars vazio)
    *====================================================================
    PROCEDURE InserirLinhaPadrao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                GO TOP
                LOCATE FOR EMPTY(ccars)
                IF EOF()
                    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ordens) ;
                        VALUES (fUniqueIds(), THIS.this_cEmpDopNums, THIS.this_cCpros, RECCOUNT("cursor_4c_Itens") + 1)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.InserirLinhaPadrao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove a linha corrente de cursor_4c_Itens
    * (equivalente ao cmdExcluir.Click do legado)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                IF !EOF()
                    DELETE
                ENDIF
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
                GO BOTTOM
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.ExcluirLinhaAtual")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Validacao - Confere que toda Caracteristica obrigatoria (SigCrRap.
    * chkobrig = 1) para o par Grupo/Grande Grupo tem uma linha preenchida
    * em cursor_4c_Itens; se faltar alguma, avisa e devolve .F. (mesma
    * mensagem do legado). Se tudo ok, apaga as linhas em branco (Delete
    * From crSigMvFtc where Empty(CCars) do legado) e devolve .T.
    *====================================================================
    FUNCTION Validacao()
        LOCAL loc_lOk, loc_cCarObrig, loc_cDescObrig, loc_cMsg
        loc_lOk  = .T.
        loc_cMsg = ""

        TRY
            IF USED("cursor_4c_SigOpDetObrigs")
                USE IN cursor_4c_SigOpDetObrigs
            ENDIF

            IF USED("cursor_4c_LocalFtc")
                SELECT DISTINCT ccars, desccars FROM cursor_4c_LocalFtc ;
                    WHERE chkobrig = 1 INTO CURSOR cursor_4c_SigOpDetObrigs READWRITE

                IF USED("cursor_4c_SigOpDetObrigs")
                    SELECT cursor_4c_SigOpDetObrigs
                    SCAN
                        loc_cCarObrig  = ccars
                        loc_cDescObrig = desccars

                        IF USED("cursor_4c_Itens")
                            SELECT cursor_4c_Itens
                            LOCATE FOR ccars = loc_cCarObrig
                            IF !FOUND()
                                loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                                loc_lOk = .F.
                            ENDIF
                        ELSE
                            loc_cMsg = loc_cMsg + ALLTRIM(loc_cDescObrig) + CHR(13) + CHR(10)
                            loc_lOk = .F.
                        ENDIF

                        IF !loc_lOk
                            EXIT
                        ENDIF
                        SELECT cursor_4c_SigOpDetObrigs
                    ENDSCAN
                    USE IN cursor_4c_SigOpDetObrigs
                ENDIF
            ENDIF

            IF !loc_lOk
                MsgAviso("Existem Caracteristicas Obrigat" + CHR(243) + "rias e n" + CHR(227) + "o Foram Informadas." + CHR(13) + CHR(10) + ;
                    CHR(13) + CHR(10) + loc_cMsg + CHR(13) + CHR(10) + "Verifique.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_Itens")
                    DELETE FROM cursor_4c_Itens WHERE EMPTY(ccars)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.Validacao")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * GravarItens - Persiste as linhas sobreviventes de cursor_4c_Itens
    * (apos Validacao() ja ter descartado as em branco) em SigMvFtc. O
    * item de movimento (this_cEmpDopNums + this_cCpros) e gravado por
    * completo: apaga tudo que ja existia na tabela para o item e regrava
    * cada linha corrente do cursor - equivalente, para esta tela, ao
    * TABLEUPDATE automatico do cursor remoto buffered do legado
    * (crSigMvFtc), que este ambiente nao possui.
    *====================================================================
    PROCEDURE GravarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nOrdem
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvFtc
                WHERE empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>
                AND cpros = <<EscaparSQL(THIS.this_cCpros)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Erro ao limpar os detalhes anteriores do item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
                loc_nOrdem = 0

                IF USED("cursor_4c_Itens")
                    SELECT cursor_4c_Itens
                    SCAN FOR !DELETED() AND !EMPTY(ccars)
                        loc_nOrdem = loc_nOrdem + 1

                        THIS.this_cCIdChaves = TratarNulo(cidchaves, "C")
                        THIS.this_cCCars     = TratarNulo(ccars,     "C")
                        THIS.this_cCTits     = TratarNulo(ctits,     "C")
                        THIS.this_cResps     = TratarNulo(resps,     "C")
                        THIS.this_nOrdens    = loc_nOrdem

                        IF EMPTY(THIS.this_cCIdChaves)
                            THIS.this_cCIdChaves = fUniqueIds()
                        ENDIF

                        IF !THIS.Inserir()
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_Itens
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpDetBO.GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
