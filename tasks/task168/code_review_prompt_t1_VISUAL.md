# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 436: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 459: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 491: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1089 linhas total):

*-- Linhas 106 a 114:
106:             ENDIF
107: 
108:             *-- Caption com acentos via CHR
109:             THIS.Caption = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
110: 
111:             *-- Imagem de fundo (equivalente ao legado new_background.jpg)
112:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
113: 
114:             *-- Criar Business Object e propagar parametros

*-- Linhas 207 a 257:
207:         loc_oCab = THIS.cnt_4c_Cabecalho
208: 
209:         WITH loc_oCab
210:             .Top         = 0
211:             .Left        = 0
212:             .Width       = THIS.Width
213:             .Height      = 80
214:             .BackStyle   = 1
215:             .BackColor   = RGB(100, 100, 100)
216:             .BorderWidth = 0
217:             .Visible     = .T.
218: 
219:             .AddObject("lbl_4c_Sombra", "Label")
220:             WITH .lbl_4c_Sombra
221:                 .AutoSize      = .F.
222:                 .Top           = 18
223:                 .Left          = 10
224:                 .Width         = loc_oCab.Width
225:                 .Height        = 40
226:                 .FontBold      = .T.
227:                 .FontName      = "Tahoma"
228:                 .FontSize      = 18
229:                 .FontUnderline = .F.
230:                 .WordWrap      = .T.
231:                 .Alignment     = 0
232:                 .BackStyle     = 0
233:                 .ForeColor     = RGB(0, 0, 0)
234:                 .Caption       = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
235:             ENDWITH
236: 
237:             .AddObject("lbl_4c_Titulo", "Label")
238:             WITH .lbl_4c_Titulo
239:                 .AutoSize  = .F.
240:                 .Top       = 17
241:                 .Left      = 10
242:                 .Width     = loc_oCab.Width
243:                 .Height    = 46
244:                 .FontBold  = .T.
245:                 .FontName  = "Tahoma"
246:                 .FontSize  = 18
247:                 .FontUnderline = .F.
248:                 .WordWrap  = .T.
249:                 .Alignment = 0
250:                 .BackStyle = 0
251:                 .ForeColor = RGB(255, 255, 255)
252:                 .Caption   = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
253:             ENDWITH
254:         ENDWITH
255: 
256:         loc_oCab.Visible = .T.
257:     ENDPROC

*-- Linhas 279 a 314:
279: 
280:         WITH loc_oPgf
281:             .PageCount = 2
282:             .Top       = 80
283:             .Left      = 0
284:             .Width     = THIS.Width
285:             .Height    = THIS.Height - 80
286:             .TabIndex  = 1
287:             .Tabs      = .F.
288:             .BorderWidth = 0
289:         ENDWITH
290: 
291:         loc_oPgf.Page1.Caption = "Lista"
292:         loc_oPgf.Page2.Caption = "Dados"
293: 
294:         *-- Containers principais da Page1 (serao populados nas fases seguintes)
295:         loc_oPgf.Page1.AddObject("cnt_4c_Botoes", "Container")
296:         WITH loc_oPgf.Page1.cnt_4c_Botoes
297:             .Top         = 3
298:             .Left        =  542
299:             .Width       = 300
300:             .Height      = 40
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         loc_oPgf.Page1.AddObject("cnt_4c_BotoesAcao", "Container")
307:         WITH loc_oPgf.Page1.cnt_4c_BotoesAcao
308:             .Top         = 3
309:             .Left        = 725
310:             .Width       = 90
311:             .Height      = 40
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.

*-- Linhas 350 a 371:
350:     *--------------------------------------------------------------------------
351:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
352:     * SKIP: Grade (Visible=.F. inicial, controlado por CarregarBaixas)
353:     *        txt_4c_Leitura e lbl_4c_Txt_Leitura (Visible=.F. inicial)
354:     *--------------------------------------------------------------------------
355:     PROCEDURE TornarControlesVisiveis(par_oContainer)
356:         LOCAL loc_i, loc_oControl
357: 
358:         FOR loc_i = 1 TO par_oContainer.ControlCount
359:             loc_oControl = par_oContainer.Controls(loc_i)
360: 
361:             IF VARTYPE(loc_oControl) = "O"
362:                 *-- Containers/controles que devem permanecer ocultos inicialmente
363:                 IF INLIST(UPPER(loc_oControl.Name), ;
364:                           "GRD_4C_DADOS", ;
365:                           "TXT_4C_LEITURA", ;
366:                           "LBL_4C_TXT_LEITURA", ;
367:                           "CNT_4C_CABECALHO")
368:                     *-- Recursao nos filhos mesmo com LOOP (filhos ficam .T.)
369:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
370:                         THIS.TornarControlesVisiveis(loc_oControl)
371:                     ENDIF

