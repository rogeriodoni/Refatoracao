# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, LCSQL, EMPDNCRDS, DATATRANS, EMPDOPNUMS, PROGS, ICLIS, JOBS, CHECKS, CEMPS

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
			.cOption("DisableUpdateCheck")   = 1
Select TmpRelat
	lcSql = [Select Emps, Dopes, Numes, ValDevs From SigMvCab Where EmpDnCrds = ']+TprMvCab.EmpDopNums+[']
	If Thisform.poDataMgr.SqlExecute(lcSql,'CrEest') > 0
LParameters tcFrom As String, tcTo As String, tcCC As String, tcAssunto As String, tcCorpo As String, tcAnexo As String, ;
	.Update()
	.From 	  = Lower( tcFrom )
	lcQuery = [Select 1 as Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Rclis, b.emails, b.grupos, b.iclis  ] + ;
			[From SigMvcab a ] + ;
			[Inner Join SigCdCli b On a.Contads = b.Iclis ] + ;
			[And empdopnums not in(select Transacaos from sigoplog where progs = 'SIGPREMA') ] + ;
	lcQuery = [Select 1 as Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Rclis, b.emails, b.grupos, b.iclis  ] + ;
			[From SigMvcab a ] + ;
			[Inner Join SigCdCli b On a.Contads = b.Iclis ] + ;
If thisform.podatamgr.SqlExecute(lcQuery,[TmpMvCab]) < 1
Select TmpMvCab
	Insert Into crLocalTotal (Checks,grupos,Contas,Rclis,emails,prioridade,EmpDopNums) ;
lcQuery	= [select 0 as Checks, c.grupos, c.iclis as Contas, c.rclis, c.emails, '' as prioridade ] + ;
	[from SigCdPam p ] + ;
	[inner  join SigCdCli c on c.grupos = p.grpadats]
If (Thisform.poDatamgr.SqlExecute(lcQuery, [crLocalPAM]) < 1)
Select crLocalPAM
	lcQuery = [Select Jobs From SigClJob Where Iclis = '] + crLocalPAM.Contas + [']
	If (Thisform.poDatamgr.SqlExecute(lcQuery, [TmpClJob]) < 1)
	Select TmpClJob
	Select crLocalTotal
		Insert Into crLocalTotal (Checks,grupos,Contas,Rclis,emails,EmpDopNums,prioridade) ;
	Select crLocalPAM
Select crLocalTotal
Thisform.grade.column6.ControlSource = [crLocalTotal.Checks]
Thisform.grade.column2.ControlSource = [crLocalTotal.Contas]
Thisform.grade.column3.ControlSource = [crLocalTotal.Rclis]
Thisform.grade.column4.ControlSource = [crLocalTotal.Emails]
Thisform.grade.column5.ControlSource = [crLocalTotal.EmpDopNums]
Select crLocalTotal
Select crLocalTotal
Select crLocalTotal
Select * From crLocaltotal Where Checks = 1 Into Cursor crLocalTotal2 ReadWrite
Select crLocaltotal2
	Select crLocaltotal2
		Delete File Addbs(Sys(2023)) + [FORTYUSPDF.PDF]
	lcQuery = [Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = '] + _Empr + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmpMail') < 1)
	lcFrom   = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails,[])))	
		If !EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom, lcReceptorCopia, lcServer, lcSenha, lnPorta)
Select crLocalTotal
Select crLocalTotal

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS SQL (1240 linhas total):

*-- Linhas 64 a 82:
64:                     USE IN cursor_4c_Dados
65:                 ENDIF
66:                 SET NULL ON
67:                 CREATE CURSOR cursor_4c_Dados (;
68:                     Checks     N(1)    NULL,;
69:                     grupos     C(10)   NULL,;
70:                     Contas     C(10)   NULL,;
71:                     Rclis      C(30)   NULL,;
72:                     emails     C(50)   NULL,;
73:                     mensagems  M,;
74:                     EmpDopNums C(29)   NULL,;
75:                     prioridade C(15)   NULL;
76:                 )
77:                 SET NULL OFF
78:                 INDEX ON Contas  TAG Contas
79:                 INDEX ON Rclis   TAG Rclis
80:                 INDEX ON emails  TAG Emails
81: 
82:                 *-- Cria estrutura visual (form OPERACIONAL usa layout flat, sem PageFrame real)

