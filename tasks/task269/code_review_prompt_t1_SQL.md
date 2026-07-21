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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCOT.prg) - TRECHOS RELEVANTES PARA PASS SQL (879 linhas total):

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

*-- Linhas 227 a 247:
227:             IF loc_lSucesso AND VARTYPE(THIS.grd_4c_Cotacoes) = "O"
228:                 THIS.grd_4c_Cotacoes.ColumnCount             = 3
229:                 THIS.grd_4c_Cotacoes.RecordSource            = "cursor_4c_Cotacoes"
230:                 THIS.grd_4c_Cotacoes.Column1.ControlSource   = "cursor_4c_Cotacoes.datas"
231:                 THIS.grd_4c_Cotacoes.Column2.ControlSource   = "cursor_4c_Cotacoes.horas"
232:                 THIS.grd_4c_Cotacoes.Column3.ControlSource   = "cursor_4c_Cotacoes.valos"
233:                 THIS.grd_4c_Cotacoes.Column1.Header1.Caption = "Data"
234:                 THIS.grd_4c_Cotacoes.Column2.Header1.Caption = "Hora"
235:                 THIS.grd_4c_Cotacoes.Column3.Header1.Caption = "Cota" + CHR(231) + CHR(227) + "o"
236:                 THIS.grd_4c_Cotacoes.Refresh()
237:             ENDIF
238:         ENDIF
239:         RETURN loc_lSucesso
240:     ENDPROC
241: 
242:     *==========================================================================
243:     PROTECTED PROCEDURE ConfigurarPaginaLista
244:     *==========================================================================
245:     *-- Form OPERACIONAL flat (sem PageFrame): agrupa configuracao da area de
246:     *-- listagem/edicao de cotacoes. Chamado uma unica vez em InicializarForm.
247:     *-- Equivalente logico ao "Page1 (Lista)" dos forms CRUD - contem:

*-- Linhas 311 a 340:
311:             .ColumnCount       = 3
312:             .FontName          = "Courier New"
313:             .RecordMark        = .F.
314:             .DeleteMark        = .F.
315:             .RowHeight         = 20
316:             .ScrollBars        = 2
317:             .AllowHeaderSizing = .T.
318:             .ReadOnly          = .F.
319: 
320:             WITH .Column1
321:                 .Width         = 80
322:                 .FontName      = "Courier New"
323:                 .Movable       = .F.
324:                 .Resizable     = .F.
325:                 .SelectOnEntry = .F.
326:                 .Format        = "K"
327:                 WITH .Header1
328:                     .Alignment = 2
329:                     .Caption   = "Data"
330:                 ENDWITH
331:             ENDWITH
332: 
333:             WITH .Column2
334:                 .Width         = 55
335:                 .FontName      = "Courier New"
336:                 .Movable       = .F.
337:                 .Resizable     = .F.
338:                 .InputMask     = "99:99"
339:                 WITH .Header1
340:                     .Alignment = 2

*-- Linhas 452 a 486:
452:         ENDIF
453:         IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
454:             IF USED("cursor_4c_Cotacoes")
455:                 SELECT cursor_4c_Cotacoes
456:                 THIS.this_nIncluir = RECNO()
457:                 *-- Desbloquear grid para edicao da nova linha (When do legado)
458:                 THIS.grd_4c_Cotacoes.ReadOnly = .F.
459:             ENDIF
460:             THIS.RefrescarGrid()
461:         ENDIF
462:     ENDPROC
463: 
464:     *==========================================================================
465:     PROCEDURE CmdExcluirClick
466:     *==========================================================================
467:         LOCAL loc_cChave, loc_lExcluiu
468:         IF !USED("cursor_4c_Cotacoes")
469:             RETURN
470:         ENDIF
471:         SELECT cursor_4c_Cotacoes
472:         IF EOF() OR BOF()
473:             RETURN
474:         ENDIF
475:         loc_cChave = ALLTRIM(cidchaves)
476:         IF EMPTY(loc_cChave)
477:             RETURN
478:         ENDIF
479:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
480:                        CHR(227) + "o?", "Confirmar")
481:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
482:                 loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
483:                 IF loc_lExcluiu
484:                     THIS.this_nIncluir = 0
485:                     THIS.grd_4c_Cotacoes.ReadOnly = .T.
486:                 ENDIF

