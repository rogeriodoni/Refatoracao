# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (31)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO, CNT_4C_COMPRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [BINDEVENT-PARAMS] Handler 'ValidarEmpresa' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarLpreco' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarLpreco(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarFpg' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCpros' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCpros(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDpros' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDpros(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarTabd' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTabd(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGetConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGetConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGetDconta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGetDconta(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.MontarRelatorio()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarReportForm()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Itens' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3398 linhas total):

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
637:                     .Top             = 3
638:                     .Left            = 422
639:                     .Width           = 75
640:                     .Height          = 75
641:                     .FontName        = "Comic Sans MS"
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
829:                     .FontName        = "Comic Sans MS"
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

*-- Linhas 1368 a 1483:
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
1382:                     .Caption  = "Sim"
1383:                     .Width    = 40
1384:                     .Themes   = .F.
1385:                 ENDWITH
1386:                 WITH .Buttons(2)
1387:                     .Caption  = "N" + CHR(227) + "o"
1388:                     .Width    = 50
1389:                     .FontName = "Tahoma"
1390:                     .FontSize = 8
1391:                     .Themes   = .F.
1392:                 ENDWITH
1393:             ENDWITH
1394: 
1395:             loc_oPagina.AddObject("opt_4c_Opt_ApliTabD", "OptionGroup")
1396:             WITH loc_oPagina.opt_4c_Opt_ApliTabD
1397:                 .ButtonCount = 2
1398:                 .Top         = 120
1399:                 .Left        = 621
1400:                 .Width       = 94
1401:                 .Height      = 22
1402:                 .Value       = 1
1403:                 .BackStyle   = 0
1404:                 .Visible     = .F.
1405:                 WITH .Buttons(1)
1406:                     .Caption  = "Sim"
1407:                     .Width    = 40
1408:                     .Themes   = .F.
1409:                 ENDWITH
1410:                 WITH .Buttons(2)
1411:                     .Caption  = "N" + CHR(227) + "o"
1412:                     .Width    = 50
1413:                     .FontName = "Tahoma"
1414:                     .FontSize = 8
1415:                     .Themes   = .F.
1416:                 ENDWITH
1417:             ENDWITH
1418: 
1419:             loc_oPagina.AddObject("opt_4c_Opt_Vencimento", "OptionGroup")
1420:             WITH loc_oPagina.opt_4c_Opt_Vencimento
1421:                 .ButtonCount = 2
1422:                 .Top         = 92
1423:                 .Left        = 621
1424:                 .Width       = 94
1425:                 .Height      = 22
1426:                 .Value       = 1
1427:                 .BackStyle   = 0
1428:                 .Visible     = .F.
1429:                 WITH .Buttons(1)
1430:                     .Caption  = "Sim"
1431:                     .Width    = 40
1432:                     .Themes   = .F.
1433:                 ENDWITH
1434:                 WITH .Buttons(2)
1435:                     .Caption  = "N" + CHR(227) + "o"
1436:                     .Width    = 50
1437:                     .FontName = "Tahoma"
1438:                     .FontSize = 8
1439:                     .Themes   = .F.
1440:                 ENDWITH
1441:             ENDWITH
1442: 
1443:             loc_oPagina.AddObject("opt_4c_Opt_Formula", "OptionGroup")
1444:             WITH loc_oPagina.opt_4c_Opt_Formula
1445:                 .ButtonCount = 2
1446:                 .Top         = 67
1447:                 .Left        = 621
1448:                 .Width       = 94
1449:                 .Height      = 22
1450:                 .Value       = 1
1451:                 .BackStyle   = 0
1452:                 .Visible     = .F.
1453:                 WITH .Buttons(1)
1454:                     .Caption  = "Sim"
1455:                     .Width    = 40
1456:                     .Themes   = .F.
1457:                 ENDWITH
1458:                 WITH .Buttons(2)
1459:                     .Caption  = "N" + CHR(227) + "o"
1460:                     .Width    = 50
1461:                     .FontName = "Tahoma"
1462:                     .FontSize = 8
1463:                     .Themes   = .F.
1464:                 ENDWITH
1465:             ENDWITH
1466: 
1467:             loc_oPagina.AddObject("lbl_4c_Say9", "Label")
1468:             WITH loc_oPagina.lbl_4c_Say9
1469:                 .Caption   = "Aplica F" + CHR(243) + "rmulas :"
1470:                 .Top       = 71
1471:                 .Left      = 540
1472:                 .Width     = 80
1473:                 .Height    = 15
1474:                 .FontName  = "Tahoma"
1475:                 .FontSize  = 8
1476:                 .ForeColor = RGB(90, 90, 90)
1477:                 .BackStyle = 0
1478:                 .Visible   = .F.
1479:             ENDWITH
1480: 
1481:             loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
1482:             WITH loc_oPagina.txt_4c_Tabd
1483:                 .Value     = ""

