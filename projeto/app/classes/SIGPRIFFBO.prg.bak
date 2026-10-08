*==============================================================================
* SIGPRIFFBO.prg
*
* Business Object para FormSIGPRIFF - dialogo generico de entrada de dados
* (equivalente a um InputBox) do fluxo da impressora fiscal / TEF.
*
* Legado: SIGPRIFF.SCX (objeto "form1") - dialogo utilitario SEM tabela.
*   PARAMETERS do Init legado:
*       pcCab, pcTipo, pcTitulo, pcMaximo, pcMinimo, pcDado
*
*   Chamador (sigprtef.PRG linha 181):
*       DO FORM SIGPRIFF WITH Escolhas, lptipo, lcTitulo, TamanhoMinimo, ;
*                             TamanhoMaximo, TipoDados TO Valores
*
*   ATENCAO - o chamador passa Minimo/Maximo em ordem TROCADA em relacao aos
*   PARAMETERS do form. Isso NAO eh defeito a corrigir: o legado resolve com
*   MaxLength = IIF(pcMaximo < pcMinimo, pcMinimo, pcMaximo), ou seja, usa o
*   MAIOR dos dois, o que torna a ordem irrelevante. Transcrever a expressao
*   como esta - nunca "arrumar" a ordem dos parametros.
*
*   O retorno (PUBLIC Resposta do legado) tem TIPO VARIAVEL e o chamador conta
*   com isso: DTOC(Valores) quando pcDado = "D" e TRANSFORM(Valores,
*   "99999999.99") quando pcDado = "V". Por isso a resposta eh guardada em
*   this_uResposta (variante) e NAO pode ser convertida para texto.
*
* Herda de: BusinessBase
* Tabela:   nenhuma - dialogo utilitario, sem persistencia em banco
*==============================================================================

