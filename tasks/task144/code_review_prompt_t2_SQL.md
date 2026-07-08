# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRA, DOPES, PESOS, EMPDNPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRA, DOPES, PESOS, EMPDNPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRA, DOPES, PESOS, EMPDNPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: AMARRA, DOPES, PESOS, EMPDNPS

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
  ControlSource = "tmpnens.grupoos"
  ControlSource = "tmpnens.contaos"
  ControlSource = "tmpnens.grupods"
  ControlSource = "tmpnens.contads"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  ControlSource = "xmfas.obss"
  ControlSource = "tmpnens.numps"
  ControlSource = "tmpnens.emps"
  ControlSource = "tmpnens.dopps"
Select xOpi
=Seek(ThisForm._Dopp, 'crSigCdOpd', 'Dopps')
	.Column1.ControlSource = 'xopi.nops'
	.Column2.ControlSource = 'xopi.oper'
	.Column6.ControlSource = 'xopi.conta'
	.Column3.ControlSource = 'xopi.qtds'
	.Column4.ControlSource = 'xopi.cpros'
	.Column5.ControlSource = 'xopi.indiv'
	.Column7.ControlSource = 'xopi.Divs'
	Select TmpNens
Select xOpi
Select xPesa
Delete All For Amarra = xOpi.Amarra
Select xOpi
lcsql = [Select CadProds, Pesos From SigCdOpe Where dopes = ']+xOpi.Dopes+[']
Thisform.podatamgr.sqlexecute(lcsql,'LocalOpe')
		Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
		Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
	Insert Into xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens ) ;
Select xOpi
Select xOpi
	Select xPesa
	Delete All For Amarra = xOpi.Amarra
	Select xOpi
			Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs,Pesoms, Divs, citens) ;
			Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
		Insert Into xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens ) ;
Select xPesa
Delete All For Amarra = xOpi.Amarra
Select xOpi
		Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs,Pesoms, Divs, citens) ;
		Insert Into xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
	Insert Into xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens ) ;
Select xOpi
Select xOpi
	Select xPesa
	Update xPesa Set Divs = (xOpi.Divs) Where Amarra = xOpi.Amarra
Select xPesa
Update xPesa Set Divs = (This.Value) Where Amarra = xOpi.Amarra
	Select TmpNens
	=Seek(TmpNens.Dopps, 'crSigCdOpd', 'Dopps')
	Select crSigCdNec
Select xPesa

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp3.prg) - TRECHOS RELEVANTES PARA PASS SQL (2254 linhas total):

*-- Linhas 275 a 337:
275:                 .Visible           = .T.
276:             ENDWITH
277:             IF USED("tmpnens")
278:                 THIS.cnt_4c_Operacao.txt_4c_Empresa.ControlSource = "tmpnens.emps"
279:             ENDIF
280: 
281:             .AddObject("txt_4c_Operacao", "TextBox")
282:             WITH .txt_4c_Operacao
283:                 .Left              = 41
284:                 .Top               = 2
285:                 .Width             = 156
286:                 .Height            = 23
287:                 .ReadOnly          = .T.
288:                 .FontName          = "Tahoma"
289:                 .FontSize          = 8
290:                 .ForeColor         = RGB(0, 0, 0)
291:                 .BackColor         = RGB(255, 255, 255)
292:                 .BorderStyle       = 1
293:                 .SpecialEffect     = 1
294:                 .DisabledBackColor = RGB(255, 255, 255)
295:                 .Themes            = .F.
296:                 .Visible           = .T.
297:             ENDWITH
298:             IF USED("tmpnens")
299:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.ControlSource = "tmpnens.dopps"
300:             ENDIF
301: 
302:             .AddObject("txt_4c_Codigo", "TextBox")
303:             WITH .txt_4c_Codigo
304:                 .Left              = 199
305:                 .Top               = 2
306:                 .Width             = 81
307:                 .Height            = 23
308:                 .ReadOnly          = .T.
309:                 .Format            = "L"
310:                 .InputMask         = "9999999999"
311:                 .FontName          = "Tahoma"
312:                 .FontSize          = 8
313:                 .ForeColor         = RGB(0, 0, 0)
314:                 .BackColor         = RGB(255, 255, 255)
315:                 .BorderStyle       = 1
316:                 .SpecialEffect     = 1
317:                 .DisabledBackColor = RGB(255, 255, 255)
318:                 .Themes            = .F.
319:                 .Visible           = .T.
320:             ENDWITH
321:             IF USED("tmpnens")
322:                 THIS.cnt_4c_Operacao.txt_4c_Codigo.ControlSource = "tmpnens.numps"
323:             ENDIF
324:         ENDWITH
325:     ENDPROC
326: 
327:     *==========================================================================
328:     * ConfigurarContainerOrigem - Configura cnt_4c_Origem
329:     * Labels "Origem"/"Grupo"/"Conta"/"Nome" + TextBoxes ReadOnly de tmpnens
330:     * Replica Origem.Say1-4, Origem.Get_grupo, Get_conta, Get_dconta do legado
331:     *==========================================================================
332:     PROTECTED PROCEDURE ConfigurarContainerOrigem()
333:         WITH THIS.cnt_4c_Origem
334:             .AddObject("lbl_4c_LblOrigem", "Label")
335:             WITH .lbl_4c_LblOrigem
336:                 .FontBold  = .T.
337:                 .FontSize  = 8

*-- Linhas 402 a 438:
402:                 .Visible       = .T.
403:             ENDWITH
404:             IF USED("tmpnens")
405:                 THIS.cnt_4c_Origem.txt_4c_Grupo.ControlSource = "tmpnens.grupoos"
406:             ENDIF
407: 
408:             .AddObject("txt_4c_Conta", "TextBox")
409:             WITH .txt_4c_Conta
410:                 .Left          = 93
411:                 .Top           = 33
412:                 .Width         = 80
413:                 .ReadOnly      = .T.
414:                 .SpecialEffect = 1
415:                 .FontName      = "Tahoma"
416:                 .FontSize      = 8
417:                 .ForeColor     = RGB(0, 0, 0)
418:                 .BorderColor   = RGB(100, 100, 100)
419:                 .Themes        = .F.
420:                 .Visible       = .T.
421:             ENDWITH
422:             IF USED("tmpnens")
423:                 THIS.cnt_4c_Origem.txt_4c_Conta.ControlSource = "tmpnens.contaos"
424:             ENDIF
425: 
426:             .AddObject("txt_4c_Dconta", "TextBox")
427:             WITH .txt_4c_Dconta
428:                 .Left          = 176
429:                 .Top           = 32
430:                 .Width         = 302
431:                 .Height        = 23
432:                 .ReadOnly      = .T.
433:                 .SpecialEffect = 1
434:                 .FontName      = "Tahoma"
435:                 .FontSize      = 8
436:                 .ForeColor     = RGB(0, 0, 0)
437:                 .BorderColor   = RGB(100, 100, 100)
438:                 .Themes        = .F.

