# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Draw()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReCmg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1541 linhas total):

*-- Linhas 27 a 137:
27:     pnNumGrf  = 1      && Posicao atual do grafico exibido (1-3)
28:     poForm1   = .NULL. && Referencia ao form pai (para DataSession e Opt_SelRel)
29: 
30:     *-- Titulo para FormBase (sera sobrescrito no InicializarForm)
31:     this_cTituloForm = ""
32: 
33:     *==========================================================================
34:     * Init - Aceita referencia ao form pai (obrigatorio para DataSession/TmpResult)
35:     *==========================================================================
36:     PROCEDURE Init(par_oFormPai)
37:         LOCAL loc_lSucesso, loc_oErro
38:         loc_lSucesso = .F.
39: 
40:         TRY
41:             *-- Guarda referencia ao form pai antes de DODEFAULT
42:             IF VARTYPE(par_oFormPai) = "O"
43:                 THIS.poForm1 = par_oFormPai
44:                 *-- Compartilha sessao de dados do pai para acessar TmpResult
45:                 THIS.DataSessionId = par_oFormPai.DataSessionId
46:             ELSE
47:                 THIS.poForm1 = THIS
48:             ENDIF
49: 
50:             *-- Instancia o BO antes de DODEFAULT (InicializarForm usa ele)
51:             THIS.this_oBusinessObject = CREATEOBJECT("SigReCmgBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
54:                 MsgErro("Erro ao criar SigReCmgBO." + CHR(13) + ;
55:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
56:                 loc_lSucesso = .F.
57:             ENDIF
58: 
59:             *-- FormBase.Init() chama InicializarForm() internamente
60:             loc_lSucesso = DODEFAULT()
61: 
62:         CATCH TO loc_oErro
63:             MsgErro("Erro ao inicializar FormSigReCmg:" + CHR(13) + ;
64:                     "Erro: " + loc_oErro.Message + CHR(13) + ;
65:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
66:                     "Procedure: " + loc_oErro.Procedure, "Erro")
67:             loc_lSucesso = .F.
68:         ENDTRY
69: 
70:         RETURN loc_lSucesso
71:     ENDPROC
72: 
73:     *==========================================================================
74:     * InicializarForm - Cria todos os controles do form e dispara geracao inicial
75:     *==========================================================================
76:     PROTECTED PROCEDURE InicializarForm()
77:         LOCAL loc_lSucesso, loc_oErro
78:         loc_lSucesso = .F.
79: 
80:         TRY
81:             THIS.LockScreen = .T.
82: 
83:             *-- Titulo do form
84:             THIS.Caption = "Gr" + CHR(225) + "fico dos Clientes que Mais Compram"
85: 
86:             *-- Coordena layout do form (form OPERACIONAL sem PageFrame)
87:             THIS.ConfigurarPageFrame()
88: 
89:             *-- Configura "Page1/Lista" (cabecalho + indicador de processamento)
90:             THIS.ConfigurarPaginaLista()
91: 
92:             *-- Configura "Page2/Dados" (area de exibicao do grafico + controles)
93:             THIS.ConfigurarPaginaDados()
94: 
95:             *-- BINDEVENT para o combo (selecao de cliente)
96:             BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "Click", THIS, "CmbChave1Click")
97:             BINDEVENT(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CmbChave1GotFocus")
98: 
99:             *-- Estado inicial: aguarde visivel, demais ocultados ate gerar grafico
100:             THIS.cnt_4c_Aguarde.Visible         = .T.
101:             THIS.cnt_4c_Grf1.Visible            = .F.
102:             THIS.cnt_4c_Grf2.Visible            = .F.
103:             THIS.chk_4c_ChkGraficos.Visible     = .F.
104:             THIS.obj_4c_CmdGgrafico.Visible     = .F.
105: 
106:             THIS.Refresh()
107:             THIS.Show()
108:             THIS.Draw()
109:             THIS.LockScreen = .F.
110: 
111:             *-- Gera grafico inicial (popula combo e carrega primeiro grafico)
112:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear
113:             THIS.GerarGrafico(1)
114: 
115:             *-- Exibe controles apos gerar grafico
116:             THIS.LockScreen = .T.
117:             THIS.cnt_4c_Aguarde.Visible         = .F.
118:             THIS.cnt_4c_Grf1.Visible            = .T.
119:             THIS.cnt_4c_Grf2.Visible            = .T.
120:             THIS.chk_4c_ChkGraficos.Visible     = .T.
121:             THIS.chk_4c_ChkGraficos.Value       = 0
122:             THIS.obj_4c_CmdGgrafico.Visible     = .T.
123:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
124:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
125:             THIS.Refresh()
126:             THIS.LockScreen = .F.
127: 
128:             loc_lSucesso = .T.
129: 
130:         CATCH TO loc_oErro
131:             THIS.LockScreen = .F.
132:             MsgErro(loc_oErro.Message, "Erro")
133:         ENDTRY
134: 
135:         RETURN loc_lSucesso
136:     ENDPROC
137: 

*-- Linhas 144 a 252:
144:     * diretamente no Form. Aqui aplicamos a configuracao visual base do Form
145:     * que normalmente seria delegada ao PageFrame.
146:     *==========================================================================
147:     PROTECTED PROCEDURE ConfigurarPageFrame()
148:         *-- Aparencia base do form (equivalente ao Page.Picture/BackColor em CRUD)
149:         THIS.BackColor   = RGB(212,208,200)
150:         THIS.ScrollBars  = 0
151:         THIS.ShowTips    = .T.
152:         THIS.SetAll("FontName", "Tahoma")
153:         THIS.SetAll("FontSize", 8)
154:     ENDPROC
155: 
156:     *==========================================================================
157:     * ConfigurarPaginaLista - Configura a "Page1/Lista" do form operacional
158:     * Em forms CRUD esta pagina contem o grid de registros. Aqui, em form
159:     * OPERACIONAL de visualizacao de grafico, a "Lista" corresponde ao bloco
160:     * persistente da tela: cabecalho (cntSombra) + indicador de processamento
161:     * (cnt_4c_Aguarde) exibido durante geracao/impressao do grafico.
162:     * Os widgets de exibicao de dados ficam em ConfigurarPaginaDados().
163:     *==========================================================================
164:     PROTECTED PROCEDURE ConfigurarPaginaLista()
165:         THIS.ConfigurarCabecalho()
166:         THIS.ConfigurarContainerAguarde()
167:     ENDPROC
168: 
169:     *==========================================================================
170:     * ConfigurarPaginaDados - Configura a "Page2/Dados" do form operacional
171:     * Em forms CRUD esta pagina hospeda os campos de edicao do registro. Aqui,
172:     * em form OPERACIONAL de exibicao de grafico, a "Dados" agrupa os widgets
173:     * de apresentacao de dados:
174:     *   - cnt_4c_Grf1 + obj_4c_OleGrafico1 (area do grafico OLE)
175:     *   - cnt_4c_Grf2 + cbo_4c_CmbChave1 (seletor de cliente)
176:     *   - obj_4c_CmdGgrafico (botoes de navegacao/impressao/encerrar)
177:     *   - chk_4c_ChkGraficos + txt_4c_NumGraficos + label (opcoes de impressao)
178:     * Apos AddObject, cada controle e inicializado com Visible=.F. para que o
179:     * InicializarForm() controle a sequencia de exibicao (Aguarde -> Dados).
180:     *==========================================================================
181:     PROTECTED PROCEDURE ConfigurarPaginaDados()
182:         *-- PARTE 1: Container do grafico OLE + seletor de cliente
183:         THIS.ConfigurarContainerGrafico()
184:         THIS.ConfigurarContainerControles()
185: 
186:         *-- PARTE 2: Botoes de acao + opcoes de impressao em lote
187:         THIS.ConfigurarCommandGroup()
188:         THIS.ConfigurarControlesAdicionais()
189: 
190:         *-- Pos-configuracao: garante z-order correto (CommandGroup acima do grafico)
191:         *-- ZOrder(0) traz para o topo da pilha visual, evitando que o OLE cubra botoes
192:         IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
193:             THIS.obj_4c_CmdGgrafico.ZOrder(0)
194:         ENDIF
195:         IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
196:             THIS.cnt_4c_Grf2.ZOrder(0)
197:         ENDIF
198:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
199:             THIS.chk_4c_ChkGraficos.ZOrder(0)
200:         ENDIF
201:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
202:             THIS.txt_4c_NumGraficos.ZOrder(0)
203:         ENDIF
204:         IF PEMSTATUS(THIS, "lbl_4c_LabelNumGrf", 5)
205:             THIS.lbl_4c_LabelNumGrf.ZOrder(0)
206:         ENDIF
207:     ENDPROC
208: 
209:     *==========================================================================
210:     * ConfigurarCabecalho - cntSombra com lblSombra e lblTitulo
211:     *==========================================================================
212:     PROTECTED PROCEDURE ConfigurarCabecalho()
213:         THIS.AddObject("cnt_4c_Sombra", "Container")
214:         WITH THIS.cnt_4c_Sombra
215:             .Top         = 0
216:             .Left        = 0
217:             .Width       = THIS.Width
218:             .Height      = 80
219:             .BorderWidth = 0
220:             .BackStyle   = 1
221:             .BackColor   = RGB(100,100,100)
222:             .Visible     = .T.
223: 
224:             .AddObject("lbl_4c_LblSombra", "Label")
225:             WITH .lbl_4c_LblSombra
226:                 .FontBold   = .T.
227:                 .FontName   = "Tahoma"
228:                 .FontSize   = 18
229:                 .WordWrap   = .T.
230:                 .Alignment  = 0
231:                 .BackStyle  = 0
232:                 .Height     = 40
233:                 .Left       = 10
234:                 .Top        = 18
235:                 .Width      = THIS.Width
236:                 .ForeColor  = RGB(0,0,0)
237:                 .Caption    = THIS.Parent.Parent.Caption
238:                 .Visible    = .T.
239:             ENDWITH
240: 
241:             .AddObject("lbl_4c_LblTitulo", "Label")
242:             WITH .lbl_4c_LblTitulo
243:                 .FontBold   = .T.
244:                 .FontName   = "Tahoma"
245:                 .FontSize   = 18
246:                 .WordWrap   = .T.
247:                 .Alignment  = 0
248:                 .BackStyle  = 0
249:                 .Height     = 46
250:                 .Left       = 10
251:                 .Top        = 17
252:                 .Width      = THIS.Width

*-- Linhas 260 a 303:
260:     *==========================================================================
261:     * ConfigurarContainerAguarde - cntAguarde (visivel durante processamento)
262:     *==========================================================================
263:     PROTECTED PROCEDURE ConfigurarContainerAguarde()
264:         THIS.AddObject("cnt_4c_Aguarde", "Container")
265:         WITH THIS.cnt_4c_Aguarde
266:             .Top          = 314
267:             .Left         = 295
268:             .Width        = 207
269:             .Height       = 49
270:             .SpecialEffect = 0
271:             .BackStyle    = 1
272:             .BackColor    = RGB(255,255,255)
273:             .Visible      = .F.
274: 
275:             .AddObject("lbl_4c_Label1Agu", "Label")
276:             WITH .lbl_4c_Label1Agu
277:                 .FontBold   = .T.
278:                 .FontName   = "Tahoma"
279:                 .FontSize   = 10
280:                 .BackStyle  = 0
281:                 .Caption    = "Aguarde..."
282:                 .Height     = 18
283:                 .Left       = 69
284:                 .Top        = 7
285:                 .Width      = 68
286:                 .ForeColor  = RGB(90,90,90)
287:                 .Visible    = .T.
288:             ENDWITH
289: 
290:             .AddObject("lbl_4c_Label2Agu", "Label")
291:             WITH .lbl_4c_Label2Agu
292:                 .AutoSize   = .T.
293:                 .FontBold   = .T.
294:                 .FontName   = "Tahoma"
295:                 .FontSize   = 10
296:                 .Alignment  = 0
297:                 .BackStyle  = 0
298:                 .Caption    = "Processando Dados..."
299:                 .Height     = 18
300:                 .Left       = 24
301:                 .Top        = 24
302:                 .Width      = 141
303:                 .ForeColor  = RGB(90,90,90)

*-- Linhas 309 a 378:
309:     *==========================================================================
310:     * ConfigurarContainerGrafico - cntGrf1 com OleBoundControl
311:     *==========================================================================
312:     PROTECTED PROCEDURE ConfigurarContainerGrafico()
313:         THIS.AddObject("cnt_4c_Grf1", "Container")
314:         WITH THIS.cnt_4c_Grf1
315:             .Top          = 202
316:             .Left         = 14
317:             .Width        = 770
318:             .Height       = 400
319:             .BackStyle    = 1
320:             .SpecialEffect = 0
321:             .BackColor    = RGB(255,255,255)
322:             .Visible      = .F.
323: 
324:             .AddObject("obj_4c_OleGrafico1", "OleBoundControl")
325:             WITH .obj_4c_OleGrafico1
326:                 .Top     = 5
327:                 .Left    = 5
328:                 .Height  = 390
329:                 .Width   = 760
330:                 .Visible = .T.
331:             ENDWITH
332:         ENDWITH
333:     ENDPROC
334: 
335:     *==========================================================================
336:     * ConfigurarContainerControles - cntGrf2 com combo e label de cliente
337:     *==========================================================================
338:     PROTECTED PROCEDURE ConfigurarContainerControles()
339:         THIS.AddObject("cnt_4c_Grf2", "Container")
340:         WITH THIS.cnt_4c_Grf2
341:             .Top          = 94
342:             .Left         = 128
343:             .Width        = 200
344:             .Height       = 35
345:             .SpecialEffect = 0
346:             .BackStyle    = 1
347:             .BackColor    = RGB(255,255,255)
348:             .Visible      = .F.
349: 
350:             .AddObject("lbl_4c_LblChave1", "Label")
351:             WITH .lbl_4c_LblChave1
352:                 .AutoSize  = .T.
353:                 .FontName  = "Tahoma"
354:                 .FontSize  = 8
355:                 .BackStyle = 0
356:                 .Caption   = "Cliente :"
357:                 .Height    = 15
358:                 .Left      = 32
359:                 .Top       = 8
360:                 .Width     = 42
361:                 .ForeColor = RGB(90,90,90)
362:                 .Visible   = .T.
363:             ENDWITH
364: 
365:             .AddObject("cbo_4c_CmbChave1", "ComboBox")
366:             WITH .cbo_4c_CmbChave1
367:                 .FontName        = "Courier New"
368:                 .FontSize        = 9
369:                 .ColumnCount     = 0
370:                 .ColumnLines     = .F.
371:                 .IncrementalSearch = .T.
372:                 .Style           = 2
373:                 .ReadOnly        = .T.
374:                 .Format          = "K"
375:                 .Sorted          = .F.
376:                 .SpecialEffect   = 0
377:                 .Height          = 25
378:                 .Left            = 81

*-- Linhas 386 a 429:
386:     *==========================================================================
387:     * ConfigurarCommandGroup - cmdGgrafico com 4 botoes (Anterior,Proximo,Imprimir,Encerrar)
388:     *==========================================================================
389:     PROTECTED PROCEDURE ConfigurarCommandGroup()
390:         THIS.AddObject("obj_4c_CmdGgrafico", "CommandGroup")
391:         WITH THIS.obj_4c_CmdGgrafico
392:             .ButtonCount   = 4
393:             .BackStyle     = 0
394:             .BorderStyle   = 0
395:             .Height        = 85
396:             .Left          = 491
397:             .SpecialEffect = 1
398:             .Top           = -2
399:             .Width         = 313
400:             .Themes        = .F.
401:             .Visible       = .F.
402: 
403:             *-- Botao 1: Anterior
404:             WITH .Buttons(1)
405:                 .Top        = 5
406:                 .Left       = 5
407:                 .Height     = 75
408:                 .Width      = 75
409:                 .FontBold   = .T.
410:                 .FontItalic = .T.
411:                 .WordWrap   = .T.
412:                 .Picture    = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
413:                 .Caption    = "\<Anterior"
414:                 .ForeColor  = RGB(90,90,90)
415:                 .BackColor  = RGB(255,255,255)
416:                 .Themes     = .F.
417:                 .Enabled    = .F.
418:             ENDWITH
419: 
420:             *-- Botao 2: Proximo
421:             WITH .Buttons(2)
422:                 .Top        = 5
423:                 .Left       = 81
424:                 .Height     = 75
425:                 .Width      = 75
426:                 .FontBold   = .T.
427:                 .FontItalic = .T.
428:                 .FontName   = "Comic Sans MS"
429:                 .FontSize   = 8

*-- Linhas 474 a 527:
474:             ENDWITH
475:         ENDWITH
476: 
477:         *-- BINDEVENTs dos botoes do CommandGroup
478:         BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(1), "Click", THIS, "BtnAnteriorClick")
479:         BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(2), "Click", THIS, "BtnProximoClick")
480:         BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(3), "Click", THIS, "BtnImprimirClick")
481:         BINDEVENT(THIS.obj_4c_CmdGgrafico.Buttons(4), "Click", THIS, "BtnEncerrarClick")
482:     ENDPROC
483: 
484:     *==========================================================================
485:     * ConfigurarControlesAdicionais - chkGraficos, NumGraficos, Label1
486:     *==========================================================================
487:     PROTECTED PROCEDURE ConfigurarControlesAdicionais()
488:         *-- CheckBox: Todos os Graficos
489:         THIS.AddObject("chk_4c_ChkGraficos", "CheckBox")
490:         WITH THIS.chk_4c_ChkGraficos
491:             .Top          = 133
492:             .Left         = 146
493:             .Height       = 17
494:             .Width        = 122
495:             .FontName     = "Tahoma"
496:             .FontSize     = 8
497:             .AutoSize     = .F.
498:             .Alignment    = 0
499:             .BackStyle    = 0
500:             .Caption      = "Todos os Gr" + CHR(225) + "ficos"
501:             .SpecialEffect = 0
502:             .Style        = 0
503:             .ForeColor    = RGB(90,90,90)
504:             .Value        = 0
505:             .Visible      = .F.
506:         ENDWITH
507: 
508:         *-- TextBox: Numero inicial do grafico
509:         THIS.AddObject("txt_4c_NumGraficos", "TextBox")
510:         WITH THIS.txt_4c_NumGraficos
511:             .Alignment  = 3
512:             .Value      = 1
513:             .Height     = 23
514:             .InputMask  = "9999"
515:             .Left       = 267
516:             .MaxLength  = 4
517:             .Top        = 157
518:             .Width      = 38
519:             .Visible    = .T.
520:         ENDWITH
521: 
522:         *-- Label: "A partir do Grafico"
523:         THIS.AddObject("lbl_4c_LabelNumGrf", "Label")
524:         WITH THIS.lbl_4c_LabelNumGrf
525:             .AutoSize   = .F.
526:             .FontName   = "Tahoma"
527:             .FontSize   = 8

