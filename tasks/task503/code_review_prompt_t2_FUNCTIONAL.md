# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Promoção' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cód.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Comiss%' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'e-Com.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lista Preços' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Produto' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Peça' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1832 linhas total):

*-- Linhas 31 a 189:
31:     * Init - Inicializa o formulario
32:     * par_cTipo: "" = Cadastro padrao, "E" = Cadastro e-Commerce
33:     *====================================================================
34:     PROCEDURE Init(par_cTipo)
35:         LOCAL loc_lSucesso
36:         loc_lSucesso = .F.
37:         TRY
38:             IF VARTYPE(par_cTipo) = "C"
39:                 THIS.this_cTipo = UPPER(ALLTRIM(par_cTipo))
40:             ENDIF
41: 
42:             IF THIS.this_cTipo == "E"
43:                 THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es e-Commerce"
44:             ELSE
45:                 THIS.Caption = "Cadastro de Promo" + CHR(231) + CHR(245) + "es"
46:             ENDIF
47: 
48:             loc_lSucesso = DODEFAULT()
49:         CATCH TO loException
50:             MostrarErro(loException, "FormPrm.Init")
51:         ENDTRY
52:         RETURN loc_lSucesso
53:     ENDPROC
54: 
55:     *====================================================================
56:     * InicializarForm - Configura estrutura do formulario
57:     * Chamado pelo FormBase.Init()
58:     *====================================================================
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lSucesso
61:         loc_lSucesso = .F.
62:         TRY
63:             THIS.this_oBusinessObject = CREATEOBJECT("PrmBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
65:                 MsgErro("Erro ao criar PrmBO", "Erro")
66:                 loc_lSucesso = .F.
67:             ENDIF
68:             THIS.this_oBusinessObject.this_cTipo = THIS.this_cTipo
69: 
70:             THIS.CriarCursoresLocais()
71:             THIS.ConfigurarPageFrame()
72:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
73:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
74:             THIS.ConfigurarPaginaLista()
75:             THIS.ConfigurarPaginaDados()
76: 
77:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
78:                 THIS.CarregarLista()
79:             ENDIF
80: 
81:             THIS.pgf_4c_Paginas.Visible = .T.
82:             THIS.pgf_4c_Paginas.ActivePage = 1
83:             THIS.this_cModoAtual = "LISTA"
84:             loc_lSucesso = .T.
85:         CATCH TO loException
86:             MostrarErro(loException, "FormPrm.InicializarForm")
87:         ENDTRY
88:         RETURN loc_lSucesso
89:     ENDPROC
90: 
91:     *====================================================================
92:     * CriarCursoresLocais - Cria cursores de trabalho locais
93:     * Equivalente ao LOAD do legado (Load nao existe em .prg)
94:     * csSigPrPmi: produtos/itens da promocao (edicao em grid)
95:     * TcrSigPrPmi: log temporario de alteracoes
96:     * csSigPrPmv: grupos de venda da promocao (edicao em grid)
97:     *====================================================================
98:     PROTECTED PROCEDURE CriarCursoresLocais()
99:         SET NULL ON
100:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
101:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
102:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
103:         SELECT csSigPrPmi
104:         INDEX ON CPros TAG CPros
105: 
106:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
107:         INDEX ON CPros TAG idxTcpros
108: 
109:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
110:         SELECT csSigPrPmv
111: 
112:         CREATE CURSOR cursor_4c_Itens ;
113:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
114:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
115:              PromoPro C(35), Vendavels N(1,0) NULL)
116:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
117: 
118:         CREATE CURSOR cursor_4c_Grupos ;
119:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
120:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
121: 
122:         SET NULL OFF
123:     ENDPROC
124: 
125:     *====================================================================
126:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
127:     *====================================================================
128:     PROTECTED PROCEDURE ConfigurarPageFrame()
129:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
130:         WITH THIS.pgf_4c_Paginas
131:             .Top       = -29
132:             .Left      = 0
133:             .Width     = THIS.Width
134:             .Height    = THIS.Height + 29
135:             .PageCount = 2
136:             .Tabs      = .F.
137:             .TabStop   = .F.
138:             .Visible   = .T.
139:             .Page1.Caption = "Lista"
140:             .Page2.Caption = "Dados"
141:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
142:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
143:         ENDWITH
144:     ENDPROC
145: 
146:     *====================================================================
147:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
148:     *====================================================================
149:     PROTECTED PROCEDURE ConfigurarPaginaLista()
150:         LOCAL loc_oPagina, loc_oGrid
151:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
152: 
153:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
154:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
155: 
156:         *-- Container cabecalho - Top=31 (2 + 29 compensacao PageFrame.Top=-29)
157:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
158:         WITH loc_oPagina.cnt_4c_Cabecalho
159:             .Top         = 31
160:             .Left        = 0
161:             .Width       = THIS.Width
162:             .Height      = 80
163:             .BackColor   = RGB(100, 100, 100)
164:             .BorderWidth = 0
165: 
166:             .AddObject("lbl_4c_Sombra", "Label")
167:             WITH .lbl_4c_Sombra
168:                 .Top       = 15
169:                 .Left      = 10
170:                 .Width     = THIS.Width
171:                 .Height    = 40
172:                 .Caption   = THIS.Caption
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 16
175:                 .FontBold  = .T.
176:                 .ForeColor = RGB(0, 0, 0)
177:                 .BackStyle = 0
178:                 .Visible   = .T.
179:             ENDWITH
180: 
181:             .AddObject("lbl_4c_Titulo", "Label")
182:             WITH .lbl_4c_Titulo
183:                 .Top       = 18
184:                 .Left      = 10
185:                 .Width     = THIS.Width
186:                 .Height    = 46
187:                 .Caption   = THIS.Caption
188:                 .FontName  = "Tahoma"
189:                 .FontSize  = 16

*-- Linhas 321 a 446:
321:             ENDWITH
322:         ENDWITH
323: 
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
326:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
327:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
328:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
329: 
330:         *-- Container saida (padrao canonico, Top=29)
331:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
332:         WITH loc_oPagina.cnt_4c_Saida
333:             .Top         = 29
334:             .Left        = 917
335:             .Width       = 90
336:             .Height      = 85
337:             .BackStyle   = 0
338:             .BorderWidth = 0
339:             .Visible     = .T.
340: 
341:             .AddObject("cmd_4c_Encerrar", "CommandButton")
342:             WITH .cmd_4c_Encerrar
343:                 .Caption         = "Encerrar"
344:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
345:                 .PicturePosition = 13
346:                 .Top             = 5
347:                 .Left            = 917
348:                 .Width           = 75
349:                 .Height          = 75
350:                 .BackColor       = RGB(255, 255, 255)
351:                 .ForeColor       = RGB(90, 90, 90)
352:                 .FontName        = "Tahoma"
353:                 .FontSize        = 8
354:                 .FontBold        = .T.
355:                 .FontItalic      = .T.
356:                 .SpecialEffect   = 0
357:                 .MousePointer    = 15
358:                 .WordWrap        = .T.
359:                 .AutoSize        = .F.
360:                 .Visible         = .T.
361:             ENDWITH
362:         ENDWITH
363: 
364:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
365: 
366:         *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
367:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
368:         loc_oGrid = loc_oPagina.grd_4c_Lista
369:         loc_oGrid.RecordSource = ""
370:         loc_oGrid.ColumnCount  = 5
371:         WITH loc_oGrid
372:             .Top                = 117
373:             .Left               = 0
374:             .Width              = 910
375:             .Height             = 478
376:             .FontName           = "Verdana"
377:             .FontSize           = 8
378:             .ForeColor          = RGB(90, 90, 90)
379:             .BackColor          = RGB(255, 255, 255)
380:             .GridLineColor      = RGB(238, 238, 238)
381:             .GridLines          = 3
382:             .HighlightBackColor = RGB(255, 255, 255)
383:             .HighlightForeColor = RGB(15, 41, 104)
384:             .HighlightStyle     = 2
385:             .DeleteMark         = .F.
386:             .RecordMark         = .F.
387:             .RowHeight          = 16
388:             .ScrollBars         = 2
389:             .ReadOnly           = .T.
390:             .Visible            = .T.
391:             .Column1.Width      = 250
392:             .Column2.Width      = 60
393:             .Column3.Width      = 85
394:             .Column4.Width      = 60
395:             .Column5.Width      = 200
396:         ENDWITH
397: 
398:         THIS.TornarControlesVisiveis(loc_oPagina)
399:     ENDPROC
400: 
401:     *====================================================================
402:     * ConfigurarPaginaDados - Configura Page2 (Dados) com campos do cabecalho
403:     * Fase 5: botoes, campos principais (Promos, Codigo, Comissao, eCommerce)
404:     * Fase 6: sub-pageframe pgGrades com grids de produtos e grupos
405:     *====================================================================
406:     PROTECTED PROCEDURE ConfigurarPaginaDados()
407:         LOCAL loc_oPagina
408:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
409: 
410:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
411:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
412: 
413:         *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
414:         *-- Legado: Grupo_Salva.Left=611, Top=13 -> usar canonico
415:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
416:         WITH loc_oPagina.cnt_4c_BotoesAcao
417:             .Top         = 33
418:             .Left        = 842
419:             .Width       = 160
420:             .Height      = 85
421:             .BackStyle   = 0
422:             .BorderWidth = 0
423:             .Visible     = .T.
424: 
425:             .AddObject("cmd_4c_Confirmar", "CommandButton")
426:             WITH .cmd_4c_Confirmar
427:                 .Caption         = "Confirmar"
428:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
429:                 .PicturePosition = 13
430:                 .Top             = 5
431:                 .Left            = 5
432:                 .Width           = 75
433:                 .Height          = 75
434:                 .BackColor       = RGB(255, 255, 255)
435:                 .ForeColor       = RGB(90, 90, 90)
436:                 .FontName        = "Tahoma"
437:                 .FontSize        = 8
438:                 .FontBold        = .T.
439:                 .FontItalic      = .T.
440:                 .SpecialEffect   = 0
441:                 .MousePointer    = 15
442:                 .WordWrap        = .T.
443:                 .AutoSize        = .F.
444:                 .Visible         = .T.
445:             ENDWITH
446: 

