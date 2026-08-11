# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ValidarSerieDestino' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSerieDestino(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Copia' (parent: SIGCDDUP.Pagina.Lista): Top original=4 vs migrado 'cnt_4c_CopiaFl' Top=40 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Copia' (parent: SIGCDDUP.Pagina.Lista): Left original=474 vs migrado 'cnt_4c_CopiaFl' Left=29 (diff=445px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDDUP.Pagina.Dados): Top original=138 vs migrado 'txt_4c_Text19' Top=273 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDDUP.Pagina.Dados): Left original=293 vs migrado 'txt_4c_Text19' Left=183 (diff=110px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDDUP.Pagina.Dados): Top original=138 vs migrado 'txt_4c_Text38' Top=333 (diff=195px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDDUP.Pagina.Dados): Left original=623 vs migrado 'txt_4c_Text38' Left=298 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDDUP.Pagina.Dados): Top original=138 vs migrado 'txt_4c_Text42' Top=335 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDDUP.Pagina.Dados): Left original=672 vs migrado 'txt_4c_Text42' Left=605 (diff=67px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2890 linhas total):

*-- Linhas 26 a 150:
26: 
27:     *==========================================================================
28:     * Init - Inicializa o formulario
29:     * FormBase.Init() chama InicializarForm() automaticamente
30:     *==========================================================================
31:     PROCEDURE Init()
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             loc_lSucesso = DODEFAULT()
37:         CATCH TO loException
38:             MsgErro("Erro ao inicializar FormDup:" + CHR(13) + loException.Message, "Erro")
39:         ENDTRY
40: 
41:         RETURN loc_lSucesso
42:     ENDPROC
43: 
44:     *==========================================================================
45:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.this_oBusinessObject = CREATEOBJECT("DupBO")
53: 
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar DupBO", "Erro")
56:             ELSE
57:                 THIS.ConfigurarPageFrame()
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66:                 loc_lSucesso = .T.
67:             ENDIF
68:         CATCH TO loException
69:             MsgErro("Erro ao inicializar formulario:" + CHR(13) + loException.Message, "Erro")
70:         ENDTRY
71: 
72:         RETURN loc_lSucesso
73:     ENDPROC
74: 
75:     *==========================================================================
76:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
77:     *==========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         TRY
80:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:             WITH THIS.pgf_4c_Paginas
82:                 .PageCount  = 2
83:                 .Top        = -29
84:                 .Left       = 0
85:                 .Width      = THIS.Width
86:                 .Height     = THIS.Height + 29
87:                 .Tabs       = .F.
88:                 .TabStretch = 1
89:                 .Visible    = .T.
90:                 .Page1.Caption   = "Lista"
91:                 .Page1.BackColor = RGB(236, 236, 236)
92:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:                 .Page2.Caption   = "Dados"
94:                 .Page2.BackColor = RGB(236, 236, 236)
95:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             ENDWITH
97: 
98:             THIS.ConfigurarPaginaLista()
99:             THIS.ConfigurarPaginaDados()
100: 
101:         CATCH TO loException
102:             MsgErro("Erro ao configurar PageFrame:" + CHR(13) + loException.Message, "Erro")
103:         ENDTRY
104:     ENDPROC
105: 
106:     *==========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 completa
108:     * Cabecalho + botoes CRUD + Encerrar + grid + botao Copiar + painel flutuante
109:     *==========================================================================
110:     PROTECTED PROCEDURE ConfigurarPaginaLista()
111:         LOCAL loc_oPagina
112:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
113: 
114:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         TRY
118:             *-- Container cabecalho (cntSombra no legado) - Top=2 dentro da Page
119:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:             WITH loc_oPagina.cnt_4c_Cabecalho
121:                 .Top         = 2
122:                 .Left        = 0
123:                 .Width       = THIS.Width
124:                 .Height      = 80
125:                 .BackColor   = RGB(100, 100, 100)
126:                 .BorderWidth = 0
127:                 .Visible     = .T.
128: 
129:                 .AddObject("lbl_4c_Sombra", "Label")
130:                 WITH .lbl_4c_Sombra
131:                     .Caption   = THIS.Caption
132:                     .Top       = 15
133:                     .Left      = 10
134:                     .Width     = THIS.Width
135:                     .Height    = 40
136:                     .FontName  = "Tahoma"
137:                     .FontSize  = 16
138:                     .FontBold  = .T.
139:                     .ForeColor = RGB(0, 0, 0)
140:                     .BackStyle = 0
141:                     .AutoSize  = .F.
142:                     .Visible   = .T.
143:                 ENDWITH
144: 
145:                 .AddObject("lbl_4c_Titulo", "Label")
146:                 WITH .lbl_4c_Titulo
147:                     .Caption   = THIS.Caption
148:                     .Top       = 18
149:                     .Left      = 10
150:                     .Width     = THIS.Width

*-- Linhas 371 a 416:
371:                 ENDWITH
372:             ENDWITH
373: 
374:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
375:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
376:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
377:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
378:             WITH loc_oPagina.cnt_4c_CopiaFl
379:                 .Top         = 270
380:                 .Left        = 335
381:                 .Width       = 317
382:                 .Height      = 123
383:                 .BackColor   = RGB(220, 220, 220)
384:                 .BorderWidth = 1
385:                 .Visible     = .F.
386: 
387:                 .AddObject("lbl_4c_LblSerieOrigem", "Label")
388:                 WITH .lbl_4c_LblSerieOrigem
389:                     .Caption   = "S" + CHR(233) + "rie Origem :"
390:                     .Top       = 40
391:                     .Left      = 29
392:                     .Width     = 72
393:                     .Height    = 15
394:                     .FontName  = "Tahoma"
395:                     .FontSize  = 8
396:                     .BackStyle = 0
397:                     .ForeColor = RGB(0, 0, 0)
398:                     .Visible   = .T.
399:                 ENDWITH
400: 
401:                 .AddObject("txt_4c_SeriesOrigem", "TextBox")
402:                 WITH .txt_4c_SeriesOrigem
403:                     .Top      = 36
404:                     .Left     = 103
405:                     .Width    = 34
406:                     .Height   = 24
407:                     .FontName = "Tahoma"
408:                     .FontSize = 8
409:                     .Value    = ""
410:                     .ReadOnly = .T.
411:                     .Visible  = .T.
412:                 ENDWITH
413: 
414:                 .AddObject("lbl_4c_LblSerieDestino", "Label")
415:                 WITH .lbl_4c_LblSerieDestino
416:                     .Caption   = "S" + CHR(233) + "rie Destino :"

