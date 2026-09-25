# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, EMPDOPNUMS, NATENDS, CODVENDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, EMPDOPNUMS, NATENDS, CODVENDS

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
This.Grade.Column2.ControlSource = []
This.Grade.Column3.ControlSource = []
This.Grade.Column4.ControlSource = []
SELECT codvends, SPACE(40) as desVends, nAtends from crSigmvate into cursor LocalVen readwrite
SELECT localVen
	If (Thisform.Podatamgr.SqlExecute([Select rclis From SigCdCli where grupos = ']+lcGrVen+[' and iclis =']+localVen.codVends+['], [crAuxVen]) < 1)
	SELECT localVen
This.Grade.Column2.ControlSource = [localVen.codVends]
This.Grade.Column3.ControlSource = [localVen.desVends]
This.Grade.Column4.ControlSource = [localVen.natends]
Select localVen
SELECT crSigMvAte
DELETE all for empdopnums = pcEDN
Select localVen
DELETE ALL for natends = 0
	INSERT into crSigmvAte (codvends, emps, empdopnums, natends, pkchaves) values;
SELECT localVen
SELECT localVen
Select localVen
Select localVen
SELECT localVen
Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvAte.prg) - TRECHOS RELEVANTES PARA PASS SQL (1257 linhas total):

*-- Linhas 102 a 120:
102:             IF USED("cursor_4c_LocalVen")
103:                 USE IN cursor_4c_LocalVen
104:             ENDIF
105:             CREATE CURSOR cursor_4c_LocalVen ;
106:                 (CodVends C(10) NULL, DesVends C(40) NULL, NAtends N(4,0) NULL)
107:             SET NULL OFF
108: 
109:             THIS.ConfigurarPageFrame()
110: 
111:             *-- Propaga o titulo para os labels do cabecalho
112:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:             *-- Carrega os atendimentos ja gravados para o documento
116:             *-- (sem conexao em modo de teste de UI)
117:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
118:                 THIS.CarregarLista()
119:             ENDIF
120: 

*-- Linhas 287 a 305:
287:                 .RowHeight          = 16
288:                 .ScrollBars         = 2
289:                 .ReadOnly           = .F.
290:                 .DeleteMark         = .F.
291:                 .RecordMark         = .F.
292:                 .GridLineColor      = RGB(238, 238, 238)
293:                 .HighlightBackColor = RGB(255, 255, 255)
294:                 .HighlightForeColor = RGB(15, 41, 104)
295:                 .HighlightStyle     = 2
296:             ENDWITH
297: 
298:             *-- Column1: Vendedor (CodVends)
299:             WITH loc_oGrd.Column1
300:                 .FontName  = "Verdana"
301:                 .FontSize  = 8
302:                 .Width     = 110
303:                 .Movable   = .F.
304:                 .Resizable = .F.
305:                 .ReadOnly  = .F.

*-- Linhas 361 a 381:
361:             *-- "Column.Width vai por ultimo")
362:             loc_oGrd.ColumnCount = 3
363:             loc_oGrd.RecordSource           = "cursor_4c_LocalVen"
364:             loc_oGrd.Column1.ControlSource  = "cursor_4c_LocalVen.CodVends"
365:             loc_oGrd.Column2.ControlSource  = "cursor_4c_LocalVen.DesVends"
366:             loc_oGrd.Column3.ControlSource  = "cursor_4c_LocalVen.NAtends"
367:             loc_oGrd.Column1.Header1.Caption = "Vendedor"
368:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
369:             loc_oGrd.Column3.Header1.Caption = "Atendimentos"
370:             loc_oGrd.Column1.Width           = 110
371:             loc_oGrd.Column2.Width           = 250
372:             loc_oGrd.Column3.Width           = 80
373:             *-- Gate do When legado da coluna Descricao: "Return EMPTY(
374:             *-- localven.codvends)". Column NAO tem DynamicReadOnly em VFP9,
375:             *-- entao o ReadOnly da coluna eh alternado por linha no
376:             *-- AfterRowColChange da grade - o proprio legado fecha o Init
377:             *-- chamando "ThisForm.Grade.AfterRowColChange()".
378:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeAfterRowColChange")
379:             THIS.AjustarColunaDescricao()
380: 
381:             BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarCodVenGrade")

