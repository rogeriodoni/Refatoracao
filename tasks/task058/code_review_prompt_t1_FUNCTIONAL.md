# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGRECNT): Top original=134 vs migrado 'lbl_4c_Label2' Top=49 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGRECNT): Top original=270 vs migrado 'lbl_4c_Label4' Top=185 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGRECNT): Top original=294 vs migrado 'lbl_4c_Label9' Top=209 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGRECNT): Top original=162 vs migrado 'lbl_4c_Label7' Top=77 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGRECNT): Top original=190 vs migrado 'lbl_4c_Label6' Top=105 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGRECNT): Top original=218 vs migrado 'lbl_4c_Label5' Top=133 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGRECNT): Top original=246 vs migrado 'lbl_4c_Label8' Top=161 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGRECNT): Top original=105 vs migrado 'lbl_4c_Label3' Top=20 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGRECNT): Top original=106 vs migrado 'lbl_4c_Label1' Top=21 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Top original=265 vs migrado 'obj_4c_OptLocal' Top=4 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptLocal' (parent: SIGRECNT): Left original=231 vs migrado 'obj_4c_OptLocal' Left=2 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGRECNT): Top original=289 vs migrado 'obj_4c_OptOrdem' Top=4 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptOrdem' (parent: SIGRECNT): Left original=231 vs migrado 'obj_4c_OptOrdem' Left=2 (diff=229px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1457 linhas total):

