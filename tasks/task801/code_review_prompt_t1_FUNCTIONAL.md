# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_TAMANHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ProdutoExisteNoCadastro()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarTamanhosInformados()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-HEADER] Header Caption 'Descriçã' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Serviço, Quantidade, Valor, Moe, Total, , Descrição do Serviço. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopser.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4656 linhas total):

*-- Linhas 27 a 51:
27: *   pelo botao Retornar.
28: *
29: * Correspondencia legado -> migrado (objetos; ver tasks\task801\mapeamento.json)
30: *   SIGOPSER                       -> Formsigopser
31: *   SIGOPSER.shpBtnGs              -> shp_4c_ShpBtnGs                 (Fase 3)
32: *   SIGOPSER.cntSombra             -> cnt_4c_Sombra                   (Fase 3)
33: *   SIGOPSER.cntSombra.lblSombra   -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
34: *   SIGOPSER.cntSombra.lblTitulo   -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
35: *   SIGOPSER.cntTamanho            -> cnt_4c_Tamanho                  (Fase 3)
36: *   SIGOPSER.fwGrade               -> grd_4c_Dados                    (Fase 4)
37: *   SIGOPSER.cntOK                 -> cmg_4c_CntOK                    (Fase 4)
38: *   SIGOPSER.btnTotItens           -> cmd_4c_BtnTotItens              (Fase 4)
39: *   SIGOPSER.btnCotacao            -> cmd_4c_BtnCotacao               (Fase 4)
40: *   SIGOPSER.btnAltImps            -> cmd_4c_BtnAltImps               (Fase 4)
41: *   SIGOPSER.Label1                -> lbl_4c_Label1                   (Fase 5)
42: *   SIGOPSER.Get_Produto           -> txt_4c_Produto                  (Fase 5)
43: *   SIGOPSER.Get_Descricao         -> txt_4c_Descricao                (Fase 5)
44: *   SIGOPSER.Get_Mercs             -> txt_4c_Mercs                    (Fase 5)
45: *   SIGOPSER.cntTamanho.Label2     -> cnt_4c_Tamanho.lbl_4c_Label2    (Fase 5)
46: *   SIGOPSER.cntTamanho.Say43      -> cnt_4c_Tamanho.lbl_4c_Label43   (Fase 5)
47: *   SIGOPSER.cntTamanho.Say1       -> cnt_4c_Tamanho.lbl_4c_Label1    (Fase 5)
48: *   SIGOPSER.cntTamanho.getTamDe   -> cnt_4c_Tamanho.txt_4c_TamDe     (Fase 6)
49: *   SIGOPSER.cntTamanho.getTamPara -> cnt_4c_Tamanho.txt_4c_TamPara   (Fase 6)
50: *
51: * Correspondencia legado -> migrado (comportamento desta fase)

*-- Linhas 85 a 128:
85: * como informacao de diagnostico.
86: *
87: * Uso (o chamador se desabilita e eh reabilitado pelo botao Retornar):
88: *   loForm = CREATEOBJECT("Formsigopser", THISFORM, THISFORM.DataSessionId, ;
89: *                         llGarantia, llVlrZeroGarantia)
90: *   IF VARTYPE(loForm) = "O"
91: *       loForm.Show()        && modal: retorna quando o dialogo fecha
92: *   ENDIF
93: *==============================================================================
94: 
95: DEFINE CLASS Formsigopser AS FormBase
96: 
97:     *==========================================================================
98:     * Propriedades visuais - PILAR 1, transcritas do dump do SCX legado
99:     *
100:     *   DataSession = 2 / BorderStyle = 2 / Height = 600 / Width = 1050
101:     *   ShowTips = .T. / AutoCenter = .T. / Caption = "Servicos"
102:     *   ControlBox = .F. / Movable = .F. / TitleBar = 0 / WindowState = 2
103:     *   AlwaysOnTop = .T. / Picture = ..\framework\imagens\new_background.jpg
104:     *
105:     * Tres observacoes:
106:     *
107:     * (1) DataSession vai como 1 pelo motivo explicado no cabecalho do arquivo.
108:     *
109:     * (2) WindowType NAO eh declarado no dump (default 0), mas o Init legado
110:     *     faz "Thisform.WindowType = 1" ANTES de qualquer Show: o dialogo eh
111:     *     modal em producao. Declarar 1 na classe eh equivalente e evita
112:     *     depender da ordem de execucao do Init.
113:     *
114:     * (3) DoCreate = .T. do dump NAO eh transcrito: eh metadado de tempo de
115:     *     desenho do SCX/VCX e NAO existe como propriedade de Form em runtime
116:     *     (a lista real de propriedades da base class Form, em
117:     *     automation\propriedades_baseclasses.txt, nao traz DOCREATE) -
118:     *     atribui-la faria a tela nao abrir.
119:     *
120:     * Caption e Picture ficam em ConfigurarAparencia: o primeiro porque o texto
121:     * tem cedilha, que vem de CHR(), e o segundo porque depende da variavel
122:     * global gc_4c_CaminhoIcones - funcao e variavel nao podem aparecer em
123:     * inicializador de propriedade de DEFINE CLASS. O Caption declarado aqui eh
124:     * a versao sem acento, substituida em ConfigurarAparencia ANTES de os
125:     * labels do cabecalho o lerem.
126:     *==========================================================================
127:     this_cMensagemErro = ""
128:     DataSession = 1

*-- Linhas 233 a 335:
233:     * parametro ausente tambem devolve "L", entao sem PCOUNT() um .T. vindo do
234:     * chamador e a ausencia do argumento ficariam indistinguiveis.
235:     *--------------------------------------------------------------------------
236:     PROCEDURE Init(par_oFormChamador, par_nDataSession, par_lGarantia, par_lVlrZeroGarantia)
237:         LOCAL loc_lSucesso
238: 
239:         IF PCOUNT() >= 1 AND VARTYPE(par_oFormChamador) = "O"
240:             THIS.this_oFormChamador = par_oFormChamador
241: 
242:             *-- Legado: .ParentForm = poForm.parentform (o dono do documento)
243:             IF PEMSTATUS(par_oFormChamador, "ParentForm", 5)
244:                 IF VARTYPE(par_oFormChamador.ParentForm) = "O"
245:                     THIS.this_oFormPai = par_oFormChamador.ParentForm
246:                 ENDIF
247:             ENDIF
248: 
249:             *-- Chamador sem ParentForm proprio: ele mesmo eh o dono do documento
250:             IF ISNULL(THIS.this_oFormPai)
251:                 THIS.this_oFormPai = par_oFormChamador
252:             ENDIF
253:         ENDIF
254: 
255:         IF PCOUNT() >= 2 AND VARTYPE(par_nDataSession) = "N"
256:             THIS.this_nDataSessionPai = par_nDataSession
257:         ENDIF
258: 
259:         IF PCOUNT() >= 3 AND VARTYPE(par_lGarantia) = "L"
260:             THIS.this_lGarantia = par_lGarantia
261:         ENDIF
262: 
263:         IF PCOUNT() >= 4 AND VARTYPE(par_lVlrZeroGarantia) = "L"
264:             THIS.this_lValorZeroGarantia = par_lVlrZeroGarantia
265:         ENDIF
266: 
267:         loc_lSucesso = DODEFAULT()
268: 
269:         RETURN loc_lSucesso
270:     ENDPROC
271: 
272:     *--------------------------------------------------------------------------
273:     * InicializarForm - Hook chamado por FormBase.Init().
274:     *
275:     * Monta a estrutura base da tela na MESMA ordem de criacao do SCX legado
276:     * (shpBtnGs -> cntSombra -> ... -> cntTamanho). A ordem importa: objeto
277:     * criado depois desenha POR CIMA do criado antes, e aqui as faixas se
278:     * cruzam de fato - shpBtnGs ocupa Top 66..81 e a faixa do cabecalho ocupa
279:     * Top 0..80.
280:     *
281:     * O botao Retornar (cmg_4c_CntOK, Top = -2..83) tambem se sobrepoe a faixa
282:     * do cabecalho, e por isso eh criado DEPOIS dela.
283:     *
284:     * Os campos Produto/Descricao/Mercs e os rotulos entram
285:     * na Fase 5; os dois campos de tamanho dentro de cnt_4c_Tamanho, que tem
286:     * lookup em SigCdTam, foram acrescentados na Fase 6.
287:     *--------------------------------------------------------------------------
288:     PROTECTED PROCEDURE InicializarForm()
289:         LOCAL loc_lSucesso, loc_oErro
290: 
291:         loc_lSucesso = .F.
292: 
293:         TRY
294:             *-- Objeto de negocio (gerado nas Fases 1 e 2)
295:             THIS.this_oBusinessObject = CREATEOBJECT("sigopserBO")
296: 
297:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
298:                 *-- Aparencia da janela (fundo e titulo acentuado)
299:                 THIS.ConfigurarAparencia()
300: 
301:                 *-- Moldura decorativa sob a barra de botoes (shpBtnGs)
302:                 THIS.ConfigurarMoldura()
303: 
304:                 *-- Faixa cinza do cabecalho (cntSombra + os dois labels)
305:                 THIS.ConfigurarCabecalho()
306: 
307:                 *-- Grade de servicos (fwGrade); so a estrutura visual - o
308:                 *-- RecordSource e os ControlSource ficam em CarregarLista,
309:                 *-- porque os cursores ainda nao existem neste ponto
310:                 THIS.ConfigurarGrade()
311: 
312:                 *-- Os tres botoes de servico (btnTotItens / btnCotacao /
313:                 *-- btnAltImps), que nascem OCULTOS como no SCX legado
314:                 THIS.ConfigurarBotoesServico()
315: 
316:                 *-- Botao Retornar (cntOK); vem DEPOIS do cabecalho porque se
317:                 *-- sobrepoe a faixa (Top = -2..83 contra 0..80) e precisa
318:                 *-- desenhar por cima dela
319:                 THIS.ConfigurarBotaoRetornar()
320: 
321:                 *-- Painel "Tamanho" (cntTamanho); os dois campos com lookup
322:                 *-- em SigCdTam foram acrescentados a ele na Fase 6
323:                 *-- (ConfigurarCamposTamanho, chamada logo abaixo)
324:                 THIS.ConfigurarPainelTamanho()
325: 
326:                 *-- Rotulo "Produto", os tres campos de identificacao do
327:                 *-- produto (Get_Produto/Get_Descricao/Get_Mercs) e os tres
328:                 *-- rotulos internos de cnt_4c_Tamanho (Tamanho/De:/Para:).
329:                 *-- Vem DEPOIS de ConfigurarPainelTamanho porque os tres
330:                 *-- ultimos sao AddObject DENTRO de cnt_4c_Tamanho, que
331:                 *-- precisa existir primeiro.
332:                 THIS.ConfigurarCamposProduto()
333: 
334:                 *-- Os dois campos de tamanho (getTamDe/getTamPara) dentro de
335:                 *-- cnt_4c_Tamanho, com lookup em SigCdTam. Vem DEPOIS de

*-- Linhas 350 a 546:
350:                 THIS.DesabilitarChamador()
351: 
352:                 *-- AddObject cria todo controle com Visible = .F.
353:                 THIS.TornarControlesVisiveis(THIS)
354: 
355:                 *-- Legado: Get_Produto/Get_Descricao/Get_Mercs tem "Return .f."
356:                 *-- no When - sao campos de exibicao. Vem DEPOIS de
357:                 *-- TornarControlesVisiveis, que percorre a tela inteira.
358:                 THIS.AplicarGatesDeEdicao()
359: 
360:                 *-- Handlers dos quatro botoes do legado e da troca de linha da
361:                 *-- grade. ANTES de CarregarLista para que a grade ja chegue
362:                 *-- posicionada com o painel "Tamanho" acompanhando a linha.
363:                 THIS.VincularEventosPrincipais()
364: 
365:                 *-- Legado (fim do Init): monta csTmpDesc, le a configuracao da
366:                 *-- operacao, liga a grade aos cursores e a posiciona. Vai por
367:                 *-- ULTIMO porque depende da grade e do contexto do movimento ja
368:                 *-- montados acima, e porque o legado tambem o faz no fim.
369:                 *-- Falha de carga NAO impede a tela de abrir (o legado tambem
370:                 *-- segue adiante com a grade vazia).
371:                 THIS.CarregarLista()
372: 
373:                 *-- Legado (fim do Init, logo apos o Scan de iconfs):
374:                 *--   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
375:                 *--   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
376:                 *-- A VISIBILIDADE do painel NAO eh tocada aqui: o legado so a
377:                 *-- decide no primeiro AfterRowColChange, e antecipa-la mudaria
378:                 *-- o que o usuario ve ao abrir a tela.
379:                 THIS.CarregarValoresTamanhoDaLinha()
380: 
381:                 *-- Os When dos tres botoes de servico, que dependem do modo e
382:                 *-- da linha corrente - ambos ja resolvidos neste ponto
383:                 THIS.AtualizarEstadoBotoesServico()
384: 
385:                 loc_lSucesso = .T.
386:             ELSE
387:                 THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
388:                                           "vel criar o objeto de neg" + CHR(243) + ;
389:                                           "cio sigopserBO"
390:                 MsgErro(THIS.this_cMensagemErro, "Erro ao Inicializar")
391:             ENDIF
392:         CATCH TO loc_oErro
393:             THIS.this_cMensagemErro = loc_oErro.Message
394:             MsgErro(loc_oErro.Message + CHR(13) + ;
395:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
396:                     "Procedure: " + loc_oErro.Procedure, ;
397:                     "Erro ao inicializar Formsigopser")
398:         ENDTRY
399: 
400:         RETURN loc_lSucesso
401:     ENDPROC
402: 
403:     *--------------------------------------------------------------------------
404:     * ConfigurarAparencia - Propriedades visuais da janela que dependem de
405:     * funcao ou de variavel global e por isso nao cabem no bloco de declaracao
406:     * da classe.
407:     *
408:     * Legado: Picture = ..\framework\imagens\new_background.jpg
409:     *         Caption = "Servicos" (com cedilha)
410:     *
411:     * O caminho vem de gc_4c_CaminhoIcones (vbmp\), onde new_background.jpg
412:     * existe - NUNCA remontar o caminho a partir de gc_4c_CaminhoBase. Sem
413:     * guard IF FILE(): o arquivo existe no acervo, e esconder a ausencia de
414:     * imagem atras de um guard eh justamente o que faz o fundo desaparecer em
415:     * silencio.
416:     *
417:     * O Caption eh trocado AQUI, antes de ConfigurarCabecalho, porque os dois
418:     * labels da faixa copiam THIS.Caption.
419:     *--------------------------------------------------------------------------
420:     PROTECTED PROCEDURE ConfigurarAparencia()
421:         THIS.Caption = "Servi" + CHR(231) + "os"
422:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
423: 
424:         RETURN
425:     ENDPROC
426: 
427:     *--------------------------------------------------------------------------
428:     * ConfigurarMoldura - shpBtnGs do legado.
429:     *
430:     * Legado: shpBtnGs Top=66 Left=12 Height=15 Width=258
431:     *                  BackStyle=0 BorderStyle=0 BorderColor=36,84,155
432:     *
433:     * Transcricao literal: com BackStyle = 0 (transparente) e BorderStyle = 0
434:     * (sem linha) o retangulo nao pinta nada - eh a area que o Form Designer
435:     * reservou sob a barra dos tres botoes de servico (Top = 87). Mantido por
436:     * fidelidade e criado ANTES da faixa do cabecalho, que eh a ordem do SCX.
437:     *
438:     * Shape NAO tem ForeColor - a cor da borda eh BorderColor e a do interior
439:     * eh FillColor; atribuir ForeColor aqui faria a tela nao abrir. O ZOrderSet
440:     * do dump tambem nao eh transcrito: eh metadado do Form Designer, sem
441:     * equivalente de propriedade em runtime (o equivalente eh o METODO
442:     * ZOrder(), que o legado nao chama).
443:     *--------------------------------------------------------------------------
444:     PROTECTED PROCEDURE ConfigurarMoldura()
445:         THIS.AddObject("shp_4c_ShpBtnGs", "Shape")
446: 
447:         WITH THIS.shp_4c_ShpBtnGs
448:             .Top         = 66
449:             .Left        = 12
450:             .Height      = 15
451:             .Width       = 258
452:             .BackStyle   = 0
453:             .BorderStyle = 0
454:             .BorderColor = RGB(36, 84, 155)
455:             .Visible     = .T.
456:         ENDWITH
457: 
458:         RETURN
459:     ENDPROC
460: 
461:     *--------------------------------------------------------------------------
462:     * ConfigurarCabecalho - Faixa cinza do titulo (cntSombra do legado).
463:     *
464:     * Legado:
465:     *   cntSombra            Top=0  Left=0  Width=1052 Height=80
466:     *                        BorderWidth=0 BackColor=100,100,100
467:     *   cntSombra.lblSombra  Top=18 Left=10 Width=769 Height=40 ForeColor=0,0,0
468:     *   cntSombra.lblTitulo  Top=17 Left=10 Width=769 Height=46 ForeColor=255,255,255
469:     *   ambos: Tahoma 18 bold, WordWrap=.T., Alignment=0, BackStyle=0
470:     *
471:     * Dois desvios DELIBERADOS do literal do dump:
472:     *
473:     * (1) WIDTH do container - o SCX declara 1052 num form de 1050, ou seja a
474:     *     faixa nasce 2px mais larga que a janela e seria RECORTADA pela borda.
475:     *     Usa-se THIS.Width, o equivalente responsivo. A largura dos LABELS
476:     *     (769) fica literal: cabe dentro do form e eh a medida que o Designer
477:     *     calculou.
478:     *
479:     * (2) CAPTION - o dump traz "Cadastro de Testes" nos dois labels, texto de
480:     *     template que ficou no SCX (o ToolTipText do lblTitulo ainda diz
481:     *     "Titulo do Relatorio"). O proprio Init legado sobrescreve os dois com
482:     *     ThisForm.Caption, que eh o que o usuario le.
483:     *
484:     * AutoSize = .F. explicito: AutoSize eh no-op em Label criado por
485:     * AddObject e, com WordWrap = .T., chega a DESCARTAR a Height - o par
486:     * Width/Height transcrito do SCX ja eh o tamanho calculado pelo Designer.
487:     *
488:     * ForeColor branco eh legitimo aqui: lbl_4c_LblTitulo fica dentro de
489:     * container OPACO escuro (BackStyle = 1 + BackColor RGB(100,100,100)).
490:     *--------------------------------------------------------------------------
491:     PROTECTED PROCEDURE ConfigurarCabecalho()
492:         THIS.AddObject("cnt_4c_Sombra", "Container")
493: 
494:         WITH THIS.cnt_4c_Sombra
495:             .Top           = 0
496:             .Left          = 0
497:             .Width         = THIS.Width
498:             .Height        = 80
499:             .BorderWidth   = 0
500:             .BackStyle     = 1
501:             .BackColor     = RGB(100, 100, 100)
502:             .SpecialEffect = 0
503:             .Visible       = .T.
504:         ENDWITH
505: 
506:         *-- Label de sombra (preto, 1px abaixo do titulo - efeito de relevo)
507:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
508: 
509:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
510:             .AutoSize      = .F.
511:             .FontName      = "Tahoma"
512:             .FontSize      = 18
513:             .FontBold      = .T.
514:             .FontUnderline = .F.
515:             .WordWrap      = .T.
516:             .Alignment     = 0
517:             .BackStyle     = 0
518:             .Caption       = THIS.Caption
519:             .Top           = 18
520:             .Left          = 10
521:             .Width         = 769
522:             .Height        = 40
523:             .ForeColor     = RGB(0, 0, 0)
524:             .Rotation      = 0
525:             .Visible       = .T.
526:         ENDWITH
527: 
528:         *-- Label do titulo (branco sobre o cinza do container)
529:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
530: 
531:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
532:             .AutoSize    = .F.
533:             .FontName    = "Tahoma"
534:             .FontSize    = 18
535:             .FontBold    = .T.
536:             .WordWrap    = .T.
537:             .Alignment   = 0
538:             .BackStyle   = 0
539:             .Caption     = THIS.Caption
540:             .Top         = 17
541:             .Left        = 10
542:             .Width       = 769
543:             .Height      = 46
544:             .ForeColor   = RGB(255, 255, 255)
545:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
546:             .Rotation    = 0

