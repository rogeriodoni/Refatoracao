# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPGRUESTS, CPROS, DATAS, CUNIS, EMPDOPNUMS, CODIGOS, ICLIS, CRSUBNIVE, EMPDNPS, USUARIOS, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_SUBNIVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPGRUESTS, CPROS, DATAS, CUNIS, EMPDOPNUMS, CODIGOS, ICLIS, CRSUBNIVE, EMPDNPS, USUARIOS, CIDCHAVES

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "crSubniveis.Emps"
  Column2.ControlSource = "crSubniveis.Dopes"
  Column3.ControlSource = "crSubniveis.Numes"
	lnQueryOk = .SqlExecute([Select a.emps,a.empos,a.grupos,a.estos,a.cpros,a.dopes,a.numes,a.datas,a.auditors,a.dtaudits,a.qtds,a.opers,]+;
		   [From SigMvHst a ]+;
	lnQueryOk = .SqlExecute([Select cpros,cunis,cunips From SigCdPro Where cpros = "]+pcCdProduto+[" ],"TmpPro")
	Select TmpPro
	lnQueryOk = .SqlExecute([Select Cestos From SigCdUni Where cunis = "]+TmpPro.cunis+[" ],"TmpUni")
	Select TmpUni
	Select CrSigMvHst
		.Column1.ControlSource = "CrSigMvHst.datas"
		.Column2.ControlSource = "CrSigMvHst.numes"
		.Column3.ControlSource = "CrSigMvHst.dopes"
		.Column4.ControlSource = "CrSigMvHst.cunis"
		.Column5.ControlSource = "CrSigMvHst.qtds"
		.Column6.ControlSource = "CrSigMvHst.opers"
		.Column7.ControlSource = "CrSigMvHst.sqtds"
			.Column8.ControlSource = "CrSigMvHst.Pesos"
			.Column9.ControlSource = "CrSigMvHst.sPesos"
	lnQueryOk = .SqlExecute([Select grupoos,contaos,grupods,contads From SigMvCab ]+;
	lnQueryOk = .SqlExecute([Select codigos,descrs From SigCdGcr ]+;
	lnQueryOk = .SqlExecute([Select iclis,rclis From SigCdCli ]+;
	Select CrSigCdGcr
	Select CrSigCdCli
	ThisForm.GetDesGruOri.Value = Iif(Seek(lcGO,"CrSigCdGcr","codigos"),CrSigCdGcr.descrs,"")
	ThisForm.GetDesConOri.Value = Iif(Seek(lcCO,"CrSigCdCli","iclis"),CrSigCdCli.rclis,"")
	ThisForm.GetDesGruDes.Value = Iif(Seek(lcGD,"CrSigCdGcr","codigos"),CrSigCdGcr.descrs,"")
	ThisForm.GetDesConDes.Value = Iif(Seek(lcCD,"CrSigCdCli","iclis"),CrSigCdCli.rclis,"")
Select CrSigMvHst
		lnQueryOk = .SqlExecute([Select grupoos,contaos,grupods,contads,Notas From SigMvCab ]+;
		lnQueryOk = .SqlExecute([Select grupoos,contaos,grupods,contads, '      ' as Notas From SigCdNec ]+;
	lnQueryOk = .SqlExecute([Select codigos,descrs From SigCdGcr ]+;
	lnQueryOk = .SqlExecute([Select iclis,rclis From SigCdCli ]+;
	Select CrSigCdGcr
	Select CrSigCdCli
ThisForm.GetDesGruOri.Value = Iif(Seek(lcGO,"CrSigCdGcr","codigos"),CrSigCdGcr.descrs,"")
ThisForm.GetDesConOri.Value = Iif(Seek(lcCO,"CrSigCdCli","iclis"),CrSigCdCli.rclis,"")
ThisForm.GetDesGruDes.Value = Iif(Seek(lcGD,"CrSigCdGcr","codigos"),CrSigCdGcr.descrs,"")
ThisForm.GetDesConDes.Value = Iif(Seek(lcCD,"CrSigCdCli","iclis"),CrSigCdCli.rclis,"")
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select supervis From SigCdUsu Where usuarios = "]+Usuar+[" ],"TmpUsu")
lcQuery = [Select a.EmpSubns as Emps, b.Dopes, Right(Str(a.Codigos, 10), 6) as Numes ] + ;
		    [From SigMvPec a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigMvPec]) < 1)
Select crSigMvPec
	Insert Into crSubniveis (Emps, Dopes, Numes) Values (crSigMvPec.Emps, crSigMvPec.Dopes, Val(crSigMvPec.Numes))
		Select CrSigMvHst
		lnQueryOk = .SqlExecute([Update SigMvHst Set auditors = "]+Usuar+[" Where cidchaves = "]+CrSigMvHst.cidchaves+[" ],"")
		lnQueryOk = .SqlExecute([Update SigMvHst Set dtaudits = ?lcDtHis Where cidchaves = "]+CrSigMvHst.cidchaves+[" ],"")
		Select CrSigMvHst
		lnQueryOk = .SqlExecute([Update SigMvHst Set auditors = "]+Space(10)+[" Where cidchaves = "]+CrSigMvHst.cidchaves+[" ],"")
		Select CrSigMvHst
		lnQueryOk = .SqlExecute([Update SigMvHst Set dtaudits = Null Where cidchaves = "]+CrSigMvHst.cidchaves+[" ],"")
Select CrSigMvHst
=Seek(DTOS(This.Value),"CrSigMvHst","datas")

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1781 linhas total):

*-- Linhas 27 a 45:
27: *   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
28: *     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
29: *   - origem/destino (Grupo/Conta) do documento de movimento corrente;
30: *   - o checkbox de Auditado, que grava (UPDATE SigMvHst) auditors/dtaudits
31: *     do registro corrente - a UNICA escrita real deste form.
32: *
33: * NOTA SOBRE O ROTEIRO GENERICO DE 8 FASES: o template padrao da Fase 3
34: * pressupoe PageFrame com Page1 (Lista) e Page2 (Dados), igual aos forms
35: * CRUD (frmcadastro). SIGPRHPR NAO tem essa superficie - o dump legado prova
36: * PageFrame=0 (Secao 1 do .txt nao lista nenhum objeto baseClass=pageframe).
37: * Inventar um PageFrame Lista/Dados violaria o PILAR 1 (UX) e a regra "NUNCA
38: * inventar" do CLAUDE.md - mesma familia de caso ja documentada para
39: * SIGPRGST/SIGPRGLX/SIGMVEXP (formularios OPERACIONAL cuja superficie real
40: * nao casa com o template CRUD). Esta fase entrega, em vez disso, a
41: * superficie BASE real do legado: o cabecalho (cntSombra) - igual ao que
42: * FormSigPrGst/FormSigPrGlx fazem na propria Fase 3.
43: *
44: * Historico de montagem (migracao multi-fase):
45: *   Fase 1 (feita) - SigPrHprBO.prg: propriedades e Init

*-- Linhas 149 a 176:
149: *                                             que o legado desenhou)
150: *                       BtnSalvarClick     -> ChkAuditadoClick() (Fase 7: a
151: *                                             UNICA escrita real do form -
152: *                                             UPDATE SigMvHst.auditors/
153: *                                             dtaudits via
154: *                                             AtualizarAuditoria() do BO)
155: *                       BtnCancelarClick   -> nao existe no legado (nao ha
156: *                                             modo de edicao para cancelar -
157: *                                             inventar um botao Cancelar
158: *                                             violaria o PILAR 1 e a regra
159: *                                             "NUNCA inventar")
160: *                       FormParaBO/BOParaForm -> nao se aplicam: nao ha
161: *                                             INSERT/UPDATE de registro via
162: *                                             formulario completo. Os campos
163: *                                             sao TODOS somente-leitura e
164: *                                             espelhados do BO para a tela
165: *                                             (nunca o inverso) por
166: *                                             AtualizarCamposDocumento()/
167: *                                             AtualizarCamposAuditoria()
168: *                                             (Fase 5-6), chamados por
169: *                                             CarregarDadosIniciais() e por
170: *                                             GrdDadosAfterRowColChange()
171: *                       HabilitarCampos    -> nao se aplica: todo campo
172: *                                             nasce ReadOnly=.T. (equivalente
173: *                                             ao When Return(.F.) do legado -
174: *                                             dump linhas 1980-2082, 2155-
175: *                                             2159, 2204-2236, 2290-2292) e
176: *                                             permanece assim sempre - nao

*-- Linhas 487 a 522:
487:     *--------------------------------------------------------------------------
488:     * ConfigurarGradePrincipal - cria grd_4c_Dados (grd_historico no legado),
489:     * so a geometria/propriedades de grade (SigPrHpr_form_codigo_fonte.txt,
490:     * linhas 546-561). RecordSource/ColumnCount/ControlSource/Width/Header
491:     * das colunas sao feitos em CarregarGradePrincipal() - fazer isso aqui
492:     * seria inutil, porque reatribuir RecordSource/ControlSource reseta
493:     * Width e Header1.Caption (CLAUDE.md - "Problema 2" / regra sobre Grid
494:     * rebind, FORMCOR_LICOES_APRENDIDAS.md).
495:     *--------------------------------------------------------------------------
496:     PROTECTED PROCEDURE ConfigurarGradePrincipal()
497:         LOCAL loc_oErro
498: 
499:         TRY
500:             THIS.AddObject("grd_4c_Dados", "Grid")
501:             WITH THIS.grd_4c_Dados
502:                 .Top         = 148
503:                 .Left        = 4
504:                 .Width       = 730
505:                 .Height      = 238
506:                 .FontName    = "Arial"
507:                 .DeleteMark  = .F.
508:                 .RecordMark  = .F.
509:                 .ScrollBars  = 2
510:                 .ReadOnly    = .T.
511:                 .ColumnCount = 9
512:                 .Visible     = .T.
513:             ENDWITH
514: 
515:             *-- AfterRowColChange = AfterRowColChange do grd_historico legado
516:             *-- (dump linhas 579-728): troca de linha na grade principal
517:             *-- reposiciona documento/origem-destino/auditoria/subniveis do
518:             *-- registro agora corrente. BINDEVENT exige metodo PUBLIC e
519:             *-- parametro declarado (CLAUDE.md regra #3).
520:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
521:         CATCH TO loc_oErro
522:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 529 a 547:
529:     * FormatarColunaGradePrincipal - aplica a UMA coluna de grd_4c_Dados o
530:     * trio FontName/Width/Movable/Resizable/ReadOnly + Format/InputMask
531:     * (quando informados) + Header1 (FontName/FontSize/Alignment/Caption/
532:     * ForeColor), na ordem exigida (DEPOIS do ControlSource - ver chamador).
533:     *--------------------------------------------------------------------------
534:     PROTECTED PROCEDURE FormatarColunaGradePrincipal(par_oColuna, par_cCaption, par_nWidth, par_cFormat, par_cInputMask)
535:         WITH par_oColuna
536:             .FontName  = "Courier New"
537:             .Width     = par_nWidth
538:             .Movable   = .F.
539:             .Resizable = .F.
540:             .ReadOnly  = .T.
541:             IF !EMPTY(par_cFormat)
542:                 .Format    = par_cFormat
543:                 .InputMask = par_cInputMask
544:             ENDIF
545:             .Header1.FontName  = "Tahoma"
546:             .Header1.FontSize  = 8
547:             .Header1.Alignment = 2

*-- Linhas 575 a 602:
575:                 loc_oGrid.ColumnCount = 9
576:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
577: 
578:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.datas"
579:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.numes"
580:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dopes"
581:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cunis"
582:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.qtds"
583:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.opers"
584:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.sqtds"
585:                 IF loc_nColunas = 9
586:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.pesos"
587:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.spesos"
588:                 ENDIF
589: 
590:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column1, "Data", 86, "", "")
591:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column2, "C" + CHR(243) + "digo", 57, "", "")
592:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column3, "Opera" + CHR(231) + CHR(227) + "o", 161, "", "")
593:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column4, "Un.", 31, "999,999.99", "999,999.99")
594:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column5, "Quantidade", 78, "999,999.999", "999,999.999")
595:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column6, "O", 24, "", "")
596:                 THIS.FormatarColunaGradePrincipal(loc_oGrid.Column7, "Saldo  Q", 93, "9,999,999.999", "9,999,999.999")
597:                 IF loc_nColunas = 9
598:                     THIS.FormatarColunaGradePrincipal(loc_oGrid.Column8, "Peso", 80, "999,999.999", "999,999.999")
599:                     THIS.FormatarColunaGradePrincipal(loc_oGrid.Column9, "Saldo P", 80, "999,999.999", "999,999.999")
600:                 ENDIF
601: 
602:                 *-- Verde claro na linha ja auditada - SetAll("DynamicBackColor", ...)

