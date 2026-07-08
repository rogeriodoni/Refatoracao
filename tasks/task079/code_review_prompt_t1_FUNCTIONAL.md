# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDif.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (989 linhas total):

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
167:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
168:         WITH THIS.cnt_4c_Cabecalho
169:             .Top         = 0
170:             .Left        = 0
171:             .Width       = THIS.Width
172:             .Height      = 80
173:             .BackStyle   = 1
174:             .BackColor   = RGB(100, 100, 100)
175:             .BorderWidth = 0
176:             .Visible     = .T.
177: 
178:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
179:             .AddObject("lbl_4c_Sombra", "Label")
180:             WITH .lbl_4c_Sombra
181:                 .Top       = 22
182:                 .Left      = 22
183:                 .Width     = THIS.Width
184:                 .Height    = 30
185:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
186:                 .FontName  = "Tahoma"
187:                 .FontSize  = 14
188:                 .FontBold  = .T.
189:                 .ForeColor = RGB(0, 0, 0)
190:                 .BackStyle = 0
191:                 .Visible   = .T.
192:             ENDWITH
193: 
194:             *-- Titulo em branco (sobre a sombra)
195:             .AddObject("lbl_4c_Titulo", "Label")
196:             WITH .lbl_4c_Titulo
197:                 .Top       = 20
198:                 .Left      = 20
199:                 .Width     = THIS.Width
200:                 .Height    = 30
201:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
202:                 .FontName  = "Tahoma"
203:                 .FontSize  = 14
204:                 .FontBold  = .T.
205:                 .ForeColor = RGB(255, 255, 255)
206:                 .BackStyle = 0

*-- Linhas 214 a 260:
214:     *   Geometria EXATA do framework frmrelatorio.vcx (BTNREPORT):
215:     *     cmg_4c_Botoes: Top=0, Left=529, Width=273, Height=80, ButtonCount=4
216:     *     Buttons: Left=5/71/137/203, Width=65, Height=70
217:     *   BINDEVENTs (Click) sao vinculados na Fase 7.
218:     *   Buttons(4).Cancel=.T. para fechar com ESC.
219:     *--------------------------------------------------------------------------
220:     PROTECTED PROCEDURE ConfigurarBotoes()
221:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
222:         WITH THIS.cmg_4c_Botoes
223:             .Top           = 0
224:             .Left          = 529
225:             .Width         = 273
226:             .Height        = 80
227:             .ButtonCount   = 4
228:             .BackStyle     = 0
229:             .BorderStyle   = 0
230:             .BorderColor   = RGB(136, 189, 188)
231:             .SpecialEffect = 1
232:             .Themes        = .F.
233:             .Visible       = .T.
234: 
235:             *-- Visualizar: exibe relatorio em preview na tela
236:             WITH .Buttons(1)
237:                 .Top             = 5
238:                 .Left            = 5
239:                 .Width           = 65
240:                 .Height          = 70
241:                 .Caption         = "Visualizar"
242:                 .FontBold        = .T.
243:                 .FontItalic      = .T.
244:                 .BackColor       = RGB(255, 255, 255)
245:                 .ForeColor       = RGB(90, 90, 90)
246:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
247:                 .PicturePosition = 13
248:                 .SpecialEffect   = 0
249:                 .MousePointer    = 15
250:                 .ToolTipText     = "Visualizar relat" + CHR(243) + "rio na tela"
251:                 .Themes          = .F.
252:                 .Visible         = .T.
253:             ENDWITH
254: 
255:             *-- Imprimir: envia relatorio com dialogo de selecao de impressora
256:             WITH .Buttons(2)
257:                 .Top             = 5
258:                 .Left            = 71
259:                 .Width           = 65
260:                 .Height          = 70

