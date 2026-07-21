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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEop.prg) - TRECHOS RELEVANTES PARA PASS SQL (861 linhas total):

*-- Linhas 183 a 201:
183:             .BackStyle     = 1
184:             .BorderStyle   = 1
185:             .Value         = ""
186:             .ControlSource = "cursor_4c_Operacoes.Dopes"
187:             .Format        = "K!"
188:             .Height        = 25
189:             .MaxLength     = 40
190:             .SpecialEffect = 0
191:             .Left          = 87
192:             .Top           = 398
193:             .Width         = 150
194:             .ForeColor     = RGB(0,0,0)
195:             .BackColor     = RGB(255,255,255)
196:             .ReadOnly      = .T.
197:         ENDWITH
198: 
199:         THIS.AddObject("lbl_4c_Label1", "Label")
200:         WITH THIS.lbl_4c_Label1
201:             .AutoSize  = .T.

*-- Linhas 218 a 259:
218:             .BackStyle     = 1
219:             .BorderStyle   = 1
220:             .Value         = 0
221:             .ControlSource = "cursor_4c_Operacoes.Numes"
222:             .Height        = 25
223:             .SpecialEffect = 0
224:             .Left          = 276
225:             .Top           = 398
226:             .Width         = 50
227:             .ForeColor     = RGB(0,0,0)
228:             .BackColor     = RGB(255,255,255)
229:             .ReadOnly      = .T.
230:         ENDWITH
231:     ENDPROC
232: 
233:     *--------------------------------------------------------------------------
234:     * AlternarPagina - Refresh do popup: vai ao topo do cursor e sincroniza grid
235:     * e textboxes de status. Parametro par_nPagina aceito para compatibilidade
236:     * com o contrato de forms CRUD; qualquer valor invoca o mesmo refresh.
237:     *--------------------------------------------------------------------------
238:     PROCEDURE AlternarPagina(par_nPagina)
239:         LOCAL loc_lTemDados
240:         loc_lTemDados = USED("cursor_4c_Operacoes") ;
241:                         AND RECCOUNT("cursor_4c_Operacoes") > 0
242: 
243:         IF loc_lTemDados
244:             SELECT cursor_4c_Operacoes
245:             GO TOP IN cursor_4c_Operacoes
246:         ENDIF
247: 
248:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
249:             THIS.grd_4c_Dados.Refresh()
250:             IF loc_lTemDados
251:                 THIS.grd_4c_Dados.SetFocus()
252:             ENDIF
253:         ENDIF
254: 
255:         IF VARTYPE(THIS.txt_4c_Operacao) = "O"
256:             THIS.txt_4c_Operacao.Refresh()
257:         ENDIF
258: 
259:         IF VARTYPE(THIS.txt_4c_Numes) = "O"