*-- Linhas 472 a 539:
472:                 ENDWITH
473:             ENDWITH
474: 
475:             *-- BINDEVENTs da Page1
476:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,        "Click", THIS, "BtnIncluirClick")
477:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,     "Click", THIS, "BtnVisualizarClick")
478:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,        "Click", THIS, "BtnAlterarClick")
479:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,        "Click", THIS, "BtnExcluirClick")
480:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,         "Click", THIS, "BtnBuscarClick")
481:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,        "Click", THIS, "BtnEncerrarClick")
482:             BINDEVENT(loc_oPagina.cmd_4c_Copia,                        "Click", THIS, "BtnCopiarClick")
483:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_OKCopia,       "Click", THIS, "BtnOKCopiarClick")
484:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiarClick")
485:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.txt_4c_SerieDestino,  "KeyPress", THIS, "ValidarSerieDestino")
486: 
487:             THIS.TornarControlesVisiveis(loc_oPagina)
488: 
489:         CATCH TO loException
490:             MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
491:         ENDTRY
492:     ENDPROC
493: 
494:     *==========================================================================
495:     * ConfigurarPaginaDados - Configura Page2 (Dados)
496:     * Fase 5: Serie, Cabecalho e primeira linha do Sacado
497:     * Fase 6: Segunda linha Sacado, Observacao e Impressora (a adicionar)
498:     *==========================================================================
499:     PROTECTED PROCEDURE ConfigurarPaginaDados()
500:         LOCAL loc_oPagina
501:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
502: 
503:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
504:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
505: 
506:         TRY
507:             *------------------------------------------------------------------
508:             * SERIE (PK) - txt_4c_Series: top=70+29=99 / Label40: top=72+29=101
509:             *------------------------------------------------------------------
510:             loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
511:             WITH loc_oPagina.lbl_4c_LblSerie
512:                 .Caption   = "S" + CHR(233) + "rie :"
513:                 .Top       = 101
514:                 .Left      = 185
515:                 .Width     = 37
516:                 .Height    = 15
517:                 .FontName  = "Tahoma"
518:                 .FontSize  = 8
519:                 .ForeColor = RGB(90, 90, 90)
520:                 .BackStyle = 0
521:                 .Visible   = .T.
522:             ENDWITH
523: 
524:             loc_oPagina.AddObject("txt_4c_Series", "TextBox")
525:             WITH loc_oPagina.txt_4c_Series
526:                 .Value    = ""
527:                 .Top      = 99
528:                 .Left     = 229
529:                 .Width    = 31
530:                 .Height   = 18
531:                 .FontName = "Tahoma"
532:                 .FontSize = 8
533:                 .Visible  = .T.
534:             ENDWITH
535: 
536:             *------------------------------------------------------------------
537:             * SECAO CABECALHO (linha/coluna impressao dados do documento)
538:             * Label27 top=103+29=132 / Shape1 top=119+29=148
539:             *------------------------------------------------------------------

*-- Linhas 1143 a 1164:
1143:                 .FontSize  = 8
1144:                 .ForeColor = RGB(90, 90, 90)
1145:                 .BackStyle = 0
1146:                 .Visible   = .T.
1147:             ENDWITH
1148:             loc_oPagina.AddObject("txt_4c_Text19", "TextBox")
1149:             WITH loc_oPagina.txt_4c_Text19
1150:                 .Value    = 0
1151:                 .Top      = 273
1152:                 .Left     = 183
1153:                 .Width    = 41
1154:                 .Height   = 18
1155:                 .FontName = "Tahoma"
1156:                 .FontSize = 8
1157:                 .Visible  = .T.
1158:             ENDWITH
1159:             loc_oPagina.AddObject("lbl_4c_XEnd", "Label")
1160:             WITH loc_oPagina.lbl_4c_XEnd
1161:                 .Caption   = "x"
1162:                 .Top       = 275
1163:                 .Left      = 225
1164:                 .Width     = 8

*-- Linhas 1449 a 1470:
1449:                 .FontSize  = 8
1450:                 .ForeColor = RGB(90, 90, 90)
1451:                 .BackStyle = 0
1452:                 .Visible   = .T.
1453:             ENDWITH
1454:             loc_oPagina.AddObject("txt_4c_Text38", "TextBox")
1455:             WITH loc_oPagina.txt_4c_Text38
1456:                 .Value    = 0
1457:                 .Top      = 333
1458:                 .Left     = 298
1459:                 .Width    = 41
1460:                 .Height   = 18
1461:                 .FontName = "Tahoma"
1462:                 .FontSize = 8
1463:                 .Visible  = .T.
1464:             ENDWITH
1465:             loc_oPagina.AddObject("lbl_4c_LblNlin", "Label")
1466:             WITH loc_oPagina.lbl_4c_LblNlin
1467:                 .Caption   = "N" + CHR(176) + " Linhas"
1468:                 .Top       = 321
1469:                 .Left      = 369
1470:                 .Width     = 47

*-- Linhas 1573 a 1594:
1573:                 .FontSize  = 8
1574:                 .ForeColor = RGB(90, 90, 90)
1575:                 .BackStyle = 0
1576:                 .Visible   = .T.
1577:             ENDWITH
1578:             loc_oPagina.AddObject("txt_4c_Text42", "TextBox")
1579:             WITH loc_oPagina.txt_4c_Text42
1580:                 .Value    = 0
1581:                 .Top      = 335
1582:                 .Left     = 605
1583:                 .Width    = 41
1584:                 .Height   = 18
1585:                 .FontName = "Tahoma"
1586:                 .FontSize = 8
1587:                 .Visible  = .T.
1588:             ENDWITH
1589: 
1590:             *-- Shape4: separador top=354+29=383
1591:             loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1592:             WITH loc_oPagina.shp_4c_Shape4
1593:                 .Top           = 383
1594:                 .Left          = 173