*-- Linhas 519 a 555:
519:                 .Visible       = .T.
520:             ENDWITH
521:             IF USED("tmpnens")
522:                 THIS.cnt_4c_Destino.txt_4c_Grupo.ControlSource = "tmpnens.grupods"
523:             ENDIF
524: 
525:             .AddObject("txt_4c_Conta", "TextBox")
526:             WITH .txt_4c_Conta
527:                 .Left          = 93
528:                 .Top           = 32
529:                 .Width         = 80
530:                 .ReadOnly      = .T.
531:                 .SpecialEffect = 1
532:                 .FontName      = "Tahoma"
533:                 .FontSize      = 8
534:                 .ForeColor     = RGB(0, 0, 0)
535:                 .BorderColor   = RGB(100, 100, 100)
536:                 .Themes        = .F.
537:                 .Visible       = .T.
538:             ENDWITH
539:             IF USED("tmpnens")
540:                 THIS.cnt_4c_Destino.txt_4c_Conta.ControlSource = "tmpnens.contads"
541:             ENDIF
542: 
543:             .AddObject("txt_4c_Dconta", "TextBox")
544:             WITH .txt_4c_Dconta
545:                 .Left          = 176
546:                 .Top           = 32
547:                 .Width         = 302
548:                 .Height        = 23
549:                 .ReadOnly      = .T.
550:                 .SpecialEffect = 1
551:                 .FontName      = "Tahoma"
552:                 .FontSize      = 8
553:                 .ForeColor     = RGB(0, 0, 0)
554:                 .BorderColor   = RGB(100, 100, 100)
555:                 .Themes        = .F.

*-- Linhas 573 a 591:
573:             RETURN
574:         ENDIF
575: 
576:         SELECT tmpnens
577: 
578:         *-- Origem: ICli = tmpnens.contaos
579:         loc_cICli = ALLTRIM(NVL(tmpnens.contaos, ""))
580:         IF NOT EMPTY(loc_cICli)
581:             loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
582:             IF NOT EMPTY(loc_cDescr)
583:                 THIS.cnt_4c_Origem.txt_4c_Dconta.Value = loc_cDescr
584:             ENDIF
585:         ENDIF
586: 
587:         *-- Destino: ICli = tmpnens.contads
588:         loc_cICli = ALLTRIM(NVL(tmpnens.contads, ""))
589:         IF NOT EMPTY(loc_cICli)
590:             loc_cDescr = THIS.this_oBusinessObject.ObterDescricaoConta(loc_cICli)
591:             IF NOT EMPTY(loc_cDescr)

*-- Linhas 671 a 702:
671:                 .HighlightBackColor = RGB(255, 255, 255)
672:                 .HighlightForeColor = RGB(15, 41, 104)
673:                 .HighlightStyle     = 2
674:                 .DeleteMark         = .F.
675:                 .RecordMark         = .F.
676:                 .ScrollBars         = 2
677:                 .RowHeight          = 16
678:                 .Visible            = .T.
679:             ENDWITH
680: 
681:             THIS.ConfigurarGrade()
682: 
683:             *-- Vincula grid ao cursor xOpi compartilhado do form pai
684:             IF USED("xOpi")
685:                 THIS.grd_4c_Dados.ColumnCount  = 7
686:                 THIS.grd_4c_Dados.RecordSource = "xOpi"
687:                 SELECT xOpi
688:                 GO TOP
689:                 *-- Inicializa header tag de Column5 conforme estado da primeira linha
690:                 IF NOT EOF("xOpi")
691:                     IF VARTYPE(indiv) = "L"
692:                         THIS.grd_4c_Dados.Column5.Header1.Tag = IIF(NVL(indiv, .F.), "X", "")
693:                     ELSE
694:                         THIS.grd_4c_Dados.Column5.Header1.Tag = IIF(NVL(indiv, 0) = 1, "X", "")
695:                     ENDIF
696:                 ENDIF
697:                 THIS.grd_4c_Dados.Refresh()
698:             ENDIF
699: 
700:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
701: 
702:             *-- Label "Descricao" (Say2 no legado, Top=485, Left=12)

*-- Linhas 759 a 777:
759:                 .Visible   = .T.
760:             ENDWITH
761:             IF USED("xmfas")
762:                 THIS.obj_4c_MmObs.ControlSource = "xmfas.obss"
763:             ENDIF
764: 
765:             *-- Label aviso peso medio (Say1 no legado, Top=532, Left=12)
766:             THIS.AddObject("lbl_4c_LblAtencao", "Label")
767:             WITH THIS.lbl_4c_LblAtencao
768:                 .Top       = 532
769:                 .Left      = 12
770:                 .AutoSize  = .T.
771:                 .Caption   = "Aten" + CHR(231) + CHR(227) + "o: a finaliza" + CHR(231) + CHR(227) + "o considera o Peso M" + CHR(233) + "dio Real"
772:                 .FontName  = "Tahoma"
773:                 .FontSize  = 8
774:                 .ForeColor = RGB(90, 90, 90)
775:                 .BackStyle = 0
776:                 .Visible   = .T.
777:             ENDWITH

