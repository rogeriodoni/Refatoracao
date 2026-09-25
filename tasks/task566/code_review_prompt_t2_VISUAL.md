# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 634: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (849 linhas total):

*-- Linhas 185 a 194:
185:         THIS.AddObject("grd_4c_Dados", "Grid")
186: 
187:         WITH THIS.grd_4c_Dados
188:             .Top           = 7
189:             .Left          = 9
190:             .Width         = 891
191:             .Height        = 499
192:             .HeaderHeight       = 0
193:             .FontSize      = 8
194:             .ReadOnly      = .F.

*-- Linhas 260 a 268:
260:             .Column1.Resizable         = .F.
261:             .Column1.Alignment         = 2
262:             .Column1.ReadOnly          = .F.
263:             .Column1.Header1.Caption   = "Data"
264:             .Column1.Header1.Alignment = 2
265:             .Column1.Header1.FontSize  = 8
266:             .Column1.Text1.FontSize    = 8
267:             .Column1.Text1.Alignment   = 2
268:             .Column1.Text1.BorderStyle = 0

*-- Linhas 277 a 285:
277:             .Column2.Format            = "999,999.99"
278:             .Column2.InputMask         = "999,999.99"
279:             .Column2.ReadOnly          = .F.
280:             .Column2.Header1.Caption   = "Adquirida"
281:             .Column2.Header1.Alignment = 2
282:             .Column2.Header1.FontSize  = 8
283:             .Column2.Text1.FontSize    = 8
284:             .Column2.Text1.BorderStyle = 0
285:             .Column2.Text1.Format      = "999,999.99"

*-- Linhas 292 a 300:
292:             .Column3.FontSize          = 8
293:             .Column3.Movable           = .F.
294:             .Column3.Resizable         = .F.
295:             .Column3.Header1.Caption   = "Uni"
296:             .Column3.Header1.Alignment = 2
297:             .Column3.Header1.FontSize  = 8
298:             .Column3.Text1.FontSize    = 8
299:             .Column3.Text1.BorderStyle = 0
300:             .Column3.Text1.Margin      = 0

*-- Linhas 307 a 315:
307:             .Column4.Format            = "999,999.99"
308:             .Column4.InputMask         = "999,999.99"
309:             .Column4.ReadOnly          = .F.
310:             .Column4.Header1.Caption   = "Valor Adq."
311:             .Column4.Header1.Alignment = 2
312:             .Column4.Header1.FontSize  = 8
313:             .Column4.Text1.FontSize    = 8
314:             .Column4.Text1.BorderStyle = 0
315:             .Column4.Text1.Format      = "999,999.99"

*-- Linhas 326 a 334:
326:             .Column5.Format            = "999,999.99"
327:             .Column5.InputMask         = "999,999.99"
328:             .Column5.ReadOnly          = .F.
329:             .Column5.Header1.Caption   = "Unit" + CHR(225) + "rio"
330:             .Column5.Header1.Alignment = 2
331:             .Column5.Header1.FontSize  = 8
332:             .Column5.Text1.FontSize    = 8
333:             .Column5.Text1.BorderStyle = 0
334:             .Column5.Text1.Format      = "999,999.99"

*-- Linhas 345 a 353:
345:             .Column6.Format            = "999,999.99"
346:             .Column6.InputMask         = "999,999.99"
347:             .Column6.ReadOnly          = .F.
348:             .Column6.Header1.Caption   = "Total"
349:             .Column6.Header1.Alignment = 2
350:             .Column6.Header1.FontSize  = 8
351:             .Column6.Text1.FontSize    = 8
352:             .Column6.Text1.BorderStyle = 0
353:             .Column6.Text1.Format      = "999,999.99"

*-- Linhas 363 a 371:
363:             .Column7.Movable           = .F.
364:             .Column7.Resizable         = .F.
365:             .Column7.ReadOnly          = .F.
366:             .Column7.Header1.Caption   = "C" + CHR(243) + "digo"
367:             .Column7.Header1.Alignment = 2
368:             .Column7.Header1.FontSize  = 8
369:             .Column7.Text1.FontSize    = 8
370:             .Column7.Text1.BorderStyle = 0
371:             .Column7.Text1.Margin      = 0

