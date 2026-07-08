# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CARGA-DADOS] OptionGroup 'opt_4c_Custo' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Fil' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [METODO-INEXISTENTE] Metodo 'THIS.XmlGetNodeText()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.XmlGetAnyNodeText()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Estoque' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_EstoqueTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Mov. Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'processar' (parent: SIGPRCTR.Pagina.Dados.Pageframe1.Page1): Left original=962 vs migrado 'cmd_4c_Processar' Left=917 (diff=45px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3519 linhas total):

*-- Linhas 4 a 24:
4: * Fase 8/8: COMPLETO - todos os metodos implementados
5: *
6: * Estrutura: PageFrame externo (pgf_4c_Paginas)
7: *   Page1 (Lista): cabecalho + filtro periodo + grd_4c_Lista + botoes CRUD
8: *   Page2 (Dados): pgf_4c_Abas (2 sub-paginas) + botoes Confirmar/Cancelar
9: *     pgf_4c_Abas.Page1 (Dados): lbl + txt_4c_Grupo/Conta/Dconta/Cpf/Moeda + opt_4c_Custo
10: *     pgf_4c_Abas.Page2 (Itens): grdDisponivel + grdItemXml
11: *==============================================================================
12: 
13: DEFINE CLASS FormSigPrCtr AS FormBase
14: 
15:     *-- Propriedades visuais (PILAR 1 - UX Fidelity) - EXATAS do original (layout.json)
16:     Height       = 620
17:     Width        = 1200
18:     Caption      = "Controle de Movimentacoes por XML"
19:     AutoCenter   = .T.
20:     ShowWindow   = 1
21:     WindowType   = 1
22:     ControlBox   = .F.
23:     Closable     = .F.
24:     MaxButton    = .F.

*-- Linhas 41 a 181:
41:     this_dDtFim    = {}
42: 
43:     *--------------------------------------------------------------------------
44:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
45:     *--------------------------------------------------------------------------
46:     PROCEDURE Init()
47:         RETURN DODEFAULT()
48:     ENDPROC
49: 
50:     *--------------------------------------------------------------------------
51:     * InicializarForm - Chamado automaticamente por FormBase.Init()
52:     *--------------------------------------------------------------------------
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lSucesso
55:         loc_lSucesso = .F.
56: 
57:         TRY
58:             *-- Caption com acentos (CHR codes obrigatorios - CLAUDE.md regra 4)
59:             THIS.Caption = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
60: 
61:             *-- Instanciar Business Object
62:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")
63: 
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
65: 
66:                 *-- Filtro inicial: hoje (replica comportamento do legado)
67:                 THIS.this_dDtInicio = DATE()
68:                 THIS.this_dDtFim    = DATE()
69: 
70:                 *-- Propagar filtros para o BO
71:                 THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
72:                 THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim
73: 
74:                 *-- Configurar estrutura visual
75:                 THIS.ConfigurarPageFrame()
76: 
77:                 *-- Carregar lista inicial (pular se validando UI sem conexao SQL)
78:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
79:                     IF !THIS.CarregarLista()
80:                         *-- Falha ao carregar nao impede abertura do formulario
81:                     ENDIF
82:                 ENDIF
83: 
84:                 THIS.pgf_4c_Paginas.Visible    = .T.
85:                 THIS.pgf_4c_Paginas.ActivePage = 1
86:                 THIS.this_cModoAtual           = "LISTA"
87:                 loc_lSucesso                   = .T.
88: 
89:             ELSE
90:                 MostrarErro("Erro ao criar SigPrCtrBO." + CHR(13) + ;
91:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
92:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
93:             ENDIF
94: 
95:         CATCH TO loException
96:             THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + ;
97:                                       " - " + loException.Message
98:             MostrarErro("Erro ao inicializar FormSigPrCtr:" + CHR(13) + ;
99:                 THIS.this_cMensagemErro, "Erro")
100:             loc_lSucesso = .F.
101:         ENDTRY
102: 
103:         RETURN loc_lSucesso
104:     ENDPROC
105: 
106:     *--------------------------------------------------------------------------
107:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas (Lista/Dados)
108:     * PageFrame.Top = -29 para ocultar abas -> compensacao +29 nos controles
109:     *--------------------------------------------------------------------------
110:     PROTECTED PROCEDURE ConfigurarPageFrame()
111:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
112: 
113:         WITH THIS.pgf_4c_Paginas
114:             .Top       = -29
115:             .Left      = 0
116:             .Width     = THIS.Width
117:             .Height    = THIS.Height + 29
118:             .PageCount = 2
119:             .Tabs      = .F.
120:             .Visible   = .T.
121:         ENDWITH
122: 
123:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
124:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
126: 
127:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
128:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
130: 
131:         THIS.ConfigurarPaginaLista()
132:         THIS.ConfigurarPaginaDados()
133:     ENDPROC
134: 
135:     *--------------------------------------------------------------------------
136:     * ConfigurarPaginaLista - Configura Page1 (Lista)
137:     * Original: SIGPRCTR.Pagina.Lista
138:     * Contem: cabecalho, filtro periodo, botoes CRUD, grd_4c_Lista
139:     * Compensacao PageFrame.Top=-29: todos os controles com Top += 29
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarPaginaLista()
142:         LOCAL loc_oPagina, loc_oGrid
143:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
144:         loc_oGrid   = .NULL.
145: 
146:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
147: 
148:         *-- Container cabecalho com fundo escuro (cntSombra no legado)
149:         *-- Top = 2 + 29 (compensacao PageFrame.Top=-29) = 31
150:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH loc_oPagina.cnt_4c_Cabecalho
152:             .Top         = 31
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 80
156:             .BackColor   = RGB(100, 100, 100)
157:             .BackStyle   = 1
158:             .BorderWidth = 0
159:             .Visible     = .T.
160:         ENDWITH
161: 
162:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
163:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
164:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
165:             .Top       = 15
166:             .Left      = 10
167:             .Width     = THIS.Width - 20
168:             .Height    = 40
169:             .FontName  = "Tahoma"
170:             .FontSize  = 16
171:             .FontBold  = .T.
172:             .ForeColor = RGB(0, 0, 0)
173:             .BackStyle = 0
174:             .AutoSize  = .F.
175:             .Visible   = .T.
176:         ENDWITH
177: 
178:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
179:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
180:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
181:             .Top       = 18

*-- Linhas 447 a 513:
447:         loc_oGrid.GridLines    = 3
448:         loc_oGrid.Visible      = .T.
449: 
450:         *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
451:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
452:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
453:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
454:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
455:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
456:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
457: 
458:         *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)
459:         BINDEVENT(loc_oPagina.txt_4c_DtInicio, "KeyPress", THIS, "DtInicioLostFocus")
460:         BINDEVENT(loc_oPagina.txt_4c_DtFim,    "KeyPress", THIS, "DtFimLostFocus")
461: 
462:         *-- BINDEVENT do grid: par_nColIndex obrigatorio (Problema 38)
463:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
464: 
465:         THIS.TornarControlesVisiveis(loc_oPagina)
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * ConfigurarPaginaDados - Configura Page2 (Dados)
470:     * Cria: cnt_4c_BotoesAcao (Confirmar/Cancelar), pgf_4c_Abas (2 sub-paginas)
471:     * Campos e grids de pgf_4c_Abas adicionados nas Fases 5-6
472:     *--------------------------------------------------------------------------
473:     PROTECTED PROCEDURE ConfigurarPaginaDados()
474:         LOCAL loc_oPagina, loc_oPgfAbas
475:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
476:         loc_oPgfAbas = .NULL.
477: 
478:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
479: 
480:         *-- Container botoes de acao (Confirmar/Cancelar)
481:         *-- Top = 4 + 29 (compensacao) = 33; Left = 1030 (lado direito)
482:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
483:         WITH loc_oPagina.cnt_4c_BotoesAcao
484:             .Top         = 33
485:             .Left        = 1030
486:             .Width       = 160
487:             .Height      = 85
488:             .BackStyle   = 0
489:             .Visible     = .T.
490:         ENDWITH
491: 
492:         *-- Botao Confirmar (salvar)
493:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
495:             .Caption         = "Confirmar"
496:             .Top             = 5
497:             .Left            = 5
498:             .Width           = 75
499:             .Height          = 75
500:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501:             .PicturePosition = 13
502:             .FontName        = "Comic Sans MS"
503:             .FontSize        = 8
504:             .FontBold        = .T.
505:             .FontItalic      = .T.
506:             .ForeColor       = RGB(90, 90, 90)
507:             .BackColor       = RGB(255, 255, 255)
508:             .Themes          = .F.
509:             .SpecialEffect   = 0
510:             .MousePointer    = 15
511:             .WordWrap        = .T.
512:             .AutoSize        = .F.
513:             .Visible         = .T.

*-- Linhas 537 a 618:
537:             .Visible         = .T.
538:         ENDWITH
539: 
540:         *-- BINDEVENTs dos botoes de acao (PUBLIC para BINDEVENT)
541:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
542:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
543: 
544:         *-- PageFrame interno (Pageframe1 no legado: top=3, left=-1, width=1199, height=624)
545:         *-- Top = 3 + 29 (compensacao) = 32
546:         loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
547:         loc_oPgfAbas = loc_oPagina.pgf_4c_Abas
548: 
549:         loc_oPgfAbas.Top       = 32
550:         loc_oPgfAbas.Left      = -1
551:         loc_oPgfAbas.Width     = 1199
552:         loc_oPgfAbas.Height    = 624
553:         loc_oPgfAbas.PageCount = 2
554:         loc_oPgfAbas.Tabs      = .T.
555:         loc_oPgfAbas.Visible   = .T.
556: 
557:         *-- Page1 (Dados): campos do cabecalho da sessao + grdEstoque (Fase 6)
558:         loc_oPgfAbas.Page1.Caption   = "Dados"
559:         loc_oPgfAbas.Page1.BackColor = RGB(255, 255, 255)
560: 
561:         *-- Page2 (Itens): grdDisponivel + grdItemXml (Fase 6)
562:         loc_oPgfAbas.Page2.Caption   = "Itens"
563:         loc_oPgfAbas.Page2.BackColor = RGB(255, 255, 255)
564: 
565:         *-- Fases 5-6: campos das abas Dados e Itens
566:         THIS.ConfigurarAbaDados()
567:         THIS.ConfigurarAbaItens()
568: 
569:         THIS.TornarControlesVisiveis(loc_oPagina)
570:     ENDPROC
571: 
572:     *--------------------------------------------------------------------------
573:     * ConfigurarAbaDados - Configura pgf_4c_Abas.Page1 (Dados) com campos Fase 5
574:     * Original: SIGPRCTR.Pagina.Dados.Pageframe1.Page1
575:     * Contem: Fornecedor (Grupo/Conta/Dconta/Cpf) + Moeda + opt_4c_Custo
576:     * Sem compensacao Top: pgf_4c_Abas tem Tabs=.T. (coordenadas originais diretas)
577:     *--------------------------------------------------------------------------
578:     PROTECTED PROCEDURE ConfigurarAbaDados()
579:         LOCAL loc_oPage, loc_oOpt
580:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
581:         loc_oOpt  = .NULL.
582: 
583:         *-- Label Fornecedores (Say4: top=69, left=228)
584:         loc_oPage.AddObject("lbl_4c_Fornecedores", "Label")
585:         WITH loc_oPage.lbl_4c_Fornecedores
586:             .Caption   = "Fornecedores:"
587:             .Top       = 69
588:             .Left      = 228
589:             .Width     = 75
590:             .Height    = 17
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(90, 90, 90)
594:             .BackStyle = 0
595:             .AutoSize  = .F.
596:             .Visible   = .T.
597:         ENDWITH
598: 
599:         *-- TextBox Grupo (Get_Grupo: top=66, left=307, width=85)
600:         loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
601:         WITH loc_oPage.txt_4c_Grupo
602:             .Value     = ""
603:             .Top       = 66
604:             .Left      = 307
605:             .Width     = 85
606:             .Height    = 21
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .ForeColor = RGB(90, 90, 90)
610:             .BackColor = RGB(255, 255, 255)
611:             .Visible   = .T.
612:         ENDWITH
613: 
614:         *-- TextBox Conta (Get_Conta: top=66, left=394, width=85)
615:         loc_oPage.AddObject("txt_4c_Conta", "TextBox")
616:         WITH loc_oPage.txt_4c_Conta
617:             .Value     = ""
618:             .Top       = 66