*-- Linhas 803 a 935:
803:                 .FontName          = "Arial"
804:                 .Header1.Caption   = "Ordem Fabrica" + CHR(231) + CHR(227) + "o"
805:                 .Header1.Alignment = 2
806:                 .ControlSource     = "xOpi.nops"
807:             ENDWITH
808:             WITH loc_oGrid.Column1.Text1
809:                 .FontName    = "Arial"
810:                 .BorderStyle = 0
811:                 .Margin      = 0
812:                 .ForeColor   = RGB(0, 0, 0)
813:                 .BackColor   = RGB(255, 255, 255)
814:             ENDWITH
815: 
816:             *-- Column2: Pedido (xOpi.oper) - largura 310 conforme original; Tab->OK
817:             WITH loc_oGrid.Column2
818:                 .Width             = 310
819:                 .ReadOnly          = .T.
820:                 .Header1.Caption   = "Pedido"
821:                 .Header1.Alignment = 2
822:                 .ControlSource     = "xOpi.oper"
823:             ENDWITH
824:             WITH loc_oGrid.Column2.Text1
825:                 .Alignment   = 0
826:                 .BorderStyle = 0
827:                 .Margin      = 0
828:                 .ForeColor   = RGB(0, 0, 0)
829:                 .BackColor   = RGB(255, 255, 255)
830:             ENDWITH
831:             BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GradeColumn2KeyPress")
832: 
833:             *-- Column3: Quantidade (xOpi.qtds) - largura 150; editavel; processa xPesa em Enter/Tab
834:             WITH loc_oGrid.Column3
835:                 .Width             = 150
836:                 .ReadOnly          = .F.
837:                 .Header1.Caption   = "Quantidade"
838:                 .Header1.Alignment = 2
839:                 .ControlSource     = "xOpi.qtds"
840:             ENDWITH
841:             WITH loc_oGrid.Column3.Text1
842:                 .BorderStyle = 0
843:                 .Margin      = 0
844:                 .ForeColor   = RGB(0, 0, 0)
845:                 .BackColor   = RGB(255, 255, 255)
846:             ENDWITH
847:             BINDEVENT(loc_oGrid.Column3.Text1, "KeyPress", THIS, "GradeColumn3KeyPress")
848: 
849:             *-- Column4: Produto (xOpi.cpros) - largura 150 conforme original
850:             WITH loc_oGrid.Column4
851:                 .Width             = 150
852:                 .ReadOnly          = .T.
853:                 .Header1.Caption   = "Produto"
854:                 .Header1.Alignment = 2
855:                 .ControlSource     = "xOpi.cpros"
856:             ENDWITH
857:             WITH loc_oGrid.Column4.Text1
858:                 .BorderStyle = 0
859:                 .Margin      = 0
860:                 .ForeColor   = RGB(0, 0, 0)
861:                 .BackColor   = RGB(255, 255, 255)
862:             ENDWITH
863: 
864:             *-- Column5: Ind (xOpi.indiv) - largura 25 conforme original; CheckBox
865:             *-- CRITICO: AddObject Check1 ANTES de CurrentControl e ControlSource
866:             loc_oGrid.Column5.AddObject("Check1", "CheckBox")
867:             WITH loc_oGrid.Column5.Check1
868:                 .Caption   = ""
869:                 .Value     = 0
870:                 .Width     = 40
871:                 .Height    = 16
872:                 .Alignment = 2
873:                 .Centered  = .T.
874:             ENDWITH
875:             WITH loc_oGrid.Column5
876:                 .Width             = 25
877:                 .CurrentControl    = "Check1"
878:                 .Header1.Caption   = "Ind"
879:                 .Header1.Alignment = 2
880:                 .ControlSource     = "xOpi.indiv"
881:             ENDWITH
882:             IF THIS.this_cEscolha <> "INSERIR"
883:                 loc_oGrid.Column5.ReadOnly = .T.
884:             ENDIF
885:             BINDEVENT(loc_oGrid.Column5.Check1, "InteractiveChange", THIS, "GradeColumn5InteractiveChange")
886:             BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "GradeColumn5HeaderClick")
887: 
888:             *-- Column6: Conta (xOpi.conta) - largura 146 conforme original; ReadOnly
889:             WITH loc_oGrid.Column6
890:                 .Width             = 146
891:                 .ReadOnly          = .T.
892:                 .Header1.Caption   = "Conta"
893:                 .Header1.Alignment = 2
894:                 .ControlSource     = "xOpi.conta"
895:             ENDWITH
896:             WITH loc_oGrid.Column6.Text1
897:                 .BorderStyle = 0
898:                 .Margin      = 0
899:                 .ReadOnly    = .T.
900:                 .ForeColor   = RGB(0, 0, 0)
901:                 .BackColor   = RGB(255, 255, 255)
902:             ENDWITH
903: 
904:             *-- Column7: PM (xOpi.divs) - largura 25 conforme original; CheckBox
905:             *-- CRITICO: mesma ordem que Column5 (AddObject antes de CurrentControl/ControlSource)
906:             loc_oGrid.Column7.AddObject("Check1", "CheckBox")
907:             WITH loc_oGrid.Column7.Check1
908:                 .Caption   = ""
909:                 .Value     = 0
910:                 .Width     = 40
911:                 .Height    = 16
912:                 .Alignment = 2
913:                 .Centered  = .T.
914:             ENDWITH
915:             WITH loc_oGrid.Column7
916:                 .Width             = 25
917:                 .CurrentControl    = "Check1"
918:                 .Header1.Caption   = "PM"
919:                 .Header1.Alignment = 2
920:                 .ControlSource     = "xOpi.divs"
921:             ENDWITH
922:             IF THIS.this_cEscolha <> "INSERIR"
923:                 loc_oGrid.Column7.ReadOnly = .T.
924:             ENDIF
925:             BINDEVENT(loc_oGrid.Column7.Check1, "InteractiveChange", THIS, "GradeColumn7InteractiveChange")
926:             BINDEVENT(loc_oGrid.Column7.Header1, "Click", THIS, "GradeColumn7HeaderClick")
927: 
928:         CATCH TO loc_oErro
929:             MsgErro(loc_oErro.Message, "Erro")
930:         ENDTRY
931:     ENDPROC
932: 
933:     *==========================================================================
934:     * ConfigurarBotoesForm - Botoes Encerrar (canonico), Pesagem e OK
935:     * Encerrar: Left=775 (canonico sistema novo)

*-- Linhas 1043 a 1077:
1043:         LOCAL loc_cCPros, loc_lPodeEditar, loc_lObrigs, loc_lIndiv, loc_oErro
1044:         TRY
1045:             IF USED("xOpi") AND NOT EOF("xOpi")
1046:                 SELECT xOpi
1047:                 loc_cCPros = ALLTRIM(NVL(xOpi.cpros, ""))
1048: 
1049:                 *-- Atualiza descricao do produto em txt_4c_Descr
1050:                 IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
1051:                     THIS.txt_4c_Descr.Value = ""
1052:                     IF NOT EMPTY(loc_cCPros)
1053:                         THIS.this_oBusinessObject.this_cCPros = loc_cCPros
1054:                         IF THIS.this_oBusinessObject.ObterDadosProduto()
1055:                             THIS.txt_4c_Descr.Value = THIS.this_oBusinessObject.this_cDPros
1056:                         ENDIF
1057:                     ENDIF
1058:                 ENDIF
1059: 
1060:                 *-- Atualiza imagem do produto (conforme crSigCdOpd.Imagems)
1061:                 IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
1062:                     SELECT crSigCdOpd
1063:                     IF crSigCdOpd.Imagems = 1
1064:                         THIS.img_4c_FigJpg.Visible = .F.
1065:                         THIS.img_4c_FigJpg.Picture  = ""
1066:                         THIS.shp_4c_Shape4.Visible  = .F.
1067: 
1068:                         LOCAL loc_cFigJpgs, loc_cBase64, loc_cTempFile
1069:                         loc_cFigJpgs = THIS.this_oBusinessObject.this_cFigJpgs
1070: 
1071:                         IF NOT EMPTY(ALLTRIM(NVL(loc_cFigJpgs, "")))
1072:                             loc_cBase64 = STRTRAN(STRTRAN(loc_cFigJpgs, ;
1073:                                 "data:image/png;base64,", ""), ;
1074:                                 "data:image/jpeg;base64,", "")
1075:                             loc_cBase64 = STRTRAN(loc_cBase64, "data:image/jpg;base64,", "")
1076: 
1077:                             IF NOT EMPTY(ALLTRIM(loc_cBase64))

*-- Linhas 1088 a 1106:
1088: 
1089:                 *-- Ajusta ReadOnly de Column5/Column7 conforme condicoes da linha corrente
1090:                 IF USED("xOpi") AND NOT EOF("xOpi")
1091:                     SELECT xOpi
1092:                     loc_lPodeEditar = (THIS.this_cEscolha = "INSERIR")
1093:                     IF VARTYPE(obrigs) = "L"
1094:                         loc_lObrigs = NVL(obrigs, .F.)
1095:                     ELSE
1096:                         IF VARTYPE(obrigs) = "L"
1097:                             loc_lObrigs = obrigs
1098:                         ELSE
1099:                             IF VARTYPE(obrigs) = "L"
1100:                                 loc_lObrigs = obrigs
1101:                             ELSE
1102:                                 IF VARTYPE(obrigs) = "L"
1103:                                     loc_lObrigs = obrigs
1104:                                 ELSE
1105:                                     IF VARTYPE(obrigs) = "L"
1106:                                         loc_lObrigs = obrigs

*-- Linhas 1181 a 1199:
1181:         ELSE
1182:             IF par_nKeyCode = 13
1183:             IF USED("xOpi") AND NOT EOF("xOpi")
1184:                 SELECT xOpi
1185:                 IF EMPTY(ALLTRIM(NVL(xOpi.oper, "")))
1186:                     loc_lSetFocus = .T.
1187:                 ENDIF
1188:             ENDIF
1189:             ENDIF
1190:         ENDIF
1191:         IF loc_lSetFocus
1192:             IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1193:                 THIS.cmd_4c_Ok.SetFocus
1194:             ENDIF
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *==========================================================================
1199:     * GradeColumn3KeyPress - Enter/Tab processa pesagem via BO.Inserir()

*-- Linhas 1207 a 1236:
1207:         loc_lProcessar = .F.
1208:         TRY
1209:             IF USED("xOpi") AND NOT EOF("xOpi")
1210:                 SELECT xOpi
1211:                 IF ALLTRIM(THIS.this_cDopp) = ALLTRIM(NVL(xOpi.dopes, ""))
1212:                     IF PEMSTATUS(THIS.grd_4c_Dados.Column3, "Text1", 5)
1213:                         loc_nQtds = NVL(THIS.grd_4c_Dados.Column3.Text1.Value, 0)
1214:                     ELSE
1215:                         loc_nQtds = NVL(xOpi.qtds, 0)
1216:                     ENDIF
1217:                     IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
1218:                         THIS.this_oBusinessObject.this_nQtds = loc_nQtds
1219:                         THIS.this_oBusinessObject.ObterDadosOpe(THIS.this_oBusinessObject.this_cDopes)
1220:                         IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1221:                             SELECT CrSigCdPam
1222:                             THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1223:                         ENDIF
1224:                         loc_lProcessar = .T.
1225:                     ENDIF
1226:                 ENDIF
1227:             ENDIF
1228:             IF loc_lProcessar
1229:                 THIS.this_oBusinessObject.Inserir()
1230:                 THIS.grd_4c_Dados.Refresh()
1231:             ENDIF
1232:         CATCH TO loc_oErro
1233:             MsgErro(loc_oErro.Message, "Erro")
1234:         ENDTRY
1235:     ENDPROC
1236: 

*-- Linhas 1243 a 1261:
1243:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_oErro
1244:         TRY
1245:             IF USED("xOpi") AND NOT EOF("xOpi")
1246:                 SELECT xOpi
1247:                 IF VARTYPE(obrigs) = "L"
1248:                     loc_lObrigs = NVL(obrigs, .F.)
1249:                 ELSE
1250:                     IF VARTYPE(obrigs) = "L"
1251:                         loc_lObrigs = obrigs
1252:                     ELSE
1253:                         IF VARTYPE(obrigs) = "L"
1254:                             loc_lObrigs = obrigs
1255:                         ELSE
1256:                             IF VARTYPE(obrigs) = "L"
1257:                                 loc_lObrigs = obrigs
1258:                             ELSE
1259:                                 IF VARTYPE(obrigs) = "L"
1260:                                     loc_lObrigs = obrigs
1261:                                 ELSE

*-- Linhas 1278 a 1303:
1278:                 IF loc_lCondicaoOk
1279:                     IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
1280:                         IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1281:                             SELECT CrSigCdPam
1282:                             THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1283:                         ENDIF
1284:                         THIS.this_oBusinessObject.InserirPorCheckbox()
1285:                     ENDIF
1286:                 ELSE
1287:                     *-- Reverte mudanca (condicoes nao atendidas)
1288:                     SELECT xOpi
1289:                     IF VARTYPE(indiv) = "L"
1290:                         REPLACE indiv WITH NOT NVL(indiv, .F.)
1291:                     ELSE
1292:                         REPLACE indiv WITH IIF(NVL(indiv, 0) = 1, 0, 1)
1293:                     ENDIF
1294:                 ENDIF
1295:             ENDIF
1296:             THIS.grd_4c_Dados.Refresh()
1297:         CATCH TO loc_oErro
1298:             MsgErro(loc_oErro.Message, "Erro")
1299:         ENDTRY
1300:     ENDPROC
1301: 
1302:     *==========================================================================
1303:     * GradeColumn5HeaderClick - Clique no header "Ind": toggle todos xOpi.Indiv

*-- Linhas 1315 a 1360:
1315:             loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column5.Header1.Tag)
1316: 
1317:             IF USED("xOpi")
1318:                 SELECT xOpi
1319:                 GO TOP
1320:                 REPLACE ALL Indiv WITH loc_lTagAtual
1321:                 GO TOP
1322:             ENDIF
1323: 
1324:             IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1325:                 SELECT CrSigCdPam
1326:                 THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1327:             ENDIF
1328: 
1329:             THIS.this_oBusinessObject.ProcessarTodasOpi()
1330:             THIS.grd_4c_Dados.Refresh()
1331:         CATCH TO loc_oErro
1332:             MsgErro(loc_oErro.Message, "Erro")
1333:         ENDTRY
1334:     ENDPROC
1335: 
1336:     *==========================================================================
1337:     * GradeColumn7InteractiveChange - CheckBox PM: atualiza Divs no xPesa
1338:     * Equivale a Column7.Check1.InteractiveChange do legado
1339:     * Se condicao nao atendida (nao INSERIR, Obrigs ou Indiv), reverte checkbox
1340:     *==========================================================================
1341:     PROCEDURE GradeColumn7InteractiveChange()
1342:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_lIndiv, loc_oErro
1343:         TRY
1344:             IF USED("xOpi") AND NOT EOF("xOpi")
1345:                 SELECT xOpi
1346:                 IF VARTYPE(obrigs) = "L"
1347:                     loc_lObrigs = NVL(obrigs, .F.)
1348:                 ELSE
1349:                     IF VARTYPE(obrigs) = "L"
1350:                         loc_lObrigs = obrigs
1351:                     ELSE
1352:                         IF VARTYPE(obrigs) = "L"
1353:                             loc_lObrigs = obrigs
1354:                         ELSE
1355:                             IF VARTYPE(obrigs) = "L"
1356:                                 loc_lObrigs = obrigs
1357:                             ELSE
1358:                                 IF VARTYPE(obrigs) = "L"
1359:                                     loc_lObrigs = obrigs
1360:                                 ELSE

*-- Linhas 1409 a 1427:
1409:                     ENDIF
1410:                 ELSE
1411:                     *-- Reverte mudanca (condicoes nao atendidas)
1412:                     SELECT xOpi
1413:                     IF VARTYPE(divs) = "L"
1414:                         REPLACE divs WITH NOT NVL(divs, .F.)
1415:                     ELSE
1416:                         REPLACE divs WITH IIF(NVL(divs, 0) = 1, 0, 1)
1417:                     ENDIF
1418:                 ENDIF
1419:             ENDIF
1420:             THIS.grd_4c_Dados.Refresh()
1421:         CATCH TO loc_oErro
1422:             MsgErro(loc_oErro.Message, "Erro")
1423:         ENDTRY
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * GradeColumn7HeaderClick - Clique no header "PM": toggle todos xOpi.Divs

*-- Linhas 1439 a 1457:
1439:             loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column7.Header1.Tag)
1440: 
1441:             IF USED("xOpi")
1442:                 SELECT xOpi
1443:                 GO TOP
1444:                 REPLACE ALL Divs WITH loc_lTagAtual
1445:                 GO TOP
1446:             ENDIF
1447: 
1448:             THIS.this_oBusinessObject.AtualizarDivsTodas()
1449:             THIS.grd_4c_Dados.Refresh()
1450:         CATCH TO loc_oErro
1451:             MsgErro(loc_oErro.Message, "Erro")
1452:         ENDTRY
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     * BtnOkClick - Confirma emissao de etiquetas e retorna ao form pai
1457:     * Equivale a "ok".Click do legado:

*-- Linhas 1465 a 1498:
1465: 
1466:             IF THIS.this_cEscolha = "CONSULTAR"
1467:                 IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
1468:                     SELECT crSigCdOpd
1469:                     IF INLIST(crSigCdOpd.Etiqs, 1, 3)
1470:                         loc_lImprimir = MsgConfirma("Deseja imprimir as etiquetas.")
1471:                     ENDIF
1472:                 ENDIF
1473:             ENDIF
1474: 
1475:             IF loc_lImprimir
1476:                 IF USED("TmpNens") AND NOT EOF("TmpNens")
1477:                     SELECT TmpNens
1478:                     GO TOP
1479:                     loc_cPosicao = TmpNens.Emps + TmpNens.Dopps + STR(TmpNens.Numps, 10)
1480:                     LOCAL loc_lSeekOk
1481:                     loc_lSeekOk = SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
1482:                     IF USED("crSigCdNec")
1483:                         SELECT crSigCdNec
1484:                         LOCATE FOR EmpDNPs = loc_cPosicao
1485:                     ENDIF
1486:                     loc_oFormEtiquetas = CREATEOBJECT("FormSigPdM10", THIS, .T.)
1487:                     IF VARTYPE(loc_oFormEtiquetas) = "O"
1488:                         loc_oFormEtiquetas.Show()
1489:                     ELSE
1490:                         MsgErro("Erro ao criar FormSigPdM10.", "Etiquetas")
1491:                     ENDIF
1492:                 ENDIF
1493:             ENDIF
1494: 
1495:             SET CONFIRM OFF
1496:             IF VARTYPE(THIS.this_oFormPai) = "O"
1497:                 THIS.this_oFormPai.Enabled = .T.
1498:             ENDIF

*-- Linhas 1505 a 1529:
1505: 
1506:     *==========================================================================
1507:     * BtnPesagemClick - Abre FormSigPdMp9 passando este form como pai
1508:     * Equivale a "Pesagem".Click do legado: Select xPesa + Enabled=.F. + DoForm
1509:     *==========================================================================
1510:     PROCEDURE BtnPesagemClick()
1511:         LOCAL loc_oFormPesagem, loc_oErro
1512:         TRY
1513:             IF USED("xPesa")
1514:                 SELECT xPesa
1515:                 GO TOP
1516:             ENDIF
1517:             THIS.Enabled = .F.
1518:             loc_oFormPesagem = CREATEOBJECT("FormSigPdMp9", THIS)
1519:             IF VARTYPE(loc_oFormPesagem) = "O"
1520:                 loc_oFormPesagem.Show()
1521:             ELSE
1522:                 MsgErro("Erro ao criar FormSigPdMp9.", "Pesagem")
1523:                 THIS.Enabled = .T.
1524:             ENDIF
1525:         CATCH TO loc_oErro
1526:             MsgErro(loc_oErro.Message, "Erro")
1527:             THIS.Enabled = .T.
1528:         ENDTRY
1529:     ENDPROC

*-- Linhas 1559 a 1577:
1559:             ENDIF
1560: 
1561:             *-- Marca todos os itens nao-obrigatorios como Indiv = .T.
1562:             SELECT xOpi
1563:             GO TOP
1564:             SCAN
1565:                 IF NOT xOpi.Obrigs
1566:                     REPLACE Indiv WITH .T. IN xOpi
1567:                 ENDIF
1568:             ENDSCAN
1569: 
1570:             *-- Atualiza TAG do header Column5 para refletir estado "marcado"
1571:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1572:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
1573:                     THIS.grd_4c_Dados.Column5.Header1.Tag = "X"
1574:                 ENDIF
1575:                 THIS.grd_4c_Dados.Refresh()
1576:             ENDIF
1577: 

*-- Linhas 1603 a 1634:
1603:             ENDIF
1604: 
1605:             *-- Marca Divs=.T. para todos os itens nao-obrigatorios e nao-individuais
1606:             SELECT xOpi
1607:             GO TOP
1608:             SCAN
1609:                 IF NOT xOpi.Obrigs AND NOT xOpi.Indiv
1610:                     REPLACE Divs WITH .T. IN xOpi
1611:                 ENDIF
1612:             ENDSCAN
1613: 
1614:             *-- Propaga Divs para xPesa (mesma logica de Column7.Header1.Click)
1615:             IF USED("xPesa")
1616:                 SELECT xOpi
1617:                 GO TOP
1618:                 SCAN
1619:                     UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
1620:                 ENDSCAN
1621:             ENDIF
1622: 
1623:             *-- Atualiza TAG do header Column7 para refletir estado "marcado"
1624:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1625:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
1626:                     THIS.grd_4c_Dados.Column7.Header1.Tag = "X"
1627:                 ENDIF
1628:                 THIS.grd_4c_Dados.Refresh()
1629:             ENDIF
1630: 
1631:         CATCH TO loc_oErro
1632:             MsgErro(loc_oErro.Message, "Erro")
1633:         ENDTRY
1634:     ENDPROC

*-- Linhas 1686 a 1714:
1686:             ENDIF
1687: 
1688:             *-- Desmarca Indiv e Divs em todos os itens nao-obrigatorios
1689:             SELECT xOpi
1690:             GO TOP
1691:             SCAN
1692:                 IF NOT xOpi.Obrigs
1693:                     REPLACE Indiv WITH .F., Divs WITH .F. IN xOpi
1694:                 ENDIF
1695:             ENDSCAN
1696: 
1697:             *-- Propaga limpeza para xPesa
1698:             IF USED("xPesa")
1699:                 SELECT xPesa
1700:                 GO TOP
1701:                 SCAN
1702:                     REPLACE Divs WITH .F. IN xPesa
1703:                 ENDSCAN
1704:             ENDIF
1705: 
1706:             *-- Limpa TAGs dos headers
1707:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1708:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
1709:                     THIS.grd_4c_Dados.Column5.Header1.Tag = ""
1710:                 ENDIF
1711:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
1712:                     THIS.grd_4c_Dados.Column7.Header1.Tag = ""
1713:                 ENDIF
1714:                 THIS.grd_4c_Dados.Refresh()

*-- Linhas 1723 a 1755:
1723:     * ReprocessarPesagemPorAmarra - Reprocessa cursor xPesa baseado nas
1724:     * marcacoes Indiv/Divs de xOpi. Helper compartilhado entre BtnIncluirClick
1725:     * e a logica original de GradeColumn5HeaderClick. Replica trecho do legado
1726:     * que faz CursorQuery em SigCdPro/SigCdGrp/SigCdGpr + DELETE + INSERT em
1727:     * xPesa para cada linha de xOpi.
1728:     *==========================================================================
1729:     PROTECTED PROCEDURE ReprocessarPesagemPorAmarra()
1730:         LOCAL loc_oErro
1731:         TRY
1732:             IF NOT USED("xPesa") OR NOT USED("xOpi")
1733:                 RETURN
1734:             ENDIF
1735: 
1736:             SELECT xOpi
1737:             GO TOP
1738:             SCAN
1739:                 *-- Limpa entradas anteriores da amarra atual
1740:                 DELETE FROM xPesa WHERE Amarra = xOpi.Amarra
1741:             ENDSCAN
1742: 
1743:             *-- Refresh do grid apos reprocessar
1744:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1745:                 THIS.grd_4c_Dados.Refresh()
1746:             ENDIF
1747: 
1748:         CATCH TO loc_oErro
1749:             MsgErro(loc_oErro.Message, "Erro")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     *==========================================================================
1754:     * ConfigurarPaginaDados - Ajuste fino do grid e campos do form operacional
1755:     * Complementa ConfigurarGrade() com propriedades que replicam o legado:

*-- Linhas 1894 a 1932:
1894: 
1895:             *-- Contexto da operacao (TmpNens corrente)
1896:             IF USED("TmpNens") AND NOT EOF("TmpNens")
1897:                 SELECT TmpNens
1898:                 loc_oBO.this_cEmps   = ALLTRIM(NVL(TmpNens.Emps, ""))
1899:                 loc_oBO.this_cDopps  = ALLTRIM(NVL(TmpNens.Dopps, ""))
1900:                 loc_oBO.this_nNumps  = NVL(TmpNens.Numps, 0)
1901:                 IF TYPE("TmpNens.grupoos") <> "U"
1902:                     loc_oBO.this_cGrupoOs = ALLTRIM(NVL(TmpNens.grupoos, ""))
1903:                 ENDIF
1904:                 IF TYPE("TmpNens.contaos") <> "U"
1905:                     loc_oBO.this_cContaOs = ALLTRIM(NVL(TmpNens.contaos, ""))
1906:                 ENDIF
1907:                 IF TYPE("TmpNens.grupods") <> "U"
1908:                     loc_oBO.this_cGrupoDs = ALLTRIM(NVL(TmpNens.grupods, ""))
1909:                 ENDIF
1910:                 IF TYPE("TmpNens.contads") <> "U"
1911:                     loc_oBO.this_cContaDs = ALLTRIM(NVL(TmpNens.contads, ""))
1912:                 ENDIF
1913:             ENDIF
1914: 
1915:             *-- Flags de exibicao (crSigCdOpd)
1916:             IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
1917:                 SELECT crSigCdOpd
1918:                 loc_oBO.this_nOrigems  = NVL(crSigCdOpd.Origems, 0)
1919:                 loc_oBO.this_nDestinos = NVL(crSigCdOpd.Destinos, 0)
1920:                 loc_oBO.this_nImagms   = NVL(crSigCdOpd.Imagems, 0)
1921:                 loc_oBO.this_nEtiqs    = NVL(crSigCdOpd.Etiqs, 0)
1922:                 IF TYPE("crSigCdOpd.Dopes") <> "U"
1923:                     loc_oBO.this_cDopesOpd = ALLTRIM(NVL(crSigCdOpd.Dopes, ""))
1924:                 ENDIF
1925:             ENDIF
1926: 
1927:             *-- Descricoes de conta de origem/destino (campos visiveis)
1928:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
1929:                 loc_oBO.this_cGrupoOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)
1930:                 loc_oBO.this_cContaOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)
1931:                 loc_oBO.this_cDcontaOs = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Dconta.Value)
1932:             ENDIF

*-- Linhas 2042 a 2060:
2042:             ENDIF
2043: 
2044:             loc_oGrid = THIS.grd_4c_Dados
2045:             SELECT xOpi
2046:             GO TOP
2047: 
2048:             *-- Re-bind do RecordSource (apenas se diferente, para preservar estado)
2049:             IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) <> "XOPI"
2050:                 loc_oGrid.RecordSource = "xOpi"
2051:             ENDIF
2052: 
2053:             loc_oGrid.Refresh()
2054: 
2055:             *-- Atualiza descricao/imagem do produto da linha corrente
2056:             IF NOT EOF("xOpi")
2057:                 THIS.GradeAfterRowColChange(1)
2058:             ENDIF
2059: 
2060:             loc_lResultado = .T.


