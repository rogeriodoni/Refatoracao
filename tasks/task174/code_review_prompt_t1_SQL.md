# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '_TALLY' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, LCSQL, EMPDNCRDS, DATATRANS, EMPDOPNUMS, PROGS, ICLIS, JOBS, CHECKS, CEMPS
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS SQL (1231 linhas total):

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

*-- Linhas 188 a 206:
188:             .FontName         = "Verdana"
189:             .FontSize         = 8
190:             .RecordMark       = .F.
191:             .DeleteMark       = .F.
192:             .RowHeight        = 18
193:             .GridLines        = 1
194:             .GridLineColor    = RGB(238, 238, 238)
195:             .HighlightBackColor = RGB(255, 255, 255)
196:             .HighlightForeColor = RGB(15, 41, 104)
197:             .HighlightStyle   = 2
198:             .ScrollBars       = 2
199:             .RecordSource     = "cursor_4c_Dados"
200:             .Visible          = .T.
201: 
202:             *-- Coluna 1: CheckBox (selecao)
203:             WITH .Column1
204:                 .Width         = 17
205:                 .ColumnOrder   = 1
206:                 .ReadOnly      = .F.

*-- Linhas 214 a 245:
214:                     .Visible   = .T.
215:                 ENDWITH
216:                 .CurrentControl  = "Check1"
217:                 .ControlSource   = "cursor_4c_Dados.Checks"
218:                 .Header1.Caption = ""
219:                 .Header1.FontName = "Tahoma"
220:                 .Header1.FontSize = 8
221:             ENDWITH
222: 
223:             *-- Coluna 2: Conta
224:             WITH .Column2
225:                 .Width         = 80
226:                 .ColumnOrder   = 2
227:                 .ReadOnly      = .T.
228:                 .FontName      = "Verdana"
229:                 .FontSize      = 8
230:                 .ControlSource = "cursor_4c_Dados.Contas"
231:                 .AddObject("Text1", "TextBox")
232:                 WITH .Text1
233:                     .FontName    = "Verdana"
234:                     .FontSize    = 8
235:                     .BorderStyle = 0
236:                     .Margin      = 0
237:                     .ReadOnly    = .T.
238:                     .ForeColor   = RGB(0, 0, 0)
239:                     .BackColor   = RGB(255, 255, 255)
240:                     .Visible     = .T.
241:                 ENDWITH
242:                 .CurrentControl  = "Text1"
243:                 .Header1.Caption  = " Conta"
244:                 .Header1.FontName = "Tahoma"
245:                 .Header1.FontSize = 8

*-- Linhas 253 a 271:
253:                 .ReadOnly      = .T.
254:                 .FontName      = "Verdana"
255:                 .FontSize      = 8
256:                 .ControlSource = "cursor_4c_Dados.Rclis"
257:                 .AddObject("Text1", "TextBox")
258:                 WITH .Text1
259:                     .FontName    = "Verdana"
260:                     .FontSize    = 8
261:                     .BorderStyle = 0
262:                     .Margin      = 0
263:                     .ReadOnly    = .T.
264:                     .ForeColor   = RGB(0, 0, 0)
265:                     .BackColor   = RGB(255, 255, 255)
266:                     .Visible     = .T.
267:                 ENDWITH
268:                 .CurrentControl  = "Text1"
269:                 .Header1.Caption  = " Nome"
270:                 .Header1.FontName = "Tahoma"
271:                 .Header1.FontSize = 8

*-- Linhas 279 a 297:
279:                 .ReadOnly      = .F.
280:                 .FontName      = "Verdana"
281:                 .FontSize      = 8
282:                 .ControlSource = "cursor_4c_Dados.emails"
283:                 .AddObject("Text1", "TextBox")
284:                 WITH .Text1
285:                     .FontName    = "Verdana"
286:                     .FontSize    = 8
287:                     .BorderStyle = 0
288:                     .Margin      = 0
289:                     .ReadOnly    = .F.
290:                     .ForeColor   = RGB(0, 0, 0)
291:                     .BackColor   = RGB(255, 255, 255)
292:                     .Visible     = .T.
293:                 ENDWITH
294:                 .CurrentControl  = "Text1"
295:                 .Header1.Caption  = "Email"
296:                 .Header1.FontName = "Tahoma"
297:                 .Header1.FontSize = 8