*-- Linhas 190 a 208:
190:             .FontName         = "Verdana"
191:             .FontSize         = 8
192:             .RecordMark       = .F.
193:             .DeleteMark       = .F.
194:             .RowHeight        = 18
195:             .GridLines        = 1
196:             .GridLineColor    = RGB(238, 238, 238)
197:             .HighlightBackColor = RGB(255, 255, 255)
198:             .HighlightForeColor = RGB(15, 41, 104)
199:             .HighlightStyle   = 2
200:             .ScrollBars       = 2
201:             .RecordSource     = "cursor_4c_Dados"
202:             .Visible          = .T.
203: 
204:             *-- Coluna 1: CheckBox (selecao)
205:             WITH .Column1
206:                 .Width         = 17
207:                 .ColumnOrder   = 1
208:                 .ReadOnly      = .F.

*-- Linhas 216 a 247:
216:                     .Visible   = .T.
217:                 ENDWITH
218:                 .CurrentControl  = "Check1"
219:                 .ControlSource   = "cursor_4c_Dados.Checks"
220:                 .Header1.Caption = ""
221:                 .Header1.FontName = "Tahoma"
222:                 .Header1.FontSize = 8
223:             ENDWITH
224: 
225:             *-- Coluna 2: Conta
226:             WITH .Column2
227:                 .Width         = 80
228:                 .ColumnOrder   = 2
229:                 .ReadOnly      = .T.
230:                 .FontName      = "Verdana"
231:                 .FontSize      = 8
232:                 .ControlSource = "cursor_4c_Dados.Contas"
233:                 .AddObject("Text1", "TextBox")
234:                 WITH .Text1
235:                     .FontName    = "Verdana"
236:                     .FontSize    = 8
237:                     .BorderStyle = 0
238:                     .Margin      = 0
239:                     .ReadOnly    = .T.
240:                     .ForeColor   = RGB(0, 0, 0)
241:                     .BackColor   = RGB(255, 255, 255)
242:                     .Visible     = .T.
243:                 ENDWITH
244:                 .CurrentControl  = "Text1"
245:                 .Header1.Caption  = "Conta"
246:                 .Header1.FontName = "Tahoma"
247:                 .Header1.FontSize = 8

*-- Linhas 255 a 273:
255:                 .ReadOnly      = .T.
256:                 .FontName      = "Verdana"
257:                 .FontSize      = 8
258:                 .ControlSource = "cursor_4c_Dados.Rclis"
259:                 .AddObject("Text1", "TextBox")
260:                 WITH .Text1
261:                     .FontName    = "Verdana"
262:                     .FontSize    = 8
263:                     .BorderStyle = 0
264:                     .Margin      = 0
265:                     .ReadOnly    = .T.
266:                     .ForeColor   = RGB(0, 0, 0)
267:                     .BackColor   = RGB(255, 255, 255)
268:                     .Visible     = .T.
269:                 ENDWITH
270:                 .CurrentControl  = "Text1"
271:                 .Header1.Caption  = "Nome"
272:                 .Header1.FontName = "Tahoma"
273:                 .Header1.FontSize = 8

*-- Linhas 281 a 299:
281:                 .ReadOnly      = .F.
282:                 .FontName      = "Verdana"
283:                 .FontSize      = 8
284:                 .ControlSource = "cursor_4c_Dados.emails"
285:                 .AddObject("Text1", "TextBox")
286:                 WITH .Text1
287:                     .FontName    = "Verdana"
288:                     .FontSize    = 8
289:                     .BorderStyle = 0
290:                     .Margin      = 0
291:                     .ReadOnly    = .F.
292:                     .ForeColor   = RGB(0, 0, 0)
293:                     .BackColor   = RGB(255, 255, 255)
294:                     .Visible     = .T.
295:                 ENDWITH
296:                 .CurrentControl  = "Text1"
297:                 .Header1.Caption  = "Email"
298:                 .Header1.FontName = "Tahoma"
299:                 .Header1.FontSize = 8

*-- Linhas 308 a 349:
308:                 .Sparse        = .F.
309:                 .FontName      = "Verdana"
310:                 .FontSize      = 8
311:                 .ControlSource = "cursor_4c_Dados.EmpDopNums"
312:                 .AddObject("Edit1", "EditBox")
313:                 WITH .Edit1
314:                     .FontName      = "Verdana"
315:                     .FontSize      = 8
316:                     .BorderStyle   = 0
317:                     .ReadOnly      = .T.
318:                     .SpecialEffect = 1
319:                     .Visible       = .T.
320:                 ENDWITH
321:                 .CurrentControl  = "Edit1"
322:                 .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
323:                 .Header1.FontName = "Tahoma"
324:                 .Header1.FontSize = 8
325:                 .Header1.Alignment = 2
326:             ENDWITH
327:         ENDWITH
328: 
329:         *-- Re-definir ControlSource apos RecordSource (evita auto-bind por posicao de campo)
330:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Checks"
331:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Contas"
332:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Rclis"
333:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emails"
334:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
335: 
336:         *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
337:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
338:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
339:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
340: 
341:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
342:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
343: 
344:         *-- Botao SelTudo (Marcar Todos)
345:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
346:         WITH THIS.cmd_4c_SelTudo
347:             .Top          = 84
348:             .Left         = 4
349:             .Height       = 40

