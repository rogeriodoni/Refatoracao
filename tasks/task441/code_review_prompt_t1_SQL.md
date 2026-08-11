# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CGRUS

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
	.Column1.ControlSource = 'xOpe.Cgrus'
	.Column2.ControlSource = 'xOpe.Dgrus'
lcSql = [Select a.*, b.Dgrus ] + ;
		[From ]+Iif(Thisform.Tipoggp,[SigCdGgp],[SigCdGps])+[ a, SigCdGrp b ] + ;
ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
Select CsSelecao
	Select xOpe
Select xOpe
Insert Into xOpe (Cgrus) Values ( Space(20))
Select xOpe
Select xOpe
	Select xOpe
	Delete 
	Select Cgrus, Sum(1) as Qt From xOpe Group by 1 Into Cursor Selecao where cgrus <> ' ' having Sum(1) > 1
	Select CrSigCdGgp
	Select CrSigCdGps
	Select xOpe
				Insert Into CrSigCdGgp (Dopes, Cgrus, pkchave) ;
				Insert Into CrSigCdGps (Dopes, Cgrus, cIdChaves) ;
		lcSql = [Delete From ]+Iif(ThisForm.Tipoggp,[SigCdGgp],[SigCdGps])+[ Where dopes = ']+CrSigCdOpe.dopes+[']
		m.lnErro1 = ( .PodataMgr.SqlExecute(lcSql,'') )
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGgp'),1,-1)
				m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdGps'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormGps.prg) - TRECHOS RELEVANTES PARA PASS SQL (997 linhas total):

*-- Linhas 195 a 227:
195:         IF USED("cursor_4c_Operacao")
196:             USE IN cursor_4c_Operacao
197:         ENDIF
198:         CREATE CURSOR cursor_4c_Operacao (Dopes C(20), Cgrus C(3), Dgrus C(20))
199:         INDEX ON Cgrus TAG Cgrus
200:         SET ORDER TO
201: 
202:         *-- Criar grid
203:         THIS.AddObject("grd_4c_Dados", "Grid")
204:         loc_oGrid = THIS.grd_4c_Dados
205:         WITH loc_oGrid
206:             .Top            = 87
207:             .Left           = 236
208:             .Width          = 264
209:             .Height         = 364
210:             .ColumnCount    = 2
211:             .FontName       = "Tahoma"
212:             .DeleteMark     = .F.
213:             .RecordMark     = .F.
214:             .ScrollBars     = 2
215:             .GridLineColor  = RGB(238,238,238)
216:             .HighlightStyle = 2
217:             .TabIndex       = 1
218:         ENDWITH
219: 
220:         WITH loc_oGrid.Column1
221:             .FontName   = "Tahoma"
222:             .Width      = 50
223:             .Movable    = .F.
224:             .Resizable  = .F.
225:             .BackColor  = RGB(255,255,255)
226:             WITH .Header1
227:                 .FontName   = "Tahoma"

*-- Linhas 250 a 269:
250:         *-- Vincular grid ao cursor
251:         WITH loc_oGrid
252:             .RecordSource           = "cursor_4c_Operacao"
253:             .Column1.ControlSource  = "cursor_4c_Operacao.Cgrus"
254:             .Column2.ControlSource  = "cursor_4c_Operacao.Dgrus"
255:         ENDWITH
256: 
257:         *-- Reconfigurar headers apos RecordSource (VFP reseta headers)
258:         WITH loc_oGrid.Column1.Header1
259:             .Caption = "Grupo"
260:         ENDWITH
261:         WITH loc_oGrid.Column2.Header1
262:             .Caption = "Descri" + CHR(231) + CHR(227) + "o"
263:         ENDWITH
264: 
265:         *-- Bindar KeyPress da Column1 para lookup de Cgrus
266:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1KeyPress")
267:     ENDPROC
268: 
269:     *--------------------------------------------------------------------------

