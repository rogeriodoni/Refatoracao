# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, EMPDOPNUMS, DOPES, X, ACAOS, ICLIS, BAIXAS, JOBS, CHECKS, CEMPS, RCL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, EMPDOPNUMS, DOPES, X, ACAOS, ICLIS, BAIXAS, JOBS, CHECKS, CEMPS, RCL

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
	lcQuery = [Select * From SigAlert Where 0 = 1]
	lcQuery = [Select a.EmpDopNums, a.Jobs, b.Rclis, a.ObsCabMovs, a.Obses From SigMvcab a Inner Join SigCdCli b On a.Jobs = b.Iclis Where a.EmpDopNums = '] + prDopes + [']
	If thisform.podatamgr.SqlExecute(lcQuery,[TmpMvCab]) < 1
	Select TmpMvCab
	lcQuery = [Select 1 as Checks,ALE.grupos,Ale.Contas, Cli.Rclis,CLI.emails,ALE.mensagems,  ] + ;
		[from SigCdAle ALE ] + ;
		[Inner Join SigCdCli Cli On Ale.Contas = Cli.IcliS ] + ;
	If (.poDatamgr.SqlExecute(lcQuery, [crLocalALE]) < 1)
			lcQuery = [Select Top 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, Space(50) as emails, Space(15) as Prioridade, Msg1s as Mensagems, 1 as Checks ] + ;
						[From SigAlert where EmpDopNums in ] + lcEDN + [ And Acaos = 'BAIXAR']
			If (.poDatamgr2.SqlExecute(lcQuery, [crOpeBaixa]) < 1)
			Select crOpeBaixa
				lcQuery = [Select a.Emails, Case when b.priors = 1 then 'URGENTE' when b.priors = 2 then 'IMPORTANTE' else 'NORMAL' end as prioridade, b.mensagems ] + ;
					[from SigCdCli a Inner Join SigCdAle b On a.Iclis = b.Contas Where a.Iclis = ']	+ crOpeBaixa.Contas + [' And b.Dopes = '] + crOpeBaixa.Dopes + [']
				If (.poDatamgr.SqlExecute(lcQuery, [TmpCli]) < 1)
				lcQuery = [Select 1 as Checks,ALE.grupos,Ale.Contas, Cli.Rclis,CLI.emails,ALE.mensagems,  ] + ;
					[from SigCdAle ALE ] + ;
					[Inner Join SigCdCli Cli On Ale.Contas = Cli.Iclis ] + ;
				If (.poDatamgr.SqlExecute(lcQuery, [crOpeBaixa]) < 1)
						Select crOpeBaixa
Select crLocalALE
Select crLocalALE
	lcQuery = [Select Jobs From SigClJob Where Iclis = '] + crLocalAle.Contas + [']
	If (Thisform.poDatamgr.SqlExecute(lcQuery, [TmpClJob]) < 1)
	Select TmpClJob
	Insert Into crLocalTotal (Checks,grupos,Contas,Rclis,emails,mensagems,prioridade,EmpDopNums,Acaos) Values ;
lcQuery	= [select 0 as Checks,CLI.grupos,CLI.iclis as Contas,CLI.rclis,CLI.emails,'' as prioridade ] + ;
	[from SigCdPam PAM ] + ;
	[inner  join SigCdCli CLI on CLI.grupos = PAM.grpadats]
If (Thisform.poDatamgr.SqlExecute(lcQuery, [crLocalPAM]) < 1)
Select crLocalPAM
	lcQuery = [Select Jobs From SigClJob Where Iclis = '] + crLocalPAM.Contas + [']
	If (Thisform.poDatamgr.SqlExecute(lcQuery, [TmpClJob]) < 1)
	Select TmpClJob
	Select crLocalTotal
		Insert Into crLocalTotal (Checks,grupos,Contas,Rclis,emails,EmpDopNums,Acaos,prioridade) Values ;
	Select crLocalPAM
Select crLocalTotal
Thisform.grade_alerta.column6.ControlSource = [crLocalTotal.Checks]
Thisform.grade_alerta.column2.ControlSource = [crLocalTotal.Contas]
Thisform.grade_alerta.column3.ControlSource = [crLocalTotal.Rclis]
Thisform.grade_alerta.column4.ControlSource = [crLocalTotal.Emails]
Thisform.grade_alerta.column5.ControlSource = [crLocalTotal.Mensagems]
Select crLocalTotal
Select crLocalTotal
Select crLocalTotal
Select * From crLocaltotal Where Checks = 1 Into Cursor crLocalTotal2
Select crLocaltotal2
	Select crLocaltotal2
	Insert Into crSigAlert from Memvar
