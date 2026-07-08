# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'GRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPODS, CONTADS, EMPDS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
		lcQuery = [Select GrPadVens ] + ;
				    [From SigCdPam ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalParam') < 1)
		Select CqSigCdCli
lcQuery = [Select a.* ] + ;
		    [From SigMvCab a, SigCdOpe b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csTemporario') < 1)
Select csTemporario
Update csTemporario ;

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg) - TRECHOS RELEVANTES PARA PASS SQL (1856 linhas total):

*-- Linhas 6 a 24:
6: *
7: * Pilares:
8: *   UX   -> pixel-perfect escalado de 823x400 para 1000x600 (ScaleX=1.215 ScaleY=1.5)
9: *   BD   -> SigMvCab (join SigCdOpe) - nomes exatos do schema
10: *   CODE -> arquitetura em camadas (FormBase / SigPrEs1BO)
11: *
12: * Fases de construcao:
13: *   FASE 3 (esta): Estrutura base - cabecalho, containers vazios, Destroy
14: *   FASE 4       : CommandGroup cmg_4c_Sair (Consultar + Encerrar)
15: *   FASES 5-6   : TextBoxes e controles de filtro em cnt_4c_Container1
16: *   FASES 7-8   : Eventos (KeyPress, LostFocus, validacoes, CmgConsultarClick)
17: *
18: * Nota sobre ConfigurarPageFrame:
19: *   Este eh um form OPERACIONAL de FILTRO/CONSULTA (nao CRUD).
20: *   Em vez de um PageFrame Page1=Lista/Page2=Dados, o layout eh
21: *   container-based: cabecalho no topo + container de filtros + botoes.
22: *   ConfigurarPageFrame() atua como orquestrador da montagem do layout
23: *   preservando o contrato semantico do FormBase.
24: *==============================================================================

*-- Linhas 714 a 738:
714:     * CmgConsultarClick - Valida filtros, executa query e abre sigpres2
715:     * Equivale ao PROCEDURE consulta.Click do legado (83 linhas)
716:     * Validacoes: empresa obrigatoria, operacao obrigatoria, periodo valido
717:     * Query: SigMvCab JOIN SigCdOpe com filtros dinamicos
718:     * Resultado: DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
719:     *==========================================================================
720:     PROCEDURE CmgConsultarClick()
721:         LOCAL loc_nNrP, loc_cNmO, loc_cEst, loc_cCon, loc_nPen
722:         LOCAL loc_cVen, loc_cEmp, loc_cSta, loc_nEmpD
723:         LOCAL loc_cNOp, loc_cNum, loc_cWhere, loc_cQuery
724:         LOCAL loc_dDtInicial, loc_dDtFinal, loc_cDtI, loc_cDtF
725:         LOCAL loc_oErro
726: 
727:         *-- Validar empresa (obrigatoria)
728:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__cd_empresa.Value))
729:             MsgAviso("Empresa Inv" + CHR(225) + "lida!!!", ;
730:                      "Aten" + CHR(231) + CHR(227) + "o")
731:             THIS.cnt_4c_Container1.txt_4c__cd_empresa.SetFocus
732:             RETURN
733:         ENDIF
734: 
735:         *-- Validar opera??o (obrigatoria)
736:         IF EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c__nm_operacao.Value))
737:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
738:                      "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 774 a 830:
774:                    PADL(STR(DAY(loc_dDtFinal), 2), 2, "0") + " 23:59:59'"
775: 
776:         *-- Montar WHERE dinamico (cada parte termina com " AND " para encadear)
777:         loc_cWhere = IIF(EMPTY(loc_cNmO), "", "a.Dopes = " + EscaparSQL(loc_cNmO) + " AND ") + ;
778:                      IIF(loc_nNrP = 1, "a.Datas ", "a.PrazoEnts ") + ;
779:                      "BETWEEN " + loc_cDtI + " AND " + loc_cDtF + " AND " + ;
780:                      IIF(EMPTY(loc_cEst), "", "(a.GrupoOs = " + EscaparSQL(loc_cEst) + ;
781:                          " OR a.GrupoDs = " + EscaparSQL(loc_cEst) + ") AND ") + ;
782:                      IIF(EMPTY(loc_cCon), "", "(a.ContaOs = " + EscaparSQL(loc_cCon) + ;
783:                          " OR a.ContaDs = " + EscaparSQL(loc_cCon) + ") AND ") + ;
784:                      IIF(EMPTY(loc_cNOp), "", "a.Nops = " + loc_cNOp + " AND ") + ;
785:                      IIF(EMPTY(loc_cNum), "", "a.Numes = " + loc_cNum + " AND ") + ;
786:                      IIF(EMPTY(loc_cVen), "", "a.Vends = " + EscaparSQL(loc_cVen) + " AND ") + ;
787:                      IIF(loc_nPen = 1, "a.ChkSubn = 0 AND ", ;
788:                          IIF(loc_nPen = 2, "a.ChkSubn = 1 AND ", "")) + ;
789:                      IIF(EMPTY(loc_cSta), "", "a.pStatus = " + EscaparSQL(loc_cSta) + " AND ")
790: 
791:         *-- Montar query principal (empresa obrigatoria + filtro empresa destino opcional)
792:         loc_cQuery = "SELECT a.* " + ;
793:                      "FROM SigMvCab a, SigCdOpe b " + ;
794:                      "WHERE (a.Emps = " + EscaparSQL(loc_cEmp) + ;
795:                      IIF(loc_nEmpD = 0, "", " OR a.Empds = " + EscaparSQL(loc_cEmp)) + ;
796:                      ") AND " + ;
797:                      loc_cWhere + ;
798:                      "a.Dopes = b.Dopes"
799: 
800:         TRY
801:             *-- Fechar cursor anterior se existir
802:             IF USED("cursor_4c_MovTemp")
803:                 USE IN cursor_4c_MovTemp
804:             ENDIF
805: 
806:             *-- Executar query no SQL Server
807:             IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MovTemp") < 1
808:                 MsgErro("Falha na conex" + CHR(227) + "o (cursor_4c_MovTemp)", "Erro")
809:                 RETURN
810:             ENDIF
811: 
812:             SELECT cursor_4c_MovTemp
813:             INDEX ON EmpDopNums TAG EmpDopNums
814: 
815:             *-- Converter PrazoEnts NULL em data vazia (equivale ao UPDATE legado)
816:             REPLACE ALL PrazoEnts WITH {} FOR ISNULL(PrazoEnts)
817: 
818:             GO TOP IN cursor_4c_MovTemp
819: 
820:             IF RECCOUNT("cursor_4c_MovTemp") > 0
821:                 *-- Desabilitar form enquanto sigpres2 esta aberto (modo RESULTADO)
822:                 THIS.AlternarPagina("RESULTADO")
823:                 DO FORM sigpres2 WITH loc_cNmO, THIS.DataSessionId, THIS
824:                 *-- Restaurar modo FILTRO ao retornar do sigpres2
825:                 THIS.AlternarPagina("FILTRO")
826:             ELSE
827:                 MsgAviso("Nenhum Registro Selecionado!!!", ;
828:                          "Informa" + CHR(231) + CHR(227) + "o")
829:             ENDIF
830: 

