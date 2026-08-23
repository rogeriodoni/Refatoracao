# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrm.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1825 linhas total):

*-- Linhas 31 a 187:
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
72:             THIS.ConfigurarPaginaLista()
73:             THIS.ConfigurarPaginaDados()
74: 
75:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
76:                 THIS.CarregarLista()
77:             ENDIF
78: 
79:             THIS.pgf_4c_Paginas.Visible = .T.
80:             THIS.pgf_4c_Paginas.ActivePage = 1
81:             THIS.this_cModoAtual = "LISTA"
82:             loc_lSucesso = .T.
83:         CATCH TO loException
84:             MostrarErro(loException, "FormPrm.InicializarForm")
85:         ENDTRY
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *====================================================================
90:     * CriarCursoresLocais - Cria cursores de trabalho locais
91:     * Equivalente ao LOAD do legado (Load nao existe em .prg)
92:     * csSigPrPmi: produtos/itens da promocao (edicao em grid)
93:     * TcrSigPrPmi: log temporario de alteracoes
94:     * csSigPrPmv: grupos de venda da promocao (edicao em grid)
95:     *====================================================================
96:     PROTECTED PROCEDURE CriarCursoresLocais()
97:         SET NULL ON
98:         CREATE CURSOR csSigPrPmi (CPros c(14), DPros c(40), Pecas c(10), ;
99:             Promos c(25), CBars n(8), Datas d NULL, DtAlts t NULL, ;
100:             PromoPro c(35), Vendavels n(1), cIdChaves c(20))
101:         SELECT csSigPrPmi
102:         INDEX ON CPros TAG CPros
103: 
104:         CREATE CURSOR TcrSigPrPmi (CPros c(14), Datas d NULL, Pecas c(10), Vendavels n(1))
105:         INDEX ON CPros TAG idxTcpros
106: 
107:         CREATE CURSOR csSigPrPmv (Promos c(25), Colecoes c(10), Datas t NULL, cIdChaves c(20))
108:         SELECT csSigPrPmv
109: 
110:         CREATE CURSOR cursor_4c_Itens ;
111:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
112:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
113:              PromoPro C(35), Vendavels N(1,0) NULL)
114:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
115: 
116:         CREATE CURSOR cursor_4c_Grupos ;
117:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
118:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
119: 
120:         SET NULL OFF
121:     ENDPROC
122: 
123:     *====================================================================
124:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
125:     *====================================================================
126:     PROTECTED PROCEDURE ConfigurarPageFrame()
127:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
128:         WITH THIS.pgf_4c_Paginas
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .PageCount = 2
134:             .Tabs      = .F.
135:             .TabStop   = .F.
136:             .Visible   = .T.
137:             .Page1.Caption = "Lista"
138:             .Page2.Caption = "Dados"
139:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141:         ENDWITH
142:     ENDPROC
143: 
144:     *====================================================================
145:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
146:     *====================================================================
147:     PROTECTED PROCEDURE ConfigurarPaginaLista()
148:         LOCAL loc_oPagina, loc_oGrid
149:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
150: 
151:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
152:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
153: 
154:         *-- Container cabecalho - Top=31 (2 + 29 compensacao PageFrame.Top=-29)
155:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
156:         WITH loc_oPagina.cnt_4c_Cabecalho
157:             .Top         = 31
158:             .Left        = 0
159:             .Width       = THIS.Width
160:             .Height      = 80
161:             .BackColor   = RGB(100, 100, 100)
162:             .BorderWidth = 0
163: 
164:             .AddObject("lbl_4c_Sombra", "Label")
165:             WITH .lbl_4c_Sombra
166:                 .Top       = 15
167:                 .Left      = 10
168:                 .Width     = THIS.Width
169:                 .Height    = 40
170:                 .Caption   = THIS.Caption
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 16
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(0, 0, 0)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             .AddObject("lbl_4c_Titulo", "Label")
180:             WITH .lbl_4c_Titulo
181:                 .Top       = 18
182:                 .Left      = 10
183:                 .Width     = THIS.Width
184:                 .Height    = 46
185:                 .Caption   = THIS.Caption
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 16

*-- Linhas 319 a 444:
319:             ENDWITH
320:         ENDWITH
321: 
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
326:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
327: 
328:         *-- Container saida (padrao canonico, Top=29)
329:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
330:         WITH loc_oPagina.cnt_4c_Saida
331:             .Top         = 29
332:             .Left        = 917
333:             .Width       = 90
334:             .Height      = 85
335:             .BackStyle   = 0
336:             .BorderWidth = 0
337:             .Visible     = .T.
338: 
339:             .AddObject("cmd_4c_Encerrar", "CommandButton")
340:             WITH .cmd_4c_Encerrar
341:                 .Caption         = "Encerrar"
342:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
343:                 .PicturePosition = 13
344:                 .Top             = 5
345:                 .Left            = 917
346:                 .Width           = 75
347:                 .Height          = 75
348:                 .BackColor       = RGB(255, 255, 255)
349:                 .ForeColor       = RGB(90, 90, 90)
350:                 .FontName        = "Comic Sans MS"
351:                 .FontSize        = 8
352:                 .FontBold        = .T.
353:                 .FontItalic      = .T.
354:                 .SpecialEffect   = 0
355:                 .MousePointer    = 15
356:                 .WordWrap        = .T.
357:                 .AutoSize        = .F.
358:                 .Visible         = .T.
359:             ENDWITH
360:         ENDWITH
361: 
362:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
363: 
364:         *-- Grid principal: Top=117 (88+29), Width=910 (nao sobrepoem cnt_4c_Saida em Left=917)
365:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
366:         loc_oGrid = loc_oPagina.grd_4c_Lista
367:         loc_oGrid.RecordSource = ""
368:         loc_oGrid.ColumnCount  = 5
369:         WITH loc_oGrid
370:             .Top                = 117
371:             .Left               = 0
372:             .Width              = 910
373:             .Height             = 478
374:             .FontName           = "Verdana"
375:             .FontSize           = 8
376:             .ForeColor          = RGB(90, 90, 90)
377:             .BackColor          = RGB(255, 255, 255)
378:             .GridLineColor      = RGB(238, 238, 238)
379:             .GridLines          = 3
380:             .HighlightBackColor = RGB(255, 255, 255)
381:             .HighlightForeColor = RGB(15, 41, 104)
382:             .HighlightStyle     = 2
383:             .DeleteMark         = .F.
384:             .RecordMark         = .F.
385:             .RowHeight          = 16
386:             .ScrollBars         = 2
387:             .ReadOnly           = .T.
388:             .Visible            = .T.
389:             .Column1.Width      = 250
390:             .Column2.Width      = 60
391:             .Column3.Width      = 85
392:             .Column4.Width      = 60
393:             .Column5.Width      = 200
394:         ENDWITH
395: 
396:         THIS.TornarControlesVisiveis(loc_oPagina)
397:     ENDPROC
398: 
399:     *====================================================================
400:     * ConfigurarPaginaDados - Configura Page2 (Dados) com campos do cabecalho
401:     * Fase 5: botoes, campos principais (Promos, Codigo, Comissao, eCommerce)
402:     * Fase 6: sub-pageframe pgGrades com grids de produtos e grupos
403:     *====================================================================
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPagina
406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
407: 
408:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *-- Container botoes Confirmar/Cancelar (canonico: Top=33, Left=842)
412:         *-- Legado: Grupo_Salva.Left=611, Top=13 -> usar canonico
413:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
414:         WITH loc_oPagina.cnt_4c_BotoesAcao
415:             .Top         = 33
416:             .Left        = 842
417:             .Width       = 160
418:             .Height      = 85
419:             .BackStyle   = 0
420:             .BorderWidth = 0
421:             .Visible     = .T.
422: 
423:             .AddObject("cmd_4c_Confirmar", "CommandButton")
424:             WITH .cmd_4c_Confirmar
425:                 .Caption         = "Confirmar"
426:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
427:                 .PicturePosition = 13
428:                 .Top             = 5
429:                 .Left            = 5
430:                 .Width           = 75
431:                 .Height          = 75
432:                 .BackColor       = RGB(255, 255, 255)
433:                 .ForeColor       = RGB(90, 90, 90)
434:                 .FontName        = "Comic Sans MS"
435:                 .FontSize        = 8
436:                 .FontBold        = .T.
437:                 .FontItalic      = .T.
438:                 .SpecialEffect   = 0
439:                 .MousePointer    = 15
440:                 .WordWrap        = .T.
441:                 .AutoSize        = .F.
442:                 .Visible         = .T.
443:             ENDWITH
444: 

