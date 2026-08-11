# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COLUMNCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DOPES, CGRUS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGps.prg) - TRECHOS RELEVANTES PARA PASS SQL (999 linhas total):

*-- Linhas 197 a 230:
197:         IF USED("cursor_4c_Operacao")
198:             USE IN cursor_4c_Operacao
199:         ENDIF
200:         CREATE CURSOR cursor_4c_Operacao (Dopes C(20), Cgrus C(3), Dgrus C(20))
201:         SET NULL OFF
202:         INDEX ON Cgrus TAG Cgrus
203:         SET ORDER TO
204: 
205:         *-- Criar grid
206:         THIS.AddObject("grd_4c_Dados", "Grid")
207:         loc_oGrid = THIS.grd_4c_Dados
208:         WITH loc_oGrid
209:             .Top            = 87
210:             .Left           = 236
211:             .Width          = 264
212:             .Height         = 364
213:             .ColumnCount    = 2
214:             .FontName       = "Tahoma"
215:             .DeleteMark     = .F.
216:             .RecordMark     = .F.
217:             .ScrollBars     = 2
218:             .GridLineColor  = RGB(238,238,238)
219:             .HighlightStyle = 2
220:             .TabIndex       = 1
221:         ENDWITH
222: 
223:         WITH loc_oGrid.Column1
224:             .FontName   = "Tahoma"
225:             .Width      = 50
226:             .Movable    = .F.
227:             .Resizable  = .F.
228:             .BackColor  = RGB(255,255,255)
229:             WITH .Header1
230:                 .FontName   = "Tahoma"

*-- Linhas 253 a 272:
253:         *-- Vincular grid ao cursor
254:         loc_oGrid.ColumnCount = 2
255:         loc_oGrid.RecordSource          = "cursor_4c_Operacao"
256:         loc_oGrid.Column1.ControlSource = "cursor_4c_Operacao.Cgrus"
257:         loc_oGrid.Column2.ControlSource = "cursor_4c_Operacao.Dgrus"
258: 
259:         *-- Reconfigurar headers apos RecordSource (VFP reseta headers)
260:         WITH loc_oGrid.Column1.Header1
261:             .Caption = "Grupo"
262:         ENDWITH
263:         WITH loc_oGrid.Column2.Header1
264:             .Caption = "Descri" + CHR(231) + CHR(227) + "o"
265:         ENDWITH
266: 
267:         *-- Bindar KeyPress da Column1 para lookup de Cgrus
268:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1KeyPress")
269:     ENDPROC
270: 
271:     *--------------------------------------------------------------------------
272:     * ConfigurarPaginaDados - Configura propriedades visuais dos Text1 do grid

*-- Linhas 433 a 466:
433: 
434:     *--------------------------------------------------------------------------
435:     * CarregarDados - Carrega grupos do SQL Server no cursor de trabalho
436:     * Equivale ao SQLEXEC + Scan/Append Blank/Gather do legado
437:     *--------------------------------------------------------------------------
438:     PROTECTED PROCEDURE CarregarDados()
439:         LOCAL loc_oErro
440:         TRY
441:             IF !EMPTY(THIS.this_cDopes) AND THIS.this_oBusinessObject.CarregarGrupos(THIS.this_cDopes, THIS.this_lTipoggp)
442:                 IF USED("cursor_4c_GruposTemp")
443:                     SELECT cursor_4c_Operacao
444:                     ZAP
445:                     APPEND FROM DBF("cursor_4c_GruposTemp")
446:                     USE IN cursor_4c_GruposTemp
447:                 ENDIF
448:             ENDIF
449: 
450:             IF USED("cursor_4c_Operacao")
451:                 SELECT cursor_4c_Operacao
452:                 SET ORDER TO
453:                 GO TOP
454:             ENDIF
455: 
456:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
457:                 THIS.grd_4c_Dados.Refresh()
458:             ENDIF
459:         CATCH TO loc_oErro
460:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
461:         ENDTRY
462:     ENDPROC
463: 
464:     *--------------------------------------------------------------------------
465:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
466:     *--------------------------------------------------------------------------