*-- Linhas 377 a 385:
377:             .Column8.Movable           = .F.
378:             .Column8.Resizable         = .F.
379:             .Column8.ReadOnly          = .F.
380:             .Column8.Header1.Caption   = "Fornecedor"
381:             .Column8.Header1.Alignment = 2
382:             .Column8.Header1.FontSize  = 8
383:             .Column8.Text1.FontSize    = 8
384:             .Column8.Text1.BorderStyle = 0
385:             .Column8.Text1.Margin      = 0

*-- Linhas 435 a 506:
435:     *--------------------------------------------------------------------------
436:     PROTECTED PROCEDURE ConfigurarCamposAprovacao()
437:         *-- Say10 "Comprador"
438:         THIS.AddObject("lbl_4c_Label10", "Label")
439:         WITH THIS.lbl_4c_Label10
440:             .Top       = 516
441:             .Left      = 9
442:             .Width     = 74
443:             .Height    = 15
444:             .AutoSize  = .T.
445:             .BackStyle = 0
446:             .FontBold  = .T.
447:             .FontSize  = 8
448:             .ForeColor = RGB(90,90,90)
449:             .Caption   = "Comprador"
450:         ENDWITH
451: 
452:         *-- Say5 "Aprovador"
453:         THIS.AddObject("lbl_4c_Label5", "Label")
454:         WITH THIS.lbl_4c_Label5
455:             .Top       = 516
456:             .Left      = 93
457:             .Width     = 71
458:             .Height    = 15
459:             .AutoSize  = .T.
460:             .BackStyle = 0
461:             .FontBold  = .T.
462:             .FontSize  = 8
463:             .ForeColor = RGB(90,90,90)
464:             .Caption   = "Aprovador"
465:         ENDWITH
466: 
467:         *-- Say1 "Data"
468:         THIS.AddObject("lbl_4c_Label1", "Label")
469:         WITH THIS.lbl_4c_Label1
470:             .Top       = 516
471:             .Left      = 177
472:             .Width     = 32
473:             .Height    = 15
474:             .AutoSize  = .T.
475:             .BackStyle = 0
476:             .FontBold  = .T.
477:             .FontSize  = 8
478:             .ForeColor = RGB(90,90,90)
479:             .Caption   = "Data"
480:         ENDWITH
481: 
482:         *-- Say2 "Observacao"
483:         THIS.AddObject("lbl_4c_Label2", "Label")
484:         WITH THIS.lbl_4c_Label2
485:             .Top       = 516
486:             .Left      = 261
487:             .Width     = 79
488:             .Height    = 15
489:             .AutoSize  = .T.
490:             .BackStyle = 0
491:             .FontBold  = .T.
492:             .FontSize  = 8
493:             .ForeColor = RGB(90,90,90)
494:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
495:         ENDWITH
496: 
497:         *-- getComprador (mirror da linha corrente - nunca recebe foco)
498:         THIS.AddObject("txt_4c_Comprador", "TextBox")
499:         WITH THIS.txt_4c_Comprador
500:             .Top               = 532
501:             .Left              = 9
502:             .Width             = 80
503:             .Height            = 20
504:             .FontName          = "Arial"
505:             .FontSize          = 8
506:             .MaxLength         = 10

*-- Linhas 516 a 525:
516:         *-- getAprovador (mirror da linha corrente - nunca recebe foco)
517:         THIS.AddObject("txt_4c_Aprovador", "TextBox")
518:         WITH THIS.txt_4c_Aprovador
519:             .Top               = 532
520:             .Left              = 93
521:             .Width             = 80
522:             .Height            = 20
523:             .FontName          = "Arial"
524:             .FontSize          = 8
525:             .MaxLength         = 10

*-- Linhas 535 a 544:
535:         *-- getDtAprovs (mirror da linha corrente - nunca recebe foco)
536:         THIS.AddObject("txt_4c_DtAprovs", "TextBox")
537:         WITH THIS.txt_4c_DtAprovs
538:             .Top               = 532
539:             .Left              = 177
540:             .Width             = 80
541:             .Height            = 20
542:             .FontName          = "Arial"
543:             .FontSize          = 8
544:             .MaxLength         = 10

*-- Linhas 556 a 565:
556:         *-- o cinza padrao do VFP9 para Enabled = .F.
557:         THIS.AddObject("obj_4c_GetObsAprovs", "EditBox")
558:         WITH THIS.obj_4c_GetObsAprovs
559:             .Top               = 532
560:             .Left              = 261
561:             .Width             = 640
562:             .Height            = 20
563:             .FontName          = "Arial"
564:             .FontSize          = 8
565:             .SpecialEffect     = 1

*-- Linhas 574 a 606:
574:         *-- Shape6 - indicador da legenda (quadrado azul), pareado com Say12
575:         THIS.AddObject("shp_4c_Shape6", "Shape")
576:         WITH THIS.shp_4c_Shape6
577:             .Top           = 562
578:             .Left          = 9
579:             .Width         = 19
580:             .Height        = 19
581:             .BackStyle     = 1
582:             .BorderStyle   = 1
583:             .SpecialEffect = 0
584:             .BackColor     = RGB(0,0,255)
585:             .BorderColor   = RGB(90,90,90)
586:         ENDWITH
587: 
588:         *-- Say12 "Pedidos Gerados" - legenda do Shape6
589:         THIS.AddObject("lbl_4c_Label12", "Label")
590:         WITH THIS.lbl_4c_Label12
591:             .Top       = 565
592:             .Left      = 34
593:             .Width     = 111
594:             .Height    = 15
595:             .AutoSize  = .T.
596:             .WordWrap  = .F.
597:             .BackStyle = 0
598:             .FontBold  = .T.
599:             .FontSize  = 8
600:             .ForeColor = RGB(90,90,90)
601:             .Caption   = "Pedidos Gerados"
602:         ENDWITH
603:     ENDPROC
604: 
605:     *--------------------------------------------------------------------------
606:     * ConfigurarBotoes - Cria cmg_4c_Botoes (equivalente a cmdSalva do

*-- Linhas 614 a 640:
614: 
615:         WITH THIS.cmg_4c_Botoes
616:             .ButtonCount   = 1
617:             .Top           = 5
618:             .Left          = 908
619:             .Width         = 90
620:             .Height        = 110
621:             .BackStyle     = 0
622:             .BorderStyle   = 0
623:             .Value         = 0
624: 
625:             WITH .Buttons(1)
626:                 .Name          = "cmd_4c_Retornar"
627:                 .Top           = 5
628:                 .Left          = 5
629:                 .Width         = 80
630:                 .Height        = 100
631:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
632:                 .Cancel        = .T.
633:                 .Caption       = "Retornar"
634:                 .FontName        = "Comic Sans MS"
635:                 .FontSize        = 8
636:                 .SpecialEffect = 0
637:                 .ForeColor     = RGB(36,84,155)
638:                 .BackColor     = RGB(255,255,255)
639:                 .ToolTipText   = "Sair"
640:                 .Themes        = .F.


### BO (C:\4c\projeto\app\classes\SIGMVCTHBO.prg):
*====================================================================
* SIGMVCTHBO.prg
*
* Business Object para Historico de Cotacoes (consulta de cotacoes
* anteriores de um produto dentro de uma proposta de compra)
* Tabelas: SigCtTCt (itens de cotacao), SigCtTDc (documento/aprovacao
*          da cotacao), SigCtTFn (fornecedor vencedor por cotacao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGMVCTHBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SigCtTCt/SigCtTDc/SigCtTFn)
    this_cCPros       = ""   && cpros char(14) - SigCtTCt - proposta filtrada
    this_nCodigos     = 0    && codigos numeric(6,0) - SigCtTCt - produto atual (excluido do historico)
    this_cCursorDados = ""   && nome do cursor de resultado exibido na grade (equivalente a crHistPeds do legado)

    *-- Propriedades espelhando a linha corrente de THIS.this_cCursorDados
    *-- (mapeadas por CarregarDoCursor - TODAS as colunas de cursor_4c_HistPeds)
    this_nSituas      = 0    && Situas n(1) - situacao da aprovacao (SigCtTDc.situas)
    this_dDatas       = {}   && Datas d(8) - data da cotacao (SigCtTDc.dtcotas)
    this_nQtdAdqs     = 0    && QtdAdqs n(12,2) - quantidade adquirida (SigCtTCt.qtdadqs)
    this_cCUnis       = ""   && CUnis c(3) - unidade (SigCtTCt.cunis)
    this_nValAdqs     = 0    && ValAdqs n(12,2) - valor adquirido (SigCtTCt.valadqs)
    this_nUnits       = 0    && Units n(12,2) - valor unitario da marca vencedora (unit01..unit06)
    this_nTotas       = 0    && Totas n(12,2) - valor total da marca vencedora (tota01..tota06)
    this_cIClis       = ""   && IClis c(10) - codigo do fornecedor vencedor (SigCtTFn.iclis)
    this_cFornecs     = ""   && Fornecs c(50) - nome do fornecedor vencedor (SigCtTFn.fornecs)
    this_cComprador   = ""   && Comprador c(10) - comprador responsavel (SigCtTDc.comprador)
    this_cAprovador   = ""   && Aprovador c(10) - aprovador responsavel (SigCtTDc.aprovador)
    this_dDtAprovs    = {}   && DtAprovs d(8) - data da aprovacao (SigCtTDc.dtaprovs)
    this_cObsAprovs   = ""   && ObsAprovs m(4) - observacao da aprovacao (SigCtTDc.obsaprovs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigCtTCt"
            THIS.this_cCampoChave  = "cidchaves"
            THIS.this_cCPros       = ""
            THIS.this_nCodigos     = 0
            THIS.this_cCursorDados = "cursor_4c_HistPeds"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarHistorico - Busca o historico de cotacoes do produto dentro
    * da proposta filtrada (THIS.this_cCPros / THIS.this_nCodigos).
    *
    * Porta o metodo "CarregaPedidos" do legado: para cada linha de
    * SigCtTCt (itens cotados) casada com SigCtTDc (documento/aprovacao),
    * resolve qual das 6 marcas (Marca01..Marca06) foi a vencedora e busca
    * o fornecedor correspondente em SigCtTFn (chave Codigos+Grades).
    *
    * Popula THIS.this_cCursorDados (cursor_4c_HistPeds), com a MESMA
    * estrutura de campos que o Load() do legado criava para crHistPeds.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cSQLFn, loc_nResultado, loc_nResultadoFn
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cLetra, loc_nUnit, loc_nTotal
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
            SET NULL OFF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Modo de validacao de UI (sem conexao SQL) - cursor fica vazio e o form abre normalmente
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCPros))
                    MostrarErro("Proposta n" + CHR(227) + "o informada.", "SIGMVCTHBO.CarregarHistorico")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT a.Codigos, b.DtCotas AS Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, " + ;
                        "a.Marca01, a.Unit01, a.Tota01, a.Marca02, a.Unit02, a.Tota02, " + ;
                        "a.Marca03, a.Unit03, a.Tota03, a.Marca04, a.Unit04, a.Tota04, " + ;
                        "a.Marca05, a.Unit05, a.Tota05, a.Marca06, a.Unit06, a.Tota06, " + ;
                        "b.Comprador, b.Aprovador, b.DtAprovs, b.ObsAprovs " + ;
                        "FROM SigCtTCt a, SigCtTDc b " + ;
                        "WHERE a.CPros = " + EscaparSQL(THIS.this_cCPros) + " " + ;
                        "AND a.Codigos <> " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + " " + ;
                        "AND a.Codigos = b.Codigos " + ;
                        "ORDER BY b.DtCotas DESC, a.Codigos ASC"

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPedsCt")

                    IF loc_nResultado < 0
                        MostrarErro("Falha ao carregar hist" + CHR(243) + "rico de cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    SELECT cursor_4c_HistPedsCt
                    SCAN
                        loc_cLetra = " "
                        loc_nUnit  = 0
                        loc_nTotal = 0

                        DO CASE
                            CASE cursor_4c_HistPedsCt.Marca01
                                loc_cLetra = "A"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit01
                                loc_nTotal = cursor_4c_HistPedsCt.Tota01
                            CASE cursor_4c_HistPedsCt.Marca02
                                loc_cLetra = "B"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit02
                                loc_nTotal = cursor_4c_HistPedsCt.Tota02
                            CASE cursor_4c_HistPedsCt.Marca03
                                loc_cLetra = "C"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit03
                                loc_nTotal = cursor_4c_HistPedsCt.Tota03
                            CASE cursor_4c_HistPedsCt.Marca04
                                loc_cLetra = "D"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit04
                                loc_nTotal = cursor_4c_HistPedsCt.Tota04
                            CASE cursor_4c_HistPedsCt.Marca05
                                loc_cLetra = "E"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit05
                                loc_nTotal = cursor_4c_HistPedsCt.Tota05
                            CASE cursor_4c_HistPedsCt.Marca06
                                loc_cLetra = "F"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit06
                                loc_nTotal = cursor_4c_HistPedsCt.Tota06
                        ENDCASE

                        IF !EMPTY(loc_cLetra)
                            INSERT INTO (THIS.this_cCursorDados) ;
                                (Situas, Datas, QtdAdqs, CUnis, ValAdqs, Comprador, Aprovador, DtAprovs, ObsAprovs, Units, Totas) ;
                                VALUES ( ;
                                    cursor_4c_HistPedsCt.Situas, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.Datas), ;
                                    cursor_4c_HistPedsCt.QtdAdqs, ;
                                    cursor_4c_HistPedsCt.CUnis, ;
                                    cursor_4c_HistPedsCt.ValAdqs, ;
                                    cursor_4c_HistPedsCt.Comprador, ;
                                    cursor_4c_HistPedsCt.Aprovador, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.DtAprovs), ;
                                    TratarNulo(cursor_4c_HistPedsCt.ObsAprovs, ""), ;
                                    loc_nUnit, ;
                                    loc_nTotal)

                            loc_cSQLFn = "SELECT a.IClis, a.Fornecs FROM SigCtTFn a " + ;
                                "WHERE a.Codigos = " + FormatarNumeroSQL(cursor_4c_HistPedsCt.Codigos, 0) + " " + ;
                                "AND a.Grades = " + EscaparSQL(loc_cLetra)

                            IF USED("cursor_4c_HistPedsFn")
                                USE IN cursor_4c_HistPedsFn
                            ENDIF
                            loc_nResultadoFn = SQLEXEC(gnConnHandle, loc_cSQLFn, "cursor_4c_HistPedsFn")

                            IF loc_nResultadoFn < 0
                                MostrarErro("Falha ao carregar fornecedor vencedor da cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lProsseguir = .F.
                            ELSE
                                IF RECCOUNT("cursor_4c_HistPedsFn") > 0
                                    SELECT (THIS.this_cCursorDados)
                                    GO BOTTOM
                                    REPLACE IClis   WITH cursor_4c_HistPedsFn.IClis, ;
                                            Fornecs WITH cursor_4c_HistPedsFn.Fornecs
                                ENDIF
                                IF USED("cursor_4c_HistPedsFn")
                                    USE IN cursor_4c_HistPedsFn
                                ENDIF
                            ENDIF
                        ENDIF

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT cursor_4c_HistPedsCt
                    ENDSCAN

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    IF USED("cursor_4c_HistPedsFn")
                        USE IN cursor_4c_HistPedsFn
                    ENDIF
                ENDIF

                loc_lSucesso = loc_lProsseguir
            ENDIF

            IF loc_lSucesso AND USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de par_cAliasCursor
    * (tipicamente THIS.this_cCursorDados, a linha selecionada na grade)
    * para as propriedades this_* do Business Object.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nSituas    = TratarNulo(Situas, 0)
                THIS.this_dDatas     = ConverterParaData(TratarNulo(Datas, {}))
                THIS.this_nQtdAdqs   = TratarNulo(QtdAdqs, 0)
                THIS.this_cCUnis     = TratarNulo(CUnis, "")
                THIS.this_nValAdqs   = TratarNulo(ValAdqs, 0)
                THIS.this_nUnits     = TratarNulo(Units, 0)
                THIS.this_nTotas     = TratarNulo(Totas, 0)
                THIS.this_cIClis     = TratarNulo(IClis, "")
                THIS.this_cFornecs   = TratarNulo(Fornecs, "")
                THIS.this_cComprador = TratarNulo(Comprador, "")
                THIS.this_cAprovador = TratarNulo(Aprovador, "")
                THIS.this_dDtAprovs  = ConverterParaData(TratarNulo(DtAprovs, {}))
                THIS.this_cObsAprovs = TratarNulo(ObsAprovs, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/RegistrarAuditoria
    * continuam exatamente como herdados de BusinessBase, por fidelidade ao
    * legado: o formulario SIGMVCTH.SCX e um visualizador de historico
    * SOMENTE LEITURA - as tres consultas acima (SELECT em SigCtTCt/
    * SigCtTDc/SigCtTFn) sao a totalidade do SQL que ele executa. O unico
    * botao (cmdSalva.btnSair, rotulado "Retornar") apenas fecha a tela
    * (ThisForm.Release) - o legado nao tem nenhum INSERT/UPDATE/DELETE
    * para portar, e este form nunca aciona THIS.Salvar() nem
    * THIS.Excluir(). O comportamento herdado de BusinessBase (recusar a
    * operacao e avisar o usuario) ja reproduz essa realidade com
    * fidelidade, entao sobrescrever aqui apenas duplicaria codigo sem
    * alterar nada em tempo de execucao.
    *====================================================================

ENDDEFINE