*-- Linhas 468 a 512:
468:             ENDWITH
469:         ENDWITH
470: 
471:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
472:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
473: 
474:         *-- Label "Promoção :" + txt_4c_Promos
475:         *-- Legado: lbl_promocao Top=133, Left=31 -> compensado +29 = 162
476:         *-- Legado: get_promos   Top=130, Left=101 -> compensado +29 = 159
477:         loc_oPagina.AddObject("lbl_4c_Promocao", "Label")
478:         WITH loc_oPagina.lbl_4c_Promocao
479:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
480:             .Top       = 162
481:             .Left      = 31
482:             .Width     = 68
483:             .Height    = 15
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .ForeColor = RGB(90, 90, 90)
487:             .BackStyle = 0
488:             .Alignment = 1
489:             .Visible   = .T.
490:         ENDWITH
491: 
492:         loc_oPagina.AddObject("txt_4c_Promos", "TextBox")
493:         WITH loc_oPagina.txt_4c_Promos
494:             .Value     = ""
495:             .Top       = 159
496:             .Left      = 101
497:             .Width     = 185
498:             .Height    = 23
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .MaxLength = 25
502:             .Visible   = .T.
503:         ENDWITH
504: 
505:         *-- Label "Código :" + txt_4c_Codigo
506:         *-- Legado: Say1     Top=157, Left=48  -> compensado +29 = 186
507:         *-- Legado: getCodigo Top=154, Left=101 -> compensado +29 = 183
508:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
509:         WITH loc_oPagina.lbl_4c_Codigo
510:             .Caption   = "C" + CHR(243) + "digo :"
511:             .Top       = 186
512:             .Left      = 48

