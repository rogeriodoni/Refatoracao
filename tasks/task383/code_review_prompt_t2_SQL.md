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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcrf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1788 linhas total):

*-- Linhas 403 a 421:
403:             .HighlightBackColor = RGB(255, 255, 255)
404:             .HighlightForeColor = RGB(15, 41, 104)
405:             .HighlightStyle     = 2
406:             .DeleteMark         = .F.
407:             .RecordMark         = .F.
408:             .RowHeight          = 16
409:             .ScrollBars         = 2
410:         ENDWITH
411: 
412:         *-- BINDEVENT: botoes CRUD
413:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
414:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
415:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
416:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
417:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
419: 
420:         *-- BINDEVENT: botoes especiais
421:         BINDEVENT(loc_oPagina.cnt_4c_BotoesEspeciais.cmd_4c_Espelho,        "Click", THIS, "BtnEspelhoClick")

*-- Linhas 758 a 776:
758:             .HighlightBackColor = RGB(255, 255, 255)
759:             .HighlightForeColor = RGB(15, 41, 104)
760:             .HighlightStyle     = 2
761:             .DeleteMark         = .F.
762:             .RecordMark         = .F.
763:             .RowHeight          = 16
764:             .ScrollBars         = 2
765: 
766:             .Column1.Header1.Caption = "Emp."
767:             .Column1.Width           = 40
768:             .Column1.ReadOnly        = .T.
769: 
770:             .Column2.Header1.Caption = "Qtde."
771:             .Column2.Width           = 60
772: 
773:             .Column3.Header1.Caption = "Estoque"
774:             .Column3.Width           = 60
775:             .Column3.ReadOnly        = .T.
776: 

*-- Linhas 848 a 894:
848: 
849:     *==========================================================================
850:     * CarregarLista - Carrega dados no grid da Page1 (cursor_4c_Dados)
851:     * Reconfigura RecordSource, ControlSource e Headers apos cada carga
852:     *==========================================================================
853:     PROCEDURE CarregarLista()
854:         LOCAL loc_lResultado, loc_oGrid
855:         loc_lResultado = .F.
856: 
857:         TRY
858:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
859:                 loc_lResultado = .T.
860:             ELSE
861:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
862:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroLista)
863:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
864: 
865:                     *-- RecordSource + ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
866:                     loc_oGrid.ColumnCount = 3
867:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
868:                     loc_oGrid.ColumnCount  = 3
869: 
870:                     WITH loc_oGrid
871:                         .Column1.ControlSource   = "cursor_4c_Dados.Datas"
872:                         .Column1.Width           = 80
873:                         .Column1.Header1.Caption = "Data"
874: 
875:                         .Column2.ControlSource   = "cursor_4c_Dados.Vends"
876:                         .Column2.Width           = 90
877:                         .Column2.Header1.Caption = "Vendedor"
878: 
879:                         .Column3.ControlSource   = "cursor_4c_Dados.Cods"
880:                         .Column3.Width           = 80
881:                         .Column3.Header1.Caption = "C" + CHR(243) + "digo"
882:                     ENDWITH
883: 
884:                     THIS.FormatarGridLista(loc_oGrid)
885:                     loc_lResultado = .T.
886:                 ENDIF
887:                 ENDIF
888:             ENDIF
889:         CATCH TO loException
890:             MostrarErro(loException, "Formcrf.CarregarLista")
891:         ENDTRY
892: 
893:         RETURN loc_lResultado
894:     ENDPROC

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

*-- Linhas 1297 a 1315:
1297:         ENDIF
1298: 
1299:         IF RECCOUNT("cursor_4c_Vendedores") = 1
1300:             SELECT cursor_4c_Vendedores
1301:             GO TOP
1302:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1303:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1304:             THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1305:             THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1306:             IF USED("cursor_4c_Vendedores")
1307:                 USE IN cursor_4c_Vendedores
1308:             ENDIF
1309:         ELSE
1310:             THIS.AbrirBuscaVendedor(loc_cCodigo)
1311:         ENDIF
1312:     ENDPROC
1313: 
1314:     *==========================================================================
1315:     * AbrirBuscaVendedor - Abre FormBuscaAuxiliar no cursor_4c_Vendedores

*-- Linhas 1331 a 1349:
1331:             loc_oBusca.Show()
1332: 
1333:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Vendedores")
1334:                 SELECT cursor_4c_Vendedores
1335:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(Iclis)
1336:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(Rclis)
1337:                 THIS.this_oBusinessObject.this_cVends    = ALLTRIM(Iclis)
1338:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(Rclis)
1339:             ELSE
1340:                 loc_oPagina.txt_4c_Conta.Value  = ""
1341:                 loc_oPagina.txt_4c_DConta.Value = ""
1342:             ENDIF
1343: 
1344:             loc_oBusca.Release()
1345:         ENDIF
1346: 
1347:         IF USED("cursor_4c_Vendedores")
1348:             USE IN cursor_4c_Vendedores
1349:         ENDIF