*-- Linhas 1782 a 2212:
1782:                 ENDWITH
1783:             ENDWITH
1784: 
1785:             *-- BINDEVENTs da Page2
1786:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1787:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1788: 
1789:             THIS.TornarControlesVisiveis(loc_oPagina)
1790: 
1791:         CATCH TO loException
1792:             MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")
1793:         ENDTRY
1794:     ENDPROC
1795: 
1796:     *==========================================================================
1797:     * CarregarLista - Carrega e vincula dados na grade Page1
1798:     *==========================================================================
1799:     PROCEDURE CarregarLista()
1800:         LOCAL loc_lResultado, loc_oGrid
1801:         loc_lResultado = .F.
1802: 
1803:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1804:             loc_lResultado = .T.
1805:         ELSE
1806:             TRY
1807:                 IF !THIS.this_oBusinessObject.Buscar("")
1808:                     loc_lResultado = .F.
1809:                 ELSE
1810:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1811:                     loc_oGrid.ColumnCount = 1
1812:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1813:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1814:                     loc_oGrid.Column1.Width             = 100
1815:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1816:                     THIS.FormatarGridLista(loc_oGrid)
1817:                     loc_lResultado = .T.
1818:                 ENDIF
1819:             CATCH TO loException
1820:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
1821:                 loc_lResultado = .F.
1822:             ENDTRY
1823:         ENDIF
1824: 
1825:         RETURN loc_lResultado
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1830:     *==========================================================================
1831:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1832:         LOCAL loc_lResultado
1833:         loc_lResultado = .F.
1834: 
1835:         TRY
1836:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1837:                 loc_lResultado = .F.
1838:             ELSE
1839:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1840:                 IF par_nPagina = 1
1841:                     THIS.this_cModoAtual = "LISTA"
1842:                     THIS.CarregarLista()
1843:                 ENDIF
1844:                 loc_lResultado = .T.
1845:             ENDIF
1846:         CATCH TO loException
1847:             MsgErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
1848:         ENDTRY
1849: 
1850:         RETURN loc_lResultado
1851:     ENDPROC
1852: 
1853:     *==========================================================================
1854:     * BtnIncluirClick - Incluir nova serie (navega para Page2)
1855:     *==========================================================================
1856:     PROCEDURE BtnIncluirClick()
1857:         THIS.this_oBusinessObject.NovoRegistro()
1858:         THIS.this_cModoAtual = "INCLUIR"
1859:         THIS.pgf_4c_Paginas.ActivePage = 2
1860:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1861:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1862:         ELSE
1863:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1864:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1865:             ENDIF
1866:         ENDIF
1867:     ENDPROC
1868: 
1869:     *==========================================================================
1870:     * BtnVisualizarClick - Visualizar serie selecionada (somente leitura)
1871:     *==========================================================================
1872:     PROCEDURE BtnVisualizarClick()
1873:         LOCAL loc_cSeries
1874:         loc_cSeries = ""
1875: 
1876:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1877:             SELECT cursor_4c_Dados
1878:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1879:         ENDIF
1880: 
1881:         IF EMPTY(loc_cSeries)
1882:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1883:             RETURN
1884:         ENDIF
1885: 
1886:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1887:             THIS.this_cModoAtual = "VISUALIZAR"
1888:             THIS.BOParaForm()
1889:             THIS.pgf_4c_Paginas.ActivePage = 2
1890:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1891:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1892:             ENDIF
1893:         ENDIF
1894:     ENDPROC
1895: 
1896:     *==========================================================================
1897:     * BtnAlterarClick - Alterar serie selecionada
1898:     *==========================================================================
1899:     PROCEDURE BtnAlterarClick()
1900:         LOCAL loc_cSeries
1901:         loc_cSeries = ""
1902: 
1903:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1904:             SELECT cursor_4c_Dados
1905:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1906:         ENDIF
1907: 
1908:         IF EMPTY(loc_cSeries)
1909:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1910:             RETURN
1911:         ENDIF
1912: 
1913:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1914:             THIS.this_oBusinessObject.EditarRegistro()
1915:             THIS.this_cModoAtual = "ALTERAR"
1916:             THIS.BOParaForm()
1917:             THIS.pgf_4c_Paginas.ActivePage = 2
1918:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Text5", 5)
1919:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Text5.SetFocus
1920:             ELSE
1921:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1922:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1923:                 ENDIF
1924:             ENDIF
1925:         ENDIF
1926:     ENDPROC
1927: 
1928:     *==========================================================================
1929:     * BtnExcluirClick - Excluir serie selecionada
1930:     *==========================================================================
1931:     PROCEDURE BtnExcluirClick()
1932:         LOCAL loc_cSeries, loc_lResultado
1933:         loc_cSeries  = ""
1934:         loc_lResultado = .F.
1935: 
1936:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1937:             SELECT cursor_4c_Dados
1938:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1939:         ENDIF
1940: 
1941:         IF EMPTY(loc_cSeries)
1942:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1943:             RETURN
1944:         ENDIF
1945: 
1946:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da s" + CHR(233) + "rie '" + ;
1947:                        loc_cSeries + "'?", "Confirmar Exclus" + CHR(227) + "o")
1948:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1949:                 loc_lResultado = THIS.this_oBusinessObject.Excluir()
1950:                 IF loc_lResultado
1951:                     MsgSucesso("S" + CHR(233) + "rie exclu" + CHR(237) + "da com sucesso!")
1952:                     THIS.CarregarLista()
1953:                 ENDIF
1954:             ENDIF
1955:         ENDIF
1956:     ENDPROC
1957: 
1958:     *==========================================================================
1959:     * BtnBuscarClick - Buscar/filtrar series (navega para Page2 em modo BUSCAR)
1960:     *==========================================================================
1961:     PROCEDURE BtnBuscarClick()
1962:         THIS.this_oBusinessObject.NovoRegistro()
1963:         THIS.this_cModoAtual = "BUSCAR"
1964:         THIS.pgf_4c_Paginas.ActivePage = 2
1965:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1966:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value = ""
1967:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1968:         ELSE
1969:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1970:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1971:             ENDIF
1972:         ENDIF
1973:     ENDPROC
1974: 
1975:     *==========================================================================
1976:     * BtnEncerrarClick - Fecha o formulario
1977:     *==========================================================================
1978:     PROCEDURE BtnEncerrarClick()
1979:         THIS.Release()
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * BtnSalvarClick - Confirmar na Page2 (salva ou busca conforme modo)
1984:     *==========================================================================
1985:     PROCEDURE BtnSalvarClick()
1986:         LOCAL loc_lResultado, loc_cFiltro
1987:         loc_lResultado = .F.
1988:         loc_cFiltro    = ""
1989: 
1990:         IF THIS.this_cModoAtual = "BUSCAR"
1991:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1992:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
1993:             ENDIF
1994:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1995:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1996:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
1997:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
1999:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2000:                 THIS.this_cModoAtual = "LISTA"
2001:                 THIS.pgf_4c_Paginas.Visible = .T.
2002:                 THIS.pgf_4c_Paginas.ActivePage = 1
2003:             ENDIF
2004:             RETURN
2005:         ENDIF
2006: 
2007:         IF INLIST(THIS.this_cModoAtual, "VISUALIZAR")
2008:             THIS.this_cModoAtual = "LISTA"
2009:             THIS.AlternarPagina(1)
2010:             RETURN
2011:         ENDIF
2012: 
2013:         THIS.FormParaBO()
2014: 
2015:         loc_lResultado = THIS.this_oBusinessObject.Salvar()
2016:         IF loc_lResultado
2017:             MsgSucesso("Registro salvo com sucesso!")
2018:             THIS.this_cModoAtual = "LISTA"
2019:             THIS.AlternarPagina(1)
2020:         ENDIF
2021:     ENDPROC
2022: 
2023:     *==========================================================================
2024:     * BtnCancelarClick - Cancelar na Page2 e voltar para lista
2025:     *==========================================================================
2026:     PROCEDURE BtnCancelarClick()
2027:         THIS.this_cModoAtual = "LISTA"
2028:         THIS.AlternarPagina(1)
2029:     ENDPROC
2030: 
2031:     *==========================================================================
2032:     * BtnCopiarClick - Exibe painel flutuante para copiar serie selecionada
2033:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.Copia.Click
2034:     *==========================================================================
2035:     PROCEDURE BtnCopiarClick()
2036:         LOCAL loc_oPg1, loc_cSeries
2037:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
2038:         loc_cSeries = ""
2039: 
2040:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2041:             SELECT cursor_4c_Dados
2042:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
2043:         ENDIF
2044: 
2045:         IF EMPTY(loc_cSeries)
2046:             MsgAviso("Selecione uma s" + CHR(233) + "rie para copiar.", "Aviso")
2047:             RETURN
2048:         ENDIF
2049: 
2050:         *-- Desabilitar controles durante a copia (como no legado)
2051:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2052:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2053:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2054:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2055: 
2056:         *-- Preencher e exibir painel
2057:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2058:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2059:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2060:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2061:     ENDPROC
2062: 
2063:     *==========================================================================
2064:     * BtnOKCopiarClick - Executa copia da serie
2065:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2066:     *==========================================================================
2067:     PROCEDURE BtnOKCopiarClick()
2068:         LOCAL loc_oPg1, loc_cSerieOrigem, loc_cSerieDestino
2069:         LOCAL loc_cSQLCheck, loc_nCheck, loc_lResultado
2070:         loc_oPg1          = THIS.pgf_4c_Paginas.Page1
2071:         loc_cSerieOrigem  = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value)
2072:         loc_cSerieDestino = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
2073:         loc_lResultado    = .F.
2074: 
2075:         IF EMPTY(loc_cSerieDestino)
2076:             MsgAviso("Informe a s" + CHR(233) + "rie de Destino...", "Aviso")
2077:             loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2078:             RETURN
2079:         ENDIF
2080: 
2081:         *-- Verificar se destino ja existe em SigCnFDU
2082:         loc_cSQLCheck = "SELECT 1 AS existe FROM SigCnFDU WHERE series = " + ;
2083:                         EscaparSQL(loc_cSerieDestino)
2084:         loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_CopiaChk")
2085:         IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_CopiaChk") > 0
2086:             MsgAviso("A s" + CHR(233) + "rie de Destino j" + CHR(225) + ;
2087:                      " est" + CHR(225) + " cadastrada...", "Aviso")
2088:             IF USED("cursor_4c_CopiaChk")
2089:                 USE IN cursor_4c_CopiaChk
2090:             ENDIF
2091:             loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2092:             RETURN
2093:         ENDIF
2094:         IF USED("cursor_4c_CopiaChk")
2095:             USE IN cursor_4c_CopiaChk
2096:         ENDIF
2097: 
2098:         *-- Copiar: carregar propriedades da origem, criar novo com serie destino
2099:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSerieOrigem)
2100:             THIS.this_oBusinessObject.NovoRegistro()
2101:             THIS.this_oBusinessObject.this_cSeries = loc_cSerieDestino
2102:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
2103:             IF loc_lResultado
2104:                 MsgSucesso("S" + CHR(233) + "rie copiada com sucesso!")
2105:                 THIS.BtnCancelarCopiarClick()
2106:                 THIS.CarregarLista()
2107:             ENDIF
2108:         ENDIF
2109:     ENDPROC
2110: 
2111:     *==========================================================================
2112:     * BtnCancelarCopiarClick - Cancela copia e restaura controles
2113:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.Cancela.Click
2114:     *==========================================================================
2115:     PROCEDURE BtnCancelarCopiarClick()
2116:         LOCAL loc_oPg1
2117:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2118: 
2119:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2120:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2121:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2122:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2123:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2124:         loc_oPg1.grd_4c_Lista.SetFocus
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2129:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2130:     * Tabela SigCdSer (series disponiveis)
2131:     *==========================================================================
2132:     PROCEDURE ValidarSerieDestino(par_nKeyCode, par_nShiftAltCtrl)
2133:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca
2134:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2135:         loc_cSerieDest = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
2136: 
2137:         IF EMPTY(loc_cSerieDest)
2138:             RETURN
2139:         ENDIF
2140: 
2141:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2142:             "SigCdSer", "cursor_4c_BuscaSer", "cods", loc_cSerieDest, ;
2143:             "S" + CHR(233) + "ries")
2144: 
2145:         IF VARTYPE(loc_oBusca) = "O"
2146:             IF !loc_oBusca.this_lAchouRegistro
2147:                 loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2148:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2149:                 loc_oBusca.Show()
2150: 
2151:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2152:                     loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value = ;
2153:                         ALLTRIM(cursor_4c_BuscaSer.cods)
2154:                 ENDIF
2155:             ENDIF
2156:             loc_oBusca.Release()
2157:         ENDIF
2158: 
2159:         IF USED("cursor_4c_BuscaSer")
2160:             USE IN cursor_4c_BuscaSer
2161:         ENDIF
2162:     ENDPROC
2163: 
2164:     *==========================================================================
2165:     * FormParaBO - Transfere campos de Page2 para o BO
2166:     * Implementacao completa adicionada nas Fases 5-6
2167:     *==========================================================================
2168:     PROCEDURE FormParaBO()
2169:         LOCAL loc_oPg2
2170:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2171: 
2172:         *-- Serie (PK): apenas no modo INCLUIR
2173:         IF THIS.this_cModoAtual = "INCLUIR"
2174:             IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2175:                 THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg2.txt_4c_Series.Value)
2176:             ENDIF
2177:         ENDIF
2178: 
2179:         *-- Cabecalho: Data Emissao
2180:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2181:             THIS.this_oBusinessObject.this_nNlnDtDocs = loc_oPg2.txt_4c_Text5.Value
2182:         ENDIF
2183:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2184:             THIS.this_oBusinessObject.this_nNclDtDocs = loc_oPg2.txt_4c_Text6.Value
2185:         ENDIF
2186: 
2187:         *-- Cabecalho: Nota Fiscal
2188:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2189:             THIS.this_oBusinessObject.this_nNlnNotas = loc_oPg2.txt_4c_Text1.Value
2190:         ENDIF
2191:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2192:             THIS.this_oBusinessObject.this_nNclNotas = loc_oPg2.txt_4c_Text2.Value
2193:         ENDIF
2194: 
2195:         *-- Cabecalho: Valor da Duplicata
2196:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2197:             THIS.this_oBusinessObject.this_nNlnVlDocs = loc_oPg2.txt_4c_Text9.Value
2198:         ENDIF
2199:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2200:             THIS.this_oBusinessObject.this_nNclVlDocs = loc_oPg2.txt_4c_Text10.Value
2201:         ENDIF
2202: 
2203:         *-- Cabecalho: N da Duplicata
2204:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2205:             THIS.this_oBusinessObject.this_nNlnNrDocs = loc_oPg2.txt_4c_Text7.Value
2206:         ENDIF
2207:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2208:             THIS.this_oBusinessObject.this_nNclNrDocs = loc_oPg2.txt_4c_Text8.Value
2209:         ENDIF
2210: 
2211:         *-- Cabecalho: Vencimento
2212:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)