*-- Linhas 275 a 441:
275:             ENDWITH
276: 
277:             *-- Documento: imprime direto na impressora padrao (sem dialogo)
278:             *   Original: BTNREPORT.DOCEXCEL -> Procedure "documento"
279:             *   -> REPORT FORM SigReDif To Printer NoConsole
280:             WITH .Buttons(3)
281:                 .Top             = 5
282:                 .Left            = 137
283:                 .Width           = 65
284:                 .Height          = 70
285:                 .Caption         = "Documento"
286:                 .FontName        = "Comic Sans MS"
287:                 .FontBold        = .T.
288:                 .FontItalic      = .T.
289:                 .FontSize        = 8
290:                 .BackColor       = RGB(255, 255, 255)
291:                 .ForeColor       = RGB(90, 90, 90)
292:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
293:                 .PicturePosition = 13
294:                 .SpecialEffect   = 0
295:                 .MousePointer    = 15
296:                 .ToolTipText     = "Imprimir direto na impressora padr" + CHR(227) + "o"
297:                 .Themes          = .F.
298:                 .Visible         = .T.
299:             ENDWITH
300: 
301:             *-- Encerrar: fecha o form (Cancel=.T. ativa com ESC)
302:             WITH .Buttons(4)
303:                 .Top             = 5
304:                 .Left            = 203
305:                 .Width           = 65
306:                 .Height          = 70
307:                 .Caption         = "Encerrar"
308:                 .Cancel          = .T.
309:                 .FontName        = "Comic Sans MS"
310:                 .FontBold        = .T.
311:                 .FontItalic      = .T.
312:                 .FontSize        = 8
313:                 .BackColor       = RGB(255, 255, 255)
314:                 .ForeColor       = RGB(90, 90, 90)
315:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
316:                 .PicturePosition = 13
317:                 .SpecialEffect   = 0
318:                 .MousePointer    = 15
319:                 .ToolTipText     = "[Esc] Encerrar"
320:                 .Themes          = .F.
321:                 .Visible         = .T.
322:             ENDWITH
323:         ENDWITH
324: 
325:         *-- Vincula eventos Click dos botoes (metodos publicos do form)
326:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
327:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
328:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnDocumentoClick")
329:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
330:     ENDPROC
331: 
332:     *--------------------------------------------------------------------------
333:     * ConfigurarPaginaLista - Cria grid de 14 colunas, label e textbox Historico
334:     *   Espelha Grid1 (Top=168 Left=72 W=668 H=345), Label1 e Text1 do legado.
335:     *   RecordSource e ControlSources sao aplicados em CarregarGrade(), apos
336:     *   crGrid existir (criado por PrepararDados na sessao do chamador).
337:     *--------------------------------------------------------------------------
338:     PROTECTED PROCEDURE ConfigurarPaginaLista()
339:         THIS.AddObject("grd_4c_Dados", "Grid")
340:         WITH THIS.grd_4c_Dados
341:             .Top               = 168
342:             .Left              = 72
343:             .Width             = 668
344:             .Height            = 345
345:             .ColumnCount       = 14
346:             .FontName          = "Verdana"
347:             .FontSize          = 8
348:             .ForeColor         = RGB(90, 90, 90)
349:             .BackColor         = RGB(255, 255, 255)
350:             .GridLineColor     = RGB(238, 238, 238)
351:             .HighlightBackColor = RGB(255, 255, 255)
352:             .HighlightForeColor = RGB(15, 41, 104)
353:             .HighlightStyle    = 2
354:             .DeleteMark        = .F.
355:             .RecordMark        = .F.
356:             .RowHeight         = 16
357:             .ScrollBars        = 3
358:             .ReadOnly          = .T.
359:             .Visible           = .T.
360:         ENDWITH
361: 
362:         *-- AfterRowColChange mostra Hists da linha selecionada (espelha Grid1.AfterRowColChange)
363:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAposLinhaColChange")
364: 
365:         *-- Label "Historico:" (espelha Label1 do legado)
366:         THIS.AddObject("lbl_4c_Historico", "Label")
367:         WITH THIS.lbl_4c_Historico
368:             .Top       = 525
369:             .Left      = 72
370:             .Width     = 58
371:             .Height    = 15
372:             .Caption   = "Hist" + CHR(243) + "rico: "
373:             .FontName  = "Tahoma"
374:             .FontSize  = 8
375:             .ForeColor = RGB(90, 90, 90)
376:             .BackStyle = 0
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         *-- TextBox de historico (somente leitura - espelha Text1 WHEN=.F. do legado)
381:         THIS.AddObject("txt_4c_Historico", "TextBox")
382:         WITH THIS.txt_4c_Historico
383:             .Top      = 521
384:             .Left     = 140
385:             .Width    = 500
386:             .Height   = 23
387:             .Value    = ""
388:             .ReadOnly = .T.
389:             .Enabled  = .F.
390:             .FontName = "Tahoma"
391:             .FontSize = 8
392:             .Visible  = .T.
393:         ENDWITH
394:     ENDPROC
395: 
396:     *--------------------------------------------------------------------------
397:     * CarregarGrade - Chama PrepararDados e configura RecordSource/colunas/headers
398:     *   Chamado em Init() apos juntar DataSessionId do form chamador.
399:     *   Necessario chamar APOS juntar a sessao para que crGrid fique visivel.
400:     *--------------------------------------------------------------------------
401:     PROCEDURE CarregarGrade()
402:         LOCAL loc_lSucesso
403:         loc_lSucesso = .F.
404:         TRY
405:             IF VARTYPE(THIS.this_oRelatorio) = "O"
406:                 THIS.this_oRelatorio.PrepararDados()
407:             ENDIF
408: 
409:             IF USED("crGrid")
410:                 WITH THIS.grd_4c_Dados
411:                     .RecordSource = "crGrid"
412: 
413:                     *-- ControlSources das 14 colunas (campos do cursor crGrid/movaux)
414:                     .Column1.ControlSource  = "crGrid.AnoFis"
415:                     .Column2.ControlSource  = "Substr(crGrid.Datas,1,2)+[/]+Substr(crGrid.Datas,3,2)+[/]+Substr(crGrid.Datas,5,4)"
416:                     .Column3.ControlSource  = "crGrid.Contas"
417:                     .Column4.ControlSource  = "crGrid.Debs"
418:                     .Column5.ControlSource  = "crGrid.Creds"
419:                     .Column6.ControlSource  = "crGrid.Docto"
420:                     .Column7.ControlSource  = "crGrid.EmpCont"
421:                     .Column8.ControlSource  = "crGrid.NumSeq"
422:                     .Column9.ControlSource  = "crGrid.Nums"
423:                     .Column10.ControlSource = "crGrid.Data"
424:                     .Column11.ControlSource = "crGrid.Valor"
425:                     .Column12.ControlSource = "crGrid.Cecus"
426:                     .Column13.ControlSource = "crGrid.Emps"
427:                     .Column14.ControlSource = "crGrid.Transacaos"
428: 
429:                     *-- Redefine headers: RecordSource reseta captions (FORMCOR licao #2)
430:                     .Column1.Header1.Caption  = "Ano"
431:                     .Column2.Header1.Caption  = "Data"
432:                     .Column3.Header1.Caption  = "Conta"
433:                     .Column4.Header1.Caption  = "D" + CHR(233) + "bito"
434:                     .Column5.Header1.Caption  = "Cr" + CHR(233) + "dito"
435:                     .Column6.Header1.Caption  = "Documento"
436:                     .Column7.Header1.Caption  = "Cont."
437:                     .Column8.Header1.Caption  = "Seq."
438:                     .Column9.Header1.Caption  = "Numes"
439:                     .Column10.Header1.Caption = "Data"
440:                     .Column11.Header1.Caption = "Valor"
441:                     .Column12.Header1.Caption = "C. Custo"

*-- Linhas 496 a 551:
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message + CHR(13) + ;
498:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
499:                     "Procedure: " + loc_oErro.Procedure, "Erro CarregarGrade")
500:         ENDTRY
501:         RETURN loc_lSucesso
502:     ENDPROC
503: 
504:     *--------------------------------------------------------------------------
505:     * ConfigurarPaginaDados - Propriedades estruturais das 14 colunas do grid.
506:     *   Espelha Column1..Column14 do legado: Movable=.F., Resizable=.F.,
507:     *   ReadOnly=.T., InputMask/Format/Alignment/MaxLength onde definidos.
508:     *   Configura tambem Text1 de cada coluna (BorderStyle=0, Margin=0, cores).
509:     *   Chamado em ConfigurarPageFrame() apos ConfigurarPaginaLista().
510:     *--------------------------------------------------------------------------
511:     PROTECTED PROCEDURE ConfigurarPaginaDados()
512:         IF VARTYPE(THIS.grd_4c_Dados) != "O"
513:             RETURN
514:         ENDIF
515:         WITH THIS.grd_4c_Dados
516:             *-- Col 1: Ano fiscal (4 digitos numericos)
517:             WITH .Column1
518:                 .Movable   = .F.
519:                 .Resizable = .F.
520:                 .ReadOnly  = .T.
521:                 .InputMask = "9999"
522:             ENDWITH
523:             WITH .Column1.Text1
524:                 .BorderStyle = 0
525:                 .InputMask   = "9999"
526:                 .Margin      = 0
527:                 .ForeColor   = RGB(0, 0, 0)
528:                 .BackColor   = RGB(255, 255, 255)
529:             ENDWITH
530:             *-- Col 2: Data como string DDMMYYYY; Format="R" exibe com separadores
531:             WITH .Column2
532:                 .Movable   = .F.
533:                 .Resizable = .F.
534:                 .ReadOnly  = .T.
535:                 .Format    = "R"
536:             ENDWITH
537:             WITH .Column2.Text1
538:                 .BorderStyle = 0
539:                 .Margin      = 0
540:                 .ForeColor   = RGB(0, 0, 0)
541:                 .BackColor   = RGB(255, 255, 255)
542:             ENDWITH
543:             *-- Col 3: Conta contabil (9 digitos) - ForeColor cinza, FontName Tahoma
544:             WITH .Column3
545:                 .Movable   = .F.
546:                 .Resizable = .F.
547:                 .ReadOnly  = .T.
548:                 .InputMask = "999999999"
549:             ENDWITH
550:             WITH .Column3.Text1
551:                 .BorderStyle = 0