*-- Linhas 582 a 974:
582:     * ControlSource, a InputMask calculada da coluna VALOR e o DynamicForeColor
583:     * da coluna QTD ficam em CarregarLista: neste ponto do Init os cursores do
584:     * chamador ainda nao foram alcancados e amarrar Column.ControlSource a um
585:     * alias inexistente derruba o Init - o CREATEOBJECT devolveria .F. e o
586:     * usuario acionaria o menu sem nada acontecer.
587:     *
588:     * GRID NASCE AUTO-LIGADO AO ALIAS CORRENTE - E ISSO GRAVA NO CURSOR
589:     * ---------------------------------------------------------------
590:     * Medido no VFP9: AddObject("grd", "Grid") com um alias selecionado devolve
591:     * a grade JA ligada a ele - RecordSourceType = 1 e RecordSource com o nome
592:     * do alias, ColumnCount igual ao numero de campos do cursor. Ao reduzir o
593:     * ColumnCount para 7 as colunas continuam ligadas, cada uma a um campo do
594:     * cursor acidental (Column1 -> 1o campo, Column2 -> 2o, ...). A partir dai
595:     * QUALQUER atribuicao a Column<N>.Text1.Value ESCREVE no cursor atraves do
596:     * vinculo. Com as duas que o dump pede (Column5 e Column6 com Value = 0) o
597:     * resultado medido foi o 5o campo do cursor corrente virando 0 e o 6o
598:     * virando "0" - sem erro, sem log, sem aviso. Este dialogo abre a partir de
599:     * um form de movimento e roda na sessao de dados DELE, entao o alias
600:     * corrente eh um cursor VIVO do documento: o estrago seria corromper dois
601:     * campos do registro corrente do chamador so por abrir a tela.
602:     *
603:     * Por isso, logo depois do ColumnCount, o vinculo acidental eh desfeito -
604:     * RecordSource vazio e ControlSource de TODAS as colunas em branco - ANTES
605:     * de qualquer propriedade de Text1. Medido: com o vinculo desfeito o cursor
606:     * fica intacto, o ColumnCount continua 7, e a ligacao de verdade feita em
607:     * CarregarLista funciona normalmente. Isso tambem evita que a grade EXIBA um
608:     * cursor alheio quando a tela abre sem os cursores do chamador (ai
609:     * VincularGrade sai cedo e, sem esta limpeza, a grade mostraria o que
610:     * estivesse selecionado).
611:     *
612:     * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh o canonico dos
613:     * grids criados por AddObject em form OPERACIONAL, e sem ele a barra de
614:     * marcacao aparece na lateral esquerda, que o legado nao tem.
615:     *
616:     * O TabIndex = 5 do dump NAO eh transcrito aqui de proposito: com AddObject
617:     * o VFP9 numera pela ordem de criacao, e atribuir um valor isolado (ou
618:     * duplicado, ou fora da faixa de controles que ja existem) eh DESCARTADO em
619:     * silencio. A ordem de tabulacao exige um passe unico sobre TODOS os
620:     * controles focalizaveis, em ordem ascendente, depois do ultimo AddObject -
621:     * o que so pode acontecer quando os campos da Fase 5 existirem.
622:     *--------------------------------------------------------------------------
623:     PROTECTED PROCEDURE ConfigurarGrade()
624:         LOCAL loc_nI
625: 
626:         THIS.AddObject("grd_4c_Dados", "Grid")
627: 
628:         *-- Desfaz o vinculo que a grade herda do alias corrente (ver nota
629:         *-- acima): sem isto, as atribuicoes a Text1.Value abaixo GRAVAM no
630:         *-- cursor do chamador. Tem de vir ANTES de tudo o que mexe em Text1.
631:         THIS.grd_4c_Dados.ColumnCount  = 7
632:         THIS.grd_4c_Dados.RecordSource = ""
633: 
634:         FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
635:             THIS.grd_4c_Dados.Columns(loc_nI).ControlSource = ""
636:         ENDFOR
637: 
638:         WITH THIS.grd_4c_Dados
639:             .Top                = 172
640:             .Left               = 12
641:             .Width              = 986
642:             .Height             = 408
643:             .FontName           = "Tahoma"
644:             .FontSize           = 8
645:             .AllowHeaderSizing  = .F.
646:             .AllowRowSizing     = .F.
647:             .DeleteMark         = .F.
648:             .RecordMark         = .F.
649:             .HeaderHeight       = 20
650:             .RowHeight          = 18
651:             .ScrollBars         = 2
652:             .GridLineColor      = RGB(238, 238, 238)
653:             .HighlightBackColor = RGB(90, 90, 90)
654:             .ToolTipText        = "Grade de Itens"
655:             .Visible            = .T.
656:         ENDWITH
657: 
658:         *-- Column1 = PRODUTO ("Servico") - codigo do servico, char(14) na
659:         *-- tabela; o dump limita a digitacao em 10 (MaxLength do Text1), que eh
660:         *-- o que se transcreve - 10 cabe em char(14) e nao trunca na gravacao
661:         WITH THIS.grd_4c_Dados.Column1
662:             .FontName    = "Verdana"
663:             .FontSize    = 8
664:             .ColumnOrder = 2
665:             .Width       = 120
666:             .Movable     = .F.
667:             .Resizable   = .F.
668:             .Format      = "K!"
669:             .InputMask   = "!!!!!!!!!!"
670:             .Visible     = .T.
671:         ENDWITH
672: 
673:         WITH THIS.grd_4c_Dados.Column1.Header1
674:             .FontName  = "Verdana"
675:             .FontSize  = 8
676:             .Alignment = 2
677:             .Caption   = "Servi" + CHR(231) + "o"
678:         ENDWITH
679: 
680:         WITH THIS.grd_4c_Dados.Column1.Text1
681:             .FontName    = "Verdana"
682:             .FontSize    = 8
683:             .BorderStyle = 0
684:             .Format      = "K!"
685:             .InputMask   = "!!!!!!!!!!"
686:             .Margin      = 0
687:             .MaxLength   = 10
688:             .ReadOnly    = .F.
689:             .ForeColor   = RGB(0, 0, 0)
690:             .BackColor   = RGB(255, 255, 255)
691:             .Visible     = .T.
692:         ENDWITH
693: 
694:         *-- Column2 = QTD ("Quantidade")
695:         WITH THIS.grd_4c_Dados.Column2
696:             .FontName    = "Verdana"
697:             .FontSize    = 8
698:             .ColumnOrder = 4
699:             .Width       = 120
700:             .Movable     = .F.
701:             .Resizable   = .F.
702:             .InputMask   = "99999.999"
703:             .Visible     = .T.
704:         ENDWITH
705: 
706:         WITH THIS.grd_4c_Dados.Column2.Header1
707:             .FontName  = "Verdana"
708:             .FontSize  = 8
709:             .Alignment = 2
710:             .Caption   = "Quantidade"
711:         ENDWITH
712: 
713:         WITH THIS.grd_4c_Dados.Column2.Text1
714:             .FontName    = "Verdana"
715:             .FontSize    = 8
716:             .BorderStyle = 0
717:             .InputMask   = "99999.999"
718:             .Margin      = 0
719:             .ReadOnly    = .F.
720:             .ForeColor   = RGB(0, 0, 0)
721:             .BackColor   = RGB(255, 255, 255)
722:             .Visible     = .T.
723:         ENDWITH
724: 
725:         *-- Column3 = VALOR ("Valor"); a InputMask definitiva eh calculada em
726:         *-- CarregarLista a partir das casas decimais da operacao, como no
727:         *-- legado. A do dump fica aqui para a grade nao abrir sem mascara caso
728:         *-- a configuracao da operacao nao esteja disponivel.
729:         WITH THIS.grd_4c_Dados.Column3
730:             .FontName    = "Verdana"
731:             .FontSize    = 8
732:             .Bound       = .T.
733:             .ColumnOrder = 5
734:             .Width       = 120
735:             .Movable     = .F.
736:             .Resizable   = .F.
737:             .InputMask   = "9999,999.99"
738:             .Visible     = .T.
739:         ENDWITH
740: 
741:         WITH THIS.grd_4c_Dados.Column3.Header1
742:             .FontName  = "Verdana"
743:             .FontSize  = 8
744:             .Alignment = 2
745:             .Caption   = "Valor"
746:         ENDWITH
747: 
748:         WITH THIS.grd_4c_Dados.Column3.Text1
749:             .FontName    = "Verdana"
750:             .FontSize    = 8
751:             .BorderStyle = 0
752:             .InputMask   = "9999,999.99"
753:             .Margin      = 0
754:             .ReadOnly    = .F.
755:             .ForeColor   = RGB(0, 0, 0)
756:             .BackColor   = RGB(255, 255, 255)
757:             .Visible     = .T.
758:         ENDWITH
759: 
760:         *-- Column4 = MOEDA ("Moe") - o dump NAO declara InputMask nesta coluna
761:         WITH THIS.grd_4c_Dados.Column4
762:             .FontName    = "Verdana"
763:             .FontSize    = 8
764:             .Bound       = .T.
765:             .ColumnOrder = 6
766:             .Width       = 33
767:             .Movable     = .F.
768:             .Resizable   = .F.
769:             .Visible     = .T.
770:         ENDWITH
771: 
772:         WITH THIS.grd_4c_Dados.Column4.Header1
773:             .FontName  = "Verdana"
774:             .FontSize  = 8
775:             .Alignment = 2
776:             .Caption   = "Moe"
777:         ENDWITH
778: 
779:         WITH THIS.grd_4c_Dados.Column4.Text1
780:             .FontName    = "Verdana"
781:             .FontSize    = 8
782:             .BorderStyle = 0
783:             .Margin      = 0
784:             .ReadOnly    = .F.
785:             .ForeColor   = RGB(0, 0, 0)
786:             .BackColor   = RGB(255, 255, 255)
787:             .Visible     = .T.
788:         ENDWITH
789: 
790:         *-- Column5 = TOTAL ("Total"); o dump traz InputMask "999999,999.99" na
791:         *-- Column e "999,999,999.99" no Text1 - os dois sao transcritos como
792:         *-- estao, porque eh o Text1 que desenha a celula
793:         WITH THIS.grd_4c_Dados.Column5
794:             .FontName    = "Verdana"
795:             .FontSize    = 8
796:             .ColumnOrder = 7
797:             .Width       = 120
798:             .Movable     = .F.
799:             .Resizable   = .F.
800:             .InputMask   = "999999,999.99"
801:             .Visible     = .T.
802:         ENDWITH
803: 
804:         WITH THIS.grd_4c_Dados.Column5.Header1
805:             .FontName  = "Verdana"
806:             .FontSize  = 8
807:             .Alignment = 2
808:             .Caption   = "Total"
809:         ENDWITH
810: 
811:         WITH THIS.grd_4c_Dados.Column5.Text1
812:             .FontName    = "Verdana"
813:             .FontSize    = 8
814:             .Alignment   = 3
815:             .BorderStyle = 0
816:             .Value       = 0
817:             .InputMask   = "999,999,999.99"
818:             .Margin      = 0
819:             .ReadOnly    = .F.
820:             .ForeColor   = RGB(0, 0, 0)
821:             .BackColor   = RGB(255, 255, 255)
822:             .Visible     = .T.
823:         ENDWITH
824: 
825:         *-- Column6 = item (numero sequencial da linha, sem caption no header)
826:         WITH THIS.grd_4c_Dados.Column6
827:             .FontName    = "Verdana"
828:             .FontSize    = 8
829:             .ColumnOrder = 1
830:             .Width       = 31
831:             .Movable     = .F.
832:             .Resizable   = .F.
833:             .InputMask   = "999"
834:             .Visible     = .T.
835:         ENDWITH
836: 
837:         WITH THIS.grd_4c_Dados.Column6.Header1
838:             .FontName = "Verdana"
839:             .FontSize = 8
840:             .Caption  = ""
841:         ENDWITH
842: 
843:         WITH THIS.grd_4c_Dados.Column6.Text1
844:             .FontName    = "Verdana"
845:             .FontSize    = 8
846:             .Alignment   = 3
847:             .BorderStyle = 0
848:             .Value       = 0
849:             .InputMask   = "999"
850:             .Margin      = 0
851:             .ReadOnly    = .F.
852:             .ForeColor   = RGB(0, 0, 0)
853:             .BackColor   = RGB(255, 255, 255)
854:             .Visible     = .T.
855:         ENDWITH
856: 
857:         *-- Column7 = Descricao ("Descricao do Servico") - a mais larga; o dump
858:         *-- NAO declara ReadOnly no Text1 dela (fica no default .F.)
859:         WITH THIS.grd_4c_Dados.Column7
860:             .FontName    = "Verdana"
861:             .FontSize    = 8
862:             .ColumnOrder = 3
863:             .Width       = 404
864:             .Movable     = .F.
865:             .Resizable   = .F.
866:             .Visible     = .T.
867:         ENDWITH
868: 
869:         WITH THIS.grd_4c_Dados.Column7.Header1
870:             .FontName  = "Verdana"
871:             .FontSize  = 8
872:             .Alignment = 2
873:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Servi" + CHR(231) + "o"
874:         ENDWITH
875: 
876:         WITH THIS.grd_4c_Dados.Column7.Text1
877:             .FontName    = "Verdana"
878:             .FontSize    = 8
879:             .BorderStyle = 0
880:             .Margin      = 0
881:             .ForeColor   = RGB(0, 0, 0)
882:             .BackColor   = RGB(255, 255, 255)
883:             .Visible     = .T.
884:         ENDWITH
885: 
886:         *-- Quarta porta do lookup das celulas: o duplo clique que nao chega a
887:         *-- celula e sim ao proprio Grid. As outras tres (Valid, F4/F5 e duplo
888:         *-- clique dentro da celula) moram na subclasse de TextBox instalada
889:         *-- por InstalarCelulasLookup - BINDEVENT em "Valid" de TextBox de
890:         *-- Column nao eh confiavel (regra #46)
891:         BINDEVENT(THIS.grd_4c_Dados, "DblClick", THIS, "GradeDblClick")
892: 
893:         *-- Celulas de lookup das colunas Servico/Descricao. Instaladas ja aqui
894:         *-- para que existam mesmo quando os cursores do chamador nao estao
895:         *-- abertos (VincularGrade sai cedo nesse caso); reinstaladas la depois
896:         *-- de cada rebind, que devolve CurrentControl/Sparse ao default
897:         THIS.InstalarCelulasLookup()
898: 
899:         *-- Idem para as celulas de quantidade e de valor, e para o ReadOnly
900:         *-- das tres colunas somente-exibicao (o "Return .f." do When delas)
901:         THIS.InstalarCelulasEdicao()
902: 
903:         RETURN
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * ConfigurarBotoesServico - a barra dos tres botoes de servico do legado.
908:     *
909:     * Legado (todos Top=87 Height=40 Width=120, Comic Sans MS 8 bold italic,
910:     * MousePointer=15, PicturePosition=1, ForeColor=0,0,0, BackColor=255,255,255
911:     * e - o que mais importa - Visible = .F.):
912:     *
913:     *   btnTotItens  Left= 18  "\<Total de Servicos"  geral_calculadora_60.jpg
914:     *   btnCotacao   Left=138  "E\<xcluir Servicos"   cadastro_excluir_60.jpg
915:     *   btnAltImps   Left=258  "Alterar \<Valores"    geral_pastas_60.jpg
916:     *
917:     * Os tres nascem OCULTOS e sao mostrados em runtime; por isso estao na lista
918:     * de excecao de TornarControlesVisiveis, que de outro modo apagaria esse
919:     * estado inicial. Os handlers de Click e os respectivos When (que no legado
920:     * so liberam os botoes em INSERIR/ALTERAR e com linha posicionada) entram na
921:     * Fase 7, junto com os demais eventos da grade.
922:     *
923:     * O "\<" de cada Caption eh a marca de tecla de atalho do VFP (T, x, V) -
924:     * transcrita literalmente, senao o usuario perde o atalho do legado.
925:     *
926:     * UNICO desvio do dump: Themes. O SCX declara Themes = .F., mas em
927:     * CommandButton AVULSO (fora de CommandGroup) com .Picture o par
928:     * Themes = .F. + Enabled = .F. faz o VFP NAO desenhar o icone - sobraria so
929:     * o texto. O canonico do projeto para esse caso eh Themes = .T. com
930:     * DisabledPicture apontando para a MESMA imagem, que preserva o icone nos
931:     * dois estados. Buttons(N) DENTRO de CommandGroup mantem Themes = .F. (ver
932:     * ConfigurarBotaoRetornar).
933:     *--------------------------------------------------------------------------
934:     PROTECTED PROCEDURE ConfigurarBotoesServico()
935:         THIS.AddObject("cmd_4c_BtnTotItens", "CommandButton")
936: 
937:         WITH THIS.cmd_4c_BtnTotItens
938:             .AutoSize        = .F.
939:             .Top             = 87
940:             .Left            = 18
941:             .Height          = 40
942:             .Width           = 120
943:             .FontName        = "Comic Sans MS"
944:             .FontSize        = 8
945:             .FontBold        = .T.
946:             .FontItalic      = .T.
947:             .WordWrap        = .T.
948:             .Caption         = "\<Total de Servi" + CHR(231) + "os"
949:             .Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
950:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
951:             .PicturePosition = 1
952:             .MousePointer    = 15
953:             .ToolTipText     = "Total dos Servi" + CHR(231) + "os"
954:             .ForeColor       = RGB(0, 0, 0)
955:             .BackColor       = RGB(255, 255, 255)
956:             .Themes          = .T.
957:             .Visible         = .F.
958:         ENDWITH
959: 
960:         THIS.AddObject("cmd_4c_BtnCotacao", "CommandButton")
961: 
962:         WITH THIS.cmd_4c_BtnCotacao
963:             .AutoSize        = .F.
964:             .Top             = 87
965:             .Left            = 138
966:             .Height          = 40
967:             .Width           = 120
968:             .FontName        = "Comic Sans MS"
969:             .FontSize        = 8
970:             .FontBold        = .T.
971:             .FontItalic      = .T.
972:             .WordWrap        = .T.
973:             .Caption         = "E\<xcluir Servi" + CHR(231) + "os"
974:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"

*-- Linhas 1044 a 1087:
1044:     * O Caption "Retornar" NAO leva a marca "\<": o dump nao declara atalho de
1045:     * teclado neste botao, so o Cancel.
1046:     *--------------------------------------------------------------------------
1047:     PROTECTED PROCEDURE ConfigurarBotaoRetornar()
1048:         THIS.AddObject("cmg_4c_CntOK", "CommandGroup")
1049: 
1050:         THIS.cmg_4c_CntOK.ButtonCount = 1
1051: 
1052:         *-- Membro interno (btnSair do legado) - define o tamanho do grupo
1053:         WITH THIS.cmg_4c_CntOK.Buttons(1)
1054:             .Top             = 5
1055:             .Left            = 5
1056:             .Height          = 75
1057:             .Width           = 75
1058:             .FontName        = "Comic Sans MS"
1059:             .FontSize        = 8
1060:             .FontBold        = .T.
1061:             .FontItalic      = .T.
1062:             .WordWrap        = .T.
1063:             .Caption         = "Retornar"
1064:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1065:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1066:             .Cancel          = .T.
1067:             .MousePointer    = 15
1068:             .SpecialEffect   = 0
1069:             .ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + ;
1070:                                CHR(231) + CHR(227) + "o"
1071:             .ForeColor       = RGB(0, 0, 0)
1072:             .BackColor       = RGB(255, 255, 255)
1073:             .Themes          = .F.
1074:             .Visible         = .T.
1075:         ENDWITH
1076: 
1077:         WITH THIS.cmg_4c_CntOK
1078:             .AutoSize      = .T.
1079:             .Top           = -2
1080:             .Left          = 968
1081:             .Width         = 85
1082:             .Height        = 85
1083:             .BackStyle     = 0
1084:             .BorderStyle   = 0
1085:             .BorderColor   = RGB(136, 189, 188)
1086:             .SpecialEffect = 1
1087:             .Value         = 0

*-- Linhas 1107 a 1231:
1107:     * Container NAO tem BorderStyle (so BorderWidth) - atribuir BorderStyle
1108:     * aqui faria a tela nao abrir.
1109:     *--------------------------------------------------------------------------
1110:     PROTECTED PROCEDURE ConfigurarPainelTamanho()
1111:         THIS.AddObject("cnt_4c_Tamanho", "Container")
1112: 
1113:         WITH THIS.cnt_4c_Tamanho
1114:             .Top           = 120
1115:             .Left          = 643
1116:             .Width         = 160
1117:             .Height        = 52
1118:             .BackStyle     = 0
1119:             .BorderWidth   = 0
1120:             .SpecialEffect = 0
1121:             .Visible       = .T.
1122:         ENDWITH
1123: 
1124:         RETURN
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     * ConfigurarCamposProduto - Identificacao do produto (Label1 + os tres
1129:     * Get_* diretos da Form) e os tres rotulos internos de cnt_4c_Tamanho.
1130:     *
1131:     * Legado (SIGOPSER - propriedades, SECAO 1 do dump):
1132:     *   Label1        AutoSize=.T. Tahoma 8 BackStyle=0 Caption="Produto"
1133:     *                 Top=128 Left=20 Width=40 Height=15 ForeColor=90,90,90
1134:     *   Get_Produto   FontName="Courier New" Top=143 Left=20 Width=112 Height=23
1135:     *                 ForeColor=90,90,90 BackColor=253,250,185
1136:     *                 DisabledBackColor=255,255,220 BorderColor=90,90,90
1137:     *                 SpecialEffect=1 ReadOnly=.F. ToolTipText="Codigo do Produto"
1138:     *   Get_Descricao mesmo estilo, Top=143 Left=134 Width=459 Height=23
1139:     *                 ToolTipText="Descricao do Produto"
1140:     *   Get_Mercs     mesmo estilo, Top=143 Left=595 Width=50 Height=23
1141:     *                 ToolTipText="Descricao do Produto" (sic - o dump legado
1142:     *                 repete o tooltip de Get_Descricao neste campo; transcrito
1143:     *                 literal, nao eh erro de migracao)
1144:     *
1145:     *   cntTamanho.Label2  AutoSize=.T. Tahoma 12 bold BackStyle=0
1146:     *                      Caption="Tamanho" Top=3 Left=8 Width=78 Height=21
1147:     *                      ForeColor=90,90,90
1148:     *   cntTamanho.Say43   Tahoma 8 Caption="De:"   Top=27 Left=13 (sem Width -
1149:     *                      classe say pura, ver nota abaixo)
1150:     *   cntTamanho.Say1    Tahoma 8 Caption="Para:" Top=27 Left=84 (idem)
1151:     *
1152:     * Os TRES campos de produto sao so EXIBICAO nesta fase: o legado os
1153:     * preenche por codigo a partir de CrTmpPro (apaite/mInsereLinha,
1154:     * "ThisForm.Get_Produto.Value = crTpmMvItn.Cpros" etc.) quando a grade
1155:     * muda de linha - esse disparo (AfterRowColChange da grade) entra na
1156:     * Fase 7 junto com os demais eventos. O When de Get_Produto/Get_Descricao
1157:     * no dump sempre "Return .f." (nunca editaveis por digitacao direta); o
1158:     * BINDEVENT que reproduz esse gate tambem fica para a Fase 7, pelo mesmo
1159:     * motivo das regras #3/#47 (handler incompleto ligado agora quebraria
1160:     * sem o resto do fluxo). .ReadOnly = .F. e .Value = "" aqui sao so o
1161:     * estado inicial, igual ao dump.
1162:     *
1163:     * MaxLength de cada TextBox vem da LARGURA DA COLUNA no schema (regra
1164:     * #19), nao do Width em pixels - o dump nao declara MaxLength nenhum:
1165:     *   SigCdPro.cpros  char(14) -> txt_4c_Produto.MaxLength   = 14
1166:     *   SigCdPro.dpros  char(65) -> txt_4c_Descricao.MaxLength = 65
1167:     *   SigCdPro.mercs  char(3)  -> txt_4c_Mercs.MaxLength     = 3
1168:     *
1169:     * FontSize = 9 dos tres TextBox NAO eh inventado: o dump so declara
1170:     * FontName = "Courier New" nestes tres, mas a SECAO 1 do mesmo dump traz
1171:     * a tabela de metricas de fonte do form ("Courier New, 0, 9, 7, 15, 12,
1172:     * 9, 3, 0") - o 3o campo eh o tamanho, e bate com o uso de Tahoma/
1173:     * Verdana/Comic Sans MS em outros controles deste mesmo form (campo na
1174:     * mesma posicao = 8 nos tres, que eh o FontSize ja usado em
1175:     * ConfigurarCabecalho/ConfigurarGrade/ConfigurarBotoesServico).
1176:     *
1177:     * Label1 ("Produto") DECLARA Width/Height no dump (40/15): sao os valores
1178:     * ja calculados pelo Form Designer, logo fixa-los com AutoSize = .F. eh
1179:     * reproducao fiel (regra #23), nao desvio.
1180:     *
1181:     * Say43/Say1 NAO declaram Width/Height - sao a classe "say" pura
1182:     * (AutoSize=.T./Alignment=0 por default), e AutoSize = .T. eh NO-OP em
1183:     * Label criado por AddObject (regra #23). Usa-se .Alignment = 0 com
1184:     * .Width calculado para o texto terminar poucos pixels antes do campo
1185:     * vizinho (mesmo padrao do FormCES citado na regra #23): Say43 "De:" em
1186:     * Left=13 termina em 13+18=31, 4px antes de getTamDe (Left=35 - Fase 6);
1187:     * Say1 "Para:" em Left=84 termina em 84+28=112, 4px antes de getTamPara
1188:     * (Left=116 - Fase 6). cntTamanho.Label2 ("Tamanho") JA declara
1189:     * Width/Height (78/21) e segue o mesmo tratamento de Label1.
1190:     *--------------------------------------------------------------------------
1191:     PROTECTED PROCEDURE ConfigurarCamposProduto()
1192:         *-- Label1 - rotulo "Produto"
1193:         THIS.AddObject("lbl_4c_Label1", "Label")
1194: 
1195:         WITH THIS.lbl_4c_Label1
1196:             .AutoSize  = .F.
1197:             .FontName  = "Tahoma"
1198:             .FontSize  = 8
1199:             .BackStyle = 0
1200:             .Alignment = 0
1201:             .Caption   = "Produto"
1202:             .Top       = 128
1203:             .Left      = 20
1204:             .Width     = 40
1205:             .Height    = 15
1206:             .ForeColor = RGB(90, 90, 90)
1207:             .Visible   = .T.
1208:         ENDWITH
1209: 
1210:         *-- Get_Produto -> txt_4c_Produto (codigo do produto)
1211:         THIS.AddObject("txt_4c_Produto", "TextBox")
1212: 
1213:         WITH THIS.txt_4c_Produto
1214:             .Top               = 143
1215:             .Left              = 20
1216:             .Width             = 112
1217:             .Height            = 23
1218:             .FontName          = "Courier New"
1219:             .FontSize          = 9
1220:             .Value             = ""
1221:             .MaxLength         = 14
1222:             .ReadOnly          = .F.
1223:             .SpecialEffect     = 1
1224:             .ForeColor         = RGB(90, 90, 90)
1225:             .BackColor         = RGB(253, 250, 185)
1226:             .DisabledBackColor = RGB(255, 255, 220)
1227:             .BorderColor       = RGB(90, 90, 90)
1228:             .ToolTipText       = "C" + CHR(243) + "digo do Produto"
1229:             .Visible           = .T.
1230:         ENDWITH
1231: 

*-- Linhas 1349 a 1582:
1349:     * MaxLength = 4 nos dois: SigCdTam.cods eh char(4) (regra #19) - o dump
1350:     * nunca declara MaxLength nestes dois campos.
1351:     *
1352:     * Lookup (tasks\task801\sigopser_form_codigo_fonte.txt, PROCEDURE Valid
1353:     * de ambos os campos):
1354:     *   CreateObject('fwbuscaext', ..., 'SigCdTam', 'CrListaRemota', 'Cods',
1355:     *                This.Value, 'Selecao', .t.) + mAddColuna(Cods/Descs) +
1356:     *   Replace TamDe/TamPara With This.Value In crTpmMvItn3
1357:     *
1358:     * Migrado para o padrao canonico do projeto: FormBuscaAuxiliar com
1359:     * parametros (match exato primeiro, Show() so se nao achou - regra #37),
1360:     * ligado em LostFocus (regra #47 - o legado valida no Valid, ao SAIR do
1361:     * campo) e tambem em Enter/Tab/F4 via KeyPress delegando ao mesmo corpo.
1362:     * Guarda de reentrancia por campo (this_lEmLookupTamDe/TamPara): o
1363:     * picker eh modal e tira o foco, o que redispara o proprio LostFocus.
1364:     *
1365:     * A gravacao eh no REGISTRO CORRENTE de crTpmMvItn3 - a mesma premissa do
1366:     * legado (o painel so fica visivel, via AfterRowColChange na Fase 7,
1367:     * enquanto a linha da grade continua corrente).
1368:     *--------------------------------------------------------------------------
1369:     PROTECTED PROCEDURE ConfigurarCamposTamanho()
1370:         THIS.cnt_4c_Tamanho.AddObject("txt_4c_TamDe", "TextBox")
1371: 
1372:         WITH THIS.cnt_4c_Tamanho.txt_4c_TamDe
1373:             .Top               = 23
1374:             .Left              = 35
1375:             .Width             = 38
1376:             .Height            = 23
1377:             .FontName          = "Tahoma"
1378:             .FontSize          = 8
1379:             .Format            = "K"
1380:             .Value             = ""
1381:             .MaxLength         = 4
1382:             .SpecialEffect     = 1
1383:             .DisabledBackColor = RGB(192, 192, 192)
1384:             .DisabledForeColor = RGB(0, 0, 0)
1385:             .ToolTipText       = "Tamanho Inicial"
1386:             .Visible           = .T.
1387:         ENDWITH
1388: 
1389:         THIS.cnt_4c_Tamanho.AddObject("txt_4c_TamPara", "TextBox")
1390: 
1391:         WITH THIS.cnt_4c_Tamanho.txt_4c_TamPara
1392:             .Top               = 23
1393:             .Left              = 116
1394:             .Width             = 38
1395:             .Height            = 23
1396:             .FontName          = "Tahoma"
1397:             .FontSize          = 8
1398:             .Format            = "K"
1399:             .Value             = ""
1400:             .MaxLength         = 4
1401:             .SpecialEffect     = 1
1402:             .DisabledBackColor = RGB(192, 192, 192)
1403:             .DisabledForeColor = RGB(0, 0, 0)
1404:             .ToolTipText       = "Tamanho Final"
1405:             .Visible           = .T.
1406:         ENDWITH
1407: 
1408:         BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamDe, "LostFocus", THIS, "ValidarTamDeLostFocus")
1409:         BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamDe, "KeyPress", THIS, "ValidarTamDeKeyPress")
1410: 
1411:         BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamPara, "LostFocus", THIS, "ValidarTamParaLostFocus")
1412:         BINDEVENT(THIS.cnt_4c_Tamanho.txt_4c_TamPara, "KeyPress", THIS, "ValidarTamParaKeyPress")
1413: 
1414:         RETURN
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * ValidarTamDeKeyPress / ValidarTamDeLostFocus / ValidarTamDeExec -
1419:     * lookup de SigCdTam para o campo "De:" do painel Tamanho.
1420:     *
1421:     * PUBLIC: metodo PROTECTED ligado por BINDEVENT estoura em runtime (regra
1422:     * #3). ValidarTamDeKeyPress so delega em ENTER(13)/TAB(9)/F4(115) - sem
1423:     * esse teste o picker abriria a cada tecla digitada (regra #47).
1424:     *--------------------------------------------------------------------------
1425:     PROCEDURE ValidarTamDeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1426:         IF INLIST(par_nKeyCode, 13, 9, 115)
1427:             THIS.ValidarTamDeLostFocus()
1428:         ENDIF
1429: 
1430:         RETURN
1431:     ENDPROC
1432: 
1433:     PROCEDURE ValidarTamDeLostFocus()
1434:         LOCAL loc_lAnterior
1435: 
1436:         loc_lAnterior = THIS.this_lEmLookupTamDe
1437: 
1438:         IF loc_lAnterior
1439:             RETURN
1440:         ENDIF
1441: 
1442:         THIS.this_lEmLookupTamDe = .T.
1443:         THIS.ValidarTamDeExec()
1444:         THIS.this_lEmLookupTamDe = loc_lAnterior
1445: 
1446:         RETURN
1447:     ENDPROC
1448: 
1449:     PROTECTED PROCEDURE ValidarTamDeExec()
1450:         LOCAL loc_oTxt, loc_cCodigo
1451: 
1452:         loc_oTxt = THIS.cnt_4c_Tamanho.txt_4c_TamDe
1453: 
1454:         IF !EMPTY(ALLTRIM(loc_oTxt.Value))
1455:             loc_cCodigo = THIS.AbrirBuscaTamanho(loc_oTxt)
1456:         ELSE
1457:             loc_cCodigo = ""
1458:         ENDIF
1459: 
1460:         loc_oTxt.Value = loc_cCodigo
1461: 
1462:         *-- "Replace TamDe With This.Value In crTpmMvItn3" do legado, pela
1463:         *-- camada: a tela vai para o BO e eh o BO que grava no cursor
1464:         THIS.GravarLinhaCorrente()
1465: 
1466:         loc_oTxt.Refresh()
1467: 
1468:         RETURN
1469:     ENDPROC
1470: 
1471:     *--------------------------------------------------------------------------
1472:     * ValidarTamParaKeyPress / ValidarTamParaLostFocus / ValidarTamParaExec -
1473:     * mesma logica de ValidarTamDe*, aplicada ao campo "Para:".
1474:     *--------------------------------------------------------------------------
1475:     PROCEDURE ValidarTamParaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1476:         IF INLIST(par_nKeyCode, 13, 9, 115)
1477:             THIS.ValidarTamParaLostFocus()
1478:         ENDIF
1479: 
1480:         RETURN
1481:     ENDPROC
1482: 
1483:     PROCEDURE ValidarTamParaLostFocus()
1484:         LOCAL loc_lAnterior
1485: 
1486:         loc_lAnterior = THIS.this_lEmLookupTamPara
1487: 
1488:         IF loc_lAnterior
1489:             RETURN
1490:         ENDIF
1491: 
1492:         THIS.this_lEmLookupTamPara = .T.
1493:         THIS.ValidarTamParaExec()
1494:         THIS.this_lEmLookupTamPara = loc_lAnterior
1495: 
1496:         RETURN
1497:     ENDPROC
1498: 
1499:     PROTECTED PROCEDURE ValidarTamParaExec()
1500:         LOCAL loc_oTxt, loc_cCodigo
1501: 
1502:         loc_oTxt = THIS.cnt_4c_Tamanho.txt_4c_TamPara
1503: 
1504:         IF !EMPTY(ALLTRIM(loc_oTxt.Value))
1505:             loc_cCodigo = THIS.AbrirBuscaTamanho(loc_oTxt)
1506:         ELSE
1507:             loc_cCodigo = ""
1508:         ENDIF
1509: 
1510:         loc_oTxt.Value = loc_cCodigo
1511: 
1512:         *-- "Replace TamPara With This.Value In crTpmMvItn3" do legado, pela
1513:         *-- camada: a tela vai para o BO e eh o BO que grava no cursor
1514:         THIS.GravarLinhaCorrente()
1515: 
1516:         loc_oTxt.Refresh()
1517: 
1518:         RETURN
1519:     ENDPROC
1520: 
1521:     *--------------------------------------------------------------------------
1522:     * AbrirBuscaTamanho - lookup compartilhado por TamDe/TamPara em
1523:     * SigCdTam (cods/descs), padrao canonico FormBuscaAuxiliar.
1524:     *
1525:     * Legado: CreateObject('fwbuscaext', ThisForm.ParentForm.poDataMgr.pnIdConn,
1526:     *         'SigCdTam', 'CrListaRemota', 'Cods', This.Value, 'Selecao', .t.)
1527:     *         - tenta o match EXATO primeiro (plAchouRegistro) e so abre o
1528:     *         browse quando nao casa (regra #37). Sem conexao valida (modo de
1529:     *         teste/validacao de UI), devolve o que o usuario digitou, sem
1530:     *         tentar SQL - mesma guarda de CarregarConfiguracaoOperacao.
1531:     *--------------------------------------------------------------------------
1532:     PROTECTED PROCEDURE AbrirBuscaTamanho(par_oTxt)
1533:         LOCAL loc_oBusca, loc_cCodigo, loc_cDigitado
1534: 
1535:         loc_cDigitado = ALLTRIM(par_oTxt.Value)
1536:         loc_cCodigo   = loc_cDigitado
1537: 
1538:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1539:             RETURN loc_cCodigo
1540:         ENDIF
1541: 
1542:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1543:             "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cDigitado, ;
1544:             "Sele" + CHR(231) + CHR(227) + "o")
1545: 
1546:         IF VARTYPE(loc_oBusca) = "O"
1547:             IF !loc_oBusca.this_lAchouRegistro
1548:                 loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
1549:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1550:                 loc_oBusca.Show()
1551:             ENDIF
1552: 
1553:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
1554:                 SELECT cursor_4c_BuscaTam
1555:                 loc_cCodigo = ALLTRIM(cods)
1556:             ELSE
1557:                 *-- Legado: Lastkey() = 27 (ESC) limpa o campo
1558:                 loc_cCodigo = ""
1559:             ENDIF
1560: 
1561:             IF USED("cursor_4c_BuscaTam")
1562:                 USE IN cursor_4c_BuscaTam
1563:             ENDIF
1564: 
1565:             loc_oBusca.Release()
1566:         ENDIF
1567: 
1568:         RETURN loc_cCodigo
1569:     ENDPROC
1570: 
1571:     *--------------------------------------------------------------------------
1572:     * CarregarServicosDisponiveis - monta csSigCdPro, o universo que os dois
1573:     * lookups da grade consultam, e os indices que o legado cria sobre ele.
1574:     *
1575:     * Legado (Init), transcrito:
1576:     *
1577:     *   =Cursorquery('SigCdPro','CrTmpPro','Cpros',crTpmMvItn.Cpros,[dpros, Mercs])
1578:     *   ThisForm.Get_Produto.Value   = crTpmMvItn.Cpros
1579:     *   ThisForm.Get_Descricao.Value = CrTmpPro.Dpros
1580:     *   ThisForm.Get_Mercs.Value     = CrTmpPro.Mercs
1581:     *   ...
1582:     *   lcMercs = Iif(Not InList(CrTmpPro.Mercs,[JOI],[REL]),[JOI],CrTmpPro.Mercs)

*-- Linhas 1596 a 1639:
1596:     * por rodar com outra configuracao; aqui a busca eh por LOCATE, que da o
1597:     * mesmo resultado sem depender do estado de EXACT.
1598:     *--------------------------------------------------------------------------
1599:     PROTECTED PROCEDURE CarregarServicosDisponiveis()
1600:         LOCAL loc_cCpros, loc_cMercs, loc_cMercsFiltro, loc_cLista, loc_nAreaAnterior
1601: 
1602:         loc_nAreaAnterior = SELECT()
1603:         loc_cLista        = THIS.this_cCursorLista
1604:         loc_cCpros        = ""
1605: 
1606:         *-- Codigo do produto dono dos servicos (crTpmMvItn.Cpros no legado)
1607:         IF USED(THIS.this_cCursorItem)
1608:             SELECT (THIS.this_cCursorItem)
1609: 
1610:             IF !EOF() AND TYPE(THIS.this_cCursorItem + ".cpros") = "C"
1611:                 loc_cCpros = ALLTRIM(cpros)
1612:             ENDIF
1613:         ENDIF
1614: 
1615:         *-- Mercadoria do produto; a descricao dele vem de carona, como no
1616:         *-- Cursorquery legado que traz dpros junto com Mercs. As tres ficam
1617:         *-- nas propriedades de ITEM do BO (this_c*Item), separadas das da
1618:         *-- linha de servico
1619:         THIS.this_oBusinessObject.this_cCprosItem = loc_cCpros
1620:         loc_cMercs = THIS.this_oBusinessObject.ObterMercadoriaProduto(loc_cCpros)
1621: 
1622:         *-- O default "JOI" vale so para FILTRAR o universo de servicos: o
1623:         *-- legado exibe em Get_Mercs a mercadoria CRUA do produto e so depois
1624:         *-- calcula lcMercs para o Select de csSigCdPro
1625:         loc_cMercsFiltro = IIF(!INLIST(loc_cMercs, "JOI", "REL"), "JOI", loc_cMercs)
1626: 
1627:         *-- Os tres campos de identificacao do produto, como no Init legado
1628:         THIS.BOParaForm()
1629: 
1630:         IF THIS.this_oBusinessObject.CarregarServicosDisponiveis(loc_cLista, loc_cMercsFiltro)
1631:             SELECT (loc_cLista)
1632:             INDEX ON DPros TAG DPros
1633:             INDEX ON Cpros TAG Cpros
1634:             INDEX ON Cpros + IdeCPros TAG IdeCPros
1635:             INDEX ON DPros + IdeCPros TAG IdeDPros
1636:             GO TOP
1637:         ENDIF
1638: 
1639:         IF loc_nAreaAnterior > 0

*-- Linhas 1647 a 1736:
1647:     * InstalarCelulasLookup - poe nas colunas "Servico" (Column1) e "Descricao"
1648:     * (Column7) os TextBox que carregam o When/Valid do legado.
1649:     *
1650:     * O legado tem o lookup no Valid do Text1 de CADA coluna. BINDEVENT em
1651:     * "Valid" de TextBox de Column NAO eh confiavel (regra #46), por isso o
1652:     * evento mora numa SUBCLASSE de TextBox posta na Column com AddObject +
1653:     * CurrentControl + Sparse = .F. (regra #18 - sem o CurrentControl o
1654:     * controle eh criado e a coluna continua desenhando o Text1 dela).
1655:     *
1656:     * As quatro portas de entrada do mesmo lookup desaguam no MESMO funil
1657:     * (AbrirBuscaServicoGrade / AbrirBuscaDescricaoGrade), guardado pela
1658:     * respectiva flag this_lEmLookup*:
1659:     *
1660:     *   Valid da celula          -> subclasse (o caminho do legado)
1661:     *   F4/F5 dentro da celula   -> KeyPress da MESMA subclasse
1662:     *   duplo clique na celula   -> DblClick da MESMA subclasse
1663:     *   duplo clique fora dela   -> BINDEVENT(grade, "DblClick", ...)
1664:     *
1665:     * Chamado por VincularGrade, nao so na inicializacao: atribuir
1666:     * RecordSource/ControlSource devolve Sparse e CurrentControl ao default, e
1667:     * a celula voltaria a ser o Text1 original sem o lookup.
1668:     *
1669:     * As propriedades visuais repetem as do Text1 configurado na Fase 4 - eh o
1670:     * controle da subclasse que passa a desenhar a celula, entao sem elas a
1671:     * coluna perderia fonte, mascara e borda.
1672:     *--------------------------------------------------------------------------
1673:     PROTECTED PROCEDURE InstalarCelulasLookup()
1674:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelServico", 5)
1675:             THIS.grd_4c_Dados.Column1.AddObject("txt_4c_CelServico", "TextBoxServicoSer_4c")
1676:         ENDIF
1677: 
1678:         WITH THIS.grd_4c_Dados.Column1.txt_4c_CelServico
1679:             .FontName       = "Verdana"
1680:             .FontSize       = 8
1681:             .BorderStyle    = 0
1682:             .Format         = "K!"
1683:             .InputMask      = "!!!!!!!!!!"
1684:             .Margin         = 0
1685:             .MaxLength      = 10
1686:             .ReadOnly       = .F.
1687:             .ForeColor      = RGB(0, 0, 0)
1688:             .BackColor      = RGB(255, 255, 255)
1689:             .ToolTipText    = "C" + CHR(243) + "digo do Servi" + CHR(231) + ;
1690:                               "o - F4 abre a lista"
1691:             .Visible        = .T.
1692:         ENDWITH
1693: 
1694:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column7, "txt_4c_CelDescricao", 5)
1695:             THIS.grd_4c_Dados.Column7.AddObject("txt_4c_CelDescricao", "TextBoxDescricaoSer_4c")
1696:         ENDIF
1697: 
1698:         WITH THIS.grd_4c_Dados.Column7.txt_4c_CelDescricao
1699:             .FontName       = "Verdana"
1700:             .FontSize       = 8
1701:             .BorderStyle    = 0
1702:             .Margin         = 0
1703:             .MaxLength      = 65
1704:             .ReadOnly       = .F.
1705:             .ForeColor      = RGB(0, 0, 0)
1706:             .BackColor      = RGB(255, 255, 255)
1707:             .ToolTipText    = "Descri" + CHR(231) + CHR(227) + "o do Servi" + ;
1708:                               CHR(231) + "o - F4 abre a lista"
1709:             .Visible        = .T.
1710:         ENDWITH
1711: 
1712:         *-- CurrentControl por ULTIMO, e so depois Sparse/ReadOnly: o ReadOnly
1713:         *-- da COLUNA tem de vir depois do ReadOnly do GRID, que propaga para
1714:         *-- as colunas e sobrescreveria o valor posto aqui (regra #18)
1715:         WITH THIS.grd_4c_Dados.Column1
1716:             .CurrentControl = "txt_4c_CelServico"
1717:             .Sparse         = .F.
1718:             .ReadOnly       = .F.
1719:         ENDWITH
1720: 
1721:         WITH THIS.grd_4c_Dados.Column7
1722:             .CurrentControl = "txt_4c_CelDescricao"
1723:             .Sparse         = .F.
1724:             .ReadOnly       = .F.
1725:         ENDWITH
1726: 
1727:         RETURN
1728:     ENDPROC
1729: 
1730:     *--------------------------------------------------------------------------
1731:     * CelulaServicoLiberada / CelulaDescricaoLiberada - o When de cada coluna.
1732:     *
1733:     * Legado (PRODUTO.Text1.When):
1734:     *   Select crTpmMvItn3
1735:     *   ThisForm.AntCPro = This.Value
1736:     *   ThisForm.AntValu = crTpmMvItn.Units

*-- Linhas 1742 a 2056:
1742:     *
1743:     * PUBLIC: sao chamados pela subclasse de TextBox, de FORA desta classe.
1744:     *--------------------------------------------------------------------------
1745:     PROCEDURE CelulaServicoLiberada(par_oTxt)
1746:         THIS.GuardarValorAnterior(par_oTxt)
1747: 
1748:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1749:     ENDPROC
1750: 
1751:     PROCEDURE CelulaDescricaoLiberada(par_oTxt)
1752:         LOCAL loc_lSemCodigo
1753: 
1754:         THIS.GuardarValorAnterior(par_oTxt)
1755: 
1756:         loc_lSemCodigo = .T.
1757: 
1758:         IF USED(THIS.this_cCursorServicos)
1759:             SELECT (THIS.this_cCursorServicos)
1760:             loc_lSemCodigo = EOF() OR EMPTY(ALLTRIM(cpros))
1761:         ENDIF
1762: 
1763:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") AND loc_lSemCodigo
1764:     ENDPROC
1765: 
1766:     *--------------------------------------------------------------------------
1767:     * GuardarValorAnterior - as duas primeiras linhas do When das duas colunas.
1768:     * AntCPro guarda o que havia na celula antes da edicao (o Valid compara os
1769:     * dois para saber se o servico mudou) e AntValu, o valor unitario do item.
1770:     *--------------------------------------------------------------------------
1771:     PROTECTED PROCEDURE GuardarValorAnterior(par_oTxt)
1772:         IF VARTYPE(par_oTxt) = "O"
1773:             THIS.this_cAntCPro = par_oTxt.Value
1774:         ENDIF
1775: 
1776:         IF USED(THIS.this_cCursorItem)
1777:             SELECT (THIS.this_cCursorItem)
1778: 
1779:             IF !EOF() AND TYPE(THIS.this_cCursorItem + ".units") = "N"
1780:                 THIS.this_cAntValu = units
1781:             ENDIF
1782:         ENDIF
1783: 
1784:         RETURN
1785:     ENDPROC
1786: 
1787:     *--------------------------------------------------------------------------
1788:     * ValidarCelulaServico / ValidarCelulaDescricao - o Valid de cada coluna.
1789:     *
1790:     * Wrapper fino da guarda de reentrancia: o picker eh modal, devolve o foco
1791:     * a celula e faria o Valid disparar de novo. A flag eh liberada no wrapper,
1792:     * e nao no corpo, porque o corpo tem RETURN antecipado - liberar la dentro
1793:     * deixaria a flag ligada para sempre e MATARIA o lookup (regra #47).
1794:     * Save/restore em vez de set/clear: as portas de F4 e duplo clique chamam
1795:     * este mesmo funil, e um clear simples liberaria a flag cedo demais.
1796:     *
1797:     * PUBLIC: chamados pela subclasse de TextBox, de FORA desta classe.
1798:     *--------------------------------------------------------------------------
1799:     PROCEDURE ValidarCelulaServico(par_oTxt)
1800:         LOCAL loc_lAnterior
1801: 
1802:         loc_lAnterior = THIS.this_lEmLookupServico
1803: 
1804:         IF loc_lAnterior
1805:             RETURN .T.
1806:         ENDIF
1807: 
1808:         THIS.this_lEmLookupServico = .T.
1809:         THIS.AbrirBuscaServicoGrade(par_oTxt)
1810:         THIS.this_lEmLookupServico = loc_lAnterior
1811: 
1812:         RETURN .T.
1813:     ENDPROC
1814: 
1815:     PROCEDURE ValidarCelulaDescricao(par_oTxt)
1816:         LOCAL loc_lAnterior
1817: 
1818:         loc_lAnterior = THIS.this_lEmLookupDescricao
1819: 
1820:         IF loc_lAnterior
1821:             RETURN .T.
1822:         ENDIF
1823: 
1824:         THIS.this_lEmLookupDescricao = .T.
1825:         THIS.AbrirBuscaDescricaoGrade(par_oTxt)
1826:         THIS.this_lEmLookupDescricao = loc_lAnterior
1827: 
1828:         RETURN .T.
1829:     ENDPROC
1830: 
1831:     *--------------------------------------------------------------------------
1832:     * GradeDblClick - a quarta porta do lookup: duplo clique que chega ao
1833:     * proprio Grid, e nao a celula. Encaminha para o funil da coluna em que o
1834:     * usuario clicou; qualquer outra coluna eh ignorada.
1835:     *--------------------------------------------------------------------------
1836:     PROCEDURE GradeDblClick()
1837:         DO CASE
1838:             CASE THIS.grd_4c_Dados.ActiveColumn = 1
1839:                 THIS.ValidarCelulaServico(THIS.grd_4c_Dados.Column1.txt_4c_CelServico)
1840:             CASE THIS.grd_4c_Dados.ActiveColumn = 7
1841:                 THIS.ValidarCelulaDescricao(THIS.grd_4c_Dados.Column7.txt_4c_CelDescricao)
1842:         ENDCASE
1843: 
1844:         RETURN
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * AbrirBuscaServicoGrade - lookup da coluna "Servico" em csSigCdPro.
1849:     *
1850:     * Legado (PRODUTO.Text1.Valid):
1851:     *   Select csSigCdPro
1852:     *   Set Order to CPros
1853:     *   If !Seek(This.Value,[csSigCdPro],[IdeCPros])
1854:     *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','Cpros',This.Value,
1855:     *                               'Cadastro de Produtos')
1856:     *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
1857:     *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
1858:     *       loBrowse.Show
1859:     *       This.Value = CsSigCdPro.Cpros
1860:     *   Endif
1861:     *   Replace crTpmMvItn3.cpros with CrTmpPro.CPROS in crTpmMvItn3
1862:     *
1863:     * O browse eh sobre CURSOR LOCAL ja populado (fwbuscasel, nao fwbuscaext):
1864:     * a forma equivalente no projeto eh o FormBuscaAuxiliar sem parametros +
1865:     * DefinirCursor + Mostrar() - o Init com parametros consultaria o SQL
1866:     * Server e ignoraria o universo que CarregarServicosDisponiveis montou.
1867:     *
1868:     * DefinirCursor ZERA as colunas e as readiciona usando o NOME DO CAMPO como
1869:     * caption; por isso this_nColunas eh zerado e as duas colunas sao remontadas
1870:     * com os captions do legado ("Codigo"/"Descricao"), senao a grade do picker
1871:     * abriria com cabecalho "Cpros"/"Dpros".
1872:     *
1873:     * O codigo digitado NAO eh apagado quando o usuario desiste (regra #50):
1874:     * so o que o legado apaga - nada - eh apagado. Universo vazio tambem nao
1875:     * gera aviso: operacao sem servicos habilitados tem lista vazia por regra.
1876:     *--------------------------------------------------------------------------
1877:     PROTECTED PROCEDURE AbrirBuscaServicoGrade(par_oTxt)
1878:         LOCAL loc_cDigitado, loc_cLista, loc_oBusca, loc_lAchou
1879: 
1880:         IF VARTYPE(par_oTxt) != "O"
1881:             RETURN
1882:         ENDIF
1883: 
1884:         loc_cDigitado = ALLTRIM(par_oTxt.Value)
1885:         loc_cLista    = THIS.this_cCursorLista
1886: 
1887:         IF EMPTY(loc_cDigitado) OR !USED(loc_cLista)
1888:             RETURN
1889:         ENDIF
1890: 
1891:         *-- Seek do legado, feito por LOCATE (ver nota de EXACT em
1892:         *-- CarregarServicosDisponiveis)
1893:         SELECT (loc_cLista)
1894:         GO TOP
1895:         LOCATE FOR ALLTRIM(Cpros) == loc_cDigitado
1896:         loc_lAchou = FOUND()
1897: 
1898:         IF !loc_lAchou
1899:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1900: 
1901:             IF VARTYPE(loc_oBusca) = "O"
1902:                 loc_oBusca.DefinirCursor(loc_cLista, "Cpros", "Dpros", ;
1903:                                          "Cadastro de Produtos")
1904:                 loc_oBusca.this_nColunas = 0
1905:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
1906:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1907: 
1908:                 IF loc_oBusca.Mostrar()
1909:                     loc_lAchou = .T.
1910:                     par_oTxt.Value = loc_oBusca.cCodigoSelecionado
1911:                 ENDIF
1912: 
1913:                 loc_oBusca.Release()
1914:             ENDIF
1915:         ENDIF
1916: 
1917:         IF loc_lAchou
1918:             THIS.AplicarServicoNaLinha(par_oTxt.Value)
1919:         ENDIF
1920: 
1921:         RETURN
1922:     ENDPROC
1923: 
1924:     *--------------------------------------------------------------------------
1925:     * AbrirBuscaDescricaoGrade - lookup da coluna "Descricao" em csSigCdPro.
1926:     *
1927:     * Legado (Descricao.Text1.Valid):
1928:     *   Select csSigCdPro
1929:     *   Go Top In csSigCdPro
1930:     *   Locate For DPros = This.Value
1931:     *   If Eof([csSigCdPro])
1932:     *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','DPros',This.Value,
1933:     *                               'Cadastro de Produtos')
1934:     *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
1935:     *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
1936:     *       loBrowse.Show
1937:     *       This.Value = CsSigCdPro.DPros
1938:     *   Endif
1939:     *
1940:     * A ORDEM das colunas eh invertida de proposito: na busca por descricao o
1941:     * legado poe Descricao na frente, e eh o que o usuario ve no picker.
1942:     *
1943:     * O Locate do legado usa "=" (comparacao por PREFIXO quando EXACT esta
1944:     * desligado). Como o projeto roda com SET EXACT ON, a busca eh feita em
1945:     * duas etapas - primeiro a descricao INTEIRA, depois por prefixo - para
1946:     * reproduzir o comportamento do legado sem depender do estado de EXACT.
1947:     *--------------------------------------------------------------------------
1948:     PROTECTED PROCEDURE AbrirBuscaDescricaoGrade(par_oTxt)
1949:         LOCAL loc_cDigitado, loc_cLista, loc_oBusca, loc_lAchou
1950: 
1951:         IF VARTYPE(par_oTxt) != "O"
1952:             RETURN
1953:         ENDIF
1954: 
1955:         loc_cDigitado = ALLTRIM(par_oTxt.Value)
1956:         loc_cLista    = THIS.this_cCursorLista
1957: 
1958:         IF EMPTY(loc_cDigitado) OR !USED(loc_cLista)
1959:             RETURN
1960:         ENDIF
1961: 
1962:         SELECT (loc_cLista)
1963:         GO TOP
1964:         LOCATE FOR ALLTRIM(Dpros) == loc_cDigitado
1965: 
1966:         IF !FOUND()
1967:             GO TOP
1968:             LOCATE FOR UPPER(ALLTRIM(Dpros)) = UPPER(loc_cDigitado)
1969:         ENDIF
1970: 
1971:         loc_lAchou = FOUND()
1972: 
1973:         IF !loc_lAchou
1974:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1975: 
1976:             IF VARTYPE(loc_oBusca) = "O"
1977:                 loc_oBusca.DefinirCursor(loc_cLista, "Dpros", "Cpros", ;
1978:                                          "Cadastro de Produtos")
1979:                 loc_oBusca.this_nColunas = 0
1980:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1981:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
1982: 
1983:                 IF loc_oBusca.Mostrar()
1984:                     loc_lAchou = .T.
1985:                     par_oTxt.Value = loc_oBusca.cCodigoSelecionado
1986:                 ENDIF
1987: 
1988:                 loc_oBusca.Release()
1989:             ENDIF
1990:         ENDIF
1991: 
1992:         IF loc_lAchou
1993:             THIS.AplicarServicoNaLinha(ALLTRIM(EVALUATE(loc_cLista + ".Cpros")))
1994:         ENDIF
1995: 
1996:         RETURN
1997:     ENDPROC
1998: 
1999:     *--------------------------------------------------------------------------
2000:     * AplicarServicoNaLinha - grava na linha corrente da grade o servico que o
2001:     * lookup resolveu.
2002:     *
2003:     * Legado, comum aos dois Valid:
2004:     *   Replace crTpmMvItn3.cpros with CrTmpPro.CPROS in crTpmMvItn3
2005:     *   cpro = Evaluate('CrTmpPro.CPros') / dpro = Evaluate('crtmpPro.DPros')
2006:     *
2007:     * O codigo e a descricao vem do MESMO registro de csSigCdPro que o lookup
2008:     * posicionou, entao nao ha segunda consulta a fazer: o legado so reconsulta
2009:     * SigCdPro porque precisa das outras vinte colunas (preco, moeda, unidade)
2010:     * usadas no calculo do item.
2011:     *--------------------------------------------------------------------------
2012:     PROTECTED PROCEDURE AplicarServicoNaLinha(par_cCpros)
2013:         LOCAL loc_cLista, loc_cCodigo, loc_cDescricao
2014: 
2015:         loc_cLista  = THIS.this_cCursorLista
2016:         loc_cCodigo = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")
2017: 
2018:         IF EMPTY(loc_cCodigo) OR !USED(loc_cLista)
2019:             RETURN
2020:         ENDIF
2021: 
2022:         SELECT (loc_cLista)
2023:         GO TOP
2024:         LOCATE FOR ALLTRIM(Cpros) == loc_cCodigo
2025: 
2026:         IF !FOUND()
2027:             RETURN
2028:         ENDIF
2029: 
2030:         loc_cDescricao = ALLTRIM(EVALUATE(loc_cLista + ".Dpros"))
2031: 
2032:         IF USED(THIS.this_cCursorServicos)
2033:             SELECT (THIS.this_cCursorServicos)
2034: 
2035:             IF !EOF()
2036:                 REPLACE cpros WITH loc_cCodigo, ;
2037:                         dpros WITH loc_cDescricao
2038:             ENDIF
2039:         ENDIF
2040: 
2041:         WITH THIS.grd_4c_Dados
2042:             IF PEMSTATUS(.Column1, "txt_4c_CelServico", 5)
2043:                 .Column1.txt_4c_CelServico.Value = loc_cCodigo
2044:             ENDIF
2045: 
2046:             IF PEMSTATUS(.Column7, "txt_4c_CelDescricao", 5)
2047:                 .Column7.txt_4c_CelDescricao.Value = loc_cDescricao
2048:             ENDIF
2049: 
2050:             .Refresh()
2051:         ENDWITH
2052: 
2053:         RETURN
2054:     ENDPROC
2055: 
2056:     *--------------------------------------------------------------------------

*-- Linhas 2071 a 2114:
2071:     * fica "VISUALIZAR": eh o modo que nao grava nada, e eh o default seguro -
2072:     * os When do legado so liberam digitacao em INSERIR e ALTERAR.
2073:     *--------------------------------------------------------------------------
2074:     PROTECTED PROCEDURE ResolverModoOperacao()
2075:         LOCAL loc_cModo, loc_lEdServicos
2076: 
2077:         loc_cModo       = ""
2078:         loc_lEdServicos = .F.
2079: 
2080:         *-- ParentForm.EdServicos do legado
2081:         IF VARTYPE(THIS.this_oFormPai) = "O"
2082:             IF PEMSTATUS(THIS.this_oFormPai, "EdServicos", 5)
2083:                 IF VARTYPE(THIS.this_oFormPai.EdServicos) = "L"
2084:                     loc_lEdServicos = THIS.this_oFormPai.EdServicos
2085:                 ENDIF
2086:             ENDIF
2087:         ENDIF
2088: 
2089:         IF loc_lEdServicos
2090:             loc_cModo = "ALTERAR"
2091:         ELSE
2092:             *-- poForm.op_Escolha do legado, nas grafias usadas pelos forms de
2093:             *-- movimento ja migrados
2094:             IF VARTYPE(THIS.this_oFormChamador) = "O"
2095:                 IF PEMSTATUS(THIS.this_oFormChamador, "this_cOpEscolha", 5)
2096:                     IF VARTYPE(THIS.this_oFormChamador.this_cOpEscolha) = "C"
2097:                         loc_cModo = ALLTRIM(THIS.this_oFormChamador.this_cOpEscolha)
2098:                     ENDIF
2099:                 ENDIF
2100: 
2101:                 IF EMPTY(loc_cModo) AND PEMSTATUS(THIS.this_oFormChamador, "this_cModoAtual", 5)
2102:                     IF VARTYPE(THIS.this_oFormChamador.this_cModoAtual) = "C"
2103:                         loc_cModo = ALLTRIM(THIS.this_oFormChamador.this_cModoAtual)
2104:                     ENDIF
2105:                 ENDIF
2106:             ENDIF
2107:         ENDIF
2108: 
2109:         IF EMPTY(loc_cModo) OR UPPER(loc_cModo) == "LISTA"
2110:             loc_cModo = "VISUALIZAR"
2111:         ENDIF
2112: 
2113:         THIS.this_cOpEscolha = UPPER(loc_cModo)
2114:         THIS.this_cModoAtual = THIS.this_cOpEscolha

*-- Linhas 2140 a 2183:
2140:     * dentro do Init do dialogo, na sessao de dados do CHAMADOR, e deixar outra
2141:     * area selecionada mudaria o alias corrente de quem abriu a tela.
2142:     *--------------------------------------------------------------------------
2143:     PROTECTED PROCEDURE ConfigurarContextoBO()
2144:         LOCAL loc_nAreaAnterior
2145: 
2146:         loc_nAreaAnterior = SELECT()
2147: 
2148:         WITH THIS.this_oBusinessObject
2149:             .this_cCursorAlias       = THIS.this_cCursorServicos
2150:             .this_lGarantia          = THIS.this_lGarantia
2151:             .this_lValorZeroGarantia = THIS.this_lValorZeroGarantia
2152:         ENDWITH
2153: 
2154:         *-- Legado: Thisform.CItem = crTpmMvItn.CItens
2155:         IF USED(THIS.this_cCursorItem)
2156:             SELECT (THIS.this_cCursorItem)
2157: 
2158:             IF !EOF()
2159:                 THIS.this_nCItem = TratarNulo(citens, 0)
2160: 
2161:                 WITH THIS.this_oBusinessObject
2162:                     .this_nCitemProduto = THIS.this_nCItem
2163:                     .this_cEmps         = TratarNulo(emps, "")
2164:                     .this_cDopes        = TratarNulo(dopes, "")
2165:                     .this_nNumes        = TratarNulo(numes, 0)
2166:                 ENDWITH
2167:             ENDIF
2168:         ENDIF
2169: 
2170:         *-- Cabecalho do movimento: eh de TprMvCab que o mInsereLinha legado le
2171:         *-- Emps/Dopes/Numes quando o cursor do item nao esta posicionado
2172:         IF EMPTY(THIS.this_oBusinessObject.this_cDopes) AND USED(THIS.this_cCursorCabecalho)
2173:             SELECT (THIS.this_cCursorCabecalho)
2174: 
2175:             IF !EOF()
2176:                 WITH THIS.this_oBusinessObject
2177:                     .this_cEmps  = TratarNulo(emps, "")
2178:                     .this_cDopes = TratarNulo(dopes, "")
2179:                     .this_nNumes = TratarNulo(numes, 0)
2180:                 ENDWITH
2181:             ENDIF
2182:         ENDIF
2183: 

*-- Linhas 2216 a 2332:
2216:     * com a grade vazia, como o legado tambem faz quando a consulta nao traz
2217:     * linha. O retorno .F. nao impede a abertura.
2218:     *--------------------------------------------------------------------------
2219:     PROCEDURE CarregarLista()
2220:         LOCAL loc_lSucesso, loc_nAreaAnterior, loc_oErro
2221: 
2222:         loc_lSucesso      = .F.
2223:         loc_nAreaAnterior = SELECT()
2224: 
2225:         TRY
2226:             *-- 1. Configuracao da operacao (casas decimais, moeda, filtros)
2227:             THIS.CarregarConfiguracaoOperacao()
2228: 
2229:             *-- 1.1 Universo de servicos consultado pelos dois lookups da
2230:             *--     grade (csSigCdPro). Depende de HabServs/ItSituas, lidos
2231:             *--     no passo anterior
2232:             THIS.CarregarServicosDisponiveis()
2233: 
2234:             *-- 2. Cursor das descricoes por linha (csTmpDesc)
2235:             THIS.CriarCursorDescricoes()
2236: 
2237:             *-- 3. Linha em branco para digitacao, so em INSERIR/ALTERAR
2238:             THIS.GarantirLinhaEmBranco()
2239: 
2240:             *-- 4. Numeracao das linhas + relacao com a grade
2241:             THIS.MontarDescricoesPorLinha()
2242: 
2243:             *-- 5. Marca as linhas que ja tem faixa de tamanho preenchida
2244:             THIS.MarcarConfirmacaoTamanho()
2245: 
2246:             *-- 6. RecordSource, ControlSource das 7 colunas e mascara do valor
2247:             THIS.VincularGrade()
2248: 
2249:             *-- 7. Posiciona e REPINTA (cursor cheio nao redesenha a grade
2250:             *--    sozinho: sem GO + Refresh a grade fica visualmente vazia)
2251:             THIS.PosicionarGrade()
2252: 
2253:             loc_lSucesso = .T.
2254:         CATCH TO loc_oErro
2255:             THIS.this_cMensagemErro = loc_oErro.Message
2256:             MsgErro(loc_oErro.Message + CHR(13) + ;
2257:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2258:                     "Procedure: " + loc_oErro.Procedure, ;
2259:                     "Erro ao carregar a grade de servi" + CHR(231) + "os")
2260:         ENDTRY
2261: 
2262:         IF loc_nAreaAnterior > 0
2263:             SELECT (loc_nAreaAnterior)
2264:         ENDIF
2265: 
2266:         RETURN loc_lSucesso
2267:     ENDPROC
2268: 
2269:     *--------------------------------------------------------------------------
2270:     * CarregarConfiguracaoOperacao - CrSigCdOpe do legado.
2271:     *
2272:     * Legado:
2273:     *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe', ;
2274:     *                                              'Dopes', TprMvCab.Dopes)
2275:     *
2276:     * De CrSigCdOpe saem as casas decimais do valor unitario (usadas na mascara
2277:     * da coluna VALOR), a moeda padrao, os flags de preco e os dois filtros que
2278:     * CarregarServicosDisponiveis usa para montar o universo de servicos
2279:     * consultado pelos lookups da grade (HabServs e ItSituas).
2280:     * Todos ficam nas propriedades do BO.
2281:     *
2282:     * Duas origens, nesta ordem: (a) o cursor que o CHAMADOR ja abriu - este
2283:     * dialogo roda na sessao de dados dele; (b) consulta propria ao SigCdOpe,
2284:     * que eh o equivalente do Cursorquery legado quando o chamador nao trouxe o
2285:     * cursor. Sem conexao e sem cursor as propriedades ficam no default do BO,
2286:     * e a mascara cai nas 2 casas minimas - o mesmo que o legado faz com
2287:     * Casas = 0, por causa do Iif(Casas < 2, 2, Casas) da formula.
2288:     *
2289:     * SigCdOpe tem Dopes como chave E descricao ao mesmo tempo: NAO existe
2290:     * coluna descrs nessa tabela.
2291:     *--------------------------------------------------------------------------
2292:     PROTECTED PROCEDURE CarregarConfiguracaoOperacao()
2293:         LOCAL loc_cDopes, loc_cSQL, loc_nResultado, loc_lAchou
2294: 
2295:         loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
2296:         loc_lAchou = .F.
2297: 
2298:         *-- (a) cursor da operacao que o chamador ja montou
2299:         IF USED(THIS.this_cCursorOperacao)
2300:             SELECT (THIS.this_cCursorOperacao)
2301: 
2302:             IF !EMPTY(loc_cDopes)
2303:                 LOCATE FOR ALLTRIM(dopes) == loc_cDopes
2304:             ELSE
2305:                 GO TOP
2306:             ENDIF
2307: 
2308:             loc_lAchou = !EOF()
2309:         ENDIF
2310: 
2311:         *-- (b) consulta propria - o Cursorquery do legado
2312:         IF !loc_lAchou AND !EMPTY(loc_cDopes) ;
2313:            AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2314: 
2315:             loc_cSQL = "SELECT Dopes, Casas, ZerQtds, PrecoAuts," + ;
2316:                        " PrecoPs, Precops, CMoes, ItSituas, HabServs" + ;
2317:                        " FROM SigCdOpe" + ;
2318:                        " WHERE Dopes = " + EscaparSQL(loc_cDopes)
2319: 
2320:             IF USED(THIS.this_cCursorOperacao)
2321:                 IF CURSORGETPROP("Buffering", THIS.this_cCursorOperacao) > 1
2322:                     TABLEREVERT(.T., THIS.this_cCursorOperacao)
2323:                 ENDIF
2324:                 USE IN (THIS.this_cCursorOperacao)
2325:             ENDIF
2326: 
2327:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)
2328: 
2329:             IF loc_nResultado < 0
2330:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
2331:                         "configura" + CHR(231) + CHR(227) + "o da opera" + ;
2332:                         CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), ;

*-- Linhas 2384 a 2474:
2384:     * USE IN fecha o alias mesmo com buffer sujo. Por isso o teste de
2385:     * CURSORGETPROP antes.
2386:     *--------------------------------------------------------------------------
2387:     PROTECTED PROCEDURE CriarCursorDescricoes()
2388:         IF USED(THIS.this_cCursorDescricoes)
2389:             IF CURSORGETPROP("Buffering", THIS.this_cCursorDescricoes) > 1
2390:                 TABLEREVERT(.T., THIS.this_cCursorDescricoes)
2391:             ENDIF
2392:             USE IN (THIS.this_cCursorDescricoes)
2393:         ENDIF
2394: 
2395:         CREATE CURSOR csTmpDesc ( nLinhas   N(4), ;
2396:                                   nControle N(8), ;
2397:                                   cDescTams C(20), ;
2398:                                   cDescCors C(40), ;
2399:                                   cDescEmbs C(20) )
2400: 
2401:         INDEX ON STR(nControle, 8) TAG iControle
2402: 
2403:         RETURN
2404:     ENDPROC
2405: 
2406:     *--------------------------------------------------------------------------
2407:     * GarantirLinhaEmBranco - a linha vazia para digitacao.
2408:     *
2409:     * Legado (Init):
2410:     *   If InList(Thisform.Op_Escolha,'INSERIR','ALTERAR')
2411:     *       Select * From crTpmMvItn3 ;
2412:     *              Where CItens = crTpmMvItn.CItens And IsEmpty(Qtds) ;
2413:     *              Into Cursor csTemp
2414:     *       If _Tally = 0
2415:     *           Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens) Values ;
2416:     *                  ( crTpmMvItn.Emps, crTpmMvItn.Dopes, ;
2417:     *                    crTpmMvItn.Numes, crTpmMvItn.CItens )
2418:     *       Endif
2419:     *   EndIf
2420:     *
2421:     * Ou seja: em INSERIR/ALTERAR a grade sempre termina com UMA linha de
2422:     * quantidade zerada, que eh onde o usuario digita o proximo servico - e so
2423:     * UMA, dai a contagem antes de inserir. Em VISUALIZAR nada eh acrescentado.
2424:     *
2425:     * A insercao vai pelo BO (sigopserBO.Inserir), que grava exatamente as
2426:     * mesmas quatro colunas de contexto; as demais propriedades de LINHA sao
2427:     * zeradas antes para a linha nascer em branco mesmo quando o BO acabou de
2428:     * carregar outro servico (CarregarLista eh chamada de novo pelos handlers).
2429:     *
2430:     * O SELECT de contagem leva WHERE proprio porque SELECT IGNORA o SET KEY /
2431:     * SET FILTER que escopa a grade - contar sem o WHERE traria os servicos de
2432:     * TODOS os itens do documento e a linha em branco nunca seria criada.
2433:     *--------------------------------------------------------------------------
2434:     PROTECTED PROCEDURE GarantirLinhaEmBranco()
2435:         LOCAL loc_nVazias, loc_nAreaAnterior, loc_cServicos, loc_nItem
2436: 
2437:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2438:             RETURN
2439:         ENDIF
2440: 
2441:         IF !USED(THIS.this_cCursorServicos)
2442:             RETURN
2443:         ENDIF
2444: 
2445:         loc_nAreaAnterior = SELECT()
2446:         loc_cServicos     = THIS.this_cCursorServicos
2447:         loc_nItem         = THIS.this_nCItem
2448: 
2449:         *-- O alias entra por MACRO: a clausula FROM do SELECT do VFP nao aceita
2450:         *-- nome entre parenteses (ao contrario do comando SELECT <alias>), e
2451:         *-- "&var." expande ANTES do parse, deixando o nome literal na consulta.
2452:         *-- O item vai numa variavel com prefixo "m." para o VFP nao tentar
2453:         *-- resolver o nome como COLUNA do cursor.
2454:         SELECT COUNT(*) AS nVazias ;
2455:             FROM &loc_cServicos. ;
2456:             WHERE citens = m.loc_nItem AND EMPTY(qtds) ;
2457:             INTO CURSOR cursor_4c_SerVazias NOFILTER
2458: 
2459:         loc_nVazias = 0
2460: 
2461:         IF USED("cursor_4c_SerVazias")
2462:             SELECT cursor_4c_SerVazias
2463:             IF !EOF()
2464:                 loc_nVazias = TratarNulo(nVazias, 0)
2465:             ENDIF
2466:             USE IN cursor_4c_SerVazias
2467:         ENDIF
2468: 
2469:         IF loc_nVazias = 0
2470:             *-- Linha NOVA: as colunas de servico tem de estar limpas, senao a
2471:             *-- linha nasceria com os dados do servico lido por ultimo
2472:             THIS.LimparDadosLinhaBO()
2473: 
2474:             IF !THIS.this_oBusinessObject.Inserir()

*-- Linhas 2505 a 2548:
2505:     * terminou e "THIS" nao existe mais - a expressao tem de sair daqui com o
2506:     * NUMERO do item ja embutido.
2507:     *--------------------------------------------------------------------------
2508:     PROTECTED PROCEDURE AplicarEscopoItem()
2509:         LOCAL loc_nI, loc_lTemTag, loc_cFiltro, loc_nItem
2510: 
2511:         IF !USED(THIS.this_cCursorServicos)
2512:             RETURN
2513:         ENDIF
2514: 
2515:         SELECT (THIS.this_cCursorServicos)
2516: 
2517:         loc_nItem   = THIS.this_nCItem
2518:         loc_lTemTag = .F.
2519: 
2520:         FOR loc_nI = 1 TO TAGCOUNT("", THIS.this_cCursorServicos)
2521:             IF UPPER(ALLTRIM(TAG(loc_nI, THIS.this_cCursorServicos))) == "CITENS"
2522:                 loc_lTemTag = .T.
2523:                 EXIT
2524:             ENDIF
2525:         ENDFOR
2526: 
2527:         IF loc_lTemTag
2528:             SET ORDER TO TAG CItens
2529:             SET KEY TO loc_nItem
2530:         ELSE
2531:             loc_cFiltro = "citens = " + ALLTRIM(STR(loc_nItem))
2532:             SET FILTER TO &loc_cFiltro.
2533:         ENDIF
2534: 
2535:         RETURN
2536:     ENDPROC
2537: 
2538:     *--------------------------------------------------------------------------
2539:     * MontarDescricoesPorLinha - numeracao das linhas e relacao com a grade.
2540:     *
2541:     * Legado (Init):
2542:     *   Select crTpmMvItn3 / Set Order To Citens / Set Key to ThisForm.CItem
2543:     *   Goto Bott
2544:     *   Thisform.nCItem2 = 1
2545:     *   Scan
2546:     *       Insert Into csTmpDesc ( nControle, nLinhas ) Values ;
2547:     *              ( RecNo('crTpmMvItn3'), Thisform.nCItem2 )
2548:     *       Thisform.nCItem2 = Thisform.nCItem2 + 1

*-- Linhas 2562 a 2605:
2562:     * A relacao propriamente dita (e o SET ORDER do lado filho que ela exige)
2563:     * esta em AplicarRelacaoDescricoes, chamado no fim deste metodo.
2564:     *--------------------------------------------------------------------------
2565:     PROTECTED PROCEDURE MontarDescricoesPorLinha()
2566:         IF !USED(THIS.this_cCursorServicos) OR !USED(THIS.this_cCursorDescricoes)
2567:             RETURN
2568:         ENDIF
2569: 
2570:         *-- Escopo do item (Set Order / Set Key do legado)
2571:         THIS.AplicarEscopoItem()
2572: 
2573:         *-- Legado: Thisform.nCItem2 = 1 antes de percorrer
2574:         THIS.this_nCItem2 = 1
2575: 
2576:         SELECT (THIS.this_cCursorServicos)
2577:         GO TOP
2578: 
2579:         SCAN
2580:             INSERT INTO csTmpDesc (nControle, nLinhas) ;
2581:                 VALUES (RECNO(THIS.this_cCursorServicos), THIS.this_nCItem2)
2582: 
2583:             THIS.this_nCItem2 = THIS.this_nCItem2 + 1
2584: 
2585:             SELECT (THIS.this_cCursorServicos)
2586:         ENDSCAN
2587: 
2588:         SELECT (THIS.this_cCursorServicos)
2589:         GO TOP
2590: 
2591:         *-- SET ORDER do lado FILHO + SET RELATION, em metodo unico porque o
2592:         *-- legado repete os dois comandos tambem no mInsereLinha
2593:         THIS.AplicarRelacaoDescricoes()
2594: 
2595:         RETURN
2596:     ENDPROC
2597: 
2598:     *--------------------------------------------------------------------------
2599:     * MarcarConfirmacaoTamanho - o iconfs das linhas que ja tem faixa.
2600:     *
2601:     * Legado (Init):
2602:     *   Select crTpmMvItn3 / Go Top
2603:     *   Scan
2604:     *       If Not Empty(TamDe) and Not Empty(TamPara)
2605:     *           replace iconfs With .T. In crTpmMvItn3

*-- Linhas 2618 a 2661:
2618:     * o valor compativel - comparar ou gravar o tipo errado dispara
2619:     * "Operator/operand type mismatch".
2620:     *--------------------------------------------------------------------------
2621:     PROTECTED PROCEDURE MarcarConfirmacaoTamanho()
2622:         LOCAL loc_lColunaLogica
2623: 
2624:         IF !USED(THIS.this_cCursorServicos)
2625:             RETURN
2626:         ENDIF
2627: 
2628:         SELECT (THIS.this_cCursorServicos)
2629:         GO TOP
2630: 
2631:         IF EOF()
2632:             RETURN
2633:         ENDIF
2634: 
2635:         loc_lColunaLogica = (VARTYPE(iconfs) = "L")
2636: 
2637:         *-- O "In crTpmMvItn3" do legado eh redundante aqui: o SCAN roda sobre a
2638:         *-- area que acabou de ser selecionada, entao o REPLACE sem clausula IN
2639:         *-- atinge exatamente o mesmo registro
2640:         SCAN
2641:             IF !EMPTY(tamde) AND !EMPTY(tampara)
2642:                 IF loc_lColunaLogica
2643:                     REPLACE iconfs WITH .T.
2644:                 ELSE
2645:                     REPLACE iconfs WITH 1
2646:                 ENDIF
2647:             ENDIF
2648: 
2649:             SELECT (THIS.this_cCursorServicos)
2650:         ENDSCAN
2651: 
2652:         RETURN
2653:     ENDPROC
2654: 
2655:     *--------------------------------------------------------------------------
2656:     * VincularGrade - RecordSource e ControlSource das sete colunas.
2657:     *
2658:     * Legado (Init):
2659:     *   With Thisform.fwgrade
2660:     *       .Recordsource            = 'crTpmMvItn3'
2661:     *       .Item.ControlSource      = "csTmpDesc.nLinhas"

*-- Linhas 2694 a 2772:
2694:     * atribuida quando aquele cursor esta aberto: expressao dinamica sobre alias
2695:     * fechado estoura no Refresh.
2696:     *--------------------------------------------------------------------------
2697:     PROTECTED PROCEDURE VincularGrade()
2698:         LOCAL loc_cMascara, loc_nCasas, loc_cServicos
2699: 
2700:         IF !USED(THIS.this_cCursorServicos)
2701:             RETURN
2702:         ENDIF
2703: 
2704:         loc_cServicos = THIS.this_cCursorServicos
2705: 
2706:         *-- Mascara do valor unitario (formula transcrita do legado)
2707:         loc_nCasas   = THIS.this_oBusinessObject.this_nCasas
2708:         loc_cMascara = "99999999." + REPLICATE("9", IIF(loc_nCasas < 2, 2, loc_nCasas))
2709:         loc_cMascara = RIGHT(loc_cMascara, 11)
2710: 
2711:         WITH THIS.grd_4c_Dados
2712:             .RecordSource = loc_cServicos
2713: 
2714:             .Column1.ControlSource = loc_cServicos + ".cpros"
2715:             .Column2.ControlSource = loc_cServicos + ".qtds"
2716:             .Column3.ControlSource = loc_cServicos + ".units"
2717:             .Column4.ControlSource = loc_cServicos + ".moedas"
2718:             .Column5.ControlSource = loc_cServicos + ".totas"
2719:             .Column7.ControlSource = loc_cServicos + ".dpros"
2720:         ENDWITH
2721: 
2722:         *-- Coluna "item": numero sequencial vindo de csTmpDesc pela relacao
2723:         IF USED(THIS.this_cCursorDescricoes)
2724:             THIS.grd_4c_Dados.Column6.ControlSource = ;
2725:                 THIS.this_cCursorDescricoes + ".nLinhas"
2726:         ENDIF
2727: 
2728:         *-- Mascara calculada, na Column E no Text1 que desenha a celula
2729:         THIS.grd_4c_Dados.Column3.InputMask       = loc_cMascara
2730:         THIS.grd_4c_Dados.Column3.Text1.InputMask = loc_cMascara
2731: 
2732:         *-- Larguras REAPLICADAS: o RecordSource acima as devolveu ao default
2733:         WITH THIS.grd_4c_Dados
2734:             .Column1.Width = 120    && PRODUTO
2735:             .Column2.Width = 120    && QTD
2736:             .Column3.Width = 120    && VALOR
2737:             .Column4.Width = 33     && MOEDA
2738:             .Column5.Width = 120    && TOTAL
2739:             .Column6.Width = 31     && item
2740:             .Column7.Width = 404    && Descricao
2741:         ENDWITH
2742: 
2743:         *-- Captions REAPLICADOS pelo mesmo motivo das larguras
2744:         WITH THIS.grd_4c_Dados
2745:             .Column1.Header1.Caption = "Servi" + CHR(231) + "o"
2746:             .Column2.Header1.Caption = "Quantidade"
2747:             .Column3.Header1.Caption = "Valor"
2748:             .Column4.Header1.Caption = "Moe"
2749:             .Column5.Header1.Caption = "Total"
2750:             .Column6.Header1.Caption = ""
2751:             .Column7.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
2752:                                        "o do Servi" + CHR(231) + "o"
2753:         ENDWITH
2754: 
2755:         *-- Cor dinamica da quantidade (expressao literal do SCX legado)
2756:         IF USED(THIS.this_cCursorItem)
2757:             THIS.grd_4c_Dados.Column2.DynamicForeColor = ;
2758:                 "IIF(" + THIS.this_cCursorItem + ".iconfs = .T.," + ;
2759:                 " RGB(0,0,255), RGB(0,0,0))"
2760:         ENDIF
2761: 
2762:         *-- REINSTALADAS aqui, e nao so na inicializacao: o RecordSource/
2763:         *-- ControlSource atribuidos acima devolvem Sparse e CurrentControl ao
2764:         *-- default, e as duas celulas de lookup voltariam a ser o Text1 da
2765:         *-- coluna, sem o When/Valid do legado
2766:         THIS.InstalarCelulasLookup()
2767: 
2768:         *-- Idem para as celulas de quantidade e de valor, e para o ReadOnly
2769:         *-- das tres colunas somente-exibicao (o "Return .f." do When delas)
2770:         THIS.InstalarCelulasEdicao()
2771: 
2772:         RETURN

*-- Linhas 2795 a 3039:
2795:     * sem ele a tela aparece vazia com o cursor cheio - sintoma que manda o
2796:     * diagnostico para o SQL quando o problema eh so de repintura.
2797:     *--------------------------------------------------------------------------
2798:     PROTECTED PROCEDURE PosicionarGrade()
2799:         IF USED(THIS.this_cCursorServicos)
2800:             SELECT (THIS.this_cCursorServicos)
2801: 
2802:             IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2803:                 GO BOTTOM
2804:             ELSE
2805:                 GO TOP
2806:             ENDIF
2807:         ENDIF
2808: 
2809:         THIS.grd_4c_Dados.Refresh()
2810: 
2811:         RETURN
2812:     ENDPROC
2813: 
2814:     *--------------------------------------------------------------------------
2815:     * Activate - foco inicial na grade.
2816:     *
2817:     * Legado (fim do Init): Thisform.fwgrade.produto.setfocus
2818:     *
2819:     * O legado pede o foco dentro do proprio Init; aqui ele eh dado no Activate
2820:     * porque durante o Init a janela ainda nao esta na tela e SetFocus em
2821:     * controle de form invisivel falha. O resultado para o usuario eh o mesmo:
2822:     * ao abrir, o cursor de digitacao esta na coluna do servico.
2823:     *
2824:     * Dispara UMA vez (Activate de form modal volta a disparar a cada vez que a
2825:     * janela reassume o foco, e insistir no SetFocus roubaria o foco de quem o
2826:     * usuario acabou de escolher). Grade sem linha nao recebe foco: ActivateCell
2827:     * sobre grade vazia estoura.
2828:     *--------------------------------------------------------------------------
2829:     PROCEDURE Activate()
2830:         DODEFAULT()
2831: 
2832:         IF THIS.this_lFocoInicialAplicado
2833:             RETURN
2834:         ENDIF
2835: 
2836:         THIS.this_lFocoInicialAplicado = .T.
2837: 
2838:         IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
2839:            AND USED(THIS.this_cCursorServicos) ;
2840:            AND RECCOUNT(THIS.this_cCursorServicos) > 0
2841: 
2842:             THIS.grd_4c_Dados.SetFocus()
2843:             THIS.grd_4c_Dados.Column1.SetFocus()
2844:         ENDIF
2845: 
2846:         RETURN
2847:     ENDPROC
2848: 
2849:     *--------------------------------------------------------------------------
2850:     * DesabilitarChamador / ReabilitarChamador - o "poForm.Enabled" do legado.
2851:     *
2852:     * O Init legado faz "poForm.Enabled = .f." e o btnSair.Click devolve
2853:     * "ThisForm.poForm.Enabled = .t." antes do Release. Como o dialogo pode ser
2854:     * fechado por outros caminhos (Esc, QueryUnload), a reabilitacao tambem eh
2855:     * chamada no Destroy: sem isso o chamador ficaria inerte e o usuario
2856:     * perderia a tela do documento. As duas sao idempotentes.
2857:     *
2858:     * ReabilitarChamador eh PUBLIC de proposito: o handler do botao Retornar
2859:     * (Fase 7) a chama, e metodo PROTECTED chamado de fora estoura em runtime.
2860:     *--------------------------------------------------------------------------
2861:     PROTECTED PROCEDURE DesabilitarChamador()
2862:         IF VARTYPE(THIS.this_oFormChamador) = "O"
2863:             IF PEMSTATUS(THIS.this_oFormChamador, "Enabled", 5)
2864:                 THIS.this_oFormChamador.Enabled = .F.
2865:             ENDIF
2866:         ENDIF
2867: 
2868:         RETURN
2869:     ENDPROC
2870: 
2871:     PROCEDURE ReabilitarChamador()
2872:         IF VARTYPE(THIS.this_oFormChamador) = "O"
2873:             IF PEMSTATUS(THIS.this_oFormChamador, "Enabled", 5)
2874:                 THIS.this_oFormChamador.Enabled = .T.
2875:             ENDIF
2876:         ENDIF
2877: 
2878:         RETURN
2879:     ENDPROC
2880: 
2881:     *==========================================================================
2882:     * FASE 7 - EVENTOS PRINCIPAIS
2883:     *
2884:     * Os quatro botoes que o SCX legado declara, com os handlers transcritos do
2885:     * dump, mais os eventos que dirigem a tela enquanto ela esta aberta (a
2886:     * troca de linha da grade e o gate de edicao dos campos de produto).
2887:     *
2888:     * NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
2889:     * BtnExcluirClick: este form NAO eh um cadastro CRUD. O legado herda de
2890:     * "form" puro (nao de frmcadastro), nao tem Grupo_Op nem pcEscolha
2891:     * proprios, e os seus QUATRO botoes sao btnTotItens / btnCotacao /
2892:     * btnAltImps / cntOK.btnSair. Inventar a barra CRUD aqui violaria o PILAR 1
2893:     * e produziria quatro metodos sem conteudo.
2894:     *
2895:     * O modo de operacao (this_cOpEscolha) eh HERDADO do chamador em
2896:     * ResolverModoOperacao - quem inclui/altera/visualiza o documento eh o form
2897:     * de Movimentacao que abriu este dialogo.
2898:     *==========================================================================
2899: 
2900:     *--------------------------------------------------------------------------
2901:     * VincularEventosPrincipais - liga os handlers aos objetos.
2902:     *
2903:     * BINDEVENT so funciona com metodo PUBLIC: handler PROTECTED falha em
2904:     * SILENCIO (regra #3). Por isso todos os alvos abaixo sao PUBLIC.
2905:     *
2906:     * O handler de AfterRowColChange declara o parametro nColIndex que o evento
2907:     * passa - handler sem o parametro estoura a cada troca de celula.
2908:     *
2909:     * Chamado no fim de InicializarForm, ANTES de CarregarLista, para que a
2910:     * troca de linha ja esteja ligada quando a grade for posicionada.
2911:     *--------------------------------------------------------------------------
2912:     PROTECTED PROCEDURE VincularEventosPrincipais()
2913:         *-- btnTotItens / btnCotacao / btnAltImps (Click do dump)
2914:         BINDEVENT(THIS.cmd_4c_BtnTotItens, "Click", THIS, "BtnTotItensClick")
2915:         BINDEVENT(THIS.cmd_4c_BtnCotacao,  "Click", THIS, "BtnCotacaoClick")
2916:         BINDEVENT(THIS.cmd_4c_BtnAltImps,  "Click", THIS, "BtnAltImpsClick")
2917: 
2918:         *-- cntOK.btnSair (o botao Retornar; membro 1 do CommandGroup)
2919:         BINDEVENT(THIS.cmg_4c_CntOK.Buttons(1), "Click", THIS, "BtnRetornarClick")
2920: 
2921:         *-- fwGrade.AfterRowColChange: mostra/esconde o painel "Tamanho" e
2922:         *-- carrega nele a faixa da linha corrente
2923:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
2924: 
2925:         RETURN
2926:     ENDPROC
2927: 
2928:     *--------------------------------------------------------------------------
2929:     * AplicarGatesDeEdicao - o "Return .f." do When dos tres campos de produto.
2930:     *
2931:     * Legado:
2932:     *   SIGOPSER.Get_Produto.When    -> Return .f.
2933:     *   SIGOPSER.Get_Descricao.When  -> Return .f.
2934:     *   SIGOPSER.Get_Mercs.When      -> Return .f.
2935:     *
2936:     * Os tres sao campos de EXIBICAO: mostram o produto dono dos servicos
2937:     * (preenchidos por CarregarServicosDisponiveis) e o legado nunca permite
2938:     * digitar neles.
2939:     *
2940:     * O gate NAO vai por BINDEVENT em "When": BINDEVENT DESCARTA o retorno do
2941:     * delegate, entao um When ligado assim nao bloqueia nada - o campo
2942:     * continuaria editavel e o defeito seria invisivel no codigo. ReadOnly = .T.
2943:     * eh o equivalente que o VFP9 oferece sem subclasse: o controle continua
2944:     * desenhado exatamente como no legado (ao contrario de Enabled = .F., que o
2945:     * acinzentaria e mudaria a tela) e nao aceita digitacao.
2946:     *--------------------------------------------------------------------------
2947:     PROTECTED PROCEDURE AplicarGatesDeEdicao()
2948:         THIS.txt_4c_Produto.ReadOnly   = .T.
2949:         THIS.txt_4c_Descricao.ReadOnly = .T.
2950:         THIS.txt_4c_Mercs.ReadOnly     = .T.
2951: 
2952:         RETURN
2953:     ENDPROC
2954: 
2955:     *--------------------------------------------------------------------------
2956:     * AtualizarEstadoBotoesServico - os When dos tres botoes de servico.
2957:     *
2958:     * Legado:
2959:     *   btnAltImps.When -> Inlist(Op_Escolha,[INSERIR],[ALTERAR]) And
2960:     *                      Not Eof([crTpmMvItn3])
2961:     *   btnCotacao.When -> Inlist(Op_Escolha,[INSERIR],[ALTERAR])
2962:     *   btnTotItens     -> NAO declara When (sempre liberado)
2963:     *
2964:     * A VISIBILIDADE nao eh tocada aqui: os tres nascem Visible = .F. no SCX e
2965:     * NENHUM trecho do legado os mostra - sao botoes desativados nesta tela (o
2966:     * SCX veio de uma copia da tela de Produtos, onde eles existem de fato).
2967:     * Mostra-los seria INVENTAR interface que o usuario nao tem hoje. O estado
2968:     * de Enabled eh mantido assim mesmo porque eh regra do legado.
2969:     *--------------------------------------------------------------------------
2970:     PROCEDURE AtualizarEstadoBotoesServico()
2971:         LOCAL loc_lEditando, loc_lTemLinha
2972: 
2973:         loc_lEditando = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2974:         loc_lTemLinha = .F.
2975: 
2976:         IF USED(THIS.this_cCursorServicos)
2977:             loc_lTemLinha = !EOF(THIS.this_cCursorServicos)
2978:         ENDIF
2979: 
2980:         THIS.cmd_4c_BtnTotItens.Enabled = .T.
2981:         THIS.cmd_4c_BtnCotacao.Enabled  = loc_lEditando
2982:         THIS.cmd_4c_BtnAltImps.Enabled  = loc_lEditando AND loc_lTemLinha
2983: 
2984:         RETURN
2985:     ENDPROC
2986: 
2987:     *--------------------------------------------------------------------------
2988:     * CarregarValoresTamanhoDaLinha - traz para o painel "Tamanho" a faixa da
2989:     * linha corrente da grade.
2990:     *
2991:     * Legado, nas DUAS vezes em que aparece (fim do Init e AfterRowColChange):
2992:     *   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
2993:     *   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
2994:     *
2995:     * Metodo unico porque o valor tem de ser o mesmo nos dois caminhos; sem
2996:     * cursor aberto ou em EOF os campos ficam vazios, que eh o que o legado
2997:     * tambem produz.
2998:     *--------------------------------------------------------------------------
2999:     PROCEDURE CarregarValoresTamanhoDaLinha()
3000:         LOCAL loc_lTemLinha, loc_nAreaAnterior
3001: 
3002:         loc_lTemLinha     = .F.
3003:         loc_nAreaAnterior = SELECT()
3004: 
3005:         IF USED(THIS.this_cCursorServicos)
3006:             SELECT (THIS.this_cCursorServicos)
3007: 
3008:             IF !EOF()
3009:                 loc_lTemLinha = THIS.this_oBusinessObject.CarregarDoCursor( ;
3010:                                     THIS.this_cCursorServicos)
3011:             ENDIF
3012:         ENDIF
3013: 
3014:         *-- Sem linha corrente o legado deixa os dois campos vazios: as
3015:         *-- propriedades da LINHA sao zeradas para que BOParaForm as espelhe
3016:         IF !loc_lTemLinha
3017:             THIS.LimparDadosLinhaBO()
3018:         ENDIF
3019: 
3020:         IF loc_nAreaAnterior > 0
3021:             SELECT (loc_nAreaAnterior)
3022:         ENDIF
3023: 
3024:         THIS.BOParaForm()
3025: 
3026:         RETURN
3027:     ENDPROC
3028: 
3029:     *--------------------------------------------------------------------------
3030:     * GradeAfterRowColChange - fwGrade.AfterRowColChange do legado.
3031:     *
3032:     * Legado:
3033:     *   LPARAMETERS nColIndex
3034:     *   Select crTpmMvItn3
3035:     *   If crTpmMvItn3.iconfs
3036:     *       ThisForm.cntTamanho.Visible = .T.
3037:     *   Else
3038:     *       ThisForm.cntTamanho.Visible = .F.
3039:     *   EndIf

*-- Linhas 3054 a 3200:
3054:     * ele estoura a CADA troca de celula (regra #3). Nao eh usado, como no
3055:     * legado.
3056:     *--------------------------------------------------------------------------
3057:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
3058:         LOCAL loc_lConfirma
3059: 
3060:         loc_lConfirma = .F.
3061: 
3062:         IF USED(THIS.this_cCursorServicos)
3063:             SELECT (THIS.this_cCursorServicos)
3064: 
3065:             IF !EOF()
3066:                 DO CASE
3067:                 CASE VARTYPE(iconfs) = "L"
3068:                     loc_lConfirma = iconfs
3069:                 CASE VARTYPE(iconfs) = "N"
3070:                     loc_lConfirma = (iconfs <> 0)
3071:                 CASE VARTYPE(iconfs) = "C"
3072:                     loc_lConfirma = (UPPER(LEFT(ALLTRIM(iconfs), 1)) == "S")
3073:                 ENDCASE
3074:             ENDIF
3075:         ENDIF
3076: 
3077:         THIS.cnt_4c_Tamanho.Visible = loc_lConfirma
3078: 
3079:         THIS.CarregarValoresTamanhoDaLinha()
3080: 
3081:         *-- O When de btnAltImps depende de Not Eof([crTpmMvItn3]), que acabou
3082:         *-- de mudar junto com a linha corrente
3083:         THIS.AtualizarEstadoBotoesServico()
3084: 
3085:         RETURN
3086:     ENDPROC
3087: 
3088:     *--------------------------------------------------------------------------
3089:     * TotalizarLinha - o "calc_valite" do legado (metodo de form).
3090:     *
3091:     * Legado:
3092:     *   PROCEDURE calc_valite
3093:     *   ThisForm.ParentForm.Calc_ValIte([crTpmMvItn3])
3094:     *   ThisForm.fwGrade.Refresh
3095:     *
3096:     * A aritmetica do total (unitario x quantidade, fator, moeda, descontos e
3097:     * impostos) eh regra de negocio que mora no Calc_ValIte do form de
3098:     * Movimentacao - esta tela so DELEGA e repinta. Reescrever a formula aqui
3099:     * gravaria valor diferente do legado, sem erro na tela (regra #17).
3100:     *
3101:     * O alias da grade vai como argumento porque eh assim que o legado chama: o
3102:     * Calc_ValIte do pai totaliza o cursor que recebe.
3103:     *
3104:     * PUBLIC: eh chamado pelos handlers de botao deste form, e eh o mesmo papel
3105:     * do metodo homonimo nos forms irmaos de movimentacao.
3106:     *--------------------------------------------------------------------------
3107:     PROCEDURE TotalizarLinha()
3108:         LOCAL loc_lSucesso, loc_oErro
3109: 
3110:         loc_lSucesso = .F.
3111: 
3112:         IF VARTYPE(THIS.this_oFormPai) = "O"
3113:             IF PEMSTATUS(THIS.this_oFormPai, "Calc_ValIte", 5)
3114:                 TRY
3115:                     THIS.this_oFormPai.Calc_ValIte(THIS.this_cCursorServicos)
3116:                     loc_lSucesso = .T.
3117:                 CATCH TO loc_oErro
3118:                     MsgErro("Erro ao totalizar os servi" + CHR(231) + "os:" + CHR(13) + ;
3119:                             loc_oErro.Message + CHR(13) + ;
3120:                             "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3121:                             "Procedure: " + loc_oErro.Procedure, ;
3122:                             "Erro em TotalizarLinha")
3123:                 ENDTRY
3124:             ENDIF
3125:         ENDIF
3126: 
3127:         THIS.grd_4c_Dados.Refresh()
3128: 
3129:         RETURN loc_lSucesso
3130:     ENDPROC
3131: 
3132:     *--------------------------------------------------------------------------
3133:     * BtnTotItensClick - btnTotItens.Click do legado ("Total de Servicos").
3134:     *
3135:     * Legado:
3136:     *   ThisForm.Enabled = .f.
3137:     *   Do Form SigOpTot With ThisForm, ThisForm.DataSessionId
3138:     *
3139:     * SigOpTot ainda NAO foi migrado. A chamada eh escrita no padrao do projeto
3140:     * (CREATEOBJECT + Show, como o form irmao Formsigoppro faz para a MESMA
3141:     * tela) e a ausencia aparece ALTA, na mensagem de erro - nunca escondida
3142:     * atras de um guard IF FILE()/PEMSTATUS, que eh o que faz o usuario clicar
3143:     * e nada acontecer (regra #27).
3144:     *
3145:     * UNICO desvio do legado: o Enabled eh devolvido aqui. O legado conta com o
3146:     * btnSair do SigOpTot para faze-lo ("ThisForm.poForm.Enabled = .t."); como
3147:     * o dialogo migrado eh modal, o Show() so retorna depois que ele fecha, e
3148:     * restaurar neste ponto eh equivalente - e eh o que impede a tela de
3149:     * Servicos de ficar MORTA quando o filho nem chega a abrir.
3150:     *--------------------------------------------------------------------------
3151:     PROCEDURE BtnTotItensClick()
3152:         LOCAL loc_oForm, loc_oErro
3153: 
3154:         loc_oForm = .NULL.
3155: 
3156:         *-- Legado: ThisForm.Enabled = .f.
3157:         THIS.Enabled = .F.
3158: 
3159:         TRY
3160:             loc_oForm = CREATEOBJECT("FormSigOpTot", THIS, THIS.DataSessionId)
3161:         CATCH TO loc_oErro
3162:             MostrarErro("Erro ao abrir Total de Servi" + CHR(231) + "os:" + CHR(13) + ;
3163:                         loc_oErro.Message, "Erro")
3164:             loc_oForm = .NULL.
3165:         ENDTRY
3166: 
3167:         IF VARTYPE(loc_oForm) = "O"
3168:             loc_oForm.Show()
3169:         ENDIF
3170: 
3171:         THIS.Enabled = .T.
3172:         THIS.grd_4c_Dados.Refresh()
3173: 
3174:         RETURN
3175:     ENDPROC
3176: 
3177:     *--------------------------------------------------------------------------
3178:     * BtnCotacaoClick - btnCotacao.Click do legado ("Excluir Servicos").
3179:     *
3180:     * Legado:
3181:     *   Do Form SigOpCot With ThisForm.ParentForm, TprMvCab.Datas
3182:     *   Select crTpmMvItn
3183:     *   Set Order To
3184:     *   Scan
3185:     *       If Not ThisForm.ParentForm.PodataMgr.CursorQuery([SigCdPro],
3186:     *                                 [crTmpPro], [CPros], crTpmMvItn.CPros)
3187:     *           Loop
3188:     *       EndIf
3189:     *       Replace AltImpost With .f. In crTpmMvItn
3190:     *       ThisForm.Calc_Valite()
3191:     *   EndScan
3192:     *
3193:     * O Caption diz "Excluir Servicos" mas o Click NAO exclui nada: abre a tela
3194:     * de Cambio (SigOpCot) e, na volta, zera a marca de imposto alterado de
3195:     * cada item cujo produto ainda existe em SigCdPro, remontando o total. O
3196:     * nome do botao esta errado no legado; o COMPORTAMENTO eh este, e eh ele
3197:     * que se transcreve.
3198:     *
3199:     * O SCAN percorre crTpmMvItn (o cursor dos ITENS do documento), nao a grade
3200:     * de servicos - tambem do legado.

*-- Linhas 3210 a 3299:
3210:     * cursor montado por outro driver, e gravar Logico ali estoura
3211:     * "Operator/operand type mismatch" (regra #13).
3212:     *--------------------------------------------------------------------------
3213:     PROCEDURE BtnCotacaoClick()
3214:         LOCAL loc_oForm, loc_oErro, loc_dDatas, loc_nAreaAnterior
3215:         LOCAL loc_cCpros, loc_cTipoAltImpost
3216: 
3217:         loc_oForm  = .NULL.
3218:         loc_dDatas = DATE()
3219: 
3220:         *-- Legado: TprMvCab.Datas (data do cabecalho do movimento)
3221:         IF USED(THIS.this_cCursorCabecalho)
3222:             loc_nAreaAnterior = SELECT()
3223:             SELECT (THIS.this_cCursorCabecalho)
3224: 
3225:             IF !EOF() AND INLIST(TYPE(THIS.this_cCursorCabecalho + ".datas"), "D", "T")
3226:                 loc_dDatas = ConverterParaData(datas)
3227:             ENDIF
3228: 
3229:             IF loc_nAreaAnterior > 0
3230:                 SELECT (loc_nAreaAnterior)
3231:             ENDIF
3232:         ENDIF
3233: 
3234:         TRY
3235:             loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oFormPai, loc_dDatas)
3236:         CATCH TO loc_oErro
3237:             MostrarErro("Erro ao abrir C" + CHR(226) + "mbio:" + CHR(13) + ;
3238:                         loc_oErro.Message, "Erro")
3239:             loc_oForm = .NULL.
3240:         ENDTRY
3241: 
3242:         IF VARTYPE(loc_oForm) = "O"
3243:             loc_oForm.Show()
3244:         ENDIF
3245: 
3246:         *-- Volta do cambio: refaz a marca de imposto e o total de cada item
3247:         IF USED(THIS.this_cCursorItem)
3248:             loc_nAreaAnterior = SELECT()
3249: 
3250:             SELECT (THIS.this_cCursorItem)
3251:             SET ORDER TO
3252: 
3253:             loc_cTipoAltImpost = TYPE(THIS.this_cCursorItem + ".altimpost")
3254: 
3255:             SCAN
3256:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))
3257: 
3258:                 IF !THIS.ProdutoExisteNoCadastro(loc_cCpros)
3259:                     SELECT (THIS.this_cCursorItem)
3260:                     LOOP
3261:                 ENDIF
3262: 
3263:                 SELECT (THIS.this_cCursorItem)
3264: 
3265:                 DO CASE
3266:                 CASE loc_cTipoAltImpost = "L"
3267:                     REPLACE altimpost WITH .F.
3268:                 CASE loc_cTipoAltImpost = "N"
3269:                     REPLACE altimpost WITH 0
3270:                 CASE loc_cTipoAltImpost = "C"
3271:                     REPLACE altimpost WITH "N"
3272:                 ENDCASE
3273: 
3274:                 THIS.TotalizarLinha()
3275: 
3276:                 SELECT (THIS.this_cCursorItem)
3277:             ENDSCAN
3278: 
3279:             IF loc_nAreaAnterior > 0
3280:                 SELECT (loc_nAreaAnterior)
3281:             ENDIF
3282:         ENDIF
3283: 
3284:         THIS.grd_4c_Dados.Refresh()
3285: 
3286:         RETURN
3287:     ENDPROC
3288: 
3289:     *--------------------------------------------------------------------------
3290:     * ProdutoExisteNoCadastro - o CursorQuery([SigCdPro],[crTmpPro],[CPros],..)
3291:     * do legado, reduzido ao que o chamador precisa saber: o produto existe?
3292:     *
3293:     * O cursor de destino mantem o nome do legado (crTmpPro) e as mesmas
3294:     * colunas, porque o form de Movimentacao que abriu este dialogo tambem o
3295:     * consulta - trocar o nome quebraria o contrato com ele.
3296:     *
3297:     * Sem conexao o resultado eh .F.: nenhuma linha eh marcada, que eh o mesmo
3298:     * efeito do CursorQuery legado falhando (o Loop pula a linha).
3299:     *--------------------------------------------------------------------------

*-- Linhas 3333 a 3433:
3333:         CATCH TO loc_oErro
3334:             MsgErro(loc_oErro.Message + CHR(13) + ;
3335:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3336:                     "Procedure: " + loc_oErro.Procedure, ;
3337:                     "Erro ao consultar o produto")
3338:         ENDTRY
3339: 
3340:         IF loc_nAreaAnterior > 0
3341:             SELECT (loc_nAreaAnterior)
3342:         ENDIF
3343: 
3344:         RETURN loc_lExiste
3345:     ENDFUNC
3346: 
3347:     *--------------------------------------------------------------------------
3348:     * BtnAltImpsClick - btnAltImps.Click do legado ("Alterar Valores").
3349:     *
3350:     * Legado:
3351:     *   If Not Empty(crTpmMvItn3.CPros)
3352:     *       _Retorno = [*] + Usuar
3353:     *       ThisForm.lAutPreco = (Left(_Retorno, 1) = [*])
3354:     *       If ThisForm.lAutPreco
3355:     *           ThisForm.fwgrade.SetFocus
3356:     *           ThisForm.fwgrade.Valor.SetFocus
3357:     *       EndIf
3358:     *   Else
3359:     *       =MessageBox([Selecione um Produto Para Ter o Preco Alterado], 48,
3360:     *                   [Atencao!!!])
3361:     *   EndIf
3362:     *
3363:     * "_Retorno = [*] + Usuar" seguido de "Left(_Retorno,1) = [*]" eh SEMPRE
3364:     * verdadeiro: no legado existia ali uma autorizacao por senha que foi
3365:     * desativada deixando o "*" fixo na frente. Transcrito como esta - inventar
3366:     * uma autorizacao que o legado nao faz mudaria quem consegue alterar preco.
3367:     *
3368:     * lAutPreco eh o que libera a coluna Valor: o When dela (na subclasse de
3369:     * celula) testa justamente essa propriedade.
3370:     *
3371:     * fwgrade.Valor eh a Column3 (ver o mapeamento das sete colunas em
3372:     * ConfigurarGrade).
3373:     *--------------------------------------------------------------------------
3374:     PROCEDURE BtnAltImpsClick()
3375:         LOCAL loc_cCpros, loc_cRetorno, loc_nAreaAnterior
3376: 
3377:         loc_cCpros = ""
3378: 
3379:         IF USED(THIS.this_cCursorServicos)
3380:             loc_nAreaAnterior = SELECT()
3381:             SELECT (THIS.this_cCursorServicos)
3382: 
3383:             IF !EOF()
3384:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))
3385:             ENDIF
3386: 
3387:             IF loc_nAreaAnterior > 0
3388:                 SELECT (loc_nAreaAnterior)
3389:             ENDIF
3390:         ENDIF
3391: 
3392:         IF EMPTY(loc_cCpros)
3393:             MsgAviso("Selecione um Produto Para Ter o Pre" + CHR(231) + "o Alterado", ;
3394:                      "Aten" + CHR(231) + CHR(227) + "o!!!")
3395:             RETURN
3396:         ENDIF
3397: 
3398:         loc_cRetorno        = "*" + gc_4c_UsuarioLogado
3399:         THIS.this_lAutPreco = (LEFT(loc_cRetorno, 1) == "*")
3400: 
3401:         IF THIS.this_lAutPreco
3402:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
3403:                 THIS.grd_4c_Dados.SetFocus()
3404: 
3405:                 IF THIS.grd_4c_Dados.Column3.Visible
3406:                     THIS.grd_4c_Dados.Column3.SetFocus()
3407:                 ENDIF
3408:             ENDIF
3409:         ENDIF
3410: 
3411:         RETURN
3412:     ENDPROC
3413: 
3414:     *--------------------------------------------------------------------------
3415:     * ValidarTamanhosInformados - a checagem que o botao Retornar faz antes de
3416:     * fechar o dialogo.
3417:     *
3418:     * Legado (cntOK.btnSair.Click):
3419:     *   If InList(Thisform.op_escolha,[INSERIR],[ALTERAR])
3420:     *       lnOldSel = Select()
3421:     *       If Used([csValConfs]) / Use in csValConfs / EndIf
3422:     *       Select crTpmMvItn3
3423:     *       Select Count(1) as Qtd From crTpmMvItn3
3424:     *           Where iConfs = .T. and (Empty(TamDe) or Empty(TamPara))
3425:     *           Into Cursor csValConfs ReadWrite
3426:     *       Select csValConfs
3427:     *       If Reccount([csValConfs])>0 And csValConfs.Qtd > 0
3428:     *           MessageBox([Existe Servicos sem Informar os campos :] + Chr(13) +
3429:     *                      [TAMANHO DE ou o TAMANHO PARA.] + Chr(13) +
3430:     *                      [Favor Verificar!!!],0+48,[Aviso])
3431:     *           Select(lnOldSel)
3432:     *           Return .F.
3433:     *       EndIf

*-- Linhas 3497 a 3574:
3497:         ENDIF
3498: 
3499:         IF loc_nQtd > 0
3500:             MsgAviso("Existe Servi" + CHR(231) + "os sem Informar os campos :" + ;
3501:                      CHR(13) + "TAMANHO DE ou o TAMANHO PARA." + CHR(13) + ;
3502:                      "Favor Verificar!!!", "Aviso")
3503:             loc_lOk = .F.
3504:         ENDIF
3505: 
3506:         IF USED("csValConfs")
3507:             USE IN csValConfs
3508:         ENDIF
3509: 
3510:         IF loc_nOldSel > 0
3511:             SELECT (loc_nOldSel)
3512:         ENDIF
3513: 
3514:         RETURN loc_lOk
3515:     ENDFUNC
3516: 
3517:     *--------------------------------------------------------------------------
3518:     * BtnRetornarClick - cntOK.btnSair.Click do legado (o botao "Retornar").
3519:     *
3520:     * Legado, depois da validacao acima:
3521:     *   ThisForm.poForm.Enabled = .t.
3522:     *   ThisForm.Release
3523:     *
3524:     * Validacao reprovada ABORTA o fechamento - eh o "Return .F." do legado, e
3525:     * eh o que mantem o usuario na tela para completar a faixa de tamanho.
3526:     *
3527:     * A reabilitacao do chamador tambem esta no Destroy (o dialogo pode fechar
3528:     * por Esc ou QueryUnload); as duas sao idempotentes.
3529:     *
3530:     * Release() e nao Hide(): o chamador nao le nenhum resultado deste dialogo
3531:     * depois que ele fecha - o trabalho fica no cursor crTpmMvItn3, que eh do
3532:     * proprio chamador.
3533:     *--------------------------------------------------------------------------
3534:     PROCEDURE BtnRetornarClick()
3535:         IF !THIS.ValidarTamanhosInformados()
3536:             RETURN
3537:         ENDIF
3538: 
3539:         THIS.ReabilitarChamador()
3540: 
3541:         THIS.Release()
3542: 
3543:         RETURN
3544:     ENDPROC
3545: 
3546:     *==========================================================================
3547:     * FASE 8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
3548:     *
3549:     * Fecha a tela com o que ainda faltava do dump (tasks\task801\
3550:     * sigopser_form_codigo_fonte.txt), item a item:
3551:     *
3552:     *   SIGOPSER.apaite                      -> LimparCampos()
3553:     *   SIGOPSER.minserelinha                -> InserirLinhaServico()
3554:     *   fwGrade.QTD.Text1.When               -> CelulaQtdLiberada()
3555:     *   fwGrade.QTD.Text1.Valid              -> ValidarCelulaQtd()
3556:     *   fwGrade.VALOR.Text1.When             -> CelulaValorLiberada()
3557:     *   fwGrade.VALOR.Text1.Valid            -> ValidarCelulaValor()
3558:     *   fwGrade.VALOR.Text1.LostFocus        -> CelulaValorLostFocus()
3559:     *   fwGrade.PRODUTO.Text1.LostFocus      -> CelulaServicoLostFocus()
3560:     *   fwGrade.Descricao.Text1.LostFocus    -> CelulaDescricaoLostFocus()
3561:     *   fwGrade.MOEDA.Text1.When     (.f.)   |
3562:     *   fwGrade.TOTAL.Text1.When     (.f.)   |-> InstalarCelulasEdicao()
3563:     *   fwGrade.item.Text1.When      (.f.)   |
3564:     *
3565:     * mais os dois hooks canonicos de transferencia entre a tela e o objeto de
3566:     * negocio (FormParaBO / BOParaForm), que aqui tem por "ficha" a LINHA
3567:     * CORRENTE da grade de servicos mais o painel "Tamanho" - esta tela nao tem
3568:     * Page de Dados, e eh a linha que o usuario edita.
3569:     *
3570:     * NAO existe BtnSalvarClick nem BtnCancelarClick: o legado tem UM unico
3571:     * botao, que VALIDA e FECHA (cntOK.btnSair, ja migrado em BtnRetornarClick
3572:     * na Fase 7), e as edicoes ja sao gravadas no cursor do CHAMADOR a cada
3573:     * Valid - nao ha o que descartar, e nao existe um segundo botao
3574:     * que abandone. A tecla Esc chega ao botao pelo "Command1.Cancel = .T." que

*-- Linhas 3583 a 3799:
3583:     * (Column3) os TextBox que carregam o When/Valid/LostFocus do legado, e
3584:     * tranca as tres colunas cujo When do legado eh "Return .f.".
3585:     *
3586:     * Mesma razao de InstalarCelulasLookup para usar SUBCLASSE e nao BINDEVENT:
3587:     * BINDEVENT em "Valid" de TextBox de Column nao eh confiavel em VFP9
3588:     * (regra #46), e BINDEVENT em "When" DESCARTA o retorno do delegate, de
3589:     * modo que o gate nao bloquearia nada.
3590:     *
3591:     * As tres colunas somente-exibicao (MOEDA, TOTAL e item) recebem
3592:     * Column.ReadOnly = .T., que eh o equivalente do "Return .f." no When: o
3593:     * usuario nao digita nelas e a celula continua desenhada como no legado
3594:     * (Enabled = .F. a acinzentaria e mudaria a tela). O ReadOnly da COLUNA vem
3595:     * DEPOIS do ReadOnly do GRID, que propaga para as colunas e sobrescreveria
3596:     * o valor posto aqui (regra #18).
3597:     *
3598:     * Chamado por VincularGrade, logo apos InstalarCelulasLookup e pelo mesmo
3599:     * motivo: atribuir RecordSource/ControlSource devolve Sparse e
3600:     * CurrentControl ao default, e as celulas voltariam a ser o Text1 original,
3601:     * sem os eventos do legado.
3602:     *
3603:     * A mascara do valor eh LIDA da Column3 em vez de repetida: ela eh
3604:     * calculada em VincularGrade a partir das casas decimais da operacao, e
3605:     * duplicar o numero aqui faria as duas copias divergirem.
3606:     *--------------------------------------------------------------------------
3607:     PROTECTED PROCEDURE InstalarCelulasEdicao()
3608:         LOCAL loc_cMascaraValor
3609: 
3610:         *-- Column2 = QTD
3611:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_CelQtd", 5)
3612:             THIS.grd_4c_Dados.Column2.AddObject("txt_4c_CelQtd", "TextBoxQtdSer_4c")
3613:         ENDIF
3614: 
3615:         WITH THIS.grd_4c_Dados.Column2.txt_4c_CelQtd
3616:             .FontName    = "Verdana"
3617:             .FontSize    = 8
3618:             .BorderStyle = 0
3619:             .InputMask   = "99999.999"
3620:             .Margin      = 0
3621:             .ReadOnly    = .F.
3622:             .ForeColor   = RGB(0, 0, 0)
3623:             .BackColor   = RGB(255, 255, 255)
3624:             .ToolTipText = "Quantidade do Servi" + CHR(231) + "o"
3625:             .Visible     = .T.
3626:         ENDWITH
3627: 
3628:         *-- Column3 = VALOR
3629:         loc_cMascaraValor = THIS.grd_4c_Dados.Column3.InputMask
3630: 
3631:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column3, "txt_4c_CelValor", 5)
3632:             THIS.grd_4c_Dados.Column3.AddObject("txt_4c_CelValor", "TextBoxValorSer_4c")
3633:         ENDIF
3634: 
3635:         WITH THIS.grd_4c_Dados.Column3.txt_4c_CelValor
3636:             .FontName    = "Verdana"
3637:             .FontSize    = 8
3638:             .BorderStyle = 0
3639:             .InputMask   = loc_cMascaraValor
3640:             .Margin      = 0
3641:             .ReadOnly    = .F.
3642:             .ForeColor   = RGB(0, 0, 0)
3643:             .BackColor   = RGB(255, 255, 255)
3644:             .ToolTipText = "Valor Unit" + CHR(225) + "rio do Servi" + CHR(231) + "o"
3645:             .Visible     = .T.
3646:         ENDWITH
3647: 
3648:         *-- CurrentControl por ULTIMO, e so depois Sparse/ReadOnly
3649:         WITH THIS.grd_4c_Dados.Column2
3650:             .CurrentControl = "txt_4c_CelQtd"
3651:             .Sparse         = .F.
3652:             .ReadOnly       = .F.
3653:         ENDWITH
3654: 
3655:         WITH THIS.grd_4c_Dados.Column3
3656:             .CurrentControl = "txt_4c_CelValor"
3657:             .Sparse         = .F.
3658:             .ReadOnly       = .F.
3659:         ENDWITH
3660: 
3661:         *-- MOEDA / TOTAL / item: o "Return .f." do When de cada uma
3662:         THIS.grd_4c_Dados.Column4.ReadOnly = .T.
3663:         THIS.grd_4c_Dados.Column5.ReadOnly = .T.
3664:         THIS.grd_4c_Dados.Column6.ReadOnly = .T.
3665: 
3666:         RETURN
3667:     ENDPROC
3668: 
3669:     *--------------------------------------------------------------------------
3670:     * CelulaQtdLiberada - o When da coluna "Quantidade".
3671:     *
3672:     * Legado (QTD.Text1.When):
3673:     *   Return Not Empty(crTpmMvItn3.CPros) And
3674:     *          Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])
3675:     *
3676:     * Isto e: so se digita quantidade depois que a linha ja tem servico, e
3677:     * apenas quando o documento esta em inclusao ou alteracao.
3678:     *
3679:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3680:     *--------------------------------------------------------------------------
3681:     PROCEDURE CelulaQtdLiberada(par_oTxt)
3682:         LOCAL loc_lTemServico
3683: 
3684:         loc_lTemServico = .F.
3685: 
3686:         IF USED(THIS.this_cCursorServicos)
3687:             SELECT (THIS.this_cCursorServicos)
3688:             loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
3689:         ENDIF
3690: 
3691:         RETURN loc_lTemServico AND INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3692:     ENDPROC
3693: 
3694:     *--------------------------------------------------------------------------
3695:     * ValidarCelulaQtd - o Valid da coluna "Quantidade".
3696:     *
3697:     * Legado (QTD.Text1.Valid):
3698:     *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe',
3699:     *                                              'Dopes', TprMvCab.Dopes)
3700:     *   If Inlist( Thisform.Op_escolha, 'INSERIR', 'ALTERAR' )
3701:     *       If Lastkey()=13
3702:     *           llNovaLinha = .t.
3703:     *           Select crTpmMvItn3
3704:     *           Thisform.Foco = 'fwgrade.Produto'
3705:     *           Thisform.mInsereLinha()
3706:     *       Endif
3707:     *   EndIf
3708:     *   Thisform.Calc_ValIte()
3709:     *
3710:     * O Cursorquery do topo eh a releitura da configuracao da operacao, que
3711:     * aqui mora em CarregarConfiguracaoOperacao - o metodo faz exatamente o que
3712:     * o Cursorquery fazia (le SigCdOpe pela Dopes do cabecalho e guarda o
3713:     * resultado nas propriedades do BO).
3714:     *
3715:     * llNovaLinha eh declarada e atribuida no legado e NUNCA lida - por isso
3716:     * nao tem equivalente aqui.
3717:     *
3718:     * Devolve .T. sempre: o legado nao tem Return nenhum neste Valid, e Valid
3719:     * sem Return deixa o foco seguir.
3720:     *
3721:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3722:     *--------------------------------------------------------------------------
3723:     PROCEDURE ValidarCelulaQtd(par_oTxt)
3724:         THIS.CarregarConfiguracaoOperacao()
3725: 
3726:         IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3727:             IF LASTKEY() = 13
3728:                 IF USED(THIS.this_cCursorServicos)
3729:                     SELECT (THIS.this_cCursorServicos)
3730:                 ENDIF
3731: 
3732:                 THIS.this_cFoco = "fwgrade.Produto"
3733:                 THIS.InserirLinhaServico()
3734:             ENDIF
3735:         ENDIF
3736: 
3737:         THIS.TotalizarLinha()
3738: 
3739:         RETURN .T.
3740:     ENDPROC
3741: 
3742:     *--------------------------------------------------------------------------
3743:     * CelulaValorLiberada - o When da coluna "Valor".
3744:     *
3745:     * Legado (VALOR.Text1.When):
3746:     *   ThisForm.OldPreco = This.Value
3747:     *   Return InList(ThisForm.Op_Escolha, [INSERIR], [ALTERAR]) And
3748:     *          Not Empty(crTpmMvItn3.CPros) And ThisForm.lAutPreco
3749:     *
3750:     * lAutPreco so fica ligada quando o usuario pede "Alterar Valores"
3751:     * (btnAltImps) - por isso, em condicao normal, o valor unitario NAO eh
3752:     * digitavel: ele vem da tabela de preco.
3753:     *
3754:     * OldPreco eh guardado AQUI, na entrada da celula, porque eh ele que o
3755:     * Valid restaura quando o usuario digita um preco negativo.
3756:     *
3757:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3758:     *--------------------------------------------------------------------------
3759:     PROCEDURE CelulaValorLiberada(par_oTxt)
3760:         LOCAL loc_lTemServico
3761: 
3762:         IF VARTYPE(par_oTxt) = "O" AND VARTYPE(par_oTxt.Value) = "N"
3763:             THIS.this_nOldPreco = par_oTxt.Value
3764:         ENDIF
3765: 
3766:         loc_lTemServico = .F.
3767: 
3768:         IF USED(THIS.this_cCursorServicos)
3769:             SELECT (THIS.this_cCursorServicos)
3770:             loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
3771:         ENDIF
3772: 
3773:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") ;
3774:                AND loc_lTemServico AND THIS.this_lAutPreco
3775:     ENDPROC
3776: 
3777:     *--------------------------------------------------------------------------
3778:     * ValidarCelulaValor - o Valid da coluna "Valor".
3779:     *
3780:     * Legado (VALOR.Text1.Valid), transcrito linha a linha:
3781:     *   lnCasas = CrSigCdOpe.Casas
3782:     *   Thisform.Foco = ''
3783:     *   This.Value = Round( This.Value, lnCasas )
3784:     *   If This.Value < 0
3785:     *       MessageBox('Preco Invalido',0+48,'')
3786:     *       This.value = Thisform.OldPreco
3787:     *       Return 0
3788:     *   EndIf
3789:     *   If Not ThisForm.plVlrZeroGarantia And This.Value = 0
3790:     *       MessageBox('Preco Nao Pode Ser Zerado.',0+48,'')
3791:     *       Return .F.
3792:     *   EndIf
3793:     *   This.Refresh
3794:     *   Thisform.lAutPreco = .F.
3795:     *   If Empty(This.Value)
3796:     *       Thisform.Calc_valite()
3797:     *   EndIf
3798:     *   If LastKey()=13
3799:     *       If Inlist( Thisform.Op_Escolha, 'INSERIR', 'ALTERAR' )