*-- Linhas 6 a 199:
6: *
7: * Form: 800 x 350 (EXATO do original layout.json)
8: * Filtros: Data, Vendedor/Conta, Localiza" + CHR(231) + CHR(245) + "es (Base/N" + CHR(237) + "vel 2/3/4),
9: *          C" + CHR(243) + "digo, OptionGroups Local e Ordena" + CHR(231) + CHR(227) + "o
10: *
11: * FASE 7/8 - Form - Eventos Principais (REPORT: conclu" + CHR(237) + "do na Fase 6)
12: *   Forms REPORT nao tem BtnIncluirClick/BtnAlterarClick/BtnExcluirClick.
13: *   Todos os eventos de bot" + CHR(245) + "es ja foram implementados na Fase 6:
14: *   BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
15: *
16: * FASE 3/8 - Form - Estrutura Base
17: *   * Propriedades visuais do form (Width=800, Height=350)
18: *   * Init() / InicializarForm() / Destroy()
19: *   * ConfigurarCabecalho()  (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
20: *   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
21: *   * ConfigurarPageFrame()  (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
22: *
23: * FASE 5/8 - Form - BINDEVENTs dos campos de filtro (primeira metade)
24: *   * ConfigurarPaginaDados() com BINDEVENT para Conta, DConta, Base, Nvl2
25: *   * TeclaVendedor / ValidarVendedor / AbrirBuscaVendedor
26: *   * TeclaDescVendedor / ValidarDescVendedor
27: *   * TeclaBase / ValidarBase / AbrirBuscaBase / LimparBaseDescendentes
28: *   * TeclaNvl2 / ValidarNvl2 / AbrirBuscaNvl2 / LimparNvl2Descendentes
29: *
30: * FASE 6/8 - Form - Campos Restantes e Lookups (segunda metade)
31: *   * BINDEVENTs para Nvl3, Nvl4 e botoes do relatorio (cmg_4c_Botoes)
32: *   * TeclaNvl3 / ValidarNvl3 / AbrirBuscaNvl3 / LimparNvl3Descendentes
33: *   * TeclaNvl4 / ValidarNvl4 / AbrirBuscaNvl4 / LimparNvl4Descendentes
34: *   * ValidarDataParaRelatorio (guard clause pre-execucao)
35: *   * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
36: *
37: * FASE 4/8 - Form - Conte" + CHR(250) + "do da Page1 + Alterna" + CHR(231) + CHR(227) + "o de p" + CHR(225) + "gina
38: *   * ConfigurarPaginaLista() - Adiciona 20 controles de filtro " + CHR(224) + " Page1:
39: *       - Labels e TextBoxes para Data, C" + CHR(243) + "digo, Vendedor (cod+desc),
40: *         Base, N" + CHR(237) + "vel 2/3/4 (cada um com cod+desc), totalizando 16 fields.
41: *       - 2 OptionGroups: OptLocal (4 op: Todos/Contados/N" + CHR(227) + "o Contados/Divergentes)
42: *         e OptOrdem (4 op: Local/N" + CHR(237) + "vel 2/N" + CHR(237) + "vel 3/N" + CHR(237) + "vel 4).
43: *       - Campos de descri" + CHR(231) + CHR(227) + "o ReadOnly=.T. com fundo cinza claro.
44: *   * AlternarPagina(par_nPagina) - Alterna ActivePage do PageFrame.
45: *   * LimparCampos() - Redefine filtros para valores padr" + CHR(227) + "o.
46: *   * FormParaRelatorio() - Transfere filtros do form para o BO.
47: *
48: *   NOTA: Este " + CHR(233) + " um form REPORT, ent" + CHR(227) + "o cnt_4c_Botoes (CRUD) N" + CHR(195) + "O existe.
49: *   Os bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar/Imprimir/Excel/Encerrar) j" + CHR(225) + " est" + CHR(227) + "o
50: *   no cmg_4c_Botoes criado na Fase 3 (padr" + CHR(227) + "o frmrelatorio framework.vcx).
51: *==============================================================================
52: 
53: DEFINE CLASS Formsigrecnt AS FormBase
54: 
55:     *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=350)
56:     Height      = 350
57:     Width       = 800
58:     DataSession = 2
59:     ShowWindow  = 1
60:     WindowType  = 1
61:     AutoCenter  = .T.
62:     BorderStyle = 2
63:     ControlBox  = .F.
64:     MaxButton   = .F.
65:     MinButton   = .F.
66:     TitleBar    = 0
67:     Themes      = .F.
68:     ShowTips    = .T.
69: 
70:     *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
71:     this_oRelatorio    = .NULL.
72:     this_cMensagemErro = ""
73: 
74:     *--------------------------------------------------------------------------
75:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
76:     *--------------------------------------------------------------------------
77:     PROCEDURE Init()
78:         RETURN DODEFAULT()
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
83:     *   1. Define Caption / Picture (fundo)
84:     *   2. Cria sigrecntBO e carrega par" + CHR(226) + "metros iniciais (pula em modo UI)
85:     *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
86:     *--------------------------------------------------------------------------
87:     PROTECTED PROCEDURE InicializarForm()
88:         LOCAL loc_lSucesso, loc_lContinuar
89:         loc_lSucesso   = .F.
90:         loc_lContinuar = .T.
91:         TRY
92:             THIS.Caption = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
93:                            "Localiza" + CHR(231) + CHR(227) + "o"
94: 
95:             IF TYPE("gc_4c_CaminhoIcones") = "U"
96:                 gc_4c_CaminhoIcones = ""
97:             ENDIF
98:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99: 
100:             *-- Instanciar BO de relat" + CHR(243) + "rio
101:             THIS.this_oRelatorio = CREATEOBJECT("sigrecntBO")
102:             IF VARTYPE(THIS.this_oRelatorio) != "O"
103:                 MsgErro("Erro ao criar sigrecntBO" + CHR(13) + ;
104:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
105:                 loc_lContinuar = .F.
106:             ENDIF
107: 
108:             *-- Carregar par" + CHR(226) + "metros iniciais (GrPadVens e cursores de n" + CHR(237) + "vel).
109:             *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
110:             IF loc_lContinuar AND ;
111:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
112:                 IF !THIS.this_oRelatorio.CarregarParametros()
113:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
114:                     loc_lContinuar = .F.
115:                 ENDIF
116:             ENDIF
117: 
118:             IF loc_lContinuar
119:                 *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
120:                 THIS.ConfigurarCabecalho()
121: 
122:                 *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
123:                 THIS.ConfigurarBotoes()
124: 
125:                 *-- PageFrame com p" + CHR(225) + "gina de filtros
126:                 THIS.ConfigurarPageFrame()
127: 
128:                 *-- Controles de filtro na Page1 (m" + CHR(233) + "todo " + CHR(233) + " "ConfigurarPaginaLista"
129:                 *-- por compatibilidade com o esqueleto, embora a Page1 deste
130:                 *-- form REPORT contenha filtros e n" + CHR(227) + "o uma lista CRUD).
131:                 THIS.ConfigurarPaginaLista()
132: 
133:                 *-- BINDEVENT dos campos de filtro interativos (Fase 5/6)
134:                 THIS.ConfigurarPaginaDados()
135: 
136:                 *-- Redefine filtros para valores padr" + CHR(227) + "o
137:                 THIS.LimparCampos()
138: 
139:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
140:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
141: 
142:                 THIS.Visible = .T.
143:                 loc_lSucesso = .T.
144:             ENDIF
145:         CATCH TO loc_oErro
146:             THIS.this_cMensagemErro = loc_oErro.Message
147:             MsgErro(loc_oErro.Message + CHR(13) + ;
148:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
149:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
150:         ENDTRY
151:         RETURN loc_lSucesso
152:     ENDPROC
153: 
154:     *--------------------------------------------------------------------------
155:     * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
156:     *   Equivalente ao cntSombra do frmrelatorio legado.
157:     *   Largura = Width do form (cobre toda a faixa superior).
158:     *--------------------------------------------------------------------------
159:     PROTECTED PROCEDURE ConfigurarCabecalho()
160:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
161:         WITH THIS.cnt_4c_Cabecalho
162:             .Top         = 0
163:             .Left        = 0
164:             .Width       = THIS.Width
165:             .Height      = 80
166:             .BackStyle   = 1
167:             .BackColor   = RGB(100, 100, 100)
168:             .BorderWidth = 0
169:             .Visible     = .T.
170: 
171:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
172:             .AddObject("lbl_4c_Sombra", "Label")
173:             WITH .lbl_4c_Sombra
174:                 .Top       = 22
175:                 .Left      = 22
176:                 .Width     = THIS.Width
177:                 .Height    = 30
178:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
179:                              "Localiza" + CHR(231) + CHR(227) + "o"
180:                 .FontName  = "Tahoma"
181:                 .FontSize  = 14
182:                 .FontBold  = .T.
183:                 .ForeColor = RGB(0, 0, 0)
184:                 .BackStyle = 0
185:                 .Visible   = .T.
186:             ENDWITH
187: 
188:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
189:             .AddObject("lbl_4c_Titulo", "Label")
190:             WITH .lbl_4c_Titulo
191:                 .Top       = 20
192:                 .Left      = 20
193:                 .Width     = THIS.Width
194:                 .Height    = 30
195:                 .Caption   = "Rela" + CHR(231) + CHR(227) + "o de Contagem por " + ;
196:                              "Localiza" + CHR(231) + CHR(227) + "o"
197:                 .FontName  = "Tahoma"
198:                 .FontSize  = 14
199:                 .FontBold  = .T.

*-- Linhas 208 a 253:
208:     * ConfigurarBotoes - CommandGroup com bot" + CHR(245) + "es de relat" + CHR(243) + "rio (btnReport " + CHR(225) + "rea)
209:     *   Original: btnReport.Top=0, Left=529, Width=273, Height=80, ButtonCount=4
210:     *   Bot" + CHR(245) + "es: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
211:     *   Eventos Click vinculados em InicializarForm (Fase 7).
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarBotoes()
214:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
215:         WITH THIS.cmg_4c_Botoes
216:             .Top           = 0
217:             .Left          = 529
218:             .Width         = 273
219:             .Height        = 80
220:             .ButtonCount   = 4
221:             .BackStyle     = 0
222:             .BorderStyle   = 0
223:             .BorderColor   = RGB(136, 189, 188)
224:             .SpecialEffect = 1
225:             .Themes        = .F.
226:             .Visible       = .T.
227: 
228:             *-- Visualizar (preview em tela)
229:             WITH .Buttons(1)
230:                 .Top             = 5
231:                 .Left            = 5
232:                 .Width           = 65
233:                 .Height          = 70
234:                 .Caption         = "Visualizar"
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .BackColor       = RGB(255, 255, 255)
238:                 .ForeColor       = RGB(90, 90, 90)
239:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
240:                 .PicturePosition = 13
241:                 .SpecialEffect   = 0
242:                 .MousePointer    = 15
243:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
244:                 .Themes          = .F.
245:                 .Visible         = .T.
246:             ENDWITH
247: 
248:             *-- Imprimir (impressora padr" + CHR(227) + "o)
249:             WITH .Buttons(2)
250:                 .Top             = 5
251:                 .Left            = 71
252:                 .Width           = 65
253:                 .Height          = 70

*-- Linhas 324 a 406:
324:     *   at" + CHR(233) + " o fim do form.
325:     *   Os campos de filtro s" + CHR(227) + "o adicionados " + CHR(224) + " Page1 nas fases seguintes (4-6).
326:     *--------------------------------------------------------------------------
327:     PROTECTED PROCEDURE ConfigurarPageFrame()
328:         LOCAL loc_oPgf
329: 
330:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
331:         loc_oPgf = THIS.pgf_4c_Paginas
332: 
333:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
334:         loc_oPgf.PageCount = 1
335: 
336:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho
337:         loc_oPgf.Top    = 85
338:         loc_oPgf.Left   = -1
339:         loc_oPgf.Width  = THIS.Width + 2
340:         loc_oPgf.Height = THIS.Height - 85
341:         loc_oPgf.Tabs   = .F.
342: 
343:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
344:         loc_oPgf.Page1.Caption   = "Filtros"
345:         loc_oPgf.Page1.FontName  = "Tahoma"
346:         loc_oPgf.Page1.FontSize  = 8
347:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
348:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
349:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
350: 
351:         loc_oPgf.Visible    = .T.
352:         loc_oPgf.ActivePage = 1
353:     ENDPROC
354: 
355:     *--------------------------------------------------------------------------
356:     * ConfigurarPaginaLista - Adiciona todos os controles de filtro ao Page1
357:     *
358:     *   Form REPORT: a "Page1" deste relat" + CHR(243) + "rio cont" + CHR(233) + "m FILTROS, n" + CHR(227) + "o uma lista
359:     *   CRUD. O nome ConfigurarPaginaLista() " + CHR(233) + " mantido para compatibilidade
360:     *   com o esqueleto/valida" + CHR(231) + CHR(227) + "o multi-fase, mas o conte" + CHR(250) + "do " + CHR(233) + " formado
361:     *   pelos campos de filtro do legado SIGRECNT (Data, C" + CHR(243) + "digo, Vendedor,
362:     *   Base, N" + CHR(237) + "veis 2/3/4 e OptionGroups Local/Ordem).
363:     *
364:     *   Posi" + CHR(231) + CHR(245) + "es: layout.json original top - 85 (offset do PageFrame).
365:     *--------------------------------------------------------------------------
366:     PROTECTED PROCEDURE ConfigurarPaginaLista()
367:         LOCAL loc_oPag
368:         loc_oPag = THIS.pgf_4c_Paginas.Page1
369: 
370:         *-- Data
371:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
372:         WITH loc_oPag.lbl_4c_Label1
373:             .Top       = 21
374:             .Left      = 199
375:             .Width     = 32
376:             .Height    = 15
377:             .Caption   = "Data :"
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:             .BackStyle = 0
381:             .ForeColor = RGB(90, 90, 90)
382:             .Visible   = .T.
383:         ENDWITH
384: 
385:         loc_oPag.AddObject("txt_4c_Datas", "TextBox")
386:         WITH loc_oPag.txt_4c_Datas
387:             .Top      = 17
388:             .Left     = 235
389:             .Width    = 80
390:             .Height   = 24
391:             .Value    = {}
392:             .Format   = "D"
393:             .FontName = "Tahoma"
394:             .FontSize = 8
395:             .Visible  = .T.
396:         ENDWITH
397: 
398:         *-- C" + CHR(243) + "digo
399:         loc_oPag.AddObject("lbl_4c_Label3", "Label")
400:         WITH loc_oPag.lbl_4c_Label3
401:             .Top       = 20
402:             .Left      = 366
403:             .Width     = 42
404:             .Height    = 15
405:             .Caption   = "C" + CHR(243) + "digo :"
406:             .FontName  = "Tahoma"

*-- Linhas 627 a 686:
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         *-- Label Localiza" + CHR(231) + CHR(245) + "es (ao lado do OptionGroup Local)
631:         loc_oPag.AddObject("lbl_4c_Label4", "Label")
632:         WITH loc_oPag.lbl_4c_Label4
633:             .Top       = 185
634:             .Left      = 163
635:             .Width     = 68
636:             .Height    = 15
637:             .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .BackStyle = 0
641:             .ForeColor = RGB(90, 90, 90)
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         *-- OptionGroup - Tipo de localiza" + CHR(231) + CHR(227) + "o
646:         loc_oPag.AddObject("obj_4c_OptLocal", "OptionGroup")
647:         WITH loc_oPag.obj_4c_OptLocal
648:             .Top         = 180
649:             .Left        = 231
650:             .Width       = 347
651:             .Height      = 26
652:             .ButtonCount = 4
653:             .BackStyle   = 0
654:             .BorderStyle = 0
655:             .Visible     = .T.
656:             .Value       = 1
657:             WITH .Buttons(1)
658:                 .Caption  = "Todos"
659:                 .Width    = 82
660:                 .Height   = 18
661:                 .Top      = 4
662:                 .Left     = 2
663:                 .ForeColor = RGB(90, 90, 90)
664:             ENDWITH
665:             WITH .Buttons(2)
666:                 .Caption  = "Contados"
667:                 .Width    = 82
668:                 .Height   = 18
669:                 .Top      = 4
670:                 .Left     = 87
671:                 .FontName = "Tahoma"
672:                 .FontSize = 8
673:                 .ForeColor = RGB(90, 90, 90)
674:             ENDWITH
675:             WITH .Buttons(3)
676:                 .Caption  = "N" + CHR(227) + "o Contados"
677:                 .Width    = 90
678:                 .Height   = 18
679:                 .Top      = 4
680:                 .Left     = 172
681:                 .FontName = "Tahoma"
682:                 .FontSize = 8
683:                 .ForeColor = RGB(90, 90, 90)
684:             ENDWITH
685:             WITH .Buttons(4)
686:                 .Caption  = "Divergentes"

*-- Linhas 694 a 753:
694:             ENDWITH
695:         ENDWITH
696: 
697:         *-- Label Ordena" + CHR(231) + CHR(227) + "o (ao lado do OptionGroup Ordem)
698:         loc_oPag.AddObject("lbl_4c_Label9", "Label")
699:         WITH loc_oPag.lbl_4c_Label9
700:             .Top       = 209
701:             .Left      = 169
702:             .Width     = 62
703:             .Height    = 15
704:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8
707:             .BackStyle = 0
708:             .ForeColor = RGB(90, 90, 90)
709:             .Visible   = .T.
710:         ENDWITH
711: 
712:         *-- OptionGroup - Crit" + CHR(233) + "rio de ordena" + CHR(231) + CHR(227) + "o
713:         loc_oPag.AddObject("obj_4c_OptOrdem", "OptionGroup")
714:         WITH loc_oPag.obj_4c_OptOrdem
715:             .Top         = 204
716:             .Left        = 231
717:             .Width       = 432
718:             .Height      = 26
719:             .ButtonCount = 4
720:             .BackStyle   = 0
721:             .BorderStyle = 0
722:             .Visible     = .T.
723:             .Value       = 1
724:             WITH .Buttons(1)
725:                 .Caption  = "Local"
726:                 .Width    = 104
727:                 .Height   = 18
728:                 .Top      = 4
729:                 .Left     = 2
730:                 .ForeColor = RGB(90, 90, 90)
731:             ENDWITH
732:             WITH .Buttons(2)
733:                 .Caption  = "N" + CHR(237) + "vel 2"
734:                 .Width    = 104
735:                 .Height   = 18
736:                 .Top      = 4
737:                 .Left     = 109
738:                 .FontName = "Tahoma"
739:                 .FontSize = 8
740:                 .ForeColor = RGB(90, 90, 90)
741:             ENDWITH
742:             WITH .Buttons(3)
743:                 .Caption  = "N" + CHR(237) + "vel 3"
744:                 .Width    = 104
745:                 .Height   = 18
746:                 .Top      = 4
747:                 .Left     = 216
748:                 .FontName = "Tahoma"
749:                 .FontSize = 8
750:                 .ForeColor = RGB(90, 90, 90)
751:             ENDWITH
752:             WITH .Buttons(4)
753:                 .Caption  = "N" + CHR(237) + "vel 4"

*-- Linhas 771 a 1457:
771:     *
772:     *   par_nPagina : n" + CHR(250) + "mero da p" + CHR(225) + "gina destino (1 = Filtros)
773:     *--------------------------------------------------------------------------
774:     PROCEDURE AlternarPagina(par_nPagina)
775:         LOCAL loc_nPagina
776:         loc_nPagina = par_nPagina
777: 
778:         *-- Sanitiza" + CHR(231) + CHR(227) + "o: somente Page1 existe neste form REPORT
779:         IF VARTYPE(loc_nPagina) != "N" OR loc_nPagina < 1 OR ;
780:            loc_nPagina > THIS.pgf_4c_Paginas.PageCount
781:             loc_nPagina = 1
782:         ENDIF
783: 
784:         THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
785: 
786:         *-- Refresh dos controles ap" + CHR(243) + "s alternar p" + CHR(225) + "gina
787:         THIS.pgf_4c_Paginas.Refresh()
788:     ENDPROC
789: 
790:     *--------------------------------------------------------------------------
791:     * LimparCampos - Redefine todos os filtros para os valores padr" + CHR(227) + "o
792:     *--------------------------------------------------------------------------
793:     PROCEDURE LimparCampos()
794:         LOCAL loc_oPag
795:         loc_oPag = THIS.pgf_4c_Paginas.Page1
796:         loc_oPag.txt_4c_Datas.Value    = DATE()
797:         loc_oPag.txt_4c_Codigo.Value   = ""
798:         loc_oPag.txt_4c_Conta.Value    = ""
799:         loc_oPag.txt_4c_DConta.Value   = ""
800:         loc_oPag.txt_4c_Base.Value     = ""
801:         loc_oPag.txt_4c_DBase.Value    = ""
802:         loc_oPag.txt_4c_Nvl2.Value     = ""
803:         loc_oPag.txt_4c_DNvl2.Value    = ""
804:         loc_oPag.txt_4c_Nvl3.Value     = ""
805:         loc_oPag.txt_4c_DNvl3.Value    = ""
806:         loc_oPag.txt_4c_Nvl4.Value     = ""
807:         loc_oPag.txt_4c_DNvl4.Value    = ""
808:         loc_oPag.obj_4c_OptLocal.Value = 1
809:         loc_oPag.obj_4c_OptOrdem.Value = 1
810:     ENDPROC
811: 
812:     *--------------------------------------------------------------------------
813:     * FormParaRelatorio - Copia valores dos filtros do form para o BO
814:     *--------------------------------------------------------------------------
815:     PROTECTED PROCEDURE FormParaRelatorio()
816:         LOCAL loc_oPag
817:         loc_oPag = THIS.pgf_4c_Paginas.Page1
818:         WITH THIS.this_oRelatorio
819:             .this_dData     = loc_oPag.txt_4c_Datas.Value
820:             .this_cCods     = ALLTRIM(loc_oPag.txt_4c_Codigo.Value)
821:             .this_cConta    = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
822:             .this_cDConta   = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
823:             .this_cBase     = ALLTRIM(loc_oPag.txt_4c_Base.Value)
824:             .this_cNvl2     = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
825:             .this_cNvl3     = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
826:             .this_cNvl4     = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
827:             .this_nOptLocal = loc_oPag.obj_4c_OptLocal.Value
828:             .this_nOptOrdem = loc_oPag.obj_4c_OptOrdem.Value
829:         ENDWITH
830:     ENDPROC
831: 
832:     *--------------------------------------------------------------------------
833:     * ConfigurarPaginaDados - Vincula eventos (BINDEVENT) dos campos de filtro
834:     *   interativos da Page1 - primeira metade (Fase 5/8):
835:     *   Conta (Vendedor), DConta (descricao), Base (nivel 1) e Nvl2 (nivel 2).
836:     *   BINDEVENT exige metodos PUBLIC - handlers abaixo sem PROTECTED.
837:     *--------------------------------------------------------------------------
838:     PROTECTED PROCEDURE ConfigurarPaginaDados()
839:         LOCAL loc_oPag
840:         loc_oPag = THIS.pgf_4c_Paginas.Page1
841:         BINDEVENT(loc_oPag.txt_4c_Conta,  "KeyPress", THIS, "TeclaVendedor")
842:         BINDEVENT(loc_oPag.txt_4c_DConta, "KeyPress", THIS, "TeclaDescVendedor")
843:         BINDEVENT(loc_oPag.txt_4c_Base,   "KeyPress", THIS, "TeclaBase")
844:         BINDEVENT(loc_oPag.txt_4c_Base,   "InteractiveChange", THIS, "LimparBaseDescendentes")
845:         BINDEVENT(loc_oPag.txt_4c_Nvl2,   "KeyPress", THIS, "TeclaNvl2")
846:         BINDEVENT(loc_oPag.txt_4c_Nvl2,   "InteractiveChange", THIS, "LimparNvl2Descendentes")
847:         BINDEVENT(loc_oPag.txt_4c_Nvl3,   "KeyPress", THIS, "TeclaNvl3")
848:         BINDEVENT(loc_oPag.txt_4c_Nvl3,   "InteractiveChange", THIS, "LimparNvl3Descendentes")
849:         BINDEVENT(loc_oPag.txt_4c_Nvl4,   "KeyPress", THIS, "TeclaNvl4")
850:         BINDEVENT(loc_oPag.txt_4c_Nvl4,   "InteractiveChange", THIS, "LimparNvl4Descendentes")
851:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
852:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
853:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
854:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
855:     ENDPROC
856: 
857:     *--------------------------------------------------------------------------
858:     * TeclaVendedor - Handler KeyPress de txt_4c_Conta (codigo do vendedor)
859:     *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de vendedor.
860:     *--------------------------------------------------------------------------
861:     PROCEDURE TeclaVendedor(par_nKeyCode, par_nShiftAltCtrl)
862:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
863:             THIS.ValidarVendedor()
864:         ENDIF
865:     ENDPROC
866: 
867:     *--------------------------------------------------------------------------
868:     * ValidarVendedor - Verifica codigo digitado; abre busca se necessario
869:     *--------------------------------------------------------------------------
870:     PROCEDURE ValidarVendedor()
871:         LOCAL loc_cValor, loc_oPag
872:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
873:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
874:         IF EMPTY(loc_cValor)
875:             loc_oPag.txt_4c_DConta.Value = ""
876:             RETURN
877:         ENDIF
878:         THIS.AbrirBuscaVendedor()
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * AbrirBuscaVendedor - Lista vendedores com controle de acesso (SigCdAcJ)
883:     *   Equivalente ao getConta.Valid / getDConta.Valid do legado.
884:     *   SQL filtra SigCdCli pelo grupo padrao de vendedores e pelos jobs
885:     *   acessiveis ao usuario logado em SigCdAcJ.
886:     *--------------------------------------------------------------------------
887:     PROCEDURE AbrirBuscaVendedor()
888:         LOCAL loc_cGrPadVens, loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
889:         loc_oPag       = THIS.pgf_4c_Paginas.Page1
890:         loc_cGrPadVens = ""
891:         IF VARTYPE(THIS.this_oRelatorio) = "O"
892:             loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
893:         ENDIF
894: 
895:         loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
896:                    "FROM SigCdCli a " + ;
897:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
898:                    "AND (b.Coletors <> 10 " + ;
899:                    "OR (b.Coletors = 10 " + ;
900:                    "AND a.IClis NOT IN (" + ;
901:                    "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
902:                    "WHERE c.Jobs NOT IN (" + ;
903:                    "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
904:                    "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
905:         IF !EMPTY(loc_cGrPadVens)
906:             loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrPadVens)
907:         ENDIF
908:         loc_cSQL = loc_cSQL + " ORDER BY a.rclis"
909: 
910:         IF USED("cursor_4c_BuscaVend")
911:             USE IN SELECT("cursor_4c_BuscaVend")
912:         ENDIF
913:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
914:         IF loc_nResult > 0
915:             IF RECCOUNT("cursor_4c_BuscaVend") > 0
916:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
917:                 IF VARTYPE(loc_oLookup) = "O"
918:                     loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
919:                         "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
920:                     IF loc_oLookup.Mostrar()
921:                         loc_oPag.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
922:                         loc_oPag.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
923:                     ENDIF
924:                 ENDIF
925:             ELSE
926:                 MsgAviso("Nenhum vendedor encontrado.", "Aviso")
927:             ENDIF
928:             IF USED("cursor_4c_BuscaVend")
929:                 USE IN SELECT("cursor_4c_BuscaVend")
930:             ENDIF
931:         ELSE
932:             MsgErro("Erro ao buscar vendedores.", "Erro")
933:         ENDIF
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
938:     *   getDConta.When legado: campo habilitado apenas quando getConta eh vazio.
939:     *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
940:     *--------------------------------------------------------------------------
941:     PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
942:         LOCAL loc_oPag
943:         loc_oPag = THIS.pgf_4c_Paginas.Page1
944:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_Conta.Value))
945:             RETURN
946:         ENDIF
947:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
948:             THIS.ValidarDescVendedor()
949:         ENDIF
950:     ENDPROC
951: 
952:     *--------------------------------------------------------------------------
953:     * ValidarDescVendedor - Valida descricao e abre busca de vendedor
954:     *--------------------------------------------------------------------------
955:     PROCEDURE ValidarDescVendedor()
956:         LOCAL loc_cValor, loc_oPag
957:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
958:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_DConta.Value)
959:         IF EMPTY(loc_cValor)
960:             loc_oPag.txt_4c_Conta.Value = ""
961:             RETURN
962:         ENDIF
963:         THIS.AbrirBuscaVendedor()
964:     ENDPROC
965: 
966:     *--------------------------------------------------------------------------
967:     * TeclaBase - Handler KeyPress de txt_4c_Base (nivel 1 da localizacao)
968:     *   ENTER(13) / TAB(9) / F4(115): valida codigo ou abre busca de base.
969:     *--------------------------------------------------------------------------
970:     PROCEDURE TeclaBase(par_nKeyCode, par_nShiftAltCtrl)
971:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
972:             THIS.ValidarBase()
973:         ENDIF
974:     ENDPROC
975: 
976:     *--------------------------------------------------------------------------
977:     * ValidarBase - Valida codigo de base contra cursor_4c_SigLcNv1 do BO
978:     *   Equivalente ao getBase.Valid (fwbuscaext em SigLcNv1) do legado.
979:     *--------------------------------------------------------------------------
980:     PROCEDURE ValidarBase()
981:         LOCAL loc_cValor, loc_oPag
982:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
983:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Base.Value)
984:         IF EMPTY(loc_cValor)
985:             loc_oPag.txt_4c_DBase.Value = ""
986:             RETURN
987:         ENDIF
988:         IF USED("cursor_4c_SigLcNv1")
989:             SELECT cursor_4c_SigLcNv1
990:             LOCATE FOR ALLTRIM(Cods) = loc_cValor
991:             IF FOUND()
992:                 loc_oPag.txt_4c_DBase.Value = ALLTRIM(Descs)
993:             ELSE
994:                 THIS.AbrirBuscaBase()
995:             ENDIF
996:         ELSE
997:             THIS.AbrirBuscaBase()
998:         ENDIF
999:     ENDPROC
1000: 
1001:     *--------------------------------------------------------------------------
1002:     * AbrirBuscaBase - Lista opcoes de base (nivel 1 de localizacao)
1003:     *   Usa cursor_4c_SigLcNv1 do BO; fallback para SQLEXEC se nao disponivel.
1004:     *--------------------------------------------------------------------------
1005:     PROCEDURE AbrirBuscaBase()
1006:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
1007:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1008:         IF USED("cursor_4c_BuscaBase")
1009:             USE IN SELECT("cursor_4c_BuscaBase")
1010:         ENDIF
1011:         IF USED("cursor_4c_SigLcNv1")
1012:             SELECT Cods, Descs FROM cursor_4c_SigLcNv1 ;
1013:                 ORDER BY Cods ;
1014:                 INTO CURSOR cursor_4c_BuscaBase READWRITE
1015:         ELSE
1016:             loc_cSQL    = "SELECT Cods, Descs FROM SigLcNv1 ORDER BY Cods"
1017:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaBase")
1018:             IF loc_nResult < 1
1019:                 MsgErro("Erro ao buscar bases de localiza" + CHR(231) + ;
1020:                     CHR(227) + "o.", "Erro")
1021:                 RETURN
1022:             ENDIF
1023:         ENDIF
1024:         loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1025:         IF VARTYPE(loc_oLookup) = "O"
1026:             loc_oLookup.DefinirCursor("cursor_4c_BuscaBase", "Cods", "Descs", ;
1027:                 "Localiza" + CHR(231) + CHR(227) + "o Base")
1028:             IF loc_oLookup.Mostrar()
1029:                 loc_oPag.txt_4c_Base.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1030:                 loc_oPag.txt_4c_DBase.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1031:                 THIS.LimparBaseDescendentes()
1032:             ENDIF
1033:         ENDIF
1034:         IF USED("cursor_4c_BuscaBase")
1035:             USE IN SELECT("cursor_4c_BuscaBase")
1036:         ENDIF
1037:     ENDPROC
1038: 
1039:     *--------------------------------------------------------------------------
1040:     * LimparBaseDescendentes - Limpa todos os niveis filhos de Base
1041:     *   Equivalente ao getBase.InteractiveChange do legado.
1042:     *--------------------------------------------------------------------------
1043:     PROCEDURE LimparBaseDescendentes()
1044:         LOCAL loc_oPag
1045:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1046:         loc_oPag.txt_4c_DBase.Value  = ""
1047:         loc_oPag.txt_4c_Nvl2.Value   = ""
1048:         loc_oPag.txt_4c_DNvl2.Value  = ""
1049:         loc_oPag.txt_4c_Nvl3.Value   = ""
1050:         loc_oPag.txt_4c_DNvl3.Value  = ""
1051:         loc_oPag.txt_4c_Nvl4.Value   = ""
1052:         loc_oPag.txt_4c_DNvl4.Value  = ""
1053:     ENDPROC
1054: 
1055:     *--------------------------------------------------------------------------
1056:     * TeclaNvl2 - Handler KeyPress de txt_4c_Nvl2 (segundo nivel localizacao)
1057:     *   getNvl2.When legado: bloqueia entrada se Base estiver vazio.
1058:     *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 2.
1059:     *--------------------------------------------------------------------------
1060:     PROCEDURE TeclaNvl2(par_nKeyCode, par_nShiftAltCtrl)
1061:         LOCAL loc_oPag
1062:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1063:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Base.Value))
1064:             MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
1065:             loc_oPag.txt_4c_Nvl2.Value = ""
1066:             RETURN
1067:         ENDIF
1068:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1069:             THIS.ValidarNvl2()
1070:         ENDIF
1071:     ENDPROC
1072: 
1073:     *--------------------------------------------------------------------------
1074:     * ValidarNvl2 - Valida codigo de nivel 2 contra cursor_4c_SigLcNv2 do BO
1075:     *   Filtra por Cods = Base atual; equivalente ao getNvl2.Valid do legado.
1076:     *--------------------------------------------------------------------------
1077:     PROCEDURE ValidarNvl2()
1078:         LOCAL loc_cNivel, loc_cValor, loc_oPag
1079:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1080:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
1081:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
1082:         IF EMPTY(loc_cValor)
1083:             loc_oPag.txt_4c_DNvl2.Value = ""
1084:             RETURN
1085:         ENDIF
1086:         IF USED("cursor_4c_SigLcNv2")
1087:             SELECT cursor_4c_SigLcNv2
1088:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1089:             IF FOUND()
1090:                 loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(Descs)
1091:             ELSE
1092:                 THIS.AbrirBuscaNvl2()
1093:             ENDIF
1094:         ELSE
1095:             THIS.AbrirBuscaNvl2()
1096:         ENDIF
1097:     ENDPROC
1098: 
1099:     *--------------------------------------------------------------------------
1100:     * AbrirBuscaNvl2 - Lista opcoes de nivel 2 filtradas pela Base atual
1101:     *   Equivalente ao fwBuscaSel em CrSigLcNv2 do legado.
1102:     *--------------------------------------------------------------------------
1103:     PROCEDURE AbrirBuscaNvl2()
1104:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1105:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1106:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
1107:         IF USED("cursor_4c_BuscaNvl2")
1108:             USE IN SELECT("cursor_4c_BuscaNvl2")
1109:         ENDIF
1110:         IF USED("cursor_4c_SigLcNv2")
1111:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv2 ;
1112:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1113:                 ORDER BY Codigo ;
1114:                 INTO CURSOR cursor_4c_BuscaNvl2 READWRITE
1115:         ELSE
1116:             MsgErro("Cursor de n" + CHR(237) + "vel 2 n" + CHR(227) + ;
1117:                 "o dispon" + CHR(237) + "vel.", "Erro")
1118:             RETURN
1119:         ENDIF
1120:         IF RECCOUNT("cursor_4c_BuscaNvl2") > 0
1121:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1122:             IF VARTYPE(loc_oLookup) = "O"
1123:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl2", "Codigo", "Descs", ;
1124:                     "Segundo N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1125:                 IF loc_oLookup.Mostrar()
1126:                     loc_oPag.txt_4c_Nvl2.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1127:                     loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1128:                     THIS.LimparNvl2Descendentes()
1129:                 ENDIF
1130:             ENDIF
1131:         ELSE
1132:             MsgAviso("Nenhum segundo n" + CHR(237) + "vel encontrado " + ;
1133:                 "para a base informada.", "Aviso")
1134:         ENDIF
1135:         IF USED("cursor_4c_BuscaNvl2")
1136:             USE IN SELECT("cursor_4c_BuscaNvl2")
1137:         ENDIF
1138:     ENDPROC
1139: 
1140:     *--------------------------------------------------------------------------
1141:     * LimparNvl2Descendentes - Limpa niveis filhos de Nvl2
1142:     *   Equivalente ao getNvl2.InteractiveChange do legado.
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE LimparNvl2Descendentes()
1145:         LOCAL loc_oPag
1146:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1147:         loc_oPag.txt_4c_DNvl2.Value = ""
1148:         loc_oPag.txt_4c_Nvl3.Value  = ""
1149:         loc_oPag.txt_4c_DNvl3.Value = ""
1150:         loc_oPag.txt_4c_Nvl4.Value  = ""
1151:         loc_oPag.txt_4c_DNvl4.Value = ""
1152:     ENDPROC
1153: 
1154:     *--------------------------------------------------------------------------
1155:     * TeclaNvl3 - Handler KeyPress de txt_4c_Nvl3 (terceiro nivel localizacao)
1156:     *   getNvl3.When legado: bloqueia entrada se Nvl2 estiver vazio.
1157:     *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 3.
1158:     *--------------------------------------------------------------------------
1159:     PROCEDURE TeclaNvl3(par_nKeyCode, par_nShiftAltCtrl)
1160:         LOCAL loc_oPag
1161:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1162:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl2.Value))
1163:             MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
1164:             loc_oPag.txt_4c_Nvl3.Value = ""
1165:             RETURN
1166:         ENDIF
1167:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1168:             THIS.ValidarNvl3()
1169:         ENDIF
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * ValidarNvl3 - Valida codigo de nivel 3 contra cursor_4c_SigLcNv3 do BO
1174:     *   Filtra por Cods = Nvl2 atual; equivalente ao getNvl3.Valid do legado.
1175:     *--------------------------------------------------------------------------
1176:     PROCEDURE ValidarNvl3()
1177:         LOCAL loc_cNivel, loc_cValor, loc_oPag
1178:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1179:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
1180:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
1181:         IF EMPTY(loc_cValor)
1182:             loc_oPag.txt_4c_DNvl3.Value = ""
1183:             RETURN
1184:         ENDIF
1185:         IF USED("cursor_4c_SigLcNv3")
1186:             SELECT cursor_4c_SigLcNv3
1187:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1188:             IF FOUND()
1189:                 loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(Descs)
1190:             ELSE
1191:                 THIS.AbrirBuscaNvl3()
1192:             ENDIF
1193:         ELSE
1194:             THIS.AbrirBuscaNvl3()
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *--------------------------------------------------------------------------
1199:     * AbrirBuscaNvl3 - Lista opcoes de nivel 3 filtradas pelo Nvl2 atual
1200:     *   Equivalente ao fwBuscaSel em CrSigLcNv3 do legado.
1201:     *--------------------------------------------------------------------------
1202:     PROCEDURE AbrirBuscaNvl3()
1203:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1204:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1205:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
1206:         IF USED("cursor_4c_BuscaNvl3")
1207:             USE IN SELECT("cursor_4c_BuscaNvl3")
1208:         ENDIF
1209:         IF USED("cursor_4c_SigLcNv3")
1210:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv3 ;
1211:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1212:                 ORDER BY Codigo ;
1213:                 INTO CURSOR cursor_4c_BuscaNvl3 READWRITE
1214:         ELSE
1215:             MsgErro("Cursor de n" + CHR(237) + "vel 3 n" + CHR(227) + ;
1216:                 "o dispon" + CHR(237) + "vel.", "Erro")
1217:             RETURN
1218:         ENDIF
1219:         IF RECCOUNT("cursor_4c_BuscaNvl3") > 0
1220:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1221:             IF VARTYPE(loc_oLookup) = "O"
1222:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl3", "Codigo", "Descs", ;
1223:                     "Terceiro N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1224:                 IF loc_oLookup.Mostrar()
1225:                     loc_oPag.txt_4c_Nvl3.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1226:                     loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1227:                     THIS.LimparNvl3Descendentes()
1228:                 ENDIF
1229:             ENDIF
1230:         ELSE
1231:             MsgAviso("Nenhum terceiro n" + CHR(237) + "vel encontrado " + ;
1232:                 "para o segundo n" + CHR(237) + "vel informado.", "Aviso")
1233:         ENDIF
1234:         IF USED("cursor_4c_BuscaNvl3")
1235:             USE IN SELECT("cursor_4c_BuscaNvl3")
1236:         ENDIF
1237:     ENDPROC
1238: 
1239:     *--------------------------------------------------------------------------
1240:     * LimparNvl3Descendentes - Limpa niveis filhos de Nvl3
1241:     *   Equivalente ao getNvl3.InteractiveChange do legado.
1242:     *--------------------------------------------------------------------------
1243:     PROCEDURE LimparNvl3Descendentes()
1244:         LOCAL loc_oPag
1245:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1246:         loc_oPag.txt_4c_DNvl3.Value = ""
1247:         loc_oPag.txt_4c_Nvl4.Value  = ""
1248:         loc_oPag.txt_4c_DNvl4.Value = ""
1249:     ENDPROC
1250: 
1251:     *--------------------------------------------------------------------------
1252:     * TeclaNvl4 - Handler KeyPress de txt_4c_Nvl4 (quarto nivel localizacao)
1253:     *   getNvl4.When legado: bloqueia entrada se Nvl3 estiver vazio.
1254:     *   ENTER(13) / TAB(9) / F4(115): valida ou abre busca de nivel 4.
1255:     *--------------------------------------------------------------------------
1256:     PROCEDURE TeclaNvl4(par_nKeyCode, par_nShiftAltCtrl)
1257:         LOCAL loc_oPag
1258:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1259:         IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Nvl3.Value))
1260:             MsgAviso("N" + CHR(237) + "vel anterior n" + CHR(227) + "o informado.", "Aviso")
1261:             loc_oPag.txt_4c_Nvl4.Value = ""
1262:             RETURN
1263:         ENDIF
1264:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1265:             THIS.ValidarNvl4()
1266:         ENDIF
1267:     ENDPROC
1268: 
1269:     *--------------------------------------------------------------------------
1270:     * ValidarNvl4 - Valida codigo de nivel 4 contra cursor_4c_SigLcNv4 do BO
1271:     *   Filtra por Cods = Nvl3 atual; equivalente ao getNvl4.Valid do legado.
1272:     *--------------------------------------------------------------------------
1273:     PROCEDURE ValidarNvl4()
1274:         LOCAL loc_cNivel, loc_cValor, loc_oPag
1275:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1276:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
1277:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Nvl4.Value)
1278:         IF EMPTY(loc_cValor)
1279:             loc_oPag.txt_4c_DNvl4.Value = ""
1280:             RETURN
1281:         ENDIF
1282:         IF USED("cursor_4c_SigLcNv4")
1283:             SELECT cursor_4c_SigLcNv4
1284:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1285:             IF FOUND()
1286:                 loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(Descs)
1287:             ELSE
1288:                 THIS.AbrirBuscaNvl4()
1289:             ENDIF
1290:         ELSE
1291:             THIS.AbrirBuscaNvl4()
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *--------------------------------------------------------------------------
1296:     * AbrirBuscaNvl4 - Lista opcoes de nivel 4 filtradas pelo Nvl3 atual
1297:     *   Equivalente ao fwBuscaSel em CrSigLcNv4 do legado.
1298:     *--------------------------------------------------------------------------
1299:     PROCEDURE AbrirBuscaNvl4()
1300:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1301:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1302:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
1303:         IF USED("cursor_4c_BuscaNvl4")
1304:             USE IN SELECT("cursor_4c_BuscaNvl4")
1305:         ENDIF
1306:         IF USED("cursor_4c_SigLcNv4")
1307:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv4 ;
1308:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1309:                 ORDER BY Codigo ;
1310:                 INTO CURSOR cursor_4c_BuscaNvl4 READWRITE
1311:         ELSE
1312:             MsgErro("Cursor de n" + CHR(237) + "vel 4 n" + CHR(227) + ;
1313:                 "o dispon" + CHR(237) + "vel.", "Erro")
1314:             RETURN
1315:         ENDIF
1316:         IF RECCOUNT("cursor_4c_BuscaNvl4") > 0
1317:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1318:             IF VARTYPE(loc_oLookup) = "O"
1319:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl4", "Codigo", "Descs", ;
1320:                     "Quarto N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1321:                 IF loc_oLookup.Mostrar()
1322:                     loc_oPag.txt_4c_Nvl4.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1323:                     loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1324:                 ENDIF
1325:             ENDIF
1326:         ELSE
1327:             MsgAviso("Nenhum quarto n" + CHR(237) + "vel encontrado " + ;
1328:                 "para o terceiro n" + CHR(237) + "vel informado.", "Aviso")
1329:         ENDIF
1330:         IF USED("cursor_4c_BuscaNvl4")
1331:             USE IN SELECT("cursor_4c_BuscaNvl4")
1332:         ENDIF
1333:     ENDPROC
1334: 
1335:     *--------------------------------------------------------------------------
1336:     * LimparNvl4Descendentes - Limpa descricao de nivel 4
1337:     *   Equivalente ao getNvl4.InteractiveChange do legado.
1338:     *--------------------------------------------------------------------------
1339:     PROCEDURE LimparNvl4Descendentes()
1340:         LOCAL loc_oPag
1341:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1342:         loc_oPag.txt_4c_DNvl4.Value = ""
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * ValidarDataParaRelatorio - Valida se data foi informada (obrigatoria)
1347:     *   Equivalente ao guard clause do btnReport.Click legado:
1348:     *     If Empty(ThisForm.getDatas.Value) -> Messagebox + Return 0
1349:     *   Retorna .T. se data valida, .F. se invalida (exibe aviso).
1350:     *--------------------------------------------------------------------------
1351:     PROTECTED PROCEDURE ValidarDataParaRelatorio()
1352:         LOCAL loc_oPag
1353:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1354:         IF EMPTY(loc_oPag.txt_4c_Datas.Value)
1355:             MsgAviso("Data inv" + CHR(225) + "lida!", "Aviso")
1356:             loc_oPag.txt_4c_Datas.SetFocus()
1357:             RETURN .F.
1358:         ENDIF
1359:         RETURN .T.
1360:     ENDPROC
1361: 
1362:     *--------------------------------------------------------------------------
1363:     * BtnVisualizarClick - Visualiza relatorio em tela (preview)
1364:     *   Botao 1 do cmg_4c_Botoes. Requer data valida.
1365:     *--------------------------------------------------------------------------
1366:     PROCEDURE BtnVisualizarClick()
1367:         IF !THIS.ValidarDataParaRelatorio()
1368:             RETURN
1369:         ENDIF
1370:         THIS.FormParaRelatorio()
1371:         IF !THIS.this_oRelatorio.Visualizar()
1372:             LOCAL loc_cMsg
1373:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1374:             IF !EMPTY(loc_cMsg)
1375:                 MsgErro(loc_cMsg, "Erro")
1376:             ENDIF
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     *--------------------------------------------------------------------------
1381:     * BtnImprimirClick - Imprime relatorio com dialogo de impressora
1382:     *   Botao 2 do cmg_4c_Botoes. Requer data valida.
1383:     *--------------------------------------------------------------------------
1384:     PROCEDURE BtnImprimirClick()
1385:         IF !THIS.ValidarDataParaRelatorio()
1386:             RETURN
1387:         ENDIF
1388:         THIS.FormParaRelatorio()
1389:         IF !THIS.this_oRelatorio.Imprimir()
1390:             LOCAL loc_cMsg
1391:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1392:             IF !EMPTY(loc_cMsg)
1393:                 MsgErro(loc_cMsg, "Erro")
1394:             ENDIF
1395:         ENDIF
1396:     ENDPROC
1397: 
1398:     *--------------------------------------------------------------------------
1399:     * BtnExcelClick - Exporta dados do relatorio para Excel
1400:     *   Botao 3 do cmg_4c_Botoes. Requer data valida.
1401:     *--------------------------------------------------------------------------
1402:     PROCEDURE BtnExcelClick()
1403:         IF !THIS.ValidarDataParaRelatorio()
1404:             RETURN
1405:         ENDIF
1406:         THIS.FormParaRelatorio()
1407:         IF !THIS.this_oRelatorio.GerarExcel()
1408:             LOCAL loc_cMsg
1409:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1410:             IF !EMPTY(loc_cMsg)
1411:                 MsgErro(loc_cMsg, "Erro")
1412:             ENDIF
1413:         ENDIF
1414:     ENDPROC
1415: 
1416:     *--------------------------------------------------------------------------
1417:     * BtnEncerrarClick - Fecha o formulario de relatorio
1418:     *   Botao 4 (Cancel=.T.) do cmg_4c_Botoes. Sem validacao de data.
1419:     *--------------------------------------------------------------------------
1420:     PROCEDURE BtnEncerrarClick()
1421:         THIS.Release()
1422:     ENDPROC
1423: 
1424:     *--------------------------------------------------------------------------
1425:     * HabilitarCampos - Habilita ou desabilita os controles de filtro
1426:     *   par_lHabilitar: .T. = habilita edicao, .F. = somente leitura
1427:     *   Forms REPORT chamam com .T. no InicializarForm (estado normal).
1428:     *--------------------------------------------------------------------------
1429:     PROCEDURE HabilitarCampos(par_lHabilitar)
1430:         LOCAL loc_lHab, loc_oPag
1431:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1432:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1433:         loc_oPag.txt_4c_Datas.ReadOnly    = !loc_lHab
1434:         loc_oPag.txt_4c_Codigo.ReadOnly   = !loc_lHab
1435:         loc_oPag.txt_4c_Conta.ReadOnly    = !loc_lHab
1436:         loc_oPag.txt_4c_Base.ReadOnly     = !loc_lHab
1437:         loc_oPag.txt_4c_Nvl2.ReadOnly     = !loc_lHab
1438:         loc_oPag.txt_4c_Nvl3.ReadOnly     = !loc_lHab
1439:         loc_oPag.txt_4c_Nvl4.ReadOnly     = !loc_lHab
1440:         loc_oPag.obj_4c_OptLocal.Enabled  = loc_lHab
1441:         loc_oPag.obj_4c_OptOrdem.Enabled  = loc_lHab
1442:         THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
1443:         THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lHab
1444:         THIS.cmg_4c_Botoes.Buttons(3).Enabled = loc_lHab
1445:     ENDPROC
1446: 
1447:     *--------------------------------------------------------------------------
1448:     * Destroy - Libera BO de relat" + CHR(243) + "rio
1449:     *--------------------------------------------------------------------------
1450:     PROCEDURE Destroy()
1451:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1452:             THIS.this_oRelatorio = .NULL.
1453:         ENDIF
1454:         DODEFAULT()
1455:     ENDPROC
1456: 
1457: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecntBO.prg):
*==============================================================================
* SIGRECNTBO.PRG
* Business Object para Relatorio de Contagem por Localizacao
*
* Herda de: RelatorioBase
* Form: Formsigrecnt.prg
* Relatorio original: sigrecnt.SCX / SigReCnt.FRX
*==============================================================================