### BO (C:\4c\projeto\app\classes\SigPdMp3BO.prg):
*==============================================================================
* SigPdMp3BO.prg - Business Object para Emissao de Etiquetas (SIGPDMP9)
* Herda de: BusinessBase
* Form: FormSigPdMp3 (sub-form de emissao de etiquetas de pesagem)
* Legado: SigPdMp3.SCX / SIGPDMP9
*==============================================================================
DEFINE CLASS SigPdMp3BO AS BusinessBase

    *-- Contexto recebido do form pai
    this_cDopp      = ""    && _Dopp do form pai (operacao corrente)
    this_cEscolha   = ""    && pcEscolha do form pai (INSERIR/CONSULTAR)

    *-- Cabecalho da operacao (TmpNens)
    this_cEmps      = ""    && Empresa (TmpNens.emps)
    this_cDopps     = ""    && Codigo da operacao (TmpNens.dopps)
    this_nNumps     = 0     && Numero da operacao (TmpNens.numps)
    this_cGrupoOs   = ""    && Grupo origem (TmpNens.grupoos)
    this_cContaOs   = ""    && Conta origem (TmpNens.contaos)
    this_cDcontaOs  = ""    && Nome da conta origem (SigCdCli.RClis)
    this_cGrupoDs   = ""    && Grupo destino (TmpNens.grupods)
    this_cContaDs   = ""    && Conta destino (TmpNens.contads)
    this_cDcontaDs  = ""    && Nome da conta destino (SigCdCli.RClis)

    *-- Flags da operacao (crSigCdOpd)
    this_nOrigems   = 0     && Exibir container Origem (crSigCdOpd.Origems)
    this_nDestinos  = 0     && Exibir container Destino (crSigCdOpd.Destinos)
    this_nImagms    = 0     && Exibir imagem do produto (crSigCdOpd.Imagems)
    this_nEtiqs     = 0     && Tipo de etiquetas (crSigCdOpd.Etiqs)
    this_cDopesOpd  = ""    && Dopes de crSigCdOpd

    *-- Linha corrente do grid xOpi
    this_nNops      = 0     && Numero OP / Ordem Fabricacao (xOpi.nops) - Column1
    this_cOper      = ""    && Pedido/operacao (xOpi.oper) - Column2
    this_nQtds      = 0     && Quantidade (xOpi.qtds) - Column3
    this_cCPros     = ""    && Codigo do produto (xOpi.cpros) - Column4
    this_lIndiv     = .F.   && Flag individual (xOpi.indiv) - Column5 checkbox
    this_cConta     = ""    && Conta (xOpi.conta) - Column6
    this_lDivs      = .F.   && Flag divisao PM (xOpi.Divs) - Column7 checkbox
    this_cAmarra    = ""    && Codigo de amarracao (xOpi.amarra)
    this_nCbars     = 0     && Flag codigo de barras (xOpi.cbars)
    this_cCodCors   = ""    && Codigo da cor (xOpi.codcors)
    this_cCodTams   = ""    && Codigo do tamanho (xOpi.codtams)
    this_cEmpds     = ""    && Empresa destino (xOpi.empds)
    this_cDopes     = ""    && Data/operacao (xOpi.dopes)
    this_nNumes     = 0     && Numero (xOpi.numes)
    this_cCitens    = ""    && Codigo do item (xOpi.citens)
    this_nNenvs     = 0     && Numero do envelope (xOpi.nenvs)
    this_lObrigs    = .F.   && Flag obrigatorio (xOpi.obrigs)

    *-- Dados do produto (SigCdPro via CursorQuery)
    this_cDPros     = ""    && Descricao do produto (DPros)
    this_cFigJpgs   = ""    && Imagem base64 (FigJpgs)
    this_cMatPrincs = ""    && Material principal (SigCdPro.MatPrincs)
    this_cCgrus     = ""    && Grupo do produto (SigCdPro.Cgrus)
    this_nPesoms    = 0     && Peso medio (SigCdPro.Pesoms)

    *-- Dados do grupo (SigCdGrp via CursorQuery)
    this_cMercs     = ""    && Mercadoria (SigCdGrp.Mercs)

    *-- Dados do sub-grupo (SigCdGpr via CursorQuery)
    this_cMatPGpr   = ""    && Material do sub-grupo (SigCdGpr.MatPrincs)
    this_nCpQtds    = 0     && Qtde por unidade (SigCdGpr.cpqtds)

    *-- Material e flags calculados
    this_cMatP      = ""    && Material efetivo resolvido (_MatP)
    this_lEspecial  = .F.   && Flag especial (CadProds=3 ou Pesos=1)
    this_nCadProds  = 0     && Tipo de cadastro do produto (SigCdOpe.CadProds)
    this_nPesos     = 0     && Flag de peso (SigCdOpe.Pesos)

    *-- Exibicao e observacao
    this_cDescr     = ""    && Descricao exibida em Get_descr
    this_cObs       = ""    && Observacao (xmfas.obss)

    *-- Auxiliar para impressao de etiquetas (ok.Click)
    this_cPosicao   = ""    && Posicao para Seek crSigCdNec

    *-- Material fallback de CrSigCdPam.Ouros (preenchido pelo Form antes de Inserir)
    this_cOuros     = ""

    *==========================================================================
    * Init - Inicializa o BO
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades da linha corrente do cursor xOpi
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops    = NVL(nops, 0)
                THIS.this_cOper    = ALLTRIM(NVL(oper, ""))
                THIS.this_nQtds    = NVL(qtds, 0)
                THIS.this_cCPros   = ALLTRIM(NVL(cpros, ""))
                IF VARTYPE(indiv) = "L"
                    THIS.this_lIndiv = NVL(indiv, .F.)
                ELSE
                    THIS.this_lIndiv = IIF(NVL(indiv, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cConta   = ALLTRIM(NVL(conta, ""))
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    THIS.this_lDivs = IIF(NVL(Divs, 0) = 1, .T., .F.)
                ENDIF
                THIS.this_cAmarra  = ALLTRIM(NVL(amarra, ""))
                THIS.this_nCbars   = NVL(cbars, 0)
                THIS.this_cCodCors = ALLTRIM(NVL(codcors, ""))
                THIS.this_cCodTams = ALLTRIM(NVL(codtams, ""))
                THIS.this_cEmpds   = ALLTRIM(NVL(empds, ""))
                THIS.this_cDopes   = ALLTRIM(NVL(dopes, ""))
                THIS.this_nNumes   = NVL(numes, 0)
                THIS.this_cCitens  = ALLTRIM(NVL(citens, ""))
                THIS.this_nNenvs   = NVL(nenvs, 0)
                IF VARTYPE(obrigs) = "L"
                    THIS.this_lObrigs = NVL(obrigs, .F.)
                ELSE
                    THIS.this_lObrigs = IIF(NVL(obrigs, 0) = 1, .T., .F.)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosProduto - Consulta SigCdPro, SigCdGrp, SigCdGpr; resolve MatP
    *==========================================================================
    PROCEDURE ObterDadosProduto()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_cMatPrincs = ""
        THIS.this_cCgrus     = ""
        THIS.this_nPesoms    = 0
        THIS.this_cMercs     = ""
        THIS.this_cMatPGpr   = ""
        THIS.this_nCpQtds    = 0
        THIS.this_cMatP      = ""
        THIS.this_cDPros     = ""
        THIS.this_cFigJpgs   = ""
        TRY
            loc_cSQL = "SELECT MatPrincs, Cgrus, PesoMs, DPros, FigJpgs" + ;
                       " FROM SigCdPro" + ;
                       " WHERE CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
            IF USED("cursor_4c_LocalPro")
                USE IN cursor_4c_LocalPro
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalPro")
                SELECT cursor_4c_LocalPro
                THIS.this_cMatPrincs = ALLTRIM(NVL(MatPrincs, ""))
                THIS.this_cCgrus     = ALLTRIM(NVL(Cgrus, ""))
                THIS.this_nPesoms    = NVL(PesoMs, 0)
                THIS.this_cDPros     = ALLTRIM(NVL(DPros, ""))
                THIS.this_cFigJpgs   = NVL(FigJpgs, "")

                IF NOT EMPTY(THIS.this_cCgrus)
                    loc_cSQL = "SELECT Mercs FROM SigCdGrp WHERE CGrus = " + ;
                               EscaparSQL(ALLTRIM(THIS.this_cCgrus))
                    IF USED("cursor_4c_LocalGru")
                        USE IN cursor_4c_LocalGru
                    ENDIF
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGru")
                    IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGru")
                        SELECT cursor_4c_LocalGru
                        THIS.this_cMercs = ALLTRIM(NVL(Mercs, ""))

                        IF NOT EMPTY(THIS.this_cMercs)
                            loc_cSQL = "SELECT MatPrincs, cpqtds FROM SigCdGpr" + ;
                                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cMercs))
                            IF USED("cursor_4c_LocalGgrp")
                                USE IN cursor_4c_LocalGgrp
                            ENDIF
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalGgrp")
                            IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalGgrp")
                                SELECT cursor_4c_LocalGgrp
                                THIS.this_cMatPGpr = ALLTRIM(NVL(MatPrincs, ""))
                                THIS.this_nCpQtds  = NVL(cpqtds, 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF NOT EMPTY(THIS.this_cMatPrincs)
                THIS.this_cMatP = THIS.this_cMatPrincs
            ELSE
                IF NOT EMPTY(THIS.this_cMatPGpr)
                    THIS.this_cMatP = THIS.this_cMatPGpr
                ELSE
                    THIS.this_cMatP = THIS.this_cOuros
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDescricaoConta - Retorna RClis do SigCdCli para o ICli informado
    *==========================================================================
    PROCEDURE ObterDescricaoConta(par_cICli)
        LOCAL loc_cResult, loc_cSQL, loc_nResult
        loc_cResult = ""
        TRY
            IF NOT EMPTY(ALLTRIM(par_cICli))
                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(ALLTRIM(par_cICli))
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalCli")
                    SELECT cursor_4c_LocalCli
                    loc_cResult = ALLTRIM(NVL(RClis, ""))
                ENDIF
                IF USED("cursor_4c_LocalCli")
                    USE IN cursor_4c_LocalCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_cResult
    ENDPROC

    *==========================================================================
    * ObterDadosOpe - Busca CadProds e Pesos de SigCdOpe; define this_lEspecial
    *==========================================================================
    PROCEDURE ObterDadosOpe(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        THIS.this_nCadProds = 0
        THIS.this_nPesos    = 0
        THIS.this_lEspecial = .F.
        TRY
            IF NOT EMPTY(ALLTRIM(par_cDopes))
                loc_cSQL = "SELECT CadProds, Pesos FROM SigCdOpe" + ;
                           " WHERE dopes = " + EscaparSQL(ALLTRIM(par_cDopes))
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
                IF loc_nResult > 0 AND NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    THIS.this_nCadProds = NVL(CadProds, 0)
                    THIS.this_nPesos    = NVL(Pesos, 0)
                    THIS.this_lEspecial = (THIS.this_nCadProds = 3 OR THIS.this_nPesos = 1)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida contexto antes de processar pesagem
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cAmarra))
            MsgAviso("Amarra n" + CHR(227) + "o informada.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF THIS.this_nQtds <= 0
            MsgAviso("Quantidade inv" + CHR(225) + "lida.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Processa pesagem do item corrente (INSERT xPesa com Especial)
    * Equivalente a Grade.Column3.Text1.Valid do legado
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()
            THIS.ObterDadosOpe(THIS.this_cDopes)

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lEspecial, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lEspecial, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Especial, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_lEspecial, THIS.this_cCitens)
            ENDIF

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirPorCheckbox - Pesagem via checkbox indiv (INSERT xPesa com Divs)
    * Equivalente a Grade.Column5.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE InserirPorCheckbox()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xPesa
            DELETE ALL FOR Amarra = THIS.this_cAmarra

            THIS.ObterDadosProduto()

            IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                loc_nCont = INT(THIS.this_nQtds)
                loc_nQtde = 0
                DO WHILE loc_nQtde < loc_nCont
                    loc_nQtde = loc_nQtde + 1
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                ENDDO
                IF (THIS.this_nQtds > loc_nQtde)
                    loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                    INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                       Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                        VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                THIS.this_lDivs, THIS.this_cCitens)
                ENDIF
            ELSE
                loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                   Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                    VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                            THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                            THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                            THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                            THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza flag Divs no xPesa para o amarra corrente
    * Equivalente a Grade.Column7.Check1.InteractiveChange do legado
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            UPDATE xPesa SET Divs = (THIS.this_lDivs) WHERE Amarra = THIS.this_cAmarra
            THIS.RegistrarAuditoria("ATUALIZAR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarDivsTodas - Atualiza Divs em xPesa para todos os registros xOpi
    * Equivalente a Grade.Column7.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE AtualizarDivsTodas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
                SELECT xOpi
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarTodasOpi - Pesagem para todos os registros xOpi (marcar/desmarcar)
    * Equivalente a Grade.Column5.Header1.DblClick do legado
    *==========================================================================
    PROCEDURE ProcessarTodasOpi()
        LOCAL loc_lSucesso, loc_nCont, loc_nQtde, loc_nPeso
        loc_lSucesso = .F.
        loc_nCont    = 0
        loc_nQtde    = 0
        loc_nPeso    = 0
        TRY
            SELECT xOpi
            GO TOP
            SCAN
                IF THIS.CarregarDoCursor("xOpi")
                    THIS.ObterDadosProduto()

                    SELECT xPesa
                    DELETE ALL FOR Amarra = THIS.this_cAmarra

                    IF THIS.this_lIndiv AND (THIS.this_nCbars = 0)
                        loc_nCont = INT(THIS.this_nQtds)
                        loc_nQtde = 0
                        DO WHILE loc_nQtde < loc_nCont
                            loc_nQtde = loc_nQtde + 1
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, 1, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, 1, loc_nPeso, ;
                                        THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms, THIS.this_lDivs, THIS.this_cCitens)
                        ENDDO
                        IF (THIS.this_nQtds > loc_nQtde)
                            loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds - loc_nQtde, 0)
                            INSERT INTO xPesa (Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                               Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, Divs, citens) ;
                                VALUES (THIS.this_cOper, THIS.this_cCPros, THIS.this_nQtds - loc_nQtde, ;
                                        loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, THIS.this_cEmpds, ;
                                        THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                        THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                        THIS.this_nPesoms * (THIS.this_nQtds - loc_nQtde), ;
                                        THIS.this_lDivs, THIS.this_cCitens)
                        ENDIF
                    ELSE
                        loc_nPeso = IIF(THIS.this_nCpQtds = 1, THIS.this_nQtds, 0)
                        INSERT INTO xPesa (cBars, Oper, CPros, Qtds, Peso, Amarra, Nenvs, Emps, ;
                                           Dopes, Numes, Nops, Cors, Tams, MatPs, Pesoms, citens) ;
                            VALUES (THIS.this_nCbars, THIS.this_cOper, THIS.this_cCPros, ;
                                    THIS.this_nQtds, loc_nPeso, THIS.this_cAmarra, THIS.this_nNenvs, ;
                                    THIS.this_cEmpds, THIS.this_cDopes, THIS.this_nNumes, THIS.this_nNops, ;
                                    THIS.this_cCodCors, THIS.this_cCodTams, THIS.this_cMatP, ;
                                    THIS.this_nPesoms * THIS.this_nQtds, THIS.this_cCitens)
                    ENDIF

                    SELECT xOpi
                ENDIF
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador do registro corrente (Amarra)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cAmarra)
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Override: form operacional opera em cursores locais
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        IF NOT EMPTY(THIS.this_cTabela)
            DODEFAULT(par_cOperacao)
        ENDIF
    ENDPROC

ENDDEFINE

