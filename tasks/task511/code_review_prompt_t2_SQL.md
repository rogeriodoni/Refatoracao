# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLECAO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGO, PRIORIDADE, QUANTIDADE, CODREGRA, INATIVAS, LNMAX, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGO, PRIORIDADE, QUANTIDADE, CODREGRA, INATIVAS, LNMAX, CIDCHAVES

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
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigCdRgr.Codigo"
  ControlSource = "crSigCdRgr.Descricao"
  ControlSource = "crSigCdRgr.Observacao"
  ControlSource = "crSigCdRgr.Datas"
  ControlSource = "crSigCdRgr.UsuIncs"
  ControlSource = "crSigCdRgr.DtaAlts"
  ControlSource = "crSigCdRgr.UsuAlts"
  ControlSource = "crSigCdRgr.Inativas"
  ControlSource = "crSigCdRgr.Valor"
	lcSqlCdCri = [Select * From SigCdRga Where Codigo = ?lcCodigo]
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRGR Where Codigo = ?lcCodigo], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRga Where Codigo = ?lcCodigo], '') < 1)
If llOk And Not Thisform.poDataMgr.Update('crSigCdRGR')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRGR )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdRga')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRga )')
If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRGR Where Codigo = ?lcCodigo], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdRga Where Codigo = ?lcCodigo], '') < 1)
If Not Thisform.poDataMgr.Update('crSigCdRGR')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRGR )')
If llOk And Not Thisform.poDataMgr.Update('crSigCdRga')
	=Messagebox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCdRga )')
Select crSigCdRga
lcQuery = [Select a.* ] + ;
	[from SigCdRga a ] + ;
	[join SigCdRGR b on a.codigo = b.codigo ] + ;
Thisform.podatamgr.SqlExecute(lcQuery,[csSigCdRga])
Select csSigCdRga
Thisform.pagina.dados.grdRegra.column1.ControlSource = [csSigCdRga.Empresa]
Thisform.pagina.dados.grdRegra.column2.ControlSource = [csSigCdRga.Grupo]
Thisform.pagina.dados.grdRegra.column3.ControlSource = [csSigCdRga.Conta]
Thisform.pagina.dados.grdRegra.column4.ControlSource = [csSigCdRga.colecao]
Thisform.pagina.dados.grdRegra.column5.ControlSource = [csSigCdRga.quantidade]
Thisform.pagina.dados.grdRegra.column6.ControlSource = [csSigCdRga.Prioridade]
Thisform.pagina.dados.grdRegra.column7.ControlSource = [csSigCdRga.GrupoPr]
Thisform.pagina.dados.grdRegra.column8.ControlSource = [csSigCdRga.Zerar]
Thisform.pagina.dados.grdRegra.column9.ControlSource = [csSigCdRga.Ordem]
Select crSigCdRga
	Select crSigCdRga
	Select csSigCdRga
		Select crSigCdRga
		Select csSigCdRga
	Select crSigCdRga
	Delete For (Empty(Empresa) And Empty(Grupo) And Empty(Conta) And Empty(Colecao) And Empty(GrupoPr)) And Quantidade = 0
	lcUpdate = [Update SigPrdWb set qtds = 0 where codregra = ']+lcCodigo+[' ]
	If Thisform.podatamgr.SqlExecute(lcUpdate) < 1
	Select csSigCdRga
	Select Nvl(Max(Prioridade),0) as UltPri From csSigCdRga Into Cursor csMaxPrior 
	Select csMaxPrior
	Select csSigCdRga
		Insert Into csSigCdRga (Prioridade, Codigo, cIdChaves, Zerar) Values (lnMax, lnCodigo, fUniqueIds(), 'N')
	Select csSigCdRga
		Delete
	Select csSigCdRga
	Update csSigCdRga Set Prioridade = Prioridade - 1 where Prioridade > lnPrior 
	Select csSigCdRga
	Select csSigCdRga
	Update csSigCdRga Set Prioridade = lnPriNw where cIdChaves = lcChave
	Select csSigCdRga
	Update csSigCdRga Set Prioridade = lnPrior where Prioridade = lnPriNw and cIdChaves <> lcChave
	Select csSigCdRga
	Select csSigCdRga
	Update csSigCdRga Set Prioridade = lnPriNw where cIdChaves = lcChave
	Select csSigCdRga
	Update csSigCdRga Set Prioridade = lnPrior where Prioridade = lnPriNw and cIdChaves <> lcChave

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formrgr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1822 linhas total):

*-- Linhas 47 a 65:
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "Formrgr.InicializarForm")
49:             ELSE
50:                 SET DELETED ON
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible  = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 

*-- Linhas 348 a 366:
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .ReadOnly           = .T.
357:             .Visible            = .T.
358:         ENDWITH
359: 
360:         WITH loc_oPagina.grd_4c_Lista
361:             .Column1.Width     = 100
362:             .Column1.Alignment = 0
363:             .Column2.Width     = 250
364:             .Column2.Alignment = 0
365:         ENDWITH
366: 