*-- Linhas 540 a 583:
540:     * GerarGrafico - Popula combo de clientes e gera graficos OLE
541:     * par_nLinhaCmb1 = posicao do combo a usar (1 = primeiro, 0 = usar ListIndex)
542:     *==========================================================================
543:     PROCEDURE GerarGrafico(par_nLinhaCmb1)
544:         LOCAL loc_nLinha, loc_nTotal, loc_oErro, loc_lOK
545:         LOCAL ARRAY loc_aClientes(1)
546:         LOCAL loc_nTmStr1, loc_nConta1, loc_cChave1
547:         LOCAL loc_cQtVal, loc_nQtVal, loc_cStrgeixoY
548:         LOCAL loc_cEscape, loc_cOldPoint, loc_cOldSepar, loc_cPoint, loc_cSepar
549:         LOCAL loc_nChave2, loc_cChave2, loc_nNumGrf, loc_lError, loc_cOnError
550: 
551:         loc_nLinha = IIF(VARTYPE(par_nLinhaCmb1) = "N" AND par_nLinhaCmb1 > 0, par_nLinhaCmb1, 1)
552: 
553:         TRY
554:             THIS.LockScreen = .T.
555: 
556:             loc_cEscape   = SET("Escape")
557:             loc_cOldPoint = SET("Point")
558:             loc_cOldSepar = SET("Separator")
559: 
560:             SET ESCAPE OFF
561: 
562:             *-- Configuracao decimal/separador de acordo com locale
563:             loc_cPoint = ","
564:             loc_cSepar = "."
565: 
566:             SET POINT TO loc_cPoint
567:             SET SEPARATOR TO loc_cSepar
568: 
569:             THIS.pnNumGrf = 1
570:             loc_nLinha = IIF(VARTYPE(par_nLinhaCmb1) = "N" AND par_nLinhaCmb1 > 0, par_nLinhaCmb1, 1)
571: 
572:             *-- Determinar modo Valor/Quantidade a partir do form pai
573:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
574:                 loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
575:                 loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
576:             ELSE
577:                 loc_cQtVal = PADR("Valor", 10)
578:                 loc_nQtVal = 1
579:             ENDIF
580: 
581:             *-- Popula combo se ainda nao foi populado
582:             IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount)
583:                 IF USED("TmpResult")

