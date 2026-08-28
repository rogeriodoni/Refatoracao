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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrgr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1831 linhas total):

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
361:             .Column1.Width     = 80
362:             .Column1.Alignment = 0
363:             .Column2.Width     = 380
364:             .Column2.Alignment = 0
365:             .Column3.Width     = 120
366:             .Column3.Alignment = 1

*-- Linhas 552 a 570:
552:         *-- Grid SigCdRga (grdRegra: Top=129+27=156, Left=11, Width=739, Height=371)
553:         *-- Cursor placeholder criado aqui; ZAP preserva estrutura em CarregarGradeRegra (Problem 34)
554:         IF !USED("csSigCdRga")
555:             CREATE CURSOR csSigCdRga ( ;
556:                 cIdChaves  C(20), ;
557:                 Codigo     C(10), ;
558:                 Empresa    C(3),  ;
559:                 Grupo      C(10), ;
560:                 Conta      C(10), ;
561:                 Colecao    C(20), ;
562:                 Quantidade N(3,0), ;
563:                 Prioridade N(3,0), ;
564:                 GrupoPr    C(3),  ;
565:                 Zerar      C(1),  ;
566:                 Ordem      C(1)   ;
567:             )
568:         ENDIF
569: 
570:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")

*-- Linhas 586 a 656:
586:             .HighlightBackColor = RGB(255, 255, 255)
587:             .HighlightForeColor = RGB(15, 41, 104)
588:             .HighlightStyle     = 2
589:             .DeleteMark         = .F.
590:             .RecordMark         = .F.
591:             .RowHeight          = 16
592:             .ScrollBars         = 2
593:             .GridLines          = 3
594:             .ReadOnly           = .F.
595:             .Visible            = .T.
596:         ENDWITH
597: 
598:         *-- ControlSource APOS RecordSource para sobrepor auto-bind (Problem 36/48)
599:         loc_oGrd = loc_oPagina.grd_4c_Dados
600:         WITH loc_oGrd
601:             .Column1.ControlSource   = "csSigCdRga.Empresa"
602:             .Column1.Width           = 60
603:             .Column1.Alignment       = 0
604:             .Column1.Header1.Caption = "Empresa"
605: 
606:             .Column2.ControlSource   = "csSigCdRga.Grupo"
607:             .Column2.Width           = 95
608:             .Column2.Alignment       = 0
609:             .Column2.Header1.Caption = "Grupo"
610: 
611:             .Column3.ControlSource   = "csSigCdRga.Conta"
612:             .Column3.Width           = 85
613:             .Column3.Alignment       = 0
614:             .Column3.Header1.Caption = "Conta"
615: 
616:             .Column4.ControlSource   = "csSigCdRga.Colecao"
617:             .Column4.Width           = 140
618:             .Column4.Alignment       = 0
619:             .Column4.Header1.Caption = "Grupo de Venda"
620: 
621:             .Column5.ControlSource   = "csSigCdRga.Quantidade"
622:             .Column5.Width           = 65
623:             .Column5.Alignment       = 2
624:             .Column5.Header1.Caption = "Qtde. Min."
625: 
626:             .Column6.ControlSource   = "csSigCdRga.Prioridade"
627:             .Column6.Width           = 70
628:             .Column6.Alignment       = 2
629:             .Column6.Header1.Caption = "Prior."
630: 
631:             .Column7.ControlSource   = "csSigCdRga.GrupoPr"
632:             .Column7.Width           = 105
633:             .Column7.Alignment       = 0
634:             .Column7.Header1.Caption = "Grupo de Produto"
635: 
636:             .Column8.ControlSource   = "csSigCdRga.Zerar"
637:             .Column8.Width           = 50
638:             .Column8.Alignment       = 1
639:             .Column8.Header1.Caption = "Zerar"
640: 
641:             .Column9.ControlSource   = "csSigCdRga.Ordem"
642:             .Column9.Width           = 50
643:             .Column9.Alignment       = 1
644:             .Column9.Header1.Caption = "Ordem"
645:         ENDWITH
646: 
647:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeRegraAfterRowColChange")
648: 
649:         *-- CommandGroup Mover linhas (Commandgroup1: Top=200+27=227, Left=748, W=50, H=90)
650:         loc_oPagina.AddObject("obj_4c_Commandgroup1", "CommandGroup")
651:         WITH loc_oPagina.obj_4c_Commandgroup1
652:             .Top         = 227
653:             .Left        = 748
654:             .Width       = 50
655:             .Height      = 90
656:             .BackStyle   = 0

