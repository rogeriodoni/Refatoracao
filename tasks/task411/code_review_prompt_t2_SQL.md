# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS

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
  ControlSource = "crSigCdFea.numes"
  ControlSource = "crSigCdFea.grupos"
  ControlSource = "crSigCdFea.contas"
  ControlSource = "crSigCdFea.datas"
  ControlSource = "crSigCdFea.brutos"
  ControlSource = "crSigCdFea.ifors"
  ControlSource = "crSigCdFea.tpmats"
  ControlSource = "crSigCdFea.pesoccbs"
  ControlSource = "crSigCdFea.pesoscbs"
  ControlSource = "crSigCdFea.Trabs"
  ControlSource = "crSigCdFea.falhas"
  ControlSource = "crSigCdFea.Produzidos"
lcQryFape = [Select * From SigCdFea Where Emps = '] + _Empr + [' And Tipos = '] + ThisForm.Tipo + [']
		Select TmpGccr
		lcQuery = [Select a.IClis, a.RClis ] + ;
					[From SigCdCli a, SigCdGcr b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpCli') < 1)
		Select TmpCli
				Select crSigCdFea
	Select crSigCdFea
    If Not Seek(This.Value, 'TmpGccr', 'Codigos')
	If Not Seek(This.Value, 'TmpCli', 'Iclis')
	Select TmpOpt
	If Not Seek(This.Value)
Select crSigCdFea
Select crSigCdFea

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFap.prg) - TRECHOS RELEVANTES PARA PASS SQL (2862 linhas total):

