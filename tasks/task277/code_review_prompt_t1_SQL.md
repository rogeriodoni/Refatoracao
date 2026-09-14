# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, LCSQL, EMPDNCRDS, DATATRANS, EMPDOPNUMS, PROGS, ICLIS, JOBS, CHECKS, CEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, LCSQL, EMPDNCRDS, DATATRANS, EMPDOPNUMS, PROGS, ICLIS, JOBS, CHECKS, CEMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNPDFCOUNT, LLPDFSTART, LNMAXSLEEP, LCSQL, EMPDNCRDS, DATATRANS, EMPDOPNUMS, PROGS, ICLIS, JOBS, CHECKS, CEMPS

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS SQL (771 linhas total):

*-- Linhas 171 a 189:
171:             IF loc_lOK
172:                 THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
173:                 IF USED("crLocalTotal")
174:                     SELECT crLocalTotal
175:                     SET ORDER TO TAG Rclis
176:                 ENDIF
177:                 THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
178:                 THIS.grd_4c_Dados.Refresh()
179:             ENDIF
180: 
181:             IF loc_lOK
182:                 THIS.TornarControlesVisiveis(THIS)
183:                 THIS.Refresh()
184:                 loc_lSucesso = .T.
185:             ENDIF
186:         CATCH TO loc_oErro
187:             MsgErro("Erro ao inicializar Formsigprema: " + loc_oErro.Message + ;
188:                 " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro")
189:         ENDTRY

*-- Linhas 248 a 337:
248:             .Height      = 469
249:             .ColumnCount = 5
250:             .RecordMark  = .F.
251:             .DeleteMark  = .F.
252:             .RowHeight   = 18
253:             .FontName    = "Verdana"
254:             .FontSize    = 8
255: 
256:             *-- Column1: CheckBox Checks (posicao visual 1 - ColumnOrder=1)
257:             *-- Sparse=.F. OBRIGATORIO: sem isso checkbox aparece so na linha corrente
258:             WITH .Column1
259:                 .Width       = 17
260:                 .ColumnOrder = 1
261:                 .ReadOnly    = .F.
262:                 .Sparse      = .F.
263:                 .AddObject("Check1", "CheckBox")
264:                 .Check1.Caption  = ""
265:                 .Check1.FontName = "Verdana"
266:                 .Check1.FontSize = 8
267:                 .CurrentControl  = "Check1"
268:                 .ControlSource   = "crLocalTotal.Checks"
269:                 .Header1.Caption = ""
270:                 .Header1.FontName = "Tahoma"
271:                 .Header1.FontSize = 8
272:             ENDWITH
273: 
274:             *-- Column2: Conta (ColumnOrder=2)
275:             WITH .Column2
276:                 .Width         = 80
277:                 .ColumnOrder   = 2
278:                 .ReadOnly      = .T.
279:                 .ControlSource = "crLocalTotal.Contas"
280:                 .Header1.Caption   = " Conta"
281:                 .Header1.FontName  = "Tahoma"
282:                 .Header1.FontSize  = 8
283:                 .Header1.Alignment = 2
284:             ENDWITH
285: 
286:             *-- Column3: Nome/Razao Social (ColumnOrder=3)
287:             WITH .Column3
288:                 .Width         = 290
289:                 .ColumnOrder   = 3
290:                 .ReadOnly      = .T.
291:                 .ControlSource = "crLocalTotal.Rclis"
292:                 .Header1.Caption   = " Nome"
293:                 .Header1.FontName  = "Tahoma"
294:                 .Header1.FontSize  = 8
295:                 .Header1.Alignment = 2
296:             ENDWITH
297: 
298:             *-- Column4: Email (ColumnOrder=4) - editavel para correcao direta
299:             WITH .Column4
300:                 .Width         = 290
301:                 .ColumnOrder   = 4
302:                 .ReadOnly      = .F.
303:                 .ControlSource = "crLocalTotal.emails"
304:                 .Header1.Caption   = "Email"
305:                 .Header1.FontName  = "Tahoma"
306:                 .Header1.FontSize  = 8
307:                 .Header1.Alignment = 2
308:             ENDWITH
309: 
310:             *-- Column5: EmpDopNums / Movimentacao (ColumnOrder=5) - EditBox somente leitura
311:             WITH .Column5
312:                 .Width       = 290
313:                 .ColumnOrder = 5
314:                 .ReadOnly    = .T.
315:                 .AddObject("EditBox1", "EditBox")
316:                 .EditBox1.ReadOnly      = .T.
317:                 .EditBox1.SpecialEffect = 1
318:                 .EditBox1.BorderStyle   = 0
319:                 .EditBox1.FontName      = "Verdana"
320:                 .EditBox1.FontSize      = 8
321:                 .CurrentControl  = "EditBox1"
322:                 .ControlSource   = "crLocalTotal.EmpDopNums"
323:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
324:                 .Header1.FontName  = "Tahoma"
325:                 .Header1.FontSize  = 8
326:                 .Header1.Alignment = 2
327:             ENDWITH
328:         ENDWITH
329:     ENDPROC
330: 
331:     *==========================================================================
332:     PROTECTED PROCEDURE ConfigurarBotoes()
333:     *==========================================================================
334:         *-- Botao Enviar Email (flutuante sobre cabecalho, esquerda do Encerrar)
335:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
336:         WITH THIS.cmd_4c_BtnEmail
337:             .Top         = 3

*-- Linhas 441 a 459:
441: 
442:         *-- Verificar se ha pelo menos um registro marcado para envio
443:         IF USED("crLocalTotal")
444:             SELECT crLocalTotal
445:             COUNT FOR Checks = 1 TO loc_nMarcados
446:         ENDIF
447: 
448:         IF loc_nMarcados = 0
449:             MsgAviso("Selecione ao menos um registro para envio de email.", ;
450:                 "Envio de Email")
451:             RETURN
452:         ENDIF
453: 
454:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
455:             WAIT WINDOW "Aguarde... gerando e enviando email..." NOWAIT NOCLEAR
456: 
457:             loc_lOK = THIS.this_oBusinessObject.ProcessarEnvioEmails()
458: 
459:             WAIT CLEAR

