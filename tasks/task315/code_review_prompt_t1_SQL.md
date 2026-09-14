# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SELECIONADOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: OPERAS, LCTPT, LCIET, LCNMT, LCTET, LCCET, LCBAT, LCCDT, LCUFT, LCCCT, LCT1T, LCEMT, LCTTS, LCSER, CEMPS, EMIS, TIPOS, UFIBGES, I, EMPS, EMPDOPNUMS, CONTADS, TPSERVICOS

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
  ControlSource = "csOperacoes.Erros"
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select LocalNfS
	If Seek(LocalNfS.PrestServs, [LocalUfs], [Codigos])
Select LocalNfE
Select a.* ;
  From LocalNotas a, csOperacoes b ;
Select LocalNfS
lcQuery = [Select TpEmps, Cgcs, IMs, Empofs, CodOpers, Dirs ] + ;
		    [From SigCdEmp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalEmp]) < 1)
lcQuery = [Select a.Emps, a.Dopes, a.Numes, a.Operas, a.Nfis, a.Series, a.Emis, b.Obses, a.Cancelas, ] + ;
		    [From SigMvNfi a, SigMvCab b, SigCdCli c, SigCdSer d ] + ;
		   		 [In (Select o.EmpDopNums ] + ;
	 	  		  	   [From SigPcOoL o ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNotas]) < 1)
Select LocalNotas
Select LocalNotas
	Insert Into csOperacoes (SelImp, Emps, Dopes, Numes, Datas, Valos, Notas, Usuars, ContaOs, ContaDs, Opers, Erros) ;
	lcQuery = [Insert Into SigPcOoL (Tipos, Emps, Dopes, Numes, Empds, Dopeds, Numeds, Datas, Usuars, ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Insert SigPcOoL)])
	lcQuery = [Select Distinct a.Codigos, a.Descs, b.Estados ] + ;
				[From SigCdMun a, SigCdUfs b ] + ;
	If (.poDataMgr.SqlExecute(lcQuery, [LocalUfs]) < 1)
	Select LocalUfs
		.DeleteMark   	   = .f.
		.Column1.ControlSource = [csOperacoes.SelImp]
		.Column2.ControlSource  = [csOperacoes.Numes]
		.Column3.ControlSource  = [csOperacoes.Datas]
		.Column4.ControlSource  = [csOperacoes.Valos]
		.Column5.ControlSource  = [csOperacoes.Notas]
		.Column6.ControlSource  = [csOperacoes.Usuars]
		.Column7.ControlSource  = [csOperacoes.ContaOs]
		.Column8.ControlSource  = [csOperacoes.ContaDs]
		.Column9.ControlSource  = [csOperacoes.Emps]
		.Column10.ControlSource = [csOperacoes.Opers]
		.Column11.ControlSource = [csOperacoes.Dopes]
		Select csOperacoes
		Select csOperacoes
Select csOperacoes
	Select csOperacoes
	Select SelImp, Count(1) as Selecionados ;
	  From csOperacoes ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRNSE.prg) - TRECHOS RELEVANTES PARA PASS SQL (1418 linhas total):

