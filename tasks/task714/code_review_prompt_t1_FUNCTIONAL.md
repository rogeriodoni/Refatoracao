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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCrp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (962 linhas total):

*-- Linhas 27 a 103:
27: *   2) Lookups: NAO HA NENHUM NO LEGADO - e por isso nenhum foi criado.
28: *      Medido no dump (tasks\task714\SigOpCrp_form_codigo_fonte.txt): zero
29: *      ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt, de mAddColuna, de
30: *      sigacess( e das funcoes Acesso*( ; e zero PROCEDURE KeyPress, zero
31: *      F4/F5. Os tres Valid do legado NAO sao lookup: nenhum deles consulta
32: *      tabela - cada um so zera os OUTROS dois criterios de pesquisa (e o
33: *      Continuar), que e' validacao de exclusao mutua. Inventar
34: *      FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra explicita "NUNCA
35: *      inventar tabelas de lookup que nao existem no original"; e metodo
36: *      AbrirLookup* vazio e' proibido pela regra de completude.
37: *
38: *   3) O que a fase DE FATO entrega: o Valid dos 3 campos digitaveis, agora
39: *      com o nome canonico Validar<Campo> (antes Txt<Campo>LostFocus, que e'
40: *      a assinatura de defeito da regra #47) - ver o cabecalho do bloco
41: *      ValidarLancamento / ValidarValor / ValidarHistorico.
42: *
43: *   Tambem NAO ha container cnt_4c_BotoesAcao (Salvar/Cancelar): isto nao e'
44: *   um CRUD. O legado tem UM CommandGroup de 2 botoes - Procurar e Encerrar -
45: *   ja entregue na Fase 4, e nao grava nada (so faz LOCATE/CONTINUE no cursor
46: *   do form pai).
47: *
48: * FASE 7/8 - "Eventos principais dos botoes" (BtnIncluirClick/BtnAlterarClick/
49: * BtnVisualizarClick/BtnExcluirClick). O template generico pressupoe a barra
50: * CRUD do frmcadastro (Incluir/Alterar/Visualizar/Excluir/Buscar), que este
51: * dialogo NAO TEM - medido no dump (SigOpCrp_form_codigo_fonte.txt): o UNICO
52: * agrupador de botoes e' Commandgroup1, ButtonCount=2, com os metodos
53: * btnOK.Click (buscar/continuar no cursor do pai) e btnSair.Click
54: * (ThisForm.Release); zero ocorrencia de Incluir/Alterar/Visualizar/Excluir em
55: * qualquer metodo deste dump. Criar os 4 handlers do template seria inventar
56: * funcionalidade que o legado nunca teve - exatamente a violacao que a regra
57: * "NUNCA inventar" e o PILAR 1 proibem (mesma familia de falso-positivo do
58: * precedente task699/SIGOPCHP: dialogo filho, OPERACIONAL, sem barra CRUD).
59: *
60: * Os "eventos principais dos botoes" DESTE form sao BtnProcurarClick e
61: * BtnEncerrarClick - a totalidade dos Click do Commandgroup1 legado - e os
62: * dois ja estao implementados abaixo desde a Fase 4 (criacao do
63: * CommandGroup, BINDEVENT e corpo completo). Nao ha codigo novo para esta
64: * fase.
65: *
66: * NOTA SOBRE O TEMPLATE GENERICO DE FASE 4 ("Grid + 6 botoes CRUD em Page1"):
67: * NAO SE APLICA a este form. O dump (SigOpCrp_form_codigo_fonte.txt) e o
68: * layout.json/analise.json de task714 confirmam: BorderStyle=2/TitleBar=0/
69: * WindowType=1 (dialogo modal), SEM PageFrame (nenhuma Page1/Page2), SEM Grid,
70: * SEM AddCursor/pColuna - "temGrid": false em analise.json. O legado tem
71: * exatamente 3 campos de pesquisa e 1 CommandGroup de 2 botoes (Procurar /
72: * Encerrar), todos direto no Form. Inventar Grid+6 botoes CRUD violaria o
73: * PILAR 1 (UI que o legado nao tem) e a regra "NUNCA inventar" - mesma familia
74: * de falso-positivo documentada para forms DESPACHANTE/CAPTURA sem superficie
75: * de lista (precedente: task699/SIGOPCHP, perfil CAPTURA). Como os campos e os
76: * botoes sao a UNICA superficie real deste dialogo (nao ha Page separada para
77: * "grid" versus "campos"), a Fase 4 entrega aqui o conteudo completo: campos +
78: * botoes + eventos - nao apenas os botoes isolados.
79: *
80: *------------------------------------------------------------------------------
81: * NAO E UM CRUD - e um dialogo FILHO, modal, sem barra de titulo, aberto pelo
82: * extrato de Conta Corrente Individual (Formsigopind) no clique do botao
83: * "Procura":
84: *
85: *     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
86: *
87: * Por isso este form:
88: *   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 520x200, igual
89: *     ao SCX legado);
90: *   - recebe DOIS parametros no Init - o DataSessionId do form pai (legado:
91: *     "Arquivos") e o OBJETO do form pai (legado: "pFormPai") - guardados em
92: *     this_nDataSessionPai/this_oFormPai porque o BO usa o primeiro para
93: *     SET DATASESSION TO antes de tocar no cursor CrSigMvCcr do pai (ver
94: *     SigOpCrpBO.prg), e o Form usa o segundo so para se posicionar do lado
95: *     do pai (legado: ThisForm.Top/Left a partir de ThisForm.FormPai).
96: *
97: * O cabecalho (cntSombra/lblSombra/lblTitulo do legado) e o MESMO componente
98: * visual usado nos cadastros CRUD (framework.vcx), so que aqui aparece direto
99: * no Form (sem Page), porque este dialogo nao tem PageFrame. Nomes dos objetos
100: * fixados em tasks\task714\mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
101: * lbl_4c_LblTitulo.
102: *
103: *==============================================================================

*-- Linhas 215 a 357:
215:     * Guardar os dois ANTES de DODEFAULT(): FormBase.Init() chama
216:     * ja preenchidos (um para instanciar o BO, outro para posicionar o form).
217:     *==========================================================================
218:     PROCEDURE Init(par_nDataSessionPai, par_oFormPai)
219:         IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
220:             THIS.this_nDataSessionPai = par_nDataSessionPai
221:         ENDIF
222: 
223:         IF VARTYPE(par_oFormPai) = "O"
224:             THIS.this_oFormPai = par_oFormPai
225:         ENDIF
226: 
227:         RETURN DODEFAULT()
228:     ENDPROC
229: 
230:     *==========================================================================
231:     * InicializarForm - Hook de FormBase.Init(). Cria o BO, posiciona o
232:     * dialogo ao lado do form pai e monta o cabecalho.
233:     *
234:     * O BO (SigOpCrpBO) nao faz nenhum acesso a servidor no proprio Init (ver
235:     * nota de arquitetura no cabecalho de SigOpCrpBO.prg) - por isso a
236:     * instanciacao roda sempre, inclusive em gb_4c_ValidandoUI, sem o guard
237:     * que outros forms usam para pular CarregarLista().
238:     *==========================================================================
239:     PROTECTED PROCEDURE InicializarForm()
240:         LOCAL loc_lSucesso, loc_oErro
241:         loc_lSucesso = .T.
242: 
243:         TRY
244:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrpBO", THIS.this_nDataSessionPai)
245:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
246:                 MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpCrpBO.", "Erro")
247:                 loc_lSucesso = .F.
248:             ENDIF
249: 
250:             *-- FASE 8: o resto so corre com o BO VIVO. Antes, a falha do
251:             *-- CREATEOBJECT apenas marcava o flag e a execucao seguia; agora
252:             *-- LimparCampos/BOParaForm tocam o BO, e sem este IF o usuario
253:             *-- levaria DOIS dialogos de erro - o real e um "Property is not
254:             *-- found" derivado dele, que esconde a causa.
255:             IF loc_lSucesso
256:                 THIS.PosicionarJuntoAoFormPai()
257: 
258:                 THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
259: 
260:                 THIS.ConfigurarCabecalho()
261: 
262:                 THIS.ConfigurarControlesPesquisa()
263: 
264:                 *-- Os defaults do Init legado (Ctod('  /  /  ') / 0.00 / '')
265:                 *-- passam pelo funil unico, para tela e BO nascerem com o
266:                 *-- MESMO estado. Os valores dos WITH de AddObject ficam porque
267:                 *-- sao o que FIXA o TIPO de cada .Value (ver cabecalho).
268:                 THIS.LimparCampos()
269: 
270:                 THIS.TornarControlesVisiveis(THIS)
271:             ENDIF
272:         CATCH TO loc_oErro
273:             loc_lSucesso = .F.
274:             THIS.this_cMensagemErro = loc_oErro.Message
275:             MsgErro(loc_oErro.Message + CHR(13) + ;
276:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
277:                 "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
278:         ENDTRY
279: 
280:         RETURN loc_lSucesso
281:     ENDPROC
282: 
283:     *==========================================================================
284:     * PosicionarJuntoAoFormPai - Transcricao do bloco de posicionamento do
285:     * Init legado:
286:     *
287:     *     ThisForm.Top  = ThisForm.FormPai.Top
288:     *     ThisForm.Left = (ThisForm.FormPai.Left + ThisForm.FormPai.Width) - ThisForm.Width
289:     *
290:     * isto eh, o dialogo nasce encostado na borda DIREITA do form pai, na
291:     * mesma altura do topo dele. Sem this_oFormPai (form aberto fora do fluxo
292:     * do extrato, ex.: teste isolado), AutoCenter continua .F. e o form fica
293:     * na posicao default do VFP9 - nao ha pai para copiar Top/Left.
294:     *==========================================================================
295:     PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
296:         IF VARTYPE(THIS.this_oFormPai) = "O"
297:             THIS.Top  = THIS.this_oFormPai.Top
298:             THIS.Left = (THIS.this_oFormPai.Left + THIS.this_oFormPai.Width) - THIS.Width
299:         ENDIF
300:     ENDPROC
301: 
302:     *==========================================================================
303:     * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
304:     *
305:     * Mesmo componente visual do cabecalho canonico dos cadastros CRUD
306:     * (framework.vcx: cntSombra/lblSombra/lblTitulo), so que direto no Form -
307:     * este dialogo nao tem PageFrame/Page para hospeda-lo. Nomes fixados em
308:     * tasks\task714\mapeamento.json (cnt_4c_Sombra, nao cnt_4c_Cabecalho).
309:     *
310:     * Width da faixa e dos dois labels usa THIS.Width (520) em vez do 800/769
311:     * literal do dump: aqueles numeros sao o default da CLASSE do framework
312:     * (dimensionada para o form 800px dos cadastros) e nunca foram
313:     * sobrescritos neste SCX de 520px - copiar ao pe da letra faria a faixa
314:     * estourar a borda do dialogo. Top/Left/Height/FontName/FontSize/
315:     * ForeColor sao TODOS transcritos do dump (regra #23: nada inventado).
316:     *==========================================================================
317:     PROTECTED PROCEDURE ConfigurarCabecalho()
318:         THIS.AddObject("cnt_4c_Sombra", "Container")
319:         WITH THIS.cnt_4c_Sombra
320:             .Top         = 0
321:             .Left        = 0
322:             .Width       = THIS.Width
323:             .Height      = 80
324:             .BorderWidth = 0
325:             .BackColor   = RGB(100, 100, 100)
326:             .Visible     = .T.
327:         ENDWITH
328: 
329:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
330:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
331:             .Top          = 18
332:             .Left         = 10
333:             .Width        = THIS.Width - 31
334:             .Height       = 40
335:             .FontName     = "Tahoma"
336:             .FontSize     = 18
337:             .FontBold     = .T.
338:             .FontUnderline = .F.
339:             .WordWrap     = .T.
340:             .Alignment    = 0
341:             .BackStyle    = 0
342:             .ForeColor    = RGB(0, 0, 0)
343:             .Caption      = THIS.Caption
344:             .Visible      = .T.
345:         ENDWITH
346: 
347:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
348:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
349:             .Top       = 17
350:             .Left      = 10
351:             .Width     = THIS.Width - 31
352:             .Height    = 46
353:             .FontName  = "Tahoma"
354:             .FontSize  = 18
355:             .FontBold  = .T.
356:             .WordWrap  = .T.
357:             .Alignment = 0

*-- Linhas 441 a 962:
441:     *     dialogo nunca desabilita campo (nao ha Enabled = .F. em lugar
442:     *     nenhum do SCX nem do migrado).
443:     *==========================================================================
444:     PROTECTED PROCEDURE ConfigurarControlesPesquisa()
445:         *----------------------------------------------------------------------
446:         * lbl_4c_Label1 "Data :" + txt_4c_Lancamento
447:         *----------------------------------------------------------------------
448:         THIS.AddObject("lbl_4c_Label1", "Label")
449:         WITH THIS.lbl_4c_Label1
450:             .Left      = 120
451:             .Top       = 116
452:             .Width     = 150
453:             .Height    = 18
454:             .Alignment = 0
455:             .BackStyle = 0
456:             .FontName  = "Tahoma"
457:             .FontSize  = 8
458:             .ForeColor = RGB(90, 90, 90)
459:             .Caption   = "Data :"
460:             .Visible   = .T.
461:         ENDWITH
462: 
463:         THIS.AddObject("txt_4c_Lancamento", "TextBox")
464:         WITH THIS.txt_4c_Lancamento
465:             .Left          = 154          && dump getLancamento.Left
466:             .Top           = 113          && dump getLancamento.Top
467:             .Width         = 80           && classe fweditdata (dump nao declara)
468:             .Height        = 23           && classe fweditdata (dump nao declara)
469:             .FontName      = "Tahoma"     && classe fweditdata
470:             .FontSize      = 8            && classe fweditdata
471:             .Alignment     = 3            && classe fweditdata
472:             .Themes        = .F.          && classe fweditdata - sem isto SpecialEffect/BorderColor sao inertes
473:             .SpecialEffect = 1            && dump getLancamento.SpecialEffect
474:             .ForeColor     = RGB(0, 0, 0) && dump getLancamento.ForeColor
475:             .BorderColor   = RGB(100, 100, 100)   && dump getLancamento.BorderColor
476:             .Value         = {}           && legado Init: Ctod('  /  /  ')
477:             .Visible       = .T.
478:         ENDWITH
479:         BINDEVENT(THIS.txt_4c_Lancamento, "GotFocus", THIS, "TxtLancamentoGotFocus")
480:         BINDEVENT(THIS.txt_4c_Lancamento, "LostFocus", THIS, "ValidarLancamento")
481: 
482:         *----------------------------------------------------------------------
483:         * lbl_4c_Label2 "Valor :" + txt_4c_Valor
484:         *----------------------------------------------------------------------
485:         THIS.AddObject("lbl_4c_Label2", "Label")
486:         WITH THIS.lbl_4c_Label2
487:             .Left      = 303
488:             .Top       = 116
489:             .Width     = 150
490:             .Height    = 18
491:             .Alignment = 0
492:             .BackStyle = 0
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .ForeColor = RGB(90, 90, 90)
496:             .Caption   = "Valor :"
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         THIS.AddObject("txt_4c_Valor", "TextBox")
501:         WITH THIS.txt_4c_Valor
502:             .Left          = 338          && dump getValor.Left
503:             .Top           = 113          && dump getValor.Top
504:             .Width         = 80           && dump getValor.Width
505:             .Height        = 23           && dump getValor.Height (= classe fwget)
506:             .FontName      = "Tahoma"     && classe fwget
507:             .FontSize      = 8            && classe fwget
508:             .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
509:             .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
510:             .SpecialEffect = 1            && dump getValor.SpecialEffect
511:             .ForeColor     = RGB(0, 0, 0) && dump getValor.ForeColor
512:             .BorderColor   = RGB(100, 100, 100)   && dump getValor.BorderColor
513:             .Value         = 0.00         && legado Init: getValor.Value = 0.00
514:             .Visible       = .T.
515:         ENDWITH
516:         BINDEVENT(THIS.txt_4c_Valor, "GotFocus", THIS, "TxtValorGotFocus")
517:         BINDEVENT(THIS.txt_4c_Valor, "LostFocus", THIS, "ValidarValor")
518: 
519:         *----------------------------------------------------------------------
520:         * lbl_4c_Label3 "Historico :" + txt_4c_Historico
521:         *----------------------------------------------------------------------
522:         THIS.AddObject("lbl_4c_Label3", "Label")
523:         WITH THIS.lbl_4c_Label3
524:             .Left      = 102
525:             .Top       = 140
526:             .Width     = 150
527:             .Height    = 18
528:             .Alignment = 0
529:             .BackStyle = 0
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .ForeColor = RGB(90, 90, 90)
533:             .Caption   = "Hist" + CHR(243) + "rico :"
534:             .Visible   = .T.
535:         ENDWITH
536: 
537:         THIS.AddObject("txt_4c_Historico", "TextBox")
538:         WITH THIS.txt_4c_Historico
539:             .Left          = 154          && dump getHistorico.Left
540:             .Top           = 137          && dump getHistorico.Top
541:             .Width         = 264          && dump getHistorico.Width
542:             .Height        = 23           && classe fwget (dump nao declara)
543:             .FontName      = "Tahoma"     && classe fwget
544:             .FontSize      = 8            && classe fwget
545:             .Format        = "K"          && classe fwget - seleciona o conteudo ao entrar
546:             .Themes        = .F.          && classe fwget - sem isto SpecialEffect/BorderColor sao inertes
547:             .SpecialEffect = 1            && dump getHistorico.SpecialEffect
548:             .ForeColor     = RGB(0, 0, 0) && dump getHistorico.ForeColor
549:             .BorderColor   = RGB(100, 100, 100)   && dump getHistorico.BorderColor
550:             .Value         = ""           && legado Init: getHistorico.Value = ''
551:             .Visible       = .T.
552:         ENDWITH
553:         BINDEVENT(THIS.txt_4c_Historico, "GotFocus", THIS, "TxtHistoricoGotFocus")
554:         BINDEVENT(THIS.txt_4c_Historico, "LostFocus", THIS, "ValidarHistorico")
555: 
556:         *----------------------------------------------------------------------
557:         * obj_4c_Commandgroup1 - Procurar (Buttons(1)) / Encerrar (Buttons(2))
558:         * ButtonCount DEVE ser setado ANTES de qualquer Buttons(N) (senao
559:         * "BUTTONS is not an object").
560:         *----------------------------------------------------------------------
561:         THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
562:         WITH THIS.obj_4c_Commandgroup1
563:             .ButtonCount   = 2
564:             .AutoSize      = .T.
565:             .BackStyle     = 0
566:             .BorderStyle   = 0
567:             .SpecialEffect = 1
568:             .BorderColor   = RGB(136, 189, 188)
569:             .Value         = 1
570:             .Top           = -2
571:             .Left          = 365
572:             .Width         = 160
573:             .Height        = 85
574:             .Themes        = .F.
575:             .Visible       = .T.
576:         ENDWITH
577:         *-- NAO atribuir .TabIndex aqui: o grupo e' o ULTIMO AddObject, e
578:         *-- atribuir no meio da criacao o puxa para a frente dos campos.
579:         *-- A ordem de tabulacao inteira vai em AplicarOrdemTabulacao(),
580:         *-- chamado depois de TODOS os AddObject.
581: 
582:         WITH THIS.obj_4c_Commandgroup1.Buttons(1)
583:             .Top             = 5
584:             .Left            = 5
585:             .Width           = 75
586:             .Height          = 75
587:             .FontName        = "Comic Sans MS"
588:             .FontSize        = 8
589:             .FontBold        = .T.
590:             .FontItalic      = .T.
591:             .WordWrap        = .T.
592:             .AutoSize        = .F.
593:             .ForeColor       = RGB(90, 90, 90)
594:             .BackColor       = RGB(255, 255, 255)
595:             .Themes          = .F.
596:             .MousePointer    = 15
597:             .PicturePosition = 13
598:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
599:             .Caption         = "\<Procurar"
600:         ENDWITH
601:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnProcurarClick")
602: 
603:         WITH THIS.obj_4c_Commandgroup1.Buttons(2)
604:             .Top             = 5
605:             .Left            = 80
606:             .Width           = 75
607:             .Height          = 75
608:             .FontName        = "Comic Sans MS"
609:             .FontSize        = 8
610:             .FontBold        = .T.
611:             .FontItalic      = .T.
612:             .WordWrap        = .T.
613:             .AutoSize        = .F.
614:             .ForeColor       = RGB(90, 90, 90)
615:             .BackColor       = RGB(255, 255, 255)
616:             .Themes          = .F.
617:             .MousePointer    = 15
618:             .PicturePosition = 13
619:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
620:             .Cancel          = .T.
621:             .Caption         = "Encerrar"
622:         ENDWITH
623:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnEncerrarClick")
624: 
625:         THIS.AplicarOrdemTabulacao()
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * AplicarOrdemTabulacao - ordem de tabulacao do legado
630:     *
631:     * O TabIndex nao pode ser atribuido dentro do WITH de cada AddObject: o
632:     * VFP aplica o valor no instante da criacao e CLAMPA ao numero de objetos
633:     * que existem ali, entao o grupo de botoes (ultimo AddObject) com
634:     * .TabIndex = 4 era puxado para a 4a posicao e o Tab saltava de "Data"
635:     * direto para os botoes, pulando Valor e Historico. Medido no VFP9 em
636:     * 2026-10-30: TabIndex efetivo era Lancamento=3, Commandgroup1=4,
637:     * Valor=6, Historico=8.
638:     *
639:     * O valor LITERAL do dump tambem nao serve como alvo - no legado ele
640:     * sofre o MESMO clamp. Simulando o load do SCX (recriando os filhos na
641:     * ordem dos REGISTROS e aplicando o valor logo apos cada AddObject),
642:     * a ordem EFETIVA do legado lida de volta foi:
643:     *
644:     *     getLancamento=1  getValor=2  getHistorico=3
645:     *     cntSombra=4      Commandgroup1=5   Say1=6  Say2=7  Say3=8
646:     *
647:     * isto eh, entre os FOCALIZAVEIS: Lancamento -> Valor -> Historico ->
648:     * Commandgroup1 (os botoes vem por ULTIMO, nao em 4o). O SCX declara
649:     * Commandgroup1.TabIndex = 4, mas esse 4 e' inalcancavel por construcao
650:     * (o grupo e' o 2o registro criado) - transcrever o literal seria FIEL AO
651:     * ARQUIVO e INFIEL A TELA.
652:     *
653:     * Numerar so os FOCALIZAVEIS: Label nao tem TabStop (medido: a property
654:     * nem existe), entao transcrever o TabIndex dos tres Say e' inerte e
655:     * ainda embaralha a sequencia de quem realmente para o Tab.
656:     *
657:     * Atribuicao em ordem ASCENDENTE e depois de todos os AddObject - cada
658:     * atribuicao poe o controle na posicao pedida e empurra os demais para
659:     * tras. Com a ordem de criacao deste form a sequencia ja sai correta, ou
660:     * seja na pratica isto e' um no-op; fica como documentacao e como guarda
661:     * caso alguem reordene os AddObject.
662:     *==========================================================================
663:     PROCEDURE AplicarOrdemTabulacao()
664:         THIS.txt_4c_Lancamento.TabIndex    = 1    && SCX getLancamento TabIndex = 1
665:         THIS.txt_4c_Valor.TabIndex         = 2    && SCX getValor      TabIndex = 2
666:         THIS.txt_4c_Historico.TabIndex     = 3    && SCX getHistorico  TabIndex = 3
667:         THIS.obj_4c_Commandgroup1.TabIndex = 4    && SCX declara 4; efetivo = depois dos 3 campos
668:     ENDPROC
669: 
670:     *==========================================================================
671:     * TxtLancamentoGotFocus / TxtValorGotFocus / TxtHistoricoGotFocus
672:     *
673:     * Transcricao do GotFocus dos 3 campos legado (This.Tag = <valor de
674:     * entrada>). O estado fica no BO (AtualizarTag*), nao no .Tag do TextBox -
675:     * so existe para o par Valid/LostFocus seguinte comparar entrada x saida.
676:     *==========================================================================
677:     PROCEDURE TxtLancamentoGotFocus()
678:         THIS.this_oBusinessObject.AtualizarTagDatas(THIS.txt_4c_Lancamento.Value)
679:     ENDPROC
680: 
681:     PROCEDURE TxtValorGotFocus()
682:         THIS.this_oBusinessObject.AtualizarTagValors(THIS.txt_4c_Valor.Value)
683:     ENDPROC
684: 
685:     PROCEDURE TxtHistoricoGotFocus()
686:         THIS.this_oBusinessObject.AtualizarTagHistorico(THIS.txt_4c_Historico.Value)
687:     ENDPROC
688: 
689:     *==========================================================================
690:     * ValidarLancamento / ValidarValor / ValidarHistorico
691:     *
692:     * FASE 6 - estes TRES metodos sao a entrega da fase: o Valid de cada campo
693:     * DIGITAVEL do legado. Os 3 campos deste dialogo aceitam digitacao
694:     * (nenhum tem ReadOnly nem When -> .f. no dump) e cada um tem um Valid de
695:     * verdade, entao reproduzi-los e' trabalho DESTA fase, nao da 7/8.
696:     *
697:     * Transcricao do Valid dos 3 campos legado - ligados a "LostFocus" porque
698:     * BINDEVENT "Valid" nao funciona de forma confiavel em TextBox (regra
699:     * critica #2 do CLAUDE.md). LostFocus cobre as tres saidas de campo que
700:     * disparam o Valid legado (Enter, Tab e clique fora) e NAO passa
701:     * parametro, por isso a assinatura e' vazia - handler sem parametro
702:     * ligado a "KeyPress" estouraria a cada tecla (regra #3).
703:     *
704:     * NOME: Validar<Campo> e' o nome canonico do projeto para o handler que
705:     * reproduz o Valid de um campo. O nome anterior (Txt<Campo>LostFocus) era
706:     * justamente a assinatura que a regra #47 marca como defeito - ela proibe
707:     * handler batizado <X>LostFocus porque, no acervo, esse nome aparece
708:     * ligado a "KeyPress" (picker abrindo a cada tecla). Aqui o binding sempre
709:     * esteve correto; o que estava fora da convencao era o nome. Os handlers
710:     * de GotFocus acima NAO entram nesse renome: eles nao validam nada -
711:     * capturam o valor de ENTRADA (a metade Tag do par) - e o nome deles casa
712:     * com o evento a que estao ligados.
713:     *
714:     * SEM GUARDA DE REENTRANCIA, de proposito: o corpo so escreve .Value nos
715:     * outros dois TextBox, e escrever .Value nao move o foco - nada redispara
716:     * o proprio LostFocus. A guarda das regras #37/#47 existe para handler que
717:     * abre form MODAL (picker); aqui nao ha picker nenhum.
718:     *
719:     * O ValidarCriterio* do BO compara entrada x saida e, mudando, ja zera as
720:     * OUTRAS duas properties de criterio - fonte unica da regra (PILAR 3),
721:     * inclusive da assimetria do legado: o Valid de Data NAO limpa
722:     * ThisForm.Continuar, os de Valor e Historico limpam. Aqui so falta
723:     * espelhar esse zeramento nos TextBox visiveis - exatamente o que o legado
724:     * faz com ThisForm.get*.Value = Ctod('  /  /  ') / 0.00 / ''.
725:     *==========================================================================
726:     PROCEDURE ValidarLancamento()
727:         IF THIS.this_oBusinessObject.ValidarCriterioDatas(THIS.txt_4c_Lancamento.Value)
728:             THIS.BOParaForm()
729:         ENDIF
730:     ENDPROC
731: 
732:     PROCEDURE ValidarValor()
733:         IF THIS.this_oBusinessObject.ValidarCriterioValors(THIS.txt_4c_Valor.Value)
734:             THIS.BOParaForm()
735:         ENDIF
736:     ENDPROC
737: 
738:     PROCEDURE ValidarHistorico()
739:         IF THIS.this_oBusinessObject.ValidarCriterioHistorico(THIS.txt_4c_Historico.Value)
740:             THIS.BOParaForm()
741:         ENDIF
742:     ENDPROC
743: 
744:     *==========================================================================
745:     * FormParaBO - FASE 8: tela -> BO (os 3 criterios de pesquisa)
746:     *
747:     * Legado: o btnOK.Click le ThisForm.get<Campo>.Value DIRETO, dentro do
748:     * proprio Do Case. Na arquitetura em camadas quem decide a precedencia dos
749:     * criterios eh o BO (SigOpCrpBO.BuscarRegistro testa this_dDatas /
750:     * this_nValors / this_cHists), entao o Form tem de alimentar as tres
751:     * properties ANTES de chamar a busca - este metodo eh esse unico ponto de
752:     * leitura dos TextBox de criterio.
753:     *
754:     * FUNCTION (nao PROCEDURE) e com retorno conferido pelo chamador: sem o
755:     * retorno, uma falha aqui deixaria o BtnProcurarClick seguir e o LOCATE
756:     * rodaria com os criterios do clique ANTERIOR, movendo o cursor do pai para
757:     * o registro errado sem erro na tela.
758:     *
759:     * Nenhuma conversao de tipo eh necessaria nos tres: os .Value nascem
760:     * Date / Numeric / Character nos WITH de AddObject (ver nota de tipo no
761:     * cabecalho do arquivo) e as properties do BO sao declaradas nos mesmos
762:     * tipos ({} / 0.00 / "") - MEDIDO no VFP9 (automation\probe714.prg):
763:     * VARTYPE devolve D / N / C nos tres controles recem-criados.
764:     *
765:     * PROTECTED explicito, e nao por estilo: FormBase.prg:285 declara
766:     * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR o
767:     * escopo - escrever "FUNCTION FormParaBO" sem o modificador nao torna o
768:     * metodo publico, so ESCONDE que ele continua protegido (regra #51; medido
769:     * no probe: chamar loForm.FormParaBO() de fora estoura Program Error e
770:     * pendura o VFP). Declarar PROTECTED deixa o arquivo dizer a verdade. Os
771:     * tres hooks sao chamados SO por THIS. - BtnProcurarClick, os tres
772:     * Validar<Campo>, LimparCampos e InicializarForm.
773:     *==========================================================================
774:     PROTECTED FUNCTION FormParaBO()
775:         LOCAL loc_lSucesso, loc_oErro
776:         loc_lSucesso = .F.
777: 
778:         TRY
779:             WITH THIS.this_oBusinessObject
780:                 .this_dDatas  = THIS.txt_4c_Lancamento.Value
781:                 .this_nValors = THIS.txt_4c_Valor.Value
782:                 .this_cHists  = THIS.txt_4c_Historico.Value
783:             ENDWITH
784:             loc_lSucesso = .T.
785:         CATCH TO loc_oErro
786:             MsgErro(loc_oErro.Message + CHR(13) + ;
787:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
788:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
789:         ENDTRY
790: 
791:         RETURN loc_lSucesso
792:     ENDFUNC
793: 
794:     *==========================================================================
795:     * BOParaForm - FASE 8: BO -> tela (os 3 criterios de pesquisa)
796:     *
797:     * Sentido inverso do FormParaBO, e o unico ponto que ESCREVE nos TextBox de
798:     * criterio. Chamado de dois lugares:
799:     *
800:     *   1) os tres Validar<Campo>, quando o ValidarCriterio* do BO confirma que
801:     *      o campo mudou e portanto ja zerou os outros dois criterios - o
802:     *      legado espelha isso com ThisForm.get<Outro>.Value = <default>;
803:     *   2) o LimparCampos, depois de zerar as properties.
804:     *
805:     * Espelha os TRES campos, inclusive o que acabou de ser digitado - e eh o
806:     * que permite UM hook em vez das tres copias que havia antes (cada uma
807:     * espelhando um par diferente de campos), que era a forma de as copias
808:     * divergirem em silencio ao acrescentar um quarto criterio.
809:     *
810:     * Espelhar o proprio campo so eh seguro porque o ValidarCriterio* do BO
811:     * GUARDA o valor de saida na property do proprio criterio antes de zerar os
812:     * outros dois. Essa linha foi acrescentada aos tres metodos do BO nesta
813:     * mesma fase, depois de o probe (automation\probe714c.prg) mostrar o
814:     * contrario: sem ela a property ficava com o valor ANTERIOR (ela so era
815:     * alimentada pelo FormParaBO, que roda no Procurar e nao no Valid), e este
816:     * hook devolvia o valor velho ao campo, APAGANDO o que o usuario tinha
817:     * acabado de digitar - ValidarValor com 777 deixava a tela em [ / / |0|],
818:     * que eh o defeito da regra #50. Ao mexer em qualquer um dos dois lados,
819:     * reexecutar aquele probe: o par "BO guarda o proprio criterio" +
820:     * "hook espelha os tres" vale junto ou nenhum dos dois vale.
821:     *==========================================================================
822:     PROTECTED PROCEDURE BOParaForm()
823:         LOCAL loc_oErro
824: 
825:         TRY
826:             WITH THIS.this_oBusinessObject
827:                 THIS.txt_4c_Lancamento.Value = .this_dDatas
828:                 THIS.txt_4c_Valor.Value      = .this_nValors
829:                 THIS.txt_4c_Historico.Value  = .this_cHists
830:             ENDWITH
831:         CATCH TO loc_oErro
832:             MsgErro(loc_oErro.Message + CHR(13) + ;
833:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
834:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
835:         ENDTRY
836:     ENDPROC
837: 
838:     *==========================================================================
839:     * LimparCampos - FASE 8: funil unico dos defaults do Init legado
840:     *
841:     *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
842:     *     ThisForm.getValor.Value      = 0.00
843:     *     ThisForm.getHistorico.Value  = ''
844:     *
845:     * Zera as properties de criterio do BO e refaz a tela pelo BOParaForm, para
846:     * o estado ter UMA fonte (o BO) - sem isso tela e BO poderiam discordar,
847:     * que eh como um criterio "invisivel" sobreviveria a um clique seguinte e
848:     * moveria o cursor do pai para o registro errado.
849:     *
850:     * Zera tambem o this_cContinuar: ele eh o estado de "continuar de onde
851:     * parei" dos criterios Valor e Historico (legado: ThisForm.Continuar), e
852:     * limpar os campos sem limpar o acumulador faria o proximo clique entrar no
853:     * ramo Continue de uma pesquisa que o usuario ja abandonou.
854:     *==========================================================================
855:     PROTECTED PROCEDURE LimparCampos()
856:         WITH THIS.this_oBusinessObject
857:             .this_dDatas     = {}
858:             .this_nValors    = 0.00
859:             .this_cHists     = ""
860:             .this_cContinuar = ""
861:         ENDWITH
862: 
863:         THIS.BOParaForm()
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * BtnProcurarClick - transcricao de SIGOPCRP.Commandgroup1.btnOK.Click
868:     *
869:     * Esta e' a entrega da Fase 7/8 ("eventos principais dos botoes") para
870:     * este form: o legado so tem este Click e o de BtnEncerrarClick abaixo -
871:     * ver nota no cabecalho do arquivo sobre a ausencia de
872:     * Incluir/Alterar/Visualizar/Excluir.
873:     *
874:     * 1) Copia os 3 campos da tela para as properties de criterio do BO
875:     *    (o legado le ThisForm.get*.Value direto dentro do Click - aqui o
876:     *    BO so testa THIS.this_dDatas/this_nValors/this_cHists, entao o
877:     *    form precisa alimenta-las antes de chamar BuscarRegistro).
878:     * 2) BuscarRegistro() faz o LOCATE/CONTINUE no cursor do pai.
879:     * 3) Refresh + SetFocus na grade do pai - INCONDICIONAL, igual ao legado
880:     *    (roda mesmo quando o dialogo vai fechar na sequencia).
881:     * 4) this_lFecharDialogo / this_cCampoFoco decidem Release ou SetFocus
882:     *    local - mesma assimetria do segundo Do Case legado (ver cabecalho
883:     *    de SigOpCrpBO.prg, secao "PRECEDENCIA DOS CRITERIOS").
884:     *==========================================================================
885:     PROCEDURE BtnProcurarClick()
886:         *-- FASE 8: a copia tela -> BO saiu daqui para o hook FormParaBO (fonte
887:         *-- unica). Retorno conferido: falhando a transferencia, o LOCATE
888:         *-- rodaria com os criterios do clique ANTERIOR e moveria o cursor do
889:         *-- pai para o registro errado, sem nada na tela.
890:         IF !THIS.FormParaBO()
891:             RETURN
892:         ENDIF
893: 
894:         THIS.this_oBusinessObject.BuscarRegistro()
895: 
896:         IF VARTYPE(THIS.this_oFormPai) = "O"
897:             IF PEMSTATUS(THIS.this_oFormPai, "pgf_4c_1", 5)
898:                 IF PEMSTATUS(THIS.this_oFormPai.pgf_4c_1.Page2, "grd_4c_Lancamento", 5)
899:                     THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.Refresh()
900:                     THIS.this_oFormPai.pgf_4c_1.Page2.grd_4c_Lancamento.SetFocus()
901:                 ENDIF
902:             ENDIF
903:         ENDIF
904: 
905:         DO CASE
906:             CASE THIS.this_oBusinessObject.this_lFecharDialogo
907:                 THIS.Release()
908:             CASE THIS.this_oBusinessObject.this_cCampoFoco == "VALOR"
909:                 THIS.txt_4c_Valor.SetFocus()
910:             CASE THIS.this_oBusinessObject.this_cCampoFoco == "HISTORICO"
911:                 THIS.txt_4c_Historico.SetFocus()
912:         ENDCASE
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * BtnEncerrarClick - transcricao de SIGOPCRP.Commandgroup1.btnSair.Click
917:     *==========================================================================
918:     PROCEDURE BtnEncerrarClick()
919:         THIS.Release()
920:     ENDPROC
921: 
922:     *==========================================================================
923:     * TornarControlesVisiveis - identico ao padrao dos demais forms (percorre
924:     * Pages de PageFrame e Controls de Container recursivamente). Este form
925:     * nao tem PageFrame nem container flutuante Visible=.F., mas o metodo fica
926:     * generico para as proximas fases (obj_4c_Commandgroup1 e os TextBox de
927:     * campo entram sempre visiveis).
928:     *==========================================================================
929:     PROCEDURE TornarControlesVisiveis(par_oContainer)
930:         LOCAL loc_nI, loc_oObjeto, loc_nP
931: 
932:         FOR loc_nI = 1 TO par_oContainer.ControlCount
933:             loc_oObjeto = par_oContainer.Controls(loc_nI)
934: 
935:             IF VARTYPE(loc_oObjeto) = "O"
936:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
937:                     loc_oObjeto.Visible = .T.
938:                 ENDIF
939: 
940:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
941:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
942:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
943:                     ENDFOR
944:                 ENDIF
945: 
946:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
947:                     THIS.TornarControlesVisiveis(loc_oObjeto)
948:                 ENDIF
949:             ENDIF
950:         ENDFOR
951:     ENDPROC
952: 
953:     *==========================================================================
954:     * Destroy - nenhum cursor local a fechar (CrSigMvCcr pertence ao form pai
955:     * e nao deve ser tocado aqui); DODEFAULT() preserva o fix de menu/popup da
956:     * FormBase (regra #29 / Erro58).
957:     *==========================================================================
958:     PROCEDURE Destroy()
959:         DODEFAULT()
960:     ENDPROC
961: 
962: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCrpBO.prg):
*==============================================================================
* SigOpCrpBO.prg
*
* Business Object para FormSigOpCrp - Procura de Lancamento de Conta Corrente
* Legado: SigOpCrp.SCX (task714)
*
* Cursor pesquisado : CrSigMvCcr (grade de lancamentos do form pai)
* Tabela de origem  : SigMvCcr (chave: cidchaves char(20))
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo, aberto pelo extrato de Conta
* Corrente Individual (SIGOPIND / Formsigopind) no clique do botao "Procura":
*
*     DO FORM SigOpCrp WITH THIS.DataSessionId, THIS
*
* A tela NAO consulta o servidor e NAO grava nada. Ela apenas POSICIONA o
* cursor que o form pai mantem aberto na grade de lancamentos, com LOCATE /
* CONTINUE, por um destes tres criterios:
*
*     Data      -> getLancamento -> CrSigMvCcr.Datas   (D)
*     Valor     -> getValor      -> CrSigMvCcr.Valors  (N(11,2))
*     Historico -> getHistorico  -> CrSigMvCcr.Hists   (C(60))
*
* Por isso o legado comeca com "Set DataSession To Arquivos": o dialogo entra
* na MESMA data session do pai e so assim enxerga CrSigMvCcr. O DataSessionId
* recebido fica guardado em this_nDataSessionPai.
*
*------------------------------------------------------------------------------
* TIPOS DOS CAMPOS - CONFERIDOS NAS DUAS PONTAS
*
* O criterio eh comparado contra o CURSOR, nao contra a tabela, e os dois
* divergem num ponto que importa: na tabela a coluna datas eh datetime, mas
* no cursor que o pai cria (Formsigopind, CREATE CURSOR CrSigMvCcr) a coluna
* Datas eh do tipo D. Conferido em docs/schema.sql (UTF-16, lido com
* Get-Content -Raw, regra #14) e no CREATE CURSOR do form pai:
*
*     coluna      SigMvCcr          CrSigMvCcr       property
*     ----------  ----------------  ---------------  -------------
*     datas       datetime NULL     Datas   D        this_dDatas
*     valors      numeric(11,2)     Valors  N(11,2)  this_nValors
*     hists       char(60) NULL     Hists   C(60)    this_cHists
*
* Dai duas consequencias:
*   - a property de data eh DATE, igual ao Ctod() vazio que o legado atribui
*     ao TextBox, e a montagem da chave passa por ConverterParaData antes do
*     DTOS para nao depender do caminho por onde o valor chegou (regra #16:
*     TTOD estoura erro 11 quando recebe DATE);
*   - o MaxLength do campo Historico eh 60, a largura da COLUNA, e nao a
*     largura em pixels do controle (regra #19).
*
*------------------------------------------------------------------------------
* BUSCA SEQUENCIAL - O QUE this_cContinuar GUARDA
*
* O legado guarda a ultima chave pesquisada na property "continuar" do form e
* usa esse valor para decidir entre RECOMECAR do topo ou CONTINUAR de onde
* parou (transcricao do btnOK.Click):
*
*     Case ThisForm.getValor.Value # 0
*         lcChave = ThisForm.getValor.Value
*         If lcChave = Val(ThisForm.Continuar) .and. !llFinal
*             Continue
*         Else
*             ThisForm.Continuar = Str(lcChave,12,2)
*             Go Top
*             Locate For lcChave = Valors
*         Endif
*
* Ou seja: mesma chave da vez anterior e cursor ainda nao no fim -> CONTINUE
* (proxima ocorrencia); chave nova -> grava a chave, GO TOP e LOCATE. Por isso
* "continuar" eh CARACTERE mesmo no criterio numerico - o legado guarda
* Str(valor,12,2) e compara com Val(). this_cContinuar reproduz isso
* literalmente, inclusive o formato de 12 posicoes com 2 decimais.
*
* llFinal eh medido ANTES da busca e espelhado em this_lFinalArquivo:
*
*     llFinal = Eof()
*     If !llFinal
*         Skip
*         llFinal = Eof()
*         Skip - 1
*     Endif
*
* isto eh, "estou no ultimo registro (ou alem dele)" - o CONTINUE so eh
* permitido quando ainda ha para onde avancar.
*
*------------------------------------------------------------------------------
* PRECEDENCIA DOS CRITERIOS E DESTINO DO FOCO
*
* O Do Case do legado usa UM criterio por vez, nesta ordem: Data, Valor,
* Historico - e os Valid dos tres campos zeram os outros dois, de modo que na
* pratica so um fica preenchido. O MESMO teste decide, no segundo Do Case, o
* que acontece depois da busca:
*
*     criterio    chave          comparacao          depois da busca
*     ----------  -------------  ------------------  --------------------
*     DATA        Dtos(Datas)    igualdade exata     fecha o dialogo
*     VALOR       Valors         igualdade numerica  foco em getValor
*     HISTORICO   Hists          lcChave $ Hists     foco em getHistorico
*     (nenhum)    -              -                   fecha o dialogo
*
* A assimetria eh do legado e eh proposital: a data identifica um lancamento
* (fecha), valor e historico repetem (o dialogo fica aberto para o usuario
* clicar Procurar de novo e cair na ocorrencia seguinte). O criterio escolhido
* fica em this_cTipoBusca e o destino do foco em this_cCampoFoco /
* this_lFecharDialogo.
*
* Atencao ao criterio de HISTORICO: o operador eh "$" (contido em), nao "=".
* Trocar por igualdade restringiria a busca e mudaria o comportamento da tela.
*
*------------------------------------------------------------------------------
* AUSENCIA DE MENSAGEM QUANDO NAO ACHA - EH DO LEGADO
*
* Quando o LOCATE falha, o legado NAO avisa nada: ele apenas da Refresh e
* SetFocus na grade do pai. Nao cabe acrescentar MsgAviso de "nao encontrado"
* nem limpar o criterio digitado - isso impediria o usuario de corrigir o
* valor e repetir a busca (regra #50). O resultado do LOCATE fica apenas em
* this_lAchouRegistro, para o form poder reposicionar a grade.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - BO SOMENTE-LEITURA
*
* O legado nao tem INSERT, UPDATE, DELETE, TABLEUPDATE nem AddCursor: o unico
* efeito da tela eh o PONTEIRO do cursor do pai. Portanto este BO nao
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao() - o comportamento
* padrao herdado de BusinessBase (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja eh o correto, e sobrescrever esses metodos
* exigiria INVENTAR uma lista de colunas, o que a regra #22 proibe.
*
* Pelo mesmo motivo o Init NAO passa o nome da tabela para o DODEFAULT: sem
* nenhuma ida ao servidor nao ha DataAccess a instanciar. this_cTabela e
* this_cCampoChave sao preenchidos direto, como contexto da entidade.
*==============================================================================

DEFINE CLASS SigOpCrpBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CRITERIOS DE BUSCA
    *
    * Uma property por caixa da tela, com a grafia da COLUNA do cursor
    * preservada (inclusive o sufixo "s" do padrao Fortyus - NUNCA "corrigir"
    * para o singular). Os valores iniciais reproduzem o Init do legado:
    *
    *     ThisForm.getLancamento.Value = Ctod('  /  /  ')
    *     ThisForm.getValor.Value      = 0.00
    *     ThisForm.getHistorico.Value  = ''
    *--------------------------------------------------------------------------
    this_dDatas  = {}   && Datas  D        - getLancamento "Data :"
    this_nValors = 0.00 && Valors N(11,2)  - getValor      "Valor :" (legado: 0.00)
    this_cHists  = ""   && Hists  C(60)    - getHistorico  "Historico :"

    *--------------------------------------------------------------------------
    * ESTADO DA BUSCA SEQUENCIAL
    *
    * this_cContinuar eh o "continuar" do form legado: CARACTERE, guardando
    * Str(valor,12,2) no criterio numerico e Alltrim(historico) no criterio
    * texto. Vazio significa "a proxima busca comeca do topo".
    *
    * this_lFinalArquivo eh o llFinal medido ANTES da busca: com ele ligado o
    * CONTINUE nao eh tentado, porque nao ha registro seguinte.
    *--------------------------------------------------------------------------
    this_cContinuar    = ""     && legado: ThisForm.Continuar
    this_lFinalArquivo = .F.    && legado: llFinal (cursor no ultimo registro)

    *--------------------------------------------------------------------------
    * CRITERIO ESCOLHIDO E DESTINO DO FOCO
    *
    * this_cTipoBusca eh o seletor dos DOIS Do Case do btnOK.Click legado,
    * resolvido uma vez e reusado: "DATA" / "VALOR" / "HISTORICO" / "" (nenhum
    * criterio preenchido). As outras duas properties sao a traducao do segundo
    * Do Case, para o form apenas obedecer:
    *
    *     this_lFecharDialogo = .T.  -> ThisForm.Release
    *     this_cCampoFoco = "VALOR" ou "HISTORICO" -> SetFocus no campo
    *--------------------------------------------------------------------------
    this_cTipoBusca     = ""    && DATA / VALOR / HISTORICO / vazio
    this_cCampoFoco     = ""    && VALOR / HISTORICO / vazio
    this_lFecharDialogo = .F.   && .T. quando o legado faz ThisForm.Release

    *--------------------------------------------------------------------------
    * RESULTADO DA BUSCA
    *
    * this_lAchouRegistro recebe o FOUND() do LOCATE / CONTINUE. Nao gera
    * mensagem nenhuma (ver nota "AUSENCIA DE MENSAGEM" no cabecalho): serve
    * para o form decidir se vale reposicionar a grade.
    *
    * this_nRegistroAchado guarda o RECNO() da ocorrencia e
    * this_nRegistroAnterior o RECNO() de onde a busca partiu - o que permite
    * devolver o ponteiro ao lugar de origem quando nada eh encontrado, em vez
    * de deixar a grade parada em EOF.
    *--------------------------------------------------------------------------
    this_lAchouRegistro    = .F.
    this_nRegistroAchado   = 0
    this_nRegistroAnterior = 0
    this_nTotalRegistros   = 0

    *--------------------------------------------------------------------------
    * VALORES DO REGISTRO LOCALIZADO (preenchidos por CarregarDoCursor)
    *
    * Espelho das tres colunas pesquisadas, LIDAS da linha em que o LOCATE /
    * CONTINUE parou. Sao DISTINTAS das properties de criterio (this_dDatas /
    * this_nValors / this_cHists) de proposito, e a separacao eh obrigatoria:
    * o primeiro Do Case do BuscarRegistro escolhe o criterio TESTANDO as
    * properties de criterio, entao carregar a linha achada em cima delas
    * TROCARIA o criterio da busca seguinte - uma busca por Valor passaria a
    * ser por Data (a coluna Datas da linha achada nunca esta vazia), em
    * silencio. Com o par separado, CarregarDoCursor eh so leitura e nao tem
    * como interferir na sequencia de buscas.
    *
    * Tipos conferidos nas duas pontas (ver cabecalho do arquivo): no cursor
    * do form pai Datas eh D, Valors eh N(11,2) e Hists eh C(60).
    *--------------------------------------------------------------------------
    this_dDatasAchado  = {}   && Datas  da linha localizada
    this_nValorsAchado = 0    && Valors da linha localizada
    this_cHistsAchado  = ""   && Hists  da linha localizada

    *--------------------------------------------------------------------------
    * CURSOR PESQUISADO E CONTEXTO DO FORM PAI
    *
    * this_cCursorBusca eh o alias que o form pai mantem ligado ao RecordSource
    * da grade de lancamentos - CrSigMvCcr em
    * Formsigopind.pgf_4c_1.Page2.grd_4c_Lancamento. Fica numa property, e nao
    * numa constante espalhada pelo codigo, porque TODA operacao deste BO eh
    * sobre esse alias.
    *
    * this_nDataSessionPai eh o primeiro parametro do form legado ("Arquivos"),
    * usado no "Set DataSession To Arquivos": sem entrar na data session do
    * pai, o alias nem existe para este dialogo.
    *--------------------------------------------------------------------------
    this_cCursorBusca    = "CrSigMvCcr"
    this_nDataSessionPai = 0

    *--------------------------------------------------------------------------
    * NOMES DAS COLUNAS PESQUISADAS
    *
    * Centralizados aqui para que LOCATE, CONTINUE e montagem de chave usem
    * sempre a mesma grafia - a do CREATE CURSOR do form pai, que eh tambem a
    * da tabela (regra #48: nome de coluna nao se deduz, se confere).
    *--------------------------------------------------------------------------
    this_cColunaData      = "Datas"
    this_cColunaValor     = "Valors"
    this_cColunaHistorico = "Hists"

    *--------------------------------------------------------------------------
    * VALOR ANTERIOR DE CADA CAMPO (legado: This.Tag no GotFocus)
    *
    * Os tres campos tem o par GotFocus / Valid: o GotFocus guarda o valor de
    * entrada e o Valid compara com o valor de saida para saber se o usuario
    * MUDOU o criterio - e, mudando, zera os outros dois campos e reinicia a
    * sequencia. O legado guarda isso no Tag do proprio controle, sempre como
    * CARACTERE:
    *
    *     getLancamento.GotFocus -> This.Tag = Dtos(This.Value)
    *     getValor.GotFocus      -> This.Tag = Str(This.Value,12,2)
    *     getHistorico.GotFocus  -> This.Tag = Alltrim(This.Value)
    *
    * Ficam espelhadas no BO, tambem como CARACTERE e no mesmo formato, porque
    * Tag de TextBox aceita SO caractere e porque guardar o estado no BO deixa
    * uma fonte unica para a comparacao.
    *--------------------------------------------------------------------------
    this_cTagDatas  = ""    && Dtos(valor de entrada)     - 8 posicoes
    this_cTagValors = ""    && Str(valor de entrada,12,2)  - 12 posicoes
    this_cTagHists  = ""    && Alltrim(valor de entrada)

    *--------------------------------------------------------------------------
    * LARGURAS DE DIGITACAO
    *
    * Vem da largura da COLUNA no cursor / schema, nunca do Width em pixels do
    * controle (regra #19). Usadas pelo MaxLength dos campos e pelo corte do
    * criterio de historico.
    *--------------------------------------------------------------------------
    this_nTamanhoHists   = 60   && Hists  C(60)
    this_nTamanhoValors  = 12   && Valors N(11,2) -> Str(x,12,2)
    this_nDecimaisValors = 2    && Valors N(11,2)

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros (ambos opcionais):
    *     par_nDataSessionPai - DataSessionId do form pai, o "Arquivos" do
    *                           legado. Guardado para o form poder executar
    *                           SET DATASESSION TO e alcancar o cursor.
    *     par_cCursorBusca    - alias a pesquisar. Omitido, fica o canonico
    *                           CrSigMvCcr do extrato de Conta Corrente.
    *
    * DODEFAULT() eh chamado SEM o nome da tabela de proposito: este BO nao vai
    * ao servidor e nao precisa de DataAccess (ver nota de arquitetura no
    * cabecalho).
    *
    * Devolve SEMPRE .T.: nao ha pre-requisito que possa falhar aqui - nenhum
    * SQL, nenhum cursor a abrir - e Init de BO que devolve .F. transforma o
    * CREATEOBJECT em logico e derruba o Init do proprio form, deixando a tela
    * sem abrir.
    *==========================================================================
    PROCEDURE Init(par_nDataSessionPai, par_cCursorBusca)
        LOCAL loc_nDataSession, loc_cCursor

        DODEFAULT()

        *-- Contexto da entidade (nenhuma ida ao servidor acontece aqui)
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        *-- DataSession do form pai (legado: Set DataSession To Arquivos)
        loc_nDataSession = 0
        IF VARTYPE(par_nDataSessionPai) = "N" AND par_nDataSessionPai > 0
            loc_nDataSession = par_nDataSessionPai
        ENDIF
        THIS.this_nDataSessionPai = loc_nDataSession

        *-- Alias pesquisado (default: a grade de lancamentos do extrato)
        loc_cCursor = ""
        IF VARTYPE(par_cCursorBusca) = "C"
            loc_cCursor = ALLTRIM(par_cCursorBusca)
        ENDIF
        IF EMPTY(loc_cCursor)
            loc_cCursor = "CrSigMvCcr"
        ENDIF
        THIS.this_cCursorBusca = loc_cCursor

        *-- Colunas pesquisadas (grafia do CREATE CURSOR do form pai)
        THIS.this_cColunaData      = "Datas"
        THIS.this_cColunaValor     = "Valors"
        THIS.this_cColunaHistorico = "Hists"

        *-- Criterios zerados, como no Init do legado
        *-- 0.00 (nao 0): o legado grava getValor.Value = 0.00 e o VFP9
        *-- preserva as casas decimais do literal, entao o campo da tela tem
        *-- de voltar a exibir "0.00". O form espelha esta property no
        *-- TxtValorLostFocus, logo o zero daqui chega a tela.
        THIS.this_dDatas  = {}
        THIS.this_nValors = 0.00
        THIS.this_cHists  = ""

        *-- A sequencia de busca comeca do topo
        THIS.this_cContinuar    = ""
        THIS.this_lFinalArquivo = .F.

        *-- Nenhum criterio escolhido e nenhum destino de foco decidido
        THIS.this_cTipoBusca     = ""
        THIS.this_cCampoFoco     = ""
        THIS.this_lFecharDialogo = .F.

        *-- Nenhuma busca executada ainda
        THIS.this_lAchouRegistro    = .F.
        THIS.this_nRegistroAchado   = 0
        THIS.this_nRegistroAnterior = 0
        THIS.this_nTotalRegistros   = 0

        *-- Nenhuma linha localizada ainda
        THIS.LimparRegistroAchado()

        *-- Valores de entrada dos campos (legado: This.Tag no GotFocus)
        THIS.this_cTagDatas  = ""
        THIS.this_cTagValors = ""
        THIS.this_cTagHists  = ""

        *-- Larguras vindas da coluna, nao do Width do controle
        THIS.this_nTamanhoHists   = 60
        THIS.this_nTamanhoValors  = 12
        THIS.this_nDecimaisValors = 2

        *-- Estado de edicao herdado: esta tela eh de consulta
        THIS.this_lEmEdicao     = .F.
        THIS.this_lNovoRegistro = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BuscarRegistro - Posiciona o cursor do form pai no registro encontrado
    *
    * Transcricao de SIGOPCRP.Commandgroup1.btnOK.Click (ver cabecalho do
    * arquivo, secoes "BUSCA SEQUENCIAL" e "PRECEDENCIA DOS CRITERIOS").
    *
    * O metodo faz SO a parte de DADOS do Click legado - LOCATE/CONTINUE no
    * cursor do pai e o calculo de qual criterio foi usado. As acoes de
    * TELA do legado (Refresh/SetFocus na grade do pai, SetFocus no proprio
    * campo, Release do dialogo) ficam no FORM, que le this_cTipoBusca /
    * this_cCampoFoco / this_lFecharDialogo / this_lAchouRegistro depois de
    * chamar este metodo.
    *
    * Devolve o mesmo valor guardado em this_lAchouRegistro. NUNCA exibe
    * mensagem quando nao acha - eh do legado (nota "AUSENCIA DE MENSAGEM"
    * no cabecalho do arquivo).
    *==========================================================================
    PROCEDURE BuscarRegistro()
        LOCAL loc_cAlias, loc_cColData, loc_cColValor, loc_cColHist, ;
              loc_cChaveTexto, loc_nChaveNumero, loc_lFinal, loc_lAchou

        loc_lAchou = .F.

        THIS.this_lAchouRegistro  = .F.
        THIS.this_nRegistroAchado = 0
        THIS.this_cCampoFoco      = ""
        THIS.this_lFecharDialogo  = .F.

        *-- A linha localizada da busca ANTERIOR nao vale mais
        THIS.LimparRegistroAchado()

        *-- Entra na data session do form pai - sem isso o alias nem existe
        *-- (legado: Set DataSession To Arquivos)
        IF THIS.this_nDataSessionPai > 0
            SET DATASESSION TO (THIS.this_nDataSessionPai)
        ENDIF

        loc_cAlias = THIS.this_cCursorBusca

        IF !USED(loc_cAlias)
            THIS.this_cTipoBusca     = ""
            THIS.this_lFecharDialogo = .T.
            RETURN .F.
        ENDIF

        loc_cColData  = THIS.this_cColunaData
        loc_cColValor = THIS.this_cColunaValor
        loc_cColHist  = THIS.this_cColunaHistorico

        SELECT (loc_cAlias)
        THIS.this_nRegistroAnterior = RECNO()
        THIS.this_nTotalRegistros   = RECCOUNT()

        SET NEAR ON

        *-- llFinal: "estou no ultimo registro (ou alem dele)", medido
        *-- ANTES da busca - igual ao legado
        loc_lFinal = EOF()
        IF !loc_lFinal
            SKIP
            loc_lFinal = EOF()
            SKIP -1
        ENDIF
        THIS.this_lFinalArquivo = loc_lFinal

        DO CASE
            *-- Criterio DATA: igualdade exata, sempre recomeca do topo
            CASE !EMPTY(THIS.this_dDatas)
                THIS.this_cTipoBusca = "DATA"
                THIS.this_cContinuar = ""
                loc_cChaveTexto = DTOS(ConverterParaData(THIS.this_dDatas))
                LOCATE FOR DTOS(&loc_cColData) = loc_cChaveTexto
                loc_lAchou = FOUND()

            *-- Criterio VALOR: mesma chave da vez anterior + ainda nao no
            *-- fim do arquivo -> Continue; senao grava a chave, Go Top e
            *-- Locate
            CASE THIS.this_nValors <> 0
                THIS.this_cTipoBusca = "VALOR"
                THIS.this_cCampoFoco = "VALOR"
                loc_nChaveNumero = THIS.this_nValors
                IF loc_nChaveNumero = VAL(THIS.this_cContinuar) AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = STR(loc_nChaveNumero, ;
                        THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
                    GO TOP
                    LOCATE FOR loc_nChaveNumero = &loc_cColValor
                ENDIF
                loc_lAchou = FOUND()

            *-- Criterio HISTORICO: "$" (contido em), NUNCA "=" - mesma
            *-- logica de Continue do criterio Valor
            CASE !EMPTY(THIS.this_cHists)
                THIS.this_cTipoBusca = "HISTORICO"
                THIS.this_cCampoFoco = "HISTORICO"
                loc_cChaveTexto = ALLTRIM(THIS.this_cHists)
                IF ALLTRIM(THIS.this_cContinuar) = loc_cChaveTexto AND !loc_lFinal
                    CONTINUE
                ELSE
                    THIS.this_cContinuar = loc_cChaveTexto
                    GO TOP
                    LOCATE FOR loc_cChaveTexto $ &loc_cColHist
                ENDIF
                loc_lAchou = FOUND()

            *-- Nenhum criterio preenchido - legado so fecha o dialogo
            OTHERWISE
                THIS.this_cTipoBusca = ""
        ENDCASE

        SET NEAR OFF

        *-- DATA fecha sempre; sem nenhum criterio preenchido tambem fecha
        *-- (Otherwise do segundo Do Case legado); VALOR/HISTORICO deixam o
        *-- dialogo aberto com foco no proprio campo
        THIS.this_lFecharDialogo = INLIST(THIS.this_cTipoBusca, "DATA", "")

        THIS.this_lAchouRegistro = loc_lAchou
        IF loc_lAchou
            THIS.this_nRegistroAchado = RECNO(loc_cAlias)

            *-- Le a linha em que o LOCATE / CONTINUE parou para as
            *-- properties this_*Achado (o cursor JA esta posicionado nela;
            *-- CarregarDoCursor apenas le e NAO move o ponteiro)
            THIS.CarregarDoCursor(loc_cAlias)
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * AtualizarTagDatas / AtualizarTagValors / AtualizarTagHistorico
    *
    * Espelham o GotFocus dos tres campos (This.Tag = <valor de entrada>,
    * sempre como CARACTERE - ver nota "VALOR ANTERIOR DE CADA CAMPO" no
    * cabecalho). O form chama um destes no GotFocus do TextBox
    * correspondente, passando o .Value de ENTRADA (antes da edicao).
    *==========================================================================
    PROCEDURE AtualizarTagDatas(par_dValorEntrada)
        THIS.this_cTagDatas = DTOS(ConverterParaData(par_dValorEntrada))
    ENDPROC

    PROCEDURE AtualizarTagValors(par_nValorEntrada)
        THIS.this_cTagValors = STR(par_nValorEntrada, ;
            THIS.this_nTamanhoValors, THIS.this_nDecimaisValors)
    ENDPROC

    PROCEDURE AtualizarTagHistorico(par_cValorEntrada)
        THIS.this_cTagHists = ALLTRIM(par_cValorEntrada)
    ENDPROC

    *==========================================================================
    * ValidarCriterioDatas / ValidarCriterioValors / ValidarCriterioHistorico
    *
    * Espelham o Valid dos tres campos: comparam o valor de SAIDA do
    * controle com o Tag guardado no GotFocus (AtualizarTag*) para saber se
    * o usuario MUDOU aquele criterio. Mudando, zeram os OUTROS criterios -
    * exatamente o Do Case de cada Valid no legado (ver cabecalho do
    * arquivo). O form chama no Valid do TextBox correspondente, passando o
    * .Value de SAIDA, e zera na TELA os campos cuja property voltou a
    * vazio/zero.
    *
    * Devolvem .T. quando o criterio mudou (os outros campos foram
    * zerados) e .F. quando nao mudou nada.
    *
    *--------------------------------------------------------------------------
    * CADA UM GUARDA O PROPRIO CRITERIO (Fase 8)
    *--------------------------------------------------------------------------
    * Os tres zeram os OUTROS dois criterios e, antes disso, guardam na propria
    * property o valor de SAIDA que acabaram de receber. No legado isso nao
    * precisa existir porque o CONTROLE eh o armazenamento
    * (ThisForm.getValor.Value eh, ao mesmo tempo, tela e modelo); na
    * arquitetura em camadas o modelo eh a property, e sem esta linha ela ficava
    * com o valor ANTERIOR - a property so era alimentada pelo FormParaBO, que
    * roda no Procurar, nao no Valid.
    *
    * MEDIDO no VFP9 (automation\probe714c.prg) - sem o "guarda o proprio", o
    * BOParaForm da Fase 8 (que espelha os TRES campos) devolvia a property
    * velha para o campo e APAGAVA o valor que o usuario tinha acabado de
    * digitar: ValidarValor com 777 deixava a tela em [ / / |0|]. Eh o defeito
    * da regra #50 (apagar o digitado), e a alternativa - o Form espelhar "todos
    * menos o que mudou" - devolveria o BOParaForm as tres copias com pares
    * diferentes de campos que a Fase 8 unificou.
    *
    * Guardar FORA do IF, de proposito: a property tem de refletir o campo
    * tambem quando o criterio NAO mudou, senao o estado do modelo passa a
    * depender de o usuario ter mexido no campo.
    *==========================================================================
    PROCEDURE ValidarCriterioDatas(par_dValorSaida)
        LOCAL loc_dTagComoData, loc_lMudou

        *-- legado: Ctod(Subs(Tag,7,2)+'/'+Subs(Tag,5,2)+'/'+Subs(Tag,1,4))
        *-- Tag em DTOS (YYYYMMDD) -> reconstroi DD/MM/YYYY (SET DATE BRITISH)
        loc_dTagComoData = CTOD(SUBSTR(THIS.this_cTagDatas, 7, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 5, 2) + "/" + ;
                                 SUBSTR(THIS.this_cTagDatas, 1, 4))

        loc_lMudou = (ConverterParaData(par_dValorSaida) <> loc_dTagComoData)

        *-- ConverterParaData (nao TTOD) porque o valor vem de TextBox criado
        *-- com .Value = {}, isto eh DATE, e TTOD com DATE dispara erro 11 em
        *-- runtime (regra #16)
        THIS.this_dDatas = ConverterParaData(par_dValorSaida)

        IF loc_lMudou
            THIS.this_nValors = 0.00   && legado: ThisForm.getValor.Value = 0.00
            THIS.this_cHists  = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioValors(par_nValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (par_nValorSaida <> VAL(THIS.this_cTagValors))

        THIS.this_nValors = par_nValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_cHists     = ""
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    PROCEDURE ValidarCriterioHistorico(par_cValorSaida)
        LOCAL loc_lMudou

        loc_lMudou = (THIS.this_cTagHists <> ALLTRIM(par_cValorSaida))

        *-- Guarda o texto CRU, nao o ALLTRIM: o ALLTRIM eh da COMPARACAO e da
        *-- montagem da chave em BuscarRegistro; apagar os espacos aqui mudaria
        *-- o que o usuario ve no campo quando o BOParaForm espelhar de volta.
        THIS.this_cHists = par_cValorSaida

        IF loc_lMudou
            THIS.this_cContinuar = ""
            THIS.this_dDatas     = {}
            THIS.this_nValors    = 0.00   && legado: ThisForm.getValor.Value = 0.00
        ENDIF

        RETURN loc_lMudou
    ENDPROC

    *==========================================================================
    * LimparRegistroAchado - Zera o espelho da linha localizada
    *
    * Chamado no Init e na ENTRADA do BuscarRegistro: a linha achada na busca
    * anterior nao vale mais assim que uma nova busca comeca, e deixa-la para
    * tras faria o chamador ler o registro errado quando o LOCATE falhasse.
    *
    * Nao leva PROTECTED (regra #51): metodo que o Form pode chamar de fora
    * nunca pode ser protegido em nivel nenhum da heranca.
    *==========================================================================
    PROCEDURE LimparRegistroAchado()
        THIS.this_dDatasAchado  = {}
        THIS.this_nValorsAchado = 0
        THIS.this_cHistsAchado  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Le a linha CORRENTE do cursor pesquisado
    *
    * Override do metodo homonimo da BusinessBase, que na base eh um stub
    * documentando justamente este contrato: "ler a linha corrente do alias
    * recebido para as properties do BO", com EVALUATE(pcCursor + ".coluna").
    *
    * Aqui ele le as tres colunas pesquisadas - Datas, Valors e Hists - da
    * linha em que o cursor do form pai esta POSICIONADO, para as properties
    * this_dDatasAchado / this_nValorsAchado / this_cHistsAchado. Serve para o
    * chamador saber QUAL lancamento a busca encontrou sem ter de mexer no
    * cursor do pai (que eh o RecordSource da grade de lancamentos e nao deve
    * ser navegado por fora).
    *
    * ESCOPO - o que este metodo NAO faz, de proposito:
    *   - NAO escreve em property de CRITERIO (this_dDatas / this_nValors /
    *     this_cHists): isso trocaria o criterio da busca seguinte em silencio
    *     (ver nota nas properties this_*Achado);
    *   - NAO habilita edicao: este BO eh somente-leitura, o legado so move o
    *     ponteiro do cursor e nao tem INSERT / UPDATE / DELETE nem
    *     TABLEUPDATE (ver nota de arquitetura no cabecalho do arquivo);
    *   - NAO move o ponteiro: EVALUATE apenas le.
    *
    * Parametro:
    *     par_cAliasCursor - alias a ler. Omitido ou vazio, usa o cursor
    *                        pesquisado (this_cCursorBusca = CrSigMvCcr).
    *
    * Devolve .T. quando leu uma linha valida e .F. quando o alias nao esta
    * aberto ou o cursor esta vazio / em EOF - neste caso o espelho fica
    * zerado, nunca com o resto da leitura anterior.
    *
    * NOTAS DE IMPLEMENTACAO
    *
    * (a) SELECT (par_cAliasCursor) ANTES de qualquer leitura, e acesso por
    *     EVALUATE(alias + "." + coluna) - NUNCA a sintaxe campo,
    *     que nao existe em VFP9 e estoura "Function name is missing )".
    *
    * (b) A existencia de cada coluna eh conferida com TYPE(alias + ".col"),
    *     nao com PEMSTATUS: PEMSTATUS exige OBJETO no 1o argumento e com
    *     nome de cursor dispara erro 11.
    *
    * (c) TratarNulo(valor, <PADRAO>) - o 2o argumento eh o VALOR PADRAO, nao
    *     um codigo de tipo. Dai {} / 0 / "" e nunca "D" / "N" / "C", que
    *     gravariam a LETRA na property.
    *
    * (d) A data passa por ConverterParaData porque a MESMA coluna chega com
    *     tipos diferentes conforme a origem: D no cursor que o form pai cria
    *     com CREATE CURSOR, T quando o alias vem de um SELECT sobre
    *     SigMvCcr.datas (datetime). TTOD() nao serve - com DATE ele dispara
    *     erro 11 em runtime (regra #16).
    *
    * (e) Valor e historico tambem sao conferidos por VARTYPE antes de serem
    *     aceitos (regra #13): coluna numerica que chegue como caractere viria
    *     a estourar "Operator/operand type mismatch" na primeira conta.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso, loc_cPrefixo, ;
              loc_uDatas, loc_uValors, loc_uHists

        loc_lSucesso = .F.

        *-- Alias a ler: o informado ou, na falta, o cursor pesquisado
        loc_cAlias = ""
        IF VARTYPE(par_cAliasCursor) = "C"
            loc_cAlias = ALLTRIM(par_cAliasCursor)
        ENDIF
        IF EMPTY(loc_cAlias)
            loc_cAlias = THIS.this_cCursorBusca
        ENDIF

        *-- Espelho sempre zerado antes de ler: alias fechado ou cursor em
        *-- EOF nao pode deixar para tras o registro da leitura anterior
        THIS.LimparRegistroAchado()

        IF USED(loc_cAlias)
            *-- (a) OBRIGATORIO antes de ler campo com alias dinamico
            SELECT (loc_cAlias)

            IF RECCOUNT() > 0 AND !EOF()
                loc_cPrefixo = loc_cAlias + "."

                *-- Datas  D  (no cursor do pai) / datetime (na tabela)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaData) != "U"
                    loc_uDatas = EVALUATE(loc_cPrefixo + THIS.this_cColunaData)
                    THIS.this_dDatasAchado = ConverterParaData(TratarNulo(loc_uDatas, {}))
                ENDIF

                *-- Valors N(11,2)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaValor) != "U"
                    loc_uValors = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaValor), 0)
                    IF VARTYPE(loc_uValors) = "N"
                        THIS.this_nValorsAchado = loc_uValors
                    ELSE
                        THIS.this_nValorsAchado = 0
                    ENDIF
                ENDIF

                *-- Hists  C(60)
                IF TYPE(loc_cPrefixo + THIS.this_cColunaHistorico) != "U"
                    loc_uHists = TratarNulo(EVALUATE(loc_cPrefixo + THIS.this_cColunaHistorico), "")
                    IF VARTYPE(loc_uHists) = "C"
                        THIS.this_cHistsAchado = LEFT(loc_uHists, THIS.this_nTamanhoHists)
                    ELSE
                        THIS.this_cHistsAchado = ""
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