*-- Linhas 3819 a 4020:
3819:     *
3820:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3821:     *--------------------------------------------------------------------------
3822:     PROCEDURE ValidarCelulaValor(par_oTxt)
3823:         LOCAL loc_nCasas, loc_nValor, loc_uRetorno
3824: 
3825:         IF VARTYPE(par_oTxt) != "O" OR VARTYPE(par_oTxt.Value) != "N"
3826:             RETURN .T.
3827:         ENDIF
3828: 
3829:         loc_nCasas      = THIS.this_oBusinessObject.this_nCasas
3830:         THIS.this_cFoco = ""
3831: 
3832:         par_oTxt.Value = ROUND(par_oTxt.Value, loc_nCasas)
3833:         loc_nValor     = par_oTxt.Value
3834:         loc_uRetorno   = .T.
3835: 
3836:         DO CASE
3837:         CASE loc_nValor < 0
3838:             MsgAviso("Pre" + CHR(231) + "o Inv" + CHR(225) + "lido", "Aviso")
3839:             par_oTxt.Value = THIS.this_nOldPreco
3840:             loc_uRetorno   = 0
3841: 
3842:         CASE !THIS.this_lValorZeroGarantia AND loc_nValor = 0
3843:             MsgAviso("Pre" + CHR(231) + "o N" + CHR(227) + "o Pode Ser Zerado.", "Aviso")
3844:             loc_uRetorno = .F.
3845: 
3846:         OTHERWISE
3847:             par_oTxt.Refresh()
3848:             THIS.this_lAutPreco = .F.
3849: 
3850:             IF EMPTY(loc_nValor)
3851:                 THIS.TotalizarLinha()
3852:             ENDIF
3853: 
3854:             IF LASTKEY() = 13
3855:                 IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3856:                     THIS.this_cFoco = "fwgrade.Produto"
3857:                     THIS.InserirLinhaServico()
3858:                     THIS.grd_4c_Dados.Refresh()
3859:                 ENDIF
3860:             ENDIF
3861:         ENDCASE
3862: 
3863:         RETURN loc_uRetorno
3864:     ENDPROC
3865: 
3866:     *--------------------------------------------------------------------------
3867:     * CelulaValorLostFocus - o LostFocus da coluna "Valor".
3868:     *
3869:     * Legado (VALOR.Text1.LostFocus):
3870:     *   Thisform.lAutPreco = .F.
3871:     *   Select crTpmMvItn3
3872:     *   If Not IsEmpty(Thisform.Foco)
3873:     *       lcFoco = AllTrim(Thisform.Foco)
3874:     *       Thisform.Foco = ''
3875:     *       Thisform.&lcFoco..Refresh
3876:     *       Thisform.&lcFoco..SetFocus
3877:     *   EndIf
3878:     *
3879:     * Desligar lAutPreco ao SAIR da celula eh o que faz a autorizacao dada pelo
3880:     * botao "Alterar Valores" valer por UMA edicao so.
3881:     *
3882:     * O desvio do foco esta em AplicarFoco: o nome guardado em this_cFoco eh o
3883:     * do objeto LEGADO ("fwgrade.Produto"), que no migrado se chama
3884:     * grd_4c_Dados.Column1 (PILAR 3) - a macro do legado nao tem como ser
3885:     * transcrita literalmente.
3886:     *
3887:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3888:     *--------------------------------------------------------------------------
3889:     PROCEDURE CelulaValorLostFocus()
3890:         THIS.this_lAutPreco = .F.
3891: 
3892:         IF USED(THIS.this_cCursorServicos)
3893:             SELECT (THIS.this_cCursorServicos)
3894:         ENDIF
3895: 
3896:         THIS.AplicarFoco()
3897: 
3898:         RETURN
3899:     ENDPROC
3900: 
3901:     *--------------------------------------------------------------------------
3902:     * AplicarFoco - o "Thisform.&lcFoco..Refresh / .SetFocus" do legado.
3903:     *
3904:     * this_cFoco guarda o nome do objeto do LEGADO, exatamente como as duas
3905:     * unicas atribuicoes do dump o escrevem ('fwgrade.Produto', nos Valid de
3906:     * QTD e de VALOR). Aqui o nome eh TRADUZIDO para o objeto migrado em vez de
3907:     * expandido por macro: os nomes do migrado sao diferentes por imposicao do
3908:     * PILAR 3, e "&lcFoco" apontaria para objeto inexistente.
3909:     *
3910:     * O nome eh consumido (zerado) na entrada, como no legado.
3911:     *
3912:     * Grade sem linha nao recebe foco: SetFocus sobre grade vazia estoura.
3913:     *--------------------------------------------------------------------------
3914:     PROTECTED PROCEDURE AplicarFoco()
3915:         LOCAL loc_cFoco
3916: 
3917:         loc_cFoco = UPPER(ALLTRIM(THIS.this_cFoco))
3918: 
3919:         IF EMPTY(loc_cFoco)
3920:             RETURN
3921:         ENDIF
3922: 
3923:         THIS.this_cFoco = ""
3924: 
3925:         DO CASE
3926:         CASE loc_cFoco == "FWGRADE.PRODUTO"
3927:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled ;
3928:                AND USED(THIS.this_cCursorServicos) ;
3929:                AND RECCOUNT(THIS.this_cCursorServicos) > 0
3930: 
3931:                 THIS.grd_4c_Dados.Column1.Refresh()
3932:                 THIS.grd_4c_Dados.SetFocus()
3933:                 THIS.grd_4c_Dados.Column1.SetFocus()
3934:             ENDIF
3935:         ENDCASE
3936: 
3937:         RETURN
3938:     ENDPROC
3939: 
3940:     *--------------------------------------------------------------------------
3941:     * CelulaServicoLostFocus / CelulaDescricaoLostFocus - o LostFocus das
3942:     * colunas "Servico" e "Descricao".
3943:     *
3944:     * Legado (PRODUTO.Text1.LostFocus):
3945:     *   ThisForm.AntCpro = Space(10)
3946:     *   If Empty(This.Value) And (Lastkey() = 13)
3947:     *       ThisForm.cntOK.btnSair.SetFocus
3948:     *   EndIf
3949:     *
3950:     * Legado (Descricao.Text1.LostFocus): identico, com Space(40).
3951:     *
3952:     * Isto e: sair da celula com ENTER sem ter digitado nada leva o foco ao
3953:     * botao Retornar - eh o atalho com que o usuario encerra a digitacao da
3954:     * grade. O tamanho do Space() difere entre as duas celulas e eh transcrito
3955:     * como esta (a propriedade so eh lida com Padr/comparacao, entao o numero
3956:     * nao muda o comportamento, mas tambem nao se inventa).
3957:     *
3958:     * cntOK.btnSair eh o membro 1 do CommandGroup cmg_4c_CntOK.
3959:     *
3960:     * PUBLIC: sao chamados pelas subclasses de TextBox, de FORA desta classe.
3961:     *--------------------------------------------------------------------------
3962:     PROCEDURE CelulaServicoLostFocus(par_oTxt)
3963:         THIS.this_cAntCPro = SPACE(10)
3964:         THIS.FocarRetornarSeVazio(par_oTxt)
3965: 
3966:         RETURN
3967:     ENDPROC
3968: 
3969:     PROCEDURE CelulaDescricaoLostFocus(par_oTxt)
3970:         THIS.this_cAntCPro = SPACE(40)
3971:         THIS.FocarRetornarSeVazio(par_oTxt)
3972: 
3973:         RETURN
3974:     ENDPROC
3975: 
3976:     *--------------------------------------------------------------------------
3977:     * FocarRetornarSeVazio - a segunda metade dos dois LostFocus acima, que eh
3978:     * identica nos dois. Em metodo unico para as duas celulas nao divergirem.
3979:     *--------------------------------------------------------------------------
3980:     PROTECTED PROCEDURE FocarRetornarSeVazio(par_oTxt)
3981:         LOCAL loc_cValor
3982: 
3983:         IF VARTYPE(par_oTxt) != "O"
3984:             RETURN
3985:         ENDIF
3986: 
3987:         loc_cValor = IIF(VARTYPE(par_oTxt.Value) = "C", ALLTRIM(par_oTxt.Value), "")
3988: 
3989:         IF EMPTY(loc_cValor) AND LASTKEY() = 13
3990:             IF THIS.cmg_4c_CntOK.Visible AND THIS.cmg_4c_CntOK.Enabled
3991:                 THIS.cmg_4c_CntOK.Buttons(1).SetFocus()
3992:             ENDIF
3993:         ENDIF
3994: 
3995:         RETURN
3996:     ENDPROC
3997: 
3998:     *--------------------------------------------------------------------------
3999:     * InserirLinhaServico - o "mInsereLinha" do legado (metodo de form).
4000:     *
4001:     * Legado:
4002:     *   Select crTpmMvItn3
4003:     *   Locate For cpros = Space(14)
4004:     *   If Eof()
4005:     *       Insert Into crTpmMvItn3(Emps, Dopes, Numes, Citens) ;
4006:     *              Values (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes,
4007:     *                      ThisForm.Citem)
4008:     *       Insert Into csTmpDesc (nControle, nLInhas) ;
4009:     *              Values (RecNo([crTpmMvItn3]), ThisForm.nCItem2)
4010:     *       ThisForm.nCItem2 = ThisForm.nCItem2 + 1
4011:     *   EndIf
4012:     *   Select crTpmMvItn3 / Set Order To CItens / Set Key To ThisForm.Citem
4013:     *   Select crTpmMvItn3 / Set Relation To Str(Recno([crTpmMvItn3]),8)
4014:     *                                        Into csTmpDesc
4015:     *   Select crTpmMvItn3
4016:     *   If Not ThisForm.lAutPreco
4017:     *       Keyboard [{DNARROW}]
4018:     *   EndIf
4019:     *   Keyboard [{DNARROW}]
4020:     *   ThisForm.OldCodBarras = []

