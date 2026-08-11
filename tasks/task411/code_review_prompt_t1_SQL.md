# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (9)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SITUAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, TIPOS, GRUPOS, BALFALPERS

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFap.prg) - TRECHOS RELEVANTES PARA PASS SQL (2896 linhas total):

*-- Linhas 358 a 379:
358: 
359: 			*------------------------------------------------------------
360: 			*-- Cursor placeholder para vincular ao grid antes da primeira carga
361: 			*-- SET NULL ON: aceita NULLs do SQL Server no APPEND FROM
362: 			*------------------------------------------------------------
363: 			SET NULL ON
364: 			CREATE CURSOR cursor_4c_Dados ( ;
365: 				numes     N(10,0), ;
366: 				datas     D, ;
367: 				ifors     C(20), ;
368: 				grupos    C(10), ;
369: 				contas    C(20), ;
370: 				tpmats    C(10), ;
371: 				brutos    N(14,4), ;
372: 				trabs     N(14,4), ;
373: 				falhas    N(14,4), ;
374: 				produzidos N(14,4), ;
375: 				pesoccbs  N(14,4), ;
376: 				pesoscbs  N(14,4), ;
377: 				baixas    L, ;
378: 				cidchaves C(20), ;
379: 				emps      C(3), ;

*-- Linhas 404 a 480:
404: 				.HighlightBackColor = RGB(255, 255, 255)
405: 				.HighlightForeColor = RGB(15, 41, 104)
406: 				.HighlightStyle     = 2
407: 				.DeleteMark         = .F.
408: 				.RecordMark         = .F.
409: 				.RowHeight          = 16
410: 				.ScrollBars         = 2
411: 				.GridLines          = 3
412: 				.Visible            = .T.
413: 
414: 				.Column1.ControlSource   = "cursor_4c_Dados.numes"
415: 				.Column1.Width           = 55
416: 				.Column1.Header1.Caption = "N" + CHR(250) + "mero"
417: 				.Column1.Alignment       = 1
418: 
419: 				.Column2.ControlSource   = "cursor_4c_Dados.datas"
420: 				.Column2.Width           = 78
421: 				.Column2.Header1.Caption = "Data"
422: 				.Column2.Alignment       = 1
423: 
424: 				.Column3.ControlSource   = "cursor_4c_Dados.grupos"
425: 				.Column3.Width           = 65
426: 				.Column3.Header1.Caption = "Grupo"
427: 
428: 				.Column4.ControlSource   = "cursor_4c_Dados.contas"
429: 				.Column4.Width           = 75
430: 				.Column4.Header1.Caption = "Conta"
431: 
432: 				.Column5.ControlSource   = "cursor_4c_Dados.ifors"
433: 				.Column5.Width           = 100
434: 				.Column5.Header1.Caption = "Recuperadora"
435: 
436: 				.Column6.ControlSource   = "cursor_4c_Dados.tpmats"
437: 				.Column6.Width           = 68
438: 				.Column6.Header1.Caption = "Tp. Material"
439: 
440: 				.Column7.ControlSource   = "cursor_4c_Dados.brutos"
441: 				.Column7.Width           = 68
442: 				.Column7.Header1.Caption = "Bruto (g)"
443: 				.Column7.Alignment       = 1
444: 
445: 				.Column8.ControlSource   = "cursor_4c_Dados.trabs"
446: 				.Column8.Width           = 78
447: 				.Column8.Header1.Caption = "Trabalhado (g)"
448: 				.Column8.Alignment       = 1
449: 
450: 				.Column9.ControlSource   = "cursor_4c_Dados.falhas"
451: 				.Column9.Width           = 65
452: 				.Column9.Header1.Caption = "Falha (g)"
453: 				.Column9.Alignment       = 1
454: 
455: 				.Column10.ControlSource   = "cursor_4c_Dados.produzidos"
456: 				.Column10.Width           = 75
457: 				.Column10.Header1.Caption = "Produzido (g)"
458: 				.Column10.Alignment       = 1
459: 
460: 				.Column11.ControlSource   = "cursor_4c_Dados.pesoccbs"
461: 				.Column11.Width           = 72
462: 				.Column11.Header1.Caption = "Total C/Cob."
463: 				.Column11.Alignment       = 1
464: 
465: 				.Column12.ControlSource   = "cursor_4c_Dados.pesoscbs"
466: 				.Column12.Width           = 71
467: 				.Column12.Header1.Caption = "Total S/Cob."
468: 				.Column12.Alignment       = 1
469: 			ENDWITH
470: 
471: 			THIS.TornarControlesVisiveis(loc_oPagina)
472: 		CATCH TO loc_oErro
473: 			MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErro.Message, "Erro")
474: 		ENDTRY
475: 	ENDPROC
476: 
477: 	*====================================================================
478: 	* ConfigurarPaginaDados - Monta Page2: area de campos + botoes acao
479: 	*====================================================================
480: 	PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 1114 a 1151:
1114: 				ELSE
1115: 					loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1116: 
1117: 					loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
1118: 						" a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
1119: 						" a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
1120: 						" a.emps, a.tipos, a.numbals" + ;
1121: 						" FROM SigCdFea a" + ;
1122: 						" WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1123: 						" AND a.tipos = " + EscaparSQL(THIS.this_cTipo) + ;
1124: 						" ORDER BY a.numes"
1125: 
1126: 					IF USED("cursor_4c_DadosTemp")
1127: 						USE IN cursor_4c_DadosTemp
1128: 					ENDIF
1129: 
1130: 					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
1131: 
1132: 					IF loc_nResultado > 0
1133: 						SELECT cursor_4c_Dados
1134: 						SELECT cursor_4c_Dados
1135: 						ZAP
1136: 						APPEND FROM DBF("cursor_4c_DadosTemp")
1137: 						GO TOP IN cursor_4c_Dados
1138: 						USE IN cursor_4c_DadosTemp
1139: 						loc_oGrid.Refresh()
1140: 						THIS.FormatarGridLista(loc_oGrid)
1141: 						loc_lResultado = .T.
1142: 					ELSE
1143: 						MsgErro("Erro ao carregar lista: " + CapturarErroSQL(), "Erro SQL")
1144: 						IF USED("cursor_4c_DadosTemp")
1145: 							USE IN cursor_4c_DadosTemp
1146: 						ENDIF
1147: 						loc_lResultado = .F.
1148: 					ENDIF
1149: 				ENDIF
1150: 			ENDIF
1151: 		CATCH TO loc_oErro

*-- Linhas 1228 a 1246:
1228: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1229: 				MsgAviso("Selecione um registro para visualizar.", "Aviso")
1230: 			ELSE
1231: 				SELECT cursor_4c_Dados
1232: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1233: 
1234: 				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1235: 					THIS.this_cModoAtual = "VISUALIZAR"
1236: 					THIS.BOParaForm()
1237: 					THIS.HabilitarCampos(.F.)
1238: 					THIS.AjustarBotoesPorModo()
1239: 					THIS.AjustarPrdzReadOnly()
1240: 					THIS.pgf_4c_Paginas.ActivePage = 2
1241: 				ENDIF
1242: 			ENDIF
1243: 		CATCH TO loc_oErro
1244: 			MsgErro("Erro ao visualizar registro: " + loc_oErro.Message, "Erro")
1245: 		ENDTRY
1246: 	ENDPROC

*-- Linhas 1256 a 1274:
1256: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1257: 				MsgAviso("Selecione um registro para alterar.", "Aviso")
1258: 			ELSE
1259: 				SELECT cursor_4c_Dados
1260: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1261: 
1262: 				IF !EMPTY(loc_cChave) AND THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1263: 					THIS.this_oBusinessObject.EditarRegistro()
1264: 					THIS.this_cModoAtual = "ALTERAR"
1265: 					THIS.BOParaForm()
1266: 					THIS.HabilitarCampos(.T.)
1267: 					THIS.AjustarBotoesPorModo()
1268: 					THIS.AjustarPrdzReadOnly()
1269: 					THIS.pgf_4c_Paginas.ActivePage = 2
1270: 				ENDIF
1271: 			ENDIF
1272: 		CATCH TO loc_oErro
1273: 			MsgErro("Erro ao iniciar altera" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
1274: 		ENDTRY

*-- Linhas 1286 a 1304:
1286: 			IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1287: 				MsgAviso("Selecione um registro para excluir.", "Aviso")
1288: 			ELSE
1289: 				SELECT cursor_4c_Dados
1290: 				loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1291: 
1292: 				IF !EMPTY(loc_cChave)
1293: 					loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
1294: 						"Excluir Registro")
1295: 
1296: 					IF loc_lConfirmado
1297: 						IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1298: 							IF THIS.this_oBusinessObject.Excluir()
1299: 								MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1300: 								THIS.CarregarLista()
1301: 							ENDIF
1302: 						ENDIF
1303: 					ENDIF
1304: 				ENDIF

