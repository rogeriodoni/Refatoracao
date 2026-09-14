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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1688 linhas total):

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
676:                 .Themes    = .F.
677:                 .Visible   = .T.
678:             ENDWITH
679: 
680:             WITH .Buttons(2)
681:                 .Caption   = "Somente Lidos"
682:                 .FontName  = "Tahoma"
683:                 .FontSize  = 8
684:                 .BackStyle = 0
685:                 .ForeColor = RGB(90, 90, 90)
686:                 .AutoSize  = .T.
687:                 .Left      = 74
688:                 .Top       = 6
689:                 .Width     = 87
690:                 .Themes    = .F.
691:                 .Visible   = .T.
692:             ENDWITH
693: 
694:             WITH .Buttons(3)
695:                 .Caption   = "N" + CHR(227) + "o Lidos"
696:                 .FontName  = "Tahoma"

*-- Linhas 726 a 1637:
726:     *   Mantido para compatibilidade com pipeline multi-fase.
727:     *   Para forms REPORT o PageFrame permanece sempre em ActivePage=1.
728:     *--------------------------------------------------------------------------
729:     PROCEDURE AlternarPagina(par_nPagina)
730:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
731:             THIS.pgf_4c_Paginas.Visible = .T.
732:             THIS.pgf_4c_Paginas.ActivePage = 1
733:         ENDIF
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * Destroy - Libera BO de relatorio
738:     *--------------------------------------------------------------------------
739:     PROCEDURE Destroy()
740:         IF VARTYPE(THIS.this_oRelatorio) = "O"
741:             THIS.this_oRelatorio = .NULL.
742:         ENDIF
743:         DODEFAULT()
744:     ENDPROC
745: 
746:     *--------------------------------------------------------------------------
747:     * ConfigurarPaginaDados - Vincula eventos BINDEVENT dos controles de filtro
748:     *   FORM REPORT sem Page2: todos os controles ja estao em Page1 (Fase 4).
749:     *   Esta fase conecta os controles existentes aos handlers de evento.
750:     *   Chamado por InicializarForm apos ConfigurarPageFrame.
751:     *--------------------------------------------------------------------------
752:     PROTECTED PROCEDURE ConfigurarPaginaDados()
753:         LOCAL loc_oPagina
754:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
755: 
756:         *-- Vendedor: codigo e descricao (com controle de acesso via SigCdAcJ)
757:         BINDEVENT(loc_oPagina.txt_4c_Conta,        "DblClick", THIS, "AbrirBuscaVendedor")
758:         BINDEVENT(loc_oPagina.txt_4c_Conta,        "KeyPress", THIS, "TeclaVendedor")
759:         BINDEVENT(loc_oPagina.txt_4c_DConta,       "DblClick", THIS, "AbrirBuscaVendedor")
760:         BINDEVENT(loc_oPagina.txt_4c_DConta,       "KeyPress", THIS, "TeclaDescVendedor")
761: 
762:         *-- Grupo Estoque: codigo e descricao (SigCdGcr)
763:         BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
764:         BINDEVENT(loc_oPagina.txt_4c_Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
765:         BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "DblClick", THIS, "AbrirBuscaGrEstoque")
766:         BINDEVENT(loc_oPagina.txt_4c_Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")
767: 
768:         *-- Conta Estoque: codigo e descricao (SigCdCli filtrado por GrEstoque)
769:         BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
770:         BINDEVENT(loc_oPagina.txt_4c_Cd_Estoque,   "KeyPress", THIS, "TeclaCdEstoque")
771:         BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "DblClick", THIS, "AbrirBuscaEstoque")
772:         BINDEVENT(loc_oPagina.txt_4c_Ds_Estoque,   "KeyPress", THIS, "TeclaDsEstoque")
773: 
774:         *-- Produto: codigo e descricao (SigCdPro)
775:         BINDEVENT(loc_oPagina.txt_4c__Produto,     "DblClick", THIS, "AbrirBuscaProduto")
776:         BINDEVENT(loc_oPagina.txt_4c__Produto,     "KeyPress", THIS, "TeclaProduto")
777:         BINDEVENT(loc_oPagina.txt_4c__descricao,   "DblClick", THIS, "AbrirBuscaProduto")
778:         BINDEVENT(loc_oPagina.txt_4c__descricao,   "KeyPress", THIS, "TeclaDescProduto")
779: 
780:         *-- Botoes do relatorio (Visualizar/Imprimir/Excel/Encerrar)
781:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
782:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
783:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
784:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * LimparCampos - Inicializa todos os filtros com valores padrao
789:     *   Data = hoje, demais em branco, OptLocal = 1 (Todos).
790:     *--------------------------------------------------------------------------
791:     PROCEDURE LimparCampos()
792:         LOCAL loc_oPagina
793:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
794:         loc_oPagina.txt_4c_Datas.Value         = DATE()
795:         loc_oPagina.txt_4c_Codigo.Value        = ""
796:         loc_oPagina.txt_4c_Conta.Value         = ""
797:         loc_oPagina.txt_4c_DConta.Value        = ""
798:         loc_oPagina.txt_4c_Cd_GrEstoque.Value  = ""
799:         loc_oPagina.txt_4c_Ds_GrEstoque.Value  = ""
800:         loc_oPagina.txt_4c_Cd_Estoque.Value    = ""
801:         loc_oPagina.txt_4c_Ds_Estoque.Value    = ""
802:         loc_oPagina.txt_4c__Produto.Value      = ""
803:         loc_oPagina.txt_4c__descricao.Value    = ""
804:         loc_oPagina.obj_4c_OptLocal.Value      = 4
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * FormParaRelatorio - Copia valores dos filtros do form para o BO
809:     *   Chamado em BtnVisualizarClick, BtnImprimirClick e BtnExcelClick.
810:     *--------------------------------------------------------------------------
811:     PROTECTED PROCEDURE FormParaRelatorio()
812:         LOCAL loc_oPagina
813:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
814:         WITH THIS.this_oRelatorio
815:             .this_dData        = loc_oPagina.txt_4c_Datas.Value
816:             .this_cCods        = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
817:             .this_cConta       = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
818:             .this_cDConta      = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
819:             .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
820:             .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
821:             .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
822:             .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
823:             .this_cProduto     = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
824:             .this_cDsProduto   = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
825:             .this_nOptLocal    = loc_oPagina.obj_4c_OptLocal.Value
826:         ENDWITH
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * ValidarDataParaRelatorio - Verifica se a data foi informada
831:     *   Equivalente ao "If (This.Value <> 4) If Empty(getDatas.Value)" do legado.
832:     *   Retorna .T. se data valida, .F. se vazia (posiciona foco na data).
833:     *--------------------------------------------------------------------------
834:     PROTECTED PROCEDURE ValidarDataParaRelatorio()
835:         LOCAL loc_oPagina
836:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
837:         IF EMPTY(loc_oPagina.txt_4c_Datas.Value)
838:             MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
839:             loc_oPagina.txt_4c_Datas.SetFocus()
840:             RETURN .F.
841:         ENDIF
842:         RETURN .T.
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * BtnVisualizarClick - Visualiza relatorio em tela (preview)
847:     *   Botao 1 do cmg_4c_Botoes.
848:     *   Equivalente a: REPORT FORM SigReCrf PREVIEW NOCONSOLE
849:     *--------------------------------------------------------------------------
850:     PROCEDURE BtnVisualizarClick()
851:         IF !THIS.ValidarDataParaRelatorio()
852:             RETURN
853:         ENDIF
854:         THIS.FormParaRelatorio()
855:         IF !THIS.this_oRelatorio.Visualizar()
856:             LOCAL loc_cMsg
857:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
858:             IF !EMPTY(loc_cMsg)
859:                 MsgErro(loc_cMsg, "Erro")
860:             ENDIF
861:         ENDIF
862:     ENDPROC
863: 
864:     *--------------------------------------------------------------------------
865:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
866:     *   Botao 2 do cmg_4c_Botoes.
867:     *   Equivalente a: REPORT FORM SigReCrf TO PRINT PROMPT NOCONSOLE
868:     *--------------------------------------------------------------------------
869:     PROCEDURE BtnImprimirClick()
870:         IF !THIS.ValidarDataParaRelatorio()
871:             RETURN
872:         ENDIF
873:         THIS.FormParaRelatorio()
874:         IF !THIS.this_oRelatorio.Imprimir()
875:             LOCAL loc_cMsg
876:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
877:             IF !EMPTY(loc_cMsg)
878:                 MsgErro(loc_cMsg, "Erro")
879:             ENDIF
880:         ENDIF
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * BtnExcelClick - Exporta relatorio para Excel
885:     *   Botao 3 do cmg_4c_Botoes.
886:     *--------------------------------------------------------------------------
887:     PROCEDURE BtnExcelClick()
888:         IF !THIS.ValidarDataParaRelatorio()
889:             RETURN
890:         ENDIF
891:         THIS.FormParaRelatorio()
892:         IF !THIS.this_oRelatorio.GerarExcel()
893:             LOCAL loc_cMsg
894:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
895:             IF !EMPTY(loc_cMsg)
896:                 MsgErro(loc_cMsg, "Erro")
897:             ENDIF
898:         ENDIF
899:     ENDPROC
900: 
901:     *--------------------------------------------------------------------------
902:     * BtnEncerrarClick - Fecha o formulario de relatorio
903:     *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
904:     *--------------------------------------------------------------------------
905:     PROCEDURE BtnEncerrarClick()
906:         THIS.Release()
907:     ENDPROC
908: 
909:     *==========================================================================
910:     *  EVENTOS CRUD-NAMED (mapeados ao contexto de REPORT form)
911:     *  Em forms REPORT (frmrelatorio) os eventos Incluir/Alterar/Excluir
912:     *  nao tem o sentido CRUD tradicional. Sao remapeados para operacoes
913:     *  uteis no fluxo de filtros do relatorio.
914:     *==========================================================================
915: 
916:     *--------------------------------------------------------------------------
917:     * BtnIncluirClick - Em REPORT forms, "Incluir" mapeia para "Novo
918:     * Relatorio": limpa todos os filtros (LimparCampos restaura defaults com
919:     * txt_4c_Datas=DATE() e obj_4c_OptLocal=4 "Todos") e devolve foco ao
920:     * primeiro filtro de data, permitindo o usuario iniciar uma nova consulta
921:     * do zero sem precisar reabrir o formulario.
922:     *--------------------------------------------------------------------------
923:     PROCEDURE BtnIncluirClick()
924:         LOCAL loc_oPagina
925:         THIS.LimparCampos()
926:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
927:         IF VARTYPE(loc_oPagina) = "O" AND VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
928:             loc_oPagina.txt_4c_Datas.SetFocus()
929:         ENDIF
930:     ENDPROC
931: 
932:     *--------------------------------------------------------------------------
933:     * BtnAlterarClick - Em REPORT forms, "Alterar" mapeia para "Alterar
934:     * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
935:     * e devolve o foco ao primeiro filtro de data, permitindo refinar a
936:     * consulta antes de re-Visualizar/Imprimir. Ressincroniza tambem a
937:     * visibilidade do OptLocal com o ComboBox/Datas para manter UI consistente.
938:     *--------------------------------------------------------------------------
939:     PROCEDURE BtnAlterarClick()
940:         LOCAL loc_oPagina
941:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
942:         IF VARTYPE(loc_oPagina) != "O"
943:             RETURN
944:         ENDIF
945:         IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
946:             loc_oPagina.obj_4c_OptLocal.Visible = .T.
947:         ENDIF
948:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
949:             loc_oPagina.txt_4c_Datas.SetFocus()
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
955:     * Filtros" / "Descartar parametros": pede confirmacao e, se confirmado,
956:     * zera todos os filtros via LimparCampos() (restaura txt_4c_Datas=DATE() e
957:     * obj_4c_OptLocal=4) e devolve foco ao primeiro filtro de data. Util
958:     * quando o usuario quer abandonar uma combinacao de filtros e recomecar
959:     * do zero sem fechar o form.
960:     *--------------------------------------------------------------------------
961:     PROCEDURE BtnExcluirClick()
962:         LOCAL loc_oPagina, loc_cMsg
963:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
964:         IF VARTYPE(loc_oPagina) != "O"
965:             RETURN
966:         ENDIF
967:         loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
968:         IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
969:             RETURN
970:         ENDIF
971:         THIS.LimparCampos()
972:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
973:             loc_oPagina.txt_4c_Datas.SetFocus()
974:         ENDIF
975:     ENDPROC
976: 
977:     *==========================================================================
978:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Vendedor (getConta/getDConta)
979:     *==========================================================================
980: 
981:     *--------------------------------------------------------------------------
982:     * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
983:     *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
984:     *--------------------------------------------------------------------------
985:     PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
986:         IF par_nKeyCode = 115
987:             THIS.AbrirBuscaVendedor()
988:         ENDIF
989:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
990:             THIS.ValidarVendedor()
991:         ENDIF
992:     ENDPROC
993: 
994:     *--------------------------------------------------------------------------
995:     * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
996:     *   getDConta.When legado: habilitado apenas quando getConta eh vazio.
997:     *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
998:     *--------------------------------------------------------------------------
999:     PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
1000:         LOCAL loc_oPagina
1001:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1002:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
1003:             RETURN
1004:         ENDIF
1005:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1006:             THIS.ValidarDescVendedor()
1007:         ENDIF
1008:     ENDPROC
1009: 
1010:     *--------------------------------------------------------------------------
1011:     * ValidarVendedor - Limpa descricao se codigo vazio; abre busca caso contrario
1012:     *   Equivalente ao getConta.Valid do legado.
1013:     *--------------------------------------------------------------------------
1014:     PROCEDURE ValidarVendedor()
1015:         LOCAL loc_cValor, loc_oPagina
1016:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1017:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1018:         IF EMPTY(loc_cValor)
1019:             loc_oPagina.txt_4c_DConta.Value = ""
1020:             RETURN
1021:         ENDIF
1022:         THIS.AbrirBuscaVendedor()
1023:     ENDPROC
1024: 
1025:     *--------------------------------------------------------------------------
1026:     * ValidarDescVendedor - Limpa codigo se descricao vazia; abre busca contrario
1027:     *   Equivalente ao getDConta.Valid do legado (busca reversa por rclis).
1028:     *--------------------------------------------------------------------------
1029:     PROCEDURE ValidarDescVendedor()
1030:         LOCAL loc_cValor, loc_oPagina
1031:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1032:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
1033:         IF EMPTY(loc_cValor)
1034:             loc_oPagina.txt_4c_Conta.Value = ""
1035:             RETURN
1036:         ENDIF
1037:         THIS.AbrirBuscaVendedor()
1038:     ENDPROC
1039: 
1040:     *--------------------------------------------------------------------------
1041:     * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
1042:     *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
1043:     *   Filtra SigCdCli pelo GrPadVens e jobs acessiveis ao usuario logado.
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE AbrirBuscaVendedor()
1046:         LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1047:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1048:         loc_cGrPadVens = ""
1049:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1050:             loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
1051:         ENDIF
1052: 
1053:         loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
1054:                    "FROM SigCdCli a " + ;
1055:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1056:                    "AND (b.Coletors <> 10 " + ;
1057:                    "OR (b.Coletors = 10 " + ;
1058:                    "AND a.IClis NOT IN (" + ;
1059:                    "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
1060:                    "WHERE c.Jobs NOT IN (" + ;
1061:                    "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
1062:                    "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
1063:         IF !EMPTY(loc_cGrPadVens)
1064:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrPadVens)
1065:         ENDIF
1066:         loc_cSQL = loc_cSQL + " AND a.Inativas <> 2" + ;
1067:                    " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1068:                    " ORDER BY a.rclis"
1069: 
1070:         IF USED("cursor_4c_BuscaVend")
1071:             USE IN SELECT("cursor_4c_BuscaVend")
1072:         ENDIF
1073:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
1074:         IF loc_nResult > 0
1075:             IF RECCOUNT("cursor_4c_BuscaVend") > 0
1076:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1077:                 IF VARTYPE(loc_oLookup) = "O"
1078:                     loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaVend"
1079:                     loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
1080:                         "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
1081:                     IF loc_oLookup.Mostrar()
1082:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1083:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1084:                     ENDIF
1085:                 ENDIF
1086:             ELSE
1087:                 MsgAviso("Nenhum vendedor encontrado.", "Aviso")
1088:             ENDIF
1089:             IF USED("cursor_4c_BuscaVend")
1090:                 USE IN SELECT("cursor_4c_BuscaVend")
1091:             ENDIF
1092:         ELSE
1093:             MsgErro("Erro ao buscar vendedores.", "Erro")
1094:         ENDIF
1095:     ENDPROC
1096: 
1097:     *==========================================================================
1098:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Grupo de Estoque
1099:     *==========================================================================
1100: 
1101:     *--------------------------------------------------------------------------
1102:     * TeclaCdGrEstoque - Handler KeyPress de txt_4c_Cd_GrEstoque (cod grupo)
1103:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1104:     *--------------------------------------------------------------------------
1105:     PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
1106:         IF par_nKeyCode = 115
1107:             THIS.AbrirBuscaGrEstoque()
1108:         ENDIF
1109:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1110:             THIS.ValidarCdGrEstoque()
1111:         ENDIF
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * TeclaDsGrEstoque - Handler KeyPress de txt_4c_Ds_GrEstoque (desc grupo)
1116:     *   Get_Ds_GrEstoque.When legado: habilitado apenas quando codigo vazio.
1117:     *   ENTER(13) / TAB(9) / F4(115): abre busca de grupo por descricao.
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
1120:         LOCAL loc_oPagina
1121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1122:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1123:             RETURN
1124:         ENDIF
1125:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1126:             THIS.ValidarDsGrEstoque()
1127:         ENDIF
1128:     ENDPROC
1129: 
1130:     *--------------------------------------------------------------------------
1131:     * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
1132:     *   Equivalente ao Get_Cd_GrEstoque.Valid (fAcessoContab 'C') do legado.
1133:     *--------------------------------------------------------------------------
1134:     PROCEDURE ValidarCdGrEstoque()
1135:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
1136:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1137:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1138:         IF EMPTY(loc_cValor)
1139:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
1140:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1141:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1142:             RETURN
1143:         ENDIF
1144:         loc_cSQL = "SELECT TOP 1 b.Codigos, b.Descrs " + ;
1145:                    "FROM SigCdCli a " + ;
1146:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
1147:                    "WHERE a.Grupos = " + EscaparSQL(loc_cValor)
1148:         IF USED("cursor_4c_GrEstVal")
1149:             USE IN SELECT("cursor_4c_GrEstVal")
1150:         ENDIF
1151:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrEstVal")
1152:         IF loc_nResult > 0 AND !EOF("cursor_4c_GrEstVal")
1153:             SELECT cursor_4c_GrEstVal
1154:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Codigos)
1155:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.Descrs)
1156:         ELSE
1157:             MsgAviso("Grupo de estoque n" + CHR(227) + "o encontrado.", "Aviso")
1158:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1159:             loc_oPagina.txt_4c_Ds_GrEstoque.Value = ""
1160:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1161:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1162:             THIS.AbrirBuscaGrEstoque()
1163:         ENDIF
1164:         IF USED("cursor_4c_GrEstVal")
1165:             USE IN SELECT("cursor_4c_GrEstVal")
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * ValidarDsGrEstoque - Valida descricao (busca reversa); abre lookup
1171:     *   Equivalente ao Get_Ds_GrEstoque.Valid (fAcessoContab 'D') do legado.
1172:     *--------------------------------------------------------------------------
1173:     PROCEDURE ValidarDsGrEstoque()
1174:         LOCAL loc_cValor, loc_oPagina
1175:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1176:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_GrEstoque.Value)
1177:         IF EMPTY(loc_cValor)
1178:             loc_oPagina.txt_4c_Cd_GrEstoque.Value = ""
1179:             loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1180:             loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1181:             RETURN
1182:         ENDIF
1183:         THIS.AbrirBuscaGrEstoque()
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * AbrirBuscaGrEstoque - Lista grupos de estoque/contab (SigCdGcr)
1188:     *   Equivalente ao fAcessoContab do legado para selecao de grupo.
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE AbrirBuscaGrEstoque()
1191:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1192:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1193:         IF USED("cursor_4c_BuscaGrEst")
1194:             USE IN SELECT("cursor_4c_BuscaGrEst")
1195:         ENDIF
1196:         loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
1197:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrEst")
1198:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaGrEst") > 0
1199:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1200:             IF VARTYPE(loc_oLookup) = "O"
1201:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaGrEst"
1202:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaGrEst", "Codigos", "Descrs", ;
1203:                     "Grupo de Estoque")
1204:                 IF loc_oLookup.Mostrar()
1205:                     loc_oPagina.txt_4c_Cd_GrEstoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1206:                     loc_oPagina.txt_4c_Ds_GrEstoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1207:                     loc_oPagina.txt_4c_Cd_Estoque.Value   = ""
1208:                     loc_oPagina.txt_4c_Ds_Estoque.Value   = ""
1209:                 ENDIF
1210:             ENDIF
1211:         ELSE
1212:             MsgAviso("Nenhum grupo de estoque encontrado.", "Aviso")
1213:         ENDIF
1214:         IF USED("cursor_4c_BuscaGrEst")
1215:             USE IN SELECT("cursor_4c_BuscaGrEst")
1216:         ENDIF
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Conta de Estoque
1221:     *==========================================================================
1222: 
1223:     *--------------------------------------------------------------------------
1224:     * TeclaCdEstoque - Handler KeyPress de txt_4c_Cd_Estoque (cod conta)
1225:     *   Bloqueia entrada se GrEstoque nao informado (equivalente ao When legado).
1226:     *   ENTER(13) / TAB(9): valida codigo | F4(115): abre busca direta
1227:     *--------------------------------------------------------------------------
1228:     PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
1229:         LOCAL loc_oPagina
1230:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1231:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1232:             MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
1233:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1234:             RETURN
1235:         ENDIF
1236:         IF par_nKeyCode = 115
1237:             THIS.AbrirBuscaEstoque()
1238:         ENDIF
1239:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1240:             THIS.ValidarCdEstoque()
1241:         ENDIF
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * TeclaDsEstoque - Handler KeyPress de txt_4c_Ds_Estoque (desc conta)
1246:     *   Get_Ds_Estoque.When legado: habilitado apenas quando codigo vazio.
1247:     *   ENTER(13) / TAB(9) / F4(115): abre busca de conta por descricao.
1248:     *--------------------------------------------------------------------------
1249:     PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
1250:         LOCAL loc_oPagina
1251:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1252:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value))
1253:             RETURN
1254:         ENDIF
1255:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value))
1256:             MsgAviso("Informe o Grupo de Estoque antes.", "Aviso")
1257:             RETURN
1258:         ENDIF
1259:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1260:             THIS.ValidarDsEstoque()
1261:         ENDIF
1262:     ENDPROC
1263: 
1264:     *--------------------------------------------------------------------------
1265:     * ValidarCdEstoque - Valida codigo da conta de estoque (SigCdCli)
1266:     *   Equivalente ao Get_Cd_Estoque.Valid (fAcessoContas 'C') do legado.
1267:     *   Filtra SigCdCli pelo grupo de estoque selecionado.
1268:     *--------------------------------------------------------------------------
1269:     PROCEDURE ValidarCdEstoque()
1270:         LOCAL loc_cValor, loc_cGrupo, loc_cSQL, loc_nResult, loc_oPagina
1271:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1272:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Cd_Estoque.Value)
1273:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1274:         IF EMPTY(loc_cValor)
1275:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1276:             RETURN
1277:         ENDIF
1278:         loc_cSQL = "SELECT TOP 1 a.IClis, a.RClis " + ;
1279:                    "FROM SigCdCli a " + ;
1280:                    "WHERE a.IClis = " + EscaparSQL(loc_cValor)
1281:         IF !EMPTY(loc_cGrupo)
1282:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1283:         ENDIF
1284:         IF USED("cursor_4c_EstVal")
1285:             USE IN SELECT("cursor_4c_EstVal")
1286:         ENDIF
1287:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EstVal")
1288:         IF loc_nResult > 0 AND !EOF("cursor_4c_EstVal")
1289:             SELECT cursor_4c_EstVal
1290:             loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_EstVal.IClis)
1291:             loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_EstVal.RClis)
1292:         ELSE
1293:             MsgAviso("Conta de estoque n" + CHR(227) + "o encontrada.", "Aviso")
1294:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1295:             loc_oPagina.txt_4c_Ds_Estoque.Value = ""
1296:             THIS.AbrirBuscaEstoque()
1297:         ENDIF
1298:         IF USED("cursor_4c_EstVal")
1299:             USE IN SELECT("cursor_4c_EstVal")
1300:         ENDIF
1301:     ENDPROC
1302: 
1303:     *--------------------------------------------------------------------------
1304:     * ValidarDsEstoque - Valida descricao da conta; abre busca reversa
1305:     *   Equivalente ao Get_Ds_Estoque.Valid (fAcessoContas 'D') do legado.
1306:     *--------------------------------------------------------------------------
1307:     PROCEDURE ValidarDsEstoque()
1308:         LOCAL loc_cValor, loc_oPagina
1309:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1310:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_Ds_Estoque.Value)
1311:         IF EMPTY(loc_cValor)
1312:             loc_oPagina.txt_4c_Cd_Estoque.Value = ""
1313:             RETURN
1314:         ENDIF
1315:         THIS.AbrirBuscaEstoque()
1316:     ENDPROC
1317: 
1318:     *--------------------------------------------------------------------------
1319:     * AbrirBuscaEstoque - Lista contas de estoque (SigCdCli) filtradas por grupo
1320:     *   Equivalente ao fAcessoContas do legado para selecao de conta de estoque.
1321:     *--------------------------------------------------------------------------
1322:     PROCEDURE AbrirBuscaEstoque()
1323:         LOCAL loc_cGrupo, loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1324:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1325:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Cd_GrEstoque.Value)
1326:         IF USED("cursor_4c_BuscaEst")
1327:             USE IN SELECT("cursor_4c_BuscaEst")
1328:         ENDIF
1329:         loc_cSQL = "SELECT a.IClis AS Cods, a.RClis AS Descs " + ;
1330:                    "FROM SigCdCli a " + ;
1331:                    "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
1332:         IF !EMPTY(loc_cGrupo)
1333:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1334:         ENDIF
1335:         loc_cSQL = loc_cSQL + " ORDER BY a.RClis"
1336:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")
1337:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEst") > 0
1338:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1339:             IF VARTYPE(loc_oLookup) = "O"
1340:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaEst"
1341:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaEst", "Cods", "Descs", ;
1342:                     "Conta de Estoque")
1343:                 IF loc_oLookup.Mostrar()
1344:                     loc_oPagina.txt_4c_Cd_Estoque.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1345:                     loc_oPagina.txt_4c_Ds_Estoque.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1346:                 ENDIF
1347:             ENDIF
1348:         ELSE
1349:             MsgAviso("Nenhuma conta de estoque encontrada.", "Aviso")
1350:         ENDIF
1351:         IF USED("cursor_4c_BuscaEst")
1352:             USE IN SELECT("cursor_4c_BuscaEst")
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     *  HANDLERS DE TECLADO + VALIDACAO + LOOKUP - Produto (get_Produto/get_descricao)
1358:     *==========================================================================
1359: 
1360:     *--------------------------------------------------------------------------
1361:     * TeclaProduto - Handler KeyPress de txt_4c__Produto (codigo do produto)
1362:     *   ENTER(13) / TAB(9): valida codigo digitado | F4(115): abre busca direta
1363:     *--------------------------------------------------------------------------
1364:     PROCEDURE TeclaProduto(par_nKeyCode, par_nShiftAltCtrl)
1365:         IF par_nKeyCode = 115
1366:             THIS.AbrirBuscaProduto()
1367:         ENDIF
1368:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1369:             THIS.ValidarProduto()
1370:         ENDIF
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     * TeclaDescProduto - Handler KeyPress de txt_4c__descricao (desc produto)
1375:     *   get_descricao.When legado: habilitado apenas quando codigo vazio.
1376:     *   ENTER(13) / TAB(9) / F4(115): abre busca de produto por descricao.
1377:     *--------------------------------------------------------------------------
1378:     PROCEDURE TeclaDescProduto(par_nKeyCode, par_nShiftAltCtrl)
1379:         LOCAL loc_oPagina
1380:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1381:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c__Produto.Value))
1382:             RETURN
1383:         ENDIF
1384:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1385:             THIS.ValidarDescProduto()
1386:         ENDIF
1387:     ENDPROC
1388: 
1389:     *--------------------------------------------------------------------------
1390:     * ValidarProduto - Valida codigo do produto (SigCdPro.cpros)
1391:     *   Equivalente ao get_Produto.Valid (fwBuscaExt SigCdPro cpros) do legado.
1392:     *--------------------------------------------------------------------------
1393:     PROCEDURE ValidarProduto()
1394:         LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPagina
1395:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1396:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Produto.Value)
1397:         IF EMPTY(loc_cValor)
1398:             loc_oPagina.txt_4c__descricao.Value = ""
1399:             RETURN
1400:         ENDIF
1401:         loc_cSQL = "SELECT TOP 1 cpros, dpros FROM SigCdPro " + ;
1402:                    "WHERE cpros = " + EscaparSQL(loc_cValor)
1403:         IF USED("cursor_4c_ProdVal")
1404:             USE IN SELECT("cursor_4c_ProdVal")
1405:         ENDIF
1406:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1407:         IF loc_nResult > 0 AND !EOF("cursor_4c_ProdVal")
1408:             SELECT cursor_4c_ProdVal
1409:             loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(cursor_4c_ProdVal.cpros)
1410:             loc_oPagina.txt_4c__descricao.Value = ALLTRIM(cursor_4c_ProdVal.dpros)
1411:         ELSE
1412:             MsgAviso("Produto n" + CHR(227) + "o encontrado.", "Aviso")
1413:             loc_oPagina.txt_4c__Produto.Value   = ""
1414:             loc_oPagina.txt_4c__descricao.Value = ""
1415:             THIS.AbrirBuscaProduto()
1416:         ENDIF
1417:         IF USED("cursor_4c_ProdVal")
1418:             USE IN SELECT("cursor_4c_ProdVal")
1419:         ENDIF
1420:     ENDPROC
1421: 
1422:     *--------------------------------------------------------------------------
1423:     * ValidarDescProduto - Valida descricao (busca reversa em SigCdPro.dpros)
1424:     *   Equivalente ao get_descricao.Valid (fwBuscaExt SigCdPro DPros) do legado.
1425:     *--------------------------------------------------------------------------
1426:     PROCEDURE ValidarDescProduto()
1427:         LOCAL loc_cValor, loc_oPagina
1428:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1429:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__descricao.Value)
1430:         IF EMPTY(loc_cValor)
1431:             loc_oPagina.txt_4c__Produto.Value = ""
1432:             RETURN
1433:         ENDIF
1434:         THIS.AbrirBuscaProduto()
1435:     ENDPROC
1436: 
1437:     *--------------------------------------------------------------------------
1438:     * AbrirBuscaProduto - Lista produtos (SigCdPro) por codigo ou descricao
1439:     *   Equivalente ao fwBuscaExt SigCdPro do legado para selecao de produto.
1440:     *--------------------------------------------------------------------------
1441:     PROCEDURE AbrirBuscaProduto()
1442:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPagina
1443:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1444:         IF USED("cursor_4c_BuscaProd")
1445:             USE IN SELECT("cursor_4c_BuscaProd")
1446:         ENDIF
1447:         loc_cSQL    = "SELECT cpros, dpros FROM SigCdPro ORDER BY dpros"
1448:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")
1449:         IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
1450:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1451:             IF VARTYPE(loc_oLookup) = "O"
1452:                 loc_oLookup.this_cCursorDestino = "cursor_4c_BuscaProd"
1453:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
1454:                     "Sele" + CHR(231) + CHR(227) + "o de Produto")
1455:                 IF loc_oLookup.Mostrar()
1456:                     loc_oPagina.txt_4c__Produto.Value   = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1457:                     loc_oPagina.txt_4c__descricao.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1458:                 ENDIF
1459:             ENDIF
1460:         ELSE
1461:             MsgAviso("Nenhum produto encontrado.", "Aviso")
1462:         ENDIF
1463:         IF USED("cursor_4c_BuscaProd")
1464:             USE IN SELECT("cursor_4c_BuscaProd")
1465:         ENDIF
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * ConfigurarPermissoesOptLocal - Controla visibilidade das opcoes do OptLocal
1470:     *   No original: se usuario NAO tem acesso DIFERENCA e nao e '4CONTROL',
1471:     *   esconde opcoes 1,2,3 (mostra apenas "Diferencas"). Caso contrario, todas.
1472:     *   Na nova arquitetura sem fChecaAcesso, default = mostrar todas as opcoes.
1473:     *--------------------------------------------------------------------------
1474:     PROTECTED PROCEDURE ConfigurarPermissoesOptLocal()
1475:         LOCAL loc_oPagina, loc_lMostrarTodas, loc_cUsuario
1476:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
1477:         loc_lMostrarTodas = .T.
1478:         loc_cUsuario     = ""
1479:         IF TYPE("gc_4c_UsuarioLogado") = "C"
1480:             loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
1481:         ENDIF
1482: 
1483:         *-- Verificar flag de restricao no BO (set durante Init do BO)
1484:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1485:             IF PEMSTATUS(THIS.this_oRelatorio, "this_lAcessoSomentesDif", 5)
1486:                 IF THIS.this_oRelatorio.this_lAcessoSomentesDif AND ;
1487:                    UPPER(loc_cUsuario) <> "4CONTROL"
1488:                     loc_lMostrarTodas = .F.
1489:                 ENDIF
1490:             ENDIF
1491:         ENDIF
1492: 
1493:         WITH loc_oPagina.obj_4c_OptLocal
1494:             .Buttons(1).Visible = loc_lMostrarTodas
1495:             .Buttons(2).Visible = loc_lMostrarTodas
1496:             .Buttons(3).Visible = loc_lMostrarTodas
1497:             .Buttons(4).Visible = .T.
1498:             IF !loc_lMostrarTodas
1499:                 .Value = 4
1500:             ENDIF
1501:         ENDWITH
1502:     ENDPROC
1503: 
1504: 
1505:     *==========================================================================
1506:     *  FASE 8/8 - METODOS AUXILIARES E COMPATIBILIDADE COM PIPELINE MULTI-FASE
1507:     *  Em forms REPORT (frmrelatorio) nao existem modos CRUD nem grid de lista.
1508:     *  Os metodos abaixo existem para satisfazer o contrato do pipeline multi-fase
1509:     *  e para fornecer comportamentos uteis mapeados ao contexto do relatorio.
1510:     *==========================================================================
1511: 
1512:     *--------------------------------------------------------------------------
1513:     * CarregarLista - Compatibilidade com pipeline CRUD (REPORT: sem lista)
1514:     *   Em forms REPORT nao ha grid de lista para recarregar. Retorna .T.
1515:     *   para indicar sucesso ao pipeline que chama este metodo apos Incluir.
1516:     *--------------------------------------------------------------------------
1517:     PROCEDURE CarregarLista()
1518:         RETURN .T.
1519:     ENDPROC
1520: 
1521:     *--------------------------------------------------------------------------
1522:     * HabilitarCampos - Habilita ou desabilita todos os campos de filtro
1523:     *   par_lHabilitar: .T. = habilitar todos, .F. = desabilitar todos.
1524:     *   Sem par_lHabilitar (ou tipo invalido) assume .T. (habilitar).
1525:     *   Em forms REPORT o padrao eh sempre habilitado (sem modo VISUALIZAR).
1526:     *--------------------------------------------------------------------------
1527:     PROCEDURE HabilitarCampos(par_lHabilitar)
1528:         LOCAL loc_lHab, loc_oPagina
1529:         loc_lHab    = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1530:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1531:         IF VARTYPE(loc_oPagina) != "O"
1532:             RETURN
1533:         ENDIF
1534:         IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1535:             loc_oPagina.txt_4c_Datas.Enabled = loc_lHab
1536:         ENDIF
1537:         IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1538:             loc_oPagina.txt_4c_Codigo.Enabled = loc_lHab
1539:         ENDIF
1540:         IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
1541:             loc_oPagina.txt_4c_Conta.Enabled = loc_lHab
1542:         ENDIF
1543:         IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
1544:             loc_oPagina.txt_4c_DConta.Enabled = loc_lHab
1545:         ENDIF
1546:         IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
1547:             loc_oPagina.txt_4c_Cd_GrEstoque.Enabled = loc_lHab
1548:         ENDIF
1549:         IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
1550:             loc_oPagina.txt_4c_Ds_GrEstoque.Enabled = loc_lHab
1551:         ENDIF
1552:         IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
1553:             loc_oPagina.txt_4c_Cd_Estoque.Enabled = loc_lHab
1554:         ENDIF
1555:         IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
1556:             loc_oPagina.txt_4c_Ds_Estoque.Enabled = loc_lHab
1557:         ENDIF
1558:         IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
1559:             loc_oPagina.txt_4c__Produto.Enabled = loc_lHab
1560:         ENDIF
1561:         IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
1562:             loc_oPagina.txt_4c__descricao.Enabled = loc_lHab
1563:         ENDIF
1564:         IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"
1565:             loc_oPagina.obj_4c_OptLocal.Enabled = loc_lHab
1566:         ENDIF
1567:     ENDPROC
1568: 
1569:     *--------------------------------------------------------------------------
1570:     * AjustarBotoesPorModo - Compatibilidade com pipeline CRUD
1571:     *   Em forms REPORT nao ha modos CRUD. Os 4 botoes do cmg_4c_Botoes ficam
1572:     *   sempre habilitados (Visualizar/Imprimir/Excel/Encerrar).
1573:     *--------------------------------------------------------------------------
1574:     PROCEDURE AjustarBotoesPorModo()
1575:         IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
1576:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
1577:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1578:             THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
1579:             THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
1580:         ENDIF
1581:     ENDPROC
1582: 
1583:     *--------------------------------------------------------------------------
1584:     * FormParaBO - Compatibilidade com pipeline CRUD
1585:     *   Delega para FormParaRelatorio() que copia valores dos filtros do form
1586:     *   para as propriedades this_* do sigrecrfBO.
1587:     *--------------------------------------------------------------------------
1588:     PROTECTED PROCEDURE FormParaBO()
1589:         THIS.FormParaRelatorio()
1590:     ENDPROC
1591: 
1592:     *--------------------------------------------------------------------------
1593:     * BOParaForm - Carrega propriedades do BO de relatorio de volta ao form
1594:     *   Restaura os campos de filtro com os valores que estao no BO.
1595:     *   Util apos uma operacao que atualizou o BO externamente.
1596:     *--------------------------------------------------------------------------
1597:     PROTECTED PROCEDURE BOParaForm()
1598:         LOCAL loc_oPagina
1599:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1600:             RETURN
1601:         ENDIF
1602:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1603:         IF VARTYPE(loc_oPagina) != "O"
1604:             RETURN
1605:         ENDIF
1606:         WITH THIS.this_oRelatorio
1607:             IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1608:                 loc_oPagina.txt_4c_Datas.Value = IIF(EMPTY(.this_dData), DATE(), .this_dData)
1609:             ENDIF
1610:             IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
1611:                 loc_oPagina.txt_4c_Codigo.Value = .this_cCods
1612:             ENDIF
1613:             IF VARTYPE(loc_oPagina.txt_4c_Conta) = "O"
1614:                 loc_oPagina.txt_4c_Conta.Value = .this_cConta
1615:             ENDIF
1616:             IF VARTYPE(loc_oPagina.txt_4c_DConta) = "O"
1617:                 loc_oPagina.txt_4c_DConta.Value = .this_cDConta
1618:             ENDIF
1619:             IF VARTYPE(loc_oPagina.txt_4c_Cd_GrEstoque) = "O"
1620:                 loc_oPagina.txt_4c_Cd_GrEstoque.Value = .this_cCdGrEstoque
1621:             ENDIF
1622:             IF VARTYPE(loc_oPagina.txt_4c_Ds_GrEstoque) = "O"
1623:                 loc_oPagina.txt_4c_Ds_GrEstoque.Value = .this_cDsGrEstoque
1624:             ENDIF
1625:             IF VARTYPE(loc_oPagina.txt_4c_Cd_Estoque) = "O"
1626:                 loc_oPagina.txt_4c_Cd_Estoque.Value = .this_cCdEstoque
1627:             ENDIF
1628:             IF VARTYPE(loc_oPagina.txt_4c_Ds_Estoque) = "O"
1629:                 loc_oPagina.txt_4c_Ds_Estoque.Value = .this_cDsEstoque
1630:             ENDIF
1631:             IF VARTYPE(loc_oPagina.txt_4c__Produto) = "O"
1632:                 loc_oPagina.txt_4c__Produto.Value = .this_cProduto
1633:             ENDIF
1634:             IF VARTYPE(loc_oPagina.txt_4c__descricao) = "O"
1635:                 loc_oPagina.txt_4c__descricao.Value = .this_cDsProduto
1636:             ENDIF
1637:             IF VARTYPE(loc_oPagina.obj_4c_OptLocal) = "O"

