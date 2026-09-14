# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DATAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: INCLUIR, CIDCHAVES

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
Objeto: delete
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = ""
  Column2.SelectOnEntry = .F.
  Column3.ControlSource = ""
  ControlSource = ""
  Name = "delete"
Select * From CrSigCdCot Into Cursor TmpCot ReadWrite
This.fwgrade_Cotacao.Data.ControlSource = 'TmpCot.datas'
This.fwgrade_Cotacao.Cotacao.ControlSource = 'TmpCot.valos'
This.fwgrade_Cotacao.Hora.ControlSource = 'TmpCot.horas'
ThisForm.Delete.Visible  = fChecaAcesso('SIGPRCOT','EXCLUIR')
If ThisForm.Delete.Visible
	ThisForm.Delete.Left = lnLeft
	lnLeft = lnLeft + ThisForm.Delete.Width
Select TmpCot
Select TmpCot
If Seek(CrSigCdMoe.cmoes + Dtos(_data) + This.Value)
Select TmpCot
Seek(CrSigCdMoe.cmoes + Dtos({}))
	Insert Into TmpCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
	Insert Into CrSigCdCot (cmoes,datas,horas,cidchaves,dtalts,usuars) ;
Select TmpCot
	If ThisForm.ThisParent.poDataMgr.SqlExecute([Delete From SigCdCot Where cidchaves = ']+lcIdChave+[' ],'') < 1
	Select TmpCot
	Delete
	If Seek(lcIdChave,'CrSigCdCot','CidChaves')
		Delete In CrSigCdCot
Select TmpCot
		Delete
		If Seek(TmpCot.cidchaves,'CrSigCdCot','CidChaves')
			Delete In CrSigCdCot
	Select TmpCot
Select CrSigCdCot
	If Seek(CrSigCdCot.cidchaves,'TmpCot','CidChaves')
ThisForm.ThisParent.poDataMgr.Update('CrSigCdCot')
Select CrSigCdMoe

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS SQL (881 linhas total):

*-- Linhas 5 a 23:
5: *
6: * Pilares:
7: *   UX   -> layout identico ao legado (537x377 - popup modal)
8: *   BD   -> SigCdCot via SQLEXEC (gnConnHandle)
9: *   CODE -> arquitetura em camadas (FormBase / SIGPRCOTBO)
10: *
11: * CHAMADA:
12: *   loForm = CREATEOBJECT("FormSIGPRCOT", loFormPai, lcMoeda)
13: *   loForm.Show()
14: *   par_oParent = form pai (objeto) - ex: FormSigPrCfn
15: *   par_cMoeda  = codigo da moeda a exibir cotacoes (ex: "USD")
16: *==============================================================================
17: 
18: DEFINE CLASS FormSIGPRCOT AS FormBase
19: 
20:     *-- Propriedades visuais (popup modal pequeno, identico ao legado)
21:     Height       = 377
22:     Width        = 537
23:     BorderStyle  = 2

*-- Linhas 229 a 249:
229:             IF loc_lSucesso AND VARTYPE(THIS.grd_4c_Cotacoes) = "O"
230:                 THIS.grd_4c_Cotacoes.ColumnCount             = 3
231:                 THIS.grd_4c_Cotacoes.RecordSource            = "cursor_4c_Cotacoes"
232:                 THIS.grd_4c_Cotacoes.Column1.ControlSource   = "cursor_4c_Cotacoes.datas"
233:                 THIS.grd_4c_Cotacoes.Column2.ControlSource   = "cursor_4c_Cotacoes.horas"
234:                 THIS.grd_4c_Cotacoes.Column3.ControlSource   = "cursor_4c_Cotacoes.valos"
235:                 THIS.grd_4c_Cotacoes.Column1.Header1.Caption = "Data"
236:                 THIS.grd_4c_Cotacoes.Column2.Header1.Caption = "Hora"
237:                 THIS.grd_4c_Cotacoes.Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
238:                 THIS.grd_4c_Cotacoes.Refresh()
239:             ENDIF
240:         ENDIF
241:         RETURN loc_lSucesso
242:     ENDPROC
243: 
244:     *==========================================================================
245:     PROTECTED PROCEDURE ConfigurarPaginaLista
246:     *==========================================================================
247:     *-- Form OPERACIONAL flat (sem PageFrame): agrupa configuracao da area de
248:     *-- listagem/edicao de cotacoes. Chamado uma unica vez em InicializarForm.
249:     *-- Equivalente logico ao "Page1 (Lista)" dos forms CRUD - contem:

*-- Linhas 313 a 342:
313:             .ColumnCount       = 3
314:             .FontName          = "Courier New"
315:             .RecordMark        = .F.
316:             .DeleteMark        = .F.
317:             .RowHeight         = 20
318:             .ScrollBars        = 2
319:             .AllowHeaderSizing = .T.
320:             .ReadOnly          = .F.
321: 
322:             WITH .Column1
323:                 .Width         = 80
324:                 .FontName      = "Courier New"
325:                 .Movable       = .F.
326:                 .Resizable     = .F.
327:                 .SelectOnEntry = .F.
328:                 .Format        = "K"
329:                 WITH .Header1
330:                     .Alignment = 2
331:                     .Caption   = "Data"
332:                 ENDWITH
333:             ENDWITH
334: 
335:             WITH .Column2
336:                 .Width         = 55
337:                 .FontName      = "Courier New"
338:                 .Movable       = .F.
339:                 .Resizable     = .F.
340:                 .InputMask     = "99:99"
341:                 WITH .Header1
342:                     .Alignment = 2

*-- Linhas 454 a 488:
454:         ENDIF
455:         IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
456:             IF USED("cursor_4c_Cotacoes")
457:                 SELECT cursor_4c_Cotacoes
458:                 THIS.this_nIncluir = RECNO()
459:                 *-- Desbloquear grid para edicao da nova linha (When do legado)
460:                 THIS.grd_4c_Cotacoes.ReadOnly = .F.
461:             ENDIF
462:             THIS.RefrescarGrid()
463:         ENDIF
464:     ENDPROC
465: 
466:     *==========================================================================
467:     PROCEDURE CmdExcluirClick
468:     *==========================================================================
469:         LOCAL loc_cChave, loc_lExcluiu
470:         IF !USED("cursor_4c_Cotacoes")
471:             RETURN
472:         ENDIF
473:         SELECT cursor_4c_Cotacoes
474:         IF EOF() OR BOF()
475:             RETURN
476:         ENDIF
477:         loc_cChave = ALLTRIM(cidchaves)
478:         IF EMPTY(loc_cChave)
479:             RETURN
480:         ENDIF
481:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
482:                        CHR(227) + "o?", "Confirmar")
483:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
484:                 loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
485:                 IF loc_lExcluiu
486:                     THIS.this_nIncluir = 0
487:                     THIS.grd_4c_Cotacoes.ReadOnly = .T.
488:                 ENDIF

*-- Linhas 505 a 606:
505:     *==========================================================================
506:         LPARAMETERS par_nColIndex
507:         IF USED("cursor_4c_Cotacoes")
508:             SELECT cursor_4c_Cotacoes
509:             IF RECNO() != THIS.this_nIncluir
510:                 THIS.this_nIncluir = 0
511:                 *-- Bloquear grid ao navegar para registro existente (When do legado)
512:                 THIS.grd_4c_Cotacoes.ReadOnly = .T.
513:             ENDIF
514:         ENDIF
515:     ENDPROC
516: 
517:     *==========================================================================
518:     PROCEDURE GrdDataText1KeyPress
519:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
520:     *-- Equivalente ao data.Text1.Valid do legado:
521:     *-- Avisa quando data esta vazia ao sair com ENTER/TAB
522:     *==========================================================================
523:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
524:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
525:             RETURN
526:         ENDIF
527:         IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
528:             RETURN
529:         ENDIF
530:         SELECT cursor_4c_Cotacoes
531:         IF RECNO() = THIS.this_nIncluir AND EMPTY(datas)
532:             MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", ;
533:                      "Aten" + CHR(231) + CHR(227) + "o")
534:         ENDIF
535:     ENDPROC
536: 
537:     *==========================================================================
538:     PROCEDURE GrdHoraText1KeyPress
539:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
540:     *-- Equivalente ao hora.Text1.Valid do legado:
541:     *-- Verifica cotacao duplicada (mesma moeda + data + hora) ao sair com ENTER/TAB
542:     *==========================================================================
543:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
544:         LOCAL loc_cHoraDigitada, loc_dData, loc_nRecnoNovo
545:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
546:             RETURN
547:         ENDIF
548:         IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
549:             RETURN
550:         ENDIF
551:         SELECT cursor_4c_Cotacoes
552:         IF RECNO() != THIS.this_nIncluir
553:             RETURN
554:         ENDIF
555:         *-- Capturar valores ANTES de acessar objeto do grid (evita mudanca de area de trabalho)
556:         loc_nRecnoNovo    = THIS.this_nIncluir
557:         loc_dData         = datas
558:         loc_cHoraDigitada = ALLTRIM(THIS.grd_4c_Cotacoes.Column2.Text1.Value)
559:         IF EMPTY(loc_cHoraDigitada) OR EMPTY(loc_dData)
560:             RETURN
561:         ENDIF
562:         *-- Restaurar area de trabalho apos acesso ao objeto do grid
563:         SELECT cursor_4c_Cotacoes
564:         *-- Procurar outra linha (nao a nova) com mesma moeda+data+hora
565:         LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(THIS.this_cMoeda) ;
566:                AND datas = loc_dData ;
567:                AND ALLTRIM(horas) = loc_cHoraDigitada ;
568:                AND RECNO() != loc_nRecnoNovo
569:         IF FOUND()
570:             SELECT cursor_4c_Cotacoes
571:             GO (loc_nRecnoNovo)
572:             THIS.grd_4c_Cotacoes.Column2.Text1.Value = "  :  "
573:             MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
574:                      " cadastrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
575:         ENDIF
576:     ENDPROC
577: 
578:     *==========================================================================
579:     PROCEDURE GrdCotacaoText1KeyPress
580:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
581:     *-- Equivalente ao cotacao.Text1.Valid do legado:
582:     *-- Posiciona no ultimo registro e refresca o grid ao sair com ENTER/TAB
583:     *==========================================================================
584:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
585:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
586:             RETURN
587:         ENDIF
588:         IF !USED("cursor_4c_Cotacoes")
589:             RETURN
590:         ENDIF
591:         SELECT cursor_4c_Cotacoes
592:         GO BOTTOM
593:         THIS.RefrescarGrid()
594:     ENDPROC
595: 
596:     *==========================================================================
597:     PROTECTED PROCEDURE RefrescarGrid
598:     *==========================================================================
599:         IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
600:             THIS.grd_4c_Cotacoes.Refresh()
601:         ENDIF
602:     ENDPROC
603: 
604:     *==========================================================================
605:     PROTECTED PROCEDURE AlternarPagina
606:     *==========================================================================

*-- Linhas 620 a 638:
620:         ENDIF
621:         IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
622:             IF USED("cursor_4c_Cotacoes")
623:                 SELECT cursor_4c_Cotacoes
624:                 THIS.this_nIncluir = RECNO()
625:                 IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
626:                     THIS.grd_4c_Cotacoes.ReadOnly = .F.
627:                     THIS.grd_4c_Cotacoes.SetFocus()
628:                 ENDIF
629:             ENDIF
630:             THIS.RefrescarGrid()
631:         ENDIF
632:     ENDPROC
633: 
634:     *==========================================================================
635:     * BtnAlterarClick - Editar cotacao selecionada. O SCX legado SIGPRCOT nao
636:     * possui botao "Alterar" (edicao acontece inline no fwgrade apenas para
637:     * o registro recem inserido, controlado pelo When(). Aqui replicamos essa
638:     * semantica: se o usuario selecionou uma linha existente, desbloqueamos o

*-- Linhas 645 a 663:
645:                      "Aten" + CHR(231) + CHR(227) + "o")
646:             RETURN
647:         ENDIF
648:         SELECT cursor_4c_Cotacoes
649:         IF EOF() OR BOF() OR RECCOUNT() = 0
650:             MsgAviso("Selecione uma cota" + CHR(231) + CHR(227) + "o para alterar.", ;
651:                      "Aten" + CHR(231) + CHR(227) + "o")
652:             RETURN
653:         ENDIF
654:         THIS.this_nIncluir = RECNO()
655:         IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
656:             THIS.grd_4c_Cotacoes.ReadOnly = .F.
657:             THIS.grd_4c_Cotacoes.SetFocus()
658:         ENDIF
659:     ENDPROC
660: 
661:     *==========================================================================
662:     * BtnVisualizarClick - Visualizar cotacoes (modo somente-leitura). Este
663:     * form OPERACIONAL flat JA e o visualizador (popup modal listando todas as

*-- Linhas 680 a 706:
680: 
681:     *==========================================================================
682:     * BtnExcluirClick - Excluir cotacao selecionada (equivalente ao botao
683:     * "delete" do SCX legado). Executa DELETE no SigCdCot via BO com chave
684:     * cidchaves da linha corrente, apos confirmacao do usuario.
685:     *==========================================================================
686:     PROCEDURE BtnExcluirClick
687:         LOCAL loc_cChave, loc_lExcluiu
688:         IF !USED("cursor_4c_Cotacoes")
689:             RETURN
690:         ENDIF
691:         SELECT cursor_4c_Cotacoes
692:         IF EOF() OR BOF() OR RECCOUNT() = 0
693:             RETURN
694:         ENDIF
695:         loc_cChave = ALLTRIM(cidchaves)
696:         IF EMPTY(loc_cChave)
697:             RETURN
698:         ENDIF
699:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
700:                        CHR(227) + "o?", "Confirmar")
701:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
702:                 loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
703:                 IF loc_lExcluiu
704:                     THIS.this_nIncluir = 0
705:                     IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
706:                         THIS.grd_4c_Cotacoes.ReadOnly = .T.