*-- Linhas 1752 a 1770:
1752: 			IF !EMPTY(loc_cCodBusca)
1753: 				loc_nBusca = VAL(loc_cCodBusca)
1754: 				IF USED("cursor_4c_Dados") AND loc_nBusca > 0
1755: 					SELECT cursor_4c_Dados
1756: 					LOCATE FOR cursor_4c_Dados.numes = loc_nBusca
1757: 					IF !FOUND()
1758: 						MsgAviso("N" + CHR(250) + "mero " + loc_cCodBusca + " n" + ;
1759: 							CHR(227) + "o encontrado.", "Busca")
1760: 					ENDIF
1761: 				ENDIF
1762: 			ENDIF
1763: 
1764: 			THIS.AlternarPagina(1)
1765: 			RETURN
1766: 		ENDIF
1767: 
1768: 		*-- INCLUIR/ALTERAR: validacoes antes do TRY (critico: validacoes fora do TRY)
1769: 		IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1770: 			THIS.AlternarPagina(1)

*-- Linhas 1874 a 1930:
1874: 					IF USED("cursor_4c_BuscaGrupo")
1875: 						USE IN cursor_4c_BuscaGrupo
1876: 					ENDIF
1877: 					loc_nResult = SQLEXEC(gnConnHandle, ;
1878: 						"SELECT Codigos, Descrs FROM SigCdGcr" + ;
1879: 						" WHERE BalFalPers = 1 AND Codigos = " + EscaparSQL(loc_cGrupo), ;
1880: 						"cursor_4c_BuscaGrupo")
1881: 
1882: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") = 1
1883: 						*-- Encontrou exato
1884: 						SELECT cursor_4c_BuscaGrupo
1885: 						IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1886: 							loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1887: 						ENDIF
1888: 						*-- Limpar conta pois grupo pode ter mudado
1889: 						IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1890: 							loc_oPagina.txt_4c_CdConta.Value = ""
1891: 						ENDIF
1892: 						IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
1893: 							loc_oPagina.txt_4c_DsConta.Value = ""
1894: 						ENDIF
1895: 					ELSE
1896: 						*-- Nao encontrou exato: carregar todos e abrir picker
1897: 						IF USED("cursor_4c_BuscaGrupo")
1898: 							USE IN cursor_4c_BuscaGrupo
1899: 						ENDIF
1900: 						loc_nResult = SQLEXEC(gnConnHandle, ;
1901: 							"SELECT Codigos, Descrs FROM SigCdGcr" + ;
1902: 							" WHERE BalFalPers = 1 ORDER BY Codigos", ;
1903: 							"cursor_4c_BuscaGrupo")
1904: 
1905: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1906: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1907: 							IF VARTYPE(loc_oBusca) = "O"
1908: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrupo"
1909: 								loc_oBusca.this_cTitulo = "Grupos"
1910: 								loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1911: 								loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1912: 								loc_oBusca.Show()
1913: 
1914: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1915: 									SELECT cursor_4c_BuscaGrupo
1916: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1917: 										loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1918: 									ENDIF
1919: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
1920: 										loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1921: 									ENDIF
1922: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
1923: 										loc_oPagina.txt_4c_CdConta.Value = ""
1924: 									ENDIF
1925: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
1926: 										loc_oPagina.txt_4c_DsConta.Value = ""
1927: 									ENDIF
1928: 								ELSE
1929: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
1930: 										loc_oPagina.txt_4c_CdGrupo.Value = ""

*-- Linhas 2002 a 2055:
2002: 					IF USED("cursor_4c_BuscaConta")
2003: 						USE IN cursor_4c_BuscaConta
2004: 					ENDIF
2005: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2006: 						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
2007: 						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
2008: 						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
2009: 						" AND a.Iclis = " + EscaparSQL(loc_cConta), ;
2010: 						"cursor_4c_BuscaConta")
2011: 
2012: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") = 1
2013: 						*-- Encontrou exato
2014: 						SELECT cursor_4c_BuscaConta
2015: 						IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2016: 							loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2017: 						ENDIF
2018: 					ELSE
2019: 						*-- Abrir picker com contas do grupo
2020: 						IF USED("cursor_4c_BuscaConta")
2021: 							USE IN cursor_4c_BuscaConta
2022: 						ENDIF
2023: 						loc_nResult = SQLEXEC(gnConnHandle, ;
2024: 							"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
2025: 							" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
2026: 							" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
2027: 							" ORDER BY a.Rclis", ;
2028: 							"cursor_4c_BuscaConta")
2029: 
2030: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2031: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2032: 							IF VARTYPE(loc_oBusca) = "O"
2033: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2034: 								loc_oBusca.this_cTitulo = "Contas"
2035: 								loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2036: 								loc_oBusca.mAddColuna("Rclis", "", "Nome")
2037: 								loc_oBusca.Show()
2038: 
2039: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2040: 									SELECT cursor_4c_BuscaConta
2041: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2042: 										loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
2043: 									ENDIF
2044: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2045: 										loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2046: 									ENDIF
2047: 								ELSE
2048: 									IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2049: 										loc_oPagina.txt_4c_CdConta.Value = ""
2050: 									ENDIF
2051: 									IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2052: 										loc_oPagina.txt_4c_DsConta.Value = ""
2053: 									ENDIF
2054: 								ENDIF
2055: 								loc_oBusca.Release()