*-- Linhas 548 a 566:
548:         *-- Grid SigCdRga (grdRegra: Top=129+27=156, Left=11, Width=739, Height=371)
549:         *-- Cursor placeholder criado aqui; ZAP preserva estrutura em CarregarGradeRegra (Problem 34)
550:         IF !USED("csSigCdRga")
551:             CREATE CURSOR csSigCdRga ( ;
552:                 cIdChaves  C(20), ;
553:                 Codigo     C(10), ;
554:                 Empresa    C(3),  ;
555:                 Grupo      C(10), ;
556:                 Conta      C(10), ;
557:                 Colecao    C(20), ;
558:                 Quantidade N(3,0), ;
559:                 Prioridade N(3,0), ;
560:                 GrupoPr    C(3),  ;
561:                 Zerar      C(1),  ;
562:                 Ordem      C(1)   ;
563:             )
564:         ENDIF
565: 
566:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 582 a 652:
582:             .HighlightBackColor = RGB(255, 255, 255)
583:             .HighlightForeColor = RGB(15, 41, 104)
584:             .HighlightStyle     = 2
585:             .DeleteMark         = .F.
586:             .RecordMark         = .F.
587:             .RowHeight          = 16
588:             .ScrollBars         = 2
589:             .GridLines          = 3
590:             .ReadOnly           = .F.
591:             .Visible            = .T.
592:         ENDWITH
593: 
594:         *-- ControlSource APOS RecordSource para sobrepor auto-bind (Problem 36/48)
595:         loc_oGrd = loc_oPagina.grd_4c_Dados
596:         WITH loc_oGrd
597:             .Column1.ControlSource   = "csSigCdRga.Empresa"
598:             .Column1.Width           = 60
599:             .Column1.Alignment       = 0
600:             .Column1.Header1.Caption = "Empresa"
601: 
602:             .Column2.ControlSource   = "csSigCdRga.Grupo"
603:             .Column2.Width           = 95
604:             .Column2.Alignment       = 0
605:             .Column2.Header1.Caption = "Grupo"
606: 
607:             .Column3.ControlSource   = "csSigCdRga.Conta"
608:             .Column3.Width           = 85
609:             .Column3.Alignment       = 0
610:             .Column3.Header1.Caption = "Conta"
611: 
612:             .Column4.ControlSource   = "csSigCdRga.Colecao"
613:             .Column4.Width           = 140
614:             .Column4.Alignment       = 0
615:             .Column4.Header1.Caption = "Grupo de Venda"
616: 
617:             .Column5.ControlSource   = "csSigCdRga.Quantidade"
618:             .Column5.Width           = 65
619:             .Column5.Alignment       = 2
620:             .Column5.Header1.Caption = "Qtde. Min."
621: 
622:             .Column6.ControlSource   = "csSigCdRga.Prioridade"
623:             .Column6.Width           = 70
624:             .Column6.Alignment       = 2
625:             .Column6.Header1.Caption = "Prior."
626: 
627:             .Column7.ControlSource   = "csSigCdRga.GrupoPr"
628:             .Column7.Width           = 105
629:             .Column7.Alignment       = 0
630:             .Column7.Header1.Caption = "Grupo de Produto"
631: 
632:             .Column8.ControlSource   = "csSigCdRga.Zerar"
633:             .Column8.Width           = 50
634:             .Column8.Alignment       = 1
635:             .Column8.Header1.Caption = "Zerar"
636: 
637:             .Column9.ControlSource   = "csSigCdRga.Ordem"
638:             .Column9.Width           = 50
639:             .Column9.Alignment       = 1
640:             .Column9.Header1.Caption = "Ordem"
641:         ENDWITH
642: 
643:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeRegraAfterRowColChange")
644: 
645:         *-- CommandGroup Mover linhas (Commandgroup1: Top=200+27=227, Left=748, W=50, H=90)
646:         loc_oPagina.AddObject("obj_4c_Commandgroup1", "CommandGroup")
647:         WITH loc_oPagina.obj_4c_Commandgroup1
648:             .Top         = 227
649:             .Left        = 748
650:             .Width       = 50
651:             .Height      = 90
652:             .BackStyle   = 0

*-- Linhas 916 a 937:
916:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
917:                 loc_oGrd.ColumnCount  = 2
918: 
919:                 *-- ControlSource APOS RecordSource; Headers OBRIGATORIOS (Problem 2/32)
920:                 WITH loc_oGrd
921:                     .Column1.ControlSource  = "cursor_4c_Dados.codigo"
922:                     .Column2.ControlSource  = "cursor_4c_Dados.descricao"
923: 
924:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
925:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o."
926: 
927:                     .Column1.Width     = 100
928:                     .Column2.Width     = 250
929:                     .Column1.Alignment = 0
930:                     .Column2.Alignment = 0
931:                 ENDWITH
932: 
933:                 THIS.FormatarGridLista(loc_oGrd)
934:                 loc_lResultado = .T.
935:             ELSE
936:                 loc_lResultado = .F.
937:                 ENDIF