lcQuery = [Select AleServs, AleEmails, AleSenhas, AlePortas From SigCdEmp Where CEmps = '] + Thisform.lcEmp + [']
If (Thisform.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
lcFrom  = Alltrim(LocalEmp.Aleemails)
If !EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom, lcReceptorCopia, lcServer, lcSenha, lnPorta)
	Select crOpeBaixa
		Insert Into crSigAlert from Memvar	
	If !EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom, lcReceptorCopia, lcServer, lcSenha, lnPorta)	
	If !thisform.podatamgr2.Update([crSigAlert])
Select crLocalTotal
Select crLocalTotal

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS SQL (789 linhas total):

*-- Linhas 319 a 380:
319:             .Width                = 993
320:             .Height               = 435
321:             .RecordMark           = .F.
322:             .DeleteMark           = .F.
323:             .RowHeight            = 18
324:             .FontName             = "Verdana"
325:             .FontSize             = 8
326:             .ForeColor            = RGB(90, 90, 90)
327:             .BackColor            = RGB(255, 255, 255)
328:             .GridLineColor        = RGB(238, 238, 238)
329:             .HighlightStyle       = 2
330:             .HighlightBackColor   = RGB(255, 255, 255)
331:             .HighlightForeColor   = RGB(15, 41, 104)
332:             .AllowAutoColumnFit   = 2
333:             .GridLines            = 2
334:             .ColumnCount          = 5
335: 
336:             *-- Column1: Checkbox Checks (ColumnOrder=1 exibido a esquerda)
337:             *-- Ordem obrigatoria: AddObject -> CurrentControl -> Sparse -> ControlSource (Erro 1767)
338:             WITH .Column1
339:                 .ColumnOrder   = 1
340:                 .Width         = 17
341:                 .ReadOnly      = .F.
342:                 WITH .Header1
343:                     .Caption  = ""
344:                     .FontName = "Verdana"
345:                     .FontSize = 8
346:                 ENDWITH
347:                 .AddObject("ctlCheckbox", "CheckBox")
348:                 WITH .ctlCheckbox
349:                     .Caption   = ""
350:                     .Alignment = 0
351:                     .FontName  = "Verdana"
352:                     .FontSize  = 8
353:                     .Value     = 0
354:                 ENDWITH
355:                 .CurrentControl = "ctlCheckbox"
356:                 .Sparse        = .F.
357:                 .ControlSource = "cursor_4c_Total.Checks"
358:             ENDWITH
359: 
360:             *-- Column2: Conta (ColumnOrder=2)
361:             WITH .Column2
362:                 .ColumnOrder   = 2
363:                 .Width         = 80
364:                 .ReadOnly      = .T.
365:                 .ControlSource = "cursor_4c_Total.Contas"
366:                 WITH .Header1
367:                     .Caption   = " Conta"
368:                     .Alignment = 2
369:                     .FontName  = "Verdana"
370:                     .FontSize  = 8
371:                     .BackColor = RGB(192, 192, 192)
372:                 ENDWITH
373:                 .AddObject("ctlText", "TextBox")
374:                 WITH .ctlText
375:                     .BorderStyle = 0
376:                     .Margin      = 0
377:                     .ReadOnly    = .T.
378:                     .ForeColor   = RGB(0, 0, 0)
379:                     .BackColor   = RGB(255, 255, 255)
380:                     .FontName    = "Verdana"

*-- Linhas 388 a 406:
388:                 .ColumnOrder   = 3
389:                 .Width         = 290
390:                 .ReadOnly      = .T.
391:                 .ControlSource = "cursor_4c_Total.Rclis"
392:                 WITH .Header1
393:                     .Caption   = " Nome"
394:                     .Alignment = 2
395:                     .FontName  = "Verdana"
396:                     .FontSize  = 8
397:                     .BackColor = RGB(64, 128, 128)
398:                 ENDWITH
399:                 .AddObject("ctlText", "TextBox")
400:                 WITH .ctlText
401:                     .BorderStyle = 0
402:                     .Margin      = 0
403:                     .ReadOnly    = .T.
404:                     .ForeColor   = RGB(0, 0, 0)
405:                     .BackColor   = RGB(255, 255, 255)
406:                     .FontName    = "Verdana"

*-- Linhas 414 a 432:
414:                 .ColumnOrder   = 4
415:                 .Width         = 290
416:                 .ReadOnly      = .F.
417:                 .ControlSource = "cursor_4c_Total.emails"
418:                 WITH .Header1
419:                     .Caption   = "Email"
420:                     .Alignment = 2
421:                     .FontName  = "Verdana"
422:                     .FontSize  = 8
423:                     .BackColor = RGB(192, 192, 192)
424:                 ENDWITH
425:                 .AddObject("ctlText", "TextBox")
426:                 WITH .ctlText
427:                     .BorderStyle = 0
428:                     .Margin      = 0
429:                     .ReadOnly    = .F.
430:                     .ForeColor   = RGB(0, 0, 0)
431:                     .BackColor   = RGB(255, 255, 255)
432:                     .FontName    = "Verdana"