*-- Linhas 597 a 1832:
597:             .Visible   = .T.
598:         ENDWITH
599: 
600:         *-- BINDEVENTs validacao e lookup
601:         BINDEVENT(loc_oPagina.txt_4c_Promos,    "KeyPress",         THIS, "ValidarPromos")
602:         BINDEVENT(loc_oPagina.txt_4c_LPrecos,   "KeyPress",         THIS, "ValidarLPrecos")
603:         BINDEVENT(loc_oPagina.chk_4c_Comissao,  "InteractiveChange", THIS, "chkComissaoChanged")
604:         BINDEVENT(loc_oPagina.chk_4c_eCommerce, "InteractiveChange", THIS, "chkeCommerceChanged")
605: 
606:         *-- Sub-pageframe para produtos e grupos de venda
607:         *-- Legado: pgGrades Top=181 -> compensado +29 = 210 (em Page2 do pgf_4c_Paginas com Top=-29)
608:         loc_oPagina.AddObject("pgf_4c_Grades", "PageFrame")
609:         WITH loc_oPagina.pgf_4c_Grades
610:             .Top       = 210
611:             .Left      = 23
612:             .Width     = 762
613:             .Height    = 396
614:             .PageCount = 2
615:             .Tabs      = .T.
616:             .TabStop   = .F.
617:             .Page1.Caption = "Produtos"
618:             .Page2.Caption = "Grupos de Venda"
619:         ENDWITH
620: 
621:         THIS.ConfigurarGradeProdutos(loc_oPagina.pgf_4c_Grades.Page1)
622:         THIS.ConfigurarGradeGrupos(loc_oPagina.pgf_4c_Grades.Page2)
623: 
624:         BINDEVENT(loc_oPagina.pgf_4c_Grades.Page2, "Activate", THIS, "GradesActivate")
625: 
626:         THIS.TornarControlesVisiveis(loc_oPagina)
627: 
628:         *-- Imagem inicialmente invisivel (mostra somente quando produto tem foto)
629:         loc_oPagina.pgf_4c_Grades.Page1.img_4c_ImgProd.Visible = .F.
630:     ENDPROC
631: 
632:     *====================================================================
633:     * CarregarLista - Carrega lista de promocoes no grid da Page1
634:     *====================================================================
635:     PROCEDURE CarregarLista()
636:         LOCAL loc_lSucesso, loc_oGrid
637:         loc_lSucesso = .F.
638: 
639:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
640:             loc_lSucesso = .T.
641:         ELSE
642:             TRY
643:                 IF !THIS.this_oBusinessObject.Buscar("")
644:                     loc_lSucesso = .F.
645:                 ELSE
646:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
647:                     loc_oGrid.ColumnCount = 5
648:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
649:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
650:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
651:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
652:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
653:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
654:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
655:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
656:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
657:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
658:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
659:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
660:                     loc_oGrid.Column3.Alignment = 1
661:                     loc_oGrid.Column4.Alignment = 1
662:                     THIS.FormatarGridLista(loc_oGrid)
663:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
664:                         GO TOP IN cursor_4c_Dados
665:                     ENDIF
666:                     loc_lSucesso = .T.
667:                 ENDIF
668:             CATCH TO loException
669:                 MostrarErro(loException, "FormPrm.CarregarLista")
670:             ENDTRY
671:         ENDIF
672: 
673:         RETURN loc_lSucesso
674:     ENDPROC
675: 
676:     *====================================================================
677:     * Destroy - Libera recursos do formulario
678:     *====================================================================
679:     PROCEDURE Destroy()
680:         TRY
681:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
682:                 THIS.this_oBusinessObject = .NULL.
683:             ENDIF
684: 
685:             IF USED("csSigPrPmi")
686:                 USE IN csSigPrPmi
687:             ENDIF
688:             IF USED("TcrSigPrPmi")
689:                 USE IN TcrSigPrPmi
690:             ENDIF
691:             IF USED("csSigPrPmv")
692:                 USE IN csSigPrPmv
693:             ENDIF
694:             IF USED("cursor_4c_Dados")
695:                 USE IN cursor_4c_Dados
696:             ENDIF
697:             IF USED("cursor_4c_Itens")
698:                 USE IN cursor_4c_Itens
699:             ENDIF
700:             IF USED("cursor_4c_Grupos")
701:                 USE IN cursor_4c_Grupos
702:             ENDIF
703:         CATCH TO loException
704:             MsgErro("Erro ao fechar: " + loException.Message, "Erro")
705:         ENDTRY
706:         DODEFAULT()
707:     ENDPROC
708: 
709:     *====================================================================
710:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
711:     *====================================================================
712:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
713:         LOCAL loc_nI, loc_oObjeto, loc_nP
714: 
715:         FOR loc_nI = 1 TO par_oContainer.ControlCount
716:             loc_oObjeto = par_oContainer.Controls(loc_nI)
717: 
718:             IF VARTYPE(loc_oObjeto) = "O"
719:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
720:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
721:                         loc_oObjeto.Visible = .T.
722:                     ENDIF
723:                 ENDIF
724: 
725:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
726:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
727:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
728:                     ENDFOR
729:                 ENDIF
730: 
731:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
732:                     THIS.TornarControlesVisiveis(loc_oObjeto)
733:                 ENDIF
734:             ENDIF
735:         ENDFOR
736:     ENDPROC
737: 
738:     *====================================================================
739:     * FormatarGridLista - Formata visual do grid principal (Page1)
740:     *====================================================================
741:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
742:         WITH par_oGrid
743:             .FontName = "Tahoma"
744:             .FontSize = 8
745:         ENDWITH
746:     ENDPROC
747: 
748:     *====================================================================
749:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
750:     *====================================================================
751:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
752:         LOCAL loc_lSucesso
753:         loc_lSucesso = .F.
754:         TRY
755:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
756:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
757:                 IF par_nPagina = 1
758:                     THIS.CarregarLista()
759:                 ENDIF
760:                 loc_lSucesso = .T.
761:             ENDIF
762:         CATCH TO loException
763:             MostrarErro(loException, "FormPrm.AlternarPagina")
764:         ENDTRY
765:         RETURN loc_lSucesso
766:     ENDPROC
767: 
768:     *====================================================================
769:     * BtnIncluirClick - Inicia inclusao de nova promocao (PUBLIC)
770:     *====================================================================
771:     PROCEDURE BtnIncluirClick()
772:         THIS.this_oBusinessObject.NovoRegistro()
773:         THIS.LimparCampos()
774:         THIS.this_cModoAtual = "INCLUIR"
775:         THIS.HabilitarCampos(.T.)
776:         THIS.AjustarBotoesPorModo()
777:         THIS.AlternarPagina(2)
778:     ENDPROC
779: 
780:     *====================================================================
781:     * BtnVisualizarClick - Visualiza promocao selecionada em modo leitura (PUBLIC)
782:     *====================================================================
783:     PROCEDURE BtnVisualizarClick()
784:         LOCAL loc_cCidChaves
785:         loc_cCidChaves = ""
786:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
787:             SELECT cursor_4c_Dados
788:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
789:         ENDIF
790:         IF EMPTY(loc_cCidChaves)
791:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
792:             RETURN
793:         ENDIF
794:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
795:             THIS.this_cModoAtual = "VISUALIZAR"
796:             THIS.BOParaForm()
797:             THIS.HabilitarCampos(.F.)
798:             THIS.AjustarBotoesPorModo()
799:             THIS.AlternarPagina(2)
800:         ENDIF
801:     ENDPROC
802: 
803:     *====================================================================
804:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
805:     *====================================================================
806:     PROCEDURE BtnAlterarClick()
807:         LOCAL loc_cCidChaves
808:         loc_cCidChaves = ""
809:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
810:             SELECT cursor_4c_Dados
811:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
812:         ENDIF
813:         IF EMPTY(loc_cCidChaves)
814:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
815:             RETURN
816:         ENDIF
817:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
818:             THIS.this_oBusinessObject.EditarRegistro()
819:             THIS.this_cModoAtual = "ALTERAR"
820:             THIS.BOParaForm()
821:             THIS.HabilitarCampos(.T.)
822:             THIS.AjustarBotoesPorModo()
823:             THIS.AlternarPagina(2)
824:         ENDIF
825:     ENDPROC
826: 
827:     *====================================================================
828:     * BtnExcluirClick - Exclui promocao selecionada apos confirmacao (PUBLIC)
829:     *====================================================================
830:     PROCEDURE BtnExcluirClick()
831:         LOCAL loc_cCidChaves, loc_lConfirma
832:         loc_cCidChaves = ""
833:         loc_lConfirma  = .F.
834:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
835:             SELECT cursor_4c_Dados
836:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
837:         ENDIF
838:         IF EMPTY(loc_cCidChaves)
839:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
840:             RETURN
841:         ENDIF
842:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
843:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
844:         IF loc_lConfirma
845:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
846:                 IF THIS.this_oBusinessObject.Excluir()
847:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
848:                         "da com sucesso!", "Sucesso")
849:                     THIS.CarregarLista()
850:                 ENDIF
851:             ENDIF
852:         ENDIF
853:     ENDPROC
854: 
855:     *====================================================================
856:     * BtnBuscarClick - Recarrega lista (filtro avancado na Fase 5) (PUBLIC)
857:     *====================================================================
858:     PROCEDURE BtnBuscarClick()
859:         THIS.CarregarLista()
860:     ENDPROC
861: 
862:     *====================================================================
863:     * BtnEncerrarClick - Fecha o formulario (PUBLIC)
864:     *====================================================================
865:     PROCEDURE BtnEncerrarClick()
866:         THIS.Release()
867:     ENDPROC
868: 
869:     *====================================================================
870:     * BtnSalvarClick - Salva promocao (cabecalho + itens + grupos) (PUBLIC)
871:     *====================================================================
872:     PROCEDURE BtnSalvarClick()
873:         LOCAL loc_lSucesso, loc_oPg2
874:         loc_lSucesso = .F.
875:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
876: 
877:         *-- Validacoes obrigatorias ANTES do TRY
878:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Promos.Value))
879:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
880:                      "lida!!!", "Campo n" + CHR(227) + "o preenchido")
881:             loc_oPg2.txt_4c_Promos.SetFocus
882:             RETURN
883:         ENDIF
884: 
885:         TRY
886:             THIS.FormParaBO()
887: 
888:             IF THIS.this_cModoAtual == "INCLUIR"
889:                 IF THIS.this_oBusinessObject.VerificarPromoExiste( ;
890:                         THIS.this_oBusinessObject.this_cPromos, ;
891:                         THIS.this_oBusinessObject.this_cCods)
892:                     MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
893:                              CHR(225) + " Cadastrada!!!", "")
894:                     loc_oPg2.txt_4c_Promos.SetFocus
895:                 ELSE
896:                     IF THIS.this_oBusinessObject.Salvar()
897:                         THIS.this_oBusinessObject.SalvarItens( ;
898:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
899:                         THIS.this_oBusinessObject.SalvarGrupos( ;
900:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
901:                         MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
902:                         loc_lSucesso = .T.
903:                     ENDIF
904:                 ENDIF
905:             ELSE
906:                 IF THIS.this_oBusinessObject.Salvar()
907:                     THIS.this_oBusinessObject.SalvarItens( ;
908:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
909:                     THIS.this_oBusinessObject.SalvarGrupos( ;
910:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
911:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
912:                     loc_lSucesso = .T.
913:                 ENDIF
914:             ENDIF
915:         CATCH TO loException
916:             MostrarErro(loException, "FormPrm.BtnSalvarClick")
917:         ENDTRY
918: 
919:         IF loc_lSucesso
920:             THIS.this_cModoAtual = "LISTA"
921:             THIS.AlternarPagina(1)
922:         ENDIF
923:     ENDPROC
924: 
925:     *====================================================================
926:     * BtnCancelarClick - Cancela edicao e retorna para lista (PUBLIC)
927:     *====================================================================
928:     PROCEDURE BtnCancelarClick()
929:         THIS.this_cModoAtual = "LISTA"
930:         THIS.AlternarPagina(1)
931:     ENDPROC
932: 
933:     *====================================================================
934:     * FormParaBO - Transfere valores dos campos do Form para o BO
935:     *====================================================================
936:     PROTECTED PROCEDURE FormParaBO()
937:         LOCAL loc_oPg2
938:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
939: 
940:         THIS.this_oBusinessObject.this_cPromos    = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
941:         THIS.this_oBusinessObject.this_cCods      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
942:         THIS.this_oBusinessObject.this_nIncentivs = IIF(loc_oPg2.chk_4c_Comissao.Value, 1, 0)
943:         THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.txt_4c_Comiss.Value
944:         THIS.this_oBusinessObject.this_nECommerce = IIF(loc_oPg2.chk_4c_eCommerce.Value, 1, 0)
945:         THIS.this_oBusinessObject.this_cLPrecos   = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
946:     ENDPROC
947: 
948:     *====================================================================
949:     * BOParaForm - Transfere valores do BO para os campos do Form
950:     *====================================================================
951:     PROTECTED PROCEDURE BOParaForm()
952:         LOCAL loc_oPg2, loc_cPromos
953:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
954:         loc_cPromos = ALLTRIM(THIS.this_oBusinessObject.this_cPromos)
955: 
956:         loc_oPg2.txt_4c_Promos.Value    = loc_cPromos
957:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
958:         loc_oPg2.chk_4c_Comissao.Value  = IIF(THIS.this_oBusinessObject.this_nIncentivs = 1, 1, 0)
959:         loc_oPg2.txt_4c_Comiss.Value    = THIS.this_oBusinessObject.this_nComiss
960:         loc_oPg2.chk_4c_eCommerce.Value = IIF(THIS.this_oBusinessObject.this_nECommerce = 1, 1, 0)
961:         loc_oPg2.txt_4c_LPrecos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLPrecos)
962: 
963:         *-- Habilitar dependencias visuais conforme checkboxes
964:         loc_oPg2.txt_4c_Comiss.Enabled  = (THIS.this_oBusinessObject.this_nIncentivs = 1)
965:         loc_oPg2.txt_4c_LPrecos.Enabled = (THIS.this_oBusinessObject.this_nECommerce = 1)
966: 
967:         *-- Carregar itens e grupos nos cursores e atualizar grids
968:         IF !EMPTY(loc_cPromos)
969:             THIS.this_oBusinessObject.BuscarItens(loc_cPromos)
970:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
971:         ENDIF
972:         TRY
973:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
974:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
975:         CATCH TO loException
976:             MostrarErro(loException, "FormPrm.BOParaForm")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *====================================================================
981:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
982:     *====================================================================
983:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
984:         LOCAL loc_oPg2
985:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
986: 
987:         *-- Promos e Codigo: editaveis somente em INCLUIR
988:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
989:                                           (THIS.this_cModoAtual == "INCLUIR")
990:         loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
991:                                           (THIS.this_cModoAtual == "INCLUIR")
992: 
993:         *-- Checkboxes: editaveis em INCLUIR/ALTERAR
994:         loc_oPg2.chk_4c_Comissao.Enabled  = par_lHabilitar
995:         loc_oPg2.chk_4c_eCommerce.Enabled = par_lHabilitar AND !(THIS.this_cTipo == "E")
996: 
997:         *-- Campos vinculados ao checkbox
998:         loc_oPg2.txt_4c_Comiss.Enabled = par_lHabilitar AND ;
999:                                           (loc_oPg2.chk_4c_Comissao.Value)
1000:         loc_oPg2.txt_4c_LPrecos.Enabled = par_lHabilitar AND ;
1001:                                            (loc_oPg2.chk_4c_eCommerce.Value)
1002: 
1003:         *-- Botoes de acao
1004:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1005:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1006: 
1007:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1008:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1009:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1010:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1011:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1012:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1013:         ENDIF
1014:     ENDPROC
1015: 
1016:     *====================================================================
1017:     * LimparCampos - Limpa valores de todos os campos da Page2
1018:     *====================================================================
1019:     PROTECTED PROCEDURE LimparCampos()
1020:         LOCAL loc_oPg2
1021:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1022: 
1023:         loc_oPg2.txt_4c_Promos.Value    = ""
1024:         loc_oPg2.txt_4c_Codigo.Value    = ""
1025:         loc_oPg2.chk_4c_Comissao.Value  = 0
1026:         loc_oPg2.txt_4c_Comiss.Value    = 0
1027:         loc_oPg2.txt_4c_Comiss.Enabled  = .F.
1028:         loc_oPg2.chk_4c_eCommerce.Value = 0
1029:         loc_oPg2.txt_4c_LPrecos.Value   = ""
1030:         loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1031: 
1032:         *-- Recriar cursores de edicao vazios (com linha em branco para o grid)
1033:         IF USED("cursor_4c_Itens")
1034:             USE IN cursor_4c_Itens
1035:         ENDIF
1036:         IF USED("cursor_4c_Grupos")
1037:             USE IN cursor_4c_Grupos
1038:         ENDIF
1039: 
1040:         SET NULL ON
1041:         CREATE CURSOR cursor_4c_Itens ;
1042:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1043:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1044:              PromoPro C(35), Vendavels N(1,0) NULL)
1045:         SET NULL OFF
1046:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1047: 
1048:         SET NULL ON
1049:         CREATE CURSOR cursor_4c_Grupos ;
1050:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1051:         SET NULL OFF
1052:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1053: 
1054:         *-- Atualizar grids com cursores limpos
1055:         TRY
1056:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1057:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1058:         CATCH TO loException
1059:             MostrarErro(loException, "FormPrm.LimparCampos")
1060:         ENDTRY
1061:     ENDPROC
1062: 
1063:     *====================================================================
1064:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1065:     *====================================================================
1066:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1067:         LOCAL loc_oPg2
1068:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1069: 
1070:         DO CASE
1071:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1072:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1073:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1074:         OTHERWISE
1075:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1076:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1077:         ENDCASE
1078:     ENDPROC
1079: 
1080:     *====================================================================
1081:     * ValidarPromos - Valida campo promocao ao perder foco (PUBLIC - BINDEVENT)
1082:     * Em modo INCLUIR: verifica unicidade e pre-carrega grupos do banco
1083:     *====================================================================
1084:     PROCEDURE ValidarPromos(par_nKeyCode, par_nShiftAltCtrl)
1085:         LOCAL loc_oPg2, loc_cPromos
1086:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1087:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1088: 
1089:         IF EMPTY(loc_cPromos) OR !INLIST(THIS.this_cModoAtual, "INCLUIR")
1090:             RETURN
1091:         ENDIF
1092: 
1093:         IF THIS.this_oBusinessObject.VerificarPromoExiste(loc_cPromos, ;
1094:                 ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1095:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
1096:                      CHR(225) + " Cadastrada!!!", "")
1097:             loc_oPg2.txt_4c_Promos.Value = ""
1098:             loc_oPg2.txt_4c_Promos.SetFocus
1099:             RETURN
1100:         ENDIF
1101: 
1102:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1103:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1104:         TRY
1105:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1106:         CATCH TO loException
1107:             MostrarErro(loException, "FormPrm.ValidarPromos")
1108:         ENDTRY
1109:     ENDPROC
1110: 
1111:     *====================================================================
1112:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1113:     * Substitui fwBuscaExt para SigCdLpc
1114:     *====================================================================
1115:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1116:         LOCAL loc_oPg2, loc_cLPrecos, loc_nResult, loc_oBusca
1117:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1118:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1119: 
1120:         IF EMPTY(loc_cLPrecos)
1121:             RETURN
1122:         ENDIF
1123: 
1124:         TRY
1125:             *-- Tentativa exata primeiro
1126:             IF USED("cursor_4c_BuscaLpc")
1127:                 USE IN cursor_4c_BuscaLpc
1128:             ENDIF
1129:             loc_nResult = SQLEXEC(gnConnHandle, ;
1130:                 "SELECT TOP 1 LPrecos FROM SigCdLpc WHERE LPrecos = " + ;
1131:                 EscaparSQL(loc_cLPrecos), "cursor_4c_BuscaLpc")
1132: 
1133:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaLpc") AND !EOF("cursor_4c_BuscaLpc")
1134:                 *-- Encontrado exatamente
1135:                 loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1136:             ELSE
1137:                 *-- Nao encontrado: busca LIKE + picker (Pattern A canonico)
1138:                 IF USED("cursor_4c_BuscaLpc")
1139:                     USE IN cursor_4c_BuscaLpc
1140:                 ENDIF
1141:                 THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1142: 
1143:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1144:                 IF VARTYPE(loc_oBusca) = "O"
1145:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLpc"
1146:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;
1147:                         "Lista de Pre" + CHR(231) + "os")
1148:                     IF loc_oBusca.Mostrar()
1149:                         loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1150:                     ELSE
1151:                         loc_oPg2.txt_4c_LPrecos.Value = ""
1152:                     ENDIF
1153:                     loc_oBusca.Release()
1154:                 ENDIF
1155:             ENDIF
1156: 
1157:             IF USED("cursor_4c_BuscaLpc")
1158:                 USE IN cursor_4c_BuscaLpc
1159:             ENDIF
1160:         CATCH TO loException
1161:             MostrarErro(loException, "FormPrm.ValidarLPrecos")
1162:             IF USED("cursor_4c_BuscaLpc")
1163:                 USE IN cursor_4c_BuscaLpc
1164:             ENDIF
1165:         ENDTRY
1166:     ENDPROC
1167: 
1168:     *====================================================================
1169:     * chkComissaoChanged - Habilita/desabilita txt_4c_Comiss (PUBLIC - BINDEVENT)
1170:     *====================================================================
1171:     PROCEDURE chkComissaoChanged()
1172:         LOCAL loc_oPg2
1173:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1174: 
1175:         IF !loc_oPg2.chk_4c_Comissao.Value
1176:             loc_oPg2.txt_4c_Comiss.Value   = 0
1177:             loc_oPg2.txt_4c_Comiss.Enabled = .F.
1178:         ELSE
1179:             loc_oPg2.txt_4c_Comiss.Enabled = .T.
1180:         ENDIF
1181:         loc_oPg2.txt_4c_Comiss.Refresh
1182:     ENDPROC
1183: 
1184:     *====================================================================
1185:     * chkeCommerceChanged - Habilita/desabilita txt_4c_LPrecos (PUBLIC - BINDEVENT)
1186:     *====================================================================
1187:     PROCEDURE chkeCommerceChanged()
1188:         LOCAL loc_oPg2
1189:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1190: 
1191:         IF !loc_oPg2.chk_4c_eCommerce.Value
1192:             loc_oPg2.txt_4c_LPrecos.Value   = ""
1193:             loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1194:         ELSE
1195:             loc_oPg2.txt_4c_LPrecos.Enabled = .T.
1196:         ENDIF
1197:         loc_oPg2.txt_4c_LPrecos.Refresh
1198:     ENDPROC
1199: 
1200:     *====================================================================
1201:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1202:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1203:     *====================================================================
1204:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1205:         LOCAL loc_oGrid
1206: 
1207:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1208:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1209:         WITH loc_oGrid
1210:             .Top             = 3
1211:             .Left            = 8
1212:             .Width           = 742
1213:             .Height          = 220
1214:             .ColumnCount     = 6
1215:             .FontName        = "Tahoma"
1216:             .FontSize        = 8
1217:             .ForeColor       = RGB(90, 90, 90)
1218:             .BackColor       = RGB(255, 255, 255)
1219:             .GridLineColor   = RGB(238, 238, 238)
1220:             .GridLines       = 3
1221:             .HighlightStyle  = 2
1222:             .DeleteMark      = .F.
1223:             .RecordMark      = .F.
1224:             .RowHeight       = 18
1225:             .ScrollBars      = 3
1226:             .ReadOnly        = .F.
1227:         ENDWITH
1228: 
1229:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1230:         loc_oGrid.ColumnCount = 6
1231:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1232: 
1233:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1234:         WITH loc_oGrid.Column1
1235:             .ControlSource   = "cursor_4c_Itens.CPros"
1236:             .Width           = 100
1237:             .Sparse          = .F.
1238:             .Header1.Caption = "Produto"
1239:         ENDWITH
1240:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1241: 
1242:         WITH loc_oGrid.Column2
1243:             .ControlSource   = "cursor_4c_Itens.DPros"
1244:             .Width           = 200
1245:             .ReadOnly        = .T.
1246:             .Sparse          = .F.
1247:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1248:         ENDWITH
1249: 
1250:         WITH loc_oGrid.Column3
1251:             .ControlSource   = "cursor_4c_Itens.Pecas"
1252:             .Width           = 70
1253:             .Sparse          = .F.
1254:             .Header1.Caption = "Pe" + CHR(231) + "a"
1255:         ENDWITH
1256: 
1257:         WITH loc_oGrid.Column4
1258:             .ControlSource   = "cursor_4c_Itens.CBars"
1259:             .Width           = 80
1260:             .Sparse          = .F.
1261:             .ReadOnly        = .T.
1262:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1263:         ENDWITH
1264: 
1265:         WITH loc_oGrid.Column5
1266:             .ControlSource   = "cursor_4c_Itens.Datas"
1267:             .Width           = 80
1268:             .Sparse          = .F.
1269:             .Header1.Caption = "Data Inicial"
1270:         ENDWITH
1271:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1272: 
1273:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1274:         WITH loc_oGrid.Column6
1275:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1276:             .Width           = 35
1277:             .Sparse          = .F.
1278:             .Header1.Caption = "V"
1279:             .AddObject("chk_4c_Vendavel", "CheckBox")
1280:             WITH .chk_4c_Vendavel
1281:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1282:                 .Caption       = ""
1283:                 .Alignment     = 0
1284:                 .ReadOnly      = .F.
1285:                 .Visible       = .T.
1286:                 .Top           = 9
1287:                 .Left          = 2
1288:                 .Height        = 17
1289:                 .Width         = 22
1290:             ENDWITH
1291:             .CurrentControl  = "chk_4c_Vendavel"
1292:         ENDWITH
1293:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1294:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1295: 
1296:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")
1297: 
1298:         *-- Label "Busca :" (legado: Say2 Top=276,Left=299)
1299:         par_oPgProdutos.AddObject("lbl_4c_Busca", "Label")
1300:         WITH par_oPgProdutos.lbl_4c_Busca
1301:             .Caption   = "Busca :"
1302:             .Top       = 276
1303:             .Left      = 299
1304:             .Width     = 37
1305:             .Height    = 15
1306:             .FontName  = "Tahoma"
1307:             .FontSize  = 8
1308:             .ForeColor = RGB(90, 90, 90)
1309:             .BackStyle = 0
1310:             .Visible   = .T.
1311:         ENDWITH
1312: 
1313:         *-- TextBox busca rapida (legado: getBusca Top=273,Left=344,W=108)
1314:         par_oPgProdutos.AddObject("txt_4c_Busca", "TextBox")
1315:         WITH par_oPgProdutos.txt_4c_Busca
1316:             .Value     = ""
1317:             .Top       = 273
1318:             .Left      = 344
1319:             .Width     = 108
1320:             .Height    = 23
1321:             .FontName  = "Tahoma"
1322:             .FontSize  = 8
1323:             .MaxLength = 14
1324:             .Visible   = .T.
1325:         ENDWITH
1326:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "LostFocus",     THIS, "BuscaItemValid")
1327:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "KeyPress", THIS, "BuscaItemLostFocus")
1328: 
1329:         *-- Botao Apagar Item (legado: cmdApagar Top=252,Left=551,W=50,H=50)
1330:         par_oPgProdutos.AddObject("cmd_4c_ApagarItem", "CommandButton")
1331:         WITH par_oPgProdutos.cmd_4c_ApagarItem
1332:             .Caption      = "Apagar"
1333:             .Top          = 252
1334:             .Left         = 551
1335:             .Width        = 50
1336:             .Height       = 50
1337:             .FontName     = "Tahoma"
1338:             .FontSize     = 8
1339:             .MousePointer = 15
1340:             .Visible      = .T.
1341:         ENDWITH
1342:         BINDEVENT(par_oPgProdutos.cmd_4c_ApagarItem, "Click", THIS, "BtnApagarItemClick")
1343: 
1344:         *-- Imagem produto (legado: ImgProd Top=228,Left=59,W=175,H=104)
1345:         par_oPgProdutos.AddObject("img_4c_ImgProd", "Image")
1346:         WITH par_oPgProdutos.img_4c_ImgProd
1347:             .Top     = 228
1348:             .Left    = 59
1349:             .Width   = 175
1350:             .Height  = 104
1351:             .Stretch = 2
1352:             .Visible = .F.
1353:         ENDWITH
1354:     ENDPROC
1355: 
1356:     *====================================================================
1357:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1358:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1359:     *====================================================================
1360:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1361:         LOCAL loc_oGrid
1362: 
1363:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1364:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1365:         WITH loc_oGrid
1366:             .Top             = 24
1367:             .Left            = 256
1368:             .Width           = 192
1369:             .Height          = 324
1370:             .ColumnCount     = 2
1371:             .FontName        = "Tahoma"
1372:             .FontSize        = 8
1373:             .ForeColor       = RGB(90, 90, 90)
1374:             .BackColor       = RGB(255, 255, 255)
1375:             .GridLineColor   = RGB(238, 238, 238)
1376:             .GridLines       = 3
1377:             .HighlightStyle  = 2
1378:             .DeleteMark      = .F.
1379:             .RecordMark      = .F.
1380:             .RowHeight       = 18
1381:             .ScrollBars      = 3
1382:             .ReadOnly        = .F.
1383:         ENDWITH
1384: 
1385:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1386:         loc_oGrid.ColumnCount = 2
1387:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1388: 
1389:         *-- ControlSources e Headers APOS RecordSource
1390:         WITH loc_oGrid.Column1
1391:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1392:             .Width           = 80
1393:             .Sparse          = .F.
1394:             .Header1.Caption = "Grp. Venda"
1395:         ENDWITH
1396:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1397: 
1398:         WITH loc_oGrid.Column2
1399:             .ControlSource   = "cursor_4c_Grupos.Datas"
1400:             .Width           = 80
1401:             .Sparse          = .F.
1402:             .Header1.Caption = "Data Inicial"
1403:         ENDWITH
1404:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1405: 
1406:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1407:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1408:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1409:             .Caption      = "Apagar"
1410:             .Top          = 161
1411:             .Left         = 451
1412:             .Width        = 50
1413:             .Height       = 50
1414:             .FontName     = "Tahoma"
1415:             .FontSize     = 8
1416:             .MousePointer = 15
1417:             .Visible      = .T.
1418:         ENDWITH
1419:         BINDEVENT(par_oPgGrupos.cmd_4c_ApagarGrupo, "Click", THIS, "BtnApagarGrupoClick")
1420:     ENDPROC
1421: 
1422:     *====================================================================
1423:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1424:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1425:     *====================================================================
1426:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1427:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1428:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1429: 
1430:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1431:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1432:             RETURN
1433:         ENDIF
1434: 
1435:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1436:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1437: 
1438:         IF EMPTY(loc_cCpros)
1439:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1440:             RETURN
1441:         ENDIF
1442: 
1443:         TRY
1444:             IF USED("cursor_4c_FigJpg")
1445:                 USE IN cursor_4c_FigJpg
1446:             ENDIF
1447:             loc_nResult = SQLEXEC(gnConnHandle, ;
1448:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1449:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1450:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1451:                     !EOF("cursor_4c_FigJpg") AND ;
1452:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1453:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1454:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1455:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1456:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1457:             ELSE
1458:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1459:             ENDIF
1460:             IF USED("cursor_4c_FigJpg")
1461:                 USE IN cursor_4c_FigJpg
1462:             ENDIF
1463:         CATCH TO loException
1464:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")
1465:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *====================================================================
1470:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1471:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1472:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1473:     *====================================================================
1474:     PROCEDURE ValidarProdutoCodigo()
1475:         LOCAL loc_cCpros, loc_oBusca
1476: 
1477:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1478:             RETURN .T.
1479:         ENDIF
1480: 
1481:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1482: 
1483:         IF EMPTY(loc_cCpros)
1484:             REPLACE cursor_4c_Itens.DPros WITH ""
1485:             REPLACE cursor_4c_Itens.CBars WITH 0
1486:             RETURN .T.
1487:         ENDIF
1488: 
1489:         TRY
1490:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1491:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1492:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1493:                     SELECT cursor_4c_BuscaProd
1494:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1495:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1496:                 ENDIF
1497:                 IF USED("cursor_4c_BuscaProd")
1498:                     USE IN cursor_4c_BuscaProd
1499:                 ENDIF
1500:             ELSE
1501:                 IF USED("cursor_4c_BuscaProd")
1502:                     USE IN cursor_4c_BuscaProd
1503:                 ENDIF
1504:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1505:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1506:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1507:                 IF VARTYPE(loc_oBusca) = "O"
1508:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
1509:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cPros", "dPros", ;
1510:                         "Selecionar Produto")
1511:                     IF loc_oBusca.Mostrar()
1512:                         REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1513:                         REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1514:                     ELSE
1515:                         REPLACE cursor_4c_Itens.CPros WITH ""
1516:                         REPLACE cursor_4c_Itens.DPros WITH ""
1517:                         REPLACE cursor_4c_Itens.CBars WITH 0
1518:                     ENDIF
1519:                     loc_oBusca.Release()
1520:                 ENDIF
1521:                 IF USED("cursor_4c_BuscaProd")
1522:                     USE IN cursor_4c_BuscaProd
1523:                 ENDIF
1524:             ENDIF
1525:         CATCH TO loException
1526:             MostrarErro(loException, "FormPrm.ValidarProdutoCodigo")
1527:             IF USED("cursor_4c_BuscaProd")
1528:                 USE IN cursor_4c_BuscaProd
1529:             ENDIF
1530:         ENDTRY
1531: 
1532:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1533:         RETURN .T.
1534:     ENDPROC
1535: 
1536:     *====================================================================
1537:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1538:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1539:     *====================================================================
1540:     PROCEDURE GridProdutosDatasValid()
1541:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1542:             RETURN .T.
1543:         ENDIF
1544: 
1545:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1546:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1547:             TRY
1548:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1549:                 GO BOTTOM IN cursor_4c_Itens
1550:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1551:             CATCH TO loException
1552:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1553:             ENDTRY
1554:         ENDIF
1555: 
1556:         RETURN .T.
1557:     ENDPROC
1558: 
1559:     *====================================================================
1560:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1561:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1562:     *====================================================================
1563:     PROCEDURE GridCheckVendavelClick()
1564:         LOCAL loc_oChk
1565:         TRY
1566:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1567:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1568:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1569:                 IF VARTYPE(loc_oChk) = "O"
1570:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1571:                 ENDIF
1572:             ENDIF
1573:         CATCH TO loException
1574:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1575:         ENDTRY
1576:     ENDPROC
1577: 
1578:     *====================================================================
1579:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1580:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1581:     *====================================================================
1582:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1583:         LOCAL loc_oPg2
1584:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1585: 
1586:         IF par_nKeyCode = 9
1587:             IF BITAND(par_nShiftAltCtrl, 1) = 1
1588:                 *-- SHIFT+TAB: voltar para campo Promocao
1589:                 loc_oPg2.txt_4c_Promos.SetFocus
1590:             ELSE
1591:                 *-- TAB: ir para botao Confirmar
1592:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1593:             ENDIF
1594:         ENDIF
1595:     ENDPROC
1596: 
1597:     *====================================================================
1598:     * BuscaItemValid - Valid do txt_4c_Busca: navega no grid de produtos
1599:     * Legado: getBusca.Valid - SEEK by CPros in csSigPrPmi
1600:     *====================================================================
1601:     PROCEDURE BuscaItemValid()
1602:         LOCAL loc_oPgP, loc_cBusca
1603:         loc_oPgP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1604:         loc_cBusca = ALLTRIM(loc_oPgP.txt_4c_Busca.Value)
1605: 
1606:         IF EMPTY(loc_cBusca) OR !USED("cursor_4c_Itens")
1607:             RETURN .T.
1608:         ENDIF
1609: 
1610:         SELECT cursor_4c_Itens
1611:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1612: 
1613:         IF FOUND()
1614:             loc_oPgP.grd_4c_Produtos.Refresh
1615:         ENDIF
1616: 
1617:         RETURN .T.
1618:     ENDPROC
1619: 
1620:     *====================================================================
1621:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1622:     * Legado: getBusca.LostFocus - focus col_CPros
1623:     *====================================================================
1624:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1625:         LOCAL loc_oPgP
1626:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1627: 
1628:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1629:             loc_oPgP.grd_4c_Produtos.SetFocus
1630:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1631:             loc_oPgP.grd_4c_Produtos.Refresh
1632:         ENDIF
1633:     ENDPROC
1634: 
1635:     *====================================================================
1636:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1637:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1638:     *====================================================================
1639:     PROCEDURE BtnApagarItemClick()
1640:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1641:         loc_lAbortou = .F.
1642: 
1643:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1644:             RETURN
1645:         ENDIF
1646: 
1647:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1648:             RETURN
1649:         ENDIF
1650: 
1651:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1652: 
1653:         TRY
1654:             *-- Excluir do banco se registro ja persistido
1655:             IF !EMPTY(loc_cIdChaves)
1656:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1657:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1658:                 IF loc_nResult < 0
1659:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1660:                     loc_lAbortou = .T.
1661:                 ENDIF
1662:             ENDIF
1663: 
1664:             IF !loc_lAbortou
1665:                 SELECT cursor_4c_Itens
1666:                 DELETE
1667:                 PACK
1668:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1669:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1670:                 ENDIF
1671:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1672:             ENDIF
1673:         CATCH TO loException
1674:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *====================================================================
1679:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1680:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1681:     *====================================================================
1682:     PROCEDURE ValidarColecao()
1683:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1684: 
1685:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1686:             RETURN .T.
1687:         ENDIF
1688: 
1689:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1690: 
1691:         IF EMPTY(loc_cColecoes)
1692:             RETURN .T.
1693:         ENDIF
1694: 
1695:         TRY
1696:             IF USED("cursor_4c_BuscaCol")
1697:                 USE IN cursor_4c_BuscaCol
1698:             ENDIF
1699:             loc_nResult = SQLEXEC(gnConnHandle, ;
1700:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1701:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1702: 
1703:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1704:                 *-- Encontrado: manter valor atual
1705:             ELSE
1706:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1707:                 IF USED("cursor_4c_BuscaCol")
1708:                     USE IN cursor_4c_BuscaCol
1709:                 ENDIF
1710:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1711: 
1712:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1713:                 IF VARTYPE(loc_oBusca) = "O"
1714:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
1715:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1716:                         "Selecionar Grupo de Venda")
1717:                     IF loc_oBusca.Mostrar()
1718:                         REPLACE cursor_4c_Grupos.Colecoes WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1719:                     ELSE
1720:                         REPLACE cursor_4c_Grupos.Colecoes WITH ""
1721:                     ENDIF
1722:                     loc_oBusca.Release()
1723:                 ENDIF
1724:                 IF USED("cursor_4c_BuscaCol")
1725:                     USE IN cursor_4c_BuscaCol
1726:                 ENDIF
1727:             ENDIF
1728:             IF USED("cursor_4c_BuscaCol")
1729:                 USE IN cursor_4c_BuscaCol
1730:             ENDIF
1731:         CATCH TO loException
1732:             MostrarErro(loException, "FormPrm.ValidarColecao")
1733:         ENDTRY
1734: 
1735:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1736:         RETURN .T.
1737:     ENDPROC
1738: 
1739:     *====================================================================
1740:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1741:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1742:     *====================================================================
1743:     PROCEDURE ValidarDataGrupo()
1744:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1745:             RETURN .T.
1746:         ENDIF
1747: 
1748:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1749:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1750:             TRY
1751:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1752:                 GO BOTTOM IN cursor_4c_Grupos
1753:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1754:             CATCH TO loException
1755:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1756:             ENDTRY
1757:         ENDIF
1758: 
1759:         RETURN .T.
1760:     ENDPROC
1761: 
1762:     *====================================================================
1763:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1764:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1765:     *====================================================================
1766:     PROCEDURE BtnApagarGrupoClick()
1767:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1768:         loc_lAbortou = .F.
1769: 
1770:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1771:             RETURN
1772:         ENDIF
1773: 
1774:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1775:             RETURN
1776:         ENDIF
1777: 
1778:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1779: 
1780:         TRY
1781:             *-- Excluir do banco se registro ja persistido
1782:             IF !EMPTY(loc_cIdChaves)
1783:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1784:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1785:                 IF loc_nResult < 0
1786:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1787:                     loc_lAbortou = .T.
1788:                 ENDIF
1789:             ENDIF
1790: 
1791:             IF !loc_lAbortou
1792:                 SELECT cursor_4c_Grupos
1793:                 DELETE
1794:                 PACK
1795:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1796:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1797:                 ENDIF
1798:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1799:             ENDIF
1800:         CATCH TO loException
1801:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1802:         ENDTRY
1803:     ENDPROC
1804: 
1805:     *====================================================================
1806:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1807:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1808:     *====================================================================
1809:     PROCEDURE GradesActivate()
1810:         LOCAL loc_cPromos, loc_oPg2
1811:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1812:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1813: 
1814:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Grupos")
1815:             RETURN
1816:         ENDIF
1817: 
1818:         TRY
1819:             GO BOTTOM IN cursor_4c_Grupos
1820:             IF EOF("cursor_4c_Grupos") OR ;
1821:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1822:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1823:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1824:                     VALUES (loc_cPromos, DATETIME())
1825:             ENDIF
1826:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1827:         CATCH TO loException
1828:             MostrarErro(loException, "FormPrm.GradesActivate")
1829:         ENDTRY
1830:     ENDPROC
1831: 
1832: ENDDEFINE


