# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (24)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO, CNT_4C_COMPRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarRelatorio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_dVenc define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_dVenc.RecordSource).
- [GRID-HEADER] Header Caption 'Lista de Preços' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cond. Pagamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vencimento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Atualizada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lista de Preços' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cond. Pagamento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vencimento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Atualizada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Cód. Produto, Descrição do Produto, Ref.Fornecedor, EAN, Custo Atual, Moe, Custo Novo, Pr. Venda, Comiss., Venc. Inicial, Venc. Final, C, Pr. De. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'ImpLista' (parent: SIGCDLPR.PAGINA.Lista): Top original=244 vs migrado 'cnt_4c_ImpLista' Top=9 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ImpLista' (parent: SIGCDLPR.PAGINA.Lista): Left original=211 vs migrado 'cnt_4c_ImpLista' Left=25 (diff=186px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Comissao' (parent: SIGCDLPR.PAGINA.Dados): Top original=63 vs migrado 'opt_4c_Opt_Comissao' Top=3 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Comissao' (parent: SIGCDLPR.PAGINA.Dados): Left original=288 vs migrado 'opt_4c_Opt_Comissao' Left=0 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_ApliTabD' (parent: SIGCDLPR.PAGINA.Dados): Top original=91 vs migrado 'opt_4c_Opt_ApliTabD' Top=3 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_ApliTabD' (parent: SIGCDLPR.PAGINA.Dados): Left original=621 vs migrado 'opt_4c_Opt_ApliTabD' Left=0 (diff=621px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Vencimento' (parent: SIGCDLPR.PAGINA.Dados): Top original=63 vs migrado 'opt_4c_Opt_Vencimento' Top=3 (diff=60px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Vencimento' (parent: SIGCDLPR.PAGINA.Dados): Left original=621 vs migrado 'opt_4c_Opt_Vencimento' Left=0 (diff=621px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Formula' (parent: SIGCDLPR.PAGINA.Dados): Top original=38 vs migrado 'opt_4c_Opt_Formula' Top=3 (diff=35px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Formula' (parent: SIGCDLPR.PAGINA.Dados): Left original=621 vs migrado 'opt_4c_Opt_Formula' Left=0 (diff=621px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDLPR.PAGINA.Dados): Top original=66 vs migrado 'lbl_4c_Say12' Top=97 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDLPR.PAGINA.Dados): Left original=559 vs migrado 'lbl_4c_Say12' Left=37 (diff=522px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDLPR.PAGINA.Dados.cntVencimentos): Top original=15 vs migrado 'lbl_4c_Say12' Top=97 (diff=82px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3490 linhas total):

*-- Linhas 4 a 207:
4: * Tabelas: SigCdLpc (cabecalho), SigCdLpi (itens da lista)
5: * Herda de: FormBase
6: *
7: * Uso: CREATEOBJECT("FormLpr")             && modo venda (padrao)
8: *      CREATEOBJECT("FormLpr", .T.)        && modo compra
9: *      CREATEOBJECT("FormLpr", .F., nome)  && venda com nome customizado
10: *==============================================================================
11: 
12: DEFINE CLASS FormLpr AS FormBase
13: 
14:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
15:     Height          = 600
16:     Width           = 1000
17:     Caption         = "Listas de Precificacao"
18:     AutoCenter      = .T.
19:     ShowWindow      = 1
20:     WindowType      = 1
21:     ControlBox      = .F.
22:     TitleBar        = 0
23:     Themes          = .F.
24:     BorderStyle     = 2
25:     FontName        = "Tahoma"
26:     FontSize        = 8
27: 
28:     *-- Propriedades de navegacao
29:     this_oBusinessObject    = .NULL.
30:     this_cModoAtual         = "LISTA"
31: 
32:     *-- Propriedades especificas do SigCdLpr (mapeadas do ThisForm original)
33:     this_cCompVenda         = " "    && "C"=compra, " "=venda
34:     this_cPcEscolha         = ""     && INSERIR/ALTERAR/PROCURAR/EXCLUIR
35:     this_lBusca             = .F.    && flag modo busca ativo
36:     this_cAntCPro           = ""     && anti-bounce: ultimo cpros validado na grade
37:     this_cAntDPro           = ""     && anti-bounce: ultimo dpros validado na grade
38:     this_cAntLPreco         = ""     && anti-bounce: ultimo lpreco validado
39:     this_nOldCasas          = 0      && backup de SET DECIMALS antes do form
40:     this_lPlCancelar        = .F.    && flag: usuario cancelou operacao
41:     this_lUpdateok          = .T.    && flag: ultima operacao Update foi bem-sucedida
42:     this_cNomeFrm           = ""     && identidade do form para DO FORM ... WITH
43:     this_cLprecosAtual      = ""     && lpreco selecionado na lista (para detalhe)
44: 
45:     *==========================================================================
46:     * Init - Inicializa o formulario
47:     * par_lCompra: .T. = modo compra, .F. ou omitido = modo venda
48:     * par_cNomeFrm: nome alternativo do form (usado em DO FORM ... WITH ThisForm)
49:     *==========================================================================
50:     PROCEDURE Init(par_lCompra, par_cNomeFrm)
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             *-- Definir modo compra vs venda ANTES do DODEFAULT()
56:             IF VARTYPE(par_lCompra) = "L" AND par_lCompra
57:                 THIS.this_cCompVenda = "C"
58:             ELSE
59:                 THIS.this_cCompVenda = " "
60:             ENDIF
61: 
62:             *-- Registrar nome customizado (para formularios abertos com DO FORM ... WITH)
63:             IF VARTYPE(par_cNomeFrm) = "C" AND !EMPTY(par_cNomeFrm)
64:                 THIS.this_cNomeFrm = par_cNomeFrm
65:             ELSE
66:                 THIS.this_cNomeFrm = "FormLpr"
67:             ENDIF
68: 
69:             *-- FormBase.Init() chama InicializarForm() internamente
70:             loc_lResultado = DODEFAULT()
71: 
72:         CATCH TO loException
73:             MsgErro("Erro: " + loException.Message + CHR(13) + ;
74:                     "Linha: " + TRANSFORM(loException.LineNo), "FormLpr.Init")
75:         ENDTRY
76: 
77:         RETURN loc_lResultado
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
82:     *==========================================================================
83:     PROTECTED PROCEDURE InicializarForm()
84:         LOCAL loc_lSucesso
85:         loc_lSucesso = .F.
86: 
87:         TRY
88:             *-- Caption com acentos (regra CLAUDE.md #4 - usar CHR())
89:             IF THIS.this_cCompVenda = "C"
90:                 THIS.Caption = "Listas de Compra"
91:             ELSE
92:                 THIS.Caption = "Listas de Precifica" + CHR(231) + CHR(227) + "o"
93:             ENDIF
94: 
95:             *-- Salvar decimais originais (restaurados no Destroy)
96:             THIS.this_nOldCasas = SET("Decimals")
97: 
98:             *-- Criar Business Object
99:             THIS.this_oBusinessObject = CREATEOBJECT("LprBO")
100: 
101:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
102: 
103:                 THIS.ConfigurarPageFrame()
104: 
105:                 *-- Propagar caption para labels do cabecalho
106:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 THIS.ConfigurarPaginaLista()
110:                 THIS.ConfigurarPaginaDados()
111: 
112:                 *-- Carregar dados apenas se nao estiver validando UI (sem conexao SQL)
113:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
114:                     THIS.CarregarLista()
115:                 ENDIF
116: 
117:                 THIS.pgf_4c_Paginas.Visible    = .T.
118:                 THIS.pgf_4c_Paginas.ActivePage = 1
119:                 THIS.this_cModoAtual           = "LISTA"
120:                 THIS.this_cPcEscolha           = ""
121: 
122:                 loc_lSucesso = .T.
123: 
124:             ELSE
125:                 MsgErro("Erro ao criar LprBO" + CHR(13) + ;
126:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
127:                         "Inicializa" + CHR(231) + CHR(227) + "o")
128:             ENDIF
129: 
130:         CATCH TO loException
131:             MsgErro("Erro: " + loException.Message + CHR(13) + ;
132:                     "Linha: " + TRANSFORM(loException.LineNo), "FormLpr.InicializarForm")
133:         ENDTRY
134: 
135:         RETURN loc_lSucesso
136:     ENDPROC
137: 
138:     *==========================================================================
139:     * ConfigurarPageFrame - Cria PageFrame com Page1=Lista e Page2=Dados
140:     *==========================================================================
141:     PROTECTED PROCEDURE ConfigurarPageFrame()
142:         TRY
143:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
144:             WITH THIS.pgf_4c_Paginas
145:                 .PageCount     = 2
146:                 .Top           = -29
147:                 .Left          = 0
148:                 .Width         = THIS.Width
149:                 .Height        = THIS.Height + 29
150:                 .Tabs          = .F.
151:                 .Visible       = .T.
152:                 .Page1.Caption = "Lista"
153:                 .Page2.Caption = "Dados"
154:                 .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
155:                 .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
156:             ENDWITH
157:         CATCH TO loException
158:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPageFrame")
159:         ENDTRY
160:     ENDPROC
161: 
162:     *==========================================================================
163:     * ConfigurarPaginaLista - Page1: Grid + botoes CRUD completo
164:     * Cabecalho, 5 botoes CRUD, Encerrar, filtros, Atualizar, Imprimir,
165:     * painel ImpLista (oculto) e grd_4c_Lista
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarPaginaLista()
168:         LOCAL loc_oPagina, loc_oCnt, loc_oGrid
169:         TRY
170:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
171:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
172: 
173:             *----------------------------------------------------------------------
174:             * Cabecalho cinza superior (cntSombra do legado)
175:             * Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
176:             *----------------------------------------------------------------------
177:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
178:             WITH loc_oPagina.cnt_4c_Cabecalho
179:                 .Top         = 31
180:                 .Left        = 0
181:                 .Width       = THIS.Width
182:                 .Height      = 80
183:                 .BackColor   = RGB(100, 100, 100)
184:                 .BorderWidth = 0
185:                 .Visible     = .T.
186: 
187:                 .AddObject("lbl_4c_Sombra", "Label")
188:                 WITH .lbl_4c_Sombra
189:                     .Caption   = THIS.Caption
190:                     .Top       = 15
191:                     .Left      = 12
192:                     .Width     = THIS.Width
193:                     .Height    = 40
194:                     .AutoSize  = .F.
195:                     .FontName  = "Tahoma"
196:                     .FontSize  = 16
197:                     .FontBold  = .T.
198:                     .ForeColor = RGB(0, 0, 0)
199:                     .BackStyle = 0
200:                     .Visible   = .T.
201:                 ENDWITH
202: 
203:                 .AddObject("lbl_4c_Titulo", "Label")
204:                 WITH .lbl_4c_Titulo
205:                     .Caption   = THIS.Caption
206:                     .Top       = 18
207:                     .Left      = 10

*-- Linhas 387 a 444:
387:             ENDWITH
388: 
389:             *----------------------------------------------------------------------
390:             * Container filtros de vencimento (cntFiltros.Optiongroup1 do legado)
391:             * Top=115 = 82 (original cntFiltros.Top) + 29 + 4 (Optiongroup1.Top)
392:             * 3 opcoes: Todos / A Vencer / Vencidos
393:             *----------------------------------------------------------------------
394:             loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
395:             WITH loc_oPagina.cnt_4c_Filtros
396:                 .Top         = 115
397:                 .Left        = 2
398:                 .Width       = 260
399:                 .Height      = 33
400:                 .BackStyle   = 0
401:                 .BorderWidth = 0
402:                 .Visible     = .T.
403: 
404:                 .AddObject("opt_4c_Vencimento", "OptionGroup")
405:                 WITH .opt_4c_Vencimento
406:                     .ButtonCount = 3
407:                     .Top         = 4
408:                     .Left        = 6
409:                     .Width       = 238
410:                     .Height      = 25
411:                     .BackStyle   = 0
412:                     .Value       = 1
413:                     .Visible     = .T.
414:                     WITH .Buttons(1)
415:                         .Caption   = "Todos"
416:                         .Left      = 0
417:                         .Top       = 3
418:                         .Width     = 50
419:                         .AutoSize  = .T.
420:                         .ForeColor = RGB(90, 90, 90)
421:                     ENDWITH
422:                     WITH .Buttons(2)
423:                         .Caption   = "A Vencer"
424:                         .Left      = 60
425:                         .Top       = 3
426:                         .Width     = 72
427:                         .AutoSize  = .T.
428:                         .FontName  = "Tahoma"
429:                         .FontSize  = 8
430:                         .ForeColor = RGB(90, 90, 90)
431:                         .Themes    = .F.
432:                     ENDWITH
433:                     WITH .Buttons(3)
434:                         .Caption   = "Vencidos"
435:                         .Left      = 140
436:                         .Top       = 3
437:                         .Width     = 72
438:                         .AutoSize  = .T.
439:                         .FontName  = "Tahoma"
440:                         .FontSize  = 8
441:                         .ForeColor = RGB(90, 90, 90)
442:                         .Themes    = .F.
443:                     ENDWITH
444:                 ENDWITH

*-- Linhas 501 a 584:
501:             *----------------------------------------------------------------------
502:             * Container painel impressao (ImpLista do legado) - inicial oculto
503:             * Top=273 = 244 (original) + 29. Aparece sobre o grid ao clicar Imprimir.
504:             * TornarControlesVisiveis pula este container mas processa seus filhos.
505:             *----------------------------------------------------------------------
506:             loc_oPagina.AddObject("cnt_4c_ImpLista", "Container")
507:             WITH loc_oPagina.cnt_4c_ImpLista
508:                 .Top         = 273
509:                 .Left        = 211
510:                 .Width       = 577
511:                 .Height      = 129
512:                 .BackStyle   = 1
513:                 .BackColor   = RGB(240, 240, 240)
514:                 .BorderWidth = 1
515:                 .Visible     = .F.
516: 
517:                 .AddObject("lbl_4c_TituloImp", "Label")
518:                 WITH .lbl_4c_TituloImp
519:                     .Caption   = "Impress" + CHR(227) + "o de Listas"
520:                     .Top       = 9
521:                     .Left      = 25
522:                     .Width     = 203
523:                     .Height    = 26
524:                     .FontName  = "Tahoma"
525:                     .FontSize  = 10
526:                     .FontBold  = .T.
527:                     .BackStyle = 0
528:                     .Visible   = .T.
529:                 ENDWITH
530: 
531:                 .AddObject("lbl_4c_TipoImpLabel", "Label")
532:                 WITH .lbl_4c_TipoImpLabel
533:                     .Caption   = "Tipo :"
534:                     .Top       = 45
535:                     .Left      = 30
536:                     .Width     = 29
537:                     .Height    = 15
538:                     .FontName  = "Tahoma"
539:                     .FontSize  = 8
540:                     .BackStyle = 0
541:                     .Visible   = .T.
542:                 ENDWITH
543: 
544:                 .AddObject("opt_4c_TipoImp", "OptionGroup")
545:                 WITH .opt_4c_TipoImp
546:                     .ButtonCount = 4
547:                     .Top         = 41
548:                     .Left        = 57
549:                     .Width       = 214
550:                     .Height      = 51
551:                     .BackStyle   = 0
552:                     .Value       = 1
553:                     .Visible     = .T.
554:                     WITH .Buttons(1)
555:                         .Caption  = "Vendas"
556:                         .Left     = 0
557:                         .Top      = 3
558:                         .AutoSize = .T.
559:                         .Themes   = .F.
560:                     ENDWITH
561:                     WITH .Buttons(2)
562:                         .Caption  = "Compras"
563:                         .Left     = 70
564:                         .Top      = 3
565:                         .AutoSize = .T.
566:                         .FontName = "Tahoma"
567:                         .FontSize = 8
568:                         .Themes   = .F.
569:                     ENDWITH
570:                     WITH .Buttons(3)
571:                         .Caption  = "An" + CHR(225) + "lise"
572:                         .Left     = 0
573:                         .Top      = 28
574:                         .AutoSize = .T.
575:                         .FontName = "Tahoma"
576:                         .FontSize = 8
577:                         .Themes   = .F.
578:                     ENDWITH
579:                     WITH .Buttons(4)
580:                         .Caption  = "Embalagem"
581:                         .Left     = 70
582:                         .Top      = 28
583:                         .AutoSize = .T.
584:                         .FontName = "Tahoma"

*-- Linhas 600 a 643:
600:                     .Visible   = .T.
601:                 ENDWITH
602: 
603:                 .AddObject("opt_4c_FotoImp", "OptionGroup")
604:                 WITH .opt_4c_FotoImp
605:                     .ButtonCount = 2
606:                     .Top         = 84
607:                     .Left        = 57
608:                     .Width       = 97
609:                     .Height      = 25
610:                     .BackStyle   = 0
611:                     .Value       = 2
612:                     .Visible     = .T.
613:                     WITH .Buttons(1)
614:                         .Caption  = "Com"
615:                         .Left     = 0
616:                         .Top      = 3
617:                         .AutoSize = .T.
618:                         .Themes   = .F.
619:                     ENDWITH
620:                     WITH .Buttons(2)
621:                         .Caption  = "Sem"
622:                         .Left     = 45
623:                         .Top      = 3
624:                         .AutoSize = .T.
625:                         .FontName = "Tahoma"
626:                         .FontSize = 8
627:                         .Themes   = .F.
628:                     ENDWITH
629:                 ENDWITH
630: 
631:                 *-- Botao Excel
632:                 .AddObject("cmd_4c_ImpExcel", "CommandButton")
633:                 WITH .cmd_4c_ImpExcel
634:                     .Caption         = "\<Excel"
635:                     .Picture         = gc_4c_CaminhoIcones + "geral_excel_32.jpg"
636:                     .PicturePosition = 13
637:                     .Top             = 5
638:                     .Left            = 422
639:                     .Width           = 75
640:                     .Height          = 75
641:                     .FontName        = "Tahoma"
642:                     .FontSize        = 8
643:                     .FontBold        = .T.

*-- Linhas 769 a 840:
769:             ENDWITH
770: 
771:             *----------------------------------------------------------------------
772:             * BINDEVENTs dos botoes (todos os handlers devem ser PUBLIC)
773:             *----------------------------------------------------------------------
774:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
775:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
776:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
777:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
778:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
779:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
780:             BINDEVENT(loc_oPagina.cmd_4c_Atualizar,                "Click", THIS, "BtnAtualizarClick")
781:             BINDEVENT(loc_oPagina.cmd_4c_ImprimirLista,            "Click", THIS, "BtnImprimirListaClick")
782:             BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Vencimento, "InteractiveChange", THIS, "FiltroVencimentoChanged")
783:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpVideo,      "Click", THIS, "BtnImpVideoClick")
784:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpImpressora, "Click", THIS, "BtnImpImpressoraClick")
785:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpExcel,      "Click", THIS, "BtnImpExcelClick")
786:             BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpFechar,     "Click", THIS, "BtnImpFecharClick")
787: 
788:             THIS.TornarControlesVisiveis(loc_oPagina)
789: 
790:         CATCH TO loException
791:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaLista")
792:         ENDTRY
793:     ENDPROC
794: 
795:     *==========================================================================
796:     * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdLpc (Fase 5)
797:     * Campos: Empresa, Codigo, Lpreco, Fpg, area de busca na grade, botoes
798:     * Fase 6 adiciona: Grade/GradeC (itens SigCdLpi) e controles ocultos
799:     *==========================================================================
800:     PROTECTED PROCEDURE ConfigurarPaginaDados()
801:         LOCAL loc_oPagina, loc_oCnt
802:         TRY
803:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
804:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
805: 
806:             *----------------------------------------------------------------------
807:             * Container botoes acao do cabecalho (Grupo_Salva do legado)
808:             * Top=33=4+29, Left=842, Width=160, Height=85
809:             *----------------------------------------------------------------------
810:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
811:             loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
812:             WITH loc_oCnt
813:                 .Top         = 33
814:                 .Left        = 842
815:                 .Width       = 160
816:                 .Height      = 85
817:                 .BackStyle   = 0
818:                 .Visible     = .T.
819: 
820:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
821:                 WITH .cmd_4c_Confirmar
822:                     .Caption         = "Confirmar"
823:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
824:                     .PicturePosition = 13
825:                     .Top             = 5
826:                     .Left            = 5
827:                     .Width           = 75
828:                     .Height          = 75
829:                     .FontName        = "Tahoma"
830:                     .FontSize        = 8
831:                     .FontBold        = .T.
832:                     .FontItalic      = .T.
833:                     .ForeColor       = RGB(90, 90, 90)
834:                     .BackColor       = RGB(255, 255, 255)
835:                     .Themes          = .F.
836:                     .SpecialEffect   = 0
837:                     .MousePointer    = 15
838:                     .WordWrap        = .T.
839:                     .AutoSize        = .F.
840:                     .Visible         = .T.

