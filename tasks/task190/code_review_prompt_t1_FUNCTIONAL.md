# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BARRAINFO, CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'AlternarPagina' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'AlternarPagina' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container3): Top original=15 vs migrado 'grd_4c_GradeDisp' Top=181 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container3): Left original=3 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=236px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container1): Top original=15 vs migrado 'grd_4c_GradeDisp' Top=181 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page1.Container1): Left original=2 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GradeDisp' (parent: SIGPRGLX.PageDados.Page4): Left original=191 vs migrado 'grd_4c_GradeDisp' Left=239 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPRGLX): Top original=251 vs migrado 'cnt_4c_Aguarde' Top=18 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Aguarde' (parent: SIGPRGLX): Left original=142 vs migrado 'cnt_4c_Aguarde' Left=208 (diff=66px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlx.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3562 linhas total):

*-- Linhas 5 a 224:
5: * Legado: SigPrGlx.SCX
6: *
7: * Fase 3/8: Form - Estrutura Base
8: *   DEFINE CLASS, Init, InicializarForm, ConfigurarPageFrame,
9: *   ConfigurarCabecalho, ConfigurarAguarde, TornarControlesVisiveis, Destroy
10: *==============================================================================
11: 
12: DEFINE CLASS FormSigPrGlx AS FormBase
13: 
14:     *-- Dimensoes e aparencia (PILAR 1: Width=800, Height=600 do legado)
15:     Width        = 800
16:     Height       = 600
17:     AutoCenter   = .T.
18:     TitleBar     = 0
19:     ShowWindow   = 1
20:     WindowType   = 1
21:     ControlBox   = .F.
22:     Closable     = .F.
23:     MaxButton    = .F.
24:     MinButton    = .F.
25:     BorderStyle  = 2
26:     DataSession  = 2
27:     ClipControls = .F.
28:     Themes       = .F.
29:     Caption      = "Previa da Globalizacao"
30:     FontName     = "Tahoma"
31:     FontSize     = 8
32: 
33:     *-- Referencias e estado operacional
34:     this_oBusinessObject = .NULL.
35:     this_oParentForm     = .NULL.
36: 
37:     *-- Flags de modo de operacao (recebidos via Init do form pai)
38:     this_lReserva    = .F.
39:     this_nEmphPdr    = 0
40:     this_lAutomatico = .F.
41:     this_nNumeroOp   = 0
42:     this_lPorDestino = .F.
43: 
44:     *-- Estado de edicao interativa nas grades (equivalentes a Liberado/OldValue/AntValue do legado)
45:     this_lLiberado   = .F.
46:     this_nOldValue   = 0
47:     this_nAntValue   = 0
48: 
49:     *--------------------------------------------------------------------------
50:     * Init - Recebe parametros do form pai, compartilha datasession e prepara execucao
51:     *--------------------------------------------------------------------------
52:     PROCEDURE Init(par_oParentForm, par_dData, par_lReservaAuto, par_nGerEmphPdr, par_lAutom, par_nNumeroOp, par_lPorDestino)
53: 
54:         *-- Guardar referencia ao form pai
55:         THIS.this_oParentForm = par_oParentForm
56: 
57:         *-- Compartilhar datasession com o form pai para acessar TmpFinalg/TmpFinal/etc.
58:         IF VARTYPE(par_oParentForm) = "O"
59:             THIS.DataSessionId = par_oParentForm.DataSessionId
60:         ENDIF
61: 
62:         *-- Salvar parametros operacionais
63:         THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto) = "L", par_lReservaAuto, .F.)
64:         THIS.this_nEmphPdr    = IIF(VARTYPE(par_nGerEmphPdr)  = "N", par_nGerEmphPdr,  0)
65:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)       = "L", par_lAutom,       .F.)
66:         THIS.this_nNumeroOp   = IIF(VARTYPE(par_nNumeroOp)    = "N", par_nNumeroOp,    0)
67:         THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino)  = "L", par_lPorDestino,  .F.)
68: 
69:         *-- Caption dinamico conforme modo de operacao
70:         THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
71:         IF THIS.this_lReserva
72:             THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
73:         ENDIF
74: 
75:         RETURN DODEFAULT()
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     * InicializarForm - Cria BO e monta estrutura visual base do form
80:     *--------------------------------------------------------------------------
81:     PROTECTED PROCEDURE InicializarForm()
82:         LOCAL loc_lSucesso, loc_oErro
83:         loc_lSucesso = .F.
84: 
85:         TRY
86:             SET DATE TO BRITISH
87:             SET CENTURY ON
88: 
89:             *-- Criar Business Object
90:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlxBO")
91:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
92:                 MsgErro("Falha ao criar SigPrGlxBO.", "Erro")
93:             ELSE
94:                 *-- Repassar flags de modo ao BO
95:                 WITH THIS.this_oBusinessObject
96:                     .this_lReserva    = THIS.this_lReserva
97:                     .this_nEmphPdr    = THIS.this_nEmphPdr
98:                     .this_lAutomatico = THIS.this_lAutomatico
99:                     .this_nNumeroOp   = THIS.this_nNumeroOp
100:                     .this_lPorDestino = THIS.this_lPorDestino
101:                 ENDWITH
102: 
103:                 *-- Montar estrutura visual
104:                 THIS.ConfigurarPageFrame()
105:                 THIS.ConfigurarCabecalho()
106:                 THIS.ConfigurarAguarde()
107:                 THIS.ConfigurarPaginaLista()
108:                 THIS.ConfigurarPaginaDados()
109: 
110:                 *-- Definir caption do cabecalho na Page1 e Page2
111:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
112:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
113:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
114:                     "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
115:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
116:                     "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
117: 
118:                 *-- Ativar PageFrame
119:                 THIS.pgf_4c_Paginas.Visible   = .T.
120:                 THIS.pgf_4c_Paginas.ActivePage = 1
121: 
122:                 THIS.TornarControlesVisiveis(THIS)
123: 
124:                 loc_lSucesso = .T.
125:             ENDIF
126: 
127:         CATCH TO loc_oErro
128:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio FormSigPrGlx: " + ;
129:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
130:                     " Proc:" + loc_oErro.Procedure + "]", "Erro")
131:         ENDTRY
132: 
133:         RETURN loc_lSucesso
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarPageFrame - PageFrame com 6 paginas operacionais
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarPageFrame()
140:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
141:         WITH THIS.pgf_4c_Paginas
142:             .PageCount   = 6
143:             .Top         = -27
144:             .Left        = -1
145:             .Width       = 804
146:             .Height      = 635
147:             .Tabs        = .F.
148:             .BorderWidth = 0
149:             .Themes      = .F.
150: 
151:             .Page1.Caption   = "Dados"
152:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
153:             .Page1.ForeColor = RGB(0,128,192)
154: 
155:             .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es Detalhadas"
156:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
157:             .Page2.ForeColor = RGB(0,128,192)
158: 
159:             .Page3.Caption   = "Totais por Linha"
160:             .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
161:             .Page3.ForeColor = RGB(0,128,192)
162:             .Page3.Enabled   = .F.
163: 
164:             .Page4.Caption   = "Selecionar Estoque"
165:             .Page4.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
166:             .Page4.ForeColor = RGB(0,128,192)
167:             .Page4.Enabled   = .F.
168: 
169:             .Page5.Caption   = "Disponivel/Tamanho"
170:             .Page5.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
171:             .Page5.ForeColor = RGB(0,128,192)
172:             .Page5.Enabled   = .F.
173: 
174:             .Page6.Caption   = "Requisi" + CHR(231) + CHR(227) + "o"
175:             .Page6.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
176:             .Page6.ForeColor = RGB(0,128,192)
177:             .Page6.Enabled   = .F.
178:         ENDWITH
179:     ENDPROC
180: 
181:     *--------------------------------------------------------------------------
182:     * ConfigurarCabecalho - Header escuro na Page1 com titulo do form
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarCabecalho()
185:         LOCAL loc_oPagina
186:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
187: 
188:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
189:         WITH loc_oPagina.cnt_4c_Cabecalho
190:             .Top         = -1
191:             .Left        = 0
192:             .Width       = THIS.Width
193:             .Height      = 80
194:             .BackStyle   = 1
195:             .BackColor   = RGB(100,100,100)
196:             .BorderWidth = 0
197: 
198:             .AddObject("lbl_4c_Sombra", "Label")
199:             WITH .lbl_4c_Sombra
200:                 .AutoSize      = .F.
201:                 .FontBold      = .T.
202:                 .FontName      = "Tahoma"
203:                 .FontSize      = 18
204:                 .FontUnderline = .F.
205:                 .WordWrap      = .T.
206:                 .Alignment     = 0
207:                 .BackStyle     = 0
208:                 .Caption       = ""
209:                 .Height        = 40
210:                 .Left          = 10
211:                 .Top           = 18
212:                 .Width         = THIS.Width
213:                 .ForeColor     = RGB(0,0,0)
214:             ENDWITH
215: 
216:             .AddObject("lbl_4c_Titulo", "Label")
217:             WITH .lbl_4c_Titulo
218:                 .AutoSize      = .F.
219:                 .FontBold      = .T.
220:                 .FontName      = "Tahoma"
221:                 .FontSize      = 18
222:                 .WordWrap      = .T.
223:                 .Alignment     = 0
224:                 .BackStyle     = 0

*-- Linhas 236 a 280:
236:     * ConfigurarAguarde - Container de espera durante processamento
237:     * Fica no form raiz (nao dentro de Page) com Visible=.F.
238:     * Tornado visivel em MostrarAguarde() e oculto em OcultarAguarde()
239:     *--------------------------------------------------------------------------
240:     PROTECTED PROCEDURE ConfigurarAguarde()
241:         THIS.AddObject("cnt_4c_Aguarde", "Container")
242:         WITH THIS.cnt_4c_Aguarde
243:             .Top         = 251
244:             .Left        = 142
245:             .Width       = 516
246:             .Height      = 98
247:             .Visible     = .F.
248:             .BackStyle   = 1
249:             .BackColor   = RGB(255,255,255)
250:             .BorderWidth = 0
251: 
252:             .AddObject("lbl_4c_AguardeMsg", "Label")
253:             WITH .lbl_4c_AguardeMsg
254:                 .AutoSize  = .F.
255:                 .Caption   = "Aguarde..."
256:                 .FontBold  = .T.
257:                 .FontName  = "Tahoma"
258:                 .FontSize  = 12
259:                 .BackStyle = 0
260:                 .Top       = 18
261:                 .Left      = 208
262:                 .Width     = 105
263:                 .Height    = 29
264:             ENDWITH
265: 
266:             .AddObject("lbl_4c_Processando", "Label")
267:             WITH .lbl_4c_Processando
268:                 .AutoSize  = .F.
269:                 .Caption   = "Processando Dados ......"
270:                 .FontBold  = .T.
271:                 .FontName  = "Tahoma"
272:                 .FontSize  = 8
273:                 .BackStyle = 0
274:                 .Top       = 52
275:                 .Left      = 137
276:                 .Width     = 242
277:                 .Height    = 27
278:             ENDWITH
279: 
280:             .AddObject("lbl_4c_Mensagem", "Label")