*-- Linhas 708 a 753:
708:             .Visible   = .T.
709:         ENDWITH
710: 
711:         *-- OptionGroup Custo (Opt_Custo: top=113, left=303, width=255, height=17, buttons=2)
712:         *-- Problema 30: NAO setar .Value em Buttons(N); usar OptionGroup.Value para default
713:         loc_oPage.AddObject("opt_4c_Custo", "OptionGroup")
714:         loc_oOpt = loc_oPage.opt_4c_Custo
715: 
716:         loc_oOpt.Top         = 113
717:         loc_oOpt.Left        = 303
718:         loc_oOpt.Width       = 255
719:         loc_oOpt.Height      = 17
720:         loc_oOpt.ButtonCount = 2
721:         loc_oOpt.Value       = 1
722:         loc_oOpt.BackStyle   = 0
723:         loc_oOpt.Visible     = .T.
724: 
725:         WITH loc_oOpt.Buttons(1)
726:             .Caption   = "Custo"
727:             .Top       = 0
728:             .Left      = 0
729:             .Width     = 120
730:             .Height    = 17
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .ForeColor = RGB(90, 90, 90)
734:             .AutoSize  = .F.
735:         ENDWITH
736: 
737:         WITH loc_oOpt.Buttons(2)
738:             .Caption   = "Pre" + CHR(231) + "o de Venda"
739:             .Top       = 0
740:             .Left      = 125
741:             .Width     = 130
742:             .Height    = 17
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(90, 90, 90)
746:             .AutoSize  = .F.
747:         ENDWITH
748: 
749:         *-- Label Moeda (Say3: top=137, left=262)
750:         loc_oPage.AddObject("lbl_4c_Moeda", "Label")
751:         WITH loc_oPage.lbl_4c_Moeda
752:             .Caption   = "Moeda:"
753:             .Top       = 137

*-- Linhas 853 a 898:
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         *-- OptionGroup Opt_Fil (top=179, left=303, width=192, height=24, 3 botoes)
857:         *-- Problema 30: NAO setar .Value em Buttons(N); usar OptionGroup.Value para default
858:         loc_oPage.AddObject("opt_4c_Fil", "OptionGroup")
859:         loc_oOpt = loc_oPage.opt_4c_Fil
860: 
861:         loc_oOpt.Top         = 179
862:         loc_oOpt.Left        = 303
863:         loc_oOpt.Width       = 192
864:         loc_oOpt.Height      = 24
865:         loc_oOpt.ButtonCount = 3
866:         loc_oOpt.Value       = 1
867:         loc_oOpt.BackStyle   = 0
868:         loc_oOpt.Visible     = .T.
869: 
870:         WITH loc_oOpt.Buttons(1)
871:             .Caption   = "Todos"
872:             .Top       = 3
873:             .Left      = 0
874:             .Width     = 58
875:             .Height    = 17
876:             .FontName  = "Tahoma"
877:             .FontSize  = 8
878:             .AutoSize  = .F.
879:         ENDWITH
880: 
881:         WITH loc_oOpt.Buttons(2)
882:             .Caption   = "Cadastrados"
883:             .Top       = 3
884:             .Left      = 60
885:             .Width     = 84
886:             .Height    = 17
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .AutoSize  = .F.
890:         ENDWITH
891: 
892:         WITH loc_oOpt.Buttons(3)
893:             .Caption   = "N" + CHR(227) + "o Cad."
894:             .Top       = 3
895:             .Left      = 146
896:             .Width     = 46
897:             .Height    = 17
898:             .FontName  = "Tahoma"

*-- Linhas 981 a 1064:
981:             .FontName = "Tahoma"
982:             .FontSize = 8
983:             .Themes   = .F.
984:         ENDWITH
985: 
986:         *-- CommandButton cmd_4c_Processar (processar: top=7, left=962, standalone/icon)
987:         *-- Standalone CommandButton com picture: Themes=.T. obrigatorio (memoria)
988:         loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
989:         WITH loc_oPage.cmd_4c_Processar
990:             .Caption         = "Processar"
991:             .Top             = 7
992:             .Left            = 917
993:             .Width           = 75
994:             .Height          = 75
995:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
996:             .PicturePosition = 4
997:             .Themes          = .T.
998:             .FontName        = "Tahoma"
999:             .FontSize        = 8
1000:             .Visible         = .T.
1001:         ENDWITH
1002: 
1003:         *-- BINDEVENTs (todos os handlers devem ser PUBLIC para BINDEVENT)
1004:         BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",         THIS, "ValidarGrupoAba")
1005:         BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",          THIS, "TeclaGrupoAba")
1006:         BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",         THIS, "ValidarContaAba")
1007:         BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",          THIS, "TeclaContaAba")
1008:         BINDEVENT(loc_oPage.txt_4c_Cpf,           "KeyPress",         THIS, "ValidarCpfAba")
1009:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",         THIS, "ValidarMoedaAba")
1010:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",          THIS, "TeclaMoedaAba")
1011:         BINDEVENT(loc_oPage.cmd_4c_Consulta,      "Click",             THIS, "BtnConsultaAbaClick")
1012:         BINDEVENT(loc_oPage.cmd_4c_Cadastros,     "Click",             THIS, "BtnCadastrosAbaClick")
1013:         BINDEVENT(loc_oPage.cmd_4c_BrowseArquivo, "Click",             THIS, "BtnBrowseArquivoClick")
1014:         BINDEVENT(loc_oPage.cmd_4c_Processar,     "Click",             THIS, "BtnProcessarClick")
1015:         BINDEVENT(loc_oPage.cgp_4c_Operacao,      "Click",             THIS, "CgpOperacaoClick")
1016:         BINDEVENT(loc_oPage.grd_4c_Estoque,       "AfterRowColChange", THIS, "GrdEstoqueAfterRowColChange")
1017:     ENDPROC
1018: 
1019:     *--------------------------------------------------------------------------
1020:     * ConfigurarAbaItens - Configura pgf_4c_Abas.Page2 (Itens) com grids e campos
1021:     * Original: SIGPRCTR.Pagina.Dados.Pageframe1.Page2
1022:     * grd_4c_Disponivel (crMovimentos), grd_4c_ItemXml (crDistribui)
1023:     *--------------------------------------------------------------------------
1024:     PROTECTED PROCEDURE ConfigurarAbaItens()
1025:         LOCAL loc_oPage, loc_oGrd
1026:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
1027:         loc_oGrd  = .NULL.
1028: 
1029:         *-- Shape5 decorativo (top=1, left=424, width=282, height=113)
1030:         loc_oPage.AddObject("shp_4c_Shape5", "Shape")
1031:         WITH loc_oPage.shp_4c_Shape5
1032:             .Top         = 1
1033:             .Left        = 424
1034:             .Width       = 282
1035:             .Height      = 113
1036:             .BackStyle   = 1
1037:             .BackColor   = RGB(192, 192, 192)
1038:             .BorderStyle = 0
1039:             .Visible     = .T.
1040:         ENDWITH
1041: 
1042:         *-- Image FigJpg (top=3, left=426, width=278, height=109)
1043:         loc_oPage.AddObject("img_4c_FigJpg", "Image")
1044:         WITH loc_oPage.img_4c_FigJpg
1045:             .Top      = 3
1046:             .Left     = 426
1047:             .Width    = 278
1048:             .Height   = 109
1049:             .Stretch  = 2
1050:             .Visible  = .T.
1051:         ENDWITH
1052: 
1053:         *-- Label "Procurar Produto :" (lbl_produto: top=74, left=8, width=91)
1054:         loc_oPage.AddObject("lbl_4c_Produto", "Label")
1055:         WITH loc_oPage.lbl_4c_Produto
1056:             .Caption   = "Procurar Produto :"
1057:             .Top       = 74
1058:             .Left      = 8
1059:             .Width     = 108
1060:             .Height    = 17
1061:             .FontName  = "Tahoma"
1062:             .FontSize  = 8
1063:             .ForeColor = RGB(90, 90, 90)
1064:             .BackStyle = 0

*-- Linhas 1466 a 1619:
1466:             .Visible   = .T.
1467:         ENDWITH
1468: 
1469:         *-- BINDEVENTs de Page2 (Itens)
1470:         BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
1471:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirSis, "Click",          THIS, "BtnExcluirSisClick")
1472:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirArq, "Click",          THIS, "BtnExcluirArqClick")
1473:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "KeyPress",     THIS, "ProdutoInicialLostFocus")
1474:         BINDEVENT(loc_oPage.img_4c_FigJpg,        "Click",          THIS, "ImgFigJpgClick")
1475:     ENDPROC
1476: 
1477:     *==========================================================================
1478:     * HANDLERS DOS CAMPOS DE pgf_4c_Abas.Page1 (PUBLIC para BINDEVENT)
1479:     *==========================================================================
1480: 
1481:     *--------------------------------------------------------------------------
1482:     * ValidarGrupoAba - LostFocus: valida codigo de grupo em SigCdGcr
1483:     * Original: Get_Grupo.Valid -> fAcessoContab(Usuar,'C',This.Value,...)
1484:     *--------------------------------------------------------------------------
1485:     PROCEDURE ValidarGrupoAba(par_nKeyCode, par_nShiftAltCtrl)
1486:         LOCAL loc_oPage, loc_cGrupo, loc_nRet
1487:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1488:         loc_cGrupo = ""
1489:         loc_nRet   = 0
1490: 
1491:         IF TYPE("loc_oPage.txt_4c_Grupo") != "O"
1492:             RETURN
1493:         ENDIF
1494: 
1495:         loc_cGrupo = ALLTRIM(NVL(loc_oPage.txt_4c_Grupo.Value, ""))
1496: 
1497:         IF EMPTY(loc_cGrupo)
1498:             RETURN
1499:         ENDIF
1500: 
1501:         TRY
1502:             loc_nRet = SQLEXEC(gnConnHandle, ;
1503:                 "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), ;
1504:                 "cursor_4c_BuscaGrupo")
1505: 
1506:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaGrupo") AND !EOF("cursor_4c_BuscaGrupo")
1507:                 *-- Grupo valido
1508:             ELSE
1509:                 THIS.AbrirBuscaGrupoAba()
1510:             ENDIF
1511: 
1512:             IF USED("cursor_4c_BuscaGrupo")
1513:                 USE IN cursor_4c_BuscaGrupo
1514:             ENDIF
1515:         CATCH TO loException
1516:             MsgErro(loException.Message, "Erro em ValidarGrupoAba")
1517:         ENDTRY
1518:     ENDPROC
1519: 
1520:     *--------------------------------------------------------------------------
1521:     * TeclaGrupoAba - KeyPress: F4 abre picker de grupo
1522:     * LPARAMETERS obrigatorio para KeyPress via BINDEVENT (memoria Erro18)
1523:     *--------------------------------------------------------------------------
1524:     PROCEDURE TeclaGrupoAba(par_nKeyCode, par_nShiftAltCtrl)
1525:         IF par_nKeyCode = 115
1526:             THIS.AbrirBuscaGrupoAba()
1527:         ENDIF
1528:     ENDPROC
1529: 
1530:     *--------------------------------------------------------------------------
1531:     * AbrirBuscaGrupoAba - FormBuscaAuxiliar para SigCdGcr
1532:     * SigCdGcr: Codigos (PK) e Descrs (com 'r' - irregularidade, memoria #115)
1533:     *--------------------------------------------------------------------------
1534:     PROCEDURE AbrirBuscaGrupoAba()
1535:         LOCAL loc_oPage, loc_oBusca, loc_cGrupo
1536:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1537:         loc_oBusca = .NULL.
1538:         loc_cGrupo = ""
1539: 
1540:         IF TYPE("loc_oPage.txt_4c_Grupo") != "O"
1541:             RETURN
1542:         ENDIF
1543: 
1544:         loc_cGrupo = ALLTRIM(NVL(loc_oPage.txt_4c_Grupo.Value, ""))
1545: 
1546:         TRY
1547:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1548:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos LIKE " + ;
1549:                     EscaparSQL(loc_cGrupo + "%") + " ORDER BY Codigos", ;
1550:                 "cursor_4c_BusGrupo", ;
1551:                 gnConnHandle)
1552: 
1553:             IF VARTYPE(loc_oBusca) = "O"
1554:                 loc_oBusca.mAddColuna("Codigos", "@!", "Grupo")
1555:                 loc_oBusca.mAddColuna("Descrs",  "",   "Descri" + CHR(231) + CHR(227) + "o")
1556:                 loc_oBusca.Show()
1557: 
1558:                 IF loc_oBusca.this_lSelecionou
1559:                     IF USED("cursor_4c_BusGrupo") AND !EOF("cursor_4c_BusGrupo")
1560:                         loc_oPage.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BusGrupo.Codigos)
1561:                     ENDIF
1562:                 ELSE
1563:                     loc_oPage.txt_4c_Grupo.Value = ""
1564:                 ENDIF
1565:             ENDIF
1566:         CATCH TO loException
1567:             MsgErro(loException.Message, "Erro em AbrirBuscaGrupoAba")
1568:         ENDTRY
1569: 
1570:         IF USED("cursor_4c_BusGrupo")
1571:             USE IN cursor_4c_BusGrupo
1572:         ENDIF
1573:     ENDPROC
1574: 
1575:     *--------------------------------------------------------------------------
1576:     * ValidarContaAba - LostFocus: valida conta em SigCdCli; preenche Dconta e CPF
1577:     * Original: Get_Conta.Valid -> fAcessoContas(...) + preenche Get_Dconta + CPF
1578:     *--------------------------------------------------------------------------
1579:     PROCEDURE ValidarContaAba(par_nKeyCode, par_nShiftAltCtrl)
1580:         LOCAL loc_oPage, loc_cConta, loc_nRet
1581:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1582:         loc_cConta = ""
1583:         loc_nRet   = 0
1584: 
1585:         IF TYPE("loc_oPage.txt_4c_Conta") != "O"
1586:             RETURN
1587:         ENDIF
1588: 
1589:         loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
1590: 
1591:         IF EMPTY(loc_cConta)
1592:             IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1593:                 loc_oPage.txt_4c_Dconta.Value = ""
1594:             ENDIF
1595:             IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1596:                 loc_oPage.txt_4c_Cpf.Value = ""
1597:             ENDIF
1598:             RETURN
1599:         ENDIF
1600: 
1601:         TRY
1602:             loc_nRet = SQLEXEC(gnConnHandle, ;
1603:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
1604:                 "cursor_4c_BuscaConta")
1605: 
1606:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaConta") AND !EOF("cursor_4c_BuscaConta")
1607:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1608:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Rclis, ""))
1609:                 ENDIF
1610:                 IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1611:                     loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Cpfs, ""))
1612:                 ENDIF
1613:             ELSE
1614:                 THIS.AbrirBuscaContaAba()
1615:             ENDIF
1616: 
1617:             IF USED("cursor_4c_BuscaConta")
1618:                 USE IN cursor_4c_BuscaConta
1619:             ENDIF

*-- Linhas 1625 a 2164:
1625:     *--------------------------------------------------------------------------
1626:     * TeclaContaAba - KeyPress: F4 abre picker de conta
1627:     *--------------------------------------------------------------------------
1628:     PROCEDURE TeclaContaAba(par_nKeyCode, par_nShiftAltCtrl)
1629:         IF par_nKeyCode = 115
1630:             THIS.AbrirBuscaContaAba()
1631:         ENDIF
1632:     ENDPROC
1633: 
1634:     *--------------------------------------------------------------------------
1635:     * AbrirBuscaContaAba - FormBuscaAuxiliar para SigCdCli
1636:     * Apos selecao, preenche Dconta (Rclis) e Cpf (Cpfs) automaticamente
1637:     *--------------------------------------------------------------------------
1638:     PROCEDURE AbrirBuscaContaAba()
1639:         LOCAL loc_oPage, loc_oBusca, loc_cConta
1640:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1641:         loc_oBusca = .NULL.
1642:         loc_cConta = ""
1643: 
1644:         IF TYPE("loc_oPage.txt_4c_Conta") != "O"
1645:             RETURN
1646:         ENDIF
1647: 
1648:         loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
1649: 
1650:         TRY
1651:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1652:                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis LIKE " + ;
1653:                     EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis", ;
1654:                 "cursor_4c_BusConta", ;
1655:                 gnConnHandle)
1656: 
1657:             IF VARTYPE(loc_oBusca) = "O"
1658:                 loc_oBusca.mAddColuna("Iclis", "@!", "C" + CHR(243) + "digo")
1659:                 loc_oBusca.mAddColuna("Rclis", "",   "Nome")
1660:                 loc_oBusca.mAddColuna("Cpfs",  "@!", "CPF/CNPJ")
1661:                 loc_oBusca.Show()
1662: 
1663:                 IF loc_oBusca.this_lSelecionou
1664:                     IF USED("cursor_4c_BusConta") AND !EOF("cursor_4c_BusConta")
1665:                         loc_oPage.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BusConta.Iclis)
1666:                         IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1667:                             loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BusConta.Rclis, ""))
1668:                         ENDIF
1669:                         IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1670:                             loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BusConta.Cpfs, ""))
1671:                         ENDIF
1672:                     ENDIF
1673:                 ELSE
1674:                     loc_oPage.txt_4c_Conta.Value = ""
1675:                     IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1676:                         loc_oPage.txt_4c_Dconta.Value = ""
1677:                     ENDIF
1678:                     IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1679:                         loc_oPage.txt_4c_Cpf.Value = ""
1680:                     ENDIF
1681:                 ENDIF
1682:             ENDIF
1683:         CATCH TO loException
1684:             MsgErro(loException.Message, "Erro em AbrirBuscaContaAba")
1685:         ENDTRY
1686: 
1687:         IF USED("cursor_4c_BusConta")
1688:             USE IN cursor_4c_BusConta
1689:         ENDIF
1690:     ENDPROC
1691: 
1692:     *--------------------------------------------------------------------------
1693:     * ValidarCpfAba - LostFocus: valida formato CPF/CNPJ; busca reversa em SigCdCli
1694:     * Original: Get_cpf.Valid -> valida 11 ou 14 digitos; preenche Conta e Dconta
1695:     *--------------------------------------------------------------------------
1696:     PROCEDURE ValidarCpfAba(par_nKeyCode, par_nShiftAltCtrl)
1697:         LOCAL loc_oPage, loc_cCpf, loc_cDigitos, loc_nLen, loc_nRet
1698:         loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1699:         loc_cCpf     = ""
1700:         loc_cDigitos = ""
1701:         loc_nLen     = 0
1702:         loc_nRet     = 0
1703: 
1704:         IF TYPE("loc_oPage.txt_4c_Cpf") != "O"
1705:             RETURN
1706:         ENDIF
1707: 
1708:         loc_cCpf = ALLTRIM(NVL(loc_oPage.txt_4c_Cpf.Value, ""))
1709: 
1710:         IF EMPTY(loc_cCpf)
1711:             RETURN
1712:         ENDIF
1713: 
1714:         *-- Remover mascaras .-/ para contar apenas digitos
1715:         loc_cDigitos = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
1716:         loc_nLen     = LEN(ALLTRIM(loc_cDigitos))
1717: 
1718:         IF loc_nLen != 11 AND loc_nLen != 14
1719:             MsgAviso("CPF deve ter 11 d" + CHR(237) + "gitos ou CNPJ 14 d" + CHR(237) + "gitos!", ;
1720:                 "CPF/CNPJ inv" + CHR(225) + "lido")
1721:             loc_oPage.txt_4c_Cpf.SetFocus()
1722:             RETURN
1723:         ENDIF
1724: 
1725:         *-- Busca reversa: SigCdCli por Cpfs -> preenche Conta e Dconta
1726:         TRY
1727:             loc_nRet = SQLEXEC(gnConnHandle, ;
1728:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cCpf), ;
1729:                 "cursor_4c_BuscaCpf")
1730: 
1731:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaCpf") AND !EOF("cursor_4c_BuscaCpf")
1732:                 IF TYPE("loc_oPage.txt_4c_Conta") = "O"
1733:                     loc_oPage.txt_4c_Conta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Iclis, ""))
1734:                 ENDIF
1735:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1736:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Rclis, ""))
1737:                 ENDIF
1738:             ENDIF
1739: 
1740:             IF USED("cursor_4c_BuscaCpf")
1741:                 USE IN cursor_4c_BuscaCpf
1742:             ENDIF
1743:         CATCH TO loException
1744:             MsgErro(loException.Message, "Erro em ValidarCpfAba")
1745:         ENDTRY
1746:     ENDPROC
1747: 
1748:     *--------------------------------------------------------------------------
1749:     * ValidarMoedaAba - LostFocus: valida codigo de moeda em SigCdMoe
1750:     * Original: Get_Moeda.Valid -> fwbuscaext em SigCdMoe (CMoes/DMoes)
1751:     *--------------------------------------------------------------------------
1752:     PROCEDURE ValidarMoedaAba(par_nKeyCode, par_nShiftAltCtrl)
1753:         LOCAL loc_oPage, loc_cMoeda, loc_nRet
1754:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1755:         loc_cMoeda = ""
1756:         loc_nRet   = 0
1757: 
1758:         IF TYPE("loc_oPage.txt_4c_Moeda") != "O"
1759:             RETURN
1760:         ENDIF
1761: 
1762:         loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
1763: 
1764:         IF EMPTY(loc_cMoeda)
1765:             RETURN
1766:         ENDIF
1767: 
1768:         TRY
1769:             loc_nRet = SQLEXEC(gnConnHandle, ;
1770:                 "SELECT TOP 1 CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), ;
1771:                 "cursor_4c_BuscaMoeda")
1772: 
1773:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaMoeda") AND !EOF("cursor_4c_BuscaMoeda")
1774:                 *-- Moeda valida
1775:             ELSE
1776:                 THIS.AbrirBuscaMoedaAba()
1777:             ENDIF
1778: 
1779:             IF USED("cursor_4c_BuscaMoeda")
1780:                 USE IN cursor_4c_BuscaMoeda
1781:             ENDIF
1782:         CATCH TO loException
1783:             MsgErro(loException.Message, "Erro em ValidarMoedaAba")
1784:         ENDTRY
1785:     ENDPROC
1786: 
1787:     *--------------------------------------------------------------------------
1788:     * TeclaMoedaAba - KeyPress: F4 abre picker de moeda
1789:     *--------------------------------------------------------------------------
1790:     PROCEDURE TeclaMoedaAba(par_nKeyCode, par_nShiftAltCtrl)
1791:         IF par_nKeyCode = 115
1792:             THIS.AbrirBuscaMoedaAba()
1793:         ENDIF
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * AbrirBuscaMoedaAba - FormBuscaAuxiliar para SigCdMoe
1798:     * Substitui fwbuscaext original de Get_Moeda.Valid
1799:     *--------------------------------------------------------------------------
1800:     PROCEDURE AbrirBuscaMoedaAba()
1801:         LOCAL loc_oPage, loc_oBusca, loc_cMoeda
1802:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1803:         loc_oBusca = .NULL.
1804:         loc_cMoeda = ""
1805: 
1806:         IF TYPE("loc_oPage.txt_4c_Moeda") != "O"
1807:             RETURN
1808:         ENDIF
1809: 
1810:         loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
1811: 
1812:         TRY
1813:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1814:                 "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes LIKE " + ;
1815:                     EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes", ;
1816:                 "cursor_4c_BusMoeda", ;
1817:                 gnConnHandle)
1818: 
1819:             IF VARTYPE(loc_oBusca) = "O"
1820:                 loc_oBusca.mAddColuna("CMoes", "@!", "C" + CHR(243) + "digo")
1821:                 loc_oBusca.mAddColuna("DMoes", "",   "Descri" + CHR(231) + CHR(227) + "o")
1822:                 loc_oBusca.Show()
1823: 
1824:                 IF loc_oBusca.this_lSelecionou
1825:                     IF USED("cursor_4c_BusMoeda") AND !EOF("cursor_4c_BusMoeda")
1826:                         loc_oPage.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BusMoeda.CMoes)
1827:                     ENDIF
1828:                 ELSE
1829:                     loc_oPage.txt_4c_Moeda.Value = ""
1830:                 ENDIF
1831:             ENDIF
1832:         CATCH TO loException
1833:             MsgErro(loException.Message, "Erro em AbrirBuscaMoedaAba")
1834:         ENDTRY
1835: 
1836:         IF USED("cursor_4c_BusMoeda")
1837:             USE IN cursor_4c_BusMoeda
1838:         ENDIF
1839:     ENDPROC
1840: 
1841:     *==========================================================================
1842:     * HANDLERS DE pgf_4c_Abas.Page1 - Arquivo/Processar/Estoque (PUBLIC)
1843:     *==========================================================================
1844: 
1845:     *--------------------------------------------------------------------------
1846:     * BtnBrowseArquivoClick - Original: Command12.Click -> GetFile([XML])
1847:     *--------------------------------------------------------------------------
1848:     PROCEDURE BtnBrowseArquivoClick()
1849:         LOCAL loc_oPage, loc_cArquivo
1850:         loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1851:         loc_cArquivo = ""
1852: 
1853:         loc_cArquivo = GETFILE("XML", "Selecionar arquivo XML", "Selecionar")
1854: 
1855:         IF !EMPTY(loc_cArquivo) AND TYPE("loc_oPage.txt_4c_Arquivo") = "O"
1856:             loc_oPage.txt_4c_Arquivo.Value = loc_cArquivo
1857:         ENDIF
1858:     ENDPROC
1859: 
1860:     *--------------------------------------------------------------------------
1861:     * BtnProcessarClick - Original: processar.Click (150 linhas)
1862:     * Valida entradas, chama CarregarArquivosXml + CarregarItemXML + CarregarGradeEstoque
1863:     *--------------------------------------------------------------------------
1864:     PROCEDURE BtnProcessarClick()
1865:         LOCAL loc_oPage, loc_oPage2, loc_cArquivo, loc_cConta, loc_cCpf
1866:         loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1867:         loc_oPage2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
1868:         loc_cArquivo = ""
1869:         loc_cConta   = ""
1870:         loc_cCpf     = ""
1871: 
1872:         IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
1873:             loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
1874:         ENDIF
1875:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
1876:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
1877:         ENDIF
1878:         IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1879:             loc_cCpf = ALLTRIM(NVL(loc_oPage.txt_4c_Cpf.Value, ""))
1880:         ENDIF
1881: 
1882:         IF EMPTY(loc_cArquivo)
1883:             MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
1884:             RETURN
1885:         ENDIF
1886: 
1887:         IF EMPTY(loc_cConta)
1888:             MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
1889:             RETURN
1890:         ENDIF
1891: 
1892:         IF EMPTY(loc_cCpf)
1893:             MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")
1894:             RETURN
1895:         ENDIF
1896: 
1897:         TRY
1898:             THIS.CarregarArquivosXml(loc_cArquivo)
1899:             THIS.CarregarItemXML()
1900:             THIS.CarregarGradeEstoque()
1901: 
1902:             *-- Atualiza display do arquivo na Page2 (Itens)
1903:             IF TYPE("loc_oPage2.txt_4c_Arquivo") = "O"
1904:                 loc_oPage2.txt_4c_Arquivo.Value = loc_cArquivo
1905:             ENDIF
1906:         CATCH TO loException
1907:             MsgErro(loException.Message, "Erro em BtnProcessarClick")
1908:         ENDTRY
1909:     ENDPROC
1910: 
1911:     *--------------------------------------------------------------------------
1912:     * CgpOperacaoClick - Original: cmdOperacao.Valid -> SigCdOpe/SigCdOpd lookup
1913:     * Verifica tipo de operacao e abre SigMvExp ou SigMvObj
1914:     *--------------------------------------------------------------------------
1915:     PROCEDURE CgpOperacaoClick()
1916:         LOCAL loc_oPage, loc_cEmps, loc_cDopes, loc_cNumes, loc_nRet
1917:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1918:         loc_cEmps  = ""
1919:         loc_cDopes = ""
1920:         loc_cNumes = ""
1921:         loc_nRet   = 0
1922: 
1923:         IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
1924:             MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
1925:             RETURN
1926:         ENDIF
1927: 
1928:         SELECT cursor_4c_Estoque
1929:         loc_cEmps  = ALLTRIM(NVL(cursor_4c_Estoque.Emps,  ""))
1930:         loc_cDopes = ALLTRIM(NVL(cursor_4c_Estoque.Dopes, ""))
1931:         loc_cNumes = ALLTRIM(NVL(cursor_4c_Estoque.Numes, ""))
1932: 
1933:         IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
1934:             MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
1935:             RETURN
1936:         ENDIF
1937: 
1938:         TRY
1939:             loc_nRet = SQLEXEC(gnConnHandle, ;
1940:                 "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
1941:                 "cursor_4c_TmpOpe")
1942: 
1943:             IF loc_nRet > 0 AND USED("cursor_4c_TmpOpe") AND !EOF("cursor_4c_TmpOpe")
1944:                 MsgAviso("Formul" + CHR(225) + "rio SigMvExp ainda n" + CHR(227) + "o migrado.", ;
1945:                     "Indispon" + CHR(237) + "vel")
1946:             ELSE
1947:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1948:                     "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), ;
1949:                     "cursor_4c_TmpOpd")
1950: 
1951:                 IF loc_nRet > 0 AND USED("cursor_4c_TmpOpd") AND !EOF("cursor_4c_TmpOpd")
1952:                     MsgAviso("Formul" + CHR(225) + "rio SigMvObj ainda n" + CHR(227) + "o migrado.", ;
1953:                         "Indispon" + CHR(237) + "vel")
1954:                 ELSE
1955:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdOpe/SigCdOpd.", ;
1956:                         "Aviso")
1957:                 ENDIF
1958:             ENDIF
1959:         CATCH TO loException
1960:             MsgErro(loException.Message, "Erro em CgpOperacaoClick")
1961:         ENDTRY
1962: 
1963:         IF USED("cursor_4c_TmpOpe")
1964:             USE IN cursor_4c_TmpOpe
1965:         ENDIF
1966:         IF USED("cursor_4c_TmpOpd")
1967:             USE IN cursor_4c_TmpOpd
1968:         ENDIF
1969:     ENDPROC
1970: 
1971:     *--------------------------------------------------------------------------
1972:     * GrdEstoqueAfterRowColChange - AfterRowColChange de grd_4c_Estoque
1973:     * par_nColIndex obrigatorio para BINDEVENT AfterRowColChange (Problema 38)
1974:     *--------------------------------------------------------------------------
1975:     PROCEDURE GrdEstoqueAfterRowColChange(par_nColIndex)
1976:         LOCAL loc_oPage, loc_lTemRegistro
1977:         loc_oPage        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1978:         loc_lTemRegistro = USED("cursor_4c_Estoque") AND !EOF("cursor_4c_Estoque")
1979: 
1980:         IF TYPE("loc_oPage.cgp_4c_Operacao") = "O"
1981:             loc_oPage.cgp_4c_Operacao.Enabled = loc_lTemRegistro
1982:         ENDIF
1983:     ENDPROC
1984: 
1985:     *--------------------------------------------------------------------------
1986:     * CarregarGradeEstoque - Popula grd_4c_Estoque com SigMvCab disponiveis
1987:     * Original: MontaGrade (25 linhas) -> SELECT SigMvCab + joins + filtros
1988:     * Problema 36: ColumnCount FORA WITH; Problema 32: Headers APOS RecordSource
1989:     * Problema 48: ControlSource APOS RecordSource
1990:     *--------------------------------------------------------------------------
1991:     PROCEDURE CarregarGradeEstoque()
1992:         LOCAL loc_oPage, loc_oGrd, loc_cConta, loc_nOpt, loc_nRet
1993:         LOCAL loc_cSql, loc_cFiltro
1994:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1995:         loc_cConta = ""
1996:         loc_nOpt   = 1
1997:         loc_nRet   = 0
1998:         loc_cSql   = ""
1999:         loc_cFiltro = ""
2000: 
2001:         IF TYPE("loc_oPage.grd_4c_Estoque") != "O"
2002:             RETURN
2003:         ENDIF
2004: 
2005:         *-- Ler filtros da Page1
2006:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2007:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
2008:         ENDIF
2009:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
2010:             loc_nOpt = NVL(loc_oPage.opt_4c_Fil.Value, 1)
2011:         ENDIF
2012: 
2013:         *-- Montar filtro por Conta
2014:         IF !EMPTY(loc_cConta)
2015:             loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(loc_cConta)
2016:         ENDIF
2017: 
2018:         loc_cSql = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes, " + ;
2019:             "a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas " + ;
2020:             "FROM SigMvCab a " + ;
2021:             "JOIN sigcdope b ON a.dopes = b.dopes " + ;
2022:             "JOIN SigOpCdd c ON b.dopes = c.dopes " + ;
2023:             "WHERE Distribui = 3 AND a.chksubn = 0 " + ;
2024:             "AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)" + ;
2025:             loc_cFiltro
2026: 
2027:         TRY
2028:             *-- Limpar RecordSource antes de recriar (Problema 36)
2029:             loc_oPage.grd_4c_Estoque.RecordSource = ""
2030: 
2031:             IF USED("cursor_4c_Estoque")
2032:                 USE IN cursor_4c_Estoque
2033:             ENDIF
2034: 
2035:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Estoque")
2036: 
2037:             IF loc_nRet > 0 AND USED("cursor_4c_Estoque")
2038:                 loc_oGrd = loc_oPage.grd_4c_Estoque
2039: 
2040:                 *-- Problema 36: ColumnCount FORA de WITH
2041:                 loc_oGrd.ColumnCount = 6
2042:                 *-- Problema 36: RecordSource FORA de WITH
2043:                 loc_oGrd.ColumnCount = 5
2044:                 loc_oGrd.RecordSource = "cursor_4c_Estoque"
2045: 
2046:                 *-- Problema 32: Headers APOS RecordSource
2047:                 loc_oGrd.Column1.Header1.Caption = " "
2048:                 loc_oGrd.Column2.Header1.Caption = "Empresa"
2049:                 loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2050:                 loc_oGrd.Column4.Header1.Caption = "Numero"
2051:                 loc_oGrd.Column5.Header1.Caption = "Grupo"
2052:                 loc_oGrd.Column6.Header1.Caption = "Conta"
2053: 
2054:                 *-- Problema 48: ControlSource APOS RecordSource
2055:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
2056:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
2057:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"
2058:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Estoque.Numes"
2059:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Estoque.Grupos"
2060:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Estoque.Contas"
2061: 
2062:                 WITH loc_oGrd
2063:                     .Column1.Width = 25
2064:                     .Column2.Width = 65
2065:                     .Column3.Width = 120
2066:                     .Column4.Width = 80
2067:                     .Column5.Width = 130
2068:                     .Column6.Width = 125
2069:                     .ReadOnly      = .T.
2070:                 ENDWITH
2071: 
2072:                 loc_oGrd.Refresh()
2073:             ENDIF
2074:         CATCH TO loException
2075:             MsgErro(loException.Message, "Erro em CarregarGradeEstoque")
2076:         ENDTRY
2077:     ENDPROC
2078: 
2079:     *--------------------------------------------------------------------------
2080:     * CarregarArquivosXml - Original: carregarquivos (122 linhas)
2081:     * Parseia NF-e XML via MSXML.DOMDOCUMENT e popula cursor crItens
2082:     *--------------------------------------------------------------------------
2083:     PROCEDURE CarregarArquivosXml(par_cArquivo)
2084:         LOCAL loc_oXml, loc_oItens, loc_oDet, loc_nTotal, loc_i
2085:         LOCAL loc_cProd, loc_cDescr, loc_nQtd, loc_nValUni, loc_nValTot
2086:         LOCAL loc_cUnid, loc_cCfop, loc_cNcm, loc_nDesc, loc_nFrete
2087:         LOCAL loc_lResultado
2088:         loc_oXml       = .NULL.
2089:         loc_oItens     = .NULL.
2090:         loc_oDet       = .NULL.
2091:         loc_nTotal     = 0
2092:         loc_i          = 0
2093:         loc_lResultado = .T.
2094: 
2095:         IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
2096:             MsgAviso("Arquivo XML n" + CHR(227) + "o encontrado: " + par_cArquivo, "Aviso")
2097:             RETURN
2098:         ENDIF
2099: 
2100:         TRY
2101:             *-- Limpar cursor anterior
2102:             IF USED("crItens")
2103:                 USE IN crItens
2104:             ENDIF
2105: 
2106:             SET NULL ON
2107:             CREATE CURSOR crItens ;
2108:                 (codigo C(15), Descr C(50), quant N(12,3), valor_uni N(12,4), ;
2109:                  valor_tot N(12,4), unid C(5), cfop C(4), ncm C(8), ;
2110:                  desconto N(12,2), frete N(12,2))
2111:             SET NULL OFF
2112: 
2113:             loc_oXml       = CREATEOBJECT("MSXML.DOMDOCUMENT")
2114:             loc_oXml.Async = .F.
2115: 
2116:             IF !loc_oXml.Load(par_cArquivo)
2117:                 MsgAviso(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2118:                 loc_lResultado = .F.
2119:             ENDIF
2120: 
2121:             IF loc_lResultado
2122:                 loc_oItens = loc_oXml.selectNodes("//det")
2123:                 IF ISNULL(loc_oItens)
2124:                     MsgAviso("Nenhum item encontrado no XML.", "Aviso")
2125:                     loc_lResultado = .F.
2126:                 ENDIF
2127:             ENDIF
2128: 
2129:             IF loc_lResultado
2130:                 loc_nTotal = loc_oItens.length
2131: 
2132:                 DO WHILE loc_i < loc_nTotal
2133:                     loc_oDet    = loc_oItens.item(loc_i)
2134: 
2135:                     loc_cProd   = THIS.XmlGetNodeText(loc_oDet, "cProd")
2136:                     loc_cDescr  = THIS.XmlGetNodeText(loc_oDet, "xProd")
2137:                     loc_nQtd    = VAL(THIS.XmlGetNodeText(loc_oDet, "qCom"))
2138:                     loc_nValUni = VAL(THIS.XmlGetNodeText(loc_oDet, "vUnCom"))
2139:                     loc_nValTot = VAL(THIS.XmlGetNodeText(loc_oDet, "vProd"))
2140:                     loc_cUnid   = THIS.XmlGetNodeText(loc_oDet, "uCom")
2141:                     loc_cCfop   = THIS.XmlGetNodeText(loc_oDet, "CFOP")
2142:                     loc_cNcm    = THIS.XmlGetNodeText(loc_oDet, "NCM")
2143:                     loc_nDesc   = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vDesc,vdesc"))
2144:                     loc_nFrete  = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vFrete,vfrete"))
2145: 
2146:                     SELECT crItens
2147:                     INSERT INTO crItens VALUES ;
2148:                         (PADR(ALLTRIM(NVL(loc_cProd,  "")), 15), ;
2149:                          PADR(ALLTRIM(NVL(loc_cDescr, "")), 50), ;
2150:                          loc_nQtd, loc_nValUni, loc_nValTot, ;
2151:                          PADR(ALLTRIM(NVL(loc_cUnid, "")), 5), ;
2152:                          PADR(ALLTRIM(NVL(loc_cCfop, "")), 4), ;
2153:                          PADR(ALLTRIM(NVL(loc_cNcm,  "")), 8), ;
2154:                          loc_nDesc, loc_nFrete)
2155: 
2156:                     loc_i = loc_i + 1
2157:                 ENDDO
2158:             ENDIF
2159: 
2160:         CATCH TO loException
2161:             MsgErro(loException.Message, "Erro em CarregarArquivosXml")
2162:         ENDTRY
2163: 
2164:         loc_oXml   = .NULL.

*-- Linhas 2225 a 2279:
2225:     * Encontrado -> crMovimentos (grd_4c_Disponivel)
2226:     * Nao encontrado -> crDistribui (grd_4c_ItemXml)
2227:     *--------------------------------------------------------------------------
2228:     PROCEDURE CarregarItemXML()
2229:         LOCAL loc_oPage, loc_cConta, loc_nOpt, loc_nRet, loc_lResultado
2230:         LOCAL loc_cProd, loc_cDescr, loc_nQtd, loc_nValTot
2231:         LOCAL loc_cCpros, loc_cDpros, loc_cReffs, loc_nPesoms, loc_nPvens
2232:         LOCAL loc_cMoevs, loc_nCustofs, loc_cMoecusfs, loc_nFcustos, loc_cCodCors
2233:         loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2234:         loc_lResultado = .F.
2235:         loc_cConta     = ""
2236:         loc_nOpt       = 1
2237: 
2238:         IF !USED("crItens") OR RECCOUNT("crItens") = 0
2239:             MsgAviso("Nenhum item XML carregado. Selecione e processe um arquivo XML primeiro.", "Aviso")
2240:             RETURN
2241:         ENDIF
2242: 
2243:         *-- Ler filtros
2244:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2245:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
2246:         ENDIF
2247:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
2248:             loc_nOpt = NVL(loc_oPage.opt_4c_Fil.Value, 1)
2249:         ENDIF
2250: 
2251:         TRY
2252:             *-- Limpar cursores anteriores
2253:             IF USED("crMovimentos")
2254:                 USE IN crMovimentos
2255:             ENDIF
2256:             IF USED("crDistribui")
2257:                 USE IN crDistribui
2258:             ENDIF
2259: 
2260:             SET NULL ON
2261:             CREATE CURSOR crMovimentos ;
2262:                 (Cpros C(15), Dpros C(50), reffs C(25), pesoms N(12,3), ;
2263:                  pvens N(12,2), moevs C(3), custofs N(12,2), moecusfs C(3), ;
2264:                  fcustos N(12,2), Emps C(4), Dopes C(10), Numes C(10), ;
2265:                  CodCors C(5), CdChaves C(36), Qtds N(12,3), ;
2266:                  QtdBaixa N(12,3), QtdRes N(12,3), QtdSaldo N(12,3))
2267: 
2268:             CREATE CURSOR crDistribui ;
2269:                 (refForn C(25), Descr C(50), Qtds N(12,3), Valor N(12,2))
2270:             SET NULL OFF
2271: 
2272:             *-- Iterar crItens e tentar localizar em SigCdPro por ifors (ref fornecedor)
2273:             SELECT crItens
2274:             GO TOP IN crItens
2275:             SCAN
2276:                 loc_cProd   = ALLTRIM(NVL(crItens.codigo, ""))
2277:                 loc_nQtd    = NVL(crItens.quant, 0)
2278:                 loc_nValTot = NVL(crItens.valor_tot, 0)
2279:                 loc_cDescr  = ALLTRIM(NVL(crItens.Descr, ""))

*-- Linhas 2347 a 2390:
2347:     * CarregarGradeDisponivel - Seta RecordSource de grd_4c_Disponivel -> crMovimentos
2348:     * Problema 36/32/48: ColumnCount/RecordSource/ControlSource na ordem certa
2349:     *--------------------------------------------------------------------------
2350:     PROCEDURE CarregarGradeDisponivel()
2351:         LOCAL loc_oPage2, loc_oGrd
2352:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2353:         loc_oGrd   = .NULL.
2354: 
2355:         IF TYPE("loc_oPage2.grd_4c_Disponivel") != "O"
2356:             RETURN
2357:         ENDIF
2358: 
2359:         IF !USED("crMovimentos")
2360:             RETURN
2361:         ENDIF
2362: 
2363:         TRY
2364:             loc_oGrd = loc_oPage2.grd_4c_Disponivel
2365:             loc_oGrd.RecordSource = ""
2366:             loc_oGrd.ColumnCount  = 7
2367:             loc_oGrd.RecordSource = "crMovimentos"
2368: 
2369:             *-- Problema 32: Headers APOS RecordSource
2370:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2371:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2372:             loc_oGrd.Column3.Header1.Caption = "Valor"
2373:             loc_oGrd.Column4.Header1.Caption = "Quantidade"
2374:             loc_oGrd.Column5.Header1.Caption = "Baixado"
2375:             loc_oGrd.Column6.Header1.Caption = "Reservado"
2376:             loc_oGrd.Column7.Header1.Caption = "Saldo"
2377: 
2378:             *-- Problema 48: ControlSource APOS RecordSource
2379:             loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
2380:             loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
2381:             loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"
2382:             loc_oGrd.Column4.ControlSource = "crMovimentos.Qtds"
2383:             loc_oGrd.Column5.ControlSource = "crMovimentos.QtdBaixa"
2384:             loc_oGrd.Column6.ControlSource = "crMovimentos.QtdRes"
2385:             loc_oGrd.Column7.ControlSource = "crMovimentos.QtdSaldo"
2386: 
2387:             WITH loc_oGrd
2388:                 .Column1.Width = 80
2389:                 .Column2.Width = 200
2390:                 .Column3.Width = 80

*-- Linhas 2409 a 2503:
2409:     *--------------------------------------------------------------------------
2410:     * CarregarGradeItemXml - Seta RecordSource de grd_4c_ItemXml -> crDistribui
2411:     *--------------------------------------------------------------------------
2412:     PROCEDURE CarregarGradeItemXml()
2413:         LOCAL loc_oPage2, loc_oGrd
2414:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2415:         loc_oGrd   = .NULL.
2416: 
2417:         IF TYPE("loc_oPage2.grd_4c_ItemXml") != "O"
2418:             RETURN
2419:         ENDIF
2420: 
2421:         IF !USED("crDistribui")
2422:             RETURN
2423:         ENDIF
2424: 
2425:         TRY
2426:             loc_oGrd = loc_oPage2.grd_4c_ItemXml
2427:             loc_oGrd.RecordSource = ""
2428:             loc_oGrd.ColumnCount  = 4
2429:             loc_oGrd.RecordSource = "crDistribui"
2430: 
2431:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2432:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2433:             loc_oGrd.Column3.Header1.Caption = "Quantidade"
2434:             loc_oGrd.Column4.Header1.Caption = "Valor"
2435: 
2436:             loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
2437:             loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
2438:             loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
2439:             loc_oGrd.Column4.ControlSource = "crDistribui.Valor"
2440: 
2441:             WITH loc_oGrd
2442:                 .Column1.Width = 100
2443:                 .Column2.Width = 220
2444:                 .Column3.Width = 80
2445:                 .Column4.Width = 93
2446:             ENDWITH
2447: 
2448:             loc_oGrd.Refresh()
2449: 
2450:         CATCH TO loException
2451:             MsgErro(loException.Message, "Erro em CarregarGradeItemXml")
2452:         ENDTRY
2453:     ENDPROC
2454: 
2455:     *==========================================================================
2456:     * HANDLERS DE pgf_4c_Abas.Page2 (Itens) (PUBLIC para BINDEVENT)
2457:     *==========================================================================
2458: 
2459:     *--------------------------------------------------------------------------
2460:     * GrdDisponivelAfterRowColChange - Popula campos de detalhe do produto corrente
2461:     * Original: grdDisponivel.Procedure (111 linhas) -> atualiza campos display
2462:     *--------------------------------------------------------------------------
2463:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
2464:         LOCAL loc_oPage2
2465:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2466: 
2467:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2468:             RETURN
2469:         ENDIF
2470: 
2471:         SELECT crMovimentos
2472: 
2473:         *-- Atualizar campos de detalhe na Page2 a partir de crMovimentos
2474:         IF TYPE("loc_oPage2.txt_4c_RefFornecedor") = "O"
2475:             loc_oPage2.txt_4c_RefFornecedor.Value = ALLTRIM(NVL(crMovimentos.reffs,    ""))
2476:         ENDIF
2477:         IF TYPE("loc_oPage2.txt_4c_PrVenda") = "O"
2478:             loc_oPage2.txt_4c_PrVenda.Value       = NVL(crMovimentos.pvens, 0)
2479:         ENDIF
2480:         IF TYPE("loc_oPage2.txt_4c_PrVendaMoeda") = "O"
2481:             loc_oPage2.txt_4c_PrVendaMoeda.Value  = ALLTRIM(NVL(crMovimentos.moevs,    ""))
2482:         ENDIF
2483:         IF TYPE("loc_oPage2.txt_4c_PesoMedio") = "O"
2484:             loc_oPage2.txt_4c_PesoMedio.Value     = NVL(crMovimentos.pesoms, 0)
2485:         ENDIF
2486:         IF TYPE("loc_oPage2.txt_4c_Custofs") = "O"
2487:             loc_oPage2.txt_4c_Custofs.Value       = NVL(crMovimentos.custofs, 0)
2488:         ENDIF
2489:         IF TYPE("loc_oPage2.txt_4c_Moecusfs") = "O"
2490:             loc_oPage2.txt_4c_Moecusfs.Value      = ALLTRIM(NVL(crMovimentos.moecusfs, ""))
2491:         ENDIF
2492:         IF TYPE("loc_oPage2.txt_4c_PrecoMov") = "O"
2493:             loc_oPage2.txt_4c_PrecoMov.Value      = NVL(crMovimentos.fcustos, 0)
2494:         ENDIF
2495:         IF TYPE("loc_oPage2.txt_4c_Emps") = "O"
2496:             loc_oPage2.txt_4c_Emps.Value          = ALLTRIM(NVL(crMovimentos.Emps,  ""))
2497:         ENDIF
2498:         IF TYPE("loc_oPage2.txt_4c_Dopes") = "O"
2499:             loc_oPage2.txt_4c_Dopes.Value         = ALLTRIM(NVL(crMovimentos.Dopes, ""))
2500:         ENDIF
2501:         IF TYPE("loc_oPage2.txt_4c_Numes") = "O"
2502:             loc_oPage2.txt_4c_Numes.Value         = ALLTRIM(NVL(crMovimentos.Numes, ""))
2503:         ENDIF

*-- Linhas 2514 a 2776:
2514:     *--------------------------------------------------------------------------
2515:     * BtnExcluirSisClick - Original: btnExcluirSis.Click -> DELETE em crMovimentos
2516:     *--------------------------------------------------------------------------
2517:     PROCEDURE BtnExcluirSisClick()
2518:         LOCAL loc_oPage2, loc_oGrd
2519:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2520: 
2521:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2522:             RETURN
2523:         ENDIF
2524: 
2525:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2526:             RETURN
2527:         ENDIF
2528: 
2529:         TRY
2530:             SELECT crMovimentos
2531:             IF !EOF()
2532:                 DELETE
2533:             ENDIF
2534: 
2535:             *-- Posicionar no proximo registro disponivel
2536:             SET DELETED ON
2537:             IF !EOF()
2538:                 SKIP
2539:                 SKIP -1
2540:             ELSE
2541:                 GO TOP
2542:             ENDIF
2543: 
2544:             *-- Atualizar grade e campos de detalhe
2545:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2546:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2547:             ENDIF
2548: 
2549:             IF !EOF("crMovimentos")
2550:                 THIS.GrdDisponivelAfterRowColChange(1)
2551:             ENDIF
2552: 
2553:         CATCH TO loException
2554:             MsgErro(loException.Message, "Erro em BtnExcluirSisClick")
2555:         ENDTRY
2556:     ENDPROC
2557: 
2558:     *--------------------------------------------------------------------------
2559:     * BtnExcluirArqClick - Original: btnExcluirArq.Click -> DELETE em crDistribui
2560:     *--------------------------------------------------------------------------
2561:     PROCEDURE BtnExcluirArqClick()
2562:         LOCAL loc_oPage2
2563:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2564: 
2565:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2566:             RETURN
2567:         ENDIF
2568: 
2569:         IF !USED("crDistribui") OR EOF("crDistribui")
2570:             RETURN
2571:         ENDIF
2572: 
2573:         TRY
2574:             SELECT crDistribui
2575:             IF !EOF()
2576:                 DELETE
2577:             ENDIF
2578: 
2579:             SET DELETED ON
2580:             IF !EOF()
2581:                 SKIP
2582:                 SKIP -1
2583:             ELSE
2584:                 GO TOP
2585:             ENDIF
2586: 
2587:             IF TYPE("loc_oPage2.grd_4c_ItemXml") = "O"
2588:                 loc_oPage2.grd_4c_ItemXml.Refresh()
2589:             ENDIF
2590: 
2591:         CATCH TO loException
2592:             MsgErro(loException.Message, "Erro em BtnExcluirArqClick")
2593:         ENDTRY
2594:     ENDPROC
2595: 
2596:     *--------------------------------------------------------------------------
2597:     * ProdutoInicialLostFocus - Original: get_produto_inicial.Valid
2598:     * Navega grd_4c_Disponivel para o produto digitado
2599:     *--------------------------------------------------------------------------
2600:     PROCEDURE ProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2601:         LOCAL loc_oPage2, loc_cProd, loc_nRec
2602:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2603:         loc_cProd  = ""
2604:         loc_nRec   = 0
2605: 
2606:         IF TYPE("loc_oPage2.txt_4c_ProdutoInicial") != "O"
2607:             RETURN
2608:         ENDIF
2609: 
2610:         loc_cProd = ALLTRIM(NVL(loc_oPage2.txt_4c_ProdutoInicial.Value, ""))
2611: 
2612:         IF EMPTY(loc_cProd) OR !USED("crMovimentos")
2613:             RETURN
2614:         ENDIF
2615: 
2616:         TRY
2617:             SELECT crMovimentos
2618:             loc_nRec = RECNO()
2619:             GO TOP
2620: 
2621:             LOCATE FOR Cpros = PADR(loc_cProd, 15)
2622: 
2623:             IF EOF()
2624:                 GO loc_nRec
2625:             ENDIF
2626: 
2627:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2628:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2629:             ENDIF
2630: 
2631:             THIS.GrdDisponivelAfterRowColChange(1)
2632: 
2633:         CATCH TO loException
2634:             MsgErro(loException.Message, "Erro em ProdutoInicialLostFocus")
2635:         ENDTRY
2636:     ENDPROC
2637: 
2638:     *--------------------------------------------------------------------------
2639:     * ImgFigJpgClick - Original: FigJpg.Click -> carrega imagem do produto
2640:     * Busca SigCdPro.FigJpgs, salva em temp e exibe na img_4c_FigJpg
2641:     *--------------------------------------------------------------------------
2642:     PROCEDURE ImgFigJpgClick()
2643:         LOCAL loc_oPage2, loc_cCpros, loc_cArqTemp, loc_nRet
2644:         loc_oPage2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2645:         loc_cCpros  = ""
2646:         loc_cArqTemp = ""
2647:         loc_nRet    = 0
2648: 
2649:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2650:             RETURN
2651:         ENDIF
2652: 
2653:         SELECT crMovimentos
2654:         loc_cCpros = ALLTRIM(NVL(crMovimentos.Cpros, ""))
2655: 
2656:         IF EMPTY(loc_cCpros)
2657:             RETURN
2658:         ENDIF
2659: 
2660:         TRY
2661:             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
2662: 
2663:             loc_nRet = SQLEXEC(gnConnHandle, ;
2664:                 "SELECT TOP 1 a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
2665:                 "cursor_4c_TmpFig")
2666: 
2667:             IF loc_nRet > 0 AND USED("cursor_4c_TmpFig") AND !EOF("cursor_4c_TmpFig")
2668:                 IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
2669:                     STRTOFILE(cursor_4c_TmpFig.FigJpgs, loc_cArqTemp)
2670:                     IF FILE(loc_cArqTemp) AND TYPE("loc_oPage2.img_4c_FigJpg") = "O"
2671:                         loc_oPage2.img_4c_FigJpg.Picture = loc_cArqTemp
2672:                     ENDIF
2673:                 ENDIF
2674:             ENDIF
2675: 
2676:             IF USED("cursor_4c_TmpFig")
2677:                 USE IN cursor_4c_TmpFig
2678:             ENDIF
2679: 
2680:         CATCH TO loException
2681:             MsgErro(loException.Message, "Erro em ImgFigJpgClick")
2682:         ENDTRY
2683:     ENDPROC
2684: 
2685:     *--------------------------------------------------------------------------
2686:     * GravarSessaoXml - Grava todos os produtos de crMovimentos como linhas SigPrCtr
2687:     * Original: cgp_Salva.salva.Click (106 linhas) - padrao multi-row INSERT
2688:     * Para cada linha de crMovimentos (nao deletadas): chama BO.Inserir()
2689:     *--------------------------------------------------------------------------
2690:     PROCEDURE GravarSessaoXml()
2691:         LOCAL loc_oPage, loc_cCodigos, loc_cConta, loc_cArquivo, loc_cMoeda
2692:         LOCAL loc_nOpt, loc_lResultado, loc_nContador
2693:         LOCAL loc_cCpros, loc_cCodCors, loc_nQtds, loc_cEmps, loc_cDopes
2694:         LOCAL loc_cNumes, loc_cCdChaves, loc_cDescr
2695:         loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2696:         loc_lResultado = .F.
2697:         loc_nContador  = 0
2698:         loc_cCodigos   = ""
2699:         loc_cConta     = ""
2700:         loc_cArquivo   = ""
2701:         loc_cMoeda     = ""
2702:         loc_nOpt       = 1
2703: 
2704:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2705:             MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
2706:             RETURN
2707:         ENDIF
2708: 
2709:         IF !USED("crMovimentos")
2710:             MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
2711:             RETURN
2712:         ENDIF
2713: 
2714:         *-- Verificar se ha registros em crMovimentos (RECCOUNT ignora SET DELETED)
2715:         IF RECCOUNT("crMovimentos") = 0
2716:             MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
2717:             RETURN
2718:         ENDIF
2719:         SET DELETED ON
2720: 
2721:         *-- Ler campos da Page1
2722:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2723:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
2724:         ENDIF
2725:         IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
2726:             loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
2727:         ENDIF
2728:         IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
2729:             loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
2730:         ENDIF
2731:         IF TYPE("loc_oPage.opt_4c_Custo") = "O"
2732:             loc_nOpt = NVL(loc_oPage.opt_4c_Custo.Value, 1)
2733:         ENDIF
2734: 
2735:         IF EMPTY(loc_cConta)
2736:             MsgAviso("Conta obrigat" + CHR(243) + "ria.", "Aviso")
2737:             RETURN
2738:         ENDIF
2739: 
2740:         TRY
2741:             *-- Obter Codigos da sessao (gerar novo ou usar existente)
2742:             loc_cCodigos = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigos, ""))
2743: 
2744:             IF EMPTY(loc_cCodigos)
2745:                 THIS.this_oBusinessObject.GerarNovoCodigos()
2746:                 loc_cCodigos = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cCodigos, ""))
2747:             ELSE
2748:                 *-- Alterar: excluir linhas anteriores antes de reinserir
2749:                 THIS.this_oBusinessObject.ExcluirLinhasSessao(loc_cCodigos)
2750:             ENDIF
2751: 
2752:             IF EMPTY(loc_cCodigos)
2753:                 MsgErro("Falha ao gerar c" + CHR(243) + "digo da sess" + CHR(227) + "o.", "Erro")
2754:                 loc_lResultado = .F.
2755:             ELSE
2756:                 *-- Inserir cada linha de crMovimentos (nao deletados)
2757:                 SELECT crMovimentos
2758:                 GO TOP IN crMovimentos
2759:                 SCAN
2760:                     loc_cCpros    = ALLTRIM(NVL(crMovimentos.Cpros,    ""))
2761:                     loc_cCodCors  = ALLTRIM(NVL(crMovimentos.CodCors,  ""))
2762:                     loc_nQtds     = NVL(crMovimentos.Qtds, 0)
2763:                     loc_cEmps     = ALLTRIM(NVL(crMovimentos.Emps,     ""))
2764:                     loc_cDopes    = ALLTRIM(NVL(crMovimentos.Dopes,    ""))
2765:                     loc_cNumes    = ALLTRIM(NVL(crMovimentos.Numes,    ""))
2766:                     loc_cCdChaves = ALLTRIM(NVL(crMovimentos.CdChaves, ""))
2767: 
2768:                     IF EMPTY(loc_cCpros)
2769:                         SELECT crMovimentos
2770:                         LOOP
2771:                     ENDIF
2772: 
2773:                     THIS.this_oBusinessObject.this_cCodigos    = loc_cCodigos
2774:                     THIS.this_oBusinessObject.this_cCpros      = loc_cCpros
2775:                     THIS.this_oBusinessObject.this_cCodCors    = loc_cCodCors
2776:                     THIS.this_oBusinessObject.this_cCodTams    = ""

