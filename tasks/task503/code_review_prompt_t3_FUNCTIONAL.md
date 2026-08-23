# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Promoção' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cód.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Comiss%' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'e-Com.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lista Preços' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Barra, Data Inicial, V, Grp. Venda. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1837 linhas total):

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
348:                 .Width           = 90
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

*-- Linhas 597 a 1061:
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
713:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lOcultar
714: 
715:         FOR loc_nI = 1 TO par_oContainer.ControlCount
716:             loc_oObjeto = par_oContainer.Controls(loc_nI)
717: 
718:             IF VARTYPE(loc_oObjeto) = "O"
719:                 loc_lOcultar = INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO")
720: 
721:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND !loc_lOcultar
722:                     loc_oObjeto.Visible = .T.
723:                 ENDIF
724: 
725:                 IF !loc_lOcultar
726:                     IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
727:                         FOR loc_nP = 1 TO loc_oObjeto.PageCount
728:                             THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
729:                         ENDFOR
730:                     ENDIF
731: 
732:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
733:                         THIS.TornarControlesVisiveis(loc_oObjeto)
734:                     ENDIF
735:                 ENDIF
736:             ENDIF
737:         ENDFOR
738:     ENDPROC
739: 
740:     *====================================================================
741:     * FormatarGridLista - Formata visual do grid principal (Page1)
742:     *====================================================================
743:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
744:         WITH par_oGrid
745:             .FontName = "Tahoma"
746:             .FontSize = 8
747:         ENDWITH
748:     ENDPROC
749: 
750:     *====================================================================
751:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
752:     *====================================================================
753:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
754:         LOCAL loc_lSucesso
755:         loc_lSucesso = .F.
756:         TRY
757:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
758:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
759:                 IF par_nPagina = 1
760:                     THIS.CarregarLista()
761:                 ENDIF
762:                 loc_lSucesso = .T.
763:             ENDIF
764:         CATCH TO loException
765:             MostrarErro(loException, "FormPrm.AlternarPagina")
766:         ENDTRY
767:         RETURN loc_lSucesso
768:     ENDPROC
769: 
770:     *====================================================================
771:     * BtnIncluirClick - Inicia inclusao de nova promocao (PUBLIC)
772:     *====================================================================
773:     PROCEDURE BtnIncluirClick()
774:         THIS.this_oBusinessObject.NovoRegistro()
775:         THIS.LimparCampos()
776:         THIS.this_cModoAtual = "INCLUIR"
777:         THIS.HabilitarCampos(.T.)
778:         THIS.AjustarBotoesPorModo()
779:         THIS.AlternarPagina(2)
780:     ENDPROC
781: 
782:     *====================================================================
783:     * BtnVisualizarClick - Visualiza promocao selecionada em modo leitura (PUBLIC)
784:     *====================================================================
785:     PROCEDURE BtnVisualizarClick()
786:         LOCAL loc_cCidChaves
787:         loc_cCidChaves = ""
788:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
789:             SELECT cursor_4c_Dados
790:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
791:         ENDIF
792:         IF EMPTY(loc_cCidChaves)
793:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
794:             RETURN
795:         ENDIF
796:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
797:             THIS.this_cModoAtual = "VISUALIZAR"
798:             THIS.BOParaForm()
799:             THIS.HabilitarCampos(.F.)
800:             THIS.AjustarBotoesPorModo()
801:             THIS.AlternarPagina(2)
802:         ENDIF
803:     ENDPROC
804: 
805:     *====================================================================
806:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
807:     *====================================================================
808:     PROCEDURE BtnAlterarClick()
809:         LOCAL loc_cCidChaves
810:         loc_cCidChaves = ""
811:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
812:             SELECT cursor_4c_Dados
813:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
814:         ENDIF
815:         IF EMPTY(loc_cCidChaves)
816:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
817:             RETURN
818:         ENDIF
819:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
820:             THIS.this_oBusinessObject.EditarRegistro()
821:             THIS.this_cModoAtual = "ALTERAR"
822:             THIS.BOParaForm()
823:             THIS.HabilitarCampos(.T.)
824:             THIS.AjustarBotoesPorModo()
825:             THIS.AlternarPagina(2)
826:         ENDIF
827:     ENDPROC
828: 
829:     *====================================================================
830:     * BtnExcluirClick - Exclui promocao selecionada apos confirmacao (PUBLIC)
831:     *====================================================================
832:     PROCEDURE BtnExcluirClick()
833:         LOCAL loc_cCidChaves, loc_lConfirma
834:         loc_cCidChaves = ""
835:         loc_lConfirma  = .F.
836:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
837:             SELECT cursor_4c_Dados
838:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
839:         ENDIF
840:         IF EMPTY(loc_cCidChaves)
841:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
842:             RETURN
843:         ENDIF
844:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
845:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
846:         IF loc_lConfirma
847:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
848:                 IF THIS.this_oBusinessObject.Excluir()
849:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
850:                         "da com sucesso!", "Sucesso")
851:                     THIS.CarregarLista()
852:                 ENDIF
853:             ENDIF
854:         ENDIF
855:     ENDPROC
856: 
857:     *====================================================================
858:     * BtnBuscarClick - Recarrega lista (filtro avancado na Fase 5) (PUBLIC)
859:     *====================================================================
860:     PROCEDURE BtnBuscarClick()
861:         THIS.CarregarLista()
862:     ENDPROC
863: 
864:     *====================================================================
865:     * BtnEncerrarClick - Fecha o formulario (PUBLIC)
866:     *====================================================================
867:     PROCEDURE BtnEncerrarClick()
868:         THIS.Release()
869:     ENDPROC
870: 
871:     *====================================================================
872:     * BtnSalvarClick - Salva promocao (cabecalho + itens + grupos) (PUBLIC)
873:     *====================================================================
874:     PROCEDURE BtnSalvarClick()
875:         LOCAL loc_lSucesso, loc_oPg2
876:         loc_lSucesso = .F.
877:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
878: 
879:         *-- Validacoes obrigatorias ANTES do TRY
880:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Promos.Value))
881:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
882:                      "lida!!!", "Campo n" + CHR(227) + "o preenchido")
883:             loc_oPg2.txt_4c_Promos.SetFocus
884:             RETURN
885:         ENDIF
886: 
887:         TRY
888:             THIS.FormParaBO()
889: 
890:             IF THIS.this_cModoAtual == "INCLUIR"
891:                 IF THIS.this_oBusinessObject.VerificarPromoExiste( ;
892:                         THIS.this_oBusinessObject.this_cPromos, ;
893:                         THIS.this_oBusinessObject.this_cCods)
894:                     MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
895:                              CHR(225) + " Cadastrada!!!", "")
896:                     loc_oPg2.txt_4c_Promos.SetFocus
897:                 ELSE
898:                     IF THIS.this_oBusinessObject.Salvar()
899:                         THIS.this_oBusinessObject.SalvarItens( ;
900:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
901:                         THIS.this_oBusinessObject.SalvarGrupos( ;
902:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
903:                         MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
904:                         loc_lSucesso = .T.
905:                     ENDIF
906:                 ENDIF
907:             ELSE
908:                 IF THIS.this_oBusinessObject.Salvar()
909:                     THIS.this_oBusinessObject.SalvarItens( ;
910:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
911:                     THIS.this_oBusinessObject.SalvarGrupos( ;
912:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
913:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
914:                     loc_lSucesso = .T.
915:                 ENDIF
916:             ENDIF
917:         CATCH TO loException
918:             MostrarErro(loException, "FormPrm.BtnSalvarClick")
919:         ENDTRY
920: 
921:         IF loc_lSucesso
922:             THIS.this_cModoAtual = "LISTA"
923:             THIS.AlternarPagina(1)
924:         ENDIF
925:     ENDPROC
926: 
927:     *====================================================================
928:     * BtnCancelarClick - Cancela edicao e retorna para lista (PUBLIC)
929:     *====================================================================
930:     PROCEDURE BtnCancelarClick()
931:         THIS.this_cModoAtual = "LISTA"
932:         THIS.AlternarPagina(1)
933:     ENDPROC
934: 
935:     *====================================================================
936:     * FormParaBO - Transfere valores dos campos do Form para o BO
937:     *====================================================================
938:     PROTECTED PROCEDURE FormParaBO()
939:         LOCAL loc_oPg2
940:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
941: 
942:         THIS.this_oBusinessObject.this_cPromos    = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
943:         THIS.this_oBusinessObject.this_cCods      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
944:         THIS.this_oBusinessObject.this_nIncentivs = IIF(loc_oPg2.chk_4c_Comissao.Value, 1, 0)
945:         THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.txt_4c_Comiss.Value
946:         THIS.this_oBusinessObject.this_nECommerce = IIF(loc_oPg2.chk_4c_eCommerce.Value, 1, 0)
947:         THIS.this_oBusinessObject.this_cLPrecos   = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
948:     ENDPROC
949: 
950:     *====================================================================
951:     * BOParaForm - Transfere valores do BO para os campos do Form
952:     *====================================================================
953:     PROTECTED PROCEDURE BOParaForm()
954:         LOCAL loc_oPg2, loc_cPromos
955:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
956:         loc_cPromos = ALLTRIM(THIS.this_oBusinessObject.this_cPromos)
957: 
958:         loc_oPg2.txt_4c_Promos.Value    = loc_cPromos
959:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
960:         loc_oPg2.chk_4c_Comissao.Value  = IIF(THIS.this_oBusinessObject.this_nIncentivs = 1, 1, 0)
961:         loc_oPg2.txt_4c_Comiss.Value    = THIS.this_oBusinessObject.this_nComiss
962:         loc_oPg2.chk_4c_eCommerce.Value = IIF(THIS.this_oBusinessObject.this_nECommerce = 1, 1, 0)
963:         loc_oPg2.txt_4c_LPrecos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLPrecos)
964: 
965:         *-- Habilitar dependencias visuais conforme checkboxes
966:         loc_oPg2.txt_4c_Comiss.Enabled  = (THIS.this_oBusinessObject.this_nIncentivs = 1)
967:         loc_oPg2.txt_4c_LPrecos.Enabled = (THIS.this_oBusinessObject.this_nECommerce = 1)
968: 
969:         *-- Carregar itens e grupos nos cursores e atualizar grids
970:         IF !EMPTY(loc_cPromos)
971:             THIS.this_oBusinessObject.BuscarItens(loc_cPromos)
972:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
973:         ENDIF
974:         TRY
975:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
976:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
977:         CATCH TO loException
978:             MostrarErro(loException, "FormPrm.BOParaForm")
979:         ENDTRY
980:     ENDPROC
981: 
982:     *====================================================================
983:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
984:     *====================================================================
985:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
986:         LOCAL loc_oPg2
987:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
988: 
989:         *-- Promos e Codigo: editaveis somente em INCLUIR
990:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
991:                                           (THIS.this_cModoAtual == "INCLUIR")
992:         loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
993:                                           (THIS.this_cModoAtual == "INCLUIR")
994: 
995:         *-- Checkboxes: editaveis em INCLUIR/ALTERAR
996:         loc_oPg2.chk_4c_Comissao.Enabled  = par_lHabilitar
997:         loc_oPg2.chk_4c_eCommerce.Enabled = par_lHabilitar AND !(THIS.this_cTipo == "E")
998: 
999:         *-- Campos vinculados ao checkbox
1000:         loc_oPg2.txt_4c_Comiss.Enabled = par_lHabilitar AND ;
1001:                                           (loc_oPg2.chk_4c_Comissao.Value)
1002:         loc_oPg2.txt_4c_LPrecos.Enabled = par_lHabilitar AND ;
1003:                                            (loc_oPg2.chk_4c_eCommerce.Value)
1004: 
1005:         *-- Botoes de acao
1006:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1007:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1008: 
1009:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1010:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1011:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1012:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1013:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1014:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1015:         ENDIF
1016:     ENDPROC
1017: 
1018:     *====================================================================
1019:     * LimparCampos - Limpa valores de todos os campos da Page2
1020:     *====================================================================
1021:     PROTECTED PROCEDURE LimparCampos()
1022:         LOCAL loc_oPg2
1023:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1024: 
1025:         loc_oPg2.txt_4c_Promos.Value    = ""
1026:         loc_oPg2.txt_4c_Codigo.Value    = ""
1027:         loc_oPg2.chk_4c_Comissao.Value  = 0
1028:         loc_oPg2.txt_4c_Comiss.Value    = 0
1029:         loc_oPg2.txt_4c_Comiss.Enabled  = .F.
1030:         loc_oPg2.chk_4c_eCommerce.Value = 0
1031:         loc_oPg2.txt_4c_LPrecos.Value   = ""
1032:         loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1033: 
1034:         *-- Recriar cursores de edicao vazios (com linha em branco para o grid)
1035:         IF USED("cursor_4c_Itens")
1036:             USE IN cursor_4c_Itens
1037:         ENDIF
1038:         IF USED("cursor_4c_Grupos")
1039:             USE IN cursor_4c_Grupos
1040:         ENDIF
1041: 
1042:         SET NULL ON
1043:         CREATE CURSOR cursor_4c_Itens ;
1044:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1045:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1046:              PromoPro C(35), Vendavels N(1,0) NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1049: 
1050:         SET NULL ON
1051:         CREATE CURSOR cursor_4c_Grupos ;
1052:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1053:         SET NULL OFF
1054:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1055: 
1056:         *-- Reatribuir RecordSource e ControlSources apos recriar cursores (AUTOBIND VFP9)
1057:         TRY
1058:             LOCAL loc_oGridProd, loc_oGridGrp
1059:             loc_oGridProd = loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos
1060:             loc_oGridProd.ColumnCount = 6
1061:             loc_oGridProd.RecordSource              = "cursor_4c_Itens"

*-- Linhas 1082 a 1837:
1082:     *====================================================================
1083:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1084:     *====================================================================
1085:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1086:         LOCAL loc_oPg2
1087:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1088: 
1089:         DO CASE
1090:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1091:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1092:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1093:         OTHERWISE
1094:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1095:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1096:         ENDCASE
1097:     ENDPROC
1098: 
1099:     *====================================================================
1100:     * ValidarPromos - Valida campo promocao ao perder foco (PUBLIC - BINDEVENT)
1101:     * Em modo INCLUIR: verifica unicidade e pre-carrega grupos do banco
1102:     *====================================================================
1103:     PROCEDURE ValidarPromos(par_nKeyCode, par_nShiftAltCtrl)
1104:         LOCAL loc_oPg2, loc_cPromos
1105:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1106:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1107: 
1108:         IF EMPTY(loc_cPromos) OR !INLIST(THIS.this_cModoAtual, "INCLUIR")
1109:             RETURN
1110:         ENDIF
1111: 
1112:         IF THIS.this_oBusinessObject.VerificarPromoExiste(loc_cPromos, ;
1113:                 ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1114:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
1115:                      CHR(225) + " Cadastrada!!!", "")
1116:             loc_oPg2.txt_4c_Promos.Value = ""
1117:             loc_oPg2.txt_4c_Promos.SetFocus
1118:             RETURN
1119:         ENDIF
1120: 
1121:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1122:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1123:         TRY
1124:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1125:         CATCH TO loException
1126:             MostrarErro(loException, "FormPrm.ValidarPromos")
1127:         ENDTRY
1128:     ENDPROC
1129: 
1130:     *====================================================================
1131:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1132:     * Substitui fwBuscaExt para SigCdLpc
1133:     *====================================================================
1134:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1135:         LOCAL loc_oPg2, loc_cLPrecos, loc_oBusca
1136:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1137:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1138: 
1139:         IF EMPTY(loc_cLPrecos)
1140:             RETURN
1141:         ENDIF
1142: 
1143:         TRY
1144:             IF USED("cursor_4c_BuscaLpc")
1145:                 USE IN cursor_4c_BuscaLpc
1146:             ENDIF
1147:             THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1148: 
1149:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1150:             IF VARTYPE(loc_oBusca) = "O"
1151:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaLpc"
1152:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;
1153:                     "Lista de Pre" + CHR(231) + "os")
1154:                 IF loc_oBusca.Mostrar()
1155:                     loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1156:                 ELSE
1157:                     loc_oPg2.txt_4c_LPrecos.Value = ""
1158:                 ENDIF
1159:                 loc_oBusca.Release()
1160:             ENDIF
1161: 
1162:             IF USED("cursor_4c_BuscaLpc")
1163:                 USE IN cursor_4c_BuscaLpc
1164:             ENDIF
1165:         CATCH TO loException
1166:             MostrarErro(loException, "FormPrm.ValidarLPrecos")
1167:             IF USED("cursor_4c_BuscaLpc")
1168:                 USE IN cursor_4c_BuscaLpc
1169:             ENDIF
1170:         ENDTRY
1171:     ENDPROC
1172: 
1173:     *====================================================================
1174:     * chkComissaoChanged - Habilita/desabilita txt_4c_Comiss (PUBLIC - BINDEVENT)
1175:     *====================================================================
1176:     PROCEDURE chkComissaoChanged()
1177:         LOCAL loc_oPg2
1178:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1179: 
1180:         IF !loc_oPg2.chk_4c_Comissao.Value
1181:             loc_oPg2.txt_4c_Comiss.Value   = 0
1182:             loc_oPg2.txt_4c_Comiss.Enabled = .F.
1183:         ELSE
1184:             loc_oPg2.txt_4c_Comiss.Enabled = .T.
1185:         ENDIF
1186:         loc_oPg2.txt_4c_Comiss.Refresh
1187:     ENDPROC
1188: 
1189:     *====================================================================
1190:     * chkeCommerceChanged - Habilita/desabilita txt_4c_LPrecos (PUBLIC - BINDEVENT)
1191:     *====================================================================
1192:     PROCEDURE chkeCommerceChanged()
1193:         LOCAL loc_oPg2
1194:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1195: 
1196:         IF !loc_oPg2.chk_4c_eCommerce.Value
1197:             loc_oPg2.txt_4c_LPrecos.Value   = ""
1198:             loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1199:         ELSE
1200:             loc_oPg2.txt_4c_LPrecos.Enabled = .T.
1201:         ENDIF
1202:         loc_oPg2.txt_4c_LPrecos.Refresh
1203:     ENDPROC
1204: 
1205:     *====================================================================
1206:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1207:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1208:     *====================================================================
1209:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1210:         LOCAL loc_oGrid
1211: 
1212:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1213:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1214:         WITH loc_oGrid
1215:             .Top             = 3
1216:             .Left            = 8
1217:             .Width           = 742
1218:             .Height          = 220
1219:             .ColumnCount     = 6
1220:             .FontName        = "Tahoma"
1221:             .FontSize        = 8
1222:             .ForeColor       = RGB(90, 90, 90)
1223:             .BackColor       = RGB(255, 255, 255)
1224:             .GridLineColor   = RGB(238, 238, 238)
1225:             .GridLines       = 3
1226:             .HighlightStyle  = 2
1227:             .DeleteMark      = .F.
1228:             .RecordMark      = .F.
1229:             .RowHeight       = 18
1230:             .ScrollBars      = 3
1231:             .ReadOnly        = .F.
1232:         ENDWITH
1233: 
1234:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1235:         loc_oGrid.ColumnCount = 6
1236:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1237: 
1238:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1239:         WITH loc_oGrid.Column1
1240:             .ControlSource   = "cursor_4c_Itens.CPros"
1241:             .Width           = 100
1242:             .Sparse          = .F.
1243:             .Header1.Caption = ""
1244:         ENDWITH
1245:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1246: 
1247:         WITH loc_oGrid.Column2
1248:             .ControlSource   = "cursor_4c_Itens.DPros"
1249:             .Width           = 200
1250:             .ReadOnly        = .T.
1251:             .Sparse          = .F.
1252:             .Header1.Caption = ""
1253:         ENDWITH
1254: 
1255:         WITH loc_oGrid.Column3
1256:             .ControlSource   = "cursor_4c_Itens.Pecas"
1257:             .Width           = 70
1258:             .Sparse          = .F.
1259:             .Header1.Caption = ""
1260:         ENDWITH
1261: 
1262:         WITH loc_oGrid.Column4
1263:             .ControlSource   = "cursor_4c_Itens.CBars"
1264:             .Width           = 80
1265:             .Sparse          = .F.
1266:             .ReadOnly        = .T.
1267:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1268:         ENDWITH
1269: 
1270:         WITH loc_oGrid.Column5
1271:             .ControlSource   = "cursor_4c_Itens.Datas"
1272:             .Width           = 80
1273:             .Sparse          = .F.
1274:             .Header1.Caption = "Data Inicial"
1275:         ENDWITH
1276:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1277: 
1278:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1279:         WITH loc_oGrid.Column6
1280:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1281:             .Width           = 35
1282:             .Sparse          = .F.
1283:             .Header1.Caption = "V"
1284:             .AddObject("chk_4c_Vendavel", "CheckBox")
1285:             WITH .chk_4c_Vendavel
1286:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1287:                 .Caption       = ""
1288:                 .Alignment     = 0
1289:                 .ReadOnly      = .F.
1290:                 .Visible       = .T.
1291:                 .Top           = 9
1292:                 .Left          = 2
1293:                 .Height        = 17
1294:                 .Width         = 22
1295:             ENDWITH
1296:             .CurrentControl  = "chk_4c_Vendavel"
1297:         ENDWITH
1298:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1299:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1300: 
1301:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")
1302: 
1303:         *-- Label "Busca :" (legado: Say2 Top=276,Left=299)
1304:         par_oPgProdutos.AddObject("lbl_4c_Busca", "Label")
1305:         WITH par_oPgProdutos.lbl_4c_Busca
1306:             .Caption   = "Busca :"
1307:             .Top       = 276
1308:             .Left      = 299
1309:             .Width     = 37
1310:             .Height    = 15
1311:             .FontName  = "Tahoma"
1312:             .FontSize  = 8
1313:             .ForeColor = RGB(90, 90, 90)
1314:             .BackStyle = 0
1315:             .Visible   = .T.
1316:         ENDWITH
1317: 
1318:         *-- TextBox busca rapida (legado: getBusca Top=273,Left=344,W=108)
1319:         par_oPgProdutos.AddObject("txt_4c_Busca", "TextBox")
1320:         WITH par_oPgProdutos.txt_4c_Busca
1321:             .Value     = ""
1322:             .Top       = 273
1323:             .Left      = 344
1324:             .Width     = 108
1325:             .Height    = 23
1326:             .FontName  = "Tahoma"
1327:             .FontSize  = 8
1328:             .MaxLength = 14
1329:             .Visible   = .T.
1330:         ENDWITH
1331:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "LostFocus",     THIS, "BuscaItemValid")
1332:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "KeyPress", THIS, "BuscaItemLostFocus")
1333: 
1334:         *-- Botao Apagar Item (legado: cmdApagar Top=252,Left=551,W=50,H=50)
1335:         par_oPgProdutos.AddObject("cmd_4c_ApagarItem", "CommandButton")
1336:         WITH par_oPgProdutos.cmd_4c_ApagarItem
1337:             .Caption      = "Apagar"
1338:             .Top          = 252
1339:             .Left         = 551
1340:             .Width        = 50
1341:             .Height       = 50
1342:             .FontName     = "Tahoma"
1343:             .FontSize     = 8
1344:             .MousePointer = 15
1345:             .Visible      = .T.
1346:         ENDWITH
1347:         BINDEVENT(par_oPgProdutos.cmd_4c_ApagarItem, "Click", THIS, "BtnApagarItemClick")
1348: 
1349:         *-- Imagem produto (legado: ImgProd Top=228,Left=59,W=175,H=104)
1350:         par_oPgProdutos.AddObject("img_4c_ImgProd", "Image")
1351:         WITH par_oPgProdutos.img_4c_ImgProd
1352:             .Top     = 228
1353:             .Left    = 59
1354:             .Width   = 175
1355:             .Height  = 104
1356:             .Stretch = 2
1357:             .Visible = .F.
1358:         ENDWITH
1359:     ENDPROC
1360: 
1361:     *====================================================================
1362:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1363:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1364:     *====================================================================
1365:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1366:         LOCAL loc_oGrid
1367: 
1368:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1369:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1370:         WITH loc_oGrid
1371:             .Top             = 24
1372:             .Left            = 256
1373:             .Width           = 192
1374:             .Height          = 324
1375:             .ColumnCount     = 2
1376:             .FontName        = "Tahoma"
1377:             .FontSize        = 8
1378:             .ForeColor       = RGB(90, 90, 90)
1379:             .BackColor       = RGB(255, 255, 255)
1380:             .GridLineColor   = RGB(238, 238, 238)
1381:             .GridLines       = 3
1382:             .HighlightStyle  = 2
1383:             .DeleteMark      = .F.
1384:             .RecordMark      = .F.
1385:             .RowHeight       = 18
1386:             .ScrollBars      = 3
1387:             .ReadOnly        = .F.
1388:         ENDWITH
1389: 
1390:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1391:         loc_oGrid.ColumnCount = 2
1392:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1393: 
1394:         *-- ControlSources e Headers APOS RecordSource
1395:         WITH loc_oGrid.Column1
1396:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1397:             .Width           = 80
1398:             .Sparse          = .F.
1399:             .Header1.Caption = "Grp. Venda"
1400:         ENDWITH
1401:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1402: 
1403:         WITH loc_oGrid.Column2
1404:             .ControlSource   = "cursor_4c_Grupos.Datas"
1405:             .Width           = 80
1406:             .Sparse          = .F.
1407:             .Header1.Caption = "Data Inicial"
1408:         ENDWITH
1409:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1410: 
1411:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1412:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1413:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1414:             .Caption      = "Apagar"
1415:             .Top          = 161
1416:             .Left         = 451
1417:             .Width        = 50
1418:             .Height       = 50
1419:             .FontName     = "Tahoma"
1420:             .FontSize     = 8
1421:             .MousePointer = 15
1422:             .Visible      = .T.
1423:         ENDWITH
1424:         BINDEVENT(par_oPgGrupos.cmd_4c_ApagarGrupo, "Click", THIS, "BtnApagarGrupoClick")
1425:     ENDPROC
1426: 
1427:     *====================================================================
1428:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1429:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1430:     *====================================================================
1431:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1432:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1433:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1434: 
1435:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1436:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1437:             RETURN
1438:         ENDIF
1439: 
1440:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1441:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1442: 
1443:         IF EMPTY(loc_cCpros)
1444:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1445:             RETURN
1446:         ENDIF
1447: 
1448:         TRY
1449:             IF USED("cursor_4c_FigJpg")
1450:                 USE IN cursor_4c_FigJpg
1451:             ENDIF
1452:             loc_nResult = SQLEXEC(gnConnHandle, ;
1453:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1454:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1455:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1456:                     !EOF("cursor_4c_FigJpg") AND ;
1457:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1458:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1459:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1460:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1461:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1462:             ELSE
1463:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1464:             ENDIF
1465:             IF USED("cursor_4c_FigJpg")
1466:                 USE IN cursor_4c_FigJpg
1467:             ENDIF
1468:         CATCH TO loException
1469:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")
1470:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1471:         ENDTRY
1472:     ENDPROC
1473: 
1474:     *====================================================================
1475:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1476:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1477:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1478:     *====================================================================
1479:     PROCEDURE ValidarProdutoCodigo()
1480:         LOCAL loc_cCpros, loc_oBusca
1481: 
1482:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1483:             RETURN .T.
1484:         ENDIF
1485: 
1486:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1487: 
1488:         IF EMPTY(loc_cCpros)
1489:             REPLACE cursor_4c_Itens.DPros WITH ""
1490:             REPLACE cursor_4c_Itens.CBars WITH 0
1491:             RETURN .T.
1492:         ENDIF
1493: 
1494:         TRY
1495:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1496:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1497:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1498:                     SELECT cursor_4c_BuscaProd
1499:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1500:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1501:                 ENDIF
1502:                 IF USED("cursor_4c_BuscaProd")
1503:                     USE IN cursor_4c_BuscaProd
1504:                 ENDIF
1505:             ELSE
1506:                 IF USED("cursor_4c_BuscaProd")
1507:                     USE IN cursor_4c_BuscaProd
1508:                 ENDIF
1509:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1510:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1511:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1512:                 IF VARTYPE(loc_oBusca) = "O"
1513:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
1514:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cPros", "dPros", ;
1515:                         "Selecionar Produto")
1516:                     IF loc_oBusca.Mostrar()
1517:                         REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1518:                         REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1519:                     ELSE
1520:                         REPLACE cursor_4c_Itens.CPros WITH ""
1521:                         REPLACE cursor_4c_Itens.DPros WITH ""
1522:                         REPLACE cursor_4c_Itens.CBars WITH 0
1523:                     ENDIF
1524:                     loc_oBusca.Release()
1525:                 ENDIF
1526:                 IF USED("cursor_4c_BuscaProd")
1527:                     USE IN cursor_4c_BuscaProd
1528:                 ENDIF
1529:             ENDIF
1530:         CATCH TO loException
1531:             MostrarErro(loException, "FormPrm.ValidarProdutoCodigo")
1532:             IF USED("cursor_4c_BuscaProd")
1533:                 USE IN cursor_4c_BuscaProd
1534:             ENDIF
1535:         ENDTRY
1536: 
1537:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1538:         RETURN .T.
1539:     ENDPROC
1540: 
1541:     *====================================================================
1542:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1543:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1544:     *====================================================================
1545:     PROCEDURE GridProdutosDatasValid()
1546:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1547:             RETURN .T.
1548:         ENDIF
1549: 
1550:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1551:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1552:             TRY
1553:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1554:                 GO BOTTOM IN cursor_4c_Itens
1555:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1556:             CATCH TO loException
1557:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1558:             ENDTRY
1559:         ENDIF
1560: 
1561:         RETURN .T.
1562:     ENDPROC
1563: 
1564:     *====================================================================
1565:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1566:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1567:     *====================================================================
1568:     PROCEDURE GridCheckVendavelClick()
1569:         LOCAL loc_oChk
1570:         TRY
1571:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1572:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1573:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1574:                 IF VARTYPE(loc_oChk) = "O"
1575:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1576:                 ENDIF
1577:             ENDIF
1578:         CATCH TO loException
1579:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *====================================================================
1584:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1585:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1586:     *====================================================================
1587:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1588:         LOCAL loc_oPg2
1589:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1590: 
1591:         IF par_nKeyCode = 9
1592:             IF BITAND(par_nShiftAltCtrl, 1) = 1
1593:                 *-- SHIFT+TAB: voltar para campo Promocao
1594:                 loc_oPg2.txt_4c_Promos.SetFocus
1595:             ELSE
1596:                 *-- TAB: ir para botao Confirmar
1597:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1598:             ENDIF
1599:         ENDIF
1600:     ENDPROC
1601: 
1602:     *====================================================================
1603:     * BuscaItemValid - Valid do txt_4c_Busca: navega no grid de produtos
1604:     * Legado: getBusca.Valid - SEEK by CPros in csSigPrPmi
1605:     *====================================================================
1606:     PROCEDURE BuscaItemValid()
1607:         LOCAL loc_oPgP, loc_cBusca
1608:         loc_oPgP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1609:         loc_cBusca = ALLTRIM(loc_oPgP.txt_4c_Busca.Value)
1610: 
1611:         IF EMPTY(loc_cBusca) OR !USED("cursor_4c_Itens")
1612:             RETURN .T.
1613:         ENDIF
1614: 
1615:         SELECT cursor_4c_Itens
1616:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1617: 
1618:         IF FOUND()
1619:             loc_oPgP.grd_4c_Produtos.Refresh
1620:         ENDIF
1621: 
1622:         RETURN .T.
1623:     ENDPROC
1624: 
1625:     *====================================================================
1626:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1627:     * Legado: getBusca.LostFocus - focus col_CPros
1628:     *====================================================================
1629:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1630:         LOCAL loc_oPgP
1631:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1632: 
1633:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1634:             loc_oPgP.grd_4c_Produtos.SetFocus
1635:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1636:             loc_oPgP.grd_4c_Produtos.Refresh
1637:         ENDIF
1638:     ENDPROC
1639: 
1640:     *====================================================================
1641:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1642:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1643:     *====================================================================
1644:     PROCEDURE BtnApagarItemClick()
1645:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1646:         loc_lAbortou = .F.
1647: 
1648:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1649:             RETURN
1650:         ENDIF
1651: 
1652:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1653:             RETURN
1654:         ENDIF
1655: 
1656:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1657: 
1658:         TRY
1659:             *-- Excluir do banco se registro ja persistido
1660:             IF !EMPTY(loc_cIdChaves)
1661:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1662:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1663:                 IF loc_nResult < 0
1664:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1665:                     loc_lAbortou = .T.
1666:                 ENDIF
1667:             ENDIF
1668: 
1669:             IF !loc_lAbortou
1670:                 SELECT cursor_4c_Itens
1671:                 DELETE
1672:                 PACK
1673:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1674:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1675:                 ENDIF
1676:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1677:             ENDIF
1678:         CATCH TO loException
1679:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1680:         ENDTRY
1681:     ENDPROC
1682: 
1683:     *====================================================================
1684:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1685:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1686:     *====================================================================
1687:     PROCEDURE ValidarColecao()
1688:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1689: 
1690:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1691:             RETURN .T.
1692:         ENDIF
1693: 
1694:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1695: 
1696:         IF EMPTY(loc_cColecoes)
1697:             RETURN .T.
1698:         ENDIF
1699: 
1700:         TRY
1701:             IF USED("cursor_4c_BuscaCol")
1702:                 USE IN cursor_4c_BuscaCol
1703:             ENDIF
1704:             loc_nResult = SQLEXEC(gnConnHandle, ;
1705:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1706:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1707: 
1708:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1709:                 *-- Encontrado: manter valor atual
1710:             ELSE
1711:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1712:                 IF USED("cursor_4c_BuscaCol")
1713:                     USE IN cursor_4c_BuscaCol
1714:                 ENDIF
1715:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1716: 
1717:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1718:                 IF VARTYPE(loc_oBusca) = "O"
1719:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCol"
1720:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1721:                         "Selecionar Grupo de Venda")
1722:                     IF loc_oBusca.Mostrar()
1723:                         REPLACE cursor_4c_Grupos.Colecoes WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1724:                     ELSE
1725:                         REPLACE cursor_4c_Grupos.Colecoes WITH ""
1726:                     ENDIF
1727:                     loc_oBusca.Release()
1728:                 ENDIF
1729:                 IF USED("cursor_4c_BuscaCol")
1730:                     USE IN cursor_4c_BuscaCol
1731:                 ENDIF
1732:             ENDIF
1733:             IF USED("cursor_4c_BuscaCol")
1734:                 USE IN cursor_4c_BuscaCol
1735:             ENDIF
1736:         CATCH TO loException
1737:             MostrarErro(loException, "FormPrm.ValidarColecao")
1738:         ENDTRY
1739: 
1740:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1741:         RETURN .T.
1742:     ENDPROC
1743: 
1744:     *====================================================================
1745:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1746:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1747:     *====================================================================
1748:     PROCEDURE ValidarDataGrupo()
1749:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1750:             RETURN .T.
1751:         ENDIF
1752: 
1753:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1754:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1755:             TRY
1756:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1757:                 GO BOTTOM IN cursor_4c_Grupos
1758:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1759:             CATCH TO loException
1760:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1761:             ENDTRY
1762:         ENDIF
1763: 
1764:         RETURN .T.
1765:     ENDPROC
1766: 
1767:     *====================================================================
1768:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1769:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1770:     *====================================================================
1771:     PROCEDURE BtnApagarGrupoClick()
1772:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1773:         loc_lAbortou = .F.
1774: 
1775:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1776:             RETURN
1777:         ENDIF
1778: 
1779:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1780:             RETURN
1781:         ENDIF
1782: 
1783:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1784: 
1785:         TRY
1786:             *-- Excluir do banco se registro ja persistido
1787:             IF !EMPTY(loc_cIdChaves)
1788:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1789:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1790:                 IF loc_nResult < 0
1791:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1792:                     loc_lAbortou = .T.
1793:                 ENDIF
1794:             ENDIF
1795: 
1796:             IF !loc_lAbortou
1797:                 SELECT cursor_4c_Grupos
1798:                 DELETE
1799:                 PACK
1800:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1801:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1802:                 ENDIF
1803:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1804:             ENDIF
1805:         CATCH TO loException
1806:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1807:         ENDTRY
1808:     ENDPROC
1809: 
1810:     *====================================================================
1811:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1812:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1813:     *====================================================================
1814:     PROCEDURE GradesActivate()
1815:         LOCAL loc_cPromos, loc_oPg2
1816:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1817:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1818: 
1819:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Grupos")
1820:             RETURN
1821:         ENDIF
1822: 
1823:         TRY
1824:             GO BOTTOM IN cursor_4c_Grupos
1825:             IF EOF("cursor_4c_Grupos") OR ;
1826:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1827:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1828:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1829:                     VALUES (loc_cPromos, DATETIME())
1830:             ENDIF
1831:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1832:         CATCH TO loException
1833:             MostrarErro(loException, "FormPrm.GradesActivate")
1834:         ENDTRY
1835:     ENDPROC
1836: 
1837: ENDDEFINE


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

