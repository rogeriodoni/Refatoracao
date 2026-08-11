# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '9' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CRSIGFIF

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = "crSigFiFis.hands"
  ControlSource = "crSigFiFis.settings"
  ControlSource = "crSigFiFis.dtrs"
  ControlSource = "crSigFiFis.rtss"
  ControlSource = "crSigFiFis.portas"
  ControlSource = "crSigFiFis.imps"
	Select crSigFiFis
Select CrSigFiFis

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFis.prg) - TRECHOS RELEVANTES PARA PASS SQL (1084 linhas total):

*-- Linhas 239 a 257:
239:             .SpinnerLowValue   = 1
240:             .ToolTipText       = "Escolher COM9 para setar USB"
241:             .Value             = 1
242:             .ControlSource     = "CrSigFiFis.Portas"
243:         ENDWITH
244: 
245:         *-- HandShaking
246:         THIS.AddObject("lbl_4c_Label2", "Label")
247:         WITH THIS.lbl_4c_Label2
248:             .FontName  = "Tahoma"
249:             .FontSize  = 8
250:             .ForeColor = RGB(90,90,90)
251:             .BackStyle = 0
252:             .AutoSize  = .F.
253:             .Left      = 124
254:             .Top       = 128
255:             .Width     = 75
256:             .Height    = 18
257:             .Caption   = "HandShaking : "

*-- Linhas 267 a 285:
267:             .Left          = 202
268:             .Top           = 123
269:             .Width         = 141
270:             .ControlSource = "CrSigFiFis.Hands"
271:         ENDWITH
272: 
273:         *-- Settings (ex: 9600,n,8,1)
274:         THIS.AddObject("lbl_4c_Label3", "Label")
275:         WITH THIS.lbl_4c_Label3
276:             .FontName  = "Tahoma"
277:             .FontSize  = 8
278:             .ForeColor = RGB(90,90,90)
279:             .BackStyle = 0
280:             .AutoSize  = .F.
281:             .Left      = 147
282:             .Top       = 153
283:             .Width     = 52
284:             .Height    = 18
285:             .Caption   = "Settings : "

*-- Linhas 295 a 313:
295:             .Width         = 141
296:             .Height        = 23
297:             .Value         = ""
298:             .ControlSource = "CrSigFiFis.Settings"
299:         ENDWITH
300: 
301:         *-- DTRenable
302:         THIS.AddObject("lbl_4c_Label4", "Label")
303:         WITH THIS.lbl_4c_Label4
304:             .FontName  = "Tahoma"
305:             .FontSize  = 8
306:             .ForeColor = RGB(90,90,90)
307:             .BackStyle = 0
308:             .AutoSize  = .F.
309:             .Left      = 134
310:             .Top       = 192
311:             .Width     = 65
312:             .Height    = 18
313:             .Caption   = "DTRenable : "

*-- Linhas 322 a 340:
322:             .BackStyle     = 0
323:             .Caption       = ""
324:             .Value         = 0
325:             .ControlSource = "CrSigFiFis.Dtrs"
326:         ENDWITH
327: 
328:         *-- RTSenable
329:         THIS.AddObject("lbl_4c_Label5", "Label")
330:         WITH THIS.lbl_4c_Label5
331:             .FontName  = "Tahoma"
332:             .FontSize  = 8
333:             .ForeColor = RGB(90,90,90)
334:             .BackStyle = 0
335:             .AutoSize  = .F.
336:             .Left      = 135
337:             .Top       = 212
338:             .Width     = 64
339:             .Height    = 18
340:             .Caption   = "RTSenable : "

*-- Linhas 349 a 367:
349:             .BackStyle     = 0
350:             .Caption       = ""
351:             .Value         = 0
352:             .ControlSource = "CrSigFiFis.Rtss"
353:         ENDWITH
354: 
355:         *-- Impressora
356:         THIS.AddObject("lbl_4c_Label6", "Label")
357:         WITH THIS.lbl_4c_Label6
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90,90,90)
361:             .BackStyle = 0
362:             .AutoSize  = .F.
363:             .Left      = 132
364:             .Top       = 236
365:             .Width     = 67
366:             .Height    = 18
367:             .Caption   = "Impressora : "

*-- Linhas 377 a 395:
377:             .Left          = 202
378:             .Top           = 231
379:             .Width         = 141
380:             .ControlSource = "CrSigFiFis.Imps"
381:         ENDWITH
382: 
383:         THIS.PopularComboBoxes()
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * PopularComboBoxes
388:     * Preenche itens dos ComboBoxes - identico ao legado
389:     *==========================================================================
390:     PROTECTED PROCEDURE PopularComboBoxes()
391:         WITH THIS.cbo_4c_CmbHand
392:             .Clear
393:             .AddItem("0-None    ")
394:             .AddItem("1-Xon Xoff")
395:             .AddItem("2-RTS     ")

*-- Linhas 417 a 461:
417:     * ??? nao ha Page1/Grid/lista de registros. Esta rotina mantem o papel
418:     * arquitetural de "visualizar registro corrente" resincronizando a UI com o
419:     * cursor CrSigFiFis (equivalente a "carregar lista" para 1 registro).
420:     * Rebinda ControlSources apos qualquer refresh do cursor.
421:     *==========================================================================
422:     PROTECTED PROCEDURE ConfigurarPaginaLista()
423:         LOCAL loc_lSucesso
424: 
425:         loc_lSucesso = .F.
426: 
427:         TRY
428:             IF !USED("CrSigFiFis")
429:                 THIS.this_oBusinessObject.InicializarCursor()
430:                 THIS.this_oBusinessObject.CarregarDeArquivo()
431:             ENDIF
432: 
433:             SELECT CrSigFiFis
434:             GO TOP
435: 
436:             IF EOF()
437:                 APPEND BLANK
438:             ENDIF
439: 
440:             *-- Rebinda ControlSources ao cursor atual
441:             THIS.obj_4c_Spinner1.ControlSource = "CrSigFiFis.Portas"
442:             THIS.cbo_4c_CmbHand.ControlSource  = "CrSigFiFis.Hands"
443:             THIS.txt_4c_Set.ControlSource      = "CrSigFiFis.Settings"
444:             THIS.chk_4c_ChkDtr.ControlSource   = "CrSigFiFis.Dtrs"
445:             THIS.chk_4c_ChkRts.ControlSource   = "CrSigFiFis.Rtss"
446:             THIS.cbo_4c_CmbImp.ControlSource   = "CrSigFiFis.Imps"
447: 
448:             *-- Forca refresh dos controles vinculados
449:             THIS.obj_4c_Spinner1.Refresh()
450:             THIS.cbo_4c_CmbHand.Refresh()
451:             THIS.txt_4c_Set.Refresh()
452:             THIS.chk_4c_ChkDtr.Refresh()
453:             THIS.chk_4c_ChkRts.Refresh()
454:             THIS.cbo_4c_CmbImp.Refresh()
455: 
456:             loc_lSucesso = .T.
457: 
458:         CATCH TO loc_oErro
459:             MsgErro(loc_oErro.Message + CHR(13) + ;
460:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
461:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 471 a 537:
471:     * Esta rotina mantem o papel arquitetural de "configurar area de edicao de
472:     * dados" delegando para os helpers ja construidos em ConfigurarCampos
473:     * (Spinner Portas, ComboBox HandShaking, TextBox Settings, CheckBox DTR/RTS
474:     * e ComboBox Impressora). Rebinda tambem os ControlSources para garantir
475:     * sincronia com o cursor CrSigFiFis apos qualquer refresh.
476:     *==========================================================================
477:     PROTECTED PROCEDURE ConfigurarPaginaDados()
478:         LOCAL loc_lSucesso
479: 
480:         loc_lSucesso = .F.
481: 
482:         TRY
483:             IF !USED("CrSigFiFis")
484:                 THIS.this_oBusinessObject.InicializarCursor()
485:                 THIS.this_oBusinessObject.CarregarDeArquivo()
486:             ENDIF
487: 
488:             SELECT CrSigFiFis
489:             GO TOP
490: 
491:             IF EOF()
492:                 APPEND BLANK
493:             ENDIF
494: 
495:             *-- Todos os campos: Porta, HandShaking, Settings, DTR, RTS, Impressora
496:             IF PEMSTATUS(THIS, "obj_4c_Spinner1", 5)
497:                 THIS.obj_4c_Spinner1.ControlSource = "CrSigFiFis.Portas"
498:                 THIS.obj_4c_Spinner1.Refresh()
499:             ENDIF
500: 
501:             IF PEMSTATUS(THIS, "cbo_4c_CmbHand", 5)
502:                 THIS.cbo_4c_CmbHand.ControlSource = "CrSigFiFis.Hands"
503:                 THIS.cbo_4c_CmbHand.Refresh()
504:             ENDIF
505: 
506:             IF PEMSTATUS(THIS, "txt_4c_Set", 5)
507:                 THIS.txt_4c_Set.ControlSource = "CrSigFiFis.Settings"
508:                 THIS.txt_4c_Set.Refresh()
509:             ENDIF
510: 
511:             IF PEMSTATUS(THIS, "chk_4c_ChkDtr", 5)
512:                 THIS.chk_4c_ChkDtr.ControlSource = "CrSigFiFis.Dtrs"
513:                 THIS.chk_4c_ChkDtr.Refresh()
514:             ENDIF
515: 
516:             IF PEMSTATUS(THIS, "chk_4c_ChkRts", 5)
517:                 THIS.chk_4c_ChkRts.ControlSource = "CrSigFiFis.Rtss"
518:                 THIS.chk_4c_ChkRts.Refresh()
519:             ENDIF
520: 
521:             IF PEMSTATUS(THIS, "cbo_4c_CmbImp", 5)
522:                 THIS.cbo_4c_CmbImp.ControlSource = "CrSigFiFis.Imps"
523:                 THIS.cbo_4c_CmbImp.Refresh()
524:             ENDIF
525: 
526:             loc_lSucesso = .T.
527: 
528:         CATCH TO loc_oErro
529:             MsgErro(loc_oErro.Message + CHR(13) + ;
530:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
531:                     "Procedure: " + loc_oErro.Procedure, ;
532:                     "Erro em FormFis.ConfigurarPaginaDados")
533:         ENDTRY
534: 
535:         RETURN loc_lSucesso
536:     ENDPROC
537: 

*-- Linhas 554 a 572:
554: 
555:         TRY
556:             IF USED("CrSigFiFis")
557:                 SELECT CrSigFiFis
558:                 GO TOP
559:             ENDIF
560: 
561:             IF PEMSTATUS(THIS, "obj_4c_Spinner1", 5)
562:                 THIS.obj_4c_Spinner1.SetFocus()
563:             ENDIF
564: 
565:         CATCH TO loc_oErro
566:             MsgErro(loc_oErro.Message + CHR(13) + ;
567:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
568:                     "Procedure: " + loc_oErro.Procedure, ;
569:                     "Erro em FormFis.AlternarPagina")
570:         ENDTRY
571:     ENDPROC
572: 

*-- Linhas 640 a 658:
640:                     THIS.this_oBusinessObject.InicializarCursor()
641:                 ENDIF
642: 
643:                 SELECT CrSigFiFis
644:                 ZAP
645:                 APPEND BLANK
646: 
647:                 REPLACE CrSigFiFis.Portas   WITH 1
648:                 REPLACE CrSigFiFis.Hands    WITH "Em Branco   "
649:                 REPLACE CrSigFiFis.Settings WITH "9600,n,8,1"
650:                 REPLACE CrSigFiFis.Dtrs     WITH .F.
651:                 REPLACE CrSigFiFis.Rtss     WITH .F.
652:                 REPLACE CrSigFiFis.Imps     WITH "Em Branco   "
653:                 REPLACE CrSigFiFis.Termicas WITH .F.
654: 
655:                 THIS.this_oBusinessObject.CarregarDoCursor("CrSigFiFis")
656: 
657:                 THIS.ConfigurarPaginaLista()
658: 

*-- Linhas 715 a 733:
715:                 THIS.this_oBusinessObject.CarregarDeArquivo()
716:             ENDIF
717: 
718:             SELECT CrSigFiFis
719:             GO TOP
720: 
721:             IF EOF()
722:                 MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o carregada.", ;
723:                          "Visualizar Configura" + CHR(231) + CHR(227) + "o")
724:             ELSE
725:                 loc_cImpr = ALLTRIM(NVL(CrSigFiFis.Imps, ""))
726:                 IF EMPTY(loc_cImpr)
727:                     loc_cImpr = "(n" + CHR(227) + "o definida)"
728:                 ENDIF
729: 
730:                 loc_cHand = ALLTRIM(NVL(CrSigFiFis.Hands, ""))
731:                 IF EMPTY(loc_cHand)
732:                     loc_cHand = "(n" + CHR(227) + "o definido)"
733:                 ENDIF