*-- Linhas 2255 a 2276:
2255:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2256:             THIS.this_oBusinessObject.this_nNcPracas = loc_oPg2.txt_4c_Text33.Value
2257:         ENDIF
2258: 
2259:         *-- Endereco do Sacado
2260:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2261:             THIS.this_oBusinessObject.this_nNlnEndCobs = loc_oPg2.txt_4c_Text19.Value
2262:         ENDIF
2263:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2264:             THIS.this_oBusinessObject.this_nNclEndCobs = loc_oPg2.txt_4c_Text20.Value
2265:         ENDIF
2266:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2267:             THIS.this_oBusinessObject.this_nNlnBaiCobs = loc_oPg2.txt_4c_Text21.Value
2268:         ENDIF
2269:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2270:             THIS.this_oBusinessObject.this_nNclBaiCobs = loc_oPg2.txt_4c_Text22.Value
2271:         ENDIF
2272:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2273:             THIS.this_oBusinessObject.this_nNlnCepCobs = loc_oPg2.txt_4c_Text27.Value
2274:         ENDIF
2275:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2276:             THIS.this_oBusinessObject.this_nNclCepCobs = loc_oPg2.txt_4c_Text28.Value

*-- Linhas 2293 a 2380:
2293:             THIS.this_oBusinessObject.this_nNlObs = loc_oPg2.txt_4c_Text36.Value
2294:         ENDIF
2295:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2296:             THIS.this_oBusinessObject.this_nNcObs = loc_oPg2.txt_4c_Text37.Value
2297:         ENDIF
2298:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2299:             THIS.this_oBusinessObject.this_nTamColObs = loc_oPg2.txt_4c_Text38.Value
2300:         ENDIF
2301:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2302:             THIS.this_oBusinessObject.this_nTamLinObs = loc_oPg2.txt_4c_Text39.Value
2303:         ENDIF
2304: 
2305:         *-- Valor NF
2306:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2307:             THIS.this_oBusinessObject.this_nLNota = loc_oPg2.txt_4c_Text34.Value
2308:         ENDIF
2309:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2310:             THIS.this_oBusinessObject.this_nCNota = loc_oPg2.txt_4c_Text35.Value
2311:         ENDIF
2312: 
2313:         *-- Codigo
2314:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2315:             THIS.this_oBusinessObject.this_nNlnCods = loc_oPg2.txt_4c_Text41.Value
2316:         ENDIF
2317:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2318:             THIS.this_oBusinessObject.this_nNclCods = loc_oPg2.txt_4c_Text42.Value
2319:         ENDIF
2320: 
2321:         *-- Impressora / Fonte
2322:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2323:             THIS.this_oBusinessObject.this_cNomeImps = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
2324:         ENDIF
2325:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2326:             THIS.this_oBusinessObject.this_cFontePdrs = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
2327:         ENDIF
2328:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2329:             THIS.this_oBusinessObject.this_nTamFontes = loc_oPg2.txt_4c_Text31.Value
2330:         ENDIF
2331:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2332:             THIS.this_oBusinessObject.this_cTamFolhas = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
2333:         ENDIF
2334:     ENDPROC
2335: 
2336:     *==========================================================================
2337:     * BOParaForm - Transfere propriedades do BO para os campos de Page2
2338:     * Implementacao completa adicionada nas Fases 5-6
2339:     *==========================================================================
2340:     PROCEDURE BOParaForm()
2341:         LOCAL loc_oPg2
2342:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2343: 
2344:         *-- Serie (PK)
2345:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2346:             loc_oPg2.txt_4c_Series.Value = THIS.this_oBusinessObject.this_cSeries
2347:         ENDIF
2348: 
2349:         *-- Cabecalho: Data Emissao
2350:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2351:             loc_oPg2.txt_4c_Text5.Value = THIS.this_oBusinessObject.this_nNlnDtDocs
2352:         ENDIF
2353:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2354:             loc_oPg2.txt_4c_Text6.Value = THIS.this_oBusinessObject.this_nNclDtDocs
2355:         ENDIF
2356: 
2357:         *-- Cabecalho: Nota Fiscal
2358:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2359:             loc_oPg2.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nNlnNotas
2360:         ENDIF
2361:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2362:             loc_oPg2.txt_4c_Text2.Value = THIS.this_oBusinessObject.this_nNclNotas
2363:         ENDIF
2364: 
2365:         *-- Cabecalho: Valor da Duplicata
2366:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2367:             loc_oPg2.txt_4c_Text9.Value = THIS.this_oBusinessObject.this_nNlnVlDocs
2368:         ENDIF
2369:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2370:             loc_oPg2.txt_4c_Text10.Value = THIS.this_oBusinessObject.this_nNclVlDocs
2371:         ENDIF
2372: 
2373:         *-- Cabecalho: N da Duplicata
2374:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2375:             loc_oPg2.txt_4c_Text7.Value = THIS.this_oBusinessObject.this_nNlnNrDocs
2376:         ENDIF
2377:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2378:             loc_oPg2.txt_4c_Text8.Value = THIS.this_oBusinessObject.this_nNclNrDocs
2379:         ENDIF
2380: 