*-- Linhas 1487 a 1546:
1487:     *==========================================================================
1488:     * CarregarGridItens - Vincula grd_4c_Dados ao cursor csSigCdCri e formata
1489:     * RecordSource e ColumnCount fora do WITH (Problema 36)
1490:     * ControlSource e Headers redefinidos apos RecordSource (reset automatico)
1491:     *==========================================================================
1492:     PROTECTED PROCEDURE CarregarGridItens()
1493:         LOCAL loc_oPagina, loc_oGrid, loc_cCursor
1494:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1495: 
1496:         TRY
1497:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1498:                 loc_oGrid   = loc_oPagina.grd_4c_Dados
1499:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1500: 
1501:                 *-- RecordSource e ColumnCount FORA do WITH (evita "Unknown member COLUMN1")
1502:                 loc_oGrid.RecordSource = loc_cCursor
1503:                 loc_oGrid.ColumnCount  = 6
1504: 
1505:                 WITH loc_oGrid
1506:                     .Column1.ControlSource   = loc_cCursor + ".Emps"
1507:                     .Column1.Width           = 40
1508:                     .Column1.ReadOnly        = .T.
1509:                     .Column1.Header1.Caption = "Emp."
1510: 
1511:                     .Column2.ControlSource   = loc_cCursor + ".QtdCtg"
1512:                     .Column2.Width           = 60
1513:                     .Column2.ReadOnly        = .F.
1514:                     .Column2.Header1.Caption = "Qtde."
1515: 
1516:                     .Column3.ControlSource   = loc_cCursor + ".qtde"
1517:                     .Column3.Width           = 60
1518:                     .Column3.ReadOnly        = .T.
1519:                     .Column3.Header1.Caption = "Estoque"
1520: 
1521:                     .Column4.ControlSource   = loc_cCursor + ".Grupos"
1522:                     .Column4.Width           = 60
1523:                     .Column4.ReadOnly        = .T.
1524:                     .Column4.Header1.Caption = "Grupo"
1525: 
1526:                     .Column5.ControlSource   = loc_cCursor + ".Estos"
1527:                     .Column5.Width           = 80
1528:                     .Column5.ReadOnly        = .T.
1529:                     .Column5.Header1.Caption = "Conta"
1530: 
1531:                     .Column6.ControlSource   = loc_cCursor + ".Descr"
1532:                     .Column6.Width           = 177
1533:                     .Column6.ReadOnly        = .T.
1534:                     .Column6.Header1.Caption = "Produto"
1535:                 ENDWITH
1536: 
1537:                 THIS.FormatarGridLista(loc_oGrid)
1538:                 loc_oGrid.Refresh()
1539:             ENDIF
1540:         CATCH TO loException
1541:             MostrarErro(loException, "Formcrf.CarregarGridItens")
1542:         ENDTRY
1543:     ENDPROC
1544: 
1545:     *==========================================================================
1546:     * ValidarBusca - LostFocus de txt_4c_Busca

*-- Linhas 1561 a 1594:
1561: 
1562:         TRY
1563:             IF loc_nOpt = 1
1564:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1565:                     WHERE ALLTRIM(CBars) = m.loc_cBusca ;
1566:                     INTO CURSOR csProcuraBusca
1567:             ELSE
1568:                 SELECT RecNo() AS nRecNo FROM csSigCdCri ;
1569:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca ;
1570:                     INTO CURSOR csProcuraBusca
1571:             ENDIF
1572: 
1573:             IF USED("csProcuraBusca") AND !EOF("csProcuraBusca") AND RECCOUNT("csProcuraBusca") > 0
1574:                 SELECT csProcuraBusca
1575:                 GO TOP
1576:                 loc_nRecNo = nRecNo
1577:                 USE IN csProcuraBusca
1578: 
1579:                 SELECT csSigCdCri
1580:                 GO loc_nRecNo
1581:                 loc_oPagina.txt_4c_DContas.Value = ALLTRIM(TratarNulo(Descr, "C"))
1582:                 loc_oPagina.grd_4c_Dados.Refresh()
1583: 
1584:                 IF PEMSTATUS(loc_oPagina.txt_4c_TotQt, "SetFocus", 5)
1585:                     loc_oPagina.txt_4c_TotQt.SetFocus()
1586:                 ENDIF
1587:             ELSE
1588:                 IF USED("csProcuraBusca")
1589:                     USE IN csProcuraBusca
1590:                 ENDIF
1591:                 MsgAviso("Produto n" + CHR(227) + "o encontrado.")
1592:                 loc_oPagina.txt_4c_DContas.Value = ""
1593:                 loc_oPagina.txt_4c_Busca.Value   = ""
1594:                 IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)

