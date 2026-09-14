# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-ASPAS] Linha 310: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE a.EmpDopNums = '" + par_cPrDopes + "'"
- [SQL-ASPAS] Linha 328: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE ALE.Dopes = '" + loc_cDopes + "' AND " + ;
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS SQL (1133 linhas total):

*-- Linhas 296 a 344:
296:             USE IN cursor_4c_MvCab
297:         ENDIF
298:         IF USED("cursor_4c_Ale")
299:             USE IN cursor_4c_Ale
300:         ENDIF
301:         IF USED("cursor_4c_Pam")
302:             USE IN cursor_4c_Pam
303:         ENDIF
304:         IF USED("cursor_4c_OpeBaixa")
305:             USE IN cursor_4c_OpeBaixa
306:         ENDIF
307:         IF USED("cursor_4c_ClJob")
308:             USE IN cursor_4c_ClJob
309:         ENDIF
310:         IF USED("cursor_4c_CliEmail")
311:             USE IN cursor_4c_CliEmail
312:         ENDIF
313:         IF USED("cursor_4c_ConfigEmail")
314:             USE IN cursor_4c_ConfigEmail
315:         ENDIF
316:         IF USED("cursor_4c_Dados2")
317:             USE IN cursor_4c_Dados2
318:         ENDIF
319: 
320:         *-- Liberar variavel publica do array de baixas
321:         IF TYPE("ga_4c_SigPrEmlOpeBaixa") != "U"
322:             RELEASE ga_4c_SigPrEmlOpeBaixa
323:         ENDIF
324: 
325:         *-- BO gerencia conexao ALERTA em seu proprio Destroy
326:         THIS.this_oBusinessObject = .NULL.
327: 
328:         DODEFAULT()
329:     ENDPROC
330: 
331:     *--------------------------------------------------------------------------
332:     * ConfigurarPaginaLista - Alias canonico para o pipeline multi-fase
333:     * Cria grade de destinatarios e botoes operacionais
334:     *--------------------------------------------------------------------------
335:     PROTECTED PROCEDURE ConfigurarPaginaLista()
336:         THIS.ConfigurarGrade()
337:         THIS.ConfigurarBotoesOpe()
338:     ENDPROC
339: 
340:     *--------------------------------------------------------------------------
341:     * ConfigurarPaginaDados - Completa elementos visuais do form OPERACIONAL
342:     *
343:     * Para forms OPERACIONAIS (sem Page2 de dados CRUD), este metodo:
344:     *   1. Cria Shape1 decorativo do SCX original (raia visual ao redor do area

*-- Linhas 434 a 544:
434:             .HighlightForeColor = RGB(15, 41, 104)
435:             .HighlightStyle     = 2
436:             .RecordMark         = .F.
437:             .DeleteMark         = .F.
438:             .RowHeight          = 20
439:             .ScrollBars         = 2
440:             .ColumnCount        = 5
441:             .AllowAutoColumnFit = 2
442: 
443:             *-- Column1: Conta (SCX Column2 - " Conta")
444:             WITH .Column1
445:                 .FontName         = "Verdana"
446:                 .FontSize         = 8
447:                 .Width            = 90
448:                 .ReadOnly         = .T.
449:                 .ControlSource    = "cursor_4c_Dados.Contas"
450:                 .Header1.Caption  = " Conta"
451:                 .Header1.BackColor = RGB(192, 192, 192)
452:                 .Header1.FontName = "Verdana"
453:                 .Header1.FontSize = 8
454:                 .Header1.Alignment = 2
455:             ENDWITH
456: 
457:             *-- Column2: Nome/Rclis (SCX Column3 - " Nome")
458:             WITH .Column2
459:                 .FontName         = "Verdana"
460:                 .FontSize         = 8
461:                 .Width            = 200
462:                 .ReadOnly         = .T.
463:                 .ControlSource    = "cursor_4c_Dados.Rclis"
464:                 .Header1.Caption  = " Nome"
465:                 .Header1.BackColor = RGB(192, 192, 192)
466:                 .Header1.FontName = "Verdana"
467:                 .Header1.FontSize = 8
468:                 .Header1.Alignment = 2
469:             ENDWITH
470: 
471:             *-- Column3: Email (SCX Column4 - "Email")
472:             WITH .Column3
473:                 .FontName         = "Verdana"
474:                 .FontSize         = 8
475:                 .Width            = 230
476:                 .ReadOnly         = .F.
477:                 .ControlSource    = "cursor_4c_Dados.emails"
478:                 .Header1.Caption  = "Email"
479:                 .Header1.BackColor = RGB(192, 192, 192)
480:                 .Header1.FontName = "Verdana"
481:                 .Header1.FontSize = 8
482:                 .Header1.Alignment = 2
483:             ENDWITH
484: 
485:             *-- Column4: Mensagem (SCX Column5 - fweditbox1 - campo memo)
486:             *-- REGRA: AddObject ANTES de CurrentControl; ControlSource na Column, NAO no EditBox1
487:             WITH .Column4
488:                 .FontName         = "Verdana"
489:                 .FontSize         = 8
490:                 .Width            = 390
491:                 .ReadOnly         = .T.
492:                 .Header1.Caption  = "Mensagem"
493:                 .Header1.BackColor = RGB(192, 192, 192)
494:                 .Header1.FontName = "Verdana"
495:                 .Header1.FontSize = 8
496:                 .Header1.Alignment = 2
497:                 .AddObject("EditBox1", "EditBox")
498:                 WITH .EditBox1
499:                     .FontName      = "Verdana"
500:                     .FontSize      = 8
501:                     .BorderStyle   = 0
502:                     .ReadOnly      = .T.
503:                     .SpecialEffect = 1
504:                     .BackColor     = RGB(255, 255, 255)
505:                     .ForeColor     = RGB(0, 0, 0)
506:                 ENDWITH
507:                 .CurrentControl  = "EditBox1"
508:                 .ControlSource   = "cursor_4c_Dados.mensagems"
509:                 .Sparse          = .F.
510:             ENDWITH
511: 
512:             *-- Column5: Checks - checkbox de selecao (SCX Column6 - header vazio)
513:             *-- REGRA: AddObject ANTES de CurrentControl; ControlSource na Column, NAO no Check1
514:             WITH .Column5
515:                 .Width            = 40
516:                 .Alignment        = 2
517:                 .Header1.Caption  = ""
518:                 .Header1.BackColor = RGB(192, 192, 192)
519:                 .Header1.FontName = "Verdana"
520:                 .Header1.FontSize = 8
521:                 .AddObject("Check1", "CheckBox")
522:                 WITH .Check1
523:                     .Caption   = ""
524:                     .BackStyle = 0
525:                     .ForeColor = RGB(90, 90, 90)
526:                     .Value     = 0
527:                 ENDWITH
528:                 .CurrentControl  = "Check1"
529:                 .ControlSource   = "cursor_4c_Dados.Checks"
530:                 .Sparse          = .F.
531:             ENDWITH
532:         ENDWITH
533: 
534:         *-- BINDEVENT para ordenacao por click nos headers de coluna
535:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "GrdColContaClick")
536:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdColNomeClick")
537:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdColEmailClick")
538:     ENDPROC
539: 
540:     *--------------------------------------------------------------------------
541:     * ConfigurarBotoesOpe - Cria botoes operacionais: SelTudo, Apaga, BtnEmail
542:     * Ref SCX: SelTudo Top=90 Left=4 W=40 H=40
543:     *          apaga   Top=90 Left=43 W=40 H=40
544:     *          btnEmail Top=3 Left=848 W=75 H=75

