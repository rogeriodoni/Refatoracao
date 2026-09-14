# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BALANCOS, SUBTOT100S, DESCGRPS, TITULOS, CODIGOS, CLASSES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BALANCOS, SUBTOT100S, DESCGRPS, TITULOS, CODIGOS, CLASSES

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
  ControlSource = "crSigCdMri.classes"
  ControlSource = "crSigCdMri.descgrps"
  ControlSource = ""
  ControlSource = "crSigCdMri.grupos"
  ControlSource = "crSigCdMri.TpDatas"
  ControlSource = "crSigCdMri.analiticos"
  ControlSource = "crSigCdMri.tpregs"
  ControlSource = "crSigCdMri.fators"
  ControlSource = "crSigCdMri.Titulos"
  ControlSource = "crSigCdMri.cpartidas"
  ControlSource = "crSigCdMri.ordems"
  ControlSource = "crSigCdMri.subtot100s"
Select crSigCdMri
		.AddCursor('SigCdMri','CidChaves','crSigCdMri','Classes',ThisForm.pagina.lista.grade,[Select * From SigCdMri Where Balancos = ?crSigCdMrr.Balancos order by Ordems, Classes])
Select crSigCdMri
ThisForm.Pagina.Lista.Grade.Column1.ControlSource=[Iif(EMPTY(crSigCdMri.grupos),crSigCdMri.classes,"")]
ThisForm.Pagina.Lista.Grade.Column3.ControlSource="iif(crSigCdMri.operacaos='-','[-]','[+]')"
ThisForm.Pagina.Lista.Grade.Column5.ControlSource=[iif(crSigCdMri.analiticos=1,'A','S')]
Select Count(*) as QTD from crSigCdMri a where a.SubTot100s = 1 and a.DescGrps <> crSigCdMri.DescGrps into cursor crAux
	lcQuery = [Select Ordems ] + ;
			    [From SigCdMri ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csChecagem') < 1)
SELECT crSigCdMri
	SELECT crSigCdMri
		SELECT crSigCdMri
	Select crSigCdMri
		SELECT crSigCdMri
	Select crSigCdMri
	   SELECT crSigCdMri  
	Select crSigCdMri
Select crSigCdMri
	SELECT crSigCdCss
		SELECT crSigCdCss
SELECT crSigCdMrr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2484 linhas total):

*-- Linhas 367 a 385:
367:             .HighlightBackColor = RGB(255, 255, 255)
368:             .HighlightForeColor = RGB(15, 41, 104)
369:             .HighlightStyle     = 2
370:             .DeleteMark         = .F.
371:             .RecordMark         = .F.
372:             .ScrollBars         = 2
373:             .GridLines          = 3
374:             .ReadOnly           = .T.
375:             .Visible            = .T.
376: 
377:             .Column1.Width          = 80
378:             .Column1.Alignment      = 0
379:             .Column1.Header1.Caption = "Classe"
380: 
381:             .Column2.Width          = 33
382:             .Column2.Alignment      = 1
383:             .Column2.Header1.Caption = "N" + CHR(237) + "vel"
384: 
385:             .Column3.Width          = 40

