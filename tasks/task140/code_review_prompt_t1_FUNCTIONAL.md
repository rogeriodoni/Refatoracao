# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMen.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (572 linhas total):

*-- Linhas 27 a 292:
27:     Caption    = "Mensagens"
28: 
29:     *--------------------------------------------------------------------------
30:     PROCEDURE Init(par_cCidChave, par_cDescr1, par_cDescr2)
31:     *--------------------------------------------------------------------------
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.this_cCidChave = IIF(VARTYPE(par_cCidChave) = "C", ALLTRIM(par_cCidChave), "")
37:             THIS.this_cDescr1   = IIF(VARTYPE(par_cDescr1) = "C", par_cDescr1, "")
38:             THIS.this_cDescr2   = IIF(VARTYPE(par_cDescr2) = "C", par_cDescr2, "")
39:             THIS.this_lUsaDescr = (VARTYPE(par_cDescr1) = "C")
40: 
41:             THIS.this_oBusinessObject = CREATEOBJECT("SigPdMenBO")
42:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
43:                 loc_lSucesso = DODEFAULT()
44:             ELSE
45:                 MsgErro("Erro ao criar Business Object de Mensagens.", "Erro")
46:             ENDIF
47:         CATCH TO loc_oErro
48:             MsgErro(loc_oErro.Message, "Erro")
49:         ENDTRY
50: 
51:         RETURN loc_lSucesso
52:     ENDPROC
53: 
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:     *--------------------------------------------------------------------------
57:         LOCAL loc_lSucesso
58:         loc_lSucesso = .F.
59: 
60:         TRY
61:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
62: 
63:             THIS.ConfigurarPageFrame()
64:             THIS.ConfigurarCabecalho()
65:             THIS.ConfigurarShape()
66:             THIS.ConfigurarLabel2()
67:             THIS.ConfigurarContainer()
68:             THIS.ConfigurarBotaoOk()
69: 
70:             THIS.TornarControlesVisiveis(THIS)
71: 
72:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                 THIS.CarregarMensagem()
74:             ENDIF
75: 
76:             loc_lSucesso = .T.
77:         CATCH TO loc_oErro
78:             MsgErro(loc_oErro.Message, "Erro")
79:         ENDTRY
80: 
81:         RETURN loc_lSucesso
82:     ENDPROC
83: 
84:     *--------------------------------------------------------------------------
85:     * ConfigurarPageFrame - Form OPERACIONAL plano (sem PageFrame):
86:     * aplica propriedades de form (BackColor, fontes, ShowTips) equivalentes
87:     * ao container raiz do dialog do legado.
88:     *--------------------------------------------------------------------------
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.BackColor  = RGB(212, 208, 200)
91:         THIS.ScrollBars = 0
92:         THIS.ShowTips   = .T.
93:         THIS.SetAll("FontName", "Tahoma")
94:         THIS.SetAll("FontSize", 8)
95:     ENDPROC
96: 
97:     *--------------------------------------------------------------------------
98:     PROTECTED PROCEDURE ConfigurarCabecalho()
99:     *--------------------------------------------------------------------------
100:         THIS.AddObject("cnt_4c_Sombra", "Container")
101:         WITH THIS.cnt_4c_Sombra
102:             .Top         = 0
103:             .Left        = 0
104:             .Width       = THIS.Width
105:             .Height      = 80
106:             .BorderWidth = 0
107:             .BackColor   = RGB(100, 100, 100)
108:             .Visible     = .T.
109:         ENDWITH
110: 
111:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
112:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
113:             .FontBold  = .T.
114:             .FontName  = "Tahoma"
115:             .FontSize  = 18
116:             .WordWrap  = .T.
117:             .Alignment = 0
118:             .BackStyle = 0
119:             .Caption   = "Mensagens"
120:             .Height    = 40
121:             .Left      = 10
122:             .Top       = 18
123:             .Width     = 769
124:             .ForeColor = RGB(0, 0, 0)
125:             .Visible   = .T.
126:         ENDWITH
127: 
128:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
129:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
130:             .FontBold  = .T.
131:             .FontName  = "Tahoma"
132:             .FontSize  = 18
133:             .WordWrap  = .T.
134:             .Alignment = 0
135:             .BackStyle = 0
136:             .Caption   = "Mensagens"
137:             .Height    = 46
138:             .Left      = 10
139:             .Top       = 17
140:             .Width     = 769
141:             .ForeColor = RGB(255, 255, 255)
142:             .Visible   = .T.
143:         ENDWITH
144:     ENDPROC
145: 
146:     *--------------------------------------------------------------------------
147:     PROTECTED PROCEDURE ConfigurarShape()
148:     *--------------------------------------------------------------------------
149:         THIS.AddObject("shp_4c_Shape1", "Shape")
150:         WITH THIS.shp_4c_Shape1
151:             .Top         = 7
152:             .Left        = 691
153:             .Height      = 110
154:             .Width       = 90
155:             .BackStyle   = 0
156:             .BorderStyle = 0
157:             .BorderColor = RGB(136, 189, 188)
158:             .Visible     = .T.
159:         ENDWITH
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE ConfigurarLabel2()
164:     *--------------------------------------------------------------------------
165:         THIS.AddObject("lbl_4c_Label2", "Label")
166:         WITH THIS.lbl_4c_Label2
167:             .AutoSize  = .T.
168:             .FontBold  = .T.
169:             .FontName  = "Tahoma"
170:             .FontSize  = 8
171:             .BackStyle = 0
172:             .Caption   = "[ Texto ]"
173:             .Height    = 15
174:             .Left      = 376
175:             .Top       = 90
176:             .Width     = 51
177:             .ForeColor = RGB(90, 90, 90)
178:             .Visible   = .T.
179:         ENDWITH
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarContainer()
184:     *--------------------------------------------------------------------------
185:         THIS.AddObject("cnt_4c_Container1", "Container")
186:         WITH THIS.cnt_4c_Container1
187:             .Top           = 108
188:             .Left          = 123
189:             .Width         = 554
190:             .Height        = 150
191:             .SpecialEffect = 1
192:             .BackColor     = RGB(255, 255, 255)
193:             .Visible       = .T.
194:         ENDWITH
195: 
196:         THIS.cnt_4c_Container1.AddObject("obj_4c_GetMemo", "EditBox")
197:         WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
198:             .BorderStyle = 0
199:             .Height      = 140
200:             .Left        = 6
201:             .ReadOnly    = .T.
202:             .ScrollBars  = 0
203:             .Top         = 5
204:             .Width       = 541
205:             .BackColor   = RGB(212, 208, 200)
206:             .Visible     = .F.
207:         ENDWITH
208: 
209:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Gettexto", "Label")
210:         WITH THIS.cnt_4c_Container1.lbl_4c_Gettexto
211:             .WordWrap  = .T.
212:             .Alignment = 2
213:             .Caption   = ""
214:             .Height    = 123
215:             .Left      = 8
216:             .Top       = 8
217:             .Width     = 520
218:             .Visible   = .T.
219:         ENDWITH
220:     ENDPROC
221: 
222:     *--------------------------------------------------------------------------
223:     PROTECTED PROCEDURE ConfigurarBotaoOk()
224:     *--------------------------------------------------------------------------
225:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
226:         WITH THIS.cmd_4c_Ok
227:             .Top           = 3
228:             .Left          = 725
229:             .Width         = 75
230:             .Height        = 75
231:             .Caption       = "OK"
232:             .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
233:             .FontName      = "Comic Sans MS"
234:             .FontBold      = .T.
235:             .FontItalic    = .T.
236:             .FontSize      = 8
237:             .ForeColor     = RGB(90, 90, 90)
238:             .BackColor     = RGB(255, 255, 255)
239:             .Themes        = .F.
240:             .SpecialEffect = 0
241:             .MousePointer  = 15
242:             .WordWrap      = .T.
243:             .PicturePosition = 13
244:             .Visible       = .T.
245:         ENDWITH
246: 
247:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
248:     ENDPROC
249: 
250:     *--------------------------------------------------------------------------
251:     PROTECTED PROCEDURE CarregarMensagem()
252:     *--------------------------------------------------------------------------
253:         LOCAL loc_cCaption, loc_cCaptionA, loc_cCaptionB
254: 
255:         IF EMPTY(THIS.this_cCidChave)
256:             RETURN
257:         ENDIF
258: 
259:         IF !THIS.this_oBusinessObject.BuscarMensagem(THIS.this_cCidChave)
260:             RETURN
261:         ENDIF
262: 
263:         loc_cCaptionA = IIF(THIS.this_lUsaDescr, ;
264:                             THIS.this_cDescr1, ;
265:                             THIS.this_oBusinessObject.this_cLinha1s)
266:         loc_cCaptionB = IIF(THIS.this_lUsaDescr, ;
267:                             THIS.this_cDescr2, ;
268:                             THIS.this_oBusinessObject.this_cLinha2s)
269: 
270:         loc_cCaption = "Mensagem da Empresa: " + ;
271:                        THIS.this_oBusinessObject.this_cEmps + ;
272:                        " para o Produto : " + ;
273:                        THIS.this_oBusinessObject.this_cCpros
274: 
275:         THIS.Caption = loc_cCaption
276:         THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
277:         THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
278: 
279:         *-- BO usa ALLTRIM ao carregar: "I " -> "I", "B " -> "B", "BI" permanece
280:         LOCAL loc_cEstilos
281:         loc_cEstilos = ALLTRIM(THIS.this_oBusinessObject.this_cEstilos)
282: 
283:         IF THIS.this_lUsaDescr
284:             THIS.cnt_4c_Container1.lbl_4c_Gettexto.Visible = .F.
285:             WITH THIS.cnt_4c_Container1.obj_4c_GetMemo
286:                 .Visible    = .T.
287:                 .Value      = ALLTRIM(loc_cCaptionA + loc_cCaptionB)
288:                 .FontName   = ALLTRIM(THIS.this_oBusinessObject.this_cFontes)
289:                 .FontSize   = THIS.this_oBusinessObject.this_nTamanhos
290:                 .ForeColor  = THIS.this_oBusinessObject.this_nCors
291:                 .FontBold   = .F.
292:                 .FontItalic = .F.

*-- Linhas 322 a 572:
322:     * CmdOkClick - Handler do botao OK
323:     * Fecha o form se pressionado via mouse; exibe aviso se via ENTER
324:     *--------------------------------------------------------------------------
325:     PROCEDURE CmdOkClick()
326:         IF LASTKEY() # 13
327:             THIS.Release()
328:         ELSE
329:             MsgInfo("Click No Bot" + CHR(227) + "o Ok Para Sair", "")
330:             CLEAR TYPEAHEAD
331:             KEYBOARD CHR(27)
332:         ENDIF
333:     ENDPROC
334: 
335:     *--------------------------------------------------------------------------
336:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
337:     *--------------------------------------------------------------------------
338:         LOCAL loc_nI, loc_oObjeto
339: 
340:         FOR loc_nI = 1 TO par_oContainer.ControlCount
341:             loc_oObjeto = par_oContainer.Controls(loc_nI)
342: 
343:             IF VARTYPE(loc_oObjeto) = "O"
344:                 *-- obj_4c_GetMemo comeca oculto; CarregarMensagem decide se exibe
345:                 IF UPPER(loc_oObjeto.Name) = "OBJ_4C_GETMEMO"
346:                     LOOP
347:                 ENDIF
348: 
349:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
350:                     loc_oObjeto.Visible = .T.
351:                 ENDIF
352: 
353:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
354:                     LOCAL loc_nP
355:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
356:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
357:                     ENDFOR
358:                 ENDIF
359: 
360:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
361:                     THIS.TornarControlesVisiveis(loc_oObjeto)
362:                 ENDIF
363:             ENDIF
364:         ENDFOR
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * ConfigurarPaginaLista - Adaptador para forms OPERACIONAIS planos
369:     *
370:     * SIGPDMEN eh um dialog modal de exibicao de mensagem (sem PageFrame e
371:     * sem Page1/Lista). Nao ha grade nem botoes CRUD ??? a "lista" equivale
372:     * ao conteudo da mensagem renderizado dentro de cnt_4c_Container1.
373:     *
374:     * Este metodo expoe a assinatura usada por callers genericos para
375:     * "recarregar a lista": forca a re-carga da mensagem corrente a partir
376:     * do banco (SigCdMsg) atraves do BO ja instanciado, mantendo coerencia
377:     * com a UI original do SCX legado.
378:     *--------------------------------------------------------------------------
379:     PROTECTED PROCEDURE ConfigurarPaginaLista()
380:         IF EMPTY(THIS.this_cCidChave)
381:             RETURN
382:         ENDIF
383:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
384:             RETURN
385:         ENDIF
386:         IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
387:             RETURN
388:         ENDIF
389:         THIS.CarregarMensagem()
390:     ENDPROC
391: 
392:     *--------------------------------------------------------------------------
393:     * ConfigurarPaginaDados - Adaptador para forms OPERACIONAIS planos
394:     *
395:     * SIGPDMEN eh um dialog modal de exibicao de mensagem (sem PageFrame e
396:     * sem Page2/Dados). Nao ha campos editaveis nem botoes Salvar/Cancelar.
397:     *
398:     * Este metodo expoe a assinatura usada por callers genericos que esperam
399:     * a interface FormBase (ConfigurarPaginaDados). Para este form, toda a
400:     * configuracao de controles ja foi feita em ConfigurarContainer(),
401:     * ConfigurarBotaoOk() e ConfigurarCabecalho(), invocados por InicializarForm().
402:     *--------------------------------------------------------------------------
403:     PROTECTED PROCEDURE ConfigurarPaginaDados()
404:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
405:             THIS.cnt_4c_Container1.Visible = .T.
406:             THIS.cnt_4c_Container1.Refresh()
407:         ENDIF
408:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
409:             THIS.cmd_4c_Ok.Visible = .T.
410:             THIS.cmd_4c_Ok.Enabled = .T.
411:         ENDIF
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * AlternarPagina - Adaptador para forms OPERACIONAIS planos
416:     *
417:     * Forms OPERACIONAIS planos nao tem PageFrame para alternar entre
418:     * Page1 (Lista) e Page2 (Dados). SIGPDMEN exibe somente o painel de
419:     * mensagem e o botao OK.
420:     *
421:     * Este metodo expoe a assinatura usada por callers genericos:
422:     *   - par_nPagina = 1 (Lista)  -> garante container visivel e refresh
423:     *   - par_nPagina = 2 (Dados) -> idem (mesma area visual)
424:     * O foco eh sempre devolvido ao botao OK (unico controle interativo).
425:     *--------------------------------------------------------------------------
426:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
427:         LOCAL loc_nPagina
428:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
429: 
430:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
431:             THIS.cnt_4c_Container1.Visible = .T.
432:             THIS.cnt_4c_Container1.Refresh()
433:         ENDIF
434: 
435:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5) AND THIS.cmd_4c_Ok.Visible
436:             THIS.cmd_4c_Ok.SetFocus()
437:         ENDIF
438: 
439:         RETURN loc_nPagina
440:     ENDPROC
441: 
442:     *--------------------------------------------------------------------------
443:     * BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick / BtnExcluirClick
444:     *
445:     * SIGPDMEN eh um dialog de exibicao de mensagem (read-only, sem CRUD).
446:     * Estes metodos existem para satisfazer a interface FormBase; o form
447:     * nao expoe botoes CRUD nem suporta operacoes de escrita no banco.
448:     * FormBase pode acionar estes handlers via teclas F2-F5 herdadas; o
449:     * comportamento correto neste contexto eh fechar o dialog (acao
450:     * equivalente ao botao OK, unico controle interativo disponivel).
451:     *--------------------------------------------------------------------------
452:     PROCEDURE BtnIncluirClick()
453:         THIS.Release()
454:     ENDPROC
455: 
456:     PROCEDURE BtnAlterarClick()
457:         THIS.Release()
458:     ENDPROC
459: 
460:     PROCEDURE BtnVisualizarClick()
461:         THIS.Release()
462:     ENDPROC
463: 
464:     PROCEDURE BtnExcluirClick()
465:         THIS.Release()
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * BtnBuscarClick / BtnEncerrarClick
470:     *
471:     * Adapters para interface FormBase: SIGPDMEN eh dialog somente-leitura.
472:     * Qualquer acao de "fechar" equivale a clicar OK.
473:     *--------------------------------------------------------------------------
474:     PROCEDURE BtnBuscarClick()
475:         THIS.Release()
476:     ENDPROC
477: 
478:     PROCEDURE BtnEncerrarClick()
479:         THIS.Release()
480:     ENDPROC
481: 
482:     *--------------------------------------------------------------------------
483:     * BtnSalvarClick / BtnCancelarClick
484:     *
485:     * SIGPDMEN nao tem campos editaveis nem botoes Salvar/Cancelar.
486:     * Fechar o dialog e a unica acao valida.
487:     *--------------------------------------------------------------------------
488:     PROCEDURE BtnSalvarClick()
489:         THIS.Release()
490:     ENDPROC
491: 
492:     PROCEDURE BtnCancelarClick()
493:         THIS.Release()
494:     ENDPROC
495: 
496:     *--------------------------------------------------------------------------
497:     * CarregarLista - Recarrega mensagem do banco e atualiza exibicao
498:     *--------------------------------------------------------------------------
499:     PROCEDURE CarregarLista()
500:         IF TYPE("gb_4c_ValidandoUI") == "L" AND gb_4c_ValidandoUI
501:             RETURN .T.
502:         ENDIF
503:         IF !EMPTY(THIS.this_cCidChave) AND VARTYPE(THIS.this_oBusinessObject) = "O"
504:             THIS.CarregarMensagem()
505:         ENDIF
506:         RETURN .T.
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * FormParaBO - SIGPDMEN e somente-leitura; CidChave ja esta no BO via Init
511:     *--------------------------------------------------------------------------
512:     PROTECTED PROCEDURE FormParaBO()
513:         RETURN .T.
514:     ENDPROC
515: 
516:     *--------------------------------------------------------------------------
517:     * BOParaForm - Atualiza exibicao a partir do BO carregado
518:     *--------------------------------------------------------------------------
519:     PROTECTED PROCEDURE BOParaForm()
520:         THIS.CarregarMensagem()
521:         RETURN .T.
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * HabilitarCampos - Dialog somente-leitura; nenhum campo e editavel
526:     *--------------------------------------------------------------------------
527:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
528:         LOCAL loc_lHabilitar
529:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
530:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
531:             THIS.cmd_4c_Ok.Enabled = loc_lHabilitar
532:         ENDIF
533:     ENDPROC
534: 
535:     *--------------------------------------------------------------------------
536:     * LimparCampos - Limpa exibicao do painel de mensagem
537:     *--------------------------------------------------------------------------
538:     PROTECTED PROCEDURE LimparCampos()
539:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
540:             IF PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Gettexto", 5)
541:                 THIS.cnt_4c_Container1.lbl_4c_Gettexto.Caption = ""
542:             ENDIF
543:             IF PEMSTATUS(THIS.cnt_4c_Container1, "obj_4c_GetMemo", 5)
544:                 THIS.cnt_4c_Container1.obj_4c_GetMemo.Value = ""
545:             ENDIF
546:         ENDIF
547:     ENDPROC
548: 
549:     *--------------------------------------------------------------------------
550:     * AjustarBotoesPorModo - Dialog sem botoes CRUD; nada a ajustar
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE AjustarBotoesPorModo()
553:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
554:             THIS.cmd_4c_Ok.Visible = .T.
555:             THIS.cmd_4c_Ok.Enabled = .T.
556:         ENDIF
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     PROCEDURE Destroy()
561:     *--------------------------------------------------------------------------
562:         TRY
563:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
564:                 THIS.this_oBusinessObject = .NULL.
565:             ENDIF
566:         CATCH TO loc_oErro
567:             MsgErro(loc_oErro.Message, "Erro")
568:         ENDTRY
569:         DODEFAULT()
570:     ENDPROC
571: 
572: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdMenBO.prg):
*==============================================================================
* SigPdMenBO.prg - Business Object para Mensagens de Produto
* Tabela: SigCdMsg
* Chave: cidchaves
*==============================================================================

DEFINE CLASS SigPdMenBO AS BusinessBase

    *-- Campos de SigCdMsg
    this_cCidChave  = ""
    this_nCors      = 0
    this_cCpros     = ""
    this_cEmpcpros  = ""
    this_cEmps      = ""
    this_cEstilos   = ""
    this_cFontes    = ""
    this_cLinha1s   = ""
    this_cLinha2s   = ""
    this_nTamanhos  = 0
    this_cCgrus     = ""
    this_cMercs     = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        this_cTabela     = "SigCdMsg"
        this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMensagem - Carrega dados de SigCdMsg pelo cidchave
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMensagem(par_cCidChave)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs " + ;
                       "FROM SigCdMsg " + ;
                       "WHERE estilos = " + EscaparSQL(par_cCidChave)

            IF USED("cursor_4c_SigPdMenMsg")
                TABLEREVERT(.T., "cursor_4c_SigPdMenMsg")
                USE IN cursor_4c_SigPdMenMsg
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigPdMenMsg") > 0
                IF !EOF("cursor_4c_SigPdMenMsg")
                    SELECT cursor_4c_SigPdMenMsg
                    THIS.this_cCidChave  = ALLTRIM(NVL(cidchaves, ""))
                    THIS.this_nCors      = NVL(cors, 0)
                    THIS.this_cCpros     = ALLTRIM(NVL(cpros, ""))
                    THIS.this_cEmpcpros  = ALLTRIM(NVL(empcpros, ""))
                    THIS.this_cEmps      = ALLTRIM(NVL(emps, ""))
                    THIS.this_cEstilos   = ALLTRIM(NVL(estilos, ""))
                    THIS.this_cFontes    = ALLTRIM(NVL(fontes, ""))
                    THIS.this_cLinha1s   = ALLTRIM(NVL(linha1s, ""))
                    THIS.this_cLinha2s   = ALLTRIM(NVL(linha2s, ""))
                    THIS.this_nTamanhos  = NVL(tamanhos, 9)
                    THIS.this_cCgrus     = ALLTRIM(NVL(cgrus, ""))
                    THIS.this_cMercs     = ALLTRIM(NVL(mercs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao buscar mensagem do produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChave  = ALLTRIM(TratarNulo(cidchaves, "C"))
            THIS.this_nCors      = TratarNulo(cors, "N")
            THIS.this_cCpros     = ALLTRIM(TratarNulo(cpros, "C"))
            THIS.this_cEmpcpros  = ALLTRIM(TratarNulo(empcpros, "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps, "C"))
            THIS.this_cEstilos   = ALLTRIM(TratarNulo(estilos, "C"))
            THIS.this_cFontes    = ALLTRIM(TratarNulo(fontes, "C"))
            THIS.this_cLinha1s   = ALLTRIM(TratarNulo(linha1s, "C"))
            THIS.this_cLinha2s   = ALLTRIM(TratarNulo(linha2s, "C"))
            THIS.this_nTamanhos  = TratarNulo(tamanhos, "N")
            THIS.this_cCgrus     = ALLTRIM(TratarNulo(cgrus, "C"))
            THIS.this_cMercs     = ALLTRIM(TratarNulo(mercs, "C"))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF EMPTY(ALLTRIM(THIS.this_cCidChave))
            MsgAviso("Chave da mensagem " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("C" + CHR(243) + "digo da empresa " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Valida" + CHR(231) + CHR(227) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdMsg " + ;
                       "(cidchaves, cors, cpros, empcpros, emps, " + ;
                       "estilos, fontes, linha1s, linha2s, tamanhos, cgrus, mercs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChave) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       EscaparSQL(THIS.this_cFontes) + ", " + ;
                       EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       EscaparSQL(THIS.this_cMercs) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMsg SET " + ;
                       "cors = " + FormatarNumeroSQL(THIS.this_nCors) + ", " + ;
                       "cpros = " + EscaparSQL(THIS.this_cCpros) + ", " + ;
                       "empcpros = " + EscaparSQL(THIS.this_cEmpcpros) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "estilos = " + EscaparSQL(THIS.this_cEstilos) + ", " + ;
                       "fontes = " + EscaparSQL(THIS.this_cFontes) + ", " + ;
                       "linha1s = " + EscaparSQL(THIS.this_cLinha1s) + ", " + ;
                       "linha2s = " + EscaparSQL(THIS.this_cLinha2s) + ", " + ;
                       "tamanhos = " + FormatarNumeroSQL(THIS.this_nTamanhos) + ", " + ;
                       "cgrus = " + EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       "mercs = " + EscaparSQL(THIS.this_cMercs) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdMsg " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir mensagem de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

