# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDif.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (990 linhas total):

*-- Linhas 12 a 206:
12: * FASE 3/8 - Estrutura base:
13: *   - Properties (dimensoes, sessao, BO)
14: *   - Init(par_nDataSessionId): armazena sessao, DODEFAULT(), junta sessao
15: *   - InicializarForm(): cria BO, cabecalho, botoes
16: *   - ConfigurarCabecalho(): container escuro com titulo
17: *   - ConfigurarBotoes(): CommandGroup 4 botoes (Visualizar, Imprimir,
18: *                         Documento, Encerrar)
19: *   - Destroy(): libera referencia ao BO
20: *==============================================================================
21: 
22: DEFINE CLASS FormSigReDif AS FormBase
23: 
24:     *-- Dimensoes (acomodam grade de 14 colunas + label historico no rodape)
25:     *   Grid: Left=72, Width=668 -> borda direita 740
26:     *   cmg_4c_Botoes: Left=529, Width=273 -> borda direita 802 (< 810)
27:     Height      = 570
28:     Width       = 810
29:     DataSession = 2
30:     ShowWindow  = 1
31:     WindowType  = 1
32:     AutoCenter  = .T.
33:     BorderStyle = 2
34:     ControlBox  = .F.
35:     MaxButton   = .F.
36:     MinButton   = .F.
37:     TitleBar    = 0
38:     Themes      = .F.
39:     ShowTips    = .T.
40: 
41:     *-- DataSessionId do form chamador (passado em Init, propagado ao BO)
42:     this_nDataSessionId = 0
43: 
44:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
45:     this_oRelatorio     = .NULL.
46:     this_cMensagemErro  = ""
47: 
48:     *--------------------------------------------------------------------------
49:     * Init - Armazena DataSessionId do chamador, delega para FormBase.Init()
50:     *        via DODEFAULT() (que chama THIS.InicializarForm()), e entao
51:     *        junta o DataSessionId ao form para que o grid veja crGrid.
52:     *        Equivalente a: DoDefault() + ThisForm.DataSessionId = _Acesso
53:     *--------------------------------------------------------------------------
54:     PROCEDURE Init(par_nDataSessionId)
55:         LOCAL loc_lSucesso
56:         loc_lSucesso = .F.
57:         TRY
58:             IF PCOUNT() > 0 AND VARTYPE(par_nDataSessionId) = "N" AND ;
59:                par_nDataSessionId > 0
60:                 THIS.this_nDataSessionId = par_nDataSessionId
61:             ENDIF
62: 
63:             *-- Inicializacao padrao: header, botoes, layout (DODEFAULT chama
64:             *   FormBase.Init que por sua vez chama THIS.InicializarForm)
65:             loc_lSucesso = DODEFAULT()
66: 
67:             *-- Junta a sessao do form chamador para ver movaux/dif2/crGrid
68:             *   Equivalente a: ThisForm.DataSessionId = _Acesso no legado
69:             IF loc_lSucesso AND THIS.this_nDataSessionId > 0
70:                 THIS.DataSessionId = THIS.this_nDataSessionId
71: 
72:                 *-- Popula crGrid e configura RecordSource/colunas do grid
73:                 THIS.CarregarGrade()
74:                 IF USED("crGrid") AND RECCOUNT("crGrid") > 0
75:                     SELECT crGrid
76:                     GO TOP
77:                     THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
78:                 ENDIF
79:             ENDIF
80:         CATCH TO loc_oErro
81:             THIS.this_cMensagemErro = loc_oErro.Message
82:             MsgErro(loc_oErro.Message + CHR(13) + ;
83:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
84:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
85:         ENDTRY
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *--------------------------------------------------------------------------
90:     * InicializarForm - Cria BO, configura cabecalho e botoes de relatorio.
91:     *                   Chamado automaticamente por FormBase.Init() via DODEFAULT.
92:     *                   Nao chama PrepararDados aqui - isso ocorre na Fase 4
93:     *                   apos Init() juntar o DataSessionId correto.
94:     *--------------------------------------------------------------------------
95:     PROTECTED PROCEDURE InicializarForm()
96:         LOCAL loc_lSucesso, loc_lContinuar
97:         loc_lSucesso   = .F.
98:         loc_lContinuar = .T.
99:         TRY
100:             THIS.Caption = "Diferen" + CHR(231) + "as Encontradas"
101: 
102:             IF TYPE("gc_4c_CaminhoIcones") = "U"
103:                 gc_4c_CaminhoIcones = ""
104:             ENDIF
105:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
106: 
107:             *-- Instanciar BO de relatorio
108:             THIS.this_oRelatorio = CREATEOBJECT("SigReDifBO")
109:             IF VARTYPE(THIS.this_oRelatorio) != "O"
110:                 MsgErro("Erro ao criar SigReDifBO" + CHR(13) + ;
111:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
112:                 loc_lContinuar = .F.
113:             ENDIF
114: 
115:             IF loc_lContinuar
116:                 *-- Propaga DataSessionId ao BO para uso em PrepararDados (Fase 4)
117:                 THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
118: 
119:                 *-- Monta layout do form REPORT: cabecalho escuro + CommandGroup
120:                 *   de 4 botoes. Em forms REPORT (frmrelatorio) nao ha PageFrame
121:                 *   CRUD; ConfigurarPageFrame() orquestra os equivalentes.
122:                 THIS.ConfigurarPageFrame()
123: 
124:                 *-- Sincroniza labels de titulo com caption do form
125:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
126:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
127: 
128:                 THIS.Visible = .T.
129:                 loc_lSucesso = .T.
130:             ENDIF
131:         CATCH TO loc_oErro
132:             THIS.this_cMensagemErro = loc_oErro.Message
133:             MsgErro(loc_oErro.Message + CHR(13) + ;
134:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
135:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
136:         ENDTRY
137:         RETURN loc_lSucesso
138:     ENDPROC
139: 
140:     *--------------------------------------------------------------------------
141:     * ConfigurarPageFrame - Orquestra o layout do form REPORT.
142:     *   Forms REPORT (frmrelatorio) NAO tem PageFrame CRUD (Lista/Dados);
143:     *   o equivalente eh o cabecalho escuro + CommandGroup de botoes.
144:     *   Este metodo eh o ponto unico de montagem do layout, espelhando o
145:     *   papel de ConfigurarPageFrame() em forms CRUD.
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarPageFrame()
148:         *-- Container escuro com titulo (equivalente ao cntSombra)
149:         THIS.ConfigurarCabecalho()
150: 
151:         *-- CommandGroup com 4 botoes de relatorio (equivalente ao BTNREPORT)
152:         THIS.ConfigurarBotoes()
153: 
154:         *-- Grid de 14 colunas com diferencas + label/textbox Historico
155:         THIS.ConfigurarPaginaLista()
156: 
157:         *-- Propriedades estruturais das colunas 1-7 (Movable, Resizable, InputMask)
158:         THIS.ConfigurarPaginaDados()
159:     ENDPROC
160: 
161:     *--------------------------------------------------------------------------
162:     * ConfigurarCabecalho - Container escuro superior com titulo.
163:     *   Equivalente ao cntSombra do frmrelatorio (framework.vcx).
164:     *   Largura = THIS.Width (cobre toda a faixa superior do form).
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarCabecalho()
167:         LOCAL loc_nLarguraForm
168:         loc_nLarguraForm = THIS.Width
169:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
170:         WITH THIS.cnt_4c_Cabecalho
171:             .Top         = 0
172:             .Left        = 0
173:             .Width       = loc_nLarguraForm
174:             .Height      = 80
175:             .BackStyle   = 1
176:             .BackColor   = RGB(100, 100, 100)
177:             .BorderWidth = 0
178:             .Visible     = .T.
179: 
180:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
181:             .AddObject("lbl_4c_Sombra", "Label")
182:             WITH .lbl_4c_Sombra
183:                 .Top       = 22
184:                 .Left      = 22
185:                 .Width     = loc_nLarguraForm
186:                 .Height    = 30
187:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
188:                 .FontName  = "Tahoma"
189:                 .FontSize  = 14
190:                 .FontBold  = .T.
191:                 .ForeColor = RGB(0, 0, 0)
192:                 .BackStyle = 0
193:                 .Visible   = .T.
194:             ENDWITH
195: 
196:             *-- Titulo em branco (sobre a sombra)
197:             .AddObject("lbl_4c_Titulo", "Label")
198:             WITH .lbl_4c_Titulo
199:                 .Top       = 20
200:                 .Left      = 20
201:                 .Width     = loc_nLarguraForm
202:                 .Height    = 30
203:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
204:                 .FontName  = "Tahoma"
205:                 .FontSize  = 14
206:                 .FontBold  = .T.

*-- Linhas 216 a 262:
216:     *   Geometria EXATA do framework frmrelatorio.vcx (BTNREPORT):
217:     *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
218:     *     Buttons: Left=5/71/137/203, Width=65, Height=70
219:     *   BINDEVENTs (Click) sao vinculados na Fase 7.
220:     *   Buttons(4).Cancel=.T. para fechar com ESC.
221:     *--------------------------------------------------------------------------
222:     PROTECTED PROCEDURE ConfigurarBotoes()
223:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
224:         WITH THIS.cmg_4c_Botoes
225:             .Top           = 0
226:             .Left          = 529
227:             .Width         = 273
228:             .Height        = 80
229:             .ButtonCount   = 4
230:             .BackStyle     = 0
231:             .BorderStyle   = 0
232:             .BorderColor   = RGB(136, 189, 188)
233:             .SpecialEffect = 1
234:             .Themes        = .F.
235:             .Visible       = .T.
236: 
237:             *-- Visualizar: exibe relatorio em preview na tela
238:             WITH .Buttons(1)
239:                 .Top             = 5
240:                 .Left            = 5
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Visualizar"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
249:                 .PicturePosition = 13
250:                 .SpecialEffect   = 0
251:                 .MousePointer    = 15
252:                 .ToolTipText     = "Visualizar relat" + CHR(243) + "rio na tela"
253:                 .Themes          = .F.
254:                 .Visible         = .T.
255:             ENDWITH
256: 
257:             *-- Imprimir: envia relatorio com dialogo de selecao de impressora
258:             WITH .Buttons(2)
259:                 .Top             = 5
260:                 .Left            = 71
261:                 .Width           = 65
262:                 .Height          = 70

*-- Linhas 277 a 443:
277:             ENDWITH
278: 
279:             *-- Documento: imprime direto na impressora padrao (sem dialogo)
280:             *   Original: BTNREPORT.DOCEXCEL -> Procedure "documento"
281:             *   -> REPORT FORM SigReDif To Printer NoConsole
282:             WITH .Buttons(3)
283:                 .Top             = 5
284:                 .Left            = 137
285:                 .Width           = 65
286:                 .Height          = 70
287:                 .Caption         = "Documento"
288:                 .FontName        = "Tahoma"
289:                 .FontBold        = .T.
290:                 .FontItalic      = .T.
291:                 .FontSize        = 8
292:                 .BackColor       = RGB(255, 255, 255)
293:                 .ForeColor       = RGB(90, 90, 90)
294:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
295:                 .PicturePosition = 13
296:                 .SpecialEffect   = 0
297:                 .MousePointer    = 15
298:                 .ToolTipText     = "Imprimir direto na impressora padr" + CHR(227) + "o"
299:                 .Themes          = .F.
300:                 .Visible         = .T.
301:             ENDWITH
302: 
303:             *-- Encerrar: fecha o form (Cancel=.T. ativa com ESC)
304:             WITH .Buttons(4)
305:                 .Top             = 5
306:                 .Left            = 203
307:                 .Width           = 65
308:                 .Height          = 70
309:                 .Caption         = "Encerrar"
310:                 .Cancel          = .T.
311:                 .FontName        = "Tahoma"
312:                 .FontBold        = .T.
313:                 .FontItalic      = .T.
314:                 .FontSize        = 8
315:                 .BackColor       = RGB(255, 255, 255)
316:                 .ForeColor       = RGB(90, 90, 90)
317:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
318:                 .PicturePosition = 13
319:                 .SpecialEffect   = 0
320:                 .MousePointer    = 15
321:                 .ToolTipText     = "[Esc] Encerrar"
322:                 .Themes          = .F.
323:                 .Visible         = .T.
324:             ENDWITH
325:         ENDWITH
326: 
327:         *-- Vincula eventos Click dos botoes (metodos publicos do form)
328:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
329:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
330:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
331:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
332:     ENDPROC
333: 
334:     *--------------------------------------------------------------------------
335:     * ConfigurarPaginaLista - Cria grid de 14 colunas, label e textbox Historico
336:     *   Espelha Grid1 (Top=168 Left=72 W=668 H=345), Label1 e Text1 do legado.
337:     *   RecordSource e ControlSources sao aplicados em CarregarGrade(), apos
338:     *   crGrid existir (criado por PrepararDados na sessao do chamador).
339:     *--------------------------------------------------------------------------
340:     PROTECTED PROCEDURE ConfigurarPaginaLista()
341:         THIS.AddObject("grd_4c_Dados", "Grid")
342:         WITH THIS.grd_4c_Dados
343:             .Top               = 168
344:             .Left              = 72
345:             .Width             = 668
346:             .Height            = 345
347:             .ColumnCount       = 14
348:             .FontName          = "Verdana"
349:             .FontSize          = 8
350:             .ForeColor         = RGB(90, 90, 90)
351:             .BackColor         = RGB(255, 255, 255)
352:             .GridLineColor     = RGB(238, 238, 238)
353:             .HighlightBackColor = RGB(255, 255, 255)
354:             .HighlightForeColor = RGB(15, 41, 104)
355:             .HighlightStyle    = 2
356:             .DeleteMark        = .F.
357:             .RecordMark        = .F.
358:             .RowHeight         = 16
359:             .ScrollBars        = 3
360:             .ReadOnly          = .T.
361:             .Visible           = .T.
362:         ENDWITH
363: 
364:         *-- AfterRowColChange mostra Hists da linha selecionada (espelha Grid1.AfterRowColChange)
365:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAposLinhaColChange")
366: 
367:         *-- Label "Historico:" (espelha Label1 do legado)
368:         THIS.AddObject("lbl_4c_Historico", "Label")
369:         WITH THIS.lbl_4c_Historico
370:             .Top       = 525
371:             .Left      = 72
372:             .Width     = 58
373:             .Height    = 15
374:             .Caption   = "Hist" + CHR(243) + "rico: "
375:             .FontName  = "Tahoma"
376:             .FontSize  = 8
377:             .ForeColor = RGB(90, 90, 90)
378:             .BackStyle = 0
379:             .Visible   = .T.
380:         ENDWITH
381: 
382:         *-- TextBox de historico (somente leitura - espelha Text1 WHEN=.F. do legado)
383:         THIS.AddObject("txt_4c_Historico", "TextBox")
384:         WITH THIS.txt_4c_Historico
385:             .Top      = 521
386:             .Left     = 140
387:             .Width    = 500
388:             .Height   = 23
389:             .Value    = ""
390:             .ReadOnly = .T.
391:             .Enabled  = .F.
392:             .FontName = "Tahoma"
393:             .FontSize = 8
394:             .Visible  = .T.
395:         ENDWITH
396:     ENDPROC
397: 
398:     *--------------------------------------------------------------------------
399:     * CarregarGrade - Chama PrepararDados e configura RecordSource/colunas/headers
400:     *   Chamado em Init() apos juntar DataSessionId do form chamador.
401:     *   Necessario chamar APOS juntar a sessao para que crGrid fique visivel.
402:     *--------------------------------------------------------------------------
403:     PROCEDURE CarregarGrade()
404:         LOCAL loc_lSucesso
405:         loc_lSucesso = .F.
406:         TRY
407:             IF VARTYPE(THIS.this_oRelatorio) = "O"
408:                 THIS.this_oRelatorio.PrepararDados()
409:             ENDIF
410: 
411:             IF USED("crGrid")
412:                 THIS.grd_4c_Dados.RecordSource = "crGrid"
413:                 WITH THIS.grd_4c_Dados
414:                     *-- ControlSources das 14 colunas (campos do cursor crGrid/movaux)
415:                     .Column1.ControlSource  = "crGrid.AnoFis"
416:                     .Column2.ControlSource  = "Substr(crGrid.Datas,1,2)+[/]+Substr(crGrid.Datas,3,2)+[/]+Substr(crGrid.Datas,5,4)"
417:                     .Column3.ControlSource  = "crGrid.Contas"
418:                     .Column4.ControlSource  = "crGrid.Debs"
419:                     .Column5.ControlSource  = "crGrid.Creds"
420:                     .Column6.ControlSource  = "crGrid.Docto"
421:                     .Column7.ControlSource  = "crGrid.EmpCont"
422:                     .Column8.ControlSource  = "crGrid.NumSeq"
423:                     .Column9.ControlSource  = "crGrid.Nums"
424:                     .Column10.ControlSource = "crGrid.Data"
425:                     .Column11.ControlSource = "crGrid.Valor"
426:                     .Column12.ControlSource = "crGrid.Cecus"
427:                     .Column13.ControlSource = "crGrid.Emps"
428:                     .Column14.ControlSource = "crGrid.Transacaos"
429: 
430:                     *-- Redefine headers: RecordSource reseta captions (FORMCOR licao #2)
431:                     .Column1.Header1.Caption  = "Ano"
432:                     .Column2.Header1.Caption  = "Data"
433:                     .Column3.Header1.Caption  = "Conta"
434:                     .Column4.Header1.Caption  = "D" + CHR(233) + "bito"
435:                     .Column5.Header1.Caption  = "Cr" + CHR(233) + "dito"
436:                     .Column6.Header1.Caption  = "Documento"
437:                     .Column7.Header1.Caption  = "Cont."
438:                     .Column8.Header1.Caption  = "Seq."
439:                     .Column9.Header1.Caption  = "Numes"
440:                     .Column10.Header1.Caption = "Data"
441:                     .Column11.Header1.Caption = "Valor"
442:                     .Column12.Header1.Caption = "C. Custo"
443:                     .Column13.Header1.Caption = "Emp."

*-- Linhas 497 a 552:
497:         CATCH TO loc_oErro
498:             MsgErro(loc_oErro.Message + CHR(13) + ;
499:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
500:                     "Procedure: " + loc_oErro.Procedure, "Erro CarregarGrade")
501:         ENDTRY
502:         RETURN loc_lSucesso
503:     ENDPROC
504: 
505:     *--------------------------------------------------------------------------
506:     * ConfigurarPaginaDados - Propriedades estruturais das 14 colunas do grid.
507:     *   Espelha Column1..Column14 do legado: Movable=.F., Resizable=.F.,
508:     *   ReadOnly=.T., InputMask/Format/Alignment/MaxLength onde definidos.
509:     *   Configura tambem Text1 de cada coluna (BorderStyle=0, Margin=0, cores).
510:     *   Chamado em ConfigurarPageFrame() apos ConfigurarPaginaLista().
511:     *--------------------------------------------------------------------------
512:     PROTECTED PROCEDURE ConfigurarPaginaDados()
513:         IF VARTYPE(THIS.grd_4c_Dados) != "O"
514:             RETURN
515:         ENDIF
516:         WITH THIS.grd_4c_Dados
517:             *-- Col 1: Ano fiscal (4 digitos numericos)
518:             WITH .Column1
519:                 .Movable   = .F.
520:                 .Resizable = .F.
521:                 .ReadOnly  = .T.
522:                 .InputMask = "9999"
523:             ENDWITH
524:             WITH .Column1.Text1
525:                 .BorderStyle = 0
526:                 .InputMask   = "9999"
527:                 .Margin      = 0
528:                 .ForeColor   = RGB(0, 0, 0)
529:                 .BackColor   = RGB(255, 255, 255)
530:             ENDWITH
531:             *-- Col 2: Data como string DDMMYYYY; Format="R" exibe com separadores
532:             WITH .Column2
533:                 .Movable   = .F.
534:                 .Resizable = .F.
535:                 .ReadOnly  = .T.
536:                 .Format    = "R"
537:             ENDWITH
538:             WITH .Column2.Text1
539:                 .BorderStyle = 0
540:                 .Margin      = 0
541:                 .ForeColor   = RGB(0, 0, 0)
542:                 .BackColor   = RGB(255, 255, 255)
543:             ENDWITH
544:             *-- Col 3: Conta contabil (9 digitos) - ForeColor cinza, FontName Tahoma
545:             WITH .Column3
546:                 .Movable   = .F.
547:                 .Resizable = .F.
548:                 .ReadOnly  = .T.
549:                 .InputMask = "999999999"
550:             ENDWITH
551:             WITH .Column3.Text1
552:                 .BorderStyle = 0

*-- Linhas 724 a 990:
724:     * BtnVisualizarClick - Exibe relatorio em preview na tela
725:     *   Espelha Buttons(1) -> REPORT FORM SigReDif Preview NoConsole
726:     *--------------------------------------------------------------------------
727:     PROCEDURE BtnVisualizarClick()
728:         LOCAL loc_lSucesso
729:         loc_lSucesso = .F.
730:         TRY
731:             IF VARTYPE(THIS.this_oRelatorio) = "O"
732:                 IF !THIS.this_oRelatorio.Visualizar()
733:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
734:                         "Erro ao Visualizar")
735:                 ELSE
736:                     loc_lSucesso = .T.
737:                 ENDIF
738:             ENDIF
739:         CATCH TO loc_oErro
740:             MsgErro(loc_oErro.Message + CHR(13) + ;
741:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
742:                 "Procedure: " + loc_oErro.Procedure, "Erro Visualizar")
743:         ENDTRY
744:         RETURN loc_lSucesso
745:     ENDPROC
746: 
747:     *--------------------------------------------------------------------------
748:     * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
749:     *   Espelha Buttons(2) -> REPORT FORM SigReDif To Printer Prompt NoConsole
750:     *--------------------------------------------------------------------------
751:     PROCEDURE BtnImprimirClick()
752:         LOCAL loc_lSucesso
753:         loc_lSucesso = .F.
754:         TRY
755:             IF VARTYPE(THIS.this_oRelatorio) = "O"
756:                 IF !THIS.this_oRelatorio.Imprimir()
757:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
758:                         "Erro ao Imprimir")
759:                 ELSE
760:                     loc_lSucesso = .T.
761:                 ENDIF
762:             ENDIF
763:         CATCH TO loc_oErro
764:             MsgErro(loc_oErro.Message + CHR(13) + ;
765:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
766:                 "Procedure: " + loc_oErro.Procedure, "Erro Imprimir")
767:         ENDTRY
768:         RETURN loc_lSucesso
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     * BtnDocumentoClick - Imprime relatorio direto na impressora padrao
773:     *   Espelha Buttons(3) -> REPORT FORM SigReDif To Printer NoConsole
774:     *--------------------------------------------------------------------------
775:     PROCEDURE BtnDocumentoClick()
776:         LOCAL loc_lSucesso
777:         loc_lSucesso = .F.
778:         TRY
779:             IF VARTYPE(THIS.this_oRelatorio) = "O"
780:                 IF !THIS.this_oRelatorio.GerarDocumento()
781:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
782:                         "Erro ao Gerar Documento")
783:                 ELSE
784:                     loc_lSucesso = .T.
785:                 ENDIF
786:             ENDIF
787:         CATCH TO loc_oErro
788:             MsgErro(loc_oErro.Message + CHR(13) + ;
789:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
790:                 "Procedure: " + loc_oErro.Procedure, "Erro Documento")
791:         ENDTRY
792:         RETURN loc_lSucesso
793:     ENDPROC
794: 
795:     *--------------------------------------------------------------------------
796:     * BtnEncerrarClick - Fecha o form
797:     *   Espelha Buttons(4) Cancel=.T. / ESC
798:     *--------------------------------------------------------------------------
799:     PROCEDURE BtnEncerrarClick()
800:         THIS.Release()
801:     ENDPROC
802: 
803:     *--------------------------------------------------------------------------
804:     * AlternarPagina - Form REPORT nao tem PageFrame Lista/Dados como CRUD.
805:     *   Quando chamado, garante apresentacao do grid: recarrega dados se vazio
806:     *   e reposiciona o cursor crGrid no primeiro registro. Mantem assinatura
807:     *   compativel para chamadores genericos (par_nPagina ignorado).
808:     *--------------------------------------------------------------------------
809:     PROCEDURE AlternarPagina(par_nPagina)
810:         IF !USED("crGrid")
811:             THIS.CarregarGrade()
812:         ENDIF
813:         IF USED("crGrid")
814:             SELECT crGrid
815:             GO TOP
816:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
817:                 THIS.grd_4c_Dados.Refresh()
818:             ENDIF
819:             IF VARTYPE(THIS.txt_4c_Historico) = "O" AND !EOF("crGrid")
820:                 THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
821:                 THIS.txt_4c_Historico.Refresh()
822:             ENDIF
823:         ENDIF
824:     ENDPROC
825: 
826:     *--------------------------------------------------------------------------
827:     * GridAposLinhaColChange - Exibe Hists da linha atual em txt_4c_Historico
828:     *   Espelha Grid1.AfterRowColChange do legado:
829:     *     ThisForm.text1.Value = crGrid.Hists / ThisForm.text1.Refresh
830:     *   par_nColIndex: obrigatorio - BINDEVENT AfterRowColChange exige o parametro
831:     *--------------------------------------------------------------------------
832:     PROCEDURE GridAposLinhaColChange(par_nColIndex)
833:         IF USED("crGrid") AND !EOF("crGrid")
834:             THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
835:             THIS.txt_4c_Historico.Refresh()
836:         ENDIF
837:     ENDPROC
838: 
839:     *--------------------------------------------------------------------------
840:     * FormParaRelatorio - Propaga DataSessionId ao BO antes de imprimir/visualizar
841:     *   Neste form nao ha campos de filtro; o dado vem via DataSessionId passado
842:     *   no Init(). Garante que o BO esta sincronizado antes de cada acao.
843:     *--------------------------------------------------------------------------
844:     PROTECTED PROCEDURE FormParaRelatorio()
845:         IF VARTYPE(THIS.this_oRelatorio) = "O"
846:             THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
847:         ENDIF
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * FormParaBO - Consolida estado de exibicao no BO antes de cada acao
852:     *   Em forms CRUD esse metodo copia inputs do usuario para o BO. Aqui
853:     *   (REPORT) propaga a sessao de dados e a linha corrente do grid para
854:     *   que Visualizar/Imprimir/GerarDocumento usem o contexto certo.
855:     *--------------------------------------------------------------------------
856:     PROTECTED PROCEDURE FormParaBO()
857:         IF VARTYPE(THIS.this_oRelatorio) != "O"
858:             RETURN
859:         ENDIF
860:         THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
861:         IF USED("crGrid") AND !EOF("crGrid")
862:             THIS.this_oRelatorio.CarregarDoCursor("crGrid")
863:         ENDIF
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * BOParaForm - Reflete dados do BO (linha corrente) nos campos de exibicao
868:     *   Em forms CRUD copia propriedades this_* do BO para TextBoxes editaveis.
869:     *   Aqui atualiza apenas o textbox de Historico, que e o unico campo
870:     *   reflexivo do REPORT.
871:     *--------------------------------------------------------------------------
872:     PROTECTED PROCEDURE BOParaForm()
873:         IF VARTYPE(THIS.this_oRelatorio) != "O"
874:             RETURN
875:         ENDIF
876:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
877:             THIS.txt_4c_Historico.Value = ALLTRIM(THIS.this_oRelatorio.this_cHists)
878:             THIS.txt_4c_Historico.Refresh()
879:         ENDIF
880:     ENDPROC
881: 
882:     *--------------------------------------------------------------------------
883:     * CarregarLista - Recarrega o grid de diferencas e sincroniza o historico
884:     *   Em forms CRUD popula a Page1 (lista). Aqui delega para CarregarGrade
885:     *   (que repopula crGrid e configura colunas) e atualiza o textbox de
886:     *   Historico com a primeira linha. Mantem nomenclatura compativel.
887:     *--------------------------------------------------------------------------
888:     PROCEDURE CarregarLista()
889:         LOCAL loc_lSucesso
890:         loc_lSucesso = THIS.CarregarGrade()
891:         IF loc_lSucesso AND USED("crGrid") AND RECCOUNT("crGrid") > 0
892:             SELECT crGrid
893:             GO TOP
894:             IF VARTYPE(THIS.txt_4c_Historico) = "O"
895:                 THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
896:                 THIS.txt_4c_Historico.Refresh()
897:             ENDIF
898:         ENDIF
899:         RETURN loc_lSucesso
900:     ENDPROC
901: 
902:     *--------------------------------------------------------------------------
903:     * BtnBuscarClick - Recarrega o grid de diferencas a partir do BO
904:     *   Em forms CRUD abre busca/lookup. Aqui acionada via menu/teclado
905:     *   pelo usuario para reavaliar movaux/dif2 e refletir alteracoes.
906:     *--------------------------------------------------------------------------
907:     PROCEDURE BtnBuscarClick()
908:         THIS.CarregarLista()
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * BtnSalvarClick - Em REPORT "salvar" significa emitir o documento final
913:     *   Delega para BtnImprimirClick (gera saida fisica/PDF do relatorio).
914:     *--------------------------------------------------------------------------
915:     PROCEDURE BtnSalvarClick()
916:         THIS.FormParaBO()
917:         THIS.BtnImprimirClick()
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * BtnCancelarClick - Em REPORT "cancelar" equivale a encerrar a janela
922:     *   Delega para BtnEncerrarClick (Release do form).
923:     *--------------------------------------------------------------------------
924:     PROCEDURE BtnCancelarClick()
925:         THIS.BtnEncerrarClick()
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * LimparCampos - Limpa campos de exibicao e reseta a linha corrente
930:     *   Zera o textbox de Historico e reposiciona o cursor crGrid no inicio
931:     *   para apresentacao consistente apos qualquer acao.
932:     *--------------------------------------------------------------------------
933:     PROTECTED PROCEDURE LimparCampos()
934:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
935:             THIS.txt_4c_Historico.Value = ""
936:             THIS.txt_4c_Historico.Refresh()
937:         ENDIF
938:         IF USED("crGrid") AND RECCOUNT("crGrid") > 0
939:             SELECT crGrid
940:             GO TOP
941:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
942:                 THIS.grd_4c_Dados.Refresh()
943:             ENDIF
944:         ENDIF
945:     ENDPROC
946: 
947:     *--------------------------------------------------------------------------
948:     * HabilitarCampos - Form REPORT e sempre somente-leitura.
949:     *   txt_4c_Historico: Enabled=.F., ReadOnly=.T.
950:     *   grd_4c_Dados: ReadOnly=.T. em todas as colunas.
951:     *   par_lHabilitar ignorado (compatibilidade com FormBase).
952:     *--------------------------------------------------------------------------
953:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
954:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
955:             THIS.txt_4c_Historico.Enabled  = .F.
956:             THIS.txt_4c_Historico.ReadOnly = .T.
957:         ENDIF
958:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
959:             THIS.grd_4c_Dados.ReadOnly = .T.
960:             THIS.grd_4c_Dados.SetAll("ReadOnly", .T., "Column")
961:         ENDIF
962:     ENDPROC
963: 
964:     *--------------------------------------------------------------------------
965:     * AjustarBotoesPorModo - Mantem os 4 botoes do CommandGroup sempre ativos
966:     *   Form REPORT nao tem modos CRUD (Lista/Edicao); todas as acoes
967:     *   (Visualizar/Imprimir/Documento/Encerrar) ficam permanentemente
968:     *   disponiveis enquanto o form esta aberto.
969:     *--------------------------------------------------------------------------
970:     PROTECTED PROCEDURE AjustarBotoesPorModo()
971:         LOCAL loc_nI
972:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
973:             RETURN
974:         ENDIF
975:         FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
976:             THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
977:         ENDFOR
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     * Destroy - Libera referencia ao BO (NUNCA .Release() em objeto Custom/BO)
982:     *--------------------------------------------------------------------------
983:     PROCEDURE Destroy()
984:         IF VARTYPE(THIS.this_oRelatorio) = "O"
985:             THIS.this_oRelatorio = .NULL.
986:         ENDIF
987:         DODEFAULT()
988:     ENDPROC
989: 
990: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReDifBO.prg):
*==============================================================================
* SIGREDIFBO.PRG
* Business Object para Relatorio de Diferencas (SigReDif)
*
* Herda de RelatorioBase
* Exibe diferencas entre movimentacoes contabeis
* Recebe DataSessionId do form chamador para acessar cursores movaux/dif2
*==============================================================================

