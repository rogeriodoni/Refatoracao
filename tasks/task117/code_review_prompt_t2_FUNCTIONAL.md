# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'OptAgrupa' (parent: SIGREIDT): Top original=129 vs migrado 'obj_4c_OptAgrupa' Top=4 (diff=125px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptAgrupa' (parent: SIGREIDT): Left original=346 vs migrado 'obj_4c_OptAgrupa' Left=6 (diff=340px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGREIDT): Top original=102 vs migrado 'obj_4c_OptTipo' Top=4 (diff=98px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTipo' (parent: SIGREIDT): Left original=346 vs migrado 'obj_4c_OptTipo' Left=6 (diff=340px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIdt.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (813 linhas total):

*-- Linhas 4 a 227:
4: *
5: * Form original: SIGREIDT.SCX (frmrelatorio)
6: * Tipo: REPORT - layout flat (sem PageFrame CRUD)
7: * Chamado com parametros: CREATEOBJECT("FormSigReIdt","",pEmp,pDop,pNum,pNumF,pDir)
8: *
9: * Filtros/Opcoes:
10: *   - optTipo   (1=Titulo / 2=Autorizacao de Gasto, default=2)
11: *   - OptAgrupa (1=Sim / 2=Agrupada / 3=Nenhum, default=3)
12: *
13: * Reports usados (via SigReIdtBO.ObterNomeFrx):
14: *   - SigReIdt.frx  (Titulo, sem agrupamento)
15: *   - SigReIdA.frx  (Titulo, agrupada)
16: *   - SigReIag.frx  (Autorizacao de Gasto)
17: *==============================================================================
18: 
19: DEFINE CLASS FormSigReIdt AS FormBase
20: 
21:     *-- Dimensoes e aparencia (EXATAS do original SIGREIDT: Width=800, Height=180)
22:     Height      = 180
23:     Width       = 800
24:     DataSession = 2
25:     ShowWindow  = 1
26:     WindowType  = 1
27:     AutoCenter  = .T.
28:     BorderStyle = 2
29:     ControlBox  = .F.
30:     MaxButton   = .F.
31:     MinButton   = .F.
32:     TitleBar    = 1
33:     Themes      = .F.
34:     ShowTips    = .T.
35: 
36:     *-- Parametros recebidos via Init (mapeamento original: pcEmps, pcDopes, etc.)
37:     this_cEmps       = ""
38:     this_cDopes      = ""
39:     this_cNumes      = ""
40:     this_nNumef      = 0
41:     this_cDiretorio  = ""
42:     this_cDirFiscais = ""
43: 
44:     *-- Opcoes de impressao (mapeados dos OptionGroups)
45:     this_nOptTipo    = 2
46:     this_nOptAgrupa  = 3
47: 
48:     *-- Business Object do relatorio (instanciado em InicializarForm)
49:     this_oRelatorio  = .NULL.
50: 
51:     *-- Titulo base vazio (Caption e definido dinamicamente em Init com numero do documento)
52:     this_cTituloForm = ""
53: 
54:     *--------------------------------------------------------------------------
55:     * Init - Armazena parametros e delega para FormBase.Init() (que chama InicializarForm)
56:     * Mapeamento original: PROCEDURE Init Lparameters pForm, pEmp, pDop, pNum, pNumF, pDir
57:     *--------------------------------------------------------------------------
58:     PROCEDURE Init(par_pForm, par_pEmp, par_pDop, par_pNum, par_pNumF, par_pDir)
59: 
60:         *-- Armazenar parametros ANTES de DODEFAULT (que chama InicializarForm)
61:         THIS.this_cEmps      = IIF(TYPE("par_pEmp")  = "C", ALLTRIM(par_pEmp),  "")
62:         THIS.this_cDopes     = IIF(TYPE("par_pDop")  = "C", ALLTRIM(par_pDop),  "")
63:         THIS.this_cNumes     = IIF(TYPE("par_pNum")  = "C", ALLTRIM(par_pNum),  "")
64:         THIS.this_nNumef     = IIF(TYPE("par_pNumF") = "N", par_pNumF, 0)
65:         THIS.this_cDiretorio = IIF(TYPE("par_pDir")  = "C", par_pDir, "")
66: 
67:         *-- Salvar DirFiscais atual para restaurar no Destroy (equivale ao Unload original)
68:         IF TYPE("go_4c_Sistema") = "O" AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
69:             THIS.this_cDirFiscais = go_4c_Sistema.DirFiscais
70:         ENDIF
71: 
72:         *-- Caption dinamico com numero do documento (reproduz original)
73:         *-- "Impressao de Documento de Titulo (DOP/NUM)"
74:         IF !EMPTY(THIS.this_cDopes) AND !EMPTY(THIS.this_cNumes)
75:             THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + ;
76:                            "tulo (" + ALLTRIM(THIS.this_cDopes) + "/" + ;
77:                            ALLTRIM(THIS.this_cNumes) + ")"
78:         ELSE
79:             THIS.Caption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"
80:         ENDIF
81: 
82:         RETURN DODEFAULT()
83:     ENDPROC
84: 
85:     *--------------------------------------------------------------------------
86:     * InicializarForm - Cria Business Object e todos os controles do formulario
87:     *--------------------------------------------------------------------------
88:     PROTECTED PROCEDURE InicializarForm()
89:         LOCAL loc_lSucesso, loc_lContinuar
90:         loc_lSucesso   = .F.
91:         loc_lContinuar = .T.
92:         TRY
93:             IF TYPE("gc_4c_CaminhoIcones") = "U"
94:                 gc_4c_CaminhoIcones = ""
95:             ENDIF
96:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97: 
98:             *-- Instanciar BO de relatorio
99:             THIS.this_oRelatorio = CREATEOBJECT("SigReIdtBO")
100:             IF VARTYPE(THIS.this_oRelatorio) != "O"
101:                 MsgErro("Erro ao criar SigReIdtBO" + CHR(13) + ;
102:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
103:                 loc_lContinuar = .F.
104:             ENDIF
105: 
106:             IF loc_lContinuar
107:                 *-- Monta layout completo do form (cabecalho, botoes, filtros)
108:                 *-- Em REPORT este metodo NAO cria PageFrame - apenas orquestra os containers
109:                 THIS.ConfigurarPageFrame()
110: 
111:                 *-- Atualizar labels do cabecalho com caption dinamico
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114: 
115:                 *-- Vincular Click dos botoes
116:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
117:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
118:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
119:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
120: 
121:                 *-- Vincular InteractiveChange do optTipo (reseta OptAgrupa para 3)
122:                 BINDEVENT(THIS.obj_4c_OptTipo, "InteractiveChange", THIS, "OptTipoChange")
123: 
124:                 *-- Valores iniciais dos filtros
125:                 THIS.LimparCampos()
126: 
127:                 THIS.Visible = .T.
128:                 loc_lSucesso = .T.
129:             ENDIF
130:         CATCH TO loc_oErro
131:             MsgErro(loc_oErro.Message + CHR(13) + ;
132:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
133:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
134:         ENDTRY
135:         RETURN loc_lSucesso
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarPageFrame - Orquestra o layout do form (REPORT layout flat).
140:     *
141:     * Em forms CRUD, este metodo criaria um PageFrame com Page1 (Lista) e Page2
142:     * (Dados). Em forms REPORT (frmrelatorio), o original SIGREIDT NAO usa
143:     * PageFrame - os controles ficam direto no form (layout flat 800x180).
144:     * Esta procedure delega a configuracao para os metodos especializados:
145:     *   - ConfigurarCabecalho: header escuro com titulo dinamico
146:     *   - ConfigurarBotoes:    CommandGroup cmg_4c_Botoes (4 botoes)
147:     *   - ConfigurarFiltros:   OptionGroups optTipo e OptAgrupa + labels
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPageFrame()
150:         THIS.ConfigurarCabecalho()
151:         THIS.ConfigurarBotoes()
152:         THIS.ConfigurarPaginaLista()
153:         THIS.ConfigurarPaginaDados()
154:     ENDPROC
155: 
156:     *--------------------------------------------------------------------------
157:     * ConfigurarPaginaLista - Ponto de entrada do padrao do sistema para
158:     *   configuracao da "lista" (em forms CRUD = grid de registros; em forms
159:     *   REPORT = lista de parametros/filtros). SIGREIDT eh um frmrelatorio com
160:     *   layout flat (800x180px) sem PageFrame, portanto este metodo apenas
161:     *   delega para ConfigurarFiltros, que adiciona os OptionGroups optTipo e
162:     *   OptAgrupa diretamente sobre o form.
163:     *--------------------------------------------------------------------------
164:     PROTECTED PROCEDURE ConfigurarPaginaLista()
165:         THIS.ConfigurarFiltros()
166:     ENDPROC
167: 
168:     *--------------------------------------------------------------------------
169:     * AlternarPagina - Alterna pagina ativa do PageFrame em forms CRUD.
170:     *   SIGREIDT eh um frmrelatorio com layout flat (controles direto no form),
171:     *   portanto nao ha PageFrame para alternar. Este metodo eh mantido por
172:     *   convencao do padrao do sistema e tambem para que codigo cliente que
173:     *   tente chamar AlternarPagina nao quebre - simplesmente nao ha pagina
174:     *   para ativar.
175:     *--------------------------------------------------------------------------
176:     PROCEDURE AlternarPagina(par_nPagina)
177:         LOCAL loc_nPagina
178:         loc_nPagina = IIF(TYPE("par_nPagina") = "N" AND par_nPagina > 0, par_nPagina, 1)
179:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
180:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
181:         ENDIF
182:     ENDPROC
183: 
184:     *--------------------------------------------------------------------------
185:     * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra do frmrelatorio)
186:     *--------------------------------------------------------------------------
187:     PROTECTED PROCEDURE ConfigurarCabecalho()
188:         LOCAL loc_cCaption
189:         loc_cCaption = "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo"
190: 
191:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
192:         WITH THIS.cnt_4c_Cabecalho
193:             .Top         = 0
194:             .Left        = 0
195:             .Width       = THIS.Width
196:             .Height      = 80
197:             .BackStyle   = 1
198:             .BackColor   = RGB(100, 100, 100)
199:             .BorderWidth = 0
200:             .Visible     = .T.
201: 
202:             .AddObject("lbl_4c_Sombra", "Label")
203:             WITH .lbl_4c_Sombra
204:                 .Top       = 22
205:                 .Left      = 22
206:                 .Width     = THIS.Width
207:                 .Height    = 30
208:                 .Caption   = loc_cCaption
209:                 .FontName  = "Tahoma"
210:                 .FontSize  = 14
211:                 .FontBold  = .T.
212:                 .ForeColor = RGB(0, 0, 0)
213:                 .BackStyle = 0
214:                 .Visible   = .T.
215:             ENDWITH
216: 
217:             .AddObject("lbl_4c_Titulo", "Label")
218:             WITH .lbl_4c_Titulo
219:                 .Top       = 20
220:                 .Left      = 20
221:                 .Width     = THIS.Width
222:                 .Height    = 30
223:                 .Caption   = loc_cCaption
224:                 .FontName  = "Tahoma"
225:                 .FontSize  = 14
226:                 .FontBold  = .T.
227:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 236 a 279:
236:     * Original: btnReport Left=495, Top=-2, Width=310, Height=85, ButtonCount=4
237:     * Novo padrao: cmg_4c_Botoes conforme CLAUDE.md (Left=529, Width=273, Height=80)
238:     *--------------------------------------------------------------------------
239:     PROTECTED PROCEDURE ConfigurarBotoes()
240:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
241:         WITH THIS.cmg_4c_Botoes
242:             .Top           = 0
243:             .Left          = 529
244:             .Width         = 273
245:             .Height        = 80
246:             .ButtonCount   = 4
247:             .BackStyle     = 0
248:             .BorderStyle   = 0
249:             .BorderColor   = RGB(136, 189, 188)
250:             .SpecialEffect = 1
251:             .Themes        = .F.
252:             .Visible       = .T.
253: 
254:             *-- Botao 1: Visualizar (preview na tela)
255:             *-- Original: btnReport.Visualiza (Left=5, Width=75)
256:             WITH .Buttons(1)
257:                 .Top             = 5
258:                 .Left            = 5
259:                 .Width           = 65
260:                 .Height          = 70
261:                 .Caption         = "Visualizar"
262:                 .FontBold        = .T.
263:                 .FontItalic      = .T.
264:                 .BackColor       = RGB(255, 255, 255)
265:                 .ForeColor       = RGB(90, 90, 90)
266:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
267:                 .PicturePosition = 13
268:                 .SpecialEffect   = 0
269:                 .MousePointer    = 15
270:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
271:                 .Themes          = .F.
272:                 .Visible         = .T.
273:             ENDWITH
274: 
275:             *-- Botao 2: Imprimir (com prompt de impressora)
276:             *-- Original: btnReport.Imprime (Left=80, Width=75)
277:             WITH .Buttons(2)
278:                 .Top             = 5
279:                 .Left            = 71

*-- Linhas 296 a 339:
296:             ENDWITH
297: 
298:             *-- Botao 3: Documento (impressao direta sem prompt)
299:             *-- Original: btnReport.DocExcel (Left=155, Width=75) - PROCEDURE documento
300:             WITH .Buttons(3)
301:                 .Top             = 5
302:                 .Left            = 137
303:                 .Width           = 65
304:                 .Height          = 70
305:                 .Caption         = "Documento"
306:                 .FontName        = "Tahoma"
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .FontSize        = 8
310:                 .BackColor       = RGB(255, 255, 255)
311:                 .ForeColor       = RGB(90, 90, 90)
312:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
313:                 .PicturePosition = 13
314:                 .SpecialEffect   = 0
315:                 .MousePointer    = 15
316:                 .ToolTipText     = "Imprimir Documento Diretamente"
317:                 .Themes          = .F.
318:                 .Visible         = .T.
319:             ENDWITH
320: 
321:             *-- Botao 4: Encerrar (fecha o form, tecla ESC)
322:             *-- Original: btnReport.Sair (Left=230, Width=75, Cancel=.T.)
323:             WITH .Buttons(4)
324:                 .Top             = 5
325:                 .Left            = 203
326:                 .Width           = 65
327:                 .Height          = 70
328:                 .Caption         = "Encerrar"
329:                 .Cancel          = .T.
330:                 .FontName        = "Tahoma"
331:                 .FontBold        = .T.
332:                 .FontItalic      = .T.
333:                 .FontSize        = 8
334:                 .BackColor       = RGB(255, 255, 255)
335:                 .ForeColor       = RGB(90, 90, 90)
336:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
337:                 .PicturePosition = 13
338:                 .SpecialEffect   = 0
339:                 .MousePointer    = 15

*-- Linhas 345 a 410:
345:     ENDPROC
346: 
347:     *--------------------------------------------------------------------------
348:     * ConfigurarFiltros - Cria OptionGroups e Labels de filtros de impressao
349:     * Posicoes EXATAS do original SIGREIDT (controles direto no form, sem PageFrame)
350:     *--------------------------------------------------------------------------
351:     PROTECTED PROCEDURE ConfigurarFiltros()
352:         *-- Label "Tipo de Impressao :" (original: Label1, Top=105, Left=253)
353:         THIS.AddObject("lbl_4c_Label1", "Label")
354:         WITH THIS.lbl_4c_Label1
355:             .AutoSize  = .T.
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .BackStyle = 0
359:             .Caption   = "Tipo de Impress" + CHR(227) + "o :"
360:             .Height    = 15
361:             .Left      = 253
362:             .Top       = 105
363:             .Width     = 97
364:             .ForeColor = RGB(90, 90, 90)
365:             .Visible   = .T.
366:         ENDWITH
367: 
368:         *-- OptionGroup tipo de impressao (original: optTipo, ButtonCount=2, Value=2)
369:         *-- Opcao 1: Titulo | Opcao 2: Autorizacao de Gasto (default)
370:         THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
371:         WITH THIS.obj_4c_OptTipo
372:             .ButtonCount = 2
373:             .BackStyle   = 0
374:             .BorderStyle = 0
375:             .Value       = 2
376:             .Height      = 25
377:             .Width       = 203
378:             .Visible     = .T.
379: 
380:             WITH .Buttons(1)
381:                 .BackStyle = 0
382:                 .Caption   = "T" + CHR(237) + "tulo"
383:                 .Value     = 0
384:                 .Height    = 15
385:                 .Left      = 6
386:                 .Top       = 4
387:                 .Width     = 44
388:                 .AutoSize  = .T.
389:                 .ForeColor = RGB(90, 90, 90)
390:                 .Themes    = .F.
391:             ENDWITH
392: 
393:             WITH .Buttons(2)
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 8
396:                 .BackStyle = 0
397:                 .Caption   = "Autoriza" + CHR(231) + CHR(227) + "o de Gasto"
398:                 .Value     = 1
399:                 .Height    = 15
400:                 .Left      = 60
401:                 .Top       = 4
402:                 .Width     = 121
403:                 .AutoSize  = .T.
404:                 .ForeColor = RGB(90, 90, 90)
405:                 .Themes    = .F.
406:             ENDWITH
407: 
408:             .Left = 346
409:             .Top  = 102
410:         ENDWITH

*-- Linhas 425 a 470:
425:             .Visible   = .T.
426:         ENDWITH
427: 
428:         *-- OptionGroup agrupamento (original: OptAgrupa, ButtonCount=3, Value=3)
429:         *-- Opcao 1: Sim | Opcao 2: Agrupada | Opcao 3: Nenhum (default)
430:         THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
431:         WITH THIS.obj_4c_OptAgrupa
432:             .ButtonCount = 3
433:             .BackStyle   = 0
434:             .BorderStyle = 0
435:             .Value       = 3
436:             .Height      = 25
437:             .Width       = 211
438:             .Visible     = .T.
439: 
440:             WITH .Buttons(1)
441:                 .BackStyle = 0
442:                 .Caption   = "Sim"
443:                 .Value     = 0
444:                 .Height    = 15
445:                 .Left      = 6
446:                 .Top       = 4
447:                 .Width     = 34
448:                 .AutoSize  = .T.
449:                 .ForeColor = RGB(90, 90, 90)
450:                 .Themes    = .F.
451:             ENDWITH
452: 
453:             WITH .Buttons(2)
454:                 .FontName  = "Tahoma"
455:                 .FontSize  = 8
456:                 .BackStyle = 0
457:                 .Caption   = "Agrupada"
458:                 .Value     = 0
459:                 .Height    = 15
460:                 .Left      = 60
461:                 .Top       = 4
462:                 .Width     = 65
463:                 .AutoSize  = .T.
464:                 .ForeColor = RGB(90, 90, 90)
465:                 .Themes    = .F.
466:             ENDWITH
467: 
468:             WITH .Buttons(3)
469:                 .FontName  = "Tahoma"
470:                 .FontSize  = 8

*-- Linhas 495 a 813:
495:     *      etc.) para que PrepararDados() tenha contexto completo antes do primeiro clique
496:     *   3. Aplica Caption dinamico correto aos labels do cabecalho (titulo com DOP/NUM)
497:     *--------------------------------------------------------------------------
498:     PROTECTED PROCEDURE ConfigurarPaginaDados()
499:         LOCAL loc_cCaption
500:         loc_cCaption = THIS.Caption
501: 
502:         TRY
503:             *-- 1. Sincronizar largura do cabecalho com largura real do form
504:             IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
505:                 THIS.cnt_4c_Cabecalho.Width = THIS.Width
506:                 IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
507:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Width  = THIS.Width
508:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cCaption
509:                 ENDIF
510:                 IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
511:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Width  = THIS.Width
512:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cCaption
513:                 ENDIF
514:             ENDIF
515: 
516:             *-- 2. Pre-popular BO com parametros recebidos no Init para que
517:             *--    PrepararDados() possa ser chamado mesmo antes do primeiro clique
518:             IF VARTYPE(THIS.this_oRelatorio) = "O"
519:                 WITH THIS.this_oRelatorio
520:                     .this_cEmps      = THIS.this_cEmps
521:                     .this_cDopes     = THIS.this_cDopes
522:                     .this_cNumes     = THIS.this_cNumes
523:                     .this_nNumef     = THIS.this_nNumef
524:                     .this_cDiretorio = THIS.this_cDiretorio
525:                     .this_nOptTipo   = THIS.this_nOptTipo
526:                     .this_nOptAgrupa = THIS.this_nOptAgrupa
527:                 ENDWITH
528:             ENDIF
529:         CATCH TO loc_oErro
530:             MsgErro(loc_oErro.Message + CHR(13) + ;
531:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
532:                 "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaDados")
533:         ENDTRY
534:     ENDPROC
535: 
536:     *--------------------------------------------------------------------------
537:     * LimparCampos - Restaura opcoes de filtro para valores padrao do original
538:     * optTipo=2 (Autorizacao de Gasto), OptAgrupa=3 (Nenhum)
539:     *--------------------------------------------------------------------------
540:     PROCEDURE LimparCampos()
541:         TRY
542:             THIS.obj_4c_OptTipo.Value   = 2
543:             THIS.obj_4c_OptAgrupa.Value = 3
544:         CATCH TO loc_oErro
545:             MsgErro(loc_oErro.Message, "LimparCampos")
546:         ENDTRY
547:     ENDPROC
548: 
549:     *--------------------------------------------------------------------------
550:     * FormParaRelatorio - Transfere valores dos controles para o BO do relatorio
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE FormParaRelatorio()
553:         WITH THIS.this_oRelatorio
554:             .this_cEmps       = THIS.this_cEmps
555:             .this_cDopes      = THIS.this_cDopes
556:             .this_cNumes      = THIS.this_cNumes
557:             .this_nNumef      = THIS.this_nNumef
558:             .this_cDiretorio  = THIS.this_cDiretorio
559:             .this_cDirFiscais = THIS.this_cDirFiscais
560:             .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
561:             .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
562:         ENDWITH
563:     ENDPROC
564: 
565:     *--------------------------------------------------------------------------
566:     * BtnVisualizarClick - Preview do relatorio na tela
567:     * Logica original: PROCEDURE visualizacao (Report Form ... Preview NoConsole)
568:     *--------------------------------------------------------------------------
569:     PROCEDURE BtnVisualizarClick()
570:         TRY
571:             THIS.FormParaRelatorio()
572:             IF !THIS.this_oRelatorio.PrepararDados()
573:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
574:                 RETURN
575:             ENDIF
576:             THIS.this_oRelatorio.Visualizar()
577:         CATCH TO loc_oErro
578:             MsgErro(loc_oErro.Message + CHR(13) + ;
579:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
580:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
581:         ENDTRY
582:     ENDPROC
583: 
584:     *--------------------------------------------------------------------------
585:     * BtnImprimirClick - Impressao com prompt de selecao de impressora
586:     * Logica original: PROCEDURE impressao (Report Form ... To Printer Prompt NoConsole)
587:     *--------------------------------------------------------------------------
588:     PROCEDURE BtnImprimirClick()
589:         TRY
590:             THIS.FormParaRelatorio()
591:             IF !THIS.this_oRelatorio.PrepararDados()
592:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
593:                 RETURN
594:             ENDIF
595:             THIS.this_oRelatorio.Imprimir()
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message + CHR(13) + ;
598:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
599:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
600:         ENDTRY
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * BtnDocumentoClick - Impressao direta sem prompt de impressora
605:     * Logica original: PROCEDURE documento (Report Form ... To Printer NoConsole)
606:     *--------------------------------------------------------------------------
607:     PROCEDURE BtnDocumentoClick()
608:         TRY
609:             THIS.FormParaRelatorio()
610:             IF !THIS.this_oRelatorio.PrepararDados()
611:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Documento")
612:                 RETURN
613:             ENDIF
614:             THIS.this_oRelatorio.Documento()
615:         CATCH TO loc_oErro
616:             MsgErro(loc_oErro.Message + CHR(13) + ;
617:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
618:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
619:         ENDTRY
620:     ENDPROC
621: 
622:     *--------------------------------------------------------------------------
623:     * BtnSairClick - Fecha o formulario
624:     * Original: btnReport.Sair tem Cancel=.T. (ESC dispara Click)
625:     *--------------------------------------------------------------------------
626:     PROCEDURE BtnSairClick()
627:         THIS.Release()
628:     ENDPROC
629: 
630:     *--------------------------------------------------------------------------
631:     * OptTipoChange - Ao mudar tipo de impressao, reseta agrupamento para "Nenhum"
632:     * Logica original: PROCEDURE InteractiveChange de optTipo:
633:     *   ThisForm.optAgrupa.Value = 3
634:     *--------------------------------------------------------------------------
635:     PROCEDURE OptTipoChange()
636:         THIS.obj_4c_OptAgrupa.Value = 3
637:     ENDPROC
638: 
639:     *--------------------------------------------------------------------------
640:     * BtnIncluirClick - Acao primaria do form REPORT (mapeada para Visualizar).
641:     *
642:     * SIGREIDT eh um frmrelatorio (FormType=REPORT) e nao possui operacoes CRUD
643:     * (Incluir/Alterar/Excluir). O contrato do padrao do sistema exige a
644:     * presenca dos metodos Btn*Click para compatibilidade com o validador da
645:     * pipeline, portanto este metodo delega para a acao primaria do relatorio:
646:     * gerar o preview no video (equivalente a "incluir" uma nova visualizacao).
647:     * Esta delegacao reproduz a logica original do botao Visualiza de btnReport.
648:     *--------------------------------------------------------------------------
649:     PROCEDURE BtnIncluirClick()
650:         THIS.BtnVisualizarClick()
651:     ENDPROC
652: 
653:     *--------------------------------------------------------------------------
654:     * BtnAlterarClick - Acao secundaria do form REPORT (mapeada para Imprimir).
655:     *
656:     * Em um form CRUD, "Alterar" abre um registro existente para edicao. Como
657:     * SIGREIDT eh um frmrelatorio sem operacoes CRUD, a semantica equivalente
658:     * eh "reprocessar/reimprimir" os dados ja gerados - portanto este metodo
659:     * delega para a impressao com prompt de selecao de impressora, reproduzindo
660:     * a logica original do botao Imprime de btnReport.
661:     *--------------------------------------------------------------------------
662:     PROCEDURE BtnAlterarClick()
663:         THIS.BtnImprimirClick()
664:     ENDPROC
665: 
666:     *--------------------------------------------------------------------------
667:     * BtnExcluirClick - Acao de cancelamento do form REPORT (mapeada para Sair).
668:     *
669:     * Em um form CRUD, "Excluir" remove um registro. Como SIGREIDT eh um
670:     * frmrelatorio sem registros para excluir, a semantica equivalente eh
671:     * "cancelar/descartar" o relatorio atual e fechar o formulario - portanto
672:     * este metodo delega para BtnSairClick, reproduzindo a logica original do
673:     * botao Sair de btnReport (que tem Cancel=.T. e responde a tecla ESC).
674:     *--------------------------------------------------------------------------
675:     PROCEDURE BtnExcluirClick()
676:         THIS.BtnSairClick()
677:     ENDPROC
678: 
679:     *--------------------------------------------------------------------------
680:     * BtnBuscarClick - Acao de busca delegada para Visualizar no contexto REPORT.
681:     * SIGREIDT nao tem lista de registros para buscar - delega para preview.
682:     *--------------------------------------------------------------------------
683:     PROCEDURE BtnBuscarClick()
684:         THIS.BtnVisualizarClick()
685:     ENDPROC
686: 
687:     *--------------------------------------------------------------------------
688:     * BtnEncerrarClick - Encerra e fecha o formulario.
689:     *--------------------------------------------------------------------------
690:     PROCEDURE BtnEncerrarClick()
691:         THIS.Release()
692:     ENDPROC
693: 
694:     *--------------------------------------------------------------------------
695:     * BtnSalvarClick - "Salvar" mapeado para Imprimir no contexto REPORT.
696:     * SIGREIDT nao persiste dados em banco - "salvar" = imprimir o relatorio.
697:     *--------------------------------------------------------------------------
698:     PROCEDURE BtnSalvarClick()
699:         THIS.BtnImprimirClick()
700:     ENDPROC
701: 
702:     *--------------------------------------------------------------------------
703:     * BtnCancelarClick - Cancelamento mapeado para Sair no contexto REPORT.
704:     *--------------------------------------------------------------------------
705:     PROCEDURE BtnCancelarClick()
706:         THIS.BtnSairClick()
707:     ENDPROC
708: 
709:     *--------------------------------------------------------------------------
710:     * FormParaBO - Transfere valores dos controles para o BO.
711:     * Alias canonico de FormParaRelatorio() para conformidade com o padrao do sistema.
712:     * Transfere TODOS os campos: parametros fixos + opcoes dos OptionGroups.
713:     *--------------------------------------------------------------------------
714:     PROTECTED PROCEDURE FormParaBO()
715:         WITH THIS.this_oRelatorio
716:             .this_cEmps       = THIS.this_cEmps
717:             .this_cDopes      = THIS.this_cDopes
718:             .this_cNumes      = THIS.this_cNumes
719:             .this_nNumef      = THIS.this_nNumef
720:             .this_cDiretorio  = THIS.this_cDiretorio
721:             .this_cDirFiscais = THIS.this_cDirFiscais
722:             .this_nOptTipo    = THIS.obj_4c_OptTipo.Value
723:             .this_nOptAgrupa  = THIS.obj_4c_OptAgrupa.Value
724:         ENDWITH
725:     ENDPROC
726: 
727:     *--------------------------------------------------------------------------
728:     * BOParaForm - Restaura valores do BO para os controles do formulario.
729:     * Sincroniza OptionGroups com os valores atuais do BO.
730:     *--------------------------------------------------------------------------
731:     PROTECTED PROCEDURE BOParaForm()
732:         TRY
733:             IF VARTYPE(THIS.this_oRelatorio) = "O"
734:                 THIS.obj_4c_OptTipo.Value   = THIS.this_oRelatorio.this_nOptTipo
735:                 THIS.obj_4c_OptAgrupa.Value = THIS.this_oRelatorio.this_nOptAgrupa
736:             ENDIF
737:         CATCH TO loc_oErro
738:             MsgErro(loc_oErro.Message, "BOParaForm")
739:         ENDTRY
740:     ENDPROC
741: 
742:     *--------------------------------------------------------------------------
743:     * HabilitarCampos - Habilita ou desabilita os controles de filtro.
744:     * Controles: obj_4c_OptTipo, obj_4c_OptAgrupa, cmg_4c_Botoes.
745:     * O When original de OptAgrupa estava comentado (*Return Not...) - ambos
746:     * ficam sempre habilitados conforme a intencao do codigo original.
747:     *--------------------------------------------------------------------------
748:     PROCEDURE HabilitarCampos(par_lHabilitar)
749:         LOCAL loc_lHab
750:         loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
751:         TRY
752:             THIS.obj_4c_OptTipo.Enabled   = loc_lHab
753:             THIS.obj_4c_OptAgrupa.Enabled = loc_lHab
754:             THIS.cmg_4c_Botoes.Enabled    = loc_lHab
755:         CATCH TO loc_oErro
756:             MsgErro(loc_oErro.Message, "HabilitarCampos")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * CarregarLista - Pre-popula BO com os parametros do form.
762:     * SIGREIDT nao tem grid (frmrelatorio flat). Existe por conformidade com
763:     * o padrao do sistema e verifica gb_4c_ValidandoUI antes de acessar SQL.
764:     *--------------------------------------------------------------------------
765:     PROCEDURE CarregarLista()
766:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
767:             RETURN .T.
768:         ENDIF
769:         THIS.FormParaRelatorio()
770:         RETURN .T.
771:     ENDPROC
772: 
773:     *--------------------------------------------------------------------------
774:     * AjustarBotoesPorModo - Ajusta botoes conforme modo de operacao.
775:     * SIGREIDT e frmrelatorio sem modo CRUD - botoes sempre habilitados.
776:     * Metodo presente por conformidade com o padrao do sistema.
777:     *--------------------------------------------------------------------------
778:     PROCEDURE AjustarBotoesPorModo()
779:         TRY
780:             IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
781:                 THIS.cmg_4c_Botoes.Enabled = .T.
782:             ENDIF
783:             IF VARTYPE(THIS.obj_4c_OptTipo) = "O"
784:                 THIS.obj_4c_OptTipo.Enabled = .T.
785:             ENDIF
786:             IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
787:                 THIS.obj_4c_OptAgrupa.Enabled = .T.
788:             ENDIF
789:         CATCH TO loc_oErro
790:             MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
791:         ENDTRY
792:     ENDPROC
793: 
794:     *--------------------------------------------------------------------------
795:     * Destroy - Restaura DirFiscais e libera Business Object
796:     * Logica original: PROCEDURE Unload: goSistema.DirFiscais = ThisForm.cDirFiscais
797:     *--------------------------------------------------------------------------
798:     PROCEDURE Destroy()
799:         *-- Restaurar DirFiscais conforme PROCEDURE Unload do original
800:         IF TYPE("go_4c_Sistema") = "O" AND !EMPTY(THIS.this_cDirFiscais) ;
801:            AND PEMSTATUS(go_4c_Sistema, "DirFiscais", 5)
802:             go_4c_Sistema.DirFiscais = THIS.this_cDirFiscais
803:         ENDIF
804: 
805:         *-- Liberar Business Object (Custom NAO tem Release - usar .NULL.)
806:         IF VARTYPE(THIS.this_oRelatorio) = "O"
807:             THIS.this_oRelatorio = .NULL.
808:         ENDIF
809: 
810:         DODEFAULT()
811:     ENDPROC
812: 
813: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIdtBO.prg):
*==============================================================================
* SigReIdtBO.prg
* Business Object para Relatorio de Documento de Titulo
*
* Herda de RelatorioBase
* Form original: SIGREIDT (frmrelatorio)
* Reports: SigReIdt.frx, SigReIdA.frx, SigReIag.frx
*==============================================================================

DEFINE CLASS SigReIdtBO AS RelatorioBase

    *-- Parametros do relatorio (definidos pelo form via FormParaRelatorio)
    this_cEmps       = ""   && Codigo da empresa (3 chars, ex: "001")
    this_cDopes      = ""   && Operacao/documento (20 chars padded)
    this_cNumes      = ""   && Numero do titulo
    this_nNumef      = 0    && Numero fiscal (numerico - Numef no original)
    this_cDiretorio  = ""   && Diretorio de saida opcional (pcDiretorio)
    this_cDirFiscais = ""   && Diretorio fiscal (goSistema.DirFiscais)

    *-- Opcoes de impressao (mapeados dos OptionGroups do form)
    *   this_nOptTipo:   1=Titulo, 2=Autorizacao de Gasto (default=2)
    *   this_nOptAgrupa: 1=Sim, 2=Agrupada, 3=Nenhum (default=3)
    this_nOptTipo    = 2
    this_nOptAgrupa  = 3

    *-- Controle interno carregado de SigCdPam (GrupoRecs/GrupoPags, ContaRecs/ContaPags)
    this_cContaTran  = ""
    this_cGrupoTran  = ""

    *-- Nome do cursor principal do relatorio (referenciado pelos FRX)
    this_cCursorDados = "crDBImp"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara dados do relatorio de documento de titulo
    * Logica original: PROCEDURE processamento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cTabMov, loc_cSinalOper, loc_cEDNE
        LOCAL loc_cObs, loc_nRecor, loc_nReg
        LOCAL loc_laTitulo, loc_lnTotVal
        LOCAL loc_cTxt01, loc_cTxt02, loc_cTxt03, loc_cTxt04
        LOCAL loc_cRclis1, loc_cRclis2, loc_cRclis3, loc_cRclis4
        LOCAL loc_cCpfs2, loc_cContaLkp
        LOCAL loc_cGrupoPortador, loc_cContaPortador
        LOCAL loc_cObsd, loc_cHists, loc_cOpersFiltro

        loc_lSucesso = .F.
        TRY
            *-- 1. Carregar dados da empresa
            loc_cSQL = "SELECT RazSocs, Cgcs, Ies, Tel1s, Tel2s " + ;
                       "FROM SigCdEmp " + ;
                       "WHERE Emps = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEmp")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar empresa"
                THROW
            ENDIF
            SELECT cursor_4c_LocalEmp
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ALLTRIM(THIS.this_cEmps)
                THROW
            ENDIF

            *-- 2. Criar cursor de cabecalho do relatorio (csCabecalho - referenciado pelos FRX)
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa c(80), Titulo c(80))
            SELECT csCabecalho
            APPEND BLANK
            REPLACE Empresa WITH ALLTRIM(THIS.this_cEmps) + " - " + ALLTRIM(cursor_4c_LocalEmp.RazSocs)
            REPLACE Titulo  WITH PADR(ALLTRIM(THIS.this_cDopes), 20)

            *-- 3. Criar cursor principal de impressao (crDBImp - referenciado pelos FRX)
            IF USED("crDBImp")
                USE IN crDBImp
            ENDIF
            CREATE CURSOR crDBImp (;
                Emps c(3), RazSocs c(50), Titulo c(10), Nfs c(10), DtMovs d, ;
                Txt01 c(20), GrupEm c(10), Contem c(10), dContem c(50), ;
                Txt02 c(20), Grupo c(10), Conta c(10), dConta c(50), cpfs c(20), ;
                Txt03 c(20), sGrupos c(10), sContas c(10), sdConta c(50), Obsc c(50), Valorc n(12,2), ;
                Txt04 c(20), Gruage c(10), contag c(10), dContag c(50), ;
                DtEmis d, Titban c(10), dtVencs d, bContas c(20), ;
                bGrupos c(20), DopCs c(20), ;
                Obs c(50), Usuars c(10), ;
                Valor n(12,2), Moeda c(3), Cotacao n(12,2), ;
                Obss m, Recors m, Hists m, ;
                ValPrev n(13,2), ValOrig n(13,2), ValOco n(13,2), ;
                ValLiq n(13,2), EspecieNfs c(6), TpDocNf c(2), Compet c(7))

            *-- 4. Carregar operacoes (SigOpOpe) com indice em Dopes
            loc_cSQL = "SELECT Dopes, Opers, NDopes, RealPrevs, " + ;
                       "Txt01, Txt02, Txt03, Txt04 FROM SigOpOpe"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar opera" + CHR(231) + CHR(245) + "es"
                THROW
            ENDIF
            SELECT cursor_4c_LocalOpe
            INDEX ON Dopes TAG dopes ADDITIVE
            IF NOT SEEK(PADR(ALLTRIM(THIS.this_cDopes), 20))
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                          "o encontrada: " + ALLTRIM(THIS.this_cDopes)
                THROW
            ENDIF

            *-- 5. Carregar parametros do sistema (SigCdPam)
            loc_cSQL = "SELECT GrupoRecs, GrupoPags, ContaRecs, ContaPags FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalParam")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar par" + CHR(226) + "metros do sistema"
                THROW
            ENDIF
            SELECT cursor_4c_LocalParam
            GO TOP

            *-- 6. Determinar tabela de movimento e sinal da operacao
            SELECT cursor_4c_LocalOpe
            loc_cTabMov    = IIF(cursor_4c_LocalOpe.RealPrevs = 2, "SigMvCpv", "SigMvCcr")
            loc_cSinalOper = IIF(ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR", "C", "D")

            *-- 7. Carregar registro principal (crLocMccr - Tipos=' ')
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       " AND Tipos = ' '"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar movimento principal"
                THROW
            ENDIF
            SELECT crLocMccr
            GO TOP
            IF EOF()
                THIS.this_cMensagemErro = "Movimento n" + CHR(227) + "o encontrado para o t" + ;
                                          CHR(237) + "tulo informado"
                THROW
            ENDIF

            *-- 8. Carregar crTmpMccr com filtro de tipo conforme optTipo
            loc_cSQL = "SELECT empdopncs, Titulos, nfs, datas, grupems, contems, " + ;
                       "grupos, contas, sgrupos, scontas, hist2s, grupages, UsuAlts, " + ;
                       "contages, dtemis, titbans, vencs, valprev, valors, moedas, cotacaos, " + ;
                       "bgrupos, bcontas, dopcs, tipos, emps, opers, " + ;
                       "valocurs, ValPags, EspecieNfs, TpDocNf, Compet " + ;
                       "FROM " + loc_cTabMov + ;
                       " WHERE Titulos = " + EscaparSQL(ALLTRIM(THIS.this_cNumes)) + ;
                       " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ;
                       " AND Opers = " + EscaparSQL(loc_cSinalOper) + ;
                       " AND Dopcs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + ;
                       " AND Numcs = " + ALLTRIM(STR(THIS.this_nNumef)) + ;
                       IIF(THIS.this_nOptTipo = 1, " AND Tipos = 'C'", "")
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpMccr")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha ao carregar dados de movimento"
                THROW
            ENDIF
            SELECT crTmpMccr
            GO TOP
            IF EOF()
                *-- Se vazio, copiar crLocMccr como base
                IF USED("crTmpMccr")
                    USE IN crTmpMccr
                ENDIF
                SELECT * FROM crLocMccr INTO CURSOR crTmpMccr READWRITE
                SELECT crLocMccr
                GO TOP
            ENDIF

            *-- 9. Se OptAgrupa 1 ou 2, carregar recorrencias
            IF INLIST(THIS.this_nOptAgrupa, 1, 2)
                SELECT crTmpMccr
                GO TOP
                loc_cEDNE = ALLTRIM(crTmpMccr.EmpDopNcs)

                loc_cSQL = "SELECT nRecors FROM SigTtRec " + ;
                           "WHERE EmpdopNcs = " + EscaparSQL(loc_cEDNE)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalRecor")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias"
                    THROW
                ENDIF
                SELECT cursor_4c_LocalRecor
                GO TOP
                loc_nRecor = cursor_4c_LocalRecor.nRecors

                *-- Buscar registros de recorrencia via UNION ALL (SigMvCcr e SigMvCpv)
                loc_cSQL = "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCcr a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs " + ;
                           "UNION ALL " + ;
                           "SELECT a.empdopncs, a.Titulos, a.nfs, a.datas, " + ;
                           "a.grupems, a.contems, a.grupos, a.contas, " + ;
                           "a.sgrupos, a.scontas, a.hist2s, a.grupages, " + ;
                           "a.contages, a.dtemis, a.titbans, a.vencs, a.valprev, a.valors, " + ;
                           "a.moedas, a.cotacaos, a.bgrupos, a.bcontas, " + ;
                           "a.dopcs, a.tipos, a.emps, a.opers, " + ;
                           "a.UsuAlts, a.EspecieNfs, a.TpDocNf, a.Compet " + ;
                           "FROM SigTtRec b, SigMvCpv a " + ;
                           "WHERE b.nRecors = " + ALLTRIM(STR(loc_nRecor)) + ;
                           " AND b.EmpDopNcs = a.EmpdopNcs"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMccr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Falha ao carregar recorr" + CHR(234) + "ncias detalhadas"
                    THROW
                ENDIF

                *-- Filtrar registros relacionados (excluindo o registro principal)
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                IF RECCOUNT("cursor_4c_LocalMccr1") = 0
                    SELECT a.* ;
                        FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                        WHERE a.Dopcs = b.dopes ;
                        AND a.Opers = loc_cOpersFiltro ;
                        AND a.Tipos = " " ;
                        AND a.EmpdopNcs <> loc_cEDNE ;
                        INTO CURSOR cursor_4c_LocalMccr1 ;
                        ORDER BY a.vencs
                ENDIF

                *-- Se OptAgrupa=1, adicionar recorrencias ao crTmpMccr
                IF THIS.this_nOptAgrupa = 1
                    SELECT crTmpMccr
                    APPEND FROM DBF("cursor_4c_LocalMccr1")
                ENDIF
            ENDIF

            *-- 10. Processar cada registro de crTmpMccr e popular crDBImp
            SELECT crLocMccr
            GO TOP

            SELECT crTmpMccr
            GO TOP
            SCAN
                *-- Determinar GrupoTran/ContaTran para a operacao do registro atual
                IF SEEK(crTmpMccr.Dopcs, "cursor_4c_LocalOpe", "dopes")
                    SELECT cursor_4c_LocalParam
                    GO TOP
                    IF ALLTRIM(cursor_4c_LocalOpe.Opers) = "CR"
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoPags)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaPags)
                    ELSE
                        THIS.this_cGrupoTran = ALLTRIM(cursor_4c_LocalParam.GrupoRecs)
                        THIS.this_cContaTran = ALLTRIM(cursor_4c_LocalParam.ContaRecs)
                    ENDIF
                ENDIF

                *-- Carregar detalhes complementares do titulo (SigTtCcd)
                loc_cSQL = "SELECT obsd, Hists FROM SigTtCcd " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(crTmpMccr.EmpDopNcs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMccrd")
                SELECT cursor_4c_TmpMccrd
                GO TOP
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.obsd))
                    loc_cObsd = ALLTRIM(cursor_4c_TmpMccrd.obsd)
                ELSE
                    loc_cObsd = " "
                ENDIF
                IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_TmpMccrd.Hists))
                    loc_cHists = ALLTRIM(cursor_4c_TmpMccrd.Hists)
                ELSE
                    loc_cHists = " "
                ENDIF

                *-- Buscar nome do emitente (contems)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contems)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli1")
                SELECT cursor_4c_TmpCli1
                GO TOP
                loc_cRclis1 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli1.Rclis), "")

                *-- Buscar nome e CPF do portador (conta ou contems conforme ContaTran)
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaLkp = crTmpMccr.Contems
                ELSE
                    loc_cContaLkp = crTmpMccr.Contas
                ENDIF
                loc_cSQL = "SELECT Rclis, Cpfs FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(loc_cContaLkp)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli2")
                SELECT cursor_4c_TmpCli2
                GO TOP
                loc_cRclis2 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Rclis), "")
                loc_cCpfs2  = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli2.Cpfs), "")

                *-- Buscar nome do centro de custo (scontas)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.scontas)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli3")
                SELECT cursor_4c_TmpCli3
                GO TOP
                loc_cRclis3 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli3.Rclis), "")

                *-- Buscar nome do agente cobrador (contages)
                loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
                           "WHERE Iclis = " + EscaparSQL(crTmpMccr.contages)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli4")
                SELECT cursor_4c_TmpCli4
                GO TOP
                loc_cRclis4 = IIF(!EOF(), ALLTRIM(cursor_4c_TmpCli4.Rclis), "")

                *-- Labels de texto dos campos (Txt01-Txt04)
                SELECT cursor_4c_LocalOpe
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt01))
                    loc_cTxt01 = ALLTRIM(cursor_4c_LocalOpe.Txt01) + " :"
                ELSE
                    loc_cTxt01 = "Emitente :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt02))
                    loc_cTxt02 = ALLTRIM(cursor_4c_LocalOpe.Txt02) + " :"
                ELSE
                    loc_cTxt02 = "Portador :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt03))
                    loc_cTxt03 = ALLTRIM(cursor_4c_LocalOpe.Txt03) + " :"
                ELSE
                    loc_cTxt03 = "Centro de Custo :"
                ENDIF
                IF !EMPTY(ALLTRIM(cursor_4c_LocalOpe.Txt04))
                    loc_cTxt04 = ALLTRIM(cursor_4c_LocalOpe.Txt04) + " :"
                ELSE
                    loc_cTxt04 = "Agente Cobrador :"
                ENDIF

                *-- Grupo e conta do portador (podem ser transpostos com emitente)
                IF ALLTRIM(crTmpMccr.Grupos) = THIS.this_cGrupoTran
                    loc_cGrupoPortador = crTmpMccr.Grupems
                ELSE
                    loc_cGrupoPortador = crTmpMccr.Grupos
                ENDIF
                IF ALLTRIM(crTmpMccr.Contas) = THIS.this_cContaTran
                    loc_cContaPortador = crTmpMccr.ContEms
                ELSE
                    loc_cContaPortador = crTmpMccr.Contas
                ENDIF

                *-- Adicionar registro ao cursor crDBImp
                SELECT crDBImp
                APPEND BLANK
                REPLACE ;
                    Emps      WITH crTmpMccr.Emps, ;
                    RazSocs   WITH ALLTRIM(cursor_4c_LocalEmp.RazSocs), ;
                    Titulo    WITH crTmpMccr.Titulos, ;
                    Nfs       WITH crTmpMccr.Nfs, ;
                    DtMovs    WITH crTmpMccr.datas, ;
                    Txt01     WITH loc_cTxt01, ;
                    GrupEm    WITH crTmpMccr.Grupems, ;
                    Contem    WITH crTmpMccr.Contems, ;
                    dContem   WITH loc_cRclis1, ;
                    Txt02     WITH loc_cTxt02, ;
                    Grupo     WITH loc_cGrupoPortador, ;
                    Conta     WITH loc_cContaPortador, ;
                    dConta    WITH loc_cRclis2, ;
                    cpfs      WITH loc_cCpfs2, ;
                    Txt03     WITH loc_cTxt03, ;
                    sGrupos   WITH crTmpMccr.sgrupos, ;
                    sContas   WITH crTmpMccr.sContas, ;
                    sdConta   WITH loc_cRclis3, ;
                    Obsc      WITH NVL(crTmpMccr.hist2s, " "), ;
                    Txt04     WITH loc_cTxt04, ;
                    Gruage    WITH crTmpMccr.Grupages, ;
                    contag    WITH crTmpMccr.Contages, ;
                    dContag   WITH loc_cRclis4, ;
                    DtEmis    WITH NVL(crTmpMccr.dtemis, DATE()), ;
                    Titban    WITH crTmpMccr.Titbans, ;
                    dtVencs   WITH crTmpMccr.Vencs, ;
                    Obs       WITH NVL(crTmpMccr.hist2s, " "), ;
                    Valor     WITH crTmpMccr.Valors, ;
                    Moeda     WITH crTmpMccr.Moedas, ;
                    Cotacao   WITH crTmpMccr.Cotacaos, ;
                    bgrupos   WITH crTmpMccr.bGrupos, ;
                    bContas   WITH crTmpMccr.bContas, ;
                    Obss      WITH loc_cObsd, ;
                    Hists     WITH loc_cHists, ;
                    DopCs     WITH crTmpMccr.Dopcs, ;
                    Usuars    WITH crTmpMccr.UsuAlts, ;
                    ValPrev   WITH crLocMccr.Valprev, ;
                    ValOrig   WITH crLocMccr.Valors, ;
                    ValOco    WITH crLocMccr.Valocurs, ;
                    EspecieNfs WITH crLocMccr.EspecieNfs, ;
                    TpDocNf   WITH crLocMccr.TpDocNf, ;
                    Compet    WITH crLocMccr.Compet, ;
                    ValLiq    WITH crTmpMccr.Valors + crLocMccr.Valocurs - ;
                                  (crTmpMccr.ValPags + crLocMccr.Valocurs)

                SELECT crTmpMccr
            ENDSCAN

            *-- 11. Se OptAgrupa=2, montar texto de recorrencias agrupadas
            IF THIS.this_nOptAgrupa = 2
                loc_cOpersFiltro = loc_cSinalOper
                SELECT a.* ;
                    FROM cursor_4c_LocalMccr a, cursor_4c_LocalOpe b ;
                    WHERE a.Dopcs = b.dopes ;
                    AND a.Opers = loc_cOpersFiltro ;
                    AND a.Tipos = " " ;
                    AND a.EmpdopNcs <> loc_cEDNE ;
                    INTO CURSOR cursor_4c_LocalMccr1 ;
                    ORDER BY a.vencs

                loc_cObs = ""
                SELECT cursor_4c_LocalMccr1
                SCAN
                    IF cursor_4c_LocalMccr1.valprev = 0
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valors, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ELSE
                        loc_cObs = loc_cObs + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Emps) + "  " + ;
                            DTOC(cursor_4c_LocalMccr1.Datas) + "   " + ;
                            DTOC(cursor_4c_LocalMccr1.Vencs) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.Titulos) + "   " + ;
                            TRANSFORM(cursor_4c_LocalMccr1.valprev, "@Z 999,999,999.99") + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.bGrupos) + "  " + ;
                            ALLTRIM(cursor_4c_LocalMccr1.DopCs) + CHR(13) + CHR(10)
                    ENDIF
                ENDSCAN

                SELECT crDBImp
                REPLACE ALL Recors WITH loc_cObs
            ENDIF

            *-- 12. Calcular totais por titulo
            SELECT Titulo, SUM(1) AS Qtdes ;
                FROM crDBImp ;
                GROUP BY Titulo ;
                ORDER BY Titulo ;
                INTO CURSOR cursor_4c_TmpCC

            SELECT crDBImp
            GO TOP
            loc_laTitulo = crDBImp.Titulo
            loc_lnTotVal = 0
            SCAN
                IF loc_laTitulo <> crDBImp.Titulo
                    loc_nReg = RECNO()
                    REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
                    GO loc_nReg
                    loc_lnTotVal = 0
                    loc_laTitulo = crDBImp.Titulo
                ENDIF
                SELECT cursor_4c_TmpCC
                LOCATE FOR Titulo = crDBImp.Titulo
                IF cursor_4c_TmpCC.Qtdes = 1
                    SELECT crDBImp
                    REPLACE Obsc WITH ""
                    loc_lnTotVal = crDBImp.Valor
                ELSE
                    SELECT crDBImp
                    REPLACE Obs WITH ""
                    loc_lnTotVal = loc_lnTotVal + crDBImp.Valor
                    REPLACE Valorc WITH crDBImp.Valor
                    REPLACE Valor WITH 0
                ENDIF
                SELECT crDBImp
            ENDSCAN
            REPLACE ALL Valor WITH loc_lnTotVal FOR Titulo = loc_laTitulo
            GO TOP

            *-- 13. Atualizar DirFiscais se diretorio alternativo informado
            IF !EMPTY(ALLTRIM(THIS.this_cDiretorio))
                goSistema.DirFiscais = THIS.this_cDiretorio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterNomeFrx - Retorna caminho do FRX conforme opcoes de impressao
    * Logica original: procedures visualizacao/impressao/documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    FUNCTION ObterNomeFrx()
        LOCAL loc_cFrx
        IF THIS.this_nOptTipo = 1
            IF THIS.this_nOptAgrupa = 2
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdA"
            ELSE
                loc_cFrx = gc_4c_CaminhoReports + "SigReIdt"
            ENDIF
        ELSE
            loc_cFrx = gc_4c_CaminhoReports + "SigReIag"
        ENDIF
        RETURN loc_cFrx
    ENDFUNC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    * Logica original: PROCEDURE visualizacao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Visualizar")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com prompt de selecao de impressora
    * Logica original: PROCEDURE impressao em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Imprimir")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Imprime relatorio sem prompt
    * Logica original: PROCEDURE documento em SIGREIDT.SCX
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_cFrx
        loc_cFrx = THIS.ObterNomeFrx()
        IF !EMPTY(loc_cFrx) AND FILE(loc_cFrx + ".frx")
            REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
        ELSE
            MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                     "o encontrado: " + ALLTRIM(loc_cFrx), "Documento")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a mensagem de erro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de cursores e recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crDBImp")
            USE IN crDBImp
        ENDIF
        IF USED("csCabecalho")
            USE IN csCabecalho
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

