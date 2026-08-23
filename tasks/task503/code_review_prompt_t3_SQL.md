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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS SQL (1834 linhas total):

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

*-- Linhas 786 a 827:
786:         LOCAL loc_cCidChaves
787:         loc_cCidChaves = ""
788:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
789:             SELECT cursor_4c_Dados
790:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
791:         ENDIF
792:         IF EMPTY(loc_cCidChaves)
793:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
794:             RETURN
795:         ENDIF
796:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
797:             THIS.this_cModoAtual = "VISUALIZAR"
798:             THIS.BOParaForm()
799:             THIS.HabilitarCampos(.F.)
800:             THIS.AjustarBotoesPorModo()
801:             THIS.AlternarPagina(2)
802:         ENDIF
803:     ENDPROC
804: 
805:     *====================================================================
806:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
807:     *====================================================================
808:     PROCEDURE BtnAlterarClick()
809:         LOCAL loc_cCidChaves
810:         loc_cCidChaves = ""
811:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
812:             SELECT cursor_4c_Dados
813:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
814:         ENDIF
815:         IF EMPTY(loc_cCidChaves)
816:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
817:             RETURN
818:         ENDIF
819:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
820:             THIS.this_oBusinessObject.EditarRegistro()
821:             THIS.this_cModoAtual = "ALTERAR"
822:             THIS.BOParaForm()
823:             THIS.HabilitarCampos(.T.)
824:             THIS.AjustarBotoesPorModo()
825:             THIS.AlternarPagina(2)
826:         ENDIF
827:     ENDPROC

*-- Linhas 834 a 852:
834:         loc_cCidChaves = ""
835:         loc_lConfirma  = .F.
836:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
837:             SELECT cursor_4c_Dados
838:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
839:         ENDIF
840:         IF EMPTY(loc_cCidChaves)
841:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
842:             RETURN
843:         ENDIF
844:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
845:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
846:         IF loc_lConfirma
847:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
848:                 IF THIS.this_oBusinessObject.Excluir()
849:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
850:                         "da com sucesso!", "Sucesso")
851:                     THIS.CarregarLista()
852:                 ENDIF

*-- Linhas 1040 a 1069:
1040:         ENDIF
1041: 
1042:         SET NULL ON
1043:         CREATE CURSOR cursor_4c_Itens ;
1044:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1045:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1046:              PromoPro C(35), Vendavels N(1,0) NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1049: 
1050:         SET NULL ON
1051:         CREATE CURSOR cursor_4c_Grupos ;
1052:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1053:         SET NULL OFF
1054:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1055: 
1056:         *-- Atualizar grids com cursores limpos
1057:         TRY
1058:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1059:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1060:         CATCH TO loException
1061:             MostrarErro(loException, "FormPrm.LimparCampos")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *====================================================================
1066:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1067:     *====================================================================
1068:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1069:         LOCAL loc_oPg2

*-- Linhas 1128 a 1148:
1128:             IF USED("cursor_4c_BuscaLpc")
1129:                 USE IN cursor_4c_BuscaLpc
1130:             ENDIF
1131:             loc_nResult = SQLEXEC(gnConnHandle, ;
1132:                 "SELECT TOP 1 LPrecos FROM SigCdLpc WHERE LPrecos = " + ;
1133:                 EscaparSQL(loc_cLPrecos), "cursor_4c_BuscaLpc")
1134: 
1135:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaLpc") AND !EOF("cursor_4c_BuscaLpc")
1136:                 *-- Encontrado exatamente
1137:                 loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1138:             ELSE
1139:                 *-- Nao encontrado: busca LIKE + picker (Pattern A canonico)
1140:                 IF USED("cursor_4c_BuscaLpc")
1141:                     USE IN cursor_4c_BuscaLpc
1142:                 ENDIF
1143:                 THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1144: 
1145:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1146:                 IF VARTYPE(loc_oBusca) = "O"
1147:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLpc"
1148:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;