*-- Linhas 1074 a 1126:
1074:             ENDWITH
1075: 
1076:             *----------------------------------------------------------------------
1077:             * BINDEVENTs dos controles da Page2 (Fase 5)
1078:             *----------------------------------------------------------------------
1079:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
1080:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
1081:             BINDEVENT(loc_oPagina.txt_4c_Emps,    "KeyPress",                     THIS, "ValidarEmpresa")
1082:             BINDEVENT(loc_oPagina.txt_4c_Lpreco,  "KeyPress",                     THIS, "ValidarLpreco")
1083:             BINDEVENT(loc_oPagina.txt_4c_Fpg,     "KeyPress",                     THIS, "ValidarFpg")
1084:             BINDEVENT(loc_oPagina.txt_4c_Txtcpros, "KeyPress",                    THIS, "ValidarCpros")
1085:             BINDEVENT(loc_oPagina.txt_4c_Txtdpros, "KeyPress",                    THIS, "ValidarDpros")
1086:             BINDEVENT(loc_oPagina.cmd_4c_Busca,   "Click",                         THIS, "BtnBuscaGradeClick")
1087: 
1088:             *----------------------------------------------------------------------
1089:             * grd_4c_GradeC - Grade modo COMPRA (7 colunas)
1090:             * top=184+29=213, left=8, width=982, height=293
1091:             * ControlSources sao vinculados em VincularGrade() quando cursor existe
1092:             *----------------------------------------------------------------------
1093:             loc_oPagina.AddObject("grd_4c_GradeC", "Grid")
1094:             WITH loc_oPagina.grd_4c_GradeC
1095:                 .Top          = 213
1096:                 .Left         = 8
1097:                 .Width        = 982
1098:                 .Height       = 293
1099:                 .ColumnCount  = 7
1100:                 .ReadOnly     = .F.
1101:                 .GridLines    = 1
1102:                 .DeleteMark   = .F.
1103:                 .RecordSource = ""
1104:                 .Visible      = .T.
1105:                 .FontName     = "Tahoma"
1106:                 .FontSize     = 8
1107:                 WITH .Column1
1108:                     .Width = 100
1109:                     .RecordMark   = .F.
1110:                 ENDWITH
1111:                 WITH .Column2
1112:                     .Width = 250
1113:                 ENDWITH
1114:                 WITH .Column3
1115:                     .Width = 130
1116:                 ENDWITH
1117:                 WITH .Column4
1118:                     .Width = 110
1119:                 ENDWITH
1120:                 WITH .Column5
1121:                     .Width = 120
1122:                 ENDWITH
1123:                 WITH .Column6
1124:                     .Width = 52
1125:                 ENDWITH
1126:                 WITH .Column7

*-- Linhas 1357 a 1507:
1357:                 ENDWITH
1358:             ENDWITH
1359: 
1360:             *----------------------------------------------------------------------
1361:             * Controles opcionais (Visible=.F.) - ativados conforme flags da lista
1362:             * opt_4c_Opt_Comissao  : top=63+29=92,  left=288 - tipo comissao
1363:             * opt_4c_Opt_ApliTabD  : top=91+29=120, left=621 - aplica tab.desconto
1364:             * opt_4c_Opt_Vencimento: top=63+29=92,  left=621 - tipo vencimento
1365:             * opt_4c_Opt_Formula   : top=38+29=67,  left=621 - tipo formula
1366:             * lbl_4c_Say9          : top=42+29=71,  left=540 - "Aplica Formulas"
1367:             * txt_4c_Tabd          : top=91+29=120, left=108 - tabela desconto
1368:             * txt_4c_Juros         : top=91+29=120, left=294 - % juros a.m.
1369:             * cmd_4c_SelecionaC    : top=2+29=31,   left=773 - sel.produtos compra
1370:             *----------------------------------------------------------------------
1371:             loc_oPagina.AddObject("opt_4c_Opt_Comissao", "OptionGroup")
1372:             WITH loc_oPagina.opt_4c_Opt_Comissao
1373:                 .ButtonCount = 2
1374:                 .Top         = 92
1375:                 .Left        = 288
1376:                 .Width       = 94
1377:                 .Height      = 22
1378:                 .Value       = 1
1379:                 .BackStyle   = 0
1380:                 .Visible     = .F.
1381:                 WITH .Buttons(1)
1382:                     .Caption   = "Sim"
1383:                     .Left      = 0
1384:                     .Top       = 3
1385:                     .Width     = 40
1386:                     .AutoSize  = .T.
1387:                     .ForeColor = RGB(90, 90, 90)
1388:                     .Themes    = .F.
1389:                 ENDWITH
1390:                 WITH .Buttons(2)
1391:                     .Caption   = "N" + CHR(227) + "o"
1392:                     .Left      = 44
1393:                     .Top       = 3
1394:                     .Width     = 50
1395:                     .AutoSize  = .T.
1396:                     .ForeColor = RGB(90, 90, 90)
1397:                     .FontName  = "Tahoma"
1398:                     .FontSize  = 8
1399:                     .Themes    = .F.
1400:                 ENDWITH
1401:             ENDWITH
1402: 
1403:             loc_oPagina.AddObject("opt_4c_Opt_ApliTabD", "OptionGroup")
1404:             WITH loc_oPagina.opt_4c_Opt_ApliTabD
1405:                 .ButtonCount = 2
1406:                 .Top         = 120
1407:                 .Left        = 621
1408:                 .Width       = 94
1409:                 .Height      = 22
1410:                 .Value       = 1
1411:                 .BackStyle   = 0
1412:                 .Visible     = .F.
1413:                 WITH .Buttons(1)
1414:                     .Caption   = "Sim"
1415:                     .Left      = 0
1416:                     .Top       = 3
1417:                     .Width     = 40
1418:                     .AutoSize  = .T.
1419:                     .ForeColor = RGB(90, 90, 90)
1420:                     .Themes    = .F.
1421:                 ENDWITH
1422:                 WITH .Buttons(2)
1423:                     .Caption   = "N" + CHR(227) + "o"
1424:                     .Left      = 44
1425:                     .Top       = 3
1426:                     .Width     = 50
1427:                     .AutoSize  = .T.
1428:                     .ForeColor = RGB(90, 90, 90)
1429:                     .FontName  = "Tahoma"
1430:                     .FontSize  = 8
1431:                     .Themes    = .F.
1432:                 ENDWITH
1433:             ENDWITH
1434: 
1435:             loc_oPagina.AddObject("opt_4c_Opt_Vencimento", "OptionGroup")
1436:             WITH loc_oPagina.opt_4c_Opt_Vencimento
1437:                 .ButtonCount = 2
1438:                 .Top         = 92
1439:                 .Left        = 621
1440:                 .Width       = 94
1441:                 .Height      = 22
1442:                 .Value       = 1
1443:                 .BackStyle   = 0
1444:                 .Visible     = .F.
1445:                 WITH .Buttons(1)
1446:                     .Caption   = "Sim"
1447:                     .Left      = 0
1448:                     .Top       = 3
1449:                     .Width     = 40
1450:                     .AutoSize  = .T.
1451:                     .ForeColor = RGB(90, 90, 90)
1452:                     .Themes    = .F.
1453:                 ENDWITH
1454:                 WITH .Buttons(2)
1455:                     .Caption   = "N" + CHR(227) + "o"
1456:                     .Left      = 44
1457:                     .Top       = 3
1458:                     .Width     = 50
1459:                     .AutoSize  = .T.
1460:                     .ForeColor = RGB(90, 90, 90)
1461:                     .FontName  = "Tahoma"
1462:                     .FontSize  = 8
1463:                     .Themes    = .F.
1464:                 ENDWITH
1465:             ENDWITH
1466: 
1467:             loc_oPagina.AddObject("opt_4c_Opt_Formula", "OptionGroup")
1468:             WITH loc_oPagina.opt_4c_Opt_Formula
1469:                 .ButtonCount = 2
1470:                 .Top         = 67
1471:                 .Left        = 621
1472:                 .Width       = 94
1473:                 .Height      = 22
1474:                 .Value       = 1
1475:                 .BackStyle   = 0
1476:                 .Visible     = .F.
1477:                 WITH .Buttons(1)
1478:                     .Caption   = "Sim"
1479:                     .Left      = 0
1480:                     .Top       = 3
1481:                     .Width     = 40
1482:                     .AutoSize  = .T.
1483:                     .ForeColor = RGB(90, 90, 90)
1484:                     .Themes    = .F.
1485:                 ENDWITH
1486:                 WITH .Buttons(2)
1487:                     .Caption   = "N" + CHR(227) + "o"
1488:                     .Left      = 44
1489:                     .Top       = 3
1490:                     .Width     = 50
1491:                     .AutoSize  = .T.
1492:                     .ForeColor = RGB(90, 90, 90)
1493:                     .FontName  = "Tahoma"
1494:                     .FontSize  = 8
1495:                     .Themes    = .F.
1496:                 ENDWITH
1497:             ENDWITH
1498: 
1499:             loc_oPagina.AddObject("lbl_4c_Say9", "Label")
1500:             WITH loc_oPagina.lbl_4c_Say9
1501:                 .Caption   = "Aplica F" + CHR(243) + "rmulas :"
1502:                 .Top       = 71
1503:                 .Left      = 540
1504:                 .Width     = 80
1505:                 .Height    = 15
1506:                 .FontName  = "Tahoma"
1507:                 .FontSize  = 8