*-- Linhas 920 a 943:
920:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
921:                 loc_oGrd.ColumnCount  = 4
922: 
923:                 *-- ControlSource APOS RecordSource; Headers OBRIGATORIOS (Problem 2/32)
924:                 WITH loc_oGrd
925:                     .Column1.ControlSource  = "cursor_4c_Dados.codigo"
926:                     .Column2.ControlSource  = "cursor_4c_Dados.descricao"
927:                     .Column3.ControlSource  = "cursor_4c_Dados.valor"
928:                     .Column4.ControlSource  = "cursor_4c_Dados.inativas"
929: 
930:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
931:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
932:                     .Column3.Header1.Caption = "Valor M" + CHR(237) + "n."
933:                     .Column4.Header1.Caption = "Inativa"
934: 
935:                     .Column1.Width     = 80
936:                     .Column2.Width     = 380
937:                     .Column3.Width     = 120
938:                     .Column4.Width     = 80
939:                     .Column1.Alignment = 0
940:                     .Column2.Alignment = 0
941:                     .Column3.Alignment = 1
942:                     .Column4.Alignment = 2
943:                 ENDWITH

*-- Linhas 1026 a 1044:
1026:         ENDIF
1027: 
1028:         TRY
1029:             SELECT cursor_4c_Dados
1030:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1031: 
1032:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1033:                 THIS.BOParaForm()
1034:                 THIS.CarregarGradeRegra(loc_cCodigo)
1035:                 THIS.this_cModoAtual = "VISUALIZAR"
1036:                 THIS.HabilitarCampos(.F.)
1037:                 THIS.AjustarBotoesPorModo()
1038:                 loc_lResultado = THIS.AlternarPagina(2)
1039:             ENDIF
1040:         CATCH TO loException
1041:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1042:                     loException.Message + CHR(13) + ;
1043:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")
1044:         ENDTRY

*-- Linhas 1060 a 1078:
1060:         ENDIF
1061: 
1062:         TRY
1063:             SELECT cursor_4c_Dados
1064:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigo)
1065: 
1066:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1067:                 THIS.this_oBusinessObject.EditarRegistro()
1068:                 THIS.BOParaForm()
1069:                 THIS.CarregarGradeRegra(loc_cCodigo)
1070:                 THIS.this_cModoAtual = "ALTERAR"
1071:                 THIS.HabilitarCampos(.T.)
1072:                 THIS.AjustarBotoesPorModo()
1073:                 loc_lResultado = THIS.AlternarPagina(2)
1074:             ENDIF
1075:         CATCH TO loException
1076:             MsgErro("Erro ao carregar registro:" + CHR(13) + ;
1077:                     loException.Message + CHR(13) + ;
1078:                     "Linha: " + TRANSFORM(loException.LineNo), "Erro")

*-- Linhas 1094 a 1112:
1094:             RETURN .F.
1095:         ENDIF
1096: 
1097:         SELECT cursor_4c_Dados
1098:         loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigo)
1099:         loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricao)
1100: 
1101:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da regra:" + CHR(13) + ;
1102:                         loc_cCodigo + " - " + loc_cDescricao + "?", ;
1103:                         "Confirmar Exclus" + CHR(227) + "o")
1104:             RETURN .F.
1105:         ENDIF
1106: 
1107:         TRY
1108:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1109:                 IF THIS.this_oBusinessObject.Excluir()
1110:                     MsgInfo("Regra exclu" + CHR(237) + "da com sucesso!")
1111:                     THIS.CarregarLista()
1112:                     loc_lResultado = .T.