DEFINE CLASS SIGPRIFFBO AS BusinessBase

    *-- Parametros do dialogo (espelham os PARAMETERS do Init legado) ---------
    this_cCabecalho = ""    && pcCab    - lista de opcoes separadas por ";" (modo "M")
                            &&            ou texto do rotulo nos demais modos
    this_cTipo      = ""    && pcTipo   - "M" = multipla escolha (ComboBox);
                            &&            qualquer outro valor = entrada livre (TextBox)
    this_cTitulo    = ""    && pcTitulo - Caption do form
    this_nMaximo    = 0     && pcMaximo - tamanho (ver nota sobre ordem trocada acima)
    this_nMinimo    = 0     && pcMinimo - tamanho (ver nota sobre ordem trocada acima)
    this_cDado      = ""    && pcDado   - "D" = data, "V" = valor numerico,
                            &&            vazio/outro = caractere

    *-- Resultado do dialogo -------------------------------------------------
    this_uResposta  = ""    && Resposta (PUBLIC no legado) - TIPO VARIA conforme
                            && this_cDado: D = Date, V = Numeric, outro = Character.
                            && Legado inicializa com "" (vazio = usuario cancelou,
                            && que o chamador detecta com EMPTY(Valores))

    *-- Opcoes do modo "M" (legado: PUBLIC laOpcoes[lnRep], RowSource do Combo1) 
    DIMENSION this_aOpcoes[1]
    this_nQtdOpcoes = 0     && lnRep - quantidade de opcoes extraidas de this_cCabecalho

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Dialogo utilitario: this_cTabela e this_cCampoChave ficam vazios, de modo
    * que BusinessBase nao instancia DataAccess (o comportamento herdado ja eh
    * o correto para uma tela sem banco).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Estado inicial dos parametros do dialogo
            THIS.this_cCabecalho = ""
            THIS.this_cTipo      = ""
            THIS.this_cTitulo    = ""
            THIS.this_nMaximo    = 0
            THIS.this_nMinimo    = 0
            THIS.this_cDado      = ""

            *-- Legado: Resposta = "" no fim do Init do form
            THIS.this_uResposta = ""

            *-- Lista de opcoes vazia ate ConfigurarDialogo receber this_cCabecalho
            DIMENSION THIS.this_aOpcoes[1]
            THIS.this_aOpcoes[1] = ""
            THIS.this_nQtdOpcoes = 0

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRIFFBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FASE 2 - Metodos CRUD (CarregarDoCursor / Inserir / Atualizar)
    *
    * Dialogo utilitario (equivalente a um InputBox) SEM tabela: this_cTabela
    * e this_cCampoChave ficam vazios desde o Init acima, o legado nunca faz
    * SQLEXEC/AddCursor/TableUpdate (comportamento.json confirma 0 queries) e
    * o unico dado que existe eh this_uResposta, devolvido direto ao chamador
    * via RETURN(Resposta) - nunca grava em SQL Server.
    *
    * CarregarDoCursor(), Inserir() e Atualizar() continuam herdados de
    * BusinessBase: o comportamento padrao (recusar a operacao, pois nunca ha
    * THIS.this_oDataAccess instanciado) ja eh o correto aqui, porque este BO
    * nunca chama Salvar()/Excluir() - quem usa o dialogo le THIS.this_uResposta
    * direto, no padrao Text1/Combo1.KeyPress do legado. ObterChavePrimaria()
    * e RegistrarAuditoria() seguem a mesma logica: nao ha chave primaria nem
    * tabela para auditar. Os metodos abaixo cobrem a logica REAL do dialogo -
    * a mesma que o Init do legado executava (parse das opcoes de "M" e
    * guarda/leitura da resposta).
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ConfigurarParametros - Recebe os PARAMETERS do form legado e prepara o
    * estado do dialogo (espelha o corpo do Init de SIGPRIFF.SCX).
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarParametros(par_cCabecalho, par_cTipo, par_cTitulo, ;
            par_nMaximo, par_nMinimo, par_cDado)

        LOCAL loc_nRep, loc_nA, loc_nInicio, loc_nFim

        THIS.this_cCabecalho = IIF(VARTYPE(par_cCabecalho) = "C", par_cCabecalho, "")
        THIS.this_cTipo      = IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")
        THIS.this_cTitulo    = IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "")
        THIS.this_nMaximo    = IIF(VARTYPE(par_nMaximo) = "N", par_nMaximo, 0)
        THIS.this_nMinimo    = IIF(VARTYPE(par_nMinimo) = "N", par_nMinimo, 0)
        THIS.this_cDado      = IIF(VARTYPE(par_cDado) = "C", par_cDado, "")

        *-- Legado: PUBLIC Resposta = "" ate o usuario digitar/escolher
        THIS.this_uResposta = ""

        IF UPPER(ALLTRIM(THIS.this_cTipo)) == "M"
            *-- Legado: lnRep=Occurs(";",pcCab) / PUBLIC laOpcoes[lnRep] /
            *-- FOR a = 1 TO lnRep / laOpcoes[a] = SUBSTR(pcCab, ...) / NEXT
            loc_nRep = OCCURS(";", THIS.this_cCabecalho)

            IF loc_nRep > 0
                DIMENSION THIS.this_aOpcoes[loc_nRep]

                FOR loc_nA = 1 TO loc_nRep
                    loc_nInicio = IIF(loc_nA = 1, 1, AT(";", THIS.this_cCabecalho, loc_nA - 1) + 1)
                    loc_nFim    = AT(";", THIS.this_cCabecalho, loc_nA) - ;
                                  IIF(loc_nA = 1, 0, AT(";", THIS.this_cCabecalho, loc_nA - 1)) - 1
                    THIS.this_aOpcoes[loc_nA] = SUBSTR(THIS.this_cCabecalho, loc_nInicio, loc_nFim)
                ENDFOR

                THIS.this_nQtdOpcoes = loc_nRep
            ELSE
                *-- Cabecalho sem ";" (uma unica opcao) - nao derruba o dialogo
                DIMENSION THIS.this_aOpcoes[1]
                THIS.this_aOpcoes[1] = THIS.this_cCabecalho
                THIS.this_nQtdOpcoes = IIF(EMPTY(THIS.this_cCabecalho), 0, 1)
            ENDIF
        ELSE
            DIMENSION THIS.this_aOpcoes[1]
            THIS.this_aOpcoes[1] = ""
            THIS.this_nQtdOpcoes = 0
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * EhMultiplaEscolha - .T. quando this_cTipo = "M" (Combo1 em vez de Text1)
    *--------------------------------------------------------------------------
    FUNCTION EhMultiplaEscolha()
        RETURN (UPPER(ALLTRIM(THIS.this_cTipo)) == "M")
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterQuantidadeOpcoes - Numero de opcoes extraidas de this_cCabecalho
    *--------------------------------------------------------------------------
    FUNCTION ObterQuantidadeOpcoes()
        RETURN THIS.this_nQtdOpcoes
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterOpcao - Devolve a opcao de indice par_nIndice (1-based) para
    * popular o RowSource/List do Combo1 do form
    *--------------------------------------------------------------------------
    FUNCTION ObterOpcao(par_nIndice)
        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1 AND par_nIndice <= THIS.this_nQtdOpcoes
            RETURN THIS.this_aOpcoes[par_nIndice]
        ENDIF
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTamanhoCampo - Legado usa o MAIOR entre pcMaximo/pcMinimo como
    * MaxLength do Text1 (o chamador sigprtef.PRG passa os dois em ordem
    * trocada - ver nota no cabecalho do arquivo - por isso o MAX, nao o 1o)
    *--------------------------------------------------------------------------
    FUNCTION ObterTamanhoCampo()
        RETURN IIF(THIS.this_nMaximo < THIS.this_nMinimo, THIS.this_nMinimo, THIS.this_nMaximo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * DefinirResposta / ObterResposta - guardam e devolvem this_uResposta
    * (equivalente a PUBLIC Resposta do legado, lido pelo chamador via
    * RETURN(Resposta) apos o form ser liberado)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirResposta(par_uResposta)
        THIS.this_uResposta = par_uResposta
    ENDPROC

    FUNCTION ObterResposta()
        RETURN THIS.this_uResposta
    ENDFUNC

ENDDEFINE
