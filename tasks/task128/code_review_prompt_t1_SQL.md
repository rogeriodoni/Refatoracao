# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, PROGRAMAS, LNI, USUACESS, USUARIOS, NTPIMPRES, LOCALENTS, X, MARCAS, DOPES, DATAS, ICLIS, PARAMETROS, CIMPS, GRUPOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATANFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, PROGRAMAS, LNI, USUACESS, USUARIOS, NTPIMPRES, LOCALENTS, X, MARCAS, DOPES, DATAS, ICLIS, PARAMETROS, CIMPS, GRUPOS

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
  ControlSource = ""
Select *, '1' as cpros, 1 as qtds, 0 as cbars from Relacao into cursor DbImpressao Readwrite
Select *, '1' as cpros, 1 as qtds, 0 as cbars, SPACE(10) as Obs from Relacao into cursor DbImpressao Readwrite
lcQryMala = [Select a.IClis, a.RClis, a.Endes, a.Nums, a.Compls, a.Bairs, a.Cidas, a.Ceps, a.Estas, ] + ;
			  [From SigMlCab a, SigCdCli b ] + ;
lcQuery = [Select pkChaves ] + ;
			[From SigCdAcU ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdAcU') < 1)
lnQueryOk = ThisForm.poDataMgr.SqlExecute('Select * From SigCdPam', 'crSigCdPam')
lcSql = [Select b.Impres ] + ;
		  [From SigSyImp a, SigCdmp b ] + ;
		[Select c.Impres ] + ;
		  [From SigCdAcG a, SigSyImp b, SigCdmp c ] + ;
If ThisForm.podatamgr.sqlexecute(lcSql,'crTmpCimp') <= 0
Select crTmpCImp
	Select Distinct Impres ;
	  From crTmpCImp ;
	lcQuery = [Select Distinct Impres ] + ;
			    [From SigCdmp ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdmp]) < 1)
Select crSigCdmp
	Select crSigCdmp
	Select TmpOper
				Select TmpOper			
				Select TmpOper				
				[Select * from TmpOper n] + Alltrim(Str(x,2,0)) + [ where marcas = 1 ] +;
	Select Relacao
Select Relacao
Select TmpOper
		lcQuery = [Select 0 as Marcas, a.Emps, a.Dopes, a.Numes, b.rclis as DescOrigs, c.Rclis as DescDests, a.ContaEs, a.LocalEnts, ] +;
					[from SigMvCab a inner join SigCdCli b on a.ContaOs = b.Iclis ] +;
					[inner join SigCdCli c on a.ContaDs = c.Iclis ] +;
		ThisForm.poDataMgr.SqlExecute(lcQuery,[TmpOper])
		Select TmpOper
Select TmpOper
Select tmpOper

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg) - TRECHOS RELEVANTES PARA PASS SQL (2431 linhas total):

*-- Linhas 81 a 100:
81:             IF loc_lContinuar AND ;
82:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
83: 
84:                 loc_nResult = SQLEXEC(gnConnHandle, ;
85:                     "SELECT pkChaves FROM SigCdAcU" + ;
86:                     " WHERE RTRIM(Programas) = 'SIGREIPE'" + ;
87:                     " AND RTRIM(Parametros) = 'LIBERAIMP'" + ;
88:                     " ORDER BY pkChaves", "cursor_4c_AcU")
89: 
90:                 IF USED("cursor_4c_AcU")
91:                     USE IN cursor_4c_AcU
92:                 ENDIF
93: 
94:                 IF loc_nResult < 0
95:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
96:                         "Falha na conex" + CHR(227) + "o (SigCdAcU).", "Erro")
97:                     loc_lContinuar = .F.
98:                 ENDIF
99:             ENDIF
100: 

