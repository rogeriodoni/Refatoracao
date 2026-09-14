# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CUNIS, FATORS, QTDS2, VALUE

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
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = "xnensi.cdescs"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select xNensi
Select xMFas
	Select xNensi
	Insert Into TmpDistrib (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
Select TmpDistrib
Select xNensi
Select TmpDistrib
	.Column6.ControlSource   = 'TmpDistrib.Nenvs'  					 && Envelope
	.Column1.ControlSource   = 'TmpDistrib.NOps'  					 && Ordem de Produção
	.Column2.ControlSource   = 'TmpDistrib.CodPds'  				 && Componente
	.Column5.ControlSource   = 'TmpDistrib.Qtds2'					 && Tipo de Material
	.Column4.ControlSource   = 'TmpDistrib.CUnis'					 && Unidade
	.Column7.ControlSource   = 'TmpDistrib.Pesos'					 && Peso na Fase Anterior
	.Column3.ControlSource   = 'TmpDistrib.cUniPs' 					 && Unidade do Peso
	.Column8.ControlSource   = 'TmpDistrib.Pesos2'					 && Peso Atual ( Balança )
	.Column9.ControlSource   = 'TmpDistrib.CodCors'					 && Cor
	.Column10.ControlSource   = 'TmpDistrib.CodTams'				 && Tamanho
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+xnensi.cunis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
			Select TmpDistrib
				Select TmpDistrib
					Select TmpDistrib
		Select TmpDistrib
			Select TmpDistrib
			Select TmpDistrib
Select xNensi
Select TmpDistrib
	Select xNensi
	If Not Seek(Str(TmpDistrib.Nops, 10) + TmpDistrib.CMats) && Tiago - 17/03/2016 - Não tem NLOTES no índice, com isso estava lançando varias vezes item agregado + Str(TmpDistrib.Nlotes, 10))
		Insert Into xNensi (CMats, Cunis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, Qtds, Pesos, TpOps, ;
Select xNensi
Select xNensi
Select xNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM14.prg) - TRECHOS RELEVANTES PARA PASS SQL (1390 linhas total):

*-- Linhas 471 a 489:
471:     *--------------------------------------------------------------------------
472:     * ConfigurarDescricao - label + campo descricao do componente na parte inferior
473:     * Origem: Say2 (Left=151, Top=565) + Get_descr (Left=223, Top=567, Width=353)
474:     * ControlSource original: xnensi.cdescs (acessivel via datasession do pai)
475:     *--------------------------------------------------------------------------
476:     PROTECTED PROCEDURE ConfigurarDescricao()
477:         *-- Label "Descricao :"
478:         THIS.AddObject("lbl_4c_LblDescricao", "Label")
479:         WITH THIS.lbl_4c_LblDescricao
480:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
481:             .Left      = 151
482:             .Top       = 565
483:             .BackStyle = 0
484:             .ForeColor = RGB(231,254,253)
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8
487:             .Visible   = .T.
488:         ENDWITH
489: 

*-- Linhas 511 a 529:
511:     PROTECTED PROCEDURE PreencherContainerOperacao()
512:         TRY
513:             IF USED("tmpnens") AND !EOF("tmpnens")
514:                 SELECT tmpnens
515:                 GO TOP
516:                 THIS.cnt_4c_Operacao.txt_4c_Empresa.Value  = TratarNulo(tmpnens.emps,  "C")
517:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = TratarNulo(tmpnens.dopps, "C")
518:                 THIS.cnt_4c_Operacao.txt_4c_Codigo.Value   = TratarNulo(tmpnens.numps, "N")
519:             ENDIF
520:         CATCH TO loc_oErro
521:             MsgErro(loc_oErro.Message, "Erro")
522:         ENDTRY
523:     ENDPROC
524: 
525:     *--------------------------------------------------------------------------
526:     * PreencherContainerMaterial - preenche campos do material com dados do BO
527:     * Dados carregados de xNensi via CarregarDoCursor no InicializarForm
528:     * Get_Pesof exibe Pesos (peso da fase) identico ao GetPeso (legado)
529:     *--------------------------------------------------------------------------