*-- Linhas 431 a 464:
431: 
432:     *--------------------------------------------------------------------------
433:     * CarregarDados - Carrega grupos do SQL Server no cursor de trabalho
434:     * Equivale ao SQLEXEC + Scan/Append Blank/Gather do legado
435:     *--------------------------------------------------------------------------
436:     PROTECTED PROCEDURE CarregarDados()
437:         LOCAL loc_oErro
438:         TRY
439:             IF !EMPTY(THIS.this_cDopes) AND THIS.this_oBusinessObject.CarregarGrupos(THIS.this_cDopes, THIS.this_lTipoggp)
440:                 IF USED("cursor_4c_GruposTemp")
441:                     SELECT cursor_4c_Operacao
442:                     ZAP
443:                     APPEND FROM DBF("cursor_4c_GruposTemp")
444:                     USE IN cursor_4c_GruposTemp
445:                 ENDIF
446:             ENDIF
447: 
448:             IF USED("cursor_4c_Operacao")
449:                 SELECT cursor_4c_Operacao
450:                 SET ORDER TO
451:                 GO TOP
452:             ENDIF
453: 
454:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
455:                 THIS.grd_4c_Dados.Refresh()
456:             ENDIF
457:         CATCH TO loc_oErro
458:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
459:         ENDTRY
460:     ENDPROC
461: 
462:     *--------------------------------------------------------------------------
463:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
464:     *--------------------------------------------------------------------------

*-- Linhas 483 a 555:
483: 
484:     *--------------------------------------------------------------------------
485:     * CmdInserirClick - Insere linha em branco no grid
486:     * Original: Insert Into xOpe (Cgrus) Values (Space(20))
487:     *--------------------------------------------------------------------------
488:     PROCEDURE CmdInserirClick()
489:         LOCAL loc_oErro
490:         TRY
491:             SELECT cursor_4c_Operacao
492:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
493:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
494:             THIS.this_lGravaDados = .T.
495:             THIS.grd_4c_Dados.Column1.SetFocus()
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
498:         ENDTRY
499:     ENDPROC
500: 
501:     *--------------------------------------------------------------------------
502:     * CmdExcluirClick - Exclui linha corrente do grid
503:     * Original: Delete + Skip, Go Bott se EOF()
504:     *--------------------------------------------------------------------------
505:     PROCEDURE CmdExcluirClick()
506:         LOCAL loc_oErro
507:         TRY
508:             SELECT cursor_4c_Operacao
509:             IF !EOF()
510:                 DELETE
511:                 SKIP
512:                 IF EOF()
513:                     GO BOTTOM
514:                 ENDIF
515:             ENDIF
516:             THIS.this_lGravaDados = .T.
517:             THIS.grd_4c_Dados.SetFocus()
518:             THIS.grd_4c_Dados.Refresh()
519:         CATCH TO loc_oErro
520:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
521:         ENDTRY
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * CmdConfirmarClick - Valida e salva grupos no SQL Server
526:     * Original: cmdSair.Click - valida duplicidade, DELETE+INSERT em transacao
527:     *--------------------------------------------------------------------------
528:     PROCEDURE CmdConfirmarClick()
529:         LOCAL loc_lSucesso, loc_lPodeFechar, loc_oErro
530:         loc_lSucesso    = .F.
531:         loc_lPodeFechar = .T.
532:         TRY
533:             IF THIS.this_lGravaDados
534:                 *-- Validar duplicidade de Cgrus no cursor
535:                 IF !THIS.this_oBusinessObject.ValidarDuplicados("cursor_4c_Operacao")
536:                     loc_lPodeFechar = .F.
537:                 ENDIF
538: 
539:                 IF loc_lPodeFechar
540:                     *-- Salvar: DELETE todos existentes + INSERT novos em transacao
541:                     loc_lSucesso = THIS.this_oBusinessObject.SalvarGrupos( ;
542:                         THIS.this_cDopes, ;
543:                         THIS.this_lTipoggp, ;
544:                         "cursor_4c_Operacao" ;
545:                     )
546: 
547:                     IF !loc_lSucesso
548:                         MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", "Erro")
549:                         loc_lPodeFechar = .F.
550:                     ENDIF
551:                 ENDIF
552:             ENDIF
553: 
554:             IF loc_lPodeFechar
555:                 *-- Re-habilitar form pai e fechar