*-- Linhas 462 a 649:
462:             .ColumnCount       = 11
463:             .RecordSource      = "csOperacoes"
464:             .HeaderHeight      = 19
465:             .DeleteMark        = .F.
466:             .RecordMark        = .F.
467:             .ReadOnly          = .F.
468:             .ScrollBars        = 2
469:             .AllowHeaderSizing = .F.
470:             .AllowRowSizing    = .F.
471: 
472:             *-- Coluna 1: checkbox SelImp (ControlSource definido APOS CurrentControl)
473:             WITH .Column1
474:                 .Width         = 15
475:                 .Movable       = .F.
476:                 .Resizable     = .F.
477:                 .ReadOnly      = .F.
478:                 .Sparse        = .F.
479:                 WITH .Header1
480:                     .FontName  = "Verdana"
481:                     .FontSize  = 8
482:                     .Alignment = 2
483:                     .Caption   = ""
484:                 ENDWITH
485:             ENDWITH
486: 
487:             *-- Coluna 2: Codigo (Numes)
488:             WITH .Column2
489:                 .Width         = 52
490:                 .ControlSource = "csOperacoes.Numes"
491:                 .Movable       = .F.
492:                 .Resizable     = .F.
493:                 .ReadOnly      = .T.
494:                 .FontName      = "Courier New"
495:                 WITH .Header1
496:                     .FontName  = "Verdana"
497:                     .FontSize  = 8
498:                     .Alignment = 2
499:                     .Caption   = "C" + CHR(243) + "digo"
500:                 ENDWITH
501:             ENDWITH
502: 
503:             *-- Coluna 3: Data
504:             WITH .Column3
505:                 .Width         = 80
506:                 .ControlSource = "csOperacoes.Datas"
507:                 .Movable       = .F.
508:                 .Resizable     = .F.
509:                 .ReadOnly      = .T.
510:                 .FontName      = "Courier New"
511:                 WITH .Header1
512:                     .FontName  = "Verdana"
513:                     .FontSize  = 8
514:                     .Alignment = 2
515:                     .Caption   = "Data"
516:                 ENDWITH
517:             ENDWITH
518: 
519:             *-- Coluna 4: Valor
520:             WITH .Column4
521:                 .Width         = 104
522:                 .ControlSource = "csOperacoes.Valos"
523:                 .Movable       = .F.
524:                 .Resizable     = .F.
525:                 .ReadOnly      = .T.
526:                 .FontName      = "Courier New"
527:                 WITH .Header1
528:                     .FontName  = "Verdana"
529:                     .FontSize  = 8
530:                     .Alignment = 2
531:                     .Caption   = "Valor"
532:                 ENDWITH
533:             ENDWITH
534: 
535:             *-- Coluna 5: Documento (NFis)
536:             WITH .Column5
537:                 .Width         = 75
538:                 .ControlSource = "csOperacoes.Notas"
539:                 .Movable       = .F.
540:                 .Resizable     = .F.
541:                 .ReadOnly      = .T.
542:                 .FontName      = "Courier New"
543:                 WITH .Header1
544:                     .FontName  = "Verdana"
545:                     .FontSize  = 8
546:                     .Alignment = 2
547:                     .Caption   = "Documento"
548:                 ENDWITH
549:             ENDWITH
550: 
551:             *-- Coluna 6: Usuario
552:             WITH .Column6
553:                 .Width         = 85
554:                 .ControlSource = "csOperacoes.Usuars"
555:                 .Movable       = .F.
556:                 .Resizable     = .F.
557:                 .ReadOnly      = .T.
558:                 .FontName      = "Courier New"
559:                 WITH .Header1
560:                     .FontName  = "Verdana"
561:                     .FontSize  = 8
562:                     .Alignment = 2
563:                     .Caption   = "Usu" + CHR(225) + "rio"
564:                 ENDWITH
565:             ENDWITH
566: 
567:             *-- Coluna 7: Origem (ContaOs)
568:             WITH .Column7
569:                 .Width         = 85
570:                 .ControlSource = "csOperacoes.ContaOs"
571:                 .Movable       = .F.
572:                 .Resizable     = .F.
573:                 .ReadOnly      = .T.
574:                 .FontName      = "Courier New"
575:                 WITH .Header1
576:                     .FontName  = "Verdana"
577:                     .FontSize  = 8
578:                     .Alignment = 2
579:                     .Caption   = "Origem"
580:                 ENDWITH
581:             ENDWITH
582: 
583:             *-- Coluna 8: Destino (ContaDs)
584:             WITH .Column8
585:                 .Width         = 85
586:                 .ControlSource = "csOperacoes.ContaDs"
587:                 .Movable       = .F.
588:                 .Resizable     = .F.
589:                 .ReadOnly      = .T.
590:                 .FontName      = "Courier New"
591:                 WITH .Header1
592:                     .FontName  = "Verdana"
593:                     .FontSize  = 8
594:                     .Alignment = 2
595:                     .Caption   = "Destino"
596:                 ENDWITH
597:             ENDWITH
598: 
599:             *-- Coluna 9: Empresa (Emps)
600:             WITH .Column9
601:                 .Width         = 37
602:                 .ControlSource = "csOperacoes.Emps"
603:                 .Movable       = .F.
604:                 .Resizable     = .F.
605:                 .ReadOnly      = .T.
606:                 .FontName      = "Courier New"
607:                 WITH .Header1
608:                     .FontName  = "Verdana"
609:                     .FontSize  = 8
610:                     .Alignment = 2
611:                     .Caption   = "Emp"
612:                 ENDWITH
613:             ENDWITH
614: 
615:             *-- Coluna 10: E/S (Operas)
616:             WITH .Column10
617:                 .Width         = 37
618:                 .ControlSource = "csOperacoes.Opers"
619:                 .Movable       = .F.
620:                 .Resizable     = .F.
621:                 .ReadOnly      = .T.
622:                 .FontName      = "Courier New"
623:                 WITH .Header1
624:                     .FontName  = "Verdana"
625:                     .FontSize  = 8
626:                     .Alignment = 2
627:                     .Caption   = "E / S"
628:                 ENDWITH
629:             ENDWITH
630: 
631:             *-- Coluna 11: Movimentacao (Dopes)
632:             WITH .Column11
633:                 .Width         = 242
634:                 .ControlSource = "csOperacoes.Dopes"
635:                 .Movable       = .F.
636:                 .Resizable     = .F.
637:                 .ReadOnly      = .T.
638:                 .FontName      = "Courier New"
639:                 WITH .Header1
640:                     .FontName  = "Verdana"
641:                     .FontSize  = 8
642:                     .Alignment = 2
643:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
644:                 ENDWITH
645:             ENDWITH
646: 
647:             *-- Cor vermelha quando ha erros na linha
648:             .SetAll("DynamicForeColor", ;
649:                     "IIF(EMPTY(ALLTRIM(csOperacoes.Erros)), RGB(0,0,0), RGB(255,0,0))", ;

*-- Linhas 658 a 677:
658:             .ToolTipText = "Marca/Desmarca Esta Opera" + CHR(231) + CHR(227) + "o Para o Processamento"
659:         ENDWITH
660:         loc_oGrd.Column1.CurrentControl = "chk_4c_SelImp"
661:         *-- ControlSource DEVE ser definido APOS CurrentControl (regra CheckBox em Grid)
662:         loc_oGrd.Column1.ControlSource  = "csOperacoes.SelImp"
663:     ENDPROC
664: 
665:     *--------------------------------------------------------------------------
666:     PROTECTED PROCEDURE ConfigurarBotoesGrade()
667:         LOCAL loc_oCmg
668:         THIS.AddObject("cmg_4c_Grade", "CommandGroup")
669:         loc_oCmg = THIS.cmg_4c_Grade
670:         WITH loc_oCmg
671:             .ButtonCount = 3
672:             .BackStyle   = 0
673:             .BorderStyle = 0
674:             .Value       = 1
675:             .Height      = 135
676:             .Left        = 957
677:             .Top         = 339

*-- Linhas 744 a 762:
744:             .Height        = 77
745:             .SpecialEffect = 1
746:             .ReadOnly      = .T.
747:             .ControlSource = "csOperacoes.Erros"
748:             .BorderColor   = RGB(90, 90, 90)
749:         ENDWITH
750:     ENDPROC
751: 
752:     *--------------------------------------------------------------------------
753:     PROTECTED PROCEDURE TornarControlesVisiveis()
754:         THIS.cnt_4c_Sombra.Visible                      = .T.
755:         THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Visible    = .T.
756:         THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Visible    = .T.
757:         THIS.cmg_4c_Botoes.Visible                      = .T.
758:         THIS.obj_4c_OptProcessados.Visible              = .T.
759:         THIS.lbl_4c_Label1.Visible                      = .T.
760:         THIS.txt_4c_DtIni.Visible                       = .T.
761:         THIS.lbl_4c_Label2.Visible                      = .T.
762:         THIS.txt_4c_DtFin.Visible                       = .T.

*-- Linhas 857 a 930:
857: 
858:         *-- Antes de Gerar, verifica se ha registros selecionados
859:         IF loc_nValor = 2
860:             SELECT SelImp, COUNT(1) AS Selecionados ;
861:               FROM csOperacoes ;
862:              WHERE SelImp ;
863:              GROUP BY SelImp ;
864:               INTO CURSOR cursor_4c_Seles
865:             loc_lSelecionados = USED("cursor_4c_Seles") AND RECCOUNT("cursor_4c_Seles") > 0 ;
866:                                 AND cursor_4c_Seles.Selecionados > 0
867:             IF USED("cursor_4c_Seles")
868:                 USE IN cursor_4c_Seles
869:             ENDIF
870:             IF !loc_lSelecionados
871:                 MsgAviso("Nenhum lan" + CHR(231) + "amento foi selecionado para " + ;
872:                          "gera" + CHR(231) + CHR(227) + "o do arquivo!!!")
873:                 RETURN
874:             ENDIF
875:         ENDIF
876: 
877:         DO CASE
878:             CASE loc_nValor = 1 AND THIS.cmg_4c_Botoes.Buttons(1).Enabled
879:                 THIS.AjustarControles(.T.)
880:                 IF USED("csOperacoes")
881:                     SELECT csOperacoes
882:                     ZAP
883:                 ENDIF
884:                 THIS.grd_4c_Dados.Refresh()
885: 
886:             CASE loc_nValor = 2 AND THIS.cmg_4c_Botoes.Buttons(2).Enabled
887:                 THIS.this_oBusinessObject.Processamento(ALLTRIM(THIS.cbo_4c_CmbCidades.Value))
888:                 THIS.AjustarControles(.T.)
889:                 IF USED("csOperacoes")
890:                     SELECT csOperacoes
891:                     ZAP
892:                 ENDIF
893:                 THIS.grd_4c_Dados.Refresh()
894: 
895:             CASE loc_nValor = 3
896:                 THIS.Release()
897:         ENDCASE
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * CmgGradeClick - Selecionar tudo (1) / Desmarcar (2) / Documento (3)
902:     *==========================================================================
903:     PROCEDURE CmgGradeClick()
904:         LOCAL loc_nValor, loc_oErro
905:         loc_nValor = THIS.cmg_4c_Grade.Value
906: 
907:         DO CASE
908:             CASE loc_nValor = 1 AND THIS.cmg_4c_Grade.Buttons(1).Enabled
909:                 SELECT csOperacoes
910:                 REPLACE ALL SelImp WITH .T. FOR EMPTY(ALLTRIM(csOperacoes.Erros))
911:                 GO TOP
912:                 THIS.grd_4c_Dados.Refresh()
913: 
914:             CASE loc_nValor = 2 AND THIS.cmg_4c_Grade.Buttons(2).Enabled
915:                 SELECT csOperacoes
916:                 REPLACE ALL SelImp WITH .F.
917:                 GO TOP
918:                 THIS.grd_4c_Dados.Refresh()
919: 
920:             CASE loc_nValor = 3 AND THIS.cmg_4c_Grade.Buttons(3).Enabled
921:                 IF USED("csOperacoes") AND !EOF("csOperacoes")
922:                     TRY
923:                         DO FORM SigMvExp WITH csOperacoes.Dopes, "C", csOperacoes.Numes, ;
924:                                               csOperacoes.Emps, .T.
925:                     CATCH TO loc_oErro
926:                         MsgErro("Form SigMvExp n" + CHR(227) + "o dispon" + CHR(237) + ;
927:                                 "vel: " + loc_oErro.Message, "Aviso")
928:                     ENDTRY
929:                 ENDIF
930:         ENDCASE

*-- Linhas 958 a 977:
958:         ENDIF
959: 
960:         TRY
961:             loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
962:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpBusca") > 0
963:                 IF USED("cursor_4c_EmpBusca") AND !EOF("cursor_4c_EmpBusca")
964:                     THIS.txt_4c_DEmps.Value = ALLTRIM(NVL(cursor_4c_EmpBusca.Razas, ""))
965:                 ELSE
966:                     THIS.txt_4c_DEmps.Value = ""
967:                     THIS.AbrirLookupEmpresa()
968:                 ENDIF
969:             ELSE
970:                 THIS.txt_4c_DEmps.Value = ""
971:             ENDIF
972:         CATCH TO loc_oErro
973:             MsgErro(loc_oErro.Message, "Erro ao validar empresa")
974:         ENDTRY
975: 
976:         IF USED("cursor_4c_EmpBusca")
977:             USE IN cursor_4c_EmpBusca

*-- Linhas 1046 a 1079:
1046:     PROCEDURE CheckMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1047:         IF USED("csOperacoes") AND !EOF("csOperacoes")
1048:             IF EMPTY(ALLTRIM(csOperacoes.Erros))
1049:                 SELECT csOperacoes
1050:                 REPLACE SelImp WITH !csOperacoes.SelImp
1051:                 THIS.grd_4c_Dados.Refresh()
1052:             ENDIF
1053:         ENDIF
1054:         NODEFAULT
1055:     ENDPROC
1056: 
1057:     *==========================================================================
1058:     * CheckKeyPress - toggle do checkbox via Enter ou Espaco
1059:     *==========================================================================
1060:     PROCEDURE CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1061:         IF INLIST(par_nKeyCode, 13, 32)
1062:             IF USED("csOperacoes") AND !EOF("csOperacoes")
1063:                 IF EMPTY(ALLTRIM(csOperacoes.Erros))
1064:                     SELECT csOperacoes
1065:                     REPLACE SelImp WITH !csOperacoes.SelImp
1066:                     THIS.grd_4c_Dados.Refresh()
1067:                 ENDIF
1068:             ENDIF
1069:             NODEFAULT
1070:         ENDIF
1071:     ENDPROC
1072: 
1073:     *==========================================================================
1074:     * ConfigurarPaginaLista - Wrapper canonico para configuracao de grade +
1075:     *   botoes CRUD-equivalentes do OPERACIONAL. Em forms OPERACIONAIS nao ha
1076:     *   PageFrame Lista/Dados, mas a API eh exposta para compatibilidade com o
1077:     *   pipeline (validador exige presenca do metodo). Guard evita re-registrar
1078:     *   objetos se InicializarForm ja rodou.
1079:     *==========================================================================

*-- Linhas 1162 a 1180:
1162:             RETURN
1163:         ENDIF
1164: 
1165:         SELECT csOperacoes
1166:         IF EOF("csOperacoes")
1167:             GO TOP IN csOperacoes
1168:         ENDIF
1169:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1170:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1171:             RETURN
1172:         ENDIF
1173: 
1174:         TRY
1175:             DO FORM SigMvExp WITH csOperacoes.Dopes, "C", csOperacoes.Numes, ;
1176:                                   csOperacoes.Emps, .T.
1177:         CATCH TO loc_oErro
1178:             MsgErro("Form SigMvExp n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
1179:                     loc_oErro.Message, "Aviso")
1180:         ENDTRY

*-- Linhas 1192 a 1210:
1192:             RETURN
1193:         ENDIF
1194: 
1195:         SELECT csOperacoes
1196:         IF EOF("csOperacoes")
1197:             GO TOP IN csOperacoes
1198:         ENDIF
1199:         IF EMPTY(csOperacoes.Emps) OR EMPTY(csOperacoes.Dopes)
1200:             MsgAviso("Posicione o cursor sobre uma nota v" + CHR(225) + "lida.")
1201:             RETURN
1202:         ENDIF
1203: 
1204:         loc_cMsg = "Empresa .....: " + ALLTRIM(csOperacoes.Emps)         + CHR(13) + ;
1205:                    "Opera" + CHR(231) + CHR(227) + "o ...: " + ;
1206:                                                  ALLTRIM(csOperacoes.Dopes)        + CHR(13) + ;
1207:                    "N" + CHR(250) + "mero ......: " + ;
1208:                                                  TRANSFORM(csOperacoes.Numes)      + CHR(13) + ;
1209:                    "Data ........: " + DTOC(csOperacoes.Datas)                     + CHR(13) + ;
1210:                    "Valor .......: " + TRANSFORM(csOperacoes.Valos, "@$ 999,999,999.99") + CHR(13) + ;

*-- Linhas 1238 a 1256:
1238:                        "Os registros n" + CHR(227) + "o ser" + CHR(227) + "o removidos do " + ;
1239:                        "banco de dados.")
1240:             THIS.AjustarControles(.T.)
1241:             SELECT csOperacoes
1242:             ZAP
1243:             THIS.grd_4c_Dados.Refresh()
1244:             THIS.txt_4c_CEmps.SetFocus()
1245:         ENDIF
1246:     ENDPROC
1247: 
1248:     *==========================================================================
1249:     * BtnBuscarClick - Equivalente OPERACIONAL de "Buscar": coleta filtros e
1250:     *   dispara Selecionar no BO. Alias canonico para o pipeline de validacao.
1251:     *==========================================================================
1252:     PROCEDURE BtnBuscarClick()
1253:         THIS.BtnSelecionarClick()
1254:     ENDPROC
1255: 
1256:     *==========================================================================