*-- Linhas 306 a 324:
306:                 .Sparse        = .F.
307:                 .FontName      = "Verdana"
308:                 .FontSize      = 8
309:                 .ControlSource = "cursor_4c_Dados.EmpDopNums"
310:                 .AddObject("Edit1", "EditBox")
311:                 WITH .Edit1
312:                     .FontName      = "Verdana"
313:                     .FontSize      = 8
314:                     .BorderStyle   = 0
315:                     .ReadOnly      = .T.
316:                     .SpecialEffect = 1
317:                     .Visible       = .T.
318:                 ENDWITH
319:                 .CurrentControl  = "Edit1"
320:                 .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
321:                 .Header1.FontName = "Tahoma"
322:                 .Header1.FontSize = 8
323:                 .Header1.Alignment = 2
324:             ENDWITH

*-- Linhas 403 a 483:
403:     * GrdHeader2Click - Ordena grid pela coluna Conta
404:     *--------------------------------------------------------------------------
405:     PROCEDURE GrdHeader2Click()
406:         SELECT cursor_4c_Dados
407:         SET ORDER TO TAG Contas
408:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
409:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
410:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
411:         THIS.grd_4c_Dados.Refresh()
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * GrdHeader3Click - Ordena grid pela coluna Nome
416:     *--------------------------------------------------------------------------
417:     PROCEDURE GrdHeader3Click()
418:         SELECT cursor_4c_Dados
419:         SET ORDER TO TAG Rclis
420:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
421:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
422:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
423:         THIS.grd_4c_Dados.Refresh()
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * GrdHeader4Click - Ordena grid pela coluna Email
428:     *--------------------------------------------------------------------------
429:     PROCEDURE GrdHeader4Click()
430:         SELECT cursor_4c_Dados
431:         SET ORDER TO TAG Emails
432:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
433:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
434:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
435:         THIS.grd_4c_Dados.Refresh()
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
440:     *--------------------------------------------------------------------------
441:     PROCEDURE ChkSelChange()
442:         LOCAL loc_oChk
443:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
444:         IF USED("cursor_4c_Dados")
445:             SELECT cursor_4c_Dados
446:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
447:         ENDIF
448:     ENDPROC
449: 
450:     *--------------------------------------------------------------------------
451:     * CmdSelTudoClick - Marca todos os registros
452:     *--------------------------------------------------------------------------
453:     PROCEDURE CmdSelTudoClick()
454:         IF USED("cursor_4c_Dados")
455:             SELECT cursor_4c_Dados
456:             GO TOP
457:             REPLACE ALL Checks WITH 1
458:             GO TOP
459:         ENDIF
460:         THIS.grd_4c_Dados.Refresh()
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * CmdApagaClick - Desmarca todos os registros
465:     *--------------------------------------------------------------------------
466:     PROCEDURE CmdApagaClick()
467:         IF USED("cursor_4c_Dados")
468:             SELECT cursor_4c_Dados
469:             GO TOP
470:             REPLACE ALL Checks WITH 0
471:             GO TOP
472:         ENDIF
473:         THIS.grd_4c_Dados.Refresh()
474:     ENDPROC
475: 
476:     *--------------------------------------------------------------------------
477:     * ConfigurarCabecalho - Cria container de cabecalho superior
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarCabecalho()
480:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
481:         WITH THIS.cnt_4c_Cabecalho
482:             .Top         = 0
483:             .Left        = 0

*-- Linhas 632 a 658:
632: 
633:             IF loc_lResultado AND USED("cursor_4c_Local")
634:                 *-- Migra dados para cursor do grid (ZAP+APPEND preserva estrutura de colunas)
635:                 SELECT cursor_4c_Dados
636:                 ZAP
637:                 APPEND FROM DBF("cursor_4c_Local")
638:                 IF USED("cursor_4c_Local")
639:                     USE IN cursor_4c_Local
640:                 ENDIF
641: 
642:                 *-- Ordena por Nome (comportamento padrao do original)
643:                 SELECT cursor_4c_Dados
644:                 SET ORDER TO TAG Rclis
645: 
646:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
647:                     THIS.grd_4c_Dados.Refresh()
648:                 ENDIF
649:             ENDIF
650: 
651:             *-- Modo automatico: envia email imediatamente sem interacao
652:             IF THIS.this_lAutomatico
653:                 THIS.CmdBtnEmailClick()
654:             ENDIF
655: 
656:         CATCH TO loc_oErro
657:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
658:                     "Erro ao carregar dados para email")