*-- Linhas 469 a 550:
469:     PROCEDURE BtnSelTudoClick()
470:     *==========================================================================
471:         IF USED("crLocalTotal")
472:             SELECT crLocalTotal
473:             GO TOP
474:             REPLACE ALL Checks WITH 1
475:             GO TOP
476:             THIS.grd_4c_Dados.Refresh()
477:         ENDIF
478:     ENDPROC
479: 
480:     *==========================================================================
481:     PROCEDURE BtnApagaClick()
482:     *==========================================================================
483:         IF USED("crLocalTotal")
484:             SELECT crLocalTotal
485:             GO TOP
486:             REPLACE ALL Checks WITH 0
487:             GO TOP
488:             THIS.grd_4c_Dados.Refresh()
489:         ENDIF
490:     ENDPROC
491: 
492:     *==========================================================================
493:     PROCEDURE HeaderContaClick()
494:     *==========================================================================
495:         IF USED("crLocalTotal")
496:             SELECT crLocalTotal
497:             SET ORDER TO TAG Contas
498:         ENDIF
499:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64,128,128)
500:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192,192,192)
501:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
502:         THIS.grd_4c_Dados.Refresh()
503:     ENDPROC
504: 
505:     *==========================================================================
506:     PROCEDURE HeaderNomeClick()
507:     *==========================================================================
508:         IF USED("crLocalTotal")
509:             SELECT crLocalTotal
510:             SET ORDER TO TAG Rclis
511:         ENDIF
512:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
513:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
514:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
515:         THIS.grd_4c_Dados.Refresh()
516:     ENDPROC
517: 
518:     *==========================================================================
519:     PROCEDURE HeaderEmailClick()
520:     *==========================================================================
521:         IF USED("crLocalTotal")
522:             SELECT crLocalTotal
523:             SET ORDER TO TAG Emails
524:         ENDIF
525:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
526:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192,192,192)
527:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64,128,128)
528:         THIS.grd_4c_Dados.Refresh()
529:     ENDPROC
530: 
531:     *==========================================================================
532:     PROCEDURE ChkChecksChange()
533:     *==========================================================================
534:         IF USED("crLocalTotal")
535:             SELECT crLocalTotal
536:             REPLACE Checks WITH THIS.grd_4c_Dados.Column1.Check1.Value IN crLocalTotal
537:         ENDIF
538:     ENDPROC
539: 
540:     *==========================================================================
541:     * Eventos CRUD mapeados para semantica OPERACIONAL de dispatch de email
542:     *--------------------------------------------------------------------------
543:     * SIGPREMA nao gerencia entidades: processa cursor crLocalTotal com emails
544:     * a enviar. As acoes reais sao Enviar Email / Marcar Todos / Desmarcar.
545:     * Os quatro handlers abaixo existem para atender o contrato do pipeline e
546:     * mapeiam para o comportamento operacional mais proximo (nunca vazios).
547:     *==========================================================================
548: 
549:     *==========================================================================
550:     PROCEDURE BtnIncluirClick()

*-- Linhas 565 a 600:
565:                 IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
566:                     THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
567:                     IF USED("crLocalTotal")
568:                         SELECT crLocalTotal
569:                         GO TOP
570:                     ENDIF
571:                     THIS.grd_4c_Dados.Refresh()
572:                 ENDIF
573:             ENDIF
574:         CATCH TO loc_oErro
575:             MsgErro("Erro ao recarregar dados: " + loc_oErro.Message, "Erro")
576:         ENDTRY
577:     ENDPROC
578: 
579:     *==========================================================================
580:     PROCEDURE BtnVisualizarClick()
581:     *==========================================================================
582:         *-- Foca o grid para visualizacao dos registros de email
583:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
584:             IF USED("crLocalTotal") AND RECCOUNT("crLocalTotal") > 0
585:                 SELECT crLocalTotal
586:                 GO TOP
587:                 THIS.grd_4c_Dados.SetFocus()
588:                 THIS.grd_4c_Dados.Refresh()
589:             ELSE
590:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " registros para visualizar.", ;
591:                     "Visualizar")
592:             ENDIF
593:         ENDIF
594:     ENDPROC
595: 
596:     *==========================================================================
597:     PROCEDURE BtnExcluirClick()
598:     *==========================================================================
599:         *-- Desmarcar todos: remove selecoes de envio (delega ao BtnApagaClick)
600:         THIS.BtnApagaClick()

*-- Linhas 614 a 632:
614:                 IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cDopes)
615:                     THIS.grd_4c_Dados.RecordSource = "crLocalTotal"
616:                     IF USED("crLocalTotal")
617:                         SELECT crLocalTotal
618:                         SET ORDER TO TAG Rclis
619:                         GO TOP
620:                     ENDIF
621:                     THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192,192,192)
622:                     THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64,128,128)
623:                     THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192,192,192)
624:                     THIS.grd_4c_Dados.Refresh()
625:                     loc_lSucesso = .T.
626:                 ENDIF
627:             ENDIF
628:         CATCH TO loc_oErro
629:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
630:         ENDTRY
631:         RETURN loc_lSucesso
632:     ENDPROC