*-- Linhas 2814 a 2876:
2814:     *--------------------------------------------------------------------------
2815:     * BtnConsultaAbaClick - Original: Bot_Consulta.Click -> DO Form SigOpCgv
2816:     *--------------------------------------------------------------------------
2817:     PROCEDURE BtnConsultaAbaClick()
2818:         MsgAviso("Formul" + CHR(225) + "rio SigOpCgv ainda n" + CHR(227) + "o migrado.", ;
2819:             "Indispon" + CHR(237) + "vel")
2820:     ENDPROC
2821: 
2822:     *--------------------------------------------------------------------------
2823:     * BtnCadastrosAbaClick - Original: btnCadastros.Click -> DO Form SIGCDCTA
2824:     *--------------------------------------------------------------------------
2825:     PROCEDURE BtnCadastrosAbaClick()
2826:         MsgAviso("Formul" + CHR(225) + "rio SIGCDCTA ainda n" + CHR(227) + "o migrado.", ;
2827:             "Indispon" + CHR(237) + "vel")
2828:     ENDPROC
2829: 
2830:     *--------------------------------------------------------------------------
2831:     * LimparCampos - Zera campos de pgf_4c_Abas.Page1 e Page2 para nova inclusao
2832:     *--------------------------------------------------------------------------
2833:     PROTECTED PROCEDURE LimparCampos()
2834:         LOCAL loc_oPage, loc_oPage2
2835:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2836:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2837: 
2838:         *-- Page1 (Dados)
2839:         IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
2840:             loc_oPage.txt_4c_Grupo.Value = ""
2841:         ENDIF
2842:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2843:             loc_oPage.txt_4c_Conta.Value = ""
2844:         ENDIF
2845:         IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
2846:             loc_oPage.txt_4c_Dconta.Value = ""
2847:         ENDIF
2848:         IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
2849:             loc_oPage.txt_4c_Cpf.Value = ""
2850:         ENDIF
2851:         IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
2852:             loc_oPage.txt_4c_Moeda.Value = ""
2853:         ENDIF
2854:         IF TYPE("loc_oPage.opt_4c_Custo") = "O"
2855:             loc_oPage.opt_4c_Custo.Value = 1
2856:         ENDIF
2857:         IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
2858:             loc_oPage.txt_4c_Arquivo.Value = ""
2859:         ENDIF
2860:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
2861:             loc_oPage.opt_4c_Fil.Value = 1
2862:         ENDIF
2863:         IF TYPE("loc_oPage.grd_4c_Estoque") = "O"
2864:             loc_oPage.grd_4c_Estoque.RecordSource = ""
2865:         ENDIF
2866: 
2867:         *-- Page2 (Itens)
2868:         IF TYPE("loc_oPage2.txt_4c_Sistema") = "O"
2869:             loc_oPage2.txt_4c_Sistema.Value = ""
2870:         ENDIF
2871:         IF TYPE("loc_oPage2.txt_4c_Arquivo") = "O"
2872:             loc_oPage2.txt_4c_Arquivo.Value = ""
2873:         ENDIF
2874:         IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2875:             loc_oPage2.grd_4c_Disponivel.RecordSource = ""
2876:         ENDIF

