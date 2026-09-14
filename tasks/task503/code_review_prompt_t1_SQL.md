# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ECOMMERCE, PROMOS, PCTIPO, CODS, CPROS, CBARS, CIDCHAVES, COLECOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ECOMMERCE, PROMOS, PCTIPO, CODS, CPROS, CBARS, CIDCHAVES, COLECOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LPRECOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ECOMMERCE, PROMOS, PCTIPO, CODS, CPROS, CBARS, CIDCHAVES, COLECOES

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
  ControlSource = "dbprodutos.cpros"
  ControlSource = "dbprodutos.dpros"
  ControlSource = "dbprodutos.pecas"
  DeleteMark = .F.
  ControlSource = "crSigPrPmc.promos"
  ControlSource = "crSigPrPmc.Cods"
  ControlSource = "crSigPrPmc.LPrecos"
  ControlSource = "crSigPrPmc.ecommerce"
  ControlSource = "crSigPrPmc.Incentivs"
  ControlSource = "crSigPrPmc.Comiss"
		m.lcSQLProm = [Select a.* From SigPrPmc a Where a.eCommerce = 1 Order by a.Promos]
		Select csSigPrPmi
			.Col_CPros.ControlSource = 'csSigPrPmi.CPros'
			.Col_DPros.ControlSource = 'csSigPrPmi.DPros'
			.Col_Pecas.ControlSource = 'csSigPrPmi.Pecas'
			.Column4.ControlSource   = 'csSigPrPmi.CBars'
			.Column5.ControlSource   = 'csSigPrPmi.Datas'
			.Column6.ControlSource   = 'csSigPrPmi.Vendavels'
		Select csSigPrPmv
			.Column1.ControlSource   = 'csSigPrPmv.Colecoes'
			.Column2.ControlSource   = 'csSigPrPmv.Datas'
Select csSigPrPmi
Select csSigPrPmv
Select csSigPrPmi
	Insert Into CrSigPrPmi From MemVar
If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmi)')
Select csSigPrPmv
	Insert Into CrSigPrPmv From MemVar
If Not ThisForm.poDataMgr.Update('crSigPrPmv')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmv)')
Select csSigPrPmi
	Insert Into crSigPrPmi From MemVar
Delete From crSigPrPmi
If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmi)')
Select csSigPrPmv
	Insert Into crSigPrPmv From MemVar
Delete From crSigPrPmv
If Not ThisForm.poDataMgr.Update('crSigPrPmv')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmv)')
Select csSigPrPmi
	Insert Into CrSigPrPmi From MemVar
If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmi)')
Select csSigPrPmv
	Insert Into CrSigPrPmv From MemVar
If Not ThisForm.poDataMgr.Update('crSigPrPmv')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigPrPmv)')
Select CrSigPrPmc
Select crSigPrPmc
	lcQuery = [Select * ] + ;
				[From SigPrPmv ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPromV') < 1)
	Select TmpPromV
		Insert Into csSigPrPmv From MemVar
		Select TmpPromV
	lcQuery = [Select a.CPros, a.Pecas, a.CBars, a.Promos, a.Datas, a.Vendavels, ] + ;
				[From SigPrPmi a, SigCdPro b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpPromI') < 1)
	Select TmpPromI
		Insert Into csSigPrPmi From MemVar
		Insert Into TcrSigPrPmi From MemVar		
		Select TmpPromI
		Delete From csSigPrPmv Where Empty(Colecoes)
		Insert Into csSigPrPmv (Promos, Datas) Values (crSigPrPmc.Promos, DateTime())
		Insert Into csSigPrPmi (Promos, Datas, Vendavels) Values (crSigPrPmc.Promos, Date(), 1)		
Select crSigPrPmc
	lStrQuery = [Select Promos,Cods From SigPrPmc Where Promos = ']+CrSigPrPmc.Promos+[' And Cods = ']+CrSigPrPmc.Cods+[' ]
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpProm') < 1
	Select TmpProm
	Select CPros, Recno() as Registro ;
	  From csSigPrPmi ;
	Select crErros
			Select csSigPrPmi
	Delete From csSigPrPmv Where Empty(Colecoes) Or IsEmpty(Datas)
	Delete From csSigPrPmi Where Empty(CPros) Or IsEmpty(Datas)
	Select Colecoes From csSigPrPmv Into Cursor crBuscaV
	Select CPros From csSigPrPmi Into Cursor crBuscaI
	Update csSigPrPmi Set Promos = crSigPrPmc.Promos Where Empty(Promos)
	Update csSigPrPmi Set PromoPro = Promos + CPros Where Empty(PromoPro)
	Update csSigPrPmi Set cIdChaves = fUniqueIds()  Where Empty(cIdChaves)
	Update csSigPrPmv Set Promos = crSigPrPmc.Promos Where Empty(Promos)
	Update csSigPrPmv Set cIdChaves = fUniqueIds()  Where Empty(cIdChaves)
	Select crSigPrPmc
		Delete From csSigPrPmv Where Empty(Colecoes)
		Insert Into csSigPrPmv (Promos, Datas) Values (crSigPrPmc.Promos, DateTime())
ThisForm.poDatamgr.SqlExecute([Select FigJpgs From SigCdPro Where cPros = ']+csSigPrPmi.CPros+['],'ciSigCdPro')
	Delete File (lcArquivo)
			lStrQuery = [Select CPros, CBars From SigOpEtq Where CBars = ] + Alltrim(This.Value)
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
			Select TmpEti
			Select CsSigPrPmi
			Select CPros ;
			  From csSigPrPmi ;
Select csSigPrPmi
	Select csSigPrPmi
		Insert Into csSigPrPmi (Promos, Datas, Vendavels) Values (crSigPrPmc.Promos, Date(), 1)		
	=Seek(Padr(This.Value,14), 'csSigPrPmi', 'CPros')
lcQuery = [Delete From SigPrPmi Where cIdChaves = '] + csSigPrPmi.cIdChaves + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPrPmi)')
Delete From crSigPrPmi Where cIdChaves = csSigPrPmi.cIdChaves
Delete In csSigPrPmi
	Insert Into csSigPrPmi (Promos, Datas, Vendavels) Values (crSigPrPmc.Promos, Date(), 1)	
lcQuery = [Delete From SigPrPmv Where cIdChaves = '] + csSigPrPmv.cIdChaves + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigPrPmv)')
Delete From crSigPrPmv Where cIdChaves = csSigPrPmv.cIdChaves
Delete In csSigPrPmv
	Delete From csSigPrPmv Where Empty(Colecoes)
	Insert Into csSigPrPmv (Promos, Datas) Values (crSigPrPmc.Promos, DateTime())
			Select CsSigPrPmv
			Select Colecoes ;
			  From csSigPrPmv ;
Select csSigPrPmv
	Select csSigPrPmv
		Insert Into csSigPrPmv (Promos, Datas) Values (crSigPrPmc.Promos, DateTime())
		lStrQuery = [Select * From SigPrPmv Where Promos = ?lcPro]
		If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpPromV') < 1
		Select TmpPromV
			Insert Into CsSigPrPmv From MemVar
			Select TmpPromV
		Select CsSigPrPmv
			Insert Into CsSigPrPmv (Promos) Values (lcPro)
		lStrQuery = [Select a.*, b.DPros From SigPrPmi a, SigCdPro b Where Promos = ?lcPro And b.CPros = a.CPros ]
		If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpPromI') < 1
		Select TmpPromI
			Insert Into CsSigPrPmi From MemVar
			Select TmpPromI
		Select CsSigPrPmi
			Insert Into CsSigPrPmi (Promos, Vendavels) Values (lcPro, 1)
		Select CsSigPrPmi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS SQL (1819 linhas total):

*-- Linhas 95 a 133:
95:     *====================================================================
96:     PROTECTED PROCEDURE CriarCursoresLocais()
97:         SET NULL ON
98:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
99:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
100:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
101:         SELECT csSigPrPmi
102:         INDEX ON CPros TAG CPros
103: 
104:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
105:         INDEX ON CPros TAG idxTcpros
106: 
107:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
108:         SELECT csSigPrPmv
109: 
110:         CREATE CURSOR cursor_4c_Itens ;
111:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
112:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
113:              PromoPro C(35), Vendavels N(1,0) NULL)
114:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
115: 
116:         CREATE CURSOR cursor_4c_Grupos ;
117:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
118:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
119: 
120:         SET NULL OFF
121:     ENDPROC
122: 
123:     *====================================================================
124:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
125:     *====================================================================
126:     PROTECTED PROCEDURE ConfigurarPageFrame()
127:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
128:         WITH THIS.pgf_4c_Paginas
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .PageCount = 2

*-- Linhas 380 a 398:
380:             .HighlightBackColor = RGB(255, 255, 255)
381:             .HighlightForeColor = RGB(15, 41, 104)
382:             .HighlightStyle     = 2
383:             .DeleteMark         = .F.
384:             .RecordMark         = .F.
385:             .RowHeight          = 16
386:             .ScrollBars         = 2
387:             .ReadOnly           = .T.
388:             .Visible            = .T.
389:             .Column1.Width      = 250
390:             .Column2.Width      = 60
391:             .Column3.Width      = 85
392:             .Column4.Width      = 60
393:             .Column5.Width      = 200
394:         ENDWITH
395: 
396:         THIS.TornarControlesVisiveis(loc_oPagina)
397:     ENDPROC
398: 

*-- Linhas 644 a 666:
644:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
645:                     loc_oGrid.ColumnCount = 5
646:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
647:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
648:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
649:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
650:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
651:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
652:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
653:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
654:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
655:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
656:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
657:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
658:                     loc_oGrid.Column3.Alignment = 1
659:                     loc_oGrid.Column4.Alignment = 1
660:                     THIS.FormatarGridLista(loc_oGrid)
661:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
662:                         GO TOP IN cursor_4c_Dados
663:                     ENDIF
664:                     loc_lSucesso = .T.
665:                 ENDIF
666:             CATCH TO loException

*-- Linhas 780 a 821:
780:         LOCAL loc_cCidChaves
781:         loc_cCidChaves = ""
782:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
783:             SELECT cursor_4c_Dados
784:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
785:         ENDIF
786:         IF EMPTY(loc_cCidChaves)
787:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
788:             RETURN
789:         ENDIF
790:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
791:             THIS.this_cModoAtual = "VISUALIZAR"
792:             THIS.BOParaForm()
793:             THIS.HabilitarCampos(.F.)
794:             THIS.AjustarBotoesPorModo()
795:             THIS.AlternarPagina(2)
796:         ENDIF
797:     ENDPROC
798: 
799:     *====================================================================
800:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
801:     *====================================================================
802:     PROCEDURE BtnAlterarClick()
803:         LOCAL loc_cCidChaves
804:         loc_cCidChaves = ""
805:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
806:             SELECT cursor_4c_Dados
807:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
808:         ENDIF
809:         IF EMPTY(loc_cCidChaves)
810:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
811:             RETURN
812:         ENDIF
813:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
814:             THIS.this_oBusinessObject.EditarRegistro()
815:             THIS.this_cModoAtual = "ALTERAR"
816:             THIS.BOParaForm()
817:             THIS.HabilitarCampos(.T.)
818:             THIS.AjustarBotoesPorModo()
819:             THIS.AlternarPagina(2)
820:         ENDIF
821:     ENDPROC

*-- Linhas 828 a 846:
828:         loc_cCidChaves = ""
829:         loc_lConfirma  = .F.
830:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
831:             SELECT cursor_4c_Dados
832:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
833:         ENDIF
834:         IF EMPTY(loc_cCidChaves)
835:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
836:             RETURN
837:         ENDIF
838:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
839:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
840:         IF loc_lConfirma
841:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
842:                 IF THIS.this_oBusinessObject.Excluir()
843:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
844:                         "da com sucesso!", "Sucesso")
845:                     THIS.CarregarLista()
846:                 ENDIF

*-- Linhas 1034 a 1063:
1034:         ENDIF
1035: 
1036:         SET NULL ON
1037:         CREATE CURSOR cursor_4c_Itens ;
1038:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1039:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1040:              PromoPro C(35), Vendavels N(1,0) NULL)
1041:         SET NULL OFF
1042:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1043: 
1044:         SET NULL ON
1045:         CREATE CURSOR cursor_4c_Grupos ;
1046:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1049: 
1050:         *-- Atualizar grids com cursores limpos
1051:         TRY
1052:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1053:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1054:         CATCH TO loException
1055:             MostrarErro(loException, "FormPrm.LimparCampos")
1056:         ENDTRY
1057:     ENDPROC
1058: 
1059:     *====================================================================
1060:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1061:     *====================================================================
1062:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1063:         LOCAL loc_oPg2

*-- Linhas 1122 a 1142:
1122:             IF USED("cursor_4c_BuscaLpc")
1123:                 USE IN cursor_4c_BuscaLpc
1124:             ENDIF
1125:             loc_nResult = SQLEXEC(gnConnHandle, ;
1126:                 "SELECT TOP 1 LPrecos FROM SigCdLpc WHERE LPrecos = " + ;
1127:                 EscaparSQL(loc_cLPrecos), "cursor_4c_BuscaLpc")
1128: 
1129:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaLpc") AND !EOF("cursor_4c_BuscaLpc")
1130:                 *-- Encontrado exatamente
1131:                 loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1132:             ELSE
1133:                 *-- Nao encontrado: busca LIKE + picker (Pattern A canonico)
1134:                 IF USED("cursor_4c_BuscaLpc")
1135:                     USE IN cursor_4c_BuscaLpc
1136:                 ENDIF
1137:                 THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1138: 
1139:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1140:                 IF VARTYPE(loc_oBusca) = "O"
1141:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;
1142:                         "Lista de Pre" + CHR(231) + "os")

*-- Linhas 1214 a 1288:
1214:             .GridLineColor   = RGB(238, 238, 238)
1215:             .GridLines       = 3
1216:             .HighlightStyle  = 2
1217:             .DeleteMark      = .F.
1218:             .RecordMark      = .F.
1219:             .RowHeight       = 18
1220:             .ScrollBars      = 3
1221:             .ReadOnly        = .F.
1222:             .RecordSource    = "cursor_4c_Itens"
1223:         ENDWITH
1224: 
1225:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1226:         WITH loc_oGrid.Column1
1227:             .ControlSource   = "cursor_4c_Itens.CPros"
1228:             .Width           = 100
1229:             .Sparse          = .F.
1230:             .Header1.Caption = "Produto"
1231:         ENDWITH
1232:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1233: 
1234:         WITH loc_oGrid.Column2
1235:             .ControlSource   = "cursor_4c_Itens.DPros"
1236:             .Width           = 200
1237:             .ReadOnly        = .T.
1238:             .Sparse          = .F.
1239:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1240:         ENDWITH
1241: 
1242:         WITH loc_oGrid.Column3
1243:             .ControlSource   = "cursor_4c_Itens.Pecas"
1244:             .Width           = 70
1245:             .Sparse          = .F.
1246:             .Header1.Caption = "Pe" + CHR(231) + "a"
1247:         ENDWITH
1248: 
1249:         WITH loc_oGrid.Column4
1250:             .ControlSource   = "cursor_4c_Itens.CBars"
1251:             .Width           = 80
1252:             .Sparse          = .F.
1253:             .ReadOnly        = .T.
1254:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1255:         ENDWITH
1256: 
1257:         WITH loc_oGrid.Column5
1258:             .ControlSource   = "cursor_4c_Itens.Datas"
1259:             .Width           = 80
1260:             .Sparse          = .F.
1261:             .Header1.Caption = "Data Inicial"
1262:         ENDWITH
1263:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1264: 
1265:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1266:         WITH loc_oGrid.Column6
1267:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1268:             .Width           = 35
1269:             .Sparse          = .F.
1270:             .Header1.Caption = "V"
1271:             .AddObject("chk_4c_Vendavel", "CheckBox")
1272:             WITH .chk_4c_Vendavel
1273:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1274:                 .Caption       = ""
1275:                 .Alignment     = 0
1276:                 .ReadOnly      = .F.
1277:                 .Visible       = .T.
1278:                 .Top           = 9
1279:                 .Left          = 2
1280:                 .Height        = 17
1281:                 .Width         = 22
1282:             ENDWITH
1283:             .CurrentControl  = "chk_4c_Vendavel"
1284:         ENDWITH
1285:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1286:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1287: 
1288:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")

*-- Linhas 1367 a 1403:
1367:             .GridLineColor   = RGB(238, 238, 238)
1368:             .GridLines       = 3
1369:             .HighlightStyle  = 2
1370:             .DeleteMark      = .F.
1371:             .RecordMark      = .F.
1372:             .RowHeight       = 18
1373:             .ScrollBars      = 3
1374:             .ReadOnly        = .F.
1375:             .RecordSource    = "cursor_4c_Grupos"
1376:         ENDWITH
1377: 
1378:         *-- ControlSources e Headers APOS RecordSource
1379:         WITH loc_oGrid.Column1
1380:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1381:             .Width           = 80
1382:             .Sparse          = .F.
1383:             .Header1.Caption = "Grp. Venda"
1384:         ENDWITH
1385:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1386: 
1387:         WITH loc_oGrid.Column2
1388:             .ControlSource   = "cursor_4c_Grupos.Datas"
1389:             .Width           = 80
1390:             .Sparse          = .F.
1391:             .Header1.Caption = "Data Inicial"
1392:         ENDWITH
1393:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1394: 
1395:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1396:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1397:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1398:             .Caption      = "Apagar"
1399:             .Top          = 161
1400:             .Left         = 451
1401:             .Width        = 50
1402:             .Height       = 50
1403:             .FontName     = "Tahoma"

*-- Linhas 1410 a 1453:
1410: 
1411:     *====================================================================
1412:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1413:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1414:     *====================================================================
1415:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1416:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1417:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1418: 
1419:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1420:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1421:             RETURN
1422:         ENDIF
1423: 
1424:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1425:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1426: 
1427:         IF EMPTY(loc_cCpros)
1428:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1429:             RETURN
1430:         ENDIF
1431: 
1432:         TRY
1433:             IF USED("cursor_4c_FigJpg")
1434:                 USE IN cursor_4c_FigJpg
1435:             ENDIF
1436:             loc_nResult = SQLEXEC(gnConnHandle, ;
1437:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1438:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1439:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1440:                     !EOF("cursor_4c_FigJpg") AND ;
1441:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1442:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1443:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1444:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1445:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1446:             ELSE
1447:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1448:             ENDIF
1449:             IF USED("cursor_4c_FigJpg")
1450:                 USE IN cursor_4c_FigJpg
1451:             ENDIF
1452:         CATCH TO loException
1453:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")

*-- Linhas 1479 a 1497:
1479:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1480:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1481:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1482:                     SELECT cursor_4c_BuscaProd
1483:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1484:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1485:                 ENDIF
1486:                 IF USED("cursor_4c_BuscaProd")
1487:                     USE IN cursor_4c_BuscaProd
1488:                 ENDIF
1489:             ELSE
1490:                 IF USED("cursor_4c_BuscaProd")
1491:                     USE IN cursor_4c_BuscaProd
1492:                 ENDIF
1493:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1494:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1495:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1496:                 IF VARTYPE(loc_oBusca) = "O"
1497:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cPros", "dPros", ;

*-- Linhas 1533 a 1551:
1533:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1534:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1535:             TRY
1536:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1537:                 GO BOTTOM IN cursor_4c_Itens
1538:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1539:             CATCH TO loException
1540:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1541:             ENDTRY
1542:         ENDIF
1543: 
1544:         RETURN .T.
1545:     ENDPROC
1546: 
1547:     *====================================================================
1548:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1549:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1550:     *====================================================================
1551:     PROCEDURE GridCheckVendavelClick()

*-- Linhas 1595 a 1613:
1595:             RETURN .T.
1596:         ENDIF
1597: 
1598:         SELECT cursor_4c_Itens
1599:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1600: 
1601:         IF FOUND()
1602:             loc_oPgP.grd_4c_Produtos.Refresh
1603:         ENDIF
1604: 
1605:         RETURN .T.
1606:     ENDPROC
1607: 
1608:     *====================================================================
1609:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1610:     * Legado: getBusca.LostFocus - focus col_CPros
1611:     *====================================================================
1612:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1613:         LOCAL loc_oPgP

*-- Linhas 1622 a 1672:
1622: 
1623:     *====================================================================
1624:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1625:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1626:     *====================================================================
1627:     PROCEDURE BtnApagarItemClick()
1628:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1629:         loc_lAbortou = .F.
1630: 
1631:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1632:             RETURN
1633:         ENDIF
1634: 
1635:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1636:             RETURN
1637:         ENDIF
1638: 
1639:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1640: 
1641:         TRY
1642:             *-- Excluir do banco se registro ja persistido
1643:             IF !EMPTY(loc_cIdChaves)
1644:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1645:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1646:                 IF loc_nResult < 0
1647:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1648:                     loc_lAbortou = .T.
1649:                 ENDIF
1650:             ENDIF
1651: 
1652:             IF !loc_lAbortou
1653:                 SELECT cursor_4c_Itens
1654:                 DELETE
1655:                 PACK
1656:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1657:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1658:                 ENDIF
1659:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1660:             ENDIF
1661:         CATCH TO loException
1662:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1663:         ENDTRY
1664:     ENDPROC
1665: 
1666:     *====================================================================
1667:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1668:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1669:     *====================================================================
1670:     PROCEDURE ValidarColecao()
1671:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1672: 

*-- Linhas 1684 a 1704:
1684:             IF USED("cursor_4c_BuscaCol")
1685:                 USE IN cursor_4c_BuscaCol
1686:             ENDIF
1687:             loc_nResult = SQLEXEC(gnConnHandle, ;
1688:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1689:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1690: 
1691:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1692:                 *-- Encontrado: manter valor atual
1693:             ELSE
1694:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1695:                 IF USED("cursor_4c_BuscaCol")
1696:                     USE IN cursor_4c_BuscaCol
1697:                 ENDIF
1698:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1699: 
1700:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1701:                 IF VARTYPE(loc_oBusca) = "O"
1702:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1703:                         "Selecionar Grupo de Venda")
1704:                     IF loc_oBusca.Mostrar()

*-- Linhas 1735 a 1798:
1735:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1736:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1737:             TRY
1738:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1739:                 GO BOTTOM IN cursor_4c_Grupos
1740:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1741:             CATCH TO loException
1742:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1743:             ENDTRY
1744:         ENDIF
1745: 
1746:         RETURN .T.
1747:     ENDPROC
1748: 
1749:     *====================================================================
1750:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1751:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1752:     *====================================================================
1753:     PROCEDURE BtnApagarGrupoClick()
1754:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1755:         loc_lAbortou = .F.
1756: 
1757:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1758:             RETURN
1759:         ENDIF
1760: 
1761:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1762:             RETURN
1763:         ENDIF
1764: 
1765:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1766: 
1767:         TRY
1768:             *-- Excluir do banco se registro ja persistido
1769:             IF !EMPTY(loc_cIdChaves)
1770:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1771:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1772:                 IF loc_nResult < 0
1773:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1774:                     loc_lAbortou = .T.
1775:                 ENDIF
1776:             ENDIF
1777: 
1778:             IF !loc_lAbortou
1779:                 SELECT cursor_4c_Grupos
1780:                 DELETE
1781:                 PACK
1782:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1783:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1784:                 ENDIF
1785:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1786:             ENDIF
1787:         CATCH TO loException
1788:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1789:         ENDTRY
1790:     ENDPROC
1791: 
1792:     *====================================================================
1793:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1794:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1795:     *====================================================================
1796:     PROCEDURE GradesActivate()
1797:         LOCAL loc_cPromos, loc_oPg2
1798:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1806 a 1819:
1806:             GO BOTTOM IN cursor_4c_Grupos
1807:             IF EOF("cursor_4c_Grupos") OR ;
1808:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1809:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1810:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1811:                     VALUES (loc_cPromos, DATETIME())
1812:             ENDIF
1813:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1814:         CATCH TO loException
1815:             MostrarErro(loException, "FormPrm.GradesActivate")
1816:         ENDTRY
1817:     ENDPROC
1818: 
1819: ENDDEFINE


### BO (C:\4c\projeto\app\classes\PrmBO.prg):
*====================================================================
* PrmBO.prg
*
* Business Object para Cadastro de Promocoes
* Tabela Principal: SigPrPmc
* Tabelas Filhas: SigPrPmi (itens/produtos), SigPrPmv (grupos de venda)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS PrmBO AS BusinessBase

    *-- Propriedades SigPrPmc (cabecalho da promocao)
    this_cPromos     = ""    && promos    char(25)  - chave de negocio (codigo promocao)
    this_cCods       = ""    && cods      char(3)   - codigo complementar
    this_cCidChaves  = ""    && cidchaves char(20)  - PK
    this_nComiss     = 0     && comiss    numeric(5,2) - percentual comissao incentivada
    this_nIncentivs  = 0     && incentivs numeric(1,0) - flag comissao incentivada (0/1)
    this_nECommerce  = 0     && ecommerce numeric(1,0) - flag integracao e-commerce (0/1)
    this_cLPrecos    = ""    && lprecos   char(30)  - lista de precos e-commerce

    *-- Propriedade de modo de exibicao (herdada do form original pcTipo)
    this_cTipo       = ""    && "" = modo padrao, "E" = modo e-commerce (filtra por ecommerce=1)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPmc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cPromos     = TratarNulo(Promos, "C")
            THIS.this_cCods       = TratarNulo(Cods, "C")
            THIS.this_nComiss     = TratarNulo(Comiss, "N")
            THIS.this_nIncentivs  = TratarNulo(Incentivs, "N")
            THIS.this_nECommerce  = TratarNulo(eCommerce, "N")
            THIS.this_cLPrecos    = TratarNulo(LPrecos, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista registros de promocoes (PUBLIC)
    * Se this_cTipo = "E", filtra por eCommerce = 1
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF UPPER(ALLTRIM(THIS.this_cTipo)) == "E"
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a" + ;
                           " WHERE a.eCommerce = 1" + ;
                           " ORDER BY a.Promos"
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a"

                IF !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Promos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega promocao pelo cIdChaves (PK) (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorPromos - Carrega promocao pela chave de negocio (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorPromos(par_cPromos, par_cCods)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos)

            IF !EMPTY(ALLTRIM(par_cCods))
                loc_cSQL = loc_cSQL + " AND a.Cods = " + EscaparSQL(par_cCods)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorPromos")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarPromoExiste - Verifica se Promos+Cods ja existe no banco
    *====================================================================
    FUNCTION VerificarPromoExiste(par_cPromos, par_cCods)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigPrPmc" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Cods = " + EscaparSQL(par_cCods)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Verifica")
                TABLEREVERT(.T., "cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Verifica")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                SELECT cursor_4c_Verifica
                loc_lExiste = (cursor_4c_Verifica.Total > 0)
            ENDIF

            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.VerificarPromoExiste")
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * GerarIdUnico - Gera ID unico para cIdChaves (substitui fUniqueIds)
    *====================================================================
    FUNCTION GerarIdUnico()
        LOCAL loc_cId, loc_nResult
        loc_cId = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT REPLACE(NEWID(),'-','') AS NewId", "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cId = LEFT(ALLTRIM(cursor_4c_NewId.NewId), 20)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loException
            loc_cId = ""
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        IF EMPTY(loc_cId)
            loc_cId = LEFT(ALLTRIM(SYS(2015)) + ALLTRIM(SYS(3)), 20)
        ENDIF
        RETURN loc_cId
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF

            loc_cSQL = "INSERT INTO SigPrPmc" + ;
                       " (cidchaves, Promos, Cods, Comiss, Incentivs, eCommerce, LPrecos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cPromos) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIncentivs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nECommerce) + ", " + ;
                       EscaparSQL(THIS.this_cLPrecos) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrPmc SET" + ;
                       " Promos = " + EscaparSQL(THIS.this_cPromos) + "," + ;
                       " Cods = " + EscaparSQL(THIS.this_cCods) + "," + ;
                       " Comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Incentivs = " + FormatarNumeroSQL(THIS.this_nIncentivs) + "," + ;
                       " eCommerce = " + FormatarNumeroSQL(THIS.this_nECommerce) + "," + ;
                       " LPrecos = " + EscaparSQL(THIS.this_cLPrecos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do cabecalho + itens + grupos (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir itens/produtos da promocao
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir grupos de venda da promocao
            loc_cSQL = "DELETE FROM SigPrPmv WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir cabecalho da promocao
            loc_cSQL = "DELETE FROM SigPrPmc WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega itens/produtos de uma promocao para cursor de edicao
    * Popula cursor_4c_Itens para o grid pgProdutos (PUBLIC)
    *====================================================================
    FUNCTION BuscarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.CPros, a.DPros, a.Pecas," + ;
                       " a.Promos, a.CBars, a.Datas, a.DtAlts," + ;
                       " a.PromoPro, a.Vendavels" + ;
                       " FROM SigPrPmi a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " ORDER BY a.CPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItensTemp")
                TABLEREVERT(.T., "cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Itens ;
                    (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
                     Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
                     PromoPro C(35), Vendavels N(1,0) NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_ItensTemp") > 0
                    SELECT cursor_4c_ItensTemp
                    SCAN
                        INSERT INTO cursor_4c_Itens ;
                            (cIdChaves, CPros, DPros, Pecas, Promos, CBars, ;
                             Datas, DtAlts, PromoPro, Vendavels) ;
                        VALUES ;
                            (cursor_4c_ItensTemp.cIdChaves, ;
                             cursor_4c_ItensTemp.CPros, ;
                             cursor_4c_ItensTemp.DPros, ;
                             cursor_4c_ItensTemp.Pecas, ;
                             cursor_4c_ItensTemp.Promos, ;
                             cursor_4c_ItensTemp.CBars, ;
                             cursor_4c_ItensTemp.Datas, ;
                             cursor_4c_ItensTemp.DtAlts, ;
                             cursor_4c_ItensTemp.PromoPro, ;
                             cursor_4c_ItensTemp.Vendavels)
                    ENDSCAN
                ENDIF

                *-- Adicionar linha em branco para edicao (como no legado)
                INSERT INTO cursor_4c_Itens (Promos, Datas, Vendavels) ;
                    VALUES (par_cPromos, DATE(), 1)

                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF

                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar itens da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarItens")
            IF USED("cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarGrupos - Carrega grupos de venda de uma promocao para cursor de edicao
    * Popula cursor_4c_Grupos para o grid pgGrpVenda (PUBLIC)
    *====================================================================
    FUNCTION BuscarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Promos, a.Colecoes, a.Datas" + ;
                       " FROM SigPrPmv a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND a.Colecoes IS NOT NULL AND a.Colecoes <> ''" + ;
                       " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GruposTemp")
                TABLEREVERT(.T., "cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos ;
                    (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_GruposTemp") > 0
                    SELECT cursor_4c_GruposTemp
                    SCAN
                        INSERT INTO cursor_4c_Grupos ;
                            (cIdChaves, Promos, Colecoes, Datas) ;
                        VALUES ;
                            (cursor_4c_GruposTemp.cIdChaves, ;
                             cursor_4c_GruposTemp.Promos, ;
                             cursor_4c_GruposTemp.Colecoes, ;
                             cursor_4c_GruposTemp.Datas)
                    ENDSCAN
                ENDIF

                *-- Linha em branco para edicao (como no legado: INSERT INTO csSigPrPmv (Promos, Datas))
                INSERT INTO cursor_4c_Grupos (Promos, Datas) VALUES (par_cPromos, DATETIME())

                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF

                GO TOP IN cursor_4c_Grupos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarGrupos")
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarItens - Persiste itens/produtos no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itens")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir TODOS os itens existentes no banco (legado faz ZAP + Delete + Update)
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(par_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir itens nao-vazios do cursor de edicao
            SELECT cursor_4c_Itens
            GO TOP IN cursor_4c_Itens
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Itens.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmi" + ;
                           " (cIdChaves, CPros, DPros, Pecas, Promos, CBars," + ;
                           " Datas, DtAlts, PromoPro, Vendavels)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.DPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.Pecas)) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.CBars) + ", " + ;
                           FormatarDataSQL(cursor_4c_Itens.Datas) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(par_cPromos + ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.Vendavels) + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar item " + ALLTRIM(cursor_4c_Itens.CPros) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarItens")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarGrupos - Persiste grupos de venda no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Grupos")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir grupos nao-vazios existentes no banco
            loc_cSQL = "DELETE FROM SigPrPmv" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Colecoes IS NOT NULL AND Colecoes <> ''"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir grupos nao-vazios do cursor de edicao
            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Grupos.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmv (cIdChaves, Promos, Colecoes, Datas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Grupos.Colecoes)) + ", " + ;
                           "GETDATE())"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar grupo " + ALLTRIM(cursor_4c_Grupos.Colecoes) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirItem - Exclui item especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de produtos
    *====================================================================
    FUNCTION ExcluirItem(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirItem")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirGrupo - Exclui grupo de venda especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de grupos
    *====================================================================
    FUNCTION ExcluirGrupo(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirGrupo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoPorCodigo - Busca produto por codigo ou codigo de barras
    * Popula cursor_4c_BuscaProd (PUBLIC)
    * Substitui a logica de Valid em txt_cpros + fVerificarBarras do legado
    *====================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCPros
        loc_lSucesso = .F.
        loc_cCPros   = ""
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            *-- Verificar se e codigo de barras (numerico com 8+ digitos)
            IF LEN(ALLTRIM(par_cCodigo)) >= 8 AND !EMPTY(VAL(ALLTRIM(par_cCodigo)))
                loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a" + ;
                           " WHERE a.CBars = " + ALLTRIM(par_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_BuscaEtq")
                    TABLEREVERT(.T., "cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtq")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaEtq") > 0
                    SELECT cursor_4c_BuscaEtq
                    GO TOP
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaEtq.CPros)
                ENDIF
                IF USED("cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                IF EMPTY(loc_cCPros)
                    loc_lSucesso = .F.
                ENDIF
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(loc_cCPros)
            ELSE
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(par_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaProd") > 0
            ELSE
                MsgErro("Erro ao buscar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoPorCodigo")
            IF USED("cursor_4c_BuscaEtq")
                USE IN cursor_4c_BuscaEtq
            ENDIF
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoParaLookup - Busca produtos para FormBuscaAuxiliar (PUBLIC)
    * Popula cursor_4c_BuscaProd com cPros + dPros
    *====================================================================
    FUNCTION BuscarProdutoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.cPros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR a.dPros LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.cPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoParaLookup")
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarColecaoParaLookup - Busca colecoes em SigCdCol (PUBLIC)
    * Substitui fwBuscaExt para SigCdCol no grid de grupos de venda
    * Popula cursor_4c_BuscaCol com Colecoes + Descs
    *====================================================================
    FUNCTION BuscarColecaoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_cSQL = "SELECT a.Colecoes, a.Descs FROM SigCdCol a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Colecoes LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " OR a.Descs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaCol")
                TABLEREVERT(.T., "cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cole" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarColecaoParaLookup")
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarListaPrecos - Busca listas de precos em SigCdLpc (PUBLIC)
    * Substitui fwBuscaExt para SigCdLpc no campo getLPrecos
    * Popula cursor_4c_BuscaLpc com LPrecos
    *====================================================================
    FUNCTION BuscarListaPrecos(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF

            loc_cSQL = "SELECT a.LPrecos FROM SigCdLpc a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.LPrecos LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.LPrecos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLpc")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de pre" + CHR(231) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarListaPrecos")
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarImagemProduto - Carrega imagem JPEG de produto para arquivo temp (PUBLIC)
    * Substitui logica AfterRowColChange do grid de produtos no legado
    *====================================================================
    FUNCTION CarregarImagemProduto(par_cCPros, par_cArquivoTemp)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF

            loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a" + ;
                       " WHERE a.cPros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
                SELECT cursor_4c_ImgProd
                IF !EMPTY(cursor_4c_ImgProd.FigJpgs) AND !ISNULL(cursor_4c_ImgProd.FigJpgs)
                    IF STRTOFILE(cursor_4c_ImgProd.FigJpgs, par_cArquivoTemp) > 0
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarImagemProduto")
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