*-- Linhas 772 a 835:
772:                     THIS.this_oBusinessObject.InicializarCursor()
773:                 ENDIF
774: 
775:                 SELECT CrSigFiFis
776:                 ZAP
777:                 APPEND BLANK
778: 
779:                 REPLACE CrSigFiFis.Portas   WITH 1
780:                 REPLACE CrSigFiFis.Hands    WITH ""
781:                 REPLACE CrSigFiFis.Settings WITH ""
782:                 REPLACE CrSigFiFis.Dtrs     WITH .F.
783:                 REPLACE CrSigFiFis.Rtss     WITH .F.
784:                 REPLACE CrSigFiFis.Imps     WITH ""
785:                 REPLACE CrSigFiFis.Termicas WITH .F.
786: 
787:                 THIS.this_oBusinessObject.CarregarDoCursor("CrSigFiFis")
788: 
789:                 SELECT CrSigFiFis
790:                 GO TOP
791:                 COPY TO (THIS.this_oBusinessObject.this_cArqFiscal) TYPE SDF
792: 
793:                 *-- Recarrega defaults para exibir estado limpo consistente
794:                 THIS.this_oBusinessObject.CarregarDeArquivo()
795:                 THIS.ConfigurarPaginaLista()
796: 
797:                 MsgInfo("Configura" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da.", ;
798:                         "Excluir Configura" + CHR(231) + CHR(227) + "o")
799:             ENDIF
800: 
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message + CHR(13) + ;
803:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
804:                     "Procedure: " + loc_oErro.Procedure, ;
805:                     "Erro em FormFis.BtnExcluirClick")
806:         ENDTRY
807:     ENDPROC
808: 
809:     *==========================================================================
810:     * FormParaBO
811:     * Transfere valores do cursor CrSigFiFis para as propriedades do BO.
812:     * Os controles tem ControlSource apontando para o cursor, portanto
813:     * o cursor ja reflete o que o usuario editou; sincronizamos as props.
814:     *==========================================================================
815:     PROCEDURE FormParaBO()
816:         LOCAL loc_oErro
817: 
818:         TRY
819:             IF USED("CrSigFiFis")
820:                 SELECT CrSigFiFis
821:                 GO TOP
822: 
823:                 THIS.this_oBusinessObject.this_nPorta      = NVL(CrSigFiFis.Portas,   1)
824:                 THIS.this_oBusinessObject.this_cHandshaking = ALLTRIM(NVL(CrSigFiFis.Hands,    ""))
825:                 THIS.this_oBusinessObject.this_cSettings    = ALLTRIM(NVL(CrSigFiFis.Settings, ""))
826:                 THIS.this_oBusinessObject.this_lDtr         = NVL(CrSigFiFis.Dtrs,     .F.)
827:                 THIS.this_oBusinessObject.this_lRts         = NVL(CrSigFiFis.Rtss,     .F.)
828:                 THIS.this_oBusinessObject.this_cImpressora  = ALLTRIM(NVL(CrSigFiFis.Imps,     ""))
829:                 THIS.this_oBusinessObject.this_lTermica     = NVL(CrSigFiFis.Termicas, .F.)
830:             ENDIF
831: 
832:         CATCH TO loc_oErro
833:             MsgErro(loc_oErro.Message + CHR(13) + ;
834:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
835:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 849 a 867:
849:                 THIS.this_oBusinessObject.InicializarCursor()
850:             ENDIF
851: 
852:             SELECT CrSigFiFis
853:             GO TOP
854: 
855:             IF EOF()
856:                 APPEND BLANK
857:             ENDIF
858: 
859:             REPLACE CrSigFiFis.Portas   WITH THIS.this_oBusinessObject.this_nPorta
860:             REPLACE CrSigFiFis.Hands    WITH THIS.this_oBusinessObject.this_cHandshaking
861:             REPLACE CrSigFiFis.Settings WITH THIS.this_oBusinessObject.this_cSettings
862:             REPLACE CrSigFiFis.Dtrs     WITH THIS.this_oBusinessObject.this_lDtr
863:             REPLACE CrSigFiFis.Rtss     WITH THIS.this_oBusinessObject.this_lRts
864:             REPLACE CrSigFiFis.Imps     WITH THIS.this_oBusinessObject.this_cImpressora
865:             REPLACE CrSigFiFis.Termicas WITH THIS.this_oBusinessObject.this_lTermica
866: 
867:             IF PEMSTATUS(THIS, "obj_4c_Spinner1", 5)

*-- Linhas 944 a 962:
944:                 THIS.this_oBusinessObject.InicializarCursor()
945:             ENDIF
946: 
947:             SELECT CrSigFiFis
948:             GO TOP
949: 
950:             IF EOF()
951:                 APPEND BLANK
952:             ENDIF
953: 
954:             REPLACE CrSigFiFis.Portas   WITH 1
955:             REPLACE CrSigFiFis.Hands    WITH "Em Branco   "
956:             REPLACE CrSigFiFis.Settings WITH ""
957:             REPLACE CrSigFiFis.Dtrs     WITH .F.
958:             REPLACE CrSigFiFis.Rtss     WITH .F.
959:             REPLACE CrSigFiFis.Imps     WITH "Em Branco   "
960:             REPLACE CrSigFiFis.Termicas WITH .F.
961: 
962:             IF PEMSTATUS(THIS, "obj_4c_Spinner1", 5)


### BO (C:\4c\projeto\app\classes\FisBO.prg):
*============================================================================
* FisBO.prg - Business Object para Configura" + CHR(231) + CHR(227) + "o de Impressora Fiscal
* Entidade  : Fis  (SIGCDFIS)
* Origem    : SigCdFis.SCX
* Arquitetura: BusinessBase sem tabela SQL - persiste em arquivo local SetFiscal.Ini
*============================================================================

DEFINE CLASS FisBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da "tabela" - form nao tem tabela SQL Server
    *--------------------------------------------------------------------------
    this_cTabela     = ""
    this_cCampoChave = ""

    *--------------------------------------------------------------------------
    * Propriedades - campos do cursor CrSigFiFis
    * CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)
    *--------------------------------------------------------------------------
    this_nPorta       = 1     && Porta de comunica" + CHR(231) + CHR(227) + "o COM (1-10; valor 9 = USB)
    this_cHandshaking = ""    && Tipo de HandShaking (c20): "0-None", "1-Xon Xoff", "2-RTS", ""
    this_cSettings    = ""    && Par" + CHR(226) + "metros seriais (c20): ex. "9600,n,8,1"
    this_lDtr         = .F.   && DTR enable
    this_lRts         = .F.   && RTS enable
    this_cImpressora  = ""    && Modelo de impressora fiscal (c20)
    this_lTermica     = .F.   && Impressora t" + CHR(233) + "rmica

    *--------------------------------------------------------------------------
    * Propriedades auxiliares de controle de arquivo
    *--------------------------------------------------------------------------
    this_cArqFiscal   = ""    && Path completo de SetFiscal.Ini (SYS(5)+SYS(2003)+\SetFiscal.Ini)
    this_cArqBema     = ""    && Path de BEMAFI32.INI (%SystemRoot%\system32\BEMAFI32.INI)
    this_cArqDaruma   = ""    && Path de DarumaFramework.xml (SYS(5)+SYS(2003)+\DarumaFramework.xml)

    *==========================================================================
    * Init
    * Configura BO sem tabela SQL. Resolve paths dos arquivos de configuracao.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""

            *-- Paths dos arquivos de configuracao fiscal
            this_cArqFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
            this_cArqBema   = GETENV("SystemRoot") + "\system32\BEMAFI32.INI"
            this_cArqDaruma = SYS(5) + SYS(2003) + "\DarumaFramework.xml"

            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarCursor
    * Cria cursor CrSigFiFis com estrutura identica ao legado (Load event)
    *==========================================================================
    PROCEDURE InicializarCursor()
        LOCAL loc_lSucesso

        TRY
            IF USED("CrSigFiFis")
                USE IN CrSigFiFis
            ENDIF

            CREATE CURSOR CrSigFiFis (Portas n(1), Hands c(20), Settings c(20), Dtrs L, Rtss L, Imps c(20), Termicas L)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.InicializarCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDeArquivo
    * Equivalente a fLerFiscal() do legado.
    * Le SetFiscal.Ini e popula cursor CrSigFiFis com valores default.
    *==========================================================================
    PROCEDURE CarregarDeArquivo()
        LOCAL loc_lSucesso

        TRY
            IF !USED("CrSigFiFis")
                THIS.InicializarCursor()
            ENDIF

            SELECT CrSigFiFis
            ZAP

            IF FILE(THIS.this_cArqFiscal)
                APPEND FROM (THIS.this_cArqFiscal) TYPE SDF
            ENDIF

            SELECT CrSigFiFis
            GO TOP

            IF EOF()
                APPEND BLANK
            ENDIF

            IF EMPTY(CrSigFiFis.Settings)
                REPLACE CrSigFiFis.Settings WITH "9600,n,8,1"
            ENDIF

            IF ALLTRIM(CrSigFiFis.Imps) = ""
                REPLACE CrSigFiFis.Imps WITH "Em Branco   "
            ENDIF

            IF ALLTRIM(CrSigFiFis.Hands) = ""
                REPLACE CrSigFiFis.Hands WITH "Em Branco   "
            ENDIF

            THIS.CarregarDoCursor("CrSigFiFis")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDeArquivo")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor
    * Mapeia campos do cursor CrSigFiFis para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nPorta       = NVL(Portas,   1)
                THIS.this_cHandshaking = ALLTRIM(NVL(Hands,    ""))
                THIS.this_cSettings    = ALLTRIM(NVL(Settings, ""))
                THIS.this_lDtr         = NVL(Dtrs,     .F.)
                THIS.this_lRts         = NVL(Rtss,     .F.)
                THIS.this_cImpressora  = ALLTRIM(NVL(Imps,     ""))
                THIS.this_lTermica     = NVL(Termicas, .F.)
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarConfiguracao
    * Persiste configuracao em SetFiscal.Ini, BEMAFI32.INI e DarumaFramework.xml.
    * Equivalente ao Ok.Click do legado.
    *==========================================================================
    PROCEDURE SalvarConfiguracao()
        LOCAL loc_lSucesso, loc_cConfig, loc_cComs, loc_cNewCon, loc_cPor, loc_cVel

        TRY
            IF !USED("CrSigFiFis")
                MsgErro("Cursor CrSigFiFis n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarConfiguracao")
                loc_lSucesso = .F.
            ELSE
                SELECT CrSigFiFis
                GO TOP

                *-- Normalizar "Em Branco" para vazio antes de gravar no arquivo
                IF ALLTRIM(CrSigFiFis.Imps) = "Em Branco"
                    REPLACE CrSigFiFis.Imps WITH ""
                ENDIF

                IF ALLTRIM(CrSigFiFis.Hands) = "Em Branco"
                    REPLACE CrSigFiFis.Hands WITH ""
                ENDIF

                *-- Gravar SetFiscal.Ini via SDF (formato de campo fixo)
                SELECT CrSigFiFis
                GO TOP
                COPY TO (THIS.this_cArqFiscal) TYPE SDF

                *-- Atualizar porta em BEMAFI32.INI (Bematech)
                IF FILE(THIS.this_cArqBema)
                    loc_cConfig = FILETOSTR(THIS.this_cArqBema)
                    loc_cComs   = STREXTRACT(loc_cConfig, "Porta", CHR(13) + CHR(10), 1, 1)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))
                    IF loc_cPor = "9"
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=USB", -1, 1, 1)
                    ELSE
                        loc_cNewCon = STRTRAN(loc_cConfig, "Porta" + loc_cComs, "Porta=COM" + loc_cPor, -1, 1, 1)
                    ENDIF
                    STRTOFILE(loc_cNewCon, THIS.this_cArqBema)
                ENDIF

                *-- Atualizar porta e velocidade em DarumaFramework.xml (Daruma)
                IF FILE(THIS.this_cArqDaruma)
                    loc_cConfig = FILETOSTR(THIS.this_cArqDaruma)
                    loc_cPor    = ALLTRIM(TRANSFORM(THIS.this_nPorta))

                    *-- Atualizar PortaSerial
                    loc_cComs   = STREXTRACT(loc_cConfig, "<PortaSerial>", CHR(13) + CHR(10), 1, 1)
                    loc_cNewCon = STRTRAN(loc_cConfig, "<PortaSerial>" + loc_cComs, ;
                                  "<PortaSerial>COM" + loc_cPor + "</PortaSerial>", -1, 1, 1)

                    *-- Atualizar Velocidade (primeiro campo antes da virgula em Settings)
                    SELECT CrSigFiFis
                    GO TOP
                    IF AT(",", ALLTRIM(CrSigFiFis.Settings)) > 0
                        loc_cVel = SUBSTR(ALLTRIM(CrSigFiFis.Settings), 1, ;
                                   AT(",", ALLTRIM(CrSigFiFis.Settings)) - 1)
                    ELSE
                        loc_cVel = "9600"
                    ENDIF
                    loc_cComs   = STREXTRACT(loc_cNewCon, "<Velocidade>", CHR(13) + CHR(10), 2, 1)
                    loc_cNewCon = STRTRAN(loc_cNewCon, "<Velocidade>" + loc_cComs, ;
                                  "<Velocidade>" + loc_cVel + "</Velocidade>", -1, 1, 1)

                    STRTOFILE(loc_cNewCon, THIS.this_cArqDaruma)
                ENDIF

                *-- Recarregar propriedades do BO apos normalizar
                THIS.CarregarDoCursor("CrSigFiFis")

                THIS.CarregarProcedureFiscal(THIS.this_cImpressora)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.SalvarConfiguracao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarProcedureFiscal
    * Libera procedure fiscal anterior e carrega nova conforme modelo de impressora.
    * Equivalente ao DO CASE de SET PROCEDURE no Ok.Click do legado.
    *==========================================================================
    PROCEDURE CarregarProcedureFiscal(par_cImpressora)
        LOCAL loc_lSucesso

        TRY
            *-- Liberar procedure fiscal previamente carregada
            DO CASE
                CASE ATC("SIGFIOP5", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP5.Prg
                CASE ATC("SIGFIOP4", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP4.Prg
                CASE ATC("SIGFIOP3", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP3.Prg
                CASE ATC("SIGFIOP0", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP0.Prg
                CASE ATC("SIGFIOP2", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP2.Prg
                CASE ATC("SIGFIOP1", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP1.Prg
                CASE ATC("SIGFIOP8", UPPER(SET("PROCEDURE"))) <> 0
                    RELEASE PROCEDURE SIGFIOP8.Prg
            ENDCASE

            *-- Carregar procedure correspondente ao modelo
            DO CASE
                CASE ALLTRIM(par_cImpressora) == "SWEDA"
                    SET PROCEDURE TO SIGFIOP0.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMATECH"
                    SET PROCEDURE TO SIGFIOP1.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "BEMA8501"
                    SET PROCEDURE TO SIGFIOP2.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DATAREGIS"
                    SET PROCEDURE TO SIGFIOP3.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NDATAREGIS"
                    SET PROCEDURE TO SIGFIOP4.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "DARUMA"
                    SET PROCEDURE TO SIGFIOP5.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "S/IMPRESSORA"
                    SET PROCEDURE TO SIGFIOP9.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "NSWEDA"
                    SET PROCEDURE TO SIGFIOP8.Prg ADDITIVE
                CASE ALLTRIM(par_cImpressora) == "EPSON"
                    SET PROCEDURE TO SIGFIOP7.Prg ADDITIVE
            ENDCASE

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FisBO.CarregarProcedureFiscal")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria
    * Form nao possui tabela SQL - retorna vazio
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir / Atualizar
    * Form nao usa SQL - delegam para SalvarConfiguracao
    *==========================================================================
    PROCEDURE Inserir()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

    PROCEDURE Atualizar()
        RETURN THIS.SalvarConfiguracao()
    ENDPROC

ENDDEFINE