*-- Linhas 2899 a 2942:
2899:     * REGRA: ControlSource APOS RecordSource (evita auto-bind - Problema 48)
2900:     * REGRA: Header1.Caption APOS RecordSource (evita reset - Problema 32)
2901:     *--------------------------------------------------------------------------
2902:     PROCEDURE CarregarLista()
2903:         LOCAL loc_lResultado, loc_oGrid
2904:         loc_lResultado = .F.
2905:         loc_oGrid      = .NULL.
2906: 
2907:         TRY
2908:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2909:                 loc_lResultado = .T.
2910:             ELSE
2911:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2912:                     THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
2913:                     THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim
2914: 
2915:                     IF THIS.this_oBusinessObject.Buscar("")
2916:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2917: 
2918:                         *-- RecordSource FORA de WITH (Problema 36: criacao imediata das colunas)
2919:                         loc_oGrid.ColumnCount = 6
2920:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2921: 
2922:                         *-- ControlSource APOS RecordSource (Problema 48: auto-bind)
2923:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2924:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
2925:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OriDopNums"
2926:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Usuars"
2927:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Contas"
2928:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Rclis"
2929: 
2930:                         loc_oGrid.Column1.Width = 80
2931:                         loc_oGrid.Column2.Width = 120
2932:                         loc_oGrid.Column3.Width = 100
2933:                         loc_oGrid.Column4.Width = 100
2934:                         loc_oGrid.Column5.Width = 100
2935:                         loc_oGrid.Column6.Width = 680
2936: 
2937:                         *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
2938:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2939:                         loc_oGrid.Column2.Header1.Caption = "Data"
2940:                         loc_oGrid.Column3.Header1.Caption = "Mov. Origem"
2941:                         loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
2942:                         loc_oGrid.Column5.Header1.Caption = "Conta"