*-- Linhas 434 a 474:
434:     *--------------------------------------------------------------------------
435:     * CarregarLista - (Re)carrega os atendimentos ja gravados do documento no
436:     * cursor_4c_LocalVen via BO e rebinda a grade (o BO fecha/recria o
437:     * cursor, entao RecordSource/ControlSource/Header/Width precisam ser
438:     * reaplicados - "Column.Width vai por ultimo").
439:     *--------------------------------------------------------------------------
440:     PROCEDURE CarregarLista()
441:         LOCAL loc_lOk, loc_oErro
442:         loc_lOk = .F.
443: 
444:         TRY
445:             loc_lOk = THIS.this_oBusinessObject.CarregarAtendimentosDocumento( ;
446:                 THIS.this_cEmpDopNums, THIS.this_cGrVends)
447: 
448:             IF loc_lOk AND USED("cursor_4c_LocalVen") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
449:                 THIS.grd_4c_Dados.RecordSource            = "cursor_4c_LocalVen"
450:                 THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_LocalVen.CodVends"
451:                 THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_LocalVen.DesVends"
452:                 THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_LocalVen.NAtends"
453:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Vendedor"
454:                 THIS.grd_4c_Dados.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
455:                 THIS.grd_4c_Dados.Column3.Header1.Caption = "Atendimentos"
456:                 THIS.grd_4c_Dados.Column1.Width           = 110
457:                 THIS.grd_4c_Dados.Column2.Width           = 250
458:                 THIS.grd_4c_Dados.Column3.Width           = 80
459:                 SELECT cursor_4c_LocalVen
460:                 GO TOP
461:                 THIS.grd_4c_Dados.Refresh()
462: 
463:                 *-- Gate do When legado da coluna Descricao (Column nao tem
464:                 *-- DynamicReadOnly em VFP9) - reaplicado para a linha corrente
465:                 *-- apos o rebind, como o Init legado faz ao chamar
466:                 *-- "ThisForm.Grade.AfterRowColChange()" depois do GO TOP
467:                 THIS.AjustarColunaDescricao()
468:             ENDIF
469:         CATCH TO loc_oErro
470:             MsgErro(loc_oErro.Message + CHR(13) + ;
471:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
472:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.CarregarLista")
473:         ENDTRY
474: 

*-- Linhas 546 a 576:
546: 
547:         loc_cVal = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
548: 
549:         SELECT cursor_4c_LocalVen
550: 
551:         IF EMPTY(loc_cVal)
552:             REPLACE CodVends WITH "", DesVends WITH ""
553:             THIS.grd_4c_Dados.Refresh()
554:             RETURN
555:         ENDIF
556: 
557:         REPLACE CodVends WITH loc_cVal
558: 
559:         IF THIS.VerificarVendedorDuplicado()
560:             MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
561:             SELECT cursor_4c_LocalVen
562:             REPLACE CodVends WITH "", DesVends WITH ""
563:             THIS.grd_4c_Dados.Refresh()
564:             RETURN
565:         ENDIF
566: 
567:         loc_cDesc = THIS.this_oBusinessObject.ObterDescricaoVendedor(THIS.this_cGrVends, loc_cVal)
568: 
569:         IF EMPTY(loc_cDesc)
570:             THIS.AbrirBuscaVenGrade()
571:         ELSE
572:             *-- Linha corrente -> BO (FormParaBO preserva o NAtends ja digitado),
573:             *-- aplica o vendedor resolvido e devolve BO -> linha corrente
574:             IF THIS.FormParaBO()
575:                 THIS.this_oBusinessObject.this_cCodVends  = loc_cVal
576:                 THIS.this_oBusinessObject.this_cDescVends = loc_cDesc

*-- Linhas 605 a 676:
605:         loc_cVal = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
606: 
607:         IF EMPTY(loc_cVal)
608:             SELECT cursor_4c_LocalVen
609:             REPLACE CodVends WITH "", DesVends WITH ""
610:             THIS.grd_4c_Dados.Refresh()
611:             RETURN
612:         ENDIF
613: 
614:         IF USED("cursor_4c_VenNomTemp")
615:             USE IN cursor_4c_VenNomTemp
616:         ENDIF
617: 
618:         TRY
619:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
620:                 SELECT TOP 1 iclis, rclis FROM SigCdCli
621:                 WHERE grupos = <<EscaparSQL(THIS.this_cGrVends)>>
622:                   AND RTRIM(rclis) = <<EscaparSQL(loc_cVal)>>
623:             ENDTEXT
624: 
625:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenNomTemp")
626: 
627:             IF loc_nResultado > 0 AND USED("cursor_4c_VenNomTemp") AND !EOF("cursor_4c_VenNomTemp")
628:                 *-- Linha corrente -> BO (FormParaBO preserva o NAtends ja
629:                 *-- digitado), aplica o vendedor resolvido pela razao social
630:                 *-- e devolve BO -> linha corrente
631:                 IF THIS.FormParaBO()
632:                     THIS.this_oBusinessObject.this_cCodVends  = ALLTRIM(cursor_4c_VenNomTemp.iclis)
633:                     THIS.this_oBusinessObject.this_cDescVends = ALLTRIM(cursor_4c_VenNomTemp.rclis)
634:                     THIS.BOParaForm()
635:                 ENDIF
636: 
637:                 SELECT cursor_4c_LocalVen
638: 
639:                 IF THIS.VerificarVendedorDuplicado()
640:                     MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
641:                     SELECT cursor_4c_LocalVen
642:                     REPLACE CodVends WITH "", DesVends WITH ""
643:                 ENDIF
644:                 THIS.grd_4c_Dados.Refresh()
645:             ELSE
646:                 THIS.AbrirBuscaVenGrade()
647:             ENDIF
648: 
649:             IF USED("cursor_4c_VenNomTemp")
650:                 USE IN cursor_4c_VenNomTemp
651:             ENDIF
652:         CATCH TO loc_oErro
653:             MsgErro(loc_oErro.Message, "Erro")
654:         ENDTRY
655:     ENDPROC
656: 
657:     *--------------------------------------------------------------------------
658:     * AbrirBuscaVenGrade - Picker de vendedor (SigCdCli) filtrado pelo grupo
659:     * de vendedores do documento (this_cGrVends), aplicado a linha corrente
660:     * da grade. Segue o padrao canonico AbrirBuscaVen (Formsigatcrp.prg):
661:     * pre-popula o cursor via SQLEXEC e passa ja pronto ao FormBuscaAuxiliar
662:     * (a API manual do FormBuscaAuxiliar nao popula cursor sozinha).
663:     *--------------------------------------------------------------------------
664:     PROCEDURE AbrirBuscaVenGrade()
665:         LOCAL loc_oBusca, loc_cValor, loc_cSQL, loc_nResultado, loc_cTitulo, ;
666:               loc_lProsseguir, loc_cCodSel, loc_cDescSel, loc_oErro
667: 
668:         IF !USED("cursor_4c_LocalVen")
669:             RETURN
670:         ENDIF
671: 
672:         loc_cValor = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
673:         IF EMPTY(loc_cValor)
674:             loc_cValor = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
675:         ENDIF
676: 

*-- Linhas 683 a 752:
683:         loc_lProsseguir = .T.
684:         TRY
685:             IF EMPTY(loc_cValor)
686:                 loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE grupos = " + ;
687:                     EscaparSQL(THIS.this_cGrVends) + " ORDER BY iclis"
688:             ELSE
689:                 loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE grupos = " + ;
690:                     EscaparSQL(THIS.this_cGrVends) + " AND (iclis LIKE " + ;
691:                     EscaparSQL(loc_cValor + "%") + " OR RTRIM(rclis) LIKE " + ;
692:                     EscaparSQL(loc_cValor + "%") + ") ORDER BY iclis"
693:             ENDIF
694:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVenGrade")
695: 
696:             IF (loc_nResultado < 1 OR !USED("cursor_4c_BuscaVenGrade") OR RECCOUNT("cursor_4c_BuscaVenGrade") = 0) ;
697:                     AND !EMPTY(loc_cValor)
698:                 IF USED("cursor_4c_BuscaVenGrade")
699:                     USE IN cursor_4c_BuscaVenGrade
700:                 ENDIF
701:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
702:                     "SELECT iclis, rclis FROM SigCdCli WHERE grupos = " + ;
703:                     EscaparSQL(THIS.this_cGrVends) + " ORDER BY iclis", ;
704:                     "cursor_4c_BuscaVenGrade")
705:             ENDIF
706: 
707:             IF loc_nResultado < 1 OR !USED("cursor_4c_BuscaVenGrade") OR RECCOUNT("cursor_4c_BuscaVenGrade") = 0
708:                 MsgAviso("Nenhum vendedor encontrado para este grupo.", "Vendedor")
709:                 loc_lProsseguir = .F.
710:             ENDIF
711: 
712:             IF loc_lProsseguir
713:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
714:                 IF VARTYPE(loc_oBusca) = "O"
715:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaVenGrade"
716:                     loc_oBusca.this_cTitulo        = loc_cTitulo
717:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
718:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
719:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
720:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
721:                     loc_oBusca.Show()
722: 
723:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVenGrade") AND USED("cursor_4c_LocalVen")
724:                         SELECT cursor_4c_BuscaVenGrade
725:                         loc_cCodSel  = ALLTRIM(cursor_4c_BuscaVenGrade.iclis)
726:                         loc_cDescSel = ALLTRIM(cursor_4c_BuscaVenGrade.rclis)
727: 
728:                         *-- Linha corrente -> BO (FormParaBO preserva o NAtends
729:                         *-- ja digitado), aplica o vendedor escolhido no picker
730:                         *-- e devolve BO -> linha corrente
731:                         IF THIS.FormParaBO()
732:                             THIS.this_oBusinessObject.this_cCodVends  = loc_cCodSel
733:                             THIS.this_oBusinessObject.this_cDescVends = loc_cDescSel
734:                             THIS.BOParaForm()
735:                         ENDIF
736: 
737:                         SELECT cursor_4c_LocalVen
738: 
739:                         IF THIS.VerificarVendedorDuplicado()
740:                             MsgAviso("Vendedor j" + CHR(225) + " inclu" + CHR(237) + "do!", "Aviso")
741:                             REPLACE CodVends WITH "", DesVends WITH ""
742:                         ENDIF
743:                     ENDIF
744:                     loc_oBusca.Release()
745:                 ENDIF
746:             ENDIF
747:         CATCH TO loc_oErro
748:             MsgErro(loc_oErro.Message, "Erro")
749:         ENDTRY
750: 
751:         IF USED("cursor_4c_BuscaVenGrade")
752:             USE IN cursor_4c_BuscaVenGrade