*-- Linhas 4040 a 4083:
4040:     * PUBLIC: eh chamado pelos Valid das celulas de quantidade e de valor, que
4041:     * moram nas subclasses de TextBox - de FORA desta classe.
4042:     *--------------------------------------------------------------------------
4043:     PROCEDURE InserirLinhaServico()
4044:         LOCAL loc_cServicos, loc_nRegistro
4045: 
4046:         loc_cServicos = THIS.this_cCursorServicos
4047: 
4048:         IF !USED(loc_cServicos)
4049:             RETURN
4050:         ENDIF
4051: 
4052:         SELECT (loc_cServicos)
4053:         LOCATE FOR EMPTY(cpros)
4054: 
4055:         IF EOF()
4056:             THIS.LimparDadosLinhaBO()
4057: 
4058:             IF THIS.this_oBusinessObject.Inserir()
4059:                 loc_nRegistro = RECNO(loc_cServicos)
4060: 
4061:                 IF USED(THIS.this_cCursorDescricoes)
4062:                     INSERT INTO csTmpDesc (nControle, nLinhas) ;
4063:                         VALUES (loc_nRegistro, THIS.this_nCItem2)
4064:                 ENDIF
4065: 
4066:                 THIS.this_nCItem2 = THIS.this_nCItem2 + 1
4067:             ELSE
4068:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
4069:                         "Erro ao incluir linha de servi" + CHR(231) + "o")
4070:             ENDIF
4071:         ENDIF
4072: 
4073:         *-- Set Order To CItens + Set Key To <item> do legado
4074:         THIS.AplicarEscopoItem()
4075: 
4076:         *-- Set Relation To Str(Recno(...),8) Into csTmpDesc do legado
4077:         THIS.AplicarRelacaoDescricoes()
4078: 
4079:         SELECT (loc_cServicos)
4080: 
4081:         IF !THIS.this_lAutPreco
4082:             KEYBOARD "{DNARROW}"
4083:         ENDIF

