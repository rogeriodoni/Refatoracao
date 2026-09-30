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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEtq.prg) - TRECHOS RELEVANTES PARA PASS SQL (3002 linhas total):

*-- Linhas 551 a 577:
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
561:         SET NULL ON
562:         CREATE CURSOR cursor_4c_Dados ( ;
563:             Cpros      C(14), ;
564:             DPros      C(40), ;
565:             Reffs      C(40), ;
566:             Qtds       N(10,3), ;
567:             QtdeEtiq   N(10,3), ;
568:             Pedido     C(30), ;
569:             Obs        C(10), ;
570:             PVens      N(12,2), ;
571:             PrecoDe    N(12,2), ;
572:             Parcelas   N(2,0), ;
573:             Cpros2     C(14), ;
574:             Cpros3     C(14), ;
575:             Cpros4     C(14), ;
576:             empos      C(3), ;
577:             empdopnums C(29), ;

*-- Linhas 606 a 709:
606:             .HeaderHeight = 17
607:             .RowHeight    = 17
608:             .ScrollBars   = 2
609:             .DeleteMark   = .F.
610:             .RecordMark   = .F.
611:             .Visible      = .T.
612: 
613:             WITH .Column1
614:                 .ControlSource     = "cursor_4c_Dados.Cpros"
615:                 .Width             = 110
616:                 .ColumnOrder       = 1
617:                 .Movable           = .F.
618:                 .Resizable         = .F.
619:                 .FontName          = "Tahoma"
620:                 .FontSize          = 8
621:                 .Header1.Caption   = "Produto"
622:                 .Header1.Alignment = 2
623:                 .Header1.ForeColor = RGB(90, 90, 90)
624:             ENDWITH
625: 
626:             WITH .Column2
627:                 .ControlSource     = "cursor_4c_Dados.DPros"
628:                 .Width             = 270
629:                 .ColumnOrder       = 3
630:                 .Movable           = .F.
631:                 .Resizable         = .F.
632:                 .FontName          = "Tahoma"
633:                 .FontSize          = 8
634:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
635:                 .Header1.Alignment = 2
636:                 .Header1.ForeColor = RGB(90, 90, 90)
637:             ENDWITH
638: 
639:             WITH .Column3
640:                 .ControlSource     = "cursor_4c_Dados.Qtds"
641:                 .Width             = 65
642:                 .ColumnOrder       = 4
643:                 .Movable           = .F.
644:                 .Resizable         = .F.
645:                 .FontName          = "Tahoma"
646:                 .FontSize          = 8
647:                 .Format            = "999,999.99"
648:                 .InputMask         = "999,999.99"
649:                 .Header1.Caption   = "Quantidade"
650:                 .Header1.Alignment = 2
651:                 .Header1.ForeColor = RGB(90, 90, 90)
652:             ENDWITH
653: 
654:             WITH .Column4
655:                 .ControlSource     = "cursor_4c_Dados.DPro2s"
656:                 .Width             = 135
657:                 .ColumnOrder       = 2
658:                 .FontName          = "Tahoma"
659:                 .FontSize          = 8
660:                 .Header1.Caption   = "Refer" + CHR(234) + "ncia Fornecedor"
661:                 .Header1.Alignment = 2
662:                 .Header1.ForeColor = RGB(90, 90, 90)
663:             ENDWITH
664: 
665:             WITH .Column5
666:                 .ControlSource     = "cursor_4c_Dados.Parcelas"
667:                 .Width             = 60
668:                 .ColumnOrder       = 5
669:                 .Movable           = .F.
670:                 .Resizable         = .F.
671:                 .FontName          = "Tahoma"
672:                 .FontSize          = 8
673:                 .Header1.Caption   = "Parcelas"
674:                 .Header1.Alignment = 2
675:                 .Header1.ForeColor = RGB(90, 90, 90)
676:             ENDWITH
677: 
678:             WITH .Column6
679:                 .ControlSource     = "cursor_4c_Dados.PVens"
680:                 .Width             = 70
681:                 .ColumnOrder       = 6
682:                 .Movable           = .F.
683:                 .Resizable         = .F.
684:                 .Enabled           = .F.
685:                 .ReadOnly          = .T.
686:                 .FontName          = "Tahoma"
687:                 .FontSize          = 8
688:                 .Header1.Caption   = "Pre" + CHR(231) + "o"
689:                 .Header1.Alignment = 2
690:                 .Header1.ForeColor = RGB(90, 90, 90)
691:             ENDWITH
692: 
693:             WITH .Column7
694:                 .ControlSource     = "cursor_4c_Dados.PrecoDe"
695:                 .Width             = 70
696:                 .ColumnOrder       = 7
697:                 .Movable           = .F.
698:                 .Resizable         = .F.
699:                 .Enabled           = .F.
700:                 .ReadOnly          = .T.
701:                 .FontName          = "Tahoma"
702:                 .FontSize          = 8
703:                 .Header1.Caption   = "Pre" + CHR(231) + "o De"
704:                 .Header1.Alignment = 2
705:                 .Header1.ForeColor = RGB(90, 90, 90)
706:             ENDWITH
707:         ENDWITH
708:     ENDPROC
709: 

*-- Linhas 757 a 850:
757:         *-- Legado: valor puramente numerico pode ser o EAN13 do produto.
758:         loc_nCod = INT(VAL(loc_cProd))
759:         IF loc_nCod > 0 AND THIS.this_oBusinessObject.BuscarProdutoPorEan13(loc_nCod, "cursor_4c_ProdEan13Grid")
760:             SELECT cursor_4c_ProdEan13Grid
761:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
762:         ENDIF
763: 
764:         *-- Busca por codigo de barras interno (ver nota do cabecalho sobre
765:         *-- fVerificarBarras - este bloco SEMPRE roda para CPros char(14)).
766:         loc_nCod = INT(VAL(loc_cProd))
767:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigoBarras(loc_nCod, "cursor_4c_ProdBarrasGrid")
768:             SELECT cursor_4c_ProdBarrasGrid
769:             loc_cProd = ALLTRIM(TratarNulo(CPros, ""))
770:         ELSE
771:             MsgAviso("Produto N" + CHR(227) + "o Cadastrado!!!", "")
772:             RETURN
773:         ENDIF
774: 
775:         *-- Unidade com etiqueta individual bloqueia impressao em lote.
776:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdUnidGrid")
777:             SELECT cursor_4c_ProdUnidGrid
778:             loc_cUnidade = ALLTRIM(TratarNulo(CUnis, ""))
779:             IF !EMPTY(loc_cUnidade) AND THIS.this_oBusinessObject.VerificarUnidadeEtiquetaIndividual(loc_cUnidade)
780:                 MsgAviso("Unidade do Produto (" + loc_cUnidade + ") Utiliza Etiqueta Individual !!!" + CHR(13) + ;
781:                          "Utilize o M" + CHR(243) + "dulo de Reimpress" + CHR(227) + "o de Etiquetas Individuais !!!", "")
782:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
783:                 THIS.grd_4c_Dados.Refresh()
784:                 RETURN
785:             ENDIF
786:         ENDIF
787: 
788:         *-- Lookup (fwbuscaext no legado) - so quando nao ha match unico direto.
789:         IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cProd, "cursor_4c_ProdLookupGrid") AND ;
790:            RECCOUNT("cursor_4c_ProdLookupGrid") = 1
791:             SELECT cursor_4c_ProdLookupGrid
792:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
793:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
794:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
795:         ELSE
796:             IF THIS.AbrirLookupCanonico("SigCdPro", "CPros", "DPros", ;
797:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cProd, ;
798:                     THIS.grd_4c_Dados.Column1.Text1, THIS.grd_4c_Dados.Column2.Text1)
799:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivoGrid")
800:                     SELECT cursor_4c_ProdDescritivoGrid
801:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
802:                 ENDIF
803:             ELSE
804:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
805:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
806:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
807:             ENDIF
808:         ENDIF
809: 
810:         *-- Aplica peso/preco do produto na linha corrente do cursor de grade.
811:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
812:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
813:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPrecoGrid")
814:             SELECT cursor_4c_ProdPrecoGrid
815:             SELECT (loc_cCursor)
816:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PesoMs, 0), ;
817:                     PVens   WITH TratarNulo(cursor_4c_ProdPrecoGrid.PVens, 0), ;
818:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPrecoGrid.PrecoDe, 0)
819:         ENDIF
820: 
821:         *-- Lista de precos aplicada quando chkLista NAO esta marcado.
822:         IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND ;
823:            !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
824:            THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodResolvido, "cursor_4c_PrecoListaGrid")
825:             SELECT cursor_4c_PrecoListaGrid
826:             GO TOP
827:             loc_nValLista   = PVens
828:             loc_nValDeLista = PrecoDe
829:             IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
830:                THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdListaVencGrid")
831:                 SELECT cursor_4c_ProdListaVencGrid
832:                 loc_nValLista   = PVens
833:                 loc_nValDeLista = PrecoDe
834:             ENDIF
835:             SELECT (loc_cCursor)
836:             REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
837:                     PVens   WITH loc_nValLista, ;
838:                     PrecoDe WITH loc_nValDeLista
839:         ENDIF
840: 
841:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
842:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
843:         ENDIF
844: 
845:         THIS.grd_4c_Dados.Refresh()
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * ValidarDescricaoGrid - Coluna Descricao da grade (col_dpros.txt_dpros
850:     * no legado). Transcricao do Valid legado: resolve por match exato de