*-- Linhas 423 a 470:
423:             *-- Redimensionar e popular cnt_4c_Botoes (Conf.Auto + Ok)
424:             loc_oCntBotoes = loc_oPagina.cnt_4c_Botoes
425:             WITH loc_oCntBotoes
426:                 .Left   = 720
427:                 .Width  = 165
428:                 .Height = 85
429: 
430:                 .AddObject("cmd_4c_Conferencia", "CommandButton")
431:                 WITH .cmd_4c_Conferencia
432:                     .Top             = 5
433:                     .Left            = 5
434:                     .Width           = 75
435:                     .Height          = 75
436:                     .FontBold        = .T.
437:                     .FontItalic      = .T.
438:                     .FontName        = "Comic Sans MS"
439:                     .FontSize        = 8
440:                     .ForeColor       = RGB(90, 90, 90)
441:                     .BackColor       = RGB(255, 255, 255)
442:                     .Caption         = "Conf. Auto"
443:                     .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
444:                     .Themes          = .F.
445:                     .SpecialEffect   = 0
446:                     .PicturePosition = 13
447:                     .MousePointer    = 15
448:                     .WordWrap        = .T.
449:                     .AutoSize        = .F.
450:                     .Visible         = .F.
451:                 ENDWITH
452: 
453:                 .AddObject("cmd_4c_Ok", "CommandButton")
454:                 WITH .cmd_4c_Ok
455:                     .Top             = 5
456:                     .Left            = 85
457:                     .Width           = 75
458:                     .Height          = 75
459:                     .FontBold        = .T.
460:                     .FontItalic      = .T.
461:                     .FontName        = "Comic Sans MS"
462:                     .FontSize        = 8
463:                     .ForeColor       = RGB(90, 90, 90)
464:                     .BackColor       = RGB(255, 255, 255)
465:                     .Caption         = "Ok"
466:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
467:                     .Themes          = .F.
468:                     .SpecialEffect   = 0
469:                     .PicturePosition = 13
470:                     .MousePointer    = 15

*-- Linhas 477 a 567:
477:             *-- Redimensionar e popular cnt_4c_BotoesAcao (Encerrar)
478:             loc_oCntBotoesAcao = loc_oPagina.cnt_4c_BotoesAcao
479:             WITH loc_oCntBotoesAcao
480:                 .Left   = 895
481:                 .Width  = 90
482:                 .Height = 85
483: 
484:                 .AddObject("cmd_4c_Sair", "CommandButton")
485:                 WITH .cmd_4c_Sair
486:                     .Top             = 5
487:                     .Left            = 5
488:                     .Width           = 75
489:                     .Height          = 75
490:                     .Cancel          = .T.
491:                     .FontBold        = .T.
492:                     .FontItalic      = .T.
493:                     .FontName        = "Comic Sans MS"
494:                     .FontSize        = 8
495:                     .ForeColor       = RGB(90, 90, 90)
496:                     .BackColor       = RGB(255, 255, 255)
497:                     .Caption         = "Encerrar"
498:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
499:                     .Themes          = .F.
500:                     .SpecialEffect   = 0
501:                     .PicturePosition = 13
502:                     .MousePointer    = 15
503:                     .WordWrap        = .T.
504:                     .AutoSize        = .F.
505:                 ENDWITH
506:             ENDWITH
507: 
508:             *-- Label "Data :"
509:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
510:             WITH loc_oPagina.lbl_4c_Label2
511:                 .AutoSize  = .T.
512:                 .FontName  = "Tahoma"
513:                 .FontSize  = 8
514:                 .BackStyle = 0
515:                 .Caption   = "Data : "
516:                 .Height    = 15
517:                 .Left      = 133
518:                 .Top       = 110
519:                 .ForeColor = RGB(90, 90, 90)
520:             ENDWITH
521: 
522:             *-- TextBox Data (somente leitura, exibe data do form pai)
523:             loc_oPagina.AddObject("txt_4c_Data", "TextBox")
524:             WITH loc_oPagina.txt_4c_Data
525:                 .FontName          = "Tahoma"
526:                 .FontSize          = 8
527:                 .Alignment         = 3
528:                 .Value             = THIS.this_dData
529:                 .Height            = 23
530:                 .Left              = 60
531:                 .Top               = 44
532:                 .Width             = 100
533:                 .ReadOnly          = .T.
534:                 .SpecialEffect     = 1
535:                 .DisabledBackColor = RGB(255, 255, 255)
536:                 .BorderColor       = RGB(100, 100, 100)
537:             ENDWITH
538: 
539:             *-- Label "Codigo de barra :" (Visible=.F. ate CarregarBaixas encontrar registros)
540:             loc_oPagina.AddObject("lbl_4c_Txt_Leitura", "Label")
541:             WITH loc_oPagina.lbl_4c_Txt_Leitura
542:                 .AutoSize  = .T.
543:                 .FontName  = "Tahoma"
544:                 .FontSize  = 8
545:                 .BackStyle = 0
546:                 .Caption   = "C" + CHR(243) + "digo de barra :"
547:                 .Height    = 15
548:                 .Left      = 133
549:                 .Top       = 359
550:                 .ForeColor = RGB(90, 90, 90)
551:                 .Visible   = .F.
552:             ENDWITH
553: 
554:             *-- TextBox leitura de codigo de barras (Visible=.F. inicial)
555:             loc_oPagina.AddObject("txt_4c_Leitura", "TextBox")
556:             WITH loc_oPagina.txt_4c_Leitura
557:                 .FontName    = "Tahoma"
558:                 .FontSize    = 8
559:                 .Height      = 23
560:                 .InputMask   = "99999999999999"
561:                 .Left        = 130
562:                 .Top         = 451
563:                 .Width       = 135
564:                 .Value       = 0
565:                 .BorderColor = RGB(100, 100, 100)
566:                 .Visible     = .F.
567:             ENDWITH

