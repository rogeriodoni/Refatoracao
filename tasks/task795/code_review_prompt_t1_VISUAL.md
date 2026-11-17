# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPRES.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (924 linhas total):

*-- Linhas 24 a 45:
24: * Correspondencia legado -> migrado (objetos; ver tasks\task795\mapeamento.json)
25: *   SIGOPRES                     -> FormSIGOPRES
26: *   SIGOPRES.cntSombra           -> cnt_4c_Sombra                   (Fase 3)
27: *   SIGOPRES.cntSombra.lblSombra -> cnt_4c_Sombra.lbl_4c_LblSombra  (Fase 3)
28: *   SIGOPRES.cntSombra.lblTitulo -> cnt_4c_Sombra.lbl_4c_LblTitulo  (Fase 3)
29: *   SIGOPRES.Shape1              -> shp_4c_Shape1                   (Fase 3)
30: *   SIGOPRES.Grid1               -> grd_4c_Dados                    (Fase 4 - feito)
31: *   SIGOPRES.Fwbtng1             -> cmd_4c_Fwbtng1                  (Fase 4 - feito)
32: *
33: * Correspondencia legado -> migrado (comportamento)
34: *   SIGOPRES.Load   (=fConfigGeral())   -> ja coberto pelo startup do sistema
35: *                                          novo (start\config.prg), que carrega
36: *                                          a configuracao geral uma unica vez.
37: *   SIGOPRES.Init   (Lparameters ocnx, __saldo)
38: *                   leitura do alias corrente + TprMvCab  -> THIS.Init() +
39: *                                          THIS.ConfigurarParametrosBO()
40: *                   as 3 consultas + a projecao dia a dia -> SIGOPRESBO.ExecutarCalculo()
41: *   SIGOPRES.Fwbtng1.Click (__saldo = thisform.nsaldo / Release)
42: *                                       -> THIS.BtnEncerrarClick()
43: *                                          + THIS.FecharDialogo()
44: *
45: * Eventos de botao (superficie COMPLETA desta tela)

*-- Linhas 201 a 221:
201:     * Monta a estrutura base da tela, na MESMA ordem de criacao do SCX legado
202:     * (cntSombra -> Shape1 -> Grid1 -> Fwbtng1). A ordem importa: objeto
203:     * criado depois desenha POR CIMA do criado antes, e o Shape1 do legado
204:     * invade a faixa do cabecalho (Top 7..117 contra faixa 0..80).
205:     *
206:     * A grade (grd_4c_Dados), o botao Encerrar (cmd_4c_Fwbtng1) e a chamada
207:     * de SIGOPRESBO.ExecutarCalculo() (THIS.CarregarDados) entram todos
208:     * aqui, na mesma ordem do Init legado: estrutura primeiro, calculo por
209:     * ultimo.
210:     *--------------------------------------------------------------------------
211:     PROTECTED PROCEDURE InicializarForm()
212:         LOCAL loc_lSucesso, loc_oErro
213: 
214:         loc_lSucesso = .F.
215: 
216:         TRY
217:             *-- Objeto de negocio (gerado nas fases de BO)
218:             THIS.this_oBusinessObject = CREATEOBJECT("SIGOPRESBO")
219: 
220:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
221:                 *-- Aparencia da janela (fundo, cor do texto, rolagem)

*-- Linhas 327 a 388:
327:     * AddObject e, com WordWrap = .T., chega a descartar a Height - o par
328:     * Width/Height transcrito do SCX ja eh o tamanho calculado pelo Designer.
329:     *
330:     * ForeColor branco eh legitimo aqui: o lbl_4c_LblTitulo fica dentro de
331:     * container OPACO escuro (BackStyle = 1 + BackColor RGB(100,100,100)).
332:     *--------------------------------------------------------------------------
333:     PROTECTED PROCEDURE ConfigurarCabecalho()
334:         THIS.AddObject("cnt_4c_Sombra", "Container")
335: 
336:         WITH THIS.cnt_4c_Sombra
337:             .Top           = 0
338:             .Left          = 0
339:             .Width         = THIS.Width
340:             .Height        = 80
341:             .BorderWidth   = 0
342:             .BackStyle     = 1
343:             .BackColor     = RGB(100, 100, 100)
344:             .SpecialEffect = 0
345:             .Visible       = .T.
346:         ENDWITH
347: 
348:         *-- Label de sombra (preto, 1px abaixo do titulo - efeito de relevo)
349:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
350: 
351:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
352:             .AutoSize      = .F.
353:             .FontName      = "Tahoma"
354:             .FontSize      = 18
355:             .FontBold      = .T.
356:             .FontUnderline = .F.
357:             .WordWrap      = .T.
358:             .Alignment     = 0
359:             .BackStyle     = 0
360:             .Caption       = THIS.Caption
361:             .Top           = 18
362:             .Left          = 10
363:             .Width         = THIS.Width - 20
364:             .Height        = 40
365:             .ForeColor     = RGB(0, 0, 0)
366:             .Rotation      = 0
367:             .Visible       = .T.
368:         ENDWITH
369: 
370:         *-- Label do titulo (branco sobre o cinza do container)
371:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
372: 
373:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
374:             .AutoSize    = .F.
375:             .FontName    = "Tahoma"
376:             .FontSize    = 18
377:             .FontBold    = .T.
378:             .WordWrap    = .T.
379:             .Alignment   = 0
380:             .BackStyle   = 0
381:             .Caption     = THIS.Caption
382:             .Top         = 17
383:             .Left        = 10
384:             .Width       = THIS.Width - 20
385:             .Height      = 46
386:             .ForeColor   = RGB(255, 255, 255)
387:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
388:             .Rotation    = 0

