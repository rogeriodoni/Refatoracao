# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Gravafichatecnica()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontaFichaTecnica()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.cnt_4c_AreaFicha()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.RespostaEhFixa()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.LerRespostaDaTela()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterControleResposta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.this_cIclis()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopftc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1992 linhas total):

*-- Linhas 10 a 89:
10: * associadas a uma Operacao (SigCdOpe.Dopes), para o cliente corrente.
11: *
12: * O legado cria uma janela filha (frmbarcta) com um container de scroll
13: * (ScrollBarContainer.ScrollSlide) onde monta, em runtime, um par
14: * Label+Memo/TextBox por caracteristica (MontaFichaTecnica). Esse container
15: * dinamico equivale aqui a cnt_4c_AreaFicha (fase 3: criado vazio; as fases
16: * seguintes populam os controles via AddObject em SCAN, igual ao legado).
17: *
18: * MIGRADO (Fases 3-4/8):
19: *   - DEFINE CLASS + propriedades visuais (dimensoes exatas do legado,
20: *     800x500 - dialogo flutuante, NAO segue o canonico 1000x600 de
21: *     frmcadastro, que nao se aplica a este form)
22: *   - Init(par_cTipoAcao, par_cOperacao, par_cIclis) / InicializarForm / Destroy
23: *   - ConfigurarCabecalho (cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo,
24: *     mapeamento.json)
25: *   - ConfigurarAreaFicha (cnt_4c_AreaFicha - container vazio que recebera
26: *     os campos dinamicos da ficha tecnica nas proximas fases)
27: *   - TornarControlesVisiveis recursivo
28: *   - FASE 4: ConfigurarContainerBotoes COMPLETO - cmg_4c_Botoes com os 2
29: *     botoes do cntBotoes legado (Caption/Picture/fonte/cor/TabIndex/Cancel
30: *     transcritos do dump) e os BINDEVENT de Click; BtnCancelarClick (que a
31: *     Fase 4 chamou BtnSairClick - ver Fase 8, nomear pela ACAO) e
32: *     BtnConfirmarClick (os dois Click do legado); GravarFichaTecnica e
33: *     CarregarRespostasGravadas (gravafichatecnica legado -> INSERT em
34: *     SigCdCet via sigopftcBO)
35: *
36: * ESTE FORM NAO TEM GRID NEM BOTOES CRUD - e nao deve ter. O SCX legado tem
37: * EXATAMENTE 4 objetos visuais (cntSombra + lblSombra + lblTitulo + cntBotoes):
38: * zero objeto de BaseClass grid/pageframe, zero controle de entrada de dados e
39: * zero AddCursor/pColuna/RecordSource/ControlSource. A estrutura Lista/Dados
40: * com 6 botoes CRUD do frmcadastro teria de ser INVENTADA (viola o PILAR 1), e
41: * os campos da ficha nao sao desenhados no SCX: o legado os cria em RUNTIME no
42: * MontaFichaTecnica (fases 5-6). O que a Fase 4 acrescenta aqui sao os botoes
43: * de acao que o legado realmente tem - Confirmar e Cancelar - com a logica de
44: * gravacao do btnConfirmar.
45: *
46: * MIGRADO (Fase 7/8) - eventos PRINCIPAIS do dialogo. Os quatro nomes de
47: * convencao Btn<Incluir|Alterar|Visualizar|Excluir> + Click NAO existem
48: * aqui e nao devem existir: o SCX legado tem DOIS botoes (Confirmar/Cancelar,
49: * ja na Fase 4) e ZERO superficie CRUD - inventa-los violaria o PILAR 1 e
50: * criar metodo vazio e proibido pela regra de completude. Os eventos
51: * principais deste form sao os metodos do PROPRIO SCX, chamados pelo form PAI
52: * de movimentacao, todos PUBLIC por isso (regra #51):
53: *   - ChecarFichaTecnica(par_cTipo)  (checarfichatecnica - "GRUPO_OP"/
54: *     "MOSTRARFORM"; o gatilho central, que decide montar ou nao a ficha)
55: *   - MontarFichaTecnica / CarregarFichaTecnica / DesmontarFichaTecnica
56: *     (montafichatecnica/carregafichatecnica/desmontafichatecnica - criam,
57: *     preenchem e removem em RUNTIME os controles mem_4c_Ficha<COrds> que a
58: *     Fase 4 ja le em GravarFichaTecnica)
59: *   - ValidarFichaTecnica (validafichatecnica - tamanho minimo da resposta)
60: *   - MostrarForm / OcultarForm (mostrarform/ocultarform)
61: * e os carregadores de dados que esses eventos usam:
62: * CarregarOperacaoComFicha (cnSigCdOpe), CarregarCaracteristicas
63: * (crTmpFicha) e RespostaEhFixa (crResp de SigCdFtr).
64: *
65: * As Fases 5 e 6 do pipeline nao produziram codigo (os fase_5_output.txt e
66: * fase_6_output.txt de tasks\task737 registram o agente sem prompt de tarefa),
67: * entao os campos dinamicos - que seriam delas - entraram aqui: sem eles
68: * ChecarFichaTecnica chamaria um metodo inexistente (regra #13) e o Confirmar
69: * da Fase 4 nunca teria cursor_4c_Ficha para percorrer.
70: *
71: * LIMITE CONHECIDO, registrado (nao e omissao silenciosa): a janela de scroll
72: * do legado - frmbarcta, com ScrollBarContainer/VerticalScrollBar - NAO foi
73: * portada para o projeto novo, assim como fwprogressbar precisou de stub. Os
74: * campos sao empilhados em cnt_4c_AreaFicha e o excedente fica recortado se a
75: * ficha for mais alta que o container; o pnCaixa/plSelecao do fweditbox legado
76: * (lista de respostas pre-cadastradas) tambem depende dessa classe. Ver
77: * MontarFichaTecnica.
78: *
79: * MIGRADO (Fase 8/8) - CONSOLIDACAO. Nenhum metodo novo inventa superficie: os
80: * quatro acrescentados sao o FUNIL dos blocos que as fases anteriores tinham
81: * inline e duplicado, o que elimina a chance de dois deles montarem nomes de
82: * controle diferentes (a armadilha que a regra #42 descreve para chave e que
83: * vale igual para nome de objeto montado em runtime):
84: *   - CarregarLista()        - ponto UNICO de (re)carga da lista de
85: *     caracteristicas: desmonta o que esta na tela, recarrega cursor_4c_Operacao
86: *     e remonta/repinta a ficha. Eh exatamente o bloco "If llOks / If Not
87: *     Empty(Operacao)" do checarfichatecnica legado, extraido para ter ponto de
88: *     recarga. PUBLIC (regra #3: o harness TesteAutomatico.prg chama
89: *     THIS.oForm.CarregarLista() de FORA da classe).

*-- Linhas 203 a 317:
203:         THIS.this_cOperacao = IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")
204:         THIS.this_cIclis    = IIF(VARTYPE(par_cIclis) = "C", par_cIclis, "")
205: 
206:         THIS.this_oBusinessObject = CREATEOBJECT("sigopftcBO")
207:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
208:             MsgErro("Erro ao criar sigopftcBO.", "Erro")
209:             RETURN .F.
210:         ENDIF
211: 
212:         WITH THIS.this_oBusinessObject
213:             .this_cTipoAcao = THIS.this_cTipoAcao
214:             .this_cOperacao = THIS.this_cOperacao
215:             .this_cIclis    = THIS.this_cIclis
216:         ENDWITH
217: 
218:         RETURN DODEFAULT()
219:     ENDFUNC
220: 
221:     *==========================================================================
222:     * InicializarForm - Monta a estrutura base do dialogo
223:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
224:     *==========================================================================
225:     PROTECTED PROCEDURE InicializarForm()
226:         LOCAL loc_lSucesso, loc_oErro
227: 
228:         loc_lSucesso = .F.
229: 
230:         TRY
231:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
232: 
233:             THIS.ConfigurarCabecalho()
234:             THIS.ConfigurarContainerBotoes()
235:             THIS.ConfigurarAreaFicha()
236: 
237:             THIS.TornarControlesVisiveis(THIS)
238: 
239:             *-- Legado (Init): ThisForm.CriarForm() seguido de
240:             *-- Thisform.MostrarForm() - eh o MostrarForm que dispara
241:             *-- ChecarFichaTecnica("MOSTRARFORM") e MONTA os campos da ficha.
242:             *-- ConfigurarAreaFicha acima equivale ao CriarForm (cria o
243:             *-- container e liga this_lCriouForm).
244:             *--
245:             *-- Em modo de teste/validacao de UI nao ha conexao SQL: montar a
246:             *-- ficha exigiria SigCdFtc/SigOpFtc e o erro abortaria o Init,
247:             *-- fazendo CREATEOBJECT devolver .F. e a tela nao abrir.
248:             IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) ;
249:                AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
250:                 THIS.MostrarForm()
251:             ENDIF
252: 
253:             loc_lSucesso = .T.
254: 
255:         CATCH TO loc_oErro
256:             THIS.this_cMensagemErro = loc_oErro.Message
257:             MsgErro(loc_oErro.Message + CHR(13) + ;
258:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
259:                     "Procedure: " + loc_oErro.Procedure, ;
260:                     "Erro em Formsigopftc.InicializarForm")
261:         ENDTRY
262: 
263:         RETURN loc_lSucesso
264:     ENDPROC
265: 
266:     *==========================================================================
267:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
268:     * cnt_4c_Sombra: Top=0 Left=0 Width=THIS.Width Height=80 BackColor=RGB(100,100,100)
269:     * Nomes conforme mapeamento.json (task737).
270:     *==========================================================================
271:     PROTECTED PROCEDURE ConfigurarCabecalho()
272:         THIS.AddObject("cnt_4c_Sombra", "Container")
273:         WITH THIS.cnt_4c_Sombra
274:             .Top         = 0
275:             .Left        = 0
276:             .Width       = THIS.Width
277:             .Height      = 80
278:             .BackStyle   = 1
279:             .BackColor   = RGB(100, 100, 100)
280:             .BorderWidth = 0
281:             .Visible     = .T.
282:         ENDWITH
283: 
284:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
285:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
286:             .Top        = 18
287:             .Left       = 10
288:             .Width      = THIS.Width - 20
289:             .Height     = 40
290:             .FontName   = "Tahoma"
291:             .FontSize   = 18
292:             .FontBold   = .T.
293:             .ForeColor  = RGB(0, 0, 0)
294:             .BackStyle  = 0
295:             .WordWrap   = .T.
296:             .AutoSize   = .F.
297:             .Caption    = THIS.Caption
298:             .Visible    = .T.
299:         ENDWITH
300: 
301:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
302:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
303:             .Top        = 17
304:             .Left       = 10
305:             .Width      = THIS.Width - 20
306:             .Height     = 46
307:             .FontName   = "Tahoma"
308:             .FontSize   = 18
309:             .FontBold   = .T.
310:             .ForeColor  = RGB(255, 255, 255)
311:             .BackStyle  = 0
312:             .WordWrap   = .T.
313:             .AutoSize   = .F.
314:             .Caption    = THIS.Caption
315:             .Visible    = .T.
316:         ENDWITH
317:     ENDPROC

*-- Linhas 341 a 390:
341:     * (regra #33); por isso fonte e cor sao definidas em cada Buttons(N).
342:     * Os Picture vem do dump legado, nunca de palpite semantico (regra #25):
343:     * "Cancelar" usa cadastro_sair_60.jpg e "Confirmar" cadastro_salvar_60.jpg,
344:     * ambos conferidos em vbmp\.
345:     *
346:     * Criado DEPOIS de cnt_4c_Sombra de proposito: com Top=-2 os botoes caem
347:     * sobre a area da faixa do cabecalho (0..80) e so aparecem desenhando por
348:     * cima dela - a mesma ordem do SCX legado (regra #11).
349:     *==========================================================================
350:     PROTECTED PROCEDURE ConfigurarContainerBotoes()
351:         LOCAL loc_oCmg
352: 
353:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
354:         loc_oCmg = THIS.cmg_4c_Botoes
355: 
356:         loc_oCmg.ButtonCount = 2
357: 
358:         *-- Buttons(1) = btnSair legado: "\<Cancelar", Cancel = .T. (responde ESC)
359:         WITH loc_oCmg.Buttons(1)
360:             .Top           = 5
361:             .Left          = 80
362:             .Width         = 75
363:             .Height        = 75
364:             .Caption       = "\<Cancelar"
365:             .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
366:             .FontName      = "Comic Sans MS"
367:             .FontSize      = 8
368:             .FontBold      = .T.
369:             .FontItalic    = .T.
370:             .WordWrap      = .T.
371:             .AutoSize      = .F.
372:             .ForeColor     = RGB(90, 90, 90)
373:             .BackColor     = RGB(255, 255, 255)
374:             .SpecialEffect = 0
375:             .MousePointer  = 15
376:             .Cancel        = .T.
377:             .TabIndex      = 2
378:             .ToolTipText   = "[Esc] Encerrar"
379:             .Themes        = .F.
380:             .Visible       = .T.
381:         ENDWITH
382: 
383:         *-- Buttons(2) = btnConfirmar legado: "\<Confirmar"
384:         WITH loc_oCmg.Buttons(2)
385:             .Top           = 5
386:             .Left          = 5
387:             .Width         = 75
388:             .Height        = 75
389:             .Caption       = "\<Confirmar"
390:             .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

*-- Linhas 421 a 775:
421:         ENDWITH
422: 
423:         *-- Handlers dos dois Click do legado. Os metodos alvo sao PUBLIC
424:         *-- (regra #3: BINDEVENT nao alcanca metodo PROTECTED).
425:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnCancelarClick")
426:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnConfirmarClick")
427:     ENDPROC
428: 
429:     *==========================================================================
430:     * ConfigurarAreaFicha - Container vazio que recebera os campos dinamicos
431:     * da ficha tecnica (equivalente ao poWindowOpe.ScrollBarContainer.ScrollSlide
432:     * do legado). Fases seguintes populam via AddObject em SCAN de
433:     * crTmpFicha/cursor_4c_Ficha (MontarFichaTecnica).
434:     *==========================================================================
435:     PROTECTED PROCEDURE ConfigurarAreaFicha()
436:         THIS.AddObject("cnt_4c_AreaFicha", "Container")
437:         WITH THIS.cnt_4c_AreaFicha
438:             .Top         = 80
439:             .Left        = 0
440:             .Width       = THIS.Width
441:             .Height      = THIS.Height - 80
442:             .BackStyle   = 0
443:             .BorderWidth = 0
444:             .Visible     = .T.
445:         ENDWITH
446: 
447:         THIS.this_lCriouForm = .T.
448:     ENDPROC
449: 
450:     *==========================================================================
451:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
452:     * Form flat sem containers flutuantes, portanto sem lista de skip.
453:     *==========================================================================
454:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
455:         LOCAL loc_i, loc_oControl
456: 
457:         FOR loc_i = 1 TO par_oContainer.ControlCount
458:             loc_oControl = par_oContainer.Controls(loc_i)
459: 
460:             IF VARTYPE(loc_oControl) = "O"
461:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
462:                     loc_oControl.Visible = .T.
463:                 ENDIF
464:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
465:                     THIS.TornarControlesVisiveis(loc_oControl)
466:                 ENDIF
467:             ENDIF
468:         ENDFOR
469:     ENDPROC
470: 
471:     *==========================================================================
472:     * BtnConfirmarClick - Click de cntBotoes.btnConfirmar (Command2) legado
473:     *
474:     * Legado (SIGOPFTC.cntBotoes.btnConfirmar.Click):
475:     *     If( ThisForm.CriouForm )
476:     *         This.Gravafichatecnica()
477:     *     Endif
478:     *
479:     * Transcrito como esta: o legado NAO fecha o dialogo ao confirmar e NAO
480:     * chama ValidaFichaTecnica aqui (a validacao de tamanho minimo da resposta
481:     * eh disparada pelo form pai, fase 7-8). PUBLIC por ser alvo de BINDEVENT
482:     * (regra #3).
483:     *==========================================================================
484:     PROCEDURE BtnConfirmarClick()
485:         IF THIS.this_lCriouForm
486:             THIS.GravarFichaTecnica()
487:         ENDIF
488:     ENDPROC
489: 
490:     *==========================================================================
491:     * BtnCancelarClick - Click de cntBotoes.btnSair (Command1) legado
492:     * Legado: ThisForm.Release
493:     *
494:     * Nomeado pela ACAO, nao pelo Name do objeto legado: o objeto chama-se
495:     * btnSair, mas o Caption que o usuario le e "\<Cancelar" e o botao tem
496:     * Cancel = .T. (responde ESC). Herdar "BtnSairClick" violaria o PILAR 3 e
497:     * esconderia de quem le qual botao da tela o metodo atende. O corpo e o do
498:     * legado - abandonar o dialogo sem gravar nada; nada a desfazer, porque a
499:     * gravacao so acontece no Confirmar.
500:     *==========================================================================
501:     PROCEDURE BtnCancelarClick()
502:         THIS.Release()
503:     ENDPROC
504: 
505:     *==========================================================================
506:     * ChecarFichaTecnica - Evento PRINCIPAL do dialogo (checarfichatecnica)
507:     *
508:     * Transcricao de SIGOPFTC.checarfichatecnica (task737):
509:     *     Lparameters pTip
510:     *     lcArea = Alias()
511:     *     llOks = .f.
512:     *     If ((pTip = [GRUPO_OP]) And (ThisForm.pcEscolha <> [INSERIR]))
513:     *         llOks = .t.
514:     *     EndIf
515:     *     If Not llOks And InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR], ;
516:     *                             [CONSULTAR]) And ThisForm.PrimeiraEntrada ;
517:     *                             And ThisForm.CriouForm
518:     *         This.DesmontaFichaTecnica
519:     *         ThisForm.PrimeiraEntrada = .f.
520:     *         llOks = .t.
521:     *     EndIf
522:     *     If llOks
523:     *         If Not Empty(ThisForm.Operacao)
524:     *             <query SigCdOpe + SigCdFtc -> cnSigCdOpe>
525:     *             If (SqlExecute(...) < 1) / MessageBox('Favor Reinicializar o
526:     *                 Processo!!!') / Return .f.
527:     *             Select cnSigCdOpe / Go Top
528:     *             If Not This.MontaFichaTecnica(ThisForm.Operacao)
529:     *                 Select &lcArea / Return 0
530:     *             EndIf
531:     *         EndIf
532:     *     EndIf
533:     *     If !Empty(lcArea) / Select &lcArea / Endif
534:     *
535:     * par_cTipo eh o pTip legado - o TAG de texto que identifica QUEM chamou:
536:     * "GRUPO_OP" quando o disparo vem da barra de acao do form PAI e
537:     * "MOSTRARFORM" quando vem do proprio MostrarForm. NAO eh objeto nenhum:
538:     * eh literal comparado com "=", por isso nao implica superficie CRUD neste
539:     * form (o SCX tem 4 objetos visuais e dois botoes - Confirmar/Cancelar).
540:     *
541:     * PUBLIC: o form PAI chama este metodo de fora (no legado,
542:     * "ThisForm.ChecarFichaTecnica([GRUPO_OP])") - metodo PROTECTED alcancado
543:     * de fora estoura "Property CHECARFICHATECNICA is not found" (regra #51).
544:     *==========================================================================
545:     PROCEDURE ChecarFichaTecnica(par_cTipo)
546:         LOCAL loc_lSucesso, loc_lOks, loc_cTipo, loc_cArea, loc_oErro
547: 
548:         loc_lSucesso = .T.
549:         loc_cArea    = ALIAS()
550:         loc_cTipo    = UPPER(ALLTRIM(IIF(VARTYPE(par_cTipo) = "C", par_cTipo, "")))
551:         loc_lOks     = .F.
552: 
553:         TRY
554:             IF loc_cTipo == "GRUPO_OP" AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "INSERIR"
555:                 loc_lOks = .T.
556:             ENDIF
557: 
558:             IF !loc_lOks ;
559:                AND INLIST(UPPER(ALLTRIM(THIS.this_cTipoAcao)), "INSERIR", "ALTERAR", "CONSULTAR") ;
560:                AND THIS.this_lPrimeiraEntrada AND THIS.this_lCriouForm
561:                 THIS.DesmontarFichaTecnica()
562:                 THIS.this_lPrimeiraEntrada = .F.
563:                 loc_lOks = .T.
564:             ENDIF
565: 
566:             IF loc_lOks AND !EMPTY(ALLTRIM(THIS.this_cOperacao))
567:                 *-- Legado: query cnSigCdOpe + Go Top + MontaFichaTecnica. O
568:                 *-- bloco inteiro mora em CarregarLista (ponto UNICO de carga),
569:                 *-- para o form pai e o harness terem como recarregar a ficha
570:                 *-- sem repetir a sequencia - e para a recarga nunca acontecer
571:                 *-- sem o Desmontar que a remontagem exige.
572:                 loc_lSucesso = THIS.CarregarLista()
573:             ENDIF
574: 
575:         CATCH TO loc_oErro
576:             loc_lSucesso = .F.
577:             THIS.this_cMensagemErro = loc_oErro.Message
578:             MsgErro(loc_oErro.Message + CHR(13) + ;
579:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
580:                     "Procedure: " + loc_oErro.Procedure, ;
581:                     "Erro em Formsigopftc.ChecarFichaTecnica")
582:         ENDTRY
583: 
584:         *-- Legado: If !Empty(lcArea) / Select &lcArea
585:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
586:             SELECT (loc_cArea)
587:         ENDIF
588: 
589:         RETURN loc_lSucesso
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * MostrarForm - Exibe a ficha tecnica (mostrarform legado)
594:     *
595:     * Legado:
596:     *     If ThisForm.CriouForm
597:     *         ThisForm.ChecarFichaTecnica([MOSTRARFORM])
598:     *         ThisForm.Top = This.Top + 60
599:     *         ThisForm.ZOrder(1)
600:     *         ThisForm.Refresh
601:     *     EndIf
602:     *
603:     * DIVERGENCIA DELIBERADA, registrada: o "ThisForm.Top = This.Top + 60" e o
604:     * ZOrder(1) do legado sao empilhamento de JANELA - posicionam o form sobre
605:     * a janela filha frmbarcta (poWindowOpe), que hospeda o container de
606:     * scroll. Aqui esse container eh filho do PROPRIO form (cnt_4c_AreaFicha),
607:     * nao outra janela, e o form tem AutoCenter = .T.: deslocar o Top a cada
608:     * chamada faria a tela DESCER 60px por vez. Nao se transcreve o Top.
609:     *
610:     * O ZOrder(1) (= mandar para TRAS) DO CONTAINER nao eh transcricao do
611:     * legado e sim consequencia da ordem de AddObject deste form:
612:     * cnt_4c_AreaFicha eh criado DEPOIS de cmg_4c_Botoes, e os dois se cruzam
613:     * em 80..83 (botoes em Top = -2 + Height 85; area da ficha em Top = 80).
614:     * Como o container eh BackStyle = 0, ele nao PINTA nada - mas, estando por
615:     * cima, intercepta o clique nessa faixa de 3px da base dos botoes (mesmo
616:     * efeito da caixa transparente da regra #23). ZOrder(1) devolve a faixa aos
617:     * botoes sem mexer na geometria transcrita do SCX.
618:     *
619:     * PUBLIC: chamado de fora pelo form pai (legado: "Thisform.MostrarForm()").
620:     *==========================================================================
621:     PROCEDURE MostrarForm()
622:         LOCAL loc_lSucesso
623: 
624:         loc_lSucesso = .T.
625: 
626:         IF THIS.this_lCriouForm
627:             loc_lSucesso = THIS.ChecarFichaTecnica("MOSTRARFORM")
628: 
629:             THIS.cnt_4c_AreaFicha.Visible = .T.
630:             THIS.cnt_4c_AreaFicha.ZOrder(1)
631:             THIS.Refresh()
632:         ENDIF
633: 
634:         RETURN loc_lSucesso
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * OcultarForm - Oculta a ficha tecnica (ocultarform legado)
639:     *
640:     * Legado: If ThisForm.CriouForm / ThisForm.poWindowOpe.Top = This.Top + 600
641:     * O legado "esconde" a janela filha jogando-a 600px para baixo (fora da
642:     * area visivel) porque frmbarcta nao pode ser fechada sem perder os campos
643:     * montados. Com o container no proprio form, o equivalente exato eh
644:     * Visible = .F.: os controles continuam montados (MontouCampos segue .T.)
645:     * e voltam com MostrarForm.
646:     *
647:     * PUBLIC: chamado de fora pelo form pai.
648:     *==========================================================================
649:     PROCEDURE OcultarForm()
650:         IF THIS.this_lCriouForm
651:             THIS.cnt_4c_AreaFicha.Visible = .F.
652:         ENDIF
653:     ENDPROC
654: 
655:     *==========================================================================
656:     * MontarFichaTecnica - Cria em RUNTIME um campo por caracteristica
657:     * (montafichatecnica legado, 182 linhas)
658:     *
659:     * Equivalencias da transcricao:
660:     *   crTmpFicha  -> cursor_4c_Ficha (CarregarCaracteristicas)
661:     *   loObjForm1  -> THIS.cnt_4c_AreaFicha (no legado,
662:     *                  poWindowOpe.ScrollBarContainer.ScrollSlide)
663:     *   sayFicha<N> -> lbl_4c_CarFicha<N>  (titulo da caracteristica)
664:     *   shpFicha<N> -> shp_4c_CarFicha<N>  (linha separadora)
665:     *   lblFicha<N> -> lbl_4c_Ficha<N>     (pergunta)
666:     *   memFicha<N> -> mem_4c_Ficha<N>     (resposta - CONTRATO lido por
667:     *                  GravarFichaTecnica/CarregarFichaTecnica/
668:     *                  ValidarFichaTecnica)
669:     *   [Say]       -> Label (classe say do framework legado)
670:     *   [fweditbox] -> EditBox (mesma troca aplicada no FormSigPrEml)
671:     *   [fwget]     -> TextBox com InputMask "99/99/9999"
672:     *
673:     * Cada Label leva AutoSize = .F. com Width/Height EXPLICITOS: AutoSize eh
674:     * NO-OP em objeto criado por AddObject (regra #23) - e o legado avanca o
675:     * lnTop pela .Height do Label, que sem isso viria do default e empilharia
676:     * os campos errado.
677:     *
678:     * O nome de cada controle eh montado em runtime, entao a referencia sai de
679:     * EVALUATE (regras #15 e #34: Controls(<nome>) nao funciona e EVALUATE eh a
680:     * forma correta de LEITURA - aqui devolvendo a REFERENCIA do objeto, que
681:     * depois recebe atribuicao normal).
682:     *
683:     * LIMITE CONHECIDO, registrado: a janela de scroll do legado (frmbarcta,
684:     * com ScrollBarContainer/VerticalScrollBar) NAO foi portada - essa classe
685:     * nao existe no projeto novo. Os campos sao empilhados em cnt_4c_AreaFicha
686:     * e, se a soma das alturas passar da altura do container, o excedente fica
687:     * RECORTADO (regra #30). O legado fecha com "SetSlideTop(0, ...)" (rolar
688:     * para o topo), que aqui nao tem equivalente. Portar frmbarcta eh
689:     * pre-requisito para ficha com muitas caracteristicas.
690:     *==========================================================================
691:     PROCEDURE MontarFichaTecnica(par_cOperacao)
692:         LOCAL loc_lSucesso, loc_cArea, loc_cDopes, loc_nTop, loc_nLef, loc_nWid
693:         LOCAL loc_cCar, loc_cObj, loc_nHei, loc_cPerg, loc_oCtrl, loc_oArea
694:         LOCAL loc_lRespFixa, loc_lEditavel, loc_oErro
695: 
696:         loc_lSucesso = .F.
697:         loc_cArea    = ALIAS()
698: 
699:         TRY
700:             IF THIS.this_lCriouForm AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "PROCURAR"
701:                 loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)
702: 
703:                 IF THIS.CarregarCaracteristicas(loc_cDopes)
704:                     loc_oArea = THIS.cnt_4c_AreaFicha
705:                     loc_nTop  = 1
706:                     loc_nLef  = 6
707:                     loc_nWid  = loc_oArea.Width - 14
708:                     loc_cCar  = ""
709: 
710:                     *-- Legado: ReadOnly = Not InList(pcEscolha,'INSERIR','ALTERAR')
711:                     loc_lEditavel = INLIST(UPPER(ALLTRIM(THIS.this_cTipoAcao)), "INSERIR", "ALTERAR")
712: 
713:                     THIS.this_lMontouCampos = .T.
714: 
715:                     SELECT cursor_4c_Ficha
716:                     GO TOP IN cursor_4c_Ficha
717:                     SCAN
718:                         *-- Troca de caracteristica: titulo + linha separadora
719:                         IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
720:                             loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
721:                             loc_nTop = loc_nTop + 1
722: 
723:                             loc_cObj = "lbl_4c_CarFicha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
724:                             loc_oArea.AddObject(loc_cObj, "Label")
725:                             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
726:                             WITH loc_oCtrl
727:                                 .AutoSize  = .F.
728:                                 .Top       = loc_nTop
729:                                 .Left      = 1
730:                                 .Width     = loc_nWid
731:                                 .Height    = 18
732:                                 .Caption   = PROPER(ALLTRIM(loc_cCar))
733:                                 .FontName  = "Tahoma"
734:                                 .FontSize  = 9
735:                                 .FontBold  = .T.
736:                                 .Alignment = 0
737:                                 .BackStyle = 0
738:                                 .ForeColor = RGB(0, 0, 128)
739:                                 .Visible   = .T.
740:                                 loc_nTop   = loc_nTop + .Height
741:                             ENDWITH
742: 
743:                             loc_cObj = "shp_4c_CarFicha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
744:                             loc_oArea.AddObject(loc_cObj, "Shape")
745:                             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
746:                             WITH loc_oCtrl
747:                                 .Top           = loc_nTop
748:                                 .Left          = 1
749:                                 .Width         = loc_nWid + 9
750:                                 .Height        = 2
751:                                 .SpecialEffect = 0
752:                                 .Visible       = .T.
753:                                 loc_nTop       = loc_nTop + .Height + 2
754:                             ENDWITH
755:                         ENDIF
756: 
757:                         *-- Pergunta (Descrs de SigPrCpP; sem cadastro, o CTits)
758:                         loc_cObj = "lbl_4c_Ficha" + ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
759:                         loc_oArea.AddObject(loc_cObj, "Label")
760:                         loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
761:                         WITH loc_oCtrl
762:                             .AutoSize  = .F.
763:                             .Top       = loc_nTop
764:                             .Left      = loc_nLef + 4
765:                             .Width     = loc_nWid - 10
766:                             .Height    = 14
767:                             .Caption   = PROPER(ALLTRIM(IIF(!EMPTY(NVL(cursor_4c_Ficha.descrs, "")), ;
768:                                                             NVL(cursor_4c_Ficha.descrs, ""), ;
769:                                                             NVL(cursor_4c_Ficha.ctits, ""))))
770:                             .FontName  = "Tahoma"
771:                             .FontSize  = 8
772:                             .FontBold  = .T.
773:                             .Alignment = 0
774:                             .BackStyle = 0
775:                             .ForeColor = RGB(0, 0, 128)

*-- Linhas 787 a 807:
787: 
788:                         IF UPPER(ALLTRIM(NVL(cursor_4c_Ficha.ctpdados, ""))) == "D"
789:                             *-- Legado: [fwget] com InputMask 99/99/9999,
790:                             *-- Format [E] e Value Ctod([])
791:                             loc_oArea.AddObject(loc_cObj, "TextBox")
792:                             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
793:                             WITH loc_oCtrl
794:                                 .Top         = loc_nTop
795:                                 .Left        = loc_nLef
796:                                 .Width       = 80
797:                                 .Height      = loc_nHei
798:                                 .Value       = {}
799:                                 *-- Format/InputMask transcritos do legado -
800:                                 *-- descartar o par faz o campo aceitar
801:                                 *-- qualquer coisa (regra #49). "E" = data no
802:                                 *-- formato britanico (dd/mm/aaaa)
803:                                 .Format      = "E"
804:                                 .InputMask   = "99/99/9999"
805:                                 .MaxLength   = 10
806:                                 *-- ReadOnly e de HabilitarCampos (fonte unica,
807:                                 *-- chamado no fim do SCAN). Campo de data nao

*-- Linhas 818 a 838:
818:                             loc_lRespFixa = THIS.RespostaEhFixa(loc_cDopes, ;
819:                                                 NVL(cursor_4c_Ficha.ccars, ""), ;
820:                                                 NVL(cursor_4c_Ficha.ctits, ""))
821: 
822:                             loc_oArea.AddObject(loc_cObj, "EditBox")
823:                             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
824:                             WITH loc_oCtrl
825:                                 .Top         = loc_nTop
826:                                 .Left        = loc_nLef
827:                                 .Width       = loc_nWid
828:                                 .Height      = loc_nHei
829:                                 .Value       = ""
830:                                 .ScrollBars  = 2
831:                                 *-- Resposta FIXA cadastrada (SigCdFtr.nResps =
832:                                 *-- 1) fica somente-leitura em QUALQUER modo: a
833:                                 *-- marca vai no .Tag para HabilitarCampos nao
834:                                 *-- destravar o campo depois. Tag de
835:                                 *-- TextBox/EditBox so aceita Character.
836:                                 .Tag         = IIF(loc_lRespFixa, "FIXA", "")
837:                                 .ToolTipText = loc_cPerg
838:                                 .Visible     = .T.

*-- Linhas 862 a 882:
862:                     *-- ao ScrollSlide para a barra de rolagem - sem frmbarcta
863:                     *-- portado ele nao tem funcao e seria um controle invisivel
864:                     *-- a mais na tela.
865:                     IF RECCOUNT("cursor_4c_Ficha") > 0
866:                         loc_oArea.AddObject("shp_4c_FichaFim", "Shape")
867:                         WITH THIS.cnt_4c_AreaFicha.shp_4c_FichaFim
868:                             .Top           = loc_nTop
869:                             .Left          = 1
870:                             .Width         = loc_nWid + 9
871:                             .Height        = 2
872:                             .SpecialEffect = 0
873:                             .Visible       = .T.
874:                         ENDWITH
875:                     ENDIF
876: 
877:                     *-- Legado: ReadOnly = Not InList(pcEscolha,'INSERIR',
878:                     *-- 'ALTERAR') aplicado controle a controle na criacao.
879:                     *-- Aqui num passe unico, DEPOIS do SCAN, para o criterio
880:                     *-- de edicao ter fonte unica e poder ser reaplicado se o
881:                     *-- modo mudar - e para a resposta FIXA (marcada no .Tag)
882:                     *-- continuar travada em qualquer modo.

*-- Linhas 898 a 1256:
898:             THIS.this_cMensagemErro = loc_oErro.Message
899:             MsgErro(loc_oErro.Message + CHR(13) + ;
900:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
901:                     "Procedure: " + loc_oErro.Procedure, ;
902:                     "Erro em Formsigopftc.MontarFichaTecnica")
903:         ENDTRY
904: 
905:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
906:             SELECT (loc_cArea)
907:         ENDIF
908: 
909:         RETURN loc_lSucesso
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * CarregarFichaTecnica - Joga as respostas do cursor nos campos montados
914:     * (carregafichatecnica legado)
915:     *
916:     * Legado:
917:     *     If ThisForm.CriouForm
918:     *         Select crTmpFicha
919:     *         Scan
920:     *             If( crTmpFicha.cTpDados <> [D] )
921:     *                 lcVal = Nvl(crTmpFicha.Resps, [])
922:     *             Else
923:     *                 lcVal = Nvl(Ctod(crTmpFicha.Resps),Ctod(''))
924:     *             Endif
925:     *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
926:     *             loObjForm1.&lcObj..Value = lcVal
927:     *             loObjForm1.&lcObj..Refresh
928:     *         EndScan
929:     *     EndIf
930:     *
931:     * A resposta vem de SigOpFtc (o Left Join de CarregarCaracteristicas): eh
932:     * a resposta JA cadastrada para a OPERACAO, nao a do cliente - a do cliente
933:     * mora em SigCdCet e eh o que GravarFichaTecnica grava.
934:     *
935:     * O par "le a linha do cursor / escreve na tela" eh exatamente o par
936:     * CarregarLinhaFichaNoBO + BOParaForm da Fase 8: o SCAN abaixo so percorre
937:     * e delega, para a escrita na tela ter UM lugar so (o mesmo que o form pai
938:     * usa se precisar repintar um campo isolado).
939:     *==========================================================================
940:     PROCEDURE CarregarFichaTecnica()
941:         LOCAL loc_cArea, loc_oErro
942: 
943:         loc_cArea = ALIAS()
944: 
945:         TRY
946:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
947:                 SELECT cursor_4c_Ficha
948:                 GO TOP IN cursor_4c_Ficha
949:                 SCAN
950:                     THIS.CarregarLinhaFichaNoBO()
951:                     THIS.BOParaForm()
952: 
953:                     *-- Volta a area do SCAN antes do SKIP implicito: os dois
954:                     *-- metodos acima nao trocam de work area hoje, mas
955:                     *-- reafirmar o alias eh o que impede que uma mudanca neles
956:                     *-- quebre o laco em silencio
957:                     SELECT cursor_4c_Ficha
958:                 ENDSCAN
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             THIS.this_cMensagemErro = loc_oErro.Message
963:             MsgErro(loc_oErro.Message + CHR(13) + ;
964:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
965:                     "Procedure: " + loc_oErro.Procedure, ;
966:                     "Erro em Formsigopftc.CarregarFichaTecnica")
967:         ENDTRY
968: 
969:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
970:             SELECT (loc_cArea)
971:         ENDIF
972:     ENDPROC
973: 
974:     *==========================================================================
975:     * DesmontarFichaTecnica - Remove os campos montados (desmontafichatecnica)
976:     *
977:     * Legado:
978:     *     If ThisForm.CriouForm And Used('crTmpFicha') And
979:     *        (ThisForm.pcEscolha <> [PROCURAR]) And ThisForm.MontouCampos
980:     *         ... RemoveObject de sayFicha/shpFicha (por caracteristica),
981:     *             lblFicha e memFicha (por linha) ...
982:     *         If (Reccount('crTmpFicha') > 0)
983:     *             RemoveObject shpFichaFim / sayFichaFim
984:     *         EndIf
985:     *         ThisForm.MontouCampos = .f.
986:     *     EndIf
987:     *
988:     * RemoveObject recebe o nome como STRING, entao nao precisa de EVALUATE -
989:     * mas precisa do PEMSTATUS antes: remover objeto inexistente estoura.
990:     *==========================================================================
991:     PROCEDURE DesmontarFichaTecnica()
992:         LOCAL loc_cArea, loc_cCar, loc_cObj, loc_cOrd, loc_oErro
993: 
994:         loc_cArea = ALIAS()
995: 
996:         TRY
997:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha") ;
998:                AND UPPER(ALLTRIM(THIS.this_cTipoAcao)) != "PROCURAR" ;
999:                AND THIS.this_lMontouCampos
1000: 
1001:                 loc_cCar = ""
1002: 
1003:                 SELECT cursor_4c_Ficha
1004:                 GO TOP IN cursor_4c_Ficha
1005:                 SCAN
1006:                     loc_cOrd = ALLTRIM(STR(NVL(cursor_4c_Ficha.cords, 0), 3))
1007: 
1008:                     IF loc_cCar != NVL(cursor_4c_Ficha.ccars, "")
1009:                         loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
1010: 
1011:                         loc_cObj = "lbl_4c_CarFicha" + loc_cOrd
1012:                         IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1013:                             THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
1014:                         ENDIF
1015: 
1016:                         loc_cObj = "shp_4c_CarFicha" + loc_cOrd
1017:                         IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1018:                             THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
1019:                         ENDIF
1020:                     ENDIF
1021: 
1022:                     loc_cObj = "lbl_4c_Ficha" + loc_cOrd
1023:                     IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1024:                         THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
1025:                     ENDIF
1026: 
1027:                     loc_cObj = "mem_4c_Ficha" + loc_cOrd
1028:                     IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1029:                         THIS.cnt_4c_AreaFicha.RemoveObject(loc_cObj)
1030:                     ENDIF
1031:                 ENDSCAN
1032: 
1033:                 IF RECCOUNT("cursor_4c_Ficha") > 0
1034:                     IF PEMSTATUS(THIS.cnt_4c_AreaFicha, "shp_4c_FichaFim", 5)
1035:                         THIS.cnt_4c_AreaFicha.RemoveObject("shp_4c_FichaFim")
1036:                     ENDIF
1037:                 ENDIF
1038: 
1039:                 THIS.this_lMontouCampos = .F.
1040:             ENDIF
1041: 
1042:         CATCH TO loc_oErro
1043:             THIS.this_cMensagemErro = loc_oErro.Message
1044:             MsgErro(loc_oErro.Message + CHR(13) + ;
1045:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1046:                     "Procedure: " + loc_oErro.Procedure, ;
1047:                     "Erro em Formsigopftc.DesmontarFichaTecnica")
1048:         ENDTRY
1049: 
1050:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1051:             SELECT (loc_cArea)
1052:         ENDIF
1053:     ENDPROC
1054: 
1055:     *==========================================================================
1056:     * ValidarFichaTecnica - Exige o tamanho MINIMO de cada resposta
1057:     * (validafichatecnica legado)
1058:     *
1059:     * Legado:
1060:     *     If Len(Alltrim(lcVal)) < crTmpFicha.Mins
1061:     *         lcMsgs = 'O Titulo ' + Alltrim(CTits) +
1062:     *                  ' da Caracteristica ' + Alltrim(CCars) + CRLF +
1063:     *                  'deve conter no minimo ' + Alltrim(Str(Mins)) +
1064:     *                  ' caracteres.'
1065:     *         MessageBox(lcMsgs,16,'')
1066:     *         Return(.f.)
1067:     *     EndIf
1068:     *
1069:     * Texto da mensagem transcrito do legado (que escreve "Titulo"/
1070:     * "Caracteristica"/"minimo" SEM acento - manter, para o usuario ler o
1071:     * mesmo de sempre). MsgAviso e nao MsgErro: eh validacao de preenchimento
1072:     * da tela, nao erro tecnico.
1073:     *
1074:     * PUBLIC: o form PAI chama antes de confirmar a movimentacao.
1075:     *==========================================================================
1076:     PROCEDURE ValidarFichaTecnica()
1077:         LOCAL loc_lValido, loc_cArea, loc_cVal, loc_cMsg, loc_oErro
1078: 
1079:         loc_lValido = .T.
1080:         loc_cArea   = ALIAS()
1081: 
1082:         TRY
1083:             IF USED("cursor_4c_Ficha")
1084:                 SELECT cursor_4c_Ficha
1085:                 GO TOP IN cursor_4c_Ficha
1086:                 SCAN WHILE loc_lValido
1087:                     *-- Mesmo leitor usado por GravarFichaTecnica/FormParaBO:
1088:                     *-- validar com uma conversao e gravar com outra eh como se
1089:                     *-- aprova o que depois nao entra
1090:                     loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
1091:                                                       NVL(cursor_4c_Ficha.ctpdados, ""))
1092: 
1093:                     IF LEN(ALLTRIM(loc_cVal)) < NVL(cursor_4c_Ficha.mins, 0)
1094:                         loc_cMsg = "O Titulo " + ALLTRIM(NVL(cursor_4c_Ficha.ctits, "")) + ;
1095:                                    " da Caracteristica " + ALLTRIM(NVL(cursor_4c_Ficha.ccars, "")) + ;
1096:                                    CHR(13) + CHR(10) + ;
1097:                                    "deve conter no minimo " + ;
1098:                                    ALLTRIM(STR(NVL(cursor_4c_Ficha.mins, 0), 3)) + ;
1099:                                    " caracteres."
1100:                         MsgAviso(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
1101:                         loc_lValido = .F.
1102:                     ENDIF
1103: 
1104:                     *-- Reafirma a area antes do SKIP implicito, igual aos
1105:                     *-- outros lacos do form
1106:                     SELECT cursor_4c_Ficha
1107:                 ENDSCAN
1108:             ENDIF
1109: 
1110:         CATCH TO loc_oErro
1111:             loc_lValido = .F.
1112:             THIS.this_cMensagemErro = loc_oErro.Message
1113:             MsgErro(loc_oErro.Message + CHR(13) + ;
1114:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1115:                     "Procedure: " + loc_oErro.Procedure, ;
1116:                     "Erro em Formsigopftc.ValidarFichaTecnica")
1117:         ENDTRY
1118: 
1119:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1120:             SELECT (loc_cArea)
1121:         ENDIF
1122: 
1123:         RETURN loc_lValido
1124:     ENDPROC
1125: 
1126:     *==========================================================================
1127:     * CarregarOperacaoComFicha - cursor_4c_Operacao (cnSigCdOpe legado)
1128:     *
1129:     * Legado (checarfichatecnica):
1130:     *     Select Distinct a.Dopes, a.TitOpes, b.CGrus as TemDados
1131:     *       From SigCdOpe a
1132:     *       Left Join SigCdFtc b On a.Dopes = b.CGrus
1133:     *      Where a.Dopes = '<Padr(Operacao,20)>' And b.nTipos = 2
1134:     *      Order By a.Dopes
1135:     *
1136:     * Colunas conferidas em docs/schema.sql (UTF-16, lido com Get-Content -Raw
1137:     * - regra #14): SigCdOpe.dopes char(20), SigCdOpe.titopes char(30),
1138:     * SigCdFtc.cgrus char(20), SigCdFtc.ntipos numeric(1,0).
1139:     *
1140:     * A comparacao usa PADR(...,20) sem ALLTRIM no meio: Dopes eh char(20) e a
1141:     * chave eh POSICIONAL (regra #42).
1142:     *==========================================================================
1143:     PROTECTED PROCEDURE CarregarOperacaoComFicha(par_cOperacao)
1144:         LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro
1145: 
1146:         loc_lSucesso = .F.
1147: 
1148:         TRY
1149:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1150:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1151:                         "Falha na Conex" + CHR(227) + "o (cursor_4c_Operacao)")
1152:             ELSE
1153:                 loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)
1154: 
1155:                 IF USED("cursor_4c_Operacao")
1156:                     IF CURSORGETPROP("Buffering", "cursor_4c_Operacao") > 1
1157:                         TABLEREVERT(.T., "cursor_4c_Operacao")
1158:                     ENDIF
1159:                     USE IN cursor_4c_Operacao
1160:                 ENDIF
1161: 
1162:                 loc_cSQL = "SELECT DISTINCT a.dopes, a.titopes, b.cgrus AS temdados" + ;
1163:                            "  FROM SigCdOpe a" + ;
1164:                            "  LEFT JOIN SigCdFtc b ON a.dopes = b.cgrus" + ;
1165:                            " WHERE a.dopes = " + EscaparSQL(loc_cDopes) + ;
1166:                            "   AND b.ntipos = 2" + ;
1167:                            " ORDER BY a.dopes"
1168: 
1169:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
1170: 
1171:                 IF loc_nResultado >= 0
1172:                     loc_lSucesso = .T.
1173:                 ELSE
1174:                     *-- Mesma mensagem do legado para falha de consulta
1175:                     MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
1176:                             CapturarErroSQL(), ;
1177:                             "Falha na Conex" + CHR(227) + "o (cursor_4c_Operacao)")
1178:                 ENDIF
1179:             ENDIF
1180: 
1181:         CATCH TO loc_oErro
1182:             loc_lSucesso = .F.
1183:             THIS.this_cMensagemErro = loc_oErro.Message
1184:             MsgErro(loc_oErro.Message + CHR(13) + ;
1185:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1186:                     "Procedure: " + loc_oErro.Procedure, ;
1187:                     "Erro em Formsigopftc.CarregarOperacaoComFicha")
1188:         ENDTRY
1189: 
1190:         RETURN loc_lSucesso
1191:     ENDPROC
1192: 
1193:     *==========================================================================
1194:     * CarregarCaracteristicas - cursor_4c_Ficha (crTmpFicha legado)
1195:     *
1196:     * Legado (montafichatecnica):
1197:     *     Select a.CCars, a.CTits, a.CLins, a.COrds, a.Maxs, a.Mins,
1198:     *            a.nChkCxas, a.cSelecaos, a.cTpDados, b.Resps, c.Descrs
1199:     *       From SigCdFtc a
1200:     *       Left Join SigOpFtc b On '<lcDopes>' + a.CCars + a.CTits = b.DopCarTits
1201:     *       Left Join SigPrCpP c on a.CTits = c.Codigos
1202:     *      Where a.CGrus = '<lcDopes>'
1203:     *        And a.SGrus = Space(6) And a.nTipos = 2
1204:     *      Order By a.COrds
1205:     *
1206:     * DopCarTits eh char(60) = dopes(20) + ccars(20) + ctits(20): chave
1207:     * POSICIONAL montada com PADR e sem ALLTRIM nas partes (regra #42) - o
1208:     * ALLTRIM no meio encurtaria a chave, o JOIN nao casaria e a resposta ja
1209:     * cadastrada da Operacao desapareceria SEM erro nenhum.
1210:     *
1211:     * O cursor sai READWRITE porque GravarFichaTecnica/CarregarFichaTecnica/
1212:     * ValidarFichaTecnica percorrem o alias - cursor de pass-through nasce
1213:     * somente-leitura. O nome e as colunas (cords, ctpdados, ccars, ctits) sao
1214:     * o CONTRATO que a Fase 4 ja documentou em GravarFichaTecnica.
1215:     *==========================================================================
1216:     PROTECTED PROCEDURE CarregarCaracteristicas(par_cOperacao)
1217:         LOCAL loc_lSucesso, loc_cSQL, loc_cDopes, loc_nResultado, loc_oErro
1218: 
1219:         loc_lSucesso = .F.
1220: 
1221:         TRY
1222:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1223:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1224:                         "Falha na Conex" + CHR(227) + "o (cursor_4c_Ficha)")
1225:             ELSE
1226:                 loc_cDopes = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20)
1227: 
1228:                 IF USED("cursor_4c_Ficha")
1229:                     IF CURSORGETPROP("Buffering", "cursor_4c_Ficha") > 1
1230:                         TABLEREVERT(.T., "cursor_4c_Ficha")
1231:                     ENDIF
1232:                     USE IN cursor_4c_Ficha
1233:                 ENDIF
1234: 
1235:                 loc_cSQL = "SELECT a.ccars, a.ctits, a.clins, a.cords, a.maxs," + ;
1236:                            "       a.mins, a.nchkcxas, a.cselecaos, a.ctpdados," + ;
1237:                            "       b.resps, c.descrs" + ;
1238:                            "  FROM SigCdFtc a" + ;
1239:                            "  LEFT JOIN SigOpFtc b" + ;
1240:                            "    ON " + EscaparSQL(loc_cDopes) + " + a.ccars + a.ctits = b.dopcartits" + ;
1241:                            "  LEFT JOIN SigPrCpP c" + ;
1242:                            "    ON a.ctits = c.codigos" + ;
1243:                            " WHERE a.cgrus = " + EscaparSQL(loc_cDopes) + ;
1244:                            "   AND a.sgrus = SPACE(6)" + ;
1245:                            "   AND a.ntipos = 2" + ;
1246:                            " ORDER BY a.cords"
1247: 
1248:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FichaTmp")
1249: 
1250:                 IF loc_nResultado >= 0
1251:                     SELECT * FROM cursor_4c_FichaTmp ;
1252:                         INTO CURSOR cursor_4c_Ficha READWRITE
1253: 
1254:                     IF USED("cursor_4c_FichaTmp")
1255:                         USE IN cursor_4c_FichaTmp
1256:                     ENDIF

*-- Linhas 1268 a 1311:
1268:             THIS.this_cMensagemErro = loc_oErro.Message
1269:             MsgErro(loc_oErro.Message + CHR(13) + ;
1270:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1271:                     "Procedure: " + loc_oErro.Procedure, ;
1272:                     "Erro em Formsigopftc.CarregarCaracteristicas")
1273:         ENDTRY
1274: 
1275:         RETURN loc_lSucesso
1276:     ENDPROC
1277: 
1278:     *==========================================================================
1279:     * RespostaEhFixa - .T. quando a pergunta tem resposta FIXA cadastrada
1280:     *
1281:     * Legado (montafichatecnica):
1282:     *     lcQryResp = [Select nResps from SigCdFtr where GruCarTits = ']
1283:     *                 + lcDopes + crTmpFicha.CCars + crTmpFicha.CTits + [']
1284:     *     If ThisForm.poDataMgr.SQLExecute(lcQryResp,[crResp]) < 1
1285:     *         MessageBox('Favor Reinicializar o Processo!!!') / Return .f.
1286:     *     EndIf
1287:     *     If !Eof([crResp]) and crResp.nResps == 1
1288:     *         llRespFixa = .T.
1289:     *     Endif
1290:     *
1291:     * SigCdFtr.grucartits eh char(66) e a comparacao do legado monta 60
1292:     * caracteres (dopes 20 + ccars 20 + ctits 20) - o SQL Server completa com
1293:     * branco na comparacao de char. Transcrito LITERALMENTE, com PADR em cada
1294:     * parte e sem ALLTRIM no meio (regra #42): acrescentar ou tirar padding
1295:     * mudaria o conjunto de linhas casadas.
1296:     *
1297:     * Falha de consulta devolve .F. (resposta editavel, como o legado deixaria
1298:     * llRespFixa) e ja exibiu a mensagem - nunca silencioso (regra #9).
1299:     *==========================================================================
1300:     PROTECTED FUNCTION RespostaEhFixa(par_cOperacao, par_cCcars, par_cCtits)
1301:         LOCAL loc_lFixa, loc_cSQL, loc_cChave, loc_nResultado, loc_cArea, loc_oErro
1302: 
1303:         loc_lFixa = .F.
1304:         loc_cArea = ALIAS()
1305: 
1306:         TRY
1307:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1308:                 loc_cChave = PADR(ALLTRIM(IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "")), 20) + ;
1309:                              PADR(ALLTRIM(IIF(VARTYPE(par_cCcars) = "C", par_cCcars, "")), 20) + ;
1310:                              PADR(ALLTRIM(IIF(VARTYPE(par_cCtits) = "C", par_cCtits, "")), 20)
1311: 

*-- Linhas 1357 a 1415:
1357:             THIS.this_cMensagemErro = loc_oErro.Message
1358:             MsgErro(loc_oErro.Message + CHR(13) + ;
1359:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1360:                     "Procedure: " + loc_oErro.Procedure, ;
1361:                     "Erro em Formsigopftc.RespostaEhFixa")
1362:         ENDTRY
1363: 
1364:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1365:             SELECT (loc_cArea)
1366:         ENDIF
1367: 
1368:         RETURN loc_lFixa
1369:     ENDFUNC
1370: 
1371:     *==========================================================================
1372:     * GravarFichaTecnica - Grava as respostas da ficha tecnica em SigCdCet
1373:     *
1374:     * Transcricao de SIGOPFTC.gravafichatecnica (task737). Trecho legado:
1375:     *     If ThisForm.CriouForm And Used("crTmpFicha")
1376:     *         loObjForm1 = ThisForm.poWindowOpe.ScrollBarContainer.ScrollSlide
1377:     *         Zap in crSigCdCeT
1378:     *         Select crTmpFicha
1379:     *         Scan
1380:     *             lcObj = [memFicha] + Alltrim(Str(crTmpFicha.COrds))
1381:     *             lcVal = loObjForm1.&lcObj..Value
1382:     *             If( crTmpFicha.cTpDados == [D] )
1383:     *                 lcVal = Dtoc(lcVal)
1384:     *             Endif
1385:     *             If Not Empty(lcVal)
1386:     *                 Select crSigCdCeT
1387:     *                 Go Top In crSigCdCeT
1388:     *                 Locate For IClis + CCars + CTits = <cliente> + CCars + CTits
1389:     *                 If Eof([crSigCdCeT])
1390:     *                     Insert Into crSigCdCeT (...) Values (..., NewIdChave())
1391:     *                 EndIf
1392:     *             EndIf
1393:     *         EndScan
1394:     *     EndIf
1395:     *     Return(.t.)
1396:     *
1397:     * Equivalencias (CONTRATO que a fase 5 tem de respeitar ao montar a ficha):
1398:     *   crTmpFicha        -> cursor_4c_Ficha, montado por MontarFichaTecnica;
1399:     *                        colunas usadas aqui: cords, ctpdados, ccars, ctits
1400:     *   memFicha<COrds>   -> mem_4c_Ficha<COrds>, filho de cnt_4c_AreaFicha,
1401:     *                        lido por EVALUATE porque o nome eh montado em
1402:     *                        runtime (regras #15 e #34: Controls(<nome>) nao
1403:     *                        funciona e EVALUATE eh a forma correta de LEITURA)
1404:     *   crSigCdCeT        -> cursor_4c_Respostas, respostas JA gravadas do
1405:     *                        cliente (CarregarRespostasGravadas)
1406:     *   crSigCdCli.IClis  -> THIS.this_cIclis, recebido no Init
1407:     *   Insert Into ...   -> sigopftcBO.NovoRegistro() + Salvar(), que faz o
1408:     *                        INSERT real em SigCdCet (NewIdChave -> fUniqueIds,
1409:     *                        regra #22). Inserir() eh PROTECTED no BO, por isso
1410:     *                        a chamada externa vai pelo par PUBLIC NovoRegistro/
1411:     *                        Salvar da BusinessBase (regra #51).
1412:     *
1413:     * DIVERGENCIA DELIBERADA, registrada: o "Zap in crSigCdCeT" do legado
1414:     * esvazia o CURSOR local de respostas antes do SCAN; a propagacao disso
1415:     * para a base depende do buffering do AddCursor Fortyus e nao ha evidencia

*-- Linhas 1423 a 1466:
1423:     * a carga das respostas existentes falhar ou se um INSERT recusar - e nesses
1424:     * casos a mensagem ja foi exibida (CarregarRespostasGravadas / regra #20).
1425:     *==========================================================================
1426:     PROCEDURE GravarFichaTecnica()
1427:         LOCAL loc_lSucesso, loc_cArea, loc_cVal
1428:         LOCAL loc_cCar, loc_cTit, loc_cCarCmp, loc_cTitCmp, loc_oErro
1429: 
1430:         loc_lSucesso = .T.
1431:         loc_cArea    = ALIAS()
1432: 
1433:         TRY
1434:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
1435:                 IF THIS.CarregarRespostasGravadas()
1436: 
1437:                     SELECT cursor_4c_Ficha
1438:                     GO TOP IN cursor_4c_Ficha
1439:                     SCAN
1440:                         loc_cCar = NVL(cursor_4c_Ficha.ccars, "")
1441:                         loc_cTit = NVL(cursor_4c_Ficha.ctits, "")
1442: 
1443:                         *-- Legado: lcVal = loObjForm1.&lcObj..Value, com
1444:                         *-- Dtoc() quando cTpDados = "D". LerRespostaDaTela eh
1445:                         *-- a fonte unica dessa leitura (a MESMA que
1446:                         *-- ValidarFichaTecnica e FormParaBO usam).
1447:                         loc_cVal = THIS.LerRespostaDaTela(NVL(cursor_4c_Ficha.cords, 0), ;
1448:                                                           NVL(cursor_4c_Ficha.ctpdados, ""))
1449: 
1450:                         IF !EMPTY(loc_cVal)
1451:                             loc_cCarCmp = UPPER(ALLTRIM(loc_cCar))
1452:                             loc_cTitCmp = UPPER(ALLTRIM(loc_cTit))
1453: 
1454:                             SELECT cursor_4c_Respostas
1455:                             GO TOP IN cursor_4c_Respostas
1456:                             LOCATE FOR UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ccars, ""))) == loc_cCarCmp ;
1457:                                    AND UPPER(ALLTRIM(NVL(cursor_4c_Respostas.ctits, ""))) == loc_cTitCmp
1458: 
1459:                             IF EOF("cursor_4c_Respostas")
1460:                                 *-- Volta ao cursor da ficha ANTES do
1461:                                 *-- FormParaBO: ele le a linha CORRENTE de
1462:                                 *-- cursor_4c_Ficha, e o LOCATE acima deixou a
1463:                                 *-- area em cursor_4c_Respostas
1464:                                 SELECT cursor_4c_Ficha
1465: 
1466:                                 *-- NovoRegistro() PRIMEIRO: ele chama

*-- Linhas 1510 a 1782:
1510:             THIS.this_cMensagemErro = loc_oErro.Message
1511:             MsgErro(loc_oErro.Message + CHR(13) + ;
1512:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1513:                     "Procedure: " + loc_oErro.Procedure, ;
1514:                     "Erro em Formsigopftc.GravarFichaTecnica")
1515:         ENDTRY
1516: 
1517:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1518:             SELECT (loc_cArea)
1519:         ENDIF
1520: 
1521:         RETURN loc_lSucesso
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     * CarregarRespostasGravadas - Monta cursor_4c_Respostas com as respostas
1526:     * JA gravadas em SigCdCet para o cliente corrente.
1527:     *
1528:     * Equivale ao cursor crSigCdCeT que o form pai legado mantinha aberto e que
1529:     * gravafichatecnica consulta com Locate antes de inserir. Precisa ser
1530:     * READWRITE porque GravarFichaTecnica acrescenta nele cada resposta que
1531:     * acabou de gravar, reproduzindo o "Insert Into crSigCdCeT" do legado - por
1532:     * isso o SQLEXEC vai num alias TEMPORARIO e o cursor final sai de
1533:     * SELECT ... INTO CURSOR ... READWRITE (cursor de pass-through nasce
1534:     * somente-leitura). O TABLEREVERT do fechamento vem guardado por
1535:     * CURSORGETPROP("Buffering"), senao estoura erro 1586 em cursor sem
1536:     * buffering (regra #52).
1537:     *==========================================================================
1538:     PROTECTED PROCEDURE CarregarRespostasGravadas()
1539:         LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
1540: 
1541:         loc_lSucesso = .F.
1542: 
1543:         TRY
1544:             IF EMPTY(ALLTRIM(THIS.this_cIclis))
1545:                 MsgAviso("Cliente n" + CHR(227) + "o informado - n" + CHR(227) + ;
1546:                          "o h" + CHR(225) + " como gravar a ficha t" + CHR(233) + "cnica.", ;
1547:                          "Aten" + CHR(231) + CHR(227) + "o")
1548:             ELSE
1549:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1550:                     MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
1551:                             "o estabelecida.", "Erro")
1552:                 ELSE
1553:                     IF USED("cursor_4c_Respostas")
1554:                         IF CURSORGETPROP("Buffering", "cursor_4c_Respostas") > 1
1555:                             TABLEREVERT(.T., "cursor_4c_Respostas")
1556:                         ENDIF
1557:                         USE IN cursor_4c_Respostas
1558:                     ENDIF
1559: 
1560:                     loc_cSQL = "SELECT iclis, ccars, ctits FROM SigCdCet" + ;
1561:                                " WHERE iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))
1562: 
1563:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_RespostasTmp")
1564: 
1565:                     IF loc_nResultado >= 0
1566:                         SELECT * FROM cursor_4c_RespostasTmp ;
1567:                             INTO CURSOR cursor_4c_Respostas READWRITE
1568: 
1569:                         IF USED("cursor_4c_RespostasTmp")
1570:                             USE IN cursor_4c_RespostasTmp
1571:                         ENDIF
1572: 
1573:                         loc_lSucesso = .T.
1574:                     ELSE
1575:                         MsgErro("Erro ao carregar as respostas j" + CHR(225) + ;
1576:                                 " gravadas da ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
1577:                                 CapturarErroSQL(), "Erro SQL")
1578:                     ENDIF
1579:                 ENDIF
1580:             ENDIF
1581: 
1582:         CATCH TO loc_oErro
1583:             loc_lSucesso = .F.
1584:             THIS.this_cMensagemErro = loc_oErro.Message
1585:             MsgErro(loc_oErro.Message + CHR(13) + ;
1586:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1587:                     "Procedure: " + loc_oErro.Procedure, ;
1588:                     "Erro em Formsigopftc.CarregarRespostasGravadas")
1589:         ENDTRY
1590: 
1591:         RETURN loc_lSucesso
1592:     ENDPROC
1593: 
1594:     *==========================================================================
1595:     * CarregarLista - Ponto UNICO de (re)carga da lista de caracteristicas da
1596:     * ficha tecnica: desmonta o que esta na tela, recarrega cursor_4c_Operacao
1597:     * e remonta/repinta os campos.
1598:     *
1599:     * Eh o bloco "If llOks / If Not Empty(ThisForm.Operacao)" do
1600:     * checarfichatecnica legado, extraido para ter ponto de recarga:
1601:     *     <query cnSigCdOpe>  -> CarregarOperacaoComFicha
1602:     *     Select cnSigCdOpe / Go Top
1603:     *     If Not This.MontaFichaTecnica(ThisForm.Operacao) / Return 0
1604:     *
1605:     * A "lista" deste dialogo eh a relacao de caracteristicas (cursor_4c_Ficha,
1606:     * o crTmpFicha legado), que o legado nao exibe em Grid e sim como uma pilha
1607:     * de pares pergunta/resposta - montada em runtime por MontarFichaTecnica.
1608:     * Nao ha Grid algum no SCX (4 objetos visuais, zero BaseClass grid), entao
1609:     * repintar aqui eh Refresh do container que hospeda a pilha, e nao
1610:     * GO TOP + Grid.Refresh de grade; o GO TOP no cursor fica, porque o
1611:     * MontarFichaTecnica e os metodos de gravacao/validacao percorrem o alias
1612:     * do inicio (regra #21a).
1613:     *
1614:     * DesmontarFichaTecnica PRIMEIRO, e por dois motivos: (a) remontar sobre
1615:     * controle que ja existe estoura "Object ... is already defined" e mata o
1616:     * dialogo - o legado deixa esse caminho aberto quando chamado com
1617:     * [GRUPO_OP] e pcEscolha <> INSERIR (divergencia declarada no cabecalho);
1618:     * (b) o Desmontar le o cursor_4c_Ficha ANTIGO para saber quais objetos
1619:     * remover, e CarregarCaracteristicas (dentro de MontarFichaTecnica)
1620:     * substitui esse cursor - desmontar depois nao acharia mais os nomes.
1621:     * DesmontarFichaTecnica ja se protege por this_lMontouCampos, logo a
1622:     * chamada eh no-op no caminho em que o legado desmonta antes.
1623:     *
1624:     * PUBLIC (sem PROTECTED): o harness TesteAutomatico.prg chama
1625:     * THIS.oForm.CarregarLista() de FORA da classe - regra #3 do CLAUDE.md.
1626:     *==========================================================================
1627:     PROCEDURE CarregarLista()
1628:         LOCAL loc_lSucesso, loc_cArea, loc_oErro
1629: 
1630:         loc_lSucesso = .F.
1631:         loc_cArea    = ALIAS()
1632: 
1633:         TRY
1634:             IF !THIS.this_lCriouForm
1635:                 *-- Sem o container dinamico nao ha onde montar a ficha. O
1636:                 *-- legado protege todo metodo de ficha com If ThisForm.CriouForm
1637:                 loc_lSucesso = .T.
1638:             ELSE
1639:                 *-- Remove a ficha anterior antes de trocar o cursor
1640:                 THIS.DesmontarFichaTecnica()
1641: 
1642:                 IF THIS.CarregarOperacaoComFicha(THIS.this_cOperacao)
1643:                     IF USED("cursor_4c_Operacao")
1644:                         SELECT cursor_4c_Operacao
1645:                         GO TOP IN cursor_4c_Operacao
1646:                     ENDIF
1647: 
1648:                     loc_lSucesso = THIS.MontarFichaTecnica(THIS.this_cOperacao)
1649: 
1650:                     *-- Popular cursor NAO repinta o que esta na tela
1651:                     *-- (regra #21a). Aqui o equivalente ao Grid.Refresh eh o
1652:                     *-- Refresh do container que hospeda a pilha de campos.
1653:                     IF USED("cursor_4c_Ficha")
1654:                         SELECT cursor_4c_Ficha
1655:                         GO TOP IN cursor_4c_Ficha
1656:                     ENDIF
1657: 
1658:                     THIS.cnt_4c_AreaFicha.Refresh()
1659:                 ENDIF
1660:             ENDIF
1661: 
1662:         CATCH TO loc_oErro
1663:             loc_lSucesso = .F.
1664:             THIS.this_cMensagemErro = loc_oErro.Message
1665:             MsgErro(loc_oErro.Message + CHR(13) + ;
1666:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1667:                     "Procedure: " + loc_oErro.Procedure, ;
1668:                     "Erro em Formsigopftc.CarregarLista")
1669:         ENDTRY
1670: 
1671:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1672:             SELECT (loc_cArea)
1673:         ENDIF
1674: 
1675:         RETURN loc_lSucesso
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * HabilitarCampos - Liga/desliga em bloco a edicao dos campos da ficha
1680:     *
1681:     * Legado (montafichatecnica, por controle, na criacao):
1682:     *     .ReadOnly = Not InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
1683:     * e, no ramo de texto, a resposta FIXA cadastrada tambem entra travada:
1684:     *     If !Eof([crResp]) and crResp.nResps == 1 / llRespFixa = .T.
1685:     *
1686:     * Aqui num passe UNICO sobre os campos montados, chamado no fim de
1687:     * MontarFichaTecnica. Resposta FIXA fica travada em QUALQUER modo: a marca
1688:     * eh o .Tag = "FIXA" posto na criacao do controle (o Tag de TextBox/EditBox
1689:     * so aceita Character, por isso a marca eh texto e nao logico).
1690:     *
1691:     * Varre por cursor_4c_Ficha e nao por ControlCount do container de
1692:     * proposito: o container tambem hospeda os Label/Shape da ficha, que nao
1693:     * tem ReadOnly - alcancar so os campos de resposta (os mem_4c_Ficha<COrds>)
1694:     * evita depender de PEMSTATUS por propriedade para distinguir.
1695:     *
1696:     * PUBLIC (sem PROTECTED): mesma razao de CarregarLista - o harness chama de
1697:     * fora da classe. NAO sobrescreve nada de FormBase (que nao declara
1698:     * HabilitarCampos), portanto nao ha escopo herdado a respeitar.
1699:     *==========================================================================
1700:     PROCEDURE HabilitarCampos(par_lHabilitar)
1701:         LOCAL loc_lHabilitar, loc_cArea, loc_oCtrl, loc_oErro
1702: 
1703:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1704:         loc_cArea      = ALIAS()
1705: 
1706:         TRY
1707:             IF THIS.this_lCriouForm AND USED("cursor_4c_Ficha")
1708:                 SELECT cursor_4c_Ficha
1709:                 GO TOP IN cursor_4c_Ficha
1710:                 SCAN
1711:                     loc_oCtrl = THIS.ObterControleResposta(NVL(cursor_4c_Ficha.cords, 0))
1712: 
1713:                     IF VARTYPE(loc_oCtrl) = "O"
1714:                         *-- Campo com resposta FIXA nunca destrava
1715:                         IF UPPER(ALLTRIM(NVL(loc_oCtrl.Tag, ""))) == "FIXA"
1716:                             loc_oCtrl.ReadOnly = .T.
1717:                         ELSE
1718:                             loc_oCtrl.ReadOnly = !loc_lHabilitar
1719:                         ENDIF
1720:                     ENDIF
1721: 
1722:                     SELECT cursor_4c_Ficha
1723:                 ENDSCAN
1724:             ENDIF
1725: 
1726:         CATCH TO loc_oErro
1727:             THIS.this_cMensagemErro = loc_oErro.Message
1728:             MsgErro(loc_oErro.Message + CHR(13) + ;
1729:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1730:                     "Procedure: " + loc_oErro.Procedure, ;
1731:                     "Erro em Formsigopftc.HabilitarCampos")
1732:         ENDTRY
1733: 
1734:         IF !EMPTY(loc_cArea) AND USED(loc_cArea)
1735:             SELECT (loc_cArea)
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * ObterControleResposta - Devolve o campo de resposta mem_4c_Ficha<COrds>
1741:     * (ou .NULL. quando a linha nao tem controle montado na tela)
1742:     *
1743:     * Fonte UNICA da montagem desse nome em runtime. Antes da Fase 8 o par
1744:     * PEMSTATUS + EVALUATE estava repetido em cinco metodos, e qualquer
1745:     * divergencia na forma de montar o sufixo (NVL, STR com largura diferente,
1746:     * ALLTRIM) faria um deles procurar um nome que outro nunca criou - defeito
1747:     * silencioso, porque PEMSTATUS apenas devolveria .F. e o campo seria
1748:     * ignorado.
1749:     *
1750:     * EVALUATE eh a forma correta de alcancar membro por NOME: Controls(<nome>)
1751:     * nao funciona (indexado por NUMERO - regra #34) e aqui o EVALUATE eh
1752:     * LEITURA, devolvendo a referencia do objeto (regra #15).
1753:     *
1754:     * NVL + STR com largura 3 reproduz o Alltrim(Str(crTmpFicha.COrds)) do
1755:     * legado: SigCdFtc.cords eh numeric(3,0) NULL-avel e STR(.NULL.) devolve
1756:     * .NULL., que propagaria pela concatenacao e estouraria no PEMSTATUS.
1757:     *==========================================================================
1758:     PROTECTED FUNCTION ObterControleResposta(par_nCords)
1759:         LOCAL loc_oCtrl, loc_cObj, loc_nCords
1760: 
1761:         loc_oCtrl = .NULL.
1762:         loc_nCords = IIF(VARTYPE(par_nCords) = "N", NVL(par_nCords, 0), 0)
1763: 
1764:         loc_cObj = "mem_4c_Ficha" + ALLTRIM(STR(loc_nCords, 3))
1765: 
1766:         IF PEMSTATUS(THIS.cnt_4c_AreaFicha, loc_cObj, 5)
1767:             loc_oCtrl = EVALUATE("THIS.cnt_4c_AreaFicha." + loc_cObj)
1768:         ENDIF
1769: 
1770:         RETURN loc_oCtrl
1771:     ENDFUNC
1772: 
1773:     *==========================================================================
1774:     * LerRespostaDaTela - Valor do campo de resposta JA normalizado para char
1775:     *
1776:     * Legado (gravafichatecnica e validafichatecnica, identicos):
1777:     *     lcVal = loObjForm1.&lcObj..Value
1778:     *     If( crTmpFicha.cTpDados == [D] ) / lcVal = Dtoc(lcVal) / Endif
1779:     *
1780:     * Fonte UNICA dessa conversao, que antes estava triplicada em
1781:     * GravarFichaTecnica, CarregarFichaTecnica e ValidarFichaTecnica - validar
1782:     * com uma conversao e gravar com outra aprovaria o que depois nao entra.

*-- Linhas 1831 a 1874:
1831:     * contexto recebido no Init, nao variam por linha, e FormParaBO os repoe
1832:     * depois do NovoRegistro().
1833:     *==========================================================================
1834:     PROTECTED PROCEDURE CarregarLinhaFichaNoBO()
1835:         IF !USED("cursor_4c_Ficha") OR EOF("cursor_4c_Ficha")
1836:             *-- Sem linha corrente nao ha o que transferir. Guarda por IF e
1837:             *-- nao por RETURN de saida antecipada (regra #1): este metodo eh
1838:             *-- chamado de dentro do TRY de CarregarFichaTecnica e do TRY de
1839:             *-- GravarFichaTecnica (via FormParaBO)
1840:         ELSE
1841:             WITH THIS.this_oBusinessObject
1842:                 .this_cCcars    = TratarNulo(cursor_4c_Ficha.ccars,     "")
1843:                 .this_cCtits    = TratarNulo(cursor_4c_Ficha.ctits,     "")
1844:                 .this_nClins    = TratarNulo(cursor_4c_Ficha.clins,     0)
1845:                 .this_nCords    = TratarNulo(cursor_4c_Ficha.cords,     0)
1846:                 .this_nMaxs     = TratarNulo(cursor_4c_Ficha.maxs,      0)
1847:                 .this_nMins     = TratarNulo(cursor_4c_Ficha.mins,      0)
1848:                 .this_cSelecaos = TratarNulo(cursor_4c_Ficha.cselecaos, "")
1849:                 .this_nChkCxas  = TratarNulo(cursor_4c_Ficha.nchkcxas,  0)
1850:                 .this_cTpDados  = TratarNulo(cursor_4c_Ficha.ctpdados,  "")
1851:                 .this_cDescrs   = TratarNulo(cursor_4c_Ficha.descrs,    "")
1852:                 .this_cResps    = TratarNulo(cursor_4c_Ficha.resps,     "")
1853: 
1854:                 *-- Nao vem no SELECT: eh o valor fixo do filtro de
1855:                 *-- CarregarCaracteristicas (a.sgrus = SPACE(6))
1856:                 .this_cSgrus    = SPACE(6)
1857:             ENDWITH
1858:         ENDIF
1859:     ENDPROC
1860: 
1861:     *==========================================================================
1862:     * FormParaBO - Campos da TELA + linha corrente da ficha -> properties do BO
1863:     *
1864:     * Reune, para a linha CORRENTE de cursor_4c_Ficha, o que o
1865:     * gravafichatecnica legado monta antes do Insert:
1866:     *     lcVal = loObjForm1.&lcObj..Value   (+ Dtoc se cTpDados = "D")
1867:     *     Insert Into crSigCdCeT (IClis, CCars, CTits, Resps, ...)
1868:     *            Values (crSigCdCli.IClis, crTmpFicha.CCars,
1869:     *                    crTmpFicha.CTits, lcVal, ..., NewIdChave())
1870:     * O IClis vem de THIS.this_cIclis (recebido no Init, equivalente ao cursor
1871:     * global crSigCdCli do form pai) e o cidchaves eh gerado por
1872:     * sigopftcBO.Inserir com fUniqueIds() (regra #22).
1873:     *
1874:     * Chamado DEPOIS de NovoRegistro(): aquele limpa as properties e liga

*-- Linhas 1938 a 1992:
1938:     *
1939:     * PROTECTED porque FormBase.BOParaForm eh PROTECTED (nao alargar escopo).
1940:     *==========================================================================
1941:     PROTECTED PROCEDURE BOParaForm()
1942:         LOCAL loc_oCtrl, loc_uVal
1943: 
1944:         loc_oCtrl = THIS.ObterControleResposta(THIS.this_oBusinessObject.this_nCords)
1945: 
1946:         IF VARTYPE(loc_oCtrl) = "O"
1947:             IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cTpDados)) == "D"
1948:                 *-- Legado: Nvl(Ctod(Resps), Ctod('')). ConverterParaData
1949:                 *-- normaliza DATE/DATETIME/CHAR e devolve data vazia quando
1950:                 *-- nao da para converter - TTOD estouraria erro 11 se a
1951:                 *-- property viesse como DATE (regra #16)
1952:                 loc_uVal = ConverterParaData(THIS.this_oBusinessObject.this_cResps)
1953:             ELSE
1954:                 loc_uVal = THIS.this_oBusinessObject.this_cResps
1955:             ENDIF
1956: 
1957:             loc_oCtrl.Value = loc_uVal
1958:             loc_oCtrl.Refresh()
1959:         ENDIF
1960:     ENDPROC
1961: 
1962:     *==========================================================================
1963:     * Destroy - Libera o Business Object. DODEFAULT no fim (rebuild menu).
1964:     *
1965:     * Fecha os cursores do dialogo. O TABLEREVERT vem guardado por
1966:     * CURSORGETPROP("Buffering"): cursor sem buffering estoura erro 1586 nele,
1967:     * e USE IN fecha o alias mesmo com buffer sujo (regra #52).
1968:     *==========================================================================
1969:     PROCEDURE Destroy()
1970:         LOCAL loc_i, loc_cCursor, loc_aCursores[4]
1971: 
1972:         loc_aCursores[1] = "cursor_4c_Respostas"
1973:         loc_aCursores[2] = "cursor_4c_Ficha"
1974:         loc_aCursores[3] = "cursor_4c_Operacao"
1975:         loc_aCursores[4] = "cursor_4c_RespFixa"
1976: 
1977:         FOR loc_i = 1 TO ALEN(loc_aCursores)
1978:             loc_cCursor = loc_aCursores[loc_i]
1979:             IF USED(loc_cCursor)
1980:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
1981:                     TABLEREVERT(.T., loc_cCursor)
1982:                 ENDIF
1983:                 USE IN (loc_cCursor)
1984:             ENDIF
1985:         ENDFOR
1986: 
1987:         THIS.this_oBusinessObject = .NULL.
1988: 
1989:         DODEFAULT()
1990:     ENDPROC
1991: 
1992: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopftcBO.prg):
*==============================================================================
* sigopftcBO.prg
*
* Business Object para sigopftc (Ficha de Complementos da Movimentacao)
* Dialogo filho MODAL, aberto por um form de movimentacao/pedido para
* coletar as respostas da "ficha tecnica" (caracteristicas) associadas a
* uma Operacao (SigCdOpe.Dopes), para o cliente corrente (crSigCdCli).
*
* O legado monta dinamicamente um campo por caracteristica cadastrada em
* SigCdFtc para a Operacao informada (join com SigOpFtc para a resposta
* padrao da operacao e com SigPrCpP para a descricao da pergunta), exibe
* esses campos num container com scroll (frmbarcta) e, ao confirmar, grava
* a resposta de cada caracteristica em SIGCDCET (chave: cidchaves; chave de
* negocio: IClis+CCars+CTits) num SCAN com Locate + Insert condicional -
* nao ha Update nem Delete no fluxo legado (MontaFichaTecnica/
* GravarFichaTecnica no Formsigopftc.prg).
*
* Nao ha, portanto, um unico registro "principal" no sentido de
* BusinessBase.Inserir()/Atualizar(): a persistencia real percorre o
* cursor de caracteristicas linha a linha. this_cTabela/this_cCampoChave
* abaixo documentam o alvo efetivo da gravacao (SIGCDCET/cidchaves), que
* e usado pelo metodo de gravacao em lote Formsigopftc.GravarFichaTecnica,
* que para cada linha chama NovoRegistro() + FormParaBO() + Salvar().
*==============================================================================

DEFINE CLASS sigopftcBO AS BusinessBase

    *-- Contexto recebido do form pai (Init legado: Lparameters pCnx, pcTipo,
    *-- pcDopes). pCnx (poDataMgr) nao e replicado aqui - o BO usa o handle
    *-- global gnConnHandle, como toda a nova arquitetura.
    this_cTipoAcao      = ""    && char - pcEscolha herdado do form pai (INSERIR/ALTERAR/CONSULTAR/PROCURAR)
    this_cOperacao      = ""    && char(20) - Dopes: codigo da Operacao (SigCdOpe.Dopes) cujas caracteristicas sao exibidas

    *-- Cliente ao qual a ficha pertence (equivalente a crSigCdCli no legado,
    *-- cursor global do form pai - aqui replicado como property porque o BO
    *-- precisa dele para montar a chave de SIGCDCET)
    this_cIclis         = ""    && char(10) - codigo do cliente (SigCdCli.IClis)

    *-- Linha corrente da caracteristica sendo exibida/respondida, espelhando
    *-- o cursor crTmpFicha (SigCdFtc + SigOpFtc + SigPrCpP) montado em
    *-- MontaFichaTecnica no legado
    this_cCcars         = ""    && char(20) - codigo da caracteristica (SigCdFtc.CCars)
    this_cCtits         = ""    && char(20) - codigo do titulo/pergunta (SigCdFtc.CTits)
    this_nClins         = 0     && numeric(2,0) - numero de linhas do campo de resposta (SigCdFtc.CLins)
    this_nCords         = 0     && numeric(3,0) - ordem de exibicao da caracteristica (SigCdFtc.COrds)
    this_nMaxs          = 0     && numeric(3,0) - tamanho maximo aceito na resposta (SigCdFtc.Maxs)
    this_nMins          = 0     && numeric(3,0) - tamanho minimo obrigatorio da resposta (SigCdFtc.Mins)
    this_cSgrus         = ""    && char(6)  - subgrupo da caracteristica (SigCdFtc.SGrus)
    this_cSelecaos      = ""    && char(1)  - "S" = pergunta com opcoes fixas de selecao (SigCdFtc.cSelecaos)
    this_nChkCxas       = 0     && numeric(1,0) - tipo de caixa de selecao da pergunta (SigCdFtc.nChkCxas)
    this_cTpDados       = ""    && char(1)  - tipo de dado da resposta: "D" = data, outro = texto (SigCdFtc.cTpDados)
    this_cDescrs        = ""    && char(40) - descricao da pergunta (SigPrCpP.Descrs, quando cadastrada)

    *-- Resposta da caracteristica corrente: SIGCDCET guarda a resposta do
    *-- cliente (gravada por GravaFichaTecnica), SigOpFtc guarda a resposta
    *-- padrao/ja existente da Operacao (lida no Join de MontaFichaTecnica)
    this_cResps         = ""    && memo/char - resposta digitada pelo usuario (SIGCDCET.Resps / SigOpFtc.Resps)
    this_cClicartits    = ""    && char(50) - chave concatenada IClis+CCars+CTits (SIGCDCET.CliCarTits)
    this_cCidchaves     = ""    && char(20) - chave unica do registro de resposta (SIGCDCET.cIdChaves), gerada por fUniqueIds() na gravacao

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        *-- Alvo real da gravacao em lote (Formsigopftc.GravarFichaTecnica).
        *-- Nao existe Inserir()/Atualizar() de registro unico neste BO: a
        *-- gravacao percorre o cursor de caracteristicas e insere em
        *-- SIGCDCET apenas as respostas nao vazias ainda nao cadastradas
        *-- para o cliente (mesmo criterio do legado Gravafichatecnica()).
        THIS.this_cTabela     = "SigCdCet"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da resposta corrente (SIGCDCET.cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarClicartits - Monta a chave POSICIONAL CliCarTits (IClis+CCars+CTits)
    *
    * SIGCDCET.clicartits char(50) = iclis char(10) + ccars char(20) +
    * ctits char(20). O legado concatena os valores das COLUNAS da tabela
    * (ja padded pelo SQL Server), nunca ALLTRIM das partes - regra da chave
    * posicional: ALLTRIM no meio da concatenacao quebra o casamento contra
    * o que esta gravado (ver CLAUDE.md regra #42 / MontarChaveEmpDopNums).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarClicartits()
        THIS.this_cClicartits = PADR(ALLTRIM(THIS.this_cIclis), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCcars), 20) + ;
                                 PADR(ALLTRIM(THIS.this_cCtits), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades da resposta a partir de um
    * cursor SELECT * FROM SigCdCet (uma resposta JA gravada do cliente).
    * NAO serve para cursor_4c_Ficha, que nao tem cidchaves/clicartits - a
    * leitura daquele cursor eh Formsigopftc.CarregarLinhaFichaNoBO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
                THIS.this_cIclis      = TratarNulo(iclis,      "")
                THIS.this_cCcars      = TratarNulo(ccars,      "")
                THIS.this_cCtits      = TratarNulo(ctits,      "")
                THIS.this_cClicartits = TratarNulo(clicartits, "")
                THIS.this_cResps      = TratarNulo(resps,      "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma resposta de caracteristica em SIGCDCET
    *
    * Equivalente ao "Insert Into crSigCdCeT (...)" de GravaFichaTecnica no
    * legado (Formsigopftc.GravarFichaTecnica chama via Salvar(), uma vez por caracteristica
    * respondida, so quando a LOCATE por IClis+CCars+CTits nao achou linha -
    * o legado NUNCA sobrescreve uma resposta ja gravada, so inclui a que
    * falta). cidchaves gerado por fUniqueIds() (regra #22 - chave Fortyus,
    * nunca string vazia) no lugar do NewIdChave() legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            THIS.MontarClicartits()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCet (iclis, ccars, ctits, resps, clicartits, cidchaves)
                VALUES (
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    <<EscaparSQL(THIS.this_cResps)>>,
                    <<EscaparSQL(THIS.this_cClicartits)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE da resposta em SIGCDCET, identificada por cidchaves
    *
    * O fluxo legado (GravaFichaTecnica) NUNCA atualiza uma resposta ja
    * gravada - a LOCATE por IClis+CCars+CTits so insere quando nao acha.
    * Este metodo existe pela convencao de BusinessBase (toda subclasse
    * expoe Inserir/Atualizar) e fica disponivel para uma correcao pontual
    * de resposta via cidchaves, sem alterar a chave de negocio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCet
                SET resps      = <<EscaparSQL(THIS.this_cResps)>>,
                    iclis      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10))>>,
                    ccars      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCcars), 20))>>,
                    ctits      = <<EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtits), 20))>>,
                    clicartits = <<EscaparSQL(THIS.this_cClicartits)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar resposta da ficha t" + CHR(233) + "cnica:" + CHR(13) + loc_oErro.Message, "sigopftcBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

