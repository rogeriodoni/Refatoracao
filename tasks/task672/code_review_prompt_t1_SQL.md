# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PCNX' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ONLINES, USUARS, CIDCHAVES, GRUCONMOES, TT, LNERROR, LNKEY

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
		lcSql = [Select 0 as Flag,* From SigOpCls Where Onlines = 1 ]+;
		lcSql = [Select 0 as Flag,* From SigOpCls Order by GruConMoes ]
	llOk  = ( ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigOpCls') > 0 )
		Select CrSigOpCls
			lcUpDate   = [ Update SigOpCls Set Usuars = Usuars Where CidChaves = ']+crSigOpCls.CidChaves+[']
			lnErro1 = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1  )
			lcSql = [Select CidChaves From SigMvSlc where GruConMoes = ']+CrSigOpCls.Grupos+CrSigOpClS.Contas+CrSigOpClS.Moedas+[' ]
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpSccr') < 0 Or Reccount('TmpSccr') = 0
				lcSql = [Select GruConMoes, sum(1) as TT From SigMvCcr Where GruConMoes = ']+CrSigOpClS.Grupos + CrSigOpClS.Contas + CrSigOpClS.Moedas +[' ]+;
				If ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpMccr') < 0 Or TmpMccr.TT > 0
			Select CrSigOpClS
			Select CrSigPrSlS
			lcDelete = [ Delete From SigOpCls Where CidChaves = ']+crSigOpCls.CidChaves+[']
			llOk = ( ThisForm.poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRss.prg) - TRECHOS RELEVANTES PARA PASS SQL (903 linhas total):

*-- Linhas 416 a 434:
416:         THIS.this_lParar = .F.
417: 
418:         *-- Ponto de recarga: re-sincroniza Usuario/Online/Parametrizado com o
419:         *-- BO antes de montar o SELECT da fila.
420:         THIS.FormParaBO()
421:         SET CURSOR OFF
422: 
423:         *-- Keyboard '{LEFTARROW}' do legado: injeta uma tecla inocua para
424:         *-- que o INKEY() da primeira passada encontre o buffer num estado
425:         *-- conhecido.
426:         KEYBOARD "{LEFTARROW}"
427: 
428:         loc_nMov          = 1
429:         loc_lErroCnx      = .F.
430:         loc_lProcessando  = .T.
431:         loc_lSemRecalculo = .F.
432:         loc_cMsgFalha     = ""
433:         loc_cMsgExcecao   = ""
434: 