*-- Linhas 294 a 419:
294: 
295:     *--------------------------------------------------------------------------
296:     * MostrarAguarde - Exibe container de espera com mensagem opcional
297:     *--------------------------------------------------------------------------
298:     PROCEDURE MostrarAguarde(par_cMensagem)
299:         THIS.cnt_4c_Aguarde.lbl_4c_Mensagem.Caption = IIF(VARTYPE(par_cMensagem) = "C", par_cMensagem, "")
300:         THIS.cnt_4c_Aguarde.Visible = .T.
301:         THIS.cnt_4c_Aguarde.ZOrder(0)
302:         THIS.LockScreen = .T.
303:         THIS.LockScreen = .F.
304:         DOEVENTS
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * OcultarAguarde - Oculta container de espera
309:     *--------------------------------------------------------------------------
310:     PROCEDURE OcultarAguarde()
311:         THIS.cnt_4c_Aguarde.Visible = .F.
312:         THIS.LockScreen = .T.
313:         THIS.LockScreen = .F.
314:         DOEVENTS
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     * TornarControlesVisiveis - Torna controles visiveis pos-AddObject
319:     * FILTRO: cnt_4c_Aguarde permanece Visible=.F. (toggleado por MostrarAguarde)
320:     *--------------------------------------------------------------------------
321:     PROCEDURE TornarControlesVisiveis(par_oContainer)
322:         LOCAL loc_i, loc_oControl, loc_p
323: 
324:         FOR loc_i = 1 TO par_oContainer.ControlCount
325:             loc_oControl = par_oContainer.Controls(loc_i)
326: 
327:             IF VARTYPE(loc_oControl) != "O"
328:                 LOOP
329:             ENDIF
330: 
331:             *-- Containers flutuantes: recursao nos filhos mas sem alterar Visible do container
332:             IF UPPER(loc_oControl.Name) = "CNT_4C_AGUARDE"
333:                 THIS.TornarControlesVisiveis(loc_oControl)
334:                 LOOP
335:             ENDIF
336: 
337:             *-- Controles com visibilidade gerenciada por logica operacional
338:             IF INLIST(UPPER(loc_oControl.Name), "BTN_4C_PEDRAS", "BTN_4C_SELESTOQUE", ;
339:                       "BTN_4C_DISPONIVEL", "IMG_4C_FIGJPG", "IMG_4C_FIGOPE")
340:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
341:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
342:                     THIS.TornarControlesVisiveis(loc_oControl)
343:                 ENDIF
344:                 LOOP
345:             ENDIF
346: 
347:             IF PEMSTATUS(loc_oControl, "Visible", 5)
348:                 loc_oControl.Visible = .T.
349:             ENDIF
350: 
351:             *-- Trata PageFrame: itera Pages
352:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
353:                 FOR loc_p = 1 TO loc_oControl.PageCount
354:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
355:                 ENDFOR
356:             ENDIF
357: 
358:             *-- Trata containers/pages com filhos
359:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
360:                 THIS.TornarControlesVisiveis(loc_oControl)
361:             ENDIF
362:         ENDFOR
363:     ENDPROC
364: 
365:     *--------------------------------------------------------------------------
366:     * Destroy - Libera recursos ao fechar
367:     *--------------------------------------------------------------------------
368:     PROCEDURE Destroy()
369:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
370:             THIS.this_oBusinessObject = .NULL.
371:         ENDIF
372:         THIS.this_oParentForm = .NULL.
373:         DODEFAULT()
374:     ENDPROC
375: 
376:     *--------------------------------------------------------------------------
377:     * ConfigurarPaginaLista - Monta controles de todas as Pages operacionais
378:     *--------------------------------------------------------------------------
379:     PROTECTED PROCEDURE ConfigurarPaginaLista()
380:         LOCAL loc_oPag1, loc_oPag2, loc_oPag3, loc_oPag4, loc_oPag5, loc_oPag6
381:         LOCAL loc_oGrade, loc_oErr
382: 
383:         TRY
384:             *-- ===== PAGE 1: Grade principal e controles operacionais =====
385:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
386: 
387:             *-- Shapes decorativos (bordas informativas)
388:             loc_oPag1.AddObject("shp_4c_BoxInfo", "Shape")
389:             WITH loc_oPag1.shp_4c_BoxInfo
390:                 .Top = 12
391:                 .Left = 10
392:                 .Width = 342
393:                 .Height = 110
394:                 .BackStyle = 0
395:             ENDWITH
396: 
397:             loc_oPag1.AddObject("shp_4c_BoxEmpresa", "Shape")
398:             WITH loc_oPag1.shp_4c_BoxEmpresa
399:                 .Top = 9
400:                 .Left = 605
401:                 .Width = 173
402:                 .Height = 38
403:                 .BackStyle = 0
404:             ENDWITH
405: 
406:             *-- Container5 legado: barra de informacoes do produto
407:             loc_oPag1.AddObject("cnt_4c_BarraInfo", "Container")
408:             WITH loc_oPag1.cnt_4c_BarraInfo
409:                 .Top = 129
410:                 .Left = 36
411:                 .Width = 727
412:                 .Height = 40
413:                 .BackStyle = 1
414:                 .BackColor = RGB(220,220,220)
415:                 .BorderWidth = 0
416: 
417:                 .AddObject("lbl_4c_Periodo", "Label")
418:                 WITH .lbl_4c_Periodo
419:                     .AutoSize = .F.

*-- Linhas 686 a 707:
686:                     .FontName = "Tahoma"
687:                     .FontSize = 8
688:                     .FontBold = .T.
689:                 ENDWITH
690: 
691:                 .AddObject("grd_4c_GradeDisp", "Grid")
692:                 WITH .grd_4c_GradeDisp
693:                     .Top = 15
694:                     .Left = 3
695:                     .Width = 358
696:                     .Height = 147
697:                     .ColumnCount = 6
698:                     .ReadOnly = .T.
699:                     .GridLines = 1
700:                     .Themes = .F.
701:                     .FontName = "Tahoma"
702:                     .FontSize = 8
703: 
704:                     WITH .Column1
705:                         .Header1.Caption = "Grupo"
706:                         .ControlSource = "TmpSaldG.Grupos"
707:                         .RecordMark   = .F.

