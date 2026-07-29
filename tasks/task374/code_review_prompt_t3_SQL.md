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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2468 linhas total):

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

*-- Linhas 1917 a 1938:
1917:         ENDIF
1918: 
1919:         TRY
1920:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1921:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1922:                        " AND Titulos = " + EscaparSQL(loc_cTitulo)
1923:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
1924:             IF loc_nResult >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
1925:                 IF cursor_4c_DupTit.QTD > 0
1926:                     IF USED("cursor_4c_DupTit")
1927:                         USE IN cursor_4c_DupTit
1928:                     ENDIF
1929:                     MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
1930:                     loc_oPg2.txt_4c_Titulo.SetFocus()
1931:                     loc_lResultado = .F.
1932:                 ENDIF
1933:             ENDIF
1934:             IF USED("cursor_4c_DupTit")
1935:                 USE IN cursor_4c_DupTit
1936:             ENDIF
1937:         CATCH TO loc_oErro
1938:             IF USED("cursor_4c_DupTit")

*-- Linhas 1954 a 1974:
1954:         loc_nOrdem = 1
1955: 
1956:         TRY
1957:             loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
1958:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
1959:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
1960:             IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
1961:                 IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
1962:                     loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
1963:                 ENDIF
1964:             ENDIF
1965:             IF USED("cursor_4c_ProxOrdem")
1966:                 USE IN cursor_4c_ProxOrdem
1967:             ENDIF
1968:         CATCH TO loException
1969:             MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")
1970:         ENDTRY
1971: 
1972:         RETURN loc_nOrdem
1973:     ENDPROC
1974: 

*-- Linhas 1981 a 2007:
1981:         loc_lResultado = .T.
1982: 
1983:         TRY
1984:             loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
1985:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
1986:                        " AND Subtot100s = 1"
1987: 
1988:             IF NOT EMPTY(ALLTRIM(par_cDescGrpsAtual))
1989:                 loc_cSQL = loc_cSQL + " AND DescGrps <> " + EscaparSQL(ALLTRIM(par_cDescGrpsAtual))
1990:             ENDIF
1991: 
1992:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltSubtot")
1993:             IF loc_nResult >= 0 AND USED("cursor_4c_AltSubtot") AND RECCOUNT("cursor_4c_AltSubtot") > 0
1994:                 loc_nQtd = cursor_4c_AltSubtot.QTD
1995:                 loc_lResultado = (loc_nQtd <= 0)
1996:             ENDIF
1997:             IF USED("cursor_4c_AltSubtot")
1998:                 USE IN cursor_4c_AltSubtot
1999:             ENDIF
2000:         CATCH TO loException
2001:             MsgErro("Erro ao verificar subtotal: " + loException.Message, "Erro")
2002:         ENDTRY
2003: 
2004:         RETURN loc_lResultado
2005:     ENDPROC
2006: 
2007:     *==========================================================================

*-- Linhas 2038 a 2059:
2038: 
2039:             loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
2040:             TRY
2041:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2042:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2043:                            " AND Titulos = " + EscaparSQL(loc_cTituloVal)
2044:                 loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
2045:                 IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
2046:                     IF cursor_4c_DupTit.QTD > 0
2047:                         IF USED("cursor_4c_DupTit")
2048:                             USE IN cursor_4c_DupTit
2049:                         ENDIF
2050:                         MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
2051:                         loc_oPg2.txt_4c_Titulo.SetFocus()
2052:                         loc_lResultado = .F.
2053:                     ENDIF
2054:                 ENDIF
2055:                 IF USED("cursor_4c_DupTit")
2056:                     USE IN cursor_4c_DupTit
2057:                 ENDIF
2058:             CATCH TO loException
2059:                 IF USED("cursor_4c_DupTit")

*-- Linhas 2077 a 2097:
2077:             ENDIF
2078: 
2079:             TRY
2080:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
2081:                            EscaparSQL(loc_cGrupos)
2082:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
2083:                 IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
2084:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
2085:                     loc_oBO.this_cClasses  = loc_cGrupos
2086:                     IF USED("cursor_4c_VGcr")
2087:                         USE IN cursor_4c_VGcr
2088:                     ENDIF
2089:                 ELSE
2090:                     IF USED("cursor_4c_VGcr")
2091:                         USE IN cursor_4c_VGcr
2092:                     ENDIF
2093:                     MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2094:                     loc_oPg2.txt_4c__cd_grupos.SetFocus()
2095:                     loc_lResultado = .F.
2096:                 ENDIF
2097:             CATCH TO loException