*-- Linhas 1659 a 2234:
1659:             ENDWITH
1660: 
1661:             *----------------------------------------------------------------------
1662:             * BINDEVENTs para controles adicionados na Fase 6
1663:             *----------------------------------------------------------------------
1664:             BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
1665:             BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
1666:             BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
1667:             BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
1668:             BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
1669:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
1670:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
1671:             BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
1672:             BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
1673:             BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1674:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress", THIS, "ValidarTabd")
1675:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
1676:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress", THIS, "ValidarGetConta")
1677:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress",  THIS, "TeclaGetConta")
1678:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress", THIS, "ValidarGetDconta")
1679:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress",  THIS, "TeclaGetDconta")
1680: 
1681:             THIS.TornarControlesVisiveis(loc_oPagina)
1682: 
1683:             *-- Ocultar controles opcionais apos TornarControlesVisiveis
1684:             loc_oPagina.opt_4c_Opt_Comissao.Visible   = .F.
1685:             loc_oPagina.opt_4c_Opt_ApliTabD.Visible   = .F.
1686:             loc_oPagina.opt_4c_Opt_Vencimento.Visible = .F.
1687:             loc_oPagina.opt_4c_Opt_Formula.Visible    = .F.
1688:             loc_oPagina.lbl_4c_Say9.Visible           = .F.
1689:             loc_oPagina.txt_4c_Tabd.Visible           = .F.
1690:             loc_oPagina.txt_4c_Juros.Visible          = .F.
1691:             loc_oPagina.cmd_4c_SelecionaC.Visible     = .F.
1692: 
1693:         CATCH TO loException
1694:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaDados")
1695:         ENDTRY
1696:     ENDPROC
1697: 
1698:     *==========================================================================
1699:     * BtnSalvarClick - Salva o cabecalho da lista de precos (SigCdLpc)
1700:     * Chamado pelo cmd_4c_Confirmar da Page2
1701:     *==========================================================================
1702:     PROCEDURE BtnSalvarClick()
1703:         LOCAL loc_lSucesso
1704:         loc_lSucesso = .F.
1705: 
1706:         *-- Validacoes obrigatorias ANTES do TRY (RETURN fora do TRY)
1707:         LOCAL loc_oPg2
1708:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1709: 
1710:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value))
1711:             MsgAviso("C" + CHR(243) + "digo da Lista de Pre" + CHR(231) + ;
1712:                 CHR(227) + "o obrigat" + CHR(243) + "rio!", "Aviso")
1713:             loc_oPg2.txt_4c_Lpreco.SetFocus()
1714:             RETURN
1715:         ENDIF
1716: 
1717:         TRY
1718:             THIS.FormParaBO()
1719:             IF THIS.this_oBusinessObject.Salvar()
1720:                 LOCAL loc_cLprecoSalvo
1721:                 loc_cLprecoSalvo = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1722:                 IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
1723:                     IF THIS.this_oBusinessObject.SalvarItens(loc_cLprecoSalvo)
1724:                         MsgInfo("Lista salva com sucesso!", "")
1725:                         THIS.AlternarPagina(1)
1726:                     ELSE
1727:                         MsgErro("Cabe" + CHR(231) + "alho salvo mas houve erro ao salvar itens.", "Aviso")
1728:                     ENDIF
1729:                 ELSE
1730:                     MsgInfo("Lista salva com sucesso!", "")
1731:                     THIS.AlternarPagina(1)
1732:                 ENDIF
1733:             ENDIF
1734:         CATCH TO loException
1735:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormLpr.BtnSalvarClick")
1736:         ENDTRY
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * BtnCancelarClick - Cancela edicao e volta para a lista (Page1)
1741:     *==========================================================================
1742:     PROCEDURE BtnCancelarClick()
1743:         TRY
1744:             THIS.this_cPcEscolha    = ""
1745:             THIS.this_cLprecosAtual = ""
1746:             THIS.AlternarPagina(1)
1747:         CATCH TO loException
1748:             MsgErro("Erro ao cancelar:" + CHR(13) + loException.Message, "FormLpr.BtnCancelarClick")
1749:         ENDTRY
1750:     ENDPROC
1751: 
1752:     *==========================================================================
1753:     * ValidarEmpresa - LostFocus do txt_4c_Emps
1754:     * Valida empresa digitada; se vazio pre-preenche com empresa logada
1755:     *==========================================================================
1756:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1757:         LOCAL loc_oPg2, loc_cEmps, loc_nResult
1758:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1759: 
1760:         TRY
1761:             loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1762: 
1763:             IF EMPTY(loc_cEmps)
1764:                 loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1765:             ELSE
1766:                 *-- Verificar se empresa existe em SigCdEmp
1767:                 LOCAL loc_cSQL
1768:                 loc_cSQL = "SELECT TOP 1 CEmps FROM SigCdEmp WHERE CEmps = " + ;
1769:                            EscaparSQL(loc_cEmps)
1770:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmps")
1771:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldEmps") = 0
1772:                     MsgErro("Empresa [" + loc_cEmps + "] n" + CHR(227) + "o encontrada!", "Aviso")
1773:                     loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1774:                 ENDIF
1775:                 IF USED("cursor_4c_VldEmps")
1776:                     USE IN cursor_4c_VldEmps
1777:                 ENDIF
1778:             ENDIF
1779: 
1780:         CATCH TO loException
1781:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarEmpresa")
1782:         ENDTRY
1783:     ENDPROC
1784: 
1785:     *==========================================================================
1786:     * ValidarLpreco - LostFocus do txt_4c_Lpreco
1787:     * Para INSERIR: verifica duplicata. Para PROCURAR: carrega registro.
1788:     *==========================================================================
1789:     PROCEDURE ValidarLpreco(par_nKeyCode, par_nShiftAltCtrl)
1790:         LOCAL loc_oPg2, loc_cLpreco, loc_nResult
1791:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1792:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1793: 
1794:         IF EMPTY(loc_cLpreco) OR loc_cLpreco == THIS.this_cAntLPreco
1795:             RETURN
1796:         ENDIF
1797: 
1798:         THIS.this_cAntLPreco = loc_cLpreco
1799: 
1800:         TRY
1801:             IF THIS.this_cPcEscolha = "INSERIR"
1802:                 *-- Verificar duplicata
1803:                 LOCAL loc_cSQL2
1804:                 loc_cSQL2 = "SELECT TOP 1 lprecos FROM SigCdLpc WHERE lprecos = " + ;
1805:                             EscaparSQL(loc_cLpreco)
1806:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_VldLpr")
1807:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLpr") > 0
1808:                     MsgErro("Lista de Pre" + CHR(231) + "o [" + loc_cLpreco + ;
1809:                         "] j" + CHR(225) + " cadastrada!", "Aviso")
1810:                     loc_oPg2.txt_4c_Lpreco.Value = THIS.this_cAntLPreco
1811:                 ENDIF
1812:                 IF USED("cursor_4c_VldLpr")
1813:                     USE IN cursor_4c_VldLpr
1814:                 ENDIF
1815:             ELSE
1816:                 IF THIS.this_cPcEscolha = "PROCURAR"
1817:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLpreco)
1818:                     THIS.BOParaForm()
1819:                 ELSE
1820:                     MsgAviso("Lista [" + loc_cLpreco + "] n" + CHR(227) + ;
1821:                         "o encontrada!", "Aviso")
1822:                     loc_oPg2.txt_4c_Lpreco.Value = ""
1823:                     THIS.this_cAntLPreco = ""
1824:                 ENDIF
1825:                 ENDIF
1826:             ENDIF
1827: 
1828:         CATCH TO loException
1829:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarLpreco")
1830:         ENDTRY
1831:     ENDPROC
1832: 
1833:     *==========================================================================
1834:     * ValidarFpg - LostFocus do txt_4c_Fpg (Cond. Pagamento)
1835:     * Lookup em SigOpFp por fpags (campo fpags)
1836:     *==========================================================================
1837:     PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
1838:         LOCAL loc_oPg2, loc_cFpg
1839:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1840:         loc_cFpg = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
1841: 
1842:         IF EMPTY(loc_cFpg)
1843:             RETURN
1844:         ENDIF
1845: 
1846:         TRY
1847:             LOCAL loc_oBusca, loc_cSQL3
1848:             *-- Verificar se fpag existe
1849:             loc_cSQL3 = "SELECT TOP 1 fpags FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cFpg)
1850:             LOCAL loc_nRes
1851:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_BuscaFpg")
1852:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BuscaFpg") = 0
1853:                 *-- Nao encontrou exato - abrir lookup
1854:                 IF USED("cursor_4c_BuscaFpg")
1855:                     USE IN cursor_4c_BuscaFpg
1856:                 ENDIF
1857:                 THIS.AbrirBuscaFpg(loc_cFpg)
1858:             ELSE
1859:                 IF USED("cursor_4c_BuscaFpg")
1860:                     USE IN cursor_4c_BuscaFpg
1861:                 ENDIF
1862:             ENDIF
1863: 
1864:         CATCH TO loException
1865:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarFpg")
1866:         ENDTRY
1867:     ENDPROC
1868: 
1869:     *==========================================================================
1870:     * AbrirBuscaFpg - Abre FormBuscaAuxiliar para selecionar Cond. Pagamento
1871:     *==========================================================================
1872:     PROCEDURE AbrirBuscaFpg(par_cFpgAtual)
1873:         LOCAL loc_oPg2, loc_oBusca
1874:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1875: 
1876:         TRY
1877:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1878:                 "SigOpFp", "cursor_4c_BuscaFpg", "fpags", ;
1879:                 ALLTRIM(par_cFpgAtual), "Condi" + CHR(231) + CHR(245) + "es de Pagamento")
1880: 
1881:             IF VARTYPE(loc_oBusca) = "O"
1882:                 IF !loc_oBusca.this_lAchouRegistro
1883:                     loc_oBusca.mAddColuna("fpags",  "XXXXXXXXXXXX", "C" + CHR(243) + "digo")
1884:                     loc_oBusca.mAddColuna("fparcs", "",             "Parcelas")
1885:                     loc_oBusca.Show()
1886:                 ENDIF
1887: 
1888:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
1889:                     SELECT cursor_4c_BuscaFpg
1890:                     loc_oPg2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
1891:                 ELSE
1892:                     IF !loc_oBusca.this_lAchouRegistro
1893:                         loc_oPg2.txt_4c_Fpg.Value = ""
1894:                     ENDIF
1895:                 ENDIF
1896:                 loc_oBusca.Release()
1897:             ENDIF
1898: 
1899:             IF USED("cursor_4c_BuscaFpg")
1900:                 USE IN cursor_4c_BuscaFpg
1901:             ENDIF
1902: 
1903:         CATCH TO loException
1904:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaFpg")
1905:         ENDTRY
1906:     ENDPROC
1907: 
1908:     *==========================================================================
1909:     * ValidarCpros - LostFocus do txt_4c_Txtcpros (busca na grade por codigo)
1910:     * Lookup em SigCdPro por cpros; preenche txt_4c_Txtdpros automaticamente
1911:     *==========================================================================
1912:     PROCEDURE ValidarCpros(par_nKeyCode, par_nShiftAltCtrl)
1913:         LOCAL loc_oPg2, loc_cCpros, loc_oBusca
1914:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1915:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
1916: 
1917:         IF EMPTY(loc_cCpros) OR loc_cCpros == THIS.this_cAntCPro
1918:             RETURN
1919:         ENDIF
1920: 
1921:         THIS.this_cAntCPro = loc_cCpros
1922: 
1923:         TRY
1924:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1925:                 "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cCpros, "Produtos", 1000)
1926: 
1927:             IF VARTYPE(loc_oBusca) = "O"
1928:                 IF !loc_oBusca.this_lAchouRegistro
1929:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1930:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1931:                     loc_oBusca.Show()
1932:                 ENDIF
1933: 
1934:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1935:                     SELECT cursor_4c_BuscaProd
1936:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1937:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1938:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1939:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1940:                 ELSE
1941:                     IF !loc_oBusca.this_lAchouRegistro
1942:                         loc_oPg2.txt_4c_Txtcpros.Value = ""
1943:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1944:                         THIS.this_cAntCPro = ""
1945:                         THIS.this_cAntDPro = ""
1946:                     ENDIF
1947:                 ENDIF
1948:                 loc_oBusca.Release()
1949:             ENDIF
1950: 
1951:             IF USED("cursor_4c_BuscaProd")
1952:                 USE IN cursor_4c_BuscaProd
1953:             ENDIF
1954: 
1955:         CATCH TO loException
1956:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarCpros")
1957:         ENDTRY
1958:     ENDPROC
1959: 
1960:     *==========================================================================
1961:     * ValidarDpros - LostFocus do txt_4c_Txtdpros (busca na grade por descricao)
1962:     * Ativo apenas quando txt_4c_Txtcpros estiver vazio
1963:     *==========================================================================
1964:     PROCEDURE ValidarDpros(par_nKeyCode, par_nShiftAltCtrl)
1965:         LOCAL loc_oPg2, loc_cDpros, loc_oBusca
1966:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1967:         loc_cDpros = ALLTRIM(loc_oPg2.txt_4c_Txtdpros.Value)
1968: 
1969:         IF !EMPTY(loc_oPg2.txt_4c_Txtcpros.Value)
1970:             RETURN
1971:         ENDIF
1972: 
1973:         IF EMPTY(loc_cDpros) OR loc_cDpros == THIS.this_cAntDPro
1974:             RETURN
1975:         ENDIF
1976: 
1977:         THIS.this_cAntDPro = loc_cDpros
1978: 
1979:         TRY
1980:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1981:                 "SigCdPro", "cursor_4c_BuscaProd", "dpros", loc_cDpros, "Produtos", 1000)
1982: 
1983:             IF VARTYPE(loc_oBusca) = "O"
1984:                 IF !loc_oBusca.this_lAchouRegistro
1985:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1986:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1987:                     loc_oBusca.Show()
1988:                 ENDIF
1989: 
1990:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1991:                     SELECT cursor_4c_BuscaProd
1992:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1993:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1994:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1995:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1996:                 ELSE
1997:                     IF !loc_oBusca.this_lAchouRegistro
1998:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1999:                         THIS.this_cAntDPro = ""
2000:                     ENDIF
2001:                 ENDIF
2002:                 loc_oBusca.Release()
2003:             ENDIF
2004: 
2005:             IF USED("cursor_4c_BuscaProd")
2006:                 USE IN cursor_4c_BuscaProd
2007:             ENDIF
2008: 
2009:         CATCH TO loException
2010:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarDpros")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * BtnBuscaGradeClick - Click do botao Busca na area de pesquisa da grade
2016:     * Busca no cursor de itens (cursor_4c_Itens) pelo cpros digitado e
2017:     * posiciona o foco na grade (grade sera vinculada na Fase 6)
2018:     *==========================================================================
2019:     PROCEDURE BtnBuscaGradeClick()
2020:         LOCAL loc_oPg2, loc_cCpros
2021:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2022:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
2023: 
2024:         TRY
2025:             IF USED("cursor_4c_Itens")
2026:                 SELECT cursor_4c_Itens
2027:                 SET NEAR ON
2028:                 IF !EMPTY(loc_cCpros)
2029:                     SEEK PADR(loc_cCpros, 14) ORDER "cpros"
2030:                 ENDIF
2031:                 SET NEAR OFF
2032: 
2033:                 *-- Tentar focar na grade de itens (adicionada na Fase 6)
2034:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2035:                     loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2036:                 ELSE
2037:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2038:                     loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2039:                     ENDIF
2040:                 ENDIF
2041:             ENDIF
2042: 
2043:             loc_oPg2.txt_4c_Txtcpros.Refresh()
2044:             loc_oPg2.txt_4c_Txtdpros.Refresh()
2045: 
2046:         CATCH TO loException
2047:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnBuscaGradeClick")
2048:         ENDTRY
2049:     ENDPROC
2050: 
2051:     *==========================================================================
2052:     * FormParaBO - Transfere valores do formulario para o Business Object
2053:     * Fase 5: campos do cabecalho SigCdLpc
2054:     *==========================================================================
2055:     PROTECTED PROCEDURE FormParaBO()
2056:         LOCAL loc_oPg2
2057:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2058: 
2059:         TRY
2060:             WITH THIS.this_oBusinessObject
2061:                 .this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
2062:                 .this_cLprecos = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2063:                 .this_cFpags   = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
2064:                 .this_cTipos   = THIS.this_cCompVenda
2065:                 .this_cTabds   = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
2066:             ENDWITH
2067:         CATCH TO loException
2068:             MsgErro("Erro: " + loException.Message, "FormLpr.FormParaBO")
2069:         ENDTRY
2070:     ENDPROC
2071: 
2072:     *==========================================================================
2073:     * BOParaForm - Transfere valores do Business Object para o formulario
2074:     * Fase 5: campos do cabecalho SigCdLpc
2075:     *==========================================================================
2076:     PROTECTED PROCEDURE BOParaForm()
2077:         LOCAL loc_oPg2
2078:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2079: 
2080:         TRY
2081:             WITH THIS.this_oBusinessObject
2082:                 loc_oPg2.txt_4c_Emps.Value   = ALLTRIM(.this_cEmps)
2083:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(.this_cCodigos)
2084:                 loc_oPg2.txt_4c_Lpreco.Value = ALLTRIM(.this_cLprecos)
2085:                 loc_oPg2.txt_4c_Fpg.Value    = ALLTRIM(.this_cFpags)
2086:                 loc_oPg2.txt_4c_Tabd.Value   = ALLTRIM(.this_cTabds)
2087:             ENDWITH
2088: 
2089:             *-- Anti-bounce: atualizar rastreadores
2090:             THIS.this_cAntLPreco = ALLTRIM(THIS.this_oBusinessObject.this_cLprecos)
2091:             THIS.this_cAntCPro   = ""
2092:             THIS.this_cAntDPro   = ""
2093:             loc_oPg2.txt_4c_Txtcpros.Value = ""
2094:             loc_oPg2.txt_4c_Txtdpros.Value = ""
2095: 
2096:         CATCH TO loException
2097:             MsgErro("Erro: " + loException.Message, "FormLpr.BOParaForm")
2098:         ENDTRY
2099:     ENDPROC
2100: 
2101:     *==========================================================================
2102:     * LimparCampos - Limpa todos os campos editaveis da Page2
2103:     *==========================================================================
2104:     PROTECTED PROCEDURE LimparCampos()
2105:         LOCAL loc_oPg2
2106:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2107: 
2108:         TRY
2109:             loc_oPg2.txt_4c_Emps.Value     = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2110:             loc_oPg2.txt_4c_Codigo.Value   = ""
2111:             loc_oPg2.txt_4c_Lpreco.Value   = ""
2112:             loc_oPg2.txt_4c_Fpg.Value      = ""
2113:             loc_oPg2.txt_4c_Tabd.Value     = ""
2114:             loc_oPg2.txt_4c_Txtcpros.Value = ""
2115:             loc_oPg2.txt_4c_Txtdpros.Value = ""
2116:             THIS.this_cAntLPreco = ""
2117:             THIS.this_cAntCPro   = ""
2118:             THIS.this_cAntDPro   = ""
2119:         CATCH TO loException
2120:             MsgErro("Erro: " + loException.Message, "FormLpr.LimparCampos")
2121:         ENDTRY
2122:     ENDPROC
2123: 
2124:     *==========================================================================
2125:     * HabilitarCampos - Habilita ou desabilita campos conforme modo e flags
2126:     * par_lHabilitar: .T. = habilitar campos editaveis, .F. = somente leitura
2127:     *==========================================================================
2128:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2129:         LOCAL loc_oPg2, loc_lFlags
2130:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2131:         loc_lFlags = .F.
2132: 
2133:         TRY
2134:             *-- Verificar se a lista ja foi publicada (flags=1)
2135:             IF THIS.this_cPcEscolha = "ALTERAR" AND ;
2136:                USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2137:                 SELECT cursor_4c_Dados
2138:                 loc_lFlags = (TratarNulo(cursor_4c_Dados.flags, "N") = 1)
2139:             ENDIF
2140: 
2141:             *-- Emps: editavel apenas em INSERIR e quando nao flags
2142:             loc_oPg2.txt_4c_Emps.ReadOnly   = !(par_lHabilitar AND !loc_lFlags)
2143:             *-- Lpreco: editavel apenas em INSERIR (nao pode mudar PK em ALTERAR)
2144:             loc_oPg2.txt_4c_Lpreco.ReadOnly = !(par_lHabilitar AND THIS.this_cPcEscolha = "INSERIR")
2145:             *-- Fpg: editavel em INSERIR e ALTERAR (quando nao flags)
2146:             loc_oPg2.txt_4c_Fpg.ReadOnly    = !(par_lHabilitar AND !loc_lFlags)
2147:             *-- Campos de busca na grade: sempre editaveis quando ha lista selecionada
2148:             loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
2149:             loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
2150:             *-- Botoes acao
2151:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2152:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2153: 
2154:         CATCH TO loException
2155:             MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
2156:         ENDTRY
2157:     ENDPROC
2158: 
2159:     *==========================================================================
2160:     * CarregarItens - Carrega SigCdLpi no cursor_4c_Itens e vincula grids
2161:     * par_cLprecos: codigo da lista; vazio = nova lista (cursor nao carregado)
2162:     *==========================================================================
2163:     PROTECTED PROCEDURE CarregarItens(par_cLprecos)
2164:         LOCAL loc_lSucesso
2165:         loc_lSucesso = .F.
2166: 
2167:         TRY
2168:             IF USED("cursor_4c_Itens")
2169:                 USE IN cursor_4c_Itens
2170:             ENDIF
2171: 
2172:             IF !EMPTY(ALLTRIM(par_cLprecos))
2173:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarItens(par_cLprecos, THIS.this_cCompVenda)
2174:             ENDIF
2175: 
2176:             IF loc_lSucesso AND USED("cursor_4c_Itens")
2177:                 *-- Criar indice para SEEK em BtnBuscaGradeClick
2178:                 SELECT cursor_4c_Itens
2179:                 INDEX ON PADR(cpros, 14) TAG cpros ADDITIVE
2180:                 GO TOP
2181:             ENDIF
2182: 
2183:             THIS.VincularGrade()
2184: 
2185:         CATCH TO loException
2186:             MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "FormLpr.CarregarItens")
2187:         ENDTRY
2188:     ENDPROC
2189: 
2190:     *==========================================================================
2191:     * VincularGrade - Define RecordSource, ControlSources e Headers dos grids
2192:     * Exibe grd_4c_GradeC em modo compra; grd_4c_Grade em modo venda
2193:     *==========================================================================
2194:     PROTECTED PROCEDURE VincularGrade()
2195:         LOCAL loc_oPg2, loc_lModoCompra, loc_oGrid
2196:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2197:         loc_lModoCompra = (THIS.this_cCompVenda = "C")
2198: 
2199:         TRY
2200:             IF loc_lModoCompra
2201:                 *-- Modo compra: grd_4c_GradeC visivel, grd_4c_Grade oculta
2202:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2203:                     loc_oGrid = loc_oPg2.grd_4c_GradeC
2204:                     IF USED("cursor_4c_Itens")
2205:                         loc_oGrid.ColumnCount = 7
2206:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2207:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2208:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2209:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.reffs"
2210:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.ean13"
2211:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.pcuss"
2212:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.moevs"
2213:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.pvens"
2214:                     ELSE
2215:                         loc_oGrid.RecordSource = ""
2216:                     ENDIF
2217:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2218:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2219:                     loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
2220:                     loc_oGrid.Column4.Header1.Caption = "EAN"
2221:                     loc_oGrid.Column5.Header1.Caption = "Custo Atual"
2222:                     loc_oGrid.Column6.Header1.Caption = "Moe"
2223:                     loc_oGrid.Column7.Header1.Caption = "Custo Novo"
2224:                     loc_oGrid.FontName = "Verdana"
2225:                     loc_oGrid.FontSize = 8
2226:                     loc_oGrid.Visible = .T.
2227:                     loc_oGrid.Refresh()
2228:                 ENDIF
2229:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2230:                     loc_oPg2.grd_4c_Grade.Visible = .F.
2231:                 ENDIF
2232:             ELSE
2233:                 *-- Modo venda: grd_4c_Grade visivel, grd_4c_GradeC oculta
2234:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)