*-- Linhas 377 a 513:
377:     * ConfigurarGrade - Grid de selecao de operacoes (grdOperacoes do legado)
378:     * 7 colunas: selecao (checkbox), data, empresa, prev. entrega, cliente, nome, conjugue
379:     * Regras criticas: AddObject chk_4c_Check1 ANTES de CurrentControl,
380:     *   CurrentControl ANTES de ControlSource, Sparse=.F. obrigatorio.
381:     *--------------------------------------------------------------------------
382:     PROTECTED PROCEDURE ConfigurarGrade()
383:         THIS.AddObject("grd_4c_Dados", "Grid")
384:         WITH THIS.grd_4c_Dados
385:             .Top               = 121
386:             .Left              = 3
387:             .Width             = 732
388:             .Height            = 275
389:             .ColumnCount       = 7
390:             .FontName          = "Tahoma"
391:             .DeleteMark        = .F.
392:             .RecordMark        = .F.
393:             .ScrollBars        = 2
394:             .HeaderHeight      = 19
395:             .ReadOnly          = .F.
396:             .AllowHeaderSizing = .F.
397:             .AllowRowSizing    = .F.
398:             .GridLineColor     = RGB(238,238,238)
399: 
400:             WITH .Column1
401:                 .Width     = 15
402:                 .Movable   = .F.
403:                 .Resizable = .F.
404:                 .ReadOnly  = .F.
405:                 .Sparse    = .F.
406:                 .AddObject("chk_4c_Check1", "CheckBox")
407:                 WITH .chk_4c_Check1
408:                     .Caption  = ""
409:                     .Value    = 0
410:                     .AutoSize = .T.
411:                 ENDWITH
412:                 .CurrentControl    = "chk_4c_Check1"
413:                 .ControlSource     = "cursor_4c_Operacoes.Selecionada"
414:                 .Header1.Caption   = ""
415:                 .Header1.Alignment = 2
416:                 .Header1.ForeColor = RGB(90,90,90)
417:                 .Header1.FontName  = "Tahoma"
418:                 .Header1.FontSize  = 8
419:             ENDWITH
420: 
421:             WITH .Column2
422:                 .Width             = 80
423:                 .Movable           = .F.
424:                 .Resizable         = .F.
425:                 .ReadOnly          = .T.
426:                 .FontName          = "Tahoma"
427:                 .ControlSource     = "cursor_4c_Operacoes.Datas"
428:                 .Header1.Caption   = "Data"
429:                 .Header1.Alignment = 2
430:                 .Header1.ForeColor = RGB(90,90,90)
431:                 .Header1.FontName  = "Tahoma"
432:                 .Header1.FontSize  = 8
433:             ENDWITH
434: 
435:             WITH .Column3
436:                 .Width             = 35
437:                 .Movable           = .F.
438:                 .Resizable         = .F.
439:                 .ReadOnly          = .T.
440:                 .FontName          = "Tahoma"
441:                 .ControlSource     = "cursor_4c_Operacoes.Emps"
442:                 .Header1.Caption   = "Emp"
443:                 .Header1.Alignment = 2
444:                 .Header1.ForeColor = RGB(90,90,90)
445:                 .Header1.FontName  = "Tahoma"
446:                 .Header1.FontSize  = 8
447:             ENDWITH
448: 
449:             WITH .Column4
450:                 .Width             = 80
451:                 .Movable           = .F.
452:                 .Resizable         = .F.
453:                 .ReadOnly          = .T.
454:                 .FontName          = "Tahoma"
455:                 .ControlSource     = "cursor_4c_Operacoes.PrazoEnts"
456:                 .Header1.Caption   = THIS.this_cCabData
457:                 .Header1.Alignment = 2
458:                 .Header1.ForeColor = RGB(90,90,90)
459:                 .Header1.FontName  = "Tahoma"
460:                 .Header1.FontSize  = 8
461:             ENDWITH
462: 
463:             WITH .Column5
464:                 .Width             = 80
465:                 .Movable           = .F.
466:                 .Resizable         = .F.
467:                 .ReadOnly          = .T.
468:                 .FontName          = "Tahoma"
469:                 .ControlSource     = "cursor_4c_Operacoes.Contas"
470:                 .Header1.Caption   = "Cliente"
471:                 .Header1.Alignment = 2
472:                 .Header1.ForeColor = RGB(90,90,90)
473:                 .Header1.FontName  = "Tahoma"
474:                 .Header1.FontSize  = 8
475:             ENDWITH
476: 
477:             WITH .Column6
478:                 .Width             = 200
479:                 .Movable           = .F.
480:                 .Resizable         = .F.
481:                 .ReadOnly          = .T.
482:                 .FontName          = "Tahoma"
483:                 .ControlSource     = "cursor_4c_Operacoes.RClis"
484:                 .Header1.Caption   = "Nome do Cliente"
485:                 .Header1.Alignment = 2
486:                 .Header1.ForeColor = RGB(90,90,90)
487:                 .Header1.FontName  = "Tahoma"
488:                 .Header1.FontSize  = 8
489:             ENDWITH
490: 
491:             WITH .Column7
492:                 .Width             = 205
493:                 .Movable           = .F.
494:                 .Resizable         = .F.
495:                 .ReadOnly          = .T.
496:                 .FontName          = "Tahoma"
497:                 .FontSize          = 9
498:                 .ControlSource     = "cursor_4c_Operacoes.Conjuges"
499:                 .Header1.Caption   = "Conjug" + CHR(233)
500:                 .Header1.Alignment = 2
501:                 .Header1.ForeColor = RGB(90,90,90)
502:                 .Header1.FontName  = "Tahoma"
503:                 .Header1.FontSize  = 8
504:             ENDWITH
505: 
506:             .RecordSource = "cursor_4c_Operacoes"
507:         ENDWITH
508:     ENDPROC
509: 
510:     *--------------------------------------------------------------------------
511:     * GrdAfterRowColChange - Atualiza textboxes de status ao navegar no grid
512:     * (equivalente ao grdOperacoes.AfterRowColChange do legado)
513:     *--------------------------------------------------------------------------