*-- Linhas 634 a 668:
634:     * legado - SigPrHpr_form_codigo_fonte.txt linhas 1256-1272) e
635:     * lbl_4c_Label3 ("Movimentacoes com subnivel" - Label3, linhas
636:     * 1367-1382), titulo estatico da grade. So geometria aqui - igual a
637:     * ConfigurarGradePrincipal, o rebind de ControlSource/Width/Header fica
638:     * em AtualizarGradeSubniveis(), chamado toda vez que o BO recria
639:     * cursor_4c_Subniveis (CarregarSubniveis faz USE IN + CREATE CURSOR a
640:     * cada linha selecionada na grade principal - regra do rebind de grid).
641:     *--------------------------------------------------------------------------
642:     PROTECTED PROCEDURE ConfigurarGradeSubniveis()
643:         LOCAL loc_oErro
644: 
645:         TRY
646:             THIS.AddObject("grd_4c_Subniveis", "Grid")
647:             WITH THIS.grd_4c_Subniveis
648:                 .Top         = 148
649:                 .Left        = 738
650:                 .Width       = 261
651:                 .Height      = 238
652:                 .FontName    = "Arial"
653:                 .DeleteMark  = .F.
654:                 .RecordMark  = .F.
655:                 .ScrollBars  = 2
656:                 .ReadOnly    = .T.
657:                 .ColumnCount = 3
658:                 .Visible     = .T.
659:             ENDWITH
660: 
661:             THIS.AddObject("lbl_4c_Label3", "Label")
662:             WITH THIS.lbl_4c_Label3
663:                 .AutoSize   = .F.
664:                 .FontBold   = .T.
665:                 .FontItalic = .F.
666:                 .FontName   = "Tahoma"
667:                 .FontSize   = 8
668:                 .BackStyle  = 0

