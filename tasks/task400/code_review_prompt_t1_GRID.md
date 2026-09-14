# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 345: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS GRID (2891 linhas total):

*-- Linhas 331 a 362:
331:                 .ForeColor       = RGB(90, 90, 90)
332:                 .BackColor       = RGB(255, 255, 255)
333:                 .Themes          = .F.
334:                 .SpecialEffect   = 0
335:                 .MousePointer    = 15
336:                 .WordWrap        = .T.
337:                 .AutoSize        = .F.
338:                 .Visible         = .T.
339:             ENDWITH
340: 
341:             *-- Grade principal - cursor_4c_Dados / series
342:             *-- Top=117 = 88 (posicao padrao framework) + 29 (compensacao PageFrame)
343:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
344:             loc_oPagina.grd_4c_Lista.ColumnCount = 3
345:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
346:             loc_oPagina.grd_4c_Lista.ColumnCount  = 1
347:             WITH loc_oPagina.grd_4c_Lista
348:                 .Top                = 117
349:                 .Left               = 12
350:                 .Width              = 890
351:                 .Height             = 490
352:                 .FontName           = "Verdana"
353:                 .FontSize           = 8
354:                 .ForeColor          = RGB(90, 90, 90)
355:                 .BackColor          = RGB(255, 255, 255)
356:                 .GridLineColor      = RGB(238, 238, 238)
357:                 .HighlightBackColor = RGB(255, 255, 255)
358:                 .HighlightForeColor = RGB(15, 41, 104)
359:                 .HighlightStyle     = 2
360:                 .DeleteMark         = .F.
361:                 .RecordMark         = .F.
362:                 .RowHeight          = 16

*-- Linhas 368 a 386:
368:                     .ControlSource    = "cursor_4c_Dados.series"
369:                     .Width            = 100
370:                     .Resizable        = .T.
371:                     .Header1.Caption  = "S" + CHR(233) + "rie"
372:                 ENDWITH
373:             ENDWITH
374: 
375:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
376:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
377:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
378:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
379:             WITH loc_oPagina.cnt_4c_CopiaFl
380:                 .Top         = 270
381:                 .Left        = 335
382:                 .Width       = 317
383:                 .Height      = 123
384:                 .BackColor   = RGB(220, 220, 220)
385:                 .BorderWidth = 1
386:                 .Visible     = .F.

*-- Linhas 1808 a 1831:
1808:                 IF !THIS.this_oBusinessObject.Buscar("")
1809:                     loc_lResultado = .F.
1810:                 ELSE
1811:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1812:                     loc_oGrid.ColumnCount = 1
1813:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1814:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1815:                     loc_oGrid.Column1.Width             = 100
1816:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1817:                     THIS.FormatarGridLista(loc_oGrid)
1818:                     loc_lResultado = .T.
1819:                 ENDIF
1820:             CATCH TO loException
1821:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
1822:                 loc_lResultado = .F.
1823:             ENDTRY
1824:         ENDIF
1825: 
1826:         RETURN loc_lResultado
1827:     ENDPROC
1828: 
1829:     *==========================================================================
1830:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1831:     *==========================================================================

*-- Linhas 1993 a 2015:
1993:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
1994:             ENDIF
1995:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1996:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1997:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
1999:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
2000:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2001:                 THIS.this_cModoAtual = "LISTA"
2002:                 THIS.pgf_4c_Paginas.Visible = .T.
2003:                 THIS.pgf_4c_Paginas.ActivePage = 1
2004:             ENDIF
2005:             RETURN
2006:         ENDIF
2007: 
2008:         IF INLIST(THIS.this_cModoAtual, "VISUALIZAR")
2009:             THIS.this_cModoAtual = "LISTA"
2010:             THIS.AlternarPagina(1)
2011:             RETURN
2012:         ENDIF
2013: 
2014:         THIS.FormParaBO()
2015: 

*-- Linhas 2050 a 2068:
2050: 
2051:         *-- Desabilitar controles durante a copia (como no legado)
2052:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2053:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2054:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2055:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2056: 
2057:         *-- Preencher e exibir painel
2058:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2059:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2060:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2061:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2062:     ENDPROC
2063: 
2064:     *==========================================================================
2065:     * BtnOKCopiarClick - Executa copia da serie
2066:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2067:     *==========================================================================
2068:     PROCEDURE BtnOKCopiarClick()

*-- Linhas 2118 a 2164:
2118:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2119: 
2120:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2121:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2122:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2123:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2124:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2125:         loc_oPg1.grd_4c_Lista.SetFocus
2126:     ENDPROC
2127: 
2128:     *==========================================================================
2129:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2130:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2131:     * Tabela SigCdSer (series disponiveis)
2132:     *==========================================================================
2133:     PROCEDURE ValidarSerieDestino()
2134:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca
2135:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2136:         loc_cSerieDest = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
2137: 
2138:         IF EMPTY(loc_cSerieDest)
2139:             RETURN
2140:         ENDIF
2141: 
2142:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2143:             "SigCdSer", "cursor_4c_BuscaSer", "cods", loc_cSerieDest, ;
2144:             "S" + CHR(233) + "ries")
2145: 
2146:         IF VARTYPE(loc_oBusca) = "O"
2147:             IF !loc_oBusca.this_lAchouRegistro
2148:                 loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2149:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2150:                 loc_oBusca.Show()
2151: 
2152:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2153:                     loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value = ;
2154:                         ALLTRIM(cursor_4c_BuscaSer.cods)
2155:                 ENDIF
2156:             ENDIF
2157:             loc_oBusca.Release()
2158:         ENDIF
2159: 
2160:         IF USED("cursor_4c_BuscaSer")
2161:             USE IN cursor_4c_BuscaSer
2162:         ENDIF
2163:     ENDPROC
2164: 

