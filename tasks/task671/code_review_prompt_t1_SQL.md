# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PROCURA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PARAMETRIZADO, PRIORS, CIDCHAVES, EMPGRUESTS, TT, LNERROR, LNKEY, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PARAMETRIZADO, PRIORS, CIDCHAVES, EMPGRUESTS, TT, LNERROR, LNKEY, CPROS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
	lcSql = [Select 0 as Flag,* From SigOpClP Where Priors = ]+Str(ThisForm.Prioridade,1)+[ Order by Emps,Grupos,Estos ]
	llOk  = ( ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigOpClP') > 0 )
		Select CrSigOpClp
			lcUpdate = [ Update SigOpClP Set Usuars = Usuars Where CidChaves = ']+CrSigOpClP.CidChaves+[']
			lnErro1 = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1  )
			lcSql = [Select CidChaves From SigMvEst where EmpGruEsts = ']+CrSigOpClP.Emps+CrSigOpClP.Grupos+CrSigOpClp.Estos+[' And ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpEst') < 1 Or Reccount('TmpEst') = 0
				lcSql = [Select EmpGruEsts, Sum(1) as TT From SigMvHst where EmpGruests = ']+CrSigOpClP.Emps+CrSigOpClP.Grupos+CrSigOpClp.Estos+[' And ]+;
				If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpHis') < 1 Or TmpHis.TT > 0
			Select CrSigOpClP
			Select CrSigPrSlP
			lcDelete = [ Delete From SigOpClP Where CidChaves = ']+CrSigOpClP.CidChaves+[']
			llOk = ( ThisForm.poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg) - TRECHOS RELEVANTES PARA PASS SQL (901 linhas total):

*-- Linhas 426 a 455:
426:             IF !loc_lOk
427:                 loc_lErroCnx = .T.
428:             ELSE
429:                 SELECT CrSigOpClP
430:                 loc_nTotal      = RECCOUNT("CrSigOpClP")
431:                 loc_nProcessado = 0
432: 
433:                 SCAN
434:                     loc_nProcessado = loc_nProcessado + 1
435:                     THIS.lbl_4c_Progresso.Caption = "Aguarde. Processando Produtos (" + ;
436:                         ALLTRIM(STR(loc_nProcessado)) + "/" + ALLTRIM(STR(loc_nTotal)) + ")"
437: 
438:                     THIS.this_oBusinessObject.CarregarDoCursor("CrSigOpClP")
439: 
440:                     *-- Lock otimista do item (Update SigOpClP Set Usuars = Usuars).
441:                     *-- O BO ja faz o Rollback da falha; aqui so reproduzimos os
442:                     *-- dois desvios que o legado tira do codigo de retorno.
443:                     loc_nResult = THIS.this_oBusinessObject.MarcarEmProcessamento()
444: 
445:                     IF loc_nResult <= 0
446:                         IF loc_nResult = -3
447:                             *-- queda de conexao com BD: Exit do Scan (legado)
448:                             loc_lErroCnx = .T.
449:                             EXIT
450:                         ENDIF
451:                         LOOP
452:                     ENDIF
453: 
454:                     IF !THIS.this_oBusinessObject.ProcessarItem()
455:                         *-- fRecalculaP ausente no acervo: o BO mediu isso na


### BO (C:\4c\projeto\app\classes\SigPrRsaBO.prg):
*==============================================================================
* Classe  : SigPrRsaBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de produto (SIGPRRSA)
*            Form OPERACIONAL - processa fila SigOpClP chamando fRecalculaP
*            para cada produto na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*
* NOTA DE ESCOPO - fRecalculaP
*   O OK.Click legado chama fRecalculaP duas vezes por item (recalculo do
*   saldo do produto e consolidacao). A funcao NAO existe no acervo - nem
*   como .prg, nem no Framework, nem no p-code dos VCX. Pela regra CLAUDE.md
*   #27 (3a linha da tabela: funcao que devolve VALOR DE CALCULO fica AUSENTE
*   e visivel, nunca vira stub) as chamadas foram mantidas como estao: um
*   stub devolvendo .T. faria a tela anunciar sucesso e DRENAR A FILA sem
*   recalcular saldo nenhum, e um stub devolvendo 0 gravaria saldo errado em
*   silencio. Mesmo tratamento ja adotado em SigOpBcbBO, SigPrGlpBO,
*   SigPrGlxBO, SigPrCccBO e dmoBO.
*
*   Diferenca em relacao a esses outros BOs: aqui o retorno GATEIA o loop (la
*   ele eh descartado). Como a chamada mora em TRY/CATCH, a ausencia virava um
*   MsgErro MODAL POR ITEM da fila - e no modo parametrizado (Fortyus.Exe, sem
*   ninguem na frente da tela) o lote TRAVAVA no primeiro dialogo. Por isso
*   ProcessarItem() mede a disponibilidade UMA vez (classificando o erro 1 do
*   VFP9) e o form aborta a passada com UMA mensagem. Ver this_lRecalculoDisponivel.
*
* NOTA DE ESCOPO - SigPrSlP (CrSigPrSlP)
*   Ver comentario em ExecutarExclusao: o Scatter/Zap/Append/Gather que o
*   legado faz sobre esse cursor nao chega ao banco (a linha Update esta
*   COMENTADA no proprio fonte legado e o buffer eh descartado pelo Rollback
*   seguinte), por isso nao foi migrado INSERT/UPDATE em SigPrSlP.
*==============================================================================
DEFINE CLASS SigPrRsaBO AS BusinessBase

    *-- Parametros de execucao
    this_nPrioridade    = 0     && Filtro de prioridade: 0 ou 1
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpClP
    this_cCidChaves = ""        && cidchaves char(20) - PK da fila
    this_nPriors    = 0         && priors numeric(1,0) - prioridade (0 ou 1)
    this_cEmps      = ""        && emps char(3) - empresa
    this_cGrupos    = ""        && grupos char(10) - grupo de estoque
    this_cEstos     = ""        && estos char(10) - estoque/localizacao
    this_cCpros     = ""        && cpros char(14) - codigo do produto
    this_dDatas     = {}        && datas datetime - data do movimento
    this_cCodCors   = ""        && codcors char(4) - codigo da cor
    this_cCodTams   = ""        && codtams char(4) - codigo do tamanho
    this_cUsuars    = ""        && usuars char(20) - usuario processador
    this_nTipoestos = 0         && tipoestos numeric(1,0) - tipo de estoque
    this_cEmpestpros = ""       && empestpros char(37) - composite emps+estos+cpros

    *-- Controle de TRANSACAO MANUAL (regra: o migrador descarta o Commit()
    *-- do legado e a gravacao fica presa na transacao aberta). Medido neste
    *-- ambiente: SQLGETPROP(h, "Transactions") ja vale 2 (MANUAL) numa
    *-- conexao virgem, e nem BusinessBase nem DataAccess dao SQLCOMMIT. O
    *-- OK.Click legado tem DOIS Commit() e SETE Rollback() - sem eles o
    *-- DELETE FROM SigOpClP nunca eh efetivado, a fila NAO drena e o lote
    *-- reprocessa os MESMOS itens a cada passada do DO WHILE, para sempre.
    this_lTransacaoManual = .F.

    *-- fRecalculaP (recalculo de saldo/posicao de estoque) NAO existe no
    *-- acervo - nem como .prg, nem no Framework, nem no p-code dos VCX. Pela
    *-- regra #27 (funcao que devolve VALOR DE CALCULO fica AUSENTE e
    *-- visivel, nunca vira stub) NAO se cria stub: devolver .T. faria a tela
    *-- anunciar sucesso e drenar a fila sem recalcular saldo nenhum, e
    *-- devolver 0 gravaria saldo errado em silencio. Mesmo tratamento ja
    *-- adotado em SigOpBcbBO, SigPrGlpBO, SigPrGlxBO e dmoBO.
    *--
    *-- A diferenca aqui eh que o retorno GATEIA o loop (nos outros BOs ele
    *-- eh descartado): a chamada mora dentro de TRY/CATCH, entao a ausencia
    *-- virava UM MsgErro MODAL POR ITEM da fila - e em modo parametrizado
    *-- (Fortyus.Exe, sem ninguem na frente da tela) o lote TRAVAVA no
    *-- primeiro dialogo. Por isso a disponibilidade eh medida UMA vez, no
    *-- primeiro item, classificando o erro 1 (File does not exist) do VFP9:
    *-- medir eh melhor que adivinhar por FILE(), porque a funcao tambem
    *-- poderia vir de um SET PROCEDURE e ai FILE() daria falso negativo.
    this_lRecalculoDisponivel = .T.

    *--------------------------------------------------------------------------
    * Init - e carrega o cursor global de parametros do sistema (CrSigCdPam),
    * que o Init do form legado montava com
    *   Podatamgr.Cursorquery('SigCdPam','CrSigCdPam',.f.,.f.,
    *                         [GrupoRecs,GrupoPags,ContaRecs,ContaPags])
    * O sistema novo nao pre-carrega os cursores globais do Fortyus no
    * startup, entao cada BO responsavel por um form que depende deles tem de
    * popula-lo aqui, depois do DODEFAULT().
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.DetectarTransacaoManual()
        THIS.CarregarParametrosSistema()
    ENDPROC

    *--------------------------------------------------------------------------
    * DetectarTransacaoManual - mede UMA vez se a conexao esta em transacao
    * manual (SQLGETPROP "Transactions" = 2) ou em auto-commit (1).
    *
    * Medir em vez de presumir deixa o par Commit/Rollback INERTE quando a
    * conexao estiver em auto-commit, que eh a forma segura ja usada no
    * projeto (SIGPRCNBBO.prg:471) - commitar em auto-commit nao eh erro, mas
    * o IF torna o codigo correto nos dois ambientes sem precisar saber qual
    * deles esta ativo.
    *
    * SQLGETPROP com handle invalido DISPARA EXCECAO (nao devolve -1), e o
    * harness de teste define gnConnHandle = 0 de proposito; por isso a
    * guarda de tipo/valor ANTES e o TRY em volta. Sem conexao o resultado
    * eh .F. (par inerte), nunca uma falha de instanciacao do BO.
    *--------------------------------------------------------------------------
    PROCEDURE DetectarTransacaoManual()
        LOCAL loc_oErro
        THIS.this_lTransacaoManual = .F.
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                THIS.this_lTransacaoManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lTransacaoManual = .F.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - SQLCOMMIT, equivalente ao poDataMgr.Commit() do
    * legado. O OK.Click chama Commit() em DOIS pontos, cada um com caminho
    * de falha proprio (If Not llOk / Rollback / Loop) - ou seja o commit eh
    * um PASSO da regra, nao detalhe de infra, e devolver o sucesso dele eh
    * necessario para reproduzir esses desvios.
    *
    * Inerte quando a conexao esta em auto-commit: devolve .T. sem chamar
    * nada, porque nesse modo o statement ja foi efetivado.
    *--------------------------------------------------------------------------
    FUNCTION ConfirmarTransacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        IF THIS.this_lTransacaoManual
            TRY
                loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
                IF !loc_lSucesso
                    THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + CHR(227) + ;
                        "o no banco de dados."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lSucesso = .F.
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DesfazerTransacao - SQLROLLBACK, equivalente ao poDataMgr.Rollback() do
    * legado (SETE chamadas no OK.Click: uma por caminho de falha, mais a
    * incondicional depois do EndScan, que descarta o que sobrou aberto na
    * passada). Sem retorno util: o legado tambem descarta o dele.
    *--------------------------------------------------------------------------
    PROCEDURE DesfazerTransacao()
        LOCAL loc_oErro
        IF THIS.this_lTransacaoManual
            TRY
                SQLROLLBACK(gnConnHandle)
            CATCH TO loc_oErro
                *-- Rollback que falha nao tem desdobramento: a transacao ja
                *-- esta perdida e o item sera reprocessado na proxima passada
                *-- (a fila so drena apos o DELETE confirmado). Registrar a
                *-- mensagem permite que o chamador a exiba se quiser, sem
                *-- abrir dialogo aqui - este metodo roda DENTRO do loop e um
                *-- modal por item travaria o modo parametrizado.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - lock otimista do item corrente, transcrito de
    *   lcUpdate = [ Update SigOpClP Set Usuars = Usuars Where CidChaves = '..']
    *   lnErro1  = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1 )
    * no OK.Click legado. Devolve o RESULTADO NUMERICO do SQLEXEC porque o
    * legado distingue dois desvios a partir dele: -3 (queda de conexao) faz
    * Exit do Scan, qualquer outra falha faz apenas Loop para o item seguinte.
    * Devolver logico apagaria essa diferenca.
    *
    * PUBLIC de proposito: eh o form que percorre o cursor da fila e precisa
    * chamar isto item a item. ExecutarAtualizacao() roda o MESMO UPDATE mas
    * eh PROTECTED (contrato de BusinessBase) e nao pode ser chamado de fora -
    * chamar la de fora estouraria "Property EXECUTARATUALIZACAO is not
    * found" (regra #51). Por isso o SQL mora aqui, uma vez, em vez de ficar
    * duplicado no .prg do form.
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmProcessamento()
        LOCAL loc_nResult, loc_cSQL, loc_oErro
        loc_nResult = 0
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpClP SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult <= 0
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" do legado
                    THIS.DesfazerTransacao()
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
            loc_nResult = 0
        ENDTRY
        RETURN loc_nResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Popula o cursor global CrSigCdPam com as
    * quatro colunas que o legado pedia no Cursorquery do Init. SigCdPam eh
    * tabela de UMA linha (parametros gerais) e NAO tem coluna de empresa -
    * nenhum filtro WHERE.
    *
    * Nunca derruba a instanciacao do BO: em modo teste/validacao de UI o
    * harness define gnConnHandle = 0 de proposito, e qualquer falha de
    * consulta cai no cursor vazio criado localmente (APPEND BLANK), de forma
    * que quem le CrSigCdPam encontre a estrutura esperada em vez de alias
    * inexistente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigCdPam")
                USE IN CrSigCdPam
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT gruporecs, grupopags, contarecs, contapags" + ;
                    " FROM SigCdPam"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamTmp")

                IF loc_nResultado > 0 AND USED("cursor_4c_PamTmp")
                    SELECT * FROM cursor_4c_PamTmp INTO CURSOR CrSigCdPam READWRITE
                    USE IN cursor_4c_PamTmp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                IF USED("cursor_4c_PamTmp")
                    USE IN cursor_4c_PamTmp
                ENDIF
                CREATE CURSOR CrSigCdPam ( ;
                    GrupoRecs C(10), GrupoPags C(10), ;
                    ContaRecs C(10), ContaPags C(10))
                APPEND BLANK
            ENDIF

            IF USED("CrSigCdPam") AND RECCOUNT("CrSigCdPam") > 0
                SELECT CrSigCdPam
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            IF !USED("CrSigCdPam")
                CREATE CURSOR CrSigCdPam ( ;
                    GrupoRecs C(10), GrupoPags C(10), ;
                    ContaRecs C(10), ContaPags C(10))
                APPEND BLANK
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "RECALCPRSLP"
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpClP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_nPriors    = NVL(priors, 0)
                THIS.this_cEmps      = NVL(emps, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cEstos     = NVL(estos, "")
                THIS.this_cCpros     = NVL(cpros, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cCodCors   = NVL(codcors, "")
                THIS.this_cCodTams   = NVL(codtams, "")
                THIS.this_cUsuars    = NVL(usuars, "")
                IF TYPE("tipoestos") != "U"
                    THIS.this_nTipoestos = NVL(tipoestos, 0)
                ENDIF
                IF TYPE("empestpros") != "U"
                    THIS.this_cEmpestpros = NVL(empestpros, "")
                ELSE
                    THIS.this_cEmpestpros = ALLTRIM(THIS.this_cEmps) + ;
                                            ALLTRIM(THIS.this_cEstos) + ;
                                            ALLTRIM(THIS.this_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpClP filtrado por prioridade em CrSigOpClP
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila(par_nPrioridade)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpClP")
                USE IN CrSigOpClP
            ENDIF
            loc_cSQL = "SELECT cidchaves, codcors, codtams, cpros, datas, emps, " + ;
                       "estos, grupos, tipoestos, usuars, priors " + ;
                       "FROM SigOpClP " + ;
                       "WHERE priors = " + FormatarNumeroSQL(par_nPrioridade, 0) + " " + ;
                       "ORDER BY emps, grupos, estos"
            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpClP") > 0)
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpClP")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpClP (enfileira item para recalculo de saldo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015)
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                             PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                             PADR(ALLTRIM(THIS.this_cCpros), 14)
            THIS.this_cEmpestpros = loc_cEmpEstPro
            loc_cSQL = "INSERT INTO SigOpClP " + ;
                       "(cidchaves, codcors, codtams, cpros, datas, empestpros, " + ;
                       "emps, estos, grupos, tipoestos, usuars, priors) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(loc_cEmpEstPro) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                *-- Commit explicito: BusinessBase nao da SQLCOMMIT e a conexao
                *-- nasce em transacao MANUAL neste ambiente, entao sem isto o
                *-- INSERT fica preso e some ao fim do processo.
                loc_lSucesso = THIS.ConfirmarTransacao()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    THIS.DesfazerTransacao()
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo (SigOpClP)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpClP com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                 PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCpros), 14)
                THIS.this_cEmpestpros = loc_cEmpEstPro
                loc_cSQL = "UPDATE SigOpClP SET " + ;
                           "codcors = " + EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                           "codtams = " + EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                           "cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "empestpros = " + EscaparSQL(loc_cEmpEstPro) + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                           "estos = " + EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "tipoestos = " + FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- Commit explicito (ver nota em Inserir)
                    loc_lSucesso = THIS.ConfirmarTransacao()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ELSE
                        THIS.DesfazerTransacao()
                    ENDIF
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo (SigOpClP)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - UPDATE SigOpClP marcando item como sendo processado
    * Delega a MarcarEmProcessamento() para que o SQL do lock otimista e o
    * Rollback associado existam em UM lugar so: este metodo eh PROTECTED
    * (contrato de BusinessBase) e o form, que percorre a fila, precisa chamar
    * a versao PUBLIC. Duplicar o UPDATE nos dois deixava o par livre para
    * divergir - foi o que aconteceu antes, quando o form tinha a sua propria
    * copia inline, sem Rollback.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarAtualizacao()
        RETURN (THIS.MarcarEmProcessamento() > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - remove o item da fila e CONFIRMA, transcrevendo:
    *
    *   lcDelete = [ Delete From SigOpClP Where CidChaves = '..' ]
    *   llOk = ( poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = llOk And ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *
    * Este eh o Commit MAIS CRITICO do form: eh ele que efetiva a saida do
    * item da fila. Sem ele, com a conexao em transacao manual, o DELETE fica
    * preso, o SELECT da passada seguinte traz os MESMOS registros e o lote
    * reprocessa a fila inteira indefinidamente - sem erro na tela.
    *
    * NOTA DE ESCOPO - gravacao em SigPrSlP (CrSigPrSlP)
    *   Entre a checagem de movimento e o DELETE, o legado faz
    *     Select CrSigOpClP / Scatter Memvar
    *     Select CrSigPrSlP / Zap / Append Blank / Gather Memvar
    *   sobre o cursor que o Init declara com
    *     .AddCursor('SigPrSlP','CidChaves','CrSigPrSlP','')
    *   mas a linha que o persistiria esta COMENTADA no proprio fonte legado
    *     (*  llOk = Thisform.Podatamgr.Update('CrSigPrSlP'))
    *   e o que sobra no buffer eh descartado pelo Rollback() que vem depois
    *   do EndScan. Ou seja: esse bloco NAO grava em SigPrSlP - eh um vestigio
    *   de buffer local, de uma linha so, que ninguem le depois (as duas
    *   chamadas a fRecalculaP acontecem ANTES dele). Por isso NAO foi migrado
    *   um INSERT/UPDATE em SigPrSlP: inventar aqui uma gravacao que o legado
    *   nao faz violaria o PILAR 2 tanto quanto perder uma que ele faz.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpClP " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- "llOk = llOk And ( PodataMgr.Commit() > 0 )" do legado
                    loc_lSucesso = THIS.ConfirmarTransacao()
                ELSE
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao remover item da fila de processamento."
                    ENDIF
                ENDIF

                IF !loc_lSucesso
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" - vale
                    *-- para a falha do DELETE E para a falha do Commit.
                    THIS.DesfazerTransacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaP para o item carregado em this_c* e
    * CONFIRMA a transacao, transcrevendo este trecho do OK.Click legado:
    *
    *   If Used('crRecalculaP') / USE in crRecalculaP / Endif
    *   llOk = fRecalculaP(Emps,grupos,estos,cpros,Datas,CodCors,CodTams, Podatamgr)
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *   llOk = fRecalculaP(.t., Podatamgr, .t.,.f.,.f.,.f.,.f.,.f.,.t.)
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *
    * O Commit() eh o TERCEIRO passo, com caminho de falha proprio - nao eh
    * detalhe de infra. Descartado, a transacao manual fica aberta e o
    * recalculo nao chega ao banco.
    *
    * A ARIDADE das duas chamadas segue o legado (8 e 9 argumentos), com
    * gnConnHandle no lugar do poDataMgr - a mesma substituicao que o
    * SigPrCccBO ja faz. A versao anterior passava 7 e 1 argumentos: como a
    * funcao devolve VALOR DE CALCULO, argumento faltando nao estoura, so
    * muda em silencio o que ela calcula (regra #17).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Ja medimos que fRecalculaP nao esta no acervo: nao chamar de novo.
        *-- Sem esta porta, cada item da fila repetia a excecao e (antes) um
        *-- MsgErro modal - no modo parametrizado o lote travava no primeiro.
        IF !THIS.this_lRecalculoDisponivel
            RETURN .F.
        ENDIF

        TRY
            IF USED("crRecalculaP")
                USE IN crRecalculaP
            ENDIF

            *-- Primeira chamada: recalcula o saldo do produto especifico
            loc_lSucesso = fRecalculaP( ;
                THIS.this_cEmps, ;
                THIS.this_cGrupos, ;
                THIS.this_cEstos, ;
                THIS.this_cCpros, ;
                THIS.this_dDatas, ;
                THIS.this_cCodCors, ;
                THIS.this_cCodTams, ;
                gnConnHandle )

            IF loc_lSucesso
                *-- Segunda chamada: consolida os saldos recalculados
                loc_lSucesso = fRecalculaP(.T., gnConnHandle, .T., .F., .F., .F., .F., .F., .T.)
            ENDIF

            IF loc_lSucesso
                *-- "llOk = ( ThisForm.PodataMgr.Commit() > 0 )" do legado
                loc_lSucesso = THIS.ConfirmarTransacao()
            ENDIF

            IF !loc_lSucesso
                THIS.DesfazerTransacao()
            ENDIF
        CATCH TO loc_oErro
            THIS.DesfazerTransacao()
            loc_lSucesso = .F.

            *-- Classificar o erro em vez de exibi-lo: o erro 1 do VFP9
            *-- ("File 'x' does not exist.") eh como uma funcao global AUSENTE
            *-- se manifesta, porque nome desconhecido seguido de "(" nao eh
            *-- erro de compilacao - o interpretador procura <nome>.prg no
            *-- PATH e so falha em RUNTIME (regra #13). Medir assim cobre
            *-- TODAS as formas de resolucao: se fRecalculaP vier de um SET
            *-- PROCEDURE, a chamada simplesmente funciona, enquanto um teste
            *-- por FILE() daria falso negativo e abortaria o lote bom.
            IF loc_oErro.ErrorNo = 1 AND "FRECALCULAP" $ UPPER(loc_oErro.Message)
                THIS.this_lRecalculoDisponivel = .F.
                THIS.this_cMensagemErro = "A fun" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + ;
                    "lculo de saldo (fRecalculaP) n" + CHR(227) + "o est" + CHR(225) + ;
                    " dispon" + CHR(237) + "vel nesta instala" + CHR(231) + CHR(227) + "o." + ;
                    CHR(13) + "Nenhum saldo foi recalculado e a fila foi preservada."
            ELSE
                *-- Erro REAL do recalculo (SQL, dado, conexao): registrar para
                *-- o chamador exibir UMA vez no fim da passada. Exibir aqui
                *-- abriria um dialogo por item e travaria o modo parametrizado.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular exclusao da fila
    *   .T. = nao tem movimento em SigMvEst E tem historico em SigMvHst (loop)
    *   .F. = tem movimento em SigMvEst OU nao tem historico -> pode excluir da fila
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ;
                         ALLTRIM(THIS.this_cGrupos) + ;
                         ALLTRIM(THIS.this_cEstos)
            loc_cSQL = "SELECT cidchaves FROM SigMvEst " + ;
                       "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                       "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1 OR RECCOUNT("TmpEst") = 0
                *-- Sem registro em SigMvEst: verificar SigMvHst
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_cSQL = "SELECT empgruests, SUM(1) AS TT FROM SigMvHst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + " " + ;
                           "GROUP BY empgruests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                IF loc_nResult < 1
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpHis") AND RECCOUNT("TmpHis") > 0
                    SELECT TmpHis
                    IF NVL(TT, 0) > 0
                        loc_lDeveLoop = .T.
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de saldos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpClP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