*-- Linhas 874 a 928:
874: 
875:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescricao(loc_cDesc, "cursor_4c_ProdDescGrid") AND ;
876:            RECCOUNT("cursor_4c_ProdDescGrid") = 1
877:             SELECT cursor_4c_ProdDescGrid
878:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
879:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
880:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
881:         ELSE
882:             IF THIS.AbrirLookupCanonico("SigCdPro", "DPros", "CPros", ;
883:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDesc, ;
884:                     THIS.grd_4c_Dados.Column2.Text1, THIS.grd_4c_Dados.Column1.Text1)
885:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescritivo2Grid")
886:                     SELECT cursor_4c_ProdDescritivo2Grid
887:                     THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
888:                 ENDIF
889:             ELSE
890:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
891:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
892:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
893:             ENDIF
894:         ENDIF
895: 
896:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
897:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
898:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso2Grid")
899:             SELECT cursor_4c_ProdPeso2Grid
900:             SELECT (loc_cCursor)
901:             REPLACE Pesos WITH TratarNulo(cursor_4c_ProdPeso2Grid.PesoMs, 0)
902:         ENDIF
903: 
904:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
905:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
906:         ENDIF
907: 
908:         THIS.grd_4c_Dados.Refresh()
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * ValidarDescritivoGrid - Coluna Referencia Fornecedor da grade
913:     * (col_DPro2s.Text1 no legado, ControlSource -> Reffs no cursor, mas a
914:     * busca do legado eh feita pelo campo Dpro2s do produto). Transcricao do
915:     * Valid legado: resolve por match exato de Dpro2s e, sem match unico,
916:     * por lookup (fwbuscaext -> AbrirLookupCanonico).
917:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
918:     *==========================================================================
919:     PROCEDURE ValidarDescritivoGrid
920:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
921:         LOCAL loc_cCursor, loc_cDescritivo, loc_cCodResolvido
922: 
923:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
924:             RETURN
925:         ENDIF
926: 
927:         loc_cCursor     = THIS.this_oBusinessObject.this_cCursorDados
928:         loc_cDescritivo = ALLTRIM(THIS.grd_4c_Dados.Column4.Text1.Value)