*-- Linhas 2275 a 2613:
2275:     *==========================================================================
2276:     * BtnINSEREClick - Insere linha em branco no cursor de itens da lista
2277:     *==========================================================================
2278:     PROCEDURE BtnINSEREClick()
2279:         LOCAL loc_oPg2, loc_cLpreco
2280:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2281:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2282: 
2283:         IF EMPTY(loc_cLpreco)
2284:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
2285:             RETURN
2286:         ENDIF
2287: 
2288:         TRY
2289:             IF !USED("cursor_4c_Itens")
2290:                 SET NULL ON
2291:                 CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2292:                     cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2293:                     pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2294:                     vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2295:                     ordems c(11), ccontroles c(30), precode n(16,6))
2296:                 SET NULL OFF
2297:             ENDIF
2298: 
2299:             SELECT cursor_4c_Itens
2300:             SET FILTER TO
2301:             INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, CHR(255))
2302:             SET FILTER TO !DELETED("cursor_4c_Itens")
2303: 
2304:             THIS.VincularGrade()
2305: 
2306:             SELECT cursor_4c_Itens
2307:             GO BOTTOM
2308: 
2309:             IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
2310:                     AND loc_oPg2.grd_4c_GradeC.Visible
2311:                 loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2312:             ELSE
2313:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2314:                 loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2315:                 ENDIF
2316:             ENDIF
2317: 
2318:         CATCH TO loException
2319:             MsgErro("Erro ao inserir item:" + CHR(13) + loException.Message, "FormLpr.BtnINSEREClick")
2320:         ENDTRY
2321:     ENDPROC
2322: 
2323:     *==========================================================================
2324:     * BtnDELETEClick - Marca item atual como excluido no cursor de itens
2325:     *==========================================================================
2326:     PROCEDURE BtnDELETEClick()
2327:         LOCAL loc_oPg2
2328:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2329: 
2330:         TRY
2331:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2332:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2333:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do item?", "Confirmar")
2334:                     SELECT cursor_4c_Itens
2335:                     IF !DELETED()
2336:                         DELETE
2337:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2338:                         GO TOP
2339:                     ENDIF
2340:                     IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2341:                         loc_oPg2.grd_4c_Grade.Refresh()
2342:                     ENDIF
2343:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2344:                         loc_oPg2.grd_4c_GradeC.Refresh()
2345:                     ENDIF
2346:                 ENDIF
2347:             ELSE
2348:                 MsgAviso("Nenhum item selecionado para excluir.", "Aviso")
2349:             ENDIF
2350:         CATCH TO loException
2351:             MsgErro("Erro ao excluir item:" + CHR(13) + loException.Message, "FormLpr.BtnDELETEClick")
2352:         ENDTRY
2353:     ENDPROC
2354: 
2355:     *==========================================================================
2356:     * BtnCOPIAClick - Duplica o item atual no cursor de itens
2357:     *==========================================================================
2358:     PROCEDURE BtnCOPIAClick()
2359:         LOCAL loc_oPg2, loc_cLpreco
2360:         LOCAL loc_cCpros, loc_cDpros, loc_cMoevs, loc_cCgrus, loc_cReffs
2361:         LOCAL loc_nPvens, loc_nComiss, loc_nEan13, loc_nPcuss, loc_nPrecode
2362:         LOCAL loc_dVencis, loc_dVencfs
2363:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2364:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2365: 
2366:         TRY
2367:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2368:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2369:                 SELECT cursor_4c_Itens
2370:                 loc_cCpros   = ALLTRIM(TratarNulo(cpros,   "C"))
2371:                 loc_cDpros   = ALLTRIM(TratarNulo(dpros,   "C"))
2372:                 loc_cMoevs   = ALLTRIM(TratarNulo(moevs,   "C"))
2373:                 loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,   "C"))
2374:                 loc_cReffs   = ALLTRIM(TratarNulo(reffs,   "C"))
2375:                 loc_nPvens   = TratarNulo(pvens,   "N")
2376:                 loc_nComiss  = TratarNulo(comiss,  "N")
2377:                 loc_nEan13   = TratarNulo(ean13,   "N")
2378:                 loc_nPcuss   = TratarNulo(pcuss,   "N")
2379:                 loc_nPrecode = TratarNulo(precode, "N")
2380:                 loc_dVencis  = TratarNulo(vencis,  "D")
2381:                 loc_dVencfs  = TratarNulo(vencfs,  "D")
2382: 
2383:                 SET FILTER TO
2384:                 INSERT INTO cursor_4c_Itens ;
2385:                     (lprecos, cpros, dpros, moevs, cgrus, reffs, pvens, comiss, ;
2386:                      ean13, pcuss, precode, vencis, vencfs, ordems) ;
2387:                     VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2388:                             loc_cCgrus, loc_cReffs, loc_nPvens, loc_nComiss, ;
2389:                             loc_nEan13, loc_nPcuss, loc_nPrecode, loc_dVencis, ;
2390:                             loc_dVencfs, CHR(255))
2391:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2392: 
2393:                 THIS.VincularGrade()
2394: 
2395:                 SELECT cursor_4c_Itens
2396:                 GO BOTTOM
2397:             ELSE
2398:                 MsgAviso("Nenhum item selecionado para duplicar.", "Aviso")
2399:             ENDIF
2400:         CATCH TO loException
2401:             MsgErro("Erro ao duplicar item:" + CHR(13) + loException.Message, "FormLpr.BtnCOPIAClick")
2402:         ENDTRY
2403:     ENDPROC
2404: 
2405:     *==========================================================================
2406:     * BtnSelecionaClick - Abre browser de produtos para adicionar item a lista
2407:     *==========================================================================
2408:     PROCEDURE BtnSelecionaClick()
2409:         LOCAL loc_oPg2, loc_oBusca, loc_nResult, loc_cSQL, loc_cLpreco
2410:         LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_nPcuss, loc_cMoevs
2411:         LOCAL loc_cCgrus, loc_cReffs, loc_nEan13
2412:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2413:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2414: 
2415:         IF EMPTY(loc_cLpreco)
2416:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de selecionar produtos.", "Aviso")
2417:             RETURN
2418:         ENDIF
2419: 
2420:         TRY
2421:             loc_cSQL = "SELECT TOP 500 cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2422:                        " FROM SigCdPro ORDER BY cpros"
2423:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
2424: 
2425:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
2426:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2427:                 IF VARTYPE(loc_oBusca) = "O"
2428:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
2429:                         "Selecionar Produto")
2430:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
2431:                     loc_oBusca.Mostrar()
2432: 
2433:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
2434:                         SELECT cursor_4c_BuscaProd
2435:                         loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.cpros)
2436:                         loc_cDpros  = ALLTRIM(cursor_4c_BuscaProd.dpros)
2437:                         loc_nPvens  = TratarNulo(cursor_4c_BuscaProd.pvens,  "N")
2438:                         loc_nPcuss  = TratarNulo(cursor_4c_BuscaProd.pcuss,  "N")
2439:                         loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.moevs, "C"))
2440:                         loc_cCgrus  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.cgrus, "C"))
2441:                         loc_cReffs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.reffs, "C"))
2442:                         loc_nEan13  = TratarNulo(cursor_4c_BuscaProd.ean13,  "N")
2443: 
2444:                         IF !USED("cursor_4c_Itens")
2445:                             SET NULL ON
2446:                             CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2447:                                 cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2448:                                 pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2449:                                 vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2450:                                 ordems c(11), ccontroles c(30), precode n(16,6))
2451:                             SET NULL OFF
2452:                         ENDIF
2453: 
2454:                         SELECT cursor_4c_Itens
2455:                         SET FILTER TO
2456:                         INSERT INTO cursor_4c_Itens ;
2457:                             (lprecos, cpros, dpros, moevs, cgrus, reffs, ean13, ordems, ;
2458:                              pvens, pcuss) ;
2459:                             VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2460:                                     loc_cCgrus, loc_cReffs, loc_nEan13, CHR(255), ;
2461:                                     IIF(THIS.this_cCompVenda = "C", loc_nPcuss, loc_nPvens), ;
2462:                                     loc_nPcuss)
2463:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2464:                         GO BOTTOM
2465: 
2466:                         THIS.VincularGrade()
2467:                     ENDIF
2468:                     loc_oBusca.Release()
2469:                 ENDIF
2470:             ELSE
2471:                 MsgAviso("Nenhum produto encontrado.", "Aviso")
2472:             ENDIF
2473: 
2474:             IF USED("cursor_4c_BuscaProd")
2475:                 USE IN cursor_4c_BuscaProd
2476:             ENDIF
2477: 
2478:         CATCH TO loException
2479:             MsgErro("Erro ao selecionar produto:" + CHR(13) + loException.Message, "FormLpr.BtnSelecionaClick")
2480:         ENDTRY
2481:     ENDPROC
2482: 
2483:     *==========================================================================
2484:     * BtnCmdVencimentoClick - Exibe ou oculta o painel de vencimento em massa
2485:     *==========================================================================
2486:     PROCEDURE BtnCmdVencimentoClick()
2487:         LOCAL loc_oPg2
2488:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2489: 
2490:         TRY
2491:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2492:                 loc_oPg2.cnt_4c_Vencimentos.Visible = !loc_oPg2.cnt_4c_Vencimentos.Visible
2493:                 IF loc_oPg2.cnt_4c_Vencimentos.Visible
2494:                     *-- Pre-preencher com data atual
2495:                     loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value = DATE()
2496:                     loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.SetFocus()
2497:                 ENDIF
2498:             ENDIF
2499:         CATCH TO loException
2500:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnCmdVencimentoClick")
2501:         ENDTRY
2502:     ENDPROC
2503: 
2504:     *==========================================================================
2505:     * BtnSalvaVencimentoClick - Aplica data de vencimento a todos os itens
2506:     *==========================================================================
2507:     PROCEDURE BtnSalvaVencimentoClick()
2508:         LOCAL loc_oPg2, loc_dVenc
2509:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2510: 
2511:         TRY
2512:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5) AND ;
2513:                PEMSTATUS(loc_oPg2.cnt_4c_Vencimentos, "txt_4c_GetVencs", 5)
2514:                 loc_dVenc = loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value
2515:             ELSE
2516:                 loc_dVenc = DATE()
2517:             ENDIF
2518: 
2519:             IF USED("cursor_4c_Itens") AND VARTYPE(loc_dVenc) = "D" AND !EMPTY(loc_dVenc)
2520:                 SELECT cursor_4c_Itens
2521:                 SET FILTER TO
2522:                 GO TOP
2523:                 SCAN
2524:                     IF !DELETED()
2525:                         REPLACE vencis WITH loc_dVenc
2526:                     ENDIF
2527:                 ENDSCAN
2528:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2529:                 GO TOP
2530:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2531:                     loc_oPg2.grd_4c_Grade.Refresh()
2532:                 ENDIF
2533:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2534:                     loc_oPg2.grd_4c_GradeC.Refresh()
2535:                 ENDIF
2536:             ENDIF
2537: 
2538:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2539:                 loc_oPg2.cnt_4c_Vencimentos.Visible = .F.
2540:             ENDIF
2541: 
2542:         CATCH TO loException
2543:             MsgErro("Erro ao aplicar vencimento:" + CHR(13) + loException.Message, "FormLpr.BtnSalvaVencimentoClick")
2544:         ENDTRY
2545:     ENDPROC
2546: 
2547:     *==========================================================================
2548:     * BtnFechaVencimentoClick - Oculta o painel de vencimento sem salvar
2549:     *==========================================================================
2550:     PROCEDURE BtnFechaVencimentoClick()
2551:         TRY
2552:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Vencimentos", 5)
2553:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Vencimentos.Visible = .F.
2554:             ENDIF
2555:         CATCH TO loException
2556:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnFechaVencimentoClick")
2557:         ENDTRY
2558:     ENDPROC
2559: 
2560:     *==========================================================================
2561:     * BtnSelecionaCClick - Selecionar Produtos (modo compra, Visible=.F. padrao)
2562:     * Reutiliza logica de BtnSelecionaClick adaptada para compra
2563:     *==========================================================================
2564:     PROCEDURE BtnSelecionaCClick()
2565:         THIS.BtnSelecionaClick()
2566:     ENDPROC
2567: 
2568:     *==========================================================================
2569:     * GradeAfterRowColChange - Handler AfterRowColChange dos grids Grade/GradeC
2570:     * par_nColIndex: coluna que ficou ativa ANTES do usuario sair (coluna origem)
2571:     * Quando sai da coluna 1 (cpros): busca produto e pre-preenche campos
2572:     *==========================================================================
2573:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
2574:         LOCAL loc_cCpros, loc_nResult, loc_cSQL, loc_lContinuar
2575:         loc_cCpros     = ""
2576:         loc_lContinuar = .T.
2577: 
2578:         TRY
2579:             IF par_nColIndex = 1 AND USED("cursor_4c_Itens") AND ;
2580:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2581:                 SELECT cursor_4c_Itens
2582:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, "C"))
2583: 
2584:                 IF !EMPTY(loc_cCpros)
2585:                     *-- Verificar grupo em modo venda (bloqueado para certos grupos)
2586:                     IF THIS.this_cCompVenda <> "C"
2587:                         IF !THIS.this_oBusinessObject.ChecaGrpVenda(loc_cCpros)
2588:                             SELECT cursor_4c_Itens
2589:                             REPLACE cpros WITH "", dpros WITH ""
2590:                             loc_lContinuar = .F.
2591:                         ENDIF
2592:                     ENDIF
2593: 
2594:                     IF loc_lContinuar
2595:                         *-- Buscar produto no catalogo e pre-preencher campos da linha
2596:                         loc_cSQL = "SELECT cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2597:                                    " FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
2598:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro")
2599: 
2600:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldPro") > 0
2601:                             SELECT cursor_4c_Itens
2602:                             REPLACE dpros WITH ALLTRIM(cursor_4c_VldPro.dpros)
2603:                             IF EMPTY(ALLTRIM(TratarNulo(moevs, "C")))
2604:                                 REPLACE moevs WITH ALLTRIM(cursor_4c_VldPro.moevs)
2605:                             ENDIF
2606:                             IF EMPTY(ALLTRIM(TratarNulo(cgrus, "C")))
2607:                                 REPLACE cgrus WITH ALLTRIM(cursor_4c_VldPro.cgrus)
2608:                             ENDIF
2609:                             IF THIS.this_cCompVenda = "C"
2610:                                 *-- Modo compra: custo atual + reffs + ean
2611:                                 IF TratarNulo(pcuss, "N") = 0
2612:                                     REPLACE pcuss WITH TratarNulo(cursor_4c_VldPro.pcuss, "N")
2613:                                 ENDIF

