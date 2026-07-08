# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-ASPAS] Linha 289: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE CPros = '" + loc_cPro + "'"
- [SQL-ASPAS] Linha 298: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = '" + loc_cPro + "'"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, IDIOMA, OBSCOMPRAS, DPROS
- [TRANSACAO-AVULSA] Linha 306: SQLEXEC com 'COMMIT' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 312: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).
- [TRANSACAO-AVULSA] Linha 325: SQLEXEC com 'ROLLBACK' mas NAO existe BEGIN TRANSACTION no codigo. A conexao ODBC usa AUTOCOMMIT - cada SQLEXEC ja eh transacao implicita. CORRIGIR: Remover SQLEXEC com COMMIT e ROLLBACK. Para operacoes simples (1 UPDATE), nao precisa de transacao explicita. Usar transacoes SOMENTE para operacoes multi-statement (2+ UPDATE/INSERT atomicos).

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
  Column1.ControlSource = "crProdutos.CPros"
  Column2.ControlSource = "crProdutos.Portugues"
  Column3.ControlSource = "crProdutos.Traduzido"
  ControlSource = "csContas.CprosAnt"
  ControlSource = "csContas.CprosNov"
Select crProdutos
	oProg.Update(.t.)
	lcQuery = [Update SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Update SigCdPro)])
	lcQuery = [Delete From SigPrPrt Where CPros = '] + lcPro + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		=MessageBox([Favor Reinicializar o Processo!!!], 16, [Falha na Conexão (Traducao - Delete SigPrPrt)], 10000)
lcQuery = [Select CPros ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crPrdTraduz]) < 1)
Select crPrdTraduz
	oProg.Update(.t.)
		lcQuery = [Select a.CPros, a.CGrus, a.CodCors, b.DGrus, b.Mercs, b.MontaGrDs, c.Descs ] + ;
				    [From SigCdPro a ] + ;
				    [Left Join SigCdGrp b On b.CGrus = a.CGrus ] + ;
				    [Left Join SigCdCor c On c.Cods = a.CodCors ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
			Select crSigCdDic
			Insert Into crProdutos (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
Select crProdutos
		lcQuery = [Select Expressao, Traducao ] + ;
					[From SigCdDic ] + ;
		If (.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrDsc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1294 linhas total):

*-- Linhas 72 a 90:
72: 
73:             *-- Cursor placeholder de produtos (sera populado pelo BtnSelecionarClick)
74:             SET NULL ON
75:             CREATE CURSOR cursor_4c_Produtos ;
76:                 (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
77:                  DscCompras M(4) NULL, ObsCompras M(4) NULL)
78:             SET NULL OFF
79: 
80:             *-- Configuracao base do form (Picture, dimensoes, Caption reforcados)
81:             *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
82:             *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
83:             THIS.ConfigurarPageFrame()
84: 
85:             *-- Configurar controles visuais
86:             THIS.ConfigurarCabecalho()
87:             THIS.ConfigurarPaginaLista()
88:             THIS.ConfigurarPaginaDados()
89:             THIS.VincularEventos()
90: 

*-- Linhas 275 a 341:
275:     *==========================================================================
276:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
277:     *==========================================================================
278:         LOCAL loc_nI, loc_oObjeto, loc_oConteiner
279: 
280:         IF VARTYPE(par_oContainer) = "O"
281:             loc_oConteiner = par_oContainer
282:         ELSE
283:             loc_oConteiner = THIS
284:         ENDIF
285: 
286:         FOR loc_nI = 1 TO loc_oConteiner.ControlCount
287:             loc_oObjeto = loc_oConteiner.Controls(loc_nI)
288:             IF VARTYPE(loc_oObjeto) = "O"
289:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
290:                     loc_oObjeto.Visible = .T.
291:                 ENDIF
292:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
293:                     THIS.TornarControlesVisiveis(loc_oObjeto)
294:                 ENDIF
295:             ENDIF
296:         ENDFOR
297:     ENDPROC
298: 
299:     *==========================================================================
300:     PROCEDURE Destroy()
301:     *==========================================================================
302:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
303:             THIS.this_oBusinessObject = .NULL.
304:         ENDIF
305:         IF USED("cursor_4c_Produtos")
306:             USE IN cursor_4c_Produtos
307:         ENDIF
308:         IF USED("cursor_4c_Dicionario")
309:             USE IN cursor_4c_Dicionario
310:         ENDIF
311:         IF USED("cursor_4c_PrdTraduz")
312:             USE IN cursor_4c_PrdTraduz
313:         ENDIF
314:         IF USED("cursor_4c_LocalPro")
315:             USE IN cursor_4c_LocalPro
316:         ENDIF
317:         IF USED("cursor_4c_BuscaProDbl")
318:             USE IN cursor_4c_BuscaProDbl
319:         ENDIF
320:         IF USED("cursor_4c_BuscaGruDbl")
321:             USE IN cursor_4c_BuscaGruDbl
322:         ENDIF
323:         DODEFAULT()
324:     ENDPROC
325: 
326:     *==========================================================================
327:     PROTECTED PROCEDURE ConfigurarFiltros()
328:     *==========================================================================
329:         *-- Label "Produtos de :" - original Left=155, Top=138, escala 1.25
330:         THIS.AddObject("lbl_4c_ProdutosDe", "Label")
331:         WITH THIS.lbl_4c_ProdutosDe
332:             .AutoSize  = .F.
333:             .Width     = 90
334:             .Height    = 20
335:             .Left      = 194
336:             .Top       = 140
337:             .Caption   = "Produtos de :"
338:             .FontBold  = .T.
339:             .FontName  = "Tahoma"
340:             .FontSize  = 8
341:             .ForeColor = RGB(90,90,90)

*-- Linhas 354 a 372:
354:             .Height        = 24
355:             .MaxLength     = 14
356:             .Value         = ""
357:             .SelectOnEntry = .T.
358:             .Visible       = .T.
359:         ENDWITH
360: 
361:         *-- Label "ate" - original Left=345, Top=138
362:         THIS.AddObject("lbl_4c_Ate", "Label")
363:         WITH THIS.lbl_4c_Ate
364:             .AutoSize  = .F.
365:             .Width     = 30
366:             .Height    = 20
367:             .Left      = 431
368:             .Top       = 140
369:             .Caption   = "at" + CHR(233)
370:             .FontBold  = .T.
371:             .FontName  = "Tahoma"
372:             .FontSize  = 8

*-- Linhas 386 a 404:
386:             .Height        = 24
387:             .MaxLength     = 14
388:             .Value         = ""
389:             .SelectOnEntry = .T.
390:             .Visible       = .T.
391:         ENDWITH
392: 
393:         *-- Label "Grupo de Produto :" - original Left=505, Top=138
394:         THIS.AddObject("lbl_4c_Grupo", "Label")
395:         WITH THIS.lbl_4c_Grupo
396:             .AutoSize  = .F.
397:             .Width     = 130
398:             .Height    = 20
399:             .Left      = 631
400:             .Top       = 140
401:             .Caption   = "Grupo de Produto :"
402:             .FontBold  = .T.
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8

*-- Linhas 418 a 496:
418:             .Height        = 24
419:             .MaxLength     = 3
420:             .Value         = ""
421:             .SelectOnEntry = .T.
422:             .Visible       = .T.
423:         ENDWITH
424:     ENDPROC
425: 
426:     *==========================================================================
427:     PROTECTED PROCEDURE ConfigurarGrade()
428:     *==========================================================================
429:         THIS.AddObject("grd_4c_Dados", "Grid")
430:         WITH THIS.grd_4c_Dados
431:             .Top                = 164
432:             .Left               = 19
433:             .Width              = 961
434:             .Height             = 343
435:             .ColumnCount        = 3
436:             .FontSize           = 8
437:             .FontName           = "Verdana"
438:             .AllowHeaderSizing  = .F.
439:             .AllowRowSizing     = .F.
440:             .DeleteMark         = .F.
441:             .RecordMark         = .F.
442:             .HeaderHeight       = 17
443:             .RowHeight          = 17
444:             .ScrollBars         = 2
445:             .ReadOnly           = .T.
446:             .HighlightStyle     = 2
447:             .HighlightBackColor = RGB(255,255,255)
448:             .HighlightForeColor = RGB(15,41,104)
449:             .GridLineColor      = RGB(238,238,238)
450:             .RecordSource       = "cursor_4c_Produtos"
451: 
452:             WITH .Column1
453:                 .Width         = 135
454:                 .FontSize      = 8
455:                 .ControlSource = "cursor_4c_Produtos.CPros"
456:                 .ReadOnly      = .T.
457:                 WITH .Header1
458:                     .Caption   = "C" + CHR(243) + "digo"
459:                     .FontName  = "Tahoma"
460:                     .FontSize  = 8
461:                     .Alignment = 2
462:                 ENDWITH
463:             ENDWITH
464: 
465:             WITH .Column2
466:                 .Width         = 363
467:                 .FontSize      = 8
468:                 .ControlSource = "cursor_4c_Produtos.Portugues"
469:                 .ReadOnly      = .T.
470:                 WITH .Header1
471:                     .Caption   = "Portugu" + CHR(234) + "s"
472:                     .FontName  = "Tahoma"
473:                     .FontSize  = 8
474:                     .Alignment = 2
475:                 ENDWITH
476:             ENDWITH
477: 
478:             WITH .Column3
479:                 .Width         = 427
480:                 .FontSize      = 8
481:                 .ControlSource = "cursor_4c_Produtos.Traduzido"
482:                 .ReadOnly      = .T.
483:                 WITH .Header1
484:                     .Caption   = "Traduzido"
485:                     .FontName  = "Tahoma"
486:                     .FontSize  = 8
487:                     .Alignment = 2
488:                 ENDWITH
489:             ENDWITH
490: 
491:             .Visible = .T.
492:         ENDWITH
493:     ENDPROC
494: 
495:     *==========================================================================
496:     PROCEDURE VincularEventos()

*-- Linhas 582 a 626:
582:         ENDIF
583: 
584:         *-- Tenta match exato primeiro
585:         loc_cSQL = "SELECT TOP 1 CPros FROM SigCdPro WHERE RTRIM(CPros) = " + ;
586:                    EscaparSQL(loc_cVal)
587:         IF USED("cursor_4c_BuscaProTmp")
588:             USE IN cursor_4c_BuscaProTmp
589:         ENDIF
590:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProTmp") > 0 AND ;
591:            !EOF("cursor_4c_BuscaProTmp")
592:             SELECT cursor_4c_BuscaProTmp
593:             loc_cCodigo    = ALLTRIM(CPros)
594:             loc_lEncontrou = .T.
595:         ENDIF
596:         IF USED("cursor_4c_BuscaProTmp")
597:             USE IN cursor_4c_BuscaProTmp
598:         ENDIF
599: 
600:         IF !loc_lEncontrou
601:             TRY
602:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
603:                     "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cVal, ;
604:                     "Sele" + CHR(231) + CHR(227) + "o de Produto", .T., .T., "")
605:                 IF VARTYPE(loc_oBusca) = "O"
606:                     loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
607:                     loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
608:                     loc_oBusca.mAddColuna("CGrus", "", "Grupo")
609:                     loc_oBusca.Show()
610:                     IF USED("cursor_4c_BuscaPro") AND loc_oBusca.this_lSelecionou
611:                         SELECT cursor_4c_BuscaPro
612:                         loc_cCodigo    = ALLTRIM(CPros)
613:                         loc_lEncontrou = .T.
614:                     ENDIF
615:                     IF USED("cursor_4c_BuscaPro")
616:                         USE IN cursor_4c_BuscaPro
617:                     ENDIF
618:                 ENDIF
619:             CATCH TO loc_oErro
620:                 MsgErro("Erro na busca de produto: " + loc_oErro.Message, "Erro")
621:             ENDTRY
622:         ENDIF
623: 
624:         IF loc_lEncontrou
625:             DO CASE
626:                 CASE par_cCampo = "CProsI"

*-- Linhas 661 a 704:
661:         ENDIF
662: 
663:         *-- Tenta match exato primeiro
664:         loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdGrp WHERE RTRIM(CGrus) = " + ;
665:                    EscaparSQL(loc_cVal)
666:         IF USED("cursor_4c_BuscaGruTmp")
667:             USE IN cursor_4c_BuscaGruTmp
668:         ENDIF
669:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGruTmp") > 0 AND ;
670:            !EOF("cursor_4c_BuscaGruTmp")
671:             SELECT cursor_4c_BuscaGruTmp
672:             loc_cCodigo    = ALLTRIM(CGrus)
673:             loc_lEncontrou = .T.
674:         ENDIF
675:         IF USED("cursor_4c_BuscaGruTmp")
676:             USE IN cursor_4c_BuscaGruTmp
677:         ENDIF
678: 
679:         IF !loc_lEncontrou
680:             TRY
681:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
682:                     "SigCdGrp", "cursor_4c_BuscaGru", "CGrus", loc_cVal, ;
683:                     "Sele" + CHR(231) + CHR(227) + "o de Grupo", .T., .T., "")
684:                 IF VARTYPE(loc_oBusca) = "O"
685:                     loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
686:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
687:                     loc_oBusca.Show()
688:                     IF USED("cursor_4c_BuscaGru") AND loc_oBusca.this_lSelecionou
689:                         SELECT cursor_4c_BuscaGru
690:                         loc_cCodigo    = ALLTRIM(CGrus)
691:                         loc_lEncontrou = .T.
692:                     ENDIF
693:                     IF USED("cursor_4c_BuscaGru")
694:                         USE IN cursor_4c_BuscaGru
695:                     ENDIF
696:                 ENDIF
697:             CATCH TO loc_oErro
698:                 MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
699:             ENDTRY
700:         ENDIF
701: 
702:         IF loc_lEncontrou
703:             THIS.txt_4c_CGrus.Value = loc_cCodigo
704:             THIS.txt_4c_CGrus.Refresh