*-- Linhas 485 a 557:
485: 
486:     *--------------------------------------------------------------------------
487:     * CmdInserirClick - Insere linha em branco no grid
488:     * Original: Insert Into xOpe (Cgrus) Values (Space(20))
489:     *--------------------------------------------------------------------------
490:     PROCEDURE CmdInserirClick()
491:         LOCAL loc_oErro
492:         TRY
493:             SELECT cursor_4c_Operacao
494:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
495:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
496:             THIS.this_lGravaDados = .T.
497:             THIS.grd_4c_Dados.Column1.SetFocus()
498:         CATCH TO loc_oErro
499:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
500:         ENDTRY
501:     ENDPROC
502: 
503:     *--------------------------------------------------------------------------
504:     * CmdExcluirClick - Exclui linha corrente do grid
505:     * Original: Delete + Skip, Go Bott se EOF()
506:     *--------------------------------------------------------------------------
507:     PROCEDURE CmdExcluirClick()
508:         LOCAL loc_oErro
509:         TRY
510:             SELECT cursor_4c_Operacao
511:             IF !EOF()
512:                 DELETE
513:                 SKIP
514:                 IF EOF()
515:                     GO BOTTOM
516:                 ENDIF
517:             ENDIF
518:             THIS.this_lGravaDados = .T.
519:             THIS.grd_4c_Dados.SetFocus()
520:             THIS.grd_4c_Dados.Refresh()
521:         CATCH TO loc_oErro
522:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
523:         ENDTRY
524:     ENDPROC
525: 
526:     *--------------------------------------------------------------------------
527:     * CmdConfirmarClick - Valida e salva grupos no SQL Server
528:     * Original: cmdSair.Click - valida duplicidade, DELETE+INSERT em transacao
529:     *--------------------------------------------------------------------------
530:     PROCEDURE CmdConfirmarClick()
531:         LOCAL loc_lSucesso, loc_lPodeFechar, loc_oErro
532:         loc_lSucesso    = .F.
533:         loc_lPodeFechar = .T.
534:         TRY
535:             IF THIS.this_lGravaDados
536:                 *-- Validar duplicidade de Cgrus no cursor
537:                 IF !THIS.this_oBusinessObject.ValidarDuplicados("cursor_4c_Operacao")
538:                     loc_lPodeFechar = .F.
539:                 ENDIF
540: 
541:                 IF loc_lPodeFechar
542:                     *-- Salvar: DELETE todos existentes + INSERT novos em transacao
543:                     loc_lSucesso = THIS.this_oBusinessObject.SalvarGrupos( ;
544:                         THIS.this_cDopes, ;
545:                         THIS.this_lTipoggp, ;
546:                         "cursor_4c_Operacao" ;
547:                     )
548: 
549:                     IF !loc_lSucesso
550:                         MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", "Erro")
551:                         loc_lPodeFechar = .F.
552:                     ENDIF
553:                 ENDIF
554:             ENDIF
555: 
556:             IF loc_lPodeFechar
557:                 *-- Re-habilitar form pai e fechar

*-- Linhas 583 a 617:
583: 
584:     *--------------------------------------------------------------------------
585:     * BtnIncluirClick - Insere nova linha em branco no grid
586:     * Legado: cmdInserir.Click -> Insert Into xOpe (Cgrus) Values (Space(20))
587:     *--------------------------------------------------------------------------
588:     PROCEDURE BtnIncluirClick()
589:         LOCAL loc_oErro
590:         TRY
591:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
592:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite inclus" + CHR(227) + "o.", "Aviso")
593:                 RETURN
594:             ENDIF
595: 
596:             IF !USED("cursor_4c_Operacao")
597:                 MsgErro("Cursor de trabalho n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em BtnIncluirClick")
598:                 RETURN
599:             ENDIF
600: 
601:             SELECT cursor_4c_Operacao
602:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
603:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
604:             THIS.this_lGravaDados = .T.
605: 
606:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
607:                 THIS.grd_4c_Dados.Refresh()
608:                 THIS.grd_4c_Dados.Column1.SetFocus()
609:             ENDIF
610:         CATCH TO loc_oErro
611:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
612:         ENDTRY
613:     ENDPROC
614: 
615:     *--------------------------------------------------------------------------
616:     * BtnAlterarClick - Coloca foco no grid para editar registro corrente
617:     * Legado: sem equivalente direto (dialogo ja abre em modo edicao).

*-- Linhas 631 a 649:
631:                 RETURN
632:             ENDIF
633: 
634:             SELECT cursor_4c_Operacao
635:             IF EOF()
636:                 GO BOTTOM
637:             ENDIF
638: 
639:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
640:                 THIS.grd_4c_Dados.Refresh()
641:                 THIS.grd_4c_Dados.Column1.SetFocus()
642:             ENDIF
643:         CATCH TO loc_oErro
644:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
645:         ENDTRY
646:     ENDPROC
647: 
648:     *--------------------------------------------------------------------------
649:     * BtnVisualizarClick - Recarrega grupos do SQL Server no grid