*-- Linhas 1129 a 1198:
1129:                     loc_oGrid.ColumnCount = 9
1130:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1131: 
1132:                     *-- Re-definir ControlSource e Headers APOS RecordSource
1133:                     WITH loc_oGrid
1134:                         *-- Column1: Classe (mostra Classes se Grupos vazio, senao branco)
1135:                         .Column1.ControlSource  = "iif(EMPTY(cursor_4c_Dados.Grupos),cursor_4c_Dados.Classes,'')"
1136:                         .Column1.Header1.Caption = "Classe"
1137:                         .Column1.Width  = 80
1138:                         .Column1.Alignment = 0
1139: 
1140:                         *-- Column2: Nivel
1141:                         .Column2.ControlSource  = "cursor_4c_Dados.Nivels"
1142:                         .Column2.Header1.Caption = "N" + CHR(237) + "vel"
1143:                         .Column2.Width  = 33
1144:                         .Column2.Alignment = 1
1145: 
1146:                         *-- Column3: Operacao (+/-) com indicador visual
1147:                         .Column3.ControlSource  = "iif(cursor_4c_Dados.Operacaos='-','[-]','[+]')"
1148:                         .Column3.Header1.Caption = "Oper"
1149:                         .Column3.Width  = 40
1150:                         .Column3.Alignment = 1
1151: 
1152:                         *-- Column4: Grupo
1153:                         .Column4.ControlSource  = "cursor_4c_Dados.Grupos"
1154:                         .Column4.Header1.Caption = "Grupo"
1155:                         .Column4.Width  = 80
1156:                         .Column4.Alignment = 0
1157: 
1158:                         *-- Column5: Analitico/Sintetico
1159:                         .Column5.ControlSource  = "iif(cursor_4c_Dados.Analiticos=1,'A','S')"
1160:                         .Column5.Header1.Caption = "A/S"
1161:                         .Column5.Width  = 30
1162:                         .Column5.Alignment = 1
1163: 
1164:                         *-- Column6: Descricao SubTotal
1165:                         .Column6.ControlSource  = "cursor_4c_Dados.DescGrps"
1166:                         .Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1167:                         .Column6.Width  = 220
1168:                         .Column6.Alignment = 0
1169: 
1170:                         *-- Column7: Fator %
1171:                         .Column7.ControlSource  = "cursor_4c_Dados.Fators"
1172:                         .Column7.Header1.Caption = "Fator"
1173:                         .Column7.Width  = 40
1174:                         .Column7.Alignment = 1
1175: 
1176:                         *-- Column8: Titulo de coluna
1177:                         .Column8.ControlSource  = "cursor_4c_Dados.Titulos"
1178:                         .Column8.Header1.Caption = "T" + CHR(237) + "tulo"
1179:                         .Column8.Width  = 80
1180:                         .Column8.Alignment = 0
1181: 
1182:                         *-- Column9: Ordem
1183:                         .Column9.ControlSource  = "cursor_4c_Dados.Ordems"
1184:                         .Column9.Header1.Caption = "Ordem"
1185:                         .Column9.Width  = 50
1186:                         .Column9.Alignment = 1
1187:                     ENDWITH
1188: 
1189:                     THIS.FormatarGridLista(loc_oGrid)
1190:                     loc_oGrid.Refresh()
1191:                     loc_lResultado = .T.
1192:                 ENDIF
1193:             ENDIF
1194:         CATCH TO loException
1195:             MsgErro("Erro ao carregar lista: " + loException.Message, "Erro")
1196:             loc_lResultado = .F.
1197:         ENDTRY
1198: 

*-- Linhas 1349 a 1389:
1349:         *-- Popular descricao do Grupo (get_ds_grupos) via SQL
1350:         IF NOT EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
1351:             TRY
1352:                 loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
1353:                            EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos))
1354:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDesc")
1355:                 IF loc_nResult >= 0 AND USED("cursor_4c_GcrDesc") AND RECCOUNT("cursor_4c_GcrDesc") > 0
1356:                     loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrDesc.Descrs)
1357:                 ENDIF
1358:                 IF USED("cursor_4c_GcrDesc")
1359:                     USE IN cursor_4c_GcrDesc
1360:                 ENDIF
1361:             CATCH TO loException
1362:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
1363:                         loException.Message, "Erro")
1364:             ENDTRY
1365:         ELSE
1366:             loc_oPg2.txt_4c__ds_grupos.Value = ""
1367:         ENDIF
1368: 
1369:         *-- Popular descricao da Classe (txt_4c_Dclasse) via SQL
1370:         IF NOT EMPTY(ALLTRIM(loc_oBO.this_cClasses))
1371:             TRY
1372:                 loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdCss WHERE Classes = " + ;
1373:                            EscaparSQL(ALLTRIM(loc_oBO.this_cClasses))
1374:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssDesc")
1375:                 IF loc_nResult >= 0 AND USED("cursor_4c_CssDesc") AND RECCOUNT("cursor_4c_CssDesc") > 0
1376:                     loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssDesc.Descrs)
1377:                 ENDIF
1378:                 IF USED("cursor_4c_CssDesc")
1379:                     USE IN cursor_4c_CssDesc
1380:                 ENDIF
1381:             CATCH TO loException
1382:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da classe: " + ;
1383:                         loException.Message, "Erro")
1384:             ENDTRY
1385:         ELSE
1386:             loc_oPg2.txt_4c_Dclasse.Value = ""
1387:         ENDIF
1388: 
1389:         THIS.OptTpregsChanged()

