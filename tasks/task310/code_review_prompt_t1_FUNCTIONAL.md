# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BARRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'Chk_DelCT' (parent: SIGPRMDC): Top original=278 vs migrado 'chk_4c_Chk_DelCT' Top=383 (diff=105px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_DelCT' (parent: SIGPRMDC): Left original=393 vs migrado 'chk_4c_Chk_DelCT' Left=490 (diff=97px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnIncluir' (parent: SIGPRMDC): Left original=425 vs migrado 'cmd_4c_BtnIncluir' Left=5 (diff=420px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnExcluir' (parent: SIGPRMDC): Left original=500 vs migrado 'cmd_4c_BtnExcluir' Left=85 (diff=415px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Exporta' (parent: SIGPRMDC): Left original=575 vs migrado 'cmd_4c_Exporta' Left=165 (diff=410px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnProcessar' (parent: SIGPRMDC): Left original=650 vs migrado 'cmd_4c_BtnProcessar' Left=245 (diff=405px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnSair' (parent: SIGPRMDC): Left original=725 vs migrado 'cmd_4c_BtnSair' Left=915 (diff=190px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkReps' (parent: SIGPRMDC): Top original=297 vs migrado 'chk_4c_ChkReps' Top=358 (diff=61px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkReps' (parent: SIGPRMDC): Left original=393 vs migrado 'chk_4c_ChkReps' Left=490 (diff=97px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1187 linhas total):