*-- Linhas 520 a 550:
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     * ChkSelecaoClick - Refresca grid apos toggle automatico via ControlSource
524:     * Cursor ja foi atualizado pelo binding antes de Click disparar
525:     *--------------------------------------------------------------------------
526:     PROCEDURE ChkSelecaoClick
527:         IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
528:             THIS.grd_4c_Dados.Refresh()
529:         ENDIF
530:     ENDPROC
531: 
532:     *--------------------------------------------------------------------------
533:     * ChkSelecaoKeyPress - Inverte selecao ao pressionar ENTER ou SPACE
534:     * Original: InList(nKeyCode, 13, 32) -> GATHER MEMVAR Fields Selecionada
535:     * ENTER e SPACE ambos alternam; ControlSource nao suprime default, por isso
536:     * usamos AlternarSelecao (toggle via GATHER MEMVAR como o legado) para ambos.
537:     *--------------------------------------------------------------------------
538:     PROCEDURE ChkSelecaoKeyPress
539:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
540:         IF INLIST(par_nKeyCode, 13, 32)
541:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
542:                 THIS.this_oBusinessObject.AlternarSelecao("cursor_4c_Operacoes")
543:                 THIS.grd_4c_Dados.Refresh()
544:             ENDIF
545:         ENDIF
546:     ENDPROC
547: 
548:     *--------------------------------------------------------------------------
549:     * ChkMarcaClick - Marca ou desmarca todas as operacoes (ck_Marca do legado)
550:     * Value ja esta no novo estado (VFP9 togglou antes de Click disparar)

*-- Linhas 647 a 665:
647:                         CHR(231) + CHR(245) + "es para visualizar.", "Aviso")
648:                 RETURN
649:             ENDIF
650:             SELECT cursor_4c_Operacoes
651:             GO TOP IN cursor_4c_Operacoes
652:             THIS.grd_4c_Dados.Refresh()
653:             THIS.grd_4c_Dados.SetFocus()
654:             THIS.txt_4c_Operacao.Refresh()
655:             THIS.txt_4c_Numes.Refresh()
656:         CATCH TO loc_oErro
657:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
658:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
659:         ENDTRY
660:     ENDPROC
661: 
662:     *--------------------------------------------------------------------------
663:     * BtnExcluirClick - Popup OPERACIONAL: mapeia p/ excluir todas da selecao
664:     * Legado SIGPREOP nao tem botao Excluir - contrato do pipeline exige metodo.
665:     * Semantica: remove todas as operacoes da selecao (desmarca Selecionada=0).

*-- Linhas 702 a 720:
702:         loc_lSucesso = .F.
703:         TRY
704:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
705:                 SELECT cursor_4c_Operacoes
706:                 GO TOP
707:             ENDIF
708:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
709:                 THIS.grd_4c_Dados.Refresh()
710:             ENDIF
711:             IF VARTYPE(THIS.txt_4c_Operacao) = "O"
712:                 THIS.txt_4c_Operacao.Refresh()
713:             ENDIF
714:             IF VARTYPE(THIS.txt_4c_Numes) = "O"
715:                 THIS.txt_4c_Numes.Refresh()
716:             ENDIF
717:             loc_lSucesso = .T.
718:         CATCH TO loc_oErro
719:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
720:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista")

*-- Linhas 779 a 797:
779: 
780:     *--------------------------------------------------------------------------
781:     * BOParaForm - Refresca controles de status com dados da linha corrente
782:     * OPERACIONAL: ControlSource ja faz binding; apenas refresca displays
783:     *--------------------------------------------------------------------------
784:     PROCEDURE BOParaForm()
785:         IF VARTYPE(THIS.txt_4c_Operacao) = "O"
786:             THIS.txt_4c_Operacao.Refresh()
787:         ENDIF
788:         IF VARTYPE(THIS.txt_4c_Numes) = "O"
789:             THIS.txt_4c_Numes.Refresh()
790:         ENDIF
791:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
792:             THIS.grd_4c_Dados.Refresh()
793:         ENDIF
794:     ENDPROC
795: 
796:     *--------------------------------------------------------------------------
797:     * HabilitarCampos - Controla habilitacao de controles interativos


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

