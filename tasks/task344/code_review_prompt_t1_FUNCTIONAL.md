# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (24)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SAIDA, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CONTAINER-TOGGLE] Container 'CNT_4C_COPIARACESSO' eh flutuante (Visible=.F. toggled por botao) mas TornarControlesVisiveis NAO o filtra. Adicionar verificacao INLIST/IF para pular este container no loop.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_GruposGrid' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_GruposGridTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_EmpresasGrid' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_EmpresasGridTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Programas' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ProgramasTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Barra' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_BarraTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Parâmetro' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cargo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Departamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Parâmetro' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tooltip' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: descrição, Programa, , Parametro, Descrição, Tool Tip Text, Figura, Empresa, Tela, Campo, Status. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Cargo' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Left original=152 vs migrado 'lbl_4c_Cargo' Left=10 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Departamento' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Left original=152 vs migrado 'lbl_4c_Departamento' Left=10 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optsenhadia' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Top original=213 vs migrado 'opt_4c_Optsenhadia' Top=0 (diff=213px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optsenhadia' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Left original=148 vs migrado 'opt_4c_Optsenhadia' Left=0 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optlibpesag' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Top original=240 vs migrado 'opt_4c_Optlibpesag' Top=0 (diff=240px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optlibpesag' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Left original=148 vs migrado 'opt_4c_Optlibpesag' Left=0 (diff=148px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optlibprod' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Top original=266 vs migrado 'opt_4c_Optlibprod' Top=0 (diff=266px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optlibprod' (parent: SIGCDACU.Pagina.Dados.Pagina.Cadastro): Left original=148 vs migrado 'opt_4c_Optlibprod' Left=0 (diff=148px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formacu.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2596 linhas total):

*-- Linhas 31 a 150:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *--------------------------------------------------------------------------
39:     * InicializarForm - Configuracao inicial (chamado pelo FormBase.Init)
40:     *--------------------------------------------------------------------------
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.Caption = "Cadastro de Usu" + CHR(225) + "rios"
47: 
48:             THIS.this_oBusinessObject = CREATEOBJECT("acuBO")
49: 
50:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
51:                 MostrarErro("Erro ao criar Business Object acuBO", "Erro Cr" + CHR(237) + "tico")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.ConfigurarPaginaLista()
55:                 THIS.ConfigurarPaginaDados()
56: 
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible  = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar Formacu:" + CHR(13) + ;
71:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
72:                 loException.Message, "Erro")
73:             loc_lSucesso = .F.
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
81:     * PageFrame.Top = -29 oculta as abas externas (padrao frmcadastro)
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 629
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .F.
94: 
95:             .Page1.Caption  = "Lista"
96:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption  = "Dados"
100:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e botoes CRUD
107:     * Compensacao +29: Top original 0 -> 29, Top 2 -> 31
108:     * Z-order: Cabecalho < Botoes < CmdEspeciais < Grid < CopiarAcesso < Saida
109:     *--------------------------------------------------------------------------
110:     PROTECTED PROCEDURE ConfigurarPaginaLista()
111:         LOCAL loc_oPagina
112:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
113: 
114:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container de cabecalho (cntSombra: Top=2+29=31)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top        = 31
121:             .Left       = 0
122:             .Width      = THIS.Width
123:             .Height     = 80
124:             .BackColor  = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible    = .T.
127: 
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .Caption   = ""
131:                 .Top       = 15
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 40
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16
137:                 .FontBold  = .T.
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .AutoSize  = .F.
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Caption   = ""
147:                 .Top       = 18
148:                 .Left      = 10
149:                 .Width     = THIS.Width
150:                 .Height    = 46

*-- Linhas 331 a 377:
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:             .Visible         = .T.
334:         ENDWITH
335: 
336:         *-- Grid da lista de usuarios (criado antes de cnt_4c_CopiarAcesso para Z-order)
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 12
341:             .Width              = 935
342:             .Height             = 450
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .GridLineColor      = RGB(238, 238, 238)
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         *-- Container "Copiar Acesso" (flutuante sobre grid, inicia oculto)
360:         *-- Top=246+29=275, Left=351 (layout.json original)
361:         loc_oPagina.AddObject("cnt_4c_CopiarAcesso", "Container")
362:         WITH loc_oPagina.cnt_4c_CopiarAcesso
363:             .Top         = 275
364:             .Left        = 351
365:             .Width       = 294
366:             .Height      = 91
367:             .BackColor   = RGB(200, 200, 200)
368:             .BorderWidth = 1
369:             .Visible     = .F.
370: 
371:             .AddObject("lbl_4c_CopiarDe", "Label")
372:             WITH .lbl_4c_CopiarDe
373:                 .Caption   = " Copiar do Usu" + CHR(225) + "rio "
374:                 .Top       = 22
375:                 .Left      = 2
376:                 .Width     = 110
377:                 .Height    = 15

*-- Linhas 474 a 541:
474:             ENDWITH
475:         ENDWITH
476: 
477:         *-- BINDEVENTs botoes da Page1 (Click)
478:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
479:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
480:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
481:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
482:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
483:         BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiarAcessoClick")
484:         BINDEVENT(loc_oPagina.cmd_4c_LimSenha, "Click", THIS, "BtnLimSenhaClick")
485:         BINDEVENT(loc_oPagina.cnt_4c_CopiarAcesso.cmd_4c_EfetuarCopia, "Click", THIS, "BtnEfetuarCopiaClick")
486:         BINDEVENT(loc_oPagina.cnt_4c_CopiarAcesso.cmd_4c_CancelarCopia, "Click", THIS, "BtnCancelarCopiaClick")
487:         BINDEVENT(loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos, "KeyPress", THIS, "CopiarUsuarioKeyPress")
488:         BINDEVENT(loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos, "DblClick", THIS, "CopiarUsuarioDblClick")
489:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
490: 
491:         THIS.TornarControlesVisiveis(loc_oPagina)
492: 
493:         *-- cnt_4c_CopiarAcesso inicia oculto (aparece apenas via BtnCopiarAcessoClick)
494:         loc_oPagina.cnt_4c_CopiarAcesso.Visible = .F.
495:     ENDPROC
496: 
497:     *--------------------------------------------------------------------------
498:     * ConfigurarPaginaDados - Configura Page2 (Dados)
499:     * Compensacao +29 aplicada a todos os controles
500:     *--------------------------------------------------------------------------
501:     PROTECTED PROCEDURE ConfigurarPaginaDados()
502:         LOCAL loc_oPagina
503:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
504: 
505:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
506:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
507: 
508:         *-- Container de botoes Confirmar/Cancelar (cnt_4c_Salva: Top=4+29=33)
509:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
510:         WITH loc_oPagina.cnt_4c_BotoesAcao
511:             .Top        = 33
512:             .Left       = 842
513:             .Width      = 160
514:             .Height     = 85
515:             .BackStyle  = 0
516:             .BorderWidth = 0
517:             .Visible    = .T.
518: 
519:             .AddObject("cmd_4c_Confirmar", "CommandButton")
520:             WITH .cmd_4c_Confirmar
521:                 .Caption         = "Confirmar"
522:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
523:                 .PicturePosition = 13
524:                 .Top             = 5
525:                 .Left            = 5
526:                 .Width           = 75
527:                 .Height          = 75
528:                 .FontName        = "Comic Sans MS"
529:                 .FontBold        = .T.
530:                 .FontItalic      = .T.
531:                 .FontSize        = 8
532:                 .ForeColor       = RGB(90, 90, 90)
533:                 .BackColor       = RGB(255, 255, 255)
534:                 .SpecialEffect   = 0
535:                 .MousePointer    = 15
536:                 .WordWrap        = .T.
537:                 .AutoSize        = .F.
538:                 .Enabled         = .F.
539:                 .Visible         = .T.
540:             ENDWITH
541: 

*-- Linhas 598 a 652:
598:         THIS.ConfigurarAbaEmpresa()
599:         THIS.ConfigurarAbaCampos()
600: 
601:         *-- BINDEVENTs botoes salvar/cancelar
602:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
603:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
604: 
605:         THIS.TornarControlesVisiveis(loc_oPagina)
606:     ENDPROC
607: 
608:     *--------------------------------------------------------------------------
609:     * ConfigurarAbaAcesso - Configura aba "Acesso" (Page1 do pgf_4c_Abas)
610:     * Filtro de pesquisa + Grid de programas com checkbox de acesso
611:     *--------------------------------------------------------------------------
612:     PROTECTED PROCEDURE ConfigurarAbaAcesso()
613:         LOCAL loc_oAba, loc_oGrid
614:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
615:         loc_oGrid = .NULL.
616: 
617:         TRY
618:             *-- Label "Acesso :"
619:             loc_oAba.AddObject("lbl_4c_AcessoLabel", "Label")
620:             WITH loc_oAba.lbl_4c_AcessoLabel
621:                 .Caption  = "Acesso :"
622:                 .Top      = 15
623:                 .Left     = 17
624:                 .Width    = 43
625:                 .Height   = 15
626:                 .FontName = "Tahoma"
627:                 .FontSize = 8
628:                 .Visible  = .T.
629:             ENDWITH
630: 
631:             *-- TextBox filtro (getfiltro: Top=11, Left=70, Width=902, Height=25)
632:             loc_oAba.AddObject("txt_4c_Filtro", "TextBox")
633:             WITH loc_oAba.txt_4c_Filtro
634:                 .Value     = ""
635:                 .Top       = 11
636:                 .Left      = 70
637:                 .Width     = 902
638:                 .Height    = 25
639:                 .FontName  = "Tahoma"
640:                 .FontSize  = 8
641:                 .MaxLength = 0
642:                 .Enabled   = .T.
643:                 .Visible   = .T.
644:             ENDWITH
645: 
646:             *-- Grid de acesso a programas (grdAcesso: Top=47, Left=70, Width=872, Height=387)
647:             loc_oAba.AddObject("grd_4c_Programas", "Grid")
648:             loc_oGrid = loc_oAba.grd_4c_Programas
649: 
650:             loc_oGrid.Top                = 47
651:             loc_oGrid.Left               = 70
652:             loc_oGrid.Width              = 872

*-- Linhas 691 a 746:
691:             loc_oGrid.Column3.Check1.Caption = ""
692:             loc_oGrid.Column3.Check1.Value   = .F.
693: 
694:             *-- BINDEVENT: Filtro refiltra programas na grade
695:             BINDEVENT(loc_oAba.txt_4c_Filtro, "InteractiveChange", THIS, "FiltrarProgramasAcesso")
696: 
697:         CATCH TO loException
698:             MsgErro("Erro em Formacu.ConfigurarAbaAcesso:" + CHR(13) + loException.Message, "Erro")
699:         ENDTRY
700:     ENDPROC
701: 
702:     *--------------------------------------------------------------------------
703:     * ConfigurarAbaCabecalho - Configura aba "Cabecalho" (Page2 do pgf_4c_Abas)
704:     * Grid para configuracao de botoes da barra de ferramentas do usuario
705:     *--------------------------------------------------------------------------
706:     PROTECTED PROCEDURE ConfigurarAbaCabecalho()
707:         LOCAL loc_oAba, loc_oGrid
708:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
709:         loc_oGrid = .NULL.
710: 
711:         TRY
712:             *-- Grid da barra de ferramentas (Grade: Top=18, Left=147, Width=701, Height=417)
713:             loc_oAba.AddObject("grd_4c_Barra", "Grid")
714:             loc_oGrid = loc_oAba.grd_4c_Barra
715: 
716:             loc_oGrid.Top                = 18
717:             loc_oGrid.Left               = 147
718:             loc_oGrid.Width              = 701
719:             loc_oGrid.Height             = 417
720:             loc_oGrid.FontName           = "Verdana"
721:             loc_oGrid.FontSize           = 8
722:             loc_oGrid.ForeColor          = RGB(90, 90, 90)
723:             loc_oGrid.BackColor          = RGB(255, 255, 255)
724:             loc_oGrid.GridLineColor      = RGB(238, 238, 238)
725:             loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
726:             loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
727:             loc_oGrid.HighlightStyle     = 2
728:             loc_oGrid.DeleteMark         = .F.
729:             loc_oGrid.RecordMark         = .F.
730:             loc_oGrid.GridLines          = 3
731:             loc_oGrid.RowHeight          = 16
732:             loc_oGrid.ScrollBars         = 3
733:             loc_oGrid.ColumnCount        = 4
734:             loc_oGrid.Visible            = .T.
735: 
736:             WITH loc_oGrid
737:                 .Column1.Width           = 300
738:                 .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
739: 
740:                 .Column2.Width           = 170
741:                 .Column2.Header1.Caption = "Tool Tip Text"
742: 
743:                 .Column3.Width           = 130
744:                 .Column3.Header1.Caption = "Figura"
745:             ENDWITH
746: 