*-- Linhas 466 a 510:
466:             ENDWITH
467:         ENDWITH
468: 
469:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
470:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
471: 
472:         *-- Label "Promoção :" + txt_4c_Promos
473:         *-- Legado: lbl_promocao Top=133, Left=31 -> compensado +29 = 162
474:         *-- Legado: get_promos   Top=130, Left=101 -> compensado +29 = 159
475:         loc_oPagina.AddObject("lbl_4c_Promocao", "Label")
476:         WITH loc_oPagina.lbl_4c_Promocao
477:             .Caption   = "Promo" + CHR(231) + CHR(227) + "o :"
478:             .Top       = 162
479:             .Left      = 31
480:             .Width     = 68
481:             .Height    = 15
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .ForeColor = RGB(90, 90, 90)
485:             .BackStyle = 0
486:             .Alignment = 1
487:             .Visible   = .T.
488:         ENDWITH
489: 
490:         loc_oPagina.AddObject("txt_4c_Promos", "TextBox")
491:         WITH loc_oPagina.txt_4c_Promos
492:             .Value     = ""
493:             .Top       = 159
494:             .Left      = 101
495:             .Width     = 185
496:             .Height    = 23
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .MaxLength = 25
500:             .Visible   = .T.
501:         ENDWITH
502: 
503:         *-- Label "Código :" + txt_4c_Codigo
504:         *-- Legado: Say1     Top=157, Left=48  -> compensado +29 = 186
505:         *-- Legado: getCodigo Top=154, Left=101 -> compensado +29 = 183
506:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
507:         WITH loc_oPagina.lbl_4c_Codigo
508:             .Caption   = "C" + CHR(243) + "digo :"
509:             .Top       = 186
510:             .Left      = 48

*-- Linhas 595 a 1825:
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         *-- BINDEVENTs validacao e lookup
599:         BINDEVENT(loc_oPagina.txt_4c_Promos,    "KeyPress",         THIS, "ValidarPromos")
600:         BINDEVENT(loc_oPagina.txt_4c_LPrecos,   "KeyPress",         THIS, "ValidarLPrecos")
601:         BINDEVENT(loc_oPagina.chk_4c_Comissao,  "InteractiveChange", THIS, "chkComissaoChanged")
602:         BINDEVENT(loc_oPagina.chk_4c_eCommerce, "InteractiveChange", THIS, "chkeCommerceChanged")
603: 
604:         *-- Sub-pageframe para produtos e grupos de venda
605:         *-- Legado: pgGrades Top=181 -> compensado +29 = 210 (em Page2 do pgf_4c_Paginas com Top=-29)
606:         loc_oPagina.AddObject("pgf_4c_Grades", "PageFrame")
607:         WITH loc_oPagina.pgf_4c_Grades
608:             .Top       = 210
609:             .Left      = 23
610:             .Width     = 762
611:             .Height    = 396
612:             .PageCount = 2
613:             .Tabs      = .T.
614:             .TabStop   = .F.
615:             .Page1.Caption = "Produtos"
616:             .Page2.Caption = "Grupos de Venda"
617:         ENDWITH
618: 
619:         THIS.ConfigurarGradeProdutos(loc_oPagina.pgf_4c_Grades.Page1)
620:         THIS.ConfigurarGradeGrupos(loc_oPagina.pgf_4c_Grades.Page2)
621: 
622:         BINDEVENT(loc_oPagina.pgf_4c_Grades.Page2, "Activate", THIS, "GradesActivate")
623: 
624:         THIS.TornarControlesVisiveis(loc_oPagina)
625: 
626:         *-- Imagem inicialmente invisivel (mostra somente quando produto tem foto)
627:         loc_oPagina.pgf_4c_Grades.Page1.img_4c_ImgProd.Visible = .F.
628:     ENDPROC
629: 
630:     *====================================================================
631:     * CarregarLista - Carrega lista de promocoes no grid da Page1
632:     *====================================================================
633:     PROCEDURE CarregarLista()
634:         LOCAL loc_lSucesso, loc_oGrid
635:         loc_lSucesso = .F.
636: 
637:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
638:             loc_lSucesso = .T.
639:         ELSE
640:             TRY
641:                 IF !THIS.this_oBusinessObject.Buscar("")
642:                     loc_lSucesso = .F.
643:                 ELSE
644:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
645:                     loc_oGrid.ColumnCount = 5
646:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
647:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Promos"
648:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Cods"
649:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Comiss"
650:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.eCommerce"
651:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.LPrecos"
652:                     *-- Redefinir Headers APOS RecordSource (obrigatorio - RecordSource os reseta)
653:                     loc_oGrid.Column1.Header1.Caption = "Promo" + CHR(231) + CHR(227) + "o"
654:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "d."
655:                     loc_oGrid.Column3.Header1.Caption = "Comiss%"
656:                     loc_oGrid.Column4.Header1.Caption = "e-Com."
657:                     loc_oGrid.Column5.Header1.Caption = "Lista Pre" + CHR(231) + "os"
658:                     loc_oGrid.Column3.Alignment = 1
659:                     loc_oGrid.Column4.Alignment = 1
660:                     THIS.FormatarGridLista(loc_oGrid)
661:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
662:                         GO TOP IN cursor_4c_Dados
663:                     ENDIF
664:                     loc_lSucesso = .T.
665:                 ENDIF
666:             CATCH TO loException
667:                 MostrarErro(loException, "FormPrm.CarregarLista")
668:             ENDTRY
669:         ENDIF
670: 
671:         RETURN loc_lSucesso
672:     ENDPROC
673: 
674:     *====================================================================
675:     * Destroy - Libera recursos do formulario
676:     *====================================================================
677:     PROCEDURE Destroy()
678:         TRY
679:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
680:                 THIS.this_oBusinessObject = .NULL.
681:             ENDIF
682: 
683:             IF USED("csSigPrPmi")
684:                 USE IN csSigPrPmi
685:             ENDIF
686:             IF USED("TcrSigPrPmi")
687:                 USE IN TcrSigPrPmi
688:             ENDIF
689:             IF USED("csSigPrPmv")
690:                 USE IN csSigPrPmv
691:             ENDIF
692:             IF USED("cursor_4c_Dados")
693:                 USE IN cursor_4c_Dados
694:             ENDIF
695:             IF USED("cursor_4c_Itens")
696:                 USE IN cursor_4c_Itens
697:             ENDIF
698:             IF USED("cursor_4c_Grupos")
699:                 USE IN cursor_4c_Grupos
700:             ENDIF
701:         CATCH TO loException
702:             MsgErro("Erro ao fechar: " + loException.Message, "Erro")
703:         ENDTRY
704:         DODEFAULT()
705:     ENDPROC
706: 
707:     *====================================================================
708:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
709:     *====================================================================
710:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
711:         LOCAL loc_nI, loc_oObjeto, loc_nP
712: 
713:         FOR loc_nI = 1 TO par_oContainer.ControlCount
714:             loc_oObjeto = par_oContainer.Controls(loc_nI)
715: 
716:             IF VARTYPE(loc_oObjeto) = "O"
717:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
718:                     loc_oObjeto.Visible = .T.
719:                 ENDIF
720: 
721:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
722:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
723:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
724:                     ENDFOR
725:                 ENDIF
726: 
727:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
728:                     THIS.TornarControlesVisiveis(loc_oObjeto)
729:                 ENDIF
730:             ENDIF
731:         ENDFOR
732:     ENDPROC
733: 
734:     *====================================================================
735:     * FormatarGridLista - Formata visual do grid principal (Page1)
736:     *====================================================================
737:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
738:         WITH par_oGrid
739:             .FontName = "Tahoma"
740:             .FontSize = 8
741:         ENDWITH
742:     ENDPROC
743: 
744:     *====================================================================
745:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
746:     *====================================================================
747:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
748:         LOCAL loc_lSucesso
749:         loc_lSucesso = .F.
750:         TRY
751:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
752:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
753:                 IF par_nPagina = 1
754:                     THIS.CarregarLista()
755:                 ENDIF
756:                 loc_lSucesso = .T.
757:             ENDIF
758:         CATCH TO loException
759:             MostrarErro(loException, "FormPrm.AlternarPagina")
760:         ENDTRY
761:         RETURN loc_lSucesso
762:     ENDPROC
763: 
764:     *====================================================================
765:     * BtnIncluirClick - Inicia inclusao de nova promocao (PUBLIC)
766:     *====================================================================
767:     PROCEDURE BtnIncluirClick()
768:         THIS.this_oBusinessObject.NovoRegistro()
769:         THIS.LimparCampos()
770:         THIS.this_cModoAtual = "INCLUIR"
771:         THIS.HabilitarCampos(.T.)
772:         THIS.AjustarBotoesPorModo()
773:         THIS.AlternarPagina(2)
774:     ENDPROC
775: 
776:     *====================================================================
777:     * BtnVisualizarClick - Visualiza promocao selecionada em modo leitura (PUBLIC)
778:     *====================================================================
779:     PROCEDURE BtnVisualizarClick()
780:         LOCAL loc_cCidChaves
781:         loc_cCidChaves = ""
782:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
783:             SELECT cursor_4c_Dados
784:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
785:         ENDIF
786:         IF EMPTY(loc_cCidChaves)
787:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
788:             RETURN
789:         ENDIF
790:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
791:             THIS.this_cModoAtual = "VISUALIZAR"
792:             THIS.BOParaForm()
793:             THIS.HabilitarCampos(.F.)
794:             THIS.AjustarBotoesPorModo()
795:             THIS.AlternarPagina(2)
796:         ENDIF
797:     ENDPROC
798: 
799:     *====================================================================
800:     * BtnAlterarClick - Inicia alteracao da promocao selecionada (PUBLIC)
801:     *====================================================================
802:     PROCEDURE BtnAlterarClick()
803:         LOCAL loc_cCidChaves
804:         loc_cCidChaves = ""
805:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
806:             SELECT cursor_4c_Dados
807:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
808:         ENDIF
809:         IF EMPTY(loc_cCidChaves)
810:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
811:             RETURN
812:         ENDIF
813:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
814:             THIS.this_oBusinessObject.EditarRegistro()
815:             THIS.this_cModoAtual = "ALTERAR"
816:             THIS.BOParaForm()
817:             THIS.HabilitarCampos(.T.)
818:             THIS.AjustarBotoesPorModo()
819:             THIS.AlternarPagina(2)
820:         ENDIF
821:     ENDPROC
822: 
823:     *====================================================================
824:     * BtnExcluirClick - Exclui promocao selecionada apos confirmacao (PUBLIC)
825:     *====================================================================
826:     PROCEDURE BtnExcluirClick()
827:         LOCAL loc_cCidChaves, loc_lConfirma
828:         loc_cCidChaves = ""
829:         loc_lConfirma  = .F.
830:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
831:             SELECT cursor_4c_Dados
832:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
833:         ENDIF
834:         IF EMPTY(loc_cCidChaves)
835:             MsgAviso("Selecione uma promo" + CHR(231) + CHR(227) + "o na lista.", "")
836:             RETURN
837:         ENDIF
838:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o desta promo" + ;
839:             CHR(231) + CHR(227) + "o?", "Confirmar Exclus" + CHR(227) + "o")
840:         IF loc_lConfirma
841:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
842:                 IF THIS.this_oBusinessObject.Excluir()
843:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
844:                         "da com sucesso!", "Sucesso")
845:                     THIS.CarregarLista()
846:                 ENDIF
847:             ENDIF
848:         ENDIF
849:     ENDPROC
850: 
851:     *====================================================================
852:     * BtnBuscarClick - Recarrega lista (filtro avancado na Fase 5) (PUBLIC)
853:     *====================================================================
854:     PROCEDURE BtnBuscarClick()
855:         THIS.CarregarLista()
856:     ENDPROC
857: 
858:     *====================================================================
859:     * BtnEncerrarClick - Fecha o formulario (PUBLIC)
860:     *====================================================================
861:     PROCEDURE BtnEncerrarClick()
862:         THIS.Release()
863:     ENDPROC
864: 
865:     *====================================================================
866:     * BtnSalvarClick - Salva promocao (cabecalho + itens + grupos) (PUBLIC)
867:     *====================================================================
868:     PROCEDURE BtnSalvarClick()
869:         LOCAL loc_lSucesso, loc_oPg2
870:         loc_lSucesso = .F.
871:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
872: 
873:         *-- Validacoes obrigatorias ANTES do TRY
874:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Promos.Value))
875:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o inv" + CHR(225) + ;
876:                      "lida!!!", "Campo n" + CHR(227) + "o preenchido")
877:             loc_oPg2.txt_4c_Promos.SetFocus
878:             RETURN
879:         ENDIF
880: 
881:         TRY
882:             THIS.FormParaBO()
883: 
884:             IF THIS.this_cModoAtual == "INCLUIR"
885:                 IF THIS.this_oBusinessObject.VerificarPromoExiste( ;
886:                         THIS.this_oBusinessObject.this_cPromos, ;
887:                         THIS.this_oBusinessObject.this_cCods)
888:                     MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
889:                              CHR(225) + " Cadastrada!!!", "")
890:                     loc_oPg2.txt_4c_Promos.SetFocus
891:                 ELSE
892:                     IF THIS.this_oBusinessObject.Salvar()
893:                         THIS.this_oBusinessObject.SalvarItens( ;
894:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
895:                         THIS.this_oBusinessObject.SalvarGrupos( ;
896:                             ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
897:                         MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
898:                         loc_lSucesso = .T.
899:                     ENDIF
900:                 ENDIF
901:             ELSE
902:                 IF THIS.this_oBusinessObject.Salvar()
903:                     THIS.this_oBusinessObject.SalvarItens( ;
904:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
905:                     THIS.this_oBusinessObject.SalvarGrupos( ;
906:                         ALLTRIM(THIS.this_oBusinessObject.this_cPromos))
907:                     MsgInfo("Promo" + CHR(231) + CHR(227) + "o salva com sucesso!", "Sucesso")
908:                     loc_lSucesso = .T.
909:                 ENDIF
910:             ENDIF
911:         CATCH TO loException
912:             MostrarErro(loException, "FormPrm.BtnSalvarClick")
913:         ENDTRY
914: 
915:         IF loc_lSucesso
916:             THIS.this_cModoAtual = "LISTA"
917:             THIS.AlternarPagina(1)
918:         ENDIF
919:     ENDPROC
920: 
921:     *====================================================================
922:     * BtnCancelarClick - Cancela edicao e retorna para lista (PUBLIC)
923:     *====================================================================
924:     PROCEDURE BtnCancelarClick()
925:         THIS.this_cModoAtual = "LISTA"
926:         THIS.AlternarPagina(1)
927:     ENDPROC
928: 
929:     *====================================================================
930:     * FormParaBO - Transfere valores dos campos do Form para o BO
931:     *====================================================================
932:     PROTECTED PROCEDURE FormParaBO()
933:         LOCAL loc_oPg2
934:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
935: 
936:         THIS.this_oBusinessObject.this_cPromos    = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
937:         THIS.this_oBusinessObject.this_cCods      = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
938:         THIS.this_oBusinessObject.this_nIncentivs = IIF(loc_oPg2.chk_4c_Comissao.Value, 1, 0)
939:         THIS.this_oBusinessObject.this_nComiss    = loc_oPg2.txt_4c_Comiss.Value
940:         THIS.this_oBusinessObject.this_nECommerce = IIF(loc_oPg2.chk_4c_eCommerce.Value, 1, 0)
941:         THIS.this_oBusinessObject.this_cLPrecos   = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
942:     ENDPROC
943: 
944:     *====================================================================
945:     * BOParaForm - Transfere valores do BO para os campos do Form
946:     *====================================================================
947:     PROTECTED PROCEDURE BOParaForm()
948:         LOCAL loc_oPg2, loc_cPromos
949:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
950:         loc_cPromos = ALLTRIM(THIS.this_oBusinessObject.this_cPromos)
951: 
952:         loc_oPg2.txt_4c_Promos.Value    = loc_cPromos
953:         loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCods)
954:         loc_oPg2.chk_4c_Comissao.Value  = (THIS.this_oBusinessObject.this_nIncentivs .Value  = IIF(THIS.this_oBusinessObject.this_nIncentivs = 1, 1, 0))
955:         loc_oPg2.txt_4c_Comiss.Value    = THIS.this_oBusinessObject.this_nComiss
956:         loc_oPg2.chk_4c_eCommerce.Value = (THIS.this_oBusinessObject.this_nECommerce .Value = IIF(THIS.this_oBusinessObject.this_nECommerce = 1, 1, 0))
957:         loc_oPg2.txt_4c_LPrecos.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLPrecos)
958: 
959:         *-- Habilitar dependencias visuais conforme checkboxes
960:         loc_oPg2.txt_4c_Comiss.Enabled  = (THIS.this_oBusinessObject.this_nIncentivs = 1)
961:         loc_oPg2.txt_4c_LPrecos.Enabled = (THIS.this_oBusinessObject.this_nECommerce = 1)
962: 
963:         *-- Carregar itens e grupos nos cursores e atualizar grids
964:         IF !EMPTY(loc_cPromos)
965:             THIS.this_oBusinessObject.BuscarItens(loc_cPromos)
966:             THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
967:         ENDIF
968:         TRY
969:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
970:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
971:         CATCH TO loException
972:             MostrarErro(loException, "FormPrm.BOParaForm")
973:         ENDTRY
974:     ENDPROC
975: 
976:     *====================================================================
977:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
978:     *====================================================================
979:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
980:         LOCAL loc_oPg2
981:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
982: 
983:         *-- Promos e Codigo: editaveis somente em INCLUIR
984:         loc_oPg2.txt_4c_Promos.Enabled = par_lHabilitar AND ;
985:                                           (THIS.this_cModoAtual == "INCLUIR")
986:         loc_oPg2.txt_4c_Codigo.Enabled = par_lHabilitar AND ;
987:                                           (THIS.this_cModoAtual == "INCLUIR")
988: 
989:         *-- Checkboxes: editaveis em INCLUIR/ALTERAR
990:         loc_oPg2.chk_4c_Comissao.Enabled  = par_lHabilitar
991:         loc_oPg2.chk_4c_eCommerce.Enabled = par_lHabilitar AND !(THIS.this_cTipo == "E")
992: 
993:         *-- Campos vinculados ao checkbox
994:         loc_oPg2.txt_4c_Comiss.Enabled = par_lHabilitar AND ;
995:                                           (loc_oPg2.chk_4c_Comissao.Value)
996:         loc_oPg2.txt_4c_LPrecos.Enabled = par_lHabilitar AND ;
997:                                            (loc_oPg2.chk_4c_eCommerce.Value)
998: 
999:         *-- Botoes de acao
1000:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1001:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1002: 
1003:         *-- Grids de edicao: ReadOnly em VISUALIZAR, editaveis em INCLUIR/ALTERAR
1004:         IF PEMSTATUS(loc_oPg2, "pgf_4c_Grades", 5)
1005:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.ReadOnly   = !par_lHabilitar
1006:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.ReadOnly     = !par_lHabilitar
1007:             loc_oPg2.pgf_4c_Grades.Page1.cmd_4c_ApagarItem.Enabled  = par_lHabilitar
1008:             loc_oPg2.pgf_4c_Grades.Page2.cmd_4c_ApagarGrupo.Enabled = par_lHabilitar
1009:         ENDIF
1010:     ENDPROC
1011: 
1012:     *====================================================================
1013:     * LimparCampos - Limpa valores de todos os campos da Page2
1014:     *====================================================================
1015:     PROTECTED PROCEDURE LimparCampos()
1016:         LOCAL loc_oPg2
1017:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1018: 
1019:         loc_oPg2.txt_4c_Promos.Value    = ""
1020:         loc_oPg2.txt_4c_Codigo.Value    = ""
1021:         loc_oPg2.chk_4c_Comissao.Value  = 0
1022:         loc_oPg2.txt_4c_Comiss.Value    = 0
1023:         loc_oPg2.txt_4c_Comiss.Enabled  = .F.
1024:         loc_oPg2.chk_4c_eCommerce.Value = 0
1025:         loc_oPg2.txt_4c_LPrecos.Value   = ""
1026:         loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1027: 
1028:         *-- Recriar cursores de edicao vazios (com linha em branco para o grid)
1029:         IF USED("cursor_4c_Itens")
1030:             USE IN cursor_4c_Itens
1031:         ENDIF
1032:         IF USED("cursor_4c_Grupos")
1033:             USE IN cursor_4c_Grupos
1034:         ENDIF
1035: 
1036:         SET NULL ON
1037:         CREATE CURSOR cursor_4c_Itens ;
1038:             (cIdChaves C(20), CPros C(14), DPros C(40), Pecas C(10), ;
1039:              Promos C(25), CBars N(8,0) NULL, Datas D NULL, DtAlts T NULL, ;
1040:              PromoPro C(35), Vendavels N(1,0) NULL)
1041:         SET NULL OFF
1042:         INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1043: 
1044:         SET NULL ON
1045:         CREATE CURSOR cursor_4c_Grupos ;
1046:             (cIdChaves C(20), Promos C(25), Colecoes C(10), Datas T NULL)
1047:         SET NULL OFF
1048:         INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1049: 
1050:         *-- Atualizar grids com cursores limpos
1051:         TRY
1052:             loc_oPg2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1053:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1054:         CATCH TO loException
1055:             MostrarErro(loException, "FormPrm.LimparCampos")
1056:         ENDTRY
1057:     ENDPROC
1058: 
1059:     *====================================================================
1060:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1061:     *====================================================================
1062:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1063:         LOCAL loc_oPg2
1064:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1065: 
1066:         DO CASE
1067:         CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1068:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1069:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1070:         OTHERWISE
1071:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1072:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1073:         ENDCASE
1074:     ENDPROC
1075: 
1076:     *====================================================================
1077:     * ValidarPromos - Valida campo promocao ao perder foco (PUBLIC - BINDEVENT)
1078:     * Em modo INCLUIR: verifica unicidade e pre-carrega grupos do banco
1079:     *====================================================================
1080:     PROCEDURE ValidarPromos(par_nKeyCode, par_nShiftAltCtrl)
1081:         LOCAL loc_oPg2, loc_cPromos
1082:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1083:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1084: 
1085:         IF EMPTY(loc_cPromos) OR !INLIST(THIS.this_cModoAtual, "INCLUIR")
1086:             RETURN
1087:         ENDIF
1088: 
1089:         IF THIS.this_oBusinessObject.VerificarPromoExiste(loc_cPromos, ;
1090:                 ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1091:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o J" + ;
1092:                      CHR(225) + " Cadastrada!!!", "")
1093:             loc_oPg2.txt_4c_Promos.Value = ""
1094:             loc_oPg2.txt_4c_Promos.SetFocus
1095:             RETURN
1096:         ENDIF
1097: 
1098:         *-- Pre-carregar grupos de venda existentes para esta promocao (se houver)
1099:         THIS.this_oBusinessObject.BuscarGrupos(loc_cPromos)
1100:         TRY
1101:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1102:         CATCH TO loException
1103:             MostrarErro(loException, "FormPrm.ValidarPromos")
1104:         ENDTRY
1105:     ENDPROC
1106: 
1107:     *====================================================================
1108:     * ValidarLPrecos - Valida campo lista de precos ao perder foco (PUBLIC - BINDEVENT)
1109:     * Substitui fwBuscaExt para SigCdLpc
1110:     *====================================================================
1111:     PROCEDURE ValidarLPrecos(par_nKeyCode, par_nShiftAltCtrl)
1112:         LOCAL loc_oPg2, loc_cLPrecos, loc_nResult, loc_oBusca
1113:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1114:         loc_cLPrecos = ALLTRIM(loc_oPg2.txt_4c_LPrecos.Value)
1115: 
1116:         IF EMPTY(loc_cLPrecos)
1117:             RETURN
1118:         ENDIF
1119: 
1120:         TRY
1121:             *-- Tentativa exata primeiro
1122:             IF USED("cursor_4c_BuscaLpc")
1123:                 USE IN cursor_4c_BuscaLpc
1124:             ENDIF
1125:             loc_nResult = SQLEXEC(gnConnHandle, ;
1126:                 "SELECT TOP 1 LPrecos FROM SigCdLpc WHERE LPrecos = " + ;
1127:                 EscaparSQL(loc_cLPrecos), "cursor_4c_BuscaLpc")
1128: 
1129:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaLpc") AND !EOF("cursor_4c_BuscaLpc")
1130:                 *-- Encontrado exatamente
1131:                 loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(cursor_4c_BuscaLpc.LPrecos)
1132:             ELSE
1133:                 *-- Nao encontrado: busca LIKE + picker (Pattern A canonico)
1134:                 IF USED("cursor_4c_BuscaLpc")
1135:                     USE IN cursor_4c_BuscaLpc
1136:                 ENDIF
1137:                 THIS.this_oBusinessObject.BuscarListaPrecos(loc_cLPrecos)
1138: 
1139:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1140:                 IF VARTYPE(loc_oBusca) = "O"
1141:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaLpc", "LPrecos", "LPrecos", ;
1142:                         "Lista de Pre" + CHR(231) + "os")
1143:                     IF loc_oBusca.Mostrar()
1144:                         loc_oPg2.txt_4c_LPrecos.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1145:                     ELSE
1146:                         loc_oPg2.txt_4c_LPrecos.Value = ""
1147:                     ENDIF
1148:                     loc_oBusca.Release()
1149:                 ENDIF
1150:             ENDIF
1151: 
1152:             IF USED("cursor_4c_BuscaLpc")
1153:                 USE IN cursor_4c_BuscaLpc
1154:             ENDIF
1155:         CATCH TO loException
1156:             MostrarErro(loException, "FormPrm.ValidarLPrecos")
1157:             IF USED("cursor_4c_BuscaLpc")
1158:                 USE IN cursor_4c_BuscaLpc
1159:             ENDIF
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *====================================================================
1164:     * chkComissaoChanged - Habilita/desabilita txt_4c_Comiss (PUBLIC - BINDEVENT)
1165:     *====================================================================
1166:     PROCEDURE chkComissaoChanged()
1167:         LOCAL loc_oPg2
1168:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1169: 
1170:         IF !loc_oPg2.chk_4c_Comissao.Value
1171:             loc_oPg2.txt_4c_Comiss.Value   = 0
1172:             loc_oPg2.txt_4c_Comiss.Enabled = .F.
1173:         ELSE
1174:             loc_oPg2.txt_4c_Comiss.Enabled = .T.
1175:         ENDIF
1176:         loc_oPg2.txt_4c_Comiss.Refresh
1177:     ENDPROC
1178: 
1179:     *====================================================================
1180:     * chkeCommerceChanged - Habilita/desabilita txt_4c_LPrecos (PUBLIC - BINDEVENT)
1181:     *====================================================================
1182:     PROCEDURE chkeCommerceChanged()
1183:         LOCAL loc_oPg2
1184:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1185: 
1186:         IF !loc_oPg2.chk_4c_eCommerce.Value
1187:             loc_oPg2.txt_4c_LPrecos.Value   = ""
1188:             loc_oPg2.txt_4c_LPrecos.Enabled = .F.
1189:         ELSE
1190:             loc_oPg2.txt_4c_LPrecos.Enabled = .T.
1191:         ENDIF
1192:         loc_oPg2.txt_4c_LPrecos.Refresh
1193:     ENDPROC
1194: 
1195:     *====================================================================
1196:     * ConfigurarGradeProdutos - Configura grd_4c_Produtos na aba Produtos
1197:     * Legado: grd_produtos Top=3,Left=8,W=742,H=220, 6 colunas
1198:     *====================================================================
1199:     PROTECTED PROCEDURE ConfigurarGradeProdutos(par_oPgProdutos)
1200:         LOCAL loc_oGrid
1201: 
1202:         par_oPgProdutos.AddObject("grd_4c_Produtos", "Grid")
1203:         loc_oGrid = par_oPgProdutos.grd_4c_Produtos
1204:         WITH loc_oGrid
1205:             .Top             = 3
1206:             .Left            = 8
1207:             .Width           = 742
1208:             .Height          = 220
1209:             .ColumnCount     = 6
1210:             .FontName        = "Tahoma"
1211:             .FontSize        = 8
1212:             .ForeColor       = RGB(90, 90, 90)
1213:             .BackColor       = RGB(255, 255, 255)
1214:             .GridLineColor   = RGB(238, 238, 238)
1215:             .GridLines       = 3
1216:             .HighlightStyle  = 2
1217:             .DeleteMark      = .F.
1218:             .RecordMark      = .F.
1219:             .RowHeight       = 18
1220:             .ScrollBars      = 3
1221:             .ReadOnly        = .F.
1222:         ENDWITH
1223: 
1224:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1225:         loc_oGrid.ColumnCount = 3
1226:         loc_oGrid.RecordSource = "cursor_4c_Itens"
1227: 
1228:         *-- ControlSources e Headers APOS RecordSource (RecordSource reseta Headers)
1229:         WITH loc_oGrid.Column1
1230:             .ControlSource   = "cursor_4c_Itens.CPros"
1231:             .Width           = 100
1232:             .Sparse          = .F.
1233:             .Header1.Caption = "Produto"
1234:         ENDWITH
1235:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarProdutoCodigo")
1236: 
1237:         WITH loc_oGrid.Column2
1238:             .ControlSource   = "cursor_4c_Itens.DPros"
1239:             .Width           = 200
1240:             .ReadOnly        = .T.
1241:             .Sparse          = .F.
1242:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1243:         ENDWITH
1244: 
1245:         WITH loc_oGrid.Column3
1246:             .ControlSource   = "cursor_4c_Itens.Pecas"
1247:             .Width           = 70
1248:             .Sparse          = .F.
1249:             .Header1.Caption = "Pe" + CHR(231) + "a"
1250:         ENDWITH
1251: 
1252:         WITH loc_oGrid.Column4
1253:             .ControlSource   = "cursor_4c_Itens.CBars"
1254:             .Width           = 80
1255:             .Sparse          = .F.
1256:             .ReadOnly        = .T.
1257:             .Header1.Caption = "C" + CHR(243) + "d. Barra"
1258:         ENDWITH
1259: 
1260:         WITH loc_oGrid.Column5
1261:             .ControlSource   = "cursor_4c_Itens.Datas"
1262:             .Width           = 80
1263:             .Sparse          = .F.
1264:             .Header1.Caption = "Data Inicial"
1265:         ENDWITH
1266:         BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GridProdutosDatasValid")
1267: 
1268:         *-- Column6: Vendavels com CheckBox (7 props obrigatorias + Sparse=.F.)
1269:         WITH loc_oGrid.Column6
1270:             .ControlSource   = "cursor_4c_Itens.Vendavels"
1271:             .Width           = 35
1272:             .Sparse          = .F.
1273:             .Header1.Caption = "V"
1274:             .AddObject("chk_4c_Vendavel", "CheckBox")
1275:             WITH .chk_4c_Vendavel
1276:                 .ControlSource = "cursor_4c_Itens.Vendavels"
1277:                 .Caption       = ""
1278:                 .Alignment     = 0
1279:                 .ReadOnly      = .F.
1280:                 .Visible       = .T.
1281:                 .Top           = 9
1282:                 .Left          = 2
1283:                 .Height        = 17
1284:                 .Width         = 22
1285:             ENDWITH
1286:             .CurrentControl  = "chk_4c_Vendavel"
1287:         ENDWITH
1288:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "Click",    THIS, "GridCheckVendavelClick")
1289:         BINDEVENT(loc_oGrid.Column6.chk_4c_Vendavel, "KeyPress", THIS, "GridProdutosKeyPress")
1290: 
1291:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridProdutosAfterRowColChange")
1292: 
1293:         *-- Label "Busca :" (legado: Say2 Top=276,Left=299)
1294:         par_oPgProdutos.AddObject("lbl_4c_Busca", "Label")
1295:         WITH par_oPgProdutos.lbl_4c_Busca
1296:             .Caption   = "Busca :"
1297:             .Top       = 276
1298:             .Left      = 299
1299:             .Width     = 37
1300:             .Height    = 15
1301:             .FontName  = "Tahoma"
1302:             .FontSize  = 8
1303:             .ForeColor = RGB(90, 90, 90)
1304:             .BackStyle = 0
1305:             .Visible   = .T.
1306:         ENDWITH
1307: 
1308:         *-- TextBox busca rapida (legado: getBusca Top=273,Left=344,W=108)
1309:         par_oPgProdutos.AddObject("txt_4c_Busca", "TextBox")
1310:         WITH par_oPgProdutos.txt_4c_Busca
1311:             .Value     = ""
1312:             .Top       = 273
1313:             .Left      = 344
1314:             .Width     = 108
1315:             .Height    = 23
1316:             .FontName  = "Tahoma"
1317:             .FontSize  = 8
1318:             .MaxLength = 14
1319:             .Visible   = .T.
1320:         ENDWITH
1321:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "LostFocus",     THIS, "BuscaItemValid")
1322:         BINDEVENT(par_oPgProdutos.txt_4c_Busca, "KeyPress", THIS, "BuscaItemLostFocus")
1323: 
1324:         *-- Botao Apagar Item (legado: cmdApagar Top=252,Left=551,W=50,H=50)
1325:         par_oPgProdutos.AddObject("cmd_4c_ApagarItem", "CommandButton")
1326:         WITH par_oPgProdutos.cmd_4c_ApagarItem
1327:             .Caption      = "Apagar"
1328:             .Top          = 252
1329:             .Left         = 551
1330:             .Width        = 50
1331:             .Height       = 50
1332:             .FontName     = "Tahoma"
1333:             .FontSize     = 8
1334:             .MousePointer = 15
1335:             .Visible      = .T.
1336:         ENDWITH
1337:         BINDEVENT(par_oPgProdutos.cmd_4c_ApagarItem, "Click", THIS, "BtnApagarItemClick")
1338: 
1339:         *-- Imagem produto (legado: ImgProd Top=228,Left=59,W=175,H=104)
1340:         par_oPgProdutos.AddObject("img_4c_ImgProd", "Image")
1341:         WITH par_oPgProdutos.img_4c_ImgProd
1342:             .Top     = 228
1343:             .Left    = 59
1344:             .Width   = 175
1345:             .Height  = 104
1346:             .Stretch = 2
1347:             .Visible = .F.
1348:         ENDWITH
1349:     ENDPROC
1350: 
1351:     *====================================================================
1352:     * ConfigurarGradeGrupos - Configura grd_4c_Grupos na aba Grupos de Venda
1353:     * Legado: grdColecoes Top=24,Left=256,W=192,H=324, 2 colunas
1354:     *====================================================================
1355:     PROTECTED PROCEDURE ConfigurarGradeGrupos(par_oPgGrupos)
1356:         LOCAL loc_oGrid
1357: 
1358:         par_oPgGrupos.AddObject("grd_4c_Grupos", "Grid")
1359:         loc_oGrid = par_oPgGrupos.grd_4c_Grupos
1360:         WITH loc_oGrid
1361:             .Top             = 24
1362:             .Left            = 256
1363:             .Width           = 192
1364:             .Height          = 324
1365:             .ColumnCount     = 2
1366:             .FontName        = "Tahoma"
1367:             .FontSize        = 8
1368:             .ForeColor       = RGB(90, 90, 90)
1369:             .BackColor       = RGB(255, 255, 255)
1370:             .GridLineColor   = RGB(238, 238, 238)
1371:             .GridLines       = 3
1372:             .HighlightStyle  = 2
1373:             .DeleteMark      = .F.
1374:             .RecordMark      = .F.
1375:             .RowHeight       = 18
1376:             .ScrollBars      = 3
1377:             .ReadOnly        = .F.
1378:         ENDWITH
1379: 
1380:         *-- RecordSource FORA do WITH (auto-bind VFP9); ControlSources redefinidos logo apos
1381:         loc_oGrid.ColumnCount = 3
1382:         loc_oGrid.RecordSource = "cursor_4c_Grupos"
1383: 
1384:         *-- ControlSources e Headers APOS RecordSource
1385:         WITH loc_oGrid.Column1
1386:             .ControlSource   = "cursor_4c_Grupos.Colecoes"
1387:             .Width           = 80
1388:             .Sparse          = .F.
1389:             .Header1.Caption = "Grp. Venda"
1390:         ENDWITH
1391:         BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "ValidarColecao")
1392: 
1393:         WITH loc_oGrid.Column2
1394:             .ControlSource   = "cursor_4c_Grupos.Datas"
1395:             .Width           = 80
1396:             .Sparse          = .F.
1397:             .Header1.Caption = "Data Inicial"
1398:         ENDWITH
1399:         BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "ValidarDataGrupo")
1400: 
1401:         *-- Botao Apagar Grupo (legado: cmdApagar Top=161,Left=451,W=50,H=50)
1402:         par_oPgGrupos.AddObject("cmd_4c_ApagarGrupo", "CommandButton")
1403:         WITH par_oPgGrupos.cmd_4c_ApagarGrupo
1404:             .Caption      = "Apagar"
1405:             .Top          = 161
1406:             .Left         = 451
1407:             .Width        = 50
1408:             .Height       = 50
1409:             .FontName     = "Tahoma"
1410:             .FontSize     = 8
1411:             .MousePointer = 15
1412:             .Visible      = .T.
1413:         ENDWITH
1414:         BINDEVENT(par_oPgGrupos.cmd_4c_ApagarGrupo, "Click", THIS, "BtnApagarGrupoClick")
1415:     ENDPROC
1416: 
1417:     *====================================================================
1418:     * GridProdutosAfterRowColChange - Carrega imagem do produto ao mudar linha
1419:     * Legado: grd_produtos.AfterRowColChange - SQLEXEC FigJpgs FROM SigCdPro
1420:     *====================================================================
1421:     PROCEDURE GridProdutosAfterRowColChange(par_nColIndex)
1422:         LOCAL loc_cCpros, loc_nResult, loc_cArqTemp, loc_oPgP
1423:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1424: 
1425:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1426:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1427:             RETURN
1428:         ENDIF
1429: 
1430:         loc_cCpros   = ALLTRIM(cursor_4c_Itens.CPros)
1431:         loc_cArqTemp = SYS(2023) + "4c_imgprod.jpg"
1432: 
1433:         IF EMPTY(loc_cCpros)
1434:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1435:             RETURN
1436:         ENDIF
1437: 
1438:         TRY
1439:             IF USED("cursor_4c_FigJpg")
1440:                 USE IN cursor_4c_FigJpg
1441:             ENDIF
1442:             loc_nResult = SQLEXEC(gnConnHandle, ;
1443:                 "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE cpros = " + ;
1444:                 EscaparSQL(loc_cCpros), "cursor_4c_FigJpg")
1445:             IF loc_nResult > 0 AND USED("cursor_4c_FigJpg") AND ;
1446:                     !EOF("cursor_4c_FigJpg") AND ;
1447:                     !ISNULL(cursor_4c_FigJpg.FigJpgs) AND ;
1448:                     LEN(cursor_4c_FigJpg.FigJpgs) > 0
1449:                 STRTOFILE(cursor_4c_FigJpg.FigJpgs, loc_cArqTemp)
1450:                 loc_oPgP.img_4c_ImgProd.Picture = loc_cArqTemp
1451:                 loc_oPgP.img_4c_ImgProd.Visible = .T.
1452:             ELSE
1453:                 loc_oPgP.img_4c_ImgProd.Visible = .F.
1454:             ENDIF
1455:             IF USED("cursor_4c_FigJpg")
1456:                 USE IN cursor_4c_FigJpg
1457:             ENDIF
1458:         CATCH TO loException
1459:             MostrarErro(loException, "FormPrm.GridProdutosAfterRowColChange")
1460:             loc_oPgP.img_4c_ImgProd.Visible = .F.
1461:         ENDTRY
1462:     ENDPROC
1463: 
1464:     *====================================================================
1465:     * ValidarProdutoCodigo - Valida CPros na Column1 do grd_4c_Produtos
1466:     * Legado: txt_cpros.Valid - busca SigCdPro + deteccao de codigo de barras (SigOpEtq)
1467:     * Usa BuscarProdutoPorCodigo do BO que trata barcode automaticamente
1468:     *====================================================================
1469:     PROCEDURE ValidarProdutoCodigo()
1470:         LOCAL loc_cCpros, loc_oBusca
1471: 
1472:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1473:             RETURN .T.
1474:         ENDIF
1475: 
1476:         loc_cCpros = ALLTRIM(cursor_4c_Itens.CPros)
1477: 
1478:         IF EMPTY(loc_cCpros)
1479:             REPLACE cursor_4c_Itens.DPros WITH ""
1480:             REPLACE cursor_4c_Itens.CBars WITH 0
1481:             RETURN .T.
1482:         ENDIF
1483: 
1484:         TRY
1485:             *-- BO detecta automaticamente se e codigo de barras (SigOpEtq) ou codigo de produto (SigCdPro)
1486:             IF THIS.this_oBusinessObject.BuscarProdutoPorCodigo(loc_cCpros)
1487:                 IF USED("cursor_4c_BuscaProd") AND !EOF("cursor_4c_BuscaProd")
1488:                     SELECT cursor_4c_BuscaProd
1489:                     REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(cursor_4c_BuscaProd.cPros)
1490:                     REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(cursor_4c_BuscaProd.dPros)
1491:                 ENDIF
1492:                 IF USED("cursor_4c_BuscaProd")
1493:                     USE IN cursor_4c_BuscaProd
1494:                 ENDIF
1495:             ELSE
1496:                 IF USED("cursor_4c_BuscaProd")
1497:                     USE IN cursor_4c_BuscaProd
1498:                 ENDIF
1499:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1500:                 THIS.this_oBusinessObject.BuscarProdutoParaLookup(loc_cCpros)
1501:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1502:                 IF VARTYPE(loc_oBusca) = "O"
1503:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cPros", "dPros", ;
1504:                         "Selecionar Produto")
1505:                     IF loc_oBusca.Mostrar()
1506:                         REPLACE cursor_4c_Itens.CPros WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1507:                         REPLACE cursor_4c_Itens.DPros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1508:                     ELSE
1509:                         REPLACE cursor_4c_Itens.CPros WITH ""
1510:                         REPLACE cursor_4c_Itens.DPros WITH ""
1511:                         REPLACE cursor_4c_Itens.CBars WITH 0
1512:                     ENDIF
1513:                     loc_oBusca.Release()
1514:                 ENDIF
1515:                 IF USED("cursor_4c_BuscaProd")
1516:                     USE IN cursor_4c_BuscaProd
1517:                 ENDIF
1518:             ENDIF
1519:         CATCH TO loException
1520:             MostrarErro(loException, "FormPrm.ValidarProdutoCodigo")
1521:             IF USED("cursor_4c_BuscaProd")
1522:                 USE IN cursor_4c_BuscaProd
1523:             ENDIF
1524:         ENDTRY
1525: 
1526:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1527:         RETURN .T.
1528:     ENDPROC
1529: 
1530:     *====================================================================
1531:     * GridProdutosDatasValid - Column5 Valid: adiciona linha na ultima posicao
1532:     * Legado: Column5.Text1.Valid - insere blank se ultima linha e CPros preenchido
1533:     *====================================================================
1534:     PROCEDURE GridProdutosDatasValid()
1535:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1536:             RETURN .T.
1537:         ENDIF
1538: 
1539:         IF RECNO("cursor_4c_Itens") = RECCOUNT("cursor_4c_Itens") AND ;
1540:                 !EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1541:             TRY
1542:                 INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1543:                 GO BOTTOM IN cursor_4c_Itens
1544:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1545:             CATCH TO loException
1546:                 MostrarErro(loException, "FormPrm.GridProdutosDatasValid")
1547:             ENDTRY
1548:         ENDIF
1549: 
1550:         RETURN .T.
1551:     ENDPROC
1552: 
1553:     *====================================================================
1554:     * GridCheckVendavelClick - Click no CheckBox Vendavel na Column6
1555:     * Legado: Column6.Check1.Click - Replace Vendavels With This.Value
1556:     *====================================================================
1557:     PROCEDURE GridCheckVendavelClick()
1558:         LOCAL loc_oChk
1559:         TRY
1560:             IF USED("cursor_4c_Itens") AND !EOF("cursor_4c_Itens")
1561:                 loc_oChk = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1 ;
1562:                     .grd_4c_Produtos.Column6.chk_4c_Vendavel
1563:                 IF VARTYPE(loc_oChk) = "O"
1564:                     REPLACE cursor_4c_Itens.Vendavels WITH IIF(loc_oChk.Value = 1, 1, 0)
1565:                 ENDIF
1566:             ENDIF
1567:         CATCH TO loException
1568:             MostrarErro(loException, "FormPrm.GridCheckVendavelClick")
1569:         ENDTRY
1570:     ENDPROC
1571: 
1572:     *====================================================================
1573:     * GridProdutosKeyPress - KeyPress no CheckBox Vendavel (Column6)
1574:     * Legado: TAB=Salva.SetFocus, SHIFT+TAB=Get_Promos.SetFocus
1575:     *====================================================================
1576:     PROCEDURE GridProdutosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1577:         LOCAL loc_oPg2
1578:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1579: 
1580:         IF par_nKeyCode = 9
1581:             IF BITAND(par_nShiftAltCtrl, 1) = 1
1582:                 *-- SHIFT+TAB: voltar para campo Promocao
1583:                 loc_oPg2.txt_4c_Promos.SetFocus
1584:             ELSE
1585:                 *-- TAB: ir para botao Confirmar
1586:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1587:             ENDIF
1588:         ENDIF
1589:     ENDPROC
1590: 
1591:     *====================================================================
1592:     * BuscaItemValid - Valid do txt_4c_Busca: navega no grid de produtos
1593:     * Legado: getBusca.Valid - SEEK by CPros in csSigPrPmi
1594:     *====================================================================
1595:     PROCEDURE BuscaItemValid()
1596:         LOCAL loc_oPgP, loc_cBusca
1597:         loc_oPgP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1598:         loc_cBusca = ALLTRIM(loc_oPgP.txt_4c_Busca.Value)
1599: 
1600:         IF EMPTY(loc_cBusca) OR !USED("cursor_4c_Itens")
1601:             RETURN .T.
1602:         ENDIF
1603: 
1604:         SELECT cursor_4c_Itens
1605:         LOCATE FOR ALLTRIM(cursor_4c_Itens.CPros) == loc_cBusca
1606: 
1607:         IF FOUND()
1608:             loc_oPgP.grd_4c_Produtos.Refresh
1609:         ENDIF
1610: 
1611:         RETURN .T.
1612:     ENDPROC
1613: 
1614:     *====================================================================
1615:     * BuscaItemLostFocus - LostFocus do txt_4c_Busca: foca Column1 do grid
1616:     * Legado: getBusca.LostFocus - focus col_CPros
1617:     *====================================================================
1618:     PROCEDURE BuscaItemLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1619:         LOCAL loc_oPgP
1620:         loc_oPgP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1
1621: 
1622:         IF PEMSTATUS(loc_oPgP, "grd_4c_Produtos", 5)
1623:             loc_oPgP.grd_4c_Produtos.SetFocus
1624:             loc_oPgP.grd_4c_Produtos.ActiveColumn = 1
1625:             loc_oPgP.grd_4c_Produtos.Refresh
1626:         ENDIF
1627:     ENDPROC
1628: 
1629:     *====================================================================
1630:     * BtnApagarItemClick - Apaga item selecionado no grd_4c_Produtos
1631:     * Legado: cmdApagarClick - DELETE FROM SigPrPmi + DELETE IN cursor
1632:     *====================================================================
1633:     PROCEDURE BtnApagarItemClick()
1634:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1635:         loc_lAbortou = .F.
1636: 
1637:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens")
1638:             RETURN
1639:         ENDIF
1640: 
1641:         IF EMPTY(ALLTRIM(cursor_4c_Itens.CPros))
1642:             RETURN
1643:         ENDIF
1644: 
1645:         loc_cIdChaves = ALLTRIM(cursor_4c_Itens.cIdChaves)
1646: 
1647:         TRY
1648:             *-- Excluir do banco se registro ja persistido
1649:             IF !EMPTY(loc_cIdChaves)
1650:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1651:                     "DELETE FROM SigPrPmi WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1652:                 IF loc_nResult < 0
1653:                     MsgErro("Erro ao excluir item da promo" + CHR(231) + CHR(227) + "o.", "Erro")
1654:                     loc_lAbortou = .T.
1655:                 ENDIF
1656:             ENDIF
1657: 
1658:             IF !loc_lAbortou
1659:                 SELECT cursor_4c_Itens
1660:                 DELETE
1661:                 PACK
1662:                 IF EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1663:                     INSERT INTO cursor_4c_Itens (Datas, Vendavels) VALUES (DATE(), 1)
1664:                 ENDIF
1665:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page1.grd_4c_Produtos.Refresh
1666:             ENDIF
1667:         CATCH TO loException
1668:             MostrarErro(loException, "FormPrm.BtnApagarItemClick")
1669:         ENDTRY
1670:     ENDPROC
1671: 
1672:     *====================================================================
1673:     * ValidarColecao - Valida Colecoes na Column1 do grd_4c_Grupos
1674:     * Legado: Column1.Text1.Valid - fwBuscaExt para SigCdCol
1675:     *====================================================================
1676:     PROCEDURE ValidarColecao()
1677:         LOCAL loc_cColecoes, loc_nResult, loc_oBusca
1678: 
1679:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1680:             RETURN .T.
1681:         ENDIF
1682: 
1683:         loc_cColecoes = ALLTRIM(cursor_4c_Grupos.Colecoes)
1684: 
1685:         IF EMPTY(loc_cColecoes)
1686:             RETURN .T.
1687:         ENDIF
1688: 
1689:         TRY
1690:             IF USED("cursor_4c_BuscaCol")
1691:                 USE IN cursor_4c_BuscaCol
1692:             ENDIF
1693:             loc_nResult = SQLEXEC(gnConnHandle, ;
1694:                 "SELECT TOP 1 colecoes, descs FROM SigCdCol WHERE colecoes = " + ;
1695:                 EscaparSQL(loc_cColecoes), "cursor_4c_BuscaCol")
1696: 
1697:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaCol") AND !EOF("cursor_4c_BuscaCol")
1698:                 *-- Encontrado: manter valor atual
1699:             ELSE
1700:                 *-- Nao encontrado: abrir picker (Pattern A canonico)
1701:                 IF USED("cursor_4c_BuscaCol")
1702:                     USE IN cursor_4c_BuscaCol
1703:                 ENDIF
1704:                 THIS.this_oBusinessObject.BuscarColecaoParaLookup(loc_cColecoes)
1705: 
1706:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1707:                 IF VARTYPE(loc_oBusca) = "O"
1708:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaCol", "colecoes", "descs", ;
1709:                         "Selecionar Grupo de Venda")
1710:                     IF loc_oBusca.Mostrar()
1711:                         REPLACE cursor_4c_Grupos.Colecoes WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
1712:                     ELSE
1713:                         REPLACE cursor_4c_Grupos.Colecoes WITH ""
1714:                     ENDIF
1715:                     loc_oBusca.Release()
1716:                 ENDIF
1717:                 IF USED("cursor_4c_BuscaCol")
1718:                     USE IN cursor_4c_BuscaCol
1719:                 ENDIF
1720:             ENDIF
1721:             IF USED("cursor_4c_BuscaCol")
1722:                 USE IN cursor_4c_BuscaCol
1723:             ENDIF
1724:         CATCH TO loException
1725:             MostrarErro(loException, "FormPrm.ValidarColecao")
1726:         ENDTRY
1727: 
1728:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1729:         RETURN .T.
1730:     ENDPROC
1731: 
1732:     *====================================================================
1733:     * ValidarDataGrupo - Column2 Valid: adiciona linha na ultima posicao
1734:     * Legado: Column2.Text1.Valid - insere blank se ultima linha e Colecoes preenchido
1735:     *====================================================================
1736:     PROCEDURE ValidarDataGrupo()
1737:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1738:             RETURN .T.
1739:         ENDIF
1740: 
1741:         IF RECNO("cursor_4c_Grupos") = RECCOUNT("cursor_4c_Grupos") AND ;
1742:                 !EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1743:             TRY
1744:                 INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1745:                 GO BOTTOM IN cursor_4c_Grupos
1746:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1747:             CATCH TO loException
1748:                 MostrarErro(loException, "FormPrm.ValidarDataGrupo")
1749:             ENDTRY
1750:         ENDIF
1751: 
1752:         RETURN .T.
1753:     ENDPROC
1754: 
1755:     *====================================================================
1756:     * BtnApagarGrupoClick - Apaga grupo selecionado no grd_4c_Grupos
1757:     * Legado: cmdApagarClick - DELETE FROM SigPrPmv + DELETE IN cursor
1758:     *====================================================================
1759:     PROCEDURE BtnApagarGrupoClick()
1760:         LOCAL loc_cIdChaves, loc_nResult, loc_lAbortou
1761:         loc_lAbortou = .F.
1762: 
1763:         IF !USED("cursor_4c_Grupos") OR EOF("cursor_4c_Grupos")
1764:             RETURN
1765:         ENDIF
1766: 
1767:         IF EMPTY(ALLTRIM(cursor_4c_Grupos.Colecoes))
1768:             RETURN
1769:         ENDIF
1770: 
1771:         loc_cIdChaves = ALLTRIM(cursor_4c_Grupos.cIdChaves)
1772: 
1773:         TRY
1774:             *-- Excluir do banco se registro ja persistido
1775:             IF !EMPTY(loc_cIdChaves)
1776:                 loc_nResult = SQLEXEC(gnConnHandle, ;
1777:                     "DELETE FROM SigPrPmv WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves))
1778:                 IF loc_nResult < 0
1779:                     MsgErro("Erro ao excluir grupo de venda.", "Erro")
1780:                     loc_lAbortou = .T.
1781:                 ENDIF
1782:             ENDIF
1783: 
1784:             IF !loc_lAbortou
1785:                 SELECT cursor_4c_Grupos
1786:                 DELETE
1787:                 PACK
1788:                 IF EOF("cursor_4c_Grupos") OR RECCOUNT("cursor_4c_Grupos") = 0
1789:                     INSERT INTO cursor_4c_Grupos (Datas) VALUES (DATETIME())
1790:                 ENDIF
1791:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1792:             ENDIF
1793:         CATCH TO loException
1794:             MostrarErro(loException, "FormPrm.BtnApagarGrupoClick")
1795:         ENDTRY
1796:     ENDPROC
1797: 
1798:     *====================================================================
1799:     * GradesActivate - Sincroniza linha em branco ao mudar aba Grades (PUBLIC - BINDEVENT)
1800:     * Legado: pgGrades.Activate - insere blank em csSigPrPmv ao entrar na aba Grupos
1801:     *====================================================================
1802:     PROCEDURE GradesActivate()
1803:         LOCAL loc_cPromos, loc_oPg2
1804:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1805:         loc_cPromos = ALLTRIM(loc_oPg2.txt_4c_Promos.Value)
1806: 
1807:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") OR !USED("cursor_4c_Grupos")
1808:             RETURN
1809:         ENDIF
1810: 
1811:         TRY
1812:             GO BOTTOM IN cursor_4c_Grupos
1813:             IF EOF("cursor_4c_Grupos") OR ;
1814:                     !EMPTY(ALLTRIM(NVL(cursor_4c_Grupos.Colecoes, "")))
1815:                 DELETE FROM cursor_4c_Grupos WHERE EMPTY(NVL(Colecoes, ""))
1816:                 INSERT INTO cursor_4c_Grupos (Promos, Datas) ;
1817:                     VALUES (loc_cPromos, DATETIME())
1818:             ENDIF
1819:             loc_oPg2.pgf_4c_Grades.Page2.grd_4c_Grupos.Refresh
1820:         CATCH TO loException
1821:             MostrarErro(loException, "FormPrm.GradesActivate")
1822:         ENDTRY
1823:     ENDPROC
1824: 
1825: ENDDEFINE


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

