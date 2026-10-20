*------------------------------------------------------------------------------
* sigopagrBO - Business Object para Formsigopagr
* Dialogo operacional de selecao/agrupamento de itens de borracharia por
* produto + tamanho, usado para marcar itens e ajustar peso/valor antes de
* propagar os valores de volta ao cursor de movimento (crTpmMvItn).
* Migrado de: SIGOPAGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida: ele recebe do form
* chamador um cursor de movimento JA ABERTO (crTpmMvItn no legado,
* this_cCursorMovimento aqui - DataSession compartilhada, igual ao legado
* DataSession=1), agrupa esse cursor por Produto+Tamanho para exibir na
* grade, deixa o usuario marcar linhas e propaga Pesos/Valor de volta para
* o PROPRIO cursor de movimento (manipulacao de cursor local, nao escrita
* em SQL Server). A UNICA tabela SQL Server realmente consultada e
* SigCdPro, e so para LEITURA (imagem do produto exibida ao navegar na
* grade) - por isso nao ha INSERT/UPDATE real para sobrescrever: ver
* comentario em Inserir()/Atualizar().
*------------------------------------------------------------------------------
DEFINE CLASS sigopagrBO AS BusinessBase

    *-- Propriedades do item agrupado (csProdItn / crItensBor no legado)
    this_nCitens  = 0
    this_cCpros   = ""
    this_cDpros   = ""
    this_cCodTams = ""
    this_nMarcas  = 0
    this_nQtds    = 0
    this_nValor   = 0
    this_nPesos   = 0
    this_cFigJpgs = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao SigMvSbnBO/SIGMVCMVBO)
    this_cCursorMovimento = ""                  && equivalente a crTpmMvItn - recebido do form chamador
    this_cCursorItens     = "cursor_4c_Itens"   && grade de itens agrupados, equivalente a crItensBor
    this_cCursorProduto   = "cursor_4c_Produto" && dados/imagem do produto exibido, equivalente a crTPro

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "Cpros"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
    * cursor de itens agrupados (this_cCursorItens, equivalente a crItensBor
    * do legado) para as propriedades this_* do item selecionado na grade.
    *   par_cAliasCursor - alias a ler; se omitido usa this_cCursorItens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
            ELSE
                THIS.this_cCpros   = TratarNulo(Cpros, "")
                THIS.this_cDpros   = TratarNulo(Dpros, "")
                THIS.this_cCodTams = TratarNulo(CodTams, "")
                THIS.this_nMarcas  = TratarNulo(Marcas, 0)
                THIS.this_nQtds    = TratarNulo(Qtds, 0)
                THIS.this_nValor   = TratarNulo(Valor, 0)
                THIS.this_nPesos   = TratarNulo(Pesos, 0)

                *-- csProdItn.cItens eh cursor vestigial do legado (criado no
                *-- Init, nunca populado nem lido em metodo nenhum do dump) -
                *-- crItensBor nao tem essa coluna. Mapear defensivamente so
                *-- quando presente, para a property nao ficar sem sentido
                *-- caso algum dia venha de um cursor de origem diferente.
                IF TYPE("Citens") = "N"
                    THIS.this_nCitens = Citens
                ELSE
                    THIS.this_nCitens = 0
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do item agrupado corrente: Produto +
    * Tamanho (Cpros+CodTams), equivalente ao par usado pelo legado no
    * "Where Cpros = ... And CodTams = ..." do btnConfirmar.Click.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros) + "|" + ALLTRIM(THIS.this_cCodTams)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarItensAgrupados - Agrupa o cursor de movimento (this_cCursorMovimento,
    * equivalente a crTpmMvItn) por Produto+Tamanho+Descricao, somando a
    * quantidade e pegando o maior valor/peso de cada grupo - replica
    * LITERALMENTE o SELECT do Init() legado:
    *   Select 0 as Marcas, Cpros, Dpros, CodTams, Sum(Qtds) as Qtds,
    *          Max(Units) as Valor, Max(Pesos) as Pesos From crTpmMvItn
    *   Where Not Empty(Cpros) Group By Cpros, CodTams, Dpros
    *          Into Cursor crItensBor ReadWrite
    * O cursor de movimento ja chega ABERTO (recebido do form chamador,
    * DataSession compartilhada - o legado usa DataSession=1); esta
    * operacao e 100% local, sem SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE MontarItensAgrupados(par_cCursorMovimento)
        LOCAL loc_cCursorMov, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        loc_cCursorMov = IIF(VARTYPE(par_cCursorMovimento) = "C" AND !EMPTY(par_cCursorMovimento), ;
            par_cCursorMovimento, THIS.this_cCursorMovimento)

        IF EMPTY(loc_cCursorMov) OR !USED(loc_cCursorMov)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        THIS.this_cCursorMovimento = loc_cCursorMov

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            SELECT 0 AS Marcas, Cpros, Dpros, CodTams, ;
                   SUM(Qtds) AS Qtds, MAX(Units) AS Valor, MAX(Pesos) AS Pesos ;
                FROM (loc_cCursorMov) ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros, CodTams, Dpros ;
                INTO CURSOR (THIS.this_cCursorItens) READWRITE

            SELECT (THIS.this_cCursorItens)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosItens - Marca/desmarca TODAS as linhas da grade de itens
    * agrupados. Equivalente ao SelTudo.Click (par_nMarcas = 1) e ao
    * apaga.Click (par_nMarcas = 0) do legado:
    *   Replace All crItensBor.Marcas with 1   (ou 0)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosItens(par_nMarcas)
        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "Cursor " + THIS.this_cCursorItens + " n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH IIF(par_nMarcas = 1, 1, 0)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarItemMovimento - Propaga Pesos/Valor do item CORRENTE (carregado
    * via CarregarDoCursor) para TODAS as linhas do cursor de movimento com o
    * mesmo Produto+Tamanho - replica LITERALMENTE o trecho do
    * btnConfirmar.Click legado (dentro do "Scan for Marcas = 1"):
    *   Update crTpmMvItn set Pesos = crItensBor.Pesos, Units = crItensBor.Valor
    *          where Cpros = crItensBor.Cpros And CodTams = crItensBor.CodTams
    * Este metodo NAO filtra por Marcas - quem decide QUAIS itens propagar e
    * o chamador (o Form varre o cursor de itens e chama isto so para as
    * linhas marcadas, replicando o "Scan for Marcas = 1" do legado).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarItemMovimento()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorMovimento)
            REPLACE ALL Pesos WITH THIS.this_nPesos, ;
                    Units WITH THIS.this_nValor ;
                FOR Cpros = THIS.this_cCpros AND CodTams = THIS.this_cCodTams

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotaisMovimento - Recalcula Totas = Units * Qtds em TODAS as
    * linhas do cursor de movimento - replica LITERALMENTE o trecho final do
    * btnConfirmar.Click legado, executado UMA UNICA VEZ apos propagar todos
    * os itens marcados (fora do loop de AtualizarItemMovimento):
    *   Update crTpmMvItn set Totas = (crTpmMvItn.Units * crTpmMvItn.Qtds)
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularTotaisMovimento()
        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorMovimento)
        REPLACE ALL Totas WITH Units * Qtds
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarImagemProdutoPorCodigo - Consulta Cpros/FigJpgs/Dpros em SigCdPro
    * para o produto corrente, replicando a consulta feita em
    * grdItens.AfterRowColChange do legado:
    *   = ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *                                      crItensBor.Cpros,'FigJpgs')
    * So LEITURA - a decodificacao do base64 (STRCONV) e a gravacao do .jpg
    * temporario (STRTOFILE) ficam no Form, que e quem exibe a Image (padrao
    * do projeto - ver Formsigmvsbn.CarregarImagemProduto).
    *--------------------------------------------------------------------------
    FUNCTION BuscarImagemProdutoPorCodigo(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF EMPTY(par_cCpros)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCpros))

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
            ELSE
                SELECT (THIS.this_cCursorProduto)
                GO TOP

                THIS.this_cFigJpgs = TratarNulo(FigJpgs, "")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar (SQL Server) - SIGOPAGR nunca grava em SigCdPro,
    * a unica tabela SQL Server que toca (e so para LER a imagem do produto -
    * ver BuscarImagemProdutoPorCodigo acima). O codigo fonte legado inteiro
    * (sigopagr_form_codigo_fonte.txt) foi conferido e nao contem nenhum
    * Insert/Update/Delete/TableUpdate/Gather contra o SQL Server - a unica
    * gravacao que o dialogo faz e a propagacao de Pesos/Valor para o cursor
    * de movimento recebido do form chamador (manipulacao de CURSOR local,
    * ver AtualizarItemMovimento/RecalcularTotaisMovimento acima), e isso
    * nao e uma escrita no banco. Por isso nao ha INSERT/UPDATE real para
    * sobrescrever aqui, e RegistrarAuditoria() nunca e chamado por este BO -
    * o comportamento padrao herdado de BusinessBase (recusar a operacao)
    * ja e o correto para este par de metodos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

ENDDEFINE
