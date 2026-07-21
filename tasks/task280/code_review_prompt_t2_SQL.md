# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Select 1 as Selecionada, * from crTprMvCab into cursor crOperacoes readwrite
ThisForm.get_Operacao.ControlSource = [crOperacoes.Dopes] 
ThisForm.get_Numes.ControlSource = [crOperacoes.Numes] 
	.DeleteMark   	   = .f.
	.Column1.ControlSource 	 = [crOperacoes.Selecionada]
	.Column2.ControlSource   = [crOperacoes.Datas]
	.Column3.ControlSource   = [crOperacoes.Emps]
	.Column4.ControlSource   = [crOperacoes.PrazoEnts]
	.Column5.ControlSource   = [crOperacoes.Contas]
	.Column6.ControlSource   = [crOperacoes.RClis]
	.Column7.ControlSource   = [crOperacoes.Conjuges]
	Select crOperacoes
Select crOperacoes
Select crOperacoes
		Insert into crFilOper Values(Padr(crOperacoes.Emps,3)+Padr(crOperacoes.Dopes,20)+Padl(Str(crOperacoes.Numes,6),6))

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg) - TRECHOS RELEVANTES PARA PASS SQL (873 linhas total):

*-- Linhas 187 a 205:
187:             .BackStyle     = 1
188:             .BorderStyle   = 1
189:             .Value         = ""
190:             .ControlSource = "cursor_4c_Operacoes.Dopes"
191:             .Format        = "K!"
192:             .Height        = 25
193:             .MaxLength     = 40
194:             .SpecialEffect = 0
195:             .Left          = 87
196:             .Top           = 398
197:             .Width         = 150
198:             .ForeColor     = RGB(0,0,0)
199:             .BackColor     = RGB(255,255,255)
200:             .ReadOnly      = .T.
201:         ENDWITH
202: 
203:         THIS.AddObject("lbl_4c_Label1", "Label")
204:         WITH THIS.lbl_4c_Label1
205:             .AutoSize  = .T.

*-- Linhas 222 a 263:
222:             .BackStyle     = 1
223:             .BorderStyle   = 1
224:             .Value         = 0
225:             .ControlSource = "cursor_4c_Operacoes.Numes"
226:             .Height        = 25
227:             .SpecialEffect = 0
228:             .Left          = 276
229:             .Top           = 398
230:             .Width         = 50
231:             .ForeColor     = RGB(0,0,0)
232:             .BackColor     = RGB(255,255,255)
233:             .ReadOnly      = .T.
234:         ENDWITH
235:     ENDPROC
236: 
237:     *--------------------------------------------------------------------------
238:     * AlternarPagina - Refresh do popup: vai ao topo do cursor e sincroniza grid
239:     * e textboxes de status. Parametro par_nPagina aceito para compatibilidade
240:     * com o contrato de forms CRUD; qualquer valor invoca o mesmo refresh.
241:     *--------------------------------------------------------------------------
242:     PROCEDURE AlternarPagina(par_nPagina)
243:         LOCAL loc_lTemDados
244:         loc_lTemDados = USED("cursor_4c_Operacoes") ;
245:                         AND RECCOUNT("cursor_4c_Operacoes") > 0
246: 
247:         IF loc_lTemDados
248:             SELECT cursor_4c_Operacoes
249:             GO TOP IN cursor_4c_Operacoes
250:         ENDIF
251: 
252:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
253:             THIS.grd_4c_Dados.Refresh()
254:             IF loc_lTemDados
255:                 THIS.grd_4c_Dados.SetFocus()
256:             ENDIF
257:         ENDIF
258: 
259:         IF VARTYPE(THIS.txt_4c_Operacao) = "O"
260:             THIS.txt_4c_Operacao.Refresh()
261:         ENDIF
262: 
263:         IF VARTYPE(THIS.txt_4c_Numes) = "O"

*-- Linhas 381 a 562:
381:     * ConfigurarGrade - Grid de selecao de operacoes (grdOperacoes do legado)
382:     * 7 colunas: selecao (checkbox), data, empresa, prev. entrega, cliente, nome, conjugue
383:     * Regras criticas: AddObject chk_4c_Check1 ANTES de CurrentControl,
384:     *   CurrentControl ANTES de ControlSource, Sparse=.F. obrigatorio.
385:     *--------------------------------------------------------------------------
386:     PROTECTED PROCEDURE ConfigurarGrade()
387:         THIS.AddObject("grd_4c_Dados", "Grid")
388:         WITH THIS.grd_4c_Dados
389:             .Top               = 121
390:             .Left              = 3
391:             .Width             = 732
392:             .Height            = 275
393:             .ColumnCount       = 7
394:             .FontName          = "Tahoma"
395:             .DeleteMark        = .F.
396:             .RecordMark        = .F.
397:             .ScrollBars        = 2
398:             .HeaderHeight      = 19
399:             .ReadOnly          = .F.
400:             .AllowHeaderSizing = .F.
401:             .AllowRowSizing    = .F.
402:             .GridLineColor     = RGB(238,238,238)
403: 
404:             WITH .Column1
405:                 .Width     = 15
406:                 .Movable   = .F.
407:                 .Resizable = .F.
408:                 .ReadOnly  = .F.
409:                 .Sparse    = .F.
410:                 .AddObject("chk_4c_Check1", "CheckBox")
411:                 WITH .chk_4c_Check1
412:                     .Caption  = ""
413:                     .Value    = 0
414:                     .AutoSize = .T.
415:                 ENDWITH
416:                 .CurrentControl    = "chk_4c_Check1"
417:                 .ControlSource     = "cursor_4c_Operacoes.Selecionada"
418:                 .Header1.Caption   = ""
419:                 .Header1.Alignment = 2
420:                 .Header1.ForeColor = RGB(90,90,90)
421:                 .Header1.FontName  = "Tahoma"
422:                 .Header1.FontSize  = 8
423:             ENDWITH
424: 
425:             WITH .Column2
426:                 .Width             = 80
427:                 .Movable           = .F.
428:                 .Resizable         = .F.
429:                 .ReadOnly          = .T.
430:                 .FontName          = "Tahoma"
431:                 .ControlSource     = "cursor_4c_Operacoes.Datas"
432:                 .Header1.Caption   = "Data"
433:                 .Header1.Alignment = 2
434:                 .Header1.ForeColor = RGB(90,90,90)
435:                 .Header1.FontName  = "Tahoma"
436:                 .Header1.FontSize  = 8
437:             ENDWITH
438: 
439:             WITH .Column3
440:                 .Width             = 35
441:                 .Movable           = .F.
442:                 .Resizable         = .F.
443:                 .ReadOnly          = .T.
444:                 .FontName          = "Tahoma"
445:                 .ControlSource     = "cursor_4c_Operacoes.Emps"
446:                 .Header1.Caption   = "Emp"
447:                 .Header1.Alignment = 2
448:                 .Header1.ForeColor = RGB(90,90,90)
449:                 .Header1.FontName  = "Tahoma"
450:                 .Header1.FontSize  = 8
451:             ENDWITH
452: 
453:             WITH .Column4
454:                 .Width             = 80
455:                 .Movable           = .F.
456:                 .Resizable         = .F.
457:                 .ReadOnly          = .T.
458:                 .FontName          = "Tahoma"
459:                 .ControlSource     = "cursor_4c_Operacoes.PrazoEnts"
460:                 .Header1.Caption   = THIS.this_cCabData
461:                 .Header1.Alignment = 2
462:                 .Header1.ForeColor = RGB(90,90,90)
463:                 .Header1.FontName  = "Tahoma"
464:                 .Header1.FontSize  = 8
465:             ENDWITH
466: 
467:             WITH .Column5
468:                 .Width             = 80
469:                 .Movable           = .F.
470:                 .Resizable         = .F.
471:                 .ReadOnly          = .T.
472:                 .FontName          = "Tahoma"
473:                 .ControlSource     = "cursor_4c_Operacoes.Contas"
474:                 .Header1.Caption   = "Cliente"
475:                 .Header1.Alignment = 2
476:                 .Header1.ForeColor = RGB(90,90,90)
477:                 .Header1.FontName  = "Tahoma"
478:                 .Header1.FontSize  = 8
479:             ENDWITH
480: 
481:             WITH .Column6
482:                 .Width             = 200
483:                 .Movable           = .F.
484:                 .Resizable         = .F.
485:                 .ReadOnly          = .T.
486:                 .FontName          = "Tahoma"
487:                 .ControlSource     = "cursor_4c_Operacoes.RClis"
488:                 .Header1.Caption   = "Nome do Cliente"
489:                 .Header1.Alignment = 2
490:                 .Header1.ForeColor = RGB(90,90,90)
491:                 .Header1.FontName  = "Tahoma"
492:                 .Header1.FontSize  = 8
493:             ENDWITH
494: 
495:             WITH .Column7
496:                 .Width             = 205
497:                 .Movable           = .F.
498:                 .Resizable         = .F.
499:                 .ReadOnly          = .T.
500:                 .FontName          = "Tahoma"
501:                 .FontSize          = 9
502:                 .ControlSource     = "cursor_4c_Operacoes.Conjuges"
503:                 .Header1.Caption   = "Conjug" + CHR(233)
504:                 .Header1.Alignment = 2
505:                 .Header1.ForeColor = RGB(90,90,90)
506:                 .Header1.FontName  = "Tahoma"
507:                 .Header1.FontSize  = 8
508:             ENDWITH
509: 
510:             .RecordSource = "cursor_4c_Operacoes"
511:             *-- Re-definir ControlSource apos RecordSource (VFP auto-bind por ordem de campo quebra bindings anteriores)
512:             .Column1.ControlSource = "cursor_4c_Operacoes.Selecionada"
513:             .Column2.ControlSource = "cursor_4c_Operacoes.Datas"
514:             .Column3.ControlSource = "cursor_4c_Operacoes.Emps"
515:             .Column4.ControlSource = "cursor_4c_Operacoes.PrazoEnts"
516:             .Column5.ControlSource = "cursor_4c_Operacoes.Contas"
517:             .Column6.ControlSource = "cursor_4c_Operacoes.RClis"
518:             .Column7.ControlSource = "cursor_4c_Operacoes.Conjuges"
519:         ENDWITH
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     * GrdAfterRowColChange - Atualiza textboxes de status ao navegar no grid
524:     * (equivalente ao grdOperacoes.AfterRowColChange do legado)
525:     *--------------------------------------------------------------------------
526:     PROCEDURE GrdAfterRowColChange
527:         LPARAMETERS par_nColIndex
528:         IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
529:             THIS.txt_4c_Operacao.Refresh()
530:             THIS.txt_4c_Numes.Refresh()
531:         ENDIF
532:     ENDPROC
533: 
534:     *--------------------------------------------------------------------------
535:     * ChkSelecaoClick - Refresca grid apos toggle automatico via ControlSource
536:     * Cursor ja foi atualizado pelo binding antes de Click disparar
537:     *--------------------------------------------------------------------------
538:     PROCEDURE ChkSelecaoClick
539:         IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
540:             THIS.grd_4c_Dados.Refresh()
541:         ENDIF
542:     ENDPROC
543: 
544:     *--------------------------------------------------------------------------
545:     * ChkSelecaoKeyPress - Inverte selecao ao pressionar ENTER ou SPACE
546:     * Original: InList(nKeyCode, 13, 32) -> GATHER MEMVAR Fields Selecionada
547:     * ENTER e SPACE ambos alternam; ControlSource nao suprime default, por isso
548:     * usamos AlternarSelecao (toggle via GATHER MEMVAR como o legado) para ambos.
549:     *--------------------------------------------------------------------------
550:     PROCEDURE ChkSelecaoKeyPress
551:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
552:         IF INLIST(par_nKeyCode, 13, 32)
553:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
554:                 THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
555:                 THIS.grd_4c_Dados.Refresh()
556:             ENDIF
557:         ENDIF
558:     ENDPROC
559: 
560:     *--------------------------------------------------------------------------
561:     * ChkMarcaClick - Marca ou desmarca todas as operacoes (ck_Marca do legado)
562:     * Value ja esta no novo estado (VFP9 togglou antes de Click disparar)