*-- Linhas 360 a 381:
360: 
361: 			*------------------------------------------------------------
362: 			*-- Cursor placeholder para vincular ao grid antes da primeira carga
363: 			*-- SET NULL ON: aceita NULLs do SQL Server no APPEND FROM
364: 			*------------------------------------------------------------
365: 			SET NULL ON
366: 			CREATE CURSOR cursor_4c_Dados ( ;
367: 				numes     N(10,0), ;
368: 				datas     D, ;
369: 				ifors     C(20), ;
370: 				grupos    C(10), ;
371: 				contas    C(20), ;
372: 				tpmats    C(10), ;
373: 				brutos    N(14,4), ;
374: 				trabs     N(14,4), ;
375: 				falhas    N(14,4), ;
376: 				produzidos N(14,4), ;
377: 				pesoccbs  N(14,4), ;
378: 				pesoscbs  N(14,4), ;
379: 				baixas    L, ;
380: 				cidchaves C(20), ;
381: 				emps      C(3), ;

*-- Linhas 406 a 482:
406: 				.HighlightBackColor = RGB(255, 255, 255)
407: 				.HighlightForeColor = RGB(15, 41, 104)
408: 				.HighlightStyle     = 2
409: 				.DeleteMark         = .F.
410: 				.RecordMark         = .F.
411: 				.RowHeight          = 16
412: 				.ScrollBars         = 2
413: 				.GridLines          = 3
414: 				.Visible            = .T.
415: 
416: 				.Column1.ControlSource   = "cursor_4c_Dados.numes"
417: 				.Column1.Width           = 55
418: 				.Column1.Header1.Caption = "N" + CHR(250) + "mero"
419: 				.Column1.Alignment       = 1
420: 
421: 				.Column2.ControlSource   = "cursor_4c_Dados.datas"
422: 				.Column2.Width           = 78
423: 				.Column2.Header1.Caption = "Data"
424: 				.Column2.Alignment       = 1
425: 
426: 				.Column3.ControlSource   = "cursor_4c_Dados.grupos"
427: 				.Column3.Width           = 65
428: 				.Column3.Header1.Caption = "Grupo"
429: 
430: 				.Column4.ControlSource   = "cursor_4c_Dados.contas"
431: 				.Column4.Width           = 75
432: 				.Column4.Header1.Caption = "Conta"
433: 
434: 				.Column5.ControlSource   = "cursor_4c_Dados.ifors"
435: 				.Column5.Width           = 100
436: 				.Column5.Header1.Caption = "Recuperadora"
437: 
438: 				.Column6.ControlSource   = "cursor_4c_Dados.tpmats"
439: 				.Column6.Width           = 68
440: 				.Column6.Header1.Caption = "Tp. Material"
441: 
442: 				.Column7.ControlSource   = "cursor_4c_Dados.brutos"
443: 				.Column7.Width           = 68
444: 				.Column7.Header1.Caption = "Bruto (g)"
445: 				.Column7.Alignment       = 1
446: 
447: 				.Column8.ControlSource   = "cursor_4c_Dados.trabs"
448: 				.Column8.Width           = 78
449: 				.Column8.Header1.Caption = "Trabalhado (g)"
450: 				.Column8.Alignment       = 1
451: 
452: 				.Column9.ControlSource   = "cursor_4c_Dados.falhas"
453: 				.Column9.Width           = 65
454: 				.Column9.Header1.Caption = "Falha (g)"
455: 				.Column9.Alignment       = 1
456: 
457: 				.Column10.ControlSource   = "cursor_4c_Dados.produzidos"
458: 				.Column10.Width           = 75
459: 				.Column10.Header1.Caption = "Produzido (g)"
460: 				.Column10.Alignment       = 1
461: 
462: 				.Column11.ControlSource   = "cursor_4c_Dados.pesoccbs"
463: 				.Column11.Width           = 72
464: 				.Column11.Header1.Caption = "Total C/Cob."
465: 				.Column11.Alignment       = 1
466: 
467: 				.Column12.ControlSource   = "cursor_4c_Dados.pesoscbs"
468: 				.Column12.Width           = 71
469: 				.Column12.Header1.Caption = "Total S/Cob."
470: 				.Column12.Alignment       = 1
471: 			ENDWITH
472: 
473: 			THIS.TornarControlesVisiveis(loc_oPagina)
474: 		CATCH TO loc_oErro
475: 			MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
476: 		ENDTRY
477: 	ENDPROC
478: 
479: 	*====================================================================
480: 	* ConfigurarPaginaDados - Monta Page2: area de campos + botoes acao
481: 	*====================================================================
482: 	PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 1116 a 1153:
1116: 				ELSE
1117: 					loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1118: 
1119: 					loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
1120: 						" a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
1121: 						" a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
1122: 						" a.emps, a.tipos, a.numbals" + ;
1123: 						" FROM SigCdFea a" + ;
1124: 						" WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1125: 						" AND a.tipos = " + EscaparSQL(THIS.this_cTipo) + ;
1126: 						" ORDER BY a.numes"
1127: 
1128: 					IF USED("cursor_4c_DadosTemp")
1129: 						USE IN cursor_4c_DadosTemp
1130: 					ENDIF
1131: 
1132: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1133: 
1134: 					IF loc_nResultado > 0
1135: 						SELECT cursor_4c_Dados
1136: 						SELECT cursor_4c_Dados
1137: 						ZAP
1138: 						APPEND FROM DBF("cursor_4c_DadosTemp")
1139: 						GO TOP IN cursor_4c_Dados
1140: 						USE IN cursor_4c_DadosTemp
1141: 						loc_oGrid.Refresh()
1142: 						THIS.FormatarGridLista(loc_oGrid)
1143: 						loc_lResultado = .T.
1144: 					ELSE
1145: 						MsgErro("Erro ao carregar lista: " + CapturarErroSQL(), "Erro SQL")
1146: 						IF USED("cursor_4c_DadosTemp")
1147: 							USE IN cursor_4c_DadosTemp
1148: 						ENDIF
1149: 						loc_lResultado = .F.
1150: 					ENDIF
1151: 				ENDIF
1152: 			ENDIF
1153: 		CATCH TO loc_oErro

*-- Linhas 1230 a 1248:
1230: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1231: 				MsgAviso("Selecione um registro para visualizar.", "Aviso")
1232: 			ELSE
1233: 				SELECT cursor_4c_Dados
1234: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1235: 
1236: 				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1237: 					THIS.this_cModoAtual = "VISUALIZAR"
1238: 					THIS.BOParaForm()
1239: 					THIS.HabilitarCampos(.F.)
1240: 					THIS.AjustarBotoesPorModo()
1241: 					THIS.AjustarPrdzReadOnly()
1242: 					THIS.pgf_4c_Paginas.ActivePage = 2
1243: 				ENDIF
1244: 			ENDIF
1245: 		CATCH TO loc_oErro
1246: 			MsgErro("Erro ao visualizar registro: " + loc_oErro.Message, "Erro")
1247: 		ENDTRY
1248: 	ENDPROC

*-- Linhas 1258 a 1276:
1258: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1259: 				MsgAviso("Selecione um registro para alterar.", "Aviso")
1260: 			ELSE
1261: 				SELECT cursor_4c_Dados
1262: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1263: 
1264: 				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1265: 					THIS.this_oBusinessObject.EditarRegistro()
1266: 					THIS.this_cModoAtual = "ALTERAR"
1267: 					THIS.BOParaForm()
1268: 					THIS.HabilitarCampos(.T.)
1269: 					THIS.AjustarBotoesPorModo()
1270: 					THIS.AjustarPrdzReadOnly()
1271: 					THIS.pgf_4c_Paginas.ActivePage = 2
1272: 				ENDIF
1273: 			ENDIF
1274: 		CATCH TO loc_oErro
1275: 			MsgErro("Erro ao iniciar altera" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
1276: 		ENDTRY

*-- Linhas 1288 a 1306:
1288: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1289: 				MsgAviso("Selecione um registro para excluir.", "Aviso")
1290: 			ELSE
1291: 				SELECT cursor_4c_Dados
1292: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1293: 
1294: 				IF !EMPTY(loc_cChave)
1295: 					loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
1296: 						"Excluir Registro")
1297: 
1298: 					IF loc_lConfirmado
1299: 						IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1300: 							IF THIS.this_oBusinessObject.Excluir()
1301: 								MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1302: 								THIS.CarregarLista()
1303: 							ENDIF
1304: 						ENDIF
1305: 					ENDIF
1306: 				ENDIF

*-- Linhas 1754 a 1772:
1754: 			IF !EMPTY(loc_cCodBusca)
1755: 				loc_nBusca = VAL(loc_cCodBusca)
1756: 				IF USED("cursor_4c_Dados") AND loc_nBusca > 0
1757: 					SELECT cursor_4c_Dados
1758: 					LOCATE FOR cursor_4c_Dados.numes = loc_nBusca
1759: 					IF !FOUND()
1760: 						MsgAviso("N" + CHR(250) + "mero " + loc_cCodBusca + " n" + ;
1761: 							CHR(227) + "o encontrado.", "Busca")
1762: 					ENDIF
1763: 				ENDIF
1764: 			ENDIF
1765: 
1766: 			THIS.AlternarPagina(1)
1767: 			RETURN
1768: 		ENDIF
1769: 
1770: 		*-- INCLUIR/ALTERAR: validacoes antes do TRY (critico: validacoes fora do TRY)
1771: 		IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1772: 			THIS.AlternarPagina(1)

*-- Linhas 1876 a 1900:
1876: 					IF USED("cursor_4c_BuscaGrupo")
1877: 						USE IN cursor_4c_BuscaGrupo
1878: 					ENDIF
1879: 					loc_nResult = SQLEXEC(gnConnHandle, ;
1880: 						"SELECT Codigos, Descrs FROM SigCdGcr" + ;
1881: 						" WHERE BalFalPers = 1 ORDER BY Codigos", ;
1882: 						"cursor_4c_BuscaGrupo")
1883: 
1884: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1885: 						SELECT cursor_4c_BuscaGrupo
1886: 						LOCATE FOR ALLTRIM(Codigos) = ALLTRIM(loc_cGrupo)
1887: 						IF FOUND()
1888: 							*-- Encontrou exato
1889: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1890: 								loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1891: 							ENDIF
1892: 							*-- Limpar conta pois grupo pode ter mudado
1893: 							IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1894: 								loc_oPagina.txt_4c_CdConta.Value = ""
1895: 							ENDIF
1896: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
1897: 								loc_oPagina.txt_4c_DsConta.Value = ""
1898: 							ENDIF
1899: 						ELSE
1900: 							*-- Nao encontrou: abrir picker

*-- Linhas 1907 a 1925:
1907: 								loc_oBusca.Show()
1908: 
1909: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1910: 									SELECT cursor_4c_BuscaGrupo
1911: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1912: 										loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1913: 									ENDIF
1914: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1915: 										loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1916: 									ENDIF
1917: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1918: 										loc_oPagina.txt_4c_CdConta.Value = ""
1919: 									ENDIF
1920: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
1921: 										loc_oPagina.txt_4c_DsConta.Value = ""
1922: 									ENDIF
1923: 								ELSE
1924: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1925: 										loc_oPagina.txt_4c_CdGrupo.Value = ""

*-- Linhas 1997 a 2041:
1997: 					IF USED("cursor_4c_BuscaConta")
1998: 						USE IN cursor_4c_BuscaConta
1999: 					ENDIF
2000: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2001: 						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
2002: 						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
2003: 						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
2004: 						" ORDER BY a.Rclis", ;
2005: 						"cursor_4c_BuscaConta")
2006: 
2007: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2008: 						SELECT cursor_4c_BuscaConta
2009: 						LOCATE FOR ALLTRIM(Iclis) = ALLTRIM(loc_cConta)
2010: 						IF FOUND()
2011: 							*-- Encontrou exato
2012: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2013: 								loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2014: 							ENDIF
2015: 						ELSE
2016: 							*-- Nao encontrou: abrir picker com contas do grupo
2017: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2018: 							IF VARTYPE(loc_oBusca) = "O"
2019: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2020: 								loc_oBusca.this_cTitulo = "Contas"
2021: 								loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2022: 								loc_oBusca.mAddColuna("Rclis", "", "Nome")
2023: 								loc_oBusca.Show()
2024: 
2025: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2026: 									SELECT cursor_4c_BuscaConta
2027: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2028: 										loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
2029: 									ENDIF
2030: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2031: 										loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2032: 									ENDIF
2033: 								ELSE
2034: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2035: 										loc_oPagina.txt_4c_CdConta.Value = ""
2036: 									ENDIF
2037: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2038: 										loc_oPagina.txt_4c_DsConta.Value = ""
2039: 									ENDIF
2040: 								ENDIF
2041: 								loc_oBusca.Release()

