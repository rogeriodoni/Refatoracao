# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [TRANSACAO-AVULSA] Linha 754: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 765: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 769: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 771: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 778: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 780: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 788: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg) - TRECHOS RELEVANTES PARA PASS SQL (607 linhas total):

*-- Linhas 340 a 409:
340:             IF !loc_lOk
341:                 loc_lErroCnx = .T.
342:             ELSE
343:                 SELECT CrSigOpClP
344:                 loc_nTotal      = RECCOUNT("CrSigOpClP")
345:                 loc_nProcessado = 0
346: 
347:                 SCAN
348:                     loc_nProcessado = loc_nProcessado + 1
349:                     THIS.lbl_4c_Progresso.Caption = "Aguarde. Processando Produtos (" + ;
350:                         ALLTRIM(STR(loc_nProcessado)) + "/" + ALLTRIM(STR(loc_nTotal)) + ")"
351: 
352:                     loc_cCidChaves = ALLTRIM(CrSigOpClP.CidChaves)
353: 
354:                     *-- Marcar item como em processamento (lock otimista)
355:                     loc_cSQL = "UPDATE SigOpClP SET Usuars = Usuars " + ;
356:                                "WHERE CidChaves = " + EscaparSQL(loc_cCidChaves)
357:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
358: 
359:                     IF loc_nResult <= 0
360:                         SQLEXEC(gnConnHandle, "ROLLBACK")
361:                         IF loc_nResult = -3
362:                             loc_lErroCnx = .T.
363:                             EXIT
364:                         ENDIF
365:                         LOOP
366:                     ENDIF
367: 
368:                     THIS.this_oBusinessObject.CarregarDoCursor("CrSigOpClP")
369: 
370:                     IF !THIS.this_oBusinessObject.ProcessarItem()
371:                         SQLEXEC(gnConnHandle, "ROLLBACK")
372:                         LOOP
373:                     ENDIF
374: 
375:                     loc_nResult = SQLEXEC(gnConnHandle, "COMMIT")
376:                     IF loc_nResult <= 0
377:                         SQLEXEC(gnConnHandle, "ROLLBACK")
378:                         LOOP
379:                     ENDIF
380: 
381:                     *-- Verificar se pode remover da fila (sem pendencias em SigMvEst)
382:                     IF !THIS.this_oBusinessObject.VerificarMovimento()
383:                         IF THIS.this_oBusinessObject.Excluir()
384:                             SQLEXEC(gnConnHandle, "COMMIT")
385:                         ELSE
386:                             SQLEXEC(gnConnHandle, "ROLLBACK")
387:                             LOOP
388:                         ENDIF
389:                     ENDIF
390: 
391:                 ENDSCAN
392:             ENDIF
393: 
394:             SQLEXEC(gnConnHandle, "ROLLBACK")
395:             THIS.cmd_4c_Encerrar.Enabled = .T.
396: 
397:             *-- Aguardar breve intervalo: permite que ESC seja detectado
398:             loc_nError = 0
399:             loc_cErro  = ON("Error")
400:             ON ERROR loc_nError = 1
401:             loc_nKey = INKEY(0.5, "M")
402:             IF loc_nError <> 0
403:                 loc_nKey = 0
404:             ENDIF
405:             ON ERROR &loc_cErro.
406: 
407:             IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroCnx OR THIS.this_lParar
408:                 loc_lProcessando = .F.
409:             ENDIF

*-- Linhas 740 a 607:

*-- Linhas 751 a 607:

*-- Linhas 755 a 607:

*-- Linhas 757 a 607:

*-- Linhas 764 a 607:

*-- Linhas 766 a 607:

*-- Linhas 774 a 607:


### BO (C:\4c\projeto\app\classes\SigPrRsaBO.prg):
*==============================================================================
* Classe  : SigPrRsaBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de produto (SIGPRRSA)
*            Form OPERACIONAL - processa fila SigOpClP chamando fRecalculaP
*            para cada produto na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
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

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

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
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
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
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
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
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpClP SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigOpClP apos processamento bem sucedido
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpClP " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao remover item da fila de processamento."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaP para o item carregado em this_c*
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("crRecalculaP")
                USE IN crRecalculaP
            ENDIF
            *-- Primeira chamada: calcula saldo do produto especifico
            loc_lSucesso = fRecalculaP( ;
                THIS.this_cEmps, ;
                THIS.this_cGrupos, ;
                THIS.this_cEstos, ;
                THIS.this_cCpros, ;
                THIS.this_dDatas, ;
                THIS.this_cCodCors, ;
                THIS.this_cCodTams )
            IF loc_lSucesso
                *-- Segunda chamada: consolida saldos em fila aguardando processamento
                loc_lSucesso = fRecalculaP(.T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
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

