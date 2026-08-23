# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS SQL (1832 linhas total):

*-- Linhas 97 a 135:
97:     *====================================================================
98:     PROTECTED PROCEDURE CriarCursoresLocais()
99:         SET NULL ON
100:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
101:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
102:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
103:         SELECT csSigPrPmi
104:         INDEX ON CPros TAG CPros
105: 
106:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
107:         INDEX ON CPros TAG idxTcpros
108: 
109:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
110:         SELECT csSigPrPmv
111: 
112:         CREATE CURSOR cursor_4c_Itens ;
113:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
114:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
115:              PromoPro C(35), Vendavels N(1,0) NULL)
116:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
117: 
118:         CREATE CURSOR cursor_4c_Grupos ;
119:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
120:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
121: 
122:         SET NULL OFF
123:     ENDPROC
124: 
125:     *====================================================================
126:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
127:     *====================================================================
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
130:         WITH THIS.pgf_4c_Paginas
131:             .Top       = -29
132:             .Left      = 0
133:             .Width     = THIS.Width
134:             .Height    = THIS.Height + 29
135:             .PageCount = 2

*-- Linhas 382 a 400:
382:             .HighlightBackColor = RGB(255, 255, 255)
383:             .HighlightForeColor = RGB(15, 41, 104)
384:             .HighlightStyle     = 2
385:             .DeleteMark         = .F.
386:             .RecordMark         = .F.
387:             .RowHeight          = 16
388:             .ScrollBars         = 2
389:             .ReadOnly           = .T.
390:             .Visible            = .T.
391:             .Column1.Width      = 250
392:             .Column2.Width      = 60
393:             .Column3.Width      = 85
394:             .Column4.Width      = 60
395:             .Column5.Width      = 200
396:         ENDWITH
397: 
398:         THIS.TornarControlesVisiveis(loc_oPagina)
399:     ENDPROC
400: 

*-- Linhas 646 a 668:
646:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
647:                     loc_oGrid.ColumnCount = 5
648:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
649:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
650:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
651:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
652:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
653:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
654:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
655:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
657:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
658:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
659:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
660:                     loc_oGrid.Column3.Alignment = 1
661:                     loc_oGrid.Column4.Alignment = 1
662:                     THIS.FormatarGridLista(loc_oGrid)
663:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
664:                         GO TOP IN cursor_4c_Dados
665:                     ENDIF
666:                     loc_lSucesso = .T.
667:                 ENDIF
668:             CATCH TO loException

*-- Linhas 784 a 825:
784:         LOCAL loc_cCidChaves
785:         loc_cCidChaves = ""
786:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
787:             SELECT cursor_4c_Dados
788:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
789:         ENDIF
790:         IF EMPTY(loc_cCidChaves)
791:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
792:             RETURN
793:         ENDIF
794:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
795:             THIS.this_cModoAtual = "VISUALIZAR"
796:             THIS.BOParaForm()
797:             THIS.HabilitarCampos(.F.)
798:             THIS.AjustarBotoesPorModo()
799:             THIS.AlternarPagina(2)
800:         ENDIF
801:     ENDPROC
802: 
803:     *====================================================================
804:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
805:     *====================================================================
806:     PROCEDURE BtnAlterarClick()
807:         LOCAL loc_cCidChaves
808:         loc_cCidChaves = ""
809:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
810:             SELECT cursor_4c_Dados
811:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
812:         ENDIF
813:         IF EMPTY(loc_cCidChaves)
814:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
815:             RETURN
816:         ENDIF
817:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
818:             THIS.this_oBusinessObject.EditarRegistro()
819:             THIS.this_cModoAtual = "ALTERAR"
820:             THIS.BOParaForm()
821:             THIS.HabilitarCampos(.T.)
822:             THIS.AjustarBotoesPorModo()
823:             THIS.AlternarPagina(2)
824:         ENDIF
825:     ENDPROC

*-- Linhas 832 a 850:
832:         loc_cCidChaves = ""
833:         loc_lConfirma  = .F.
834:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
835:             SELECT cursor_4c_Dados
836:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
837:         ENDIF
838:         IF EMPTY(loc_cCidChaves)
839:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
840:             RETURN
841:         ENDIF
842:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
843:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
844:         IF loc_lConfirma
845:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
846:                 IF THIS.this_oBusinessObject.Excluir()
847:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
848:                         "da com sucesso!", "Sucesso")
849:                     THIS.CarregarLista()
850:                 ENDIF

*-- Linhas 1038 a 1067:
1038:         ENDIF
1039: 
1040:         SET NULL ON
1041:         CREATE CURSOR cursor_4c_Itens ;
1042:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1043:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1044:              PromoPro C(35), Vendavels N(1,0) NULL)
1045:         SET NULL OFF
1046:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1047: 
1048:         SET NULL ON
1049:         CREATE CURSOR cursor_4c_Grupos ;
1050:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1051:         SET NULL OFF
1052:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1053: 
1054:         *-- Atualizar grids com cursores limpos
1055:         TRY
1056:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1057:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1058:         CATCH TO loException
1059:             MostrarErro(loException, "FormPrm.LimparCampos")
1060:         ENDTRY
1061:     ENDPROC
1062: 
1063:     *====================================================================
1064:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1065:     *====================================================================
1066:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1067:         LOCAL loc_oPg2

*-- Linhas 1126 a 1146:
1126:             IF USED("cursor_4c_BuscaLpc")
1127:                 USE IN cursor_4c_BuscaLpc
1128:             ENDIF
1129:             loc_nResult = SQLEXEC(gnConnHandle, ;
1130:                 "SELECT TOP 1 LPrecos FROM SigCdLpc WHERE LPrecos = " + ;
1131:                 EscaparSQL(loc_cLPrecos), "cursor_4c_BuscaLpc")
1132: 
1133:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaLpc") AND !EOF("cursor_4c_BuscaLpc")
1134:                 *-- Encontrado exatamente
1135:                 loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1136:             ELSE
1137:                 *-- Nao encontrado: busca LIKE + picker (Pattern A canonico)
1138:                 IF USED("cursor_4c_BuscaLpc")
1139:                     USE IN cursor_4c_BuscaLpc
1140:                 ENDIF
1141:                 THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1142: 
1143:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1144:                 IF VARTYPE(loc_oBusca) = "O"
1145:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLpc"
1146:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;

*-- Linhas 1219 a 1296:
1219:             .GridLineColor   = RGB(238, 238, 238)
1220:             .GridLines       = 3
1221:             .HighlightStyle  = 2
1222:             .DeleteMark      = .F.
1223:             .RecordMark      = .F.
1224:             .RowHeight       = 18
1225:             .ScrollBars      = 3
1226:             .ReadOnly        = .F.
1227:         ENDWITH
1228: 
1229:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1230:         loc_oGrid.ColumnCount = 3
1231:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1232: 
1233:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1234:         WITH loc_oGrid.Column1
1235:             .ControlSource   = "cursor_4c_Itens.CPros"
1236:             .Width           = 100
1237:             .Sparse          = .F.
1238:             .Header1.Caption = "Produto"
1239:         ENDWITH
1240:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1241: 
1242:         WITH loc_oGrid.Column2
1243:             .ControlSource   = "cursor_4c_Itens.DPros"
1244:             .Width           = 200
1245:             .ReadOnly        = .T.
1246:             .Sparse          = .F.
1247:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1248:         ENDWITH
1249: 
1250:         WITH loc_oGrid.Column3
1251:             .ControlSource   = "cursor_4c_Itens.Pecas"
1252:             .Width           = 70
1253:             .Sparse          = .F.
1254:             .Header1.Caption = "Pe" + CHR(231) + "a"
1255:         ENDWITH
1256: 
1257:         WITH loc_oGrid.Column4
1258:             .ControlSource   = "cursor_4c_Itens.CBars"
1259:             .Width           = 80
1260:             .Sparse          = .F.
1261:             .ReadOnly        = .T.
1262:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1263:         ENDWITH
1264: 
1265:         WITH loc_oGrid.Column5
1266:             .ControlSource   = "cursor_4c_Itens.Datas"
1267:             .Width           = 80
1268:             .Sparse          = .F.
1269:             .Header1.Caption = "Data Inicial"
1270:         ENDWITH
1271:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1272: 
1273:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1274:         WITH loc_oGrid.Column6
1275:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1276:             .Width           = 35
1277:             .Sparse          = .F.
1278:             .Header1.Caption = "V"
1279:             .AddObject("chk_4c_Vendavel", "CheckBox")
1280:             WITH .chk_4c_Vendavel
1281:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1282:                 .Caption       = ""
1283:                 .Alignment     = 0
1284:                 .ReadOnly      = .F.
1285:                 .Visible       = .T.
1286:                 .Top           = 9
1287:                 .Left          = 2
1288:                 .Height        = 17
1289:                 .Width         = 22
1290:             ENDWITH
1291:             .CurrentControl  = "chk_4c_Vendavel"
1292:         ENDWITH
1293:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1294:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1295: 
1296:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")

*-- Linhas 1375 a 1414:
1375:             .GridLineColor   = RGB(238, 238, 238)
1376:             .GridLines       = 3
1377:             .HighlightStyle  = 2
1378:             .DeleteMark      = .F.
1379:             .RecordMark      = .F.
1380:             .RowHeight       = 18
1381:             .ScrollBars      = 3
1382:             .ReadOnly        = .F.
1383:         ENDWITH
1384: 
1385:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1386:         loc_oGrid.ColumnCount = 3
1387:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1388: 
1389:         *-- ControlSources e Headers APOS RecordSource
1390:         WITH loc_oGrid.Column1
1391:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1392:             .Width           = 80
1393:             .Sparse          = .F.
1394:             .Header1.Caption = "Grp. Venda"
1395:         ENDWITH
1396:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1397: 
1398:         WITH loc_oGrid.Column2
1399:             .ControlSource   = "cursor_4c_Grupos.Datas"
1400:             .Width           = 80
1401:             .Sparse          = .F.
1402:             .Header1.Caption = "Data Inicial"
1403:         ENDWITH
1404:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1405: 
1406:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1407:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1408:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1409:             .Caption      = "Apagar"
1410:             .Top          = 161
1411:             .Left         = 451
1412:             .Width        = 50
1413:             .Height       = 50
1414:             .FontName     = "Tahoma"

*-- Linhas 1421 a 1464:
1421: 
1422:     *====================================================================
1423:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1424:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1425:     *====================================================================
1426:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1427:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1428:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1429: 
1430:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1431:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1432:             RETURN
1433:         ENDIF
1434: 
1435:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1436:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1437: 
1438:         IF EMPTY(loc_cCpros)
1439:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1440:             RETURN
1441:         ENDIF
1442: 
1443:         TRY
1444:             IF USED("cursor_4c_FigJpg")
1445:                 USE IN cursor_4c_FigJpg
1446:             ENDIF
1447:             loc_nResult = SQLEXEC(gnConnHandle, ;
1448:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1449:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1450:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1451:                     !EOF("cursor_4c_FigJpg") AND ;
1452:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1453:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1454:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1455:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1456:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1457:             ELSE
1458:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1459:             ENDIF
1460:             IF USED("cursor_4c_FigJpg")
1461:                 USE IN cursor_4c_FigJpg
1462:             ENDIF
1463:         CATCH TO loException
1464:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")

*-- Linhas 1490 a 1508:
1490:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1491:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1492:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1493:                     SELECT cursor_4c_BuscaProd
1494:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1495:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1496:                 ENDIF
1497:                 IF USED("cursor_4c_BuscaProd")
1498:                     USE IN cursor_4c_BuscaProd
1499:                 ENDIF
1500:             ELSE
1501:                 IF USED("cursor_4c_BuscaProd")
1502:                     USE IN cursor_4c_BuscaProd
1503:                 ENDIF
1504:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1505:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1506:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1507:                 IF VARTYPE(loc_oBusca) = "O"
1508:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"

*-- Linhas 1545 a 1563:
1545:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1546:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1547:             TRY
1548:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1549:                 GO BOTTOM IN cursor_4c_Itens
1550:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1551:             CATCH TO loException
1552:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1553:             ENDTRY
1554:         ENDIF
1555: 
1556:         RETURN .T.
1557:     ENDPROC
1558: 
1559:     *====================================================================
1560:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1561:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1562:     *====================================================================
1563:     PROCEDURE GridCheckVendavelClick()

*-- Linhas 1607 a 1625:
1607:             RETURN .T.
1608:         ENDIF
1609: 
1610:         SELECT cursor_4c_Itens
1611:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1612: 
1613:         IF FOUND()
1614:             loc_oPgP.grd_4c_Produtos.Refresh
1615:         ENDIF
1616: 
1617:         RETURN .T.
1618:     ENDPROC
1619: 
1620:     *====================================================================
1621:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1622:     * Legado: getBusca.LostFocus - focus col_CPros
1623:     *====================================================================
1624:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1625:         LOCAL loc_oPgP

*-- Linhas 1634 a 1684:
1634: 
1635:     *====================================================================
1636:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1637:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1638:     *====================================================================
1639:     PROCEDURE BtnApagarItemClick()
1640:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1641:         loc_lAbortou = .F.
1642: 
1643:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1644:             RETURN
1645:         ENDIF
1646: 
1647:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1648:             RETURN
1649:         ENDIF
1650: 
1651:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1652: 
1653:         TRY
1654:             *-- Excluir do banco se registro ja persistido
1655:             IF !EMPTY(loc_cIdChaves)
1656:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1657:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1658:                 IF loc_nResult < 0
1659:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1660:                     loc_lAbortou = .T.
1661:                 ENDIF
1662:             ENDIF
1663: 
1664:             IF !loc_lAbortou
1665:                 SELECT cursor_4c_Itens
1666:                 DELETE
1667:                 PACK
1668:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1669:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1670:                 ENDIF
1671:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1672:             ENDIF
1673:         CATCH TO loException
1674:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *====================================================================
1679:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1680:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1681:     *====================================================================
1682:     PROCEDURE ValidarColecao()
1683:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1684: 

*-- Linhas 1696 a 1716:
1696:             IF USED("cursor_4c_BuscaCol")
1697:                 USE IN cursor_4c_BuscaCol
1698:             ENDIF
1699:             loc_nResult = SQLEXEC(gnConnHandle, ;
1700:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1701:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1702: 
1703:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1704:                 *-- Encontrado: manter valor atual
1705:             ELSE
1706:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1707:                 IF USED("cursor_4c_BuscaCol")
1708:                     USE IN cursor_4c_BuscaCol
1709:                 ENDIF
1710:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1711: 
1712:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1713:                 IF VARTYPE(loc_oBusca) = "O"
1714:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
1715:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1716:                         "Selecionar Grupo de Venda")

*-- Linhas 1748 a 1811:
1748:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1749:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1750:             TRY
1751:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1752:                 GO BOTTOM IN cursor_4c_Grupos
1753:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1754:             CATCH TO loException
1755:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1756:             ENDTRY
1757:         ENDIF
1758: 
1759:         RETURN .T.
1760:     ENDPROC
1761: 
1762:     *====================================================================
1763:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1764:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1765:     *====================================================================
1766:     PROCEDURE BtnApagarGrupoClick()
1767:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1768:         loc_lAbortou = .F.
1769: 
1770:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1771:             RETURN
1772:         ENDIF
1773: 
1774:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1775:             RETURN
1776:         ENDIF
1777: 
1778:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1779: 
1780:         TRY
1781:             *-- Excluir do banco se registro ja persistido
1782:             IF !EMPTY(loc_cIdChaves)
1783:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1784:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1785:                 IF loc_nResult < 0
1786:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1787:                     loc_lAbortou = .T.
1788:                 ENDIF
1789:             ENDIF
1790: 
1791:             IF !loc_lAbortou
1792:                 SELECT cursor_4c_Grupos
1793:                 DELETE
1794:                 PACK
1795:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1796:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1797:                 ENDIF
1798:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1799:             ENDIF
1800:         CATCH TO loException
1801:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1802:         ENDTRY
1803:     ENDPROC
1804: 
1805:     *====================================================================
1806:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1807:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1808:     *====================================================================
1809:     PROCEDURE GradesActivate()
1810:         LOCAL loc_cPromos, loc_oPg2
1811:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1819 a 1832:
1819:             GO BOTTOM IN cursor_4c_Grupos
1820:             IF EOF("cursor_4c_Grupos") OR ;
1821:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1822:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1823:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1824:                     VALUES (loc_cPromos, DATETIME())
1825:             ENDIF
1826:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1827:         CATCH TO loException
1828:             MostrarErro(loException, "FormPrm.GradesActivate")
1829:         ENDTRY
1830:     ENDPROC
1831: 
1832: ENDDEFINE


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
                           " WHERE a.cPros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
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
                           " WHERE a.Colecoes LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
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

            loc_cSQL = "SELECT a.LPrecos FROM SigCdLpc a ORDER BY a.LPrecos"

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

