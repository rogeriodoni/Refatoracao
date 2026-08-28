# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, PROCESSOS, FKCHAVES, FISCAIS, PROGRAMAS, PARAMETROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TPPRODUTOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, PROCESSOS, FKCHAVES, FISCAIS, PROGRAMAS, PARAMETROS

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
  ControlSource = "crSigPcOop.codigos"
  DeleteMark = .F.
  Column1.ControlSource = "csDestinos.EmpDs"
  Column2.ControlSource = "csDestinos.Drives"
  Column3.ControlSource = "csDestinos.DopeDs"
  Column4.ControlSource = "csDestinos.TpProdutos"
  Column5.ControlSource = "csDestinos.Dias"
  Column6.ControlSource = "csDestinos.PctMins"
  Column7.ControlSource = "csDestinos.PctMaxs"
  Column8.ControlSource = "csDestinos.GdeGrupos"
  Column9.ControlSource = "csDestinos.Emps"
  Column10.ControlSource = "csDestinos.Dopes"
  Column11.ControlSource = "csDestinos.CUnis"
  Column12.ControlSource = "csDestinos.Origems"
  Column13.ControlSource = "csDestinos.Destinos"
  Column14.ControlSource = "csDestinos.SemItens"
  Column15.ControlSource = "csDestinos.Fiscais"
  Column16.ControlSource = "csDestinos.PctCopias"
  Column17.ControlSource = "csDestinos.OpItens"
  Column18.ControlSource = "csDestinos.PctComps"
  ControlSource = "crSigPcOop.processos"
  ControlSource = "crSigPcOop.Apagar"
  ControlSource = "crSigPcOop.Fiscal"
  ControlSource = "crSigPcOop.Imprimir"
  ControlSource = "crSigPcOop.notas"
  ControlSource = "crSigPcOop.ordems"
  ControlSource = "crSigPcOop.Logs"
  ControlSource = "crSigPcOop.Toleras"
  DeleteMark = .F.
  Column1.ControlSource = "csDestinoG.Mercs"
  Column2.ControlSource = "csDestinoG.CUnis"
  ControlSource = "csDestinoG.Cgrus"
	.DeleteMark = .F.
	.Column1.ControlSource  = 'csDestinos.EmpDs'
	.Column2.ControlSource  = 'csDestinos.Drives'
	.Column3.ControlSource  = 'csDestinos.DopeDs'
	.Column4.ControlSource  = 'csDestinos.TpProdutos'
	.Column5.ControlSource  = 'csDestinos.Dias'
	.Column6.ControlSource  = 'csDestinos.PctMins'
	.Column7.ControlSource  = 'csDestinos.PctMaxs'
	.Column8.ControlSource  = 'csDestinos.GdeGrupos'
	.Column9.ControlSource  = 'csDestinos.Emps'
    .Column10.ControlSource = 'csDestinos.Dopes'
    .Column11.ControlSource = 'csDestinos.CUnis'
    .Column12.ControlSource = 'csDestinos.Origems'
    .Column13.ControlSource = 'csDestinos.Destinos'
    .Column14.ControlSource = 'csDestinos.SemItens'
    .Column15.ControlSource = 'csDestinos.Fiscais'
    .Column16.ControlSource = 'csDestinos.PctCopias'
    .Column17.ControlSource = 'csDestinos.OpItens'
    .Column18.ControlSource = 'csDestinos.pctcomps'
	.DeleteMark = .F.
	.Column1.ControlSource  = 'csDestinoG.Mercs'
	.Column2.ControlSource  = 'csDestinoG.CUnis'
	.Column3.ControlSource  = 'csDestinoG.Cgrus'
	.optGruConOs.ControlSource   = 'csDestinos.GruconOs'
	.optGruConDs.ControlSource   = 'csDestinos.GruconDs'
	.optEmpDests.ControlSource   = 'csDestinos.EmpDests'
	.optAgrupar.ControlSource    = 'csDestinos.Agrupar'
	.optNovoCodigo.ControlSource = 'csDestinos.NovoCods'
	.optCorTamanho.ControlSource = 'csDestinos.CorTams'
	.optMoeVals.ControlSource  	 = 'csDestinos.MoeVals'
	.optSituas.ControlSource     = 'csDestinos.Situas'
	.optFranquia.ControlSource   = 'csDestinos.Franquias'
	.optCustos.ControlSource     = 'csDestinos.Custos'
	.optImpostos.ControlSource   = 'csDestinos.Impostos'
	.optImagem.ControlSource     = 'csDestinos.Imagem'
	.optMantProds.ControlSource  = 'csDestinos.MantProds'
	.optOriCompos.ControlSource  = 'csDestinos.OriCompos'
	.optBarras.ControlSource     = 'csDestinos.Barras'
	.optGlobaliza.ControlSource  = 'csDestinos.Globalizas'
	.optMccrs.ControlSource      = 'csDestinos.Mccrs'
	.optCheques.ControlSource    = 'csDestinos.Cheques'
	.optRecalculos.ControlSource = 'csDestinos.Recalculos'
	.optDelets.ControlSource     = 'csDestinos.Delets'
	.optDesItens.ControlSource   = 'csDestinos.DesItens'
	.optMontaObs.ControlSource   = 'csDestinos.MontaObs'
	.optChkCons.ControlSource    = 'csDestinos.ChkCons'
	.optMantemMats.ControlSource = 'csDestinos.MantemMats'
	.optMantDPros.ControlSource  = 'csDestinos.MantDPros'
	.optMovMZeros.ControlSource  = 'csDestinos.MovMZeros'
	.optMovcParc.ControlSource   = 'csDestinos.MovcParc'
lcQryCopOp = 'Select * From SigPcOop'
lcQryCopOI = 'Select * From SigPcOoI Where Processos = ?pPro'
lcQryCopOG = 'Select * From SigPcOoG Where Processos = ?pPro And fkChaves = ?pKey'
Select crSigPcOop
If (ThisForm.poDataMgr.SQLExecute([Delete From SigPcOoI Where Processos = ?pPro], '') < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigPcOoG Where Processos = ?pPro], '') < 1)
If Not ThisForm.poDataMgr.Update('crSigPcOoI')
If Not ThisForm.poDataMgr.Update('crSigPcOoG')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigPcOoI Where Processos = ?pPro], '') < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigPcOoG Where Processos = ?pPro], '') < 1)
If Not ThisForm.poDataMgr.Update('crSigPcOoI')
If Not ThisForm.poDataMgr.Update('crSigPcOoG')
Select crSigPcOop
Select crSigPcOop
Select csDestinoG
	Select crSigPcOoI
		Insert Into csDestinos (Processos, Emps, Dopes, Codigos, Drives, EmpDs, DopeDs, TpProdutos, Dias, ;
		Select crSigPcOoG
			Insert Into csDestinoG (Processos, Mercs, CUnis, fkChaves, Cgrus) ;
Select csDestinos
Select csDestinoG
		Insert Into csDestinos (GruConOs, GruConDs, EmpDests, Agrupar, NovoCods, CorTams, MoeVals, Situas, Franquias, ;
		Select Processos ;
		  From csDestinos ;
		Select crBusca
	Select csDestinos
Select crSigPcOop
	Select * ;
	  From csDestinos ;
		Select * ;
		  From csDestinos ;
	Select csDestinoG
		Select csDestinos
				Insert Into crSigPcOoI (Processos, Emps, Dopes, Codigos, Drives, EmpDs, DopeDs, TpProdutos, Dias, ;
				Select csDestinoG
						Insert Into crSigPcOoG (Processos, Mercs, CUnis, fkChaves, cIdChaves, Cgrus) ;
	lcQuery = [Delete From SigCdPrg ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCdPrg)')
	Insert Into crSigCdPrg (Descricaos, Parametros, Programas, pkChaves) Values (lcDes, lcPar, lcPrg, fUniqueIds())
	If Not ThisForm.poDataMgr.Update('crSigCdPrg')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdPrg)')
	Select crSigPcOop
Insert Into csDestinos (Processos, Emps, Dopes, Codigos, Drives, EmpDs, DopeDs, TpProdutos, Dias, GruConOs, ;
	Insert Into csDestinoG (Processos, Mercs, CUnis, fkChaves, Cgrus ) ;
	Select csDestinoG
Select csDestinos
		Select csDestinoG
			Delete
		Delete In CsDestinos
	Select csDestinos
	Insert Into csDestinos From Memvar
	Select csDestinos
	Select csDestinoG
		Insert Into csDestinoG From Memvar
	Select csDestinoG
	Select * From csDestinoG ;
		Insert Into csDestinoG (Processos, Mercs, CUnis, Cgrus, fkChaves) ;
	Insert Into csDestinoG (Processos, Mercs, CUnis, Cgrus, fkChaves) ;
	Select csDestinoG
Select csDestinoG
		Select csDestinoG
		Delete

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formprc.prg) - TRECHOS RELEVANTES PARA PASS SQL (3538 linhas total):

*-- Linhas 62 a 96:
62:                 IF USED("csDestinos")
63:                     USE IN csDestinos
64:                 ENDIF
65:                 CREATE CURSOR csDestinos (Processos c(20), Codigos n(6,0), Drives c(20), Emps c(3), ;
66:                                            Dopes c(20), EmpDs c(3), DopeDs c(20), TpProdutos n(2,0), ;
67:                                            Dias n(3,0), GruconOs n(1,0), GruconDs n(1,0), EmpDests n(1,0), ;
68:                                            Agrupar L, NovoCods L, CorTams L, MoeVals L, ;
69:                                            Situas n(1,0), Franquias n(1,0), PctMins n(12,2), PctMaxs n(12,2), ;
70:                                            Custos n(1,0), Impostos n(1,0), Imagem n(1,0), MantProds n(1,0), ;
71:                                            Barras n(1,0), Mccrs n(1,0), Cheques n(1,0), Delets n(1,0), ;
72:                                            DesItens n(1,0), MontaObs n(1,0), ChkCons n(1,0), MantemMats n(1,0), ;
73:                                            MantDPros n(1,0), GdeGrupos c(3), CUnis c(3), OriCompos n(1,0), ;
74:                                            Origems c(10), Destinos c(10), SemItens n(1,0), Fiscais n(1,0), ;
75:                                            Recalculos n(1,0), PctCopias n(8,2), OpItens c(1), cIdChaves c(20), ;
76:                                            MovMZeros n(1,0), MovcParc n(1,0), pctcomps n(8,2), Globalizas n(1,0))
77: 
78:                 IF USED("csDestinoG")
79:                     USE IN csDestinoG
80:                 ENDIF
81:                 CREATE CURSOR csDestinoG (Processos c(20), Mercs c(3), CUnis c(3), fkChaves c(20), Cgrus c(3))
82: 
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.ConfigurarPaginaLista()
85:                 THIS.ConfigurarPaginaDados()
86: 
87:                 *-- Propaga caption para labels de titulo
88:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
89:                 IF VARTYPE(loc_oCab) = "O"
90:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
91:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
92:                     ENDIF
93:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
94:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
95:                     ENDIF
96:                 ENDIF

*-- Linhas 362 a 380:
362:             .HighlightBackColor = RGB(255, 255, 255)
363:             .HighlightForeColor = RGB(15, 41, 104)
364:             .HighlightStyle     = 2
365:             .DeleteMark         = .F.
366:             .RecordMark         = .F.
367:             .RowHeight          = 16
368:             .ScrollBars         = 2
369:             .GridLines          = 3
370:             .ReadOnly           = .T.
371:             .Visible            = .T.
372:             .Column1.Width      = 200
373:             .Column1.ReadOnly   = .T.
374:             .Column1.Header1.Caption = "Processo"
375:             .Column2.Width      = 60
376:             .Column2.ReadOnly   = .T.
377:             .Column2.Header1.Caption = "Emp"
378:             .Column3.Width      = 80
379:             .Column3.ReadOnly   = .T.
380:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"

*-- Linhas 769 a 909:
769:             .HighlightBackColor = RGB(255, 255, 255)
770:             .HighlightForeColor = RGB(15, 41, 104)
771:             .HighlightStyle     = 2
772:             .DeleteMark         = .F.
773:             .RecordMark         = .F.
774:             .RowHeight          = 16
775:             .ScrollBars         = 3
776:             .GridLines          = 3
777:             .ReadOnly           = .F.
778:             .Visible            = .T.
779: 
780:             *-- Col1: EmpDs
781:             .Column1.Width          = 40
782:             .Column1.ControlSource  = "csDestinos.EmpDs"
783:             .Column1.Header1.Caption = "Emp"
784: 
785:             *-- Col2: Drives
786:             .Column2.Width          = 80
787:             .Column2.ControlSource  = "csDestinos.Drives"
788:             .Column2.Header1.Caption = "Local/Drive"
789: 
790:             *-- Col3: DopeDs
791:             .Column3.Width          = 80
792:             .Column3.ControlSource  = "csDestinos.DopeDs"
793:             .Column3.Header1.Caption = "Op.Dest."
794: 
795:             *-- Col4: TpProdutos
796:             .Column4.Width          = 45
797:             .Column4.ControlSource  = "csDestinos.TpProdutos"
798:             .Column4.Alignment      = 2
799:             .Column4.Header1.Caption = "Produto"
800: 
801:             *-- Col5: Dias
802:             .Column5.Width          = 35
803:             .Column5.ControlSource  = "csDestinos.Dias"
804:             .Column5.Alignment      = 2
805:             .Column5.Header1.Caption = "Dias"
806: 
807:             *-- Col6: PctMins
808:             .Column6.Width          = 75
809:             .Column6.ControlSource  = "csDestinos.PctMins"
810:             .Column6.Alignment      = 2
811:             .Column6.Header1.Caption = "Mg.Min."
812: 
813:             *-- Col7: PctMaxs
814:             .Column7.Width          = 75
815:             .Column7.ControlSource  = "csDestinos.PctMaxs"
816:             .Column7.Alignment      = 2
817:             .Column7.Header1.Caption = "Mg.Max."
818: 
819:             *-- Col8: GdeGrupos
820:             .Column8.Width          = 40
821:             .Column8.ControlSource  = "csDestinos.GdeGrupos"
822:             .Column8.Header1.Caption = "GGpr"
823: 
824:             *-- Col9: Emps (origem)
825:             .Column9.Width          = 35
826:             .Column9.ControlSource  = "csDestinos.Emps"
827:             .Column9.Header1.Caption = "Emp.Or."
828: 
829:             *-- Col10: Dopes (operacao origem)
830:             .Column10.Width          = 75
831:             .Column10.ControlSource  = "csDestinos.Dopes"
832:             .Column10.Header1.Caption = "Op.Orig."
833: 
834:             *-- Col11: CUnis
835:             .Column11.Width          = 35
836:             .Column11.ControlSource  = "csDestinos.CUnis"
837:             .Column11.Header1.Caption = "Uni"
838: 
839:             *-- Col12: Origems
840:             .Column12.Width          = 70
841:             .Column12.ControlSource  = "csDestinos.Origems"
842:             .Column12.Header1.Caption = "Cta.Orig."
843: 
844:             *-- Col13: Destinos
845:             .Column13.Width          = 70
846:             .Column13.ControlSource  = "csDestinos.Destinos"
847:             .Column13.Header1.Caption = "Cta.Dest."
848: 
849:             *-- Col14: SemItens (CheckBox)
850:             .Column14.Width          = 55
851:             .Column14.ControlSource  = "csDestinos.SemItens"
852:             .Column14.Sparse         = .F.
853:             .Column14.Header1.Caption = "Sem " + CHR(205) + "tens"
854:             .Column14.AddObject("Check1", "CheckBox")
855:             WITH .Column14.Check1
856:                 .Alignment  = 0
857:                 .ReadOnly   = .F.
858:                 .Visible    = .T.
859:                 .Top        = 9
860:                 .Left       = 2
861:                 .Height     = 17
862:                 .Width      = 22
863:             ENDWITH
864: 
865:             *-- Col15: Fiscais (CheckBox)
866:             .Column15.Width          = 45
867:             .Column15.ControlSource  = "csDestinos.Fiscais"
868:             .Column15.Sparse         = .F.
869:             .Column15.Header1.Caption = "Fiscal"
870:             .Column15.AddObject("Check1", "CheckBox")
871:             WITH .Column15.Check1
872:                 .Alignment  = 0
873:                 .ReadOnly   = .F.
874:                 .Visible    = .T.
875:                 .Top        = 9
876:                 .Left       = 2
877:                 .Height     = 17
878:                 .Width      = 22
879:             ENDWITH
880: 
881:             *-- Col16: PctCopias
882:             .Column16.Width          = 70
883:             .Column16.ControlSource  = "csDestinos.PctCopias"
884:             .Column16.Alignment      = 2
885:             .Column16.Header1.Caption = "% Prod/$"
886: 
887:             *-- Col17: OpItens
888:             .Column17.Width          = 50
889:             .Column17.ControlSource  = "csDestinos.OpItens"
890:             .Column17.Header1.Caption = "Op Itens"
891: 
892:             *-- Col18: pctcomps
893:             .Column18.Width          = 60
894:             .Column18.ControlSource  = "csDestinos.pctcomps"
895:             .Column18.Alignment      = 2
896:             .Column18.Header1.Caption = "Pct.Comps"
897:         ENDWITH
898: 
899:         *-- Botao copiar linha atual do grdDestinos
900:         loc_oPagina.AddObject("cmd_4c_CopOpe", "CommandButton")
901:         WITH loc_oPagina.cmd_4c_CopOpe
902:             .Caption       = "Copiar"
903:             .Top           = 325
904:             .Left          = 738
905:             .Width         = 55
906:             .Height        = 59
907:             .BackColor     = RGB(255, 255, 255)
908:             .ForeColor     = RGB(90, 90, 90)
909:             .FontName      = "Tahoma"

*-- Linhas 1976 a 2008:
1976:             .HighlightBackColor = RGB(255, 255, 255)
1977:             .HighlightForeColor = RGB(15, 41, 104)
1978:             .HighlightStyle     = 2
1979:             .DeleteMark         = .F.
1980:             .RecordMark         = .F.
1981:             .RowHeight          = 16
1982:             .ScrollBars         = 2
1983:             .GridLines          = 3
1984:             .ReadOnly           = .F.
1985:             .Visible            = .T.
1986:             .Column1.Width         = 40
1987:             .Column1.ControlSource = "csDestinoG.Mercs"
1988:             .Column1.Header1.Caption = "Merc"
1989:             .Column2.Width         = 40
1990:             .Column2.ControlSource = "csDestinoG.CUnis"
1991:             .Column2.Header1.Caption = "Uni"
1992:             .Column3.Width         = 55
1993:             .Column3.ControlSource = "csDestinoG.Cgrus"
1994:             .Column3.Header1.Caption = "Grupo"
1995:         ENDWITH
1996: 
1997:         *-- BINDEVENTs Page2
1998:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1999:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
2000:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoInserir, "Click", THIS, "BtnCompoInserirClick")
2001:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoExcluir, "Click", THIS, "BtnCompoExcluirClick")
2002:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpInserir,    "Click", THIS, "BtnGrpInserirClick")
2003:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpExcluir,    "Click", THIS, "BtnGrpExcluirClick")
2004:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "AfterRowColChange", THIS, "GrdDestinosAfterRowColChange")
2005:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "KeyPress", THIS, "GrdDestinosKeyPress")
2006:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "DblClick", THIS, "GrdDestinosDblClick")
2007:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "KeyPress", THIS, "GrdDestinoGKeyPress")
2008:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "DblClick", THIS, "GrdDestinoGDblClick")

*-- Linhas 2021 a 2050:
2021:         TRY
2022:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2023:                 IF !USED("cursor_4c_Dados")
2024:                     CREATE CURSOR cursor_4c_Dados (processos c(20), emps c(3), codigos n(6,0))
2025:                 ENDIF
2026:                 loc_lResultado = .T.
2027:             ELSE
2028:                 IF THIS.this_oBusinessObject.Buscar("")
2029:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2030:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2031:                         loc_oGrid.ColumnCount = 3
2032:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2033:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
2034:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2035:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
2036:                         loc_oGrid.Column1.Header1.Caption = "Processo"
2037:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2038:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2039:                         THIS.FormatarGridLista(loc_oGrid)
2040:                     ENDIF
2041:                     loc_lResultado = .T.
2042:                 ENDIF
2043:             ENDIF
2044:         CATCH TO loc_oErro
2045:             MsgErro("Erro em Formprc.CarregarLista:" + CHR(13) + loc_oErro.Message + ;
2046:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2047:         ENDTRY
2048: 
2049:         RETURN loc_lResultado
2050:     ENDPROC

*-- Linhas 2080 a 2098:
2080:                 ELSE
2081:                     IF THIS.this_cModoAtual = "INCLUIR"
2082:                     *-- Linha padrao vazia para o modo inserir
2083:                     SELECT csDestinos
2084:                     APPEND BLANK
2085:                     ENDIF
2086:                 ENDIF
2087: 
2088:                 THIS.RefrescarOpcoesDoItem()
2089:                 THIS.AtualizarEstadoCampos()
2090:             ENDIF
2091: 
2092:             loc_lResultado = .T.
2093:         CATCH TO loc_oErro
2094:             MsgErro("Erro em Formprc.AlternarPagina:" + CHR(13) + loc_oErro.Message + ;
2095:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2096:         ENDTRY
2097: 
2098:         RETURN loc_lResultado

*-- Linhas 2111 a 2139:
2111:                 USE IN cursor_4c_OoI
2112:             ENDIF
2113: 
2114:             loc_cSQL = "SELECT * FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos) + ;
2115:                        " ORDER BY codigos"
2116:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OoI")
2117: 
2118:             IF loc_nResult >= 0
2119:                 SELECT csDestinos
2120:                 ZAP
2121:                 SELECT cursor_4c_OoI
2122:                 SCAN
2123:                     loc_cCidChaves = ALLTRIM(cursor_4c_OoI.cidchaves)
2124:                     INSERT INTO csDestinos (Processos, Codigos, Drives, Emps, Dopes, EmpDs, DopeDs, ;
2125:                                             TpProdutos, Dias, GruconOs, GruconDs, EmpDests, Agrupar, ;
2126:                                             NovoCods, CorTams, MoeVals, Situas, Franquias, PctMins, PctMaxs, ;
2127:                                             Custos, Impostos, Imagem, MantProds, Barras, Mccrs, Cheques, ;
2128:                                             Delets, DesItens, MontaObs, ChkCons, MantemMats, MantDPros, ;
2129:                                             GdeGrupos, CUnis, OriCompos, Origems, Destinos, SemItens, Fiscais, ;
2130:                                             Recalculos, PctCopias, OpItens, cIdChaves, MovMZeros, MovcParc, ;
2131:                                             pctcomps, Globalizas) ;
2132:                            VALUES (TratarNulo(cursor_4c_OoI.processos,""), ;
2133:                                    TratarNulo(cursor_4c_OoI.codigos,0), ;
2134:                                    TratarNulo(cursor_4c_OoI.drives,""), ;
2135:                                    TratarNulo(cursor_4c_OoI.emps,""), ;
2136:                                    TratarNulo(cursor_4c_OoI.dopes,""), ;
2137:                                    TratarNulo(cursor_4c_OoI.empds,""), ;
2138:                                    TratarNulo(cursor_4c_OoI.dopeds,""), ;
2139:                                    TratarNulo(cursor_4c_OoI.tpprodutos,0), ;

*-- Linhas 2183 a 2224:
2183:                         USE IN cursor_4c_OoG
2184:                     ENDIF
2185:                     LOCAL loc_cSQLG, loc_nResG
2186:                     loc_cSQLG = "SELECT * FROM SigPcOog WHERE fkchaves = " + EscaparSQL(loc_cCidChaves)
2187:                     loc_nResG = SQLEXEC(gnConnHandle, loc_cSQLG, "cursor_4c_OoG")
2188:                     IF loc_nResG >= 0
2189:                         SELECT cursor_4c_OoG
2190:                         SCAN
2191:                             INSERT INTO csDestinoG (Processos, Mercs, CUnis, fkChaves, Cgrus) ;
2192:                                 VALUES (TratarNulo(cursor_4c_OoG.processos,""), ;
2193:                                         TratarNulo(cursor_4c_OoG.mercs,""), ;
2194:                                         TratarNulo(cursor_4c_OoG.cunis,""), ;
2195:                                         loc_cCidChaves, ;
2196:                                         TratarNulo(cursor_4c_OoG.cgrus,""))
2197:                         ENDSCAN
2198:                         IF USED("cursor_4c_OoG")
2199:                             USE IN cursor_4c_OoG
2200:                         ENDIF
2201:                     ENDIF
2202:                     SELECT cursor_4c_OoI
2203:                 ENDSCAN
2204: 
2205:                 IF USED("cursor_4c_OoI")
2206:                     USE IN cursor_4c_OoI
2207:                 ENDIF
2208: 
2209:                 SELECT csDestinos
2210:                 IF RECCOUNT("csDestinos") > 0
2211:                     GO TOP IN csDestinos
2212:                 ENDIF
2213: 
2214:                 loc_lResultado = .T.
2215:             ELSE
2216:                 MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
2217:             ENDIF
2218:         CATCH TO loc_oErro
2219:             MsgErro("Erro em Formprc.CarregarItens:" + CHR(13) + loc_oErro.Message + ;
2220:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2221:         ENDTRY
2222: 
2223:         RETURN loc_lResultado
2224:     ENDPROC

*-- Linhas 2242 a 2260:
2242:         ENDIF
2243: 
2244:         TRY
2245:             SELECT csDestinos
2246: 
2247:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
2248:                 loc_nVal = csDestinos.GruconOs
2249:                 loc_oPg2.obj_4c_OptGruConOs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2250:             ENDIF
2251:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
2252:                 loc_nVal = csDestinos.GruconDs
2253:                 loc_oPg2.obj_4c_OptGruConDs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2254:             ENDIF
2255:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
2256:                 loc_nVal = csDestinos.Agrupar
2257:                 loc_oPg2.obj_4c_OptAgrupar.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2258:             ENDIF
2259:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
2260:                 loc_nVal = csDestinos.Franquias

*-- Linhas 2374 a 2392:
2374:         ENDIF
2375: 
2376:         TRY
2377:             SELECT csDestinos
2378:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
2379:                 REPLACE csDestinos.GruconOs WITH loc_oPg2.obj_4c_OptGruConOs.Value
2380:             ENDIF
2381:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
2382:                 REPLACE csDestinos.GruconDs WITH loc_oPg2.obj_4c_OptGruConDs.Value
2383:             ENDIF
2384:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
2385:                 REPLACE csDestinos.Agrupar WITH loc_oPg2.obj_4c_OptAgrupar.Value
2386:             ENDIF
2387:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
2388:                 REPLACE csDestinos.Franquias WITH loc_oPg2.obj_4c_OptFranquia.Value
2389:             ENDIF
2390:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptCustos", 5)
2391:                 REPLACE csDestinos.Custos WITH loc_oPg2.obj_4c_OptCustos.Value
2392:             ENDIF

*-- Linhas 2705 a 2723:
2705:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2706:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
2707:             ELSE
2708:                 SELECT cursor_4c_Dados
2709:                 IF EOF("cursor_4c_Dados")
2710:                     MsgAviso("Selecione um registro na lista.", "Visualizar")
2711:                 ELSE
2712:                     loc_nCodigos = cursor_4c_Dados.codigos
2713:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
2714:                         THIS.this_cModoAtual     = "VISUALIZAR"
2715:                         THIS.this_nPkAtual       = loc_nCodigos
2716:                         THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
2717:                         THIS.BOParaForm()
2718:                         THIS.AtualizarEstadoCampos()
2719:                         THIS.AlternarPagina(2)
2720:                     ELSE
2721:                         MsgErro("Erro ao carregar registro!", "Visualizar")
2722:                     ENDIF
2723:                 ENDIF

*-- Linhas 2738 a 2756:
2738:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2739:                 MsgAviso("Selecione um registro na lista.", "Alterar")
2740:             ELSE
2741:                 SELECT cursor_4c_Dados
2742:                 IF EOF("cursor_4c_Dados")
2743:                     MsgAviso("Selecione um registro na lista.", "Alterar")
2744:                 ELSE
2745:                     loc_nCodigos = cursor_4c_Dados.codigos
2746:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
2747:                         THIS.this_oBusinessObject.EditarRegistro()
2748:                         THIS.this_cModoAtual     = "ALTERAR"
2749:                         THIS.this_nPkAtual       = loc_nCodigos
2750:                         THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
2751:                         THIS.BOParaForm()
2752:                         THIS.AtualizarEstadoCampos()
2753:                         THIS.AlternarPagina(2)
2754:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Toleras", 5)
2755:                             THIS.pgf_4c_Paginas.Page2.txt_4c_Toleras.SetFocus()
2756:                         ENDIF

*-- Linhas 2775 a 2793:
2775:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2776:                 MsgAviso("Selecione um registro na lista.", "Excluir")
2777:             ELSE
2778:                 SELECT cursor_4c_Dados
2779:                 IF EOF("cursor_4c_Dados")
2780:                     MsgAviso("Selecione um registro na lista.", "Excluir")
2781:                 ELSE
2782:                     loc_nCodigos = cursor_4c_Dados.codigos
2783:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste processo?", ;
2784:                                    "Confirmar Exclus" + CHR(227) + "o")
2785:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
2786:                             IF THIS.this_oBusinessObject.Excluir()
2787:                                 MsgInfo("Processo exclu" + CHR(237) + "do com sucesso!", ;
2788:                                         "Exclu" + CHR(237) + "do")
2789:                                 THIS.CarregarLista()
2790:                             ELSE
2791:                                 MsgErro("Erro ao excluir processo!", "Excluir")
2792:                             ENDIF
2793:                         ELSE

*-- Linhas 2811 a 2837:
2811: 
2812:         TRY
2813:             IF !EMPTY(ALLTRIM(loc_cTermoBusca))
2814:                 loc_cFiltro = "processos LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
2815:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2816:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2817:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2818:                         loc_oGrid.ColumnCount = 3
2819:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2820:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
2821:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2822:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
2823:                         loc_oGrid.Column1.Header1.Caption = "Processo"
2824:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2825:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2826:                         THIS.FormatarGridLista(loc_oGrid)
2827:                     ENDIF
2828:                 ENDIF
2829:             ELSE
2830:                 THIS.CarregarLista()
2831:             ENDIF
2832:         CATCH TO loc_oErro
2833:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2834:         ENDTRY
2835:     ENDPROC
2836: 
2837:     *==========================================================================

*-- Linhas 2872 a 2891:
2872:                 IF USED("cursor_4c_ChkProc")
2873:                     USE IN cursor_4c_ChkProc
2874:                 ENDIF
2875:                 loc_cSQL = "SELECT codigos FROM SigPcOoP WHERE processos = " + EscaparSQL(loc_cProcessos)
2876:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProc")
2877:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkProc") > 0
2878:                     MsgAviso("Processo '" + loc_cProcessos + "' j" + CHR(225) + " existe!", ;
2879:                              "Aten" + CHR(231) + CHR(227) + "o")
2880:                     IF USED("cursor_4c_ChkProc")
2881:                         USE IN cursor_4c_ChkProc
2882:                     ENDIF
2883:                     IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
2884:                         loc_oPg2.txt_4c_Processos.SetFocus()
2885:                     ENDIF
2886:                     RETURN
2887:                 ENDIF
2888:                 IF USED("cursor_4c_ChkProc")
2889:                     USE IN cursor_4c_ChkProc
2890:                 ENDIF
2891:             CATCH TO loc_oErro

*-- Linhas 2899 a 2917:
2899:             IF loc_oPg2.obj_4c_OptFiscal.Value = .T.
2900:                 loc_lFiscalOk = .F.
2901:                 IF USED("csDestinos")
2902:                     SELECT csDestinos
2903:                     SCAN
2904:                         IF csDestinos.Fiscais = 1
2905:                             loc_lFiscalOk = .T.
2906:                             EXIT
2907:                         ENDIF
2908:                     ENDSCAN
2909:                 ENDIF
2910:                 IF !loc_lFiscalOk
2911:                     MsgAviso("Fiscal habilitado mas nenhuma linha de destino tem Fiscal marcado!", ;
2912:                              "Aten" + CHR(231) + CHR(227) + "o")
2913:                     RETURN
2914:                 ENDIF
2915:             ENDIF
2916:         ENDIF
2917: 

*-- Linhas 2970 a 3098:
2970:         TRY
2971:             *-- Sincroniza opcoes antes de mover para nova linha
2972:             THIS.SincronizarOpcoesParaItem()
2973:             SELECT csDestinos
2974:             APPEND BLANK
2975:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
2976:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
2977:             ENDIF
2978:             THIS.RefrescarOpcoesDoItem()
2979:         CATCH TO loc_oErro
2980:             MsgErro("Erro em BtnCompoInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
2981:         ENDTRY
2982:     ENDPROC
2983: 
2984:     *==========================================================================
2985:     * BtnCompoExcluirClick - Exclui linha atual do csDestinos e seus grupos
2986:     *==========================================================================
2987:     PROCEDURE BtnCompoExcluirClick()
2988:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2989:             RETURN
2990:         ENDIF
2991:         TRY
2992:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
2993:                 LOCAL loc_cIdRef
2994:                 SELECT csDestinos
2995:                 loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
2996:                 DELETE IN csDestinos
2997:                 PACK IN csDestinos
2998:                 *-- Remove grupos associados
2999:                 IF USED("csDestinoG") AND !EMPTY(loc_cIdRef)
3000:                     SELECT csDestinoG
3001:                     DELETE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef
3002:                     PACK IN csDestinoG
3003:                 ENDIF
3004:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
3005:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
3006:                 ENDIF
3007:                 THIS.RefrescarOpcoesDoItem()
3008:             ENDIF
3009:         CATCH TO loc_oErro
3010:             MsgErro("Erro em BtnCompoExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3011:         ENDTRY
3012:     ENDPROC
3013: 
3014:     *==========================================================================
3015:     * BtnGrpInserirClick - Insere nova linha em csDestinoG vinculada ao item atual
3016:     *==========================================================================
3017:     PROCEDURE BtnGrpInserirClick()
3018:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3019:             RETURN
3020:         ENDIF
3021:         TRY
3022:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
3023:                 SELECT csDestinos
3024:                 LOCAL loc_cFk
3025:                 loc_cFk = ALLTRIM(csDestinos.cIdChaves)
3026:                 IF EMPTY(loc_cFk)
3027:                     *-- Atribui novo ID se ainda nao tem
3028:                     loc_cFk = SYS(2015)
3029:                     REPLACE csDestinos.cIdChaves WITH loc_cFk
3030:                 ENDIF
3031:                 INSERT INTO csDestinoG (Processos, fkChaves) ;
3032:                     VALUES (ALLTRIM(csDestinos.Processos), loc_cFk)
3033:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
3034:                     THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
3035:                 ENDIF
3036:             ELSE
3037:                 MsgAviso("Selecione um item de destino primeiro.", "Aten" + CHR(231) + CHR(227) + "o")
3038:             ENDIF
3039:         CATCH TO loc_oErro
3040:             MsgErro("Erro em BtnGrpInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3041:         ENDTRY
3042:     ENDPROC
3043: 
3044:     *==========================================================================
3045:     * BtnGrpExcluirClick - Exclui linha atual de csDestinoG
3046:     *==========================================================================
3047:     PROCEDURE BtnGrpExcluirClick()
3048:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3049:             RETURN
3050:         ENDIF
3051:         TRY
3052:             IF USED("csDestinoG") AND RECCOUNT("csDestinoG") > 0 AND !EOF("csDestinoG")
3053:                 SELECT csDestinoG
3054:                 DELETE IN csDestinoG
3055:                 PACK IN csDestinoG
3056:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
3057:                     THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
3058:                 ENDIF
3059:             ENDIF
3060:         CATCH TO loc_oErro
3061:             MsgErro("Erro em BtnGrpExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3062:         ENDTRY
3063:     ENDPROC
3064: 
3065:     *==========================================================================
3066:     * BtnCopOpeClick - Copia linha atual do csDestinos e seus grupos
3067:     *==========================================================================
3068:     PROCEDURE BtnCopOpeClick()
3069:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3070:             RETURN
3071:         ENDIF
3072:         TRY
3073:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
3074:                 LOCAL loc_cIdAntigo, loc_cIdNovo
3075:                 SELECT csDestinos
3076:                 loc_cIdAntigo = ALLTRIM(csDestinos.cIdChaves)
3077:                 loc_cIdNovo   = SYS(2015)
3078:                 SCATTER MEMVAR MEMO
3079:                 APPEND BLANK
3080:                 GATHER MEMVAR MEMO
3081:                 REPLACE csDestinos.cIdChaves WITH loc_cIdNovo
3082:                 IF USED("csDestinoG") AND !EMPTY(loc_cIdAntigo)
3083:                     SELECT csDestinoG
3084:                     LOCATE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
3085:                     DO WHILE !EOF("csDestinoG") AND ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
3086:                         SCATTER MEMVAR MEMO
3087:                         APPEND BLANK
3088:                         GATHER MEMVAR MEMO
3089:                         REPLACE csDestinoG.fkChaves WITH loc_cIdNovo
3090:                         SKIP
3091:                     ENDDO
3092:                 ENDIF
3093:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
3094:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
3095:                 ENDIF
3096:             ELSE
3097:                 MsgAviso("Selecione um item para copiar.", "Aten" + CHR(231) + CHR(227) + "o")
3098:             ENDIF

*-- Linhas 3203 a 3235:
3203:             IF USED("cursor_4c_BuscaDrives")
3204:                 USE IN cursor_4c_BuscaDrives
3205:             ENDIF
3206:             loc_nResult = SQLEXEC(gnConnHandle, ;
3207:                 "SELECT cods, drives FROM SigCdLoc ORDER BY cods", ;
3208:                 "cursor_4c_BuscaDrives")
3209:             IF loc_nResult < 0
3210:                 MsgErro("Erro ao buscar Locais/Drives.", "Erro")
3211:                 RETURN
3212:             ENDIF
3213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3214:             loc_oBusca.DefinirCursor("cursor_4c_BuscaDrives", "cods", "drives", ;
3215:                 "Buscar Local/Drive")
3216:             loc_oBusca.Mostrar()
3217:             IF loc_oBusca.this_lSelecionou
3218:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3219:                 IF USED("csDestinos") AND !EOF("csDestinos")
3220:                     SELECT csDestinos
3221:                     REPLACE csDestinos.Drives WITH loc_cSelecionado
3222:                     loc_oGrid.Refresh()
3223:                 ENDIF
3224:             ENDIF
3225:             IF USED("cursor_4c_BuscaDrives")
3226:                 USE IN cursor_4c_BuscaDrives
3227:             ENDIF
3228:             loc_oBusca.Release()
3229:         CATCH TO loc_oErro
3230:             MsgErro("Erro em AbrirLookupDrives:" + CHR(13) + loc_oErro.Message, "Erro")
3231:         ENDTRY
3232:     ENDPROC
3233: 
3234:     *==========================================================================
3235:     * AbrirLookupOperacaoDestino - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.DopeDs

*-- Linhas 3241 a 3273:
3241:             IF USED("cursor_4c_BuscaOpeDs")
3242:                 USE IN cursor_4c_BuscaOpeDs
3243:             ENDIF
3244:             loc_nResult = SQLEXEC(gnConnHandle, ;
3245:                 "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
3246:                 "cursor_4c_BuscaOpeDs")
3247:             IF loc_nResult < 0
3248:                 MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
3249:                 RETURN
3250:             ENDIF
3251:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3252:             loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeDs", "Dopes", "Dopes", ;
3253:                 "Buscar Opera" + CHR(231) + CHR(227) + "o Destino")
3254:             loc_oBusca.Mostrar()
3255:             IF loc_oBusca.this_lSelecionou
3256:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3257:                 IF USED("csDestinos") AND !EOF("csDestinos")
3258:                     SELECT csDestinos
3259:                     REPLACE csDestinos.DopeDs WITH loc_cSelecionado
3260:                     loc_oGrid.Refresh()
3261:                 ENDIF
3262:             ENDIF
3263:             IF USED("cursor_4c_BuscaOpeDs")
3264:                 USE IN cursor_4c_BuscaOpeDs
3265:             ENDIF
3266:             loc_oBusca.Release()
3267:         CATCH TO loc_oErro
3268:             MsgErro("Erro em AbrirLookupOperacaoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3269:         ENDTRY
3270:     ENDPROC
3271: 
3272:     *==========================================================================
3273:     * AbrirLookupGrandeGrupoDestino - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinos.GdeGrupos

*-- Linhas 3279 a 3311:
3279:             IF USED("cursor_4c_BuscaGdeGrp")
3280:                 USE IN cursor_4c_BuscaGdeGrp
3281:             ENDIF
3282:             loc_nResult = SQLEXEC(gnConnHandle, ;
3283:                 "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
3284:                 "cursor_4c_BuscaGdeGrp")
3285:             IF loc_nResult < 0
3286:                 MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
3287:                 RETURN
3288:             ENDIF
3289:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3290:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrp", "codigos", "descs", ;
3291:                 "Buscar Grande Grupo")
3292:             loc_oBusca.Mostrar()
3293:             IF loc_oBusca.this_lSelecionou
3294:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3295:                 IF USED("csDestinos") AND !EOF("csDestinos")
3296:                     SELECT csDestinos
3297:                     REPLACE csDestinos.GdeGrupos WITH loc_cSelecionado
3298:                     loc_oGrid.Refresh()
3299:                 ENDIF
3300:             ENDIF
3301:             IF USED("cursor_4c_BuscaGdeGrp")
3302:                 USE IN cursor_4c_BuscaGdeGrp
3303:             ENDIF
3304:             loc_oBusca.Release()
3305:         CATCH TO loc_oErro
3306:             MsgErro("Erro em AbrirLookupGrandeGrupoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3307:         ENDTRY
3308:     ENDPROC
3309: 
3310:     *==========================================================================
3311:     * AbrirLookupEmpresaDestino - Busca Empresa (SigCdEmp.Cemps) -> csDestinos.Emps

*-- Linhas 3317 a 3349:
3317:             IF USED("cursor_4c_BuscaEmpOr")
3318:                 USE IN cursor_4c_BuscaEmpOr
3319:             ENDIF
3320:             loc_nResult = SQLEXEC(gnConnHandle, ;
3321:                 "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
3322:                 "cursor_4c_BuscaEmpOr")
3323:             IF loc_nResult < 0
3324:                 MsgErro("Erro ao buscar Empresas.", "Erro")
3325:                 RETURN
3326:             ENDIF
3327:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3328:             loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpOr", "Cemps", "Razas", ;
3329:                 "Buscar Empresa Origem")
3330:             loc_oBusca.Mostrar()
3331:             IF loc_oBusca.this_lSelecionou
3332:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3333:                 IF USED("csDestinos") AND !EOF("csDestinos")
3334:                     SELECT csDestinos
3335:                     REPLACE csDestinos.Emps WITH loc_cSelecionado
3336:                     loc_oGrid.Refresh()
3337:                 ENDIF
3338:             ENDIF
3339:             IF USED("cursor_4c_BuscaEmpOr")
3340:                 USE IN cursor_4c_BuscaEmpOr
3341:             ENDIF
3342:             loc_oBusca.Release()
3343:         CATCH TO loc_oErro
3344:             MsgErro("Erro em AbrirLookupEmpresaDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3345:         ENDTRY
3346:     ENDPROC
3347: 
3348:     *==========================================================================
3349:     * AbrirLookupOperacaoOrigem - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.Dopes

*-- Linhas 3355 a 3387:
3355:             IF USED("cursor_4c_BuscaOpeOr")
3356:                 USE IN cursor_4c_BuscaOpeOr
3357:             ENDIF
3358:             loc_nResult = SQLEXEC(gnConnHandle, ;
3359:                 "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
3360:                 "cursor_4c_BuscaOpeOr")
3361:             IF loc_nResult < 0
3362:                 MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
3363:                 RETURN
3364:             ENDIF
3365:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3366:             loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeOr", "Dopes", "Dopes", ;
3367:                 "Buscar Opera" + CHR(231) + CHR(227) + "o Origem")
3368:             loc_oBusca.Mostrar()
3369:             IF loc_oBusca.this_lSelecionou
3370:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3371:                 IF USED("csDestinos") AND !EOF("csDestinos")
3372:                     SELECT csDestinos
3373:                     REPLACE csDestinos.Dopes WITH loc_cSelecionado
3374:                     loc_oGrid.Refresh()
3375:                 ENDIF
3376:             ENDIF
3377:             IF USED("cursor_4c_BuscaOpeOr")
3378:                 USE IN cursor_4c_BuscaOpeOr
3379:             ENDIF
3380:             loc_oBusca.Release()
3381:         CATCH TO loc_oErro
3382:             MsgErro("Erro em AbrirLookupOperacaoOrigem:" + CHR(13) + loc_oErro.Message, "Erro")
3383:         ENDTRY
3384:     ENDPROC
3385: 
3386:     *==========================================================================
3387:     * AbrirLookupUnidadeDestino - Busca Unidade (SigCdUni.CUnis) -> csDestinos.CUnis

*-- Linhas 3393 a 3425:
3393:             IF USED("cursor_4c_BuscaUni")
3394:                 USE IN cursor_4c_BuscaUni
3395:             ENDIF
3396:             loc_nResult = SQLEXEC(gnConnHandle, ;
3397:                 "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
3398:                 "cursor_4c_BuscaUni")
3399:             IF loc_nResult < 0
3400:                 MsgErro("Erro ao buscar Unidades.", "Erro")
3401:                 RETURN
3402:             ENDIF
3403:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3404:             loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", ;
3405:                 "Buscar Unidade")
3406:             loc_oBusca.Mostrar()
3407:             IF loc_oBusca.this_lSelecionou
3408:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3409:                 IF USED("csDestinos") AND !EOF("csDestinos")
3410:                     SELECT csDestinos
3411:                     REPLACE csDestinos.CUnis WITH loc_cSelecionado
3412:                     loc_oGrid.Refresh()
3413:                 ENDIF
3414:             ENDIF
3415:             IF USED("cursor_4c_BuscaUni")
3416:                 USE IN cursor_4c_BuscaUni
3417:             ENDIF
3418:             loc_oBusca.Release()
3419:         CATCH TO loc_oErro
3420:             MsgErro("Erro em AbrirLookupUnidadeDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3421:         ENDTRY
3422:     ENDPROC
3423: 
3424:     *==========================================================================
3425:     * AbrirLookupGrandeGrupoG - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinoG.Mercs

*-- Linhas 3431 a 3463:
3431:             IF USED("cursor_4c_BuscaGdeGrpG")
3432:                 USE IN cursor_4c_BuscaGdeGrpG
3433:             ENDIF
3434:             loc_nResult = SQLEXEC(gnConnHandle, ;
3435:                 "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
3436:                 "cursor_4c_BuscaGdeGrpG")
3437:             IF loc_nResult < 0
3438:                 MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
3439:                 RETURN
3440:             ENDIF
3441:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3442:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrpG", "codigos", "descs", ;
3443:                 "Buscar Grande Grupo")
3444:             loc_oBusca.Mostrar()
3445:             IF loc_oBusca.this_lSelecionou
3446:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3447:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3448:                     SELECT csDestinoG
3449:                     REPLACE csDestinoG.Mercs WITH loc_cSelecionado
3450:                     loc_oGrid.Refresh()
3451:                 ENDIF
3452:             ENDIF
3453:             IF USED("cursor_4c_BuscaGdeGrpG")
3454:                 USE IN cursor_4c_BuscaGdeGrpG
3455:             ENDIF
3456:             loc_oBusca.Release()
3457:         CATCH TO loc_oErro
3458:             MsgErro("Erro em AbrirLookupGrandeGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
3459:         ENDTRY
3460:     ENDPROC
3461: 
3462:     *==========================================================================
3463:     * AbrirLookupUnidadeG - Busca Unidade (SigCdUni.CUnis) -> csDestinoG.CUnis

*-- Linhas 3469 a 3501:
3469:             IF USED("cursor_4c_BuscaUniG")
3470:                 USE IN cursor_4c_BuscaUniG
3471:             ENDIF
3472:             loc_nResult = SQLEXEC(gnConnHandle, ;
3473:                 "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
3474:                 "cursor_4c_BuscaUniG")
3475:             IF loc_nResult < 0
3476:                 MsgErro("Erro ao buscar Unidades.", "Erro")
3477:                 RETURN
3478:             ENDIF
3479:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3480:             loc_oBusca.DefinirCursor("cursor_4c_BuscaUniG", "CUnis", "DUnis", ;
3481:                 "Buscar Unidade")
3482:             loc_oBusca.Mostrar()
3483:             IF loc_oBusca.this_lSelecionou
3484:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3485:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3486:                     SELECT csDestinoG
3487:                     REPLACE csDestinoG.CUnis WITH loc_cSelecionado
3488:                     loc_oGrid.Refresh()
3489:                 ENDIF
3490:             ENDIF
3491:             IF USED("cursor_4c_BuscaUniG")
3492:                 USE IN cursor_4c_BuscaUniG
3493:             ENDIF
3494:             loc_oBusca.Release()
3495:         CATCH TO loc_oErro
3496:             MsgErro("Erro em AbrirLookupUnidadeG:" + CHR(13) + loc_oErro.Message, "Erro")
3497:         ENDTRY
3498:     ENDPROC
3499: 
3500:     *==========================================================================
3501:     * AbrirLookupGrupoG - Busca Grupo de Produto (SigCdGrp.cgrus) -> csDestinoG.Cgrus

*-- Linhas 3507 a 3538:
3507:             IF USED("cursor_4c_BuscaGrpG")
3508:                 USE IN cursor_4c_BuscaGrpG
3509:             ENDIF
3510:             loc_nResult = SQLEXEC(gnConnHandle, ;
3511:                 "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
3512:                 "cursor_4c_BuscaGrpG")
3513:             IF loc_nResult < 0
3514:                 MsgErro("Erro ao buscar Grupos de Produto.", "Erro")
3515:                 RETURN
3516:             ENDIF
3517:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3518:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrpG", "cgrus", "dgrus", ;
3519:                 "Buscar Grupo de Produto")
3520:             loc_oBusca.Mostrar()
3521:             IF loc_oBusca.this_lSelecionou
3522:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3523:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3524:                     SELECT csDestinoG
3525:                     REPLACE csDestinoG.Cgrus WITH loc_cSelecionado
3526:                     loc_oGrid.Refresh()
3527:                 ENDIF
3528:             ENDIF
3529:             IF USED("cursor_4c_BuscaGrpG")
3530:                 USE IN cursor_4c_BuscaGrpG
3531:             ENDIF
3532:             loc_oBusca.Release()
3533:         CATCH TO loc_oErro
3534:             MsgErro("Erro em AbrirLookupGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
3535:         ENDTRY
3536:     ENDPROC
3537: 
3538: ENDDEFINE


### BO (C:\4c\projeto\app\classes\prcBO.prg):
*==============================================================================
* prcBO.prg - Business Object: Cadastro de Movimenta" + CHR(231) + CHR(245) + "es Para C" + CHR(243) + "pia
* Tabela principal : SigPcOoP (PK: codigos numeric(6,0))
* Tabelas filhas   : SigPcOoI (cidchaves PK), SigPcOog (cidchaves PK)
* Herda de         : BusinessBase (app\classes\businessbase.prg)
* Task             : task501
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS prcBO AS BusinessBase

    *-- Campos da tabela SigPcOoP
    this_cProcessos  = ""   && processos  CHAR(20)    - nome/chave do processo
    this_cEmps       = ""   && emps       CHAR(3)     - empresa
    this_cDopes      = ""   && dopes      CHAR(20)    - operacao
    this_nCodigos    = 0    && codigos    NUM(6,0)    - PK
    this_nNotas      = 0    && notas      NUM(1,0)
    this_nOrdems     = 0    && ordems     NUM(1,0)
    this_nApagar     = 0    && apagar     NUM(1,0)
    this_nFiscal     = 0    && fiscal     NUM(1,0)
    this_nImprimir   = 0    && imprimir   NUM(1,0)
    this_nLogs       = 0    && logs       NUM(1,0)
    this_nToleras    = 0    && toleras    NUM(11,2)
    this_cClass      = ""   && class      CHAR(15)
    this_cGrupo      = ""   && grupo      CHAR(15)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPcOoP"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "prcBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condicao WHERE adicional (sem WHERE) ou "" para todos
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT processos, emps, codigos" + ;
                       " FROM SigPcOoP" + loc_cWhere + ;
                       " ORDER BY processos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar processos de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Buscar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo codigos (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF

            loc_cSQL = "SELECT processos, emps, dopes, codigos, notas, ordems," + ;
                       " apagar, fiscal, imprimir, logs, toleras, class AS tclass, grupo" + ;
                       " FROM SigPcOoP" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Registro") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Registro")
            ENDIF

            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades do BO a partir do cursor
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProcessos = TratarNulo(processos, "")
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cDopes     = TratarNulo(dopes,     "")
                THIS.this_nCodigos   = TratarNulo(codigos,   0)
                THIS.this_nNotas     = TratarNulo(notas,     0)
                THIS.this_nOrdems    = TratarNulo(ordems,    0)
                THIS.this_nApagar    = TratarNulo(apagar,    0)
                THIS.this_nFiscal    = TratarNulo(fiscal,    0)
                THIS.this_nImprimir  = TratarNulo(imprimir,  0)
                THIS.this_nLogs      = TratarNulo(logs,      0)
                THIS.this_nToleras   = TratarNulo(toleras,   0)
                THIS.this_cClass     = TratarNulo(tclass,    "")
                THIS.this_cGrupo     = TratarNulo(grupo,     "")
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_nCodigos = THIS.ObterProxCodigos()

            loc_cSQL = "INSERT INTO SigPcOoP" + ;
                       " (processos, emps, dopes, codigos, notas, ordems," + ;
                       "  apagar, fiscal, imprimir, logs, toleras, class, grupo)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cProcessos)           + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                + ", " + ;
                       EscaparSQL(THIS.this_cDopes)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nApagar)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFiscal)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImprimir)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLogs)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nToleras)      + ", " + ;
                       EscaparSQL(THIS.this_cClass)               + ", " + ;
                       EscaparSQL(THIS.this_cGrupo)               + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Inserir:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPcOoP SET" + ;
                       " processos = " + EscaparSQL(THIS.this_cProcessos)       + ", " + ;
                       " emps      = " + EscaparSQL(THIS.this_cEmps)            + ", " + ;
                       " dopes     = " + EscaparSQL(THIS.this_cDopes)           + ", " + ;
                       " notas     = " + FormatarNumeroSQL(THIS.this_nNotas)    + ", " + ;
                       " ordems    = " + FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       " apagar    = " + FormatarNumeroSQL(THIS.this_nApagar)   + ", " + ;
                       " fiscal    = " + FormatarNumeroSQL(THIS.this_nFiscal)   + ", " + ;
                       " imprimir  = " + FormatarNumeroSQL(THIS.this_nImprimir) + ", " + ;
                       " logs      = " + FormatarNumeroSQL(THIS.this_nLogs)     + ", " + ;
                       " toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + ", " + ;
                       " class     = " + EscaparSQL(THIS.this_cClass)           + ", " + ;
                       " grupo     = " + EscaparSQL(THIS.this_cGrupo)           + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar processo de c" + CHR(243) + "pia:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.Atualizar:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui em cascata: OoI -> OoG -> SigCdPrg -> OoP
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProc
        loc_lSucesso = .F.

        TRY
            loc_cProc = ALLTRIM(THIS.this_cProcessos)

            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(loc_cProc)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(loc_cProc)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir grupos SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Remove entrada em SigCdPrg (erro nao critico)
                    loc_cSQL = "DELETE FROM SigCdPrg" + ;
                               " WHERE programas = " + EscaparSQL(PADR("SIGCDPRC", 15)) + ;
                               " AND parametros = " + EscaparSQL(PADL(TRANSFORM(THIS.this_nCodigos), 10, "0"))
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    loc_cSQL = "DELETE FROM SigPcOoP WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao excluir SigPcOoP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProxCodigos - Gera proximo codigos (MAX+1) em SigPcOoP
    *==========================================================================
    PROTECTED FUNCTION ObterProxCodigos()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_nProx
        loc_nProx = 1

        TRY
            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF

            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS proxcod FROM SigPcOoP"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MaxCod")
                loc_nProx = cursor_4c_MaxCod.proxcod
            ENDIF

            IF USED("cursor_4c_MaxCod")
                USE IN cursor_4c_MaxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.ObterProxCodigos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nProx
    ENDFUNC

    *==========================================================================
    * SalvarItens - Persiste csDestinos e csDestinoG no banco
    * par_cProcessos : nome do processo
    * par_nCodigos   : PK do processo
    *==========================================================================
    FUNCTION SalvarItens(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves, loc_cFkChaves
        loc_lSucesso = .F.

        TRY
            *-- Limpa filhos anteriores
            loc_cSQL = "DELETE FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao limpar SigPcOoI:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_cSQL = "DELETE FROM SigPcOog WHERE processos = " + EscaparSQL(par_cProcessos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao limpar SigPcOog:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("csDestinos")
                        SELECT csDestinos
                        SCAN
                            IF !EMPTY(ALLTRIM(csDestinos.Drives)) AND csDestinos.TpProdutos <> 0
                                loc_cCidChaves = fUniqueIds()
                                loc_cFkChaves  = loc_cCidChaves

                                loc_cSQL = "INSERT INTO SigPcOoI" + ;
                                    " (processos, emps, dopes, codigos, drives, empds," + ;
                                    "  dopeds, tpprodutos, dias, gruconos, gruconds," + ;
                                    "  agrupar, pctmins, pctmaxs, custos, imagem, barras," + ;
                                    "  novocods, empdests, gdegrupos, cidchaves," + ;
                                    "  franquias, oricompos, cunis, mccrs, delets, chkcons," + ;
                                    "  cortams, desitens, destinos, montaobs, origems," + ;
                                    "  semitens, situas, cheques, mantemmats, mantprods," + ;
                                    "  recalculos, mantdpros, fiscais, impostos, pctcopias," + ;
                                    "  movcparc, movmzeros, opitens, pctcomps, globalizas, moevals, atucli)" + ;
                                    " VALUES (" + ;
                                    EscaparSQL(par_cProcessos)                              + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.Emps))                   + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.Dopes))                  + ", " + ;
                                    FormatarNumeroSQL(par_nCodigos)                        + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.Drives))                 + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.EmpDs))                  + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.DopeDs))                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.TpProdutos)               + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Dias)                     + ", " + ;
                                    FormatarNumeroSQL(csDestinos.GruconOs)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.GruconDs)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Agrupar)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.PctMins)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.PctMaxs)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Custos)                   + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Imagem)                   + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Barras)                   + ", " + ;
                                    FormatarNumeroSQL(csDestinos.NovoCods)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.EmpDests)                 + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.GdeGrupos))              + ", " + ;
                                    EscaparSQL(loc_cCidChaves)                             + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Franquias)                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.OriCompos)                + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.CUnis))                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Mccrs)                    + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Delets)                   + ", " + ;
                                    FormatarNumeroSQL(csDestinos.ChkCons)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.CorTams)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.DesItens)                 + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.Destinos))               + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MontaObs)                 + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.Origems))                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.SemItens)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Situas)                   + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Cheques)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MantemMats)               + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MantProds)                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Recalculos)               + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MantDPros)                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Fiscais)                  + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Impostos)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.PctCopias)                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MovcParc)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MovMZeros)                + ", " + ;
                                    EscaparSQL(ALLTRIM(csDestinos.OpItens))                + ", " + ;
                                    FormatarNumeroSQL(csDestinos.pctcomps)                 + ", " + ;
                                    FormatarNumeroSQL(csDestinos.Globalizas)               + ", " + ;
                                    FormatarNumeroSQL(csDestinos.MoeVals)                  + ", " + ;
                                    "0)"

                                SQLEXEC(gnConnHandle, loc_cSQL)

                                *-- Grupos correspondentes do csDestinoG
                                IF USED("csDestinoG")
                                    LOCAL loc_cIdRef
                                    loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
                                    SELECT csDestinoG
                                    SCAN FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef ;
                                            AND (!EMPTY(ALLTRIM(csDestinoG.Mercs)) OR !EMPTY(ALLTRIM(csDestinoG.Cgrus)))
                                        loc_cSQL = "INSERT INTO SigPcOog" + ;
                                            " (processos, cidchaves, cunis, fkchaves, mercs, cgrus)" + ;
                                            " VALUES (" + ;
                                            EscaparSQL(par_cProcessos)                           + ", " + ;
                                            EscaparSQL(fUniqueIds())                              + ", " + ;
                                            EscaparSQL(ALLTRIM(csDestinoG.CUnis))                + ", " + ;
                                            EscaparSQL(loc_cFkChaves)                             + ", " + ;
                                            EscaparSQL(ALLTRIM(csDestinoG.Mercs))                + ", " + ;
                                            EscaparSQL(ALLTRIM(csDestinoG.Cgrus))                + ")"
                                        SQLEXEC(gnConnHandle, loc_cSQL)
                                    ENDSCAN
                                    SELECT csDestinos
                                ENDIF
                            ENDIF
                        ENDSCAN
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Cursor csDestinos n" + CHR(227) + "o encontrado.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.SalvarItens:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AtualizarSigCdPrg - Registra/atualiza entrada em SigCdPrg
    *==========================================================================
    FUNCTION AtualizarSigCdPrg(par_cProcessos, par_nCodigos)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cProg, loc_cParam
        loc_lSucesso = .F.

        TRY
            loc_cProg  = PADR("SIGCDPRC", 15)
            loc_cParam = PADL(TRANSFORM(par_nCodigos), 10, "0")

            loc_cSQL = "DELETE FROM SigCdPrg" + ;
                       " WHERE programas = " + EscaparSQL(loc_cProg) + ;
                       " AND parametros = " + EscaparSQL(loc_cParam)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "INSERT INTO SigCdPrg (programas, parametros, descricaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cProg)                   + ", " + ;
                       EscaparSQL(loc_cParam)                  + ", " + ;
                       EscaparSQL(ALLTRIM(par_cProcessos))     + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar SigCdPrg:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em prcBO.AtualizarSigCdPrg:" + CHR(13) + loc_oErro.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