*-- Linhas 2094 a 2133:
2094: 					IF USED("cursor_4c_BuscaIfor")
2095: 						USE IN cursor_4c_BuscaIfor
2096: 					ENDIF
2097: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2098: 						"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2099: 						"cursor_4c_BuscaIfor")
2100: 
2101: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
2102: 						SELECT cursor_4c_BuscaIfor
2103: 						LOCATE FOR ALLTRIM(IClis) = ALLTRIM(loc_cIfor)
2104: 						IF FOUND()
2105: 							IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2106: 								loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2107: 							ENDIF
2108: 						ELSE
2109: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2110: 							IF VARTYPE(loc_oBusca) = "O"
2111: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
2112: 								loc_oBusca.this_cTitulo = "Recuperadoras"
2113: 								loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2114: 								loc_oBusca.mAddColuna("RClis", "", "Nome")
2115: 								loc_oBusca.Show()
2116: 
2117: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
2118: 									SELECT cursor_4c_BuscaIfor
2119: 									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2120: 										loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
2121: 									ENDIF
2122: 									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2123: 										loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2124: 									ENDIF
2125: 								ELSE
2126: 									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2127: 										loc_oCnt.txt_4c_ifor.Value = ""
2128: 									ENDIF
2129: 									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2130: 										loc_oCnt.txt_4c_dfor.Value = ""
2131: 									ENDIF
2132: 								ENDIF
2133: 								loc_oBusca.Release()

