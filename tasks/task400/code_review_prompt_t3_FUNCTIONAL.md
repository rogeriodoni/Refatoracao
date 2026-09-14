# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDup.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2897 linhas total):

*-- Linhas 26 a 152:
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
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68:                 loc_lSucesso = .T.
69:             ENDIF
70:         CATCH TO loException
71:             MsgErro("Erro ao inicializar formulario:" + CHR(13) + loException.Message, "Erro")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *==========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
79:     *==========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         TRY
82:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83:             WITH THIS.pgf_4c_Paginas
84:                 .PageCount  = 2
85:                 .Top        = -29
86:                 .Left       = 0
87:                 .Width      = THIS.Width
88:                 .Height     = THIS.Height + 29
89:                 .Tabs       = .F.
90:                 .TabStretch = 1
91:                 .Visible    = .T.
92:                 .Page1.Caption   = "Lista"
93:                 .Page1.BackColor = RGB(236, 236, 236)
94:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:                 .Page2.Caption   = "Dados"
96:                 .Page2.BackColor = RGB(236, 236, 236)
97:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             ENDWITH
99: 
100:             THIS.ConfigurarPaginaLista()
101:             THIS.ConfigurarPaginaDados()
102: 
103:         CATCH TO loException
104:             MsgErro("Erro ao configurar PageFrame:" + CHR(13) + loException.Message, "Erro")
105:         ENDTRY
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Configura Page1 completa
110:     * Cabecalho + botoes CRUD + Encerrar + grid + botao Copiar + painel flutuante
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         TRY
120:             *-- Container cabecalho (cntSombra no legado) - Top=2 dentro da Page
121:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
122:             WITH loc_oPagina.cnt_4c_Cabecalho
123:                 .Top         = 2
124:                 .Left        = 0
125:                 .Width       = THIS.Width
126:                 .Height      = 80
127:                 .BackColor   = RGB(100, 100, 100)
128:                 .BorderWidth = 0
129:                 .Visible     = .T.
130: 
131:                 .AddObject("lbl_4c_Sombra", "Label")
132:                 WITH .lbl_4c_Sombra
133:                     .Caption   = THIS.Caption
134:                     .Top       = 15
135:                     .Left      = 10
136:                     .Width     = THIS.Width
137:                     .Height    = 40
138:                     .FontName  = "Tahoma"
139:                     .FontSize  = 16
140:                     .FontBold  = .T.
141:                     .ForeColor = RGB(0, 0, 0)
142:                     .BackStyle = 0
143:                     .AutoSize  = .F.
144:                     .Visible   = .T.
145:                 ENDWITH
146: 
147:                 .AddObject("lbl_4c_Titulo", "Label")
148:                 WITH .lbl_4c_Titulo
149:                     .Caption   = THIS.Caption
150:                     .Top       = 18
151:                     .Left      = 10
152:                     .Width     = THIS.Width

*-- Linhas 374 a 419:
374:                 ENDWITH
375:             ENDWITH
376: 
377:             *-- Painel flutuante de copia de series (cntcopia no legado - Visible=.F.)
378:             *-- Top=270 = 241 (original) + 29 (compensacao PageFrame)
379:             *-- Nome "cnt_4c_CopiaFl" -> UPPER = "CNT_4C_COPIAFL" (guardado em TornarControlesVisiveis)
380:             loc_oPagina.AddObject("cnt_4c_CopiaFl", "Container")
381:             WITH loc_oPagina.cnt_4c_CopiaFl
382:                 .Top         = 270
383:                 .Left        = 335
384:                 .Width       = 317
385:                 .Height      = 123
386:                 .BackColor   = RGB(220, 220, 220)
387:                 .BorderWidth = 1
388:                 .Visible     = .F.
389: 
390:                 .AddObject("lbl_4c_LblSerieOrigem", "Label")
391:                 WITH .lbl_4c_LblSerieOrigem
392:                     .Caption   = "S" + CHR(233) + "rie Origem :"
393:                     .Top       = 40
394:                     .Left      = 29
395:                     .Width     = 72
396:                     .Height    = 15
397:                     .FontName  = "Tahoma"
398:                     .FontSize  = 8
399:                     .BackStyle = 0
400:                     .ForeColor = RGB(0, 0, 0)
401:                     .Visible   = .T.
402:                 ENDWITH
403: 
404:                 .AddObject("txt_4c_SeriesOrigem", "TextBox")
405:                 WITH .txt_4c_SeriesOrigem
406:                     .Top      = 36
407:                     .Left     = 103
408:                     .Width    = 34
409:                     .Height   = 24
410:                     .FontName = "Tahoma"
411:                     .FontSize = 8
412:                     .Value    = ""
413:                     .ReadOnly = .T.
414:                     .Visible  = .T.
415:                 ENDWITH
416: 
417:                 .AddObject("lbl_4c_LblSerieDestino", "Label")
418:                 WITH .lbl_4c_LblSerieDestino
419:                     .Caption   = "S" + CHR(233) + "rie Destino :"