*-- Linhas 411 a 420:
411:         THIS.AddObject("shp_4c_Shape1", "Shape")
412: 
413:         WITH THIS.shp_4c_Shape1
414:             .Top         = 7
415:             .Left        = 374
416:             .Height      = 110
417:             .Width       = 90
418:             .BackStyle   = 0
419:             .BorderStyle = 0
420:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 442 a 478:
442:     * NIVEL DO GRID). ColumnCount/RecordSource/ControlSource/Width/
443:     * Header1.Caption ficam em THIS.MontaGrade(), que e chamado tanto aqui
444:     * (com o cursor placeholder, estrutura IDENTICA ao cursor real - regra
445:     * do CLAUDE.md) quanto depois de THIS.this_oBusinessObject.
446:     * ExecutarCalculo() em CarregarDados() - esse metodo do BO fecha e
447:     * recria cursor_4c_Dados (Select ... Into Cursor), o que zera o
448:     * ColumnCount da grade (mesmo efeito do SQLEXEC sobre alias ligado a
449:     * Grid - CLAUDE.md, Erro179), entao o remonte tem de poder ser repetido
450:     * a qualquer momento (padrao ConfigurarGrid/MontaGrade de
451:     * FormSigOpMop.prg e FormSigOpPrL.prg).
452:     *--------------------------------------------------------------------------
453:     PROTECTED PROCEDURE ConfigurarGrid()
454:         IF USED("cursor_4c_Dados")
455:             USE IN cursor_4c_Dados
456:         ENDIF
457: 
458:         CREATE CURSOR cursor_4c_Dados (datas D, estoque N(11,3))
459:         INDEX ON datas TAG datas
460: 
461:         THIS.AddObject("grd_4c_Dados", "Grid")
462: 
463:         WITH THIS.grd_4c_Dados
464:             .Top               = 99
465:             .Left              = 124
466:             .Width             = 221
467:             .Height            = 200
468:             .FontName          = "Tahoma"
469:             .FontSize          = 8
470:             .AllowHeaderSizing = .F.
471:             .AllowRowSizing    = .F.
472:             .DeleteMark        = .F.
473:             .RecordMark        = .F.
474:             .RowHeight         = 16
475:             *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
476:             *-- READ-ONLY em runtime: medido no VFP9 (2026-11-16,
477:             *-- automation\tmp795\medir_splitbar.prg) a atribuicao estoura
478:             *-- "Property SPLITBAR is read-only." para QUALQUER valor,

*-- Linhas 498 a 518:
498: 
499:         RETURN
500:     ENDPROC
501: 
502:     *--------------------------------------------------------------------------
503:     * MontaGrade - (re)liga grd_4c_Dados a cursor_4c_Dados.
504:     *
505:     * Legado: thisform.grid1.RecordSource = [TmpResul]
506:     *         thisform.grid1.column1.ControlSource = [TmpResul.datas]
507:     *         thisform.grid1.column2.ControlSource = [TmpResul.estoque]
508:     *
509:     *   Column1  Width=80 Movable=.F. Resizable=.F. ReadOnly=.T.
510:     *            BackColor=255,255,255
511:     *     Header1  Alignment=2 Caption="Data"
512:     *     Text1    BorderStyle=0 Margin=0 ReadOnly=.T. ForeColor=0,0,0
513:     *              BackColor=255,255,255
514:     *   Column2  Width=90  (ReadOnly NAO declarado no dump - fica editavel,
515:     *            exatamente como no legado; nao inventar trava que ele nao
516:     *            tem - regra de transcricao literal)
517:     *     Header1  Alignment=2 Caption="Estoque"
518:     *     Text1    BorderStyle=0 Margin=0 ForeColor=0,0,0

*-- Linhas 539 a 583:
539:     * found." - VFP9 nao aceita argumento extra em metodo sem LPARAMETERS. As
540:     * chamadas internas (THIS.MontaGrade()) seguem sem argumento. Mesmo
541:     * padrao de FormSigOpMop.MontaGrade.
542:     *--------------------------------------------------------------------------
543:     PROCEDURE MontaGrade(par_cParamTeste)
544:         WITH THIS.grd_4c_Dados
545:             .ColumnCount  = 2
546:             .RecordSource = "cursor_4c_Dados"
547: 
548:             .Column1.ControlSource     = "cursor_4c_Dados.datas"
549:             .Column1.Width             = 80
550:             .Column1.Movable           = .F.
551:             .Column1.Resizable         = .F.
552:             .Column1.ReadOnly          = .T.
553:             .Column1.BackColor         = RGB(255, 255, 255)
554:             .Column1.FontName          = "Tahoma"
555:             .Column1.FontSize          = 8
556:             .Column1.Header1.Caption   = "Data"
557:             .Column1.Header1.Alignment = 2
558:             .Column1.Header1.FontName  = "Tahoma"
559:             .Column1.Header1.FontSize  = 8
560:             .Column1.Text1.BorderStyle = 0
561:             .Column1.Text1.Margin      = 0
562:             .Column1.Text1.ReadOnly    = .T.
563:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
564:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
565:             .Column1.Text1.FontName    = "Tahoma"
566:             .Column1.Text1.FontSize    = 8
567: 
568:             .Column2.ControlSource     = "cursor_4c_Dados.estoque"
569:             .Column2.Width             = 90
570:             .Column2.FontName          = "Tahoma"
571:             .Column2.FontSize          = 8
572:             .Column2.Header1.Caption   = "Estoque"
573:             .Column2.Header1.Alignment = 2
574:             .Column2.Header1.FontName  = "Tahoma"
575:             .Column2.Header1.FontSize  = 8
576:             .Column2.Text1.BorderStyle = 0
577:             .Column2.Text1.Margin      = 0
578:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
579:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
580:             .Column2.Text1.FontName    = "Tahoma"
581:             .Column2.Text1.FontSize    = 8
582:         ENDWITH
583: 

*-- Linhas 595 a 623:
595:     * framework.vcx, que nao da para ler diretamente (regra #31 do
596:     * CLAUDE.md: p-code de VCX). Usa-se 75x75, o tamanho canonico do
597:     * projeto para botao de icone com Caption (framework_frmcadastro_
598:     * layout.md, cmd_4c_Encerrar) - e 395 + 75 = 470 fecha EXATO contra o
599:     * Width do form (470), o que confirma a medida.
600:     *
601:     * Themes = .F. + FontName "Comic Sans MS"/ForeColor RGB(90,90,90) sao as
602:     * propriedades COMUNS a todos os botoes deste framework (mesmo
603:     * documento). Como este botao nunca eh desabilitado (eh a UNICA saida
604:     * do dialogo - TitleBar=0, ControlBox=.F.), a excecao de Themes=.T. para
605:     * botao com Picture + Caption (CorretorAutomatico #99) nao se aplica
606:     * aqui.
607:     *
608:     * Cancel = .T. faz ESC disparar o Click, igual ao legado.
609:     *--------------------------------------------------------------------------
610:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
611:         THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")
612: 
613:         WITH THIS.cmd_4c_Fwbtng1
614:             .Top             = 3
615:             .Left            = 395
616:             .Width           = 75
617:             .Height          = 75
618:             .Caption         = "Encerrar"
619:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
620:             .Cancel          = .T.
621:             .FontName        = "Comic Sans MS"
622:             .FontBold        = .T.
623:             .FontItalic      = .T.

*-- Linhas 633 a 641:
633:             .Visible         = .T.
634:         ENDWITH
635: 
636:         BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "BtnEncerrarClick")
637: 
638:         RETURN
639:     ENDPROC
640: 
641:     *--------------------------------------------------------------------------