*-- Linhas 632 a 694:
632:                     .RecordSource = "cursor_4c_Dados"
633: 
634:                     *-- Reconfigurar apos RecordSource (VFP reseta headers)
635:                     .Column1.ControlSource    = "cursor_4c_Dados.Contas"
636:                     .Column1.Header1.Caption  = " Conta"
637:                     .Column2.ControlSource    = "cursor_4c_Dados.Rclis"
638:                     .Column2.Header1.Caption  = " Nome"
639:                     .Column3.ControlSource    = "cursor_4c_Dados.emails"
640:                     .Column3.Header1.Caption  = "Email"
641:                     .Column4.CurrentControl   = "EditBox1"
642:                     .Column4.ControlSource    = "cursor_4c_Dados.mensagems"
643:                     .Column4.Header1.Caption  = "Mensagem"
644:                     .AddObject("Check1", "CheckBox")
645:                     .Check1.Caption = ""
646:                     .Column5.CurrentControl   = "Check1"
647:                     .Column5.ControlSource    = "cursor_4c_Dados.Checks"
648:                     .Column5.Header1.Caption  = ""
649:                 ENDWITH
650:                 THIS.grd_4c_Dados.Refresh()
651:                 THIS.GrdColNomeClick()
652:             ENDIF
653:         CATCH TO loc_oErro
654:             MsgErro("Erro ao carregar destinat" + CHR(225) + "rios:" + CHR(13) + ;
655:                     loc_oErro.Message, "Erro")
656:         ENDTRY
657: 
658:         RETURN loc_lResultado
659:     ENDPROC
660: 
661:     *--------------------------------------------------------------------------
662:     * CmdSelTudoClick - Marca Checks=1 em todos os registros do cursor
663:     *--------------------------------------------------------------------------
664:     PROCEDURE CmdSelTudoClick()
665:         IF USED("cursor_4c_Dados")
666:             SELECT cursor_4c_Dados
667:             GO TOP
668:             REPLACE ALL Checks WITH 1
669:             GO TOP
670:             THIS.grd_4c_Dados.Refresh()
671:         ENDIF
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * CmdApagaClick - Marca Checks=0 em todos os registros do cursor
676:     *--------------------------------------------------------------------------
677:     PROCEDURE CmdApagaClick()
678:         IF USED("cursor_4c_Dados")
679:             SELECT cursor_4c_Dados
680:             GO TOP
681:             REPLACE ALL Checks WITH 0
682:             GO TOP
683:             THIS.grd_4c_Dados.Refresh()
684:         ENDIF
685:     ENDPROC
686: 
687:     *--------------------------------------------------------------------------
688:     * CmdBtnEmailClick - Envia email para destinatarios com Checks=1
689:     * Replica logica de SIGPREML.btnEmail.Click (~139 linhas no SCX original)
690:     * Fluxo: verifica selecao -> busca config SMTP -> monta mensagem completa ->
691:     *        envia via SQL Server Database Mail -> registra historico em SigAlert ->
692:     *        envia segundo email para baixas -> fecha form
693:     *--------------------------------------------------------------------------
694:     PROCEDURE CmdBtnEmailClick()