*-- Linhas 1645 a 1688:
1645:     *   Valida data (exceto OptLocal=4), copia filtros para BO e exibe relatorio.
1646:     *   Equivalente semantico ao "Buscar" em forms CRUD que carrega a lista.
1647:     *--------------------------------------------------------------------------
1648:     PROCEDURE BtnBuscarClick()
1649:         THIS.BtnVisualizarClick()
1650:     ENDPROC
1651: 
1652:     *--------------------------------------------------------------------------
1653:     * BtnSalvarClick - Em REPORT forms, "Salvar" = Imprimir (direto na impressora)
1654:     *   Valida data, copia filtros para BO e imprime sem dialogo de impressora.
1655:     *   Equivalente semantico ao "Salvar" de forms CRUD (persistir resultado).
1656:     *--------------------------------------------------------------------------
1657:     PROCEDURE BtnSalvarClick()
1658:         IF !THIS.ValidarDataParaRelatorio()
1659:             RETURN
1660:         ENDIF
1661:         THIS.FormParaRelatorio()
1662:         IF !THIS.this_oRelatorio.Imprimir()
1663:             LOCAL loc_cMsg
1664:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1665:             IF !EMPTY(loc_cMsg)
1666:                 MsgErro(loc_cMsg, "Erro")
1667:             ENDIF
1668:         ENDIF
1669:     ENDPROC
1670: 
1671:     *--------------------------------------------------------------------------
1672:     * BtnCancelarClick - Em REPORT forms, "Cancelar" = Limpar filtros
1673:     *   Restaura todos os campos de filtro para seus valores padrao (LimparCampos)
1674:     *   e posiciona foco no campo de data para nova consulta.
1675:     *   Equivalente semantico ao "Cancelar" de forms CRUD (descartar edicao).
1676:     *--------------------------------------------------------------------------
1677:     PROCEDURE BtnCancelarClick()
1678:         LOCAL loc_oPagina
1679:         THIS.LimparCampos()
1680:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1681:         IF VARTYPE(loc_oPagina) = "O"
1682:             IF VARTYPE(loc_oPagina.txt_4c_Datas) = "O"
1683:                 loc_oPagina.txt_4c_Datas.SetFocus()
1684:             ENDIF
1685:         ENDIF
1686:     ENDPROC
1687: 
1688: ENDDEFINE


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

