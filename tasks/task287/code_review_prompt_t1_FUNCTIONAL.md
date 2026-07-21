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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (765 linhas total):

*-- Linhas 10 a 196:
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
77:                 *-- BINDEVENT: validacao interativa ao sair do campo DtFinal
78:                 *-- (equivale ao getDtFinal.Valid do legado)
79:                 BINDEVENT(THIS.txt_4c_DtFinal, "KeyPress", THIS, "TxtDtFinalKeyPress")
80: 
81:                 *-- Tornar controles visiveis (cnt_4c_Aguarde permanece oculto)
82:                 THIS.TornarControlesVisiveis()
83: 
84:                 *-- Datas iniciais: primeiro dia do mes atual / ultimo dia do mes
85:                 THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
86:                                                    "/" + LTRIM(STR(YEAR(DATE()), 4)))
87:                 THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
88: 
89:                 THIS.txt_4c_DtInicial.SetFocus
90: 
91:                 loc_lSucesso = .T.
92:             ENDIF
93: 
94:         CATCH TO loc_oErro
95:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
96:                     " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     * ConfigurarPaginaLista - Wrapper de montagem da tela unica (OPERACIONAL)
104:     * Original SIGPRGF1 NAO tem PageFrame nem Grid nem botoes CRUD (Incluir/
105:     * Alterar/Excluir/Buscar) ??? eh um painel de filtro (periodo) + Processar +
106:     * Encerrar. Este metodo agrega ConfigurarCabecalho + ConfigurarFiltros +
107:     * ConfigurarBotoes (CommandGroup Processar/Encerrar) + ConfigurarAguarde
108:     * mantendo o contrato esperado pela pipeline (PILAR 1: preservar UX legado).
109:     *--------------------------------------------------------------------------
110:     PROTECTED PROCEDURE ConfigurarPaginaLista()
111:         THIS.ConfigurarCabecalho()
112:         THIS.ConfigurarFiltros()
113:         THIS.ConfigurarBotoes()
114:         THIS.ConfigurarAguarde()
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * AlternarPagina - Navegacao entre paginas
119:     * Form OPERACIONAL de tela unica (SIGPRGF1 sem PageFrame): unica "pagina"
120:     * util eh o painel de filtro. Metodo mantido para atender contrato da
121:     * pipeline (fase 4) e para permitir refoco/reset apos processamento.
122:     *--------------------------------------------------------------------------
123:     PROCEDURE AlternarPagina(par_nPagina)
124:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
125:             THIS.txt_4c_DtInicial.SetFocus
126:         ENDIF
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------
130:     * ConfigurarPaginaDados - Contrato da pipeline (fase 5/6) para forms CRUD
131:     * O legado SIGPRGF1.SCX (Width=800, Height=158) NAO tem PageFrame nem
132:     * Page2 (Dados): eh um form OPERACIONAL flat com apenas painel de filtro
133:     * de periodo (getDtInicial + getDtFinal), CommandGroup Processar/Encerrar
134:     * e cntAguarde. Nao ha campos de edicao de registro, nao ha Grid CRUD.
135:     *
136:     * Todos os controles do form ja foram criados por ConfigurarPaginaLista()
137:     * nas fases 3-4 (cnt_4c_Cabecalho + cnt_4c_Aguarde + txt_4c_DtInicial +
138:     * txt_4c_DtFinal + lbl_4c_Periodo + cmg_4c_Processar). Este metodo eh
139:     * mantido como no-op documentado para atender o contrato de fases da
140:     * pipeline (que espera ConfigurarPaginaDados em todos os forms migrados).
141:     *
142:     * Se no futuro precisar adicionar campos de "detalhe" (segunda tela), a
143:     * implementacao seguiria o padrao AddObject aqui e a navegacao entre
144:     * paineis usaria .Visible = .T./.F. em containers filhos do form.
145:     *--------------------------------------------------------------------------
146:     PROTECTED PROCEDURE ConfigurarPaginaDados()
147:         *-- No-op intencional: SIGPRGF1 eh OPERACIONAL flat (ver comentario acima).
148:         *-- Sem PageFrame => sem Page2 => sem campos de dados adicionais.
149:         *-- ConfigurarPaginaLista() ja montou 100% dos controles do form legado.
150:         RETURN
151:     ENDPROC
152: 
153:     *--------------------------------------------------------------------------
154:     * ConfigurarCabecalho - Container escuro com titulo (equivale ao cntSombra)
155:     *--------------------------------------------------------------------------
156:     PROTECTED PROCEDURE ConfigurarCabecalho()
157:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
158:         WITH THIS.cnt_4c_Cabecalho
159:             .Top        = 0
160:             .Left       = 0
161:             .Width      = THIS.Width
162:             .Height     = 80
163:             .BackStyle  = 1
164:             .BackColor  = RGB(100,100,100)
165:             .BorderWidth = 0
166: 
167:             .AddObject("lbl_4c_Sombra", "Label")
168:             WITH .lbl_4c_Sombra
169:                 .Top       = 18
170:                 .Left      = 10
171:                 .Width     = THIS.Width
172:                 .Height    = 40
173:                 .AutoSize  = .F.
174:                 .FontBold  = .T.
175:                 .FontName  = "Tahoma"
176:                 .FontSize  = 18
177:                 .WordWrap  = .T.
178:                 .Alignment = 0
179:                 .BackStyle = 0
180:                 .Caption   = THIS.this_cCaption
181:                 .ForeColor = RGB(0,0,0)
182:             ENDWITH
183: 
184:             .AddObject("lbl_4c_Titulo", "Label")
185:             WITH .lbl_4c_Titulo
186:                 .Top       = 17
187:                 .Left      = 10
188:                 .Width     = THIS.Width
189:                 .Height    = 46
190:                 .AutoSize  = .F.
191:                 .FontBold  = .T.
192:                 .FontName  = "Tahoma"
193:                 .FontSize  = 18
194:                 .WordWrap  = .T.
195:                 .Alignment = 0
196:                 .BackStyle = 0

*-- Linhas 205 a 765:
205:     * Original: lbl_periodo (Top=116, Left=41) + getDtinicial (Top=111, Left=98)
206:     *           + getDtfinal (Top=111, Left=180)
207:     *--------------------------------------------------------------------------
208:     PROTECTED PROCEDURE ConfigurarFiltros()
209:         *-- Label "Periodo :"
210:         THIS.AddObject("lbl_4c_Periodo", "Label")
211:         WITH THIS.lbl_4c_Periodo
212:             .Top      = 116
213:             .Left     = 41
214:             .Width    = 50
215:             .Height   = 15
216:             .AutoSize = .F.
217:             .Caption  = "Per" + CHR(237) + "odo :"
218:             .FontName = "Tahoma"
219:             .FontSize = 8
220:         ENDWITH
221: 
222:         *-- Data Inicial (getDtinicial)
223:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
224:         WITH THIS.txt_4c_DtInicial
225:             .Top       = 111
226:             .Left      = 98
227:             .Width     = 79
228:             .Height    = 25
229:             .Format    = "K"
230:             .Value     = {}
231:             .FontName  = "Tahoma"
232:             .FontSize  = 8
233:             .TabIndex  = 1
234:         ENDWITH
235: 
236:         *-- Data Final (getDtfinal)
237:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
238:         WITH THIS.txt_4c_DtFinal
239:             .Top      = 111
240:             .Left     = 180
241:             .Width    = 79
242:             .Height   = 25
243:             .Format   = "K"
244:             .Value    = {}
245:             .FontName = "Tahoma"
246:             .FontSize = 8
247:             .TabIndex = 2
248:         ENDWITH
249:     ENDPROC
250: 
251:     *--------------------------------------------------------------------------
252:     * ConfigurarBotoes - CommandGroup com Processar + Encerrar
253:     * Original: cmdGprocessa (Top=-2, Left=643, Width=160, Height=85)
254:     *--------------------------------------------------------------------------
255:     PROTECTED PROCEDURE ConfigurarBotoes()
256:         THIS.AddObject("cmg_4c_Processar", "CommandGroup")
257:         WITH THIS.cmg_4c_Processar
258:             .Top         = -2
259:             .Left        = 643
260:             .Width       = 160
261:             .Height      = 85
262:             .ButtonCount = 2
263:             .BackStyle   = 0
264:             .BorderStyle = 0
265:             .SpecialEffect = 1
266: 
267:             WITH .Buttons(1)
268:                 .Top         = 5
269:                 .Left        = 5
270:                 .Width       = 75
271:                 .Height      = 75
272:                 .Caption     = "Processar"
273:                 .Picture     = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
274:                 .FontBold    = .T.
275:                 .FontItalic  = .T.
276:                 .WordWrap    = .T.
277:                 .ForeColor   = RGB(90,90,90)
278:                 .BackColor   = RGB(255,255,255)
279:                 .Themes      = .F.
280:                 .PicturePosition = 13
281:             ENDWITH
282: 
283:             WITH .Buttons(2)
284:                 .Top         = 5
285:                 .Left        = 80
286:                 .Width       = 75
287:                 .Height      = 75
288:                 .Caption     = "Encerrar"
289:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
290:                 .Cancel      = .T.
291:                 .FontBold    = .T.
292:                 .FontItalic  = .T.
293:                 .FontName    = "Comic Sans MS"
294:                 .FontSize    = 8
295:                 .WordWrap    = .T.
296:                 .ForeColor   = RGB(90,90,90)
297:                 .BackColor   = RGB(255,255,255)
298:                 .Themes      = .F.
299:                 .PicturePosition = 13
300:             ENDWITH
301:         ENDWITH
302: 
303:         BINDEVENT(THIS.cmg_4c_Processar.Buttons(1), "Click", THIS, "BtnProcessarClick")
304:         BINDEVENT(THIS.cmg_4c_Processar.Buttons(2), "Click", THIS, "BtnEncerrarClick")
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * ConfigurarAguarde - Container de indicador de processamento (Visible=.F.)
309:     * Original: cntAguarde (Top=99, Left=312, Width=207, Height=49)
310:     *--------------------------------------------------------------------------
311:     PROTECTED PROCEDURE ConfigurarAguarde()
312:         THIS.AddObject("cnt_4c_Aguarde", "Container")
313:         WITH THIS.cnt_4c_Aguarde
314:             .Top        = 99
315:             .Left       = 312
316:             .Width      = 207
317:             .Height     = 49
318:             .BackStyle  = 1
319:             .BackColor  = RGB(255,255,255)
320:             .BorderWidth = 0
321:             .SpecialEffect = 0
322:             .Visible    = .F.
323: 
324:             .AddObject("lbl_4c_Aguarde", "Label")
325:             WITH .lbl_4c_Aguarde
326:                 .Top       = 7
327:                 .Left      = 69
328:                 .Width     = 78
329:                 .Height    = 18
330:                 .AutoSize  = .F.
331:                 .FontBold  = .T.
332:                 .FontName  = "Verdana"
333:                 .FontSize  = 10
334:                 .BackStyle = 0
335:                 .Caption   = "Aguarde..."
336:                 .ForeColor = RGB(255,0,0)
337:                 .Visible   = .T.
338:             ENDWITH
339: 
340:             .AddObject("lbl_4c_Processando", "Label")
341:             WITH .lbl_4c_Processando
342:                 .Top       = 24
343:                 .Left      = 34
344:                 .Width     = 141
345:                 .Height    = 18
346:                 .AutoSize  = .F.
347:                 .FontBold  = .T.
348:                 .FontName  = "Tahoma"
349:                 .FontSize  = 10
350:                 .BackStyle = 0
351:                 .Caption   = "Processando Dados..."
352:                 .ForeColor = RGB(90,90,90)
353:                 .Visible   = .T.
354:             ENDWITH
355:         ENDWITH
356:     ENDPROC
357: 
358:     *--------------------------------------------------------------------------
359:     * TornarControlesVisiveis - Torna controles visiveis
360:     * cnt_4c_Aguarde permanece oculto (toggled durante processamento)
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE TornarControlesVisiveis()
363:         LOCAL loc_i, loc_oControl
364:         FOR loc_i = 1 TO THIS.ControlCount
365:             loc_oControl = THIS.Controls(loc_i)
366:             IF VARTYPE(loc_oControl) = "O"
367:                 IF UPPER(loc_oControl.Name) = "CNT_4C_AGUARDE"
368:                     *-- Recursar filhos antes de LOOP para que fiquem visiveis
369:                     *-- quando o container for exibido durante o processamento
370:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
371:                         THIS.TornarSubControlesVisiveis(loc_oControl)
372:                     ENDIF
373:                     LOOP
374:                 ENDIF
375:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
376:                     loc_oControl.Visible = .T.
377:                 ENDIF
378:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
379:                     THIS.TornarSubControlesVisiveis(loc_oControl)
380:                 ENDIF
381:             ENDIF
382:         ENDFOR
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * TornarSubControlesVisiveis - Recursao para sub-containers
387:     *--------------------------------------------------------------------------
388:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
389:         LOCAL loc_i, loc_oControl
390:         FOR loc_i = 1 TO par_oContainer.ControlCount
391:             loc_oControl = par_oContainer.Controls(loc_i)
392:             IF VARTYPE(loc_oControl) = "O"
393:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
394:                     loc_oControl.Visible = .T.
395:                 ENDIF
396:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
397:                     THIS.TornarSubControlesVisiveis(loc_oControl)
398:                 ENDIF
399:             ENDIF
400:         ENDFOR
401:     ENDPROC
402: 
403:     *--------------------------------------------------------------------------
404:     * BtnProcessarClick - Valida periodo, processa dados, abre FormSigPrGf2
405:     * Equivalente ao cmdProcessa.Click do legado
406:     *--------------------------------------------------------------------------
407:     PROCEDURE BtnProcessarClick()
408:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro, loc_oGf2
409:         loc_lSucesso   = .F.
410:         loc_lContinuar = .T.
411: 
412:         TRY
413:             *-- Transferir datas para o BO
414:             THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
415:             THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
416: 
417:             *-- Validar periodo
418:             IF !THIS.this_oBusinessObject.ValidarPeriodo()
419:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
420:                 loc_lContinuar = .F.
421:             ENDIF
422: 
423:             IF loc_lContinuar
424:                 *-- Exibir indicador de processamento
425:                 THIS.cnt_4c_Aguarde.Visible = .T.
426:                 THIS.LockScreen = .T.
427:                 THIS.Refresh
428: 
429:                 *-- Processar dados
430:                 loc_lSucesso = THIS.this_oBusinessObject.ProcessarDados()
431: 
432:                 THIS.cnt_4c_Aguarde.Visible = .F.
433:                 THIS.LockScreen = .F.
434:                 THIS.Refresh
435: 
436:                 IF loc_lSucesso
437:                     *-- Desabilitar este form e abrir resultado
438:                     THIS.Enabled = .F.
439:                     loc_oGf2 = CREATEOBJECT("FormSigPrGf2", THIS)
440:                     IF VARTYPE(loc_oGf2) = "O"
441:                         loc_oGf2.Show()
442:                     ELSE
443:                         THIS.Enabled = .T.
444:                         MsgErro("Erro ao criar FormSigPrGf2." + CHR(13) + ;
445:                                 "VARTYPE retornou: " + VARTYPE(loc_oGf2), "Erro")
446:                     ENDIF
447:                 ELSE
448:                     IF !EMPTY(THIS.this_oBusinessObject.this_cMensagem)
449:                         MsgAviso(THIS.this_oBusinessObject.this_cMensagem, ;
450:                                  "Aten" + CHR(231) + CHR(227) + "o")
451:                     ENDIF
452:                 ENDIF
453:             ENDIF
454: 
455:         CATCH TO loc_oErro
456:             THIS.cnt_4c_Aguarde.Visible = .F.
457:             THIS.LockScreen = .F.
458:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
459:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnProcessarClick")
460:         ENDTRY
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * BtnEncerrarClick - Fecha o form e reativa o form pai (se existir)
465:     * Equivalente ao cmdSair.Click do legado
466:     *--------------------------------------------------------------------------
467:     PROCEDURE BtnEncerrarClick()
468:         LOCAL loc_oErro
469: 
470:         TRY
471:             THIS.LockScreen = .T.
472: 
473:             IF USED("crLstMatLote")
474:                 USE IN crLstMatLote
475:             ENDIF
476: 
477:             IF TYPE("THIS.poForm1") = "O"
478:                 THIS.poForm1.LockScreen = .T.
479:                 THIS.poForm1.Enabled    = .T.
480:                 IF PEMSTATUS(THIS.poForm1, "mAtivaPgMovto1", 5)
481:                     THIS.poForm1.mAtivaPgMovto1()
482:                 ENDIF
483:                 THIS.poForm1.LockScreen = .F.
484:             ENDIF
485: 
486:             THIS.Release()
487: 
488:         CATCH TO loc_oErro
489:             THIS.LockScreen = .F.
490:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
491:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnEncerrarClick")
492:         ENDTRY
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * TxtDtFinalKeyPress - Valida periodo ao sair do campo Data Final
497:     * Equivalente ao getDtFinal.Valid do legado: bloqueia ENTER/TAB quando
498:     * DtFinal invalida, DtFinal < DtInicial ou periodo > 12 meses
499:     *--------------------------------------------------------------------------
500:     PROCEDURE TxtDtFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
501: 
502:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
503:             RETURN
504:         ENDIF
505: 
506:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
507:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
508: 
509:         IF !THIS.this_oBusinessObject.ValidarPeriodo()
510:             MsgAviso(THIS.this_oBusinessObject.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
511:             IF EMPTY(THIS.txt_4c_DtFinal.Value)
512:                 THIS.txt_4c_DtFinal.SetFocus
513:             ELSE
514:                 THIS.txt_4c_DtInicial.SetFocus
515:             ENDIF
516:         ENDIF
517:     ENDPROC
518: 
519:     *--------------------------------------------------------------------------
520:     * BtnIncluirClick - Reset do filtro para novo processamento (equivalente
521:     * a "Nova consulta" em OPERACIONAL): restaura periodo padrao (mes corrente)
522:     * e devolve foco a DtInicial. Nao existe INSERT em SigPrGf1 (nao ha entidade
523:     * persistida ??? o form apenas processa saldos em memoria via ProcessarDados).
524:     *--------------------------------------------------------------------------
525:     PROCEDURE BtnIncluirClick()
526:         LOCAL loc_oErro
527: 
528:         TRY
529:             THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
530:                                                "/" + LTRIM(STR(YEAR(DATE()), 4)))
531:             THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
532: 
533:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
534:                 THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
535:                 THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
536:                 THIS.this_oBusinessObject.this_cMensagem  = ""
537:             ENDIF
538: 
539:             THIS.Refresh
540:             THIS.txt_4c_DtInicial.SetFocus
541: 
542:         CATCH TO loc_oErro
543:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
544:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
545:         ENDTRY
546:     ENDPROC
547: 
548:     *--------------------------------------------------------------------------
549:     * BtnAlterarClick - Habilita edicao interativa do filtro de periodo:
550:     * garante que os campos de data estejam editaveis e devolve foco a
551:     * DtInicial. Nao ha UPDATE persistente em SigPrGf1 (form OPERACIONAL sem
552:     * entidade CRUD) ??? este evento existe para atender ao contrato da pipeline
553:     * e para uso via atalho de teclado equivalente a "editar filtro".
554:     *--------------------------------------------------------------------------
555:     PROCEDURE BtnAlterarClick()
556:         LOCAL loc_oErro
557: 
558:         TRY
559:             THIS.txt_4c_DtInicial.Enabled  = .T.
560:             THIS.txt_4c_DtInicial.ReadOnly = .F.
561:             THIS.txt_4c_DtFinal.Enabled    = .T.
562:             THIS.txt_4c_DtFinal.ReadOnly   = .F.
563: 
564:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
565:                 THIS.this_oBusinessObject.this_cMensagem = ""
566:             ENDIF
567: 
568:             THIS.Refresh
569:             THIS.txt_4c_DtInicial.SetFocus
570: 
571:         CATCH TO loc_oErro
572:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
573:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
574:         ENDTRY
575:     ENDPROC
576: 
577:     *--------------------------------------------------------------------------
578:     * BtnVisualizarClick - Executa o processamento e abre o resultado
579:     * (FormSigPrGf2). Em forms OPERACIONAIS de relatorio/consulta, "Visualizar"
580:     * corresponde a executar a consulta e exibir o resultado ??? equivale ao
581:     * BtnProcessarClick. Delegamos para reaproveitar validacao de periodo,
582:     * indicador cnt_4c_Aguarde e tratamento de erros.
583:     *--------------------------------------------------------------------------
584:     PROCEDURE BtnVisualizarClick()
585:         THIS.BtnProcessarClick()
586:     ENDPROC
587: 
588:     *--------------------------------------------------------------------------
589:     * BtnExcluirClick - Limpa o filtro de periodo (equivalente a "cancelar
590:     * consulta"): zera datas, limpa mensagem do BO e devolve foco a DtInicial.
591:     * Nao existe DELETE em SigPrGf1 (form OPERACIONAL sem entidade persistida)
592:     * ??? este evento existe para atender ao contrato da pipeline.
593:     *--------------------------------------------------------------------------
594:     PROCEDURE BtnExcluirClick()
595:         LOCAL loc_oErro
596: 
597:         TRY
598:             THIS.txt_4c_DtInicial.Value = {}
599:             THIS.txt_4c_DtFinal.Value   = {}
600: 
601:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
602:                 THIS.this_oBusinessObject.this_dDtInicial = {}
603:                 THIS.this_oBusinessObject.this_dDtFinal   = {}
604:                 THIS.this_oBusinessObject.this_cMensagem  = ""
605:             ENDIF
606: 
607:             IF USED("crLstMatLote")
608:                 USE IN crLstMatLote
609:             ENDIF
610: 
611:             THIS.Refresh
612:             THIS.txt_4c_DtInicial.SetFocus
613: 
614:         CATCH TO loc_oErro
615:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
616:                     " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
617:         ENDTRY
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * BtnBuscarClick - Busca/consulta (OPERACIONAL: delega ao processamento)
622:     * Original: a acao "Buscar" neste form equivale a executar o processamento
623:     * com o periodo atual sem resetar os campos de data.
624:     *--------------------------------------------------------------------------
625:     PROCEDURE BtnBuscarClick()
626:         THIS.BtnProcessarClick()
627:     ENDPROC
628: 
629:     *--------------------------------------------------------------------------
630:     * BtnSalvarClick - Nao aplicavel (form OPERACIONAL sem entidade persistida)
631:     * Contrato da pipeline: delega ao BtnProcessarClick para manter coerencia.
632:     *--------------------------------------------------------------------------
633:     PROCEDURE BtnSalvarClick()
634:         THIS.BtnProcessarClick()
635:     ENDPROC
636: 
637:     *--------------------------------------------------------------------------
638:     * BtnCancelarClick - Cancela/limpa o filtro de periodo e reseta o form
639:     *--------------------------------------------------------------------------
640:     PROCEDURE BtnCancelarClick()
641:         THIS.LimparCampos()
642:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
643:             THIS.txt_4c_DtInicial.SetFocus
644:         ENDIF
645:     ENDPROC
646: 
647:     *--------------------------------------------------------------------------
648:     * FormParaBO - Transfere campos do form para o Business Object
649:     *--------------------------------------------------------------------------
650:     PROCEDURE FormParaBO()
651:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
652:             RETURN .F.
653:         ENDIF
654: 
655:         THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
656:         THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
657:         THIS.this_oBusinessObject.this_cEmpresa   = go_4c_Sistema.cCodEmpresa
658: 
659:         RETURN .T.
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * BOParaForm - Transfere dados do Business Object de volta para o form
664:     *--------------------------------------------------------------------------
665:     PROCEDURE BOParaForm()
666:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
667:             RETURN .F.
668:         ENDIF
669: 
670:         IF !EMPTY(THIS.this_oBusinessObject.this_dDtInicial)
671:             THIS.txt_4c_DtInicial.Value = THIS.this_oBusinessObject.this_dDtInicial
672:         ENDIF
673:         IF !EMPTY(THIS.this_oBusinessObject.this_dDtFinal)
674:             THIS.txt_4c_DtFinal.Value = THIS.this_oBusinessObject.this_dDtFinal
675:         ENDIF
676: 
677:         RETURN .T.
678:     ENDPROC
679: 
680:     *--------------------------------------------------------------------------
681:     * HabilitarCampos - Habilita ou desabilita campos de edicao conforme modo
682:     * par_lHabilitar = .T. => campos editaveis | .F. => campos somente leitura
683:     *--------------------------------------------------------------------------
684:     PROCEDURE HabilitarCampos(par_lHabilitar)
685:         LOCAL loc_lHabilitar
686:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
687: 
688:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
689:             THIS.txt_4c_DtInicial.Enabled  = loc_lHabilitar
690:             THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
691:         ENDIF
692:         IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
693:             THIS.txt_4c_DtFinal.Enabled  = loc_lHabilitar
694:             THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
695:         ENDIF
696:     ENDPROC
697: 
698:     *--------------------------------------------------------------------------
699:     * LimparCampos - Limpa os campos de filtro de periodo
700:     *--------------------------------------------------------------------------
701:     PROCEDURE LimparCampos()
702:         IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
703:             THIS.txt_4c_DtInicial.Value = {}
704:         ENDIF
705:         IF VARTYPE(THIS.txt_4c_DtFinal) = "O"
706:             THIS.txt_4c_DtFinal.Value = {}
707:         ENDIF
708: 
709:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
710:             THIS.this_oBusinessObject.this_dDtInicial = {}
711:             THIS.this_oBusinessObject.this_dDtFinal   = {}
712:             THIS.this_oBusinessObject.this_cMensagem  = ""
713:             THIS.this_oBusinessObject.this_cTitulo1   = ""
714:             THIS.this_oBusinessObject.this_cTitulo2   = ""
715:         ENDIF
716: 
717:         IF USED("crLstMatLote")
718:             USE IN crLstMatLote
719:         ENDIF
720:         IF USED("crRel1")
721:             USE IN crRel1
722:         ENDIF
723:     ENDPROC
724: 
725:     *--------------------------------------------------------------------------
726:     * CarregarLista - Sem grid/lista neste form OPERACIONAL (apenas filtro)
727:     * Contrato da pipeline: restaura o periodo padrao (mes corrente) caso
728:     * os campos estejam vazios, garantindo estado inicial consistente.
729:     *--------------------------------------------------------------------------
730:     PROCEDURE CarregarLista()
731:         LOCAL loc_lResultado
732:         loc_lResultado = .T.
733: 
734:         IF EMPTY(THIS.txt_4c_DtInicial.Value) AND EMPTY(THIS.txt_4c_DtFinal.Value)
735:             THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
736:                                                "/" + LTRIM(STR(YEAR(DATE()), 4)))
737:             THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
738:         ENDIF
739: 
740:         RETURN loc_lResultado
741:     ENDPROC
742: 
743:     *--------------------------------------------------------------------------
744:     * AjustarBotoesPorModo - Sem modos CRUD neste form OPERACIONAL
745:     * Contrato da pipeline: mantido como no-op documentado pois SIGPRGF1 tem
746:     * apenas Processar e Encerrar (sem Incluir/Alterar/Excluir/Buscar/Salvar).
747:     *--------------------------------------------------------------------------
748:     PROCEDURE AjustarBotoesPorModo()
749:         *-- No-op: SIGPRGF1 e form OPERACIONAL flat sem modos CRUD.
750:         *-- Os unicos botoes (Processar/Encerrar em cmg_4c_Processar) permanecem
751:         *-- sempre habilitados enquanto o form estiver ativo.
752:         RETURN
753:     ENDPROC
754: 
755:     *--------------------------------------------------------------------------
756:     * Destroy
757:     *--------------------------------------------------------------------------
758:     PROCEDURE Destroy()
759:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
760:             THIS.this_oBusinessObject = .NULL.
761:         ENDIF
762:         DODEFAULT()
763:     ENDPROC
764: 
765: ENDDEFINE


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

