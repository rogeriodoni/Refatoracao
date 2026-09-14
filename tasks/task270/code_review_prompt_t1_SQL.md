# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PNCOD, CODIGOS, DATAS, FASES, UNIPRDTS, CONTAS, CPROS, UNIDADE

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
		lcSql = [Select * From SigCdPcz Where codigos = ]+Str(pnCod)
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcp') < 1)
		lcSql = [Select Codigos, Sum(minutos) as Minutos, sum(minutos-Saldos) as UtilizadoS, Sum(saldos) as Saldos ]+;
				[From SigCdPcP Where Codigos = ]+Str(pncod)+[ And Datas = ?pDataI And Fases = ']+pFase+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcpcp') < 1)
		lcSql = [Select * from SigCdPcg Where datas = ?pDatai And Fases = ']+pFase+[' And Codigos = ]+Str(pnCod)+[ ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcppp') < 1)
		lcSql = [Select a.*, a.dopes+'-'+Str(a.numes,6) as Pedido, a.contas+'-'+b.rclis as cliente, b.Rclis ]+;
				[From SigCdPco a, SigCdCli b ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'zTmpPcpOP2') < 1)
		Select a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, sum(a.Minutos) as Minutos From zTmpPcpOp2 a, zTmpPcpPP b ;
		Select a.*, b.Minutos as TempU, c.Minutos as TempoO, fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60)) as TempoReal;
		From zTmpPcpOp2 a, zTmpPcpPp b, zTmpPcpOp3 c ;
Select zTmpPcpOp
	.Column1.ControlSource = 'zTmpPcpOp.nenvs'
	.Column2.Controlsource = 'zTmpPcpOp.Nops'
	.Column3.Controlsource = 'zTmpPcpOp.ordems'
	.Column4.Controlsource = 'zTmpPcpOp.TempoReal' &&'zTmpPcpOp.Minutos'
	.Column5.Controlsource = 'zTmpPcpOp.Cpros'
	.Column6.Controlsource = 'zTmpPcpOp.Pedido'
	.Column7.Controlsource = 'zTmpPcpOp.Cliente'
	.Column8.Controlsource = 'zTmpPcpOp.UniPrdts'
lcQuery = [Select FigJpgs, Dpros From SigCdPro Where Cpros= ']+zTmpPcpOp.Cpros+[']
=ThisForm.PodataMgr.SqlExecute(lcQuery,'CrTmpPro')
Select zTmpPcpOp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS SQL (1091 linhas total):

