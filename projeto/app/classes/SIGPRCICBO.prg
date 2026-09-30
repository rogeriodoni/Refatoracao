*==============================================================================
* SIGPRCICBO.prg - Business Object para escolha de icone (SIGPRCIC)
* Form OPERACIONAL: dialogo modal de selecao de icone do sistema (SigSyIco),
* invocado por outro form (par_oFormPai) para atribuir o icone escolhido ao
* registro identificado por par_cPkChaves nos cursores de programas do
* chamador (mesmo padrao de FormICN/ICNBO: cursor_4c_Prog/cursor_4c_ProgFiltrado)
* Herda de: BusinessBase
* Tabela: SigSyIco | PK: carqicones
*==============================================================================
DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Configuracao da tabela (lista de icones do sistema)
    this_cTabela     = "SigSyIco"
    this_cCampoChave = "carqicones"

    *-- Referencia ao form chamador e chave do registro cujo icone sera trocado
    *-- Espelham poForm1/pcIdChaves do legado (DataSessionId compartilhado)
    this_oFormPai  = .NULL.
    this_cPkChaves = ""

    *-- Cursores compartilhados com o form chamador (mesma DataSession)
    *-- Espelham crSigSyIco1 (icones), crProg1 (todos) e crProg2 (filtrado)
    this_cCursorIcones       = "cursor_4c_Icones"
    this_cCursorProg         = "cursor_4c_Prog"
    this_cCursorProgFiltrado = "cursor_4c_ProgFiltrado"

    *-- Estado resolvido no Init a partir do registro corrente do chamador
    this_cArqIconeAtual     = ""
    this_cDescricaoPrograma = ""

    *-- Estado da linha corrente do grid de icones (SigSyIco), populado por
    *-- CarregarDoCursor() a cada AfterRowColChange/BeforeRowColChange/Scrolled
    *-- do Grid1 (legado) ou DblClick sobre a linha escolhida
    this_cArqIconeSelecionado = ""
    this_mIconeBinario        = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigSyIco"
            THIS.this_cCampoChave = "carqicones"

            THIS.this_oFormPai  = .NULL.
            THIS.this_cPkChaves = ""

            THIS.this_cCursorIcones       = "cursor_4c_Icones"
            THIS.this_cCursorProg         = "cursor_4c_Prog"
            THIS.this_cCursorProgFiltrado = "cursor_4c_ProgFiltrado"

            THIS.this_cArqIconeAtual     = ""
            THIS.this_cDescricaoPrograma = ""

            THIS.this_cArqIconeSelecionado = ""
            THIS.this_mIconeBinario        = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGPRCICBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigSyIco (carqicones,
    * marqicones) do registro CORRENTE do cursor de icones (par_cAliasCursor,
    * tipicamente THIS.this_cCursorIcones) para as properties this_* da linha
    * selecionada no grid. Espelha o que o legado faz em
    * AfterRowColChange/BeforeRowColChange/Scrolled do Grid1 (le
    * crSigSyIco1.ctmpicones para exibir o preview) e no DblClick da coluna
    * (le This.Value, isto eh, crSigSyIco1.carqicones, para aplicar a
    * selecao). ctmpicones do legado eh um campo CALCULADO no SELECT que
    * popula o cursor (caminho fisico extraido de marqicones para o Image
    * de preview) - fica por conta do metodo que POPULA THIS.this_cCursorIcones,
    * nao deste metodo, que so mapeia as colunas REAIS da tabela.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cArqIconeSelecionado = TratarNulo(carqicones, "")
            THIS.this_mIconeBinario        = TratarNulo(marqicones, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - PK de SigSyIco eh carqicones (char(64)). Corresponde
    * ao icone atualmente destacado no grid (this_cArqIconeSelecionado),
    * carregado por CarregarDoCursor() a partir da linha corrente.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cArqIconeSelecionado
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar() - o legado (SIGPRCIC.SCX) NAO grava nem altera
    * registros em SigSyIco: o catalogo de icones do sistema e populado por
    * outro modulo (cadastro/importacao de icones), e esta tela e um DIALOGO
    * DE SELECAO somente-leitura sobre esse catalogo (comportamento.json: os
    * dois metodos do form marcados com "temSQL" sao Init e o Click/DblClick
    * da coluna do grid - nenhum dos dois faz Insert/Update/Delete em
    * SigSyIco, so Select/Seek/Locate de leitura e Replace nos cursores do
    * form chamador). A "gravacao" desta tela e, na
    * verdade, um Replace EM MEMORIA nos cursores do form CHAMADOR
    * (crProg1/crProg2 - aqui this_cCursorProg/this_cCursorProgFiltrado),
    * feito no DblClick da coluna do grid: Replace barrapict With
    * <arquivo escolhido>, barraforms With ... . Isso e orquestracao de
    * selecao (Form chamando o BO do PROGRAMA, nao SQL sobre SigSyIco) e
    * pertence ao metodo que aplica a escolha, nao a Inserir()/Atualizar()
    * desta entidade. O comportamento padrao herdado de BusinessBase
    * (recusar Inserir/Atualizar) ja eh o correto para SigSyIco neste form.
    *==========================================================================

ENDDEFINE