*-- Linhas 1014 a 1032:
1014:         ENDIF
1015: 
1016:         TRY
1017:             SELECT cursor_4c_Dados
1018:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1019: 
1020:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1021:                 THIS.BOParaForm()
1022:                 THIS.CarregarGradeRegra(loc_cCodigo)
1023:                 THIS.this_cModoAtual = "VISUALIZAR"
1024:                 THIS.HabilitarCampos(.F.)
1025:                 THIS.AjustarBotoesPorModo()
1026:                 loc_lResultado = THIS.AlternarPagina(2)
1027:             ENDIF
1028:         CATCH TO loException
1029:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1030:                     loException.Message + CHR(13) + ;
1031:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1032:         ENDTRY

*-- Linhas 1048 a 1066:
1048:         ENDIF
1049: 
1050:         TRY
1051:             SELECT cursor_4c_Dados
1052:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1053: 
1054:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1055:                 THIS.this_oBusinessObject.EditarRegistro()
1056:                 THIS.BOParaForm()
1057:                 THIS.CarregarGradeRegra(loc_cCodigo)
1058:                 THIS.this_cModoAtual = "ALTERAR"
1059:                 THIS.HabilitarCampos(.T.)
1060:                 THIS.AjustarBotoesPorModo()
1061:                 loc_lResultado = THIS.AlternarPagina(2)
1062:             ENDIF
1063:         CATCH TO loException
1064:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1065:                     loException.Message + CHR(13) + ;
1066:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")

*-- Linhas 1082 a 1100:
1082:             RETURN .F.
1083:         ENDIF
1084: 
1085:         SELECT cursor_4c_Dados
1086:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigo)
1087:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricao)
1088: 
1089:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da regra:" + CHR(13) + ;
1090:                         loc_cCodigo + " - " + loc_cDescricao + "?", ;
1091:                         "Confirmar Exclus" + CHR(227) + "o")
1092:             RETURN .F.
1093:         ENDIF
1094: 
1095:         TRY
1096:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1097:                 IF THIS.this_oBusinessObject.Excluir()
1098:                     MsgInfo("Regra exclu" + CHR(237) + "da com sucesso!")
1099:                     THIS.CarregarLista()
1100:                     loc_lResultado = .T.

*-- Linhas 1120 a 1138:
1120: 
1121:         IF THIS.CarregarLista()
1122:             IF !EMPTY(loc_cBuscar) AND USED("cursor_4c_Dados")
1123:                 SELECT cursor_4c_Dados
1124:                 LOCATE FOR UPPER(loc_cBuscar) $ UPPER(ALLTRIM(codigo)) OR ;
1125:                            UPPER(loc_cBuscar) $ UPPER(ALLTRIM(descricao))
1126:                 IF EOF("cursor_4c_Dados")
1127:                     GO TOP IN cursor_4c_Dados
1128:                     MsgAviso("Nenhum registro encontrado para: " + loc_cBuscar, "Buscar")
1129:                 ENDIF
1130:             ENDIF
1131:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1132:             IF VARTYPE(loc_oGrd) = "O"
1133:                 loc_oGrd.Refresh()
1134:             ENDIF
1135:         ENDIF
1136:     ENDPROC
1137: 
1138:     *===========================================================================

*-- Linhas 1300 a 1361:
1300:     ENDPROC
1301: 
1302:     *===========================================================================
1303:     * CarregarGradeRegra - ZAP + SQLEXEC + APPEND para preservar colunas do grid
1304:     * NAO chama rgrBO.CarregarLinhasRegra() pois ela recriar o cursor (Problem 34)
1305:     *===========================================================================
1306:     PROTECTED PROCEDURE CarregarGradeRegra(par_cCodigo)
1307:         LOCAL loc_lResultado, loc_nSQL, loc_cSQL
1308:         loc_lResultado = .F.
1309: 
1310:         TRY
1311:             IF USED("csSigCdRga")
1312:                 ZAP IN csSigCdRga
1313:             ENDIF
1314: 
1315:             loc_cSQL = "SELECT cidchaves, codigo, empresa, grupo, conta, colecao, " + ;
1316:                        "       quantidade, prioridade, grupopr, zerar, ordem "       + ;
1317:                        "  FROM SigCdRga "                                             + ;
1318:                        " WHERE codigo = " + EscaparSQL(par_cCodigo)                  + ;
1319:                        " ORDER BY prioridade"
1320: 
1321:             loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RgaTmp")
1322: 
1323:             IF loc_nSQL > 0
1324:                 SELECT cursor_4c_RgaTmp
1325:                 SCAN
1326:                     SELECT csSigCdRga
1327:                     APPEND BLANK
1328:                     REPLACE cIdChaves  WITH cursor_4c_RgaTmp.cidchaves,  ;
1329:                             Codigo     WITH cursor_4c_RgaTmp.codigo,     ;
1330:                             Empresa    WITH cursor_4c_RgaTmp.empresa,    ;
1331:                             Grupo      WITH cursor_4c_RgaTmp.grupo,      ;
1332:                             Conta      WITH cursor_4c_RgaTmp.conta,      ;
1333:                             Colecao    WITH cursor_4c_RgaTmp.colecao,    ;
1334:                             Quantidade WITH cursor_4c_RgaTmp.quantidade, ;
1335:                             Prioridade WITH cursor_4c_RgaTmp.prioridade, ;
1336:                             GrupoPr    WITH cursor_4c_RgaTmp.grupopr,    ;
1337:                             Zerar      WITH cursor_4c_RgaTmp.zerar,      ;
1338:                             Ordem      WITH cursor_4c_RgaTmp.ordem
1339:                     SELECT cursor_4c_RgaTmp
1340:                 ENDSCAN
1341: 
1342:                 IF USED("cursor_4c_RgaTmp")
1343:                     USE IN cursor_4c_RgaTmp
1344:                 ENDIF
1345: 
1346:                 SELECT csSigCdRga
1347:                 IF RECCOUNT("csSigCdRga") > 0
1348:                     INDEX ON Prioridade TAG PriIdx
1349:                     SET ORDER TO TAG PriIdx
1350:                     GO TOP
1351:                 ENDIF
1352: 
1353:                 loc_lResultado = .T.
1354:             ELSE
1355:                 IF USED("cursor_4c_RgaTmp")
1356:                     USE IN cursor_4c_RgaTmp
1357:                 ENDIF
1358:                 MsgErro("Erro ao carregar regras do servidor.", "Erro")
1359:             ENDIF
1360:         CATCH TO loException
1361:             IF USED("cursor_4c_RgaTmp")