*-- Linhas 855 a 873:
855:     * metodo delega para CmgConsultarClick(), que:
856:     *   1) Valida empresa/operacao/periodo (campos obrigatorios)
857:     *   2) Monta WHERE dinamico com todos os filtros do form
858:     *   3) SQLEXEC em cursor_4c_MovTemp + INDEX ON EmpDopNums
859:     *   4) Alterna form para modo RESULTADO (desabilita filtros)
860:     *   5) DO FORM sigpres2 (viewer dos resultados)
861:     *   6) Retorna para modo FILTRO ao fechar SIGPRES2
862:     *==========================================================================
863:     PROCEDURE BtnVisualizarClick()
864:         THIS.CmgConsultarClick()
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * BtnIncluirClick - Executa consulta (acao principal do form OPERACIONAL)
869:     *
870:     * Contexto OPERACIONAL: SIGPRES1 nao possui CRUD proprio - eh um form de
871:     * FILTRO/CONSULTA que exibe movimentos existentes em SigMvCab. A inclusao
872:     * de novos movimentos ocorre em forms de digitacao especializados (nao
873:     * neste form).

*-- Linhas 1546 a 1564:
1546:         loc_cGrupo = ALLTRIM(loc_oCnt.txt_4c_Grupo.Value)
1547:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1548:                        IIF(EMPTY(loc_cGrupo), "SigCdCli", ;
1549:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrupo)), ;
1550:                        "cursor_4c_BuscaConta", "iclis", ;
1551:                        ALLTRIM(loc_oCnt.txt_4c_Conta.Value), ;
1552:                        "Conta")
1553:         IF VARTYPE(loc_oFrm) = "O"
1554:             loc_oFrm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1555:             loc_oFrm.mAddColuna("rclis", "", "Nome")
1556:             loc_oFrm.Show()
1557:             IF THIS.this_lSelecionou
1558:                 loc_oCnt.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.iclis)
1559:                 loc_oCnt.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1560:                 USE IN cursor_4c_BuscaConta
1561:                 THIS.PreencherCpfPorConta()
1562:             ENDIF
1563:             loc_oFrm.Release()
1564:             loc_oFrm = .NULL.