*-- Linhas 771 a 789:
771:             RETURN loc_lDuplicado
772:         ENDIF
773: 
774:         SELECT cursor_4c_LocalVen
775:         loc_nRecAtual = RECNO()
776:         loc_cCodVen   = ALLTRIM(CodVends)
777: 
778:         IF !EMPTY(loc_cCodVen)
779:             LOCATE FOR ALLTRIM(CodVends) == loc_cCodVen AND RECNO() != loc_nRecAtual
780:             loc_lDuplicado = FOUND()
781:         ENDIF
782: 
783:         IF BETWEEN(loc_nRecAtual, 1, RECCOUNT("cursor_4c_LocalVen"))
784:             GO loc_nRecAtual IN cursor_4c_LocalVen
785:         ENDIF
786: 
787:         RETURN loc_lDuplicado
788:     ENDPROC
789: 

*-- Linhas 810 a 828:
810:         TRY
811:             THIS.LockScreen = .T.
812: 
813:             SELECT cursor_4c_LocalVen
814:             LOCATE FOR EMPTY(ALLTRIM(CodVends))
815:             IF !FOUND()
816:                 APPEND BLANK
817:             ENDIF
818: 
819:             REPLACE CodVends WITH "", DesVends WITH "", NAtends WITH 0
820: 
821:             THIS.grd_4c_Dados.Refresh()
822: 
823:             *-- Entra em edicao na linha recem-criada. Como CodVends esta
824:             *-- vazio, BtnAlterarClick posiciona o foco na coluna do codigo
825:             *-- do vendedor - o mesmo "Thisform.grade.column2.SetFocus" que o
826:             *-- legado executa (Column2 do legado = Column1 aqui).
827:             THIS.BtnAlterarClick()
828: 