*-- Linhas 989 a 1051:
989:                 .FontSize = 8
990:             ENDWITH
991: 
992:             *-- BINDEVENTs: grade principal e botoes Page1
993:             loc_oGrade = loc_oPag1.grd_4c_GradeItens
994:             BINDEVENT(loc_oGrade,               "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
995:             BINDEVENT(loc_oGrade.Column3.Text1,  "Click",            THIS, "GradeItensCol3Click")
996:             BINDEVENT(loc_oGrade.Column7.Text1,  "GotFocus",         THIS, "GradeItensCol7GotFocus")
997:             BINDEVENT(loc_oGrade.Column7.Text1,  "Valid",            THIS, "GradeItensCol7Valid")
998:             BINDEVENT(loc_oGrade.Column7.Text1,  "KeyPress",       THIS, "GradeItensCol7LostFocus")
999:             BINDEVENT(loc_oGrade.Column8.Text1,  "KeyPress",       THIS, "GradeItensCol8LostFocus")
1000:             BINDEVENT(loc_oGrade.Column10.Text1, "GotFocus",         THIS, "GradeItensCol10GotFocus")
1001:             BINDEVENT(loc_oGrade.Column10.Text1, "Valid",            THIS, "GradeItensCol10Valid")
1002:             BINDEVENT(loc_oGrade.Column10.Text1, "KeyPress",       THIS, "GradeItensCol10LostFocus")
1003: 
1004:             BINDEVENT(loc_oPag1.img_4c_FigJpg,    "Click", THIS, "ImgFigJpgClick")
1005:             BINDEVENT(loc_oPag1.btn_4c_Pedras,     "Click", THIS, "BtnPedrasClick")
1006:             BINDEVENT(loc_oPag1.btn_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
1007:             BINDEVENT(loc_oPag1.btn_4c_Disponivel, "Click", THIS, "BtnDisponivelClick")
1008:             BINDEVENT(loc_oPag1.btn_4c_TotLinha,   "Click", THIS, "BtnTotLinhaClick")
1009:             BINDEVENT(loc_oPag1.btn_4c_Processar,  "Click", THIS, "BtnProcessarClick")
1010:             BINDEVENT(loc_oPag1.btn_4c_Cancelar,   "Click", THIS, "BtnCancelarClick")
1011:             BINDEVENT(loc_oPag1.btn_4c_Alteraqtd,  "Click", THIS, "BtnAlteraqtdClick")
1012: 
1013:             *-- ===== PAGE 2: Operacoes Detalhadas =====
1014:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1015: 
1016:             loc_oPag2.AddObject("lbl_4c_QtdSel", "Label")
1017:             WITH loc_oPag2.lbl_4c_QtdSel
1018:                 .AutoSize = .F.
1019:                 .Caption = "Qtd Selecionada :"
1020:                 .Top = 164
1021:                 .Left = 383
1022:                 .Width = 119
1023:                 .Height = 15
1024:                 .BackStyle = 0
1025:                 .FontName = "Tahoma"
1026:                 .FontSize = 8
1027:             ENDWITH
1028: 
1029:             loc_oPag2.AddObject("txt_4c_TotSEst", "TextBox")
1030:             WITH loc_oPag2.txt_4c_TotSEst
1031:                 .Top = 162
1032:                 .Left = 501
1033:                 .Width = 67
1034:                 .Height = 19
1035:                 .ReadOnly = .T.
1036:                 .Format = "@Z 9999999.999"
1037:                 .FontName = "Tahoma"
1038:                 .FontSize = 8
1039:             ENDWITH
1040: 
1041:             loc_oPag2.AddObject("txt_4c_TotSPrc", "TextBox")
1042:             WITH loc_oPag2.txt_4c_TotSPrc
1043:                 .Top = 162
1044:                 .Left = 567
1045:                 .Width = 67
1046:                 .Height = 19
1047:                 .ReadOnly = .T.
1048:                 .Format = "@Z 9999999.999"
1049:                 .FontName = "Tahoma"
1050:                 .FontSize = 8
1051:             ENDWITH

*-- Linhas 1240 a 1302:
1240:                 .FontName = "Tahoma"
1241:                 .FontSize = 8
1242:             ENDWITH
1243:             BINDEVENT(loc_oPag2.btn_4c_VoltarP2, "Click", THIS, "BtnVoltarPage2Click")
1244: 
1245:             *-- BINDEVENTs: grade de operacoes detalhadas (Page2) - colunas ReadOnly redirecionam foco p/ Col7
1246:             LOCAL loc_oGradeOpe
1247:             loc_oGradeOpe = loc_oPag2.grd_4c_GradeOpe
1248:             BINDEVENT(loc_oGradeOpe,                "AfterRowColChange", THIS, "GradeOpeAfterRowColChange")
1249:             BINDEVENT(loc_oGradeOpe.Column1.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1250:             BINDEVENT(loc_oGradeOpe.Column2.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1251:             BINDEVENT(loc_oGradeOpe.Column3.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1252:             BINDEVENT(loc_oGradeOpe.Column4.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1253:             BINDEVENT(loc_oGradeOpe.Column5.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1254:             BINDEVENT(loc_oGradeOpe.Column6.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1255:             BINDEVENT(loc_oGradeOpe.Column8.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1256:             BINDEVENT(loc_oGradeOpe.Column9.Text1,  "GotFocus", THIS, "GradeOpeColsGotFocus")
1257:             BINDEVENT(loc_oGradeOpe.Column7.Text1,  "GotFocus", THIS, "GradeOpeCol7GotFocus")
1258:             BINDEVENT(loc_oGradeOpe.Column7.Text1,  "Valid",    THIS, "GradeOpeCol7Valid")
1259:             BINDEVENT(loc_oGradeOpe.Column7.Text1,  "KeyPress",THIS, "GradeOpeCol7LostFocus")
1260:             BINDEVENT(loc_oGradeOpe.Column10.Text1, "GotFocus", THIS, "GradeOpeCol10GotFocus")
1261:             BINDEVENT(loc_oGradeOpe.Column10.Text1, "Valid",    THIS, "GradeOpeCol10Valid")
1262:             BINDEVENT(loc_oGradeOpe.Column10.Text1, "KeyPress",THIS, "GradeOpeCol10LostFocus")
1263: 
1264:             *-- ===== PAGE 3: Totais por Linha =====
1265:             loc_oPag3 = THIS.pgf_4c_Paginas.Page3
1266: 
1267:             loc_oPag3.AddObject("lbl_4c_TitLinha", "Label")
1268:             WITH loc_oPag3.lbl_4c_TitLinha
1269:                 .AutoSize = .F.
1270:                 .Caption = "Totais por Linha"
1271:                 .Top = 147
1272:                 .Left = 173
1273:                 .Width = 157
1274:                 .Height = 25
1275:                 .BackStyle = 0
1276:                 .FontName = "Tahoma"
1277:                 .FontSize = 10
1278:                 .FontBold = .T.
1279:             ENDWITH
1280: 
1281:             loc_oPag3.AddObject("grd_4c_GradeLinhas", "Grid")
1282:             WITH loc_oPag3.grd_4c_GradeLinhas
1283:                 .Top = 181
1284:                 .Left = 167
1285:                 .Width = 438
1286:                 .Height = 292
1287:                 .ColumnCount = 5
1288:                 .ReadOnly = .T.
1289:                 .GridLines = 1
1290:                 .Themes = .F.
1291:                 .FontName = "Tahoma"
1292:                 .FontSize = 8
1293: 
1294:                 WITH .Column1
1295:                     .Header1.Caption = "Linha"
1296:                     .ControlSource = "TmpLinha.Linhas"
1297:                     .RecordMark   = .F.
1298:                     .DeleteMark   = .F.
1299:                 ENDWITH
1300:                 WITH .Column2
1301:                     .Header1.Caption = "Quantidade"
1302:                     .ControlSource = "TmpLinha.Saldo"

*-- Linhas 1330 a 1373:
1330:                 .FontName = "Tahoma"
1331:                 .FontSize = 8
1332:             ENDWITH
1333:             BINDEVENT(loc_oPag3.btn_4c_VoltarP3, "Click", THIS, "BtnVoltarPage3Click")
1334: 
1335:             *-- ===== PAGE 4: Selecionar Estoque =====
1336:             loc_oPag4 = THIS.pgf_4c_Paginas.Page4
1337: 
1338:             loc_oPag4.AddObject("lbl_4c_TitSelEst", "Label")
1339:             WITH loc_oPag4.lbl_4c_TitSelEst
1340:                 .AutoSize = .F.
1341:                 .Caption = "Selecionar Estoque"
1342:                 .Top = 138
1343:                 .Left = 197
1344:                 .Width = 184
1345:                 .Height = 25
1346:                 .BackStyle = 0
1347:                 .FontName = "Tahoma"
1348:                 .FontSize = 10
1349:                 .FontBold = .T.
1350:             ENDWITH
1351: 
1352:             loc_oPag4.AddObject("txt_4c_P4CodProd", "TextBox")
1353:             WITH loc_oPag4.txt_4c_P4CodProd
1354:                 .Top = 138
1355:                 .Left = 479
1356:                 .Width = 80
1357:                 .Height = 19
1358:                 .ReadOnly = .T.
1359:                 .FontName = "Tahoma"
1360:                 .FontSize = 8
1361:             ENDWITH
1362: 
1363:             loc_oPag4.AddObject("grd_4c_GradeSelEst", "Grid")
1364:             WITH loc_oPag4.grd_4c_GradeSelEst
1365:                 .Top = 169
1366:                 .Left = 191
1367:                 .Width = 370
1368:                 .Height = 244
1369:                 .ColumnCount = 5
1370:                 .ReadOnly = .F.
1371:                 .GridLines = 1
1372:                 .Themes = .F.
1373:                 .FontName = "Tahoma"

*-- Linhas 1465 a 1517:
1465:                 .FontName = "Tahoma"
1466:                 .FontSize = 8
1467:             ENDWITH
1468:             BINDEVENT(loc_oPag4.btn_4c_VoltarP4, "Click", THIS, "BtnVoltarPage4Click")
1469:             *-- BINDEVENTs: Page4 grade editavel (Column5 Utilizar)
1470:             BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "Valid",     THIS, "GradeSelEstCol5Valid")
1471:             BINDEVENT(loc_oPag4.grd_4c_GradeSelEst.Column5.Text1, "KeyPress", THIS, "GradeSelEstCol5LostFocus")
1472: 
1473:             *-- ===== PAGE 5: Disponivel/Tamanho =====
1474:             loc_oPag5 = THIS.pgf_4c_Paginas.Page5
1475: 
1476:             loc_oPag5.AddObject("lbl_4c_TitDisp", "Label")
1477:             WITH loc_oPag5.lbl_4c_TitDisp
1478:                 .AutoSize = .F.
1479:                 .Caption = "Selecionar Tamanhos"
1480:                 .Top = 150
1481:                 .Left = 246
1482:                 .Width = 205
1483:                 .Height = 25
1484:                 .BackStyle = 0
1485:                 .FontName = "Tahoma"
1486:                 .FontSize = 10
1487:                 .FontBold = .T.
1488:             ENDWITH
1489: 
1490:             loc_oPag5.AddObject("txt_4c_P5CodProd", "TextBox")
1491:             WITH loc_oPag5.txt_4c_P5CodProd
1492:                 .Top = 151
1493:                 .Left = 486
1494:                 .Width = 80
1495:                 .Height = 19
1496:                 .ReadOnly = .T.
1497:                 .FontName = "Tahoma"
1498:                 .FontSize = 8
1499:             ENDWITH
1500: 
1501:             loc_oPag5.AddObject("grd_4c_GradeDisp", "Grid")
1502:             WITH loc_oPag5.grd_4c_GradeDisp
1503:                 .Top = 181
1504:                 .Left = 239
1505:                 .Width = 327
1506:                 .Height = 228
1507:                 .ColumnCount = 5
1508:                 .ReadOnly = .F.
1509:                 .GridLines = 1
1510:                 .Themes = .F.
1511:                 .FontName = "Tahoma"
1512:                 .FontSize = 8
1513: 
1514:                 WITH .Column1
1515:                     .Header1.Caption = "Produto"
1516:                     .ReadOnly = .T.
1517:                     .ControlSource = "TmpDisp.Cpros"

*-- Linhas 1603 a 1658:
1603:                 .FontName = "Tahoma"
1604:                 .FontSize = 8
1605:             ENDWITH
1606:             BINDEVENT(loc_oPag5.btn_4c_VoltarP5, "Click", THIS, "BtnVoltarPage5Click")
1607:             *-- BINDEVENTs: Page5 grade editavel (Cols 1-4 redirecionam foco; Col5 valida)
1608:             BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column1.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
1609:             BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column2.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
1610:             BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column3.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
1611:             BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column4.Text1, "GotFocus", THIS, "GradeDispColsGotFocus")
1612:             BINDEVENT(loc_oPag5.grd_4c_GradeDisp.Column5.Text1, "Valid",    THIS, "GradeDispCol5Valid")
1613: 
1614:             *-- ===== PAGE 6: Requisicoes de Material =====
1615:             loc_oPag6 = THIS.pgf_4c_Paginas.Page6
1616: 
1617:             loc_oPag6.AddObject("lbl_4c_TitReq", "Label")
1618:             WITH loc_oPag6.lbl_4c_TitReq
1619:                 .AutoSize = .F.
1620:                 .Caption = "Requisi"+CHR(231)+CHR(227)+"o Manual de Material"
1621:                 .Top = 168
1622:                 .Left = 132
1623:                 .Width = 294
1624:                 .Height = 25
1625:                 .BackStyle = 0
1626:                 .FontName = "Tahoma"
1627:                 .FontSize = 10
1628:                 .FontBold = .T.
1629:             ENDWITH
1630: 
1631:             loc_oPag6.AddObject("txt_4c_P6CodProd", "TextBox")
1632:             WITH loc_oPag6.txt_4c_P6CodProd
1633:                 .Top = 169
1634:                 .Left = 487
1635:                 .Width = 80
1636:                 .Height = 19
1637:                 .ReadOnly = .T.
1638:                 .FontName = "Tahoma"
1639:                 .FontSize = 8
1640:             ENDWITH
1641: 
1642:             loc_oPag6.AddObject("grd_4c_GradePedra", "Grid")
1643:             WITH loc_oPag6.grd_4c_GradePedra
1644:                 .Top = 197
1645:                 .Left = 119
1646:                 .Width = 500
1647:                 .Height = 261
1648:                 .ColumnCount = 5
1649:                 .ReadOnly = .F.
1650:                 .GridLines = 1
1651:                 .Themes = .F.
1652:                 .FontName = "Tahoma"
1653:                 .FontSize = 8
1654: 
1655:                 WITH .Column1
1656:                     .Header1.Caption = "Produto"
1657:                     .ReadOnly = .F.
1658:                     .ControlSource = "SelPedra.Cpros"

*-- Linhas 1693 a 1759:
1693:                 .FontName = "Tahoma"
1694:                 .FontSize = 8
1695:             ENDWITH
1696:             BINDEVENT(loc_oPag6.btn_4c_VoltarP6, "Click", THIS, "BtnVoltarPage6Click")
1697: 
1698:             *-- BINDEVENTs: Page6 GradePedra - lookup produto e edicao condicional
1699:             BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column1.Text1, "Valid",     THIS, "GradePedraCol1Valid")
1700:             BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column4.Text1, "When",      THIS, "GradePedraCol4When")
1701:             BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "When",      THIS, "GradePedraCol5When")
1702:             BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "Valid",     THIS, "GradePedraCol5Valid")
1703:             BINDEVENT(loc_oPag6.grd_4c_GradePedra.Column5.Text1, "KeyPress", THIS, "GradePedraCol5LostFocus")
1704: 
1705:         CATCH TO loc_oErr
1706:             MsgErro("Erro em ConfigurarPaginaLista: " + loc_oErr.Message + ;
1707:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
1708:                     " Proc:" + loc_oErr.Procedure + "]", "Erro")
1709:         ENDTRY
1710:     ENDPROC
1711: 
1712:     *--------------------------------------------------------------------------
1713:     * ConfigurarPaginaDados - Page2 (Operacoes Detalhadas): cabecalho + primeiros
1714:     * 50% dos campos auxiliares (info do produto selecionado, painel de selecao).
1715:     * Page2 ja possui grid principal e totais (montados em ConfigurarPaginaLista);
1716:     * este metodo COMPLEMENTA com o header cinza padrao do sistema e o painel de
1717:     * informacoes do produto ativo (codigo/descricao/cor/tamanho + qtde do pedido).
1718:     *--------------------------------------------------------------------------
1719:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1720:         LOCAL loc_oPag2, loc_oErr
1721: 
1722:         TRY
1723:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1724: 
1725:             *-- ===== Cabecalho cinza padrao (equivalente ao cntSombra do framework) =====
1726:             loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
1727:             WITH loc_oPag2.cnt_4c_Cabecalho
1728:                 .Top         = -1
1729:                 .Left        = 0
1730:                 .Width       = THIS.Width
1731:                 .Height      = 80
1732:                 .BackStyle   = 1
1733:                 .BackColor   = RGB(100,100,100)
1734:                 .BorderWidth = 0
1735: 
1736:                 .AddObject("lbl_4c_Sombra", "Label")
1737:                 WITH .lbl_4c_Sombra
1738:                     .AutoSize      = .F.
1739:                     .FontBold      = .T.
1740:                     .FontName      = "Tahoma"
1741:                     .FontSize      = 18
1742:                     .FontUnderline = .F.
1743:                     .WordWrap      = .T.
1744:                     .Alignment     = 0
1745:                     .BackStyle     = 0
1746:                     .Caption       = ""
1747:                     .Height        = 40
1748:                     .Left          = 10
1749:                     .Top           = 18
1750:                     .Width         = THIS.Width
1751:                     .ForeColor     = RGB(0,0,0)
1752:                 ENDWITH
1753: 
1754:                 .AddObject("lbl_4c_Titulo", "Label")
1755:                 WITH .lbl_4c_Titulo
1756:                     .AutoSize      = .F.
1757:                     .FontBold      = .T.
1758:                     .FontName      = "Tahoma"
1759:                     .FontSize      = 18

*-- Linhas 1957 a 2062:
1957:         CATCH TO loc_oErr
1958:             MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErr.Message + ;
1959:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
1960:                     " Proc:" + loc_oErr.Procedure + "]", "Erro")
1961:         ENDTRY
1962:     ENDPROC
1963: 
1964:     *--------------------------------------------------------------------------
1965:     * AlternarPagina - Controla navegacao entre as 6 pages operacionais
1966:     *--------------------------------------------------------------------------
1967:     PROCEDURE AlternarPagina(par_nPagina)
1968:         WITH THIS.pgf_4c_Paginas
1969:             .Page1.Enabled = .T.
1970:             .Page2.Enabled = .T.
1971:             .Page3.Enabled = .F.
1972:             .Page4.Enabled = .F.
1973:             .Page5.Enabled = .F.
1974:             .Page6.Enabled = .F.
1975: 
1976:             DO CASE
1977:                 CASE par_nPagina = 1
1978:                     .ActivePage = 1
1979:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
1980:                         THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
1981:                     ENDIF
1982:                 CASE par_nPagina = 2
1983:                     .ActivePage = 2
1984:                 CASE par_nPagina = 3
1985:                     .Page1.Enabled = .F.
1986:                     .Page2.Enabled = .F.
1987:                     .Page3.Enabled = .T.
1988:                     .ActivePage = 3
1989:                 CASE par_nPagina = 4
1990:                     .Page1.Enabled = .F.
1991:                     .Page2.Enabled = .F.
1992:                     .Page4.Enabled = .T.
1993:                     .ActivePage = 4
1994:                 CASE par_nPagina = 5
1995:                     .Page1.Enabled = .F.
1996:                     .Page2.Enabled = .F.
1997:                     .Page5.Enabled = .T.
1998:                     .ActivePage = 5
1999:                 CASE par_nPagina = 6
2000:                     .Page1.Enabled = .F.
2001:                     .Page2.Enabled = .F.
2002:                     .Page6.Enabled = .T.
2003:                     .ActivePage = 6
2004:             ENDCASE
2005:         ENDWITH
2006:     ENDPROC
2007: 
2008:     *--------------------------------------------------------------------------
2009:     * GradeItensAfterRowColChange - Atualiza paineis ao mudar linha na grade
2010:     *--------------------------------------------------------------------------
2011:     PROCEDURE GradeItensAfterRowColChange
2012:         LPARAMETERS par_nColIndex
2013:         LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto
2014: 
2015:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
2016:             RETURN
2017:         ENDIF
2018: 
2019:         *-- Posicionar TmpSaldo na linha atual
2020:         IF USED("TmpSaldo")
2021:             =SEEK(TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams, "TmpSaldo")
2022:         ENDIF
2023: 
2024:         *-- Filtrar TmpSaldG para linha atual
2025:         IF USED("TmpSaldG")
2026:             SELECT TmpSaldG
2027:             SET ORDER TO Cpros
2028:             SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
2029:             GO TOP
2030:         ENDIF
2031: 
2032:         *-- Atualizar Container3 (Estoque Disponivel)
2033:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeDisp
2034:             IF USED("TmpSaldo") AND NOT EOF("TmpSaldo")
2035:                 .txt_4c_DispQtd.Value = TmpSaldo.Saldo
2036:                 .txt_4c_DispEst.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2037:                 .txt_4c_DispPrz.Value = TmpSaldo.Disps
2038:             ELSE
2039:                 .txt_4c_DispQtd.Value = 0
2040:                 .txt_4c_DispEst.Value = 0
2041:                 .txt_4c_DispPrz.Value = 0
2042:             ENDIF
2043:             .lbl_4c_TituloDisp.Caption = "Estoque Dispon"+CHR(237)+"vel " + ;
2044:                 ALLTRIM(TmpFinalg.Cpros) + ;
2045:                 IIF(NOT EMPTY(TmpFinalg.CodCors), " Cor:"+ALLTRIM(TmpFinalg.CodCors), "") + ;
2046:                 IIF(NOT EMPTY(TmpFinalg.CodTams), " Tam:"+ALLTRIM(TmpFinalg.CodTams), "")
2047:             .grd_4c_GradeDisp.Refresh
2048:             .Visible     = .T.
2049:         ENDWITH
2050: 
2051:         *-- Atualizar barra de informacoes (Container5)
2052:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_BarraInfo
2053:             .txt_4c_CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
2054:             .txt_4c_MinProd.Value = TmpFinalg.QtdMins
2055:             .Visible     = .T.
2056:         ENDWITH
2057: 
2058:         *-- Atualizar Container1 (Producao em andamento)
2059:         THIS.pgf_4c_Paginas.Page1.cnt_4c_GradeProd.grd_4c_GradeProd.Refresh
2060: 
2061:         *-- Carregar imagem do produto
2062:         loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;

*-- Linhas 2085 a 2633:
2085:     * GradeItensCol3Click - Click na coluna 3 navega para Page2 (Operacoes)
2086:     * Equivalente ao PageDados.Activate do legado: filtra TmpFinal e inicializa totais
2087:     *--------------------------------------------------------------------------
2088:     PROCEDURE GradeItensCol3Click
2089:         LOCAL loc_oPag2
2090: 
2091:         *-- Filtrar TmpFinal para o produto/cor/tam corrente (SET KEY dinamico)
2092:         IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2093:             SELECT TmpFinal
2094:             SET ORDER TO Cpros
2095:             SET KEY TO TmpFinalg.Cpros + TmpFinalg.CodCors + TmpFinalg.CodTams
2096:             GO TOP
2097:         ENDIF
2098: 
2099:         *-- Inicializar totais da secao "Qtd Selecionada" em Page2
2100:         IF USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2101:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2102:             loc_oPag2.txt_4c_TotSEst.Value = TmpFinalg.Estoque
2103:             loc_oPag2.txt_4c_TotSPrc.Value = TmpFinalg.Fabrs
2104:             THIS.AtualizarTotaisPage2()
2105:         ENDIF
2106: 
2107:         THIS.pgf_4c_Paginas.Page2.Enabled = .T.
2108:         THIS.pgf_4c_Paginas.ActivePage = 2
2109:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
2110:             THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.SetFocus
2111:         ENDIF
2112:     ENDPROC
2113: 
2114:     *--------------------------------------------------------------------------
2115:     * GradeItensCol7GotFocus - Salva valor anterior de Produzir
2116:     *--------------------------------------------------------------------------
2117:     PROCEDURE GradeItensCol7GotFocus
2118:         THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value
2119:     ENDPROC
2120: 
2121:     *--------------------------------------------------------------------------
2122:     * GradeItensCol7Valid - Valida e aplica nova quantidade de Producao
2123:     *--------------------------------------------------------------------------
2124:     PROCEDURE GradeItensCol7Valid
2125:         LOCAL loc_lResultado, loc_nNewVal, loc_nMaxProd, loc_nQtdMin
2126:         loc_lResultado = .T.
2127:         loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value
2128: 
2129:         *-- Garantir registro em TmpSaldU para este produto
2130:         IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2131:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2132:         ENDIF
2133: 
2134:         *-- Checar se produto usa selecao manual de OP
2135:         IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelmp
2136:             IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de OP. "+CHR(13)+ ;
2137:                     "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
2138:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
2139:                 RETURN .F.
2140:             ENDIF
2141:         ENDIF
2142: 
2143:         loc_nMaxProd = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), ;
2144:                            TmpFinalg.Saldo - TmpFinalg.Estoque, 0)
2145:         loc_nQtdMin  = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)
2146: 
2147:         DO CASE
2148:             CASE loc_nNewVal = THIS.this_nOldValue
2149:                 *-- Sem alteracao: aceitar
2150:             CASE loc_nNewVal < 0
2151:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
2152:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
2153:                 loc_lResultado = .F.
2154:             CASE loc_nNewVal > loc_nMaxProd
2155:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade dispon"+CHR(237)+"vel para produ"+CHR(231)+CHR(227)+"o...")
2156:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column7.Text1.Value = THIS.this_nOldValue
2157:                 loc_lResultado = .F.
2158:             OTHERWISE
2159:                 *-- Atualizar TmpFinalg: Produzir, UsuLibs, Produzir2
2160:                 REPLACE Produzir  WITH loc_nNewVal, ;
2161:                         UsuLibs   WITH " ", ;
2162:                         Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNewVal < loc_nQtdMin AND loc_nNewVal > 0, ;
2163:                                          loc_nQtdMin - loc_nNewVal, 0) ;
2164:                 IN TmpFinalg
2165:                 *-- Resetar flag de selecao manual de OP
2166:                 IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
2167:                     REPLACE KeySelmp WITH .F. IN TmpSaldU
2168:                 ENDIF
2169:                 *-- Atualizar disponibilidade em TmpSaldG
2170:                 IF USED("TmpSaldo") AND NOT EOF("TmpSaldo") AND USED("TmpSaldG")
2171:                     LOCAL loc_nDisps
2172:                     loc_nDisps = TmpSaldo.Disps
2173:                     SELECT TmpSaldG
2174:                     SCAN
2175:                         REPLACE Disps WITH loc_nDisps IN TmpSaldG
2176:                     ENDSCAN
2177:                 ENDIF
2178:         ENDCASE
2179: 
2180:         RETURN loc_lResultado
2181:     ENDPROC
2182: 
2183:     *--------------------------------------------------------------------------
2184:     * GradeItensCol7LostFocus - Atualiza totais apos edicao de Producao
2185:     *--------------------------------------------------------------------------
2186:     PROCEDURE GradeItensCol7LostFocus
2187:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2188:         THIS.AtualizarTotaisGrade()
2189:     ENDPROC
2190: 
2191:     *--------------------------------------------------------------------------
2192:     * GradeItensCol8LostFocus - Fecha janela de edicao de Produzir Estq
2193:     *--------------------------------------------------------------------------
2194:     PROCEDURE GradeItensCol8LostFocus
2195:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2196:         THIS.this_lLiberado = .F.
2197:         THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .T.
2198:     ENDPROC
2199: 
2200:     *--------------------------------------------------------------------------
2201:     * GradeItensCol10GotFocus - Salva valor anterior de Estoque e trata Disponivel
2202:     *--------------------------------------------------------------------------
2203:     PROCEDURE GradeItensCol10GotFocus
2204:         LOCAL loc_lcSql
2205:         THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value
2206:         THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .F.
2207: 
2208:         *-- Mostrar botao Disponivel apenas para reserva de produtos tipo 3 ou 4
2209:         IF THIS.this_lReserva AND USED("TmpFinalg") AND NOT EOF("TmpFinalg") AND TmpFinalg.Estoque = 0
2210:             loc_lcSql = [SELECT g.TipoEstos FROM SigCdPro p ] + ;
2211:                         [INNER JOIN SigCdGrp g ON g.CGrus = p.CGrus ] + ;
2212:                         [WHERE p.CPros = ] + EscaparSQL(TmpFinalg.Cpros)
2213:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TipoEsto") >= 1
2214:                 IF INLIST(cursor_4c_TipoEsto.TipoEstos, 3, 4)
2215:                     THIS.pgf_4c_Paginas.Page1.btn_4c_Disponivel.Visible = .T.
2216:                 ENDIF
2217:                 USE IN cursor_4c_TipoEsto
2218:             ENDIF
2219:         ENDIF
2220:     ENDPROC
2221: 
2222:     *--------------------------------------------------------------------------
2223:     * GradeItensCol10Valid - Valida e aplica nova quantidade de Estoque
2224:     *--------------------------------------------------------------------------
2225:     PROCEDURE GradeItensCol10Valid
2226:         LOCAL loc_lResultado, loc_nNewVal, loc_nMaxEst, loc_nDelta, loc_nNovoProd, loc_nQtdMin
2227:         loc_lResultado = .T.
2228:         loc_nNewVal    = THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value
2229: 
2230:         *-- Garantir registro em TmpSaldU para este produto
2231:         IF USED("TmpSaldU") AND NOT SEEK(TmpFinalg.Cpros, "TmpSaldU", "Cpros")
2232:             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2233:         ENDIF
2234: 
2235:         *-- Checar se produto usa selecao manual de estoque
2236:         IF USED("TmpSaldU") AND loc_nNewVal <> THIS.this_nOldValue AND TmpSaldU.KeySelm
2237:             IF NOT MsgConfirma("Produto com Sele"+CHR(231)+CHR(227)+"o Manual de estoque. "+CHR(13)+ ;
2238:                     "O sistema ir"+CHR(225)+" acionar o modo autom"+CHR(225)+"tico. Deseja Continuar?")
2239:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
2240:                 RETURN .F.
2241:             ENDIF
2242:         ENDIF
2243: 
2244:         loc_nMaxEst = IIF(USED("TmpSaldo") AND NOT EOF("TmpSaldo"), TmpSaldo.Disps, 0)
2245:         loc_nQtdMin = IIF(USED("TmpFinalg") AND NOT EOF("TmpFinalg"), TmpFinalg.QtdMins, 0)
2246: 
2247:         DO CASE
2248:             CASE loc_nNewVal = THIS.this_nOldValue
2249:                 *-- Sem alteracao: aceitar
2250:             CASE loc_nNewVal < 0
2251:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
2252:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
2253:                 loc_lResultado = .F.
2254:             CASE loc_nNewVal > loc_nMaxEst
2255:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que o estoque dispon"+CHR(237)+"vel...")
2256:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column10.Text1.Value = THIS.this_nOldValue
2257:                 loc_lResultado = .F.
2258:             OTHERWISE
2259:                 *-- Calcular delta e balancear Estoque x Producao
2260:                 loc_nDelta    = loc_nNewVal - TmpFinalg.Estoque
2261:                 loc_nNovoProd = TmpFinalg.Produzir - loc_nDelta
2262:                 IF loc_nNovoProd < 0
2263:                     loc_nNovoProd = 0
2264:                 ENDIF
2265:                 *-- Atualizar TmpFinalg: Estoque, Produzir, Produzir2
2266:                 REPLACE Estoque   WITH loc_nNewVal, ;
2267:                         Produzir  WITH loc_nNovoProd, ;
2268:                         Produzir2 WITH IIF(loc_nQtdMin > 0 AND loc_nNovoProd < loc_nQtdMin AND loc_nNovoProd > 0, ;
2269:                                          loc_nQtdMin - loc_nNovoProd, 0) ;
2270:                 IN TmpFinalg
2271:                 *-- Resetar flag de selecao manual de estoque
2272:                 IF USED("TmpSaldU") AND NOT EOF("TmpSaldU")
2273:                     REPLACE KeySelm WITH .F. IN TmpSaldU
2274:                 ENDIF
2275:         ENDCASE
2276: 
2277:         RETURN loc_lResultado
2278:     ENDPROC
2279: 
2280:     *--------------------------------------------------------------------------
2281:     * GradeItensCol10LostFocus - Atualiza totais apos edicao de Estoque
2282:     *--------------------------------------------------------------------------
2283:     PROCEDURE GradeItensCol10LostFocus
2284:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2285:         THIS.AtualizarTotaisGrade()
2286:     ENDPROC
2287: 
2288:     *--------------------------------------------------------------------------
2289:     * AtualizarTotaisGrade - Recalcula e exibe totais de TmpFinalg
2290:     *--------------------------------------------------------------------------
2291:     PROTECTED PROCEDURE AtualizarTotaisGrade()
2292:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2293: 
2294:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
2295:             RETURN
2296:         ENDIF
2297: 
2298:         SELECT TmpFinalg
2299:         loc_nRecno = RECNO()
2300:         SUM Saldo, Estoque, Produzir, Fabrs, Produzir2 ;
2301:             TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc, loc_nPrze
2302:         GO loc_nRecno
2303: 
2304:         WITH THIS.pgf_4c_Paginas.Page1
2305:             .txt_4c_TotQtd.Value  = loc_nSal
2306:             .txt_4c_TotEst.Value  = loc_nEst
2307:             .txt_4c_TotPrdc.Value = loc_nPrc
2308:             .txt_4c_TotPrz.Value  = loc_nPrz
2309:             .txt_4c_TotPrze.Value = loc_nPrze
2310:             .txt_4c_TotQtd.Refresh
2311:             .txt_4c_TotEst.Refresh
2312:             .txt_4c_TotPrdc.Refresh
2313:             .txt_4c_TotPrz.Refresh
2314:             .txt_4c_TotPrze.Refresh
2315:         ENDWITH
2316:     ENDPROC
2317: 
2318:     *--------------------------------------------------------------------------
2319:     * ImgFigJpgClick - Exibe/recarrega foto do produto ao clicar na imagem
2320:     *--------------------------------------------------------------------------
2321:     PROCEDURE ImgFigJpgClick
2322:         LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto
2323: 
2324:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
2325:             RETURN
2326:         ENDIF
2327: 
2328:         loc_lcSql = [SELECT a.cpros, a.dpros, a.figjpgs FROM SigCdPro a WHERE a.cpros = ] + ;
2329:                     EscaparSQL(TmpFinalg.Cpros)
2330: 
2331:         IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") >= 1
2332:             WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
2333:                 IF NOT EMPTY(cursor_4c_LocalPro.FigJpgs) AND NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
2334:                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2335:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_LocalPro.FigJpgs, ;
2336:                         "data:image/png;base64,", ""), ;
2337:                         "data:image/jpeg;base64,", ""), ;
2338:                         "data:image/jpg;base64,", ""), 14)
2339:                     =STRTOFILE(loc_lcFoto, loc_lcArquivo)
2340:                     .Picture = loc_lcArquivo
2341:                     .Visible = .T.
2342:                 ELSE
2343:                     MsgAviso("Nenhuma imagem cadastrada para este produto.")
2344:                 ENDIF
2345:             ENDWITH
2346:             USE IN cursor_4c_LocalPro
2347:         ENDIF
2348:     ENDPROC
2349: 
2350:     *--------------------------------------------------------------------------
2351:     * BtnProcessarClick - Delega processamento da globalizacao ao BO
2352:     *--------------------------------------------------------------------------
2353:     PROCEDURE BtnProcessarClick
2354:         LOCAL loc_lSucesso, loc_oErr
2355:         loc_lSucesso = .F.
2356: 
2357:         IF NOT MsgConfirma("Confirma o processamento da Globaliza"+CHR(231)+CHR(227)+"o?")
2358:             RETURN
2359:         ENDIF
2360: 
2361:         THIS.MostrarAguarde("Processando...")
2362: 
2363:         TRY
2364:             loc_lSucesso = THIS.this_oBusinessObject.Processar()
2365:         CATCH TO loc_oErr
2366:             MsgErro("Erro ao processar: " + loc_oErr.Message + ;
2367:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
2368:         ENDTRY
2369: 
2370:         THIS.OcultarAguarde()
2371: 
2372:         IF loc_lSucesso
2373:             MsgInfo("Processamento conclu"+CHR(237)+"do com sucesso!")
2374:             THIS.BtnCancelarClick()
2375:         ENDIF
2376:     ENDPROC
2377: 
2378:     *--------------------------------------------------------------------------
2379:     * BtnTotLinhaClick - Calcula totais por linha e navega para Page3
2380:     *--------------------------------------------------------------------------
2381:     PROCEDURE BtnTotLinhaClick
2382:         IF USED("TmpLinha")
2383:             THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas.RecordSource = ""
2384:             USE IN TmpLinha
2385:         ENDIF
2386: 
2387:         SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, ;
2388:                SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2389:         FROM TmpFinalg GROUP BY 1 ;
2390:         UNION ALL ;
2391:         SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, ;
2392:                SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir, SUM(Fabrs) AS Fabrs ;
2393:         FROM TmpFinalg GROUP BY 1 ;
2394:         INTO CURSOR TmpLinha ORDER BY 2, 1
2395: 
2396:         WITH THIS.pgf_4c_Paginas.Page3.grd_4c_GradeLinhas
2397:             .RecordSource = "TmpLinha"
2398:             .Refresh
2399:         ENDWITH
2400: 
2401:         THIS.AlternarPagina(3)
2402:     ENDPROC
2403: 
2404:     *--------------------------------------------------------------------------
2405:     * BtnCancelarClick - Encerra o form e reativa o form pai
2406:     *--------------------------------------------------------------------------
2407:     PROCEDURE BtnCancelarClick
2408:         IF VARTYPE(THIS.this_oParentForm) = "O"
2409:             THIS.this_oParentForm.Enabled = .T.
2410:         ENDIF
2411:         THIS.Release()
2412:     ENDPROC
2413: 
2414:     *--------------------------------------------------------------------------
2415:     * BtnDisponivelClick - Selecao por disponibilidade de tamanhos (Page5)
2416:     *--------------------------------------------------------------------------
2417:     PROCEDURE BtnDisponivelClick
2418:         LOCAL loc_lcCpro, loc_lcCor
2419: 
2420:         IF TmpFinalg.Estoque <> 0 OR TmpFinalg.Fabrs <> 0
2421:             MsgAviso("Quantidade de Estoque e Produ"+CHR(231)+CHR(227)+"o tem estar Zero antes deste Processo!!!")
2422:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
2423:             RETURN
2424:         ENDIF
2425: 
2426:         loc_lcCpro = TmpFinalg.Cpros
2427:         loc_lcCor  = TmpFinalg.CodCors
2428: 
2429:         IF USED("TmpDisp")
2430:             THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.RecordSource = ""
2431:             USE IN TmpDisp
2432:         ENDIF
2433: 
2434:         SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2435:         FROM TmpSaldo ;
2436:         WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND Disps > 0 ;
2437:         INTO CURSOR Resultado ORDER BY 1, 2, 3
2438: 
2439:         SELECT 0
2440:         USE DBF("Resultado") ALIAS TmpDisp AGAIN
2441:         USE IN Resultado
2442: 
2443:         IF RECCOUNT("TmpDisp") = 0
2444:             MsgAviso("Nenhum tamanho dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
2445:             IF USED("TmpDisp")
2446:                 USE IN TmpDisp
2447:             ENDIF
2448:             RETURN
2449:         ENDIF
2450: 
2451:         WITH THIS.pgf_4c_Paginas.Page5
2452:             .txt_4c_P5CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
2453:                 IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "")
2454:             .txt_4c_P5QtPedida.Value = TmpFinalg.Saldo
2455:             .txt_4c_P5QtSelec.Value  = 0
2456:             .grd_4c_GradeDisp.RecordSource = "TmpDisp"
2457:             .grd_4c_GradeDisp.Refresh
2458:         ENDWITH
2459: 
2460:         THIS.AlternarPagina(5)
2461:     ENDPROC
2462: 
2463:     *--------------------------------------------------------------------------
2464:     * BtnSelEstoqueClick - Selecao de estoque por conta/grupo (Page4)
2465:     *--------------------------------------------------------------------------
2466:     PROCEDURE BtnSelEstoqueClick
2467:         LOCAL loc_lcCpro, loc_lcCor, loc_lcTam
2468: 
2469:         loc_lcCpro = TmpFinalg.Cpros
2470:         loc_lcCor  = TmpFinalg.CodCors
2471:         loc_lcTam  = TmpFinalg.CodTams
2472: 
2473:         IF USED("TmpDisp")
2474:             THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.RecordSource = ""
2475:             USE IN TmpDisp
2476:         ENDIF
2477: 
2478:         SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
2479:         FROM TmpSaldG ;
2480:         WHERE Cpros = loc_lcCpro AND CodCors = loc_lcCor AND CodTams = loc_lcTam AND Disps > 0 ;
2481:         INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
2482: 
2483:         SELECT 0
2484:         USE DBF("Resultado") ALIAS TmpDisp AGAIN
2485:         USE IN Resultado
2486: 
2487:         IF RECCOUNT("TmpDisp") = 0
2488:             MsgAviso("Nenhum estoque dispon"+CHR(237)+"vel para esta refer"+CHR(234)+"ncia.")
2489:             IF USED("TmpDisp")
2490:                 USE IN TmpDisp
2491:             ENDIF
2492:             RETURN
2493:         ENDIF
2494: 
2495:         WITH THIS.pgf_4c_Paginas.Page4
2496:             .txt_4c_P4CodProd.Value  = ALLTRIM(loc_lcCpro) + ;
2497:                 IIF(NOT EMPTY(loc_lcCor), "/"+ALLTRIM(loc_lcCor), "") + ;
2498:                 IIF(NOT EMPTY(loc_lcTam), "/"+ALLTRIM(loc_lcTam), "")
2499:             .txt_4c_P4QtPedida.Value = TmpFinalg.Saldo - TmpFinalg.Estoque
2500:             .txt_4c_P4QtSelec.Value  = 0
2501:             .grd_4c_GradeSelEst.RecordSource = "TmpDisp"
2502:             .grd_4c_GradeSelEst.Refresh
2503:         ENDWITH
2504: 
2505:         THIS.AlternarPagina(4)
2506:     ENDPROC
2507: 
2508:     *--------------------------------------------------------------------------
2509:     * BtnPedrasClick - Configura grade de requisicoes e navega para Page6
2510:     *--------------------------------------------------------------------------
2511:     PROCEDURE BtnPedrasClick
2512:         WITH THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra
2513:             IF USED("SelPedra")
2514:                 .RecordSource = ""
2515:             ENDIF
2516:             .RecordSource          = "SelPedra"
2517:             .ColumnCount           = 5
2518:             .Column1.ControlSource = "SelPedra.Cpros"
2519:             .Column2.ControlSource = "SelPedra.Dpros"
2520:             .Column3.ControlSource = "SelPedra.Cunis"
2521:             .Column4.ControlSource = "SelPedra.Qtds"
2522:             .Column5.ControlSource = "SelPedra.Cpro2s"
2523:             .Refresh
2524:         ENDWITH
2525: 
2526:         THIS.pgf_4c_Paginas.Page6.txt_4c_P6CodProd.Value = ALLTRIM(TmpFinalg.Cpros)
2527:         THIS.AlternarPagina(6)
2528:     ENDPROC
2529: 
2530:     *--------------------------------------------------------------------------
2531:     * BtnAlteraqtdClick - Autoriza alteracao de Produzir2 via SigOpSen
2532:     *--------------------------------------------------------------------------
2533:     PROCEDURE BtnAlteraqtdClick
2534:         LOCAL loc_lcString, loc_lcRetorno
2535: 
2536:         IF TmpFinalg.Produzir2 = 0
2537:             MsgAviso("Referencia Sem Quantidade a Produzir para Estoque!!!")
2538:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
2539:             RETURN
2540:         ENDIF
2541: 
2542:         loc_lcString = ALLTRIM(TmpFinalg.Cpros) + " Qt.Min:" + ;
2543:             ALLTRIM(TRANSFORM(TmpFinalg.QtdMins,  "@Z 99999.999")) + " " + ;
2544:             "Qt.Est:" + ALLTRIM(TRANSFORM(TmpFinalg.Produzir2, "@Z 99999.999"))
2545: 
2546:         DO FORM SigOpSen WITH "PRDZRISCO", loc_lcString, "" TO loc_lcRetorno
2547: 
2548:         CLEAR TYPEAHEAD
2549:         IF LEFT(loc_lcRetorno, 1) = "*"
2550:             THIS.this_lLiberado = .T.
2551:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.ReadOnly = .F.
2552:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
2553:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Column8.Text1.SetFocus
2554:         ELSE
2555:             MsgAviso("Altera"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o autorizada!")
2556:         ENDIF
2557:     ENDPROC
2558: 
2559:     *--------------------------------------------------------------------------
2560:     * BtnVoltarPage2Click - Valida e retorna de Operacoes Detalhadas para Page1
2561:     *--------------------------------------------------------------------------
2562:     PROCEDURE BtnVoltarPage2Click
2563:         LOCAL loc_nSumEst, loc_nSumPrc
2564: 
2565:         IF USED("TmpFinal") AND USED("TmpFinalg") AND NOT EOF("TmpFinalg")
2566:             SELECT TmpFinal
2567:             SUM TmpFinal.Estoque, TmpFinal.Fabrs TO loc_nSumEst, loc_nSumPrc
2568: 
2569:             IF loc_nSumEst <> TmpFinalg.Estoque
2570:                 MsgAviso("A quantidade de Estoque n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
2571:                 RETURN
2572:             ENDIF
2573:             IF loc_nSumPrc <> TmpFinalg.Fabrs
2574:                 MsgAviso("A quantidade de Produ"+CHR(231)+CHR(227)+"o n"+CHR(227)+"o confere com a Quantidade Selecionada!!!")
2575:                 RETURN
2576:             ENDIF
2577:         ENDIF
2578: 
2579:         THIS.AlternarPagina(1)
2580:     ENDPROC
2581: 
2582:     *--------------------------------------------------------------------------
2583:     * BtnVoltarPage3Click - Retorna de Totais por Linha para Page1
2584:     *--------------------------------------------------------------------------
2585:     PROCEDURE BtnVoltarPage3Click
2586:         THIS.AlternarPagina(1)
2587:     ENDPROC
2588: 
2589:     *--------------------------------------------------------------------------
2590:     * BtnVoltarPage4Click - Aplica selecoes de estoque (TmpDisp) e retorna para Page1
2591:     * Logica: Page4.CancelaDisp.Click do legado
2592:     *--------------------------------------------------------------------------
2593:     PROCEDURE BtnVoltarPage4Click
2594:         LOCAL loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
2595:         loc_nQtdUti = 0
2596:         loc_nQtUtil = 0
2597:         loc_nXBaixa = 0
2598: 
2599:         TRY
2600:             IF USED("TmpDisp")
2601: 
2602:                 SELECT TmpDisp
2603:                 SUM Utilizar TO loc_nQtdUti
2604: 
2605:                 IF loc_nQtdUti > 0
2606: 
2607:                     SELECT TmpDisp
2608:                     SCAN
2609:                         IF TmpDisp.Utilizar = 0
2610:                             LOOP
2611:                         ENDIF
2612:                         loc_nQtUtil = TmpDisp.Utilizar
2613: 
2614:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
2615: 
2616:                         SELECT TmpFinalg
2617:                         REPLACE Produzir  WITH Produzir - loc_nQtUtil, ;
2618:                                 Estoque   WITH Estoque + loc_nQtUtil, ;
2619:                                 UsuLibs   WITH ' ' IN TmpFinalg
2620:                         REPLACE Produzir2 WITH IIF(QtdMins > 0 AND Produzir < QtdMins AND Produzir > 0, ;
2621:                                                   QtdMins - Produzir, 0) IN TmpFinalg
2622: 
2623:                         SELECT TmpSaldo
2624:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - loc_nQtUtil IN TmpSaldo
2625: 
2626:                         *-- Registrar selecao manual de estoque em TmpSaldU
2627:                         IF NOT SEEK(TmpFinalg.Cpros, 'TmpSaldU', 'Cpros')
2628:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinalg.Cpros)
2629:                         ENDIF
2630:                         REPLACE keySelm WITH .T. IN TmpSaldU
2631: 
2632:                         *-- Atualizar disponivel no grupo/conta especifico em TmpSaldG
2633:                         SELECT TmpSaldG

*-- Linhas 2673 a 2724:
2673:         CATCH TO loc_oErr
2674:             MsgErro("Erro em BtnVoltarPage4Click: " + loc_oErr.Message + ;
2675:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
2676:                     " Proc:" + loc_oErr.Procedure + "]", "Erro")
2677:         ENDTRY
2678:     ENDPROC
2679: 
2680:     *--------------------------------------------------------------------------
2681:     * BtnVoltarPage5Click - Aplica selecoes por tamanho (TmpDisp) e retorna para Page1
2682:     * Logica: Page5.CancelaDisp.Click do legado ? quebra TmpFinal por tamanho
2683:     *--------------------------------------------------------------------------
2684:     PROCEDURE BtnVoltarPage5Click
2685:         LOCAL loc_nRegFinal, loc_nQtdUti, loc_nQtUtil, loc_nXBaixa, loc_oErr
2686:         LOCAL ARRAY loc_aFinal[1], loc_aMemvar[1]
2687:         loc_nRegFinal = 0
2688:         loc_nQtdUti   = 0
2689:         loc_nQtUtil   = 0
2690:         loc_nXBaixa   = 0
2691: 
2692:         TRY
2693:             IF USED("TmpDisp") AND USED("TmpFinal")
2694: 
2695:                 SELECT TmpFinal
2696:                 SET ORDER TO
2697:                 loc_nRegFinal = RECNO()
2698: 
2699:                 SELECT TmpDisp
2700:                 SUM Utilizar TO loc_nQtdUti
2701: 
2702:             IF loc_nQtdUti > 0
2703: 
2704:                 *-- Criar cursor Temporario com mesma estrutura de TmpFinal para staging
2705:                 SELECT TmpFinal
2706:                 =AFIELDS(loc_aFinal)
2707:                 CREATE CURSOR Temporario FROM ARRAY loc_aFinal
2708: 
2709:                 SELECT TmpDisp
2710:                 SCAN
2711:                     IF TmpDisp.Utilizar = 0
2712:                         LOOP
2713:                     ENDIF
2714:                     loc_nQtUtil = TmpDisp.Utilizar
2715: 
2716:                     =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, 'TmpSaldo')
2717: 
2718:                     *-- Copiar linha TmpFinal para Temporario, ajustando tamanho e quantidade
2719:                     SELECT TmpFinal
2720:                     SCATTER TO loc_aMemvar
2721:                     SELECT Temporario
2722:                     APPEND FROM ARRAY loc_aMemvar
2723:                     REPLACE Temporario.Saldo    WITH loc_nQtUtil, ;
2724:                             Temporario.CodTams  WITH TmpDisp.CodTams, ;

*-- Linhas 2817 a 3562:
2817:         CATCH TO loc_oErr
2818:             MsgErro("Erro em BtnVoltarPage5Click: " + loc_oErr.Message + ;
2819:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + ;
2820:                     " Proc:" + loc_oErr.Procedure + "]", "Erro")
2821:         ENDTRY
2822:     ENDPROC
2823: 
2824:     *--------------------------------------------------------------------------
2825:     * GradeSelEstCol5Valid - Valida quantidade Utilizar na grade de Page4 (Sel.Estoque)
2826:     *--------------------------------------------------------------------------
2827:     PROCEDURE GradeSelEstCol5Valid
2828:         LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
2829:         loc_lResultado = .T.
2830:         loc_nVal       = 0
2831:         loc_nPedida    = 0
2832:         loc_nRegDisp   = 0
2833:         loc_nQtdUti    = 0
2834: 
2835:         IF NOT USED("TmpDisp") OR NOT USED("TmpFinalg") OR EOF("TmpFinalg")
2836:             RETURN loc_lResultado
2837:         ENDIF
2838: 
2839:         loc_nVal    = THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value
2840:         loc_nPedida = TmpFinalg.Saldo - TmpFinalg.Estoque
2841: 
2842:         IF loc_nVal > TmpDisp.Disps
2843:             MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
2844:             THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
2845:             THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
2846:             loc_lResultado = .F.
2847:         ELSE
2848:             IF loc_nVal < 0
2849:                 MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser menor que zero...")
2850:                 THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
2851:                 THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
2852:                 loc_lResultado = .F.
2853:             ELSE
2854:                 loc_nRegDisp = RECNO("TmpDisp")
2855:                 SELECT TmpDisp
2856:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2857:                 GO loc_nRegDisp IN TmpDisp
2858:                 IF loc_nQtdUti > loc_nPedida
2859:                     MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Solicitada...")
2860:                     THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Value = 0
2861:                     THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
2862:                     loc_lResultado = .F.
2863:                 ELSE
2864:                     WITH THIS.pgf_4c_Paginas.Page4
2865:                         .txt_4c_P4QtSelec.Value = loc_nQtdUti
2866:                         .txt_4c_P4QtSelec.Refresh
2867:                     ENDWITH
2868:                 ENDIF
2869:             ENDIF
2870:         ENDIF
2871: 
2872:         RETURN loc_lResultado
2873:     ENDPROC
2874: 
2875:     *--------------------------------------------------------------------------
2876:     * GradeSelEstCol5LostFocus - Avanca linha ao Enter na grade de Page4
2877:     *--------------------------------------------------------------------------
2878:     PROCEDURE GradeSelEstCol5LostFocus
2879:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2880:         IF LASTKEY() = 13
2881:             KEYBOARD "{DNARROW}"
2882:         ENDIF
2883:         THIS.pgf_4c_Paginas.Page4.grd_4c_GradeSelEst.Column5.Text1.Refresh
2884:     ENDPROC
2885: 
2886:     *--------------------------------------------------------------------------
2887:     * GradeDispColsGotFocus - Colunas ReadOnly de Page5 redirecionam foco para Col5
2888:     *--------------------------------------------------------------------------
2889:     PROCEDURE GradeDispColsGotFocus
2890:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "grd_4c_GradeDisp", 5)
2891:             THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.SetFocus
2892:         ENDIF
2893:     ENDPROC
2894: 
2895:     *--------------------------------------------------------------------------
2896:     * GradeDispCol5Valid - Valida quantidade Utilizar na grade de Page5 (Disponivel/Tam)
2897:     *--------------------------------------------------------------------------
2898:     PROCEDURE GradeDispCol5Valid
2899:         LOCAL loc_nVal, loc_nPedida, loc_nRegDisp, loc_nQtdUti, loc_lResultado
2900:         loc_lResultado = .T.
2901:         loc_nVal       = 0
2902:         loc_nPedida    = 0
2903:         loc_nRegDisp   = 0
2904:         loc_nQtdUti    = 0
2905: 
2906:         IF NOT USED("TmpDisp") OR NOT PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "txt_4c_P5QtPedida", 5)
2907:             RETURN loc_lResultado
2908:         ENDIF
2909: 
2910:         loc_nVal    = THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value
2911:         loc_nPedida = THIS.pgf_4c_Paginas.Page5.txt_4c_P5QtPedida.Value
2912: 
2913:         IF loc_nVal > TmpDisp.Disps
2914:             MsgAviso("A quantidade a utilizar n"+CHR(227)+"o pode ser maior que Qtde Dispon"+CHR(237)+"vel...")
2915:             THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
2916:             THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
2917:             loc_lResultado = .F.
2918:         ELSE
2919:             loc_nRegDisp = RECNO("TmpDisp")
2920:             SELECT TmpDisp
2921:             SUM TmpDisp.Utilizar TO loc_nQtdUti
2922:             GO loc_nRegDisp IN TmpDisp
2923:             IF loc_nQtdUti > loc_nPedida
2924:                 MsgAviso("Qtde Selecionada n"+CHR(227)+"o pode ser maior que Qtde Pedida...")
2925:                 THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Value = 0
2926:                 THIS.pgf_4c_Paginas.Page5.grd_4c_GradeDisp.Column5.Text1.Refresh
2927:                 loc_lResultado = .F.
2928:             ELSE
2929:                 WITH THIS.pgf_4c_Paginas.Page5
2930:                     .txt_4c_P5QtSelec.Value = loc_nQtdUti
2931:                     .txt_4c_P5QtSelec.Refresh
2932:                 ENDWITH
2933:             ENDIF
2934:         ENDIF
2935: 
2936:         RETURN loc_lResultado
2937:     ENDPROC
2938: 
2939:     *--------------------------------------------------------------------------
2940:     * BtnVoltarPage6Click - Retorna de Requisicoes para Page1
2941:     *--------------------------------------------------------------------------
2942:     PROCEDURE BtnVoltarPage6Click
2943:         THIS.AlternarPagina(1)
2944:     ENDPROC
2945: 
2946:     *--------------------------------------------------------------------------
2947:     * GradeOpeAfterRowColChange - Atualiza label obs e imagem ao mudar linha na Page2
2948:     *--------------------------------------------------------------------------
2949:     PROCEDURE GradeOpeAfterRowColChange
2950:         LPARAMETERS par_nColIndex
2951:         LOCAL loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oPag2
2952:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2953: 
2954:         IF NOT USED("TmpFinal") OR EOF("TmpFinal")
2955:             RETURN
2956:         ENDIF
2957: 
2958:         loc_oPag2.lbl_4c_ObsItem.Caption = "Observa"+CHR(231)+CHR(227)+"o do Item " + ALLTRIM(TmpFinal.Cpros)
2959:         loc_oPag2.edt_4c_ObsItens.Refresh
2960: 
2961:         loc_lcSql = [SELECT cpros, figjpgs FROM SigCdPro WHERE Cpros = ] + ;
2962:                     EscaparSQL(TmpFinal.Cpros)
2963:         IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_ProdFig2") >= 1
2964:             WITH loc_oPag2.img_4c_FigOpe
2965:                 IF NOT EMPTY(cursor_4c_ProdFig2.FigJpgs) AND NOT ISNULL(cursor_4c_ProdFig2.FigJpgs)
2966:                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
2967:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_ProdFig2.FigJpgs, ;
2968:                         "data:image/png;base64,", ""), ;
2969:                         "data:image/jpeg;base64,", ""), ;
2970:                         "data:image/jpg;base64,", ""), 14)
2971:                     =STRTOFILE(loc_lcFoto, loc_lcArquivo)
2972:                     .Picture = loc_lcArquivo
2973:                     .Visible = .T.
2974:                 ELSE
2975:                     .Picture = ""
2976:                     .Visible = .F.
2977:                 ENDIF
2978:             ENDWITH
2979:             USE IN cursor_4c_ProdFig2
2980:         ENDIF
2981:     ENDPROC
2982: 
2983:     *--------------------------------------------------------------------------
2984:     * GradeOpeColsGotFocus - Colunas ReadOnly de Page2 redirecionam foco para Col7
2985:     *--------------------------------------------------------------------------
2986:     PROCEDURE GradeOpeColsGotFocus
2987:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_GradeOpe", 5)
2988:             THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.SetFocus
2989:         ENDIF
2990:     ENDPROC
2991: 
2992:     *--------------------------------------------------------------------------
2993:     * GradeOpeCol7GotFocus - Salva valor anterior de Estoque (Col7 Page2)
2994:     *--------------------------------------------------------------------------
2995:     PROCEDURE GradeOpeCol7GotFocus
2996:         THIS.this_nOldValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
2997:     ENDPROC
2998: 
2999:     *--------------------------------------------------------------------------
3000:     * GradeOpeCol7Valid - Valida nova quantidade de Estoque na Page2
3001:     * Limites: nao negativo, nao excede Saldo da operacao, nao excede Tot_sEst selecionado
3002:     *--------------------------------------------------------------------------
3003:     PROCEDURE GradeOpeCol7Valid
3004:         LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
3005:         loc_lResultado = .T.
3006:         loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value
3007:         loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSEst.Value
3008: 
3009:         DO CASE
3010:             CASE loc_nNewVal = THIS.this_nOldValue
3011:                 *-- Sem alteracao: aceitar
3012: 
3013:             CASE loc_nNewVal < 0
3014:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
3015:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
3016:                 loc_lResultado = .F.
3017: 
3018:             CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
3019:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
3020:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
3021:                 loc_lResultado = .F.
3022: 
3023:             CASE loc_nNewVal > loc_nPSaldo
3024:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
3025:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column7.Text1.Value = THIS.this_nOldValue
3026:                 loc_lResultado = .F.
3027: 
3028:             OTHERWISE
3029:                 IF USED("TmpFinal") AND NOT EOF("TmpFinal")
3030:                     REPLACE TmpFinal.Estoque WITH loc_nNewVal IN TmpFinal
3031:                 ENDIF
3032:         ENDCASE
3033: 
3034:         RETURN loc_lResultado
3035:     ENDPROC
3036: 
3037:     *--------------------------------------------------------------------------
3038:     * GradeOpeCol7LostFocus - Atualiza totais de Page2 apos edicao de Estoque
3039:     *--------------------------------------------------------------------------
3040:     PROCEDURE GradeOpeCol7LostFocus
3041:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3042:         THIS.AtualizarTotaisPage2()
3043:     ENDPROC
3044: 
3045:     *--------------------------------------------------------------------------
3046:     * AtualizarTotaisPage2 - Recalcula e exibe totais de TmpFinal na Page2
3047:     *--------------------------------------------------------------------------
3048:     PROTECTED PROCEDURE AtualizarTotaisPage2()
3049:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3050: 
3051:         IF NOT USED("TmpFinal") OR EOF("TmpFinal")
3052:             RETURN
3053:         ENDIF
3054: 
3055:         SELECT TmpFinal
3056:         loc_nRecno = RECNO()
3057:         SUM Saldo, Estoque, Produzir, Fabrs TO loc_nSal, loc_nEst, loc_nPrz, loc_nPrc
3058:         GO loc_nRecno
3059: 
3060:         WITH THIS.pgf_4c_Paginas.Page2
3061:             .txt_4c_P2TotQtd.Value = loc_nSal
3062:             .txt_4c_P2TotEst.Value = loc_nEst
3063:             .txt_4c_P2TotPrc.Value = loc_nPrc
3064:             .txt_4c_P2TotPrz.Value = loc_nPrz
3065:             .txt_4c_P2TotQtd.Refresh
3066:             .txt_4c_P2TotEst.Refresh
3067:             .txt_4c_P2TotPrc.Refresh
3068:             .txt_4c_P2TotPrz.Refresh
3069:         ENDWITH
3070:     ENDPROC
3071: 
3072:     *--------------------------------------------------------------------------
3073:     PROCEDURE GradeOpeCol10GotFocus
3074:         THIS.this_nAntValue = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
3075:     ENDPROC
3076: 
3077:     *--------------------------------------------------------------------------
3078:     PROCEDURE GradeOpeCol10Valid
3079:         LOCAL loc_lResultado, loc_nNewVal, loc_nPSaldo
3080:         loc_lResultado = .T.
3081:         loc_nNewVal    = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value
3082:         loc_nPSaldo    = THIS.pgf_4c_Paginas.Page2.txt_4c_TotSPrc.Value
3083: 
3084:         DO CASE
3085:             CASE loc_nNewVal = THIS.this_nAntValue
3086:                 *-- sem alteracao, nada a fazer
3087:             CASE loc_nNewVal < 0
3088:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser um valor negativo...")
3089:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
3090:                 loc_lResultado = .F.
3091:             CASE USED("TmpFinal") AND NOT EOF("TmpFinal") AND loc_nNewVal > TmpFinal.Saldo
3092:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade da Opera"+CHR(231)+CHR(227)+"o...")
3093:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
3094:                 loc_lResultado = .F.
3095:             CASE loc_nNewVal > loc_nPSaldo
3096:                 MsgAviso("A quantidade n"+CHR(227)+"o pode ser maior que a quantidade Selecionada...")
3097:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GradeOpe.Column10.Text1.Value = THIS.this_nAntValue
3098:                 loc_lResultado = .F.
3099:             OTHERWISE
3100:                 IF USED("TmpFinal") AND NOT EOF("TmpFinal")
3101:                     REPLACE TmpFinal.Fabrs WITH loc_nNewVal IN TmpFinal
3102:                 ENDIF
3103:         ENDCASE
3104: 
3105:         RETURN loc_lResultado
3106:     ENDPROC
3107: 
3108:     *--------------------------------------------------------------------------
3109:     PROCEDURE GradeOpeCol10LostFocus
3110:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3111:         THIS.AtualizarTotaisPage2()
3112:     ENDPROC
3113: 
3114:     *--------------------------------------------------------------------------
3115:     * GradePedraCol1Valid - Lookup de produto principal na grade de Requisicao (Page6)
3116:     * Busca em SigCdPro e preenche Dpros e Cunis no cursor SelPedra
3117:     *--------------------------------------------------------------------------
3118:     PROCEDURE GradePedraCol1Valid
3119:         LOCAL loc_cCodPro, loc_oBusca, loc_oErr, loc_lcSql, loc_lcSql2
3120:         loc_cCodPro = ""
3121: 
3122:         IF NOT USED("SelPedra") OR EOF("SelPedra")
3123:             RETURN .T.
3124:         ENDIF
3125: 
3126:         loc_cCodPro = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column1.Text1.Value)
3127: 
3128:         IF EMPTY(loc_cCodPro)
3129:             REPLACE SelPedra.Dpros WITH "" IN SelPedra
3130:             REPLACE SelPedra.Cunis WITH "" IN SelPedra
3131:             RETURN .T.
3132:         ENDIF
3133: 
3134:         TRY
3135:             loc_lcSql = [SELECT a.CPros, a.DPros, a.Cunis FROM SigCdPro a WHERE a.CPros = ] + ;
3136:                         EscaparSQL(loc_cCodPro)
3137:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPPedra") >= 1 AND ;
3138:                NOT EOF("cursor_4c_BPPedra")
3139:                 REPLACE SelPedra.Cpros  WITH ALLTRIM(cursor_4c_BPPedra.CPros) IN SelPedra
3140:                 REPLACE SelPedra.Dpros  WITH ALLTRIM(cursor_4c_BPPedra.DPros) IN SelPedra
3141:                 REPLACE SelPedra.Cunis  WITH ALLTRIM(cursor_4c_BPPedra.Cunis) IN SelPedra
3142:                 USE IN cursor_4c_BPPedra
3143:             ELSE
3144:                 IF USED("cursor_4c_BPPedra")
3145:                     USE IN cursor_4c_BPPedra
3146:                 ENDIF
3147:                 *-- Produto nao encontrado: abrir picker
3148:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3149:                     "SigCdPro", "cursor_4c_BPPedra2", "CPros", loc_cCodPro, ;
3150:                     "Selecionar Produto", .T., .T., "")
3151:                 loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
3152:                 loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
3153:                 loc_oBusca.Show()
3154:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPPedra2")
3155:                     REPLACE SelPedra.Cpros WITH ALLTRIM(cursor_4c_BPPedra2.CPros) IN SelPedra
3156:                     REPLACE SelPedra.Dpros WITH ALLTRIM(cursor_4c_BPPedra2.DPros) IN SelPedra
3157:                     *-- Buscar unidade complementar
3158:                     loc_lcSql2 = [SELECT Cunis FROM SigCdPro WHERE CPros = ] + ;
3159:                                  EscaparSQL(ALLTRIM(cursor_4c_BPPedra2.CPros))
3160:                     IF SQLEXEC(gnConnHandle, loc_lcSql2, "cursor_4c_BPUni") >= 1
3161:                         REPLACE SelPedra.Cunis WITH ALLTRIM(cursor_4c_BPUni.Cunis) IN SelPedra
3162:                         USE IN cursor_4c_BPUni
3163:                     ENDIF
3164:                 ELSE
3165:                     REPLACE SelPedra.Cpros WITH "" IN SelPedra
3166:                     REPLACE SelPedra.Dpros WITH "" IN SelPedra
3167:                     REPLACE SelPedra.Cunis WITH "" IN SelPedra
3168:                 ENDIF
3169:                 IF USED("cursor_4c_BPPedra2")
3170:                     USE IN cursor_4c_BPPedra2
3171:                 ENDIF
3172:                 loc_oBusca.Release()
3173:             ENDIF
3174: 
3175:             THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh
3176: 
3177:         CATCH TO loc_oErr
3178:             MsgErro("Erro no lookup de produto (Grade Pedra): " + loc_oErr.Message, "Erro")
3179:         ENDTRY
3180: 
3181:         RETURN .T.
3182:     ENDPROC
3183: 
3184:     *--------------------------------------------------------------------------
3185:     * GradePedraCol4When - Coluna 4 (Qtde) so editavel se Produto preenchido
3186:     *--------------------------------------------------------------------------
3187:     PROCEDURE GradePedraCol4When
3188:         IF NOT USED("SelPedra") OR EOF("SelPedra")
3189:             RETURN .F.
3190:         ENDIF
3191:         RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
3192:     ENDPROC
3193: 
3194:     *--------------------------------------------------------------------------
3195:     * GradePedraCol5When - Coluna 5 (Produto Ref) so editavel se Produto preenchido
3196:     *--------------------------------------------------------------------------
3197:     PROCEDURE GradePedraCol5When
3198:         IF NOT USED("SelPedra") OR EOF("SelPedra")
3199:             RETURN .F.
3200:         ENDIF
3201:         RETURN NOT EMPTY(ALLTRIM(SelPedra.Cpros))
3202:     ENDPROC
3203: 
3204:     *--------------------------------------------------------------------------
3205:     * GradePedraCol5Valid - Lookup de produto referencia (Cpro2s) na grade Page6
3206:     *--------------------------------------------------------------------------
3207:     PROCEDURE GradePedraCol5Valid
3208:         LOCAL loc_cCodRef, loc_oBusca, loc_oErr, loc_lcSql
3209:         loc_cCodRef = ""
3210: 
3211:         IF NOT USED("SelPedra") OR EOF("SelPedra")
3212:             RETURN .T.
3213:         ENDIF
3214: 
3215:         loc_cCodRef = ALLTRIM(THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Column5.Text1.Value)
3216: 
3217:         IF EMPTY(loc_cCodRef)
3218:             REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
3219:             THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh
3220:             RETURN .T.
3221:         ENDIF
3222: 
3223:         TRY
3224:             loc_lcSql = [SELECT CPros FROM SigCdPro WHERE CPros = ] + EscaparSQL(loc_cCodRef)
3225:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_BPro2") >= 1 AND ;
3226:                NOT EOF("cursor_4c_BPro2")
3227:                 REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2.CPros) IN SelPedra
3228:                 USE IN cursor_4c_BPro2
3229:             ELSE
3230:                 IF USED("cursor_4c_BPro2")
3231:                     USE IN cursor_4c_BPro2
3232:                 ENDIF
3233:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3234:                     "SigCdPro", "cursor_4c_BPro2b", "CPros", loc_cCodRef, ;
3235:                     "Produto Refer"+CHR(234)+"ncia", .T., .T., "")
3236:                 loc_oBusca.mAddColuna("CPros", "", "C"+CHR(243)+"digo")
3237:                 loc_oBusca.mAddColuna("DPros", "", "Descri"+CHR(231)+CHR(227)+"o")
3238:                 loc_oBusca.Show()
3239:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BPro2b")
3240:                     REPLACE SelPedra.Cpro2s WITH ALLTRIM(cursor_4c_BPro2b.CPros) IN SelPedra
3241:                 ELSE
3242:                     REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
3243:                 ENDIF
3244:                 IF USED("cursor_4c_BPro2b")
3245:                     USE IN cursor_4c_BPro2b
3246:                 ENDIF
3247:                 loc_oBusca.Release()
3248:             ENDIF
3249: 
3250:             THIS.pgf_4c_Paginas.Page6.grd_4c_GradePedra.Refresh
3251: 
3252:         CATCH TO loc_oErr
3253:             MsgErro("Erro no lookup de produto refer"+CHR(234)+"ncia: " + loc_oErr.Message, "Erro")
3254:         ENDTRY
3255: 
3256:         RETURN .T.
3257:     ENDPROC
3258: 
3259:     *--------------------------------------------------------------------------
3260:     * GradePedraCol5LostFocus - Adiciona nova linha quando usuario sai da ultima linha preenchida
3261:     *--------------------------------------------------------------------------
3262:     PROCEDURE GradePedraCol5LostFocus
3263:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3264:         LOCAL loc_nPosicao
3265:         IF NOT USED("SelPedra") OR EOF("SelPedra")
3266:             RETURN
3267:         ENDIF
3268: 
3269:         loc_nPosicao = RECNO("SelPedra")
3270:         GO BOTTOM IN SelPedra
3271:         IF NOT EMPTY(ALLTRIM(SelPedra.Cpros)) AND RECNO("SelPedra") = loc_nPosicao
3272:             APPEND BLANK IN SelPedra
3273:         ENDIF
3274:         GO loc_nPosicao IN SelPedra
3275:         KEYBOARD "{DNARROW}"
3276:     ENDPROC
3277: 
3278:     *==========================================================================
3279:     * ADAPTADORES CRUD PARA FORM OPERACIONAL
3280:     * SIGPRGLX eh operacional (Previa da Globalizacao) e nao possui CRUD.
3281:     * Os handlers abaixo mapeiam a interface CRUD padrao para as operacoes
3282:     * reais do form: Processar (main action), Alterar Qtd (autorizacao),
3283:     * Visualizar Imagem, e Cancelar/Encerrar.
3284:     *==========================================================================
3285: 
3286:     *--------------------------------------------------------------------------
3287:     * BtnIncluirClick - Executa o processamento da globalizacao (acao principal)
3288:     * Em forms operacionais de preview, "incluir" == confirmar e processar.
3289:     *--------------------------------------------------------------------------
3290:     PROCEDURE BtnIncluirClick
3291:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
3292:             MsgAviso("N"+CHR(227)+"o h"+CHR(225)+" itens dispon"+CHR(237)+"veis para processar.")
3293:             RETURN
3294:         ENDIF
3295:         THIS.BtnProcessarClick()
3296:     ENDPROC
3297: 
3298:     *--------------------------------------------------------------------------
3299:     * BtnAlterarClick - Autoriza alteracao da quantidade de producao para estoque
3300:     * Delega para BtnAlteraqtdClick que abre SigOpSen para validar senha.
3301:     *--------------------------------------------------------------------------
3302:     PROCEDURE BtnAlterarClick
3303:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
3304:             MsgAviso("Selecione um item da grade antes de alterar.")
3305:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
3306:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.SetFocus
3307:             ENDIF
3308:             RETURN
3309:         ENDIF
3310:         THIS.BtnAlteraqtdClick()
3311:     ENDPROC
3312: 
3313:     *--------------------------------------------------------------------------
3314:     * BtnVisualizarClick - Exibe a imagem do produto da linha corrente
3315:     * Reproduz o mesmo SQL de ImgFigJpg.Click (SigCdPro.FigJpgs) e renderiza
3316:     * em arquivo temporario alimentando o Image control da Page1.
3317:     *--------------------------------------------------------------------------
3318:     PROCEDURE BtnVisualizarClick
3319:         LOCAL loc_lcCodPro, loc_lcSql, loc_lcArquivo, loc_lcFoto, loc_oErr
3320: 
3321:         IF NOT USED("TmpFinalg") OR EOF("TmpFinalg")
3322:             MsgAviso("Selecione um item da grade para visualizar a imagem.")
3323:             RETURN
3324:         ENDIF
3325: 
3326:         loc_lcCodPro  = TmpFinalg.Cpros
3327:         loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
3328:         loc_lcSql     = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
3329:                         "WHERE a.cpros = " + EscaparSQL(loc_lcCodPro)
3330: 
3331:         TRY
3332:             IF USED("cursor_4c_LocalPro")
3333:                 USE IN cursor_4c_LocalPro
3334:             ENDIF
3335: 
3336:             IF SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_LocalPro") < 1
3337:                 MsgAviso("N"+CHR(227)+"o foi poss"+CHR(237)+"vel carregar a imagem do produto.")
3338:                 RETURN
3339:             ENDIF
3340: 
3341:             IF NOT EMPTY(NVL(cursor_4c_LocalPro.FigJpgs, "")) AND ;
3342:                NOT ISNULL(cursor_4c_LocalPro.FigJpgs)
3343: 
3344:                 loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
3345:                     cursor_4c_LocalPro.FigJpgs, ;
3346:                     "data:image/png;base64,",  ""), ;
3347:                     "data:image/jpeg;base64,", ""), ;
3348:                     "data:image/jpg;base64,",  ""), 14)
3349:                 =STRTOFILE(loc_lcFoto, loc_lcArquivo)
3350: 
3351:                 WITH THIS.pgf_4c_Paginas.Page1.img_4c_FigJpg
3352:                     .Picture = loc_lcArquivo
3353:                     .Visible = .T.
3354:                 ENDWITH
3355:             ELSE
3356:                 MsgAviso("Nenhuma imagem cadastrada para este produto.")
3357:             ENDIF
3358: 
3359:             IF USED("cursor_4c_LocalPro")
3360:                 USE IN cursor_4c_LocalPro
3361:             ENDIF
3362:         CATCH TO loc_oErr
3363:             MsgErro("Erro ao visualizar imagem: " + loc_oErr.Message + ;
3364:                     " [Ln:" + TRANSFORM(loc_oErr.LineNo) + "]", "Erro")
3365:         ENDTRY
3366:     ENDPROC
3367: 
3368:     *--------------------------------------------------------------------------
3369:     * BtnExcluirClick - Encerra o form sem processar (equivale a cancelar)
3370:     * Em preview de globalizacao, "excluir" == abandonar as alteracoes.
3371:     *--------------------------------------------------------------------------
3372:     PROCEDURE BtnExcluirClick
3373:         IF NOT MsgConfirma("Confirma o cancelamento da Globaliza"+CHR(231)+CHR(227)+"o?" + ;
3374:                            CHR(13) + "Todas as sele"+CHR(231)+CHR(245)+"es ser"+CHR(227)+"o descartadas.")
3375:             RETURN
3376:         ENDIF
3377:         THIS.BtnCancelarClick()
3378:     ENDPROC
3379: 
3380:     *--------------------------------------------------------------------------
3381:     * BtnSalvarClick - Acao principal do form operacional (delega para Processar)
3382:     *--------------------------------------------------------------------------
3383:     PROCEDURE BtnSalvarClick
3384:         THIS.BtnProcessarClick()
3385:     ENDPROC
3386: 
3387:     *--------------------------------------------------------------------------
3388:     * BtnBuscarClick - Atualiza exibicao dos dados das grades operacionais
3389:     *--------------------------------------------------------------------------
3390:     PROCEDURE BtnBuscarClick
3391:         IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
3392:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
3393:                 THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
3394:             ENDIF
3395:             THIS.AtualizarTotaisGrade()
3396:         ENDIF
3397:     ENDPROC
3398: 
3399:     *--------------------------------------------------------------------------
3400:     * BtnEncerrarClick - Encerra o form (mesma logica que BtnCancelarClick)
3401:     *--------------------------------------------------------------------------
3402:     PROCEDURE BtnEncerrarClick
3403:         THIS.BtnCancelarClick()
3404:     ENDPROC
3405: 
3406:     *==========================================================================
3407:     * METODOS DE SUPORTE (FASE 8)
3408:     *==========================================================================
3409: 
3410:     *--------------------------------------------------------------------------
3411:     * CarregarLista - Vincula grades aos cursores operacionais (TmpFinalg etc.)
3412:     * Para form operacional, os cursores sao passados via datasession do form pai;
3413:     * este metodo apenas atualiza a exibicao apos os cursores estarem populados.
3414:     *--------------------------------------------------------------------------
3415:     PROCEDURE CarregarLista()
3416:         LOCAL loc_lSucesso
3417:         loc_lSucesso = .F.
3418: 
3419:         IF NOT USED("TmpFinalg") OR RECCOUNT("TmpFinalg") = 0
3420:             RETURN loc_lSucesso
3421:         ENDIF
3422: 
3423:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
3424:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.Refresh
3425:         ENDIF
3426: 
3427:         THIS.AtualizarTotaisGrade()
3428:         loc_lSucesso = .T.
3429: 
3430:         RETURN loc_lSucesso
3431:     ENDPROC
3432: 
3433:     *--------------------------------------------------------------------------
3434:     * HabilitarCampos - Habilita/desabilita controles conforme disponibilidade de dados
3435:     *--------------------------------------------------------------------------
3436:     PROTECTED PROCEDURE HabilitarCampos()
3437:         LOCAL loc_lTemDados
3438: 
3439:         IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3440:             RETURN
3441:         ENDIF
3442: 
3443:         loc_lTemDados = USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
3444: 
3445:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_GradeItens", 5)
3446:             THIS.pgf_4c_Paginas.Page1.grd_4c_GradeItens.ReadOnly = !loc_lTemDados
3447:         ENDIF
3448: 
3449:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Processar", 5)
3450:             THIS.pgf_4c_Paginas.Page1.btn_4c_Processar.Enabled = loc_lTemDados
3451:         ENDIF
3452: 
3453:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_TotLinha", 5)
3454:             THIS.pgf_4c_Paginas.Page1.btn_4c_TotLinha.Enabled = loc_lTemDados
3455:         ENDIF
3456: 
3457:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Alteraqtd", 5)
3458:             THIS.pgf_4c_Paginas.Page1.btn_4c_Alteraqtd.Enabled = loc_lTemDados
3459:         ENDIF
3460:     ENDPROC
3461: 
3462:     *--------------------------------------------------------------------------
3463:     * LimparCampos - Zera campos de totalizacao da Page1
3464:     *--------------------------------------------------------------------------
3465:     PROTECTED PROCEDURE LimparCampos()
3466:         LOCAL loc_oPag1
3467: 
3468:         IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3469:             RETURN
3470:         ENDIF
3471: 
3472:         loc_oPag1 = THIS.pgf_4c_Paginas.Page1
3473: 
3474:         IF PEMSTATUS(loc_oPag1, "txt_4c_TotQtd", 5)
3475:             loc_oPag1.txt_4c_TotQtd.Value = 0
3476:         ENDIF
3477:         IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrdc", 5)
3478:             loc_oPag1.txt_4c_TotPrdc.Value = 0
3479:         ENDIF
3480:         IF PEMSTATUS(loc_oPag1, "txt_4c_TotEst", 5)
3481:             loc_oPag1.txt_4c_TotEst.Value = 0
3482:         ENDIF
3483:         IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrz", 5)
3484:             loc_oPag1.txt_4c_TotPrz.Value = 0
3485:         ENDIF
3486:         IF PEMSTATUS(loc_oPag1, "txt_4c_TotPrze", 5)
3487:             loc_oPag1.txt_4c_TotPrze.Value = 0
3488:         ENDIF
3489:     ENDPROC
3490: 
3491:     *--------------------------------------------------------------------------
3492:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme pagina ativa
3493:     *--------------------------------------------------------------------------
3494:     PROTECTED PROCEDURE AjustarBotoesPorModo()
3495:         LOCAL loc_nPaginaAtiva
3496: 
3497:         IF NOT PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
3498:             RETURN
3499:         ENDIF
3500: 
3501:         loc_nPaginaAtiva = THIS.pgf_4c_Paginas.ActivePage
3502: 
3503:         DO CASE
3504:             CASE loc_nPaginaAtiva = 1
3505:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Processar", 5)
3506:                     THIS.pgf_4c_Paginas.Page1.btn_4c_Processar.Visible = .T.
3507:                 ENDIF
3508:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_Cancelar", 5)
3509:                     THIS.pgf_4c_Paginas.Page1.btn_4c_Cancelar.Visible = .T.
3510:                 ENDIF
3511:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "btn_4c_TotLinha", 5)
3512:                     THIS.pgf_4c_Paginas.Page1.btn_4c_TotLinha.Visible = .T.
3513:                 ENDIF
3514:             CASE loc_nPaginaAtiva = 2
3515:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "btn_4c_VoltarP2", 5)
3516:                     THIS.pgf_4c_Paginas.Page2.btn_4c_VoltarP2.Visible = .T.
3517:                 ENDIF
3518:             CASE loc_nPaginaAtiva = 3
3519:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page3, "btn_4c_VoltarP3", 5)
3520:                     THIS.pgf_4c_Paginas.Page3.btn_4c_VoltarP3.Visible = .T.
3521:                 ENDIF
3522:             CASE loc_nPaginaAtiva = 4
3523:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page4, "btn_4c_VoltarP4", 5)
3524:                     THIS.pgf_4c_Paginas.Page4.btn_4c_VoltarP4.Visible = .T.
3525:                 ENDIF
3526:             CASE loc_nPaginaAtiva = 5
3527:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page5, "btn_4c_VoltarP5", 5)
3528:                     THIS.pgf_4c_Paginas.Page5.btn_4c_VoltarP5.Visible = .T.
3529:                 ENDIF
3530:             CASE loc_nPaginaAtiva = 6
3531:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page6, "btn_4c_VoltarP6", 5)
3532:                     THIS.pgf_4c_Paginas.Page6.btn_4c_VoltarP6.Visible = .T.
3533:                 ENDIF
3534:         ENDCASE
3535:     ENDPROC
3536: 
3537:     *--------------------------------------------------------------------------
3538:     * FormParaBO - Transfere flags operacionais para o BO antes do Processar
3539:     *--------------------------------------------------------------------------
3540:     PROTECTED PROCEDURE FormParaBO()
3541:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3542:             RETURN
3543:         ENDIF
3544:         WITH THIS.this_oBusinessObject
3545:             .this_lReserva    = THIS.this_lReserva
3546:             .this_nEmphPdr    = THIS.this_nEmphPdr
3547:             .this_lAutomatico = THIS.this_lAutomatico
3548:             .this_nNumeroOp   = THIS.this_nNumeroOp
3549:             .this_lPorDestino = THIS.this_lPorDestino
3550:         ENDWITH
3551:     ENDPROC
3552: 
3553:     *--------------------------------------------------------------------------
3554:     * BOParaForm - Atualiza exibicao apos processamento do BO
3555:     *--------------------------------------------------------------------------
3556:     PROTECTED PROCEDURE BOParaForm()
3557:         IF USED("TmpFinalg") AND RECCOUNT("TmpFinalg") > 0
3558:             THIS.AtualizarTotaisGrade()
3559:         ENDIF
3560:     ENDPROC
3561: 
3562: ENDDEFINE