*-- Linhas 796 a 814:
796:     *==========================================================================
797:     * BOParaForm - Nao aplicavel a este form OPERACIONAL
798:     * Os dados ja estao no cursor cursor_4c_Cotacoes vinculado ao grid via
799:     * RecordSource/ControlSource. Nao ha TextBoxes avulsos para popular.
800:     *==========================================================================
801:     PROCEDURE BOParaForm
802:         RETURN .T.
803:     ENDPROC
804: 
805:     *==========================================================================
806:     * HabilitarCampos - Controla habilitacao do grid conforme modo de edicao
807:     * par_lHabilitar = .T. -> grid editavel (nova linha em insercao/alteracao)
808:     * par_lHabilitar = .F. -> grid somente-leitura (modo consulta/inicial)
809:     *==========================================================================
810:     PROCEDURE HabilitarCampos
811:         LPARAMETERS par_lHabilitar
812:         LOCAL loc_lHabilitar
813:         IF VARTYPE(par_lHabilitar) = "L"
814:             loc_lHabilitar = par_lHabilitar


### BO (C:\4c\projeto\app\classes\SIGPRCOTBO.prg):
*==============================================================================
* SIGPRCOTBO.prg - Business Object para Cotacao de Moeda
* Tabela principal: SigCdCot
* Tipo: OPERACIONAL
* Migracao de: SIGPRCOT.SCX
*==============================================================================
SET RESOURCE OFF
SET SAFETY OFF

