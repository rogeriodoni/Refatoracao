# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTADS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NENVS, DOPPS, SUBNS, GRCOMPS, EMPDNPS, GRUPODS, ICLIS, QT, GERBALS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NENVS, DOPPS, SUBNS, GRCOMPS, EMPDNPS, GRUPODS, ICLIS, QT, GERBALS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NENVS, DOPPS, SUBNS, GRCOMPS, EMPDNPS, GRUPODS, ICLIS, QT, GERBALS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, NENVS, DOPPS, SUBNS, GRCOMPS, EMPDNPS, GRUPODS, ICLIS, QT, GERBALS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQuery = [Select distinct b.Nenvs ] + ;
		    [From SigCdNec a, SigCdNei b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdNec') < 1)
Select crSigCdNec
		loBarra.Update(.t.)
		lcQuery = [Select Distinct Nenvs, EmpDnPs, Dopps From SigCdNei Where Nenvs = ]+Str(CrSigCdNec.Nenvs)
		If Thisform.PodataMgr.SqlExecute(lcQuery,'LocNensi') < 1
		Select LocNensI
			lcQuery = [Select Dopps,Subns,GrComps,SepPedras From SigCdOpd where Dopps = ']+LocNensI.Dopps+[']
			If Thisform.PodataMgr.SqlExecute(lcQuery,'TmpOpp') < 1
			lcQuery = [Select * From SigCdNec Where EmpDnPs = ']+LocNensI.EmpDnPs+[']
			If Thisform.PodataMgr.SqlExecute(lcQuery,'LocNens') < 1
			Select LocNens
			lcQuery = [Select Rclis From SigCdCli Where Iclis = ']+LocNens.ContaOs+[']
			If Thisform.PodataMgr.SqlExecute(lcQuery,'TmpCli') < 1
			lcQuery = [Select Rclis From SigCdCli Where Iclis = ']+LocNens.ContaDs+[']
			If Thisform.PodataMgr.SqlExecute(lcQuery,'TmpCli') < 1
			Select TmpRelat
			Select Envelope
			If Not Seek(Str(LocNensI.Nenvs,10)+LocNens.GrupoDS)
Insert Into dbCabecalho (Titulo, SubTitulo, NomeEmpresa) Values (lcCab, lcSub, lcEmp)
Select A.* From TmpRelat A, Envelope B Where a.Nenvs = b.Nenvs And a.GrupoDs = b.grupoDs And b.Qt > 1 ;
Select CsSelecao
		lcQuery = [Select Codigos, Descrs ] + ;
				    [From SigCdGcr ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
		Select crSigCdGcr
		lcQuery = [Select IClis, RClis, Inativas ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		Select crSigCdCli
	Select crSigCdGcr
	If Not Seek(This.Value)
	Select crSigCdCli
	If Not Seek(This.Value)
	Select crSigCdCli
	If Not Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEvd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1059 linhas total):

*-- Linhas 561 a 584:
561:                 THIS.AtualizarEstadoCampos()
562:                 RETURN
563:             ENDIF
564:             loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr " + ;
565:                           "WHERE Codigos = " + EscaparSQL(loc_cCodigo) + ;
566:                           " AND GerBals = 1"
567:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdGrpVal")
568:             IF loc_nResult > 0 AND !EOF("cursor_4c_EvdGrpVal")
569:                 SELECT cursor_4c_EvdGrpVal
570:                 loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
571:             ELSE
572:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "Grupo")
573:                 loc_oPg.txt_4c_Grupo.Value  = ""
574:                 loc_oPg.txt_4c_Conta.Value  = ""
575:                 loc_oPg.txt_4c_Dconta.Value = ""
576:                 THIS.AbrirLookupGrupo()
577:             ENDIF
578:             IF USED("cursor_4c_EvdGrpVal")
579:                 USE IN cursor_4c_EvdGrpVal
580:             ENDIF
581:         CATCH TO loc_oErro
582:             MsgErro(loc_oErro.Message, "Erro")
583:         ENDTRY
584:         THIS.AtualizarEstadoCampos()

*-- Linhas 598 a 616:
598:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
599:                 loc_oBusca.Show()
600:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
601:                     SELECT (loc_cCursor)
602:                     loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
603:                 ENDIF
604:                 loc_oBusca.Release()
605:             ENDIF
606:         CATCH TO loc_oErro
607:             MsgErro(loc_oErro.Message, "Erro")
608:         ENDTRY
609:         IF USED(loc_cCursor)
610:             USE IN (loc_cCursor)
611:         ENDIF
612:         THIS.AtualizarEstadoCampos()
613:     ENDPROC
614: 
615:     *==========================================================================
616:     *  VALIDACAO E LOOKUP - Conta (SigCdCli: IClis/codigo; preenche tb DConta)

*-- Linhas 631 a 654:
631:                 THIS.AtualizarEstadoCampos()
632:                 RETURN
633:             ENDIF
634:             loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
635:                           "WHERE IClis = " + EscaparSQL(loc_cCodigo) + ;
636:                           " AND GerBals = 1"
637:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdContVal")
638:             IF loc_nResult > 0 AND !EOF("cursor_4c_EvdContVal")
639:                 SELECT cursor_4c_EvdContVal
640:                 loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
641:                 loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
642:             ELSE
643:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
644:                 loc_oPg.txt_4c_Conta.Value  = ""
645:                 loc_oPg.txt_4c_Dconta.Value = ""
646:                 THIS.AbrirLookupConta()
647:             ENDIF
648:             IF USED("cursor_4c_EvdContVal")
649:                 USE IN cursor_4c_EvdContVal
650:             ENDIF
651:         CATCH TO loc_oErro
652:             MsgErro(loc_oErro.Message, "Erro")
653:         ENDTRY
654:         THIS.AtualizarEstadoCampos()

*-- Linhas 668 a 686:
668:                 loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
669:                 loc_oBusca.Show()
670:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
671:                     SELECT (loc_cCursor)
672:                     loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
673:                     loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
674:                 ELSE
675:                     loc_oPg.txt_4c_Conta.Value  = ""
676:                     loc_oPg.txt_4c_Dconta.Value = ""
677:                 ENDIF
678:                 loc_oBusca.Release()
679:             ENDIF
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message, "Erro")
682:         ENDTRY
683:         IF USED(loc_cCursor)
684:             USE IN (loc_cCursor)
685:         ENDIF
686:         THIS.AtualizarEstadoCampos()

*-- Linhas 707 a 730:
707:                 THIS.AtualizarEstadoCampos()
708:                 RETURN
709:             ENDIF
710:             loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
711:                           "WHERE RClis = " + EscaparSQL(loc_cNome) + ;
712:                           " AND GerBals = 1"
713:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EvdDcVal")
714:             IF loc_nResult > 0 AND !EOF("cursor_4c_EvdDcVal")
715:                 SELECT cursor_4c_EvdDcVal
716:                 loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
717:                 loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
718:             ELSE
719:                 MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
720:                 loc_oPg.txt_4c_Conta.Value  = ""
721:                 loc_oPg.txt_4c_Dconta.Value = ""
722:                 THIS.AbrirLookupDconta()
723:             ENDIF
724:             IF USED("cursor_4c_EvdDcVal")
725:                 USE IN cursor_4c_EvdDcVal
726:             ENDIF
727:         CATCH TO loc_oErro
728:             MsgErro(loc_oErro.Message, "Erro")
729:         ENDTRY
730:         THIS.AtualizarEstadoCampos()

*-- Linhas 744 a 762:
744:                 loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
745:                 loc_oBusca.Show()
746:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
747:                     SELECT (loc_cCursor)
748:                     loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
749:                     loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
750:                 ELSE
751:                     loc_oPg.txt_4c_Conta.Value  = ""
752:                     loc_oPg.txt_4c_Dconta.Value = ""
753:                 ENDIF
754:                 loc_oBusca.Release()
755:             ENDIF
756:         CATCH TO loc_oErro
757:             MsgErro(loc_oErro.Message, "Erro")
758:         ENDTRY
759:         IF USED(loc_cCursor)
760:             USE IN (loc_cCursor)
761:         ENDIF
762:         THIS.AtualizarEstadoCampos()


### BO (C:\4c\projeto\app\classes\SigReEvdBO.prg):
*==============================================================================
* SIGREEVDBO.PRG
* Business Object - Demonstrativo de Envelopes Duplicados
*
* Herda de: RelatorioBase
* Formulario: FormSigReEvd.prg
* Relatorio:  SigReEvd.frx
* Tabelas:    SigCdNec, SigCdNei, SigCdOpd, SigCdCli, SigCdGcr, SigCdEmp
*==============================================================================

DEFINE CLASS SigReEvdBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cGrupo       = ""
    this_cConta       = ""
    this_cDConta      = ""
    this_dDatai       = {}
    this_dDataf       = {}

    *-- Cursor de dados resultado
    this_cCursorDados = "cursor_4c_Dados"

    *-- Propriedades espelhando colunas de cursor_4c_Dados (registro corrente)
    *-- Carregadas por CarregarDoCursor() para inspecao/drill-down do relatorio
    this_nNenvs    = 0
    this_cGrupoOs  = ""
    this_cContaOs  = ""
    this_cRCliOs   = ""
    this_dDatas    = {}
    this_cGrupoDs  = ""
    this_cContaDs  = ""
    this_cRCliDs   = ""
    this_cEmpDnPs  = ""
    this_lRetrabs  = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de lookup para grupos e clientes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Carregar grupos (SigCdGcr) para lookup de Get_Grupo
            loc_cSQL = "SELECT Codigos, Descrs " + ;
                       "FROM SigCdGcr " + ;
                       "WHERE GerBals = 1"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
            IF loc_nResult >= 1
                *-- Carregar clientes (SigCdCli) para lookup de Get_Conta / Get_DConta
                loc_cSQL = "SELECT IClis, RClis, Inativas " + ;
                           "FROM SigCdCli " + ;
                           "WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Clientes")
                IF loc_nResult >= 1
                    loc_lSucesso = DODEFAULT()
                ELSE
                    MsgErro("Falha ao carregar clientes (SigCdCli)", "SigReEvdBO.Init")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar grupos (SigCdGcr)", "SigReEvdBO.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * PrepararDados - Processa envelopes duplicados conforme os filtros.
    * Equivalente ao metodo 'processamento' do form legado SIGREEVD.
    * Popula cursor_4c_Dados (registros a imprimir) e cursor_4c_Cabecalho.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_lcGrupo, loc_lcConta, loc_ldDatai, loc_ldDataf, loc_cDtFSQL
        LOCAL loc_lcCliOs, loc_lcCliDs, loc_lcEmp, loc_lcCab, loc_lcSub
        LOCAL loc_nNenvs, loc_cGrupoOs, loc_cContaOs, loc_dDatas
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPs, loc_lRetrabs
        loc_lSucesso = .F.
        TRY
            loc_lcGrupo = ALLTRIM(THIS.this_cGrupo)
            loc_lcConta = ALLTRIM(THIS.this_cConta)
            loc_ldDatai = THIS.this_dDatai
            loc_ldDataf = THIS.this_dDataf

            *-- Data final com 23:59:59 para cobrir dia inteiro (Datas eh DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_ldDataf),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataf), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataf),   2, "0") + " 23:59:59'"

            *-- Criar cursores de trabalho locais
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF
            CREATE CURSOR cursor_4c_Envelope (Nenvs N(10), GrupoDs C(10), Qt N(5))
            INDEX ON STR(Nenvs, 10) + GrupoDs TAG Nenvs

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            CREATE CURSOR cursor_4c_TmpRelat ( ;
                Nenvs   N(10), GrupoOs C(10), ContaOs C(10), RCliOs C(50), ;
                Datas   D,     GrupoDs C(10), ContaDs C(10), RCliDs C(50), ;
                EmpDnPs C(33), Retrabs L)

            *-- Clausula WHERE com filtros opcionais de grupo e conta
            loc_cWhere = "a.Datas BETWEEN " + FormatarDataSQL(loc_ldDatai) + ;
                         " AND " + loc_cDtFSQL
            IF !EMPTY(loc_lcGrupo)
                loc_cWhere = loc_cWhere + " AND a.GrupoDs = " + EscaparSQL(loc_lcGrupo)
            ENDIF
            IF !EMPTY(loc_lcConta)
                loc_cWhere = loc_cWhere + " AND a.ContaDs = " + EscaparSQL(loc_lcConta)
            ENDIF

            *-- Buscar envelopes distintos no periodo/filtros
            loc_cSQL = "SELECT DISTINCT b.Nenvs " + ;
                       "FROM SigCdNec a, SigCdNei b " + ;
                       "WHERE " + loc_cWhere + " AND a.EmpDNps = b.EmpDNps " + ;
                       "ORDER BY b.Nenvs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NecBase")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao buscar envelopes (SigCdNec/SigCdNei)"
                MsgErro("Falha ao buscar envelopes (SigCdNec/SigCdNei)", "PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- Processar cada numero de envelope encontrado
            SELECT cursor_4c_NecBase
            SCAN
                IF cursor_4c_NecBase.Nenvs = 0
                    LOOP
                ENDIF

                *-- Buscar itens do envelope em SigCdNei
                loc_cSQL = "SELECT DISTINCT Nenvs, EmpDnPs, Dopps FROM SigCdNei " + ;
                           "WHERE Nenvs = " + TRANSFORM(cursor_4c_NecBase.Nenvs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensiLoc")
                IF loc_nResult < 1
                    IF USED("cursor_4c_NensiLoc")
                        USE IN cursor_4c_NensiLoc
                    ENDIF
                    SELECT cursor_4c_NecBase
                    LOOP
                ENDIF

                SELECT cursor_4c_NensiLoc
                SCAN
                    *-- Verificar tipo de operacao em SigCdOpd
                    loc_cSQL = "SELECT Dopps, Subns, GrComps, SepPedras FROM SigCdOpd " + ;
                               "WHERE Dopps = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.Dopps))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpp")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_TmpOpp")
                            USE IN cursor_4c_TmpOpp
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se operacao nao se qualifica (SepPedras 1/3, Subns!=1, GrComps!=1)
                    SELECT cursor_4c_TmpOpp
                    IF INLIST(cursor_4c_TmpOpp.SepPedras, 1, 3) OR ;
                       cursor_4c_TmpOpp.Subns <> 1 OR ;
                       cursor_4c_TmpOpp.GrComps <> 1
                        USE IN cursor_4c_TmpOpp
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF
                    USE IN cursor_4c_TmpOpp

                    *-- Buscar dados do envelope origem em SigCdNec pelo EmpDnPs
                    loc_cSQL = "SELECT GrupoOs, ContaOs, Datas, GrupoDs, ContaDs, " + ;
                               "EmpDnPs, Retrabs FROM SigCdNec " + ;
                               "WHERE EmpDnPs = " + EscaparSQL(ALLTRIM(cursor_4c_NensiLoc.EmpDnPs))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NensLoc")
                    IF loc_nResult < 1
                        IF USED("cursor_4c_NensLoc")
                            USE IN cursor_4c_NensLoc
                        ENDIF
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Pular se sem registro ou grupo reservado de estoque
                    SELECT cursor_4c_NensLoc
                    IF RECCOUNT() = 0 OR ALLTRIM(cursor_4c_NensLoc.GrupoDs) = "TRMOVESTQ"
                        USE IN cursor_4c_NensLoc
                        SELECT cursor_4c_NensiLoc
                        LOOP
                    ENDIF

                    *-- Buscar nome do cliente origem (ContaOs)
                    loc_lcCliOs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaOs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliOs") > 0
                        SELECT cursor_4c_TmpCliOs
                        IF !EOF()
                            loc_lcCliOs = ALLTRIM(cursor_4c_TmpCliOs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliOs
                    ENDIF

                    *-- Buscar nome do cliente destino (ContaDs)
                    loc_lcCliDs = ""
                    loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_NensLoc.ContaDs))
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCliDs") > 0
                        SELECT cursor_4c_TmpCliDs
                        IF !EOF()
                            loc_lcCliDs = ALLTRIM(cursor_4c_TmpCliDs.RClis)
                        ENDIF
                        USE IN cursor_4c_TmpCliDs
                    ENDIF

                    *-- Guardar valores antes de mudar work area
                    loc_nNenvs   = cursor_4c_NensiLoc.Nenvs
                    loc_cGrupoOs = ALLTRIM(cursor_4c_NensLoc.GrupoOs)
                    loc_cContaOs = ALLTRIM(cursor_4c_NensLoc.ContaOs)
                    loc_dDatas   = cursor_4c_NensLoc.Datas
                    loc_cGrupoDs = ALLTRIM(cursor_4c_NensLoc.GrupoDs)
                    loc_cContaDs = ALLTRIM(cursor_4c_NensLoc.ContaDs)
                    loc_cEmpDnPs = ALLTRIM(cursor_4c_NensLoc.EmpDnPs)
                    loc_lRetrabs = cursor_4c_NensLoc.Retrabs
                    USE IN cursor_4c_NensLoc

                    *-- Acumular no TmpRelat
                    SELECT cursor_4c_TmpRelat
                    APPEND BLANK
                    REPLACE Nenvs   WITH loc_nNenvs,   ;
                            GrupoOs WITH loc_cGrupoOs, ;
                            ContaOs WITH loc_cContaOs, ;
                            RCliOs  WITH loc_lcCliOs,  ;
                            Datas   WITH loc_dDatas,   ;
                            GrupoDs WITH loc_cGrupoDs, ;
                            ContaDs WITH loc_cContaDs, ;
                            RCliDs  WITH loc_lcCliDs,  ;
                            EmpDnPs WITH loc_cEmpDnPs, ;
                            Retrabs WITH loc_lRetrabs

                    *-- Atualizar contador de duplicados no cursor Envelope
                    SELECT cursor_4c_Envelope
                    SET ORDER TO TAG Nenvs
                    IF !SEEK(STR(loc_nNenvs, 10) + loc_cGrupoDs)
                        APPEND BLANK
                        REPLACE Nenvs   WITH loc_nNenvs, ;
                                GrupoDs WITH loc_cGrupoDs
                    ENDIF
                    REPLACE Qt WITH Qt + 1

                    SELECT cursor_4c_NensiLoc
                ENDSCAN

                IF USED("cursor_4c_NensiLoc")
                    USE IN cursor_4c_NensiLoc
                ENDIF
                SELECT cursor_4c_NecBase
            ENDSCAN

            IF USED("cursor_4c_NecBase")
                USE IN cursor_4c_NecBase
            ENDIF

            *-- Montar cabecalho do relatorio
            loc_lcCab = "Auditoria de Envelopes"
            loc_lcSub = "Per" + CHR(237) + "odo : " + ;
                        ALLTRIM(DTOC(loc_ldDatai)) + " at" + CHR(233) + " " + ;
                        ALLTRIM(DTOC(loc_ldDataf))

            loc_lcEmp = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRel") > 0
                SELECT cursor_4c_EmpRel
                IF !EOF()
                    loc_lcEmp = go_4c_Sistema.cCodEmpresa + " - " + ;
                                ALLTRIM(cursor_4c_EmpRel.Razas)
                ENDIF
                USE IN cursor_4c_EmpRel
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_lcCab, loc_lcSub, loc_lcEmp)

            *-- Cursor final: apenas envelopes realmente duplicados (Qt > 1)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            SELECT A.* FROM cursor_4c_TmpRelat A, cursor_4c_Envelope B ;
                WHERE A.Nenvs = B.Nenvs AND A.GrupoDs = B.GrupoDs AND B.Qt > 1 ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY A.Nenvs, A.Datas

            IF USED("cursor_4c_TmpRelat")
                USE IN cursor_4c_TmpRelat
            ENDIF
            IF USED("cursor_4c_Envelope")
                USE IN cursor_4c_Envelope
            ENDIF

            SELECT cursor_4c_Dados
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReEvdBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente do cursor de dados do
    * relatorio para as propriedades this_*. Util para drill-down, exportacao
    * registro a registro ou inspecao em testes. Aceita qualquer alias com a
    * mesma estrutura de cursor_4c_Dados (cursor_4c_TmpRelat).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), THIS.this_cCursorDados, par_cAliasCursor)
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o aberto: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor sem registro corrente: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            *-- Mapeamento das colunas do cursor para propriedades do BO.
            *-- Usar TYPE() para tolerar cursores com subset de colunas.
            IF TYPE(loc_cAlias + ".Nenvs") = "N"
                THIS.this_nNenvs = NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0)
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoOs") = "C"
                THIS.this_cGrupoOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaOs") = "C"
                THIS.this_cContaOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliOs") = "C"
                THIS.this_cRCliOs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliOs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Datas") = "D" OR TYPE(loc_cAlias + ".Datas") = "T"
                THIS.this_dDatas = NVL(EVALUATE(loc_cAlias + ".Datas"), {})
            ENDIF
            IF TYPE(loc_cAlias + ".GrupoDs") = "C"
                THIS.this_cGrupoDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".ContaDs") = "C"
                THIS.this_cContaDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ContaDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".RCliDs") = "C"
                THIS.this_cRCliDs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".RCliDs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".EmpDnPs") = "C"
                THIS.this_cEmpDnPs = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".EmpDnPs"), ""))
            ENDIF
            IF TYPE(loc_cAlias + ".Retrabs") = "L"
                THIS.this_lRetrabs = NVL(EVALUATE(loc_cAlias + ".Retrabs"), .F.)
            ELSE
                IF TYPE(loc_cAlias + ".Retrabs") = "N"
                    THIS.this_lRetrabs = (NVL(EVALUATE(loc_cAlias + ".Retrabs"), 0) = 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReEvdBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros. " + ;
            "Use PrepararDados() para gerar os dados."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o registro corrente, devolve "Nenvs|GrupoDs"
    * (chave composta que identifica o envelope duplicado no resultado).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cAlias
        loc_cChave = ""
        loc_cAlias = THIS.this_cCursorDados
        IF USED(loc_cAlias)
            SELECT (loc_cAlias)
            IF !EOF() AND !BOF()
                loc_cChave = ALLTRIM(STR(NVL(EVALUATE(loc_cAlias + ".Nenvs"), 0))) + ;
                             "|" + ALLTRIM(NVL(EVALUATE(loc_cAlias + ".GrupoDs"), ""))
            ENDIF
        ENDIF
        IF EMPTY(loc_cChave) AND THIS.this_nNenvs > 0
            loc_cChave = ALLTRIM(STR(THIS.this_nNenvs)) + "|" + ALLTRIM(THIS.this_cGrupoDs)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava operacao em LogAuditoria. Para relatorios
    * registra apenas a operacao "IMPRESSAO" com os filtros aplicados.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cFiltros, loc_cOper
        loc_lSucesso = .F.
        TRY
            loc_cOper = IIF(EMPTY(par_cOperacao), "IMPRESSAO", ALLTRIM(par_cOperacao))
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               ALLTRIM(gc_4c_UsuarioLogado), "")

            loc_cFiltros = "Grupo=" + ALLTRIM(THIS.this_cGrupo) + ;
                           "; Conta=" + ALLTRIM(THIS.this_cConta) + ;
                           "; DConta=" + ALLTRIM(THIS.this_cDConta) + ;
                           "; Datai=" + DTOC(THIS.this_dDatai) + ;
                           "; Dataf=" + DTOC(THIS.this_dDataf)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(TabelaNome, ChaveRegistro, Operacao, Usuario, DataHora, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigReEvd") + ", " + ;
                       EscaparSQL("RELATORIO") + ", " + ;
                       EscaparSQL(loc_cOper) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cFiltros, 500)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper o relatorio
            THIS.this_cMensagemErro = "Falha auditoria: " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_Clientes")
            USE IN cursor_4c_Clientes
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_TmpRelat")
            USE IN cursor_4c_TmpRelat
        ENDIF
        IF USED("cursor_4c_Envelope")
            USE IN cursor_4c_Envelope
        ENDIF
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

