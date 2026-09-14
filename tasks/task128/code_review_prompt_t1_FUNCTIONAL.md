# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (39)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=9 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [BINDEVENT-PARAMS] Handler 'TxtNmOperacaoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE TxtNmOperacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGREIPE): Top original=363 vs migrado 'lbl_4c_Say2' Top=281 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Option' (parent: SIGREIPE): Top original=378 vs migrado 'obj_4c_Option' Top=23 (diff=355px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpOrdem' (parent: SIGREIPE): Top original=451 vs migrado 'obj_4c_OpOrdem' Top=23 (diff=428px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_dopes' (parent: SIGREIPE): Top original=128 vs migrado 'lbl_4c_Lbl_dopes' Top=46 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpColunas' (parent: SIGREIPE): Top original=378 vs migrado 'obj_4c_OpColunas' Top=22 (diff=356px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpColunas' (parent: SIGREIPE): Left original=125 vs migrado 'obj_4c_OpColunas' Left=5 (diff=120px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGREIPE): Top original=424 vs migrado 'lbl_4c_Say4' Top=342 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptPais' (parent: SIGREIPE): Top original=419 vs migrado 'obj_4c_OptPais' Top=5 (diff=414px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptPais' (parent: SIGREIPE): Left original=669 vs migrado 'obj_4c_OptPais' Left=5 (diff=664px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGREIPE): Top original=440 vs migrado 'lbl_4c_Say6' Top=358 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCodigo' (parent: SIGREIPE): Top original=436 vs migrado 'obj_4c_OptCodigo' Top=5 (diff=431px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCodigo' (parent: SIGREIPE): Left original=669 vs migrado 'obj_4c_OptCodigo' Left=5 (diff=664px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGREIPE): Top original=457 vs migrado 'lbl_4c_Say7' Top=375 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optProper' (parent: SIGREIPE): Top original=452 vs migrado 'obj_4c_OptProper' Top=5 (diff=447px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optProper' (parent: SIGREIPE): Left original=669 vs migrado 'obj_4c_OptProper' Left=5 (diff=664px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_conta' (parent: SIGREIPE): Top original=172 vs migrado 'obj_4c_Opt_conta' Top=5 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_conta' (parent: SIGREIPE): Left original=91 vs migrado 'obj_4c_Opt_conta' Left=5 (diff=86px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREIPE): Top original=151 vs migrado 'lbl_4c_Lbl_periodo_a' Top=69 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREIPE): Left original=47 vs migrado 'lbl_4c_Lbl_periodo_a' Left=182 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGREIPE): Top original=151 vs migrado 'lbl_4c_Lbl_periodo_a' Top=69 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say9' (parent: SIGREIPE): Top original=476 vs migrado 'lbl_4c_Say9' Top=394 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optContatos' (parent: SIGREIPE): Top original=471 vs migrado 'obj_4c_OptContatos' Top=5 (diff=466px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optContatos' (parent: SIGREIPE): Left original=669 vs migrado 'obj_4c_OptContatos' Left=5 (diff=664px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREIPE): Top original=264 vs migrado 'cmd_4c_Apaga' Top=182 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREIPE): Top original=220 vs migrado 'cmd_4c_SelTudo' Top=138 (diff=82px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGREIPE): Top original=378 vs migrado 'obj_4c_Opt_Impressora' Top=10 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGREIPE): Left original=230 vs migrado 'obj_4c_Opt_Impressora' Left=9 (diff=221px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGREIPE): Top original=364 vs migrado 'lbl_4c_Label3' Top=282 (diff=82px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2434 linhas total):