*-- Linhas 581 a 615:
581: 
582:     *--------------------------------------------------------------------------
583:     * BtnIncluirClick - Insere nova linha em branco no grid
584:     * Legado: cmdInserir.Click -> Insert Into xOpe (Cgrus) Values (Space(20))
585:     *--------------------------------------------------------------------------
586:     PROCEDURE BtnIncluirClick()
587:         LOCAL loc_oErro
588:         TRY
589:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
590:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite inclus" + CHR(227) + "o.", "Aviso")
591:                 RETURN
592:             ENDIF
593: 
594:             IF !USED("cursor_4c_Operacao")
595:                 MsgErro("Cursor de trabalho n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em BtnIncluirClick")
596:                 RETURN
597:             ENDIF
598: 
599:             SELECT cursor_4c_Operacao
600:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
601:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
602:             THIS.this_lGravaDados = .T.
603: 
604:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
605:                 THIS.grd_4c_Dados.Refresh()
606:                 THIS.grd_4c_Dados.Column1.SetFocus()
607:             ENDIF
608:         CATCH TO loc_oErro
609:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
610:         ENDTRY
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * BtnAlterarClick - Coloca foco no grid para editar registro corrente
615:     * Legado: sem equivalente direto (dialogo ja abre em modo edicao).

*-- Linhas 629 a 647:
629:                 RETURN
630:             ENDIF
631: 
632:             SELECT cursor_4c_Operacao
633:             IF EOF()
634:                 GO BOTTOM
635:             ENDIF
636: 
637:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
638:                 THIS.grd_4c_Dados.Refresh()
639:                 THIS.grd_4c_Dados.Column1.SetFocus()
640:             ENDIF
641:         CATCH TO loc_oErro
642:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
643:         ENDTRY
644:     ENDPROC
645: 
646:     *--------------------------------------------------------------------------
647:     * BtnVisualizarClick - Recarrega grupos do SQL Server no grid

*-- Linhas 677 a 721:
677: 
678:     *--------------------------------------------------------------------------
679:     * BtnExcluirClick - Exclui registro corrente do grid
680:     * Legado: cmdExcluir.Click -> Delete + Skip + Go Bott se EOF
681:     *--------------------------------------------------------------------------
682:     PROCEDURE BtnExcluirClick()
683:         LOCAL loc_lConfirma, loc_oErro
684:         TRY
685:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
686:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite exclus" + CHR(227) + "o.", "Aviso")
687:                 RETURN
688:             ENDIF
689: 
690:             IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
691:                 MsgAviso("Nenhum registro para excluir.", "Aviso")
692:                 RETURN
693:             ENDIF
694: 
695:             SELECT cursor_4c_Operacao
696:             IF EOF()
697:                 MsgAviso("Posicione em um registro para excluir.", "Aviso")
698:                 RETURN
699:             ENDIF
700: 
701:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
702:             IF !loc_lConfirma
703:                 RETURN
704:             ENDIF
705: 
706:             DELETE
707:             SKIP
708:             IF EOF()
709:                 GO BOTTOM
710:             ENDIF
711:             THIS.this_lGravaDados = .T.
712: 
713:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
714:                 THIS.grd_4c_Dados.Refresh()
715:                 THIS.grd_4c_Dados.SetFocus()
716:             ENDIF
717:         CATCH TO loc_oErro
718:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
719:         ENDTRY
720:     ENDPROC
721: 