*-- Linhas 681 a 722:
681:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGradeSubniveis")
682:         ENDTRY
683:     ENDPROC
684: 
685:     *--------------------------------------------------------------------------
686:     * AtualizarGradeSubniveis - rebinda grd_4c_Subniveis a cursor_4c_Subniveis
687:     * (crSubniveis no legado - RecordSource estatico, linha 1266 do dump,
688:     * porque o cursor e SEMPRE recriado com a MESMA estrutura por
689:     * CarregarSubniveis()/CarregarDoCursor() do BO). Precisa ser chamado de
690:     * NOVO toda vez que o BO recriar o cursor - Width/Header1.Caption se
691:     * perdem no rebind (mesma familia do "Problema 2" / regra sobre Grid
692:     * Column.ControlSource resetar Header/Width). Reusado pela Fase 7-8 no
693:     * AfterRowColChange da grade principal.
694:     *--------------------------------------------------------------------------
695:     PROTECTED PROCEDURE AtualizarGradeSubniveis()
696:         LOCAL loc_oGrid, loc_oErro
697: 
698:         TRY
699:             loc_oGrid = THIS.grd_4c_Subniveis
700: 
701:             loc_oGrid.RecordSource = ""
702:             loc_oGrid.ColumnCount  = 3
703:             loc_oGrid.RecordSource = "cursor_4c_Subniveis"
704: 
705:             loc_oGrid.Column1.ControlSource = "cursor_4c_Subniveis.Emps"
706:             loc_oGrid.Column2.ControlSource = "cursor_4c_Subniveis.Dopes"
707:             loc_oGrid.Column3.ControlSource = "cursor_4c_Subniveis.Numes"
708: 
709:             WITH loc_oGrid.Column1
710:                 .FontName  = "Courier New"
711:                 .Width     = 31
712:                 .Movable   = .F.
713:                 .Resizable = .F.
714:                 .ReadOnly  = .T.
715:                 .Header1.FontName  = "Tahoma"
716:                 .Header1.FontSize  = 8
717:                 .Header1.Alignment = 2
718:                 .Header1.Caption   = "Emp"
719:             ENDWITH
720: 
721:             WITH loc_oGrid.Column2
722:                 .FontName  = "Courier New"

*-- Linhas 740 a 761:
740:                 .Header1.FontSize  = 8
741:                 .Header1.Alignment = 2
742:                 .Header1.Caption   = "C" + CHR(243) + "digo"
743:             ENDWITH
744: 
745:             IF USED("cursor_4c_Subniveis")
746:                 GO TOP IN cursor_4c_Subniveis
747:             ENDIF
748:             loc_oGrid.Refresh()
749:         CATCH TO loc_oErro
750:             MsgErro(loc_oErro.Message + CHR(13) + ;
751:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
752:                 "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarGradeSubniveis")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *--------------------------------------------------------------------------
757:     * ConfigurarCamposDocumento - cria o bloco Origem/Destino do documento de
758:     * movimento corrente (dump linhas 467-1051 e 1419-1471): os dois paineis
759:     * de fundo cnt_4c_Container1 (Origem, Left=7)/cnt_4c_Container2 (Destino,
760:     * Left=504), os titulos lbl_4c_Say7 "Origem "/lbl_4c_Say8 "Destino" com
761:     * as linhas separadoras lin_4c_Line1/lin_4c_Line2, o titulo dinamico