*-- Linhas 2645 a 2688:
2645:     * CarregarLista - Carrega lista de SigCdLpc no Grid da Page1
2646:     * Chama Buscar() no BO com filtro de CompVenda e opcoes de vencimento
2647:     *==========================================================================
2648:     PROCEDURE CarregarLista()
2649:         LOCAL loc_lResultado, loc_oGrid, loc_nFiltroVenc
2650:         loc_lResultado  = .F.
2651:         loc_nFiltroVenc = 1
2652: 
2653:         TRY
2654:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2655:                 loc_lResultado = .T.
2656:             ELSE
2657:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cCompVenda)
2658: 
2659:                     *-- Ler filtro de vencimento (1=Todos, 2=A Vencer, 3=Vencidos)
2660:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
2661:                         loc_nFiltroVenc = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Vencimento.Value
2662:                     ENDIF
2663: 
2664:                     IF USED("cursor_4c_Dados")
2665:                         SELECT cursor_4c_Dados
2666:                         DO CASE
2667:                             CASE loc_nFiltroVenc = 2
2668:                                 SET FILTER TO vencis >= DATE()
2669:                             CASE loc_nFiltroVenc = 3
2670:                                 SET FILTER TO !EMPTY(vencis) AND vencis < DATE()
2671:                             OTHERWISE
2672:                                 SET FILTER TO
2673:                         ENDCASE
2674:                         GO TOP
2675:                     ENDIF
2676: 
2677:                     *-- Vincular grid: RecordSource -> ControlSources -> Headers
2678:                     *   VFP9 sobrescreve ControlSources e Headers ao trocar RecordSource
2679:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2680:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2681:                         IF USED("cursor_4c_Dados")
2682:                             loc_oGrid.ColumnCount = 4
2683:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
2684:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.lprecos"
2685:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
2686:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
2687:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
2688:                             loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"