*-- Linhas 2108 a 2154:
2108: 					IF USED("cursor_4c_BuscaIfor")
2109: 						USE IN cursor_4c_BuscaIfor
2110: 					ENDIF
2111: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2112: 						"SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
2113: 						EscaparSQL(loc_cIfor), ;
2114: 						"cursor_4c_BuscaIfor")
2115: 
2116: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") = 1
2117: 						SELECT cursor_4c_BuscaIfor
2118: 						IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2119: 							loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2120: 						ENDIF
2121: 					ELSE
2122: 						IF USED("cursor_4c_BuscaIfor")
2123: 							USE IN cursor_4c_BuscaIfor
2124: 						ENDIF
2125: 						loc_nResult = SQLEXEC(gnConnHandle, ;
2126: 							"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2127: 							"cursor_4c_BuscaIfor")
2128: 
2129: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
2130: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2131: 							IF VARTYPE(loc_oBusca) = "O"
2132: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
2133: 								loc_oBusca.this_cTitulo = "Recuperadoras"
2134: 								loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2135: 								loc_oBusca.mAddColuna("RClis", "", "Nome")
2136: 								loc_oBusca.Show()
2137: 
2138: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
2139: 									SELECT cursor_4c_BuscaIfor
2140: 									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2141: 										loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
2142: 									ENDIF
2143: 									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2144: 										loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2145: 									ENDIF
2146: 								ELSE
2147: 									IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2148: 										loc_oCnt.txt_4c_ifor.Value = ""
2149: 									ENDIF
2150: 									IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2151: 										loc_oCnt.txt_4c_dfor.Value = ""
2152: 									ENDIF
2153: 								ENDIF
2154: 								loc_oBusca.Release()

*-- Linhas 2210 a 2259:
2210: 						IF USED("cursor_4c_BuscaDfor")
2211: 							USE IN cursor_4c_BuscaDfor
2212: 						ENDIF
2213: 						loc_nResult = SQLEXEC(gnConnHandle, ;
2214: 							"SELECT IClis, RClis FROM SigCdCli" + ;
2215: 							" WHERE RClis = " + EscaparSQL(loc_cDfor), ;
2216: 							"cursor_4c_BuscaDfor")
2217: 
2218: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") = 1
2219: 							SELECT cursor_4c_BuscaDfor
2220: 							IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2221: 								loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2222: 							ENDIF
2223: 							IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2224: 								loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2225: 							ENDIF
2226: 						ELSE
2227: 							IF USED("cursor_4c_BuscaDfor")
2228: 								USE IN cursor_4c_BuscaDfor
2229: 							ENDIF
2230: 							loc_nResult = SQLEXEC(gnConnHandle, ;
2231: 								"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
2232: 								"cursor_4c_BuscaDfor")
2233: 
2234: 							IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
2235: 								loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2236: 								IF VARTYPE(loc_oBusca) = "O"
2237: 									loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
2238: 									loc_oBusca.this_cTitulo = "Recuperadoras"
2239: 									loc_oBusca.mAddColuna("RClis", "", "Nome")
2240: 									loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2241: 									loc_oBusca.Show()
2242: 
2243: 									IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
2244: 										SELECT cursor_4c_BuscaDfor
2245: 										IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2246: 											loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2247: 										ENDIF
2248: 										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2249: 											loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2250: 										ENDIF
2251: 									ELSE
2252: 										IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2253: 											loc_oCnt.txt_4c_dfor.Value = ""
2254: 										ENDIF
2255: 									ENDIF
2256: 									loc_oBusca.Release()
2257: 								ENDIF
2258: 							ELSE
2259: 								MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")

*-- Linhas 2300 a 2341:
2300: 					IF USED("cursor_4c_BuscaTpmat")
2301: 						USE IN cursor_4c_BuscaTpmat
2302: 					ENDIF
2303: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2304: 						"SELECT Cods, Descs FROM SigOpOpt WHERE Situas = 3 AND Cods = " + ;
2305: 						EscaparSQL(loc_cTpmat), ;
2306: 						"cursor_4c_BuscaTpmat")
2307: 
2308: 					IF loc_nResult <= 0 OR RECCOUNT("cursor_4c_BuscaTpmat") = 0
2309: 						IF USED("cursor_4c_BuscaTpmat")
2310: 							USE IN cursor_4c_BuscaTpmat
2311: 						ENDIF
2312: 						loc_nResult = SQLEXEC(gnConnHandle, ;
2313: 							"SELECT Cods, Descs FROM SigOpOpt WHERE Situas = 3 ORDER BY Cods", ;
2314: 							"cursor_4c_BuscaTpmat")
2315: 
2316: 						IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
2317: 							loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2318: 							IF VARTYPE(loc_oBusca) = "O"
2319: 								loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
2320: 								loc_oBusca.this_cTitulo = "Tipo de Material"
2321: 								loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2322: 								loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2323: 								loc_oBusca.Show()
2324: 
2325: 								IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
2326: 									SELECT cursor_4c_BuscaTpmat
2327: 									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2328: 										loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
2329: 									ENDIF
2330: 								ELSE
2331: 									IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2332: 										loc_oCnt.txt_4c_tpmat.Value = ""
2333: 									ENDIF
2334: 								ENDIF
2335: 								loc_oBusca.Release()
2336: 							ENDIF
2337: 						ELSE
2338: 							MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
2339: 							IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2340: 								loc_oCnt.txt_4c_tpmat.Value = ""
2341: 							ENDIF