*-- Linhas 475 a 542:
475:                 ENDWITH
476:             ENDWITH
477: 
478:             *-- BINDEVENTs da Page1
479:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,        "Click", THIS, "BtnIncluirClick")
480:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,     "Click", THIS, "BtnVisualizarClick")
481:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,        "Click", THIS, "BtnAlterarClick")
482:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,        "Click", THIS, "BtnExcluirClick")
483:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,         "Click", THIS, "BtnBuscarClick")
484:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,        "Click", THIS, "BtnEncerrarClick")
485:             BINDEVENT(loc_oPagina.cmd_4c_Copia,                        "Click", THIS, "BtnCopiarClick")
486:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_OKCopia,       "Click", THIS, "BtnOKCopiarClick")
487:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiarClick")
488:             BINDEVENT(loc_oPagina.cnt_4c_CopiaFl.txt_4c_SerieDestino,  "KeyPress", THIS, "ValidarSerieDestino")
489: 
490:             THIS.TornarControlesVisiveis(loc_oPagina)
491: 
492:         CATCH TO loException
493:             MsgErro("Erro ao configurar Page1:" + CHR(13) + loException.Message, "Erro")
494:         ENDTRY
495:     ENDPROC
496: 
497:     *==========================================================================
498:     * ConfigurarPaginaDados - Configura Page2 (Dados)
499:     * Fase 5: Serie, Cabecalho e primeira linha do Sacado
500:     * Fase 6: Segunda linha Sacado, Observacao e Impressora (a adicionar)
501:     *==========================================================================
502:     PROTECTED PROCEDURE ConfigurarPaginaDados()
503:         LOCAL loc_oPagina
504:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
505: 
506:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
507:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
508: 
509:         TRY
510:             *------------------------------------------------------------------
511:             * SERIE (PK) - txt_4c_Series: top=70+29=99 / Label40: top=72+29=101
512:             *------------------------------------------------------------------
513:             loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
514:             WITH loc_oPagina.lbl_4c_LblSerie
515:                 .Caption   = "S" + CHR(233) + "rie :"
516:                 .Top       = 101
517:                 .Left      = 185
518:                 .Width     = 37
519:                 .Height    = 15
520:                 .FontName  = "Tahoma"
521:                 .FontSize  = 8
522:                 .ForeColor = RGB(90, 90, 90)
523:                 .BackStyle = 0
524:                 .Visible   = .T.
525:             ENDWITH
526: 
527:             loc_oPagina.AddObject("txt_4c_Series", "TextBox")
528:             WITH loc_oPagina.txt_4c_Series
529:                 .Value    = ""
530:                 .Top      = 99
531:                 .Left     = 229
532:                 .Width    = 31
533:                 .Height   = 18
534:                 .FontName = "Tahoma"
535:                 .FontSize = 8
536:                 .Visible  = .T.
537:             ENDWITH
538: 
539:             *------------------------------------------------------------------
540:             * SECAO CABECALHO (linha/coluna impressao dados do documento)
541:             * Label27 top=103+29=132 / Shape1 top=119+29=148
542:             *------------------------------------------------------------------

*-- Linhas 1146 a 1167:
1146:                 .FontSize  = 8
1147:                 .ForeColor = RGB(90, 90, 90)
1148:                 .BackStyle = 0
1149:                 .Visible   = .T.
1150:             ENDWITH
1151:             loc_oPagina.AddObject("txt_4c_Text19", "TextBox")
1152:             WITH loc_oPagina.txt_4c_Text19
1153:                 .Value    = 0
1154:                 .Top      = 273
1155:                 .Left     = 183
1156:                 .Width    = 41
1157:                 .Height   = 18
1158:                 .FontName = "Tahoma"
1159:                 .FontSize = 8
1160:                 .Visible  = .T.
1161:             ENDWITH
1162:             loc_oPagina.AddObject("lbl_4c_XEnd", "Label")
1163:             WITH loc_oPagina.lbl_4c_XEnd
1164:                 .Caption   = "x"
1165:                 .Top       = 275
1166:                 .Left      = 225
1167:                 .Width     = 8

*-- Linhas 1452 a 1473:
1452:                 .FontSize  = 8
1453:                 .ForeColor = RGB(90, 90, 90)
1454:                 .BackStyle = 0
1455:                 .Visible   = .T.
1456:             ENDWITH
1457:             loc_oPagina.AddObject("txt_4c_Text38", "TextBox")
1458:             WITH loc_oPagina.txt_4c_Text38
1459:                 .Value    = 0
1460:                 .Top      = 333
1461:                 .Left     = 298
1462:                 .Width    = 41
1463:                 .Height   = 18
1464:                 .FontName = "Tahoma"
1465:                 .FontSize = 8
1466:                 .Visible  = .T.
1467:             ENDWITH
1468:             loc_oPagina.AddObject("lbl_4c_LblNlin", "Label")
1469:             WITH loc_oPagina.lbl_4c_LblNlin
1470:                 .Caption   = "N" + CHR(176) + " Linhas"
1471:                 .Top       = 321
1472:                 .Left      = 369
1473:                 .Width     = 47

*-- Linhas 1576 a 1597:
1576:                 .FontSize  = 8
1577:                 .ForeColor = RGB(90, 90, 90)
1578:                 .BackStyle = 0
1579:                 .Visible   = .T.
1580:             ENDWITH
1581:             loc_oPagina.AddObject("txt_4c_Text42", "TextBox")
1582:             WITH loc_oPagina.txt_4c_Text42
1583:                 .Value    = 0
1584:                 .Top      = 335
1585:                 .Left     = 605
1586:                 .Width    = 41
1587:                 .Height   = 18
1588:                 .FontName = "Tahoma"
1589:                 .FontSize = 8
1590:                 .Visible  = .T.
1591:             ENDWITH
1592: 
1593:             *-- Shape4: separador top=354+29=383
1594:             loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1595:             WITH loc_oPagina.shp_4c_Shape4
1596:                 .Top           = 383
1597:                 .Left          = 173