*-- Linhas 2712 a 3042:
2712:     *==========================================================================
2713:     * FormatarGridLista - Formata visual do grid da lista
2714:     *==========================================================================
2715:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2716:         WITH par_oGrid
2717:             .FontName = "Verdana"
2718:             .FontSize = 8
2719:         ENDWITH
2720:     ENDPROC
2721: 
2722:     *==========================================================================
2723:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2724:     * Containers flutuantes que devem iniciar ocultos sao pulados (mas seus
2725:     * filhos sao processados para que fiquem prontos ao serem exibidos).
2726:     *==========================================================================
2727:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2728:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
2729:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2730:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2731:             IF VARTYPE(loc_oObjeto) = "O"
2732:                 loc_cNome = UPPER(loc_oObjeto.Name)
2733: 
2734:                 *-- Containers flutuantes que iniciam ocultos no legado
2735:                 IF INLIST(loc_cNome, "CNT_4C_IMPLISTA", "CNT_4C_VENCIMENTOS", "CNT_4C_COMPRA", ;
2736:                     "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
2737:                     *-- Nao tornar visivel, mas processar filhos (ficam prontos para Show)
2738:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2739:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2740:                     ENDIF
2741:                     LOOP
2742:                 ENDIF
2743: 
2744:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2745:                     loc_oObjeto.Visible = .T.
2746:                 ENDIF
2747: 
2748:                 *-- PageFrame: iterar Pages
2749:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2750:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2751:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2752:                     ENDFOR
2753:                 ENDIF
2754: 
2755:                 *-- Containers: recursar nos filhos
2756:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2757:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2758:                 ENDIF
2759:             ENDIF
2760:         ENDFOR
2761:     ENDPROC
2762: 
2763:     *==========================================================================
2764:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe de itens)
2765:     * Ao voltar para Page1 (par_nPagina=1) recarrega a lista automaticamente
2766:     *==========================================================================
2767:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2768:         TRY
2769:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2770:             THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
2771:             IF par_nPagina = 1
2772:                 THIS.this_cPcEscolha    = ""
2773:                 THIS.this_cLprecosAtual = ""
2774:                 THIS.CarregarLista()
2775:             ELSE
2776:                 *-- Ir para Page2: preencher cabecalho e carregar itens da lista
2777:                 THIS.LimparCampos()
2778:                 IF THIS.this_cPcEscolha <> "INSERIR"
2779:                     THIS.BOParaForm()
2780:                 ELSE
2781:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ;
2782:                         ALLTRIM(go_4c_Sistema.cCodEmpresa)
2783:                 ENDIF
2784:                 THIS.CarregarItens(THIS.this_cLprecosAtual)
2785:                 THIS.HabilitarCampos(.T.)
2786:             ENDIF
2787:         CATCH TO loException
2788:             MsgErro("Erro: " + loException.Message, "FormLpr.AlternarPagina")
2789:         ENDTRY
2790:     ENDPROC
2791: 
2792:     *==========================================================================
2793:     * BtnIncluirClick - Inicia inclusao de nova lista de precos (vai para Page2)
2794:     *==========================================================================
2795:     PROCEDURE BtnIncluirClick()
2796:         TRY
2797:             THIS.this_cPcEscolha                         = "INSERIR"
2798:             THIS.this_cLprecosAtual                       = ""
2799:             THIS.this_oBusinessObject.this_lNovoRegistro  = .T.
2800:             THIS.this_oBusinessObject.this_cLprecos       = ""
2801:             THIS.AlternarPagina(2)
2802:         CATCH TO loException
2803:             MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "FormLpr.BtnIncluirClick")
2804:         ENDTRY
2805:     ENDPROC
2806: 
2807:     *==========================================================================
2808:     * BtnVisualizarClick - Visualiza lista selecionada em modo somente leitura
2809:     *==========================================================================
2810:     PROCEDURE BtnVisualizarClick()
2811:         LOCAL loc_cLprecos, loc_lOk
2812:         loc_cLprecos = ""
2813:         loc_lOk      = .F.
2814: 
2815:         TRY
2816:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2817:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2818:                 SELECT cursor_4c_Dados
2819:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2820:                 loc_lOk = .T.
2821:             ENDIF
2822: 
2823:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2824:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2825:                     THIS.this_cPcEscolha    = "PROCURAR"
2826:                     THIS.this_cLprecosAtual = loc_cLprecos
2827:                     THIS.AlternarPagina(2)
2828:                 ENDIF
2829:             ELSE
2830:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2831:             ENDIF
2832:         CATCH TO loException
2833:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "FormLpr.BtnVisualizarClick")
2834:         ENDTRY
2835:     ENDPROC
2836: 
2837:     *==========================================================================
2838:     * BtnAlterarClick - Altera lista selecionada
2839:     * Se flags=1 (ja publicada), pede confirmacao antes de prosseguir
2840:     *==========================================================================
2841:     PROCEDURE BtnAlterarClick()
2842:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
2843:         loc_cLprecos    = ""
2844:         loc_nFlags      = 0
2845:         loc_lOk         = .F.
2846:         loc_lProsseguir = .T.
2847: 
2848:         TRY
2849:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2850:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2851:                 SELECT cursor_4c_Dados
2852:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2853:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2854:                 loc_lOk = .T.
2855:             ENDIF
2856: 
2857:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2858:                 IF loc_nFlags = 1
2859:                     loc_lProsseguir = MsgConfirma("Esta lista j" + CHR(225) + ;
2860:                         " foi atualizada no sistema." + CHR(13) + ;
2861:                         "Deseja alterar mesmo assim?", "Aten" + CHR(231) + CHR(227) + "o")
2862:                 ENDIF
2863: 
2864:                 IF loc_lProsseguir
2865:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2866:                         THIS.this_cPcEscolha    = "ALTERAR"
2867:                         THIS.this_cLprecosAtual = loc_cLprecos
2868:                         THIS.AlternarPagina(2)
2869:                     ENDIF
2870:                 ENDIF
2871:             ELSE
2872:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2873:             ENDIF
2874:         CATCH TO loException
2875:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "FormLpr.BtnAlterarClick")
2876:         ENDTRY
2877:     ENDPROC
2878: 
2879:     *==========================================================================
2880:     * BtnExcluirClick - Exclui lista selecionada
2881:     * Bloqueia exclusao se lista ja foi publicada (flags=1)
2882:     *==========================================================================
2883:     PROCEDURE BtnExcluirClick()
2884:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk
2885:         loc_cLprecos = ""
2886:         loc_nFlags   = 0
2887:         loc_lOk      = .F.
2888: 
2889:         TRY
2890:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2891:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2892:                 SELECT cursor_4c_Dados
2893:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2894:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2895:                 loc_lOk = .T.
2896:             ENDIF
2897: 
2898:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2899:                 IF loc_nFlags = 1
2900:                     MsgErro("Lista j" + CHR(225) + " atualizada no sistema." + CHR(13) + ;
2901:                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
2902:                             "vel excluir!", "Aviso")
2903:                 ELSE
2904:                     IF MsgConfirma("Confirma exclus" + CHR(227) + "o da lista [" + ;
2905:                                    loc_cLprecos + "]?", "Confirmar")
2906:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2907:                             IF THIS.this_oBusinessObject.Excluir()
2908:                                 MsgInfo("Lista exclu" + CHR(237) + "da com sucesso!", "")
2909:                                 THIS.CarregarLista()
2910:                             ENDIF
2911:                         ENDIF
2912:                     ENDIF
2913:                 ENDIF
2914:             ELSE
2915:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2916:             ENDIF
2917:         CATCH TO loException
2918:             MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "FormLpr.BtnExcluirClick")
2919:         ENDTRY
2920:     ENDPROC
2921: 
2922:     *==========================================================================
2923:     * BtnBuscarClick - Recarrega a lista (equivalente a bnt_Busca do legado)
2924:     *==========================================================================
2925:     PROCEDURE BtnBuscarClick()
2926:         TRY
2927:             THIS.CarregarLista()
2928:         CATCH TO loException
2929:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormLpr.BtnBuscarClick")
2930:         ENDTRY
2931:     ENDPROC
2932: 
2933:     *==========================================================================
2934:     * BtnEncerrarClick - Fecha o formulario
2935:     *==========================================================================
2936:     PROCEDURE BtnEncerrarClick()
2937:         TRY
2938:             THIS.Release()
2939:         CATCH TO loException
2940:             MsgErro("Erro ao encerrar:" + CHR(13) + loException.Message, "FormLpr.BtnEncerrarClick")
2941:         ENDTRY
2942:     ENDPROC
2943: 
2944:     *==========================================================================
2945:     * BtnAtualizarClick - Publica a lista selecionada no sistema (flags=1)
2946:     * Avisa se lista ja foi publicada e pede confirmacao antes de repetir
2947:     *==========================================================================
2948:     PROCEDURE BtnAtualizarClick()
2949:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
2950:         loc_cLprecos    = ""
2951:         loc_nFlags      = 0
2952:         loc_lOk         = .F.
2953:         loc_lProsseguir = .T.
2954: 
2955:         TRY
2956:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2957:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2958:                 SELECT cursor_4c_Dados
2959:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2960:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2961:                 loc_lOk = .T.
2962:             ENDIF
2963: 
2964:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2965:                 IF loc_nFlags = 1
2966:                     loc_lProsseguir = MsgConfirma("Lista j" + CHR(225) + ;
2967:                         " atualizada no sistema." + CHR(13) + ;
2968:                         "Deseja atualizar novamente?", "Confirmar")
2969:                 ENDIF
2970: 
2971:                 IF loc_lProsseguir
2972:                     IF THIS.this_oBusinessObject.AtualizarFlags(loc_cLprecos)
2973:                         MsgInfo("Lista [" + loc_cLprecos + "] atualizada com sucesso!", "")
2974:                         THIS.CarregarLista()
2975:                     ENDIF
2976:                 ENDIF
2977:             ELSE
2978:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2979:             ENDIF
2980:         CATCH TO loException
2981:             MsgErro("Erro ao atualizar flags:" + CHR(13) + loException.Message, "FormLpr.BtnAtualizarClick")
2982:         ENDTRY
2983:     ENDPROC
2984: 
2985:     *==========================================================================
2986:     * BtnImprimirListaClick - Exibe ou oculta o painel de impressao (toggle)
2987:     *==========================================================================
2988:     PROCEDURE BtnImprimirListaClick()
2989:         TRY
2990:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista
2991:                 .Visible = !.Visible
2992:                 .Visible     = .T.
2993:             ENDWITH
2994:         CATCH TO loException
2995:             MsgErro("Erro ao exibir impressao:" + CHR(13) + loException.Message, "FormLpr.BtnImprimirListaClick")
2996:         ENDTRY
2997:     ENDPROC
2998: 
2999:     *==========================================================================
3000:     * FiltroVencimentoChanged - Recarrega lista ao alterar o filtro de vencimento
3001:     *==========================================================================
3002:     PROCEDURE FiltroVencimentoChanged()
3003:         TRY
3004:             THIS.CarregarLista()
3005:         CATCH TO loException
3006:             MsgErro("Erro ao filtrar:" + CHR(13) + loException.Message, "FormLpr.FiltroVencimentoChanged")
3007:         ENDTRY
3008:     ENDPROC
3009: 
3010:     *==========================================================================
3011:     * MontarRelatorio - Monta cursor_4c_Relatorio para impressao de listas
3012:     * par_nTipo: 1=Vendas, 2=Compras, 3=Analise, 4=Embalagem
3013:     * Retorna .T. se cursor montado com dados
3014:     *==========================================================================
3015:     PROTECTED FUNCTION MontarRelatorio(par_nTipo)
3016:         LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cFiltroTipo
3017:         loc_lSucesso    = .F.
3018:         loc_cFiltroTipo = ""
3019: 
3020:         TRY
3021:             IF USED("cursor_4c_Relatorio")
3022:                 USE IN cursor_4c_Relatorio
3023:             ENDIF
3024: 
3025:             DO CASE
3026:                 CASE par_nTipo = 1
3027:                     loc_cFiltroTipo = " AND b.tipos = ' '"
3028:                 CASE par_nTipo = 2
3029:                     loc_cFiltroTipo = " AND b.tipos = 'C'"
3030:                 OTHERWISE
3031:                     loc_cFiltroTipo = ""
3032:             ENDCASE
3033: 
3034:             loc_cSQL = "SELECT b.lprecos, b.fpags, b.vencis AS vencis_lista," + ;
3035:                        " b.flags, b.tipos," + ;
3036:                        " a.cpros, a.dpros, a.pvens, a.pcuss, a.moevs," + ;
3037:                        " a.comiss, a.vencis AS vencis_item, a.vencfs," + ;
3038:                        " a.cgrus, a.ean13, a.reffs, a.ordems, a.precode" + ;
3039:                        " FROM SigCdLpi a" + ;
3040:                        " INNER JOIN SigCdLpc b ON a.lprecos = b.lprecos" + ;
3041:                        " WHERE b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
3042:                        loc_cFiltroTipo + ;