*-- Linhas 412 a 492:
412:     * GrdHeader2Click - Ordena grid pela coluna Conta
413:     *--------------------------------------------------------------------------
414:     PROCEDURE GrdHeader2Click()
415:         SELECT cursor_4c_Dados
416:         SET ORDER TO TAG Contas
417:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
418:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
419:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
420:         THIS.grd_4c_Dados.Refresh()
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * GrdHeader3Click - Ordena grid pela coluna Nome
425:     *--------------------------------------------------------------------------
426:     PROCEDURE GrdHeader3Click()
427:         SELECT cursor_4c_Dados
428:         SET ORDER TO TAG Rclis
429:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
430:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
431:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
432:         THIS.grd_4c_Dados.Refresh()
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * GrdHeader4Click - Ordena grid pela coluna Email
437:     *--------------------------------------------------------------------------
438:     PROCEDURE GrdHeader4Click()
439:         SELECT cursor_4c_Dados
440:         SET ORDER TO TAG Emails
441:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
442:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
443:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
444:         THIS.grd_4c_Dados.Refresh()
445:     ENDPROC
446: 
447:     *--------------------------------------------------------------------------
448:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
449:     *--------------------------------------------------------------------------
450:     PROCEDURE ChkSelChange()
451:         LOCAL loc_oChk
452:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
453:         IF USED("cursor_4c_Dados")
454:             SELECT cursor_4c_Dados
455:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
456:         ENDIF
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * CmdSelTudoClick - Marca todos os registros
461:     *--------------------------------------------------------------------------
462:     PROCEDURE CmdSelTudoClick()
463:         IF USED("cursor_4c_Dados")
464:             SELECT cursor_4c_Dados
465:             GO TOP
466:             REPLACE ALL Checks WITH 1
467:             GO TOP
468:         ENDIF
469:         THIS.grd_4c_Dados.Refresh()
470:     ENDPROC
471: 
472:     *--------------------------------------------------------------------------
473:     * CmdApagaClick - Desmarca todos os registros
474:     *--------------------------------------------------------------------------
475:     PROCEDURE CmdApagaClick()
476:         IF USED("cursor_4c_Dados")
477:             SELECT cursor_4c_Dados
478:             GO TOP
479:             REPLACE ALL Checks WITH 0
480:             GO TOP
481:         ENDIF
482:         THIS.grd_4c_Dados.Refresh()
483:     ENDPROC
484: 
485:     *--------------------------------------------------------------------------
486:     * ConfigurarCabecalho - Cria container de cabecalho superior
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarCabecalho()
489:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
490:         WITH THIS.cnt_4c_Cabecalho
491:             .Top         = 0
492:             .Left        = 0

*-- Linhas 641 a 667:
641: 
642:             IF loc_lResultado AND USED("cursor_4c_Local")
643:                 *-- Migra dados para cursor do grid (ZAP+APPEND preserva estrutura de colunas)
644:                 SELECT cursor_4c_Dados
645:                 ZAP
646:                 APPEND FROM DBF("cursor_4c_Local")
647:                 IF USED("cursor_4c_Local")
648:                     USE IN cursor_4c_Local
649:                 ENDIF
650: 
651:                 *-- Ordena por Nome (comportamento padrao do original)
652:                 SELECT cursor_4c_Dados
653:                 SET ORDER TO TAG Rclis
654: 
655:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
656:                     THIS.grd_4c_Dados.Refresh()
657:                 ENDIF
658:             ENDIF
659: 
660:             *-- Modo automatico: envia email imediatamente sem interacao
661:             IF THIS.this_lAutomatico
662:                 THIS.CmdBtnEmailClick()
663:             ENDIF
664: 
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
667:                     "Erro ao carregar dados para email")