*-- Linhas 671 a 790:
671:         LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto
672:         LOCAL loc_cTxtMensagem, loc_cArqAnexo
673:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEdn
674:         LOCAL loc_cFrom, loc_cServer, loc_cSenha, loc_nPorta
675:         LOCAL loc_cSQL
676: 
677:         loc_lOk              = .T.
678:         loc_cReceptor        = ""
679:         loc_cReceptorCopia   = ""
680:         loc_cAssunto         = ""
681:         loc_cTxtMensagem     = ""
682:         loc_cArqAnexo        = ""
683: 
684:         *-- Seleciona apenas registros marcados
685:         IF USED("cursor_4c_Local2")
686:             USE IN cursor_4c_Local2
687:         ENDIF
688:         SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Local2 READWRITE
689: 
690:         IF !USED("cursor_4c_Local2") OR _TALLY < 1
691:             MsgAviso("Nenhum registro marcado para envio de email.", "Aviso")
692:             RETURN
693:         ENDIF
694: 
695:         SELECT cursor_4c_Local2
696:         GO TOP
697:         SCAN
698:             IF EMPTY(cursor_4c_Local2.emails)
699:                 LOOP
700:             ENDIF
701: 
702:             SELECT cursor_4c_Local2
703:             loc_cEmps   = SUBSTR(cursor_4c_Local2.EmpDopNums, 1, 3)
704:             loc_cDopes  = ALLTRIM(SUBSTR(cursor_4c_Local2.EmpDopNums, 4, 20))
705:             loc_nNumes  = VAL(SUBSTR(cursor_4c_Local2.EmpDopNums, 24, 6))
706:             loc_cEdn    = ALLTRIM(cursor_4c_Local2.EmpDopNums)
707: 
708:             IF RECNO("cursor_4c_Local2") = 1
709:                 loc_cReceptor      = ALLTRIM(cursor_4c_Local2.emails)
710:                 loc_cTxtMensagem   = ""
711:                 loc_cAssunto       = ""
712:             ELSE
713:                 IF !EMPTY(ALLTRIM(cursor_4c_Local2.emails))
714:                     loc_cReceptorCopia = loc_cReceptorCopia + ;
715:                         IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
716:                         ALLTRIM(cursor_4c_Local2.emails)
717:                 ENDIF
718:             ENDIF
719: 
720:             *-- Remove PDF anterior se existir
721:             IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
722:                 DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
723:             ENDIF
724: 
725:             *-- Gera impressao/PDF do documento
726:             loc_lOk = THIS.ImprimirDocumento(loc_cEdn)
727: 
728:             IF loc_lOk
729:                 loc_cArqAnexo = THIS.this_cArqEmail
730:             ENDIF
731: 
732:             *-- Busca dados de email da empresa
733:             loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
734:                        "FROM SigCdEmp WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
735:             IF USED("cursor_4c_EmpMail")
736:                 USE IN cursor_4c_EmpMail
737:             ENDIF
738:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpMail") < 1
739:                 MsgErro("Falha ao buscar dados de email da empresa.", "Erro")
740:                 loc_lOk = .F.
741:             ELSE
742:                 SELECT cursor_4c_EmpMail
743:                 GO TOP
744:                 IF !EOF("cursor_4c_EmpMail")
745:                     loc_cFrom   = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadEmails, "")))
746:                     loc_cServer = LOWER(ALLTRIM(NVL(cursor_4c_EmpMail.PadServs, "")))
747:                     loc_cSenha  = ALLTRIM(NVL(cursor_4c_EmpMail.PadSenhas, ""))
748:                     loc_nPorta  = NVL(cursor_4c_EmpMail.PadPortas, 0)
749:                 ELSE
750:                     MsgErro("Empresa n" + CHR(227) + "o encontrada no cadastro.", "Erro")
751:                     loc_lOk = .F.
752:                 ENDIF
753:             ENDIF
754: 
755:             IF loc_lOk
756:                 WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR
757:                 loc_lOk = THIS.EnviarEmail(;
758:                     loc_cFrom, ;
759:                     loc_cReceptor, ;
760:                     loc_cReceptorCopia, ;
761:                     loc_cAssunto, ;
762:                     loc_cTxtMensagem, ;
763:                     loc_cArqAnexo, ;
764:                     loc_cServer, ;
765:                     loc_nPorta, ;
766:                     loc_cFrom, ;
767:                     loc_cSenha;
768:                 )
769:             ENDIF
770: 
771:             IF loc_lOk
772:                 THIS.GravarLog(loc_cEdn)
773:             ENDIF
774: 
775:             SELECT cursor_4c_Local2
776:         ENDSCAN
777: 
778:         WAIT CLEAR
779: 
780:         IF USED("cursor_4c_EmpMail")
781:             USE IN cursor_4c_EmpMail
782:         ENDIF
783:         IF USED("cursor_4c_Local2")
784:             USE IN cursor_4c_Local2
785:         ENDIF
786: 
787:         IF loc_lOk
788:             WAIT WINDOW "Email enviado com sucesso!" TIMEOUT 2
789:             THIS.Release()
790:         ENDIF