*-- Linhas 451 a 474:
451:                 IF !loc_lOk
452:                     loc_lErroCnx = .T.
453:                 ELSE
454:                     SELECT CrSigOpCls
455: 
456:                     SCAN
457:                         THIS.this_oBusinessObject.CarregarDoCursor("CrSigOpCls")
458: 
459:                         *-- Lock otimista do item (Update SigOpCls Set Usuars = Usuars)
460:                         loc_nResultLock = THIS.this_oBusinessObject.MarcarEmProcessamento()
461: 
462:                         IF loc_nResultLock <= 0
463:                             IF loc_nResultLock = -3
464:                                 *-- queda de conexao com BD: Exit do Scan (legado)
465:                                 loc_lErroCnx = .T.
466:                                 EXIT
467:                             ENDIF
468:                             LOOP
469:                         ENDIF
470: 
471:                         IF !THIS.this_oBusinessObject.ProcessarItem()
472:                             *-- fRecalculaS INALCANCAVEL (ela esta portada em
473:                             *-- utils\functions.prg - so cai aqui com deploy
474:                             *-- quebrado, functions.prg fora do SET PROCEDURE

*-- Linhas 493 a 511:
493:                             LOOP
494:                         ENDIF
495: 
496:                         *-- "Delete From SigOpCls ... Commit" do legado
497:                         IF !THIS.this_oBusinessObject.Excluir()
498:                             IF EMPTY(loc_cMsgFalha)
499:                                 loc_cMsgFalha = THIS.this_oBusinessObject.this_cMensagemErro
500:                             ENDIF
501:                             LOOP
502:                         ENDIF
503:                     ENDSCAN
504:                 ENDIF
505: 
506:                 *-- Rollback() incondicional depois do EndScan (legado): descarta
507:                 *-- o que tenha sobrado aberto na passada.
508:                 THIS.this_oBusinessObject.DesfazerTransacao()
509: 
510:             CATCH TO loc_oErro
511:                 *-- O loop faz SQL em toda passada e NAO tinha TRY/CATCH.


### BO (C:\4c\projeto\app\classes\SigPrRssBO.prg):
*==============================================================================
* Classe  : SigPrRssBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de contas (SIGPRRSS)
*            Form OPERACIONAL - processa fila SigOpCls chamando fRecalculaS
*            para cada conta na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*            Irmao de SigPrRsaBO (recalculo de saldo de PRODUTO) - mesma
*            estrutura, aplicada a CONTAS em vez de produtos.
*
* NOTA - fRecalculaS ESTA PORTADA (medido em 2026-10-18)
*   O OK.Click legado chama fRecalculaS duas vezes por item (recalculo do
*   saldo da conta e consolidacao), e a funcao EXISTE na nova arquitetura:
*   projeto\app\utils\functions.prg, portada de Framework\sigfuncs.PRG com
*   SQLEXEC(gnConnHandle) no lugar de loCnx.SqlExecute, junto com a auxiliar
*   fProcessarS. Outros cinco call sites do projeto ja a usam direto
*   (SigPrCccBO, SigPrMdcBO, FormSigPrMdc, Formsigopacc, Formsigmvcot).
*
*   Isto CORRIGE a nota anterior, copiada do irmao SigPrRsaBO, que afirmava
*   ausencia no acervo. A confusao e de NOME e vale registrar: o irmao
*   processa PRODUTOS e chama fRecalculaP - essa sim nao foi portada, e a
*   nota de escopo dele esta certa. Aqui e fRecalculaS, de CONTAS.
*
*   A deteccao de ausencia em ProcessarItem FICA, agora como rede de
*   seguranca de DEPLOY (functions.prg fora do SET PROCEDURE / PATH quebrado
*   - regra #26 ja produziu exatamente isso neste projeto), nao como premissa
*   sobre o acervo: sem ela, uma instalacao com functions.prg inalcancavel
*   abriria um dialogo MODAL por item da fila e travaria o lote.
*
*   fRecalculaS tambem resolve a pendencia do CursorQuery('SigCdPam',
*   'CrSigCdPam',...,[GrupoRecs,GrupoPags,ContaRecs,ContaPags]) que o Init
*   legado fazia: ela propria le essas quatro colunas de SigCdPam para o
*   cursor crAi1, entao o form nao precisa mais pre-carregar o cursor global.
*
* NOTA DE ESCOPO - SigPrSlS (CrSigPrSlS)
*   O Scatter/Zap/Append/Gather que o legado faz sobre esse cursor nao chega
*   ao banco: a linha "Thisform.Podatamgr.Update('CrSigPrSlS')" esta COMENTADA
*   no proprio fonte legado (SigPrRss_form_codigo_fonte.txt:433) e o buffer eh
*   descartado pelo Rollback incondicional que fecha o loop - por isso nao
*   havera INSERT/UPDATE migrado para SigPrSlS.
*==============================================================================
DEFINE CLASS SigPrRssBO AS BusinessBase

    *-- Parametros de execucao (LParameters pParam, pUsuario, pOnLine do Init legado)
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar
    this_lOnline         = .F.  && ThisForm.Online - loop continuo sem prompt de interrupcao
    this_cUsuario        = SPACE(10)  && ThisForm.Usuario - filtra a fila por usuario quando informado

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpCls (fila a processar)
    this_cCidChaves   = ""      && cidchaves char(20) - PK da fila
    this_cGrupos      = ""      && grupos char(10) - grupo da conta
    this_cContas      = ""      && contas char(10) - conta
    this_cMoedas      = ""      && moedas char(3) - moeda
    this_dDatas       = {}      && datas datetime - data do movimento
    this_cGruConMoes  = ""      && gruconmoes char(23) - Grupos + Contas + Moedas
    this_cUsuars      = ""      && usuars char(20) - usuario processador
    this_nOnlines     = 0       && onlines numeric(1,0) - processamento continuo (0/1)
    this_cEmps        = ""      && emps char(3) - empresa
    this_lChkPrc      = .F.     && chkprc bit - checagem de preco

    *-- Controle de TRANSACAO MANUAL (regra: o migrador descarta o Commit()
    *-- do legado e a gravacao fica presa na transacao aberta). O OK.Click
    *-- legado tem DOIS Commit() e SETE Rollback() - sem eles o
    *-- DELETE FROM SigOpCls nunca eh efetivado, a fila NAO drena e o lote
    *-- reprocessa os MESMOS itens a cada passada do DO WHILE, para sempre.
    this_lTransacaoManual = .F.

    *-- fRecalculaS ESTA portada (ver NOTA no cabecalho), entao em instalacao
    *-- sadia esta flag nunca cai. Ela e rede de seguranca de DEPLOY: se
    *-- functions.prg nao estiver alcancavel, a chamada estoura erro 1 do VFP9
    *-- ("File does not exist") e a flag faz a ausencia gerar UMA mensagem e
    *-- abortar a passada, em vez de um MsgErro MODAL POR ITEM da fila, que
    *-- travaria o modo parametrizado.
    this_lRecalculoDisponivel = .T.

    *--------------------------------------------------------------------------
    * Init - BO de processamento em lote (SIGPRRSS), nao um cadastro CRUD:
    * nao ha tabela/chave primaria "principal" governada por Salvar/Excluir,
    * entao this_cTabela e this_cCampoChave permanecem vazios (mesmo padrao de
    * SigPrRsaBO) e DODEFAULT() segue sem instanciar DataAccess.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.DetectarTransacaoManual()
    ENDPROC

    *--------------------------------------------------------------------------
    * DetectarTransacaoManual - mede UMA vez se a conexao esta em transacao
    * MANUAL (SQLGETPROP "Transactions" = 2) ou em auto-commit (1). Mesma
    * tecnica de SigPrRsaBO.prg: medir em vez de presumir deixa o par
    * Confirmar/DesfazerTransacao INERTE em auto-commit, sem precisar saber
    * de antemao qual modo esta ativo.
    *
    * SQLGETPROP com handle invalido DISPARA EXCECAO (nao devolve -1), e o
    * harness de teste define gnConnHandle = 0 de proposito; por isso a
    * guarda de tipo/valor ANTES e o TRY em volta. Sem conexao o resultado eh
    * .F. (par inerte), nunca falha de instanciacao do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DetectarTransacaoManual()
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
    * ConfirmarTransacao - SQLCOMMIT, equivalente ao ThisForm.PodataMgr.Commit()
    * do legado. O OK.Click chama Commit() em dois pontos distintos do loop de
    * processamento (cada um com o proprio caminho de falha) - o commit eh um
    * PASSO da regra de negocio, nao detalhe de infra.
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
    * DesfazerTransacao - SQLROLLBACK, equivalente ao ThisForm.Podatamgr.Rollback()
    * do legado (SETE chamadas no OK.Click: uma por caminho de falha, mais a
    * incondicional apos o EndScan, que descarta o que sobrou aberto na
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
    * RegistrarFalha - canal UNICO de erro desta classe.
    *
    * Cada metodo deste BO roda DENTRO do loop de processamento do form (ou,
    * no caso dos logs, dentro do ramo parametrizado) - e em modo
    * parametrizado nao ha ninguem na frente da tela: um MsgErro ali eh modal
    * e TRAVA o processamento desassistido indefinidamente (regra #6), exatamente
    * como o DesfazerTransacao acima ja documentava. Pior: BuscarFila roda a
    * CADA passada e CarregarDoCursor a cada ITEM, entao uma conexao caida
    * geraria um dialogo por item.
    *
    * Regra #9 (CATCH nunca silencioso) continua honrada: a mensagem eh SEMPRE
    * gravada em this_cMensagemErro, que o form reporta uma unica vez por
    * execucao pelo canal dele (ReportarFalhaProcessamento -> Fortyus.Log em
    * modo batch, dialogo em modo interativo). No modo interativo o dialogo
    * imediato eh mantido, porque ali ha usuario para ler.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarFalha(par_cMensagem)
        LOCAL loc_cMensagem
        loc_cMensagem = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
        IF EMPTY(loc_cMensagem)
            RETURN
        ENDIF
        THIS.this_cMensagemErro = loc_cMensagem
        IF !THIS.this_lParametrizado
            MsgErro(loc_cMensagem, "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveGruConMoes - gruconmoes char(23) = grupos(10) + contas(10) +
    * moedas(3), transcrito de
    *   lcSql = [... where GruConMoes = ']+CrSigOpCls.Grupos+CrSigOpClS.Contas+CrSigOpClS.Moedas+[' ]
    * do OK.Click legado. Chave POSICIONAL (regra #42 CLAUDE.md) - cada parte
    * tem de vir com PADR explicito na largura da coluna de origem, NUNCA
    * ALLTRIM nas partes interiores, senao a concatenacao nunca mais casa com
    * o gruconmoes gravado em SigMvCcr/SigMvSlc (SELECT roda sem erro e
    * devolve ZERO linhas, em silencio).
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveGruConMoes()
        RETURN PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
               PADR(ALLTRIM(THIS.this_cContas), 10) + ;
               PADR(ALLTRIM(THIS.this_cMoedas), 3)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador do registro (fila SigOpCls)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpCls
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cContas    = NVL(contas, "")
                THIS.this_cMoedas    = NVL(moedas, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cUsuars    = NVL(usuars, "")
                THIS.this_nOnlines   = NVL(onlines, 0)
                THIS.this_cEmps      = NVL(emps, "")

                IF TYPE("gruconmoes") != "U"
                    THIS.this_cGruConMoes = NVL(gruconmoes, "")
                ELSE
                    THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()
                ENDIF

                *-- chkprc eh bit NULL - chega como Logico ou Numerico conforme
                *-- o driver (regra #13); testar VARTYPE antes de comparar.
                IF TYPE("chkprc") != "U"
                    IF VARTYPE(chkprc) = "L"
                        THIS.this_lChkPrc = chkprc
                    ELSE
                        THIS.this_lChkPrc = (NVL(chkprc, 0) <> 0)
                    ENDIF
                ELSE
                    THIS.this_lChkPrc = .F.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpCls (enfileira item para recalculo de saldo
    * de conta). Cobre TODAS as colunas da tabela (regra #22): cidchaves eh
    * PK sem default (gerada via fUniqueIds se vazia) e emps/onlines sao
    * NOT NULL sem default.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()

            loc_cSQL = "INSERT INTO SigOpCls " + ;
                       "(grupos, contas, moedas, datas, cidchaves, gruconmoes, " + ;
                       "usuars, onlines, chkprc, emps) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(THIS.this_cGruConMoes) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                       IIF(THIS.this_lChkPrc, "1", "0") + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                *-- Commit explicito: BusinessBase nao da SQLCOMMIT e a conexao
                *-- pode nascer em transacao MANUAL - sem isto o INSERT fica
                *-- preso e some ao fim do processo.
                loc_lSucesso = THIS.ConfirmarTransacao()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    THIS.DesfazerTransacao()
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo de saldos (SigOpCls)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpCls com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                THIS.this_cGruConMoes = THIS.MontarChaveGruConMoes()

                loc_cSQL = "UPDATE SigOpCls SET " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "contas = " + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", " + ;
                           "moedas = " + EscaparSQL(ALLTRIM(THIS.this_cMoedas)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "gruconmoes = " + EscaparSQL(THIS.this_cGruConMoes) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "onlines = " + FormatarNumeroSQL(THIS.this_nOnlines, 0) + ", " + ;
                           "chkprc = " + IIF(THIS.this_lChkPrc, "1", "0") + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + " " + ;
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
                        THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo de saldos (SigOpCls)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de
    * saldos de contas (fila SigOpCls)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpCls") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpCls em CrSigOpCls, transcrito do OK.Click:
    *   If Not Empty(ThisForm.Usuario) Or ThisForm.Online
    *       lcSql = [...Where Onlines = 1] + Iif(Usuario informado, [And Usuars='X'], [ ])
    *   Else
    *       lcSql = [...sem filtro...]
    *   Endif
    * Sem filtro de Usuario/Online, traz a fila INTEIRA (mesmo comportamento
    * do legado) - nao e bug de migracao, e a condicao que CERCA a consulta
    * (regra #21b CLAUDE.md).
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpCls")
                USE IN CrSigOpCls
            ENDIF

            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF !EMPTY(loc_cUsuario) OR THIS.this_lOnline
                loc_cSQL = "SELECT cidchaves, grupos, contas, moedas, datas, " + ;
                           "gruconmoes, usuars, onlines, chkprc, emps " + ;
                           "FROM SigOpCls WHERE onlines = 1 "
                IF !EMPTY(loc_cUsuario)
                    loc_cSQL = loc_cSQL + "AND usuars = " + EscaparSQL(loc_cUsuario) + " "
                ENDIF
                loc_cSQL = loc_cSQL + "ORDER BY gruconmoes"
            ELSE
                loc_cSQL = "SELECT cidchaves, grupos, contas, moedas, datas, " + ;
                           "gruconmoes, usuars, onlines, chkprc, emps " + ;
                           "FROM SigOpCls ORDER BY gruconmoes"
            ENDIF

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpCls") > 0)

            *-- this_nTotalFila/this_nProcessados sao o par de contadores da
            *-- PASSADA corrente (uma volta do DO WHILE do form), por isso o
            *-- contador de processados zera aqui, junto com a releitura da
            *-- fila. Quem os consome eh o relatorio de falha parcial do form,
            *-- que eh mensagem do sistema NOVO - a tela legada nao exibe
            *-- contagem nenhuma e o Label1 continua com o texto literal do
            *-- legado (PILAR 1).
            THIS.this_nProcessados = 0
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpCls")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - lock otimista do item corrente, transcrito de
    *   lcUpdate = [ Update SigOpCls Set Usuars = Usuars Where CidChaves = '..']
    *   lnErro1  = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1 )
    * no OK.Click legado. Devolve o RESULTADO NUMERICO porque o legado
    * distingue -3 (queda de conexao -> Exit do Scan) de qualquer outra falha
    * (-> Loop). PUBLIC: o form percorre o cursor da fila e chama item a item.
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmProcessamento()
        LOCAL loc_nResult, loc_cSQL, loc_oErro
        loc_nResult = 0
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpCls SET usuars = usuars " + ;
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
    * ProcessarItem - chama fRecalculaS para o item carregado em this_c* e
    * CONFIRMA a transacao, transcrevendo este trecho do OK.Click legado:
    *
    *   If Used('crRecalculaS') / Use In crRecalculaS / Endif
    *   llOk = fRecalculaS( Grupos, Contas, Datas, Moedas, Podatamgr )
    *   If Not llOk / Loop / Endif
    *   llOk = fRecalculaS( .t., Podatamgr, .t., .f., .f., .t. )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *
    * O legado NAO faz Rollback apos a falha da PRIMEIRA chamada (so Loop,
    * deixando o lock sem liberar para o Rollback incondicional do fim do Scan),
    * mas faz Rollback apos a segunda chamada e apos o Commit. Mesma
    * simplificacao adotada em SigPrRsaBO.ProcessarItem (rollback em QUALQUER
    * falha, via "IF !loc_lSucesso"): o efeito transacional no fim da
    * iteracao e IDENTICO - nada commita, tudo desfaz, item fica na fila.
    *
    * fRecalculaS ESTA portada em utils\functions.prg (ver NOTA no cabecalho
    * da classe) - a disponibilidade e medida UMA vez (classificando o erro 1
    * do VFP9) so como rede de seguranca de DEPLOY, para que functions.prg
    * inalcancavel gere UMA mensagem e aborte a passada, em vez de um MsgErro
    * modal por item (travaria o modo parametrizado).
    *
    * A 2a chamada passa gnConnHandle (numerico) onde o legado passava o
    * objeto poDataMgr, porque na nova arquitetura nao existe objeto de
    * conexao. Isso e o que os outros call sites do projeto ja fazem
    * (SigPrCccBO, SigPrMdcBO, Formsigopacc) e e o contrato da funcao portada,
    * que resolve a conexao por "IIF(TYPE(pCnx)=N AND pCnx>0, pCnx,
    * gnConnHandle)". O 6o argumento (pAut = .T.) e transcrito do legado e e
    * quem carrega a semantica de "modo automatico" na versao portada.
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF !THIS.this_lRecalculoDisponivel
            RETURN .F.
        ENDIF

        TRY
            IF USED("crRecalculaS")
                USE IN crRecalculaS
            ENDIF

            *-- Primeira chamada: recalcula o saldo da conta especifica
            loc_lSucesso = fRecalculaS( ;
                THIS.this_cGrupos, ;
                THIS.this_cContas, ;
                THIS.this_dDatas, ;
                THIS.this_cMoedas, ;
                gnConnHandle )

            IF loc_lSucesso
                *-- Segunda chamada: consolida os saldos recalculados
                loc_lSucesso = fRecalculaS(.T., gnConnHandle, .T., .F., .F., .T.)
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

            *-- Classificar o erro em vez de exibi-lo: erro 1 do VFP9 ("File
            *-- 'x' does not exist.") e como uma funcao global INALCANCAVEL se
            *-- manifesta (regra #13) - nome desconhecido seguido de "(" nao e
            *-- erro de compilacao, so estoura em runtime.
            *--
            *-- fRecalculaS EXISTE em utils\functions.prg (ver NOTA no
            *-- cabecalho): este ramo nao e "funcao nao migrada", e deploy
            *-- quebrado - functions.prg fora do SET PROCEDURE ou PATH mal
            *-- formado (regra #26). A mensagem diz isso, para nao mandar quem
            *-- for diagnosticar procurar uma migracao que ja foi feita.
            IF loc_oErro.ErrorNo = 1 AND "FRECALCULAS" $ UPPER(loc_oErro.Message)
                THIS.this_lRecalculoDisponivel = .F.
                THIS.this_cMensagemErro = "A fun" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + ;
                    "lculo de saldo (fRecalculaS) n" + CHR(227) + "o p" + CHR(244) + "de ser " + ;
                    "carregada (utils" + CHR(92) + "functions.prg inalcan" + CHR(231) + CHR(225) + "vel)." + ;
                    CHR(13) + "Nenhum saldo foi recalculado e a fila foi preservada."
            ELSE
                *-- Erro REAL do recalculo (SQL, dado, conexao): registrar
                *-- para o chamador exibir UMA vez no fim da passada.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular a exclusao da fila
    * (manter o item para reprocessar depois), transcrito de:
    *
    *   lcSql = [Select CidChaves From SigMvSlc where GruConMoes = '..' ]
    *   If Sqlexecute(lcSql,'TmpSccr') < 0 Or Reccount('TmpSccr') = 0
    *       lcSql = [Select GruConMoes, sum(1) as TT From SigMvCcr
    *                Where GruConMoes = '..' Group By GruConMoes]
    *       If Sqlexecute(lcSql,'TmpMccr') < 0 Or TmpMccr.TT > 0
    *           Loop
    *       Endif
    *   Endif
    *
    * Isto e: achou saldo corrente em SigMvSlc -> pode excluir da fila (.F.);
    * nao achou -> so pode excluir se SigMvCcr nao tiver movimento em aberto
    * (TT = 0); erro de consulta em qualquer um dos dois -> NAO excluir (.T.).
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult, loc_oErro
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = THIS.MontarChaveGruConMoes()

            IF USED("TmpSccr")
                USE IN TmpSccr
            ENDIF
            loc_cSQL = "SELECT cidchaves FROM SigMvSlc " + ;
                       "WHERE gruconmoes = " + EscaparSQL(loc_cChave)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpSccr")

            IF loc_nResult < 0 OR !USED("TmpSccr") OR RECCOUNT("TmpSccr") = 0
                IF USED("TmpMccr")
                    USE IN TmpMccr
                ENDIF
                loc_cSQL = "SELECT gruconmoes, SUM(1) AS TT FROM SigMvCcr " + ;
                           "WHERE gruconmoes = " + EscaparSQL(loc_cChave) + " " + ;
                           "GROUP BY gruconmoes"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr")
                IF loc_nResult < 0
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpMccr") AND RECCOUNT("TmpMccr") > 0
                        SELECT TmpMccr
                        IF NVL(TT, 0) > 0
                            loc_lDeveLoop = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("TmpSccr")
                USE IN TmpSccr
            ENDIF
            IF USED("TmpMccr")
                USE IN TmpMccr
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - remove o item da fila e CONFIRMA, transcrevendo:
    *
    *   lcDelete = [ Delete From SigOpCls Where CidChaves = '..' ]
    *   llOk = ( poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *   llOk = llOk And ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *
    * Este e o Commit MAIS CRITICO do form: e ele que efetiva a saida do item
    * da fila. Sem ele, com a conexao em transacao manual, o DELETE fica
    * preso e a fila nunca drena.
    *
    * NOTA DE ESCOPO - gravacao em SigPrSlS (CrSigPrSlS): entre a checagem de
    * movimento e o DELETE, o legado faz Scatter/Zap/Append/Gather sobre o
    * cursor CrSigPrSlS, mas a linha que o persistiria
    * ("* llOk = Thisform.Podatamgr.Update('CrSigPrSlS')") esta COMENTADA no
    * fonte legado e o buffer e descartado pelo Rollback incondicional do fim
    * do Scan. NAO migrado INSERT/UPDATE em SigPrSlS - inventar aqui uma
    * gravacao que o legado nao faz violaria o PILAR 2 tanto quanto perder
    * uma que ele faz.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpCls " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- "llOk = llOk And ( PodataMgr.Commit() > 0 )" do legado
                    loc_lSucesso = THIS.ConfirmarTransacao()

                    IF loc_lSucesso
                        *-- DELETE confirmado eh o UNICO ponto em que o item
                        *-- deixa de fato a fila - contar antes do Commit
                        *-- informaria item que o rollback devolveu.
                        THIS.this_nProcessados = THIS.this_nProcessados + 1
                    ENDIF
                ELSE
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao remover item da fila de recalculo de saldos (SigOpCls)."
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
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo, loc_oErro
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        LOCAL loc_oErro
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            THIS.RegistrarFalha(loc_oErro.Message)
        ENDTRY
    ENDPROC

ENDDEFINE