*-- Linhas 3061 a 3485:
3061:     *==========================================================================
3062:     * BtnImpVideoClick - Visualiza relatorio de listas em video (PREVIEW)
3063:     *==========================================================================
3064:     PROCEDURE BtnImpVideoClick()
3065:         LOCAL loc_nTipo
3066:         loc_nTipo = 1
3067: 
3068:         TRY
3069:             loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3070:             IF THIS.MontarRelatorio(loc_nTipo)
3071:                 THIS.ExecutarReportForm("SigCdLpr", "PREVIEW", "cursor_4c_Relatorio")
3072:             ENDIF
3073:         CATCH TO loException
3074:             MsgErro("Erro ao visualizar relat" + CHR(243) + "rio:" + CHR(13) + ;
3075:                     loException.Message, "FormLpr.BtnImpVideoClick")
3076:         ENDTRY
3077:     ENDPROC
3078: 
3079:     *==========================================================================
3080:     * BtnImpImpressoraClick - Imprime relatorio de listas na impressora
3081:     *==========================================================================
3082:     PROCEDURE BtnImpImpressoraClick()
3083:         LOCAL loc_nTipo
3084:         loc_nTipo = 1
3085: 
3086:         TRY
3087:             loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3088:             IF THIS.MontarRelatorio(loc_nTipo)
3089:                 THIS.ExecutarReportForm("SigCdLpr", "PRINTER_PROMPT", "cursor_4c_Relatorio")
3090:             ENDIF
3091:         CATCH TO loException
3092:             MsgErro("Erro ao imprimir relat" + CHR(243) + "rio:" + CHR(13) + ;
3093:                     loException.Message, "FormLpr.BtnImpImpressoraClick")
3094:         ENDTRY
3095:     ENDPROC
3096: 
3097:     *==========================================================================
3098:     * BtnImpExcelClick - Exporta relatorio de listas para Excel (XLS)
3099:     *==========================================================================
3100:     PROCEDURE BtnImpExcelClick()
3101:         LOCAL loc_nTipo, loc_cArquivo
3102:         loc_nTipo    = 1
3103:         loc_cArquivo = ""
3104: 
3105:         TRY
3106:             loc_nTipo    = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3107:             loc_cArquivo = gc_4c_CaminhoReports + "SigCdLpr.xls"
3108: 
3109:             IF THIS.MontarRelatorio(loc_nTipo)
3110:                 IF USED("cursor_4c_Relatorio")
3111:                     SELECT cursor_4c_Relatorio
3112:                     COPY TO (loc_cArquivo) TYPE XL5
3113:                     MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "")
3114:                 ENDIF
3115:             ENDIF
3116:         CATCH TO loException
3117:             MsgErro("Erro ao exportar Excel:" + CHR(13) + loException.Message, "FormLpr.BtnImpExcelClick")
3118:         ENDTRY
3119:     ENDPROC
3120: 
3121:     *==========================================================================
3122:     * BtnImpFecharClick - Oculta o painel de impressao cnt_4c_ImpLista
3123:     *==========================================================================
3124:     PROCEDURE BtnImpFecharClick()
3125:         TRY
3126:             THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.Visible = .F.
3127:         CATCH TO loException
3128:             MsgErro("Erro ao fechar painel:" + CHR(13) + loException.Message, "FormLpr.BtnImpFecharClick")
3129:         ENDTRY
3130:     ENDPROC
3131: 
3132:     *==========================================================================
3133:     * ValidarTabd - LostFocus do txt_4c_Tabd (Tabela de Desconto)
3134:     * Lookup em SigOpTdz por codigos
3135:     *==========================================================================
3136:     PROCEDURE ValidarTabd(par_nKeyCode, par_nShiftAltCtrl)
3137:         LOCAL loc_oPg2, loc_cTabd, loc_nResult
3138:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3139:         loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
3140: 
3141:         IF EMPTY(loc_cTabd)
3142:             RETURN
3143:         ENDIF
3144: 
3145:         TRY
3146:             LOCAL loc_cSQL
3147:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigOpTdz WHERE codigos = " + EscaparSQL(loc_cTabd)
3148:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTabd")
3149:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaTabd") = 0
3150:                 IF USED("cursor_4c_BuscaTabd")
3151:                     USE IN cursor_4c_BuscaTabd
3152:                 ENDIF
3153:                 THIS.AbrirBuscaTabd()
3154:             ELSE
3155:                 IF USED("cursor_4c_BuscaTabd")
3156:                     USE IN cursor_4c_BuscaTabd
3157:                 ENDIF
3158:             ENDIF
3159:         CATCH TO loException
3160:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarTabd")
3161:         ENDTRY
3162:     ENDPROC
3163: 
3164:     *==========================================================================
3165:     * AbrirBuscaTabd - Abre FormBuscaAuxiliar para selecionar Tabela de Desconto
3166:     *==========================================================================
3167:     PROCEDURE AbrirBuscaTabd()
3168:         LOCAL loc_oPg2, loc_oBusca, loc_cTabd
3169:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3170:         loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
3171: 
3172:         TRY
3173:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3174:                 "SigOpTdz", "cursor_4c_BuscaTabd", "codigos", loc_cTabd, ;
3175:                 "Tabelas de Desconto")
3176: 
3177:             IF VARTYPE(loc_oBusca) = "O"
3178:                 IF !loc_oBusca.this_lAchouRegistro
3179:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
3180:                     loc_oBusca.mAddColuna("descrs",  "",           "Descri" + CHR(231) + CHR(227) + "o")
3181:                     loc_oBusca.Show()
3182:                 ENDIF
3183: 
3184:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3185:                     SELECT cursor_4c_BuscaTabd
3186:                     loc_oPg2.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3187:                 ELSE
3188:                     IF !loc_oBusca.this_lAchouRegistro
3189:                         loc_oPg2.txt_4c_Tabd.Value = ""
3190:                     ENDIF
3191:                 ENDIF
3192:                 loc_oBusca.Release()
3193:             ENDIF
3194: 
3195:             IF USED("cursor_4c_BuscaTabd")
3196:                 USE IN cursor_4c_BuscaTabd
3197:             ENDIF
3198: 
3199:         CATCH TO loException
3200:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaTabd")
3201:         ENDTRY
3202:     ENDPROC
3203: 
3204:     *==========================================================================
3205:     * TeclaTabd - KeyPress do txt_4c_Tabd
3206:     * F4/F5: abre lookup. ENTER/TAB: valida.
3207:     *==========================================================================
3208:     PROCEDURE TeclaTabd(par_nKeyCode, par_nShiftAltCtrl)
3209:         IF INLIST(par_nKeyCode, 115, 116)
3210:             THIS.AbrirBuscaTabd()
3211:         ELSE
3212:             IF INLIST(par_nKeyCode, 13, 9)
3213:             THIS.ValidarTabd()
3214:             ENDIF
3215:         ENDIF
3216:     ENDPROC
3217: 
3218:     *==========================================================================
3219:     * ValidarGetConta - LostFocus do txt_4c_GetConta (Fornecedor, modo compra)
3220:     * Lookup em SigCdCli por iclis; preenche txt_4c_GetDconta automaticamente
3221:     *==========================================================================
3222:     PROCEDURE ValidarGetConta(par_nKeyCode, par_nShiftAltCtrl)
3223:         LOCAL loc_oPg2, loc_oCnt, loc_cConta, loc_nResult
3224:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3225:         loc_oCnt   = loc_oPg2.cnt_4c_Compra
3226:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)
3227: 
3228:         IF EMPTY(loc_cConta)
3229:             loc_oCnt.txt_4c_GetDconta.Value = ""
3230:             RETURN
3231:         ENDIF
3232: 
3233:         TRY
3234:             LOCAL loc_cSQL
3235:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
3236:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaForns")
3237:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaForns") > 0
3238:                 SELECT cursor_4c_BuscaForns
3239:                 loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3240:             ELSE
3241:                 IF USED("cursor_4c_BuscaForns")
3242:                     USE IN cursor_4c_BuscaForns
3243:                 ENDIF
3244:                 THIS.AbrirBuscaGetConta()
3245:             ENDIF
3246:             IF USED("cursor_4c_BuscaForns")
3247:                 USE IN cursor_4c_BuscaForns
3248:             ENDIF
3249:         CATCH TO loException
3250:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetConta")
3251:         ENDTRY
3252:     ENDPROC
3253: 
3254:     *==========================================================================
3255:     * AbrirBuscaGetConta - Abre FormBuscaAuxiliar para selecionar Fornecedor
3256:     * (modo compra - campo GetConta de cnt_4c_Compra)
3257:     *==========================================================================
3258:     PROCEDURE AbrirBuscaGetConta()
3259:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cConta
3260:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3261:         loc_oCnt   = loc_oPg2.cnt_4c_Compra
3262:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)
3263: 
3264:         TRY
3265:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3266:                 "SigCdCli", "cursor_4c_BuscaForns", "iclis", loc_cConta, ;
3267:                 "Fornecedor")
3268: 
3269:             IF VARTYPE(loc_oBusca) = "O"
3270:                 IF !loc_oBusca.this_lAchouRegistro
3271:                     loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
3272:                     loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
3273:                     loc_oBusca.Show()
3274:                 ENDIF
3275: 
3276:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3277:                     SELECT cursor_4c_BuscaForns
3278:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3279:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3280:                 ELSE
3281:                     IF !loc_oBusca.this_lAchouRegistro
3282:                         loc_oCnt.txt_4c_GetConta.Value  = ""
3283:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3284:                     ENDIF
3285:                 ENDIF
3286:                 loc_oBusca.Release()
3287:             ENDIF
3288: 
3289:             IF USED("cursor_4c_BuscaForns")
3290:                 USE IN cursor_4c_BuscaForns
3291:             ENDIF
3292: 
3293:         CATCH TO loException
3294:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetConta")
3295:         ENDTRY
3296:     ENDPROC
3297: 
3298:     *==========================================================================
3299:     * TeclaGetConta - KeyPress do txt_4c_GetConta (Fornecedor modo compra)
3300:     * F4/F5: abre lookup. ENTER/TAB: valida.
3301:     *==========================================================================
3302:     PROCEDURE TeclaGetConta(par_nKeyCode, par_nShiftAltCtrl)
3303:         IF INLIST(par_nKeyCode, 115, 116)
3304:             THIS.AbrirBuscaGetConta()
3305:         ELSE
3306:             IF INLIST(par_nKeyCode, 13, 9)
3307:             THIS.ValidarGetConta()
3308:             ENDIF
3309:         ENDIF
3310:     ENDPROC
3311: 
3312:     *==========================================================================
3313:     * ValidarGetDconta - LostFocus do txt_4c_GetDconta (Descricao Fornecedor)
3314:     * Ativo apenas quando txt_4c_GetConta estiver vazio (busca por nome)
3315:     *==========================================================================
3316:     PROCEDURE ValidarGetDconta(par_nKeyCode, par_nShiftAltCtrl)
3317:         LOCAL loc_oPg2, loc_oCnt
3318:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3319:         loc_oCnt = loc_oPg2.cnt_4c_Compra
3320: 
3321:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetConta.Value))
3322:             RETURN
3323:         ENDIF
3324: 
3325:         IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value))
3326:             RETURN
3327:         ENDIF
3328: 
3329:         TRY
3330:             THIS.AbrirBuscaGetDconta()
3331:         CATCH TO loException
3332:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetDconta")
3333:         ENDTRY
3334:     ENDPROC
3335: 
3336:     *==========================================================================
3337:     * AbrirBuscaGetDconta - Abre FormBuscaAuxiliar para Fornecedor por descricao
3338:     *==========================================================================
3339:     PROCEDURE AbrirBuscaGetDconta()
3340:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cDconta
3341:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3342:         loc_oCnt    = loc_oPg2.cnt_4c_Compra
3343:         loc_cDconta = ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value)
3344: 
3345:         TRY
3346:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3347:                 "SigCdCli", "cursor_4c_BuscaForns", "rclis", loc_cDconta, ;
3348:                 "Fornecedor")
3349: 
3350:             IF VARTYPE(loc_oBusca) = "O"
3351:                 IF !loc_oBusca.this_lAchouRegistro
3352:                     loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
3353:                     loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
3354:                     loc_oBusca.Show()
3355:                 ENDIF
3356: 
3357:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3358:                     SELECT cursor_4c_BuscaForns
3359:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3360:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3361:                 ELSE
3362:                     IF !loc_oBusca.this_lAchouRegistro
3363:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3364:                     ENDIF
3365:                 ENDIF
3366:                 loc_oBusca.Release()
3367:             ENDIF
3368: 
3369:             IF USED("cursor_4c_BuscaForns")
3370:                 USE IN cursor_4c_BuscaForns
3371:             ENDIF
3372: 
3373:         CATCH TO loException
3374:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetDconta")
3375:         ENDTRY
3376:     ENDPROC
3377: 
3378:     *==========================================================================
3379:     * TeclaGetDconta - KeyPress do txt_4c_GetDconta (Descricao Fornecedor)
3380:     * F4/F5/ENTER/TAB: abre lookup por nome.
3381:     *==========================================================================
3382:     PROCEDURE TeclaGetDconta(par_nKeyCode, par_nShiftAltCtrl)
3383:         IF INLIST(par_nKeyCode, 115, 116, 13, 9)
3384:             THIS.AbrirBuscaGetDconta()
3385:         ENDIF
3386:     ENDPROC
3387: 
3388:     *==========================================================================
3389:     * ExecutarReportForm - Helper canonico para REPORT FORM com locale isolado
3390:     * par_cRelatorioBase: nome-base do FRX (sem path, sem .frx)
3391:     * par_cModo        : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
3392:     * par_cCursorDados : alias do cursor consumido pelo FRX (guard vazio)
3393:     *==========================================================================
3394:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
3395:         LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
3396:         loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
3397: 
3398:         IF !FILE(loc_cFRX)
3399:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
3400:                 CHR(13) + loc_cFRX, "Erro")
3401:             RETURN .F.
3402:         ENDIF
3403: 
3404:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
3405:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
3406:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
3407:                     "Aten" + CHR(231) + CHR(227) + "o")
3408:                 RETURN .F.
3409:             ENDIF
3410:         ENDIF
3411: 
3412:         loc_cPointOrig    = SET("POINT")
3413:         loc_cSepOrig      = SET("SEPARATOR")
3414:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
3415:         SET POINT TO "."
3416:         SET SEPARATOR TO ","
3417:         SET REPORTBEHAVIOR 80
3418: 
3419:         DO CASE
3420:             CASE par_cModo == "PREVIEW"
3421:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
3422:             CASE par_cModo == "PRINTER_PROMPT"
3423:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
3424:             CASE par_cModo == "PRINTER"
3425:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
3426:         ENDCASE
3427: 
3428:         SET POINT TO (loc_cPointOrig)
3429:         SET SEPARATOR TO (loc_cSepOrig)
3430:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
3431: 
3432:         TRY
3433:             SET SYSMENU TO DEFAULT
3434:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
3435:             CriarMenuPrincipal()
3436:         CATCH
3437:         ENDTRY
3438: 
3439:         RETURN .T.
3440:     ENDPROC
3441: 
3442:     *==========================================================================
3443:     * Destroy - Libera recursos ao fechar o formulario
3444:     *==========================================================================
3445:     PROCEDURE Destroy()
3446:         TRY
3447:             *-- Restaurar decimais originais
3448:             IF THIS.this_nOldCasas > 0
3449:                 SET DECIMALS TO (THIS.this_nOldCasas)
3450:             ENDIF
3451: 
3452:             *-- Liberar Business Object
3453:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3454:                 THIS.this_oBusinessObject = .NULL.
3455:             ENDIF
3456: 
3457:             *-- Fechar cursores de trabalho
3458:             IF USED("cursor_4c_Dados")
3459:                 USE IN cursor_4c_Dados
3460:             ENDIF
3461:             IF USED("cursor_4c_Itens")
3462:                 USE IN cursor_4c_Itens
3463:             ENDIF
3464:             IF USED("cursor_4c_ItensCopia")
3465:                 USE IN cursor_4c_ItensCopia
3466:             ENDIF
3467:             IF USED("cursor_4c_BuscaProd")
3468:                 USE IN cursor_4c_BuscaProd
3469:             ENDIF
3470:             IF USED("cursor_4c_BuscaMoe")
3471:                 USE IN cursor_4c_BuscaMoe
3472:             ENDIF
3473:             IF USED("cursor_4c_BuscaFpg")
3474:                 USE IN cursor_4c_BuscaFpg
3475:             ENDIF
3476:             IF USED("cursor_4c_BuscaTabd")
3477:                 USE IN cursor_4c_BuscaTabd
3478:             ENDIF
3479:             IF USED("cursor_4c_Relatorio")
3480:                 USE IN cursor_4c_Relatorio
3481:             ENDIF
3482: 
3483:         CATCH TO loException
3484:             MsgErro("Erro: " + loException.Message, "FormLpr.Destroy")
3485:         ENDTRY