*-- Linhas 1621 a 1642:
1621: 
1622:         TRY
1623:             IF loc_nOpt = 1
1624:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1625:                     WHERE ALLTRIM(CBars) = m.loc_cBusca
1626:             ELSE
1627:                 UPDATE csSigCdCri SET QtdCtg = m.loc_nQtds ;
1628:                     WHERE ALLTRIM(Cpros) = m.loc_cBusca
1629:             ENDIF
1630: 
1631:             loc_oPagina.txt_4c_Busca.Value    = ""
1632:             loc_oPagina.txt_4c_TotQt.Value    = 0
1633:             loc_oPagina.txt_4c_DContas.Value  = ""
1634:             loc_oPagina.img_4c_ImgJpg.Visible = .F.
1635:             loc_oPagina.img_4c_ImgJpg.Picture = ""
1636:             loc_oPagina.grd_4c_Dados.Refresh()
1637: 
1638:             IF PEMSTATUS(loc_oPagina.txt_4c_Busca, "SetFocus", 5)
1639:                 loc_oPagina.txt_4c_Busca.SetFocus()
1640:             ENDIF
1641:         CATCH TO loException
1642:             MostrarErro(loException, "Formcrf.ValidarQuantidade")

*-- Linhas 1656 a 1674:
1656:         ENDIF
1657: 
1658:         TRY
1659:             SELECT csSigCdCri
1660:             loc_cCpros = ALLTRIM(TratarNulo(Cpros, "C"))
1661:             loc_cDescr = ALLTRIM(TratarNulo(Descr, "C"))
1662: 
1663:             loc_oPagina.txt_4c_DContas.Value = loc_cDescr
1664: 
1665:             IF !EMPTY(loc_cCpros)
1666:                 THIS.CarregarImagemProduto(loc_cCpros)
1667:             ELSE
1668:                 loc_oPagina.img_4c_ImgJpg.Visible = .F.
1669:                 loc_oPagina.img_4c_ImgJpg.Picture = ""
1670:             ENDIF
1671:         CATCH TO loException
1672:             MostrarErro(loException, "Formcrf.GridDadosAfterRowColChange")
1673:         ENDTRY
1674:     ENDPROC

*-- Linhas 1682 a 1707:
1682:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1683: 
1684:         TRY
1685:             loc_cSQL    = "SELECT FigJpgs FROM SigCdPro" + ;
1686:                           " WHERE RTRIM(Cpros) = " + EscaparSQL(par_cCpros)
1687:             loc_nRetSQL = SQLEXEC(gnConnHandle, loc_cSQL, "csImgProduto")
1688: 
1689:             IF loc_nRetSQL > 0 AND USED("csImgProduto") AND ;
1690:                     !EOF("csImgProduto") AND !EMPTY(ALLTRIM(csImgProduto.FigJpgs))
1691: 
1692:                 SELECT csImgProduto
1693:                 GO TOP
1694:                 loc_cBase64 = ALLTRIM(FigJpgs)
1695: 
1696:                 IF "base64," $ loc_cBase64
1697:                     loc_cBase64 = SUBSTR(loc_cBase64, AT("base64,", loc_cBase64) + 7)
1698:                 ENDIF
1699: 
1700:                 IF !EMPTY(loc_cBase64)
1701:                     loc_cTmpFile = SYS(2023) + "\4c_img_tmp.jpg"
1702:                     STRTOFILE(STRCONV(loc_cBase64, 14), loc_cTmpFile)
1703: 
1704:                     IF FILE(loc_cTmpFile)
1705:                         loc_oPagina.img_4c_ImgJpg.Picture = loc_cTmpFile
1706:                         loc_oPagina.img_4c_ImgJpg.Visible = .T.
1707:                     ELSE


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
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cGrPadVens)
                THIS.CarregarParametros()
            ENDIF

            IF USED("cursor_4c_Vendedores")
                USE IN cursor_4c_Vendedores
            ENDIF

            loc_cSQL = "SELECT a.Iclis, a.Rclis, a.Grupos, a.Situas," + ;
                       " a.Cpfs, a.Inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE NOT b.Coletors = 10" + ;
                       " AND a.Grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
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