*-- Linhas 4102 a 4184:
4102:     * (InserirLinhaServico). Duplicar a lista faria as duas copias divergirem
4103:     * na primeira coluna nova.
4104:     *--------------------------------------------------------------------------
4105:     PROTECTED PROCEDURE LimparDadosLinhaBO()
4106:         WITH THIS.this_oBusinessObject
4107:             .this_cCidChaves = ""
4108:             .this_cCpros     = ""
4109:             .this_cDpros     = ""
4110:             .this_cCunis     = ""
4111:             .this_nQtds      = 0
4112:             .this_nUnits     = 0
4113:             .this_nUnivals   = 0
4114:             .this_nTotas     = 0
4115:             .this_cMoedas    = ""
4116:             .this_cMoefats   = ""
4117:             .this_cMoevs     = ""
4118:             .this_nMoevals   = 0
4119:             .this_lIconfs    = .F.
4120:             .this_nCodBarras = 0
4121:             .this_nUtilizas  = 0
4122:             .this_cNotas     = ""
4123:             .this_cObs       = ""
4124:             .this_cTamDe     = ""
4125:             .this_cTamPara   = ""
4126:         ENDWITH
4127: 
4128:         RETURN
4129:     ENDPROC
4130: 
4131:     *--------------------------------------------------------------------------
4132:     * AplicarRelacaoDescricoes - o "Set Relation To Str(Recno(...),8) Into
4133:     * csTmpDesc" do legado, com o SET ORDER do lado FILHO que ele pressupoe.
4134:     *
4135:     * Metodo unico pelos mesmos dois caminhos de LimparDadosLinhaBO: a montagem
4136:     * inicial (MontarDescricoesPorLinha) e a insercao em runtime
4137:     * (InserirLinhaServico) - o legado repete o comando nos dois.
4138:     *
4139:     * A expressao eh montada por MACRO, com o nome do cursor pai LITERAL dentro
4140:     * dela: SET RELATION GUARDA a expressao e a reavalia a cada movimento do
4141:     * cursor, muito depois deste metodo terminar - um "THIS" ali dentro nao
4142:     * teria como ser resolvido.
4143:     *--------------------------------------------------------------------------
4144:     PROTECTED PROCEDURE AplicarRelacaoDescricoes()
4145:         LOCAL loc_cRelacao
4146: 
4147:         IF !USED(THIS.this_cCursorServicos) OR !USED(THIS.this_cCursorDescricoes)
4148:             RETURN
4149:         ENDIF
4150: 
4151:         SELECT (THIS.this_cCursorDescricoes)
4152:         SET ORDER TO TAG iControle
4153: 
4154:         loc_cRelacao = "STR(RECNO('" + THIS.this_cCursorServicos + "'), 8)"
4155: 
4156:         SELECT (THIS.this_cCursorServicos)
4157:         SET RELATION TO &loc_cRelacao. INTO csTmpDesc
4158: 
4159:         RETURN
4160:     ENDPROC
4161: 
4162:     *--------------------------------------------------------------------------
4163:     * LimparCampos - o "apaite" do legado (metodo de form).
4164:     *
4165:     * Legado:
4166:     *   Select crTpmMvItn3
4167:     *   Replace DPros With [], Obs With [], CodBarras With 00, Utilizas With 00,
4168:     *           TamDe With [], TamPara With [], iConfs With .F.,
4169:     *           Notas With [] In crTpmMvItn3
4170:     *   With Thisform.fwGrade
4171:     *       .Produto.Text1.Value = [] / .Qtd.Text1.Value   = 0
4172:     *       .Valor.Text1.Value   = 0  / .Moeda.Text1.Value = ''
4173:     *       .Total.Text1.Value   = 0
4174:     *       (Refresh de cada um e da grade)
4175:     *   EndWith
4176:     *
4177:     * Limpa a linha CORRENTE: as colunas descritivas do cursor e o conteudo
4178:     * exibido nas cinco primeiras celulas. O codigo do servico (cpros) e a
4179:     * quantidade (qtds) NAO sao apagados do CURSOR pelo legado - so da tela -,
4180:     * e isso eh transcrito como esta.
4181:     *
4182:     * iConfs eh coluna "bit" no SQL Server e chega ao cursor VFP ora Logico ora
4183:     * Numerico conforme o driver: o tipo eh medido e o REPLACE usa o valor
4184:     * compativel - gravar o tipo errado dispara "Operator/operand type