*-- Linhas 680 a 799:
680:         LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto
681:         LOCAL loc_cTxtMensagem, loc_cArqAnexo
682:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEdn
683:         LOCAL loc_cFrom, loc_cServer, loc_cSenha, loc_nPorta
684:         LOCAL loc_cSQL
685: 
686:         loc_lOk              = .T.
687:         loc_cReceptor        = ""
688:         loc_cReceptorCopia   = ""
689:         loc_cAssunto         = ""
690:         loc_cTxtMensagem     = ""
691:         loc_cArqAnexo        = ""
692: 
693:         *-- Seleciona apenas registros marcados
694:         IF USED("cursor_4c_Local2")
695:             USE IN cursor_4c_Local2
696:         ENDIF
697:         SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Local2 READWRITE
698: 
699:         IF !USED("cursor_4c_Local2") OR RECCOUNT("cursor_4c_Local2") < 1
700:             MsgAviso("Nenhum registro marcado para envio de email.", "Aviso")
701:             RETURN
702:         ENDIF
703: 
704:         SELECT cursor_4c_Local2
705:         GO TOP
706:         SCAN
707:             IF EMPTY(cursor_4c_Local2.emails)
708:                 LOOP
709:             ENDIF
710: 
711:             SELECT cursor_4c_Local2
712:             loc_cEmps   = SUBSTR(cursor_4c_Local2.EmpDopNums, 1, 3)
713:             loc_cDopes  = ALLTRIM(SUBSTR(cursor_4c_Local2.EmpDopNums, 4, 20))
714:             loc_nNumes  = VAL(SUBSTR(cursor_4c_Local2.EmpDopNums, 24, 6))
715:             loc_cEdn    = ALLTRIM(cursor_4c_Local2.EmpDopNums)
716: 
717:             IF RECNO("cursor_4c_Local2") = 1
718:                 loc_cReceptor      = ALLTRIM(cursor_4c_Local2.emails)
719:                 loc_cTxtMensagem   = ""
720:                 loc_cAssunto       = ""
721:             ELSE
722:                 IF !EMPTY(ALLTRIM(cursor_4c_Local2.emails))
723:                     loc_cReceptorCopia = loc_cReceptorCopia + ;
724:                         IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
725:                         ALLTRIM(cursor_4c_Local2.emails)
726:                 ENDIF
727:             ENDIF
728: 
729:             *-- Remove PDF anterior se existir
730:             IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
731:                 DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
732:             ENDIF
733: 
734:             *-- Gera impressao/PDF do documento
735:             loc_lOk = THIS.ImprimirDocumento(loc_cEdn)
736: 
737:             IF loc_lOk
738:                 loc_cArqAnexo = THIS.this_cArqEmail
739:             ENDIF
740: 
741:             *-- Busca dados de email da empresa
742:             loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
743:                        "FROM SigCdEmp WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
744:             IF USED("cursor_4c_EmpMail")
745:                 USE IN cursor_4c_EmpMail
746:             ENDIF
747:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpMail") < 1
748:                 MsgErro("Falha ao buscar dados de email da empresa.", "Erro")
749:                 loc_lOk = .F.
750:             ELSE
751:                 SELECT cursor_4c_EmpMail
752:                 GO TOP
753:                 IF !EOF("cursor_4c_EmpMail")
754:                     loc_cFrom   = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadEmails, "")))
755:                     loc_cServer = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadServs, "")))
756:                     loc_cSenha  = ALLTRIM(NVL(cursor_4c_EmpMail.PadSenhas, ""))
757:                     loc_nPorta  = NVL(cursor_4c_EmpMail.PadPortas, 0)
758:                 ELSE
759:                     MsgErro("Empresa n" + CHR(227) + "o encontrada no cadastro.", "Erro")
760:                     loc_lOk = .F.
761:                 ENDIF
762:             ENDIF
763: 
764:             IF loc_lOk
765:                 WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR
766:                 loc_lOk = THIS.EnviarEmail(;
767:                     loc_cFrom, ;
768:                     loc_cReceptor, ;
769:                     loc_cReceptorCopia, ;
770:                     loc_cAssunto, ;
771:                     loc_cTxtMensagem, ;
772:                     loc_cArqAnexo, ;
773:                     loc_cServer, ;
774:                     loc_nPorta, ;
775:                     loc_cFrom, ;
776:                     loc_cSenha;
777:                 )
778:             ENDIF
779: 
780:             IF loc_lOk
781:                 THIS.GravarLog(loc_cEdn)
782:             ENDIF
783: 
784:             SELECT cursor_4c_Local2
785:         ENDSCAN
786: 
787:         WAIT CLEAR
788: 
789:         IF USED("cursor_4c_EmpMail")
790:             USE IN cursor_4c_EmpMail
791:         ENDIF
792:         IF USED("cursor_4c_Local2")
793:             USE IN cursor_4c_Local2
794:         ENDIF
795: 
796:         IF loc_lOk
797:             WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
798:             THIS.Release()
799:         ENDIF