*-- Linhas 6 a 112:
6: *
7: * FASE 3/8 - Estrutura base do formulario
8: *   * Propriedades visuais (Width=819, Height=558)
9: *   * Init() / InicializarForm() / Destroy()
10: *   * ConfigurarCabecalho() (faixa escura com titulo)
11: *   * ConfigurarBotoes()    (cmg_4c_Botoes: Visualizar/Imprimir/ImpDireto/Encerrar)
12: *   * ConfigurarPageFrame() (pgf_4c_Paginas com 1 pagina para filtros)
13: *   * LimparCampos()        (reinicia propriedades do BO)
14: *==============================================================================
15: 
16: DEFINE CLASS Formsigreipe AS FormBase
17: 
18:     *-- Dimensoes exatas do original (Width=819, Height=558)
19:     Height      = 558
20:     Width       = 819
21:     DataSession = 2
22:     ShowWindow  = 1
23:     WindowType  = 1
24:     AutoCenter  = .T.
25:     BorderStyle = 2
26:     ControlBox  = .F.
27:     MaxButton   = .F.
28:     MinButton   = .F.
29:     TitleBar    = 0
30:     Themes      = .F.
31:     ShowTips    = .T.
32: 
33:     *-- BO de relatorio (sigreipeBO herda RelatorioBase)
34:     this_oRelatorio    = .NULL.
35:     this_cMensagemErro = ""
36: 
37:     *-- Parametros de impressao termica (carregados em CarregarImpressoras)
38:     this_nTpImp    = 1
39:     this_nAjVerts  = 0
40:     this_nAjHorzs  = 0
41:     this_nAjDenss  = 10
42:     this_nAjVelos  = 1
43: 
44:     *--------------------------------------------------------------------------
45:     * Init - Delega para FormBase.Init() que chama InicializarForm()
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init()
48:         RETURN DODEFAULT()
49:     ENDPROC
50: 
51:     *--------------------------------------------------------------------------
52:     * InicializarForm - Cria estrutura base do formulario de etiquetas
53:     *   1. Configura Caption e Picture de fundo
54:     *   2. Instancia sigreipeBO
55:     *   3. Verifica conexao SQL (replica verificacao SigCdAcU do original)
56:     *   4. Cria cabecalho, botoes e PageFrame
57:     *   5. Limpa filtros para valores padrao
58:     *--------------------------------------------------------------------------
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lSucesso, loc_lContinuar, loc_nResult
61:         loc_lSucesso   = .F.
62:         loc_lContinuar = .T.
63:         TRY
64:             THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas"
65: 
66:             IF TYPE("gc_4c_CaminhoIcones") = "U"
67:                 gc_4c_CaminhoIcones = ""
68:             ENDIF
69:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
70: 
71:             *-- Instanciar BO de relatorio
72:             THIS.this_oRelatorio = CREATEOBJECT("sigreipeBO")
73:             IF VARTYPE(THIS.this_oRelatorio) != "O"
74:                 MsgErro("Erro ao criar sigreipeBO" + CHR(13) + ;
75:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
76:                 loc_lContinuar = .F.
77:             ENDIF
78: 
79:             *-- Verificar conexao SQL (replica verificacao SigCdAcU do Init original)
80:             *   Se a query falha, ha problema de conexao -> abortar
81:             IF loc_lContinuar AND ;
82:                (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
83: 
84:                 loc_nResult = SQLEXEC(gnConnHandle, ;
85:                     "SELECT pkChaves FROM SigCdAcU" + ;
86:                     " WHERE RTRIM(Programas) = 'SIGREIPE'" + ;
87:                     " AND RTRIM(Parametros) = 'LIBERAIMP'" + ;
88:                     " ORDER BY pkChaves", "cursor_4c_AcU")
89: 
90:                 IF USED("cursor_4c_AcU")
91:                     USE IN cursor_4c_AcU
92:                 ENDIF
93: 
94:                 IF loc_nResult < 0
95:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
96:                         "Falha na conex" + CHR(227) + "o (SigCdAcU).", "Erro")
97:                     loc_lContinuar = .F.
98:                 ENDIF
99:             ENDIF
100: 
101:             IF loc_lContinuar
102:                 THIS.ConfigurarCabecalho()
103:                 THIS.ConfigurarBotoes()
104:                 THIS.ConfigurarPageFrame()
105:                 THIS.ConfigurarPaginaLista()
106:                 THIS.ConfigurarPaginaDados()
107:                 THIS.ConfigurarPaginaDados2()
108:                 THIS.CarregarImpressoras()
109: 
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 

*-- Linhas 118 a 171:
118:             THIS.this_cMensagemErro = loc_oErro.Message
119:             MsgErro(loc_oErro.Message + CHR(13) + ;
120:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
121:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
122:         ENDTRY
123:         RETURN loc_lSucesso
124:     ENDPROC
125: 
126:     *--------------------------------------------------------------------------
127:     * ConfigurarCabecalho - Container escuro superior com titulo
128:     *   Original cntSombra: Top=0, Left=0, Width=852, Height=80
129:     *   No novo sistema: Width=THIS.Width (819), fundo RGB(100,100,100)
130:     *--------------------------------------------------------------------------
131:     PROTECTED PROCEDURE ConfigurarCabecalho()
132:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH THIS.cnt_4c_Cabecalho
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackStyle   = 1
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142: 
143:             *-- Sombra deslocada 2px (efeito 3D para o titulo branco)
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .Top       = 22
147:                 .Left      = 22
148:                 .Width     = THIS.Width
149:                 .Height    = 30
150:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 14
153:                 .FontBold  = .T.
154:                 .ForeColor = RGB(0, 0, 0)
155:                 .BackStyle = 0
156:                 .Visible   = .T.
157:             ENDWITH
158: 
159:             *-- Titulo em branco sobre a sombra
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .Top       = 20
163:                 .Left      = 20
164:                 .Width     = THIS.Width
165:                 .Height    = 30
166:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
167:                 .FontName  = "Tahoma"
168:                 .FontSize  = 14
169:                 .FontBold  = .T.
170:                 .ForeColor = RGB(255, 255, 255)
171:                 .BackStyle = 0

*-- Linhas 180 a 223:
180:     *   Botoes originais: Visualiza(L=5,W=75), Imprime(L=80), DocExcel(L=155), Sair(L=230)
181:     *   No novo sistema usa cmg_4c_Botoes (CommandGroup padrao frmrelatorio)
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
185:         WITH THIS.cmg_4c_Botoes
186:             .Top           = 0
187:             .Left          = 509
188:             .Width         = 308
189:             .Height        = 80
190:             .ButtonCount   = 4
191:             .BackStyle     = 0
192:             .BorderStyle   = 0
193:             .BorderColor   = RGB(136, 189, 188)
194:             .SpecialEffect = 1
195:             .Themes        = .F.
196:             .Visible       = .T.
197: 
198:             *-- Visualizar - preview em tela (original: visualizacao())
199:             WITH .Buttons(1)
200:                 .Top             = 5
201:                 .Left            = 5
202:                 .Width           = 70
203:                 .Height          = 70
204:                 .Caption         = "Visualizar"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .BackColor       = RGB(255, 255, 255)
208:                 .ForeColor       = RGB(90, 90, 90)
209:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
210:                 .PicturePosition = 13
211:                 .SpecialEffect   = 0
212:                 .MousePointer    = 15
213:                 .ToolTipText     = "Gerar pr" + CHR(233) + "via em tela"
214:                 .Themes          = .F.
215:                 .Visible         = .T.
216:             ENDWITH
217: 
218:             *-- Imprimir - impressora com dialogo (original: impressao())
219:             WITH .Buttons(2)
220:                 .Top             = 5
221:                 .Left            = 79
222:                 .Width           = 70
223:                 .Height          = 70

*-- Linhas 282 a 725:
282:                 .Visible         = .T.
283:             ENDWITH
284:         ENDWITH
285:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
286:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
287:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnImpDiretoClick")
288:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
289:     ENDPROC
290: 
291:     *--------------------------------------------------------------------------
292:     * ConfigurarPageFrame - PageFrame com 1 pagina para os controles de filtro
293:     *   O form original e FLAT (sem PageFrame), mas no novo padrao os campos
294:     *   sao agrupados em PageFrame para consistencia com o sistema.
295:     *   Posicionado logo abaixo do cabecalho (80px) ate o fim do form.
296:     *   Page1 recebe os controles de filtro nas fases seguintes (4-6).
297:     *--------------------------------------------------------------------------
298:     PROTECTED PROCEDURE ConfigurarPageFrame()
299:         LOCAL loc_oPgf
300: 
301:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
302:         loc_oPgf = THIS.pgf_4c_Paginas
303: 
304:         loc_oPgf.PageCount = 1
305: 
306:         loc_oPgf.Top    = 82
307:         loc_oPgf.Left   = -1
308:         loc_oPgf.Width  = THIS.Width + 2
309:         loc_oPgf.Height = THIS.Height - 82
310:         loc_oPgf.Tabs   = .F.
311: 
312:         loc_oPgf.Page1.Caption   = "Filtros"
313:         loc_oPgf.Page1.FontName  = "Tahoma"
314:         loc_oPgf.Page1.FontSize  = 8
315:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
316:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
317:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
318: 
319:         loc_oPgf.Visible    = .T.
320:         loc_oPgf.ActivePage = 1
321:     ENDPROC
322: 
323:     *--------------------------------------------------------------------------
324:     * LimparCampos - Reinicia todas as propriedades de filtro do BO
325:     *   Sincronizado com as propriedades declaradas em sigreipeBO.prg
326:     *--------------------------------------------------------------------------
327:     PROCEDURE LimparCampos()
328:         IF VARTYPE(THIS.this_oRelatorio) = "O"
329:             WITH THIS.this_oRelatorio
330:                 .this_cCodigos        = ""
331:                 .this_cDescs          = ""
332:                 .this_cNmOperacao     = ""
333:                 .this_dDtInicial      = {}
334:                 .this_dDtFinal        = {}
335:                 .this_nConta          = 2
336:                 .this_nColunas        = 2
337:                 .this_nQtdEtiq        = 1
338:                 .this_nOrdem          = 2
339:                 .this_nOrdemDir       = 2
340:                 .this_nImpPais        = 2
341:                 .this_nImpCodigo      = 1
342:                 .this_nImpMaius       = 2
343:                 .this_nImpContatos    = 2
344:                 .this_nImpressora     = 1
345:                 .this_cNomeImpressora = ""
346:             ENDWITH
347:         ENDIF
348:         LOCAL loc_oPg1
349:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
350:         IF PEMSTATUS(loc_oPg1, "txt_4c_Codigo", 5)
351:             loc_oPg1.txt_4c_Codigo.Value       = ""
352:             loc_oPg1.txt_4c_Desc.Value         = ""
353:             loc_oPg1.txt_4c__nm_operacao.Value = ""
354:             loc_oPg1.txt_4c__dt_inicial.Value  = {}
355:             loc_oPg1.txt_4c__dt_final.Value    = {}
356:             loc_oPg1.obj_4c_Spn_qtdetiq.Value  = 1
357:             loc_oPg1.obj_4c_Opt_conta.Value    = 2
358:         ENDIF
359:         IF PEMSTATUS(loc_oPg1, "obj_4c_Option", 5)
360:             loc_oPg1.obj_4c_Option.Value         = 2
361:             loc_oPg1.obj_4c_OpOrdem.Value        = 2
362:             loc_oPg1.obj_4c_OpColunas.Value      = 2
363:             loc_oPg1.obj_4c_OptPais.Value        = 2
364:             loc_oPg1.obj_4c_OptCodigo.Value      = 1
365:             loc_oPg1.obj_4c_OptProper.Value      = 2
366:             loc_oPg1.obj_4c_OptContatos.Value    = 2
367:             loc_oPg1.obj_4c_Opt_Impressora.Value = 1
368:         ENDIF
369:         THIS.AtualizarEstadoControles()
370:     ENDPROC
371: 
372:     *--------------------------------------------------------------------------
373:     * Destroy - Libera BO e cursor ao encerrar (NAO usar .Release() em Custom)
374:     *--------------------------------------------------------------------------
375:     PROCEDURE Destroy()
376:         IF VARTYPE(THIS.this_oRelatorio) = "O"
377:             THIS.this_oRelatorio = .NULL.
378:         ENDIF
379:         IF USED("cursor_4c_Operacoes")
380:             USE IN cursor_4c_Operacoes
381:         ENDIF
382:         IF USED("Relacao")
383:             USE IN Relacao
384:         ENDIF
385:         IF USED("CsCabecalho")
386:             USE IN CsCabecalho
387:         ENDIF
388:         IF USED("DbImpressao")
389:             USE IN DbImpressao
390:         ENDIF
391:         DODEFAULT()
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaLista - Adiciona grid de operacoes e botoes na Page1
396:     *   Original grdOper: top=207, left=17, width=727, height=148, 6 colunas
397:     *   Original SelTudo: top=220, left=756, w=45, h=45
398:     *   Original apaga:   top=264, left=756, w=45, h=45
399:     *   Na Page1 (PageFrame.Top=82): top ajustado 207-82=125, 220-82=138, 264-82=182
400:     *--------------------------------------------------------------------------
401:     PROTECTED PROCEDURE ConfigurarPaginaLista()
402:         LOCAL loc_oPagina
403:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
404: 
405:         *-- Cursor placeholder com mesmo esquema do SQLEXEC em ValidarDtFinal
406:         IF USED("cursor_4c_Operacoes")
407:             USE IN cursor_4c_Operacoes
408:         ENDIF
409:         CREATE CURSOR cursor_4c_Operacoes (;
410:             Marcas    I,;
411:             Emps      C(2),;
412:             Dopes     C(6),;
413:             Numes     N(8,0),;
414:             DescOrigs C(60),;
415:             DescDests C(60),;
416:             ContaEs   C(15),;
417:             LocalEnts N(8,0))
418: 
419:         THIS.ConfigurarGridOperacoes(loc_oPagina)
420:         THIS.ConfigurarBotoesSelecao(loc_oPagina)
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * ConfigurarGridOperacoes - Grid com 6 colunas para selecao de operacoes
425:     *   CheckBox em Column1: AddObject -> Caption/Value -> CurrentControl -> ControlSource
426:     *--------------------------------------------------------------------------
427:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPage)
428:         LOCAL loc_oGrid
429: 
430:         par_oPage.AddObject("grd_4c_GrdOper", "Grid")
431:         loc_oGrid = par_oPage.grd_4c_GrdOper
432: 
433:         WITH loc_oGrid
434:             .Top                = 125
435:             .Left               = 17
436:             .Width              = 727
437:             .Height             = 148
438:             .ColumnCount        = 6
439:             .RecordSource       = "cursor_4c_Operacoes"
440:             .RecordMark         = .F.
441:             .DeleteMark         = .F.
442:             .ReadOnly           = .F.
443:             .FontName           = "Verdana"
444:             .FontSize           = 8
445:             .ForeColor          = RGB(90, 90, 90)
446:             .BackColor          = RGB(255, 255, 255)
447:             .GridLineColor      = RGB(238, 238, 238)
448:             .HighlightBackColor = RGB(255, 255, 255)
449:             .HighlightForeColor = RGB(15, 41, 104)
450:             .HighlightStyle     = 2
451:             .ScrollBars         = 2
452:             .RowHeight          = 16
453: 
454:             *-- Column1: Marcas (CheckBox) - ordem critica obrigatoria
455:             WITH .Column1
456:                 .Width     = 30
457:                 .Alignment = 2
458:                 .Sparse    = .F.
459:                 .AddObject("Check1", "CheckBox")
460:                 .Check1.Caption = ""
461:                 .Check1.Value   = 0
462:                 .Check1.Width   = 25
463:                 .Check1.Height  = 14
464:                 .CurrentControl  = "Check1"
465:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
466:                 .Header1.Caption = ""
467:             ENDWITH
468: 
469:             *-- Column2: Emps
470:             WITH .Column2
471:                 .Width           = 40
472:                 .ControlSource   = "cursor_4c_Operacoes.Emps"
473:                 .Header1.Caption = "Emp"
474:             ENDWITH
475: 
476:             *-- Column3: Dopes (Operacao)
477:             WITH .Column3
478:                 .Width           = 80
479:                 .ControlSource   = "cursor_4c_Operacoes.Dopes"
480:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
481:             ENDWITH
482: 
483:             *-- Column4: Numes (Codigo)
484:             WITH .Column4
485:                 .Width           = 70
486:                 .ControlSource   = "cursor_4c_Operacoes.Numes"
487:                 .Header1.Caption = CHR(67) + CHR(243) + "digo"
488:             ENDWITH
489: 
490:             *-- Column5: DescOrigs (Conta Origem)
491:             WITH .Column5
492:                 .Width           = 255
493:                 .ControlSource   = "cursor_4c_Operacoes.DescOrigs"
494:                 .Header1.Caption = "Origem"
495:             ENDWITH
496: 
497:             *-- Column6: DescDests (Conta Destino) - 30+40+80+70+255+252=727
498:             WITH .Column6
499:                 .Width           = 252
500:                 .ControlSource   = "cursor_4c_Operacoes.DescDests"
501:                 .Header1.Caption = "Destino"
502:             ENDWITH
503: 
504:             .Visible = .T.
505:         ENDWITH
506:     ENDPROC
507: 
508:     *--------------------------------------------------------------------------
509:     * ConfigurarBotoesSelecao - Botoes SelTudo e Apaga ao lado direito do grid
510:     *--------------------------------------------------------------------------
511:     PROTECTED PROCEDURE ConfigurarBotoesSelecao(par_oPage)
512:         *-- SelTudo: selecionar todos (original top=220, left=756, w=45, h=45 -> Page1: top=138)
513:         par_oPage.AddObject("cmd_4c_SelTudo", "CommandButton")
514:         WITH par_oPage.cmd_4c_SelTudo
515:             .Top           = 138
516:             .Left          = 756
517:             .Width         = 45
518:             .Height        = 45
519:             .Caption       = "Todos"
520:             .FontName      = "Tahoma"
521:             .FontBold      = .T.
522:             .FontSize      = 7
523:             .BackColor     = RGB(255, 255, 255)
524:             .ForeColor     = RGB(90, 90, 90)
525:             .SpecialEffect = 0
526:             .Themes        = .F.
527:             .MousePointer  = 15
528:             .WordWrap      = .T.
529:             .ToolTipText   = "Selecionar todos os registros"
530:             .Visible       = .T.
531:         ENDWITH
532:         BINDEVENT(par_oPage.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
533: 
534:         *-- Apaga: desmarcar todos (original top=264, left=756, w=45, h=45 -> Page1: top=182)
535:         par_oPage.AddObject("cmd_4c_Apaga", "CommandButton")
536:         WITH par_oPage.cmd_4c_Apaga
537:             .Top           = 182
538:             .Left          = 756
539:             .Width         = 45
540:             .Height        = 45
541:             .Caption       = "Nenhum"
542:             .FontName      = "Tahoma"
543:             .FontBold      = .T.
544:             .FontSize      = 7
545:             .BackColor     = RGB(255, 255, 255)
546:             .ForeColor     = RGB(90, 90, 90)
547:             .SpecialEffect = 0
548:             .Themes        = .F.
549:             .MousePointer  = 15
550:             .WordWrap      = .T.
551:             .ToolTipText   = "Desmarcar todos os registros"
552:             .Visible       = .T.
553:         ENDWITH
554:         BINDEVENT(par_oPage.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
555:     ENDPROC
556: 
557:     *--------------------------------------------------------------------------
558:     * CmdSelTudoClick - Marca todos os registros do grid (Marcas=1)
559:     *   Replica: Select tmpOper + Replace All tmpOper.marcas with 1
560:     *--------------------------------------------------------------------------
561:     PROCEDURE CmdSelTudoClick()
562:         IF USED("cursor_4c_Operacoes")
563:             SELECT cursor_4c_Operacoes
564:             REPLACE ALL Marcas WITH 1
565:             GO TOP
566:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
567:         ENDIF
568:     ENDPROC
569: 
570:     *--------------------------------------------------------------------------
571:     * CmdApagaClick - Desmarca todos os registros do grid (Marcas=0)
572:     *   Replica: Select TmpOper + Replace All TmpOper.marcas with 0
573:     *--------------------------------------------------------------------------
574:     PROCEDURE CmdApagaClick()
575:         IF USED("cursor_4c_Operacoes")
576:             SELECT cursor_4c_Operacoes
577:             REPLACE ALL Marcas WITH 0
578:             GO TOP
579:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
580:         ENDIF
581:     ENDPROC
582: 
583:     *--------------------------------------------------------------------------
584:     * AlternarPagina - Alterna para pagina indicada no PageFrame
585:     *   Formulario de etiquetas usa PageCount=1 (todos os controles em Page1)
586:     *--------------------------------------------------------------------------
587:     PROCEDURE AlternarPagina(par_nPagina)
588:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
589:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
590:         ENDIF
591:     ENDPROC
592: 
593:     *--------------------------------------------------------------------------
594:     * ConfigurarPaginaDados - Adiciona campos de filtro (primeira metade) em Page1
595:     *   Controles: Say1, Get_codigo, Get_desc, lbl_dopes, get_nm_operacao,
596:     *              lbl_periodo, get_dt_inicial, lbl_periodo_a, get_dt_final,
597:     *              Say8, spn_qtdetiq, Say5, opt_conta
598:     *   Top ajustado: top_original - 82 (compensa PageFrame.Top=82)
599:     *--------------------------------------------------------------------------
600:     PROTECTED PROCEDURE ConfigurarPaginaDados()
601:         LOCAL loc_oPagina
602:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
603: 
604:         *-- Rotulo "Selecao :" (Say1: top=104, left=46)
605:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
606:         WITH loc_oPagina.lbl_4c_Label1
607:             .Top       = 22
608:             .Left      = 46
609:             .Caption   = "Sele" + CHR(231) + CHR(227) + "o :"
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .ForeColor = RGB(90, 90, 90)
613:             .BackStyle = 0
614:             .AutoSize  = .T.
615:             .Visible   = .T.
616:         ENDWITH
617: 
618:         *-- Campo Codigo (Get_codigo: top=100, left=97, width=66, maxlength=8)
619:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
620:         WITH loc_oPagina.txt_4c_Codigo
621:             .Top           = 18
622:             .Left          = 97
623:             .Width         = 66
624:             .Height        = 21
625:             .MaxLength     = 8
626:             .SpecialEffect = 1
627:             .FontName      = "Tahoma"
628:             .FontSize      = 8
629:             .Value         = ""
630:             .Visible       = .T.
631:         ENDWITH
632:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "TxtCodigoKeyPress")
633:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "DblClick", THIS, "AbrirBuscaCodigo")
634: 
635:         *-- Campo Descricao (Get_desc: top=100, left=165, width=220, maxlength=30)
636:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
637:         WITH loc_oPagina.txt_4c_Desc
638:             .Top           = 18
639:             .Left          = 165
640:             .Width         = 220
641:             .Height        = 21
642:             .MaxLength     = 30
643:             .SpecialEffect = 1
644:             .FontName      = "Tahoma"
645:             .FontSize      = 8
646:             .Value         = ""
647:             .Visible       = .T.
648:         ENDWITH
649:         BINDEVENT(loc_oPagina.txt_4c_Desc, "KeyPress", THIS, "TxtDescKeyPress")
650:         BINDEVENT(loc_oPagina.txt_4c_Desc, "DblClick", THIS, "AbrirBuscaDesc")
651: 
652:         *-- Rotulo "Operacao :" (lbl_dopes: top=128, left=36)
653:         loc_oPagina.AddObject("lbl_4c_Lbl_dopes", "Label")
654:         WITH loc_oPagina.lbl_4c_Lbl_dopes
655:             .Top       = 46
656:             .Left      = 36
657:             .Width     = 56
658:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
659:             .FontName  = "Tahoma"
660:             .FontSize  = 8
661:             .ForeColor = RGB(90, 90, 90)
662:             .BackStyle = 0
663:             .AutoSize  = .T.
664:             .Visible   = .T.
665:         ENDWITH
666: 
667:         *-- Campo Operacao (get_nm_operacao: top=125, left=97, width=150)
668:         *   FontName=Courier New, FontSize=9, Format=K! (uppercase automatico)
669:         loc_oPagina.AddObject("txt_4c__nm_operacao", "TextBox")
670:         WITH loc_oPagina.txt_4c__nm_operacao
671:             .Top           = 43
672:             .Left          = 97
673:             .Width         = 150
674:             .Height        = 21
675:             .MaxLength     = 20
676:             .SpecialEffect = 1
677:             .FontName      = "Courier New"
678:             .FontSize      = 9
679:             .Format        = "K!"
680:             .Value         = ""
681:             .ForeColor     = RGB(0, 0, 0)
682:             .Visible       = .T.
683:         ENDWITH
684:         BINDEVENT(loc_oPagina.txt_4c__nm_operacao, "KeyPress",  THIS, "TxtNmOperacaoKeyPress")
685:         BINDEVENT(loc_oPagina.txt_4c__nm_operacao, "KeyPress", THIS, "TxtNmOperacaoLostFocus")
686: 
687:         *-- Rotulo "Periodo :" (lbl_periodo: top=151, left=47)
688:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo", "Label")
689:         WITH loc_oPagina.lbl_4c_Lbl_periodo
690:             .Top       = 69
691:             .Left      = 47
692:             .Caption   = "Per" + CHR(237) + "odo :"
693:             .FontName  = "Tahoma"
694:             .FontSize  = 8
695:             .ForeColor = RGB(90, 90, 90)
696:             .BackStyle = 0
697:             .AutoSize  = .T.
698:             .Visible   = .T.
699:         ENDWITH
700: 
701:         *-- Data inicial (get_dt_inicial: top=148, left=97, width=80)
702:         *   Desabilitado ate que Operacao seja preenchida (When original)
703:         loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
704:         WITH loc_oPagina.txt_4c__dt_inicial
705:             .Top           = 66
706:             .Left          = 97
707:             .Width         = 80
708:             .Height        = 21
709:             .SpecialEffect = 1
710:             .FontName      = "Tahoma"
711:             .FontSize      = 8
712:             .Format        = "K"
713:             .Value         = {}
714:             .Enabled       = .F.
715:             .Visible       = .T.
716:         ENDWITH
717: 
718:         *-- Rotulo separador "a" (lbl_periodo_a: top=151, left=182)
719:         loc_oPagina.AddObject("lbl_4c_Lbl_periodo_a", "Label")
720:         WITH loc_oPagina.lbl_4c_Lbl_periodo_a
721:             .Top       = 69
722:             .Left      = 182
723:             .Width     = 8
724:             .Caption   = CHR(224)
725:             .FontName  = "Tahoma"

*-- Linhas 746 a 1223:
746:             .Enabled       = .F.
747:             .Visible       = .T.
748:         ENDWITH
749:         BINDEVENT(loc_oPagina.txt_4c__dt_final, "KeyPress", THIS, "TxtDtFinalKeyPress")
750: 
751:         *-- Rotulo "Qtd. copias :" (Say8: top=151, left=281, FontName=Verdana)
752:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
753:         WITH loc_oPagina.lbl_4c_Label8
754:             .Top       = 69
755:             .Left      = 281
756:             .Width     = 75
757:             .Caption   = "Qtd. c" + CHR(243) + "pias :"
758:             .FontName  = "Verdana"
759:             .FontSize  = 8
760:             .ForeColor = RGB(90, 90, 90)
761:             .BackStyle = 0
762:             .Visible   = .T.
763:         ENDWITH
764: 
765:         *-- Spinner quantidade de etiquetas (spn_qtdetiq: top=148, left=360, range 1..10)
766:         loc_oPagina.AddObject("obj_4c_Spn_qtdetiq", "Spinner")
767:         WITH loc_oPagina.obj_4c_Spn_qtdetiq
768:             .Top               = 66
769:             .Left              = 360
770:             .Width             = 53
771:             .Height            = 21
772:             .SpecialEffect     = 1
773:             .SpinnerHighValue  = 10
774:             .SpinnerLowValue   = 1
775:             .KeyboardHighValue = 10
776:             .KeyboardLowValue  = 1
777:             .Value             = 1
778:             .Enabled           = .F.
779:             .Visible           = .T.
780:         ENDWITH
781: 
782:         *-- Rotulo "Conta :" (Say5: top=176, left=54)
783:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
784:         WITH loc_oPagina.lbl_4c_Label5
785:             .Top       = 94
786:             .Left      = 54
787:             .Width     = 38
788:             .Caption   = "Conta :"
789:             .FontName  = "Tahoma"
790:             .FontSize  = 8
791:             .ForeColor = RGB(90, 90, 90)
792:             .BackStyle = 0
793:             .AutoSize  = .T.
794:             .Visible   = .T.
795:         ENDWITH
796: 
797:         *-- OptionGroup Conta (opt_conta: top=172, left=91, width=135, Value=2=Destino)
798:         *   Option1="Origem" (Value=0), Option2="Destino" (Value=1), grupo Value=2
799:         loc_oPagina.AddObject("obj_4c_Opt_conta", "OptionGroup")
800:         WITH loc_oPagina.obj_4c_Opt_conta
801:             .Top           = 90
802:             .Left          = 91
803:             .Width         = 135
804:             .Height        = 25
805:             .ButtonCount   = 2
806:             .BackStyle     = 0
807:             .BorderStyle   = 0
808:             .SpecialEffect = 1
809:             .Value         = 2
810:             .Enabled       = .F.
811: 
812:             WITH .Buttons(1)
813:                 .Caption   = "Origem"
814:                 .Value     = 0
815:                 .BackStyle = 0
816:                 .ForeColor = RGB(90, 90, 90)
817:                 .Height    = 15
818:                 .Left      = 5
819:                 .Top       = 5
820:                 .Width     = 52
821:                 .AutoSize  = .T.
822:             ENDWITH
823: 
824:             WITH .Buttons(2)
825:                 .Caption   = "Destino"
826:                 .Value     = 1
827:                 .FontName  = "Tahoma"
828:                 .FontSize  = 8
829:                 .BackStyle = 0
830:                 .ForeColor = RGB(90, 90, 90)
831:                 .Height    = 15
832:                 .Left      = 68
833:                 .Top       = 5
834:                 .Width     = 54
835:                 .AutoSize  = .T.
836:             ENDWITH
837: 
838:             .Visible = .T.
839:         ENDWITH
840:         BINDEVENT(loc_oPagina.obj_4c_Opt_conta, "InteractiveChange", THIS, "OptContaInteractiveChange")
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * AtualizarEstadoControles - Habilita/desabilita campos conforme estado atual
845:     *   Replica os eventos When do original:
846:     *     txt_4c_Codigo.When:       !lTemNmOp   (desabilitado se operacao preenchida)
847:     *     txt_4c_Desc.When:         !lTemNmOp AND !lTemCodigo
848:     *     txt_4c__nm_operacao.When: !lTemCodigo (desabilitado se codigo preenchido)
849:     *     datas/spinner/conta.When: lTemNmOp    (somente quando operacao preenchida)
850:     *--------------------------------------------------------------------------
851:     PROCEDURE AtualizarEstadoControles()
852:         LOCAL loc_oPg1, loc_lTemNmOp, loc_lTemCodigo
853:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
854: 
855:         IF !PEMSTATUS(loc_oPg1, "txt_4c_Codigo", 5)
856:             RETURN
857:         ENDIF
858: 
859:         loc_lTemNmOp   = !EMPTY(ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value))
860:         loc_lTemCodigo = !EMPTY(ALLTRIM(loc_oPg1.txt_4c_Codigo.Value))
861: 
862:         loc_oPg1.txt_4c_Codigo.Enabled         = !loc_lTemNmOp
863:         loc_oPg1.txt_4c_Desc.Enabled           = !loc_lTemNmOp AND !loc_lTemCodigo
864:         loc_oPg1.txt_4c__nm_operacao.Enabled   = !loc_lTemCodigo
865:         loc_oPg1.txt_4c__dt_inicial.Enabled    = loc_lTemNmOp
866:         loc_oPg1.txt_4c__dt_final.Enabled      = loc_lTemNmOp
867:         loc_oPg1.obj_4c_Spn_qtdetiq.Enabled    = loc_lTemNmOp
868:         loc_oPg1.obj_4c_Opt_conta.Enabled      = loc_lTemNmOp
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * TxtCodigoKeyPress - F4/F5 abre busca direta; ENTER/TAB valida e preenche desc
873:     *--------------------------------------------------------------------------
874:     PROCEDURE TxtCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
875:         IF INLIST(par_nKeyCode, 115, 116)
876:             THIS.AbrirBuscaCodigo()
877:         ELSE
878:             IF INLIST(par_nKeyCode, 13, 9)
879:             THIS.ValidarCodigo()
880:             ENDIF
881:         ENDIF
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * TxtDescKeyPress - F4/F5 abre busca direta; ENTER/TAB valida e preenche codigo
886:     *--------------------------------------------------------------------------
887:     PROCEDURE TxtDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
888:         IF INLIST(par_nKeyCode, 115, 116)
889:             THIS.AbrirBuscaDesc()
890:         ELSE
891:             IF INLIST(par_nKeyCode, 13, 9)
892:             THIS.ValidarDesc()
893:             ENDIF
894:         ENDIF
895:     ENDPROC
896: 
897:     *--------------------------------------------------------------------------
898:     * TxtNmOperacaoKeyPress - ENTER/TAB valida operacao e atualiza estado dos campos
899:     *--------------------------------------------------------------------------
900:     PROCEDURE TxtNmOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
901:         IF INLIST(par_nKeyCode, 13, 9)
902:             THIS.ValidarNmOperacao()
903:         ENDIF
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * TxtNmOperacaoLostFocus - Limpa datas se campo Operacao ficou vazio
908:     *   Replica: get_nm_operacao.LostFocus do original
909:     *--------------------------------------------------------------------------
910:     PROCEDURE TxtNmOperacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
911:         LOCAL loc_oPg1
912:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
913:         IF EMPTY(ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value))
914:             loc_oPg1.txt_4c__dt_inicial.Value = {}
915:             loc_oPg1.txt_4c__dt_final.Value   = {}
916:         ENDIF
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * TxtDtFinalKeyPress - ENTER/TAB dispara consulta SQL e popula o grid
921:     *--------------------------------------------------------------------------
922:     PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
923:         IF INLIST(par_nKeyCode, 13, 9)
924:             THIS.ValidarDtFinal()
925:         ENDIF
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * OptContaInteractiveChange - Re-executa consulta quando Conta muda
930:     *   Replica: opt_conta.InteractiveChange do original
931:     *--------------------------------------------------------------------------
932:     PROCEDURE OptContaInteractiveChange()
933:         LOCAL loc_oPg1
934:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
935:         IF !EMPTY(loc_oPg1.txt_4c__dt_inicial.Value) AND ;
936:            !EMPTY(loc_oPg1.txt_4c__dt_final.Value)
937:             THIS.ValidarDtFinal()
938:         ENDIF
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * ValidarCodigo - Busca por Codigos em SigMlItn e preenche Descricao
943:     *   Replica: Get_codigo.Valid do original (fwbuscaext por Codigos)
944:     *--------------------------------------------------------------------------
945:     PROCEDURE ValidarCodigo()
946:         LOCAL loc_oPg1, loc_cValor, loc_oForm
947:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
948:         loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Codigo.Value)
949: 
950:         IF EMPTY(loc_cValor)
951:             loc_oPg1.txt_4c_Codigo.Value = ""
952:             loc_oPg1.txt_4c_Desc.Value   = ""
953:             THIS.AtualizarEstadoControles()
954:             RETURN
955:         ENDIF
956: 
957:         TRY
958:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
959:                 "SigMlItn", "cursor_4c_BuscaCodigo", "Codigos", loc_cValor, ;
960:                 "Sele" + CHR(231) + CHR(227) + "o")
961: 
962:             IF VARTYPE(loc_oForm) != "O"
963:                 RETURN
964:             ENDIF
965: 
966:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
967:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.Codigos)
968:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
969:             ELSE
970:                 IF !loc_oForm.this_lAchouRegistro
971:                 loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
972:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
973:                 loc_oForm.Show()
974:                 IF loc_oForm.this_lSelecionou
975:                     loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.Codigos)
976:                     loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
977:                 ELSE
978:                     loc_oPg1.txt_4c_Codigo.Value = ""
979:                     loc_oPg1.txt_4c_Desc.Value   = ""
980:                 ENDIF
981:                 ENDIF
982:             ENDIF
983: 
984:             IF USED("cursor_4c_BuscaCodigo")
985:                 USE IN cursor_4c_BuscaCodigo
986:             ENDIF
987:             loc_oForm.Release()
988: 
989:         CATCH TO loc_oErro
990:             MsgErro(loc_oErro.Message + CHR(13) + ;
991:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
992:         ENDTRY
993: 
994:         loc_oPg1.txt_4c_Codigo.Refresh()
995:         loc_oPg1.txt_4c_Desc.Refresh()
996:         THIS.AtualizarEstadoControles()
997:     ENDPROC
998: 
999:     *--------------------------------------------------------------------------
1000:     * ValidarDesc - Busca por Descs em SigMlItn e preenche Codigo
1001:     *   Replica: Get_desc.Valid do original (fwbuscaext por Descs)
1002:     *--------------------------------------------------------------------------
1003:     PROCEDURE ValidarDesc()
1004:         LOCAL loc_oPg1, loc_cValor, loc_oForm
1005:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
1006:         loc_cValor = ALLTRIM(loc_oPg1.txt_4c_Desc.Value)
1007: 
1008:         IF EMPTY(loc_cValor)
1009:             loc_oPg1.txt_4c_Codigo.Value = ""
1010:             loc_oPg1.txt_4c_Desc.Value   = ""
1011:             THIS.AtualizarEstadoControles()
1012:             RETURN
1013:         ENDIF
1014: 
1015:         TRY
1016:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1017:                 "SigMlItn", "cursor_4c_BuscaDesc", "Descs", loc_cValor, ;
1018:                 "Sele" + CHR(231) + CHR(227) + "o")
1019: 
1020:             IF VARTYPE(loc_oForm) != "O"
1021:                 RETURN
1022:             ENDIF
1023: 
1024:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1025:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDesc.Codigos)
1026:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1027:             ELSE
1028:                 IF !loc_oForm.this_lAchouRegistro
1029:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1030:                 loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1031:                 loc_oForm.Show()
1032:                 IF loc_oForm.this_lSelecionou
1033:                     loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDesc.Codigos)
1034:                     loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1035:                 ELSE
1036:                     loc_oPg1.txt_4c_Codigo.Value = ""
1037:                     loc_oPg1.txt_4c_Desc.Value   = ""
1038:                 ENDIF
1039:                 ENDIF
1040:             ENDIF
1041: 
1042:             IF USED("cursor_4c_BuscaDesc")
1043:                 USE IN cursor_4c_BuscaDesc
1044:             ENDIF
1045:             loc_oForm.Release()
1046: 
1047:         CATCH TO loc_oErro
1048:             MsgErro(loc_oErro.Message + CHR(13) + ;
1049:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1050:         ENDTRY
1051: 
1052:         loc_oPg1.txt_4c_Codigo.Refresh()
1053:         loc_oPg1.txt_4c_Desc.Refresh()
1054:         THIS.AtualizarEstadoControles()
1055:     ENDPROC
1056: 
1057:     *--------------------------------------------------------------------------
1058:     * AbrirBuscaCodigo - Lookup direto (F4/DblClick) em SigMlItn por Codigos
1059:     *--------------------------------------------------------------------------
1060:     PROCEDURE AbrirBuscaCodigo()
1061:         LOCAL loc_oPg1, loc_oForm
1062:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1063: 
1064:         TRY
1065:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1066:                 "SigMlItn", "cursor_4c_BuscaCodigo", "Codigos", "", ;
1067:                 "Sele" + CHR(231) + CHR(227) + "o")
1068: 
1069:             IF VARTYPE(loc_oForm) != "O"
1070:                 RETURN
1071:             ENDIF
1072: 
1073:             loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1074:             loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1075:             loc_oForm.Show()
1076: 
1077:             IF loc_oForm.this_lSelecionou
1078:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.Codigos)
1079:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
1080:                 loc_oPg1.txt_4c_Codigo.Refresh()
1081:                 loc_oPg1.txt_4c_Desc.Refresh()
1082:                 THIS.AtualizarEstadoControles()
1083:             ENDIF
1084: 
1085:             IF USED("cursor_4c_BuscaCodigo")
1086:                 USE IN cursor_4c_BuscaCodigo
1087:             ENDIF
1088:             loc_oForm.Release()
1089: 
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + CHR(13) + ;
1092:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1093:         ENDTRY
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     * AbrirBuscaDesc - Lookup direto (F4/DblClick) em SigMlItn por Descs
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE AbrirBuscaDesc()
1100:         LOCAL loc_oPg1, loc_oForm
1101:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1102: 
1103:         TRY
1104:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1105:                 "SigMlItn", "cursor_4c_BuscaDesc", "Descs", "", ;
1106:                 "Sele" + CHR(231) + CHR(227) + "o")
1107: 
1108:             IF VARTYPE(loc_oForm) != "O"
1109:                 RETURN
1110:             ENDIF
1111: 
1112:             loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1113:             loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1114:             loc_oForm.Show()
1115: 
1116:             IF loc_oForm.this_lSelecionou
1117:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDesc.Codigos)
1118:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1119:                 loc_oPg1.txt_4c_Codigo.Refresh()
1120:                 loc_oPg1.txt_4c_Desc.Refresh()
1121:                 THIS.AtualizarEstadoControles()
1122:             ENDIF
1123: 
1124:             IF USED("cursor_4c_BuscaDesc")
1125:                 USE IN cursor_4c_BuscaDesc
1126:             ENDIF
1127:             loc_oForm.Release()
1128: 
1129:         CATCH TO loc_oErro
1130:             MsgErro(loc_oErro.Message + CHR(13) + ;
1131:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1132:         ENDTRY
1133:     ENDPROC
1134: 
1135:     *--------------------------------------------------------------------------
1136:     * ValidarNmOperacao - Valida acesso a operacao (replica fAcessoMovmto)
1137:     *   Verifica se o codigo de operacao existe em SigMvCab.Dopes
1138:     *--------------------------------------------------------------------------
1139:     PROCEDURE ValidarNmOperacao()
1140:         LOCAL loc_oPg1, loc_cValor, loc_cSQL, loc_nResult
1141:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
1142:         loc_cValor = ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value)
1143: 
1144:         IF EMPTY(loc_cValor)
1145:             THIS.AtualizarEstadoControles()
1146:             RETURN
1147:         ENDIF
1148: 
1149:         TRY
1150:             loc_cSQL    = "SELECT TOP 1 Dopes FROM SigMvCab" + ;
1151:                           " WHERE RTRIM(Dopes) = " + EscaparSQL(loc_cValor)
1152:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NmOpVal")
1153: 
1154:             IF loc_nResult > 0
1155:                 SELECT cursor_4c_NmOpVal
1156:                 IF EOF()
1157:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cValor + ;
1158:                         "' n" + CHR(227) + "o encontrada.", "Aviso")
1159:                     loc_oPg1.txt_4c__nm_operacao.Value = ""
1160:                 ENDIF
1161:             ENDIF
1162: 
1163:             IF USED("cursor_4c_NmOpVal")
1164:                 USE IN cursor_4c_NmOpVal
1165:             ENDIF
1166: 
1167:         CATCH TO loc_oErro
1168:             MsgErro(loc_oErro.Message + CHR(13) + ;
1169:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1170:         ENDTRY
1171: 
1172:         THIS.AtualizarEstadoControles()
1173:     ENDPROC
1174: 
1175:     *--------------------------------------------------------------------------
1176:     * ValidarDtFinal - Executa SQL e popula grid com operacoes do periodo
1177:     *   Replica: get_dt_final.Valid do original
1178:     *   SQL: SigMvCab JOIN SigCdCli (b=ContaOs, c=ContaDs) com todos os campos
1179:     *   Cursor READWRITE (para marcacao via CheckBox no grid)
1180:     *   lnConta=1 -> usar dados de SigCdCli da Conta Origem (b.*)
1181:     *   lnConta=2 -> usar dados de SigCdCli da Conta Destino (c.*)
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE ValidarDtFinal()
1184:         LOCAL loc_oPg1, loc_cDopes, loc_dDataIni, loc_dDataFin
1185:         LOCAL loc_nConta, loc_cSQL, loc_nResult, loc_oGrid
1186:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1187:         loc_cDopes   = ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value)
1188:         loc_dDataIni = loc_oPg1.txt_4c__dt_inicial.Value
1189:         loc_dDataFin = loc_oPg1.txt_4c__dt_final.Value
1190:         loc_nConta   = loc_oPg1.obj_4c_Opt_conta.Value
1191:         loc_oGrid    = loc_oPg1.grd_4c_GrdOper
1192: 
1193:         IF EMPTY(loc_dDataFin)
1194:             RETURN
1195:         ENDIF
1196: 
1197:         loc_oGrid.RecordSource = ""
1198: 
1199:         TRY
1200:             IF loc_nConta = 1
1201:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1202:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1203:                            "a.ContaEs, a.LocalEnts, " + ;
1204:                            "b.IClis, b.RClis, b.Endes, b.Nums, b.Compls, " + ;
1205:                            "b.Bairs, b.Cidas, b.Ceps, b.Estas, b.Tel1s, " + ;
1206:                            "b.Tel2s, b.Faxs, b.Nascs, b.cIdChaves, " + ;
1207:                            "b.Codigos, b.Paises, b.Contato " + ;
1208:                            "FROM SigMvCab a " + ;
1209:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1210:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1211:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1212:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;
1213:                            " AND " + FormatarDataSQL(loc_dDataFin) + ;
1214:                            " ORDER BY a.Numes"
1215:             ELSE
1216:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1217:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1218:                            "a.ContaEs, a.LocalEnts, " + ;
1219:                            "c.IClis, c.RClis, c.Endes, c.Nums, c.Compls, " + ;
1220:                            "c.Bairs, c.Cidas, c.Ceps, c.Estas, c.Tel1s, " + ;
1221:                            "c.Tel2s, c.Faxs, c.Nascs, c.cIdChaves, " + ;
1222:                            "c.Codigos, c.Paises, c.Contato " + ;
1223:                            "FROM SigMvCab a " + ;