*-- Linhas 1627 a 2230:
1627:             ENDWITH
1628: 
1629:             *----------------------------------------------------------------------
1630:             * BINDEVENTs para controles adicionados na Fase 6
1631:             *----------------------------------------------------------------------
1632:             BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
1633:             BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
1634:             BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
1635:             BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
1636:             BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
1637:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
1638:             BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
1639:             BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
1640:             BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
1641:             BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
1642:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress", THIS, "ValidarTabd")
1643:             BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
1644:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress", THIS, "ValidarGetConta")
1645:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress",  THIS, "TeclaGetConta")
1646:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress", THIS, "ValidarGetDconta")
1647:             BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress",  THIS, "TeclaGetDconta")
1648: 
1649:             THIS.TornarControlesVisiveis(loc_oPagina)
1650: 
1651:             *-- Ocultar controles opcionais apos TornarControlesVisiveis
1652:             loc_oPagina.opt_4c_Opt_Comissao.Visible   = .F.
1653:             loc_oPagina.opt_4c_Opt_ApliTabD.Visible   = .F.
1654:             loc_oPagina.opt_4c_Opt_Vencimento.Visible = .F.
1655:             loc_oPagina.opt_4c_Opt_Formula.Visible    = .F.
1656:             loc_oPagina.lbl_4c_Say9.Visible           = .F.
1657:             loc_oPagina.txt_4c_Tabd.Visible           = .F.
1658:             loc_oPagina.txt_4c_Juros.Visible          = .F.
1659:             loc_oPagina.cmd_4c_SelecionaC.Visible     = .F.
1660: 
1661:         CATCH TO loException
1662:             MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaDados")
1663:         ENDTRY
1664:     ENDPROC
1665: 
1666:     *==========================================================================
1667:     * BtnSalvarClick - Salva o cabecalho da lista de precos (SigCdLpc)
1668:     * Chamado pelo cmd_4c_Confirmar da Page2
1669:     *==========================================================================
1670:     PROCEDURE BtnSalvarClick()
1671:         LOCAL loc_lSucesso
1672:         loc_lSucesso = .F.
1673: 
1674:         *-- Validacoes obrigatorias ANTES do TRY (RETURN fora do TRY)
1675:         LOCAL loc_oPg2
1676:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1677: 
1678:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value))
1679:             MsgAviso("C" + CHR(243) + "digo da Lista de Pre" + CHR(231) + ;
1680:                 CHR(227) + "o obrigat" + CHR(243) + "rio!", "Aviso")
1681:             loc_oPg2.txt_4c_Lpreco.SetFocus()
1682:             RETURN
1683:         ENDIF
1684: 
1685:         TRY
1686:             THIS.FormParaBO()
1687:             IF THIS.this_oBusinessObject.Salvar()
1688:                 LOCAL loc_cLprecoSalvo
1689:                 loc_cLprecoSalvo = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1690:                 IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
1691:                     IF THIS.this_oBusinessObject.SalvarItens(loc_cLprecoSalvo)
1692:                         MsgInfo("Lista salva com sucesso!", "")
1693:                         THIS.AlternarPagina(1)
1694:                     ELSE
1695:                         MsgErro("Cabe" + CHR(231) + "alho salvo mas houve erro ao salvar itens.", "Aviso")
1696:                     ENDIF
1697:                 ELSE
1698:                     MsgInfo("Lista salva com sucesso!", "")
1699:                     THIS.AlternarPagina(1)
1700:                 ENDIF
1701:             ENDIF
1702:         CATCH TO loException
1703:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormLpr.BtnSalvarClick")
1704:         ENDTRY
1705:     ENDPROC
1706: 
1707:     *==========================================================================
1708:     * BtnCancelarClick - Cancela edicao e volta para a lista (Page1)
1709:     *==========================================================================
1710:     PROCEDURE BtnCancelarClick()
1711:         TRY
1712:             THIS.this_cPcEscolha    = ""
1713:             THIS.this_cLprecosAtual = ""
1714:             THIS.AlternarPagina(1)
1715:         CATCH TO loException
1716:             MsgErro("Erro ao cancelar:" + CHR(13) + loException.Message, "FormLpr.BtnCancelarClick")
1717:         ENDTRY
1718:     ENDPROC
1719: 
1720:     *==========================================================================
1721:     * ValidarEmpresa - LostFocus do txt_4c_Emps
1722:     * Valida empresa digitada; se vazio pre-preenche com empresa logada
1723:     *==========================================================================
1724:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1725:         LOCAL loc_oPg2, loc_cEmps, loc_nResult
1726:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1727: 
1728:         TRY
1729:             loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
1730: 
1731:             IF EMPTY(loc_cEmps)
1732:                 loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1733:             ELSE
1734:                 *-- Verificar se empresa existe em SigCdEmp
1735:                 LOCAL loc_cSQL
1736:                 loc_cSQL = "SELECT TOP 1 CEmps FROM SigCdEmp WHERE CEmps = " + ;
1737:                            EscaparSQL(loc_cEmps)
1738:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmps")
1739:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldEmps") = 0
1740:                     MsgErro("Empresa [" + loc_cEmps + "] n" + CHR(227) + "o encontrada!", "Aviso")
1741:                     loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
1742:                 ENDIF
1743:                 IF USED("cursor_4c_VldEmps")
1744:                     USE IN cursor_4c_VldEmps
1745:                 ENDIF
1746:             ENDIF
1747: 
1748:         CATCH TO loException
1749:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarEmpresa")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     *==========================================================================
1754:     * ValidarLpreco - LostFocus do txt_4c_Lpreco
1755:     * Para INSERIR: verifica duplicata. Para PROCURAR: carrega registro.
1756:     *==========================================================================
1757:     PROCEDURE ValidarLpreco(par_nKeyCode, par_nShiftAltCtrl)
1758:         LOCAL loc_oPg2, loc_cLpreco, loc_nResult
1759:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1760:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
1761: 
1762:         IF EMPTY(loc_cLpreco) OR loc_cLpreco == THIS.this_cAntLPreco
1763:             RETURN
1764:         ENDIF
1765: 
1766:         THIS.this_cAntLPreco = loc_cLpreco
1767: 
1768:         TRY
1769:             IF THIS.this_cPcEscolha = "INSERIR"
1770:                 *-- Verificar duplicata
1771:                 LOCAL loc_cSQL2
1772:                 loc_cSQL2 = "SELECT TOP 1 lprecos FROM SigCdLpc WHERE lprecos = " + ;
1773:                             EscaparSQL(loc_cLpreco)
1774:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_VldLpr")
1775:                 IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLpr") > 0
1776:                     MsgErro("Lista de Pre" + CHR(231) + "o [" + loc_cLpreco + ;
1777:                         "] j" + CHR(225) + " cadastrada!", "Aviso")
1778:                     loc_oPg2.txt_4c_Lpreco.Value = THIS.this_cAntLPreco
1779:                 ENDIF
1780:                 IF USED("cursor_4c_VldLpr")
1781:                     USE IN cursor_4c_VldLpr
1782:                 ENDIF
1783:             ELSE
1784:                 IF THIS.this_cPcEscolha = "PROCURAR"
1785:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLpreco)
1786:                     THIS.BOParaForm()
1787:                 ELSE
1788:                     MsgAviso("Lista [" + loc_cLpreco + "] n" + CHR(227) + ;
1789:                         "o encontrada!", "Aviso")
1790:                     loc_oPg2.txt_4c_Lpreco.Value = ""
1791:                     THIS.this_cAntLPreco = ""
1792:                 ENDIF
1793:                 ENDIF
1794:             ENDIF
1795: 
1796:         CATCH TO loException
1797:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarLpreco")
1798:         ENDTRY
1799:     ENDPROC
1800: 
1801:     *==========================================================================
1802:     * ValidarFpg - LostFocus do txt_4c_Fpg (Cond. Pagamento)
1803:     * Lookup em SigOpFp por fpags (campo fpags)
1804:     *==========================================================================
1805:     PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
1806:         LOCAL loc_oPg2, loc_cFpg
1807:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1808:         loc_cFpg = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
1809: 
1810:         IF EMPTY(loc_cFpg)
1811:             RETURN
1812:         ENDIF
1813: 
1814:         TRY
1815:             LOCAL loc_oBusca, loc_cSQL3
1816:             *-- Verificar se fpag existe
1817:             loc_cSQL3 = "SELECT TOP 1 fpags FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cFpg)
1818:             LOCAL loc_nRes
1819:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_BuscaFpg")
1820:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BuscaFpg") = 0
1821:                 *-- Nao encontrou exato - abrir lookup
1822:                 IF USED("cursor_4c_BuscaFpg")
1823:                     USE IN cursor_4c_BuscaFpg
1824:                 ENDIF
1825:                 THIS.AbrirBuscaFpg(loc_cFpg)
1826:             ELSE
1827:                 IF USED("cursor_4c_BuscaFpg")
1828:                     USE IN cursor_4c_BuscaFpg
1829:                 ENDIF
1830:             ENDIF
1831: 
1832:         CATCH TO loException
1833:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarFpg")
1834:         ENDTRY
1835:     ENDPROC
1836: 
1837:     *==========================================================================
1838:     * AbrirBuscaFpg - Abre FormBuscaAuxiliar para selecionar Cond. Pagamento
1839:     *==========================================================================
1840:     PROCEDURE AbrirBuscaFpg(par_cFpgAtual)
1841:         LOCAL loc_oPg2, loc_oBusca
1842:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1843: 
1844:         TRY
1845:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1846:                 "SigOpFp", "cursor_4c_BuscaFpg", "fpags", ;
1847:                 ALLTRIM(par_cFpgAtual), "Condi" + CHR(231) + CHR(245) + "es de Pagamento")
1848: 
1849:             IF VARTYPE(loc_oBusca) = "O"
1850:                 IF !loc_oBusca.this_lAchouRegistro
1851:                     loc_oBusca.mAddColuna("fpags",  "XXXXXXXXXXXX", "C" + CHR(243) + "digo")
1852:                     loc_oBusca.mAddColuna("fparcs", "",             "Parcelas")
1853:                     loc_oBusca.Show()
1854:                 ENDIF
1855: 
1856:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
1857:                     SELECT cursor_4c_BuscaFpg
1858:                     loc_oPg2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
1859:                 ELSE
1860:                     IF !loc_oBusca.this_lAchouRegistro
1861:                         loc_oPg2.txt_4c_Fpg.Value = ""
1862:                     ENDIF
1863:                 ENDIF
1864:                 loc_oBusca.Release()
1865:             ENDIF
1866: 
1867:             IF USED("cursor_4c_BuscaFpg")
1868:                 USE IN cursor_4c_BuscaFpg
1869:             ENDIF
1870: 
1871:         CATCH TO loException
1872:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaFpg")
1873:         ENDTRY
1874:     ENDPROC
1875: 
1876:     *==========================================================================
1877:     * ValidarCpros - LostFocus do txt_4c_Txtcpros (busca na grade por codigo)
1878:     * Lookup em SigCdPro por cpros; preenche txt_4c_Txtdpros automaticamente
1879:     *==========================================================================
1880:     PROCEDURE ValidarCpros(par_nKeyCode, par_nShiftAltCtrl)
1881:         LOCAL loc_oPg2, loc_cCpros, loc_oBusca
1882:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1883:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
1884: 
1885:         IF EMPTY(loc_cCpros) OR loc_cCpros == THIS.this_cAntCPro
1886:             RETURN
1887:         ENDIF
1888: 
1889:         THIS.this_cAntCPro = loc_cCpros
1890: 
1891:         TRY
1892:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1893:                 "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cCpros, "Produtos", 1000)
1894: 
1895:             IF VARTYPE(loc_oBusca) = "O"
1896:                 IF !loc_oBusca.this_lAchouRegistro
1897:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1898:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1899:                     loc_oBusca.Show()
1900:                 ENDIF
1901: 
1902:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1903:                     SELECT cursor_4c_BuscaProd
1904:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1905:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1906:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1907:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1908:                 ELSE
1909:                     IF !loc_oBusca.this_lAchouRegistro
1910:                         loc_oPg2.txt_4c_Txtcpros.Value = ""
1911:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1912:                         THIS.this_cAntCPro = ""
1913:                         THIS.this_cAntDPro = ""
1914:                     ENDIF
1915:                 ENDIF
1916:                 loc_oBusca.Release()
1917:             ENDIF
1918: 
1919:             IF USED("cursor_4c_BuscaProd")
1920:                 USE IN cursor_4c_BuscaProd
1921:             ENDIF
1922: 
1923:         CATCH TO loException
1924:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarCpros")
1925:         ENDTRY
1926:     ENDPROC
1927: 
1928:     *==========================================================================
1929:     * ValidarDpros - LostFocus do txt_4c_Txtdpros (busca na grade por descricao)
1930:     * Ativo apenas quando txt_4c_Txtcpros estiver vazio
1931:     *==========================================================================
1932:     PROCEDURE ValidarDpros(par_nKeyCode, par_nShiftAltCtrl)
1933:         LOCAL loc_oPg2, loc_cDpros, loc_oBusca
1934:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1935:         loc_cDpros = ALLTRIM(loc_oPg2.txt_4c_Txtdpros.Value)
1936: 
1937:         IF !EMPTY(loc_oPg2.txt_4c_Txtcpros.Value)
1938:             RETURN
1939:         ENDIF
1940: 
1941:         IF EMPTY(loc_cDpros) OR loc_cDpros == THIS.this_cAntDPro
1942:             RETURN
1943:         ENDIF
1944: 
1945:         THIS.this_cAntDPro = loc_cDpros
1946: 
1947:         TRY
1948:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1949:                 "SigCdPro", "cursor_4c_BuscaProd", "dpros", loc_cDpros, "Produtos", 1000)
1950: 
1951:             IF VARTYPE(loc_oBusca) = "O"
1952:                 IF !loc_oBusca.this_lAchouRegistro
1953:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1954:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1955:                     loc_oBusca.Show()
1956:                 ENDIF
1957: 
1958:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1959:                     SELECT cursor_4c_BuscaProd
1960:                     loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1961:                     loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
1962:                     THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
1963:                     THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
1964:                 ELSE
1965:                     IF !loc_oBusca.this_lAchouRegistro
1966:                         loc_oPg2.txt_4c_Txtdpros.Value = ""
1967:                         THIS.this_cAntDPro = ""
1968:                     ENDIF
1969:                 ENDIF
1970:                 loc_oBusca.Release()
1971:             ENDIF
1972: 
1973:             IF USED("cursor_4c_BuscaProd")
1974:                 USE IN cursor_4c_BuscaProd
1975:             ENDIF
1976: 
1977:         CATCH TO loException
1978:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarDpros")
1979:         ENDTRY
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * BtnBuscaGradeClick - Click do botao Busca na area de pesquisa da grade
1984:     * Busca no cursor de itens (cursor_4c_Itens) pelo cpros digitado e
1985:     * posiciona o foco na grade (grade sera vinculada na Fase 6)
1986:     *==========================================================================
1987:     PROCEDURE BtnBuscaGradeClick()
1988:         LOCAL loc_oPg2, loc_cCpros
1989:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1990:         loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)
1991: 
1992:         TRY
1993:             IF USED("cursor_4c_Itens")
1994:                 SELECT cursor_4c_Itens
1995:                 SET NEAR ON
1996:                 IF !EMPTY(loc_cCpros)
1997:                     SEEK PADR(loc_cCpros, 14) ORDER "cpros"
1998:                 ENDIF
1999:                 SET NEAR OFF
2000: 
2001:                 *-- Tentar focar na grade de itens (adicionada na Fase 6)
2002:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2003:                     loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2004:                 ELSE
2005:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2006:                     loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2007:                     ENDIF
2008:                 ENDIF
2009:             ENDIF
2010: 
2011:             loc_oPg2.txt_4c_Txtcpros.Refresh()
2012:             loc_oPg2.txt_4c_Txtdpros.Refresh()
2013: 
2014:         CATCH TO loException
2015:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnBuscaGradeClick")
2016:         ENDTRY
2017:     ENDPROC
2018: 
2019:     *==========================================================================
2020:     * FormParaBO - Transfere valores do formulario para o Business Object
2021:     * Fase 5: campos do cabecalho SigCdLpc
2022:     *==========================================================================
2023:     PROTECTED PROCEDURE FormParaBO()
2024:         LOCAL loc_oPg2
2025:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2026: 
2027:         TRY
2028:             WITH THIS.this_oBusinessObject
2029:                 .this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
2030:                 .this_cLprecos = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2031:                 .this_cFpags   = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
2032:                 .this_cTipos   = THIS.this_cCompVenda
2033:                 .this_cTabds   = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
2034:             ENDWITH
2035:         CATCH TO loException
2036:             MsgErro("Erro: " + loException.Message, "FormLpr.FormParaBO")
2037:         ENDTRY
2038:     ENDPROC
2039: 
2040:     *==========================================================================
2041:     * BOParaForm - Transfere valores do Business Object para o formulario
2042:     * Fase 5: campos do cabecalho SigCdLpc
2043:     *==========================================================================
2044:     PROTECTED PROCEDURE BOParaForm()
2045:         LOCAL loc_oPg2
2046:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2047: 
2048:         TRY
2049:             WITH THIS.this_oBusinessObject
2050:                 loc_oPg2.txt_4c_Emps.Value   = ALLTRIM(.this_cEmps)
2051:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(.this_cCodigos)
2052:                 loc_oPg2.txt_4c_Lpreco.Value = ALLTRIM(.this_cLprecos)
2053:                 loc_oPg2.txt_4c_Fpg.Value    = ALLTRIM(.this_cFpags)
2054:                 loc_oPg2.txt_4c_Tabd.Value   = ALLTRIM(.this_cTabds)
2055:             ENDWITH
2056: 
2057:             *-- Anti-bounce: atualizar rastreadores
2058:             THIS.this_cAntLPreco = ALLTRIM(THIS.this_oBusinessObject.this_cLprecos)
2059:             THIS.this_cAntCPro   = ""
2060:             THIS.this_cAntDPro   = ""
2061:             loc_oPg2.txt_4c_Txtcpros.Value = ""
2062:             loc_oPg2.txt_4c_Txtdpros.Value = ""
2063: 
2064:         CATCH TO loException
2065:             MsgErro("Erro: " + loException.Message, "FormLpr.BOParaForm")
2066:         ENDTRY
2067:     ENDPROC
2068: 
2069:     *==========================================================================
2070:     * LimparCampos - Limpa todos os campos editaveis da Page2
2071:     *==========================================================================
2072:     PROTECTED PROCEDURE LimparCampos()
2073:         LOCAL loc_oPg2
2074:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2075: 
2076:         TRY
2077:             loc_oPg2.txt_4c_Emps.Value     = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2078:             loc_oPg2.txt_4c_Codigo.Value   = ""
2079:             loc_oPg2.txt_4c_Lpreco.Value   = ""
2080:             loc_oPg2.txt_4c_Fpg.Value      = ""
2081:             loc_oPg2.txt_4c_Tabd.Value     = ""
2082:             loc_oPg2.txt_4c_Txtcpros.Value = ""
2083:             loc_oPg2.txt_4c_Txtdpros.Value = ""
2084:             THIS.this_cAntLPreco = ""
2085:             THIS.this_cAntCPro   = ""
2086:             THIS.this_cAntDPro   = ""
2087:         CATCH TO loException
2088:             MsgErro("Erro: " + loException.Message, "FormLpr.LimparCampos")
2089:         ENDTRY
2090:     ENDPROC
2091: 
2092:     *==========================================================================
2093:     * HabilitarCampos - Habilita ou desabilita campos conforme modo e flags
2094:     * par_lHabilitar: .T. = habilitar campos editaveis, .F. = somente leitura
2095:     *==========================================================================
2096:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2097:         LOCAL loc_oPg2, loc_lFlags
2098:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2099:         loc_lFlags = .F.
2100: 
2101:         TRY
2102:             *-- Verificar se a lista ja foi publicada (flags=1)
2103:             IF THIS.this_cPcEscolha = "ALTERAR" AND ;
2104:                USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2105:                 SELECT cursor_4c_Dados
2106:                 loc_lFlags = (TratarNulo(cursor_4c_Dados.flags, "N") = 1)
2107:             ENDIF
2108: 
2109:             *-- Emps: editavel apenas em INSERIR e quando nao flags
2110:             loc_oPg2.txt_4c_Emps.ReadOnly   = !(par_lHabilitar AND !loc_lFlags)
2111:             *-- Lpreco: editavel apenas em INSERIR (nao pode mudar PK em ALTERAR)
2112:             loc_oPg2.txt_4c_Lpreco.ReadOnly = !(par_lHabilitar AND THIS.this_cPcEscolha = "INSERIR")
2113:             *-- Fpg: editavel em INSERIR e ALTERAR (quando nao flags)
2114:             loc_oPg2.txt_4c_Fpg.ReadOnly    = !(par_lHabilitar AND !loc_lFlags)
2115:             *-- Campos de busca na grade: sempre editaveis quando ha lista selecionada
2116:             loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
2117:             loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
2118:             *-- Botoes acao
2119:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2120:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2121: 
2122:         CATCH TO loException
2123:             MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
2124:         ENDTRY
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * CarregarItens - Carrega SigCdLpi no cursor_4c_Itens e vincula grids
2129:     * par_cLprecos: codigo da lista; vazio = nova lista (cursor nao carregado)
2130:     *==========================================================================
2131:     PROTECTED PROCEDURE CarregarItens(par_cLprecos)
2132:         LOCAL loc_lSucesso
2133:         loc_lSucesso = .F.
2134: 
2135:         TRY
2136:             IF USED("cursor_4c_Itens")
2137:                 USE IN cursor_4c_Itens
2138:             ENDIF
2139: 
2140:             IF !EMPTY(ALLTRIM(par_cLprecos))
2141:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarItens(par_cLprecos, THIS.this_cCompVenda)
2142:             ENDIF
2143: 
2144:             IF loc_lSucesso AND USED("cursor_4c_Itens")
2145:                 *-- Criar indice para SEEK em BtnBuscaGradeClick
2146:                 SELECT cursor_4c_Itens
2147:                 INDEX ON PADR(cpros, 14) TAG cpros ADDITIVE
2148:                 GO TOP
2149:             ENDIF
2150: 
2151:             THIS.VincularGrade()
2152: 
2153:         CATCH TO loException
2154:             MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "FormLpr.CarregarItens")
2155:         ENDTRY
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * VincularGrade - Define RecordSource, ControlSources e Headers dos grids
2160:     * Exibe grd_4c_GradeC em modo compra; grd_4c_Grade em modo venda
2161:     *==========================================================================
2162:     PROTECTED PROCEDURE VincularGrade()
2163:         LOCAL loc_oPg2, loc_lModoCompra, loc_oGrid
2164:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
2165:         loc_lModoCompra = (THIS.this_cCompVenda = "C")
2166: 
2167:         TRY
2168:             IF loc_lModoCompra
2169:                 *-- Modo compra: grd_4c_GradeC visivel, grd_4c_Grade oculta
2170:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
2171:                     loc_oGrid = loc_oPg2.grd_4c_GradeC
2172:                     IF USED("cursor_4c_Itens")
2173:                         loc_oGrid.ColumnCount = 7
2174:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2175:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2176:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2177:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.reffs"
2178:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.ean13"
2179:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.pcuss"
2180:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.moevs"
2181:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.pvens"
2182:                     ELSE
2183:                         loc_oGrid.RecordSource = ""
2184:                     ENDIF
2185:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2186:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2187:                     loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
2188:                     loc_oGrid.Column4.Header1.Caption = "EAN"
2189:                     loc_oGrid.Column5.Header1.Caption = "Custo Atual"
2190:                     loc_oGrid.Column6.Header1.Caption = "Moe"
2191:                     loc_oGrid.Column7.Header1.Caption = "Custo Novo"
2192:                     loc_oGrid.FontName = "Verdana"
2193:                     loc_oGrid.FontSize = 8
2194:                     loc_oGrid.Visible = .T.
2195:                     loc_oGrid.Refresh()
2196:                 ENDIF
2197:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2198:                     loc_oPg2.grd_4c_Grade.Visible = .F.
2199:                 ENDIF
2200:             ELSE
2201:                 *-- Modo venda: grd_4c_Grade visivel, grd_4c_GradeC oculta
2202:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
2203:                     loc_oGrid = loc_oPg2.grd_4c_Grade
2204:                     IF USED("cursor_4c_Itens")
2205:                         loc_oGrid.ColumnCount = 9
2206:                         loc_oGrid.RecordSource         = "cursor_4c_Itens"
2207:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
2208:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
2209:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.pvens"
2210:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.moevs"
2211:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.comiss"
2212:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.vencis"
2213:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.vencfs"
2214:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Itens.cgrus"
2215:                         loc_oGrid.Column9.ControlSource = "cursor_4c_Itens.precode"
2216:                     ELSE
2217:                         loc_oGrid.RecordSource = ""
2218:                     ENDIF
2219:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
2220:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
2221:                     loc_oGrid.Column3.Header1.Caption = "Pr. Venda"
2222:                     loc_oGrid.Column4.Header1.Caption = "Moe"
2223:                     loc_oGrid.Column5.Header1.Caption = "Comiss."
2224:                     loc_oGrid.Column6.Header1.Caption = "Venc. Inicial"
2225:                     loc_oGrid.Column7.Header1.Caption = "Venc. Final"
2226:                     loc_oGrid.Column8.Header1.Caption = "C"
2227:                     loc_oGrid.Column9.Header1.Caption = "Pr. De"
2228:                     loc_oGrid.FontName = "Verdana"
2229:                     loc_oGrid.FontSize = 8
2230:                     loc_oGrid.Visible = .T.