*-- Linhas 723 a 989:
723:     * BtnVisualizarClick - Exibe relatorio em preview na tela
724:     *   Espelha Buttons(1) -> REPORT FORM SigReDif Preview NoConsole
725:     *--------------------------------------------------------------------------
726:     PROCEDURE BtnVisualizarClick()
727:         LOCAL loc_lSucesso
728:         loc_lSucesso = .F.
729:         TRY
730:             IF VARTYPE(THIS.this_oRelatorio) = "O"
731:                 IF !THIS.this_oRelatorio.Visualizar()
732:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
733:                         "Erro ao Visualizar")
734:                 ELSE
735:                     loc_lSucesso = .T.
736:                 ENDIF
737:             ENDIF
738:         CATCH TO loc_oErro
739:             MsgErro(loc_oErro.Message + CHR(13) + ;
740:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
741:                 "Procedure: " + loc_oErro.Procedure, "Erro Visualizar")
742:         ENDTRY
743:         RETURN loc_lSucesso
744:     ENDPROC
745: 
746:     *--------------------------------------------------------------------------
747:     * BtnImprimirClick - Imprime relatorio com dialogo de selecao de impressora
748:     *   Espelha Buttons(2) -> REPORT FORM SigReDif To Printer Prompt NoConsole
749:     *--------------------------------------------------------------------------
750:     PROCEDURE BtnImprimirClick()
751:         LOCAL loc_lSucesso
752:         loc_lSucesso = .F.
753:         TRY
754:             IF VARTYPE(THIS.this_oRelatorio) = "O"
755:                 IF !THIS.this_oRelatorio.Imprimir()
756:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
757:                         "Erro ao Imprimir")
758:                 ELSE
759:                     loc_lSucesso = .T.
760:                 ENDIF
761:             ENDIF
762:         CATCH TO loc_oErro
763:             MsgErro(loc_oErro.Message + CHR(13) + ;
764:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
765:                 "Procedure: " + loc_oErro.Procedure, "Erro Imprimir")
766:         ENDTRY
767:         RETURN loc_lSucesso
768:     ENDPROC
769: 
770:     *--------------------------------------------------------------------------
771:     * BtnDocumentoClick - Imprime relatorio direto na impressora padrao
772:     *   Espelha Buttons(3) -> REPORT FORM SigReDif To Printer NoConsole
773:     *--------------------------------------------------------------------------
774:     PROCEDURE BtnDocumentoClick()
775:         LOCAL loc_lSucesso
776:         loc_lSucesso = .F.
777:         TRY
778:             IF VARTYPE(THIS.this_oRelatorio) = "O"
779:                 IF !THIS.this_oRelatorio.GerarDocumento()
780:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
781:                         "Erro ao Gerar Documento")
782:                 ELSE
783:                     loc_lSucesso = .T.
784:                 ENDIF
785:             ENDIF
786:         CATCH TO loc_oErro
787:             MsgErro(loc_oErro.Message + CHR(13) + ;
788:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
789:                 "Procedure: " + loc_oErro.Procedure, "Erro Documento")
790:         ENDTRY
791:         RETURN loc_lSucesso
792:     ENDPROC
793: 
794:     *--------------------------------------------------------------------------
795:     * BtnEncerrarClick - Fecha o form
796:     *   Espelha Buttons(4) Cancel=.T. / ESC
797:     *--------------------------------------------------------------------------
798:     PROCEDURE BtnEncerrarClick()
799:         THIS.Release()
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * AlternarPagina - Form REPORT nao tem PageFrame Lista/Dados como CRUD.
804:     *   Quando chamado, garante apresentacao do grid: recarrega dados se vazio
805:     *   e reposiciona o cursor crGrid no primeiro registro. Mantem assinatura
806:     *   compativel para chamadores genericos (par_nPagina ignorado).
807:     *--------------------------------------------------------------------------
808:     PROCEDURE AlternarPagina(par_nPagina)
809:         IF !USED("crGrid")
810:             THIS.CarregarGrade()
811:         ENDIF
812:         IF USED("crGrid")
813:             SELECT crGrid
814:             GO TOP
815:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
816:                 THIS.grd_4c_Dados.Refresh()
817:             ENDIF
818:             IF VARTYPE(THIS.txt_4c_Historico) = "O" AND !EOF("crGrid")
819:                 THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
820:                 THIS.txt_4c_Historico.Refresh()
821:             ENDIF
822:         ENDIF
823:     ENDPROC
824: 
825:     *--------------------------------------------------------------------------
826:     * GridAposLinhaColChange - Exibe Hists da linha atual em txt_4c_Historico
827:     *   Espelha Grid1.AfterRowColChange do legado:
828:     *     ThisForm.text1.Value = crGrid.Hists / ThisForm.text1.Refresh
829:     *   par_nColIndex: obrigatorio - BINDEVENT AfterRowColChange exige o parametro
830:     *--------------------------------------------------------------------------
831:     PROCEDURE GridAposLinhaColChange(par_nColIndex)
832:         IF USED("crGrid") AND !EOF("crGrid")
833:             THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
834:             THIS.txt_4c_Historico.Refresh()
835:         ENDIF
836:     ENDPROC
837: 
838:     *--------------------------------------------------------------------------
839:     * FormParaRelatorio - Propaga DataSessionId ao BO antes de imprimir/visualizar
840:     *   Neste form nao ha campos de filtro; o dado vem via DataSessionId passado
841:     *   no Init(). Garante que o BO esta sincronizado antes de cada acao.
842:     *--------------------------------------------------------------------------
843:     PROTECTED PROCEDURE FormParaRelatorio()
844:         IF VARTYPE(THIS.this_oRelatorio) = "O"
845:             THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
846:         ENDIF
847:     ENDPROC
848: 
849:     *--------------------------------------------------------------------------
850:     * FormParaBO - Consolida estado de exibicao no BO antes de cada acao
851:     *   Em forms CRUD esse metodo copia inputs do usuario para o BO. Aqui
852:     *   (REPORT) propaga a sessao de dados e a linha corrente do grid para
853:     *   que Visualizar/Imprimir/GerarDocumento usem o contexto certo.
854:     *--------------------------------------------------------------------------
855:     PROTECTED PROCEDURE FormParaBO()
856:         IF VARTYPE(THIS.this_oRelatorio) != "O"
857:             RETURN
858:         ENDIF
859:         THIS.this_oRelatorio.this_nDataSessionId = THIS.this_nDataSessionId
860:         IF USED("crGrid") AND !EOF("crGrid")
861:             THIS.this_oRelatorio.CarregarDoCursor("crGrid")
862:         ENDIF
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * BOParaForm - Reflete dados do BO (linha corrente) nos campos de exibicao
867:     *   Em forms CRUD copia propriedades this_* do BO para TextBoxes editaveis.
868:     *   Aqui atualiza apenas o textbox de Historico, que e o unico campo
869:     *   reflexivo do REPORT.
870:     *--------------------------------------------------------------------------
871:     PROTECTED PROCEDURE BOParaForm()
872:         IF VARTYPE(THIS.this_oRelatorio) != "O"
873:             RETURN
874:         ENDIF
875:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
876:             THIS.txt_4c_Historico.Value = ALLTRIM(THIS.this_oRelatorio.this_cHists)
877:             THIS.txt_4c_Historico.Refresh()
878:         ENDIF
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * CarregarLista - Recarrega o grid de diferencas e sincroniza o historico
883:     *   Em forms CRUD popula a Page1 (lista). Aqui delega para CarregarGrade
884:     *   (que repopula crGrid e configura colunas) e atualiza o textbox de
885:     *   Historico com a primeira linha. Mantem nomenclatura compativel.
886:     *--------------------------------------------------------------------------
887:     PROCEDURE CarregarLista()
888:         LOCAL loc_lSucesso
889:         loc_lSucesso = THIS.CarregarGrade()
890:         IF loc_lSucesso AND USED("crGrid") AND RECCOUNT("crGrid") > 0
891:             SELECT crGrid
892:             GO TOP
893:             IF VARTYPE(THIS.txt_4c_Historico) = "O"
894:                 THIS.txt_4c_Historico.Value = ALLTRIM(crGrid.Hists)
895:                 THIS.txt_4c_Historico.Refresh()
896:             ENDIF
897:         ENDIF
898:         RETURN loc_lSucesso
899:     ENDPROC
900: 
901:     *--------------------------------------------------------------------------
902:     * BtnBuscarClick - Recarrega o grid de diferencas a partir do BO
903:     *   Em forms CRUD abre busca/lookup. Aqui acionada via menu/teclado
904:     *   pelo usuario para reavaliar movaux/dif2 e refletir alteracoes.
905:     *--------------------------------------------------------------------------
906:     PROCEDURE BtnBuscarClick()
907:         THIS.CarregarLista()
908:     ENDPROC
909: 
910:     *--------------------------------------------------------------------------
911:     * BtnSalvarClick - Em REPORT "salvar" significa emitir o documento final
912:     *   Delega para BtnImprimirClick (gera saida fisica/PDF do relatorio).
913:     *--------------------------------------------------------------------------
914:     PROCEDURE BtnSalvarClick()
915:         THIS.FormParaBO()
916:         THIS.BtnImprimirClick()
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * BtnCancelarClick - Em REPORT "cancelar" equivale a encerrar a janela
921:     *   Delega para BtnEncerrarClick (Release do form).
922:     *--------------------------------------------------------------------------
923:     PROCEDURE BtnCancelarClick()
924:         THIS.BtnEncerrarClick()
925:     ENDPROC
926: 
927:     *--------------------------------------------------------------------------
928:     * LimparCampos - Limpa campos de exibicao e reseta a linha corrente
929:     *   Zera o textbox de Historico e reposiciona o cursor crGrid no inicio
930:     *   para apresentacao consistente apos qualquer acao.
931:     *--------------------------------------------------------------------------
932:     PROTECTED PROCEDURE LimparCampos()
933:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
934:             THIS.txt_4c_Historico.Value = ""
935:             THIS.txt_4c_Historico.Refresh()
936:         ENDIF
937:         IF USED("crGrid") AND RECCOUNT("crGrid") > 0
938:             SELECT crGrid
939:             GO TOP
940:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
941:                 THIS.grd_4c_Dados.Refresh()
942:             ENDIF
943:         ENDIF
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * HabilitarCampos - Form REPORT e sempre somente-leitura.
948:     *   txt_4c_Historico: Enabled=.F., ReadOnly=.T.
949:     *   grd_4c_Dados: ReadOnly=.T. em todas as colunas.
950:     *   par_lHabilitar ignorado (compatibilidade com FormBase).
951:     *--------------------------------------------------------------------------
952:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
953:         IF VARTYPE(THIS.txt_4c_Historico) = "O"
954:             THIS.txt_4c_Historico.Enabled  = .F.
955:             THIS.txt_4c_Historico.ReadOnly = .T.
956:         ENDIF
957:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
958:             THIS.grd_4c_Dados.ReadOnly = .T.
959:             THIS.grd_4c_Dados.SetAll("ReadOnly", .T., "Column")
960:         ENDIF
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     * AjustarBotoesPorModo - Mantem os 4 botoes do CommandGroup sempre ativos
965:     *   Form REPORT nao tem modos CRUD (Lista/Edicao); todas as acoes
966:     *   (Visualizar/Imprimir/Documento/Encerrar) ficam permanentemente
967:     *   disponiveis enquanto o form esta aberto.
968:     *--------------------------------------------------------------------------
969:     PROTECTED PROCEDURE AjustarBotoesPorModo()
970:         LOCAL loc_nI
971:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
972:             RETURN
973:         ENDIF
974:         FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
975:             THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
976:         ENDFOR
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * Destroy - Libera referencia ao BO (NUNCA .Release() em objeto Custom/BO)
981:     *--------------------------------------------------------------------------
982:     PROCEDURE Destroy()
983:         IF VARTYPE(THIS.this_oRelatorio) = "O"
984:             THIS.this_oRelatorio = .NULL.
985:         ENDIF
986:         DODEFAULT()
987:     ENDPROC
988: 
989: ENDDEFINE


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