*-- Linhas 606 a 815:
606:             .HighlightBackColor = RGB(255,255,255)
607:             .HighlightForeColor = RGB(15,41,104)
608:             .HighlightStyle     = 2
609:             .DeleteMark         = .F.
610:             .RecordMark         = .F.
611:             .RowHeight          = 16
612:             .ScrollBars         = 2
613:             .Panel              = 1
614:             .ColumnCount        = 10
615: 
616:             *-- RecordSource primeiro para evitar reset de headers depois
617:             .RecordSource = "TmpDistrib"
618: 
619:             *-- Column1: NOps / Industrializacao (ColumnOrder=2, ReadOnly)
620:             WITH .Column1
621:                 .ColumnOrder       = 2
622:                 .Width             = 90
623:                 .Movable           = .F.
624:                 .Resizable         = .F.
625:                 .ReadOnly          = .T.
626:                 .Format            = "L"
627:                 .InputMask         = "9999999999"
628:                 .ControlSource     = "TmpDistrib.Nops"
629:                 .Header1.Caption   = loc_cTitulo
630:                 .Header1.Alignment = 2
631:                 .Header1.FontName  = "Tahoma"
632:                 .Header1.FontSize  = 8
633:                 .Text1.FontName    = "Courier New"
634:                 .Text1.BorderStyle = 0
635:                 .Text1.Margin      = 0
636:                 .Text1.ReadOnly    = .T.
637:                 .Text1.ForeColor   = RGB(0,0,0)
638:                 .Text1.BackColor   = RGB(255,255,255)
639:             ENDWITH
640: 
641:             *-- Column2: Pesos / Qtde Agregar (ColumnOrder=8, editavel condicional)
642:             WITH .Column2
643:                 .ColumnOrder       = 8
644:                 .Width             = 83
645:                 .Movable           = .F.
646:                 .Resizable         = .F.
647:                 .ReadOnly          = .F.
648:                 .ControlSource     = "TmpDistrib.Pesos"
649:                 .Header1.Caption   = "Qtde Agregar"
650:                 .Header1.Alignment = 2
651:                 .Header1.FontName  = "Tahoma"
652:                 .Header1.FontSize  = 8
653:                 .Text1.BorderStyle = 0
654:                 .Text1.Margin      = 0
655:                 .Text1.ForeColor   = RGB(0,0,0)
656:                 .Text1.BackColor   = RGB(255,255,255)
657:             ENDWITH
658: 
659:             *-- Column3: CUnis / Unid. (ColumnOrder=7, ReadOnly)
660:             WITH .Column3
661:                 .ColumnOrder       = 7
662:                 .Width             = 31
663:                 .Movable           = .F.
664:                 .Resizable         = .F.
665:                 .ReadOnly          = .T.
666:                 .ControlSource     = "TmpDistrib.CUnis"
667:                 .Header1.Caption   = "Unid."
668:                 .Header1.Alignment = 2
669:                 .Header1.FontName  = "Tahoma"
670:                 .Header1.FontSize  = 8
671:                 .Text1.BorderStyle = 0
672:                 .Text1.Margin      = 0
673:                 .Text1.ReadOnly    = .T.
674:                 .Text1.ForeColor   = RGB(0,0,0)
675:                 .Text1.BackColor   = RGB(255,255,255)
676:             ENDWITH
677: 
678:             *-- Column4: Pesos2 / Peso Fabr Agregar (ColumnOrder=10, editavel condicional)
679:             WITH .Column4
680:                 .ColumnOrder       = 10
681:                 .Width             = 95
682:                 .Movable           = .F.
683:                 .Resizable         = .F.
684:                 .ReadOnly          = .F.
685:                 .ControlSource     = "TmpDistrib.Pesos2"
686:                 .Header1.Caption   = "Peso Fabr Agregar"
687:                 .Header1.Alignment = 2
688:                 .Header1.FontName  = "Tahoma"
689:                 .Header1.FontSize  = 8
690:                 .Text1.BorderStyle = 0
691:                 .Text1.Margin      = 0
692:                 .Text1.ForeColor   = RGB(0,0,0)
693:                 .Text1.BackColor   = RGB(255,255,255)
694:             ENDWITH
695: 
696:             *-- Column5: cUniPs / Unid. (ColumnOrder=9, ReadOnly)
697:             WITH .Column5
698:                 .ColumnOrder       = 9
699:                 .Width             = 31
700:                 .Movable           = .F.
701:                 .Resizable         = .F.
702:                 .ReadOnly          = .T.
703:                 .ControlSource     = "TmpDistrib.cUniPs"
704:                 .Header1.Caption   = "Unid."
705:                 .Header1.Alignment = 2
706:                 .Header1.FontName  = "Tahoma"
707:                 .Header1.FontSize  = 8
708:                 .Text1.BorderStyle = 0
709:                 .Text1.Margin      = 0
710:                 .Text1.ReadOnly    = .T.
711:                 .Text1.ForeColor   = RGB(0,0,0)
712:                 .Text1.BackColor   = RGB(255,255,255)
713:             ENDWITH
714: 
715:             *-- Column6: Qtds2 / Qtde Agregar (ColumnOrder=6, editavel em INSERIR/ALTERAR)
716:             WITH .Column6
717:                 .ColumnOrder       = 6
718:                 .Width             = 80
719:                 .Movable           = .F.
720:                 .Resizable         = .F.
721:                 .ReadOnly          = .F.
722:                 .InputMask         = loc_cMask
723:                 .ControlSource     = "TmpDistrib.Qtds2"
724:                 .Header1.Caption   = "Qtde Agregar"
725:                 .Header1.Alignment = 2
726:                 .Header1.FontName  = "Tahoma"
727:                 .Header1.FontSize  = 8
728:                 .Text1.BorderStyle = 0
729:                 .Text1.Margin      = 0
730:                 .Text1.InputMask   = loc_cMask
731:                 .Text1.ForeColor   = RGB(0,0,0)
732:                 .Text1.BackColor   = RGB(255,255,255)
733:             ENDWITH
734: 
735:             *-- Column7: Nenvs / Envelope (ColumnOrder=1, ReadOnly)
736:             WITH .Column7
737:                 .ColumnOrder       = 1
738:                 .Width             = 80
739:                 .Movable           = .F.
740:                 .Resizable         = .F.
741:                 .ReadOnly          = .T.
742:                 .ControlSource     = "TmpDistrib.Nenvs"
743:                 .Header1.Caption   = "Envelope"
744:                 .Header1.Alignment = 2
745:                 .Header1.FontName  = "Tahoma"
746:                 .Header1.FontSize  = 8
747:                 .Text1.BorderStyle = 0
748:                 .Text1.Margin      = 0
749:                 .Text1.ReadOnly    = .T.
750:                 .Text1.ForeColor   = RGB(0,0,0)
751:                 .Text1.BackColor   = RGB(255,255,255)
752:             ENDWITH
753: 
754:             *-- Column8: CodPds / Produto (ColumnOrder=3, ReadOnly)
755:             WITH .Column8
756:                 .ColumnOrder       = 3
757:                 .Width             = 108
758:                 .Movable           = .F.
759:                 .Resizable         = .F.
760:                 .ReadOnly          = .T.
761:                 .ControlSource     = "TmpDistrib.CodPds"
762:                 .Header1.Caption   = "Produto"
763:                 .Header1.Alignment = 2
764:                 .Header1.FontName  = "Tahoma"
765:                 .Header1.FontSize  = 8
766:                 .Text1.FontSize    = 8
767:                 .Text1.BorderStyle = 0
768:                 .Text1.Margin      = 0
769:                 .Text1.ReadOnly    = .T.
770:                 .Text1.ForeColor   = RGB(0,0,0)
771:                 .Text1.BackColor   = RGB(255,255,255)
772:             ENDWITH
773: 
774:             *-- Column9: CodCors / Cor (ColumnOrder=4, ReadOnly)
775:             WITH .Column9
776:                 .ColumnOrder       = 4
777:                 .Width             = 38
778:                 .Movable           = .F.
779:                 .Resizable         = .F.
780:                 .ReadOnly          = .T.
781:                 .ControlSource     = "TmpDistrib.CodCors"
782:                 .Header1.Caption   = "Cor"
783:                 .Header1.Alignment = 2
784:                 .Header1.FontName  = "Tahoma"
785:                 .Header1.FontSize  = 8
786:                 .Text1.BorderStyle = 0
787:                 .Text1.Margin      = 0
788:                 .Text1.ReadOnly    = .T.
789:                 .Text1.ForeColor   = RGB(0,0,0)
790:                 .Text1.BackColor   = RGB(255,255,255)
791:             ENDWITH
792: 
793:             *-- Column10: CodTams / Tam (ColumnOrder=5, ReadOnly)
794:             WITH .Column10
795:                 .ColumnOrder       = 5
796:                 .Width             = 38
797:                 .Movable           = .F.
798:                 .Resizable         = .F.
799:                 .ReadOnly          = .T.
800:                 .ControlSource     = "TmpDistrib.CodTams"
801:                 .Header1.Caption   = "Tam"
802:                 .Header1.Alignment = 2
803:                 .Header1.FontName  = "Tahoma"
804:                 .Header1.FontSize  = 8
805:                 .Text1.BorderStyle = 0
806:                 .Text1.Margin      = 0
807:                 .Text1.ReadOnly    = .T.
808:                 .Text1.ForeColor   = RGB(0,0,0)
809:                 .Text1.BackColor   = RGB(255,255,255)
810:             ENDWITH
811: 
812:             .Refresh()
813:             .Visible = .T.
814:         ENDWITH
815: 