*-- Linhas 815 a 893:
815: 
816:         TRY
817:             *-- Busca cabecalho do movimento
818:             loc_cSQL = "SELECT Emps, Dopes, Numes, ValDevs, EmpDnCrds, Contads " + ;
819:                        "FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(par_cEdn))
820:             IF USED("cursor_4c_MvCab")
821:                 TABLEREVERT(.T., "cursor_4c_MvCab")
822:                 USE IN cursor_4c_MvCab
823:             ENDIF
824:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") < 1
825:                 MsgErro("Erro ao buscar movimento " + ALLTRIM(par_cEdn), "Erro")
826:                 loc_lContinuar = .F.
827:             ENDIF
828: 
829:             IF loc_lContinuar
830:                 SELECT cursor_4c_MvCab
831:                 GO TOP
832:                 IF EOF("cursor_4c_MvCab")
833:                     loc_lContinuar = .F.
834:                 ENDIF
835:             ENDIF
836: 
837:             *-- Busca operacao
838:             IF loc_lContinuar
839:                 loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
840:                 loc_cSQL   = "SELECT Dopes, Docus, nOpCrs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
841:                 IF USED("cursor_4c_Ope")
842:                     USE IN cursor_4c_Ope
843:                 ENDIF
844:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope") < 1
845:                     MsgErro("Erro ao buscar opera" + CHR(231) + CHR(227) + "o " + loc_cDopes, "Erro")
846:                     loc_lContinuar = .F.
847:                 ELSE
848:                     SELECT cursor_4c_Ope
849:                     GO TOP
850:                 ENDIF
851:             ENDIF
852: 
853:             IF loc_lContinuar
854:                 *-- Busca configuracao da operacao (datacenter - inclui GerOpes)
855:                 loc_cSQL = "SELECT Dopes, QtdDocs, GerOpes FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopes)
856:                 IF USED("cursor_4c_OpCdc")
857:                     USE IN cursor_4c_OpCdc
858:                 ENDIF
859:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
860:                 SELECT cursor_4c_OpCdc
861:                 GO TOP
862: 
863:                 *-- Busca configuracao de Job e inventario (SigOpCdi - lbltxidCs e chkInvs)
864:                 loc_cSQL = "SELECT Dopes, lbltxidCs, chkInvs FROM SigOpCdi WHERE Dopes = " + EscaparSQL(loc_cDopes)
865:                 IF USED("cursor_4c_OpCdi")
866:                     USE IN cursor_4c_OpCdi
867:                 ENDIF
868:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi")
869:                 SELECT cursor_4c_OpCdi
870:                 GO TOP
871: 
872:                 *-- Busca configuracao adicional (SigOpCdd - ConfigGers para impressao de Job)
873:                 loc_cSQL = "SELECT Dopes, ConfigGers FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes)
874:                 IF USED("cursor_4c_OpCdd")
875:                     USE IN cursor_4c_OpCdd
876:                 ENDIF
877:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdd")
878:                 SELECT cursor_4c_OpCdd
879:                 GO TOP
880: 
881:                 *-- Define caminho do PDF gerado
882:                 THIS.this_cArqEmail  = ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
883:                 THIS.this_cPcEscolha = ""
884: 
885:                 *-- Impressao de boleto/NF (docus 0,1,5)
886:                 IF !EOF("cursor_4c_Ope") AND INLIST(cursor_4c_Ope.Docus, 0, 1, 5)
887:                     loc_cEmps  = ALLTRIM(cursor_4c_MvCab.Emps)
888:                     loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
889:                     DO FORM SigPrIdc WITH ;
890:                         loc_cEmps, loc_cDopes, cursor_4c_MvCab.Numes, ;
891:                         cursor_4c_MvCab.ValDevs, cursor_4c_OpCdc.QtdDocs, ;
892:                         .F., .T., .F., .F., .F., .F., THIS, .T.
893:                     loc_lSucesso = FILE(THIS.this_cArqEmail)