*-- Linhas 2189 a 2231:
2189: 						IF USED("cursor_4c_BuscaDfor")
2190: 							USE IN cursor_4c_BuscaDfor
2191: 						ENDIF
2192: 						loc_nResult = SQLEXEC(gnConnHandle, ;
2193: 							"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
2194: 							"cursor_4c_BuscaDfor")
2195: 
2196: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
2197: 							SELECT cursor_4c_BuscaDfor
2198: 							LOCATE FOR ALLTRIM(RClis) = ALLTRIM(loc_cDfor)
2199: 							IF FOUND()
2200: 								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2201: 									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2202: 								ENDIF
2203: 								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2204: 									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2205: 								ENDIF
2206: 							ELSE
2207: 								loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2208: 								IF VARTYPE(loc_oBusca) = "O"
2209: 									loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
2210: 									loc_oBusca.this_cTitulo = "Recuperadoras"
2211: 									loc_oBusca.mAddColuna("RClis", "", "Nome")
2212: 									loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2213: 									loc_oBusca.Show()
2214: 
2215: 									IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
2216: 										SELECT cursor_4c_BuscaDfor
2217: 										IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2218: 											loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2219: 										ENDIF
2220: 										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2221: 											loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2222: 										ENDIF
2223: 									ELSE
2224: 										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2225: 											loc_oCnt.txt_4c_dfor.Value = ""
2226: 										ENDIF
2227: 									ENDIF
2228: 									loc_oBusca.Release()
2229: 								ENDIF
2230: 							ENDIF
2231: 						ELSE