*-- Linhas 984 a 1002:
984:                INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND ;
985:                !EMPTY(xNensi.CMats)
986:                 IF (LocalUni2.Fators <> 1) OR (LocalUni2.QtEqualPs = "S")
987:                     SELECT TmpDistrib
988:                     REPLACE Pesos2 WITH (TmpDistrib.Pesos * LocalUni2.Fators)
989:                 ENDIF
990:             ENDIF
991:         CATCH TO loc_oErro
992:             MsgErro(loc_oErro.Message, "Erro")
993:         ENDTRY
994:         RETURN loc_lOK
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * GradeCol4WhenHandler - Column4 (Pesos2): editavel se INSERIR/ALTERAR e
999:     *   PesoBals != 1 (entrada manual; balanca fisica nao disponivel neste sistema)
1000:     * Origem: Grade.Column8.Text1.When
1001:     *--------------------------------------------------------------------------
1002:     PROCEDURE GradeCol4WhenHandler()

*-- Linhas 1041 a 1086:
1041:                         loc_lOK = .F.
1042:                     ELSE
1043:                         IF (LocalUni.Fators <> 1) OR (LocalUni.QtEqualPs = "S")
1044:                             SELECT TmpDistrib
1045:                             REPLACE Qtds2 WITH (TmpDistrib.Pesos2 / LocalUni.Fators)
1046:                         ELSE
1047:                             IF USED("LocalUni2") AND !EOF("LocalUni2")
1048:                                 IF LocalUni.cEstos = "3" AND !EMPTY(xNensi.cUniPs) AND ;
1049:                                    ((LocalUni2.Fators <> 1) OR (LocalUni2.QtEqualPs = "S"))
1050:                                     SELECT TmpDistrib
1051:                                     REPLACE Pesos WITH (TmpDistrib.Pesos2 / LocalUni2.Fators)
1052:                                 ENDIF
1053:                             ENDIF
1054:                         ENDIF
1055:                     ENDIF
1056:                 ENDIF
1057:             ENDIF
1058:         CATCH TO loc_oErro
1059:             MsgErro(loc_oErro.Message, "Erro")
1060:         ENDTRY
1061:         RETURN loc_lOK
1062:     ENDPROC
1063: 
1064:     *--------------------------------------------------------------------------
1065:     * GradeCol4LostFocusHandler - Column4 (Pesos2): apos edicao, avanca para
1066:     *   Column6 (Qtds2) da proxima linha via DNARROW
1067:     * Origem: Grade.Column8.Text1.LostFocus
1068:     *--------------------------------------------------------------------------
1069:     PROCEDURE GradeCol4LostFocusHandler()
1070:         IF USED("TmpDistrib")
1071:             SELECT TmpDistrib
1072:             SKIP
1073:             IF !EOF()
1074:                 SKIP -1
1075:                 THIS.grd_4c_Dados.Column6.SetFocus()
1076:                 KEYBOARD '{DNARROW}'
1077:             ELSE
1078:                 SKIP -1
1079:             ENDIF
1080:         ENDIF
1081:     ENDPROC
1082: 
1083:     *--------------------------------------------------------------------------
1084:     * GradeCol6WhenHandler - Column6 (Qtds2): salva valor anterior e consulta
1085:     *   LocalUni para uso no Valid
1086:     * Origem: Grade.Column5.Text1.When