*-- Linhas 402 a 456:
402:         LOCAL loc_oPagina
403:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
404: 
405:         *-- Cursor placeholder com mesmo esquema do SQLEXEC em ValidarDtFinal
406:         IF USED("cursor_4c_Operacoes")
407:             USE IN cursor_4c_Operacoes
408:         ENDIF
409:         CREATE CURSOR cursor_4c_Operacoes (;
410:             Marcas    I,;
411:             Emps      C(2),;
412:             Dopes     C(6),;
413:             Numes     N(8,0),;
414:             DescOrigs C(60),;
415:             DescDests C(60),;
416:             ContaEs   C(15),;
417:             LocalEnts N(8,0))
418: 
419:         THIS.ConfigurarGridOperacoes(loc_oPagina)
420:         THIS.ConfigurarBotoesSelecao(loc_oPagina)
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * ConfigurarGridOperacoes - Grid com 6 colunas para selecao de operacoes
425:     *   CheckBox em Column1: AddObject -> Caption/Value -> CurrentControl -> ControlSource
426:     *--------------------------------------------------------------------------
427:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPage)
428:         LOCAL loc_oGrid
429: 
430:         par_oPage.AddObject("grd_4c_GrdOper", "Grid")
431:         loc_oGrid = par_oPage.grd_4c_GrdOper
432: 
433:         WITH loc_oGrid
434:             .Top                = 125
435:             .Left               = 17
436:             .Width              = 727
437:             .Height             = 148
438:             .ColumnCount        = 6
439:             .RecordSource       = "cursor_4c_Operacoes"
440:             .RecordMark         = .F.
441:             .DeleteMark         = .F.
442:             .ReadOnly           = .F.
443:             .FontName           = "Verdana"
444:             .FontSize           = 8
445:             .ForeColor          = RGB(90, 90, 90)
446:             .BackColor          = RGB(255, 255, 255)
447:             .GridLineColor      = RGB(238, 238, 238)
448:             .HighlightBackColor = RGB(255, 255, 255)
449:             .HighlightForeColor = RGB(15, 41, 104)
450:             .HighlightStyle     = 2
451:             .ScrollBars         = 2
452:             .RowHeight          = 16
453: 
454:             *-- Column1: Marcas (CheckBox) - ordem critica obrigatoria
455:             WITH .Column1
456:                 .Width     = 30

*-- Linhas 462 a 515:
462:                 .Check1.Width   = 25
463:                 .Check1.Height  = 14
464:                 .CurrentControl  = "Check1"
465:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
466:                 .Header1.Caption = ""
467:             ENDWITH
468: 
469:             *-- Column2: Emps
470:             WITH .Column2
471:                 .Width           = 40
472:                 .ControlSource   = "cursor_4c_Operacoes.Emps"
473:                 .Header1.Caption = "Emp"
474:             ENDWITH
475: 
476:             *-- Column3: Dopes (Operacao)
477:             WITH .Column3
478:                 .Width           = 80
479:                 .ControlSource   = "cursor_4c_Operacoes.Dopes"
480:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
481:             ENDWITH
482: 
483:             *-- Column4: Numes (Codigo)
484:             WITH .Column4
485:                 .Width           = 70
486:                 .ControlSource   = "cursor_4c_Operacoes.Numes"
487:                 .Header1.Caption = CHR(67) + CHR(243) + "digo"
488:             ENDWITH
489: 
490:             *-- Column5: DescOrigs (Conta Origem)
491:             WITH .Column5
492:                 .Width           = 255
493:                 .ControlSource   = "cursor_4c_Operacoes.DescOrigs"
494:                 .Header1.Caption = "Origem"
495:             ENDWITH
496: 
497:             *-- Column6: DescDests (Conta Destino) - 30+40+80+70+255+252=727
498:             WITH .Column6
499:                 .Width           = 252
500:                 .ControlSource   = "cursor_4c_Operacoes.DescDests"
501:                 .Header1.Caption = "Destino"
502:             ENDWITH
503: 
504:             .Visible = .T.
505:         ENDWITH
506:     ENDPROC
507: 
508:     *--------------------------------------------------------------------------
509:     * ConfigurarBotoesSelecao - Botoes SelTudo e Apaga ao lado direito do grid
510:     *--------------------------------------------------------------------------
511:     PROTECTED PROCEDURE ConfigurarBotoesSelecao(par_oPage)
512:         *-- SelTudo: selecionar todos (original top=220, left=756, w=45, h=45 -> Page1: top=138)
513:         par_oPage.AddObject("cmd_4c_SelTudo", "CommandButton")
514:         WITH par_oPage.cmd_4c_SelTudo
515:             .Top           = 138