*-- Linhas 2961 a 3430:
2961:     *--------------------------------------------------------------------------
2962:     * FormatarGridLista - Formata visual do grid de lista
2963:     *--------------------------------------------------------------------------
2964:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2965:         WITH par_oGrid
2966:             .FontName = "Tahoma"
2967:             .FontSize = 8
2968:             .SetAll("ForeColor", RGB(90, 90, 90), "Column")
2969:         ENDWITH
2970:     ENDPROC
2971: 
2972:     *--------------------------------------------------------------------------
2973:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
2974:     *--------------------------------------------------------------------------
2975:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2976:         LOCAL loc_lResultado
2977:         loc_lResultado = .F.
2978: 
2979:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
2980:             RETURN .F.
2981:         ENDIF
2982: 
2983:         TRY
2984:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2985:             loc_lResultado = .T.
2986:         CATCH TO loException
2987:             MostrarErro("Erro em FormSigPrCtr.AlternarPagina:" + CHR(13) + ;
2988:                 loException.Message, "Erro")
2989:         ENDTRY
2990: 
2991:         RETURN loc_lResultado
2992:     ENDPROC
2993: 
2994:     *--------------------------------------------------------------------------
2995:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2996:     * REGRA: Deve iterar Pages E Controls para PageFrames (FORMCOR_LICOES Problema 6)
2997:     *--------------------------------------------------------------------------
2998:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2999:         LOCAL loc_nI, loc_oObjeto, loc_nP
3000: 
3001:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3002:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3003: 
3004:             IF VARTYPE(loc_oObjeto) = "O"
3005:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3006:                     loc_oObjeto.Visible = .T.
3007:                 ENDIF
3008: 
3009:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3010:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3011:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3012:                     ENDFOR
3013:                 ENDIF
3014: 
3015:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3016:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3017:                 ENDIF
3018:             ENDIF
3019:         ENDFOR
3020:     ENDPROC
3021: 
3022:     *==========================================================================
3023:     * HANDLERS DOS BOTOES CRUD (PUBLIC - necessario para BINDEVENT)
3024:     * REGRA: metodos Btn*Click NAO devem ser PROTECTED (Problema 17)
3025:     *==========================================================================
3026: 
3027:     *--------------------------------------------------------------------------
3028:     * BtnIncluirClick - Prepara formulario para inclusao de nova sessao
3029:     *--------------------------------------------------------------------------
3030:     PROCEDURE BtnIncluirClick()
3031:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3032:             RETURN
3033:         ENDIF
3034: 
3035:         *-- Preparar BO para INSERT; setar modo ANTES de HabilitarCampos (Problema 19)
3036:         THIS.this_oBusinessObject.NovoRegistro()
3037:         THIS.this_cModoAtual = "INCLUIR"
3038:         THIS.LimparCampos()
3039:         THIS.HabilitarCampos(.T.)
3040:         THIS.AjustarBotoesPorModo()
3041:         THIS.AlternarPagina(2)
3042:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3043:     ENDPROC
3044: 
3045:     *--------------------------------------------------------------------------
3046:     * BtnVisualizarClick - Abre sessao selecionada em modo somente leitura
3047:     *--------------------------------------------------------------------------
3048:     PROCEDURE BtnVisualizarClick()
3049:         LOCAL loc_cCodigo
3050:         loc_cCodigo = ""
3051: 
3052:         IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3053:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3054:             RETURN
3055:         ENDIF
3056: 
3057:         SELECT cursor_4c_Dados
3058:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3059: 
3060:         IF EMPTY(loc_cCodigo)
3061:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3062:             RETURN
3063:         ENDIF
3064: 
3065:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3066:             RETURN
3067:         ENDIF
3068: 
3069:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3070:             THIS.BOParaForm()
3071:             THIS.this_cModoAtual = "VISUALIZAR"
3072:             THIS.HabilitarCampos(.F.)
3073:             THIS.AjustarBotoesPorModo()
3074:             THIS.AlternarPagina(2)
3075:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3076:         ELSE
3077:             MsgErro("Erro ao carregar registro.", "Erro")
3078:         ENDIF
3079:     ENDPROC
3080: 
3081:     *--------------------------------------------------------------------------
3082:     * BtnAlterarClick - Abre sessao selecionada para edicao
3083:     *--------------------------------------------------------------------------
3084:     PROCEDURE BtnAlterarClick()
3085:         LOCAL loc_cCodigo
3086:         loc_cCodigo = ""
3087: 
3088:         IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3089:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3090:             RETURN
3091:         ENDIF
3092: 
3093:         SELECT cursor_4c_Dados
3094:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3095: 
3096:         IF EMPTY(loc_cCodigo)
3097:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3098:             RETURN
3099:         ENDIF
3100: 
3101:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3102:             RETURN
3103:         ENDIF
3104: 
3105:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3106:             *-- EditarRegistro prepara BO para UPDATE (Problema 18)
3107:             THIS.this_oBusinessObject.EditarRegistro()
3108:             THIS.BOParaForm()
3109:             THIS.this_cModoAtual = "ALTERAR"
3110:             THIS.HabilitarCampos(.T.)
3111:             THIS.AjustarBotoesPorModo()
3112:             THIS.AlternarPagina(2)
3113:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3114:         ELSE
3115:             MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Erro")
3116:         ENDIF
3117:     ENDPROC
3118: 
3119:     *--------------------------------------------------------------------------
3120:     * BtnExcluirClick - Exclui sessao selecionada apos confirmacao
3121:     *--------------------------------------------------------------------------
3122:     PROCEDURE BtnExcluirClick()
3123:         LOCAL loc_cCodigo, loc_lConfirmado
3124:         loc_cCodigo     = ""
3125:         loc_lConfirmado = .F.
3126: 
3127:         IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3128:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3129:             RETURN
3130:         ENDIF
3131: 
3132:         SELECT cursor_4c_Dados
3133:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3134: 
3135:         IF EMPTY(loc_cCodigo)
3136:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3137:             RETURN
3138:         ENDIF
3139: 
3140:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3141:             RETURN
3142:         ENDIF
3143: 
3144:         *-- MsgConfirma retorna LOGICAL (.T./.F.) - nunca comparar com = 6 (Problema 50)
3145:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro" + ;
3146:             CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + " ?", ;
3147:             "Confirmar Exclus" + CHR(227) + "o")
3148: 
3149:         IF loc_lConfirmado
3150:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3151:                 *-- Form chama Excluir() PUBLIC; BO sobrescreve ExecutarExclusao() (Problema 57)
3152:                 IF THIS.this_oBusinessObject.Excluir()
3153:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
3154:                     THIS.CarregarLista()
3155:                 ELSE
3156:                     MsgErro("Erro ao excluir registro!", "Erro")
3157:                 ENDIF
3158:             ELSE
3159:                 MsgErro("Erro ao carregar registro para exclus" + CHR(227) + "o!", "Erro")
3160:             ENDIF
3161:         ENDIF
3162:     ENDPROC
3163: 
3164:     *--------------------------------------------------------------------------
3165:     * BtnBuscarClick - Aplica filtros de periodo e recarrega a lista
3166:     *--------------------------------------------------------------------------
3167:     PROCEDURE BtnBuscarClick()
3168:         LOCAL loc_oPg1, loc_dIni, loc_dFim
3169:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3170:         loc_dIni = DATE()
3171:         loc_dFim = DATE()
3172: 
3173:         IF TYPE("loc_oPg1.txt_4c_DtInicio") = "O"
3174:             loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
3175:         ENDIF
3176: 
3177:         IF TYPE("loc_oPg1.txt_4c_DtFim") = "O"
3178:             loc_dFim = loc_oPg1.txt_4c_DtFim.Value
3179:         ENDIF
3180: 
3181:         *-- Validar periodo antes de buscar
3182:         IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
3183:             IF loc_dIni > loc_dFim
3184:                 MsgAviso("Data inicial n" + CHR(227) + "o pode ser maior que a data final!", ;
3185:                     "Per" + CHR(237) + "odo inv" + CHR(225) + "lido")
3186:                 RETURN
3187:             ENDIF
3188:         ENDIF
3189: 
3190:         THIS.this_dDtInicio = loc_dIni
3191:         THIS.this_dDtFim    = loc_dFim
3192:         THIS.CarregarLista()
3193:     ENDPROC
3194: 
3195:     *--------------------------------------------------------------------------
3196:     * BtnEncerrarClick - Fecha o formulario
3197:     *--------------------------------------------------------------------------
3198:     PROCEDURE BtnEncerrarClick()
3199:         THIS.Release()
3200:     ENDPROC
3201: 
3202:     *--------------------------------------------------------------------------
3203:     * BtnSalvarClick - Salva sessao XML: padrao multi-row (DELETE + loop INSERT)
3204:     * SigPrCtr armazena multiplas linhas por sessao (uma por produto)
3205:     * Delega para GravarSessaoXml que faz ExcluirLinhasSessao + BO.Inserir por linha
3206:     *--------------------------------------------------------------------------
3207:     PROCEDURE BtnSalvarClick()
3208:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3209:             RETURN
3210:         ENDIF
3211: 
3212:         THIS.GravarSessaoXml()
3213:     ENDPROC
3214: 
3215:     *--------------------------------------------------------------------------
3216:     * BtnCancelarClick - Cancela edicao e retorna para lista
3217:     *--------------------------------------------------------------------------
3218:     PROCEDURE BtnCancelarClick()
3219:         THIS.this_cModoAtual = "LISTA"
3220:         THIS.AjustarBotoesPorModo()
3221:         THIS.AlternarPagina(1)
3222:         THIS.CarregarLista()
3223:     ENDPROC
3224: 
3225:     *--------------------------------------------------------------------------
3226:     * DtInicioLostFocus - Sincroniza data inicio; ajusta DtFim se necessario
3227:     * Original: Dt_inicial.Valid -> ajusta Dt_final se necessario
3228:     *--------------------------------------------------------------------------
3229:     PROCEDURE DtInicioLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3230:         LOCAL loc_oPg1, loc_dIni, loc_dFim
3231:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3232:         loc_dIni = DATE()
3233:         loc_dFim = DATE()
3234: 
3235:         IF TYPE("loc_oPg1.txt_4c_DtInicio") != "O" OR TYPE("loc_oPg1.txt_4c_DtFim") != "O"
3236:             RETURN
3237:         ENDIF
3238: 
3239:         loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
3240:         loc_dFim = loc_oPg1.txt_4c_DtFim.Value
3241: 
3242:         *-- Se data inicial > data final, ajusta data final (replica legado: Dt_inicial.Valid)
3243:         IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
3244:             IF loc_dIni > loc_dFim
3245:                 loc_oPg1.txt_4c_DtFim.Value = loc_dIni
3246:                 THIS.this_dDtFim = loc_dIni
3247:             ENDIF
3248:         ENDIF
3249: 
3250:         THIS.this_dDtInicio = loc_dIni
3251:     ENDPROC
3252: 
3253:     *--------------------------------------------------------------------------
3254:     * DtFimLostFocus - Sincroniza data fim e recarrega lista
3255:     * Original: Dt_final.LostFocus -> Requery TmpSigPrCtr + Grade.SetFocus
3256:     *--------------------------------------------------------------------------
3257:     PROCEDURE DtFimLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3258:         LOCAL loc_oPg1, loc_dIni, loc_dFim
3259:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3260:         loc_dIni = DATE()
3261:         loc_dFim = DATE()
3262: 
3263:         IF TYPE("loc_oPg1.txt_4c_DtInicio") != "O" OR TYPE("loc_oPg1.txt_4c_DtFim") != "O"
3264:             RETURN
3265:         ENDIF
3266: 
3267:         loc_dIni = loc_oPg1.txt_4c_DtInicio.Value
3268:         loc_dFim = loc_oPg1.txt_4c_DtFim.Value
3269: 
3270:         *-- Se data final < data inicial, ajusta data inicial (replica legado: Dt_final.Valid)
3271:         IF VARTYPE(loc_dIni) = "D" AND VARTYPE(loc_dFim) = "D"
3272:             IF loc_dFim < loc_dIni
3273:                 loc_oPg1.txt_4c_DtInicio.Value = loc_dFim
3274:                 THIS.this_dDtInicio = loc_dFim
3275:             ENDIF
3276:         ENDIF
3277: 
3278:         THIS.this_dDtFim = loc_dFim
3279: 
3280:         *-- Recarregar lista (replica legado: Requery + Grade.SetFocus)
3281:         THIS.CarregarLista()
3282: 
3283:         IF TYPE("loc_oPg1.grd_4c_Lista") = "O"
3284:             loc_oPg1.grd_4c_Lista.SetFocus()
3285:         ENDIF
3286:     ENDPROC
3287: 
3288:     *--------------------------------------------------------------------------
3289:     * GridListaAfterRowColChange - Habilita/desabilita botoes conforme selecao
3290:     * par_nColIndex obrigatorio para AfterRowColChange (Problema 38)
3291:     *--------------------------------------------------------------------------
3292:     PROCEDURE GridListaAfterRowColChange(par_nColIndex)
3293:         LOCAL loc_oPg1, loc_lTemRegistro
3294:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
3295:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3296: 
3297:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar") = "O"
3298:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3299:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3300:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3301:         ENDIF
3302:     ENDPROC
3303: 
3304:     *--------------------------------------------------------------------------
3305:     * HabilitarCampos - Habilita ou desabilita campos de Page2 por modo
3306:     * par_lHabilitar: .T. = editar; .F. = somente leitura
3307:     *--------------------------------------------------------------------------
3308:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3309:         LOCAL loc_oPg2, loc_oPage
3310:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3311:         loc_oPage = loc_oPg2.pgf_4c_Abas.Page1
3312: 
3313:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3314:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3315:         ENDIF
3316: 
3317:         *-- Campos de pgf_4c_Abas.Page1 (Fases 5-6)
3318:         *-- Nota: cmd_4c_Consulta/Cadastros/Processar (icon-only) NAO desabilitar (icone some)
3319:         IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
3320:             loc_oPage.txt_4c_Grupo.Enabled        = par_lHabilitar
3321:             loc_oPage.txt_4c_Conta.Enabled        = par_lHabilitar
3322:             loc_oPage.txt_4c_Cpf.Enabled          = par_lHabilitar
3323:             loc_oPage.txt_4c_Moeda.Enabled        = par_lHabilitar
3324:             loc_oPage.opt_4c_Custo.Enabled        = par_lHabilitar
3325:         ENDIF
3326:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
3327:             loc_oPage.opt_4c_Fil.Enabled          = par_lHabilitar
3328:             loc_oPage.cmd_4c_BrowseArquivo.Enabled = par_lHabilitar
3329:         ENDIF
3330: 
3331:         *-- Habilitar botoes de excluir em Page2 (Itens)
3332:         LOCAL loc_oPage2
3333:         loc_oPage2 = loc_oPg2.pgf_4c_Abas.Page2
3334:         IF TYPE("loc_oPage2.cmd_4c_BtnExcluirSis") = "O"
3335:         ENDIF
3336:     ENDPROC
3337: 
3338:     *--------------------------------------------------------------------------
3339:     * FormParaBO - Transfere dados dos campos de Page2 para o Business Object
3340:     * Retorna .T. se BO disponivel para receber dados (campos adicionados Fases 5-6)
3341:     *--------------------------------------------------------------------------
3342:     PROTECTED PROCEDURE FormParaBO()
3343:         LOCAL loc_oPage, loc_lResultado
3344:         loc_oPage     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
3345:         loc_lResultado = .F.
3346: 
3347:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3348:             RETURN .F.
3349:         ENDIF
3350: 
3351:         TRY
3352:             IF TYPE("loc_oPage.txt_4c_Conta") = "O"
3353:                 THIS.this_oBusinessObject.this_cContas = ;
3354:                     ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
3355:             ENDIF
3356: 
3357:             IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
3358:                 THIS.this_oBusinessObject.this_cMoedas = ;
3359:                     ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
3360:             ENDIF
3361: 
3362:             IF TYPE("loc_oPage.opt_4c_Custo") = "O"
3363:                 THIS.this_oBusinessObject.this_nPrecific = loc_oPage.opt_4c_Custo.Value
3364:             ENDIF
3365: 
3366:             loc_lResultado = .T.
3367:         CATCH TO loException
3368:             MsgErro(loException.Message, "Erro em FormParaBO")
3369:         ENDTRY
3370: 
3371:         RETURN loc_lResultado
3372:     ENDPROC
3373: 
3374:     *--------------------------------------------------------------------------
3375:     * BOParaForm - Carrega dados do BO nos campos de Page2
3376:     * Sincroniza tambem os filtros de periodo da Page1
3377:     *--------------------------------------------------------------------------
3378:     PROTECTED PROCEDURE BOParaForm()
3379:         LOCAL loc_oPg1, loc_oPage, loc_cConta, loc_nRet
3380:         loc_oPg1   = THIS.pgf_4c_Paginas.Page1
3381:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
3382:         loc_cConta = ""
3383:         loc_nRet   = 0
3384: 
3385:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3386:             RETURN
3387:         ENDIF
3388: 
3389:         *-- Sincronizar datas do BO com os campos de filtro da lista
3390:         IF VARTYPE(THIS.this_oBusinessObject.this_dFiltroInicio) = "D"
3391:             THIS.this_dDtInicio = THIS.this_oBusinessObject.this_dFiltroInicio
3392:             IF TYPE("loc_oPg1.txt_4c_DtInicio") = "O"
3393:                 loc_oPg1.txt_4c_DtInicio.Value = THIS.this_dDtInicio
3394:             ENDIF
3395:         ENDIF
3396: 
3397:         IF VARTYPE(THIS.this_oBusinessObject.this_dFiltroFim) = "D"
3398:             THIS.this_dDtFim = THIS.this_oBusinessObject.this_dFiltroFim
3399:             IF TYPE("loc_oPg1.txt_4c_DtFim") = "O"
3400:                 loc_oPg1.txt_4c_DtFim.Value = THIS.this_dDtFim
3401:             ENDIF
3402:         ENDIF
3403: 
3404:         *-- Fase 5: preencher campos de pgf_4c_Abas.Page1 a partir do BO
3405:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
3406:             loc_cConta = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cContas, ""))
3407:             loc_oPage.txt_4c_Conta.Value = loc_cConta
3408:         ENDIF
3409: 
3410:         IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
3411:             loc_oPage.txt_4c_Moeda.Value = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cMoedas, ""))
3412:         ENDIF
3413: 
3414:         IF TYPE("loc_oPage.opt_4c_Custo") = "O"
3415:             loc_oPage.opt_4c_Custo.Value = IIF(THIS.this_oBusinessObject.this_nPrecific > 0, ;
3416:                 THIS.this_oBusinessObject.this_nPrecific, 1)
3417:         ENDIF
3418: 
3419:         *-- Buscar Dconta (Rclis) e Cpf (Cpfs) de SigCdCli para campos display-only
3420:         IF !EMPTY(loc_cConta)
3421:             TRY
3422:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3423:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
3424:                     "cursor_4c_BoParaForm")
3425: 
3426:                 IF loc_nRet > 0 AND USED("cursor_4c_BoParaForm") AND !EOF("cursor_4c_BoParaForm")
3427:                     IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
3428:                         loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Rclis, ""))
3429:                     ENDIF
3430:                     IF TYPE("loc_oPage.txt_4c_Cpf") = "O"