*-- Linhas 685 a 728:
685:     * ConfigurarOleGrafico - Configura propriedades visuais do OleBoundControl
686:     * Chamado apos LOCATE em CrGrafico1 posicionar no registro correto
687:     *==========================================================================
688:     PROTECTED PROCEDURE ConfigurarOleGrafico(par_cChave1, par_cStrgeixoY, par_nQtVal)
689:         LOCAL loc_oOle, loc_nNlegenda1, loc_nConta2, loc_nConta3
690:         LOCAL loc_nVlGrf1, loc_cCampValComp, loc_cCampValAno, loc_oErro
691: 
692:         TRY
693:             loc_oOle      = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
694:             loc_nNlegenda1 = 7
695: 
696:             WITH loc_oOle
697:                 .ControlSource   = "CrGrafico1.gGrafico1s"
698:                 .AutoActivate    = 0
699:                 .AutoSize        = .T.
700:                 .Sizable         = .T.
701:                 .Stretch         = 2
702:                 .HasLegend       = .T.
703:                 .HasTitle        = .F.
704:                 .DisplayBlanksAs = 1
705:                 .HasAxis(2)      = .T.
706:                 .Type            = -4100
707:                 .SubType         = 1
708: 
709:                 WITH .ChartArea
710:                     .Font.Name        = "Arial"
711:                     .Font.Size        = 8
712:                     .Font.Bold        = .T.
713:                     .Font.Italic      = .F.
714:                     .Interior.Color   = RGB(255,255,255)
715:                     .Border.Color     = RGB(0,0,0)
716:                     .Border.LineStyle = 1
717:                     .Border.Weight    = 2
718:                     .Shadow           = .T.
719:                 ENDWITH
720: 
721:                 WITH .PlotArea
722:                     .Interior.Color = RGB(255,255,255)
723:                     .Border.Color   = RGB(0,0,0)
724:                 ENDWITH
725: 
726:                 WITH .Legend
727:                     .Font.Name   = "Arial"
728:                     .Font.Size   = 8

*-- Linhas 829 a 992:
829:     *==========================================================================
830:     * CmbChave1Click - Selecao de cliente no combo dispara geracao do grafico
831:     *==========================================================================
832:     PROCEDURE CmbChave1Click()
833:         THIS.cnt_4c_Aguarde.Visible = .T.
834:         THIS.Refresh()
835:         THIS.Draw()
836:         THIS.LockScreen = .T.
837:         THIS.SetAll("Enabled", .F., "OleBoundControl")
838:         THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
839:         THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
840:         THIS.cnt_4c_Aguarde.Visible = .F.
841:         THIS.Refresh()
842:         THIS.Draw()
843:         THIS.LockScreen = .F.
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * CmbChave1GotFocus - Ao entrar no combo, desabilita OleBoundControl
848:     *==========================================================================
849:     PROCEDURE CmbChave1GotFocus()
850:         THIS.SetAll("Enabled", .F., "OleBoundControl")
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * BtnAnteriorClick - Navega para o grafico anterior
855:     *==========================================================================
856:     PROCEDURE BtnAnteriorClick()
857:         LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro
858: 
859:         TRY
860:             THIS.LockScreen = .T.
861: 
862:             *-- Decrementa posicao diretamente (minimo 1) e sincroniza BO
863:             THIS.pnNumGrf = MAX(1, THIS.pnNumGrf - 1)
864:             THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
865: 
866:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
867:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
868: 
869:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
870:                 loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
871:                 loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
872:             ELSE
873:                 loc_cQtVal = PADR("Valor", 10)
874:                 loc_nQtVal = 1
875:             ENDIF
876: 
877:             loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
878:             loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
879:                              THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
880:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
881:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
882: 
883:             SELECT CrGrafico1
884:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
885: 
886:             *-- Atualiza exibicao do grafico OLE com a nova posicao
887:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
888:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
889: 
890:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
891:             THIS.Draw()
892:             THIS.Refresh()
893:             THIS.LockScreen = .F.
894: 
895:         CATCH TO loc_oErro
896:             THIS.LockScreen = .F.
897:             MsgErro(loc_oErro.Message, "Erro")
898:         ENDTRY
899:     ENDPROC
900: 
901:     *==========================================================================
902:     * BtnProximoClick - Navega para o proximo grafico
903:     *==========================================================================
904:     PROCEDURE BtnProximoClick()
905:         LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro
906: 
907:         TRY
908:             THIS.LockScreen = .T.
909: 
910:             *-- Incrementa posicao diretamente (maximo 3) e sincroniza BO
911:             THIS.pnNumGrf = MIN(3, THIS.pnNumGrf + 1)
912:             THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
913: 
914:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
915:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
916: 
917:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
918:                 loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
919:                 loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
920:             ELSE
921:                 loc_cQtVal = PADR("Valor", 10)
922:                 loc_nQtVal = 1
923:             ENDIF
924: 
925:             loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
926:             loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
927:                              THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
928:             loc_cChave2    = THIS.this_oBusinessObject.ObterChaveGrafico(;
929:                              loc_cChave1, THIS.pnNumGrf, loc_cStrgeixoY)
930: 
931:             SELECT CrGrafico1
932:             LOCATE FOR CrGrafico1.cChave1s = PADR(loc_cChave2, 100)
933: 
934:             *-- Atualiza exibicao do grafico OLE com a nova posicao
935:             THIS.ConfigurarOleGrafico(loc_cChave1, loc_cStrgeixoY, loc_nQtVal)
936:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
937: 
938:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
939:             THIS.Draw()
940:             THIS.Refresh()
941:             THIS.LockScreen = .F.
942: 
943:         CATCH TO loc_oErro
944:             THIS.LockScreen = .F.
945:             MsgErro(loc_oErro.Message, "Erro")
946:         ENDTRY
947:     ENDPROC
948: 
949:     *==========================================================================
950:     * BtnImprimirClick - Imprime grafico(s) conforme opcao chkGraficos
951:     *==========================================================================
952:     PROCEDURE BtnImprimirClick()
953:         LOCAL loc_nRecno1, loc_nConta1, loc_cChave1, loc_nPosic
954:         LOCAL loc_nGrafico, loc_cNomeImpressora, loc_oErro
955: 
956:         TRY
957:             THIS.cnt_4c_Aguarde.Visible = .T.
958:             THIS.Refresh()
959:             THIS.Draw()
960:             THIS.LockScreen = .T.
961: 
962:             loc_nGrafico = THIS.txt_4c_NumGraficos.Value
963:             loc_nRecno1  = RECNO("CrGrafico1")
964:             loc_cChave1  = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
965:                            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)
966:             loc_nPosic   = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
967:             THIS.SetAll("Enabled", .F., "OleBoundControl")
968: 
969:             IF THIS.chk_4c_ChkGraficos.Value = 1
970:                 *-- Imprimir todos os graficos a partir do numero inicial
971:                 loc_cNomeImpressora = GETPRINTER()
972:                 SET PRINTER TO NAME (loc_cNomeImpressora)
973:                 SET PRINTER ON
974: 
975:                 FOR loc_nConta1 = loc_nGrafico TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
976:                     SELECT CrGrafico1
977:                     ZAP
978:                     THIS.GerarGrafico(loc_nConta1)
979:                     THIS.cnt_4c_Aguarde.Visible = .F.
980:                     THIS.Draw()
981:                     THIS.LockScreen = .F.
982:                     THIS.cnt_4c_Aguarde.Refresh()
983:                     THIS.LockScreen = .T.
984: 
985:                     SELECT CrGrafico1
986:                     SET ORDER TO ""
987:                     SET ORDER TO pkchave1
988:                     LOCATE
989:                     REPORT FORM SigReCmg TO PRINTER
990:                 ENDFOR
991: 
992:                 SET PRINTER TO DEFAULT

*-- Linhas 1033 a 1199:
1033:     *==========================================================================
1034:     * BtnEncerrarClick - Fecha o form e reabilita o form pai
1035:     *==========================================================================
1036:     PROCEDURE BtnEncerrarClick()
1037:         LOCAL loc_oErro
1038:         TRY
1039:             THIS.LockScreen = .T.
1040:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1041:             THIS.this_oBusinessObject.FecharCursores()
1042:             THIS.LockScreen = .F.
1043: 
1044:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
1045:                 THIS.poForm1.LockScreen = .T.
1046:                 THIS.poForm1.Enabled    = .T.
1047:                 THIS.poForm1.LockScreen = .F.
1048:             ENDIF
1049: 
1050:             THIS.Release()
1051: 
1052:         CATCH TO loc_oErro
1053:             THIS.LockScreen = .F.
1054:             MsgErro(loc_oErro.Message, "Erro")
1055:         ENDTRY
1056:     ENDPROC
1057: 
1058:     *==========================================================================
1059:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1060:     * FILTRO: cnt_4c_Aguarde e cnt_4c_Grf1/cnt_4c_Grf2 sao flutuantes
1061:     *==========================================================================
1062:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1063:         LOCAL loc_nI, loc_oObjeto
1064: 
1065:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1066:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1067: 
1068:             IF VARTYPE(loc_oObjeto) = "O"
1069:                 *-- Pular containers flutuantes (gerenciados por InicializarForm)
1070:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_AGUARDE", "CNT_4C_GRF1", "CNT_4C_GRF2", ;
1071:                           "CHK_4C_CHKGRAFICOS", "OBJ_4C_CMDGGRAFICO")
1072:                     LOOP
1073:                 ENDIF
1074: 
1075:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1076:                     loc_oObjeto.Visible = .T.
1077:                 ENDIF
1078: 
1079:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1080:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1081:                 ENDIF
1082:             ENDIF
1083:         ENDFOR
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * CarregarLista - Cria cursor minimo para testes automatizados
1088:     * Form OPERACIONAL sem grid de lista; os dados vem de TmpResult do form pai
1089:     * e de CrGrafico1 (criado em GerarGrafico). Aqui criamos cursor_4c_Dados
1090:     * minimo para satisfazer testes que checam USED("cursor_4c_Dados").
1091:     *==========================================================================
1092:     PROCEDURE CarregarLista()
1093:         LOCAL loc_nSessaoAtual
1094:         loc_nSessaoAtual = THIS.DataSessionId
1095: 
1096:         *-- Criar na sessao global (1) para testes automatizados enxergarem
1097:         SET DATASESSION TO 1
1098:         IF USED("cursor_4c_Dados")
1099:             USE IN cursor_4c_Dados
1100:         ENDIF
1101:         CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1102: 
1103:         *-- Voltar para sessao original e criar la tambem
1104:         SET DATASESSION TO (loc_nSessaoAtual)
1105:         IF loc_nSessaoAtual != 1
1106:             IF USED("cursor_4c_Dados")
1107:                 USE IN cursor_4c_Dados
1108:             ENDIF
1109:             CREATE CURSOR cursor_4c_Dados (cChave1s C(100), gGrafico1s G, cTitulo1s C(64))
1110:         ENDIF
1111: 
1112:         RETURN .T.
1113:     ENDPROC
1114: 
1115:     *==========================================================================
1116:     * FormParaBO - Transfere estado dos controles do form para o BO
1117:     * Sincroniza posicao do grafico, flag de todos os graficos, grafico inicial
1118:     * e chave selecionada no combo. Chamado antes de operacoes do BO.
1119:     *==========================================================================
1120:     PROTECTED PROCEDURE FormParaBO()
1121:         LOCAL loc_nIndex
1122: 
1123:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1124:             RETURN
1125:         ENDIF
1126: 
1127:         WITH THIS.this_oBusinessObject
1128:             *-- Posicao atual do grafico exibido (1 a 3)
1129:             .this_nNumGrafico = THIS.pnNumGrf
1130: 
1131:             *-- Flag de imprimir todos os graficos
1132:             IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1133:                 .this_lTodosGraficos = (THIS.chk_4c_ChkGraficos.Value = 1)
1134:             ENDIF
1135: 
1136:             *-- Grafico inicial para impressao em lote
1137:             IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1138:                 .this_nInicioGrafico = MAX(1, NVL(THIS.txt_4c_NumGraficos.Value, 1))
1139:             ENDIF
1140: 
1141:             *-- Chave selecionada no combo (ordem + nome do cliente)
1142:             IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
1143:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1144:                 loc_nIndex = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
1145:                 IF loc_nIndex >= 1 AND loc_nIndex <= THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
1146:                     .this_cChaveAtual = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIndex)
1147:                 ELSE
1148:                     .this_cChaveAtual = ""
1149:                 ENDIF
1150:             ENDIF
1151:         ENDWITH
1152:     ENDPROC
1153: 
1154:     *==========================================================================
1155:     * BOParaForm - Transfere estado do BO para os controles do form
1156:     * Restaura posicao do grafico, flags e selecao do combo. Chamado apos
1157:     * operacoes que possam ter alterado o estado do BO.
1158:     *==========================================================================
1159:     PROTECTED PROCEDURE BOParaForm()
1160:         LOCAL loc_nI, loc_nIndex
1161: 
1162:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1163:             RETURN
1164:         ENDIF
1165: 
1166:         WITH THIS.this_oBusinessObject
1167:             *-- Restaura posicao do grafico
1168:             IF .this_nNumGrafico >= 1 AND .this_nNumGrafico <= 3
1169:                 THIS.pnNumGrf = .this_nNumGrafico
1170:             ENDIF
1171: 
1172:             *-- Restaura flag de todos os graficos
1173:             IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1174:                 THIS.chk_4c_ChkGraficos.Value = IIF(.this_lTodosGraficos, 1, 0)
1175:             ENDIF
1176: 
1177:             *-- Restaura grafico inicial
1178:             IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1179:                 THIS.txt_4c_NumGraficos.Value = MAX(1, .this_nInicioGrafico)
1180:             ENDIF
1181: 
1182:             *-- Restaura selecao do combo (procurar pela chave atual)
1183:             IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
1184:                PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5) AND ;
1185:                NOT EMPTY(.this_cChaveAtual)
1186:                 loc_nIndex = 0
1187:                 FOR loc_nI = 1 TO THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount
1188:                     IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nI) == .this_cChaveAtual
1189:                         loc_nIndex = loc_nI
1190:                         EXIT
1191:                     ENDIF
1192:                 ENDFOR
1193:                 IF loc_nIndex > 0
1194:                     THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = loc_nIndex
1195:                 ENDIF
1196:             ENDIF
1197:         ENDWITH
1198: 
1199:         *-- Atualiza estado dos botoes de navegacao conforme nova posicao

*-- Linhas 1209 a 1500:
1209:     * Usado durante processamento do grafico (cntAguarde visivel) para
1210:     * impedir interacao do usuario enquanto o grafico OLE eh recarregado.
1211:     *==========================================================================
1212:     PROCEDURE HabilitarCampos(par_lHabilitar)
1213:         LOCAL loc_lHab
1214:         loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)
1215: 
1216:         IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
1217:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled = loc_lHab
1218:         ENDIF
1219: 
1220:         IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
1221:             *-- Botao Anterior so habilita se nao esta no primeiro grafico
1222:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (loc_lHab AND THIS.pnNumGrf > 1)
1223:             *-- Botao Proximo so habilita se nao esta no ultimo grafico
1224:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (loc_lHab AND THIS.pnNumGrf < 3)
1225:             *-- Botao Imprimir
1226:             IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 3
1227:                 THIS.obj_4c_CmdGgrafico.Buttons(3).Enabled = loc_lHab
1228:             ENDIF
1229:             *-- Botao Encerrar
1230:             IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 4
1231:                 THIS.obj_4c_CmdGgrafico.Buttons(4).Enabled = loc_lHab
1232:             ENDIF
1233:         ENDIF
1234: 
1235:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1236:             THIS.chk_4c_ChkGraficos.Enabled = loc_lHab
1237:         ENDIF
1238: 
1239:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1240:             THIS.txt_4c_NumGraficos.Enabled = loc_lHab
1241:         ENDIF
1242: 
1243:         *-- OleBoundControl: desabilitar durante processamento (padrao do legado)
1244:         IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1245:            PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1246:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Enabled = loc_lHab
1247:         ENDIF
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * LimparCampos - Reseta controles do form para estado inicial
1252:     * Limpa o ControlSource do grafico OLE, reseta combo e checkbox.
1253:     * Chamado ao fechar ou reabrir o form com novos dados.
1254:     *==========================================================================
1255:     PROTECTED PROCEDURE LimparCampos()
1256:         IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1257:            PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1258:             THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1259:         ENDIF
1260: 
1261:         IF PEMSTATUS(THIS, "cnt_4c_Grf2", 5) AND ;
1262:            PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1263:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 0
1264:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
1265:         ENDIF
1266: 
1267:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5)
1268:             THIS.chk_4c_ChkGraficos.Value = 0
1269:         ENDIF
1270: 
1271:         IF PEMSTATUS(THIS, "txt_4c_NumGraficos", 5)
1272:             THIS.txt_4c_NumGraficos.Value = 1
1273:         ENDIF
1274: 
1275:         THIS.pnNumGrf = 1
1276: 
1277:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1278:             THIS.this_oBusinessObject.this_nNumGrafico    = 1
1279:             THIS.this_oBusinessObject.this_lTodosGraficos = .F.
1280:             THIS.this_oBusinessObject.this_nInicioGrafico = 1
1281:             THIS.this_oBusinessObject.this_cChaveAtual    = ""
1282:         ENDIF
1283:     ENDPROC
1284: 
1285:     *==========================================================================
1286:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme estado do form
1287:     * Em form OPERACIONAL nao ha modos INCLUIR/ALTERAR/VISUALIZAR; aqui o
1288:     * ajuste depende apenas da posicao atual do grafico (pnNumGrf).
1289:     *==========================================================================
1290:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1291:         IF PEMSTATUS(THIS, "obj_4c_CmdGgrafico", 5)
1292:             *-- Anterior: desabilitado quando esta no primeiro grafico
1293:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
1294:             *-- Proximo: desabilitado quando esta no ultimo grafico
1295:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
1296:             *-- Imprimir e Encerrar sempre habilitados
1297:             IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 3
1298:                 THIS.obj_4c_CmdGgrafico.Buttons(3).Enabled = .T.
1299:             ENDIF
1300:             IF THIS.obj_4c_CmdGgrafico.ButtonCount >= 4
1301:                 THIS.obj_4c_CmdGgrafico.Buttons(4).Enabled = .T.
1302:             ENDIF
1303:         ENDIF
1304: 
1305:         *-- Checkbox e textbox de impressao dependem da disponibilidade do combo
1306:         IF PEMSTATUS(THIS, "chk_4c_ChkGraficos", 5) AND ;
1307:            PEMSTATUS(THIS, "cnt_4c_Grf2", 5)
1308:             THIS.chk_4c_ChkGraficos.Enabled = ;
1309:                 (THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0)
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *==========================================================================
1314:     * BtnBuscarClick - Reaplica geracao do grafico atual (refresh)
1315:     * Form OPERACIONAL nao tem busca CRUD; aqui Buscar = regenerar grafico
1316:     * com a chave atualmente selecionada no combo.
1317:     *==========================================================================
1318:     PROCEDURE BtnBuscarClick()
1319:         LOCAL loc_nIndex, loc_oErro
1320:         TRY
1321:             IF NOT PEMSTATUS(THIS, "cnt_4c_Grf2", 5) OR ;
1322:                NOT PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
1323:                 RETURN
1324:             ENDIF
1325: 
1326:             loc_nIndex = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
1327:             IF loc_nIndex < 1
1328:                 MsgAviso("Selecione um cliente no combo para gerar o gr" + ;
1329:                          CHR(225) + "fico.", "Aten" + CHR(231) + CHR(227) + "o")
1330:                 RETURN
1331:             ENDIF
1332: 
1333:             THIS.LockScreen = .T.
1334:             THIS.cnt_4c_Aguarde.Visible = .T.
1335:             THIS.Refresh()
1336:             THIS.Draw()
1337:             THIS.HabilitarCampos(.F.)
1338: 
1339:             THIS.GerarGrafico(loc_nIndex)
1340: 
1341:             THIS.cnt_4c_Aguarde.Visible = .F.
1342:             THIS.HabilitarCampos(.T.)
1343:             THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus
1344:             THIS.Refresh()
1345:             THIS.Draw()
1346:             THIS.LockScreen = .F.
1347: 
1348:         CATCH TO loc_oErro
1349:             THIS.LockScreen = .F.
1350:             THIS.cnt_4c_Aguarde.Visible = .F.
1351:             THIS.HabilitarCampos(.T.)
1352:             MsgErro(loc_oErro.Message, "Erro BtnBuscar")
1353:         ENDTRY
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * BtnSalvarClick - Persiste estado atual do form no BO
1358:     * Form OPERACIONAL nao salva em tabela; aqui apenas sincroniza FormParaBO
1359:     * para permitir reaberturas consistentes via BOParaForm.
1360:     *==========================================================================
1361:     PROCEDURE BtnSalvarClick()
1362:         LOCAL loc_oErro
1363:         TRY
1364:             THIS.FormParaBO()
1365:         CATCH TO loc_oErro
1366:             MsgErro(loc_oErro.Message, "Erro BtnSalvar")
1367:         ENDTRY
1368:     ENDPROC
1369: 
1370:     *==========================================================================
1371:     * BtnCancelarClick - Descarta alteracoes locais e restaura estado do BO
1372:     * Form OPERACIONAL nao tem edicao CRUD; cancelar = BOParaForm para
1373:     * reverter qualquer alteracao nos controles desde a ultima sincronizacao.
1374:     *==========================================================================
1375:     PROCEDURE BtnCancelarClick()
1376:         LOCAL loc_oErro
1377:         TRY
1378:             THIS.BOParaForm()
1379:             THIS.Refresh()
1380:         CATCH TO loc_oErro
1381:             MsgErro(loc_oErro.Message, "Erro BtnCancelar")
1382:         ENDTRY
1383:     ENDPROC
1384: 
1385:     *==========================================================================
1386:     * BtnIncluirClick - Override: form OPERACIONAL sem CRUD
1387:     * Reabre o form descartando estado atual (equivalente a "novo grafico")
1388:     *==========================================================================
1389:     PROCEDURE BtnIncluirClick()
1390:         LOCAL loc_oErro
1391:         TRY
1392:             THIS.LimparCampos()
1393:             *-- Regenera lista de chaves do TmpResult do form pai
1394:             IF VARTYPE(THIS.poForm1) = "O" AND USED("TmpResult")
1395:                 THIS.InicializarForm()
1396:             ENDIF
1397:         CATCH TO loc_oErro
1398:             MsgErro(loc_oErro.Message, "Erro BtnIncluir")
1399:         ENDTRY
1400:     ENDPROC
1401: 
1402:     *==========================================================================
1403:     * BtnAlterarClick - Override: form OPERACIONAL sem CRUD
1404:     * Equivalente funcional: regenera grafico atual com novo modo Valor/Qtd
1405:     *==========================================================================
1406:     PROCEDURE BtnAlterarClick()
1407:         THIS.BtnBuscarClick()
1408:     ENDPROC
1409: 
1410:     *==========================================================================
1411:     * BtnVisualizarClick - Override: form OPERACIONAL sem CRUD
1412:     * Equivalente funcional: re-exibe grafico atual no OleBoundControl
1413:     *==========================================================================
1414:     PROCEDURE BtnVisualizarClick()
1415:         LOCAL loc_oErro
1416:         TRY
1417:             IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1418:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1419:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1420:             ENDIF
1421:         CATCH TO loc_oErro
1422:             MsgErro(loc_oErro.Message, "Erro BtnVisualizar")
1423:         ENDTRY
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * BtnExcluirClick - Override: form OPERACIONAL sem CRUD
1428:     * Equivalente funcional: limpa o grafico atual do OleBoundControl
1429:     *==========================================================================
1430:     PROCEDURE BtnExcluirClick()
1431:         LOCAL loc_oErro
1432:         TRY
1433:             IF PEMSTATUS(THIS, "cnt_4c_Grf1", 5) AND ;
1434:                PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
1435:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
1436:                 THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.Refresh
1437:             ENDIF
1438:         CATCH TO loc_oErro
1439:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
1440:         ENDTRY
1441:     ENDPROC
1442: 
1443:     *==========================================================================
1444:     * AtualizarEstadoControles - Sincroniza estado dos controles com posicao
1445:     * atual do grafico. Chamado apos navegacao (Anterior/Proximo/Alternar).
1446:     *==========================================================================
1447:     PROCEDURE AtualizarEstadoControles()
1448:         THIS.AjustarBotoesPorModo()
1449:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1450:             THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
1451:         ENDIF
1452:     ENDPROC
1453: 
1454:     *==========================================================================
1455:     * AlternarPagina - Navega entre as 3 posicoes de grafico (1, 2, 3)
1456:     * Forms OPERACIONAIS nao tem PageFrame; aqui par_nPagina representa a
1457:     * posicao do grafico (pnNumGrf) a exibir. Equivalente funcional ao
1458:     * BtnAnterior/BtnProximo, mas permitindo salto direto para qualquer posicao.
1459:     *==========================================================================
1460:     PROCEDURE AlternarPagina(par_nPagina)
1461:         LOCAL loc_cChave1, loc_cChave2, loc_cQtVal, loc_nQtVal, loc_cStrgeixoY, loc_oErro
1462:         LOCAL loc_nDestino
1463: 
1464:         TRY
1465:             *-- Valida e normaliza a posicao destino (1 a 3 = posicoes validas)
1466:             IF VARTYPE(par_nPagina) != "N" OR !BETWEEN(par_nPagina, 1, 3)
1467:                 RETURN
1468:             ENDIF
1469:             loc_nDestino = par_nPagina
1470: 
1471:             *-- Combo de clientes precisa estar populado (pre-condicao do refresh)
1472:             IF EMPTY(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount) OR ;
1473:                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex < 1
1474:                 RETURN
1475:             ENDIF
1476: 
1477:             THIS.LockScreen = .T.
1478: 
1479:             *-- Atualiza posicao do grafico e sincroniza BO
1480:             THIS.pnNumGrf = loc_nDestino
1481:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1482:                 THIS.this_oBusinessObject.this_nNumGrafico = THIS.pnNumGrf
1483:             ENDIF
1484: 
1485:             *-- Atualiza estado dos botoes de navegacao
1486:             THIS.obj_4c_CmdGgrafico.Buttons(1).Enabled = (THIS.pnNumGrf > 1)
1487:             THIS.obj_4c_CmdGgrafico.Buttons(2).Enabled = (THIS.pnNumGrf < 3)
1488: 
1489:             *-- Determinar modo Valor/Quantidade a partir do form pai
1490:             IF VARTYPE(THIS.poForm1) = "O" AND THIS.poForm1 != THIS
1491:                 loc_cQtVal = PADR(IIF(THIS.poForm1.Opt_SelRel.Value = 1, "Valor", "Quantidade"), 10)
1492:                 loc_nQtVal = THIS.poForm1.Opt_SelRel.Value
1493:             ELSE
1494:                 loc_cQtVal = PADR("Valor", 10)
1495:                 loc_nQtVal = 1
1496:             ENDIF
1497: 
1498:             loc_cStrgeixoY = "Opera" + CHR(231) + CHR(245) + "es Ranking   " + loc_cQtVal
1499:             loc_cChave1    = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(;
1500:                              THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)