*-- Linhas 556 a 591:
556: 
557:     *--------------------------------------------------------------------------
558:     * CmdSelTudoClick - Marca todos os registros do grid (Marcas=1)
559:     *   Replica: Select tmpOper + Replace All tmpOper.marcas with 1
560:     *--------------------------------------------------------------------------
561:     PROCEDURE CmdSelTudoClick()
562:         IF USED("cursor_4c_Operacoes")
563:             SELECT cursor_4c_Operacoes
564:             REPLACE ALL Marcas WITH 1
565:             GO TOP
566:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
567:         ENDIF
568:     ENDPROC
569: 
570:     *--------------------------------------------------------------------------
571:     * CmdApagaClick - Desmarca todos os registros do grid (Marcas=0)
572:     *   Replica: Select TmpOper + Replace All TmpOper.marcas with 0
573:     *--------------------------------------------------------------------------
574:     PROCEDURE CmdApagaClick()
575:         IF USED("cursor_4c_Operacoes")
576:             SELECT cursor_4c_Operacoes
577:             REPLACE ALL Marcas WITH 0
578:             GO TOP
579:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
580:         ENDIF
581:     ENDPROC
582: 
583:     *--------------------------------------------------------------------------
584:     * AlternarPagina - Alterna para pagina indicada no PageFrame
585:     *   Formulario de etiquetas usa PageCount=1 (todos os controles em Page1)
586:     *--------------------------------------------------------------------------
587:     PROCEDURE AlternarPagina(par_nPagina)
588:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
589:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
590:         ENDIF
591:     ENDPROC

*-- Linhas 1147 a 1258:
1147:         ENDIF
1148: 
1149:         TRY
1150:             loc_cSQL    = "SELECT TOP 1 Dopes FROM SigMvCab" + ;
1151:                           " WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor)
1152:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NmOpVal")
1153: 
1154:             IF loc_nResult > 0
1155:                 SELECT cursor_4c_NmOpVal
1156:                 IF EOF()
1157:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cValor + ;
1158:                         "' n" + CHR(227) + "o encontrada.", "Aviso")
1159:                     loc_oPg1.txt_4c__nm_operacao.Value = ""
1160:                 ENDIF
1161:             ENDIF
1162: 
1163:             IF USED("cursor_4c_NmOpVal")
1164:                 USE IN cursor_4c_NmOpVal
1165:             ENDIF
1166: 
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message + CHR(13) + ;
1169:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1170:         ENDTRY
1171: 
1172:         THIS.AtualizarEstadoControles()
1173:     ENDPROC
1174: 
1175:     *--------------------------------------------------------------------------
1176:     * ValidarDtFinal - Executa SQL e popula grid com operacoes do periodo
1177:     *   Replica: get_dt_final.Valid do original
1178:     *   SQL: SigMvCab JOIN SigCdCli (b=ContaOs, c=ContaDs) com todos os campos
1179:     *   Cursor READWRITE (para marcacao via CheckBox no grid)
1180:     *   lnConta=1 -> usar dados de SigCdCli da Conta Origem (b.*)
1181:     *   lnConta=2 -> usar dados de SigCdCli da Conta Destino (c.*)
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE ValidarDtFinal()
1184:         LOCAL loc_oPg1, loc_cDopes, loc_dDataIni, loc_dDataFin
1185:         LOCAL loc_nConta, loc_cSQL, loc_nResult, loc_oGrid
1186:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1187:         loc_cDopes   = ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value)
1188:         loc_dDataIni = loc_oPg1.txt_4c__dt_inicial.Value
1189:         loc_dDataFin = loc_oPg1.txt_4c__dt_final.Value
1190:         loc_nConta   = loc_oPg1.obj_4c_Opt_conta.Value
1191:         loc_oGrid    = loc_oPg1.grd_4c_GrdOper
1192: 
1193:         IF EMPTY(loc_dDataFin)
1194:             RETURN
1195:         ENDIF
1196: 
1197:         loc_oGrid.RecordSource = ""
1198: 
1199:         TRY
1200:             IF loc_nConta = 1
1201:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1202:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1203:                            "a.ContaEs, a.LocalEnts, " + ;
1204:                            "b.IClis, b.RClis, b.Endes, b.Nums, b.Compls, " + ;
1205:                            "b.Bairs, b.Cidas, b.Ceps, b.Estas, b.Tel1s, " + ;
1206:                            "b.Tel2s, b.Faxs, b.Nascs, b.cIdChaves, " + ;
1207:                            "b.Codigos, b.Paises, b.Contato " + ;
1208:                            "FROM SigMvCab a " + ;
1209:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1210:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1211:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1212:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1213:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1214:                            " ORDER BY a.Numes"
1215:             ELSE
1216:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1217:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1218:                            "a.ContaEs, a.LocalEnts, " + ;
1219:                            "c.IClis, c.RClis, c.Endes, c.Nums, c.Compls, " + ;
1220:                            "c.Bairs, c.Cidas, c.Ceps, c.Estas, c.Tel1s, " + ;
1221:                            "c.Tel2s, c.Faxs, c.Nascs, c.cIdChaves, " + ;
1222:                            "c.Codigos, c.Paises, c.Contato " + ;
1223:                            "FROM SigMvCab a " + ;
1224:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1225:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1226:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1227:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1228:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1229:                            " ORDER BY a.Numes"
1230:             ENDIF
1231: 
1232:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpQuery")
1233: 
1234:             IF loc_nResult > 0
1235:                 IF USED("cursor_4c_Operacoes")
1236:                     USE IN cursor_4c_Operacoes
1237:                 ENDIF
1238:                 SELECT * FROM cursor_4c_TmpQuery INTO CURSOR cursor_4c_Operacoes READWRITE
1239:                 IF USED("cursor_4c_TmpQuery")
1240:                     USE IN cursor_4c_TmpQuery
1241:                 ENDIF
1242: 
1243:                 SELECT cursor_4c_Operacoes
1244:                 IF !EOF()
1245:                     GO TOP
1246:                     loc_oGrid.ColumnCount = 3
1247:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1248:                 ELSE
1249:                     MsgAviso("Nenhum movimento encontrado nesse per" + ;
1250:                         CHR(237) + "odo.", "Aviso")
1251:                 ENDIF
1252:             ELSE
1253:                 IF USED("cursor_4c_TmpQuery")
1254:                     USE IN cursor_4c_TmpQuery
1255:                 ENDIF
1256:                 MsgErro("Erro ao consultar movimentos de " + loc_cDopes + ".", "Erro")
1257:             ENDIF
1258: 

