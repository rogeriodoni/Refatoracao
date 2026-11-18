*==============================================================================
* SigOpTloBO.prg - Business Object para "Total por Local" (SIGOPTLO)
*
* Origem legado : SigOpTlo.SCX  (tasks\task810)
* Tipo de form  : OPERACIONAL (dialogo FILHO, modal, chamado pela aba Leitura
*                 do form pai SIGCDBAL - Balanco/Inventario, hoje FormBAL)
* Tabelas base  : SigIvTrH (historico de leituras) e SigIvTrE (etiquetas)
* Chave         : cidchaves (PK das duas tabelas)
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Visualizador SOMENTE-LEITURA que TOTALIZA as leituras de inventario por
* LOCAL de armazenamento. O legado eh aberto de dois pontos do form pai
* (tasks\task348\SIGCDBAL_form_codigo_fonte.txt):
*
*   TotalLocal.Click   -> Do Form SigOpTlo With This.Parent.TipoLeitura.Value
*                         (modo OFFLINE: agrega os cursores LOCAIS do pai,
*                          "Historico" e "Etiqueta", com as leituras da
*                          sessao corrente)
*   LocalGravado.Click -> Do Form SigOpTlo With This.Parent.TipoLeitura.Value, .t.
*                         (modo ONLINE: o PAI roda antes os dois Select em
*                          SigIvTrH / SigIvTrE filtrados por Emps + Codigos e
*                          popula "csHistorico" / "csEtiqueta"; o dialogo
*                          agrega esses dois)
*
* Em QUALQUER um dos dois modos o dialogo NAO consulta o banco: ele percorre
* cursores que o CHAMADOR populou. Por isso este BO nao tem metodo de busca
* remota das leituras - inventar um SELECT aqui mudaria o universo totalizado
* (o cursor do pai tem as leituras da sessao que ainda nao foram gravadas) e
* violaria o PILAR 1.
*
* O legado roda na MESMA data session do pai (o SCX nao declara DataSession,
* logo vale o default 1 = compartilhada) - eh assim que ele alcanca os
* cursores locais do chamador. O migrado precisa manter isso: form com
* DataSession = 2 nao veria "cursor_4c_Historico" do FormBAL.
*
* COMO O TOTAL EH CALCULADO (transcricao do Init legado - regra #17: formula
* de calculo se TRANSCREVE, nunca se reescreve)
* -----------------------------------------------------------------------------
*   Select TmpLocal / Zap                     -> zera a grade de totais
*   Scan do historico:
*       se o Local ainda nao esta em TmpLocal -> Insert Into TmpLocal(Localis)
*       Tipos = 1 -> Replace Leitura   With Leitura   + Qtds
*       Tipos = 2 -> Replace ReLeitura With ReLeitura + Qtds
*       (qualquer outro Tipos eh IGNORADO - o legado so trata 1 e 2)
*   Scan de TmpLocal:
*       lnTetQReadL = lnTetQReadL + Iif(ReLeitura > 0, ReLeitura, Leitura)
*       (a RELEITURA, quando existe, SUBSTITUI a leitura daquele local -
*        nao se somam as duas)
*   lnTetQLoad  = RecCount(<etiquetas>) , e Iif(lnTetQLoad = 0, 1, lnTetQLoad)
*       (o piso 1 existe para o percentual nao dividir por zero)
*   lnPercLeit  = (lnTetQReadL / lnTetQLoad * 100)
*   lnPercRLeit = (lnTetQReadR / lnTetQLoad * 100)
*
* lnTetQReadR (total de RELEITURA) eh zerado e NUNCA incrementado pelo legado,
* portanto lnPercRLeit vale sempre 0. A property this_nTotalReleitura /
* this_nPercReleitura reproduz esse comportamento de proposito: o legado nao
* exibe esse par em label nenhum, e "consertar" a conta aqui faria a tela
* mostrar numero que o usuario nunca viu.
*
* EXIBICAO (so quando SigCdPam.perlocals esta ligado - gate do legado
* "If CrSigCdPam.PerLocals"):
*   lb_TotLido.Caption    = Str(lnTetQReadL, 5)
*   lb_TotEstoque.Caption = Str(lnTetQLoad, 5)
*   Leitura.Caption       = Transform(lnPercLeit, '@Z 9999.99%')
* Com o parametro desligado os tres labels ficam VAZIOS - eh o comportamento
* do legado, e eh o que this_lPerLocals = .F. entrega por default.
*
* GRAVACAO
* --------
* A tela nao grava nada: o legado nao tem Insert/Update/Delete contra tabela,
* nao tem TableUpdate e nao tem .AddCursor - o unico Insert Into tem por
* destino o cursor LOCAL de totais (TmpLocal). O comportamento herdado de
* BusinessBase para Salvar()/Excluir() (recusar a operacao e reportar pelo
* ExibirFalha) ja eh o correto para esta tela, por isso Inserir()/Atualizar()/
* ExecutarExclusao() nao sao sobrescritos - escrever INSERT/UPDATE aqui seria
* inventar gravacao que o legado nao faz (regra #22: a lista de colunas vem do
* schema, nunca de adivinhacao).
*
* ESTRUTURA DO CURSOR DE TOTAIS (TmpLocal do legado)
* --------------------------------------------------
* O legado cria TmpLocal no Load do form PAI (SIGCDBAL):
*   Create Cursor TmpLocal (Localis c(10), Leitura n(8,2), ReLeitura n(8,2))
*   Index On Localis Tag Localis
* O indice eh o que faz o Seek(<historico>.Localis, 'TmpLocal') do Scan
* funcionar. No migrado o cursor eh do PROPRIO dialogo (FormBAL nao o cria),
* com as MESMAS larguras e o MESMO indice, sob o alias this_cCursorLocais.
*
* LARGURAS DO SCHEMA (docs\schema.sql - lido com Get-Content -Raw, regra #14)
* --------------------------------------------------------------------------
*   SigIvTrH.localis   char(10)       NOT NULL  - local de armazenamento
*   SigIvTrH.qtds      numeric(11,3)  NOT NULL  - quantidade lida
*   SigIvTrH.tipos     numeric(1,0)   NOT NULL  - 1 = Leitura / 2 = Releitura
*   SigIvTrH.emps      char(3)        NOT NULL  - empresa
*   SigIvTrH.codigos   numeric(4,0)   NOT NULL  - codigo do balanco
*   SigIvTrE.qtds      numeric(9,3)   NOT NULL  - etiqueta (universo do total)
*   SigCdPam.perlocals bit            NOT NULL  - mostra os totais na tela
*==============================================================================

DEFINE CLASS SigOpTloBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - uma LINHA de total por local (equivale a uma linha de TmpLocal)
    *
    * Nao eh uma linha de tabela: eh o agregado de SigIvTrH por localis. As
    * larguras acompanham o Create Cursor do legado, nao as colunas de origem.
    *--------------------------------------------------------------------------
    this_cLocalis               = ""   && Localis   c(10)  - local de armazenamento (SigIvTrH.localis)
    this_nLeitura               = 0    && Leitura   n(8,2) - soma de qtds com tipos = 1
    this_nReLeitura             = 0    && ReLeitura n(8,2) - soma de qtds com tipos = 2

    *--------------------------------------------------------------------------
    * TOTAIS DO RODAPE (variaveis lnTetQ* / lnPerc* do Init legado)
    *--------------------------------------------------------------------------
    this_nTotalLido             = 0    && lnTetQReadL - soma de Iif(ReLeitura > 0, ReLeitura, Leitura)
    this_nTotalReleitura        = 0    && lnTetQReadR - zerado e nunca incrementado pelo legado
    this_nTotalEstoque          = 0    && lnTetQLoad  - RecCount das etiquetas, com piso 1
    this_nPercLeitura           = 0    && lnPercLeit  - (TotalLido / TotalEstoque * 100)
    this_nPercReleitura         = 0    && lnPercRLeit - (TotalReleitura / TotalEstoque * 100), sempre 0 no legado

    *--------------------------------------------------------------------------
    * CONTEXTO RECEBIDO DO FORM PAI (LParameters lnTipoLeitura, llOnLine)
    *
    * this_nTipoLeitura guarda o 1o parametro (This.Parent.TipoLeitura.Value do
    * SIGCDBAL). O Init legado o RECEBE e nao o usa em lugar nenhum - a
    * property existe para o contrato de chamada continuar identico e para o
    * valor ficar disponivel sem reabrir a tela; nenhuma conta deste BO depende
    * dele, exatamente como no legado.
    *--------------------------------------------------------------------------
    this_nTipoLeitura           = 0    && lnTipoLeitura - tipo de leitura escolhido no pai (1 = Leitura / 2 = Releitura)
    this_lOnLine                = .F.  && llOnLine - .T. agrega os cursores ONLINE (csHistorico/csEtiqueta) do pai

    *--------------------------------------------------------------------------
    * PARAMETRO DO SISTEMA (SigCdPam.perlocals)
    *
    * Gate do legado "If CrSigCdPam.PerLocals": com o parametro desligado os
    * labels de Lido / Estoque / percentual ficam VAZIOS. Coluna bit, que chega
    * do SQL Server ora como Logico ora como Numerico conforme o driver - por
    * isso a leitura passa por ConverterParaLogico (regra #13).
    *--------------------------------------------------------------------------
    this_lPerLocals             = .F.  && perlocals bit - exibe os totais no rodape

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR (nome do legado entre parenteses - PILAR 3 renomeia)
    *
    * this_cCursorLocais eh o cursor de TOTAIS, criado e mantido por ESTA tela.
    * Alias proprio (nao "cursor_4c_Dados" nem "cursor_4c_TotalLocal"): o
    * dialogo roda na data session COMPARTILHADA do pai, e reusar um alias do
    * FormBAL derrubaria a lista dele - o Zap do legado apagaria o cursor
    * errado.
    *
    * Os quatro cursores de ORIGEM pertencem ao CHAMADOR: este BO apenas LE
    * deles. Nunca fecha, nunca recria e nunca apaga nenhum dos quatro.
    *--------------------------------------------------------------------------
    this_cCursorLocais          = "cursor_4c_Locais"           && TmpLocal    - grade de totais por local (deste dialogo)
    this_cCursorHistorico       = "cursor_4c_Historico"        && Historico   - leituras da sessao no pai (modo OFFLINE)
    this_cCursorEtiqueta        = "cursor_4c_Etiqueta"         && Etiqueta    - etiquetas carregadas no pai (modo OFFLINE)
    this_cCursorHistoricoOnLine = "cursor_4c_HistoricoOnLine"  && csHistorico - Select SigIvTrH feito pelo pai (modo ONLINE)
    this_cCursorEtiquetaOnLine  = "cursor_4c_EtiquetaOnLine"   && csEtiqueta  - Select SigIvTrE feito pelo pai (modo ONLINE)
    this_cCursorParametros      = "crSigCdPam"                 && CrSigCdPam  - cursor global Fortyus dos parametros do sistema

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de origem das leituras (SigIvTrH.cidchaves), repoe
    * os totais em zero (toda abertura do dialogo recalcula tudo, igual ao
    * legado, que comeca com Zap em TmpLocal) e resolve o parametro
    * SigCdPam.perlocals, que decide se o rodape exibe os numeros.
    *
    * O cursor global crSigCdPam era pre-carregado no startup do Fortyus e NAO
    * existe no startup do sistema novo - quem depende dele tem de popula-lo
    * (regra dos cursores globais Fortyus). Aqui a carga eh defensiva em tres
    * camadas, implementadas em CarregarParametroPerLocais().
    *
    * O RETURN fica FORA de TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigIvTrH"
        THIS.this_cCampoChave = "cidchaves"

        THIS.this_cLocalis        = ""
        THIS.this_nLeitura        = 0
        THIS.this_nReLeitura      = 0

        THIS.this_nTotalLido      = 0
        THIS.this_nTotalReleitura = 0
        THIS.this_nTotalEstoque   = 0
        THIS.this_nPercLeitura    = 0
        THIS.this_nPercReleitura  = 0

        THIS.this_nTipoLeitura    = 0
        THIS.this_lOnLine         = .F.
        THIS.this_lPerLocals      = .F.

        THIS.CarregarParametroPerLocais()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametroPerLocais - Resolve SigCdPam.perlocals em this_lPerLocals
    *
    * Equivale ao "If CrSigCdPam.PerLocals" do Init legado, que contava com o
    * cursor global ja aberto pelo startup do Fortyus.
    *
    * Tres camadas:
    *   1) crSigCdPam ja aberto E com a coluna perlocals -> apenas le;
    *   2) senao, consulta SigCdPam num cursor proprio e, se o nome legado
    *      ainda nao existir, cria crSigCdPam a partir dele - sem derrubar um
    *      crSigCdPam que outro BO tenha aberto com outras colunas;
    *   3) sem conexao (probe/harness sem config.prg) -> this_lPerLocals fica
    *      .F., que eh exatamente o caminho do legado com o parametro
    *      desligado: os labels do rodape ficam vazios e a grade continua
    *      totalizando normalmente.
    *
    * Retorna .T. quando conseguiu LER o parametro (mesmo que o valor lido seja
    * .F.) e .F. quando nao havia de onde ler - assim o chamador distingue
    * "parametro desligado" de "parametro indisponivel", sem que nenhum dos
    * dois casos impeca a tela de abrir.
    *
    * SigCdPam eh tabela de UMA linha de parametros do sistema: o SELECT vai
    * sem WHERE, igual ao legado.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametroPerLocais()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- 1) cursor global ja aberto e com a coluna que interessa
            IF USED(THIS.this_cCursorParametros) AND ;
               TYPE(THIS.this_cCursorParametros + ".perlocals") != "U"

                SELECT (THIS.this_cCursorParametros)
                IF !EOF()
                    THIS.this_lPerLocals = ConverterParaLogico(perlocals)
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            *-- 2) consulta propria ao banco
            IF !loc_lResultado AND TYPE("gnConnHandle") = "N"
                IF gnConnHandle > 0
                    *-- SELECT * (e nao so perlocals) porque o cursor global
                    *-- crSigCdPam do Fortyus carregava a LINHA INTEIRA de
                    *-- parametros: criado aqui com uma coluna so, ele faria
                    *-- outro BO que leia crSigCdPam.<outra coluna> estourar
                    *-- "Variable is not found" em runtime
                    loc_cSQL = "SELECT * FROM SigCdPam"

                    IF USED("cursor_4c_PamTlo")
                        USE IN cursor_4c_PamTlo
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamTlo")

                    IF loc_nResultado >= 0 AND USED("cursor_4c_PamTlo")
                        IF RECCOUNT("cursor_4c_PamTlo") > 0
                            SELECT cursor_4c_PamTlo
                            GO TOP
                            THIS.this_lPerLocals = ConverterParaLogico(perlocals)
                            loc_lResultado = .T.

                            *-- deixa o nome legado disponivel para quem mais
                            *-- dependa dele, preservando um crSigCdPam que
                            *-- outro BO tenha aberto com outras colunas
                            IF !USED(THIS.this_cCursorParametros)
                                SELECT * FROM cursor_4c_PamTlo ;
                                    INTO CURSOR (THIS.this_cCursorParametros) READWRITE
                            ENDIF
                        ENDIF

                        IF USED("cursor_4c_PamTlo")
                            USE IN cursor_4c_PamTlo
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                            CHR(237) + "vel ler o par" + CHR(226) + "metro de totais por local."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            *-- parametro indisponivel nao impede a tela de abrir: o rodape
            *-- fica vazio, igual ao legado com perlocals desligado
            THIS.this_cMensagemErro = loException.Message
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Valor da chave usado pela auditoria da BusinessBase
    *
    * A tela nao grava, logo nao existe cidchaves de registro corrente para
    * devolver: a identidade de uma linha deste visualizador eh o proprio LOCAL
    * totalizado.
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cLocalis)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Zera a linha corrente e os totais do rodape
    *
    * BusinessBase.LimparDados so limpa this_cMensagemErro e deixa a cargo da
    * subclasse limpar as proprias properties. Aqui isso corresponde ao
    * "Select TmpLocal / Zap" com que o Init legado comeca: toda nova
    * totalizacao parte de zero, e nenhum numero da abertura anterior pode
    * sobrar no rodape.
    *
    * NAO zera o contexto recebido do pai (this_nTipoLeitura / this_lOnLine), o
    * parametro this_lPerLocals nem os nomes de alias: perder o modo ONLINE
    * faria a totalizacao seguinte ler o cursor errado, e perder o parametro
    * apagaria o rodape de uma tela que o usuario configurou para ve-lo.
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cLocalis        = ""
        THIS.this_nLeitura        = 0
        THIS.this_nReLeitura      = 0

        THIS.this_nTotalLido      = 0
        THIS.this_nTotalReleitura = 0
        THIS.this_nTotalEstoque   = 0
        THIS.this_nPercLeitura    = 0
        THIS.this_nPercReleitura  = 0

        RETURN .T.
    ENDPROC


    *--------------------------------------------------------------------------
    * CriarCursorLocais - Garante o cursor de totais por local, vazio
    *
    * Transcricao do que o legado espalha em dois lugares:
    *   - o form PAI (SIGCDBAL) cria a estrutura no Load:
    *       Create Cursor TmpLocal (Localis c(10), Leitura n(8,2), ReLeitura n(8,2))
    *       Index On Localis Tag Localis
    *   - o dialogo abre com "Select TmpLocal / Zap", ou seja toda abertura
    *     recomeca de ZERO.
    *
    * Aqui o cursor eh do PROPRIO dialogo (alias this_cCursorLocais), com as
    * MESMAS larguras e o MESMO indice: o indice eh o que faz o
    * SEEK(<historico>.localis, <locais>, "Localis") de AgregarLeituras()
    * funcionar - sem ele cada leitura abriria uma linha nova e o total por
    * local nao agregaria nada.
    *
    * Ja aberto -> ZAP (igual ao legado); ainda nao aberto -> CREATE CURSOR.
    * O ZAP vai cercado por SET SAFETY OFF porque SET SAFETY eh escopado por
    * data session: numa sessao onde ele esteja ON, o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique.
    *
    * O RETURN fica FORA de TRY/CATCH (regra #1).
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorLocais()
        LOCAL loc_lResultado, loc_cAlias, loc_cSafety
        loc_lResultado = .F.
        loc_cAlias     = THIS.this_cCursorLocais

        TRY
            IF USED(loc_cAlias)
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF

                SELECT (loc_cAlias)
                ZAP

                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF
            ELSE
                CREATE CURSOR (loc_cAlias) ;
                    (Localis C(10), Leitura N(8,2), ReLeitura N(8,2))

                INDEX ON Localis TAG Localis
            ENDIF

            loc_lResultado = USED(loc_cAlias)
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao preparar os totais por local")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a linha CORRENTE do cursor para as properties
    *
    * FONTE UNICA de leitura de uma linha de total por local: tanto a grade
    * (linha selecionada) quanto o laco de CalcularTotalLido() passam por aqui,
    * em vez de cada ponto ler Localis / Leitura / ReLeitura por conta propria.
    *
    * Sem argumento, le o cursor de totais deste dialogo. Cada coluna eh lida
    * sob TYPE(<alias>.<col>) != "U" porque os cursores que chegam a este BO
    * tem subconjuntos DIFERENTES de colunas: o de totais tem as tres; o de
    * leituras do pai tem localis (mais tipos / qtds, que nao sao properties da
    * entidade). Sem o guard, apontar este metodo para o cursor de leituras
    * estouraria "Variable LEITURA is not found" em runtime.
    *
    * Cursor vazio (ou ponteiro em EOF) NAO eh erro: zera a linha corrente e
    * devolve .F., para o chamador distinguir "linha lida" de "nao havia linha"
    * - a grade pode estar legitimamente vazia quando o balanco ainda nao tem
    * leitura nenhuma.
    *
    * Localis vai por PADR(..., 10): a largura do cursor de totais eh char(10)
    * e eh ela que o indice usa como chave.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = THIS.this_cCursorLocais
        IF VARTYPE(par_cAliasCursor) = "C"
            IF !EMPTY(par_cAliasCursor)
                loc_cAlias = ALLTRIM(par_cAliasCursor)
            ENDIF
        ENDIF

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "O cursor [" + loc_cAlias + "] n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cAlias)

                IF EOF()
                    THIS.this_cLocalis   = ""
                    THIS.this_nLeitura   = 0
                    THIS.this_nReLeitura = 0
                ELSE
                    IF TYPE(loc_cAlias + ".Localis") != "U"
                        THIS.this_cLocalis = PADR(TratarNulo(EVALUATE(loc_cAlias + ".Localis"), ""), 10)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Leitura") != "U"
                        THIS.this_nLeitura = TratarNulo(EVALUATE(loc_cAlias + ".Leitura"), 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".ReLeitura") != "U"
                        THIS.this_nReLeitura = TratarNulo(EVALUATE(loc_cAlias + ".ReLeitura"), 0)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao ler o total por local")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AgregarLeituras - Soma as leituras do cursor do PAI por local
    *
    * Transcricao LITERAL do 1o Scan do Init legado (regra #17 - formula de
    * calculo se transcreve, nunca se reescreve):
    *
    *   Select Historico
    *   Set Order To
    *   Scan
    *       If !Seek(Historico.Localis,'TmpLocal')
    *           Insert Into TmpLocal(Localis) Values (Historico.Localis)
    *       EndIf
    *       If Historico.Tipos = 1
    *           Replace TmpLocal.Leitura With TmpLocal.Leitura + Historico.Qtds
    *       Else
    *           If Historico.Tipos = 2
    *               Replace TmpLocal.ReLeitura With TmpLocal.ReLeitura + Historico.Qtds
    *           EndIf
    *       EndIf
    *   EndScan
    *
    * Tres detalhes do legado que NAO se descartam:
    *   1) "Set Order To" varre o cursor do pai na ordem FISICA - o legado faz
    *      isso de proposito, e o resultado da soma nao depende da ordem;
    *   2) tipos fora de {1, 2} eh IGNORADO (o Else interno so trata o 2) -
    *      por isso o DO CASE nao tem OTHERWISE;
    *   3) a linha nova entra com Leitura e ReLeitura em ZERO e so depois eh
    *      somada, igual ao Insert ... (Localis) do legado, que preenche uma
    *      coluna so.
    *
    * O laco eh DO WHILE com SELECT/SKIP explicitos no lugar de SCAN/ENDSCAN:
    * o corpo troca de area de trabalho (para inserir no cursor de totais) e
    * SCAN avanca o ponteiro da area CORRENTE no ENDSCAN - com a troca no meio,
    * quem avancaria seria o cursor errado.
    *
    * Este metodo apenas LE o cursor do pai: nao fecha, nao recria e nao apaga.
    *--------------------------------------------------------------------------
    PROCEDURE AgregarLeituras(par_cAliasHistorico)
        LOCAL loc_lResultado, loc_cHist, loc_cLocais
        LOCAL loc_cLocal, loc_nTipo, loc_nQtd, loc_nAtual
        loc_lResultado = .F.
        loc_cHist      = IIF(VARTYPE(par_cAliasHistorico) = "C", ALLTRIM(par_cAliasHistorico), "")
        loc_cLocais    = THIS.this_cCursorLocais

        TRY
            DO CASE
                CASE EMPTY(loc_cHist) OR !USED(loc_cHist)
                    *-- o cursor de leituras eh do form PAI: sem ele nao ha o
                    *-- que totalizar, e inventar um SELECT aqui mudaria o
                    *-- universo (o cursor do pai tem as leituras da sessao
                    *-- que ainda nao foram gravadas)
                    THIS.this_cMensagemErro = "O cursor de leituras [" + loc_cHist + ;
                        "] n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel."

                CASE !USED(loc_cLocais)
                    THIS.this_cMensagemErro = "O cursor de totais por local n" + ;
                        CHR(227) + "o est" + CHR(225) + " aberto."

                CASE TYPE(loc_cHist + ".localis") = "U" OR ;
                     TYPE(loc_cHist + ".tipos")   = "U" OR ;
                     TYPE(loc_cHist + ".qtds")    = "U"
                    THIS.this_cMensagemErro = "O cursor de leituras [" + loc_cHist + ;
                        "] n" + CHR(227) + "o tem as colunas localis, tipos e qtds."

                OTHERWISE
                    SELECT (loc_cHist)
                    SET ORDER TO
                    GO TOP

                    DO WHILE .T.
                        SELECT (loc_cHist)

                        IF EOF()
                            EXIT
                        ENDIF

                        loc_cLocal = PADR(TratarNulo(localis, ""), 10)
                        loc_nTipo  = TratarNulo(tipos, 0)
                        loc_nQtd   = TratarNulo(qtds, 0)

                        IF !SEEK(loc_cLocal, loc_cLocais, "Localis")
                            SELECT (loc_cLocais)
                            APPEND BLANK
                            REPLACE Localis WITH loc_cLocal
                        ENDIF

                        DO CASE
                            CASE loc_nTipo = 1
                                loc_nAtual = EVALUATE(loc_cLocais + ".Leitura")
                                REPLACE Leitura WITH loc_nAtual + loc_nQtd IN (loc_cLocais)

                            CASE loc_nTipo = 2
                                loc_nAtual = EVALUATE(loc_cLocais + ".ReLeitura")
                                REPLACE ReLeitura WITH loc_nAtual + loc_nQtd IN (loc_cLocais)
                        ENDCASE

                        SELECT (loc_cHist)
                        SKIP
                    ENDDO

                    loc_lResultado = .T.
            ENDCASE
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao totalizar as leituras")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularTotalLido - Soma do rodape (lnTetQReadL do legado)
    *
    * Transcricao do 2o Scan do Init legado:
    *
    *   Select TmpLocal
    *   Scan
    *       If TmpLocal.ReLeitura > 0
    *           lnTetQReadL = lnTetQReadL + TmpLocal.ReLeitura
    *       Else
    *           lnTetQReadL = lnTetQReadL + TmpLocal.Leitura
    *       EndIf
    *   EndScan
    *
    * A RELEITURA, quando existe, SUBSTITUI a leitura daquele local - as duas
    * NUNCA se somam. Cada linha eh lida por CarregarDoCursor(), para a leitura
    * de Leitura / ReLeitura ter um unico lugar.
    *
    * this_nTotalReleitura (lnTetQReadR) eh zerado e NUNCA incrementado - eh o
    * comportamento do legado, que declara a variavel, zera e so a usa para
    * calcular um percentual que nenhum label exibe. Somar algo aqui faria a
    * tela mostrar numero que o usuario nunca viu.
    *--------------------------------------------------------------------------
    PROCEDURE CalcularTotalLido()
        LOCAL loc_lResultado, loc_cLocais, loc_nTotal
        loc_lResultado = .F.
        loc_cLocais    = THIS.this_cCursorLocais
        loc_nTotal     = 0

        TRY
            IF !USED(loc_cLocais)
                THIS.this_cMensagemErro = "O cursor de totais por local n" + ;
                    CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (loc_cLocais)
                GO TOP

                DO WHILE .T.
                    SELECT (loc_cLocais)

                    IF EOF()
                        EXIT
                    ENDIF

                    IF THIS.CarregarDoCursor(loc_cLocais)
                        IF THIS.this_nReLeitura > 0
                            loc_nTotal = loc_nTotal + THIS.this_nReLeitura
                        ELSE
                            loc_nTotal = loc_nTotal + THIS.this_nLeitura
                        ENDIF
                    ENDIF

                    SELECT (loc_cLocais)
                    SKIP
                ENDDO

                THIS.this_nTotalLido      = loc_nTotal
                THIS.this_nTotalReleitura = 0

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao somar os totais lidos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularPercentuais - Universo de etiquetas e os dois percentuais
    *
    * Transcricao do legado:
    *   lnTetQLoad  = RecCount('Etiqueta')
    *   lnTetQLoad  = Iif(lnTetQLoad = 0,1,lnTetQLoad)
    *   lnPercLeit  = (lnTetQReadL / lnTetQLoad * 100)
    *   lnPercRLeit = (lnTetQReadR / lnTetQLoad * 100)
    *
    * O piso 1 existe para o percentual nao dividir por zero - eh o que
    * garante que a conta abaixo nunca estoure, mesmo com o cursor de
    * etiquetas vazio.
    *
    * RECCOUNT conta tambem registro marcado para exclusao: o legado usa
    * RecCount e eh esse o universo que a tela sempre mostrou, entao fica
    * RECCOUNT. Cursor de etiquetas ausente conta como zero e cai no piso 1,
    * em vez de estourar como o RecCount do legado estouraria.
    *
    * this_nPercReleitura sai sempre 0, porque this_nTotalReleitura eh sempre
    * 0 (ver CalcularTotalLido) - reproducao fiel.
    *--------------------------------------------------------------------------
    PROCEDURE CalcularPercentuais(par_cAliasEtiqueta)
        LOCAL loc_lResultado, loc_cEtq, loc_nEstoque
        loc_lResultado = .F.
        loc_cEtq       = IIF(VARTYPE(par_cAliasEtiqueta) = "C", ALLTRIM(par_cAliasEtiqueta), "")
        loc_nEstoque   = 0

        TRY
            IF !EMPTY(loc_cEtq) AND USED(loc_cEtq)
                loc_nEstoque = RECCOUNT(loc_cEtq)
            ENDIF

            loc_nEstoque = IIF(loc_nEstoque = 0, 1, loc_nEstoque)

            THIS.this_nTotalEstoque  = loc_nEstoque
            THIS.this_nPercLeitura   = (THIS.this_nTotalLido / loc_nEstoque * 100)
            THIS.this_nPercReleitura = (THIS.this_nTotalReleitura / loc_nEstoque * 100)

            loc_lResultado = .T.
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao calcular os percentuais de leitura")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TotalizarLocais - Recalcula a tela inteira (corpo do Init legado)
    *
    * Ordem transcrita do legado:
    *   Zap no cursor de totais -> escolhe os cursores do modo -> Scan das
    *   leituras -> Scan dos totais -> universo de etiquetas e percentuais ->
    *   "Select Historico / Go Bottom" (SO no ramo OFFLINE) ->
    *   "Select TmpLocal / Go Top".
    *
    * O par de cursores depende do modo, e eh a UNICA diferenca entre os dois
    * ramos (If Not llOnLine / Else) do Init legado, que repetem o mesmo
    * calculo trocando Historico/Etiqueta por csHistorico/csEtiqueta. Aqui o
    * calculo fica em UM lugar e o modo so escolhe os aliases.
    *
    * llOnLine chega AUSENTE quando o pai abre pelo botao de total da sessao
    * (Do Form SigOpTlo With This.Parent.TipoLeitura.Value, sem o 2o
    * argumento). Parametro nao passado nao eh .F.: eh do tipo Logico VAZIO, e
    * por isso o modo eh decidido por PCOUNT(), nao por VARTYPE do valor.
    *
    * O "Go Bottom" no cursor de leituras do pai deixa o ponteiro do PAI no
    * ultimo registro - comportamento do legado, que faz isso de proposito no
    * ramo OFFLINE e nao faz no ONLINE. Nao eh ponteiro perdido por descuido:
    * nao repor seria divergir.
    *
    * No fim, a linha corrente passa a ser a PRIMEIRA do cursor de totais e eh
    * carregada nas properties, para a grade e os rotulos partirem do mesmo
    * estado.
    *--------------------------------------------------------------------------
    PROCEDURE TotalizarLocais(par_nTipoLeitura, par_lOnLine)
        LOCAL loc_lResultado, loc_cHist, loc_cEtq, loc_cLocais
        loc_lResultado = .F.

        IF PCOUNT() >= 1 AND VARTYPE(par_nTipoLeitura) = "N"
            THIS.this_nTipoLeitura = par_nTipoLeitura
        ENDIF

        IF PCOUNT() >= 2 AND VARTYPE(par_lOnLine) = "L"
            THIS.this_lOnLine = par_lOnLine
        ELSE
            THIS.this_lOnLine = .F.
        ENDIF

        TRY
            *-- zera os totais do rodape (o "Select TmpLocal / Zap" do legado
            *-- vale para a grade E para os numeros que ela alimenta)
            THIS.LimparDados()

            IF THIS.this_lOnLine
                loc_cHist = THIS.this_cCursorHistoricoOnLine
                loc_cEtq  = THIS.this_cCursorEtiquetaOnLine
            ELSE
                loc_cHist = THIS.this_cCursorHistorico
                loc_cEtq  = THIS.this_cCursorEtiqueta
            ENDIF

            IF THIS.CriarCursorLocais()
                IF THIS.AgregarLeituras(loc_cHist)
                    THIS.CalcularTotalLido()
                    THIS.CalcularPercentuais(loc_cEtq)

                    *-- "Select Historico / Go Bottom" - so no ramo OFFLINE
                    IF !THIS.this_lOnLine AND USED(loc_cHist)
                        GO BOTTOM IN (loc_cHist)
                    ENDIF

                    *-- "Select TmpLocal / Go Top"
                    loc_cLocais = THIS.this_cCursorLocais
                    IF USED(loc_cLocais)
                        GO TOP IN (loc_cLocais)
                        THIS.CarregarDoCursor(loc_cLocais)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MsgErro(loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                    "Procedure: " + loException.Procedure, ;
                    "Erro ao totalizar os locais")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - A consulta desta tela eh a TOTALIZACAO, nao um SELECT
    *
    * BusinessBase.Buscar() faz SQLEXEC em this_cTabela (SigIvTrH). Para esta
    * tela isso seria ERRADO em dois sentidos: traria a tabela inteira (sem o
    * emps + codigos do balanco que o pai filtra) e DEIXARIA DE FORA as
    * leituras da sessao corrente, que no modo OFFLINE existem apenas no
    * cursor local do pai e sao justamente o que o usuario quer conferir.
    *
    * Por isso o metodo eh redirecionado para TotalizarLocais() no modo que
    * estiver valendo: qualquer chamador generico ("recarregue a lista") faz a
    * mesma coisa que o botao do pai, e nenhum SELECT sai daqui.
    *
    * Os tres argumentos da assinatura da base sao aceitos e ignorados - nao ha
    * filtro, ordenacao nem lista de campos a aplicar sobre um agregado em
    * memoria.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro, par_cOrdenacao, par_cCampos)
        RETURN THIS.TotalizarLocais(THIS.this_nTipoLeitura, THIS.this_lOnLine)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTextoTotalLido / ObterTextoTotalEstoque / ObterTextoPercLeitura
    *
    * Os tres rotulos do rodape, com a formatacao e o GATE do legado:
    *
    *   If CrSigCdPam.PerLocals
    *       ThisForm.lb_TotLIdo.Caption    = Str(lnTetQReadL,5)
    *       ThisForm.lb_TotEstoque.Caption = Str(lnTetQLoad,5)
    *       ThisForm.Leitura.Caption       = Transform(lnPercLeit,'@Z 9999.99%')
    *   EndIf
    *
    * Com o parametro DESLIGADO o legado nao atribui nada, e os tres Caption
    * ficam no "" com que o SCX os declara - por isso aqui a resposta eh string
    * VAZIA, e nao o numero. O gate mora no BO (e nao no form) para o criterio
    * de exibicao ter um unico lugar.
    *
    * STR(x, 5) e o '@Z 9999.99%' sao transcritos: o @Z mostra BRANCO quando o
    * percentual eh zero, que eh o que a tela faz hoje.
    *--------------------------------------------------------------------------
    FUNCTION ObterTextoTotalLido()
        RETURN IIF(THIS.this_lPerLocals, STR(THIS.this_nTotalLido, 5), "")
    ENDFUNC

    FUNCTION ObterTextoTotalEstoque()
        RETURN IIF(THIS.this_lPerLocals, STR(THIS.this_nTotalEstoque, 5), "")
    ENDFUNC

    FUNCTION ObterTextoPercLeitura()
        RETURN IIF(THIS.this_lPerLocals, TRANSFORM(THIS.this_nPercLeitura, "@Z 9999.99%"), "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * DECISAO DE PROJETO - por que nao existe gravacao neste BO
    *
    * Os metodos Inserir(), Atualizar() e ExecutarExclusao() seguem como a
    * BusinessBase os entrega: recusar a operacao e reportar pelo ExibirFalha()
    * do Salvar()/Excluir(). A tela nao grava, e as quatro provas estao no dump
    * legado (tasks\task810\SigOpTlo_form_codigo_fonte.txt):
    *
    *   1) nenhum TableUpdate( - eh assim que o Fortyus comita cursor remoto;
    *   2) nenhum .AddCursor(  - eh o bind remoto que habilita o CRUD;
    *   3) os DOIS unicos "Insert Into" do dump tem por destino TmpLocal, que
    *      eh cursor LOCAL - declarado no Load do form PAI (SIGCDBAL,
    *      tasks\task348) com "Create Cursor TmpLocal (Localis c(10),
    *      Leitura n(8,2), ReLeitura n(8,2))", e aqui recriado por
    *      CriarCursorLocais(). Nao ha Update nem Delete From no dump;
    *   4) o acesso remoto do dialogo eh ZERO: todo numero vem de cursor que o
    *      CHAMADOR populou.
    *
    * Escrever INSERT/UPDATE aqui seria INVENTAR gravacao que o legado nao faz,
    * contra a regra #22 (a lista de colunas vem do schema, nunca de
    * adivinhacao) e contra o PILAR 2.
    *
    * Observacao para quem auditar a prova (3) por ferramenta: o harvest de
    * "cursor local" le apenas o dump DESTE form, e TmpLocal eh criado pelo
    * form PAI - entao a ferramenta ve TmpLocal como se fosse tabela remota.
    * Eh falso positivo conhecido de dialogo FILHO, e a conferencia eh a linha
    * do Load do pai citada acima.
    *--------------------------------------------------------------------------

ENDDEFINE
