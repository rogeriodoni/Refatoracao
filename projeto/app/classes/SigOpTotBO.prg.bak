*==============================================================================
* SIGOPTOTBO.PRG
* Business Object do formulario Total Itens (SigOpTot)
* Origem legado: SigOpTot.SCX (form generico, modal, aberto via
* CREATEOBJECT/Show pelo formulario pai de movimento (TprMvCab), que ja
* prepara na DataSession do chamador os cursores crSigCdOpe/crTpmMvItn/
* crTpmMvIts/crTpmMvItn3/crSigOpCdc/crSigOpCdd antes de abrir este dialogo)
*
* NATUREZA DESTE DIALOGO: para o USUARIO e uma tela de consulta - todas as
* colunas das grades (grade_total/Grade_Serv/Grade_ProdutoTam/
* Grade_Produto/GrdTCompo) tem Text1.When = Return .F. no SCX e nao ha
* nenhum Click/DblClick nelas; o unico botao e OK.btnSair ("Retornar"),
* que so reabilita o form pai e libera o dialogo. O campo editavel
* (Get_Compensacao) grava DIRETO no cursor TprMvCab do form pai via
* ControlSource, nunca em tabela.
*
* MAS O LEGADO GRAVA NO SQL SERVER: quando a operacao explode componentes
* (crSigCdOpe.TotCompos = 1), o Init legado (linhas 1448-1505) usa a
* tabela SigTempD como AREA DE TROCA, para poder fazer o agrupamento no
* servidor - ele faz .Addcursor('SigTempD',...), Zap, Append Blank +
* Replace por produto, Podatamgr.UpDate('CrSigTempD') + commit() (que e
* o TABLEUPDATE do Fortyus, ou seja um INSERT remoto), consulta o JOIN
* SigTempD x SigPrCpo e por fim "Delete From SigTempD Where CidQuerys =
* ?lcCidQuery3". Essas duas gravacoes remotas sao reproduzidas aqui em
* Inserir() (o INSERT) e ExecutarExclusao() (o DELETE), com a lista de
* colunas tirada do schema e nao de adivinhacao (regra #22 do CLAUDE.md):
* alem das colunas que o legado preenche (cidquerys/cpros/qtds) entram as
* duas NOT NULL sem DEFAULT de SIGTEMPD - cidchaves char(64), que e a PK e
* recebe fUniqueIds(), e dpros char(65), que no legado ficava em branco
* por vir do registro em branco do Append Blank.
*
* Atualizar() NAO e sobrescrito: o legado nao tem nenhum UPDATE contra
* SigTempD (as linhas sao escritas uma vez e apagadas no fim do mesmo
* processo), e escrever um UPDATE aqui seria inventar SQL - o
* comportamento herdado de BusinessBase, que recusa a operacao e reporta
* pelo ExibirFalha do Salvar, ja e o correto. RegistrarAuditoria() tambem
* nao e sobrescrito: SigTempD e area de troca transitoria, nao entidade de
* negocio, e auditar cada linha dela encheria LogAuditoria a cada abertura
* da tela - o legado tambem nao registra nada disso.
*
* Os metodos desta classe reproduzem a logica real do PROCEDURE Init +
* PROCEDURE calctotais do SIGOPTOT.SCX legado
* (tasks\task813\SigOpTot_form_codigo_fonte.txt, linhas 1278-1593).
*==============================================================================

DEFINE CLASS SigOpTotBO AS BusinessBase

    *-- Contexto recebido do formulario pai (equivalente as properties
    *-- customizadas ParentForm/PoDataMgr/AntValue do SIGOPTOT.SCX legado)
    this_oParentForm    = .NULL.  && Referencia ao form pai (movimento/operacao)
    this_nDataSessionId = 0       && DataSessionId do form pai (cursores de itens vivem la)

    *-- Chave de correlacao gerada no Init (equivalente a lcCidQuery3 do
    *-- legado), usada nas consultas temporarias contra SigTempD quando
    *-- a operacao tem componentes (TotCompos = 1)
    this_cCidQuery3 = ""

    *-- Nomes dos cursores de trabalho (todos ja populados/mantidos pelo
    *-- formulario pai e pelos metodos desta classe - nenhum deles e uma
    *-- tabela de entidade unica, por isso this_cTabela/this_cCampoChave
    *-- ficam vazios, igual ao padrao do SigPrGl2BO)
    this_cCursorOperacao  = "crSigCdOpe"   && Tipo de operacao (SigCdOpe) - ChkQtds/PesoVts/PrecoVts/HabServs/TotCompos
    this_cCursorCabecalho = "TprMvCab"     && Cabecalho do movimento (Dopes/VCompensas/VCompensa2)
    this_cCursorOpCdc     = "crSigOpCdc"   && Opcoes de cadastro da operacao (DocQtd2s - rotulo do total de peso)
    this_cCursorOpCdd     = "crSigOpCdd"   && Opcoes de cadastro da operacao (MtCubs - habilita metro cubico)
    this_cCursorItens     = "crTpmMvItn"   && Itens da operacao (Cpros/Qtds/Pesos/Opers/Moedas/MoeFats/Totas/Cunis/Codbarras/CItens)
    this_cCursorItensDet  = "crTpmMvIts"   && Detalhe dos itens por tamanho (CItens/Codtams/Pesos/Qtds)
    this_cCursorItensServ = "crTpmMvItn3"  && Itens de servico da operacao (Cpros/Moedas/Totas)
    this_cCursorUnidade   = "crTmpUni"     && Cursor auxiliar de unidade corrente (Cunis/Cestos) - CursorQuery por item
    this_cCursorTempD     = "CrSigTempD"   && Cursor ligado a SigTempD (SQL Server) - usado so quando ha componentes
    this_cCursorValIte    = "xValIte"      && Totais por moeda dos PRODUTOS (grade_total)
    this_cCursorValServ   = "xValServ"     && Totais por moeda dos SERVICOS (Grade_Serv)
    this_cCursorCompo     = "csCompo"      && Totais de materia-prima consumida (GrdTCompo)
    this_cCursorProEesti  = "ProEesti"     && Totais agrupados por produto (Grade_Produto)
    this_cCursorProTam    = "ProTam"       && Totais agrupados por produto + tamanho (Grade_ProdutoTam)
    *-- Cursor de agrupamento por produto que alimenta Inserir() (equivale
    *-- ao cursor wEesti do Init legado, linha 1452)
    this_cCursorAgrupado  = "cursor_4c_CompoAgrupado"

    *-- Flags do TIPO DE OPERACAO. CarregarDoCursor() e a fonte UNICA de
    *-- leitura destas colunas; os metodos que decidem por elas usam a
    *-- property, nunca o cursor. Todas as colunas de flag sao
    *-- numeric(1,0) NOT NULL no schema (SigCdOpe.ChkQtds/PesoVts/
    *-- PrecoVts/HabServs/TotCompos/Opers), por isso ficam em property
    *-- NUMERICA (this_n*) e nunca logica - coluna numeric(1,0) de duas
    *-- opcoes NAO e booleana (CLAUDE.md), e aqui ChkQtds vale 6 ou 7 e
    *-- Opers e comparada com 3.
    this_nChkQtds   = 0    && SigCdOpe.ChkQtds   - 6/7 trocam o criterio de soma de quantidade/peso
    this_nPesoVts   = 0    && SigCdOpe.PesoVts   - 1 = acumula o peso no total por moeda
    this_nPrecoVts  = 0    && SigCdOpe.PrecoVts  - 1 = acumula o valor no total por moeda
    this_nHabServs  = 0    && SigCdOpe.HabServs  - 1 = a operacao tem grade de servicos
    this_nTotCompos = 0    && SigCdOpe.TotCompos - 1 = a operacao explode componentes (SigTempD x SigPrCpo)
    this_nOpers     = 0    && SigCdOpe.Opers     - 3 inverte o multiplicador de entrada/saida
    this_cCmoes     = ""   && SigCdOpe.Cmoes     - char(3): moeda fixa da operacao (vazia = usa a do item)
    this_cDocQtd2s  = ""   && SigOpCdc.DocQtd2s  - char(12): rotulo alternativo do total de peso
    this_nMtCubs    = 0    && SigOpCdd.MtCubs    - numeric(4,0): <> 0 habilita o total em metros cubicos

    *-- Latch de carga das flags acima. Os metodos que decidem por flag
    *-- (CalcularTotais/ProcessarComponentes/MontarGradeServicos) chamam a
    *-- carga quando este latch esta desligado, para a flag nunca ser lida
    *-- como zero so porque o metodo foi acionado por um caminho que nao
    *-- passou pelo ProcessarTotais - zero em TotCompos/HabServs
    *-- desligaria secao inteira da tela sem erro nenhum.
    this_lFlagsCarregadas = .F.

    *-- Totais calculados por CalcTotais() (fase seguinte), espelhados nos
    *-- controles Get_TotQtde/Get_QOper/Get_TotPeso/Get_POper/Get_TotPesoC/
    *-- getTotPes/Get_mtCub do form
    this_nTotQtde  = 0    && Total de quantidade (abs(lnTotQtde))
    this_cQOper    = ""   && Sinal da quantidade: "E" (entrada), "S" (saida) ou " " (zero)
    this_nTotPeso  = 0    && Total de peso (abs(lnTotPeso))
    this_cPOper    = ""   && Sinal do peso: "E", "S" ou " "
    this_nTotPesoC = 0    && Total de peso COM compensacao (abs(lnTotPesoC))
    this_nTotPes   = 0    && Total de peso "puro" dos itens, sem multiplicador de operacao (abs(lnTotPes))
    this_nMtCub    = 0    && Total em metros cubicos (so quando crSigOpCdd.MtCubs <> 0)
    this_lMostrarMtCub = .F.  && .T. quando a secao de metro cubico deve ficar visivel

    *-- Peso Unitario em Compensacao (Get_Compensacao, ligado a
    *-- TprMvCab.VCompensas) - editavel pelo usuario; this_nCompensacaoAnt
    *-- guarda o valor anterior (AntValue do legado) para rollback quando
    *-- o usuario digita valor invalido (< 0)
    this_nCompensacao    = 0
    this_nCompensacaoAnt = 0

    *-- Flags de secao: quais grades auxiliares devem ficar visiveis
    *-- (llTemCompo/llTemServ do legado). Quando nao ha servicos, a grade
    *-- de Produto+Tamanho ocupa o lugar da grade de Servicos (mesma
    *-- posicao na tela - comentario original "Mena - 20/10/2017")
    this_lTemComponentes = .F.  && GrdTCompo.Visible (TotCompos = 1 e csCompo com linhas)
    this_lTemServicos     = .F.  && Grade_Serv.Visible (HabServs = 1)

    *-- Rotulo do total de peso (lblTotPes.Caption), que no legado depende
    *-- de crSigOpCdc.DocQtd2s ("Total <DocQtd2s> :" ou "Total Peso :")
    this_cRotuloTotalPeso = ""

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao opera sobre uma unica tabela SQL Server: e um dialogo de
    * totalizacao que le/soma cursores ja preparados pelo formulario pai
    * (crSigCdOpe/TprMvCab/crTpmMvItn/crTpmMvIts/crTpmMvItn3/crSigOpCdc/
    * crSigOpCdd), por isso this_cTabela/this_cCampoChave ficam vazios -
    * mesmo padrao do SigPrGl2BO. this_cCidQuery3 e gerado aqui porque e
    * usado so internamente (consultas temporarias contra SigTempD), nunca
    * exposto ao usuario.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCidQuery3 = fUniqueIds()

            THIS.this_oParentForm    = .NULL.
            THIS.this_nDataSessionId = 0

            THIS.this_nTotQtde  = 0
            THIS.this_cQOper    = ""
            THIS.this_nTotPeso  = 0
            THIS.this_cPOper    = ""
            THIS.this_nTotPesoC = 0
            THIS.this_nTotPes   = 0
            THIS.this_nMtCub    = 0
            THIS.this_lMostrarMtCub = .F.

            THIS.this_nCompensacao    = 0
            THIS.this_nCompensacaoAnt = 0

            THIS.this_lTemComponentes = .F.
            THIS.this_lTemServicos    = .F.

            THIS.this_cRotuloTotalPeso = "Total Peso :"
            THIS.this_nChkQtds   = 0
            THIS.this_nPesoVts   = 0
            THIS.this_nPrecoVts  = 0
            THIS.this_nHabServs  = 0
            THIS.this_nTotCompos = 0
            THIS.this_nOpers     = 0
            THIS.this_cCmoes     = ""
            THIS.this_cDocQtd2s  = ""
            THIS.this_nMtCubs    = 0
            THIS.this_lFlagsCarregadas = .F.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirContexto - Guarda a referencia ao form pai (equivalente ao
    * parametro "pform" do Init legado) e a DataSession compartilhada
    * (equivalente a "datses"). THIS.this_oParentForm corresponde a
    * "ThisForm.ParentForm" do legado - usado por CalcularTotais() para ler
    * Op_Escolha e, quando precisar de metros cubicos, subir mais um nivel
    * (THIS.this_oParentForm.ParentForm.VerifMtCub).
    *--------------------------------------------------------------------------
    PROCEDURE DefinirContexto(par_oParentForm, par_nDataSessionId)
        THIS.this_oParentForm    = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
        THIS.this_nDataSessionId = IIF(VARTYPE(par_nDataSessionId) = "N", par_nDataSessionId, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTotais - Orquestra toda a carga/calculo do dialogo, na MESMA
    * ordem do PROCEDURE Init legado (linhas 1407-1593): fallback de
    * crSigCdOpe, rotulo do total de peso, componentes (se TotCompos=1),
    * CalcTotais, grade de produto, grade de produto+tamanho e grade de
    * servicos (se HabServs=1). Deve ser chamado pelo Form (fase seguinte)
    * depois que os cursores compartilhados (crSigCdOpe/TprMvCab/
    * crTpmMvItn/crTpmMvIts/crTpmMvItn3/crSigOpCdc/crSigOpCdd) ja estiverem
    * abertos na DataSession corrente.
    *--------------------------------------------------------------------------
    FUNCTION ProcessarTotais(par_cDopes)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.CarregarOperacao(par_cDopes)
            RETURN .F.
        ENDIF

        *-- Fonte unica das flags do tipo de operacao (ChkQtds/PesoVts/
        *-- PrecoVts/HabServs/TotCompos/Opers/Cmoes) e dos parametros
        *-- complementares (DocQtd2s/MtCubs): tem de rodar ANTES de
        *-- qualquer decisao por flag.
        IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)
            RETURN .F.
        ENDIF

        THIS.PrepararRotuloTotalPeso()

        IF !THIS.ProcessarComponentes()
            RETURN .F.
        ENDIF

        IF !THIS.CalcularTotais()
            RETURN .F.
        ENDIF

        IF !THIS.MontarGradeProdutos()
            RETURN .F.
        ENDIF

        IF !THIS.MontarGradeProdutoTam()
            RETURN .F.
        ENDIF

        IF !THIS.MontarGradeServicos()
            RETURN .F.
        ENDIF

        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - FONTE UNICA de leitura das flags do tipo de
    * operacao. No legado essas colunas sao lidas soltas, direto do cursor,
    * em 18 pontos do Init/calctotais (crSigCdOpe.ChkQtds 6x, .Cmoes 7x,
    * .Opers/.PesoVts/.PrecoVts/.HabServs/.TotCompos 1x cada,
    * crSigOpCdc.DocQtd2s 2x, CrSigOpCdd.MtCubs 1x); aqui elas entram em
    * property uma vez e todos os metodos passam a decidir pela property.
    *
    * Os TRES cursores de parametro tem conjuntos DISJUNTOS de colunas
    * (SigCdOpe tem as flags, SigOpCdc tem DocQtd2s, SigOpCdd tem MtCubs),
    * por isso CADA coluna so e lida quando existe NESTE alias: sem esse
    * cuidado a 2a chamada apagaria o que a 1a carregou. Chamado com o
    * cursor da operacao, cascateia para os dois complementares, de modo
    * que uma chamada carrega tudo.
    *
    * A existencia da coluna e testada com TYPE(alias + ".coluna"), nunca
    * com PEMSTATUS (que exige OBJETO no 1o argumento e estoura com alias
    * de cursor), e o valor e lido com EVALUATE - leitura por nome montado
    * e justamente o uso correto de EVALUATE. O acesso "campo"
    * NAO existe em VFP9, por isso o SELECT (alias) vem antes.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lLeu, loc_lSucesso
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")
        IF EMPTY(loc_cAlias)
            loc_cAlias = THIS.this_cCursorOperacao
        ENDIF

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + "] n" + CHR(227) + ;
                "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        *-- Sem registro posicionado as flags viriam todas zero, o que
        *-- desligaria secao inteira da tela sem erro nenhum - prefere-se
        *-- falhar alto.
        IF EOF(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor [" + loc_cAlias + ;
                "] sem registro posicionado"
            RETURN .F.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            loc_lLeu = .F.

            *-- Flags de SigCdOpe
            IF TYPE(loc_cAlias + ".ChkQtds") != "U"
                THIS.this_nChkQtds = THIS.LerFlagNumerica(loc_cAlias, "ChkQtds", THIS.this_nChkQtds)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".PesoVts") != "U"
                THIS.this_nPesoVts = THIS.LerFlagNumerica(loc_cAlias, "PesoVts", THIS.this_nPesoVts)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".PrecoVts") != "U"
                THIS.this_nPrecoVts = THIS.LerFlagNumerica(loc_cAlias, "PrecoVts", THIS.this_nPrecoVts)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".TotCompos") != "U"
                THIS.this_nTotCompos = THIS.LerFlagNumerica(loc_cAlias, "TotCompos", THIS.this_nTotCompos)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".Opers") != "U"
                THIS.this_nOpers = THIS.LerFlagNumerica(loc_cAlias, "Opers", THIS.this_nOpers)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".Cmoes") != "U"
                THIS.this_cCmoes = THIS.LerTextoColuna(loc_cAlias, "Cmoes", THIS.this_cCmoes)
                loc_lLeu = .T.
            ENDIF

            *-- HabServs existe em SigCdOpe E em SigOpCdc (schema conferido):
            *-- o legado decide pelo cursor da OPERACAO (CrSigCdOpe.HabServs),
            *-- por isso o cursor complementar nao pode sobrescrever a flag.
            IF TYPE(loc_cAlias + ".HabServs") != "U" ;
                    AND UPPER(ALLTRIM(loc_cAlias)) == UPPER(ALLTRIM(THIS.this_cCursorOperacao))
                THIS.this_nHabServs = THIS.LerFlagNumerica(loc_cAlias, "HabServs", THIS.this_nHabServs)
                loc_lLeu = .T.
            ENDIF

            *-- Parametros complementares
            IF TYPE(loc_cAlias + ".DocQtd2s") != "U"
                THIS.this_cDocQtd2s = THIS.LerTextoColuna(loc_cAlias, "DocQtd2s", THIS.this_cDocQtd2s)
                loc_lLeu = .T.
            ENDIF
            IF TYPE(loc_cAlias + ".MtCubs") != "U"
                THIS.this_nMtCubs = THIS.LerFlagNumerica(loc_cAlias, "MtCubs", THIS.this_nMtCubs)
                loc_lLeu = .T.
            ENDIF

            *-- Cascata: uma chamada com o cursor da operacao carrega tambem
            *-- os dois cursores de parametro, quando o form pai os deixou
            *-- abertos (no legado eles sao lidos soltos, sem guard).
            IF UPPER(ALLTRIM(loc_cAlias)) == UPPER(ALLTRIM(THIS.this_cCursorOperacao))
                IF USED(THIS.this_cCursorOpCdc) AND !EOF(THIS.this_cCursorOpCdc)
                    THIS.CarregarDoCursor(THIS.this_cCursorOpCdc)
                ENDIF
                IF USED(THIS.this_cCursorOpCdd) AND !EOF(THIS.this_cCursorOpCdd)
                    THIS.CarregarDoCursor(THIS.this_cCursorOpCdd)
                ENDIF

                SELECT (loc_cAlias)
                THIS.this_lFlagsCarregadas = loc_lLeu
            ENDIF

            IF loc_lLeu
                THIS.this_cMensagemErro = ""
            ENDIF

            loc_lSucesso = loc_lLeu

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os par" + CHR(226) + "metros da opera" + ;
                CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LerFlagNumerica - Le uma coluna de flag do cursor informado,
    * devolvendo sempre NUMERICO. A mesma coluna chega com tipo diferente
    * conforme a origem: numeric(1,0) do SQL Server chega Numerico, coluna
    * bit chega ora Logica ora Numerica conforme o driver, e cursor local
    * pode trazer marcacao em char - comparar Logico com numero estoura
    * "Operator/operand type mismatch", por isso o tipo e testado antes.
    * Coluna ausente devolve o valor ATUAL da property (par_nAtual), para
    * a leitura de um cursor complementar nao apagar o que o cursor da
    * operacao ja tinha carregado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerFlagNumerica(par_cAlias, par_cColuna, par_nAtual)
        LOCAL loc_cExpr, loc_uValor, loc_nRetorno

        loc_nRetorno = IIF(VARTYPE(par_nAtual) = "N", par_nAtual, 0)
        loc_cExpr    = ALLTRIM(par_cAlias) + "." + ALLTRIM(par_cColuna)

        IF TYPE(loc_cExpr) = "U"
            RETURN loc_nRetorno
        ENDIF

        loc_uValor = EVALUATE(loc_cExpr)

        DO CASE
        CASE ISNULL(loc_uValor)
            loc_nRetorno = 0
        CASE VARTYPE(loc_uValor) = "N"
            loc_nRetorno = loc_uValor
        CASE VARTYPE(loc_uValor) = "L"
            loc_nRetorno = IIF(loc_uValor, 1, 0)
        CASE VARTYPE(loc_uValor) = "C"
            loc_nRetorno = VAL(loc_uValor)
        ENDCASE

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * LerTextoColuna - Par de LerFlagNumerica para as colunas char
    * (SigCdOpe.Cmoes, SigOpCdc.DocQtd2s). Coluna ausente devolve o valor
    * atual da property; NULL devolve string vazia (o legado trata campo
    * nulo como vazio nos Iif(IsEmpty(...)) que consomem esses valores).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LerTextoColuna(par_cAlias, par_cColuna, par_cAtual)
        LOCAL loc_cExpr, loc_uValor, loc_cRetorno

        loc_cRetorno = IIF(VARTYPE(par_cAtual) = "C", par_cAtual, "")
        loc_cExpr    = ALLTRIM(par_cAlias) + "." + ALLTRIM(par_cColuna)

        IF TYPE(loc_cExpr) = "U"
            RETURN loc_cRetorno
        ENDIF

        loc_uValor = EVALUATE(loc_cExpr)

        DO CASE
        CASE ISNULL(loc_uValor)
            loc_cRetorno = ""
        CASE VARTYPE(loc_uValor) = "C"
            loc_cRetorno = loc_uValor
        OTHERWISE
            loc_cRetorno = TRANSFORM(loc_uValor)
        ENDCASE

        RETURN loc_cRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Grava na AREA DE TROCA SigTempD as linhas agrupadas por
    * produto, reproduzindo o trecho do Init legado (linhas 1450-1470):
    *     Select CrSigTempD / Zap
    *     Scan wEesti -> Append Blank + Replace Cpros/CidQuerys/Qtds/CidChaves
    *     ThisForm.Podatamgr.UpDate(" + "CrSigTempD" + ") + PoDataMgr.commit()
    * O UpDate do Fortyus e o TABLEUPDATE do cursor remoto bufferizado, ou
    * seja um INSERT em SigTempD - por isso esta gravacao remota existe de
    * verdade e vem para ca em vez de ficar herdada de BusinessBase.
    *
    * COLUNAS: as que o legado preenche (cidquerys/cpros/qtds) MAIS as duas
    * NOT NULL sem DEFAULT de SIGTEMPD conferidas no docs/schema.sql -
    * cidchaves char(64), a PK, que recebe fUniqueIds() (nunca string
    * vazia, senao a 2a linha colide no indice unico) e dpros char(65),
    * que fica em branco porque no legado vinha do registro em branco do
    * Append Blank. Omitir qualquer uma delas faria o SQL Server recusar o
    * INSERT inteiro (regra #22 do CLAUDE.md).
    *
    * O lote inteiro vai num UNICO SQLEXEC com controle de transacao em
    * T-SQL (SAVE TRANSACTION quando @@TRANCOUNT > 0) - BEGIN/COMMIT em
    * SQLEXECs separados NAO protegem, porque a conexao do VFP ja abre com
    * Transactions = 2 e @@TRANCOUNT = 1, e seria so aninhamento.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nLinhas, ;
              loc_cCidQuery3, loc_cAlias
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        loc_cAlias = THIS.this_cCursorAgrupado

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de agrupamento [" + loc_cAlias + ;
                "] n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        loc_cCidQuery3 = ALLTRIM(THIS.this_cCidQuery3)
        IF EMPTY(loc_cCidQuery3)
            THIS.this_cMensagemErro = "Chave de correla" + CHR(231) + CHR(227) + ;
                "o da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o foi gerada"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor reinicializar o processo."
            RETURN .F.
        ENDIF

        TRY
            loc_nLinhas = 0

            loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + ;
                "DECLARE @nivel4c int = @@TRANCOUNT;" + CHR(13) + ;
                "IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Compo4c;" + CHR(13) + ;
                "BEGIN TRY" + CHR(13)

            *-- Campos lidos sem qualificar o alias: o SELECT abaixo torna
            *-- esta a area corrente, e VFP9 nao aceita "campo".
            SELECT (loc_cAlias)
            SCAN
                loc_nLinhas = loc_nLinhas + 1
                loc_cSQL = loc_cSQL + ;
                    "INSERT INTO SigTempD (cidchaves, cidquerys, cpros, dpros, qtds) VALUES (" + ;
                    EscaparSQL(fUniqueIds()) + ", " + ;
                    EscaparSQL(loc_cCidQuery3) + ", " + ;
                    EscaparSQL(Cpros) + ", " + ;
                    EscaparSQL("") + ", " + ;
                    FormatarNumeroSQL(Qtds, 2) + ");" + CHR(13)
            ENDSCAN

            loc_cSQL = loc_cSQL + ;
                "IF @nivel4c = 0 COMMIT TRANSACTION;" + CHR(13) + ;
                "END TRY" + CHR(13) + ;
                "BEGIN CATCH" + CHR(13) + ;
                "    IF @nivel4c = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + ;
                "    ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Compo4c; END;" + CHR(13) + ;
                "    THROW;" + CHR(13) + ;
                "END CATCH"

            IF loc_nLinhas = 0
                *-- Nenhum produto a explodir: nada a gravar, e isso nao e falha
                loc_lSucesso = .T.
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;
                        CHR(13) + CapturarErroSQL()
                    loc_lSucesso = .F.
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            SELECT (loc_cAlias)
            GO TOP

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar a " + CHR(225) + "rea de troca " + ;
                "SigTempD: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Apaga as linhas transitorias desta instancia na
    * area de troca, reproduzindo o Init legado (linha 1484):
    *     lcDelete = [Delete From SigTempD Where CidQuerys = ?lcCidQuery3]
    * Roda nos DOIS caminhos de ProcessarComponentes (sucesso e falha da
    * consulta de componentes), para a tabela nunca ficar com sobra desta
    * sessao - no legado a limpeza tambem acontece antes do uso do
    * resultado.
    *
    * Continua PROTECTED, como em BusinessBase: de fora, a exclusao de um
    * registro de entidade entra sempre por Excluir(). Aqui ela e um passo
    * interno do processamento, chamado so por ProcessarComponentes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCidQuery3
        loc_lSucesso = .F.

        loc_cCidQuery3 = ALLTRIM(THIS.this_cCidQuery3)
        IF EMPTY(loc_cCidQuery3)
            THIS.this_cMensagemErro = "Chave de correla" + CHR(231) + CHR(227) + ;
                "o da opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o foi gerada"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor reinicializar o processo."
            RETURN .F.
        ENDIF

        loc_cSQL = "DELETE FROM SigTempD WHERE cidquerys = " + EscaparSQL(loc_cCidQuery3)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;
                CHR(13) + CapturarErroSQL()
            loc_lSucesso = .F.
        ELSE
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Replica o fallback do Init legado:
    *   If Not Used([crSigCdOpe])
    *       lcQuery = [Select * From SigCdOpe Where Dopes = '<Dopes>']
    *       If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdOpe]) < 1)
    *           MessageBox('Favor Reinicializar o Processo!!!', ...)
    *   EndIf
    * So executa a consulta quando crSigCdOpe AINDA NAO esta aberto - o
    * caminho normal eh o form pai ja o ter deixado pronto na DataSession
    * compartilhada.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_cDopes

        IF USED("crSigCdOpe")
            RETURN .T.
        ENDIF

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", ALLTRIM(par_cDopes), "")

        IF EMPTY(loc_cDopes)
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT * FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpe")

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararRotuloTotalPeso - Replica:
    *   ThisForm.lblTotPes.Caption = Iif(Not Empty(crSigOpCdc.DocQtd2s),
    *       'Total '+alltrim(crSigOpCdc.DocQtd2s), 'Total Peso') + [ :]
    *--------------------------------------------------------------------------
    FUNCTION PrepararRotuloTotalPeso()
        IF !EMPTY(THIS.this_cDocQtd2s)
            THIS.this_cRotuloTotalPeso = "Total " + ALLTRIM(THIS.this_cDocQtd2s) + " :"
        ELSE
            THIS.this_cRotuloTotalPeso = "Total Peso :"
        ENDIF

        RETURN THIS.this_cRotuloTotalPeso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarUnidade - Equivalente a:
    *   =ThisForm.podatamgr.cursorquery('SigCdUni','CrTmpUni','Cunis',
    *       crTpmMvItn.Cunis)
    * Recarrega o cursor crTmpUni (nome fixo, igual ao legado - usado so
    * dentro de CalcularTotais) com a linha de SigCdUni da unidade
    * informada. So o campo Cestos e consumido pelo calculo de peso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUnidade(par_cCunis)
        LOCAL loc_cSQL, loc_nResultado, loc_cCunis

        loc_cCunis = IIF(VARTYPE(par_cCunis) = "C", ALLTRIM(par_cCunis), "")

        IF USED("crTmpUni")
            USE IN crTmpUni
        ENDIF

        IF EMPTY(loc_cCunis) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            SET NULL ON
            CREATE CURSOR crTmpUni (Cunis C(3), Cestos C(1))
            SET NULL OFF
            RETURN .F.
        ENDIF

        loc_cSQL = "SELECT Cunis, Cestos FROM SigCdUni WHERE Cunis = " + EscaparSQL(loc_cCunis)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpUni")

        IF loc_nResultado < 0
            SET NULL ON
            CREATE CURSOR crTmpUni (Cunis C(3), Cestos C(1))
            SET NULL OFF
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComponentes - Replica o bloco "If crSigCdOpe.TotCompos = 1"
    * do Init legado (linhas 1448-1505): agrupa crTpmMvItn por Cpros, grava
    * as linhas em SigTempD (area de troca correlacionada por
    * THIS.this_cCidQuery3), consulta o JOIN SigTempD+SigPrCpo agrupado por
    * materia-prima (Mats/UniCompos) e, por fim, apaga as linhas
    * transitorias de SigTempD. O resultado fica em this_cCursorCompo
    * (csCompo) e this_lTemComponentes espelha "llTemCompo".
    *
    * O INSERT+SELECT+DELETE vai num UNICO SQLEXEC com controle de
    * transacao em T-SQL (SAVE TRANSACTION quando @@TRANCOUNT>0) - BEGIN/
    * COMMIT via SQLEXEC's separados NAO protegem, porque a conexao do VFP
    * ja abre com Transactions=2 e @@TRANCOUNT=1 (seria so aninhamento).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarComponentes()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCidQuery3, loc_nLinhas, loc_lProsseguir
        loc_lSucesso = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_lTemComponentes = .F.

        *-- A flag vem da property (fonte unica). O latch garante a carga
        *-- mesmo quando este metodo e acionado por um caminho que nao
        *-- passou pelo ProcessarTotais - TotCompos lido como zero
        *-- desligaria a grade de componentes sem erro nenhum.
        IF !THIS.this_lFlagsCarregadas
            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.this_nTotCompos != 1
            RETURN .T.
        ENDIF

        IF !USED("crTpmMvItn")
            THIS.this_cMensagemErro = "Cursor de itens n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Favor reinicializar o processo."
            RETURN .F.
        ENDIF

        loc_cCidQuery3  = THIS.this_cCidQuery3
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorAgrupado)
                USE IN (THIS.this_cCursorAgrupado)
            ENDIF

            *-- Equivale a "Select Cpros,Sum(Qtds) as Qtds From crTpmMvItn
            *-- Group by Cpros Into cursor wEesti" do Init legado (linha
            *-- 1452). O !EMPTY(Cpros) reproduz o "If IsEmpty(Cpros) Loop"
            *-- que o Scan logo abaixo faz no legado.
            SELECT Cpros, SUM(Qtds) AS Qtds ;
                FROM crTpmMvItn ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros ;
                INTO CURSOR (THIS.this_cCursorAgrupado) READWRITE

            *-- COUNT (e nao RECCOUNT) porque RECCOUNT conta tambem
            *-- registro marcado para exclusao
            SELECT (THIS.this_cCursorAgrupado)
            COUNT TO loc_nLinhas
            GO TOP

            IF loc_nLinhas > 0
                *-- Gravacao remota na area de troca (ver Inserir())
                IF !THIS.Inserir()
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT b.Mats AS Codigos, SUM(a.Qtds * b.Qtds) AS Qtds, b.UniCompos, " + ;
                        "SUM(a.Qtds * b.QtsCons) AS QtsCons " + ;
                        "FROM SigTempD a INNER JOIN SigPrCpo b ON a.Cpros = b.Cpros " + ;
                        "WHERE a.CidQuerys = " + EscaparSQL(loc_cCidQuery3) + " " + ;
                        "GROUP BY b.Mats, b.UniCompos"

                    IF USED("cursor_4c_CompoTmp")
                        USE IN cursor_4c_CompoTmp
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")

                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()
                        THIS.ExecutarExclusao()
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    THIS.ExecutarExclusao()

                    IF USED(THIS.this_cCursorCompo)
                        SELECT (THIS.this_cCursorCompo)
                        ZAP
                        IF RECCOUNT("cursor_4c_CompoTmp") > 0
                            APPEND FROM DBF("cursor_4c_CompoTmp")
                        ENDIF
                    ELSE
                        SELECT * FROM cursor_4c_CompoTmp INTO CURSOR (THIS.this_cCursorCompo) READWRITE
                    ENDIF

                    IF USED("cursor_4c_CompoTmp")
                        USE IN cursor_4c_CompoTmp
                    ENDIF

                    SELECT (THIS.this_cCursorCompo)
                    GO TOP

                    THIS.this_lTemComponentes = (RECCOUNT(THIS.this_cCursorCompo) > 0)
                ENDIF
            ENDIF

            IF USED(THIS.this_cCursorAgrupado)
                USE IN (THIS.this_cCursorAgrupado)
            ENDIF

            loc_lSucesso = loc_lProsseguir

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao processar componentes: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularTotais - Transcricao literal do PROCEDURE calctotais do
    * SIGOPTOT.SCX legado (linhas 1280-1382), regra #17 do CLAUDE.md:
    * formula, sinal e guards do legado NAO podem ser reescritos.
    *
    * crSigCdOpe/TprMvCab/crTpmMvItn/crTpmMvIts sao os cursores EXTERNOS
    * fixos preparados pelo form pai (ver cabecalho do arquivo) - usados
    * pelo nome LITERAL, nunca via (THIS.this_cCursorXxx).Campo, porque VFP9
    * nao aceita "campo" para acesso a cursor (CLAUDE.md -
    * FORMCOR_LICOES_APRENDIDAS Problema 9). xValIte (this_cCursorValIte) e
    * owned por este BO e por isso usa a expressao entre parenteses nos
    * comandos que aceitam ALIAS/expressao (SELECT/CREATE CURSOR/SEEK).
    *--------------------------------------------------------------------------
    FUNCTION CalcularTotais()
        LOCAL loc_lSucesso, loc_nTotQtde, loc_nTotPeso, loc_nTotPesoC, loc_nTotPes, ;
              loc_nMulti, loc_cMoePeso, loc_cMoePreco, loc_nChkQtds, loc_nQtde, ;
              loc_nPeso, loc_cModoOperacao
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF !USED("crSigCdOpe") OR !USED("crTpmMvItn") OR !USED("TprMvCab")
            THIS.this_cMensagemErro = "Cursores da opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(227) + "o abertos"
            RETURN .F.
        ENDIF

        *-- As flags da operacao sao constantes durante todo o SCAN (o
        *-- cursor da operacao tem uma linha so), por isso vem da property.
        *-- O latch cobre a chamada vinda de ValidarCompensacao, que
        *-- recalcula os totais sem passar pelo ProcessarTotais.
        IF !THIS.this_lFlagsCarregadas
            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)
                RETURN .F.
            ENDIF
        ENDIF

        loc_cModoOperacao = ""
        IF VARTYPE(THIS.this_oParentForm) = "O" AND PEMSTATUS(THIS.this_oParentForm, "Op_Escolha", 5)
            loc_cModoOperacao = THIS.this_oParentForm.Op_Escolha
        ENDIF

        loc_nTotQtde  = 0
        loc_nTotPeso  = 0
        loc_nTotPesoC = 0
        loc_nTotPes   = 0

        TRY
            IF USED(THIS.this_cCursorValIte)
                SELECT (THIS.this_cCursorValIte)
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorValIte) (Moeda C(3), Total N(15,2))
                SET NULL OFF
                INDEX ON Moeda TAG Moeda
            ENDIF

            SELECT crTpmMvItn
            SCAN
                IF EMPTY(crTpmMvItn.Cpros)
                    LOOP
                ENDIF

                *-- crSigCdOpe.Opers (numeric) vem da property; crTpmMvItn.Opers
                *-- e a marcacao "E"/"S" de CADA item e continua lida do cursor
                loc_nMulti = IIF(THIS.this_nOpers = 3, ;
                    IIF(crTpmMvItn.Opers = "E", -1, 1), ;
                    IIF(crTpmMvItn.Opers = "E", 1, -1))

                loc_nTotPes = loc_nTotPes + crTpmMvItn.TPesos

                IF THIS.this_nPesoVts = 1
                    loc_cMoePeso = IIF(EMPTY(THIS.this_cCmoes), crTpmMvItn.MoeFats, THIS.this_cCmoes)
                    SELECT (THIS.this_cCursorValIte)
                    IF !SEEK(loc_cMoePeso)
                        INSERT INTO (THIS.this_cCursorValIte) (Moeda) VALUES (loc_cMoePeso)
                        SEEK loc_cMoePeso
                    ENDIF
                    REPLACE Total WITH Total + (loc_nMulti * crTpmMvItn.TPesos)
                ENDIF

                IF THIS.this_nPrecoVts = 1
                    loc_cMoePreco = IIF(!EMPTY(crTpmMvItn.Moedas), crTpmMvItn.Moedas, THIS.this_cCmoes)
                    SELECT (THIS.this_cCursorValIte)
                    IF !SEEK(loc_cMoePreco)
                        INSERT INTO (THIS.this_cCursorValIte) (Moeda) VALUES (loc_cMoePreco)
                        SEEK loc_cMoePreco
                    ENDIF
                    REPLACE Total WITH Total + (loc_nMulti * crTpmMvItn.Totas)
                ENDIF

                THIS.CarregarUnidade(crTpmMvItn.Cunis)

                IF INLIST(THIS.this_nChkQtds, 6, 7)
                    loc_nChkQtds = THIS.this_nChkQtds
                    loc_nTotQtde = loc_nTotQtde + ;
                        (IIF((loc_nChkQtds = 6 AND crTpmMvItn.Opers = "S") OR ;
                             (loc_nChkQtds = 7 AND crTpmMvItn.Opers = "E"), 1, 0) * crTpmMvItn.Qtds)
                ELSE
                    loc_nTotQtde = loc_nTotQtde + (loc_nMulti * crTpmMvItn.Qtds)
                ENDIF
                loc_nQtde = crTpmMvItn.Qtds

                IF USED("crTpmMvIts")
                    SELECT crTpmMvIts
                    SET ORDER TO
                    SET ORDER TO CItens
                    IF SEEK(crTpmMvItn.CItens)
                        SCAN WHILE CItens = crTpmMvItn.CItens
                            IF INLIST(THIS.this_nChkQtds, 6, 7)
                                loc_nChkQtds = THIS.this_nChkQtds
                                loc_nTotPeso = loc_nTotPeso + ;
                                    (IIF((loc_nChkQtds = 6 AND crTpmMvItn.Opers = "E") OR ;
                                         (loc_nChkQtds = 7 AND crTpmMvItn.Opers = "S"), 1, 0) * ;
                                     crTpmMvIts.Pesos * crTpmMvIts.Qtds)
                            ELSE
                                loc_nTotPeso = loc_nTotPeso + (loc_nMulti * crTpmMvIts.Pesos * crTpmMvIts.Qtds)
                            ENDIF
                        ENDSCAN
                    ELSE
                        IF INLIST(THIS.this_nChkQtds, 6, 7)
                            loc_nChkQtds = THIS.this_nChkQtds
                            loc_nTotPeso = loc_nTotPeso + ;
                                (IIF((loc_nChkQtds = 6 AND crTpmMvItn.Opers = "E") OR ;
                                     (loc_nChkQtds = 7 AND crTpmMvItn.Opers = "S"), 1, 0) * ;
                                 ROUND(IIF(EMPTY(crTpmMvItn.Codbarras) AND crTmpUni.Cestos = "2", loc_nQtde, 1) * crTpmMvItn.Pesos, 2))
                        ELSE
                            loc_nTotPeso = loc_nTotPeso + ;
                                (loc_nMulti * ROUND(IIF(EMPTY(crTpmMvItn.Codbarras) AND crTmpUni.Cestos = "2", loc_nQtde, 1) * crTpmMvItn.Pesos, 2))
                        ENDIF
                    ENDIF
                ENDIF

                IF INLIST(loc_cModoOperacao, "INSERIR", "ALTERAR")
                    loc_nPeso = crTpmMvItn.Pesos + TprMvCab.VCompensas - ;
                        IIF(loc_cModoOperacao = "ALTERAR", TprMvCab.VCompensa2, 0)
                    loc_nTotPesoC = loc_nTotPesoC + loc_nMulti * ;
                        ROUND(IIF(EMPTY(crTpmMvItn.Codbarras) AND crTmpUni.Cestos = "2", crTpmMvItn.Qtds, 1) * loc_nPeso, 2)
                ELSE
                    loc_nTotPesoC = loc_nTotPeso
                ENDIF
            ENDSCAN

            THIS.this_nTotQtde = ABS(loc_nTotQtde)
            THIS.this_cQOper   = IIF(loc_nTotQtde = 0, " ", IIF(loc_nTotQtde > 0, "E", "S"))
            THIS.this_nTotPeso = ABS(loc_nTotPeso)
            *-- Transcricao literal do legado (regra #17): a 2a condicao do
            *-- sinal de Peso compara loc_nTotQtde, nao loc_nTotPeso - e
            *-- assim mesmo no SIGOPTOT.SCX original (linha 1361)
            THIS.this_cPOper    = IIF(loc_nTotPeso = 0, " ", IIF(loc_nTotQtde > 0, "E", "S"))
            THIS.this_nTotPesoC = ABS(loc_nTotPesoC)
            THIS.this_nTotPes   = ABS(loc_nTotPes)

            SELECT (THIS.this_cCursorValIte)
            DELETE FOR Total = 0

            THIS.this_lMostrarMtCub = .F.
            IF THIS.this_nMtCubs <> 0
                THIS.this_nMtCub = THIS.ObterMetrosCubicos()
                THIS.this_lMostrarMtCub = .T.
            ENDIF

            SELECT (THIS.this_cCursorValIte)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao calcular totais: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMetrosCubicos - Equivalente a
    *   ThisForm.ParentForm.ParentForm.VerifMtCub(.t.)
    * THIS.this_oParentForm corresponde a "ThisForm.ParentForm" do legado,
    * entao o metodo real fica um nivel acima:
    * THIS.this_oParentForm.ParentForm.VerifMtCub(). Guard de tipo/metodo
    * antes de chamar (o form pai, de dois niveis, nao faz parte deste
    * acervo isolado - regra #27 do CLAUDE.md, wrapper de contrato).
    *--------------------------------------------------------------------------
    FUNCTION ObterMetrosCubicos()
        LOCAL loc_nResultado
        loc_nResultado = 0

        IF VARTYPE(THIS.this_oParentForm) = "O" ;
                AND PEMSTATUS(THIS.this_oParentForm, "ParentForm", 5) ;
                AND VARTYPE(THIS.this_oParentForm.ParentForm) = "O" ;
                AND PEMSTATUS(THIS.this_oParentForm.ParentForm, "VerifMtCub", 5)
            loc_nResultado = THIS.this_oParentForm.ParentForm.VerifMtCub(.T.)
        ENDIF

        RETURN loc_nResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeProdutos - Replica:
    *   Select Cpros, Sum(Qtds) as Qtds From crTpmMvItn Where Not Empty(Cpros)
    *       Group by Cpros Into cursor ProEesti ReadWrite
    * Alimenta this_cCursorProEesti (ProEesti), ligado a Grade_Produto.
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeProdutos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("crTpmMvItn")
            THIS.this_cMensagemErro = "Cursor de itens n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorProEesti)
                USE IN (THIS.this_cCursorProEesti)
            ENDIF

            SELECT Cpros, SUM(Qtds) AS Qtds ;
                FROM crTpmMvItn ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros ;
                INTO CURSOR (THIS.this_cCursorProEesti) READWRITE

            SELECT (THIS.this_cCursorProEesti)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar totais por produto: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeProdutoTam - Replica (comentario original "Mena -
    * 20/10/2017 - mostra total de produtos por tamanho"):
    *   Select Cpros+'-'+ALLTRIM(codtams) as cpros, Sum(Qtds) as Qtds
    *       From crTpmMvIts Where Not Empty(Cpros) Group by Cpros,Codtams
    *       Into cursor ProTam ReadWrite
    * Alimenta this_cCursorProTam (ProTam), ligado a Grade_ProdutoTam.
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeProdutoTam()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("crTpmMvIts")
            THIS.this_cMensagemErro = "Cursor de itens por tamanho n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorProTam)
                USE IN (THIS.this_cCursorProTam)
            ENDIF

            SELECT Cpros + "-" + ALLTRIM(Codtams) AS Cpros, SUM(Qtds) AS Qtds ;
                FROM crTpmMvIts ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros, Codtams ;
                INTO CURSOR (THIS.this_cCursorProTam) READWRITE

            SELECT (THIS.this_cCursorProTam)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar totais por produto+tamanho: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeServicos - Replica o bloco "If CrSigCdOpe.HabServs = 1" do
    * Init legado (linhas 1545-1578): monta xValServ (totais por moeda dos
    * SERVICOS, crTpmMvItn3) com a MESMA estrutura de xValIte (o legado faz
    * isso com AFields(v01)+Create Cursor...From Array, aqui recriamos a
    * estrutura (Moeda/Total) diretamente, que eh a mesma). Alimenta
    * this_cCursorValServ (xValServ) e this_lTemServicos ("llTemServ").
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeServicos()
        LOCAL loc_lSucesso, loc_cMoePreco
        loc_lSucesso = .F.
        THIS.this_lTemServicos = .F.

        IF !THIS.this_lFlagsCarregadas
            IF !THIS.CarregarDoCursor(THIS.this_cCursorOperacao)
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.this_nHabServs != 1
            RETURN .T.
        ENDIF

        IF !USED("crTpmMvItn3")
            THIS.this_cMensagemErro = "Cursor de itens de servi" + CHR(231) + "o n" + CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorValServ)
                USE IN (THIS.this_cCursorValServ)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorValServ) (Moeda C(3), Total N(15,2))
            SET NULL OFF
            INDEX ON Moeda TAG Moeda

            SELECT crTpmMvItn3
            SCAN
                IF EMPTY(crTpmMvItn3.Cpros)
                    LOOP
                ENDIF

                loc_cMoePreco = IIF(EMPTY(THIS.this_cCmoes), crTpmMvItn3.Moedas, THIS.this_cCmoes)

                SELECT (THIS.this_cCursorValServ)
                IF !SEEK(loc_cMoePreco)
                    INSERT INTO (THIS.this_cCursorValServ) (Moeda) VALUES (loc_cMoePreco)
                    SEEK loc_cMoePreco
                ENDIF
                REPLACE Total WITH Total + crTpmMvItn3.Totas
            ENDSCAN

            SELECT (THIS.this_cCursorValServ)
            DELETE FOR Total = 0
            GO TOP

            THIS.this_lTemServicos = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar totais de servi" + CHR(231) + "os: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCompensacao - Equivalente ao PROCEDURE Valid de Get_Compensacao
    * (linhas 1767-1779): recusa valor negativo (guardando o anterior em
    * this_nCompensacaoAnt, para o Form repor no TextBox) e, se valido,
    * recalcula os totais (This.Refresh + Thisform.CalcTotais() do legado).
    *--------------------------------------------------------------------------
    FUNCTION ValidarCompensacao(par_nValor)
        IF VARTYPE(par_nValor) != "N" OR par_nValor < 0
            THIS.this_cMensagemErro = "Valor de Compensa" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lido"
            RETURN .F.
        ENDIF

        THIS.this_nCompensacaoAnt = THIS.this_nCompensacao
        THIS.this_nCompensacao    = par_nValor

        RETURN THIS.CalcularTotais()
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao ha PK de tabela real neste dialogo (ver
    * cabecalho do arquivo - e somente leitura, sem Salvar/Excluir). A
    * sobrescrita existe so para documentar a chave de CORRELACAO usada
    * internamente (this_cCidQuery3, equivalente ao lcCidQuery3 do legado,
    * que identifica as linhas transitorias desta instancia em SigTempD).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidQuery3
    ENDPROC

ENDDEFINE