*-- Linhas 806 a 884:
806: 
807:         TRY
808:             *-- Busca cabecalho do movimento
809:             loc_cSQL = "SELECT Emps, Dopes, Numes, ValDevs, EmpDnCrds, Contads " + ;
810:                        "FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(par_cEdn))
811:             IF USED("cursor_4c_MvCab")
812:                 TABLEREVERT(.T., "cursor_4c_MvCab")
813:                 USE IN cursor_4c_MvCab
814:             ENDIF
815:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab") < 1
816:                 MsgErro("Erro ao buscar movimento " + ALLTRIM(par_cEdn), "Erro")
817:                 loc_lContinuar = .F.
818:             ENDIF
819: 
820:             IF loc_lContinuar
821:                 SELECT cursor_4c_MvCab
822:                 GO TOP
823:                 IF EOF("cursor_4c_MvCab")
824:                     loc_lContinuar = .F.
825:                 ENDIF
826:             ENDIF
827: 
828:             *-- Busca operacao
829:             IF loc_lContinuar
830:                 loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
831:                 loc_cSQL   = "SELECT Dopes, Docus, nOpCrs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
832:                 IF USED("cursor_4c_Ope")
833:                     USE IN cursor_4c_Ope
834:                 ENDIF
835:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope") < 1
836:                     MsgErro("Erro ao buscar opera" + CHR(231) + CHR(227) + "o " + loc_cDopes, "Erro")
837:                     loc_lContinuar = .F.
838:                 ELSE
839:                     SELECT cursor_4c_Ope
840:                     GO TOP
841:                 ENDIF
842:             ENDIF
843: 
844:             IF loc_lContinuar
845:                 *-- Busca configuracao da operacao (datacenter - inclui GerOpes)
846:                 loc_cSQL = "SELECT Dopes, QtdDocs, GerOpes FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopes)
847:                 IF USED("cursor_4c_OpCdc")
848:                     USE IN cursor_4c_OpCdc
849:                 ENDIF
850:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdc")
851:                 SELECT cursor_4c_OpCdc
852:                 GO TOP
853: 
854:                 *-- Busca configuracao de Job e inventario (SigOpCdi - lbltxidCs e chkInvs)
855:                 loc_cSQL = "SELECT Dopes, lbltxidCs, chkInvs FROM SigOpCdi WHERE Dopes = " + EscaparSQL(loc_cDopes)
856:                 IF USED("cursor_4c_OpCdi")
857:                     USE IN cursor_4c_OpCdi
858:                 ENDIF
859:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdi")
860:                 SELECT cursor_4c_OpCdi
861:                 GO TOP
862: 
863:                 *-- Busca configuracao adicional (SigOpCdd - ConfigGers para impressao de Job)
864:                 loc_cSQL = "SELECT Dopes, ConfigGers FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes)
865:                 IF USED("cursor_4c_OpCdd")
866:                     USE IN cursor_4c_OpCdd
867:                 ENDIF
868:                 SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdd")
869:                 SELECT cursor_4c_OpCdd
870:                 GO TOP
871: 
872:                 *-- Define caminho do PDF gerado
873:                 THIS.this_cArqEmail  = ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
874:                 THIS.this_cPcEscolha = ""
875: 
876:                 *-- Impressao de boleto/NF (docus 0,1,5)
877:                 IF !EOF("cursor_4c_Ope") AND INLIST(cursor_4c_Ope.Docus, 0, 1, 5)
878:                     loc_cEmps  = ALLTRIM(cursor_4c_MvCab.Emps)
879:                     loc_cDopes = ALLTRIM(cursor_4c_MvCab.Dopes)
880:                     DO FORM SigPrIdc WITH ;
881:                         loc_cEmps, loc_cDopes, cursor_4c_MvCab.Numes, ;
882:                         cursor_4c_MvCab.ValDevs, cursor_4c_OpCdc.QtdDocs, ;
883:                         .F., .T., .F., .F., .F., .F., THIS, .T.
884:                     loc_lSucesso = FILE(THIS.this_cArqEmail)

