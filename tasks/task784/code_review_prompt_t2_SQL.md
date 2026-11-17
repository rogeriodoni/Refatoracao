# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTADS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, DTALTS, DTBAIXAS

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
  ControlSource = ""
Select crLclMvItn
Delete All For Dopes + Str(Numes, 6) = TmpPends.Dopes + Str(TmpPends.Numes, 6)
Select TmpOperacao
If Seek(lnNumNivel, 'TmpOperacao', 'Codigos')
	Delete
lcQuery = [Update SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Desmarca - Update - SigMvCab)')
If Seek(lnNumNivel, 'TmpOperacao', 'Codigos' )
	Select TmpPends
	Select TmpPends
lcQuery = [Update SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Marca - Update - SigMvCab)')
Select crLclMvItn
Delete All For Empty(Cpros)
Select TmpOperacao
Insert Into TmpOperacao (Codigos) Values (lnNumNivel)
Select crItens
 	Insert Into crLclMvItn From Memvar
Select crLclMvItn
 	Insert Into crLclMvItn (Emps, Dopes, Numes, cItens) ;
Select crSigMvCab
Select crLclMvItn
Select TmpOperacao
Delete All For Empty(Codigos)
lcQuery = [Select Emps, Dopes, Numes, MascNum, Datas, Valos, ChkSubn, GrupoOs, GrupoDs, ContaOs, ContaDs ] + ;
		    [From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'PendEest') < 1)
Select PendEest
	If PendEest.ChkSubn And Not Seek(Val(lcNumeroNivel + Transf(PendEest.Numes, '@L 999999')), 'TmpOperacao', 'Codigos')
	_Flag = Seek(Val(lcNumeroNivel + Transform(Numes, '@L 999999')), 'TmpOperacao', 'Codigos')
	Insert Into TmpPends (Flag, Emps, Dopes, Numes, Mascnum, Datas, Origem, Destino, Valos) ;
	.Seleciona.ControlSource = 'TmpPends.Flag'
	.Operacao.ControlSource  = 'TmpPends.Dopes'
	.Codigo.ControlSource 	 = 'TmpPends.MascNum'
	.Data.ControlSource 	 = 'TmpPends.Datas'
	.Grupo.ControlSource 	 = 'TmpPends.Origem'
	.Conta.ControlSource 	 = 'TmpPends.Destino'
	.Column8.ControlSource 	 = 'TmpPends.Valos'
	Select TmpPends
Select TmpPends
Select TmpPends

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPdt.prg) - TRECHOS RELEVANTES PARA PASS SQL (2035 linhas total):

*-- Linhas 267 a 285:
267:     * por fim, a CARGA da grade.
268:     *
269:     * A carga vai por CarregarLista, que orquestra
270:     * this_oBusinessObject.CarregarPendencias() (o SELECT que popula
271:     * cursor_4c_Pendentes) e religa a grade. O .F. dela equivale ao
272:     * "Return 0" do Init legado, que abortava a abertura da tela.
273:     *
274:     * AjustarBotoesPorModo fica DEPOIS de TornarControlesVisiveis de
275:     * proposito - ver o comentario no corpo.
276:     *==========================================================================
277:     PROTECTED PROCEDURE InicializarForm()
278:         LOCAL loc_lSucesso, loc_oErro
279:         loc_lSucesso = .F.
280: 
281:         TRY
282:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
283:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
284: 
285:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpPdtBO")

