# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, EMPS, CONFERIDO, CUNIS, ICLIS, JOBS, USUARS, GRUPOS, INATIVAS, CBARS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODS, EMPS, CONFERIDO, CUNIS, ICLIS, JOBS, USUARS, GRUPOS, INATIVAS, CBARS, CPROS

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
  ControlSource = "crSigCdCrf.Vends"
  ControlSource = "crSigCdCrf.Cods"
  ControlSource = "crSigCdCrf.DesVends"
  DeleteMark = .F.
If Not Thisform.poDataMgr.Update('crSigCdCrf')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCrf)')
If llOk And Not Thisform.poDataMgr.Update('crSigCdCri')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCri)')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCrf Where Cods = ?lcCods], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCri Where Cods = ?lcCods], '') < 1)
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCrf Where Cods = ?lcCods], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCri Where Cods = ?lcCods], '') < 1)
If llOk And Not Thisform.poDataMgr.Update('crSigCdCrf')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCrf)')
If llOk And Not Thisform.poDataMgr.Update('crSigCdCri')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdCri)')
	lcQryCnl = [select a.*, b.rclis as desvends ] + ;
				[from SigCdCrf a ] + ;
				[join sigcdcli b on a.vends = b.iclis ] + ;
	lcSqlCdCni = [Select * From SigCdCri Where Cods = ?lcCods]
Select crSigCdCrf
lnOldSel = Select()
lcQuery = [Select a.Emps, a.Grupos, a.Estos, a.cpros, sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr, b.cbars ] + ;  
	[From SigMvEst a ] + ;    
	[Join SigCdpro b on a.CPros = b.Cpros ] + ;    
	[Join SigCdCli c on a.Estos = c.Iclis ] + ;    
	[join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas ] + ;   
If (ThisForm.podatamgr.SqlExecute(lcQuery,[csSigCdCri])<1)
	Select(lnOldSel)
Select csSigCdCri
Select crSigCdCri
	If Seek(crSigCdCri.Emps + crSigCdCri.Grupos + crSigCdCri.Estos + crSigCdCri.Cpros,[csSigCdCri],[EmpGruEsts])
	Select csSigCdCri
		If Not Seek(csSigCdCri.Emps + csSigCdCri.Grupos + csSigCdCri.Estos + csSigCdCri.Cpros,[crSigCdCri],[EmpGruEsts])
			Delete 
		Select csSigCdCri
Select crSigCdCri
Select csSigCdCri
Thisform.pagina.dados.GrdLoc.column1.ControlSource = [csSigCdCri.Emps]
Thisform.pagina.dados.GrdLoc.column2.ControlSource = [csSigCdCri.QtdCtg]
Thisform.pagina.dados.GrdLoc.column3.ControlSource = [csSigCdCri.Qtde] 
Thisform.pagina.dados.GrdLoc.column4.ControlSource = [csSigCdCri.Grupos] 
Thisform.pagina.dados.GrdLoc.column5.ControlSource = [csSigCdCri.Estos] 
Thisform.pagina.dados.GrdLoc.column6.ControlSource = [csSigCdCri.Cpros] 
Select(lnOldSel)
	Select csSigCdCri
		Select crSigCdCri
		Select csSigCdCri
	Select crSigCdCri
lnOldSel = Select()
lcQuery = [Select a.Emps, a.Grupos, a.Estos, a.cpros, sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr ] + ;  
	[From SigMvEst a ] + ;    
	[Join SigCdpro b on a.CPros = b.Cpros ] + ;    
	[Join SigCdCli c on a.Estos = c.Iclis ] + ;    
	[join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas ] + ;   
If (ThisForm.podatamgr.SqlExecute(lcQuery,[csTmpCdCrI])<1)
	Select(lnOldSel)
Select csTmpCdCrI
Select(lnOldSel)
Select CrSigCdCrf
	Select CrSigCdCrf
		lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigCdCrf'),1,-1)
Select CrSigCdCrf
	Select CrSigCdCrf
		lnErro1 = Iif(Thisform.poDataMgr.Update('CrSigCdCrf'),1,-1)
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
			[Inner Join SigCdAce c on a.Iclis = c.Usuarios ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+This.Value+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVends
	If Seek(This.Value,'CrSigVends','Iclis')
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+lcVends+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVendsf
	If Seek(This.Value,'CrSigVends','Rclis')
Select csSigCdCri
Select csSigCdCri
	Select crTPro
	Select csSigCdCri
		Select RecNo() As nRecNo From csSigCdCri Where CBars = Int(Val(Alltrim(lnCBars))) Into Cursor csProcura
		Select RecNo() As nRecNo From csSigCdCri Where Cpros = lcCpros Into Cursor csProcura
	Select csProcura
		Select csSigCdCri
		Select csSigCdCri
			Select crTPro
	Select csSigCdCri
		Update csSigCdCri Set QtdCtg = lnQtds Where CBars = Int(Val(Alltrim(lcBusca)))
		Update csSigCdCri Set QtdCtg = lnQtds Where Cpros = lcBusca

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1785 linhas total):