*-- Linhas 916 a 960:
916:                 *-- Estorno: operacao gerou documento vinculado (nOpCrs nao vazio)
917:                 IF !EOF("cursor_4c_Ope") AND !EMPTY(cursor_4c_Ope.nOpCrs)
918:                     LOCAL loc_cSQLEst, loc_cEmpEst, loc_cDopEst, loc_nNumEst
919:                     loc_cSQLEst = "SELECT Emps, Dopes, Numes, ValDevs " + ;
920:                                   "FROM SigMvCab WHERE EmpDnCrds = " + EscaparSQL(ALLTRIM(par_cEdn))
921:                     IF USED("cursor_4c_MvCabEst")
922:                         USE IN cursor_4c_MvCabEst
923:                     ENDIF
924:                     IF SQLEXEC(gnConnHandle, loc_cSQLEst, "cursor_4c_MvCabEst") > 0
925:                         SELECT cursor_4c_MvCabEst
926:                         GO TOP
927:                         IF !EOF("cursor_4c_MvCabEst")
928:                             loc_cEmpEst = ALLTRIM(cursor_4c_MvCabEst.Emps)
929:                             loc_cDopEst = ALLTRIM(cursor_4c_MvCabEst.Dopes)
930:                             loc_nNumEst = cursor_4c_MvCabEst.Numes
931:                             IF USED("cursor_4c_OpeEst")
932:                                 USE IN cursor_4c_OpeEst
933:                             ENDIF
934:                             loc_cSQL = "SELECT Dopes, Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopEst)
935:                             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeEst") > 0
936:                                 SELECT cursor_4c_OpeEst
937:                                 GO TOP
938:                                 IF !EOF("cursor_4c_OpeEst")
939:                                     IF INLIST(cursor_4c_OpeEst.Docus, 1, 5)
940:                                         IF USED("cursor_4c_OpCdcEst")
941:                                             USE IN cursor_4c_OpCdcEst
942:                                         ENDIF
943:                                         loc_cSQL = "SELECT Dopes, QtdDocs FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopEst)
944:                                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdcEst") > 0
945:                                             SELECT cursor_4c_OpCdcEst
946:                                             GO TOP
947:                                             IF !EOF("cursor_4c_OpCdcEst")
948:                                                 DO FORM SigPrIdc WITH ;
949:                                                     loc_cEmpEst, loc_cDopEst, loc_nNumEst, ;
950:                                                     cursor_4c_MvCabEst.ValDevs, cursor_4c_OpCdcEst.QtdDocs, ;
951:                                                     .F., .F., .F., .F., .F., .F., THIS, .T.
952:                                             ENDIF
953:                                         ENDIF
954:                                         IF USED("cursor_4c_OpCdcEst")
955:                                             USE IN cursor_4c_OpCdcEst
956:                                         ENDIF
957:                                     ENDIF
958:                                     IF INLIST(cursor_4c_OpeEst.Docus, 3, 6, 7, 8, 9)
959:                                         DO FORM SigReIfx WITH loc_cEmpEst, loc_cDopEst, loc_nNumEst, .F., .T.
960:                                     ENDIF

*-- Linhas 999 a 1017:
999:     * EnviarEmail - Envia email via CDO.Message
1000:     * Adaptado de: SIGPREMA.memail
1001:     *--------------------------------------------------------------------------
1002:     FUNCTION EnviarEmail(par_cFrom, par_cTo, par_cCC, par_cAssunto, par_cCorpo, ;
1003:                          par_cAnexo, par_cSmtpServer, par_nSmtpPort, ;
1004:                          par_cSendUser, par_cSendPass)
1005:         LOCAL loc_oEmail, loc_lOk, loc_lEnvioOk, loc_oErro
1006:         loc_lOk      = .F.
1007:         loc_lEnvioOk = .T.
1008: 
1009:         TRY
1010:             loc_oEmail = CREATEOBJECT("CDO.Message")
1011:             IF VARTYPE(loc_oEmail) != "O"
1012:                 MsgAviso("Problemas ao instanciar CDO.Message para envio de email.", "Aviso")
1013:                 loc_lEnvioOk = .F.
1014:             ENDIF
1015: 
1016:             IF loc_lEnvioOk
1017:                 WITH loc_oEmail.Configuration.Fields