*-- Linhas 2243 a 2579:
2243:     *==========================================================================
2244:     * BtnINSEREClick - Insere linha em branco no cursor de itens da lista
2245:     *==========================================================================
2246:     PROCEDURE BtnINSEREClick()
2247:         LOCAL loc_oPg2, loc_cLpreco
2248:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2249:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2250: 
2251:         IF EMPTY(loc_cLpreco)
2252:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
2253:             RETURN
2254:         ENDIF
2255: 
2256:         TRY
2257:             IF !USED("cursor_4c_Itens")
2258:                 CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2259:                     cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2260:                     pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2261:                     vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2262:                     ordems c(11), ccontroles c(30), precode n(16,6))
2263:             ENDIF
2264: 
2265:             SELECT cursor_4c_Itens
2266:             SET FILTER TO
2267:             INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, CHR(255))
2268:             SET FILTER TO !DELETED("cursor_4c_Itens")
2269: 
2270:             THIS.VincularGrade()
2271: 
2272:             SELECT cursor_4c_Itens
2273:             GO BOTTOM
2274: 
2275:             IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
2276:                     AND loc_oPg2.grd_4c_GradeC.Visible
2277:                 loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
2278:             ELSE
2279:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2280:                 loc_oPg2.grd_4c_Grade.Column1.SetFocus()
2281:                 ENDIF
2282:             ENDIF
2283: 
2284:         CATCH TO loException
2285:             MsgErro("Erro ao inserir item:" + CHR(13) + loException.Message, "FormLpr.BtnINSEREClick")
2286:         ENDTRY
2287:     ENDPROC
2288: 
2289:     *==========================================================================
2290:     * BtnDELETEClick - Marca item atual como excluido no cursor de itens
2291:     *==========================================================================
2292:     PROCEDURE BtnDELETEClick()
2293:         LOCAL loc_oPg2
2294:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2295: 
2296:         TRY
2297:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2298:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2299:                 IF MsgConfirma("Confirma exclus" + CHR(227) + "o do item?", "Confirmar")
2300:                     SELECT cursor_4c_Itens
2301:                     IF !DELETED()
2302:                         DELETE
2303:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2304:                         GO TOP
2305:                     ENDIF
2306:                     IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2307:                         loc_oPg2.grd_4c_Grade.Refresh()
2308:                     ENDIF
2309:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2310:                         loc_oPg2.grd_4c_GradeC.Refresh()
2311:                     ENDIF
2312:                 ENDIF
2313:             ELSE
2314:                 MsgAviso("Nenhum item selecionado para excluir.", "Aviso")
2315:             ENDIF
2316:         CATCH TO loException
2317:             MsgErro("Erro ao excluir item:" + CHR(13) + loException.Message, "FormLpr.BtnDELETEClick")
2318:         ENDTRY
2319:     ENDPROC
2320: 
2321:     *==========================================================================
2322:     * BtnCOPIAClick - Duplica o item atual no cursor de itens
2323:     *==========================================================================
2324:     PROCEDURE BtnCOPIAClick()
2325:         LOCAL loc_oPg2, loc_cLpreco
2326:         LOCAL loc_cCpros, loc_cDpros, loc_cMoevs, loc_cCgrus, loc_cReffs
2327:         LOCAL loc_nPvens, loc_nComiss, loc_nEan13, loc_nPcuss, loc_nPrecode
2328:         LOCAL loc_dVencis, loc_dVencfs
2329:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2330:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2331: 
2332:         TRY
2333:             IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
2334:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2335:                 SELECT cursor_4c_Itens
2336:                 loc_cCpros   = ALLTRIM(TratarNulo(cpros,   "C"))
2337:                 loc_cDpros   = ALLTRIM(TratarNulo(dpros,   "C"))
2338:                 loc_cMoevs   = ALLTRIM(TratarNulo(moevs,   "C"))
2339:                 loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,   "C"))
2340:                 loc_cReffs   = ALLTRIM(TratarNulo(reffs,   "C"))
2341:                 loc_nPvens   = TratarNulo(pvens,   "N")
2342:                 loc_nComiss  = TratarNulo(comiss,  "N")
2343:                 loc_nEan13   = TratarNulo(ean13,   "N")
2344:                 loc_nPcuss   = TratarNulo(pcuss,   "N")
2345:                 loc_nPrecode = TratarNulo(precode, "N")
2346:                 loc_dVencis  = TratarNulo(vencis,  "D")
2347:                 loc_dVencfs  = TratarNulo(vencfs,  "D")
2348: 
2349:                 SET FILTER TO
2350:                 INSERT INTO cursor_4c_Itens ;
2351:                     (lprecos, cpros, dpros, moevs, cgrus, reffs, pvens, comiss, ;
2352:                      ean13, pcuss, precode, vencis, vencfs, ordems) ;
2353:                     VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2354:                             loc_cCgrus, loc_cReffs, loc_nPvens, loc_nComiss, ;
2355:                             loc_nEan13, loc_nPcuss, loc_nPrecode, loc_dVencis, ;
2356:                             loc_dVencfs, CHR(255))
2357:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2358: 
2359:                 THIS.VincularGrade()
2360: 
2361:                 SELECT cursor_4c_Itens
2362:                 GO BOTTOM
2363:             ELSE
2364:                 MsgAviso("Nenhum item selecionado para duplicar.", "Aviso")
2365:             ENDIF
2366:         CATCH TO loException
2367:             MsgErro("Erro ao duplicar item:" + CHR(13) + loException.Message, "FormLpr.BtnCOPIAClick")
2368:         ENDTRY
2369:     ENDPROC
2370: 
2371:     *==========================================================================
2372:     * BtnSelecionaClick - Abre browser de produtos para adicionar item a lista
2373:     *==========================================================================
2374:     PROCEDURE BtnSelecionaClick()
2375:         LOCAL loc_oPg2, loc_oBusca, loc_nResult, loc_cSQL, loc_cLpreco
2376:         LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_nPcuss, loc_cMoevs
2377:         LOCAL loc_cCgrus, loc_cReffs, loc_nEan13
2378:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2379:         loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
2380: 
2381:         IF EMPTY(loc_cLpreco)
2382:             MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de selecionar produtos.", "Aviso")
2383:             RETURN
2384:         ENDIF
2385: 
2386:         TRY
2387:             loc_cSQL = "SELECT TOP 500 cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2388:                        " FROM SigCdPro ORDER BY cpros"
2389:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
2390: 
2391:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
2392:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2393:                 IF VARTYPE(loc_oBusca) = "O"
2394:                     loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
2395:                         "Selecionar Produto")
2396:                     loc_oBusca.Mostrar()
2397: 
2398:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
2399:                         SELECT cursor_4c_BuscaProd
2400:                         loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.cpros)
2401:                         loc_cDpros  = ALLTRIM(cursor_4c_BuscaProd.dpros)
2402:                         loc_nPvens  = TratarNulo(cursor_4c_BuscaProd.pvens,  "N")
2403:                         loc_nPcuss  = TratarNulo(cursor_4c_BuscaProd.pcuss,  "N")
2404:                         loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.moevs, "C"))
2405:                         loc_cCgrus  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.cgrus, "C"))
2406:                         loc_cReffs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.reffs, "C"))
2407:                         loc_nEan13  = TratarNulo(cursor_4c_BuscaProd.ean13,  "N")
2408: 
2409:                         IF !USED("cursor_4c_Itens")
2410:                             CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
2411:                                 cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
2412:                                 pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
2413:                                 vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
2414:                                 ordems c(11), ccontroles c(30), precode n(16,6))
2415:                         ENDIF
2416: 
2417:                         SELECT cursor_4c_Itens
2418:                         SET FILTER TO
2419:                         INSERT INTO cursor_4c_Itens ;
2420:                             (lprecos, cpros, dpros, moevs, cgrus, reffs, ean13, ordems, ;
2421:                              pvens, pcuss) ;
2422:                             VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
2423:                                     loc_cCgrus, loc_cReffs, loc_nEan13, CHR(255), ;
2424:                                     IIF(THIS.this_cCompVenda = "C", loc_nPcuss, loc_nPvens), ;
2425:                                     loc_nPcuss)
2426:                         SET FILTER TO !DELETED("cursor_4c_Itens")
2427:                         GO BOTTOM
2428: 
2429:                         THIS.VincularGrade()
2430:                     ENDIF
2431:                     loc_oBusca.Release()
2432:                 ENDIF
2433:             ELSE
2434:                 MsgAviso("Nenhum produto encontrado.", "Aviso")
2435:             ENDIF
2436: 
2437:             IF USED("cursor_4c_BuscaProd")
2438:                 USE IN cursor_4c_BuscaProd
2439:             ENDIF
2440: 
2441:         CATCH TO loException
2442:             MsgErro("Erro ao selecionar produto:" + CHR(13) + loException.Message, "FormLpr.BtnSelecionaClick")
2443:         ENDTRY
2444:     ENDPROC
2445: 
2446:     *==========================================================================
2447:     * BtnCmdVencimentoClick - Exibe ou oculta o painel de vencimento em massa
2448:     *==========================================================================
2449:     PROCEDURE BtnCmdVencimentoClick()
2450:         LOCAL loc_oPg2
2451:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2452: 
2453:         TRY
2454:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2455:                 loc_oPg2.cnt_4c_Vencimentos.Visible = !loc_oPg2.cnt_4c_Vencimentos.Visible
2456:                 IF loc_oPg2.cnt_4c_Vencimentos.Visible
2457:                     *-- Pre-preencher com data atual
2458:                     loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value = DATE()
2459:                     loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.SetFocus()
2460:                 ENDIF
2461:             ENDIF
2462:         CATCH TO loException
2463:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnCmdVencimentoClick")
2464:         ENDTRY
2465:     ENDPROC
2466: 
2467:     *==========================================================================
2468:     * BtnSalvaVencimentoClick - Aplica data de vencimento a todos os itens
2469:     *==========================================================================
2470:     PROCEDURE BtnSalvaVencimentoClick()
2471:         LOCAL loc_oPg2, loc_dVenc
2472:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2473: 
2474:         TRY
2475:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5) AND ;
2476:                PEMSTATUS(loc_oPg2.cnt_4c_Vencimentos, "txt_4c_GetVencs", 5)
2477:                 loc_dVenc = loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value
2478:             ELSE
2479:                 loc_dVenc = DATE()
2480:             ENDIF
2481: 
2482:             IF USED("cursor_4c_Itens") AND VARTYPE(loc_dVenc) = "D" AND !EMPTY(loc_dVenc)
2483:                 SELECT cursor_4c_Itens
2484:                 SET FILTER TO
2485:                 GO TOP
2486:                 SCAN
2487:                     IF !DELETED()
2488:                         REPLACE vencis WITH loc_dVenc
2489:                     ENDIF
2490:                 ENDSCAN
2491:                 SET FILTER TO !DELETED("cursor_4c_Itens")
2492:                 GO TOP
2493:                 IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
2494:                     loc_oPg2.grd_4c_Grade.Refresh()
2495:                 ENDIF
2496:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
2497:                     loc_oPg2.grd_4c_GradeC.Refresh()
2498:                 ENDIF
2499:             ENDIF
2500: 
2501:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
2502:                 loc_oPg2.cnt_4c_Vencimentos.Visible = .F.
2503:             ENDIF
2504: 
2505:         CATCH TO loException
2506:             MsgErro("Erro ao aplicar vencimento:" + CHR(13) + loException.Message, "FormLpr.BtnSalvaVencimentoClick")
2507:         ENDTRY
2508:     ENDPROC
2509: 
2510:     *==========================================================================
2511:     * BtnFechaVencimentoClick - Oculta o painel de vencimento sem salvar
2512:     *==========================================================================
2513:     PROCEDURE BtnFechaVencimentoClick()
2514:         TRY
2515:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Vencimentos", 5)
2516:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Vencimentos.Visible = .F.
2517:             ENDIF
2518:         CATCH TO loException
2519:             MsgErro("Erro: " + loException.Message, "FormLpr.BtnFechaVencimentoClick")
2520:         ENDTRY
2521:     ENDPROC
2522: 
2523:     *==========================================================================
2524:     * BtnSelecionaCClick - Selecionar Produtos (modo compra, Visible=.F. padrao)
2525:     * Reutiliza logica de BtnSelecionaClick adaptada para compra
2526:     *==========================================================================
2527:     PROCEDURE BtnSelecionaCClick()
2528:         THIS.BtnSelecionaClick()
2529:     ENDPROC
2530: 
2531:     *==========================================================================
2532:     * GradeAfterRowColChange - Handler AfterRowColChange dos grids Grade/GradeC
2533:     * par_nColIndex: coluna que ficou ativa ANTES do usuario sair (coluna origem)
2534:     * Quando sai da coluna 1 (cpros): busca produto e pre-preenche campos
2535:     *==========================================================================
2536:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
2537:         LOCAL loc_cCpros, loc_nResult, loc_cSQL, loc_lContinuar
2538:         loc_cCpros     = ""
2539:         loc_lContinuar = .T.
2540: 
2541:         TRY
2542:             IF par_nColIndex = 1 AND USED("cursor_4c_Itens") AND ;
2543:                !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
2544:                 SELECT cursor_4c_Itens
2545:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, "C"))
2546: 
2547:                 IF !EMPTY(loc_cCpros)
2548:                     *-- Verificar grupo em modo venda (bloqueado para certos grupos)
2549:                     IF THIS.this_cCompVenda <> "C"
2550:                         IF !THIS.this_oBusinessObject.ChecaGrpVenda(loc_cCpros)
2551:                             SELECT cursor_4c_Itens
2552:                             REPLACE cpros WITH "", dpros WITH ""
2553:                             loc_lContinuar = .F.
2554:                         ENDIF
2555:                     ENDIF
2556: 
2557:                     IF loc_lContinuar
2558:                         *-- Buscar produto no catalogo e pre-preencher campos da linha
2559:                         loc_cSQL = "SELECT cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
2560:                                    " FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
2561:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro")
2562: 
2563:                         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldPro") > 0
2564:                             SELECT cursor_4c_Itens
2565:                             REPLACE dpros WITH ALLTRIM(cursor_4c_VldPro.dpros)
2566:                             IF EMPTY(ALLTRIM(TratarNulo(moevs, "C")))
2567:                                 REPLACE moevs WITH ALLTRIM(cursor_4c_VldPro.moevs)
2568:                             ENDIF
2569:                             IF EMPTY(ALLTRIM(TratarNulo(cgrus, "C")))
2570:                                 REPLACE cgrus WITH ALLTRIM(cursor_4c_VldPro.cgrus)
2571:                             ENDIF
2572:                             IF THIS.this_cCompVenda = "C"
2573:                                 *-- Modo compra: custo atual + reffs + ean
2574:                                 IF TratarNulo(pcuss, "N") = 0
2575:                                     REPLACE pcuss WITH TratarNulo(cursor_4c_VldPro.pcuss, "N")
2576:                                 ENDIF
2577:                                 IF EMPTY(ALLTRIM(TratarNulo(reffs, "C")))
2578:                                     REPLACE reffs WITH ALLTRIM(cursor_4c_VldPro.reffs)
2579:                                 ENDIF