*-- Linhas 399 a 417:
399:             .HighlightBackColor = RGB(255, 255, 255)
400:             .HighlightForeColor = RGB(15, 41, 104)
401:             .HighlightStyle     = 2
402:             .DeleteMark         = .F.
403:             .RecordMark         = .F.
404:             .RowHeight          = 16
405:             .ScrollBars         = 2
406:         ENDWITH
407: 
408:         *-- BINDEVENT: botoes CRUD
409:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
410:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
411:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
412:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
415: 
416:         *-- BINDEVENT: botoes especiais
417:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")

*-- Linhas 754 a 772:
754:             .HighlightBackColor = RGB(255, 255, 255)
755:             .HighlightForeColor = RGB(15, 41, 104)
756:             .HighlightStyle     = 2
757:             .DeleteMark         = .F.
758:             .RecordMark         = .F.
759:             .RowHeight          = 16
760:             .ScrollBars         = 2
761: 
762:             .Column1.Header1.Caption = "Emp."
763:             .Column1.Width           = 40
764:             .Column1.ReadOnly        = .T.
765: 
766:             .Column2.Header1.Caption = "Qtde."
767:             .Column2.Width           = 60
768: 
769:             .Column3.Header1.Caption = "Estoque"
770:             .Column3.Width           = 60
771:             .Column3.ReadOnly        = .T.
772: 

*-- Linhas 844 a 898:
844: 
845:     *==========================================================================
846:     * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
847:     * Reconfigura RecordSource, ControlSource e Headers apos cada carga
848:     *==========================================================================
849:     PROCEDURE CarregarLista()
850:         LOCAL loc_lResultado, loc_oGrid
851:         loc_lResultado = .F.
852: 
853:         TRY
854:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
855:                 loc_lResultado = .T.
856:             ELSE
857:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
858:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroLista)
859:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
860: 
861:                     *-- RecordSource + ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
862:                     loc_oGrid.ColumnCount = 3
863:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
864:                     loc_oGrid.ColumnCount  = 5
865: 
866:                     WITH loc_oGrid
867:                         .Column1.ControlSource   = "cursor_4c_Dados.Cods"
868:                         .Column1.Width           = 80
869:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
870: 
871:                         .Column2.ControlSource   = "cursor_4c_Dados.Datas"
872:                         .Column2.Width           = 90
873:                         .Column2.Header1.Caption = "Data"
874: 
875:                         .Column3.ControlSource   = "cursor_4c_Dados.Vends"
876:                         .Column3.Width           = 80
877:                         .Column3.Header1.Caption = "Vendedor"
878: 
879:                         .Column4.ControlSource   = "cursor_4c_Dados.DesVends"
880:                         .Column4.Width           = 400
881:                         .Column4.Header1.Caption = "Nome do Vendedor"
882: 
883:                         .Column5.ControlSource   = "cursor_4c_Dados.Conferido"
884:                         .Column5.Width           = 70
885:                         .Column5.Header1.Caption = "Encerrada"
886:                     ENDWITH
887: 
888:                     THIS.FormatarGridLista(loc_oGrid)
889:                     loc_lResultado = .T.
890:                 ENDIF
891:                 ENDIF
892:             ENDIF
893:         CATCH TO loException
894:             MostrarErro(loException, "Formcrf.CarregarLista")
895:         ENDTRY
896: 
897:         RETURN loc_lResultado
898:     ENDPROC

*-- Linhas 1003 a 1021:
1003:             RETURN
1004:         ENDIF
1005: 
1006:         SELECT cursor_4c_Dados
1007:         loc_cCods = ALLTRIM(TratarNulo(Cods, "C"))
1008: 
1009:         IF EMPTY(loc_cCods)
1010:             MsgAviso("C" + CHR(243) + "digo inv" + CHR(225) + "lido.")
1011:             RETURN
1012:         ENDIF
1013: 
1014:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
1015:             RETURN
1016:         ENDIF
1017: 
1018:         IF !THIS.this_oBusinessObject.CarregarItensContagem(loc_cCods, .T.)
1019:             RETURN
1020:         ENDIF
1021: 