*-- Linhas 717 a 737:
717:     *
718:     * Legado: bloco final do Init - calcula TmpResul e faz
719:     *         thisform.nsaldo = TmpResul.estoque antes de ligar o Grid.
720:     *
721:     * THIS.this_oBusinessObject.ExecutarCalculo() fecha e recria
722:     * cursor_4c_Dados (ver CalcularEstoquePorDia no BO), o que derruba o
723:     * bind da grade (zera ColumnCount - mesma causa do Erro179). Por isso
724:     * MontaGrade() e chamado de novo aqui, sempre, mesmo quando o calculo
725:     * falha - a grade tem de voltar a mostrar, no minimo, o cursor vazio
726:     * com cabecalho certo, nunca "Column1"/"Column2" genericos.
727:     *--------------------------------------------------------------------------
728:     PROCEDURE CarregarDados()
729:         LOCAL loc_lSucesso
730: 
731:         loc_lSucesso = .F.
732: 
733:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
734:             loc_lSucesso = THIS.this_oBusinessObject.ExecutarCalculo()
735: 
736:             THIS.this_nSaldo     = IIF(loc_lSucesso, ;
737:                                        THIS.this_oBusinessObject.this_nSaldo, ;

*-- Linhas 772 a 797:
772:             *-- dar o GO TOP para o legado ser reproduzido.
773:             *
774:             *-- O GO TOP continua valendo no caminho de FALHA: ai nao houve
775:             *-- SEEK, o cursor eh o placeholder vazio (ou ficou em EOF) e a
776:             *-- grade precisa de um ponteiro valido para pintar (regra #21a).
777:             IF !loc_lSucesso AND USED("cursor_4c_Dados")
778:                 SELECT cursor_4c_Dados
779:                 GO TOP
780:             ENDIF
781: 
782:             THIS.grd_4c_Dados.Refresh()
783:         ENDIF
784: 
785:         RETURN loc_lSucesso
786:     ENDPROC
787: 
788:     *--------------------------------------------------------------------------
789:     * ConfigurarParametrosBO - Repassa ao BO o que o chamador informou.
790:     *
791:     * Legado (bloco de abertura do Init):
792:     *   lcAlias   = Upper(Alias())
793:     *   lcproduto = &lcAlias..CPros
794:     *   lcoper    = TprMvCab.dopes
795:     *   dtini     = Dtot(Date())
796:     *   dtfin     = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents), ;
797:     *                   TprMvCab.datas, TprMvCab.prazoents)

*-- Linhas 881 a 917:
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * Destroy - Fecha os cursores de trabalho da projecao e libera o BO.
885:     *
886:     * Os cursores sao os declarados pelo BO (cursor_4c_Dados, _Reservas,
887:     * _Locacoes, _OperacaoPai, _Datas). O cursor do CHAMADOR (cabecalho e
888:     * item) NAO eh fechado aqui - ele nao pertence a esta tela.
889:     *
890:     * TABLEREVERT exige buffering: sem buffering ele nao eh inofensivo, dispara
891:     * o erro 1586. Por isso vem sob o teste de CURSORGETPROP("Buffering") > 1
892:     * (USE IN fecha o alias mesmo com buffer sujo, entao o TABLEREVERT so
893:     * existe para o caso em que o buffer de fato tenha algo a descartar).
894:     *
895:     * DODEFAULT() eh a ULTIMA linha: eh FormBase.Destroy que libera o BO e
896:     * restaura os popups do menu principal depois de um form modal.
897:     *--------------------------------------------------------------------------
898:     PROCEDURE Destroy()
899:         LOCAL loc_nI, loc_cCursor
900:         LOCAL ARRAY loc_aCursores[5]
901: 
902:         loc_aCursores[1] = "cursor_4c_Dados"
903:         loc_aCursores[2] = "cursor_4c_Reservas"
904:         loc_aCursores[3] = "cursor_4c_Locacoes"
905:         loc_aCursores[4] = "cursor_4c_OperacaoPai"
906:         loc_aCursores[5] = "cursor_4c_Datas"
907: 
908:         FOR loc_nI = 1 TO ALEN(loc_aCursores)
909:             loc_cCursor = loc_aCursores[loc_nI]
910: 
911:             IF USED(loc_cCursor)
912:                 IF CURSORGETPROP("Buffering", loc_cCursor) > 1
913:                     TABLEREVERT(.T., loc_cCursor)
914:                 ENDIF
915:                 USE IN (loc_cCursor)
916:             ENDIF
917:         ENDFOR


### BO (C:\4c\projeto\app\classes\SIGOPRESBO.prg):
*============================================================================
* SIGOPRESBO.prg - Business Object para Estoque Estimado por Dia
*
* Legado  : SIGOPRES.SCX (form OPERACIONAL, modal, WindowType = 1)
* Operacao: dialogo de CONSULTA aberto a partir de uma operacao de venda /
*           locacao. Projeta, dia a dia, o estoque estimado de UM produto
*           dentro da janela que vai de hoje ate o prazo de entrega da
*           operacao, somando o que entra e subtraindo o que sai por conta
*           das reservas (operacao corrente e irmas) e das locacoes
*           (operacao PAI, SigCdOpe.copers = 1).
*
* Tabelas lidas (SOMENTE leitura - o legado nao grava em tabela nenhuma:
* cada Insert Into / Replace do SCX tem por destino um cursor LOCAL):
*   SigMvItn (a) PK cidchaves char(20) - itens de movimento: cpros char(14),
*                 dopes char(20), qtds numeric(9,3), qtbaixas numeric(9,3),
*                 empdopnums char(29)
*   SigMvCab (b) PK cidchaves char(20) - cabecalho: empdopnums char(29),
*                 datas datetime, prazoents datetime, dopes char(20),
*                 chksubn bit
*   SigCdOpe     PK dopes char(20)     - operacoes: nivels char(20),
*                 copers numeric(1,0)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*
* Mapeamento legado -> migrado (a logica entra na Fase 2):
*   Init / 1a query  (TmpReser) -> THIS.CarregarReservas()
*   Init / 2a query  (TmpOpe)   -> THIS.CarregarOperacaoPai()
*   Init / 3a query  (TmpLoca)  -> THIS.CarregarLocacoes()
*   Init / Create Cursor Tmpresul + os dois SCAN + o laco dos dias sem
*          movimentacao + o Select final por faixa de data
*                              -> THIS.CalcularEstoquePorDia()
*   Init / Seek(Ttod(TprMvCab.datas)) + thisform.nsaldo = TmpResul.estoque
*                              -> THIS.ObterSaldoNaData()
*
* O SCX NAO tem INSERT/UPDATE/DELETE remoto, por isso este BO mantem o
* comportamento herdado de BusinessBase para Inserir()/Atualizar()/
* ExecutarExclusao(), que ja eh o correto para uma tela de consulta.
*============================================================================

