*====================================================================
* SigOpPcuBO.prg
*
* Business Object para SigOpPcu - Planilha de Custo
* Herda de: BusinessBase
*
* ORIGEM LEGADO: SigOpPcu.SCX (dialogo modal filho)
*   Chamado por SIGCDPRO (Cadastro de Produto), aba Composicao:
*     chkPlanCus.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [C]
*     chkPlanVen.Valid -> Do Form SigOpPcu With ThisForm, DataSessionId, [V]
*   Parametros do Init legado: poForm (form pai), pnDataSes (DataSession
*   do pai), pTipo ("C" = planilha de Fator/Custo, "V" = planilha de Venda).
*
* NATUREZA DA TELA (importante para entender este BO):
*   A planilha opera sobre o CURSOR LOCAL "csGrade", que pertence ao form
*   PAI (SIGCDPRO) e vive na DataSession DELE - o dialogo faz
*   "Set DataSession to pnDataSes" e edita o mesmo cursor em memoria.
*   Estrutura do cursor, transcrita do Load do SIGCDPRO:
*     Create Cursor CsGrade (Tipos c(1), Ordem n(3), Cpros c(14),
*            Dpros c(30), Totas n(12,3), Coefs n(8,4), Valos n(12,3),
*            TotalG n(12,3), Acumulas n(12,3), cGrus c(3), cods c(2),
*            CidChaves c(20), AltCoef n(1,0))
*     Index On Tipos + Str(Ordem,3) + Cpros Tag Ordem
*   O dialogo filtra as linhas do tipo recebido com "Set Key To pTipo"
*   sobre essa TAG e permite editar apenas a coluna Coefs (Coef./(%)),
*   recalculando Valos / TotalG / Acumulas e o total adicional.
*
* PERSISTENCIA: este dialogo NAO grava em tabela nenhuma. Quem persiste
*   eh o form PAI, no Salvar dele, lendo as linhas marcadas pelo dialogo:
*     SELECT csGrade / SCAN / IF altcoef = 1
*         Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves)
*             Values (csGrade.cgrus, csGrade.cods, csGrade.coefs,
*                     crSigcdPro.cpros,
*                     IIF(EMPTY(csGrade.CidChaves), fUniqueIds(),
*                         csGrade.CidChaves))
*   Por isso o contrato de saida do dialogo sao as DUAS marcas que ele
*   grava na linha editada (AltCoef = 1 e CidChaves = fUniqueIds()) mais
*   o cursor crPrFtp que o botao Encerrar monta com as linhas alteradas:
*     SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
*   O comportamento padrao herdado de BusinessBase para Inserir() /
*   Atualizar() / ExecutarExclusao() (recusar a operacao e reportar pelo
*   ExibirFalha do Salvar) ja eh o correto para esta tela.
*
* TABELA DE REFERENCIA (PILAR 2 - nomes EXATOS do schema):
*   sigprftp  - destino final do coeficiente alterado (gravado pelo pai)
*               cgrus char(3), cods char(2), coefs numeric(6,4),
*               cpros char(14), pkchaves char(20), valors numeric(10,2)
*   SigPrFto  - origem das linhas da planilha montadas pelo pai
*               cidchaves char(20), coefs numeric(7,4), cpros char(14)
*====================================================================