*-- Linhas 2585 a 2651:
2585:                                 IF TratarNulo(pvens, "N") = 0
2586:                                     REPLACE pvens WITH TratarNulo(cursor_4c_VldPro.pvens, "N")
2587:                                 ENDIF
2588:                             ENDIF
2589:                         ELSE
2590:                             SELECT cursor_4c_Itens
2591:                             REPLACE dpros WITH ""
2592:                         ENDIF
2593: 
2594:                         IF USED("cursor_4c_VldPro")
2595:                             USE IN cursor_4c_VldPro
2596:                         ENDIF
2597:                     ENDIF
2598:                 ENDIF
2599:             ENDIF
2600: 
2601:         CATCH TO loException
2602:             MsgErro("Erro na grade (col " + TRANSFORM(par_nColIndex) + "):" + ;
2603:                     CHR(13) + loException.Message, "FormLpr.GradeAfterRowColChange")
2604:         ENDTRY
2605:     ENDPROC
2606: 
2607:     *==========================================================================
2608:     * CarregarLista - Carrega lista de SigCdLpc no Grid da Page1
2609:     * Chama Buscar() no BO com filtro de CompVenda e opcoes de vencimento
2610:     *==========================================================================
2611:     PROCEDURE CarregarLista()
2612:         LOCAL loc_lResultado, loc_oGrid, loc_nFiltroVenc
2613:         loc_lResultado  = .F.
2614:         loc_nFiltroVenc = 1
2615: 
2616:         TRY
2617:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2618:                 loc_lResultado = .T.
2619:             ELSE
2620:                 IF THIS.this_oBusinessObject.Buscar(THIS.this_cCompVenda)
2621: 
2622:                     *-- Ler filtro de vencimento (1=Todos, 2=A Vencer, 3=Vencidos)
2623:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
2624:                         loc_nFiltroVenc = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Vencimento.Value
2625:                     ENDIF
2626: 
2627:                     IF USED("cursor_4c_Dados")
2628:                         SELECT cursor_4c_Dados
2629:                         DO CASE
2630:                             CASE loc_nFiltroVenc = 2
2631:                                 SET FILTER TO vencis >= DATE()
2632:                             CASE loc_nFiltroVenc = 3
2633:                                 SET FILTER TO !EMPTY(vencis) AND vencis < DATE()
2634:                             OTHERWISE
2635:                                 SET FILTER TO
2636:                         ENDCASE
2637:                         GO TOP
2638:                     ENDIF
2639: 
2640:                     *-- Vincular grid: RecordSource -> ControlSources -> Headers
2641:                     *   VFP9 sobrescreve ControlSources e Headers ao trocar RecordSource
2642:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2643:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2644:                         IF USED("cursor_4c_Dados")
2645:                             loc_oGrid.ColumnCount = 4
2646:                             loc_oGrid.RecordSource = "cursor_4c_Dados"
2647:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.lprecos"
2648:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
2649:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
2650:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
2651:                             loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"

