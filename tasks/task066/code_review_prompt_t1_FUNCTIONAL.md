# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECNT): Top original=126 vs migrado 'lbl_4c_Label2' Top=41 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGRECNT): Top original=98 vs migrado 'lbl_4c_Label3' Top=13 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGRECNT): Top original=228 vs migrado 'lbl_4c_Label4' Top=143 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGRECNT): Top original=178 vs migrado 'lbl_4c_Lbl_estoque' Top=93 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECNT): Top original=99 vs migrado 'lbl_4c_Label1' Top=14 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Top original=223 vs migrado 'obj_4c_OptLocal' Top=5 (diff=218px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Left original=252 vs migrado 'obj_4c_OptLocal' Left=5 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_codigo' (parent: SIGRECNT): Top original=204 vs migrado 'lbl_4c_Lbl_codigo' Top=119 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1684 linhas total):

*-- Linhas 6 a 189:
6: *
7: * FASE 3/8 - Form - Estrutura Base
8: *   * Propriedades visuais do form (Width=800, Height=330)
9: *   * Init() / InicializarForm() / Destroy()
10: *   * ConfigurarCabecalho()  (cabecalho escuro com titulo)
11: *   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
12: *   * ConfigurarPageFrame()  (PageFrame com 1 pagina - "Filtros")
13: * FASE 4/8 - Form - Filtros na Page1 (equivalente da fase CRUD "Grid + Botoes")
14: *   * ConfigurarPaginaLista() (todos os controles de filtro do SIGRECNT)
15: *       Em forms CRUD esta fase adiciona o grid e botoes na Page1 (Lista).
16: *       Forms REPORT NAO tem grid CRUD nem botoes Incluir/Alterar/Excluir.
17: *       O equivalente eh a pagina unica de filtros - mantido nome padrao
18: *       (ConfigurarPaginaLista) para compatibilidade com pipeline multi-fase.
19: *   * AlternarPagina()        (stub - form REPORT tem pagina unica)
20: *   * Inicializacao txt_4c_Datas.Value = DATE() no InicializarForm
21: * FASE 5/8 - Form - Campos principais parte 1
22: *   * Linha 2: Vendedor (txt_4c_Conta + txt_4c_DConta)
23: *   * Linha 3: Grupo Estoque (txt_4c_Cd_GrEstoque + txt_4c_Ds_GrEstoque)
24: * FASE 6/8 - Form - Campos restantes e lookups
25: *   * Linha 4: Conta Estoque (txt_4c_Cd_Estoque + txt_4c_Ds_Estoque)
26: *   * Linha 5: Produto (txt_4c__Produto + txt_4c__descricao)
27: *   * Linha 6: Localizacoes (obj_4c_OptLocal)
28: *   * ConfigurarPaginaDados() - todos os BINDEVENTs de teclado e lookup
29: *   * Todos os handlers: Vendedor, GrEstoque, Estoque, Produto
30: * FASE 7/8 - Form - Eventos principais
31: *   * BtnVisualizarClick() - preview em tela (REPORT FORM ... PREVIEW)
32: *   * BtnImprimirClick()   - impressora com dialogo (REPORT FORM ... TO PRINT PROMPT)
33: *   * BtnExcelClick()      - exportar para Excel (RelatorioBase.GerarExcel)
34: *   * BtnEncerrarClick()   - fechar formulario
35: * FASE 8/8 - Form - Eventos auxiliares e consolidacao final
36: *   * CarregarLista()      - stub compatibilidade pipeline (REPORT sem grid CRUD)
37: *   * HabilitarCampos()    - habilita/desabilita todos os filtros do form
38: *   * AjustarBotoesPorModo() - stub compatibilidade pipeline (REPORT sem modos CRUD)
39: *   * FormParaBO()         - wrapper de compatibilidade -> delega FormParaRelatorio()
40: *   * BOParaForm()         - carrega propriedades do BO de volta nos controles
41: *   * BtnBuscarClick()     - REPORT: dispara Visualizar (preview)
42: *   * BtnSalvarClick()     - REPORT: dispara Imprimir (imprime sem dialogo)
43: *   * BtnCancelarClick()   - REPORT: limpa todos os filtros (LimparCampos)
44: *==============================================================================
45: 
46: DEFINE CLASS Formsigrecrf AS FormBase
47: 
48:     *-- Dimensoes e aparencia (Width=800 exato do original, Height expandido para header+filtros)
49:     Height      = 330
50:     Width       = 800
51:     DataSession = 2
52:     ShowWindow  = 1
53:     WindowType  = 1
54:     AutoCenter  = .T.
55:     BorderStyle = 2
56:     ControlBox  = .F.
57:     MaxButton   = .F.
58:     MinButton   = .F.
59:     TitleBar    = 0
60:     Themes      = .F.
61:     ShowTips    = .T.
62: 
63:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
64:     this_oRelatorio    = .NULL.
65:     this_cMensagemErro = ""
66: 
67:     *--------------------------------------------------------------------------
68:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
69:     *--------------------------------------------------------------------------
70:     PROCEDURE Init()
71:         RETURN DODEFAULT()
72:     ENDPROC
73: 
74:     *--------------------------------------------------------------------------
75:     * InicializarForm - Cria estrutura base do formulario de relatorio
76:     *   1. Define Caption / Picture (fundo)
77:     *   2. Cria sigrecrfBO e valida GrPadVens (pula em modo UI)
78:     *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame
79:     *--------------------------------------------------------------------------
80:     PROTECTED PROCEDURE InicializarForm()
81:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
82:         loc_lSucesso   = .F.
83:         loc_lContinuar = .T.
84:         TRY
85:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
86:                            "Refer" + CHR(234) + "ncia"
87: 
88:             IF TYPE("gc_4c_CaminhoIcones") = "U"
89:                 gc_4c_CaminhoIcones = ""
90:             ENDIF
91:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92: 
93:             *-- Instanciar BO de relatorio
94:             THIS.this_oRelatorio = CREATEOBJECT("sigrecrfBO")
95:             IF VARTYPE(THIS.this_oRelatorio) != "O"
96:                 MsgErro("Erro ao criar sigrecrfBO" + CHR(13) + ;
97:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
98:                 loc_lContinuar = .F.
99:             ENDIF
100: 
101:             *-- Validar GrPadVens carregado pelo BO (pula em modo UI sem conexao SQL)
102:             IF loc_lContinuar AND ;
103:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
104:                 IF EMPTY(THIS.this_oRelatorio.this_cGrPadVens)
105:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
106:                     loc_lContinuar = .F.
107:                 ENDIF
108:             ENDIF
109: 
110:             IF loc_lContinuar
111:                 *-- Cabecalho escuro com titulo (equivalente a cntSombra)
112:                 THIS.ConfigurarCabecalho()
113: 
114:                 *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
115:                 THIS.ConfigurarBotoes()
116: 
117:                 *-- PageFrame com pagina de filtros
118:                 THIS.ConfigurarPageFrame()
119: 
120:                 *-- Vincular eventos BINDEVENT dos campos de filtro
121:                 THIS.ConfigurarPaginaDados()
122: 
123:                 *-- Visibilidade opcoes OptLocal por permissao de acesso
124:                 THIS.ConfigurarPermissoesOptLocal()
125: 
126:                 *-- Inicializar filtros com valores padrao (data = hoje)
127:                 THIS.LimparCampos()
128: 
129:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
130:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
131: 
132:                 THIS.Visible = .T.
133:                 loc_lSucesso = .T.
134:             ENDIF
135:         CATCH TO loc_oErro
136:             THIS.this_cMensagemErro = loc_oErro.Message
137:             MsgErro(loc_oErro.Message + CHR(13) + ;
138:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
139:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
140:         ENDTRY
141:         RETURN loc_lSucesso
142:     ENDPROC
143: 
144:     *--------------------------------------------------------------------------
145:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
146:     *   Equivalente ao cntSombra do frmrelatorio legado.
147:     *   Largura = Width do form (cobre toda a faixa superior).
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarCabecalho()
150:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH THIS.cnt_4c_Cabecalho
152:             .Top         = 0
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 80
156:             .BackStyle   = 1
157:             .BackColor   = RGB(100, 100, 100)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160: 
161:             *-- Sombra deslocada 2px para efeito 3D do texto branco
162:             .AddObject("lbl_4c_Sombra", "Label")
163:             WITH .lbl_4c_Sombra
164:                 .Top       = 22
165:                 .Left      = 22
166:                 .Width     = THIS.Width
167:                 .Height    = 30
168:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
169:                              "Refer" + CHR(234) + "ncia"
170:                 .FontName  = "Tahoma"
171:                 .FontSize  = 14
172:                 .FontBold  = .T.
173:                 .ForeColor = RGB(0, 0, 0)
174:                 .BackStyle = 0
175:                 .Visible   = .T.
176:             ENDWITH
177: 
178:             *-- Titulo em branco (sobre a sombra)
179:             .AddObject("lbl_4c_Titulo", "Label")
180:             WITH .lbl_4c_Titulo
181:                 .Top       = 20
182:                 .Left      = 20
183:                 .Width     = THIS.Width
184:                 .Height    = 30
185:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
186:                              "Refer" + CHR(234) + "ncia"
187:                 .FontName  = "Tahoma"
188:                 .FontSize  = 14
189:                 .FontBold  = .T.

*-- Linhas 200 a 243:
200:     *   Botoes: Visualizar(6), Imprimir(72), DocExcel(138), Sair(204) - W=65
201:     *   Eventos Click vinculados em ConfigurarPaginaDados (Fase 7/8).
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarBotoes()
204:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
205:         WITH THIS.cmg_4c_Botoes
206:             .Top           = 0
207:             .Left          = 529
208:             .Width         = 273
209:             .Height        = 80
210:             .ButtonCount   = 4
211:             .BackStyle     = 0
212:             .BorderStyle   = 0
213:             .BorderColor   = RGB(136, 189, 188)
214:             .SpecialEffect = 1
215:             .Themes        = .F.
216:             .Visible       = .T.
217: 
218:             *-- Visualizar (preview em tela)
219:             WITH .Buttons(1)
220:                 .Top             = 5
221:                 .Left            = 5
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Visualizar"
225:                 .FontBold        = .T.
226:                 .FontItalic      = .T.
227:                 .BackColor       = RGB(255, 255, 255)
228:                 .ForeColor       = RGB(90, 90, 90)
229:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
230:                 .PicturePosition = 13
231:                 .SpecialEffect   = 0
232:                 .MousePointer    = 15
233:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
234:                 .Themes          = .F.
235:                 .Visible         = .T.
236:             ENDWITH
237: 
238:             *-- Imprimir (impressora com dialogo)
239:             WITH .Buttons(2)
240:                 .Top             = 5
241:                 .Left            = 71
242:                 .Width           = 65
243:                 .Height          = 70

*-- Linhas 309 a 398:
309:     *   Form REPORT FLAT: controles de filtro sao adicionados em Page1
310:     *   nas fases seguintes (4-6). Posicionado logo abaixo do cabecalho.
311:     *--------------------------------------------------------------------------
312:     PROTECTED PROCEDURE ConfigurarPageFrame()
313:         LOCAL loc_oPgf
314: 
315:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
316:         loc_oPgf = THIS.pgf_4c_Paginas
317: 
318:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
319:         loc_oPgf.PageCount = 1
320: 
321:         loc_oPgf.Top    = 85
322:         loc_oPgf.Left   = -1
323:         loc_oPgf.Width  = THIS.Width + 2
324:         loc_oPgf.Height = THIS.Height - 85
325:         loc_oPgf.Tabs   = .F.
326: 
327:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
328:         loc_oPgf.Page1.Caption   = "Filtros"
329:         loc_oPgf.Page1.FontName  = "Tahoma"
330:         loc_oPgf.Page1.FontSize  = 8
331:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
332:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
333:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
334: 
335:         *-- Adicionar controles de filtro na Page1
336:         THIS.ConfigurarPaginaLista()
337: 
338:         loc_oPgf.Visible    = .T.
339:         loc_oPgf.ActivePage = 1
340:     ENDPROC
341: 
342:     *--------------------------------------------------------------------------
343:     * ConfigurarPaginaLista - Adiciona todos os controles de filtro na Page1
344:     *   FORM REPORT: a "Page1" eh a unica pagina e contem todos os filtros.
345:     *   Nome do metodo mantem padrao "ConfigurarPaginaLista" para compatibilidade
346:     *   com o pipeline multi-fase (validador da Fase 4 exige este nome). Em forms
347:     *   CRUD esta seria a pagina de Lista; aqui eh a pagina de Filtros do REPORT.
348:     *
349:     *   Migrado do layout flat do SIGRECNT (form de 800x269).
350:     *   Posicoes top = original - 85 (PageFrame.Top=85).
351:     *   Linha 1: Data (txt_4c_Datas) + Codigo referencia (txt_4c_Codigo)
352:     *   Linha 2: Vendedor - codigo (txt_4c_Conta) + descricao (txt_4c_DConta)
353:     *   Linha 3: Grupo Estoque - cod (txt_4c_Cd_GrEstoque) + ds (txt_4c_Ds_GrEstoque)
354:     *   Linha 4: Conta Estoque - cod (txt_4c_Cd_Estoque) + ds (txt_4c_Ds_Estoque)
355:     *   Linha 5: Produto - cod (txt_4c__Produto) + ds (txt_4c__descricao)
356:     *   Linha 6: Localizacoes label + obj_4c_OptLocal (OptionGroup 4 botoes)
357:     *--------------------------------------------------------------------------
358:     PROTECTED PROCEDURE ConfigurarPaginaLista()
359:         LOCAL loc_oPagina
360:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
361: 
362:         *--------------------------------------------------------------------
363:         *-- Linha 1: Data e Codigo de referencia
364:         *   Original: Label1.top=99 GetDatas.top=95 Label3.top=98 GetCods.top=94
365:         *--------------------------------------------------------------------
366:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
367:         WITH loc_oPagina.lbl_4c_Label1
368:             .Top       = 14
369:             .Left      = 220
370:             .Width     = 32
371:             .Height    = 15
372:             .Caption   = "Data :"
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .BackStyle = 0
376:             .ForeColor = RGB(90, 90, 90)
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
381:         WITH loc_oPagina.txt_4c_Datas
382:             .Top           = 10
383:             .Left          = 256
384:             .Width         = 80
385:             .Height        = 24
386:             .Value         = {}
387:             .Alignment     = 3
388:             .FontName      = "Tahoma"
389:             .FontSize      = 8
390:             .ForeColor     = RGB(0, 0, 0)
391:             .BackColor     = RGB(255, 255, 255)
392:             .SpecialEffect = 1
393:             .Visible       = .T.
394:         ENDWITH
395: 
396:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
397:         WITH loc_oPagina.lbl_4c_Label3
398:             .Top       = 13

*-- Linhas 634 a 696:
634:         ENDWITH
635: 
636:         *--------------------------------------------------------------------
637:         *-- Linha 6: Localizacoes - label + OptionGroup 4 opcoes
638:         *   Original: Label4.top=228 OptLocal.top=223 Width=347 Height=26
639:         *   btnReport.Click verifica Value <> 4 para exigir data
640:         *   Opcao 4 = relatorio sem exigencia de data
641:         *--------------------------------------------------------------------
642:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
643:         WITH loc_oPagina.lbl_4c_Label4
644:             .Top       = 143
645:             .Left      = 184
646:             .Width     = 68
647:             .Height    = 15
648:             .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
649:             .FontName  = "Tahoma"
650:             .FontSize  = 8
651:             .BackStyle = 0
652:             .ForeColor = RGB(90, 90, 90)
653:             .Visible   = .T.
654:         ENDWITH
655: 
656:         loc_oPagina.AddObject("obj_4c_OptLocal", "OptionGroup")
657:         WITH loc_oPagina.obj_4c_OptLocal
658:             .Top         = 138
659:             .Left        = 252
660:             .Width       = 347
661:             .Height      = 26
662:             .ButtonCount = 4
663:             .BackStyle   = 0
664:             .BorderStyle = 0
665:             .Visible     = .T.
666:             .Value       = 4
667: 
668:             WITH .Buttons(1)
669:                 .Caption   = "Todas"
670:                 .BackStyle = 0
671:                 .ForeColor = RGB(90, 90, 90)
672:                 .AutoSize  = .T.
673:                 .Left      = 5
674:                 .Top       = 5
675:                 .Width     = 47
676:                 .Visible   = .T.
677:             ENDWITH
678: 
679:             WITH .Buttons(2)
680:                 .Caption   = "Somente Lidos"
681:                 .FontName  = "Tahoma"
682:                 .FontSize  = 8
683:                 .BackStyle = 0
684:                 .ForeColor = RGB(90, 90, 90)
685:                 .AutoSize  = .T.
686:                 .Left      = 74
687:                 .Top       = 6
688:                 .Width     = 87
689:                 .Visible   = .T.
690:             ENDWITH
691: 
692:             WITH .Buttons(3)
693:                 .Caption   = "N" + CHR(227) + "o Lidos"
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .BackStyle = 0

*-- Linhas 722 a 1633:
722:     *   Mantido para compatibilidade com pipeline multi-fase.
723:     *   Para forms REPORT o PageFrame permanece sempre em ActivePage=1.
724:     *--------------------------------------------------------------------------
725:     PROCEDURE AlternarPagina(par_nPagina)
726:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
727:             THIS.pgf_4c_Paginas.Visible = .T.
728:             THIS.pgf_4c_Paginas.ActivePage = 1
729:         ENDIF
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     * Destroy - Libera BO de relatorio
734:     *--------------------------------------------------------------------------
735:     PROCEDURE Destroy()
736:         IF VARTYPE(THIS.this_oRelatorio) = "O"
737:             THIS.this_oRelatorio = .NULL.
738:         ENDIF
739:         DODEFAULT()
740:     ENDPROC
741: 
742:     *--------------------------------------------------------------------------
743:     * ConfigurarPaginaDados - Vincula eventos BINDEVENT dos controles de filtro
744:     *   FORM REPORT sem Page2: todos os controles ja estao em Page1 (Fase 4).
745:     *   Esta fase conecta os controles existentes aos handlers de evento.
746:     *   Chamado por InicializarForm apos ConfigurarPageFrame.
747:     *--------------------------------------------------------------------------
748:     PROTECTED PROCEDURE ConfigurarPaginaDados()
749:         LOCAL loc_oPagina
750:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
751: 
752:         *-- Vendedor: codigo e descricao (com controle de acesso via SigCdAcJ)
753:         BINDEVENT(loc_oPagina.txt_4c_Conta,        "DblClick", THIS, "AbrirBuscaVendedor")
754:         BINDEVENT(loc_oPagina.txt_4c_Conta,        "KeyPress", THIS, "TeclaVendedor")
755:         BINDEVENT(loc_oPagina.txt_4c_DConta,       "DblClick", THIS, "AbrirBuscaVendedor")
756:         BINDEVENT(loc_oPagina.txt_4c_DConta,       "KeyPress", THIS, "TeclaDescVendedor")
757: 
758:         *-- Grupo Estoque: codigo e descricao (SigCdGcr)
759:         BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
760:         BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
761:         BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
762:         BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
763: 
764:         *-- Conta Estoque: codigo e descricao (SigCdCli filtrado por GrEstoque)
765:         BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
766:         BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "KeyPress", THIS, "TeclaCdEstoque")
767:         BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
768:         BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "KeyPress", THIS, "TeclaDsEstoque")
769: 
770:         *-- Produto: codigo e descricao (SigCdPro)
771:         BINDEVENT(loc_oPagina.txt_4c__Produto,     "DblClick", THIS, "AbrirBuscaProduto")
772:         BINDEVENT(loc_oPagina.txt_4c__Produto,     "KeyPress", THIS, "TeclaProduto")
773:         BINDEVENT(loc_oPagina.txt_4c__descricao,   "DblClick", THIS, "AbrirBuscaProduto")
774:         BINDEVENT(loc_oPagina.txt_4c__descricao,   "KeyPress", THIS, "TeclaDescProduto")
775: 
776:         *-- Botoes do relatorio (Visualizar/Imprimir/Excel/Encerrar)
777:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
778:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
779:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
780:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * LimparCampos - Inicializa todos os filtros com valores padrao
785:     *   Data = hoje, demais em branco, OptLocal = 1 (Todos).
786:     *--------------------------------------------------------------------------
787:     PROCEDURE LimparCampos()
788:         LOCAL loc_oPagina
789:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
790:         loc_oPagina.txt_4c_Datas.Value         = DATE()
791:         loc_oPagina.txt_4c_Codigo.Value        = ""
792:         loc_oPagina.txt_4c_Conta.Value         = ""
793:         loc_oPagina.txt_4c_DConta.Value        = ""
794:         loc_oPagina.txt_4c_Cd_GrEstoque.Value  = ""
795:         loc_oPagina.txt_4c_Ds_GrEstoque.Value  = ""
796:         loc_oPagina.txt_4c_Cd_Estoque.Value    = ""
797:         loc_oPagina.txt_4c_Ds_Estoque.Value    = ""
798:         loc_oPagina.txt_4c__Produto.Value      = ""
799:         loc_oPagina.txt_4c__descricao.Value    = ""
800:         loc_oPagina.obj_4c_OptLocal.Value      = 4
801:     ENDPROC
802: 
803:     *--------------------------------------------------------------------------
804:     * FormParaRelatorio - Copia valores dos filtros do form para o BO
805:     *   Chamado em BtnVisualizarClick, BtnImprimirClick e BtnExcelClick.
806:     *--------------------------------------------------------------------------
807:     PROTECTED PROCEDURE FormParaRelatorio()
808:         LOCAL loc_oPagina
809:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
810:         WITH THIS.this_oRelatorio
811:             .this_dData        = loc_oPagina.txt_4c_Datas.Value
812:             .this_cCods        = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
813:             .this_cConta       = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
814:             .this_cDConta      = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
815:             .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
816:             .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
817:             .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
818:             .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
819:             .this_cProduto     = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
820:             .this_cDsProduto   = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
821:             .this_nOptLocal    = loc_oPagina.obj_4c_OptLocal.Value
822:         ENDWITH
823:     ENDPROC
824: 
825:     *--------------------------------------------------------------------------
826:     * ValidarDataParaRelatorio - Verifica se a data foi informada
827:     *   Equivalente ao "If (This.Value <> 4) If Empty(getDatas.Value)" do legado.
828:     *   Retorna .T. se data valida, .F. se vazia (posiciona foco na data).
829:     *--------------------------------------------------------------------------
830:     PROTECTED PROCEDURE ValidarDataParaRelatorio()
831:         LOCAL loc_oPagina
832:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
833:         IF EMPTY(loc_oPagina.txt_4c_Datas.Value)
834:             MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
835:             loc_oPagina.txt_4c_Datas.SetFocus()
836:             RETURN .F.
837:         ENDIF
838:         RETURN .T.
839:     ENDPROC
840: 
841:     *--------------------------------------------------------------------------
842:     * BtnVisualizarClick - Visualiza relatorio em tela (preview)
843:     *   Botao 1 do cmg_4c_Botoes.
844:     *   Equivalente a: REPORT FORM SigReCrf PREVIEW NOCONSOLE
845:     *--------------------------------------------------------------------------
846:     PROCEDURE BtnVisualizarClick()
847:         IF !THIS.ValidarDataParaRelatorio()
848:             RETURN
849:         ENDIF
850:         THIS.FormParaRelatorio()
851:         IF !THIS.this_oRelatorio.Visualizar()
852:             LOCAL loc_cMsg
853:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
854:             IF !EMPTY(loc_cMsg)
855:                 MsgErro(loc_cMsg, "Erro")
856:             ENDIF
857:         ENDIF
858:     ENDPROC
859: 
860:     *--------------------------------------------------------------------------
861:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
862:     *   Botao 2 do cmg_4c_Botoes.
863:     *   Equivalente a: REPORT FORM SigReCrf TO PRINT PROMPT NOCONSOLE
864:     *--------------------------------------------------------------------------
865:     PROCEDURE BtnImprimirClick()
866:         IF !THIS.ValidarDataParaRelatorio()
867:             RETURN
868:         ENDIF
869:         THIS.FormParaRelatorio()
870:         IF !THIS.this_oRelatorio.Imprimir()
871:             LOCAL loc_cMsg
872:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
873:             IF !EMPTY(loc_cMsg)
874:                 MsgErro(loc_cMsg, "Erro")
875:             ENDIF
876:         ENDIF
877:     ENDPROC
878: 
879:     *--------------------------------------------------------------------------
880:     * BtnExcelClick - Exporta relatorio para Excel
881:     *   Botao 3 do cmg_4c_Botoes.
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnExcelClick()
884:         IF !THIS.ValidarDataParaRelatorio()
885:             RETURN
886:         ENDIF
887:         THIS.FormParaRelatorio()
888:         IF !THIS.this_oRelatorio.GerarExcel()
889:             LOCAL loc_cMsg
890:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
891:             IF !EMPTY(loc_cMsg)
892:                 MsgErro(loc_cMsg, "Erro")
893:             ENDIF
894:         ENDIF
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * BtnEncerrarClick - Fecha o formulario de relatorio
899:     *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
900:     *--------------------------------------------------------------------------
901:     PROCEDURE BtnEncerrarClick()
902:         THIS.Release()
903:     ENDPROC
904: 
905:     *==========================================================================
906:     *  EVENTOS CRUD-NAMED (mapeados ao contexto de REPORT form)
907:     *  Em forms REPORT (frmrelatorio) os eventos Incluir/Alterar/Excluir
908:     *  nao tem o sentido CRUD tradicional. Sao remapeados para operacoes
909:     *  uteis no fluxo de filtros do relatorio.
910:     *==========================================================================
911: 
912:     *--------------------------------------------------------------------------
913:     * BtnIncluirClick - Em REPORT forms, "Incluir" mapeia para "Novo
914:     * Relatorio": limpa todos os filtros (LimparCampos restaura defaults com
915:     * txt_4c_Datas=DATE() e obj_4c_OptLocal=4 "Todos") e devolve foco ao
916:     * primeiro filtro de data, permitindo o usuario iniciar uma nova consulta
917:     * do zero sem precisar reabrir o formulario.
918:     *--------------------------------------------------------------------------
919:     PROCEDURE BtnIncluirClick()
920:         LOCAL loc_oPagina
921:         THIS.LimparCampos()
922:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
923:         IF VARTYPE(loc_oPagina) = "O" AND VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
924:             loc_oPagina.txt_4c_Datas.SetFocus()
925:         ENDIF
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * BtnAlterarClick - Em REPORT forms, "Alterar" mapeia para "Alterar
930:     * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
931:     * e devolve o foco ao primeiro filtro de data, permitindo refinar a
932:     * consulta antes de re-Visualizar/Imprimir. Ressincroniza tambem a
933:     * visibilidade do OptLocal com o ComboBox/Datas para manter UI consistente.
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnAlterarClick()
936:         LOCAL loc_oPagina
937:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
938:         IF VARTYPE(loc_oPagina) != "O"
939:             RETURN
940:         ENDIF
941:         IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
942:             loc_oPagina.obj_4c_OptLocal.Visible = .T.
943:         ENDIF
944:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
945:             loc_oPagina.txt_4c_Datas.SetFocus()
946:         ENDIF
947:     ENDPROC
948: 
949:     *--------------------------------------------------------------------------
950:     * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
951:     * Filtros" / "Descartar parametros": pede confirmacao e, se confirmado,
952:     * zera todos os filtros via LimparCampos() (restaura txt_4c_Datas=DATE() e
953:     * obj_4c_OptLocal=4) e devolve foco ao primeiro filtro de data. Util
954:     * quando o usuario quer abandonar uma combinacao de filtros e recomecar
955:     * do zero sem fechar o form.
956:     *--------------------------------------------------------------------------
957:     PROCEDURE BtnExcluirClick()
958:         LOCAL loc_oPagina, loc_cMsg
959:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
960:         IF VARTYPE(loc_oPagina) != "O"
961:             RETURN
962:         ENDIF
963:         loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
964:         IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
965:             RETURN
966:         ENDIF
967:         THIS.LimparCampos()
968:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
969:             loc_oPagina.txt_4c_Datas.SetFocus()
970:         ENDIF
971:     ENDPROC
972: 
973:     *==========================================================================
974:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Vendedor (getConta/getDConta)
975:     *==========================================================================
976: 
977:     *--------------------------------------------------------------------------
978:     * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
979:     *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
980:     *--------------------------------------------------------------------------
981:     PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
982:         IF par_nKeyCode = 115
983:             THIS.AbrirBuscaVendedor()
984:         ENDIF
985:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
986:             THIS.ValidarVendedor()
987:         ENDIF
988:     ENDPROC
989: 
990:     *--------------------------------------------------------------------------
991:     * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
992:     *   getDConta.When legado: habilitado apenas quando getConta eh vazio.
993:     *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
994:     *--------------------------------------------------------------------------
995:     PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
996:         LOCAL loc_oPagina
997:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
998:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
999:             RETURN
1000:         ENDIF
1001:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1002:             THIS.ValidarDescVendedor()
1003:         ENDIF
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * ValidarVendedor - Limpa descricao se codigo vazio; abre busca caso contrario
1008:     *   Equivalente ao getConta.Valid do legado.
1009:     *--------------------------------------------------------------------------
1010:     PROCEDURE ValidarVendedor()
1011:         LOCAL loc_cValor, loc_oPagina
1012:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1013:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1014:         IF EMPTY(loc_cValor)
1015:             loc_oPagina.txt_4c_DConta.Value = ""
1016:             RETURN
1017:         ENDIF
1018:         THIS.AbrirBuscaVendedor()
1019:     ENDPROC
1020: 
1021:     *--------------------------------------------------------------------------
1022:     * ValidarDescVendedor - Limpa codigo se descricao vazia; abre busca contrario
1023:     *   Equivalente ao getDConta.Valid do legado (busca reversa por rclis).
1024:     *--------------------------------------------------------------------------
1025:     PROCEDURE ValidarDescVendedor()
1026:         LOCAL loc_cValor, loc_oPagina
1027:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1028:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
1029:         IF EMPTY(loc_cValor)
1030:             loc_oPagina.txt_4c_Conta.Value = ""
1031:             RETURN
1032:         ENDIF
1033:         THIS.AbrirBuscaVendedor()
1034:     ENDPROC
1035: 
1036:     *--------------------------------------------------------------------------
1037:     * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
1038:     *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
1039:     *   Filtra SigCdCli pelo GrPadVens e jobs acessiveis ao usuario logado.
1040:     *--------------------------------------------------------------------------
1041:     PROCEDURE AbrirBuscaVendedor()
1042:         LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1043:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1044:         loc_cGrPadVens = ""
1045:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1046:             loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
1047:         ENDIF
1048: 
1049:         loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
1050:                    "FROM SigCdCli a " + ;
1051:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1052:                    "AND (b.Coletors <> 10 " + ;
1053:                    "OR (b.Coletors = 10 " + ;
1054:                    "AND a.IClis NOT IN (" + ;
1055:                    "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
1056:                    "WHERE c.Jobs NOT IN (" + ;
1057:                    "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
1058:                    "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
1059:         IF !EMPTY(loc_cGrPadVens)
1060:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrPadVens)
1061:         ENDIF
1062:         loc_cSQL = loc_cSQL + " AND a.Inativas <> 2" + ;
1063:                    " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1064:                    " ORDER BY a.rclis"
1065: 
1066:         IF USED("cursor_4c_BuscaVend")
1067:             USE IN SELECT("cursor_4c_BuscaVend")
1068:         ENDIF
1069:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
1070:         IF loc_nResult > 0
1071:             IF RECCOUNT("cursor_4c_BuscaVend") > 0
1072:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1073:                 IF VARTYPE(loc_oLookup) = "O"
1074:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaVend"
1075:                     loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
1076:                         "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
1077:                     IF loc_oLookup.Mostrar()
1078:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1079:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1080:                     ENDIF
1081:                 ENDIF
1082:             ELSE
1083:                 MsgAviso("Nenhum vendedor encontrado.", "Aviso")
1084:             ENDIF
1085:             IF USED("cursor_4c_BuscaVend")
1086:                 USE IN SELECT("cursor_4c_BuscaVend")
1087:             ENDIF
1088:         ELSE
1089:             MsgErro("Erro ao buscar vendedores.", "Erro")
1090:         ENDIF
1091:     ENDPROC
1092: 
1093:     *==========================================================================
1094:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Grupo de Estoque
1095:     *==========================================================================
1096: 
1097:     *--------------------------------------------------------------------------
1098:     * TeclaCdGrEstoque - Handler KeyPress de txt_4c_Cd_GrEstoque (cod grupo)
1099:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1100:     *--------------------------------------------------------------------------
1101:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
1102:         IF par_nKeyCode = 115
1103:             THIS.AbrirBuscaGrEstoque()
1104:         ENDIF
1105:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1106:             THIS.ValidarCdGrEstoque()
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     *--------------------------------------------------------------------------
1111:     * TeclaDsGrEstoque - Handler KeyPress de txt_4c_Ds_GrEstoque (desc grupo)
1112:     *   Get_Ds_GrEstoque.When legado: habilitado apenas quando codigo vazio.
1113:     *   ENTER(13) / TAB(9) / F4(115): abre busca de grupo por descricao.
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
1116:         LOCAL loc_oPagina
1117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1118:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1119:             RETURN
1120:         ENDIF
1121:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1122:             THIS.ValidarDsGrEstoque()
1123:         ENDIF
1124:     ENDPROC
1125: 
1126:     *--------------------------------------------------------------------------
1127:     * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
1128:     *   Equivalente ao Get_Cd_GrEstoque.Valid (fAcessoContab 'C') do legado.
1129:     *--------------------------------------------------------------------------
1130:     PROCEDURE ValidarCdGrEstoque()
1131:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
1132:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1133:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1134:         IF EMPTY(loc_cValor)
1135:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
1136:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1137:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1138:             RETURN
1139:         ENDIF
1140:         loc_cSQL = "SELECT TOP 1 b.Codigos, b.Descrs " + ;
1141:                    "FROM SigCdCli a " + ;
1142:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1143:                    "WHERE a.Grupos = " + EscaparSQL(loc_cValor)
1144:         IF USED("cursor_4c_GrEstVal")
1145:             USE IN SELECT("cursor_4c_GrEstVal")
1146:         ENDIF
1147:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal")
1148:         IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstVal")
1149:             SELECT cursor_4c_GrEstVal
1150:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Codigos)
1151:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Descrs)
1152:         ELSE
1153:             MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
1154:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1155:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
1156:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1157:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1158:             THIS.AbrirBuscaGrEstoque()
1159:         ENDIF
1160:         IF USED("cursor_4c_GrEstVal")
1161:             USE IN SELECT("cursor_4c_GrEstVal")
1162:         ENDIF
1163:     ENDPROC
1164: 
1165:     *--------------------------------------------------------------------------
1166:     * ValidarDsGrEstoque - Valida descricao (busca reversa); abre lookup
1167:     *   Equivalente ao Get_Ds_GrEstoque.Valid (fAcessoContab 'D') do legado.
1168:     *--------------------------------------------------------------------------
1169:     PROCEDURE ValidarDsGrEstoque()
1170:         LOCAL loc_cValor, loc_oPagina
1171:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1172:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
1173:         IF EMPTY(loc_cValor)
1174:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1175:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1176:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1177:             RETURN
1178:         ENDIF
1179:         THIS.AbrirBuscaGrEstoque()
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * AbrirBuscaGrEstoque - Lista grupos de estoque/contab (SigCdGcr)
1184:     *   Equivalente ao fAcessoContab do legado para selecao de grupo.
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE AbrirBuscaGrEstoque()
1187:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1188:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1189:         IF USED("cursor_4c_BuscaGrEst")
1190:             USE IN SELECT("cursor_4c_BuscaGrEst")
1191:         ENDIF
1192:         loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
1193:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrEst")
1194:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrEst") > 0
1195:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1196:             IF VARTYPE(loc_oLookup) = "O"
1197:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaGrEst"
1198:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaGrEst", "Codigos", "Descrs", ;
1199:                     "Grupo de Estoque")
1200:                 IF loc_oLookup.Mostrar()
1201:                     loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1202:                     loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1203:                     loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1204:                     loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1205:                 ENDIF
1206:             ENDIF
1207:         ELSE
1208:             MsgAviso("Nenhum grupo de estoque encontrado.", "Aviso")
1209:         ENDIF
1210:         IF USED("cursor_4c_BuscaGrEst")
1211:             USE IN SELECT("cursor_4c_BuscaGrEst")
1212:         ENDIF
1213:     ENDPROC
1214: 
1215:     *==========================================================================
1216:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Conta de Estoque
1217:     *==========================================================================
1218: 
1219:     *--------------------------------------------------------------------------
1220:     * TeclaCdEstoque - Handler KeyPress de txt_4c_Cd_Estoque (cod conta)
1221:     *   Bloqueia entrada se GrEstoque nao informado (equivalente ao When legado).
1222:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1223:     *--------------------------------------------------------------------------
1224:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
1225:         LOCAL loc_oPagina
1226:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1227:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1228:             MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
1229:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1230:             RETURN
1231:         ENDIF
1232:         IF par_nKeyCode = 115
1233:             THIS.AbrirBuscaEstoque()
1234:         ENDIF
1235:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1236:             THIS.ValidarCdEstoque()
1237:         ENDIF
1238:     ENDPROC
1239: 
1240:     *--------------------------------------------------------------------------
1241:     * TeclaDsEstoque - Handler KeyPress de txt_4c_Ds_Estoque (desc conta)
1242:     *   Get_Ds_Estoque.When legado: habilitado apenas quando codigo vazio.
1243:     *   ENTER(13) / TAB(9) / F4(115): abre busca de conta por descricao.
1244:     *--------------------------------------------------------------------------
1245:     PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
1246:         LOCAL loc_oPagina
1247:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1248:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value))
1249:             RETURN
1250:         ENDIF
1251:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1252:             MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
1253:             RETURN
1254:         ENDIF
1255:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1256:             THIS.ValidarDsEstoque()
1257:         ENDIF
1258:     ENDPROC
1259: 
1260:     *--------------------------------------------------------------------------
1261:     * ValidarCdEstoque - Valida codigo da conta de estoque (SigCdCli)
1262:     *   Equivalente ao Get_Cd_Estoque.Valid (fAcessoContas 'C') do legado.
1263:     *   Filtra SigCdCli pelo grupo de estoque selecionado.
1264:     *--------------------------------------------------------------------------
1265:     PROCEDURE ValidarCdEstoque()
1266:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina
1267:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1268:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
1269:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1270:         IF EMPTY(loc_cValor)
1271:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1272:             RETURN
1273:         ENDIF
1274:         loc_cSQL = "SELECT TOP 1 a.IClis, a.RClis " + ;
1275:                    "FROM SigCdCli a " + ;
1276:                    "WHERE a.IClis = " + EscaparSQL(loc_cValor)
1277:         IF !EMPTY(loc_cGrupo)
1278:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1279:         ENDIF
1280:         IF USED("cursor_4c_EstVal")
1281:             USE IN SELECT("cursor_4c_EstVal")
1282:         ENDIF
1283:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
1284:         IF loc_nResult > 0 AND !EOF("cursor_4c_EstVal")
1285:             SELECT cursor_4c_EstVal
1286:             loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_EstVal.IClis)
1287:             loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_EstVal.RClis)
1288:         ELSE
1289:             MsgAviso("Conta de estoque n" + CHR(227) + "o encontrada.", "Aviso")
1290:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1291:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1292:             THIS.AbrirBuscaEstoque()
1293:         ENDIF
1294:         IF USED("cursor_4c_EstVal")
1295:             USE IN SELECT("cursor_4c_EstVal")
1296:         ENDIF
1297:     ENDPROC
1298: 
1299:     *--------------------------------------------------------------------------
1300:     * ValidarDsEstoque - Valida descricao da conta; abre busca reversa
1301:     *   Equivalente ao Get_Ds_Estoque.Valid (fAcessoContas 'D') do legado.
1302:     *--------------------------------------------------------------------------
1303:     PROCEDURE ValidarDsEstoque()
1304:         LOCAL loc_cValor, loc_oPagina
1305:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1306:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
1307:         IF EMPTY(loc_cValor)
1308:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1309:             RETURN
1310:         ENDIF
1311:         THIS.AbrirBuscaEstoque()
1312:     ENDPROC
1313: 
1314:     *--------------------------------------------------------------------------
1315:     * AbrirBuscaEstoque - Lista contas de estoque (SigCdCli) filtradas por grupo
1316:     *   Equivalente ao fAcessoContas do legado para selecao de conta de estoque.
1317:     *--------------------------------------------------------------------------
1318:     PROCEDURE AbrirBuscaEstoque()
1319:         LOCAL loc_cGrupo, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1320:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1321:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1322:         IF USED("cursor_4c_BuscaEst")
1323:             USE IN SELECT("cursor_4c_BuscaEst")
1324:         ENDIF
1325:         loc_cSQL = "SELECT a.IClis AS Cods, a.RClis AS Descs " + ;
1326:                    "FROM SigCdCli a " + ;
1327:                    "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1328:         IF !EMPTY(loc_cGrupo)
1329:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1330:         ENDIF
1331:         loc_cSQL = loc_cSQL + " ORDER BY a.RClis"
1332:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1333:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEst") > 0
1334:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1335:             IF VARTYPE(loc_oLookup) = "O"
1336:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaEst"
1337:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaEst", "Cods", "Descs", ;
1338:                     "Conta de Estoque")
1339:                 IF loc_oLookup.Mostrar()
1340:                     loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1341:                     loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1342:                 ENDIF
1343:             ENDIF
1344:         ELSE
1345:             MsgAviso("Nenhuma conta de estoque encontrada.", "Aviso")
1346:         ENDIF
1347:         IF USED("cursor_4c_BuscaEst")
1348:             USE IN SELECT("cursor_4c_BuscaEst")
1349:         ENDIF
1350:     ENDPROC
1351: 
1352:     *==========================================================================
1353:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Produto (get_Produto/get_descricao)
1354:     *==========================================================================
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * TeclaProduto - Handler KeyPress de txt_4c__Produto (codigo do produto)
1358:     *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
1359:     *--------------------------------------------------------------------------
1360:     PROCEDURE TeclaProduto(par_nKeyCode, par_nShiftAltCtrl)
1361:         IF par_nKeyCode = 115
1362:             THIS.AbrirBuscaProduto()
1363:         ENDIF
1364:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1365:             THIS.ValidarProduto()
1366:         ENDIF
1367:     ENDPROC
1368: 
1369:     *--------------------------------------------------------------------------
1370:     * TeclaDescProduto - Handler KeyPress de txt_4c__descricao (desc produto)
1371:     *   get_descricao.When legado: habilitado apenas quando codigo vazio.
1372:     *   ENTER(13) / TAB(9) / F4(115): abre busca de produto por descricao.
1373:     *--------------------------------------------------------------------------
1374:     PROCEDURE TeclaDescProduto(par_nKeyCode, par_nShiftAltCtrl)
1375:         LOCAL loc_oPagina
1376:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1377:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value))
1378:             RETURN
1379:         ENDIF
1380:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1381:             THIS.ValidarDescProduto()
1382:         ENDIF
1383:     ENDPROC
1384: 
1385:     *--------------------------------------------------------------------------
1386:     * ValidarProduto - Valida codigo do produto (SigCdPro.cpros)
1387:     *   Equivalente ao get_Produto.Valid (fwBuscaExt SigCdPro cpros) do legado.
1388:     *--------------------------------------------------------------------------
1389:     PROCEDURE ValidarProduto()
1390:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
1391:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1392:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1393:         IF EMPTY(loc_cValor)
1394:             loc_oPagina.txt_4c__descricao.Value = ""
1395:             RETURN
1396:         ENDIF
1397:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
1398:                    "WHERE cpros = " + EscaparSQL(loc_cValor)
1399:         IF USED("cursor_4c_ProdVal")
1400:             USE IN SELECT("cursor_4c_ProdVal")
1401:         ENDIF
1402:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1403:         IF loc_nResult > 0 AND !EOF("cursor_4c_ProdVal")
1404:             SELECT cursor_4c_ProdVal
1405:             loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(cursor_4c_ProdVal.cpros)
1406:             loc_oPagina.txt_4c__descricao.Value = ALLTRIM(cursor_4c_ProdVal.dpros)
1407:         ELSE
1408:             MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Aviso")
1409:             loc_oPagina.txt_4c__Produto.Value   = ""
1410:             loc_oPagina.txt_4c__descricao.Value = ""
1411:             THIS.AbrirBuscaProduto()
1412:         ENDIF
1413:         IF USED("cursor_4c_ProdVal")
1414:             USE IN SELECT("cursor_4c_ProdVal")
1415:         ENDIF
1416:     ENDPROC
1417: 
1418:     *--------------------------------------------------------------------------
1419:     * ValidarDescProduto - Valida descricao (busca reversa em SigCdPro.dpros)
1420:     *   Equivalente ao get_descricao.Valid (fwBuscaExt SigCdPro DPros) do legado.
1421:     *--------------------------------------------------------------------------
1422:     PROCEDURE ValidarDescProduto()
1423:         LOCAL loc_cValor, loc_oPagina
1424:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1425:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
1426:         IF EMPTY(loc_cValor)
1427:             loc_oPagina.txt_4c__Produto.Value = ""
1428:             RETURN
1429:         ENDIF
1430:         THIS.AbrirBuscaProduto()
1431:     ENDPROC
1432: 
1433:     *--------------------------------------------------------------------------
1434:     * AbrirBuscaProduto - Lista produtos (SigCdPro) por codigo ou descricao
1435:     *   Equivalente ao fwBuscaExt SigCdPro do legado para selecao de produto.
1436:     *--------------------------------------------------------------------------
1437:     PROCEDURE AbrirBuscaProduto()
1438:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1439:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1440:         IF USED("cursor_4c_BuscaProd")
1441:             USE IN SELECT("cursor_4c_BuscaProd")
1442:         ENDIF
1443:         loc_cSQL    = "SELECT cpros, dpros FROM SigCdPro ORDER BY dpros"
1444:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
1445:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
1446:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1447:             IF VARTYPE(loc_oLookup) = "O"
1448:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaProd"
1449:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
1450:                     "Sele" + CHR(231) + CHR(227) + "o de Produto")
1451:                 IF loc_oLookup.Mostrar()
1452:                     loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1453:                     loc_oPagina.txt_4c__descricao.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1454:                 ENDIF
1455:             ENDIF
1456:         ELSE
1457:             MsgAviso("Nenhum produto encontrado.", "Aviso")
1458:         ENDIF
1459:         IF USED("cursor_4c_BuscaProd")
1460:             USE IN SELECT("cursor_4c_BuscaProd")
1461:         ENDIF
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------
1465:     * ConfigurarPermissoesOptLocal - Controla visibilidade das opcoes do OptLocal
1466:     *   No original: se usuario NAO tem acesso DIFERENCA e nao e '4CONTROL',
1467:     *   esconde opcoes 1,2,3 (mostra apenas "Diferencas"). Caso contrario, todas.
1468:     *   Na nova arquitetura sem fChecaAcesso, default = mostrar todas as opcoes.
1469:     *--------------------------------------------------------------------------
1470:     PROTECTED PROCEDURE ConfigurarPermissoesOptLocal()
1471:         LOCAL loc_oPagina, loc_lMostrarTodas, loc_cUsuario
1472:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
1473:         loc_lMostrarTodas = .T.
1474:         loc_cUsuario     = ""
1475:         IF TYPE("gc_4c_UsuarioLogado") = "C"
1476:             loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
1477:         ENDIF
1478: 
1479:         *-- Verificar flag de restricao no BO (set durante Init do BO)
1480:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1481:             IF PEMSTATUS(THIS.this_oRelatorio, "this_lAcessoSomentesDif", 5)
1482:                 IF THIS.this_oRelatorio.this_lAcessoSomentesDif AND ;
1483:                    UPPER(loc_cUsuario) <> "4CONTROL"
1484:                     loc_lMostrarTodas = .F.
1485:                 ENDIF
1486:             ENDIF
1487:         ENDIF
1488: 
1489:         WITH loc_oPagina.obj_4c_OptLocal
1490:             .Buttons(1).Visible = loc_lMostrarTodas
1491:             .Buttons(2).Visible = loc_lMostrarTodas
1492:             .Buttons(3).Visible = loc_lMostrarTodas
1493:             .Buttons(4).Visible = .T.
1494:             IF !loc_lMostrarTodas
1495:                 .Value = 4
1496:             ENDIF
1497:         ENDWITH
1498:     ENDPROC
1499: 
1500: 
1501:     *==========================================================================
1502:     *  FASE 8/8 - METODOS AUXILIARES E COMPATIBILIDADE COM PIPELINE MULTI-FASE
1503:     *  Em forms REPORT (frmrelatorio) nao existem modos CRUD nem grid de lista.
1504:     *  Os metodos abaixo existem para satisfazer o contrato do pipeline multi-fase
1505:     *  e para fornecer comportamentos uteis mapeados ao contexto do relatorio.
1506:     *==========================================================================
1507: 
1508:     *--------------------------------------------------------------------------
1509:     * CarregarLista - Compatibilidade com pipeline CRUD (REPORT: sem lista)
1510:     *   Em forms REPORT nao ha grid de lista para recarregar. Retorna .T.
1511:     *   para indicar sucesso ao pipeline que chama este metodo apos Incluir.
1512:     *--------------------------------------------------------------------------
1513:     PROCEDURE CarregarLista()
1514:         RETURN .T.
1515:     ENDPROC
1516: 
1517:     *--------------------------------------------------------------------------
1518:     * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
1519:     *   par_lHabilitar: .T. = habilitar todos, .F. = desabilitar todos.
1520:     *   Sem par_lHabilitar (ou tipo invalido) assume .T. (habilitar).
1521:     *   Em forms REPORT o padrao eh sempre habilitado (sem modo VISUALIZAR).
1522:     *--------------------------------------------------------------------------
1523:     PROCEDURE HabilitarCampos(par_lHabilitar)
1524:         LOCAL loc_lHab, loc_oPagina
1525:         loc_lHab    = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1526:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1527:         IF VARTYPE(loc_oPagina) != "O"
1528:             RETURN
1529:         ENDIF
1530:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1531:             loc_oPagina.txt_4c_Datas.Enabled = loc_lHab
1532:         ENDIF
1533:         IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1534:             loc_oPagina.txt_4c_Codigo.Enabled = loc_lHab
1535:         ENDIF
1536:         IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
1537:             loc_oPagina.txt_4c_Conta.Enabled = loc_lHab
1538:         ENDIF
1539:         IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
1540:             loc_oPagina.txt_4c_DConta.Enabled = loc_lHab
1541:         ENDIF
1542:         IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
1543:             loc_oPagina.txt_4c_Cd_GrEstoque.Enabled = loc_lHab
1544:         ENDIF
1545:         IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
1546:             loc_oPagina.txt_4c_Ds_GrEstoque.Enabled = loc_lHab
1547:         ENDIF
1548:         IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
1549:             loc_oPagina.txt_4c_Cd_Estoque.Enabled = loc_lHab
1550:         ENDIF
1551:         IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
1552:             loc_oPagina.txt_4c_Ds_Estoque.Enabled = loc_lHab
1553:         ENDIF
1554:         IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
1555:             loc_oPagina.txt_4c__Produto.Enabled = loc_lHab
1556:         ENDIF
1557:         IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
1558:             loc_oPagina.txt_4c__descricao.Enabled = loc_lHab
1559:         ENDIF
1560:         IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
1561:             loc_oPagina.obj_4c_OptLocal.Enabled = loc_lHab
1562:         ENDIF
1563:     ENDPROC
1564: 
1565:     *--------------------------------------------------------------------------
1566:     * AjustarBotoesPorModo - Compatibilidade com pipeline CRUD
1567:     *   Em forms REPORT nao ha modos CRUD. Os 4 botoes do cmg_4c_Botoes ficam
1568:     *   sempre habilitados (Visualizar/Imprimir/Excel/Encerrar).
1569:     *--------------------------------------------------------------------------
1570:     PROCEDURE AjustarBotoesPorModo()
1571:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1572:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1573:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1574:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1575:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1576:         ENDIF
1577:     ENDPROC
1578: 
1579:     *--------------------------------------------------------------------------
1580:     * FormParaBO - Compatibilidade com pipeline CRUD
1581:     *   Delega para FormParaRelatorio() que copia valores dos filtros do form
1582:     *   para as propriedades this_* do sigrecrfBO.
1583:     *--------------------------------------------------------------------------
1584:     PROTECTED PROCEDURE FormParaBO()
1585:         THIS.FormParaRelatorio()
1586:     ENDPROC
1587: 
1588:     *--------------------------------------------------------------------------
1589:     * BOParaForm - Carrega propriedades do BO de relatorio de volta ao form
1590:     *   Restaura os campos de filtro com os valores que estao no BO.
1591:     *   Util apos uma operacao que atualizou o BO externamente.
1592:     *--------------------------------------------------------------------------
1593:     PROTECTED PROCEDURE BOParaForm()
1594:         LOCAL loc_oPagina
1595:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1596:             RETURN
1597:         ENDIF
1598:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1599:         IF VARTYPE(loc_oPagina) != "O"
1600:             RETURN
1601:         ENDIF
1602:         WITH THIS.this_oRelatorio
1603:             IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1604:                 loc_oPagina.txt_4c_Datas.Value = IIF(EMPTY(.this_dData), DATE(), .this_dData)
1605:             ENDIF
1606:             IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1607:                 loc_oPagina.txt_4c_Codigo.Value = .this_cCods
1608:             ENDIF
1609:             IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
1610:                 loc_oPagina.txt_4c_Conta.Value = .this_cConta
1611:             ENDIF
1612:             IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
1613:                 loc_oPagina.txt_4c_DConta.Value = .this_cDConta
1614:             ENDIF
1615:             IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
1616:                 loc_oPagina.txt_4c_Cd_GrEstoque.Value = .this_cCdGrEstoque
1617:             ENDIF
1618:             IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
1619:                 loc_oPagina.txt_4c_Ds_GrEstoque.Value = .this_cDsGrEstoque
1620:             ENDIF
1621:             IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
1622:                 loc_oPagina.txt_4c_Cd_Estoque.Value = .this_cCdEstoque
1623:             ENDIF
1624:             IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
1625:                 loc_oPagina.txt_4c_Ds_Estoque.Value = .this_cDsEstoque
1626:             ENDIF
1627:             IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
1628:                 loc_oPagina.txt_4c__Produto.Value = .this_cProduto
1629:             ENDIF
1630:             IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
1631:                 loc_oPagina.txt_4c__descricao.Value = .this_cDsProduto
1632:             ENDIF
1633:             IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"