*-- Linhas 1132 a 1150:
1132: 
1133:         IF THIS.CarregarLista()
1134:             IF !EMPTY(loc_cBuscar) AND USED("cursor_4c_Dados")
1135:                 SELECT cursor_4c_Dados
1136:                 LOCATE FOR UPPER(loc_cBuscar) $ UPPER(ALLTRIM(codigo)) OR ;
1137:                            UPPER(loc_cBuscar) $ UPPER(ALLTRIM(descricao))
1138:                 IF EOF("cursor_4c_Dados")
1139:                     GO TOP IN cursor_4c_Dados
1140:                     MsgAviso("Nenhum registro encontrado para: " + loc_cBuscar, "Buscar")
1141:                 ENDIF
1142:             ENDIF
1143:             loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1144:             IF VARTYPE(loc_oGrd) = "O"
1145:                 loc_oGrd.Refresh()
1146:             ENDIF
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *===========================================================================

*-- Linhas 1312 a 1373:
1312:     ENDPROC
1313: 
1314:     *===========================================================================
1315:     * CarregarGradeRegra - ZAP + SQLEXEC + APPEND para preservar colunas do grid
1316:     * NAO chama rgrBO.CarregarLinhasRegra() pois ela recriar o cursor (Problem 34)
1317:     *===========================================================================
1318:     PROTECTED PROCEDURE CarregarGradeRegra(par_cCodigo)
1319:         LOCAL loc_lResultado, loc_nSQL, loc_cSQL
1320:         loc_lResultado = .F.
1321: 
1322:         TRY
1323:             IF USED("csSigCdRga")
1324:                 ZAP IN csSigCdRga
1325:             ENDIF
1326: 
1327:             loc_cSQL = "SELECT cidchaves, codigo, empresa, grupo, conta, colecao, " + ;
1328:                        "       quantidade, prioridade, grupopr, zerar, ordem "       + ;
1329:                        "  FROM SigCdRga "                                             + ;
1330:                        " WHERE codigo = " + EscaparSQL(par_cCodigo)                  + ;
1331:                        " ORDER BY prioridade"
1332: 
1333:             loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RgaTmp")
1334: 
1335:             IF loc_nSQL > 0
1336:                 SELECT cursor_4c_RgaTmp
1337:                 SCAN
1338:                     SELECT csSigCdRga
1339:                     APPEND BLANK
1340:                     REPLACE cIdChaves  WITH cursor_4c_RgaTmp.cidchaves,  ;
1341:                             Codigo     WITH cursor_4c_RgaTmp.codigo,     ;
1342:                             Empresa    WITH cursor_4c_RgaTmp.empresa,    ;
1343:                             Grupo      WITH cursor_4c_RgaTmp.grupo,      ;
1344:                             Conta      WITH cursor_4c_RgaTmp.conta,      ;
1345:                             Colecao    WITH cursor_4c_RgaTmp.colecao,    ;
1346:                             Quantidade WITH cursor_4c_RgaTmp.quantidade, ;
1347:                             Prioridade WITH cursor_4c_RgaTmp.prioridade, ;
1348:                             GrupoPr    WITH cursor_4c_RgaTmp.grupopr,    ;
1349:                             Zerar      WITH cursor_4c_RgaTmp.zerar,      ;
1350:                             Ordem      WITH cursor_4c_RgaTmp.ordem
1351:                     SELECT cursor_4c_RgaTmp
1352:                 ENDSCAN
1353: 
1354:                 IF USED("cursor_4c_RgaTmp")
1355:                     USE IN cursor_4c_RgaTmp
1356:                 ENDIF
1357: 
1358:                 SELECT csSigCdRga
1359:                 IF RECCOUNT("csSigCdRga") > 0
1360:                     INDEX ON Prioridade TAG PriIdx
1361:                     SET ORDER TO TAG PriIdx
1362:                     GO TOP
1363:                 ENDIF
1364: 
1365:                 loc_lResultado = .T.
1366:             ELSE
1367:                 IF USED("cursor_4c_RgaTmp")
1368:                     USE IN cursor_4c_RgaTmp
1369:                 ENDIF
1370:                 MsgErro("Erro ao carregar regras do servidor.", "Erro")
1371:             ENDIF
1372:         CATCH TO loException
1373:             IF USED("cursor_4c_RgaTmp")