*-- Linhas 1039 a 1057:
1039:             RETURN
1040:         ENDIF
1041: 
1042:         SELECT cursor_4c_Dados
1043:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1044:         loc_nConferido = TratarNulo(Conferido, "N")
1045: 
1046:         IF loc_nConferido = 1
1047:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1048:             RETURN
1049:         ENDIF
1050: 
1051:         IF !THIS.this_oBusinessObject.CarregarParametros()
1052:             RETURN
1053:         ENDIF
1054: 
1055:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)
1056:             RETURN
1057:         ENDIF

*-- Linhas 1081 a 1099:
1081:             RETURN
1082:         ENDIF
1083: 
1084:         SELECT cursor_4c_Dados
1085:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1086:         loc_nConferido = TratarNulo(Conferido, "N")
1087: 
1088:         IF loc_nConferido = 1
1089:             MsgAviso("Contagem J" + CHR(225) + " Encerrada. " + ;
1090:                      "Reabra antes de excluir.")
1091:             RETURN
1092:         ENDIF
1093: 
1094:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o desta contagem?", ;
1095:                         "Confirmar Exclus" + CHR(227) + "o")
1096:             RETURN
1097:         ENDIF
1098: 
1099:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCods)

*-- Linhas 1178 a 1196:
1178:             RETURN
1179:         ENDIF
1180: 
1181:         SELECT cursor_4c_Dados
1182:         loc_nConferido = TratarNulo(Conferido, "N")
1183: 
1184:         IF loc_nConferido = 1
1185:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1186:             RETURN
1187:         ENDIF
1188: 
1189:         IF !MsgConfirma("Deseja gerar espelho do estoque para esta contagem?", "Espelho")
1190:             RETURN
1191:         ENDIF
1192: 
1193:         IF THIS.this_oBusinessObject.CarregarProdutosEstoque()
1194:             MsgInfo("Espelho de estoque gerado com sucesso!")
1195:             THIS.CarregarGridItens()
1196:         ENDIF

*-- Linhas 1209 a 1227:
1209:             RETURN
1210:         ENDIF
1211: 
1212:         SELECT cursor_4c_Dados
1213:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1214:         loc_nConferido = TratarNulo(Conferido, "N")
1215: 
1216:         IF loc_nConferido = 1
1217:             MsgAviso("Contagem J" + CHR(225) + " Encerrada!!!")
1218:             RETURN
1219:         ENDIF
1220: 
1221:         IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Finalizada. " + ;
1222:                         "Deseja encerrar a Contagem???", ;
1223:                         "ATEN" + CHR(199) + CHR(195) + "O !!!")
1224:             RETURN
1225:         ENDIF
1226: 
1227:         IF THIS.this_oBusinessObject.EncerrarContagem(loc_cCods)

*-- Linhas 1243 a 1261:
1243:             RETURN
1244:         ENDIF
1245: 
1246:         SELECT cursor_4c_Dados
1247:         loc_cCods      = ALLTRIM(TratarNulo(Cods,      "C"))
1248:         loc_nConferido = TratarNulo(Conferido, "N")
1249: 
1250:         IF loc_nConferido = 0
1251:             MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada!!!")
1252:             RETURN
1253:         ENDIF
1254: 
1255:         IF !MsgConfirma("Esta Contagem ser" + CHR(225) + " Aberta Novamente. " + ;
1256:                         "Deseja Continuar a Contagem???", ;
1257:                         "ATEN" + CHR(199) + CHR(195) + "O !!!")
1258:             RETURN
1259:         ENDIF
1260: 
1261:         IF THIS.this_oBusinessObject.ReabrirContagem(loc_cCods)

*-- Linhas 1296 a 1314:
1296:         ENDIF
1297: 
1298:         IF RECCOUNT("cursor_4c_Vendedores") = 1
1299:             SELECT cursor_4c_Vendedores
1300:             GO TOP
1301:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1302:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1303:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1304:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1305:             IF USED("cursor_4c_Vendedores")
1306:                 USE IN cursor_4c_Vendedores
1307:             ENDIF
1308:         ELSE
1309:             THIS.AbrirBuscaVendedor(loc_cCodigo)
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *==========================================================================
1314:     * AbrirBuscaVendedor - Abre FormBuscaAuxiliar no cursor_4c_Vendedores