*-- Linhas 1785 a 2215:
1785:                 ENDWITH
1786:             ENDWITH
1787: 
1788:             *-- BINDEVENTs da Page2
1789:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1790:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1791: 
1792:             THIS.TornarControlesVisiveis(loc_oPagina)
1793: 
1794:         CATCH TO loException
1795:             MsgErro("Erro ao configurar Page2:" + CHR(13) + loException.Message, "Erro")
1796:         ENDTRY
1797:     ENDPROC
1798: 
1799:     *==========================================================================
1800:     * CarregarLista - Carrega e vincula dados na grade Page1
1801:     *==========================================================================
1802:     PROCEDURE CarregarLista()
1803:         LOCAL loc_lResultado, loc_oGrid
1804:         loc_lResultado = .F.
1805: 
1806:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1807:             loc_lResultado = .T.
1808:         ELSE
1809:             TRY
1810:                 IF !THIS.this_oBusinessObject.Buscar("")
1811:                     loc_lResultado = .F.
1812:                 ELSE
1813:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1814:                     loc_oGrid.ColumnCount = 1
1815:                     loc_oGrid.RecordSource              = "cursor_4c_Dados"
1816:                     loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.series"
1817:                     loc_oGrid.Column1.Width             = 100
1818:                     loc_oGrid.Column1.Header1.Caption   = "S" + CHR(233) + "rie"
1819:                     THIS.FormatarGridLista(loc_oGrid)
1820:                     loc_lResultado = .T.
1821:                 ENDIF
1822:             CATCH TO loException
1823:                 MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
1824:                 loc_lResultado = .F.
1825:             ENDTRY
1826:         ENDIF
1827: 
1828:         RETURN loc_lResultado
1829:     ENDPROC
1830: 
1831:     *==========================================================================
1832:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1833:     *==========================================================================
1834:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1835:         LOCAL loc_lResultado
1836:         loc_lResultado = .F.
1837: 
1838:         TRY
1839:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1840:                 loc_lResultado = .F.
1841:             ELSE
1842:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1843:                 IF par_nPagina = 1
1844:                     THIS.this_cModoAtual = "LISTA"
1845:                     THIS.CarregarLista()
1846:                 ENDIF
1847:                 loc_lResultado = .T.
1848:             ENDIF
1849:         CATCH TO loException
1850:             MsgErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
1851:         ENDTRY
1852: 
1853:         RETURN loc_lResultado
1854:     ENDPROC
1855: 
1856:     *==========================================================================
1857:     * BtnIncluirClick - Incluir nova serie (navega para Page2)
1858:     *==========================================================================
1859:     PROCEDURE BtnIncluirClick()
1860:         THIS.this_oBusinessObject.NovoRegistro()
1861:         THIS.this_cModoAtual = "INCLUIR"
1862:         THIS.pgf_4c_Paginas.ActivePage = 2
1863:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1864:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1865:         ELSE
1866:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1867:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1868:             ENDIF
1869:         ENDIF
1870:     ENDPROC
1871: 
1872:     *==========================================================================
1873:     * BtnVisualizarClick - Visualizar serie selecionada (somente leitura)
1874:     *==========================================================================
1875:     PROCEDURE BtnVisualizarClick()
1876:         LOCAL loc_cSeries
1877:         loc_cSeries = ""
1878: 
1879:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1880:             SELECT cursor_4c_Dados
1881:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1882:         ENDIF
1883: 
1884:         IF EMPTY(loc_cSeries)
1885:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1886:             RETURN
1887:         ENDIF
1888: 
1889:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1890:             THIS.this_cModoAtual = "VISUALIZAR"
1891:             THIS.BOParaForm()
1892:             THIS.pgf_4c_Paginas.ActivePage = 2
1893:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1894:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1895:             ENDIF
1896:         ENDIF
1897:     ENDPROC
1898: 
1899:     *==========================================================================
1900:     * BtnAlterarClick - Alterar serie selecionada
1901:     *==========================================================================
1902:     PROCEDURE BtnAlterarClick()
1903:         LOCAL loc_cSeries
1904:         loc_cSeries = ""
1905: 
1906:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1907:             SELECT cursor_4c_Dados
1908:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1909:         ENDIF
1910: 
1911:         IF EMPTY(loc_cSeries)
1912:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1917:             THIS.this_oBusinessObject.EditarRegistro()
1918:             THIS.this_cModoAtual = "ALTERAR"
1919:             THIS.BOParaForm()
1920:             THIS.pgf_4c_Paginas.ActivePage = 2
1921:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Text5", 5)
1922:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Text5.SetFocus
1923:             ELSE
1924:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1925:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1926:                 ENDIF
1927:             ENDIF
1928:         ENDIF
1929:     ENDPROC
1930: 
1931:     *==========================================================================
1932:     * BtnExcluirClick - Excluir serie selecionada
1933:     *==========================================================================
1934:     PROCEDURE BtnExcluirClick()
1935:         LOCAL loc_cSeries, loc_lResultado
1936:         loc_cSeries  = ""
1937:         loc_lResultado = .F.
1938: 
1939:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1940:             SELECT cursor_4c_Dados
1941:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
1942:         ENDIF
1943: 
1944:         IF EMPTY(loc_cSeries)
1945:             MsgAviso("Selecione uma s" + CHR(233) + "rie na lista.", "Aviso")
1946:             RETURN
1947:         ENDIF
1948: 
1949:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da s" + CHR(233) + "rie '" + ;
1950:                        loc_cSeries + "'?", "Confirmar Exclus" + CHR(227) + "o")
1951:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSeries)
1952:                 loc_lResultado = THIS.this_oBusinessObject.Excluir()
1953:                 IF loc_lResultado
1954:                     MsgSucesso("S" + CHR(233) + "rie exclu" + CHR(237) + "da com sucesso!")
1955:                     THIS.CarregarLista()
1956:                 ENDIF
1957:             ENDIF
1958:         ENDIF
1959:     ENDPROC
1960: 
1961:     *==========================================================================
1962:     * BtnBuscarClick - Buscar/filtrar series (navega para Page2 em modo BUSCAR)
1963:     *==========================================================================
1964:     PROCEDURE BtnBuscarClick()
1965:         THIS.this_oBusinessObject.NovoRegistro()
1966:         THIS.this_cModoAtual = "BUSCAR"
1967:         THIS.pgf_4c_Paginas.ActivePage = 2
1968:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1969:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value = ""
1970:             THIS.pgf_4c_Paginas.Page2.txt_4c_Series.SetFocus
1971:         ELSE
1972:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1973:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1974:             ENDIF
1975:         ENDIF
1976:     ENDPROC
1977: 
1978:     *==========================================================================
1979:     * BtnEncerrarClick - Fecha o formulario
1980:     *==========================================================================
1981:     PROCEDURE BtnEncerrarClick()
1982:         THIS.Release()
1983:     ENDPROC
1984: 
1985:     *==========================================================================
1986:     * BtnSalvarClick - Confirmar na Page2 (salva ou busca conforme modo)
1987:     *==========================================================================
1988:     PROCEDURE BtnSalvarClick()
1989:         LOCAL loc_lResultado, loc_cFiltro
1990:         loc_lResultado = .F.
1991:         loc_cFiltro    = ""
1992: 
1993:         IF THIS.this_cModoAtual = "BUSCAR"
1994:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Series", 5)
1995:                 loc_cFiltro = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Series.Value)
1996:             ENDIF
1997:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1998:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 1
1999:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource            = "cursor_4c_Dados"
2000:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.series"
2001:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "S" + CHR(233) + "rie"
2002:                 THIS.FormatarGridLista(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista)
2003:                 THIS.this_cModoAtual = "LISTA"
2004:                 THIS.pgf_4c_Paginas.Visible = .T.
2005:                 THIS.pgf_4c_Paginas.ActivePage = 1
2006:             ENDIF
2007:             RETURN
2008:         ENDIF
2009: 
2010:         IF INLIST(THIS.this_cModoAtual, "VISUALIZAR")
2011:             THIS.this_cModoAtual = "LISTA"
2012:             THIS.AlternarPagina(1)
2013:             RETURN
2014:         ENDIF
2015: 
2016:         THIS.FormParaBO()
2017: 
2018:         loc_lResultado = THIS.this_oBusinessObject.Salvar()
2019:         IF loc_lResultado
2020:             MsgSucesso("Registro salvo com sucesso!")
2021:             THIS.this_cModoAtual = "LISTA"
2022:             THIS.AlternarPagina(1)
2023:         ENDIF
2024:     ENDPROC
2025: 
2026:     *==========================================================================
2027:     * BtnCancelarClick - Cancelar na Page2 e voltar para lista
2028:     *==========================================================================
2029:     PROCEDURE BtnCancelarClick()
2030:         THIS.this_cModoAtual = "LISTA"
2031:         THIS.AlternarPagina(1)
2032:     ENDPROC
2033: 
2034:     *==========================================================================
2035:     * BtnCopiarClick - Exibe painel flutuante para copiar serie selecionada
2036:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.Copia.Click
2037:     *==========================================================================
2038:     PROCEDURE BtnCopiarClick()
2039:         LOCAL loc_oPg1, loc_cSeries
2040:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
2041:         loc_cSeries = ""
2042: 
2043:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2044:             SELECT cursor_4c_Dados
2045:             loc_cSeries = ALLTRIM(cursor_4c_Dados.series)
2046:         ENDIF
2047: 
2048:         IF EMPTY(loc_cSeries)
2049:             MsgAviso("Selecione uma s" + CHR(233) + "rie para copiar.", "Aviso")
2050:             RETURN
2051:         ENDIF
2052: 
2053:         *-- Desabilitar controles durante a copia (como no legado)
2054:         loc_oPg1.cnt_4c_Botoes.Enabled = .F.
2055:         loc_oPg1.grd_4c_Lista.Enabled  = .F.
2056:         loc_oPg1.cnt_4c_Saida.Enabled  = .F.
2057:         loc_oPg1.cmd_4c_Copia.Enabled  = .F.
2058: 
2059:         *-- Preencher e exibir painel
2060:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value  = loc_cSeries
2061:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value  = ""
2062:         loc_oPg1.cnt_4c_CopiaFl.Visible                    = .T.
2063:         loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2064:     ENDPROC
2065: 
2066:     *==========================================================================
2067:     * BtnOKCopiarClick - Executa copia da serie
2068:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.OK.Click
2069:     *==========================================================================
2070:     PROCEDURE BtnOKCopiarClick()
2071:         LOCAL loc_oPg1, loc_cSerieOrigem, loc_cSerieDestino
2072:         LOCAL loc_cSQLCheck, loc_nCheck, loc_lResultado
2073:         loc_oPg1          = THIS.pgf_4c_Paginas.Page1
2074:         loc_cSerieOrigem  = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SeriesOrigem.Value)
2075:         loc_cSerieDestino = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
2076:         loc_lResultado    = .F.
2077: 
2078:         IF EMPTY(loc_cSerieDestino)
2079:             MsgAviso("Informe a s" + CHR(233) + "rie de Destino...", "Aviso")
2080:             loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2081:             RETURN
2082:         ENDIF
2083: 
2084:         *-- Verificar se destino ja existe em SigCnFDU
2085:         loc_cSQLCheck = "SELECT 1 AS existe FROM SigCnFDU WHERE series = " + ;
2086:                         EscaparSQL(loc_cSerieDestino)
2087:         loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQLCheck, "cursor_4c_CopiaChk")
2088:         IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_CopiaChk") > 0
2089:             MsgAviso("A s" + CHR(233) + "rie de Destino j" + CHR(225) + ;
2090:                      " est" + CHR(225) + " cadastrada...", "Aviso")
2091:             IF USED("cursor_4c_CopiaChk")
2092:                 USE IN cursor_4c_CopiaChk
2093:             ENDIF
2094:             loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.SetFocus
2095:             RETURN
2096:         ENDIF
2097:         IF USED("cursor_4c_CopiaChk")
2098:             USE IN cursor_4c_CopiaChk
2099:         ENDIF
2100: 
2101:         *-- Copiar: carregar propriedades da origem, criar novo com serie destino
2102:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSerieOrigem)
2103:             THIS.this_oBusinessObject.NovoRegistro()
2104:             THIS.this_oBusinessObject.this_cSeries = loc_cSerieDestino
2105:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
2106:             IF loc_lResultado
2107:                 MsgSucesso("S" + CHR(233) + "rie copiada com sucesso!")
2108:                 THIS.BtnCancelarCopiarClick()
2109:                 THIS.CarregarLista()
2110:             ENDIF
2111:         ENDIF
2112:     ENDPROC
2113: 
2114:     *==========================================================================
2115:     * BtnCancelarCopiarClick - Cancela copia e restaura controles
2116:     * Logica baseada no legado: SIGCDDUP.Pagina.Lista.cntcopia.Cancela.Click
2117:     *==========================================================================
2118:     PROCEDURE BtnCancelarCopiarClick()
2119:         LOCAL loc_oPg1
2120:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2121: 
2122:         loc_oPg1.cnt_4c_Botoes.Enabled = .T.
2123:         loc_oPg1.grd_4c_Lista.Enabled  = .T.
2124:         loc_oPg1.cnt_4c_Saida.Enabled  = .T.
2125:         loc_oPg1.cmd_4c_Copia.Enabled  = .T.
2126:         loc_oPg1.cnt_4c_CopiaFl.Visible = .F.
2127:         loc_oPg1.grd_4c_Lista.SetFocus
2128:     ENDPROC
2129: 
2130:     *==========================================================================
2131:     * ValidarSerieDestino - Abre lookup de series ao sair do campo destino
2132:     * Baseado no legado: SIGCDDUP.Pagina.Lista.cntcopia.nomedest.Valid
2133:     * Tabela SigCdSer (series disponiveis)
2134:     *==========================================================================
2135:     PROCEDURE ValidarSerieDestino
2136:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2137:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
2138:             RETURN
2139:         ENDIF
2140:         LOCAL loc_oPg1, loc_cSerieDest, loc_oBusca
2141:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2142:         loc_cSerieDest = ALLTRIM(loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value)
2143: 
2144:         IF EMPTY(loc_cSerieDest)
2145:             RETURN
2146:         ENDIF
2147: 
2148:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2149:             "SigCdSer", "cursor_4c_BuscaSer", "cods", loc_cSerieDest, ;
2150:             "S" + CHR(233) + "ries")
2151: 
2152:         IF VARTYPE(loc_oBusca) = "O"
2153:             IF !loc_oBusca.this_lAchouRegistro
2154:                 loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
2155:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2156:                 loc_oBusca.Show()
2157: 
2158:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2159:                     loc_oPg1.cnt_4c_CopiaFl.txt_4c_SerieDestino.Value = ;
2160:                         ALLTRIM(cursor_4c_BuscaSer.cods)
2161:                 ENDIF
2162:             ENDIF
2163:             loc_oBusca.Release()
2164:         ENDIF
2165: 
2166:         IF USED("cursor_4c_BuscaSer")
2167:             USE IN cursor_4c_BuscaSer
2168:         ENDIF
2169:     ENDPROC
2170: 
2171:     *==========================================================================
2172:     * FormParaBO - Transfere campos de Page2 para o BO
2173:     * Implementacao completa adicionada nas Fases 5-6
2174:     *==========================================================================
2175:     PROCEDURE FormParaBO()
2176:         LOCAL loc_oPg2
2177:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2178: 
2179:         *-- Serie (PK): apenas no modo INCLUIR
2180:         IF THIS.this_cModoAtual = "INCLUIR"
2181:             IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2182:                 THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg2.txt_4c_Series.Value)
2183:             ENDIF
2184:         ENDIF
2185: 
2186:         *-- Cabecalho: Data Emissao
2187:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2188:             THIS.this_oBusinessObject.this_nNlnDtDocs = loc_oPg2.txt_4c_Text5.Value
2189:         ENDIF
2190:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2191:             THIS.this_oBusinessObject.this_nNclDtDocs = loc_oPg2.txt_4c_Text6.Value
2192:         ENDIF
2193: 
2194:         *-- Cabecalho: Nota Fiscal
2195:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2196:             THIS.this_oBusinessObject.this_nNlnNotas = loc_oPg2.txt_4c_Text1.Value
2197:         ENDIF
2198:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2199:             THIS.this_oBusinessObject.this_nNclNotas = loc_oPg2.txt_4c_Text2.Value
2200:         ENDIF
2201: 
2202:         *-- Cabecalho: Valor da Duplicata
2203:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2204:             THIS.this_oBusinessObject.this_nNlnVlDocs = loc_oPg2.txt_4c_Text9.Value
2205:         ENDIF
2206:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2207:             THIS.this_oBusinessObject.this_nNclVlDocs = loc_oPg2.txt_4c_Text10.Value
2208:         ENDIF
2209: 
2210:         *-- Cabecalho: N da Duplicata
2211:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2212:             THIS.this_oBusinessObject.this_nNlnNrDocs = loc_oPg2.txt_4c_Text7.Value
2213:         ENDIF
2214:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2215:             THIS.this_oBusinessObject.this_nNclNrDocs = loc_oPg2.txt_4c_Text8.Value