*-- Linhas 1374 a 1392:
1374:     * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
1375:     *===========================================================================
1376:     PROCEDURE GradeRegraAfterRowColChange(par_nColIndex)
1377:         IF !USED("csSigCdRga") OR EOF("csSigCdRga") OR DELETED("csSigCdRga")
1378:             RETURN
1379:         ENDIF
1380:         IF THIS.this_cModoAtual = "VISUALIZAR"
1381:             RETURN
1382:         ENDIF
1383: 
1384:         DO CASE
1385:         CASE par_nColIndex = 1
1386:             THIS.ValidarEmpresaGrid()
1387:         CASE par_nColIndex = 2
1388:             THIS.ValidarGrupoContabilGrid()
1389:         CASE par_nColIndex = 3
1390:             THIS.ValidarContaGrid()
1391:         CASE par_nColIndex = 4
1392:             THIS.ValidarColecaoGrid()

*-- Linhas 1408 a 1783:
1408:         ENDIF
1409: 
1410:         LOCAL loc_cEmp
1411:         SELECT csSigCdRga
1412:         loc_cEmp = ALLTRIM(csSigCdRga.Empresa)
1413: 
1414:         IF EMPTY(loc_cEmp)
1415:             RETURN
1416:         ENDIF
1417: 
1418:         TRY
1419:             *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
1420:             IF !fAcessoEmpresa(Usuar, 'C', loc_cEmp, .NULL., '')
1421:                 SELECT csSigCdRga
1422:                 REPLACE Empresa WITH ""
1423:             ENDIF
1424:         CATCH TO loException
1425:             MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
1426:         ENDTRY
1427:     ENDPROC
1428: 
1429:     *===========================================================================
1430:     * ValidarGrupoContabilGrid - Valida col Grupo via fAcessoContab (sigacess.PRG)
1431:     *===========================================================================
1432:     PROTECTED PROCEDURE ValidarGrupoContabilGrid()
1433:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1434:             RETURN
1435:         ENDIF
1436: 
1437:         LOCAL loc_cGrp
1438:         SELECT csSigCdRga
1439:         loc_cGrp = ALLTRIM(csSigCdRga.Grupo)
1440: 
1441:         IF EMPTY(loc_cGrp)
1442:             RETURN
1443:         ENDIF
1444: 
1445:         TRY
1446:             IF !fAcessoContab(Usuar, 'C', loc_cGrp, .NULL., '')
1447:                 MsgAviso("Acesso Negado !!!", "Grupo Cont" + CHR(225) + "bil")
1448:                 SELECT csSigCdRga
1449:                 REPLACE Grupo WITH ""
1450:             ENDIF
1451:         CATCH TO loException
1452:             MsgErro("Erro ao validar grupo contabil:" + CHR(13) + loException.Message, "Erro")
1453:         ENDTRY
1454:     ENDPROC
1455: 
1456:     *===========================================================================
1457:     * ValidarContaGrid - Valida col Conta via fAcessoContas (sigacess.PRG)
1458:     * Depende do Grupo da mesma linha para contexto de acesso
1459:     *===========================================================================
1460:     PROTECTED PROCEDURE ValidarContaGrid()
1461:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1462:             RETURN
1463:         ENDIF
1464: 
1465:         LOCAL loc_cConta, loc_cGrp, loc_lRet
1466:         SELECT csSigCdRga
1467:         loc_cConta = ALLTRIM(csSigCdRga.Conta)
1468:         loc_cGrp   = ALLTRIM(csSigCdRga.Grupo)
1469: 
1470:         IF EMPTY(loc_cConta)
1471:             RETURN
1472:         ENDIF
1473: 
1474:         TRY
1475:             loc_lRet = fAcessoContas(Usuar, loc_cGrp, 'C', loc_cConta, .NULL., '')
1476:             IF !loc_lRet
1477:                 MsgAviso("Acesso Negado !!!", "Conta")
1478:                 SELECT csSigCdRga
1479:                 REPLACE Conta WITH ""
1480:             ENDIF
1481:         CATCH TO loException
1482:             MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
1483:         ENDTRY
1484:     ENDPROC
1485: 
1486:     *===========================================================================
1487:     * ValidarColecaoGrid - Valida col Colecao; abre lookup se nao encontrado
1488:     *===========================================================================
1489:     PROTECTED PROCEDURE ValidarColecaoGrid()
1490:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1491:             RETURN
1492:         ENDIF
1493: 
1494:         LOCAL loc_cCol, loc_nSQL
1495:         SELECT csSigCdRga
1496:         loc_cCol = ALLTRIM(csSigCdRga.Colecao)
1497: 
1498:         IF EMPTY(loc_cCol)
1499:             RETURN
1500:         ENDIF
1501: 
1502:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1503:             "SELECT COUNT(*) AS qtd FROM SigCdCol WHERE Colecao = " + EscaparSQL(loc_cCol), ;
1504:             "cursor_4c_ValCol")
1505: 
1506:         IF loc_nSQL > 0 AND USED("cursor_4c_ValCol")
1507:             IF cursor_4c_ValCol.qtd = 0
1508:                 USE IN cursor_4c_ValCol
1509:                 THIS.AbrirLookupColecao()
1510:             ELSE
1511:                 USE IN cursor_4c_ValCol
1512:             ENDIF
1513:         ENDIF
1514:     ENDPROC
1515: 
1516:     *===========================================================================
1517:     * ValidarGrupoProdutoGrid - Valida col GrupoPr; abre lookup se nao encontrado
1518:     *===========================================================================
1519:     PROTECTED PROCEDURE ValidarGrupoProdutoGrid()
1520:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1521:             RETURN
1522:         ENDIF
1523: 
1524:         LOCAL loc_cGrp, loc_nSQL
1525:         SELECT csSigCdRga
1526:         loc_cGrp = ALLTRIM(csSigCdRga.GrupoPr)
1527: 
1528:         IF EMPTY(loc_cGrp)
1529:             RETURN
1530:         ENDIF
1531: 
1532:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1533:             "SELECT COUNT(*) AS qtd FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrp), ;
1534:             "cursor_4c_ValGrp")
1535: 
1536:         IF loc_nSQL > 0 AND USED("cursor_4c_ValGrp")
1537:             IF cursor_4c_ValGrp.qtd = 0
1538:                 USE IN cursor_4c_ValGrp
1539:                 THIS.AbrirLookupGrupoProduto()
1540:             ELSE
1541:                 USE IN cursor_4c_ValGrp
1542:             ENDIF
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     *===========================================================================
1547:     * ValidarZerarGrid - Valida col Zerar: aceita somente S ou N
1548:     *===========================================================================
1549:     PROTECTED PROCEDURE ValidarZerarGrid()
1550:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1551:             RETURN
1552:         ENDIF
1553: 
1554:         LOCAL loc_cZerar
1555:         SELECT csSigCdRga
1556:         loc_cZerar = UPPER(ALLTRIM(csSigCdRga.Zerar))
1557: 
1558:         IF !EMPTY(loc_cZerar) AND loc_cZerar != "S" AND loc_cZerar != "N"
1559:             MsgAviso("Zerar deve ser S ou N.", "Zerar")
1560:             REPLACE Zerar WITH "S"
1561:         ENDIF
1562:     ENDPROC
1563: 
1564:     *===========================================================================
1565:     * ValidarOrdemGrid - Valida col Ordem: aceita somente P ou D
1566:     *===========================================================================
1567:     PROTECTED PROCEDURE ValidarOrdemGrid()
1568:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1569:             RETURN
1570:         ENDIF
1571: 
1572:         LOCAL loc_cOrdem
1573:         SELECT csSigCdRga
1574:         loc_cOrdem = UPPER(ALLTRIM(csSigCdRga.Ordem))
1575: 
1576:         IF !EMPTY(loc_cOrdem) AND loc_cOrdem != "P" AND loc_cOrdem != "D"
1577:             MsgAviso("Ordem deve ser P ou D.", "Ordem")
1578:             REPLACE Ordem WITH "P"
1579:         ENDIF
1580:     ENDPROC
1581: 
1582:     *===========================================================================
1583:     * CmdInsRowClick - Insere nova linha em branco no grid de regras
1584:     *===========================================================================
1585:     PROCEDURE CmdInsRowClick()
1586:         IF !USED("csSigCdRga") OR THIS.this_cModoAtual = "VISUALIZAR"
1587:             RETURN
1588:         ENDIF
1589: 
1590:         LOCAL loc_nProx, loc_cIdChav, loc_cCodigo
1591:         SELECT csSigCdRga
1592:         CALCULATE MAX(Prioridade) TO loc_nProx
1593:         loc_nProx   = loc_nProx + 1
1594:         loc_cIdChav = ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1595:         loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1596: 
1597:         APPEND BLANK IN csSigCdRga
1598:         SELECT csSigCdRga
1599:         GO BOTTOM
1600:         REPLACE cIdChaves  WITH loc_cIdChav, ;
1601:                 Codigo     WITH loc_cCodigo, ;
1602:                 Prioridade WITH loc_nProx
1603: 
1604:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1605:     ENDPROC
1606: 
1607:     *===========================================================================
1608:     * CmdDelRowClick - Marca linha atual do grid como excluida (DELETE)
1609:     *===========================================================================
1610:     PROCEDURE CmdDelRowClick()
1611:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1612:             RETURN
1613:         ENDIF
1614:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1615:             RETURN
1616:         ENDIF
1617: 
1618:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta linha?", ;
1619:                        "Excluir Linha")
1620:             SELECT csSigCdRga
1621:             DELETE
1622:             SET DELETED ON
1623:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1624:         ENDIF
1625:     ENDPROC
1626: 
1627:     *===========================================================================
1628:     * CmdMoveUpClick - Move a linha atual para cima (troca Prioridade com anterior)
1629:     *===========================================================================
1630:     PROCEDURE CmdMoveUpClick()
1631:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1632:             RETURN
1633:         ENDIF
1634:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1635:             RETURN
1636:         ENDIF
1637: 
1638:         LOCAL loc_nAtual, loc_nAnterior
1639:         SELECT csSigCdRga
1640:         loc_nAtual    = csSigCdRga.Prioridade
1641:         loc_nAnterior = loc_nAtual - 1
1642: 
1643:         IF loc_nAtual <= 1
1644:             RETURN
1645:         ENDIF
1646: 
1647:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1648:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nAnterior
1649:         UPDATE csSigCdRga SET Prioridade = loc_nAnterior WHERE Prioridade = 0
1650: 
1651:         SELECT csSigCdRga
1652:         INDEX ON Prioridade TAG PriIdx
1653:         SET ORDER TO TAG PriIdx
1654:         LOCATE FOR Prioridade = loc_nAnterior
1655: 
1656:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1657:     ENDPROC
1658: 
1659:     *===========================================================================
1660:     * CmdMoveDownClick - Move a linha atual para baixo (troca Prioridade com proxima)
1661:     *===========================================================================
1662:     PROCEDURE CmdMoveDownClick()
1663:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1664:             RETURN
1665:         ENDIF
1666:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1667:             RETURN
1668:         ENDIF
1669: 
1670:         LOCAL loc_nAtual, loc_nProximo, loc_nMax
1671:         SELECT csSigCdRga
1672:         loc_nAtual  = csSigCdRga.Prioridade
1673:         CALCULATE MAX(Prioridade) TO loc_nMax
1674:         loc_nProximo = loc_nAtual + 1
1675: 
1676:         IF loc_nAtual >= loc_nMax
1677:             RETURN
1678:         ENDIF
1679: 
1680:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1681:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nProximo
1682:         UPDATE csSigCdRga SET Prioridade = loc_nProximo WHERE Prioridade = 0
1683: 
1684:         SELECT csSigCdRga
1685:         INDEX ON Prioridade TAG PriIdx
1686:         SET ORDER TO TAG PriIdx
1687:         LOCATE FOR Prioridade = loc_nProximo
1688: 
1689:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1690:     ENDPROC
1691: 
1692:     *===========================================================================
1693:     * AbrirLookupColecao - FormBuscaAuxiliar para SigCdCol (Pattern A canonico)
1694:     *===========================================================================
1695:     PROCEDURE AbrirLookupColecao()
1696:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1697:         loc_cValAtual = ""
1698: 
1699:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1700:             SELECT csSigCdRga
1701:             loc_cValAtual = ALLTRIM(csSigCdRga.Colecao)
1702:         ENDIF
1703: 
1704:         IF EMPTY(loc_cValAtual)
1705:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol ORDER BY Colecao"
1706:         ELSE
1707:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol " + ;
1708:                        " WHERE Colecao LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1709:                        " ORDER BY Colecao"
1710:         ENDIF
1711: 
1712:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
1713: 
1714:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaCol")
1715:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1716:             IF VARTYPE(loc_oBusca) = "O"
1717:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
1718:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "Colecao", "Descs", ;
1719:                     "Cole" + CHR(231) + CHR(227) + "o")
1720:                 IF loc_oBusca.Mostrar()
1721:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1722:                         SELECT csSigCdRga
1723:                         REPLACE Colecao WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1724:                     ENDIF
1725:                 ENDIF
1726:                 loc_oBusca.Release()
1727:             ENDIF
1728:             IF USED("cursor_4c_BuscaCol")
1729:                 USE IN cursor_4c_BuscaCol
1730:             ENDIF
1731:         ENDIF
1732: 
1733:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1734:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1735:         ENDIF
1736:     ENDPROC
1737: 
1738:     *===========================================================================
1739:     * AbrirLookupGrupoProduto - FormBuscaAuxiliar para SigCdGrp (Pattern A canonico)
1740:     *===========================================================================
1741:     PROCEDURE AbrirLookupGrupoProduto()
1742:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1743:         loc_cValAtual = ""
1744: 
1745:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1746:             SELECT csSigCdRga
1747:             loc_cValAtual = ALLTRIM(csSigCdRga.GrupoPr)
1748:         ENDIF
1749: 
1750:         IF EMPTY(loc_cValAtual)
1751:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp ORDER BY CGrus"
1752:         ELSE
1753:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp " + ;
1754:                        " WHERE CGrus LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1755:                        " ORDER BY CGrus"
1756:         ENDIF
1757: 
1758:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
1759: 
1760:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaGrp")
1761:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1762:             IF VARTYPE(loc_oBusca) = "O"
1763:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrp"
1764:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaGrp", "CGrus", "DGrus", ;
1765:                     "Grupo de Produto")
1766:                 IF loc_oBusca.Mostrar()
1767:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1768:                         SELECT csSigCdRga
1769:                         REPLACE GrupoPr WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1770:                     ENDIF
1771:                 ENDIF
1772:                 loc_oBusca.Release()
1773:             ENDIF
1774:             IF USED("cursor_4c_BuscaGrp")
1775:                 USE IN cursor_4c_BuscaGrp
1776:             ENDIF
1777:         ENDIF
1778: 
1779:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1780:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1781:         ENDIF
1782:     ENDPROC
1783: 