*-- Linhas 1571 a 1589:
1571:         loc_cGrpVens = THIS.this_oBusinessObject.this_cGrPadVens
1572:         loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1573:                        IIF(EMPTY(loc_cGrpVens), "SigCdCli", ;
1574:                            "SigCdCli WHERE grupos = " + EscaparSQL(loc_cGrpVens)), ;
1575:                        "cursor_4c_BuscaResp", "iclis", ;
1576:                        ALLTRIM(loc_oCnt.txt_4c__resps.Value), ;
1577:                        "Respons" + CHR(225) + "vel")
1578:         IF VARTYPE(loc_oFrm) = "O"
1579:             loc_oFrm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1580:             loc_oFrm.mAddColuna("rclis", "", "Nome")
1581:             loc_oFrm.Show()
1582:             IF THIS.this_lSelecionou
1583:                 loc_oCnt.txt_4c__resps.Value  = ALLTRIM(cursor_4c_BuscaResp.iclis)
1584:                 loc_oCnt.txt_4c__dresps.Value = ALLTRIM(cursor_4c_BuscaResp.rclis)
1585:                 USE IN cursor_4c_BuscaResp
1586:             ENDIF
1587:             loc_oFrm.Release()
1588:             loc_oFrm = .NULL.
1589:         ENDIF

*-- Linhas 1621 a 1641:
1621:         IF EMPTY(loc_cConta)
1622:             RETURN
1623:         ENDIF
1624:         loc_cSQL = "SELECT cpfs FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
1625:         TRY
1626:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpfTemp")
1627:             IF loc_nRes > 0 AND !EMPTY(cursor_4c_CpfTemp.cpfs)
1628:                 loc_cCpf = ALLTRIM(cursor_4c_CpfTemp.cpfs)
1629:                 loc_oCnt.txt_4c_Cpf.Value = loc_cCpf
1630:             ELSE
1631:                 loc_oCnt.txt_4c_Cpf.Value = ""
1632:             ENDIF
1633:             IF USED("cursor_4c_CpfTemp")
1634:                 USE IN cursor_4c_CpfTemp
1635:             ENDIF
1636:         CATCH TO loc_oErro
1637:             MsgErro(loc_oErro.Message, "Erro ao buscar CPF")
1638:         ENDTRY
1639:     ENDPROC
1640: 
1641:     *==========================================================================


### BO (C:\4c\projeto\app\classes\SigPrEs1BO.prg):
*==============================================================================
* SigPrEs1BO.prg - Business Object: Posicao Por Movimentacao
* Herda de: BusinessBase
* Tipo: OPERACIONAL (filtro/consulta - sem CRUD direto)
* Tabela principal: SigMvCab
*==============================================================================

DEFINE CLASS SigPrEs1BO AS BusinessBase

    *--------------------------------------------------------------------------
    * Filtros de periodo
    *--------------------------------------------------------------------------
    this_dDtInicial    = {}
    this_dDtFinal      = {}
    this_nNrPeriodo    = 1        && 1=Lancamento, 2=Prazo Entrega

    *--------------------------------------------------------------------------
    * Filtro Movimentacao / Operacao
    *--------------------------------------------------------------------------
    this_cNmOperacao   = ""       && C(20) - Nome da movimentacao (SigCdOpe.Dopes)

    *--------------------------------------------------------------------------
    * Filtros Numero / OP
    *--------------------------------------------------------------------------
    this_nNumero       = 0        && N(6,0) - Numero do lancamento (SigMvCab.numes)
    this_nOp           = 0        && N(6,0) - Numero da OP (SigMvCab.nops)

    *--------------------------------------------------------------------------
    * Filtro Status
    *--------------------------------------------------------------------------
    this_cPStatus      = ""       && C(1) - Status (SigMvCab.pstatus)

    *--------------------------------------------------------------------------
    * Filtro Grupo Contabil (SigCdGcr - origem/destino)
    *--------------------------------------------------------------------------
    this_cGrupo        = ""       && C(10) - Codigo do grupo (grupoos/grupods)
    this_cDGrupo       = ""       && C(40) - Descricao do grupo (descrs)

    *--------------------------------------------------------------------------
    * Filtro Conta / CPF/CNPJ (SigCdCli)
    *--------------------------------------------------------------------------
    this_cConta        = ""       && C(10) - Codigo da conta (contaos/contads)
    this_cDConta       = ""       && C(50) - Descricao da conta (rclis)
    this_cCpf          = ""       && C(20) - CPF/CNPJ (SigCdCli.cpfs)

    *--------------------------------------------------------------------------
    * Filtro Moeda (SigCdMoe - exibido em sigpres2, nao filtra SQL principal)
    *--------------------------------------------------------------------------
    this_cCdMoeda      = ""       && C(3)  - Codigo da moeda (cmoes)
    this_cDsMoeda      = ""       && C(15) - Descricao da moeda (dmoes)

    *--------------------------------------------------------------------------
    * Filtro Responsavel / Vendedor (SigCdCli com grupo = GrPadVens)
    *--------------------------------------------------------------------------
    this_cResps        = ""       && C(10) - Codigo do responsavel (vends)
    this_cDResps       = ""       && C(50) - Descricao do responsavel (rclis)

    *--------------------------------------------------------------------------
    * Filtro Empresa (sigcdemp)
    *--------------------------------------------------------------------------
    this_cCdEmpresa    = ""       && C(3)  - Codigo da empresa (emps)
    this_cDsEmpresa    = ""       && C(40) - Descricao da empresa (razas)
    this_nChkEmpD      = 0        && N(1)  - 0=nao filtrar Empds, 1=incluir Empds

    *--------------------------------------------------------------------------
    * OptionGroups - passados a sigpres2 para controle de exibicao/impressao
    *--------------------------------------------------------------------------
    this_nOptCotacao   = 1        && 1=Fechamento, 2=Movimentacao
    this_nOptImpressao = 1        && 1=Por Vendedor, 2=Por Movimentacao
    this_nOptPendente  = 3        && 1=Pendentes, 2=Baixadas, 3=Todas

    *--------------------------------------------------------------------------
    * Parametro operacional carregado de SigCdPam
    *--------------------------------------------------------------------------
    this_cGrPadVens    = ""       && C(10) - Grupo padrao de vendedores (grpadvens)

    *==========================================================================
    * Init - Inicializa o BO configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna identificador para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumero)
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega GrPadVens e demais config de SigCdPam
    * Deve ser chamado no Init() do Form apos criar o BO
    * Retorna .T. se carregou com sucesso
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 grpadvens FROM SigCdPam"

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
                IF !EOF("cursor_4c_Param")
                    SELECT cursor_4c_Param
                    THIS.this_cGrPadVens = NVL(grpadvens, "")
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Param")
                USE IN cursor_4c_Param
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar par" + CHR(226) + "metros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarFiltros - Valida campos obrigatorios antes da consulta
    * Retorna: "" se valido, mensagem de erro se invalido
    *==========================================================================
    PROCEDURE ValidarFiltros()
        LOCAL loc_cMensagem
        loc_cMensagem = ""

        IF EMPTY(THIS.this_cCdEmpresa)
            RETURN "Empresa Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF EMPTY(THIS.this_cNmOperacao)
            RETURN "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!"
        ENDIF

        IF !EMPTY(THIS.this_dDtFinal) AND !EMPTY(THIS.this_dDtInicial)
            IF THIS.this_dDtFinal < THIS.this_dDtInicial
                RETURN "Per" + CHR(237) + "odo Inv" + CHR(225) + "lido!!! " + ;
                       "Data Final Menor do Que a Inicial!!!"
            ENDIF
        ENDIF

        RETURN loc_cMensagem
    ENDPROC

    *==========================================================================
    * ExecutarConsulta - Monta e executa consulta principal em SigMvCab
    * Popula cursor_4c_MovTemp com resultados indexados por EmpDopNums
    * Requer: this_cCdEmpresa, this_dDtInicial, this_dDtFinal validados
    * Retorna: .T. se consulta gerou ao menos 1 registro
    *==========================================================================
    PROCEDURE ExecutarConsulta()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_cDtI, loc_cDtF, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cDtI = "'" + DTOC(THIS.this_dDtInicial, 1) + "'"
            loc_cDtF = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            loc_cWhere = IIF(EMPTY(THIS.this_cNmOperacao), "", ;
                             "a.dopes = " + EscaparSQL(THIS.this_cNmOperacao) + " And ") + ;
                         IIF(THIS.this_nNrPeriodo = 1, "a.datas ", "a.prazoents ") + ;
                             "Between " + loc_cDtI + " And " + loc_cDtF + " And " + ;
                         IIF(EMPTY(THIS.this_cGrupo), "", ;
                             "(a.grupoos = " + EscaparSQL(THIS.this_cGrupo) + ;
                             " Or a.grupods = " + EscaparSQL(THIS.this_cGrupo) + ") And ") + ;
                         IIF(EMPTY(THIS.this_cConta), "", ;
                             "(a.contaos = " + EscaparSQL(THIS.this_cConta) + ;
                             " Or a.contads = " + EscaparSQL(THIS.this_cConta) + ") And ") + ;
                         IIF(THIS.this_nOp = 0, "", ;
                             "a.nops = " + TRANSFORM(THIS.this_nOp) + " And ") + ;
                         IIF(THIS.this_nNumero = 0, "", ;
                             "a.numes = " + TRANSFORM(THIS.this_nNumero) + " And ") + ;
                         IIF(EMPTY(THIS.this_cResps), "", ;
                             "a.vends = " + EscaparSQL(THIS.this_cResps) + " And ") + ;
                         IIF(THIS.this_nOptPendente = 1, "a.chksubn = 0 And ", ;
                             IIF(THIS.this_nOptPendente = 2, "a.chksubn = 1 And ", "")) + ;
                         IIF(EMPTY(THIS.this_cPStatus), "", ;
                             "a.pstatus = " + EscaparSQL(THIS.this_cPStatus) + " And ")

            loc_cSQL = "SELECT a.* " + ;
                       "FROM SigMvCab a, SigCdOpe b " + ;
                       "WHERE (a.emps = " + EscaparSQL(THIS.this_cCdEmpresa) + ;
                           IIF(THIS.this_nChkEmpD = 0, "", ;
                               " Or a.empds = " + EscaparSQL(THIS.this_cCdEmpresa)) + ;
                           ") And " + ;
                       loc_cWhere + ;
                       "a.dopes = b.Dopes"

            IF USED("cursor_4c_MovTemp")
                USE IN cursor_4c_MovTemp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTemp") > 0
                SELECT cursor_4c_MovTemp
                IF !EOF("cursor_4c_MovTemp")
                    INDEX ON empdopnums TAG empdopnums
                    UPDATE cursor_4c_MovTemp ;
                        SET prazoents = IIF(ISNULL(prazoents), {}, prazoents)
                    GO TOP IN cursor_4c_MovTemp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao executar consulta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorCodigo - Lookup SigCdGcr por codigo (equivale fAcessoContab C)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 registro
    *==========================================================================
    PROCEDURE BuscarGrupoPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(codigos) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarGrupoPorDescricao - Lookup SigCdGcr por descricao (fAcessoContab D)
    * Popula cursor_4c_BuscaGrupo com codigos, descrs
    * Retorna .T. se encontrou exatamente 1 match (auto-preenche sem picker)
    *==========================================================================
    PROCEDURE BuscarGrupoPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
                       "WHERE RTRIM(descrs) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY descrs"

            IF USED("cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo") > 0
                SELECT cursor_4c_BuscaGrupo
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaGrupo")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorCodigo - Lookup SigCdMoe por cmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(cmoes) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarMoedaPorDescricao - Lookup SigCdMoe por dmoes
    * Popula cursor_4c_BuscaMoeda com cmoes, dmoes
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                       "WHERE RTRIM(dmoes) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY dmoes"

            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaMoeda")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Lookup SigCdCli por iclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'C', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cGrupo, par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorDescricao - Lookup SigCdCli por rclis com filtro de grupo
    * Equivale a fAcessoContas(usu, grupo, 'D', ...)
    * Popula cursor_4c_BuscaConta com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarContaPorDescricao(par_cGrupo, par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(par_cGrupo), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(par_cGrupo) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaConta")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar conta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorCodigo - Lookup vendedor/resp por iclis
    * Usa this_cGrPadVens como filtro de grupo (SigCdCli.grupos)
    * Equivale a fAcessoContas(usu, GrPadVens, 'C', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarResponsavelPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(iclis) = RTRIM(" + EscaparSQL(par_cCodigo) + ")" + ;
                       loc_cFiltroGrupo

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarResponsavelPorDescricao - Lookup vendedor/resp por rclis
    * Usa this_cGrPadVens como filtro de grupo
    * Equivale a fAcessoContas(usu, GrPadVens, 'D', ...)
    * Popula cursor_4c_BuscaResp com iclis, rclis
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarResponsavelPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltroGrupo, loc_oErro
        loc_lSucesso    = .F.
        loc_cFiltroGrupo = IIF(EMPTY(THIS.this_cGrPadVens), "", ;
            " And RTRIM(grupos) = RTRIM(" + EscaparSQL(THIS.this_cGrPadVens) + ")")

        TRY
            loc_cSQL = "SELECT iclis, rclis FROM SIGCDCLI " + ;
                       "WHERE RTRIM(rclis) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       loc_cFiltroGrupo + ;
                       " ORDER BY rclis"

            IF USED("cursor_4c_BuscaResp")
                USE IN cursor_4c_BuscaResp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaResp") > 0
                SELECT cursor_4c_BuscaResp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaResp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar respons" + CHR(225) + "vel")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarClientePorCpf - Lookup SigCdCli por cpfs (CPF/CNPJ)
    * Popula cursor_4c_BuscaCliente com iclis, rclis, cpfs
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarClientePorCpf(par_cCpf)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT iclis, rclis, cpfs FROM SIGCDCLI " + ;
                       "WHERE RTRIM(cpfs) = " + EscaparSQL(PADR(ALLTRIM(par_cCpf), 20))

            IF USED("cursor_4c_BuscaCliente")
                USE IN cursor_4c_BuscaCliente
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCliente") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaCliente")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cliente por CPF")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarOperacaoPorNome - Valida existencia da operacao em SigCdOpe
    * Equivale a fAcessoMovmto - verifica que Dopes existe
    * Popula cursor_4c_BuscaOpe com Dopes
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarOperacaoPorNome(par_cNome)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe " + ;
                       "WHERE RTRIM(Dopes) = RTRIM(" + EscaparSQL(par_cNome) + ")"

            IF USED("cursor_4c_BuscaOpe")
                USE IN cursor_4c_BuscaOpe
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaOpe")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar opera" + CHR(231) + CHR(227) + "o")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorCodigo - Lookup sigcdemp por cemps
    * Equivale a fAcessoEmpresa modo C
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou
    *==========================================================================
    PROCEDURE BuscarEmpresaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(cemps) = RTRIM(" + EscaparSQL(par_cCodigo) + ")"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                loc_lSucesso = !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia registro atual de cursor SigMvCab para propriedades
    * Usado quando form carrega movimentacao selecionada (double-click no grid de sigpres2)
    * par_cAliasCursor: nome do cursor com dados de SigMvCab (a.* da ExecutarConsulta)
    * Retorna .T. se mapeou com sucesso
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            IF EOF() OR BOF()
                loc_lSucesso = .F.
            ENDIF

            IF TYPE(par_cAliasCursor + ".emps") != "U"
                THIS.this_cCdEmpresa = NVL(emps, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".dopes") != "U"
                THIS.this_cNmOperacao = NVL(dopes, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".datas") != "U"
                THIS.this_dDtInicial = IIF(ISNULL(datas), {}, datas)
                THIS.this_dDtFinal   = IIF(ISNULL(datas), {}, datas)
            ENDIF
            IF TYPE(par_cAliasCursor + ".numes") != "U"
                THIS.this_nNumero = NVL(numes, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".nops") != "U"
                THIS.this_nOp = NVL(nops, 0)
            ENDIF
            IF TYPE(par_cAliasCursor + ".pstatus") != "U"
                THIS.this_cPStatus = NVL(pstatus, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".grupoos") != "U"
                THIS.this_cGrupo = NVL(grupoos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".contaos") != "U"
                THIS.this_cConta = NVL(contaos, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".vends") != "U"
                THIS.this_cResps = NVL(vends, "")
            ENDIF
            IF TYPE(par_cAliasCursor + ".chksubn") != "U"
                IF VARTYPE(chksubn) = "N"
                    THIS.this_nOptPendente = IIF(NVL(chksubn, 0) = 1, 2, 1)
                ELSE
                    THIS.this_nOptPendente = IIF(NVL(chksubn, .F.), 2, 1)
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar do cursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Nao suportado
    * SigPrEs1 eh form OPERACIONAL de consulta/relatorio (Posicao Por Movimentacao).
    * Os registros de SigMvCab sao criados/mantidos pelos forms de movimentacao
    * (sigcdmov e derivados). Este BO apenas consulta - retorna .F. explicitamente
    * para impedir uso indevido em vez de gravar dados inconsistentes.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para incluir registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar - Nao suportado
    * Ver comentario em Inserir(). Consultas/relatorios nao atualizam SigMvCab.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        MsgAviso("Este relat" + CHR(243) + "rio de posi" + CHR(231) + CHR(227) + "o eh somente leitura. " + ;
                "Use os formul" + CHR(225) + "rios de movimenta" + CHR(231) + CHR(227) + "o para alterar registros.", ;
                "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o permitida")
        RETURN .F.
    ENDPROC

    *==========================================================================
    * BuscarEmpresaPorDescricao - Lookup sigcdemp por razas
    * Equivale a fAcessoEmpresa modo D
    * Popula cursor_4c_BuscaEmp com cemps, razas
    * Retorna .T. se encontrou exatamente 1 match
    *==========================================================================
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cemps, razas FROM sigcdemp " + ;
                       "WHERE RTRIM(razas) LIKE " + ;
                       EscaparSQL(RTRIM(par_cDescricao) + "%") + ;
                       " ORDER BY razas"

            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp") > 0
                SELECT cursor_4c_BuscaEmp
                loc_lSucesso = (RECCOUNT() = 1) AND !EOF("cursor_4c_BuscaEmp")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar empresa")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