DEFINE CLASS sigrecntBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCnt"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cBase              = ""
    this_cNvl2              = ""
    this_cNvl3              = ""
    this_cNvl4              = ""
    this_cCods              = ""
    this_nOptLocal          = 0
    this_nOptOrdem          = 0

    *-- Estado / controle
    this_lVisualizaCtg      = .F.
    this_cGrPadVens         = ""

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                     "Contagem por Localiza" + CHR(231) + CHR(227) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega GrPadVens e cursores de nivel para o form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cSQL = "SELECT TOP 1 GrPadVens FROM SigCdPam " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_LocalPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(NVL(cursor_4c_LocalPam.GrPadVens, ""))
                    ENDIF
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores " + ;
                        "N" + CHR(227) + "o Est" + CHR(225) + " Configurado nos " + ;
                        "Par" + CHR(226) + "metros do Sistema."
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "cursor_4c_SigLcNv1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 1"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "cursor_4c_SigLcNv2")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 2"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "cursor_4c_SigLcNv3")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 3"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "cursor_4c_SigLcNv4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 4"
                    EXIT
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida parametros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lcLocalizacao, loc_lcBase, loc_lcNvl2, loc_lcNvl3, loc_lcNvl4
        LOCAL loc_lcVends, loc_lnLocal, loc_lnOrdem, loc_lcCods
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2
        LOCAL loc_lcNvl3Tmp
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                loc_lcBase        = ALLTRIM(THIS.this_cBase)
                loc_lcNvl2        = ALLTRIM(THIS.this_cNvl2)
                loc_lcNvl3        = ALLTRIM(THIS.this_cNvl3)
                loc_lcNvl4        = ALLTRIM(THIS.this_cNvl4)
                loc_lcLocalizacao = loc_lcBase + loc_lcNvl2 + loc_lcNvl3 + loc_lcNvl4
                loc_lcVends       = ALLTRIM(THIS.this_cConta)
                loc_lnLocal       = THIS.this_nOptLocal
                loc_lnOrdem       = THIS.this_nOptOrdem
                loc_lcCods        = ALLTRIM(THIS.this_cCods)

                loc_cDtI = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 00:00:00', 120)"
                loc_cDtF = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 23:59:59', 120)"

                IF USED("csRel")
                    USE IN csRel
                ENDIF
                IF USED("crRel")
                    USE IN crRel
                ENDIF
                IF USED("crTmpLocal")
                    USE IN crTmpLocal
                ENDIF
                IF USED("crSigCdCnl")
                    USE IN crSigCdCnl
                ENDIF
                IF USED("csTotLocal")
                    USE IN csTotLocal
                ENDIF
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF

                CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

                loc_lcEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ALLTRIM(go_4c_Sistema.cEmpresa)

                loc_lcTitulo  = "Rela" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
                loc_lcTitulo2 = IIF(!EMPTY(THIS.this_cConta), ;
                    "Vendedor - " + THIS.this_cConta + " " + THIS.this_cDConta, "")
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                    VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2)

                *-- Contagens realizadas (sigcdcnl + sigcdcni)
                loc_cSQL = "SELECT a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque " + ;
                           "FROM sigcdcnl a " + ;
                           "JOIN sigcdcni b ON a.cods = b.cods " + ;
                           "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

                IF !EMPTY(loc_lcCods)
                    loc_cSQL = loc_cSQL + " AND A.Cods = " + EscaparSQL(loc_lcCods)
                ENDIF
                IF !EMPTY(loc_lcVends)
                    loc_cSQL = loc_cSQL + " AND A.Vends = " + EscaparSQL(loc_lcVends)
                ENDIF
                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND b.locals LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar contagens."
                    EXIT
                ENDIF

                SELECT crSigCdCnl
                INDEX ON Locals TAG Locals
                GO TOP

                IF RECCOUNT("crSigCdCnl") = 0
                    THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
                    EXIT
                ENDIF

                *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
                loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
                           "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
                           "FROM (" + ;
                           " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
                           " FROM SigOpEtq A " + ;
                           " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
                           "  ON b.cpros = a.cpros " + ;
                           " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.contas NOT IN ('15000100','15000141') " + ;
                           " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
                           " UNION ALL " + ;
                           " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
                           " FROM SigMvesl a, SigCdpro b " + ;
                           " WHERE a.CPros = b.Cpros " + ;
                           " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.estos NOT IN ('15000100','15000141') " + ;
                           " AND a.cpros + a.locals NOT IN " + ;
                           "  (SELECT cpros + localizas FROM sigopetq) " + ;
                           " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
                           ") a WHERE Grupos <> SPACE(10)"

                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_cSQL = loc_cSQL + ;
                           " GROUP BY localizas, grupos, contas, empos" + ;
                           " HAVING SUM(qtde) <> 0"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;
                                              CHR(231) + CHR(227) + "o."
                    EXIT
                ENDIF

                *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
                SELECT crTmpLocal
                GO TOP
                SCAN
                    IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
                        DELETE
                        LOOP
                    ENDIF
                    SELECT crTmpLocal
                ENDSCAN

                SELECT Localizas, SUM(Qtde) AS Qtds ;
                    FROM crTmpLocal WHERE 0=0 ;
                    GROUP BY Localizas ;
                    INTO CURSOR csTotLocal READWRITE

                IF RECCOUNT("csTotLocal") = 0
                    THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
                        "localiza" + CHR(231) + CHR(245) + "es contadas."
                    EXIT
                ENDIF

                SELECT csTotLocal
                INDEX ON Localizas TAG Locals
                GO TOP

                *-- Gera cursor de resultado conforme OptLocal
                DO CASE
                CASE loc_lnLocal = 1
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 2
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crSigCdCnl a ;
                        LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 3
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) = 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 4
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> ;
                            IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
                        INTO CURSOR csRel READWRITE
                ENDCASE

                *-- Agrega resultado final com campos de nivel decompostos
                SELECT Datas, Locals, Vends, Empos, Localizas, ;
                    SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
                    SPACE(100) AS Descr, ;
                    LEFT(Locals, 2) AS Nivel1s, ;
                    SUBSTR(Locals, 3, 2) AS Nivel2s, ;
                    SUBSTR(Locals, 5, 2) AS Nivel3s, ;
                    SUBSTR(Locals, 7, 3) AS Nivel4s ;
                    FROM csRel ;
                    GROUP BY Datas, Locals, Vends, Empos, Localizas ;
                    INTO CURSOR crRel READWRITE

                *-- Enriquece descricao com nivel 3
                IF !USED("cursor_4c_SigLcNv3")
                    SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")
                ENDIF

                SELECT crRel
                INDEX ON Vends + Locals TAG Locals
                GO TOP
                SCAN
                    loc_lcNvl3Tmp = SUBSTR(crRel.Locals, 5, 2)
                    IF !EMPTY(loc_lcNvl3Tmp)
                        SELECT cursor_4c_SigLcNv3
                        LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_lcNvl3Tmp)
                        IF FOUND()
                            REPLACE Descr WITH ALLTRIM(cursor_4c_SigLcNv3.Descs) IN crRel
                        ENDIF
                    ENDIF
                    SELECT crRel
                ENDSCAN

                *-- Aplica ordenacao final
                SELECT crRel
                DO CASE
                CASE loc_lnOrdem = 1
                    INDEX ON Locals TAG Locals
                CASE loc_lnOrdem = 2
                    INDEX ON Nivel2s TAG Nivel2s
                CASE loc_lnOrdem = 3
                    INDEX ON Nivel3s TAG Nivel3s
                CASE loc_lnOrdem = 4
                    INDEX ON Nivel4s TAG Nivel4s
                ENDCASE
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta para planilha Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                    "contagem_localizacao", "xls")
                IF !EMPTY(loc_cArquivo)
                    SELECT crRel
                    COPY TO (loc_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem, o unico
    * parametro persistido eh GrPadVens, usado nos lookups de vendedor.
    * Retorna .T. se carregou, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
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
    * Contagem por Localizacao eh apenas leitura: consulta SigCdCnl/SigCdCnI/
    * SigOpEtq/SigMvesl e gera preview via REPORT FORM. Retorna .F. para
    * satisfazer contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
    * data, empresa e filtro de localizacao) para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCNT|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cBase) + ;
                     ALLTRIM(THIS.this_cNvl2) + ;
                     ALLTRIM(THIS.this_cNvl3) + ;
                     ALLTRIM(THIS.this_cNvl4)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de execucao do relatorio na
    * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.
        IF EMPTY(par_cOperacao)
            par_cOperacao = "VISUALIZAR"
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Empresa, Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Relatorio_Contagem") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cTituloRelatorio) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