*-- Linhas 751 a 791:
751:             IF !EMPTY(loc_cCgrus)
752:                 *-- Busca exata em SigCdGrp
753:                 loc_cDgrus = ""
754:                 loc_cSQL = "SELECT TOP 1 dgrus FROM SigCdGrp WHERE RTRIM(cgrus) = " + ;
755:                            EscaparSQL(loc_cCgrus)
756: 
757:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpBusca") > 0 AND ;
758:                    RECCOUNT("cursor_4c_GrpBusca") > 0
759:                     SELECT cursor_4c_GrpBusca
760:                     loc_cDgrus = ALLTRIM(dgrus)
761:                     USE IN cursor_4c_GrpBusca
762: 
763:                     *-- Atualizar Dgrus na linha corrente do cursor de trabalho
764:                     SELECT cursor_4c_Operacao
765:                     REPLACE Dgrus WITH loc_cDgrus
766:                     THIS.this_lGravaDados = .T.
767:                 ELSE
768:                     IF USED("cursor_4c_GrpBusca")
769:                         USE IN cursor_4c_GrpBusca
770:                     ENDIF
771:                     *-- Nao encontrou: abrir picker (nao exibir aviso antes, conforme CLAUDE.md)
772:                     THIS.AbrirLookupGrupo(loc_cCgrus)
773:                 ENDIF
774:             ELSE
775:                 *-- Limpar descricao quando codigo em branco
776:                 SELECT cursor_4c_Operacao
777:                 REPLACE Cgrus WITH SPACE(3), Dgrus WITH SPACE(20)
778:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
779:             ENDIF
780: 
781:             THIS.grd_4c_Dados.Refresh()
782:         CATCH TO loc_oErro
783:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GrdDadosCol1KeyPress")
784:         ENDTRY
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
789:     * Original: fwbuscaext com Cgrus/Dgrus
790:     *--------------------------------------------------------------------------
791:     PROCEDURE AbrirLookupGrupo(par_cValorInicial)

*-- Linhas 813 a 837:
813:                 loc_oBusca.Show()
814: 
815:                 IF USED("cursor_4c_GrpLookup") AND RECCOUNT("cursor_4c_GrpLookup") > 0
816:                     SELECT cursor_4c_GrpLookup
817:                     LOCAL loc_cCgrusOk, loc_cDgrusOk
818:                     loc_cCgrusOk = ALLTRIM(cgrus)
819:                     loc_cDgrusOk = ALLTRIM(dgrus)
820:                     USE IN cursor_4c_GrpLookup
821: 
822:                     SELECT cursor_4c_Operacao
823:                     REPLACE Cgrus WITH loc_cCgrusOk, Dgrus WITH loc_cDgrusOk
824:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCgrusOk
825:                     THIS.this_lGravaDados = .T.
826:                 ENDIF
827:             ENDIF
828: 
829:             THIS.grd_4c_Dados.Refresh()
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
832:         ENDTRY
833:     ENDPROC
834: 
835:     *--------------------------------------------------------------------------
836:     * GrdDadosCol2When - Bloqueia edicao da Column2 (Dgrus - somente leitura)
837:     * Original: Column2.Text1.When = Return .f.

*-- Linhas 941 a 959:
941:     *--------------------------------------------------------------------------
942:     PROCEDURE LimparCampos()
943:         IF USED("cursor_4c_Operacao")
944:             SELECT cursor_4c_Operacao
945:             ZAP
946:             THIS.this_lGravaDados = .T.
947:         ENDIF
948:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
949:             THIS.grd_4c_Dados.Refresh()
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * CarregarLista - Carrega grupos da operacao no grid
955:     * Wrapper sobre CarregarDados para compatibilidade com o pipeline
956:     *--------------------------------------------------------------------------
957:     PROCEDURE CarregarLista()
958:         LOCAL loc_lSucesso
959:         loc_lSucesso = .F.


### BO (C:\4c\projeto\app\classes\GpsBO.prg):
*==============================================================================
* GpsBO.prg - Business Object para Grupos de Produtos (Sub-nivel)
* Tabelas: SigCdGgp (tipo GGP) / SigCdGps (tipo GPS)
* Gerado: Fase 1/8 - Propriedades e Init
*         Fase 2/8 - Metodos CRUD
*==============================================================================

