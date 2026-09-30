# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, EMPDOPNUMS, DOPES, X, ACAOS, ICLIS, BAIXAS, JOBS, CHECKS, CEMPS, RCL

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEml.prg) - TRECHOS RELEVANTES PARA PASS SQL (884 linhas total):

*-- Linhas 281 a 332:
281:     ENDPROC
282: 
283:     *==========================================================================
284:     * ConfigurarGrid - Cria cursor_4c_Dados (equivalente a "Create Cursor
285:     * crLocalTotal" do Init legado) e o grd_4c_Dados (grade_alerta) com as
286:     * 5 colunas: Checks (checkbox), Contas, Rclis (Nome), Emails (editavel)
287:     * e Mensagem (editbox).
288:     * Original: grade_alerta (Top=132,Left=3,W=993,H=435,ColumnCount=5,
289:     *           FontName="Verdana",FontSize=8,RowHeight=18,RecordMark=.F.)
290:     *==========================================================================
291:     PROTECTED PROCEDURE ConfigurarGrid()
292:         LOCAL loc_oErro
293:         TRY
294:             THIS.CriarCursorDados()
295: 
296:             THIS.AddObject("grd_4c_Dados", "Grid")
297:             WITH THIS.grd_4c_Dados
298:                 .Top          = 132
299:                 .Left         = 3
300:                 .Width        = 993
301:                 .Height       = 435
302:                 .FontName     = "Verdana"
303:                 .FontSize     = 8
304:                 .RowHeight    = 18
305:                 .RecordMark   = .F.
306:                 .DeleteMark   = .F.
307:                 .ReadOnly     = .F.
308:                 .Visible      = .T.
309: 
310:                 .ColumnCount  = 5
311:                 .RecordSource = "cursor_4c_Dados"
312: 
313:                 .Column1.ControlSource = "cursor_4c_Dados.checks"
314:                 .Column2.ControlSource = "cursor_4c_Dados.contas"
315:                 .Column3.ControlSource = "cursor_4c_Dados.rclis"
316:                 .Column4.ControlSource = "cursor_4c_Dados.emails"
317:                 .Column5.ControlSource = "cursor_4c_Dados.mensagems"
318: 
319:                 *-- Column1 - Checks (fwcheckbox1 original, ColumnOrder=1, Width=17)
320:                 *-- Sparse=.F. garante checkbox visivel em TODAS as linhas (nao so na corrente)
321:                 .Column1.Width = 30
322:                 .Column1.AddObject("chk_4c_Check", "CheckBox")
323:                 WITH .Column1.chk_4c_Check
324:                     .Caption = ""
325:                     .Top     = 0
326:                     .Left    = 2
327:                     .Width   = 22
328:                     .Height  = 17
329:                     .Visible = .T.
330:                 ENDWITH
331:                 .Column1.CurrentControl = "chk_4c_Check"
332:                 .Column1.Sparse         = .F.

*-- Linhas 411 a 440:
411: 
412:     *==========================================================================
413:     * CriarCursorDados - Cria o cursor_4c_Dados (equivalente ao
414:     * "Create Cursor crLocalTotal (Checks N(1),grupos c(10),Contas c(10),
415:     * Rclis c(30),emails c(50),mensagems m,prioridade c(15),EmpDopNums c(29),
416:     * Acaos c(10))" + os 3 indices por Contas/Rclis/Emails do Init legado.
417:     * Rclis usa C(50) (nao C(30) como no legado) para bater com a largura
418:     * real de SigCdCli.rclis no schema e evitar truncamento de nome.
419:     *==========================================================================
420:     PROTECTED PROCEDURE CriarCursorDados()
421:         IF USED("cursor_4c_Dados")
422:             USE IN cursor_4c_Dados
423:         ENDIF
424: 
425:         CREATE CURSOR cursor_4c_Dados ( ;
426:             checks     N(1), ;
427:             grupos     C(10), ;
428:             contas     C(10), ;
429:             rclis      C(50), ;
430:             emails     C(50), ;
431:             mensagems  M, ;
432:             prioridade C(15), ;
433:             empdopnums C(29), ;
434:             acaos      C(10))
435: 
436:         INDEX ON contas TAG contas
437:         INDEX ON rclis  TAG rclis
438:         INDEX ON emails TAG emails
439:     ENDPROC
440: 

*-- Linhas 552 a 570:
552:     * ENUMERAVEL pelos gates do pipeline; verbo de negocio fora dele faz a
553:     * validacao reprovar um form correto. E eh fiel: este Click nao so
554:     * envia - ele monta a mensagem, GRAVA o historico em SigAlert
555:     * (Insert Into crSigAlert + Update/Commit no legado) e so entao
556:     * despacha pelo SMTP. O CONTROLE (cmd_4c_BtnEmail) segue com o nome do
557:     * meio de entrega e NAO muda, portanto mapeamento.json nao eh afetado.
558:     *==========================================================================
559:     PROCEDURE BtnProcessarEmailClick()
560:         LOCAL loc_oErro
561: 
562:         *-- Guarda de pre-acao. O RETURN fica FORA do TRY (regra #1 do
563:         *-- CLAUDE.md): ValidarEnvio ja exibiu o aviso do motivo.
564:         IF !THIS.ValidarEnvio()
565:             RETURN
566:         ENDIF
567: 
568:         TRY
569:             IF THIS.this_oBusinessObject.EnviarAlertasSelecionados()
570:                 WAIT WINDOW "Email enviado com sucesso!" TIMEOUT .02

*-- Linhas 592 a 610:
592:     *   3. Acao (pcEscolha)        - entra no WHERE do Init legado
593:     *                                (inserirs/alterars/excluirs) e no corpo
594:     *                                da mensagem ("Acao : " + pcescolha).
595:     *   4. Ao menos uma linha marcada - o legado monta "Select * From
596:     *                                crLocaltotal Where Checks = 1" e tira o
597:     *                                destinatario dela.
598:     *   5. E-mail da PRIMEIRA linha marcada - eh o destinatario (lcReceptor).
599:     *                                O legado guarda a lista de COPIA com
600:     *                                "If !Empty(Alltrim(...emails))", mas nao
601:     *                                guarda o destinatario principal.
602:     *
603:     * Devolve .T. quando pode enviar; .F. depois de avisar o motivo.
604:     * Preserva o registro corrente do cursor para nao mexer na grade.
605:     *==========================================================================
606:     PROCEDURE ValidarEnvio()
607:         LOCAL loc_lOk, loc_nRegAtual, loc_nMarcados, loc_cEmailReceptor
608:         LOCAL loc_oControleFoco
609:         loc_lOk            = .F.
610:         loc_nMarcados      = 0

*-- Linhas 636 a 654:
636:                 *-- Varre na ORDEM CORRENTE da grade (o SET ORDER TO TAG
637:                 *-- definido pelos Header1.Click), para que a "primeira linha
638:                 *-- marcada" seja a mesma que o BO usara como destinatario.
639:                 SELECT cursor_4c_Dados
640:                 loc_nRegAtual = RECNO("cursor_4c_Dados")
641: 
642:                 SCAN FOR cursor_4c_Dados.checks = 1
643:                     loc_nMarcados = loc_nMarcados + 1
644:                     IF loc_nMarcados = 1
645:                         loc_cEmailReceptor = ALLTRIM(TratarNulo(cursor_4c_Dados.emails, ""))
646:                     ENDIF
647:                 ENDSCAN
648: 
649:                 IF BETWEEN(loc_nRegAtual, 1, RECCOUNT("cursor_4c_Dados"))
650:                     GO loc_nRegAtual IN cursor_4c_Dados
651:                 ELSE
652:                     GO TOP IN cursor_4c_Dados
653:                 ENDIF
654: 

*-- Linhas 713 a 731:
713: 
714:         loc_cDigitado = ALLTRIM(TratarNulo(THIS.grd_4c_Dados.Column4.Text1.Value, ""))
715: 
716:         SELECT cursor_4c_Dados
717:         REPLACE emails WITH loc_cDigitado
718: 
719:         IF !EMPTY(loc_cDigitado) AND !("@" $ loc_cDigitado)
720:             MsgAviso("Endere" + CHR(231) + "o de e-mail inv" + CHR(225) + "lido: [" + ;
721:                 loc_cDigitado + "]." + CHR(13) + ;
722:                 "Um endere" + CHR(231) + "o de e-mail precisa conter o caractere @.", ;
723:                 "Processamento de Email")
724:         ENDIF
725: 
726:         THIS.grd_4c_Dados.Refresh()
727:     ENDPROC
728: 
729:     *==========================================================================
730:     * CarregarDados - Delega ao BO a montagem de cursor_4c_Dados e, em caso
731:     * de sucesso, atualiza a grade e o estado inicial de ordenacao (o legado

*-- Linhas 737 a 850:
737:         loc_lSucesso = .F.
738: 
739:         IF THIS.this_oBusinessObject.CarregarAlertas()
740:             SELECT cursor_4c_Dados
741:             GO TOP
742:             THIS.grd_4c_Dados.Refresh()
743:             THIS.HeaderRclisClick()
744:             loc_lSucesso = .T.
745:         ENDIF
746: 
747:         RETURN loc_lSucesso
748:     ENDPROC
749: 
750:     *==========================================================================
751:     * HeaderContasClick / HeaderRclisClick / HeaderEmailsClick - Reordena
752:     * cursor_4c_Dados pelo TAG correspondente e realca o header da coluna
753:     * ativa, igual aos 3 Header1.Click do grade_alerta legado.
754:     *==========================================================================
755:     PROCEDURE HeaderContasClick()
756:         IF USED("cursor_4c_Dados")
757:             SELECT cursor_4c_Dados
758:             SET ORDER TO TAG contas
759:         ENDIF
760:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
761:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
762:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
763:         THIS.grd_4c_Dados.Refresh()
764:     ENDPROC
765: 
766:     PROCEDURE HeaderRclisClick()
767:         IF USED("cursor_4c_Dados")
768:             SELECT cursor_4c_Dados
769:             SET ORDER TO TAG rclis
770:         ENDIF
771:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
772:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
773:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
774:         THIS.grd_4c_Dados.Refresh()
775:     ENDPROC
776: 
777:     PROCEDURE HeaderEmailsClick()
778:         IF USED("cursor_4c_Dados")
779:             SELECT cursor_4c_Dados
780:             SET ORDER TO TAG emails
781:         ENDIF
782:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
783:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
784:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
785:         THIS.grd_4c_Dados.Refresh()
786:     ENDPROC
787: 
788:     *==========================================================================
789:     * ChkCheckKeyPress/MouseUp/MouseDown/Click - CheckBox de coluna de Grid
790:     * nao alterna pelo binding nativo em VFP9 (licao Erro146/Pattern #185/
791:     * #186) - Click/MouseDown sao suprimidos com NODEFAULT e o toggle real
792:     * acontece no KeyPress (Enter/Espaco) e no MouseUp (que simula o mesmo
793:     * Enter). Equivalente ao "Replace Checks With this.Value in crLocalTotal"
794:     * do InteractiveChange original.
795:     *==========================================================================
796:     PROCEDURE ChkCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
797:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
798:             SELECT cursor_4c_Dados
799:             REPLACE checks WITH IIF(checks = 0, 1, 0)
800:             THIS.grd_4c_Dados.Refresh()
801:         ENDIF
802:         NODEFAULT
803:     ENDPROC
804: 
805:     PROCEDURE ChkCheckMouseUp(par_nButton, par_nShift, par_nCol, par_nRow)
806:         THIS.ChkCheckKeyPress(13, 0)
807:         NODEFAULT
808:     ENDPROC
809: 
810:     PROCEDURE ChkCheckMouseDown(par_nButton, par_nShift, par_nCol, par_nRow)
811:         NODEFAULT
812:     ENDPROC
813: 
814:     PROCEDURE ChkCheckClick()
815:         NODEFAULT
816:     ENDPROC
817: 
818:     *==========================================================================
819:     * BtnSelTudoClick / BtnApagaClick - Marcar Todos / Desmarcar Todos.
820:     * Original: Select crLocalTotal / Go top / Replace All Checks With 1|0 /
821:     *           Go Top / ThisForm.Refresh()
822:     *==========================================================================
823:     PROCEDURE BtnSelTudoClick()
824:         IF USED("cursor_4c_Dados")
825:             SELECT cursor_4c_Dados
826:             GO TOP
827:             REPLACE ALL checks WITH 1
828:             GO TOP
829:             THIS.grd_4c_Dados.Refresh()
830:         ENDIF
831:     ENDPROC
832: 
833:     PROCEDURE BtnApagaClick()
834:         IF USED("cursor_4c_Dados")
835:             SELECT cursor_4c_Dados
836:             GO TOP
837:             REPLACE ALL checks WITH 0
838:             GO TOP
839:             THIS.grd_4c_Dados.Refresh()
840:         ENDIF
841:     ENDPROC
842: 
843:     *==========================================================================
844:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
845:     * criados via AddObject (que nascem com Visible = .F.)
846:     *==========================================================================
847:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
848:         LOCAL loc_nI, loc_oObjeto, loc_nP
849: 
850:         FOR loc_nI = 1 TO par_oContainer.ControlCount


### BO (C:\4c\projeto\app\classes\SigPrEmlBO.prg):
*====================================================================
* SigPrEmlBO.prg
*
* Business Object para SigPrEml (Alerta - Envio de Email)
* Tabela: SigAlert (historico de alertas de email enviados)
* Chave: pkchaves char(20) - PK (fUniqueIds())
*
* Form OPERACIONAL chamado com parametros (par_cEmpDopNums, par_cEscolha,
* par_aOpeBaixa) por outras telas do sistema, para montar e enviar uma
* lista de emails de alerta referente a uma movimentacao (SigMvCab) e
* gravar o historico em SigAlert.
*
* Fonte da lista de emails:
*  - SigCdAle (parametrizacao de alerta por grupo/conta) filtrado pelo
*    Dopes da movimentacao e pela acao (INSERIR/ALTERAR/EXCLUIR)
*  - SigCdCli (contas do grupo padrao em SigCdPam.GrPadAts), quando a
*    conta ainda nao estiver na lista acima
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrEmlBO AS BusinessBase

    *-- Contexto recebido do chamador (equivalente aos parametros do
    *-- Init() do form legado: prDopes, pcEscolha, laOpeBaixa)
    this_cEmpDopNumsOrigem = ""    && par_cEmpDopNums recebido (emp+dopes+num, 29 chars)
    this_cLcEmp            = ""    && Substr(EmpDopNumsOrigem, 1, 3)  - empresa
    this_cLcDopes          = ""    && Substr(EmpDopNumsOrigem, 4, 20) - operacao (Dopes)
    this_cEscolha          = ""    && "INSERIR", "ALTERAR" ou "EXCLUIR"
    this_aOpeBaixa         = .NULL. && par_aOpeBaixa recebido (array de EmpDopNums de operacoes de baixa, opcional)

    *-- Propriedades da entidade (mapeamento para tabela SigAlert)
    this_cPkChaves    = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cAcaos       = ""    && acaos char(10) - acao que originou o alerta
    this_cContas      = ""    && contas char(10) - FK SigCdCli.Iclis (destinatario)
    this_cDopes       = ""    && dopes char(20) - FK SigCdOpe.Dopes
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave da movimentacao (emp+dopes+num)
    this_cEmps        = ""    && cemps char(3) - FK SigCdEmp.Cemps
    this_cGrupos      = ""    && grupos char(10) - grupo do destinatario
    this_cMsg1s       = ""    && msg1s text - mensagem enviada ao destinatario principal
    this_cMsg2s       = ""    && msg2s text - mensagem enviada aos destinatarios em copia
    this_nNumes       = 0     && numes numeric(6,0) - numero sequencial da movimentacao
    this_nPriors      = 0     && priors numeric(1,0) - prioridade (1=URGENTE,2=IMPORTANTE,demais=NORMAL)
    this_dDtAlerts    = {}    && dtalerts datetime - data/hora do alerta
    this_dDtAlert2s   = {}    && dtalert2s datetime - data/hora do alerta (baixa/complementar)
    this_cUsualerts   = ""    && usualerts char(10) - usuario que gerou o alerta
    this_cUsuars      = ""    && usuars char(10) - usuario logado (auditoria)

    *-- Propriedades de apoio para envio (NAO persistidas em SigAlert;
    *-- vem do cadastro da empresa - SigCdEmp.AleServs/AleEmails/AleSenhas/AlePortas)
    this_cEmailFrom   = ""    && email remetente (SigCdEmp.AleEmails)
    this_cSmtpServer  = ""    && servidor SMTP (SigCdEmp.AleServs)
    this_cSmtpSenha   = ""    && senha SMTP (SigCdEmp.AleSenhas)
    this_nSmtpPorta   = 0     && porta SMTP (SigCdEmp.AlePortas)

    *-- Dados da movimentacao de origem (equivalente ao cursor TmpMvCab do
    *-- legado) - carregados por CarregarAlertas() e usados tanto no filtro
    *-- de contas por Job (SigClJob) quanto na composicao do texto do email
    this_cMovJobs        = ""    && TmpMvCab.Jobs
    this_cMovRclis       = ""    && TmpMvCab.Rclis (nome do cliente do Job)
    this_cMovObsCabMovs  = ""    && TmpMvCab.ObsCabMovs
    this_cMovObses       = ""    && TmpMvCab.Obses (memo)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigAlert"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrEmlBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor (SELECT * FROM SigAlert)
    * para as propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChaves   = TratarNulo(pkchaves, "")
            THIS.this_cAcaos      = TratarNulo(acaos, "")
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cMsg1s      = TratarNulo(msg1s, "")
            THIS.this_cMsg2s      = TratarNulo(msg2s, "")
            THIS.this_nNumes      = TratarNulo(numes, 0)
            THIS.this_nPriors     = TratarNulo(priors, 0)
            THIS.this_dDtAlerts   = TratarNulo(dtalerts, {})
            THIS.this_dDtAlert2s  = TratarNulo(dtalert2s, {})
            THIS.this_cUsualerts  = TratarNulo(usualerts, "")
            THIS.this_cUsuars     = TratarNulo(usuars, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigAlert
    *
    * SigAlert eh tabela de HISTORICO (todas as 15 colunas NOT NULL, sem
    * DEFAULT - ver docs/schema.sql). O legado grava um registro por
    * destinatario dentro do Scan de btnEmail.Click (Scatter Memo Memvar +
    * Insert Into crSigAlert From Memvar), preenchendo pkchaves/emps/dopes/
    * numes/dtalerts/msg1s/usuars na hora - por isso os guards abaixo
    * replicam esse preenchimento quando o chamador nao setou a property.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- pkchaves eh a PK Fortyus (fUniqueIds()) - nunca pode ir vazia,
            *-- senao o proximo registro colide no indice unico (regra #22).
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            *-- dtalerts eh a data/hora do alerta - equivalente a m.DtAlerts =
            *-- Datetime() no legado. Sem valor explicito, usa o instante atual.
            IF EMPTY(THIS.this_dDtAlerts)
                THIS.this_dDtAlerts = DATETIME()
            ENDIF

            *-- usualerts/usuars = usuario logado (auditoria), igual ao legado
            *-- (m.Usuars = m.Usuar), quando o chamador nao informou outro valor.
            IF EMPTY(THIS.this_cUsualerts)
                THIS.this_cUsualerts = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF

            loc_cSQL = "INSERT INTO SigAlert" + ;
                       " (pkchaves, acaos, contas, dopes, empdopnums, emps, grupos," + ;
                       " msg1s, msg2s, numes, priors, dtalerts, dtalert2s, usualerts, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cPkChaves) + "," + ;
                       EscaparSQL(THIS.this_cAcaos) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       EscaparSQL(THIS.this_cDopes) + "," + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cGrupos) + "," + ;
                       EscaparSQL(THIS.this_cMsg1s) + "," + ;
                       EscaparSQL(THIS.this_cMsg2s) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                       FormatarDataSQL(THIS.this_dDtAlerts) + "," + ;
                       IIF(EMPTY(THIS.this_dDtAlert2s), "'19000101'", FormatarDataSQL(THIS.this_dDtAlert2s)) + "," + ;
                       EscaparSQL(THIS.this_cUsualerts) + "," + ;
                       EscaparSQL(THIS.this_cUsuars) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao gravar alerta de e-mail:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar alerta de e-mail:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigAlert (complemento de baixa/reenvio)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cPkChaves)
            THIS.this_cMensagemErro = "Chave do alerta n" + CHR(227) + "o informada para atualiza" + CHR(231) + CHR(227) + "o."
            MsgErro(THIS.this_cMensagemErro, "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigAlert SET" + ;
                       " acaos = " + EscaparSQL(THIS.this_cAcaos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " msg1s = " + EscaparSQL(THIS.this_cMsg1s) + "," + ;
                       " msg2s = " + EscaparSQL(THIS.this_cMsg2s) + "," + ;
                       " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + "," + ;
                       " priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + "," + ;
                       " dtalert2s = " + IIF(EMPTY(THIS.this_dDtAlert2s), "'19000101'", FormatarDataSQL(THIS.this_dDtAlert2s)) + "," + ;
                       " usualerts = " + EscaparSQL(THIS.this_cUsualerts) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar alerta de e-mail:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar alerta de e-mail:" + CHR(13) + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAlertas - Monta a lista de destinatarios do alerta em
    * cursor_4c_Dados (equivalente ao "Create Cursor crLocalTotal" + as
    * queries que o alimentam no Init() do legado):
    *   1) TmpMvCab - dados da movimentacao (SigMvCab + Job em SigCdCli)
    *   2) crLocalALE - SigCdAle parametrizado para o Dopes/acao, filtrado
    *      por conta pertencer ao Job da movimentacao (SigClJob)
    *   3) crLocalPAM - contas do grupo padrao (SigCdPam.GrPadAts), quando
    *      ainda nao estiverem na lista acima (dedup por Contas+Rclis)
    *
    * Tambem monta (via MontarCascataBaixa) o cursor_4c_OpeBaixa da
    * cascata de laOpeBaixa do legado - esse cursor NAO alimenta a
    * grade, so o envio de email (EnviarCascataBaixa, chamado de
    * EnviarAlertasSelecionados).
    *
    * Pre-requisito: FormSigPrEml.ConfigurarGrid() ja criou o cursor
    * cursor_4c_Dados (CREATE CURSOR) antes de chamar este metodo.
    *====================================================================
    FUNCTION CarregarAlertas()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado, loc_cFlagCampo, loc_lCascataOk
        loc_lSucesso  = .F.
        loc_lCascataOk = .T.

        TRY
            *-- 1) Dados da movimentacao (equivalente a TmpMvCab do legado)
            loc_cSQL = "SELECT a.jobs AS jobs, a.obscabmovs AS obscabmovs," + ;
                       " a.obses AS obses, b.rclis AS rclis" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigCdCli b ON a.jobs = b.iclis" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cEmpDopNumsOrigem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab")
            IF loc_nResultado < 0 OR !USED("cursor_4c_TmpMvCab") OR RECCOUNT("cursor_4c_TmpMvCab") = 0
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (TmpMvCab)", "Erro")
            ELSE
                SELECT cursor_4c_TmpMvCab
                THIS.this_cMovJobs       = TratarNulo(jobs, "")
                THIS.this_cMovRclis      = TratarNulo(rclis, "")
                THIS.this_cMovObsCabMovs = TratarNulo(obscabmovs, "")
                THIS.this_cMovObses      = TratarNulo(obses, "")

                DO CASE
                    CASE THIS.this_cEscolha = "INSERIR"
                        loc_cFlagCampo = "inserirs"
                    CASE THIS.this_cEscolha = "ALTERAR"
                        loc_cFlagCampo = "alterars"
                    CASE THIS.this_cEscolha = "EXCLUIR"
                        loc_cFlagCampo = "excluirs"
                    OTHERWISE
                        loc_cFlagCampo = ""
                ENDCASE

                *-- Cascata de baixa (laOpeBaixa) - equivalente ao bloco
                *-- "If Type([laOpeBaixa],1) = [A] ... Endif" do Init legado
                *-- (linhas 561-615). Nao alimenta a grade (cursor_4c_Dados) -
                *-- monta cursor_4c_OpeBaixa, consumido so por
                *-- EnviarCascataBaixa() no envio do e-mail. Erro ja avisado
                *-- dentro de MontarCascataBaixa (regra #9 - CATCH nunca
                *-- silencioso); aqui so propaga a falha, igual ao Return .F.
                *-- do legado quando qualquer consulta da cascata falha.
                loc_lCascataOk = THIS.MontarCascataBaixa()

                *-- 2) Alertas parametrizados em SigCdAle para o Dopes/acao
                loc_cSQL = "SELECT ale.grupos AS grupos, ale.contas AS contas," + ;
                           " cli.rclis AS rclis, cli.emails AS emails, ale.mensagems AS mensagems," + ;
                           " CASE WHEN ale.priors = 1 THEN 'URGENTE' WHEN ale.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade" + ;
                           " FROM SigCdAle ale" + ;
                           " INNER JOIN SigCdCli cli ON ale.contas = cli.iclis" + ;
                           " WHERE ale.dopes = " + EscaparSQL(THIS.this_cLcDopes) + ;
                           IIF(!EMPTY(loc_cFlagCampo), " AND ale." + loc_cFlagCampo + " = 1", "")

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpAle")
                IF loc_nResultado < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crLocal)", "Erro")
                ELSE
                    IF USED("cursor_4c_TmpAle") AND RECCOUNT("cursor_4c_TmpAle") > 0
                        SELECT cursor_4c_TmpAle
                        SCAN
                            IF THIS.ContaPertenceAoJob(cursor_4c_TmpAle.contas)
                                INSERT INTO cursor_4c_Dados (checks, grupos, contas, rclis, emails, mensagems, prioridade, empdopnums, acaos) ;
                                    VALUES (1, cursor_4c_TmpAle.grupos, cursor_4c_TmpAle.contas, cursor_4c_TmpAle.rclis, ;
                                            cursor_4c_TmpAle.emails, NVL(cursor_4c_TmpAle.mensagems, ""), cursor_4c_TmpAle.prioridade, ;
                                            THIS.this_cEmpDopNumsOrigem, THIS.this_cEscolha)
                            ENDIF
                            SELECT cursor_4c_TmpAle
                        ENDSCAN
                    ENDIF

                    *-- 3) Contas do grupo padrao (SigCdPam.GrPadAts), quando
                    *-- ainda nao estiverem na lista acima
                    loc_cSQL = "SELECT cli.grupos AS grupos, cli.iclis AS contas," + ;
                               " cli.rclis AS rclis, cli.emails AS emails" + ;
                               " FROM SigCdPam pam" + ;
                               " INNER JOIN SigCdCli cli ON cli.grupos = pam.grpadats"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPam")
                    IF loc_nResultado < 0
                        MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crLocal)", "Erro")
                    ELSE
                        IF USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
                            SELECT cursor_4c_TmpPam
                            SCAN
                                IF THIS.ContaPertenceAoJob(cursor_4c_TmpPam.contas)
                                    SELECT cursor_4c_Dados
                                    LOCATE FOR ALLTRIM(contas) == ALLTRIM(cursor_4c_TmpPam.contas) AND ;
                                               ALLTRIM(rclis) == ALLTRIM(cursor_4c_TmpPam.rclis)
                                    IF EOF("cursor_4c_Dados")
                                        INSERT INTO cursor_4c_Dados (checks, grupos, contas, rclis, emails, empdopnums, acaos, prioridade) ;
                                            VALUES (0, "", cursor_4c_TmpPam.contas, cursor_4c_TmpPam.rclis, cursor_4c_TmpPam.emails, ;
                                                    THIS.this_cEmpDopNumsOrigem, THIS.this_cEscolha, "NORMAL")
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_TmpPam
                            ENDSCAN
                        ENDIF

                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = loc_lCascataOk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAlertas")
        ENDTRY

        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_TmpAle")
            USE IN cursor_4c_TmpAle
        ENDIF
        IF USED("cursor_4c_TmpPam")
            USE IN cursor_4c_TmpPam
        ENDIF
        IF USED("cursor_4c_TmpClJob")
            USE IN cursor_4c_TmpClJob
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ContaPertenceAoJob - Replica o filtro do legado que PULA a conta
    * quando ela tem Jobs cadastrados em SigClJob mas NENHUM deles bate
    * com o Job da movimentacao de origem. Equivalente a:
    *   Select Jobs From SigClJob Where Iclis = <conta>
    *   Select TmpClJob / Go top
    *   If !Eof()
    *       Locate For Jobs = TmpMvCab.Jobs
    *       If Eof()
    *           Loop   && pula a conta
    *       Endif
    *   Endif
    * Conta SEM nenhum Job cadastrado (TmpClJob vazio) NAO eh pulada -
    * o filtro por Job so se aplica a quem tem Job restrito.
    *====================================================================
    PROTECTED FUNCTION ContaPertenceAoJob(par_cContas)
        LOCAL loc_lPertence, loc_nResultado
        loc_lPertence = .T.

        loc_nResultado = SQLEXEC(gnConnHandle, "SELECT jobs FROM SigClJob WHERE iclis = " + EscaparSQL(par_cContas), "cursor_4c_TmpClJob")

        IF loc_nResultado >= 0 AND USED("cursor_4c_TmpClJob") AND RECCOUNT("cursor_4c_TmpClJob") > 0
            SELECT cursor_4c_TmpClJob
            LOCATE FOR ALLTRIM(jobs) == ALLTRIM(THIS.this_cMovJobs)
            loc_lPertence = !EOF("cursor_4c_TmpClJob")
        ENDIF

        RETURN loc_lPertence
    ENDFUNC

    *====================================================================
    * MontarCascataBaixa - Monta cursor_4c_OpeBaixa a partir do array
    * this_aOpeBaixa (par_aOpeBaixa recebido pelo form) - equivalente ao
    * bloco "If Type([laOpeBaixa],1) = [A] ... Endif" do Init() legado
    * (linhas 561-615 do fonte original):
    *   1) tenta achar, em SigAlert, um alerta de baixa JA enviado para
    *      alguma das movimentacoes do array (Acaos = 'BAIXAR') e o
    *      enriquece com email/prioridade/mensagem atuais de SigCdCli/
    *      SigCdAle;
    *   2) se nao achar nenhum (Reccount = 0), monta do zero a partir de
    *      SigCdAle/SigCdCli (baixas = 1) e amarra o EmpDopNums de cada
    *      linha ao item correspondente do array (por Dopes).
    *
    * cursor_4c_OpeBaixa alimenta SO o envio de email complementar
    * (EnviarCascataBaixa) - nao entra na grade de selecao
    * (cursor_4c_Dados). Se this_aOpeBaixa nao for array (uso normal,
    * sem baixa em cascata), nao ha nada a fazer.
    *====================================================================
    PROTECTED FUNCTION MontarCascataBaixa()
        LOCAL loc_lSucesso, loc_nResultado, loc_nX, loc_cItem, loc_cDope, loc_cEDN
        LOCAL loc_cSQL, loc_cContas, loc_cDopes

        loc_lSucesso = .T.

        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF

        IF VARTYPE(THIS.this_aOpeBaixa) = "A"
            loc_cDope = ""
            loc_cEDN  = ""

            FOR loc_nX = 1 TO ALEN(THIS.this_aOpeBaixa)
                loc_cItem = TratarNulo(THIS.this_aOpeBaixa(loc_nX), "")
                IF !EMPTY(loc_cItem)
                    loc_cDope = loc_cDope + IIF(EMPTY(loc_cDope), "('", ",'") + ALLTRIM(SUBSTR(loc_cItem, 4, 20)) + "'"
                    loc_cEDN  = loc_cEDN  + IIF(EMPTY(loc_cEDN), "('", ",'") + ALLTRIM(loc_cItem) + "'"
                ENDIF
            ENDFOR

            IF !EMPTY(loc_cDope)
                loc_cDope = loc_cDope + ")"
                loc_cEDN  = loc_cEDN  + ")"

                *-- 1) Alerta de baixa ja enviado para alguma dessas movimentacoes
                IF USED("cursor_4c_TmpOpeBaixa")
                    USE IN cursor_4c_TmpOpeBaixa
                ENDIF

                loc_cSQL = "SELECT TOP 1 contas AS contas, acaos AS acaos, empdopnums AS empdopnums," + ;
                           " emps AS emps, dopes AS dopes, numes AS numes, SPACE(50) AS emails," + ;
                           " SPACE(15) AS prioridade, msg1s AS mensagems, 1 AS checks" + ;
                           " FROM SigAlert WHERE empdopnums IN " + loc_cEDN + " AND acaos = 'BAIXAR'"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeBaixa")
                IF loc_nResultado < 0
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crOpeBaixa)", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    SELECT * FROM cursor_4c_TmpOpeBaixa INTO CURSOR cursor_4c_OpeBaixa READWRITE
                    USE IN cursor_4c_TmpOpeBaixa

                    IF RECCOUNT("cursor_4c_OpeBaixa") > 0
                        *-- Enriquece com email/prioridade/mensagem atuais do destinatario
                        SELECT cursor_4c_OpeBaixa
                        SCAN
                            loc_cContas = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.contas, ""))
                            loc_cDopes  = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.dopes, ""))

                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            loc_cSQL = "SELECT a.emails AS emails," + ;
                                       " CASE WHEN b.priors = 1 THEN 'URGENTE' WHEN b.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade," + ;
                                       " b.mensagems AS mensagems" + ;
                                       " FROM SigCdCli a INNER JOIN SigCdAle b ON a.iclis = b.contas" + ;
                                       " WHERE a.iclis = " + EscaparSQL(loc_cContas) + " AND b.dopes = " + EscaparSQL(loc_cDopes)

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            IF loc_nResultado < 0
                                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (TmpCli)", "Erro")
                                loc_lSucesso = .F.
                            ELSE
                                IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                    SELECT cursor_4c_TmpCli
                                    GO TOP
                                    SELECT cursor_4c_OpeBaixa
                                    REPLACE emails WITH cursor_4c_TmpCli.emails, ;
                                            prioridade WITH cursor_4c_TmpCli.prioridade, ;
                                            mensagems WITH cursor_4c_TmpCli.mensagems
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            SELECT cursor_4c_OpeBaixa
                        ENDSCAN
                    ENDIF

                    *-- 2) Nao achou alerta de baixa anterior - monta do zero a
                    *-- partir de SigCdAle/SigCdCli e amarra o EmpDopNums de
                    *-- cada linha do array (por Dopes)
                    IF loc_lSucesso AND RECCOUNT("cursor_4c_OpeBaixa") = 0
                        IF USED("cursor_4c_TmpOpeBaixa2")
                            USE IN cursor_4c_TmpOpeBaixa2
                        ENDIF

                        loc_cSQL = "SELECT 1 AS checks, ale.grupos AS grupos, ale.contas AS contas," + ;
                                   " cli.rclis AS rclis, cli.emails AS emails, ale.mensagems AS mensagems," + ;
                                   " CASE WHEN ale.priors = 1 THEN 'URGENTE' WHEN ale.priors = 2 THEN 'IMPORTANTE' ELSE 'NORMAL' END AS prioridade," + ;
                                   " ale.dopes AS dopes, SPACE(29) AS empdopnums, " + EscaparSQL(THIS.this_cEscolha) + " AS acaos" + ;
                                   " FROM SigCdAle ale" + ;
                                   " INNER JOIN SigCdCli cli ON ale.contas = cli.iclis" + ;
                                   " WHERE ale.dopes IN " + loc_cDope + " AND ale.baixas = 1"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpeBaixa2")
                        IF loc_nResultado < 0
                            MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + "Falha na Conex" + CHR(227) + "o (crOpeBaixa)", "Erro")
                            loc_lSucesso = .F.
                        ELSE
                            IF USED("cursor_4c_OpeBaixa")
                                USE IN cursor_4c_OpeBaixa
                            ENDIF
                            SELECT * FROM cursor_4c_TmpOpeBaixa2 INTO CURSOR cursor_4c_OpeBaixa READWRITE
                            USE IN cursor_4c_TmpOpeBaixa2

                            IF RECCOUNT("cursor_4c_OpeBaixa") > 0
                                FOR loc_nX = 1 TO ALEN(THIS.this_aOpeBaixa)
                                    loc_cItem = TratarNulo(THIS.this_aOpeBaixa(loc_nX), "")
                                    IF !EMPTY(loc_cItem)
                                        SELECT cursor_4c_OpeBaixa
                                        GO TOP
                                        REPLACE ALL empdopnums WITH ALLTRIM(loc_cItem) ;
                                            FOR ALLTRIM(dopes) == ALLTRIM(SUBSTR(loc_cItem, 4, 20))
                                    ENDIF
                                ENDFOR
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDadosContaEmail - Busca a conta de e-mail de ALERTA (SMTP)
    * parametrizada para a empresa em SigCdEmp.AleEmails/AleServs/
    * AleSenhas/AlePortas (equivalente a consulta LocalEmp do legado:
    * "Select AleServs, AleEmails, AleSenhas, AlePortas From SigCdEmp
    * Where CEmps = <lcEmp>"). Popula this_cEmailFrom/this_cSmtpServer/
    * this_cSmtpSenha/this_nSmtpPorta.
    *====================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT AleServs, AleEmails, AleSenhas, AlePortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (LocalEmp)", "Erro")
            ELSE
                SELECT cursor_4c_TmpEmpMail
                GO TOP
                IF !EOF()
                    THIS.this_cEmailFrom  = ALLTRIM(TratarNulo(AleEmails, ""))
                    THIS.this_cSmtpServer = ALLTRIM(TratarNulo(AleServs, ""))
                    THIS.this_cSmtpSenha  = ALLTRIM(TratarNulo(AleSenhas, ""))
                    THIS.this_nSmtpPorta  = NVL(AlePortas, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ObterDadosContaEmail")
        ENDTRY

        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * EnviarEmailSmtp - Dispara o envio via CDO.Message (SMTP).
    *
    * DE ONDE VEM ESTE CORPO: o btnEmail.Click legado (linhas 881 e 941 do
    * fonte original) chama a funcao GLOBAL EnviaEmail(...), que NAO veio
    * no acervo (nao esta em Framework\sigacess.PRG nem em lugar nenhum
    * do dump). A melhor evidencia disponivel do que essa funcao faz eh o
    * PROCEDURE memail do SCX irmao SIGPREMA (sigpremaBO.prg), que
    * implementa a mesma rotina via CDO.Message - transcrita aqui com os
    * nomes de propriedade desta BO. Por isso NAO se cria wrapper
    * generico em utils\ (regra #27 do CLAUDE.md): a chamada mora no
    * codigo do FORM que estamos migrando, e este metodo a substitui.
    *
    * De-para dos argumentos, conferido contra a chamada legada
    * EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom,
    *            lcReceptorCopia, lcServer, lcSenha, lnPorta):
    *   lcReceptor      -> par_cPara        lcFrom   -> par_cRemetente
    *   lcReceptorCopia -> par_cCopia       lcServer -> par_cServidor
    *   lcAssunto       -> par_cAssunto     lcSenha  -> par_cSenha
    *   lcTxtMensagem   -> par_cCorpo       lnPorta  -> par_nPorta
    *   lcArqAnexo      -> par_cAnexo
    *
    * Retorna .T. se o e-mail foi enviado com sucesso.
    *====================================================================
    PROCEDURE EnviarEmailSmtp(par_cPara, par_cCopia, par_cAssunto, par_cCorpo, ;
                              par_cAnexo, par_cRemetente, par_cServidor, ;
                              par_cSenha, par_nPorta)
        LOCAL loc_lOk, loc_lEnvioOk, loc_oEmail, loc_oErro, loc_oErroEnvio

        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') != "O"
                MsgAviso("Problemas para instanciar o objeto CDO.Message.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")            = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")            = LOWER(par_cServidor)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")        = IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")      = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")          = LOWER(par_cRemetente)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")          = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")            = IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cPara)
                    .Cc       = LOWER(NVL(par_cCopia, ""))
                    .From     = LOWER(par_cRemetente)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("N" + CHR(227) + "o foi encontrado o arquivo:" + CHR(13) + ;
                                     par_cAnexo + CHR(13) + "para ser anexado.", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            *-- O legado tambem nao fica calado aqui: o Catch
                            *-- do PROCEDURE memail (SIGPREMA) avisa com
                            *-- Wait Window "Dados do e-mail invalidos."
                            *-- TimeOut 5 - transcrito para manter o aviso
                            *-- sem travar o processamento (CLAUDE.md #9:
                            *-- CATCH nunca silencioso).
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em EnviarEmailSmtp")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *====================================================================
    * EnviarCascataBaixa - Envia o e-mail complementar de "baixa" (quando
    * o form foi aberto com laOpeBaixa) e grava o historico correspondente
    * em SigAlert com Acaos = 'BAIXAR' - equivalente ao trecho
    * "If llOk And Used([CrOpeBaixa]) ... Endif" do btnEmail.Click legado
    * (linhas 887-946 do fonte original). So deve ser chamado quando o
    * envio principal (EnviarAlertasSelecionados) deu certo. Se
    * MontarCascataBaixa nao populou cursor_4c_OpeBaixa (uso normal, sem
    * baixa em cascata), nao ha nada a enviar e retorna .T. (equivalente
    * a "Used([CrOpeBaixa])" ser falso no legado).
    *====================================================================
    PROTECTED FUNCTION EnviarCascataBaixa()
        LOCAL loc_lOk, loc_lTodasGravacoesOk
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
        LOCAL loc_cEmpDopNumsBaixa

        loc_lOk = .T.

        IF USED("cursor_4c_OpeBaixa") AND RECCOUNT("cursor_4c_OpeBaixa") > 0
            loc_cReceptor         = ""
            loc_cReceptorCopia    = ""
            loc_cAssunto          = "ALERTA"
            loc_cTxtMensagem      = ""
            loc_lTodasGravacoesOk = .T.

            SELECT cursor_4c_OpeBaixa
            GO TOP
            SCAN
                loc_cEmpDopNumsBaixa = TratarNulo(cursor_4c_OpeBaixa.empdopnums, "")

                IF RECNO() = 1
                    loc_cReceptor    = ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.emails, ""))
                    loc_cTxtMensagem = ;
                        IIF(!EMPTY(THIS.this_cMovJobs), "JOB          : " + THIS.this_cMovJobs + " - " + ALLTRIM(THIS.this_cMovRclis) + CHR(13) + CHR(10), "") + ;
                        IIF(!EMPTY(THIS.this_cMovObsCabMovs), "Descritivo : " + ALLTRIM(THIS.this_cMovObsCabMovs) + CHR(13) + CHR(10), "") + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o : " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 1, 3) + " / " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 4, 20) + " / " + SUBSTR(THIS.this_cEmpDopNumsOrigem, 24, 6) + CHR(13) + CHR(10) + ;
                        "A" + CHR(231) + CHR(227) + "o         : " + THIS.this_cEscolha + CHR(13) + CHR(10) + ;
                        "Movimenta" + CHR(231) + CHR(227) + "o baixada " + IIF(THIS.this_cEscolha = "EXCLUIR", "cancelada ", "") + ": " + ;
                            SUBSTR(loc_cEmpDopNumsBaixa, 1, 3) + " / " + SUBSTR(loc_cEmpDopNumsBaixa, 4, 20) + " / " + SUBSTR(loc_cEmpDopNumsBaixa, 24, 6) + CHR(13) + CHR(10) + ;
                        "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                        "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
                        IIF(!EMPTY(TratarNulo(cursor_4c_OpeBaixa.mensagems, "")), "Mensagem     : " + ALLTRIM(cursor_4c_OpeBaixa.mensagems) + CHR(13) + CHR(10), "") + ;
                        IIF(!EMPTY(THIS.this_cMovObses), "Observa" + CHR(231) + CHR(227) + "o   : " + ALLTRIM(THIS.this_cMovObses), "")

                    loc_cAssunto = "ALERTA - " + ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.prioridade, ""))
                ELSE
                    IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_OpeBaixa.emails, "")))
                        loc_cReceptorCopia = loc_cReceptorCopia + ;
                            IIF(EMPTY(loc_cReceptorCopia), "", ",") + ALLTRIM(cursor_4c_OpeBaixa.emails)
                    ENDIF
                ENDIF

                *-- Historico do alerta de baixa - um registro em SigAlert por
                *-- destinatario, Acaos sempre 'BAIXAR' (equivalente ao
                *-- Scatter Memo Memvar + m.Acaos = [BAIXAR] + Insert Into
                *-- crSigAlert do legado)
                THIS.this_cPkChaves   = ""
                THIS.this_dDtAlerts   = DATETIME()
                THIS.this_cMsg1s      = loc_cTxtMensagem
                THIS.this_cMsg2s      = ""
                THIS.this_cAcaos      = "BAIXAR"
                THIS.this_cContas     = TratarNulo(cursor_4c_OpeBaixa.contas, "")
                THIS.this_cGrupos     = ""
                THIS.this_cEmpDopNums = loc_cEmpDopNumsBaixa
                THIS.this_cEmps       = SUBSTR(loc_cEmpDopNumsBaixa, 1, 3)
                THIS.this_cDopes      = SUBSTR(loc_cEmpDopNumsBaixa, 4, 20)
                THIS.this_nNumes      = VAL(SUBSTR(loc_cEmpDopNumsBaixa, 24, 6))
                THIS.this_nPriors     = 0
                THIS.this_dDtAlert2s  = {}
                THIS.this_cUsualerts  = gc_4c_UsuarioLogado
                THIS.this_cUsuars     = gc_4c_UsuarioLogado

                IF !THIS.Inserir()
                    loc_lTodasGravacoesOk = .F.
                ENDIF

                SELECT cursor_4c_OpeBaixa
            ENDSCAN

            WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR
            loc_lOk = THIS.EnviarEmailSmtp(loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, ;
                loc_cTxtMensagem, "", THIS.this_cEmailFrom, THIS.this_cSmtpServer, ;
                THIS.this_cSmtpSenha, THIS.this_nSmtpPorta)
            WAIT CLEAR

            loc_lOk = (loc_lOk AND loc_lTodasGravacoesOk)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *====================================================================
    * EnviarAlertasSelecionados - Envia o e-mail de alerta para os
    * destinatarios marcados (Checks = 1) em cursor_4c_Dados e grava o
    * historico correspondente em SigAlert - equivalente ao PROCEDURE
    * Click do btnEmail legado (linhas 820-885 e 948-959 do fonte
    * original).
    *
    * Depois do envio principal, chama EnviarCascataBaixa() - equivalente
    * ao trecho "If llOk And Used([CrOpeBaixa]) ... Endif" do legado
    * (linhas 887-946), que so faz algo quando o form foi aberto com
    * laOpeBaixa e MontarCascataBaixa (chamado por CarregarAlertas) achou
    * o que enviar.
    *
    * O legado grava o historico (Insert Into crSigAlert from Memvar) num
    * cursor LOCAL e so confirma tudo (thisform.podatamgr2.Update +
    * Commit) depois do envio do e-mail dar certo, com Rollback se a
    * gravacao falhar. Aqui THIS.Inserir() ja manda cada INSERT para o
    * SQL Server na hora (regra desta arquitetura); o SQLCOMMIT/
    * SQLROLLBACK no final reproduz a mesma fronteira transacional (a
    * conexao nasce em modo manual - Transactions=2).
    *
    * Retorna .T. se o envio E a gravacao do historico tiveram sucesso.
    *====================================================================
    FUNCTION EnviarAlertasSelecionados()
        LOCAL loc_lOk, loc_lTodasGravacoesOk, loc_oErro
        LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, loc_cTxtMensagem
        LOCAL loc_cEmpDopNums

        loc_lOk = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Nenhum dado carregado para envio.", "Processamento de Email")
            ELSE
                IF USED("cursor_4c_Selecionados")
                    USE IN cursor_4c_Selecionados
                ENDIF

                SELECT * FROM cursor_4c_Dados WHERE checks = 1 INTO CURSOR cursor_4c_Selecionados READWRITE

                IF RECCOUNT("cursor_4c_Selecionados") = 0
                    MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                             "Marque ao menos um e-mail antes de enviar.", "Processamento de Email")
                ELSE
                    loc_cReceptor         = ""
                    loc_cReceptorCopia    = ""
                    loc_cAssunto          = "ALERTA"
                    loc_cTxtMensagem      = ""
                    loc_lTodasGravacoesOk = .T.

                    SELECT cursor_4c_Selecionados
                    GO TOP
                    SCAN
                        loc_cEmpDopNums = TratarNulo(cursor_4c_Selecionados.empdopnums, "")

                        IF RECNO() = 1
                            loc_cReceptor    = ALLTRIM(TratarNulo(cursor_4c_Selecionados.emails, ""))
                            loc_cTxtMensagem = ;
                                IIF(!EMPTY(THIS.this_cMovJobs), "JOB          : " + THIS.this_cMovJobs + " - " + ALLTRIM(THIS.this_cMovRclis) + CHR(13) + CHR(10), "") + ;
                                IIF(!EMPTY(THIS.this_cMovObsCabMovs), "Descritivo : " + ALLTRIM(THIS.this_cMovObsCabMovs) + CHR(13) + CHR(10), "") + ;
                                "Movimenta" + CHR(231) + CHR(227) + "o : " + SUBSTR(loc_cEmpDopNums, 1, 3) + " / " + SUBSTR(loc_cEmpDopNums, 4, 20) + " / " + SUBSTR(loc_cEmpDopNums, 24, 6) + CHR(13) + CHR(10) + ;
                                "A" + CHR(231) + CHR(227) + "o         : " + THIS.this_cEscolha + CHR(13) + CHR(10) + ;
                                "Usu" + CHR(225) + "rio      : " + gc_4c_UsuarioLogado + CHR(13) + CHR(10) + ;
                                "Data         : " + TTOC(DATETIME()) + CHR(13) + CHR(10) + ;
                                IIF(!EMPTY(TratarNulo(cursor_4c_Selecionados.mensagems, "")), "Mensagem     : " + ALLTRIM(cursor_4c_Selecionados.mensagems) + CHR(13) + CHR(10), "") + ;
                                IIF(!EMPTY(THIS.this_cMovObses), "Observa" + CHR(231) + CHR(227) + "o   : " + ALLTRIM(THIS.this_cMovObses), "")

                            loc_cAssunto = "ALERTA - " + ALLTRIM(TratarNulo(cursor_4c_Selecionados.prioridade, ""))
                        ELSE
                            IF !EMPTY(ALLTRIM(TratarNulo(cursor_4c_Selecionados.emails, "")))
                                loc_cReceptorCopia = loc_cReceptorCopia + ;
                                    IIF(EMPTY(loc_cReceptorCopia), "", ",") + ALLTRIM(cursor_4c_Selecionados.emails)
                            ENDIF
                        ENDIF

                        *-- Historico do alerta - um registro em SigAlert por
                        *-- destinatario marcado (equivalente ao Scatter Memo
                        *-- Memvar + Insert Into crSigAlert do legado). Todas
                        *-- as linhas do lote compartilham o MESMO texto de
                        *-- mensagem (loc_cTxtMensagem), igual ao legado, que
                        *-- so recalcula essa variavel no Recno() = 1.
                        THIS.this_cPkChaves   = ""
                        THIS.this_dDtAlerts   = DATETIME()
                        THIS.this_cMsg1s      = loc_cTxtMensagem
                        THIS.this_cMsg2s      = ""
                        THIS.this_cAcaos      = TratarNulo(cursor_4c_Selecionados.acaos, THIS.this_cEscolha)
                        THIS.this_cContas     = TratarNulo(cursor_4c_Selecionados.contas, "")
                        THIS.this_cGrupos     = ""
                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        THIS.this_cEmps       = SUBSTR(loc_cEmpDopNums, 1, 3)
                        THIS.this_cDopes      = SUBSTR(loc_cEmpDopNums, 4, 20)
                        THIS.this_nNumes      = VAL(SUBSTR(loc_cEmpDopNums, 24, 6))
                        THIS.this_nPriors     = 0
                        THIS.this_dDtAlert2s  = {}
                        THIS.this_cUsualerts  = gc_4c_UsuarioLogado
                        THIS.this_cUsuars     = gc_4c_UsuarioLogado

                        IF !THIS.Inserir()
                            loc_lTodasGravacoesOk = .F.
                        ENDIF

                        SELECT cursor_4c_Selecionados
                    ENDSCAN

                    IF !THIS.ObterDadosContaEmail(THIS.this_cLcEmp)
                        *-- erro ja exibido em ObterDadosContaEmail
                        loc_lOk = .F.
                    ELSE
                        WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                        loc_lOk = THIS.EnviarEmailSmtp(loc_cReceptor, loc_cReceptorCopia, loc_cAssunto, ;
                            loc_cTxtMensagem, "", THIS.this_cEmailFrom, THIS.this_cSmtpServer, ;
                            THIS.this_cSmtpSenha, THIS.this_nSmtpPorta)

                        WAIT CLEAR
                    ENDIF

                    loc_lOk = (loc_lOk AND loc_lTodasGravacoesOk)

                    *-- Cascata de baixa (laOpeBaixa) - so envia/grava se o
                    *-- principal deu certo, igual ao "If llOk And Used(...)"
                    *-- do legado
                    IF loc_lOk
                        loc_lOk = THIS.EnviarCascataBaixa()
                    ENDIF

                    IF loc_lOk
                        SQLCOMMIT(gnConnHandle)
                    ELSE
                        SQLROLLBACK(gnConnHandle)
                    ENDIF
                ENDIF

                IF USED("cursor_4c_Selecionados")
                    USE IN cursor_4c_Selecionados
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em EnviarAlertasSelecionados")
        ENDTRY

        IF USED("cursor_4c_OpeBaixa")
            USE IN cursor_4c_OpeBaixa
        ENDIF

        RETURN loc_lOk
    ENDFUNC

ENDDEFINE