*-- Linhas 2425 a 2446:
2425:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2426:             loc_oPg2.txt_4c_Text33.Value = THIS.this_oBusinessObject.this_nNcPracas
2427:         ENDIF
2428: 
2429:         *-- Endereco do Sacado
2430:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2431:             loc_oPg2.txt_4c_Text19.Value = THIS.this_oBusinessObject.this_nNlnEndCobs
2432:         ENDIF
2433:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2434:             loc_oPg2.txt_4c_Text20.Value = THIS.this_oBusinessObject.this_nNclEndCobs
2435:         ENDIF
2436:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2437:             loc_oPg2.txt_4c_Text21.Value = THIS.this_oBusinessObject.this_nNlnBaiCobs
2438:         ENDIF
2439:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2440:             loc_oPg2.txt_4c_Text22.Value = THIS.this_oBusinessObject.this_nNclBaiCobs
2441:         ENDIF
2442:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2443:             loc_oPg2.txt_4c_Text27.Value = THIS.this_oBusinessObject.this_nNlnCepCobs
2444:         ENDIF
2445:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2446:             loc_oPg2.txt_4c_Text28.Value = THIS.this_oBusinessObject.this_nNclCepCobs

*-- Linhas 2463 a 2550:
2463:             loc_oPg2.txt_4c_Text36.Value = THIS.this_oBusinessObject.this_nNlObs
2464:         ENDIF
2465:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2466:             loc_oPg2.txt_4c_Text37.Value = THIS.this_oBusinessObject.this_nNcObs
2467:         ENDIF
2468:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2469:             loc_oPg2.txt_4c_Text38.Value = THIS.this_oBusinessObject.this_nTamColObs
2470:         ENDIF
2471:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2472:             loc_oPg2.txt_4c_Text39.Value = THIS.this_oBusinessObject.this_nTamLinObs
2473:         ENDIF
2474: 
2475:         *-- Valor NF
2476:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2477:             loc_oPg2.txt_4c_Text34.Value = THIS.this_oBusinessObject.this_nLNota
2478:         ENDIF
2479:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2480:             loc_oPg2.txt_4c_Text35.Value = THIS.this_oBusinessObject.this_nCNota
2481:         ENDIF
2482: 
2483:         *-- Codigo
2484:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2485:             loc_oPg2.txt_4c_Text41.Value = THIS.this_oBusinessObject.this_nNlnCods
2486:         ENDIF
2487:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2488:             loc_oPg2.txt_4c_Text42.Value = THIS.this_oBusinessObject.this_nNclCods
2489:         ENDIF
2490: 
2491:         *-- Impressora / Fonte
2492:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2493:             loc_oPg2.txt_4c_Text29.Value = THIS.this_oBusinessObject.this_cNomeImps
2494:         ENDIF
2495:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2496:             loc_oPg2.txt_4c_Text30.Value = THIS.this_oBusinessObject.this_cFontePdrs
2497:         ENDIF
2498:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2499:             loc_oPg2.txt_4c_Text31.Value = THIS.this_oBusinessObject.this_nTamFontes
2500:         ENDIF
2501:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2502:             loc_oPg2.txt_4c_Text40.Value = THIS.this_oBusinessObject.this_cTamFolhas
2503:         ENDIF
2504:     ENDPROC
2505: 
2506:     *==========================================================================
2507:     * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
2508:     * VISUALIZAR: todos ReadOnly / INCLUIR+ALTERAR: editaveis
2509:     *==========================================================================
2510:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2511:         LOCAL loc_oPg2, loc_lRO
2512:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2513:         loc_lRO  = !(par_lHabilitar = .T.)
2514: 
2515:         *-- Serie (PK) so editavel no modo INCLUIR
2516:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2517:             loc_oPg2.txt_4c_Series.ReadOnly = !(par_lHabilitar = .T. AND THIS.this_cModoAtual = "INCLUIR")
2518:         ENDIF
2519: 
2520:         *-- Cabecalho: Data Emissao, Nota Fiscal, Valor Duplicata, Nr Duplicata, Vencimento
2521:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",  5)
2522:             loc_oPg2.txt_4c_Text5.ReadOnly  = loc_lRO
2523:         ENDIF
2524:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",  5)
2525:             loc_oPg2.txt_4c_Text6.ReadOnly  = loc_lRO
2526:         ENDIF
2527:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",  5)
2528:             loc_oPg2.txt_4c_Text1.ReadOnly  = loc_lRO
2529:         ENDIF
2530:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",  5)
2531:             loc_oPg2.txt_4c_Text2.ReadOnly  = loc_lRO
2532:         ENDIF
2533:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",  5)
2534:             loc_oPg2.txt_4c_Text9.ReadOnly  = loc_lRO
2535:         ENDIF
2536:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2537:             loc_oPg2.txt_4c_Text10.ReadOnly = loc_lRO
2538:         ENDIF
2539:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",  5)
2540:             loc_oPg2.txt_4c_Text7.ReadOnly  = loc_lRO
2541:         ENDIF
2542:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",  5)
2543:             loc_oPg2.txt_4c_Text8.ReadOnly  = loc_lRO
2544:         ENDIF
2545:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",  5)
2546:             loc_oPg2.txt_4c_Text3.ReadOnly  = loc_lRO
2547:         ENDIF
2548:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",  5)
2549:             loc_oPg2.txt_4c_Text4.ReadOnly  = loc_lRO
2550:         ENDIF

