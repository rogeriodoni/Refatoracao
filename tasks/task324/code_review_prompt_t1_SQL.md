# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, LNKEY

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
	lcSql = [Select 0 as Flag,* From SigOpClC Order by EmpCpros ]
	llOk  = ( ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigOpClC') > 0 )
		Select CrSigOpClC
			lcUpdate = [ Update SigOpClC Set Usuars = Usuars Where CidChaves = ']+lcCidChave+[']
			lnErro1 = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1  )
			lcDelete = [ Delete From SigOpClC Where CidChaves = ']+lcCidChave+[']
			llOk = ( ThisForm.poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprrcu.prg) - TRECHOS RELEVANTES PARA PASS SQL (619 linhas total):

*-- Linhas 314 a 333:
314:     * CmdProcessarClick - Loop principal de recalculo de custos de produto
315:     * Replica SIGPRRCU.OK.Click:
316:     *   1. Busca produtos na fila SigOpClC
317:     *   2. Para cada item: marca em processamento (UPDATE), chama fRecalculaC (x2)
318:     *   3. Remove da fila (DELETE) e confirma (COMMIT)
319:     *   4. Repete continuamente ate ESC ou erro de conexao
320:     *==========================================================================
321:     PROCEDURE CmdProcessarClick()
322:         LOCAL loc_lOk, loc_lErroConexao, loc_nMov, loc_cCidChave, loc_nErro, loc_nKey
323: 
324:         THIS.AlternarPagina("PROCESSANDO")
325:         loc_lErroConexao = .F.
326:         loc_nMov         = 1
327: 
328:         SET CURSOR OFF
329: 
330:         DO WHILE .T.
331:             THIS.cmd_4c_Encerrar.Enabled = .F.
332: 
333:             THIS.cnt_4c_Dados.lbl_4c_Status.Caption = "Aguardando Produtos Para Processar" + REPLICATE(".", loc_nMov)

*-- Linhas 340 a 418:
340:             IF !loc_lOk
341:                 loc_lErroConexao = .T.
342:             ELSE
343:                 SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
344:                 SELECT CrSigOpClC
345: 
346:                 SCAN
347:                     loc_cCidChave = TratarNulo(CrSigOpClC.CidChaves, "C")
348: 
349:                     *-- Marca item em processamento (lock transacional via UPDATE Usuars)
350:                     loc_nErro = THIS.this_oBusinessObject.MarcarEmProcessamento(gnConnHandle, loc_cCidChave)
351:                     loc_lOk   = (loc_nErro > 0)
352: 
353:                     IF !loc_lOk
354:                         SQLEXEC(gnConnHandle, "ROLLBACK")
355:                         IF loc_nErro < 0
356:                             loc_lErroConexao = .T.
357:                             EXIT
358:                         ENDIF
359:                         LOOP
360:                     ENDIF
361: 
362:                     IF USED("TmpCustPro")
363:                         USE IN TmpCustPro
364:                     ENDIF
365: 
366:                     *-- 1a chamada fRecalculaC: recalcula custo do produto na data
367:                     loc_lOk = THIS.this_oBusinessObject.ExecutarRecalculo( ;
368:                                   TratarNulo(CrSigOpClC.Emps,  "C"), ;
369:                                   TratarNulo(CrSigOpClC.Cpros, "C"), ;
370:                                   TratarNulo(CrSigOpClC.Datas, "D"))
371: 
372:                     IF !loc_lOk
373:                         SQLEXEC(gnConnHandle, "ROLLBACK")
374:                         LOOP
375:                     ENDIF
376: 
377:                     *-- 2a chamada fRecalculaC: confirma calculo com handle de transacao
378:                     loc_lOk = THIS.this_oBusinessObject.ExecutarRecalculoFinal(gnConnHandle)
379: 
380:                     IF !loc_lOk
381:                         SQLEXEC(gnConnHandle, "ROLLBACK")
382:                         LOOP
383:                     ENDIF
384: 
385:                     *-- Remove item processado da fila
386:                     loc_lOk = THIS.this_oBusinessObject.RemoverDaFila(gnConnHandle, loc_cCidChave)
387: 
388:                     IF !loc_lOk
389:                         SQLEXEC(gnConnHandle, "ROLLBACK")
390:                         LOOP
391:                     ENDIF
392: 
393:                     loc_lOk = (SQLEXEC(gnConnHandle, "COMMIT") > 0)
394:                     IF !loc_lOk
395:                         SQLEXEC(gnConnHandle, "ROLLBACK")
396:                         LOOP
397:                     ENDIF
398:                     SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
399: 
400:                 ENDSCAN
401:             ENDIF
402: 
403:             SQLEXEC(gnConnHandle, "ROLLBACK")
404:             THIS.AlternarPagina("AGUARDANDO")
405: 
406:             *-- Aguarda 0.5s por tecla ou mouse; ESC (27) encerra o loop
407:             loc_nKey = INKEY(0.5, "M")
408: 
409:             IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroConexao
410:                 EXIT
411:             ENDIF
412:         ENDDO
413: 
414:         SET CURSOR ON
415: 
416:         THIS.AlternarPagina("IDLE")
417: 
418:         IF THIS.this_lParametrizado