*-- Linhas 760 a 803:
760:     *--------------------------------------------------------------------------
761:     * CarregarLista - Carrega dados no Grid da Page1 (Lista)
762:     *--------------------------------------------------------------------------
763:     PROCEDURE CarregarLista()
764:         LOCAL loc_lSucesso, loc_oGrid
765:         loc_lSucesso = .F.
766: 
767:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
768:             RETURN .T.
769:         ENDIF
770: 
771:         TRY
772:             IF !THIS.this_oBusinessObject.Buscar("")
773:                 loc_lSucesso = .F.
774:             ELSE
775:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
776: 
777:                 *-- Problema 36: RecordSource e ColumnCount FORA do WITH
778:                 loc_oGrid.ColumnCount = 3
779:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
780:                 loc_oGrid.ColumnCount  = 5
781: 
782:                 *-- Problema 48: ControlSource APOS RecordSource (auto-bind por ordem)
783:                 *-- Problema 32: Header1.Caption APOS RecordSource (RecordSource reseta headers)
784:                 WITH loc_oGrid
785:                     .Column1.ControlSource   = "cursor_4c_Dados.usuarios"
786:                     .Column1.Width           = 90
787:                     .Column1.ReadOnly        = .T.
788:                     .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
789: 
790:                     .Column2.ControlSource   = "cursor_4c_Dados.ncomps"
791:                     .Column2.Width           = 300
792:                     .Column2.ReadOnly        = .T.
793:                     .Column2.Header1.Caption = "Nome"
794: 
795:                     .Column3.ControlSource   = "cursor_4c_Dados.ccargs"
796:                     .Column3.Width           = 80
797:                     .Column3.ReadOnly        = .T.
798:                     .Column3.Header1.Caption = "Cargo"
799: 
800:                     .Column4.ControlSource   = "cursor_4c_Dados.deptos"
801:                     .Column4.Width           = 100
802:                     .Column4.ReadOnly        = .T.
803:                     .Column4.Header1.Caption = "Departamento"

*-- Linhas 822 a 1012:
822:     *--------------------------------------------------------------------------
823:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
824:     *--------------------------------------------------------------------------
825:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
826:         LOCAL loc_lSucesso
827:         loc_lSucesso = .F.
828: 
829:         TRY
830:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
831:                 loc_lSucesso = .F.
832:             ELSE
833:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
834: 
835:                 IF par_nPagina = 1
836:                     THIS.CarregarLista()
837:                 ENDIF
838: 
839:                 loc_lSucesso = .T.
840:             ENDIF
841:         CATCH TO loException
842:             MsgErro("Erro em Formacu.AlternarPagina:" + CHR(13) + loException.Message, "Erro")
843:             loc_lSucesso = .F.
844:         ENDTRY
845: 
846:         RETURN loc_lSucesso
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * BtnEncerrarClick - Fecha o formulario
851:     *--------------------------------------------------------------------------
852:     PROCEDURE BtnEncerrarClick()
853:         THIS.Release()
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
858:     *--------------------------------------------------------------------------
859:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
860:         LOCAL loc_nI, loc_oObjeto
861: 
862:         FOR loc_nI = 1 TO par_oContainer.ControlCount
863:             loc_oObjeto = par_oContainer.Controls(loc_nI)
864: 
865:             IF VARTYPE(loc_oObjeto) = "O"
866:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
867:                     loc_oObjeto.Visible = .T.
868:                 ENDIF
869: 
870:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
871:                     LOCAL loc_nP
872:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
873:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
874:                     ENDFOR
875:                 ENDIF
876: 
877:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
878:                     THIS.TornarControlesVisiveis(loc_oObjeto)
879:                 ENDIF
880:             ENDIF
881:         ENDFOR
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * FiltrarProgramasAcesso - Filtra grid de programas pelo texto do filtro
886:     *--------------------------------------------------------------------------
887:     PROCEDURE FiltrarProgramasAcesso()
888:         LOCAL loc_oAba, loc_oGrid, loc_cFiltro
889:         loc_oAba    = .NULL.
890:         loc_oGrid   = .NULL.
891:         loc_cFiltro = ""
892: 
893:         TRY
894:             loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
895:             loc_oGrid   = loc_oAba.grd_4c_Programas
896:             loc_cFiltro = UPPER(ALLTRIM(loc_oAba.txt_4c_Filtro.Value))
897: 
898:             IF USED("cursor_4c_Programas")
899:                 SELECT cursor_4c_Programas
900:                 IF EMPTY(m.loc_cFiltro)
901:                     SET FILTER TO
902:                 ELSE
903:                     SET FILTER TO m.loc_cFiltro $ UPPER(ALLTRIM(descricaos)) ;
904:                                OR m.loc_cFiltro $ UPPER(ALLTRIM(programas))  ;
905:                                OR m.loc_cFiltro $ UPPER(ALLTRIM(parametros))
906:                 ENDIF
907:                 GO TOP
908:                 loc_oGrid.Refresh()
909:             ENDIF
910: 
911:         CATCH TO loException
912:             MsgErro("Erro em Formacu.FiltrarProgramasAcesso:" + CHR(13) + loException.Message, "Erro")
913:         ENDTRY
914:     ENDPROC
915: 
916:     *--------------------------------------------------------------------------
917:     * FormatarGridLista - Formata visual do grid da lista
918:     *--------------------------------------------------------------------------
919:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
920:         WITH par_oGrid
921:             .FontName = "Verdana"
922:             .FontSize = 8
923:         ENDWITH
924:     ENDPROC
925: 
926:     *--------------------------------------------------------------------------
927:     * Destroy - Limpeza ao fechar o formulario
928:     *--------------------------------------------------------------------------
929:     PROCEDURE Destroy()
930:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
931:             THIS.this_oBusinessObject = .NULL.
932:         ENDIF
933: 
934:         IF USED("cursor_4c_Dados")
935:             USE IN cursor_4c_Dados
936:         ENDIF
937:         IF USED("cursor_4c_Programas")
938:             USE IN cursor_4c_Programas
939:         ENDIF
940:         IF USED("cursor_4c_Grupos")
941:             USE IN cursor_4c_Grupos
942:         ENDIF
943:         IF USED("cursor_4c_Acessos")
944:             USE IN cursor_4c_Acessos
945:         ENDIF
946:         IF USED("cursor_4c_GruposUsu")
947:             USE IN cursor_4c_GruposUsu
948:         ENDIF
949:         IF USED("cursor_4c_EmpresasUsu")
950:             USE IN cursor_4c_EmpresasUsu
951:         ENDIF
952:         IF USED("cursor_4c_Barra")
953:             USE IN cursor_4c_Barra
954:         ENDIF
955:         IF USED("cursor_4c_GruposGrid")
956:             USE IN cursor_4c_GruposGrid
957:         ENDIF
958:         IF USED("cursor_4c_EmpresasGrid")
959:             USE IN cursor_4c_EmpresasGrid
960:         ENDIF
961:         IF USED("cursor_4c_AcCamp")
962:             USE IN cursor_4c_AcCamp
963:         ENDIF
964: 
965:         DODEFAULT()
966:     ENDPROC
967: 
968:     *--------------------------------------------------------------------------
969:     * ConfigurarAbaCadastro - Aba "Cadastro" (Page3 do pgf_4c_Abas)
970:     * Dados pessoais do usuario + grupos de acesso (grid substitui OLE TreeView)
971:     *--------------------------------------------------------------------------
972:     PROTECTED PROCEDURE ConfigurarAbaCadastro()
973:         LOCAL loc_oAba, loc_oGrid, loc_oCol
974:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
975:         loc_oGrid = .NULL.
976:         loc_oCol  = .NULL.
977: 
978:         TRY
979:             *-- Labels + TextBoxes
980:             loc_oAba.AddObject("lbl_4c_Usuario",      "Label")
981:             loc_oAba.AddObject("txt_4c_Usuario",      "TextBox")
982:             loc_oAba.AddObject("lbl_4c_NComps",       "Label")
983:             loc_oAba.AddObject("txt_4c_NComps",       "TextBox")
984:             loc_oAba.AddObject("lbl_4c_Cargo",        "Label")
985:             loc_oAba.AddObject("txt_4c_Cargo",        "TextBox")
986:             loc_oAba.AddObject("lbl_4c_Departamento", "Label")
987:             loc_oAba.AddObject("txt_4c_Departamento", "TextBox")
988:             loc_oAba.AddObject("lbl_4c_Setores",      "Label")
989:             loc_oAba.AddObject("txt_4c_Setores",      "TextBox")
990:             loc_oAba.AddObject("lbl_4c_IClis",        "Label")
991:             loc_oAba.AddObject("txt_4c_IClis",        "TextBox")
992:             loc_oAba.AddObject("lbl_4c_RClis",        "Label")
993:             loc_oAba.AddObject("txt_4c_RClis",        "TextBox")
994: 
995:             WITH loc_oAba.lbl_4c_Usuario
996:                 .Caption  = "Usu" + CHR(225) + "rio:"
997:                 .Top      = 18
998:                 .Left     = 10
999:                 .Width    = 140
1000:                 .Height   = 17
1001:                 .FontName = "Verdana"
1002:                 .FontSize = 8
1003:             ENDWITH
1004:             WITH loc_oAba.txt_4c_Usuario
1005:                 .Top       = 18
1006:                 .Left      = 152
1007:                 .Width     = 81
1008:                 .Height    = 21
1009:                 .MaxLength = 10
1010:                 .FontName  = "Verdana"
1011:                 .FontSize  = 8
1012:             ENDWITH

*-- Linhas 1126 a 1301:
1126:                 .FontName  = "Verdana"
1127:                 .FontSize  = 8
1128:             ENDWITH
1129: 
1130:             *-- OptionGroups
1131:             loc_oAba.AddObject("opt_4c_Optsenhadia", "OptionGroup")
1132:             WITH loc_oAba.opt_4c_Optsenhadia
1133:                 .Top         = 181
1134:                 .Left        = 10
1135:                 .Width       = 200
1136:                 .Height      = 21
1137:                 .ButtonCount = 2
1138:                 .Value       = 1
1139:                 WITH .Buttons(1)
1140:                     .Caption = "Trocar Senha"
1141:                     .Top     = 0
1142:                     .Left    = 0
1143:                     .Width   = 95
1144:                     .Height  = 21
1145:                 ENDWITH
1146:                 WITH .Buttons(2)
1147:                     .Caption  = "Mant" + CHR(233) + "m Senha"
1148:                     .Top      = 0
1149:                     .Left     = 100
1150:                     .Width    = 95
1151:                     .Height   = 21
1152:                     .FontName = "Verdana"
1153:                     .FontSize = 8
1154:                 ENDWITH
1155:             ENDWITH
1156: 
1157:             loc_oAba.AddObject("opt_4c_Optlibpesag", "OptionGroup")
1158:             WITH loc_oAba.opt_4c_Optlibpesag
1159:                 .Top         = 208
1160:                 .Left        = 10
1161:                 .Width       = 200
1162:                 .Height      = 21
1163:                 .ButtonCount = 2
1164:                 .Value       = 1
1165:                 WITH .Buttons(1)
1166:                     .Caption = "Lib. Pesagem"
1167:                     .Top     = 0
1168:                     .Left    = 0
1169:                     .Width   = 95
1170:                     .Height  = 21
1171:                 ENDWITH
1172:                 WITH .Buttons(2)
1173:                     .Caption  = "Bloq. Pesagem"
1174:                     .Top      = 0
1175:                     .Left     = 100
1176:                     .Width    = 95
1177:                     .Height   = 21
1178:                     .FontName = "Verdana"
1179:                     .FontSize = 8
1180:                 ENDWITH
1181:             ENDWITH
1182: 
1183:             loc_oAba.AddObject("opt_4c_Optlibprod", "OptionGroup")
1184:             WITH loc_oAba.opt_4c_Optlibprod
1185:                 .Top         = 235
1186:                 .Left        = 10
1187:                 .Width       = 200
1188:                 .Height      = 21
1189:                 .ButtonCount = 2
1190:                 .Value       = 1
1191:                 WITH .Buttons(1)
1192:                     .Caption = "Lib. Produtos"
1193:                     .Top     = 0
1194:                     .Left    = 0
1195:                     .Width   = 95
1196:                     .Height  = 21
1197:                 ENDWITH
1198:                 WITH .Buttons(2)
1199:                     .Caption  = "Bloq. Produtos"
1200:                     .Top      = 0
1201:                     .Left     = 100
1202:                     .Width    = 95
1203:                     .Height   = 21
1204:                     .FontName = "Verdana"
1205:                     .FontSize = 8
1206:                 ENDWITH
1207:             ENDWITH
1208: 
1209:             loc_oAba.AddObject("opt_4c_ObrigSenha", "OptionGroup")
1210:             WITH loc_oAba.opt_4c_ObrigSenha
1211:                 .Top         = 262
1212:                 .Left        = 10
1213:                 .Width       = 200
1214:                 .Height      = 21
1215:                 .ButtonCount = 2
1216:                 .Value       = 2
1217:                 WITH .Buttons(1)
1218:                     .Caption = "Obriga Senha"
1219:                     .Top     = 0
1220:                     .Left    = 0
1221:                     .Width   = 95
1222:                     .Height  = 21
1223:                 ENDWITH
1224:                 WITH .Buttons(2)
1225:                     .Caption  = "N" + CHR(227) + "o Obriga"
1226:                     .Top      = 0
1227:                     .Left     = 100
1228:                     .Width    = 95
1229:                     .Height   = 21
1230:                     .FontName = "Verdana"
1231:                     .FontSize = 8
1232:                 ENDWITH
1233:             ENDWITH
1234: 
1235:             loc_oAba.AddObject("opt_4c_LibQtMin", "OptionGroup")
1236:             WITH loc_oAba.opt_4c_LibQtMin
1237:                 .Top         = 289
1238:                 .Left        = 10
1239:                 .Width       = 200
1240:                 .Height      = 21
1241:                 .ButtonCount = 2
1242:                 .Value       = 2
1243:                 WITH .Buttons(1)
1244:                     .Caption = "Lib. Qt.Min"
1245:                     .Top     = 0
1246:                     .Left    = 0
1247:                     .Width   = 95
1248:                     .Height  = 21
1249:                 ENDWITH
1250:                 WITH .Buttons(2)
1251:                     .Caption  = "Bloq. Qt.Min"
1252:                     .Top      = 0
1253:                     .Left     = 100
1254:                     .Width    = 95
1255:                     .Height   = 21
1256:                     .FontName = "Verdana"
1257:                     .FontSize = 8
1258:                 ENDWITH
1259:             ENDWITH
1260: 
1261:             loc_oAba.AddObject("opt_4c_Supervisao", "OptionGroup")
1262:             WITH loc_oAba.opt_4c_Supervisao
1263:                 .Top         = 316
1264:                 .Left        = 10
1265:                 .Width       = 200
1266:                 .Height      = 21
1267:                 .ButtonCount = 2
1268:                 .Value       = 2
1269:                 WITH .Buttons(1)
1270:                     .Caption = "Supervisor"
1271:                     .Top     = 0
1272:                     .Left    = 0
1273:                     .Width   = 95
1274:                     .Height  = 21
1275:                 ENDWITH
1276:                 WITH .Buttons(2)
1277:                     .Caption  = "N" + CHR(227) + "o Supervisor"
1278:                     .Top      = 0
1279:                     .Left     = 100
1280:                     .Width    = 95
1281:                     .Height   = 21
1282:                     .FontName = "Verdana"
1283:                     .FontSize = 8
1284:                 ENDWITH
1285:             ENDWITH
1286: 
1287:             *-- Limite de desconto
1288:             loc_oAba.AddObject("lbl_4c_LimDescs", "Label")
1289:             loc_oAba.AddObject("txt_4c_LimDescs", "TextBox")
1290:             WITH loc_oAba.lbl_4c_LimDescs
1291:                 .Caption  = "Limite Desconto %:"
1292:                 .Top      = 343
1293:                 .Left     = 10
1294:                 .Width    = 140
1295:                 .Height   = 17
1296:                 .FontName = "Verdana"
1297:                 .FontSize = 8
1298:             ENDWITH
1299:             WITH loc_oAba.txt_4c_LimDescs
1300:                 .Top       = 343
1301:                 .Left      = 152

*-- Linhas 1384 a 1448:
1384:                 .Sparse          = .F.
1385:             ENDWITH
1386: 
1387:             *-- BINDEVENTs lookups da aba Cadastro
1388:             BINDEVENT(loc_oAba.txt_4c_Cargo,        "KeyPress", THIS, "CargoKeyPress")
1389:             BINDEVENT(loc_oAba.txt_4c_Cargo,        "DblClick", THIS, "CargoDblClick")
1390:             BINDEVENT(loc_oAba.txt_4c_Departamento, "KeyPress", THIS, "DepartamentoKeyPress")
1391:             BINDEVENT(loc_oAba.txt_4c_Departamento, "DblClick", THIS, "DepartamentoDblClick")
1392:             BINDEVENT(loc_oAba.txt_4c_Setores,      "KeyPress", THIS, "SetoresKeyPress")
1393:             BINDEVENT(loc_oAba.txt_4c_Setores,      "DblClick", THIS, "SetoresDblClick")
1394:             BINDEVENT(loc_oAba.txt_4c_IClis,        "KeyPress", THIS, "IClisKeyPress")
1395:             BINDEVENT(loc_oAba.txt_4c_IClis,        "DblClick", THIS, "ICLisDblClick")
1396:             BINDEVENT(loc_oAba.txt_4c_RClis,        "KeyPress", THIS, "RClisKeyPress")
1397:             BINDEVENT(loc_oAba.txt_4c_RClis,        "DblClick", THIS, "RCLisDblClick")
1398: 
1399:         CATCH TO loException
1400:             MsgErro("Erro em Formacu.ConfigurarAbaCadastro:" + CHR(13) + loException.Message, "Erro")
1401:         ENDTRY
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * ConfigurarAbaEmpresa - Aba "Empresa" (Page4 do pgf_4c_Abas)
1406:     * Grid para selecao das empresas que o usuario pode acessar
1407:     *--------------------------------------------------------------------------
1408:     PROTECTED PROCEDURE ConfigurarAbaEmpresa()
1409:         LOCAL loc_oAba, loc_oGrid, loc_oCol
1410:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
1411:         loc_oGrid = .NULL.
1412:         loc_oCol  = .NULL.
1413: 
1414:         TRY
1415:             loc_oAba.AddObject("lbl_4c_Empresas", "Label")
1416:             WITH loc_oAba.lbl_4c_Empresas
1417:                 .Caption  = "Empresas com acesso:"
1418:                 .Top      = 10
1419:                 .Left     = 10
1420:                 .Width    = 200
1421:                 .Height   = 17
1422:                 .FontName = "Verdana"
1423:                 .FontSize = 8
1424:             ENDWITH
1425: 
1426:             loc_oAba.AddObject("grd_4c_Empresas", "Grid")
1427:             loc_oGrid = loc_oAba.grd_4c_Empresas
1428:             WITH loc_oGrid
1429:                 .Top         = 35
1430:                 .Left        = 10
1431:                 .Width       = 400
1432:                 .Height      = 350
1433:                 .ColumnCount = 2
1434:                 .ReadOnly    = .F.
1435:                 .GridLines   = 1
1436:                 .FontName    = "Verdana"
1437:                 .FontSize    = 8
1438:             ENDWITH
1439: 
1440:             *-- Coluna 1: checkbox marcas
1441:             loc_oCol = loc_oGrid.Column1
1442:             WITH loc_oCol
1443:                 .Width           = 25
1444:                 .Header1.Caption = ""
1445:                 .Sparse          = .F.
1446:                 .AddObject("chk_4c_Marca", "CheckBox")
1447:                 .CurrentControl  = "chk_4c_Marca"
1448:                 .chk_4c_Marca.Caption = ""

*-- Linhas 1467 a 1510:
1467:     * Grid para configurar visibilidade dos campos por usuario (original: Page1 / Acesso Tela)
1468:     * Grade: Top=18, Left=6, Width=969, Height=421, 3 colunas
1469:     *--------------------------------------------------------------------------
1470:     PROTECTED PROCEDURE ConfigurarAbaCampos()
1471:         LOCAL loc_oAba, loc_oGrid, loc_oCbo, loc_cRowSource
1472:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5
1473:         loc_oGrid = .NULL.
1474:         loc_oCbo  = .NULL.
1475: 
1476:         TRY
1477:             *-- Grid de campos por usuario (Grade: Top=18, Left=6, Width=969, Height=421)
1478:             loc_oAba.AddObject("grd_4c_AcCamp", "Grid")
1479:             loc_oGrid = loc_oAba.grd_4c_AcCamp
1480: 
1481:             WITH loc_oGrid
1482:                 .Top                = 18
1483:                 .Left               = 6
1484:                 .Width              = 969
1485:                 .Height             = 421
1486:                 .ColumnCount        = 3
1487:                 .FontName           = "Verdana"
1488:                 .FontSize           = 8
1489:                 .ForeColor          = RGB(0, 0, 0)
1490:                 .BackColor          = RGB(255, 255, 255)
1491:                 .GridLineColor      = RGB(238, 238, 238)
1492:                 .HighlightBackColor = RGB(255, 255, 255)
1493:                 .HighlightForeColor = RGB(15, 41, 104)
1494:                 .HighlightStyle     = 2
1495:                 .DeleteMark         = .F.
1496:                 .RecordMark         = .F.
1497:                 .RowHeight          = 16
1498:                 .ScrollBars         = 2
1499:                 .Visible            = .T.
1500:             ENDWITH
1501: 
1502:             *-- Coluna 1: Tela (original column2, ColumnOrder=1, Width=360)
1503:             WITH loc_oGrid.Column1
1504:                 .Width           = 360
1505:                 .Movable         = .F.
1506:                 .Resizable       = .F.
1507:                 .ReadOnly        = .T.
1508:                 .Header1.Caption = "Tela"
1509:                 .Header1.FontName = "Tahoma"
1510:                 .Header1.FontSize = 8

*-- Linhas 1558 a 1601:
1558:     * configurados para controle de acesso por usuario (26 campos SIGCDCLI)
1559:     * Espelha o bloco CREATE CURSOR + INSERT do procedimento Load do original
1560:     *--------------------------------------------------------------------------
1561:     PROCEDURE InicializarCursorAcCamp()
1562:         IF USED("crAcCamp")
1563:             USE IN crAcCamp
1564:         ENDIF
1565: 
1566:         CREATE CURSOR crAcCamp (cCodigos c(10), cDescTelas c(50), cCampos c(30), ;
1567:                                 cObjetos c(100), cDescCamps c(50), nStatus n(1))
1568:         INDEX ON cCodigos TAG cCodigos
1569: 
1570:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1571:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.endes",     "Endere" + CHR(231) + "o", 0)
1572:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1573:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.fpubls",    "Forma de publicidade", 0)
1574:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1575:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.nacionals",  "Nacionalidade", 0)
1576:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1577:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.estcivils",  "Estado civil", 0)
1578:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1579:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.conjuges",   "C" + CHR(244) + "njuge", 0)
1580:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1581:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.ultcomps",   CHR(218) + "ltima compra", 0)
1582:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1583:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.codsegs",    "Segmento", 0)
1584:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1585:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.profiss",    "Profiss" + CHR(227) + "o", 0)
1586:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1587:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.DtVals",     "Validade", 0)
1588:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1589:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.tel1s",      "Telefone", 0)
1590:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1591:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.emails",     "E-mail", 0)
1592:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1593:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.contato",    "Contato", 0)
1594:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1595:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.CTELEMS",    "Telemarketing", 0)
1596:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1597:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.codigos",    "Classifica" + CHR(231) + CHR(227) + "o", 0)
1598:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1599:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.sexos",      "Sexo", 0)
1600:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1601:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.obs",        "Observa" + CHR(231) + CHR(227) + "o", 0)

