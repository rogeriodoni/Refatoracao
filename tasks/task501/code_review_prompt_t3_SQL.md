# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, PROCESSOS, FKCHAVES, FISCAIS, PROGRAMAS, PARAMETROS

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formprc.prg) - TRECHOS RELEVANTES PARA PASS SQL (3929 linhas total):

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
87: 
88:                 *-- Propaga caption para labels de titulo
89:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
90:                 IF VARTYPE(loc_oCab) = "O"
91:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
92:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
93:                     ENDIF
94:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
95:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
96:                     ENDIF

*-- Linhas 363 a 381:
363:             .HighlightBackColor = RGB(255, 255, 255)
364:             .HighlightForeColor = RGB(15, 41, 104)
365:             .HighlightStyle     = 2
366:             .DeleteMark         = .F.
367:             .RecordMark         = .F.
368:             .RowHeight          = 16
369:             .ScrollBars         = 2
370:             .GridLines          = 3
371:             .ReadOnly           = .T.
372:             .Visible            = .T.
373:             .Column1.Width      = 200
374:             .Column1.ReadOnly   = .T.
375:             .Column1.Header1.Caption = "Processo"
376:             .Column2.Width      = 60
377:             .Column2.ReadOnly   = .T.
378:             .Column2.Header1.Caption = "Emp"
379:             .Column3.Width      = 80
380:             .Column3.ReadOnly   = .T.
381:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"

*-- Linhas 830 a 970:
830:             .HighlightBackColor = RGB(255, 255, 255)
831:             .HighlightForeColor = RGB(15, 41, 104)
832:             .HighlightStyle     = 2
833:             .DeleteMark         = .F.
834:             .RecordMark         = .F.
835:             .RowHeight          = 16
836:             .ScrollBars         = 3
837:             .GridLines          = 3
838:             .ReadOnly           = .F.
839:             .Visible            = .T.
840: 
841:             *-- Col1: EmpDs
842:             .Column1.Width          = 40
843:             .Column1.ControlSource  = "csDestinos.EmpDs"
844:             .Column1.Header1.Caption = "Emp"
845: 
846:             *-- Col2: Drives
847:             .Column2.Width          = 80
848:             .Column2.ControlSource  = "csDestinos.Drives"
849:             .Column2.Header1.Caption = "Local"
850: 
851:             *-- Col3: DopeDs
852:             .Column3.Width          = 80
853:             .Column3.ControlSource  = "csDestinos.DopeDs"
854:             .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o no Destino"
855: 
856:             *-- Col4: TpProdutos
857:             .Column4.Width          = 45
858:             .Column4.ControlSource  = "csDestinos.TpProdutos"
859:             .Column4.Alignment      = 2
860:             .Column4.Header1.Caption = "Produto"
861: 
862:             *-- Col5: Dias
863:             .Column5.Width          = 35
864:             .Column5.ControlSource  = "csDestinos.Dias"
865:             .Column5.Alignment      = 2
866:             .Column5.Header1.Caption = "Dias"
867: 
868:             *-- Col6: PctMins
869:             .Column6.Width          = 75
870:             .Column6.ControlSource  = "csDestinos.PctMins"
871:             .Column6.Alignment      = 2
872:             .Column6.Header1.Caption = "Margem M" + CHR(237) + "n."
873: 
874:             *-- Col7: PctMaxs
875:             .Column7.Width          = 75
876:             .Column7.ControlSource  = "csDestinos.PctMaxs"
877:             .Column7.Alignment      = 2
878:             .Column7.Header1.Caption = "Margem M" + CHR(225) + "x."
879: 
880:             *-- Col8: GdeGrupos
881:             .Column8.Width          = 40
882:             .Column8.ControlSource  = "csDestinos.GdeGrupos"
883:             .Column8.Header1.Caption = "GGpr"
884: 
885:             *-- Col9: Emps (origem)
886:             .Column9.Width          = 35
887:             .Column9.ControlSource  = "csDestinos.Emps"
888:             .Column9.Header1.Caption = "Emp"
889: 
890:             *-- Col10: Dopes (operacao origem)
891:             .Column10.Width          = 75
892:             .Column10.ControlSource  = "csDestinos.Dopes"
893:             .Column10.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o na Origem"
894: 
895:             *-- Col11: CUnis
896:             .Column11.Width          = 35
897:             .Column11.ControlSource  = "csDestinos.CUnis"
898:             .Column11.Header1.Caption = "Uni"
899: 
900:             *-- Col12: Origems
901:             .Column12.Width          = 70
902:             .Column12.ControlSource  = "csDestinos.Origems"
903:             .Column12.Header1.Caption = "Cta.Origem"
904: 
905:             *-- Col13: Destinos
906:             .Column13.Width          = 70
907:             .Column13.ControlSource  = "csDestinos.Destinos"
908:             .Column13.Header1.Caption = "Cta.Destino"
909: 
910:             *-- Col14: SemItens (CheckBox)
911:             .Column14.Width          = 55
912:             .Column14.ControlSource  = "csDestinos.SemItens"
913:             .Column14.Sparse         = .F.
914:             .Column14.Header1.Caption = "Sem " + CHR(205) + "tens"
915:             .Column14.AddObject("Check1", "CheckBox")
916:             WITH .Column14.Check1
917:                 .Alignment  = 0
918:                 .ReadOnly   = .F.
919:                 .Visible    = .T.
920:                 .Top        = 9
921:                 .Left       = 2
922:                 .Height     = 17
923:                 .Width      = 22
924:             ENDWITH
925: 
926:             *-- Col15: Fiscais (CheckBox)
927:             .Column15.Width          = 45
928:             .Column15.ControlSource  = "csDestinos.Fiscais"
929:             .Column15.Sparse         = .F.
930:             .Column15.Header1.Caption = "Fiscal"
931:             .Column15.AddObject("Check1", "CheckBox")
932:             WITH .Column15.Check1
933:                 .Alignment  = 0
934:                 .ReadOnly   = .F.
935:                 .Visible    = .T.
936:                 .Top        = 9
937:                 .Left       = 2
938:                 .Height     = 17
939:                 .Width      = 22
940:             ENDWITH
941: 
942:             *-- Col16: PctCopias
943:             .Column16.Width          = 70
944:             .Column16.ControlSource  = "csDestinos.PctCopias"
945:             .Column16.Alignment      = 2
946:             .Column16.Header1.Caption = "% Produto / $"
947: 
948:             *-- Col17: OpItens
949:             .Column17.Width          = 50
950:             .Column17.ControlSource  = "csDestinos.OpItens"
951:             .Column17.Header1.Caption = "Op Itens"
952: 
953:             *-- Col18: pctcomps
954:             .Column18.Width          = 60
955:             .Column18.ControlSource  = "csDestinos.pctcomps"
956:             .Column18.Alignment      = 2
957:             .Column18.Header1.Caption = "% Compos."
958:         ENDWITH
959: 
960:         *-- Botao copiar linha atual do grdDestinos
961:         loc_oPagina.AddObject("cmd_4c_CopOpe", "CommandButton")
962:         WITH loc_oPagina.cmd_4c_CopOpe
963:             .Caption       = "Copiar"
964:             .Top           = 325
965:             .Left          = 738
966:             .Width         = 55
967:             .Height        = 59
968:             .BackColor     = RGB(255, 255, 255)
969:             .ForeColor     = RGB(90, 90, 90)
970:             .FontName      = "Tahoma"

*-- Linhas 2357 a 2389:
2357:             .HighlightBackColor = RGB(255, 255, 255)
2358:             .HighlightForeColor = RGB(15, 41, 104)
2359:             .HighlightStyle     = 2
2360:             .DeleteMark         = .F.
2361:             .RecordMark         = .F.
2362:             .RowHeight          = 16
2363:             .ScrollBars         = 2
2364:             .GridLines          = 3
2365:             .ReadOnly           = .F.
2366:             .Visible            = .T.
2367:             .Column1.Width         = 40
2368:             .Column1.ControlSource = "csDestinoG.Mercs"
2369:             .Column1.Header1.Caption = "G.Grp."
2370:             .Column2.Width         = 40
2371:             .Column2.ControlSource = "csDestinoG.CUnis"
2372:             .Column2.Header1.Caption = "Uni"
2373:             .Column3.Width         = 55
2374:             .Column3.ControlSource = "csDestinoG.Cgrus"
2375:             .Column3.Header1.Caption = "Grupo"
2376:         ENDWITH
2377: 
2378:         *-- BINDEVENTs Page2
2379:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
2380:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
2381:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoInserir, "Click", THIS, "BtnCompoInserirClick")
2382:         BINDEVENT(loc_oPagina.cnt_4c_CompoOp.cmd_4c_CompoExcluir, "Click", THIS, "BtnCompoExcluirClick")
2383:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpInserir,    "Click", THIS, "BtnGrpInserirClick")
2384:         BINDEVENT(loc_oPagina.cnt_4c_CompoG.cmd_4c_GrpExcluir,    "Click", THIS, "BtnGrpExcluirClick")
2385:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "AfterRowColChange", THIS, "GrdDestinosAfterRowColChange")
2386:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "KeyPress", THIS, "GrdDestinosKeyPress")
2387:         BINDEVENT(loc_oPagina.grd_4c_Destinos, "DblClick", THIS, "GrdDestinosDblClick")
2388:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "KeyPress", THIS, "GrdDestinoGKeyPress")
2389:         BINDEVENT(loc_oPagina.grd_4c_DestinoG, "DblClick", THIS, "GrdDestinoGDblClick")

*-- Linhas 2403 a 2433:
2403:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2404:                 IF !USED("cursor_4c_Dados")
2405:                     SET NULL ON
2406:                     CREATE CURSOR cursor_4c_Dados (processos c(20), emps c(3), codigos n(6,0))
2407:                     SET NULL OFF
2408:                 ENDIF
2409:                 loc_lResultado = .T.
2410:             ELSE
2411:                 IF THIS.this_oBusinessObject.Buscar("")
2412:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2413:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2414:                         loc_oGrid.ColumnCount = 3
2415:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2416:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
2417:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2418:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
2419:                         loc_oGrid.Column1.Header1.Caption = "Processo"
2420:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2421:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
2422:                         THIS.FormatarGridLista(loc_oGrid)
2423:                     ENDIF
2424:                     loc_lResultado = .T.
2425:                 ENDIF
2426:             ENDIF
2427:         CATCH TO loc_oErro
2428:             MsgErro("Erro em Formprc.CarregarLista:" + CHR(13) + loc_oErro.Message + ;
2429:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2430:         ENDTRY
2431: 
2432:         RETURN loc_lResultado
2433:     ENDPROC

*-- Linhas 2463 a 2481:
2463:                 ELSE
2464:                     IF THIS.this_cModoAtual = "INCLUIR"
2465:                     *-- Linha padrao vazia para o modo inserir
2466:                     SELECT csDestinos
2467:                     APPEND BLANK
2468:                     ENDIF
2469:                 ENDIF
2470: 
2471:                 THIS.RefrescarOpcoesDoItem()
2472:                 THIS.AtualizarEstadoCampos()
2473:             ENDIF
2474: 
2475:             loc_lResultado = .T.
2476:         CATCH TO loc_oErro
2477:             MsgErro("Erro em Formprc.AlternarPagina:" + CHR(13) + loc_oErro.Message + ;
2478:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2479:         ENDTRY
2480: 
2481:         RETURN loc_lResultado

*-- Linhas 2494 a 2521:
2494:                 USE IN cursor_4c_OoI
2495:             ENDIF
2496: 
2497:             loc_cSQL = "SELECT * FROM SigPcOoI WHERE processos = " + EscaparSQL(par_cProcessos)
2498:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OoI")
2499: 
2500:             IF loc_nResult >= 0
2501:                 SELECT csDestinos
2502:                 ZAP
2503:                 SELECT cursor_4c_OoI
2504:                 SCAN
2505:                     loc_cCidChaves = ALLTRIM(cursor_4c_OoI.cidchaves)
2506:                     INSERT INTO csDestinos (Processos, Codigos, Drives, Emps, Dopes, EmpDs, DopeDs, ;
2507:                                             TpProdutos, Dias, GruconOs, GruconDs, EmpDests, Agrupar, ;
2508:                                             NovoCods, CorTams, MoeVals, Situas, Franquias, PctMins, PctMaxs, ;
2509:                                             Custos, Impostos, Imagem, MantProds, Barras, Mccrs, Cheques, ;
2510:                                             Delets, DesItens, MontaObs, ChkCons, MantemMats, MantDPros, ;
2511:                                             GdeGrupos, CUnis, OriCompos, Origems, Destinos, SemItens, Fiscais, ;
2512:                                             Recalculos, PctCopias, OpItens, cIdChaves, MovMZeros, MovcParc, ;
2513:                                             pctcomps, Globalizas) ;
2514:                            VALUES (TratarNulo(cursor_4c_OoI.processos,""), ;
2515:                                    TratarNulo(cursor_4c_OoI.codigos,0), ;
2516:                                    TratarNulo(cursor_4c_OoI.drives,""), ;
2517:                                    TratarNulo(cursor_4c_OoI.emps,""), ;
2518:                                    TratarNulo(cursor_4c_OoI.dopes,""), ;
2519:                                    TratarNulo(cursor_4c_OoI.empds,""), ;
2520:                                    TratarNulo(cursor_4c_OoI.dopeds,""), ;
2521:                                    TratarNulo(cursor_4c_OoI.tpprodutos,0), ;

*-- Linhas 2565 a 2606:
2565:                         USE IN cursor_4c_OoG
2566:                     ENDIF
2567:                     LOCAL loc_cSQLG, loc_nResG
2568:                     loc_cSQLG = "SELECT * FROM SigPcOog WHERE fkchaves = " + EscaparSQL(loc_cCidChaves)
2569:                     loc_nResG = SQLEXEC(gnConnHandle, loc_cSQLG, "cursor_4c_OoG")
2570:                     IF loc_nResG >= 0
2571:                         SELECT cursor_4c_OoG
2572:                         SCAN
2573:                             INSERT INTO csDestinoG (Processos, Mercs, CUnis, fkChaves, Cgrus) ;
2574:                                 VALUES (TratarNulo(cursor_4c_OoG.processos,""), ;
2575:                                         TratarNulo(cursor_4c_OoG.mercs,""), ;
2576:                                         TratarNulo(cursor_4c_OoG.cunis,""), ;
2577:                                         loc_cCidChaves, ;
2578:                                         TratarNulo(cursor_4c_OoG.cgrus,""))
2579:                         ENDSCAN
2580:                         IF USED("cursor_4c_OoG")
2581:                             USE IN cursor_4c_OoG
2582:                         ENDIF
2583:                     ENDIF
2584:                     SELECT cursor_4c_OoI
2585:                 ENDSCAN
2586: 
2587:                 IF USED("cursor_4c_OoI")
2588:                     USE IN cursor_4c_OoI
2589:                 ENDIF
2590: 
2591:                 SELECT csDestinos
2592:                 IF RECCOUNT("csDestinos") > 0
2593:                     GO TOP IN csDestinos
2594:                 ENDIF
2595: 
2596:                 loc_lResultado = .T.
2597:             ELSE
2598:                 MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
2599:             ENDIF
2600:         CATCH TO loc_oErro
2601:             MsgErro("Erro em Formprc.CarregarItens:" + CHR(13) + loc_oErro.Message + ;
2602:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
2603:         ENDTRY
2604: 
2605:         RETURN loc_lResultado
2606:     ENDPROC

*-- Linhas 2624 a 2642:
2624:         ENDIF
2625: 
2626:         TRY
2627:             SELECT csDestinos
2628: 
2629:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
2630:                 loc_nVal = csDestinos.GruconOs
2631:                 loc_oPg2.obj_4c_OptGruConOs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2632:             ENDIF
2633:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
2634:                 loc_nVal = csDestinos.GruconDs
2635:                 loc_oPg2.obj_4c_OptGruConDs.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2636:             ENDIF
2637:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
2638:                 loc_nVal = csDestinos.Agrupar
2639:                 loc_oPg2.obj_4c_OptAgrupar.Value = IIF(loc_nVal > 0, loc_nVal, 1)
2640:             ENDIF
2641:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
2642:                 loc_nVal = csDestinos.Franquias

*-- Linhas 2756 a 2774:
2756:         ENDIF
2757: 
2758:         TRY
2759:             SELECT csDestinos
2760:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConOs", 5)
2761:                 REPLACE csDestinos.GruconOs WITH loc_oPg2.obj_4c_OptGruConOs.Value
2762:             ENDIF
2763:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptGruConDs", 5)
2764:                 REPLACE csDestinos.GruconDs WITH loc_oPg2.obj_4c_OptGruConDs.Value
2765:             ENDIF
2766:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptAgrupar", 5)
2767:                 REPLACE csDestinos.Agrupar WITH loc_oPg2.obj_4c_OptAgrupar.Value
2768:             ENDIF
2769:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptFranquia", 5)
2770:                 REPLACE csDestinos.Franquias WITH loc_oPg2.obj_4c_OptFranquia.Value
2771:             ENDIF
2772:             IF PEMSTATUS(loc_oPg2, "obj_4c_OptCustos", 5)
2773:                 REPLACE csDestinos.Custos WITH loc_oPg2.obj_4c_OptCustos.Value
2774:             ENDIF

*-- Linhas 3087 a 3105:
3087:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3088:                 MsgAviso("Selecione um registro na lista.", "Visualizar")
3089:             ELSE
3090:                 SELECT cursor_4c_Dados
3091:                 IF EOF("cursor_4c_Dados")
3092:                     MsgAviso("Selecione um registro na lista.", "Visualizar")
3093:                 ELSE
3094:                     loc_nCodigos = cursor_4c_Dados.codigos
3095:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
3096:                         THIS.this_cModoAtual     = "VISUALIZAR"
3097:                         THIS.this_nPkAtual       = loc_nCodigos
3098:                         THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
3099:                         THIS.BOParaForm()
3100:                         THIS.AtualizarEstadoCampos()
3101:                         THIS.AlternarPagina(2)
3102:                     ELSE
3103:                         MsgErro("Erro ao carregar registro!", "Visualizar")
3104:                     ENDIF
3105:                 ENDIF

*-- Linhas 3120 a 3138:
3120:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3121:                 MsgAviso("Selecione um registro na lista.", "Alterar")
3122:             ELSE
3123:                 SELECT cursor_4c_Dados
3124:                 IF EOF("cursor_4c_Dados")
3125:                     MsgAviso("Selecione um registro na lista.", "Alterar")
3126:                 ELSE
3127:                     loc_nCodigos = cursor_4c_Dados.codigos
3128:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
3129:                         THIS.this_oBusinessObject.EditarRegistro()
3130:                         THIS.this_cModoAtual     = "ALTERAR"
3131:                         THIS.this_nPkAtual       = loc_nCodigos
3132:                         THIS.this_cProcessoAtual = ALLTRIM(THIS.this_oBusinessObject.this_cProcessos)
3133:                         THIS.BOParaForm()
3134:                         THIS.AtualizarEstadoCampos()
3135:                         THIS.AlternarPagina(2)
3136:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Toleras", 5)
3137:                             THIS.pgf_4c_Paginas.Page2.txt_4c_Toleras.SetFocus()
3138:                         ENDIF

*-- Linhas 3157 a 3175:
3157:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
3158:                 MsgAviso("Selecione um registro na lista.", "Excluir")
3159:             ELSE
3160:                 SELECT cursor_4c_Dados
3161:                 IF EOF("cursor_4c_Dados")
3162:                     MsgAviso("Selecione um registro na lista.", "Excluir")
3163:                 ELSE
3164:                     loc_nCodigos = cursor_4c_Dados.codigos
3165:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste processo?", ;
3166:                                    "Confirmar Exclus" + CHR(227) + "o")
3167:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
3168:                             IF THIS.this_oBusinessObject.Excluir()
3169:                                 MsgInfo("Processo exclu" + CHR(237) + "do com sucesso!", ;
3170:                                         "Exclu" + CHR(237) + "do")
3171:                                 THIS.CarregarLista()
3172:                             ELSE
3173:                                 MsgErro("Erro ao excluir processo!", "Excluir")
3174:                             ENDIF
3175:                         ELSE

*-- Linhas 3193 a 3219:
3193: 
3194:         TRY
3195:             IF !EMPTY(ALLTRIM(loc_cTermoBusca))
3196:                 loc_cFiltro = "processos LIKE " + EscaparSQL(ALLTRIM(loc_cTermoBusca) + "%")
3197:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3198:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
3199:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3200:                         loc_oGrid.ColumnCount = 3
3201:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
3202:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.processos"
3203:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
3204:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.codigos"
3205:                         loc_oGrid.Column1.Header1.Caption = "Processo"
3206:                         loc_oGrid.Column2.Header1.Caption = "Emp"
3207:                         loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
3208:                         THIS.FormatarGridLista(loc_oGrid)
3209:                     ENDIF
3210:                 ENDIF
3211:             ELSE
3212:                 THIS.CarregarLista()
3213:             ENDIF
3214:         CATCH TO loc_oErro
3215:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
3216:         ENDTRY
3217:     ENDPROC
3218: 
3219:     *==========================================================================

*-- Linhas 3254 a 3273:
3254:                 IF USED("cursor_4c_ChkProc")
3255:                     USE IN cursor_4c_ChkProc
3256:                 ENDIF
3257:                 loc_cSQL = "SELECT codigos FROM SigPcOoP WHERE processos = " + EscaparSQL(loc_cProcessos)
3258:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProc")
3259:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkProc") > 0
3260:                     MsgAviso("Processo '" + loc_cProcessos + "' j" + CHR(225) + " existe!", ;
3261:                              "Aten" + CHR(231) + CHR(227) + "o")
3262:                     IF USED("cursor_4c_ChkProc")
3263:                         USE IN cursor_4c_ChkProc
3264:                     ENDIF
3265:                     IF PEMSTATUS(loc_oPg2, "txt_4c_Processos", 5)
3266:                         loc_oPg2.txt_4c_Processos.SetFocus()
3267:                     ENDIF
3268:                     RETURN
3269:                 ENDIF
3270:                 IF USED("cursor_4c_ChkProc")
3271:                     USE IN cursor_4c_ChkProc
3272:                 ENDIF
3273:             CATCH TO loc_oErro

*-- Linhas 3281 a 3299:
3281:             IF loc_oPg2.obj_4c_OptFiscal.Value = 1
3282:                 loc_lFiscalOk = .F.
3283:                 IF USED("csDestinos")
3284:                     SELECT csDestinos
3285:                     SCAN
3286:                         IF csDestinos.Fiscais = 1
3287:                             loc_lFiscalOk = .T.
3288:                             EXIT
3289:                         ENDIF
3290:                     ENDSCAN
3291:                 ENDIF
3292:                 IF !loc_lFiscalOk
3293:                     MsgAviso("Fiscal habilitado mas nenhuma linha de destino tem Fiscal marcado!", ;
3294:                              "Aten" + CHR(231) + CHR(227) + "o")
3295:                     RETURN
3296:                 ENDIF
3297:             ENDIF
3298:         ENDIF
3299: 

*-- Linhas 3352 a 3480:
3352:         TRY
3353:             *-- Sincroniza opcoes antes de mover para nova linha
3354:             THIS.SincronizarOpcoesParaItem()
3355:             SELECT csDestinos
3356:             APPEND BLANK
3357:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
3358:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
3359:             ENDIF
3360:             THIS.RefrescarOpcoesDoItem()
3361:         CATCH TO loc_oErro
3362:             MsgErro("Erro em BtnCompoInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3363:         ENDTRY
3364:     ENDPROC
3365: 
3366:     *==========================================================================
3367:     * BtnCompoExcluirClick - Exclui linha atual do csDestinos e seus grupos
3368:     *==========================================================================
3369:     PROCEDURE BtnCompoExcluirClick()
3370:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3371:             RETURN
3372:         ENDIF
3373:         TRY
3374:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
3375:                 LOCAL loc_cIdRef
3376:                 SELECT csDestinos
3377:                 loc_cIdRef = ALLTRIM(csDestinos.cIdChaves)
3378:                 DELETE IN csDestinos
3379:                 PACK IN csDestinos
3380:                 *-- Remove grupos associados
3381:                 IF USED("csDestinoG") AND !EMPTY(loc_cIdRef)
3382:                     SELECT csDestinoG
3383:                     DELETE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdRef
3384:                     PACK IN csDestinoG
3385:                 ENDIF
3386:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
3387:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
3388:                 ENDIF
3389:                 THIS.RefrescarOpcoesDoItem()
3390:             ENDIF
3391:         CATCH TO loc_oErro
3392:             MsgErro("Erro em BtnCompoExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3393:         ENDTRY
3394:     ENDPROC
3395: 
3396:     *==========================================================================
3397:     * BtnGrpInserirClick - Insere nova linha em csDestinoG vinculada ao item atual
3398:     *==========================================================================
3399:     PROCEDURE BtnGrpInserirClick()
3400:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3401:             RETURN
3402:         ENDIF
3403:         TRY
3404:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
3405:                 SELECT csDestinos
3406:                 LOCAL loc_cFk
3407:                 loc_cFk = ALLTRIM(csDestinos.cIdChaves)
3408:                 IF EMPTY(loc_cFk)
3409:                     *-- Atribui novo ID se ainda nao tem
3410:                     loc_cFk = SYS(2015)
3411:                     REPLACE csDestinos.cIdChaves WITH loc_cFk
3412:                 ENDIF
3413:                 INSERT INTO csDestinoG (Processos, fkChaves) ;
3414:                     VALUES (ALLTRIM(csDestinos.Processos), loc_cFk)
3415:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
3416:                     THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
3417:                 ENDIF
3418:             ELSE
3419:                 MsgAviso("Selecione um item de destino primeiro.", "Aten" + CHR(231) + CHR(227) + "o")
3420:             ENDIF
3421:         CATCH TO loc_oErro
3422:             MsgErro("Erro em BtnGrpInserirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3423:         ENDTRY
3424:     ENDPROC
3425: 
3426:     *==========================================================================
3427:     * BtnGrpExcluirClick - Exclui linha atual de csDestinoG
3428:     *==========================================================================
3429:     PROCEDURE BtnGrpExcluirClick()
3430:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3431:             RETURN
3432:         ENDIF
3433:         TRY
3434:             IF USED("csDestinoG") AND RECCOUNT("csDestinoG") > 0 AND !EOF("csDestinoG")
3435:                 SELECT csDestinoG
3436:                 DELETE IN csDestinoG
3437:                 PACK IN csDestinoG
3438:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_DestinoG", 5)
3439:                     THIS.pgf_4c_Paginas.Page2.grd_4c_DestinoG.Refresh()
3440:                 ENDIF
3441:             ENDIF
3442:         CATCH TO loc_oErro
3443:             MsgErro("Erro em BtnGrpExcluirClick:" + CHR(13) + loc_oErro.Message, "Erro")
3444:         ENDTRY
3445:     ENDPROC
3446: 
3447:     *==========================================================================
3448:     * BtnCopOpeClick - Copia linha atual do csDestinos e seus grupos
3449:     *==========================================================================
3450:     PROCEDURE BtnCopOpeClick()
3451:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3452:             RETURN
3453:         ENDIF
3454:         TRY
3455:             IF USED("csDestinos") AND RECCOUNT("csDestinos") > 0 AND !EOF("csDestinos")
3456:                 LOCAL loc_cIdAntigo, loc_cIdNovo
3457:                 SELECT csDestinos
3458:                 loc_cIdAntigo = ALLTRIM(csDestinos.cIdChaves)
3459:                 loc_cIdNovo   = SYS(2015)
3460:                 SCATTER MEMVAR MEMO
3461:                 APPEND BLANK
3462:                 GATHER MEMVAR MEMO
3463:                 REPLACE csDestinos.cIdChaves WITH loc_cIdNovo
3464:                 IF USED("csDestinoG") AND !EMPTY(loc_cIdAntigo)
3465:                     SELECT csDestinoG
3466:                     LOCATE FOR ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
3467:                     DO WHILE !EOF("csDestinoG") AND ALLTRIM(csDestinoG.fkChaves) == loc_cIdAntigo
3468:                         SCATTER MEMVAR MEMO
3469:                         APPEND BLANK
3470:                         GATHER MEMVAR MEMO
3471:                         REPLACE csDestinoG.fkChaves WITH loc_cIdNovo
3472:                         SKIP
3473:                     ENDDO
3474:                 ENDIF
3475:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Destinos", 5)
3476:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Destinos.Refresh()
3477:                 ENDIF
3478:             ELSE
3479:                 MsgAviso("Selecione um item para copiar.", "Aten" + CHR(231) + CHR(227) + "o")
3480:             ENDIF

*-- Linhas 3585 a 3618:
3585:             IF USED("cursor_4c_BuscaDrives")
3586:                 USE IN cursor_4c_BuscaDrives
3587:             ENDIF
3588:             loc_nResult = SQLEXEC(gnConnHandle, ;
3589:                 "SELECT cods, drives FROM SigCdLoc ORDER BY cods", ;
3590:                 "cursor_4c_BuscaDrives")
3591:             IF loc_nResult < 0
3592:                 MsgErro("Erro ao buscar Locais/Drives.", "Erro")
3593:                 RETURN
3594:             ENDIF
3595:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3596:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDrives"
3597:             loc_oBusca.DefinirCursor("cursor_4c_BuscaDrives", "cods", "drives", ;
3598:                 "Buscar Local/Drive")
3599:             loc_oBusca.Mostrar()
3600:             IF loc_oBusca.this_lSelecionou
3601:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3602:                 IF USED("csDestinos") AND !EOF("csDestinos")
3603:                     SELECT csDestinos
3604:                     REPLACE csDestinos.Drives WITH loc_cSelecionado
3605:                     loc_oGrid.Refresh()
3606:                 ENDIF
3607:             ENDIF
3608:             IF USED("cursor_4c_BuscaDrives")
3609:                 USE IN cursor_4c_BuscaDrives
3610:             ENDIF
3611:             loc_oBusca.Release()
3612:         CATCH TO loc_oErro
3613:             MsgErro("Erro em AbrirLookupDrives:" + CHR(13) + loc_oErro.Message, "Erro")
3614:         ENDTRY
3615:     ENDPROC
3616: 
3617:     *==========================================================================
3618:     * AbrirLookupOperacaoDestino - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.DopeDs

*-- Linhas 3624 a 3657:
3624:             IF USED("cursor_4c_BuscaOpeDs")
3625:                 USE IN cursor_4c_BuscaOpeDs
3626:             ENDIF
3627:             loc_nResult = SQLEXEC(gnConnHandle, ;
3628:                 "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
3629:                 "cursor_4c_BuscaOpeDs")
3630:             IF loc_nResult < 0
3631:                 MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
3632:                 RETURN
3633:             ENDIF
3634:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3635:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpeDs"
3636:             loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeDs", "Dopes", "Dopes", ;
3637:                 "Buscar Opera" + CHR(231) + CHR(227) + "o Destino")
3638:             loc_oBusca.Mostrar()
3639:             IF loc_oBusca.this_lSelecionou
3640:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3641:                 IF USED("csDestinos") AND !EOF("csDestinos")
3642:                     SELECT csDestinos
3643:                     REPLACE csDestinos.DopeDs WITH loc_cSelecionado
3644:                     loc_oGrid.Refresh()
3645:                 ENDIF
3646:             ENDIF
3647:             IF USED("cursor_4c_BuscaOpeDs")
3648:                 USE IN cursor_4c_BuscaOpeDs
3649:             ENDIF
3650:             loc_oBusca.Release()
3651:         CATCH TO loc_oErro
3652:             MsgErro("Erro em AbrirLookupOperacaoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3653:         ENDTRY
3654:     ENDPROC
3655: 
3656:     *==========================================================================
3657:     * AbrirLookupGrandeGrupoDestino - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinos.GdeGrupos

*-- Linhas 3663 a 3696:
3663:             IF USED("cursor_4c_BuscaGdeGrp")
3664:                 USE IN cursor_4c_BuscaGdeGrp
3665:             ENDIF
3666:             loc_nResult = SQLEXEC(gnConnHandle, ;
3667:                 "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
3668:                 "cursor_4c_BuscaGdeGrp")
3669:             IF loc_nResult < 0
3670:                 MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
3671:                 RETURN
3672:             ENDIF
3673:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3674:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGdeGrp"
3675:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrp", "codigos", "descs", ;
3676:                 "Buscar Grande Grupo")
3677:             loc_oBusca.Mostrar()
3678:             IF loc_oBusca.this_lSelecionou
3679:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3680:                 IF USED("csDestinos") AND !EOF("csDestinos")
3681:                     SELECT csDestinos
3682:                     REPLACE csDestinos.GdeGrupos WITH loc_cSelecionado
3683:                     loc_oGrid.Refresh()
3684:                 ENDIF
3685:             ENDIF
3686:             IF USED("cursor_4c_BuscaGdeGrp")
3687:                 USE IN cursor_4c_BuscaGdeGrp
3688:             ENDIF
3689:             loc_oBusca.Release()
3690:         CATCH TO loc_oErro
3691:             MsgErro("Erro em AbrirLookupGrandeGrupoDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3692:         ENDTRY
3693:     ENDPROC
3694: 
3695:     *==========================================================================
3696:     * AbrirLookupEmpresaDestino - Busca Empresa (SigCdEmp.Cemps) -> csDestinos.Emps

*-- Linhas 3702 a 3735:
3702:             IF USED("cursor_4c_BuscaEmpOr")
3703:                 USE IN cursor_4c_BuscaEmpOr
3704:             ENDIF
3705:             loc_nResult = SQLEXEC(gnConnHandle, ;
3706:                 "SELECT Cemps, Razas FROM SigCdEmp ORDER BY Cemps", ;
3707:                 "cursor_4c_BuscaEmpOr")
3708:             IF loc_nResult < 0
3709:                 MsgErro("Erro ao buscar Empresas.", "Erro")
3710:                 RETURN
3711:             ENDIF
3712:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3713:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpOr"
3714:             loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpOr", "Cemps", "Razas", ;
3715:                 "Buscar Empresa Origem")
3716:             loc_oBusca.Mostrar()
3717:             IF loc_oBusca.this_lSelecionou
3718:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3719:                 IF USED("csDestinos") AND !EOF("csDestinos")
3720:                     SELECT csDestinos
3721:                     REPLACE csDestinos.Emps WITH loc_cSelecionado
3722:                     loc_oGrid.Refresh()
3723:                 ENDIF
3724:             ENDIF
3725:             IF USED("cursor_4c_BuscaEmpOr")
3726:                 USE IN cursor_4c_BuscaEmpOr
3727:             ENDIF
3728:             loc_oBusca.Release()
3729:         CATCH TO loc_oErro
3730:             MsgErro("Erro em AbrirLookupEmpresaDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3731:         ENDTRY
3732:     ENDPROC
3733: 
3734:     *==========================================================================
3735:     * AbrirLookupOperacaoOrigem - Busca Operacao (SigCdOpe.Dopes) -> csDestinos.Dopes

*-- Linhas 3741 a 3774:
3741:             IF USED("cursor_4c_BuscaOpeOr")
3742:                 USE IN cursor_4c_BuscaOpeOr
3743:             ENDIF
3744:             loc_nResult = SQLEXEC(gnConnHandle, ;
3745:                 "SELECT Dopes FROM SigCdOpe ORDER BY Dopes", ;
3746:                 "cursor_4c_BuscaOpeOr")
3747:             IF loc_nResult < 0
3748:                 MsgErro("Erro ao buscar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
3749:                 RETURN
3750:             ENDIF
3751:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3752:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaOpeOr"
3753:             loc_oBusca.DefinirCursor("cursor_4c_BuscaOpeOr", "Dopes", "Dopes", ;
3754:                 "Buscar Opera" + CHR(231) + CHR(227) + "o Origem")
3755:             loc_oBusca.Mostrar()
3756:             IF loc_oBusca.this_lSelecionou
3757:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3758:                 IF USED("csDestinos") AND !EOF("csDestinos")
3759:                     SELECT csDestinos
3760:                     REPLACE csDestinos.Dopes WITH loc_cSelecionado
3761:                     loc_oGrid.Refresh()
3762:                 ENDIF
3763:             ENDIF
3764:             IF USED("cursor_4c_BuscaOpeOr")
3765:                 USE IN cursor_4c_BuscaOpeOr
3766:             ENDIF
3767:             loc_oBusca.Release()
3768:         CATCH TO loc_oErro
3769:             MsgErro("Erro em AbrirLookupOperacaoOrigem:" + CHR(13) + loc_oErro.Message, "Erro")
3770:         ENDTRY
3771:     ENDPROC
3772: 
3773:     *==========================================================================
3774:     * AbrirLookupUnidadeDestino - Busca Unidade (SigCdUni.CUnis) -> csDestinos.CUnis

*-- Linhas 3780 a 3813:
3780:             IF USED("cursor_4c_BuscaUni")
3781:                 USE IN cursor_4c_BuscaUni
3782:             ENDIF
3783:             loc_nResult = SQLEXEC(gnConnHandle, ;
3784:                 "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
3785:                 "cursor_4c_BuscaUni")
3786:             IF loc_nResult < 0
3787:                 MsgErro("Erro ao buscar Unidades.", "Erro")
3788:                 RETURN
3789:             ENDIF
3790:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3791:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUni"
3792:             loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", ;
3793:                 "Buscar Unidade")
3794:             loc_oBusca.Mostrar()
3795:             IF loc_oBusca.this_lSelecionou
3796:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3797:                 IF USED("csDestinos") AND !EOF("csDestinos")
3798:                     SELECT csDestinos
3799:                     REPLACE csDestinos.CUnis WITH loc_cSelecionado
3800:                     loc_oGrid.Refresh()
3801:                 ENDIF
3802:             ENDIF
3803:             IF USED("cursor_4c_BuscaUni")
3804:                 USE IN cursor_4c_BuscaUni
3805:             ENDIF
3806:             loc_oBusca.Release()
3807:         CATCH TO loc_oErro
3808:             MsgErro("Erro em AbrirLookupUnidadeDestino:" + CHR(13) + loc_oErro.Message, "Erro")
3809:         ENDTRY
3810:     ENDPROC
3811: 
3812:     *==========================================================================
3813:     * AbrirLookupGrandeGrupoG - Busca Grande Grupo (SigCdGpr.codigos) -> csDestinoG.Mercs

*-- Linhas 3819 a 3852:
3819:             IF USED("cursor_4c_BuscaGdeGrpG")
3820:                 USE IN cursor_4c_BuscaGdeGrpG
3821:             ENDIF
3822:             loc_nResult = SQLEXEC(gnConnHandle, ;
3823:                 "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
3824:                 "cursor_4c_BuscaGdeGrpG")
3825:             IF loc_nResult < 0
3826:                 MsgErro("Erro ao buscar Grandes Grupos.", "Erro")
3827:                 RETURN
3828:             ENDIF
3829:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3830:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGdeGrpG"
3831:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGdeGrpG", "codigos", "descs", ;
3832:                 "Buscar Grande Grupo")
3833:             loc_oBusca.Mostrar()
3834:             IF loc_oBusca.this_lSelecionou
3835:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3836:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3837:                     SELECT csDestinoG
3838:                     REPLACE csDestinoG.Mercs WITH loc_cSelecionado
3839:                     loc_oGrid.Refresh()
3840:                 ENDIF
3841:             ENDIF
3842:             IF USED("cursor_4c_BuscaGdeGrpG")
3843:                 USE IN cursor_4c_BuscaGdeGrpG
3844:             ENDIF
3845:             loc_oBusca.Release()
3846:         CATCH TO loc_oErro
3847:             MsgErro("Erro em AbrirLookupGrandeGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
3848:         ENDTRY
3849:     ENDPROC
3850: 
3851:     *==========================================================================
3852:     * AbrirLookupUnidadeG - Busca Unidade (SigCdUni.CUnis) -> csDestinoG.CUnis

*-- Linhas 3858 a 3891:
3858:             IF USED("cursor_4c_BuscaUniG")
3859:                 USE IN cursor_4c_BuscaUniG
3860:             ENDIF
3861:             loc_nResult = SQLEXEC(gnConnHandle, ;
3862:                 "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", ;
3863:                 "cursor_4c_BuscaUniG")
3864:             IF loc_nResult < 0
3865:                 MsgErro("Erro ao buscar Unidades.", "Erro")
3866:                 RETURN
3867:             ENDIF
3868:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3869:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUniG"
3870:             loc_oBusca.DefinirCursor("cursor_4c_BuscaUniG", "CUnis", "DUnis", ;
3871:                 "Buscar Unidade")
3872:             loc_oBusca.Mostrar()
3873:             IF loc_oBusca.this_lSelecionou
3874:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3875:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3876:                     SELECT csDestinoG
3877:                     REPLACE csDestinoG.CUnis WITH loc_cSelecionado
3878:                     loc_oGrid.Refresh()
3879:                 ENDIF
3880:             ENDIF
3881:             IF USED("cursor_4c_BuscaUniG")
3882:                 USE IN cursor_4c_BuscaUniG
3883:             ENDIF
3884:             loc_oBusca.Release()
3885:         CATCH TO loc_oErro
3886:             MsgErro("Erro em AbrirLookupUnidadeG:" + CHR(13) + loc_oErro.Message, "Erro")
3887:         ENDTRY
3888:     ENDPROC
3889: 
3890:     *==========================================================================
3891:     * AbrirLookupGrupoG - Busca Grupo de Produto (SigCdGrp.cgrus) -> csDestinoG.Cgrus

*-- Linhas 3897 a 3929:
3897:             IF USED("cursor_4c_BuscaGrpG")
3898:                 USE IN cursor_4c_BuscaGrpG
3899:             ENDIF
3900:             loc_nResult = SQLEXEC(gnConnHandle, ;
3901:                 "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
3902:                 "cursor_4c_BuscaGrpG")
3903:             IF loc_nResult < 0
3904:                 MsgErro("Erro ao buscar Grupos de Produto.", "Erro")
3905:                 RETURN
3906:             ENDIF
3907:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3908:             loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrpG"
3909:             loc_oBusca.DefinirCursor("cursor_4c_BuscaGrpG", "cgrus", "dgrus", ;
3910:                 "Buscar Grupo de Produto")
3911:             loc_oBusca.Mostrar()
3912:             IF loc_oBusca.this_lSelecionou
3913:                 loc_cSelecionado = ALLTRIM(loc_oBusca.cCodigoSelecionado)
3914:                 IF USED("csDestinoG") AND !EOF("csDestinoG")
3915:                     SELECT csDestinoG
3916:                     REPLACE csDestinoG.Cgrus WITH loc_cSelecionado
3917:                     loc_oGrid.Refresh()
3918:                 ENDIF
3919:             ENDIF
3920:             IF USED("cursor_4c_BuscaGrpG")
3921:                 USE IN cursor_4c_BuscaGrpG
3922:             ENDIF
3923:             loc_oBusca.Release()
3924:         CATCH TO loc_oErro
3925:             MsgErro("Erro em AbrirLookupGrupoG:" + CHR(13) + loc_oErro.Message, "Erro")
3926:         ENDTRY
3927:     ENDPROC
3928: 
3929: ENDDEFINE


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