*-- Linhas 441 a 485:
441:                 .Width         = 290
442:                 .ReadOnly      = .T.
443:                 .Sparse        = .F.
444:                 .ControlSource = "cursor_4c_Total.mensagems"
445:                 WITH .Header1
446:                     .Caption   = "Mensagem"
447:                     .Alignment = 2
448:                     .FontName  = "Verdana"
449:                     .FontSize  = 8
450:                 ENDWITH
451:                 .AddObject("ctlEditBox", "EditBox")
452:                 WITH .ctlEditBox
453:                     .BorderStyle   = 0
454:                     .ReadOnly      = .T.
455:                     .SpecialEffect = 1
456:                     .FontName      = "Verdana"
457:                     .FontSize      = 8
458:                 ENDWITH
459:                 .CurrentControl = "ctlEditBox"
460:             ENDWITH
461: 
462:             *-- Ativar RecordSource por ultimo para evitar auto-binding prematuro
463:             .RecordSource = "cursor_4c_Total"
464: 
465:             *-- Redefinir ControlSource apos RecordSource para evitar auto-bind por ordem de campos
466:             .Column1.ControlSource = "cursor_4c_Total.Checks"
467:             .Column2.ControlSource = "cursor_4c_Total.Contas"
468:             .Column3.ControlSource = "cursor_4c_Total.Rclis"
469:             .Column4.ControlSource = "cursor_4c_Total.emails"
470:             .Column5.ControlSource = "cursor_4c_Total.mensagems"
471:         ENDWITH
472:     ENDPROC
473: 
474:     *==========================================================================
475:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
476:     *==========================================================================
477:         *-- Botoes de acao
478:         BINDEVENT(THIS.cmd_4c_BtnEmail,               "Click", THIS, "BtnEmailClick")
479:         BINDEVENT(THIS.cmd_4c_SelTudo,                "Click", THIS, "SelTudoClick")
480:         BINDEVENT(THIS.cmd_4c_Apaga,                  "Click", THIS, "ApagaClick")
481:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "EncerrarClick")
482: 
483:         *-- Cliques nos cabecalhos para ordenacao (Conta, Nome, Email)
484:         BINDEVENT(THIS.grd_4c_Dados.Column2.Header1, "Click", THIS, "Col2HeaderClick")
485:         BINDEVENT(THIS.grd_4c_Dados.Column3.Header1, "Click", THIS, "Col3HeaderClick")

*-- Linhas 631 a 649:
631:     *--------------------------------------------------------------------------
632:     PROCEDURE BtnVisualizarClick()
633:         IF USED("cursor_4c_Total")
634:             SELECT cursor_4c_Total
635:             GO TOP
636:         ENDIF
637:         THIS.grd_4c_Dados.SetFocus()
638:         THIS.grd_4c_Dados.Refresh()
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------
642:     * BtnExcluirClick - Contexto EXCLUIR do alerta: no fluxo operacional
643:     * equivale a limpar selecao (desmarcar destinatarios) via BO.
644:     *--------------------------------------------------------------------------
645:     PROCEDURE BtnExcluirClick()
646:         THIS.this_cEscolha = "EXCLUIR"
647:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
648:             THIS.this_oBusinessObject.DesmarcarTodos()
649:         ENDIF

*-- Linhas 658 a 676:
658:     *==========================================================================
659:     PROCEDURE BtnBuscarClick()
660:         IF USED("cursor_4c_Total")
661:             SELECT cursor_4c_Total
662:             GO TOP
663:         ENDIF
664:         THIS.grd_4c_Dados.Refresh()
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * BtnEncerrarClick - Alias de EncerrarClick (contrato arquitetural pipeline)
669:     *==========================================================================
670:     PROCEDURE BtnEncerrarClick()
671:         THIS.EncerrarClick()
672:     ENDPROC
673: 
674:     *==========================================================================
675:     * BtnSalvarClick - Form OPERACIONAL: "salvar" = enviar email
676:     *--------------------------------------------------------------------------

*-- Linhas 752 a 770:
752: 
753:         TRY
754:             IF USED("cursor_4c_Total")
755:                 SELECT cursor_4c_Total
756:                 GO TOP
757:                 THIS.grd_4c_Dados.Refresh()
758:                 loc_lSucesso = .T.
759:             ENDIF
760:         CATCH TO loc_oErro
761:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
762:                     "Erro FormSigPrEml.CarregarLista")
763:         ENDTRY
764: 
765:         RETURN loc_lSucesso
766:     ENDPROC
767: 
768:     *==========================================================================
769:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD a ajustar
770:     *--------------------------------------------------------------------------