*-- Linhas 712 a 750:
712:         TRY
713:             *-- Verificar selecao
714:             IF USED("cursor_4c_Dados")
715:                 SELECT cursor_4c_Dados
716:                 COUNT FOR Checks = 1 TO loc_nSelecionados
717:             ENDIF
718:             IF loc_nSelecionados = 0
719:                 MsgAviso("Selecione ao menos um destinat" + CHR(225) + "rio antes de enviar.", ;
720:                          "Aviso")
721:             ELSE
722:                 *-- Buscar configuracao SMTP da empresa via BO
723:                 IF THIS.this_oBusinessObject.BuscarConfigEmailEmpresa()
724:                     loc_oBO = THIS.this_oBusinessObject
725: 
726:                     *-- Dados da movimentacao (cursor_4c_MvCab criado pelo BO)
727:                     loc_cJobDesc     = ""
728:                     loc_cClienteDesc = ""
729:                     loc_cDescritivo  = ""
730:                     loc_cObses       = ""
731:                     loc_cEmpMv       = SUBSTR(THIS.this_cPrDopes, 1, 3)
732:                     loc_cDopeMv      = ALLTRIM(SUBSTR(THIS.this_cPrDopes, 4, 20))
733:                     loc_cNumMv       = ALLTRIM(SUBSTR(THIS.this_cPrDopes, 24, 6))
734:                     IF USED("cursor_4c_MvCab")
735:                         SELECT cursor_4c_MvCab
736:                         GO TOP
737:                         IF !EOF()
738:                             loc_cJobDesc     = ALLTRIM(NVL(cursor_4c_MvCab.Jobs,       ""))
739:                             loc_cClienteDesc = ALLTRIM(NVL(cursor_4c_MvCab.Rclis,      ""))
740:                             loc_cDescritivo  = ALLTRIM(NVL(cursor_4c_MvCab.ObsCabMovs, ""))
741:                             loc_cObses       = ALLTRIM(NVL(cursor_4c_MvCab.Obses,      ""))
742:                         ENDIF
743:                     ENDIF
744: 
745:                     *-- Construir descricao da acao
746:                     DO CASE
747:                         CASE ALLTRIM(THIS.this_cEscolha) = "INSERIR"
748:                             loc_cEscolhaDesc = "Inclus" + CHR(227) + "o"
749:                         CASE ALLTRIM(THIS.this_cEscolha) = "ALTERAR"
750:                             loc_cEscolhaDesc = "Altera" + CHR(231) + CHR(227) + "o"

*-- Linhas 758 a 779:
758:                     IF USED("cursor_4c_Dados2")
759:                         USE IN cursor_4c_Dados2
760:                     ENDIF
761:                     SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Dados2
762: 
763:                     *-- SCAN 1: montar lista de destinatarios + capturar dados do primeiro
764:                     SELECT cursor_4c_Dados2
765:                     GO TOP
766:                     SCAN
767:                         IF RECNO() = 1
768:                             loc_cReceptor       = ALLTRIM(NVL(cursor_4c_Dados2.emails,    ""))
769:                             loc_cTxtPrioridade  = ALLTRIM(NVL(cursor_4c_Dados2.prioridade, "NORMAL"))
770:                             loc_cMensagemAlerta = ALLTRIM(NVL(cursor_4c_Dados2.mensagems, ""))
771:                         ELSE
772:                             IF !EMPTY(ALLTRIM(NVL(cursor_4c_Dados2.emails, "")))
773:                                 loc_cReceptorCopia = loc_cReceptorCopia + ;
774:                                     IIF(!EMPTY(loc_cReceptorCopia), "; ", "") + ;
775:                                     ALLTRIM(cursor_4c_Dados2.emails)
776:                             ENDIF
777:                         ENDIF
778:                     ENDSCAN
779: 

*-- Linhas 809 a 870:
809:                     *-- Enviar email principal via SQL Server Database Mail
810:                     IF !EMPTY(loc_cReceptor)
811:                         loc_cSQL = "EXEC msdb.dbo.sp_send_dbmail " + ;
812:                             "@profile_name = " + EscaparSQL("SIGE") + ", " + ;
813:                             "@recipients = " + EscaparSQL(loc_cReceptor) + ", " + ;
814:                             "@copy_recipients = " + EscaparSQL(loc_cReceptorCopia) + ", " + ;
815:                             "@body = " + EscaparSQL(loc_cTxtMensagem) + ", " + ;
816:                             "@subject = " + EscaparSQL(loc_cAssunto) + ", " + ;
817:                             "@from_address = " + EscaparSQL(loc_oBO.this_cAleEmails)
818:                         IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
819:                             loc_lResultado = .T.
820:                         ELSE
821:                             MsgErro("Falha ao enviar email via SQL Server Database Mail. " + ;
822:                                     "Verifique a configura" + CHR(231) + CHR(227) + ;
823:                                     "o de email do servidor.", "Erro")
824:                         ENDIF
825:                     ELSE
826:                         MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado possui email cadastrado.", ;
827:                                  "Aviso")
828:                     ENDIF
829: 
830:                     IF loc_lResultado
831:                         *-- SCAN 2: registrar historico para cada destinatario selecionado
832:                         SELECT cursor_4c_Dados2
833:                         GO TOP
834:                         SCAN
835:                             loc_cPkNovo = fUniqueIds()
836:                             loc_oBO.InserirAlertaHistoricoItem(loc_cPkNovo, ;
837:                                 loc_cTxtMensagem, ;
838:                                 ALLTRIM(NVL(cursor_4c_Dados2.Contas, "")), ;
839:                                 ALLTRIM(NVL(cursor_4c_Dados2.Rclis,  "")), ;
840:                                 ALLTRIM(NVL(cursor_4c_Dados2.emails, "")), ;
841:                                 ALLTRIM(NVL(cursor_4c_Dados2.mensagems, "")), ;
842:                                 THIS.this_cPrDopes, ;
843:                                 THIS.this_cEscolha, ;
844:                                 ALLTRIM(NVL(cursor_4c_Dados2.prioridade, "NORMAL")))
845:                         ENDSCAN
846: 
847:                         *-- Processar e enviar segundo email para operacoes baixadas
848:                         IF USED("cursor_4c_OpeBaixa") AND RECCOUNT("cursor_4c_OpeBaixa") > 0
849:                             loc_cReceptor2    = ""
850:                             loc_cCopia2       = ""
851:                             loc_cTxtMensagem2 = ""
852:                             loc_cPrio2        = "NORMAL"
853:                             loc_lPrimeiro     = .T.
854: 
855:                             SELECT cursor_4c_OpeBaixa
856:                             GO TOP
857:                             SCAN
858:                                 IF loc_lPrimeiro
859:                                     loc_cReceptor2 = ALLTRIM(NVL(cursor_4c_OpeBaixa.emails, ""))
860:                                     loc_cPrio2     = ALLTRIM(NVL(cursor_4c_OpeBaixa.Prioridade, "NORMAL"))
861:                                     loc_cEDN2      = ALLTRIM(NVL(cursor_4c_OpeBaixa.EmpDopNums, ""))
862:                                     loc_cEmp2      = SUBSTR(loc_cEDN2, 1, 3)
863:                                     loc_cDope2     = ALLTRIM(SUBSTR(loc_cEDN2, 4, 20))
864:                                     loc_cNum2      = ALLTRIM(SUBSTR(loc_cEDN2, 24, 6))
865: 
866:                                     *-- Corpo do segundo email com info da movimentacao baixada
867:                                     loc_cTxtMensagem2 = ""
868:                                     IF !EMPTY(loc_cJobDesc)
869:                                         loc_cTxtMensagem2 = loc_cTxtMensagem2 + ;
870:                                             "JOB          : " + loc_cJobDesc + " - " + ;