*-- Linhas 738 a 756:
738:                 loc_oBusca.mAddColuna("CGrus", "", "Grupo")
739:                 loc_oBusca.Show()
740:                 IF USED("cursor_4c_BuscaProDbl") AND loc_oBusca.this_lSelecionou
741:                     SELECT cursor_4c_BuscaProDbl
742:                     loc_cCodigo = ALLTRIM(CPros)
743:                     DO CASE
744:                         CASE par_cCampo = "CProsI"
745:                             THIS.txt_4c_CProsI.Value = loc_cCodigo
746:                             THIS.txt_4c_CProsI.Refresh
747:                             IF EMPTY(THIS.txt_4c_CProsF.Value)
748:                                 THIS.txt_4c_CProsF.Value = loc_cCodigo
749:                                 THIS.txt_4c_CProsF.Refresh
750:                             ENDIF
751:                             THIS.txt_4c_CGrus.Value = ""
752:                             THIS.txt_4c_CGrus.Refresh
753:                         CASE par_cCampo = "CProsF"
754:                             THIS.txt_4c_CProsF.Value = loc_cCodigo
755:                             THIS.txt_4c_CProsF.Refresh
756:                             IF EMPTY(THIS.txt_4c_CProsI.Value)

*-- Linhas 789 a 807:
789:                 loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
790:                 loc_oBusca.Show()
791:                 IF USED("cursor_4c_BuscaGruDbl") AND loc_oBusca.this_lSelecionou
792:                     SELECT cursor_4c_BuscaGruDbl
793:                     loc_cCodigo = ALLTRIM(CGrus)
794:                     THIS.txt_4c_CGrus.Value = loc_cCodigo
795:                     THIS.txt_4c_CGrus.Refresh
796:                     THIS.txt_4c_CProsI.Value = ""
797:                     THIS.txt_4c_CProsI.Refresh
798:                     THIS.txt_4c_CProsF.Value = ""
799:                     THIS.txt_4c_CProsF.Refresh
800:                 ENDIF
801:                 IF USED("cursor_4c_BuscaGruDbl")
802:                     USE IN cursor_4c_BuscaGruDbl
803:                 ENDIF
804:             ENDIF
805:         CATCH TO loc_oErro
806:             MsgErro("Erro na busca de grupo: " + loc_oErro.Message, "Erro")
807:         ENDTRY