*-- Linhas 2580 a 2601:
2580:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2581:             loc_oPg2.txt_4c_Text33.ReadOnly = loc_lRO
2582:         ENDIF
2583: 
2584:         *-- Endereco do Sacado
2585:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2586:             loc_oPg2.txt_4c_Text19.ReadOnly = loc_lRO
2587:         ENDIF
2588:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2589:             loc_oPg2.txt_4c_Text20.ReadOnly = loc_lRO
2590:         ENDIF
2591:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2592:             loc_oPg2.txt_4c_Text21.ReadOnly = loc_lRO
2593:         ENDIF
2594:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2595:             loc_oPg2.txt_4c_Text22.ReadOnly = loc_lRO
2596:         ENDIF
2597:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2598:             loc_oPg2.txt_4c_Text27.ReadOnly = loc_lRO
2599:         ENDIF
2600:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2601:             loc_oPg2.txt_4c_Text28.ReadOnly = loc_lRO

*-- Linhas 2618 a 2700:
2618:             loc_oPg2.txt_4c_Text36.ReadOnly = loc_lRO
2619:         ENDIF
2620:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2621:             loc_oPg2.txt_4c_Text37.ReadOnly = loc_lRO
2622:         ENDIF
2623:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2624:             loc_oPg2.txt_4c_Text38.ReadOnly = loc_lRO
2625:         ENDIF
2626:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2627:             loc_oPg2.txt_4c_Text39.ReadOnly = loc_lRO
2628:         ENDIF
2629:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2630:             loc_oPg2.txt_4c_Text34.ReadOnly = loc_lRO
2631:         ENDIF
2632:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2633:             loc_oPg2.txt_4c_Text35.ReadOnly = loc_lRO
2634:         ENDIF
2635:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2636:             loc_oPg2.txt_4c_Text41.ReadOnly = loc_lRO
2637:         ENDIF
2638:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2639:             loc_oPg2.txt_4c_Text42.ReadOnly = loc_lRO
2640:         ENDIF
2641: 
2642:         *-- Impressora / Fonte / Tamanho / Folha
2643:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2644:             loc_oPg2.txt_4c_Text29.ReadOnly = loc_lRO
2645:         ENDIF
2646:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2647:             loc_oPg2.txt_4c_Text30.ReadOnly = loc_lRO
2648:         ENDIF
2649:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2650:             loc_oPg2.txt_4c_Text31.ReadOnly = loc_lRO
2651:         ENDIF
2652:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2653:             loc_oPg2.txt_4c_Text40.ReadOnly = loc_lRO
2654:         ENDIF
2655:     ENDPROC
2656: 
2657:     *==========================================================================
2658:     * LimparCampos - Zera/limpa todos os campos da Page2
2659:     *==========================================================================
2660:     PROTECTED PROCEDURE LimparCampos()
2661:         LOCAL loc_oPg2
2662:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2663: 
2664:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series",  5)
2665:             loc_oPg2.txt_4c_Series.Value  = ""
2666:         ENDIF
2667:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",   5)
2668:             loc_oPg2.txt_4c_Text1.Value   = 0
2669:         ENDIF
2670:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",   5)
2671:             loc_oPg2.txt_4c_Text2.Value   = 0
2672:         ENDIF
2673:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",   5)
2674:             loc_oPg2.txt_4c_Text3.Value   = 0
2675:         ENDIF
2676:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",   5)
2677:             loc_oPg2.txt_4c_Text4.Value   = 0
2678:         ENDIF
2679:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",   5)
2680:             loc_oPg2.txt_4c_Text5.Value   = 0
2681:         ENDIF
2682:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",   5)
2683:             loc_oPg2.txt_4c_Text6.Value   = 0
2684:         ENDIF
2685:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",   5)
2686:             loc_oPg2.txt_4c_Text7.Value   = 0
2687:         ENDIF
2688:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",   5)
2689:             loc_oPg2.txt_4c_Text8.Value   = 0
2690:         ENDIF
2691:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",   5)
2692:             loc_oPg2.txt_4c_Text9.Value   = 0
2693:         ENDIF
2694:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10",  5)
2695:             loc_oPg2.txt_4c_Text10.Value  = 0
2696:         ENDIF
2697:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text11",  5)
2698:             loc_oPg2.txt_4c_Text11.Value  = 0
2699:         ENDIF
2700:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text12",  5)

*-- Linhas 2716 a 2737:
2716:             loc_oPg2.txt_4c_Text17.Value  = 0
2717:         ENDIF
2718:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text18",  5)
2719:             loc_oPg2.txt_4c_Text18.Value  = 0
2720:         ENDIF
2721:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19",  5)
2722:             loc_oPg2.txt_4c_Text19.Value  = 0
2723:         ENDIF
2724:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20",  5)
2725:             loc_oPg2.txt_4c_Text20.Value  = 0
2726:         ENDIF
2727:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21",  5)
2728:             loc_oPg2.txt_4c_Text21.Value  = 0
2729:         ENDIF
2730:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22",  5)
2731:             loc_oPg2.txt_4c_Text22.Value  = 0
2732:         ENDIF
2733:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text23",  5)
2734:             loc_oPg2.txt_4c_Text23.Value  = 0
2735:         ENDIF
2736:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text24",  5)
2737:             loc_oPg2.txt_4c_Text24.Value  = 0

*-- Linhas 2773 a 2890:
2773:             loc_oPg2.txt_4c_Text36.Value  = 0
2774:         ENDIF
2775:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37",  5)
2776:             loc_oPg2.txt_4c_Text37.Value  = 0
2777:         ENDIF
2778:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38",  5)
2779:             loc_oPg2.txt_4c_Text38.Value  = 0
2780:         ENDIF
2781:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39",  5)
2782:             loc_oPg2.txt_4c_Text39.Value  = 0
2783:         ENDIF
2784:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40",  5)
2785:             loc_oPg2.txt_4c_Text40.Value  = ""
2786:         ENDIF
2787:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41",  5)
2788:             loc_oPg2.txt_4c_Text41.Value  = 0
2789:         ENDIF
2790:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42",  5)
2791:             loc_oPg2.txt_4c_Text42.Value  = 0
2792:         ENDIF
2793:     ENDPROC
2794: 
2795:     *==========================================================================
2796:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2797:     * VISUALIZAR: Confirmar disabled, Cancelar enabled
2798:     * INCLUIR/ALTERAR/BUSCAR: ambos habilitados
2799:     *==========================================================================
2800:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2801:         LOCAL loc_oPg2, loc_oBtnConf, loc_oBtnCanc
2802:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2803: 
2804:         IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2805:             RETURN
2806:         ENDIF
2807: 
2808:         loc_oBtnConf = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
2809:         loc_oBtnCanc = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
2810: 
2811:         DO CASE
2812:         CASE THIS.this_cModoAtual = "VISUALIZAR"
2813:             loc_oBtnConf.Caption = "OK"
2814:             loc_oBtnConf.Enabled = .T.
2815:             loc_oBtnCanc.Enabled = .T.
2816:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2817:             loc_oBtnConf.Caption = "Confirmar"
2818:             loc_oBtnConf.Enabled = .T.
2819:             loc_oBtnCanc.Enabled = .T.
2820:         CASE THIS.this_cModoAtual = "BUSCAR"
2821:             loc_oBtnConf.Caption = "Buscar"
2822:             loc_oBtnConf.Enabled = .T.
2823:             loc_oBtnCanc.Enabled = .T.
2824:         OTHERWISE
2825:             loc_oBtnConf.Caption = "Confirmar"
2826:             loc_oBtnConf.Enabled = .T.
2827:             loc_oBtnCanc.Enabled = .T.
2828:         ENDCASE
2829:     ENDPROC
2830: 
2831:     *==========================================================================
2832:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2833:     * Guarda o painel flutuante cnt_4c_CopiaFl como oculto
2834:     *==========================================================================
2835:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2836:         LOCAL loc_nI, loc_oObjeto, loc_cNome
2837: 
2838:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2839:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2840: 
2841:             IF VARTYPE(loc_oObjeto) = "O"
2842:                 loc_cNome = UPPER(loc_oObjeto.Name)
2843: 
2844:                 *-- Painel flutuante de copia deve permanecer oculto ate acionado
2845:                 IF INLIST(loc_cNome, "CNT_4C_COPIAFL")
2846:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2847:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2848:                     ENDIF
2849:                     LOOP
2850:                 ENDIF
2851: 
2852:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2853:                     loc_oObjeto.Visible = .T.
2854:                 ENDIF
2855: 
2856:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2857:                     LOCAL loc_nP
2858:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2859:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2860:                     ENDFOR
2861:                 ENDIF
2862: 
2863:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2864:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2865:                 ENDIF
2866:             ENDIF
2867:         ENDFOR
2868:     ENDPROC
2869: 
2870:     *==========================================================================
2871:     * FormatarGridLista - Formata visual da grade
2872:     *==========================================================================
2873:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2874:         WITH par_oGrid
2875:             .FontName = "Verdana"
2876:             .FontSize = 8
2877:         ENDWITH
2878:     ENDPROC
2879: 
2880:     *==========================================================================
2881:     * Destroy - Cleanup ao fechar o formulario
2882:     *==========================================================================
2883:     PROCEDURE Destroy()
2884:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2885:             THIS.this_oBusinessObject = .NULL.
2886:         ENDIF
2887:         DODEFAULT()
2888:     ENDPROC
2889: 
2890: ENDDEFINE


### BO (C:\4c\projeto\app\classes\DupBO.prg):
*==============================================================================
* DupBO.prg - Business Object para Configuracao de Duplicatas
* Tabela: SigCnFDU
* PK: series
* Fase 1/8: Propriedades e Init()
*==============================================================================