*-- Linhas 659 a 677:
659:                         CHR(231) + CHR(245) + "es para visualizar.", "Aviso")
660:                 RETURN
661:             ENDIF
662:             SELECT cursor_4c_Operacoes
663:             GO TOP IN cursor_4c_Operacoes
664:             THIS.grd_4c_Dados.Refresh()
665:             THIS.grd_4c_Dados.SetFocus()
666:             THIS.txt_4c_Operacao.Refresh()
667:             THIS.txt_4c_Numes.Refresh()
668:         CATCH TO loc_oErro
669:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
670:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
671:         ENDTRY
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * BtnExcluirClick - Popup OPERACIONAL: mapeia p/ excluir todas da selecao
676:     * Legado SIGPREOP nao tem botao Excluir - contrato do pipeline exige metodo.
677:     * Semantica: remove todas as operacoes da selecao (desmarca Selecionada=0).

*-- Linhas 714 a 732:
714:         loc_lSucesso = .F.
715:         TRY
716:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
717:                 SELECT cursor_4c_Operacoes
718:                 GO TOP
719:             ENDIF
720:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
721:                 THIS.grd_4c_Dados.Refresh()
722:             ENDIF
723:             IF VARTYPE(THIS.txt_4c_Operacao) = "O"
724:                 THIS.txt_4c_Operacao.Refresh()
725:             ENDIF
726:             IF VARTYPE(THIS.txt_4c_Numes) = "O"
727:                 THIS.txt_4c_Numes.Refresh()
728:             ENDIF
729:             loc_lSucesso = .T.
730:         CATCH TO loc_oErro
731:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
732:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista")

*-- Linhas 791 a 809:
791: 
792:     *--------------------------------------------------------------------------
793:     * BOParaForm - Refresca controles de status com dados da linha corrente
794:     * OPERACIONAL: ControlSource ja faz binding; apenas refresca displays
795:     *--------------------------------------------------------------------------
796:     PROCEDURE BOParaForm()
797:         IF VARTYPE(THIS.txt_4c_Operacao) = "O"
798:             THIS.txt_4c_Operacao.Refresh()
799:         ENDIF
800:         IF VARTYPE(THIS.txt_4c_Numes) = "O"
801:             THIS.txt_4c_Numes.Refresh()
802:         ENDIF
803:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
804:             THIS.grd_4c_Dados.Refresh()
805:         ENDIF
806:     ENDPROC
807: 
808:     *--------------------------------------------------------------------------
809:     * HabilitarCampos - Controla habilitacao de controles interativos


### BO (C:\4c\projeto\app\classes\SigPrEopBO.prg):
*==============================================================================
* SigPrEopBO.prg - Business Object: Selecao de Operacoes
* Entidade  : SigPrEop
* Tabela    : (sem tabela propria - opera com cursores temporarios)
* Tipo      : OPERACIONAL (seletor de operacoes)
*==============================================================================
DEFINE CLASS SigPrEopBO AS BusinessBase

    *-- Operacao selecionada (linha corrente no grid)
    this_cDopes      = ""  && Codigo da operacao (20 chars)
    this_nNumes      = 0   && Numero da operacao
    this_dDatas      = {}  && Data da operacao
    this_dPrazoEnts  = {}  && Previsao de entrega
    this_cEmps       = ""  && Codigo da empresa (3 chars)
    this_cContas     = ""  && Conta / numero do pedido
    this_cRClis      = ""  && Nome do cliente
    this_cConjuges   = ""  && Operacao conjugada
    this_nSelecionada = 0  && Flag de selecao (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Selecao de Operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de linha do cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nSelecionada = NVL(Selecionada, 0)
            THIS.this_cDopes       = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes       = NVL(Numes, 0)
            THIS.this_dDatas       = NVL(Datas, {})
            THIS.this_dPrazoEnts   = NVL(PrazoEnts, {})
            THIS.this_cEmps        = ALLTRIM(NVL(Emps, ""))
            THIS.this_cContas      = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRClis       = ALLTRIM(NVL(RClis, ""))
            THIS.this_cConjuges    = ALLTRIM(NVL(Conjuges, ""))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarOperacoes - Cria cursor_4c_Operacoes a partir do cursor de origem
    * par_cCursorOrigem: nome do cursor com operacoes pre-carregadas (crTprMvCab)
    *--------------------------------------------------------------------------
    PROCEDURE InicializarOperacoes(par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            IF USED(par_cCursorOrigem)
                SELECT 1 AS Selecionada, * FROM (par_cCursorOrigem) ;
                    INTO CURSOR cursor_4c_Operacoes READWRITE
                loc_lSucesso = .T.
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Operacoes ;
                    (Selecionada N(1,0) NULL, ;
                     Emps        C(3)   NULL, ;
                     Dopes       C(20)  NULL, ;
                     Numes       N(6,0) NULL, ;
                     Datas       D      NULL, ;
                     PrazoEnts   D      NULL, ;
                     Contas      C(20)  NULL, ;
                     RClis       C(60)  NULL, ;
                     Conjuges    C(20)  NULL)
                SET NULL OFF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarSelecao - Inverte o flag Selecionada da linha corrente do cursor
    * Equivalente ao GATHER MEMVAR do legado (Check1 KeyPress + MouseDown)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarSelecao(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_nNovoValor, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias) AND !EOF(loc_cAlias)
                SELECT (loc_cAlias)
                loc_nNovoValor = IIF(Selecionada = 0, 1, 0)
                REPLACE Selecionada WITH loc_nNovoValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarDesmarcarTodos - Marca ou desmarca todas as operacoes
    * par_nValor: 1 = marcar todos, 0 = desmarcar todos (equivale a ck_Marca.Click)
    * par_cAliasCursor: alias do cursor (padrao: cursor_4c_Operacoes)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarDesmarcarTodos(par_nValor, par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Operacoes", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                REPLACE ALL Selecionada WITH par_nValor
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularFilOper - Varre cursor de operacoes e popula cursor destino
    * com as operacoes selecionadas (Selecionada = 1)
    * Equivalente ao SCAN em cmdSair.Click do legado
    * par_cCursorDest  : nome do cursor destino (crFilOper no legado)
    * par_cCursorOrigem: cursor fonte (padrao: cursor_4c_Operacoes)
    * Formato de cada registro: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE PopularFilOper(par_cCursorDest, par_cCursorOrigem)
        LOCAL loc_lSucesso, loc_oErro, loc_cAlias, loc_cChave
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cCursorOrigem), "cursor_4c_Operacoes", par_cCursorOrigem)
        TRY
            IF USED(loc_cAlias) AND USED(par_cCursorDest)
                ZAP IN (par_cCursorDest)
                SELECT (loc_cAlias)
                GO TOP
                SCAN
                    IF Selecionada = 1
                        loc_cChave = PADR(Emps, 3) + PADR(Dopes, 20) + PADL(STR(Numes, 6), 6)
                        INSERT INTO (par_cCursorDest) VALUES (loc_cChave)
                    ENDIF
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta da operacao corrente
    * Formato: Emps(3) + Dopes(20) + Numes(6) = 29 chars
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + PADL(STR(THIS.this_nNumes, 6), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra as operacoes selecionadas no cursor destino (crFilOper)
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao SCAN em cmdSair.Click do legado que popula crFilOper com
    * as operacoes marcadas (Selecionada = 1) e serve de filtro para o form pai.
    * Requer THIS.this_cCursorDestino previamente configurado (default: crFilOper).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cCursorDest, loc_nRegistros, loc_lContinua
        loc_lSucesso    = .F.
        loc_lContinua   = .T.
        loc_nRegistros  = 0
        loc_cCursorDest = IIF(PEMSTATUS(THIS, "this_cCursorDestino", 5) AND ;
                              !EMPTY(THIS.this_cCursorDestino), ;
                              THIS.this_cCursorDestino, "crFilOper")

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !USED(loc_cCursorDest)
                THIS.this_cMensagemErro = "Cursor destino '" + loc_cCursorDest + ;
                    "' n" + CHR(227) + "o encontrado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua AND !THIS.PopularFilOper(loc_cCursorDest, "cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Falha ao popular cursor destino"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT (loc_cCursorDest)
                GO TOP
                COUNT TO loc_nRegistros

                IF loc_nRegistros = 0
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o foi selecionada"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                THIS.RegistrarAuditoria("SELECT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o estado de selecao da operacao corrente no cursor
    * BO OPERACIONAL de selecao: nao persiste em tabela SQL Server.
    * Equivalente ao GATHER MEMVAR Fields Selecionada do Check1 (KeyPress/MouseDown).
    * Usa this_nSelecionada (definido via CarregarDoCursor ou setter externo)
    * para atualizar o registro corrente do cursor de operacoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_lContinua
        loc_lSucesso  = .F.
        loc_lContinua = .T.

        TRY
            IF !USED("cursor_4c_Operacoes")
                THIS.this_cMensagemErro = "Cursor de opera" + CHR(231) + CHR(245) + ;
                    "es n" + CHR(227) + "o inicializado"
                loc_lContinua = .F.
            ENDIF

            IF loc_lContinua
                SELECT cursor_4c_Operacoes
                IF EOF() OR BOF()
                    THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + ;
                        "o corrente para atualizar"
                    loc_lContinua = .F.
                ENDIF
            ENDIF

            IF loc_lContinua
                REPLACE Selecionada  WITH THIS.this_nSelecionada, ;
                        Emps         WITH THIS.this_cEmps, ;
                        Dopes        WITH THIS.this_cDopes, ;
                        Numes        WITH THIS.this_nNumes, ;
                        Datas        WITH THIS.this_dDatas, ;
                        PrazoEnts    WITH THIS.this_dPrazoEnts, ;
                        Contas       WITH THIS.this_cContas, ;
                        RClis        WITH THIS.this_cRClis, ;
                        Conjuges     WITH THIS.this_cConjuges

                THIS.RegistrarAuditoria("TOGGLE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para BO OPERACIONAL sem tabela
    * BO de selecao opera apenas em cursores de sessao (nao persiste em tabela).
    * Nao ha registro em LogAuditoria (this_cTabela vazio inviabiliza SQL de log).
    * Metodo mantido para preservar contrato com BusinessBase.Salvar/Excluir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

ENDDEFINE