*-- Linhas 1221 a 1298:
1221:             .GridLineColor   = RGB(238, 238, 238)
1222:             .GridLines       = 3
1223:             .HighlightStyle  = 2
1224:             .DeleteMark      = .F.
1225:             .RecordMark      = .F.
1226:             .RowHeight       = 18
1227:             .ScrollBars      = 3
1228:             .ReadOnly        = .F.
1229:         ENDWITH
1230: 
1231:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1232:         loc_oGrid.ColumnCount = 6
1233:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1234: 
1235:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1236:         WITH loc_oGrid.Column1
1237:             .ControlSource   = "cursor_4c_Itens.CPros"
1238:             .Width           = 100
1239:             .Sparse          = .F.
1240:             .Header1.Caption = ""
1241:         ENDWITH
1242:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1243: 
1244:         WITH loc_oGrid.Column2
1245:             .ControlSource   = "cursor_4c_Itens.DPros"
1246:             .Width           = 200
1247:             .ReadOnly        = .T.
1248:             .Sparse          = .F.
1249:             .Header1.Caption = ""
1250:         ENDWITH
1251: 
1252:         WITH loc_oGrid.Column3
1253:             .ControlSource   = "cursor_4c_Itens.Pecas"
1254:             .Width           = 70
1255:             .Sparse          = .F.
1256:             .Header1.Caption = ""
1257:         ENDWITH
1258: 
1259:         WITH loc_oGrid.Column4
1260:             .ControlSource   = "cursor_4c_Itens.CBars"
1261:             .Width           = 80
1262:             .Sparse          = .F.
1263:             .ReadOnly        = .T.
1264:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1265:         ENDWITH
1266: 
1267:         WITH loc_oGrid.Column5
1268:             .ControlSource   = "cursor_4c_Itens.Datas"
1269:             .Width           = 80
1270:             .Sparse          = .F.
1271:             .Header1.Caption = "Data Inicial"
1272:         ENDWITH
1273:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1274: 
1275:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1276:         WITH loc_oGrid.Column6
1277:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1278:             .Width           = 35
1279:             .Sparse          = .F.
1280:             .Header1.Caption = "V"
1281:             .AddObject("chk_4c_Vendavel", "CheckBox")
1282:             WITH .chk_4c_Vendavel
1283:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1284:                 .Caption       = ""
1285:                 .Alignment     = 0
1286:                 .ReadOnly      = .F.
1287:                 .Visible       = .T.
1288:                 .Top           = 9
1289:                 .Left          = 2
1290:                 .Height        = 17
1291:                 .Width         = 22
1292:             ENDWITH
1293:             .CurrentControl  = "chk_4c_Vendavel"
1294:         ENDWITH
1295:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1296:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1297: 
1298:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")

*-- Linhas 1377 a 1416:
1377:             .GridLineColor   = RGB(238, 238, 238)
1378:             .GridLines       = 3
1379:             .HighlightStyle  = 2
1380:             .DeleteMark      = .F.
1381:             .RecordMark      = .F.
1382:             .RowHeight       = 18
1383:             .ScrollBars      = 3
1384:             .ReadOnly        = .F.
1385:         ENDWITH
1386: 
1387:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1388:         loc_oGrid.ColumnCount = 2
1389:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1390: 
1391:         *-- ControlSources e Headers APOS RecordSource
1392:         WITH loc_oGrid.Column1
1393:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1394:             .Width           = 80
1395:             .Sparse          = .F.
1396:             .Header1.Caption = "Grp. Venda"
1397:         ENDWITH
1398:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1399: 
1400:         WITH loc_oGrid.Column2
1401:             .ControlSource   = "cursor_4c_Grupos.Datas"
1402:             .Width           = 80
1403:             .Sparse          = .F.
1404:             .Header1.Caption = "Data Inicial"
1405:         ENDWITH
1406:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1407: 
1408:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1409:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1410:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1411:             .Caption      = "Apagar"
1412:             .Top          = 161
1413:             .Left         = 451
1414:             .Width        = 50
1415:             .Height       = 50
1416:             .FontName     = "Tahoma"

