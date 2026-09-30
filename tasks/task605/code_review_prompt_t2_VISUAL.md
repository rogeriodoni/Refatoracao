# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1025 linhas total):

*-- Linhas 11 a 19:
11: * de cada linha marcada - identico ao Scan do cmdSair.Click legado.
12: *
13: * Layout FLAT (legado SIGPREOP.SCX NAO tem PageFrame - grid,
14: * checkbox de marcar todos, par de campos somente-exibicao
15: * (Operacao/Numero) e botao OK ficam direto no form): grid e
16: * botoes entram na Fase 4, campos de exibicao na Fase 5,
17: * BINDEVENTs/eventos nas Fases 7-8.
18: *
19: * Chamada: CREATEOBJECT("FormSigPrEop", oParentForm,

*-- Linhas 28 a 42:
28: *   Fase 4:   FormSigPrEop.prg - grd_4c_Dados (7 colunas na ordem
29: *             ColumnOrder do legado), CarregarDados (carga do cursor +
30: *             vinculo da grade + GO TOP/Refresh), chk_4c_Ck_Marca e
31: *             cmd_4c_CmdSair (criacao visual; Click/BINDEVENT ficam
32: *             para as Fases 7/8)
33: *   Fase 5:   FormSigPrEop.prg - lbl_4c_Lbl_descricao + txt_4c__Operacao
34: *             (1o par label/campo de exibicao da linha corrente do
35: *             grid - equivalente a "ThisForm.get_Operacao.ControlSource
36: *             = [crOperacoes.Dopes]" do Init legado)
37: *   Fase 6:   FormSigPrEop.prg - lbl_4c_Label1 + txt_4c__Numes (2o par
38: *             label/campo de exibicao - Say1/get_Numes do legado,
39: *             equivalente a "ThisForm.get_Numes.ControlSource =
40: *             [crOperacoes.Numes]" do Init legado), o comportamento
41: *             desses campos (GridAfterRowColChange ligado por BINDEVENT
42: *             no AfterRowColChange da grade - o AfterRowColChange legado

*-- Linhas 53 a 67:
53: *             original - inventar um picker aqui violaria o PILAR 1 e a
54: *             regra "NUNCA inventar tabelas de lookup que nao existem no
55: *             original". Sem container de Salvar/Cancelar: este form
56: *             OPERACIONAL ja tem seu unico botao de acao (cmd_4c_CmdSair,
57: *             "OK") criado na Fase 4 - o legado nao tem par
58: *             Confirmar/Cancelar.
59: *   Fase 7:   FormSigPrEop.prg - eventos principais: o toggle do checkbox
60: *             de cada linha da grade (Column1.Check1 - GridCheck1Click/
61: *             MouseDown/MouseUp/KeyPress, os 4 handlers ligados por
62: *             BINDEVENT porque o CheckBox de Grid nao alterna sozinho -
63: *             o legado suprime o toggle nativo e alterna por codigo no
64: *             MouseDown e no KeyPress de Enter/Espaco, replicado
65: *             identico ao comportamento.json), CkMarcaClick (ck_Marca.
66: *             Click - marcar/desmarcar todas as linhas via BO.
67: *             MarcarTodasOperacoes) e BtnOKClick (cmdSair.Click - monta

*-- Linhas 197 a 205:
197:     *--------------------------------------------------------------------------
198:     * InicializarForm - Monta a estrutura visual base do form (chamado
199:     * por FormBase.Init via DODEFAULT). Layout FLAT: o legado
200:     * (SIGPREOP.SCX) nao tem PageFrame - grid, checkbox, campos e botao
201:     * vao direto no form nas proximas fases.
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE InicializarForm()
204:         LOCAL loc_lSucesso, loc_oErro, loc_cPictureFundo
205:         loc_lSucesso = .F.

*-- Linhas 245 a 253:
245:                     THIS.CarregarDados()
246:                 ENDIF
247: 
248:                 *-- 6. Checkbox "marcar/desmarcar todas" (ck_Marca do legado) -
249:                 *-- criado DEPOIS da grade para ficar por cima dela (Top=123
250:                 *-- cai sobre o topo do grdOperacoes, Top=121, igual ao legado)
251:                 THIS.ConfigurarCkMarca()
252: 
253:                 *-- 7. Botao OK (cmdSair do legado)

*-- Linhas 270 a 345:
270:     *--------------------------------------------------------------------------
271:     * ConfigurarCabecalho - Cria a faixa cinza do topo (cntSombra do
272:     * legado): container opaco RGB(100,100,100) com o Caption do form
273:     * duplicado em lbl_4c_Sombra (sombra preta) e lbl_4c_Titulo (texto
274:     * branco por cima) - identico ao Init legado
275:     * (ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption /
276:     * ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption)
277:     *--------------------------------------------------------------------------
278:     PROTECTED PROCEDURE ConfigurarCabecalho()
279:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
280:         WITH THIS.cnt_4c_Cabecalho
281:             .Top           = 0
282:             .Left          = 0
283:             .Width         = THIS.Width
284:             .Height        = 80
285:             .BackColor     = RGB(100, 100, 100)
286:             .BorderWidth   = 0
287:             .SpecialEffect = 0
288:             .Visible     = .T.
289:         ENDWITH
290: 
291:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
292:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
293:             .Top       = 25
294:             .Left      = 10
295:             .Width     = THIS.cnt_4c_Cabecalho.Width - 31
296:             .Height    = 40
297:             .FontName  = "Tahoma"
298:             .FontSize  = 18
299:             .FontBold  = .T.
300:             .WordWrap  = .T.
301:             .Alignment = 0
302:             .BackStyle = 0
303:             .ForeColor = RGB(0, 0, 0)
304:             .Caption   = THIS.Caption
305:         ENDWITH
306: 
307:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
308:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
309:             .Top         = 24
310:             .Left        = 10
311:             .Width       = THIS.cnt_4c_Cabecalho.Width - 31
312:             .Height      = 46
313:             .FontName    = "Tahoma"
314:             .FontSize    = 18
315:             .FontBold    = .T.
316:             .WordWrap    = .T.
317:             .Alignment   = 0
318:             .BackStyle   = 0
319:             .ForeColor   = RGB(255, 255, 255)
320:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
321:             .Caption     = THIS.Caption
322:         ENDWITH
323:     ENDPROC
324: 
325:     *--------------------------------------------------------------------------
326:     * ConfigurarGrid - Cria grd_4c_Dados (grdOperacoes do legado) com as 7
327:     * colunas na ordem visual do Init legado (ColumnOrder, NAO a ordem
328:     * fisica dos registros do dump - o SCX legado renomeia as colunas
329:     * internamente, mas aqui a colecao Columns(1..7) ja nasce na ordem
330:     * certa, sem precisar de rename - CLAUDE.md proibe .Name em Columns).
331:     * Somente a Column1 (Selecionada) eh editavel: AddObject de CheckBox +
332:     * CurrentControl + Sparse=.F., ReadOnly=.F. (regra do CheckBox em
333:     * Grid Column). As demais colunas replicam o
334:     * "For I=2 To .ColumnCount ... .ReadOnly = .t." do Init legado.
335:     *--------------------------------------------------------------------------
336:     PROTECTED PROCEDURE ConfigurarGrid()
337:         THIS.AddObject("grd_4c_Dados", "Grid")
338:         WITH THIS.grd_4c_Dados
339:             .Top               = 121
340:             .Left              = 3
341:             .Width             = 732
342:             .Height            = 275
343:             .FontName          = "Tahoma"
344:             .HeaderHeight      = 19
345:             .DeleteMark        = .F.

*-- Linhas 351 a 393:
351:             .GridLineColor     = RGB(238, 238, 238)
352:             .ColumnCount       = 7
353: 
354:             *-- Column1 - Selecionada (checkbox, ColumnOrder implicito = 1)
355:             .Column1.AddObject("chk_4c_Check1", "CheckBox")
356:             WITH .Column1
357:                 .FontName       = "Tahoma"
358:                 .Width          = 15
359:                 .Movable        = .F.
360:                 .Resizable      = .F.
361:                 .ReadOnly       = .F.
362:                 .Sparse         = .F.
363:                 .CurrentControl = "chk_4c_Check1"
364:                 .Header1.Caption   = ""
365:                 .Header1.FontName  = "Tahoma"
366:                 .Header1.FontSize  = 8
367:                 .Header1.Alignment = 2
368:                 .Header1.ForeColor = RGB(90, 90, 90)
369:             ENDWITH
370:             *-- O legado deixa o Caption default ("Check1") e liga AutoSize no
371:             *-- Init (.Column1.Check1.AutoSize = .t.); com a coluna em 15px o
372:             *-- texto fica recortado e so a caixinha aparece. Aqui o Caption
373:             *-- nasce vazio (mesmo resultado visual, sem depender do recorte)
374:             WITH .Column1.chk_4c_Check1
375:                 .Caption   = ""
376:                 .AutoSize  = .T.
377:                 .Value     = 0
378:                 .BackStyle = 0
379:             ENDWITH
380: 
381:             *-- Column2 - Datas (ColumnOrder = 2)
382:             WITH .Column2
383:                 .FontName          = "Courier New"
384:                 .Width             = 80
385:                 .Movable           = .F.
386:                 .Resizable         = .F.
387:                 .ReadOnly          = .T.
388:                 .Header1.Caption   = "Data"
389:                 .Header1.FontName  = "Tahoma"
390:                 .Header1.FontSize  = 8
391:                 .Header1.Alignment = 2
392:                 .Header1.ForeColor = RGB(90, 90, 90)
393:             ENDWITH

*-- Linhas 399 a 422:
399:                 .Movable           = .F.
400:                 .Resizable         = .F.
401:                 .ReadOnly          = .T.
402:                 .Header1.Caption   = "Emp"
403:                 .Header1.FontName  = "Tahoma"
404:                 .Header1.FontSize  = 8
405:                 .Header1.Alignment = 2
406:                 .Header1.ForeColor = RGB(90, 90, 90)
407:             ENDWITH
408: 
409:             *-- Column4 - PrazoEnts (ColumnOrder = 4). Header dinamico:
410:             *-- "Column4.Header1.Caption = lcCabData" no Init legado
411:             WITH .Column4
412:                 .FontName          = "Courier New"
413:                 .Width             = 80
414:                 .Movable           = .F.
415:                 .Resizable         = .F.
416:                 .ReadOnly          = .T.
417:                 .Header1.Caption   = IIF(!EMPTY(THIS.this_cCabecalhoDados), THIS.this_cCabecalhoDados, "Prev. Entrega")
418:                 .Header1.FontName  = "Tahoma"
419:                 .Header1.FontSize  = 8
420:                 .Header1.Alignment = 2
421:                 .Header1.ForeColor = RGB(90, 90, 90)
422:             ENDWITH

*-- Linhas 428 a 436:
428:                 .Movable           = .F.
429:                 .Resizable         = .F.
430:                 .ReadOnly          = .T.
431:                 .Header1.Caption   = "Cliente"
432:                 .Header1.FontName  = "Tahoma"
433:                 .Header1.FontSize  = 8
434:                 .Header1.Alignment = 2
435:                 .Header1.ForeColor = RGB(90, 90, 90)
436:             ENDWITH

*-- Linhas 442 a 450:
442:                 .Movable           = .F.
443:                 .Resizable         = .F.
444:                 .ReadOnly          = .T.
445:                 .Header1.Caption   = "Nome do Cliente"
446:                 .Header1.FontName  = "Tahoma"
447:                 .Header1.FontSize  = 8
448:                 .Header1.Alignment = 2
449:                 .Header1.ForeColor = RGB(90, 90, 90)
450:             ENDWITH

*-- Linhas 457 a 465:
457:                 .Movable           = .F.
458:                 .Resizable         = .F.
459:                 .ReadOnly          = .T.
460:                 .Header1.Caption   = "Conjug" + CHR(234)
461:                 .Header1.FontName  = "Tahoma"
462:                 .Header1.FontSize  = 8
463:                 .Header1.Alignment = 2
464:                 .Header1.ForeColor = RGB(90, 90, 90)
465:             ENDWITH

*-- Linhas 474 a 483:
474:         *-- LPARAMETERS falha em SILENCIO no BINDEVENT (CLAUDE.md regra #3).
475:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")
476: 
477:         *-- Toggle do checkbox de marcacao (Column1.Check1 do legado). O
478:         *-- binding nativo do CheckBox de Grid NAO alterna o valor sozinho
479:         *-- (a celula recebe foco mas clicar/teclar nao muda nada) - o
480:         *-- legado suprime o toggle padrao nos 4 eventos e alterna por
481:         *-- codigo: Click = NoDefault (nao faz nada sozinho), MouseDown =
482:         *-- alterna Selecionada + Refresh + NoDefault, MouseUp = so
483:         *-- NoDefault, KeyPress = alterna em Enter(13)/Espaco(32) + Refresh

*-- Linhas 499 a 563:
499:     * Equivalente funcional aqui e .ReadOnly = .T. (o campo mostra o
500:     * valor mas nao aceita edicao).
501:     *
502:     * Cria os dois pares do dump: "Operacao" (lbl_4c_Lbl_descricao +
503:     * txt_4c__Operacao) e "Numero" (lbl_4c_Label1 + txt_4c__Numes -
504:     * Say1/get_Numes do legado). O ControlSource dos quatro NAO eh atribuido aqui:
505:     * fica em CarregarDados, depois que o cursor de trabalho existe
506:     * (CLAUDE.md regra #41).
507:     *--------------------------------------------------------------------------
508:     PROTECTED PROCEDURE ConfigurarCampos()
509:         THIS.AddObject("lbl_4c_Lbl_descricao", "Label")
510:         WITH THIS.lbl_4c_Lbl_descricao
511:             .Top       = 402
512:             .Left      = 19
513:             .Width     = 56
514:             .Height    = 15
515:             .AutoSize  = .F.
516:             .Alignment = 0
517:             .BackStyle = 0
518:             .FontName  = "Tahoma"
519:             .FontSize  = 8
520:             .ForeColor = RGB(90, 90, 90)
521:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
522:         ENDWITH
523: 
524:         THIS.AddObject("txt_4c__Operacao", "TextBox")
525:         WITH THIS.txt_4c__Operacao
526:             .Top       = 398
527:             .Left      = 87
528:             .Width     = 150
529:             .Height    = 25
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .ForeColor = RGB(90, 90, 90)
533:             .Value     = ""
534:             .ReadOnly  = .T.
535:             .TabStop   = .F.
536:         ENDWITH
537: 
538:         *-- Say1 do legado ("N" + CHR(186) + " :"), AutoSize=.T. no SCX -
539:         *-- texto curto (4 chars), sem risco de recorte (CLAUDE.md #23)
540:         THIS.AddObject("lbl_4c_Label1", "Label")
541:         WITH THIS.lbl_4c_Label1
542:             .Top       = 402
543:             .Left      = 249
544:             .Width     = 21
545:             .Height    = 15
546:             .AutoSize  = .F.
547:             .Alignment = 0
548:             .BackStyle = 0
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .ForeColor = RGB(90, 90, 90)
552:             .Caption   = "N" + CHR(186) + " :"
553:         ENDWITH
554: 
555:         THIS.AddObject("txt_4c__Numes", "TextBox")
556:         WITH THIS.txt_4c__Numes
557:             .Top       = 398
558:             .Left      = 276
559:             .Width     = 50
560:             .Height    = 25
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 633 a 652:
633:                     .Column6.Width = 200
634:                     .Column7.Width = 205
635: 
636:                     .Column1.Header1.Caption = ""
637:                     .Column2.Header1.Caption = "Data"
638:                     .Column3.Header1.Caption = "Emp"
639:                     *-- Column4 tem header dinamico: "Column4.Header1.Caption =
640:                     *-- lcCabData" no Init legado (parametro recebido do chamador)
641:                     .Column4.Header1.Caption = IIF(!EMPTY(THIS.this_cCabecalhoDados), ;
642:                         THIS.this_cCabecalhoDados, "Prev. Entrega")
643:                     .Column5.Header1.Caption = "Cliente"
644:                     .Column6.Header1.Caption = "Nome do Cliente"
645:                     .Column7.Header1.Caption = "Conjug" + CHR(234)
646: 
647:                     *-- O CheckBox da coluna de marcacao tambem se perde no
648:                     *-- rebind - sem isto a coluna volta a desenhar o Text1 e
649:                     *-- o usuario nao consegue marcar linha nenhuma
650:                     IF PEMSTATUS(.Column1, "chk_4c_Check1", 5)
651:                         .Column1.CurrentControl = "chk_4c_Check1"
652:                     ENDIF

*-- Linhas 709 a 717:
709:         loc_lValido   = .F.
710:         loc_cFaltando = ""
711: 
712:         *-- Selecionada: Column1 (checkbox de marcacao, criada pelo SELECT do BO)
713:         *-- Datas/Emps/PrazoEnts/Contas/RClis/Conjuges: Column2..Column7
714:         *-- Dopes/Numes: txt_4c__Operacao / txt_4c__Numes
715:         loc_aCampos[1] = "Selecionada"
716:         loc_aCampos[2] = "Datas"
717:         loc_aCampos[3] = "Emps"

*-- Linhas 783 a 791:
783:     * GridCheck1Click - Column1.Check1.Click do legado ("NoDefault"): o
784:     * clique sozinho nao faz nada, quem alterna o valor eh o MouseDown (e o
785:     * KeyPress, via teclado). Existe so para suprimir o toggle nativo do
786:     * CheckBox, que nao repintaria a grade corretamente.
787:     *--------------------------------------------------------------------------
788:     PROCEDURE GridCheck1Click()
789:         NODEFAULT
790:     ENDPROC
791: 

*-- Linhas 839 a 872:
839:     ENDPROC
840: 
841:     *--------------------------------------------------------------------------
842:     * ConfigurarCkMarca - Checkbox "marcar/desmarcar todas as linhas"
843:     * (ck_Marca do legado), posicionado por cima do canto superior
844:     * esquerdo da grade (Top=123 sobre Top=121 do grid), igual ao legado.
845:     * O Click (Replace All Selecionada with This.Value in crOperacoes +
846:     * grid.Refresh) eh ligado logo abaixo via BINDEVENT, em CkMarcaClick.
847:     *--------------------------------------------------------------------------
848:     PROTECTED PROCEDURE ConfigurarCkMarca()
849:         THIS.AddObject("chk_4c_Ck_Marca", "CheckBox")
850:         WITH THIS.chk_4c_Ck_Marca
851:             .Top       = 123
852:             .Left      = 15
853:             .Width     = 13
854:             .Height    = 17
855:             .Alignment = 0
856:             .Caption   = ""
857:             .Value     = 1
858:             .BackStyle = 0
859:         ENDWITH
860: 
861:         *-- ck_Marca.Click do legado: "Replace All Selecionada with
862:         *-- This.Value in crOperacoes / ThisForm.grdOperacoes.Refresh()"
863:         BINDEVENT(THIS.chk_4c_Ck_Marca, "Click", THIS, "CkMarcaClick")
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * CkMarcaClick - Handler do checkbox "marcar/desmarcar todas as
868:     * linhas" (ck_Marca.Click do legado). Delega ao BO
869:     * (MarcarTodasOperacoes), que faz o REPLACE ALL no cursor de trabalho,
870:     * e repinta a grade em seguida.
871:     *--------------------------------------------------------------------------
872:     PROCEDURE CkMarcaClick()

*-- Linhas 898 a 912:
898:     * form) eh ligado logo abaixo via BINDEVENT, em BtnOKClick.
899:     *--------------------------------------------------------------------------
900:     PROTECTED PROCEDURE ConfigurarBotoes()
901:         THIS.AddObject("cmd_4c_CmdSair", "CommandButton")
902:         WITH THIS.cmd_4c_CmdSair
903:             .Top             = 3
904:             .Left            = 663
905:             .Width           = 75
906:             .Height          = 75
907:             .Caption         = "OK"
908:             .FontName        = "Comic Sans MS"
909:             .FontBold        = .T.
910:             .FontItalic      = .T.
911:             .FontSize        = 8
912:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 923 a 931:
923: 
924:         *-- cmdSair.Click do legado: monta o cursor de saida com a chave
925:         *-- das linhas marcadas e fecha o picker
926:         BINDEVENT(THIS.cmd_4c_CmdSair, "Click", THIS, "BtnOKClick")
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * BtnOKClick - Handler do botao OK (cmdSair.Click do legado):
931:     *


### BO (C:\4c\projeto\app\classes\SigPrEopBO.prg):
*====================================================================
* SigPrEopBO.prg
*
* Business Object para SigPrEop (Selecao de Operacoes)
* Tabela de origem: SigMvCab (movimentacao) | Chave composta: EmpDopNums
*
* Form OPERACIONAL modal (picker) chamado por outras telas do sistema
* para o usuario marcar quais movimentacoes (linhas de SigMvCab, ja
* filtradas pelo chamador num cursor de origem) entram num filtro.
* Nao executa SQL Server proprio: opera sobre cursores em memoria
* recebidos do form chamador (cursor de origem com as movimentacoes
* candidatas) e devolve, ao final, um cursor de saida com a chave
* composta EmpDopNums = Padr(Emps,3) + Padr(Dopes,20) + Padl(Str(Numes,6),6)
* de cada linha marcada - identico ao Scan do cmdSair.Click do legado.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- ===================================================================
    *-- Propriedades da entidade (linha corrente do cursor de operacoes)
    *-- ===================================================================
    this_nSelecionada  = 0     && Selecionada numeric(1,0) - flag de marcacao da linha no grid
    this_cEmps         = ""    && Emps char(3) - empresa (SigMvCab)
    this_cDopes        = ""    && Dopes char(20) - operacao/documento (SigMvCab / SigCdOpe.Dopes)
    this_nNumes        = 0     && Numes numeric(6,0) - numero da movimentacao (SigMvCab)
    this_dDatas        = {}    && Datas date - data da movimentacao
    this_dPrazoEnts    = {}    && PrazoEnts date - previsao de entrega
    this_cContas       = ""    && Contas char - codigo do cliente/conta (SigCdCli.Iclis)
    this_cRClis        = ""    && RClis char - nome/razao do cliente
    this_cConjuges     = ""    && Conjuges - indicador de operacao conjugada
    this_cEmpDopNums   = ""    && EmpDopNums char(29) - chave composta Emps(3)+Dopes(20)+Numes(6)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"

        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas da linha corrente do
    * cursor de operacoes (Selecionada, Emps, Dopes, Numes, Datas,
    * PrazoEnts, Contas, RClis, Conjuges - as mesmas colunas produzidas
    * por "Select 1 as Selecionada, * from crTprMvCab" no Init legado)
    * para as properties this_* da linha corrente, e calcula a chave
    * composta EmpDopNums via ObterChavePrimaria().
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cEmps        = TratarNulo(Emps, "")
            THIS.this_cDopes       = TratarNulo(Dopes, "")
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = ConverterParaData(Datas)
            THIS.this_dPrazoEnts   = ConverterParaData(PrazoEnts)
            THIS.this_cContas      = TratarNulo(Contas, "")
            THIS.this_cRClis       = TratarNulo(RClis, "")
            THIS.this_cConjuges    = TratarNulo(Conjuges, "")

            THIS.this_cEmpDopNums = THIS.ObterChavePrimaria()

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave composta EmpDopNums, identica ao Scan do
    * cmdSair.Click legado: Padr(Emps,3) + Padr(Dopes,20) +
    * Padl(Str(Numes,6),6) (char(29) = 3+20+6). Chave POSICIONAL - o
    * padding faz parte da chave, por isso PADR/PADL nas partes, NUNCA
    * ALLTRIM (CLAUDE.md regra #22 / Erro177: ALLTRIM nas partes internas
    * descasa a busca em SILENCIO, sem erro, devolvendo zero linhas).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + ;
            PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *====================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - o legado (SIGPREOP.SCX)
    * NAO grava nada em SQL Server: eh um picker modal que (1) recebe do
    * form chamador um cursor de origem JA FILTRADO (crTprMvCab), (2)
    * deixa o usuario marcar linhas via checkbox e (3) devolve ao
    * chamador um cursor de saida em memoria (crFilOper) com a chave
    * composta das linhas marcadas - tudo dentro do proprio processo VFP,
    * sem SQLEXEC, sem TABLEUPDATE, sem AddCursor remoto (comportamento.json
    * confirma: nenhum metodo do form tem gravacao remota). O
    * comportamento herdado de BusinessBase (recusar Inserir/Atualizar) ja
    * eh o correto para esta entidade neste form; a operacao real de
    * "gravacao" desta tela eh a montagem do cursor de saida, implementada
    * abaixo em MontarCursorSelecionados() (equivalente ao Scan do
    * cmdSair.Click).
    *====================================================================

    *====================================================================
    * CarregarOperacoes - Constroi o cursor de trabalho da grade a partir
    * do cursor de origem recebido do form chamador, replicando o Init
    * legado: "Select 1 as Selecionada, * from crTprMvCab into cursor
    * crOperacoes readwrite". par_cCursorOrigem eh o cursor JA POPULADO
    * pelo chamador (equivalente a crTprMvCab); par_cCursorDestino recebe
    * as mesmas colunas mais a coluna Selecionada, iniciada em 1 - o
    * legado marca TODAS as linhas como selecionadas por padrao (mesmo
    * valor inicial de ck_Marca.Value = 1).
    *====================================================================
    PROCEDURE CarregarOperacoes(par_cCursorOrigem, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOrigem) = "C" AND !EMPTY(par_cCursorOrigem) AND USED(par_cCursorOrigem) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino)

            TRY
                IF USED(par_cCursorDestino)
                    USE IN (par_cCursorDestino)
                ENDIF

                loc_cSQL = "SELECT 1 AS Selecionada, * FROM " + par_cCursorOrigem + ;
                    " INTO CURSOR " + par_cCursorDestino + " READWRITE"

                &loc_cSQL.

                IF USED(par_cCursorDestino)
                    SELECT (par_cCursorDestino)
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                        "vel montar o cursor de opera" + CHR(231) + CHR(245) + "es."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MarcarTodasOperacoes - Replica ck_Marca.Click do legado: marca ou
    * desmarca TODAS as linhas do cursor de operacoes de uma vez ("Replace
    * All Selecionada with This.Value in crOperacoes").
    *====================================================================
    PROCEDURE MarcarTodasOperacoes(par_cCursorOperacoes, par_nValor)
        LOCAL loc_lSucesso, loc_nRecno
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes)
            loc_nRecno = RECNO(par_cCursorOperacoes)

            SELECT (par_cCursorOperacoes)
            REPLACE ALL Selecionada WITH NVL(par_nValor, 0)

            IF BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursorOperacoes))
                GOTO loc_nRecno
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarCursorSelecionados - Replica o Scan do cmdSair.Click legado:
    * percorre o cursor de operacoes e grava, no cursor de saida (ja
    * criado pelo form chamador, equivalente a crFilOper), a chave
    * composta EmpDopNums de cada linha marcada (Selecionada == 1). O
    * cursor de saida eh ZERADO no inicio (Zap in crFilOper do legado) e
    * espera uma unica coluna EmpDopNums char(29).
    *====================================================================
    PROCEDURE MontarCursorSelecionados(par_cCursorOperacoes, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_nRecnoOrigem, loc_cChave, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(par_cCursorOperacoes) = "C" AND !EMPTY(par_cCursorOperacoes) AND USED(par_cCursorOperacoes) AND ;
           VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino) AND USED(par_cCursorDestino)

            TRY
                loc_nRecnoOrigem = RECNO(par_cCursorOperacoes)

                SELECT (par_cCursorDestino)
                ZAP

                SELECT (par_cCursorOperacoes)
                SCAN FOR NVL(Selecionada, 0) = 1
                    THIS.CarregarDoCursor(par_cCursorOperacoes)
                    loc_cChave = THIS.ObterChavePrimaria()

                    INSERT INTO (par_cCursorDestino) VALUES (loc_cChave)

                    SELECT (par_cCursorOperacoes)
                ENDSCAN

                IF USED(par_cCursorOperacoes) AND BETWEEN(loc_nRecnoOrigem, 1, RECCOUNT(par_cCursorOperacoes))
                    SELECT (par_cCursorOperacoes)
                    GOTO loc_nRecnoOrigem
                ENDIF

                loc_lSucesso = .T.
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                    "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