### BO (C:\4c\projeto\app\classes\sigprrcuBO.prg):
*==============================================================================
* sigprrcuBO.prg - Business Object: Recalculo de Custos de Produto
* Herda de: BusinessBase
* Tabela principal: SigOpClC (fila de recalculo de custos em lote)
*==============================================================================
DEFINE CLASS sigprrcuBO AS BusinessBase

    *-- Estado do processamento
    this_lParametrizado = .F.    && .T. quando acionado via Fortyus.Exe
    this_lErroConexao   = .F.    && .T. se houve queda de conexao durante o loop
    this_lProcessando   = .F.    && .T. enquanto loop de processamento esta ativo
    this_cArquivoLog    = ""     && Caminho do arquivo de log (Fortyus.Log)
    this_nContadorAnima = 0      && Contador de animacao dos pontos no label de status

    *-- Campos de SigOpClC
    this_cCidChave  = ""    && CidChaves PK (uniqueidentifier)
    this_cEmps      = ""    && Empresa
    this_cCpros     = ""    && Codigo do Produto
    this_dDatas     = {}    && Data de referencia
    this_cUsuars    = ""    && Usuario que enfileirou
    this_cEmpCpros  = ""    && Emps + Cpros (chave de ordenacao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "CidChaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChave
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = TratarNulo(CidChaves, "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cCpros     = TratarNulo(Cpros,     "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_cEmpCpros  = TratarNulo(EmpCpros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cCpros)
                THIS.this_cMensagemErro = "Empresa e produto s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
            ELSE
                THIS.this_cEmpCpros = RTRIM(THIS.this_cEmps) + RTRIM(THIS.this_cCpros)

                loc_cSQL = "INSERT INTO SigOpClC (CidChaves, Emps, Cpros, Datas, Usuars, EmpCpros) VALUES (" + ;
                           "NEWID(), " + ;
                           EscaparSQL(THIS.this_cEmps) + ", " + ;
                           EscaparSQL(THIS.this_cCpros) + ", " + ;
                           FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(THIS.this_cEmpCpros) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChave)
                THIS.this_cMensagemErro = "Chave n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            ELSE
                loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChave)

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar item na fila de recalculo."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Carrega itens da fila SigOpClC em cursor local (CrSigOpClC) para recalculo
    * par_nHandle: handle de conexao SQL (da transacao ativa do form)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutosPendentes(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigOpClC")
                USE IN CrSigOpClC
            ENDIF
            loc_cSQL = "SELECT 0 AS Flag, * FROM SigOpClC ORDER BY EmpCpros"
            loc_nRet = SQLEXEC(par_nHandle, loc_cSQL, "CrSigOpClC")
            loc_lSucesso = (loc_nRet > 0)

            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao buscar produtos pendentes."
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - UPDATE SigOpClC para criar lock transacional
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item a marcar
    * Retorna: 1 sucesso | 0 falha | -3 queda de conexao
    *--------------------------------------------------------------------------
    PROCEDURE MarcarEmProcessamento(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "UPDATE SigOpClC SET Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                   " WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN loc_nRet
    ENDPROC

    *--------------------------------------------------------------------------
    * RemoverDaFila - DELETE FROM SigOpClC apos processamento bem-sucedido
    * par_nHandle:   handle de conexao (transacao ativa)
    * par_cCidChave: CidChaves do item processado
    *--------------------------------------------------------------------------
    PROCEDURE RemoverDaFila(par_nHandle, par_cCidChave)
        LOCAL loc_cSQL, loc_nRet
        loc_cSQL = "DELETE FROM SigOpClC WHERE CidChaves = " + EscaparSQL(par_cCidChave)
        loc_nRet = SQLEXEC(par_nHandle, loc_cSQL)
        RETURN (loc_nRet > 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculo - Chama fRecalculaC para recalcular custo do produto
    * par_cEmps:  empresa (usa go_4c_Sistema.cCodEmpresa se vazio)
    * par_cCpros: codigo do produto
    * par_dDatas: data de referencia
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculo(par_cEmps, par_cCpros, par_dDatas)
        LOCAL loc_lSucesso, loc_oErro, loc_cEmps
        loc_lSucesso = .F.

        TRY
            loc_cEmps = IIF(EMPTY(par_cEmps), go_4c_Sistema.cCodEmpresa, par_cEmps)

            loc_lSucesso = fRecalculaC(loc_cEmps, par_cCpros, par_dDatas)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarRecalculoFinal - Segunda chamada de fRecalculaC (commit calculo)
    * par_nHandle: handle de conexao da transacao ativa
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarRecalculoFinal(par_nHandle)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = fRecalculaC(.T., .T., .F., par_nHandle, .T.)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - Escreve cabecalho no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog()
        LOCAL loc_cLinha

        THIS.this_cArquivoLog = "Fortyus.Log"
        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Iniciando o Processamento : Fortyus.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConcluirLog - Escreve rodape no arquivo Fortyus.Log
    *--------------------------------------------------------------------------
    PROCEDURE ConcluirLog()
        LOCAL loc_cLinha

        STRTOFILE("", THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Concluindo o Processamento : Prod2005.Exe (SigOpClC) - Recalculo de Custos"
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = "Data : " + DTOC(DATE()) + " - Hora : " + TIME()
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)

        loc_cLinha = REPLICATE("=", 80)
        STRTOFILE(loc_cLinha + CHR(10), THIS.this_cArquivoLog, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarEntradaLog - Escreve uma linha no arquivo de log
    *--------------------------------------------------------------------------
    PROCEDURE GravarEntradaLog(par_cMensagem)
        IF !EMPTY(THIS.this_cArquivoLog)
            STRTOFILE(par_cMensagem + CHR(10), THIS.this_cArquivoLog, .T.)
        ENDIF
    ENDPROC

ENDDEFINE