*-- Linhas 503 a 604:
503:     *==========================================================================
504:         LPARAMETERS par_nColIndex
505:         IF USED("cursor_4c_Cotacoes")
506:             SELECT cursor_4c_Cotacoes
507:             IF RECNO() != THIS.this_nIncluir
508:                 THIS.this_nIncluir = 0
509:                 *-- Bloquear grid ao navegar para registro existente (When do legado)
510:                 THIS.grd_4c_Cotacoes.ReadOnly = .T.
511:             ENDIF
512:         ENDIF
513:     ENDPROC
514: 
515:     *==========================================================================
516:     PROCEDURE GrdDataText1KeyPress
517:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
518:     *-- Equivalente ao data.Text1.Valid do legado:
519:     *-- Avisa quando data esta vazia ao sair com ENTER/TAB
520:     *==========================================================================
521:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
522:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
523:             RETURN
524:         ENDIF
525:         IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
526:             RETURN
527:         ENDIF
528:         SELECT cursor_4c_Cotacoes
529:         IF RECNO() = THIS.this_nIncluir AND EMPTY(datas)
530:             MsgAviso("Informe a data da Cota" + CHR(231) + CHR(227) + "o.", ;
531:                      "Aten" + CHR(231) + CHR(227) + "o")
532:         ENDIF
533:     ENDPROC
534: 
535:     *==========================================================================
536:     PROCEDURE GrdHoraText1KeyPress
537:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
538:     *-- Equivalente ao hora.Text1.Valid do legado:
539:     *-- Verifica cotacao duplicada (mesma moeda + data + hora) ao sair com ENTER/TAB
540:     *==========================================================================
541:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
542:         LOCAL loc_cHoraDigitada, loc_dData, loc_nRecnoNovo
543:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
544:             RETURN
545:         ENDIF
546:         IF !USED("cursor_4c_Cotacoes") OR THIS.this_nIncluir <= 0
547:             RETURN
548:         ENDIF
549:         SELECT cursor_4c_Cotacoes
550:         IF RECNO() != THIS.this_nIncluir
551:             RETURN
552:         ENDIF
553:         *-- Capturar valores ANTES de acessar objeto do grid (evita mudanca de area de trabalho)
554:         loc_nRecnoNovo    = THIS.this_nIncluir
555:         loc_dData         = datas
556:         loc_cHoraDigitada = ALLTRIM(THIS.grd_4c_Cotacoes.Column2.Text1.Value)
557:         IF EMPTY(loc_cHoraDigitada) OR EMPTY(loc_dData)
558:             RETURN
559:         ENDIF
560:         *-- Restaurar area de trabalho apos acesso ao objeto do grid
561:         SELECT cursor_4c_Cotacoes
562:         *-- Procurar outra linha (nao a nova) com mesma moeda+data+hora
563:         LOCATE FOR ALLTRIM(cmoes) = ALLTRIM(THIS.this_cMoeda) ;
564:                AND datas = loc_dData ;
565:                AND ALLTRIM(horas) = loc_cHoraDigitada ;
566:                AND RECNO() != loc_nRecnoNovo
567:         IF FOUND()
568:             SELECT cursor_4c_Cotacoes
569:             GO (loc_nRecnoNovo)
570:             THIS.grd_4c_Cotacoes.Column2.Text1.Value = "  :  "
571:             MsgAviso("Cota" + CHR(231) + CHR(227) + "o j" + CHR(225) + ;
572:                      " cadastrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
573:         ENDIF
574:     ENDPROC
575: 
576:     *==========================================================================
577:     PROCEDURE GrdCotacaoText1KeyPress
578:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
579:     *-- Equivalente ao cotacao.Text1.Valid do legado:
580:     *-- Posiciona no ultimo registro e refresca o grid ao sair com ENTER/TAB
581:     *==========================================================================
582:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
583:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
584:             RETURN
585:         ENDIF
586:         IF !USED("cursor_4c_Cotacoes")
587:             RETURN
588:         ENDIF
589:         SELECT cursor_4c_Cotacoes
590:         GO BOTTOM
591:         THIS.RefrescarGrid()
592:     ENDPROC
593: 
594:     *==========================================================================
595:     PROTECTED PROCEDURE RefrescarGrid
596:     *==========================================================================
597:         IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
598:             THIS.grd_4c_Cotacoes.Refresh()
599:         ENDIF
600:     ENDPROC
601: 
602:     *==========================================================================
603:     PROTECTED PROCEDURE AlternarPagina
604:     *==========================================================================

*-- Linhas 618 a 636:
618:         ENDIF
619:         IF THIS.this_oBusinessObject.InserirNovaCotacao(THIS.this_cMoeda)
620:             IF USED("cursor_4c_Cotacoes")
621:                 SELECT cursor_4c_Cotacoes
622:                 THIS.this_nIncluir = RECNO()
623:                 IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
624:                     THIS.grd_4c_Cotacoes.ReadOnly = .F.
625:                     THIS.grd_4c_Cotacoes.SetFocus()
626:                 ENDIF
627:             ENDIF
628:             THIS.RefrescarGrid()
629:         ENDIF
630:     ENDPROC
631: 
632:     *==========================================================================
633:     * BtnAlterarClick - Editar cotacao selecionada. O SCX legado SIGPRCOT nao
634:     * possui botao "Alterar" (edicao acontece inline no fwgrade apenas para
635:     * o registro recem inserido, controlado pelo When(). Aqui replicamos essa
636:     * semantica: se o usuario selecionou uma linha existente, desbloqueamos o

*-- Linhas 643 a 661:
643:                      "Aten" + CHR(231) + CHR(227) + "o")
644:             RETURN
645:         ENDIF
646:         SELECT cursor_4c_Cotacoes
647:         IF EOF() OR BOF() OR RECCOUNT() = 0
648:             MsgAviso("Selecione uma cota" + CHR(231) + CHR(227) + "o para alterar.", ;
649:                      "Aten" + CHR(231) + CHR(227) + "o")
650:             RETURN
651:         ENDIF
652:         THIS.this_nIncluir = RECNO()
653:         IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
654:             THIS.grd_4c_Cotacoes.ReadOnly = .F.
655:             THIS.grd_4c_Cotacoes.SetFocus()
656:         ENDIF
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * BtnVisualizarClick - Visualizar cotacoes (modo somente-leitura). Este
661:     * form OPERACIONAL flat JA e o visualizador (popup modal listando todas as

*-- Linhas 678 a 704:
678: 
679:     *==========================================================================
680:     * BtnExcluirClick - Excluir cotacao selecionada (equivalente ao botao
681:     * "delete" do SCX legado). Executa DELETE no SigCdCot via BO com chave
682:     * cidchaves da linha corrente, apos confirmacao do usuario.
683:     *==========================================================================
684:     PROCEDURE BtnExcluirClick
685:         LOCAL loc_cChave, loc_lExcluiu
686:         IF !USED("cursor_4c_Cotacoes")
687:             RETURN
688:         ENDIF
689:         SELECT cursor_4c_Cotacoes
690:         IF EOF() OR BOF() OR RECCOUNT() = 0
691:             RETURN
692:         ENDIF
693:         loc_cChave = ALLTRIM(cidchaves)
694:         IF EMPTY(loc_cChave)
695:             RETURN
696:         ENDIF
697:         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o desta cota" + CHR(231) + ;
698:                        CHR(227) + "o?", "Confirmar")
699:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
700:                 loc_lExcluiu = THIS.this_oBusinessObject.ExcluirCotacaoAtual(loc_cChave)
701:                 IF loc_lExcluiu
702:                     THIS.this_nIncluir = 0
703:                     IF VARTYPE(THIS.grd_4c_Cotacoes) = "O"
704:                         THIS.grd_4c_Cotacoes.ReadOnly = .T.

*-- Linhas 794 a 812:
794:     *==========================================================================
795:     * BOParaForm - Nao aplicavel a este form OPERACIONAL
796:     * Os dados ja estao no cursor cursor_4c_Cotacoes vinculado ao grid via
797:     * RecordSource/ControlSource. Nao ha TextBoxes avulsos para popular.
798:     *==========================================================================
799:     PROCEDURE BOParaForm
800:         RETURN .T.
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * HabilitarCampos - Controla habilitacao do grid conforme modo de edicao
805:     * par_lHabilitar = .T. -> grid editavel (nova linha em insercao/alteracao)
806:     * par_lHabilitar = .F. -> grid somente-leitura (modo consulta/inicial)
807:     *==========================================================================
808:     PROCEDURE HabilitarCampos
809:         LPARAMETERS par_lHabilitar
810:         LOCAL loc_lHabilitar
811:         IF VARTYPE(par_lHabilitar) = "L"
812:             loc_lHabilitar = par_lHabilitar


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