DEFINE CLASS SigReDifBO AS RelatorioBase

    *-- Sessao de dados do form chamador (DataSessionId)
    this_nDataSessionId = 0

    *-- Flag para exportacao PDF (lacpdf do legado)
    this_lAcPdf         = .F.

    *-- Cursor com os dados preparados para o grid
    this_cCursorDados   = "crGrid"

    *-- Mensagem de erro
    this_cMensagemErro  = ""

    *-- Propriedades mapeadas da linha atual do crGrid
    this_nAnoFis        = 0
    this_cDatas         = ""
    this_cContas        = ""
    this_cDebs          = ""
    this_cCreds         = ""
    this_cDocto         = ""
    this_cEmpCont       = ""
    this_nNumSeq        = 0
    this_nNums          = 0
    this_dData          = {}
    this_cValor         = ""
    this_cCecus         = ""
    this_cEmps          = ""
    this_cTransacaos    = ""
    this_cHists         = ""
    this_nDeb1s         = 0
    this_nCred1s        = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                THIS.this_cCursorDados = "crGrid"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Cria cursor crGrid a partir de movaux/dif2
    * Muda para sessao this_nDataSessionId onde movaux e dif2 existem,
    * executa SELECT, formata valores e posiciona no primeiro registro.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nSessaoOriginal, loc_nContagem
        loc_lSucesso = .F.
        loc_nSessaoOriginal = SET("Datasession")
        TRY
            *-- Muda para sessao do form chamador onde existem movaux e dif2
            IF THIS.this_nDataSessionId > 0
                SET DATASESSION TO (THIS.this_nDataSessionId)
            ENDIF

            *-- Valida existencia das tabelas de origem
            IF !USED("movaux") OR !USED("dif2")
                THIS.this_cMensagemErro = "Cursores 'movaux' e 'dif2' n" + CHR(227) + ;
                                          "o est" + CHR(227) + "o dispon" + CHR(237) + ;
                                          "veis na sess" + CHR(227) + "o de dados."
                MsgErro(THIS.this_cMensagemErro, "Erro")
                EXIT
            ENDIF

            *-- Fecha cursor anterior se existir
            IF USED("crGrid")
                SELECT crGrid
                USE
            ENDIF

            *-- Cursor com os mesmos dados do Cursor Diferenca
            SELECT *, ;
                   99999999.99 AS Deb1s, ;
                   99999999.99 AS Cred1s ;
            FROM movaux ;
            WHERE Transacaos IN (SELECT Transacaos FROM dif2) ;
            INTO CURSOR crGrid READWRITE

            *-- Verifica se ha registros para processar
            SELECT crGrid
            loc_nContagem = RECCOUNT("crGrid")

            IF loc_nContagem > 0
                *-- Formata debito e credito (centavos para formato moeda)
                REPLACE ALL Debs  WITH TRANSFORM(VAL(Debs)/100,  "@z 9,999,999.99") IN crGrid
                REPLACE ALL Creds WITH TRANSFORM(VAL(Creds)/100, "@z 9,999,999.99") IN crGrid

                *-- Formata valor total e numero do documento
                REPLACE ALL Valor WITH TRANSFORM(VAL(Valor), "@z 9,999,999.99") IN crGrid
                REPLACE ALL Docto WITH TRANSFORM(VAL(Docto), "@z 9999999999")   IN crGrid

                *-- Valores numericos para uso no relatorio FRX (remove separadores de milhar)
                REPLACE ALL Deb1s  WITH VAL(STRTRAN(Debs,  ",", "")) IN crGrid
                REPLACE ALL Cred1s WITH VAL(STRTRAN(Creds, ",", "")) IN crGrid

                SELECT crGrid
                LOCATE
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Restaura sessao de dados original (fora do TRY/CATCH)
        IF loc_nSessaoOriginal > 0 AND loc_nSessaoOriginal != SET("Datasession")
            SET DATASESSION TO (loc_nSessaoOriginal)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da linha atual do crGrid para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nAnoFis     = TratarNulo(AnoFis,     "N")
                THIS.this_cDatas      = TratarNulo(Datas,      "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cDebs       = TratarNulo(Debs,       "C")
                THIS.this_cCreds      = TratarNulo(Creds,      "C")
                THIS.this_cDocto      = TratarNulo(Docto,      "C")
                THIS.this_cEmpCont    = TratarNulo(EmpCont,    "C")
                THIS.this_nNumSeq     = TratarNulo(NumSeq,     "N")
                THIS.this_nNums       = TratarNulo(Nums,       "N")
                THIS.this_dData       = TratarNulo(Data,       "D")
                THIS.this_cValor      = TratarNulo(Valor,      "C")
                THIS.this_cCecus      = TratarNulo(Cecus,      "C")
                THIS.this_cEmps       = TratarNulo(Emps,       "C")
                THIS.this_cTransacaos = TratarNulo(Transacaos, "C")
                THIS.this_cHists      = TratarNulo(Hists,      "C")
                THIS.this_nDeb1s      = TratarNulo(Deb1s,      "N")
                THIS.this_nCred1s     = TratarNulo(Cred1s,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) PREVIEW NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDocumento - Imprime relatorio direto na impressora padrao
    *--------------------------------------------------------------------------
    PROCEDURE GerarDocumento()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) TO PRINTER NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