*-- Linhas 1023 a 1047:
1023:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")           = LOWER(ALLTRIM(par_cSendUser))
1024:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")           = par_cSendPass
1025:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")             = IIF(par_nSmtpPort = 465, 1, 0)
1026:                     .Update()
1027:                 ENDWITH
1028: 
1029:                 WITH loc_oEmail
1030:                     .To        = LOWER(ALLTRIM(par_cTo))
1031:                     .Cc        = LOWER(NVL(par_cCC, ""))
1032:                     .From      = LOWER(ALLTRIM(par_cFrom))
1033:                     .Subject   = ALLTRIM(par_cAssunto)
1034:                     .TextBody  = ALLTRIM(par_cCorpo)
1035: 
1036:                     IF !ISNULL(par_cAnexo) AND !EMPTY(ALLTRIM(par_cAnexo))
1037:                         IF FILE(ALLTRIM(par_cAnexo))
1038:                             .AddAttachment(ALLTRIM(par_cAnexo))
1039:                         ELSE
1040:                             loc_lEnvioOk = .F.
1041:                             MsgAviso("Arquivo anexo n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1042:                                      ALLTRIM(par_cAnexo), "Aviso")
1043:                         ENDIF
1044:                     ENDIF
1045: 
1046:                     IF loc_lEnvioOk
1047:                         LOCAL loc_oErroEnvio

*-- Linhas 1074 a 1097:
1074:         loc_lSucesso = .F.
1075: 
1076:         TRY
1077:             loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datas, Horas) " + ;
1078:                        "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
1079:                        EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
1080:                        FormatarDataSQL(DATE()) + ", " + ;
1081:                        EscaparSQL(TIME()) + ")"
1082:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1083:                 loc_lSucesso = .T.
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             *-- Falha no log nao impede o fluxo principal
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1092:     * FormBase declara este metodo; retorna .F. para indicar nao-suporte
1093:     *--------------------------------------------------------------------------
1094:     PROCEDURE BtnIncluirClick()
1095:         RETURN .F.
1096:     ENDPROC
1097: 