*-- Linhas 1789 a 1885:
1789:     * CarregarImpressoras - Carrega impressoras termicas autorizadas para o usuario
1790:     *   1. Consulta SigCdPam/SigCdPac para parametros de impressao termica
1791:     *   2. APRINTERS() lista todas as impressoras Windows instaladas
1792:     *   3. SQLEXEC filtra impressoras termicas (SigSyImp+SigCdmp, nTpImpres=2)
1793:     *   4. Expande ButtonCount de obj_4c_Opt_Impressora com impressoras encontradas
1794:     *--------------------------------------------------------------------------
1795:     PROCEDURE CarregarImpressoras()
1796:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nMaxImpEti
1797:         LOCAL loc_nPrinters, loc_nI, loc_nCnt, loc_nImp, loc_nOk, loc_lcI
1798:         LOCAL loc_nTop, loc_nHeight, loc_oPg1, loc_oOptImp
1799:         DIMENSION loc_laPrinters(10, 2)
1800:         DIMENSION loc_laImpOk(1)
1801:         loc_lSucesso  = .F.
1802:         loc_nMaxImpEti = 5
1803: 
1804:         TRY
1805:             *-- Parametros de impressao termica: SigCdPam
1806:             loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "cursor_4c_SigCdPam")
1807:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigCdPam")
1808:                 SELECT cursor_4c_SigCdPam
1809:                 GO TOP
1810:                 THIS.this_nTpImp   = IIF(cursor_4c_SigCdPam.ImpEtis <> 0, cursor_4c_SigCdPam.ImpEtis, 1)
1811:                 THIS.this_nAjVerts = cursor_4c_SigCdPam.AjVerts
1812:                 THIS.this_nAjHorzs = cursor_4c_SigCdPam.AjHorzs
1813:                 loc_nMaxImpEti     = IIF(cursor_4c_SigCdPam.nMaxImpEti > 5, cursor_4c_SigCdPam.nMaxImpEti, 5)
1814:             ENDIF
1815:             IF USED("cursor_4c_SigCdPam")
1816:                 USE IN cursor_4c_SigCdPam
1817:             ENDIF
1818: 
1819:             *-- Ajustes de impressora: SigCdPac
1820:             loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "cursor_4c_SigCdPac")
1821:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigCdPac")
1822:                 SELECT cursor_4c_SigCdPac
1823:                 GO TOP
1824:                 THIS.this_nAjDenss = IIF(cursor_4c_SigCdPac.AjDens < 10, 10, cursor_4c_SigCdPac.AjDens)
1825:                 THIS.this_nAjVelos = IIF(cursor_4c_SigCdPac.AjVelos < 1, 1, cursor_4c_SigCdPac.AjVelos)
1826:             ENDIF
1827:             IF USED("cursor_4c_SigCdPac")
1828:                 USE IN cursor_4c_SigCdPac
1829:             ENDIF
1830: 
1831:             *-- Lista de impressoras Windows (APRINTERS retorna array 2D: nome, porta)
1832:             loc_nPrinters = APRINTERS(loc_laPrinters)
1833:             IF loc_nPrinters > 0
1834:                 FOR loc_nI = 1 TO loc_nPrinters
1835:                     loc_laPrinters(loc_nI, 1) = UPPER(loc_laPrinters(loc_nI, 1))
1836:                 ENDFOR
1837:                 =ASORT(loc_laPrinters)
1838:             ENDIF
1839: 
1840:             *-- Impressoras termicas autorizadas para o usuario (SigSyImp+SigCdmp)
1841:             loc_cSQL = "SELECT b.Impres" + ;
1842:                        " FROM SigSyImp a, SigCdmp b" + ;
1843:                        " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1844:                        " AND a.CImps = b.Impres AND b.nTpImpres = 2" + ;
1845:                        " UNION ALL" + ;
1846:                        " SELECT c.Impres" + ;
1847:                        " FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
1848:                        " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
1849:                        " AND a.Grupos = b.GrAcess" + ;
1850:                        " AND b.CImps = c.Impres AND c.nTpImpres = 2"
1851: 
1852:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCImp")
1853:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TmpCImp") > 0
1854:                 SELECT DISTINCT Impres FROM cursor_4c_TmpCImp ;
1855:                     ORDER BY Impres ;
1856:                     INTO CURSOR cursor_4c_SigCdmp READWRITE
1857:             ELSE
1858:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1859:                     "SELECT DISTINCT Impres FROM SigCdmp WHERE nTpImpres = 2 ORDER BY Impres", ;
1860:                     "cursor_4c_SigCdmp")
1861:             ENDIF
1862:             IF USED("cursor_4c_TmpCImp")
1863:                 USE IN cursor_4c_TmpCImp
1864:             ENDIF
1865: 
1866:             *-- Cruzar impressoras autorizadas com as instaladas no Windows
1867:             loc_nCnt = 0
1868:             loc_nImp = 1
1869:             IF loc_nPrinters > 0 AND USED("cursor_4c_SigCdmp") AND RECCOUNT("cursor_4c_SigCdmp") > 0
1870:                 SELECT cursor_4c_SigCdmp
1871:                 GO TOP
1872:                 SCAN
1873:                     loc_nOk = ASCAN(loc_laPrinters, ALLTRIM(UPPER(cursor_4c_SigCdmp.Impres)))
1874:                     IF loc_nOk <> 0
1875:                         loc_nCnt = loc_nCnt + 1
1876:                         DIMENSION loc_laImpOk(loc_nCnt)
1877:                         loc_laImpOk(loc_nCnt) = loc_laPrinters(loc_nOk)
1878:                         loc_nImp = loc_nImp + 1
1879:                     ENDIF
1880:                 ENDSCAN
1881:             ENDIF
1882:             loc_nImp = loc_nImp - 1
1883:             IF USED("cursor_4c_SigCdmp")
1884:                 USE IN cursor_4c_SigCdmp
1885:             ENDIF