DEFINE CLASS GpsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade
    *--------------------------------------------------------------------------

    *-- Identificacao da operacao (Dopes de SigCdOpe)
    this_cDopes     = ""

    *-- Codigo do grupo (Cgrus de SigCdGrp - char(3))
    this_cCgrus     = ""

    *-- Descricao do grupo (Dgrus de SigCdGrp - char(30))
    this_cDgrus     = ""

    *-- Controla qual tabela usar: .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    this_lTipoggp   = .F.

    *-- Modo de edicao recebido do form pai: 'INSERIR', 'ALTERAR', etc.
    this_cEscolha   = ""

    *-- Flag que indica se houve alteracao de dados no grid
    this_lGravaDados = .F.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- Tabela padrao GGP; o form comuta para GPS via this_lTipoggp
        this_cTabela     = "SigCdGgp"
        this_cCampoChave = "pkchave"

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta (Dopes + Cgrus) para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes) + "|" + ALLTRIM(THIS.this_cCgrus)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor de trabalho nas propriedades do BO
    * par_cAliasCursor: nome do cursor (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes = TratarNulo(Dopes, "C")
                THIS.this_cCgrus = TratarNulo(Cgrus, "C")
                THIS.this_cDgrus = TratarNulo(Dgrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um unico registro de grupo no SQL Server
    * Usa: this_cDopes, this_cCgrus, this_lTipoggp
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo, loc_cChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.this_lTipoggp
                loc_cTabela  = "SigCdGgp"
                loc_cPkCampo = "pkchave"
            ELSE
                loc_cTabela  = "SigCdGps"
                loc_cPkCampo = "cIdChaves"
            ENDIF

            loc_cChave = LOWER(SYS(2015) + SYS(2015))

            loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                       " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel: grupos sao gerenciados via SalvarGrupos (batch)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os grupos de uma operacao (Dopes)
    * Chamado internamente pelo ciclo de salvamento (SalvarGrupos)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTabela = IIF(THIS.this_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do SQL Server em cursor temporario
    * par_cDopes   : Dopes da operacao (SigCdOpe)
    * par_lTipoggp : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * Resultado: cursor_4c_GruposTemp (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cDopes, par_lTipoggp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_cTabela = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM " + loc_cTabela + " a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos da opera" + CHR(231) + CHR(227) + "o.", "Erro em CarregarGrupos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Verifica duplicidade de Cgrus no cursor de trabalho
    * par_cCursorOpe : Nome do cursor de trabalho (ex: "cursor_4c_Operacao")
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicados(par_cCursorOpe)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorOpe) AND RECCOUNT(par_cCursorOpe) > 0
                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF

                SELECT Cgrus, SUM(1) AS Qt ;
                    FROM (par_cCursorOpe) ;
                    WHERE NOT EMPTY(ALLTRIM(Cgrus)) ;
                    GROUP BY Cgrus ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupVerif READWRITE

                IF USED("cursor_4c_DupVerif") AND RECCOUNT("cursor_4c_DupVerif") > 0
                    loc_lValido = .F.
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF

                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDuplicados")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Ciclo completo: exclui registros existentes e reinsere
    * par_cDopes     : Dopes da operacao identificando os grupos
    * par_lTipoggp   : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * par_cCursorOpe : Nome do cursor de trabalho com grupos editados pelo usuario
    * Retorna .T. se salvou com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cDopes, par_lTipoggp, par_cCursorOpe)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo
        LOCAL loc_cChave, loc_cCgrus, loc_lTransAtiva, loc_lErroInsert, loc_oErro
        loc_lSucesso    = .F.
        loc_lTransAtiva = .F.
        loc_lErroInsert = .F.
        TRY
            loc_cTabela  = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cPkCampo = IIF(par_lTipoggp, "pkchave", "cIdChaves")

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAtiva = .T.

            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0

                IF USED(par_cCursorOpe)
                    SELECT (par_cCursorOpe)
                    GO TOP
                    DO WHILE !EOF() AND !loc_lErroInsert
                        IF !DELETED()
                            loc_cCgrus = ALLTRIM(Cgrus)
                            IF !EMPTY(loc_cCgrus)
                                loc_cChave = LOWER(SYS(2015) + SYS(2015))
                                loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                                           " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                                           EscaparSQL(loc_cCgrus) + ", " + ;
                                           EscaparSQL(loc_cChave) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_lErroInsert
                            SELECT (par_cCursorOpe)
                            SKIP
                        ENDIF
                    ENDDO
                ENDIF

                IF !loc_lErroInsert
                    IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                        loc_lTransAtiva = .F.
                        THIS.this_cDopes    = ALLTRIM(par_cDopes)
                        THIS.this_lTipoggp  = par_lTipoggp
                        THIS.RegistrarAuditoria("A")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro em SalvarGrupos")
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir grupo " + loc_cCgrus + ".", "Erro em SalvarGrupos")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em SalvarGrupos")
            ENDIF

            IF loc_lTransAtiva AND !loc_lSucesso
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransAtiva = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