*-- Linhas 4191 a 4237:
4191:     * PUBLIC: eh um metodo de form no legado, chamavel de fora - o SCX o
4192:     * declara em ClassInfo junto com calc_valite e minserelinha.
4193:     *--------------------------------------------------------------------------
4194:     PROCEDURE LimparCampos()
4195:         LOCAL loc_cServicos
4196: 
4197:         loc_cServicos = THIS.this_cCursorServicos
4198: 
4199:         IF USED(loc_cServicos)
4200:             SELECT (loc_cServicos)
4201: 
4202:             IF !EOF()
4203:                 REPLACE dpros     WITH "", ;
4204:                         obs       WITH "", ;
4205:                         codbarras WITH 0, ;
4206:                         utilizas  WITH 0, ;
4207:                         tamde     WITH "", ;
4208:                         tampara   WITH "", ;
4209:                         notas     WITH ""
4210: 
4211:                 IF VARTYPE(iconfs) = "L"
4212:                     REPLACE iconfs WITH .F.
4213:                 ELSE
4214:                     REPLACE iconfs WITH 0
4215:                 ENDIF
4216:             ENDIF
4217:         ENDIF
4218: 
4219:         *-- As cinco celulas que o legado limpa na tela. O controle que DESENHA
4220:         *-- a celula eh o da subclasse quando ela esta instalada (colunas 1, 2 e
4221:         *-- 3) e o Text1 nas demais - por isso cada uma eh tratada pelo seu nome
4222:         WITH THIS.grd_4c_Dados
4223:             IF PEMSTATUS(.Column1, "txt_4c_CelServico", 5)
4224:                 .Column1.txt_4c_CelServico.Value = ""
4225:                 .Column1.txt_4c_CelServico.Refresh()
4226:             ENDIF
4227: 
4228:             IF PEMSTATUS(.Column2, "txt_4c_CelQtd", 5)
4229:                 .Column2.txt_4c_CelQtd.Value = 0
4230:                 .Column2.txt_4c_CelQtd.Refresh()
4231:             ENDIF
4232: 
4233:             IF PEMSTATUS(.Column3, "txt_4c_CelValor", 5)
4234:                 .Column3.txt_4c_CelValor.Value = 0
4235:                 .Column3.txt_4c_CelValor.Refresh()
4236:             ENDIF
4237: 