*-- Linhas 1230 a 1337:
1230:             ENDIF
1231: 
1232:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpQuery")
1233: 
1234:             IF loc_nResult > 0
1235:                 IF USED("cursor_4c_Operacoes")
1236:                     USE IN cursor_4c_Operacoes
1237:                 ENDIF
1238:                 SELECT * FROM cursor_4c_TmpQuery INTO CURSOR cursor_4c_Operacoes READWRITE
1239:                 IF USED("cursor_4c_TmpQuery")
1240:                     USE IN cursor_4c_TmpQuery
1241:                 ENDIF
1242: 
1243:                 SELECT cursor_4c_Operacoes
1244:                 IF !EOF()
1245:                     GO TOP
1246:                     loc_oGrid.ColumnCount = 3
1247:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1248:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Marcas"
1249:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Operacoes.Emps"
1250:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Operacoes.Dopes"
1251:                 ELSE
1252:                     MsgAviso("Nenhum movimento encontrado nesse per" + ;
1253:                         CHR(237) + "odo.", "Aviso")
1254:                 ENDIF
1255:             ELSE
1256:                 IF USED("cursor_4c_TmpQuery")
1257:                     USE IN cursor_4c_TmpQuery
1258:                 ENDIF
1259:                 MsgErro("Erro ao consultar movimentos de " + loc_cDopes + ".", "Erro")
1260:             ENDIF
1261: 
1262:         CATCH TO loc_oErro
1263:             MsgErro(loc_oErro.Message + CHR(13) + ;
1264:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1265:         ENDTRY
1266: 
1267:         loc_oGrid.Refresh()
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     * ConfigurarPaginaDados2 - Adiciona controles de ordenacao e impressao em Page1
1272:     *   Controles: Say2/Option/OpOrdem (ordenacao), OpColunas (modelo etiqueta),
1273:     *              Label3/Opt_Impressora (termica), Say4/OptPais, Say6/OptCodigo,
1274:     *              Say7/OptProper, Say9/OptContatos
1275:     *   Top ajustado: top_original - 82 (PageFrame.Top=82)
1276:     *--------------------------------------------------------------------------
1277:     PROTECTED PROCEDURE ConfigurarPaginaDados2()
1278:         LOCAL loc_oPagina
1279:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1280: 
1281:         *-- Rotulo "Ordenacao :" (Say2: top=363, left=18)
1282:         loc_oPagina.AddObject("lbl_4c_Say2", "Label")
1283:         WITH loc_oPagina.lbl_4c_Say2
1284:             .Top       = 281
1285:             .Left      = 18
1286:             .Width     = 76
1287:             .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
1288:             .FontName  = "Tahoma"
1289:             .FontSize  = 8
1290:             .ForeColor = RGB(90, 90, 90)
1291:             .BackStyle = 0
1292:             .AutoSize  = .T.
1293:             .Visible   = .T.
1294:         ENDWITH
1295: 
1296:         *-- OptionGroup tipo de ordenacao (Option: top=378, left=18, Value=2=CEP)
1297:         loc_oPagina.AddObject("obj_4c_Option", "OptionGroup")
1298:         WITH loc_oPagina.obj_4c_Option
1299:             .Top           = 296
1300:             .Left          = 18
1301:             .Width         = 102
1302:             .Height        = 64
1303:             .ButtonCount   = 3
1304:             .BackStyle     = 0
1305:             .SpecialEffect = 1
1306:             .BorderColor   = RGB(90, 90, 90)
1307:             .Value         = 2
1308: 
1309:             WITH .Buttons(1)
1310:                 .Caption   = "Alfab" + CHR(233) + "tica"
1311:                 .BackStyle = 0
1312:                 .ForeColor = RGB(90, 90, 90)
1313:                 .Height    = 15
1314:                 .Left      = 5
1315:                 .Top       = 23
1316:                 .Width     = 66
1317:                 .AutoSize  = .T.
1318:             ENDWITH
1319: 
1320:             WITH .Buttons(2)
1321:                 .Caption   = "CEP"
1322:                 .Value     = 1
1323:                 .FontName  = "Tahoma"
1324:                 .FontSize  = 8
1325:                 .BackStyle = 0
1326:                 .ForeColor = RGB(90, 90, 90)
1327:                 .Height    = 15
1328:                 .Left      = 5
1329:                 .Top       = 6
1330:                 .Width     = 37
1331:                 .AutoSize  = .T.
1332:             ENDWITH
1333: 
1334:             WITH .Buttons(3)
1335:                 .Caption   = "Data Nasc."
1336:                 .FontName  = "Tahoma"
1337:                 .FontSize  = 8

*-- Linhas 1347 a 1433:
1347:             .Visible = .T.
1348:         ENDWITH
1349: 
1350:         *-- OptionGroup direcao de ordenacao (OpOrdem: top=451, left=18, Value=2=Descendente)
1351:         loc_oPagina.AddObject("obj_4c_OpOrdem", "OptionGroup")
1352:         WITH loc_oPagina.obj_4c_OpOrdem
1353:             .Top           = 369
1354:             .Left          = 18
1355:             .Width         = 102
1356:             .Height        = 83
1357:             .ButtonCount   = 2
1358:             .BackStyle     = 0
1359:             .SpecialEffect = 1
1360:             .BorderColor   = RGB(90, 90, 90)
1361:             .Value         = 2
1362: 
1363:             WITH .Buttons(1)
1364:                 .Caption   = "Ascendente"
1365:                 .BackStyle = 0
1366:                 .ForeColor = RGB(90, 90, 90)
1367:                 .Height    = 15
1368:                 .Left      = 5
1369:                 .Top       = 23
1370:                 .Width     = 75
1371:                 .AutoSize  = .T.
1372:             ENDWITH
1373: 
1374:             WITH .Buttons(2)
1375:                 .Caption   = "Descendente"
1376:                 .Value     = 1
1377:                 .FontName  = "Tahoma"
1378:                 .FontSize  = 8
1379:                 .BackStyle = 0
1380:                 .ForeColor = RGB(90, 90, 90)
1381:                 .Height    = 15
1382:                 .Left      = 5
1383:                 .Top       = 6
1384:                 .Width     = 81
1385:                 .AutoSize  = .T.
1386:             ENDWITH
1387: 
1388:             .Visible = .T.
1389:         ENDWITH
1390: 
1391:         *-- OptionGroup modelo de etiqueta (OpColunas: top=378, left=125, Value=2=2Colunas)
1392:         *   Valores: 1=3col-DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
1393:         loc_oPagina.AddObject("obj_4c_OpColunas", "OptionGroup")
1394:         WITH loc_oPagina.obj_4c_OpColunas
1395:             .Top           = 296
1396:             .Left          = 125
1397:             .Width         = 100
1398:             .Height        = 156
1399:             .ButtonCount   = 9
1400:             .BackStyle     = 0
1401:             .SpecialEffect = 1
1402:             .BorderColor   = RGB(90, 90, 90)
1403:             .Value         = 2
1404: 
1405:             WITH .Buttons(1)
1406:                 .Caption   = "3 Colunas"
1407:                 .BackStyle = 0
1408:                 .ForeColor = RGB(90, 90, 90)
1409:                 .Height    = 15
1410:                 .Left      = 5
1411:                 .Top       = 22
1412:                 .Width     = 65
1413:                 .AutoSize  = .T.
1414:             ENDWITH
1415: 
1416:             WITH .Buttons(2)
1417:                 .Caption   = "2 Colunas"
1418:                 .Value     = 1
1419:                 .FontName  = "Tahoma"
1420:                 .FontSize  = 8
1421:                 .BackStyle = 0
1422:                 .ForeColor = RGB(90, 90, 90)
1423:                 .Height    = 15
1424:                 .Left      = 5
1425:                 .Top       = 6
1426:                 .Width     = 65
1427:                 .AutoSize  = .T.
1428:             ENDWITH
1429: 
1430:             WITH .Buttons(3)
1431:                 .Caption   = "9 Linhas"
1432:                 .FontName  = "Tahoma"
1433:                 .FontSize  = 8

*-- Linhas 1534 a 1622:
1534:             .Visible   = .T.
1535:         ENDWITH
1536: 
1537:         *-- OptionGroup impressora termica (Opt_Impressora: top=378, left=230)
1538:         *   ButtonCount=1 inicial; CarregarImpressoras expande dinamicamente
1539:         loc_oPagina.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
1540:         WITH loc_oPagina.obj_4c_Opt_Impressora
1541:             .Top           = 296
1542:             .Left          = 230
1543:             .Width         = 215
1544:             .Height        = 156
1545:             .ButtonCount   = 1
1546:             .BackStyle     = 0
1547:             .SpecialEffect = 1
1548:             .BorderColor   = RGB(90, 90, 90)
1549:             .Value         = 1
1550: 
1551:             WITH .Buttons(1)
1552:                 .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
1553:                 .Value     = 1
1554:                 .BackStyle = 0
1555:                 .ForeColor = RGB(90, 90, 90)
1556:                 .Height    = 16
1557:                 .Left      = 9
1558:                 .Top       = 10
1559:                 .Width     = 210
1560:                 .AutoSize  = .F.
1561:             ENDWITH
1562: 
1563:             .Visible = .T.
1564:         ENDWITH
1565: 
1566:         *-- Rotulo "Imprimir Pais :" (Say4: top=424, left=595)
1567:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
1568:         WITH loc_oPagina.lbl_4c_Say4
1569:             .Top       = 342
1570:             .Left      = 595
1571:             .Width     = 69
1572:             .Caption   = "Imprimir Pa" + CHR(237) + "s :"
1573:             .FontName  = "Tahoma"
1574:             .FontSize  = 8
1575:             .ForeColor = RGB(90, 90, 90)
1576:             .BackStyle = 0
1577:             .AutoSize  = .T.
1578:             .Visible   = .T.
1579:         ENDWITH
1580: 
1581:         *-- OptionGroup Imprimir Pais (OptPais: top=419, left=669, Value=2=Nao)
1582:         loc_oPagina.AddObject("obj_4c_OptPais", "OptionGroup")
1583:         WITH loc_oPagina.obj_4c_OptPais
1584:             .Top           = 337
1585:             .Left          = 669
1586:             .Width         = 104
1587:             .Height        = 26
1588:             .ButtonCount   = 2
1589:             .BackStyle     = 0
1590:             .BorderStyle   = 0
1591:             .SpecialEffect = 0
1592:             .Value         = 2
1593: 
1594:             WITH .Buttons(1)
1595:                 .Caption   = "Sim"
1596:                 .BackStyle = 0
1597:                 .ForeColor = RGB(90, 90, 90)
1598:                 .Height    = 15
1599:                 .Left      = 5
1600:                 .Top       = 5
1601:                 .Width     = 34
1602:                 .AutoSize  = .T.
1603:             ENDWITH
1604: 
1605:             WITH .Buttons(2)
1606:                 .Caption   = "N" + CHR(227) + "o"
1607:                 .Value     = 1
1608:                 .FontName  = "Tahoma"
1609:                 .FontSize  = 8
1610:                 .BackStyle = 0
1611:                 .ForeColor = RGB(90, 90, 90)
1612:                 .Height    = 15
1613:                 .Left      = 56
1614:                 .Top       = 5
1615:                 .Width     = 37
1616:                 .AutoSize  = .T.
1617:             ENDWITH
1618: 
1619:             .Visible = .T.
1620:         ENDWITH
1621: 
1622:         *-- Rotulo "Imprimir Codigo :" (Say6: top=440, left=581)

*-- Linhas 1634 a 1678:
1634:             .Visible   = .T.
1635:         ENDWITH
1636: 
1637:         *-- OptionGroup Imprimir Codigo (OptCodigo: top=436, left=669, Value=1=Sim)
1638:         loc_oPagina.AddObject("obj_4c_OptCodigo", "OptionGroup")
1639:         WITH loc_oPagina.obj_4c_OptCodigo
1640:             .Top           = 354
1641:             .Left          = 669
1642:             .Width         = 104
1643:             .Height        = 26
1644:             .ButtonCount   = 2
1645:             .BackStyle     = 0
1646:             .BorderStyle   = 0
1647:             .SpecialEffect = 0
1648:             .Value         = 1
1649: 
1650:             WITH .Buttons(1)
1651:                 .Caption   = "Sim"
1652:                 .Value     = 1
1653:                 .BackStyle = 0
1654:                 .ForeColor = RGB(90, 90, 90)
1655:                 .Height    = 15
1656:                 .Left      = 5
1657:                 .Top       = 5
1658:                 .Width     = 34
1659:                 .AutoSize  = .T.
1660:             ENDWITH
1661: 
1662:             WITH .Buttons(2)
1663:                 .Caption   = "N" + CHR(227) + "o"
1664:                 .FontName  = "Tahoma"
1665:                 .FontSize  = 8
1666:                 .BackStyle = 0
1667:                 .ForeColor = RGB(90, 90, 90)
1668:                 .Height    = 15
1669:                 .Left      = 56
1670:                 .Top       = 5
1671:                 .Width     = 37
1672:                 .AutoSize  = .T.
1673:             ENDWITH
1674: 
1675:             .Visible = .T.
1676:         ENDWITH
1677: 
1678:         *-- Rotulo "Imprime Iniciais em Maiusculo :" (Say7: top=457, left=516)

*-- Linhas 1690 a 1734:
1690:             .Visible   = .T.
1691:         ENDWITH
1692: 
1693:         *-- OptionGroup Maiusculo/Proper (OptProper: top=452, left=669, Value=2=Nao)
1694:         loc_oPagina.AddObject("obj_4c_OptProper", "OptionGroup")
1695:         WITH loc_oPagina.obj_4c_OptProper
1696:             .Top           = 370
1697:             .Left          = 669
1698:             .Width         = 104
1699:             .Height        = 26
1700:             .ButtonCount   = 2
1701:             .BackStyle     = 0
1702:             .BorderStyle   = 0
1703:             .SpecialEffect = 0
1704:             .Value         = 2
1705: 
1706:             WITH .Buttons(1)
1707:                 .Caption   = "Sim"
1708:                 .BackStyle = 0
1709:                 .ForeColor = RGB(90, 90, 90)
1710:                 .Height    = 15
1711:                 .Left      = 5
1712:                 .Top       = 5
1713:                 .Width     = 34
1714:                 .AutoSize  = .T.
1715:             ENDWITH
1716: 
1717:             WITH .Buttons(2)
1718:                 .Caption   = "N" + CHR(227) + "o"
1719:                 .Value     = 1
1720:                 .FontName  = "Tahoma"
1721:                 .FontSize  = 8
1722:                 .BackStyle = 0
1723:                 .ForeColor = RGB(90, 90, 90)
1724:                 .Height    = 15
1725:                 .Left      = 56
1726:                 .Top       = 5
1727:                 .Width     = 37
1728:                 .AutoSize  = .T.
1729:             ENDWITH
1730: 
1731:             .Visible = .T.
1732:         ENDWITH
1733: 
1734:         *-- Rotulo "Usar Nome de Contato se Preenchido :" (Say9: top=476, left=476)

*-- Linhas 1746 a 1838:
1746:             .Visible   = .T.
1747:         ENDWITH
1748: 
1749:         *-- OptionGroup Usar Contato (OptContatos: top=471, left=669, Value=2=Nao)
1750:         loc_oPagina.AddObject("obj_4c_OptContatos", "OptionGroup")
1751:         WITH loc_oPagina.obj_4c_OptContatos
1752:             .Top           = 389
1753:             .Left          = 669
1754:             .Width         = 104
1755:             .Height        = 26
1756:             .ButtonCount   = 2
1757:             .BackStyle     = 0
1758:             .BorderStyle   = 0
1759:             .SpecialEffect = 0
1760:             .Value         = 2
1761: 
1762:             WITH .Buttons(1)
1763:                 .Caption   = "Sim"
1764:                 .BackStyle = 0
1765:                 .ForeColor = RGB(90, 90, 90)
1766:                 .Height    = 15
1767:                 .Left      = 5
1768:                 .Top       = 5
1769:                 .Width     = 34
1770:                 .AutoSize  = .T.
1771:             ENDWITH
1772: 
1773:             WITH .Buttons(2)
1774:                 .Caption   = "N" + CHR(227) + "o"
1775:                 .Value     = 1
1776:                 .FontName  = "Tahoma"
1777:                 .FontSize  = 8
1778:                 .BackStyle = 0
1779:                 .ForeColor = RGB(90, 90, 90)
1780:                 .Height    = 15
1781:                 .Left      = 56
1782:                 .Top       = 5
1783:                 .Width     = 37
1784:                 .AutoSize  = .T.
1785:             ENDWITH
1786: 
1787:             .Visible = .T.
1788:         ENDWITH
1789:     ENDPROC
1790: 
1791:     *--------------------------------------------------------------------------
1792:     * CarregarImpressoras - Carrega impressoras termicas autorizadas para o usuario
1793:     *   1. Consulta SigCdPam/SigCdPac para parametros de impressao termica
1794:     *   2. APRINTERS() lista todas as impressoras Windows instaladas
1795:     *   3. SQLEXEC filtra impressoras termicas (SigSyImp+SigCdmp, nTpImpres=2)
1796:     *   4. Expande ButtonCount de obj_4c_Opt_Impressora com impressoras encontradas
1797:     *--------------------------------------------------------------------------
1798:     PROCEDURE CarregarImpressoras()
1799:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nMaxImpEti
1800:         LOCAL loc_nPrinters, loc_nI, loc_nCnt, loc_nImp, loc_nOk, loc_lcI
1801:         LOCAL loc_nTop, loc_nHeight, loc_oPg1, loc_oOptImp
1802:         DIMENSION loc_laPrinters(10, 2)
1803:         DIMENSION loc_laImpOk(1)
1804:         loc_lSucesso  = .F.
1805:         loc_nMaxImpEti = 5
1806: 
1807:         TRY
1808:             *-- Parametros de impressao termica: SigCdPam
1809:             loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "cursor_4c_SigCdPam")
1810:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigCdPam")
1811:                 SELECT cursor_4c_SigCdPam
1812:                 GO TOP
1813:                 THIS.this_nTpImp   = IIF(cursor_4c_SigCdPam.ImpEtis <> 0, cursor_4c_SigCdPam.ImpEtis, 1)
1814:                 THIS.this_nAjVerts = cursor_4c_SigCdPam.AjVerts
1815:                 THIS.this_nAjHorzs = cursor_4c_SigCdPam.AjHorzs
1816:                 loc_nMaxImpEti     = IIF(cursor_4c_SigCdPam.nMaxImpEti > 5, cursor_4c_SigCdPam.nMaxImpEti, 5)
1817:             ENDIF
1818:             IF USED("cursor_4c_SigCdPam")
1819:                 USE IN cursor_4c_SigCdPam
1820:             ENDIF
1821: 
1822:             *-- Ajustes de impressora: SigCdPac
1823:             loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "cursor_4c_SigCdPac")
1824:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigCdPac")
1825:                 SELECT cursor_4c_SigCdPac
1826:                 GO TOP
1827:                 THIS.this_nAjDenss = IIF(cursor_4c_SigCdPac.AjDens < 10, 10, cursor_4c_SigCdPac.AjDens)
1828:                 THIS.this_nAjVelos = IIF(cursor_4c_SigCdPac.AjVelos < 1, 1, cursor_4c_SigCdPac.AjVelos)
1829:             ENDIF
1830:             IF USED("cursor_4c_SigCdPac")
1831:                 USE IN cursor_4c_SigCdPac
1832:             ENDIF
1833: 
1834:             *-- Lista de impressoras Windows (APRINTERS retorna array 2D: nome, porta)
1835:             loc_nPrinters = APRINTERS(loc_laPrinters)
1836:             IF loc_nPrinters > 0
1837:                 FOR loc_nI = 1 TO loc_nPrinters
1838:                     loc_laPrinters(loc_nI, 1) = UPPER(loc_laPrinters(loc_nI, 1))