*-- Linhas 907 a 951:
907:                 *-- Estorno: operacao gerou documento vinculado (nOpCrs nao vazio)
908:                 IF !EOF("cursor_4c_Ope") AND !EMPTY(cursor_4c_Ope.nOpCrs)
909:                     LOCAL loc_cSQLEst, loc_cEmpEst, loc_cDopEst, loc_nNumEst
910:                     loc_cSQLEst = "SELECT Emps, Dopes, Numes, ValDevs " + ;
911:                                   "FROM SigMvCab WHERE EmpDnCrds = " + EscaparSQL(ALLTRIM(par_cEdn))
912:                     IF USED("cursor_4c_MvCabEst")
913:                         USE IN cursor_4c_MvCabEst
914:                     ENDIF
915:                     IF SQLEXEC(gnConnHandle, loc_cSQLEst, "cursor_4c_MvCabEst") > 0
916:                         SELECT cursor_4c_MvCabEst
917:                         GO TOP
918:                         IF !EOF("cursor_4c_MvCabEst")
919:                             loc_cEmpEst = ALLTRIM(cursor_4c_MvCabEst.Emps)
920:                             loc_cDopEst = ALLTRIM(cursor_4c_MvCabEst.Dopes)
921:                             loc_nNumEst = cursor_4c_MvCabEst.Numes
922:                             IF USED("cursor_4c_OpeEst")
923:                                 USE IN cursor_4c_OpeEst
924:                             ENDIF
925:                             loc_cSQL = "SELECT Dopes, Docus FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopEst)
926:                             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeEst") > 0
927:                                 SELECT cursor_4c_OpeEst
928:                                 GO TOP
929:                                 IF !EOF("cursor_4c_OpeEst")
930:                                     IF INLIST(cursor_4c_OpeEst.Docus, 1, 5)
931:                                         IF USED("cursor_4c_OpCdcEst")
932:                                             USE IN cursor_4c_OpCdcEst
933:                                         ENDIF
934:                                         loc_cSQL = "SELECT Dopes, QtdDocs FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopEst)
935:                                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpCdcEst") > 0
936:                                             SELECT cursor_4c_OpCdcEst
937:                                             GO TOP
938:                                             IF !EOF("cursor_4c_OpCdcEst")
939:                                                 DO FORM SigPrIdc WITH ;
940:                                                     loc_cEmpEst, loc_cDopEst, loc_nNumEst, ;
941:                                                     cursor_4c_MvCabEst.ValDevs, cursor_4c_OpCdcEst.QtdDocs, ;
942:                                                     .F., .F., .F., .F., .F., .F., THIS, .T.
943:                                             ENDIF
944:                                         ENDIF
945:                                         IF USED("cursor_4c_OpCdcEst")
946:                                             USE IN cursor_4c_OpCdcEst
947:                                         ENDIF
948:                                     ENDIF
949:                                     IF INLIST(cursor_4c_OpeEst.Docus, 3, 6, 7, 8, 9)
950:                                         DO FORM SigReIfx WITH loc_cEmpEst, loc_cDopEst, loc_nNumEst, .F., .T.
951:                                     ENDIF