*-- Linhas 679 a 723:
679: 
680:     *--------------------------------------------------------------------------
681:     * BtnExcluirClick - Exclui registro corrente do grid
682:     * Legado: cmdExcluir.Click -> Delete + Skip + Go Bott se EOF
683:     *--------------------------------------------------------------------------
684:     PROCEDURE BtnExcluirClick()
685:         LOCAL loc_lConfirma, loc_oErro
686:         TRY
687:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
688:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite exclus" + CHR(227) + "o.", "Aviso")
689:                 RETURN
690:             ENDIF
691: 
692:             IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
693:                 MsgAviso("Nenhum registro para excluir.", "Aviso")
694:                 RETURN
695:             ENDIF
696: 
697:             SELECT cursor_4c_Operacao
698:             IF EOF()
699:                 MsgAviso("Posicione em um registro para excluir.", "Aviso")
700:                 RETURN
701:             ENDIF
702: 
703:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
704:             IF !loc_lConfirma
705:                 RETURN
706:             ENDIF
707: 
708:             DELETE
709:             SKIP
710:             IF EOF()
711:                 GO BOTTOM
712:             ENDIF
713:             THIS.this_lGravaDados = .T.
714: 
715:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
716:                 THIS.grd_4c_Dados.Refresh()
717:                 THIS.grd_4c_Dados.SetFocus()
718:             ENDIF
719:         CATCH TO loc_oErro
720:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
721:         ENDTRY
722:     ENDPROC
723: 

*-- Linhas 753 a 793:
753:             IF !EMPTY(loc_cCgrus)
754:                 *-- Busca exata em SigCdGrp
755:                 loc_cDgrus = ""
756:                 loc_cSQL = "SELECT TOP 1 dgrus FROM SigCdGrp WHERE RTRIM(cgrus) = " + ;
757:                            EscaparSQL(loc_cCgrus)
758: 
759:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpBusca") > 0 AND ;
760:                    RECCOUNT("cursor_4c_GrpBusca") > 0
761:                     SELECT cursor_4c_GrpBusca
762:                     loc_cDgrus = ALLTRIM(dgrus)
763:                     USE IN cursor_4c_GrpBusca
764: 
765:                     *-- Atualizar Dgrus na linha corrente do cursor de trabalho
766:                     SELECT cursor_4c_Operacao
767:                     REPLACE Dgrus WITH loc_cDgrus
768:                     THIS.this_lGravaDados = .T.
769:                 ELSE
770:                     IF USED("cursor_4c_GrpBusca")
771:                         USE IN cursor_4c_GrpBusca
772:                     ENDIF
773:                     *-- Nao encontrou: abrir picker (nao exibir aviso antes, conforme CLAUDE.md)
774:                     THIS.AbrirLookupGrupo(loc_cCgrus)
775:                 ENDIF
776:             ELSE
777:                 *-- Limpar descricao quando codigo em branco
778:                 SELECT cursor_4c_Operacao
779:                 REPLACE Cgrus WITH SPACE(3), Dgrus WITH SPACE(20)
780:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
781:             ENDIF
782: 
783:             THIS.grd_4c_Dados.Refresh()
784:         CATCH TO loc_oErro
785:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GrdDadosCol1KeyPress")
786:         ENDTRY
787:     ENDPROC
788: 
789:     *--------------------------------------------------------------------------
790:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
791:     * Original: fwbuscaext com Cgrus/Dgrus
792:     *--------------------------------------------------------------------------
793:     PROCEDURE AbrirLookupGrupo(par_cValorInicial)

*-- Linhas 815 a 839:
815:                 loc_oBusca.Show()
816: 
817:                 IF USED("cursor_4c_GrpLookup") AND RECCOUNT("cursor_4c_GrpLookup") > 0
818:                     SELECT cursor_4c_GrpLookup
819:                     LOCAL loc_cCgrusOk, loc_cDgrusOk
820:                     loc_cCgrusOk = ALLTRIM(cgrus)
821:                     loc_cDgrusOk = ALLTRIM(dgrus)
822:                     USE IN cursor_4c_GrpLookup
823: 
824:                     SELECT cursor_4c_Operacao
825:                     REPLACE Cgrus WITH loc_cCgrusOk, Dgrus WITH loc_cDgrusOk
826:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCgrusOk
827:                     THIS.this_lGravaDados = .T.
828:                 ENDIF
829:             ENDIF
830: 
831:             THIS.grd_4c_Dados.Refresh()
832:         CATCH TO loc_oErro
833:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
834:         ENDTRY
835:     ENDPROC
836: 
837:     *--------------------------------------------------------------------------
838:     * GrdDadosCol2When - Bloqueia edicao da Column2 (Dgrus - somente leitura)
839:     * Original: Column2.Text1.When = Return .f.

*-- Linhas 943 a 961:
943:     *--------------------------------------------------------------------------
944:     PROCEDURE LimparCampos()
945:         IF USED("cursor_4c_Operacao")
946:             SELECT cursor_4c_Operacao
947:             ZAP
948:             THIS.this_lGravaDados = .T.
949:         ENDIF
950:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
951:             THIS.grd_4c_Dados.Refresh()
952:         ENDIF
953:     ENDPROC
954: 
955:     *--------------------------------------------------------------------------
956:     * CarregarLista - Carrega grupos da operacao no grid
957:     * Wrapper sobre CarregarDados para compatibilidade com o pipeline
958:     *--------------------------------------------------------------------------
959:     PROCEDURE CarregarLista()
960:         LOCAL loc_lSucesso
961:         loc_lSucesso = .F.


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