*-- Linhas 580 a 592:
580:                 .DeleteMark        = .F.
581:                 .RecordMark        = .F.
582:                 .Height            = 336
583:                 .Left              = 12
584:                 .ReadOnly          = .T.
585:                 .RowHeight         = 17
586:                 .ScrollBars        = 2
587:                 .Top               = 98
588:                 .Width             = 940
589:                 .Panel             = 1
590:                 .Visible           = .F.
591: 
592:                 *-- Propriedades visuais das colunas

*-- Linhas 624 a 657:
624:                 .Column5.ControlSource = "cursor_4c_TmpBaixa.QtdeLido"
625: 
626:                 *-- Headers (reconfigurar apos RecordSource pois VFP9 os reseta)
627:                 .Column1.Header1.Caption   = "C" + CHR(243) + "d. Barra"
628:                 .Column1.Header1.FontName  = "Tahoma"
629:                 .Column1.Header1.FontSize  = 8
630:                 .Column1.Header1.Alignment = 2
631:                 .Column2.Header1.Caption   = "Produto"
632:                 .Column2.Header1.FontName  = "Tahoma"
633:                 .Column2.Header1.FontSize  = 8
634:                 .Column2.Header1.Alignment = 2
635:                 .Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
636:                 .Column3.Header1.FontName  = "Tahoma"
637:                 .Column3.Header1.FontSize  = 8
638:                 .Column3.Header1.Alignment = 2
639:                 .Column4.Header1.Caption   = "N" + CHR(250) + "mero"
640:                 .Column4.Header1.FontName  = "Tahoma"
641:                 .Column4.Header1.FontSize  = 8
642:                 .Column4.Header1.Alignment = 2
643:                 .Column5.Header1.Caption   = "Qtde."
644:                 .Column5.Header1.FontName  = "Tahoma"
645:                 .Column5.Header1.FontSize  = 8
646:                 .Column5.Header1.Alignment = 2
647:             ENDWITH
648: 
649:             *-- BINDEVENTs (metodos PUBLIC por default em DEFINE CLASS)
650:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia, "Click", THIS, "CmdConferenciaClick")
651:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
652:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
653:             BINDEVENT(loc_oPagina.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
654: 
655:         CATCH TO loc_oErro
656:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
657:         ENDTRY

*-- Linhas 686 a 696:
686: 
687:             loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
688:             loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
689:             loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
690:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
691:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
692: 
693:             IF loc_lTemDados
694:                 loc_oPagina.grd_4c_Dados.Refresh()
695:                 loc_oPagina.txt_4c_Leitura.SetFocus()
696:             ELSE

*-- Linhas 1020 a 1037:
1020:                     loc_oPagina.txt_4c_Leitura.Visible  = loc_lTemDados
1021:                 ENDIF
1022: 
1023:                 IF PEMSTATUS(loc_oPagina, "lbl_4c_Txt_Leitura", 5)
1024:                     loc_oPagina.lbl_4c_Txt_Leitura.Visible = loc_lTemDados
1025:                 ENDIF
1026: 
1027:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1028:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Ok", 5)
1029:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible = loc_lTemDados
1030:                     ENDIF
1031:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Conferencia", 5)
1032:                         loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
1033:                     ENDIF
1034:                 ENDIF
1035: 
1036:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
1037:                     loc_oPagina.grd_4c_Dados.Visible = loc_lTemDados


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Herda de: BusinessBase
* Tabela principal: SigOpEtq (etiquetas de producao)
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Chave e tabela principal
    this_cTabela      = "SigOpEtq"
    this_cCampoChave  = "CBars"

    *-- Data de referencia (Get_Data do form pai)
    this_dData        = {}

    *-- Chave unica da sessao (CrSigCdPac.SigKeys)
    this_cSigKey      = ""

    *-- Parametros vindos de crSigCdPam
    this_cDopeCit     = ""
    this_cDopTransf   = ""
    this_cGruConfs    = ""
    this_cConConfs    = ""
    this_cGruReservs  = ""
    this_cConReservs  = ""
    this_cGrupoEsts   = ""
    this_cContaEsts   = ""

    *-- Campos do cursor cursor_4c_TmpBaixa (linha corrente)
    this_cCodBarra    = ""
    this_cCPros       = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nQtde        = 0
    this_nQtdeLido    = 0
    this_nNops        = 0
    this_cGrupods     = ""
    this_cContads     = ""

    *-- Estado interno
    this_lGradeVisivel = .F.
    this_nSeqContador  = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            DODEFAULT()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades this_
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodBarra  = TratarNulo(CodBarra,  "C")
                THIS.this_cCPros     = TratarNulo(CPros,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_nQtde      = TratarNulo(Qtde,      "N")
                THIS.this_nQtdeLido  = TratarNulo(QtdeLido,  "N")
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_cGrupods   = TratarNulo(Grupods,   "C")
                THIS.this_cContads   = TratarNulo(Contads,   "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBaixas - Carrega etiquetas de producao em cursor_4c_TmpBaixa
    * Equivalente ao legado carregabars.
    * Pre-requisito: cursor_4c_TmpEnc deve existir (Dopps C, Numps N)
    * cursor_4c_TmpBaixa deve existir com tags CodBarra e GruConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBaixas()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL
        LOCAL loc_cDopps, loc_nNumps, loc_cChave
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_cGruReservs, loc_cConReservs
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_cDopeCit
        LOCAL loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs
        LOCAL loc_nNops, loc_cEmpos, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtEti, loc_nQtCit, loc_nBaixa, loc_nPendente, loc_nPVal
        LOCAL loc_llBaixa, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cEmpDopNumsCit

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_TmpEnc")
                MsgErro("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar TmpBaixa
            SELECT cursor_4c_TmpBaixa
            ZAP

            loc_cGruConfs   = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs   = ALLTRIM(THIS.this_cConConfs)
            loc_cGruReservs = ALLTRIM(THIS.this_cGruReservs)
            loc_cConReservs = ALLTRIM(THIS.this_cConReservs)
            loc_cGrupoEsts  = ALLTRIM(THIS.this_cGrupoEsts)
            loc_cContaEsts  = ALLTRIM(THIS.this_cContaEsts)
            loc_cDopeCit    = ALLTRIM(THIS.this_cDopeCit)

            SELECT cursor_4c_TmpEnc
            GO TOP

            SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                loc_cDopps = ALLTRIM(cursor_4c_TmpEnc.Dopps)
                loc_nNumps = cursor_4c_TmpEnc.Numps
                loc_cChave = go_4c_Sistema.cCodEmpresa + loc_cDopps + STR(loc_nNumps, 6)

                *-- Buscar etiquetas desta OS
                loc_cSQL = "SELECT e.CBars, e.CPros, e.DopeOs, e.NumeOs, e.Qtds, e.Nops, " + ;
                           "e.Empos, e.CodCors, e.CodTams, e.Grupos, e.Contas " + ;
                           "FROM SigOpEtq e " + ;
                           "WHERE e.EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtqBx") > 0
                    SELECT cursor_4c_SigOpEtqBx
                    SCAN
                        *-- Verificar se etiqueta pertence ao grupo/conta de conferencia
                        IF ALLTRIM(cursor_4c_SigOpEtqBx.Grupos) + ALLTRIM(cursor_4c_SigOpEtqBx.Contas) <> ;
                           loc_cGruConfs + loc_cConConfs
                            LOOP
                        ENDIF

                        loc_cCBars   = ALLTRIM(cursor_4c_SigOpEtqBx.CBars)
                        loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtqBx.CPros)
                        loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtqBx.DopeOs)
                        loc_nNumeOs  = cursor_4c_SigOpEtqBx.NumeOs
                        loc_nNops    = cursor_4c_SigOpEtqBx.Nops
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqBx.Empos)
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqBx.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqBx.CodTams)
                        loc_nQtEti   = cursor_4c_SigOpEtqBx.Qtds
                        loc_nQtCit   = 0

                        *-- Buscar movimento origem para determinar grupos/contas
                        loc_cSQL = "SELECT TOP 1 m.Dopes, m.Grupoos, m.Contaos, m.Grupods, m.Contads " + ;
                                   "FROM SigMvCab m " + ;
                                   "WHERE m.EmpDopNums = " + EscaparSQL(loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCabBx") > 0
                            SELECT cursor_4c_MvCabBx
                            IF !EOF()
                                *-- Verificar tipo de operacao (Globalizas/Servicos)
                                loc_cSQL = "SELECT TOP 1 Globalizas, Servicos FROM SigCdOpe " + ;
                                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_MvCabBx.Dopes))

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeBx") > 0
                                    SELECT cursor_4c_SigCdOpeBx
                                    IF !EOF() AND (NVL(cursor_4c_SigCdOpeBx.Globalizas, 0) = 1 OR ;
                                                   NVL(cursor_4c_SigCdOpeBx.Servicos, 0) = 1)
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupoos)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contaos)
                                    ELSE
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                    ENDIF
                                    IF USED("cursor_4c_SigCdOpeBx")
                                        USE IN cursor_4c_SigCdOpeBx
                                    ENDIF
                                ELSE
                                    loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                    loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                ENDIF

                                *-- Aplicar override de GruReservs/ConReservs
                                loc_cGrupo = IIF(EMPTY(loc_cGruReservs), loc_cTGrupo, loc_cGruReservs)
                                loc_cConta = IIF(EMPTY(loc_cConReservs), loc_cTConta, loc_cConReservs)

                                *-- Verificar tipo de estoque pelo grupo do produto
                                loc_nTipoEstos = 1
                                loc_cSQL = "SELECT p.CGrus FROM SigCdPro p WHERE p.CPros = " + EscaparSQL(loc_cCPros)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProBx") > 0
                                    SELECT cursor_4c_SigCdProBx
                                    IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        loc_cSQL = "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + ;
                                                   EscaparSQL(ALLTRIM(cursor_4c_SigCdProBx.CGrus))
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdGrpBx") > 0
                                            SELECT cursor_4c_SigCdGrpBx
                                            IF !EOF()
                                                loc_nTipoEstos = NVL(cursor_4c_SigCdGrpBx.TipoEstos, 1)
                                                IF !INLIST(loc_nTipoEstos, 2, 3, 4)
                                                    loc_nTipoEstos = 1
                                                ENDIF
                                            ENDIF
                                            IF USED("cursor_4c_SigCdGrpBx")
                                                USE IN cursor_4c_SigCdGrpBx
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdProBx")
                                        USE IN cursor_4c_SigCdProBx
                                    ENDIF
                                ENDIF

                                *-- Override grupo/conta pelo cliente destino
                                loc_cSQL = "SELECT GruProds, ConProds FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cTConta)
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdCliBx") > 0
                                    SELECT cursor_4c_SigCdCliBx
                                    IF !EOF()
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.GruProds))
                                            loc_cGrupo = ALLTRIM(cursor_4c_SigCdCliBx.GruProds)
                                        ENDIF
                                        IF !EMPTY(ALLTRIM(cursor_4c_SigCdCliBx.ConProds))
                                            loc_cConta = ALLTRIM(cursor_4c_SigCdCliBx.ConProds)
                                        ENDIF
                                    ENDIF
                                    IF USED("cursor_4c_SigCdCliBx")
                                        USE IN cursor_4c_SigCdCliBx
                                    ENDIF
                                ENDIF

                                *-- Processar operacao de citacao (DopeCit) se configurada
                                IF !EMPTY(loc_cDopeCit)
                                    loc_cEmpDopNumsCit = loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)
                                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCit") > 0
                                        SELECT cursor_4c_ChkCit
                                        IF !EOF() AND NVL(cursor_4c_ChkCit.nExiste, 0) > 0
                                            loc_nBaixa = loc_nQtEti

                                            IF loc_nTipoEstos = 1
                                                *-- Baixar SigMvItn (itens simples por produto)
                                                loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds " + ;
                                                           "FROM SigMvItn " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCit") > 0
                                                    SELECT cursor_4c_ItnCit
                                                    GO TOP
                                                    SCAN WHILE !EOF("cursor_4c_ItnCit") AND loc_nBaixa > 0
                                                        IF (cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas) <> 0
                                                            loc_nPendente = cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal  = loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nPVal  = loc_nPendente
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItnCit.QtBaixas + loc_nPVal = cursor_4c_ItnCit.Qtds, 1, 0)
                                                            loc_cSQL = "UPDATE SigMvItn " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + ", " + ;
                                                                       "DtAlts = GETDATE() " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItn")
                                                            IF USED("cursor_4c_UpdItn")
                                                                USE IN cursor_4c_UpdItn
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItnCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItnCit")
                                                        USE IN cursor_4c_ItnCit
                                                    ENDIF
                                                ENDIF
                                            ELSE
                                                *-- Baixar SigMvIts (itens com cor/tamanho)
                                                loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                                           "FROM SigMvIts " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                                           " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                                           " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItsCit") > 0
                                                    SELECT cursor_4c_ItsCit
                                                    SCAN WHILE !EOF("cursor_4c_ItsCit") AND loc_nBaixa > 0
                                                        loc_nPendente = cursor_4c_ItsCit.Qtds - cursor_4c_ItsCit.QtBaixas
                                                        IF loc_nPendente <> 0
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal = loc_nBaixa
                                                            ELSE
                                                                loc_nPVal = loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItsCit.QtBaixas + loc_nPVal = cursor_4c_ItsCit.Qtds, 1, 0)

                                                            loc_cSQL = "UPDATE SigMvIts " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + " " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdIts")
                                                            IF USED("cursor_4c_UpdIts")
                                                                USE IN cursor_4c_UpdIts
                                                            ENDIF

                                                            *-- Atualizar SigMvItn correspondente ao item
                                                            loc_cSQL = "SELECT cIdChaves FROM SigMvItn " + ;
                                                                       "WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.EmpDopNums)) + ;
                                                                       " AND CItens = " + TRANSFORM(cursor_4c_ItsCit.CItens)
                                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCorr") > 0
                                                                SELECT cursor_4c_ItnCorr
                                                                IF !EOF()
                                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                                               "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                               "DtAlts = GETDATE() " + ;
                                                                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCorr.cIdChaves))
                                                                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItnC")
                                                                    IF USED("cursor_4c_UpdItnC")
                                                                        USE IN cursor_4c_UpdItnC
                                                                    ENDIF
                                                                ENDIF
                                                                IF USED("cursor_4c_ItnCorr")
                                                                    USE IN cursor_4c_ItnCorr
                                                                ENDIF
                                                            ENDIF

                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItsCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItsCit")
                                                        USE IN cursor_4c_ItsCit
                                                    ENDIF
                                                ENDIF
                                            ENDIF

                                            loc_nQtCit = loc_nQtEti - loc_nBaixa
                                        ENDIF
                                        IF USED("cursor_4c_ChkCit")
                                            USE IN cursor_4c_ChkCit
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- Calcular quantidade que vai para TmpBaixa
                                loc_nQtEti = cursor_4c_SigOpEtqBx.Qtds - loc_nQtCit

                                *-- Inserir na TmpBaixa (quantidade principal -> grupo/conta destino)
                                IF loc_nQtEti <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtEti, 0, loc_nNops, loc_cGrupo, loc_cConta)
                                ENDIF

                                *-- Inserir na TmpBaixa (quantidade citacao -> grupo/conta estoque)
                                IF loc_nQtCit <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtCit, 0, loc_nNops, loc_cGrupoEsts, loc_cContaEsts)
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_MvCabBx")
                                USE IN cursor_4c_MvCabBx
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpEtqBx
                    ENDSCAN

                    IF USED("cursor_4c_SigOpEtqBx")
                        USE IN cursor_4c_SigOpEtqBx
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpEnc
            ENDSCAN

            *-- Posicionar no inicio da TmpBaixa
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLeitura - Marca codigo de barras como lido na cursor_4c_TmpBaixa
    * Equivalente ao legado Get_Leitura.Valid
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLeitura(par_cCodBarra)
        LOCAL loc_lSucesso, loc_oErro, loc_cCodBarra

        loc_lSucesso = .F.
        loc_cCodBarra = ALLTRIM(par_cCodBarra)

        TRY
            IF EMPTY(loc_cCodBarra) OR !USED("cursor_4c_TmpBaixa")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_TmpBaixa
            SET ORDER TO TAG CodBarra

            IF SEEK(loc_cCodBarra)
                IF cursor_4c_TmpBaixa.QtdeLido = 0
                    REPLACE QtdeLido WITH cursor_4c_TmpBaixa.Qtde IN cursor_4c_TmpBaixa
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLidas - Marca todas etiquetas como lidas (Conferencia Auto)
    * Equivalente ao legado Conferencia.Click
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLidas()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG CodBarra
                REPLACE ALL QtdeLido WITH Qtde IN cursor_4c_TmpBaixa
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConferencia - Processa confirmacao da conferencia (equivalente Ok.Click)
    * Cria SigMvCab + SigMvItn + SigMvHst e atualiza SigOpEtq para cada item lido
    * Pre-requisito: this_cDopTransf, this_cGruConfs, this_cConConfs, this_cSigKey devem estar setados
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_llTaOk
        LOCAL loc_cSQL, loc_nNume, loc_cDopTransf
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_nItem, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads, loc_cEmpDopNums
        LOCAL loc_cCPros, loc_cCodBarra, loc_nQtdeLido
        LOCAL loc_cDPros, loc_cCUnis
        LOCAL loc_cEmposItm, loc_cCodCors2, loc_cCodTams2

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cDopTransf = ALLTRIM(THIS.this_cDopTransf)
            loc_cGruConfs  = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs  = ALLTRIM(THIS.this_cConConfs)

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trans")
            IF USED("cursor_4c_Trans")
                USE IN cursor_4c_Trans
            ENDIF

            loc_llTaOk = .T.

            *-- Obter grupos/contas distintos com itens lidos
            SELECT DISTINCT Grupods, Contads FROM cursor_4c_TmpBaixa ;
                WHERE QtdeLido <> 0 ;
                INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            GO TOP

            SCAN WHILE !EOF("cursor_4c_xCabec") AND loc_llTaOk
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                *-- Gerar numero unico do movimento
                loc_nNume      = THIS.GerarChaveUnica(go_4c_Sistema.cCodEmpresa + loc_cDopTransf)
                loc_cEmpDopNums = go_4c_Sistema.cCodEmpresa + loc_cDopTransf + STR(loc_nNume, 6)

                *-- Inserir cabecalho SigMvCab
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                           "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cIdChaves, DtAlts, EmpGopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                           EscaparSQL(loc_cDopTransf) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(THIS.GerarMascara(loc_nNume)) + ", " + ;
                           "GETDATE(), GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cGruConfs) + ", " + ;
                           EscaparSQL(loc_cConConfs) + ", " + ;
                           EscaparSQL(loc_cGrupods) + ", " + ;
                           EscaparSQL(loc_cContads) + ", " + ;
                           EscaparSQL(loc_cEmpDopNums) + ", " + ;
                           EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResCab") < 1
                    MsgErro("Falha ao inserir SigMvCab!", "Erro")
                    loc_llTaOk = .F.
                    EXIT
                ENDIF
                IF USED("cursor_4c_ResCab")
                    USE IN cursor_4c_ResCab
                ENDIF

                *-- Iterar itens deste grupo/conta
                loc_nItem = 0
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                      FOR QtdeLido <> 0

                    loc_nItem     = loc_nItem + 1
                    loc_cCPros    = ALLTRIM(cursor_4c_TmpBaixa.CPros)
                    loc_cCodBarra = ALLTRIM(cursor_4c_TmpBaixa.CodBarra)
                    loc_nQtdeLido = cursor_4c_TmpBaixa.QtdeLido

                    *-- Buscar dados do produto (descricao e unidade)
                    loc_cDPros = ""
                    loc_cCUnis = ""
                    loc_cSQL = "SELECT DPros, CUnis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProItm") > 0
                        SELECT cursor_4c_ProItm
                        IF !EOF()
                            loc_cDPros = ALLTRIM(DPros)
                            loc_cCUnis = ALLTRIM(CUnis)
                        ENDIF
                        IF USED("cursor_4c_ProItm")
                            USE IN cursor_4c_ProItm
                        ENDIF
                    ENDIF

                    *-- Buscar dados da etiqueta (cor, tamanho, empresa origem)
                    loc_cCodCors2 = ""
                    loc_cCodTams2 = ""
                    loc_cEmposItm = go_4c_Sistema.cCodEmpresa
                    loc_cSQL = "SELECT CodCors, CodTams, Empos FROM SigOpEtq WHERE CBars = " + EscaparSQL(loc_cCodBarra)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtqItm") > 0
                        SELECT cursor_4c_EtqItm
                        IF !EOF()
                            loc_cCodCors2 = ALLTRIM(CodCors)
                            loc_cCodTams2 = ALLTRIM(CodTams)
                            loc_cEmposItm = ALLTRIM(Empos)
                        ENDIF
                        IF USED("cursor_4c_EtqItm")
                            USE IN cursor_4c_EtqItm
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_TmpBaixa

                    *-- Inserir item SigMvItn
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(CItens, Emps, Dopes, Numes, CPros, Qtds, CUnis, DPros, Opers, " + ;
                               "CodBarras, EmpDopNums, cIdChaves, DtAlts) " + ;
                               "VALUES (" + ;
                               TRANSFORM(loc_nItem) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               EscaparSQL(loc_cCUnis) + ", " + ;
                               EscaparSQL(loc_cDPros) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                               "GETDATE())"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResItn") < 1
                        MsgErro("Falha ao inserir SigMvItn!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResItn")
                        USE IN cursor_4c_ResItn
                    ENDIF

                    *-- Historico de saida do grupo conferencia (S)
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cGruConfs) + ", " + ;
                               EscaparSQL(loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGruConfs + loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstS") < 1
                        MsgErro("Falha ao inserir SigMvHst (S)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstS")
                        USE IN cursor_4c_ResHstS
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGruConfs, loc_cConConfs, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Historico de entrada no grupo destino (E)
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'E', " + ;
                               EscaparSQL(loc_cGrupods) + ", " + ;
                               EscaparSQL(loc_cContads) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGrupods + loc_cContads) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstE") < 1
                        MsgErro("Falha ao inserir SigMvHst (E)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstE")
                        USE IN cursor_4c_ResHstE
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGrupods, loc_cContads, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Atualizar SigOpEtq com grupo/conta destino
                    loc_cSQL = "UPDATE SigOpEtq " + ;
                               "SET Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = GETDATE() " + ;
                               "WHERE CBars = " + EscaparSQL(loc_cCodBarra)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResEtq") < 1
                        MsgErro("Falha ao atualizar SigOpEtq!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResEtq")
                        USE IN cursor_4c_ResEtq
                    ENDIF

                    SELECT cursor_4c_TmpBaixa
                ENDSCAN

                IF !loc_llTaOk
                    EXIT
                ENDIF

                SELECT cursor_4c_xCabec
            ENDSCAN

            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF

            *-- Confirmar ou reverter transacao
            IF loc_llTaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
                THIS.RegistrarAuditoria("CONFERENCIA")
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
            IF USED("cursor_4c_TransR")
                USE IN cursor_4c_TransR
            ENDIF
            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Processa a conferencia das etiquetas (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarConferencia()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Registra leitura de codigo de barras (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cCodBarra)
        LOCAL loc_cCodBarra
        loc_cCodBarra = IIF(PCOUNT() > 0, par_cCodBarra, THIS.this_cCodBarra)
        RETURN THIS.RegistrarLeitura(loc_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Audit")
            IF USED("cursor_4c_Audit")
                USE IN cursor_4c_Audit
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera numero sequencial unico por prefixo
    * Prefixo de movimento (Emps+Dopes, >8 chars): usa MAX(Numes)+1 de SigMvCab
    * Prefixo curto (data YYYYMMDD ou HISTBAR): usa contador interno this_nSeqContador
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica(par_cPrefixo)
        LOCAL loc_nChave, loc_cSQL, loc_cPref, loc_oErro

        loc_nChave = 1
        loc_cPref  = ALLTRIM(par_cPrefixo)

        TRY
            IF LEN(loc_cPref) > 8
                *-- Prefixo de movimento: Emps + Dopes
                loc_cSQL = "SELECT ISNULL(MAX(Numes), 0) + 1 AS Proximo " + ;
                           "FROM SigMvCab " + ;
                           "WHERE Emps + Dopes = " + EscaparSQL(loc_cPref)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqMv") > 0
                    SELECT cursor_4c_SeqMv
                    IF !EOF()
                        loc_nChave = NVL(cursor_4c_SeqMv.Proximo, 1)
                    ENDIF
                    IF USED("cursor_4c_SeqMv")
                        USE IN cursor_4c_SeqMv
                    ENDIF
                ENDIF
            ELSE
                *-- Prefixo curto (data ou HISTBAR): contador interno da sessao
                THIS.this_nSeqContador = THIS.this_nSeqContador + 1
                loc_nChave = THIS.this_nSeqContador
            ENDIF

        CATCH TO loc_oErro
            THIS.this_nSeqContador = THIS.this_nSeqContador + 1
            loc_nChave = THIS.this_nSeqContador
        ENDTRY

        RETURN loc_nChave
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera string ID unico para cIdChaves
    * Equivalente ao legado fUniqueIds()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIdUnico()
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1
        RETURN SYS(2015) + TRANSFORM(THIS.this_nSeqContador, "@L 99999")
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMascara - Formata numero como string mascarada
    * Equivalente ao legado fGerMascara()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarMascara(par_nNumero)
        RETURN ALLTRIM(TRANSFORM(par_nNumero, "@L 999999"))
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularPositivo - Recalcula posicao de estoque via stored procedure
    * Equivalente ao legado fRecalculaP por registro (SigOpClP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularPositivo(par_cEmps, par_cGrupos, par_cEstos, par_cCPros, par_cCodCors, par_cCodTams)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClP " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@Grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ", " + ;
                       "@Estos = " + EscaparSQL(ALLTRIM(par_cEstos)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ", " + ;
                       "@CodCors = " + EscaparSQL(ALLTRIM(par_cCodCors)) + ", " + ;
                       "@CodTams = " + EscaparSQL(ALLTRIM(par_cCodTams))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecP")
            IF USED("cursor_4c_ResRecP")
                USE IN cursor_4c_ResRecP
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular posi" + CHR(231) + CHR(227) + "o de estoque: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularCusto - Recalcula custo do produto via stored procedure
    * Equivalente ao legado fRecalculaC por registro (SigOpClC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularCusto(par_cEmps, par_cCPros)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClC " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecC")
            IF USED("cursor_4c_ResRecC")
                USE IN cursor_4c_ResRecC
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular custo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