*-- Linhas 2272 a 2307:
2272: 					IF USED("cursor_4c_BuscaTpmat")
2273: 						USE IN cursor_4c_BuscaTpmat
2274: 					ENDIF
2275: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2276: 						"SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods", ;
2277: 						"cursor_4c_BuscaTpmat")
2278: 
2279: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
2280: 						SELECT cursor_4c_BuscaTpmat
2281: 						LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_cTpmat)
2282: 						IF !FOUND()
2283: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2284: 							IF VARTYPE(loc_oBusca) = "O"
2285: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
2286: 								loc_oBusca.this_cTitulo = "Tipo de Material"
2287: 								loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2288: 								loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2289: 								loc_oBusca.Show()
2290: 
2291: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
2292: 									SELECT cursor_4c_BuscaTpmat
2293: 									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2294: 										loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
2295: 									ENDIF
2296: 								ELSE
2297: 									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2298: 										loc_oCnt.txt_4c_tpmat.Value = ""
2299: 									ENDIF
2300: 								ENDIF
2301: 								loc_oBusca.Release()
2302: 							ENDIF
2303: 						ENDIF
2304: 					ELSE
2305: 						MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
2306: 						IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2307: 							loc_oCnt.txt_4c_tpmat.Value = ""

*-- Linhas 2466 a 2499:
2466: 				IF USED("cursor_4c_BuscaGrupo")
2467: 					USE IN cursor_4c_BuscaGrupo
2468: 				ENDIF
2469: 				loc_nResult = SQLEXEC(gnConnHandle, ;
2470: 					"SELECT Codigos, Descrs FROM SigCdGcr" + ;
2471: 					" WHERE BalFalPers = 1 ORDER BY Codigos", ;
2472: 					"cursor_4c_BuscaGrupo")
2473: 
2474: 				IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2475: 					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2476: 					IF VARTYPE(loc_oBusca) = "O"
2477: 						loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrupo"
2478: 						loc_oBusca.this_cTitulo = "Grupos"
2479: 						loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2480: 						loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2481: 						loc_oBusca.Show()
2482: 
2483: 						IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
2484: 							SELECT cursor_4c_BuscaGrupo
2485: 							IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
2486: 								loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
2487: 							ENDIF
2488: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
2489: 								loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
2490: 							ENDIF
2491: 							IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2492: 								loc_oPagina.txt_4c_CdConta.Value = ""
2493: 							ENDIF
2494: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2495: 								loc_oPagina.txt_4c_DsConta.Value = ""
2496: 							ENDIF
2497: 						ENDIF
2498: 						loc_oBusca.Release()
2499: 					ENDIF