*-- Linhas 478 a 496:
478:     * Left=72, Width=622, Height=148, ColumnCount=8, Visible=.T. - mais o que
479:     * vem da classe fwgrade do framework.vcx e o SCX nao sobrepoe
480:     * (docs\FRAMEWORK_class_codigo_fonte.txt): AllowHeaderSizing=.F.,
481:     * AllowRowSizing=.F., DeleteMark=.F., RecordMark=.F., ScrollBars=2,
482:     * GridLineColor=238,238,238, HighlightBackColor=90,90,90.
483:     *
484:     * Nao ha PageFrame neste form (ver cabecalho do arquivo) - Top/Left sao
485:     * absolutos ao form, sem compensacao de -29 (essa regra eh exclusiva de
486:     * frmcadastro).
487:     *
488:     * As colunas e o RecordSource ficam em VincularGrade, chamado aqui e de
489:     * novo apos this_oBusinessObject.CarregarPendencias() (Fase 8) - ver a
490:     * justificativa no cabecalho de VincularGrade (Problema 48/regra #41).
491:     *==========================================================================
492:     PROTECTED PROCEDURE ConfigurarGrade()
493:         LOCAL loc_oErro
494: 
495:         TRY
496:             THIS.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 508 a 566:
508:                 .AllowHeaderSizing = .F.
509:                 .AllowRowSizing    = .F.
510:                 .RecordMark        = .F.
511:                 .DeleteMark        = .F.
512:                 .GridLineColor     = RGB(238, 238, 238)
513:                 .HighlightBackColor = RGB(90, 90, 90)
514:                 .Visible           = .T.
515:             ENDWITH
516: 
517:             THIS.VincularGrade()
518:         CATCH TO loc_oErro
519:             MsgErro(loc_oErro.Message + CHR(13) + ;
520:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
521:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
522:         ENDTRY
523:     ENDPROC
524: 
525:     *==========================================================================
526:     * GarantirCursorGrade - garante que cursor_4c_Pendentes EXISTE antes de
527:     * qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41 -
528:     * Column.ControlSource de cursor que ainda nao existe derruba o Init: o
529:     * ALIAS inexistente estoura dentro do TRY de InicializarForm, que devolve
530:     * .F., CREATEOBJECT devolve .F. e o usuario clica no menu e nada
531:     * acontece, sem erro visivel).
532:     *
533:     * O cursor REAL (populado pelo SELECT em SigMvCab) so existe depois de
534:     * this_oBusinessObject.CarregarPendencias() rodar (Fase 8), e so pode
535:     * rodar com o form PAI (crSigMvCab/TmpOperacao) ja aberto - na abertura
536:     * por harness/probe ou ValidarUIFidelity esses cursores nao existem.
537:     *
538:     * Estrutura EXATA do cursor que SigOpPdtBO.CarregarPendencias monta
539:     * (CREATE CURSOR cursor_4c_Pendentes, ver o BO) - os nomes e os tipos sao
540:     * o que a grade consulta ao vincular; o BO SEMPRE recria este alias
541:     * inteiro (USE IN + CREATE CURSOR), nunca faz APPEND FROM dentro dele.
542:     *==========================================================================
543:     PROTECTED PROCEDURE GarantirCursorGrade()
544:         LOCAL loc_cAlias, loc_oErro
545: 
546:         TRY
547:             loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
548: 
549:             IF !EMPTY(loc_cAlias)
550:                 IF !USED(loc_cAlias)
551:                     CREATE CURSOR (loc_cAlias) ( ;
552:                         Flag    L,     ;
553:                         Emps    C(3),  ;
554:                         Dopes   C(20), ;
555:                         Numes   N(6),  ;
556:                         MascNum C(6),  ;
557:                         Datas   T,     ;
558:                         TpFats  C(3),  ;
559:                         Origem  C(21), ;
560:                         Destino C(21), ;
561:                         Valos   N(12, 2) )
562: 
563:                     *-- Os MESMOS dois TAGs que SigOpPdtBO.CarregarPendencias
564:                     *-- cria no cursor real, transcritos do Init legado
565:                     *-- ("Index On Emps + Dopes + Str(Numes, 6) Tag EmpDopNum"
566:                     *-- e "Index On Numes Tag Numes"). O placeholder precisa

*-- Linhas 586 a 612:
586:     * POR QUE TUDO DE COLUNA MORA AQUI, e nao em ConfigurarGrade: atribuir
587:     * ColumnCount RECRIA os objetos Column (descartando Width, Header1.
588:     * Caption, CurrentControl, ReadOnly); e o BO fecha e recria o alias
589:     * inteiro (USE IN + CREATE CURSOR) em CarregarPendencias, o que derruba
590:     * RecordSource/ControlSource. Configurar coluna uma unica vez na
591:     * montagem seria apagado na primeira carga - a grade abriria com
592:     * "Header1"/colunas de 90px (Problema 48/CLAUDE.md regra #41).
593:     *
594:     * ORDEM obrigatoria: Grid.ReadOnly (ANTES das colunas - regra #18, o do
595:     * grid propaga e sobrescreveria o das colunas) -> ColumnCount ->
596:     * RecordSource -> Column.ControlSource -> resto da coluna (Width por
597:     * ultimo, pois RecordSource/ControlSource recalculam para o default 90).
598:     *
599:     * WITH de cada Column fica FORA do WITH do grid (regra CLAUDE.md #44 -
600:     * WITH aninhado com .AddObject dentro ignora propriedades em silencio).
601:     *
602:     * Colunas (ordem visual = ordem do dump/layout.json, ver mapeamento.json
603:     * e o cabecalho de SigOpPdtBO.prg para a estrutura do alias
604:     * cursor_4c_Pendentes):
605:     *   1 "seleciona" (checkbox, Flag)       - unica coluna EDITAVEL; o
606:     *       toggle real (InteractiveChange -> Marcar/DesmarcarPendencia) fica
607:     *       em GradeSelecaoInteractiveChange, ligado por VincularEventosGrade
608:     *       no fim deste metodo; aqui a renderizacao (AddObject +
609:     *       CurrentControl + Sparse = .F., regra #18)
610:     *   2 "empresa" (Emps)        - "Emp"
611:     *   3 "operacao" (Dopes)      - "Opera" + CHR(231) + CHR(227) + "o"
612:     *   4 "codigo" (MascNum)      - "C" + CHR(243) + "d" - numero do

*-- Linhas 680 a 698:
680:             *-- Columns (destruindo o Check1), mas nao se pode contar com
681:             *-- isso quando o valor atribuido eh o mesmo de antes.
682:             WITH loc_oGrid.Column1
683:                 .ControlSource = loc_cAlias + ".Flag"
684:                 .FontName      = "Courier New"
685:                 .FontSize      = 9
686:                 .Movable       = .F.
687:                 .Resizable     = .F.
688:                 .Sparse        = .F.
689:                 .ForeColor     = RGB(0, 0, 0)
690: 
691:                 IF !PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
692:                     .AddObject("Check1", "CheckBox")
693:                 ENDIF
694: 
695:                 .Check1.Caption   = ""
696:                 .Check1.FontName  = "Tahoma"
697:                 .Check1.FontSize  = 8
698:                 .Check1.Alignment = 0

*-- Linhas 717 a 836:
717: 
718:             *-- 2 - "empresa" <- Emps
719:             WITH loc_oGrid.Column2
720:                 .ControlSource = loc_cAlias + ".Emps"
721:                 .FontName      = "Arial"
722:                 .FontSize      = 8
723:                 .Movable       = .F.
724:                 .Resizable     = .F.
725:                 .ReadOnly      = .T.
726:                 .ForeColor     = RGB(0, 0, 0)
727:                 .Header1.FontName  = "Arial"
728:                 .Header1.FontSize  = 8
729:                 .Header1.Alignment = 2
730:                 .Header1.Caption   = "Emp"
731:                 .Width             = 25
732:             ENDWITH
733: 
734:             *-- 3 - "operacao" <- Dopes
735:             WITH loc_oGrid.Column3
736:                 .ControlSource = loc_cAlias + ".Dopes"
737:                 .FontName      = "Arial"
738:                 .FontSize      = 8
739:                 .Movable       = .F.
740:                 .Resizable     = .F.
741:                 .ReadOnly      = .T.
742:                 .ForeColor     = RGB(0, 0, 0)
743:                 .Header1.FontName  = "Arial"
744:                 .Header1.FontSize  = 8
745:                 .Header1.Alignment = 2
746:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
747:                 .Width             = 110
748:             ENDWITH
749: 
750:             *-- 4 - "codigo" <- MascNum (numero do documento FORMATADO)
751:             WITH loc_oGrid.Column4
752:                 .ControlSource = loc_cAlias + ".MascNum"
753:                 .FontName      = "Arial"
754:                 .FontSize      = 8
755:                 .Movable       = .F.
756:                 .Resizable     = .F.
757:                 .ReadOnly      = .T.
758:                 .ForeColor     = RGB(0, 0, 0)
759:                 .Header1.FontName  = "Arial"
760:                 .Header1.FontSize  = 8
761:                 .Header1.Alignment = 2
762:                 .Header1.Caption   = "C" + CHR(243) + "d"
763:                 .Width             = 40
764:             ENDWITH
765: 
766:             *-- 5 - "data" <- Datas
767:             WITH loc_oGrid.Column5
768:                 .ControlSource = loc_cAlias + ".Datas"
769:                 .FontName      = "Arial"
770:                 .FontSize      = 8
771:                 .Movable       = .F.
772:                 .Resizable     = .F.
773:                 .ReadOnly      = .T.
774:                 .ForeColor     = RGB(0, 0, 0)
775:                 .Header1.FontName  = "Verdana"
776:                 .Header1.FontSize  = 8
777:                 .Header1.Alignment = 2
778:                 .Header1.ForeColor = RGB(36, 84, 155)
779:                 .Header1.Caption   = "Data"
780:                 .Width             = 60
781:             ENDWITH
782: 
783:             *-- 6 - "Grupo" <- Origem
784:             WITH loc_oGrid.Column6
785:                 .ControlSource = loc_cAlias + ".Origem"
786:                 .FontName      = "Arial"
787:                 .FontSize      = 8
788:                 .Movable       = .F.
789:                 .Resizable     = .F.
790:                 .ReadOnly      = .T.
791:                 .ForeColor     = RGB(0, 0, 0)
792:                 .Header1.FontName  = "Verdana"
793:                 .Header1.FontSize  = 8
794:                 .Header1.Alignment = 2
795:                 .Header1.ForeColor = RGB(36, 84, 155)
796:                 .Header1.Caption   = "Origem"
797:                 .Width             = 130
798:             ENDWITH
799: 
800:             *-- 7 - "Conta" <- Destino
801:             WITH loc_oGrid.Column7
802:                 .ControlSource = loc_cAlias + ".Destino"
803:                 .FontName      = "Arial"
804:                 .FontSize      = 8
805:                 .Movable       = .F.
806:                 .Resizable     = .F.
807:                 .ReadOnly      = .T.
808:                 .ForeColor     = RGB(0, 0, 0)
809:                 .Header1.FontName  = "Verdana"
810:                 .Header1.FontSize  = 8
811:                 .Header1.Alignment = 2
812:                 .Header1.ForeColor = RGB(36, 84, 155)
813:                 .Header1.Caption   = "Destino"
814:                 .Width             = 130
815:             ENDWITH
816: 
817:             *-- 8 - "Column8" <- Valos
818:             *-- InputMask "999,999.99" transcrita do dump (a coluna eh a unica
819:             *-- do legado com mascara - formata o valor do documento).
820:             WITH loc_oGrid.Column8
821:                 .ControlSource = loc_cAlias + ".Valos"
822:                 .FontName      = "Arial"
823:                 .FontSize      = 8
824:                 .Movable       = .F.
825:                 .Resizable     = .F.
826:                 .ReadOnly      = .T.
827:                 .InputMask     = "999,999.99"
828:                 .ForeColor     = RGB(0, 0, 0)
829:                 .Header1.FontName  = "Verdana"
830:                 .Header1.FontSize  = 8
831:                 .Header1.Alignment = 2
832:                 .Header1.ForeColor = RGB(36, 84, 155)
833:                 .Header1.Caption   = "Valor"
834:                 .Width             = 75
835:             ENDWITH
836: 

*-- Linhas 854 a 872:
854:     * POR QUE no fim de VincularGrade, e nao em ConfigurarGrade (medido no
855:     * VFP9 em 2026-11-13):
856:     *
857:     *   1) O BO fecha o alias (USE IN + CREATE CURSOR) para refazer a grade, e
858:     *      FECHAR O ALIAS QUE EH RecordSource DERRUBA AS COLUNAS - no probe o
859:     *      ColumnCount caiu de 3 para 0 e Column1 virou "Unknown member".
860:     *      Logo o Check1 reconstruido por VincularGrade eh um objeto NOVO, e
861:     *      as ligacoes do anterior morreram com ele: sem religar aqui, o
862:     *      checkbox reaparece na tela e NAO alterna mais nada - o usuario ve
863:     *      a caixa, clica, e o vinculo nunca eh gravado (sem erro, sem log).
864:     *
865:     *   2) Grid.ReadOnly PROPAGA para Column.ReadOnly e SOBRESCREVE o que a
866:     *      coluna tinha (medido: Column2.ReadOnly = .T. volta a .F. depois de
867:     *      Grid.ReadOnly = .F.; regra CLAUDE.md #18/#46). VincularGrade
868:     *      atribui Grid.ReadOnly no TOPO, entao o gate de modo da coluna 1 so
869:     *      sobrevive se for aplicado DEPOIS - e eh por isso que ele mora em
870:     *      AjustarBotoesPorModo, chamado no FIM deste metodo.
871:     *
872:     * BINDEVENT REPETIDO eh seguro: o VFP9 DEDUPLICA o mesmo quadruplo

*-- Linhas 893 a 913:
893:             *-- ABRE com "=DoDefault()", ou seja ele CONTA com o toggle
894:             *-- NATIVO e so reage ao valor resultante. E o toggle nativo de
895:             *-- fato funciona neste caso, medido no VFP9: o alias eh
896:             *-- CREATE CURSOR local (gravavel) com Flag LOGICO, e atribuir
897:             *-- Check1.Value PROPAGA para a coluna do cursor pelo
898:             *-- ControlSource. O quarteto com NODEFAULT eh para o caso oposto
899:             *-- (legado que SUPRIME o toggle nativo) e aqui alternaria DUAS
900:             *-- vezes, anulando o clique.
901:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
902:                 BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", ;
903:                     THIS, "GradeSelecaoInteractiveChange")
904:             ENDIF
905: 
906:             *-- (b) "PROCEDURE GotFocus / ThisForm.Grade.Seleciona.
907:             *-- fwcheckbox1.SetFocus" de Text1 das colunas de CONSULTA
908:             *-- (empresa, operacao, data, Grupo, Conta e Column8 no dump - as
909:             *-- seis que o legado declara). O foco sempre volta para a coluna
910:             *-- de selecao, a unica editavel da tela.
911:             *--
912:             *-- A coluna 4 ("codigo") NAO entra: o dump nao declara GotFocus
913:             *-- nela (o controle dela eh "Ingrid1", classe ingrid do

*-- Linhas 1257 a 1285:
1257: 
1258:     *==========================================================================
1259:     * CarregarLista - carga da grade. Equivale ao trecho do Init legado que
1260:     * monta TmpPends (Create Cursor + o SELECT em SigMvCab + o Scan que
1261:     * resolve Origem/Destino e grava as linhas) e, no fim, liga a grade ao
1262:     * cursor ("With ThisForm.Grade / .RecordSource = 'TmpPends' / ...").
1263:     *
1264:     * A montagem do cursor mora no BO (SigOpPdtBO.CarregarPendencias - PILAR
1265:     * 3: o form nao emite SQL); aqui ficam a orquestracao, o rebind da grade
1266:     * e o repintar.
1267:     *
1268:     * VincularGrade DEPOIS da carga eh OBRIGATORIO: o BO fecha e recria o
1269:     * alias inteiro (USE IN + CREATE CURSOR), o que derruba RecordSource/
1270:     * ControlSource e as larguras das colunas (Problema 48/regra #41).
1271:     *
1272:     * Retorno .F. equivale ao "Return 0" do Init legado (que abortava a
1273:     * abertura da tela) - so acontece quando a consulta FOI tentada e falhou.
1274:     *
1275:     * Pulado (sem erro, devolvendo .T.) em modo de teste/validacao de UI, sem
1276:     * gnConnHandle, ou quando crSigMvCab (cursor do FORM PAI, contrato de
1277:     * abertura deste dialogo) nao esta aberto - nesses casos a grade fica
1278:     * ligada ao cursor placeholder de GarantirCursorGrade e a tela abre
1279:     * vazia, em vez de exibir erro de conexao num probe.
1280:     *
1281:     * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
1282:     * THIS.oForm.CarregarLista() de FORA da classe (regra CLAUDE.md #3).
1283:     *==========================================================================
1284:     PROCEDURE CarregarLista()
1285:         LOCAL loc_lResultado, loc_lSemConexao, loc_lModoValidacaoOuTeste, loc_oErro

*-- Linhas 1346 a 1424:
1346: 
1347:             IF !EMPTY(loc_cAlias)
1348:                 IF USED(loc_cAlias)
1349:                     SELECT (loc_cAlias)
1350:                     GO TOP
1351:                 ENDIF
1352:             ENDIF
1353: 
1354:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1355:                 THIS.grd_4c_Dados.Refresh()
1356:             ENDIF
1357:         CATCH TO loc_oErro
1358:             MsgErro(loc_oErro.Message + CHR(13) + ;
1359:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1360:                 "Procedure: " + loc_oErro.Procedure, "Erro em RepintarGrade")
1361:         ENDTRY
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * BtnSelTudoClick - PROCEDURE Click de SelTudo no legado:
1366:     *
1367:     *   Select TmpPends
1368:     *   Scan For Not Flag
1369:     *       Replace Flag With ThisForm.Marca(.t.)
1370:     *   EndScan
1371:     *   ThisForm.Grade.Refresh
1372:     *
1373:     * "Marca(.t.)" eh SigOpPdtBO.MarcarPendencia(.T.) - o .T. eh o
1374:     * "llAutomatico" do legado, que SUPRIME os avisos de bloqueio (percorrendo
1375:     * a lista inteira o usuario nao pode levar um modal por linha). Flag
1376:     * recebe o RESULTADO: pendencia recusada continua desmarcada, exatamente
1377:     * como no legado.
1378:     *
1379:     * O laco eh DO WHILE com RECNO/GOTO explicitos, e nao SCAN: MarcarPendencia
1380:     * troca a area de trabalho corrente (abre cursores proprios de SigCdOpe/
1381:     * SigMvCab), e um SCAN cujo corpo muda o SELECT aplicaria o SKIP no alias
1382:     * errado.
1383:     *==========================================================================
1384:     PROCEDURE BtnSelTudoClick()
1385:         LOCAL loc_cAlias, loc_nRec, loc_lMarcou, loc_lAlgumMarcou, loc_oErro
1386: 
1387:         loc_lAlgumMarcou = .F.
1388: 
1389:         TRY
1390:             loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
1391: 
1392:             IF !EMPTY(loc_cAlias)
1393:                 IF USED(loc_cAlias)
1394:                     SELECT (loc_cAlias)
1395:                     GO TOP
1396: 
1397:                     DO WHILE !EOF(loc_cAlias)
1398:                         loc_nRec = RECNO(loc_cAlias)
1399: 
1400:                         IF !EVALUATE(loc_cAlias + ".Flag")
1401:                             loc_lMarcou = THIS.this_oBusinessObject.MarcarPendencia(.T.)
1402:                             REPLACE Flag WITH loc_lMarcou IN (loc_cAlias)
1403: 
1404:                             IF loc_lMarcou
1405:                                 loc_lAlgumMarcou = .T.
1406:                             ENDIF
1407:                         ENDIF
1408: 
1409:                         SELECT (loc_cAlias)
1410:                         GOTO loc_nRec
1411:                         SKIP 1
1412:                     ENDDO
1413: 
1414:                     *-- Cauda do Marca() legado. O legado a executa a cada
1415:                     *-- iteracao do "Scan For Not Flag"; aqui ela roda UMA vez
1416:                     *-- no fim, com o mesmo resultado visivel (as tres
1417:                     *-- descricoes sao sempre recalculadas de crSigMvCab, que
1418:                     *-- no fim do laco ja tem o estado final) e sem repintar o
1419:                     *-- form pai uma vez por linha.
1420:                     IF loc_lAlgumMarcou
1421:                         THIS.AtualizarFormPai()
1422:                     ENDIF
1423: 
1424:                     THIS.RepintarGrade()

*-- Linhas 1434 a 1483:
1434:     *==========================================================================
1435:     * BtnApagaClick - PROCEDURE Click de apaga no legado:
1436:     *
1437:     *   Select TmpPends
1438:     *   Scan For Flag
1439:     *       Replace Flag With .f.
1440:     *       =ThisForm.Desmarca()
1441:     *   EndScan
1442:     *   ThisForm.Grade.Refresh
1443:     *
1444:     * Ordem TRANSCRITA: o legado limpa o Flag ANTES de chamar Desmarca()
1445:     * (SigOpPdtBO.DesmarcarPendencia), e nao depende do retorno dela. Mesmo
1446:     * laco explicito de BtnSelTudoClick, pelo mesmo motivo (o BO troca a area
1447:     * de trabalho corrente).
1448:     *==========================================================================
1449:     PROCEDURE BtnApagaClick()
1450:         LOCAL loc_cAlias, loc_nRec, loc_oErro
1451: 
1452:         TRY
1453:             loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
1454: 
1455:             IF !EMPTY(loc_cAlias)
1456:                 IF USED(loc_cAlias)
1457:                     SELECT (loc_cAlias)
1458:                     GO TOP
1459: 
1460:                     DO WHILE !EOF(loc_cAlias)
1461:                         loc_nRec = RECNO(loc_cAlias)
1462: 
1463:                         IF EVALUATE(loc_cAlias + ".Flag")
1464:                             REPLACE Flag WITH .F. IN (loc_cAlias)
1465:                             THIS.this_oBusinessObject.DesmarcarPendencia()
1466:                         ENDIF
1467: 
1468:                         SELECT (loc_cAlias)
1469:                         GOTO loc_nRec
1470:                         SKIP 1
1471:                     ENDDO
1472: 
1473:                     THIS.RepintarGrade()
1474:                 ENDIF
1475:             ENDIF
1476:         CATCH TO loc_oErro
1477:             MsgErro(loc_oErro.Message + CHR(13) + ;
1478:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1479:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnApagaClick")
1480:         ENDTRY
1481:     ENDPROC
1482: 
1483:     *==========================================================================

*-- Linhas 1536 a 1561:
1536:     *     a chamada sem argumento ja produz o default certo, sem PCOUNT.
1537:     *   - "This.Value = ThisForm.Marca()" eh REVERSAO: pendencia recusada
1538:     *     volta a desmarcada. Atribuir Check1.Value grava no cursor pelo
1539:     *     ControlSource (medido no VFP9), que eh exatamente o efeito do
1540:     *     legado.
1541:     *
1542:     * NAO chama RepintarGrade: aquele metodo faz "GO TOP" (fiel ao Init e aos
1543:     * dois Click, que recarregam a lista inteira) e aqui isso JOGARIA O
1544:     * CURSOR PARA A PRIMEIRA LINHA a cada marcacao - o usuario marca a linha
1545:     * 5 e o foco salta para a 1. O legado tambem nao repinta neste evento: a
1546:     * celula se redesenha sozinha pelo ControlSource.
1547:     *
1548:     * PUBLIC (sem PROTECTED): BINDEVENT com delegado PROTECTED ESTOURA
1549:     * ("Property <X> is not found", medido) dentro do TRY de InicializarForm,
1550:     * o que viraria "a tela nao abre" (regra CLAUDE.md #3).
1551:     *==========================================================================
1552:     PROCEDURE GradeSelecaoInteractiveChange()
1553:         IF THIS.this_lEmToggleSelecao
1554:             RETURN
1555:         ENDIF
1556: 
1557:         THIS.this_lEmToggleSelecao = .T.
1558:         THIS.GradeSelecaoInteractiveChangeExec()
1559:         THIS.this_lEmToggleSelecao = .F.
1560:     ENDPROC
1561: 

*-- Linhas 1620 a 1651:
1620:             IF loc_lProsseguir
1621:                 loc_oChk = THIS.grd_4c_Dados.Column1.Check1
1622: 
1623:                 SELECT (loc_cAlias)
1624:                 loc_nRec = RECNO(loc_cAlias)
1625: 
1626:                 IF !loc_oChk.Value
1627:                     *-- "If Not This.Value / ThisForm.Desmarca"
1628:                     THIS.this_oBusinessObject.DesmarcarPendencia()
1629:                     THIS.ReposicionarPendencia(loc_cAlias, loc_nRec)
1630:                 ELSE
1631:                     *-- "Else / This.Value = ThisForm.Marca()" - a atribuicao
1632:                     *-- do RETORNO eh a reversao: recusado volta a desmarcado.
1633:                     loc_lAceito = THIS.this_oBusinessObject.MarcarPendencia()
1634: 
1635:                     *-- Reposicionar ANTES de tocar em Check1.Value: a
1636:                     *-- atribuicao grava no cursor pelo ControlSource, e o BO
1637:                     *-- acabou de mover a area de trabalho corrente.
1638:                     THIS.ReposicionarPendencia(loc_cAlias, loc_nRec)
1639: 
1640:                     IF !loc_lAceito
1641:                         loc_oChk.Value = .F.
1642:                     ELSE
1643:                         *-- Cauda do Marca() legado: so roda quando a
1644:                         *-- pendencia foi ACEITA (o legado tambem nao chega
1645:                         *-- la nos ramos que dao "Return .f.").
1646:                         THIS.AtualizarFormPai()
1647:                     ENDIF
1648:                 ENDIF
1649:             ENDIF
1650:         CATCH TO loc_oErro
1651:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 1663 a 1723:
1663:     * SigMvCab) e portanto TROCAM a area de trabalho corrente; algumas
1664:     * validacoes ainda navegam o proprio cursor de pendencias. Quem chama o
1665:     * BO e depois mexe no cursor da grade - REPLACE, leitura de coluna ou
1666:     * atribuicao a Check1.Value (que grava pelo ControlSource) - precisa
1667:     * repor os dois, senao escreve na LINHA ERRADA sem erro nenhum.
1668:     *
1669:     * O BETWEEN eh necessario: nada garante que o registro ainda exista
1670:     * depois de o BO rodar, e GOTO fora da faixa estoura ("Record is out of
1671:     * range").
1672:     *==========================================================================
1673:     PROTECTED PROCEDURE ReposicionarPendencia(par_cAlias, par_nRecno)
1674:         IF !USED(par_cAlias)
1675:             RETURN
1676:         ENDIF
1677: 
1678:         SELECT (par_cAlias)
1679: 
1680:         IF BETWEEN(par_nRecno, 1, RECCOUNT(par_cAlias))
1681:             GOTO par_nRecno
1682:         ENDIF
1683:     ENDPROC
1684: 
1685:     *==========================================================================
1686:     * AtualizarFormPai - a CAUDA do PROCEDURE Marca() do legado, que a
1687:     * migracao havia descartado:
1688:     *
1689:     *   Select crSigMvCab
1690:     *   With ThisForm.ParentForm.Pagina.Dados
1691:     *       ...CursorQuery('SigCdCli','crCli','IClis',crSigMvCab.ContaOs,'RClis')
1692:     *       .Origem.get_dconta.Value      = crCli.RClis   (ou '')
1693:     *       .Destino.get_dconta.Value     = crCli.RClis   (ou '')
1694:     *       .Responsavel.get_dconta.Value = crCli.RClis   (ou '')
1695:     *       .Refresh
1696:     *   Endwith
1697:     *
1698:     * Marcar uma pendencia PUXA grupo e conta de origem, de destino e do
1699:     * responsavel para o documento corrente (os "REPLACE ... IN crSigMvCab"
1700:     * de SigOpPdtBO.MarcarPendencia) e resolve as tres razoes sociais em
1701:     * SigCdCli (SigOpPdtBO.ObterDescricaoConta, que ja deixa o resultado em
1702:     * this_cOrigemDesc/this_cDestinoDesc/this_cResponsavelDesc).
1703:     *
1704:     * No legado os campos Grupo/Conta do form PAI tem
1705:     * ControlSource = "crSigMvCab.<coluna>", entao o ".Refresh" final ja os
1706:     * repintava sozinho; so as tres DESCRICOES, que nao tem ControlSource,
1707:     * precisavam de atribuicao explicita. No sistema novo o form pai NAO usa
1708:     * ControlSource na pagina de Dados (carrega os campos por BOParaForm, a
1709:     * partir das properties do BO dele), logo NADA se repinta sozinho: sem
1710:     * esta chamada o usuario escolhe a pendencia, a origem/destino sao
1711:     * gravadas no cursor e a tela de movimentacao continua exibindo os
1712:     * valores ANTIGOS. E o efeito nao eh so visual - o Salvar seguinte leria
1713:     * os campos velhos de volta pelo FormParaBO do pai e DESFARIA o que foi
1714:     * puxado.
1715:     *
1716:     * Quem conhece o layout do pai eh o PAI (PILAR 3): este metodo so avisa,
1717:     * entregando as tres descricoes; o form pai se repinta no proprio
1718:     * AtualizarDadosPendencia (que tambem re-sincroniza o BO dele com as
1719:     * colunas que o BO deste dialogo acabou de gravar em crSigMvCab).
1720:     *
1721:     * PEMSTATUS nos DOIS niveis porque (a) o harness de teste, o probe e o
1722:     * ValidarUIFidelity instanciam este dialogo SEM pai (this_oFormPai =
1723:     * .NULL.) e (b) pai sem o metodo nao pode derrubar a tela. O metodo do

*-- Linhas 1779 a 1797:
1779:     *
1780:     *   PROCEDURE Valid                       PROCEDURE LostFocus
1781:     *   If Not Empty(This.Value)              If (TmpPends.Numes == This.Value) ;
1782:     *       Select TmpPends                      Or (This.Value = 0)
1783:     *       Set Order To Numes                       ThisForm.Grade.Seleciona. ;
1784:     *       Set Near On                                  fwcheckbox1.SetFocus
1785:     *       Seek This.Value                   EndIf
1786:     *       Set Near Off
1787:     *       ThisForm.Refresh
1788:     *       If (This.Value == TmpPends.Numes)
1789:     *           This.Value = 0
1790:     *       Else
1791:     *           Return 0
1792:     *       EndIf
1793:     *   EndIf
1794:     *
1795:     * As duas moram no MESMO handler porque, no legado, o LostFocus so chega a
1796:     * rodar quando o Valid NAO recusou o valor - o "Return 0" mantem o foco no
1797:     * campo e aborta a saida. Dai o loc_lProsseguir: codigo inexistente para o

*-- Linhas 1856 a 1874:
1856: 
1857:             *-- Transcricao do Valid legado.
1858:             IF loc_lProsseguir AND !EMPTY(loc_nProcurado)
1859:                 SELECT (loc_cAlias)
1860:                 SET ORDER TO Numes
1861:                 SET NEAR ON
1862:                 SEEK loc_nProcurado
1863:                 SET NEAR OFF
1864: 
1865:                 *-- "ThisForm.Refresh" do legado: REPINTA, sem mexer no
1866:                 *-- ponteiro. NAO chamar RepintarGrade aqui - o GO TOP dele
1867:                 *-- desfaria o posicionamento que o SEEK acabou de obter.
1868:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1869:                     THIS.grd_4c_Dados.Refresh()
1870:                 ENDIF
1871: 
1872:                 IF loc_nProcurado == EVALUATE(loc_cAlias + ".Numes")
1873:                     *-- Achou exatamente: o legado ZERA o campo (a busca ja
1874:                     *-- levou a grade ate a linha procurada).


### BO (C:\4c\projeto\app\classes\SigOpPdtBO.prg):
*==============================================================================
* SigOpPdtBO.prg - Business Object para FormSigOpPdt (operacoes em aberto)
* Herda de BusinessBase
*
* Origem legado: tasks\task784\SigOpPdt.SCX (form SIGOPPDT, DataSession = 2,
* WindowType = 1 - dialogo MODAL aberto pela tela de movimentacao SigMvCab
* para marcar/desmarcar quais operacoes em aberto ficam vinculadas ao
* documento corrente).
*
* ATENCAO - ESTE DIALOGO NAO TEM TABELA PROPRIA NO SQL SERVER:
* o Init legado cria o cursor de exibicao TmpPends a partir de um SELECT em
* SigMvCab (armazenado em PendEest) e usa TRES cursores que pertencem ao
* FORM PAI (crSigMvCab, crLclMvItn, TmpOperacao - ver Init/Marca/Desmarca do
* dump legado). A gravacao da marcacao/desmarcacao eh um UPDATE direto em
* SigMvCab (coluna ChkSubn), nao um Inserir/Atualizar de registro proprio -
* por isso this_cTabela fica vazio (ver Init) e a persistencia real sera
* feita em metodos dedicados (fase 2), nao em Inserir()/Atualizar().
*
* Estrutura EXATA do cursor de exibicao (transcrita do Create Cursor legado):
*   TmpPends ( Flag l, Emps c(3), Dopes c(20), Numes n(6), MascNum c(6),
*              Datas t Null, TpFats c(3), Origem c(21), Destino c(21),
*              Valos n(12,2) )
*              Index on Emps + Dopes + Str(Numes, 6) Tag EmpDopNum
*              Index on Numes Tag Numes
*
* Chave de cada linha da grade (lcNivel no legado) = Emps + Dopes + Str(Numes,6),
* usada no WHERE EmpDopNums = '<lcNivel>' do UPDATE SigMvCab em Marca/Desmarca.
*
* Cursores do FORM PAI (SigMvCab), CONTRATO - nomes NAO renomeados:
*   crSigMvCab   - cabecalho do movimento corrente (Emps, Dopes, Numes,
*                  ContaOs, ContaDs, GrupoOs, GrupoDs, GrVends, Vends, Obses)
*   crLclMvItn   - cursor local de itens do movimento corrente
*   TmpOperacao  - cursor de controle (Codigos) com os niveis ja vinculados
*
* FASE 1/8: declaracao de TODAS as propriedades + Init.
* FASE 2/8: CarregarPendencias (reproduz o SELECT em SigMvCab + filtros de
* conta do Init legado), CarregarDoCursor (linha corrente -> propriedades),
* MarcarPendencia/DesmarcarPendencia (equivalentes a Marca/Desmarca) e
* ObterChavePrimaria. Inserir/Atualizar/ExecutarExclusao ficam com o default
* herdado - este dialogo nao insere nem exclui registro proprio nenhum.
*==============================================================================
DEFINE CLASS SigOpPdtBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da LINHA CORRENTE do cursor de exibicao (TmpPends), uma
    * para cada coluna da grade de 8 colunas do legado (seleciona, empresa,
    * operacao, codigo, data, Grupo=Origem, Conta=Destino, Column8=valor)
    *--------------------------------------------------------------------------
    this_lFlag     = .F.   && Flag      l       - pendencia esta marcada (vinculada)
    this_cEmps     = ""    && Emps      c(3)    - empresa do documento pendente
    this_cDopes    = ""    && Dopes     c(20)   - codigo da operacao (SigCdOpe.Dopes)
    this_nNumes    = 0     && Numes     n(6)    - numero do documento pendente
    this_cMascNum  = ""    && MascNum   c(6)    - numero do documento formatado p/ exibicao
    this_dDatas    = {}    && Datas     t       - data/hora do documento pendente
    this_cTpFats   = ""    && TpFats    c(3)    - tipo de fatura (nao exibido na grade,
                           && mas faz parte da estrutura do cursor legado)
    this_cOrigem   = ""    && Origem    c(21)   - "GrupoOs/ContaOs" resolvido no Init
    this_cDestino  = ""    && Destino   c(21)   - "GrupoDs/ContaDs" resolvido no Init
    this_nValos    = 0     && Valos     n(12,2) - valor do documento pendente

    *--------------------------------------------------------------------------
    * Variaveis de sessao do dialogo, calculadas UMA VEZ no Init legado a
    * partir de crSigMvCab.Dopes (consulta a SigCdOpe) e reaproveitadas
    * durante o ciclo de vida da tela - decidem como Origem/Destino sao
    * resolvidos e filtrados (equivalente a lcDopesNivel, lnPuxaOrigem,
    * lnPuxaDestino, lcNumeroNivel do Init; FixGOrigs/FixGDests/ConOSubs/
    * ConDSubs sao relidos em Marca a partir da operacao do documento
    * CORRENTE, mas com a MESMA semantica)
    *--------------------------------------------------------------------------
    this_cDopesNivel    = ""   && TempOpe.Nivels  - codigo de operacao "nivel" do documento
    this_cNumeroNivel   = ""   && Str(TempOpe.NDopes, 4) - numero sequencial da operacao nivel
    this_nPuxaOrigem    = 0    && TempOpe.ConOSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_nPuxaDestino   = 0    && TempOpe.ConDSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_lFixGOrigs     = .F.  && TempOpe.FixGOrigs - grupo de origem fixo (nao sobrescrever)
    this_lFixGDests     = .F.  && TempOpe.FixGDests - grupo de destino fixo (nao sobrescrever)

    *--------------------------------------------------------------------------
    * Escolha operacional herdada do form pai (ThisForm.Op_Escolha =
    * ThisForm.Parentform.pcEscolha no legado). Controla se o checkbox de
    * marcacao esta habilitado (When = Op_Escolha = 'INSERIR') e se os
    * botoes SelTudo/Apaga agem (When = Inlist(Op_Escolha,'INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    this_cOpEscolha = ""

    *--------------------------------------------------------------------------
    * Descricoes resolvidas (SigCdCli.RClis) apos Marcar/Desmarcar uma
    * pendencia - equivalente ao bloco final de Marca() do legado que
    * preenchia ThisForm.ParentForm.Pagina.Dados.Origem/Destino/Responsavel.
    * get_dconta.Value. Aqui ficam disponiveis como SAIDA de dados para o
    * FORM repassar ao form pai (BO nunca toca em controle de outro form).
    *--------------------------------------------------------------------------
    this_cOrigemDesc      = ""
    this_cDestinoDesc     = ""
    this_cResponsavelDesc = ""

    *--------------------------------------------------------------------------
    * Cursores proprios deste dialogo (nomenclatura nova - PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorPendentes = "cursor_4c_Pendentes"  && migrado de TmpPends (grade)
    this_cCursorPendEest  = "cursor_4c_PendEest"   && migrado de PendEest (SELECT em SigMvCab)
    this_cCursorTempOpe   = "cursor_4c_TempOpe"    && migrado de TempOpe (lookup SigCdOpe)
    this_cCursorCli       = "cursor_4c_Cli"        && migrado de crCli (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Cursores do FORM PAI (SigMvCab) - CONTRATO, nomes do legado preservados
    * de proposito (ver cabecalho do arquivo). Este dialogo entra na data
    * session do form pai (par_nDataSession recebido pelo Form) e LE/ESCREVE
    * nesses cursores sem recria-los.
    *--------------------------------------------------------------------------
    this_cCursorSigMvCab    = "crSigMvCab"
    this_cCursorLclMvItn    = "crLclMvItn"
    this_cCursorTmpOperacao = "TmpOperacao"

    *--------------------------------------------------------------------------
    * Tabelas do SQL Server consultadas/atualizadas por este dialogo
    *--------------------------------------------------------------------------
    this_cTabelaSigMvCab = "SigMvCab"
    this_cTabelaSigCdOpe = "SigCdOpe"
    this_cTabelaSigMvItn = "SigMvItn"
    this_cTabelaSigCdCli = "SigCdCli"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * this_cTabela fica VAZIO de proposito: este dialogo nao persiste um
    * registro proprio (ver cabecalho) - a gravacao eh um UPDATE direto em
    * SigMvCab.ChkSubn, feito por metodo dedicado na fase 2. O campo chave
    * eh Numes, que eh o indice usado pelo legado para localizar a pendencia
    * ao digitar o numero no campo de procura (Get_Procura.Valid faz
    * Set Order To Numes / Seek This.Value em TmpPends).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Numes"

                *-- Estado inicial da linha corrente - zerado aqui (e nao so na
                *-- declaracao) para que reusar a mesma instancia do BO numa
                *-- segunda abertura do dialogo nunca exiba dados da anterior.
                THIS.this_lFlag     = .F.
                THIS.this_cEmps     = ""
                THIS.this_cDopes    = ""
                THIS.this_nNumes    = 0
                THIS.this_cMascNum  = ""
                THIS.this_dDatas    = {}
                THIS.this_cTpFats   = ""
                THIS.this_cOrigem   = ""
                THIS.this_cDestino  = ""
                THIS.this_nValos    = 0

                THIS.this_cDopesNivel  = ""
                THIS.this_cNumeroNivel = ""
                THIS.this_nPuxaOrigem  = 0
                THIS.this_nPuxaDestino = 0
                THIS.this_lFixGOrigs   = .F.
                THIS.this_lFixGDests   = .F.

                THIS.this_cOpEscolha = ""

                THIS.this_cOrigemDesc      = ""
                THIS.this_cDestinoDesc     = ""
                THIS.this_cResponsavelDesc = ""

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE de cursor_4c_Pendentes (o
    * cursor de exibicao, equivalente a TmpPends do legado) para as
    * propriedades this_* da linha. Chamado antes de Marcar/Desmarcar e pelo
    * Form sempre que precisar ler os dados da linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_lFlag    = Flag
                    THIS.this_cEmps    = TratarNulo(Emps, "")
                    THIS.this_cDopes   = TratarNulo(Dopes, "")
                    THIS.this_nNumes   = TratarNulo(Numes, 0)
                    THIS.this_cMascNum = TratarNulo(MascNum, "")
                    THIS.this_dDatas   = TratarNulo(Datas, {})
                    THIS.this_cTpFats  = TratarNulo(TpFats, "")
                    THIS.this_cOrigem  = TratarNulo(Origem, "")
                    THIS.this_cDestino = TratarNulo(Destino, "")
                    THIS.this_nValos   = TratarNulo(Valos, 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Monta a chave POSICIONAL EmpDopNums (Emps char(3)
    * + Dopes char(20) + Str(Numes,6) = 29 chars) da LINHA CORRENTE, a partir
    * das propriedades carregadas por CarregarDoCursor. PADR explicito em
    * cada parte (regra #42) - NUNCA ALLTRIM nas partes internas, senao a
    * chave nunca casa com SigMvCab.EmpDopNums.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Resolve a razao social (SigCdCli.RClis) de um
    * codigo de conta (IClis). Equivalente ao
    * "ThisForm.poDataMgr.CursorQuery('SigCdCli','crCli','IClis',<cod>,'RClis')
    * + If Not Eof('crCli') ... Else ''" repetido 3x no final de Marca().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoConta(par_cCodigo)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT RClis FROM " + THIS.this_cTabelaSigCdCli + ;
                           " WHERE IClis = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado > 0
                    IF !EOF("cursor_4c_Cli")
                        loc_cDescricao = TratarNulo(cursor_4c_Cli.RClis, "")
                    ENDIF
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendencias - Monta cursor_4c_Pendentes (grade de exibicao,
    * equivalente a TmpPends) a partir do movimento corrente (crSigMvCab,
    * cursor do FORM PAI). Transcricao literal do PROCEDURE Init do legado
    * (a parte de montagem de dados - o restante do Init, que cria o
    * FormSigOpPdt e configura a grade, fica na FASE 3/Form).
    *
    * Pre-requisitos (contrato do form pai, ver cabecalho do arquivo):
    *   - crSigMvCab posicionado no documento corrente
    *   - TmpOperacao aberto (cursor de niveis ja vinculados)
    *
    * Retorno: .T. com cursor_4c_Pendentes populado (GO TOP); .F. em falha,
    * com this_cMensagemErro preenchido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPendencias()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_cDopesNivel, loc_cNumeroNivel, loc_nPuxaOrigem, loc_nPuxaDestino
        LOCAL loc_cEd1, loc_cEd2, loc_cOrigem, loc_cDestino, loc_lFlag, loc_nNivelAtual

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursor de controle do movimento (TmpOperacao) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_Pendentes")
                    USE IN cursor_4c_Pendentes
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Pendentes ;
                    (Flag L, Emps C(3), Dopes C(20), Numes N(6), MascNum C(6), ;
                     Datas T, TpFats C(3), Origem C(21), Destino C(21), Valos N(12,2))
                SET NULL OFF
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON Numes TAG Numes

                SELECT TmpOperacao
                DELETE ALL FOR EMPTY(Codigos)

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT Nivels, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cDopesNivel  = TratarNulo(cursor_4c_TempOpe.Nivels, "")
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cNumeroNivel = STR(TratarNulo(cursor_4c_TempOpe.NDopes, 0), 4)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cEd1 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(0, 6)
                loc_cEd2 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(999999, 6)

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, Valos, ChkSubn, GrupoOs, GrupoDs, ContaOs, ContaDs" + ;
                           " FROM " + THIS.this_cTabelaSigMvCab + ;
                           " WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_PendEest
                SCAN
                    loc_nNivelAtual = VAL(loc_cNumeroNivel + TRANSFORM(cursor_4c_PendEest.Numes, "@L 999999"))

                    IF cursor_4c_PendEest.ChkSubn AND !SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")
                        LOOP
                    ENDIF

                    loc_cOrigem  = ""
                    loc_cDestino = ""

                    IF INLIST(loc_nPuxaOrigem, 1, 2)
                        IF loc_nPuxaOrigem = 1
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                    ENDIF

                    IF INLIST(loc_nPuxaDestino, 1, 2)
                        IF loc_nPuxaDestino = 1
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                    ENDIF

                    loc_lFlag = SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")

                    INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Datas, Origem, Destino, Valos) ;
                        VALUES (loc_lFlag, cursor_4c_PendEest.Emps, cursor_4c_PendEest.Dopes, cursor_4c_PendEest.Numes, ;
                                cursor_4c_PendEest.MascNum, cursor_4c_PendEest.Datas, loc_cOrigem, loc_cDestino, ;
                                cursor_4c_PendEest.Valos)
                ENDSCAN

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                SELECT cursor_4c_Pendentes
                GO TOP

                THIS.this_cDopesNivel  = loc_cDopesNivel
                THIS.this_cNumeroNivel = loc_cNumeroNivel
                THIS.this_nPuxaOrigem  = loc_nPuxaOrigem
                THIS.this_nPuxaDestino = loc_nPuxaDestino

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPendencia - vincula a pendencia CORRENTE de cursor_4c_Pendentes
    * ao documento corrente (crSigMvCab), gravando o vinculo em
    * SigMvCab.ChkSubn. Equivalente ao PROCEDURE Marca() do legado - esta EH
    * a persistencia real deste dialogo (ver cabecalho do arquivo: nao ha
    * Inserir()/Atualizar() de registro proprio porque o dado gravado
    * pertence a SigMvCab, nao a uma tabela deste BO).
    *
    * par_lAutomatico (.T./.F.) suprime os MsgAviso de bloqueio - equivalente
    * a "llAutomatico" do legado, usado pelo botao "Selecionar Tudo".
    *
    * Apos marcar com sucesso, this_cOrigemDesc/this_cDestinoDesc/
    * this_cResponsavelDesc ficam com a razao social resolvida (SigCdCli)
    * das contas de Origem/Destino/Responsavel de crSigMvCab, para o FORM
    * repassar aos controles do form pai.
    *
    * Retorno: .T. se marcou com sucesso; .F. se bloqueado ou se falhou a
    * gravacao (mensagem em this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPendencia(par_lAutomatico)
        LOCAL loc_lResultado, loc_lProsseguir, loc_lAutomatico
        LOCAL loc_cNivel, loc_nNumNivel, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lFixGOrigs, loc_lFixGDests
        LOCAL loc_nItens

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_lAutomatico = (par_lAutomatico = .T.)
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crLclMvItn") OR !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursores do movimento corrente (crLclMvItn/TmpOperacao) nao estao abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                    IF !loc_lAutomatico
                        MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Digitada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.this_cMensagemErro = "Movimentacao ja digitada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT FixGDests, FixGOrigs, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    loc_lFixGOrigs   = cursor_4c_TempOpe.FixGOrigs
                    loc_lFixGDests   = cursor_4c_TempOpe.FixGDests
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT ChkSubn, Obses, GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends FROM " + ;
                           THIS.this_cTabelaSigMvCab + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                DO CASE
                    CASE cursor_4c_PendEest.ChkSubn
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao ja utilizada em outra operacao."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaDs) AND cursor_4c_PendEest.ContaDs <> crSigMvCab.ContaDs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaOs) AND cursor_4c_PendEest.ContaOs <> crSigMvCab.ContaOs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 1, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crLclMvItn
                DELETE ALL FOR EMPTY(Cpros)
                GO BOTTOM

                SELECT TmpOperacao
                INSERT INTO TmpOperacao (Codigos) VALUES (loc_nNumNivel)

                IF EMPTY(crSigMvCab.Obses)
                    REPLACE Obses WITH cursor_4c_PendEest.Obses IN crSigMvCab
                ENDIF

                IF INLIST(loc_nPuxaOrigem, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoOs) OR (EMPTY(crSigMvCab.ContaOs) AND !loc_lFixGOrigs)
                        REPLACE GrupoOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaOs)
                        REPLACE ContaOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF INLIST(loc_nPuxaDestino, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoDs) OR (EMPTY(crSigMvCab.ContaDs) AND !loc_lFixGDests)
                        REPLACE GrupoDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaDs)
                        REPLACE ContaDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF EMPTY(crSigMvCab.GrVends)
                    REPLACE GrVends WITH cursor_4c_PendEest.GrVends IN crSigMvCab
                ENDIF
                IF EMPTY(crSigMvCab.Vends)
                    IF crSigMvCab.GrVends = cursor_4c_PendEest.GrVends
                        REPLACE Vends WITH cursor_4c_PendEest.Vends IN crSigMvCab
                    ENDIF
                ENDIF

                USE IN cursor_4c_PendEest

                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                loc_cSQL = "SELECT * FROM " + THIS.this_cTabelaSigMvItn + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

                IF loc_nResultado >= 0
                    SELECT cursor_4c_Itens
                    SCAN
                        SCATTER MEMVAR MEMO
                        INSERT INTO crLclMvItn FROM MEMVAR
                    ENDSCAN

                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                ENDIF

                loc_nItens = 0
                SELECT crLclMvItn
                SET ORDER TO
                SCAN
                    IF EMPTY(Cpros)
                        LOOP
                    ENDIF
                    loc_nItens = loc_nItens + 1
                    REPLACE cItens WITH loc_nItens
                ENDSCAN

                GO TOP
                IF EOF()
                    INSERT INTO crLclMvItn (Emps, Dopes, Numes, cItens) ;
                        VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, loc_nItens + 1)
                ENDIF
                SET ORDER TO

                THIS.this_cOrigemDesc      = THIS.ObterDescricaoConta(crSigMvCab.ContaOs)
                THIS.this_cDestinoDesc     = THIS.ObterDescricaoConta(crSigMvCab.ContaDs)
                THIS.this_cResponsavelDesc = THIS.ObterDescricaoConta(crSigMvCab.Vends)

                THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_cTabela = ""

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarPendencia - desfaz o vinculo da pendencia CORRENTE de
    * cursor_4c_Pendentes com o documento corrente (crSigMvCab), gravando
    * SigMvCab.ChkSubn = 0. Equivalente ao PROCEDURE Desmarca() do legado.
    *
    * Retorno: .T. se desvinculou com sucesso; .F. em falha (mensagem em
    * this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarPendencia()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNivel, loc_nNumNivel
        LOCAL loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("crLclMvItn")
                    SELECT crLclMvItn
                    DELETE ALL FOR Dopes + STR(Numes, 6) = THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                ENDIF

                IF USED("TmpOperacao")
                    IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                        SELECT TmpOperacao
                        DELETE
                    ENDIF
                ENDIF

                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 0, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                    THIS.RegistrarAuditoria("UPDATE")
                    THIS.this_cTabela = ""

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - PROPOSITALMENTE nao sobrescritos.
    *
    * Este dialogo nao grava um registro proprio (ver cabecalho do arquivo
    * e comentario do Init): a gravacao real e o UPDATE SigMvCab.ChkSubn,
    * feito por MarcarPendencia()/DesmarcarPendencia() acima - que SAO, na
    * pratica, o Inserir()/Atualizar() desta tela. O comportamento padrao
    * herdado de BusinessBase (recusar a operacao) ja eh o correto para
    * estes tres metodos.
    *--------------------------------------------------------------------------

ENDDEFINE