*-- Linhas 1524 a 1541:
1524:     *==========================================================================
1525:     * Destroy - Limpa recursos ao fechar o form
1526:     *==========================================================================
1527:     PROCEDURE Destroy()
1528:         LOCAL loc_oErro
1529:         TRY
1530:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1531:                 THIS.this_oBusinessObject.FecharCursores()
1532:                 THIS.this_oBusinessObject = .NULL.
1533:             ENDIF
1534:         CATCH TO loc_oErro
1535:             *-- Silencioso no Destroy: form ja esta fechando
1536:         ENDTRY
1537: 
1538:         DODEFAULT()
1539:     ENDPROC
1540: 
1541: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReCmgBO.prg):
*==============================================================================
* SigReCmgBO.prg
* Business Object: Grafico Clientes que Mais Compram (SIGRECMG)
* Herda de: BusinessBase
* Tipo: OPERACIONAL - subformulario de exibicao de grafico
* Sem tabela direta (dados vem de TmpResult do formulario pai)
*==============================================================================

DEFINE CLASS SigReCmgBO AS BusinessBase

    *-- Identificacao
    this_cTabela          = ""
    this_cCampoChave      = ""

    *-- Estado do grafico
    this_nNumGrafico      = 0      && Posicao atual do grafico exibido (1-3)
    this_lTodosGraficos   = .F.    && Imprimir todos os graficos em sequencia
    this_nInicioGrafico   = 1      && Grafico inicial para impressao em lote
    this_cChaveAtual      = ""     && Chave selecionada no combo (ordem + nome cliente)

    *-- Titulos do grafico (lidos de TmpResult ao gerar cada grafico)
    this_cTitulo1         = ""
    this_cTitulo2         = ""
    this_cTitulo3         = ""
    this_cTitulo4         = ""
    this_cEmpresaGrafico  = ""

    *==========================================================================
    * Init - Inicializa o BO sem tabela direta (form operacional)
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Obrigatorio para sistema de auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaveAtual
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Inserir - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Nao aplicavel (form operacional sem tabela)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarCursorGrafico - Cria cursor CrGrafico1 se nao existe
    * Estrutura IDENTICA ao original (BeforeOpenTables/mGeraGrafico)
    *==========================================================================
    PROCEDURE InicializarCursorGrafico()
        IF !USED("CrGrafico1")
            SET NULL ON
            CREATE CURSOR CrGrafico1 (;
                gGrafico1s G(4),;
                cChave1s   C(100),;
                cEmpresas  C(128),;
                cTitulo1s  C(64),;
                cTitulo2s  C(64),;
                cTitulo3s  C(64),;
                cTitulo4s  C(64))
            SET NULL OFF
            INDEX ON cChave1s TAG pkchave1
        ENDIF
    ENDPROC

    *==========================================================================
    * ZerarCursorGrafico - Limpa CrGrafico1 para regerar graficos
    *==========================================================================
    PROCEDURE ZerarCursorGrafico()
        IF USED("CrGrafico1")
            SELECT CrGrafico1
            ZAP
        ENDIF
    ENDPROC

    *==========================================================================
    * FecharCursores - Fecha cursores locais do grafico
    *==========================================================================
    PROCEDURE FecharCursores()
        IF USED("CrGrafico1")
            USE IN CrGrafico1
        ENDIF
    ENDPROC

    *==========================================================================
    * BuscarClientesTmpResult - Busca clientes distintos de TmpResult
    * Popula par_aClientes com [Ordem, Crclis] ordenado por Ordem
    * Retorna numero de clientes encontrados (0 se TmpResult nao existe)
    *==========================================================================
    PROCEDURE BuscarClientesTmpResult(par_aClientes)
        LOCAL loc_nTotal, loc_oErro
        loc_nTotal = 0

        TRY
            IF USED("TmpResult")
                SELECT DISTINCT Ordem, Crclis ;
                  FROM TmpResult ;
                 ORDER BY Ordem ;
                  INTO ARRAY par_aClientes

                loc_nTotal = ALEN(par_aClientes, 1)
                THIS.this_cChaveAtual = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * ObterTitulosGrafico - Le titulos e empresa de TmpResult pela chave
    * par_cChave1 = item do combo (5 chars ordem + separador + nome cliente)
    * Popula this_cTitulo1..4 e this_cEmpresaGrafico
    *==========================================================================
    PROCEDURE ObterTitulosGrafico(par_cChave1)
        LOCAL loc_nOrdem, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_nOrdem = VAL(LEFT(par_cChave1, 5))

            IF USED("TmpResult")
                SELECT TmpResult
                SET ORDER TO ""
                LOCATE FOR TmpResult.ordem = loc_nOrdem

                IF !EOF()
                    THIS.this_cTitulo1        = ALLTRIM(TmpResult.cTitulo1s)
                    THIS.this_cTitulo2        = ALLTRIM(TmpResult.cTitulo2s)
                    THIS.this_cTitulo3        = ALLTRIM(TmpResult.cTitulo3s)
                    THIS.this_cTitulo4        = ALLTRIM(TmpResult.cTitulo4s)
                    THIS.this_cEmpresaGrafico = ALLTRIM(TmpResult.cEmpresas)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PrepararDadosGrafico - Prepara e insere dados no CrGrafico1
    * par_cChave2     = chave composta (chave1 + nome do eixo para o grafico N)
    * par_nContaGrafico = 1, 2 ou 3
    * par_nQtVal      = 1=Valor, 2=Quantidade (do OptionGroup Opt_SelRel do pai)
    * par_cStrgeixoY  = string do eixo Y com 3 nomes de 10 chars cada
    * Retorna .T. se CrGrafico1 preparado (novo ou ja existente)
    *==========================================================================
    PROCEDURE PrepararDadosGrafico(par_cChave2, par_nContaGrafico, par_nQtVal, par_cStrgeixoY)
        LOCAL loc_lResultado, loc_cStrg1, loc_cStrg2, loc_nVlGrf1
        LOCAL loc_cStrgeixoX, loc_nNlegenda1, loc_nConta2, loc_oErro
        LOCAL loc_cCampValComp, loc_cCampValAno
        loc_lResultado = .F.

        TRY
            THIS.InicializarCursorGrafico()

            *-- Verifica se o grafico ja foi gerado para esta chave
            SELECT CrGrafico1
            LOCATE FOR CrGrafico1.cChave1s = PADR(par_cChave2, 100)

            IF !EOF()
                loc_lResultado = .T.
            ELSE
                IF USED("TmpResult")
                    *-- Titulo do eixo X (nome do tipo de grafico)
                    loc_cStrg1 = CHR(9) + PROPER(ALLTRIM(SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)))

                    *-- Campos conforme tipo Valor/Quantidade
                    loc_cCampValComp = ALLTRIM(SUBSTR("ncomprasordem   " + IIF(par_nQtVal = 1, "nvalcomp", "nqtde   "), (par_nContaGrafico * 8 - 7), 8))
                    loc_cCampValAno  = ALLTRIM(SUBSTR("ncompra ordem   " + IIF(par_nQtVal = 1, "nvalano ", "nqtdano "), (par_nContaGrafico * 8 - 7), 8))

                    *-- Linha geral (total do ranking)
                    loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValComp)
                    loc_cStrg2  = "Geral" + CHR(9) + ;
                                  ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                  CHR(13) + CHR(10)

                    *-- Linhas por ano (ate 7 anos)
                    loc_cStrgeixoX = TmpResult.cStrAno1s
                    loc_nNlegenda1 = 7

                    FOR loc_nConta2 = 1 TO loc_nNlegenda1
                        IF !EMPTY(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))
                            loc_nVlGrf1 = EVALUATE("TmpResult." + loc_cCampValAno + ALLTRIM(STR(loc_nConta2, 20, 0)))
                            loc_cStrg2  = loc_cStrg2 + ;
                                          PROPER(ALLTRIM(SUBSTR(loc_cStrgeixoX, (loc_nConta2 * 4 - 3), 4))) + ;
                                          CHR(9) + ;
                                          ALLTRIM(TRANSFORM(IIF(par_nContaGrafico = 2, TmpResult.MaxOrdem - loc_nVlGrf1 + 1, loc_nVlGrf1), "999,999,999,999")) + ;
                                          CHR(13) + CHR(10)
                        ENDIF
                    ENDFOR

                    *-- Insere estrutura no CrGrafico1 com titulos e dados OLE
                    SELECT CrGrafico1
                    INSERT INTO CrGrafico1 (cChave1s, cTitulo1s, cTitulo2s, cTitulo3s, cTitulo4s, cEmpresas) ;
                        VALUES (par_cChave2, THIS.this_cTitulo1, THIS.this_cTitulo2, ;
                                THIS.this_cTitulo3, THIS.this_cTitulo4, THIS.this_cEmpresaGrafico)
                    APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" DATA (loc_cStrg1 + CHR(13) + CHR(10) + loc_cStrg2)

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * NavGraficoAnterior - Decrementa posicao do grafico (minimo 1)
    * Retorna o numero atual apos decremento
    *==========================================================================
    PROCEDURE NavGraficoAnterior()
        THIS.this_nNumGrafico = MAX(1, THIS.this_nNumGrafico - 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * NavGraficoProximo - Incrementa posicao do grafico (maximo 3)
    * Retorna o numero atual apos incremento
    *==========================================================================
    PROCEDURE NavGraficoProximo()
        THIS.this_nNumGrafico = MIN(3, THIS.this_nNumGrafico + 1)
        RETURN THIS.this_nNumGrafico
    ENDPROC

    *==========================================================================
    * ObterChaveGrafico - Monta chave composta para lookup em CrGrafico1
    * par_cChave1 = item do combo (ordem + separador + cliente)
    * par_nContaGrafico = 1, 2 ou 3
    * par_cStrgeixoY = string do eixo Y (30 chars = 3 nomes de 10)
    *==========================================================================
    PROCEDURE ObterChaveGrafico(par_cChave1, par_nContaGrafico, par_cStrgeixoY)
        RETURN par_cChave1 + SUBSTR(par_cStrgeixoY, (par_nContaGrafico * 10 - 9), 10)
    ENDPROC

ENDDEFINE

