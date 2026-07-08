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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp3.prg) - TRECHOS RELEVANTES PARA PASS SQL (2194 linhas total):

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
1105:                                     loc_lObrigs = (NVL(obrigs, 0) = 1)
1106:                                 ENDIF

*-- Linhas 1157 a 1175:
1157:         ELSE
1158:             IF par_nKeyCode = 13
1159:             IF USED("xOpi") AND NOT EOF("xOpi")
1160:                 SELECT xOpi
1161:                 IF EMPTY(ALLTRIM(NVL(xOpi.oper, "")))
1162:                     loc_lSetFocus = .T.
1163:                 ENDIF
1164:             ENDIF
1165:             ENDIF
1166:         ENDIF
1167:         IF loc_lSetFocus
1168:             IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1169:                 THIS.cmd_4c_Ok.SetFocus
1170:             ENDIF
1171:         ENDIF
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     * GradeColumn3KeyPress - Enter/Tab processa pesagem via BO.Inserir()

*-- Linhas 1183 a 1212:
1183:         loc_lProcessar = .F.
1184:         TRY
1185:             IF USED("xOpi") AND NOT EOF("xOpi")
1186:                 SELECT xOpi
1187:                 IF ALLTRIM(THIS.this_cDopp) = ALLTRIM(NVL(xOpi.dopes, ""))
1188:                     IF PEMSTATUS(THIS.grd_4c_Dados.Column3, "Text1", 5)
1189:                         loc_nQtds = NVL(THIS.grd_4c_Dados.Column3.Text1.Value, 0)
1190:                     ELSE
1191:                         loc_nQtds = NVL(xOpi.qtds, 0)
1192:                     ENDIF
1193:                     IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
1194:                         THIS.this_oBusinessObject.this_nQtds = loc_nQtds
1195:                         THIS.this_oBusinessObject.ObterDadosOpe(THIS.this_oBusinessObject.this_cDopes)
1196:                         IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1197:                             SELECT CrSigCdPam
1198:                             THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1199:                         ENDIF
1200:                         loc_lProcessar = .T.
1201:                     ENDIF
1202:                 ENDIF
1203:             ENDIF
1204:             IF loc_lProcessar
1205:                 THIS.this_oBusinessObject.Inserir()
1206:                 THIS.grd_4c_Dados.Refresh()
1207:             ENDIF
1208:         CATCH TO loc_oErro
1209:             MsgErro(loc_oErro.Message, "Erro")
1210:         ENDTRY
1211:     ENDPROC
1212: 

*-- Linhas 1219 a 1267:
1219:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_oErro
1220:         TRY
1221:             IF USED("xOpi") AND NOT EOF("xOpi")
1222:                 SELECT xOpi
1223:                 IF VARTYPE(obrigs) = "L"
1224:                     loc_lObrigs = NVL(obrigs, .F.)
1225:                 ELSE
1226:                     IF VARTYPE(obrigs) = "L"
1227:                         loc_lObrigs = obrigs
1228:                     ELSE
1229:                         IF VARTYPE(obrigs) = "L"
1230:                             loc_lObrigs = obrigs
1231:                         ELSE
1232:                             IF VARTYPE(obrigs) = "L"
1233:                                 loc_lObrigs = obrigs
1234:                             ELSE
1235:                                 loc_lObrigs = (NVL(obrigs, 0) = 1)
1236:                             ENDIF
1237:                         ENDIF
1238:                     ENDIF
1239:                 ENDIF
1240:                 loc_lCondicaoOk = (THIS.this_cEscolha = "INSERIR") AND NOT loc_lObrigs
1241: 
1242:                 IF loc_lCondicaoOk
1243:                     IF THIS.this_oBusinessObject.CarregarDoCursor("xOpi")
1244:                         IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1245:                             SELECT CrSigCdPam
1246:                             THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1247:                         ENDIF
1248:                         THIS.this_oBusinessObject.InserirPorCheckbox()
1249:                     ENDIF
1250:                 ELSE
1251:                     *-- Reverte mudanca (condicoes nao atendidas)
1252:                     SELECT xOpi
1253:                     IF VARTYPE(indiv) = "L"
1254:                         REPLACE indiv WITH NOT NVL(indiv, .F.)
1255:                     ELSE
1256:                         REPLACE indiv WITH IIF(NVL(indiv, 0) = 1, 0, 1)
1257:                     ENDIF
1258:                 ENDIF
1259:             ENDIF
1260:             THIS.grd_4c_Dados.Refresh()
1261:         CATCH TO loc_oErro
1262:             MsgErro(loc_oErro.Message, "Erro")
1263:         ENDTRY
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * GradeColumn5HeaderClick - Clique no header "Ind": toggle todos xOpi.Indiv

*-- Linhas 1279 a 1324:
1279:             loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column5.Header1.Tag)
1280: 
1281:             IF USED("xOpi")
1282:                 SELECT xOpi
1283:                 GO TOP
1284:                 REPLACE ALL Indiv WITH loc_lTagAtual
1285:                 GO TOP
1286:             ENDIF
1287: 
1288:             IF USED("CrSigCdPam") AND NOT EOF("CrSigCdPam")
1289:                 SELECT CrSigCdPam
1290:                 THIS.this_oBusinessObject.this_cOuros = ALLTRIM(NVL(CrSigCdPam.Ouros, ""))
1291:             ENDIF
1292: 
1293:             THIS.this_oBusinessObject.ProcessarTodasOpi()
1294:             THIS.grd_4c_Dados.Refresh()
1295:         CATCH TO loc_oErro
1296:             MsgErro(loc_oErro.Message, "Erro")
1297:         ENDTRY
1298:     ENDPROC
1299: 
1300:     *==========================================================================
1301:     * GradeColumn7InteractiveChange - CheckBox PM: atualiza Divs no xPesa
1302:     * Equivale a Column7.Check1.InteractiveChange do legado
1303:     * Se condicao nao atendida (nao INSERIR, Obrigs ou Indiv), reverte checkbox
1304:     *==========================================================================
1305:     PROCEDURE GradeColumn7InteractiveChange()
1306:         LOCAL loc_lCondicaoOk, loc_lObrigs, loc_lIndiv, loc_oErro
1307:         TRY
1308:             IF USED("xOpi") AND NOT EOF("xOpi")
1309:                 SELECT xOpi
1310:                 IF VARTYPE(obrigs) = "L"
1311:                     loc_lObrigs = NVL(obrigs, .F.)
1312:                 ELSE
1313:                     IF VARTYPE(obrigs) = "L"
1314:                         loc_lObrigs = obrigs
1315:                     ELSE
1316:                         IF VARTYPE(obrigs) = "L"
1317:                             loc_lObrigs = obrigs
1318:                         ELSE
1319:                             IF VARTYPE(obrigs) = "L"
1320:                                 loc_lObrigs = obrigs
1321:                             ELSE
1322:                                 loc_lObrigs = (NVL(obrigs, 0) = 1)
1323:                             ENDIF
1324:                         ENDIF

*-- Linhas 1349 a 1367:
1349:                     ENDIF
1350:                 ELSE
1351:                     *-- Reverte mudanca (condicoes nao atendidas)
1352:                     SELECT xOpi
1353:                     IF VARTYPE(divs) = "L"
1354:                         REPLACE divs WITH NOT NVL(divs, .F.)
1355:                     ELSE
1356:                         REPLACE divs WITH IIF(NVL(divs, 0) = 1, 0, 1)
1357:                     ENDIF
1358:                 ENDIF
1359:             ENDIF
1360:             THIS.grd_4c_Dados.Refresh()
1361:         CATCH TO loc_oErro
1362:             MsgErro(loc_oErro.Message, "Erro")
1363:         ENDTRY
1364:     ENDPROC
1365: 
1366:     *==========================================================================
1367:     * GradeColumn7HeaderClick - Clique no header "PM": toggle todos xOpi.Divs

*-- Linhas 1379 a 1397:
1379:             loc_lTagAtual = NOT EMPTY(THIS.grd_4c_Dados.Column7.Header1.Tag)
1380: 
1381:             IF USED("xOpi")
1382:                 SELECT xOpi
1383:                 GO TOP
1384:                 REPLACE ALL Divs WITH loc_lTagAtual
1385:                 GO TOP
1386:             ENDIF
1387: 
1388:             THIS.this_oBusinessObject.AtualizarDivsTodas()
1389:             THIS.grd_4c_Dados.Refresh()
1390:         CATCH TO loc_oErro
1391:             MsgErro(loc_oErro.Message, "Erro")
1392:         ENDTRY
1393:     ENDPROC
1394: 
1395:     *==========================================================================
1396:     * BtnOkClick - Confirma emissao de etiquetas e retorna ao form pai
1397:     * Equivale a "ok".Click do legado:

*-- Linhas 1405 a 1438:
1405: 
1406:             IF THIS.this_cEscolha = "CONSULTAR"
1407:                 IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
1408:                     SELECT crSigCdOpd
1409:                     IF INLIST(crSigCdOpd.Etiqs, 1, 3)
1410:                         loc_lImprimir = MsgConfirma("Deseja imprimir as etiquetas.")
1411:                     ENDIF
1412:                 ENDIF
1413:             ENDIF
1414: 
1415:             IF loc_lImprimir
1416:                 IF USED("TmpNens") AND NOT EOF("TmpNens")
1417:                     SELECT TmpNens
1418:                     GO TOP
1419:                     loc_cPosicao = TmpNens.Emps + TmpNens.Dopps + STR(TmpNens.Numps, 10)
1420:                     LOCAL loc_lSeekOk
1421:                     loc_lSeekOk = SEEK(TmpNens.Dopps, "crSigCdOpd", "Dopps")
1422:                     IF USED("crSigCdNec")
1423:                         SELECT crSigCdNec
1424:                         LOCATE FOR EmpDNPs = loc_cPosicao
1425:                     ENDIF
1426:                     loc_oFormEtiquetas = CREATEOBJECT("FormSigPdM10", THIS, .T.)
1427:                     IF VARTYPE(loc_oFormEtiquetas) = "O"
1428:                         loc_oFormEtiquetas.Show()
1429:                     ELSE
1430:                         MsgErro("Erro ao criar FormSigPdM10.", "Etiquetas")
1431:                     ENDIF
1432:                 ENDIF
1433:             ENDIF
1434: 
1435:             SET CONFIRM OFF
1436:             IF VARTYPE(THIS.this_oFormPai) = "O"
1437:                 THIS.this_oFormPai.Enabled = .T.
1438:             ENDIF

*-- Linhas 1445 a 1469:
1445: 
1446:     *==========================================================================
1447:     * BtnPesagemClick - Abre FormSigPdMp9 passando este form como pai
1448:     * Equivale a "Pesagem".Click do legado: Select xPesa + Enabled=.F. + DoForm
1449:     *==========================================================================
1450:     PROCEDURE BtnPesagemClick()
1451:         LOCAL loc_oFormPesagem, loc_oErro
1452:         TRY
1453:             IF USED("xPesa")
1454:                 SELECT xPesa
1455:                 GO TOP
1456:             ENDIF
1457:             THIS.Enabled = .F.
1458:             loc_oFormPesagem = CREATEOBJECT("FormSigPdMp9", THIS)
1459:             IF VARTYPE(loc_oFormPesagem) = "O"
1460:                 loc_oFormPesagem.Show()
1461:             ELSE
1462:                 MsgErro("Erro ao criar FormSigPdMp9.", "Pesagem")
1463:                 THIS.Enabled = .T.
1464:             ENDIF
1465:         CATCH TO loc_oErro
1466:             MsgErro(loc_oErro.Message, "Erro")
1467:             THIS.Enabled = .T.
1468:         ENDTRY
1469:     ENDPROC

*-- Linhas 1499 a 1517:
1499:             ENDIF
1500: 
1501:             *-- Marca todos os itens nao-obrigatorios como Indiv = .T.
1502:             SELECT xOpi
1503:             GO TOP
1504:             SCAN
1505:                 IF NOT xOpi.Obrigs
1506:                     REPLACE Indiv WITH .T. IN xOpi
1507:                 ENDIF
1508:             ENDSCAN
1509: 
1510:             *-- Atualiza TAG do header Column5 para refletir estado "marcado"
1511:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1512:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
1513:                     THIS.grd_4c_Dados.Column5.Header1.Tag = "X"
1514:                 ENDIF
1515:                 THIS.grd_4c_Dados.Refresh()
1516:             ENDIF
1517: 

*-- Linhas 1543 a 1574:
1543:             ENDIF
1544: 
1545:             *-- Marca Divs=.T. para todos os itens nao-obrigatorios e nao-individuais
1546:             SELECT xOpi
1547:             GO TOP
1548:             SCAN
1549:                 IF NOT xOpi.Obrigs AND NOT xOpi.Indiv
1550:                     REPLACE Divs WITH .T. IN xOpi
1551:                 ENDIF
1552:             ENDSCAN
1553: 
1554:             *-- Propaga Divs para xPesa (mesma logica de Column7.Header1.Click)
1555:             IF USED("xPesa")
1556:                 SELECT xOpi
1557:                 GO TOP
1558:                 SCAN
1559:                     UPDATE xPesa SET Divs = (xOpi.Divs) WHERE Amarra = xOpi.Amarra
1560:                 ENDSCAN
1561:             ENDIF
1562: 
1563:             *-- Atualiza TAG do header Column7 para refletir estado "marcado"
1564:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1565:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
1566:                     THIS.grd_4c_Dados.Column7.Header1.Tag = "X"
1567:                 ENDIF
1568:                 THIS.grd_4c_Dados.Refresh()
1569:             ENDIF
1570: 
1571:         CATCH TO loc_oErro
1572:             MsgErro(loc_oErro.Message, "Erro")
1573:         ENDTRY
1574:     ENDPROC

*-- Linhas 1626 a 1654:
1626:             ENDIF
1627: 
1628:             *-- Desmarca Indiv e Divs em todos os itens nao-obrigatorios
1629:             SELECT xOpi
1630:             GO TOP
1631:             SCAN
1632:                 IF NOT xOpi.Obrigs
1633:                     REPLACE Indiv WITH .F., Divs WITH .F. IN xOpi
1634:                 ENDIF
1635:             ENDSCAN
1636: 
1637:             *-- Propaga limpeza para xPesa
1638:             IF USED("xPesa")
1639:                 SELECT xPesa
1640:                 GO TOP
1641:                 SCAN
1642:                     REPLACE Divs WITH .F. IN xPesa
1643:                 ENDSCAN
1644:             ENDIF
1645: 
1646:             *-- Limpa TAGs dos headers
1647:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1648:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column5, "Header1", 5)
1649:                     THIS.grd_4c_Dados.Column5.Header1.Tag = ""
1650:                 ENDIF
1651:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column7, "Header1", 5)
1652:                     THIS.grd_4c_Dados.Column7.Header1.Tag = ""
1653:                 ENDIF
1654:                 THIS.grd_4c_Dados.Refresh()

*-- Linhas 1663 a 1695:
1663:     * ReprocessarPesagemPorAmarra - Reprocessa cursor xPesa baseado nas
1664:     * marcacoes Indiv/Divs de xOpi. Helper compartilhado entre BtnIncluirClick
1665:     * e a logica original de GradeColumn5HeaderClick. Replica trecho do legado
1666:     * que faz CursorQuery em SigCdPro/SigCdGrp/SigCdGpr + DELETE + INSERT em
1667:     * xPesa para cada linha de xOpi.
1668:     *==========================================================================
1669:     PROTECTED PROCEDURE ReprocessarPesagemPorAmarra()
1670:         LOCAL loc_oErro
1671:         TRY
1672:             IF NOT USED("xPesa") OR NOT USED("xOpi")
1673:                 RETURN
1674:             ENDIF
1675: 
1676:             SELECT xOpi
1677:             GO TOP
1678:             SCAN
1679:                 *-- Limpa entradas anteriores da amarra atual
1680:                 DELETE FROM xPesa WHERE Amarra = xOpi.Amarra
1681:             ENDSCAN
1682: 
1683:             *-- Refresh do grid apos reprocessar
1684:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1685:                 THIS.grd_4c_Dados.Refresh()
1686:             ENDIF
1687: 
1688:         CATCH TO loc_oErro
1689:             MsgErro(loc_oErro.Message, "Erro")
1690:         ENDTRY
1691:     ENDPROC
1692: 
1693:     *==========================================================================
1694:     * ConfigurarPaginaDados - Ajuste fino do grid e campos do form operacional
1695:     * Complementa ConfigurarGrade() com propriedades que replicam o legado:

*-- Linhas 1834 a 1872:
1834: 
1835:             *-- Contexto da operacao (TmpNens corrente)
1836:             IF USED("TmpNens") AND NOT EOF("TmpNens")
1837:                 SELECT TmpNens
1838:                 loc_oBO.this_cEmps   = ALLTRIM(NVL(TmpNens.Emps, ""))
1839:                 loc_oBO.this_cDopps  = ALLTRIM(NVL(TmpNens.Dopps, ""))
1840:                 loc_oBO.this_nNumps  = NVL(TmpNens.Numps, 0)
1841:                 IF TYPE("TmpNens.grupoos") <> "U"
1842:                     loc_oBO.this_cGrupoOs = ALLTRIM(NVL(TmpNens.grupoos, ""))
1843:                 ENDIF
1844:                 IF TYPE("TmpNens.contaos") <> "U"
1845:                     loc_oBO.this_cContaOs = ALLTRIM(NVL(TmpNens.contaos, ""))
1846:                 ENDIF
1847:                 IF TYPE("TmpNens.grupods") <> "U"
1848:                     loc_oBO.this_cGrupoDs = ALLTRIM(NVL(TmpNens.grupods, ""))
1849:                 ENDIF
1850:                 IF TYPE("TmpNens.contads") <> "U"
1851:                     loc_oBO.this_cContaDs = ALLTRIM(NVL(TmpNens.contads, ""))
1852:                 ENDIF
1853:             ENDIF
1854: 
1855:             *-- Flags de exibicao (crSigCdOpd)
1856:             IF USED("crSigCdOpd") AND NOT EOF("crSigCdOpd")
1857:                 SELECT crSigCdOpd
1858:                 loc_oBO.this_nOrigems  = NVL(crSigCdOpd.Origems, 0)
1859:                 loc_oBO.this_nDestinos = NVL(crSigCdOpd.Destinos, 0)
1860:                 loc_oBO.this_nImagms   = NVL(crSigCdOpd.Imagems, 0)
1861:                 loc_oBO.this_nEtiqs    = NVL(crSigCdOpd.Etiqs, 0)
1862:                 IF TYPE("crSigCdOpd.Dopes") <> "U"
1863:                     loc_oBO.this_cDopesOpd = ALLTRIM(NVL(crSigCdOpd.Dopes, ""))
1864:                 ENDIF
1865:             ENDIF
1866: 
1867:             *-- Descricoes de conta de origem/destino (campos visiveis)
1868:             IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Grupo", 5)
1869:                 loc_oBO.this_cGrupoOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Grupo.Value)
1870:                 loc_oBO.this_cContaOs  = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Conta.Value)
1871:                 loc_oBO.this_cDcontaOs = ALLTRIM(THIS.cnt_4c_Origem.txt_4c_Dconta.Value)
1872:             ENDIF

*-- Linhas 1982 a 2000:
1982:             ENDIF
1983: 
1984:             loc_oGrid = THIS.grd_4c_Dados
1985:             SELECT xOpi
1986:             GO TOP
1987: 
1988:             *-- Re-bind do RecordSource (apenas se diferente, para preservar estado)
1989:             IF UPPER(ALLTRIM(loc_oGrid.RecordSource)) <> "XOPI"
1990:                 loc_oGrid.RecordSource = "xOpi"
1991:             ENDIF
1992: 
1993:             loc_oGrid.Refresh()
1994: 
1995:             *-- Atualiza descricao/imagem do produto da linha corrente
1996:             IF NOT EOF("xOpi")
1997:                 THIS.GradeAfterRowColChange(1)
1998:             ENDIF
1999: 
2000:             loc_lResultado = .T.


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