*-- Linhas 860 a 879:
860:         TRY
861:             THIS.LockScreen = .T.
862: 
863:             SELECT cursor_4c_LocalVen
864:             DELETE
865: 
866:             THIS.grd_4c_Dados.Refresh()
867: 
868:             THIS.LockScreen = .F.
869:         CATCH TO loc_oErro
870:             THIS.LockScreen = .F.
871:             MsgErro(loc_oErro.Message + CHR(13) + ;
872:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
873:                 "Procedure: " + loc_oErro.Procedure, "FormSigMvAte.BtnExcluirClick")
874:         ENDTRY
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------
878:     * PodeEditarDocumento - Reproduz o When dos botoes inserir/excluir do
879:     * legado ("Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))"). O modo

*-- Linhas 896 a 914:
896:         loc_lOk = .F.
897: 
898:         IF USED("cursor_4c_LocalVen")
899:             SELECT cursor_4c_LocalVen
900:             loc_lOk = (RECCOUNT("cursor_4c_LocalVen") > 0 AND !EOF() AND !BOF())
901:         ENDIF
902: 
903:         RETURN loc_lOk
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * BtnAlterarClick - Entra em edicao na linha corrente da grade.
908:     *
909:     * SIGMVATE nao tem botao "Alterar": a alteracao acontece digitando direto
910:     * na grade, e quem autoriza eh o par de regras do legado - o When de
911:     * inserir/excluir (INLIST(pcEscolha,'INSERIR','ALTERAR')) somado ao When da
912:     * coluna Descricao (RETURN EMPTY(localven.codvends)). Este metodo concentra
913:     * essas duas regras: valida a linha, aplica o mesmo gate e devolve o foco a
914:     * celula que o legado deixa editavel para a linha corrente - Codigo quando o