DEFINE CLASS DupBO AS BusinessBase

    *-- Chave primaria
    this_cSeries = ""

    *-- Cabecalho - posicoes de impressao da Nota Fiscal
    this_nNlnNotas   = 0
    this_nNclNotas   = 0
    this_nNlnDtVencs = 0
    this_nNclDtVencs = 0
    this_nNlnDtDocs  = 0
    this_nNclDtDocs  = 0
    this_nNlnNrDocs  = 0
    this_nNclNrDocs  = 0
    this_nNlnVlDocs  = 0
    this_nNclVlDocs  = 0

    *-- Sacado - posicoes de impressao do cliente/cobranca
    this_nNlnRazClis = 0
    this_nNclRazClis = 0
    this_nNlnCgcClis = 0
    this_nNclCgcClis = 0
    this_nNlnEndCobs = 0
    this_nNclEndCobs = 0
    this_nNlnBaiCobs = 0
    this_nNclBaiCobs = 0
    this_nNlnCidCobs = 0
    this_nNclCidCobs = 0
    this_nNlnEstCobs = 0
    this_nNclEstCobs = 0
    this_nNlnCepCobs = 0
    this_nNclCepCobs = 0
    this_nNlnEstClis = 0
    this_nNclEstClis = 0
    this_nNlnExtens  = 0
    this_nNclExtens  = 0
    this_nNlPracas   = 0
    this_nNcPracas   = 0

    *-- Observacao - posicoes e dimensoes
    this_nNlObs     = 0
    this_nNcObs     = 0
    this_nTamColObs = 0
    this_nTamLinObs = 0

    *-- Codigo - posicao de impressao
    this_nNlnCods   = 0
    this_nNclCods   = 0

    *-- Valor NF - posicao de impressao
    this_nLNota     = 0
    this_nCNota     = 0

    *-- Impressora e fonte
    this_cNomeImps  = ""
    this_cFontePdrs = ""
    this_nTamFontes = 0
    this_cTamFolhas = ""

    *-- Auditoria
    this_dDatas    = {}
    this_cHoras    = ""
    this_cUsuarios = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCnFDU"
        THIS.this_cCampoChave = "series"
        RETURN .T.
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSeries
    ENDFUNC

    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT series FROM SigCnFDU"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE series LIKE " + EscaparSQL(par_cFiltro + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY series"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSeries)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCnFDU WHERE series = " + EscaparSQL(par_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSeries      = ALLTRIM(TratarNulo(series,      "C"))
            THIS.this_nNlnNotas    = TratarNulo(nlnnotas,    "N")
            THIS.this_nNclNotas    = TratarNulo(nclnotas,    "N")
            THIS.this_nNlnDtVencs  = TratarNulo(nlndtvencs,  "N")
            THIS.this_nNclDtVencs  = TratarNulo(ncldtvencs,  "N")
            THIS.this_nNlnDtDocs   = TratarNulo(nlndtdocs,   "N")
            THIS.this_nNclDtDocs   = TratarNulo(ncldtdocs,   "N")
            THIS.this_nNlnNrDocs   = TratarNulo(nlnnrdocs,   "N")
            THIS.this_nNclNrDocs   = TratarNulo(nclnrdocs,   "N")
            THIS.this_nNlnVlDocs   = TratarNulo(nlnvldocs,   "N")
            THIS.this_nNclVlDocs   = TratarNulo(nclvldocs,   "N")
            THIS.this_nNlnRazClis  = TratarNulo(nlnrazclis,  "N")
            THIS.this_nNclRazClis  = TratarNulo(nclrazclis,  "N")
            THIS.this_nNlnCgcClis  = TratarNulo(nlncgcclis,  "N")
            THIS.this_nNclCgcClis  = TratarNulo(nclcgcclis,  "N")
            THIS.this_nNlnEndCobs  = TratarNulo(nlnendcobs,  "N")
            THIS.this_nNclEndCobs  = TratarNulo(nclendcobs,  "N")
            THIS.this_nNlnBaiCobs  = TratarNulo(nlnbaicobs,  "N")
            THIS.this_nNclBaiCobs  = TratarNulo(nclbaicobs,  "N")
            THIS.this_nNlnCidCobs  = TratarNulo(nlncidcobs,  "N")
            THIS.this_nNclCidCobs  = TratarNulo(nclcidcobs,  "N")
            THIS.this_nNlnEstCobs  = TratarNulo(nlnestcobs,  "N")
            THIS.this_nNclEstCobs  = TratarNulo(nclestcobs,  "N")
            THIS.this_nNlnCepCobs  = TratarNulo(nlncepcobs,  "N")
            THIS.this_nNclCepCobs  = TratarNulo(nclcepcobs,  "N")
            THIS.this_nNlnEstClis  = TratarNulo(nlnestclis,  "N")
            THIS.this_nNclEstClis  = TratarNulo(nclestclis,  "N")
            THIS.this_nNlnExtens   = TratarNulo(nlnextens,   "N")
            THIS.this_nNclExtens   = TratarNulo(nclextens,   "N")
            THIS.this_nNlPracas    = TratarNulo(nlpracas,    "N")
            THIS.this_nNcPracas    = TratarNulo(ncpracas,    "N")
            THIS.this_nNlObs       = TratarNulo(nlobs,       "N")
            THIS.this_nNcObs       = TratarNulo(ncobs,       "N")
            THIS.this_nTamColObs   = TratarNulo(tamcolobs,   "N")
            THIS.this_nTamLinObs   = TratarNulo(tamlinobs,   "N")
            THIS.this_nNlnCods     = TratarNulo(nlncods,     "N")
            THIS.this_nNclCods     = TratarNulo(nclcods,     "N")
            THIS.this_nLNota       = TratarNulo(lnota,       "N")
            THIS.this_nCNota       = TratarNulo(cnota,       "N")
            THIS.this_cNomeImps    = ALLTRIM(TratarNulo(cnomeimps,    "C"))
            THIS.this_cFontePdrs   = ALLTRIM(TratarNulo(cfontepdrs,   "C"))
            THIS.this_nTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cTamFolhas   = ALLTRIM(TratarNulo(ctamfolhas,   "C"))
            THIS.this_cHoras       = ALLTRIM(TratarNulo(choras,       "C"))
            THIS.this_cUsuarios    = ALLTRIM(TratarNulo(cusuarios,    "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCnFDU (" + ;
                "series, cemps, cnomeimps, cfontepdrs, ntamfontes, ctamfolhas," + ;
                " cusuarios, ddatas, choras, clocals," + ;
                " nlnnotas, nclnotas, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlnrazclis, nclrazclis," + ;
                " nlncgcclis, nclcgcclis, nlnendcobs, nclendcobs," + ;
                " nlnbaicobs, nclbaicobs, nlncidcobs, nclcidcobs," + ;
                " nlnestcobs, nclestcobs, nlncepcobs, nclcepcobs," + ;
                " nlnestclis, nclestclis, nlnextens, nclextens," + ;
                " nlpracas, ncpracas, nlobs, ncobs," + ;
                " tamcolobs, tamlinobs, nlncods, nclcods, lnota, cnota" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cSeries) + ", " + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(TIME()) + ", " + ;
                EscaparSQL("") + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nCNota)      + ;
                ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Insert")
                TABLEREVERT(.T., "cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCnFDU SET " + ;
                "cnomeimps  = " + EscaparSQL(LEFT(THIS.this_cNomeImps,  128)) + ", " + ;
                "cfontepdrs = " + EscaparSQL(LEFT(THIS.this_cFontePdrs, 128)) + ", " + ;
                "ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamFontes) + ", " + ;
                "ctamfolhas = " + EscaparSQL(LEFT(THIS.this_cTamFolhas,  80)) + ", " + ;
                "cusuarios  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   20)) + ", " + ;
                "ddatas = GETDATE(), " + ;
                "choras = " + EscaparSQL(TIME()) + ", " + ;
                "nlnnotas   = " + FormatarNumeroSQL(THIS.this_nNlnNotas)   + ", " + ;
                "nclnotas   = " + FormatarNumeroSQL(THIS.this_nNclNotas)   + ", " + ;
                "nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + ", " + ;
                "ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + ", " + ;
                "nlndtdocs  = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs)  + ", " + ;
                "ncldtdocs  = " + FormatarNumeroSQL(THIS.this_nNclDtDocs)  + ", " + ;
                "nlnnrdocs  = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs)  + ", " + ;
                "nclnrdocs  = " + FormatarNumeroSQL(THIS.this_nNclNrDocs)  + ", " + ;
                "nlnvldocs  = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs)  + ", " + ;
                "nclvldocs  = " + FormatarNumeroSQL(THIS.this_nNclVlDocs)  + ", " + ;
                "nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + ", " + ;
                "nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + ", " + ;
                "nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + ", " + ;
                "nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + ", " + ;
                "nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + ", " + ;
                "nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + ", " + ;
                "nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + ", " + ;
                "nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + ", " + ;
                "nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + ", " + ;
                "nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + ", " + ;
                "nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + ", " + ;
                "nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + ", " + ;
                "nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + ", " + ;
                "nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + ", " + ;
                "nlnestclis = " + FormatarNumeroSQL(THIS.this_nNlnEstClis) + ", " + ;
                "nclestclis = " + FormatarNumeroSQL(THIS.this_nNclEstClis) + ", " + ;
                "nlnextens  = " + FormatarNumeroSQL(THIS.this_nNlnExtens)  + ", " + ;
                "nclextens  = " + FormatarNumeroSQL(THIS.this_nNclExtens)  + ", " + ;
                "nlpracas   = " + FormatarNumeroSQL(THIS.this_nNlPracas)   + ", " + ;
                "ncpracas   = " + FormatarNumeroSQL(THIS.this_nNcPracas)   + ", " + ;
                "nlobs      = " + FormatarNumeroSQL(THIS.this_nNlObs)      + ", " + ;
                "ncobs      = " + FormatarNumeroSQL(THIS.this_nNcObs)      + ", " + ;
                "tamcolobs  = " + FormatarNumeroSQL(THIS.this_nTamColObs)  + ", " + ;
                "tamlinobs  = " + FormatarNumeroSQL(THIS.this_nTamLinObs)  + ", " + ;
                "nlncods    = " + FormatarNumeroSQL(THIS.this_nNlnCods)    + ", " + ;
                "nclcods    = " + FormatarNumeroSQL(THIS.this_nNclCods)    + ", " + ;
                "lnota      = " + FormatarNumeroSQL(THIS.this_nLNota)      + ", " + ;
                "cnota      = " + FormatarNumeroSQL(THIS.this_nCNota)      + ;
                " WHERE series = " + EscaparSQL(THIS.this_cSeries)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCnFDU WHERE series = " + EscaparSQL(THIS.this_cSeries)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

