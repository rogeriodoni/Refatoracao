# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: BALANCOS, SUBTOT100S, DESCGRPS, TITULOS, CODIGOS, CLASSES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2472 linhas total):

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

*-- Linhas 1458 a 1478:
1458:         ENDIF
1459: 
1460:         TRY
1461:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1462:                        EscaparSQL(loc_cGrupo)
1463:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1464:             IF loc_nResult >= 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1465:                 loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrVal.Descrs)
1466:             ELSE
1467:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1468:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1469:                     "Grupos de Conta Corrente")
1470: 
1471:                 IF VARTYPE(loc_oBusca) = "O"
1472:                     IF NOT loc_oBusca.this_lAchouRegistro
1473:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1474:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1475:                         loc_oBusca.Show()
1476:                     ENDIF
1477: 
1478:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")

*-- Linhas 1581 a 1601:
1581:         ENDIF
1582: 
1583:         TRY
1584:             loc_cSQL = "SELECT TOP 1 Classes, Descrs FROM SigCdCss WHERE Classes = " + ;
1585:                        EscaparSQL(loc_cClasse)
1586:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVal")
1587:             IF loc_nResult >= 0 AND USED("cursor_4c_CssVal") AND RECCOUNT("cursor_4c_CssVal") > 0
1588:                 loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssVal.Descrs)
1589:             ELSE
1590:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1591:                     "SigCdCss", "cursor_4c_BuscaClasse", "Classes", loc_cClasse, ;
1592:                     "Classes Cont" + CHR(225) + "beis")
1593: 
1594:                 IF VARTYPE(loc_oBusca) = "O"
1595:                     IF NOT loc_oBusca.this_lAchouRegistro
1596:                         loc_oBusca.mAddColuna("Classes", "", "Classe")
1597:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1598:                         loc_oBusca.Show()
1599:                     ENDIF
1600: 
1601:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")

*-- Linhas 1917 a 1939:
1917:         ENDIF
1918: 
1919:         TRY
1920:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1921:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1922:                        " AND Titulos = " + EscaparSQL(loc_cTitulo) + ;
1923:                        " AND CidChaves <> " + EscaparSQL(THIS.this_oBusinessObject.this_cCidChaves)
1924:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
1925:             IF loc_nResult >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
1926:                 IF cursor_4c_DupTit.QTD > 0
1927:                     IF USED("cursor_4c_DupTit")
1928:                         USE IN cursor_4c_DupTit
1929:                     ENDIF
1930:                     MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
1931:                     loc_oPg2.txt_4c_Titulo.SetFocus()
1932:                     loc_lResultado = .F.
1933:                 ENDIF
1934:             ENDIF
1935:             IF USED("cursor_4c_DupTit")
1936:                 USE IN cursor_4c_DupTit
1937:             ENDIF
1938:         CATCH TO loc_oErro
1939:             IF USED("cursor_4c_DupTit")

*-- Linhas 1955 a 1975:
1955:         loc_nOrdem = 1
1956: 
1957:         TRY
1958:             loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
1959:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
1960:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
1961:             IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
1962:                 IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
1963:                     loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
1964:                 ENDIF
1965:             ENDIF
1966:             IF USED("cursor_4c_ProxOrdem")
1967:                 USE IN cursor_4c_ProxOrdem
1968:             ENDIF
1969:         CATCH TO loException
1970:             MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")
1971:         ENDTRY
1972: 
1973:         RETURN loc_nOrdem
1974:     ENDFUNC
1975: 

*-- Linhas 1982 a 2008:
1982:         loc_lResultado = .T.
1983: 
1984:         TRY
1985:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1986:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1987:                        " AND Subtot100s = 1"
1988: 
1989:             IF NOT EMPTY(ALLTRIM(par_cDescGrpsAtual))
1990:                 loc_cSQL = loc_cSQL + " AND DescGrps <> " + EscaparSQL(ALLTRIM(par_cDescGrpsAtual))
1991:             ENDIF
1992: 
1993:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltSubtot")
1994:             IF loc_nResult >= 0 AND USED("cursor_4c_AltSubtot") AND RECCOUNT("cursor_4c_AltSubtot") > 0
1995:                 loc_nQtd = cursor_4c_AltSubtot.QTD
1996:                 loc_lResultado = (loc_nQtd <= 0)
1997:             ENDIF
1998:             IF USED("cursor_4c_AltSubtot")
1999:                 USE IN cursor_4c_AltSubtot
2000:             ENDIF
2001:         CATCH TO loException
2002:             MsgErro("Erro ao verificar subtotal: " + loException.Message, "Erro")
2003:         ENDTRY
2004: 
2005:         RETURN loc_lResultado
2006:     ENDFUNC
2007: 
2008:     *==========================================================================

*-- Linhas 2039 a 2061:
2039: 
2040:             loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
2041:             TRY
2042:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2043:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2044:                            " AND Titulos = " + EscaparSQL(loc_cTituloVal) + ;
2045:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2046:                 loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
2047:                 IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
2048:                     IF cursor_4c_DupTit.QTD > 0
2049:                         IF USED("cursor_4c_DupTit")
2050:                             USE IN cursor_4c_DupTit
2051:                         ENDIF
2052:                         MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
2053:                         loc_oPg2.txt_4c_Titulo.SetFocus()
2054:                         loc_lResultado = .F.
2055:                     ENDIF
2056:                 ENDIF
2057:                 IF USED("cursor_4c_DupTit")
2058:                     USE IN cursor_4c_DupTit
2059:                 ENDIF
2060:             CATCH TO loException
2061:                 IF USED("cursor_4c_DupTit")