DEFINE CLASS SigOpPcuBO AS BusinessBase

    *----------------------------------------------------------------
    * PARAMETROS DE ABERTURA (legado: LParameters poForm, pnDataSes, pTipo)
    *----------------------------------------------------------------
    this_cTipo              = "C"    && pTipo: "C" = Fator (custo), "V" = Venda
    this_nDataSessionPai    = 0      && pnDataSes - DataSession do form pai

    *----------------------------------------------------------------
    * CURSORES COMPARTILHADOS COM O FORM PAI
    * Os nomes sao os do legado de proposito: estes cursores NAO sao
    * criados aqui, eles pertencem a DataSession do form pai e os nomes
    * sao o CONTRATO entre as duas telas (mesma pratica de FormFti,
    * que tambem preserva "csGrade").
    *----------------------------------------------------------------
    this_cCursorGrade       = "csGrade"      && linhas da planilha (cursor do pai)
    this_cCursorProduto     = "CrSigCdPro"   && produto em edicao no pai (Cpros/Dpros)
    this_cCursorAlterados   = "crPrFtp"      && saida: linhas com AltCoef = 1
    this_cTagOrdem          = "Ordem"        && TAG Tipos + Str(Ordem,3) + Cpros

    *----------------------------------------------------------------
    * LINHA DA PLANILHA (colunas do cursor csGrade)
    * Tipo e tamanho transcritos do Create Cursor do SIGCDPRO.
    *----------------------------------------------------------------
    this_cTipos             = ""     && Tipos     c(1)      - "C" ou "V"
    this_nOrdem             = 0      && Ordem     n(3,0)    - sequencia da linha
    this_cCpros             = ""     && Cpros     c(14)     - codigo (coluna "Codigo")
    this_cDpros             = ""     && Dpros     c(30)     - descricao (coluna "Descricao")
    this_nTotas             = 0      && Totas     n(12,3)   - coluna "Total (a)"
    this_nCoefs             = 0      && Coefs     n(8,4)    - coluna "Coef. / (%)" (EDITAVEL)
    this_nValos             = 0      && Valos     n(12,3)   - coluna "Valor (b)"
    this_nTotalG            = 0      && TotalG    n(12,3)   - coluna "Total (a+b)"
    this_nAcumulas          = 0      && Acumulas  n(12,3)   - coluna "Acumulado"
    this_cCgrus             = ""     && cGrus     c(3)      - grupo (-> sigprftp.cgrus)
    this_cCods              = ""     && cods      c(2)      - feitio (-> sigprftp.cods)
    this_cCidChaves         = ""     && CidChaves c(20)     - PK (-> sigprftp.pkchaves)
    this_nAltCoef           = 0      && AltCoef   n(1,0)    - 1 = coeficiente alterado

    *----------------------------------------------------------------
    * CABECALHO DA TELA
    * Legado: ThisForm.Caption = CrSigCdPro.Cpros + " - " + CrSigCdPro.Dpros
    *         Label1 = "Planilha de Custo (" + Iif(pTipo="C","Fator","Venda") + ")"
    *----------------------------------------------------------------
    this_cCodigoProduto     = ""     && CrSigCdPro.Cpros c(14)
    this_cDescricaoProduto  = ""     && CrSigCdPro.Dpros c(30)

    *----------------------------------------------------------------
    * ESTADO DE CALCULO
    * this_nTotalAdicional eh o _TTA do legado (Sum Valos), exibido no
    * TextBox Get_Adicional, e eh recalculado a cada edicao de Coefs.
    * this_nCoefAnterior eh o lnCoef que o legado guardava no GotFocus
    * da celula para descobrir se o coeficiente mudou de fato - so nesse
    * caso a linha recebe AltCoef = 1 e CidChaves nova.
    *----------------------------------------------------------------
    this_nTotalAdicional    = 0      && _TTA - soma de Valos do tipo corrente
    this_nCoefAnterior      = 0      && lnCoef - valor de Coefs ao entrar na celula

    *----------------------------------------------------------------
    * CONTROLE DE ACESSO
    * Legado (When da Column4): Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * Ou seja: a coluna do coeficiente so eh editavel com acesso ao
    * cadastro de Feitios E na planilha de VENDA. O default .T. acompanha
    * o fChecaAcesso portado (utils\functions.prg), que libera o acesso;
    * o valor eh reavaliado por fChecaAcesso na carga da planilha.
    *----------------------------------------------------------------
    this_lAcessoFeitio      = .T.    && fChecaAcesso("SIGCDFTI")

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * Nao recebe parametro obrigatorio: o harness de teste instancia com
    * CREATEOBJECT("SigOpPcuBO") sem argumento, e Init que devolve .F.
    * mata o form. O tipo da planilha ("C"/"V") e a DataSession do pai
    * sao atribuidos pelo form depois da instanciacao.
    *
    * this_cTabela / this_cCampoChave apontam para sigprftp / pkchaves,
    * que eh onde o coeficiente editado aqui termina gravado pelo form
    * pai (nomes EXATOS do schema - PILAR 2).
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprftp"
            THIS.this_cCampoChave = "pkchaves"

            *-- Estado inicial da planilha (equivalente ao Init legado
            *-- antes de "Set Key To pTipo" / "Sum Valos to _TTA")
            THIS.this_cTipo             = "C"
            THIS.this_nDataSessionPai   = 0
            THIS.this_nTotalAdicional   = 0
            THIS.this_nCoefAnterior     = 0
            THIS.this_lAcessoFeitio     = .T.

            THIS.this_cCodigoProduto    = ""
            THIS.this_cDescricaoProduto = ""

            THIS.this_cTipos      = ""
            THIS.this_nOrdem      = 0
            THIS.this_cCpros      = ""
            THIS.this_cDpros      = ""
            THIS.this_nTotas      = 0
            THIS.this_nCoefs      = 0
            THIS.this_nValos      = 0
            THIS.this_nTotalG     = 0
            THIS.this_nAcumulas   = 0
            THIS.this_cCgrus      = ""
            THIS.this_cCods       = ""
            THIS.this_cCidChaves  = ""
            THIS.this_nAltCoef    = 0

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SigOpPcuBO:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta linha a partir do
    * registro CORRENTE do cursor recebido (este dialogo nao usa SQLEXEC:
    * a "fonte de dados" eh o cursor local csGrade, compartilhado com o
    * form pai - ver cabecalho do arquivo).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cTipos     = TratarNulo(Tipos, "C")
            THIS.this_nOrdem     = TratarNulo(Ordem, "N")
            THIS.this_cCpros     = TratarNulo(Cpros, "C")
            THIS.this_cDpros     = TratarNulo(Dpros, "C")
            THIS.this_nTotas     = TratarNulo(Totas, "N")
            THIS.this_nCoefs     = TratarNulo(Coefs, "N")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_nTotalG    = TratarNulo(TotalG, "N")
            THIS.this_nAcumulas  = TratarNulo(Acumulas, "N")
            THIS.this_cCgrus     = TratarNulo(cGrus, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_nAltCoef   = TratarNulo(AltCoef, "N")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave desta linha no destino final (sigprftp.
    * pkchaves = csGrade.CidChaves). Mantido por consistencia com
    * BusinessBase; este dialogo NAO chama Salvar()/Excluir() (ver nota
    * de PERSISTENCIA no cabecalho do arquivo e Init() acima) - quem
    * grava em sigprftp eh o form PAI (SIGCDPRO), varrendo o proprio
    * csGrade pelas linhas com AltCoef = 1 que esta tela marcou.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN EscaparSQL(THIS.this_cCidChaves)
    ENDPROC

    *====================================================================
    * FiltrarGrade - Replica "Select CsGrade / Set Key To pTipo" do Init
    * legado: restringe o cursor compartilhado csGrade as linhas do tipo
    * recebido ("C" = Fator/Custo, "V" = Venda, Column4.When) e recalcula
    * o total adicional (_TTA do legado / TextBox Get_Adicional) somando
    * Valos das linhas visiveis.
    *
    * O "Set Key To pTipo" do legado NAO pode ser transcrito ao pe da letra
    * aqui - e o motivo nao se ve lendo o codigo, so MEDINDO. O TAG "Ordem"
    * do csGrade eh COMPOSTO ("Index On Tipos + Str(Ordem,3) + Cpros", dump
    * do SIGCDPRO), isto eh uma chave de 18 caracteres, e "V" eh um valor
    * PARCIAL dela. Medido no VFP9 em 2026-11-11 (automation\
    * MedirSetKeyRange777.prg, mesmo cursor e mesmo TAG):
    *
    *     SET EXACT OFF + SET KEY TO "V"                  -> 3 linhas
    *     SET EXACT ON  + SET KEY TO "V"                  -> 0 LINHAS
    *     SET EXACT ON  + SET KEY TO RANGE "V", "V"+CHR(255)...  -> 3 linhas
    *
    * E o projeto roda com EXACT ON: start\config.prg:242 faz "SET EXACT ON"
    * no nivel de cima, ao contrario do ambiente Fortyus. Transcrito
    * literalmente, portanto, o filtro casa ZERO linha e a planilha abre
    * VAZIA - sem erro, sem log e sem excecao, que eh o sintoma que manda o
    * diagnostico para o cursor ou para o form pai (a mesma familia da regra
    * #21 e da licao "INDEX composto + SEEK parcial com EXACT ON").
    *
    * SET KEY TO RANGE eh a forma que nao depende do SET EXACT: o limite
    * inferior eh o proprio tipo e o superior eh o tipo seguido de CHR(255),
    * que ordena acima de qualquer sufixo possivel da chave. Medido no mesmo
    * script: "V" -> 3, "C" -> 2, tipo inexistente -> 0, e o SUM Valos passa
    * a somar so as visiveis (250.000 contra 380.000 sem filtro). O sufixo
    * eh FOLGADO de proposito (250 chars, contra os 17 que faltariam para
    * completar a chave): limite superior maior que a chave foi medido e
    * funciona, e assim o codigo nao fica amarrado a largura exata do TAG,
    * que pertence ao form PAI e pode mudar la.
    *
    * NAO se usa "salvar e restaurar SET EXACT" no lugar disto: o SET eh
    * global, valeria para tudo que rodasse entre as duas linhas, e deixaria
    * o comportamento da tela dependendo de um estado de ambiente.
    *
    * Tipo vazio = sem filtro (o legado tambem limpa o filtro com
    * "Set Key To" sem argumento, em MontarCursorAlterados).
    *====================================================================
    PROCEDURE FiltrarGrade(par_cTipo)
        LOCAL loc_lSucesso, loc_nTotalAdicional, loc_cTipo
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            THIS.this_cTipo = par_cTipo
            loc_cTipo = IIF(VARTYPE(par_cTipo) = "C", ALLTRIM(par_cTipo), "")

            SELECT (THIS.this_cCursorGrade)
            SET ORDER TO TAG (THIS.this_cTagOrdem)
            IF EMPTY(loc_cTipo)
                SET KEY TO
            ELSE
                SET KEY TO RANGE loc_cTipo, loc_cTipo + REPLICATE(CHR(255), 250)
            ENDIF
            GO TOP IN (THIS.this_cCursorGrade)

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO TOP IN (THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * VerificarAcessoCoeficiente - Replica Column4.When do legado:
    *   Return fChecaAcesso([SIGCDFTI]) And (pcTipo = [V])
    * A celula do coeficiente so eh editavel com acesso ao cadastro de
    * Feitios (SIGCDFTI) E na planilha de VENDA. Chamado pelo Form no
    * When/InteractiveChange da coluna de Coefs.
    *====================================================================
    PROCEDURE VerificarAcessoCoeficiente()
        THIS.this_lAcessoFeitio = (fChecaAcesso("SIGCDFTI") AND (THIS.this_cTipo == "V"))
        RETURN THIS.this_lAcessoFeitio
    ENDPROC

    *====================================================================
    * ArmazenarCoefAnterior - Replica Column4.GotFocus do legado
    * ("PUBLIC lnCoef / lnCoef = this.Value"): guarda o valor do
    * coeficiente ANTES da edicao, para THIS.RecalcularCoeficiente()
    * decidir se a linha deve ser marcada como alterada.
    *====================================================================
    PROCEDURE ArmazenarCoefAnterior(par_nCoefAtual)
        THIS.this_nCoefAnterior = TratarNulo(par_nCoefAtual, 0)
    ENDPROC

    *====================================================================
    * RecalcularCoeficiente - Replica Column4.Valid do legado (formula
    * transcrita LITERALMENTE, sem reescrever - regra de negocio):
    *   IF this.Value <> lnCoef
    *       replace altcoef with 1 in csGrade
    *       replace cidChaves with fUniqueIds() in csGrade
    *   ENDIF
    *   replace valos with Round((( totas * coefs ) - totas ),3) in csGrade
    *   replace totalg with totas + valos in csGrade
    *   GO top / SCAN / replace acumulas with lnVr + valos + totas / lnVr = acumulas
    *   Sum Valos to lnVr -> Get_Adicional.Value
    *
    * par_nNovoCoef - valor novo da celula (TextBox.Value no legado),
    * aplicado ao registro CORRENTE do cursor csGrade.
    *====================================================================
    PROCEDURE RecalcularCoeficiente(par_nNovoCoef)
        LOCAL loc_lSucesso, loc_nRegistroAtual, loc_nAcumulado, loc_nTotalAdicional
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade) AND !EOF(THIS.this_cCursorGrade)
            SELECT (THIS.this_cCursorGrade)

            IF par_nNovoCoef <> THIS.this_nCoefAnterior
                REPLACE AltCoef WITH 1 IN (THIS.this_cCursorGrade)
                REPLACE CidChaves WITH fUniqueIds() IN (THIS.this_cCursorGrade)
            ENDIF

            loc_nRegistroAtual = RECNO(THIS.this_cCursorGrade)

            REPLACE Coefs WITH par_nNovoCoef IN (THIS.this_cCursorGrade)
            REPLACE Valos WITH ROUND(((Totas * Coefs) - Totas), 3) IN (THIS.this_cCursorGrade)
            REPLACE TotalG WITH Totas + Valos IN (THIS.this_cCursorGrade)

            GO TOP IN (THIS.this_cCursorGrade)
            loc_nAcumulado = 0
            SCAN
                REPLACE Acumulas WITH loc_nAcumulado + Valos + Totas IN (THIS.this_cCursorGrade)
                loc_nAcumulado = Acumulas
            ENDSCAN

            loc_nTotalAdicional = 0
            SUM Valos TO loc_nTotalAdicional
            THIS.this_nTotalAdicional = loc_nTotalAdicional

            GO RECORD loc_nRegistroAtual IN (THIS.this_cCursorGrade)
            THIS.CarregarDoCursor(THIS.this_cCursorGrade)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorAlterados - Replica a parte de dados do cmdSair.Click
    * do legado:
    *   SELECT * from csGrade where altcoef = 1 into cursor crPrFtp READWRITE
    *   Select CsGrade / Set Key To
    * (o restante do Click - ThisForm.ParentForm.Enabled = .T. e
    * ThisForm.Release - eh responsabilidade do Form, nao do BO). Chamado
    * pelo botao Encerrar antes de fechar o dialogo. MEDIDO no dump do pai:
    * o form PAI (SIGCDPRO) grava sigprftp a partir do SCAN do PROPRIO
    * csGrade por AltCoef = 1 (sigcdpro_form_codigo_fonte.txt:20840), e le
    * this_cCursorAlterados (crPrFtp) quando REMONTA a composicao, para
    * reaplicar Coefs/cidchaves (linhas 14706-14715).
    *====================================================================
    PROCEDURE MontarCursorAlterados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(THIS.this_cCursorGrade)
            IF USED(THIS.this_cCursorAlterados)
                USE IN (THIS.this_cCursorAlterados)
            ENDIF

            SELECT * FROM (THIS.this_cCursorGrade) WHERE AltCoef = 1 ;
                INTO CURSOR (THIS.this_cCursorAlterados) READWRITE

            SELECT (THIS.this_cCursorGrade)
            SET KEY TO

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