*-- Linhas 936 a 977:
936: 
937:         IF THIS.this_oBusinessObject.BuscarProdutoPorDescritivo(loc_cDescritivo, "cursor_4c_ProdDescrvGrid") AND ;
938:            RECCOUNT("cursor_4c_ProdDescrvGrid") = 1
939:             SELECT cursor_4c_ProdDescrvGrid
940:             THIS.grd_4c_Dados.Column1.Text1.Value = ALLTRIM(CPros)
941:             THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
942:             THIS.grd_4c_Dados.Column4.Text1.Value = ALLTRIM(TratarNulo(Dpro2s, ""))
943:         ELSE
944:             IF THIS.AbrirLookupCanonico("SigCdPro", "Dpro2s", "CPros", ;
945:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", loc_cDescritivo, ;
946:                     THIS.grd_4c_Dados.Column4.Text1, THIS.grd_4c_Dados.Column1.Text1)
947:                 IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), "cursor_4c_ProdDescricao3Grid")
948:                     SELECT cursor_4c_ProdDescricao3Grid
949:                     THIS.grd_4c_Dados.Column2.Text1.Value = ALLTRIM(TratarNulo(DPros, ""))
950:                 ENDIF
951:             ELSE
952:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
953:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
954:                 THIS.grd_4c_Dados.Column4.Text1.Value = ""
955:             ENDIF
956:         ENDIF
957: 
958:         loc_cCodResolvido = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
959:         IF !EMPTY(loc_cCodResolvido) AND USED(loc_cCursor) AND ;
960:            THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodResolvido, "cursor_4c_ProdPeso3Grid")
961:             SELECT cursor_4c_ProdPeso3Grid
962:             SELECT (loc_cCursor)
963:             REPLACE Pesos   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PesoMs, 0), ;
964:                     PVens   WITH TratarNulo(cursor_4c_ProdPeso3Grid.PVens, 0), ;
965:                     PrecoDe WITH TratarNulo(cursor_4c_ProdPeso3Grid.PrecoDe, 0)
966:         ENDIF
967: 
968:         IF !EMPTY(loc_cCodResolvido) AND EMPTY(THIS.grd_4c_Dados.Column3.Text1.Value)
969:             THIS.grd_4c_Dados.Column3.Text1.Value = 1
970:         ENDIF
971: 
972:         THIS.grd_4c_Dados.Refresh()
973:     ENDPROC
974: 
975:     *==========================================================================
976:     * ValidarQtdGrid - Coluna Quantidade da grade (col_qtds.txt_qtds no
977:     * legado). Transcricao do Valid legado: so processa em ENTER (o legado

*-- Linhas 995 a 1031:
995:             RETURN
996:         ENDIF
997: 
998:         SELECT (loc_cCursor)
999:         loc_cProduto = PADR(Cpros, 14)
1000:         loc_nApurado = Qtds
1001: 
1002:         IF EMPTY(loc_cProduto)
1003:             RETURN
1004:         ENDIF
1005: 
1006:         IF !THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cProduto), "cursor_4c_ProdValidaQtdGrid")
1007:             MsgAviso("Produto Inv" + CHR(225) + "lido!!!", "")
1008:             RETURN
1009:         ENDIF
1010: 
1011:         IF loc_nApurado <= 0
1012:             MsgAviso("Valor Apurado Inv" + CHR(225) + "lido!!!", "")
1013:             RETURN
1014:         ENDIF
1015: 
1016:         SELECT (loc_cCursor)
1017:         SET ORDER TO Cpros
1018:         loc_cChave = SPACE(14)
1019:         IF !SEEK(loc_cChave)
1020:             APPEND BLANK
1021:         ENDIF
1022:         SET ORDER TO
1023: 
1024:         THIS.grd_4c_Dados.Refresh()
1025:     ENDPROC
1026: 
1027:     *==========================================================================
1028:     * ConfigurarBotoesGrade - Botoes de acao da grade de etiquetas
1029:     * (btnCarregar/btnexcluir no legado - icones-only, SEM CommandGroup).
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE ConfigurarBotoesGrade()

*-- Linhas 1064 a 1212:
1064:     * CriarCursorImpressorasWindows - Popula o cursor crImpreV (RowSource do
1065:     * Get_Printer/cbo_4c_Get_Printer) com as impressoras Windows instaladas
1066:     * na estacao. Precisa existir ANTES do ComboBox ser criado (regra
1067:     * CLAUDE.md #41 - ControlSource/RowSource de cursor inexistente derruba
1068:     * o Init).
1069:     *==========================================================================
1070:     PROTECTED PROCEDURE CriarCursorImpressorasWindows()
1071:         LOCAL loc_nImp, loc_nTotal, loc_cAliasAut, loc_lTemAutorizadas, loc_oErro
1072:         LOCAL ARRAY loc_aImpressoras[1, 2]
1073: 
1074:         *-- crImpre: impressoras instaladas no Windows (legado: Create Cursor
1075:         *-- crImpre + laPrinters de APrinters()).
1076:         IF USED("crImpre")
1077:             USE IN crImpre
1078:         ENDIF
1079:         CREATE CURSOR crImpre (Impres C(60))
1080: 
1081:         loc_nTotal = APRINTERS(loc_aImpressoras)
1082:         IF loc_nTotal > 0
1083:             FOR loc_nImp = 1 TO loc_nTotal
1084:                 INSERT INTO crImpre (Impres) VALUES (UPPER(loc_aImpressoras[loc_nImp, 1]))
1085:             ENDFOR
1086:         ENDIF
1087: 
1088:         *-- crSigCdmp: impressoras de ETIQUETA (SigCdmp.nTpImpres = 2) que o
1089:         *-- usuario pode usar - por acesso direto (SigSyImp) ou por grupo
1090:         *-- (SigCdAcG). Legado: quando o UNION ALL nao devolve linha nenhuma,
1091:         *-- ele repete a consulta SEM restricao de acesso.
1092:         loc_cAliasAut      = "cursor_4c_ImpAutTmp"
1093:         loc_lTemAutorizadas = .F.
1094: 
1095:         TRY
1096:             IF USED("crSigCdmp")
1097:                 USE IN crSigCdmp
1098:             ENDIF
1099: 
1100:             IF THIS.this_oBusinessObject.BuscarImpressorasAutorizadas(gc_4c_UsuarioLogado, loc_cAliasAut) ;
1101:                AND RECCOUNT(loc_cAliasAut) > 0
1102: 
1103:                 SELECT DISTINCT Impres FROM (loc_cAliasAut) ;
1104:                     ORDER BY Impres INTO CURSOR crSigCdmp READWRITE
1105:                 loc_lTemAutorizadas = .T.
1106:             ELSE
1107:                 IF THIS.this_oBusinessObject.BuscarImpressorasEtiqueta("crSigCdmp") ;
1108:                    AND RECCOUNT("crSigCdmp") > 0
1109:                     loc_lTemAutorizadas = .T.
1110:                 ENDIF
1111:             ENDIF
1112: 
1113:             IF USED(loc_cAliasAut)
1114:                 USE IN (loc_cAliasAut)
1115:             ENDIF
1116: 
1117:         CATCH TO loc_oErro
1118:             THIS.this_cMensagemErro = loc_oErro.Message
1119:             MsgErro(loc_oErro.Message + CHR(13) + ;
1120:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1121:                     "Procedure: " + loc_oErro.Procedure, "Erro ao Listar Impressoras")
1122:         ENDTRY
1123: 
1124:         *-- crImpreV: par "impressora do sistema x impressora do Windows".
1125:         *-- Estrutura FIXA nos dois caminhos (regra do CREATE CURSOR com ordem
1126:         *-- identica em todos os locais): IDupla eh a coluna 1 e portanto o
1127:         *-- texto exibido pelo ComboBox; Impres eh o nome Windows que vai para
1128:         *-- a impressao; ImpresS eh o nome de sistema usado no ajuste fino.
1129:         IF USED("cursor_4c_ImpPar")
1130:             USE IN cursor_4c_ImpPar
1131:         ENDIF
1132:         SET NULL ON
1133:         CREATE CURSOR cursor_4c_ImpPar (IDupla C(66), Impres C(60), ImpresS C(60))
1134:         SET NULL OFF
1135: 
1136:         IF loc_lTemAutorizadas
1137:             *-- Legado: casa as duas listas por conter-um-ao-outro (o nome
1138:             *-- cadastrado costuma ser um prefixo do nome instalado).
1139:             SELECT crSigCdmp
1140:             SCAN
1141:                 SELECT crImpre
1142:                 SCAN
1143:                     IF ALLTRIM(UPPER(crSigCdmp.Impres)) $ ALLTRIM(UPPER(crImpre.Impres)) ;
1144:                        OR ALLTRIM(UPPER(crImpre.Impres)) $ ALLTRIM(UPPER(crSigCdmp.Impres))
1145: 
1146:                         INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1147:                             PADR(ALLTRIM(crSigCdmp.Impres), 15) + " " + ALLTRIM(crImpre.Impres), ;
1148:                             crImpre.Impres, ;
1149:                             crSigCdmp.Impres)
1150:                     ENDIF
1151:                     SELECT crImpre
1152:                 ENDSCAN
1153:                 SELECT crSigCdmp
1154:             ENDSCAN
1155: 
1156:             *-- Legado: com mais de um par casado, a lista ganha uma linha em
1157:             *-- BRANCO que, pela ordenacao por IDupla, fica em PRIMEIRO - a
1158:             *-- tela abre sem impressora escolhida e obriga a escolha
1159:             *-- explicita ("se houver mais de uma impressora na lista,
1160:             *-- posiciona em impressora em branco").
1161:             IF RECCOUNT("cursor_4c_ImpPar") > 1
1162:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ("", "", "")
1163:             ENDIF
1164:         ENDIF
1165: 
1166:         *-- Sem banco (modo de teste/validacao de UI) ou sem nenhum par casado,
1167:         *-- a tela ainda precisa listar as impressoras do Windows - caso
1168:         *-- contrario o ComboBox abre vazio e nao ha como imprimir.
1169:         IF RECCOUNT("cursor_4c_ImpPar") = 0
1170:             SELECT crImpre
1171:             SCAN
1172:                 INSERT INTO cursor_4c_ImpPar (IDupla, Impres, ImpresS) VALUES ( ;
1173:                     ALLTRIM(crImpre.Impres), crImpre.Impres, crImpre.Impres)
1174:             ENDSCAN
1175:         ENDIF
1176: 
1177:         IF USED("crImpreV")
1178:             USE IN crImpreV
1179:         ENDIF
1180:         SELECT IDupla, Impres, ImpresS FROM cursor_4c_ImpPar ;
1181:             ORDER BY IDupla INTO CURSOR crImpreV READWRITE
1182: 
1183:         IF USED("cursor_4c_ImpPar")
1184:             USE IN cursor_4c_ImpPar
1185:         ENDIF
1186:         IF USED("crImpre")
1187:             USE IN crImpre
1188:         ENDIF
1189:         IF USED("crSigCdmp")
1190:             USE IN crSigCdmp
1191:         ENDIF
1192: 
1193:         *-- Legado: lnImp = Reccount('crImpreV') - alimenta o Enabled do botao
1194:         *-- Imprimir (ver HabilitarCampos).
1195:         THIS.this_nTotalImpressoras = RECCOUNT("crImpreV")
1196: 
1197:         SELECT crImpreV
1198:         GO TOP
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * ConfigurarCamposImpressao - Campos restantes do form (Parte 2/2):
1203:     * tipo de etiqueta, ajustes da impressora Zebra/Allegro, impressora
1204:     * alternativa Windows/Sistema e opcoes de impressao (separador, ordem,
1205:     * peso, composicao, preco). Transcricao 1:1 das propriedades visuais do
1206:     * SCX legado - a populacao dinamica de Opt_Tipo a partir de SigCdTpe
1207:     * (BuscarTiposEtiquetaAtivos, ja disponivel no BO) fica para a fase que
1208:     * amarra o fluxo de impressao (BTNREPORT), que tambem nao foi criado
1209:     * ainda nesta fase.
1210:     *==========================================================================
1211:     PROTECTED PROCEDURE ConfigurarCamposImpressao()
1212: 

*-- Linhas 1904 a 1973:
1904: 
1905:         loc_nMaxPadrao = 7
1906:         IF USED(loc_cAliasPam)
1907:             SELECT (loc_cAliasPam)
1908:             GO TOP
1909:             loc_nMaxPadrao = MAX(TratarNulo(nMaxTpEtis, 0), 7)
1910:         ENDIF
1911: 
1912:         loc_cAliasTipos = "cursor_4c_TiposEtiqueta"
1913:         IF !THIS.this_oBusinessObject.BuscarTiposEtiquetaAtivos(loc_cAliasTipos)
1914:             THIS.this_nTotalTipos = 0
1915:             RETURN
1916:         ENDIF
1917: 
1918:         SELECT (loc_cAliasTipos)
1919:         loc_nTotal = RECCOUNT()
1920: 
1921:         *-- Legado: lnTipos alimenta o Enabled do botao Imprimir
1922:         *-- (.Imprime.Enabled = (lnTipos <> 0 And lnImp <> 0)) e o Enabled do
1923:         *-- proprio Opt_Tipo (.Enabled = (lnTipos > 1)) - ver HabilitarCampos.
1924:         THIS.this_nTotalTipos = loc_nTotal
1925: 
1926:         IF loc_nTotal = 0
1927:             USE IN (loc_cAliasTipos)
1928:             RETURN
1929:         ENDIF
1930: 
1931:         WITH THIS.obj_4c_Opt_Tipo
1932:             loc_nTipoPadrao = 1
1933:             .ButtonCount    = MIN(loc_nTotal, loc_nMaxPadrao)
1934:             loc_nHeight     = 15
1935:             loc_nTop        = 10
1936: 
1937:             SELECT (loc_cAliasTipos)
1938:             GO TOP
1939:             FOR loc_nI = 1 TO THIS.obj_4c_Opt_Tipo.ButtonCount
1940:                 IF USED(loc_cAliasPam) AND TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0) = cursor_4c_Pam.TpEtiPads
1941:                     loc_nTipoPadrao = loc_nI
1942:                 ENDIF
1943: 
1944:                 WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
1945:                     .AutoSize  = .F.
1946:                     .Width     = 197
1947:                     .Caption   = " \<" + CHR(96 + loc_nI) + ". " + ALLTRIM(TratarNulo(cursor_4c_TiposEtiqueta.cEtiquetas, ""))
1948:                     .FontSize  = 8
1949:                     .ForeColor = RGB(90, 90, 90)
1950:                     .Tag       = ALLTRIM(STR(TratarNulo(cursor_4c_TiposEtiqueta.nTipos, 0)))
1951:                     .Top       = loc_nTop
1952:                     .BackStyle = 0
1953:                 ENDWITH
1954: 
1955:                 loc_nTop    = loc_nTop + 20
1956:                 loc_nHeight = loc_nHeight + 20
1957: 
1958:                 SELECT (loc_cAliasTipos)
1959:                 SKIP
1960:             ENDFOR
1961: 
1962:             .Enabled = (loc_nTotal > 1)
1963:             .Height  = loc_nHeight
1964:             .Value   = loc_nTipoPadrao
1965:         ENDWITH
1966: 
1967:         THIS.this_oBusinessObject.this_nTipoEtiqueta = THIS.obj_4c_Opt_Tipo.Value
1968: 
1969:         IF USED(loc_cAliasTipos)
1970:             USE IN (loc_cAliasTipos)
1971:         ENDIF
1972:     ENDPROC
1973: 