*-- Linhas 2555 a 2590:
2555: 					IF USED("cursor_4c_BuscaConta")
2556: 						USE IN cursor_4c_BuscaConta
2557: 					ENDIF
2558: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2559: 						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
2560: 						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
2561: 						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
2562: 						" ORDER BY a.Rclis", ;
2563: 						"cursor_4c_BuscaConta")
2564: 
2565: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2566: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2567: 						IF VARTYPE(loc_oBusca) = "O"
2568: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2569: 							loc_oBusca.this_cTitulo = "Contas"
2570: 							loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2571: 							loc_oBusca.mAddColuna("Rclis", "", "Nome")
2572: 							loc_oBusca.Show()
2573: 
2574: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2575: 								SELECT cursor_4c_BuscaConta
2576: 								IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2577: 									loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
2578: 								ENDIF
2579: 								IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2580: 									loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2581: 								ENDIF
2582: 							ENDIF
2583: 							loc_oBusca.Release()
2584: 						ENDIF
2585: 					ELSE
2586: 						MsgAviso("Nenhuma conta encontrada para o grupo!", "Aviso")
2587: 					ENDIF
2588: 
2589: 					IF USED("cursor_4c_BuscaConta")
2590: 						USE IN cursor_4c_BuscaConta

*-- Linhas 2636 a 2668:
2636: 					IF USED("cursor_4c_BuscaIfor")
2637: 						USE IN cursor_4c_BuscaIfor
2638: 					ENDIF
2639: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2640: 						"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2641: 						"cursor_4c_BuscaIfor")
2642: 
2643: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
2644: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2645: 						IF VARTYPE(loc_oBusca) = "O"
2646: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
2647: 							loc_oBusca.this_cTitulo = "Recuperadoras"
2648: 							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2649: 							loc_oBusca.mAddColuna("RClis", "", "Nome")
2650: 							loc_oBusca.Show()
2651: 
2652: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
2653: 								SELECT cursor_4c_BuscaIfor
2654: 								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2655: 									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
2656: 								ENDIF
2657: 								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2658: 									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2659: 								ENDIF
2660: 							ENDIF
2661: 							loc_oBusca.Release()
2662: 						ENDIF
2663: 					ELSE
2664: 						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
2665: 					ENDIF
2666: 
2667: 					IF USED("cursor_4c_BuscaIfor")
2668: 						USE IN cursor_4c_BuscaIfor

*-- Linhas 2713 a 2745:
2713: 					IF USED("cursor_4c_BuscaTpmat")
2714: 						USE IN cursor_4c_BuscaTpmat
2715: 					ENDIF
2716: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2717: 						"SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods", ;
2718: 						"cursor_4c_BuscaTpmat")
2719: 
2720: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
2721: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2722: 						IF VARTYPE(loc_oBusca) = "O"
2723: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
2724: 							loc_oBusca.this_cTitulo = "Tipo de Material"
2725: 							loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2726: 							loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2727: 							loc_oBusca.Show()
2728: 
2729: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
2730: 								SELECT cursor_4c_BuscaTpmat
2731: 								IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2732: 									loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
2733: 								ENDIF
2734: 							ENDIF
2735: 							loc_oBusca.Release()
2736: 						ENDIF
2737: 					ELSE
2738: 						MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
2739: 					ENDIF
2740: 
2741: 					IF USED("cursor_4c_BuscaTpmat")
2742: 						USE IN cursor_4c_BuscaTpmat
2743: 					ENDIF
2744: 				ENDIF
2745: 			    ENDIF

*-- Linhas 2796 a 2828:
2796: 					IF USED("cursor_4c_BuscaDfor")
2797: 						USE IN cursor_4c_BuscaDfor
2798: 					ENDIF
2799: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2800: 						"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
2801: 						"cursor_4c_BuscaDfor")
2802: 
2803: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
2804: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2805: 						IF VARTYPE(loc_oBusca) = "O"
2806: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
2807: 							loc_oBusca.this_cTitulo = "Recuperadoras"
2808: 							loc_oBusca.mAddColuna("RClis", "", "Nome")
2809: 							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2810: 							loc_oBusca.Show()
2811: 
2812: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
2813: 								SELECT cursor_4c_BuscaDfor
2814: 								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2815: 									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2816: 								ENDIF
2817: 								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2818: 									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2819: 								ENDIF
2820: 							ENDIF
2821: 							loc_oBusca.Release()
2822: 						ENDIF
2823: 					ELSE
2824: 						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
2825: 					ENDIF
2826: 
2827: 					IF USED("cursor_4c_BuscaDfor")
2828: 						USE IN cursor_4c_BuscaDfor


### BO (C:\4c\projeto\app\classes\FapBO.prg):
*====================================================================
* FapBO.prg
*
* Business Object para Envio para Recuperacao
* Tabela: SigCdFea
* PK: cidchaves (char 20)
*====================================================================

DEFINE CLASS FapBO AS BusinessBase

	*-- Chave primaria (char 20, gerada via fGerUniqueKey no legado)
	this_cCidChaves = ""

	*-- Numero sequencial visivel ao usuario
	this_nNumes     = 0

	*-- Empresa
	this_cEmps      = ""

	*-- Tipo ('F' ou outro - recebido como parametro ao abrir o form)
	this_cTipos     = ""

	*-- Data do envio
	this_dDatas     = {}

	*-- Grupo de conta corrente (codigo + descricao de lookup)
	this_cGrupos    = ""
	this_cDsGrupos  = ""

	*-- Conta corrente (codigo + descricao de lookup)
	this_cContas    = ""
	this_cDsContas  = ""

	*-- Recuperadora - codigo e nome (SigCdCli.IClis / RClis)
	this_cIfors     = ""
	this_cDsIfors   = ""

	*-- Tipo de material (SigOpOpt.Cods)
	this_cTpmats    = ""

	*-- Pesos em gramas
	this_nBrutos    = 0     && Peso Bruto
	this_nTrabs     = 0     && Peso Trabalhado
	this_nFalhas    = 0     && Peso Falha
	this_nProduzidos= 0     && Produzido

	*-- Totais de material recuperado
	this_nPesoccbs  = 0     && Total Com Cobranca
	this_nPesoscbs  = 0     && Total Sem Cobranca

	*-- Flag de baixa (bit -> logical)
	this_lBaixas    = .F.

	*-- Numero do balancete relacionado
	this_nNumbals   = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela    = "SigCdFea"
			THIS.this_cCampoChave = "cidchaves"
			loc_lResultado = .T.
		CATCH TO loException
			MsgErro("Erro ao inicializar FapBO: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da PK para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT lista de registros (filtrado por empresa + tipo)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals" + ;
					   " FROM SigCdFea a" + ;
					   " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND a.tipos = " + EscaparSQL(THIS.this_cTipos)

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.numes"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado > 0
				GO TOP IN cursor_4c_Dados
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals," + ;
					   " ISNULL(b.Descrs, '') AS ds_grupos," + ;
					   " ISNULL(c.RClis, '') AS ds_contas," + ;
					   " ISNULL(d.RClis, '') AS ds_ifors" + ;
					   " FROM SigCdFea a" + ;
					   " LEFT JOIN SigCdGcr b ON b.Codigos = a.grupos" + ;
					   " LEFT JOIN SigCdCli c ON c.IClis = a.contas" + ;
					   " LEFT JOIN SigCdCli d ON d.IClis = a.ifors" + ;
					   " WHERE a.cidchaves = " + EscaparSQL(par_cCodigo)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
				THIS.this_nNumes      = TratarNulo(numes, "N")
				THIS.this_cEmps       = TratarNulo(emps, "C")
				THIS.this_cTipos      = TratarNulo(tipos, "C")
				THIS.this_dDatas      = TratarNulo(datas, "D")
				THIS.this_cGrupos     = TratarNulo(grupos, "C")
				THIS.this_cContas     = TratarNulo(contas, "C")
				THIS.this_cIfors      = TratarNulo(ifors, "C")
				THIS.this_cTpmats     = TratarNulo(tpmats, "C")
				THIS.this_nBrutos     = TratarNulo(brutos, "N")
				THIS.this_nTrabs      = TratarNulo(trabs, "N")
				THIS.this_nFalhas     = TratarNulo(falhas, "N")
				THIS.this_nProduzidos = TratarNulo(produzidos, "N")
				THIS.this_nPesoccbs   = TratarNulo(pesoccbs, "N")
				THIS.this_nPesoscbs   = TratarNulo(pesoscbs, "N")
				THIS.this_lBaixas     = (TratarNulo(baixas, "N") = 1)
				THIS.this_nNumbals    = TratarNulo(numbals, "N")

				*-- Descricoes (apenas disponiveis no cursor de CarregarPorCodigo com JOIN)
				TRY
					THIS.this_cDsGrupos = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_grupos"))
					THIS.this_cDsContas = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_contas"))
					THIS.this_cDsIfors  = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_ifors"))
				CATCH
					&& Cursor sem descricoes - normal para Buscar()
				ENDTRY

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_nNumes
		loc_lSucesso = .F.

		TRY
			*-- Gerar cidchaves unico (20 chars)
			loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)

			*-- Gerar proximo numes sequencial para empresa+tipo
			loc_nNumes = THIS.GerarProximoNumes()
			IF loc_nNumes <= 0
				MsgErro("Erro ao gerar n" + CHR(250) + "mero sequencial.", "Erro")
			ELSE
				THIS.this_cCidChaves = loc_cChave
				THIS.this_nNumes     = loc_nNumes
				THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa

				loc_cSQL = "INSERT INTO SigCdFea" + ;
						   " (cidchaves, numes, emps, tipos, datas," + ;
						   "  grupos, contas, ifors, tpmats," + ;
						   "  brutos, trabs, falhas, produzidos," + ;
						   "  pesoccbs, pesoscbs, baixas, numbals)" + ;
						   " VALUES (" + ;
						   EscaparSQL(THIS.this_cCidChaves) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
						   EscaparSQL(THIS.this_cEmps) + ", " + ;
						   EscaparSQL(THIS.this_cTipos) + ", " + ;
						   FormatarDataSQL(THIS.this_dDatas) + ", " + ;
						   EscaparSQL(THIS.this_cGrupos) + ", " + ;
						   EscaparSQL(THIS.this_cContas) + ", " + ;
						   EscaparSQL(THIS.this_cIfors) + ", " + ;
						   EscaparSQL(THIS.this_cTpmats) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
						   IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumbals) + ;
						   ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
				ENDIF

				IF USED("cursor_4c_Ins")
					USE IN cursor_4c_Ins
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFea SET" + ;
					   " datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
					   " grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
					   " contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
					   " ifors = " + EscaparSQL(THIS.this_cIfors) + ", " + ;
					   " tpmats = " + EscaparSQL(THIS.this_cTpmats) + ", " + ;
					   " brutos = " + FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
					   " trabs = " + FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
					   " falhas = " + FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
					   " produzidos = " + FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
					   " pesoccbs = " + FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
					   " pesoscbs = " + FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
					   " baixas = " + IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
					   " numbals = " + FormatarNumeroSQL(THIS.this_nNumbals) + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdFea" + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Del")
				USE IN cursor_4c_Del
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor de grupos disponiveis (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
					   " WHERE BalFalPers = 1 ORDER BY Codigos"

			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar grupos: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarGrupos: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor de contas para um grupo (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarContas(par_cGrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.IClis, a.RClis" + ;
					   " FROM SigCdCli a" + ;
					   " JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
					   " WHERE b.BalFalPers = 1"

			IF !EMPTY(par_cGrupo)
				loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(par_cGrupo)
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar contas: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarContas: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarTiposMaterial - Carrega cursor de tipos de material (Situas=3)
	*====================================================================
	PROCEDURE BuscarTiposMaterial()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods"

			IF USED("cursor_4c_TpMats")
				USE IN cursor_4c_TpMats
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpMats")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar tipos de material: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarTiposMaterial: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoNumes - Retorna proximo numero sequencial para empresa+tipo
	*====================================================================
	PROTECTED PROCEDURE GerarProximoNumes()
		LOCAL loc_cSQL, loc_nResultado, loc_nProximo
		loc_nProximo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(numes), 0) + 1 AS proximo" + ;
					   " FROM SigCdFea" + ;
					   " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND tipos = " + EscaparSQL(THIS.this_cTipos)

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Numes")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Numes") > 0
				SELECT cursor_4c_Numes
				loc_nProximo = proximo
			ELSE
				MsgErro("Erro ao gerar n" + CHR(250) + "mero: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF
		CATCH TO loException
			MsgErro("Erro em GerarProximoNumes: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_nProximo
	ENDPROC

ENDDEFINE