*-- Linhas 1454 a 1474:
1454:         ENDIF
1455: 
1456:         TRY
1457:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1458:                        EscaparSQL(loc_cGrupo)
1459:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1460:             IF loc_nResult >= 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1461:                 loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrVal.Descrs)
1462:             ELSE
1463:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1464:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1465:                     "Grupos de Conta Corrente")
1466: 
1467:                 IF VARTYPE(loc_oBusca) = "O"
1468:                     IF NOT loc_oBusca.this_lAchouRegistro
1469:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1470:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1471:                         loc_oBusca.Show()
1472:                     ENDIF
1473: 
1474:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")

*-- Linhas 1569 a 1589:
1569:         ENDIF
1570: 
1571:         TRY
1572:             loc_cSQL = "SELECT TOP 1 Classes, Descrs FROM SigCdCss WHERE Classes = " + ;
1573:                        EscaparSQL(loc_cClasse)
1574:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVal")
1575:             IF loc_nResult >= 0 AND USED("cursor_4c_CssVal") AND RECCOUNT("cursor_4c_CssVal") > 0
1576:                 loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssVal.Descrs)
1577:             ELSE
1578:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1579:                     "SigCdCss", "cursor_4c_BuscaClasse", "Classes", loc_cClasse, ;
1580:                     "Classes Cont" + CHR(225) + "beis")
1581: 
1582:                 IF VARTYPE(loc_oBusca) = "O"
1583:                     IF NOT loc_oBusca.this_lAchouRegistro
1584:                         loc_oBusca.mAddColuna("Classes", "", "Classe")
1585:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1586:                         loc_oBusca.Show()
1587:                     ENDIF
1588: 
1589:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")

*-- Linhas 1901 a 1923:
1901:         ENDIF
1902: 
1903:         TRY
1904:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1905:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1906:                        " AND Titulos = " + EscaparSQL(loc_cTitulo) + ;
1907:                        " AND CidChaves <> " + EscaparSQL(THIS.this_oBusinessObject.this_cCidChaves)
1908:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
1909:             IF loc_nResult >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
1910:                 IF cursor_4c_DupTit.QTD > 0
1911:                     IF USED("cursor_4c_DupTit")
1912:                         USE IN cursor_4c_DupTit
1913:                     ENDIF
1914:                     MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
1915:                     loc_oPg2.txt_4c_Titulo.SetFocus()
1916:                     loc_lResultado = .F.
1917:                 ENDIF
1918:             ENDIF
1919:             IF USED("cursor_4c_DupTit")
1920:                 USE IN cursor_4c_DupTit
1921:             ENDIF
1922:         CATCH TO loc_oErro
1923:             IF USED("cursor_4c_DupTit")

*-- Linhas 1939 a 1959:
1939:         loc_nOrdem = 1
1940: 
1941:         TRY
1942:             loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
1943:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
1944:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
1945:             IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
1946:                 IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
1947:                     loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
1948:                 ENDIF
1949:             ENDIF
1950:             IF USED("cursor_4c_ProxOrdem")
1951:                 USE IN cursor_4c_ProxOrdem
1952:             ENDIF
1953:         CATCH TO loException
1954:             MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")
1955:         ENDTRY
1956: 
1957:         RETURN loc_nOrdem
1958:     ENDFUNC
1959: 

*-- Linhas 1966 a 1992:
1966:         loc_lResultado = .T.
1967: 
1968:         TRY
1969:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1970:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1971:                        " AND Subtot100s = 1"
1972: 
1973:             IF NOT EMPTY(ALLTRIM(par_cDescGrpsAtual))
1974:                 loc_cSQL = loc_cSQL + " AND DescGrps <> " + EscaparSQL(ALLTRIM(par_cDescGrpsAtual))
1975:             ENDIF
1976: 
1977:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltSubtot")
1978:             IF loc_nResult >= 0 AND USED("cursor_4c_AltSubtot") AND RECCOUNT("cursor_4c_AltSubtot") > 0
1979:                 loc_nQtd = cursor_4c_AltSubtot.QTD
1980:                 loc_lResultado = (loc_nQtd <= 0)
1981:             ENDIF
1982:             IF USED("cursor_4c_AltSubtot")
1983:                 USE IN cursor_4c_AltSubtot
1984:             ENDIF
1985:         CATCH TO loException
1986:             MsgErro("Erro ao verificar subtotal: " + loException.Message, "Erro")
1987:         ENDTRY
1988: 
1989:         RETURN loc_lResultado
1990:     ENDFUNC
1991: 
1992:     *==========================================================================

*-- Linhas 2023 a 2045:
2023: 
2024:             loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
2025:             TRY
2026:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2027:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2028:                            " AND Titulos = " + EscaparSQL(loc_cTituloVal) + ;
2029:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2030:                 loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
2031:                 IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
2032:                     IF cursor_4c_DupTit.QTD > 0
2033:                         IF USED("cursor_4c_DupTit")
2034:                             USE IN cursor_4c_DupTit
2035:                         ENDIF
2036:                         MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
2037:                         loc_oPg2.txt_4c_Titulo.SetFocus()
2038:                         loc_lResultado = .F.
2039:                     ENDIF
2040:                 ENDIF
2041:                 IF USED("cursor_4c_DupTit")
2042:                     USE IN cursor_4c_DupTit
2043:                 ENDIF
2044:             CATCH TO loException
2045:                 IF USED("cursor_4c_DupTit")

*-- Linhas 2063 a 2083:
2063:             ENDIF
2064: 
2065:             TRY
2066:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
2067:                            EscaparSQL(loc_cGrupos)
2068:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
2069:                 IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
2070:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
2071:                     loc_oBO.this_cClasses  = loc_cGrupos
2072:                     IF USED("cursor_4c_VGcr")
2073:                         USE IN cursor_4c_VGcr
2074:                     ENDIF
2075:                 ELSE
2076:                     IF USED("cursor_4c_VGcr")
2077:                         USE IN cursor_4c_VGcr
2078:                     ENDIF
2079:                     MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2080:                     loc_oPg2.txt_4c__cd_grupos.SetFocus()
2081:                     loc_lResultado = .F.
2082:                 ENDIF
2083:             CATCH TO loException