*-- Linhas 678 a 756:
678:             RETURN
679:         ENDIF
680:         IF USED("crLocalTotal")
681:             SELECT crLocalTotal
682:             GO TOP
683:             THIS.grd_4c_Dados.Refresh()
684:         ENDIF
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * HabilitarCampos - Controla habilitacao de botoes conforme estado do cursor
689:     *--------------------------------------------------------------------------
690:     * cmd_4c_BtnEmail: habilitado quando ha pelo menos um registro marcado.
691:     * cmd_4c_SelTudo/cmd_4c_Apaga: sempre habilitados quando ha registros.
692:     *==========================================================================
693:     PROCEDURE HabilitarCampos()
694:         LOCAL loc_nTotal, loc_nMarcados
695:         loc_nTotal   = 0
696:         loc_nMarcados = 0
697:         IF USED("crLocalTotal")
698:             SELECT crLocalTotal
699:             COUNT TO loc_nTotal
700:             COUNT FOR Checks = 1 TO loc_nMarcados
701:         ENDIF
702:         IF VARTYPE(THIS.cmd_4c_BtnEmail) = "O"
703:             *-- Icone-only: nao desabilitar (.Enabled=.F. apaga icone); controle no handler
704:         ENDIF
705:         IF VARTYPE(THIS.cmd_4c_SelTudo) = "O"
706:             *-- Icone-only: nao desabilitar
707:         ENDIF
708:         IF VARTYPE(THIS.cmd_4c_Apaga) = "O"
709:             *-- Icone-only: nao desabilitar
710:         ENDIF
711:     ENDPROC
712: 
713:     *==========================================================================
714:     * LimparCampos - Limpa cursor crLocalTotal e redefine grid
715:     *==========================================================================
716:     PROCEDURE LimparCampos()
717:         IF USED("crLocalTotal")
718:             SELECT crLocalTotal
719:             ZAP
720:             THIS.grd_4c_Dados.Refresh()
721:         ENDIF
722:         THIS.this_cDopes = ""
723:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
724:             THIS.this_oBusinessObject.this_cEmpDopNums = ""
725:             THIS.this_oBusinessObject.this_cContas     = ""
726:             THIS.this_oBusinessObject.this_cRclis      = ""
727:             THIS.this_oBusinessObject.this_cEmails     = ""
728:         ENDIF
729:     ENDPROC
730: 
731:     *==========================================================================
732:     * AjustarBotoesPorModo - Ajuste visual dos botoes para este form OPERACIONAL
733:     *--------------------------------------------------------------------------
734:     * OPERACIONAL nao tem modos INCLUIR/ALTERAR/VISUALIZAR classicos. O metodo
735:     * garante que os botoes estejam no estado correto para exibicao do grid.
736:     *==========================================================================
737:     PROCEDURE AjustarBotoesPorModo()
738:         LOCAL loc_nTotal
739:         loc_nTotal = 0
740:         IF USED("crLocalTotal")
741:             SELECT crLocalTotal
742:             COUNT TO loc_nTotal
743:         ENDIF
744:         IF VARTYPE(THIS.cmd_4c_BtnEmail) = "O"
745:             THIS.cmd_4c_BtnEmail.Visible = (loc_nTotal > 0)
746:         ENDIF
747:     ENDPROC
748: 
749:     *==========================================================================
750:     * TornarControlesVisiveis - Torna todos os sub-controles visiveis
751:     *--------------------------------------------------------------------------
752:     * Aplicado apos AddObject que cria controles com Visible=.F. por default.
753:     * Para este form operacional plano os containers que devem permanecer
754:     * ocultos (nao ha nenhum neste form) seriam excluidos por nome aqui.
755:     *==========================================================================
756:     PROCEDURE TornarControlesVisiveis(par_oContainer)


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* sigpremaBO.prg - Business Object para Processamento e Geracao de Email
*==============================================================================
* Entidade : SIGPREMA - Processamento e Geracao de Email de Movimentacoes
* Tabelas  : SigMvCab, SigCdCli, SigCdPam, SigCdEmp, SigClJob, sigoplog
* Autor    : Migracao Automatica VFP9
* Data     : 2026-07-15
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Sem tabela de CRUD: operacoes em cursores locais + views SQL
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Parametros de execucao recebidos no Init do form
    this_cEmps        = ""    && C(3)  codigo da empresa (Substr(prDopes,1,3))
    this_cDopes       = ""    && C(20) operacao (Substr(prDopes,4,20))
    this_cEmpDopNums  = ""    && C(29) chave completa EmpDopNums (prDopes)
    this_lAutomatico  = .F.   && .T. = modo automatico sem interacao UI

    *-- Controle de arquivo PDF para anexo de email
    this_cPcArqEmail  = ""    && path completo do arquivo PDF gerado
    this_cPcEscolha   = ""    && escolha do tipo de impressao do documento

    *-- Configuracao SMTP lida de SigCdEmp
    this_cEmailFrom   = ""    && remetente (PadEmails da empresa)
    this_cSmtpServer  = ""    && servidor SMTP (PadServs)
    this_cSmtpSenha   = ""    && senha SMTP (PadSenhas)
    this_nSmtpPorta   = 0     && porta SMTP (PadPortas)

    *-- Filtro de data para busca de movimentacoes (quando prDopes vazio)
    this_dDti         = {}    && data/hora inicial do dia corrente
    this_dDtf         = {}    && data/hora final do dia corrente

    *-- Flag de controle de resultado do envio
    this_lEnvioOk     = .F.   && .T. se ultimo envio foi bem-sucedido

    *-- Dados da linha corrente (preenchidos em CarregarDoCursor)
    this_cContas      = ""    && C(10) conta do cliente
    this_cRclis       = ""    && C(30) razao social do cliente
    this_cEmails      = ""    && C(50) email do cliente
    this_cGrupos      = ""    && C(10) grupo do cliente
    this_cPrioridade  = ""    && C(15) prioridade do envio
    this_nChecks      = 0     && N(1)  marcado para envio (0=nao / 1=sim)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave (form operacional sem CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria (EmpDopNums)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de linha de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cContas     = TratarNulo(Contas,     "C")
            THIS.this_cRclis      = TratarNulo(Rclis,      "C")
            THIS.this_cEmails     = TratarNulo(emails,     "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_nChecks     = NVL(Checks, 0)
            loc_lSucesso          = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Popula crLocalTotal com movimentacoes para envio de email
    * par_cDopes = EmpDopNums completo (C(29)) ou vazio (busca pelo dia corrente)
    * Retorna .T. se carregado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cDopes)
        LOCAL loc_lSucesso, loc_lOK, loc_cQuery, loc_cDti, loc_cDtf
        LOCAL loc_cContas, loc_cRclis, loc_nJobOK
        loc_lSucesso = .F.
        loc_lOK      = .T.

        IF VARTYPE(par_cDopes) != "C"
            par_cDopes = ""
        ENDIF

        TRY
            *-- Recriar cursor destino
            IF USED("crLocalTotal")
                USE IN crLocalTotal
            ENDIF
            SET NULL ON
            CREATE CURSOR crLocalTotal (;
                Checks N(1), grupos C(10), Contas C(10), Rclis C(30), ;
                emails C(50), mensagems M, EmpDopNums C(29), prioridade C(15))
            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON emails TAG Emails
            SET NULL OFF

            *-- Montar query de movimentacoes
            IF EMPTY(par_cDopes)
                loc_cDti   = THIS.FormatarDatetimeSQL(DATETIME())
                loc_cDtf   = THIS.FormatarDatetimeSQL(DTOT(DATE()) + 86399)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, " + ;
                    "b.emails, b.grupos, b.iclis " + ;
                    "FROM SigMvcab a " + ;
                    "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                    "WHERE a.datatrans BETWEEN " + loc_cDti + " AND " + loc_cDtf + " " + ;
                    "AND a.EmpDopNums NOT IN (" + ;
                    "SELECT Transacaos FROM sigoplog WHERE progs = 'SIGPREMA') " + ;
                    "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, " + ;
                    "b.emails, b.grupos, b.iclis " + ;
                    "FROM SigMvcab a " + ;
                    "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            *-- Buscar movimentacoes
            IF loc_lOK
                IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpMvCab") < 1
                    MsgErro("Falha ao buscar movimenta" + CHR(231) + CHR(245) + ;
                        "es para email (TmpMvCab).", "Erro")
                    loc_lOK = .F.
                ENDIF
            ENDIF

            *-- Popular crLocalTotal com movimentacoes
            IF loc_lOK
                SELECT TmpMvCab
                GO TOP
                SCAN
                    INSERT INTO crLocalTotal ;
                        (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                        VALUES (TmpMvCab.Checks, TmpMvCab.grupos, TmpMvCab.iclis, ;
                            TmpMvCab.Rclis, TmpMvCab.emails, "NORMAL", TmpMvCab.EmpDopNums)
                ENDSCAN
                IF USED("TmpMvCab")
                    USE IN TmpMvCab
                ENDIF
            ENDIF

            *-- Buscar contas adicionais parametrizadas em SigCdPam
            IF loc_lOK
                loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                    "c.rclis, c.emails, '' AS prioridade " + ;
                    "FROM SigCdPam p " + ;
                    "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"
                IF SQLEXEC(gnConnHandle, loc_cQuery, "crLocalPAM") < 1
                    MsgErro("Falha ao buscar contas PAM (crLocalPAM).", "Erro")
                    loc_lOK = .F.
                ENDIF
            ENDIF

            *-- Adicionar registros PAM que nao existam em crLocalTotal
            IF loc_lOK
                SELECT crLocalPAM
                SCAN
                    loc_cContas = ALLTRIM(crLocalPAM.Contas)
                    loc_cRclis  = ALLTRIM(crLocalPAM.Rclis)

                    *-- Verificar Jobs do cliente PAM
                    loc_nJobOK = SQLEXEC(gnConnHandle, ;
                        "SELECT Jobs FROM SigClJob WHERE Iclis = " + EscaparSQL(loc_cContas), ;
                        "TmpClJob")
                    IF loc_nJobOK >= 1 AND USED("TmpClJob")
                        USE IN TmpClJob
                    ENDIF

                    *-- Inserir se nao existir no crLocalTotal
                    SELECT crLocalTotal
                    LOCATE FOR ALLTRIM(crLocalTotal.Contas) = loc_cContas ;
                        AND ALLTRIM(crLocalTotal.Rclis) = loc_cRclis
                    IF EOF()
                        INSERT INTO crLocalTotal ;
                            (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                            VALUES (crLocalPAM.Checks, "", loc_cContas, loc_cRclis, ;
                                crLocalPAM.emails, par_cDopes, "NORMAL")
                    ENDIF

                    SELECT crLocalPAM
                ENDSCAN
                IF USED("crLocalPAM")
                    USE IN crLocalPAM
                ENDIF
            ENDIF

            IF loc_lOK
                SELECT crLocalTotal
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterConfigSMTP - Le configuracao SMTP da empresa em SigCdEmp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterConfigSMTP()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        TRY
            loc_cQuery = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                "FROM SigCdEmp WHERE CEmps = " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cQuery, "TmpCfgSMTP") >= 1
                SELECT TmpCfgSMTP
                GO TOP
                IF !EOF()
                    THIS.this_cEmailFrom  = LOWER(ALLTRIM(NVL(TmpCfgSMTP.PadEmails, "")))
                    THIS.this_cSmtpServer = LOWER(ALLTRIM(NVL(TmpCfgSMTP.PadServs,  "")))
                    THIS.this_cSmtpSenha  = ALLTRIM(NVL(TmpCfgSMTP.PadSenhas, ""))
                    THIS.this_nSmtpPorta  = NVL(TmpCfgSMTP.PadPortas, 0)
                    loc_lSucesso          = .T.
                ENDIF
                IF USED("TmpCfgSMTP")
                    USE IN TmpCfgSMTP
                ENDIF
            ELSE
                MsgErro("Falha ao ler configura" + CHR(231) + CHR(227) + "o SMTP da empresa.", ;
                    "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ObterConfigSMTP")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDocumento - Gera documento e PDF de uma movimentacao
    * par_cEdn = EmpDopNums (C(29)) da movimentacao
    * Retorna .T. se gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDocumento(par_cEdn)
        LOCAL loc_lSucesso, loc_lOK, loc_cQuery
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nValDevs
        LOCAL loc_nDocusCdOpe, loc_nQtdDocs, loc_nGerOpes
        LOCAL loc_nJobAtivo, loc_nJobTela, loc_lInvAtivo
        LOCAL loc_cEmpDopNumsMvCab
        LOCAL loc_cEstEmps, loc_cEstDopes, loc_nEstNumes, loc_nDocusEst, loc_nEstQtdDocs, loc_nEstValDevs

        loc_lSucesso    = .F.
        loc_lOK         = .T.
        loc_nDocusCdOpe = -1

        TRY
            *-- Carregar movimentacao
            IF SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 * FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(par_cEdn), ;
                "TprMvCab") < 1
                MsgErro("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o encontrada: " + par_cEdn, "Erro")
                loc_lOK = .F.
            ENDIF

            IF loc_lOK
                SELECT TprMvCab
                GO TOP
                IF EOF()
                    loc_lOK = .F.
                ELSE
                    loc_cEmps          = ALLTRIM(TprMvCab.Emps)
                    loc_cDopes         = ALLTRIM(TprMvCab.Dopes)
                    loc_nNumes         = NVL(TprMvCab.Numes, 0)
                    loc_nValDevs       = NVL(TprMvCab.valdevs, 0)
                    loc_cEmpDopNumsMvCab = ALLTRIM(TprMvCab.EmpDopNums)
                ENDIF
            ENDIF

            *-- Carregar configuracao da operacao
            IF loc_lOK
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigCdOpe WHERE dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigCdOpe")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdc WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdc")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdi WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdi")
                SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 * FROM SigOpCdd WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                    "crSigOpCdd")

                IF USED("crSigCdOpe")
                    SELECT crSigCdOpe
                    GO TOP
                    IF !EOF()
                        loc_nDocusCdOpe = NVL(crSigCdOpe.docus, -1)
                    ENDIF
                ENDIF

                THIS.this_cPcEscolha = ""

                *-- Boleto (docus = 0, 1, 5)
                IF INLIST(loc_nDocusCdOpe, 0, 1, 5)
                    loc_nQtdDocs = 0
                    IF USED("crSigOpCdc")
                        SELECT crSigOpCdc
                        GO TOP
                        IF !EOF()
                            loc_nQtdDocs = NVL(crSigOpCdc.QtdDocs, 0)
                        ENDIF
                    ENDIF
                    TRY
                        DO SigPrIdc WITH loc_cEmps, loc_cDopes, loc_nNumes, ;
                            loc_nValDevs, loc_nQtdDocs, .F., .T., .F., .F., .F., .F., THISFORM, .T.
                    CATCH TO loc_oErroPrg
                        MsgErro("Erro ao imprimir documento: " + loc_oErroPrg.Message, ;
                            "Impress" + CHR(227) + "o")
                    ENDTRY
                    THIS.this_cPcArqEmail = ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
                    loc_lSucesso          = .T.
                ENDIF

                *-- NF (docus = 3, 4, 6, 7, 8, 9)
                IF INLIST(loc_nDocusCdOpe, 3, 4, 6, 7, 8, 9)
                    TRY
                        DO FORM SigReIfx WITH loc_cEmps, loc_cDopes, loc_nNumes, .F., .T.
                    CATCH TO loc_oErroNF
                        MsgErro("Erro ao gerar NF: " + loc_oErroNF.Message, ;
                            "Impress" + CHR(227) + "o")
                    ENDTRY
                    loc_lSucesso = .T.
                ENDIF

                *-- Relatorio de Job (se campo Job ativo na tela e configurado)
                loc_nJobAtivo = 0
                IF USED("crSigOpCdi")
                    SELECT crSigOpCdi
                    GO TOP
                    IF !EOF()
                        loc_nJobAtivo = INT(VAL(SUBSTR(;
                            NVL(ALLTRIM(crSigOpCdi.lbltxidCs), ""), 25, 1)))
                    ENDIF
                ENDIF
                IF INLIST(loc_nJobAtivo, 1, 3) AND USED("crSigOpCdd")
                    SELECT crSigOpCdd
                    GO TOP
                    IF !EOF()
                        loc_nJobTela = INT(VAL(SUBSTR(;
                            NVL(ALLTRIM(crSigOpCdd.ConfigGers), ""), 157, 1)))
                        IF loc_nJobTela = 1
                            TRY
                                DO FORM SigReJob WITH THISFORM
                            CATCH TO loc_oErroJob
                                MsgErro("Erro no relat" + CHR(243) + "rio de Job: " + ;
                                    loc_oErroJob.Message, "Impress" + CHR(227) + "o")
                            ENDTRY
                        ENDIF
                    ENDIF
                ENDIF

                *-- Multiplas movimentacoes (GerOpes = 2)
                loc_nGerOpes = 0
                IF USED("crSigOpCdc")
                    SELECT crSigOpCdc
                    GO TOP
                    IF !EOF()
                        loc_nGerOpes = NVL(crSigOpCdc.GerOpes, 0)
                    ENDIF
                ENDIF
                IF loc_nGerOpes = 2
                    TRY
                        DO FORM SigOpIgm WITH THISFORM, loc_cEmps, loc_cDopes, loc_nNumes, .T.
                    CATCH TO loc_oErroMulti
                        MsgErro("Erro multiplas movimenta" + CHR(231) + CHR(245) + "es: " + ;
                            loc_oErroMulti.Message, "Impress" + CHR(227) + "o")
                    ENDTRY
                ENDIF

                *-- Inventario (chkInvs = 1)
                loc_lInvAtivo = .F.
                IF USED("crSigOpCdi")
                    SELECT crSigOpCdi
                    GO TOP
                    IF !EOF()
                        IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                            loc_lInvAtivo = crSigOpCdi.chkInvs
                        ELSE
                            IF VARTYPE(crSigOpCdi.chkInvs) = "L"
                                loc_lInvAtivo = crSigOpCdi.chkInvs
                            ELSE
                                loc_lInvAtivo = (NVL(crSigOpCdi.chkInvs, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF loc_lInvAtivo
                    TRY
                        DO FORM SigReIiv WITH loc_cEmps, loc_cDopes, loc_nNumes
                    CATCH TO loc_oErroInv
                        MsgErro("Erro no invent" + CHR(225) + "rio: " + ;
                            loc_oErroInv.Message, "Impress" + CHR(227) + "o")
                    ENDTRY
                ENDIF

                *-- Estorno (nOpCrs preenchido)
                IF USED("crSigCdOpe")
                    SELECT crSigCdOpe
                    GO TOP
                    IF !EOF() AND !EMPTY(NVL(crSigCdOpe.nOpCrs, ""))
                        loc_cQuery = "SELECT Emps, Dopes, Numes, ValDevs FROM SigMvCab " + ;
                            "WHERE EmpDnCrds = " + EscaparSQL(loc_cEmpDopNumsMvCab)
                        IF SQLEXEC(gnConnHandle, loc_cQuery, "crEest") >= 1
                            SELECT crEest
                            GO TOP
                            IF !EOF()
                                loc_cEstEmps  = ALLTRIM(crEest.Emps)
                                loc_cEstDopes = ALLTRIM(crEest.Dopes)
                                loc_nEstNumes = NVL(crEest.Numes, 0)
                                loc_nDocusEst = -1

                                IF SQLEXEC(gnConnHandle, ;
                                    "SELECT TOP 1 * FROM SigCdOpe WHERE dopes = " + ;
                                    EscaparSQL(loc_cEstDopes), "TmpOpeEst") >= 1
                                    SELECT TmpOpeEst
                                    GO TOP
                                    IF !EOF()
                                        loc_nDocusEst = NVL(TmpOpeEst.docus, -1)
                                    ENDIF
                                    IF USED("TmpOpeEst")
                                        USE IN TmpOpeEst
                                    ENDIF
                                ENDIF

                                IF INLIST(loc_nDocusEst, 1, 5)
                                    IF SQLEXEC(gnConnHandle, ;
                                        "SELECT TOP 1 * FROM SigOpCdc WHERE Dopes = " + ;
                                        EscaparSQL(loc_cEstDopes), "crSigOpCdcEst") >= 1 AND ;
                                       SQLEXEC(gnConnHandle, ;
                                        "SELECT TOP 1 * FROM SigMvCab WHERE EmpDopNums = " + ;
                                        EscaparSQL(loc_cEstEmps + loc_cEstDopes + ;
                                        STR(loc_nEstNumes, 6)), "CrEestMvCab") >= 1
                                        loc_nEstQtdDocs = 0
                                        loc_nEstValDevs = 0
                                        SELECT crSigOpCdcEst
                                        GO TOP
                                        IF !EOF()
                                            loc_nEstQtdDocs = NVL(crSigOpCdcEst.QtdDocs, 0)
                                        ENDIF
                                        SELECT CrEestMvCab
                                        GO TOP
                                        IF !EOF()
                                            loc_nEstValDevs = NVL(CrEestMvCab.valdevs, 0)
                                        ENDIF
                                        TRY
                                            DO SigPrIdc WITH loc_cEstEmps, loc_cEstDopes, ;
                                                loc_nEstNumes, loc_nEstValDevs, loc_nEstQtdDocs, ;
                                                .F., .F., .F., .F., .F., .F., THISFORM, .T.
                                        CATCH TO loc_oErroEst
                                            MsgErro("Erro no estorno: " + loc_oErroEst.Message, ;
                                                "Impress" + CHR(227) + "o")
                                        ENDTRY
                                        IF USED("crSigOpCdcEst")
                                            USE IN crSigOpCdcEst
                                        ENDIF
                                        IF USED("CrEestMvCab")
                                            USE IN CrEestMvCab
                                        ENDIF
                                    ENDIF
                                ENDIF

                                IF INLIST(loc_nDocusEst, 3, 6, 7, 8, 9)
                                    TRY
                                        DO FORM SigReIfx WITH loc_cEstEmps, loc_cEstDopes, ;
                                            loc_nEstNumes, .F., .T.
                                    CATCH TO loc_oErroEstNF
                                        MsgErro("Erro no estorno NF: " + loc_oErroEstNF.Message, ;
                                            "Impress" + CHR(227) + "o")
                                    ENDTRY
                                ENDIF
                            ENDIF
                            IF USED("crEest")
                                USE IN crEest
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            *-- Limpar cursores de configuracao
            LOCAL loc_nI, loc_aNomCursores[5]
            loc_aNomCursores[1] = "TprMvCab"
            loc_aNomCursores[2] = "crSigCdOpe"
            loc_aNomCursores[3] = "crSigOpCdc"
            loc_aNomCursores[4] = "crSigOpCdi"
            loc_aNomCursores[5] = "crSigOpCdd"
            FOR loc_nI = 1 TO 5
                IF USED(loc_aNomCursores[loc_nI])
                    USE IN (loc_aNomCursores[loc_nI])
                ENDIF
            ENDFOR

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ImprimirDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPDF - Gera arquivo PDF via PDFCreator COM
    * par_cArqEmail = caminho completo do arquivo PDF a gerar
    * Retorna .T. se PDF gerado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarPDF(par_cArqEmail)
        LOCAL loc_lSucesso, loc_lPDFOK, loc_lStart, loc_cDefaultPrinter, loc_nCount
        LOCAL loc_oPDF, loc_cPrn
        loc_lSucesso = .F.
        loc_lPDFOK   = .T.
        loc_lStart   = .F.

        TRY
            DECLARE INTEGER Sleep IN WIN32API INTEGER nMilliseconds

            loc_oPDF = CREATEOBJECT("PDFCreator.clsPDFCreator", "PDFCreator_")

            IF loc_oPDF.cErrorDetail("Number") <> 0
                MsgErro("Erro ao inicializar PDFCreator: " + ;
                    loc_oPDF.cErrorDetail("Description"), "PDF")
                loc_lPDFOK = .F.
            ELSE
                loc_cDefaultPrinter = SET("PRINTER", 2)

                WITH loc_oPDF
                    .cClearCache()
                    .cErrorClear()
                    loc_lStart = .cStart("/NoProcessingAtStartup")
                    IF !loc_lStart
                        MsgErro("Falha ao iniciar PDFCreator.", "PDF")
                        loc_lPDFOK = .F.
                    ELSE
                        .cOption("DisableUpdateCheck")   = 1
                        .cOption("UseAutosaveDirectory") = 1
                        .cOption("UseAutosave")          = 1
                        .cOption("UseStandardAuthor")    = 1
                        .cOption("StandardAuthor")       = "FORTYUS"
                        .cOption("StandardTitle")        = ""
                        .cOption("AutosaveFormat")       = 0
                        .cOption("AutosaveDirectory")    = ADDBS(JUSTPATH(par_cArqEmail))
                        .cOption("AutosaveFilename")     = JUSTFNAME(par_cArqEmail)
                        .cDefaultPrinter                 = "PDFCreator"
                        .cPrinterStop                    = .F.
                    ENDIF
                ENDWITH

                IF loc_lStart AND loc_lPDFOK
                    loc_cPrn = "PDFCreator"
                    SET PRINTER TO NAME (loc_cPrn)

                    *-- Aguardar PDFCreator como impressora padrao
                    loc_nCount = 0
                    DO WHILE loc_nCount < 200
                        IF loc_oPDF.cDefaultPrinter = "PDFCreator"
                            EXIT
                        ENDIF
                        Sleep(500)
                        loc_nCount = loc_nCount + 1
                    ENDDO

                    IF loc_oPDF.cDefaultPrinter = "PDFCreator"
                        THIS.ImprimirParaPDF()
                        Sleep(500)

                        *-- Aguardar geracao do arquivo PDF
                        loc_nCount = 0
                        DO WHILE loc_nCount <= 10
                            Sleep(1000)
                            loc_nCount = loc_nCount + 1
                            IF FILE(par_cArqEmail)
                                EXIT
                            ENDIF
                        ENDDO

                        IF FILE(par_cArqEmail)
                            THIS.this_cPcArqEmail = par_cArqEmail
                            loc_lSucesso          = .T.
                        ELSE
                            MsgErro("Arquivo PDF n" + CHR(227) + "o foi gerado: " + ;
                                par_cArqEmail, "PDF")
                        ENDIF
                    ELSE
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel definir " + ;
                            "PDFCreator como impressora padr" + CHR(227) + "o.", "PDF")
                    ENDIF

                    SET PRINTER TO NAME (loc_cDefaultPrinter)
                ENDIF

                loc_oPDF.cClearCache()
                loc_oPDF.cClose()
                loc_oPDF = .NULL.
            ENDIF

            CLEAR DLLS "Sleep"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GerarPDF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirParaPDF - Imprime relatorio SigReDc2 na impressora corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ImprimirParaPDF()
        LOCAL loc_cArq, loc_lcPoint, loc_lcSep
        TRY
            loc_cArq = FULLPATH(gc_4c_CaminhoReports + "SigReDc2.frx")
            IF FILE(loc_cArq)
                loc_lcPoint = SET("POINT")
                loc_lcSep   = SET("SEPARATOR")
                SET POINT TO "."
                SET SEPARATOR TO ","
                SET REPORTBEHAVIOR 80
                REPORT FORM (loc_cArq) TO PRINTER NOCONSOLE
                SET POINT TO (loc_lcPoint)
                SET SEPARATOR TO (loc_lcSep)
                SET REPORTBEHAVIOR 90
            ELSE
                MsgErro("Relat" + CHR(243) + "rio SigReDc2.frx n" + CHR(227) + "o encontrado.", ;
                    "PDF")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ImprimirParaPDF")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmailCDO - Envia email via CDO.Message (Windows COM)
    * par_cFrom  = endereco remetente
    * par_cTo    = endereco destinatario principal
    * par_cCC    = enderecos em copia (separados por virgula)
    * par_cAssunto, par_cCorpo = assunto e corpo do email
    * par_cAnexo = caminho completo do arquivo a anexar (ou "")
    * par_cSmtpServer, par_nPorta, par_cUser, par_cSenha = config SMTP
    * Retorna .T. se enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmailCDO(par_cFrom, par_cTo, par_cCC, par_cAssunto, ;
        par_cCorpo, par_cAnexo, par_cSmtpServer, par_nPorta, par_cUser, par_cSenha)
        LOCAL loc_lSucesso, loc_lCDOOK, loc_lEnvioOK, loc_oEmail
        loc_lSucesso = .F.
        loc_lCDOOK   = .T.
        loc_lEnvioOK = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') <> "O"
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel instanciar " + ;
                    "CDO.Message.", "Email")
                loc_lCDOOK = .F.
            ENDIF

            IF loc_lCDOOK
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = ;
                        LOWER(par_cSmtpServer)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = ;
                        IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = ;
                        LOWER(par_cUser)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = ;
                        IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cTo)
                    .Cc       = LOWER(NVL(par_cCC, ""))
                    .From     = LOWER(par_cFrom)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !ISNULL(par_cAnexo) AND !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOK = .F.
                            MsgAviso("Arquivo de anexo n" + CHR(227) + "o encontrado:" + ;
                                CHR(13) + par_cAnexo, "Anexo")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOK
                        TRY
                            .Send()
                            loc_lSucesso = .T.
                        CATCH TO loc_oErroSend
                            MsgErro("Falha ao enviar email: " + loc_oErroSend.Message, "Email")
                            loc_lSucesso = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro EnviarEmailCDO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEnvioEmails - Envia emails para todos os registros marcados
    * Percorre crLocalTotal (Checks=1), gera documento e envia por email
    * Retorna .T. se todos os emails foram enviados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEnvioEmails()
        LOCAL loc_lSucesso, loc_lTudoOK, loc_lConfigOK
        LOCAL loc_cReceptor, loc_cReceptorCC, loc_cAssunto, loc_cCorpo, loc_cArqAnexo
        LOCAL loc_cEdn, loc_nRec
        loc_lSucesso   = .F.
        loc_lTudoOK    = .T.
        loc_lConfigOK  = .T.
        loc_nRec       = 0
        loc_cReceptor  = ""
        loc_cReceptorCC = ""
        loc_cAssunto   = ""
        loc_cCorpo     = ""

        TRY
            *-- Obter configuracao SMTP da empresa
            IF !THIS.ObterConfigSMTP()
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel obter " + ;
                    "configura" + CHR(231) + CHR(227) + "o SMTP.", "Email")
                loc_lConfigOK = .F.
            ENDIF

            IF loc_lConfigOK
                *-- Cursor com registros marcados para envio
                IF USED("crLocalTotal2")
                    USE IN crLocalTotal2
                ENDIF
                SELECT * FROM crLocalTotal WHERE Checks = 1 INTO CURSOR crLocalTotal2 READWRITE

                SELECT crLocalTotal2
                GO TOP
                SCAN
                    IF EMPTY(ALLTRIM(crLocalTotal2.emails))
                        LOOP
                    ENDIF

                    *-- Flag por iteracao: erros nao bloqueiam movimentacoes subsequentes
                    LOCAL loc_lIterOK
                    loc_lIterOK = .T.

                    loc_nRec = loc_nRec + 1
                    loc_cEdn = ALLTRIM(crLocalTotal2.EmpDopNums)

                    *-- Primeiro registro = receptor principal; demais = copia
                    IF loc_nRec = 1
                        loc_cReceptor   = ALLTRIM(crLocalTotal2.emails)
                        loc_cCorpo      = ""
                        loc_cAssunto    = ""
                        loc_cReceptorCC = ""
                    ELSE
                        IF !EMPTY(ALLTRIM(crLocalTotal2.emails))
                            loc_cReceptorCC = loc_cReceptorCC + ;
                                IIF(EMPTY(loc_cReceptorCC), "", ",") + ;
                                ALLTRIM(crLocalTotal2.emails)
                        ENDIF
                    ENDIF

                    *-- Remover PDF anterior
                    IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
                        DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
                    ENDIF

                    *-- Gerar documento e PDF
                    IF !THIS.ImprimirDocumento(loc_cEdn)
                        loc_lIterOK = .F.
                        loc_lTudoOK = .F.
                    ENDIF

                    loc_cArqAnexo = THIS.this_cPcArqEmail

                    *-- Enviar email desta movimentacao
                    IF loc_lIterOK
                        IF !THIS.EnviarEmailCDO(;
                            THIS.this_cEmailFrom, ;
                            loc_cReceptor, ;
                            loc_cReceptorCC, ;
                            loc_cAssunto, ;
                            loc_cCorpo, ;
                            loc_cArqAnexo, ;
                            THIS.this_cSmtpServer, ;
                            THIS.this_nSmtpPorta, ;
                            THIS.this_cEmailFrom, ;
                            THIS.this_cSmtpSenha)
                            loc_lIterOK = .F.
                            loc_lTudoOK = .F.
                        ENDIF
                    ENDIF

                    *-- Registrar log apenas se esta iteracao foi bem-sucedida
                    IF loc_lIterOK
                        THIS.RegistrarLogEmail(loc_cEdn)
                    ENDIF

                    SELECT crLocalTotal2
                ENDSCAN

                IF USED("crLocalTotal2")
                    USE IN crLocalTotal2
                ENDIF

                THIS.this_lEnvioOk = loc_lTudoOK
                loc_lSucesso       = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro ProcessarEnvioEmails")
        ENDTRY

        RETURN loc_lSucesso AND loc_lTudoOK
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLogEmail - Registra envio de email em sigoplog
    * par_cEdn = EmpDopNums (C(29)) da movimentacao enviada
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLogEmail(par_cEdn)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO sigoplog (Transacaos, progs) VALUES (" + ;
                EscaparSQL(par_cEdn) + ", 'SIGPREMA')"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao registrar log de email para " + par_cEdn + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro RegistrarLogEmail")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra log de envio de email em sigoplog + auditoria
    * Chave usada: this_cEmpDopNums (populada por CarregarDoCursor ou FormParaBO)
    * Retorna .T. se INSERT bem-sucedido
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Chave EmpDopNums em branco - n" + CHR(227) + ;
                "o eh poss" + CHR(237) + "vel registrar log de email.", "Log")
            RETURN .F.
        ENDIF

        loc_cUsuario = LEFT(NVL(gc_4c_UsuarioLogado, "SIGPREMA"), 20)

        TRY
            loc_cSQL = "INSERT INTO sigoplog (" + ;
                "usuaredes, datars, horas, progs, opers, usuasis, " + ;
                "parametros, transacaos, cversaos, cidchaves, copias) VALUES (" + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                "'SIGPREMA', " + ;
                "'I', " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                "'', " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 100)) + ", " + ;
                "'', " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 20)) + ", " + ;
                "0)"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INCLUIR")
            ELSE
                MsgErro("Falha ao registrar log de email para " + ;
                    THIS.this_cEmpDopNums + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza log de envio de email em sigoplog + auditoria
    * Chave usada: this_cEmpDopNums (armazenada em cidchaves)
    * Retorna .T. se UPDATE bem-sucedido
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("Chave EmpDopNums em branco - n" + CHR(227) + ;
                "o eh poss" + CHR(237) + "vel atualizar log de email.", "Log")
            RETURN .F.
        ENDIF

        loc_cUsuario = LEFT(NVL(gc_4c_UsuarioLogado, "SIGPREMA"), 20)

        TRY
            loc_cSQL = "UPDATE sigoplog SET " + ;
                "datars = GETDATE(), " + ;
                "horas = " + EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                "opers = 'A', " + ;
                "usuaredes = " + EscaparSQL(loc_cUsuario) + ", " + ;
                "transacaos = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 100)) + " " + ;
                "WHERE progs = 'SIGPREMA' " + ;
                "AND cidchaves = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 20))
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("ALTERAR")
            ELSE
                MsgErro("Falha ao atualizar log de email para " + ;
                    THIS.this_cEmpDopNums + ".", "Log")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para string SQL Server
    * Retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples incluidas
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDatetimeSQL(par_tDt)
        LOCAL loc_cResult
        TRY
            loc_cResult = "'" + ;
                TRANSFORM(YEAR(par_tDt))             + "-" + ;
                PADL(TRANSFORM(MONTH(par_tDt)),  2, "0") + "-" + ;
                PADL(TRANSFORM(DAY(par_tDt)),    2, "0") + " " + ;
                PADL(TRANSFORM(HOUR(par_tDt)),   2, "0") + ":" + ;
                PADL(TRANSFORM(MINUTE(par_tDt)), 2, "0") + ":" + ;
                PADL(TRANSFORM(SEC(par_tDt)),    2, "0") + "'"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro FormatarDatetimeSQL")
            loc_cResult = "'2000-01-01 00:00:00'"
        ENDTRY
        RETURN loc_cResult
    ENDFUNC

ENDDEFINE