*-- Linhas 919 a 943:
919:                             IF !EMPTY(loc_cReceptor2)
920:                                 loc_cAssunto2 = "ALERTA - " + IIF(!EMPTY(loc_cPrio2), loc_cPrio2, "NORMAL")
921:                                 loc_cSQL = "EXEC msdb.dbo.sp_send_dbmail " + ;
922:                                     "@profile_name = " + EscaparSQL("SIGE") + ", " + ;
923:                                     "@recipients = " + EscaparSQL(loc_cReceptor2) + ", " + ;
924:                                     "@copy_recipients = " + EscaparSQL(loc_cCopia2) + ", " + ;
925:                                     "@body = " + EscaparSQL(loc_cTxtMensagem2) + ", " + ;
926:                                     "@subject = " + EscaparSQL(loc_cAssunto2) + ", " + ;
927:                                     "@from_address = " + EscaparSQL(loc_oBO.this_cAleEmails)
928:                                 SQLEXEC(gnConnHandle, loc_cSQL)
929:                             ENDIF
930:                         ENDIF
931: 
932:                         *-- Fechar cursor temporario antes de liberar form
933:                         IF USED("cursor_4c_Dados2")
934:                             USE IN cursor_4c_Dados2
935:                         ENDIF
936: 
937:                         MsgInfo("Email enviado com sucesso para " + ;
938:                                 TRANSFORM(loc_nSelecionados) + " destinat" + CHR(225) + ;
939:                                 "rio(s).", "Email Enviado")
940:                         THIS.Release()
941:                     ENDIF
942: 
943:                     IF USED("cursor_4c_Dados2")

*-- Linhas 962 a 1010:
962:     *--------------------------------------------------------------------------
963:     PROCEDURE GrdColContaClick()
964:         IF USED("cursor_4c_Dados")
965:             SELECT cursor_4c_Dados
966:             SET ORDER TO TAG Contas
967:         ENDIF
968:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(64, 128, 128)
969:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
970:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
971:         THIS.grd_4c_Dados.Refresh()
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * GrdColNomeClick - Ordena grid por Nome/Rclis; destaca header ativo
976:     * Ref SCX: SIGPREML.grade_alerta.Column3.Header1.Click
977:     *--------------------------------------------------------------------------
978:     PROCEDURE GrdColNomeClick()
979:         IF USED("cursor_4c_Dados")
980:             SELECT cursor_4c_Dados
981:             SET ORDER TO TAG Rclis
982:         ENDIF
983:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
984:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
985:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
986:         THIS.grd_4c_Dados.Refresh()
987:     ENDPROC
988: 
989:     *--------------------------------------------------------------------------
990:     * GrdColEmailClick - Ordena grid por Email; destaca header ativo
991:     * Ref SCX: SIGPREML.grade_alerta.Column4.Header1.Click
992:     *--------------------------------------------------------------------------
993:     PROCEDURE GrdColEmailClick()
994:         IF USED("cursor_4c_Dados")
995:             SELECT cursor_4c_Dados
996:             SET ORDER TO TAG Emails
997:         ENDIF
998:         THIS.grd_4c_Dados.Column1.Header1.BackColor = RGB(192, 192, 192)
999:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
1000:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
1001:         THIS.grd_4c_Dados.Refresh()
1002:     ENDPROC
1003: 
1004:     *--------------------------------------------------------------------------
1005:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1006:     * SCX SIGPREML nao possui botao Incluir; destinatarios sao carregados
1007:     * automaticamente por CarregarDados via BO.CarregarAlertasEmail.
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE BtnIncluirClick()
1010:         RETURN .F.