*-- Linhas 1624 a 1843:
1624:     *--------------------------------------------------------------------------
1625:     * CarregarAbasUsuario - Carrega dados de todas as abas para o usuario
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE CarregarAbasUsuario(par_cUsuarios)
1628:         THIS.CarregarGruposGrid(par_cUsuarios)
1629:         THIS.CarregarEmpresasGrid(par_cUsuarios)
1630:         THIS.CarregarAcessosGrid(par_cUsuarios)
1631:         THIS.CarregarBarraGrid(par_cUsuarios)
1632:         THIS.CarregarCamposGrid(par_cUsuarios)
1633:     ENDPROC
1634: 
1635:     *--------------------------------------------------------------------------
1636:     * CarregarGruposGrid - Grupos de acesso com marca de selecao
1637:     *--------------------------------------------------------------------------
1638:     PROCEDURE CarregarGruposGrid(par_cUsuarios)
1639:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1640:         loc_lResultado = .F.
1641: 
1642:         TRY
1643:             loc_cSQL = "SELECT g.grupos, g.dgrus, " + ;
1644:                        "CAST(CASE WHEN ag.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marca " + ;
1645:                        "FROM sigcdgra g " + ;
1646:                        "LEFT JOIN sigcdacg ag ON ag.grupos = g.grupos AND ag.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1647:                        "ORDER BY g.grupos"
1648: 
1649:             IF USED("cursor_4c_GruposGrid")
1650:                 USE IN cursor_4c_GruposGrid
1651:             ENDIF
1652: 
1653:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposGrid") > 0
1654:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Grupos
1655:                 loc_oGrid.ColumnCount = 3
1656:                 loc_oGrid.RecordSource          = "cursor_4c_GruposGrid"
1657:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GruposGrid.marca"
1658:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GruposGrid.grupos"
1659:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GruposGrid.dgrus"
1660:                 loc_oGrid.Column1.Header1.Caption = ""
1661:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1662:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1663:                 loc_lResultado = .T.
1664:             ELSE
1665:                 MsgErro("Erro ao carregar grupos de acesso.", "Erro")
1666:             ENDIF
1667: 
1668:         CATCH TO loException
1669:             MsgErro("Erro em Formacu.CarregarGruposGrid:" + CHR(13) + loException.Message, "Erro")
1670:         ENDTRY
1671: 
1672:         RETURN loc_lResultado
1673:     ENDPROC
1674: 
1675:     *--------------------------------------------------------------------------
1676:     * CarregarEmpresasGrid - Empresas com marca de selecao
1677:     *--------------------------------------------------------------------------
1678:     PROCEDURE CarregarEmpresasGrid(par_cUsuarios)
1679:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1680:         loc_lResultado = .F.
1681: 
1682:         TRY
1683:             loc_cSQL = "SELECT e.Cemps AS emps, e.Razas, " + ;
1684:                        "CAST(CASE WHEN ae.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas " + ;
1685:                        "FROM SigCdEmp e " + ;
1686:                        "LEFT JOIN sigcdace ae ON ae.emps = e.Cemps AND ae.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1687:                        "ORDER BY e.Cemps"
1688: 
1689:             IF USED("cursor_4c_EmpresasGrid")
1690:                 USE IN cursor_4c_EmpresasGrid
1691:             ENDIF
1692: 
1693:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasGrid") > 0
1694:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Empresas
1695:                 loc_oGrid.ColumnCount = 2
1696:                 loc_oGrid.RecordSource          = "cursor_4c_EmpresasGrid"
1697:                 loc_oGrid.Column1.ControlSource = "cursor_4c_EmpresasGrid.marcas"
1698:                 loc_oGrid.Column2.ControlSource = "cursor_4c_EmpresasGrid.Razas"
1699:                 loc_oGrid.Column1.Header1.Caption = ""
1700:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
1701:                 loc_lResultado = .T.
1702:             ELSE
1703:                 MsgErro("Erro ao carregar empresas.", "Erro")
1704:             ENDIF
1705: 
1706:         CATCH TO loException
1707:             MsgErro("Erro em Formacu.CarregarEmpresasGrid:" + CHR(13) + loException.Message, "Erro")
1708:         ENDTRY
1709: 
1710:         RETURN loc_lResultado
1711:     ENDPROC
1712: 
1713:     *--------------------------------------------------------------------------
1714:     * CarregarAcessosGrid - Programas com marca de acesso (aba Acesso)
1715:     *--------------------------------------------------------------------------
1716:     PROCEDURE CarregarAcessosGrid(par_cUsuarios)
1717:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1718:         loc_lResultado = .F.
1719: 
1720:         TRY
1721:             loc_cSQL = "SELECT p.programas, p.descricaos, p.grupos, p.parametros, " + ;
1722:                        "CAST(CASE WHEN a.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas, " + ;
1723:                        "ISNULL(a.usuarios, '') AS usuarios " + ;
1724:                        "FROM sigcdprg p " + ;
1725:                        "LEFT JOIN sigcdacu a ON a.programas = p.programas AND a.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1726:                        "ORDER BY p.grupos, p.programas"
1727: 
1728:             IF USED("cursor_4c_Programas")
1729:                 USE IN cursor_4c_Programas
1730:             ENDIF
1731: 
1732:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas") > 0
1733:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.grd_4c_Programas
1734:                 loc_oGrid.ColumnCount = 4
1735:                 loc_oGrid.RecordSource          = "cursor_4c_Programas"
1736:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.marcas"
1737:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.programas"
1738:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.descricaos"
1739:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.parametros"
1740:                 loc_oGrid.Column1.Header1.Caption = ""
1741:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1742:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1743:                 loc_oGrid.Column4.Header1.Caption = "Par" + CHR(226) + "metro"
1744:                 loc_lResultado = .T.
1745:             ELSE
1746:                 MsgErro("Erro ao carregar programas de acesso.", "Erro")
1747:             ENDIF
1748: 
1749:         CATCH TO loException
1750:             MsgErro("Erro em Formacu.CarregarAcessosGrid:" + CHR(13) + loException.Message, "Erro")
1751:         ENDTRY
1752: 
1753:         RETURN loc_lResultado
1754:     ENDPROC
1755: 
1756:     *--------------------------------------------------------------------------
1757:     * CarregarBarraGrid - Programas da barra de ferramentas (aba Cabecalho)
1758:     *--------------------------------------------------------------------------
1759:     PROCEDURE CarregarBarraGrid(par_cUsuarios)
1760:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1761:         loc_lResultado = .F.
1762: 
1763:         TRY
1764:             loc_cSQL = "SELECT p.programas, p.descricaos, " + ;
1765:                        "ISNULL(b.barratips, '') AS barratips, " + ;
1766:                        "ISNULL(b.barrapicts, '') AS barrapicts, " + ;
1767:                        "CAST(CASE WHEN b.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas " + ;
1768:                        "FROM sigcdprg p " + ;
1769:                        "LEFT JOIN sigcdacb b ON b.programas = p.programas AND b.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1770:                        "ORDER BY p.programas"
1771: 
1772:             IF USED("cursor_4c_Barra")
1773:                 USE IN cursor_4c_Barra
1774:             ENDIF
1775: 
1776:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
1777:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Barra
1778:                 loc_oGrid.ColumnCount = 4
1779:                 loc_oGrid.RecordSource          = "cursor_4c_Barra"
1780:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Barra.marcas"
1781:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Barra.programas"
1782:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Barra.descricaos"
1783:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Barra.barratips"
1784:                 loc_oGrid.Column1.Header1.Caption = ""
1785:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1786:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1787:                 loc_oGrid.Column4.Header1.Caption = "Tooltip"
1788:                 loc_lResultado = .T.
1789:             ELSE
1790:                 MsgErro("Erro ao carregar barra de ferramentas.", "Erro")
1791:             ENDIF
1792: 
1793:         CATCH TO loException
1794:             MsgErro("Erro em Formacu.CarregarBarraGrid:" + CHR(13) + loException.Message, "Erro")
1795:         ENDTRY
1796: 
1797:         RETURN loc_lResultado
1798:     ENDPROC
1799: 
1800:     *--------------------------------------------------------------------------
1801:     * CarregarCamposGrid - Campos por usuario (aba Campos - SigAcTel)
1802:     *--------------------------------------------------------------------------
1803:     PROCEDURE CarregarCamposGrid(par_cUsuarios)
1804:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1805:         loc_lResultado = .F.
1806: 
1807:         TRY
1808:             THIS.InicializarCursorAcCamp()
1809: 
1810:             loc_cSQL = "SELECT cCodigos, cCampos, nStatus, Grupos, Usuarios, PkChaves " + ;
1811:                        "FROM SigAcTel " + ;
1812:                        "WHERE Usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1813:                        "ORDER BY cCodigos"
1814: 
1815:             IF USED("crTmpAcTel")
1816:                 USE IN crTmpAcTel
1817:             ENDIF
1818: 
1819:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcTel") > 0
1820:                 IF USED("crSigAcTel")
1821:                     USE IN crSigAcTel
1822:                 ENDIF
1823: 
1824:                 SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps, ;
1825:                        IIF(ISNULL(b.nStatus), 1, b.nStatus) AS nStatus, ;
1826:                        IIF(ISNULL(b.Grupos),    "", b.Grupos)    AS Grupos, ;
1827:                        IIF(ISNULL(b.Usuarios),  "", b.Usuarios)  AS Usuarios, ;
1828:                        IIF(ISNULL(b.PkChaves),  "", b.PkChaves)  AS PkChaves ;
1829:                        FROM crAcCamp a ;
1830:                        LEFT JOIN crTmpAcTel b ON a.cCodigos = b.cCodigos AND a.cCampos = b.cCampos ;
1831:                        INTO CURSOR crSigAcTel READWRITE
1832: 
1833:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5.grd_4c_AcCamp
1834:                 loc_oGrid.RecordSource = ""
1835:                 loc_oGrid.RecordSource = "crSigAcTel"
1836:                 loc_oGrid.Column1.ControlSource   = "crSigAcTel.cDescTelas"
1837:                 loc_oGrid.Column2.ControlSource   = "crSigAcTel.cDescCamps"
1838:                 loc_oGrid.Column3.ControlSource   = "crSigAcTel.nStatus"
1839:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1840:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1841:                 loc_oGrid.Column3.Header1.Caption = "Status"
1842:                 loc_lResultado = .T.
1843:             ELSE