*-- Linhas 2093 a 2115:
2093:             ENDIF
2094: 
2095:             TRY
2096:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2097:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2098:                            " AND Grupos = " + EscaparSQL(loc_cGrupos) + ;
2099:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2100:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupGrp")
2101:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupGrp") AND RECCOUNT("cursor_4c_DupGrp") > 0
2102:                     IF cursor_4c_DupGrp.QTD > 0
2103:                         IF USED("cursor_4c_DupGrp")
2104:                             USE IN cursor_4c_DupGrp
2105:                         ENDIF
2106:                         MsgAviso("Grupo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
2107:                         loc_oPg2.txt_4c__cd_grupos.SetFocus()
2108:                         loc_lResultado = .F.
2109:                     ENDIF
2110:                 ENDIF
2111:                 IF USED("cursor_4c_DupGrp")
2112:                     USE IN cursor_4c_DupGrp
2113:                 ENDIF
2114:             CATCH TO loException
2115:                 MsgErro("Erro ao verificar duplicidade: " + loException.Message, "Erro")

*-- Linhas 2130 a 2150:
2130:             ENDIF
2131: 
2132:             TRY
2133:                 loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
2134:                            EscaparSQL(loc_cClasses)
2135:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
2136:                 IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
2137:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
2138:                     loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
2139:                     IF USED("cursor_4c_VCss")
2140:                         USE IN cursor_4c_VCss
2141:                     ENDIF
2142:                 ELSE
2143:                     IF USED("cursor_4c_VCss")
2144:                         USE IN cursor_4c_VCss
2145:                     ENDIF
2146:                     MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2147:                     loc_oPg2.txt_4c_Classe.SetFocus()
2148:                     loc_lResultado = .F.
2149:                 ENDIF
2150:             CATCH TO loException

*-- Linhas 2160 a 2182:
2160:             ENDIF
2161: 
2162:             TRY
2163:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2164:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2165:                            " AND Classes = " + EscaparSQL(loc_cClasses) + ;
2166:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2167:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
2168:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
2169:                     IF cursor_4c_DupCls.QTD > 0
2170:                         IF USED("cursor_4c_DupCls")
2171:                             USE IN cursor_4c_DupCls
2172:                         ENDIF
2173:                         MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
2174:                         loc_oPg2.txt_4c_Classe.SetFocus()
2175:                         loc_lResultado = .F.
2176:                     ENDIF
2177:                 ENDIF
2178:                 IF USED("cursor_4c_DupCls")
2179:                     USE IN cursor_4c_DupCls
2180:                 ENDIF
2181:             CATCH TO loException
2182:                 MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")

*-- Linhas 2206 a 2228:
2206:             loc_oBO.this_cClasses = "6"
2207: 
2208:             TRY
2209:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2210:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2211:                            " AND DescGrps = " + EscaparSQL(loc_cDescGrps) + ;
2212:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2213:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
2214:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
2215:                     IF cursor_4c_DupSub.QTD > 0
2216:                         IF USED("cursor_4c_DupSub")
2217:                             USE IN cursor_4c_DupSub
2218:                         ENDIF
2219:                         MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
2220:                         loc_oPg2.txt_4c_Descgrps.SetFocus()
2221:                         loc_lResultado = .F.
2222:                     ENDIF
2223:                 ENDIF
2224:                 IF USED("cursor_4c_DupSub")
2225:                     USE IN cursor_4c_DupSub
2226:                 ENDIF
2227:             CATCH TO loException
2228:                 MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")

*-- Linhas 2261 a 2281:
2261:         *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
2262:         IF loc_nTpregs = 1
2263:             TRY
2264:                 loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
2265:                            EscaparSQL(loc_oBO.this_cClasses)
2266:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
2267:                 IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
2268:                     loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
2269:                 ELSE
2270:                     loc_oBO.this_nNivels = 0
2271:                 ENDIF
2272:                 IF USED("cursor_4c_NivGrp")
2273:                     USE IN cursor_4c_NivGrp
2274:                 ENDIF
2275:             CATCH TO loException
2276:                 MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
2277:             ENDTRY
2278:         ENDIF
2279: 
2280:         RETURN .T.
2281:     ENDFUNC

*-- Linhas 2309 a 2350:
2309:         loc_cCidChaves = ""
2310: 
2311:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2312:             SELECT cursor_4c_Dados
2313:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2314:         ENDIF
2315: 
2316:         IF EMPTY(loc_cCidChaves)
2317:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
2318:             RETURN
2319:         ENDIF
2320: 
2321:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2322:             THIS.this_cCidChavesAtual = loc_cCidChaves
2323:             THIS.this_cModoAtual      = "VISUALIZAR"
2324:             THIS.BOParaForm()
2325:             THIS.HabilitarCampos(.F.)
2326:             THIS.AlternarPagina(2)
2327:         ENDIF
2328:     ENDPROC
2329: 
2330:     PROCEDURE BtnAlterarClick()
2331:         LOCAL loc_cCidChaves, loc_cDescGrpsAtual
2332:         loc_cCidChaves = ""
2333: 
2334:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2335:             SELECT cursor_4c_Dados
2336:             loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
2337:             loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
2338:         ENDIF
2339: 
2340:         IF EMPTY(loc_cCidChaves)
2341:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
2342:             RETURN
2343:         ENDIF
2344: 
2345:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2346:             THIS.this_cCidChavesAtual = loc_cCidChaves
2347:             THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
2348:             THIS.this_oBusinessObject.EditarRegistro()
2349:             THIS.this_cModoAtual = "ALTERAR"
2350:             THIS.BOParaForm()

*-- Linhas 2358 a 2376:
2358:         loc_cCidChaves = ""
2359: 
2360:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2361:             SELECT cursor_4c_Dados
2362:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2363:         ENDIF
2364: 
2365:         IF EMPTY(loc_cCidChaves)
2366:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2367:             RETURN
2368:         ENDIF
2369: 
2370:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
2371:                                     "Confirmar Exclus" + CHR(227) + "o")
2372: 
2373:         IF loc_lConfirma
2374:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2375:                 IF THIS.this_oBusinessObject.Excluir()
2376:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")


### BO (C:\4c\projeto\app\classes\CmrBO.prg):
*==============================================================================
* CmrBO.prg - Business Object para Itens de Mapa de Resultados (SigCdMri)
* Data: 2026-07-29
* Tabela: SIGCDMRI | PK: CidChaves (char 20)
* FK: Balancos -> SIGCDMRR.Balancos
*==============================================================================

DEFINE CLASS CmrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SIGCDMRI)
    this_cCidChaves   = ""  && cidchaves   CHAR(20)     - Chave " + CHR(250) + "nica (PK)
    this_cBalancos    = ""  && balancos    CHAR(20)     - Balan" + CHR(231) + "o (FK -> SIGCDMRR)
    this_nAnaliticos  = 0   && analiticos  NUMERIC(1,0) - Anal" + CHR(237) + "tico (1=Sim, 2=N" + CHR(227) + "o)
    this_cClasses     = ""  && classes     CHAR(10)     - Classe contabil
    this_cDescGrps    = ""  && descgrps    CHAR(30)     - Descri" + CHR(231) + CHR(227) + "o do Subtotal
    this_nFators      = 0   && fators      NUMERIC(3,0) - Fator percentual (0-100)
    this_cGrupos      = ""  && grupos      CHAR(10)     - Grupo de conta corrente
    this_nNivels      = 0   && nivels      NUMERIC(1,0) - N" + CHR(237) + "vel hier" + CHR(225) + "rquico
    this_cOperacaos   = ""  && operacaos   CHAR(1)      - Opera" + CHR(231) + CHR(227) + "o ('+' Soma / '-' Subtrai)
    this_nTpregs      = 0   && tpregs      NUMERIC(1,0) - Tipo de registro (1=Grupo, 2=SubTotal, 3=Classe)
    this_cTitulos     = ""  && titulos     CHAR(10)     - T" + CHR(237) + "tulo do cabe" + CHR(231) + "alho de coluna
    this_nCpartidas   = 0   && cpartidas   NUMERIC(1,0) - Contra Partida (1=Sim, 2=N" + CHR(227) + "o)
    this_nOrdems      = 0   && ordems      NUMERIC(3,0) - Ordem de exibi" + CHR(231) + CHR(227) + "o
    this_nSubtot100s  = 0   && subtot100s  NUMERIC(1,0) - SubTotal 100% (1=Sim, 2=N" + CHR(227) + "o)
    this_nTpDatas     = 0   && tpdatas     NUMERIC(1,0) - Tipo de data (1=Emiss" + CHR(227) + "o, 2=Lan" + CHR(231) + "amento, 3=Vencimento, 4=Baixa)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMri"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor -> propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(CidChaves,  "C")
                THIS.this_cBalancos   = TratarNulo(Balancos,   "C")
                THIS.this_nTpregs     = TratarNulo(Tpregs,     "N")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cDescGrps   = TratarNulo(DescGrps,   "C")
                THIS.this_cClasses    = TratarNulo(Classes,    "C")
                THIS.this_nAnaliticos = TratarNulo(Analiticos, "N")
                THIS.this_cOperacaos  = TratarNulo(Operacaos,  "C")
                THIS.this_nCpartidas  = TratarNulo(Cpartidas,  "N")
                THIS.this_nSubtot100s = TratarNulo(Subtot100s, "N")
                THIS.this_nFators     = TratarNulo(Fators,     "N")
                THIS.this_cTitulos    = TratarNulo(Titulos,    "C")
                THIS.this_nOrdems     = TratarNulo(Ordems,     "N")
                THIS.this_nTpDatas    = TratarNulo(TpDatas,    "N")
                THIS.this_nNivels     = TratarNulo(Nivels,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista itens do mapa de resultados do Balanco corrente
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                       " ORDER BY Ordems, Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do mapa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cNovaChave
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica via SQL Server (NEWID sem hifens, 20 chars)
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS NovaCidChave", ;
                "cursor_4c_NewID")
            IF loc_nResult >= 0 AND USED("cursor_4c_NewID") AND RECCOUNT("cursor_4c_NewID") > 0
                GO TOP IN cursor_4c_NewID
                loc_cNovaChave = ALLTRIM(cursor_4c_NewID.NovaCidChave)
            ELSE
                loc_cNovaChave = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            THIS.this_cCidChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigCdMri" + ;
                " (CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                "  Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                "  Fators, Titulos, Ordems, TpDatas, Nivels)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cBalancos)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpregs) + ", " + ;
                EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                EscaparSQL(THIS.this_cDescGrps)   + ", " + ;
                EscaparSQL(THIS.this_cClasses)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAnaliticos)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpartidas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nSubtot100s)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFators)      + ", " + ;
                EscaparSQL(THIS.this_cTitulos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdems)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpDatas)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nNivels)      + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigCdMri SET" + ;
                " Tpregs = "      + FormatarNumeroSQL(THIS.this_nTpregs)     + "," + ;
                " Grupos = "      + EscaparSQL(THIS.this_cGrupos)            + "," + ;
                " DescGrps = "    + EscaparSQL(THIS.this_cDescGrps)          + "," + ;
                " Classes = "     + EscaparSQL(THIS.this_cClasses)           + "," + ;
                " Analiticos = "  + FormatarNumeroSQL(THIS.this_nAnaliticos) + "," + ;
                " Operacaos = "   + EscaparSQL(THIS.this_cOperacaos)         + "," + ;
                " Cpartidas = "   + FormatarNumeroSQL(THIS.this_nCpartidas)  + "," + ;
                " Subtot100s = "  + FormatarNumeroSQL(THIS.this_nSubtot100s) + "," + ;
                " Fators = "      + FormatarNumeroSQL(THIS.this_nFators)     + "," + ;
                " Titulos = "     + EscaparSQL(THIS.this_cTitulos)           + "," + ;
                " Ordems = "      + FormatarNumeroSQL(THIS.this_nOrdems)     + "," + ;
                " TpDatas = "     + FormatarNumeroSQL(THIS.this_nTpDatas)    + "," + ;
                " Nivels = "      + FormatarNumeroSQL(THIS.this_nNivels)     + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMri (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdMri" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