*-- Linhas 1330 a 1348:
1330:             loc_oBusca.Show()
1331: 
1332:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Vendedores")
1333:                 SELECT cursor_4c_Vendedores
1334:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1335:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1336:                 THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1337:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1338:             ELSE
1339:                 loc_oPagina.txt_4c_Conta.Value  = ""
1340:                 loc_oPagina.txt_4c_DConta.Value = ""
1341:             ENDIF
1342: 
1343:             loc_oBusca.Release()
1344:         ENDIF
1345: 
1346:         IF USED("cursor_4c_Vendedores")
1347:             USE IN cursor_4c_Vendedores
1348:         ENDIF

*-- Linhas 1486 a 1545:
1486:     *==========================================================================
1487:     * CarregarGridItens - Vincula grd_4c_Dados ao cursor csSigCdCri e formata
1488:     * RecordSource e ColumnCount fora do WITH (Problema 36)
1489:     * ControlSource e Headers redefinidos apos RecordSource (reset automatico)
1490:     *==========================================================================
1491:     PROTECTED PROCEDURE CarregarGridItens()
1492:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
1493:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1494: 
1495:         TRY
1496:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1497:                 loc_oGrid   = loc_oPagina.grd_4c_Dados
1498:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1499: 
1500:                 *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
1501:                 loc_oGrid.RecordSource = loc_cCursor
1502:                 loc_oGrid.ColumnCount  = 6
1503: 
1504:                 WITH loc_oGrid
1505:                     .Column1.ControlSource   = loc_cCursor + ".Emps"
1506:                     .Column1.Width           = 40
1507:                     .Column1.ReadOnly        = .T.
1508:                     .Column1.Header1.Caption = "Emp."
1509: 
1510:                     .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
1511:                     .Column2.Width           = 60
1512:                     .Column2.ReadOnly        = .F.
1513:                     .Column2.Header1.Caption = "Qtde."
1514: 
1515:                     .Column3.ControlSource   = loc_cCursor + ".qtde"
1516:                     .Column3.Width           = 60
1517:                     .Column3.ReadOnly        = .T.
1518:                     .Column3.Header1.Caption = "Estoque"
1519: 
1520:                     .Column4.ControlSource   = loc_cCursor + ".Grupos"
1521:                     .Column4.Width           = 60
1522:                     .Column4.ReadOnly        = .T.
1523:                     .Column4.Header1.Caption = "Grupo"
1524: 
1525:                     .Column5.ControlSource   = loc_cCursor + ".Estos"
1526:                     .Column5.Width           = 80
1527:                     .Column5.ReadOnly        = .T.
1528:                     .Column5.Header1.Caption = "Conta"
1529: 
1530:                     .Column6.ControlSource   = loc_cCursor + ".Descr"
1531:                     .Column6.Width           = 177
1532:                     .Column6.ReadOnly        = .T.
1533:                     .Column6.Header1.Caption = "Produto"
1534:                 ENDWITH
1535: 
1536:                 THIS.FormatarGridLista(loc_oGrid)
1537:                 loc_oGrid.Refresh()
1538:             ENDIF
1539:         CATCH TO loException
1540:             MostrarErro(loException, "Formcrf.CarregarGridItens")
1541:         ENDTRY
1542:     ENDPROC
1543: 
1544:     *==========================================================================
1545:     * ValidarBusca - LostFocus de txt_4c_Busca

*-- Linhas 1559 a 1592:
1559: 
1560:         TRY
1561:             IF loc_nOpt = 1
1562:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1563:                     WHERE ALLTRIM(CBars) = m.loc_cBusca ;
1564:                     INTO CURSOR csProcuraBusca
1565:             ELSE
1566:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1567:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca ;
1568:                     INTO CURSOR csProcuraBusca
1569:             ENDIF
1570: 
1571:             IF USED("csProcuraBusca") AND !EOF("csProcuraBusca") AND RECCOUNT("csProcuraBusca") > 0
1572:                 SELECT csProcuraBusca
1573:                 GO TOP
1574:                 loc_nRecNo = nRecNo
1575:                 USE IN csProcuraBusca
1576: 
1577:                 SELECT csSigCdCri
1578:                 GO loc_nRecNo
1579:                 loc_oPagina.txt_4c_DContas.Value = ALLTRIM(TratarNulo(Descr, "C"))
1580:                 loc_oPagina.grd_4c_Dados.Refresh()
1581: 
1582:                 IF PEMSTATUS(loc_oPagina.txt_4c_TotQt, "SetFocus", 5)
1583:                     loc_oPagina.txt_4c_TotQt.SetFocus()
1584:                 ENDIF
1585:             ELSE
1586:                 IF USED("csProcuraBusca")
1587:                     USE IN csProcuraBusca
1588:                 ENDIF
1589:                 MsgAviso("Produto n" + CHR(227) + "o encontrado.")
1590:                 loc_oPagina.txt_4c_DContas.Value = ""
1591:                 loc_oPagina.txt_4c_Busca.Value   = ""
1592:                 IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)