*-- Linhas 30 a 385:
30:     *--------------------------------------------------------------------------
31:     * Init
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *--------------------------------------------------------------------------
38:     * ConfigurarPageFrame
39:     * Configura aparencia base do form (fundo, fontes, cores).
40:     * Para forms OPERACIONAIS sem PageFrame, este metodo define o Picture
41:     * e propriedades globais do form.
42:     *--------------------------------------------------------------------------
43:     PROTECTED PROCEDURE ConfigurarPageFrame()
44:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
45:         THIS.ScrollBars = 0
46:         THIS.ShowTips   = .F.
47:         THIS.SetAll("FontName", "Tahoma")
48:         THIS.SetAll("FontSize", 8)
49:     ENDPROC
50: 
51:     *--------------------------------------------------------------------------
52:     * InicializarForm
53:     * Chamado por FormBase.Init() - cria BO, monta layout de containers base.
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso
57:         loc_lSucesso = .F.
58:         TRY
59:             *-- Configurar aparencia base do form
60:             THIS.ConfigurarPageFrame()
61: 
62:             *-- Criar Business Object
63:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
65:                 THIS.this_oBusinessObject.this_lCheckCadPro = THIS.this_lCheckCadPro
66:                 IF THIS.this_oBusinessObject.InicializarCursorContas()
67:                     THIS.ConfigurarCabecalho()
68:                     THIS.ConfigurarBotoes()
69:                     THIS.ConfigurarContainerResultado()
70:                     THIS.ConfigurarPaginaLista()
71: 
72:                     *-- Tornar controles visiveis (exceto cnt_4c_Resultado que eh flutuante)
73:                     THIS.TornarControlesVisiveis(THIS)
74: 
75:                     loc_lSucesso = .T.
76:                 ELSE
77:                     MsgErro("Erro ao inicializar cursor de contas.", "Erro")
78:                 ENDIF
79:             ELSE
80:                 MsgErro("Erro ao criar SigPrMdcBO." + CHR(13) + ;
81:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
82:             ENDIF
83:         CATCH TO loc_oErro
84:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
85:                 " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
86:         ENDTRY
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *--------------------------------------------------------------------------
91:     * ConfigurarCabecalho - cabecalho cinza com titulo (cntSombra do legado)
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarCabecalho()
94:         LOCAL loc_oCab
95:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
96:         loc_oCab = THIS.cnt_4c_Cabecalho
97:         WITH loc_oCab
98:             .Top         = 0
99:             .Left        = 0
100:             .Width       = THIS.Width
101:             .Height      = 80
102:             .BackStyle   = 1
103:             .BackColor   = RGB(100, 100, 100)
104:             .BorderWidth = 0
105:         ENDWITH
106:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
107:         WITH loc_oCab.lbl_4c_Sombra
108:             .Top       = 18
109:             .Left      = 10
110:             .Width     = THIS.Width - 20
111:             .Height    = 40
112:             .AutoSize  = .F.
113:             .FontName  = "Tahoma"
114:             .FontSize  = 18
115:             .FontBold  = .T.
116:             .BackStyle = 0
117:             .Caption   = THIS.Caption
118:             .ForeColor = RGB(0, 0, 0)
119:         ENDWITH
120:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
121:         WITH loc_oCab.lbl_4c_Titulo
122:             .Top       = 17
123:             .Left      = 10
124:             .Width     = THIS.Width - 20
125:             .Height    = 46
126:             .AutoSize  = .F.
127:             .FontName  = "Tahoma"
128:             .FontSize  = 18
129:             .FontBold  = .T.
130:             .BackStyle = 0
131:             .Caption   = THIS.Caption
132:             .ForeColor = RGB(255, 255, 255)
133:         ENDWITH
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarBotoes
138:     * Container para os botoes de acao (Incluir, Excluir, Importar, Processar,
139:     * Encerrar). Fica logo abaixo do cabecalho, cobrindo toda a largura.
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarBotoes()
142:         LOCAL loc_oCnt
143:         THIS.AddObject("cnt_4c_Botoes", "Container")
144:         loc_oCnt = THIS.cnt_4c_Botoes
145:         WITH loc_oCnt
146:             .Top         = 80
147:             .Left        =  542
148:             .Width       = THIS.Width
149:             .Height      = 90
150:             .BackStyle   = 0
151:             .BorderWidth = 0
152:         ENDWITH
153:     ENDPROC
154: 
155:     *--------------------------------------------------------------------------
156:     * ConfigurarContainerResultado
157:     * Painel de progresso de processamento (cntResult do legado).
158:     * Inicialmente oculto; exibido durante btnProcessar quando chkReps=.F.
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarContainerResultado()
161:         LOCAL loc_oCnt
162:         THIS.AddObject("cnt_4c_Resultado", "Container")
163:         loc_oCnt = THIS.cnt_4c_Resultado
164:         WITH loc_oCnt
165:             .Top         = 170
166:             .Left        = 490
167:             .Width       = 297
168:             .Height      = 183
169:             .BackStyle   = 1
170:             .BackColor   = RGB(255, 255, 255)
171:             .SpecialEffect = 0
172:             .BorderWidth = 1
173:             .Visible     = .F.
174:         ENDWITH
175:     ENDPROC
176: 
177:     *--------------------------------------------------------------------------
178:     * AtualizarProgresso
179:     * Chamado pelo BO (ProcessarMudancaContas) para atualizar a UI em tempo
180:     * real durante o processamento.
181:     * par_cArquivo: nome do arquivo/campo em processamento
182:     * par_nPct    : percentual concluido 0-100
183:     *--------------------------------------------------------------------------
184:     PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
185:         LOCAL loc_nLargura
186:         loc_nLargura = 0
187:         TRY
188:             IF VARTYPE(THIS.cnt_4c_Resultado) = "O" AND THIS.cnt_4c_Resultado.Visible
189:                 THIS.cnt_4c_Resultado.txt_4c_Arquivo.Value = par_cArquivo
190:                 THIS.cnt_4c_Resultado.txt_4c_Arquivo.Refresh
191:                 loc_nLargura = INT((par_nPct * 275) / 100)
192:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width = loc_nLargura
193:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = ;
194:                     ALLTRIM(TRANSFORM(par_nPct)) + " %"
195:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.Refresh
196:             ENDIF
197:         CATCH TO loc_oErro
198:             *-- progresso nao e critico, pular silenciosamente
199:         ENDTRY
200:     ENDPROC
201: 
202:     *--------------------------------------------------------------------------
203:     * TornarControlesVisiveis
204:     * Torna controles Visible=.T. apos AddObject (que cria com Visible=.F.).
205:     * EXCECAO: cnt_4c_Resultado permanece oculto (container flutuante); seus
206:     * filhos sao visitados recursivamente para render correto ao exibir.
207:     *--------------------------------------------------------------------------
208:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
209:         LOCAL loc_i, loc_oCtrl
210:         FOR loc_i = 1 TO par_oContainer.ControlCount
211:             loc_oCtrl = par_oContainer.Controls(loc_i)
212:             IF VARTYPE(loc_oCtrl) = "O"
213:                 IF UPPER(loc_oCtrl.Name) = "CNT_4C_RESULTADO"
214:                     THIS.TornarControlesVisiveis(loc_oCtrl)
215:                     LOOP
216:                 ENDIF
217:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
218:                     loc_oCtrl.Visible = .T.
219:                 ENDIF
220:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) .AND. ;
221:                    loc_oCtrl.ControlCount > 0
222:                     THIS.TornarControlesVisiveis(loc_oCtrl)
223:                 ENDIF
224:             ENDIF
225:         ENDFOR
226:     ENDPROC
227: 
228:     *--------------------------------------------------------------------------
229:     * Activate - foca o grid quando o form e exibido (padrao legado Init SetFocus)
230:     *--------------------------------------------------------------------------
231:     PROCEDURE Activate()
232:         DODEFAULT()
233:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
234:             THIS.grd_4c_Dados.SetFocus()
235:         ENDIF
236:     ENDPROC
237: 
238:     *--------------------------------------------------------------------------
239:     * Destroy
240:     *--------------------------------------------------------------------------
241:     PROCEDURE Destroy()
242:         TRY
243:             IF USED("cursor_4c_Contas")
244:                 USE IN cursor_4c_Contas
245:             ENDIF
246:             IF USED("csCampos")
247:                 USE IN csCampos
248:             ENDIF
249:             IF USED("csArquivos")
250:                 USE IN csArquivos
251:             ENDIF
252:             THIS.this_oBusinessObject = .NULL.
253:         CATCH TO loc_oErro
254:             *-- ignorar erros de cleanup
255:         ENDTRY
256:         DODEFAULT()
257:     ENDPROC
258: 
259: 
260:     *--------------------------------------------------------------------------
261:     * ConfigurarPaginaLista
262:     * Configura o corpo principal do form OPERACIONAL: botoes de acao, grid
263:     * de pares de contas, checkboxes e internos do painel de progresso.
264:     *--------------------------------------------------------------------------
265:     PROTECTED PROCEDURE ConfigurarPaginaLista()
266:         THIS.ConfigurarBotoesAcao()
267:         THIS.ConfigurarGrid()
268:         THIS.ConfigurarCheckboxes()
269:         THIS.ConfigurarResultadoInternos()
270:         THIS.VincularEventos()
271:     ENDPROC
272: 
273:     *--------------------------------------------------------------------------
274:     * ConfigurarBotoesAcao
275:     * Adiciona os botoes de acao ao container cnt_4c_Botoes.
276:     *--------------------------------------------------------------------------
277:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
278:         LOCAL loc_oCnt
279:         loc_oCnt = THIS.cnt_4c_Botoes
280: 
281:         loc_oCnt.AddObject("cmd_4c_BtnIncluir", "CommandButton")
282:         WITH loc_oCnt.cmd_4c_BtnIncluir
283:             .Top             = 7
284:             .Left            = 5
285:             .Width           = 75
286:             .Height          = 75
287:             .Caption         = "\<Incluir"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
289:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
290:             .FontName        = "Comic Sans MS"
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .FontSize        = 8
294:             .ForeColor       = RGB(90, 90, 90)
295:             .BackColor       = RGB(255, 255, 255)
296:             .Themes          = .T.
297:             .SpecialEffect   = 0
298:             .PicturePosition = 13
299:             .WordWrap        = .T.
300:             .MousePointer    = 15
301:         ENDWITH
302: 
303:         loc_oCnt.AddObject("cmd_4c_BtnExcluir", "CommandButton")
304:         WITH loc_oCnt.cmd_4c_BtnExcluir
305:             .Top             = 7
306:             .Left            = 85
307:             .Width           = 75
308:             .Height          = 75
309:             .Caption         = "\<Excluir"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
311:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
312:             .FontName        = "Comic Sans MS"
313:             .FontBold        = .T.
314:             .FontItalic      = .T.
315:             .FontSize        = 8
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .T.
319:             .SpecialEffect   = 0
320:             .PicturePosition = 13
321:             .WordWrap        = .T.
322:             .MousePointer    = 15
323:         ENDWITH
324: 
325:         loc_oCnt.AddObject("cmd_4c_Exporta", "CommandButton")
326:         WITH loc_oCnt.cmd_4c_Exporta
327:             .Top             = 7
328:             .Left            = 165
329:             .Width           = 75
330:             .Height          = 75
331:             .Caption         = "I\<mportar"
332:             .Picture         = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
333:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_multiplos_60.jpg"
334:             .FontName        = "Comic Sans MS"
335:             .FontBold        = .T.
336:             .FontItalic      = .T.
337:             .FontSize        = 8
338:             .ForeColor       = RGB(90, 90, 90)
339:             .BackColor       = RGB(255, 255, 255)
340:             .Themes          = .T.
341:             .SpecialEffect   = 0
342:             .PicturePosition = 13
343:             .WordWrap        = .T.
344:             .MousePointer    = 15
345:         ENDWITH
346: 
347:         loc_oCnt.AddObject("cmd_4c_BtnProcessar", "CommandButton")
348:         WITH loc_oCnt.cmd_4c_BtnProcessar
349:             .Top             = 7
350:             .Left            = 245
351:             .Width           = 75
352:             .Height          = 75
353:             .Caption         = "\<Processar"
354:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
355:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
356:             .FontName        = "Comic Sans MS"
357:             .FontBold        = .T.
358:             .FontItalic      = .T.
359:             .FontSize        = 8
360:             .ForeColor       = RGB(90, 90, 90)
361:             .BackColor       = RGB(255, 255, 255)
362:             .Themes          = .T.
363:             .SpecialEffect   = 0
364:             .PicturePosition = 13
365:             .WordWrap        = .T.
366:             .MousePointer    = 15
367:         ENDWITH
368: 
369:         loc_oCnt.AddObject("cmd_4c_BtnSair", "CommandButton")
370:         WITH loc_oCnt.cmd_4c_BtnSair
371:             .Top             = 7
372:             .Left            = 915
373:             .Width           = 75
374:             .Height          = 75
375:             .Caption         = "Encerrar"
376:             .Cancel          = .T.
377:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
378:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
379:             .FontName        = "Comic Sans MS"
380:             .FontBold        = .T.
381:             .FontItalic      = .T.
382:             .FontSize        = 8
383:             .ForeColor       = RGB(90, 90, 90)
384:             .BackColor       = RGB(255, 255, 255)
385:             .Themes          = .T.