*-- Linhas 962 a 980:
962:     * documento (somente leitura): recarrega cursor_4c_LocalVen a partir de
963:     * SigMvAte via BO, que tambem reresolve a descricao de cada vendedor em
964:     * SigCdCli pelo grupo do documento - exatamente a consulta que o Init do
965:     * legado roda linha a linha no SCAN ("Select rclis From SigCdCli where
966:     * grupos = <grvends> and iclis = <codvends>").
967:     *
968:     * Nao grava nada e nao depende do modo do documento (serve em CONSULTAR).
969:     * Como recarregar descarta o que ainda nao foi confirmado, pede confirmacao
970:     * quando o documento esta editavel e a grade ja tem linhas.
971:     *
972:     * NAO cria botao proprio na tela (PILAR 1 - o legado nao tem): eh o ponto
973:     * de entrada programatico de consulta do form.
974:     *--------------------------------------------------------------------------
975:     PROCEDURE BtnVisualizarClick()
976:         LOCAL loc_lOk, loc_lProsseguir, loc_oErro
977: 
978:         loc_lOk         = .F.
979:         loc_lProsseguir = .T.
980: 

*-- Linhas 1012 a 1059:
1012: 
1013:     *--------------------------------------------------------------------------
1014:     * BtnSalvarClick - Apaga os atendimentos ja gravados do documento e
1015:     * reinsere as linhas atuais da grade com natends <> 0 (delete-all-then-
1016:     * reinsert, equivalente ao PROCEDURE Click de SIGMVATE.cntBotoes.btnConfirmar:
1017:     * "DELETE all for empdopnums = pcEDN" + "DELETE ALL for natends = 0" +
1018:     * SCAN/INSERT). Eh o metodo de gravacao do form - BtnConfirmarClick
1019:     * (nome do botao do legado, alvo do BINDEVENT) delega para ca.
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE BtnSalvarClick()
1022:         LOCAL loc_lSucesso, loc_oErro
1023: 
1024:         IF !USED("cursor_4c_LocalVen")
1025:             THIS.Release()
1026:             RETURN
1027:         ENDIF
1028: 
1029:         loc_lSucesso = .F.
1030: 
1031:         TRY
1032:             SELECT cursor_4c_LocalVen
1033:             GO TOP
1034:             THIS.grd_4c_Dados.Refresh()
1035: 
1036:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirTodosDoDocumento(THIS.this_cEmpDopNums)
1037: 
1038:             IF loc_lSucesso
1039:                 SELECT cursor_4c_LocalVen
1040:                 *-- "DELETE ALL for natends = 0" do legado: as linhas zeradas
1041:                 *-- nao sao reinseridas
1042:                 SCAN FOR NAtends != 0
1043:                     *-- NovoRegistro() antes do mapeamento: LimparDados() zera
1044:                     *-- this_cPkChaves, senao o 2o INSERT do laco colidiria no
1045:                     *-- indice unico com a PK da linha anterior
1046:                     THIS.this_oBusinessObject.NovoRegistro()
1047: 
1048:                     IF !THIS.FormParaBO()
1049:                         LOOP
1050:                     ENDIF
1051: 
1052:                     IF !THIS.this_oBusinessObject.Salvar()
1053:                         loc_lSucesso = .F.
1054:                         EXIT
1055:                     ENDIF
1056:                 ENDSCAN
1057:             ENDIF
1058:         CATCH TO loc_oErro
1059:             loc_lSucesso = .F.

*-- Linhas 1124 a 1142:
1124:         loc_lOk = .F.
1125: 
1126:         IF USED("cursor_4c_LocalVen") AND VARTYPE(THIS.this_oBusinessObject) = "O"
1127:             SELECT cursor_4c_LocalVen
1128: 
1129:             IF RECCOUNT("cursor_4c_LocalVen") > 0 AND ;
1130:                !EOF("cursor_4c_LocalVen") AND !BOF("cursor_4c_LocalVen")
1131: 
1132:                 *-- Colunas da linha corrente da grade
1133:                 THIS.this_oBusinessObject.this_cCodVends  = ALLTRIM(NVL(cursor_4c_LocalVen.CodVends, ""))
1134:                 THIS.this_oBusinessObject.this_cDescVends = ALLTRIM(NVL(cursor_4c_LocalVen.DesVends, ""))
1135:                 THIS.this_oBusinessObject.this_nAtends    = NVL(cursor_4c_LocalVen.NAtends, 0)
1136: 
1137:                 *-- Contexto do documento pai (SigMvCab), recebido no Init
1138:                 THIS.this_oBusinessObject.this_cEmps       = THIS.this_cEmps
1139:                 THIS.this_oBusinessObject.this_cEmpDopNums = THIS.this_cEmpDopNums
1140:                 THIS.this_oBusinessObject.this_cGrVends    = THIS.this_cGrVends
1141: 
1142:                 loc_lOk = .T.

*-- Linhas 1167 a 1185:
1167:         loc_lOk = .F.
1168: 
1169:         IF USED("cursor_4c_LocalVen") AND VARTYPE(THIS.this_oBusinessObject) = "O"
1170:             SELECT cursor_4c_LocalVen
1171: 
1172:             IF RECCOUNT("cursor_4c_LocalVen") > 0 AND ;
1173:                !EOF("cursor_4c_LocalVen") AND !BOF("cursor_4c_LocalVen")
1174: 
1175:                 REPLACE CodVends WITH THIS.this_oBusinessObject.this_cCodVends, ;
1176:                         DesVends WITH THIS.this_oBusinessObject.this_cDescVends, ;
1177:                         NAtends  WITH THIS.this_oBusinessObject.this_nAtends ;
1178:                     IN cursor_4c_LocalVen
1179: 
1180:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1181:                     THIS.grd_4c_Dados.Refresh()
1182:                 ENDIF
1183: 
1184:                 *-- Reaplica o When da coluna Descricao para a linha alterada
1185:                 *-- (com o codigo preenchido ela volta a ser somente leitura)


### BO (C:\4c\projeto\app\classes\SigMvAteBO.prg):
*====================================================================
* SigMvAteBO.prg
*
* Business Object para Atendimentos de Vendedores por Documento
* Tabela: SigMvAte
* Herda de: BusinessBase
*
* Form OPERACIONAL chamado a partir de um documento de movimento
* (SigMvCab): permite escolher, na grade, os vendedores que
* atenderam o pedido/documento e quantos atendimentos cada um teve.
* Ao Confirmar, o legado apaga os registros de SigMvAte do documento
* (empdopnums) e reinsere as linhas atuais da grade.
*====================================================================

DEFINE CLASS SigMvAteBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvAte)
    this_cCodVends   = ""    && codvends   char(10) - codigo do vendedor
    this_cEmps       = ""    && emps       char(3)  - empresa do documento
    this_cEmpDopNums = ""    && empdopnums char(29) - chave do documento pai (SigMvCab)
    this_nAtends     = 0     && natends    numeric(4,0) - quantidade de atendimentos
    this_cPkChaves   = ""    && pkchaves   char(20) - PK

    *-- Propriedade de exibicao (NAO persistida - descricao do vendedor,
    *-- obtida via lookup em SigCdCli.rclis Where grupos = this_cGrVends
    *-- and iclis = this_cCodVends)
    this_cDescVends  = ""

    *-- Contexto do documento pai (TprMvCab no legado), necessario para
    *-- filtrar/validar os vendedores deste documento nas proximas fases
    this_cGrVends    = ""    && grvends do SigMvCab - grupo de vendedores aceito

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvAte"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvAteBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * (chamado por NovoRegistro() antes de cada Inserir() do laco de
    * Confirmar - sem isso this_cPkChaves manteria o valor da linha
    * anterior e o segundo INSERT colidiria no indice unico)
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cCodVends   = ""
        THIS.this_cEmps       = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_nAtends     = 0
        THIS.this_cPkChaves   = ""
        THIS.this_cDescVends  = ""
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * (usado ao percorrer a grade local de atendimentos - ver Formcomp.
    * cursor tipico: crSigMvAte, populado via SELECT * FROM SigMvAte)
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodVends   = TratarNulo(codvends,   "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nAtends     = TratarNulo(natends,    "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * Inserir - Grava novo atendimento de vendedor para o documento
    * (equivale ao INSERT INTO crSigmvAte (...) do legado, feito para
    * cada linha da grade nao-zerada ao Confirmar; gera pkchaves novo)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvAte (codvends, emps, empdopnums, natends, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodVends)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigMvAteBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a quantidade de atendimentos do vendedor
    * para o documento (o legado nunca faz UPDATE de linha - apaga e
    * reinsere a grade inteira -, mas o metodo eh mantido para permitir
    * corrigir uma linha isolada sem afetar as demais do documento)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvAte
                SET codvends   = <<EscaparSQL(THIS.this_cCodVends)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    natends    = <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigMvAteBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o atendimento do vendedor pela pkchaves
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigMvAteBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirTodosDoDocumento - Apaga TODOS os atendimentos ja gravados
    * para o documento (empdopnums), replicando o
    * "Delete all for empdopnums = pcEDN" do legado antes de reinserir
    * a grade atual ao Confirmar (ver FormSigMvAte.BtnConfirmarClick)
    *====================================================================
    PROCEDURE ExcluirTodosDoDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + loException.Message, "SigMvAteBO.ExcluirTodosDoDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAtendimentosDocumento - Popula cursor_4c_LocalVen (cursor
    * local, editavel) com os vendedores ja gravados em SigMvAte para o
    * documento informado, buscando a descricao (Rclis) de cada vendedor
    * em SigCdCli filtrado pelo grupo de vendedores do documento.
    * Equivale ao trecho do Init do legado:
    *   SELECT codvends, SPACE(40) as desVends, nAtends FROM crSigmvate
    *   INTO CURSOR LocalVen READWRITE
    *   SCAN
    *       (busca RClis em SigCdCli where grupos=... and iclis=...)
    *   ENDSCAN
    * IMPORTANTE: a ordem dos campos do CREATE CURSOR abaixo tem de ser
    * IDENTICA ao cursor placeholder criado em
    * FormSigMvAte.InicializarForm (CodVends, DesVends, NAtends).
    *====================================================================
    PROCEDURE CarregarAtendimentosDocumento(par_cEmpDopNums, par_cGrVends)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDesc

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_AtendTemp")
                USE IN cursor_4c_AtendTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codvends, natends FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AtendTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_LocalVen")
                    USE IN cursor_4c_LocalVen
                ENDIF
                CREATE CURSOR cursor_4c_LocalVen ;
                    (CodVends C(10), DesVends C(40), NAtends N(4,0))

                IF USED("cursor_4c_AtendTemp")
                    SELECT cursor_4c_AtendTemp
                    GO TOP
                    SCAN
                        loc_cDesc = THIS.ObterDescricaoVendedor(par_cGrVends, ;
                            TratarNulo(cursor_4c_AtendTemp.codvends, "C"))

                        INSERT INTO cursor_4c_LocalVen (CodVends, DesVends, NAtends) ;
                            VALUES (TratarNulo(cursor_4c_AtendTemp.codvends, "C"), ;
                                    loc_cDesc, ;
                                    TratarNulo(cursor_4c_AtendTemp.natends, "N"))
                    ENDSCAN
                    USE IN cursor_4c_AtendTemp
                ENDIF

                SELECT cursor_4c_LocalVen
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar atendimentos:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarAtendimentosDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterDescricaoVendedor - Busca a razao social (Rclis) do vendedor
    * em SigCdCli, filtrando pelo grupo de vendedores do documento
    * (equivale a SqlExecute("Select rclis From SigCdCli where grupos =
    * ... and iclis = ...") do legado). Retorna "" se nao encontrado -
    * PUBLIC porque o Form chama para revalidar codigos digitados na grade.
    *====================================================================
    PROCEDURE ObterDescricaoVendedor(par_cGrVends, par_cCodVends)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(par_cCodVends)
            RETURN loc_cRetorno
        ENDIF

        TRY
            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT rclis FROM SigCdCli
                WHERE grupos = <<EscaparSQL(par_cGrVends)>>
                  AND iclis  = <<EscaparSQL(par_cCodVends)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenTemp")

            IF loc_nResultado > 0 AND USED("cursor_4c_VenTemp") AND RECCOUNT("cursor_4c_VenTemp") > 0
                loc_cRetorno = TratarNulo(cursor_4c_VenTemp.rclis, "C")
            ENDIF

            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF
        CATCH TO loException
            loc_cRetorno = ""
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

ENDDEFINE