*-- Linhas 1113 a 1131:
1113:                             loc_lOK = .F.
1114:                         ELSE
1115:                             IF (LocalUni.Fators <> 1) OR (LocalUni.QtEqualPs = "S")
1116:                                 SELECT TmpDistrib
1117:                                 REPLACE Pesos2 WITH (TmpDistrib.Qtds2 * LocalUni.Fators)
1118:                             ENDIF
1119:                         ENDIF
1120:                     ENDIF
1121:                 ENDIF
1122:             ENDIF
1123:         CATCH TO loc_oErro
1124:             MsgErro(loc_oErro.Message, "Erro")
1125:         ENDTRY
1126:         RETURN loc_lOK
1127:     ENDPROC
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * Eventos CRUD - Form OPERACIONAL (Rateio de Componentes)
1131:     *

*-- Linhas 1303 a 1321:
1303:         LOCAL loc_oErro
1304:         TRY
1305:             IF VARTYPE(THIS.grd_4c_Dados) = "O" AND USED("TmpDistrib")
1306:                 SELECT TmpDistrib
1307:                 THIS.grd_4c_Dados.Refresh()
1308:                 THIS.this_oBusinessObject.this_nTPeso  = 0
1309:                 THIS.this_oBusinessObject.this_nTQtde  = 0
1310:                 THIS.this_oBusinessObject.this_nTPeso2 = 0
1311:                 SCAN
1312:                     THIS.this_oBusinessObject.this_nTPeso  = ;
1313:                         THIS.this_oBusinessObject.this_nTPeso  + TmpDistrib.Pesos2
1314:                     THIS.this_oBusinessObject.this_nTQtde  = ;
1315:                         THIS.this_oBusinessObject.this_nTQtde  + TmpDistrib.Qtds2
1316:                     THIS.this_oBusinessObject.this_nTPeso2 = ;
1317:                         THIS.this_oBusinessObject.this_nTPeso2 + TmpDistrib.Pesos
1318:                 ENDSCAN
1319:             ENDIF
1320:         CATCH TO loc_oErro
1321:             MsgErro(loc_oErro.Message, "Erro FormParaBO")