*-- Linhas 2262 a 2283:
2262:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2263:             THIS.this_oBusinessObject.this_nNcPracas = loc_oPg2.txt_4c_Text33.Value
2264:         ENDIF
2265: 
2266:         *-- Endereco do Sacado
2267:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2268:             THIS.this_oBusinessObject.this_nNlnEndCobs = loc_oPg2.txt_4c_Text19.Value
2269:         ENDIF
2270:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2271:             THIS.this_oBusinessObject.this_nNclEndCobs = loc_oPg2.txt_4c_Text20.Value
2272:         ENDIF
2273:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2274:             THIS.this_oBusinessObject.this_nNlnBaiCobs = loc_oPg2.txt_4c_Text21.Value
2275:         ENDIF
2276:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2277:             THIS.this_oBusinessObject.this_nNclBaiCobs = loc_oPg2.txt_4c_Text22.Value
2278:         ENDIF
2279:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2280:             THIS.this_oBusinessObject.this_nNlnCepCobs = loc_oPg2.txt_4c_Text27.Value
2281:         ENDIF
2282:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2283:             THIS.this_oBusinessObject.this_nNclCepCobs = loc_oPg2.txt_4c_Text28.Value

*-- Linhas 2300 a 2387:
2300:             THIS.this_oBusinessObject.this_nNlObs = loc_oPg2.txt_4c_Text36.Value
2301:         ENDIF
2302:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2303:             THIS.this_oBusinessObject.this_nNcObs = loc_oPg2.txt_4c_Text37.Value
2304:         ENDIF
2305:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2306:             THIS.this_oBusinessObject.this_nTamColObs = loc_oPg2.txt_4c_Text38.Value
2307:         ENDIF
2308:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2309:             THIS.this_oBusinessObject.this_nTamLinObs = loc_oPg2.txt_4c_Text39.Value
2310:         ENDIF
2311: 
2312:         *-- Valor NF
2313:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2314:             THIS.this_oBusinessObject.this_nLNota = loc_oPg2.txt_4c_Text34.Value
2315:         ENDIF
2316:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2317:             THIS.this_oBusinessObject.this_nCNota = loc_oPg2.txt_4c_Text35.Value
2318:         ENDIF
2319: 
2320:         *-- Codigo
2321:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2322:             THIS.this_oBusinessObject.this_nNlnCods = loc_oPg2.txt_4c_Text41.Value
2323:         ENDIF
2324:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2325:             THIS.this_oBusinessObject.this_nNclCods = loc_oPg2.txt_4c_Text42.Value
2326:         ENDIF
2327: 
2328:         *-- Impressora / Fonte
2329:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2330:             THIS.this_oBusinessObject.this_cNomeImps = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
2331:         ENDIF
2332:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2333:             THIS.this_oBusinessObject.this_cFontePdrs = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
2334:         ENDIF
2335:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2336:             THIS.this_oBusinessObject.this_nTamFontes = loc_oPg2.txt_4c_Text31.Value
2337:         ENDIF
2338:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2339:             THIS.this_oBusinessObject.this_cTamFolhas = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
2340:         ENDIF
2341:     ENDPROC
2342: 
2343:     *==========================================================================
2344:     * BOParaForm - Transfere propriedades do BO para os campos de Page2
2345:     * Implementacao completa adicionada nas Fases 5-6
2346:     *==========================================================================
2347:     PROCEDURE BOParaForm()
2348:         LOCAL loc_oPg2
2349:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2350: 
2351:         *-- Serie (PK)
2352:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2353:             loc_oPg2.txt_4c_Series.Value = THIS.this_oBusinessObject.this_cSeries
2354:         ENDIF
2355: 
2356:         *-- Cabecalho: Data Emissao
2357:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2358:             loc_oPg2.txt_4c_Text5.Value = THIS.this_oBusinessObject.this_nNlnDtDocs
2359:         ENDIF
2360:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2361:             loc_oPg2.txt_4c_Text6.Value = THIS.this_oBusinessObject.this_nNclDtDocs
2362:         ENDIF
2363: 
2364:         *-- Cabecalho: Nota Fiscal
2365:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2366:             loc_oPg2.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nNlnNotas
2367:         ENDIF
2368:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2369:             loc_oPg2.txt_4c_Text2.Value = THIS.this_oBusinessObject.this_nNclNotas
2370:         ENDIF
2371: 
2372:         *-- Cabecalho: Valor da Duplicata
2373:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2374:             loc_oPg2.txt_4c_Text9.Value = THIS.this_oBusinessObject.this_nNlnVlDocs
2375:         ENDIF
2376:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2377:             loc_oPg2.txt_4c_Text10.Value = THIS.this_oBusinessObject.this_nNclVlDocs
2378:         ENDIF
2379: 
2380:         *-- Cabecalho: N da Duplicata
2381:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2382:             loc_oPg2.txt_4c_Text7.Value = THIS.this_oBusinessObject.this_nNlnNrDocs
2383:         ENDIF
2384:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2385:             loc_oPg2.txt_4c_Text8.Value = THIS.this_oBusinessObject.this_nNclNrDocs
2386:         ENDIF
2387: 