*-- Linhas 4327 a 4656:
4327:     * caminho; sem linha corrente nao ha o que gravar, e sair calado aqui eh o
4328:     * que o legado faz (o Replace dele tambem nao tem efeito em EOF).
4329:     *--------------------------------------------------------------------------
4330:     PROTECTED PROCEDURE GravarLinhaCorrente()
4331:         IF !USED(THIS.this_cCursorServicos)
4332:             RETURN
4333:         ENDIF
4334: 
4335:         SELECT (THIS.this_cCursorServicos)
4336: 
4337:         IF EOF()
4338:             RETURN
4339:         ENDIF
4340: 
4341:         IF THIS.FormParaBO()
4342:             IF !THIS.this_oBusinessObject.AtualizarTamanhos()
4343:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
4344:                         "Erro ao gravar o tamanho do servi" + CHR(231) + "o")
4345:             ENDIF
4346:         ENDIF
4347: 
4348:         RETURN
4349:     ENDPROC
4350: 
4351:     *--------------------------------------------------------------------------
4352:     * BOParaForm - transfere o objeto de negocio para a TELA.
4353:     *
4354:     * O inverso de FormParaBO, com as mesmas partes:
4355:     *
4356:     *   1. o cabecalho do dialogo - os tres campos somente-exibicao que
4357:     *      identificam o PRODUTO dono dos servicos (Get_Produto/Get_Descricao/
4358:     *      Get_Mercs do legado), que o BO guarda em propriedades proprias
4359:     *      (this_cCprosItem / this_cDprosItem / this_cMercsItem) para nao se
4360:     *      confundirem com o codigo e a descricao do SERVICO da linha;
4361:     *   2. o painel "Tamanho" da linha corrente.
4362:     *
4363:     * As celulas da GRADE ficam de fora de proposito: elas estao ligadas ao
4364:     * cursor por ControlSource e se desenham sozinhas a partir dele - escrever
4365:     * .Value numa celula ligada GRAVARIA de volta no cursor, que eh justamente
4366:     * de onde o valor acabou de vir. O que esta tela precisa aqui eh so
4367:     * REPINTAR a grade.
4368:     *
4369:     * A VISIBILIDADE do painel "Tamanho" NAO eh tocada aqui: quem a decide eh o
4370:     * AfterRowColChange da grade, que eh onde o legado a decide. Mexer nela
4371:     * aqui faria o painel aparecer ja na abertura da tela, que eh exatamente o
4372:     * que o legado nao faz.
4373:     *
4374:     * PUBLIC: eh um dos dois hooks canonicos de transferencia e eh chamado de
4375:     * fora da classe (pelo funil de carga da linha e pelo harness de teste).
4376:     *--------------------------------------------------------------------------
4377:     PROCEDURE BOParaForm()
4378:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4379:             RETURN
4380:         ENDIF
4381: 
4382:         WITH THIS.this_oBusinessObject
4383:             *-- 1. Identificacao do produto dono dos servicos
4384:             THIS.txt_4c_Produto.Value   = ALLTRIM(.this_cCprosItem)
4385:             THIS.txt_4c_Descricao.Value = ALLTRIM(.this_cDprosItem)
4386:             THIS.txt_4c_Mercs.Value     = ALLTRIM(.this_cMercsItem)
4387: 
4388:             *-- 2. Painel "Tamanho" da linha corrente
4389:             THIS.cnt_4c_Tamanho.txt_4c_TamDe.Value   = ALLTRIM(.this_cTamDe)
4390:             THIS.cnt_4c_Tamanho.txt_4c_TamPara.Value = ALLTRIM(.this_cTamPara)
4391:         ENDWITH
4392: 
4393:         THIS.grd_4c_Dados.Refresh()
4394: 
4395:         RETURN
4396:     ENDPROC
4397: 
4398:     *--------------------------------------------------------------------------
4399:     * TornarControlesVisiveis - AddObject cria todo controle com Visible = .F.
4400:     *
4401:     * A lista de excecao existe porque TRES objetos nascem OCULTOS no SCX
4402:     * legado (Visible = .F. no dump) e sao mostrados em runtime pelos handlers:
4403:     *
4404:     *   btnTotItens  -> cmd_4c_BtnTotItens   ("Total de Servicos")
4405:     *   btnCotacao   -> cmd_4c_BtnCotacao    ("Excluir Servicos")
4406:     *   btnAltImps   -> cmd_4c_BtnAltImps    ("Alterar Valores")
4407:     *
4408:     * Forcar Visible = .T. neles APAGARIA o estado inicial que o legado
4409:     * declara. A verificacao eh por nome, como manda o padrao dos forms
4410:     * OPERACIONAIS com controles de visibilidade alternada; os tres objetos
4411:     * sao criados por ConfigurarBotoesServico, e a lista os cobre.
4412:     *
4413:     * Grid fica fora da recursao: suas Columns nao sao controles de container
4414:     * comum, e a visibilidade delas eh definida junto com a grade.
4415:     *--------------------------------------------------------------------------
4416:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4417:         LOCAL loc_nI, loc_oControle, loc_cNome
4418: 
4419:         IF VARTYPE(par_oContainer) != "O"
4420:             RETURN
4421:         ENDIF
4422: 
4423:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
4424:             RETURN
4425:         ENDIF
4426: 
4427:         FOR loc_nI = 1 TO par_oContainer.ControlCount
4428:             loc_oControle = par_oContainer.Controls(loc_nI)
4429: 
4430:             IF VARTYPE(loc_oControle) = "O"
4431:                 loc_cNome = UPPER(ALLTRIM(loc_oControle.Name))
4432: 
4433:                 IF !INLIST(loc_cNome, "CMD_4C_BTNTOTITENS", ;
4434:                                       "CMD_4C_BTNCOTACAO", ;
4435:                                       "CMD_4C_BTNALTIMPS")
4436:                     IF PEMSTATUS(loc_oControle, "Visible", 5)
4437:                         loc_oControle.Visible = .T.
4438:                     ENDIF
4439:                 ENDIF
4440: 
4441:                 IF UPPER(ALLTRIM(loc_oControle.BaseClass)) != "GRID" ;
4442:                    AND PEMSTATUS(loc_oControle, "ControlCount", 5) ;
4443:                    AND loc_oControle.ControlCount > 0
4444:                     THIS.TornarControlesVisiveis(loc_oControle)
4445:                 ENDIF
4446:             ENDIF
4447:         ENDFOR
4448: 
4449:         RETURN
4450:     ENDPROC
4451: 
4452:     *--------------------------------------------------------------------------
4453:     * Destroy - Fecha os cursores que ESTA tela cria e libera as referencias.
4454:     *
4455:     * Os cursores do CHAMADOR (crTpmMvItn3, crTpmMvItn, TprMvCab, CrSigCdOpe)
4456:     * NAO sao fechados aqui: eles pertencem ao form que abriu o dialogo e
4457:     * continuam em uso depois que esta tela fecha. Fecham-se apenas os dois que
4458:     * o dialogo monta para si (csTmpDesc e csSigCdPro).
4459:     *
4460:     * CrSigCdOpe fica de fora mesmo quando foi esta tela que o consultou (ver
4461:     * CarregarConfiguracaoOperacao): o Cursorquery do legado tambem o deixa
4462:     * aberto na sessao do chamador, e o documento continua precisando dele.
4463:     *
4464:     * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
4465:     * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
4466:     * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
4467:     * existe para o caso em que o buffer de fato tenha algo a descartar).
4468:     *
4469:     * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
4470:     * restaura os popups do menu principal depois de um form modal.
4471:     *--------------------------------------------------------------------------
4472:     PROCEDURE Destroy()
4473:         LOCAL loc_nI, loc_cCursor
4474:         LOCAL ARRAY loc_aCursores[2]
4475: 
4476:         loc_aCursores[1] = THIS.this_cCursorDescricoes
4477:         loc_aCursores[2] = THIS.this_cCursorLista
4478: 
4479:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
4480:             loc_cCursor = loc_aCursores[loc_nI]
4481: 
4482:             IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
4483:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
4484:                     TABLEREVERT(.T., loc_cCursor)
4485:                 ENDIF
4486:                 USE IN (loc_cCursor)
4487:             ENDIF
4488:         ENDFOR
4489: 
4490:         *-- Devolve o chamador ao usuario mesmo quando o dialogo eh fechado por
4491:         *-- Esc ou por QueryUnload, e nao pelo botao Retornar
4492:         THIS.ReabilitarChamador()
4493: 
4494:         THIS.this_oFormChamador = .NULL.
4495:         THIS.this_oFormPai      = .NULL.
4496: 
4497:         DODEFAULT()
4498:     ENDPROC
4499: 
4500: ENDDEFINE
4501: 
4502: *==============================================================================
4503: * TextBoxServicoSer_4c / TextBoxDescricaoSer_4c
4504: *
4505: * As celulas das colunas "Servico" e "Descricao" da grade de servicos. Existem
4506: * como SUBCLASSE, e nao como BINDEVENT sobre o Text1 da Column, porque
4507: * BINDEVENT em "Valid" de TextBox de Column nao eh confiavel em VFP9
4508: * (regra #46) - e eh justamente no Valid que o legado poe o lookup.
4509: *
4510: * Nenhuma das duas carrega regra: cada evento DELEGA ao form dono, alcancado
4511: * por THISFORM. Assim o funil do lookup continua unico e a guarda de
4512: * reentrancia continua valendo para as quatro portas. THISFORM em vez de uma
4513: * referencia guardada numa propriedade de proposito: o par form-celula criaria
4514: * um ciclo de referencias que impediria a liberacao do form.
4515: *
4516: * KeyPress so age em F4 (115) e F5 (116): sem esse teste o picker abriria a
4517: * cada tecla digitada (regra #47). NODEFAULT impede o VFP de tratar a tecla
4518: * depois que o dialogo ja a consumiu.
4519: *==============================================================================
4520: DEFINE CLASS TextBoxServicoSer_4c AS TextBox
4521: 
4522:     PROCEDURE When()
4523:         IF VARTYPE(THISFORM) != "O"
4524:             RETURN .T.
4525:         ENDIF
4526: 
4527:         RETURN THISFORM.CelulaServicoLiberada(THIS)
4528:     ENDPROC
4529: 
4530:     PROCEDURE Valid()
4531:         IF VARTYPE(THISFORM) != "O"
4532:             RETURN .T.
4533:         ENDIF
4534: 
4535:         RETURN THISFORM.ValidarCelulaServico(THIS)
4536:     ENDPROC
4537: 
4538:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
4539:         IF INLIST(par_nKeyCode, 115, 116) AND VARTYPE(THISFORM) = "O"
4540:             THISFORM.ValidarCelulaServico(THIS)
4541:             NODEFAULT
4542:         ENDIF
4543:     ENDPROC
4544: 
4545:     PROCEDURE DblClick()
4546:         IF VARTYPE(THISFORM) = "O"
4547:             THISFORM.ValidarCelulaServico(THIS)
4548:         ENDIF
4549:     ENDPROC
4550: 
4551:     PROCEDURE LostFocus()
4552:         IF VARTYPE(THISFORM) = "O"
4553:             THISFORM.CelulaServicoLostFocus(THIS)
4554:         ENDIF
4555:     ENDPROC
4556: 
4557: ENDDEFINE
4558: 
4559: DEFINE CLASS TextBoxDescricaoSer_4c AS TextBox
4560: 
4561:     PROCEDURE When()
4562:         IF VARTYPE(THISFORM) != "O"
4563:             RETURN .T.
4564:         ENDIF
4565: 
4566:         RETURN THISFORM.CelulaDescricaoLiberada(THIS)
4567:     ENDPROC
4568: 
4569:     PROCEDURE Valid()
4570:         IF VARTYPE(THISFORM) != "O"
4571:             RETURN .T.
4572:         ENDIF
4573: 
4574:         RETURN THISFORM.ValidarCelulaDescricao(THIS)
4575:     ENDPROC
4576: 
4577:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
4578:         IF INLIST(par_nKeyCode, 115, 116) AND VARTYPE(THISFORM) = "O"
4579:             THISFORM.ValidarCelulaDescricao(THIS)
4580:             NODEFAULT
4581:         ENDIF
4582:     ENDPROC
4583: 
4584:     PROCEDURE DblClick()
4585:         IF VARTYPE(THISFORM) = "O"
4586:             THISFORM.ValidarCelulaDescricao(THIS)
4587:         ENDIF
4588:     ENDPROC
4589: 
4590:     PROCEDURE LostFocus()
4591:         IF VARTYPE(THISFORM) = "O"
4592:             THISFORM.CelulaDescricaoLostFocus(THIS)
4593:         ENDIF
4594:     ENDPROC
4595: 
4596: ENDDEFINE
4597: 
4598: *==============================================================================
4599: * TextBoxQtdSer_4c / TextBoxValorSer_4c
4600: *
4601: * As celulas das colunas "Quantidade" e "Valor" da grade de servicos. Existem
4602: * pelo MESMO motivo das duas subclasses acima: o legado poe When, Valid e
4603: * LostFocus no Text1 de cada coluna, e nenhum dos tres pode ser ligado por
4604: * BINDEVENT - "Valid" de TextBox de Column nao eh confiavel em VFP9
4605: * (regra #46) e "When" ligado por BINDEVENT tem o retorno DESCARTADO, de modo
4606: * que o gate de edicao nao bloquearia nada.
4607: *
4608: * Nenhuma das duas carrega regra: cada evento DELEGA ao form dono, alcancado
4609: * por THISFORM - assim as regras do legado ficam num lugar so e podem ser
4610: * lidas lado a lado com o dump.
4611: *==============================================================================
4612: DEFINE CLASS TextBoxQtdSer_4c AS TextBox
4613: 
4614:     PROCEDURE When()
4615:         IF VARTYPE(THISFORM) != "O"
4616:             RETURN .T.
4617:         ENDIF
4618: 
4619:         RETURN THISFORM.CelulaQtdLiberada(THIS)
4620:     ENDPROC
4621: 
4622:     PROCEDURE Valid()
4623:         IF VARTYPE(THISFORM) != "O"
4624:             RETURN .T.
4625:         ENDIF
4626: 
4627:         RETURN THISFORM.ValidarCelulaQtd(THIS)
4628:     ENDPROC
4629: 
4630: ENDDEFINE
4631: 
4632: DEFINE CLASS TextBoxValorSer_4c AS TextBox
4633: 
4634:     PROCEDURE When()
4635:         IF VARTYPE(THISFORM) != "O"
4636:             RETURN .T.
4637:         ENDIF
4638: 
4639:         RETURN THISFORM.CelulaValorLiberada(THIS)
4640:     ENDPROC
4641: 
4642:     PROCEDURE Valid()
4643:         IF VARTYPE(THISFORM) != "O"
4644:             RETURN .T.
4645:         ENDIF
4646: 
4647:         RETURN THISFORM.ValidarCelulaValor(THIS)
4648:     ENDPROC
4649: 
4650:     PROCEDURE LostFocus()
4651:         IF VARTYPE(THISFORM) = "O"
4652:             THISFORM.CelulaValorLostFocus()
4653:         ENDIF
4654:     ENDPROC
4655: 
4656: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopserBO.prg):
*==============================================================================
* sigopserBO.prg - Business Object para Servicos do Item (SIGOPSER)
* Tabela principal: SigMvItn (linhas de servico do item de movimento)
* Tabela relacionada: SigMvItp (TamDe/TamPara - tamanho exigido do servico)
* Dialogo modal aberto pelo form pai (ex.: SigOpPed) para detalhar os
* servicos vinculados a um item de produto (ThisForm.ParentForm.Citem).
*==============================================================================

DEFINE CLASS sigopserBO AS BusinessBase

    *-- Identificacao do movimento/operacao pai (contexto recebido do form
    *-- que abriu o dialogo - TprMvCab/crTpmMvItn do legado) --------------
    this_cEmps            = ""    && char(3)  - Empresa
    this_cDopes           = ""    && char(20) - Operacao do movimento (TprMvCab.Dopes)
    this_nNumes           = 0     && N(6,0)   - Numero sequencial do movimento (TprMvCab.Numes)
    this_nCitemProduto    = 0     && N(10,0)  - Citens do item de produto ao qual os servicos pertencem (ThisForm.Citem)
    this_cCursorAlias     = ""    && Alias do cursor de grade compartilhado com o form pai (crTpmMvItn3 no
                                   && legado), setado pelo Form antes de chamar CarregarDoCursor/Inserir/Atualizar

    *-- Configuracao da operacao (SigCdOpe) - carregada uma vez por sessao
    *-- do dialogo e reutilizada nas validacoes de preco/quantidade -------
    this_nCasas           = 0     && N(1,0)  - Casas decimais do preco unitario (CrSigCdOpe.Casas)
    this_nZerQtds         = 0     && N(1,0)  - Zera a quantidade ao trocar de produto (CrSigCdOpe.ZerQtds)
    this_nPrecoAuts       = 0     && N(1,0)  - Busca preco de lista automaticamente (CrSigCdOpe.PrecoAuts)
    this_nPrecoPs         = 0     && N(2,0)  - Fonte do preco quando nao ha lista vigente (CrSigCdOpe.PrecoPs)
    this_nPrecops         = 0     && N(1,0)  - Define a moeda de faturamento do item (CrSigCdOpe.Precops)
    this_cCMoes           = ""    && char(3) - Moeda padrao da operacao (CrSigCdOpe.CMoes)
    this_nItSituas        = 0     && N(1,0)  - Filtro de situacao do produto/servico (CrSigCdOpe.ItSituas)
    this_nHabServs        = 0     && N(1,0)  - Indica se a operacao habilita servicos (CrSigCdOpe.HabServs)

    *-- Flags de garantia recebidos do form pai no Init do dialogo --------
    this_lGarantia            = .F.   && Indica fluxo de garantia (par_lGarantia)
    this_lValorZeroGarantia   = .F.   && Zera o valor unitario quando em garantia (par_lVlrZeroGarantia)

    *-- Identificacao do PRODUTO dono dos servicos (crTpmMvItn + SigCdPro do
    *-- legado), exibida no cabecalho do dialogo nos campos Get_Produto /
    *-- Get_Descricao / Get_Mercs. Propriedades SEPARADAS das da linha
    *-- (this_cCpros/this_cDpros) de proposito: aquelas descrevem o SERVICO da
    *-- linha corrente da grade e mudam a cada troca de linha, estas descrevem
    *-- o item do documento e valem para o dialogo inteiro - reaproveitar as
    *-- primeiras faria a descricao do produto sobrescrever a do servico.
    this_cCprosItem       = ""    && char(14) - Codigo do produto do item (crTpmMvItn.Cpros)
    this_cDprosItem       = ""    && char(65) - Descricao do produto do item (SigCdPro.dpros)
    this_cMercsItem       = ""    && char(3)  - Mercadoria do produto do item (SigCdPro.mercs)

    *-- Dados do item de servico (linha corrente de SigMvItn + SigMvItp) --
    this_cCidChaves       = ""    && char(20) - Chave unica do item (PK)
    this_nCitens          = 0     && N(10,0)  - Item (mesmo citens do produto pai)
    this_cCpros           = ""    && char(14) - Codigo do servico
    this_cDpros           = ""    && char(65) - Descricao do servico
    this_cCunis           = ""    && char(3)  - Unidade
    this_nQtds            = 0     && N(9,3)   - Quantidade
    this_nUnits           = 0     && N(15,6)  - Valor unitario
    this_nUnivals         = 0     && N(15,6)  - Valor unitario de venda (tabela de preco)
    this_nTotas           = 0     && N(11,2)  - Total do item
    this_cMoedas          = ""    && char(3)  - Moeda do item
    this_cMoefats         = ""    && char(3)  - Moeda de faturamento
    this_cMoevs           = ""    && char(3)  - Moeda de venda
    this_nMoevals         = 0     && N(15,6)  - Valor na moeda de venda
    this_lIconfs          = .F.   && bit      - Exige confirmacao de tamanho
    this_nCodBarras       = 0     && N(14,0)  - Codigo de barras
    this_nUtilizas        = 0     && N(4,0)   - Utilizas
    this_cNotas           = ""    && char(6)  - Notas
    this_cObs             = ""    && memo     - Observacao
    this_cTamDe           = ""    && char(3)  - Tamanho De (SigMvItp)
    this_cTamPara         = ""    && char(3)  - Tamanho Para (SigMvItp)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigopserBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do servico a partir do
    * registro corrente do cursor informado (equivalente a leitura de
    * crTpmMvItn3 feita pelos handlers Valid/AfterRowColChange do legado).
    * par_cCursor eh o alias do cursor de grade compartilhado com o form pai.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor) AND USED(par_cCursor)

            SELECT (par_cCursor)

            IF !EOF()
                TRY
                    THIS.this_cCursorAlias = par_cCursor

                    THIS.this_cCidChaves   = TratarNulo(cidchaves, "")
                    THIS.this_cEmps        = TratarNulo(emps, "")
                    THIS.this_cDopes       = TratarNulo(dopes, "")
                    THIS.this_nNumes       = TratarNulo(numes, 0)
                    THIS.this_nCitens      = TratarNulo(citens, 0)
                    THIS.this_cCpros       = TratarNulo(cpros, "")
                    THIS.this_cDpros       = TratarNulo(dpros, "")
                    THIS.this_cCunis       = TratarNulo(cunis, "")
                    THIS.this_nQtds        = TratarNulo(qtds, 0)
                    THIS.this_nUnits       = TratarNulo(units, 0)
                    THIS.this_nUnivals     = TratarNulo(univals, 0)
                    THIS.this_nTotas       = TratarNulo(totas, 0)
                    THIS.this_cMoedas      = TratarNulo(moedas, "")
                    THIS.this_cMoefats     = TratarNulo(moefats, "")
                    THIS.this_cMoevs       = TratarNulo(moevs, "")
                    THIS.this_nMoevals     = TratarNulo(moevals, 0)
                    THIS.this_lIconfs      = ConverterParaLogico(iconfs)
                    THIS.this_nCodBarras   = TratarNulo(codbarras, 0)
                    THIS.this_nUtilizas    = TratarNulo(utilizas, 0)
                    THIS.this_cNotas       = TratarNulo(notas, "")
                    THIS.this_cObs         = TratarNulo(obs, "")
                    THIS.this_cTamDe       = TratarNulo(tamde, "")
                    THIS.this_cTamPara     = TratarNulo(tampara, "")

                    loc_lResultado = .T.

                CATCH TO loc_oErro
                    MsgErro("Erro ao carregar linha de servi" + CHR(231) + "o do cursor: " + loc_oErro.Message, "Erro")
                    loc_lResultado = .F.
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Adiciona uma nova linha de servico ao cursor de grade
    * compartilhado com o formulario pai (equivalente ao mInsereLinha() do
    * legado, que faz "Insert Into crTpmMvItn3(...) Values (...)").
    *
    * Este dialogo NUNCA grava diretamente em SigMvItn/SigMvItp: no legado,
    * o Init monta e o cntOK.btnSair apenas valida/fecha o cursor compartilhado
    * crTpmMvItn3 - a persistencia definitiva (e a auditoria correspondente)
    * acontece quando o formulario pai salva o documento (pedido) por completo.
    * Por isso THIS.RegistrarAuditoria() nao e chamado aqui.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)
            APPEND BLANK

            REPLACE emps      WITH THIS.this_cEmps, ;
                    dopes     WITH THIS.this_cDopes, ;
                    numes     WITH THIS.this_nNumes, ;
                    citens    WITH THIS.this_nCitemProduto, ;
                    cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            THIS.this_nCitens = THIS.this_nCitemProduto
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Grava as alteracoes do servico corrente no registro
    * posicionado do cursor de grade compartilhado (equivalente aos blocos
    * "Replace ... In crTpmMvItn3" dos handlers Valid/LostFocus do legado:
    * PRODUTO.Valid, QTD.Valid, VALOR.Valid, Descricao.Valid, getTamDe/
    * getTamPara.Valid). Mesma observacao da Inserir() quanto a auditoria.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarTamanhos - Grava NO registro posicionado do cursor de grade
    * apenas as duas colunas do painel "Tamanho" (SigMvItp.TamDe/TamPara).
    *
    * Equivalente exato do "Replace TamDe With This.Value In crTpmMvItn3" que o
    * legado faz no Valid de cada um dos dois campos. Existe ao lado de
    * Atualizar() - e nao no lugar dela - porque Atualizar() regrava a LINHA
    * INTEIRA: usa-la aqui ampliaria a escrita para 18 colunas que o legado nao
    * toca neste caminho, inclusive iconfs, cujo tipo varia conforme o driver
    * que montou o cursor do chamador.
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51).
    *==========================================================================
    PROCEDURE AtualizarTamanhos()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE tamde   WITH THIS.this_cTamDe, ;
                    tampara WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar o tamanho do servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterMercadoriaProduto - Mercadoria (SigCdPro.mercs) do produto dono dos
    * servicos. Eh o que o legado obtinha junto com a descricao do item:
    *
    *   =ThisForm.Parentform.Podatamgr.Cursorquery('SigCdPro','CrTmpPro', ;
    *                                   'Cpros', crTpmMvItn.Cpros,[dpros, Mercs])
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51). Devolve ""
    * quando nao ha conexao ou o produto nao existe - o chamador decide o
    * default, como o legado faz no Iif de lcMercs.
    *==========================================================================
    PROCEDURE ObterMercadoriaProduto(par_cCpros)
        LOCAL loc_cMercs, loc_cSQL, loc_nResultado, loc_nAreaAnterior, loc_oErro

        loc_cMercs        = ""
        loc_nAreaAnterior = SELECT()

        TRY
            IF VARTYPE(par_cCpros) = "C" AND !EMPTY(ALLTRIM(par_cCpros)) ;
               AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                loc_cSQL = "SELECT dpros, mercs FROM SigCdPro" + ;
                           " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

                IF USED("cursor_4c_ProdutoItem")
                    USE IN cursor_4c_ProdutoItem
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoItem")

                IF loc_nResultado < 0
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
                            "produto do item." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_ProdutoItem")
                        SELECT cursor_4c_ProdutoItem
                        GO TOP

                        IF !EOF()
                            loc_cMercs = ALLTRIM(TratarNulo(mercs, ""))

                            *-- Identificacao do PRODUTO do item, nas
                            *-- propriedades proprias dele: this_cDpros
                            *-- descreve o SERVICO da linha corrente e seria
                            *-- sobrescrita aqui, fazendo a grade exibir a
                            *-- descricao do produto no lugar da do servico.
                            *-- this_cCprosItem eh escrita pelo Form, que eh
                            *-- quem le o codigo no cursor do item
                            THIS.this_cDprosItem = ALLTRIM(TratarNulo(dpros, ""))
                            THIS.this_cMercsItem = loc_cMercs
                        ENDIF

                        USE IN cursor_4c_ProdutoItem
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler o produto do item")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_cMercs
    ENDPROC

    *==========================================================================
    * CarregarServicosDisponiveis - monta csSigCdPro, o UNIVERSO dos servicos
    * que o usuario pode escolher nas colunas "Servico" e "Descricao" da grade.
    *
    * Legado (Init de SIGOPSER), transcrito:
    *
    *   If (crSigCdOpe.HabServs = 1)
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a, SigCdGrp b ]+;
    *                [Where a.Cgrus = b.Cgrus And b.Servicos = 1 ]+;
    *          Iif(crSigCdOpe.ItSituas=1,[ And (Not a.Situas = 2 Or (a.Situas = 2 And
    *                    (Not a.DtSituas Is Null And a.DtSituas < ?pDat)))], ;
    *          Iif(crSigCdOpe.ItSituas=2,[ And a.Situas = 2 ],[]))
    *   Else
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a Where 0=1 ]
    *   EndIf
    *   ...
    *   Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite
    *
    * O "Where 0=1" do ramo Else NAO eh defeito: operacao que nao habilita
    * servicos tem universo VAZIO de proposito, e o legado monta o cursor assim
    * mesmo para que a estrutura exista e os indices possam ser criados.
    *
    * O filtro por mercadoria eh o re-Select que o legado faz logo depois; aqui
    * ele entra no proprio WHERE porque o resultado eh o mesmo e evita uma
    * segunda passagem sobre o cursor inteiro. Quando o chamador nao consegue
    * resolver a mercadoria (par_cMercs vazio), o filtro NAO eh aplicado - o
    * legado nunca chega a esse caso porque sempre cai no default 'JOI'.
    *
    * O cursor sai READWRITE porque o Form cria indices sobre ele (Cpros/DPros)
    * e o cursor de SQLEXEC nasce somente-leitura; por isso o SQLEXEC vai para
    * um alias TEMPORARIO e o resultado eh convertido.
    *
    * pDat do legado eh Datetime() do cliente, nao GETDATE() do servidor:
    * transcrito como GETDATE().
    *==========================================================================
    PROCEDURE CarregarServicosDisponiveis(par_cCursor, par_cMercs)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor, loc_nResultado
        LOCAL loc_nAreaAnterior, loc_oErro

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cCursor       = IIF(VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor), ;
                                par_cCursor, "csSigCdPro")

        TRY
            IF THIS.this_nHabServs = 1
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a, SigCdGrp b" + ;
                           " WHERE a.Cgrus = b.Cgrus AND b.Servicos = 1"

                DO CASE
                    CASE THIS.this_nItSituas = 1
                        loc_cSQL = loc_cSQL + ;
                            " AND (NOT a.Situas = 2 OR (a.Situas = 2" + ;
                            " AND (NOT a.DtSituas IS NULL" + ;
                            " AND a.DtSituas < " + GETDATE() + ")))"
                    CASE THIS.this_nItSituas = 2
                        loc_cSQL = loc_cSQL + " AND a.Situas = 2"
                ENDCASE
            ELSE
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a WHERE 0 = 1"
            ENDIF

            IF VARTYPE(par_cMercs) = "C" AND !EMPTY(ALLTRIM(par_cMercs))
                loc_cSQL = loc_cSQL + ;
                           " AND a.IdeCPros = " + EscaparSQL(ALLTRIM(par_cMercs))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cpros"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                            THIS.this_cMensagemErro, ;
                            "Falha na Conex" + CHR(227) + "o (csSigCdPro)")
                ELSE
                    IF USED(loc_cCursor)
                        IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                            TABLEREVERT(.T., loc_cCursor)
                        ENDIF
                        USE IN (loc_cCursor)
                    ENDIF

                    SELECT Cpros, Dpros, IdeCPros ;
                        FROM cursor_4c_ServicosTmp ;
                        INTO CURSOR (loc_cCursor) READWRITE

                    IF USED("cursor_4c_ServicosTmp")
                        USE IN cursor_4c_ServicosTmp
                    ENDIF

                    loc_lSucesso = USED(loc_cCursor)
                ENDIF
            ELSE
                *-- Sem conexao (harness de teste / validacao de UI): o cursor
                *-- existe VAZIO, com a mesma estrutura, para que a grade e os
                *-- lookups encontrem o alias em vez de estourar
                IF USED(loc_cCursor)
                    IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                        TABLEREVERT(.T., loc_cCursor)
                    ENDIF
                    USE IN (loc_cCursor)
                ENDIF

                CREATE CURSOR (loc_cCursor) ( Cpros    C(14), ;
                                              Dpros    C(65), ;
                                              IdeCPros C(3) )

                loc_lSucesso = USED(loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao montar a lista de servi" + CHR(231) + "os")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do item corrente, usada
    * pela RegistrarAuditoria() da BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

ENDDEFINE