*-- Linhas 1351 a 1369:
1351:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND USED("TmpDistrib")
1352:                 THIS.this_oBusinessObject.CalcularDistribuicao()
1353:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
1354:                     SELECT TmpDistrib
1355:                     GO TOP
1356:                     THIS.grd_4c_Dados.Refresh()
1357:                 ENDIF
1358:                 THIS.PreencherContainerMaterial()
1359:             ENDIF
1360:         CATCH TO loc_oErro
1361:             MsgErro(loc_oErro.Message, "Erro BtnBuscar")
1362:         ENDTRY
1363:     ENDPROC
1364: 
1365:     *--------------------------------------------------------------------------
1366:     * BtnEncerrarClick - Encerra o dialogo sem confirmar (alias de Cancelar)
1367:     *--------------------------------------------------------------------------
1368:     PROCEDURE BtnEncerrarClick()
1369:         THIS.BtnCancelarClick()


### BO (C:\4c\projeto\app\classes\SigPdM14BO.prg):
*==============================================================================
* SigPdM14BO.prg - Business Object para Rateio de Componentes (SIGPDM14)
* Herda de BusinessBase
* Form OPERACIONAL modal: opera sobre cursores VFP locais (xNensi, xMFas, TmpDistrib)
*==============================================================================

DEFINE CLASS SigPdM14BO AS BusinessBase

    *-- Identificacao (sem tabela SQL - opera sobre cursores locais)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Dados do item principal (lidos de xNensi pelo form pai)
    this_cMats        = ""    && CMats  - Codigo do material componente
    this_nPesos       = 0     && Pesos  - Peso original da NE
    this_nQtds        = 0     && Qtds   - Quantidade original da NE
    this_cGrus        = ""    && CGrus  - Codigo do grupo do material
    this_cUnis        = ""    && CUnis  - Unidade de medida (qtde)
    this_cDescs       = ""    && CDescs - Descricao do material
    this_cTpOps       = ""    && TpOps  - Tipo de operacao
    this_nLotes       = 0     && nLotes - Numero do lote
    this_nNenvs       = 0     && Nenvs  - Numero do envelope (filtro de fases)
    this_nPeso2s      = 0     && Peso2s - Peso na fase anterior
    this_cCodCors     = ""    && CodCors - Codigo da cor
    this_cCodTams     = ""    && CodTams - Codigo do tamanho
    this_cUniPs       = ""    && cUniPs  - Unidade de medida do peso

    *-- Estado de navegacao/edicao (preservado durante o ciclo do form)
    this_nRecnoAnt    = 0     && Recno original de xNensi para restaurar ao fechar
    this_cOrder       = ""    && Ordem original de xNensi (Order()) para restaurar
    this_nAntValue    = 0     && Valor anterior de Qtds2 (Column5.Text1.When)
    this_nAntValueP   = 0     && Valor anterior de Pesos2 (Column8.Text1.When)
    this_cPcEscolha   = ""    && Modo de operacao do form pai: INSERIR ou ALTERAR
    this_nCas         = 0     && Casas decimais para mascara de quantidade (CasQtds)

    *-- Totais acumulados durante ok.Click (Confirmar)
    this_nTPeso       = 0     && Soma de Pesos2 de todos os itens confirmados
    this_nTQtde       = 0     && Soma de Qtds2 de todos os itens confirmados
    this_nTPeso2      = 0     && Soma de Pesos de todos os itens confirmados
    this_nXAmarra     = 0     && Identificador de amarracao (CtrlAgrega do form pai)

    *--------------------------------------------------------------------------
    * Init - Configura identificacao do BO (sem tabela SQL propria)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (sem tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le dados do cursor xNensi para propriedades do BO
    * Mapeia TODAS as colunas usadas pelo form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cMats    = TratarNulo(CMats,   "C")
                THIS.this_nPesos   = TratarNulo(Pesos,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cGrus    = TratarNulo(CGrus,   "C")
                THIS.this_cUnis    = TratarNulo(CUnis,   "C")
                THIS.this_cDescs   = TratarNulo(CDescs,  "C")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                THIS.this_nLotes   = TratarNulo(nLotes,  "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nPeso2s  = TratarNulo(Peso2s,  "N")
                THIS.this_cCodCors = TratarNulo(CodCors, "C")
                THIS.this_cCodTams = TratarNulo(CodTams, "C")
                THIS.this_cUniPs   = TratarNulo(cUniPs,  "C")
                THIS.this_nRecnoAnt = RECNO()
                THIS.this_cOrder    = ORDER()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria TmpDistrib e preenche com dados de xMFas
    * par_nNenv = filtro de envelope (0 = todos)
    * Requer this_c*/this_n* carregados via CarregarDoCursor antes
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores(par_nNenv)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib (Nops N(10) NULL, Nenvs N(10) NULL, CodPds C(14) NULL, ;
                CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, ;
                Qtds2 N(10,3) NULL, Pesos2 N(10,3) NULL, CDescs C(40) NULL, CGrus C(3) NULL, ;
                TpOps C(15) NULL, nLotes N(10) NULL, Peso2s N(10,3) NULL, cUniPs C(3) NULL, ;
                CodCors C(4) NULL, codTams C(4) NULL)
            SET NULL OFF

            SELECT xMFas
            SCAN
                IF par_nNenv <> 0
                    IF par_nNenv <> xMFas.Nenvs
                        LOOP
                    ENDIF
                ENDIF

                INSERT INTO TmpDistrib ;
                    (Nops, Nenvs, CodPds, Qtds, Pesos, CUnis, CMats, CDescs, ;
                     CGrus, TpOps, nLotes, cUniPs, CodCors, CodTams) ;
                VALUES ;
                    (xMFas.Nops, xMFas.Nenvs, xMFas.CodPds, 0, 0, ;
                     THIS.this_cUnis, THIS.this_cMats, THIS.this_cDescs, ;
                     THIS.this_cGrus, THIS.this_cTpOps, THIS.this_nLotes, ;
                     THIS.this_cUniPs, THIS.this_cCodCors, THIS.this_cCodTams)
            ENDSCAN

            THIS.CalcularDistribuicao()

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularDistribuicao - Distribui Pesos2/Qtds2 proporcionalmente
    * Requer TmpDistrib existente e this_nPesos/this_nQtds/this_nLotes carregados
    *--------------------------------------------------------------------------
    PROCEDURE CalcularDistribuicao()
        LOCAL loc_lSucesso, loc_nQt, loc_nPs, loc_nPes2, loc_nQtd2
        loc_lSucesso = .F.
        TRY
            SELECT TmpDistrib
            GO TOP

            IF (THIS.this_nPesos > 0) AND (THIS.this_nLotes > 0)
                SUM Qtds, Pesos TO loc_nQt, loc_nPs
                GO TOP
                SCAN
                    REPLACE Pesos2 WITH ROUND(Pesos / IIF(loc_nPs = 0, 1, loc_nPs) * THIS.this_nPesos, 2), ;
                            Qtds2  WITH ROUND(Qtds  / IIF(loc_nQt = 0, 1, loc_nQt) * THIS.this_nQtds,  2)
                ENDSCAN

                SUM Pesos2, Qtds2 TO loc_nPes2, loc_nQtd2
                IF (THIS.this_nPesos <> loc_nPes2) OR (THIS.this_nQtds <> loc_nQtd2)
                    GO BOTTOM
                    REPLACE Pesos2 WITH Pesos2 + (THIS.this_nPesos - loc_nPes2), ;
                            Qtds2  WITH Qtds2  + (THIS.this_nQtds  - loc_nQtd2)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarUnidadeSQL - Consulta SigCdUni via SQL Server
    * par_cCUnis   = codigo da unidade a buscar
    * par_cAlias   = nome do cursor destino (ex: "LocalUni", "LocalUni2")
    * par_cCampos  = campos a retornar (ex: "Fators,QtEqualPs,cestos")
    *--------------------------------------------------------------------------
    PROCEDURE BuscarUnidadeSQL(par_cCUnis, par_cAlias, par_cCampos)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSelect
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAlias)
                loc_lSucesso = .F.
            ENDIF

            IF USED(par_cAlias)
                TABLEREVERT(.T., par_cAlias)
                USE IN (par_cAlias)
            ENDIF

            loc_cSelect = IIF(EMPTY(par_cCampos), "CUnis, Fators, QtEqualPs, cEstos", par_cCampos)
            loc_cSQL = "SELECT " + loc_cSelect + ;
                       " FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCUnis))

            SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

            IF USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
                SELECT (par_cAlias)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarEstoquePeso - Verifica se estoque suporta quantidade adicional
    * Equivalente ao fVerEstP do framework legado
    * par_nQuant = TmpDistrib.Qtds2 - xNensi.Qtds (diferenca a verificar)
    * Retorna .T. se pode prosseguir
    *--------------------------------------------------------------------------
    PROCEDURE VerificarEstoquePeso(par_nQuant)
        LOCAL loc_lOK, loc_cSQL, loc_nSaldo
        loc_lOK = .T.
        TRY
            IF par_nQuant > 0 AND !EMPTY(THIS.this_cMats)
                IF USED("TmpDistrib") AND !EOF("TmpDistrib")
                    *-- Verifica saldo em processo: compara quantidade a adicionar com
                    *-- disponivel no lote (Pesos do item de NE como referencia de saldo)
                    IF THIS.this_nPesos > 0
                        loc_nSaldo = THIS.this_nPesos
                        IF par_nQuant > loc_nSaldo
                            loc_lOK = .F.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lOK
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterCasasDecimais - Retorna casas decimais da operacao para mascara
    * Lido de CrSigCdOpd.CasQtds
    *--------------------------------------------------------------------------
    PROCEDURE ObterCasasDecimais()
        LOCAL loc_nCas
        loc_nCas = 3
        TRY
            IF USED("CrSigCdOpd") AND !EOF("CrSigCdOpd")
                loc_nCas = IIF(CrSigCdOpd.CasQtds = 0, 3, CrSigCdOpd.CasQtds)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCas
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarRateio - Itera TmpDistrib e insere/atualiza xNensi
    * Logica do ok.Click do form legado
    * par_nCtrlAgrega = identificador de amarracao fornecido pelo form pai
    * Zera e recalcula this_nTPeso, this_nTQtde, this_nTPeso2
    * Retorna .T. se confirmado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarRateio(par_nCtrlAgrega)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_nTPeso   = 0
            THIS.this_nTQtde   = 0
            THIS.this_nTPeso2  = 0
            THIS.this_nXAmarra = par_nCtrlAgrega

            SELECT xNensi
            GO (THIS.this_nRecnoAnt)

            SELECT TmpDistrib
            SCAN
                SELECT xNensi
                SET ORDER TO NopCMatnV
                IF !SEEK(STR(TmpDistrib.Nops, 10) + TmpDistrib.CMats)
                    INSERT INTO xNensi ;
                        (CMats, CUnis, CDescs, CGrus, Nops, Rateio, FlagIncs, Nenvs, ;
                         Qtds, Pesos, TpOps, nLotes, Peso2s, CodCors, CodTams, cUniPs) ;
                    VALUES ;
                        (TmpDistrib.CMats, TmpDistrib.CUnis, TmpDistrib.CDescs, ;
                         TmpDistrib.CGrus, TmpDistrib.Nops, 3, .T., TmpDistrib.Nenvs, ;
                         TmpDistrib.Qtds2, TmpDistrib.Pesos2, TmpDistrib.TpOps, ;
                         TmpDistrib.nLotes, TmpDistrib.Pesos, ;
                         TmpDistrib.CodCors, TmpDistrib.CodTams, TmpDistrib.cUniPs)
                ENDIF

                REPLACE Qtds   WITH TmpDistrib.Qtds2, ;
                        Peso2s WITH TmpDistrib.Pesos, ;
                        Pesos  WITH TmpDistrib.Pesos2

                REPLACE QtFaseAnt  WITH TmpDistrib.Qtds2, ;
                        Amarracao  WITH THIS.this_nXAmarra IN xNensi

                IF TmpDistrib.Pesos2 <> 0
                    REPLACE PsFaseAnt WITH TmpDistrib.Pesos2
                ENDIF
                IF TmpDistrib.Pesos <> 0
                    REPLACE Ps2FaseAnt WITH TmpDistrib.Pesos
                ENDIF

                THIS.this_nTPeso  = THIS.this_nTPeso  + TmpDistrib.Pesos2
                THIS.this_nTQtde  = THIS.this_nTQtde  + TmpDistrib.Qtds2
                THIS.this_nTPeso2 = THIS.this_nTPeso2 + TmpDistrib.Pesos
            ENDSCAN

            SELECT xNensi
            SET ORDER TO Editar
            GO (THIS.this_nRecnoAnt)
            REPLACE Qtds      WITH THIS.this_nTQtde, ;
                    Pesos     WITH THIS.this_nTPeso, ;
                    Peso2s    WITH THIS.this_nTPeso2, ;
                    Rateio    WITH 1, ;
                    Amarracao WITH THIS.this_nXAmarra IN xNensi

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CancelarRateio - Restaura estado do cursor xNensi ao cancelar
    * Equivalente ao Cancelar.Click do form legado
    *--------------------------------------------------------------------------
    PROCEDURE CancelarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xNensi
            SET ORDER TO Editar
            IF THIS.this_nRecnoAnt > 0
                GO (THIS.this_nRecnoAnt)
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Persiste novo rateio em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: nao ha tabela SQL propria; opera sobre cursor xNensi.
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para insercao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza rateio existente em xNensi (delega para ConfirmarRateio)
    * Form OPERACIONAL: ConfirmarRateio decide INSERT vs UPDATE conforme SEEK
    * par_nCtrlAgrega = CtrlAgrega do form pai (controle de amarracao)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_nCtrlAgrega)
        LOCAL loc_lSucesso, loc_nCtrl
        loc_lSucesso = .F.
        TRY
            loc_nCtrl = IIF(VARTYPE(par_nCtrlAgrega) = "N", par_nCtrlAgrega, THIS.this_nXAmarra)

            IF !USED("TmpDistrib")
                MsgErro("Cursor TmpDistrib nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("xNensi")
                MsgErro("Cursor xNensi nao disponivel para atualizacao.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.ConfirmarRateio(loc_nCtrl)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sem auditoria em form OPERACIONAL (sem tabela SQL)
    * par_cOperacao = "INSERIR" ou "ATUALIZAR" (recebido de Inserir/Atualizar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