*-- Linhas 1111 a 1129:
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE LimparCampos()
1113:         IF USED("cursor_4c_Dados")
1114:             SELECT cursor_4c_Dados
1115:             GO TOP
1116:             REPLACE ALL Checks WITH 0
1117:             GO TOP
1118:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1119:                 THIS.grd_4c_Dados.Refresh()
1120:             ENDIF
1121:         ENDIF
1122:     ENDPROC
1123: 
1124:     *--------------------------------------------------------------------------
1125:     * AjustarBotoesPorModo - Form OPERACIONAL sem botoes CRUD com modo variavel
1126:     * Metodo presente para compatibilidade com o pipeline de migracao
1127:     *--------------------------------------------------------------------------
1128:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1129:         *-- OPERACIONAL: sem botoes CRUD com aparencia por modo


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*==============================================================================
* SIGPREMLBO.PRG
* Business Object para Alerta de Email (SIGPREML)
* Entidade: SigAlert
* Tipo: OPERACIONAL
*==============================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela         = "SigAlert"
    this_cCampoChave     = "PkChaves"

    *-- Chave primaria
    this_cPkChaves       = ""

    *-- Campos principais de SigAlert
    this_cContas         = ""    && Conta do cliente C(10)
    this_cGrupos         = ""    && Grupo C(10)
    this_cEmps           = ""    && Empresa C(3)
    this_cDopes          = ""    && Operacao C(20)
    this_nNumes          = 0     && Numero N(6,0)
    this_cAcaos          = ""    && Acao C(10)
    this_cUsuars         = ""    && Usuario
    this_dDtAlerts       = {}    && Data/hora do alerta
    this_cMsg1s          = ""    && Mensagem 1 (texto)
    this_cMensagems      = ""    && Mensagem (memo)
    this_cEmails         = ""    && Email C(50)
    this_cPrioridade     = ""    && Prioridade C(15): URGENTE/IMPORTANTE/NORMAL
    this_cEmpDopNums     = ""    && Composto empresa+dope+numero C(29)
    this_nPriors         = 0     && Prioridade numerica N(1): 1=URGENTE,2=IMPORTANTE,3=NORMAL
    this_cRclis          = ""    && Nome do cliente C(30)

    *-- Parametros de contexto recebidos pelo form
    this_cPrDopes        = ""    && Parametro completo (empresa+dope+numero) C(29)
    this_cEmp            = ""    && Codigo da empresa (3 primeiros chars de PrDopes)
    this_cDope           = ""    && Codigo da operacao (chars 4-23 de PrDopes)
    this_cEscolha        = ""    && Escolha de acao: INSERIR/ALTERAR/EXCLUIR

    *-- Dados de email da empresa (lidos de SigCdEmp)
    this_cAleServs       = ""    && Servidor SMTP
    this_cAleEmails      = ""    && Email remetente
    this_cAleSenhas      = ""    && Senha do email
    this_nAlePortas      = 0     && Porta SMTP

    *-- Conexao secundaria para banco ALERTA (SigAlert)
    this_nConnAlerta     = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT("SigAlert")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF THIS.this_nConnAlerta > 0
            SQLDISCONNECT(THIS.this_nConnAlerta)
            THIS.this_nConnAlerta = 0
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarConexaoAlerta - Abre conexao com banco ALERTA
    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexaoAlerta()
        LOCAL loc_lResultado, loc_cConnStr, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cConnStr = "DRIVER={SQL Server};" + ;
                           "SERVER=192.168.15.101;" + ;
                           "DATABASE=ALERTA;" + ;
                           "UID=sa;PWD=s@4control;"
            THIS.this_nConnAlerta = SQLSTRINGCONNECT(loc_cConnStr)
            IF THIS.this_nConnAlerta > 0
                SQLSETPROP(THIS.this_nConnAlerta, "DispWarnings", .F.)
                SQLSETPROP(THIS.this_nConnAlerta, "Asynchronous", .F.)
                loc_lResultado = .T.
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel conectar ao banco ALERTA.", ;
                        "Erro de Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SigAlert
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves    = TratarNulo(PkChaves,    "C")
                THIS.this_cContas      = TratarNulo(Contas,      "C")
                THIS.this_cGrupos      = TratarNulo(Grupos,      "C")
                THIS.this_cEmps        = TratarNulo(Emps,        "C")
                THIS.this_cDopes       = TratarNulo(Dopes,       "C")
                THIS.this_nNumes       = TratarNulo(Numes,       "N")
                THIS.this_cAcaos       = TratarNulo(Acaos,       "C")
                THIS.this_cUsuars      = TratarNulo(Usuars,      "C")
                THIS.this_cMsg1s       = TratarNulo(Msg1s,       "C")
                THIS.this_cMensagems   = TratarNulo(Mensagems,   "C")
                THIS.this_cEmails      = TratarNulo(Emails,      "C")
                THIS.this_cEmpDopNums  = TratarNulo(EmpDopNums,  "C")
                THIS.this_cRclis       = TratarNulo(Rclis,       "C")
                THIS.this_nPriors      = TratarNulo(Priors,      "N")
                IF THIS.this_nPriors = 1
                    THIS.this_cPrioridade = "URGENTE"
                ELSE
                    IF THIS.this_nPriors = 2
                        THIS.this_cPrioridade = "IMPORTANTE"
                    ELSE
                        THIS.this_cPrioridade = "NORMAL"
                    ENDIF
                ENDIF
                IF TYPE(par_cAliasCursor + ".DtAlerts") != "U"
                    THIS.this_dDtAlerts = TratarNulo(DtAlerts, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cContas)
            MsgAviso("Conta n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmails)
            MsgAviso("Email n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigAlert (banco ALERTA)
    * Requer this_nConnAlerta ja inicializado via InicializarConexaoAlerta()
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cPkChaves = fUniqueIds()
                THIS.this_dDtAlerts = DATETIME()
                THIS.this_cEmps     = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
                THIS.this_cDopes    = ALLTRIM(SUBSTR(THIS.this_cEmpDopNums, 4, 20))
                THIS.this_nNumes    = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
                THIS.this_cUsuars   = gc_4c_UsuarioLogado

                loc_cSQL = "INSERT INTO SigAlert " + ;
                    "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
                    "Emails, Mensagems, Msg1s, Priors, Acaos, " + ;
                    "Usuars, DtAlerts, EmpDopNums) VALUES (" + ;
                    EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                    EscaparSQL(THIS.this_cEmps) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                    EscaparSQL(THIS.this_cContas) + ", " + ;
                    EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    EscaparSQL(THIS.this_cRclis) + ", " + ;
                    EscaparSQL(THIS.this_cEmails) + ", " + ;
                    EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(THIS.this_cEmpDopNums) + ")"

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao registrar alerta de email no banco ALERTA.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                THIS.this_cUsuars = gc_4c_UsuarioLogado

                loc_cSQL = "UPDATE SigAlert SET " + ;
                    "Contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
                    "Grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
                    "Rclis = " + EscaparSQL(THIS.this_cRclis) + ", " + ;
                    "Emails = " + EscaparSQL(THIS.this_cEmails) + ", " + ;
                    "Mensagems = " + EscaparSQL(THIS.this_cMensagems) + ", " + ;
                    "Msg1s = " + EscaparSQL(THIS.this_cMsg1s) + ", " + ;
                    "Priors = " + FormatarNumeroSQL(THIS.this_nPriors) + ", " + ;
                    "Acaos = " + EscaparSQL(THIS.this_cAcaos) + ", " + ;
                    "Usuars = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums) + " " + ;
                    "WHERE PkChaves = " + EscaparSQL(THIS.this_cPkChaves)

                IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                    THIS.RegistrarAuditoria("ALTERAR")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar alerta de email.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigAlert (banco ALERTA)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigAlert WHERE PkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir alerta de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasEmail - Carrega lista de destinatarios para o cursor do form
    * Popula cursor_4c_Dados (estrutura identica a crLocalTotal do legado)
    * par_cPrDopes: empresa(3)+dope(20)+numero(6) concatenados
    * par_cEscolha: INSERIR | ALTERAR | EXCLUIR
    * par_laOpeBaixa: array de EmpDopNums de operacoes baixadas (ou .F. se nenhum)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAlertasEmail(par_cPrDopes, par_cEscolha, par_laOpeBaixa)
        LOCAL loc_lResultado, loc_cSQL, loc_cDopes, loc_oErro
        LOCAL loc_cDope, loc_cEDN, loc_nX, loc_cConta, loc_cRclis
        loc_lResultado = .F.
        loc_cDope      = ""
        loc_cEDN       = ""
        TRY
            THIS.this_cPrDopes = par_cPrDopes
            THIS.this_cEscolha = par_cEscolha
            THIS.this_cEmp     = SUBSTR(par_cPrDopes, 1, 3)
            loc_cDopes         = ALLTRIM(SUBSTR(par_cPrDopes, 4, 20))

            SET NULL ON
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            CREATE CURSOR cursor_4c_Dados (Checks N(1) NULL, grupos C(10) NULL, ;
                Contas C(10) NULL, Rclis C(30) NULL, emails C(50) NULL, ;
                mensagems M NULL, prioridade C(15) NULL, ;
                EmpDopNums C(29) NULL, Acaos C(10) NULL)
            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON emails TAG Emails
            SET NULL OFF

            *-- Buscar dados da movimentacao (cabecalho + cliente)
            IF USED("cursor_4c_MvCab")
                USE IN cursor_4c_MvCab
            ENDIF
            loc_cSQL = "SELECT a.EmpDopNums, a.Jobs, b.Rclis, a.ObsCabMovs, a.Obses " + ;
                       "FROM SigMvcab a INNER JOIN SigCdCli b ON a.Jobs = b.Iclis " + ;
                       "WHERE a.EmpDopNums = '" + par_cPrDopes + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") >= 1
                SELECT cursor_4c_MvCab
                GO TOP

                *-- Buscar alertas configurados em SigCdAle
                IF USED("cursor_4c_Ale")
                    USE IN cursor_4c_Ale
                ENDIF
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "'" + par_cPrDopes + "' AS EmpDopNums " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes = '" + loc_cDopes + "' AND " + ;
                           IIF(par_cEscolha = "INSERIR", "ALE.inserirs = 1 ", ;
                           IIF(par_cEscolha = "ALTERAR", "ALE.alterars = 1 ", ;
                           IIF(par_cEscolha = "EXCLUIR", "ALE.excluirs = 1 ", "1 = 1 ")))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ale") >= 1
                    *-- Filtrar por job e inserir em cursor_4c_Dados
                    SELECT cursor_4c_Ale
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Ale.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Ale
                                LOOP
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Dados
                        INSERT INTO cursor_4c_Dados ;
                            (Checks, grupos, Contas, Rclis, emails, ;
                             mensagems, prioridade, EmpDopNums, Acaos) ;
                            VALUES (cursor_4c_Ale.Checks, cursor_4c_Ale.grupos, ;
                                    cursor_4c_Ale.Contas, cursor_4c_Ale.Rclis, ;
                                    cursor_4c_Ale.emails, NVL(cursor_4c_Ale.mensagems, ""), ;
                                    cursor_4c_Ale.prioridade, par_cPrDopes, par_cEscolha)
                        SELECT cursor_4c_Ale
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar alertas configurados.", "Erro")
                ENDIF

                *-- Buscar destinatarios de SigCdPam (grupos de alerta parametrizados)
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_cSQL = "SELECT 0 AS Checks, CLI.grupos, CLI.iclis AS Contas, " + ;
                           "CLI.rclis, CLI.emails, '' AS prioridade " + ;
                           "FROM SigCdPam PAM " + ;
                           "INNER JOIN SigCdCli CLI ON CLI.grupos = PAM.grpadats"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") >= 1
                    SELECT cursor_4c_Pam
                    GO TOP
                    SCAN
                        IF USED("cursor_4c_ClJob")
                            USE IN cursor_4c_ClJob
                        ENDIF
                        loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = '" + ;
                                   ALLTRIM(cursor_4c_Pam.Contas) + "'"
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClJob")
                        SELECT cursor_4c_ClJob
                        GO TOP
                        IF !EOF()
                            LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_MvCab.Jobs)
                            IF EOF()
                                SELECT cursor_4c_Pam
                                LOOP
                            ENDIF
                        ENDIF

                        loc_cConta = cursor_4c_Pam.Contas
                        loc_cRclis = cursor_4c_Pam.Rclis
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(cursor_4c_Dados.Contas) = ALLTRIM(loc_cConta) ;
                               AND ALLTRIM(cursor_4c_Dados.Rclis)  = ALLTRIM(loc_cRclis)
                        IF EOF()
                            INSERT INTO cursor_4c_Dados ;
                                (Checks, grupos, Contas, Rclis, emails, ;
                                 EmpDopNums, Acaos, prioridade) ;
                                VALUES (cursor_4c_Pam.Checks, "", loc_cConta, ;
                                        loc_cRclis, cursor_4c_Pam.emails, ;
                                        par_cPrDopes, par_cEscolha, "NORMAL")
                        ENDIF
                        SELECT cursor_4c_Pam
                    ENDSCAN
                ELSE
                    MsgErro("Falha ao buscar destinat" + CHR(225) + "rios de grupo.", "Erro")
                ENDIF

                *-- Processar operacoes de baixa (laOpeBaixa), se array valido
                IF TYPE("par_laOpeBaixa", 1) = "A"
                    FOR loc_nX = 1 TO ALEN(par_laOpeBaixa)
                        IF !EMPTY(par_laOpeBaixa(loc_nX))
                            IF EMPTY(loc_cDope)
                                loc_cDope = "('" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = "('" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ELSE
                                loc_cDope = loc_cDope + ",'" + ALLTRIM(SUBSTR(par_laOpeBaixa(loc_nX), 4, 20)) + "'"
                                loc_cEDN  = loc_cEDN  + ",'" + ALLTRIM(par_laOpeBaixa(loc_nX)) + "'"
                            ENDIF
                        ENDIF
                    NEXT
                    IF !EMPTY(loc_cDope)
                        loc_cDope = loc_cDope + ") "
                        loc_cEDN  = loc_cEDN  + ") "
                        THIS.CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, loc_cDope, loc_cEDN)
                    ENDIF
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Falha ao buscar dados da movimenta" + CHR(231) + CHR(227) + "o.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertasBaixa - Processa alertas de operacoes baixadas
    * Popula cursor_4c_OpeBaixa (usado pelo form no envio do segundo email)
    * par_cDope: lista IN de codigos de operacao ex: "('FRET','DESPA') "
    * par_cEDN:  lista IN de EmpDopNums    ex: "('001FRET  000001') "
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarAlertasBaixa(par_cPrDopes, par_cEscolha, par_cDope, par_cEDN)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_OpeBaixa")
                USE IN cursor_4c_OpeBaixa
            ENDIF

            *-- Tentar buscar na ALERTA primeiro (alertas ja enviados para baixa)
            loc_cSQL = "SELECT TOP 1 Contas, Acaos, EmpDopNums, Emps, Dopes, Numes, " + ;
                       "SPACE(50) AS emails, SPACE(15) AS Prioridade, " + ;
                       "Msg1s AS Mensagems, 1 AS Checks " + ;
                       "FROM SigAlert WHERE EmpDopNums IN " + par_cEDN + ;
                       " AND Acaos = 'BAIXAR'"
            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL, "cursor_4c_OpeBaixa") < 1
                *-- Fallback: buscar na SIGE via SigCdAle (baixas configuradas)
                loc_cSQL = "SELECT 1 AS Checks, ALE.grupos, ALE.Contas, " + ;
                           "CLI.Rclis, CLI.emails, ALE.mensagems, " + ;
                           "CASE WHEN ALE.priors = 1 THEN 'URGENTE' " + ;
                           "WHEN ALE.priors = 2 THEN 'IMPORTANTE' " + ;
                           "ELSE 'NORMAL' END AS prioridade, " + ;
                           "ALE.datas, ALE.dtalts, ALE.pkchaves, ALE.priors, ALE.dopes, " + ;
                           "SPACE(29) AS EmpDopNums, '" + par_cEscolha + "' AS Acaos " + ;
                           "FROM SigCdAle ALE " + ;
                           "INNER JOIN SigCdCli CLI ON ALE.Contas = CLI.Iclis " + ;
                           "WHERE ALE.Dopes IN " + par_cDope + " AND ALE.baixas = 1"
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeBaixa")
            ENDIF

            IF USED("cursor_4c_OpeBaixa")
                *-- Buscar emails e prioridade para cada conta
                SELECT cursor_4c_OpeBaixa
                GO TOP
                SCAN
                    IF USED("cursor_4c_CliEmail")
                        USE IN cursor_4c_CliEmail
                    ENDIF
                    loc_cSQL = "SELECT a.Emails, " + ;
                               "CASE WHEN b.priors = 1 THEN 'URGENTE' " + ;
                               "WHEN b.priors = 2 THEN 'IMPORTANTE' " + ;
                               "ELSE 'NORMAL' END AS prioridade, b.mensagems " + ;
                               "FROM SigCdCli a INNER JOIN SigCdAle b ON a.Iclis = b.Contas " + ;
                               "WHERE a.Iclis = '" + ALLTRIM(cursor_4c_OpeBaixa.Contas) + ;
                               "' AND b.Dopes = '" + ALLTRIM(cursor_4c_OpeBaixa.Dopes) + "'"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliEmail")
                    IF USED("cursor_4c_CliEmail") AND !EOF("cursor_4c_CliEmail")
                        SELECT cursor_4c_OpeBaixa
                        REPLACE emails     WITH cursor_4c_CliEmail.Emails
                        REPLACE prioridade WITH cursor_4c_CliEmail.prioridade
                        REPLACE mensagems  WITH cursor_4c_CliEmail.mensagems
                    ENDIF
                    SELECT cursor_4c_OpeBaixa
                ENDSCAN
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmailEmpresa - Busca config SMTP de SigCdEmp
    * Popula this_cAleServs, this_cAleEmails, this_cAleSenhas, this_nAlePortas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmailEmpresa()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ConfigEmail")
                USE IN cursor_4c_ConfigEmail
            ENDIF
            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE CEmps = '" + ALLTRIM(THIS.this_cEmp) + "'"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigEmail") >= 1
                SELECT cursor_4c_ConfigEmail
                IF !EOF()
                    THIS.this_cAleServs  = ALLTRIM(TratarNulo(AleServs,  "C"))
                    THIS.this_cAleEmails = ALLTRIM(TratarNulo(AleEmails, "C"))
                    THIS.this_cAleSenhas = ALLTRIM(TratarNulo(AleSenhas, "C"))
                    THIS.this_nAlePortas = TratarNulo(AlePortas, "N")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o de email n" + CHR(227) + ;
                            "o encontrada para empresa '" + ALLTRIM(THIS.this_cEmp) + "'.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao buscar configura" + CHR(231) + CHR(227) + "o de email.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirAlertaHistoricoItem - Insere UM registro em SigAlert (banco ALERTA)
    * Chamado pelo form para cada destinatario selecionado no grid
    * par_cMsg1s:     texto completo da mensagem montada pelo form
    * par_cEmpDopNums: empresa(3)+dope(20)+numero(6) concatenados
    * par_cAcaos:     INSERIR | ALTERAR | EXCLUIR | BAIXAR
    * par_cPrioridade: URGENTE | IMPORTANTE | NORMAL
    *--------------------------------------------------------------------------
    PROCEDURE InserirAlertaHistoricoItem(par_cPkChaves, par_cMsg1s, par_cContas, ;
                                         par_cRclis, par_cEmails, par_cMensagems, ;
                                         par_cEmpDopNums, par_cAcaos, par_cPrioridade)
        LOCAL loc_lResultado, loc_cSQL, loc_nPriors, loc_oErro
        loc_lResultado = .F.
        TRY
            DO CASE
                CASE ALLTRIM(par_cPrioridade) = "URGENTE"
                    loc_nPriors = 1
                CASE ALLTRIM(par_cPrioridade) = "IMPORTANTE"
                    loc_nPriors = 2
                OTHERWISE
                    loc_nPriors = 3
            ENDCASE

            loc_cSQL = "INSERT INTO SigAlert " + ;
                "(PkChaves, Emps, Dopes, Numes, Contas, Grupos, Rclis, " + ;
                "Emails, Mensagems, Msg1s, Priors, Acaos, Usuars, DtAlerts, EmpDopNums) " + ;
                "VALUES (" + ;
                EscaparSQL(par_cPkChaves) + ", " + ;
                EscaparSQL(SUBSTR(par_cEmpDopNums, 1, 3)) + ", " + ;
                EscaparSQL(ALLTRIM(SUBSTR(par_cEmpDopNums, 4, 20))) + ", " + ;
                FormatarNumeroSQL(VAL(SUBSTR(par_cEmpDopNums, 24, 6))) + ", " + ;
                EscaparSQL(par_cContas) + ", " + ;
                EscaparSQL("") + ", " + ;
                EscaparSQL(par_cRclis) + ", " + ;
                EscaparSQL(par_cEmails) + ", " + ;
                EscaparSQL(par_cMensagems) + ", " + ;
                EscaparSQL(par_cMsg1s) + ", " + ;
                FormatarNumeroSQL(loc_nPriors) + ", " + ;
                EscaparSQL(par_cAcaos) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(par_cEmpDopNums) + ")"

            IF SQLEXEC(THIS.this_nConnAlerta, loc_cSQL) >= 1
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao registrar alerta no hist" + CHR(243) + "rico.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