*-- Linhas 1055 a 1258:
1055:         loc_cPrF = PADR(ALLTRIM(THIS.txt_4c_CProsF.Value), 14)
1056: 
1057:         IF !EMPTY(loc_cGru)
1058:             loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
1059:                        "WHERE CGrus = " + EscaparSQL(PADR(loc_cGru, 3)) + ;
1060:                        " ORDER BY CPros"
1061:         ELSE
1062:             loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
1063:                        "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + ;
1064:                        " AND " + EscaparSQL(loc_cPrF) + ;
1065:                        " ORDER BY CPros"
1066:         ENDIF
1067: 
1068:         IF USED("cursor_4c_PrdTraduz")
1069:             USE IN cursor_4c_PrdTraduz
1070:         ENDIF
1071: 
1072:         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrdTraduz") < 1
1073:             MsgErro("Falha ao carregar produtos.", "Erro")
1074:             RETURN
1075:         ENDIF
1076: 
1077:         loc_nRecs = RECCOUNT("cursor_4c_PrdTraduz")
1078:         IF loc_nRecs = 0
1079:             MsgAviso("Nenhum produto encontrado com os filtros informados.", "Aviso")
1080:             USE IN cursor_4c_PrdTraduz
1081:             RETURN
1082:         ENDIF
1083: 
1084:         loc_oProg = .NULL.
1085:         TRY
1086:             loc_oProg = CREATEOBJECT("fwprogressbar", ;
1087:                 "Processando Tradu" + CHR(231) + CHR(245) + "es...", loc_nRecs)
1088:             IF VARTYPE(loc_oProg) = "O"
1089:                 loc_oProg.Show
1090:             ENDIF
1091:         CATCH TO loc_oErro
1092:             loc_oProg = .NULL.
1093:         ENDTRY
1094: 
1095:         SELECT cursor_4c_PrdTraduz
1096:         GO TOP
1097:         SCAN
1098:             loc_cPro = ALLTRIM(cursor_4c_PrdTraduz.CPros)
1099:             loc_cDes = ""
1100:             loc_cIni = ""
1101:             loc_nGrD = 0
1102: 
1103:             IF VARTYPE(loc_oProg) = "O"
1104:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1105:                 loc_oProg.Update(.T.)
1106:             ENDIF
1107: 
1108:             IF !EMPTY(loc_cPro)
1109:                 *-- Busca descricao do grupo e cor do produto
1110:                 loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, b.DGrus, " + ;
1111:                            "b.Mercs, b.MontaGrDs, c.Descs " + ;
1112:                            "FROM SigCdPro a " + ;
1113:                            "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
1114:                            "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
1115:                            "WHERE a.CPros = " + EscaparSQL(loc_cPro)
1116: 
1117:                 IF USED("cursor_4c_LocalPro")
1118:                     USE IN cursor_4c_LocalPro
1119:                 ENDIF
1120: 
1121:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") > 0 AND ;
1122:                    !EOF("cursor_4c_LocalPro")
1123:                     SELECT cursor_4c_LocalPro
1124:                     loc_cIni = ALLTRIM(NVL(DGrus, "")) + " " + ALLTRIM(NVL(Descs, ""))
1125:                     loc_cIni = ALLTRIM(loc_cIni)
1126:                     loc_nGrD = NVL(MontaGrDs, 0)
1127:                 ENDIF
1128: 
1129:                 IF USED("cursor_4c_LocalPro")
1130:                     USE IN cursor_4c_LocalPro
1131:                 ENDIF
1132: 
1133:                 *-- Usa descricao montada quando MontaGrDs=1 (flag de montagem)
1134:                 IF loc_nGrD != 0 AND !EMPTY(loc_cIni)
1135:                     loc_cDes = loc_cIni
1136:                 ENDIF
1137: 
1138:                 IF !EMPTY(loc_cDes)
1139:                     *-- Traduz para ingles usando SigCdDic (ordenado por expressao mais longa)
1140:                     loc_cIng = loc_cDes
1141: 
1142:                     IF USED("cursor_4c_Dicionario")
1143:                         SELECT cursor_4c_Dicionario
1144:                         GO TOP
1145:                         SCAN
1146:                             loc_cIng = STRTRAN(loc_cIng, ;
1147:                                 ALLTRIM(cursor_4c_Dicionario.Expressao), ;
1148:                                 ALLTRIM(cursor_4c_Dicionario.Traducao))
1149:                         ENDSCAN
1150:                     ENDIF
1151: 
1152:                     *-- Remove aspas simples/duplas para evitar problemas no SQL futuro
1153:                     loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
1154:                     loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")
1155: 
1156:                     *-- Insere no cursor (APPEND BLANK seguro para campos memo)
1157:                     SELECT cursor_4c_Produtos
1158:                     APPEND BLANK
1159:                     REPLACE cursor_4c_Produtos.CPros      WITH loc_cPro, ;
1160:                             cursor_4c_Produtos.Portugues  WITH loc_cDes, ;
1161:                             cursor_4c_Produtos.Traduzido  WITH loc_cIng, ;
1162:                             cursor_4c_Produtos.DscCompras WITH loc_cIng, ;
1163:                             cursor_4c_Produtos.ObsCompras WITH loc_cDes
1164:                 ENDIF
1165:             ENDIF
1166: 
1167:             *-- Restaura contexto do SCAN externo
1168:             SELECT cursor_4c_PrdTraduz
1169:             THIS.grd_4c_Dados.Refresh
1170:         ENDSCAN
1171: 
1172:         IF USED("cursor_4c_PrdTraduz")
1173:             USE IN cursor_4c_PrdTraduz
1174:         ENDIF
1175: 
1176:         IF VARTYPE(loc_oProg) = "O"
1177:             loc_oProg.Complete
1178:         ENDIF
1179: 
1180:         SELECT cursor_4c_Produtos
1181:         GO TOP
1182:         IF !EOF("cursor_4c_Produtos")
1183:             THIS.cmd_4c_BtnAtualizar.Enabled = .T.
1184:         ENDIF
1185:     ENDPROC
1186: 
1187:     *==========================================================================
1188:     PROTECTED PROCEDURE Gravacao()
1189:     *  Grava descricoes: UPDATE SigCdPro + DELETE SigPrPrt por produto
1190:     *==========================================================================
1191:         LOCAL loc_lOk, loc_cPro, loc_cSQL, loc_oProg, loc_nRecs
1192:         LOCAL loc_nResult, loc_oErro
1193:         loc_lOk = .T.
1194: 
1195:         SELECT cursor_4c_Produtos
1196:         loc_nRecs = RECCOUNT("cursor_4c_Produtos")
1197: 
1198:         IF loc_nRecs = 0
1199:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
1200:                      " produtos para gravar.", "Aviso")
1201:             RETURN
1202:         ENDIF
1203: 
1204:         loc_oProg = .NULL.
1205:         TRY
1206:             loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nRecs)
1207:             IF VARTYPE(loc_oProg) = "O"
1208:                 loc_oProg.Show
1209:             ENDIF
1210:         CATCH TO loc_oErro
1211:             loc_oProg = .NULL.
1212:         ENDTRY
1213: 
1214:         SELECT cursor_4c_Produtos
1215:         GO TOP
1216:         SCAN WHILE loc_lOk
1217:             loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)
1218: 
1219:             IF VARTYPE(loc_oProg) = "O"
1220:                 loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
1221:                 loc_oProg.Update(.T.)
1222:             ENDIF
1223: 
1224:             *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
1225:             loc_cSQL = "UPDATE SigCdPro " + ;
1226:                        "SET DscCompras = " + ;
1227:                            EscaparSQL(ALLTRIM(cursor_4c_Produtos.DscCompras)) + ", " + ;
1228:                        "ObsCompras = " + ;
1229:                            EscaparSQL(ALLTRIM(cursor_4c_Produtos.ObsCompras)) + ", " + ;
1230:                        "DPros = " + ;
1231:                            EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + ;
1232:                        " WHERE CPros = " + EscaparSQL(loc_cPro)
1233: 
1234:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1235:             IF loc_nResult < 1
1236:                 MsgErro("Falha ao gravar produto " + loc_cPro + " em SigCdPro.", "Erro")
1237:                 loc_lOk = .F.
1238:                 LOOP
1239:             ENDIF
1240: 
1241:             *-- DELETE FROM SigPrPrt (remove produto da fila de processamento)
1242:             loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
1243:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1244:             IF loc_nResult < 1
1245:                 MsgErro("Falha ao remover produto " + loc_cPro + " de SigPrPrt.", "Erro")
1246:                 loc_lOk = .F.
1247:             ENDIF
1248:         ENDSCAN
1249: 
1250:         IF VARTYPE(loc_oProg) = "O"
1251:             loc_oProg.Complete
1252:         ENDIF
1253: 
1254:         IF loc_lOk
1255:             MsgInfo("Foram gravados " + ALLTRIM(STR(loc_nRecs)) + " produtos!", ;
1256:                     "Processamento Conclu" + CHR(237) + "do!")
1257:         ELSE
1258:             MsgAviso("Ocorreu um erro com a grava" + CHR(231) + CHR(227) + ;


### BO (C:\4c\projeto\app\classes\SigPrDscBO.prg):
*==============================================================================
* SIGPRDSCBO.PRG - Business Object para Montagem de Descricao de Produtos
* Tabela principal: SigCdPro
* Form operacional: processa descricoes/traducoes de produtos em lote
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *-- Filtros de selecao
    this_cCProsI     = ""   && Codigo produto inicial (filtro intervalo)
    this_cCProsF     = ""   && Codigo produto final (filtro intervalo)
    this_cCGrus      = ""   && Codigo grupo de produto (filtro alternativo)

    *-- Propriedades do produto corrente (linha selecionada na grade)
    this_cCPros      = ""   && Codigo do produto (CPros)
    this_cDPros      = ""   && Descricao do produto (DPros)
    this_cCGrusProd  = ""   && Grupo do produto (CGrus)
    this_cCodCors    = ""   && Codigo da cor (CodCors)
    this_cPortugues  = ""   && Descricao montada em Portugues
    this_cTraduzido  = ""   && Descricao traduzida (Ingles)
    this_cDscCompras = ""   && Descricao para compras (DscCompras)
    this_cObsCompras = ""   && Observacao para compras (ObsCompras)

    *--------------------------------------------------------------------------
    * INIT - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT("SigCdPro")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCPros      = TratarNulo(CPros,      "C")
                THIS.this_cDPros      = TratarNulo(DPros,      "C")
                THIS.this_cCGrusProd  = TratarNulo(CGrus,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cDscCompras = TratarNulo(DscCompras, "C")
                THIS.this_cObsCompras = TratarNulo(ObsCompras, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Seleciona produtos conforme filtros para a grade
    * Popula cursor_4c_Produtos (CPros, Portugues, Traduzido, DscCompras, ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lResultado, loc_cSQL, loc_cFiltro, loc_cPrI, loc_cPrF, loc_cGru
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT CPros, '' AS Portugues, '' AS Traduzido, " + ;
                       "ISNULL(DscCompras,'') AS DscCompras, " + ;
                       "ISNULL(ObsCompras,'') AS ObsCompras " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY CPros"

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar produtos"
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_Produtos")
                TABLEREVERT(.T., "cursor_4c_Produtos")
                USE IN cursor_4c_Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Produtos ;
                (CPros C(14) NULL, Portugues C(254) NULL, Traduzido C(254) NULL, ;
                 DscCompras M(4) NULL, ObsCompras M(4) NULL)
            SET NULL OFF

            IF RECCOUNT("cursor_4c_ProdutosTemp") > 0
                SELECT cursor_4c_Produtos
                APPEND FROM DBF("cursor_4c_ProdutosTemp")
            ENDIF

            IF USED("cursor_4c_ProdutosTemp")
                USE IN cursor_4c_ProdutosTemp
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDescricoes - Monta descricoes em Portugues e traduz para Ingles
    * Usa crSigCdDic (dicionario) e SigCdGrp/SigCdCor para montar descricao
    * Popula colunas Portugues/Traduzido de cursor_4c_Produtos
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDescricoes()
        LOCAL loc_lResultado, loc_cSQL, loc_cPro, loc_cDes, loc_cIng
        LOCAL loc_cPrI, loc_cPrF, loc_cGru, loc_cFiltro
        LOCAL loc_cDGrus, loc_cDescs, loc_nMontaGrDs
        loc_lResultado = .F.

        TRY
            loc_cPrI = PADR(ALLTRIM(THIS.this_cCProsI), 14)
            loc_cPrF = PADR(ALLTRIM(THIS.this_cCProsF), 14)
            loc_cGru = PADR(ALLTRIM(THIS.this_cCGrus),  3)

            IF !EMPTY(loc_cGru)
                loc_cFiltro = "a.CGrus = '" + loc_cGru + "'"
            ELSE
                loc_cFiltro = "a.CPros BETWEEN '" + loc_cPrI + "' AND '" + loc_cPrF + "'"
            ENDIF

            loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                       "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                       "FROM SigCdPro a " + ;
                       "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                       "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                       "WHERE " + loc_cFiltro + " " + ;
                       "ORDER BY a.CPros"

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfoTemp") < 1
                THIS.this_cMensagemErro = "Falha ao buscar informa" + CHR(231) + CHR(245) + "es dos produtos"
                loc_lResultado = .F.
            ENDIF

            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            ZAP

            SELECT cursor_4c_ProdInfoTemp
            GO TOP
            DO WHILE !EOF("cursor_4c_ProdInfoTemp")
                loc_cPro    = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.CPros,   ""))
                loc_cDGrus  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.DGrus,   ""))
                loc_cDescs  = ALLTRIM(NVL(cursor_4c_ProdInfoTemp.Descs,   ""))
                loc_nMontaGrDs = NVL(cursor_4c_ProdInfoTemp.MontaGrDs, 0)

                IF !EMPTY(loc_cPro)
                    *-- Monta descricao base: Grupo + Cor
                    loc_cDes = ALLTRIM(loc_cDGrus + " " + loc_cDescs)

                    IF !EMPTY(loc_cDes)
                        *-- Aplica dicionario de traducao
                        loc_cIng = loc_cDes
                        IF USED("cursor_4c_Dicionario")
                            SELECT cursor_4c_Dicionario
                            GO TOP
                            DO WHILE !EOF("cursor_4c_Dicionario")
                                loc_cIng = STRTRAN(loc_cIng, ;
                                    ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                    ALLTRIM(cursor_4c_Dicionario.Traducao))
                                SKIP IN cursor_4c_Dicionario
                            ENDDO
                        ENDIF

                        *-- Limpa caracteres especiais para SQL
                        loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                        loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                        SELECT cursor_4c_Produtos
                        INSERT INTO cursor_4c_Produtos ;
                            (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                            VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)
                    ENDIF
                ENDIF

                SKIP IN cursor_4c_ProdInfoTemp
            ENDDO

            IF USED("cursor_4c_ProdInfoTemp")
                USE IN cursor_4c_ProdInfoTemp
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDicionario - Carrega SigCdDic (Ingles) em cursor_4c_Dicionario
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDicionario()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"

            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                THIS.this_cMensagemErro = "Falha ao carregar dicion" + CHR(225) + "rio"
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - Atualiza SigCdPro e limpa SigPrPrt em lote
    * Percorre cursor_4c_Produtos e faz UPDATE em cada produto
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes(par_oProgressBar)
        LOCAL loc_lResultado, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_cPortugues, loc_cTraduzido, loc_cDscCompras, loc_cObsCompras
        loc_lResultado = .F.
        loc_lOks = .T.

        TRY
            IF !USED("cursor_4c_Produtos")
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado"
                loc_lResultado = .F.
            ENDIF

            SELECT cursor_4c_Produtos
            GO TOP

            DO WHILE !EOF("cursor_4c_Produtos") AND loc_lOks
                loc_cPro         = ALLTRIM(NVL(cursor_4c_Produtos.CPros,       ""))
                loc_cPortugues   = ALLTRIM(NVL(cursor_4c_Produtos.Portugues,   ""))
                loc_cTraduzido   = ALLTRIM(NVL(cursor_4c_Produtos.Traduzido,   ""))
                loc_cDscCompras  = ALLTRIM(NVL(cursor_4c_Produtos.DscCompras,  ""))
                loc_cObsCompras  = ALLTRIM(NVL(cursor_4c_Produtos.ObsCompras,  ""))

                IF VARTYPE(par_oProgressBar) = "O"
                    par_oProgressBar.SubTitulo.Caption = "Produto : " + loc_cPro
                    par_oProgressBar.Update(.T.)
                ENDIF

                *-- UPDATE SigCdPro
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(loc_cDscCompras) + ", " + ;
                           "ObsCompras = " + EscaparSQL(loc_cObsCompras) + ", " + ;
                           "DPros = '" + PADR(loc_cPortugues, 40) + "' " + ;
                           "WHERE CPros = '" + loc_cPro + "'"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar produto " + loc_cPro
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE SigPrPrt
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = '" + loc_cPro + "'"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                        THIS.this_cMensagemErro = "Falha ao limpar SigPrPrt para " + loc_cPro
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    IF SQLEXEC(gnConnHandle, "COMMIT", "") < 1
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF !loc_lOks
                    SQLEXEC(gnConnHandle, "ROLLBACK", "")
                ENDIF

                IF loc_lOks
                    SKIP IN cursor_4c_Produtos
                ELSE
                    EXIT
                ENDIF
            ENDDO

            loc_lResultado = loc_lOks
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK", "")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (CPros)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCPros)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel: form operacional nao cria produtos novos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza descricoes de um produto individual em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCPros)
                THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado"
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdPro " + ;
                       "SET DscCompras = " + EscaparSQL(THIS.this_cDscCompras) + ", " + ;
                       "ObsCompras = " + EscaparSQL(THIS.this_cObsCompras) + ", " + ;
                       "DPros = '" + PADR(ALLTRIM(THIS.this_cPortugues), 40) + "' " + ;
                       "WHERE CPros = '" + ALLTRIM(THIS.this_cCPros) + "'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "") < 1
                THIS.this_cMensagemErro = "Falha ao atualizar produto " + ALLTRIM(THIS.this_cCPros)
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria("A")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cCProsI     = ""
        THIS.this_cCProsF     = ""
        THIS.this_cCGrus      = ""
        THIS.this_cCPros      = ""
        THIS.this_cDPros      = ""
        THIS.this_cCGrusProd  = ""
        THIS.this_cCodCors    = ""
        THIS.this_cPortugues  = ""
        THIS.this_cTraduzido  = ""
        THIS.this_cDscCompras = ""
        THIS.this_cObsCompras = ""
        THIS.this_cMensagemErro = ""
    ENDPROC

ENDDEFINE