*-- Linhas 1386 a 1404:
1386:     * Deve ser PUBLIC - handler BINDEVENT (CLAUDE.md regra #3)
1387:     *===========================================================================
1388:     PROCEDURE GradeRegraAfterRowColChange(par_nColIndex)
1389:         IF !USED("csSigCdRga") OR EOF("csSigCdRga") OR DELETED("csSigCdRga")
1390:             RETURN
1391:         ENDIF
1392:         IF THIS.this_cModoAtual = "VISUALIZAR"
1393:             RETURN
1394:         ENDIF
1395: 
1396:         DO CASE
1397:         CASE par_nColIndex = 1
1398:             THIS.ValidarEmpresaGrid()
1399:         CASE par_nColIndex = 2
1400:             THIS.ValidarGrupoContabilGrid()
1401:         CASE par_nColIndex = 3
1402:             THIS.ValidarContaGrid()
1403:         CASE par_nColIndex = 4
1404:             THIS.ValidarColecaoGrid()

*-- Linhas 1420 a 1793:
1420:         ENDIF
1421: 
1422:         LOCAL loc_cEmp
1423:         SELECT csSigCdRga
1424:         loc_cEmp = ALLTRIM(csSigCdRga.Empresa)
1425: 
1426:         IF EMPTY(loc_cEmp)
1427:             RETURN
1428:         ENDIF
1429: 
1430:         TRY
1431:             *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
1432:             IF !fAcessoEmpresa(Usuar, 'C', loc_cEmp, .NULL., '')
1433:                 SELECT csSigCdRga
1434:                 REPLACE Empresa WITH ""
1435:             ENDIF
1436:         CATCH TO loException
1437:             MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
1438:         ENDTRY
1439:     ENDPROC
1440: 
1441:     *===========================================================================
1442:     * ValidarGrupoContabilGrid - Valida col Grupo via fAcessoContab (sigacess.PRG)
1443:     *===========================================================================
1444:     PROTECTED PROCEDURE ValidarGrupoContabilGrid()
1445:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1446:             RETURN
1447:         ENDIF
1448: 
1449:         LOCAL loc_cGrp
1450:         SELECT csSigCdRga
1451:         loc_cGrp = ALLTRIM(csSigCdRga.Grupo)
1452: 
1453:         IF EMPTY(loc_cGrp)
1454:             RETURN
1455:         ENDIF
1456: 
1457:         TRY
1458:             IF !fAcessoContab(Usuar, 'C', loc_cGrp, .NULL., '')
1459:                 MsgAviso("Acesso Negado !!!", "Grupo Cont" + CHR(225) + "bil")
1460:                 SELECT csSigCdRga
1461:                 REPLACE Grupo WITH ""
1462:             ENDIF
1463:         CATCH TO loException
1464:             MsgErro("Erro ao validar grupo contabil:" + CHR(13) + loException.Message, "Erro")
1465:         ENDTRY
1466:     ENDPROC
1467: 
1468:     *===========================================================================
1469:     * ValidarContaGrid - Valida col Conta via fAcessoContas (sigacess.PRG)
1470:     * Depende do Grupo da mesma linha para contexto de acesso
1471:     *===========================================================================
1472:     PROTECTED PROCEDURE ValidarContaGrid()
1473:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1474:             RETURN
1475:         ENDIF
1476: 
1477:         LOCAL loc_cConta, loc_cGrp, loc_lRet
1478:         SELECT csSigCdRga
1479:         loc_cConta = ALLTRIM(csSigCdRga.Conta)
1480:         loc_cGrp   = ALLTRIM(csSigCdRga.Grupo)
1481: 
1482:         IF EMPTY(loc_cConta)
1483:             RETURN
1484:         ENDIF
1485: 
1486:         TRY
1487:             loc_lRet = fAcessoContas(Usuar, loc_cGrp, 'C', loc_cConta, .NULL., '')
1488:             IF !loc_lRet
1489:                 MsgAviso("Acesso Negado !!!", "Conta")
1490:                 SELECT csSigCdRga
1491:                 REPLACE Conta WITH ""
1492:             ENDIF
1493:         CATCH TO loException
1494:             MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
1495:         ENDTRY
1496:     ENDPROC
1497: 
1498:     *===========================================================================
1499:     * ValidarColecaoGrid - Valida col Colecao; abre lookup se nao encontrado
1500:     *===========================================================================
1501:     PROTECTED PROCEDURE ValidarColecaoGrid()
1502:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1503:             RETURN
1504:         ENDIF
1505: 
1506:         LOCAL loc_cCol, loc_nSQL
1507:         SELECT csSigCdRga
1508:         loc_cCol = ALLTRIM(csSigCdRga.Colecao)
1509: 
1510:         IF EMPTY(loc_cCol)
1511:             RETURN
1512:         ENDIF
1513: 
1514:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1515:             "SELECT COUNT(*) AS qtd FROM SigCdCol WHERE Colecao = " + EscaparSQL(loc_cCol), ;
1516:             "cursor_4c_ValCol")
1517: 
1518:         IF loc_nSQL > 0 AND USED("cursor_4c_ValCol")
1519:             IF cursor_4c_ValCol.qtd = 0
1520:                 USE IN cursor_4c_ValCol
1521:                 THIS.AbrirLookupColecao()
1522:             ELSE
1523:                 USE IN cursor_4c_ValCol
1524:             ENDIF
1525:         ENDIF
1526:     ENDPROC
1527: 
1528:     *===========================================================================
1529:     * ValidarGrupoProdutoGrid - Valida col GrupoPr; abre lookup se nao encontrado
1530:     *===========================================================================
1531:     PROTECTED PROCEDURE ValidarGrupoProdutoGrid()
1532:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1533:             RETURN
1534:         ENDIF
1535: 
1536:         LOCAL loc_cGrp, loc_nSQL
1537:         SELECT csSigCdRga
1538:         loc_cGrp = ALLTRIM(csSigCdRga.GrupoPr)
1539: 
1540:         IF EMPTY(loc_cGrp)
1541:             RETURN
1542:         ENDIF
1543: 
1544:         loc_nSQL = SQLEXEC(gnConnHandle, ;
1545:             "SELECT COUNT(*) AS qtd FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrp), ;
1546:             "cursor_4c_ValGrp")
1547: 
1548:         IF loc_nSQL > 0 AND USED("cursor_4c_ValGrp")
1549:             IF cursor_4c_ValGrp.qtd = 0
1550:                 USE IN cursor_4c_ValGrp
1551:                 THIS.AbrirLookupGrupoProduto()
1552:             ELSE
1553:                 USE IN cursor_4c_ValGrp
1554:             ENDIF
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     *===========================================================================
1559:     * ValidarZerarGrid - Valida col Zerar: aceita somente S ou N
1560:     *===========================================================================
1561:     PROTECTED PROCEDURE ValidarZerarGrid()
1562:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1563:             RETURN
1564:         ENDIF
1565: 
1566:         LOCAL loc_cZerar
1567:         SELECT csSigCdRga
1568:         loc_cZerar = UPPER(ALLTRIM(csSigCdRga.Zerar))
1569: 
1570:         IF !EMPTY(loc_cZerar) AND loc_cZerar != "S" AND loc_cZerar != "N"
1571:             MsgAviso("Zerar deve ser S ou N.", "Zerar")
1572:             REPLACE Zerar WITH "S"
1573:         ENDIF
1574:     ENDPROC
1575: 
1576:     *===========================================================================
1577:     * ValidarOrdemGrid - Valida col Ordem: aceita somente P ou D
1578:     *===========================================================================
1579:     PROTECTED PROCEDURE ValidarOrdemGrid()
1580:         IF !USED("csSigCdRga") OR EOF("csSigCdRga")
1581:             RETURN
1582:         ENDIF
1583: 
1584:         LOCAL loc_cOrdem
1585:         SELECT csSigCdRga
1586:         loc_cOrdem = UPPER(ALLTRIM(csSigCdRga.Ordem))
1587: 
1588:         IF !EMPTY(loc_cOrdem) AND loc_cOrdem != "P" AND loc_cOrdem != "D"
1589:             MsgAviso("Ordem deve ser P ou D.", "Ordem")
1590:             REPLACE Ordem WITH "P"
1591:         ENDIF
1592:     ENDPROC
1593: 
1594:     *===========================================================================
1595:     * CmdInsRowClick - Insere nova linha em branco no grid de regras
1596:     *===========================================================================
1597:     PROCEDURE CmdInsRowClick()
1598:         IF !USED("csSigCdRga") OR THIS.this_cModoAtual = "VISUALIZAR"
1599:             RETURN
1600:         ENDIF
1601: 
1602:         LOCAL loc_nProx, loc_cIdChav, loc_cCodigo
1603:         SELECT csSigCdRga
1604:         CALCULATE MAX(Prioridade) TO loc_nProx
1605:         loc_nProx   = loc_nProx + 1
1606:         loc_cIdChav = ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
1607:         loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1608: 
1609:         APPEND BLANK IN csSigCdRga
1610:         SELECT csSigCdRga
1611:         GO BOTTOM
1612:         REPLACE cIdChaves  WITH loc_cIdChav, ;
1613:                 Codigo     WITH loc_cCodigo, ;
1614:                 Prioridade WITH loc_nProx
1615: 
1616:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1617:     ENDPROC
1618: 
1619:     *===========================================================================
1620:     * CmdDelRowClick - Marca linha atual do grid como excluida (DELETE)
1621:     *===========================================================================
1622:     PROCEDURE CmdDelRowClick()
1623:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1624:             RETURN
1625:         ENDIF
1626:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1627:             RETURN
1628:         ENDIF
1629: 
1630:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta linha?", ;
1631:                        "Excluir Linha")
1632:             SELECT csSigCdRga
1633:             DELETE
1634:             SET DELETED ON
1635:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1636:         ENDIF
1637:     ENDPROC
1638: 
1639:     *===========================================================================
1640:     * CmdMoveUpClick - Move a linha atual para cima (troca Prioridade com anterior)
1641:     *===========================================================================
1642:     PROCEDURE CmdMoveUpClick()
1643:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1644:             RETURN
1645:         ENDIF
1646:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1647:             RETURN
1648:         ENDIF
1649: 
1650:         LOCAL loc_nAtual, loc_nAnterior
1651:         SELECT csSigCdRga
1652:         loc_nAtual    = csSigCdRga.Prioridade
1653:         loc_nAnterior = loc_nAtual - 1
1654: 
1655:         IF loc_nAtual <= 1
1656:             RETURN
1657:         ENDIF
1658: 
1659:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1660:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nAnterior
1661:         UPDATE csSigCdRga SET Prioridade = loc_nAnterior WHERE Prioridade = 0
1662: 
1663:         SELECT csSigCdRga
1664:         INDEX ON Prioridade TAG PriIdx
1665:         SET ORDER TO TAG PriIdx
1666:         LOCATE FOR Prioridade = loc_nAnterior
1667: 
1668:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1669:     ENDPROC
1670: 
1671:     *===========================================================================
1672:     * CmdMoveDownClick - Move a linha atual para baixo (troca Prioridade com proxima)
1673:     *===========================================================================
1674:     PROCEDURE CmdMoveDownClick()
1675:         IF !USED("csSigCdRga") OR RECCOUNT("csSigCdRga") = 0 OR EOF("csSigCdRga")
1676:             RETURN
1677:         ENDIF
1678:         IF THIS.this_cModoAtual = "VISUALIZAR" OR DELETED("csSigCdRga")
1679:             RETURN
1680:         ENDIF
1681: 
1682:         LOCAL loc_nAtual, loc_nProximo, loc_nMax
1683:         SELECT csSigCdRga
1684:         loc_nAtual  = csSigCdRga.Prioridade
1685:         CALCULATE MAX(Prioridade) TO loc_nMax
1686:         loc_nProximo = loc_nAtual + 1
1687: 
1688:         IF loc_nAtual >= loc_nMax
1689:             RETURN
1690:         ENDIF
1691: 
1692:         UPDATE csSigCdRga SET Prioridade = 0           WHERE Prioridade = loc_nAtual
1693:         UPDATE csSigCdRga SET Prioridade = loc_nAtual  WHERE Prioridade = loc_nProximo
1694:         UPDATE csSigCdRga SET Prioridade = loc_nProximo WHERE Prioridade = 0
1695: 
1696:         SELECT csSigCdRga
1697:         INDEX ON Prioridade TAG PriIdx
1698:         SET ORDER TO TAG PriIdx
1699:         LOCATE FOR Prioridade = loc_nProximo
1700: 
1701:         THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1702:     ENDPROC
1703: 
1704:     *===========================================================================
1705:     * AbrirLookupColecao - FormBuscaAuxiliar para SigCdCol (Pattern A canonico)
1706:     *===========================================================================
1707:     PROCEDURE AbrirLookupColecao()
1708:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1709:         loc_cValAtual = ""
1710: 
1711:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1712:             SELECT csSigCdRga
1713:             loc_cValAtual = ALLTRIM(csSigCdRga.Colecao)
1714:         ENDIF
1715: 
1716:         IF EMPTY(loc_cValAtual)
1717:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol ORDER BY Colecao"
1718:         ELSE
1719:             loc_cSQL = "SELECT Colecao, Descs FROM SigCdCol " + ;
1720:                        " WHERE Colecao LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1721:                        " ORDER BY Colecao"
1722:         ENDIF
1723: 
1724:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
1725: 
1726:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaCol")
1727:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1728:             IF VARTYPE(loc_oBusca) = "O"
1729:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "Colecao", "Descs", ;
1730:                     "Cole" + CHR(231) + CHR(227) + "o")
1731:                 IF loc_oBusca.Mostrar()
1732:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1733:                         SELECT csSigCdRga
1734:                         REPLACE Colecao WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1735:                     ENDIF
1736:                 ENDIF
1737:                 loc_oBusca.Release()
1738:             ENDIF
1739:             IF USED("cursor_4c_BuscaCol")
1740:                 USE IN cursor_4c_BuscaCol
1741:             ENDIF
1742:         ENDIF
1743: 
1744:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1745:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1746:         ENDIF
1747:     ENDPROC
1748: 
1749:     *===========================================================================
1750:     * AbrirLookupGrupoProduto - FormBuscaAuxiliar para SigCdGrp (Pattern A canonico)
1751:     *===========================================================================
1752:     PROCEDURE AbrirLookupGrupoProduto()
1753:         LOCAL loc_oBusca, loc_nSQL, loc_cValAtual, loc_cSQL
1754:         loc_cValAtual = ""
1755: 
1756:         IF USED("csSigCdRga") AND !EOF("csSigCdRga") AND !DELETED("csSigCdRga")
1757:             SELECT csSigCdRga
1758:             loc_cValAtual = ALLTRIM(csSigCdRga.GrupoPr)
1759:         ENDIF
1760: 
1761:         IF EMPTY(loc_cValAtual)
1762:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp ORDER BY CGrus"
1763:         ELSE
1764:             loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp " + ;
1765:                        " WHERE CGrus LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
1766:                        " ORDER BY CGrus"
1767:         ENDIF
1768: 
1769:         loc_nSQL = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrp")
1770: 
1771:         IF loc_nSQL > 0 AND USED("cursor_4c_BuscaGrp")
1772:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1773:             IF VARTYPE(loc_oBusca) = "O"
1774:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaGrp", "CGrus", "DGrus", ;
1775:                     "Grupo de Produto")
1776:                 IF loc_oBusca.Mostrar()
1777:                     IF USED("csSigCdRga") AND !EOF("csSigCdRga")
1778:                         SELECT csSigCdRga
1779:                         REPLACE GrupoPr WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1780:                     ENDIF
1781:                 ENDIF
1782:                 loc_oBusca.Release()
1783:             ENDIF
1784:             IF USED("cursor_4c_BuscaGrp")
1785:                 USE IN cursor_4c_BuscaGrp
1786:             ENDIF
1787:         ENDIF
1788: 
1789:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.grd_4c_Dados) = "O"
1790:             THIS.pgf_4c_Paginas.Page2.grd_4c_Dados.Refresh()
1791:         ENDIF
1792:     ENDPROC
1793: 


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