*-- Linhas 1618 a 1639:
1618: 
1619:         TRY
1620:             IF loc_nOpt = 1
1621:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1622:                     WHERE ALLTRIM(CBars) = m.loc_cBusca
1623:             ELSE
1624:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1625:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca
1626:             ENDIF
1627: 
1628:             loc_oPagina.txt_4c_Busca.Value    = ""
1629:             loc_oPagina.txt_4c_TotQt.Value    = 0
1630:             loc_oPagina.txt_4c_DContas.Value  = ""
1631:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1632:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1633:             loc_oPagina.grd_4c_Dados.Refresh()
1634: 
1635:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1636:                 loc_oPagina.txt_4c_Busca.SetFocus()
1637:             ENDIF
1638:         CATCH TO loException
1639:             MostrarErro(loException, "Formcrf.ValidarQuantidade")

*-- Linhas 1653 a 1671:
1653:         ENDIF
1654: 
1655:         TRY
1656:             SELECT csSigCdCri
1657:             loc_cCpros = ALLTRIM(TratarNulo(Cpros, "C"))
1658:             loc_cDescr = ALLTRIM(TratarNulo(Descr, "C"))
1659: 
1660:             loc_oPagina.txt_4c_DContas.Value = loc_cDescr
1661: 
1662:             IF !EMPTY(loc_cCpros)
1663:                 THIS.CarregarImagemProduto(loc_cCpros)
1664:             ELSE
1665:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1666:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1667:             ENDIF
1668:         CATCH TO loException
1669:             MostrarErro(loException, "Formcrf.GridDadosAfterRowColChange")
1670:         ENDTRY
1671:     ENDPROC

*-- Linhas 1679 a 1704:
1679:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1680: 
1681:         TRY
1682:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro" + ;
1683:                           " WHERE RTRIM(Cpros) = " + EscaparSQL(par_cCpros)
1684:             loc_nRetSQL = SQLEXEC(gnConnHandle, loc_cSQL, "csImgProduto")
1685: 
1686:             IF loc_nRetSQL > 0 AND USED("csImgProduto") AND ;
1687:                     !EOF("csImgProduto") AND !EMPTY(ALLTRIM(csImgProduto.FigJpgs))
1688: 
1689:                 SELECT csImgProduto
1690:                 GO TOP
1691:                 loc_cBase64 = ALLTRIM(FigJpgs)
1692: 
1693:                 IF "base64," $ loc_cBase64
1694:                     loc_cBase64 = SUBSTR(loc_cBase64, AT("base64,", loc_cBase64) + 7)
1695:                 ENDIF
1696: 
1697:                 IF !EMPTY(loc_cBase64)
1698:                     loc_cTmpFile = SYS(2023) + "\4c_img_tmp.jpg"
1699:                     STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTmpFile)
1700: 
1701:                     IF FILE(loc_cTmpFile)
1702:                         loc_oPagina.img_4c_ImgJpg.Picture = loc_cTmpFile
1703:                         loc_oPagina.img_4c_ImgJpg.Visible = .T.
1704:                     ELSE


### BO (C:\4c\projeto\app\classes\crfBO.prg):
*============================================================================
* crfBO.prg - Business Object para Contagem de Referencia (SigCdCrf)
* Herda de BusinessBase
* Tabela principal: SigCdCrf (cabecalho da contagem)
* Tabela detalhe  : SigCdCri (itens/produtos da contagem)
*============================================================================