*-- Linhas 1641 a 1684:
1641:     *   Valida data (exceto OptLocal=4), copia filtros para BO e exibe relatorio.
1642:     *   Equivalente semantico ao "Buscar" em forms CRUD que carrega a lista.
1643:     *--------------------------------------------------------------------------
1644:     PROCEDURE BtnBuscarClick()
1645:         THIS.BtnVisualizarClick()
1646:     ENDPROC
1647: 
1648:     *--------------------------------------------------------------------------
1649:     * BtnSalvarClick - Em REPORT forms, "Salvar" = Imprimir (direto na impressora)
1650:     *   Valida data, copia filtros para BO e imprime sem dialogo de impressora.
1651:     *   Equivalente semantico ao "Salvar" de forms CRUD (persistir resultado).
1652:     *--------------------------------------------------------------------------
1653:     PROCEDURE BtnSalvarClick()
1654:         IF !THIS.ValidarDataParaRelatorio()
1655:             RETURN
1656:         ENDIF
1657:         THIS.FormParaRelatorio()
1658:         IF !THIS.this_oRelatorio.Imprimir()
1659:             LOCAL loc_cMsg
1660:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1661:             IF !EMPTY(loc_cMsg)
1662:                 MsgErro(loc_cMsg, "Erro")
1663:             ENDIF
1664:         ENDIF
1665:     ENDPROC
1666: 
1667:     *--------------------------------------------------------------------------
1668:     * BtnCancelarClick - Em REPORT forms, "Cancelar" = Limpar filtros
1669:     *   Restaura todos os campos de filtro para seus valores padrao (LimparCampos)
1670:     *   e posiciona foco no campo de data para nova consulta.
1671:     *   Equivalente semantico ao "Cancelar" de forms CRUD (descartar edicao).
1672:     *--------------------------------------------------------------------------
1673:     PROCEDURE BtnCancelarClick()
1674:         LOCAL loc_oPagina
1675:         THIS.LimparCampos()
1676:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1677:         IF VARTYPE(loc_oPagina) = "O"
1678:             IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1679:                 loc_oPagina.txt_4c_Datas.SetFocus()
1680:             ENDIF
1681:         ENDIF
1682:     ENDPROC
1683: 
1684: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecrfBO.prg):
*==============================================================================
* SIGRECRFBO.PRG
* Business Object para Relatorio de Contagem por Referencia
*
* Herda de: RelatorioBase
* Form: Formsigrecrf.prg
* Relatorio original: sigrecrf.SCX / SigReCrf.FRX
*==============================================================================