*-- Linhas 1423 a 1466:
1423: 
1424:     *====================================================================
1425:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1426:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1427:     *====================================================================
1428:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1429:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1430:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1431: 
1432:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1433:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1434:             RETURN
1435:         ENDIF
1436: 
1437:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1438:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1439: 
1440:         IF EMPTY(loc_cCpros)
1441:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1442:             RETURN
1443:         ENDIF
1444: 
1445:         TRY
1446:             IF USED("cursor_4c_FigJpg")
1447:                 USE IN cursor_4c_FigJpg
1448:             ENDIF
1449:             loc_nResult = SQLEXEC(gnConnHandle, ;
1450:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1451:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1452:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1453:                     !EOF("cursor_4c_FigJpg") AND ;
1454:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1455:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1456:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1457:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1458:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1459:             ELSE
1460:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1461:             ENDIF
1462:             IF USED("cursor_4c_FigJpg")
1463:                 USE IN cursor_4c_FigJpg
1464:             ENDIF
1465:         CATCH TO loException
1466:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")

*-- Linhas 1492 a 1510:
1492:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1493:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1494:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1495:                     SELECT cursor_4c_BuscaProd
1496:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1497:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1498:                 ENDIF
1499:                 IF USED("cursor_4c_BuscaProd")
1500:                     USE IN cursor_4c_BuscaProd
1501:                 ENDIF
1502:             ELSE
1503:                 IF USED("cursor_4c_BuscaProd")
1504:                     USE IN cursor_4c_BuscaProd
1505:                 ENDIF
1506:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1507:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1508:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1509:                 IF VARTYPE(loc_oBusca) = "O"
1510:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"

*-- Linhas 1547 a 1565:
1547:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1548:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1549:             TRY
1550:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1551:                 GO BOTTOM IN cursor_4c_Itens
1552:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1553:             CATCH TO loException
1554:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1555:             ENDTRY
1556:         ENDIF
1557: 
1558:         RETURN .T.
1559:     ENDPROC
1560: 
1561:     *====================================================================
1562:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1563:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1564:     *====================================================================
1565:     PROCEDURE GridCheckVendavelClick()

*-- Linhas 1609 a 1627:
1609:             RETURN .T.
1610:         ENDIF
1611: 
1612:         SELECT cursor_4c_Itens
1613:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1614: 
1615:         IF FOUND()
1616:             loc_oPgP.grd_4c_Produtos.Refresh
1617:         ENDIF
1618: 
1619:         RETURN .T.
1620:     ENDPROC
1621: 
1622:     *====================================================================
1623:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1624:     * Legado: getBusca.LostFocus - focus col_CPros
1625:     *====================================================================
1626:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1627:         LOCAL loc_oPgP

*-- Linhas 1636 a 1686:
1636: 
1637:     *====================================================================
1638:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1639:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1640:     *====================================================================
1641:     PROCEDURE BtnApagarItemClick()
1642:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1643:         loc_lAbortou = .F.
1644: 
1645:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1646:             RETURN
1647:         ENDIF
1648: 
1649:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1650:             RETURN
1651:         ENDIF
1652: 
1653:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1654: 
1655:         TRY
1656:             *-- Excluir do banco se registro ja persistido
1657:             IF !EMPTY(loc_cIdChaves)
1658:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1659:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1660:                 IF loc_nResult < 0
1661:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1662:                     loc_lAbortou = .T.
1663:                 ENDIF
1664:             ENDIF
1665: 
1666:             IF !loc_lAbortou
1667:                 SELECT cursor_4c_Itens
1668:                 DELETE
1669:                 PACK
1670:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1671:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1672:                 ENDIF
1673:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1674:             ENDIF
1675:         CATCH TO loException
1676:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1677:         ENDTRY
1678:     ENDPROC
1679: 
1680:     *====================================================================
1681:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1682:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1683:     *====================================================================
1684:     PROCEDURE ValidarColecao()
1685:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1686: 

*-- Linhas 1698 a 1718:
1698:             IF USED("cursor_4c_BuscaCol")
1699:                 USE IN cursor_4c_BuscaCol
1700:             ENDIF
1701:             loc_nResult = SQLEXEC(gnConnHandle, ;
1702:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1703:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1704: 
1705:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1706:                 *-- Encontrado: manter valor atual
1707:             ELSE
1708:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1709:                 IF USED("cursor_4c_BuscaCol")
1710:                     USE IN cursor_4c_BuscaCol
1711:                 ENDIF
1712:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1713: 
1714:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1715:                 IF VARTYPE(loc_oBusca) = "O"
1716:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
1717:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1718:                         "Selecionar Grupo de Venda")

*-- Linhas 1750 a 1813:
1750:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1751:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1752:             TRY
1753:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1754:                 GO BOTTOM IN cursor_4c_Grupos
1755:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1756:             CATCH TO loException
1757:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1758:             ENDTRY
1759:         ENDIF
1760: 
1761:         RETURN .T.
1762:     ENDPROC
1763: 
1764:     *====================================================================
1765:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1766:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1767:     *====================================================================
1768:     PROCEDURE BtnApagarGrupoClick()
1769:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1770:         loc_lAbortou = .F.
1771: 
1772:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1773:             RETURN
1774:         ENDIF
1775: 
1776:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1777:             RETURN
1778:         ENDIF
1779: 
1780:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1781: 
1782:         TRY
1783:             *-- Excluir do banco se registro ja persistido
1784:             IF !EMPTY(loc_cIdChaves)
1785:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1786:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1787:                 IF loc_nResult < 0
1788:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1789:                     loc_lAbortou = .T.
1790:                 ENDIF
1791:             ENDIF
1792: 
1793:             IF !loc_lAbortou
1794:                 SELECT cursor_4c_Grupos
1795:                 DELETE
1796:                 PACK
1797:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1798:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1799:                 ENDIF
1800:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1801:             ENDIF
1802:         CATCH TO loException
1803:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1804:         ENDTRY
1805:     ENDPROC
1806: 
1807:     *====================================================================
1808:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1809:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1810:     *====================================================================
1811:     PROCEDURE GradesActivate()
1812:         LOCAL loc_cPromos, loc_oPg2
1813:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1821 a 1834:
1821:             GO BOTTOM IN cursor_4c_Grupos
1822:             IF EOF("cursor_4c_Grupos") OR ;
1823:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1824:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1825:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1826:                     VALUES (loc_cPromos, DATETIME())
1827:             ENDIF
1828:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1829:         CATCH TO loException
1830:             MostrarErro(loException, "FormPrm.GradesActivate")
1831:         ENDTRY
1832:     ENDPROC
1833: 
1834: ENDDEFINE


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