*-- Linhas 990 a 1008:
990:     * EnviarEmail - Envia email via CDO.Message
991:     * Adaptado de: SIGPREMA.memail
992:     *--------------------------------------------------------------------------
993:     FUNCTION EnviarEmail(par_cFrom, par_cTo, par_cCC, par_cAssunto, par_cCorpo, ;
994:                          par_cAnexo, par_cSmtpServer, par_nSmtpPort, ;
995:                          par_cSendUser, par_cSendPass)
996:         LOCAL loc_oEmail, loc_lOk, loc_lEnvioOk, loc_oErro
997:         loc_lOk      = .F.
998:         loc_lEnvioOk = .T.
999: 
1000:         TRY
1001:             loc_oEmail = CREATEOBJECT("CDO.Message")
1002:             IF VARTYPE(loc_oEmail) != "O"
1003:                 MsgAviso("Problemas ao instanciar CDO.Message para envio de email.", "Aviso")
1004:                 loc_lEnvioOk = .F.
1005:             ENDIF
1006: 
1007:             IF loc_lEnvioOk
1008:                 WITH loc_oEmail.Configuration.Fields

*-- Linhas 1014 a 1038:
1014:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")           = LOWER(ALLTRIM(par_cSendUser))
1015:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")           = par_cSendPass
1016:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")             = IIF(par_nSmtpPort = 465, 1, 0)
1017:                     .Update()
1018:                 ENDWITH
1019: 
1020:                 WITH loc_oEmail
1021:                     .To        = LOWER(ALLTRIM(par_cTo))
1022:                     .Cc        = LOWER(NVL(par_cCC, ""))
1023:                     .From      = LOWER(ALLTRIM(par_cFrom))
1024:                     .Subject   = ALLTRIM(par_cAssunto)
1025:                     .TextBody  = ALLTRIM(par_cCorpo)
1026: 
1027:                     IF !ISNULL(par_cAnexo) AND !EMPTY(ALLTRIM(par_cAnexo))
1028:                         IF FILE(ALLTRIM(par_cAnexo))
1029:                             .AddAttachment(ALLTRIM(par_cAnexo))
1030:                         ELSE
1031:                             loc_lEnvioOk = .F.
1032:                             MsgAviso("Arquivo anexo n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1033:                                      ALLTRIM(par_cAnexo), "Aviso")
1034:                         ENDIF
1035:                     ENDIF
1036: 
1037:                     IF loc_lEnvioOk
1038:                         LOCAL loc_oErroEnvio

*-- Linhas 1065 a 1088:
1065:         loc_lSucesso = .F.
1066: 
1067:         TRY
1068:             loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datas, Horas) " + ;
1069:                        "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
1070:                        EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
1071:                        FormatarDataSQL(DATE()) + ", " + ;
1072:                        EscaparSQL(TIME()) + ")"
1073:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1074:                 loc_lSucesso = .T.
1075:             ENDIF
1076:         CATCH TO loc_oErro
1077:             *-- Falha no log nao impede o fluxo principal
1078:         ENDTRY
1079:     ENDPROC
1080: 
1081:     *--------------------------------------------------------------------------
1082:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1083:     * FormBase declara este metodo; retorna .F. para indicar nao-suporte
1084:     *--------------------------------------------------------------------------
1085:     PROCEDURE BtnIncluirClick()
1086:         RETURN .F.
1087:     ENDPROC
1088: 

*-- Linhas 1206 a 1224:
1206:     *--------------------------------------------------------------------------
1207:     PROCEDURE LimparCampos()
1208:         IF USED("cursor_4c_Dados")
1209:             SELECT cursor_4c_Dados
1210:             ZAP
1211:         ENDIF
1212:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1213:             THIS.grd_4c_Dados.Refresh()
1214:         ENDIF
1215:     ENDPROC
1216: 
1217:     *--------------------------------------------------------------------------
1218:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1219:     *--------------------------------------------------------------------------
1220:     PROCEDURE CarregarLista()
1221:         RETURN THIS.CarregarDados()
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------


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