### BO (C:\4c\projeto\app\classes\LprBO.prg):
*------------------------------------------------------------------------------
* LprBO.prg - Business Object para Listas de Precificacao
* Tabela principal: SigCdLpc (cabecalho da lista)
* Tabela detalhe  : SigCdLpi (itens da lista)
* Herda de        : BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS LprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades SigCdLpc - campo a campo conforme schema.sql
    *--------------------------------------------------------------------------
    this_cLprecos    = ""    && c(30) PK  - codigo da lista de precos
    this_cFpags      = ""    && c(12)     - condicao de pagamento (FK SigOpFp)
    this_nFormulas   = 0     && n(1,0)    - tipo formula de calculo
    this_nComiss     = 0     && n(1,0)    - tipo calculo comissao
    this_nNvencs     = 0     && n(1,0)    - tipo vencimento
    this_cContas     = ""    && c(10)     - conta (modo compra: fornecedor)
    this_lFlags      = .F.   && bit       - ja atualizada no sistema
    this_cTipos      = ""    && c(1)      - tipo: "C"=compra, " "=venda
    this_dVencis     = {}    && datetime  - data vencimento inicial
    this_nAplictabds = 0     && n(1,0)    - aplica tabela de desconto
    this_cCidchaves  = ""    && c(20)     - chave unica
    this_nDescos     = 0     && n(5,2)    - percentual de desconto
    this_cTabds      = ""    && c(10)     - codigo tabela desconto (FK SigOpTdz)
    this_nCodigos    = 0     && n(6,0)    - codigo sequencial (gerado por fGerUniqueKey)
    this_cEmps       = ""    && c(3)      - empresa (FK SigCdEmp)
    this_nNqtdes     = 0     && n(5,0)    - quantidade minima

    *--------------------------------------------------------------------------
    * Propriedades auxiliares - descricoes (nao persistidas no banco)
    *--------------------------------------------------------------------------
    this_cDfpags     = ""    && descricao da condicao de pagamento
    this_cDtabds     = ""    && descricao da tabela de desconto
    this_cDemps      = ""    && razao social da empresa
    this_cDcontas    = ""    && descricao da conta (modo compra)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLpc"
        THIS.this_cCampoChave = "lprecos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLprecos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista cabecalhos SigCdLpc filtrados por empresa e tipo
    * par_cFiltro: "C"=compra, " "=venda (vazio = venda)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTipos
        loc_lSucesso = .F.

        TRY
            loc_cTipos = IIF(VARTYPE(par_cFiltro) = "C" AND ALLTRIM(par_cFiltro) = "C", "C", " ")

            loc_cSQL = "SELECT DISTINCT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " INNER JOIN SigCdLpi b ON a.lprecos = b.lprecos" + ;
                       " WHERE a.Tipos = " + EscaparSQL(loc_cTipos) + ;
                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.lprecos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de precifica" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar listas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um SigCdLpc pela PK lprecos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " WHERE a.lprecos = " + EscaparSQL(par_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cLprecos     = TratarNulo(lprecos,     "C")
            THIS.this_cFpags       = TratarNulo(fpags,       "C")
            THIS.this_nFormulas    = TratarNulo(formulas,    "N")
            THIS.this_nComiss      = TratarNulo(ncomiss,     "N")
            THIS.this_nNvencs      = TratarNulo(nvencs,      "N")
            THIS.this_cContas      = TratarNulo(contas,      "C")
            THIS.this_lFlags       = (TratarNulo(flags, "N") = 1)
            THIS.this_cTipos       = TratarNulo(tipos,       "C")
            THIS.this_dVencis      = TratarNulo(vencis,      "D")
            THIS.this_nAplictabds  = TratarNulo(aplictabds,  "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_nDescos      = TratarNulo(descos,      "N")
            THIS.this_cTabds       = TratarNulo(tabds,       "C")
            THIS.this_nCodigos     = TratarNulo(codigos,     "N")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_nNqtdes      = TratarNulo(nqtdes,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdLpc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLpc" + ;
                       " (lprecos, fpags, formulas, ncomiss, nvencs, contas," + ;
                       " flags, tipos, vencis, aplictabds, cidchaves, descos," + ;
                       " tabds, codigos, emps, nqtdes)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLprecos) + "," + ;
                       EscaparSQL(THIS.this_cFpags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       EscaparSQL(THIS.this_cTabds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNqtdes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdLpc (lprecos eh PK, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET" + ;
                       " fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                       " formulas = " + FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       " ncomiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " nvencs = " + FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " flags = " + IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       " tipos = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       " vencis = " + FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       " aplictabds = " + FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       " descos = " + FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " codigos = " + FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " nqtdes = " + FormatarNumeroSQL(THIS.this_nNqtdes) + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi (itens) e SigCdLpc (cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (FK)
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + ;
                       EscaparSQL(THIS.this_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdLpc WHERE lprecos = " + ;
                           EscaparSQL(THIS.this_cLprecos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega SigCdLpi de uma lista no cursor_4c_Itens
    * par_cLprecos: codigo da lista de precos
    * par_cTipos  : "C"=compra, " "=venda (determina colunas do grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cLprecos, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLprecos))
            RETURN .F.
        ENDIF

        TRY

            IF VARTYPE(par_cTipos) != "C"
                par_cTipos = " "
            ENDIF

            IF ALLTRIM(par_cTipos) = "C"
                *-- Modo compra: colunas cpros, dpros, reffs, ean13, pcuss, moevs + custo novo
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.reffs, a.ean13, a.pcuss, a.moevs," + ;
                           " a.pvens, a.vencis, a.vencfs, a.comiss," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ELSE
                *-- Modo venda: colunas cpros, dpros, pvens, moevs, comiss, vencis, vencfs
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.pvens, a.moevs, a.comiss, a.vencis, a.vencfs," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles," + ;
                           " a.ean13, a.pcuss, a.reffs, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarItens - Persiste cursor_4c_Itens no SQL Server via DELETE+INSERT
    * par_cLprecos: codigo da lista de precos
    * Estrategia: DELETE todos do lprecos + INSERT dos nao-deletados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarItens(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroItem
        LOCAL loc_cCidchave, loc_cCpros, loc_cDpros, loc_cMoevs
        LOCAL loc_nPvens, loc_nComiss, loc_dVencis, loc_dVencfs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13, loc_nPcuss
        LOCAL loc_nPrecode, loc_cOrdems
        loc_lSucesso = .F.
        loc_lErroItem = .F.

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        TRY
            *-- Excluir todos os itens existentes para este lprecos
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Inserir todos os itens nao-deletados do cursor
                SELECT cursor_4c_Itens
                GO TOP
                DO WHILE !EOF("cursor_4c_Itens") AND !loc_lErroItem
                    IF !DELETED("cursor_4c_Itens")
                        loc_cCpros   = ALLTRIM(TratarNulo(cpros,  "C"))
                        loc_cDpros   = ALLTRIM(TratarNulo(dpros,  "C"))
                        loc_cMoevs   = ALLTRIM(TratarNulo(moevs,  "C"))
                        loc_nPvens   = TratarNulo(pvens,   "N")
                        loc_nComiss  = TratarNulo(comiss,  "N")
                        loc_dVencis  = TratarNulo(vencis,  "D")
                        loc_dVencfs  = TratarNulo(vencfs,  "D")
                        loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,  "C"))
                        loc_cReffs   = ALLTRIM(TratarNulo(reffs,  "C"))
                        loc_nEan13   = TratarNulo(ean13,   "N")
                        loc_nPcuss   = TratarNulo(pcuss,   "N")
                        loc_nPrecode = TratarNulo(precode, "N")
                        loc_cOrdems  = ALLTRIM(TratarNulo(ordems, "C"))

                        *-- Gerar cidchaves unico se vazio
                        loc_cCidchave = ALLTRIM(TratarNulo(cidchaves, "C"))
                        IF EMPTY(loc_cCidchave)
                            loc_cCidchave = THIS.GerarCidchave()
                        ENDIF

                        IF !EMPTY(loc_cCpros)
                            loc_cSQL = "INSERT INTO SigCdLpi" + ;
                                       " (cidchaves, lprecos, cpros, dpros, moevs," + ;
                                       " pvens, comiss, vencis, vencfs, cgrus," + ;
                                       " reffs, ean13, pcuss, precode, ordems," + ;
                                       " flagutabs, ccontroles)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidchave) + "," + ;
                                       EscaparSQL(par_cLprecos) + "," + ;
                                       EscaparSQL(loc_cCpros) + "," + ;
                                       EscaparSQL(loc_cDpros) + "," + ;
                                       EscaparSQL(loc_cMoevs) + "," + ;
                                       FormatarNumeroSQL(loc_nPvens) + "," + ;
                                       FormatarNumeroSQL(loc_nComiss) + "," + ;
                                       FormatarDataSQL(loc_dVencis) + "," + ;
                                       FormatarDataSQL(loc_dVencfs) + "," + ;
                                       EscaparSQL(loc_cCgrus) + "," + ;
                                       EscaparSQL(loc_cReffs) + "," + ;
                                       FormatarNumeroSQL(loc_nEan13) + "," + ;
                                       FormatarNumeroSQL(loc_nPcuss) + "," + ;
                                       FormatarNumeroSQL(loc_nPrecode) + "," + ;
                                       EscaparSQL(loc_cOrdems) + "," + ;
                                       "0,'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir item [" + loc_cCpros + "]:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lErroItem = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Itens
                    SKIP
                ENDDO

                IF !loc_lErroItem
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidchave - Gera chave unica para SigCdLpi.cidchaves (char 20)
    * Formato: emps(3) + lprecos(8) + cpros(5) + seq(4)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidchave()
        LOCAL loc_cChave, loc_nSeq, loc_cSQL, loc_nResult
        loc_nSeq = 0

        TRY
            loc_cSQL = "SELECT COUNT(1) AS nTotal FROM SigCdLpi" + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Seq")
                loc_nSeq = TratarNulo(cursor_4c_Seq.nTotal, "N")
            ENDIF
            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar, loc_nSeq = 0
        ENDTRY

        loc_cChave = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                     PADR(LEFT(ALLTRIM(THIS.this_cLprecos), 8), 8) + ;
                     TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS")
        loc_cChave = LEFT(ALLTRIM(loc_cChave) + TRANSFORM(loc_nSeq), 20)

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChecaGrpVenda - Verifica se produto pertence a grupo permitido para venda
    * Consulta SigCdPam.GrPadFors para obter grupo padrao e valida no produto
    * Retorna .T. se pode alterar preco, .F. se grupo bloqueado
    *--------------------------------------------------------------------------
    PROCEDURE ChecaGrpVenda(par_cCpros)
        LOCAL loc_cSQL, loc_nResult, loc_lPode, loc_cGrPadFors, loc_cCgrus
        loc_lPode = .T.

        TRY
            *-- Ler grupo padrao de fornecedores em SigCdPam
            loc_cSQL = "SELECT GrPadFors FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Pam") AND !EMPTY(ALLTRIM(cursor_4c_Pam.GrPadFors))
                loc_cGrPadFors = ALLTRIM(cursor_4c_Pam.GrPadFors)
            ELSE
                loc_cGrPadFors = ""
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF EMPTY(loc_cGrPadFors) OR EMPTY(ALLTRIM(par_cCpros))
                loc_lPode = .T.
            ELSE
                *-- Verificar grupo do produto
                loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResult >= 0 AND !EOF("cursor_4c_Pro")
                    loc_cCgrus = ALLTRIM(cursor_4c_Pro.cgrus)
                    IF loc_cCgrus = loc_cGrPadFors
                        MsgAviso("Produto do grupo " + loc_cGrPadFors + " n" + CHR(227) + "o pode ter pre" + ;
                                 CHR(231) + "o alterado nesta lista!", "Aviso")
                        loc_lPode = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFlags - Marca SigCdLpc.flags=1 (lista atualizada no sistema)
    * e persiste os itens de SigCdLpi via SalvarItens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFlags(par_cLprecos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET flags = 1" + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lFlags = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar flags:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlterarVencimentos - Altera vencfs de todos os itens de uma lista
    * Equivalente ao cmdSalva do cntVencimentos no legado
    *--------------------------------------------------------------------------
    PROCEDURE AlterarVencimentos(par_cLprecos, par_dVencfs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_dVencfs)
            MsgErro("Data de vencimento inv" + CHR(225) + "lida!", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdLpi SET vencfs = " + FormatarDataSQL(par_dVencfs) + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
                MsgInfo("Vencimentos alterados para " + DTOC(par_dVencfs) + "!", "")
            ELSE
                MsgErro("Erro ao alterar vencimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar vencimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