*-- Linhas 1854 a 2596:
1854:     *--------------------------------------------------------------------------
1855:     * FormParaBO - L? controles da Page3 (Cadastro) e preenche o BO
1856:     *--------------------------------------------------------------------------
1857:     PROTECTED PROCEDURE FormParaBO()
1858:         LOCAL loc_oAba, loc_oBo
1859:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
1860:         loc_oBo  = THIS.this_oBusinessObject
1861: 
1862:         TRY
1863:             loc_oBo.this_cUsuarios   = ALLTRIM(loc_oAba.txt_4c_Usuario.Value)
1864:             loc_oBo.this_cNComps     = ALLTRIM(loc_oAba.txt_4c_NComps.Value)
1865:             loc_oBo.this_cCCargs     = ALLTRIM(loc_oAba.txt_4c_Cargo.Value)
1866:             loc_oBo.this_cDeptos     = ALLTRIM(loc_oAba.txt_4c_Departamento.Value)
1867:             loc_oBo.this_cSetores    = ALLTRIM(loc_oAba.txt_4c_Setores.Value)
1868:             loc_oBo.this_cIClis      = ALLTRIM(loc_oAba.txt_4c_IClis.Value)
1869:             loc_oBo.this_cLimDescs   = ALLTRIM(loc_oAba.txt_4c_LimDescs.Value)
1870:             loc_oBo.this_dTdtSenhas  = CTOD(loc_oAba.txt_4c_TdtSenhas.Value)
1871: 
1872:             *-- OptionGroups: 1=Sim/Lib, 2=Nao/Bloq
1873:             loc_oBo.this_cSenhas    = IIF(loc_oAba.opt_4c_Optsenhadia.Value = 1, "S", "N")
1874:             loc_oBo.this_cLibPess   = IIF(loc_oAba.opt_4c_Optlibpesag.Value = 1, "S", "N")
1875:             loc_oBo.this_cLibProds  = IIF(loc_oAba.opt_4c_Optlibprod.Value  = 1, "S", "N")
1876:             loc_oBo.this_nObrigSenhas = IIF(loc_oAba.opt_4c_ObrigSenha.Value = 1, 1, 0)
1877:             loc_oBo.this_cLibQtMins = IIF(loc_oAba.opt_4c_LibQtMin.Value    = 1, "S", "N")
1878:             loc_oBo.this_cSupervis  = IIF(loc_oAba.opt_4c_Supervisao.Value  = 1, "S", "N")
1879: 
1880:         CATCH TO loException
1881:             MsgErro("Erro em Formacu.FormParaBO:" + CHR(13) + loException.Message, "Erro")
1882:         ENDTRY
1883:     ENDPROC
1884: 
1885:     *--------------------------------------------------------------------------
1886:     * BOParaForm - Preenche controles da Page3 (Cadastro) com dados do BO
1887:     *--------------------------------------------------------------------------
1888:     PROTECTED PROCEDURE BOParaForm()
1889:         LOCAL loc_oAba, loc_oBo
1890:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
1891:         loc_oBo  = THIS.this_oBusinessObject
1892: 
1893:         TRY
1894:             loc_oAba.txt_4c_Usuario.Value      = ALLTRIM(loc_oBo.this_cUsuarios)
1895:             loc_oAba.txt_4c_NComps.Value       = ALLTRIM(loc_oBo.this_cNComps)
1896:             loc_oAba.txt_4c_Cargo.Value        = ALLTRIM(loc_oBo.this_cCCargs)
1897:             loc_oAba.txt_4c_Departamento.Value = ALLTRIM(loc_oBo.this_cDeptos)
1898:             loc_oAba.txt_4c_Setores.Value      = ALLTRIM(loc_oBo.this_cSetores)
1899:             loc_oAba.txt_4c_IClis.Value        = ALLTRIM(loc_oBo.this_cIClis)
1900:             loc_oAba.txt_4c_LimDescs.Value     = ALLTRIM(loc_oBo.this_cLimDescs)
1901: 
1902:             IF !EMPTY(loc_oBo.this_dTdtSenhas) AND VARTYPE(loc_oBo.this_dTdtSenhas) = "D"
1903:                 loc_oAba.txt_4c_TdtSenhas.Value = DTOC(loc_oBo.this_dTdtSenhas)
1904:             ELSE
1905:                 loc_oAba.txt_4c_TdtSenhas.Value = ""
1906:             ENDIF
1907: 
1908:             *-- OptionGroups
1909:             loc_oAba.opt_4c_Optsenhadia.Value = IIF(UPPER(ALLTRIM(loc_oBo.this_cSenhas))   = "S", 1, 2)
1910:             loc_oAba.opt_4c_Optlibpesag.Value = IIF(UPPER(ALLTRIM(loc_oBo.this_cLibPess))  = "S", 1, 2)
1911:             loc_oAba.opt_4c_Optlibprod.Value  = IIF(UPPER(ALLTRIM(loc_oBo.this_cLibProds)) = "S", 1, 2)
1912:             loc_oAba.opt_4c_ObrigSenha.Value  = IIF(loc_oBo.this_nObrigSenhas = 1, 1, 2)
1913:             loc_oAba.opt_4c_LibQtMin.Value    = IIF(UPPER(ALLTRIM(loc_oBo.this_cLibQtMins)) = "S", 1, 2)
1914:             loc_oAba.opt_4c_Supervisao.Value  = IIF(UPPER(ALLTRIM(loc_oBo.this_cSupervis)) = "S", 1, 2)
1915: 
1916:         CATCH TO loException
1917:             MsgErro("Erro em Formacu.BOParaForm:" + CHR(13) + loException.Message, "Erro")
1918:         ENDTRY
1919:     ENDPROC
1920: 
1921:     *--------------------------------------------------------------------------
1922:     * HabilitarCampos - Habilita ou desabilita campos de edicao
1923:     *--------------------------------------------------------------------------
1924:     PROCEDURE HabilitarCampos(par_lHabilitar)
1925:         LOCAL loc_oAba
1926:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
1927: 
1928:         TRY
1929:             loc_oAba.txt_4c_Usuario.Enabled      = par_lHabilitar
1930:             loc_oAba.txt_4c_NComps.Enabled       = par_lHabilitar
1931:             loc_oAba.txt_4c_Cargo.Enabled        = par_lHabilitar
1932:             loc_oAba.txt_4c_Departamento.Enabled = par_lHabilitar
1933:             loc_oAba.txt_4c_Setores.Enabled      = par_lHabilitar
1934:             loc_oAba.txt_4c_IClis.Enabled        = par_lHabilitar
1935:             loc_oAba.txt_4c_LimDescs.Enabled     = par_lHabilitar
1936:             loc_oAba.txt_4c_TdtSenhas.Enabled    = par_lHabilitar
1937:             loc_oAba.opt_4c_Optsenhadia.Enabled  = par_lHabilitar
1938:             loc_oAba.opt_4c_Optlibpesag.Enabled  = par_lHabilitar
1939:             loc_oAba.opt_4c_Optlibprod.Enabled   = par_lHabilitar
1940:             loc_oAba.opt_4c_ObrigSenha.Enabled   = par_lHabilitar
1941:             loc_oAba.opt_4c_LibQtMin.Enabled     = par_lHabilitar
1942:             loc_oAba.opt_4c_Supervisao.Enabled   = par_lHabilitar
1943:             loc_oAba.grd_4c_Grupos.ReadOnly      = !par_lHabilitar
1944: 
1945:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Empresas.ReadOnly = !par_lHabilitar
1946:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.grd_4c_Programas.ReadOnly = !par_lHabilitar
1947: 
1948:             *-- Botoes de acao
1949:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1950:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1951: 
1952:         CATCH TO loException
1953:             MsgErro("Erro em Formacu.HabilitarCampos:" + CHR(13) + loException.Message, "Erro")
1954:         ENDTRY
1955:     ENDPROC
1956: 
1957:     *--------------------------------------------------------------------------
1958:     * LimparCampos - Restaura todos os campos para valores padrao
1959:     *--------------------------------------------------------------------------
1960:     PROCEDURE LimparCampos()
1961:         LOCAL loc_oAba
1962:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
1963: 
1964:         TRY
1965:             loc_oAba.txt_4c_Usuario.Value      = ""
1966:             loc_oAba.txt_4c_NComps.Value       = ""
1967:             loc_oAba.txt_4c_Cargo.Value        = ""
1968:             loc_oAba.txt_4c_Departamento.Value = ""
1969:             loc_oAba.txt_4c_Setores.Value      = ""
1970:             loc_oAba.txt_4c_IClis.Value        = ""
1971:             loc_oAba.txt_4c_RClis.Value        = ""
1972:             loc_oAba.txt_4c_LimDescs.Value     = ""
1973:             loc_oAba.txt_4c_TdtSenhas.Value    = ""
1974:             loc_oAba.opt_4c_Optsenhadia.Value  = 1
1975:             loc_oAba.opt_4c_Optlibpesag.Value  = 1
1976:             loc_oAba.opt_4c_Optlibprod.Value   = 1
1977:             loc_oAba.opt_4c_ObrigSenha.Value   = 2
1978:             loc_oAba.opt_4c_LibQtMin.Value     = 2
1979:             loc_oAba.opt_4c_Supervisao.Value   = 2
1980: 
1981:             *-- Limpar grids (registros em branco)
1982:             IF USED("cursor_4c_GruposGrid")
1983:                 USE IN cursor_4c_GruposGrid
1984:             ENDIF
1985:             IF USED("cursor_4c_EmpresasGrid")
1986:                 USE IN cursor_4c_EmpresasGrid
1987:             ENDIF
1988:             IF USED("cursor_4c_Programas")
1989:                 USE IN cursor_4c_Programas
1990:             ENDIF
1991:             IF USED("cursor_4c_Barra")
1992:                 USE IN cursor_4c_Barra
1993:             ENDIF
1994:             IF USED("cursor_4c_AcCamp")
1995:                 USE IN cursor_4c_AcCamp
1996:             ENDIF
1997: 
1998:         CATCH TO loException
1999:             MsgErro("Erro em Formacu.LimparCampos:" + CHR(13) + loException.Message, "Erro")
2000:         ENDTRY
2001:     ENDPROC
2002: 
2003:     *--------------------------------------------------------------------------
2004:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo
2005:     *--------------------------------------------------------------------------
2006:     PROCEDURE AjustarBotoesPorModo()
2007:         LOCAL loc_oCnt, loc_lTemRegistro
2008:         loc_oCnt       = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2009:         loc_lTemRegistro = (USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0)
2010: 
2011:         TRY
2012:             WITH loc_oCnt
2013:                 .cmd_4c_Incluir.Enabled    = .T.
2014:                 .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
2015:                 .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
2016:                 .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
2017:                 .cmd_4c_Buscar.Enabled     = .T.
2018:             ENDWITH
2019: 
2020:         CATCH TO loException
2021:             MsgErro("Erro em Formacu.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
2022:         ENDTRY
2023:     ENDPROC
2024: 
2025:     *--------------------------------------------------------------------------
2026:     * BtnIncluirClick - Prepara formulario para novo registro
2027:     *--------------------------------------------------------------------------
2028:     PROCEDURE BtnIncluirClick()
2029:         TRY
2030:             THIS.this_cModoAtual    = "INCLUIR"
2031:             THIS.this_cUsuarioAtual = ""
2032:             THIS.LimparCampos()
2033:             THIS.HabilitarCampos(.T.)
2034:             THIS.pgf_4c_Paginas.ActivePage = 2
2035:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 3
2036: 
2037:         CATCH TO loException
2038:             MsgErro("Erro em Formacu.BtnIncluirClick:" + CHR(13) + loException.Message, "Erro")
2039:         ENDTRY
2040:     ENDPROC
2041: 
2042:     *--------------------------------------------------------------------------
2043:     * BtnAlterarClick - Carrega registro selecionado para edicao
2044:     *--------------------------------------------------------------------------
2045:     PROCEDURE BtnAlterarClick()
2046:         LOCAL loc_cUsuarios, loc_lPode
2047:         loc_cUsuarios = ""
2048:         loc_lPode     = .T.
2049: 
2050:         TRY
2051:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2052:                 MsgAviso("Nenhum registro selecionado.")
2053:                 loc_lPode = .F.
2054:             ENDIF
2055: 
2056:             IF loc_lPode
2057:                 loc_cUsuarios = ALLTRIM(cursor_4c_Dados.usuarios)
2058:                 IF EMPTY(loc_cUsuarios)
2059:                     MsgAviso("Selecione um usu" + CHR(225) + "rio para alterar.")
2060:                     loc_lPode = .F.
2061:                 ENDIF
2062:             ENDIF
2063: 
2064:             IF loc_lPode
2065:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cUsuarios)
2066:                     THIS.this_cModoAtual    = "ALTERAR"
2067:                     THIS.this_cUsuarioAtual = loc_cUsuarios
2068:                     THIS.BOParaForm()
2069:                     THIS.CarregarAbasUsuario(loc_cUsuarios)
2070:                     THIS.HabilitarCampos(.T.)
2071:                     THIS.pgf_4c_Paginas.ActivePage = 2
2072:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 3
2073:                 ELSE
2074:                     MsgErro("Usu" + CHR(225) + "rio n" + CHR(227) + "o encontrado.", "Erro")
2075:                 ENDIF
2076:             ENDIF
2077: 
2078:         CATCH TO loException
2079:             MsgErro("Erro em Formacu.BtnAlterarClick:" + CHR(13) + loException.Message, "Erro")
2080:         ENDTRY
2081:     ENDPROC
2082: 
2083:     *--------------------------------------------------------------------------
2084:     * BtnVisualizarClick - Carrega registro apenas para visualizacao
2085:     *--------------------------------------------------------------------------
2086:     PROCEDURE BtnVisualizarClick()
2087:         LOCAL loc_cUsuarios, loc_lPode
2088:         loc_cUsuarios = ""
2089:         loc_lPode     = .T.
2090: 
2091:         TRY
2092:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2093:                 MsgAviso("Nenhum registro selecionado.")
2094:                 loc_lPode = .F.
2095:             ENDIF
2096: 
2097:             IF loc_lPode
2098:                 loc_cUsuarios = ALLTRIM(cursor_4c_Dados.usuarios)
2099:                 IF EMPTY(loc_cUsuarios)
2100:                     MsgAviso("Selecione um usu" + CHR(225) + "rio para visualizar.")
2101:                     loc_lPode = .F.
2102:                 ENDIF
2103:             ENDIF
2104: 
2105:             IF loc_lPode
2106:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cUsuarios)
2107:                     THIS.this_cModoAtual    = "VISUALIZAR"
2108:                     THIS.this_cUsuarioAtual = loc_cUsuarios
2109:                     THIS.BOParaForm()
2110:                     THIS.CarregarAbasUsuario(loc_cUsuarios)
2111:                     THIS.HabilitarCampos(.F.)
2112:                     THIS.pgf_4c_Paginas.ActivePage = 2
2113:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 3
2114:                 ELSE
2115:                     MsgErro("Usu" + CHR(225) + "rio n" + CHR(227) + "o encontrado.", "Erro")
2116:                 ENDIF
2117:             ENDIF
2118: 
2119:         CATCH TO loException
2120:             MsgErro("Erro em Formacu.BtnVisualizarClick:" + CHR(13) + loException.Message, "Erro")
2121:         ENDTRY
2122:     ENDPROC
2123: 
2124:     *--------------------------------------------------------------------------
2125:     * BtnExcluirClick - Exclui registro selecionado com confirmacao
2126:     *--------------------------------------------------------------------------
2127:     PROCEDURE BtnExcluirClick()
2128:         LOCAL loc_cUsuarios, loc_lConf, loc_lPode
2129:         loc_cUsuarios = ""
2130:         loc_lConf     = .F.
2131:         loc_lPode     = .T.
2132: 
2133:         TRY
2134:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2135:                 MsgAviso("Nenhum registro selecionado.")
2136:                 loc_lPode = .F.
2137:             ENDIF
2138: 
2139:             IF loc_lPode
2140:                 loc_cUsuarios = ALLTRIM(cursor_4c_Dados.usuarios)
2141:                 IF EMPTY(loc_cUsuarios)
2142:                     MsgAviso("Selecione um usu" + CHR(225) + "rio para excluir.")
2143:                     loc_lPode = .F.
2144:                 ENDIF
2145:             ENDIF
2146: 
2147:             IF loc_lPode
2148:                 loc_lConf = MsgConfirma("Confirma a exclus" + CHR(227) + "o do usu" + CHR(225) + "rio '" + ALLTRIM(loc_cUsuarios) + "'?")
2149: 
2150:                 IF loc_lConf
2151:                     THIS.this_oBusinessObject.this_cUsuarios = loc_cUsuarios
2152:                     IF THIS.this_oBusinessObject.Excluir()
2153:                         MsgInfo("Usu" + CHR(225) + "rio exclu" + CHR(237) + "do com sucesso.")
2154:                         THIS.BtnBuscarClick()
2155:                     ELSE
2156:                         MsgErro("Erro ao excluir usu" + CHR(225) + "rio.", "Erro")
2157:                     ENDIF
2158:                 ENDIF
2159:             ENDIF
2160: 
2161:         CATCH TO loException
2162:             MsgErro("Erro em Formacu.BtnExcluirClick:" + CHR(13) + loException.Message, "Erro")
2163:         ENDTRY
2164:     ENDPROC
2165: 
2166:     *--------------------------------------------------------------------------
2167:     * BtnBuscarClick - Recarrega lista de usuarios
2168:     *--------------------------------------------------------------------------
2169:     PROCEDURE BtnBuscarClick()
2170:         TRY
2171:             THIS.CarregarLista()
2172:             THIS.AjustarBotoesPorModo()
2173: 
2174:         CATCH TO loException
2175:             MsgErro("Erro em Formacu.BtnBuscarClick:" + CHR(13) + loException.Message, "Erro")
2176:         ENDTRY
2177:     ENDPROC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * BtnSalvarClick - Valida e persiste todos os dados (cascade)
2181:     *--------------------------------------------------------------------------
2182:     PROCEDURE BtnSalvarClick()
2183:         LOCAL loc_cUsuarios, loc_lResultado, loc_lValido
2184:         loc_cUsuarios  = ""
2185:         loc_lResultado = .F.
2186:         loc_lValido    = .T.
2187: 
2188:         THIS.FormParaBO()
2189:         loc_cUsuarios = ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
2190: 
2191:         IF EMPTY(loc_cUsuarios)
2192:             MsgAviso("Informe o c" + CHR(243) + "digo do usu" + CHR(225) + "rio.")
2193:             loc_lValido = .F.
2194:         ENDIF
2195: 
2196:         IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cNComps))
2197:             MsgAviso("Informe o nome completo do usu" + CHR(225) + "rio.")
2198:             loc_lValido = .F.
2199:         ENDIF
2200: 
2201:         IF loc_lValido AND THIS.this_cModoAtual = "INCLUIR"
2202:             IF THIS.this_oBusinessObject.VerificarUsuarioExistente(loc_cUsuarios)
2203:                 MsgAviso("Usu" + CHR(225) + "rio '" + ALLTRIM(loc_cUsuarios) + "' j" + CHR(225) + " cadastrado.")
2204:                 loc_lValido = .F.
2205:             ENDIF
2206:         ENDIF
2207: 
2208:         IF loc_lValido
2209:             TRY
2210:                 IF THIS.this_cModoAtual = "INCLUIR"
2211:                     loc_lResultado = THIS.this_oBusinessObject.Inserir()
2212:                 ELSE
2213:                     loc_lResultado = THIS.this_oBusinessObject.Atualizar()
2214:                 ENDIF
2215: 
2216:                 IF loc_lResultado
2217:                     IF USED("cursor_4c_Programas")
2218:                         THIS.this_oBusinessObject.SalvarAcessos(loc_cUsuarios, "cursor_4c_Programas")
2219:                     ENDIF
2220:                     IF USED("cursor_4c_GruposGrid")
2221:                         THIS.this_oBusinessObject.SalvarGrupos(loc_cUsuarios, "cursor_4c_GruposGrid")
2222:                     ENDIF
2223:                     IF USED("cursor_4c_EmpresasGrid")
2224:                         THIS.this_oBusinessObject.SalvarEmpresas(loc_cUsuarios, "cursor_4c_EmpresasGrid")
2225:                     ENDIF
2226: 
2227:                     MsgInfo("Usu" + CHR(225) + "rio salvo com sucesso.")
2228:                     THIS.this_cModoAtual    = "LISTA"
2229:                     THIS.this_cUsuarioAtual = loc_cUsuarios
2230:                     THIS.pgf_4c_Paginas.ActivePage = 1
2231:                     THIS.BtnBuscarClick()
2232:                 ELSE
2233:                     MsgErro("Erro ao salvar dados do usu" + CHR(225) + "rio.", "Erro")
2234:                 ENDIF
2235: 
2236:             CATCH TO loException
2237:                 MsgErro("Erro em Formacu.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
2238:             ENDTRY
2239:         ENDIF
2240:     ENDPROC
2241: 
2242:     *--------------------------------------------------------------------------
2243:     * BtnCancelarClick - Cancela edicao e retorna a lista
2244:     *--------------------------------------------------------------------------
2245:     PROCEDURE BtnCancelarClick()
2246:         TRY
2247:             THIS.this_cModoAtual = "LISTA"
2248:             THIS.pgf_4c_Paginas.ActivePage = 1
2249:             THIS.AjustarBotoesPorModo()
2250: 
2251:         CATCH TO loException
2252:             MsgErro("Erro em Formacu.BtnCancelarClick:" + CHR(13) + loException.Message, "Erro")
2253:         ENDTRY
2254:     ENDPROC
2255: 
2256:     *--------------------------------------------------------------------------
2257:     * BtnCopiarAcessoClick - Exibe painel para copiar acessos de outro usuario
2258:     *--------------------------------------------------------------------------
2259:     PROCEDURE BtnCopiarAcessoClick()
2260:         LOCAL loc_oPagina
2261:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
2262: 
2263:         TRY
2264:             loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos.Value = ""
2265:             loc_oPagina.cnt_4c_CopiarAcesso.Visible = .T.
2266:             loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos.SetFocus()
2267: 
2268:         CATCH TO loException
2269:             MsgErro("Erro em Formacu.BtnCopiarAcessoClick:" + CHR(13) + loException.Message, "Erro")
2270:         ENDTRY
2271:     ENDPROC
2272: 
2273:     *--------------------------------------------------------------------------
2274:     * BtnLimSenhaClick - Limpa/redefine senha do usuario selecionado
2275:     *--------------------------------------------------------------------------
2276:     PROCEDURE BtnLimSenhaClick()
2277:         LOCAL loc_cUsuarios, loc_lConf, loc_lResultado
2278:         loc_cUsuarios  = ""
2279:         loc_lConf      = .F.
2280:         loc_lResultado = .F.
2281: 
2282:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2283:             MsgAviso("Selecione um usu" + CHR(225) + "rio para limpar a senha.")
2284:             RETURN
2285:         ENDIF
2286: 
2287:         loc_cUsuarios = ALLTRIM(cursor_4c_Dados.usuarios)
2288: 
2289:         IF EMPTY(loc_cUsuarios)
2290:             MsgAviso("Selecione um usu" + CHR(225) + "rio.")
2291:             RETURN
2292:         ENDIF
2293: 
2294:         loc_lConf = MsgConfirma("Confirma a limpeza de senha do usu" + CHR(225) + "rio '" + ALLTRIM(loc_cUsuarios) + "'?")
2295: 
2296:         TRY
2297:             IF loc_lConf
2298:                 loc_lResultado = THIS.this_oBusinessObject.LimparSenha(loc_cUsuarios)
2299:                 IF loc_lResultado
2300:                     MsgInfo("Senha do usu" + CHR(225) + "rio redefinida com sucesso.")
2301:                 ELSE
2302:                     MsgErro("Erro ao redefinir senha.", "Erro")
2303:                 ENDIF
2304:             ENDIF
2305: 
2306:         CATCH TO loException
2307:             MsgErro("Erro em Formacu.BtnLimSenhaClick:" + CHR(13) + loException.Message, "Erro")
2308:         ENDTRY
2309:     ENDPROC
2310: 
2311:     *--------------------------------------------------------------------------
2312:     * BtnEfetuarCopiaClick - Copia acessos do usuario digitado para o atual
2313:     *--------------------------------------------------------------------------
2314:     PROCEDURE BtnEfetuarCopiaClick()
2315:         LOCAL loc_oPagina, loc_cUsuarioOrigem, loc_cUsuarioDestino, loc_lConf, loc_lResultado
2316:         loc_oPagina        = THIS.pgf_4c_Paginas.Page1
2317:         loc_cUsuarioOrigem = ""
2318:         loc_cUsuarioDestino = ""
2319:         loc_lConf          = .F.
2320:         loc_lResultado     = .F.
2321: 
2322:         loc_cUsuarioOrigem  = ALLTRIM(loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos.Value)
2323:         loc_cUsuarioDestino = ALLTRIM(cursor_4c_Dados.usuarios)
2324: 
2325:         IF EMPTY(loc_cUsuarioOrigem)
2326:             MsgAviso("Informe o usu" + CHR(225) + "rio de origem para copiar acessos.")
2327:             RETURN
2328:         ENDIF
2329: 
2330:         IF EMPTY(loc_cUsuarioDestino)
2331:             MsgAviso("Selecione o usu" + CHR(225) + "rio de destino na lista.")
2332:             RETURN
2333:         ENDIF
2334: 
2335:         loc_lConf = MsgConfirma("Copiar acessos de '" + ALLTRIM(loc_cUsuarioOrigem) + "' para '" + ALLTRIM(loc_cUsuarioDestino) + "'?")
2336: 
2337:         TRY
2338:             IF loc_lConf
2339:                 loc_lResultado = THIS.this_oBusinessObject.CopiarAcessos(loc_cUsuarioOrigem, loc_cUsuarioDestino)
2340:                 IF loc_lResultado
2341:                     MsgInfo("Acessos copiados com sucesso.")
2342:                     loc_oPagina.cnt_4c_CopiarAcesso.Visible = .F.
2343:                 ELSE
2344:                     MsgErro("Erro ao copiar acessos.", "Erro")
2345:                 ENDIF
2346:             ENDIF
2347: 
2348:         CATCH TO loException
2349:             MsgErro("Erro em Formacu.BtnEfetuarCopiaClick:" + CHR(13) + loException.Message, "Erro")
2350:         ENDTRY
2351:     ENDPROC
2352: 
2353:     *--------------------------------------------------------------------------
2354:     * BtnCancelarCopiaClick - Fecha painel de copia de acessos
2355:     *--------------------------------------------------------------------------
2356:     PROCEDURE BtnCancelarCopiaClick()
2357:         TRY
2358:             THIS.pgf_4c_Paginas.Page1.cnt_4c_CopiarAcesso.Visible = .F.
2359: 
2360:         CATCH TO loException
2361:             MsgErro("Erro em Formacu.BtnCancelarCopiaClick:" + CHR(13) + loException.Message, "Erro")
2362:         ENDTRY
2363:     ENDPROC
2364: 
2365:     *==========================================================================
2366:     * HANDLERS DE LOOKUP - Cargo (SigCdCrg)
2367:     *==========================================================================
2368:     PROCEDURE CargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2369:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2370:             THIS.AbrirLookupCargo()
2371:         ENDIF
2372:     ENDPROC
2373: 
2374:     PROCEDURE CargoDblClick()
2375:         THIS.AbrirLookupCargo()
2376:     ENDPROC
2377: 
2378:     PROTECTED PROCEDURE AbrirLookupCargo()
2379:         LOCAL loc_oLookup, loc_oAba
2380:         loc_oLookup = .NULL.
2381:         loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
2382: 
2383:         TRY
2384:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2385:                 "SELECT CCargs, DCargs FROM SigCdCrg ORDER BY CCargs", ;
2386:                 "cursor_4c_BuscaCargo")
2387: 
2388:             IF VARTYPE(loc_oLookup) = "O"
2389:                 loc_oLookup.mAddColuna("CCargs", "@!", "C" + CHR(243) + "digo")
2390:                 loc_oLookup.mAddColuna("DCargs", "@!",  "Descri" + CHR(231) + CHR(227) + "o")
2391:                 loc_oLookup.Show()
2392: 
2393:                 IF loc_oLookup.this_lSelecionou
2394:                     SELECT cursor_4c_BuscaCargo
2395:                     loc_oAba.txt_4c_Cargo.Value = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
2396:                 ENDIF
2397: 
2398:                 loc_oLookup.Release()
2399:                 IF USED("cursor_4c_BuscaCargo")
2400:                     USE IN cursor_4c_BuscaCargo
2401:                 ENDIF
2402:             ENDIF
2403: 
2404:         CATCH TO loException
2405:             MsgErro("Erro em Formacu.AbrirLookupCargo:" + CHR(13) + loException.Message, "Erro")
2406:         ENDTRY
2407:     ENDPROC
2408: 
2409:     *==========================================================================
2410:     * HANDLERS DE LOOKUP - Departamento (SigCdDpt)
2411:     *==========================================================================
2412:     PROCEDURE DepartamentoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2413:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2414:             THIS.AbrirLookupDepartamento()
2415:         ENDIF
2416:     ENDPROC
2417: 
2418:     PROCEDURE DepartamentoDblClick()
2419:         THIS.AbrirLookupDepartamento()
2420:     ENDPROC
2421: 
2422:     PROTECTED PROCEDURE AbrirLookupDepartamento()
2423:         LOCAL loc_oLookup, loc_oAba
2424:         loc_oLookup = .NULL.
2425:         loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
2426: 
2427:         TRY
2428:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2429:                 "SELECT codigos, Descricaos FROM SigCdDpt ORDER BY codigos", ;
2430:                 "cursor_4c_BuscaDept")
2431: 
2432:             IF VARTYPE(loc_oLookup) = "O"
2433:                 loc_oLookup.mAddColuna("codigos",     "@!", "C" + CHR(243) + "digo")
2434:                 loc_oLookup.mAddColuna("Descricaos",  "@!", "Descri" + CHR(231) + CHR(227) + "o")
2435:                 loc_oLookup.Show()
2436: 
2437:                 IF loc_oLookup.this_lSelecionou
2438:                     SELECT cursor_4c_BuscaDept
2439:                     loc_oAba.txt_4c_Departamento.Value = ALLTRIM(cursor_4c_BuscaDept.codigos)
2440:                 ENDIF
2441: 
2442:                 loc_oLookup.Release()
2443:                 IF USED("cursor_4c_BuscaDept")
2444:                     USE IN cursor_4c_BuscaDept
2445:                 ENDIF
2446:             ENDIF
2447: 
2448:         CATCH TO loException
2449:             MsgErro("Erro em Formacu.AbrirLookupDepartamento:" + CHR(13) + loException.Message, "Erro")
2450:         ENDTRY
2451:     ENDPROC
2452: 
2453:     *==========================================================================
2454:     * HANDLERS DE LOOKUP - Setor (SigCdSet)
2455:     *==========================================================================
2456:     PROCEDURE SetoresKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2457:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2458:             THIS.AbrirLookupSetores()
2459:         ENDIF
2460:     ENDPROC
2461: 
2462:     PROCEDURE SetoresDblClick()
2463:         THIS.AbrirLookupSetores()
2464:     ENDPROC
2465: 
2466:     PROTECTED PROCEDURE AbrirLookupSetores()
2467:         LOCAL loc_oLookup, loc_oAba
2468:         loc_oLookup = .NULL.
2469:         loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
2470: 
2471:         TRY
2472:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2473:                 "SELECT Setores, Descrs FROM SigCdSet ORDER BY Setores", ;
2474:                 "cursor_4c_BuscaSetor")
2475: 
2476:             IF VARTYPE(loc_oLookup) = "O"
2477:                 loc_oLookup.mAddColuna("Setores", "@!", "Setor")
2478:                 loc_oLookup.mAddColuna("Descrs",  "@!", "Descri" + CHR(231) + CHR(227) + "o")
2479:                 loc_oLookup.Show()
2480: 
2481:                 IF loc_oLookup.this_lSelecionou
2482:                     SELECT cursor_4c_BuscaSetor
2483:                     loc_oAba.txt_4c_Setores.Value = ALLTRIM(cursor_4c_BuscaSetor.Setores)
2484:                 ENDIF
2485: 
2486:                 loc_oLookup.Release()
2487:                 IF USED("cursor_4c_BuscaSetor")
2488:                     USE IN cursor_4c_BuscaSetor
2489:                 ENDIF
2490:             ENDIF
2491: 
2492:         CATCH TO loException
2493:             MsgErro("Erro em Formacu.AbrirLookupSetores:" + CHR(13) + loException.Message, "Erro")
2494:         ENDTRY
2495:     ENDPROC
2496: 
2497:     *==========================================================================
2498:     * HANDLERS DE LOOKUP - IClis / RClis (SigCdCli) - preenche ambos campos
2499:     *==========================================================================
2500:     PROCEDURE IClisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2501:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2502:             THIS.AbrirLookupCli()
2503:         ENDIF
2504:     ENDPROC
2505: 
2506:     PROCEDURE ICLisDblClick()
2507:         THIS.AbrirLookupCli()
2508:     ENDPROC
2509: 
2510:     PROCEDURE RClisKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2511:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2512:             THIS.AbrirLookupCli()
2513:         ENDIF
2514:     ENDPROC
2515: 
2516:     PROCEDURE RCLisDblClick()
2517:         THIS.AbrirLookupCli()
2518:     ENDPROC
2519: 
2520:     PROTECTED PROCEDURE AbrirLookupCli()
2521:         LOCAL loc_oLookup, loc_oAba
2522:         loc_oLookup = .NULL.
2523:         loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
2524: 
2525:         TRY
2526:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2527:                 "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2528:                 "cursor_4c_BuscaCli")
2529: 
2530:             IF VARTYPE(loc_oLookup) = "O"
2531:                 loc_oLookup.mAddColuna("IClis", "@!", CHR(205) + "ndice")
2532:                 loc_oLookup.mAddColuna("RClis", "@!", "Raz" + CHR(227) + "o")
2533:                 loc_oLookup.Show()
2534: 
2535:                 IF loc_oLookup.this_lSelecionou
2536:                     SELECT cursor_4c_BuscaCli
2537:                     loc_oAba.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaCli.IClis)
2538:                     loc_oAba.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
2539:                 ENDIF
2540: 
2541:                 loc_oLookup.Release()
2542:                 IF USED("cursor_4c_BuscaCli")
2543:                     USE IN cursor_4c_BuscaCli
2544:                 ENDIF
2545:             ENDIF
2546: 
2547:         CATCH TO loException
2548:             MsgErro("Erro em Formacu.AbrirLookupCli:" + CHR(13) + loException.Message, "Erro")
2549:         ENDTRY
2550:     ENDPROC
2551: 
2552:     *==========================================================================
2553:     * HANDLERS DE LOOKUP - CopiarAcessos (sigcdusu) - painel cnt_4c_CopiarAcesso
2554:     *==========================================================================
2555:     PROCEDURE CopiarUsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2556:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
2557:             THIS.AbrirLookupCopiarUsuario()
2558:         ENDIF
2559:     ENDPROC
2560: 
2561:     PROCEDURE CopiarUsuarioDblClick()
2562:         THIS.AbrirLookupCopiarUsuario()
2563:     ENDPROC
2564: 
2565:     PROTECTED PROCEDURE AbrirLookupCopiarUsuario()
2566:         LOCAL loc_oLookup, loc_oPagina
2567:         loc_oLookup = .NULL.
2568:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
2569: 
2570:         TRY
2571:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2572:                 "SELECT usuarios, NComps FROM sigcdusu ORDER BY usuarios", ;
2573:                 "cursor_4c_BuscaUsu")
2574: 
2575:             IF VARTYPE(loc_oLookup) = "O"
2576:                 loc_oLookup.mAddColuna("usuarios", "@!", "Usu" + CHR(225) + "rio")
2577:                 loc_oLookup.mAddColuna("NComps",   "@!", "Nome")
2578:                 loc_oLookup.Show()
2579: 
2580:                 IF loc_oLookup.this_lSelecionou
2581:                     SELECT cursor_4c_BuscaUsu
2582:                     loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
2583:                 ENDIF
2584: 
2585:                 loc_oLookup.Release()
2586:                 IF USED("cursor_4c_BuscaUsu")
2587:                     USE IN cursor_4c_BuscaUsu
2588:                 ENDIF
2589:             ENDIF
2590: 
2591:         CATCH TO loException
2592:             MsgErro("Erro em Formacu.AbrirLookupCopiarUsuario:" + CHR(13) + loException.Message, "Erro")
2593:         ENDTRY
2594:     ENDPROC
2595: 
2596: ENDDEFINE