*-- Linhas 2675 a 3004:
2675:     *==========================================================================
2676:     * FormatarGridLista - Formata visual do grid da lista
2677:     *==========================================================================
2678:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2679:         WITH par_oGrid
2680:             .FontName = "Verdana"
2681:             .FontSize = 8
2682:         ENDWITH
2683:     ENDPROC
2684: 
2685:     *==========================================================================
2686:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2687:     * Containers flutuantes que devem iniciar ocultos sao pulados (mas seus
2688:     * filhos sao processados para que fiquem prontos ao serem exibidos).
2689:     *==========================================================================
2690:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2691:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
2692:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2693:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2694:             IF VARTYPE(loc_oObjeto) = "O"
2695:                 loc_cNome = UPPER(loc_oObjeto.Name)
2696: 
2697:                 *-- Containers flutuantes que iniciam ocultos no legado
2698:                 IF INLIST(loc_cNome, "CNT_4C_IMPLISTA", "CNT_4C_VENCIMENTOS", "CNT_4C_COMPRA")
2699:                     *-- Nao tornar visivel, mas processar filhos (ficam prontos para Show)
2700:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2701:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2702:                     ENDIF
2703:                     LOOP
2704:                 ENDIF
2705: 
2706:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2707:                     loc_oObjeto.Visible = .T.
2708:                 ENDIF
2709: 
2710:                 *-- PageFrame: iterar Pages
2711:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2712:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2713:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2714:                     ENDFOR
2715:                 ENDIF
2716: 
2717:                 *-- Containers: recursar nos filhos
2718:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2719:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2720:                 ENDIF
2721:             ENDIF
2722:         ENDFOR
2723:     ENDPROC
2724: 
2725:     *==========================================================================
2726:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe de itens)
2727:     * Ao voltar para Page1 (par_nPagina=1) recarrega a lista automaticamente
2728:     *==========================================================================
2729:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2730:         TRY
2731:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2732:             THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
2733:             IF par_nPagina = 1
2734:                 THIS.this_cPcEscolha    = ""
2735:                 THIS.this_cLprecosAtual = ""
2736:                 THIS.CarregarLista()
2737:             ELSE
2738:                 *-- Ir para Page2: preencher cabecalho e carregar itens da lista
2739:                 THIS.LimparCampos()
2740:                 IF THIS.this_cPcEscolha <> "INSERIR"
2741:                     THIS.BOParaForm()
2742:                 ELSE
2743:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ;
2744:                         ALLTRIM(go_4c_Sistema.cCodEmpresa)
2745:                 ENDIF
2746:                 THIS.CarregarItens(THIS.this_cLprecosAtual)
2747:                 THIS.HabilitarCampos(.T.)
2748:             ENDIF
2749:         CATCH TO loException
2750:             MsgErro("Erro: " + loException.Message, "FormLpr.AlternarPagina")
2751:         ENDTRY
2752:     ENDPROC
2753: 
2754:     *==========================================================================
2755:     * BtnIncluirClick - Inicia inclusao de nova lista de precos (vai para Page2)
2756:     *==========================================================================
2757:     PROCEDURE BtnIncluirClick()
2758:         TRY
2759:             THIS.this_cPcEscolha                         = "INSERIR"
2760:             THIS.this_cLprecosAtual                       = ""
2761:             THIS.this_oBusinessObject.this_lNovoRegistro  = .T.
2762:             THIS.this_oBusinessObject.this_cLprecos       = ""
2763:             THIS.AlternarPagina(2)
2764:         CATCH TO loException
2765:             MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "FormLpr.BtnIncluirClick")
2766:         ENDTRY
2767:     ENDPROC
2768: 
2769:     *==========================================================================
2770:     * BtnVisualizarClick - Visualiza lista selecionada em modo somente leitura
2771:     *==========================================================================
2772:     PROCEDURE BtnVisualizarClick()
2773:         LOCAL loc_cLprecos, loc_lOk
2774:         loc_cLprecos = ""
2775:         loc_lOk      = .F.
2776: 
2777:         TRY
2778:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2779:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2780:                 SELECT cursor_4c_Dados
2781:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2782:                 loc_lOk = .T.
2783:             ENDIF
2784: 
2785:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2786:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2787:                     THIS.this_cPcEscolha    = "PROCURAR"
2788:                     THIS.this_cLprecosAtual = loc_cLprecos
2789:                     THIS.AlternarPagina(2)
2790:                 ENDIF
2791:             ELSE
2792:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2793:             ENDIF
2794:         CATCH TO loException
2795:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "FormLpr.BtnVisualizarClick")
2796:         ENDTRY
2797:     ENDPROC
2798: 
2799:     *==========================================================================
2800:     * BtnAlterarClick - Altera lista selecionada
2801:     * Se flags=1 (ja publicada), pede confirmacao antes de prosseguir
2802:     *==========================================================================
2803:     PROCEDURE BtnAlterarClick()
2804:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
2805:         loc_cLprecos    = ""
2806:         loc_nFlags      = 0
2807:         loc_lOk         = .F.
2808:         loc_lProsseguir = .T.
2809: 
2810:         TRY
2811:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2812:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2813:                 SELECT cursor_4c_Dados
2814:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2815:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2816:                 loc_lOk = .T.
2817:             ENDIF
2818: 
2819:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2820:                 IF loc_nFlags = 1
2821:                     loc_lProsseguir = MsgConfirma("Esta lista j" + CHR(225) + ;
2822:                         " foi atualizada no sistema." + CHR(13) + ;
2823:                         "Deseja alterar mesmo assim?", "Aten" + CHR(231) + CHR(227) + "o")
2824:                 ENDIF
2825: 
2826:                 IF loc_lProsseguir
2827:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2828:                         THIS.this_cPcEscolha    = "ALTERAR"
2829:                         THIS.this_cLprecosAtual = loc_cLprecos
2830:                         THIS.AlternarPagina(2)
2831:                     ENDIF
2832:                 ENDIF
2833:             ELSE
2834:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2835:             ENDIF
2836:         CATCH TO loException
2837:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "FormLpr.BtnAlterarClick")
2838:         ENDTRY
2839:     ENDPROC
2840: 
2841:     *==========================================================================
2842:     * BtnExcluirClick - Exclui lista selecionada
2843:     * Bloqueia exclusao se lista ja foi publicada (flags=1)
2844:     *==========================================================================
2845:     PROCEDURE BtnExcluirClick()
2846:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk
2847:         loc_cLprecos = ""
2848:         loc_nFlags   = 0
2849:         loc_lOk      = .F.
2850: 
2851:         TRY
2852:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2853:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2854:                 SELECT cursor_4c_Dados
2855:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2856:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2857:                 loc_lOk = .T.
2858:             ENDIF
2859: 
2860:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2861:                 IF loc_nFlags = 1
2862:                     MsgErro("Lista j" + CHR(225) + " atualizada no sistema." + CHR(13) + ;
2863:                             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
2864:                             "vel excluir!", "Aviso")
2865:                 ELSE
2866:                     IF MsgConfirma("Confirma exclus" + CHR(227) + "o da lista [" + ;
2867:                                    loc_cLprecos + "]?", "Confirmar")
2868:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
2869:                             IF THIS.this_oBusinessObject.Excluir()
2870:                                 MsgInfo("Lista exclu" + CHR(237) + "da com sucesso!", "")
2871:                                 THIS.CarregarLista()
2872:                             ENDIF
2873:                         ENDIF
2874:                     ENDIF
2875:                 ENDIF
2876:             ELSE
2877:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2878:             ENDIF
2879:         CATCH TO loException
2880:             MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "FormLpr.BtnExcluirClick")
2881:         ENDTRY
2882:     ENDPROC
2883: 
2884:     *==========================================================================
2885:     * BtnBuscarClick - Recarrega a lista (equivalente a bnt_Busca do legado)
2886:     *==========================================================================
2887:     PROCEDURE BtnBuscarClick()
2888:         TRY
2889:             THIS.CarregarLista()
2890:         CATCH TO loException
2891:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormLpr.BtnBuscarClick")
2892:         ENDTRY
2893:     ENDPROC
2894: 
2895:     *==========================================================================
2896:     * BtnEncerrarClick - Fecha o formulario
2897:     *==========================================================================
2898:     PROCEDURE BtnEncerrarClick()
2899:         TRY
2900:             THIS.Release()
2901:         CATCH TO loException
2902:             MsgErro("Erro ao encerrar:" + CHR(13) + loException.Message, "FormLpr.BtnEncerrarClick")
2903:         ENDTRY
2904:     ENDPROC
2905: 
2906:     *==========================================================================
2907:     * BtnAtualizarClick - Publica a lista selecionada no sistema (flags=1)
2908:     * Avisa se lista ja foi publicada e pede confirmacao antes de repetir
2909:     *==========================================================================
2910:     PROCEDURE BtnAtualizarClick()
2911:         LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
2912:         loc_cLprecos    = ""
2913:         loc_nFlags      = 0
2914:         loc_lOk         = .F.
2915:         loc_lProsseguir = .T.
2916: 
2917:         TRY
2918:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
2919:                !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
2920:                 SELECT cursor_4c_Dados
2921:                 loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
2922:                 loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
2923:                 loc_lOk = .T.
2924:             ENDIF
2925: 
2926:             IF loc_lOk AND !EMPTY(loc_cLprecos)
2927:                 IF loc_nFlags = 1
2928:                     loc_lProsseguir = MsgConfirma("Lista j" + CHR(225) + ;
2929:                         " atualizada no sistema." + CHR(13) + ;
2930:                         "Deseja atualizar novamente?", "Confirmar")
2931:                 ENDIF
2932: 
2933:                 IF loc_lProsseguir
2934:                     IF THIS.this_oBusinessObject.AtualizarFlags(loc_cLprecos)
2935:                         MsgInfo("Lista [" + loc_cLprecos + "] atualizada com sucesso!", "")
2936:                         THIS.CarregarLista()
2937:                     ENDIF
2938:                 ENDIF
2939:             ELSE
2940:                 MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
2941:             ENDIF
2942:         CATCH TO loException
2943:             MsgErro("Erro ao atualizar flags:" + CHR(13) + loException.Message, "FormLpr.BtnAtualizarClick")
2944:         ENDTRY
2945:     ENDPROC
2946: 
2947:     *==========================================================================
2948:     * BtnImprimirListaClick - Exibe ou oculta o painel de impressao (toggle)
2949:     *==========================================================================
2950:     PROCEDURE BtnImprimirListaClick()
2951:         TRY
2952:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista
2953:                 .Visible = !.Visible
2954:                 .Visible     = .T.
2955:             ENDWITH
2956:         CATCH TO loException
2957:             MsgErro("Erro ao exibir impressao:" + CHR(13) + loException.Message, "FormLpr.BtnImprimirListaClick")
2958:         ENDTRY
2959:     ENDPROC
2960: 
2961:     *==========================================================================
2962:     * FiltroVencimentoChanged - Recarrega lista ao alterar o filtro de vencimento
2963:     *==========================================================================
2964:     PROCEDURE FiltroVencimentoChanged()
2965:         TRY
2966:             THIS.CarregarLista()
2967:         CATCH TO loException
2968:             MsgErro("Erro ao filtrar:" + CHR(13) + loException.Message, "FormLpr.FiltroVencimentoChanged")
2969:         ENDTRY
2970:     ENDPROC
2971: 
2972:     *==========================================================================
2973:     * MontarRelatorio - Monta cursor_4c_Relatorio para impressao de listas
2974:     * par_nTipo: 1=Vendas, 2=Compras, 3=Analise, 4=Embalagem
2975:     * Retorna .T. se cursor montado com dados
2976:     *==========================================================================
2977:     PROTECTED FUNCTION MontarRelatorio(par_nTipo)
2978:         LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cFiltroTipo
2979:         loc_lSucesso    = .F.
2980:         loc_cFiltroTipo = ""
2981: 
2982:         TRY
2983:             IF USED("cursor_4c_Relatorio")
2984:                 USE IN cursor_4c_Relatorio
2985:             ENDIF
2986: 
2987:             DO CASE
2988:                 CASE par_nTipo = 1
2989:                     loc_cFiltroTipo = " AND b.tipos = ' '"
2990:                 CASE par_nTipo = 2
2991:                     loc_cFiltroTipo = " AND b.tipos = 'C'"
2992:                 OTHERWISE
2993:                     loc_cFiltroTipo = ""
2994:             ENDCASE
2995: 
2996:             loc_cSQL = "SELECT b.lprecos, b.fpags, b.vencis AS vencis_lista," + ;
2997:                        " b.flags, b.tipos," + ;
2998:                        " a.cpros, a.dpros, a.pvens, a.pcuss, a.moevs," + ;
2999:                        " a.comiss, a.vencis AS vencis_item, a.vencfs," + ;
3000:                        " a.cgrus, a.ean13, a.reffs, a.ordems, a.precode" + ;
3001:                        " FROM SigCdLpi a" + ;
3002:                        " INNER JOIN SigCdLpc b ON a.lprecos = b.lprecos" + ;
3003:                        " WHERE b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
3004:                        loc_cFiltroTipo + ;