*-- Linhas 1887 a 1930:
1887:                 USE IN cursor_4c_SigCdmp
1888:             ENDIF
1889: 
1890:             *-- Configurar botoes da OptionGroup de impressoras
1891:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1892:             IF !PEMSTATUS(loc_oPg1, "obj_4c_Opt_Impressora", 5)
1893:                 RETURN
1894:             ENDIF
1895:             loc_oOptImp = loc_oPg1.obj_4c_Opt_Impressora
1896:             loc_nTop    = 10
1897:             loc_nHeight = 15
1898: 
1899:             IF loc_nImp > 0
1900:                 loc_oOptImp.ButtonCount = MIN(loc_nImp, loc_nMaxImpEti)
1901:                 FOR loc_nI = 1 TO loc_oOptImp.ButtonCount
1902:                     loc_lcI = ALLTRIM(STR(loc_nI))
1903:                     WITH loc_oOptImp.Buttons(loc_nI)
1904:                         .AutoSize  = .F.
1905:                         .Caption   = " \<" + loc_lcI + ". " + loc_laImpOk(loc_nI)
1906:                         .FontSize  = 8
1907:                         .ForeColor = RGB(36, 84, 155)
1908:                         .Tag       = UPPER(loc_laImpOk(loc_nI))
1909:                         .Top       = loc_nTop
1910:                         .Width     = 210
1911:                         .BackStyle = 0
1912:                     ENDWITH
1913:                     loc_nTop    = loc_nTop + 20
1914:                     loc_nHeight = loc_nHeight + 20
1915:                 ENDFOR
1916:             ELSE
1917:                 loc_oOptImp.ButtonCount = 1
1918:                 loc_nOk = ASCAN(loc_laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
1919:                 WITH loc_oOptImp.Buttons(1)
1920:                     .AutoSize  = .F.
1921:                     .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
1922:                     .Enabled   = (loc_nOk <> 0)
1923:                     .FontSize  = 8
1924:                     .ForeColor = RGB(36, 84, 155)
1925:                     .Tag       = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
1926:                     .Width     = 210
1927:                 ENDWITH
1928:                 loc_nHeight = loc_nHeight + 20
1929:                 loc_nImp    = IIF(loc_oOptImp.Buttons(1).Enabled, 1, 0)
1930:             ENDIF

*-- Linhas 1941 a 2057:
1941:     *--------------------------------------------------------------------------
1942:     * FormParaRelatorio - Transfere valores dos controles do form para o BO
1943:     *--------------------------------------------------------------------------
1944:     PROTECTED PROCEDURE FormParaRelatorio()
1945:         LOCAL loc_oPg1, loc_nImpres
1946:         IF VARTYPE(THIS.this_oRelatorio) <> "O"
1947:             RETURN
1948:         ENDIF
1949:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1950:         WITH THIS.this_oRelatorio
1951:             IF PEMSTATUS(loc_oPg1, "txt_4c_Codigo", 5)
1952:                 .this_cCodigos    = ALLTRIM(loc_oPg1.txt_4c_Codigo.Value)
1953:                 .this_cDescs      = ALLTRIM(loc_oPg1.txt_4c_Desc.Value)
1954:                 .this_cNmOperacao = ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value)
1955:                 .this_dDtInicial  = loc_oPg1.txt_4c__dt_inicial.Value
1956:                 .this_dDtFinal    = loc_oPg1.txt_4c__dt_final.Value
1957:                 .this_nQtdEtiq    = loc_oPg1.obj_4c_Spn_qtdetiq.Value
1958:                 .this_nConta      = loc_oPg1.obj_4c_Opt_conta.Value
1959:             ENDIF
1960:             IF PEMSTATUS(loc_oPg1, "obj_4c_Option", 5)
1961:                 .this_nOrdem       = loc_oPg1.obj_4c_Option.Value
1962:                 .this_nOrdemDir    = loc_oPg1.obj_4c_OpOrdem.Value
1963:                 .this_nColunas     = loc_oPg1.obj_4c_OpColunas.Value
1964:                 .this_nImpPais     = loc_oPg1.obj_4c_OptPais.Value
1965:                 .this_nImpCodigo   = loc_oPg1.obj_4c_OptCodigo.Value
1966:                 .this_nImpMaius    = loc_oPg1.obj_4c_OptProper.Value
1967:                 .this_nImpContatos = loc_oPg1.obj_4c_OptContatos.Value
1968:                 .this_nImpressora  = loc_oPg1.obj_4c_Opt_Impressora.Value
1969:                 loc_nImpres = loc_oPg1.obj_4c_Opt_Impressora.Value
1970:                 IF loc_nImpres >= 1
1971:                     .this_cNomeImpressora = ALLTRIM(loc_oPg1.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
1972:                 ELSE
1973:                     .this_cNomeImpressora = ""
1974:                 ENDIF
1975:             ENDIF
1976:         ENDWITH
1977:     ENDPROC
1978: 
1979:     *--------------------------------------------------------------------------
1980:     * Processamento - Constroi cursor Relacao e CsCabecalho para impressao
1981:     *   Modo Mala Direta (nm_operacao vazio): SigMlCab+SigCdCli via BO
1982:     *   Modo Operacao (cursor_4c_Operacoes): SELECT marcados com copias UNION ALL
1983:     *   Aplica optContatos, optProper e INDEX ON para ordenacao
1984:     *--------------------------------------------------------------------------
1985:     PROCEDURE Processamento()
1986:         LOCAL loc_lSucesso, loc_oPg1, loc_lModoOp, loc_nQtd, loc_nX
1987:         LOCAL loc_nOrdem, loc_nOrdemDir, loc_nContatos, loc_nProper, loc_cQuery
1988:         loc_lSucesso = .F.
1989:         TRY
1990:             THIS.FormParaRelatorio()
1991:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1992: 
1993:             *-- Cursor CsCabecalho: flags de impressao usados pelos arquivos LBX
1994:             IF USED("CsCabecalho")
1995:                 USE IN CsCabecalho
1996:             ENDIF
1997:             CREATE CURSOR CsCabecalho (llImpPais L, llImpCodigos L)
1998:             APPEND BLANK
1999:             REPLACE llImpPais WITH ;
2000:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptPais", 5) AND loc_oPg1.obj_4c_OptPais.Value = 1, .T., .F.) ;
2001:                 IN CsCabecalho
2002:             REPLACE llImpCodigos WITH ;
2003:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptCodigo", 5) AND loc_oPg1.obj_4c_OptCodigo.Value = 1, .T., .T.) ;
2004:                 IN CsCabecalho
2005: 
2006:             loc_nContatos = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptContatos", 5), loc_oPg1.obj_4c_OptContatos.Value, 2)
2007:             loc_nProper   = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptProper", 5),   loc_oPg1.obj_4c_OptProper.Value,   2)
2008:             loc_nOrdem    = IIF(PEMSTATUS(loc_oPg1, "obj_4c_Option", 5),      loc_oPg1.obj_4c_Option.Value,      2)
2009:             loc_nOrdemDir = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OpOrdem", 5),     loc_oPg1.obj_4c_OpOrdem.Value,     2)
2010:             loc_lModoOp   = PEMSTATUS(loc_oPg1, "txt_4c__nm_operacao", 5) AND ;
2011:                             !EMPTY(ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value))
2012: 
2013:             IF loc_lModoOp
2014:                 IF !USED("cursor_4c_Operacoes") OR FCOUNT("cursor_4c_Operacoes") <= 8
2015:                     MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o carregada. " + ;
2016:                              "Informe o per" + CHR(237) + "odo e pressione Enter.", ;
2017:                              "Impress" + CHR(227) + "o")
2018:                 ELSE
2019:                     loc_nQtd = IIF(PEMSTATUS(loc_oPg1, "obj_4c_Spn_qtdetiq", 5), ;
2020:                                   loc_oPg1.obj_4c_Spn_qtdetiq.Value, 1)
2021:                     IF USED("Relacao")
2022:                         USE IN Relacao
2023:                     ENDIF
2024:                     IF loc_nQtd <= 1
2025:                         SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, ;
2026:                                Ceps, Estas, Tel1s, Tel2s, Faxs, Nascs, cIdChaves, ;
2027:                                Codigos, paises, Contato ;
2028:                                FROM cursor_4c_Operacoes WHERE Marcas = 1 ;
2029:                                INTO CURSOR Relacao READWRITE
2030:                     ELSE
2031:                         *-- Multiplas copias via UNION ALL (replica logica original com ExecScript)
2032:                         loc_cQuery = ""
2033:                         FOR loc_nX = 1 TO loc_nQtd
2034:                             IF !EMPTY(loc_cQuery)
2035:                                 loc_cQuery = loc_cQuery + CHR(13) + CHR(10) + ;
2036:                                              "UNION ALL" + CHR(13) + CHR(10)
2037:                             ENDIF
2038:                             loc_cQuery = loc_cQuery + ;
2039:                                 "SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas," + ;
2040:                                 " Ceps, Estas, Tel1s, Tel2s, Faxs, Nascs, cIdChaves," + ;
2041:                                 " Codigos, paises, Contato" + ;
2042:                                 " FROM cursor_4c_Operacoes n" + ALLTRIM(STR(loc_nX)) + ;
2043:                                 " WHERE Marcas = 1"
2044:                         ENDFOR
2045:                         loc_cQuery = loc_cQuery + " INTO CURSOR Relacao READWRITE"
2046:                         EXECSCRIPT(loc_cQuery)
2047:                     ENDIF
2048:                     loc_lSucesso = .T.
2049:                 ENDIF
2050:             ELSE
2051:                 IF THIS.this_oRelatorio.PrepararDadosMalaDireta()
2052:                     loc_lSucesso = .T.
2053:                 ELSE
2054:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro ao carregar dados")
2055:                 ENDIF
2056:             ENDIF
2057: 