*-- Linhas 1262 a 1284:
1262: 
1263:             *-- chkAuditado.Click do legado (dump: "Private lcDtHis / With
1264:             *-- ThisForm.poDataMgr / If This.Value = 1 / ... Replace
1265:             *-- CrSigMvHst.auditors With Usuar / .SqlExecute(Update SigMvHst
1266:             *-- Set auditors...) / ... Replace CrSigMvHst.dtaudits With
1267:             *-- Date()...") - equivalente encapsulado em
1268:             *-- AtualizarAuditoria() do BO (Fase 2), que ja faz a transacao
1269:             *-- BEGIN/UPDATE auditors/UPDATE dtaudits/COMMIT ou ROLLBACK.
1270:             BINDEVENT(THIS.chk_4c_ChkAuditado, "Click", THIS, "ChkAuditadoClick")
1271: 
1272:             *-- Data : / campo de filtro por data (Say6/Get_Data) - toggle
1273:             *-- flutuante disparado por cmd_4c_Command1 ("Procurar", Fase
1274:             *-- 4), comeca oculto igual ao legado (dump: ThisForm.Get_Data.
1275:             *-- Visible = .f. / ThisForm.Say6.Visible = .f. no Init).
1276:             THIS.AddObject("lbl_4c_Label6", "Label")
1277:             WITH THIS.lbl_4c_Label6
1278:                 .AutoSize  = .F.
1279:                 .FontBold  = .T.
1280:                 .FontName  = "Tahoma"
1281:                 .FontSize  = 8
1282:                 .BackStyle = 0
1283:                 .Alignment = 0
1284:                 .Caption   = "Data :"

*-- Linhas 1451 a 1477:
1451:     *--------------------------------------------------------------------------
1452:     * ChkAuditadoClick - chkAuditado.Click do legado (dump:
1453:     * "Private lcDtHis / With ThisForm.poDataMgr / If This.Value = 1 /
1454:     * Select CrSigMvHst / Replace CrSigMvHst.auditors With Usuar /
1455:     * .SqlExecute([Update SigMvHst Set auditors = "]+Usuar+...) / If
1456:     * lnQueryOk < 1 / MessageBox('Favor reinicializar o processo.',16,
1457:     * 'Falha na Conex?o') / .RollBack() / Return(.F.) / EndIf / Replace
1458:     * CrSigMvHst.dtaudits With Date()..."): marca/desmarca a auditoria do
1459:     * registro corrente. THIS.this_oBusinessObject.AtualizarAuditoria() (BO,
1460:     * Fase 2) encapsula a transacao BEGIN/UPDATE auditors/UPDATE dtaudits/
1461:     * COMMIT-ou-ROLLBACK equivalente. Falhando, o checkbox volta ao estado
1462:     * anterior (o legado tambem reverte - o UPDATE nunca commitou) e exibe o
1463:     * MESMO texto do legado ("Favor reinicializar o processo."), que ja vem
1464:     * em THIS.this_cMensagemErro. Sucedendo, reconsulta o registro para
1465:     * refletir o auditors/dtaudits gravados (RegistrarAuditoria do proprio
1466:     * BO fica fora deste fluxo - jah chamado dentro de AtualizarAuditoria) e
1467:     * repinta a grade (auditors alimenta o DynamicBackColor verde-claro da
1468:     * Fase 7). PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
1469:     *--------------------------------------------------------------------------
1470:     PROCEDURE ChkAuditadoClick()
1471:         LOCAL loc_lMarcar
1472: 
1473:         loc_lMarcar = (THIS.chk_4c_ChkAuditado.Value = 1)
1474: 
1475:         IF THIS.this_oBusinessObject.AtualizarAuditoria(loc_lMarcar)
1476:             THIS.AtualizarCamposAuditoria()
1477:             THIS.grd_4c_Dados.Refresh()

*-- Linhas 1686 a 1704:
1686:     *     If IsEmpty(This.Value)
1687:     *         This.Visible = .F. / ThisForm.Say6.Visible = .F. / Return(.T.)
1688:     *     EndIf
1689:     *     Select CrSigMvHst / Set Near On
1690:     *     =Seek(DTOS(This.Value),"CrSigMvHst","datas")
1691:     *     Set Near Off / ThisForm.grd_historico.Refresh / Return(.T.)
1692:     *
1693:     * Valor vazio: esconde o campo e a label e sai (mesmo corpo do LostFocus).
1694:     * Valor preenchido: posiciona cursor_4c_Dados (CrSigMvHst) na data
1695:     * informada e repinta a grade - SET NEAR ON faz o SEEK parar no registro
1696:     * mais PROXIMO quando a data exata nao existe, que e o comportamento de
1697:     * "procurar" esperado pelo usuario. O tag "datas" e criado pelo BO com
1698:     * INDEX ON DTOS(datas) (SigPrHprBO.CarregarHistorico), por isso a chave do
1699:     * SEEK tambem e DTOS() - a forma de 3 argumentos dispensa SET ORDER.
1700:     * SET NEAR e RESTAURADO ao valor anterior (nao chutado para OFF): sem
1701:     * isso o metodo mudaria um SET da datasession em vez de so usa-lo.
1702:     * ConverterParaData() normaliza DATE/DATETIME/CHAR - .Value nasce {}
1703:     * (DATE) mas o campo e digitado pelo usuario (CLAUDE.md regra #16).
1704:     * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).

*-- Linhas 1723 a 1741:
1723:             IF USED("cursor_4c_Dados")
1724:                 loc_cNearAnterior = SET("NEAR")
1725: 
1726:                 SELECT cursor_4c_Dados
1727:                 SET NEAR ON
1728:                 =SEEK(DTOS(loc_dData), "cursor_4c_Dados", "datas")
1729: 
1730:                 IF loc_cNearAnterior == "OFF"
1731:                     SET NEAR OFF
1732:                 ENDIF
1733: 
1734:                 THIS.grd_4c_Dados.Refresh()
1735:             ENDIF
1736:         CATCH TO loc_oErro
1737:             MsgErro(loc_oErro.Message + CHR(13) + ;
1738:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1739:                 "Procedure: " + loc_oErro.Procedure, "Erro em ValidarData")
1740:         ENDTRY
1741:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrHprBO.prg):
*============================================================================
* SigPrHprBO.prg - Business Object para Historico de Produtos (SIGPRHPR)
*
* Form OPERACIONAL (SIGPRHPR / FormSigPrHpr): tela de CONSULTA aberta por um
* form pai (ThisForm.ParentForm) que ja definiu, antes de "Do Form SigPrHpr",
* as variaveis PRIVATE pcCdGrupo/pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/
* pdDataFin (grupo, conta, produto e periodo cujo historico de movimentos
* sera exibido - ver tasks/task621/SigPrHpr_form_codigo_fonte.txt,
* Procedure Init). A tela mostra:
*   - a grade principal grd_4c_Dados (CrSigMvHst no legado) com o historico
*     de movimentos do produto no periodo;
*   - a grade secundaria grd_4c_Subniveis (crSubniveis no legado) com os
*     subniveis (SigMvPec x SigCdOpe) do documento selecionado;
*   - origem/destino (Grupo/Conta) do documento de movimento corrente,
*     resolvidos contra SigMvCab (ou SigCdNec quando o documento ainda nao
*     foi efetivado) e descritos via SigCdGcr/SigCdCli;
*   - o checkbox de Auditado, que GRAVA (UPDATE SigMvHst) auditors/dtaudits
*     do registro corrente - a UNICA escrita real deste form.
*
* NAO existe uma unica "tabela principal" para efeito de Buscar()/
* CarregarDoCursor() (this_cTabela permanece vazio, mesmo padrao adotado em
* SigPrGstBO/SigPrGlxBO): o historico vem de SigMvHst filtrado por
* Grupo+Conta+Produto+Periodo, e os cursores auxiliares (documento, grupo/
* conta descritivos, subniveis) sao resolvidos a cada linha selecionada na
* grade principal (AfterRowColChange do legado). this_cCampoChave aponta
* para "cidchaves" (SigMvHst.cidchaves, PK), que eh o unico campo usado
* para localizar o registro no UPDATE de auditoria.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos CRUD/dominio (CarregarHistorico,
* CarregarDoCursor, BuscarDocumentoMovimento, BuscarDescricoesGrupoConta,
* VerificarPermissaoAuditoria, CarregarSubniveis, AtualizarAuditoria,
* VerificarDocumentoCadastrado, ObterChavePrimaria, ObterTituloProduto)
*============================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form pai (equivalente as PRIVATE pcCdGrupo/
    * pcCdConta/pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do legado -
    * definidas pelo chamador ANTES de abrir esta tela)
    *==========================================================================
    this_cGrupo             = SPACE(10)  && pcCdGrupo  (SigMvHst.grupos char(10))
    this_cConta             = SPACE(10)  && pcCdConta  (SigMvHst.estos  char(10))
    this_cProduto           = SPACE(14)  && pcCdProduto (SigMvHst.cpros char(14))
    this_cDescricaoProduto  = ""         && pcDsProduto (descricao exibida no titulo)
    this_dDataIni           = {}         && pdDataIni  (inicio do periodo)
    this_dDataFin           = {}         && pdDataFin  (fim do periodo)

    *==========================================================================
    * Registro corrente da grade principal (equivalente a CrSigMvHst na
    * linha ativa - usado por AfterRowColChange/chkAuditado.Click/
    * btnDocumento.Click do legado)
    *==========================================================================
    this_cEmpsAtual         = SPACE(3)   && CrSigMvHst.emps
    this_cEmposAtual        = SPACE(3)   && CrSigMvHst.empos
    this_cDopesAtual        = SPACE(20)  && CrSigMvHst.dopes
    this_nNumesAtual        = 0          && CrSigMvHst.numes
    this_cCidChavesAtual    = SPACE(20)  && CrSigMvHst.cidchaves (PK - chave do UPDATE de auditoria)
    this_cAuditorAtual      = SPACE(10)  && CrSigMvHst.auditors
    this_dDtAuditAtual      = {}         && CrSigMvHst.dtaudits
    this_cObsAtual          = ""         && CrSigMvHst.obs
    this_cUsuarioMovAtual   = SPACE(10)  && CrSigMvHst.usuars
    this_cNotaAtual         = SPACE(6)   && SigMvCab.notas do documento corrente

    *==========================================================================
    * Produto / unidade (equivalente a TmpPro/TmpUni do legado - resolvidos
    * uma unica vez no Init para decidir se a grade mostra as colunas de
    * Peso/Saldo Peso)
    *==========================================================================
    this_cUnidade           = SPACE(3)   && SigCdPro.cunis
    this_cUnidadePeso       = SPACE(3)   && SigCdPro.cunips
    this_cTipoEstoque       = SPACE(1)   && SigCdUni.cestos ("3" = controla peso)

    *==========================================================================
    * Documento de origem/destino do movimento corrente (equivalente a
    * CrSigMvCab resolvido no AfterRowColChange do legado - grupoos/
    * contaos/grupods/contads - e suas descricoes via SigCdGcr/SigCdCli)
    *==========================================================================
    this_cGrupoOrigem       = SPACE(10)  && SigMvCab.grupoos
    this_cContaOrigem       = SPACE(10)  && SigMvCab.contaos
    this_cGrupoDestino      = SPACE(10)  && SigMvCab.grupods
    this_cContaDestino      = SPACE(10)  && SigMvCab.contads
    this_cDescGrupoOrigem   = SPACE(40)  && SigCdGcr.descrs (grupoos)
    this_cDescContaOrigem   = SPACE(50)  && SigCdCli.rclis  (contaos)
    this_cDescGrupoDestino  = SPACE(40)  && SigCdGcr.descrs (grupods)
    this_cDescContaDestino  = SPACE(50)  && SigCdCli.rclis  (contads)

    *==========================================================================
    * Permissao de auditoria (equivalente a llSupervis/llVisAudit do Init
    * legado - decide se o chk_4c_Auditado fica visivel para o usuario
    * corrente)
    *==========================================================================
    this_lUsuarioSupervisor = .F.        && Upper(Alltrim(Usuar)) = "4CONTROL"
    this_lPodeAuditar       = .F.        && llVisAudit (resultado final da checagem)

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo de consulta (o historico vem de SigMvHst
    * filtrado por Grupo+Conta+Produto+Periodo recebidos do form pai) -
    * mesmo padrao adotado em SigPrGstBO.Init/SigPrGlxBO.Init. this_cCam
    * poChave fica com "cidchaves" (SigMvHst.cidchaves), unico campo usado
    * para localizar o registro no UPDATE de auditoria.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_cGrupo            = SPACE(10)
            THIS.this_cConta            = SPACE(10)
            THIS.this_cProduto          = SPACE(14)
            THIS.this_cDescricaoProduto = ""
            THIS.this_dDataIni          = {}
            THIS.this_dDataFin          = {}

            THIS.this_cEmpsAtual        = SPACE(3)
            THIS.this_cEmposAtual       = SPACE(3)
            THIS.this_cDopesAtual       = SPACE(20)
            THIS.this_nNumesAtual       = 0
            THIS.this_cCidChavesAtual   = SPACE(20)
            THIS.this_cAuditorAtual     = SPACE(10)
            THIS.this_dDtAuditAtual     = {}
            THIS.this_cObsAtual         = ""
            THIS.this_cUsuarioMovAtual  = SPACE(10)
            THIS.this_cNotaAtual        = SPACE(6)

            THIS.this_cUnidade          = SPACE(3)
            THIS.this_cUnidadePeso      = SPACE(3)
            THIS.this_cTipoEstoque      = SPACE(1)

            THIS.this_cGrupoOrigem      = SPACE(10)
            THIS.this_cContaOrigem      = SPACE(10)
            THIS.this_cGrupoDestino     = SPACE(10)
            THIS.this_cContaDestino     = SPACE(10)
            THIS.this_cDescGrupoOrigem  = SPACE(40)
            THIS.this_cDescContaOrigem  = SPACE(50)
            THIS.this_cDescGrupoDestino = SPACE(40)
            THIS.this_cDescContaDestino = SPACE(50)

            THIS.this_lUsuarioSupervisor = .F.
            THIS.this_lPodeAuditar       = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave usada por RegistrarAuditoria() apos o
    * UPDATE de auditoria (AtualizarAuditoria) - SigMvHst.cidchaves do
    * registro corrente da grade principal.
    *
    * PROTECTED porque o metodo da base tambem eh PROTECTED - subclasse nao
    * alarga escopo de hook herdado.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChavesAtual)
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() do BusinessBase NAO sao
    * sobrescritos aqui: este form eh de CONSULTA (historico de movimentos
    * de SigMvHst), sem INSERT/UPDATE/DELETE genericos no legado. A UNICA
    * escrita real (toggle de chk_4c_Auditado) tem semantica propria -
    * AtualizarAuditoria(), mais abaixo, grava auditors/dtaudits em
    * SigMvHst e chama RegistrarAuditoria("UPDATE") no sucesso. O
    * comportamento padrao herdado de BusinessBase para Inserir/Atualizar/
    * ExecutarExclusao ja eh o correto para este BO.
    *==========================================================================

    *==========================================================================
    * ExecutarSQL - SQLEXEC preservando a area de trabalho corrente
    * (equivalente a ThisForm.poDataMgr.SqlExecute do legado, que nao
    * reseleciona a area depois - SQLEXEC() troca a area selecionada).
    *==========================================================================
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *==========================================================================
    * BuscarProdutoUnidade - produto/unidade do historico (TmpPro/TmpUni do
    * legado) - decide via this_cTipoEstoque se a grade mostra as colunas
    * de Peso/Saldo Peso (cestos = "3").
    *==========================================================================
    PROTECTED FUNCTION BuscarProdutoUnidade(par_cProduto)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cProduto)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Produto", "Produto")
            IF USED("cursor_4c_Produto") AND RECCOUNT("cursor_4c_Produto") > 0
                SELECT cursor_4c_Produto
                GO TOP
                THIS.this_cUnidade     = PADR(TratarNulo(cunis, ""), 3)
                THIS.this_cUnidadePeso = PADR(TratarNulo(cunips, ""), 3)
                USE IN cursor_4c_Produto

                loc_cSQL = "SELECT cestos FROM SigCdUni WHERE cunis = " + EscaparSQL(THIS.this_cUnidade)
                IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Unidade", "Unidade")
                    IF USED("cursor_4c_Unidade") AND RECCOUNT("cursor_4c_Unidade") > 0
                        SELECT cursor_4c_Unidade
                        GO TOP
                        THIS.this_cTipoEstoque = TratarNulo(cestos, "")
                        loc_lResultado = .T.
                    ENDIF
                    IF USED("cursor_4c_Unidade")
                        USE IN cursor_4c_Unidade
                    ENDIF
                ENDIF
            ELSE
                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF
                THIS.this_cMensagemErro = "Produto " + ALLTRIM(TratarNulo(par_cProduto, "")) + " n" + CHR(227) + "o encontrado."
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarHistorico - equivalente ao bloco principal do Init legado:
    * resolve produto/unidade, popula cursor_4c_Dados (CrSigMvHst) com o
    * historico de movimentos filtrado por Grupo+Conta+Produto+Periodo e
    * deixa o cursor posicionado no ULTIMO registro (Go Bottom legado), que
    * eh quem o Form usa para carregar a linha inicial via
    * CarregarDoCursor(). Chave empgruests eh POSICIONAL (emps(3)+
    * grupos(10)+estos(10) = 23) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarHistorico(par_cGrupo, par_cConta, par_cProduto, par_cDescricaoProduto, par_dDataIni, par_dDataFin)
        LOCAL loc_lResultado, loc_cSQL, loc_cChave, loc_dFim

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        THIS.this_cGrupo            = PADR(TratarNulo(par_cGrupo, ""), 10)
        THIS.this_cConta            = PADR(TratarNulo(par_cConta, ""), 10)
        THIS.this_cProduto          = PADR(TratarNulo(par_cProduto, ""), 14)
        THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(par_cDescricaoProduto, ""))
        THIS.this_dDataIni          = TratarNulo(par_dDataIni, {})
        THIS.this_dDataFin          = TratarNulo(par_dDataFin, {})

        IF !THIS.BuscarProdutoUnidade(THIS.this_cProduto)
            RETURN .F.
        ENDIF

        loc_dFim = DATETIME(YEAR(THIS.this_dDataFin), MONTH(THIS.this_dDataFin), DAY(THIS.this_dDataFin), 23, 59, 59)

        loc_cChave = PADR(go_4c_Sistema.cCodEmpresa, 3) + THIS.this_cGrupo + THIS.this_cConta

        loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, a.dopes, a.numes, " + ;
            "a.datas, a.auditors, a.dtaudits, a.qtds, a.opers, a.sqtds, a.obs, " + ;
            "a.usuars, a.cidchaves, a.pesos, a.spesos, SPACE(3) AS cunis " + ;
            "FROM SigMvHst a " + ;
            "WHERE a.empgruests = " + EscaparSQL(loc_cChave) + " " + ;
            "AND a.cpros = " + EscaparSQL(THIS.this_cProduto) + " " + ;
            "AND a.datas BETWEEN " + FormatarDataSQL(THIS.this_dDataIni) + " AND " + FormatarDataSQL(loc_dFim) + " " + ;
            "ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Dados", "Historico")
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE ALL cunis WITH THIS.this_cUnidade
                INDEX ON Pesos TAG Pesos
                INDEX ON DTOS(datas) TAG datas
                GO BOTTOM
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterTituloProduto - monta o Caption de lbl_4c_Produto (equivalente a
    * ThisForm.lbl_Produto.Caption do Init legado): produto + descricao +
    * periodo e, quando a unidade controla peso (cestos = "3"), tambem a
    * unidade de peso.
    *==========================================================================
    FUNCTION ObterTituloProduto()
        LOCAL loc_cTitulo

        loc_cTitulo = "Produto : " + ALLTRIM(THIS.this_cProduto) + " - " + ALLTRIM(THIS.this_cDescricaoProduto) + ;
            SPACE(10) + "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + " " + CHR(224) + " " + DTOC(THIS.this_dDataFin)

        IF THIS.this_cTipoEstoque == "3"
            loc_cTitulo = loc_cTitulo + " Unid.Peso:" + ALLTRIM(THIS.this_cUnidadePeso)
        ENDIF

        RETURN loc_cTitulo
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - equivalente ao AfterRowColChange do legado: le o
    * registro CORRENTE de cursor_4c_Dados (a grade principal) e resolve
    * tudo o que depende dele - documento de origem/destino, descricoes de
    * grupo/conta, permissao de auditoria e subniveis.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpsAtual       = PADR(TratarNulo(emps, ""), 3)
            THIS.this_cEmposAtual      = PADR(TratarNulo(empos, ""), 3)
            THIS.this_cDopesAtual      = PADR(TratarNulo(dopes, ""), 20)
            THIS.this_nNumesAtual      = TratarNulo(numes, 0)
            THIS.this_cCidChavesAtual  = PADR(TratarNulo(cidchaves, ""), 20)
            THIS.this_cAuditorAtual    = PADR(TratarNulo(auditors, ""), 10)
            THIS.this_dDtAuditAtual    = TratarNulo(dtaudits, {})
            THIS.this_cObsAtual        = TratarNulo(obs, "")
            THIS.this_cUsuarioMovAtual = PADR(TratarNulo(usuars, ""), 10)
            THIS.this_cNotaAtual       = SPACE(6)

            IF THIS.BuscarDocumentoMovimento()
                THIS.BuscarDescricoesGrupoConta()
            ENDIF

            THIS.VerificarPermissaoAuditoria()
            THIS.CarregarSubniveis()

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOperacaoCadastrada - equivalente a
    * ThisForm.poDataMgr.Cursorquery('SigCdOpe','CrOpe','Dopes',...,'Dopes')
    * do legado: confirma se a operacao (Dopes) do movimento corrente esta
    * cadastrada em SigCdOpe. Decide se o documento se resolve por
    * SigMvCab (movimento ja efetivado) ou por SigCdNec (necessidade,
    * ainda nao efetivada).
    *==========================================================================
    PROTECTED FUNCTION VerificarOperacaoCadastrada(par_cDopes)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdOpe WHERE Dopes = " + ;
            EscaparSQL(ALLTRIM(TratarNulo(par_cDopes, "")))

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerOpe", "VerificarOperacao")
            IF USED("cursor_4c_VerOpe")
                loc_lResultado = (NVL(cursor_4c_VerOpe.Total, 0) > 0)
                USE IN cursor_4c_VerOpe
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDocumentoMovimento - resolve o documento de origem/destino do
    * movimento corrente (grupoos/contaos/grupods/contads), igual ao
    * AfterRowColChange do legado: tenta SigMvCab (documento JA efetivado,
    * chave EmpDopNums char(29) = emps(3)+dopes(20)+Str(numes,6)) e cai
    * para SigCdNec (necessidade, ainda nao efetivada, chave EmpDnPs
    * char(33) = emps(3)+dopes(20)+Str(numes,10)) quando a operacao nao
    * esta cadastrada em SigCdOpe. As duas chaves sao POSICIONAIS - PADR
    * explicito, nunca ALLTRIM nas partes (CLAUDE.md regra #42).
    *==========================================================================
    PROTECTED FUNCTION BuscarDocumentoMovimento()
        LOCAL loc_lResultado, loc_cSQL, loc_cEmpDoc

        loc_lResultado = .F.

        loc_cEmpDoc = PADR(IIF(!EMPTY(THIS.this_cEmposAtual), THIS.this_cEmposAtual, THIS.this_cEmpsAtual), 3)

        THIS.this_cGrupoOrigem  = SPACE(10)
        THIS.this_cContaOrigem  = SPACE(10)
        THIS.this_cGrupoDestino = SPACE(10)
        THIS.this_cContaDestino = SPACE(10)
        THIS.this_cNotaAtual    = SPACE(6)

        IF THIS.VerificarOperacaoCadastrada(THIS.this_cDopesAtual)
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, Notas FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6))
        ELSE
            loc_cSQL = "SELECT grupoos, contaos, grupods, contads, SPACE(6) AS Notas FROM SigCdNec " + ;
                "WHERE empdnps = " + EscaparSQL(loc_cEmpDoc + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 10))
        ENDIF

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Documento", "Documento")
            IF USED("cursor_4c_Documento") AND RECCOUNT("cursor_4c_Documento") > 0
                SELECT cursor_4c_Documento
                GO TOP
                THIS.this_cGrupoOrigem  = PADR(TratarNulo(grupoos, ""), 10)
                THIS.this_cContaOrigem  = PADR(TratarNulo(contaos, ""), 10)
                THIS.this_cGrupoDestino = PADR(TratarNulo(grupods, ""), 10)
                THIS.this_cContaDestino = PADR(TratarNulo(contads, ""), 10)
                THIS.this_cNotaAtual    = PADR(TratarNulo(Notas, ""), 6)
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_Documento")
                USE IN cursor_4c_Documento
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * BuscarDescricoesGrupoConta - descricoes de Grupo (SigCdGcr.descrs) e
    * Conta (SigCdCli.rclis) de origem/destino do documento corrente.
    *==========================================================================
    PROTECTED FUNCTION BuscarDescricoesGrupoConta()
        LOCAL loc_cSQL, loc_cGO, loc_cGD, loc_cCO, loc_cCD

        loc_cGO = ALLTRIM(THIS.this_cGrupoOrigem)
        loc_cGD = ALLTRIM(THIS.this_cGrupoDestino)
        loc_cCO = ALLTRIM(THIS.this_cContaOrigem)
        loc_cCD = ALLTRIM(THIS.this_cContaDestino)

        THIS.this_cDescGrupoOrigem  = SPACE(40)
        THIS.this_cDescContaOrigem  = SPACE(50)
        THIS.this_cDescGrupoDestino = SPACE(40)
        THIS.this_cDescContaDestino = SPACE(50)

        IF !EMPTY(loc_cGO) OR !EMPTY(loc_cGD)
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGO) + ;
                " OR codigos = " + EscaparSQL(loc_cGD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Grupo", "Grupo")
                IF USED("cursor_4c_Grupo")
                    INDEX ON codigos TAG codigos
                    IF !EMPTY(loc_cGO) AND SEEK(loc_cGO, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoOrigem = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    IF !EMPTY(loc_cGD) AND SEEK(loc_cGD, "cursor_4c_Grupo", "codigos")
                        THIS.this_cDescGrupoDestino = PADR(TratarNulo(cursor_4c_Grupo.descrs, ""), 40)
                    ENDIF
                    USE IN cursor_4c_Grupo
                ENDIF
            ENDIF
        ENDIF

        IF !EMPTY(loc_cCO) OR !EMPTY(loc_cCD)
            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCO) + ;
                " OR iclis = " + EscaparSQL(loc_cCD)
            IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_Conta", "Conta")
                IF USED("cursor_4c_Conta")
                    INDEX ON iclis TAG iclis
                    IF !EMPTY(loc_cCO) AND SEEK(loc_cCO, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaOrigem = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    IF !EMPTY(loc_cCD) AND SEEK(loc_cCD, "cursor_4c_Conta", "iclis")
                        THIS.this_cDescContaDestino = PADR(TratarNulo(cursor_4c_Conta.rclis, ""), 50)
                    ENDIF
                    USE IN cursor_4c_Conta
                ENDIF
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * VerificarPermissaoAuditoria - equivalente ao bloco llSupervis/
    * llVisAudit do AfterRowColChange legado. this_lUsuarioSupervisor e
    * this_lPodeAuditar decidem se chk_4c_Auditado fica visivel/habilitado
    * para o usuario corrente.
    *==========================================================================
    PROTECTED FUNCTION VerificarPermissaoAuditoria()
        LOCAL loc_cUsuario

        loc_cUsuario = UPPER(ALLTRIM(TratarNulo(gc_4c_UsuarioLogado, "")))

        * Richard em 29/11/2016 - Eliminando SUPERVIS (a consulta a
        * SigCdUsu.supervis foi comentada no legado - *!* no fonte
        * original - preservado: so o usuario 4CONTROL eh supervisor)
        THIS.this_lUsuarioSupervisor = (loc_cUsuario == "4CONTROL")

        IF THIS.this_lUsuarioSupervisor
            THIS.this_lPodeAuditar = .T.
        ELSE
            IF EMPTY(THIS.this_cAuditorAtual) AND fChecaAcesso("SIGPRHPR", "AUDITORIA")
                THIS.this_lPodeAuditar = .T.
            ELSE
                THIS.this_lPodeAuditar = (loc_cUsuario == UPPER(ALLTRIM(THIS.this_cAuditorAtual)))
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarSubniveis - equivalente ao bloco final do AfterRowColChange
    * legado: Zap In crSubniveis + Scan/Insert Into a partir de SigMvPec x
    * SigCdOpe. Chave EmpDopNums eh POSICIONAL (emps(3)+dopes(20)+
    * Str(numes,6) = 29) - PADR explicito, nunca ALLTRIM nas partes
    * (CLAUDE.md regra #42).
    *==========================================================================
    FUNCTION CarregarSubniveis()
        LOCAL loc_lResultado, loc_cSQL, loc_cEdn

        loc_lResultado = .F.

        IF USED("cursor_4c_Subniveis")
            USE IN cursor_4c_Subniveis
        ENDIF
        CREATE CURSOR cursor_4c_Subniveis (Emps C(3), Dopes C(20), Numes N(6))
        INDEX ON Emps TAG Emps

        loc_cEdn = PADR(THIS.this_cEmpsAtual, 3) + PADR(THIS.this_cDopesAtual, 20) + STR(THIS.this_nNumesAtual, 6)

        loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
            "FROM SigMvPec a, SigCdOpe b " + ;
            "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + " " + ;
            "AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
            "ORDER BY 1, 2, 3"

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_SubniveisTemp", "Subniveis")
            IF USED("cursor_4c_SubniveisTemp")
                SELECT cursor_4c_SubniveisTemp
                SCAN
                    INSERT INTO cursor_4c_Subniveis (Emps, Dopes, Numes) ;
                        VALUES (cursor_4c_SubniveisTemp.Emps, cursor_4c_SubniveisTemp.Dopes, VAL(cursor_4c_SubniveisTemp.Numes))
                ENDSCAN
                USE IN cursor_4c_SubniveisTemp
            ENDIF
            loc_lResultado = .T.
        ENDIF

        IF USED("cursor_4c_Subniveis")
            GO TOP IN cursor_4c_Subniveis
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarAuditoria - equivalente ao chkAuditado.Click do legado: grava
    * (UPDATE SigMvHst) auditors/dtaudits do registro corrente - a UNICA
    * escrita real deste form. BEGIN/COMMIT/ROLLBACK TRANSACTION em LOTE
    * unico (os dois UPDATEs na mesma transacao).
    *==========================================================================
    FUNCTION AtualizarAuditoria(par_lMarcarAuditado)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet1, loc_nRet2

        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cCidChavesAtual)
            THIS.this_cMensagemErro = "Nenhum registro selecionado para auditoria."
            RETURN .F.
        ENDIF

        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trn")
        IF USED("cursor_4c_Trn")
            USE IN cursor_4c_Trn
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(SPACE(10)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet1 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud1")
        IF USED("cursor_4c_UpdAud1")
            USE IN cursor_4c_UpdAud1
        ENDIF

        IF par_lMarcarAuditado
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ELSE
            loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChavesAtual)
        ENDIF
        loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdAud2")
        IF USED("cursor_4c_UpdAud2")
            USE IN cursor_4c_UpdAud2
        ENDIF

        IF loc_nRet1 < 0 OR loc_nRet2 < 0
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
            IF USED("cursor_4c_Rb")
                USE IN cursor_4c_Rb
            ENDIF
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + CHR(13) + CapturarErroSQL()
            loc_lResultado = .F.
        ELSE
            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
            IF USED("cursor_4c_Cmt")
                USE IN cursor_4c_Cmt
            ENDIF

            IF par_lMarcarAuditado
                THIS.this_cAuditorAtual = PADR(gc_4c_UsuarioLogado, 10)
                THIS.this_dDtAuditAtual = DATETIME()
            ELSE
                THIS.this_cAuditorAtual = SPACE(10)
                THIS.this_dDtAuditAtual = {}
            ENDIF

            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                REPLACE cursor_4c_Dados.auditors WITH THIS.this_cAuditorAtual, ;
                        cursor_4c_Dados.dtaudits  WITH THIS.this_dDtAuditAtual
            ENDIF

            THIS.RegistrarAuditoria("UPDATE")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarDocumentoCadastrado - equivalente a
    * ThisForm.poDataMgr.ChkRegister(tabela, campo, valor) do legado:
    * confirma se existe registro com a chave informada. Usado pelo botao
    * Movimento para decidir entre abrir o documento ja efetivado
    * (SigMvCab) ou a necessidade ainda em aberto (SigCdNec).
    *==========================================================================
    FUNCTION VerificarDocumentoCadastrado(par_cTabela, par_cCampoChave, par_cValorChave)
        LOCAL loc_lResultado, loc_cSQL

        loc_lResultado = .F.

        loc_cSQL = "SELECT COUNT(*) AS Total FROM " + par_cTabela + ;
            " WHERE " + par_cCampoChave + " = " + EscaparSQL(par_cValorChave)

        IF THIS.ExecutarSQL(loc_cSQL, "cursor_4c_VerDoc", "VerificarDocumento")
            IF USED("cursor_4c_VerDoc")
                loc_lResultado = (NVL(cursor_4c_VerDoc.Total, 0) > 0)
                USE IN cursor_4c_VerDoc
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