*-- Linhas 3448 a 3517:
3448:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
3449:     * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
3450:     *--------------------------------------------------------------------------
3451:     PROCEDURE AjustarBotoesPorModo()
3452:         LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro, loc_lEditar
3453:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
3454:         loc_oPg2         = THIS.pgf_4c_Paginas.Page2
3455:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3456:         loc_lEditar      = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3457: 
3458:         *-- Botoes CRUD na Page1
3459:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir") = "O"
3460:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
3461:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3462:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3463:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3464:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
3465:         ENDIF
3466: 
3467:         *-- Botoes de acao na Page2 (Confirmar so habilitado ao editar)
3468:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3469:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
3470:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
3471:         ENDIF
3472:     ENDPROC
3473: 
3474:     *--------------------------------------------------------------------------
3475:     * Destroy - Limpeza de recursos ao fechar o formulario
3476:     *--------------------------------------------------------------------------
3477:     PROCEDURE Destroy()
3478:         TRY
3479:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3480:                 THIS.this_oBusinessObject = .NULL.
3481:             ENDIF
3482: 
3483:             IF USED("cursor_4c_Dados")
3484:                 USE IN cursor_4c_Dados
3485:             ENDIF
3486:             IF USED("cursor_4c_Linhas")
3487:                 USE IN cursor_4c_Linhas
3488:             ENDIF
3489:             IF USED("cursor_4c_Carrega")
3490:                 USE IN cursor_4c_Carrega
3491:             ENDIF
3492:             IF USED("cursor_4c_NovoCod")
3493:                 USE IN cursor_4c_NovoCod
3494:             ENDIF
3495:             IF USED("cursor_4c_BoParaForm")
3496:                 USE IN cursor_4c_BoParaForm
3497:             ENDIF
3498: 
3499:             *-- Cursores de processamento XML (legado: crDistribui, crMovimentos)
3500:             IF USED("crDistribui")
3501:                 USE IN crDistribui
3502:             ENDIF
3503:             IF USED("crMovimentos")
3504:                 USE IN crMovimentos
3505:             ENDIF
3506:             IF USED("crItens")
3507:                 USE IN crItens
3508:             ENDIF
3509:             IF USED("csPrNAOCad")
3510:                 USE IN csPrNAOCad
3511:             ENDIF
3512:         CATCH TO loException
3513:             MsgErro(loException.Message, "Erro em FormSigPrCtr.Destroy")
3514:         ENDTRY
3515: 
3516:         DODEFAULT()
3517:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object: Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Chave: Codigos (identificador de sessao de processamento)
*
* Cada sessao (Codigos) agrupa multiplas linhas em SigPrCtr,
* uma por produto processado no XML. O padrao de gravacao e:
*   DELETE todas as linhas do Codigos + INSERT novas linhas.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Identificacao da sessao de processamento (grupo de linhas)
    this_cCodigos   = ""    && C(10) - Chave da sessao (PK do grupo)

    *-- Chave individual de cada linha
    this_cPkChave   = ""    && C(15) - Chave unica por linha (fUniqueIds)

    *-- Produto
    this_cCpros     = ""    && C(15) - Codigo do produto
    this_cCodCors   = ""    && C(6)  - Codigo da cor
    this_cCodTams   = ""    && C(6)  - Codigo do tamanho

    *-- Movimento de origem
    this_cOriDopNums = ""   && C(30) - Numero(s) de DOP de origem
    this_cFkChaves   = ""   && C(15) - FK para SigMvItn.cidchaves

    *-- Quantidades
    this_nQtds   = 0        && N(12,2) - Quantidade total do XML
    this_nQtdOs  = 0        && N(12,2) - Quantidade disponivel/OS

    *-- Identificacao do fornecedor/conta
    this_cContas = ""       && C(10) - Codigo da conta (fornecedor)

    *-- Arquivo XML processado
    this_cArquivo = ""      && C(255) - Caminho do arquivo XML

    *-- Moeda e precificacao
    this_cMoedas  = ""      && C(10) - Codigo da moeda
    this_nPrecific = 0      && N(2,0) - Opcao de precificacao (1=Custo Total, 2=Composicao)

    *-- Auditoria de insercao
    this_dDatas  = {/ /}    && T - Data/hora de processamento (INSERT)
    this_cUsuars = ""       && C(6)  - Usuario que processou (INSERT)

    *-- Auditoria de alteracao
    this_dDtAlts  = {/ /}   && T - Data/hora da alteracao
    this_cUsuAlts = ""       && C(6)  - Usuario que alterou

    *-- Filtros de periodo para Buscar()
    this_dFiltroInicio = {}  && Data inicial do filtro
    this_dFiltroFim    = {}  && Data final do filtro

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCtr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista sessoes agrupadas por periodo
    * par_cFiltro: filtro adicional de data (formato "ldDatai" e "ldDataf")
    * Retorna cursor_4c_Dados: Codigos, Datas, OriDopNums, Usuars, Contas, Rclis
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        LOCAL ldDatai, ldDataf
        loc_lSucesso = .F.

        TRY
            ldDatai = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroInicio), THIS.this_dFiltroInicio, DATE()))
            ldDataf = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroFim), THIS.this_dFiltroFim, DATE()))

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                       " WHERE a.Datas >= " + ldDatai + ;
                       " AND a.Datas < DATEADD(day, 1, " + ldDataf + ")"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " ORDER BY MAX(a.Datas) DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar sessoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhasSessao - Carrega todas as linhas de uma sessao (para grid Page1)
    * Retorna cursor_4c_Linhas: todas as colunas de SigPrCtr para o Codigos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY a.Cpros"

            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Linhas")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.BuscarLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega a primeira linha de uma sessao pelo Codigos
    * Usado para validacao e para preencher campos de cabecalho da sessao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cFkChaves   = TratarNulo(fkChaves,   "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuAlts    = TratarNulo(UsuAlts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere UMA linha na tabela SigPrCtr (chamada em loop pela form)
    * PROTECTED - chamado por BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = PADR(ALLTRIM(SYS(2015)), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCtr" + ;
                       " (Codigos, PkChave, Cpros, CodCors, CodTams," + ;
                       "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                       "  Moedas, Precific, fkChaves, Datas, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPkChave)) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       EscaparSQL(THIS.this_cContas) + ", " + ;
                       EscaparSQL(THIS.this_cArquivo) + ", " + ;
                       EscaparSQL(THIS.this_cMoedas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecific) + ", " + ;
                       EscaparSQL(THIS.this_cFkChaves) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza campos de auditoria de uma linha existente
    * PROTECTED - Para o padrao de edicao: DELETE + re-INSERT via GravarSessao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCtr SET" + ;
                       " Qtds = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " QtdOs = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Arquivo = " + EscaparSQL(THIS.this_cArquivo) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Precific = " + FormatarNumeroSQL(THIS.this_nPrecific) + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE PkChave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove TODAS as linhas da sessao (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhasSessao - Remove TODAS as linhas de uma sessao (PUBLIC)
    * Usado pela form no inicio do ciclo de gravacao (ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigos))
                MsgErro("Codigos nao informado para exclusao de linhas.", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExcluirLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovoCodigos - Gera um novo identificador numerico de sessao
    * Retorna string C(10) com numero sequencial unico para SigPrCtr
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovoCodigos()
        LOCAL loc_cCodigos, loc_cSQL, loc_nResult, loc_nMaxCod
        loc_cCodigos = ""
        loc_nMaxCod  = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS BIGINT)), 0) + 1" + ;
                       " AS NovoCodigos FROM SigPrCtr"

            IF USED("cursor_4c_NovoCod")
                USE IN cursor_4c_NovoCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovoCod")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_NovoCod") > 0
                SELECT cursor_4c_NovoCod
                loc_nMaxCod = cursor_4c_NovoCod.NovoCodigos
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.GerarNovoCodigos")
        ENDTRY

        IF USED("cursor_4c_NovoCod")
            USE IN cursor_4c_NovoCod
        ENDIF

        IF loc_nMaxCod > 0
            loc_cCodigos = ALLTRIM(STR(loc_nMaxCod, 10))
        ENDIF

        RETURN loc_cCodigos
    ENDPROC

ENDDEFINE