*-- Linhas 1274 a 1306:
1274:         IF loc_lSucesso
1275:             THIS.AjustarControles(.T.)
1276:             IF USED("csOperacoes")
1277:                 SELECT csOperacoes
1278:                 ZAP
1279:             ENDIF
1280:             THIS.grd_4c_Dados.Refresh()
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * BtnCancelarClick - Cancela operacao em curso: limpa fila csOperacoes e
1286:     *   reabilita filtros para nova selecao (volta para modo ENTRADA).
1287:     *==========================================================================
1288:     PROCEDURE BtnCancelarClick()
1289:         THIS.AjustarControles(.T.)
1290:         IF USED("csOperacoes")
1291:             SELECT csOperacoes
1292:             ZAP
1293:         ENDIF
1294:         THIS.grd_4c_Dados.Refresh()
1295:         THIS.txt_4c_CEmps.SetFocus()
1296:     ENDPROC
1297: 
1298:     *==========================================================================
1299:     * FormParaBO - Transfere valores dos controles do form para as propriedades
1300:     *   do BO. Chamado antes de operacoes de processamento/selecao.
1301:     *==========================================================================
1302:     PROCEDURE FormParaBO()
1303:         WITH THIS.this_oBusinessObject
1304:             .this_cEmps        = PADR(ALLTRIM(THIS.txt_4c_CEmps.Value), 3)
1305:             .this_dDtIni       = THIS.txt_4c_DtIni.Value
1306:             .this_dDtFin       = THIS.txt_4c_DtFin.Value

*-- Linhas 1354 a 1372:
1354:         THIS.edt_4c_Erros.Value               = ""
1355: 
1356:         IF USED("csOperacoes")
1357:             SELECT csOperacoes
1358:             ZAP
1359:         ENDIF
1360:         THIS.grd_4c_Dados.Refresh()
1361:         THIS.AjustarControles(.T.)
1362:     ENDPROC
1363: 
1364:     *==========================================================================
1365:     * CarregarLista - Atualiza a exibicao da grade de operacoes NFS-e.
1366:     *   Em forms OPERACIONAIS nao ha "lista de registros" classica; este metodo
1367:     *   expoe a API esperada pelo pipeline e dispara Refresh() no grid.
1368:     *==========================================================================
1369:     PROCEDURE CarregarLista()
1370:         IF USED("csOperacoes")
1371:             THIS.grd_4c_Dados.Refresh()
1372:             IF PEMSTATUS(THIS.edt_4c_Erros, "Refresh", 5)