*-- Linhas 1976 a 2009:
1976:     *--------------------------------------------------------------------------
1977:     * Processamento - Constroi cursor Relacao e CsCabecalho para impressao
1978:     *   Modo Mala Direta (nm_operacao vazio): SigMlCab+SigCdCli via BO
1979:     *   Modo Operacao (cursor_4c_Operacoes): SELECT marcados com copias UNION ALL
1980:     *   Aplica optContatos, optProper e INDEX ON para ordenacao
1981:     *--------------------------------------------------------------------------
1982:     PROCEDURE Processamento()
1983:         LOCAL loc_lSucesso, loc_oPg1, loc_lModoOp, loc_nQtd, loc_nX
1984:         LOCAL loc_nOrdem, loc_nOrdemDir, loc_nContatos, loc_nProper, loc_cQuery
1985:         loc_lSucesso = .F.
1986:         TRY
1987:             THIS.FormParaRelatorio()
1988:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1989: 
1990:             *-- Cursor CsCabecalho: flags de impressao usados pelos arquivos LBX
1991:             IF USED("CsCabecalho")
1992:                 USE IN CsCabecalho
1993:             ENDIF
1994:             CREATE CURSOR CsCabecalho (llImpPais L, llImpCodigos L)
1995:             APPEND BLANK
1996:             REPLACE llImpPais WITH ;
1997:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptPais", 5) AND loc_oPg1.obj_4c_OptPais.Value = 1, .T., .F.) ;
1998:                 IN CsCabecalho
1999:             REPLACE llImpCodigos WITH ;
2000:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptCodigo", 5) AND loc_oPg1.obj_4c_OptCodigo.Value = 1, .T., .T.) ;
2001:                 IN CsCabecalho
2002: 
2003:             loc_nContatos = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptContatos", 5), loc_oPg1.obj_4c_OptContatos.Value, 2)
2004:             loc_nProper   = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptProper", 5),   loc_oPg1.obj_4c_OptProper.Value,   2)
2005:             loc_nOrdem    = IIF(PEMSTATUS(loc_oPg1, "obj_4c_Option", 5),      loc_oPg1.obj_4c_Option.Value,      2)
2006:             loc_nOrdemDir = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OpOrdem", 5),     loc_oPg1.obj_4c_OpOrdem.Value,     2)
2007:             loc_lModoOp   = PEMSTATUS(loc_oPg1, "txt_4c__nm_operacao", 5) AND ;
2008:                             !EMPTY(ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value))
2009: 

*-- Linhas 2019 a 2081:
2019:                         USE IN Relacao
2020:                     ENDIF
2021:                     IF loc_nQtd <= 1
2022:                         SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, ;
2023:                                Ceps, Estas, Tel1s, Tel2s, Faxs, Nascs, cIdChaves, ;
2024:                                Codigos, paises, Contato ;
2025:                                FROM cursor_4c_Operacoes WHERE Marcas = 1 ;
2026:                                INTO CURSOR Relacao READWRITE
2027:                     ELSE
2028:                         *-- Multiplas copias via UNION ALL (replica logica original com ExecScript)
2029:                         loc_cQuery = ""
2030:                         FOR loc_nX = 1 TO loc_nQtd
2031:                             IF !EMPTY(loc_cQuery)
2032:                                 loc_cQuery = loc_cQuery + CHR(13) + CHR(10) + ;
2033:                                              "UNION ALL" + CHR(13) + CHR(10)
2034:                             ENDIF
2035:                             loc_cQuery = loc_cQuery + ;
2036:                                 "SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas," + ;
2037:                                 " Ceps, Estas, Tel1s, Tel2s, Faxs, Nascs, cIdChaves," + ;
2038:                                 " Codigos, paises, Contato" + ;
2039:                                 " FROM cursor_4c_Operacoes n" + ALLTRIM(STR(loc_nX)) + ;
2040:                                 " WHERE Marcas = 1"
2041:                         ENDFOR
2042:                         loc_cQuery = loc_cQuery + " INTO CURSOR Relacao READWRITE"
2043:                         EXECSCRIPT(loc_cQuery)
2044:                     ENDIF
2045:                     loc_lSucesso = .T.
2046:                 ENDIF
2047:             ELSE
2048:                 IF THIS.this_oRelatorio.PrepararDadosMalaDireta()
2049:                     loc_lSucesso = .T.
2050:                 ELSE
2051:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao carregar dados")
2052:                 ENDIF
2053:             ENDIF
2054: 
2055:             IF loc_lSucesso
2056:                 *-- Substituir nome pelo contato se preenchido
2057:                 IF loc_nContatos = 1 AND USED("Relacao") AND RECCOUNT("Relacao") > 0
2058:                     REPLACE ALL RClis WITH IIF(EMPTY(Contato), RClis, Contato) IN Relacao
2059:                 ENDIF
2060:                 *-- Proper case nos nomes
2061:                 IF loc_nProper = 1 AND USED("Relacao") AND RECCOUNT("Relacao") > 0
2062:                     REPLACE ALL RClis WITH PROPER(RClis) IN Relacao
2063:                 ENDIF
2064:                 *-- Ordenacao por indice
2065:                 IF USED("Relacao") AND RECCOUNT("Relacao") > 0
2066:                     SELECT Relacao
2067:                     DO CASE
2068:                         CASE loc_nOrdem = 1  && Alfabetica
2069:                             IF loc_nOrdemDir = 2
2070:                                 INDEX ON RClis + IClis DESCENDING TAG RClis
2071:                             ELSE
2072:                                 INDEX ON RClis + IClis TAG RClis
2073:                             ENDIF
2074:                         CASE loc_nOrdem = 2  && CEP
2075:                             IF loc_nOrdemDir = 2
2076:                                 INDEX ON Ceps + IClis DESCENDING TAG Ceps
2077:                             ELSE
2078:                                 INDEX ON Ceps + IClis TAG Ceps
2079:                             ENDIF
2080:                         CASE loc_nOrdem = 3  && Data de Nascimento
2081:                             IF loc_nOrdemDir = 2