*-- Linhas 2158 a 2237:
2158:                 *-- "Existem Etiquetas na Grade! Deseja Refazer a Selecao?"
2159:                 *-- MsgConfirma devolve LOGICAL (regra CLAUDE.md #7).
2160:                 loc_lRefazer = .T.
2161:                 SELECT (loc_cCursor)
2162:                 COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2163:                 IF loc_nQtdSelecionadas > 0
2164:                     loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + ;
2165:                                                CHR(231) + CHR(227) + "o?", ;
2166:                                                "Aten" + CHR(231) + CHR(227) + "o!!!")
2167:                 ENDIF
2168: 
2169:                 IF loc_lRefazer
2170:                     SELECT (loc_cCursor)
2171:                     ZAP
2172: 
2173:                     *-- Legado: If (ThisForm.chkLista.Value = 1)
2174:                     loc_lCarregaLista = THIS.this_oBusinessObject.this_lCarregaItensLista
2175:                     IF PEMSTATUS(THIS, "chk_4c_ChkLista", 5)
2176:                         loc_lCarregaLista = (THIS.chk_4c_ChkLista.Value = 1)
2177:                     ENDIF
2178: 
2179:                     IF loc_lCarregaLista AND ;
2180:                        THIS.this_oBusinessObject.BuscarItensListaPreco(loc_cLista, loc_cAliasItens)
2181: 
2182:                         SELECT (loc_cAliasItens)
2183:                         SCAN
2184:                             loc_cCodProd   = TratarNulo(CPros, "")
2185:                             loc_cDescProd  = TratarNulo(DPros, "")
2186:                             loc_cListaItem = TratarNulo(LPrecos, "")
2187:                             loc_nVal       = TratarNulo(PVens, 0)
2188:                             loc_nValDe     = TratarNulo(PrecoDe, 0)
2189: 
2190:                             *-- Vigencia do preco da lista. Data nula = lista sem
2191:                             *-- prazo: cai DENTRO da vigencia e NAO troca o preco
2192:                             *-- (mesmo efeito do legado, que nunca recebia nulo
2193:                             *-- porque lia a tabela local via CursorQuery).
2194:                             loc_dVencIni = TratarNulo(VencIs, DATETIME())
2195:                             loc_dVencFim = TratarNulo(VencFs, DATETIME())
2196: 
2197:                             IF !BETWEEN(DATETIME(), loc_dVencIni, loc_dVencFim) AND ;
2198:                                !EMPTY(loc_cCodProd) AND ;
2199:                                THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodProd), loc_cAliasProd)
2200: 
2201:                                 SELECT (loc_cAliasProd)
2202:                                 GO TOP
2203:                                 loc_nVal   = TratarNulo(PVens, 0)
2204:                                 loc_nValDe = TratarNulo(PrecoDe, 0)
2205:                             ENDIF
2206: 
2207:                             *-- Legado: Insert Into dbImpressao (Cpros, DPros,
2208:                             *-- Qtds, QtdeEtiq, Obs, PVens, empos, PrecoDe).
2209:                             *-- Qtds/QtdeEtiq = 1 (uma etiqueta por item da
2210:                             *-- lista) e Obs = codigo da lista aplicada.
2211:                             SELECT (loc_cCursor)
2212:                             APPEND BLANK
2213:                             REPLACE Cpros    WITH loc_cCodProd, ;
2214:                                     DPros    WITH loc_cDescProd, ;
2215:                                     Qtds     WITH 1, ;
2216:                                     QtdeEtiq WITH 1, ;
2217:                                     Obs      WITH loc_cListaItem, ;
2218:                                     PVens    WITH loc_nVal, ;
2219:                                     empos    WITH go_4c_Sistema.cCodEmpresa, ;
2220:                                     PrecoDe  WITH loc_nValDe
2221: 
2222:                             SELECT (loc_cAliasItens)
2223:                         ENDSCAN
2224:                     ENDIF
2225:                 ENDIF
2226: 
2227:                 *-- Linha em branco obrigatoria + Go Top + Refresh: regra
2228:                 *-- CLAUDE.md #21(a), centralizada em CarregarLista para nao
2229:                 *-- ficar de fora de nenhum caminho que mexe no cursor.
2230:                 THIS.CarregarLista()
2231: 
2232:                 loc_lSucesso = .T.
2233:             ENDIF
2234: 
2235:             IF USED(loc_cAliasItens)
2236:                 USE IN (loc_cAliasItens)
2237:             ENDIF