*-- Linhas 2500 a 2533:
2500: 				IF USED("cursor_4c_BuscaGrupo")
2501: 					USE IN cursor_4c_BuscaGrupo
2502: 				ENDIF
2503: 				loc_nResult = SQLEXEC(gnConnHandle, ;
2504: 					"SELECT Codigos, Descrs FROM SigCdGcr" + ;
2505: 					" WHERE BalFalPers = 1 ORDER BY Codigos", ;
2506: 					"cursor_4c_BuscaGrupo")
2507: 
2508: 				IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
2509: 					loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2510: 					IF VARTYPE(loc_oBusca) = "O"
2511: 						loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaGrupo"
2512: 						loc_oBusca.this_cTitulo = "Grupos"
2513: 						loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2514: 						loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
2515: 						loc_oBusca.Show()
2516: 
2517: 						IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
2518: 							SELECT cursor_4c_BuscaGrupo
2519: 							IF PEMSTATUS(loc_oPagina, "txt_4c_CdGrupo", 5)
2520: 								loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
2521: 							ENDIF
2522: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsGrupo", 5)
2523: 								loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
2524: 							ENDIF
2525: 							IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2526: 								loc_oPagina.txt_4c_CdConta.Value = ""
2527: 							ENDIF
2528: 							IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2529: 								loc_oPagina.txt_4c_DsConta.Value = ""
2530: 							ENDIF
2531: 						ENDIF
2532: 						loc_oBusca.Release()
2533: 					ENDIF

*-- Linhas 2589 a 2624:
2589: 					IF USED("cursor_4c_BuscaConta")
2590: 						USE IN cursor_4c_BuscaConta
2591: 					ENDIF
2592: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2593: 						"SELECT a.Iclis, a.Rclis FROM SigCdCli a" + ;
2594: 						" INNER JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
2595: 						" WHERE b.BalFalPers = 1 AND a.Grupos = " + EscaparSQL(loc_cGrupo) + ;
2596: 						" ORDER BY a.Rclis", ;
2597: 						"cursor_4c_BuscaConta")
2598: 
2599: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
2600: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2601: 						IF VARTYPE(loc_oBusca) = "O"
2602: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
2603: 							loc_oBusca.this_cTitulo = "Contas"
2604: 							loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2605: 							loc_oBusca.mAddColuna("Rclis", "", "Nome")
2606: 							loc_oBusca.Show()
2607: 
2608: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
2609: 								SELECT cursor_4c_BuscaConta
2610: 								IF PEMSTATUS(loc_oPagina, "txt_4c_CdConta", 5)
2611: 									loc_oPagina.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
2612: 								ENDIF
2613: 								IF PEMSTATUS(loc_oPagina, "txt_4c_DsConta", 5)
2614: 									loc_oPagina.txt_4c_DsConta.Value = ALLTRIM(cursor_4c_BuscaConta.Rclis)
2615: 								ENDIF
2616: 							ENDIF
2617: 							loc_oBusca.Release()
2618: 						ENDIF
2619: 					ELSE
2620: 						MsgAviso("Nenhuma conta encontrada para o grupo!", "Aviso")
2621: 					ENDIF
2622: 
2623: 					IF USED("cursor_4c_BuscaConta")
2624: 						USE IN cursor_4c_BuscaConta

*-- Linhas 2670 a 2702:
2670: 					IF USED("cursor_4c_BuscaIfor")
2671: 						USE IN cursor_4c_BuscaIfor
2672: 					ENDIF
2673: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2674: 						"SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2675: 						"cursor_4c_BuscaIfor")
2676: 
2677: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaIfor") > 0
2678: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2679: 						IF VARTYPE(loc_oBusca) = "O"
2680: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaIfor"
2681: 							loc_oBusca.this_cTitulo = "Recuperadoras"
2682: 							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2683: 							loc_oBusca.mAddColuna("RClis", "", "Nome")
2684: 							loc_oBusca.Show()
2685: 
2686: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
2687: 								SELECT cursor_4c_BuscaIfor
2688: 								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2689: 									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaIfor.IClis)
2690: 								ENDIF
2691: 								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2692: 									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaIfor.RClis)
2693: 								ENDIF
2694: 							ENDIF
2695: 							loc_oBusca.Release()
2696: 						ENDIF
2697: 					ELSE
2698: 						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
2699: 					ENDIF
2700: 
2701: 					IF USED("cursor_4c_BuscaIfor")
2702: 						USE IN cursor_4c_BuscaIfor

*-- Linhas 2747 a 2779:
2747: 					IF USED("cursor_4c_BuscaTpmat")
2748: 						USE IN cursor_4c_BuscaTpmat
2749: 					ENDIF
2750: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2751: 						"SELECT Cods, Descs FROM SigOpOpt WHERE Situas = 3 ORDER BY Cods", ;
2752: 						"cursor_4c_BuscaTpmat")
2753: 
2754: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaTpmat") > 0
2755: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2756: 						IF VARTYPE(loc_oBusca) = "O"
2757: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpmat"
2758: 							loc_oBusca.this_cTitulo = "Tipo de Material"
2759: 							loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
2760: 							loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2761: 							loc_oBusca.Show()
2762: 
2763: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpmat")
2764: 								SELECT cursor_4c_BuscaTpmat
2765: 								IF PEMSTATUS(loc_oCnt, "txt_4c_tpmat", 5)
2766: 									loc_oCnt.txt_4c_tpmat.Value = ALLTRIM(cursor_4c_BuscaTpmat.Cods)
2767: 								ENDIF
2768: 							ENDIF
2769: 							loc_oBusca.Release()
2770: 						ENDIF
2771: 					ELSE
2772: 						MsgAviso("Nenhum tipo de material encontrado!", "Aviso")
2773: 					ENDIF
2774: 
2775: 					IF USED("cursor_4c_BuscaTpmat")
2776: 						USE IN cursor_4c_BuscaTpmat
2777: 					ENDIF
2778: 				ENDIF
2779: 			    ENDIF

*-- Linhas 2830 a 2862:
2830: 					IF USED("cursor_4c_BuscaDfor")
2831: 						USE IN cursor_4c_BuscaDfor
2832: 					ENDIF
2833: 					loc_nResult = SQLEXEC(gnConnHandle, ;
2834: 						"SELECT IClis, RClis FROM SigCdCli ORDER BY RClis", ;
2835: 						"cursor_4c_BuscaDfor")
2836: 
2837: 					IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaDfor") > 0
2838: 						loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2839: 						IF VARTYPE(loc_oBusca) = "O"
2840: 							loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDfor"
2841: 							loc_oBusca.this_cTitulo = "Recuperadoras"
2842: 							loc_oBusca.mAddColuna("RClis", "", "Nome")
2843: 							loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
2844: 							loc_oBusca.Show()
2845: 
2846: 							IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDfor")
2847: 								SELECT cursor_4c_BuscaDfor
2848: 								IF PEMSTATUS(loc_oCnt, "txt_4c_ifor", 5)
2849: 									loc_oCnt.txt_4c_ifor.Value = ALLTRIM(cursor_4c_BuscaDfor.IClis)
2850: 								ENDIF
2851: 								IF PEMSTATUS(loc_oCnt, "txt_4c_dfor", 5)
2852: 									loc_oCnt.txt_4c_dfor.Value = ALLTRIM(cursor_4c_BuscaDfor.RClis)
2853: 								ENDIF
2854: 							ENDIF
2855: 							loc_oBusca.Release()
2856: 						ENDIF
2857: 					ELSE
2858: 						MsgAviso("Nenhuma recuperadora encontrada!", "Aviso")
2859: 					ENDIF
2860: 
2861: 					IF USED("cursor_4c_BuscaDfor")
2862: 						USE IN cursor_4c_BuscaDfor


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
			loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt" + ;
					   " WHERE Situas = 3 ORDER BY Cods"

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