DEFINE CLASS crfBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdCrf (cabecalho da contagem)
    *--------------------------------------------------------------------------
    this_cCods      = ""    && PK: Codigo da contagem C(10) - gerado por fGerUniqueKey
    this_cEmps      = ""    && Empresa C(3)
    this_cVends     = ""    && Codigo do vendedor C(10) - FK SigCdCli.Iclis
    this_cDesVends  = ""    && Nome do vendedor - virtual do JOIN com SigCdCli.Rclis
    this_dDatas     = {}    && Data da contagem (Date)
    this_nConferido = 0     && Status: 0=contagem aberta, 1=contagem encerrada
    this_cIdChaves  = ""    && Identificador unico do cabecalho - gerado por fUniqueIds

    *--------------------------------------------------------------------------
    * Propriedades auxiliares para operacao
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""           && Grupo padrao de vendedores (de SigCdPam.GrPadVens)
    this_cCursorItens  = "csSigCdCri" && Cursor de trabalho (itens vindos de SigMvEst)
    this_cCursorSalvar = "crSigCdCri" && Cursor de gravacao (itens para SigCdCri)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCrf"
            THIS.this_cCampoChave = "Cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "crfBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDFUNC

    *==========================================================================
    * Buscar - Lista contagens de referencia da empresa
    * par_cFiltro: filtro WHERE opcional (sem a palavra WHERE)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ;
                        (Cods C(10), Emps C(3), Vends C(10), Datas D, ;
                         Conferido N(1,0), cIdChaves C(10), DesVends C(50))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                           " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                           " FROM SigCdCrf a" + ;
                           " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                           " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Datas DESC, a.Cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar contagens:" + CHR(13) + CapturarErroSQL(), "crfBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "crfBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega contagem pelo codigo Cods
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Cods, a.Emps, a.Vends, a.Datas," + ;
                       " a.Conferido, a.cIdChaves, b.Rclis AS DesVends" + ;
                       " FROM SigCdCrf a" + ;
                       " LEFT JOIN SigCdCli b ON a.Vends = b.Iclis" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Contagem n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarPorCodigo")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "crfBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCods      = TratarNulo(Cods,      "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cVends     = TratarNulo(Vends,     "C")
                THIS.this_cDesVends  = TratarNulo(DesVends,  "C")
                THIS.this_dDatas     = TratarNulo(Datas,     "D")
                THIS.this_nConferido = TratarNulo(Conferido, "N")
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "crfBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigoContagem - Gera proximo codigo numerico para SigCdCrf
    *==========================================================================
    PROTECTED FUNCTION GerarCodigoContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nProxId
        loc_lSucesso = .F.
        loc_nProxId  = 1

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Cods)) AS BIGINT)), 0) + 1" + ;
                       " AS NextID FROM SigCdCrf WHERE ISNUMERIC(Cods) = 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxId")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_MaxId") > 0
                SELECT cursor_4c_MaxId
                loc_nProxId = TratarNulo(NextID, "N")
                IF loc_nProxId < 1
                    loc_nProxId = 1
                ENDIF
            ENDIF

            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF

            THIS.this_cCods     = PADL(ALLTRIM(STR(loc_nProxId, 10)), 10, " ")
            THIS.this_cIdChaves = SYS(2015)
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "crfBO.GerarCodigoContagem")
            IF USED("cursor_4c_MaxId")
                USE IN cursor_4c_MaxId
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - Insere cabecalho em SigCdCrf e itens de csSigCdCri em SigCdCri
    * Usa transacao explicita pois atualiza duas tabelas
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            IF !THIS.GerarCodigoContagem()
                MostrarErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "crfBO.Inserir")
            ELSE
                THIS.this_dDatas     = DATE()
                THIS.this_nConferido = 0

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                    VALUES (
                        <<EscaparSQL(THIS.this_cCods)>>,
                        <<EscaparSQL(THIS.this_cEmps)>>,
                        <<EscaparSQL(THIS.this_cVends)>>,
                        <<FormatarDataSQL(THIS.this_dDatas)>>,
                        <<EscaparSQL(THIS.this_cIdChaves)>>,
                        <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MostrarErro("Erro ao inserir cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Inserir")
                ELSE
                    loc_lSucesso = THIS.SalvarItensContagem()

                    IF loc_lSucesso
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("INSERT")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "crfBO.Inserir")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarItensContagem - Insere cada item de csSigCdCri em SigCdCri
    * Chamado dentro de transacao (Inserir/Atualizar)
    *==========================================================================
    PROTECTED FUNCTION SalvarItensContagem()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        LOCAL loc_cIdChave, loc_cEmps, loc_cGrupos, loc_cEstos
        LOCAL loc_cCpros, loc_nCBars, loc_nQtds, loc_nEstoque, loc_cDescr
        loc_lSucesso = .F.

        TRY
            IF !USED(THIS.this_cCursorItens)
                MostrarErro("Cursor de itens n" + CHR(227) + "o encontrado: " + THIS.this_cCursorItens, "crfBO.SalvarItensContagem")
            ELSE
                loc_lSucesso = .T.

                SELECT (THIS.this_cCursorItens)
                GO TOP

                SCAN WHILE loc_lSucesso
                    loc_cIdChave = SYS(2015)
                    loc_cEmps    = ALLTRIM(TratarNulo(Emps,   "C"))
                    loc_cGrupos  = ALLTRIM(TratarNulo(Grupos, "C"))
                    loc_cEstos   = ALLTRIM(TratarNulo(Estos,  "C"))
                    loc_cCpros   = ALLTRIM(TratarNulo(Cpros,  "C"))
                    loc_nCBars   = TratarNulo(CBars,   "N")
                    loc_nQtds    = TratarNulo(QtdCtg,  "N")
                    loc_nEstoque = TratarNulo(qtde,    "N")
                    loc_cDescr   = LEFT(ALLTRIM(TratarNulo(Descr, "C")), 60)

                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCri (cIdChaves, Cods, Emps, Grupos, Estos, Cpros, CBars, Qtds, Estoque, Descr)
                        VALUES (
                            <<EscaparSQL(loc_cIdChave)>>,
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(loc_cEmps)>>,
                            <<EscaparSQL(loc_cGrupos)>>,
                            <<EscaparSQL(loc_cEstos)>>,
                            <<EscaparSQL(loc_cCpros)>>,
                            <<FormatarNumeroSQL(loc_nCBars, 0)>>,
                            <<FormatarNumeroSQL(loc_nQtds, 2)>>,
                            <<FormatarNumeroSQL(loc_nEstoque, 2)>>,
                            <<EscaparSQL(loc_cDescr)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao salvar item [" + loc_cCpros + "]:" + CHR(13) + CapturarErroSQL(), "crfBO.SalvarItensContagem")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT (THIS.this_cCursorItens)
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "crfBO.SalvarItensContagem")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Delete+reinsert em SigCdCrf e SigCdCri (mesmo padrao do legado)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            THIS.this_dDatas    = DATE()
            THIS.this_cIdChaves = SYS(2015)

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Exclui itens existentes
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

            IF loc_nResultado < 0
                MostrarErro("Erro ao excluir itens anteriores:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
            ELSE
                *-- Exclui cabecalho existente
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir cabe" + CHR(231) + "alho anterior:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                ELSE
                    TEXT TO loc_cSQL TEXTMERGE NOSHOW
                        INSERT INTO SigCdCrf (Cods, Emps, Vends, Datas, cIdChaves, Conferido)
                        VALUES (
                            <<EscaparSQL(THIS.this_cCods)>>,
                            <<EscaparSQL(THIS.this_cEmps)>>,
                            <<EscaparSQL(THIS.this_cVends)>>,
                            <<FormatarDataSQL(THIS.this_dDatas)>>,
                            <<EscaparSQL(THIS.this_cIdChaves)>>,
                            <<FormatarNumeroSQL(THIS.this_nConferido, 0)>>
                        )
                    ENDTEXT

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        MostrarErro("Erro ao regravar cabe" + CHR(231) + "alho:" + CHR(13) + CapturarErroSQL(), "crfBO.Atualizar")
                    ELSE
                        loc_lSucesso = THIS.SalvarItensContagem()

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                            loc_lTransacao = .F.
                            THIS.RegistrarAuditoria("UPDATE")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "crfBO.Atualizar")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui contagem (itens + cabecalho) com verificacao
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nResultado, loc_lTransacao
        loc_lSucesso  = .F.
        loc_lTransacao = .F.

        TRY
            *-- Verifica se a contagem esta encerrada (nao pode excluir encerradas)
            IF THIS.this_nConferido = 1
                MsgAviso("Contagem J" + CHR(225) + " Encerrada. Reabra antes de excluir.")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdCri WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                IF loc_nResultado < 0
                    MostrarErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM SigCdCrf WHERE Cods = " + EscaparSQL(THIS.this_cCods))

                    IF loc_nResultado >= 0
                        SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        loc_lTransacao = .F.
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ExecutarExclusao")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "crfBO.ExecutarExclusao")
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega grupo padrao de vendedores de SigCdPam
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT GrPadVens FROM SigCdPam" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cGrPadVens = ALLTRIM(TratarNulo(GrPadVens, "C"))

                IF EMPTY(THIS.this_cGrPadVens)
                    MostrarErro("O Grupo Padr" + CHR(227) + "o de Vendedores n" + CHR(227) + "o est" + ;
                                CHR(225) + " configurado nos Par" + CHR(226) + "metros do Sistema.", ;
                                "Configura" + CHR(231) + CHR(227) + "o Incorreta")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MostrarErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados.", "crfBO.CarregarParametros")
            ENDIF

            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros:" + CHR(13) + loException.Message, "crfBO.CarregarParametros")
            IF USED("cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProdutosEstoque - Carrega produtos de SigMvEst em csSigCdCri
    * Usado ao iniciar nova contagem (modo INSERIR)
    *==========================================================================
    PROCEDURE CarregarProdutosEstoque()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " CONVERT(numeric(5,0), 0) AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0" + ;
                       " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar produtos do estoque:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarProdutosEstoque")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar estoque:" + CHR(13) + loException.Message, "crfBO.CarregarProdutosEstoque")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarItensContagem - Carrega produtos + mescla com itens de SigCdCri
    * Usado ao editar (ALTERAR) ou visualizar (CONSULTAR) contagem existente
    * par_cCodigo      : codigo da contagem (Cods)
    * par_lSoContados  : .T. = mostra apenas itens que foram contados (CONSULTAR)
    *==========================================================================
    PROCEDURE CarregarItensContagem(par_cCodigo, par_lSoContados)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            *-- Query unica: produtos do estoque com QtdCtg ja preenchida de SigCdCri
            loc_cSQL = "SELECT a.Emps, a.Grupos, a.Estos, a.cpros," + ;
                       " SUM(a.sqtds) AS qtde," + ;
                       " ISNULL(" + ;
                       "   (SELECT TOP 1 c.Qtds FROM SigCdCri c" + ;
                       "    WHERE c.Cods = " + EscaparSQL(par_cCodigo) + ;
                       "    AND c.Cpros = a.cpros AND c.Emps = a.Emps" + ;
                       "    AND c.Grupos = a.Grupos AND c.Estos = a.Estos), 0)" + ;
                       " AS QtdCtg," + ;
                       " b.dpros AS Descr, b.cbars AS CBars" + ;
                       " FROM SigMvEst a" + ;
                       " JOIN SigCdpro b ON a.CPros = b.Cpros" + ;
                       " JOIN SigCdCli c ON a.Estos = c.Iclis" + ;
                       " JOIN SigCtCtg d ON a.empgruests = d.empresa + d.grupos + d.contas" + ;
                       " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " AND b.cunis = 'UN'" + ;
                       " GROUP BY a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros, b.cbars" + ;
                       " HAVING SUM(a.sqtds) <> 0"

            IF par_lSoContados
                *-- CONSULTAR/Encerrada: filtra apenas itens que existem em SigCdCri
                loc_cSQL = loc_cSQL + ;
                           " AND EXISTS (SELECT 1 FROM SigCdCri cx" + ;
                           " WHERE cx.Cods = " + EscaparSQL(par_cCodigo) + ;
                           " AND cx.Cpros = a.cpros AND cx.Emps = a.Emps" + ;
                           " AND cx.Grupos = a.Grupos AND cx.Estos = a.Estos)"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens)

            IF loc_nResultado >= 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens da contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.CarregarItensContagem")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "crfBO.CarregarItensContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * EncerrarContagem - Define Conferido=1 na contagem especificada
    *==========================================================================
    PROCEDURE EncerrarContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 1" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 1
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao encerrar contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.EncerrarContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "crfBO.EncerrarContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ReabrirContagem - Define Conferido=0 na contagem especificada
    *==========================================================================
    PROCEDURE ReabrirContagem(par_cCodigo)
        LOCAL loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE SigCdCrf SET Conferido = 0" + ;
                " WHERE Cods = " + EscaparSQL(par_cCodigo) + ;
                " AND Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa))

            IF loc_nResultado >= 0
                THIS.this_nConferido = 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao reabrir contagem:" + CHR(13) + CapturarErroSQL(), "crfBO.ReabrirContagem")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao reabrir:" + CHR(13) + loException.Message, "crfBO.ReabrirContagem")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarVendedores - Pesquisa vendedores validos no grupo padrao
    * par_cValor: valor de busca inicial
    * par_cCampo: "Iclis" (por codigo) ou "Rclis" (por nome)
    *==========================================================================
    PROCEDURE BuscarVendedores(par_cValor, par_cCampo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltroVal
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cFiltroVal = IIF(EMPTY(par_cValor), "", ;
                " AND a." + ALLTRIM(par_cCampo) + " LIKE " + EscaparSQL(par_cValor + "%"))

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       loc_cFiltroVal + ;
                       " ORDER BY a.Iclis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Vendedores")

            IF loc_nResultado >= 0
                SELECT cursor_4c_Vendedores
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar vendedores:" + CHR(13) + CapturarErroSQL(), "crfBO.BuscarVendedores")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar vendedores:" + CHR(13) + loException.Message, "crfBO.BuscarVendedores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