*-- Linhas 2296 a 2431:
2296: 
2297:         loc_lRefazer = .T.
2298:         IF USED(loc_cCursor)
2299:             SELECT (loc_cCursor)
2300:             COUNT TO loc_nQtdSelecionadas FOR !EMPTY(Cpros)
2301:             IF loc_nQtdSelecionadas > 0
2302:                 loc_lRefazer = MsgConfirma("Existem Etiquetas na Grade! Deseja Refazer a Sele" + CHR(231) + CHR(227) + "o?", "Aten" + CHR(231) + CHR(227) + "o!!!")
2303:             ENDIF
2304:         ENDIF
2305: 
2306:         IF loc_lRefazer
2307:             IF USED(loc_cCursor)
2308:                 SELECT (loc_cCursor)
2309:                 ZAP
2310:             ENDIF
2311: 
2312:             IF THIS.chk_4c_ChkOperacoes.Value = 1 AND USED(loc_cAliasItens)
2313:                 SELECT (loc_cAliasItens)
2314:                 SCAN
2315:                     loc_cCodItem    = TratarNulo(CPros, "")
2316:                     loc_cDescItem   = TratarNulo(DPros, "")
2317:                     loc_nQtdItem    = TratarNulo(Qtds, 0)
2318:                     loc_nCitemItem  = TratarNulo(Citens, 0)
2319: 
2320:                     loc_nVenda      = 0
2321:                     loc_nPrecoDeVal = 0
2322:                     loc_nPeso       = 0
2323: 
2324:                     IF !EMPTY(loc_cCodItem) AND THIS.this_oBusinessObject.BuscarProdutoPorCodigo(ALLTRIM(loc_cCodItem), "cursor_4c_ProdutoCarga")
2325:                         SELECT cursor_4c_ProdutoCarga
2326:                         IF NVL(PVens, 0) > 0
2327:                             loc_nVenda = PVens
2328:                         ENDIF
2329:                         IF NVL(PrecoDe, 0) > 0
2330:                             loc_nPrecoDeVal = PrecoDe
2331:                         ENDIF
2332:                         IF NVL(PesoMs, 0) > 0
2333:                             loc_nPeso = PesoMs
2334:                         ENDIF
2335:                     ENDIF
2336: 
2337:                     SELECT (loc_cCursor)
2338:                     APPEND BLANK
2339:                     REPLACE Cpros      WITH loc_cCodItem, ;
2340:                             DPros      WITH loc_cDescItem, ;
2341:                             Qtds       WITH loc_nQtdItem, ;
2342:                             QtdeEtiq   WITH loc_nQtdItem, ;
2343:                             Obs        WITH loc_cEmpDopNums, ;
2344:                             PVens      WITH loc_nVenda, ;
2345:                             empos      WITH go_4c_Sistema.cCodEmpresa, ;
2346:                             empdopnums WITH loc_cEmpDopNums, ;
2347:                             citens     WITH loc_nCitemItem, ;
2348:                             Pesos      WITH loc_nPeso, ;
2349:                             PrecoDe    WITH loc_nPrecoDeVal
2350: 
2351:                     SELECT (loc_cAliasItens)
2352:                 ENDSCAN
2353:             ENDIF
2354:         ENDIF
2355: 
2356:         IF THIS.chk_4c_ChkLista.Value <> 1 AND !EMPTY(THIS.txt_4c_Lpreco.Value) AND USED(loc_cCursor)
2357:             SELECT (loc_cCursor)
2358:             SCAN
2359:                 loc_cCodScan = ALLTRIM(TratarNulo(Cpros, ""))
2360: 
2361:                 IF !EMPTY(loc_cCodScan) AND ;
2362:                    THIS.this_oBusinessObject.BuscarPrecoItemListaPreco(ALLTRIM(THIS.txt_4c_Lpreco.Value), loc_cCodScan, "cursor_4c_ItemListaCarga")
2363: 
2364:                     SELECT cursor_4c_ItemListaCarga
2365:                     GO TOP
2366:                     loc_nValLista   = PVens
2367:                     loc_nValDeLista = PrecoDe
2368: 
2369:                     IF !BETWEEN(DATETIME(), VencIs, VencFs) AND ;
2370:                        THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCodScan, "cursor_4c_ProdutoListaCarga")
2371:                         SELECT cursor_4c_ProdutoListaCarga
2372:                         loc_nValLista   = PVens
2373:                         loc_nValDeLista = PrecoDe
2374:                     ENDIF
2375: 
2376:                     SELECT (loc_cCursor)
2377:                     REPLACE Obs     WITH ALLTRIM(THIS.txt_4c_Lpreco.Value), ;
2378:                             PVens   WITH loc_nValLista, ;
2379:                             PrecoDe WITH loc_nValDeLista
2380:                 ENDIF
2381:             ENDSCAN
2382:         ENDIF
2383: 
2384:         *-- Linha em branco obrigatoria + Go Top + Refresh (regra CLAUDE.md
2385:         *-- #21a), centralizados em CarregarLista.
2386:         THIS.CarregarLista()
2387:     ENDPROC
2388: 
2389:     *==========================================================================
2390:     * BtnExcluirItemClick - Remove o item corrente da grade de etiquetas.
2391:     * Transcricao literal do btnexcluir.Click do legado.
2392:     * PUBLIC: chamado via BINDEVENT (regra CLAUDE.md #3).
2393:     *==========================================================================
2394:     PROCEDURE BtnExcluirItemClick()
2395:         LOCAL loc_cCursor
2396:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2397: 
2398:         IF USED(loc_cCursor)
2399:             SELECT (loc_cCursor)
2400:             DELETE
2401:             *-- Legado: Locate For .f. tira o ponteiro da linha excluida sem
2402:             *-- depender de SET DELETED.
2403:             LOCATE FOR .F.
2404: 
2405:             *-- Linha em branco obrigatoria + Go Top + Refresh (CLAUDE.md #21a)
2406:             THIS.CarregarLista()
2407:         ENDIF
2408:     ENDPROC
2409: 
2410:     *==========================================================================
2411:     * BtnProcessarImpressaoClick - Botao principal do form (BTNREPORT.Imprime no legado):
2412:     * confirma, remove itens sem quantidade apurada, reordena a grade (por
2413:     * Codigo ou por ordem de digitacao) e dispara a impressao fisica das
2414:     * etiquetas. Transcricao literal do fluxo do legado (regra CLAUDE.md #17)
2415:     * - inclusive o SINAL/ordem das validacoes e o criterio de reordenacao
2416:     * via cursor auxiliar (Scatter/Insert), que o legado usa para fisicamente
2417:     * fixar a sequencia de impressao antes de varrer a grade.
2418:     * PUBLIC: bindado via BINDEVENT (regra CLAUDE.md #3).
2419:     *==========================================================================
2420:     PROCEDURE BtnProcessarImpressaoClick()
2421:         LOCAL loc_cCursor, loc_nImpPreco, loc_lImpSepar, loc_lImpPeso, loc_lCompo, ;
2422:               loc_nTipoSel, loc_nTpEti, loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, ;
2423:               loc_nAjDenss, loc_nAjVelos, loc_cNomeImpressora, loc_cLp1, loc_cLp2, ;
2424:               loc_cBop, loc_cAliasOpe, loc_cAliasOrdenado
2425: 
2426:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2427:         IF !USED(loc_cCursor)
2428:             RETURN
2429:         ENDIF
2430: 
2431:         *-- Recolhe a tela inteira para o BO de uma vez so (equivale ao bloco

*-- Linhas 2468 a 2527:
2468:         *-- Legado: remove da grade os itens sem quantidade apurada e
2469:         *-- reordena fisicamente (Codigo ou ordem de digitacao) ANTES de
2470:         *-- imprimir, refazendo o cursor via cursor auxiliar (crOrdenado).
2471:         SELECT (loc_cCursor)
2472:         DELETE FOR Qtds <= 0
2473: 
2474:         loc_cAliasOrdenado = "cursor_4c_Ordenado"
2475:         IF USED(loc_cAliasOrdenado)
2476:             USE IN (loc_cAliasOrdenado)
2477:         ENDIF
2478:         SELECT * FROM (loc_cCursor) WHERE .F. INTO CURSOR (loc_cAliasOrdenado) READWRITE
2479: 
2480:         SELECT (loc_cCursor)
2481:         IF THIS.this_oBusinessObject.this_nOrdem = 1
2482:             SET ORDER TO Cpros
2483:         ELSE
2484:             SET ORDER TO Registros
2485:         ENDIF
2486: 
2487:         SELECT (loc_cCursor)
2488:         SCAN
2489:             SCATTER MEMVAR MEMO
2490:             INSERT INTO (loc_cAliasOrdenado) FROM MEMVAR
2491:         ENDSCAN
2492: 
2493:         SELECT (loc_cCursor)
2494:         ZAP
2495: 
2496:         SELECT (loc_cAliasOrdenado)
2497:         SCAN
2498:             SCATTER MEMVAR MEMO
2499:             INSERT INTO (loc_cCursor) FROM MEMVAR
2500:         ENDSCAN
2501:         USE IN (loc_cAliasOrdenado)
2502: 
2503:         SELECT (loc_cCursor)
2504:         SET ORDER TO
2505: 
2506:         *-- Legado: lcBop = numero curto da operacao (SigCdOpe.NDopes) +
2507:         *-- numero da movimentacao - referencia de impressao.
2508:         loc_cBop = ""
2509:         IF !EMPTY(THIS.this_oBusinessObject.this_cDopes) AND !EMPTY(THIS.txt_4c_Numes.Value)
2510:             loc_cAliasOpe = "cursor_4c_OperacaoBop"
2511:             IF THIS.this_oBusinessObject.BuscarOperacaoNumero(THIS.this_oBusinessObject.this_cDopes, loc_cAliasOpe)
2512:                 SELECT (loc_cAliasOpe)
2513:                 IF !EMPTY(TratarNulo(NDopes, ""))
2514:                     loc_cBop = PADL(ALLTRIM(TratarNulo(NDopes, "")), 4, "0") + ;
2515:                                PADL(THIS.this_oBusinessObject.this_cNumes, 6, "0")
2516:                 ENDIF
2517:                 USE IN (loc_cAliasOpe)
2518:             ENDIF
2519:         ENDIF
2520: 
2521:         *-- A impressao eh demorada: tranca a superficie de captura para o
2522:         *-- usuario nao alterar a grade no meio do processo. NUNCA THIS.Enabled
2523:         *-- - o form eh modal e sem TitleBar, trancar tudo o deixaria sem saida.
2524:         THIS.HabilitarCampos(.F.)
2525: 
2526:         IF !THIS.this_oBusinessObject.ImprimirEtiquetas(loc_nImpPreco, loc_lImpSepar, loc_nTpEti, ;
2527:                 loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos, ;

*-- Linhas 2580 a 2614:
2580:             ENDIF
2581: 
2582:             IF USED(loc_cAliasPam) AND RECCOUNT(loc_cAliasPam) > 0
2583:                 SELECT (loc_cAliasPam)
2584:                 GO TOP
2585: 
2586:                 *-- Legado: Iif(crSigCdPam.ImpEtis <> 0, crSigCdPam.ImpEtis, 1)
2587:                 loc_nImpEtis = TratarNulo(ImpEtis, 0)
2588:                 loc_oBO.this_nOpcaoImp = IIF(loc_nImpEtis <> 0, loc_nImpEtis, 1)
2589: 
2590:                 loc_oBO.this_nAjVerts = TratarNulo(AjVerts, 0)
2591:                 loc_oBO.this_nAjHorzs = TratarNulo(AjHorzs, 0)
2592:             ENDIF
2593: 
2594:             IF !USED(loc_cAliasPac)
2595:                 loc_oBO.CarregarParametrosImpressao(loc_cAliasPac)
2596:             ENDIF
2597: 
2598:             IF USED(loc_cAliasPac) AND RECCOUNT(loc_cAliasPac) > 0
2599:                 SELECT (loc_cAliasPac)
2600:                 GO TOP
2601: 
2602:                 *-- Legado: Iif(Empty(<col>), <default>, <col>)
2603:                 loc_oBO.this_nAjDenss = IIF(EMPTY(TratarNulo(AjDens, 0)), 20, TratarNulo(AjDens, 0))
2604:                 loc_oBO.this_nAjVelos = IIF(EMPTY(TratarNulo(AjVelos, 0)), 1, TratarNulo(AjVelos, 0))
2605: 
2606:                 *-- opt_separador tem 2 botoes: valor fora da faixa derruba o
2607:                 *-- OptionGroup, entao so aplica o parametro quando ele eh um
2608:                 *-- indice valido (o legado atribui cru porque o SCX dele nasce
2609:                 *-- com a mesma quantidade de botoes).
2610:                 loc_nSep = TratarNulo(EtqSeps, 0)
2611:                 IF BETWEEN(loc_nSep, 1, THIS.obj_4c_Opt_separador.ButtonCount)
2612:                     loc_oBO.this_nSeparador = loc_nSep
2613:                 ENDIF
2614:             ENDIF

*-- Linhas 2779 a 2797:
2779: 
2780:         loc_cNome = ""
2781:         IF USED("crImpreV") AND RECCOUNT("crImpreV") > 0
2782:             SELECT crImpreV
2783:             IF BETWEEN(THIS.cbo_4c_Get_Printer.ListIndex, 1, RECCOUNT("crImpreV"))
2784:                 GO (THIS.cbo_4c_Get_Printer.ListIndex)
2785:             ENDIF
2786:             loc_cNome = ALLTRIM(TratarNulo(crImpreV.Impres, ""))
2787:         ENDIF
2788: 
2789:         RETURN loc_cNome
2790:     ENDFUNC
2791: 
2792:     *==========================================================================
2793:     * AplicarAcessosUsuario - Le as permissoes do usuario logado para os
2794:     * ajustes finos da impressora e para o tipo de etiqueta. Transcricao das
2795:     * seis chamadas fChecaAcesso do Init legado:
2796:     *   .spn_AjVerts.Enabled = fChecaAcesso([SigPrEtq], [VERTICAL])   (e irmas)
2797:     *   .opt_Tipo.Enabled    = fChecaAcesso([SigPrEtq], [TIPO])

*-- Linhas 2895 a 2913:
2895: 
2896:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2897:         IF USED(loc_cCursor)
2898:             SELECT (loc_cCursor)
2899:             ZAP
2900:         ENDIF
2901: 
2902:         THIS.CarregarLista()
2903:     ENDPROC
2904: 
2905:     *==========================================================================
2906:     * CarregarLista - Fecha CADA caminho que popula a grade de etiquetas:
2907:     * garante a linha em branco que o legado sempre mantem em dbImpressao,
2908:     * reposiciona no topo e repinta o Grid.
2909:     * Popular o cursor NAO repinta a grade sozinho (regra CLAUDE.md #21a): o
2910:     * legado encerra cada carga com "Go Top In dbImpressao" + "Grade.Refresh",
2911:     * e esse par vive aqui para nao ser esquecido em nenhum dos quatro
2912:     * caminhos que mexem no cursor (carga por lista de precos, carga por
2913:     * movimentacao, exclusao de item e reset pos-impressao).

*-- Linhas 2920 a 2943:
2920:         loc_cCursor  = THIS.this_oBusinessObject.this_cCursorDados
2921: 
2922:         IF USED(loc_cCursor)
2923:             SELECT (loc_cCursor)
2924: 
2925:             *-- Legado: "Go Top In dbImpressao / If Eof() / Append Blank".
2926:             *-- O teste eh EOF() DEPOIS do GO TOP, nao RECCOUNT(): RECCOUNT
2927:             *-- conta tambem os registros marcados para exclusao, entao logo
2928:             *-- apos um DELETE a grade pode ficar sem NENHUMA linha visivel
2929:             *-- com RECCOUNT ainda positivo - e sem linha o Grid nao aceita
2930:             *-- digitacao no campo Produto.
2931:             GO TOP
2932:             IF EOF()
2933:                 APPEND BLANK
2934:                 GO TOP
2935:             ENDIF
2936: 
2937:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2938:                 THIS.grd_4c_Dados.Refresh()
2939:             ENDIF
2940: 
2941:             loc_lSucesso = .T.
2942:         ENDIF
2943: 


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