*-- Linhas 2432 a 2453:
2432:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2433:             loc_oPg2.txt_4c_Text33.Value = THIS.this_oBusinessObject.this_nNcPracas
2434:         ENDIF
2435: 
2436:         *-- Endereco do Sacado
2437:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2438:             loc_oPg2.txt_4c_Text19.Value = THIS.this_oBusinessObject.this_nNlnEndCobs
2439:         ENDIF
2440:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2441:             loc_oPg2.txt_4c_Text20.Value = THIS.this_oBusinessObject.this_nNclEndCobs
2442:         ENDIF
2443:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2444:             loc_oPg2.txt_4c_Text21.Value = THIS.this_oBusinessObject.this_nNlnBaiCobs
2445:         ENDIF
2446:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2447:             loc_oPg2.txt_4c_Text22.Value = THIS.this_oBusinessObject.this_nNclBaiCobs
2448:         ENDIF
2449:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2450:             loc_oPg2.txt_4c_Text27.Value = THIS.this_oBusinessObject.this_nNlnCepCobs
2451:         ENDIF
2452:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2453:             loc_oPg2.txt_4c_Text28.Value = THIS.this_oBusinessObject.this_nNclCepCobs

*-- Linhas 2470 a 2557:
2470:             loc_oPg2.txt_4c_Text36.Value = THIS.this_oBusinessObject.this_nNlObs
2471:         ENDIF
2472:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2473:             loc_oPg2.txt_4c_Text37.Value = THIS.this_oBusinessObject.this_nNcObs
2474:         ENDIF
2475:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2476:             loc_oPg2.txt_4c_Text38.Value = THIS.this_oBusinessObject.this_nTamColObs
2477:         ENDIF
2478:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2479:             loc_oPg2.txt_4c_Text39.Value = THIS.this_oBusinessObject.this_nTamLinObs
2480:         ENDIF
2481: 
2482:         *-- Valor NF
2483:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2484:             loc_oPg2.txt_4c_Text34.Value = THIS.this_oBusinessObject.this_nLNota
2485:         ENDIF
2486:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2487:             loc_oPg2.txt_4c_Text35.Value = THIS.this_oBusinessObject.this_nCNota
2488:         ENDIF
2489: 
2490:         *-- Codigo
2491:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2492:             loc_oPg2.txt_4c_Text41.Value = THIS.this_oBusinessObject.this_nNlnCods
2493:         ENDIF
2494:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2495:             loc_oPg2.txt_4c_Text42.Value = THIS.this_oBusinessObject.this_nNclCods
2496:         ENDIF
2497: 
2498:         *-- Impressora / Fonte
2499:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2500:             loc_oPg2.txt_4c_Text29.Value = THIS.this_oBusinessObject.this_cNomeImps
2501:         ENDIF
2502:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2503:             loc_oPg2.txt_4c_Text30.Value = THIS.this_oBusinessObject.this_cFontePdrs
2504:         ENDIF
2505:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2506:             loc_oPg2.txt_4c_Text31.Value = THIS.this_oBusinessObject.this_nTamFontes
2507:         ENDIF
2508:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2509:             loc_oPg2.txt_4c_Text40.Value = THIS.this_oBusinessObject.this_cTamFolhas
2510:         ENDIF
2511:     ENDPROC
2512: 
2513:     *==========================================================================
2514:     * HabilitarCampos - Habilita ou desabilita campos de edicao na Page2
2515:     * VISUALIZAR: todos ReadOnly / INCLUIR+ALTERAR: editaveis
2516:     *==========================================================================
2517:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2518:         LOCAL loc_oPg2, loc_lRO
2519:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2520:         loc_lRO  = !(par_lHabilitar = .T.)
2521: 
2522:         *-- Serie (PK) so editavel no modo INCLUIR
2523:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series", 5)
2524:             loc_oPg2.txt_4c_Series.ReadOnly = !(par_lHabilitar = .T. AND THIS.this_cModoAtual = "INCLUIR")
2525:         ENDIF
2526: 
2527:         *-- Cabecalho: Data Emissao, Nota Fiscal, Valor Duplicata, Nr Duplicata, Vencimento
2528:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",  5)
2529:             loc_oPg2.txt_4c_Text5.ReadOnly  = loc_lRO
2530:         ENDIF
2531:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",  5)
2532:             loc_oPg2.txt_4c_Text6.ReadOnly  = loc_lRO
2533:         ENDIF
2534:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",  5)
2535:             loc_oPg2.txt_4c_Text1.ReadOnly  = loc_lRO
2536:         ENDIF
2537:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",  5)
2538:             loc_oPg2.txt_4c_Text2.ReadOnly  = loc_lRO
2539:         ENDIF
2540:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",  5)
2541:             loc_oPg2.txt_4c_Text9.ReadOnly  = loc_lRO
2542:         ENDIF
2543:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2544:             loc_oPg2.txt_4c_Text10.ReadOnly = loc_lRO
2545:         ENDIF
2546:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",  5)
2547:             loc_oPg2.txt_4c_Text7.ReadOnly  = loc_lRO
2548:         ENDIF
2549:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",  5)
2550:             loc_oPg2.txt_4c_Text8.ReadOnly  = loc_lRO
2551:         ENDIF
2552:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",  5)
2553:             loc_oPg2.txt_4c_Text3.ReadOnly  = loc_lRO
2554:         ENDIF
2555:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",  5)
2556:             loc_oPg2.txt_4c_Text4.ReadOnly  = loc_lRO
2557:         ENDIF