*-- Linhas 3023 a 3393:
3023:     *==========================================================================
3024:     * BtnImpVideoClick - Visualiza relatorio de listas em video (PREVIEW)
3025:     *==========================================================================
3026:     PROCEDURE BtnImpVideoClick()
3027:         LOCAL loc_nTipo
3028:         loc_nTipo = 1
3029: 
3030:         TRY
3031:             loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3032:             IF THIS.MontarRelatorio(loc_nTipo)
3033:                 THIS.ExecutarReportForm("SigCdLpr", "PREVIEW", "cursor_4c_Relatorio")
3034:             ENDIF
3035:         CATCH TO loException
3036:             MsgErro("Erro ao visualizar relat" + CHR(243) + "rio:" + CHR(13) + ;
3037:                     loException.Message, "FormLpr.BtnImpVideoClick")
3038:         ENDTRY
3039:     ENDPROC
3040: 
3041:     *==========================================================================
3042:     * BtnImpImpressoraClick - Imprime relatorio de listas na impressora
3043:     *==========================================================================
3044:     PROCEDURE BtnImpImpressoraClick()
3045:         LOCAL loc_nTipo
3046:         loc_nTipo = 1
3047: 
3048:         TRY
3049:             loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3050:             IF THIS.MontarRelatorio(loc_nTipo)
3051:                 THIS.ExecutarReportForm("SigCdLpr", "PRINTER_PROMPT", "cursor_4c_Relatorio")
3052:             ENDIF
3053:         CATCH TO loException
3054:             MsgErro("Erro ao imprimir relat" + CHR(243) + "rio:" + CHR(13) + ;
3055:                     loException.Message, "FormLpr.BtnImpImpressoraClick")
3056:         ENDTRY
3057:     ENDPROC
3058: 
3059:     *==========================================================================
3060:     * BtnImpExcelClick - Exporta relatorio de listas para Excel (XLS)
3061:     *==========================================================================
3062:     PROCEDURE BtnImpExcelClick()
3063:         LOCAL loc_nTipo, loc_cArquivo
3064:         loc_nTipo    = 1
3065:         loc_cArquivo = ""
3066: 
3067:         TRY
3068:             loc_nTipo    = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
3069:             loc_cArquivo = gc_4c_CaminhoReports + "SigCdLpr.xls"
3070: 
3071:             IF THIS.MontarRelatorio(loc_nTipo)
3072:                 IF USED("cursor_4c_Relatorio")
3073:                     SELECT cursor_4c_Relatorio
3074:                     COPY TO (loc_cArquivo) TYPE XL5
3075:                     MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "")
3076:                 ENDIF
3077:             ENDIF
3078:         CATCH TO loException
3079:             MsgErro("Erro ao exportar Excel:" + CHR(13) + loException.Message, "FormLpr.BtnImpExcelClick")
3080:         ENDTRY
3081:     ENDPROC
3082: 
3083:     *==========================================================================
3084:     * BtnImpFecharClick - Oculta o painel de impressao cnt_4c_ImpLista
3085:     *==========================================================================
3086:     PROCEDURE BtnImpFecharClick()
3087:         TRY
3088:             THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.Visible = .F.
3089:         CATCH TO loException
3090:             MsgErro("Erro ao fechar painel:" + CHR(13) + loException.Message, "FormLpr.BtnImpFecharClick")
3091:         ENDTRY
3092:     ENDPROC
3093: 
3094:     *==========================================================================
3095:     * ValidarTabd - LostFocus do txt_4c_Tabd (Tabela de Desconto)
3096:     * Lookup em SigOpTdz por codigos
3097:     *==========================================================================
3098:     PROCEDURE ValidarTabd(par_nKeyCode, par_nShiftAltCtrl)
3099:         LOCAL loc_oPg2, loc_cTabd, loc_nResult
3100:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3101:         loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
3102: 
3103:         IF EMPTY(loc_cTabd)
3104:             RETURN
3105:         ENDIF
3106: 
3107:         TRY
3108:             LOCAL loc_cSQL
3109:             loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigOpTdz WHERE codigos = " + EscaparSQL(loc_cTabd)
3110:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTabd")
3111:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaTabd") = 0
3112:                 IF USED("cursor_4c_BuscaTabd")
3113:                     USE IN cursor_4c_BuscaTabd
3114:                 ENDIF
3115:                 THIS.AbrirBuscaTabd()
3116:             ELSE
3117:                 IF USED("cursor_4c_BuscaTabd")
3118:                     USE IN cursor_4c_BuscaTabd
3119:                 ENDIF
3120:             ENDIF
3121:         CATCH TO loException
3122:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarTabd")
3123:         ENDTRY
3124:     ENDPROC
3125: 
3126:     *==========================================================================
3127:     * AbrirBuscaTabd - Abre FormBuscaAuxiliar para selecionar Tabela de Desconto
3128:     *==========================================================================
3129:     PROCEDURE AbrirBuscaTabd()
3130:         LOCAL loc_oPg2, loc_oBusca, loc_cTabd
3131:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3132:         loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
3133: 
3134:         TRY
3135:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3136:                 "SigOpTdz", "cursor_4c_BuscaTabd", "codigos", loc_cTabd, ;
3137:                 "Tabelas de Desconto")
3138: 
3139:             IF VARTYPE(loc_oBusca) = "O"
3140:                 IF !loc_oBusca.this_lAchouRegistro
3141:                     loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
3142:                     loc_oBusca.mAddColuna("descrs",  "",           "Descri" + CHR(231) + CHR(227) + "o")
3143:                     loc_oBusca.Show()
3144:                 ENDIF
3145: 
3146:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
3147:                     SELECT cursor_4c_BuscaTabd
3148:                     loc_oPg2.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
3149:                 ELSE
3150:                     IF !loc_oBusca.this_lAchouRegistro
3151:                         loc_oPg2.txt_4c_Tabd.Value = ""
3152:                     ENDIF
3153:                 ENDIF
3154:                 loc_oBusca.Release()
3155:             ENDIF
3156: 
3157:             IF USED("cursor_4c_BuscaTabd")
3158:                 USE IN cursor_4c_BuscaTabd
3159:             ENDIF
3160: 
3161:         CATCH TO loException
3162:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaTabd")
3163:         ENDTRY
3164:     ENDPROC
3165: 
3166:     *==========================================================================
3167:     * TeclaTabd - KeyPress do txt_4c_Tabd
3168:     * F4/F5: abre lookup. ENTER/TAB: valida.
3169:     *==========================================================================
3170:     PROCEDURE TeclaTabd(par_nKeyCode, par_nShiftAltCtrl)
3171:         IF INLIST(par_nKeyCode, 115, 116)
3172:             THIS.AbrirBuscaTabd()
3173:         ELSE
3174:             IF INLIST(par_nKeyCode, 13, 9)
3175:             THIS.ValidarTabd()
3176:             ENDIF
3177:         ENDIF
3178:     ENDPROC
3179: 
3180:     *==========================================================================
3181:     * ValidarGetConta - LostFocus do txt_4c_GetConta (Fornecedor, modo compra)
3182:     * Lookup em SigCdCli por iclis; preenche txt_4c_GetDconta automaticamente
3183:     *==========================================================================
3184:     PROCEDURE ValidarGetConta(par_nKeyCode, par_nShiftAltCtrl)
3185:         LOCAL loc_oPg2, loc_oCnt, loc_cConta, loc_nResult
3186:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3187:         loc_oCnt   = loc_oPg2.cnt_4c_Compra
3188:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)
3189: 
3190:         IF EMPTY(loc_cConta)
3191:             loc_oCnt.txt_4c_GetDconta.Value = ""
3192:             RETURN
3193:         ENDIF
3194: 
3195:         TRY
3196:             LOCAL loc_cSQL
3197:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
3198:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaForns")
3199:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaForns") > 0
3200:                 SELECT cursor_4c_BuscaForns
3201:                 loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3202:             ELSE
3203:                 IF USED("cursor_4c_BuscaForns")
3204:                     USE IN cursor_4c_BuscaForns
3205:                 ENDIF
3206:                 THIS.AbrirBuscaGetConta()
3207:             ENDIF
3208:             IF USED("cursor_4c_BuscaForns")
3209:                 USE IN cursor_4c_BuscaForns
3210:             ENDIF
3211:         CATCH TO loException
3212:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetConta")
3213:         ENDTRY
3214:     ENDPROC
3215: 
3216:     *==========================================================================
3217:     * AbrirBuscaGetConta - Abre FormBuscaAuxiliar para selecionar Fornecedor
3218:     * (modo compra - campo GetConta de cnt_4c_Compra)
3219:     *==========================================================================
3220:     PROCEDURE AbrirBuscaGetConta()
3221:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cConta
3222:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3223:         loc_oCnt   = loc_oPg2.cnt_4c_Compra
3224:         loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)
3225: 
3226:         TRY
3227:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3228:                 "SigCdCli", "cursor_4c_BuscaForns", "iclis", loc_cConta, ;
3229:                 "Fornecedor")
3230: 
3231:             IF VARTYPE(loc_oBusca) = "O"
3232:                 IF !loc_oBusca.this_lAchouRegistro
3233:                     loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
3234:                     loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
3235:                     loc_oBusca.Show()
3236:                 ENDIF
3237: 
3238:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3239:                     SELECT cursor_4c_BuscaForns
3240:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3241:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3242:                 ELSE
3243:                     IF !loc_oBusca.this_lAchouRegistro
3244:                         loc_oCnt.txt_4c_GetConta.Value  = ""
3245:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3246:                     ENDIF
3247:                 ENDIF
3248:                 loc_oBusca.Release()
3249:             ENDIF
3250: 
3251:             IF USED("cursor_4c_BuscaForns")
3252:                 USE IN cursor_4c_BuscaForns
3253:             ENDIF
3254: 
3255:         CATCH TO loException
3256:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetConta")
3257:         ENDTRY
3258:     ENDPROC
3259: 
3260:     *==========================================================================
3261:     * TeclaGetConta - KeyPress do txt_4c_GetConta (Fornecedor modo compra)
3262:     * F4/F5: abre lookup. ENTER/TAB: valida.
3263:     *==========================================================================
3264:     PROCEDURE TeclaGetConta(par_nKeyCode, par_nShiftAltCtrl)
3265:         IF INLIST(par_nKeyCode, 115, 116)
3266:             THIS.AbrirBuscaGetConta()
3267:         ELSE
3268:             IF INLIST(par_nKeyCode, 13, 9)
3269:             THIS.ValidarGetConta()
3270:             ENDIF
3271:         ENDIF
3272:     ENDPROC
3273: 
3274:     *==========================================================================
3275:     * ValidarGetDconta - LostFocus do txt_4c_GetDconta (Descricao Fornecedor)
3276:     * Ativo apenas quando txt_4c_GetConta estiver vazio (busca por nome)
3277:     *==========================================================================
3278:     PROCEDURE ValidarGetDconta(par_nKeyCode, par_nShiftAltCtrl)
3279:         LOCAL loc_oPg2, loc_oCnt
3280:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3281:         loc_oCnt = loc_oPg2.cnt_4c_Compra
3282: 
3283:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetConta.Value))
3284:             RETURN
3285:         ENDIF
3286: 
3287:         IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value))
3288:             RETURN
3289:         ENDIF
3290: 
3291:         TRY
3292:             THIS.AbrirBuscaGetDconta()
3293:         CATCH TO loException
3294:             MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetDconta")
3295:         ENDTRY
3296:     ENDPROC
3297: 
3298:     *==========================================================================
3299:     * AbrirBuscaGetDconta - Abre FormBuscaAuxiliar para Fornecedor por descricao
3300:     *==========================================================================
3301:     PROCEDURE AbrirBuscaGetDconta()
3302:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cDconta
3303:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3304:         loc_oCnt    = loc_oPg2.cnt_4c_Compra
3305:         loc_cDconta = ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value)
3306: 
3307:         TRY
3308:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3309:                 "SigCdCli", "cursor_4c_BuscaForns", "rclis", loc_cDconta, ;
3310:                 "Fornecedor")
3311: 
3312:             IF VARTYPE(loc_oBusca) = "O"
3313:                 IF !loc_oBusca.this_lAchouRegistro
3314:                     loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
3315:                     loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
3316:                     loc_oBusca.Show()
3317:                 ENDIF
3318: 
3319:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
3320:                     SELECT cursor_4c_BuscaForns
3321:                     loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
3322:                     loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
3323:                 ELSE
3324:                     IF !loc_oBusca.this_lAchouRegistro
3325:                         loc_oCnt.txt_4c_GetDconta.Value = ""
3326:                     ENDIF
3327:                 ENDIF
3328:                 loc_oBusca.Release()
3329:             ENDIF
3330: 
3331:             IF USED("cursor_4c_BuscaForns")
3332:                 USE IN cursor_4c_BuscaForns
3333:             ENDIF
3334: 
3335:         CATCH TO loException
3336:             MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetDconta")
3337:         ENDTRY
3338:     ENDPROC
3339: 
3340:     *==========================================================================
3341:     * TeclaGetDconta - KeyPress do txt_4c_GetDconta (Descricao Fornecedor)
3342:     * F4/F5/ENTER/TAB: abre lookup por nome.
3343:     *==========================================================================
3344:     PROCEDURE TeclaGetDconta(par_nKeyCode, par_nShiftAltCtrl)
3345:         IF INLIST(par_nKeyCode, 115, 116, 13, 9)
3346:             THIS.AbrirBuscaGetDconta()
3347:         ENDIF
3348:     ENDPROC
3349: 
3350:     *==========================================================================
3351:     * Destroy - Libera recursos ao fechar o formulario
3352:     *==========================================================================
3353:     PROCEDURE Destroy()
3354:         TRY
3355:             *-- Restaurar decimais originais
3356:             IF THIS.this_nOldCasas > 0
3357:                 SET DECIMALS TO (THIS.this_nOldCasas)
3358:             ENDIF
3359: 
3360:             *-- Liberar Business Object
3361:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3362:                 THIS.this_oBusinessObject = .NULL.
3363:             ENDIF
3364: 
3365:             *-- Fechar cursores de trabalho
3366:             IF USED("cursor_4c_Dados")
3367:                 USE IN cursor_4c_Dados
3368:             ENDIF
3369:             IF USED("cursor_4c_Itens")
3370:                 USE IN cursor_4c_Itens
3371:             ENDIF
3372:             IF USED("cursor_4c_ItensCopia")
3373:                 USE IN cursor_4c_ItensCopia
3374:             ENDIF
3375:             IF USED("cursor_4c_BuscaProd")
3376:                 USE IN cursor_4c_BuscaProd
3377:             ENDIF
3378:             IF USED("cursor_4c_BuscaMoe")
3379:                 USE IN cursor_4c_BuscaMoe
3380:             ENDIF
3381:             IF USED("cursor_4c_BuscaFpg")
3382:                 USE IN cursor_4c_BuscaFpg
3383:             ENDIF
3384:             IF USED("cursor_4c_BuscaTabd")
3385:                 USE IN cursor_4c_BuscaTabd
3386:             ENDIF
3387:             IF USED("cursor_4c_Relatorio")
3388:                 USE IN cursor_4c_Relatorio
3389:             ENDIF
3390: 
3391:         CATCH TO loException
3392:             MsgErro("Erro: " + loException.Message, "FormLpr.Destroy")
3393:         ENDTRY


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