DEFINE CLASS SIGOPRESBO AS BusinessBase

    *==========================================================================
    * Entrada recebida do form chamador
    *
    * O Init legado le o produto da area de trabalho corrente
    * (lcAlias = Upper(Alias()) seguido de lcproduto = <alias>.CPros) e os
    * dados do cabecalho do cursor TprMvCab do chamador (datas, prazoents,
    * dopes, empdopnums). Na arquitetura nova esses valores chegam por
    * parametro e ficam guardados aqui.
    *==========================================================================
    this_cProduto      = ""    && char(14) SigMvItn.cpros      - produto consultado (CPros do item corrente)
    this_cOperacao     = ""    && char(20) SigMvCab.dopes      - operacao da venda/locacao (TprMvCab.dopes)
    this_cEmpDopNums   = ""    && char(29) SigMvCab.empdopnums - chave da operacao CORRENTE (TprMvCab.empdopnums)
    this_nSaldoInicial = 0     && numeric(11,3) - saldo de estoque recebido do chamador (parametro __saldo do legado)

    *==========================================================================
    * Janela de datas da projecao
    *
    * Legado: dtini = Dtot(Date())
    *         dtfin = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *                     TprMvCab.datas, TprMvCab.prazoents)
    *         dtfin = fDtoSQL(dtfin, 23:59:59)
    *
    * Guardadas como DATE (regra #16 do CLAUDE.md - o mesmo campo chega ora
    * DATE ora DATETIME conforme o caminho, por isso a normalizacao eh feita
    * com ConverterParaData e o limite de hora 23:59:59 do dtfin eh aplicado
    * somente na montagem da query).
    *==========================================================================
    this_dDataMovimento = {}   && SigMvCab.datas      - data da operacao (TprMvCab.datas)
    this_dPrazoEntrega  = {}   && SigMvCab.prazoents  - prazo de entrega da operacao (TprMvCab.prazoents)
    this_dDataInicial   = {}   && dtini do legado - DATE() na abertura da tela
    this_dDataFinal     = {}   && dtfin do legado - prazoents quando preenchido, senao datas

    *==========================================================================
    * Operacao PAI (locacoes)
    *
    * Legado: select dopes from SigCdOpe where nivels = <operacao> and copers = 1
    *         lcoper = tmpOpe.dopes
    * A MESMA query das reservas eh reexecutada com essa operacao para montar
    * TmpLoca. Quando SigCdOpe nao devolve linha, o legado le tmpOpe.dopes em
    * EOF e recebe BRANCOS: a consulta das locacoes fica sem resultado, que eh
    * o comportamento reproduzido na Fase 2 a partir destas duas properties.
    *==========================================================================
    this_cOperacaoPai      = ""   && char(20) SigCdOpe.dopes - operacao pai (nivels = this_cOperacao e copers = 1)
    this_lAchouOperacaoPai = .F.  && .T. quando SigCdOpe devolveu a operacao pai

    *==========================================================================
    * Resultado devolvido ao chamador
    *
    * Legado: thisform.nsaldo (property custom do form, RESERVED3 do SCX) eh
    * carregado com TmpResul.estoque da data da operacao e devolvido no Click
    * do botao Encerrar (__saldo = thisform.nsaldo).
    *==========================================================================
    this_nSaldo = 0            && numeric(11,3) - estoque estimado na data da operacao (nsaldo do legado)

    *==========================================================================
    * Cursores de trabalho (PILAR 3 - nomes novos, cursor_4c_*)
    *
    *   TmpReser -> this_cCursorReservas      (itens reservados na janela)
    *   TmpOpe   -> this_cCursorOperacaoPai   (operacao pai vinda de SigCdOpe)
    *   TmpLoca  -> this_cCursorLocacoes      (itens locados na janela)
    *   Tmpresul -> this_cCursorDados         (projecao dia a dia - grade)
    *   Tmpdata  -> this_cCursorDatas         (auxiliar dos Select Max/Min)
    *
    * this_cCursorDados eh o cursor ligado ao Grid; os demais sao
    * intermediarios. Na Fase 2 todo SQLEXEC vai para cursor TEMPORARIO
    * proprio, para nunca derrubar o alias da grade.
    *==========================================================================
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorReservas    = "cursor_4c_Reservas"
    this_cCursorLocacoes    = "cursor_4c_Locacoes"
    this_cCursorOperacaoPai = "cursor_4c_OperacaoPai"
    this_cCursorDatas       = "cursor_4c_Datas"

    *==========================================================================
    * Estado da carga
    *==========================================================================
    this_lDadosCarregados = .F.  && .T. depois que a projecao dia a dia foi montada
    this_nTotalDias       = 0    && quantidade de linhas da projecao (RECCOUNT do cursor da grade)

    *==========================================================================
    * Init - Configura tabela e chave primaria do BO
    *
    * A entidade lida eh SigMvItn (tabela "a" do JOIN que alimenta tanto as
    * reservas quanto as locacoes), cuja chave primaria eh cidchaves char(20).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"

            *-- A janela de datas comeca sempre em DATE(), como o dtini do legado
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarCalculo - Funil unico que reproduz o Init legado por completo.
    *
    * Chamado pelo Form (FormSIGOPRES) depois de preencher os parametros
    * recebidos do chamador (this_cProduto/this_cOperacao/this_cEmpDopNums/
    * this_nSaldoInicial/this_dDataMovimento/this_dPrazoEntrega). Repete, na
    * mesma ordem do Init do SCX, as 3 consultas remotas + a projecao dia a
    * dia + o saldo na data da operacao.
    *
    * PUBLIC - regra #51 do CLAUDE.md (metodo chamado de fora do BO nunca
    * pode ser PROTECTED em nenhum nivel da heranca).
    *==========================================================================
    FUNCTION ExecutarCalculo()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF THIS.CarregarReservas() AND THIS.CarregarOperacaoPai()
            IF THIS.CarregarLocacoes() AND THIS.CalcularEstoquePorDia()
                loc_lResultado = THIS.ObterSaldoNaData()
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarReservas - 1a query do Init legado (TmpReser)
    *
    * Legado:
    *   lcoper = TprMvCab.dopes
    *   lcquery = [select b.empdopnums, b.datas, b.prazoents, a.qtds,
    *              a.qtbaixas, 000000.000 as qtdests from SigMvItn a
    *              inner join SigMvCab b on a.empdopnums = b.empdopnums
    *              where cpros = ?lcproduto and a.dopes = ?lcoper and
    *              (b.datas between ?dtini and ?dtfin or
    *               b.prazoents >= ?dtini) and b.chksubn = 0
    *              order by b.datas, b.prazoents]
    *   ocnx.sqlexecute(lcquery,[TmpReser])
    *==========================================================================
    PROTECTED FUNCTION CarregarReservas()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarQueryMovimento(THIS.this_cOperacao)

            IF USED(THIS.this_cCursorReservas)
                USE IN (THIS.this_cCursorReservas)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorReservas)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar reservas: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarOperacaoPai - 2a query do Init legado (TmpOpe)
    *
    * Legado:
    *   lcquery2 = [select dopes from SigCdOpe where nivels = '] + lcoper +
    *              [' and copers = 1]
    *   ocnx.sqlexecute(lcquery2,[TmpOpe])
    *   lcoper = tmpOpe.dopes
    *
    * Quando SigCdOpe NAO devolve linha (a operacao nao tem pai de locacao),
    * o legado le tmpOpe.dopes com o cursor em EOF e recebe BRANCOS - lcoper
    * fica vazio e a consulta seguinte (TmpLoca) nao casa com registro nenhum,
    * porque dopes char(20) nunca eh branco num movimento real. Ou seja: sem
    * operacao pai, nao ha locacao a descontar.
    *
    * Por isso this_cOperacaoPai recebe "" nesse caso, e NAO this_cOperacao:
    * repetir a operacao original faria a consulta das locacoes devolver
    * exatamente as mesmas linhas das reservas, e cada movimento seria
    * aplicado DUAS vezes sobre a projecao - numero errado, sem erro na tela
    * (regra #17 do CLAUDE.md: a formula/consulta do legado se transcreve,
    * nao se reinventa).
    *==========================================================================
    PROTECTED FUNCTION CarregarOperacaoPai()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe " + ;
                       "WHERE nivels = " + EscaparSQL(THIS.this_cOperacao) + " " + ;
                       "AND copers = 1"

            IF USED(THIS.this_cCursorOperacaoPai)
                USE IN (THIS.this_cCursorOperacaoPai)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacaoPai)

            IF loc_nResultado >= 0
                IF RECCOUNT(THIS.this_cCursorOperacaoPai) > 0
                    SELECT (THIS.this_cCursorOperacaoPai)
                    GO TOP
                    THIS.this_cOperacaoPai      = TratarNulo(dopes, "")
                    THIS.this_lAchouOperacaoPai = .T.
                ELSE
                    *-- Legado: lcoper = tmpOpe.dopes com TmpOpe vazio = BRANCOS
                    THIS.this_cOperacaoPai      = ""
                    THIS.this_lAchouOperacaoPai = .F.
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(227) + "o pai: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarLocacoes - 3a query do Init legado (TmpLoca)
    *
    * Legado: ocnx.sqlexecute(lcquery,[TmpLoca]) - a MESMA lcquery da 1a
    * consulta, reexecutada com lcoper agora valendo this_cOperacaoPai.
    *==========================================================================
    PROTECTED FUNCTION CarregarLocacoes()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarQueryMovimento(THIS.this_cOperacaoPai)

            IF USED(THIS.this_cCursorLocacoes)
                USE IN (THIS.this_cCursorLocacoes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLocacoes)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar loca" + CHR(231) + CHR(245) + "es: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * MontarQueryMovimento - texto da lcquery do legado, parametrizado pela
    * operacao (this_cOperacao para reservas, this_cOperacaoPai para
    * locacoes - regra #42 do CLAUDE.md: montagem de chave/filtro eh
    * transcrita, nao reinventada).
    *
    * dtfin ganha hora 23:59:59 (fDtoSQL(dtfin,'23:59:59') do legado) porque
    * b.datas/b.prazoents sao DATETIME no SQL Server - sem a hora, o filtro
    * perderia os registros do ultimo dia da janela que tem hora != 00:00:00.
    *==========================================================================
    PROTECTED FUNCTION MontarQueryMovimento(par_cOperacao)
        LOCAL loc_cSQL, loc_cDtIni, loc_cDtFin

        loc_cDtIni = FormatarDataSQL(THIS.this_dDataInicial)

        loc_cDtFin = FormatarDataSQL(THIS.this_dDataFinal)
        loc_cDtFin = LEFT(loc_cDtFin, LEN(loc_cDtFin) - 1) + " 23:59:59'"

        loc_cSQL = "SELECT b.empdopnums, b.datas, b.prazoents, a.qtds, a.qtbaixas, " + ;
                   "0.000 AS qtdests " + ;
                   "FROM SigMvItn a " + ;
                   "INNER JOIN SigMvCab b ON a.empdopnums = b.empdopnums " + ;
                   "WHERE a.cpros = " + EscaparSQL(THIS.this_cProduto) + " " + ;
                   "AND a.dopes = " + EscaparSQL(par_cOperacao) + " " + ;
                   "AND (b.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + " " + ;
                   "OR b.prazoents >= " + loc_cDtIni + ") " + ;
                   "AND b.chksubn = 0 " + ;
                   "ORDER BY b.datas, b.prazoents"

        RETURN loc_cSQL
    ENDFUNC

    *==========================================================================
    * CalcularEstoquePorDia - Create Cursor Tmpresul + os dois SCAN
    * (TmpReser/TmpLoca) + o laco dos dias sem movimentacao + o Select final
    * por faixa de data, todos do Init legado.
    *==========================================================================
    PROTECTED FUNCTION CalcularEstoquePorDia()
        LOCAL loc_lResultado, loc_dIni, loc_dFim
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorDados) (datas D, estoque N(11,3))
            INDEX ON datas TAG datas

            *-- Legado: Insert into Tmpresul(datas,estoque) values (Date(), __saldo)
            INSERT INTO (THIS.this_cCursorDados) (datas, estoque) ;
                VALUES (DATE(), THIS.this_nSaldoInicial)

            *-- Legado: Select TmpReser / Scan ... EndScan
            *
            *   O SELECT de volta DENTRO do laco eh obrigatorio: INSERT INTO e
            *   os Select ... INTO CURSOR dos helpers de saldo trocam a area de
            *   trabalho corrente, e o ENDSCAN precisa do cursor de origem
            *   selecionado para avancar o ponteiro.
            IF USED(THIS.this_cCursorReservas)
                SELECT (THIS.this_cCursorReservas)
                SCAN
                    THIS.AplicarMovimentoReserva(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorReservas)
                ENDSCAN
            ENDIF

            *-- Legado: Select TmpLoca / Scan ... EndScan
            IF USED(THIS.this_cCursorLocacoes)
                SELECT (THIS.this_cCursorLocacoes)
                SCAN
                    THIS.AplicarMovimentoLocacao(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorLocacoes)
                ENDSCAN
            ENDIF

            *-- Legado: insere estoque nos dias que nao tiveram movimentacao
            THIS.PreencherDiasSemMovimento(THIS.this_cCursorDados)

            *-- Legado: Select * from Tmpresul where datas between dtini and
            *-- dtfin into cursor Tmpresul order by datas (aqui num cursor
            *-- temporario, para depois substituir o cursor_4c_Dados)
            loc_dIni = THIS.this_dDataInicial
            loc_dFim = THIS.this_dDataFinal

            SELECT * FROM (THIS.this_cCursorDados) ;
                WHERE datas >= m.loc_dIni AND datas <= m.loc_dFim ;
                ORDER BY datas ;
                INTO CURSOR cursor_4c_EstoqueFiltrado READWRITE

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            SELECT * FROM cursor_4c_EstoqueFiltrado INTO CURSOR (THIS.this_cCursorDados) READWRITE

            IF USED("cursor_4c_EstoqueFiltrado")
                USE IN cursor_4c_EstoqueFiltrado
            ENDIF

            SELECT (THIS.this_cCursorDados)
            INDEX ON datas TAG datas
            GO TOP

            THIS.this_lDadosCarregados = .T.
            THIS.this_nTotalDias       = RECCOUNT(THIS.this_cCursorDados)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AplicarMovimentoReserva - um "passo" do Scan TmpReser do legado,
    * aplicado ao registro CORRENTE de this_cCursorReservas.
    *
    * Legado (datas - inicio da reserva):
    *   =Seek(Ttod(Tmpreser.datas),'TmpResul','datas')
    *   If !Eof('TmpResul')
    *       If TprMvCab.empdopnums = tmpreser.empdopnums
    *           replace estoque with estoque + (qtds-qtbaixas) for datas >= ... in TmpResul
    *       Else
    *           replace estoque with estoque - (qtds-qtbaixas) for datas >= ... in TmpResul
    *       EndIf
    *   Else
    *       dmax = Max(Ttod(dtini),TmpReser.datas)
    *       <saldo ate dmax> ...
    *       Insert ... values (data, saldo +/- qtde)
    *   EndIf
    *
    * Legado (prazoents - fim da reserva, sempre DEVOLVE a quantidade):
    *   =Seek(Ttod(TmpReser.prazoents),'TmpResul','datas')
    *   If !Eof('TmpResul')
    *       replace estoque with estoque + (qtds-qtbaixas) for datas >= ... in TmpResul
    *   Else
    *       <saldo no intervalo [datas, prazoents]> ...
    *       Insert ... values (prazoents, saldo + qtde)
    *   EndIf
    *==========================================================================
    PROTECTED PROCEDURE AplicarMovimentoReserva(par_cCursorResultado)
        LOCAL loc_dDataInicioMov, loc_dDataFimMov, loc_nQtdeLiquida, loc_lMesmaOperacao
        LOCAL loc_dMax, loc_nSaldo

        loc_dDataInicioMov = ConverterParaData(datas)
        loc_dDataFimMov    = ConverterParaData(prazoents)
        loc_nQtdeLiquida   = qtds - qtbaixas
        loc_lMesmaOperacao = (THIS.this_cEmpDopNums = empdopnums)

        *-- 1) Movimento na data de inicio da reserva
        IF SEEK(loc_dDataInicioMov, par_cCursorResultado, "datas")
            IF loc_lMesmaOperacao
                REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                    FOR datas >= loc_dDataInicioMov IN (par_cCursorResultado)
            ELSE
                REPLACE estoque WITH estoque - loc_nQtdeLiquida ;
                    FOR datas >= loc_dDataInicioMov IN (par_cCursorResultado)
            ENDIF
        ELSE
            loc_dMax   = MAX(THIS.this_dDataInicial, loc_dDataInicioMov)
            loc_nSaldo = THIS.ObterSaldoAteData(par_cCursorResultado, loc_dMax)
            IF loc_lMesmaOperacao
                INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                    VALUES (loc_dDataInicioMov, loc_nSaldo + loc_nQtdeLiquida)
            ELSE
                INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                    VALUES (loc_dDataInicioMov, loc_nSaldo - loc_nQtdeLiquida)
            ENDIF
        ENDIF

        *-- 2) Movimento na data do prazo de entrega da reserva (devolve a quantidade)
        IF SEEK(loc_dDataFimMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                FOR datas >= loc_dDataFimMov IN (par_cCursorResultado)
        ELSE
            loc_nSaldo = THIS.ObterSaldoNoIntervalo(par_cCursorResultado, loc_dDataInicioMov, loc_dDataFimMov)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataFimMov, loc_nSaldo + loc_nQtdeLiquida)
        ENDIF
    ENDPROC

    *==========================================================================
    * AplicarMovimentoLocacao - um "passo" do Scan TmpLoca do legado,
    * aplicado ao registro CORRENTE de this_cCursorLocacoes.
    *
    * Diferenca em relacao a reserva: na data de INICIO da locacao, a
    * retirada de estoque so vale ATE dtini (for datas >= ... and
    * datas < dtini) - a partir de hoje quem manda eh a janela calculada,
    * nao mais o item locado.
    *==========================================================================
    PROTECTED PROCEDURE AplicarMovimentoLocacao(par_cCursorResultado)
        LOCAL loc_dDataInicioMov, loc_dDataFimMov, loc_nQtdeLiquida
        LOCAL loc_dMax, loc_nSaldo

        loc_dDataInicioMov = ConverterParaData(datas)
        loc_dDataFimMov    = ConverterParaData(prazoents)
        loc_nQtdeLiquida   = qtds - qtbaixas

        *-- 1) Retirada do estoque na data da locacao, limitada ao inicio da janela
        IF SEEK(loc_dDataInicioMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque - loc_nQtdeLiquida ;
                FOR datas >= loc_dDataInicioMov AND datas < THIS.this_dDataInicial ;
                IN (par_cCursorResultado)
        ELSE
            loc_dMax   = MAX(THIS.this_dDataInicial, loc_dDataInicioMov)
            loc_nSaldo = THIS.ObterSaldoAteData(par_cCursorResultado, loc_dMax)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataInicioMov, loc_nSaldo - loc_nQtdeLiquida)
        ENDIF

        *-- 2) Devolucao do estoque na data do prazo de entrega da locacao
        IF SEEK(loc_dDataFimMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                FOR datas >= loc_dDataFimMov IN (par_cCursorResultado)
        ELSE
            loc_nSaldo = THIS.ObterSaldoNoIntervalo(par_cCursorResultado, loc_dDataInicioMov, loc_dDataFimMov)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataFimMov, loc_nSaldo + loc_nQtdeLiquida)
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterSaldoAteData - "Select Max(datas) ... where datas <= dmax" do
    * legado, seguido do Seek + leitura do estoque (ou __saldo se nao achar).
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoAteData(par_cCursorResultado, par_dDataLimite)
        LOCAL loc_nSaldo, loc_dDataMax

        loc_nSaldo = THIS.this_nSaldoInicial

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MAX(datas) AS datas FROM (par_cCursorResultado) ;
            WHERE datas <= m.par_dDataLimite ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dDataMax = datas

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        IF !ISNULL(loc_dDataMax)
            IF SEEK(loc_dDataMax, par_cCursorResultado, "datas")
                SELECT (par_cCursorResultado)
                IF !EOF(par_cCursorResultado)
                    loc_nSaldo = estoque
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_nSaldo
    ENDFUNC

    *==========================================================================
    * ObterSaldoNoIntervalo - "Select Max(datas) ... where datas between X
    * and Y" do legado (usado no lado "prazoents" das reservas/locacoes),
    * seguido do Seek + leitura do estoque (ou __saldo se nao achar).
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoNoIntervalo(par_cCursorResultado, par_dDataIni, par_dDataFim)
        LOCAL loc_nSaldo, loc_dDataMax

        loc_nSaldo = THIS.this_nSaldoInicial

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MAX(datas) AS datas FROM (par_cCursorResultado) ;
            WHERE datas >= m.par_dDataIni AND datas <= m.par_dDataFim ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dDataMax = datas

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        IF !ISNULL(loc_dDataMax)
            IF SEEK(loc_dDataMax, par_cCursorResultado, "datas")
                SELECT (par_cCursorResultado)
                IF !EOF(par_cCursorResultado)
                    loc_nSaldo = estoque
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_nSaldo
    ENDFUNC

    *==========================================================================
    * PreencherDiasSemMovimento - "Insere estoque nos dias que nao tiveram
    * movimentacao" do legado.
    *
    * Legado:
    *   Select Min(datas) as dtini, Max(datas) as dtfin from TmpResul into cursor TmpData
    *   nsaldoant = __saldo
    *   If Reccount('TmpResul') > 0
    *       For x = 0 to (TmpData.dtfin - TmpData.dtini)
    *           =Seek(TmpData.dtini+x,'Tmpresul','datas')
    *           If !Eof('Tmpresul')
    *               nsaldoant = Tmpresul.estoque
    *           Else
    *               Insert into Tmpresul(datas,estoque) values (TmpData.dtini+x, nsaldoant)
    *           EndIf
    *       Next
    *   Else
    *       Insert into Tmpresul(datas,estoque) values (Ttod(TprMvCab.datas), nsaldoant)
    *   EndIf
    *==========================================================================
    PROTECTED PROCEDURE PreencherDiasSemMovimento(par_cCursorResultado)
        LOCAL loc_dMin, loc_dMax, loc_nSaldoAnterior, loc_nX

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MIN(datas) AS dtini, MAX(datas) AS dtfin FROM (par_cCursorResultado) ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dMin = dtini
        loc_dMax = dtfin

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        loc_nSaldoAnterior = THIS.this_nSaldoInicial

        IF RECCOUNT(par_cCursorResultado) > 0
            FOR loc_nX = 0 TO (loc_dMax - loc_dMin)
                IF SEEK(loc_dMin + loc_nX, par_cCursorResultado, "datas")
                    SELECT (par_cCursorResultado)
                    loc_nSaldoAnterior = estoque
                ELSE
                    INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                        VALUES (loc_dMin + loc_nX, loc_nSaldoAnterior)
                ENDIF
            ENDFOR
        ELSE
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (ConverterParaData(THIS.this_dDataMovimento), loc_nSaldoAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterSaldoNaData - localiza o saldo projetado na data da operacao e
    * devolve em this_nSaldo (nsaldo do legado).
    *
    * Legado:
    *   Select Tmpresul
    *   index on datas to datas
    *   Set near On
    *   =Seek(Ttod(TprMvCab.datas),'Tmpresul','datas')
    *   Set Near Off
    *   If Bof() or Eof()
    *       Go bottom
    *   EndIf
    *   thisform.nsaldo = TmpResul.estoque
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoNaData()
        LOCAL loc_lResultado, loc_dData
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                loc_dData = ConverterParaData(THIS.this_dDataMovimento)

                SET NEAR ON
                =SEEK(loc_dData, THIS.this_cCursorDados, "datas")
                SET NEAR OFF

                SELECT (THIS.this_cCursorDados)

                IF BOF() OR EOF()
                    GO BOTTOM
                ENDIF

                THIS.this_nSaldo = NVL(estoque, 0)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de resultado n" + CHR(227) + "o foi carregado"
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - le do cursor do CHAMADOR os parametros de entrada da
    * projecao, reproduzindo o bloco de leitura que abre o Init legado.
    *
    * Legado:
    *   lcAlias   = Upper(Alias())
    *   lcproduto = &lcAlias..CPros                    && item corrente
    *   lcoper    = TprMvCab.dopes                     && cabecalho
    *   dtini     = Dtot(Date())
    *   dtfin     = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *                   TprMvCab.datas, TprMvCab.prazoents)
    *   ... e TprMvCab.empdopnums, usado na comparacao de cada reserva.
    *
    * No legado esses valores vem de DOIS cursores do chamador: o produto sai
    * da area de trabalho corrente (o ITEM) e o resto sai do cabecalho
    * TprMvCab. Por isso cada coluna eh procurada com TYPE() antes de ser
    * lida - o mesmo metodo atende os dois cursores, e o Form pode chama-lo
    * uma vez para cada um. Coluna ausente simplesmente nao sobrescreve a
    * property, que continua com o valor ja recebido.
    *
    * PEMSTATUS NAO serve aqui: o 1o argumento dele tem de ser OBJETO, e
    * passar nome de cursor estoura "Function argument value, type, or count
    * is invalid." A deteccao de coluna em cursor eh com TYPE(alias + ".col").
    *
    * PUBLIC (sem modificador, como na BusinessBase) - regra #51 do CLAUDE.md:
    * metodo chamado de fora do BO nunca pode ser PROTECTED.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                *-- Produto consultado (CPros do item corrente no legado)
                IF TYPE(loc_cAlias + ".cpros") = "C"
                    THIS.this_cProduto = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".cpros"), ""))
                ENDIF

                *-- Operacao da venda/locacao (TprMvCab.dopes)
                IF TYPE(loc_cAlias + ".dopes") = "C"
                    THIS.this_cOperacao = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".dopes"), ""))
                ENDIF

                *-- Chave da operacao CORRENTE (TprMvCab.empdopnums)
                IF TYPE(loc_cAlias + ".empdopnums") = "C"
                    THIS.this_cEmpDopNums = TratarNulo(EVALUATE(loc_cAlias + ".empdopnums"), "")
                ENDIF

                *-- Data da operacao (TprMvCab.datas)
                IF INLIST(TYPE(loc_cAlias + ".datas"), "D", "T")
                    THIS.this_dDataMovimento = ConverterParaData(EVALUATE(loc_cAlias + ".datas"))
                ENDIF

                *-- Prazo de entrega da operacao (TprMvCab.prazoents)
                IF INLIST(TYPE(loc_cAlias + ".prazoents"), "D", "T")
                    THIS.this_dPrazoEntrega = ConverterParaData(EVALUATE(loc_cAlias + ".prazoents"))
                ENDIF

                *-- Janela da projecao - dtini / dtfin do legado
                THIS.AtualizarJanelaDatas()

                *-- Parametros novos invalidam a projecao ja calculada
                THIS.this_lDadosCarregados = .F.
                THIS.this_nTotalDias       = 0

                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + ;
                                          "o est" + CHR(225) + " aberto: [" + loc_cAlias + "]"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarJanelaDatas - dtini / dtfin do Init legado.
    *
    *   dtini = Dtot(Date())
    *   dtfin = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *               TprMvCab.datas, TprMvCab.prazoents)
    *
    * Fica num metodo proprio porque o Form tambem precisa recalcular a janela
    * quando preenche this_dDataMovimento / this_dPrazoEntrega por parametro,
    * sem passar por um cursor. PUBLIC pelo mesmo motivo (regra #51).
    *==========================================================================
    PROCEDURE AtualizarJanelaDatas()
        THIS.this_dDataInicial = DATE()

        IF EMPTY(THIS.this_dPrazoEntrega)
            THIS.this_dDataFinal = THIS.this_dDataMovimento
        ELSE
            THIS.this_dDataFinal = THIS.this_dPrazoEntrega
        ENDIF

        *-- Sem cabecalho nenhum (chamada direta de teste), a janela degenera
        *-- em um unico dia - DATE() -, que eh o que o legado produz quando
        *-- TprMvCab.datas tambem esta vazio.
        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_dDataFinal = THIS.this_dDataInicial
        ENDIF

        RETURN
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identifica o registro de SigMvItn em que a
    * projecao esta ancorada.
    *
    * SigMvItn tem PK cidchaves char(20), mas o legado nunca posiciona esta
    * tela por cidchaves: ele recebe o item pela area de trabalho corrente e
    * identifica a linha pelo par (produto, operacao) dentro da chave da
    * operacao corrente. Eh essa a identificacao devolvida aqui - a mesma que
    * o RegistrarAuditoria herdado gravaria, e a que aparece no texto de erro
    * do ExibirFalha quando alguem tenta gravar por este BO.
    *
    * PROTECTED (como na BusinessBase - regra #51: nunca chamado de fora).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ALLTRIM(THIS.this_cEmpDopNums) + "|" + ;
                     ALLTRIM(THIS.this_cProduto)    + "|" + ;
                     ALLTRIM(THIS.this_cOperacao)

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