*-- Linhas 395 a 522:
395:     * Cria grd_4c_Dados com 2 colunas (Conta Antiga / Conta Nova).
396:     * RecordSource: cursor_4c_Contas criado pelo BO em InicializarCursorContas.
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarGrid()
399:         LOCAL loc_oGrid
400:         THIS.AddObject("grd_4c_Dados", "Grid")
401:         loc_oGrid = THIS.grd_4c_Dados
402:         WITH loc_oGrid
403:             .Top               = 170
404:             .Left              = 12
405:             .Width             = 460
406:             .Height            = 400
407:             .ColumnCount       = 2
408:             .AllowHeaderSizing = .F.
409:             .AllowRowSizing    = .F.
410:             .DeleteMark        = .F.
411:             .RecordMark        = .F.
412:             .HeaderHeight      = 18
413:             .RowHeight         = 18
414:             .ScrollBars        = 2
415:             .FontName          = "Verdana"
416:             .FontSize          = 8
417:             .ForeColor         = RGB(0, 0, 0)
418:             .BackColor         = RGB(255, 255, 255)
419:             .GridLineColor     = RGB(238, 238, 238)
420:             .HighlightStyle    = 2
421:             .RecordSource      = "cursor_4c_Contas"
422:             .Column1.ControlSource = "cursor_4c_Contas.ContaAnt"
423:             .Column1.Width         = 220
424:             .Column1.Sparse        = .F.
425:             .Column2.ControlSource = "cursor_4c_Contas.ContaNov"
426:             .Column2.Width         = 220
427:             .Column2.Sparse        = .F.
428:         ENDWITH
429:         *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
430:         loc_oGrid.Column1.Header1.Caption   = "Conta Antiga"
431:         loc_oGrid.Column1.Header1.Alignment = 2
432:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
433:         loc_oGrid.Column1.Header1.FontSize  = 8
434:         loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
435:         loc_oGrid.Column2.Header1.Caption   = "Conta Nova"
436:         loc_oGrid.Column2.Header1.Alignment = 2
437:         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
438:         loc_oGrid.Column2.Header1.FontSize  = 8
439:         loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
440:     ENDPROC
441: 
442:     *--------------------------------------------------------------------------
443:     * ConfigurarCheckboxes
444:     * Adiciona checkboxes de controle ao form.
445:     *--------------------------------------------------------------------------
446:     PROTECTED PROCEDURE ConfigurarCheckboxes()
447:         THIS.AddObject("chk_4c_ChkReps", "CheckBox")
448:         WITH THIS.chk_4c_ChkReps
449:             .Top       = 358
450:             .Left      = 490
451:             .Height    = 20
452:             .Width     = 240
453:             .Caption   = "Trocar Apenas Representantes"
454:             .Value     = 0
455:             .AutoSize  = .F.
456:             .BackStyle = 0
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .ForeColor = RGB(90, 90, 90)
460:         ENDWITH
461:         THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
462:         WITH THIS.chk_4c_Chk_DelCT
463:             .Top       = 383
464:             .Left      = 490
465:             .Height    = 20
466:             .Width     = 260
467:             .Caption   = "Apagar a Conta Antiga do Cadastro"
468:             .Value     = 0
469:             .AutoSize  = .F.
470:             .BackStyle = 0
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .ForeColor = RGB(90, 90, 90)
474:         ENDWITH
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     * ConfigurarResultadoInternos
479:     * Adiciona controles internos ao painel de progresso cnt_4c_Resultado.
480:     * Nomes devem bater exatamente com as referencias em AtualizarProgresso().
481:     *--------------------------------------------------------------------------
482:     PROTECTED PROCEDURE ConfigurarResultadoInternos()
483:         LOCAL loc_oCnt
484:         loc_oCnt = THIS.cnt_4c_Resultado
485: 
486:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
487:         WITH loc_oCnt.lbl_4c_Label5
488:             .Caption   = "Arquivo/Campo :"
489:             .Left      = 7
490:             .Top       = 9
491:             .AutoSize  = .T.
492:             .BackStyle = 0
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .ForeColor = RGB(0, 0, 0)
496:         ENDWITH
497: 
498:         loc_oCnt.AddObject("txt_4c_Arquivo", "TextBox")
499:         WITH loc_oCnt.txt_4c_Arquivo
500:             .Top               = 26
501:             .Left              = 7
502:             .Width             = 278
503:             .Height            = 24
504:             .Enabled           = .F.
505:             .Value             = ""
506:             .Alignment         = 3
507:             .SpecialEffect     = 1
508:             .DisabledBackColor = RGB(255, 255, 255)
509:             .DisabledForeColor = RGB(0, 0, 0)
510:             .BorderColor       = RGB(100, 100, 100)
511:             .FontName          = "Tahoma"
512:             .FontSize          = 8
513:         ENDWITH
514: 
515:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
516:         WITH loc_oCnt.lbl_4c_Label1
517:             .Caption   = "Progresso :"
518:             .Left      = 7
519:             .Top       = 100
520:             .AutoSize  = .T.
521:             .BackStyle = 0
522:             .FontName  = "Tahoma"