DEFINE CLASS sigrecrfBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCrf"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cCods              = ""
    this_cProduto           = ""
    this_cDsProduto         = ""
    this_cCdGrEstoque       = ""
    this_cDsGrEstoque       = ""
    this_cCdEstoque         = ""
    this_cDsEstoque         = ""
    this_nOptLocal          = 4

    *-- Estado / controle
    this_cGrPadVens         = ""
    this_lAcessoSomentesDif = .F.

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init - Carrega GrPadVens de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de Contagem por Referencia"
        THIS.this_nOptLocal        = 4

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 GrPadVens FROM SigCdPam", ;
                "cursor_4c_SigrecrfPam")

            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPam
                IF !EOF()
                    THIS.this_cGrPadVens = ALLTRIM(GrPadVens)
                ENDIF
                USE IN cursor_4c_SigrecrfPam
            ENDIF

            IF EMPTY(THIS.this_cGrPadVens)
                THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores n" + ;
                    CHR(227) + "o est" + CHR(225) + " configurado nos par" + CHR(226) + ;
                    "metros do sistema. Configure antes de prosseguir."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecrfBO.Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa queries e monta cursor crRel para REPORT FORM
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cVends, loc_cCods, loc_cPro, loc_cGrupo, loc_cConta, loc_nLocal
        LOCAL loc_cNomeEmpresa, loc_cTitulo2

        loc_lSucesso = .F.

        TRY
            loc_cVends   = ALLTRIM(THIS.this_cConta)
            loc_nLocal   = THIS.this_nOptLocal
            loc_cCods    = ALLTRIM(THIS.this_cCods)
            loc_cPro     = ALLTRIM(THIS.this_cProduto)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            *-- Limpar cursores de execucao anterior
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("crRel")
                USE IN crRel
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF

            *-- Validar data (obrigatoria exceto para Diferencas - OptLocal=4)
            IF loc_nLocal <> 4 AND EMPTY(THIS.this_dData)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ENDIF

            *-- Montar cabecalho do relatorio
            CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

            loc_cNomeEmpresa = loc_cEmpresa
            loc_cTitulo2     = ""

            IF !EMPTY(go_4c_Sistema.cEmpresa)
                loc_cNomeEmpresa = loc_cEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)
            ENDIF

            IF !EMPTY(loc_cVends)
                loc_cTitulo2 = "Vendedor - " + loc_cVends + " " + ALLTRIM(THIS.this_cDConta)
            ENDIF

            INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTituloRelatorio, loc_cTitulo2)

            *--------------------------------------------------------------
            *-- QUERY 1: Contagens - sigcdcrf JOIN sigcdcri
            *--------------------------------------------------------------
            loc_cWhere = "a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(THIS.this_dData)
                loc_cWhere = loc_cWhere + ;
                    " And CAST(a.Datas AS DATE) = " + FormatarDataSQL(THIS.this_dData)
            ENDIF
            IF !EMPTY(loc_cCods)
                loc_cWhere = loc_cWhere + " And A.Cods = " + EscaparSQL(loc_cCods)
            ENDIF
            IF !EMPTY(loc_cVends)
                loc_cWhere = loc_cWhere + " And A.Vends = " + EscaparSQL(loc_cVends)
            ENDIF
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And b.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And b.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.cods, a.datas, a.vends, a.emps, " + ;
                       "b.cpros, b.grupos, b.estos, b.qtds, b.estoque " + ;
                       "from sigcdcrf a " + ;
                       "join sigcdcri b on a.cods = b.cods " + ;
                       "Where " + loc_cWhere

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar contagens (crSigCdCrf)"
                loc_lSucesso = .F.
            ENDIF

            IF RECCOUNT("crSigCdCrf") = 0
                THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigCdCrf
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produto
            GO TOP

            *--------------------------------------------------------------
            *-- QUERY 2: Estoque - SigMvEst JOIN SigCdpro/SigCdCli/SigCtCtg
            *--------------------------------------------------------------
            loc_cWhere = "a.emps = " + EscaparSQL(loc_cEmpresa)
            IF !EMPTY(loc_cPro)
                loc_cWhere = loc_cWhere + " And a.cpros = " + EscaparSQL(loc_cPro)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cWhere = loc_cWhere + " And a.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cConta)
                loc_cWhere = loc_cWhere + " And a.estos = " + EscaparSQL(loc_cConta)
            ENDIF

            loc_cSQL = "Select a.Emps, a.Grupos, a.Estos, a.cpros, " + ;
                       "sum(sqtds) as qtde, convert(numeric(5,0),0) as QtdCtg, b.dpros as Descr " + ;
                       "From SigMvEst a " + ;
                       "Join SigCdpro b on a.CPros = b.Cpros " + ;
                       "Join SigCdCli c on a.Estos = c.Iclis " + ;
                       "join SigCtCtg d on a.empgruests = d.empresa + d.grupos + d.contas " + ;
                       "Where " + loc_cWhere + ;
                       " And b.cunis = 'UN'" + ;
                       " group by a.Emps, a.Grupos, a.Estos, b.dpros, a.cpros" + ;
                       " Having sum(sqtds) <> 0" + ;
                       " order by a.Emps, a.Grupos, a.Estos, a.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpCrf")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar estoque (crTmpCrf)"
                loc_lSucesso = .F.
            ENDIF

            *-- Remover de crTmpCrf itens ausentes em crSigCdCrf
            SELECT crTmpCrf
            GO TOP
            SCAN
                IF !SEEK(crTmpCrf.Emps + crTmpCrf.Grupos + crTmpCrf.Estos + crTmpCrf.Cpros, ;
                         "crSigCdCrf", "Produto")
                    DELETE
                ENDIF
                SELECT crTmpCrf
            ENDSCAN

            *-- Agregar crTmpCrf por produto
            SELECT crTmpCrf
            SELECT Emps, grupos, estos, cpros, Sum(Qtde) As Qtds ;
                From crTmpCrf ;
                Where NOT DELETED() ;
                Group By Emps, grupos, estos, cpros ;
                Into Cursor csTotLocal READWRITE

            IF RECCOUNT("csTotLocal") = 0
                THIS.this_cMensagemErro = "Nenhum item de estoque encontrado para os filtros."
                loc_lSucesso = .F.
            ENDIF

            SELECT csTotLocal
            INDEX ON Emps + Grupos + Estos + Cpros TAG Produtos
            GO TOP

            *--------------------------------------------------------------
            *-- Aplicar filtro Localizacoes (OptLocal 1=Todas 2=Lidos 3=NaoLidos 4=Diferencas)
            *--------------------------------------------------------------
            DO CASE
            CASE loc_nLocal = 1
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    FULL OUTER JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 2
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crSigCdCrf a ;
                    LEFT JOIN crTmpCrf b ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 3
                SELECT DISTINCT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) = 0 ;
                    Into Cursor csRel READWRITE

            CASE loc_nLocal = 4
                SELECT a.DataS, ;
                    NVL(a.Emps,'') As emps, NVL(a.grupos,'') as grupos, ;
                    NVL(a.estos,'') as estos, NVL(a.cpros,'') as cpros, ;
                    NVL(a.Qtds,0) As Qtds, NVL(a.vends,'') As vends, ;
                    NVL(b.emps,'') As empsest, NVL(b.grupos,'') As gruposest, ;
                    NVL(b.estos,'') as estosest, NVL(b.cpros,'') as cprosest, ;
                    NVL(b.Qtde,0) As Qtde, NVL(b.Descr,'') as Descr ;
                    From crTmpCrf b ;
                    LEFT JOIN crSigCdCrf a ;
                    On a.emps = b.emps And a.grupos = b.grupos ;
                    And a.estos = b.estos And a.cpros = b.cpros ;
                    Where NVL(a.Qtds,0) <> NVL(b.Qtde,0) ;
                    Into Cursor csRel READWRITE
            ENDCASE

            *-- Agregacao final -> crRel (cursor do REPORT FORM)
            SELECT DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr, ;
                Sum(Qtds) As Qtds, Sum(Qtde) As Qtde ;
                From csRel ;
                Group By DataS, Emps, grupos, estos, cpros, Vends, empsest, Descr ;
                Into Cursor crRel READWRITE

            SELECT crRel
            INDEX ON Vends + Emps + grupos + estos + cpros TAG Locals
            GO TOP

            *-- Limpar cursores intermediarios
            IF USED("csRel")
                USE IN csRel
            ENDIF
            IF USED("csTotLocal")
                USE IN csTotLocal
            ENDIF
            IF USED("crTmpCrf")
                USE IN crTmpCrf
            ENDIF
            IF USED("crSigCdCrf")
                USE IN crSigCdCrf
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta relatorio para planilha Excel via REPORT FORM XML
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = SYS(5) + CURDIR() + "SigReCrf_" + ;
                               STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarVendedores - Busca lista de vendedores para lookup no form
    * Popula cursor_4c_SigrecrfVends com iclis, rclis, grupos, situas, Cpfs
    * Filtra por GrPadVens, Emps, acesso do usuario (SigCdAcJ)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarVendedores()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfVends")
                USE IN cursor_4c_SigrecrfVends
            ENDIF

            loc_cSQL = "Select a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs " + ;
                       "From SigCdCli a " + ;
                       "Inner Join SigCdGcr b On a.Grupos = b.Codigos " + ;
                       "And (b.Coletors <> 10 Or (b.Coletors = 10 " + ;
                       "And a.IClis Not In (" + ;
                       "Select Distinct c.Jobs From SigCdAcJ c " + ;
                       "Where c.Jobs Not In (" + ;
                       "Select Distinct d.Jobs From SigCdAcJ d " + ;
                       "Where d.Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                       ")))) " + ;
                       "And a.grupos = " + EscaparSQL(THIS.this_cGrPadVens) + ;
                       " And a.Inativas <> 2" + ;
                       " And a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfVends")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar vendedores"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarVendedores")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Busca produto em SigCdPro para lookup no form
    * par_cFiltro: valor digitado
    * par_cTipo:   "C"=por codigo (cpros), "N"=por descricao (dpros)
    * Popula cursor_4c_SigrecrfPro com cpros, dpros
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cFiltro, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCampo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigrecrfPro")
                USE IN cursor_4c_SigrecrfPro
            ENDIF

            IF ALLTRIM(par_cTipo) = "C"
                loc_cCampo = "cpros"
            ELSE
                loc_cCampo = "dpros"
            ENDIF

            loc_cSQL = "Select cpros, dpros " + ;
                       "From SigCdPro " + ;
                       "Where " + loc_cCampo + " LIKE " + ;
                       EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                       " Order By dpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrfPro")
            IF loc_nResult > 0
                SELECT cursor_4c_SigrecrfPro
                GO TOP
                loc_lSucesso = !EOF()
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar produto"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BuscarProduto")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem por Referencia,
    * o unico parametro persistido eh GrPadVens, usado no lookup de vendedor.
    * Retorna .T. se carregou com sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Referencia eh apenas leitura: consulta SigCdCrf/SigCdCrI/
    * SigMvEst e gera preview via REPORT FORM. Retorna .F. para satisfazer
    * contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Refer" + CHR(234) + "ncia (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto por
    * data, empresa, vendedor e filtro de localizacao) para fins de auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCRF|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cCods) + "|" + ;
                     ALLTRIM(THIS.this_cProduto) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     TRANSFORM(THIS.this_nOptLocal)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crRel")
            USE IN crRel
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrfVends")
            USE IN cursor_4c_SigrecrfVends
        ENDIF
        IF USED("cursor_4c_SigrecrfPro")
            USE IN cursor_4c_SigrecrfPro
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