*-- Linhas 2587 a 2608:
2587:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text33", 5)
2588:             loc_oPg2.txt_4c_Text33.ReadOnly = loc_lRO
2589:         ENDIF
2590: 
2591:         *-- Endereco do Sacado
2592:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19", 5)
2593:             loc_oPg2.txt_4c_Text19.ReadOnly = loc_lRO
2594:         ENDIF
2595:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20", 5)
2596:             loc_oPg2.txt_4c_Text20.ReadOnly = loc_lRO
2597:         ENDIF
2598:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21", 5)
2599:             loc_oPg2.txt_4c_Text21.ReadOnly = loc_lRO
2600:         ENDIF
2601:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22", 5)
2602:             loc_oPg2.txt_4c_Text22.ReadOnly = loc_lRO
2603:         ENDIF
2604:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text27", 5)
2605:             loc_oPg2.txt_4c_Text27.ReadOnly = loc_lRO
2606:         ENDIF
2607:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text28", 5)
2608:             loc_oPg2.txt_4c_Text28.ReadOnly = loc_lRO

*-- Linhas 2625 a 2707:
2625:             loc_oPg2.txt_4c_Text36.ReadOnly = loc_lRO
2626:         ENDIF
2627:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37", 5)
2628:             loc_oPg2.txt_4c_Text37.ReadOnly = loc_lRO
2629:         ENDIF
2630:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38", 5)
2631:             loc_oPg2.txt_4c_Text38.ReadOnly = loc_lRO
2632:         ENDIF
2633:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39", 5)
2634:             loc_oPg2.txt_4c_Text39.ReadOnly = loc_lRO
2635:         ENDIF
2636:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text34", 5)
2637:             loc_oPg2.txt_4c_Text34.ReadOnly = loc_lRO
2638:         ENDIF
2639:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text35", 5)
2640:             loc_oPg2.txt_4c_Text35.ReadOnly = loc_lRO
2641:         ENDIF
2642:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41", 5)
2643:             loc_oPg2.txt_4c_Text41.ReadOnly = loc_lRO
2644:         ENDIF
2645:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42", 5)
2646:             loc_oPg2.txt_4c_Text42.ReadOnly = loc_lRO
2647:         ENDIF
2648: 
2649:         *-- Impressora / Fonte / Tamanho / Folha
2650:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2651:             loc_oPg2.txt_4c_Text29.ReadOnly = loc_lRO
2652:         ENDIF
2653:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2654:             loc_oPg2.txt_4c_Text30.ReadOnly = loc_lRO
2655:         ENDIF
2656:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2657:             loc_oPg2.txt_4c_Text31.ReadOnly = loc_lRO
2658:         ENDIF
2659:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2660:             loc_oPg2.txt_4c_Text40.ReadOnly = loc_lRO
2661:         ENDIF
2662:     ENDPROC
2663: 
2664:     *==========================================================================
2665:     * LimparCampos - Zera/limpa todos os campos da Page2
2666:     *==========================================================================
2667:     PROTECTED PROCEDURE LimparCampos()
2668:         LOCAL loc_oPg2
2669:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2670: 
2671:         IF PEMSTATUS(loc_oPg2, "txt_4c_Series",  5)
2672:             loc_oPg2.txt_4c_Series.Value  = ""
2673:         ENDIF
2674:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text1",   5)
2675:             loc_oPg2.txt_4c_Text1.Value   = 0
2676:         ENDIF
2677:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text2",   5)
2678:             loc_oPg2.txt_4c_Text2.Value   = 0
2679:         ENDIF
2680:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text3",   5)
2681:             loc_oPg2.txt_4c_Text3.Value   = 0
2682:         ENDIF
2683:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text4",   5)
2684:             loc_oPg2.txt_4c_Text4.Value   = 0
2685:         ENDIF
2686:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text5",   5)
2687:             loc_oPg2.txt_4c_Text5.Value   = 0
2688:         ENDIF
2689:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text6",   5)
2690:             loc_oPg2.txt_4c_Text6.Value   = 0
2691:         ENDIF
2692:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text7",   5)
2693:             loc_oPg2.txt_4c_Text7.Value   = 0
2694:         ENDIF
2695:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text8",   5)
2696:             loc_oPg2.txt_4c_Text8.Value   = 0
2697:         ENDIF
2698:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text9",   5)
2699:             loc_oPg2.txt_4c_Text9.Value   = 0
2700:         ENDIF
2701:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text10",  5)
2702:             loc_oPg2.txt_4c_Text10.Value  = 0
2703:         ENDIF
2704:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text11",  5)
2705:             loc_oPg2.txt_4c_Text11.Value  = 0
2706:         ENDIF
2707:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text12",  5)