*-- Linhas 521 a 628:
521:                         .Movable       = .F.
522:                         .Resizable     = .F.
523:                         .ReadOnly      = .T.
524:                         .ControlSource = "cursor_4c_Dados.Nenvs"
525:                         .Header1.Caption   = "Envelope"
526:                         .Header1.FontName  = "Tahoma"
527:                         .Header1.FontSize  = 8
528:                         .Header1.Alignment = 2
529:                         .Header1.ForeColor = RGB(0, 0, 0)
530:                     ENDWITH
531:                     WITH .Column2
532:                         .ColumnOrder   = 3
533:                         .Width         = 100
534:                         .Movable       = .F.
535:                         .Resizable     = .F.
536:                         .ReadOnly      = .T.
537:                         .ControlSource = "cursor_4c_Dados.Nops"
538:                         .Header1.Caption   = "O.P."
539:                         .Header1.FontName  = "Tahoma"
540:                         .Header1.FontSize  = 8
541:                         .Header1.Alignment = 2
542:                     ENDWITH
543:                     WITH .Column3
544:                         .ColumnOrder   = 4
545:                         .Width         = 24
546:                         .Alignment     = 2
547:                         .Movable       = .F.
548:                         .Resizable     = .F.
549:                         .ReadOnly      = .T.
550:                         .ControlSource = "cursor_4c_Dados.Seqs"
551:                         .Header1.Caption   = "Seq"
552:                         .Header1.FontName  = "Tahoma"
553:                         .Header1.FontSize  = 8
554:                         .Header1.Alignment = 2
555:                     ENDWITH
556:                     WITH .Column4
557:                         .ColumnOrder   = 5
558:                         .Width         = 65
559:                         .Alignment     = 2
560:                         .Movable       = .F.
561:                         .Resizable     = .F.
562:                         .ReadOnly      = .T.
563:                         .InputMask     = "9999.99"
564:                         .ControlSource = "cursor_4c_Dados.TempoReal"
565:                         .Header1.Caption   = "Minutos"
566:                         .Header1.FontName  = "Tahoma"
567:                         .Header1.FontSize  = 8
568:                         .Header1.Alignment = 2
569:                     ENDWITH
570:                     WITH .Column5
571:                         .ColumnOrder   = 6
572:                         .Width         = 95
573:                         .Movable       = .F.
574:                         .Resizable     = .F.
575:                         .ReadOnly      = .T.
576:                         .ControlSource = "cursor_4c_Dados.Cpros"
577:                         .Header1.Caption   = "Produto"
578:                         .Header1.FontName  = "Tahoma"
579:                         .Header1.FontSize  = 8
580:                         .Header1.Alignment = 2
581:                     ENDWITH
582:                     WITH .Column6
583:                         .ColumnOrder   = 7
584:                         .Width         = 190
585:                         .Movable       = .F.
586:                         .Resizable     = .F.
587:                         .ReadOnly      = .T.
588:                         .ControlSource = "cursor_4c_Dados.Pedido"
589:                         .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
590:                         .Header1.FontName  = "Tahoma"
591:                         .Header1.FontSize  = 8
592:                         .Header1.Alignment = 2
593:                     ENDWITH
594:                     WITH .Column7
595:                         .ColumnOrder   = 8
596:                         .Width         = 165
597:                         .Movable       = .F.
598:                         .Resizable     = .F.
599:                         .ReadOnly      = .T.
600:                         .ControlSource = "cursor_4c_Dados.cliente"
601:                         .Header1.Caption   = "Cliente"
602:                         .Header1.FontName  = "Tahoma"
603:                         .Header1.FontSize  = 8
604:                         .Header1.Alignment = 2
605:                     ENDWITH
606:                     WITH .Column8
607:                         .ColumnOrder   = 1
608:                         .Width         = 80
609:                         .Alignment     = 3
610:                         .Movable       = .F.
611:                         .Resizable     = .F.
612:                         .ReadOnly      = .T.
613:                         .ControlSource = "cursor_4c_Dados.UniPrdts"
614:                         .Header1.Caption   = "Unidade Prod."
615:                         .Header1.FontName  = "Tahoma"
616:                         .Header1.FontSize  = 8
617:                         .Header1.Alignment = 2
618:                     ENDWITH
619: 
620:                     *-- Prioridade: itens com Priors < 999990 aparecem em azul (identico ao legado)
621:                     .SetAll("DynamicForeColor", ;
622:                         "IIF(cursor_4c_Dados.Priors < 999990, RGB(0,0,255), RGB(0,0,0))", ;
623:                         "Column")
624: 
625:                     .Refresh
626:                 ENDWITH
627: 
628:                 *-- Preencher campos de detalhe do primeiro registro e focar grid

*-- Linhas 683 a 701:
683:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
684:             RETURN
685:         ENDIF
686:         SELECT cursor_4c_Dados
687:         GO TOP
688:         THIS.grd_4c_Dados.Refresh()
689:         THIS.GrdDadosAfterRowColChange(1)
690:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
691:             THIS.grd_4c_Dados.SetFocus()
692:         ENDIF
693:     ENDPROC
694: 
695:     *==========================================================================
696:     PROCEDURE BtnExcluirClick
697:     *==========================================================================
698:         *-- Form OPERACIONAL de consulta (read-only): encerra a janela.
699:         *-- Alias de CmdEncerrarClick (mesmo comportamento do botao Encerrar).
700:         THIS.Release()
701:     ENDPROC

*-- Linhas 746 a 764:
746:             .HighlightForeColor = RGB(15, 41, 104)
747:             .HighlightStyle   = 2
748:             .RecordMark       = .F.
749:             .DeleteMark       = .F.
750:             .RowHeight        = 16
751:             .ScrollBars       = 2
752:             .ReadOnly         = .T.
753:         ENDWITH
754:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
755:     ENDPROC
756: 
757:     *==========================================================================
758:     PROTECTED PROCEDURE ConfigurarDetalhesProduto
759:     *==========================================================================
760:         *-- Shape4: borda ao redor da foto do produto (inicialmente oculto)
761:         THIS.AddObject("shp_4c_Shape4", "Shape")
762:         WITH THIS.shp_4c_Shape4
763:             .Top       = 455
764:             .Left      = 456

*-- Linhas 941 a 959:
941:             THIS.txt_4c_TEnv.Value     = 0
942: 
943:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
944:                 SELECT cursor_4c_Dados
945:                 loc_cCpros = ALLTRIM(NVL(Cpros, ""))
946: 
947:                 *-- Preencher campos de detalhe da linha corrente
948:                 THIS.txt_4c_Qtde.Value    = NVL(Qtds, 0)
949:                 THIS.txt_4c_Cliente.Value = ALLTRIM(NVL(Rclis, ""))
950:                 THIS.txt_4c_TEnv.Value    = NVL(TempU, 0)
951: 
952:                 *-- Carregar foto e descricao do produto via BO
953:                 IF !EMPTY(loc_cCpros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
954:                     THIS.this_oBusinessObject.CarregarFotoProduto(loc_cCpros)
955: 
956:                     THIS.txt_4c_Descr.Value = ;
957:                         ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDescricaoProduto, ""))
958: 
959:                     IF !EMPTY(THIS.this_oBusinessObject.this_cFotoArquivo) AND ;


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*==============================================================================
* sigprcpdBO.prg - Business Object: Capacidade Produtiva
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Colunas da tabela SigCdPcz (mapeadas 1:1 com o schema)
    this_nCodigo    = 0    && codigos numeric(10,0) NOT NULL - PK
    this_cContas    = ""   && contas char(10) NOT NULL
    this_cCvens     = ""   && cvens char(10) NOT NULL
    this_dData      = {}   && datas datetime NULL
    this_cDopes     = ""   && dopes char(20) NOT NULL
    this_dDtLancs   = {}   && dtlancs datetime NULL
    this_dEmissaoF  = {}   && emissaof datetime NULL
    this_dEmissaoI  = {}   && emissaoi datetime NULL
    this_cEmps      = ""   && emps char(3) NOT NULL
    this_nNumeFs    = 0    && numefs numeric(6,0) NOT NULL
    this_nNumeIs    = 0    && numeis numeric(6,0) NOT NULL
    this_dPrevFs    = {}   && prevfs datetime NULL
    this_dPrevIs    = {}   && previs datetime NULL
    this_cTitulos   = ""   && titulos char(50) NOT NULL

    *-- Parametros de contexto recebidos pelo form chamador
    this_cSetor     = ""   && Fase/Setor (contexto do form)
    this_cUnidade   = ""   && Unidade de producao (vazio = todas)

    *-- Dados de capacidade agregados (SigCdPcP por data/fase/unidade)
    this_nCapacidade  = 0  && Capacidade total em minutos
    this_nUtilizado   = 0  && Minutos utilizados (minutos - saldos)
    this_nSaldo       = 0  && Saldo de minutos

    *-- Dados do produto da linha selecionada no grid
    this_cDescricaoProduto = ""   && Dpros de SigCdPro
    this_cFotoArquivo      = ""   && Caminho temporario do JPEG decodificado

    *-- Dados exibidos abaixo do grid (linha corrente de zTmpPcpOp)
    this_nQtde          = 0   && Qtds da ordem
    this_cClienteNome   = ""  && Rclis do cliente
    this_nTempoEnvelope = 0   && TempU (tempo total do envelope em minutos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (SigCdPcz.codigos)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(TRANSFORM(THIS.this_nCodigo))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCdPcz para as
    * propriedades do BO. Recebe o alias do cursor aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_nCodigo   = NVL(codigos, 0)
            THIS.this_cContas   = NVL(contas, "")
            THIS.this_cCvens    = NVL(cvens, "")
            THIS.this_dData     = NVL(datas, {})
            THIS.this_cDopes    = NVL(dopes, "")
            THIS.this_dDtLancs  = NVL(dtlancs, {})
            THIS.this_dEmissaoF = NVL(emissaof, {})
            THIS.this_dEmissaoI = NVL(emissaoi, {})
            THIS.this_cEmps     = NVL(emps, "")
            THIS.this_nNumeFs   = NVL(numefs, 0)
            THIS.this_nNumeIs   = NVL(numeis, 0)
            THIS.this_dPrevFs   = NVL(prevfs, {})
            THIS.this_dPrevIs   = NVL(previs, {})
            THIS.this_cTitulos  = NVL(titulos, "")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um novo registro de processo em SigCdPcz.
    * Retorna .T. se sucesso, .F. em falha.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpresa
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Inserir")
            ELSE
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmps)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdPcz (" + ;
                    "codigos, contas, cvens, datas, dopes, dtlancs, " + ;
                    "emissaof, emissaoi, emps, numefs, numeis, " + ;
                    "prevfs, previs, titulos" + ;
                    ") VALUES (" + ;
                    FormatarNumeroSQL(THIS.this_nCodigo, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                    FormatarDataSQL(THIS.this_dData) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                    FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                    FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                    EscaparSQL(LEFT(loc_cEmpresa, 3)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                    FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha ao inserir processo em SigCdPcz.", ;
                            "Erro sigprcpdBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza o registro corrente em SigCdPcz (chave: codigos).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                        "Erro sigprcpdBO.Atualizar")
            ELSE
                IF THIS.this_nCodigo <= 0
                    MsgAviso("Processo sem c" + CHR(243) + "digo: use Inserir para gravar novo registro.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cSQL = "UPDATE SigCdPcz SET " + ;
                        "contas = "   + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                        "cvens = "    + EscaparSQL(LEFT(THIS.this_cCvens, 10)) + ", " + ;
                        "datas = "    + FormatarDataSQL(THIS.this_dData) + ", " + ;
                        "dopes = "    + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                        "dtlancs = "  + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                        "emissaof = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                        "emissaoi = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                        "numefs = "   + FormatarNumeroSQL(THIS.this_nNumeFs, 0) + ", " + ;
                        "numeis = "   + FormatarNumeroSQL(THIS.this_nNumeIs, 0) + ", " + ;
                        "prevfs = "   + FormatarDataSQL(THIS.this_dPrevFs) + ", " + ;
                        "previs = "   + FormatarDataSQL(THIS.this_dPrevIs) + ", " + ;
                        "titulos = "  + EscaparSQL(LEFT(THIS.this_cTitulos, 50)) + " " + ;
                        "WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigo, 0)

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        MsgErro("Falha ao atualizar processo em SigCdPcz.", ;
                                "Erro sigprcpdBO.Atualizar")
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro sigprcpdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_oErro, loc_cSQL, loc_cUsuario, loc_cChave

        TRY
            IF gnConnHandle > 0
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
                loc_cChave   = THIS.ObterChavePrimaria()

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                    "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                    "VALUES (GETDATE(), " + ;
                    EscaparSQL(loc_cUsuario) + ", " + ;
                    EscaparSQL("SigCdPcz") + ", " + ;
                    EscaparSQL(par_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ")"

                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper fluxo principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega todos os cursores de capacidade produtiva
    * Par?metros: par_nCodigo (SigCdPcz.codigos), par_cFase, par_cUnidade, par_dData
    * Retorna: .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nCodigo, par_cFase, par_cUnidade, par_dData)
        LOCAL loc_lSucesso, loc_lCont, loc_cSQL, loc_cFiltro, loc_cFiltroA
        loc_lSucesso = .F.
        loc_lCont    = .T.
        loc_cFiltro  = ""
        loc_cFiltroA = ""

        TRY
            THIS.this_nCodigo  = par_nCodigo
            THIS.this_cSetor   = par_cFase
            THIS.this_cUnidade = par_cUnidade
            THIS.this_dData    = par_dData

            IF !EMPTY(par_cUnidade)
                loc_cFiltro  = " AND UniPrdts = " + EscaparSQL(par_cUnidade)
                loc_cFiltroA = " AND a.UniPrdts = " + EscaparSQL(par_cUnidade)
            ENDIF

            *-- 1. Processo (SigCdPcz)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcz WHERE codigos = " + ;
                           FormatarNumeroSQL(par_nCodigo, 0)

                IF USED("cursor_4c_Processo")
                    USE IN cursor_4c_Processo
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Processo") < 1
                    MsgErro("Falha ao carregar processo (SigCdPcz).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 2. Capacidade agregada (SigCdPcP): minutos, utilizados, saldos
            IF loc_lCont
                loc_cSQL = "SELECT Codigos, " + ;
                           "SUM(minutos) AS Minutos, " + ;
                           "SUM(minutos - Saldos) AS Utilizados, " + ;
                           "SUM(saldos) AS Saldos " + ;
                           "FROM SigCdPcP " + ;
                           "WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND Datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltro + ;
                           " GROUP BY Codigos"

                IF USED("cursor_4c_Capacidade")
                    USE IN cursor_4c_Capacidade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Capacidade") < 1
                    MsgErro("Falha ao carregar capacidade (SigCdPcP).", "Erro")
                    loc_lCont = .F.
                ELSE
                    SELECT cursor_4c_Capacidade
                    GO TOP
                    IF !EOF()
                        THIS.this_nCapacidade = NVL(Minutos, 0)
                        THIS.this_nUtilizado  = NVL(Utilizados, 0)
                        THIS.this_nSaldo      = NVL(Saldos, 0)
                    ENDIF
                ENDIF
            ENDIF

            *-- 3. Grade de sequ" + CHR(234) + "ncias (SigCdPcg)
            IF loc_lCont
                loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                           "WHERE datas = " + FormatarDataSQL(par_dData) + ;
                           " AND Fases = " + EscaparSQL(par_cFase) + ;
                           " AND Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           loc_cFiltro + ;
                           " ORDER BY Cidchaves"

                IF USED("cursor_4c_Grade")
                    USE IN cursor_4c_Grade
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grade") < 1
                    MsgErro("Falha ao carregar grade (SigCdPcg).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 4. Ordens com cliente (SigCdPco JOIN SigCdCli)
            IF loc_lCont
                loc_cSQL = "SELECT a.*, " + ;
                           "a.dopes + '-' + STR(a.numes, 6) AS Pedido, " + ;
                           "a.contas + '-' + b.rclis AS cliente, " + ;
                           "b.Rclis " + ;
                           "FROM SigCdPco a, SigCdCli b " + ;
                           "WHERE a.Codigos = " + FormatarNumeroSQL(par_nCodigo, 0) + ;
                           " AND a.Fases = " + EscaparSQL(par_cFase) + ;
                           loc_cFiltroA + ;
                           " AND a.Contas = b.Iclis " + ;
                           "ORDER BY a.UniPrdts, a.Seqs, a.Nenvs"

                IF USED("cursor_4c_OrdensTemp")
                    USE IN cursor_4c_OrdensTemp
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OrdensTemp") < 1
                    MsgErro("Falha ao carregar ordens (SigCdPco).", "Erro")
                    loc_lCont = .F.
                ENDIF
            ENDIF

            *-- 5. Agrupamento por envelope/seq (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_GrupoOp")
                    USE IN cursor_4c_GrupoOp
                ENDIF

                SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, ;
                       SUM(a.Minutos) AS Minutos ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                INTO CURSOR cursor_4c_GrupoOp READWRITE
            ENDIF

            *-- 6. Cursor final do grid com TempoReal proporcional (SELECT VFP local)
            IF loc_lCont
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                       IIF(c.Minutos = 0, 0, ;
                           (a.minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60)) AS TempoReal ;
                FROM cursor_4c_OrdensTemp a, cursor_4c_Grade b, cursor_4c_GrupoOp c ;
                WHERE a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      b.Fases + b.UniPrdts + STR(b.Nenvs,10) + STR(b.Seqs,2) ;
                AND   a.Fases + a.UniPrdts + STR(a.Nenvs,10) + STR(a.Seqs,2) = ;
                      c.Fases + c.UniPrdts + STR(c.Nenvs,10) + STR(c.Seqs,2) ;
                ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                INTO CURSOR cursor_4c_Dados READWRITE

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - Carrega foto e descri" + CHR(231) + CHR(227) + "o do produto selecionado no grid
    * Par?metro: par_cCpros - c?digo do produto (SigCdPro.Cpros)
    * Retorna: .T. se sucesso
    * Efeitos: popula this_cDescricaoProduto e this_cFotoArquivo
    *--------------------------------------------------------------------------
    FUNCTION CarregarFotoProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_cArqTemp, loc_cFotoBase64
        loc_lSucesso = .F.
        THIS.this_cDescricaoProduto = ""
        THIS.this_cFotoArquivo      = ""

        TRY
            loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                       EscaparSQL(ALLTRIM(par_cCpros))

            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto") >= 1
                SELECT cursor_4c_Produto
                GO TOP

                IF !EOF()
                    THIS.this_cDescricaoProduto = NVL(Dpros, "")

                    IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
                        loc_cArqTemp    = SYS(2023) + "\sigprcpd.jpg"
                        loc_cFotoBase64 = STRCONV(;
                            STRTRAN(;
                                STRTRAN(;
                                    STRTRAN(FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)

                        IF STRTOFILE(loc_cFotoBase64, loc_cArqTemp) > 0
                            THIS.this_cFotoArquivo = loc_cArqTemp
                        ENDIF
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