DEFINE CLASS SIGPRCOTBO AS BusinessBase

    *-- Campos de SigCdCot (schema: docs/schema.sql)
    this_cMoes      = ""   && char(3)       - codigo da moeda
    this_dDatas     = {}   && date NULL      - data da cotacao
    this_cHoras     = ""   && char(8)        - hora da cotacao
    this_nValos     = 0    && numeric(11,6)  - valor da cotacao
    this_cCidChaves = ""   && char(20)       - chave unica (PK)
    this_dDtAlts    = {}   && date NULL      - data da ultima alteracao
    this_cUsuars    = ""   && char(10)       - usuario que inseriu/alterou

    *-- Nome do cursor de trabalho (grid de cotacoes)
    this_cCursorCotacoes = "cursor_4c_Cotacoes"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCot"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cMoes      = TratarNulo(cmoes,     "C")
            THIS.this_dDatas     = TratarNulo(datas,     "D")
            THIS.this_cHoras     = TratarNulo(horas,     "C")
            THIS.this_nValos     = TratarNulo(valos,     "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_dDtAlts    = TratarNulo(dtalts,    "D")
            THIS.this_cUsuars    = TratarNulo(usuars,    "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de inserir/atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cMoes))
            THIS.this_cMensagem = "Informe o c" + CHR(243) + "digo da moeda."
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDatas)
            THIS.this_cMensagem = "Informe a data da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        IF THIS.this_nValos <= 0
            THIS.this_cMensagem = "Informe o valor da cota" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave unica char(20) para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica()
        RETURN LEFT(SYS(2015) + SYS(2015), 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoes - Carrega cotacoes de uma moeda no cursor de trabalho
    * O cursor resultante (cursor_4c_Cotacoes) eh READWRITE para edicao no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCotacoes(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCotacoes)
                USE IN (THIS.this_cCursorCotacoes)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Cotacoes ;
                (cmoes C(3) NULL, datas D NULL, horas C(8) NULL, ;
                 valos N(11,6) NULL, cidchaves C(20) NULL, ;
                 dtalts D NULL, usuars C(10) NULL)
            SET NULL OFF

            INDEX ON cidchaves                    TAG CidChaves
            INDEX ON cmoes + DTOS(datas) + horas  TAG Cotacaos

            loc_cSQL = "SELECT cmoes, CAST(datas AS date) AS datas, horas, valos, " + ;
                "cidchaves, CAST(dtalts AS date) AS dtalts, usuars " + ;
                "FROM SigCdCot " + ;
                "WHERE cmoes = " + EscaparSQL(par_cMoeda) + " " + ;
                "ORDER BY datas DESC, horas DESC"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotacoesTemp")

            IF loc_nRet > 0
                IF USED("cursor_4c_CotacoesTemp") AND RECCOUNT("cursor_4c_CotacoesTemp") > 0
                    SELECT cursor_4c_Cotacoes
                    APPEND FROM DBF("cursor_4c_CotacoesTemp")
                ENDIF
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF

                SELECT cursor_4c_Cotacoes
                IF RECCOUNT() > 0
                    SET ORDER TO TAG Cotacaos
                    GO BOTTOM
                ENDIF
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                IF USED("cursor_4c_CotacoesTemp")
                    USE IN cursor_4c_CotacoesTemp
                ENDIF
                MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirNovaCotacao - Insere nova cotacao vazia para a moeda informada
    * Verifica duplicidade: somente insere se nao houver cotacao para hoje
    * Replica logica do botao "inserir" do legado (Click do SIGPRCOT.inserir)
    *--------------------------------------------------------------------------
    PROCEDURE InserirNovaCotacao(par_cMoeda)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCidChave, loc_dHoje, loc_cHoras
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            loc_dHoje  = DATE()
            loc_cHoras = TIME()

            *-- Verificar duplicidade no cursor (cotacao para hoje ja existe?)
            *-- Usa LOCATE porque SET EXACT ON impede SEEK parcial em indice composto
            SELECT cursor_4c_Cotacoes
            LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(par_cMoeda) AND datas = loc_dHoje
            IF FOUND()
                MsgAviso("J" + CHR(225) + " existe cota" + CHR(231) + CHR(227) + ;
                    "o cadastrada para hoje.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar chave unica
                loc_cCidChave = THIS.GerarChaveUnica()

                *-- INSERT no SQL Server (valos=0 inicialmente; usuario edita no grid)
                loc_cSQL = "INSERT INTO SigCdCot " + ;
                    "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                    "VALUES (" + ;
                    EscaparSQL(ALLTRIM(par_cMoeda)) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(loc_cHoras) + ", " + ;
                    "0, " + ;
                    EscaparSQL(loc_cCidChave) + ", " + ;
                    FormatarDataSQL(loc_dHoje) + ", " + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet > 0
                    *-- Adicionar ao cursor de trabalho; APPEND BLANK deixa ponteiro no novo registro
                    SELECT cursor_4c_Cotacoes
                    SET ORDER TO
                    APPEND BLANK
                    REPLACE cmoes     WITH ALLTRIM(par_cMoeda)
                    REPLACE datas     WITH loc_dHoje
                    REPLACE horas     WITH loc_cHoras
                    REPLACE valos     WITH 0
                    REPLACE cidchaves WITH loc_cCidChave
                    REPLACE dtalts    WITH loc_dHoje
                    REPLACE usuars    WITH gc_4c_UsuarioLogado

                    THIS.this_cCidChaves = loc_cCidChave
                    THIS.RegistrarAuditoria("INSERIR")
                    loc_lSucesso = .T.
                ELSE
                    AERROR(loc_aErro)
                    MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                        loc_aErro[2], "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirCotacaoAtual - Exclui cotacao pelo cidchaves do registro corrente
    * Replica logica do botao "delete" do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirCotacaoAtual(par_cCidChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cCidChave))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                *-- Remover do cursor de trabalho
                IF USED(THIS.this_cCursorCotacoes)
                    SELECT cursor_4c_Cotacoes
                    LOCATE FOR ALLTRIM(cidchaves) = ALLTRIM(par_cCidChave)
                    IF FOUND()
                        DELETE
                        PACK
                        IF RECCOUNT() > 0
                            SET ORDER TO TAG Cotacaos
                            GO BOTTOM
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cCidChaves = par_cCidChave
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAlteracoesCursor - Sincroniza cursor de cotacoes com SQL Server
    * Replica logica do botao "sair" do legado:
    * 1. Remove registros com data vazia ou valor zero/null
    * 2. Atualiza SigCdCot com os valores editados no cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAlteracoesCursor()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cChave, loc_dDatas, loc_cHoras, loc_nValos
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorCotacoes)
            RETURN .F.
        ENDIF

        TRY
            *-- Passo 1: Remover registros incompletos (data vazia ou valor <= 0)
            SELECT cursor_4c_Cotacoes
            SET ORDER TO
            GO TOP
            SCAN
                loc_cChave = ALLTRIM(cidchaves)
                IF EMPTY(datas) OR NVL(valos, 0) <= 0
                    IF !EMPTY(loc_cChave)
                        loc_cSQL = "DELETE FROM SigCdCot " + ;
                            "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                    SELECT cursor_4c_Cotacoes
                    DELETE
                ENDIF
                SELECT cursor_4c_Cotacoes
            ENDSCAN

            PACK

            *-- Passo 2: Atualizar SigCdCot com valores editados no cursor
            SELECT cursor_4c_Cotacoes
            GO TOP
            SCAN
                loc_cChave  = ALLTRIM(cidchaves)
                loc_dDatas  = datas
                loc_cHoras  = ALLTRIM(horas)
                loc_nValos  = valos

                IF !EMPTY(loc_cChave)
                    loc_cSQL = "UPDATE SigCdCot SET " + ;
                        "datas = " + FormatarDataSQL(loc_dDatas) + ", " + ;
                        "horas = " + EscaparSQL(loc_cHoras) + ", " + ;
                        "valos = " + FormatarNumeroSQL(loc_nValos, 6) + ", " + ;
                        "dtalts = GETDATE(), " + ;
                        "usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + " " + ;
                        "WHERE cidchaves = " + EscaparSQL(loc_cChave)
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDIF

                SELECT cursor_4c_Cotacoes
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova cotacao usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro, loc_cCidChave
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cCidChave         = THIS.GerarChaveUnica()
            THIS.this_cCidChaves  = loc_cCidChave
            THIS.this_dDtAlts     = DATE()
            THIS.this_cUsuars     = gc_4c_UsuarioLogado

            IF EMPTY(ALLTRIM(THIS.this_cHoras))
                THIS.this_cHoras = TIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdCot " + ;
                "(cmoes, datas, horas, valos, cidchaves, dtalts, usuars) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cMoes) + ", " + ;
                FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                EscaparSQL(THIS.this_cHoras) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza cotacao existente usando propriedades this_* do BO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        IF !THIS.ValidarDados()
            MsgAviso(THIS.this_cMensagem, "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlts = DATE()
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "UPDATE SigCdCot SET " + ;
                "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                "horas = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
                "valos = " + FormatarNumeroSQL(THIS.this_nValos, 6) + ", " + ;
                "dtalts = " + FormatarDataSQL(THIS.this_dDtAlts) + ", " + ;
                "usuars = " + EscaparSQL(THIS.this_cUsuars) + " " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui cotacao de SigCdCot (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_aErro[3]
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCot " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                AERROR(loc_aErro)
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    loc_aErro[2], "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, Chave, Usuario, DataHora) VALUES (" + ;
                EscaparSQL("SigCdCot") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