### BO (C:\4c\projeto\app\classes\rgrBO.prg):
*==============================================================================
* rgrBO.prg - Business Object para Regras de E-Commerce
* Tabela principal : SigCdRGR
* Tabela detalhe   : SigCdRga (gerenciada via cursor csSigCdRga)
* Form relacionado : Formrgr.prg
*==============================================================================

DEFINE CLASS rgrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - SigCdRGR (cabecalho da regra)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && cidchaves  char(20) - chave interna (fUniqueIds)
    this_cCodigo     = ""   && codigo     char(10) - codigo da regra (chave visivel)
    this_cDescricao  = ""   && descricao  char(40) - descricao
    this_dDatas      = {}   && datas      datetime - data de inclusao
    this_dDtaAlts    = {}   && dtaalts    datetime - data de alteracao
    this_cObservacao = ""   && observacao text     - observacao
    this_cUsaAlts    = ""   && usualts    char(10) - usuario que alterou
    this_cUsuIncs    = ""   && usuincs    char(10) - usuario que incluiu
    this_nInativas   = 0    && inativas   numeric(1,0) - 0=ativo / 1=inativo
    this_nValor      = 0    && valor      numeric(12,2)- valor minimo do pedido

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdRGR"
        THIS.this_cCampoChave = "Codigo"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave interna para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de regras para o Grid da Page1
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " ORDER BY a.codigo"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar regras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar regras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro RGR pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.codigo, a.descricao, a.datas," + ;
                       " a.dtaalts, a.observacao, a.usualts, a.usuincs," + ;
                       " a.inativas, a.valor" + ;
                       " FROM SigCdRGR a" + ;
                       " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(codigo,     "C")
            THIS.this_cDescricao  = TratarNulo(descricao,  "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_dDtaAlts    = TratarNulo(dtaalts,    "D")
            THIS.this_cObservacao = TratarNulo(observacao,  "")
            THIS.this_cUsaAlts    = TratarNulo(usualts,    "C")
            THIS.this_cUsuIncs    = TratarNulo(usuincs,    "C")
            THIS.this_nInativas   = TratarNulo(inativas,   "N")
            THIS.this_nValor      = TratarNulo(valor,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhasRegra - Popula cursor csSigCdRga com linhas do servidor
    *--------------------------------------------------------------------------
    FUNCTION CarregarLinhasRegra(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("csSigCdRga")
                USE IN csSigCdRga
            ENDIF

            SET NULL ON
            CREATE CURSOR csSigCdRga ( ;
                cIdChaves  C(20), ;
                Codigo     C(10), ;
                Empresa    C(3),  ;
                Grupo      C(10), ;
                Conta      C(10), ;
                Colecao    C(20), ;
                Quantidade N(3,0),;
                Prioridade N(3,0),;
                GrupoPr    C(3),  ;
                Zerar      C(1),  ;
                Ordem      C(1)   ;
            )
            SET NULL OFF

            IF NOT EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.cidchaves, a.codigo, a.empresa, a.grupo," + ;
                           " a.conta, a.colecao, a.quantidade, a.prioridade," + ;
                           " a.grupopr, a.zerar, a.ordem" + ;
                           " FROM SigCdRga a" + ;
                           " WHERE a.codigo = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.prioridade"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_LinhasRgr")
                    TABLEREVERT(.T., "cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasRgr")
                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_LinhasRgr") > 0
                        SELECT cursor_4c_LinhasRgr
                        GO TOP
                        SCAN
                            SELECT csSigCdRga
                            APPEND BLANK
                            REPLACE cIdChaves  WITH ALLTRIM(cursor_4c_LinhasRgr.cidchaves)
                            REPLACE Codigo     WITH ALLTRIM(cursor_4c_LinhasRgr.codigo)
                            REPLACE Empresa    WITH ALLTRIM(cursor_4c_LinhasRgr.empresa)
                            REPLACE Grupo      WITH ALLTRIM(cursor_4c_LinhasRgr.grupo)
                            REPLACE Conta      WITH ALLTRIM(cursor_4c_LinhasRgr.conta)
                            REPLACE Colecao    WITH ALLTRIM(cursor_4c_LinhasRgr.colecao)
                            REPLACE Quantidade WITH cursor_4c_LinhasRgr.quantidade
                            REPLACE Prioridade WITH cursor_4c_LinhasRgr.prioridade
                            REPLACE GrupoPr    WITH ALLTRIM(cursor_4c_LinhasRgr.grupopr)
                            REPLACE Zerar      WITH ALLTRIM(cursor_4c_LinhasRgr.zerar)
                            REPLACE Ordem      WITH ALLTRIM(cursor_4c_LinhasRgr.ordem)
                            SELECT cursor_4c_LinhasRgr
                        ENDSCAN
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_LinhasRgr")
                    USE IN cursor_4c_LinhasRgr
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF

            SELECT csSigCdRga
            GO TOP
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linhas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhasRegra - Insere linhas validas do csSigCdRga no SigCdRga
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION InserirLinhasRegra()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChaveRga
        loc_lSucesso = .T.

        IF NOT USED("csSigCdRga")
            RETURN .T.
        ENDIF

        TRY
            SELECT csSigCdRga
            GO TOP
            SCAN
                IF EMPTY(ALLTRIM(csSigCdRga.Empresa))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Grupo))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Conta))      AND ;
                   EMPTY(ALLTRIM(csSigCdRga.Colecao))    AND ;
                   EMPTY(ALLTRIM(csSigCdRga.GrupoPr))    AND ;
                   csSigCdRga.Quantidade = 0
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(csSigCdRga.cIdChaves))
                    loc_cChaveRga = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
                ELSE
                    loc_cChaveRga = ALLTRIM(csSigCdRga.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdRga" + ;
                           " (cidchaves, codigo, empresa, grupo, conta, colecao," + ;
                           "  quantidade, prioridade, grupopr, zerar, ordem)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cChaveRga) + "," + ;
                           EscaparSQL(THIS.this_cCodigo) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Empresa)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Grupo)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Conta)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Colecao)) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Quantidade) + "," + ;
                           FormatarNumeroSQL(csSigCdRga.Prioridade) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.GrupoPr)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Zerar)) + "," + ;
                           EscaparSQL(ALLTRIM(csSigCdRga.Ordem)) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRga")
                    TABLEREVERT(.T., "cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRga")
                IF USED("cursor_4c_InsRga")
                    USE IN cursor_4c_InsRga
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir linhas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRGR + SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            loc_cSQL = "INSERT INTO SigCdRGR" + ;
                       " (cidchaves, codigo, descricao, datas," + ;
                       "  observacao, usuincs, usualts, inativas, valor, dtaalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "GETDATE()," + ;
                       EscaparSQL(THIS.this_cObservacao) + "," + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       EscaparSQL("") + "," + ;
                       FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       "NULL)"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_InsRgr")
                TABLEREVERT(.T., "cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRgr")
            IF USED("cursor_4c_InsRgr")
                USE IN cursor_4c_InsRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_lSucesso = THIS.InserirLinhasRegra()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRGR + DELETE/INSERT SigCdRga (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRGR SET" + ;
                       " descricao = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " observacao = " + EscaparSQL(THIS.this_cObservacao) + "," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " inativas = " + FormatarNumeroSQL(THIS.this_nInativas) + "," + ;
                       " valor = " + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                       " dtaalts = GETDATE()" + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UpdRgr")
                TABLEREVERT(.T., "cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRgr")
            IF USED("cursor_4c_UpdRgr")
                USE IN cursor_4c_UpdRgr
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRga")
                    TABLEREVERT(.T., "cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
                IF USED("cursor_4c_DelRga")
                    USE IN cursor_4c_DelRga
                ENDIF

                IF loc_nResultado >= 0
                    loc_lSucesso = THIS.InserirLinhasRegra()
                    IF loc_lSucesso
                        loc_cSQL = "UPDATE SigPrdWb SET qtds = 0 WHERE codregra = " + ;
                                   EscaparSQL(THIS.this_cCodigo)
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_UpdWb")
                            TABLEREVERT(.T., "cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF

                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdWb")
                        IF USED("cursor_4c_UpdWb")
                            USE IN cursor_4c_UpdWb
                        ENDIF
                        THIS.RegistrarAuditoria("UPDATE")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir linhas antigas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRga + SigCdRGR (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRga WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelRga")
                TABLEREVERT(.T., "cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRga")
            IF USED("cursor_4c_DelRga")
                USE IN cursor_4c_DelRga
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdRGR WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DelRgr")
                    TABLEREVERT(.T., "cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelRgr")
                IF USED("cursor_4c_DelRgr")
                    USE IN cursor_4c_DelRgr
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir linhas de regra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir regra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("csSigCdRga")
            USE IN csSigCdRga
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

