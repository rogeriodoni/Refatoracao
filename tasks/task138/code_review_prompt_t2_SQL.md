# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NENVS, DOPPS, SEPPEDRAS, CHKDESTS, TPOPS, CHKDEVS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
		lcSql = [Select a.EmpDnPs, a.Cmats, a.Qtds, a.TpOps From SigCdNei a, SigCdOpd b, SigOpOpt c ]+;
				[Select a.EmpDnPs, a.Cmats, (a.Qtds*-1) as Qtds, a.TpOps From SigCdNei a, SigCdOpd b ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocalNoo') < 1)
		Select LocalNoo
			.Column1.ControlSource   = 'LocalNoo.EmpDnPs'  	
			.Column2.ControlSource   = 'LocalNoo.Cmats' 	
			.Column3.ControlSource   = 'LocalNoo.TpOPs'
			.Column4.ControlSource   = 'LocalNoo.Qtds'
	Select xNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM13.prg) - TRECHOS RELEVANTES PARA PASS SQL (717 linhas total):

*-- Linhas 332 a 350:
332:             .Width         = 841
333:             .Height        = 426
334:             .RecordMark    = .F.
335:             .DeleteMark    = .F.
336:             .GridLineColor = RGB(238,238,238)
337:             .FontName      = "Verdana"
338:             .FontSize      = 8
339:             .Visible       = .T.
340:         ENDWITH
341: 
342:         WITH loc_oGrd.Column1
343:             .ColumnOrder        = 1
344:             .Width              = 270
345:             .Movable            = .F.
346:             .Resizable          = .F.
347:             .ReadOnly           = .T.
348:             .FontName           = "Courier New"
349:             .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
350:             .Header1.FontName   = "Tahoma"