*-- Linhas 2116 a 2136:
2116:             ENDIF
2117: 
2118:             TRY
2119:                 loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
2120:                            EscaparSQL(loc_cClasses)
2121:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
2122:                 IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
2123:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
2124:                     loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
2125:                     IF USED("cursor_4c_VCss")
2126:                         USE IN cursor_4c_VCss
2127:                     ENDIF
2128:                 ELSE
2129:                     IF USED("cursor_4c_VCss")
2130:                         USE IN cursor_4c_VCss
2131:                     ENDIF
2132:                     MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2133:                     loc_oPg2.txt_4c_Classe.SetFocus()
2134:                     loc_lResultado = .F.
2135:                 ENDIF
2136:             CATCH TO loException

*-- Linhas 2146 a 2167:
2146:             ENDIF
2147: 
2148:             TRY
2149:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2150:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2151:                            " AND Classes = " + EscaparSQL(loc_cClasses)
2152:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
2153:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
2154:                     IF cursor_4c_DupCls.QTD > 0
2155:                         IF USED("cursor_4c_DupCls")
2156:                             USE IN cursor_4c_DupCls
2157:                         ENDIF
2158:                         MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
2159:                         loc_oPg2.txt_4c_Classe.SetFocus()
2160:                         loc_lResultado = .F.
2161:                     ENDIF
2162:                 ENDIF
2163:                 IF USED("cursor_4c_DupCls")
2164:                     USE IN cursor_4c_DupCls
2165:                 ENDIF
2166:             CATCH TO loException
2167:                 MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")

*-- Linhas 2191 a 2212:
2191:             loc_oBO.this_cClasses = "6"
2192: 
2193:             TRY
2194:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2195:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2196:                            " AND DescGrps = " + EscaparSQL(loc_cDescGrps)
2197:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
2198:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
2199:                     IF cursor_4c_DupSub.QTD > 0
2200:                         IF USED("cursor_4c_DupSub")
2201:                             USE IN cursor_4c_DupSub
2202:                         ENDIF
2203:                         MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
2204:                         loc_oPg2.txt_4c_Descgrps.SetFocus()
2205:                         loc_lResultado = .F.
2206:                     ENDIF
2207:                 ENDIF
2208:                 IF USED("cursor_4c_DupSub")
2209:                     USE IN cursor_4c_DupSub
2210:                 ENDIF
2211:             CATCH TO loException
2212:                 MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")

*-- Linhas 2245 a 2265:
2245:         *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
2246:         IF loc_nTpregs = 1
2247:             TRY
2248:                 loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
2249:                            EscaparSQL(loc_oBO.this_cClasses)
2250:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
2251:                 IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
2252:                     loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
2253:                 ELSE
2254:                     loc_oBO.this_nNivels = 0
2255:                 ENDIF
2256:                 IF USED("cursor_4c_NivGrp")
2257:                     USE IN cursor_4c_NivGrp
2258:                 ENDIF
2259:             CATCH TO loException
2260:                 MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
2261:             ENDTRY
2262:         ENDIF
2263: 
2264:         RETURN .T.
2265:     ENDPROC

*-- Linhas 2293 a 2334:
2293:         loc_cCidChaves = ""
2294: 
2295:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2296:             SELECT cursor_4c_Dados
2297:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2298:         ENDIF
2299: 
2300:         IF EMPTY(loc_cCidChaves)
2301:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
2302:             RETURN
2303:         ENDIF
2304: 
2305:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2306:             THIS.this_cCidChavesAtual = loc_cCidChaves
2307:             THIS.this_cModoAtual      = "VISUALIZAR"
2308:             THIS.BOParaForm()
2309:             THIS.HabilitarCampos(.F.)
2310:             THIS.AlternarPagina(2)
2311:         ENDIF
2312:     ENDPROC
2313: 
2314:     PROCEDURE BtnAlterarClick()
2315:         LOCAL loc_cCidChaves, loc_cDescGrpsAtual
2316:         loc_cCidChaves = ""
2317: 
2318:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2319:             SELECT cursor_4c_Dados
2320:             loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
2321:             loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
2322:         ENDIF
2323: 
2324:         IF EMPTY(loc_cCidChaves)
2325:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
2326:             RETURN
2327:         ENDIF
2328: 
2329:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2330:             THIS.this_cCidChavesAtual = loc_cCidChaves
2331:             THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
2332:             THIS.this_oBusinessObject.EditarRegistro()
2333:             THIS.this_cModoAtual = "ALTERAR"
2334:             THIS.BOParaForm()

*-- Linhas 2342 a 2360:
2342:         loc_cCidChaves = ""
2343: 
2344:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2345:             SELECT cursor_4c_Dados
2346:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2347:         ENDIF
2348: 
2349:         IF EMPTY(loc_cCidChaves)
2350:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2351:             RETURN
2352:         ENDIF
2353: 
2354:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
2355:                                     "Confirmar Exclus" + CHR(227) + "o")
2356: 
2357:         IF loc_lConfirma
2358:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2359:                 IF THIS.this_oBusinessObject.Excluir()
2360:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")


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