*-- Linhas 2102 a 2434:
2102:     * ImprimirTermica - Impressao em impressora termica modelo 45 (SigOpEtq)
2103:     *   Cria DbImpressao a partir de Relacao (SPACE(60) como Obs, copiado de IClis)
2104:     *--------------------------------------------------------------------------
2105:     PROCEDURE ImprimirTermica()
2106:         LOCAL loc_lSucesso, loc_lcNomeImp, loc_oPg1, loc_nImpres
2107:         loc_lSucesso = .F.
2108:         TRY
2109:             IF THIS.Processamento() AND THIS.this_oRelatorio.PrepararDbImpressao()
2110:                 loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2111:                 loc_lcNomeImp = ""
2112:                 IF PEMSTATUS(loc_oPg1, "obj_4c_Opt_Impressora", 5)
2113:                     loc_nImpres = loc_oPg1.obj_4c_Opt_Impressora.Value
2114:                     IF loc_nImpres >= 1
2115:                         loc_lcNomeImp = ALLTRIM(loc_oPg1.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
2116:                     ENDIF
2117:                 ENDIF
2118:                 TRY
2119:                     =SigOpEtq(.F., .F., .F., 45, THIS.this_nTpImp, THIS.this_nAjVerts, ;
2120:                              THIS.this_nAjHorzs, THIS.this_nAjDenss, .F., .F., .F., ;
2121:                              loc_lcNomeImp, , , THIS.this_nAjVelos, .F., .F.)
2122:                 CATCH TO loc_oEtq
2123:                     MsgErro(loc_oEtq.Message, "SigOpEtq n" + CHR(227) + "o dispon" + CHR(237) + "vel")
2124:                 ENDTRY
2125:                 MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", ;
2126:                     "T" + CHR(233) + "rmica")
2127:                 loc_lSucesso = .T.
2128:             ENDIF
2129:         CATCH TO loc_oErro
2130:             MsgErro(loc_oErro.Message, "Erro ImprimirTermica")
2131:         ENDTRY
2132:         RETURN loc_lSucesso
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * ImprimirTermicaZ - Impressao em impressora termica modelo 96 (SigOpEtq)
2137:     *   DbImpressao usa SPACE(10) para Obs (replica imptermicaz do original)
2138:     *--------------------------------------------------------------------------
2139:     PROCEDURE ImprimirTermicaZ()
2140:         LOCAL loc_lSucesso, loc_lcNomeImp, loc_oPg1, loc_nImpres
2141:         loc_lSucesso = .F.
2142:         TRY
2143:             IF THIS.Processamento()
2144:                 IF USED("DbImpressao")
2145:                     USE IN DbImpressao
2146:                 ENDIF
2147:                 IF USED("Relacao") AND RECCOUNT("Relacao") > 0
2148:                     SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, SPACE(10) AS Obs ;
2149:                         FROM Relacao INTO CURSOR DbImpressao READWRITE
2150:                     SELECT DbImpressao
2151:                     GO TOP
2152:                     REPLACE ALL Obs WITH IClis IN DbImpressao
2153: 
2154:                     loc_oPg1      = THIS.pgf_4c_Paginas.Page1
2155:                     loc_lcNomeImp = ""
2156:                     IF PEMSTATUS(loc_oPg1, "obj_4c_Opt_Impressora", 5)
2157:                         loc_nImpres = loc_oPg1.obj_4c_Opt_Impressora.Value
2158:                         IF loc_nImpres >= 1
2159:                             loc_lcNomeImp = ALLTRIM(loc_oPg1.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
2160:                         ENDIF
2161:                     ENDIF
2162:                     TRY
2163:                         =SigOpEtq(.F., .F., .F., 96, THIS.this_nTpImp, THIS.this_nAjVerts, ;
2164:                                  THIS.this_nAjHorzs, THIS.this_nAjDenss, .F., .F., .F., ;
2165:                                  loc_lcNomeImp, , , THIS.this_nAjVelos, .F., .F.)
2166:                     CATCH TO loc_oEtq
2167:                         MsgErro(loc_oEtq.Message, "SigOpEtq n" + CHR(227) + "o dispon" + CHR(237) + "vel")
2168:                     ENDTRY
2169:                     MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", ;
2170:                         "T" + CHR(233) + "rmica Z")
2171:                     loc_lSucesso = .T.
2172:                 ELSE
2173:                     MsgAviso("Nenhum registro para imprimir.", ;
2174:                         "T" + CHR(233) + "rmica Z")
2175:                 ENDIF
2176:             ENDIF
2177:         CATCH TO loc_oErro
2178:             MsgErro(loc_oErro.Message, "Erro ImprimirTermicaZ")
2179:         ENDTRY
2180:         RETURN loc_lSucesso
2181:     ENDPROC
2182: 
2183:     *--------------------------------------------------------------------------
2184:     * BtnVisualizarClick - Processamento + LABEL FORM PREVIEW (ou Termica)
2185:     *--------------------------------------------------------------------------
2186:     PROCEDURE BtnVisualizarClick()
2187:         LOCAL loc_oPg1, loc_nColunas, loc_lOk
2188:         loc_lOk = .F.
2189:         TRY
2190:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
2191:             loc_nColunas = 2
2192:             IF PEMSTATUS(loc_oPg1, "obj_4c_OpColunas", 5)
2193:                 loc_nColunas = loc_oPg1.obj_4c_OpColunas.Value
2194:             ENDIF
2195: 
2196:             IF loc_nColunas = 7
2197:                 THIS.ImprimirTermica()
2198:                 loc_lOk = .T.
2199:             ELSE
2200:                 IF loc_nColunas = 9
2201:                 THIS.ImprimirTermicaZ()
2202:                 loc_lOk = .T.
2203:             ELSE
2204:                 IF THIS.Processamento() AND USED("Relacao") AND RECCOUNT("Relacao") > 0
2205:                 DO CASE
2206:                     CASE loc_nColunas = 1
2207:                         LABEL FORM SigMldDn PREVIEW NOCONSOLE
2208:                     CASE loc_nColunas = 2
2209:                         LABEL FORM SigMld2 PREVIEW NOCONSOLE
2210:                     CASE loc_nColunas = 3
2211:                         LABEL FORM SigMld3 PREVIEW NOCONSOLE
2212:                     CASE loc_nColunas = 4
2213:                         LABEL FORM SigMld4 PREVIEW NOCONSOLE
2214:                     CASE loc_nColunas = 5
2215:                         LABEL FORM SigMld5 PREVIEW NOCONSOLE
2216:                     CASE loc_nColunas = 6
2217:                         LABEL FORM SigMld2C PREVIEW NOCONSOLE
2218:                     CASE loc_nColunas = 8
2219:                         LABEL FORM SigMld2K PREVIEW NOCONSOLE
2220:                 ENDCASE
2221:                 loc_lOk = .T.
2222:             ELSE
2223:                 MsgAviso("Nenhum registro encontrado para visualizar.", "Visualizar")
2224:                 ENDIF
2225:                 ENDIF
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             MsgErro(loc_oErro.Message, "Erro Visualizar")
2229:         ENDTRY
2230:     ENDPROC
2231: 
2232:     *--------------------------------------------------------------------------
2233:     * BtnImprimirClick - Processamento + LABEL FORM TO PRINTER PROMPT
2234:     *--------------------------------------------------------------------------
2235:     PROCEDURE BtnImprimirClick()
2236:         LOCAL loc_oPg1, loc_nColunas, loc_lOk
2237:         loc_lOk = .F.
2238:         TRY
2239:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
2240:             loc_nColunas = 2
2241:             IF PEMSTATUS(loc_oPg1, "obj_4c_OpColunas", 5)
2242:                 loc_nColunas = loc_oPg1.obj_4c_OpColunas.Value
2243:             ENDIF
2244: 
2245:             IF loc_nColunas = 7
2246:                 THIS.ImprimirTermica()
2247:                 loc_lOk = .T.
2248:             ELSE
2249:                 IF loc_nColunas = 9
2250:                 THIS.ImprimirTermicaZ()
2251:                 loc_lOk = .T.
2252:             ELSE
2253:                 IF THIS.Processamento() AND USED("Relacao") AND RECCOUNT("Relacao") > 0
2254:                 DO CASE
2255:                     CASE loc_nColunas = 1
2256:                         LABEL FORM SigMldDn TO PRINTER PROMPT NOCONSOLE
2257:                     CASE loc_nColunas = 2
2258:                         LABEL FORM SigMld2 TO PRINTER PROMPT NOCONSOLE
2259:                     CASE loc_nColunas = 3
2260:                         LABEL FORM SigMld3 TO PRINTER PROMPT NOCONSOLE
2261:                     CASE loc_nColunas = 4
2262:                         LABEL FORM SigMld4 TO PRINTER PROMPT NOCONSOLE
2263:                     CASE loc_nColunas = 5
2264:                         LABEL FORM SigMld5 TO PRINTER PROMPT NOCONSOLE
2265:                     CASE loc_nColunas = 6
2266:                         LABEL FORM SigMld2C TO PRINTER PROMPT NOCONSOLE
2267:                     CASE loc_nColunas = 8
2268:                         LABEL FORM SigMld2K TO PRINTER PROMPT NOCONSOLE
2269:                 ENDCASE
2270:                 loc_lOk = .T.
2271:             ELSE
2272:                 MsgAviso("Nenhum registro encontrado para imprimir.", "Imprimir")
2273:                 ENDIF
2274:                 ENDIF
2275:             ENDIF
2276:         CATCH TO loc_oErro
2277:             MsgErro(loc_oErro.Message, "Erro Imprimir")
2278:         ENDTRY
2279:     ENDPROC
2280: 
2281:     *--------------------------------------------------------------------------
2282:     * BtnImpDiretoClick - Processamento + LABEL FORM TO PRINTER (sem dialogo)
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE BtnImpDiretoClick()
2285:         LOCAL loc_oPg1, loc_nColunas, loc_lOk
2286:         loc_lOk = .F.
2287:         TRY
2288:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
2289:             loc_nColunas = 2
2290:             IF PEMSTATUS(loc_oPg1, "obj_4c_OpColunas", 5)
2291:                 loc_nColunas = loc_oPg1.obj_4c_OpColunas.Value
2292:             ENDIF
2293: 
2294:             IF loc_nColunas = 7
2295:                 THIS.ImprimirTermica()
2296:                 loc_lOk = .T.
2297:             ELSE
2298:                 IF loc_nColunas = 9
2299:                 THIS.ImprimirTermicaZ()
2300:                 loc_lOk = .T.
2301:             ELSE
2302:                 IF THIS.Processamento() AND USED("Relacao") AND RECCOUNT("Relacao") > 0
2303:                 DO CASE
2304:                     CASE loc_nColunas = 1
2305:                         LABEL FORM SigMldDn TO PRINTER NOCONSOLE
2306:                     CASE loc_nColunas = 2
2307:                         LABEL FORM SigMld2 TO PRINTER NOCONSOLE
2308:                     CASE loc_nColunas = 3
2309:                         LABEL FORM SigMld3 TO PRINTER NOCONSOLE
2310:                     CASE loc_nColunas = 4
2311:                         LABEL FORM SigMld4 TO PRINTER NOCONSOLE
2312:                     CASE loc_nColunas = 5
2313:                         LABEL FORM SigMld5 TO PRINTER NOCONSOLE
2314:                     CASE loc_nColunas = 6
2315:                         LABEL FORM SigMld2C TO PRINTER NOCONSOLE
2316:                     CASE loc_nColunas = 8
2317:                         LABEL FORM SigMld2K TO PRINTER NOCONSOLE
2318:                 ENDCASE
2319:                 loc_lOk = .T.
2320:             ELSE
2321:                 MsgAviso("Nenhum registro encontrado para imprimir.", "Imprimir Direto")
2322:                 ENDIF
2323:                 ENDIF
2324:             ENDIF
2325:         CATCH TO loc_oErro
2326:             MsgErro(loc_oErro.Message, "Erro ImpDireto")
2327:         ENDTRY
2328:     ENDPROC
2329: 
2330:     *--------------------------------------------------------------------------
2331:     * BtnEncerrarClick - Fecha o formulario
2332:     *--------------------------------------------------------------------------
2333:     PROCEDURE BtnEncerrarClick()
2334:         THIS.Release()
2335:     ENDPROC
2336: 
2337:     *--------------------------------------------------------------------------
2338:     * BtnIncluirClick - Alterna para pagina de parametros/filtros
2339:     *   Em form REPORT, "Incluir" navega para a aba de parametros para o
2340:     *   usuario configurar os filtros antes de gerar o relatorio.
2341:     *--------------------------------------------------------------------------
2342:     PROCEDURE BtnIncluirClick()
2343:         TRY
2344:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND THIS.pgf_4c_Paginas.PageCount >= 2
2345:                 THIS.AlternarPagina(2)
2346:             ELSE
2347:                 THIS.AlternarPagina(1)
2348:             ENDIF
2349:         CATCH TO loc_oErro
2350:             MsgErro(loc_oErro.Message, "Erro BtnIncluir")
2351:         ENDTRY
2352:     ENDPROC
2353: 
2354:     *--------------------------------------------------------------------------
2355:     * BtnAlterarClick - Nao aplicavel a formulario de relatorio
2356:     *   Form REPORT nao possui operacao Alterar - usar Visualizar/Imprimir
2357:     *--------------------------------------------------------------------------
2358:     PROCEDURE BtnAlterarClick()
2359:         RETURN
2360:     ENDPROC
2361: 
2362:     *--------------------------------------------------------------------------
2363:     * BtnExcluirClick - Nao aplicavel a formulario de relatorio
2364:     *   Form REPORT nao possui operacao Excluir - usar Visualizar/Imprimir
2365:     *--------------------------------------------------------------------------
2366:     PROCEDURE BtnExcluirClick()
2367:         RETURN
2368:     ENDPROC
2369: 
2370:     *--------------------------------------------------------------------------
2371:     * BtnBuscarClick - Nao aplicavel a formulario de relatorio
2372:     *   Form REPORT nao possui operacao Buscar separada - usa filtros inline
2373:     *--------------------------------------------------------------------------
2374:     PROCEDURE BtnBuscarClick()
2375:         RETURN
2376:     ENDPROC
2377: 
2378:     *--------------------------------------------------------------------------
2379:     * BtnSalvarClick - Nao aplicavel a formulario de relatorio
2380:     *   Form REPORT nao possui operacao Salvar - dados sao somente leitura
2381:     *--------------------------------------------------------------------------
2382:     PROCEDURE BtnSalvarClick()
2383:         RETURN
2384:     ENDPROC
2385: 
2386:     *--------------------------------------------------------------------------
2387:     * BtnCancelarClick - Limpa os filtros e reinicia o formulario
2388:     *   Em form REPORT, "Cancelar" reinicia todos os filtros para valores padrao
2389:     *--------------------------------------------------------------------------
2390:     PROCEDURE BtnCancelarClick()
2391:         THIS.LimparCampos()
2392:     ENDPROC
2393: 
2394:     *--------------------------------------------------------------------------
2395:     * FormParaBO - Compatibilidade com FormBase; delega para FormParaRelatorio
2396:     *   Form REPORT usa FormParaRelatorio() para transferir filtros ao BO
2397:     *--------------------------------------------------------------------------
2398:     PROTECTED PROCEDURE FormParaBO()
2399:         THIS.FormParaRelatorio()
2400:     ENDPROC
2401: 
2402:     *--------------------------------------------------------------------------
2403:     * BOParaForm - Nao aplicavel a formulario de relatorio
2404:     *   Form REPORT nao carrega dados do BO de volta para o form
2405:     *--------------------------------------------------------------------------
2406:     PROTECTED PROCEDURE BOParaForm()
2407:         RETURN
2408:     ENDPROC
2409: 
2410:     *--------------------------------------------------------------------------
2411:     * HabilitarCampos - Atualiza estado de habilitacao dos controles
2412:     *   Delega para AtualizarEstadoControles que implementa a logica real
2413:     *--------------------------------------------------------------------------
2414:     PROCEDURE HabilitarCampos(par_lHabilitar)
2415:         THIS.AtualizarEstadoControles()
2416:     ENDPROC
2417: 
2418:     *--------------------------------------------------------------------------
2419:     * CarregarLista - Nao aplicavel a formulario de relatorio
2420:     *   Form REPORT nao possui grade de lista - usa filtros + LABEL FORM
2421:     *--------------------------------------------------------------------------
2422:     PROCEDURE CarregarLista()
2423:         RETURN .T.
2424:     ENDPROC
2425: 
2426:     *--------------------------------------------------------------------------
2427:     * AjustarBotoesPorModo - Nao aplicavel a formulario de relatorio
2428:     *   Form REPORT nao possui modos CRUD - botoes sao sempre os mesmos
2429:     *--------------------------------------------------------------------------
2430:     PROCEDURE AjustarBotoesPorModo()
2431:         RETURN
2432:     ENDPROC
2433: 
2434: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreipeBO.prg):
*==============================================================================
* SIGREIPEBO.PRG
* Business Object para Impressao de Etiquetas
* Tabela principal: SigMlCab (mala direta) / SigMvCab (operacoes)
*
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigreipeBO AS RelatorioBase

    *-- Propriedades padrao
    this_cTabela         = "SigMlCab"
    this_cCampoChave     = "cIdChaves"
    this_cCursorDados    = "Relacao"
    this_cMensagemErro   = ""

    *-- Filtro: selecao por codigo/descricao (tabela SigMlItn)
    this_cCodigos        = ""
    this_cDescs          = ""

    *-- Filtro: selecao por operacao de movimento
    this_cNmOperacao     = ""
    this_dDtInicial      = {}
    this_dDtFinal        = {}
    this_nConta          = 2

    *-- Configuracao do modelo de etiqueta
    *-- 1=3col DN, 2=2col, 3=9lin, 4=9x3, 5=A4355, 6=2ColMarg, 7=Termica, 8=Pimaco6181, 9=TermicaZ
    this_nColunas        = 2
    this_nQtdEtiq        = 1

    *-- Configuracao da ordenacao
    *-- this_nOrdem: 1=Alfabetica, 2=CEP, 3=Data Nasc.
    *-- this_nOrdemDir: 1=Ascendente, 2=Descendente
    this_nOrdem          = 2
    this_nOrdemDir       = 2

    *-- Opcoes de conteudo das etiquetas
    *-- 1=Sim, 2=Nao em todos os grupos abaixo
    this_nImpPais        = 2
    this_nImpCodigo      = 1
    this_nImpMaius       = 2
    this_nImpContatos    = 2

    *-- Impressora selecionada (carregada no Form a partir de SigCdmp/SigSyImp)
    this_nImpressora     = 1
    this_cNomeImpressora = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigMlCab"
        THIS.this_cCampoChave  = "cIdChaves"
        THIS.this_cCursorDados = "Relacao"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Despacha para modo mala direta ou modo operacao
    * Modo mala direta: this_cCodigos preenchido -> SigMlCab+SigCdCli
    * Modo operacao:    this_cNmOperacao preenchido -> TmpOper via SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(THIS.this_cNmOperacao)
                loc_lSucesso = THIS.PrepararDadosOperacao()
            ELSE
                loc_lSucesso = THIS.PrepararDadosMalaDireta()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosMalaDireta - Busca registros de SigMlCab filtrando por
    * codigo de itinerario (this_cCodigos) ou descricao (this_cDescs)
    * Replica logica do Init original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosMalaDireta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cOrder, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Iclis = b.Iclis"
            IF !EMPTY(THIS.this_cCodigos)
                loc_cWhere = loc_cWhere + " AND a.Codigos = " + EscaparSQL(THIS.this_cCodigos)
            ENDIF

            loc_cOrder = "a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                         " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                         " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                         " a.cIdChaves, a.Codigos, b.Contato"

            loc_cSQL = "SELECT a.IClis, a.RClis, a.Endes, a.Nums, a.Compls," + ;
                       " a.Bairs, a.Cidas, a.Ceps, a.Estas," + ;
                       " a.Tel1s, a.Tel2s, a.Faxs, a.Nascs," + ;
                       " a.cIdChaves, a.Codigos, b.paises, b.Contato" + ;
                       " FROM SigMlCab a, SigCdCli b" + ;
                       " WHERE " + loc_cWhere + ;
                       " ORDER BY " + loc_cOrder

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados da mala direta"
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosMalaDireta")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosOperacao - Busca movimentos de SigMvCab filtrados por
    * operacao e periodo, populando cursor TmpOper com campos para etiqueta.
    * Replica logica do get_dt_final.Valid original.
    * this_nConta = 1 -> usa dados do cliente ORIGEM (ContaOs)
    * this_nConta = 2 -> usa dados do cliente DESTINO (ContaDs)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDadosOperacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cWhere = "a.Dopes = " + EscaparSQL(THIS.this_cNmOperacao)
            IF !EMPTY(THIS.this_dDtInicial)
                loc_cWhere = loc_cWhere + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF
            IF !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + " AND a.Datas <= " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            IF THIS.this_nConta = 1
                *-- Origem: usa dados de b (SigCdCli ContaOs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " b.IClis, b.RClis, b.Endes, b.Nums, b.Compls," + ;
                           " b.Bairs, b.Cidas, b.Ceps, b.Estas," + ;
                           " b.Tel1s, b.Tel2s, b.Faxs, b.Nascs," + ;
                           " b.cIdChaves, b.Codigos, b.paises, b.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ELSE
                *-- Destino: usa dados de c (SigCdCli ContaDs)
                loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes," + ;
                           " b.Rclis AS DescOrigs, c.Rclis AS DescDests," + ;
                           " a.ContaEs, a.LocalEnts," + ;
                           " c.IClis, c.RClis, c.Endes, c.Nums, c.Compls," + ;
                           " c.Bairs, c.Cidas, c.Ceps, c.Estas," + ;
                           " c.Tel1s, c.Tel2s, c.Faxs, c.Nascs," + ;
                           " c.cIdChaves, c.Codigos, c.paises, c.Contato" + ;
                           " FROM SigMvCab a" + ;
                           " INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis" + ;
                           " INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis" + ;
                           " WHERE " + loc_cWhere
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar operacoes"
                loc_lSucesso = .F.
            ENDIF

            *-- Replica cursor TmpOper para Relacao (formato unificado para impressao)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT TmpOper
            IF !EOF()
                SELECT IClis, RClis, Endes, Nums, Compls, Bairs, Cidas, Ceps, Estas, ;
                       Tel1s, Tel2s, Faxs, Nascs, cIdChaves, Codigos, paises, Contato ;
                       FROM TmpOper WHERE Marcas = 1 ;
                       INTO CURSOR (THIS.this_cCursorDados) READWRITE
            ELSE
                *-- Cursor vazio com estrutura correta
                CREATE CURSOR (THIS.this_cCursorDados) ;
                    (IClis C(15), RClis C(60), Endes C(60), Nums C(10), Compls C(20), ;
                     Bairs C(40), Cidas C(40), Ceps C(9), Estas C(2), ;
                     Tel1s C(20), Tel2s C(20), Faxs C(20), Nascs D, ;
                     cIdChaves C(36), Codigos C(10), paises C(20), Contato C(40))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDadosOperacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Transforma cursor Relacao em DbImpressao pronto
    * para LABEL FORM, adicionando colunas cpros/qtds/cbars e copiando Obs
    * Replica logica do metodo "processamento" original do SIGREIPE
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorDados) OR RECCOUNT(THIS.this_cCursorDados) = 0
                THIS.this_cMensagemErro = "Nenhum registro para imprimir"
                loc_lSucesso = .F.
            ENDIF

            IF USED("DbImpressao")
                USE IN DbImpressao
            ENDIF

            SELECT *, '1' AS cpros, 1 AS qtds, 0 AS cbars, ;
                   SPACE(60) AS Obs ;
                   FROM (THIS.this_cCursorDados) ;
                   INTO CURSOR DbImpressao READWRITE

            SELECT DbImpressao
            GO TOP
            REPLACE ALL Obs WITH IClis

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro PrepararDbImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (cIdChaves) do cursor atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorDados) AND !EOF(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                loc_cChave = ALLTRIM(NVL(cIdChaves, ""))
            ENDIF
        CATCH TO loc_oErro
            loc_cChave = ""
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("TmpOper")
            USE IN TmpOper
        ENDIF
        IF USED("DbImpressao")
            USE IN DbImpressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

