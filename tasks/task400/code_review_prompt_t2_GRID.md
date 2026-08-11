# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 347: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS GRID (2896 linhas total):

*-- Linhas 333 a 363:
333:                 .ForeColor       = RGB(90, 90, 90)
334:                 .BackColor       = RGB(255, 255, 255)
335:                 .Themes          = .F.
336:                 .SpecialEffect   = 0
337:                 .MousePointer    = 15
338:                 .WordWrap        = .T.
339:                 .AutoSize        = .F.
340:                 .Visible         = .T.
341:             ENDWITH
342: 
343:             *-- Grade principal - cursor_4c_Dados / series
344:             *-- Top=117 = 88 (posicao padrao framework) + 29 (compensacao PageFrame)
345:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
346:             loc_oPagina.grd_4c_Lista.ColumnCount = 1
347:             loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
348:             WITH loc_oPagina.grd_4c_Lista
349:                 .Top                = 117
350:                 .Left               = 12
351:                 .Width              = 890
352:                 .Height             = 490
353:                 .FontName           = "Verdana"
354:                 .FontSize           = 8
355:                 .ForeColor          = RGB(90, 90, 90)
356:                 .BackColor          = RGB(255, 255, 255)
357:                 .GridLineColor      = RGB(238, 238, 238)
358:                 .HighlightBackColor = RGB(255, 255, 255)
359:                 .HighlightForeColor = RGB(15, 41, 104)
360:                 .HighlightStyle     = 2
361:                 .DeleteMark         = .F.
362:                 .RecordMark         = .F.
363:                 .RowHeight          = 16

*-- Linhas 369 a 387:
369:                     .ControlSource    = "cursor_4c_Dados.series"
370:                     .Width            = 100
371:                     .Resizable        = .T.
372:                     .Header1.Caption  = "S" + CHR(233) + "rie"
373:                 ENDWITH
374:             ENDWITH
375: 
376:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
377:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
378:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
379:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
380:             WITH loc_oPagina.cnt_4c_CopiaFl
381:                 .Top         = 270
382:                 .Left        = 335
383:                 .Width       = 317
384:                 .Height      = 123
385:                 .BackColor   = RGB(220, 220, 220)
386:                 .BorderWidth = 1
387:                 .Visible     = .F.

*-- Linhas 1809 a 1832:
1809:                 IF !THIS.this_oBusinessObject.Buscar("")
1810:                     loc_lResultado = .F.
1811:                 ELSE
1812:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1813:                     loc_oGrid.ColumnCount = 1
1814:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1815:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1816:                     loc_oGrid.Column1.Width             = 100
1817:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1818:                     THIS.FormatarGridLista(loc_oGrid)
1819:                     loc_lResultado = .T.
1820:                 ENDIF
1821:             CATCH TO loException
1822:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
1823:                 loc_lResultado = .F.
1824:             ENDTRY
1825:         ENDIF
1826: 
1827:         RETURN loc_lResultado
1828:     ENDPROC
1829: 
1830:     *==========================================================================
1831:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1832:     *==========================================================================

*-- Linhas 1994 a 2016:
1994:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
1995:             ENDIF
1996:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1997:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
1999:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
2000:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
2001:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2002:                 THIS.this_cModoAtual = "LISTA"
2003:                 THIS.pgf_4c_Paginas.Visible = .T.
2004:                 THIS.pgf_4c_Paginas.ActivePage = 1
2005:             ENDIF
2006:             RETURN
2007:         ENDIF
2008: 
2009:         IF INLIST(THIS.this_cModoAtual, "VISUALIZAR")
2010:             THIS.this_cModoAtual = "LISTA"
2011:             THIS.AlternarPagina(1)
2012:             RETURN
2013:         ENDIF
2014: 
2015:         THIS.FormParaBO()
2016: 

*-- Linhas 2051 a 2069:
2051: 
2052:         *-- Desabilitar controles durante a copia (como no legado)
2053:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2054:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2055:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2056:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2057: 
2058:         *-- Preencher e exibir painel
2059:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2060:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2061:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2062:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2063:     ENDPROC
2064: 
2065:     *==========================================================================
2066:     * BtnOKCopiarClick - Executa copia da serie
2067:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2068:     *==========================================================================
2069:     PROCEDURE BtnOKCopiarClick()

*-- Linhas 2119 a 2141:
2119:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2120: 
2121:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2122:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2123:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2124:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2125:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2126:         loc_oPg1.grd_4c_Lista.SetFocus
2127:     ENDPROC
2128: 
2129:     *==========================================================================
2130:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2131:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2132:     * Tabela SigCdSer (series disponiveis)
2133:     *==========================================================================
2134:     PROCEDURE ValidarSerieDestino
2135:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2136:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2137:             RETURN
2138:         ENDIF
2139:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca
2140:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2141:         loc_cSerieDest = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)

*-- Linhas 2150 a 2169:
2150: 
2151:         IF VARTYPE(loc_oBusca) = "O"
2152:             IF !loc_oBusca.this_lAchouRegistro
2153:                 loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2154:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2155:                 loc_oBusca.Show()
2156: 
2157:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2158:                     loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value = ;
2159:                         ALLTRIM(cursor_4c_BuscaSer.cods)
2160:                 ENDIF
2161:             ENDIF
2162:             loc_oBusca.Release()
2163:         ENDIF
2164: 
2165:         IF USED("cursor_4c_BuscaSer")
2166:             USE IN cursor_4c_BuscaSer
2167:         ENDIF
2168:     ENDPROC
2169: 