*-- Linhas 443 a 489:
443:     * CarregarDados - Carrega dados do envelope e popula grid
444:     * 1. BO.CarregarOperacao -> preenche container Operacao
445:     * 2. BO.CarregarDados   -> popula cursor_4c_Dados
446:     * 3. Rebind do grid (ControlSource + headers reconfigurados apos RecordSource)
447:     *--------------------------------------------------------------------------
448:     PROCEDURE CarregarDados()
449:         LOCAL loc_lSucesso, loc_oGrd, loc_oErro
450:         loc_lSucesso = .F.
451: 
452:         TRY
453:             *-- Carregar informacoes do envelope (empresa, operacao, numero)
454:             IF THIS.this_oBusinessObject.CarregarOperacao(THIS.this_nNenvs)
455:                 WITH THIS.cnt_4c_Operacao
456:                     .txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
457:                     .txt_4c_Operacao.Value = THIS.this_oBusinessObject.this_cDopps
458:                     .txt_4c_Codigo.Value   = THIS.this_oBusinessObject.this_nNumps
459:                     .Visible     = .T.
460:                 ENDWITH
461:             ENDIF
462: 
463:             *-- Carregar pendencias de devolucao de pedras
464:             IF THIS.this_oBusinessObject.CarregarDados(THIS.this_nNenvs)
465:                 loc_oGrd = THIS.grd_4c_Dados
466: 
467:                 *-- RecordSource antes de ControlSource (reseta headers - Licao #2 FORMCOR)
468:                 loc_oGrd.ColumnCount  = 4
469:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
470: 
471:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.EmpDnPs"
472:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.Cmats"
473:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.TpOps"
474:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.Qtds"
475: 
476:                 *-- Reconfigurar headers obrigatoriamente apos RecordSource
477:                 loc_oGrd.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
478:                 loc_oGrd.Column2.Header1.Caption = "Componente"
479:                 loc_oGrd.Column3.Header1.Caption = "Tipo de Material"
480:                 loc_oGrd.Column4.Header1.Caption = "Quantidade"
481: 
482:                 THIS.txt_4c_TotalQtds.Value = THIS.this_oBusinessObject.this_nTotalQtds
483: 
484:                 loc_oGrd.Refresh()
485:                 loc_lSucesso = .T.
486:             ENDIF
487: 
488:         CATCH TO loc_oErro
489:             MsgErro(loc_oErro.Message, "Erro CarregarDados")

*-- Linhas 566 a 584:
566:     *
567:     * SIGPDM13 e um form de CONSULTA/CHECAGEM de devolucao de pedras.
568:     * Nao ha operacao de inclusao: o grid exibe pendencias calculadas pelo
569:     * legado via SELECT em SigCdNei+SigCdOpd+SigOpOpt (queries somente-leitura).
570:     * Nenhum botao Incluir existe na UI deste form.
571:     *--------------------------------------------------------------------------
572:     PROCEDURE BtnIncluirClick()
573:         *-- Form OPERACIONAL de checagem: operacao de inclusao nao aplicavel
574:         RETURN
575:     ENDPROC
576: 
577:     *--------------------------------------------------------------------------
578:     * BtnAlterarClick - No-op: form OPERACIONAL read-only (checagem)
579:     *
580:     * Todos os controles do grid (Column1-4) tem ReadOnly=.T. e When=.F.,
581:     * replicando o comportamento do SCX legado onde nenhuma coluna era
582:     * editavel pelo usuario. Nenhum botao Alterar existe na UI deste form.
583:     *--------------------------------------------------------------------------
584:     PROCEDURE BtnAlterarClick()


### BO (C:\4c\projeto\app\classes\SigPdM13BO.prg):
*==============================================================================
* SigPdM13BO.prg - Business Object para Checagem de Devolucao de Pedras
* Origem: SIGPDM13.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigPdM13BO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela      = "SigCdNei"
    this_cCampoChave  = "Nenvs"

    *-- Parametro de entrada: numero do envelope
    this_nNenvs       = 0

    *-- Informacoes do envelope (container Operacao)
    this_nNumps       = 0         && Numero do envelope
    this_cEmps        = ""        && Empresa
    this_cDopps       = ""        && Codigo da operacao

    *-- Campos da linha corrente do cursor (SigCdNei)
    this_cEmpDnPs     = ""        && Empresa/deposito da movimentacao
    this_cCmats       = ""        && Componente/material
    this_nQtds        = 0         && Quantidade
    this_cTpOps       = ""        && Tipo de operacao

    *-- Totalizador: SUM(Qtds) apos carregar cursor
    this_nTotalQtds   = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdNei")
        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "Nenvs"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNenvs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades da linha corrente de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                THIS.this_cCmats   = TratarNulo(Cmats,   "C")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega informacoes do envelope para o container
    * par_nNenvs: numero do envelope
    * Cria cursor_4c_Operacao com numps, emps, dopps para ControlSource
    *--------------------------------------------------------------------------
    FUNCTION CarregarOperacao(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            *-- Valores default: envelope passado, campos vazios
            THIS.this_nNumps = par_nNenvs
            THIS.this_cEmps  = ""
            THIS.this_cDopps = ""

            loc_cSQL = "SELECT TOP 1 numps, emps, dopps " + ;
                       "FROM SigCdNei " + ;
                       "WHERE Nenvs = " + TRANSFORM(par_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacaoTemp")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_OperacaoTemp") > 0
                SELECT cursor_4c_OperacaoTemp
                GO TOP
                THIS.this_nNumps = TratarNulo(numps, "N")
                THIS.this_cEmps  = TratarNulo(emps,  "C")
                THIS.this_cDopps = TratarNulo(dopps, "C")
            ENDIF

            IF USED("cursor_4c_OperacaoTemp")
                USE IN cursor_4c_OperacaoTemp
            ENDIF

            *-- Recriar cursor de bind para container Operacao
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Operacao (numps N(10,0) NULL, emps C(3) NULL, dopps C(20) NULL)
            SET NULL OFF

            SELECT cursor_4c_Operacao
            APPEND BLANK
            REPLACE numps WITH THIS.this_nNumps
            REPLACE emps  WITH THIS.this_cEmps
            REPLACE dopps WITH THIS.this_cDopps
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDados - Executa UNION ALL do legado e popula cursor_4c_Dados
    * Replica exata da query de SIGPDM13.Init:
    *   - Para devolucao: SepPedras=1, ChkDests<>4, tipo com chkDevs='S'
    *   - Ja devolvidos: ChkDests=4, Qtds negativo
    * par_nNenvs: numero do envelope
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            THIS.this_nNenvs     = par_nNenvs
            THIS.this_nTotalQtds = 0

            *-- Protecao uncommitted changes no cursor do grid
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.EmpDnPs, a.Cmats, a.Qtds, a.TpOps " + ;
                       "FROM SigCdNei a, SigCdOpd b, SigOpOpt c " + ;
                       "WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.SepPedras = 1" + ;
                       " AND b.ChkDests <> 4" + ;
                       " AND a.TpOps = c.Cods AND c.chkDevs = 'S'" + ;
                       " UNION ALL" + ;
                       " SELECT a.EmpDnPs, a.Cmats, (a.Qtds * -1) AS Qtds, a.TpOps" + ;
                       " FROM SigCdNei a, SigCdOpd b" + ;
                       " WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.ChkDests = 4" + ;
                       " ORDER BY a.Cmats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado < 1
                MsgErro("Falha ao carregar dados de devolu" + CHR(231) + CHR(227) + "o de pedras.", "Erro")
            ELSE
                *-- Calcular total (replica: Sum Qtds to _Total do legado)
                SELECT cursor_4c_DadosTemp
                SUM Qtds TO THIS.this_nTotalQtds
                GO TOP

                *-- Criar cursor definitivo com estrutura identica ao temporario
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (EmpDnPs C(33) NULL, Cmats C(14) NULL, Qtds N(9,3) NULL, TpOps C(15) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                GO TOP

                USE IN cursor_4c_DadosTemp

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei com os campos disponiveis na linha corrente
    * Form SIGPDM13 eh OPERACIONAL/consulta - este metodo existe para paridade
    * com BusinessBase e eventuais chamadas de processo de checagem.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNei " + ;
                       "(Nenvs, numps, emps, dopps, EmpDnPs, Cmats, Qtds, TpOps) " + ;
                       "VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nNenvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)   + ", " + ;
                       EscaparSQL(THIS.this_cEmps)           + ", " + ;
                       EscaparSQL(THIS.this_cDopps)          + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)        + ", " + ;
                       EscaparSQL(THIS.this_cCmats)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)    + ", " + ;
                       EscaparSQL(THIS.this_cTpOps)          + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao inserir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei dos campos da linha corrente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Qtds   = " + FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       "TpOps  = " + EscaparSQL(THIS.this_cTpOps)        + ", " + ;
                       "numps  = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       "emps   = " + EscaparSQL(THIS.this_cEmps)         + ", " + ;
                       "dopps  = " + EscaparSQL(THIS.this_cDopps)        + " " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNei filtrado pela chave corrente
    * PROTECTED conforme padrao BusinessBase (chamado via Excluir() publico)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNei " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao excluir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigCdNei") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nNenvs)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE

