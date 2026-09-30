# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EAN13' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBARS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPRO2S' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDOPNUMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDEETIQ' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPRESSORAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NSITUAS, USUACESS, USUARIOS, NTPIMPRES, LNIMP, ETIQDUPS, LPRECOS, 0, QTDS, CIMPS, GRUPOS, CPROS

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
  Column1.ControlSource = "dbimpressao.cpros"
  Column2.ControlSource = "dbimpressao.dpros"
  Column3.ControlSource = "dbimpressao.qtds"
  Column4.ControlSource = "dbimpressao.Dpro2s"
  Column5.ControlSource = "dbimpressao.parcelas"
  Column6.ControlSource = "dbimpressao.PVens"
  Column7.ControlSource = "dbimpressao.PrecoDe"
  ControlSource = "dbimpressao.cpros"
  ControlSource = "dbimpressao.dpros"
  ControlSource = "dbimpressao.qtds"
  ControlSource = "dbimpressao.reffs"
  ControlSource = ""
				Insert Into crImpre	(impres) Values(Upper(laPrinters(lnI, 1)))
		Select crSigCdTpe
		Select crSigCdTpe
		lcSql = [Select b.Impres ] + ;
				  [From SigSyImp a, SigCdmp b ] + ;
				[Select c.Impres ] + ;
				  [From SigCdAcG a, SigSyImp b, SigCdmp c ] + ;
		If ThisForm.podatamgr.sqlexecute(lcSql,'crTmpCimp') <= 0
		Select crTmpCImp
			Select Distinct Impres ;
			  From crTmpCImp ;
			lcQuery = [Select Distinct Impres ] + ;
					    [From SigCdmp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdmp]) < 1)
		Select crSigCdmp
		SELECT PADR(ALLTRIM(a.Impres),15)+' '+ALLTRIM(b.impres) as IDupla, b.impres, a.impres as impresS from crSigCdmp a, crImpre b where ALLTRIM(UPPER(a.impres)) like '%'+ALLTRIM(UPPER(b.impres))+'%' ;
		SELECT * FROM crImp order by 1 into cursor crImpreV
		SELECT crImpreV
	Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
			Select LocalLPreI
				Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe) ;
	Select dbImpressao
	Select crSigCdUni
	lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
			    [From SigCdLpi ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
	Select LocalLPreI
Select dbImpressao
If Not Seek(cChave)
Select CPros From dbImpressao Where Not Empty(Cpros) Into Cursor TmpDig
		Select LocalEestI
			Insert Into dbImpressao (Cpros, DPros, Qtds, QtdeEtiq, Obs, PVens, empos, empdopnums, citens, Pesos, PrecoDe) ;
	Select dbImpressao
		lcQuery = [Select LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs ] + ;
				    [From SigCdLpi ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalLPreI') < 1)
		Select LocalLPreI
Select dbImpressao
Select dbImpressao
Delete
Select dbImpressao
Select * From DbImpressao Where 0=1 Into Cursor crOrdenado ReadWrite
Select dbImpressao
Delete From dbImpressao Where Qtds <= 0 
Select DbImpressao
	Insert Into crOrdenado From Memvar
Select crOrdenado
	Insert Into DbImpressao From Memvar
Select dbImpressao

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (2998 linhas total):

*-- Linhas 551 a 576:
551:     * em metodo proprio (nao dentro do Load/Init) porque o novo sistema nao
552:     * separa Load de Init - a estrutura do cursor precisa existir ANTES do
553:     * ConfigurarGridEtiquetas() fazer o bind do Grid (regra CLAUDE.md #41:
554:     * Column.ControlSource de cursor que ainda nao existe derruba o Init).
555:     *==========================================================================
556:     PROTECTED PROCEDURE CriarCursorDados()
557:         IF USED("cursor_4c_Dados")
558:             USE IN cursor_4c_Dados
559:         ENDIF
560: 
561:         CREATE CURSOR cursor_4c_Dados ( ;
562:             Cpros      C(14), ;
563:             DPros      C(40), ;
564:             Reffs      C(40), ;
565:             Qtds       N(10,3), ;
566:             QtdeEtiq   N(10,3), ;
567:             Pedido     C(30), ;
568:             Obs        C(10), ;
569:             PVens      N(12,2), ;
570:             PrecoDe    N(12,2), ;
571:             Parcelas   N(2,0), ;
572:             Cpros2     C(14), ;
573:             Cpros3     C(14), ;
574:             Cpros4     C(14), ;
575:             empos      C(3), ;
576:             empdopnums C(29), ;

*-- Linhas 604 a 707:
604:             .HeaderHeight = 17
605:             .RowHeight    = 17
606:             .ScrollBars   = 2
607:             .DeleteMark   = .F.
608:             .RecordMark   = .F.
609:             .Visible      = .T.
610: 
611:             WITH .Column1
612:                 .ControlSource     = "cursor_4c_Dados.Cpros"
613:                 .Width             = 110
614:                 .ColumnOrder       = 1
615:                 .Movable           = .F.
616:                 .Resizable         = .F.
617:                 .FontName          = "Tahoma"
618:                 .FontSize          = 8
619:                 .Header1.Caption   = "Produto"
620:                 .Header1.Alignment = 2
621:                 .Header1.ForeColor = RGB(90, 90, 90)
622:             ENDWITH
623: 
624:             WITH .Column2
625:                 .ControlSource     = "cursor_4c_Dados.DPros"
626:                 .Width             = 270
627:                 .ColumnOrder       = 3
628:                 .Movable           = .F.
629:                 .Resizable         = .F.
630:                 .FontName          = "Tahoma"
631:                 .FontSize          = 8
632:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
633:                 .Header1.Alignment = 2
634:                 .Header1.ForeColor = RGB(90, 90, 90)
635:             ENDWITH
636: 
637:             WITH .Column3
638:                 .ControlSource     = "cursor_4c_Dados.Qtds"
639:                 .Width             = 65
640:                 .ColumnOrder       = 4
641:                 .Movable           = .F.
642:                 .Resizable         = .F.
643:                 .FontName          = "Tahoma"
644:                 .FontSize          = 8
645:                 .Format            = "999,999.99"
646:                 .InputMask         = "999,999.99"
647:                 .Header1.Caption   = "Quantidade"
648:                 .Header1.Alignment = 2
649:                 .Header1.ForeColor = RGB(90, 90, 90)
650:             ENDWITH
651: 
652:             WITH .Column4
653:                 .ControlSource     = "cursor_4c_Dados.DPro2s"
654:                 .Width             = 135
655:                 .ColumnOrder       = 2
656:                 .FontName          = "Tahoma"
657:                 .FontSize          = 8
658:                 .Header1.Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
659:                 .Header1.Alignment = 2
660:                 .Header1.ForeColor = RGB(90, 90, 90)
661:             ENDWITH
662: 
663:             WITH .Column5
664:                 .ControlSource     = "cursor_4c_Dados.Parcelas"
665:                 .Width             = 60
666:                 .ColumnOrder       = 5
667:                 .Movable           = .F.
668:                 .Resizable         = .F.
669:                 .FontName          = "Tahoma"
670:                 .FontSize          = 8
671:                 .Header1.Caption   = "Parcelas"
672:                 .Header1.Alignment = 2
673:                 .Header1.ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675: 
676:             WITH .Column6
677:                 .ControlSource     = "cursor_4c_Dados.PVens"
678:                 .Width             = 70
679:                 .ColumnOrder       = 6
680:                 .Movable           = .F.
681:                 .Resizable         = .F.
682:                 .Enabled           = .F.
683:                 .ReadOnly          = .T.
684:                 .FontName          = "Tahoma"
685:                 .FontSize          = 8
686:                 .Header1.Caption   = "Pre" + CHR(231) + "o"
687:                 .Header1.Alignment = 2
688:                 .Header1.ForeColor = RGB(90, 90, 90)
689:             ENDWITH
690: 
691:             WITH .Column7
692:                 .ControlSource     = "cursor_4c_Dados.PrecoDe"
693:                 .Width             = 70
694:                 .ColumnOrder       = 7
695:                 .Movable           = .F.
696:                 .Resizable         = .F.
697:                 .Enabled           = .F.
698:                 .ReadOnly          = .T.
699:                 .FontName          = "Tahoma"
700:                 .FontSize          = 8
701:                 .Header1.Caption   = "Pre" + CHR(231) + "o De"
702:                 .Header1.Alignment = 2
703:                 .Header1.ForeColor = RGB(90, 90, 90)
704:             ENDWITH
705:         ENDWITH
706:     ENDPROC
707: 

*-- Linhas 755 a 848:
755:         *-- Legado: valor puramente numerico pode ser o EAN13 do produto.
756:         loc_nCod = INT(VAL(loc_cProd))
757:         IF loc_nCod > 0 AND THIS.this_oBusinessObject.BuscarProdutoPorEan13(loc_nCod, "cursor_4c_ProdEan13Grid")
758:             SELECT cursor_4c_ProdEan13Grid
759:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
760:         ENDIF
761: 
762:         *-- Busca por codigo de barras interno (ver nota do cabecalho sobre
763:         *-- fVerificarBarras - este bloco SEMPRE roda para CPros char(14)).
764:         loc_nCod = INT(VAL(loc_cProd))
765:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigoBarras(loc_nCod, "cursor_4c_ProdBarrasGrid")
766:             SELECT cursor_4c_ProdBarrasGrid
767:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
768:         ELSE
769:             MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!!", "")
770:             RETURN
771:         ENDIF
772: 
773:         *-- Unidade com etiqueta individual bloqueia impressao em lote.
774:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdUnidGrid")
775:             SELECT cursor_4c_ProdUnidGrid
776:             loc_cUnidade = ALLTRIM(TratarNulo(CUnis, ""))
777:             IF !EMPTY(loc_cUnidade) AND THIS.this_oBusinessObject.VerificarUnidadeEtiquetaIndividual(loc_cUnidade)
778:                 MsgAviso("Unidade do Produto (" + loc_cUnidade + ") Utiliza Etiqueta Individual !!!" + CHR(13) + ;
779:                          "Utilize o M" + CHR(243) + "dulo de Reimpress" + CHR(227) + "o de Etiquetas Individuais !!!", "")
780:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
781:                 THIS.grd_4c_Dados.Refresh()
782:                 RETURN
783:             ENDIF
784:         ENDIF
785: 
786:         *-- Lookup (fwbuscaext no legado) - so quando nao ha match unico direto.
787:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdLookupGrid") AND ;
788:            RECCOUNT("cursor_4c_ProdLookupGrid") = 1
789:             SELECT cursor_4c_ProdLookupGrid
790:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
791:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
792:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
793:         ELSE
794:             IF THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
795:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cProd, ;
796:                     THIS.grd_4c_Dados.Column1.Text1, THIS.grd_4c_Dados.Column2.Text1)
797:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivoGrid")
798:                     SELECT cursor_4c_ProdDescritivoGrid
799:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
800:                 ENDIF
801:             ELSE
802:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
803:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
804:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
805:             ENDIF
806:         ENDIF
807: 
808:         *-- Aplica peso/preco do produto na linha corrente do cursor de grade.
809:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
810:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
811:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPrecoGrid")
812:             SELECT cursor_4c_ProdPrecoGrid
813:             SELECT (loc_cCursor)
814:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PesoMs, 0), ;
815:                     PVens   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PVens, 0), ;
816:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPrecoGrid.PrecoDe, 0)
817:         ENDIF
818: 
819:         *-- Lista de precos aplicada quando chkLista NAO esta marcado.
820:         IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND ;
821:            !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
822:            THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodResolvido, "cursor_4c_PrecoListaGrid")
823:             SELECT cursor_4c_PrecoListaGrid
824:             GO TOP
825:             loc_nValLista   = PVens
826:             loc_nValDeLista = PrecoDe
827:             IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
828:                THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdListaVencGrid")
829:                 SELECT cursor_4c_ProdListaVencGrid
830:                 loc_nValLista   = PVens
831:                 loc_nValDeLista = PrecoDe
832:             ENDIF
833:             SELECT (loc_cCursor)
834:             REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
835:                     PVens   WITH loc_nValLista, ;
836:                     PrecoDe WITH loc_nValDeLista
837:         ENDIF
838: 
839:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
840:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
841:         ENDIF
842: 
843:         THIS.grd_4c_Dados.Refresh()
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * ValidarDescricaoGrid - Coluna Descricao da grade (col_dpros.txt_dpros
848:     * no legado). Transcricao do Valid legado: resolve por match exato de

*-- Linhas 872 a 926:
872: 
873:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescricao(loc_cDesc, "cursor_4c_ProdDescGrid") AND ;
874:            RECCOUNT("cursor_4c_ProdDescGrid") = 1
875:             SELECT cursor_4c_ProdDescGrid
876:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
877:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
878:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
879:         ELSE
880:             IF THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", ;
881:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDesc, ;
882:                     THIS.grd_4c_Dados.Column2.Text1, THIS.grd_4c_Dados.Column1.Text1)
883:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivo2Grid")
884:                     SELECT cursor_4c_ProdDescritivo2Grid
885:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
886:                 ENDIF
887:             ELSE
888:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
889:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
890:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
891:             ENDIF
892:         ENDIF
893: 
894:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
895:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
896:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso2Grid")
897:             SELECT cursor_4c_ProdPeso2Grid
898:             SELECT (loc_cCursor)
899:             REPLACE Pesos WITH TratarNulo(cursor_4c_ProdPeso2Grid.PesoMs, 0)
900:         ENDIF
901: 
902:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
903:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
904:         ENDIF
905: 
906:         THIS.grd_4c_Dados.Refresh()
907:     ENDPROC
908: 
909:     *==========================================================================
910:     * ValidarDescritivoGrid - Coluna Referencia Fornecedor da grade
911:     * (col_DPro2s.Text1 no legado, ControlSource -> Reffs no cursor, mas a
912:     * busca do legado eh feita pelo campo Dpro2s do produto). Transcricao do
913:     * Valid legado: resolve por match exato de Dpro2s e, sem match unico,
914:     * por lookup (fwbuscaext -> AbrirLookupCanonico).
915:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
916:     *==========================================================================
917:     PROCEDURE ValidarDescritivoGrid
918:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
919:         LOCAL loc_cCursor, loc_cDescritivo, loc_cCodResolvido
920: 
921:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
922:             RETURN
923:         ENDIF
924: 
925:         loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
926:         loc_cDescritivo = ALLTRIM(THIS.grd_4c_Dados.Column4.Text1.Value)

*-- Linhas 934 a 975:
934: 
935:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescritivo(loc_cDescritivo, "cursor_4c_ProdDescrvGrid") AND ;
936:            RECCOUNT("cursor_4c_ProdDescrvGrid") = 1
937:             SELECT cursor_4c_ProdDescrvGrid
938:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
939:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
940:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
941:         ELSE
942:             IF THIS.AbrirLookupCanonico("SigCdPro", "Dpro2s", "CPros", ;
943:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDescritivo, ;
944:                     THIS.grd_4c_Dados.Column4.Text1, THIS.grd_4c_Dados.Column1.Text1)
945:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescricao3Grid")
946:                     SELECT cursor_4c_ProdDescricao3Grid
947:                     THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
948:                 ENDIF
949:             ELSE
950:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
951:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
952:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
953:             ENDIF
954:         ENDIF
955: 
956:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
957:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
958:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso3Grid")
959:             SELECT cursor_4c_ProdPeso3Grid
960:             SELECT (loc_cCursor)
961:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PesoMs, 0), ;
962:                     PVens   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PVens, 0), ;
963:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPeso3Grid.PrecoDe, 0)
964:         ENDIF
965: 
966:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
967:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
968:         ENDIF
969: 
970:         THIS.grd_4c_Dados.Refresh()
971:     ENDPROC
972: 
973:     *==========================================================================
974:     * ValidarQtdGrid - Coluna Quantidade da grade (col_qtds.txt_qtds no
975:     * legado). Transcricao do Valid legado: so processa em ENTER (o legado

*-- Linhas 993 a 1029:
993:             RETURN
994:         ENDIF
995: 
996:         SELECT (loc_cCursor)
997:         loc_cProduto = PADR(Cpros, 14)
998:         loc_nApurado = Qtds
999: 
1000:         IF EMPTY(loc_cProduto)
1001:             RETURN
1002:         ENDIF
1003: 
1004:         IF !THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cProduto), "cursor_4c_ProdValidaQtdGrid")
1005:             MsgAviso("Produto Inv" + CHR(225) + "lido!!!", "")
1006:             RETURN
1007:         ENDIF
1008: 
1009:         IF loc_nApurado <= 0
1010:             MsgAviso("Valor Apurado Inv" + CHR(225) + "lido!!!", "")
1011:             RETURN
1012:         ENDIF
1013: 
1014:         SELECT (loc_cCursor)
1015:         SET ORDER TO Cpros
1016:         loc_cChave = SPACE(14)
1017:         IF !SEEK(loc_cChave)
1018:             APPEND BLANK
1019:         ENDIF
1020:         SET ORDER TO
1021: 
1022:         THIS.grd_4c_Dados.Refresh()
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * ConfigurarBotoesGrade - Botoes de acao da grade de etiquetas
1027:     * (btnCarregar/btnexcluir no legado - icones-only, SEM CommandGroup).
1028:     *==========================================================================
1029:     PROTECTED PROCEDURE ConfigurarBotoesGrade()

*-- Linhas 1062 a 1208:
1062:     * CriarCursorImpressorasWindows - Popula o cursor crImpreV (RowSource do
1063:     * Get_Printer/cbo_4c_Get_Printer) com as impressoras Windows instaladas
1064:     * na estacao. Precisa existir ANTES do ComboBox ser criado (regra
1065:     * CLAUDE.md #41 - ControlSource/RowSource de cursor inexistente derruba
1066:     * o Init).
1067:     *==========================================================================
1068:     PROTECTED PROCEDURE CriarCursorImpressorasWindows()
1069:         LOCAL loc_nImp, loc_nTotal, loc_cAliasAut, loc_lTemAutorizadas, loc_oErro
1070:         LOCAL ARRAY loc_aImpressoras[1, 2]
1071: 
1072:         *-- crImpre: impressoras instaladas no Windows (legado: Create Cursor
1073:         *-- crImpre + laPrinters de APrinters()).
1074:         IF USED("crImpre")
1075:             USE IN crImpre
1076:         ENDIF
1077:         CREATE CURSOR crImpre (Impres C(60))
1078: 
1079:         loc_nTotal = APRINTERS(loc_aImpressoras)
1080:         IF loc_nTotal > 0
1081:             FOR loc_nImp = 1 TO loc_nTotal
1082:                 INSERT INTO crImpre (Impres) VALUES (UPPER(loc_aImpressoras[loc_nImp, 1]))
1083:             ENDFOR
1084:         ENDIF
1085: 
1086:         *-- crSigCdmp: impressoras de ETIQUETA (SigCdmp.nTpImpres = 2) que o
1087:         *-- usuario pode usar - por acesso direto (SigSyImp) ou por grupo
1088:         *-- (SigCdAcG). Legado: quando o UNION ALL nao devolve linha nenhuma,
1089:         *-- ele repete a consulta SEM restricao de acesso.
1090:         loc_cAliasAut      = "cursor_4c_ImpAutTmp"
1091:         loc_lTemAutorizadas = .F.
1092: 
1093:         TRY
1094:             IF USED("crSigCdmp")
1095:                 USE IN crSigCdmp
1096:             ENDIF
1097: 
1098:             IF THIS.this_oBusinessObject.BuscarImpressorasAutorizadas(gc_4c_UsuarioLogado, loc_cAliasAut) ;
1099:                AND RECCOUNT(loc_cAliasAut) > 0
1100: 
1101:                 SELECT DISTINCT Impres FROM (loc_cAliasAut) ;
1102:                     ORDER BY Impres INTO CURSOR crSigCdmp READWRITE
1103:                 loc_lTemAutorizadas = .T.
1104:             ELSE
1105:                 IF THIS.this_oBusinessObject.BuscarImpressorasEtiqueta("crSigCdmp") ;
1106:                    AND RECCOUNT("crSigCdmp") > 0
1107:                     loc_lTemAutorizadas = .T.
1108:                 ENDIF
1109:             ENDIF
1110: 
1111:             IF USED(loc_cAliasAut)
1112:                 USE IN (loc_cAliasAut)
1113:             ENDIF
1114: 
1115:         CATCH TO loc_oErro
1116:             THIS.this_cMensagemErro = loc_oErro.Message
1117:             MsgErro(loc_oErro.Message + CHR(13) + ;
1118:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1119:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Listar Impressoras")
1120:         ENDTRY
1121: 
1122:         *-- crImpreV: par "impressora do sistema x impressora do Windows".
1123:         *-- Estrutura FIXA nos dois caminhos (regra do CREATE CURSOR com ordem
1124:         *-- identica em todos os locais): IDupla eh a coluna 1 e portanto o
1125:         *-- texto exibido pelo ComboBox; Impres eh o nome Windows que vai para
1126:         *-- a impressao; ImpresS eh o nome de sistema usado no ajuste fino.
1127:         IF USED("cursor_4c_ImpPar")
1128:             USE IN cursor_4c_ImpPar
1129:         ENDIF
1130:         CREATE CURSOR cursor_4c_ImpPar (IDupla C(66), Impres C(60), ImpresS C(60))
1131: 
1132:         IF loc_lTemAutorizadas
1133:             *-- Legado: casa as duas listas por conter-um-ao-outro (o nome
1134:             *-- cadastrado costuma ser um prefixo do nome instalado).
1135:             SELECT crSigCdmp
1136:             SCAN
1137:                 SELECT crImpre
1138:                 SCAN
1139:                     IF ALLTRIM(UPPER(crSigCdmp.Impres)) $ ALLTRIM(UPPER(crImpre.Impres)) ;
1140:                        OR ALLTRIM(UPPER(crImpre.Impres)) $ ALLTRIM(UPPER(crSigCdmp.Impres))
1141: 
1142:                         INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1143:                             PADR(ALLTRIM(crSigCdmp.Impres), 15) + " " + ALLTRIM(crImpre.Impres), ;
1144:                             crImpre.Impres, ;
1145:                             crSigCdmp.Impres)
1146:                     ENDIF
1147:                     SELECT crImpre
1148:                 ENDSCAN
1149:                 SELECT crSigCdmp
1150:             ENDSCAN
1151: 
1152:             *-- Legado: com mais de um par casado, a lista ganha uma linha em
1153:             *-- BRANCO que, pela ordenacao por IDupla, fica em PRIMEIRO - a
1154:             *-- tela abre sem impressora escolhida e obriga a escolha
1155:             *-- explicita ("se houver mais de uma impressora na lista,
1156:             *-- posiciona em impressora em branco").
1157:             IF RECCOUNT("cursor_4c_ImpPar") > 1
1158:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ("", "", "")
1159:             ENDIF
1160:         ENDIF
1161: 
1162:         *-- Sem banco (modo de teste/validacao de UI) ou sem nenhum par casado,
1163:         *-- a tela ainda precisa listar as impressoras do Windows - caso
1164:         *-- contrario o ComboBox abre vazio e nao ha como imprimir.
1165:         IF RECCOUNT("cursor_4c_ImpPar") = 0
1166:             SELECT crImpre
1167:             SCAN
1168:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1169:                     ALLTRIM(crImpre.Impres), crImpre.Impres, crImpre.Impres)
1170:             ENDSCAN
1171:         ENDIF
1172: 
1173:         IF USED("crImpreV")
1174:             USE IN crImpreV
1175:         ENDIF
1176:         SELECT IDupla, Impres, ImpresS FROM cursor_4c_ImpPar ;
1177:             ORDER BY IDupla INTO CURSOR crImpreV READWRITE
1178: 
1179:         IF USED("cursor_4c_ImpPar")
1180:             USE IN cursor_4c_ImpPar
1181:         ENDIF
1182:         IF USED("crImpre")
1183:             USE IN crImpre
1184:         ENDIF
1185:         IF USED("crSigCdmp")
1186:             USE IN crSigCdmp
1187:         ENDIF
1188: 
1189:         *-- Legado: lnImp = Reccount('crImpreV') - alimenta o Enabled do botao
1190:         *-- Imprimir (ver HabilitarCampos).
1191:         THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")
1192: 
1193:         SELECT crImpreV
1194:         GO TOP
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * ConfigurarCamposImpressao - Campos restantes do form (Parte 2/2):
1199:     * tipo de etiqueta, ajustes da impressora Zebra/Allegro, impressora
1200:     * alternativa Windows/Sistema e opcoes de impressao (separador, ordem,
1201:     * peso, composicao, preco). Transcricao 1:1 das propriedades visuais do
1202:     * SCX legado - a populacao dinamica de Opt_Tipo a partir de SigCdTpe
1203:     * (BuscarTiposEtiquetaAtivos, ja disponivel no BO) fica para a fase que
1204:     * amarra o fluxo de impressao (BTNREPORT), que tambem nao foi criado
1205:     * ainda nesta fase.
1206:     *==========================================================================
1207:     PROTECTED PROCEDURE ConfigurarCamposImpressao()
1208: 

*-- Linhas 1900 a 1969:
1900: 
1901:         loc_nMaxPadrao = 7
1902:         IF USED(loc_cAliasPam)
1903:             SELECT (loc_cAliasPam)
1904:             GO TOP
1905:             loc_nMaxPadrao = MAX(TratarNulo(nMaxTpEtis, 0), 7)
1906:         ENDIF
1907: 
1908:         loc_cAliasTipos = "cursor_4c_TiposEtiqueta"
1909:         IF !THIS.this_oBusinessObject.BuscarTiposEtiquetaAtivos(loc_cAliasTipos)
1910:             THIS.this_nTotalTipos = 0
1911:             RETURN
1912:         ENDIF
1913: 
1914:         SELECT (loc_cAliasTipos)
1915:         loc_nTotal = RECCOUNT()
1916: 
1917:         *-- Legado: lnTipos alimenta o Enabled do botao Imprimir
1918:         *-- (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)) e o Enabled do
1919:         *-- proprio Opt_Tipo (.Enabled = (lnTipos > 1)) - ver HabilitarCampos.
1920:         THIS.this_nTotalTipos = loc_nTotal
1921: 
1922:         IF loc_nTotal = 0
1923:             USE IN (loc_cAliasTipos)
1924:             RETURN
1925:         ENDIF
1926: 
1927:         WITH THIS.obj_4c_Opt_Tipo
1928:             loc_nTipoPadrao = 1
1929:             .ButtonCount    = MIN(loc_nTotal, loc_nMaxPadrao)
1930:             loc_nHeight     = 15
1931:             loc_nTop        = 10
1932: 
1933:             SELECT (loc_cAliasTipos)
1934:             GO TOP
1935:             FOR loc_nI = 1 TO THIS.obj_4c_Opt_Tipo.ButtonCount
1936:                 IF USED(loc_cAliasPam) AND TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0) = cursor_4c_Pam.TpEtiPads
1937:                     loc_nTipoPadrao = loc_nI
1938:                 ENDIF
1939: 
1940:                 WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
1941:                     .AutoSize  = .F.
1942:                     .Width     = 197
1943:                     .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ALLTRIM(TratarNulo(cursor_4c_TiposEtiqueta.cEtiquetas, ""))
1944:                     .FontSize  = 8
1945:                     .ForeColor = RGB(90, 90, 90)
1946:                     .Tag       = ALLTRIM(STR(TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0)))
1947:                     .Top       = loc_nTop
1948:                     .BackStyle = 0
1949:                 ENDWITH
1950: 
1951:                 loc_nTop    = loc_nTop + 20
1952:                 loc_nHeight = loc_nHeight + 20
1953: 
1954:                 SELECT (loc_cAliasTipos)
1955:                 SKIP
1956:             ENDFOR
1957: 
1958:             .Enabled = (loc_nTotal > 1)
1959:             .Height  = loc_nHeight
1960:             .Value   = loc_nTipoPadrao
1961:         ENDWITH
1962: 
1963:         THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value
1964: 
1965:         IF USED(loc_cAliasTipos)
1966:             USE IN (loc_cAliasTipos)
1967:         ENDIF
1968:     ENDPROC
1969: 

*-- Linhas 2154 a 2233:
2154:                 *-- "Existem Etiquetas na Grade! Deseja Refazer a Selecao?"
2155:                 *-- MsgConfirma devolve LOGICAL (regra CLAUDE.md #7).
2156:                 loc_lRefazer = .T.
2157:                 SELECT (loc_cCursor)
2158:                 COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2159:                 IF loc_nQtdSelecionadas > 0
2160:                     loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + ;
2161:                                                CHR(231) + CHR(227) + "o?", ;
2162:                                                "Aten" + CHR(231) + CHR(227) + "o!!!")
2163:                 ENDIF
2164: 
2165:                 IF loc_lRefazer
2166:                     SELECT (loc_cCursor)
2167:                     ZAP
2168: 
2169:                     *-- Legado: If (ThisForm.chkLista.Value = 1)
2170:                     loc_lCarregaLista = THIS.this_oBusinessObject.this_lCarregaItensLista
2171:                     IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
2172:                         loc_lCarregaLista = (THIS.chk_4c_ChkLista.Value = 1)
2173:                     ENDIF
2174: 
2175:                     IF loc_lCarregaLista AND ;
2176:                        THIS.this_oBusinessObject.BuscarItensListaPreco(loc_cLista, loc_cAliasItens)
2177: 
2178:                         SELECT (loc_cAliasItens)
2179:                         SCAN
2180:                             loc_cCodProd   = TratarNulo(CPros, "")
2181:                             loc_cDescProd  = TratarNulo(DPros, "")
2182:                             loc_cListaItem = TratarNulo(LPrecos, "")
2183:                             loc_nVal       = TratarNulo(PVens, 0)
2184:                             loc_nValDe     = TratarNulo(PrecoDe, 0)
2185: 
2186:                             *-- Vigencia do preco da lista. Data nula = lista sem
2187:                             *-- prazo: cai DENTRO da vigencia e NAO troca o preco
2188:                             *-- (mesmo efeito do legado, que nunca recebia nulo
2189:                             *-- porque lia a tabela local via CursorQuery).
2190:                             loc_dVencIni = TratarNulo(VencIs, DATETIME())
2191:                             loc_dVencFim = TratarNulo(VencFs, DATETIME())
2192: 
2193:                             IF !BETWEEN(DATETIME(), loc_dVencIni, loc_dVencFim) AND ;
2194:                                !EMPTY(loc_cCodProd) AND ;
2195:                                THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodProd), loc_cAliasProd)
2196: 
2197:                                 SELECT (loc_cAliasProd)
2198:                                 GO TOP
2199:                                 loc_nVal   = TratarNulo(PVens, 0)
2200:                                 loc_nValDe = TratarNulo(PrecoDe, 0)
2201:                             ENDIF
2202: 
2203:                             *-- Legado: Insert Into dbImpressao (Cpros, DPros,
2204:                             *-- Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe).
2205:                             *-- Qtds/QtdeEtiq = 1 (uma etiqueta por item da
2206:                             *-- lista) e Obs = codigo da lista aplicada.
2207:                             SELECT (loc_cCursor)
2208:                             APPEND BLANK
2209:                             REPLACE Cpros    WITH loc_cCodProd, ;
2210:                                     DPros    WITH loc_cDescProd, ;
2211:                                     Qtds     WITH 1, ;
2212:                                     QtdeEtiq WITH 1, ;
2213:                                     Obs      WITH loc_cListaItem, ;
2214:                                     PVens    WITH loc_nVal, ;
2215:                                     empos    WITH go_4c_Sistema.cCodEmpresa, ;
2216:                                     PrecoDe  WITH loc_nValDe
2217: 
2218:                             SELECT (loc_cAliasItens)
2219:                         ENDSCAN
2220:                     ENDIF
2221:                 ENDIF
2222: 
2223:                 *-- Linha em branco obrigatoria + Go Top + Refresh: regra
2224:                 *-- CLAUDE.md #21(a), centralizada em CarregarLista para nao
2225:                 *-- ficar de fora de nenhum caminho que mexe no cursor.
2226:                 THIS.CarregarLista()
2227: 
2228:                 loc_lSucesso = .T.
2229:             ENDIF
2230: 
2231:             IF USED(loc_cAliasItens)
2232:                 USE IN (loc_cAliasItens)
2233:             ENDIF

*-- Linhas 2292 a 2427:
2292: 
2293:         loc_lRefazer = .T.
2294:         IF USED(loc_cCursor)
2295:             SELECT (loc_cCursor)
2296:             COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2297:             IF loc_nQtdSelecionadas > 0
2298:                 loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?", "Aten" + CHR(231) + CHR(227) + "o!!!")
2299:             ENDIF
2300:         ENDIF
2301: 
2302:         IF loc_lRefazer
2303:             IF USED(loc_cCursor)
2304:                 SELECT (loc_cCursor)
2305:                 ZAP
2306:             ENDIF
2307: 
2308:             IF THIS.chk_4c_ChkOperacoes.Value = 1 AND USED(loc_cAliasItens)
2309:                 SELECT (loc_cAliasItens)
2310:                 SCAN
2311:                     loc_cCodItem    = TratarNulo(CPros, "")
2312:                     loc_cDescItem   = TratarNulo(DPros, "")
2313:                     loc_nQtdItem    = TratarNulo(Qtds, 0)
2314:                     loc_nCitemItem  = TratarNulo(Citens, 0)
2315: 
2316:                     loc_nVenda      = 0
2317:                     loc_nPrecoDeVal = 0
2318:                     loc_nPeso       = 0
2319: 
2320:                     IF !EMPTY(loc_cCodItem) AND THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodItem), "cursor_4c_ProdutoCarga")
2321:                         SELECT cursor_4c_ProdutoCarga
2322:                         IF NVL(PVens, 0) > 0
2323:                             loc_nVenda = PVens
2324:                         ENDIF
2325:                         IF NVL(PrecoDe, 0) > 0
2326:                             loc_nPrecoDeVal = PrecoDe
2327:                         ENDIF
2328:                         IF NVL(PesoMs, 0) > 0
2329:                             loc_nPeso = PesoMs
2330:                         ENDIF
2331:                     ENDIF
2332: 
2333:                     SELECT (loc_cCursor)
2334:                     APPEND BLANK
2335:                     REPLACE Cpros      WITH loc_cCodItem, ;
2336:                             DPros      WITH loc_cDescItem, ;
2337:                             Qtds       WITH loc_nQtdItem, ;
2338:                             QtdeEtiq   WITH loc_nQtdItem, ;
2339:                             Obs        WITH loc_cEmpDopNums, ;
2340:                             PVens      WITH loc_nVenda, ;
2341:                             empos      WITH go_4c_Sistema.cCodEmpresa, ;
2342:                             empdopnums WITH loc_cEmpDopNums, ;
2343:                             citens     WITH loc_nCitemItem, ;
2344:                             Pesos      WITH loc_nPeso, ;
2345:                             PrecoDe    WITH loc_nPrecoDeVal
2346: 
2347:                     SELECT (loc_cAliasItens)
2348:                 ENDSCAN
2349:             ENDIF
2350:         ENDIF
2351: 
2352:         IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND USED(loc_cCursor)
2353:             SELECT (loc_cCursor)
2354:             SCAN
2355:                 loc_cCodScan = ALLTRIM(TratarNulo(Cpros, ""))
2356: 
2357:                 IF !EMPTY(loc_cCodScan) AND ;
2358:                    THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodScan, "cursor_4c_ItemListaCarga")
2359: 
2360:                     SELECT cursor_4c_ItemListaCarga
2361:                     GO TOP
2362:                     loc_nValLista   = PVens
2363:                     loc_nValDeLista = PrecoDe
2364: 
2365:                     IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
2366:                        THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodScan, "cursor_4c_ProdutoListaCarga")
2367:                         SELECT cursor_4c_ProdutoListaCarga
2368:                         loc_nValLista   = PVens
2369:                         loc_nValDeLista = PrecoDe
2370:                     ENDIF
2371: 
2372:                     SELECT (loc_cCursor)
2373:                     REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
2374:                             PVens   WITH loc_nValLista, ;
2375:                             PrecoDe WITH loc_nValDeLista
2376:                 ENDIF
2377:             ENDSCAN
2378:         ENDIF
2379: 
2380:         *-- Linha em branco obrigatoria + Go Top + Refresh (regra CLAUDE.md
2381:         *-- #21a), centralizados em CarregarLista.
2382:         THIS.CarregarLista()
2383:     ENDPROC
2384: 
2385:     *==========================================================================
2386:     * BtnExcluirItemClick - Remove o item corrente da grade de etiquetas.
2387:     * Transcricao literal do btnexcluir.Click do legado.
2388:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2389:     *==========================================================================
2390:     PROCEDURE BtnExcluirItemClick()
2391:         LOCAL loc_cCursor
2392:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2393: 
2394:         IF USED(loc_cCursor)
2395:             SELECT (loc_cCursor)
2396:             DELETE
2397:             *-- Legado: Locate For .f. tira o ponteiro da linha excluida sem
2398:             *-- depender de SET DELETED.
2399:             LOCATE FOR .F.
2400: 
2401:             *-- Linha em branco obrigatoria + Go Top + Refresh (CLAUDE.md #21a)
2402:             THIS.CarregarLista()
2403:         ENDIF
2404:     ENDPROC
2405: 
2406:     *==========================================================================
2407:     * BtnProcessarImpressaoClick - Botao principal do form (BTNREPORT.Imprime no legado):
2408:     * confirma, remove itens sem quantidade apurada, reordena a grade (por
2409:     * Codigo ou por ordem de digitacao) e dispara a impressao fisica das
2410:     * etiquetas. Transcricao literal do fluxo do legado (regra CLAUDE.md #17)
2411:     * - inclusive o SINAL/ordem das validacoes e o criterio de reordenacao
2412:     * via cursor auxiliar (Scatter/Insert), que o legado usa para fisicamente
2413:     * fixar a sequencia de impressao antes de varrer a grade.
2414:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2415:     *==========================================================================
2416:     PROCEDURE BtnProcessarImpressaoClick()
2417:         LOCAL loc_cCursor, loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
2418:               loc_nTipoSel, loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
2419:               loc_nAjDenss, loc_nAjVelos, loc_cNomeImpressora, loc_cLp1, loc_cLp2, ;
2420:               loc_cBop, loc_cAliasOpe, loc_cAliasOrdenado
2421: 
2422:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2423:         IF !USED(loc_cCursor)
2424:             RETURN
2425:         ENDIF
2426: 
2427:         *-- Recolhe a tela inteira para o BO de uma vez so (equivale ao bloco

*-- Linhas 2464 a 2523:
2464:         *-- Legado: remove da grade os itens sem quantidade apurada e
2465:         *-- reordena fisicamente (Codigo ou ordem de digitacao) ANTES de
2466:         *-- imprimir, refazendo o cursor via cursor auxiliar (crOrdenado).
2467:         SELECT (loc_cCursor)
2468:         DELETE FOR Qtds <= 0
2469: 
2470:         loc_cAliasOrdenado = "cursor_4c_Ordenado"
2471:         IF USED(loc_cAliasOrdenado)
2472:             USE IN (loc_cAliasOrdenado)
2473:         ENDIF
2474:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cAliasOrdenado) READWRITE
2475: 
2476:         SELECT (loc_cCursor)
2477:         IF THIS.this_oBusinessObject.this_nOrdem = 1
2478:             SET ORDER TO Cpros
2479:         ELSE
2480:             SET ORDER TO Registros
2481:         ENDIF
2482: 
2483:         SELECT (loc_cCursor)
2484:         SCAN
2485:             SCATTER MEMVAR MEMO
2486:             INSERT INTO (loc_cAliasOrdenado) FROM MEMVAR
2487:         ENDSCAN
2488: 
2489:         SELECT (loc_cCursor)
2490:         ZAP
2491: 
2492:         SELECT (loc_cAliasOrdenado)
2493:         SCAN
2494:             SCATTER MEMVAR MEMO
2495:             INSERT INTO (loc_cCursor) FROM MEMVAR
2496:         ENDSCAN
2497:         USE IN (loc_cAliasOrdenado)
2498: 
2499:         SELECT (loc_cCursor)
2500:         SET ORDER TO
2501: 
2502:         *-- Legado: lcBop = numero curto da operacao (SigCdOpe.NDopes) +
2503:         *-- numero da movimentacao - referencia de impressao.
2504:         loc_cBop = ""
2505:         IF !EMPTY(THIS.this_oBusinessObject.this_cDopes) AND !EMPTY(THIS.txt_4c_Numes.Value)
2506:             loc_cAliasOpe = "cursor_4c_OperacaoBop"
2507:             IF THIS.this_oBusinessObject.BuscarOperacaoNumero(THIS.this_oBusinessObject.this_cDopes, loc_cAliasOpe)
2508:                 SELECT (loc_cAliasOpe)
2509:                 IF !EMPTY(TratarNulo(NDopes, ""))
2510:                     loc_cBop = PADL(ALLTRIM(TratarNulo(NDopes, "")), 4, "0") + ;
2511:                                PADL(THIS.this_oBusinessObject.this_cNumes, 6, "0")
2512:                 ENDIF
2513:                 USE IN (loc_cAliasOpe)
2514:             ENDIF
2515:         ENDIF
2516: 
2517:         *-- A impressao eh demorada: tranca a superficie de captura para o
2518:         *-- usuario nao alterar a grade no meio do processo. NUNCA THIS.Enabled
2519:         *-- - o form eh modal e sem TitleBar, trancar tudo o deixaria sem saida.
2520:         THIS.HabilitarCampos(.F.)
2521: 
2522:         IF !THIS.this_oBusinessObject.ImprimirEtiquetas(loc_nImpPreco, loc_lImpSepar, loc_nTpEti, ;
2523:                 loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, ;

*-- Linhas 2576 a 2610:
2576:             ENDIF
2577: 
2578:             IF USED(loc_cAliasPam) AND RECCOUNT(loc_cAliasPam) > 0
2579:                 SELECT (loc_cAliasPam)
2580:                 GO TOP
2581: 
2582:                 *-- Legado: Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2583:                 loc_nImpEtis = TratarNulo(ImpEtis, 0)
2584:                 loc_oBO.this_nOpcaoImp = IIF(loc_nImpEtis <> 0, loc_nImpEtis, 1)
2585: 
2586:                 loc_oBO.this_nAjVerts = TratarNulo(AjVerts, 0)
2587:                 loc_oBO.this_nAjHorzs = TratarNulo(AjHorzs, 0)
2588:             ENDIF
2589: 
2590:             IF !USED(loc_cAliasPac)
2591:                 loc_oBO.CarregarParametrosImpressao(loc_cAliasPac)
2592:             ENDIF
2593: 
2594:             IF USED(loc_cAliasPac) AND RECCOUNT(loc_cAliasPac) > 0
2595:                 SELECT (loc_cAliasPac)
2596:                 GO TOP
2597: 
2598:                 *-- Legado: Iif(Empty(<col>), <default>, <col>)
2599:                 loc_oBO.this_nAjDenss = IIF(EMPTY(TratarNulo(AjDens, 0)), 20, TratarNulo(AjDens, 0))
2600:                 loc_oBO.this_nAjVelos = IIF(EMPTY(TratarNulo(AjVelos, 0)), 1, TratarNulo(AjVelos, 0))
2601: 
2602:                 *-- opt_separador tem 2 botoes: valor fora da faixa derruba o
2603:                 *-- OptionGroup, entao so aplica o parametro quando ele eh um
2604:                 *-- indice valido (o legado atribui cru porque o SCX dele nasce
2605:                 *-- com a mesma quantidade de botoes).
2606:                 loc_nSep = TratarNulo(EtqSeps, 0)
2607:                 IF BETWEEN(loc_nSep, 1, THIS.obj_4c_Opt_separador.ButtonCount)
2608:                     loc_oBO.this_nSeparador = loc_nSep
2609:                 ENDIF
2610:             ENDIF

*-- Linhas 2775 a 2793:
2775: 
2776:         loc_cNome = ""
2777:         IF USED("crImpreV") AND RECCOUNT("crImpreV") > 0
2778:             SELECT crImpreV
2779:             IF BETWEEN(THIS.cbo_4c_Get_Printer.ListIndex, 1, RECCOUNT("crImpreV"))
2780:                 GO (THIS.cbo_4c_Get_Printer.ListIndex)
2781:             ENDIF
2782:             loc_cNome = ALLTRIM(TratarNulo(crImpreV.Impres, ""))
2783:         ENDIF
2784: 
2785:         RETURN loc_cNome
2786:     ENDFUNC
2787: 
2788:     *==========================================================================
2789:     * AplicarAcessosUsuario - Le as permissoes do usuario logado para os
2790:     * ajustes finos da impressora e para o tipo de etiqueta. Transcricao das
2791:     * seis chamadas fChecaAcesso do Init legado:
2792:     *   .spn_AjVerts.Enabled = fChecaAcesso([SigPrEtq], [VERTICAL])   (e irmas)
2793:     *   .opt_Tipo.Enabled    = fChecaAcesso([SigPrEtq], [TIPO])

*-- Linhas 2891 a 2909:
2891: 
2892:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2893:         IF USED(loc_cCursor)
2894:             SELECT (loc_cCursor)
2895:             ZAP
2896:         ENDIF
2897: 
2898:         THIS.CarregarLista()
2899:     ENDPROC
2900: 
2901:     *==========================================================================
2902:     * CarregarLista - Fecha CADA caminho que popula a grade de etiquetas:
2903:     * garante a linha em branco que o legado sempre mantem em dbImpressao,
2904:     * reposiciona no topo e repinta o Grid.
2905:     * Popular o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a): o
2906:     * legado encerra cada carga com "Go Top In dbImpressao" + "Grade.Refresh",
2907:     * e esse par vive aqui para nao ser esquecido em nenhum dos quatro
2908:     * caminhos que mexem no cursor (carga por lista de precos, carga por
2909:     * movimentacao, exclusao de item e reset pos-impressao).

*-- Linhas 2916 a 2939:
2916:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados
2917: 
2918:         IF USED(loc_cCursor)
2919:             SELECT (loc_cCursor)
2920: 
2921:             *-- Legado: "Go Top In dbImpressao / If Eof() / Append Blank".
2922:             *-- O teste eh EOF() DEPOIS do GO TOP, nao RECCOUNT(): RECCOUNT
2923:             *-- conta tambem os registros marcados para exclusao, entao logo
2924:             *-- apos um DELETE a grade pode ficar sem NENHUMA linha visivel
2925:             *-- com RECCOUNT ainda positivo - e sem linha o Grid nao aceita
2926:             *-- digitacao no campo Produto.
2927:             GO TOP
2928:             IF EOF()
2929:                 APPEND BLANK
2930:                 GO TOP
2931:             ENDIF
2932: 
2933:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2934:                 THIS.grd_4c_Dados.Refresh()
2935:             ENDIF
2936: 
2937:             loc_lSucesso = .T.
2938:         ENDIF
2939: 


### BO (C:\4c\projeto\app\classes\SigPrEtqBO.prg):
*==============================================================================
* SigPrEtqBO.prg - Business Object para Impressao de Etiquetas Selecionadas
* Herda de: BusinessBase
* Origem legado: SIGPRETQ.SCX (form OPERACIONAL, sem CRUD proprio)
* Tabela de referencia: SigCdPro (produtos que recebem etiqueta)
*==============================================================================
DEFINE CLASS SigPrEtqBO AS BusinessBase

    *-- Identificacao da movimentacao (getEmps / getDopes / getNumes)
    this_cEmps            = ""   && Empresa (SigCdEmp.Cemps, char(3))
    this_cDopes           = ""   && Operacao de movimento (SigCdOpe.Dopes)
    this_cNumes           = ""   && Numero da movimentacao

    *-- Listas de preco (getLPreco / getLPreco2 - lookup SigCdLpc.LPrecos)
    this_cLPreco          = ""   && Lista de preco principal
    this_cLPreco2         = ""   && Lista de preco secundaria

    *-- Flags de carga de itens (chkLista / chkOperacoes)
    this_lCarregaItensLista     = .T.   && Carrega itens da Lista de Precos
    this_lCarregaItensOperacao  = .T.   && Carrega itens da Movimentacao

    *-- Opcoes de impressao de etiqueta (OptionGroups - valor = indice do botao)
    this_nTipoEtiqueta    = 1    && Opt_Tipo (tipo de etiqueta)
    this_nTipoImpressora  = 1    && Opt_Impressora (impressora especial)
    this_nOpcaoImp        = 1    && Cnt_Impressora.Opcao_imp
    this_nSeparador       = 1    && opt_separador
    this_nOrdem           = 1    && OptOrdem
    this_nPeso            = 1    && opt_peso
    this_nComposicao      = 1    && optCompos
    this_nPreco           = 1    && opt_Preco

    *-- Ajustes finos de impressao (Cnt_Impressora.Spn_*)
    this_nAjVerts         = 0    && Ajuste vertical
    this_nAjHorzs         = 0    && Ajuste horizontal
    this_nAjDenss         = 0    && Ajuste de densidade
    this_nAjVelos         = 0    && Ajuste de velocidade

    *-- Impressora do sistema Windows (Get_Printer - combobox)
    this_cImpressora      = ""

    *-- Controle interno / grade de etiquetas (dbImpressao no legado)
    this_cCursorDados     = "cursor_4c_Dados"
    this_lResultadoOk     = .F.
    this_cMensagemErro    = ""

    *-- Espelho da linha corrente do cursor de grade (dbImpressao no legado)
    *-- Preenchido por CarregarDoCursor() - mesma ordem/nomes do CREATE CURSOR
    *-- dbImpressao declarado no Load() do form legado.
    this_cCpros           = ""   && Codigo do produto (SigCdPro.CPros, char(14))
    this_cDPros           = ""   && Descricao do produto
    this_cReffs           = ""   && Referencia do fornecedor
    this_nQtds            = 0    && Quantidade apurada
    this_nQtdeEtiq        = 0    && Quantidade de etiquetas a imprimir
    this_cPedido          = ""   && Pedido/origem do item (Obs de lista de preco)
    this_cObs             = ""   && Observacao (lista de preco aplicada)
    this_nPVens           = 0    && Preco de venda
    this_nPrecoDe         = 0    && Preco "De" (preco cheio antes do desconto)
    this_nParcelas        = 0    && Numero de parcelas
    this_cCpros2          = ""   && Produto complementar 2 (combo/kit)
    this_cCpros3          = ""   && Produto complementar 3
    this_cCpros4          = ""   && Produto complementar 4
    this_cEmpos           = ""   && Empresa de origem do item
    this_cEmpDopNums      = ""   && Chave posicional Emps+Dopes+Numes (char(29))
    this_nCitens          = 0    && Numero do item na movimentacao (SigMvItn.Citens)
    this_nPesos           = 0    && Peso do produto (SigCdPro.PesoMs)
    this_cCodTams         = ""   && Codigo do tamanho (SigCdPro.CodTams)
    this_cDPro2s          = ""   && Descritivo do produto (SigCdPro.Dpro2s)

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    * CarregarDoCursor - Mapeia uma linha do cursor de grade de etiquetas
    * (equivalente ao dbImpressao do legado) para as properties this_*.
    * par_cAliasCursor: alias do cursor posicionado na linha a carregar.
    *============================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCpros          = TratarNulo(Cpros, "")
        THIS.this_cDPros          = TratarNulo(DPros, "")
        THIS.this_cReffs          = TratarNulo(Reffs, "")
        THIS.this_nQtds           = TratarNulo(Qtds, 0)
        THIS.this_nQtdeEtiq       = TratarNulo(QtdeEtiq, 0)
        THIS.this_cPedido         = TratarNulo(Pedido, "")
        THIS.this_cObs            = TratarNulo(Obs, "")
        THIS.this_nPVens          = TratarNulo(PVens, 0)
        THIS.this_nPrecoDe        = TratarNulo(PrecoDe, 0)
        THIS.this_nParcelas       = TratarNulo(Parcelas, 0)
        THIS.this_cCpros2         = TratarNulo(Cpros2, "")
        THIS.this_cCpros3         = TratarNulo(Cpros3, "")
        THIS.this_cCpros4         = TratarNulo(Cpros4, "")
        THIS.this_cEmpos          = TratarNulo(empos, "")
        THIS.this_cEmpDopNums     = TratarNulo(empdopnums, "")
        THIS.this_nCitens         = TratarNulo(citens, 0)
        THIS.this_nPesos          = TratarNulo(Pesos, 0)
        THIS.this_cCodTams        = TratarNulo(CodTams, "")
        THIS.this_cDPro2s         = TratarNulo(DPro2s, "")

        RETURN .T.
    ENDFUNC

    *============================================================================
    * ObterChavePrimaria - Chave da linha corrente da grade (produto)
    *============================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *============================================================================
    * Este BO NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
    *
    * O legado nao grava a selecao de etiquetas via INSERT/UPDATE/DELETE de
    * registro: dbImpressao eh um cursor 100% em memoria, populado a partir de
    * SigMvItn/SigCdLpi (metodos BuscarItensMovimento/BuscarItensListaPreco
    * abaixo) e a "gravacao" da tela eh a rotina de impressao de etiqueta
    * (SigOpEtq no legado) seguida de Commit() da conexao - nao um Salvar()
    * de registro no padrao FormBase/BusinessBase. Como este BO nunca chama
    * THIS.Salvar()/THIS.Excluir(), o comportamento padrao herdado de
    * BusinessBase ja eh o correto.
    *============================================================================

    *============================================================================
    * CarregarParametrosEtiqueta - Carrega SigCdPam (parametros gerais de
    * etiqueta) no cursor de destino. Equivale ao 1o CursorQuery do Init legado.
    *============================================================================
    FUNCTION CarregarParametrosEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pam")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, TpInstalas, " + ;
                   "AjVerts, AjHorzs, TpCBars, GrPadClis, GrPadVens FROM SigCdPam"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * CarregarParametrosImpressao - Carrega SigCdPac (ajuste de impressao/
    * separador de etiqueta) no cursor de destino.
    *============================================================================
    FUNCTION CarregarParametrosImpressao(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Pac")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT AjDens, AjVelos, EtqSeps FROM SigCdPac"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarTiposEtiquetaAtivos - Tipos de etiqueta ativos (SigCdTpe), na
    * mesma ordem usada pelo legado para montar o Opt_Tipo (cOrdems+cEtiquetas).
    *============================================================================
    FUNCTION BuscarTiposEtiquetaAtivos(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_TiposEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT nTipos, cEtiquetas, cOrdems FROM SigCdTpe " + ;
                   "WHERE nSituas = 1 ORDER BY cOrdems, cEtiquetas"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasAutorizadas - Impressoras de etiqueta (nTpImpres = 2)
    * liberadas para o usuario, por acesso direto (SigSyImp) ou por grupo
    * (SigCdAcG). Transcricao literal do UNION ALL do Init legado.
    *============================================================================
    FUNCTION BuscarImpressorasAutorizadas(par_cUsuario, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_cUsuario

        IF VARTYPE(par_cUsuario) != "C" OR EMPTY(par_cUsuario)
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasAutorizadas")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cUsuario = EscaparSQL(ALLTRIM(par_cUsuario))

        loc_cSQL = "SELECT b.Impres FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + loc_cUsuario + " AND a.CImps = b.Impres AND b.nTpImpres = 2 " + ;
                   "UNION ALL " + ;
                   "SELECT c.Impres FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + loc_cUsuario + " AND a.Grupos = b.GrAcess " + ;
                   "AND b.CImps = c.Impres AND c.nTpImpres = 2"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarImpressorasEtiqueta - Todas as impressoras de etiqueta cadastradas
    * (SigCdmp.nTpImpres = 2), sem filtro de usuario. Transcricao do FALLBACK
    * do Init legado: quando o UNION ALL de BuscarImpressorasAutorizadas nao
    * devolve nenhuma linha, o legado repete a consulta sem restricao de
    * acesso ("Select Distinct Impres From SigCdmp Where nTpImpres = 2
    * Order By Impres") em vez de deixar a lista vazia.
    *============================================================================
    FUNCTION BuscarImpressorasEtiqueta(par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ImpressorasEtiqueta")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT DISTINCT Impres FROM SigCdmp " + ;
                   "WHERE nTpImpres = 2 ORDER BY Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorEan13 - Localiza produto pelo codigo de barras EAN13.
    *============================================================================
    FUNCTION BuscarProdutoPorEan13(par_nEan, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nEan) != "N" OR par_nEan <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Ean13 = " + FormatarNumeroSQL(par_nEan, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigoBarras - Localiza produto pelo codigo de barras
    * interno (CBars), usado quando o valor digitado nao eh um EAN13 valido.
    *============================================================================
    FUNCTION BuscarProdutoPorCodigoBarras(par_nCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_nCodigo) != "N" OR par_nCodigo <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CBars = " + FormatarNumeroSQL(par_nCodigo, 0)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorCodigo - Localiza produto pelo codigo (CPros).
    *============================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescricao - Localiza produto pela descricao (DPros).
    *============================================================================
    FUNCTION BuscarProdutoPorDescricao(par_cDescricao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescricao) != "C" OR EMPTY(par_cDescricao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE DPros = " + EscaparSQL(ALLTRIM(par_cDescricao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarProdutoPorDescritivo - Localiza produto pelo descritivo (Dpro2s,
    * usado como "Referencia Fornecedor"/descritivo no grid de etiquetas).
    *============================================================================
    FUNCTION BuscarProdutoPorDescritivo(par_cDescritivo, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cDescritivo) != "C" OR EMPTY(par_cDescritivo)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_Produto")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT CPros, DPros, Dpro2s, CUnis, PesoMs, PVens, PrecoDe, CodTams " + ;
                   "FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(ALLTRIM(par_cDescritivo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * VerificarUnidadeEtiquetaIndividual - .T. quando a unidade do produto
    * usa etiqueta individual e NAO permite duplicidade (Etiqs = 'S' e
    * EtiqDups <> 1) - nesse caso o legado bloqueia a impressao em lote.
    *============================================================================
    FUNCTION VerificarUnidadeEtiquetaIndividual(par_cCodUnidade)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lBloqueia

        loc_lBloqueia = .F.

        IF VARTYPE(par_cCodUnidade) != "C" OR EMPTY(par_cCodUnidade)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_UnidadeEtiqueta"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Etiqs, EtiqDups FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCodUnidade))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0
            SELECT (loc_cAlias)
            loc_lBloqueia = (ALLTRIM(UPPER(TratarNulo(Etiqs, ""))) == "S") AND (TratarNulo(EtiqDups, 0) <> 1)
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lBloqueia
    ENDFUNC

    *============================================================================
    * BuscarItensMovimento - Itens da movimentacao (SigMvItn) para a chave
    * posicional EmpDopNums (Emps char(3) + Dopes char(20) + Numes STR(,6)),
    * usada pelo botao "Carregar" quando chkOperacoes esta marcado.
    *============================================================================
    FUNCTION BuscarItensMovimento(par_cEmpDopNums, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cEmpDopNums) != "C" OR EMPTY(par_cEmpDopNums)
            THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensMovimento")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        *-- Chave POSICIONAL (Emps+Dopes+Numes) - NAO fazer ALLTRIM nas partes
        *-- que compoem par_cEmpDopNums; o padding faz parte da chave.
        loc_cSQL = "SELECT CPros, DPros, Units, Qtds, Citens FROM SigMvItn " + ;
                   "WHERE EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarItensListaPreco - Itens de uma lista de precos (SigCdLpi), usada
    * pelo botao "Carregar"/Valid de Get_lpreco quando chkLista esta marcado.
    *============================================================================
    FUNCTION BuscarItensListaPreco(par_cListaPreco, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            THIS.this_cMensagemErro = "Lista de pre" + CHR(231) + "os n" + CHR(227) + "o informada."
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_ItensListaPreco")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * BuscarPrecoItemListaPreco - Preco de um produto especifico dentro de
    * uma lista de precos (usado nos Valid dos campos da grade).
    *============================================================================
    FUNCTION BuscarPrecoItemListaPreco(par_cListaPreco, par_cCodProduto, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco) ;
           OR VARTYPE(par_cCodProduto) != "C" OR EMPTY(par_cCodProduto)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_PrecoItemLista")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos, CPros, DPros, PVens, PrecoDe, VencIs, VencFs FROM SigCdLpi " + ;
                   "WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30)) + ;
                   " AND CPros = " + EscaparSQL(PADR(ALLTRIM(par_cCodProduto), 14))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarListaPreco - Confere se a lista de precos existe (SigCdLpc),
    * usado no Valid de Get_lpreco/getLPreco2 antes de abrir o picker.
    *============================================================================
    FUNCTION ValidarListaPreco(par_cListaPreco)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cListaPreco) != "C" OR EMPTY(par_cListaPreco)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaListaPreco"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT LPrecos FROM SigCdLpc WHERE LPrecos = " + EscaparSQL(PADR(ALLTRIM(par_cListaPreco), 30))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * BuscarOperacaoNumero - Le o NDopes (numero curto da operacao) de
    * SigCdOpe, usado para montar o "lcBop" (chave de impressao) antes de
    * chamar a rotina de impressao de etiqueta.
    *============================================================================
    FUNCTION BuscarOperacaoNumero(par_cCodOperacao, par_cAliasDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias

        IF VARTYPE(par_cCodOperacao) != "C" OR EMPTY(par_cCodOperacao)
            RETURN .F.
        ENDIF

        loc_cAlias = IIF(VARTYPE(par_cAliasDestino) = "C" AND !EMPTY(par_cAliasDestino), ;
                         par_cAliasDestino, "cursor_4c_OperacaoNumero")

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes, NDopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodOperacao))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
            RETURN .F.
        ENDIF

        RETURN (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)
    ENDFUNC

    *============================================================================
    * ValidarOperacao - Confere se o codigo de operacao existe em SigCdOpe.
    * Substitui a chamada legado a fAcessoMovmto() (funcao global nao portada).
    *============================================================================
    FUNCTION ValidarOperacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaOperacao"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ValidarEmpresa - Confere se o codigo de empresa existe em SigCdEmp.
    * Substitui a chamada legado a fAcessoEmpresa() (funcao global nao
    * portada - ver licao aprendida sobre fAcessoEmpresa).
    *============================================================================
    FUNCTION ValidarEmpresa(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cAlias, loc_lExiste

        loc_lExiste = .F.

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(par_cCodigo)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        loc_cAlias = "cursor_4c_ValidaEmpresa"
        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodigo))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAlias)

        loc_lExiste = (loc_nResultado > 0 AND RECCOUNT(loc_cAlias) > 0)

        IF USED(loc_cAlias)
            USE IN (loc_cAlias)
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *============================================================================
    * ImprimirEtiquetas - Envia para impressao as etiquetas selecionadas na
    * grade (cursor_4c_Dados). O motor de impressao do legado (SigOpEtq, em
    * SIGFUNCS.PRG) gera comandos proprietarios ZPL/EPL/Allegro para
    * impressoras termicas especificas e NAO esta no acervo migrado (mesma
    * familia da licao "funcao global do legado nao portada" - regra
    * CLAUDE.md #27). Como o retorno de SigOpEtq eh descartado pelo legado
    * (=SigOpEtq(...)) e o fluxo segue para "Impressao Concluida!!!"
    * seja qual for o resultado interno dela, este metodo substitui por uma
    * impressao de texto generica e FUNCIONAL (via SET DEVICE TO PRINTER),
    * respeitando quantidade por item (QtdeEtiq), impressora selecionada,
    * exibicao de preco e peso, e separador entre etiquetas - sem reproduzir
    * o layout proprietario exato (codigo de barras/posicionamento termico)
    * que so existe no motor original.
    *============================================================================
    FUNCTION ImprimirEtiquetas(par_nImpPreco, par_lImpSepar, par_nTpEti, par_nTpImp, ;
            par_nAjVerts, par_nAjHorzs, par_nAjDenss, par_nAjVelos, par_cNomeImpressora, ;
            par_lImpPeso, par_cBop, par_cLp1, par_cLp2, par_lCompo)

        LOCAL loc_cCursor, loc_nCopia, loc_nQtdImpressa, loc_lSucesso, loc_oErro

        loc_lSucesso    = .F.
        loc_nQtdImpressa = 0
        loc_cCursor     = THIS.this_cCursorDados

        IF !USED(loc_cCursor)
            THIS.this_cMensagemErro = "Nenhuma etiqueta selecionada para impress" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            IF !EMPTY(par_cNomeImpressora)
                SET PRINTER TO NAME (par_cNomeImpressora)
            ENDIF

            SET DEVICE TO PRINTER
            SET PRINT ON

            SELECT (loc_cCursor)
            SCAN FOR !EMPTY(Cpros) AND QtdeEtiq > 0
                FOR loc_nCopia = 1 TO QtdeEtiq
                    @ PROW() + 1, 0 SAY PADR(ALLTRIM(Cpros), 14) + "  " + ALLTRIM(TratarNulo(DPros, ""))

                    IF INLIST(par_nImpPreco, 1, 3, 4)
                        @ PROW() + 1, 4 SAY "R$ " + TRANSFORM(PVens, "999,999.99")
                    ENDIF

                    IF par_lImpPeso AND TratarNulo(Pesos, 0) > 0
                        @ PROW() + 1, 4 SAY "Peso: " + TRANSFORM(Pesos, "999,999.999") + " Kg"
                    ENDIF

                    IF par_lCompo AND !EMPTY(TratarNulo(DPro2s, ""))
                        @ PROW() + 1, 4 SAY ALLTRIM(DPro2s)
                    ENDIF

                    IF !EMPTY(par_cBop)
                        @ PROW() + 1, 4 SAY "Ref: " + par_cBop
                    ENDIF

                    IF par_lImpSepar
                        @ PROW() + 1, 0 SAY REPLICATE("-", 40)
                    ENDIF

                    loc_nQtdImpressa = loc_nQtdImpressa + 1
                ENDFOR
                SELECT (loc_cCursor)
            ENDSCAN

            SET PRINT OFF
            SET DEVICE TO SCREEN

            IF loc_nQtdImpressa = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta com quantidade apurada para imprimir."
            ELSE
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            SET PRINT OFF
            SET DEVICE TO SCREEN
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