*-- Linhas 2079 a 2099:
2079:             ENDIF
2080: 
2081:             TRY
2082:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
2083:                            EscaparSQL(loc_cGrupos)
2084:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
2085:                 IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
2086:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
2087:                     loc_oBO.this_cClasses  = loc_cGrupos
2088:                     IF USED("cursor_4c_VGcr")
2089:                         USE IN cursor_4c_VGcr
2090:                     ENDIF
2091:                 ELSE
2092:                     IF USED("cursor_4c_VGcr")
2093:                         USE IN cursor_4c_VGcr
2094:                     ENDIF
2095:                     MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2096:                     loc_oPg2.txt_4c__cd_grupos.SetFocus()
2097:                     loc_lResultado = .F.
2098:                 ENDIF
2099:             CATCH TO loException

*-- Linhas 2118 a 2138:
2118:             ENDIF
2119: 
2120:             TRY
2121:                 loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
2122:                            EscaparSQL(loc_cClasses)
2123:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
2124:                 IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
2125:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
2126:                     loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
2127:                     IF USED("cursor_4c_VCss")
2128:                         USE IN cursor_4c_VCss
2129:                     ENDIF
2130:                 ELSE
2131:                     IF USED("cursor_4c_VCss")
2132:                         USE IN cursor_4c_VCss
2133:                     ENDIF
2134:                     MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2135:                     loc_oPg2.txt_4c_Classe.SetFocus()
2136:                     loc_lResultado = .F.
2137:                 ENDIF
2138:             CATCH TO loException

*-- Linhas 2148 a 2170:
2148:             ENDIF
2149: 
2150:             TRY
2151:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2152:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2153:                            " AND Classes = " + EscaparSQL(loc_cClasses) + ;
2154:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2155:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
2156:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
2157:                     IF cursor_4c_DupCls.QTD > 0
2158:                         IF USED("cursor_4c_DupCls")
2159:                             USE IN cursor_4c_DupCls
2160:                         ENDIF
2161:                         MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
2162:                         loc_oPg2.txt_4c_Classe.SetFocus()
2163:                         loc_lResultado = .F.
2164:                     ENDIF
2165:                 ENDIF
2166:                 IF USED("cursor_4c_DupCls")
2167:                     USE IN cursor_4c_DupCls
2168:                 ENDIF
2169:             CATCH TO loException
2170:                 MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")

*-- Linhas 2194 a 2216:
2194:             loc_oBO.this_cClasses = "6"
2195: 
2196:             TRY
2197:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2198:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2199:                            " AND DescGrps = " + EscaparSQL(loc_cDescGrps) + ;
2200:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2201:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
2202:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
2203:                     IF cursor_4c_DupSub.QTD > 0
2204:                         IF USED("cursor_4c_DupSub")
2205:                             USE IN cursor_4c_DupSub
2206:                         ENDIF
2207:                         MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
2208:                         loc_oPg2.txt_4c_Descgrps.SetFocus()
2209:                         loc_lResultado = .F.
2210:                     ENDIF
2211:                 ENDIF
2212:                 IF USED("cursor_4c_DupSub")
2213:                     USE IN cursor_4c_DupSub
2214:                 ENDIF
2215:             CATCH TO loException
2216:                 MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")

*-- Linhas 2249 a 2269:
2249:         *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
2250:         IF loc_nTpregs = 1
2251:             TRY
2252:                 loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
2253:                            EscaparSQL(loc_oBO.this_cClasses)
2254:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
2255:                 IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
2256:                     loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
2257:                 ELSE
2258:                     loc_oBO.this_nNivels = 0
2259:                 ENDIF
2260:                 IF USED("cursor_4c_NivGrp")
2261:                     USE IN cursor_4c_NivGrp
2262:                 ENDIF
2263:             CATCH TO loException
2264:                 MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
2265:             ENDTRY
2266:         ENDIF
2267: 
2268:         RETURN .T.
2269:     ENDFUNC

*-- Linhas 2297 a 2338:
2297:         loc_cCidChaves = ""
2298: 
2299:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2300:             SELECT cursor_4c_Dados
2301:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2302:         ENDIF
2303: 
2304:         IF EMPTY(loc_cCidChaves)
2305:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
2306:             RETURN
2307:         ENDIF
2308: 
2309:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2310:             THIS.this_cCidChavesAtual = loc_cCidChaves
2311:             THIS.this_cModoAtual      = "VISUALIZAR"
2312:             THIS.BOParaForm()
2313:             THIS.HabilitarCampos(.F.)
2314:             THIS.AlternarPagina(2)
2315:         ENDIF
2316:     ENDPROC
2317: 
2318:     PROCEDURE BtnAlterarClick()
2319:         LOCAL loc_cCidChaves, loc_cDescGrpsAtual
2320:         loc_cCidChaves = ""
2321: 
2322:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2323:             SELECT cursor_4c_Dados
2324:             loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
2325:             loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
2326:         ENDIF
2327: 
2328:         IF EMPTY(loc_cCidChaves)
2329:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
2330:             RETURN
2331:         ENDIF
2332: 
2333:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2334:             THIS.this_cCidChavesAtual = loc_cCidChaves
2335:             THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
2336:             THIS.this_oBusinessObject.EditarRegistro()
2337:             THIS.this_cModoAtual = "ALTERAR"
2338:             THIS.BOParaForm()

*-- Linhas 2346 a 2364:
2346:         loc_cCidChaves = ""
2347: 
2348:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2349:             SELECT cursor_4c_Dados
2350:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2351:         ENDIF
2352: 
2353:         IF EMPTY(loc_cCidChaves)
2354:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2355:             RETURN
2356:         ENDIF
2357: 
2358:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
2359:                                     "Confirmar Exclus" + CHR(227) + "o")
2360: 
2361:         IF loc_lConfirma
2362:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2363:                 IF THIS.this_oBusinessObject.Excluir()
2364:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")


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