*-- Linhas 2142 a 2162:
2142:                     USE IN DbImpressao
2143:                 ENDIF
2144:                 IF USED("Relacao") AND RECCOUNT("Relacao") > 0
2145:                     SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, SPACE(10) AS Obs ;
2146:                         FROM Relacao INTO CURSOR DbImpressao READWRITE
2147:                     SELECT DbImpressao
2148:                     GO TOP
2149:                     REPLACE ALL Obs WITH IClis IN DbImpressao
2150: 
2151:                     loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2152:                     loc_lcNomeImp = ""
2153:                     IF PEMSTATUS(loc_oPg1, "obj_4c_Opt_Impressora", 5)
2154:                         loc_nImpres = loc_oPg1.obj_4c_Opt_Impressora.Value
2155:                         IF loc_nImpres >= 1
2156:                             loc_lcNomeImp = ALLTRIM(loc_oPg1.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
2157:                         ENDIF
2158:                     ENDIF
2159:                     TRY
2160:                         =SigOpEtq(.F., .F., .F., 96, THIS.this_nTpImp, THIS.this_nAjVerts, ;
2161:                                  THIS.this_nAjHorzs, THIS.this_nAjDenss, .F., .F., .F., ;
2162:                                  loc_lcNomeImp, , , THIS.this_nAjVelos, .F., .F.)


### BO (C:\4c\projeto\app\classes\sigreipeBO.prg):
*==============================================================================
* SIGREIPEBO.PRG
* Business Object para Impressao de Etiquetas
* Tabela principal: SigMlCab (mala direta) / SigMvCab (operacoes)
*
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreipeBO AS RelatorioBase

    *-- Propriedades padrao
    this_cTabela         = "SigMlCab"
    this_cCampoChave     = "cIdChaves"
    this_cCursorDados    = "Relacao"
    this_cMensagemErro   = ""

    *-- Filtro: selecao por codigo/descricao (tabela SigMlItn)
    this_cCodigos        = ""
    this_cDescs          = ""

    *-- Filtro: selecao por operacao de movimento
    this_cNmOperacao     = ""
    this_dDtInicial      = {}
    this_dDtFinal        = {}
    this_nConta          = 2

    *-- Configuracao do modelo de etiqueta
    *-- 1=3col DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
    this_nColunas        = 2
    this_nQtdEtiq        = 1

    *-- Configuracao da ordenacao
    *-- this_nOrdem: 1=Alfabetica, 2=CEP, 3=Data Nasc.
    *-- this_nOrdemDir: 1=Ascendente, 2=Descendente
    this_nOrdem          = 2
    this_nOrdemDir       = 2

    *-- Opcoes de conteudo das etiquetas
    *-- 1=Sim, 2=Nao em todos os grupos abaixo
    this_nImpPais        = 2
    this_nImpCodigo      = 1
    this_nImpMaius       = 2
    this_nImpContatos    = 2

    *-- Impressora selecionada (carregada no Form a partir de SigCdmp/SigSyImp)
    this_nImpressora     = 1
    this_cNomeImpressora = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMlCab"
        THIS.this_cCampoChave  = "cIdChaves"
        THIS.this_cCursorDados = "Relacao"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Despacha para modo mala direta ou modo operacao
    * Modo mala direta: this_cCodigos preenchido -> SigMlCab+SigCdCli
    * Modo operacao:    this_cNmOperacao preenchido -> TmpOper via SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(THIS.this_cNmOperacao)
                loc_lSucesso = THIS.PrepararDadosOperacao()
            ELSE
                loc_lSucesso = THIS.PrepararDadosMalaDireta()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosMalaDireta - Busca registros de SigMlCab filtrando por
    * codigo de itinerario (this_cCodigos) ou descricao (this_cDescs)
    * Replica logica do Init original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosMalaDireta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cOrder, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Iclis = b.Iclis"
            IF !EMPTY(THIS.this_cCodigos)
                loc_cWhere = loc_cWhere + " AND a.Codigos = " + EscaparSQL(THIS.this_cCodigos)
            ENDIF

            loc_cOrder = "a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                         " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                         " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                         " a.cIdChaves, a.Codigos, b.Contato"

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                       " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                       " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                       " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;
                       " FROM SigMlCab a, SigCdCli b" + ;
                       " WHERE " + loc_cWhere + ;
                       " ORDER BY " + loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados da mala direta"
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosMalaDireta")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosOperacao - Busca movimentos de SigMvCab filtrados por
    * operacao e periodo, populando cursor TmpOper com campos para etiqueta.
    * Replica logica do get_dt_final.Valid original.
    * this_nConta = 1 -> usa dados do cliente ORIGEM (ContaOs)
    * this_nConta = 2 -> usa dados do cliente DESTINO (ContaDs)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cEmps, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cEmps = go_4c_Sistema.cCodEmpresa
            loc_cWhere = "a.Dopes = " + EscaparSQL(THIS.this_cNmOperacao)
            IF !EMPTY(loc_cEmps)
                loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(loc_cEmps)
            ENDIF
            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + " AND a.DataNFs >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF
            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + " AND a.DataNFs <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            IF THIS.this_nConta = 1
                *-- Origem: usa dados de b (SigCdCli ContaOs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " b.IClis, b.RClis, b.Endes, b.Nums, b.Compls," + ;
                           " b.Bairs, b.Cidas, b.Ceps, b.Estas," + ;
                           " b.Tel1s, b.Tel2s, b.Faxs, b.Nascs," + ;
                           " b.cIdChaves, b.Codigos, b.paises, b.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ELSE
                *-- Destino: usa dados de c (SigCdCli ContaDs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " c.IClis, c.RClis, c.Endes, c.Nums, c.Compls," + ;
                           " c.Bairs, c.Cidas, c.Ceps, c.Estas," + ;
                           " c.Tel1s, c.Tel2s, c.Faxs, c.Nascs," + ;
                           " c.cIdChaves, c.Codigos, c.paises, c.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar operacoes"
                loc_lSucesso = .F.
            ENDIF

            *-- Replica cursor TmpOper para Relacao (formato unificado para impressao)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT TmpOper
            IF !EOF()
                SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, ;
                       Tel1s, Tel2s, Faxs, Nascs, cIdChaves, Codigos, paises, Contato ;
                       FROM TmpOper WHERE Marcas = 1 ;
                       INTO CURSOR (THIS.this_cCursorDados) READWRITE
            ELSE
                *-- Cursor vazio com estrutura correta
                CREATE CURSOR (THIS.this_cCursorDados) ;
                    (IClis C(15), RClis C(60), Endes C(60), Nums C(10), Compls C(20), ;
                     Bairs C(40), Cidas C(40), Ceps C(9), Estas C(2), ;
                     Tel1s C(20), Tel2s C(20), Faxs C(20), Nascs D, ;
                     cIdChaves C(36), Codigos C(10), paises C(20), Contato C(40))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosOperacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Transforma cursor Relacao em DbImpressao pronto
    * para LABEL FORM, adicionando colunas cpros/qtds/cbars e copiando Obs
    * Replica logica do metodo "processamento" original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                THIS.this_cMensagemErro = "Nenhum registro para imprimir"
                loc_lSucesso = .F.
            ENDIF

            IF USED("DbImpressao")
                USE IN DbImpressao
            ENDIF

            SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, ;
                   SPACE(60) AS Obs ;
                   FROM (THIS.this_cCursorDados) ;
                   INTO CURSOR DbImpressao READWRITE

            SELECT DbImpressao
            GO TOP
            REPLACE ALL Obs WITH IClis

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDbImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (cIdChaves) do cursor atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorDados) AND !EOF(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                loc_cChave = ALLTRIM(NVL(cIdChaves, ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cChave = ""
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("TmpOper")
            USE IN TmpOper
        ENDIF
        IF USED("DbImpressao")
            USE IN DbImpressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