*-- Linhas 1215 a 1233:
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE LimparCampos()
1217:         IF USED("cursor_4c_Dados")
1218:             SELECT cursor_4c_Dados
1219:             ZAP
1220:         ENDIF
1221:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1222:             THIS.grd_4c_Dados.Refresh()
1223:         ENDIF
1224:     ENDPROC
1225: 
1226:     *--------------------------------------------------------------------------
1227:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1228:     *--------------------------------------------------------------------------
1229:     PROCEDURE CarregarLista()
1230:         RETURN THIS.CarregarDados()
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* sigpremaBO.prg - Business Object: Processamento e Geracao de Email
* Herda de: BusinessBase
* Form: Formsigprema.prg (OPERACIONAL)
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros de entrada do processo
    this_cEmpDopNums = ""    && Identificador completo do movimento (Emps+Dopes+Numes C29)
    this_cEmps       = ""    && Codigo da empresa (3 chars)
    this_cDopes      = ""    && Tipo de operacao (chars 4-23)
    this_nNumes      = 0     && Numero do movimento (chars 24-29)
    this_lAutomatico = .F.   && Modo automatico: processa e encerra sem interacao

    *-- Estado do processo de email
    this_cArqEmail   = ""    && Caminho do arquivo PDF gerado para anexo
    this_cEscolha    = ""    && Escolha de operacao retornada pelo ImpDocto

    *-- Configuracoes de email extraidas de SigCdEmp
    this_cPadEmails  = ""    && Email remetente (PadEmails)
    this_cPadServs   = ""    && Servidor SMTP (PadServs)
    this_cPadSenhas  = ""    && Senha SMTP (PadSenhas)
    this_nPadPortas  = 0     && Porta SMTP (PadPortas)

    *-- Estado da disponibilidade do PDFCreator
    this_lEmailAtivo = .F.   && .T. se PDFCreator esta registrado no sistema

    *-- Propriedades da linha do cursor (para CarregarDoCursor)
    this_cContas     = ""    && Codigo da conta/cliente (Iclis)
    this_cRclis      = ""    && Nome do cliente/conta (Rclis)
    this_cEmails     = ""    && Endereco de email
    this_cGrupos     = ""    && Grupo do cliente
    this_cMensagems  = ""    && Corpo da mensagem
    this_cPrioridade = ""    && Prioridade (NORMAL/etc)
    this_nChecks     = 0     && Flag de selecao para envio (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nChecks     = TratarNulo(Checks, "N")
            THIS.this_cGrupos     = TratarNulo(grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cRclis      = TratarNulo(Rclis, "C")
            THIS.this_cEmails     = TratarNulo(emails, "C")
            THIS.this_cMensagems  = TratarNulo(mensagems, "C")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_cEmps       = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
            THIS.this_cDopes      = SUBSTR(THIS.this_cEmpDopNums, 4, 20)
            THIS.this_nNumes      = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaEmail - Carrega cursor_4c_Local com movimentos para envio
    * par_cDopes: EmpDopNums do movimento especifico (vazio = todos do dia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarListaEmail(par_cDopes)
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Local")
                USE IN cursor_4c_Local
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Local (;
                Checks     N(1)    NULL,;
                grupos     C(10)   NULL,;
                Contas     C(10)   NULL,;
                Rclis      C(30)   NULL,;
                emails     C(50)   NULL,;
                mensagems  M,;
                EmpDopNums C(29)   NULL,;
                prioridade C(15)   NULL;
            )
            SET NULL OFF
            INDEX ON Contas     TAG Contas
            INDEX ON Rclis      TAG Rclis
            INDEX ON emails     TAG Emails

            *-- Carrega movimentos: especifico ou todos do dia sem log
            IF EMPTY(par_cDopes)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE CONVERT(date, a.datatrans) = CONVERT(date, GETDATE()) " + ;
                             "AND a.EmpDopNums NOT IN (" + ;
                             "  SELECT transacaos FROM SigOpLog WHERE progs = 'SIGPREMA'" + ;
                             ") " + ;
                             "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvTemp") < 1
                MsgErro("Falha ao carregar movimentos para email.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_MvTemp
            SCAN
                INSERT INTO cursor_4c_Local ;
                    (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                    VALUES (cursor_4c_MvTemp.Checks, cursor_4c_MvTemp.grupos, ;
                            cursor_4c_MvTemp.iclis, cursor_4c_MvTemp.Rclis, ;
                            cursor_4c_MvTemp.emails, "NORMAL", cursor_4c_MvTemp.EmpDopNums)
            ENDSCAN
            IF USED("cursor_4c_MvTemp")
                USE IN cursor_4c_MvTemp
            ENDIF

            *-- Carrega clientes do grupo PAM (SigCdPam)
            loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                         "c.rclis, c.emails, '' AS prioridade " + ;
                         "FROM SigCdPam p " + ;
                         "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_PamTemp") >= 1
                SELECT cursor_4c_PamTemp
                SCAN
                    LOCAL loc_cJobQuery, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam
                    loc_cContasPam = cursor_4c_PamTemp.Contas
                    loc_cRclisPam  = cursor_4c_PamTemp.Rclis
                    loc_cEmailsPam = cursor_4c_PamTemp.emails

                    *-- Verifica se cliente tem job associado ao movimento
                    loc_cJobQuery = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                                   EscaparSQL(loc_cContasPam)
                    IF SQLEXEC(gnConnHandle, loc_cJobQuery, "cursor_4c_JobTemp") >= 1
                        SELECT cursor_4c_JobTemp
                        GO TOP
                        IF !EOF()
                            *-- Insere apenas se nao existe ja no cursor
                            SELECT cursor_4c_Local
                            LOCATE FOR ALLTRIM(cursor_4c_Local.Contas) = ALLTRIM(loc_cContasPam) ;
                                    AND ALLTRIM(cursor_4c_Local.Rclis)  = ALLTRIM(loc_cRclisPam)
                            IF EOF()
                                INSERT INTO cursor_4c_Local ;
                                    (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                                    VALUES (0, "", loc_cContasPam, loc_cRclisPam, ;
                                            loc_cEmailsPam, par_cDopes, "NORMAL")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_JobTemp")
                            USE IN cursor_4c_JobTemp
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_PamTemp
                ENDSCAN
                IF USED("cursor_4c_PamTemp")
                    USE IN cursor_4c_PamTemp
                ENDIF
            ENDIF

            SELECT cursor_4c_Local
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar lista de email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmail - Carrega configuracoes SMTP de sigcdemp para this_*
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmail()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            loc_cQuery = "SELECT pademails, padservs, padsenhas, padportas " + ;
                         "FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_EmpEmail") >= 1
                SELECT cursor_4c_EmpEmail
                GO TOP
                IF !EOF()
                    THIS.this_cPadEmails = ALLTRIM(NVL(pademails, ""))
                    THIS.this_cPadServs  = ALLTRIM(NVL(padservs, ""))
                    THIS.this_cPadSenhas = ALLTRIM(NVL(padsenhas, ""))
                    THIS.this_nPadPortas = NVL(padportas, 0)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_EmpEmail")
                    USE IN cursor_4c_EmpEmail
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de email")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra envio de email no log de operacoes (SigOpLog)
    * Chamado apos cada email enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
                MsgAviso("Identifica" + CHR(231) + CHR(227) + "o do movimento n" + ;
                         CHR(227) + "o informada.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigOpLog " + ;
                       "(usuaredes, datars, horas, progs, opers, usuasis, " + ;
                       " parametros, transacaos, cversaos, cidchaves, copias) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                       "'SIGPREMA', 'T', " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "'', " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ", " + ;
                       "'', '', 0)"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao registrar log de envio de email.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao registrar email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do movimento atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       "'SigMvCab', " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