*-- Linhas 2723 a 2744:
2723:             loc_oPg2.txt_4c_Text17.Value  = 0
2724:         ENDIF
2725:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text18",  5)
2726:             loc_oPg2.txt_4c_Text18.Value  = 0
2727:         ENDIF
2728:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text19",  5)
2729:             loc_oPg2.txt_4c_Text19.Value  = 0
2730:         ENDIF
2731:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text20",  5)
2732:             loc_oPg2.txt_4c_Text20.Value  = 0
2733:         ENDIF
2734:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text21",  5)
2735:             loc_oPg2.txt_4c_Text21.Value  = 0
2736:         ENDIF
2737:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text22",  5)
2738:             loc_oPg2.txt_4c_Text22.Value  = 0
2739:         ENDIF
2740:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text23",  5)
2741:             loc_oPg2.txt_4c_Text23.Value  = 0
2742:         ENDIF
2743:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text24",  5)
2744:             loc_oPg2.txt_4c_Text24.Value  = 0

*-- Linhas 2780 a 2897:
2780:             loc_oPg2.txt_4c_Text36.Value  = 0
2781:         ENDIF
2782:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text37",  5)
2783:             loc_oPg2.txt_4c_Text37.Value  = 0
2784:         ENDIF
2785:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text38",  5)
2786:             loc_oPg2.txt_4c_Text38.Value  = 0
2787:         ENDIF
2788:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text39",  5)
2789:             loc_oPg2.txt_4c_Text39.Value  = 0
2790:         ENDIF
2791:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text40",  5)
2792:             loc_oPg2.txt_4c_Text40.Value  = ""
2793:         ENDIF
2794:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text41",  5)
2795:             loc_oPg2.txt_4c_Text41.Value  = 0
2796:         ENDIF
2797:         IF PEMSTATUS(loc_oPg2, "txt_4c_Text42",  5)
2798:             loc_oPg2.txt_4c_Text42.Value  = 0
2799:         ENDIF
2800:     ENDPROC
2801: 
2802:     *==========================================================================
2803:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2804:     * VISUALIZAR: Confirmar disabled, Cancelar enabled
2805:     * INCLUIR/ALTERAR/BUSCAR: ambos habilitados
2806:     *==========================================================================
2807:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2808:         LOCAL loc_oPg2, loc_oBtnConf, loc_oBtnCanc
2809:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2810: 
2811:         IF !PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2812:             RETURN
2813:         ENDIF
2814: 
2815:         loc_oBtnConf = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
2816:         loc_oBtnCanc = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
2817: 
2818:         DO CASE
2819:         CASE THIS.this_cModoAtual = "VISUALIZAR"
2820:             loc_oBtnConf.Caption = "OK"
2821:             loc_oBtnConf.Enabled = .T.
2822:             loc_oBtnCanc.Enabled = .T.
2823:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2824:             loc_oBtnConf.Caption = "Confirmar"
2825:             loc_oBtnConf.Enabled = .T.
2826:             loc_oBtnCanc.Enabled = .T.
2827:         CASE THIS.this_cModoAtual = "BUSCAR"
2828:             loc_oBtnConf.Caption = "Buscar"
2829:             loc_oBtnConf.Enabled = .T.
2830:             loc_oBtnCanc.Enabled = .T.
2831:         OTHERWISE
2832:             loc_oBtnConf.Caption = "Confirmar"
2833:             loc_oBtnConf.Enabled = .T.
2834:             loc_oBtnCanc.Enabled = .T.
2835:         ENDCASE
2836:     ENDPROC
2837: 
2838:     *==========================================================================
2839:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2840:     * Guarda o painel flutuante cnt_4c_CopiaFl como oculto
2841:     *==========================================================================
2842:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2843:         LOCAL loc_nI, loc_oObjeto, loc_cNome
2844: 
2845:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2846:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2847: 
2848:             IF VARTYPE(loc_oObjeto) = "O"
2849:                 loc_cNome = UPPER(loc_oObjeto.Name)
2850: 
2851:                 *-- Painel flutuante de copia deve permanecer oculto ate acionado
2852:                 IF INLIST(loc_cNome, "CNT_4C_COPIAFL")
2853:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2854:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2855:                     ENDIF
2856:                     LOOP
2857:                 ENDIF
2858: 
2859:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2860:                     loc_oObjeto.Visible = .T.
2861:                 ENDIF
2862: 
2863:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2864:                     LOCAL loc_nP
2865:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2866:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2867:                     ENDFOR
2868:                 ENDIF
2869: 
2870:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2871:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2872:                 ENDIF
2873:             ENDIF
2874:         ENDFOR
2875:     ENDPROC
2876: 
2877:     *==========================================================================
2878:     * FormatarGridLista - Formata visual da grade
2879:     *==========================================================================
2880:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2881:         WITH par_oGrid
2882:             .FontName = "Verdana"
2883:             .FontSize = 8
2884:         ENDWITH
2885:     ENDPROC
2886: 
2887:     *==========================================================================
2888:     * Destroy - Cleanup ao fechar o formulario
2889:     *==========================================================================
2890:     PROCEDURE Destroy()
2891:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2892:             THIS.this_oBusinessObject = .NULL.
2893:         ENDIF
2894:         DODEFAULT()
2895:     ENDPROC
2896: 
2897: ENDDEFINE


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