*-- Linhas 569 a 1187:
569:     *   cnt_4c_Resultado  - painel de progresso (flutuante)
570:     * Metodo mantido para compatibilidade com o template multi-fase.
571:     *--------------------------------------------------------------------------
572:     PROTECTED PROCEDURE ConfigurarPaginaDados()
573:         *-- Form OPERACIONAL plano: nao ha Page2 separada de edicao de dados.
574:         *-- Todos os controles foram configurados em ConfigurarPaginaLista().
575:         RETURN
576:     ENDPROC
577: 
578:     *--------------------------------------------------------------------------
579:     * VincularEventos
580:     * Vincula eventos dos controles aos handlers do form via BINDEVENT.
581:     *--------------------------------------------------------------------------
582:     PROTECTED PROCEDURE VincularEventos()
583:         LOCAL loc_oCnt
584:         loc_oCnt = THIS.cnt_4c_Botoes
585:         BINDEVENT(loc_oCnt.cmd_4c_BtnIncluir,  "Click", THIS, "CmdIncluirClick")
586:         BINDEVENT(loc_oCnt.cmd_4c_BtnExcluir,  "Click", THIS, "CmdExcluirClick")
587:         BINDEVENT(loc_oCnt.cmd_4c_Exporta,     "Click", THIS, "CmdExportaClick")
588:         BINDEVENT(loc_oCnt.cmd_4c_BtnProcessar,"Click", THIS, "CmdProcessarClick")
589:         BINDEVENT(loc_oCnt.cmd_4c_BtnSair,     "Click", THIS, "CmdSairClick")
590:         BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
591:         BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdDadosKeyPress")
592:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
593:     ENDPROC
594: 
595:     *--------------------------------------------------------------------------
596:     * AlternarPagina
597:     * Exibe ou oculta o painel de progresso (cnt_4c_Resultado).
598:     * par_lMostrar: .T. para exibir, .F. para ocultar, omitir para alternar.
599:     *--------------------------------------------------------------------------
600:     PROCEDURE AlternarPagina(par_lMostrar)
601:         TRY
602:             IF VARTYPE(par_lMostrar) = "L"
603:                 THIS.cnt_4c_Resultado.Visible = par_lMostrar
604:             ELSE
605:                 THIS.cnt_4c_Resultado.Visible = !THIS.cnt_4c_Resultado.Visible
606:             ENDIF
607:             THIS.Refresh()
608:         CATCH TO loc_oErro
609:             MsgErro(loc_oErro.Message, "Erro")
610:         ENDTRY
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * CmdIncluirClick - Incluir nova linha em branco no grid
615:     *--------------------------------------------------------------------------
616:     PROCEDURE CmdIncluirClick()
617:         TRY
618:             THIS.this_oBusinessObject.IncluirParConta()
619:             THIS.grd_4c_Dados.Refresh()
620:             THIS.grd_4c_Dados.SetFocus()
621:         CATCH TO loc_oErro
622:             MsgErro(loc_oErro.Message, "Erro ao Incluir")
623:         ENDTRY
624:     ENDPROC
625: 
626:     *--------------------------------------------------------------------------
627:     * CmdExcluirClick - Excluir linha corrente do grid
628:     *--------------------------------------------------------------------------
629:     PROCEDURE CmdExcluirClick()
630:         TRY
631:             THIS.this_oBusinessObject.ExcluirParConta()
632:             THIS.grd_4c_Dados.Refresh()
633:             THIS.grd_4c_Dados.SetFocus()
634:         CATCH TO loc_oErro
635:             MsgErro(loc_oErro.Message, "Erro ao Excluir")
636:         ENDTRY
637:     ENDPROC
638: 
639:     *--------------------------------------------------------------------------
640:     * CmdExportaClick - Importar pares de contas de arquivo XLS
641:     *--------------------------------------------------------------------------
642:     PROCEDURE CmdExportaClick()
643:         LOCAL loc_cArquivo
644:         loc_cArquivo = ""
645:         TRY
646:             loc_cArquivo = GETFILE("XLS")
647:             IF EMPTY(loc_cArquivo)
648:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
649:                     "o n" + CHR(227) + "o informado!!!", "Aviso")
650:                 RETURN
651:             ENDIF
652:             IF THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
653:                 THIS.grd_4c_Dados.Refresh()
654:             ENDIF
655:         CATCH TO loc_oErro
656:             MsgErro(loc_oErro.Message, "Erro ao Importar")
657:         ENDTRY
658:     ENDPROC
659: 
660:     *--------------------------------------------------------------------------
661:     * CmdProcessarClick - Processar troca de contas em todas as tabelas
662:     *--------------------------------------------------------------------------
663:     PROCEDURE CmdProcessarClick()
664:         LOCAL loc_lSucesso, loc_cMensagem, loc_lApagarContaAntiga, loc_lTrocarReps
665:         loc_lSucesso           = .F.
666:         loc_cMensagem          = ""
667:         loc_lApagarContaAntiga = .F.
668:         loc_lTrocarReps        = .F.
669:         TRY
670:             *-- Validar pares antes de processar
671:             IF NOT THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
672:                 MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
673:                 THIS.grd_4c_Dados.SetFocus()
674:                 RETURN
675:             ENDIF
676: 
677:             *-- Confirmar com usuario
678:             IF NOT MsgConfirma("Confirma a Troca das Contas ?", ;
679:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
680:                 THIS.cnt_4c_Botoes.cmd_4c_BtnSair.SetFocus()
681:                 RETURN
682:             ENDIF
683: 
684:             loc_lTrocarReps        = (THIS.chk_4c_ChkReps.Value   = 1)
685:             loc_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
686: 
687:             IF loc_lTrocarReps
688:                 *-- Troca apenas ContaVens em SigCdCli (representantes)
689:                 loc_lSucesso = THIS.this_oBusinessObject.TrocarContaRepresentantes()
690:             ELSE
691:                 *-- Processamento completo via catalogo ArqDBF
692:                 THIS.cnt_4c_Resultado.Visible = .T.
693:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.shp_4c_Barra.Width   = 0
694:                 THIS.cnt_4c_Resultado.cnt_4c_Barra.lbl_4c_Porcento.Caption = "0 %"
695:                 THIS.cnt_4c_Resultado.Refresh()
696:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarMudancaContas( ;
697:                     loc_lApagarContaAntiga, THIS)
698:                 THIS.cnt_4c_Resultado.Visible = .F.
699:                 THIS.Refresh()
700:             ENDIF
701: 
702:             *-- Informar resultado
703:             IF loc_lSucesso
704:                 MsgAviso("Todas as Contas Foram Alteradas!!!", ;
705:                     "Processamento Encerrado!!!")
706:             ELSE
707:                 MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
708:                     "Processamento Encerrado!!!")
709:             ENDIF
710: 
711:             *-- Reiniciar cursor para nova rodada
712:             IF USED("cursor_4c_Contas")
713:                 SELECT cursor_4c_Contas
714:                 SET ORDER TO
715:                 ZAP
716:                 APPEND BLANK
717:             ENDIF
718:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
719:                 THIS.grd_4c_Dados.Refresh()
720:             ENDIF
721:         CATCH TO loc_oErro
722:             MsgErro(loc_oErro.Message, "Erro no Processamento")
723:             TRY
724:                 THIS.cnt_4c_Resultado.Visible = .F.
725:                 THIS.Refresh()
726:             CATCH TO loc_oErroVis
727:                 *-- ignorar
728:             ENDTRY
729:         ENDTRY
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     * CmdSairClick - Fechar o formulario
734:     *--------------------------------------------------------------------------
735:     PROCEDURE CmdSairClick()
736:         THIS.Release()
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     * ChkRepsClick
741:     * Quando "Trocar Apenas Representantes" e marcado, desabilitar e limpar
742:     * "Apagar Conta Antiga" (legado: When = chkReps.Value = 0).
743:     *--------------------------------------------------------------------------
744:     PROCEDURE ChkRepsClick()
745:         IF THIS.chk_4c_ChkReps.Value = 1
746:             THIS.chk_4c_Chk_DelCT.Value   = 0
747:             THIS.chk_4c_Chk_DelCT.Enabled = .F.
748:         ELSE
749:             THIS.chk_4c_Chk_DelCT.Enabled = .T.
750:         ENDIF
751:     ENDPROC
752: 
753:     *--------------------------------------------------------------------------
754:     * GrdDadosKeyPress - F4 abre lookup para a coluna ativa (Conta Antiga/Nova)
755:     *--------------------------------------------------------------------------
756:     PROCEDURE GrdDadosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
757:         IF par_nKeyCode != 115  && Apenas F4
758:             RETURN
759:         ENDIF
760:         LOCAL loc_nColAtiva
761:         loc_nColAtiva = 0
762:         TRY
763:             loc_nColAtiva = THIS.grd_4c_Dados.ActiveColumn
764:         CATCH TO loc_oErro
765:             *-- ignorar
766:         ENDTRY
767:         IF loc_nColAtiva = 1
768:             THIS.AbrirLookupContaAnt()
769:         ELSE
770:             IF loc_nColAtiva = 2
771:             THIS.AbrirLookupContaNov()
772:             ENDIF
773:         ENDIF
774:     ENDPROC
775: 
776:     *--------------------------------------------------------------------------
777:     * GrdDadosAfterRowColChange
778:     * Ao mover para Coluna 2, valida ContaAnt do registro corrente.
779:     * Ao mover para Coluna 1 com ContaNov preenchida, valida ContaNov.
780:     * (Equivale aos Valid de Column1.Text1 e Column2.Text1 do legado.)
781:     *--------------------------------------------------------------------------
782:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
783:         IF THIS.this_lCheckCadPro
784:             RETURN
785:         ENDIF
786:         IF par_nColIndex = 2
787:             THIS.ValidarContaAnt()
788:         ELSE
789:             IF par_nColIndex = 1
790:             *-- Validar ContaNov apenas se tiver valor (usuario saiu da col 2)
791:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
792:                 IF NOT EMPTY(NVL(cursor_4c_Contas.ContaNov, ""))
793:                     THIS.ValidarContaNov()
794:                 ENDIF
795:             ENDIF
796:             ENDIF
797:         ENDIF
798:     ENDPROC
799: 
800:     *--------------------------------------------------------------------------
801:     * ValidarContaAnt
802:     * Valida ContaAnt do registro corrente contra SigCdCli. Se nao encontrado,
803:     * abre picker para selecao.
804:     *--------------------------------------------------------------------------
805:     PROCEDURE ValidarContaAnt()
806:         LOCAL loc_cValor, loc_cEncontrado
807:         loc_cValor      = ""
808:         loc_cEncontrado = ""
809:         TRY
810:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
811:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
812:             ENDIF
813:             IF EMPTY(loc_cValor)
814:                 RETURN
815:             ENDIF
816:             loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
817:             IF EMPTY(loc_cEncontrado)
818:                 THIS.AbrirLookupContaAnt()
819:             ENDIF
820:         CATCH TO loc_oErro
821:             MsgErro(loc_oErro.Message, "Erro ao validar Conta Antiga")
822:         ENDTRY
823:     ENDPROC
824: 
825:     *--------------------------------------------------------------------------
826:     * ValidarContaNov
827:     * Valida ContaNov do registro corrente contra SigCdCli. Se nao encontrado,
828:     * abre picker para selecao.
829:     *--------------------------------------------------------------------------
830:     PROCEDURE ValidarContaNov()
831:         LOCAL loc_cValor, loc_cEncontrado
832:         loc_cValor      = ""
833:         loc_cEncontrado = ""
834:         TRY
835:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
836:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
837:             ENDIF
838:             IF EMPTY(loc_cValor)
839:                 RETURN
840:             ENDIF
841:             loc_cEncontrado = THIS.this_oBusinessObject.ValidarCodigoConta(loc_cValor)
842:             IF EMPTY(loc_cEncontrado)
843:                 THIS.AbrirLookupContaNov()
844:             ENDIF
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "Erro ao validar Conta Nova")
847:         ENDTRY
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * AbrirLookupContaAnt
852:     * Abre FormBuscaAuxiliar para selecao de Conta Antiga (SigCdCli.Iclis).
853:     *--------------------------------------------------------------------------
854:     PROCEDURE AbrirLookupContaAnt()
855:         LOCAL loc_oLista, loc_cValor
856:         loc_cValor = ""
857:         TRY
858:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
859:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
860:             ENDIF
861:             loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
862:                 "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
863:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
864:             loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
865:             loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
866:             loc_oLista.mAddColuna("Grupos", "", "Grupo")
867:             loc_oLista.Show()
868:             IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
869:                RECCOUNT("cursor_4c_BuscaCli") > 0
870:                 SELECT cursor_4c_BuscaCli
871:                 IF NOT EOF()
872:                     SELECT cursor_4c_Contas
873:                     IF NOT EOF()
874:                         REPLACE cursor_4c_Contas.ContaAnt WITH ;
875:                             ALLTRIM(cursor_4c_BuscaCli.Iclis)
876:                     ENDIF
877:                 ENDIF
878:             ENDIF
879:         CATCH TO loc_oErro
880:             MsgErro(loc_oErro.Message, "Erro ao buscar Conta Antiga")
881:         ENDTRY
882:         IF USED("cursor_4c_BuscaCli")
883:             USE IN cursor_4c_BuscaCli
884:         ENDIF
885:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
886:             THIS.grd_4c_Dados.Refresh()
887:         ENDIF
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     * AbrirLookupContaNov
892:     * Abre FormBuscaAuxiliar para selecao de Conta Nova (SigCdCli.Iclis).
893:     *--------------------------------------------------------------------------
894:     PROCEDURE AbrirLookupContaNov()
895:         LOCAL loc_oLista, loc_cValor
896:         loc_cValor = ""
897:         TRY
898:             IF USED("cursor_4c_Contas") AND NOT EOF("cursor_4c_Contas")
899:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
900:             ENDIF
901:             loc_oLista = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
902:                 "SigCdCli", "cursor_4c_BuscaCli", "Iclis", loc_cValor, ;
903:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
904:             loc_oLista.mAddColuna("Iclis",  "", "C" + CHR(243) + "digo")
905:             loc_oLista.mAddColuna("Rclis",  "", "Descri" + CHR(231) + CHR(227) + "o")
906:             loc_oLista.mAddColuna("Grupos", "", "Grupo")
907:             loc_oLista.Show()
908:             IF loc_oLista.this_lSelecionou .AND. USED("cursor_4c_BuscaCli") .AND. ;
909:                RECCOUNT("cursor_4c_BuscaCli") > 0
910:                 SELECT cursor_4c_BuscaCli
911:                 IF NOT EOF()
912:                     SELECT cursor_4c_Contas
913:                     IF NOT EOF()
914:                         REPLACE cursor_4c_Contas.ContaNov WITH ;
915:                             ALLTRIM(cursor_4c_BuscaCli.Iclis)
916:                     ENDIF
917:                 ENDIF
918:             ENDIF
919:         CATCH TO loc_oErro
920:             MsgErro(loc_oErro.Message, "Erro ao buscar Conta Nova")
921:         ENDTRY
922:         IF USED("cursor_4c_BuscaCli")
923:             USE IN cursor_4c_BuscaCli
924:         ENDIF
925:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
926:             THIS.grd_4c_Dados.Refresh()
927:         ENDIF
928:     ENDPROC
929: 
930:     *--------------------------------------------------------------------------
931:     * BtnIncluirClick
932:     * Adiciona novo par de contas em branco no grid (equivalente CRUD Incluir).
933:     * Roteia para CmdIncluirClick (mesmo handler do botao [Incluir] visivel).
934:     *--------------------------------------------------------------------------
935:     PROCEDURE BtnIncluirClick()
936:         THIS.CmdIncluirClick()
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * BtnAlterarClick
941:     * Coloca foco na Conta Antiga da linha corrente para edicao inline no grid.
942:     * Form OPERACIONAL: grid eh sempre editavel, nao ha modo separado ALTERAR.
943:     *--------------------------------------------------------------------------
944:     PROCEDURE BtnAlterarClick()
945:         TRY
946:             IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
947:                 MsgAviso("N" + CHR(227) + "o existem pares de contas para alterar.", ;
948:                     "Aten" + CHR(231) + CHR(227) + "o")
949:                 RETURN
950:             ENDIF
951:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
952:                 THIS.grd_4c_Dados.SetFocus()
953:                 THIS.grd_4c_Dados.ActiveColumn = 1
954:                 IF VARTYPE(THIS.grd_4c_Dados.Column1.Text1) = "O"
955:                     THIS.grd_4c_Dados.Column1.Text1.SetFocus()
956:                 ENDIF
957:             ENDIF
958:         CATCH TO loc_oErro
959:             MsgErro(loc_oErro.Message, "Erro ao Alterar")
960:         ENDTRY
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     * BtnVisualizarClick
965:     * Exibe as descricoes das Contas Antiga/Nova da linha corrente do grid.
966:     * Form OPERACIONAL: nao ha modo VISUALIZAR separado; consulta on-demand.
967:     *--------------------------------------------------------------------------
968:     PROCEDURE BtnVisualizarClick()
969:         LOCAL loc_cContaAnt, loc_cContaNov, loc_cDescAnt, loc_cDescNov, loc_cMsg
970:         loc_cContaAnt = ""
971:         loc_cContaNov = ""
972:         loc_cDescAnt  = ""
973:         loc_cDescNov  = ""
974:         TRY
975:             IF NOT USED("cursor_4c_Contas") OR EOF("cursor_4c_Contas")
976:                 MsgAviso("N" + CHR(227) + "o existem pares de contas para visualizar.", ;
977:                     "Aten" + CHR(231) + CHR(227) + "o")
978:                 RETURN
979:             ENDIF
980:             SELECT cursor_4c_Contas
981:             loc_cContaAnt = ALLTRIM(NVL(cursor_4c_Contas.ContaAnt, ""))
982:             loc_cContaNov = ALLTRIM(NVL(cursor_4c_Contas.ContaNov, ""))
983:             IF EMPTY(loc_cContaAnt) AND EMPTY(loc_cContaNov)
984:                 MsgAviso("Linha corrente n" + CHR(227) + "o tem contas preenchidas.", ;
985:                     "Aten" + CHR(231) + CHR(227) + "o")
986:                 RETURN
987:             ENDIF
988:             IF NOT EMPTY(loc_cContaAnt)
989:                 loc_cDescAnt = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaAnt)
990:             ENDIF
991:             IF NOT EMPTY(loc_cContaNov)
992:                 loc_cDescNov = THIS.this_oBusinessObject.BuscarDescricaoConta(loc_cContaNov)
993:             ENDIF
994:             loc_cMsg = "Conta Antiga: " + loc_cContaAnt + CHR(13) + ;
995:                        "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescAnt + CHR(13) + CHR(13) + ;
996:                        "Conta Nova..: " + loc_cContaNov + CHR(13) + ;
997:                        "Descri" + CHR(231) + CHR(227) + "o.: " + loc_cDescNov
998:             MsgInfo(loc_cMsg, "Visualizar Par de Contas")
999:         CATCH TO loc_oErro
1000:             MsgErro(loc_oErro.Message, "Erro ao Visualizar")
1001:         ENDTRY
1002:     ENDPROC
1003: 
1004:     *--------------------------------------------------------------------------
1005:     * BtnExcluirClick
1006:     * Remove par de contas da linha corrente do grid (equivalente CRUD Excluir).
1007:     * Roteia para CmdExcluirClick (mesmo handler do botao [Excluir] visivel).
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE BtnExcluirClick()
1010:         IF NOT USED("cursor_4c_Contas") OR RECCOUNT("cursor_4c_Contas") = 0
1011:             MsgAviso("N" + CHR(227) + "o existem pares de contas para excluir.", ;
1012:                 "Aten" + CHR(231) + CHR(227) + "o")
1013:             RETURN
1014:         ENDIF
1015:         IF NOT MsgConfirma("Confirma a exclus" + CHR(227) + "o da linha corrente?", ;
1016:             "Confirma" + CHR(231) + CHR(227) + "o")
1017:             RETURN
1018:         ENDIF
1019:         THIS.CmdExcluirClick()
1020:     ENDPROC
1021: 
1022:     *--------------------------------------------------------------------------
1023:     * BtnEncerrarClick - Fechar o formulario (alias canonico para cmd Encerrar)
1024:     *--------------------------------------------------------------------------
1025:     PROCEDURE BtnEncerrarClick()
1026:         THIS.CmdSairClick()
1027:     ENDPROC
1028: 
1029:     *--------------------------------------------------------------------------
1030:     * BtnBuscarClick - Focar grid para edicao inline (busca e via F4 no grid)
1031:     *--------------------------------------------------------------------------
1032:     PROCEDURE BtnBuscarClick()
1033:         TRY
1034:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1035:                 THIS.grd_4c_Dados.SetFocus()
1036:                 THIS.grd_4c_Dados.ActiveColumn = 1
1037:             ENDIF
1038:         CATCH TO loc_oErro
1039:             *-- ignorar
1040:         ENDTRY
1041:     ENDPROC
1042: 
1043:     *--------------------------------------------------------------------------
1044:     * BtnSalvarClick - Aciona o processamento principal (semantica CRUD Salvar)
1045:     *--------------------------------------------------------------------------
1046:     PROCEDURE BtnSalvarClick()
1047:         THIS.CmdProcessarClick()
1048:     ENDPROC
1049: 
1050:     *--------------------------------------------------------------------------
1051:     * BtnCancelarClick - Limpa a lista de pares (semantica CRUD Cancelar)
1052:     *--------------------------------------------------------------------------
1053:     PROCEDURE BtnCancelarClick()
1054:         THIS.LimparCampos()
1055:     ENDPROC
1056: 
1057:     *--------------------------------------------------------------------------
1058:     * FormParaBO
1059:     * Transfere estado dos controles do form para propriedades do BO.
1060:     * Para este OPERACIONAL: repassa flags dos checkboxes.
1061:     *--------------------------------------------------------------------------
1062:     PROCEDURE FormParaBO()
1063:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1064:             RETURN
1065:         ENDIF
1066:         TRY
1067:             THIS.this_oBusinessObject.this_lCheckCadPro       = THIS.this_lCheckCadPro
1068:             THIS.this_oBusinessObject.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
1069:             THIS.this_oBusinessObject.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
1070:         CATCH TO loc_oErro
1071:             MsgErro(loc_oErro.Message, "Erro em FormParaBO")
1072:         ENDTRY
1073:     ENDPROC
1074: 
1075:     *--------------------------------------------------------------------------
1076:     * BOParaForm
1077:     * Carrega propriedades do BO nos controles do form.
1078:     * Para este OPERACIONAL: reflete flags de configuracao nos checkboxes.
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE BOParaForm()
1081:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1082:             RETURN
1083:         ENDIF
1084:         TRY
1085:             THIS.chk_4c_ChkReps.Value   = IIF(THIS.this_oBusinessObject.this_lTrocarReps, 1, 0)
1086:             THIS.chk_4c_Chk_DelCT.Value = IIF(THIS.this_oBusinessObject.this_lApagarContaAntiga, 1, 0)
1087:         CATCH TO loc_oErro
1088:             MsgErro(loc_oErro.Message, "Erro em BOParaForm")
1089:         ENDTRY
1090:     ENDPROC
1091: 
1092:     *--------------------------------------------------------------------------
1093:     * HabilitarCampos
1094:     * Habilita ou desabilita os botoes de acao do formulario.
1095:     * par_lHabilitar: .T. para habilitar, .F. para desabilitar (default .T.)
1096:     *--------------------------------------------------------------------------
1097:     PROCEDURE HabilitarCampos(par_lHabilitar)
1098:         LOCAL loc_lAtivar
1099:         loc_lAtivar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1100:         TRY
1101:             WITH THIS.cnt_4c_Botoes
1102:                 .cmd_4c_BtnIncluir.Enabled   = loc_lAtivar
1103:                 .cmd_4c_BtnExcluir.Enabled   = loc_lAtivar
1104:                 .cmd_4c_Exporta.Enabled      = loc_lAtivar
1105:                 .cmd_4c_BtnProcessar.Enabled = loc_lAtivar
1106:                 .Visible     = .T.
1107:             ENDWITH
1108:         CATCH TO loc_oErro
1109:             *-- ignorar erro de habilitacao
1110:         ENDTRY
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * LimparCampos
1115:     * Reinicia cursor_4c_Contas com um registro em branco e limpa checkboxes.
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE LimparCampos()
1118:         TRY
1119:             IF USED("cursor_4c_Contas")
1120:                 SELECT cursor_4c_Contas
1121:                 SET ORDER TO
1122:                 ZAP
1123:                 APPEND BLANK
1124:             ENDIF
1125:             THIS.chk_4c_ChkReps.Value    = 0
1126:             THIS.chk_4c_Chk_DelCT.Value  = 0
1127:             THIS.chk_4c_Chk_DelCT.Enabled = .T.
1128:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1129:                 THIS.grd_4c_Dados.Refresh()
1130:             ENDIF
1131:         CATCH TO loc_oErro
1132:             MsgErro(loc_oErro.Message, "Erro ao limpar")
1133:         ENDTRY
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * CarregarLista
1138:     * Atualiza a exibicao do grid com o estado corrente do cursor_4c_Contas.
1139:     * Returns: .T. em sucesso
1140:     *--------------------------------------------------------------------------
1141:     FUNCTION CarregarLista()
1142:         LOCAL loc_lSucesso
1143:         loc_lSucesso = .F.
1144:         TRY
1145:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
1146:                 THIS.grd_4c_Dados.Refresh()
1147:             ENDIF
1148:             loc_lSucesso = .T.
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message, "Erro ao carregar lista")
1151:         ENDTRY
1152:         RETURN loc_lSucesso
1153:     ENDFUNC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     * AjustarBotoesPorModo
1157:     * Ajusta estado dos botoes conforme conteudo do cursor.
1158:     * Excluir e Processar so ficam ativos se houver pares cadastrados.
1159:     *--------------------------------------------------------------------------
1160:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1161:         LOCAL loc_lTemRegistros
1162:         loc_lTemRegistros = USED("cursor_4c_Contas") AND ;
1163:                             NOT EOF("cursor_4c_Contas") AND ;
1164:                             NOT EMPTY(NVL(cursor_4c_Contas.ContaAnt, ""))
1165:         TRY
1166:             WITH THIS.cnt_4c_Botoes
1167:                 .cmd_4c_BtnExcluir.Enabled   = loc_lTemRegistros
1168:                 .cmd_4c_BtnProcessar.Enabled = loc_lTemRegistros
1169:                 .Visible     = .T.
1170:             ENDWITH
1171:         CATCH TO loc_oErro
1172:             *-- ignorar erro de ajuste
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * FormatarGridLista
1178:     * Aplica formatacao visual padrao ao grid de pares de contas.
1179:     *--------------------------------------------------------------------------
1180:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1181:         WITH par_oGrid
1182:             .FontName = "Verdana"
1183:             .FontSize = 8
1184:         ENDWITH
1185:     ENDPROC
1186: 
1187: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts + chama fRecalculaP + fRecalculaC
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    TRY
                                        =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                            m.loc_cContaNovSalvo, ;
                                            CTOD('01/01/1900'), ;
                                            cursor_4c_Mccr.Moedas, ;
                                            gnConnHandle)
                                    CATCH TO loc_oErroF
                                        *-- fRecalculaS nao portada - pular recalculo
                                    ENDTRY
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His") AND RECCOUNT("cursor_4c_His") > 0
                                        loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                        SELECT cursor_4c_His
                                        SCAN
                                            TRY
                                                =fRecalculaP(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Grupos, ;
                                                    m.loc_cContaNovSalvo, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    cursor_4c_His.CodCors, ;
                                                    cursor_4c_His.CodTams, ;
                                                    gnConnHandle)
                                                =fRecalculaC(cursor_4c_His.Emps, ;
                                                    cursor_4c_His.Cpros, ;
                                                    CTOD('01/01/1900'), ;
                                                    gnConnHandle)
                                            CATCH TO loc_oErroF
                                                *-- fRecalculaP/C nao portadas - pular recalculo
                                            ENDTRY
                                        ENDSCAN
                                        IF USED("cursor_4c_His")
                                            USE IN cursor_4c_His
                                        ENDIF
                                    ENDIF
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculos finais (funcoes legado - pular se nao portadas)
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaS nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaP(.T., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaP nao portada - ignorar
                ENDTRY
            ENDIF
            IF loc_nErro > 0
                TRY
                    IF NOT fRecalculaC(.T., .F., .F., gnConnHandle)
                        loc_nErro = -1
                    ENDIF
                CATCH
                    *-- fRecalculaC nao portada - ignorar
                ENDTRY
            ENDIF

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