### BO (C:\4c\projeto\app\classes\acuBO.prg):
*******************************************************************************
* acuBO.prg - Business Object para Cadastro de Usuarios
* Tabela principal: sigcdusu (PK: usuarios)
* Tabelas relacionadas: sigcdacg, sigcdace, sigcdacu, sigcdacb
*******************************************************************************

DEFINE CLASS acuBO AS BusinessBase

    *-- Propriedades da tabela sigcdusu
    this_cUsuarios    = ""  && usuarios char(10) - PK
    this_cNComps      = ""  && ncomps char(30) - nome completo
    this_cSenhas      = ""  && senhas char(10)
    this_cCCargs      = ""  && ccargs char(10) - codigo do cargo
    this_cLimDescs    = ""  && limdescs char(1) - senha do dia (S/N)
    this_cDeptos      = ""  && deptos char(10) - departamento
    this_cLibPess     = ""  && libpess char(1) - libera pesagem (S/N)
    this_cLibProds    = ""  && libprods char(1) - libera producao (S/N)
    this_cSetores     = ""  && setores char(10)
    this_cCativos     = ""  && cativos char(1) - ativo (S/N)
    this_cSupervis    = ""  && supervis char(1)
    this_cMbioDigs    = ""  && mbiodigs text NULL
    this_dTdtSenhas   = {}  && tdtsenhas datetime NULL - data/hora troca senha
    this_cIClis       = ""  && iclis char(10) - codigo cliente vinculado
    this_nObrigSenhas = 0   && obrigsenhas numeric(1,0) - obriga cadastro de senha
    this_cLibQtMins   = ""  && libqtmins char(1) - libera movimentacao (S/N)
    this_cFigJpgSuser = ""  && figjpgsuser text NULL - foto do usuario

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdusu"
        THIS.this_cCampoChave = "usuarios"
        RETURN .T.
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios    = TratarNulo(usuarios,    "C")
            THIS.this_cNComps      = TratarNulo(ncomps,      "C")
            THIS.this_cSenhas      = TratarNulo(senhas,      "C")
            THIS.this_cCCargs      = TratarNulo(ccargs,      "C")
            THIS.this_cLimDescs    = TratarNulo(limdescs,    "C")
            THIS.this_cDeptos      = TratarNulo(deptos,      "C")
            THIS.this_cLibPess     = TratarNulo(libpess,     "C")
            THIS.this_cLibProds    = TratarNulo(libprods,    "C")
            THIS.this_cSetores     = TratarNulo(setores,     "C")
            THIS.this_cCativos     = TratarNulo(cativos,     "C")
            THIS.this_cSupervis    = TratarNulo(supervis,    "C")
            THIS.this_cIClis       = TratarNulo(iclis,       "C")
            THIS.this_nObrigSenhas = TratarNulo(obrigsenhas, "N")
            THIS.this_cLibQtMins   = TratarNulo(libqtmins,   "C")
            IF !ISNULL(tdtsenhas)
                THIS.this_dTdtSenhas = tdtsenhas
            ELSE
                THIS.this_dTdtSenhas = {}
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista usuarios com filtro opcional (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " ORDER BY usuarios"
            ELSE
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " WHERE UPPER(usuarios) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " OR UPPER(ncomps) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " ORDER BY usuarios"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega usuario pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cUsuarios)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM sigcdusu" + ;
                       " WHERE usuarios = " + EscaparSQL(par_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdusu" + ;
                       " (usuarios, ncomps, senhas, ccargs, limdescs, deptos," + ;
                       "  libpess, libprods, setores, cativos, supervis, iclis," + ;
                       "  obrigsenhas, libqtmins)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cUsuarios)    + "," + ;
                       EscaparSQL(THIS.this_cNComps)      + "," + ;
                       EscaparSQL(THIS.this_cSenhas)      + "," + ;
                       EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       EscaparSQL(THIS.this_cSetores)     + "," + ;
                       EscaparSQL(THIS.this_cCativos)     + "," + ;
                       EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       EscaparSQL(THIS.this_cIClis)       + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       EscaparSQL(THIS.this_cLibQtMins)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdusu SET" + ;
                       "  ncomps      = " + EscaparSQL(THIS.this_cNComps)      + "," + ;
                       "  ccargs      = " + EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       "  limdescs    = " + EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       "  deptos      = " + EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       "  libpess     = " + EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       "  libprods    = " + EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       "  setores     = " + EscaparSQL(THIS.this_cSetores)     + "," + ;
                       "  cativos     = " + EscaparSQL(THIS.this_cCativos)     + "," + ;
                       "  supervis    = " + EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       "  iclis       = " + EscaparSQL(THIS.this_cIClis)       + "," + ;
                       "  obrigsenhas = " + FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       "  libqtmins   = " + EscaparSQL(THIS.this_cLibQtMins)   + ;
                       " WHERE usuarios = " + EscaparSQL(THIS.this_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em cascata (sigcdacu,sigcdacg,sigcdace,sigcdacb,sigcdusu)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cUsuarios, loc_nResultado
        loc_lSucesso = .F.
        loc_cUsuarios = EscaparSQL(THIS.this_cUsuarios)

        TRY
            *-- Remover acessos relacionados em cascata
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcu")
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_DlAcu")
                    USE IN cursor_4c_DlAcu
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM sigcdacg WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcg")
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_DlAcg")
                        USE IN cursor_4c_DlAcg
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM sigcdace WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAce")
                    IF loc_nResultado < 0
                        MsgErro("Erro ao excluir empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_DlAce")
                            USE IN cursor_4c_DlAce
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "DELETE FROM sigcdacb WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcb")
                        IF loc_nResultado < 0
                            MsgErro("Erro ao excluir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            IF USED("cursor_4c_DlAcb")
                                USE IN cursor_4c_DlAcb
                            ENDIF

                            loc_nResultado = SQLEXEC(gnConnHandle, ;
                                "DELETE FROM sigcdusu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlUsu")
                            IF loc_nResultado >= 0
                                THIS.RegistrarAuditoria("DELETE")
                                loc_lSucesso = .T.
                            ELSE
                                MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                            IF USED("cursor_4c_DlUsu")
                                USE IN cursor_4c_DlUsu
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega todos os grupos de acesso (sigcdgra)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, dgrus FROM sigcdgra ORDER BY grupos", ;
                "cursor_4c_Grupos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProgramas - Carrega todos os programas (sigcdprg)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProgramas()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, descricaos, programas, parametros, barraforms," + ;
                " barratips, barrapicts, pkchaves, 0 AS marcas" + ;
                " FROM sigcdprg" + ;
                " ORDER BY descricaos, programas, parametros", ;
                "cursor_4c_Programas")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarProgramas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessosPorUsuario - Carrega acessos do usuario (sigcdacu)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Acessos")
                USE IN cursor_4c_Acessos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, programas, parametros, usuarios, pkchaves" + ;
                " FROM sigcdacu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_Acessos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarAcessosPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposPorUsuario - Carrega grupos do usuario (sigcdacg)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GruposUsu")
                USE IN cursor_4c_GruposUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, pkchaves" + ;
                " FROM sigcdacg" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_GruposUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarGruposPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresasPorUsuario - Carrega empresas do usuario (sigcdace)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresasPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_EmpresasUsu")
                USE IN cursor_4c_EmpresasUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT e.usuarios, e.emps, e.pkchaves, c.razas" + ;
                " FROM sigcdace e" + ;
                " LEFT JOIN sigcdemp c ON RTRIM(c.cemps) = RTRIM(e.cemps)" + ;
                " WHERE e.usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_EmpresasUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarEmpresasPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarraPorUsuario - Carrega barra de acesso do usuario (sigcdacb)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarraPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Barra")
                USE IN cursor_4c_Barra
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, descricaos, barraforms, barraordem," + ;
                " programas, parametros, selbarras, pkchaves" + ;
                " FROM sigcdacb" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios) + ;
                " ORDER BY barraordem", ;
                "cursor_4c_Barra")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar barra do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarBarraPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Grava programas marcados em sigcdacu (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorPrg: cursor com programas (campo marcas=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cUsuarios, par_cCursorPrg)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga acessos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcu2")
            IF USED("cursor_4c_DlAcu2")
                USE IN cursor_4c_DlAcu2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Insere apenas os programas marcados
                IF USED(par_cCursorPrg) AND RECCOUNT(par_cCursorPrg) > 0
                    SELECT (par_cCursorPrg)
                    GO TOP
                    SCAN FOR marcas = 1
                        loc_cPK = ALLTRIM(usuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))     + "," + ;
                            EscaparSQL(ALLTRIM(parametros)) + "," + ;
                            EscaparSQL(ALLTRIM(programas))  + "," + ;
                            EscaparSQL(par_cUsuarios)       + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 45))   + ;
                            ")", "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Grava grupos marcados em sigcdacg (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorGru: cursor com grupos (campo marca=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrupos(par_cUsuarios, par_cCursorGru)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga grupos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacg WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcg2")
            IF USED("cursor_4c_DlAcg2")
                USE IN cursor_4c_DlAcg2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorGru) AND RECCOUNT(par_cCursorGru) > 0
                    SELECT (par_cCursorGru)
                    GO TOP
                    SCAN FOR marca = 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos)) + "," + ;
                            EscaparSQL(par_cUsuarios)   + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20)) + ;
                            ")", "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarEmpresas - Grava empresas marcadas em sigcdace (substitui todas)
    * par_cUsuarios: codigo do usuario
    * par_cCursorEmp: cursor com empresas (campo marcas=.T. = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarEmpresas(par_cUsuarios, par_cCursorEmp)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdace WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAce2")
            IF USED("cursor_4c_DlAce2")
                USE IN cursor_4c_DlAce2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorEmp) AND RECCOUNT(par_cCursorEmp) > 0
                    SELECT (par_cCursorEmp)
                    GO TOP
                    SCAN FOR marcas
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(emps)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(ALLTRIM(emps))        + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 13))    + ;
                            ")", "cursor_4c_InsAce")
                        IF USED("cursor_4c_InsAce")
                            USE IN cursor_4c_InsAce
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Grava barra selecionada em sigcdacb (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorBarra: cursor TmpBarra com campos SelBarras, Usuarios, etc.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cUsuarios, par_cCursorBarra)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK, loc_nOrdem
        loc_lSucesso = .F.
        loc_nOrdem   = 0

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacb WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcb2")
            IF USED("cursor_4c_DlAcb2")
                USE IN cursor_4c_DlAcb2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                    SELECT (par_cCursorBarra)
                    SET ORDER TO BarraOrdem
                    GO TOP
                    SCAN FOR !EMPTY(ALLTRIM(usuarios))
                        loc_nOrdem = loc_nOrdem + 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))      + "," + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(descricaos), 73)) + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(barraforms), 50)) + "," + ;
                            FormatarNumeroSQL(loc_nOrdem)    + "," + ;
                            EscaparSQL(ALLTRIM(programas))   + "," + ;
                            EscaparSQL(ALLTRIM(parametros))  + "," + ;
                            IIF(selbarras, "1", "0")         + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20))    + ;
                            ")", "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarBarra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSenha - Reseta a senha do usuario para vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparSenha(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE sigcdusu SET senhas = ''" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_LimSen")
            IF USED("cursor_4c_LimSen")
                USE IN cursor_4c_LimSen
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE-SENHA")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao limpar senha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.LimparSenha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarUsuarioExistente - Verifica se um usuario ja esta cadastrado
    *--------------------------------------------------------------------------
    PROCEDURE VerificarUsuarioExistente(par_cUsuarios)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_VerUsu")
                USE IN cursor_4c_VerUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 usuarios FROM sigcdusu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_VerUsu")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerUsu") > 0
                loc_lExiste = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.VerificarUsuarioExistente:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VerUsu")
            USE IN cursor_4c_VerUsu
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia acessos de um usuario para outro
    * par_cUsuOri: usuario de origem
    * par_cUsuDes: usuario de destino
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cUsuOri, par_cUsuDes)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Copiar sigcdacu (programas/acessos)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                " SELECT a.grupos, a.parametros, a.programas," + ;
                " " + EscaparSQL(par_cUsuDes) + "," + ;
                " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                " AND a.programas + a.parametros NOT IN" + ;
                " (SELECT b.programas + b.parametros FROM sigcdacu b" + ;
                "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao copiar acessos (acu):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Copiar sigcdacg (grupos)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                    " SELECT a.grupos," + ;
                    " " + EscaparSQL(par_cUsuDes) + "," + ;
                    " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos, 20)" + ;
                    " FROM sigcdacg a" + ;
                    " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                    " AND a.grupos NOT IN" + ;
                    " (SELECT b.grupos FROM sigcdacg b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                    "cursor_4c_CpAcg")
                IF USED("cursor_4c_CpAcg")
                    USE IN cursor_4c_CpAcg
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao copiar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Copiar sigcdace (empresas)
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                        " SELECT " + EscaparSQL(par_cUsuDes) + ", a.emps," + ;
                        " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.emps, 13)" + ;
                        " FROM sigcdace a" + ;
                        " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                        " AND a.emps NOT IN" + ;
                        " (SELECT b.emps FROM sigcdace b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                        "cursor_4c_CpAce")
                    IF USED("cursor_4c_CpAce")
                        USE IN cursor_4c_CpAce
                    ENDIF

                    IF loc_nResultado < 0
                        MsgErro("Erro ao copiar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Copiar sigcdacb (barra)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " SELECT a.grupos, " + EscaparSQL(par_cUsuDes) + "," + ;
                            " a.descricaos, a.barraforms, a.barraordem," + ;
                            " a.programas, a.parametros, a.selbarras," + ;
                            " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 20)" + ;
                            " FROM sigcdacb a" + ;
                            " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                            " AND a.programas + a.parametros NOT IN" + ;
                            " (SELECT b.programas + b.parametros FROM sigcdacb b" + ;
                            "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                            "cursor_4c_CpAcb")
                        IF USED("cursor_4c_CpAcb")
                            USE IN cursor_4c_CpAcb
                        ENDIF

                        IF loc_nResultado < 0
                            MsgErro("Erro ao copiar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CopiarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