### BO (C:\4c\projeto\app\classes\PrmBO.prg):
*====================================================================
* PrmBO.prg
*
* Business Object para Cadastro de Promocoes
* Tabela Principal: SigPrPmc
* Tabelas Filhas: SigPrPmi (itens/produtos), SigPrPmv (grupos de venda)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS PrmBO AS BusinessBase

    *-- Propriedades SigPrPmc (cabecalho da promocao)
    this_cPromos     = ""    && promos    char(25)  - chave de negocio (codigo promocao)
    this_cCods       = ""    && cods      char(3)   - codigo complementar
    this_cCidChaves  = ""    && cidchaves char(20)  - PK
    this_nComiss     = 0     && comiss    numeric(5,2) - percentual comissao incentivada
    this_nIncentivs  = 0     && incentivs numeric(1,0) - flag comissao incentivada (0/1)
    this_nECommerce  = 0     && ecommerce numeric(1,0) - flag integracao e-commerce (0/1)
    this_cLPrecos    = ""    && lprecos   char(30)  - lista de precos e-commerce

    *-- Propriedade de modo de exibicao (herdada do form original pcTipo)
    this_cTipo       = ""    && "" = modo padrao, "E" = modo e-commerce (filtra por ecommerce=1)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPmc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cPromos     = TratarNulo(Promos, "C")
            THIS.this_cCods       = TratarNulo(Cods, "C")
            THIS.this_nComiss     = TratarNulo(Comiss, "N")
            THIS.this_nIncentivs  = TratarNulo(Incentivs, "N")
            THIS.this_nECommerce  = TratarNulo(eCommerce, "N")
            THIS.this_cLPrecos    = TratarNulo(LPrecos, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista registros de promocoes (PUBLIC)
    * Se this_cTipo = "E", filtra por eCommerce = 1
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF UPPER(ALLTRIM(THIS.this_cTipo)) == "E"
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a" + ;
                           " WHERE a.eCommerce = 1" + ;
                           " ORDER BY a.Promos"
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                           " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                           " FROM SigPrPmc a"

                IF !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Promos"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega promocao pelo cIdChaves (PK) (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorPromos - Carrega promocao pela chave de negocio (PUBLIC)
    *====================================================================
    FUNCTION CarregarPorPromos(par_cPromos, par_cCods)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Promos, a.Cods," + ;
                       " a.Comiss, a.Incentivs, a.eCommerce, a.LPrecos" + ;
                       " FROM SigPrPmc a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos)

            IF !EMPTY(ALLTRIM(par_cCods))
                loc_cSQL = loc_cSQL + " AND a.Cods = " + EscaparSQL(par_cCods)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarPorPromos")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * VerificarPromoExiste - Verifica se Promos+Cods ja existe no banco
    *====================================================================
    FUNCTION VerificarPromoExiste(par_cPromos, par_cCods)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigPrPmc" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Cods = " + EscaparSQL(par_cCods)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Verifica")
                TABLEREVERT(.T., "cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Verifica")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                SELECT cursor_4c_Verifica
                loc_lExiste = (cursor_4c_Verifica.Total > 0)
            ENDIF

            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.VerificarPromoExiste")
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * GerarIdUnico - Gera ID unico para cIdChaves (substitui fUniqueIds)
    *====================================================================
    FUNCTION GerarIdUnico()
        LOCAL loc_cId, loc_nResult
        loc_cId = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT REPLACE(NEWID(),'-','') AS NewId", "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cId = LEFT(ALLTRIM(cursor_4c_NewId.NewId), 20)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loException
            loc_cId = ""
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        IF EMPTY(loc_cId)
            loc_cId = LEFT(ALLTRIM(SYS(2015)) + ALLTRIM(SYS(3)), 20)
        ENDIF
        RETURN loc_cId
    ENDFUNC

    *====================================================================
    * Inserir - INSERT na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF

            loc_cSQL = "INSERT INTO SigPrPmc" + ;
                       " (cidchaves, Promos, Cods, Comiss, Incentivs, eCommerce, LPrecos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cPromos) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIncentivs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nECommerce) + ", " + ;
                       EscaparSQL(THIS.this_cLPrecos) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigPrPmc (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrPmc SET" + ;
                       " Promos = " + EscaparSQL(THIS.this_cPromos) + "," + ;
                       " Cods = " + EscaparSQL(THIS.this_cCods) + "," + ;
                       " Comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " Incentivs = " + FormatarNumeroSQL(THIS.this_nIncentivs) + "," + ;
                       " eCommerce = " + FormatarNumeroSQL(THIS.this_nECommerce) + "," + ;
                       " LPrecos = " + EscaparSQL(THIS.this_cLPrecos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do cabecalho + itens + grupos (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Excluir itens/produtos da promocao
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir grupos de venda da promocao
            loc_cSQL = "DELETE FROM SigPrPmv WHERE Promos = " + EscaparSQL(THIS.this_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir cabecalho da promocao
            loc_cSQL = "DELETE FROM SigPrPmc WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarItens - Carrega itens/produtos de uma promocao para cursor de edicao
    * Popula cursor_4c_Itens para o grid pgProdutos (PUBLIC)
    *====================================================================
    FUNCTION BuscarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.CPros, a.DPros, a.Pecas," + ;
                       " a.Promos, a.CBars, a.Datas, a.DtAlts," + ;
                       " a.PromoPro, a.Vendavels" + ;
                       " FROM SigPrPmi a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " ORDER BY a.CPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ItensTemp")
                TABLEREVERT(.T., "cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Itens ;
                    (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
                     Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
                     PromoPro C(35), Vendavels N(1,0) NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_ItensTemp") > 0
                    SELECT cursor_4c_ItensTemp
                    SCAN
                        INSERT INTO cursor_4c_Itens ;
                            (cIdChaves, CPros, DPros, Pecas, Promos, CBars, ;
                             Datas, DtAlts, PromoPro, Vendavels) ;
                        VALUES ;
                            (cursor_4c_ItensTemp.cIdChaves, ;
                             cursor_4c_ItensTemp.CPros, ;
                             cursor_4c_ItensTemp.DPros, ;
                             cursor_4c_ItensTemp.Pecas, ;
                             cursor_4c_ItensTemp.Promos, ;
                             cursor_4c_ItensTemp.CBars, ;
                             cursor_4c_ItensTemp.Datas, ;
                             cursor_4c_ItensTemp.DtAlts, ;
                             cursor_4c_ItensTemp.PromoPro, ;
                             cursor_4c_ItensTemp.Vendavels)
                    ENDSCAN
                ENDIF

                *-- Adicionar linha em branco para edicao (como no legado)
                INSERT INTO cursor_4c_Itens (Promos, Datas, Vendavels) ;
                    VALUES (par_cPromos, DATE(), 1)

                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF

                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar itens da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ItensTemp")
                    USE IN cursor_4c_ItensTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarItens")
            IF USED("cursor_4c_ItensTemp")
                USE IN cursor_4c_ItensTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarGrupos - Carrega grupos de venda de uma promocao para cursor de edicao
    * Popula cursor_4c_Grupos para o grid pgGrpVenda (PUBLIC)
    *====================================================================
    FUNCTION BuscarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.cIdChaves, a.Promos, a.Colecoes, a.Datas" + ;
                       " FROM SigPrPmv a" + ;
                       " WHERE a.Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND a.Colecoes IS NOT NULL AND a.Colecoes <> ''" + ;
                       " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GruposTemp")
                TABLEREVERT(.T., "cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_Grupos ;
                    (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
                SET NULL OFF

                IF RECCOUNT("cursor_4c_GruposTemp") > 0
                    SELECT cursor_4c_GruposTemp
                    SCAN
                        INSERT INTO cursor_4c_Grupos ;
                            (cIdChaves, Promos, Colecoes, Datas) ;
                        VALUES ;
                            (cursor_4c_GruposTemp.cIdChaves, ;
                             cursor_4c_GruposTemp.Promos, ;
                             cursor_4c_GruposTemp.Colecoes, ;
                             cursor_4c_GruposTemp.Datas)
                    ENDSCAN
                ENDIF

                *-- Linha em branco para edicao (como no legado: INSERT INTO csSigPrPmv (Promos, Datas))
                INSERT INTO cursor_4c_Grupos (Promos, Datas) VALUES (par_cPromos, DATETIME())

                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF

                GO TOP IN cursor_4c_Grupos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos da promo" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_GruposTemp")
                    USE IN cursor_4c_GruposTemp
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarGrupos")
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarItens - Persiste itens/produtos no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarItens(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itens")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir TODOS os itens existentes no banco (legado faz ZAP + Delete + Update)
            loc_cSQL = "DELETE FROM SigPrPmi WHERE Promos = " + EscaparSQL(par_cPromos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir itens nao-vazios do cursor de edicao
            SELECT cursor_4c_Itens
            GO TOP IN cursor_4c_Itens
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Itens.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmi" + ;
                           " (cIdChaves, CPros, DPros, Pecas, Promos, CBars," + ;
                           " Datas, DtAlts, PromoPro, Vendavels)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.DPros)) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Itens.Pecas)) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.CBars) + ", " + ;
                           FormatarDataSQL(cursor_4c_Itens.Datas) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(par_cPromos + ALLTRIM(cursor_4c_Itens.CPros)) + ", " + ;
                           FormatarNumeroSQL(cursor_4c_Itens.Vendavels) + ;
                           ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar item " + ALLTRIM(cursor_4c_Itens.CPros) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarItens")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * SalvarGrupos - Persiste grupos de venda no banco (DELETE+INSERT) (PUBLIC)
    * Chamado pelo form apos salvar cabecalho
    *====================================================================
    FUNCTION SalvarGrupos(par_cPromos)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cIdChaves
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Grupos")
                loc_lSucesso = .T.
            ENDIF

            *-- Excluir grupos nao-vazios existentes no banco
            loc_cSQL = "DELETE FROM SigPrPmv" + ;
                       " WHERE Promos = " + EscaparSQL(par_cPromos) + ;
                       " AND Colecoes IS NOT NULL AND Colecoes <> ''"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Inserir grupos nao-vazios do cursor de edicao
            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            loc_lSucesso = .T.
            SCAN
                IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
                    LOOP
                ENDIF

                IF EMPTY(ALLTRIM(cursor_4c_Grupos.cIdChaves))
                    loc_cIdChaves = THIS.GerarIdUnico()
                ELSE
                    loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
                ENDIF

                loc_cSQL = "INSERT INTO SigPrPmv (cIdChaves, Promos, Colecoes, Datas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cIdChaves) + ", " + ;
                           EscaparSQL(par_cPromos) + ", " + ;
                           EscaparSQL(ALLTRIM(cursor_4c_Grupos.Colecoes)) + ", " + ;
                           "GETDATE())"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao salvar grupo " + ALLTRIM(cursor_4c_Grupos.Colecoes) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDSCAN
        CATCH TO loException
            MostrarErro(loException, "PrmBO.SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirItem - Exclui item especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de produtos
    *====================================================================
    FUNCTION ExcluirItem(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirItem")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExcluirGrupo - Exclui grupo de venda especifico por cIdChaves (PUBLIC)
    * Chamado quando usuario clica cmdApagar no grid de grupos
    *====================================================================
    FUNCTION ExcluirGrupo(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.ExcluirGrupo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoPorCodigo - Busca produto por codigo ou codigo de barras
    * Popula cursor_4c_BuscaProd (PUBLIC)
    * Substitui a logica de Valid em txt_cpros + fVerificarBarras do legado
    *====================================================================
    FUNCTION BuscarProdutoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCPros
        loc_lSucesso = .F.
        loc_cCPros   = ""
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            *-- Verificar se e codigo de barras (numerico com 8+ digitos)
            IF LEN(ALLTRIM(par_cCodigo)) >= 8 AND !EMPTY(VAL(ALLTRIM(par_cCodigo)))
                loc_cSQL = "SELECT a.CPros, a.CBars FROM SigOpEtq a" + ;
                           " WHERE a.CBars = " + ALLTRIM(par_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_BuscaEtq")
                    TABLEREVERT(.T., "cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtq")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaEtq") > 0
                    SELECT cursor_4c_BuscaEtq
                    GO TOP
                    loc_cCPros = ALLTRIM(cursor_4c_BuscaEtq.CPros)
                ENDIF
                IF USED("cursor_4c_BuscaEtq")
                    USE IN cursor_4c_BuscaEtq
                ENDIF

                IF EMPTY(loc_cCPros)
                    loc_lSucesso = .F.
                ENDIF
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(loc_cCPros)
            ELSE
                loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a" + ;
                           " WHERE a.cPros = " + EscaparSQL(par_cCodigo)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaProd") > 0
            ELSE
                MsgErro("Erro ao buscar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoPorCodigo")
            IF USED("cursor_4c_BuscaEtq")
                USE IN cursor_4c_BuscaEtq
            ENDIF
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarProdutoParaLookup - Busca produtos para FormBuscaAuxiliar (PUBLIC)
    * Popula cursor_4c_BuscaProd com cPros + dPros
    *====================================================================
    FUNCTION BuscarProdutoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_cSQL = "SELECT a.cPros, a.dPros FROM SigCdPro a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.cPros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.cPros"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaProd")
                TABLEREVERT(.T., "cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarProdutoParaLookup")
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarColecaoParaLookup - Busca colecoes em SigCdCol (PUBLIC)
    * Substitui fwBuscaExt para SigCdCol no grid de grupos de venda
    * Popula cursor_4c_BuscaCol com Colecoes + Descs
    *====================================================================
    FUNCTION BuscarColecaoParaLookup(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_cSQL = "SELECT a.Colecoes, a.Descs FROM SigCdCol a"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Colecoes LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.Colecoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaCol")
                TABLEREVERT(.T., "cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCol")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cole" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarColecaoParaLookup")
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * BuscarListaPrecos - Busca listas de precos em SigCdLpc (PUBLIC)
    * Substitui fwBuscaExt para SigCdLpc no campo getLPrecos
    * Popula cursor_4c_BuscaLpc com LPrecos
    *====================================================================
    FUNCTION BuscarListaPrecos(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF

            loc_cSQL = "SELECT a.LPrecos FROM SigCdLpc a ORDER BY a.LPrecos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLpc")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de pre" + CHR(231) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.BuscarListaPrecos")
            IF USED("cursor_4c_BuscaLpc")
                USE IN cursor_4c_BuscaLpc
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarImagemProduto - Carrega imagem JPEG de produto para arquivo temp (PUBLIC)
    * Substitui logica AfterRowColChange do grid de produtos no legado
    *====================================================================
    FUNCTION CarregarImagemProduto(par_cCPros, par_cArquivoTemp)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF

            loc_cSQL = "SELECT a.FigJpgs FROM SigCdPro a" + ;
                       " WHERE a.cPros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
                SELECT cursor_4c_ImgProd
                IF !EMPTY(cursor_4c_ImgProd.FigJpgs) AND !ISNULL(cursor_4c_ImgProd.FigJpgs)
                    IF STRTOFILE(cursor_4c_ImgProd.FigJpgs, par_cArquivoTemp) > 0
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "PrmBO.CarregarImagemProduto")
            IF USED("cursor_4c_ImgProd")
                USE IN cursor_4c_ImgProd
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

