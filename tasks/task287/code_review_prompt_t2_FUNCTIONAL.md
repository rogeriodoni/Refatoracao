# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (770 linhas total):

*-- Linhas 10 a 199:
10:     *-- BO
11:     this_oBusinessObject = .NULL.
12: 
13:     *-- Caption (populado via PROMPT() em InicializarForm)
14:     this_cCaption = ""
15: 
16:     *-- Referencia ao form pai que abriu este form (opcional)
17:     *-- Setado externamente quando chamado por outro form (ex: movimentos)
18:     poForm1 = .NULL.
19: 
20:     *-- Propriedades visuais (PILAR 1: identico ao original SIGPRGF1)
21:     Width       = 800
22:     Height      = 158
23:     AutoCenter  = .T.
24:     TitleBar    = 0
25:     ShowWindow = 1
26:     WindowType = 1
27:     ControlBox  = .F.
28:     Closable    = .F.
29:     MaxButton   = .F.
30:     MinButton   = .F.
31:     BorderStyle = 2
32:     DataSession = 2
33: 
34:     *--------------------------------------------------------------------------
35:     * Init
36:     *--------------------------------------------------------------------------
37:     PROCEDURE Init()
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *--------------------------------------------------------------------------
42:     * ConfigurarPageFrame - Aparencia base do form (OPERACIONAL sem PageFrame)
43:     *--------------------------------------------------------------------------
44:     PROTECTED PROCEDURE ConfigurarPageFrame()
45:         THIS.ScrollBars = 0
46:         THIS.ShowTips   = .F.
47:         THIS.SetAll("FontName", "Tahoma")
48:         THIS.SetAll("FontSize", 8)
49: 
50:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
51:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
52:         ENDIF
53:     ENDPROC
54: 
55:     *--------------------------------------------------------------------------
56:     * InicializarForm - Cria estrutura visual (chamado por FormBase.Init)
57:     *--------------------------------------------------------------------------
58:     PROTECTED PROCEDURE InicializarForm()
59:         LOCAL loc_lSucesso, loc_oErro
60:         loc_lSucesso = .F.
61: 
62:         TRY
63:             *-- Instanciar BO
64:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf1BO")
65:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
66:                 MsgErro("Falha ao criar SigPrGf1BO.", "Erro")
67:             ELSE
68:                 THIS.this_oBusinessObject.this_cEmpresa = go_4c_Sistema.cCodEmpresa
69: 
70:                 *-- Caption a partir do menu corrente
71:                 THIS.this_cCaption = PROMPT()
72:                 THIS.Caption       = THIS.this_cCaption
73: 
74:                 *-- Criar componentes (form OPERACIONAL layout flat sem PageFrame)
75:                 THIS.ConfigurarPaginaLista()
76: 
77:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
78:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
79: 
80:                 *-- BINDEVENT: validacao interativa ao sair do campo DtFinal
81:                 *-- (equivale ao getDtFinal.Valid do legado)
82:                 BINDEVENT(THIS.txt_4c_DtFinal, "KeyPress", THIS, "TxtDtFinalKeyPress")
83: 
84:                 *-- Tornar controles visiveis (cnt_4c_Aguarde permanece oculto)
85:                 THIS.TornarControlesVisiveis()
86: 
87:                 *-- Datas iniciais: primeiro dia do mes atual / ultimo dia do mes
88:                 THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
89:                                                    "/" + LTRIM(STR(YEAR(DATE()), 4)))
90:                 THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
91: 
92:                 THIS.txt_4c_DtInicial.SetFocus
93: 
94:                 loc_lSucesso = .T.
95:             ENDIF
96: 
97:         CATCH TO loc_oErro
98:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
99:                     " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
100:         ENDTRY
101: 
102:         RETURN loc_lSucesso
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Wrapper de montagem da tela unica (OPERACIONAL)
107:     * Original SIGPRGF1 NAO tem PageFrame nem Grid nem botoes CRUD (Incluir/
108:     * Alterar/Excluir/Buscar) ??? eh um painel de filtro (periodo) + Processar +
109:     * Encerrar. Este metodo agrega ConfigurarCabecalho + ConfigurarFiltros +
110:     * ConfigurarBotoes (CommandGroup Processar/Encerrar) + ConfigurarAguarde
111:     * mantendo o contrato esperado pela pipeline (PILAR 1: preservar UX legado).
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         THIS.ConfigurarCabecalho()
115:         THIS.ConfigurarFiltros()
116:         THIS.ConfigurarBotoes()
117:         THIS.ConfigurarAguarde()
118:     ENDPROC
119: 
120:     *--------------------------------------------------------------------------
121:     * AlternarPagina - Navegacao entre paginas
122:     * Form OPERACIONAL de tela unica (SIGPRGF1 sem PageFrame): unica "pagina"
123:     * util eh o painel de filtro. Metodo mantido para atender contrato da
124:     * pipeline (fase 4) e para permitir refoco/reset apos processamento.
125:     *--------------------------------------------------------------------------
126:     PROCEDURE AlternarPagina(par_nPagina)
127:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
128:             THIS.txt_4c_DtInicial.SetFocus
129:         ENDIF
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarPaginaDados - Contrato da pipeline (fase 5/6) para forms CRUD
134:     * O legado SIGPRGF1.SCX (Width=800, Height=158) NAO tem PageFrame nem
135:     * Page2 (Dados): eh um form OPERACIONAL flat com apenas painel de filtro
136:     * de periodo (getDtInicial + getDtFinal), CommandGroup Processar/Encerrar
137:     * e cntAguarde. Nao ha campos de edicao de registro, nao ha Grid CRUD.
138:     *
139:     * Todos os controles do form ja foram criados por ConfigurarPaginaLista()
140:     * nas fases 3-4 (cnt_4c_Cabecalho + cnt_4c_Aguarde + txt_4c_DtInicial +
141:     * txt_4c_DtFinal + lbl_4c_Periodo + cmg_4c_Processar). Este metodo eh
142:     * mantido como no-op documentado para atender o contrato de fases da
143:     * pipeline (que espera ConfigurarPaginaDados em todos os forms migrados).
144:     *
145:     * Se no futuro precisar adicionar campos de "detalhe" (segunda tela), a
146:     * implementacao seguiria o padrao AddObject aqui e a navegacao entre
147:     * paineis usaria .Visible = .T./.F. em containers filhos do form.
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarPaginaDados()
150:         *-- No-op intencional: SIGPRGF1 eh OPERACIONAL flat (ver comentario acima).
151:         *-- Sem PageFrame => sem Page2 => sem campos de dados adicionais.
152:         *-- ConfigurarPaginaLista() ja montou 100% dos controles do form legado.
153:         RETURN
154:     ENDPROC
155: 
156:     *--------------------------------------------------------------------------
157:     * ConfigurarCabecalho - Container escuro com titulo (equivale ao cntSombra)
158:     *--------------------------------------------------------------------------
159:     PROTECTED PROCEDURE ConfigurarCabecalho()
160:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
161:         WITH THIS.cnt_4c_Cabecalho
162:             .Top        = 0
163:             .Left       = 0
164:             .Width      = THIS.Width
165:             .Height     = 80
166:             .BackStyle  = 1
167:             .BackColor  = RGB(100,100,100)
168:             .BorderWidth = 0
169: 
170:             .AddObject("lbl_4c_Sombra", "Label")
171:             WITH .lbl_4c_Sombra
172:                 .Top       = 18
173:                 .Left      = 10
174:                 .Width     = THIS.Width
175:                 .Height    = 40
176:                 .AutoSize  = .F.
177:                 .FontBold  = .T.
178:                 .FontName  = "Tahoma"
179:                 .FontSize  = 18
180:                 .WordWrap  = .T.
181:                 .Alignment = 0
182:                 .BackStyle = 0
183:                 .Caption   = THIS.this_cCaption
184:                 .ForeColor = RGB(0,0,0)
185:             ENDWITH
186: 
187:             .AddObject("lbl_4c_Titulo", "Label")
188:             WITH .lbl_4c_Titulo
189:                 .Top       = 17
190:                 .Left      = 10
191:                 .Width     = THIS.Width
192:                 .Height    = 46
193:                 .AutoSize  = .F.
194:                 .FontBold  = .T.
195:                 .FontName  = "Tahoma"
196:                 .FontSize  = 18
197:                 .WordWrap  = .T.
198:                 .Alignment = 0
199:                 .BackStyle = 0

*-- Linhas 210 a 770:
210:     * Original: lbl_periodo (Top=116, Left=41) + getDtinicial (Top=111, Left=98)
211:     *           + getDtfinal (Top=111, Left=180)
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarFiltros()
214:         *-- Label "Periodo :"
215:         THIS.AddObject("lbl_4c_Periodo", "Label")
216:         WITH THIS.lbl_4c_Periodo
217:             .Top      = 116
218:             .Left     = 41
219:             .Width    = 50
220:             .Height   = 15
221:             .AutoSize = .F.
222:             .Caption  = "Per" + CHR(237) + "odo :"
223:             .FontName = "Tahoma"
224:             .FontSize = 8
225:         ENDWITH
226: 
227:         *-- Data Inicial (getDtinicial)
228:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
229:         WITH THIS.txt_4c_DtInicial
230:             .Top       = 111
231:             .Left      = 98
232:             .Width     = 79
233:             .Height    = 25
234:             .Format    = "K"
235:             .Value     = {}
236:             .FontName  = "Tahoma"
237:             .FontSize  = 8
238:             .TabIndex  = 1
239:         ENDWITH
240: 
241:         *-- Data Final (getDtfinal)
242:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
243:         WITH THIS.txt_4c_DtFinal
244:             .Top      = 111
245:             .Left     = 180
246:             .Width    = 79
247:             .Height   = 25
248:             .Format   = "K"
249:             .Value    = {}
250:             .FontName = "Tahoma"
251:             .FontSize = 8
252:             .TabIndex = 2
253:         ENDWITH
254:     ENDPROC
255: 
256:     *--------------------------------------------------------------------------
257:     * ConfigurarBotoes - CommandGroup com Processar + Encerrar
258:     * Original: cmdGprocessa (Top=-2, Left=643, Width=160, Height=85)
259:     *--------------------------------------------------------------------------
260:     PROTECTED PROCEDURE ConfigurarBotoes()
261:         THIS.AddObject("cmg_4c_Processar", "CommandGroup")
262:         WITH THIS.cmg_4c_Processar
263:             .Top         = -2
264:             .Left        = 643
265:             .Width       = 160
266:             .Height      = 85
267:             .ButtonCount = 2
268:             .BackStyle   = 0
269:             .BorderStyle = 0
270:             .SpecialEffect = 1
271: 
272:             WITH .Buttons(1)
273:                 .Top         = 5
274:                 .Left        = 5
275:                 .Width       = 75
276:                 .Height      = 75
277:                 .Caption     = "Processar"
278:                 .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
279:                 .FontBold    = .T.
280:                 .FontItalic  = .T.
281:                 .WordWrap    = .T.
282:                 .ForeColor   = RGB(90,90,90)
283:                 .BackColor   = RGB(255,255,255)
284:                 .Themes      = .F.
285:                 .PicturePosition = 13
286:             ENDWITH
287: 
288:             WITH .Buttons(2)
289:                 .Top         = 5
290:                 .Left        = 80
291:                 .Width       = 75
292:                 .Height      = 75
293:                 .Caption     = "Encerrar"
294:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
295:                 .Cancel      = .T.
296:                 .FontBold    = .T.
297:                 .FontItalic  = .T.
298:                 .FontName    = "Tahoma"
299:                 .FontSize    = 8
300:                 .WordWrap    = .T.
301:                 .ForeColor   = RGB(90,90,90)
302:                 .BackColor   = RGB(255,255,255)
303:                 .Themes      = .F.
304:                 .PicturePosition = 13
305:             ENDWITH
306:         ENDWITH
307: 
308:         BINDEVENT(THIS.cmg_4c_Processar.Buttons(1), "Click", THIS, "BtnProcessarClick")
309:         BINDEVENT(THIS.cmg_4c_Processar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
310:     ENDPROC
311: 
312:     *--------------------------------------------------------------------------
313:     * ConfigurarAguarde - Container de indicador de processamento (Visible=.F.)
314:     * Original: cntAguarde (Top=99, Left=312, Width=207, Height=49)
315:     *--------------------------------------------------------------------------
316:     PROTECTED PROCEDURE ConfigurarAguarde()
317:         THIS.AddObject("cnt_4c_Aguarde", "Container")
318:         WITH THIS.cnt_4c_Aguarde
319:             .Top        = 99
320:             .Left       = 312
321:             .Width      = 207
322:             .Height     = 49
323:             .BackStyle  = 1
324:             .BackColor  = RGB(255,255,255)
325:             .BorderWidth = 0
326:             .SpecialEffect = 0
327:             .Visible    = .F.
328: 
329:             .AddObject("lbl_4c_Aguarde", "Label")
330:             WITH .lbl_4c_Aguarde
331:                 .Top       = 7
332:                 .Left      = 69
333:                 .Width     = 78
334:                 .Height    = 18
335:                 .AutoSize  = .F.
336:                 .FontBold  = .T.
337:                 .FontName  = "Verdana"
338:                 .FontSize  = 10
339:                 .BackStyle = 0
340:                 .Caption   = "Aguarde..."
341:                 .ForeColor = RGB(255,0,0)
342:                 .Visible   = .T.
343:             ENDWITH
344: 
345:             .AddObject("lbl_4c_Processando", "Label")
346:             WITH .lbl_4c_Processando
347:                 .Top       = 24
348:                 .Left      = 34
349:                 .Width     = 141
350:                 .Height    = 18
351:                 .AutoSize  = .F.
352:                 .FontBold  = .T.
353:                 .FontName  = "Tahoma"
354:                 .FontSize  = 10
355:                 .BackStyle = 0
356:                 .Caption   = "Processando Dados..."
357:                 .ForeColor = RGB(90,90,90)
358:                 .Visible   = .T.
359:             ENDWITH
360:         ENDWITH
361:     ENDPROC
362: 
363:     *--------------------------------------------------------------------------
364:     * TornarControlesVisiveis - Torna controles visiveis
365:     * cnt_4c_Aguarde permanece oculto (toggled durante processamento)
366:     *--------------------------------------------------------------------------
367:     PROTECTED PROCEDURE TornarControlesVisiveis()
368:         LOCAL loc_i, loc_oControl
369:         FOR loc_i = 1 TO THIS.ControlCount
370:             loc_oControl = THIS.Controls(loc_i)
371:             IF VARTYPE(loc_oControl) = "O"
372:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_AGUARDE", "CNT_4C_CABECALHO")
373:                     *-- Recursar filhos antes de LOOP para que fiquem visiveis
374:                     *-- quando o container for exibido durante o processamento
375:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
376:                         THIS.TornarSubControlesVisiveis(loc_oControl)
377:                     ENDIF
378:                     LOOP
379:                 ENDIF
380:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
381:                     loc_oControl.Visible = .T.
382:                 ENDIF
383:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
384:                     THIS.TornarSubControlesVisiveis(loc_oControl)
385:                 ENDIF
386:             ENDIF
387:         ENDFOR
388:     ENDPROC
389: 
390:     *--------------------------------------------------------------------------
391:     * TornarSubControlesVisiveis - Recursao para sub-containers
392:     *--------------------------------------------------------------------------
393:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
394:         LOCAL loc_i, loc_oControl
395:         FOR loc_i = 1 TO par_oContainer.ControlCount
396:             loc_oControl = par_oContainer.Controls(loc_i)
397:             IF VARTYPE(loc_oControl) = "O"
398:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
399:                     loc_oControl.Visible = .T.
400:                 ENDIF
401:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
402:                     THIS.TornarSubControlesVisiveis(loc_oControl)
403:                 ENDIF
404:             ENDIF
405:         ENDFOR
406:     ENDPROC
407: 
408:     *--------------------------------------------------------------------------
409:     * BtnProcessarClick - Valida periodo, processa dados, abre FormSigPrGf2
410:     * Equivalente ao cmdProcessa.Click do legado
411:     *--------------------------------------------------------------------------
412:     PROCEDURE BtnProcessarClick()
413:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_oGf2
414:         loc_lSucesso   = .F.
415:         loc_lContinuar = .T.
416: 
417:         TRY
418:             *-- Transferir datas para o BO
419:             THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
420:             THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
421: 
422:             *-- Validar periodo
423:             IF !THIS.this_oBusinessObject.ValidarPeriodo()
424:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
425:                 loc_lContinuar = .F.
426:             ENDIF
427: 
428:             IF loc_lContinuar
429:                 *-- Exibir indicador de processamento
430:                 THIS.cnt_4c_Aguarde.Visible = .T.
431:                 THIS.LockScreen = .T.
432:                 THIS.Refresh
433: 
434:                 *-- Processar dados
435:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarDados()
436: 
437:                 THIS.cnt_4c_Aguarde.Visible = .F.
438:                 THIS.LockScreen = .F.
439:                 THIS.Refresh
440: 
441:                 IF loc_lSucesso
442:                     *-- Desabilitar este form e abrir resultado
443:                     THIS.Enabled = .F.
444:                     loc_oGf2 = CREATEOBJECT("FormSigPrGf2", THIS)
445:                     IF VARTYPE(loc_oGf2) = "O"
446:                         loc_oGf2.Show()
447:                     ELSE
448:                         THIS.Enabled = .T.
449:                         MsgErro("Erro ao criar FormSigPrGf2." + CHR(13) + ;
450:                                 "VARTYPE retornou: " + VARTYPE(loc_oGf2), "Erro")
451:                     ENDIF
452:                 ELSE
453:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagem)
454:                         MsgAviso(THIS.this_oBusinessObject.this_cMensagem, ;
455:                                  "Aten" + CHR(231) + CHR(227) + "o")
456:                     ENDIF
457:                 ENDIF
458:             ENDIF
459: 
460:         CATCH TO loc_oErro
461:             THIS.cnt_4c_Aguarde.Visible = .F.
462:             THIS.LockScreen = .F.
463:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
464:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnProcessarClick")
465:         ENDTRY
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * BtnEncerrarClick - Fecha o form e reativa o form pai (se existir)
470:     * Equivalente ao cmdSair.Click do legado
471:     *--------------------------------------------------------------------------
472:     PROCEDURE BtnEncerrarClick()
473:         LOCAL loc_oErro
474: 
475:         TRY
476:             THIS.LockScreen = .T.
477: 
478:             IF USED("crLstMatLote")
479:                 USE IN crLstMatLote
480:             ENDIF
481: 
482:             IF TYPE("THIS.poForm1") = "O"
483:                 THIS.poForm1.LockScreen = .T.
484:                 THIS.poForm1.Enabled    = .T.
485:                 IF PEMSTATUS(THIS.poForm1, "mAtivaPgMovto1", 5)
486:                     THIS.poForm1.mAtivaPgMovto1()
487:                 ENDIF
488:                 THIS.poForm1.LockScreen = .F.
489:             ENDIF
490: 
491:             THIS.Release()
492: 
493:         CATCH TO loc_oErro
494:             THIS.LockScreen = .F.
495:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
496:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
497:         ENDTRY
498:     ENDPROC
499: 
500:     *--------------------------------------------------------------------------
501:     * TxtDtFinalKeyPress - Valida periodo ao sair do campo Data Final
502:     * Equivalente ao getDtFinal.Valid do legado: bloqueia ENTER/TAB quando
503:     * DtFinal invalida, DtFinal < DtInicial ou periodo > 12 meses
504:     *--------------------------------------------------------------------------
505:     PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
506: 
507:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
508:             RETURN
509:         ENDIF
510: 
511:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
512:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
513: 
514:         IF !THIS.this_oBusinessObject.ValidarPeriodo()
515:             MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
516:             IF EMPTY(THIS.txt_4c_DtFinal.Value)
517:                 THIS.txt_4c_DtFinal.SetFocus
518:             ELSE
519:                 THIS.txt_4c_DtInicial.SetFocus
520:             ENDIF
521:         ENDIF
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * BtnIncluirClick - Reset do filtro para novo processamento (equivalente
526:     * a "Nova consulta" em OPERACIONAL): restaura periodo padrao (mes corrente)
527:     * e devolve foco a DtInicial. Nao existe INSERT em SigPrGf1 (nao ha entidade
528:     * persistida ??? o form apenas processa saldos em memoria via ProcessarDados).
529:     *--------------------------------------------------------------------------
530:     PROCEDURE BtnIncluirClick()
531:         LOCAL loc_oErro
532: 
533:         TRY
534:             THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
535:                                                "/" + LTRIM(STR(YEAR(DATE()), 4)))
536:             THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
537: 
538:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
539:                 THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
540:                 THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
541:                 THIS.this_oBusinessObject.this_cMensagem  = ""
542:             ENDIF
543: 
544:             THIS.Refresh
545:             THIS.txt_4c_DtInicial.SetFocus
546: 
547:         CATCH TO loc_oErro
548:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
549:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
550:         ENDTRY
551:     ENDPROC
552: 
553:     *--------------------------------------------------------------------------
554:     * BtnAlterarClick - Habilita edicao interativa do filtro de periodo:
555:     * garante que os campos de data estejam editaveis e devolve foco a
556:     * DtInicial. Nao ha UPDATE persistente em SigPrGf1 (form OPERACIONAL sem
557:     * entidade CRUD) ??? este evento existe para atender ao contrato da pipeline
558:     * e para uso via atalho de teclado equivalente a "editar filtro".
559:     *--------------------------------------------------------------------------
560:     PROCEDURE BtnAlterarClick()
561:         LOCAL loc_oErro
562: 
563:         TRY
564:             THIS.txt_4c_DtInicial.Enabled  = .T.
565:             THIS.txt_4c_DtInicial.ReadOnly = .F.
566:             THIS.txt_4c_DtFinal.Enabled    = .T.
567:             THIS.txt_4c_DtFinal.ReadOnly   = .F.
568: 
569:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
570:                 THIS.this_oBusinessObject.this_cMensagem = ""
571:             ENDIF
572: 
573:             THIS.Refresh
574:             THIS.txt_4c_DtInicial.SetFocus
575: 
576:         CATCH TO loc_oErro
577:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
578:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
579:         ENDTRY
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * BtnVisualizarClick - Executa o processamento e abre o resultado
584:     * (FormSigPrGf2). Em forms OPERACIONAIS de relatorio/consulta, "Visualizar"
585:     * corresponde a executar a consulta e exibir o resultado ??? equivale ao
586:     * BtnProcessarClick. Delegamos para reaproveitar validacao de periodo,
587:     * indicador cnt_4c_Aguarde e tratamento de erros.
588:     *--------------------------------------------------------------------------
589:     PROCEDURE BtnVisualizarClick()
590:         THIS.BtnProcessarClick()
591:     ENDPROC
592: 
593:     *--------------------------------------------------------------------------
594:     * BtnExcluirClick - Limpa o filtro de periodo (equivalente a "cancelar
595:     * consulta"): zera datas, limpa mensagem do BO e devolve foco a DtInicial.
596:     * Nao existe DELETE em SigPrGf1 (form OPERACIONAL sem entidade persistida)
597:     * ??? este evento existe para atender ao contrato da pipeline.
598:     *--------------------------------------------------------------------------
599:     PROCEDURE BtnExcluirClick()
600:         LOCAL loc_oErro
601: 
602:         TRY
603:             THIS.txt_4c_DtInicial.Value = {}
604:             THIS.txt_4c_DtFinal.Value   = {}
605: 
606:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
607:                 THIS.this_oBusinessObject.this_dDtInicial = {}
608:                 THIS.this_oBusinessObject.this_dDtFinal   = {}
609:                 THIS.this_oBusinessObject.this_cMensagem  = ""
610:             ENDIF
611: 
612:             IF USED("crLstMatLote")
613:                 USE IN crLstMatLote
614:             ENDIF
615: 
616:             THIS.Refresh
617:             THIS.txt_4c_DtInicial.SetFocus
618: 
619:         CATCH TO loc_oErro
620:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
621:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
622:         ENDTRY
623:     ENDPROC
624: 
625:     *--------------------------------------------------------------------------
626:     * BtnBuscarClick - Busca/consulta (OPERACIONAL: delega ao processamento)
627:     * Original: a acao "Buscar" neste form equivale a executar o processamento
628:     * com o periodo atual sem resetar os campos de data.
629:     *--------------------------------------------------------------------------
630:     PROCEDURE BtnBuscarClick()
631:         THIS.BtnProcessarClick()
632:     ENDPROC
633: 
634:     *--------------------------------------------------------------------------
635:     * BtnSalvarClick - Nao aplicavel (form OPERACIONAL sem entidade persistida)
636:     * Contrato da pipeline: delega ao BtnProcessarClick para manter coerencia.
637:     *--------------------------------------------------------------------------
638:     PROCEDURE BtnSalvarClick()
639:         THIS.BtnProcessarClick()
640:     ENDPROC
641: 
642:     *--------------------------------------------------------------------------
643:     * BtnCancelarClick - Cancela/limpa o filtro de periodo e reseta o form
644:     *--------------------------------------------------------------------------
645:     PROCEDURE BtnCancelarClick()
646:         THIS.LimparCampos()
647:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
648:             THIS.txt_4c_DtInicial.SetFocus
649:         ENDIF
650:     ENDPROC
651: 
652:     *--------------------------------------------------------------------------
653:     * FormParaBO - Transfere campos do form para o Business Object
654:     *--------------------------------------------------------------------------
655:     PROCEDURE FormParaBO()
656:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
657:             RETURN .F.
658:         ENDIF
659: 
660:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
661:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
662:         THIS.this_oBusinessObject.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
663: 
664:         RETURN .T.
665:     ENDPROC
666: 
667:     *--------------------------------------------------------------------------
668:     * BOParaForm - Transfere dados do Business Object de volta para o form
669:     *--------------------------------------------------------------------------
670:     PROCEDURE BOParaForm()
671:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
672:             RETURN .F.
673:         ENDIF
674: 
675:         IF !EMPTY(THIS.this_oBusinessObject.this_dDtInicial)
676:             THIS.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_dDtInicial
677:         ENDIF
678:         IF !EMPTY(THIS.this_oBusinessObject.this_dDtFinal)
679:             THIS.txt_4c_DtFinal.Value = THIS.this_oBusinessObject.this_dDtFinal
680:         ENDIF
681: 
682:         RETURN .T.
683:     ENDPROC
684: 
685:     *--------------------------------------------------------------------------
686:     * HabilitarCampos - Habilita ou desabilita campos de edicao conforme modo
687:     * par_lHabilitar = .T. => campos editaveis | .F. => campos somente leitura
688:     *--------------------------------------------------------------------------
689:     PROCEDURE HabilitarCampos(par_lHabilitar)
690:         LOCAL loc_lHabilitar
691:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
692: 
693:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
694:             THIS.txt_4c_DtInicial.Enabled  = loc_lHabilitar
695:             THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
696:         ENDIF
697:         IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
698:             THIS.txt_4c_DtFinal.Enabled  = loc_lHabilitar
699:             THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
700:         ENDIF
701:     ENDPROC
702: 
703:     *--------------------------------------------------------------------------
704:     * LimparCampos - Limpa os campos de filtro de periodo
705:     *--------------------------------------------------------------------------
706:     PROCEDURE LimparCampos()
707:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
708:             THIS.txt_4c_DtInicial.Value = {}
709:         ENDIF
710:         IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
711:             THIS.txt_4c_DtFinal.Value = {}
712:         ENDIF
713: 
714:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
715:             THIS.this_oBusinessObject.this_dDtInicial = {}
716:             THIS.this_oBusinessObject.this_dDtFinal   = {}
717:             THIS.this_oBusinessObject.this_cMensagem  = ""
718:             THIS.this_oBusinessObject.this_cTitulo1   = ""
719:             THIS.this_oBusinessObject.this_cTitulo2   = ""
720:         ENDIF
721: 
722:         IF USED("crLstMatLote")
723:             USE IN crLstMatLote
724:         ENDIF
725:         IF USED("crRel1")
726:             USE IN crRel1
727:         ENDIF
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     * CarregarLista - Sem grid/lista neste form OPERACIONAL (apenas filtro)
732:     * Contrato da pipeline: restaura o periodo padrao (mes corrente) caso
733:     * os campos estejam vazios, garantindo estado inicial consistente.
734:     *--------------------------------------------------------------------------
735:     PROCEDURE CarregarLista()
736:         LOCAL loc_lResultado
737:         loc_lResultado = .T.
738: 
739:         IF EMPTY(THIS.txt_4c_DtInicial.Value) AND EMPTY(THIS.txt_4c_DtFinal.Value)
740:             THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
741:                                                "/" + LTRIM(STR(YEAR(DATE()), 4)))
742:             THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
743:         ENDIF
744: 
745:         RETURN loc_lResultado
746:     ENDPROC
747: 
748:     *--------------------------------------------------------------------------
749:     * AjustarBotoesPorModo - Sem modos CRUD neste form OPERACIONAL
750:     * Contrato da pipeline: mantido como no-op documentado pois SIGPRGF1 tem
751:     * apenas Processar e Encerrar (sem Incluir/Alterar/Excluir/Buscar/Salvar).
752:     *--------------------------------------------------------------------------
753:     PROCEDURE AjustarBotoesPorModo()
754:         *-- No-op: SIGPRGF1 e form OPERACIONAL flat sem modos CRUD.
755:         *-- Os unicos botoes (Processar/Encerrar em cmg_4c_Processar) permanecem
756:         *-- sempre habilitados enquanto o form estiver ativo.
757:         RETURN
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * Destroy
762:     *--------------------------------------------------------------------------
763:     PROCEDURE Destroy()
764:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
765:             THIS.this_oBusinessObject = .NULL.
766:         ENDIF
767:         DODEFAULT()
768:     ENDPROC
769: 
770: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf1BO.prg):
*==============================================================================
* SigPrGf1BO.prg - Business Object para Falha x Recuperacao por Mes
* Herda de: BusinessBase
* Form OPERACIONAL: selecao de periodo + processamento de SigCdFea
*==============================================================================
DEFINE CLASS SigPrGf1BO AS BusinessBase

    *-- Identificacao
    this_cTabela          = "SigCdFea"
    this_cCampoChave      = ""

    *-- Periodo de filtro
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Empresa
    this_cEmpresa         = ""
    this_cNomeEmpresa     = ""

    *-- Titulos gerados pelo processamento
    this_cTitulo1         = ""
    this_cTitulo2         = ""

    *-- Nome do cursor de resultado produzido por ProcessarDados()
    this_cCursorResultado = "crRel1"

    *-- Mensagem de retorno para o form (equivalente a pcMsg legado)
    this_cMensagem        = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdFea"
        THIS.this_cCampoChave = ""
        THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Valida datas de filtro (equivalente a mChkValid do legado)
    * Retorna .T. se valido; seta this_cMensagem e retorna .F. se invalido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPeriodo()
        LOCAL loc_nDifMeses

        THIS.this_cMensagem = ""

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagem = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagem = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF YEAR(THIS.this_dDtInicial) = YEAR(THIS.this_dDtFinal)
            loc_nDifMeses = MONTH(THIS.this_dDtInicial) - MONTH(THIS.this_dDtFinal) + 1
        ELSE
            loc_nDifMeses = (12 - MONTH(THIS.this_dDtInicial)) + MONTH(THIS.this_dDtFinal) + 1
        ENDIF

        IF loc_nDifMeses > 12
            THIS.this_cMensagem = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDados - Gera cursor crRel1 com dados agregados de SigCdFea
    * Equivalente a mProcessamento do legado
    * Retorna .T. se encontrou registros, .F. caso contrario ou em erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_cSQL, loc_cNomeEmpresa
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, loc_cEmpresa
        LOCAL loc_nSaveDecimals, loc_cSaveFixed, loc_cSaveExact

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        THIS.this_cMensagem = ""

        TRY
            *-- Buscar nome da empresa no SQL Server
            loc_cNomeEmpresa = ""
            IF SQLEXEC(gnConnHandle, ;
                "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa), ;
                "crSigCdEmpGf1") > 0
                IF !EOF("crSigCdEmpGf1")
                    SELECT crSigCdEmpGf1
                    loc_cNomeEmpresa = ALLTRIM(NVL(crSigCdEmpGf1.Razas, ""))
                ENDIF
                USE IN crSigCdEmpGf1
            ENDIF
            THIS.this_cNomeEmpresa = loc_cNomeEmpresa

            *-- Formatar datas para SQL Server
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFim = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            *-- SQL de busca no SQL Server
            loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs" + ;
                       " FROM SigCdFea a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                       " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

            IF USED("crTmpRelGf1")
                USE IN crTmpRelGf1
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpRelGf1") < 1
                THIS.this_cMensagem = "Falha na conex" + CHR(227) + "o ao buscar dados de SigCdFea."
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EOF("crTmpRelGf1")
                THIS.this_cMensagem = "Nenhum Registro Encontrado."
                USE IN crTmpRelGf1
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Variaveis para o SELECT VFP local (usar m. prefix nas refs abaixo)
                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)

                *-- String de nomes de meses, 9 chars por mes (12 * 9 = 108 chars)
                loc_cStrgMes  = "Janeiro  " + "Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                "Abril    " + "Maio     " + "Junho    " + ;
                                "Julho    " + "Agosto   " + "Setembro " + ;
                                "Outubro  " + "Novembro " + "Dezembro "

                loc_cTitulo1  = "Falha X Recupera" + CHR(231) + CHR(227) + ;
                                "o por M" + CHR(234) + "s da Empresa "

                IF EMPTY(THIS.this_dDtInicial) AND EMPTY(THIS.this_dDtFinal)
                    loc_cTitulo2 = ""
                ELSE
                    IF THIS.this_dDtInicial = THIS.this_dDtFinal
                        loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDtInicial) + "]"
                    ELSE
                        IF EMPTY(THIS.this_dDtInicial)
                            loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ELSE
                            loc_cTitulo2 = " [De " + DTOC(THIS.this_dDtInicial) + ;
                                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cTitulo1 = loc_cTitulo1
                THIS.this_cTitulo2 = loc_cTitulo2

                IF USED("crRel1")
                    USE IN crRel1
                ENDIF

                *-- Salvar configuracoes SET para restaurar apos SELECT
                loc_nSaveDecimals = SET("DECIMALS")
                loc_cSaveFixed    = SET("FIXED")
                loc_cSaveExact    = SET("EXACT")

                SET DECIMALS TO 6
                SET FIXED ON
                SET EXACT ON

                *-- SELECT VFP local: agrega dados de SigCdFea por empresa/mes
                SELECT Emps AS Cemps, ;
                       PADR(DTOS(Datas), 6) AS cAnomess, ;
                       PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + ;
                            TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                       PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + ;
                            " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                       m.loc_cTitulo2 AS ctitulo2s, ;
                       PADR(ALLTRIM(m.loc_cEmpresa) + " - " + ;
                            ALLTRIM(m.loc_cNomeEmpresa), 100) AS cEmpresas, ;
                       VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                       VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                  FROM crTmpRelGf1 ;
                 GROUP BY 1, 2, 3, 4, 5, 6 ;
                  INTO CURSOR crRel1 READWRITE

                SELECT crRel1
                GO TOP

                *-- Restaurar configuracoes SET
                SET DECIMALS TO (loc_nSaveDecimals)
                IF loc_cSaveFixed = "ON"
                    SET FIXED ON
                ELSE
                    SET FIXED OFF
                ENDIF
                IF loc_cSaveExact = "ON"
                    SET EXACT ON
                ELSE
                    SET EXACT OFF
                ENDIF

                USE IN crTmpRelGf1

                loc_lSucesso = !EOF("crRel1")
                IF !loc_lSucesso
                    THIS.this_cMensagem = "Nenhum Registro Encontrado."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em ProcessarDados")
            THIS.this_cMensagem = "Erro no processamento: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir do cursor de resultado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmpresa     = NVL(Cemps, "")
            THIS.this_cTitulo1     = NVL(cTitulo1s, "")
            THIS.this_cTitulo2     = NVL(ctitulo2s, "")
            THIS.this_cNomeEmpresa = NVL(cEmpresas, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere linhas em SigCdFea diretamente
    * SigCdFea eh populada por outros processos do sistema (movimentacao de
    * producao). Este BO apenas LE e agrega dados para o relatorio de
    * "Falha X Recuperacao por Mes". Bloquear insercao evita gravacao acidental.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        THIS.this_cMensagem = "Form operacional: inser" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao atualiza linhas de SigCdFea
    * Bloqueia UPDATE por design: este BO consome dados agregados, nao mantem
    * cadastro. Alteracoes em SigCdFea ocorrem via processos de producao.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        THIS.this_cMensagem = "Form operacional: atualiza" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Form OPERACIONAL nao exclui linhas de SigCdFea
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagem = "Form operacional: exclus" + CHR(227) + "o direta " + ;
                              "em SigCdFea n" + CHR(227) + "o suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE

